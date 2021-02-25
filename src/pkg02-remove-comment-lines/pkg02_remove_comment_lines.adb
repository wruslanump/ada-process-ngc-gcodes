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
   
   inp_fhandle, out_fhandle : ATIO.File_Type;
   
   lineCount         : Integer    := 0;
   inp_UBlineStr     : ASU.Unbounded_String; -- Initialization not needed
   firstChar         : String  := "1";       -- DUMMY
   lineRemoved       : Integer := 0;
   lineRemaining     : Integer := 0;
   
   -- =====================================================
   procedure exec_remove_comment_lines(inp_fname : in String)
   -- =====================================================
   -- with SPARK_Mode => on
   is
      
   begin
      ATIO.New_Line;
      ATIO.Put_Line("Run exec_remove_comment_lines (inp_fname)");
      ATIO.Put_Line("inp_fname = " & (inp_fname));
      ATIO.New_Line;
      
      ATIO.Open   (inp_fhandle, ATIO.In_File,  inp_fname);
      ATIO.Create (out_fhandle, ATIO.Out_File, "files/out_gcode_file_02.txt");
      
      exec_remove_comment_and_blank_lines;  -- Call internal procedure
               
      ATIO.Close (inp_fhandle);
      ATIO.Close (out_fhandle);
      PADTS.exec_delay_sec (2); -- Ensure finish file closing.
            
   end exec_remove_comment_lines;
   -- ====================================================
   -- =====================================================
   procedure exec_remove_comment_and_blank_lines
   -- =====================================================
   -- with SPARK_Mode => on
   is
      
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
      ATIO.Put_Line ("LINE ACCOUNTING AND CLASSIFICATION SUMMARY ");
      ATIO.Put_Line ("=======================================================");  
      ATIO.Put_Line ("lineCount        = " & Integer'Image(lineCount));
      ATIO.Put_Line ("lineRemoved      = " & Integer'Image(lineRemoved));
      ATIO.Put_Line ("lineRemaining    = " & Integer'Image(lineRemaining));
      ATIO.Put_Line ("Curr File Output = " & "files/out_gcode_file_02.txt");
      ATIO.Put ("("); PADTS.dtstamp; ATIO.Put_line("finished execution.)"); 
      
      
   end exec_remove_comment_and_blank_lines;   
   -- =====================================================

-- =======================================================   
begin
  null;
-- ========================================================
end pkg02_remove_comment_lines;
-- ========================================================    
