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
   inp_fmode   : ATIO.File_Mode  := ATIO.In_File;
   inp_fname   : String          := "files/bismillah.ngc";
   -- inp_fname   : String         := "files/just-KSG.ngc";
   
   out_fmode   : ATIO.File_Mode  := ATIO.Out_File;
   out_fname   : String          := "files/write_bismillah.txt";
   -- out_fname   : String          := "files/write_just_KSG.txt";
   
   app_fmode   : ATIO.File_Mode  := ATIO.Append_File;
   app_fname   : String          := "files/append_session_01.txt";  
   
   write_fmode : ATIO.File_Mode  := ATIO.Out_File;
   write_fname : String          := "files/random_integers_floats.txt";
     
-- ========================================================  
begin
   
   PADTS.dtstamp; ATIO.Put_Line ("Bismillah 3 times WRY");
   PADTS.dtstamp; ATIO.Put_Line ("Running inside GNAT Studio Community");
   ATIO.New_Line;
   
   -- PARDF.exec_read_display_file (inp_fmode, inp_fname);
   -- PARWF.exec_read_write_file (inp_fmode, inp_fname, out_fmode, out_fname);
   -- PAWDF.exec_write_display_file (write_fmode, write_fname);
   
   PCGL.exec_read_display_file (inp_fmode, inp_fname);  
   PRCL.exec_read_display_file (inp_fmode, inp_fname);  
   PPGL.exec_read_display_file (inp_fmode, inp_fname);  
   
   -- =====================================================
            
   ATIO.New_Line; PADTS.dtstamp; ATIO.Put_Line ("Alhamdulillah 3 times WRY");
-- ========================================================   
end main_ada_process_ngc_gcodes;
-- ========================================================

