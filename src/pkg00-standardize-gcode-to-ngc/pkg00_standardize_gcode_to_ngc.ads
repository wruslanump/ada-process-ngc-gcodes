-- File   : pkg00_standardize_gcode_to_ngc.ads
-- Date   : Sat 27 Feb 2021 05:19:56 PM +08
-- Author : WRY wruslandr@gmail.com
-- ========================================================
with Ada.Text_IO;
with Ada.Strings.Unbounded;

-- ========================================================
package pkg00_standardize_gcode_to_ngc
-- ========================================================
--   with SPARK_Mode => on
is
   -- LIST OF PACKAGES RENAMED -- S for specification (.ads)
   package SATIO renames Ada.Text_IO;
   package SASU  renames Ada.Strings.Unbounded;
   
   -- LIST OF PROCEDURES
   procedure exec_standardize_gcode_to_ngc (inp_gcode_fname : in String); 
   procedure exec_replace_uppercase_all_chars (inp_UBfname, out_gcode_file_01 : in SASU.Unbounded_String);
   procedure exec_remove_whitespace_each_line (out_gcode_file_01, out_gcode_file_02 : in SASU.Unbounded_String);
   
   -- LIST OF FUNCTIONS
      
-- ========================================================
end pkg00_standardize_gcode_to_ngc;
-- ========================================================    
    
