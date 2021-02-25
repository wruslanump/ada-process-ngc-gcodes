-- File	: pkg_ada_write_display_file.adb
-- Date	: Tue 23 Feb 2021 04:39:09 PM +08
-- Env	: Linux HPEliteBook8470p-Ub2004-rt38 5.4.66-rt38 
-- #1 SMP PREEMPT_RT Sat Sep 26 16:51:59 +08 2020 x86_64 x86_64 x86_64 GNU/Linux
-- Author: WRY wruslandr@gmail.com
-- ========================================================

-- ADA STANDARD PACKAGES
with Ada.Text_IO;
with Ada.Numerics;

-- ADA STRING MANIPULATION
-- Ada has three(3) types of strings: fixed length, bounded length, unbounded.
with Ada.Strings;
with Ada.Strings.Fixed;
with Ada.Strings.Bounded;
with Ada.Strings.Unbounded;
with Ada.Strings.Unbounded.Text_IO;
with Ada.Command_Line;


-- WRY CREATED PACKAGES 
with pkg_ada_dtstamp;
with pkg_ada_random;

-- ========================================================
package body pkg_ada_write_display_file 
-- ========================================================
--   with SPARK_Mode => on
is

   package ATIO renames Ada.Text_IO;
   package ASU  renames Ada.Strings.Unbounded;
   
   package PADTS renames pkg_ada_dtstamp;
   package PAR   renames pkg_ada_random;
   
   -- =====================================================
   out_fhandle : ATIO.File_Type;
   
   rand_int1   : Integer := 999; 
   rand_float1 : Float   := 999.99;
   rand_int2   : Integer := 999; 
   rand_float2 : Float   := 999.99;
   rand_int3   : Integer := 999; 
   rand_float3 : Float   := 999.99;
   
   -- ==================================================== 
   procedure exec_write_display_file (out_fmode : in AATIO.File_Mode; out_fname : in String)
   -- =====================================================   
     is
      
   begin
      ATIO.Put_Line("Run exec_write_display_file (out_fmode, out_fname)");
      ATIO.Put_Line("out_fmode = ATIO.Out_File ");
      ATIO.Put_Line("out_fname = " & (out_fname));
      
      ATIO.Put_Line("ToCreate out_fname = " & out_fname);
      ATIO.Create (out_fhandle, out_fmode, out_fname); 
      ATIO.Put_Line("Created  out_fname = " & out_fname & " successfully.");
      ATIO.New_Line;
   
      -- Write lines
      for line_num in 1 .. 100 loop
         
         -- Get random integer and float
         rand_int1   := PAR.get_random_integer (0, 10);
         rand_int2   := PAR.get_random_integer (-10, +10); 
         rand_int3   := PAR.get_random_integer (155, 199); 
         
         rand_float1 := PAR.get_random_float   (0.0, 10.0); 
         rand_float2 := PAR.get_random_float   (-10.0, +10.0); 
         rand_float3 := PAR.get_random_float   (255.044, 299.044); 
   
         -- Write to terminal random integers and floats
         ATIO.Set_Output(ATIO.Standard_Output);
         ATIO.Put ("LINE_NO " & Integer'Image(line_num) & " : "); 
         ATIO.Put (Integer'Image(rand_int1) & " ");
         ATIO.Put (Integer'Image(rand_int2) & " ");  
         ATIO.Put (Integer'Image(rand_int3) & " "); 
         ATIO.Put (Float'Image(rand_float1) & " "); 
         ATIO.Put (Float'Image(rand_float2) & " "); 
         ATIO.Put (Float'Image(rand_float3) & " "); 
         ATIO.New_Line;
   
         -- Write to file random integers and floats  
         ATIO.Set_Output(out_fhandle);
         ATIO.Put ("LINE_NO " & Integer'Image(line_num) & " : "); 
         ATIO.Put (Integer'Image(rand_int1) & " ");
         ATIO.Put (Integer'Image(rand_int2) & " ");  
         ATIO.Put (Integer'Image(rand_int3) & " "); 
         ATIO.Put (Float'Image(rand_float1) & " "); 
         ATIO.Put (Float'Image(rand_float2) & " "); 
         ATIO.Put (Float'Image(rand_float3) & " "); 
         ATIO.New_Line;
         
      end loop;
      ATIO.Set_Output(ATIO.Standard_Output);
      
      ATIO.Close(out_fhandle);
      PADTS.exec_delay_sec (2);
      -- provide 2 seconds delay to make closing files take effect
      
   end exec_write_display_file;
   
   -- =====================================================
   procedure about_pkg_ada_write_display_file
   -- =====================================================
   is 
   
   begin 
      ATIO.Put_Line("About_pkg_ada_write_display_file (PAWDF)");

   end about_pkg_ada_write_display_file;

-- =======================================================   
begin
  null;
-- ========================================================
end pkg_ada_write_display_file;
-- ========================================================    
   
