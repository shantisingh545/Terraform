docker build -t eks-nginx .
||

aws ecr get-login-password --region us-east-1 \
| docker login --username AWS --password-stdin <ACCOUNT_ID>.dkr.ecr.us-east-1.amazonaws.com
||

docker tag eks-nginx:latest <ECR_URL>:latest
||

docker push <ECR_URL>:latest
||

kubectl get svc
||

nginx-service   LoadBalancer   a1b2c3d4.elb.amazonaws.com

||

http://a1b2c3d4.elb.amazonaws.com
