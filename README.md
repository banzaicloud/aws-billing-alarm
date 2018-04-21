
Creating an AWS billing alarm is pretty straightforward, and you should really use it. You can avoid
"surprise bills" at the end of the month. 

For further details reads this [post](https://banzaicloud.com/blog/slackbot/).

## Billing Alert

For simple cost management, aws can automagically email if aws bills exceed a limit. 
Instead the [manual procees](manual-process.md) of creating resources, use the provided
CloudFormation template.

- Start the Create Stack on AWS console: [![Launch Stack](https://cdn.rawgit.com/buildkite/cloudformation-launch-stack-button-svg/master/launch-stack.svg)](https://console.aws.amazon.com/cloudformation/home?region=us-east-1#/stacks/new?stackName=billingAlarm&templateURL=https://s3-eu-west-1.amazonaws.com/lp-lambda-go/billing-alarm.yml)
- On the _Select Template_ page click **Next**
- On the _Specify Details_ page fill the **Email** and **Spending Limit** fields, than click **Next**
- On the _Options_ page click **Next**
- On _Review_ page click **Create**

You will receive an email from : `AWS Notifications <no-reply@sns.amazonaws.com>`:
- Click on the **Confirm subscription** link

### aws cli

If you prefer the terminal way:
```
export BILLING_ALARM_EMAIL=youremail@gmail.com
export BILLING_ALARM_LIMIT=123


aws cloudformation create-stack \
  --template-url https://s3-eu-west-1.amazonaws.com/lp-lambda-go/billing-alarm.yml \
  --region us-east-1 \
  --stack-name billing-alarm \
  --capabilities CAPABILITY_IAM \
  --tags Key=alarm,Value=billing \
  --parameters \
      ParameterKey=BillingAlertEmailParameter,ParameterValue=${BILLING_ALARM_EMAIL} \
      ParameterKey=MonthlySpendLimitParameter,ParameterValue=${BILLING_ALARM_LIMIT} \
      ParameterKey=AlarmEvaluationPeriod,ParameterValue=one-hour 

```

## Manual process on AWS console

If you want to manually do the steps on the AWS console follow this [description](manual-process.md)
