-- File   : pkg02_remove_comment_lines.adb
-- Date   : Thu 25 Feb 2021 01:51:47 PM +08
-- Author : WRY wruslandr@gmail.com
-- ========================================================

-- ADA STANDARD PACKAGES
with Ada.Text_IO;
with Ada.Numerics;

-- ADA STRING MANIPULATION
-- Ada has three(3) types of strings: 
-- fixed length, bounded length, unbounded.
with Ada.Strings;
with Ada.Strings.Fixed;
with Ada.Strings.Bounded;
with Ada.Strings.Unbounded;
with Ada.Strings.Unbounded.Text_IO;
with Ada.Command_Line;

-- WRY CREATED PACKAGES 
with pkg_ada_dtstamp;



-- ========================================================
package body pkg02_remove_comment_lines
-- ========================================================
--   with SPARK_Mode => on
is

   package ATIO renames Ada.Text_IO;
   package ASU  renames Ada.Strings.Unbounded;
   
     
   -- =====================================================
   procedure exec_read_display_file (inp_fmode   : in ATIO.File_Mode; inp_fname   : in String) 
   -- =====================================================
   -- with SPARK_Mode => on
   is
      
   begin
      ATIO.Put_Line("Run exec_read_display_file (inp_fmode, inp_fname)");
      ATIO.Put_Line("inp_fmode = ATIO.In_File ");
      ATIO.Put_Line("inp_fname = " & (inp_fname));
      
      
   end exec_read_display_file;
   -- ====================================================
   
   
  

-- =======================================================   
begin
  null;
-- ========================================================
end pkg02_remove_comment_lines;
-- ========================================================    
