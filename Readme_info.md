#(In this file the Keyword to read the modifications needed is MODIFICATION)
Starting point: ./test_pf.sh
........................................
#For LeNet fault injection:
Commands are used to perform the initial simulation to generate golden outputs: golden_stdout.txt and golden_stderr.txt in test-apps/LeNet folder. MODIFICATION: At line 119 and 121 in test_pf.sh need to change the path for darknet and LeNet folder.
Uncomment the command "rm -f /home/jetson/nvbit_release/tools/nvbitfi/test-apps/LeNet/logs/report.txt" to remove the report file containing each injection information, this remove the original content(old injections) avoiding to append new fault injection results at the end of the file report.

From scripts folder 4 scripts are launched:

1. Perform the profiling with run_profiler.py: MODIFICATION In test-apps/LeNet folder in run_pf_profile.sh script need to change the path for profiler.so folder and LeNet folder. In test-apps/LeNet folder the script generate the output file nvbit-profile.txt containing the profile information used later.

2. Generate the fault list with Neural_list.py: read the nvbit-profile.txt and generate in test-apps/LeNet folder the "injection-RF.txt" file containing the complete fault list, the number of faults generated is given by the total number of used registers for 18 pseudo-random threads ID number for the 2 stuck at model with different masks ( 36 faults for each register). No changes are needed here.

3. Perform the injections and classification with Neural_classifier.py: read the injection-RF.txt file and modify for each read fault the nvbit-injection-info.txt file in pf_injector folder used to perform the injection. Results of the injections are appended in the test-apps/LeNet/logs report.txt file. MODIFICATION: In test-apps/LeNet folder in run_pf.sh need to modify the path for pf_injector/pf_injector.so, the Darkent path and also the output file path which should be inside the test-apps/LeNet folder.

4. Parse the results with Neural_parser.py: read the report.txt file generated by the classifier and generate a report file called darknet_op_report.txt in folder test-apps/LeNet/logs. No changes are needed here.

