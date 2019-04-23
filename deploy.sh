dokcer build -t ateivj/multi-client:latest -t ateivj/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t ateivj/multi-server:latest -t ateivj/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t ateivj/multi-worker:latest -t ateivj/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push ateivj/multi-client:latest
docker push ateivj/multi-server:latest
docker push ateivj/multi-worker:latest
docker push ateivj/multi-client:$SHA
docker push ateivj/multi-server:$SHA
docker push ateivj/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=ateivj/multi-server:$SHA
kubectl set image deployments/client-deployment client=ateivj/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=ateivj/multi-worker:$SHA