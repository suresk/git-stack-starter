package org.lds.service;

import java.util.List;

import javax.validation.ConstraintViolationException;

import org.lds.model.Example;

/**
 * A Sample Service Interface
 */
public interface ExampleService {

	/**
	 * Persists an instance of ExampleEntity in the Database.
	 * @param example
	 */
	public Long createExample(Example example) throws ConstraintViolationException;

	/**
	 * Returns all ExampleModels in the database.
	 * @return
	 */
	public List<Example> getAllExamples();
	
	/**
	 * Find a ExampleModel given a primary key
	 * @param id
	 * @return a ExampleModel instance or null if none found.
	 */
	public Example findExample(Long id);
}