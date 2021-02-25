-- File   : pkg02_remove_comment_lines.ads
-- Date   : Thu 25 Feb 2021 01:51:47 PM +08
-- Author : WRY wruslandr@gmail.com
-- ========================================================
with Ada.Text_IO;

-- ========================================================
package pkg02_remove_comment_lines
-- ========================================================
--   with SPARK_Mode => on
is
   -- LIST OF PACKAGES RENAMED -- S for specification (.ads)
   package SATIO renames Ada.Text_IO; 
   
   -- LIST OF PROCEDURES
   procedure exec_remove_comment_lines(inp_fname : in String);
   procedure exec_remove_comment_and_blank_lines;
   
   -- LIST OF FUNCTIONS
      
-- ========================================================
end pkg02_remove_comment_lines;
-- ========================================================    
   
  
     
