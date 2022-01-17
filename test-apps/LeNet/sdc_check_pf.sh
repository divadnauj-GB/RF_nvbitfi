#!/bin/bash
#read -n 1
diff /home/jetson/nvbit_release/tools/nvbitfi/test-apps/LeNet/stdout.txt /home/jetson/nvbit_release/tools/nvbitfi/test-apps/LeNet/golden_stdout.txt > stdout_diff.log
diff /home/jetson/nvbit_release/tools/nvbitfi/test-apps/LeNet/stderr.txt /home/jetson/nvbit_release/tools/nvbitfi/test-apps/LeNet/golden_stderr.txt > stderr_diff.log
