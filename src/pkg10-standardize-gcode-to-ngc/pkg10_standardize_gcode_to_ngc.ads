-- File   : pkg10_standardize_gcode_to_ngc.ads
-- Date   : Sat 27 Feb 2021 05:19:56 PM +08
-- Author : WRY wruslandr@gmail.com
-- ========================================================
with Ada.Text_IO;
with Ada.Strings.Unbounded;

-- ========================================================
package pkg10_standardize_gcode_to_ngc
-- ========================================================
--   with SPARK_Mode => on
is
   -- LIST OF PACKAGES RENAMED -- S for specification (.ads)
   package SATIO renames Ada.Text_IO;
   package SASU  renames Ada.Strings.Unbounded;
   
   -- LIST OF PROCEDURES
   procedure exec10_standardize_gcode_to_ngc (inp_gcode_fname : in String); 
   procedure exec11_replace_uppercase_all_chars (inp_UBfname, out_UBfname :    in SASU.Unbounded_String);
   procedure exec12_remove_whitespace_each_line (inp_UBfname, out_UBfname :    in SASU.Unbounded_String);
   procedure exec13_remove_comment_and_blank_lines (inp_UBfname, out_UBfname : in SASU.Unbounded_String);
   
   -- APPENDED ACTIVITIES TO REPORT FILE
   procedure exec_report_pkg10_standardize_gcode_to_ngc (app_report_pkg10 : in String);
   procedure exec_report_out_gcode_textfile_10 (report_gcode_textfile_10 : in String);
   procedure exec_report_out_gcode_textfile_11 (report_gcode_textfile_11 : in String);
   procedure exec_report_out_gcode_textfile_12 (report_gcode_textfile_12 : in String);
   procedure exec_report_out_gcode_textfile_13 (report_gcode_textfile_13 : in String);
  
   
   
   -- LIST OF FUNCTIONS
      
-- ========================================================
end pkg10_standardize_gcode_to_ngc;
-- ========================================================    
    
