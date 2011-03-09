package org.lds.service;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.inject.Inject;
import javax.validation.ConstraintValidator;
import javax.validation.ConstraintValidatorContext;
import javax.validation.ConstraintViolation;
import javax.validation.ConstraintViolationException;
import javax.validation.Validator;

import org.apache.commons.lang.Validate;
import org.lds.model.Example;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.core.simple.SimpleJdbcInsert;
import org.springframework.jdbc.core.simple.SimpleJdbcTemplate;
import org.springframework.jdbc.support.incrementer.DataFieldMaxValueIncrementer;
import org.springframework.jdbc.support.incrementer.OracleSequenceMaxValueIncrementer;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Transactional(readOnly=true)
@Service("exampleService")
public class ExampleServiceImpl implements ExampleService {
	private SimpleJdbcTemplate simpleJdbcTemplate;
	private SimpleJdbcInsert exampleModelJdbcInsert;
	private DataFieldMaxValueIncrementer exampleModelIncrementor;
	private Validator validator;
	
	@Inject
	public ExampleServiceImpl(SimpleJdbcTemplate simpleJdbcTemplate, JdbcTemplate jdbcTemplate, Validator validator) {
		this.simpleJdbcTemplate = simpleJdbcTemplate;
		this.validator = validator;
		this.exampleModelJdbcInsert = new SimpleJdbcInsert(jdbcTemplate)
				.withTableName("EXAMPLE");
		this.exampleModelJdbcInsert.setOverrideIncludeSynonymsDefault(true);
		this.exampleModelIncrementor = new OracleSequenceMaxValueIncrementer(jdbcTemplate.getDataSource(), "SEQ_EXAMPLE_PK");
	}

	/* (non-Javadoc)
	 * @see org.lds.service.ExampleService#createExample(org.lds.model.Example)
	 */
	@Override
	@Transactional
	public Long createExample(Example example) throws ConstraintViolationException {
		Validate.notNull(example, "Example instance must not be null");
		Set<ConstraintViolation<Example>> violations = validator.validate(example);
		
		if(!violations.isEmpty()) {
			throw new ConstraintViolationException(new LinkedHashSet<ConstraintViolation<?>>(violations));
		}
		Map<String, Object> parameters = new HashMap<String, Object>();
		Long id = exampleModelIncrementor.nextLongValue();
		parameters.put("id", id);
		parameters.put("EXAMPLE_NAME", example.getName());
		parameters.put("DATA", example.getData());
		exampleModelJdbcInsert.execute(parameters);
		return id;
	}
	
	/* (non-Javadoc)
	 * @see org.lds.service.ExampleService#getAllExamples()
	 */
	@Override
	public List<Example> getAllExamples() {
		return simpleJdbcTemplate.query("select * from EXAMPLE", new ExampleRowMapper());
	}

	/* (non-Javadoc)
	 * @see org.lds.service.ExampleService#findExample(java.lang.Long)
	 */
	@Override
	public Example findExample(Long id) {
		List<Example> examples = simpleJdbcTemplate.query("select * from EXAMPLE where ID=?", new ExampleRowMapper(), id);
		if(examples.isEmpty()) {
			return null;
		}
		return examples.get(0);
	}
	
	private static class ExampleRowMapper implements RowMapper<Example> {
		@Override
		public Example mapRow(ResultSet rs, int rowNum) throws SQLException {
			Example example = new Example();
			example.setId(rs.getLong("ID"));
			example.setName(rs.getString("EXAMPLE_NAME"));
			example.setData(rs.getString("DATA"));
			return example;
		}
	}
	
	public static class VerifyExampleNameNotDuplicateValidator implements ConstraintValidator<VerifyExampleNameNotDuplicate, String> {

		@Autowired
		private SimpleJdbcTemplate simpleJdbcTemplate;

		@Override
		public void initialize(VerifyExampleNameNotDuplicate constraintAnnotation) {	}
		
		@Override
		public boolean isValid(String value, ConstraintValidatorContext context) {
			return simpleJdbcTemplate.queryForInt("select count(*) from EXAMPLE where EXAMPLE_NAME=?", value) == 0;
		}
		
	}

}
