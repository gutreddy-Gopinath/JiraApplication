global class ScheduledFlow1HourEmailNotification implements Schedulable {

   global void execute(SchedulableContext sc) {

       Map<String, Id> params = new Map<String, Id> ();

       		Flow.Interview kycScoringFlow = Flow.Interview.createInterview('Meeting_Invite_Reminder_Email_Notification_1Hour',params );

			kycScoringFlow.start();

   }

}