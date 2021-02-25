-- File   : pkg01_classify_gcode_lines.adb
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
package body pkg01_classify_gcode_lines
-- ========================================================
--   with SPARK_Mode => on
is

   package ATIO  renames Ada.Text_IO;
   package ASU   renames Ada.Strings.Unbounded;
   package PADTS renames pkg_ada_dtstamp;
   
   inp_fhandle, out_fhandle : ATIO.File_Type;    
   
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
   lineNotBlank : Integer := 0;
   lineComment  : Integer := 0;
   
   firstChar       : String  := "1";
   first3Chars     : String  := "123"; --DUMMY
   
   countG    : Integer := 0;
   countG00  : Integer := 0; 
   countG01  : Integer := 0;
   countG02  : Integer := 0;
   countG03  : Integer := 0;
   countG21  : Integer := 0;
   countHash : Integer := 0;
   
   -- =====================================================
   procedure exec_classify_gcode_lines (inp_gcode_file : in String)
   -- =====================================================
   -- with SPARK_Mode => on
   is
      
   begin
      ATIO.Put_Line("Run exec_read_display_file (inp_gcode_file)");
      ATIO.Put_Line("inp_gcode_file = " & (inp_gcode_file));
      ATIO.New_Line;
      
      ATIO.Open   (inp_fhandle, ATIO.In_File,  inp_gcode_file);
      ATIO.Create (out_fhandle, ATIO.Out_File, "files/out_gcode_file01.txt");
      exec_tag_blank_line;  -- Call internal procedure
      
      ATIO.Close (inp_fhandle);
      ATIO.Close (out_fhandle);
      PADTS.exec_delay_sec (2); -- Ensure finish file closing.
           
   end exec_classify_gcode_lines;
   -- ====================================================
   
   -- =====================================================
   procedure exec_tag_blank_line
   -- =====================================================
   -- with SPARK_Mode => on
   is
      
   begin
      
      curr_lenUBlineStr  := 1;
      max_lenUBlineStr  := 1;
      lineCount         := 0;
      lineTagged        := 0;
      lineBlank    := 0;
      lineNotBlank := 0; 
      lineComment  := 0;
      
      countG    := 0;
      countG00  := 0; 
      countG01  := 0;
      countG02  := 0;
      countG03  := 0;
      countG21  := 0;
      countHash := 0;
      lineClassified    := 0;
      lineNotClassified := 0;  
      
      -- ==================================================
      while not ATIO.End_Of_File (inp_fhandle) loop
         inp_UBlineStr := ASU.To_Unbounded_String(ATIO.Get_Line (inp_fhandle));
         
         lineCount    := lineCount + 1;
         curr_lenUBlineStr := ASU.Length (inp_UBlineStr);
         if curr_lenUBlineStr > max_lenUBlineStr then 
            max_lenUBlineStr := curr_lenUBlineStr;
         end if;  
         
         if curr_lenUBlineStr = 0 then
            lineBlank := lineBlank + 1;
            
            -- Write line to terminal
            ATIO.Put_Line ("(Blank Line) LINETAG" & Integer'Image(lineCount));
            -- Write line to output file
            ATIO.Put_Line (out_fhandle, "(Blank Line) LINETAG" & Integer'Image(lineCount));
         else 
            lineNotBlank := lineNotBlank + 1; 
            -- Write line to terminal
            ATIO.Put_Line (ASU.To_String (inp_UBlineStr)); 
            -- Write line to output file
            ATIO.Put_Line (out_fhandle, ASU.To_String (inp_UBlineStr)); 
                 
         end if;   
         
         lineTagged := lineTagged + 1;
             
      end loop; 
      
      ATIO.Set_Output(ATIO.Standard_Output);
      ATIO.Put_Line ("=======================================================");
      ATIO.Put_Line ("LINE ACCOUNTING AND CLASSIFICATION SUMMARY ");
      ATIO.Put_Line ("=======================================================");  
      ATIO.Put_Line ("lineCount        = " & Integer'Image(lineCount));
      ATIO.Put_Line ("max_lenUBlineStr = " & Natural'Image(max_lenUBlineStr));
      ATIO.Put_Line ("lineBlank        = " & Integer'Image(lineBlank));
      ATIO.Put_Line ("lineNotBlank     = " & Integer'Image(lineNotBlank));
      ATIO.Put_Line ("lineTagged       = " & Integer'Image(lineTagged));
      ATIO.Put_Line ("Curr File Output = " & "files/out_gcode_file01.txt");
      
      ATIO.Set_Output(out_fhandle);
      ATIO.Put_Line ("=======================================================");
      ATIO.Put_Line ("LINE ACCOUNTING AND CLASSIFICATION SUMMARY");
      ATIO.Put_Line ("=======================================================");  
      ATIO.Put_Line ("lineCount        = " & Integer'Image(lineCount));
      ATIO.Put_Line ("max_lenUBlineStr = " & Natural'Image(max_lenUBlineStr));
      ATIO.Put_Line ("lineBlank        = " & Integer'Image(lineBlank));
      ATIO.Put_Line ("lineNotBlank     = " & Integer'Image(lineNotBlank));
      ATIO.Put_Line ("lineTagged       = " & Integer'Image(lineTagged));
      ATIO.Put_Line ("Curr File Output = " & "files/out_gcode_file01.txt");
      
      ATIO.Set_Output(ATIO.Standard_Output);
      
   end exec_tag_blank_line;
   -- ====================================================
  

-- =======================================================   
begin
  null;
-- ========================================================
end pkg01_classify_gcode_lines;
-- ========================================================    
