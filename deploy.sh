docker build -t freulein/multi-client:latest -t freulein/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t freulein/multi-server:latest -t freulein/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t freulein/multi-worker:latest -t freulein/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push freulein/multi-client:latest
docker push freulein/multi-worker:latest
docker push freulein/multi-server:latest

docker push freulein/multi-client:$SHA
docker push freulein/multi-worker:$SHA
docker push freulein/multi-server:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=freulein/multi-server:$SHA
kubectl set image deployments/client-deployment client=freulein/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=freulein/multi-worker:$SHA
