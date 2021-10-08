build:
	docker build -t prod/eramba -f Dockerfile .
	docker tag prod/eramba 623976975596.dkr.ecr.us-east-1.amazonaws.com/prod/eramba

push: build
	docker push 623976975596.dkr.ecr.us-east-1.amazonaws.com/prod/eramba

refresh: build push
	aws ecs update-service --cluster infra --service security-eramba-service --force-new-deployment | jq .