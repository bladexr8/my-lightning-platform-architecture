public inherited sharing class RaceServiceImpl implements IRaceService {
    
    public Map<Id, List<RaceService.ProvisionalResult>> calculateProvisionalResults(Set<Id> raceIds) {
        throw new RaceService.RaceServiceException('Not implemented');
    }

    public void applyRaceResults(Map<Id, List<RaceService.ProvisionalResult>> provisionalResultsByRaceId) {
        throw new RaceService.RaceServiceException('Not implemented');
    }

    public void awardChampionshipPoints(Set<Id> raceIds) {
        fflib_ISObjectUnitIfWork uow = Application.UnitOfWork.newInstance();

        // Query Races and Contestants and bulkify list of all contestants
        List<Contestant__c> contestants = new List<Contestant__c>();
        for(Race__c race : new RaceSelector().selectByIdWithContestants(raceIds)) {
            contestants.addAll(race.Contestants__r);
        }

        // Delegate to contestant service
        ContestantService.awardChampionshipPoints(uow, contestants);

        // Commit work
        uow.commitWork();
    }

}
