@isTest
public class AnimalLocatorTest {
    @isTest
    static void testGetAnimalNameById() {
        // Mock HTTP response
        Test.setMock(HttpCalloutMock.class, new AnimalLocatorMock());
        
        // Call the method to test
        String animalName = AnimalLocator.getAnimalNameById(1);
        
        // Verify the result
        System.assertEquals('Tiger', animalName);
    }


}