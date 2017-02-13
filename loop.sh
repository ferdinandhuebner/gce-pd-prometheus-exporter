#!/bin/sh

IMAGE=quay.io/ferdi/gce-pd-prometheus-exporter
host=$(hostname)
interval=30
outfile="/tmp/prometheus/gce_pd.prom"
if [ ! -z "${OUTFILE}" ]; then
    outfile=${OUTFILE}
fi
if [ ! -z "${UPDATE_INTERVAL}" ]; then
    interval=${UPDATE_INTERVAL}
fi

mkdir -p $(dirname ${outfile})
docker pull ${IMAGE}
while (true); do
  
  docker run --rm \
    -v /:/rootfs:ro \
    -e ROOTFS=/rootfs \
    ${IMAGE} /export-gce-pd-stats.sh > ${outfile}

  sleep ${interval}
done
