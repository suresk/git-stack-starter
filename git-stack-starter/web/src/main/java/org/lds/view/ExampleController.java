package org.lds.view;

import java.util.Locale;

import javax.validation.ConstraintViolationException;
import javax.validation.Valid;

import org.lds.model.Example;
import org.lds.service.ExampleService;
import org.lds.stack.web.spring.utils.BeanValidationUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.Errors;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class ExampleController {
	private ExampleService exampleService;
	
	@Autowired
	public ExampleController(ExampleService exampleService) {
		this.exampleService = exampleService;
	}
	
	@RequestMapping(value="/example",method=RequestMethod.GET)
	public String list(@ModelAttribute Example example, Model model) {
		model.addAttribute("examples", exampleService.getAllExamples());
		return "example/manageExample";
	}
	
	@RequestMapping(value="/example", method=RequestMethod.POST)
	public String create(@ModelAttribute @Valid Example example, Errors errors, Model model, Locale locale) {
		if(errors.hasErrors()) {
			return list(example, model);
		}
		try {
			exampleService.createExample(example);
		} catch(ConstraintViolationException e) {
			BeanValidationUtils.addContraintViolations(errors, e.getConstraintViolations());
			return list(example, model);
		}
		model.addAttribute("flash:msg", "created");
		return "redirect:example";
	}
}