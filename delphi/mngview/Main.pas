unit Main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, StdCtrls, ExtCtrls, Buttons,
  libmng;

{****************************************************************************}

type
  TMainForm = class(TForm)

    OFMainMenu: TMainMenu;
    OFMenuFile: TMenuItem;
    OFMenuFileOpen: TMenuItem;
    OFMenuFileProfile: TMenuItem;
    OFMenuFileN1: TMenuItem;
    OFMenuFileExit: TMenuItem;

    OFMenuOptions: TMenuItem;
    OFMenuOptionsModemSpeed: TMenuItem;
    OFMenuOptionsModem28k8: TMenuItem;
    OFMenuOptionsModem33k6: TMenuItem;
    OFMenuOptionsModem56k: TMenuItem;
    OFMenuOptionsModemISDN64: TMenuItem;
    OFMenuOptionsModemISDN128: TMenuItem;
    OFMenuOptionsModemCable512: TMenuItem;
    OFMenuOptionsModemUnlimited: TMenuItem;

    OFTimer: TTimer;

    OFOpenDialog: TOpenDialog;
    OFOpenDialogProfile: TOpenDialog;

    OFImage: TImage;

    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormShow(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);

    procedure OFTimerTimer(Sender: TObject);

    procedure OFMenuFileOpenClick(Sender: TObject);
    procedure OFMenuFileProfileClick(Sender: TObject);
    procedure OFMenuFileExitClick(Sender: TObject);

    procedure OFMenuOptionsModemSpeedClick(Sender: TObject);
    procedure OFMenuOptionsModemXClick(Sender: TObject);

  private
    { Private declarations }

    SFFileName    : string;            { filename of the input stream }
    OFFile        : TFileStream;       { input stream }
    IFHandle      : mng_handle;        { the libray handle }
    OFBitmap      : TBitmap;           { drawing canvas }
    BFCancelled   : boolean;           { <esc> or app-exit }

    IFTicks       : cardinal;          { used to fake slow connections }
    IFBytes       : cardinal;
    IFBytesPerSec : cardinal;

    procedure MNGerror (SHMsg : string);

  public
    { Public declarations }

  end;

var
  MainForm: TMainForm;

{****************************************************************************}

implementation

{$R *.DFM}

{****************************************************************************}

{$F+}
function  Memalloc (iLen : mng_uint32) : mng_ptr; cdecl;
{$F-}
begin
  getmem   (Result, iLen);             { get memory from the heap }
  fillchar (Result^, iLen, 0);         { and initialize it }
end;

{****************************************************************************}

{$F+}
procedure Memfree (iPtr : mng_ptr;
                   iLen : mng_uint32); cdecl;
{$F-}
begin
  freemem (iPtr, iLen);                { free the memory }
end;

{****************************************************************************}

{$F+}
procedure Openstream (hHandle : mng_handle); cdecl;
{$F-}

var OHForm : TMainForm;

begin                                  { get a fix on our form }
  OHForm := TMainForm (mng_get_userdata (hHandle));

  with OHFORM do
  begin
    if OFFile <> nil then              { free previous stream (if any) }
      OFFile.Free;
                                       { open a new stream }
    OFFile := TFileStream.Create (SFFileName, fmOpenRead or fmShareDenyWrite);
  end;
end;

{****************************************************************************}

{$F+}
procedure Closestream (hHandle : mng_handle); cdecl;
{$F-}

var OHForm : TMainForm;

begin                                  { get a fix on our form }
  OHForm := TMainForm (mng_get_userdata (hHandle));

  with OHFORM do
  begin
    OFFile.Free;                       { cleanup the stream }
    OFFile := nil;                     { don't use it again ! }
  end;
end;

{****************************************************************************}

{$F+}
function Readdata (    hHandle : mng_handle;
                       pBuf    : mng_ptr;
                       iBuflen : mng_uint32;
                   var pRead   : mng_uint32) : mng_retcode; cdecl;
{$F-}

var OHForm        : TMainForm;
    IHTicks       : cardinal;
    IHByte1       : cardinal;
    IHByte2       : cardinal;
    IHBytesPerSec : cardinal;

begin
  Result := 0;                         { get a fix on our form }
  OHForm := TMainForm (mng_get_userdata (hHandle));

  with OHForm do
  begin                                { are we at EOF ? }
    if OFFile.Position >= OFFile.Size then
    begin
      pRead := 0;                      { indicate so }
    end
    else
    begin
      IHBytesPerSec := IFBytesPerSec;  { fake a slow connection }

      if IHBytesPerSec > 0 then
      begin
        IHTicks       := Windows.GetTickCount;
        IHByte1       := (IHTicks - IFTicks) * IHBytesPerSec;
        IHByte2       := (IFBytes + iBuflen) * 1000;

        if ((IHByte2 - IHByte1) div IHBytesPerSec) > 10 then
          Windows.Sleep ((IHByte2 - IHByte1) div IHBytesPerSec);

      end;
                                       { read the requested data }
      pRead   := OFFile.Read (pBuf^, iBuflen);
      IFBytes := IFBytes + pRead;
    end;
  end;
end;

{****************************************************************************}

{$F+}
procedure ProcessHeader (hHandle : mng_handle;
                         iWidth  : mng_uint32;
                         iHeight : mng_uint32); cdecl;
{$F-}

var OHForm : TMainForm;

begin                                  { get a fix on our form }
  OHForm := TMainForm (mng_get_userdata (hHandle));

  with OHForm do
  begin
    OFBitmap.Width  := iWidth;         { store the new dimensions }
    OFBitmap.Height := iHeight;
    OFImage.Left    := 0;              { adjust the visible component }
    OFImage.Top     := 0;
    OFImage.Width   := iWidth;
    OFImage.Height  := iHeight;

    FormResize (OHForm);               { force re-centering the image}
                                       { clear the canvas & draw an outline }
    OFBitmap.Canvas.Brush.Color := clGray;
    OFBitmap.Canvas.Brush.Style := bsSolid;
    OFBitmap.Canvas.FillRect  (OFBitmap.Canvas.ClipRect);
    OFBitmap.Canvas.Brush.Color := clRed;
    OFBitmap.Canvas.Brush.Style := bsSolid;
    OFBitmap.Canvas.Pen.Color   := clRed;
    OFBitmap.Canvas.Pen.Style   := psSolid;
    OFBitmap.Canvas.FrameRect (OFBitmap.Canvas.ClipRect);

    OFImage.Picture.Assign (OFBitmap); { make sure it's gets out there }
                                       { tell the library we want funny windows-bgr}
    if mng_set_canvasstyle (hHandle, MNG_CANVAS_BGR8) <> 0 then
      MNGerror ('libmng reported an error setting the canvas style');

  end;
end;

{****************************************************************************}

{$F+}
function GetCanvasLine (hHandle : mng_handle;
                        iLinenr : mng_uint32) : mng_ptr; cdecl;
{$F-}

var OHForm : TMainForm;

begin                                  { get a fix on our form }
  OHForm := TMainForm (mng_get_userdata (hHandle));
                                       { easy with these bitmap objects ! }
  Result := OHForm.OFBitmap.ScanLine [iLinenr];
end;

{****************************************************************************}

{$F+}
procedure ImageRefresh (hHandle : mng_handle;
                        iTop    : mng_uint32;
                        iLeft   : mng_uint32;
                        iBottom : mng_uint32;
                        iRight  : mng_uint32); cdecl;
{$F-}

var OHForm : TMainForm;

begin                                  { get a fix on our form }
  OHForm := TMainForm (mng_get_userdata (hHandle));
                                       { force redraw }
  OHForm.OFImage.Picture.Assign (OHForm.OFBitmap);
  Application.ProcessMessages;
end;


{****************************************************************************}

{$F+}
function GetTickCount (hHandle : mng_handle) : mng_uint32; cdecl;
{$F-}
begin
  Result := Windows.GetTickCount;      { windows knows that }
end;

{****************************************************************************}

{$F+}
procedure SetTimer (hHandle : mng_handle;
                    iMsecs  : mng_uint32); cdecl;
{$F-}

var OHForm : TMainForm;

begin                                  { get a fix on our form }
  OHForm := TMainForm (mng_get_userdata (hHandle));
  OHForm.OFTimer.Interval := iMsecs;   { and set the timer }
  OHForm.OFTimer.Enabled  := true;
end;

{****************************************************************************}

procedure TMainForm.FormCreate(Sender: TObject);

var   SHProfileName          : array [0 .. MAX_PATH + 100] of char;
      IHRed, IHGreen, IHBlue : word;

begin
  OFBitmap      := TBitmap.Create;     { initialize }
  IFBytesPerSec := 10000000;
  OFFile        := nil;

  OFOpenDialog.Initialdir := '';
  OFBitmap.HandleType     := bmDIB;    { make it a 24-bit DIB }
  OFBitmap.PixelFormat    := pf24bit;
                                       { try to locate the "standard" sRGB profile }
  GetSystemDirectory (@SHProfileName, MAX_PATH);
  strcat (@SHProfileName, '\Color\sRGB Color Space Profile.ICM');
                                       { now initialize the library }
  IFHandle := mng_initialize (mng_int32(self), Memalloc, Memfree, nil);

  if IFHandle = 0 then
    MNGerror ('libmng initializiation error');
                                       { supply it with the sRGB profile }
  if (mng_set_srgb            (IFHandle, true          ) <> 0) or
     (mng_set_outputprofile   (IFHandle, @SHProfileName) <> 0) then
  begin
    MNGerror ('libmng reported an error setting the CMS conditions!');
    exit;
  end;
                                       { set all the callbacks }
  if (mng_setcb_openstream    (IFHandle, Openstream   ) <> 0) or
     (mng_setcb_closestream   (IFHandle, Closestream  ) <> 0) or
     (mng_setcb_readdata      (IFHandle, Readdata     ) <> 0) or
     (mng_setcb_processheader (IFHandle, ProcessHeader) <> 0) or
     (mng_setcb_getcanvasline (IFHandle, GetCanvasLine) <> 0) or
     (mng_setcb_refresh       (IFHandle, ImageRefresh ) <> 0) or
     (mng_setcb_gettickcount  (IFHandle, GetTickCount ) <> 0) or
     (mng_setcb_settimer      (IFHandle, SetTimer     ) <> 0) then
  begin
    MNGerror ('libmng reported an error setting a callback function!');
    exit;
  end;

  IHRed   := (Color       ) and $FF;   { supply our own bg-color }
  IHGreen := (Color shr  8) and $FF;
  IHBlue  := (Color shr 16) and $FF;

  IHRed   := (IHRed   shl 8) + IHRed;
  IHGreen := (IHGreen shl 8) + IHGreen;
  IHBlue  := (IHBlue  shl 8) + IHBlue;

  if mng_set_bgcolor (IFHandle, IHRed, IHGreen, IHBlue) <> 0 then
    MNGerror ('libmng reported an error setting the background color!');

end;

{****************************************************************************}

procedure TMainForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  BFCancelled := true;

  if OFTimer.Enabled then              { if we're still animating then stop it }
    if mng_display_freeze (IFHandle) <> 0 then
      MNGerror ('libmng reported an error during display_freeze!');

  OFTimer.Enabled := false;
end;

{****************************************************************************}

procedure TMainForm.FormShow(Sender: TObject);
begin
  FormResize (self);
end;

{****************************************************************************}

procedure TMainForm.FormResize(Sender: TObject);
begin                                  { center the image in the window }
  if ClientWidth  < OFImage.Width  then
    OFImage.Left := 0
  else
    OFImage.Left := (ClientWidth  - OFImage.Width ) div 2;

  if ClientHeight < OFImage.Height then
    OFImage.Top  := 0
  else
    OFImage.Top  := (ClientHeight - OFImage.Height) div 2;

end;

{****************************************************************************}

procedure TMainForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = vk_Escape then              { pressing <esc> will freeze an animation }
  begin
    if OFTimer.Enabled then
      if mng_display_freeze (IFHandle) <> 0 then
        MNGerror ('libmng reported an error during display_freeze!');

    OFTimer.Enabled := false;          { don't let that timer go off then ! }
    BFCancelled     := true;
  end;
end;

{****************************************************************************}

procedure TMainForm.OFTimerTimer(Sender: TObject);
begin
  OFTimer.Enabled := false;            { only once ! }

  if not BFCancelled then              { and inform the library }
    if mng_display_resume (IFHandle) <> 0 then
      MNGerror ('libmng reported an error during display_resume!');

end;

{****************************************************************************}

procedure TMainForm.OFMenuFileOpenClick(Sender: TObject);
begin
  OFOpenDialog.InitialDir := '';
  OFOpenDialog.FileName   := SFFileName;

  if OFOpenDialog.Execute then         { get the filename }
  begin
    if OFTimer.Enabled then            { if the lib was active; stop it }
      if mng_display_freeze (IFHandle) <> 0 then
        MNGerror ('libmng reported an error during display_freeze!');

    OFTimer.Enabled := false;          { save interesting fields }
    SFFileName      := OFOpenDialog.FileName;
    IFTicks         := Windows.GetTickCount;
    IFBytes         := 0;
    BFCancelled     := false;

    if mng_reset (IFHandle) <> 0 then  { always reset (just in case) }
      MNGerror ('libmng reported an error during reset!')
    else                               { and let the lib do it's job ! }
    if mng_readdisplay (IFHandle) <> 0 then
      MNGerror ('libmng reported an error reading the input file!');

  end;
end;

{****************************************************************************}

procedure TMainForm.OFMenuFileProfileClick(Sender: TObject);

var SHProfileDir : array [0 .. MAX_PATH + 20] of char;

begin
  GetSystemDirectory (@SHProfileDir, MAX_PATH);
  strcat (@SHProfileDir, '\Color');

  OFOpenDialogProfile.InitialDir := strpas (@SHProfileDir);

  if OFOpenDialogProfile.Execute then
    if mng_set_outputprofile (IFHandle, pchar (OFOpenDialogProfile.FileName)) <> 0 then
      MNGerror ('libmng reported an error setting the output-profile!');

end;

{****************************************************************************}

procedure TMainForm.OFMenuFileExitClick(Sender: TObject);
begin
  if mng_cleanup (IFHandle) <> 0 then
    MNGerror ('libmng cleanup error');

  Close;
end;

{****************************************************************************}

procedure TMainForm.OFMenuOptionsModemSpeedClick(Sender: TObject);
begin
  OFMenuOptionsModem28k8.Checked      := false;
  OFMenuOptionsModem33k6.Checked      := false;
  OFMenuOptionsModem56k.Checked       := false;
  OFMenuOptionsModemISDN64.Checked    := false;
  OFMenuOptionsModemISDN128.Checked   := false;
  OFMenuOptionsModemCable512.Checked  := false;
  OFMenuOptionsModemUnlimited.Checked := false;

  if IFBytesPerSec = OFMenuOptionsModem28k8.Tag      div 10 then
    OFMenuOptionsModem28k8.Checked      := true
  else
  if IFBytesPerSec = OFMenuOptionsModem33k6.Tag      div 10 then
    OFMenuOptionsModem33k6.Checked      := true
  else
  if IFBytesPerSec = OFMenuOptionsModem56k.Tag       div 10 then
    OFMenuOptionsModem56k.Checked       := true
  else
  if IFBytesPerSec = OFMenuOptionsModemISDN64.Tag    div 10 then
    OFMenuOptionsModemISDN64.Checked    := true
  else
  if IFBytesPerSec = OFMenuOptionsModemISDN128.Tag   div 10 then
    OFMenuOptionsModemISDN128.Checked   := true
  else
  if IFBytesPerSec = OFMenuOptionsModemUnlimited.Tag div 10 then
    OFMenuOptionsModemCable512.Checked  := true
  else
    OFMenuOptionsModemUnlimited.Checked := true;

end;

{****************************************************************************}

procedure TMainForm.OFMenuOptionsModemXClick(Sender: TObject);
begin
  IFBytesPerSec := TMenuItem (Sender).Tag div 10;
end;

{****************************************************************************}

procedure TMainForm.MNGerror;

var iErrorcode : mng_uint32;
    iSeverity  : mng_uint8;
    iChunkname : mng_chunkid;
    iChunkseq  : mng_uint32;
    iExtra1    : mng_int32;
    iExtra2    : mng_int32;
    zErrortext : mng_pchar;

begin                                  { get extended info }
  iErrorcode := mng_getlasterror (IFHandle, iSeverity, iChunkname, iChunkseq,
                                            iExtra1, iExtra2, zErrortext);

  MessageDlg (SHMsg + #13#10#13#10 + mng_errorname (iErrorcode) + #13#10#13#10 +
              Format ('Error = %d; Severity = %d; Chunknr = %d; Extra1 = %d',
                      [iErrorcode, iSeverity, iChunkseq, iExtra1]),
              mtError, [mbOK], 0);
end;

{****************************************************************************}

end.
