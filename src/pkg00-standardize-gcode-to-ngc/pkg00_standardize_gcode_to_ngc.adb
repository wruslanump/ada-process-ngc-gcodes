-- File   : pkg00_standardize_gcode_to_ngc.adb
-- Date   : Thu 25 Feb 2021 01:51:47 PM +08
-- Author : WRY wruslandr@gmail.com
-- ========================================================

-- ADA STANDARD PACKAGES
with Ada.Text_IO;
with Ada.Strings.Unbounded;

-- WRY CREATED PACKAGES 
with pkg_ada_dtstamp;



-- ========================================================
package body pkg00_standardize_gcode_to_ngc
-- ========================================================
--   with SPARK_Mode => on
is

   package ATIO renames Ada.Text_IO;
   package ASU  renames Ada.Strings.Unbounded;
   
   -- VARIABLES WITH PACKAGE-WISE ACCESS
   inp_UBfname : ASU.Unbounded_String; 
   out_UBfname : ASU.Unbounded_String; 
   
   out_gcode_file_11 : String := "files/out_gcode_file_11.txt"; 
   out_gcode_file_12 : String := "files/out_gcode_file_12.txt";   
     
   -- =====================================================
   procedure exec_standardize_gcode_to_ngc (inp_gcode_fname : in String)
   -- =====================================================
   -- with SPARK_Mode => on
   is
      
   begin
      ATIO.New_Line;
      ATIO.Put_Line("Start PSGTN.exec_standardize_gcode_to_ngc (" & inp_gcode_fname & ")");
      ATIO.New_Line;
      
      -- (1) Call internal procedure
      inp_UBfname := ASU.To_Unbounded_String (inp_gcode_fname);
      out_UBfname := ASU.To_Unbounded_String (out_gcode_file_11);
      -- Check input and output file names
      ATIO.Put_Line ("PSGTN internal (1): exec_replace_uppercase_all_chars (input, output):");
      ATIO.Put_Line ("input  = " & ASU.To_String (inp_UBfname));
      ATIO.Put_Line ("output = " & ASU.To_String (out_UBfname));
      -- Execute after check 
      exec_replace_uppercase_all_chars (inp_UBfname, out_UBfname);
      ATIO.New_Line;
      
      -- (2) Call internal procedure
      -- ==================================================
      inp_UBfname := out_UBfname;
      out_UBfname := ASU.To_Unbounded_String (out_gcode_file_12);
      -- Check input and output file names
      ATIO.Put_Line ("PSGTN internal (2): exec_remove_whitespace_each_line (input, output):");
      ATIO.Put_Line ("input  = " & ASU.To_String (inp_UBfname));
      ATIO.Put_Line ("output = " & ASU.To_String (out_UBfname));
      -- Execute after check               
      exec_remove_whitespace_each_line (inp_UBfname, out_UBfname);
      ATIO.New_Line;
   
      ATIO.Put_Line("End PSGTN.exec_standardize_gcode_to_ngc (" & inp_gcode_fname & ")");
      ATIO.New_Line;
         
   end exec_standardize_gcode_to_ngc;
   -- =====================================================
   procedure exec_replace_uppercase_all_chars (inp_UBfname, out_gcode_file_01 : in SASU.Unbounded_String)
   -- =====================================================
   -- with SPARK_Mode => on
   is
      
   begin
      null;
      
      
      
   end exec_replace_uppercase_all_chars;
   -- ====================================================
   procedure exec_remove_whitespace_each_line (out_gcode_file_01, out_gcode_file_02 : in SASU.Unbounded_String)
   -- ====================================================  
   -- with SPARK_Mode => on
   is
      
   begin
      null;
      
      
   end exec_remove_whitespace_each_line;
-- =======================================================   
begin
  null;
-- ========================================================
end pkg00_standardize_gcode_to_ngc;
-- ========================================================    
