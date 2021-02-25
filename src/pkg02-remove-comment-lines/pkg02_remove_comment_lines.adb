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
   package PADTS renames pkg_ada_dtstamp;
   
   -- PACKAGE GLOBAL VARIABLES
   inp_fhandle, out_fhandle : ATIO.File_Type;
   
   lineCount         : Integer    := 0;
   inp_UBlineStr     : ASU.Unbounded_String; -- Initialization not needed
   lineRemoved       : Integer := 0;
   lineRemaining     : Integer := 0;
   
   firstChar         : String  := "1";         -- DUMMY
   first2Chars       : String  := "12";        -- DUMMY
   first3Chars       : String  := "123";       -- DUMMY
   
   
      
   -- =====================================================
   procedure exec_remove_comment_lines(inp_fname : in String)
   -- =====================================================
   -- with SPARK_Mode => on
   is
      
   begin
      
      -- STEP 1
      ATIO.Open   (inp_fhandle, ATIO.In_File,  "files/out_gcode_file_01.txt");
      ATIO.Create (out_fhandle, ATIO.Out_File, "files/out_gcode_file_02.txt");
      
      -- Call internal procedure
      exec_remove_comment_and_blank_lines;  
            
      ATIO.Close (inp_fhandle);
      ATIO.Close (out_fhandle);
      PADTS.exec_delay_sec (2); -- Ensure finish file closing.
      
      -- STEP 2
      ATIO.Open (inp_fhandle, ATIO.In_File, "files/out_gcode_file_02.txt");
      
      -- Call internal procedure
      exec_display_gcode_categories;
      
      ATIO.Close (inp_fhandle);
      PADTS.exec_delay_sec (2); -- Ensure finish file closing.
      
   end exec_remove_comment_lines;
   -- =====================================================
   procedure exec_remove_comment_and_blank_lines
   -- =====================================================
   -- with SPARK_Mode => on
   is
      out_FHReport_02 : ATIO.File_Type;
      
   begin
      lineCount   := 0;
      lineRemoved := 0;
      lineRemaining := 0;
   -- ==================================================
      while not ATIO.End_Of_File (inp_fhandle) loop
         inp_UBlineStr := ASU.To_Unbounded_String(ATIO.Get_Line (inp_fhandle));
         lineCount := LineCount + 1;
                 
         firstChar   := ASU.To_String (ASU.Unbounded_Slice(inp_UBlineStr, 1, 1));
         
         -- Note: character ( applies to both comments and blank lines
         if (firstChar = "(") then
            lineRemoved := lineRemoved + 1;
            -- ATIO.Put_Line ("Removed lineCount = " & Integer'Image(lineCount));
         else
            lineRemaining :=  lineRemaining + 1;            
            -- ATIO.Put_Line (ASU.To_String (inp_UBlineStr));             
            ATIO.Put_Line (out_fhandle, ASU.To_String (inp_UBlineStr)); 
         end if;
         
      end loop;
      
      ATIO.Set_Output(ATIO.Standard_Output);
      ATIO.Put_Line ("=======================================================");
      ATIO.Put_Line ("2. LINE ACCOUNTING (pkg02 remove comment lines) ");
      ATIO.Put_Line ("======================================================="); 
      ATIO.Put_Line ("Curr File Input  = " & "files/out_gcode_file_01.txt");
      ATIO.New_Line; 
      ATIO.Put_Line ("lineCount        = " & Integer'Image(lineCount));
      ATIO.Put_Line ("lineRemoved      = " & Integer'Image(lineRemoved));
      ATIO.Put_Line ("lineRemaining    = " & Integer'Image(lineRemaining));
      
      ATIO.Create (out_FHReport_02, ATIO.Out_File, "files/out_FHReport_02.txt");
      
      ATIO.Set_Output (out_FHReport_02);
      ATIO.Put_Line ("=======================================================");
      ATIO.Put_Line ("2. LINE ACCOUNTING (pkg02 remove comment lines) ");
      ATIO.Put_Line ("======================================================="); 
      ATIO.Put_Line ("Curr File Input  = " & "files/out_gcode_file_01.txt");
      ATIO.New_Line; 
      ATIO.Put_Line ("lineCount        = " & Integer'Image(lineCount));
      ATIO.Put_Line ("lineRemoved      = " & Integer'Image(lineRemoved));
      ATIO.Put_Line ("lineRemaining    = " & Integer'Image(lineRemaining));  
     
      ATIO.Close (out_FHReport_02);
      PADTS.exec_delay_sec (2); -- Ensure finish file closing.
      
      ATIO.Set_Output (ATIO.Standard_Output);
      
      
   end exec_remove_comment_and_blank_lines;   
   -- =====================================================
   procedure exec_display_gcode_categories
   -- =====================================================
   -- with SPARK_Mode => on
   is
      count_Percent : Integer := 0;
      count_Hash  : Integer := 0; -- (Numeric scaling factors)
      count_MCode : Integer := 0;
      count_GCode : Integer := 0;
      sum_AllCodes : Integer := 0;
      
      count_M1 : Integer := 0;
      count_M2 : Integer := 0;
      count_M3 : Integer := 0;
      count_M4 : Integer := 0;
      count_M5 : Integer := 0;
      sum_MX : Integer := 0;
      
      count_G00 : Integer := 0; -- (rapid linear move)
      count_G01 : Integer := 0; -- (linear move)
      count_G02 : Integer := 0; -- (clockwise arc move) 
      count_G03 : Integer := 0; -- (counter-clockwise arc move)
      count_G21 : Integer := 0; -- (G21 - All units in mm)
      sum_GXX   : Integer := 0;
      
      out_FHReport_02 : ATIO.File_Type;
      
   begin
      
      lineCount := 0;
            
      while not ATIO.End_Of_File (inp_fhandle) loop
         inp_UBlineStr := ASU.To_Unbounded_String(ATIO.Get_Line (inp_fhandle));
         lineCount := LineCount + 1;
       
         firstChar   := ASU.To_String (ASU.Unbounded_Slice (inp_UBlineStr, 1, 1));
         first2Chars := ASU.To_String (ASU.Unbounded_Slice (inp_UBlineStr, 1, 2));
         first3Chars := ASU.To_String (ASU.Unbounded_Slice (inp_UBlineStr, 1, 3));
        
         -- FOR FIRST 2 CHARACTERS
         if (firstChar = "%") then
            count_Percent := count_Percent + 1;
         elsif (firstChar = "#") then
            count_Hash := count_Hash + 1;
         elsif (firstChar = "M") then
            count_MCode := count_MCode +1;
         elsif (firstChar = "G") then
            count_GCode := count_GCode +1;
         else
            ATIO.Put_Line("Error. firstChar = " & (firstChar) & " not captured.");
         end if;
         
         -- FOR FIRST 2 CHARACTERS
         if (first2Chars = "M1") then
            count_M1 := count_M1 + 1;
         elsif (first2Chars = "M2") then
            count_M2 := count_M2 + 1;
         elsif (first2Chars = "M3") then
            count_M3 := count_M3 + 1;   
         elsif (first2Chars = "M4") then
            count_M4 := count_M4 + 1;
         elsif (first2Chars = "M5") then
            count_M5 := count_M5 + 1;   
         -- else
            -- ATIO.Put_Line("Error. first2Chars = " & (first2Chars) & " not captured.");
         end if;         
      
         -- FOR FIRST 3 CHARACTERS
         if    (first3Chars = "G00") then
            count_G00 := count_G00 + 1;
      
         elsif (first3Chars = "G01") then
            count_G01 := count_G01 + 1;
      
         elsif (first3Chars = "G02") then
            count_G02 := count_G02 + 1;
            
         elsif (first3Chars = "G03") then
            count_G03 := count_G03 + 1;
      
         elsif (first3Chars = "G21") then
            count_G21 := count_G21 + 1;
      
         -- else
            -- ATIO.Put_Line("Error. inp_first3Chars = " & (first3Chars) & " not captured.");
         end if;      
         
         
         
      end loop;   
      
      ATIO.Set_Output(ATIO.Standard_Output);
      -- ==================================================
      ATIO.New_Line;
      ATIO.Put_Line ("count_Percent    = " & Integer'Image(count_Percent));
      ATIO.Put_Line ("count_Hash       = " & Integer'Image(count_Hash));
      ATIO.Put_Line ("count_MCode      = " & Integer'Image(count_MCode));
      ATIO.Put_Line ("count_GCode      = " & Integer'Image(count_GCode));
      
      sum_AllCodes := count_Percent + count_Hash + count_MCode + count_GCode;
      ATIO.Put_Line ("sum_AllCodes     = " & Integer'Image(sum_AllCodes));
      ATIO.New_Line;
      
      ATIO.Put_Line ("count_M1         = " & Integer'Image(count_M1));
      ATIO.Put_Line ("count_M2         = " & Integer'Image(count_M2));
      ATIO.Put_Line ("count_M3         = " & Integer'Image(count_M3));
      ATIO.Put_Line ("count_M4         = " & Integer'Image(count_M4));
      ATIO.Put_Line ("count_M5         = " & Integer'Image(count_M5));
     
      sum_MX := count_M1 + count_M2 + count_M3 + count_M4 + count_M5;
      ATIO.Put_Line ("sum_MX           = " & Integer'Image(sum_MX));
      ATIO.New_Line;
      
      ATIO.Put_Line ("count_G00        = " & Integer'Image(count_G00));
      ATIO.Put_Line ("count_G01        = " & Integer'Image(count_G01));
      ATIO.Put_Line ("count_G02        = " & Integer'Image(count_G02));
      ATIO.Put_Line ("count_G03        = " & Integer'Image(count_G03));
      ATIO.Put_Line ("count_G21        = " & Integer'Image(count_G21));
      
      sum_GXX := count_G00 + count_G01 + count_G02 + count_G03 + count_G21;
      ATIO.Put_Line ("sum_GXX          = " & Integer'Image(sum_GXX));
      ATIO.New_Line;
      
      ATIO.Put_Line ("Curr File Output = " & "files/out_gcode_file_02.txt");
      ATIO.Put ("("); PADTS.dtstamp; ATIO.Put_line("finished execution.)"); 
      
      -- WRITE TO FILE
      -- =====================================================
      ATIO.Open (out_FHReport_02, ATIO.Append_File, "files/out_FHReport_02.txt");
      
      ATIO.Set_Output (out_FHReport_02);
       -- ==================================================
      ATIO.New_Line;
      ATIO.Put_Line ("count_Percent    = " & Integer'Image(count_Percent));
      ATIO.Put_Line ("count_Hash       = " & Integer'Image(count_Hash));
      ATIO.Put_Line ("count_MCode      = " & Integer'Image(count_MCode));
      ATIO.Put_Line ("count_GCode      = " & Integer'Image(count_GCode));
      
      sum_AllCodes := count_Percent + count_Hash + count_MCode + count_GCode;
      ATIO.Put_Line ("sum_AllCodes     = " & Integer'Image(sum_AllCodes));
      ATIO.New_Line;
      
      ATIO.Put_Line ("count_M1         = " & Integer'Image(count_M1));
      ATIO.Put_Line ("count_M2         = " & Integer'Image(count_M2));
      ATIO.Put_Line ("count_M3         = " & Integer'Image(count_M3));
      ATIO.Put_Line ("count_M4         = " & Integer'Image(count_M4));
      ATIO.Put_Line ("count_M5         = " & Integer'Image(count_M5));
     
      sum_MX := count_M1 + count_M2 + count_M3 + count_M4 + count_M5;
      ATIO.Put_Line ("sum_MX           = " & Integer'Image(sum_MX));
      ATIO.New_Line;
      
      ATIO.Put_Line ("count_G00        = " & Integer'Image(count_G00));
      ATIO.Put_Line ("count_G01        = " & Integer'Image(count_G01));
      ATIO.Put_Line ("count_G02        = " & Integer'Image(count_G02));
      ATIO.Put_Line ("count_G03        = " & Integer'Image(count_G03));
      ATIO.Put_Line ("count_G21        = " & Integer'Image(count_G21));
      
      sum_GXX := count_G00 + count_G01 + count_G02 + count_G03 + count_G21;
      ATIO.Put_Line ("sum_GXX          = " & Integer'Image(sum_GXX));
      ATIO.New_Line;
      
      ATIO.Put_Line ("Curr File Output = " & "files/out_gcode_file_02.txt");
      ATIO.Put ("("); PADTS.dtstamp; ATIO.Put_line("finished execution.)"); 
      
      -- ===================================================
      ATIO.Close (out_FHReport_02);
      PADTS.exec_delay_sec (2); -- Ensure finish file closing.
      
      ATIO.Set_Output(ATIO.Standard_Output);
      
   end exec_display_gcode_categories;
   -- ========================================================   

begin
       null;
-- ========================================================
end pkg02_remove_comment_lines;
-- ========================================================    
