#!/bin/bash

exec=./a.out

ucc=1
hcoll=0

gpus_per_node=8
cores_per_socket=56
sockets_per_node=2
n_ranks=2

ranks_per_socket=$(( n_ranks / sockets_per_node ))
ranks_per_socket=$(( ranks_per_socket==0 ? 1 : ranks_per_socket ))
cores_per_rank=$(( cores_per_socket / ranks_per_socket ))

# set OpenMP thread affinity, use --report-bindings to show processor affinity
export OMP_NUM_THREADS=${cores_per_rank} OMP_PROC_BIND=true

# for OpenMPI 5 use "package", for older OpenMPI use "socket"
bind_opts="--map-by ppr:${ranks_per_socket}:socket:PE=${cores_per_rank} --bind-to core"
#bind_opts="--map-by ppr:${ranks_per_socket}:package:PE=${cores_per_rank} --bind-to core"

ucx_opts="--mca pml ucx --mca osc ucx --mca spml ucx"
ucx_opts="${ucx_opts} --mca coll_ucc_enable ${ucc} --mca coll_ucc_priority 100"
ucx_opts="${ucx_opts} --mca coll_hcoll_enable ${hcoll}"

mpirun -n ${n_ranks} ${ucx_opts} ${bind_opts} ./launch.sh ${exec}
