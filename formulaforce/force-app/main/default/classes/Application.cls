public class Application {

    public static final fflib_Application.DomainFactory Domain = 
        new fflib_Application.DomainFactory(
            Application.Selector,
            // Map SObjectType to Domain Class Constructors
            new Map<SObjectType, Type> {
                Race__c.SObjectType => Races.Constructor.class,
                Car__c.SObjectType => Cars.Constructor.class,
                Driver__c.SObjectType => Drivers.Constructor.class
            }
        );

    public Application() {

    }
}
