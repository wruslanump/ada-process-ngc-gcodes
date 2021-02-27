-- File	: pkg20_classify_each_gcode_line.ads
-- Date	: Thu 25 Feb 2021 01:51:47 PM +08
-- Author: WRY wruslandr@gmail.com
-- ========================================================
with Ada.Text_IO;

-- ========================================================
package pkg20_classify_each_gcode_line 
-- ========================================================
--   with SPARK_Mode => on
is
   -- LIST OF PACKAGES RENAMED -- S for specification (.ads)
   package SATIO renames Ada.Text_IO; 
   
   -- LIST OF PROCEDURES
   procedure exec20_classify_each_gcode_line (inp_gcode_file : in String);
   procedure exec_scan_tag_blank_line;
   
   -- LIST OF FUNCTIONS
      
-- ========================================================
end pkg20_classify_each_gcode_line;
-- ========================================================    
 
     
