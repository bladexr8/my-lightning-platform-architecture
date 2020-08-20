public interface IRaceService {

    // interface to support dependency injection of RaceService
    
    Map<Id, List<RaceService.ProvisionalResult>> calculateProvisionalResults(Set<Id> raceIds);

    void applyRaceResults(Map<Id, List<ProvisionalResult>> provisionalResultsByRaceId);

    void awardChampionshipPoints(Set<Id> raceIds);
}
