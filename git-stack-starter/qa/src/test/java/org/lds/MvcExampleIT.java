package org.lds;

import static org.testng.AssertJUnit.assertEquals;
import static org.testng.AssertJUnit.assertTrue;

import java.util.ArrayList;
import java.util.concurrent.TimeUnit;

import org.apache.commons.lang.RandomStringUtils;
import org.lds.settings.Constants;
import org.openqa.selenium.By;
import org.openqa.selenium.RenderedWebElement;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.firefox.FirefoxDriver;
import org.testng.annotations.AfterMethod;
import org.testng.annotations.BeforeMethod;
import org.testng.annotations.Test;


public class MvcExampleIT {

	private WebDriver driver;

	@BeforeMethod(alwaysRun=true)
	public void init() {
		driver = new FirefoxDriver();
		driver.manage().timeouts().implicitlyWait(Constants.defaultWaitTime, TimeUnit.SECONDS);
	}
	
	@AfterMethod(alwaysRun=true)
	public void destroy() {
		driver.close();
	}
	
	@Test(groups={ "smoke" }, enabled=true)
	public void testManageExamplesNavigation() {
		navigateToExample();
		assertEquals("should be on the manage examples page", Constants.exampleUrl, driver.getCurrentUrl());
	}

	@Test(enabled=true) 
	public void testAddExample() {
		navigateToExample();
		String randomName = RandomStringUtils.randomAlphanumeric(10);
		String randomData = RandomStringUtils.randomAlphanumeric(10);
		driver.findElement(By.id("name")).sendKeys(randomName);
		driver.findElement(By.id("data")).sendKeys(randomData);
		driver.findElement(By.id("createExample")).click();
		
		RenderedWebElement gridData = (RenderedWebElement) driver.findElement(By.id("exampleModelsGrid"));
		ArrayList<WebElement> gridElements = (ArrayList<WebElement>) gridData.findElements(By.tagName("tr"));
		
		String newRow = randomName + " " + randomData;
		assertTrue("name and data row should be in table", verifyStringInTableData(gridElements, newRow));
	}
	
	private void navigateToExample() {
		driver.get(Constants.homeUrl);
		TestUtils.doLogin(driver);
		driver.findElement(By.linkText("Manage Examples")).click();
	}
	
	
	private boolean verifyStringInTableData(ArrayList<WebElement> table, String verifyStr) {
		boolean found = false;			

		for(WebElement element : table) {
			if(element.getText().equals(verifyStr)) {
				found = true;
			}				
		}
		return found;
	}
		
}
