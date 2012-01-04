--------------------------------------------------------------------------------
--  Copyright (c) 2011, Felix Krause
--  All rights reserved.
--
--  Redistribution and use in source and binary forms, with or without
--  modification, are permitted provided that the following conditions are met:
--
--  * Redistributions of source code must retain the above copyright notice,
--    this list of conditions and the following disclaimer.
--  * Redistributions in binary form must reproduce the above copyright notice,
--    this list of conditions and the following disclaimer in the documentation
--    and/or other materials provided with the distribution.
--
--  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
--  AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
--  IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
--  ARE DISCLAIMED.
--  IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY
--  DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
--  (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
--  LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
--  ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
--  (INCLUDING NEGLIGENCE OR OTHERWISE)  ARISING IN ANY WAY OUT OF THE USE OF
--  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
--------------------------------------------------------------------------------

with Glfw.Enums;
with Glfw.Display;

with Glfw.Events.Keys;
with Glfw.Events.Mouse;

with Interfaces.C.Strings;

private package Glfw.Api is

   type Window_Size_Callback is access procedure (Width, Height : C.int);
   type Window_Close_Callback is access function return Bool;
   type Window_Refresh_Callback is access procedure;

   pragma Convention (C, Window_Size_Callback);
   pragma Convention (C, Window_Close_Callback);
   pragma Convention (C, Window_Refresh_Callback);

   type Raw_Video_Mode is array (1 .. 5) of C.int;
   pragma Convention (C, Raw_Video_Mode);

   type Video_Mode_List is array (Positive range <>) of Raw_Video_Mode;
   pragma Convention (C, Video_Mode_List);

   function Init return C.int;
   pragma Import (Convention => StdCall, Entity => Init,
                  External_Name => "glfwInit");

   procedure Glfw_Terminate;
   pragma Import (Convention => StdCall, Entity => Glfw_Terminate,
                  External_Name => "glfwTerminate");

   procedure Get_Version (Major, Minor, Revision : out C.int);
   pragma Import (Convention => StdCall, Entity => Get_Version,
                  External_Name => "glfwGetVersion");

   function Open_Window (Width, Height, Red_Bits, Green_Bits, Blue_Bits,
                         Alpha_Bits, Depth_Bits, Stencil_Bits : C.int;
                         Mode : Display.Display_Mode) return Bool;
   pragma Import (Convention => StdCall, Entity => Open_Window,
                  External_Name => "glfwOpenWindow");

   procedure Open_Window_Hint (Target : Glfw.Enums.Window_Hint; Info : C.int);
   procedure Open_Window_Hint (Target : Glfw.Enums.Window_Hint; Info : Bool);
   procedure Open_Window_Hint (Target : Glfw.Enums.Window_Hint;
                               Info : Display.OpenGL_Profile_Kind);
   pragma Import (Convention => StdCall, Entity => Open_Window_Hint,
                  External_Name => "glfwOpenWindowHint");

   procedure Close_Window;
   pragma Import (Convention => StdCall, Entity => Close_Window,
                  External_Name => "glfwCloseWindow");

   procedure Set_Window_Title (Title : C.Strings.chars_ptr);
   pragma Import (Convention => StdCall, Entity => Set_Window_Title,
                  External_Name => "glfwSetWindowTitle");

   procedure Get_Window_Size (Width, Height : out C.int);
   pragma Import (Convention => StdCall, Entity => Get_Window_Size,
                  External_Name => "glfwGetWindowSize");

   procedure Set_Window_Size (Width, Height : C.int);
   pragma Import (Convention => StdCall, Entity => Set_Window_Size,
                  External_Name => "glfwSetWindowSize");

   procedure Set_Window_Pos (X, Y : C.int);
   pragma Import (Convention => StdCall, Entity => Set_Window_Pos,
                  External_Name => "glfwSetWindowPos");

   procedure Iconify_Window;
   pragma Import (Convention => StdCall, Entity => Iconify_Window,
                  External_Name => "glfwIconifyWindow");

   procedure Restore_Window;
   pragma Import (Convention => StdCall, Entity => Restore_Window,
                  External_Name => "glfwRestoreWindow");

   procedure Swap_Buffers;
   pragma Import (Convention => StdCall, Entity => Swap_Buffers,
                  External_Name => "glfwSwapBuffers");

   procedure Swap_Interval (Interval : C.int);
   pragma Import (Convention => StdCall, Entity => Swap_Interval,
                  External_Name => "glfwSwapInterval");

   function Get_Window_Param (Param : Enums.Window_Info) return C.int;
   function Get_Window_Param (Param : Enums.Window_Info) return Bool;
   function Get_Window_Param (Param : Enums.Window_Info) return Display.OpenGL_Profile_Kind;
   pragma Import (Convention => StdCall, Entity => Get_Window_Param,
                  External_Name => "glfwGetWindowParam");

   procedure Set_Window_Size_Callback (Cb : Window_Size_Callback);
   pragma Import (Convention => StdCall, Entity => Set_Window_Size_Callback,
                  External_Name => "glfwSetWindowSizeCallback");

   procedure Set_Window_Close_Callback (Cb : Window_Close_Callback);
   pragma Import (Convention => StdCall, Entity => Set_Window_Close_Callback,
                  External_Name => "glfwSetWindowCloseCallback");

   procedure Set_Window_Refresh_Callback (Cb : Window_Refresh_Callback);
   pragma Import (Convention => StdCall, Entity => Set_Window_Refresh_Callback,
                  External_Name => "glfwSetWindowCloseCallback");

   function Get_Video_Modes (List : Video_Mode_List;
                             Max_Count : C.int) return C.int;
   pragma Import (Convention => StdCall, Entity => Get_Video_Modes,
                  External_Name => "glfwGetVideoModes");

   procedure Get_Desktop_Mode (Mode : access Raw_Video_Mode);
   pragma Import (Convention => StdCall, Entity => Get_Desktop_Mode,
                  External_Name => "glfwGetDesktopMode");

   procedure Poll_Events;
   pragma Import (Convention => StdCall, Entity => Poll_Events,
                  External_Name => "glfwPollEvents");

   procedure Wait_Events;
   pragma Import (Convention => StdCall, Entity => Wait_Events,
                  External_Name => "glfwWaitEvents");

   function Get_Key (Key : Glfw.Events.Keys.Key) return Glfw.Events.Key_State;
   pragma Import (Convention => StdCall, Entity => Get_Key,
                  External_Name => "glfwGetKey");

   function Get_Mouse_Button (Button : Glfw.Events.Mouse.Button)
                              return Glfw.Events.Key_State;
   pragma Import (Convention => StdCall, Entity => Get_Mouse_Button,
                  External_Name => "glfwGetMouseButton");

   procedure Get_Mouse_Pos (XPos, YPos : out C.int);
   pragma Import (Convention => StdCall, Entity => Get_Mouse_Pos,
                  External_Name => "glfwGetMousePos");

   function Get_Mouse_Wheel return C.int;
   pragma Import (Convention => StdCall, Entity => Get_Mouse_Wheel,
                  External_Name => "glfwGetMouseWheel");

   procedure Set_Mouse_Wheel (Position : C.int);
   pragma Import (Convention => StdCall, Entity => Set_Mouse_Wheel,
                  External_Name => "glfwSetMouseWheel");

   procedure Set_Key_Callback (CbFun : Glfw.Events.Keys.Key_Callback);
   pragma Import (Convention => StdCall, Entity => Set_Key_Callback,
                  External_Name => "glfwSetKeyCallback");

   procedure Set_Char_Callback (CbFun : Glfw.Events.Keys.Character_Callback);
   pragma Import (Convention => StdCall, Entity => Set_Char_Callback,
                  External_Name => "glfwSetCharCallback");

   procedure Set_Mouse_Button_Callback (CbFun : Glfw.Events.Mouse.Button_Callback);
   pragma Import (Convention => StdCall, Entity => Set_Mouse_Button_Callback,
                  External_Name => "glfwSetMouseButtonCallback");

   procedure Set_Mouse_Pos_Callback (CbFun : Glfw.Events.Mouse.Position_Callback);
   pragma Import (Convention => StdCall, Entity => Set_Mouse_Pos_Callback,
                  External_Name => "glfwSetMousePosCallback");

   procedure Set_Mouse_Wheel_Callback (CbFun : Glfw.Events.Mouse.Wheel_Callback);
   pragma Import (Convention => StdCall, Entity => Set_Mouse_Wheel_Callback,
                  External_Name => "glfwSetMouseWheelCallback");

   function Get_Time return C.double;
   pragma Import (Convention => StdCall, Entity => Get_Time,
                  External_Name => "glfwGetTime");

   procedure Set_Time (Value : C.double);
   pragma Import (Convention => StdCall, Entity => Set_Time,
                  External_Name => "glfwSetTime");

   procedure Sleep (Time : C.double);
   pragma Import (Convention => StdCall, Entity => Sleep,
                  External_Name => "glfwSleep");

   function Extension_Supported (Name : C.char_array) return Bool;
   pragma Import (Convention => StdCall, Entity => Extension_Supported,
                  External_Name => "glfwExtensionSupported");

   procedure Get_GL_Version (Major, Minor, Rev : out C.int);
   pragma Import (Convention => StdCall, Entity => Get_GL_Version,
                  External_Name => "glfwGetGLVersion");

   procedure Enable (Target : Enums.Feature);
   pragma Import (Convention => StdCall, Entity => Enable,
                  External_Name => "glfwEnable");

   procedure Disable (Target : Enums.Feature);
   pragma Import (Convention => StdCall, Entity => Disable,
                  External_Name => "glfwDisable");

end Glfw.Api;
