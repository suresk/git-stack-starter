package org.lds;

import javax.inject.Inject;
import javax.validation.ConstraintViolationException;

import org.apache.commons.lang.RandomStringUtils;
import org.lds.model.Example;
import org.lds.service.ExampleService;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.testng.AbstractTransactionalTestNGSpringContextTests;
import org.testng.Assert;
import org.testng.annotations.Test;

@ContextConfiguration(locations={"classpath*:META-INF/spring/*Context.xml","classpath*:META-INF/spring/*Context-test.xml"})
public class ExampleIT extends AbstractTransactionalTestNGSpringContextTests {

	@Inject
	private ExampleService exampleService;

	@Test
	public void testManageExample() {
		Example example = new Example();
		String name = RandomStringUtils.randomAlphanumeric(10);
		example.setName(name);
		example.setData("SomeTestData");
		Long id = exampleService.createExample(example);
		Assert.assertNotNull(exampleService.findExample(id));
		try {
			exampleService.createExample(example);
		} catch(ConstraintViolationException e) {
			//Success
		}
	}
}
