public with sharing class ComplianceService {
    /**
     * Provides general support to verify compliance
     * in the application
     * @throws ComplianceException for any failures
     */

    /**
     * Interface used to execute compliance checking
     * logic in each domain class
     */
    public interface ICompliant {
        List<VerifyResult> verifyCompliance();
    }

    /**
     * Results of a compliance verification for 
     * a given record
     */
    public class VerifyResult {
        public Id recordId;
        public String complianceCode;
        public Boolean passed;
        public String failureReason;
    }

    public static void verify(Set<Id> recordIds) {
        // Query the given records and delegate to the
        // corresponding Domain class to check
        // compliance and report failures
        // via ComplianceException

        // Dynamically create Domain instance for these records
        fflib_ISObjectDomain domain = Application.Domain.newInstance(recordIds);
        if (domain instanceof ICompliant) {
            // Ask the domain class to verify its compliance
            ICompliant compliantDomain = (ICompliant) domain;
            List<VerifyResult> verifyResults = compliantDomain.verifyCompliance();
            if (verifyResults != null) {
                // Check for failed compliances
                List<VerifyResult> failedCompliances = new List<VerifyResult>();
                for (VerifyResult verifyResult : verifyResults) {
                    if (!verifyResult.passed) {
                        failedCompliances.add(verifyResult);
                    }
                }
                if (failedCompliances.size() > 0) {
                    throw new ComplianceException('Compliance failures found.', failedCompliances);
                    return;
                }
            }
            throw new ComplianceException('Unable to verify compliance', null);
        }
    }
    
    public ComplianceService() {
        // Constructor
    }
}