! -*- f95 -*-

! main entry point
program test
  ! access the compatibility layer
  use, intrinsic:: iso_c_binding
  ! access to {image}
  use image_module

  implicit none

  ! type declarations
  type(image_t) :: img
  integer imgsz

  ! initialize the shape
  img % shape % lines = 1
  img % shape % samples = 2
  img % shape % bands = 3
  ! compute the image size
  imgsz = size(img)

  ! show me
  call show(img)

  ! all done
end program test

! end of file
