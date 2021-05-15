docker build -t dheerajmportal/multi-client:latest -t dheerajmportal/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t dheerajmportal/multi-server:latest -t dheerajmportal/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t dheerajmportal/multi-worker:latest -t dheerajmportal/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push dheerajmportal/multi-client:latest
docker push dheerajmportal/multi-server:latest
docker push dheerajmportal/multi-worker:latest

docker push dheerajmportal/multi-client:$SHA
docker push dheerajmportal/multi-server:$SHA
docker push dheerajmportal/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=dheerajmportal/multi-server:$SHA
kubectl set image deployments/client-deployment client=dheerajmportal/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=dheerajmportal/multi-worker:$SHA