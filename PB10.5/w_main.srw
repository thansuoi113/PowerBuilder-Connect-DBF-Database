$PBExportHeader$w_main.srw
forward
global type w_main from window
end type
type cb_6 from commandbutton within w_main
end type
type cb_5 from commandbutton within w_main
end type
type dw_test from datawindow within w_main
end type
type st_4 from statictext within w_main
end type
type cb_4 from commandbutton within w_main
end type
type st_1 from statictext within w_main
end type
type cb_3 from commandbutton within w_main
end type
type cb_2 from commandbutton within w_main
end type
type sle_db from singlelineedit within w_main
end type
type cb_1 from commandbutton within w_main
end type
type system_info from structure within w_main
end type
end forward

type system_info from structure
	unsignedinteger		wprocessorarchitecture
	unsignedinteger		wreserved
	unsignedlong		dwpagesize
	unsignedlong		lpminimumapplicationaddress
	unsignedlong		lpmaximumapplicationaddress
	unsignedlong		dwactiveprocessormask
	unsignedlong		dwnumberofprocessors
	unsignedlong		dwprocessortype
	unsignedlong		dwallocationgranularity
	unsignedinteger		wprocessorlevel
	unsignedinteger		wprocessorrevsion
end type

global type w_main from window
integer width = 2194
integer height = 1220
boolean titlebar = true
string title = "Connect DBF"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
cb_6 cb_6
cb_5 cb_5
dw_test dw_test
st_4 st_4
cb_4 cb_4
st_1 st_1
cb_3 cb_3
cb_2 cb_2
sle_db sle_db
cb_1 cb_1
end type
global w_main w_main

type prototypes
Subroutine GetNativeSystemInfo ( 	Ref SYSTEM_INFO lpSystemInfo ) Library "kernel32.dll"
Subroutine GetSystemInfo ( Ref SYSTEM_INFO lpSystemInfo ) Library "kernel32.dll"
Function Boolean IsWow64Process ( Long hProcess, 	Ref Boolean Wow64Process ) Library "kernel32.dll"
Function Long GetCurrentProcess ( ) Library "kernel32.dll"

end prototypes

type variables
transaction itran
end variables

forward prototypes
public function integer wf_getosbits ()
end prototypes

public function integer wf_getosbits ();// This function determines if OS is 32 bits or 64 bits.

Constant Long PROCESSOR_ARCHITECTURE_INTEL = 0	// x86
Constant Long PROCESSOR_ARCHITECTURE_IA64  = 6	// Intel Itanium-based
Constant Long PROCESSOR_ARCHITECTURE_AMD64 = 9	// x64 (AMD or Intel)
SYSTEM_INFO lstr_si
Integer li_bits
Boolean lb_IsWow64

IsWOW64Process(GetCurrentProcess(), lb_IsWow64)

If lb_IsWow64 Then
	GetNativeSystemInfo(lstr_si)
Else
	GetSystemInfo(lstr_si)
End If

choose case lstr_si.wProcessorArchitecture
	case PROCESSOR_ARCHITECTURE_IA64
		li_bits = 64
	case PROCESSOR_ARCHITECTURE_AMD64
		li_bits = 64
	case else
		li_bits = 32
end choose

Return li_bits

end function

on w_main.create
this.cb_6=create cb_6
this.cb_5=create cb_5
this.dw_test=create dw_test
this.st_4=create st_4
this.cb_4=create cb_4
this.st_1=create st_1
this.cb_3=create cb_3
this.cb_2=create cb_2
this.sle_db=create sle_db
this.cb_1=create cb_1
this.Control[]={this.cb_6,&
this.cb_5,&
this.dw_test,&
this.st_4,&
this.cb_4,&
this.st_1,&
this.cb_3,&
this.cb_2,&
this.sle_db,&
this.cb_1}
end on

on w_main.destroy
destroy(this.cb_6)
destroy(this.cb_5)
destroy(this.dw_test)
destroy(this.st_4)
destroy(this.cb_4)
destroy(this.st_1)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.sle_db)
destroy(this.cb_1)
end on

event open;string ls_path
ls_path = GetCurrentDirectory ( )

sle_db.text = ls_path
end event

event close;If IsValid(itran) Then
	Disconnect Using itran ;
	Destroy itran
End If

end event

type cb_6 from commandbutton within w_main
integer x = 937
integer y = 360
integer width = 462
integer height = 92
integer taborder = 40
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Connect OLE DB"
end type

event clicked;String ls_db, ls_database,  ls_user, ls_pass, ls_odbcjt32

dw_test.reset()

ls_database = sle_db.Text


Transaction ltran_conn
ltran_conn = Create Transaction

// Using OLE DB Connect To MS DBF 
ltran_conn.DBMS ="OLE DB"
ltran_conn.AutoCommit = False
ltran_conn.DBParm = "PROVIDER='Microsoft.Jet.OLEDB.4.0',PROVIDERSTRING='dBASE IV',DATASOURCE='"+ls_database+""

Connect Using ltran_conn ;
If ltran_conn.SQLCode = -1 Then
	MessageBox('Warning','Connect Database Error' + ltran_conn.SQLErrText)
Else
	MessageBox('Warning',"Connect Success!")
End If

//Disconnect Using ltran_conn ;
itran = ltran_conn
end event

type cb_5 from commandbutton within w_main
integer x = 1563
integer y = 360
integer width = 270
integer height = 92
integer taborder = 30
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Retrieve"
end type

event clicked;If Not  IsValid(itran) Then Return
If itran.dbhandle( ) = 0  Then Return
dw_test.settransobject(itran )
dw_test.Retrieve( )

end event

type dw_test from datawindow within w_main
integer x = 37
integer y = 480
integer width = 2085
integer height = 608
integer taborder = 30
string title = "none"
string dataobject = "d_test"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type st_4 from statictext within w_main
integer x = 55
integer y = 40
integer width = 2139
integer height = 136
integer textsize = -18
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Connect DBF Database"
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_4 from commandbutton within w_main
integer x = 2007
integer y = 216
integer width = 123
integer height = 92
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "..."
end type

event clicked;String ls_path, ls_file
Int li_rc

ls_path = sle_db.Text
//li_rc = GetFileSaveName ( "Select File",   ls_path, ls_file, "dbf",  "Microsoft FoxPro/dBASE (*.dbf),*.dbf,All Files (*.*),*.*" )
li_rc = GetFolder( "Choose Folder", ls_path )
If li_rc = 1 Then
	sle_db.Text = ls_path
End If


end event

type st_1 from statictext within w_main
integer x = 55
integer y = 228
integer width = 178
integer height = 56
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Folder:"
alignment alignment = right!
boolean focusrectangle = false
end type

type cb_3 from commandbutton within w_main
integer x = 1861
integer y = 360
integer width = 265
integer height = 92
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Close"
end type

event clicked;Close(Parent)
end event

type cb_2 from commandbutton within w_main
integer x = 503
integer y = 360
integer width = 411
integer height = 92
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Connect JDBC"
end type

event clicked;String ls_path, ls_classpath
Boolean lb_jvm_started, lb_debug
javavm ljvm
ls_path = GetCurrentDirectory ( )

dw_test.reset()

// set classpath or you can environment variables of window
ls_classpath = ls_path + "\dans-dbf-lib-1.0.0-beta-10.jar"

If Not FileExists(ls_classpath) Then
	MessageBox('Warning',"driver class file not exists")
	Return
End If

If Not FileExists(ls_path +"\csvjdbc-1.0-36.jar") Then
	MessageBox('Warning',"driver class file not exists")
	Return
End If

// add libary
ls_classpath = ls_classpath + ";" + ls_path +"\csvjdbc-1.0-36.jar"
//ls_classpath = ls_classpath + ";" + ls_path +"\FoxProJdbcDriver\javadbf-1.11.2.jar"

If Not lb_jvm_started Then
	ljvm = Create javavm //using pbejbclientXXX.pbd
	Choose Case ljvm.createJavaVM(ls_classpath, lb_debug)
		Case 0
			lb_jvm_started = True
		Case -1
			MessageBox('Warning',"Failed to load JavaVM")
			Return
		Case -2
			MessageBox('Warning',"Failed to load EJBLocator")
			Return
	End Choose
End If


// Get infor
String ls_url, ls_database,  ls_user, ls_pass

ls_database = sle_db.Text

ls_url = "jdbc:relique:csv:"+ ls_database

//connect
Transaction ltran_conn
ltran_conn = Create Transaction

ltran_conn.DBMS = "JDBC"
ltran_conn.AutoCommit = False
ltran_conn.DBParm = "Driver='org.relique.jdbc.csv.CsvDriver',URL='"+ls_url+"?fileExtension=.dbf'"

Connect Using ltran_conn ;
If ltran_conn.SQLCode = -1 Then
	MessageBox('Warning','Connect Database Error' + ltran_conn.SQLErrText)
Else
	MessageBox('Warning',"Connect Success!")
End If

itran = ltran_conn
//Disconnect Using ltran_conn ;

end event

type sle_db from singlelineedit within w_main
integer x = 233
integer y = 220
integer width = 1760
integer height = 80
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type cb_1 from commandbutton within w_main
integer x = 50
integer y = 360
integer width = 430
integer height = 92
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Connect ODBC"
end type

event clicked;String ls_db, ls_database,  ls_user, ls_pass, ls_odbcjt32

dw_test.reset()

If wf_GetOSBits() = 64 Then
	ls_odbcjt32 = "C:\Windows\SysWOW64\odbcjt32.dll"
Else
	ls_odbcjt32 = "C:\Windows\System32\odbcjt32.dll"
End If

ls_db = "PBDBFA"
ls_database = sle_db.Text

//set database Transaction.database or odbc DefaultDir
//RegistrySet("HKEY_CURRENT_USE\Software\ODBC\ODBC.INI\"+ls_db,"DefaultDir",RegString!,ls_database)
RegistrySet("HKEY_CURRENT_USE\Software\ODBC\ODBC.INI\"+ls_db,"Driver",RegString!,ls_odbcjt32)
RegistrySet("HKEY_CURRENT_USE\Software\ODBC\ODBC.INI\"+ls_db,"DriverId",ReguLong!,533)
RegistrySet("HKEY_CURRENT_USE\Software\ODBC\ODBC.INI\"+ls_db,"FIL",RegString!,"dBase 5.0")
RegistrySet("HKEY_CURRENT_USER\SOFTWARE\ODBC\ODBC.INI\ODBC DATA SOURCES",ls_db, RegString!, "Driver do Microsoft dBase (*.dbf)")

RegistrySet("HKEY_CURRENT_USE\Software\ODBC\ODBC.INI\"+ls_db+"\Engines\Xbase","CollatingSequence",RegString!,"ASCII")
RegistrySet("HKEY_CURRENT_USE\Software\ODBC\ODBC.INI\"+ls_db+"\Engines\Xbase","PageTimeout",ReguLong!,5)
RegistrySet("HKEY_CURRENT_USE\Software\ODBC\ODBC.INI\"+ls_db+"\Engines\Xbase","Threads",ReguLong!,3)
RegistrySet("HKEY_CURRENT_USE\Software\ODBC\ODBC.INI\"+ls_db+"\Engines\Xbase","ImplicitCommitSync",RegString!,"")


Transaction ltran_conn
//if isvalid(ltran_conn) then destroy ltran_conn
ltran_conn = Create Transaction


// Using ODBC Connect To MS DBF 
ltran_conn.DBMS = "ODBC"
ltran_conn.database = ls_database
ltran_conn.AutoCommit = False
ltran_conn.DBParm = "ConnectString='DSN="+ls_db+"'"

Connect Using ltran_conn ;
If ltran_conn.SQLCode = -1 Then
	MessageBox('Warning','Connect Database Error' + ltran_conn.SQLErrText)
Else
	MessageBox('Warning',"Connect Success!")
End If

itran = ltran_conn
//Disconnect Using ltran_conn ;

end event

