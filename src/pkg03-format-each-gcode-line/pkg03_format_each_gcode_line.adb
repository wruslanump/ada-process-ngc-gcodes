-- File   : pkg03_format_each_gcode_line.adb
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
package body pkg03_format_each_gcode_line
-- ========================================================
--   with SPARK_Mode => on
is

   package ATIO renames Ada.Text_IO;
   package ASU  renames Ada.Strings.Unbounded;
   
   inp_fhandle : ATIO.File_Type;
   out_fhandle : ATIO.File_Type;
     
   -- =====================================================
   procedure exec_format_each_gcode_line
   -- =====================================================
   -- with SPARK_Mode => on
   is
      
   begin
      ATIO.New_Line;
      ATIO.Put_Line("Run PFEGL.format_each_gcode_line");
      
      ATIO.New_Line;
      
      
      
      
      
   end exec_format_each_gcode_line;
   -- ====================================================
   
   
  

-- =======================================================   
begin
  null;
-- ========================================================
end pkg03_format_each_gcode_line;
-- ========================================================    
