-- File: main_ada_process_ngc_gcodes.adb
-- Date: Thu 25 Feb 2021 11:49:52 AM +08
-- Author: WRY wruslan.ump@gmail.com
-- ========================================================

-- IMPORT STANDARD ADA PACKAGES
with Ada.Text_IO;
with Ada.Real_Time; use Ada.Real_Time;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

-- IMPORT USER-DEFINED ADA PACKAGES
with pkg_ada_dtstamp;
with pkg_ada_random;
with pkg_ada_read_display_file;
with pkg_ada_read_write_file;
with pkg_ada_write_display_file;

with pkg01_classify_gcode_lines;
with pkg02_remove_comment_lines;
with pkg03_process_gcode_line;

-- ========================================================
procedure main_ada_process_ngc_gcodes
-- ========================================================
	with SPARK_Mode => on
is 

   -- RENAME STANDARD ADA PACKAGES FOR CONVENIENCE
   package ATIO    renames Ada.Text_IO;
   package ART     renames Ada.Real_Time;
   package ASU     renames Ada.Strings.Unbounded;
   
   -- RENAME USER-DEFINED ADA PACKAGES FOR CONVENIENCE
   package PADTS   renames pkg_ada_dtstamp;
   package PAR     renames pkg_ada_random;
   package PARDF   renames pkg_ada_read_display_file;
   package PARWF   renames pkg_ada_read_write_file;
   package PAWDF   renames pkg_ada_write_display_file;
   
   package PCGL    renames pkg01_classify_gcode_lines;
   package PRCL    renames pkg02_remove_comment_lines;
   package PPGL    renames pkg03_process_gcode_line;
   
   -- =======================================================
   -- GENERIC FILE VARIABLES
   -- =======================================================
   inp_gcode_file1   : String := "files/bismillah.ngc";
   inp_gcode_file2   : String := "files/just-KSG.ngc";
          
-- ========================================================  
begin
   
   PADTS.dtstamp; ATIO.Put_Line ("Bismillah 3 times WRY");
   PADTS.dtstamp; ATIO.Put_Line ("Running inside GNAT Studio Community");
   ATIO.New_Line;
   
   -- PARDF.exec_read_display_file (inp_fmode, inp_fname);
   -- PARWF.exec_read_write_file (inp_fmode, inp_fname, out_fmode, out_fname);
   -- PAWDF.exec_write_display_file (write_fmode, write_fname);
   
   -- PCGL.exec_read_display_file (inp_fmode, inp_fname);  
   -- PRCL.exec_read_display_file (inp_fmode, inp_fname);  
   -- PPGL.exec_read_display_file (inp_fmode, inp_fname);  
   
   PCGL.exec_classify_gcode_lines(inp_gcode_file1);
   -- PRCL.exec_remove_comment_lines("files/out_gcode_file01.txt");
   
   -- =====================================================
            
   ATIO.New_Line; PADTS.dtstamp; ATIO.Put_Line ("Alhamdulillah 3 times WRY");
-- ========================================================   
end main_ada_process_ngc_gcodes;
-- ========================================================

-- =======================================================
-- LINE ACCOUNTING AND CLASSIFICATION SUMMARY 
-- =======================================================
-- lineCount        =  328
-- max_lenUBlineStr =  99
-- lineBlank        =  62
-- lineNotBlank     =  266
-- lineTagged       =  328
-- Curr File Output = files/out_gcode_file01.txt

-- 2021-02-25 10:03:33.57042091241 Alhamdulillah 3 times WRY
-- [2021-02-25 18:03:33] process terminated successfully, elapsed time: 02.20s
