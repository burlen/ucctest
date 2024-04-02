


program main
  use mpi
  implicit none
  integer ierr, nProcs, procId, req, recv, msg, cnt, tot, i
  real(4), allocatable ::  sbuf(:), rbuf(:)

  call MPI_Init_thread(MPI_THREAD_MULTIPLE, recv, ierr)

  call MPI_Comm_size(MPI_COMM_WORLD, nProcs, ierr)
  call MPI_Comm_rank(MPI_COMM_WORLD, procId, ierr)

  msg = 32
  cnt = msg / 4
  tot = nProcs*cnt

  write(*,'(I0,A,I0,A,I0)')nProcs,' procs cnt ',cnt,' tot ',tot

  allocate(sbuf(1:tot), rbuf(1:tot))

  !$omp target data map(alloc:sbuf, rbuf)

  !$omp target teams distribute parallel do map(alloc:sbuf)
  do i = 1, tot
    sbuf(i) = procId
  end do

  !$omp target data use_device_ptr(sbuf, rbuf)
  call MPI_Alltoall(sbuf, cnt, MPI_REAL4, rbuf, cnt, MPI_REAL4, MPI_COMM_WORLD, ierr)
  !$omp end target data

  !$omp target update from(rbuf)
  write(*,*) rbuf(:)

  !$omp end target data

  call MPI_Finalize(ierr)


end program
