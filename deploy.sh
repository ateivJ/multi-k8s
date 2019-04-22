dokcer build -t ateivJ/multi-client:latest -t ateivJ/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t ateivJ/multi-server:latest -t ateivJ/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t ateivJ/multi-worker:latest -t ateivJ/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push ateivJ/multi-client:latest
docker push ateivJ/multi-server:latest
docker push ateivJ/multi-worker:latest
docker push ateivJ/multi-client:$SHA
docker push ateivJ/multi-server:$SHA
docker push ateivJ/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=ateivJ/multi-server:$SHA
kubectl set image deployments/client-deployment client=ateivJ/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=ateivJ/multi-worker:$SHA