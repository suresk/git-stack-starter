package org.lds.settings;

import org.lds.stack.qa.TestConfig;
import org.lds.stack.qa.annotations.TestConfigProperty;

@TestConfigProperty
public class Constants {

    static { new TestConfig(); }
    
    public static int defaultWaitTime;
    
    public static String homeUrl;
    
    public static String exampleUrl;
	
	public static String defaultSsoUser;
	public static String ssoLoginPage;
	public static String authenticationUrl;
    
}
