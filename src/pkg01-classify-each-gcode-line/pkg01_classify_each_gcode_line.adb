-- File   : pkg01_classify_each_gcode_line.adb
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
package body pkg01_classify_each_gcode_line
-- ========================================================
--   with SPARK_Mode => on
is

   package ATIO  renames Ada.Text_IO;
   package ASU   renames Ada.Strings.Unbounded;
   package PADTS renames pkg_ada_dtstamp;
   
   input_gcode_file  : ASU.Unbounded_String; 
   inp_fhandle : ATIO.File_Type; 
   out_fhandle : ATIO.File_Type;    
      
   -- NOTE: two subtypes of type Integer: 
   -- Natural is an Integer which cannot be less than zero, 
   -- Positive is an Integer which cannot be less than 1.
   
   inp_UBlineStr     : ASU.Unbounded_String;
   curr_lenUBlineStr : Natural := 1;
   max_lenUBlineStr  : Natural := 1;
   
   lineCount         : Integer := 999;
   lineTagged        : Integer := 999;
   lineClassified    : Integer := 999;
   lineNotClassified : Integer := 999;  
   lineBlank    : Integer := 0;
   lineControl  : Integer := 0;
   lineNotBlank : Integer := 0;
   lineComment  : Integer := 0;
   
   -- =====================================================
   procedure exec_classify_each_gcode_line (inp_gcode_file : in String)
   -- =====================================================
   -- with SPARK_Mode => on
   is
      
   begin
      
      -- Make input file name global package-wise
      input_gcode_file := ASU.To_Unbounded_String(inp_gcode_file); 
      
      ATIO.Open   (inp_fhandle, ATIO.In_File,  ASU.To_String(input_gcode_file));
      ATIO.Create (out_fhandle, ATIO.Out_File, "files/out_gcode_file_01.txt");
      
      -- Call internal procedure
      exec_scan_tag_blank_line;  
      
      ATIO.Close (inp_fhandle);
      ATIO.Close (out_fhandle);
      PADTS.exec_delay_sec (2); -- Ensure finish file closing.
           
   end exec_classify_each_gcode_line;
   
   -- =====================================================
   procedure exec_scan_tag_blank_line
   -- =====================================================
   -- with SPARK_Mode => on
   is
      out_FHReport_01 : ATIO.File_Type;
      
   begin
      curr_lenUBlineStr := 1; -- Natural
      max_lenUBlineStr  := 1;
      lineCount    := 0;
      lineTagged   := 0;
      lineBlank    := 0;
      lineControl  := 0;
      lineNotBlank := 0; 
              
      -- ==================================================
      while not ATIO.End_Of_File (inp_fhandle) loop
         inp_UBlineStr := ASU.To_Unbounded_String(ATIO.Get_Line (inp_fhandle));
         
         lineCount    := lineCount + 1;
         
         curr_lenUBlineStr := ASU.Length (inp_UBlineStr);
         if curr_lenUBlineStr > max_lenUBlineStr then 
            max_lenUBlineStr := curr_lenUBlineStr;
         end if;  
         
         if (curr_lenUBlineStr) = 0 then
            lineBlank := lineBlank + 1;
            -- ATIO.Put_Line ("(Blank Line) LINETAG" & Integer'Image(lineCount));
            ATIO.Put_Line (out_fhandle, "(Blank Line) LINETAG" & Integer'Image(lineCount));
         elsif (curr_lenUBlineStr) = 1 then
            ATIO.Put_Line (out_fhandle, ASU.To_String (inp_UBlineStr) & " Control");
            lineControl := lineControl + 1;
         elsif (curr_lenUBlineStr) = 2 then
            ATIO.Put_Line (out_fhandle, ASU.To_String (inp_UBlineStr) & " Control");
            lineControl := lineControl + 1;
         else 
            lineNotBlank := lineNotBlank + 1; 
            -- ATIO.Put_Line (ASU.To_String (inp_UBlineStr)); 
            ATIO.Put_Line (out_fhandle, ASU.To_String (inp_UBlineStr)); 
                 
         end if;   
         
         lineTagged := lineTagged + 1;
             
      end loop; 
      
      ATIO.Set_Output(ATIO.Standard_Output);
      ATIO.Put_Line ("=======================================================");
      ATIO.Put_Line ("1. LINE ACCOUNTING (pkg01 classify gcode lines) ");
      ATIO.Put_Line ("======================================================="); 
      ATIO.Put_Line ("Curr File Input  = " & ASU.To_String(input_gcode_file));
      ATIO.New_Line;
      ATIO.Put_Line ("lineCount        = " & Integer'Image(lineCount));
      ATIO.Put_Line ("max_lenUBlineStr = " & Natural'Image(max_lenUBlineStr));
      ATIO.Put_Line ("lineBlank        = " & Integer'Image(lineBlank));
      ATIO.Put_Line ("lineControl      = " & Integer'Image(lineControl));
      ATIO.Put_Line ("lineNotBlank     = " & Integer'Image(lineNotBlank));
      ATIO.Put_Line ("lineTagged       = " & Integer'Image(lineTagged));
      ATIO.New_Line;
      ATIO.Put_Line ("Curr File Output = " & "files/out_gcode_file_01.txt");
      ATIO.Put ("("); PADTS.dtstamp; ATIO.Put_line("finished execution.)"); 
      ATIO.New_Line;
      
      -- WRITE TO FILE ====================================
      ATIO.Create (out_FHReport_01, ATIO.Out_File, "files/out_FHReport_01.txt");
      
      ATIO.Set_Output(out_FHReport_01);
      ATIO.Put_Line ("(=======================================================");
      ATIO.Put_Line ("(1. LINE ACCOUNTING (pkg01 classify gcode lines)");
      ATIO.Put_Line ("(======================================================="); 
      ATIO.Put_Line ("(Curr File Input  = " & ASU.To_String(input_gcode_file));
      ATIO.Put_Line ("(");
      ATIO.Put_Line ("(lineCount        = " & Integer'Image(lineCount));
      ATIO.Put_Line ("(max_lenUBlineStr = " & Natural'Image(max_lenUBlineStr));
      ATIO.Put_Line ("(lineBlank        = " & Integer'Image(lineBlank));
      ATIO.Put_Line ("(lineControl      = " & Integer'Image(lineControl));
      ATIO.Put_Line ("(lineNotBlank     = " & Integer'Image(lineNotBlank));
      ATIO.Put_Line ("(lineTagged       = " & Integer'Image(lineTagged));
      ATIO.Put_Line ("(");
      ATIO.Put_Line ("(Curr File Output = " & "files/out_gcode_file_01.txt");
      ATIO.Put ("("); PADTS.dtstamp; ATIO.Put_line("finished execution.)"); 
      
      ATIO.Close (out_FHReport_01);
      PADTS.exec_delay_sec (2); -- Ensure finish file closing.
      
      ATIO.Set_Output(ATIO.Standard_Output);
      
   end exec_scan_tag_blank_line;
   -- ====================================================

-- =======================================================   
begin
  null;
-- ========================================================
end pkg01_classify_each_gcode_line;
-- ========================================================    
