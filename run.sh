 #! /bin/bash
 # Скрипт по установке opencv
 sudo apt-get install -y build-essential
 sudo apt-get install -y cmake git libgtk2.0-dev pkg-config libavcodec-dev libavformat-dev libswscale-dev
 sudo apt-get install -y python-dev python-numpy libtbb2 libtbb-dev libjpeg-dev libpng-dev libtiff-dev libjasper-dev libdc1394-22-dev

   git clone https://github.com/opencv/opencv.git
   git clone https://github.com/opencv/opencv_contrib.git
   cd opencv

  # Create a new 'build' folder.
   mkdir build
   cd build

  # Set build instructions for Ubuntu distro.
   cmake -D CMAKE_BUILD_TYPE=RELEASE -D BUILD_EXAMPLES=OFF -D BUILD_opencv_apps=OFF -D BUILD_DOCS=OFF -D BUILD_PERF_TESTS=OFF -D BUILD_TESTS=OFF -D CMAKE_INSTALL_PREFIX=/usr/local ..

  # Run 'make' with four threads.
   make -j4

  # Install to OS.
   sudo make install

  # Add configuration to OpenCV to tell it where the library files are located on the file system (/usr/local/lib)
   sudo sh -c 'echo "/usr/local/lib" > /etc/ld.so.conf.d/opencv.conf'

   sudo ldconfig
   echo "OpenCV installed."
