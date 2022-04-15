docker build -t argahv/multi-client:latest -t argahv/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t argahv/multi-server:lastet -t argahv/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t argahv/multi-worker:latest -t argahv/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push argahv/multi-client:latest
docker push argahv/multi-server:latest
docker push argahv/multi-worker:latest

docker push argahv/multi-client:$SHA
docker push argahv/multi-server:$SHA
docker push argahv/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=argahv/multi-server:$SHA
kubectl set image deployments/client-deployment client=argahv/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=argahv/multi-worker:$SHA