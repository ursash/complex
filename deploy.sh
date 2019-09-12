docker build -t ursash/multi-client:latest -t ursash/multi-client:$SHA  -f ./client/Dockerfile ./client
docker build -t ursash/multi-server:latest -t ursash/multi-server:$SHA  -f ./server/Dockerfile ./server
docker build -t ursash/multi-worker:latest -t ursash/multi-worker:$SHA  -f ./worker/Dockerfile ./worker

docker push ursash/multi-client:latest
docker push ursash/multi-server:latest
docker push ursash/multi-worker:latest

docker push ursash/multi-client:$SHA
docker push ursash/multi-server:$SHA
docker push ursash/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=ursash/multi-server:$SHA
kubectl set image deployments/client-deployment client=ursash/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=ursash/multi-worker:$SHA