! -*- f95 -*-

module image_module
  ! the C compatibility layer
  use, intrinsic:: iso_c_binding
  ! oh yes...
  implicit none

  ! shape
  type, bind(C) :: shape_t
     integer(c_int) :: bands, lines, samples
  end type shape_t


  ! image
  type, bind(C) :: image_t
     type(shape_t) :: shape
     type(c_ptr) :: data
  end type image_t


contains

  ! compute the size of an image
  function size(image)

    implicit none
    integer size
    type(image_t), intent(in) :: image

    size = image%shape%lines * image%shape%samples * image%shape%bands

  end function size

  ! display image statistics
  subroutine show(image) bind(c, name='show')
    use, intrinsic:: iso_c_binding
    implicit none

    integer imgsz
    integer band, line, sample
    integer bands, lines, samples
    type(image_t), intent(in) :: image

    ! local variable
    type(shape_t) :: shape
    real(kind=c_double), pointer :: data(:,:,:)
    real(kind=c_double), pointer :: flat(:)

    ! compute the size
    imgsz = size(image)
    ! access to the shape
    shape = image%shape
    ! unpack
    bands = shape%bands
    lines = shape%lines
    samples = shape%samples

    ! get access to the payload
    call c_f_pointer(image%data, flat, [imgsz])
    call c_f_pointer(image%data, data, [samples,lines,bands])

    ! print stats
    print *, bands, lines, samples
    print *, imgsz

    print *,'--------------------------------'
    do band=1,bands
       print *,"band =",band
       do line=1,lines
          print *,"line =",line
          do sample=1,samples
             print *,data(sample,line,band)
          end do
       end do
    end do

    print *,'--------------------------------'
    do sample=1,imgsz
       print *,flat(sample)
    end do

    ! all done
  end subroutine show

end module image_module

! end of file
