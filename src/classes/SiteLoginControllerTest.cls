/**
 * An apex page controller that exposes the site login functionality
 */
@IsTest global with sharing class SiteLoginControllerTest {
    @IsTest(SeeAllData=true) global static void testSiteLoginController () {
        // Instantiate a new controller with all parameters in the page
        SiteLoginController controller = new SiteLoginController ();
        controller.username = 'doctor@revature.com';
        controller.password = 'Abubba25!!'; 
                
        System.assertEquals(controller.login(),null);                           
    }    
}