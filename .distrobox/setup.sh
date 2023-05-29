#!/usr/bin/env bash
set -e

docker build -f Containerfile.base -t distrobox-img-base .
docker build -f Containerfile.personal -t distrobox-img-personal .
docker build -f Containerfile.work -t distrobox-img-work .

(distrobox stop spiral && distrobox rm spiral) > /dev/null || true
(distrobox stop helix && distrobox rm helix) > /dev/null || true

distrobox create --image distrobox-img-personal --name spiral
distrobox create --image distrobox-img-work --name helix

distrobox enter spiral -- echo "Spiral set up successfully"
distrobox enter helix -- echo "Helix set up successfully"
