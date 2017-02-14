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
if [ ! -z "${HOSTNAME_OVERRIDE}" ]; then
    host=${HOSTNAME_OVERRIDE}
fi

mkdir -p $(dirname ${outfile})
docker pull ${IMAGE}
while (true); do
  
  docker run --rm \
    -v /:/rootfs:ro \
    -e ROOTFS=/rootfs \
    -e HOSTNAME_OVERRIDE=${host} \
    ${IMAGE} /export-gce-pd-stats.sh > ${outfile}

  sleep ${interval}
done
