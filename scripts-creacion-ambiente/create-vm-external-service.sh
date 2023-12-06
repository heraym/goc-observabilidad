gcloud compute instances create external-service \
  --image-project=debian-cloud \
  --image-family=debian-10 \
  --zone=us-central1-a \
  --network=vpc-goc \
  --tags=http-server \
  --metadata=startup-script='#! /bin/bash
  apt update
  apt -y install apache2
  cat <<EOF > /var/www/html/index.html
  <html><body><p>Linux startup script added directly.</p></body></html>
  EOF'
