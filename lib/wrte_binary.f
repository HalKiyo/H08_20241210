cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
c Copyright (c) 2023 Dr. Naota HANASAKI, NIES
c
c Licensed under the Apache License, Version 2.0 (the "License");
c   You may not use this file except in compliance with the License.
c   You may obtain a copy of the License at:
c
c     http://www.apache.org/licenses/LICENSE-2.0
c
c Unless required by applicable law or agreed to in writing, software
c distributed under the License is distributed on an "AS IS" BASIS,
c WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND,
c either express or implied.
c See the License for the specific language governing permissions and
c limitations under the License.
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
      subroutine wrte_binary(
     $     n0l,
     $     r1dat,
     $     c0ofname)
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cto   write binary array
cby   2010/03/31, hanasaki, NIES: H08 ver1.0
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
      implicit none
c parameter (array)
      integer           n0l
c parameter (default)
      integer           n0of
      parameter        (n0of=16)
c index (array)
      integer           i0l
c in
      real              r1dat(n0l)
c out
      character*128     c0ofname
      
      logical           lexist

c debug
      integer           ios
      integer*8         file_size
      character*160     err_msg

      write(*,*) 'DEBUG c0fname', c0ofname
      write(*,*) 'DEBUG n0l', n0l
      write(*,*) 'DEBUG recl', n0l*4
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
c Write binary
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
      inquire(file=c0ofname, exist=lexist)
      if (lexist) then
        open(unit=99, file=c0ofname, status='old')
        close(99, status='delete')
      end if

      open(unit=n0of, file=c0ofname, access='direct', recl=n0l*4)
      inquire(file=c0ofname, size=file_size, iostat=ios)
      if (ios .eq. 0) then
         write(*,*) 'After OPEN: File size =', file_size, 'bytes'
      else
         write(*,*) 'After OPEN: Size unknown'
      end if

      write(n0of,rec=1)(r1dat(i0l),i0l=1,n0l)
      inquire(file=c0ofname, size=file_size, iostat=ios)
      if (ios .eq. 0) then
         write(*,*) 'After WRITE: File size =', file_size, 'bytes'
      else
         write(*,*) 'After WRITE: Size unknown'
      end if
 
      close(n0of)
c
      end
