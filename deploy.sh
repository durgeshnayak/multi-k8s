docker build -t durgeshnayak/multi-client:latest -t durgeshnayak/multi-client:$GIT_SHA -f ./client/Dockerfile ./client
docker build -t durgeshnayak/multi-server:latest -t durgeshnayak/multi-server:$GIT_SHA -f ./server/Dockerfile ./server
docker build -t durgeshnayak/multi-worker:latest -t durgeshnayak/multi-worker:$GIT_SHA -f ./worker/Dockerfile ./worker

docker push durgeshnayak/multi-client:latest
docker push durgeshnayak/multi-client:$GIT_SHA
docker push durgeshnayak/multi-server:latest
docker push durgeshnayak/multi-server:$GIT_SHA
docker push durgeshnayak/multi-worker:latest
docker push durgeshnayak/multi-worker:$GIT_SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=durgeshnayak/multi-client:$GIT_SHA
kubectl set image deployments/server-deployment server=durgeshnayak/multi-server:$GIT_SHA
kubectl set image deployments/worker-deployment worker=durgeshnayak/multi-worker:$GIT_SHA

