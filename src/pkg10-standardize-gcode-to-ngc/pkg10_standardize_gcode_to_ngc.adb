-- File   : pkg10_standardize_gcode_to_ngc.adb
-- Date   : Thu 25 Feb 2021 01:51:47 PM +08
-- Author : WRY wruslandr@gmail.com
-- ========================================================

-- ADA STANDARD PACKAGES
with Ada.Text_IO;
with Ada.Strings;
with Ada.Strings.Unbounded;
with Ada.Strings.Maps;
with Ada.Characters.Handling;
with Ada.Characters.Latin_1;

-- WRY CREATED PACKAGES 
with pkg_ada_dtstamp;
with pkg_ada_read_write_file;

-- ========================================================
package body pkg10_standardize_gcode_to_ngc
-- ========================================================
--   with SPARK_Mode => on
is

   package ATIO  renames Ada.Text_IO;
   package AS    renames Ada.Strings;
   package ASU   renames Ada.Strings.Unbounded;
   package ASM   renames Ada.Strings.Maps;
   package ACH   renames Ada.Characters.Handling;
   package ACL1  renames Ada.Characters.Latin_1;
   
   package PADTS renames pkg_ada_dtstamp;
   package PARWF renames pkg_ada_read_write_file;
   
   -- VARIABLES WITH PACKAGE-WISE ACCESS
   inp_UBfname : ASU.Unbounded_String; 
   out_UBfname : ASU.Unbounded_String; 
   
   -- Single input file
   inp_gcode_file_10 : ASU.Unbounded_String; -- No need initialization
   
   -- Series of output files
   out_gcode_file_10 : String := "files/out_gcode_file_10.txt"; -- Exact copy of Original
   out_gcode_file_11 : String := "files/out_gcode_file_11.txt"; -- Raised all to Uppercase
   out_gcode_file_12 : String := "files/out_gcode_file_12.txt"; -- Fixed line remove spaces "F ["  
   out_gcode_file_13 : String := "files/out_gcode_file_13.txt"; -- Removed comments and blank lines  
   
   -- Report file (SINGLE APPENDED FILE)
   app_report_pkg10 : String := "files/report_pkg10_standardize_gcode_to_ngc.txt"; 
   
  
   
   -- =====================================================
   procedure exec10_standardize_gcode_to_ngc (inp_gcode_fname : in String)
   -- =====================================================
   -- with SPARK_Mode => on
   is
      
   begin
      ATIO.New_Line;
      ATIO.Put_Line("Start PSGTN.exec10_standardize_gcode_to_ngc (" & ASU.To_String (inp_gcode_file_10) & ")");
      
      -- (10) Call External procedure in PARWF
      -- ==================================================
      -- COPY STARTING INPUT G-GODE FILE TO NEW FILE 
      -- SO WE LEAVE CONTENTS OF ORIGINAL GCODE UNCHANGED
      -- This copied file will be named "files/out_gcode_file_10.txt"
      
      ATIO.Put_Line ("=====================================================");
      -- Check input and output file names
      ATIO.Put_Line ("PSGTN external: PARWF.exec_read_write_file (input, output):");
      ATIO.Put_Line ("input  = " & inp_gcode_fname  );   -- Already a string
      ATIO.Put_Line ("output = " & out_gcode_file_10);   -- Already a string
      
      -- Execute package pkg_ada_read_write_file for this G-CODE copy
      inp_gcode_file_10 := ASU.To_Unbounded_String (inp_gcode_fname);
      PARWF.exec_read_write_file (ATIO.In_File, ASU.To_String(inp_gcode_file_10), ATIO.Out_File, out_gcode_file_10);
      
      -- (11) Call internal procedure
      -- ==================================================
      inp_UBfname := ASU.To_Unbounded_String ("files/out_gcode_file_10.txt");
      out_UBfname := ASU.To_Unbounded_String (out_gcode_file_11);
      
      ATIO.Put_Line ("=====================================================");
      -- Check input and output file names
      ATIO.Put_Line ("PSGTN internal: exec11_replace_uppercase_all_chars (input, output):");
      -- ATIO.Put_Line ("input  = " & ASU.To_String (inp_UBfname));
      -- ATIO.Put_Line ("output = " & ASU.To_String (out_UBfname));
      
      -- Execute after check 
      exec11_replace_uppercase_all_chars (inp_UBfname, out_UBfname);
      ATIO.New_Line;
      
      -- ==================================================
      -- (12) Call internal procedure
      -- ==================================================
      inp_UBfname := ASU.To_Unbounded_String (out_gcode_file_11);
      out_UBfname := ASU.To_Unbounded_String (out_gcode_file_12);
      
      ATIO.Put_Line ("=====================================================");
      -- Check input and output file names
      ATIO.Put_Line ("PSGTN internal: exec12_remove_whitespace_each_line (input, output):");
      -- ATIO.Put_Line ("input  = " & ASU.To_String (inp_UBfname));
      -- ATIO.Put_Line ("output = " & ASU.To_String (out_UBfname));
      
      -- Execute after check               
      exec12_remove_whitespace_each_line (inp_UBfname, out_UBfname);
      ATIO.New_Line;
     
      -- ==================================================
      -- (13) Call internal procedure
      -- ==================================================
      inp_UBfname := ASU.To_Unbounded_String (out_gcode_file_12);
      out_UBfname := ASU.To_Unbounded_String (out_gcode_file_13);
      
      ATIO.Put_Line ("=====================================================");
      -- Check input and output file names
      ATIO.Put_Line ("PSGTN internal: exec13_remove_comments_and_blank_lines (input, output):");
      ATIO.Put_Line ("input  = " & ASU.To_String (inp_UBfname));
      ATIO.Put_Line ("output = " & ASU.To_String (out_UBfname));
      
      -- Execute after check 
      exec13_remove_comment_and_blank_lines (inp_UBfname, out_UBfname);
      ATIO.New_Line;
      
      
      -- (14) Closing Call internal reporting procedure
      -- ==================================================
      -- Finally write reports for all generated files 
      ATIO.Put_Line ("=====================================================");
      ATIO.Put_Line ("PSGTN Internal: exec_report_pkg10_standardize_gcode_to_ngc (app_report_pkg10);");
      ATIO.Put_Line ("output = " & app_report_pkg10);
      
      -- Execute after check 
      -- exec_report_pkg10_standardize_gcode_to_ngc (app_report_pkg10);
            
      ATIO.Put_Line("End PSGTN.exec10_standardize_gcode_to_ngc (" & inp_gcode_fname & ")");
      ATIO.Put_Line ("=====================================================");
      ATIO.New_Line;
         
   end exec10_standardize_gcode_to_ngc;
   
   -- =====================================================
   procedure exec11_replace_uppercase_all_chars (inp_UBfname, out_UBfname : in ASU.Unbounded_String)
   -- =====================================================
   -- with SPARK_Mode => on
   is
      inp_fhandle,   out_fhandle   : ATIO.File_Type; 
      inp_UBlineStr, out_UBlineStr : ASU.Unbounded_String;
           
   begin
      ATIO.New_Line;
      PADTS.dtstamp; ATIO.Put_Line ("Executing exec11 ...");
      
      ATIO.Open   (inp_fhandle, ATIO.In_File, ASU.To_String (inp_UBfname));
      ATIO.Put_Line ("Opened input file : " & ASU.To_String (inp_UBfname)  & " successfully.");
      
      ATIO.Create (out_fhandle, ATIO.Out_File, ASU.To_String (out_UBfname));
      ATIO.Put_Line ("Opened output file: " &  ASU.To_String (out_UBfname) & " successfully.");
    
      ATIO.Put_Line ("PROCESSING ...");
      
      -- TO UPPERCASE ENTIRE STRING
      while not ATIO.End_Of_File (inp_fhandle) loop
         inp_UBlineStr := ASU.To_Unbounded_String(ATIO.Get_Line (inp_fhandle));
      
         -- write line to output file
         ATIO.Put_Line (out_fhandle, ACH.To_Upper (ASU.To_String(inp_UBlineStr)) );
                         
      end loop;   
      
      -- ATIO.Reset (out_fhandle);
      
      
      ATIO.Close (inp_fhandle);
      ATIO.Put_Line ("Close input  file : " & ASU.To_String (inp_UBfname)  & " successfully.");
      ATIO.Close (out_fhandle);
      ATIO.Put_Line ("Close output file : " & ASU.To_String (out_UBfname)  & " successfully.");
      PADTS.exec_delay_sec (1); 
      
      PADTS.dtstamp; ATIO.Put_Line ("Completed exec11.");
   end exec11_replace_uppercase_all_chars;
   
   -- ====================================================
   procedure exec12_remove_whitespace_each_line (inp_UBfname, out_UBfname : in ASU.Unbounded_String)
   -- ====================================================  
   -- with SPARK_Mode => on
   is
      inp_fhandle,   out_fhandle   : ATIO.File_Type; 
      inp_UBlineStr, out_UBlineStr : ASU.Unbounded_String;
      lineNum : Integer := 999;
      
      idx_location_X : Natural := 0;  
      idx_location_Y : Natural := 0;  
      idx_location_Z : Natural := 0;  
      idx_location_I : Natural := 0;  
      idx_location_J : Natural := 0; 
      idx_location_K : Natural := 0; 
      idx_location_F : Natural := 0;
      
   begin
      ATIO.New_Line;
      PADTS.dtstamp; ATIO.Put_Line ("Executing exec12 ...");
      
      ATIO.Open   (inp_fhandle, ATIO.In_File, ASU.To_String (inp_UBfname));
      ATIO.Put_Line ("Opened input file : " & ASU.To_String (inp_UBfname)  & " successfully.");
      ATIO.Create (out_fhandle, ATIO.Out_File, ASU.To_String (out_UBfname));
      ATIO.Put_Line ("Opened output file: " &  ASU.To_String (out_UBfname) & " successfully.");
      ATIO.Put_Line ("PROCESSING ...");
      -- ==================================================
      
      -- VERY IMPORTANT ==================================
      -- The (while..loop) below processes only one field error per line.
      -- If for every line scanned, there are more that one field "error" of
      -- the type we have, then we must rerun the many times.
      -- Maximum rerun would be for the number of fields. (seven)
      -- X, Y, Z, I, J, K, F . MUST SIMULATE THIS TEST.
      -- So we run the (for..loop)
      -- ==================================================
      for fieldnumber in 1 .. 7 loop
      
      lineNum := 0;
      while not ATIO.End_Of_File (inp_fhandle) loop
         inp_UBlineStr := ASU.To_Unbounded_String(ATIO.Get_Line (inp_fhandle));
         lineNum := lineNum + 1;
         
         -- SEARCH LOCATION FOR SUBSTRING PATTERN "F [" INSIDE LINE STRING
         -- Replace "F [" with "F[" (that is remove whitespace)
         -- EXAMPLE: 
         -- idx_location_X := ASU.Index (Source => inp_UBlineStr,
         --                             Pattern => "X [", 
         --                             Going   => Ada.Strings.Forward, 
         --                             Mapping => Ada.Strings.Maps.Identity);  
                               
         -- The substring exists somewhere in the line string if location is not zero
         idx_location_X := ASU.Index (inp_UBlineStr, "X [", AS.Forward, ASM.Identity);   
         if ( idx_location_X /= 0 ) then
               
               -- DISPLAY LINE BEFORE DELETION
               -- ============================
            -- ATIO.Put ("LINE: " & Integer'Image(lineNum) & " idx_location_X = " & Natural'Image(idx_location_X) );
            -- ATIO.Put_Line (" inp_UBlineStr: " &  ASU.To_String (inp_UBlineStr));
            
               -- DELETE from location-number(start) through location-number(end)
              -- ================================
            ASU.Delete (inp_UBlineStr, idx_location_X + 1, idx_location_X + 1);
            
               -- RECHECK LINE AFTER REPLACEMENT
               -- =============================
            -- ATIO.Put ("LINE: " & Integer'Image(lineNum) & " idx_location_X = " & Natural'Image(idx_location_X) );
            -- ATIO.Put_Line (" inp_UBlineStr: " &  ASU.To_String (inp_UBlineStr));
         
         end if;
         
         idx_location_Y := ASU.Index (inp_UBlineStr, "Y [", AS.Forward, ASM.Identity);     
         if ( idx_location_Y /= 0 ) then
             
               ASU.Delete (inp_UBlineStr, idx_location_Y + 1, idx_location_Y + 1);
               
         end if;
         
         idx_location_Z := ASU.Index (inp_UBlineStr, "Z [", AS.Forward, ASM.Identity);  
         if ( idx_location_Z /= 0 ) then
                           
            ASU.Delete (inp_UBlineStr, idx_location_Z + 1, idx_location_Z + 1);
           
         end if;
         
         idx_location_I := ASU.Index (inp_UBlineStr, "I [", AS.Forward, ASM.Identity);     
         if ( idx_location_I /= 0 ) then
            
            ASU.Delete (inp_UBlineStr, idx_location_I + 1, idx_location_I + 1);
           
         end if;
         
         idx_location_J := ASU.Index (inp_UBlineStr, "J [", AS.Forward, ASM.Identity);    
         if ( idx_location_J /= 0 ) then
            
            ASU.Delete (inp_UBlineStr, idx_location_J + 1, idx_location_J + 1);
           
         end if;
         
         idx_location_K := ASU.Index (inp_UBlineStr, "K [", AS.Forward, ASM.Identity);  
         if ( idx_location_K /= 0 ) then
            
            ASU.Delete (inp_UBlineStr, idx_location_K + 1, idx_location_K + 1);
           
         end if;
         
         idx_location_F := ASU.Index (inp_UBlineStr, "F [", AS.Forward, ASM.Identity);     
         if ( idx_location_F /= 0 ) then
            
            ASU.Delete (inp_UBlineStr, idx_location_F + 1, idx_location_F + 1);
                              
         end if;
         
            -- Write to terminal (AFTER SUBSTRING DELETION)
            -- ========================
            -- ATIO.Put_Line (ATIO.Standard_Output, ASU.To_String (inp_UBlineStr));
            
            -- Write to output file   (AFTER SUBSTRING DELETION) 
            -- ========================
            ATIO.Put_Line (out_fhandle, ASU.To_String (inp_UBlineStr));
            
                           
      -- =================================================     
      end loop; -- END while..loop
      
      end loop; -- END for..loop
      
      -- ==================================================
      ATIO.Put_Line ("COMPLETED. EXITING ...");
      ATIO.Close (inp_fhandle);
      ATIO.Put_Line ("Close input  file : " & ASU.To_String (inp_UBfname)  & " successfully.");
      ATIO.Close (out_fhandle);
      ATIO.Put_Line ("Close output file : " & ASU.To_String (out_UBfname)  & " successfully.");
      PADTS.exec_delay_sec (1); 
      
      PADTS.dtstamp; ATIO.Put_Line ("Completed exec12.");
   end exec12_remove_whitespace_each_line;
   
   -- ====================================================
   procedure exec13_remove_comment_and_blank_lines (inp_UBfname, out_UBfname : in ASU.Unbounded_String)
   -- ====================================================
   -- with SPARK_Mode => on
   is
   
      inp_fhandle : ATIO.File_Type;
      out_fhandle : ATIO.File_Type;
    
      inp_UBlineStr     : ASU.Unbounded_String;   -- initialization not needed
      curr_lenUBlineStr : Natural := 999;         -- use ASU.Length
      firstChar         : String  := "1";         -- use ASU.Unbounded_Slice
      
      
      
   begin
      ATIO.New_Line;
      PADTS.dtstamp; ATIO.Put_Line ("Executing exec13 ...");
   
      ATIO.Open   (inp_fhandle, ATIO.In_File, ASU.To_String (inp_UBfname));
      ATIO.Put_Line ("Opened input file : " & ASU.To_String (inp_UBfname)  & " successfully.");
      ATIO.Create (out_fhandle, ATIO.Out_File, ASU.To_String (out_UBfname));
      ATIO.Put_Line ("Opened output file: " &  ASU.To_String (out_UBfname) & " successfully.");
      ATIO.Put_Line ("PROCESSING ...");
      -- ==================================================  
      
      -- (1) To remove blank lines
      while not ATIO.End_Of_File (inp_fhandle) loop
         inp_UBlineStr := ASU.To_Unbounded_String(ATIO.Get_Line (inp_fhandle));
               
         firstChar  := ASU.To_String (ASU.Unbounded_Slice(inp_UBlineStr, 1, 1));
         
         -- for both comment and blank lines
         if (firstChar = "(" ) then
            null;
         else
             ATIO.Put_Line (ASU.To_String (inp_UBlineStr)); 
             ATIO.Put_Line (out_fhandle, ASU.To_String (inp_UBlineStr)); 
         end if;
      
      end loop;
         
           
      -- ==================================================
      ATIO.Put_Line ("COMPLETED. EXITING ...");
      ATIO.Close (inp_fhandle);
      ATIO.Put_Line ("Close input  file : " & ASU.To_String (inp_UBfname)  & " successfully.");
      ATIO.Close (out_fhandle);
      ATIO.Put_Line ("Close output file : " & ASU.To_String (out_UBfname)  & " successfully.");
      PADTS.exec_delay_sec (1); 
      PADTS.dtstamp; ATIO.Put_Line ("Completed exec13.");
      
   end exec13_remove_comment_and_blank_lines;
   
   -- ====================================================
   -- PERFORM REPORT AFTER ALL FILES COMPLETED
   -- ====================================================
   procedure exec_report_pkg10_standardize_gcode_to_ngc (app_report_pkg10 : in String)
   -- ====================================================
     -- with SPARK_Mode => on
   is
       app_fhandle : ATIO.File_Type;
       app_fname   : String := app_report_pkg10;
      
   begin
      ATIO.New_Line;
      PADTS.dtstamp; ATIO.Put_Line ("Executing exec_report_pkg10 ...");
   
      -- INITIALLY CREATE A BLANK REPORT FILE TO BE APPENDED LATER
      ATIO.Create (app_fhandle, ATIO.Append_File, app_fname);
      
         ATIO.Set_Output (app_fhandle);
         PADTS.dtstamp; ATIO.Put_Line ("Bismillah 3 times WRY");
         PADTS.dtstamp; ATIO.Put_Line ("Running exec_report_pkg10_standardize_gcode_to_ngc");
         ATIO.New_Line;
         
         ATIO.Set_Output (ATIO.Standard_Output);
      
      ATIO.Close (app_fhandle);
      PADTS.exec_delay_sec (1); -- Ensure file closed within time
      
      -- ALL INTERNAL SUB-PROCEDURES BELOW  
      -- ORIGINAL G-CODE FILES  
      
      ATIO.Put_Line ("Run exec_report_out_gcode_textfile_10 (out_gcode_file_10); ");
      exec_report_out_gcode_textfile_10 ("files/out_gcode_file_10.txt");
      
      -- ATIO.Put_Line ("Run exec_report_out_gcode_textfile_11 (out_gcode_file_11); ");
      -- exec_report_out_gcode_textfile_11 ("files/out_gcode_file_11.txt");
      
      -- ATIO.Put_Line ("Run exec_report_out_gcode_textfile_12 (out_gcode_file_12); ");
      -- exec_report_out_gcode_textfile_12 ("files/out_gcode_file_12.txt");
      
      -- ATIO.Put_Line ("Run exec_report_out_gcode_textfile_13 (out_gcode_file_13); ");
      -- exec_report_out_gcode_textfile_13 ("files/out_gcode_file_13.txt");
      
      
   end exec_report_pkg10_standardize_gcode_to_ngc;
   
   -- =====================================================
   procedure exec_report_out_gcode_textfile_10 (report_gcode_textfile_10 : in String)
   -- =====================================================
   -- with SPARK_Mode => on
   is
      inp_fname : String := report_gcode_textfile_10;
      app_fname : String := app_report_pkg10;
      
      inp_fhandle : ATIO.File_Type;
      app_fhandle : ATIO.File_Type;
      
      -- NOTE: two subtypes of type Integer: 
      -- Natural is an Integer which cannot be less than zero, 
      -- Positive is an Integer which cannot be less than 1.
   
      inp_UBlineStr     : ASU.Unbounded_String;
      curr_lenUBlineStr : Natural := 1;
      max_lenUBlineStr  : Natural := 1;
      
      firstChar      : String  := "1";         -- DUMMY
      first2Chars    : String  := "12";        -- DUMMY
      first3Chars    : String  := "123";       -- DUMMY
      
      lineCount          : Integer := 999;
      count_BlankLine    : Integer := 999;
      count_NonBlankLine : Integer := 999;
      count_Comment      : Integer := 999;
      count_NonComment   : Integer := 999;
      count_Percent : Integer := 999; -- (Begin and End G-Code file)
      count_Hash    : Integer := 999; -- (Numeric scaling factors)
      count_MCode   : Integer := 999; -- (Machine control codes)
      count_GCode   : Integer := 999; -- (Movemont control codes)
      sum_AllCodes  : Integer := 0;
      
      sum_Hash  : Integer := 0;
      sum_MX    : Integer := 0;
      sum_GXX   : Integer := 0;
            
      count_Hash6   : Integer := 999; -- (X axis offset)
      count_Hash7   : Integer := 999; -- (Y axis offset)
      count_Hash8   : Integer := 999; -- (Z axis offset)
      count_Hash10  : Integer := 999; -- (XY Scale factor)
      count_Hash11  : Integer := 999; -- (Z  Scale factor) 
      count_Hash20  : Integer := 999; -- (Feed Definition)
      count_Hash21  : Integer := 999; -- (Feed Definition) 
           
      count_M0 : Integer := 999;
      count_M1 : Integer := 999;
      count_M2 : Integer := 999;
      count_M3 : Integer := 999;
      count_M4 : Integer := 999;
      count_M5 : Integer := 999;
            
      count_G00 : Integer := 999; -- (rapid linear move)
      count_G01 : Integer := 999; -- (linear move)
      count_G02 : Integer := 999; -- (clockwise arc move) 
      count_G03 : Integer := 999; -- (counter-clockwise arc move)
      count_G21 : Integer := 999; -- (G21 - All units in mm)
     
      
   begin
      
      ATIO.Open (inp_fhandle, ATIO.In_File,     inp_fname); 
      ATIO.Open (app_fhandle, ATIO.Append_File, app_fname);
      
      -- Checking correct files processed
      ATIO.Set_Output (app_fhandle);
      PADTS.dtstamp; ATIO.Put_Line ("RUNNING ... exec_report_out_gcode_textfile_10"); 
      PADTS.dtstamp; ATIO.Put_Line ("inp_fname = " & inp_fname);
      PADTS.dtstamp; ATIO.Put_Line ("app_fname = " & app_fname);
      PADTS.dtstamp; ATIO.Put_Line ("PROCESSING ...");
      
      ATIO.Set_Output (ATIO.Standard_Output);
      ATIO.Put_Line ("RUNNING ... exec_report_out_gcode_textfile_10"); 
      ATIO.Put_Line ("inp_fname = " & inp_fname);
      ATIO.Put_Line ("app_fname = " & app_fname);
      ATIO.Put_Line ("PROCESSING ...");
      
      -- THE ACTUAL REPORT PROCESSING
      -- ==================================================
      -- (1) Check for total line counts
      -- ==================================================
      lineCount    := 0;
      while not ATIO.End_Of_File (inp_fhandle) loop
         inp_UBlineStr := ASU.To_Unbounded_String(ATIO.Get_Line (inp_fhandle));
         lineCount    := lineCount + 1;
      end loop;
      
      -- Back to beginning of file 
      ATIO.Reset(inp_fhandle);
            
      -- ==================================================
      -- (2) Check for length of line and first character in line
      -- ==================================================
      count_BlankLine    := 0;
      count_NonBlankLine := 0;
      count_Comment      := 0;
      count_NonComment   := 0;
      count_Percent := 0; -- (Begin and End G-Code file)
      count_Hash    := 0; -- (Numeric scaling factors)
      count_MCode   := 0; -- (Machine control codes)
      count_GCode   := 0; -- (Movemont control codes)
      sum_AllCodes  := 0;
            
      while not ATIO.End_Of_File (inp_fhandle) loop
         inp_UBlineStr := ASU.To_Unbounded_String(ATIO.Get_Line (inp_fhandle));
      
         curr_lenUBlineStr := ASU.Length (inp_UBlineStr);
         
         if curr_lenUBlineStr > max_lenUBlineStr then 
            max_lenUBlineStr := curr_lenUBlineStr;
         end if;  
         
         -- NON-ZERO LENGTH STRING
         if (curr_lenUBlineStr /= 0) then
            count_NonBlankLine := count_NonBlankLine + 1;
              
            firstChar  := ASU.To_String (ASU.Unbounded_Slice(inp_UBlineStr, 1, 1));
            
            -- CHECK FOR THE FIRST CHARACTER
            if (firstChar = "(") then
               count_Comment := count_Comment + 1;
            elsif (firstChar = "%") then
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
            
         -- BLANK LINE = ZERO LENGTH STRING        
         else       
            count_BlankLine := count_BlankLine + 1;
         end if;
         
      end loop;
      -- ==================================================
      sum_AllCodes  := count_Percent + count_Hash + count_MCode + count_GCode; 
      count_NonComment := lineCount - count_Comment - count_BlankLine;
      
      -- ==================================================
      ATIO.Set_Output (app_fhandle);
      ATIO.New_Line;
      PADTS.dtstamp; ATIO.Put_Line ("Total lineCount    = " & Integer'Image (lineCount));
      PADTS.dtstamp; ATIO.Put_Line ("count_BlankLine    = " & Integer'Image (count_BlankLine));
      PADTS.dtstamp; ATIO.Put_Line ("count_NonBlankLine = " & Integer'Image (count_NonBlankLine));
      PADTS.dtstamp; ATIO.Put_Line ("count_Comment      = " & Integer'Image (count_Comment));
      PADTS.dtstamp; ATIO.Put_Line ("count_NonComment   = " & Integer'Image (count_NonComment));
      ATIO.New_Line;
      PADTS.dtstamp; ATIO.Put_Line ("count_Percent      = " & Integer'Image (count_Percent));
      PADTS.dtstamp; ATIO.Put_Line ("count_Hash         = " & Integer'Image (count_Hash));
      PADTS.dtstamp; ATIO.Put_Line ("count_MCode        = " & Integer'Image (count_MCode));
      PADTS.dtstamp; ATIO.Put_Line ("count_GCode        = " & Integer'Image (count_GCode));
      PADTS.dtstamp; ATIO.Put_Line ("Sum_AllCodes       = " & Integer'Image (Sum_AllCodes));
      PADTS.dtstamp; ATIO.Put_Line ("max_lenUBlineStr   = " & Natural'Image (max_lenUBlineStr));
      ATIO.New_Line;
       
      ATIO.Set_Output (ATIO.Standard_Output);
      ATIO.New_Line;
      PADTS.dtstamp; ATIO.Put_Line ("Total lineCount    = " & Integer'Image (lineCount));
      PADTS.dtstamp; ATIO.Put_Line ("count_BlankLine    = " & Integer'Image (count_BlankLine));
      PADTS.dtstamp; ATIO.Put_Line ("count_NonBlankLine = " & Integer'Image (count_NonBlankLine));
      PADTS.dtstamp; ATIO.Put_Line ("count_Comment      = " & Integer'Image (count_Comment));
      PADTS.dtstamp; ATIO.Put_Line ("count_NonComment   = " & Integer'Image (count_NonComment));
      ATIO.New_Line;
      PADTS.dtstamp; ATIO.Put_Line ("count_Percent      = " & Integer'Image (count_Percent));
      PADTS.dtstamp; ATIO.Put_Line ("count_Hash         = " & Integer'Image (count_Hash));
      PADTS.dtstamp; ATIO.Put_Line ("count_MCode        = " & Integer'Image (count_MCode));
      PADTS.dtstamp; ATIO.Put_Line ("count_GCode        = " & Integer'Image (count_GCode));
      PADTS.dtstamp; ATIO.Put_Line ("Sum_AllCodes       = " & Integer'Image (Sum_AllCodes));
      PADTS.dtstamp; ATIO.Put_Line ("max_lenUBlineStr   = " & Natural'Image (max_lenUBlineStr));
      ATIO.New_Line;
      
      -- Back to beginning of file 
      ATIO.Reset(inp_fhandle);
      
      -- ==================================================
      -- (3) Breakdown counts for each code
      -- ==================================================
      -- FIRST 2 CHARACTERS
      count_M0 := 0;
      count_M1 := 0;
      count_M2 := 0;
      count_M3 := 0;
      count_M4 := 0;
      count_M5 := 0;
            
      count_Hash6   := 0; -- (X axis offset)
      count_Hash7   := 0; -- (Y axis offset)
      count_Hash8   := 0; -- (Z axis offset)
      
      
      while not ATIO.End_Of_File (inp_fhandle) loop
         inp_UBlineStr := ASU.To_Unbounded_String(ATIO.Get_Line (inp_fhandle));
      
         curr_lenUBlineStr := ASU.Length (inp_UBlineStr); 
      
      
         -- USING FIRST 2 CHARACTERS FOR MCode and HashCode
         if  (curr_lenUBlineStr /= 0) and (curr_lenUBlineStr >= 2) then
         
            first2Chars  := ASU.To_String (ASU.Unbounded_Slice(inp_UBlineStr, 1, 2));
            
            if (first2Chars = "M0") then
               count_M0 := count_M0 + 1;
            elsif (first2Chars = "M1") then
               count_M1 := count_M1 + 1; 
            elsif (first2Chars = "M2") then
               count_M2 := count_M2 + 1;
            elsif (first2Chars = "M3") then
               count_M3 := count_M3 + 1;   
            elsif (first2Chars = "M4") then
               count_M4 := count_M4 + 1;
            elsif (first2Chars = "M5") then
               count_M5 := count_M5 + 1; 
            
            elsif (first2Chars = "#6") then
               count_Hash6 := count_Hash6 + 1;   
            elsif (first2Chars = "#7") then
               count_Hash7 := count_Hash7 + 1;   
            elsif (first2Chars = "#8") then
               count_Hash8 := count_Hash8 + 1;      
               -- else
               -- ATIO.Put_Line("Error. first2Chars = " & (first2Chars) & " not captured.");
            end if;         
                 
         end if;
               
      end loop;
      
      -- ==================================================
      -- Back to beginning of file 
      ATIO.Reset(inp_fhandle);
      
      -- FIRST 3 Chars
      -- ==================================================
      count_Hash10  := 0; -- (XY Scale factor)
      count_Hash11  := 0; -- (Z  Scale factor) 
      count_Hash20  := 0; -- (Feed Definition)
      count_Hash21  := 0; -- (Feed Definition) 
      
      count_G00 := 0; -- (rapid linear move)
      count_G01 := 0; -- (linear move)
      count_G02 := 0; -- (clockwise arc move) 
      count_G03 := 0; -- (counter-clockwise arc move)
      count_G21 := 0; -- (G21 - All units in mm)
      
      while not ATIO.End_Of_File (inp_fhandle) loop
         inp_UBlineStr := ASU.To_Unbounded_String(ATIO.Get_Line (inp_fhandle));
         curr_lenUBlineStr := ASU.Length (inp_UBlineStr); 
      
         if  (curr_lenUBlineStr /= 0) and (curr_lenUBlineStr >= 3) then
             first3Chars  := ASU.To_String (ASU.Unbounded_Slice(inp_UBlineStr, 1, 3));
      
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
            
            elsif (first3Chars = "#10") then
               count_Hash10 := count_Hash10 + 1;   
            elsif (first3Chars = "#11") then
               count_Hash11 := count_Hash11 + 1;  
            elsif (first3Chars = "#20") then
               count_Hash20 := count_Hash20 + 1;   
            elsif (first3Chars = "#21") then
               count_Hash21 := count_Hash21 + 1;     
               -- else
               -- ATIO.Put_Line("Error. inp_first3Chars = " & (first3Chars) & " not captured.");
            end if;  -- END (if first3Chars)   
            
                     
         end if;  -- END (len_UBlineStr)   
            
      end loop;  -- END (while ..loop)
      -- =====================================================
      
      sum_Hash := count_Hash6 + count_Hash7 + count_Hash8 + count_Hash10 + count_Hash11 +count_Hash20 +count_Hash21;
      sum_MX := count_M1 + count_M2 + count_M3 + count_M4 + count_M5;
      sum_GXX := count_G00 + count_G01 + count_G02 + count_G03 + count_G21;
      
      -- APPEND TO FILE 
      -- ======================================================
      PADTS.dtstamp; ATIO.Set_Output (app_fhandle);
      PADTS.dtstamp; ATIO.Put_Line ("count_Hash6        = " & Integer'Image(count_Hash6) & " " & ACL1.HT & "(X axis offset)");
      PADTS.dtstamp; ATIO.Put_Line ("count_Hash7        = " & Integer'Image(count_Hash7) & " " & ACL1.HT & "(Y axis offset)");
      PADTS.dtstamp; ATIO.Put_Line ("count_Hash8        = " & Integer'Image(count_Hash8) & " " & ACL1.HT & "(Z axis offset)");
      PADTS.dtstamp; ATIO.Put_Line ("count_Hash10       = " & Integer'Image(count_Hash10) & " " & ACL1.HT & "(XY axes scaling factor)");
      PADTS.dtstamp; ATIO.Put_Line ("count_Hash11       = " & Integer'Image(count_Hash11) & " " & ACL1.HT & "(Z  axis scaling factor)");
      PADTS.dtstamp; ATIO.Put_Line ("count_Hash20       = " & Integer'Image(count_Hash20) & " " & ACL1.HT & "(Feedrate Spindle)");
      PADTS.dtstamp; ATIO.Put_Line ("count_Hash21       = " & Integer'Image(count_Hash21) & " " & ACL1.HT & "(Feedrate Spindle)");
      PADTS.dtstamp; ATIO.Put_Line ("sum_Hash           = " & Integer'Image(sum_Hash));
      ATIO.New_Line;
      PADTS.dtstamp; ATIO.Put_Line ("count_M0           = " & Integer'Image(count_M0) & ACL1.HT & "(pause a running program temporarily)");
      PADTS.dtstamp; ATIO.Put_Line ("count_M1           = " & Integer'Image(count_M1) & ACL1.HT & "(pause program temporarily if stop switch ON)");
      PADTS.dtstamp; ATIO.Put_Line ("count_M2           = " & Integer'Image(count_M2) & ACL1.HT & "(end the program)");
      PADTS.dtstamp; ATIO.Put_Line ("count_M3           = " & Integer'Image(count_M3) & ACL1.HT & "(start spindle clockwise at S speed)");
      PADTS.dtstamp; ATIO.Put_Line ("count_M4           = " & Integer'Image(count_M4) & ACL1.HT & "(start spindle counter-clockwise at S speed)");
      PADTS.dtstamp; ATIO.Put_Line ("count_M5           = " & Integer'Image(count_M5) & ACL1.HT & "(stop the spindle)");
      PADTS.dtstamp; ATIO.Put_Line ("sum_MX             = " & Integer'Image(sum_MX));
      ATIO.New_Line;
      PADTS.dtstamp; ATIO.Put_Line ("count_G00          = " & Integer'Image(count_G00) & ACL1.HT & "(rapid linear move)"); 
      PADTS.dtstamp; ATIO.Put_Line ("count_G01          = " & Integer'Image(count_G01) & ACL1.HT & "(linear move)");
      PADTS.dtstamp; ATIO.Put_Line ("count_G02          = " & Integer'Image(count_G02) & ACL1.HT & "(clockwise arc move)");
      PADTS.dtstamp; ATIO.Put_Line ("count_G03          = " & Integer'Image(count_G03) & ACL1.HT & "(counter-clockwise arc move)");
      PADTS.dtstamp; ATIO.Put_Line ("count_G21          = " & Integer'Image(count_G21) & ACL1.HT & "(use mm length units. G20 = inches)");
      PADTS.dtstamp; ATIO.Put_Line ("sum_GXX            = " & Integer'Image(sum_GXX));
      ATIO.New_Line;
      PADTS.dtstamp; ATIO.Put_Line ("COMPLETED. EXITING ...");
      PADTS.dtstamp; ATIO.Put_Line ("=====================================================");
      
      -- WRITE TO TERMINAL
      -- =================================================
      ATIO.Set_Output (ATIO.Standard_Output);
      ATIO.Put_Line ("count_Hash6      = " & Integer'Image(count_Hash6) & " " & ACL1.HT & "(X axis offset)");
      ATIO.Put_Line ("count_Hash7      = " & Integer'Image(count_Hash7) & " " & ACL1.HT & "(Y axis offset)");
      ATIO.Put_Line ("count_Hash8      = " & Integer'Image(count_Hash8) & " " & ACL1.HT & "(Z axis offset)");
      ATIO.Put_Line ("count_Hash10     = " & Integer'Image(count_Hash10) & " " & ACL1.HT & "(XY axes scaling factor)");
      ATIO.Put_Line ("count_Hash11     = " & Integer'Image(count_Hash11) & " " & ACL1.HT & "(Z  axis scaling factor)");
      ATIO.Put_Line ("count_Hash20     = " & Integer'Image(count_Hash20) & " " & ACL1.HT & "(Feedrate Spindle)");
      ATIO.Put_Line ("count_Hash21     = " & Integer'Image(count_Hash21) & " " & ACL1.HT & "(Feedrate Spindle)");
      ATIO.Put_Line ("sum_Hash         = " & Integer'Image(sum_Hash));
      ATIO.New_Line;
      ATIO.Put_Line ("count_M0         = " & Integer'Image(count_M0) & ACL1.HT & "(pause a running program temporarily)");
      ATIO.Put_Line ("count_M1         = " & Integer'Image(count_M1) & ACL1.HT & "(pause program temporarily if stop switch ON)");
      ATIO.Put_Line ("count_M2         = " & Integer'Image(count_M2) & ACL1.HT & "(end the program)");
      ATIO.Put_Line ("count_M3         = " & Integer'Image(count_M3) & ACL1.HT & "(start spindle clockwise at S speed)");
      ATIO.Put_Line ("count_M4         = " & Integer'Image(count_M4) & ACL1.HT & "(start spindle counter-clockwise at S speed)");
      ATIO.Put_Line ("count_M5         = " & Integer'Image(count_M5) & ACL1.HT & "(stop the spindle)");
      ATIO.Put_Line ("sum_MX           = " & Integer'Image(sum_MX));
      ATIO.New_Line;
      ATIO.Put_Line ("count_G00        = " & Integer'Image(count_G00) & ACL1.HT & "(rapid linear move)"); 
      ATIO.Put_Line ("count_G01        = " & Integer'Image(count_G01) & ACL1.HT & "(linear move)");
      ATIO.Put_Line ("count_G02        = " & Integer'Image(count_G02) & ACL1.HT & "(clockwise arc move)");
      ATIO.Put_Line ("count_G03        = " & Integer'Image(count_G03) & ACL1.HT & "(counter-clockwise arc move)");
      ATIO.Put_Line ("count_G21        = " & Integer'Image(count_G21) & ACL1.HT & "(use mm length units. G20 = inches)");
      ATIO.Put_Line ("sum_GXX          = " & Integer'Image(sum_GXX));
      ATIO.New_Line;
      PADTS.dtstamp; ATIO.Put_Line ("COMPLETED. EXITING ...");
      ATIO.Put_Line ("=====================================================");
      
      -- ==================================================
      ATIO.Close (inp_fhandle);
      ATIO.Close (app_fhandle);
      PADTS.exec_delay_sec (1); -- Ensure file closed within time
      
   end exec_report_out_gcode_textfile_10;  
   
   -- =====================================================
   procedure exec_report_out_gcode_textfile_11 (report_gcode_textfile_11 : in String)
   -- =====================================================
   -- with SPARK_Mode => on
   is
      inp_fname : String := report_gcode_textfile_11;
      app_fname : String := app_report_pkg10;
      
      inp_fhandle : ATIO.File_Type;
      app_fhandle : ATIO.File_Type;
      
   begin
      ATIO.Open (inp_fhandle, ATIO.In_File,     inp_fname); 
      ATIO.Open (app_fhandle, ATIO.Append_File, app_fname);
      
      -- Checking correct files processed
      ATIO.Set_Output (app_fhandle);
      PADTS.dtstamp; ATIO.Put_Line ("RUNNING ... exec_report_out_gcode_textfile_11"); 
      PADTS.dtstamp; ATIO.Put_Line ("inp_fname = " & inp_fname);
      PADTS.dtstamp; ATIO.Put_Line ("app_fname = " & app_fname);
      PADTS.dtstamp; ATIO.Put_Line ("PROCESSING ...");
      
      ATIO.Set_Output (ATIO.Standard_Output);
      ATIO.Put_Line ("RUNNING ... exec_report_out_gcode_textfile_11"); 
      ATIO.Put_Line ("inp_fname = " & inp_fname);
      ATIO.Put_Line ("app_fname = " & app_fname);
      ATIO.Put_Line ("PROCESSING ...");
      
      -- THE ACTUAL REPORT PROCESSING
      
      ATIO.Set_Output (app_fhandle);
      PADTS.dtstamp; ATIO.Put_Line ("EXITING ...");
      ATIO.Set_Output (ATIO.Standard_Output);
      ATIO.Put_Line ("EXITING ...");
      
      ATIO.Close (inp_fhandle);
      ATIO.Close (app_fhandle);
      PADTS.exec_delay_sec (1); -- Ensure file closed within time
      
   end exec_report_out_gcode_textfile_11;  
   
   -- =====================================================
   procedure exec_report_out_gcode_textfile_12 (report_gcode_textfile_12 : in String)
   -- =====================================================
   -- with SPARK_Mode => on
   is
      inp_fname : String := report_gcode_textfile_12;
      app_fname : String := app_report_pkg10;
      
      inp_fhandle : ATIO.File_Type;
      app_fhandle : ATIO.File_Type;
      
   begin
      ATIO.Open (inp_fhandle, ATIO.In_File,     inp_fname); 
      ATIO.Open (app_fhandle, ATIO.Append_File, app_fname);
      
      -- Checking correct files processed
      ATIO.Set_Output (app_fhandle);
      PADTS.dtstamp; ATIO.Put_Line ("RUNNING ... exec_report_out_gcode_textfile_12"); 
      PADTS.dtstamp; ATIO.Put_Line ("inp_fname = " & inp_fname);
      PADTS.dtstamp; ATIO.Put_Line ("app_fname = " & app_fname);
      PADTS.dtstamp; ATIO.Put_Line ("PROCESSING ...");
      
      ATIO.Set_Output (ATIO.Standard_Output);
      ATIO.Put_Line ("RUNNING ... exec_report_out_gcode_textfile_12"); 
      ATIO.Put_Line ("inp_fname = " & inp_fname);
      ATIO.Put_Line ("app_fname = " & app_fname);
      ATIO.Put_Line ("PROCESSING ...");
      
      -- THE ACTUAL REPORT PROCESSING
      
      ATIO.Set_Output (app_fhandle);
      PADTS.dtstamp; ATIO.Put_Line ("EXITING ...");
      ATIO.Set_Output (ATIO.Standard_Output);
      ATIO.Put_Line ("EXITING ...");
      
      ATIO.Close (inp_fhandle);
      ATIO.Close (app_fhandle);
      PADTS.exec_delay_sec (1); -- Ensure file closed within time
      
   end exec_report_out_gcode_textfile_12;  
   
   -- =====================================================
   procedure exec_report_out_gcode_textfile_13 (report_gcode_textfile_13 : in String)
   -- =====================================================
   -- with SPARK_Mode => on
   is
      inp_fname : String := report_gcode_textfile_13;
      app_fname : String := app_report_pkg10;
      
      inp_fhandle : ATIO.File_Type;
      app_fhandle : ATIO.File_Type;
      
      lineCount     : Integer := 999;
      lineRemoved   : Integer := 999;
      lineRemained  : Integer := 999;
      inp_UBlineStr : ASU.Unbounded_String;
      
      firstChar      : String  := "1";         -- DUMMY
      -- first2Chars    : String  := "12";     -- DUMMY
      -- first3Chars    : String  := "123";    -- DUMMY
   
   begin
      ATIO.Open (inp_fhandle, ATIO.In_File,     inp_fname); 
      ATIO.Open (app_fhandle, ATIO.Append_File, app_fname);
      
      -- Checking correct files processed
      ATIO.Set_Output (app_fhandle);
      PADTS.dtstamp; ATIO.Put_Line ("RUNNING ... exec_report_out_gcode_textfile_13"); 
      PADTS.dtstamp; ATIO.Put_Line ("inp_fname = " & inp_fname);
      PADTS.dtstamp; ATIO.Put_Line ("app_fname = " & app_fname);
      PADTS.dtstamp; ATIO.Put_Line ("PROCESSING ...");
      
      ATIO.Set_Output (ATIO.Standard_Output);
      ATIO.Put_Line ("RUNNING ... exec_report_out_gcode_textfile_13"); 
      ATIO.Put_Line ("inp_fname = " & inp_fname);
      ATIO.Put_Line ("app_fname = " & app_fname);
      ATIO.Put_Line ("PROCESSING ...");
      
      -- THE ACTUAL REPORT PROCESSING
      lineCount     := 0;
      lineRemoved   := 0;
      lineRemained  := 0;
      firstChar := ASU.To_String (ASU.Unbounded_Slice(inp_UBlineStr, 1, 1));
      
      while not ATIO.End_Of_File (inp_fhandle) loop
         inp_UBlineStr := ASU.To_Unbounded_String(ATIO.Get_Line (inp_fhandle));
         lineCount := LineCount + 1;
      
      -- Note: character ( applies to both comments and blank lines
         if (firstChar = "(") then
            lineRemoved := lineRemoved + 1;
         else
            lineRemained := lineRemained + 1;            
         end if;
         
      end loop;   
      
      ATIO.Set_Output (app_fhandle); -- WRITE TO FILE
      
      PADTS.dtstamp; ATIO.Put_Line ("lineCount   = " & Integer'Image(lineCount) & ACL1.HT & "(input file line count)");
      PADTS.dtstamp; ATIO.Put_Line ("lineRemoved = " & Integer'Image(lineRemoved) & ACL1.HT & "(removed comment and blank lines)");
      PADTS.dtstamp; ATIO.Put_Line ("lineRemained= " & Integer'Image(lineRemained) & ACL1.HT & "(output file line count)"); 
      
      
      PADTS.dtstamp; ATIO.Put_Line ("EXITING ...");
      
      ATIO.Set_Output (ATIO.Standard_Output); -- WRITE TO TERMINAL
      
      PADTS.dtstamp; ATIO.Put_Line ("lineCount   = " & Integer'Image(lineCount) & ACL1.HT & "(input file line count)");
      PADTS.dtstamp; ATIO.Put_Line ("lineRemoved = " & Integer'Image(lineRemoved) & ACL1.HT & "(removed comment and blank lines)");
      PADTS.dtstamp; ATIO.Put_Line ("lineRemained= " & Integer'Image(lineRemained) & ACL1.HT & "(output file line count)"); 
            
      ATIO.Put_Line ("EXITING ...");
      
      ATIO.Close (inp_fhandle);
      ATIO.Close (app_fhandle);
      PADTS.exec_delay_sec (1); -- Ensure file closed within time
      
   end exec_report_out_gcode_textfile_13;  
   -- =====================================================   
   
   
-- ========================================================   
begin
  null;
-- ========================================================
end pkg10_standardize_gcode_to_ngc;
-- ========================================================    
