#!/bin/bash
LD_PRELOAD=/home/jetson/nvbit_release/tools/nvbitfi/profiler/profiler.so /home/jetson/darknet/darknet classifier predict /home/jetson/darknet/LeNet/cfg/mnist.data /home/jetson/darknet/LeNet/cfg/mnist_lenet.cfg /home/jetson/darknet/LeNet/mnist_lenet.weights /home/jetson/darknet/LeNet/mnist_images/test/0_Five.png -t 10


