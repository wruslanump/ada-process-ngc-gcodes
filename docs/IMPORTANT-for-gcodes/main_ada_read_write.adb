-- File: main_ada_read_write.adb
-- Date: Tue 23 Feb 2021 04:39:09 PM +08
-- Author: WRY wruslan.ump@gmail.com
-- ========================================================

-- IMPORT STANDARD ADA PACKAGES
with Ada.Text_IO;
with Ada.Real_Time; use Ada.Real_Time;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

-- IMPORT USER-DEFINED ADA PACKAGES
with pkg_ada_dtstamp;
with pkg_ada_random;
with pkg_ada_read_display_file;
with pkg_ada_read_write_file;
with pkg_ada_write_display_file;

-- ========================================================
procedure main_ada_read_write
-- ========================================================
	with SPARK_Mode => on
is 

   -- RENAME STANDARD ADA PACKAGES FOR CONVENIENCE
   package ATIO    renames Ada.Text_IO;
   package ART     renames Ada.Real_Time;
   package ASU     renames Ada.Strings.Unbounded;
   
   -- RENAME USER-DEFINED ADA PACKAGES FOR CONVENIENCE
   package PADTS   renames pkg_ada_dtstamp;
   package PAR     renames pkg_ada_random;
   package PARDF   renames pkg_ada_read_display_file;
   package PARWF   renames pkg_ada_read_write_file;
   package PAWDF   renames pkg_ada_write_display_file;
   
   -- PART 1 ==============================================
   inp_fhandle_00 : ATIO.File_Type;
   inp_fmode_00   : ATIO.File_Mode  := ATIO.In_File;
   inp_fname_00   : String          := "files/bismillah.ngc"; -- GOOD TESTED
   -- inp_fname_00   : String          := "files/just-KSG.ngc"; -- GOOD TESTED
   -- inp_fname_00   : String          := "files/linuxcnc-logo.ngc"; -- TO FIX THIS CODE
   
   out_fhandle_00 : ATIO.File_Type;
   out_fmode_00   : ATIO.File_Mode  := ATIO.Out_File;
   out_fname_00 : String          := "files/outfile_level_00.txt";
   
   -- PART 2 ==============================================
   inp_fhandle_01 : ATIO.File_Type;
   inp_fmode_01   : ATIO.File_Mode  := ATIO.In_File;
   inp_fname_01   : String          := "files/outfile_level_00.txt";
   
   out_fhandle_01 : ATIO.File_Type;
   out_fmode_01   : ATIO.File_Mode  := ATIO.Out_File;
   out_fname_01   : String          := "files/outfile_level_01.txt";
   
   -- PART 3 ==============================================
   inp_fhandle_02 : ATIO.File_Type;
   inp_fmode_02   : ATIO.File_Mode  := ATIO.In_File;
   inp_fname_02   : String          := "files/outfile_level_01.txt";
   
   out_fhandle_02 : ATIO.File_Type;
   out_fmode_02   : ATIO.File_Mode  := ATIO.Out_File;
   out_fname_02   : String          := "files/outfile_level_02.txt";
  
   -- =======================================================
   -- GENERIC FILE VARIABLES
   -- =======================================================
   inp_fmode   : ATIO.File_Mode  := ATIO.In_File;
   inp_fname   : String          := "files/read_session_01.txt";
     
   out_fmode   : ATIO.File_Mode  := ATIO.Out_File;
   out_fname   : String          := "files/write_session_01.txt";
   
   app_fmode   : ATIO.File_Mode  := ATIO.Append_File;
   app_fname   : String          := "files/append_session_01.txt";  
     
   -- =======================================================
   -- COMMON VARIABLES
   -- =======================================================
   inp_UBlineStr : ASU.Unbounded_String;
   inp_lineStr   : String  := ASU.To_String(inp_UBlineStr);
   len_UBlineStr : Natural := 0;
   inp_lineCnt_All     : Integer := 0;
   inp_lineCnt_NonZero : Integer := 0; 
   inp_firstChar       : String  := "1";
   inp_first3Chars     : String  := "123"; --DUMMY
   
   out_lineStr : ASU.Unbounded_String;
   out_lineCnt : Integer := 999;
   
   out_countG   : Integer := 0;
   out_countHash: Integer := 0; -- (Numeric scaling factors)
   out_countG00 : Integer := 0; -- (rapid linear move)
   out_countG01 : Integer := 0; -- (linear move)
   out_countG02 : Integer := 0; -- (clockwise arc move) 
   out_countG03 : Integer := 0; -- (counter-clockwise arc move)
   out_countG21 : Integer := 0; -- (G21 - All units in mm)
   
begin
   PADTS.dtstamp; ATIO.Put_Line ("Bismillah 3 times WRY");
   PADTS.dtstamp; ATIO.Put_Line ("Running inside GNAT Studio Community");
   ATIO.New_Line;
   
   ATIO.Put_Line ("====================================================");
   ATIO.Put_Line ("(1) PARDF - Package Ada Read Display File");
   ATIO.Put_Line ("=====================================================");
   PARDF.exec_read_display_file (inp_fmode, inp_fname);
   
   ATIO.New_Line;
   ATIO.Put_Line ("====================================================");
   ATIO.Put_Line ("(2) PARWF - Package Ada Read Write File");
   ATIO.Put_Line ("=====================================================");
   PARWF.exec_read_write_file (inp_fmode, inp_fname, out_fmode, out_fname);
   
   ATIO.New_Line;
   ATIO.Put_Line ("====================================================");
   ATIO.Put_Line ("(3) PAWDF - Package Ada Write Display File");
   ATIO.Put_Line ("=====================================================");
   -- PAWDF.exec_write_display_file (out_fmode, out_fname);
   
   -- Generate random integers and floats
   -- Write to file random integers and floats
   -- Write to terminal random integers and floats
   
   ATIO.New_Line;
   -- =====================================================
   -- PART 1 Read input file then write output file 
   -- =====================================================
   -- Input file -- Output file
   ATIO.Open   (inp_fhandle_00, inp_fmode_00, inp_fname_00);
   ATIO.Create (out_fhandle_00, out_fmode_00, out_fname_00);
   
   ATIO.Put_Line("Opened inp_fhandle_00 as input");
   ATIO.Put_Line("Opened out_fhandle_00 as output");
      
   inp_lineCnt_All     := 0;
   inp_lineCnt_NonZero := 0;
     
   while not ATIO.End_Of_File (inp_fhandle_00) loop
      
      inp_UBlineStr := ASU.To_Unbounded_String(ATIO.Get_Line (inp_fhandle_00));
      len_UBlineStr := ASU.Length(inp_UBlineStr);
      inp_lineCnt_All := inp_lineCnt_All + 1;
      
      -- EXTRACT ONLY NON BLANK LINES
      if len_UBlineStr /= 0 then
         inp_lineCnt_NonZero := inp_lineCnt_NonZero + 1;
              
         ATIO.Put ("inp_lineCnt = "   & Integer'image (inp_lineCnt_All) & " ");
         ATIO.Put ("len_UBlineStr = " & Natural'Image (len_UBlineStr) & " ");
         
         -- WRITE OUTPUT TO SCREEN TERMINAL (Standard_Output) AND FILE
         ATIO.Put_Line (ATIO.Standard_Output, ASU.To_String (inp_UBLineStr)); 
         ATIO.Put_Line (out_fhandle_00, ASU.To_String (inp_UBLineStr)); 
                
      end if;
                 
   end loop;
   
   ATIO.Put_Line (ATIO.Standard_Output, "Total lines read    = " & Integer'Image (inp_lineCnt_All));
   ATIO.Put_Line (ATIO.Standard_Output, "Non-zero lines read = " & Integer'Image (inp_lineCnt_NonZero));
   
   ATIO.Close (out_fhandle_00);
   ATIO.Close (inp_fhandle_00);
   PADTS.exec_delay_sec (2);
   -- provide 2 sec delay to make closing files take effect
   -- because immediately next step we need to open out_fhandle_00
   
   ATIO.Put_Line ("=== PART 2 ==========================================");
   ATIO.Put_Line ("=====================================================");
   ATIO.New_Line;
     
   -- Input file  -- Output file
   ATIO.Open   (inp_fhandle_01, inp_fmode_01, inp_fname_01);
   ATIO.Create (out_fhandle_01, out_fmode_01, out_fname_01);
   
   ATIO.Put_Line("Opened inp_fhandle_01 as input");
   ATIO.Put_Line("Opened out_fhandle_01 as output");
     
   -- READLINE FROM INPUT FILE LINE-BY-LINE
   while not ATIO.End_Of_File (inp_fhandle_01) loop
      inp_UBlineStr := ASU.To_Unbounded_String(ATIO.Get_Line (inp_fhandle_01));
      
      inp_firstChar := ASU.To_String (ASU.Unbounded_Slice(inp_UBlineStr, 1, 1));
      
      -- MUST USE DOUBLE QUOTES FOR TYPE Standard.String BELOW
      -- SINGLE QUOTE FOR TYPE Character
      if   (inp_firstChar = "(") -- SKIP THE COMMENT LINES
        or (inp_firstChar = "%") -- SKIP THE HEADER AND FOOTER MARKERS
        or (inp_firstChar = "M") -- SKIP THE SPINDLE CONTROL CODES 
        then  
           -- DO NOTHING            
           null;
      else    
         -- WRITE REMAINING LINES TO OUTPUT FILE  AND TO TERMINAL 
         -- =====================================================
         ATIO.Put_Line (ATIO.Standard_Output, ASU.To_String (inp_UBLineStr)); 
         ATIO.Put_Line (out_fhandle_01, ASU.To_String (inp_UBLineStr));
   
      end if;
         
   end loop;   
   
   ATIO.Close (out_fhandle_01);
   ATIO.Close (inp_fhandle_01);
   PADTS.exec_delay_sec (2);
   
   ATIO.Put_Line ("=== PART 3 ==========================================");
   ATIO.Put_Line ("=====================================================");
   ATIO.New_Line;
   
   -- Input file  -- Output file
   ATIO.Open   (inp_fhandle_02, inp_fmode_02, inp_fname_02);
   ATIO.Create (out_fhandle_02, out_fmode_02, out_fname_02);
   
   ATIO.Put_Line("Opened inp_fhandle_02 as input");
   ATIO.Put_Line("Opened out_fhandle_02 as output");
   
   out_countG   := 0;
   out_countG00 := 0; 
   out_countG01 := 0;
   out_countG02 := 0;
   out_countG03 := 0;
   out_countG21 := 0;
   out_countHash:= 0;
   out_lineCnt  := 0;
   
    -- READLINE FROM INPUT FILE LINE-BY-LINE
   while not ATIO.End_Of_File (inp_fhandle_02) loop
      inp_UBlineStr := ASU.To_Unbounded_String(ATIO.Get_Line (inp_fhandle_02));
      out_lineCnt  := out_lineCnt + 1;
      
      inp_firstChar   := ASU.To_String (ASU.Unbounded_Slice(inp_UBlineStr, 1, 1));
      inp_first3Chars := ASU.To_String (ASU.Unbounded_Slice(inp_UBlineStr, 1, 3));
      
      
      -- LINE ACCOUNTING TO BE SIMPLIFIED LATER
      if (inp_firstChar = "G") then
         out_countG := out_countG + 1;
      end if;
      
      if (inp_firstChar = "#") then
         out_countHash := out_countHash + 1;
      end if;
      
      -- ==================================================
      if    (inp_first3Chars = "G00") then
         out_countG00 := out_countG00 + 1;
      
      elsif (inp_first3Chars = "G01") then
         out_countG01 := out_countG01 + 1;
      
      elsif (inp_first3Chars = "G02") then
         out_countG02 := out_countG02 + 1;
            
      elsif (inp_first3Chars = "G03") then
         out_countG03 := out_countG03 + 1;
      
      elsif (inp_first3Chars = "G21") then
         out_countG21 := out_countG21 + 1;
      
      else
         ATIO.Put_Line("Error. inp_first3Chars = " & (inp_first3Chars) & " not found.");
      end if;   
      
   end loop; 
   
   -- Write to file
   ATIO.Set_Output(out_fhandle_02);
   ATIO.New_Line;
   ATIO.Put_Line("out_countHash = " & Integer'image(out_countHash));
   ATIO.Put_Line("out_countG   = " & Integer'image(out_countG));
   ATIO.Put_Line("out_countG00 = " & Integer'image(out_countG00));
   ATIO.Put_Line("out_countG01 = " & Integer'image(out_countG01));
   ATIO.Put_Line("out_countG02 = " & Integer'image(out_countG02));
   ATIO.Put_Line("out_countG03 = " & Integer'image(out_countG03));
   ATIO.Put_Line("out_countG21 = " & Integer'image(out_countG21));
   ATIO.New_Line;
   ATIO.Put_Line("out_lineCnt  = " & Integer'image(out_lineCnt));
   
   -- Write to terminal
   ATIO.Set_Output(ATIO.Standard_Output);
   ATIO.New_Line;
   ATIO.Put_Line("out_countHash = " & Integer'image(out_countHash));
   ATIO.Put_Line("out_countG   = " & Integer'image(out_countG));
   ATIO.Put_Line("out_countG00 = " & Integer'image(out_countG00));
   ATIO.Put_Line("out_countG01 = " & Integer'image(out_countG01));
   ATIO.Put_Line("out_countG02 = " & Integer'image(out_countG02));
   ATIO.Put_Line("out_countG03 = " & Integer'image(out_countG03));
   ATIO.Put_Line("out_countG21 = " & Integer'image(out_countG21));
   ATIO.New_Line;
   ATIO.Put_Line("out_lineCnt  = " & Integer'image(out_lineCnt));
   
   
   ATIO.Close (out_fhandle_02);
   ATIO.Close (inp_fhandle_02);
   PADTS.exec_delay_sec (2);
   
   -- =====================================================
   ATIO.New_Line;
   PARDF.about_pkg_ada_read_display_file;
   PARWF.about_pkg_ada_read_write_file;
   PAWDF.about_pkg_ada_write_display_file;
         
   ATIO.New_Line; PADTS.dtstamp; ATIO.Put_Line ("Alhamdulillah 3 times WRY");
-- ========================================================   
end main_ada_read_write;
-- ========================================================

