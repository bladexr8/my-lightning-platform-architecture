public inherited sharing class Drivers extends ApplicationDomain
    implements ComplianceService.ICompliant {

    public List<ComplianceService.VerifyResult> verifyCompliance() {
        List<ComplianceService.VerifyResult> compliances = new List<ComplianceService.VerifyResult>();
        for (Driver__c driver : (List<Driver__c>) Records) {
            ComplianceService.VerifyResult license = new Compliance.VerifyResult();
            license.ComplianceCode = '4.1';
            license.RecordId = driver.Id;
            license.passed = driver.FIASuperLicense__c;
            license.failureReason = license.passed ? null : 'Driver must have an FIA Super License.';
            compliances.add(license);
        }
        return compliances;
    }

    public Drivers() {

    }
}
