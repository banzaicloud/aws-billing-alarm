CF_TEMPLATE_BUCKET=lp-lambda-go

upload:
	aws s3 cp billing-alarm.yml \
	    s3://$(CF_TEMPLATE_BUCKET) \
	    --acl public-read


