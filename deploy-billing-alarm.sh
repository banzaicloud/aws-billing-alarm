#!/usr/bin/env bash
set -eo pipefail

debug() {                      
  [[ "$DEBUG" ]] && echo "-----> $*" 1>&2                      
} 

usage() {
    cat 1>&2 << EOF
=============================================
An AWS Billing Alarm will be created via a
CloudFormation Template. Please answer:
=============================================
EOF
}

main() {
    usage
    read -p "email address, for billing alarm: " BillingAlertEmailParameter
    read -p "amount of USD you want tu use as billing alarm: " MonthlySpendLimitParameter

    : ${BillingAlertEmailParameter:? required}
    : ${MonthlySpendLimitParameter:? required}

    aws cloudformation create-stack \
	--template-url https://s3-eu-west-1.amazonaws.com/lp-lambda-go/billing-alarm.yml \
	--region us-east-1 \
	--stack-name billing-alarm \
        --capabilities CAPABILITY_IAM \
        --tags Key=alarm,Value=billing \
        --parameters \
            ParameterKey=BillingAlertEmailParameter,ParameterValue=${BillingAlertEmailParameter} \
            ParameterKey=MonthlySpendLimitParameter,ParameterValue=${MonthlySpendLimitParameter} \
            ParameterKey=AlarmEvaluationPeriod,ParameterValue=one-hour 
}

main "$@"
