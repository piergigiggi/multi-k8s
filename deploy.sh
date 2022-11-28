docker build -t piergiggisc/multi-client:latest -t piergiggisc/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t piergiggisc/multi-server:latest -t piergiggisc/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t piergiggisc/multi-worker:latest -t piergiggisc/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push piergiggisc/multi-client:latest
docker push piergiggisc/multi-server:latest
docker push piergiggisc/multi-worker:latest

docker push piergiggisc/multi-client:$SHA
docker push piergiggisc/multi-server:$SHA
docker push piergiggisc/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=piergiggisc/multi-server:$SHA
kubectl set image deployments/client-deployment client=piergiggisc/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=piergiggisc/multi-worker:$SHA