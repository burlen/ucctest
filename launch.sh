#!/bin/bash

#set -x

world_rank=${OMPI_COMM_WORLD_RANK}
node_rank=${OMPI_COMM_WORLD_LOCAL_RANK}
eos_node_nics=( mlx5_0:1 mlx5_3:1 mlx5_4:1 mlx5_5:1 mlx5_6:1 mlx5_9:1 mlx5_10:1 mlx5_11:1 )
eos_node_gpus=( 0 1 2 3 4 5 6 7 )

export CUDA_VISIBLE_DEVICES=${eos_node_gpus[${node_rank}]}
export UCX_NET_DEVICES=${eos_node_nics[${node_rank}]}
export UCX_TLS=sm,rc,cuda_ipc,cuda_copy,gdr_copy
export UCX_IB_SL=1

#export UCX_LOG_LEVEL=info
export UCC_LOG_LEVEL=trace

$*
