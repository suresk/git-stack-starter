package org.lds.service;

import java.lang.annotation.Documented;
import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

import javax.validation.Constraint;
import javax.validation.Payload;

@Target( { ElementType.METHOD, ElementType.FIELD})
@Retention(RetentionPolicy.RUNTIME)
@Constraint(validatedBy = ExampleServiceImpl.VerifyExampleNameNotDuplicateValidator.class)
@Documented
public @interface VerifyExampleNameNotDuplicate {
	String message() default "{manageExample.duplicatename}";
	
	Class<?>[] groups() default {};
	
	Class<? extends Payload>[] payload() default {};
}