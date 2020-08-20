public with sharing class ContestantService {

	// inner class
	public class RaceRetirement {
		public Id contestantId;
		public String reason;
	}

	// custom Exception
	public class ContestantServiceException extends Exception {}

	// process retirement
	public static void retireFromRace(List<RaceRetirement> retirements) {
		// Process race retirements
		throw new ContestantServiceException('Not implemented');
	}

	/***************************
	 * POINTS AWARDED FOR RACES
	 * *************************/

	public static void awardChampionshipPoints(Set<Id> contestantIds)
	{
		System.debug(LoggingLevel.INFO, '*** Awarding Championship Points ***');

		// Apply championship points to selected contestants
		fflib_ISObjectUnitOfWork uow = Application.UnitOfWork.newInstance();
		// call overloaded method
		awardChampionshipPoints(uow, new ContestantsSelector().selectById(contestantIds));
		uow.commitWork();
	}

	public static void awardChampionshipPoints(fflib_ISObjectUnitOfWork uow, List<Contestant__c> contestants) {

		// Apply championship points to given contestants
		Map<Integer, ChampionshipPoint__mdt> pointsByTrackPosition = 
		 new ChampionshipPointsSelector().selectAllByTrackPosition();
		for (Contestant__c contestant : contestants) {
			// Determine points to award for the given position
			ChampionshipPoint__mdt pointsForPosition = pointsByTrackPosition.get(Integer.valueOf(contestant.RacePosition__c));
			if (pointsForPosition != null) {
				// apply points and register for update with uow
				contestant.ChampionshipPoints__c =pointsForPosition.PointsAwarded__c;
				uow.registerDirty(contestant);
			}
		}
	}
}