steps to reproduce:

```
source ~/luster/installs/modulefiles/hpc_sdk_243_env.sh # nvidia hpc sdk 24.03
make
./run.sh | grep TL_CUDA
[1712070582.931909] [eos0143:1210996:0]     tl_cuda_lib.c:35   TL_CUDA DEBUG initialized lib object: 0x839c10
[1712070582.932056] [eos0143:1210996:0] tl_cuda_context.c:43   TL_CUDA DEBUG cannot create CUDA TL context without active CUDA context
[1712070582.932758] [eos0143:1210997:0]     tl_cuda_lib.c:35   TL_CUDA DEBUG initialized lib object: 0x66c380
[1712070582.932897] [eos0143:1210997:0] tl_cuda_context.c:43   TL_CUDA DEBUG cannot create CUDA TL context without active CUDA context
[1712070583.619655] [eos0143:1210996:0]     tl_cuda_lib.c:41   TL_CUDA DEBUG finalizing lib object: 0x839c10
[1712070583.620122] [eos0143:1210997:0]     tl_cuda_lib.c:41   TL_CUDA DEBUG finalizing lib object: 0x66c380
```
