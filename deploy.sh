docker build -t mudaledocker/multi-client:latest -t mudaledocker/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t mudaledocker/multi-server:latest -t mudaledocker/multi-server:$SHA  -f ./server/Dockerfile ./server
docker build -t mudaledocker/multi-worker:latest -t mudaledocker/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push mudaledocker/multi-client:latest
docker push mudaledocker/multi-server:latest
docker push mudaledocker/multi-worker:latest

docker push mudaledocker/multi-client:$SHA
docker push mudaledocker/multi-server:$SHA
docker push mudaledocker/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=mudaledocker/multi-server:$SHA
kubectl set image deployments/client-deployment client=mudaledocker/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=mudaledocker/multi-worker:$SHA
