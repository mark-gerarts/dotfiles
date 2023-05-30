#!/usr/bin/env bash
set -e

docker build -f Containerfile.base -t distrobox-img-base .

# Since --pull doesn't work with local images, force remove the old ones.
# TODO: check if this is needed.
(distrobox stop spiral && distrobox rm spiral) > /dev/null || true
(distrobox stop helix && distrobox rm helix) > /dev/null || true
docker image rm distrobox-img-personal:latest || true
docker image rm distrobox-img-work:latest || true

docker build -f Containerfile.personal -t distrobox-img-personal .
docker build -f Containerfile.work -t distrobox-img-work .

distrobox create --image distrobox-img-personal:latest --name spiral
distrobox enter spiral -- echo "Spiral set up successfully"

distrobox create --image distrobox-img-work:latest --name helix
distrobox enter helix -- echo "Helix set up successfully"
