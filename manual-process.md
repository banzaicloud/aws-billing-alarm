


**Note:** Make sure you are using the AWS console in the **us-east (north-virginia)** region, as billing
related Cloudwatch data is collected there. The SNS topic should be located there as well.

A small AWS console cheat: if you haven't created any alarms yet, than the console will provide a
wizard which helps you to create exactly a _total estimated charges_ alarm, and the SNS topic with
an email subscription can be created by providing a single email in the dialog. 

But once you already have an alarm, the helper wizard will not be available and you have to perform 2 separate steps:
- create an SNS topic, with an email endpoint
- create a new alarm, and connect it with the SNS topic

First you have to create an **SNS Topic** which will deliver alarms as email:

- Go to [AWS SNS console](https://console.aws.amazon.com/sns/v2/home?region=us-east-1)
- Select **Topics / Create new topic**
- Fill **Topic name** and **Display name** with `EmailMe`
- Click **Create Topic**
- Click on the newly created topic ARN to see the details page
- push **Create Subscription** 
  - Protocol: **Email**
  - Endpoint: **YourEmail@comes.here**

First the subscription will be in _pending state_. Once you click the **Confirm subscription** link
in the email, the subscription will be live. You can even test it with the **Publish to topic**
button.

Now you are ready to create the billing alarm: [AWS CloudWatch User-Guide](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/monitor_estimated_charges_with_cloudwatch.html)

- Go to [AWS Cloudwatch console](https://console.aws.amazon.com/cloudwatch/home?region=us-east-1)
- Navigate to **Alarms / Billing / Create Alarm**
- Select **Total Estimated Charge** from the billing category, click next
- Select **USD**, click next
- Fill _Alarm Threshold_ name and description
- Enter the limit you want to be checked, lets say 1000 USD
- In the **Actions** subsection
  - choose **State is ALARM**
  - choose the previously created SNS: **EmailMe**
- click **Create Alarm**
