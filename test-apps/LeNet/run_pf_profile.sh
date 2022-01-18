#!/bin/bash
LD_PRELOAD=/home/juancho/Documents/GitHub/Ampere_NVBit/nvbit_release/tools/RF_nvbitfi/profiler/profiler.so /home/juancho/Documents/GitHub/darknet_jd_v1/darknet classifier predict /home/juancho/Documents/GitHub/darknet_jd_v1/LeNet/cfg/mnist.data /home/juancho/Documents/GitHub/darknet_jd_v1/LeNet/cfg/mnist_lenet.cfg /home/juancho/Documents/GitHub/darknet_jd_v1/LeNet/mnist_lenet.weights /home/juancho/Documents/GitHub/darknet_jd_v1/LeNet/mnist_images/test/0_Five.png -t 10


