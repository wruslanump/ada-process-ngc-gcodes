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
      
   package PADTS renames pkg_ada_dtstamp;
   package PARWF renames pkg_ada_read_write_file;
   
   -- VARIABLES WITH PACKAGE-WISE ACCESS
   inp_UBfname : ASU.Unbounded_String; 
   out_UBfname : ASU.Unbounded_String; 
   
   inp_gcode_file_10 : ASU.Unbounded_String; -- No need initialization
   out_gcode_file_10 : String := "files/out_gcode_file_10.txt";
   
   out_gcode_file_11 : String := "files/out_gcode_file_11.txt"; 
   out_gcode_file_12 : String := "files/out_gcode_file_12.txt";   
     
   -- =====================================================
   procedure exec10_standardize_gcode_to_ngc (inp_gcode_fname : in String)
   -- =====================================================
   -- with SPARK_Mode => on
   is
      
   begin
      -- COPY INPUT C-GODE FILE TO NEW FILE WITH LINE_NO
      -- SO WE LEAVE CONTENTS OF ORIGINAL GCODE UNCHANGED
      -- This copied file will be named "files/out_gcode_file_10.txt"
      inp_gcode_file_10 := ASU.To_Unbounded_String (inp_gcode_fname);
      
      -- Execute package pkg_ada_read_write_file for this G-CODE copy
      PARWF.exec_read_write_file (ATIO.In_File, ASU.To_String(inp_gcode_file_10), ATIO.Out_File, out_gcode_file_10);
      
      ATIO.New_Line;
      ATIO.Put_Line("Start PSGTN.exec10_standardize_gcode_to_ngc (" & ASU.To_String (inp_gcode_file_10) & ")");
            
      -- (11) Call internal procedure
      -- ==================================================
      inp_UBfname := ASU.To_Unbounded_String (ASU.To_String (inp_gcode_file_10));
      out_UBfname := ASU.To_Unbounded_String (out_gcode_file_11);
      
      ATIO.Put_Line ("=====================================================");
      -- Check input and output file names
      ATIO.Put_Line ("PSGTN internal: exec11_replace_uppercase_all_chars (input, output):");
      ATIO.Put_Line ("input  = " & ASU.To_String (inp_UBfname));
      ATIO.Put_Line ("output = " & ASU.To_String (out_UBfname));
      -- Execute after check 
      exec11_replace_uppercase_all_chars (inp_UBfname, out_UBfname);
      ATIO.New_Line;
      
      -- (12) Call internal procedure
      -- ==================================================
      inp_UBfname := out_UBfname;
      out_UBfname := ASU.To_Unbounded_String (out_gcode_file_12);
      
      ATIO.Put_Line ("=====================================================");
      -- Check input and output file names
      ATIO.Put_Line ("PSGTN internal: exec12_remove_whitespace_each_line (input, output):");
      ATIO.Put_Line ("input  = " & ASU.To_String (inp_UBfname));
      ATIO.Put_Line ("output = " & ASU.To_String (out_UBfname));
      -- Execute after check               
      exec12_remove_whitespace_each_line (inp_UBfname, out_UBfname);
      ATIO.New_Line;
     
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
      ATIO.Put_Line ("Opened output file: " &  ASU.To_String (out_UBfname) & " duccessfully.");
    
      ATIO.Put_Line ("PROCESSING ...");
      
      while not ATIO.End_Of_File (inp_fhandle) loop
         inp_UBlineStr := ASU.To_Unbounded_String(ATIO.Get_Line (inp_fhandle));
      
         -- PROCESS THE LINE -- exec11_replace_uppercase_all_chars
         -- write line to terminal
         -- ATIO.Put_Line (ATIO.Standard_Output, ACH.To_Upper (ASU.To_String(inp_UBlineStr)) );
         
         -- write line to output file
         ATIO.Put_Line (out_fhandle, ACH.To_Upper (ASU.To_String(inp_UBlineStr)) );
                          
      end loop;   
      
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
            ATIO.Put ("LINE: " & Integer'Image(lineNum) & " idx_location_X = " & Natural'Image(idx_location_X) );
            ATIO.Put_Line (" inp_UBlineStr: " &  ASU.To_String (inp_UBlineStr));
            
            -- Delete from location-number(start) through location-number(end)
            ASU.Delete (inp_UBlineStr, idx_location_X + 1, idx_location_X + 1);
            
            -- RECHECK LINE AFTER REPLACEMENT
            ATIO.Put ("LINE: " & Integer'Image(lineNum) & " idx_location_X = " & Natural'Image(idx_location_X) );
            ATIO.Put_Line (" inp_UBlineStr: " &  ASU.To_String (inp_UBlineStr));
         end if;
         
         idx_location_Y := ASU.Index (inp_UBlineStr, "Y [", AS.Forward, ASM.Identity);     
         if ( idx_location_Y /= 0 ) then
            ATIO.Put ("LINE: " & Integer'Image(lineNum) & " idx_location_Y = " & Natural'Image(idx_location_Y) );
            ATIO.Put_Line (" inp_UBlineStr: " &  ASU.To_String (inp_UBlineStr));
            ASU.Delete (inp_UBlineStr, idx_location_Y + 1, idx_location_Y + 1);
            ATIO.Put ("LINE: " & Integer'Image(lineNum) & " idx_location_Y = " & Natural'Image(idx_location_Y) );
            ATIO.Put_Line (" inp_UBlineStr: " &  ASU.To_String (inp_UBlineStr));
         end if;
         
         idx_location_Z := ASU.Index (inp_UBlineStr, "Z [", AS.Forward, ASM.Identity);  
         if ( idx_location_Z /= 0 ) then
            ATIO.Put ("LINE: " & Integer'Image(lineNum) & " idx_location_Z = " & Natural'Image(idx_location_Z) );
            ATIO.Put_Line (" inp_UBlineStr: " &  ASU.To_String (inp_UBlineStr));
            ASU.Delete (inp_UBlineStr, idx_location_Z + 1, idx_location_Z + 1);
            ATIO.Put ("LINE: " & Integer'Image(lineNum) & " idx_location_Z = " & Natural'Image(idx_location_Z) );
            ATIO.Put_Line (" inp_UBlineStr: " &  ASU.To_String (inp_UBlineStr));
         end if;
         
         idx_location_I := ASU.Index (inp_UBlineStr, "I [", AS.Forward, ASM.Identity);     
         if ( idx_location_I /= 0 ) then
            ATIO.Put ("LINE: " & Integer'Image(lineNum) & " idx_location_I = " & Natural'Image(idx_location_I) );
            ATIO.Put_Line (" inp_UBlineStr: " &  ASU.To_String (inp_UBlineStr));
            ASU.Delete (inp_UBlineStr, idx_location_I + 1, idx_location_I + 1);
            ATIO.Put ("LINE: " & Integer'Image(lineNum) & " idx_location_I = " & Natural'Image(idx_location_I) );
            ATIO.Put_Line (" inp_UBlineStr: " &  ASU.To_String (inp_UBlineStr));
         end if;
         
         idx_location_J := ASU.Index (inp_UBlineStr, "J [", AS.Forward, ASM.Identity);    
         if ( idx_location_J /= 0 ) then
            ATIO.Put ("LINE: " & Integer'Image(lineNum) & " idx_location_J = " & Natural'Image(idx_location_J) );
            ATIO.Put_Line (" inp_UBlineStr: " &  ASU.To_String (inp_UBlineStr));
            ASU.Delete (inp_UBlineStr, idx_location_J + 1, idx_location_J + 1);
            ATIO.Put ("LINE: " & Integer'Image(lineNum) & " idx_location_J = " & Natural'Image(idx_location_J) );
            ATIO.Put_Line (" inp_UBlineStr: " &  ASU.To_String (inp_UBlineStr));
         end if;
         
         idx_location_K := ASU.Index (inp_UBlineStr, "K [", AS.Forward, ASM.Identity);  
         if ( idx_location_K /= 0 ) then
            ATIO.Put ("LINE: " & Integer'Image(lineNum) & " idx_location_K = " & Natural'Image(idx_location_K) );
            ATIO.Put_Line (" inp_UBlineStr: " &  ASU.To_String (inp_UBlineStr));
            ASU.Delete (inp_UBlineStr, idx_location_K + 1, idx_location_K + 1);
            ATIO.Put ("LINE: " & Integer'Image(lineNum) & " idx_location_K = " & Natural'Image(idx_location_K) );
            ATIO.Put_Line (" inp_UBlineStr: " &  ASU.To_String (inp_UBlineStr));
         end if;
         
         idx_location_F := ASU.Index (inp_UBlineStr, "F [", AS.Forward, ASM.Identity);     
         if ( idx_location_F /= 0 ) then
            ATIO.Put ("LINE: " & Integer'Image(lineNum) & " "); 
            ATIO.Put ("idx_location_F = " & Natural'Image(idx_location_F) );
            ATIO.Put_Line (" inp_UBlineStr: " &  ASU.To_String (inp_UBlineStr));
        
            ASU.Delete (inp_UBlineStr, idx_location_F + 1, idx_location_F + 1);
            
            -- RECHECK AFTER REPLACEMENT
            ATIO.Put ("LINE: " & Integer'Image(lineNum) & " "); 
            ATIO.Put ("idx_location_F = " & Natural'Image(idx_location_F) );
            ATIO.Put_Line (" inp_UBlineStr: " &  ASU.To_String (inp_UBlineStr));
            
         end if;
         
         -- Write to terminal
         ATIO.Put_Line (ATIO.Standard_Output, ASU.To_String (inp_UBlineStr));
         -- Write to output file    
         ATIO.Put_Line (out_fhandle, ASU.To_String (inp_UBlineStr));
                           
      -- =================================================     
      end loop; -- END while..loop
      
      end loop; -- END for..loop
      
      ATIO.Close (inp_fhandle);
      ATIO.Put_Line ("Close input  file : " & ASU.To_String (inp_UBfname)  & " successfully.");
      ATIO.Close (out_fhandle);
      ATIO.Put_Line ("Close output file : " & ASU.To_String (out_UBfname)  & " successfully.");
      PADTS.exec_delay_sec (1); 
      
      PADTS.dtstamp; ATIO.Put_Line ("Completed exec12.");
   end exec12_remove_whitespace_each_line;
   
-- =======================================================   
begin
  null;
-- ========================================================
end pkg10_standardize_gcode_to_ngc;
-- ========================================================    
