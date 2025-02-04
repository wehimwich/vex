*
* Copyright (c) 2020 NVI, Inc.
*
* This file is part of VLBI Field System
* (see http://github.com/nvi-inc/fs).
*
* This program is free software: you can redistribute it and/or modify
* it under the terms of the GNU General Public License as published by
* the Free Software Foundation, either version 3 of the License, or
* (at your option) any later version.
*
* This program is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
* GNU General Public License for more details.
*
* You should have received a copy of the GNU General Public License
* along with this program. If not, see <http://www.gnu.org/licenses/>.
*
      program t
      implicit none
      character*129 buffer,mode,units,scanid
      integer ierr,vex,lenn,i, iarray(4),int,j
      double precision double, seconds
c
      integer ptr_ch,fvex_open,fvex_len,fvex_field,fvex_units
      integer fget_station_def,fget_mode_def,fget_source_def
      integer fget_all_lowl,fget_mode_lowl,fget_station_lowl
      integer fget_global_lowl,fget_source_lowl,fget_scan_station
      integer fvex_scan_source
      integer fvex_double,fvex_date,fvex_int,fvex_ra,fvex_dec
      integer fvex_scan_source2, fget_vex_rev, fvex_scan_intent
      integer fvex_scan_pointing_offset
c
      ierr=fvex_open(ptr_ch("wh2"//char(0)),vex)

      write(6,*) "ierr from fvex_open=",ierr," vex=",vex

      ierr=fget_vex_rev(ptr_ch(buffer),len(buffer),vex)
      write(6,*) "ierr from fget_vex_rev=",ierr
      if(ierr.eq.0)
     &write(6,*) "buffer='",buffer(1:fvex_len(buffer)),
     & "' len=",fvex_len(buffer)

c
      if(ierr.eq.0) then
         lenn=fvex_len(buffer)
         write(6,*)"fvex_len(buffer)=",lenn
      endif
c
      ierr=fget_station_def(ptr_ch(buffer),len(buffer),vex)
      write(6,*) "ierr from fget_station_def=",ierr
c
      if(ierr.eq.0) then
         lenn=fvex_len(buffer)
         write(6,*)"fvex_len(buffer)=",lenn
      endif
c
      do while (lenn.gt.0.and.ierr.eq.0)
         write(6,*) "buffer=",buffer(1:lenn)
         ierr=fget_station_def(ptr_ch(buffer),len(buffer),0)
         write(6,*) "ierr from fget_station_def=",ierr
         if(ierr.eq.0) then
            lenn=fvex_len(buffer)
            write(6,*)"fvex_len(buffer)=",lenn
         endif
      enddo
c
      ierr=fget_mode_def(ptr_ch(buffer),len(buffer),vex)
      write(6,*) "ierr from fget_mode_def=",ierr
c
      if(ierr.eq.0) then
         lenn=fvex_len(buffer)
         write(6,*)"fvex_len(buffer)=",lenn
      endif
c
      do while (lenn.gt.0.and.ierr.eq.0)
         write(6,*) "buffer=",buffer(1:lenn)
         ierr=fget_mode_def(ptr_ch(buffer),len(buffer),0)
         write(6,*) "ierr from fget_mode_def=",ierr
         if(ierr.eq.0) then
            lenn=fvex_len(buffer)
            write(6,*)"fvex_len(buffer)=",lenn
         endif
      enddo
c
      ierr=fget_source_def(ptr_ch(buffer),len(buffer),vex)
      write(6,*) "ierr from fget_source_def=",ierr
c
      if(ierr.eq.0) then
         lenn=fvex_len(buffer)
         write(6,*)"fvex_len(buffer)=",lenn
      endif
c
      do while (lenn.gt.0.and.ierr.eq.0)
         write(6,*) "buffer=",buffer(1:lenn)
         ierr=fget_source_def(ptr_ch(buffer),len(buffer),0)
         write(6,*) "ierr from fget_source_def=",ierr
         if(ierr.eq.0) then
            lenn=fvex_len(buffer)
            write(6,*)"fvex_len(buffer)=",lenn
         endif
      enddo
C
C test all lowl
c
      ierr=fget_all_lowl(ptr_ch("EF"//char(0)),ptr_ch("SX"//char(0)),
     &     ptr_ch("chan_def"//char(0)),ptr_ch("FREQ"//char(0)),vex)
      write(6,*) "ierr from fget_all_lowl=",ierr

      do i=1,9
      ierr=fvex_field(i,ptr_ch(buffer),len(buffer))
      write(6,*) "i=",i," ierr from fvex_field=",ierr

      if(ierr.eq.0)
     &write(6,*) "buffer='",buffer(1:fvex_len(buffer)),
     & "' len=",fvex_len(buffer)

      ierr=fvex_units(ptr_ch(units),len(units))
      write(6,*) "i=",i," ierr from fvex_units=",ierr

      if(ierr.eq.0) then
         write(6,*) "units='",units(1:fvex_len(units)),
     &        "' len=",fvex_len(units)
         ierr=fvex_double(ptr_ch(buffer),ptr_ch(units),double)
         write(6,*) " ierr from fvex_double=",ierr," doube=",double
      endif
      enddo
C
      do j=1,4
      if(j.eq.1) then
      ierr=fget_all_lowl(ptr_ch("EF"//char(0)),
     &    ptr_ch("SX_VLBA"//char(0)),
     &     ptr_ch("extension"//char(0)),
     &     ptr_ch("EXTENSIONS"//char(0)),vex)
      else
      ierr=fget_all_lowl(ptr_ch("EF"//char(0)),ptr_ch("SX"//char(0)),
     &     ptr_ch("extension"//char(0)),
     &     ptr_ch("EXTENSIONS"//char(0)),0)
      endif
      write(6,*) "ierr from fget_all_lowl EXTENSIONS =",ierr

      if(ierr.eq.0) then
      do i=1,9
      ierr=fvex_field(i,ptr_ch(buffer),len(buffer))
      write(6,*) "i=",i," ierr from fvex_field=",ierr

      if(ierr.eq.0) then
      write(6,*) "buffer='",buffer(1:fvex_len(buffer)),
     & "' len=",fvex_len(buffer)

      ierr=fvex_units(ptr_ch(units),len(units))
      write(6,*) "i=",i," ierr from fvex_units=",ierr

      if(ierr.eq.0) then
         write(6,*) "units='",units(1:fvex_len(units)),
     &        "' len=",fvex_len(units)
         ierr=fvex_double(ptr_ch(buffer),ptr_ch(units),double)
         write(6,*) " ierr from fvex_double=",ierr," doube=",double
      endif
      endif
      enddo
      endif
      enddo
C
C test mode lowl
c
      ierr=fget_mode_lowl(ptr_ch("JB"//char(0)),
     &     ptr_ch("SX_VLBA"//char(0)),
     &     ptr_ch("chan_def"//char(0)),ptr_ch("FREQ"//char(0)),vex)
      write(6,*) "ierr from fget_mode_lowl=",ierr

      do i=1,9
      ierr=fvex_field(i,ptr_ch(buffer),len(buffer))
      write(6,*) "i=",i," ierr from fvex_field=",ierr

      if(ierr.eq.0)
     &write(6,*) "buffer='",buffer(1:fvex_len(buffer)),
     & "' len=",fvex_len(buffer)

      ierr=fvex_units(ptr_ch(units),len(units))
      write(6,*) "i=",i," ierr from fvex_units=",ierr

      if(ierr.eq.0) then
         write(6,*) "units='",units(1:fvex_len(units)),
     &        "' len=",fvex_len(units)
         ierr=fvex_double(ptr_ch(buffer),ptr_ch(units),double)
         write(6,*) " ierr from fvex_double=",ierr," doube=",double
      endif
      enddo
c
      ierr=fget_mode_lowl(ptr_ch("JB"//char(0)),
     &     ptr_ch("SX_VLBA"//char(0)),
     &     ptr_ch("extension"//char(0)),
     &     ptr_ch("EXTENSIONS"//char(0)),vex)
      write(6,*) "ierr from fget_mode_lowl EXTENSIONS=",ierr

      do i=1,9
      ierr=fvex_field(i,ptr_ch(buffer),len(buffer))
      write(6,*) "i=",i," ierr from fvex_field=",ierr

      if(ierr.eq.0)
     &write(6,*) "buffer='",buffer(1:fvex_len(buffer)),
     & "' len=",fvex_len(buffer)

      ierr=fvex_units(ptr_ch(units),len(units))
      write(6,*) "i=",i," ierr from fvex_units=",ierr

      if(ierr.eq.0) then
         write(6,*) "units='",units(1:fvex_len(units)),
     &        "' len=",fvex_len(units)
         ierr=fvex_double(ptr_ch(buffer),ptr_ch(units),double)
         write(6,*) " ierr from fvex_double=",ierr," doube=",double
      endif
      enddo
C
C station lowls
C
      ierr=fget_station_lowl(ptr_ch("EF"//char(0)),
     &     ptr_ch("site_position"//char(0)),ptr_ch("SITE"//char(0)),vex)
      write(6,*) "ierr from fget_station_lowl=",ierr

      do i=1,9
      ierr=fvex_field(i,ptr_ch(buffer),len(buffer))
      write(6,*) "i=",i," ierr from fvex_field=",ierr

      if(ierr.eq.0)
     &write(6,*) "buffer='",buffer(1:fvex_len(buffer)),
     & "' len=",fvex_len(buffer)

      ierr=fvex_units(ptr_ch(units),len(units))
      write(6,*) "i=",i," ierr from fvex_units=",ierr

      if(ierr.eq.0) then
         write(6,*) "units='",units(1:fvex_len(units)),
     &        "' len=",fvex_len(units)
         ierr=fvex_double(ptr_ch(buffer),ptr_ch(units),double)
         write(6,*) " ierr from fvex_double=",ierr," doube=",double
      endif

      enddo
C
      ierr=fget_station_lowl(ptr_ch("EF"//char(0)),
     &     ptr_ch("antenna_motion"//char(0)),ptr_ch("ANTENNA"//char(0)),
     &     vex)
      write(6,*) "ierr from fget_station_lowl=",ierr

      do i=1,9
      ierr=fvex_field(i,ptr_ch(buffer),len(buffer))
      write(6,*) "i=",i," ierr from fvex_field=",ierr

      if(ierr.eq.0)
     &write(6,*) "buffer='",buffer(1:fvex_len(buffer)),
     & "' len=",fvex_len(buffer)

      ierr=fvex_units(ptr_ch(units),len(units))
      write(6,*) "i=",i," ierr from fvex_units=",ierr

      if(ierr.eq.0) then
         write(6,*) "units='",units(1:fvex_len(units)),
     &        "' len=",fvex_len(units)
         ierr=fvex_double(ptr_ch(buffer),ptr_ch(units),double)
         write(6,*) " ierr from fvex_double=",ierr," doube=",double
      endif

      enddo
      ierr=fget_station_lowl(ptr_ch("EF"//char(0)),
     &     ptr_ch("extension"//char(0)),ptr_ch("EXTENSIONS"//char(0)),
     &     vex)
      write(6,*) "ierr from fget_station_lowl for EF EXTENSIONS=",ierr

      do i=1,9
      ierr=fvex_field(i,ptr_ch(buffer),len(buffer))
      write(6,*) "i=",i," ierr from fvex_field=",ierr

      if(ierr.eq.0)
     &write(6,*) "buffer='",buffer(1:fvex_len(buffer)),
     & "' len=",fvex_len(buffer)

      ierr=fvex_units(ptr_ch(units),len(units))
      write(6,*) "i=",i," ierr from fvex_units=",ierr

      if(ierr.eq.0) then
         write(6,*) "units='",units(1:fvex_len(units)),
     &        "' len=",fvex_len(units)
         ierr=fvex_double(ptr_ch(buffer),ptr_ch(units),double)
         write(6,*) " ierr from fvex_double=",ierr," doube=",double
      endif

      enddo
C
C  test global lowl
C
      ierr=fget_global_lowl(
     &     ptr_ch("x_wobble"//char(0)),ptr_ch("EOP"//char(0)),vex)
      write(6,*) "ierr from fget_global_lowl=",ierr

      do i=1,9
      ierr=fvex_field(i,ptr_ch(buffer),len(buffer))
      write(6,*) "i=",i," ierr from fvex_field=",ierr

      if(ierr.eq.0)
     &write(6,*) "buffer='",buffer(1:fvex_len(buffer)),
     & "' len=",fvex_len(buffer)

      ierr=fvex_units(ptr_ch(units),len(units))
      write(6,*) "i=",i," ierr from fvex_units=",ierr

      if(ierr.eq.0) then
         write(6,*) "units='",units(1:fvex_len(units)),
     &        "' len=",fvex_len(units)
         ierr=fvex_double(ptr_ch(buffer),ptr_ch(units),double)
         write(6,*) " ierr from fvex_double=",ierr," doube=",double
      endif

      enddo
c
      ierr=fget_global_lowl(
     &     ptr_ch("extension"//char(0)),
     &     ptr_ch("EXTENSIONS"//char(0)),vex)
      write(6,*) "ierr from fget_global_lowl EXTENSION=",ierr

      do i=1,9
      ierr=fvex_field(i,ptr_ch(buffer),len(buffer))
      write(6,*) "i=",i," ierr from fvex_field=",ierr

      if(ierr.eq.0)
     &write(6,*) "buffer='",buffer(1:fvex_len(buffer)),
     & "' len=",fvex_len(buffer)

      ierr=fvex_units(ptr_ch(units),len(units))
      write(6,*) "i=",i," ierr from fvex_units=",ierr

      if(ierr.eq.0) then
         write(6,*) "units='",units(1:fvex_len(units)),
     &        "' len=",fvex_len(units)
         ierr=fvex_double(ptr_ch(buffer),ptr_ch(units),double)
         write(6,*) " ierr from fvex_double=",ierr," doube=",double
      endif

      enddo
c
      do j=1,4
      if(j.eq.1) then
      ierr=fget_global_lowl(
     &     ptr_ch("equip_set"//char(0)),
     &     ptr_ch("DAS"//char(0)),vex)
      else
      ierr=fget_global_lowl(
     &     ptr_ch("equip_set"//char(0)),
     &     ptr_ch("DAS"//char(0)),0)
      endif
      write(6,*) "ierr from fget_global_lowl DAS=",ierr

      if(ierr.eq.0) then
      do i=1,9
      ierr=fvex_field(i,ptr_ch(buffer),len(buffer))
      write(6,*) "i=",i," ierr from fvex_field=",ierr

      if(ierr.eq.0) then
      write(6,*) "buffer='",buffer(1:fvex_len(buffer)),
     & "' len=",fvex_len(buffer)

      ierr=fvex_units(ptr_ch(units),len(units))
      write(6,*) "i=",i," ierr from fvex_units=",ierr

      if(ierr.eq.0) then
         write(6,*) "units='",units(1:fvex_len(units)),
     &        "' len=",fvex_len(units)
         ierr=fvex_double(ptr_ch(buffer),ptr_ch(units),double)
         write(6,*) " ierr from fvex_double=",ierr," doube=",double
      endif
      endif
      enddo
      endif
      enddo
c
      ierr=fget_source_lowl(ptr_ch("HD123456"//char(0)),
     & ptr_ch("source_model"//char(0)),vex)
      write(6,*) "ierr from fget_source_lowl=",ierr

      do i=1,9
      ierr=fvex_field(i,ptr_ch(buffer),len(buffer))
      write(6,*) "i=",i," ierr from fvex_field=",ierr

      if(ierr.eq.0)
     &write(6,*) "buffer='",buffer(1:fvex_len(buffer)),
     & "' len=",fvex_len(buffer)

      ierr=fvex_units(ptr_ch(units),len(units))
      write(6,*) "i=",i," ierr from fvex_units=",ierr

      if(ierr.eq.0) then
         write(6,*) "units='",units(1:fvex_len(units)),
     &        "' len=",fvex_len(units)
         ierr=fvex_double(ptr_ch(buffer),ptr_ch(units),double)
         write(6,*) " ierr from fvex_double=",ierr," doube=",double
      endif

      enddo
c
      ierr=fget_source_lowl(ptr_ch("HD123456"//char(0)),
     & ptr_ch("source_model"//char(0)),0)
      write(6,*) "ierr from fget_source_lowl=",ierr

      do i=1,9
      ierr=fvex_field(i,ptr_ch(buffer),len(buffer))
      write(6,*) "i=",i," ierr from fvex_field=",ierr

      if(ierr.eq.0)
     &write(6,*) "buffer='",buffer(1:fvex_len(buffer)),
     & "' len=",fvex_len(buffer)

      ierr=fvex_units(ptr_ch(units),len(units))
      write(6,*) "i=",i," ierr from fvex_units=",ierr

      if(ierr.eq.0) then
         write(6,*) "units='",units(1:fvex_len(units)),
     &        "' len=",fvex_len(units)
         ierr=fvex_double(ptr_ch(buffer),ptr_ch(units),double)
         write(6,*) " ierr from fvex_double=",ierr," doube=",double
      endif

      enddo
c
      ierr=fget_scan_station(ptr_ch(buffer),len(buffer),
     &     ptr_ch(mode),len(mode),ptr_ch(scanid),len(scanid),
     &     ptr_ch("JB"//char(0)),vex)
      write(6,*) "ierr from fget_scan_station=",ierr
      write(6,*) "start =",buffer(1:fvex_len(buffer))
      write(6,*) "mode  =",mode(1:fvex_len(mode))
      write(6,*) "scanid=",scanid(1:fvex_len(scanid))

      do i=1,9
      ierr=fvex_field(i,ptr_ch(buffer),len(buffer))
      write(6,*) "i=",i," ierr from fvex_field=",ierr

      if(ierr.eq.0)
     &write(6,*) "buffer='",buffer(1:fvex_len(buffer)),
     & "' len=",fvex_len(buffer)

      ierr=fvex_units(ptr_ch(units),len(units))
      write(6,*) "i=",i," ierr from fvex_units=",ierr

      if(ierr.eq.0) then
         write(6,*) "units='",units(1:fvex_len(units)),
     &        "' len=",fvex_len(units)
         ierr=fvex_double(ptr_ch(buffer),ptr_ch(units),double)
         write(6,*) " ierr from fvex_double=",ierr," doube=",double
      endif

      enddo

      do j=1,3
         ierr=fvex_scan_source2(j)
         WRITE(6,*) ' IERR FROM FVEX_SCAN_SOURCE2=',IERr
         if(ierr.eq.0) then
            do i=1,4
               ierr=fvex_field(i,ptr_ch(buffer),len(buffer))
               write(6,*) "i=",i," ierr from fvex_field=",ierr

               if(ierr.eq.0)
     &            write(6,*) "buffer='",buffer(1:fvex_len(buffer)),
     &           "' len=",fvex_len(buffer)
            enddo
         endif
      enddo

c
      ierr=fget_scan_station(ptr_ch(buffer),len(buffer),
     &     ptr_ch(mode),len(mode),ptr_ch(scanid),len(scanid),
     &     ptr_ch("JB"//char(0)),0)
      write(6,*) "ierr from fget_scan_station=",ierr
      write(6,*) "start=",buffer(1:fvex_len(buffer))
      write(6,*) "mode =",mode(1:fvex_len(mode))
      write(6,*) "scanid=",scanid(1:fvex_len(scanid))
c
      do i=1,9
      ierr=fvex_field(i,ptr_ch(buffer),len(buffer))
      write(6,*) "i=",i," ierr from fvex_field=",ierr

      if(ierr.eq.0)
     &write(6,*) "buffer='",buffer(1:fvex_len(buffer)),
     & "' len=",fvex_len(buffer)

      ierr=fvex_units(ptr_ch(units),len(units))
      write(6,*) "i=",i," ierr from fvex_units=",ierr

      if(ierr.eq.0) then
         write(6,*) "units='",units(1:fvex_len(units)),
     &        "' len=",fvex_len(units)
         ierr=fvex_double(ptr_ch(buffer),ptr_ch(units),double)
         write(6,*) " ierr from fvex_double=",ierr," doube=",double
      endif
      enddo
c
      ierr=fget_scan_station(ptr_ch(buffer),len(buffer),
     &     ptr_ch(mode),len(mode),ptr_ch(scanid),len(scanid),
     &     ptr_ch("JB"//char(0)),0)
      write(6,*) "ierr from fget_scan_station=",ierr
      write(6,*) "start=",buffer(1:fvex_len(buffer))
      write(6,*) "mode =",mode(1:fvex_len(mode))
      write(6,*) "scanid=",scanid(1:fvex_len(scanid))

      ierr=fvex_date(ptr_ch(buffer),iarray,seconds)
      write(6,*) "ierr from fvex_date=",ierr
      write(6,*) "iarray = ", iarray, " seconds=",seconds

      do i=1,9
      ierr=fvex_field(i,ptr_ch(buffer),len(buffer))
      write(6,*) "i=",i," ierr from fvex_field=",ierr

      if(ierr.eq.0)
     &write(6,*) "buffer='",buffer(1:fvex_len(buffer)),
     & "' len=",fvex_len(buffer)

      ierr=fvex_units(ptr_ch(units),len(units))
      write(6,*) "i=",i," ierr from fvex_units=",ierr

      if(ierr.eq.0) then
         write(6,*) "units='",units(1:fvex_len(units)),
     &        "' len=",fvex_len(units)
         ierr=fvex_double(ptr_ch(buffer),ptr_ch(units),double)
         write(6,*) " ierr from fvex_double=",ierr," doube=",double
      endif

      ierr=fvex_int(ptr_ch(buffer),int)
      write(6,*) "ierr from fvex_int=",ierr
      write(6,*) "int= ",int

      enddo
      ierr=fget_scan_station(ptr_ch(buffer),len(buffer),
     &     ptr_ch(mode),len(mode),ptr_ch(scanid),len(scanid),
     &     ptr_ch("EF"//char(0)),vex)

      write(6,*) "ierr from fget_scan_station=",ierr
      write(6,*) "start=",buffer(1:fvex_len(buffer))
      write(6,*) "mode =",mode(1:fvex_len(mode))
      write(6,*) "scanid=",scanid(1:fvex_len(scanid))

      ierr=fvex_date(ptr_ch(buffer),iarray,seconds)
      write(6,*) "ierr from fvex_date=",ierr
      write(6,*) "iarray = ", iarray, " seconds=",seconds

      do i=1,9
      ierr=fvex_field(i,ptr_ch(buffer),len(buffer))
      write(6,*) "i=",i," ierr from fvex_field=",ierr

      if(ierr.eq.0)
     &write(6,*) "buffer='",buffer(1:fvex_len(buffer)),
     & "' len=",fvex_len(buffer)

      ierr=fvex_units(ptr_ch(units),len(units))
      write(6,*) "i=",i," ierr from fvex_units=",ierr

      if(ierr.eq.0) then
         write(6,*) "units='",units(1:fvex_len(units)),
     &        "' len=",fvex_len(units)
         ierr=fvex_double(ptr_ch(buffer),ptr_ch(units),double)
         write(6,*) " ierr from fvex_double=",ierr," doube=",double
      endif

      ierr=fvex_int(ptr_ch(buffer),int)
      write(6,*) "ierr from fvex_int=",ierr
      write(6,*) "int= ",int

      enddo

      do i=1,3
      ierr=fvex_scan_source(i,ptr_ch(buffer),len(buffer))
      write(6,*) "i=",i," ierr from fvex_scan_source=",ierr

      if(ierr.eq.0)
     &write(6,*) "buffer='",buffer(1:fvex_len(buffer)),
     & "' len=",fvex_len(buffer)
      enddo
c
      do j=1,3
         ierr=fvex_scan_intent(j)
         WRITE(6,*) ' IERR FROM FVEX_SCAN_INTENT=',IERr
         if(ierr.eq.0) then
            do i=1,4
               ierr=fvex_field(i,ptr_ch(buffer),len(buffer))
               write(6,*) "i=",i," ierr from fvex_field=",ierr

               if(ierr.eq.0)
     &            write(6,*) "buffer='",buffer(1:fvex_len(buffer)),
     &           "' len=",fvex_len(buffer)
            enddo
         endif
      enddo
c
      do j=1,3
         ierr=fvex_scan_pointing_offset(j)
         WRITE(6,*) ' IERR FROM FVEX_SCAN_POINTING_OFFSET=',IERr
         if(ierr.eq.0) then
            do i=1,9
               ierr=fvex_field(i,ptr_ch(buffer),len(buffer))
               write(6,*) "i=",i," ierr from fvex_field=",ierr

               if(ierr.eq.0) then
                  write(6,*) "buffer='",buffer(1:fvex_len(buffer)),
     &           "' len=",fvex_len(buffer)
                  ierr=fvex_units(ptr_ch(units),len(units))
                  write(6,*) "i=",i," ierr from fvex_units=",ierr

                  if(ierr.eq.0) then
                     write(6,*) "units='",units(1:fvex_len(units)),
     &        "' len=",fvex_len(units)
                  endif
               endif
            enddo
         endif
      enddo
c
      ierr=fget_source_lowl(ptr_ch("HD123456"//char(0)),
     & ptr_ch("ra"//char(0)),vex)
      write(6,*) "ierr from fget_source_lowl=",ierr

      i=1
      ierr=fvex_field(i,ptr_ch(buffer),len(buffer))
      write(6,*) "i=",i," ierr from fvex_field=",ierr

      if(ierr.eq.0) then
      write(6,*) "buffer='",buffer(1:fvex_len(buffer)),
     & "' len=",fvex_len(buffer)

         ierr=fvex_ra(ptr_ch(buffer),double)
         write(6,*) " ierr from fvex_ra=",ierr," doube=",double
      endif
c
      ierr=fget_source_lowl(ptr_ch("HD123456"//char(0)),
     & ptr_ch("dec"//char(0)),vex)
      write(6,*) "ierr from fget_source_lowl=",ierr

      i=1
      ierr=fvex_field(i,ptr_ch(buffer),len(buffer))
      write(6,*) "i=",i," ierr from fvex_field=",ierr

      if(ierr.eq.0) then
      write(6,*) "buffer='",buffer(1:fvex_len(buffer)),
     & "' len=",fvex_len(buffer)

         ierr=fvex_dec(ptr_ch(buffer),double)
         write(6,*) " ierr from fvex_dec=",ierr," doube=",double
      endif
c
      ierr=fget_station_lowl(ptr_ch("JB"//char(0)),
     &     ptr_ch("clock_early"//char(0)),ptr_ch("CLOCK"//char(0)),
     &     vex)
      write(6,*) "ierr from fget_station_lowl=",ierr

      do while (ierr.eq.0)
      do i=1,9
      ierr=fvex_field(i,ptr_ch(buffer),len(buffer))
      write(6,*) "i=",i," ierr from fvex_field=",ierr

      if(ierr.eq.0)
     &write(6,*) "buffer='",buffer(1:fvex_len(buffer)),
     & "' len=",fvex_len(buffer)

      ierr=fvex_units(ptr_ch(units),len(units))
      write(6,*) "i=",i," ierr from fvex_units=",ierr

      if(ierr.eq.0) then
         write(6,*) "units='",units(1:fvex_len(units)),
     &        "' len=",fvex_len(units)
         ierr=fvex_double(ptr_ch(buffer),ptr_ch(units),double)
         write(6,*) " ierr from fvex_double=",ierr," doube=",double
      endif

      enddo
      ierr=fget_station_lowl(ptr_ch("JB"//char(0)),
     &     ptr_ch("clock_early"//char(0)),ptr_ch("CLOCK"//char(0)),
     &     0)
      write(6,*) "ierr from fget_station_lowl=",ierr

      enddo
C
      write(6,*) 'scheduling software'
      ierr=fget_global_lowl(
     &     ptr_ch("scheduling_software"//char(0)),
     &     ptr_ch("EXPER"//char(0)),vex)
      write(6,*) "ierr from fget_global_lowl=",ierr
      do while(ierr.eq.0)
c
      call gfields
c
      ierr=fget_global_lowl(
     &     ptr_ch("scheduling_software"//char(0)),
     &     ptr_ch("EXPER"//char(0)),0)
      write(6,*) "ierr from fget_global_lowl=",ierr
      enddo
C
      write(6,*) 'VEX_file_writer'
      ierr=fget_global_lowl(
     &     ptr_ch("VEX_file_writer"//char(0)),
     &     ptr_ch("EXPER"//char(0)),vex)
      write(6,*) "ierr from fget_global_lowl=",ierr
      do while(ierr.eq.0)
c
      call gfields
c
      ierr=fget_global_lowl(
     &     ptr_ch("VEX_file_writer"//char(0)),
     &     ptr_ch("EXPER"//char(0)),0)
      write(6,*) "ierr from fget_global_lowl=",ierr
      enddo
C
      write(6,*) 'exper_name'
      ierr=fget_global_lowl(
     &     ptr_ch("exper_name"//char(0)),
     &     ptr_ch("EXPER"//char(0)),vex)
      write(6,*) "ierr from fget_global_lowl=",ierr
      do while(ierr.eq.0)
c
      call gfields
c
      ierr=fget_global_lowl(
     &     ptr_ch("exper_name"//char(0)),
     &     ptr_ch("EXPER"//char(0)),0)
      write(6,*) "ierr from fget_global_lowl=",ierr
      enddo
C
      end
