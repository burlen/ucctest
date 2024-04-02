#include <mpi.h>
#include <stdlib.h>
#include <stdio.h>
int main(int argc, char** argv) {
  int ierr, nProcs, procId, recv, cnt, tot, i;
  float *sbuf, *rbuf;

  MPI_Init_thread(&argc, &argv, MPI_THREAD_MULTIPLE, &recv);

  MPI_Comm_size(MPI_COMM_WORLD, &nProcs);
  MPI_Comm_rank(MPI_COMM_WORLD, &procId);

  cnt = 8;
  tot = nProcs*cnt;

  printf("%d procs cnt %d tot %d\n", nProcs, cnt, tot);

  sbuf = (float*)malloc(tot*sizeof(float));
  rbuf = (float*)malloc(tot*sizeof(float));
  #pragma omp target data map(alloc:sbuf[0:tot], rbuf[0:tot])
  {

  #pragma omp target teams distribute parallel for map(alloc:sbuf[0:tot]) map(to:procId)
  for (i = 0; i < tot; ++i) {
    sbuf[i] = procId;
  }

  #pragma omp target data use_device_ptr(sbuf, rbuf)
  {
  ierr = MPI_Alltoall(sbuf, cnt, MPI_FLOAT, rbuf, cnt, MPI_FLOAT, MPI_COMM_WORLD);
  }

  #pragma omp target update from(rbuf[0:tot])
  for (i = 0; i < tot; ++i)
    printf("%g, ", rbuf[i]);
  printf("\n");

  }
  MPI_Finalize();
  return 0;
}
