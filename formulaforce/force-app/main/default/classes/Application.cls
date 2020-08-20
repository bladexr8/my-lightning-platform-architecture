public class Application {

    /* public static final fflib_Application.DomainFactory Domain = 
        new fflib_Application.DomainFactory(
            Application.Selector,
            // Map SObjectType to Domain Class Constructors
            new Map<SObjectType, Type> {
                Race__c.SObjectType => Races.Constructor.class,
                Car__c.SObjectType => Cars.Constructor.class,
                Driver__c.SObjectType => Drivers.Constructor.class
            }
        ); */

    // Configure and create the UnitOfWorkFactory for this Application
    public static final fflib_Application.UnitOfWorkFactory UnitOfWork = 
     new fflib_Application.UnitOfWorkFactory(
        new List<SObjectType> {
            Driver__c.SObjectType,
            Season__c.SObjectType,
            Race__c.SObjectType,
            Contestant__c.SObjectType
        }
    );

    // Configure and create the ServiceFactory for this application
    public static final fflib_Application.ServiceFactory Service = 
     new Application.ServiceFactory(
         new Map<Type, Type> {
             IRaceService.class => RaceServiceImpl.class
         }
     );

     // Configure and create the SelectorFactory for this Application
     public static final fflib_Application.SelectorFactory Selector = 
      new fflib_Application.SelectorFactory(
          new Map<SObjectType, Type> {
              // Opportunity.SObjectType => OpportunitiesSelector.class
          }
      );

      // Customised Service Factory to support developer overrides via Custom Metadata (chapter 5)
      private class ServiceFactory extends fflib_Application.ServiceFactory {
          private Map<String, String> servicesByClassName = new Map<String, String>();

          public ServiceFactory(Map<Type, Type> serviceInterfaceTypeByServiceImplType) {
              super(serviceInterfaceTypeByServiceImplType);

              // Map of overriden services defined by developer in this org
              for(Service__mdt serviceOverride : [select DeveloperName, NamespacePrefix, ApexClass__c from Service__mdt]) {
                  servicesByClassName.put(
                      serviceOverride.NamespacePrefix + '.' + serviceOverride.DeveloperName,
                      serviceOverride.ApexClass__c
                  );
              }
          }

          public override Object newInstance(Type serviceInterfaceType) {
              // Has developer overridden Service Implementation in this org?
              if (!Test.isRunningTest() && servicesByClassName.containsKey(serviceInterfaceType.getName())) {
                  String overriddenServiceImpl = servicesByClassName.get(serviceInterfaceType.getName());
                  return Type.forName(overriddenServiceImpl).newInstance();
              }

              // Default Service Factory returns mocked or registered default implementation
              return super.newInstance(serviceInterfaceType);
          }
      }

      /** Utility method to throw Application exceptions to Lightning Components */
      public static void throwAuraHandledException(Exception e) {
          String message = e.getMessage();
          AuraHandledException error = new AuraHandledException(message);
          error.setMessage(message);    // ensure Apex tests can assert the error message value
          throw error;
      }
}
