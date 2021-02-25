-- File   : pkg03_process_gcode_line.ads
-- Date   : Thu 25 Feb 2021 01:51:47 PM +08
-- Author : WRY wruslandr@gmail.com
-- ========================================================
with Ada.Text_IO;

-- ========================================================
package pkg03_process_gcode_line
-- ========================================================
--   with SPARK_Mode => on
is
   -- LIST OF PACKAGES RENAMED -- S for specification (.ads)
   package SATIO renames Ada.Text_IO; 
   
   -- LIST OF PROCEDURES
   procedure exec_read_display_file (inp_fmode : in SATIO.File_Mode; inp_fname : in String); 
   
   
   -- LIST OF FUNCTIONS
      
-- ========================================================
end pkg03_process_gcode_line;
-- ========================================================    
    
