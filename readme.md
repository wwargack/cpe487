# cpe487 - Digital System Design

## Directories

- Assignment 1 ([hw1](./hw1))
  - Find a VHDL model not included in the textbook.
  - Add a comment citing the source and upload the file to your GitHub Repository. 
  
- Assignment 2 ([hw2](./hw2))
  - Develop a test bench for your VHDL file from assignment 1.
  - Run GHDL to generate a vcd file.
  - Use GTKWave to view the VCD file and take a screenshot.
  - Upload the design, test bench, and VCD files to your GitHub repository.
  - Create a readme.md file to include the screenshot.

- Lab 1 ([leddec](./lab1/leddec), [hexcount](./lab1/hexcount))
  - Open Vivado and create VHDL projects to synthesize, implement, generate bitstream, and program FPGA for:
    - Lab 1 Project 1: LED Decoder ([leddec](./lab1/leddec))
    - Lab 1 Project 2: Single Digit Hex Counter ([hexcount](./lab1/hexcount))
    - Lab 1 Modifications:
      - LED Decoder Switch Change ([leddec mod](./lab1/leddec/mod))
      - Hexcount LED Decoder Combination ([super hexcount](./lab1/hexcount/super))

- Lab 2 ([hex4count](./lab2/hex4count))
  - Open Vivado and create a VHDL project to synthesize, implement, generate bitstream, and program FPGA for:
    - Lab 2 Project 1: Four Digit Hex Counter ([hex4count](./lab2/hex4count))
    - Lab 2 Modifications: 
      - Eight Digit Hex Counter ([hex8count](./lab2/hex8count))
      - Choice Digit Hex Counter ([hexchoicecount](./lab2/hexchoicecount))
  - Also create memory configuration files so that the FPGA board can boot the VHDL program from memory.
  
- Lab 3 ([vgaball](./lab3/vgaball))
  - Open Vivado and create a VHDL project to synthesize, implemet, generate bitstream, and program FPGA for:
    - Lab 3 Project 1: VGA Ball Display ([vgaball](./lab3/vgaball))
    - Lab 3 Modifications ([lab3 mod](./lab3/vgaball/mod))
    
- Lab 4 ([hexcalc](./lab4/hexcalc))
  - Open Vivado and create a VHDL project to synthesize, implemet, generate bitstream, and program FPGA for:
    - Lab 4 Project 1: Hexadecimal Calculator ([hexcalc](./lab4/hexcalc))
      - 4 Digit Hex Display (16 Bits)
      - Operations
        - Addition
    - Lab 4 Modifications ([lab4 mod](./lab4/hexcalc/mod)):
      - 8 Digit Hex Display (32 Bits)
      - Operations
        - Addition
        - Subtraction
        - Multiplication
      - Leading Zero Suppression
  - More modifications included in [Final Project](./proj)

- Lab 5 ([siren](./lab5/siren))

- Lab 6 ([pong](./lab6/pong))

- Final Project ([proj](./proj))
  - Walter's Advanced Hexadecimal Calculator
  - Operations
    - Addition
    - Subtraction
    - Multiplication
    - Division
    - Bitwise AND
    - Bitwise NAND
    - Bitwise OR
    - Bitwise XOR
  - Leading Zero Suppression


## Git LFS Issue

- GitHub does not allow you to upload a file greater than 100MB to your repository.
To get around this, it is possible to use [Git LFS](https://git-lfs.github.com/) (Git Large File Storage).
  - Once per user account, run `git lfs install` in the terminal.
  - In each Git repository where you want to use Git LFS, select the file types you'd like Git LFS to manage (or directly edit .gitattributes).  `git lfs track "*.gif"`
  - Then make sure .gitattributes is tracked.  `git add .gitattributes`
  - Git LFS now works for your repository and you can commit and push to GitHub like normal.

- For a basic account, Git LFS has a maximum storage and bandwidth size of 1GB.
This is a problem considering if you are using Git LFS your files are already larger than 100MB.
- With the most basic plan, this would mean that you would only be able to store a maximum of about 10 files in your Git LFS storage.
Each addition to your data plan costs $5.00 more per month and adds 50GB to your maximum storage and bandwidth.
- I noticed this problem when I got an email from GitHub saying that my LFS storage was 30% full for only including one file in it.
- I didn't want to go over my storage limit, so I tried to figure out a way to remove LFS from my repository.
- The only thing that I had stored was a large unedited gif file. It's not too important, and I can figure out how to edit it to reduce it's file size.

  - I tried removing the gif file and .gitattribute files from my repository and the file was still being stored.
  - I tried `git lfs uninstall` and the file was still being stored.
- According to a GitHub [documentation](https://docs.github.com/en/repositories/working-with-files/managing-large-files/removing-files-from-git-large-file-storage) on removing files from Git LFS, the only easy way I've seen to remove files from Git LFS is to delete the repository the files are a part of.
- Git LFS still stores files that are in repository histories, and I thought that deleting my repo and pushing all my old files would be faster than doing the research and spending time trying to figure out how to delete files from my repo history.
- This repo is technically the new one but it is now indistinguishable from the old one in terms of right before the old one was deleted with the exception of no Git LFS and no large gif files. 

- I would not recommend using Git LFS to store inconsequential files unless you are willing to pay for a bigger storage plan.
  - I think Git LFS could work for a short term solution (provided you know how to correctly remove files from your LFS storage without needing to delete your whole repository).
  - However I do not think Git LFS is worth it in the long term unless you pay.
  - It is especially not worth using if you need to delete your repository to free up space like me.
