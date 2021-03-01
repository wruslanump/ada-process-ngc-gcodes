-- File   : pkg20_classify_each_gcode_line.adb
-- Date   : Thu 25 Feb 2021 01:51:47 PM +08
-- Author : WRY wruslandr@gmail.com
-- ========================================================

-- REF : http://www.linuxcnc.org/docs/html/gcode/g-code.html NGC

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
package body pkg20_classify_each_gcode_line
-- ========================================================
--   with SPARK_Mode => on
is

   package ATIO  renames Ada.Text_IO;
   package ASU   renames Ada.Strings.Unbounded;
   package PADTS renames pkg_ada_dtstamp;
   
   -- PACKAGE-WIDE VARIABLES
   inp_UBfname :  ASU.Unbounded_String;
      
   
   -- =====================================================
   procedure exec20_classify_each_gcode_line (inp_gcode_file : in String)
   -- =====================================================
   -- with SPARK_Mode => on
   is
      
   begin
      null;
     
           
   end exec20_classify_each_gcode_line;
   
   -- =====================================================
   procedure exec_scan_tag_blank_line
   -- =====================================================
   -- with SPARK_Mode => on
   is
      
      
   begin
             null;
   
   end exec_scan_tag_blank_line;
   -- ====================================================

-- =======================================================   
begin
  null;
-- ========================================================
end pkg20_classify_each_gcode_line;
-- ========================================================    
