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

with pkg00_standardize_gcode_to_ngc;
with pkg01_classify_each_gcode_line;
with pkg02_remove_comment_blank_lines;
with pkg03_format_each_gcode_line;

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
   -- package PAR     renames pkg_ada_random;
   -- package PARDF   renames pkg_ada_read_display_file;
   -- package PARWF   renames pkg_ada_read_write_file;
   -- package PAWDF   renames pkg_ada_write_display_file;
   
   package PSGTN    renames pkg00_standardize_gcode_to_ngc;
   package PCEGL    renames pkg01_classify_each_gcode_line;
   package PRCBL    renames pkg02_remove_comment_blank_lines;
   package PFEGL    renames pkg03_format_each_gcode_line;
  
   
   
   -- =======================================================
   -- GENERIC FILE VARIABLES
   -- =======================================================
   -- REF : http://www.linuxcnc.org/docs/html/gcode/g-code.html 
   -- Note: must translate other g-code formats to standardized ngc
   -- Then find and replace. Examples: G0 to G01, G1 to G01 etc
   
   inp_gcode_file_01 : String := "files/bismillah.ngc";
   inp_gcode_file_02 : String := "files/just-KSG.ngc";
   inp_gcode_file_03 : String := "files/butterfly.nc";
   inp_gcode_file_04 : String := "files/linuxcnc-logo.nc";  
   
-- ========================================================  
begin
   
   PADTS.dtstamp; ATIO.Put_Line ("Bismillah 3 times WRY");
   PADTS.dtstamp; ATIO.Put_Line ("Running inside GNAT Studio Community");
   ATIO.New_Line;
   -- ====================================================== 
   -- PACKAGE-00 -- STANDARDIZE GCODE TO NGC FORMATTED FILES
   PSGTN.exec_standardize_gcode_to_ngc (inp_gcode_file_01);
   
   
   -- PACKAGE-01 -- NGC FILES
   -- PCEGL.exec_classify_each_gcode_line (inp_gcode_file1);
   -- PCEGL.exec_classify_each_gcode_line (inp_gcode_file2);
   
   -- NC FILES (Other Formats)
   -- PCEGL.exec_classify_each_gcode_line ("files/butterfly.nc");
   -- PCEGL.exec_classify_each_gcode_line ("files/linuxcnc-logo.nc");
   
   -- PACKAGE-02
   -- PRCBL.exec_remove_comment_blank_lines ("files/out_gcode_file_01.txt");
   
   -- PACKAGE-03 (TO DO)
   -- PFEGL.exec_format_each_gcode_line; 
     
   -- =====================================================
   ATIO.New_Line; PADTS.dtstamp; ATIO.Put_Line ("Alhamdulillah 3 times WRY");
-- ========================================================   
end main_ada_process_ngc_gcodes;
-- ========================================================

