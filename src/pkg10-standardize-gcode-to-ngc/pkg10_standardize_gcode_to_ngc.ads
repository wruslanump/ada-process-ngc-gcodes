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
   procedure exec11_replace_uppercase_all_chars (inp_UBfname, out_UBfname : in SASU.Unbounded_String);
   procedure exec12_remove_whitespace_each_line (inp_UBfname, out_UBfname : in SASU.Unbounded_String);
   
   -- LIST OF FUNCTIONS
      
-- ========================================================
end pkg10_standardize_gcode_to_ngc;
-- ========================================================    
    
