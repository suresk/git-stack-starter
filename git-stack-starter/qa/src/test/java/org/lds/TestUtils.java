package org.lds;

import static org.testng.AssertJUnit.assertTrue;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.lds.settings.Constants;

public class TestUtils {

	public static void doLogin(WebDriver driver) {
		assertTrue("should be on the selectUser page", driver.getCurrentUrl().contains(Constants.ssoLoginPage));
		driver.findElement(By.linkText(Constants.defaultSsoUser)).click();
	}
	
}