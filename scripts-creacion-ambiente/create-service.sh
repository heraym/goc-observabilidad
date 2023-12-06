export PROJECT_ID=`gcloud config list --format="value(core.project)"`
 export PROJECT_NUMBER=$(gcloud projects describe $PROJECT_ID --format='get(projectNumber)')
 gcloud services enable monitoring --project=$PROJECT_ID
 gcloud services enable servicedirectory --project=$PROJECT_ID
 gcloud service-directory namespaces create hackathon-namespace --location=us-central1
 gcloud service-directory services create hackathon-service-1 \
--namespace hackathon-namespace --location=us-central1

export INTERNAL_IP=$(gcloud compute instances describe --zone=us-central1-a \
vm-hackathon-srv-1 --format='get(networkInterfaces[0].networkIP)')
 
 gcloud service-directory endpoints create hackathon-endpoint-1 \
haymard@cloudshell:~/hackathon/observabilidad (projectodemos)$ vi create-service-1.sh 
haymard@cloudshell:~/hackathon/observabilidad (projectodemos)$ more create-service-1.sh 
 export PROJECT_ID=`gcloud config list --format="value(core.project)"`
 export PROJECT_NUMBER=$(gcloud projects describe $PROJECT_ID --format='get(projectNumber)')
 gcloud services enable monitoring --project=$PROJECT_ID
 gcloud services enable servicedirectory --project=$PROJECT_ID
 gcloud service-directory namespaces create goc-namespace --location=us-central1
 gcloud service-directory services create goc-external-service \
--namespace goc-namespace --location=us-central1

export INTERNAL_IP=$(gcloud compute instances describe --zone=us-central1-a \
external-service --format='get(networkInterfaces[0].networkIP)')
 
 gcloud service-directory endpoints create goc-es-endpoint \
--location=us-central1 --namespace=goc-namespace \
--service=goc-external-service \
--network=projects/$PROJECT_NUMBER/locations/global/networks/vpc-goc \
--address=$INTERNAL_IP --port=80
