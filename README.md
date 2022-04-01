# EC552 Homework 1: Genetic Circuit Tool 
## by Zenia Valdiviezo and Sally Shin

###### What it can do
This MATLAB livescript tool allows for basic optimization of a user-defined circuit by modifying the response function of individual gates using various operations that user can decide for each gate. The tool runs through the given circuit automatically and returns an output text file that contains information of the score, rudimentary circuit diagram, gates chosen with operations run on it, and how many times each operation was used. 

###### To Run
The main livescript file EC552HW1.mlx and 3 gate function files (AND_gate.m, OR_gate.m, NOT_gate.m) should be in same directory to run the script. The user-defined files (described below) should be in the same directory as well. 

When getting started, load the files on the MATLAB directory, change filenames in the "Import Files" section as directed and run the script. 
The output file is automatically named as "myoutput.txt" and placed in the run directory. 

*When running multiple runs*
We suggest clearing the variable workspace to not have any errors with the variable names. 
If multiple output results need to be saved, rename the result file in the code or remove the file "myoutput.txt" from the directory to save it elsewhere.

###### Files to prepare
*IMPORTANT: ALL FILES SHOULD HAVE SAME NECESSARY COLUMN NAMES AS THE EXAMPLE FILES IN THIS REPOSITORY*
More information is given in the mlx file. The files can be unused columns but the necessary column names must be included to run the program properly.

1. Input file: includes input name and values of being OFF or ON
2. AND gates file: includes name, values of ymin, ymax, n and Kd. 
3. OR gates file: includes name, values of ymin, ymax, n and Kd. 
4. NOT gates file: includes name, values of ymin, ymax, n and Kd. 
5. Circuit file: includes name, type (AND/OR/NOT), names of input_1, input_2, and output for each gate, and empty columns (or with 0s) titled output_off and output_on.

Each file should be filled with values other than the output_off and output_on columns in circuit file. 

###### Operations Possible
1. Stretch: increases ymax and decreases ymin
  -ymax is increased by score x by equation (new_ymax = ymax * x)
  -ymin is decreased by score x by equation (new_ymin = ymin / x)
2. Increase Slope: increase n
  -n is increased by score x by equation (new_n = n * x)
3. Decrease Slope: decrease n
  -n is decreased by score x by equation (new_n = n / x)
4. Stronger Promoter: increase ymax and increase ymin
  -ymax is increased by score x by equation (new_ymax = ymax * x)
  -ymin is increased by score x by equation (new_ymin = ymin * x)
5. Weaker Promoter: decrease ymax and decrease ymin
  -ymax is decreased by score x by equation (new_ymax = ymax / x)
  -ymin is decreased by score x by equation (new_ymin = ymin / x)
6. Stronger RBS: Kd is decreased
  -Kd is decreased by score x by equation (new_Kd = Kd / x)
7. Weaker RBS: Kd is increased
  -Kd is increased by score x by equation (new_Kd = Kd * x)


