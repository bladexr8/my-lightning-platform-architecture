public with sharing class RaceService 
{
	public static void awardChampionshipPoints(Set<Id> raceIds)
	{
		// Mark the start of the database
		System.Savepoint serviceSavePoint = Database.setSavePoint();
		try {
			ContestantService.awardChampionshipPoints(null);
		} catch (Exception e) {
			// Rollback any data written before the exception
			Database.rollback(serviceSavePoint);
			// Pass the excpetion on for the caller to handle
			throw e;
		}
	}

	public static Map<Id, List<ProvisionalResult>> calculateProvisionalResults(Set<Id> raceIds) {
		// Implementation
		return null;
	}

	public static void applyRaceResults(Map<Id, List<ProvisionalResult>> provisionalResultsByRaceId) {
		// implementation
	}

	// inner class
	public class ProvisionalResult {
		public Integer racePosition { get; set; }
		public Id contestantId { get; set; }
		// can't be set by caller, but can be returned
		public String contestName { get; private set; }
	}
}