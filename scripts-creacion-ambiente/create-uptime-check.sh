export PROJECT_ID=`gcloud config list --format="value(core.project)"`
export PROJECT_NUMBER=$(gcloud projects describe $PROJECT_ID --format='get(projectNumber)')
gcloud projects add-iam-policy-binding $PROJECT_ID \
--member='serviceAccount:service-'$PROJECT_NUMBER'@gcp-sa-monitoring-notification.iam.gserviceaccount.com' \
--role='roles/servicedirectory.viewer'

gcloud projects add-iam-policy-binding $PROJECT_ID \
--member='serviceAccount:service-'$PROJECT_NUMBER'@gcp-sa-monitoring-notification.iam.gserviceaccount.com' \
--role='roles/servicedirectory.pscAuthorizedService'

gcloud compute firewall-rules create PRIVATE_CHECK_NETWORK_HOPE_RULE \
--network="vpc-demos"  \
--action=allow   --direction=ingress   --source-ranges="35.199.192.0/19" \
--rules=tcp   --project="$PROJECT_ID"

 export TOKEN=`gcloud auth print-access-token`
 curl https://monitoring.googleapis.com/v3/projects/${PROJECT_ID}/uptimeCheckConfigs \
-H "Authorization: Bearer $TOKEN" -H "Content-Type: application/json" \
--request POST --data '{
"displayName": "private-check-demo",
"monitoredResource": {
  "type": "servicedirectory_service",
  "labels": {
    "project_id": "'"$PROJECT_ID"'",
    "service_name": "hackathon-service-1",
    "namespace_name": "hackathon-namespace",
    "location": "us-central1"
  }
},
"httpCheck": {
  "requestMethod": "GET"
},
"period": "60s",
"timeout": "10s",
"checker_type": "VPC_CHECKERS"
}'
