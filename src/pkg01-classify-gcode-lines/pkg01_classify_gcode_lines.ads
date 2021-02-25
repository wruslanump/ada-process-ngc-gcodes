-- File	: pkg01_classify_gcode_lines.ads
-- Date	: Thu 25 Feb 2021 01:51:47 PM +08
-- Author: WRY wruslandr@gmail.com
-- ========================================================
with Ada.Text_IO;

-- ========================================================
package pkg01_classify_gcode_lines 
-- ========================================================
--   with SPARK_Mode => on
is
   -- LIST OF PACKAGES RENAMED -- S for specification (.ads)
   package SATIO renames Ada.Text_IO; 
   
   -- LIST OF PROCEDURES
   procedure exec_classify_gcode_lines (inp_gcode_file : in String);
   procedure exec_tag_blank_line;
   
   -- LIST OF FUNCTIONS
      
-- ========================================================
end pkg01_classify_gcode_lines;
-- ========================================================    
   
  
     
