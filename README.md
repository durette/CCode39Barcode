# CCode39Barcode
This Oracle Package converts a text string to Code 39 barcode as a string of lines and blocks. It's specifically tailored for use with IFS Applications.

    SELECT c_code39_barcode_api.alphanum_to_code39('HELLO WORLD') FROM DUAL;
    
          | |▮▮|▮|| ▮|▮|▮ |||▮|| ▮|▮|| ▮▮|▮| || ▮|▮|▮ ▮|||▮|▮| |▮||▮ ||▮|| ▮||▮ |▮| |▮▮|      
