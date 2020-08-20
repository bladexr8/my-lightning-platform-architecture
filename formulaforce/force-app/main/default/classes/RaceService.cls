public with sharing class RaceService 
{
	/* public static void awardChampionshipPoints(Set<Id> raceIds)
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
	} */

	
	public static Map<Id, List<ProvisionalResult>> calculateProvisionalResults(Set<Id> raceIds) {
		return service().calculateProvisionalResults(raceIds);
	}

	public static void applyRaceResults(Map<Id, List<ProvisionalResult>> provisionalResultsByRaceId) {
		service().applyRaceResults(provisionalResultsByRaceId);
	}

	public static void awardChampionshipPoints(Set<Id> raceIds) {
		service().awardChampionshipPoints(raceIds);
	}

	// instantiate Implemented class for Race Service
	private static IRaceService service() {
		return (IRaceService) Application.Service.newInstance(IRaceService.class);
	}

	public class RaceServiceException extends Exception {} 	


	// inner class
	public class ProvisionalResult {
		public Integer racePosition { get; set; }
		public Id contestantId { get; set; }
		// can't be set by caller, but can be returned
		public String contestantName { get; set; }
	}
}