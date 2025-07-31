Return-Path: <linux-kernel+bounces-751604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ABB70B16B63
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 07:00:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C45D21AA0661
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 05:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB77923B619;
	Thu, 31 Jul 2025 05:00:29 +0000 (UTC)
Received: from mail.comtrue-inc.com (220-134-147-48.hinet-ip.hinet.net [220.134.147.48])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C97713D512;
	Thu, 31 Jul 2025 05:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.134.147.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753938029; cv=none; b=KCYjUsgg0tJpwRFbhzib8VF8r8VjoXgu8s/VntiqDz1b+Hws0hUHqZCdY7TWXX6JXBRBWIJFIOdwZ59ct9Ca4P4cnQYrtJJqlhmMlM1HbKwx7lUVEelwO4ws0g7HYeVSD8EEelZje6RLrJ1ON74KEj1MjLIemq6++Bn3nm9+JwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753938029; c=relaxed/simple;
	bh=gZ9PUbdTg7cMsplRGAXBlhb3hEK01avE8VBUDyx4wd4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lCBj9XXUJ6UOLCMrrnpiIt0sN0IQDcBbmVgRPITw41/VrvjCBSA4Vp+8xKXxn+muZVADqwJYtmTq/o7lCm+X1ouEdmWEM+9jlqn2cWJpJ81S5aeLcWEyRrL/+x+5JYiXCFy/SM+VPxHDybJf8BEjL7ATBuTBHNPv6EW2nvrOlB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=comtrue-inc.com; spf=pass smtp.mailfrom=comtrue-inc.com; arc=none smtp.client-ip=220.134.147.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=comtrue-inc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=comtrue-inc.com
Received: from T470p (111-240-71-216.dynamic-ip.hinet.net [111.240.71.216])
	by mail.comtrue-inc.com (Postfix) with ESMTPA id 13932181713;
	Thu, 31 Jul 2025 12:51:37 +0800 (CST)
From: <noble.yang@comtrue-inc.com>
To: <tiwai@suse.com>,
	<perex@perex.cz>,
	<hulianqin@vivo.com>,
	<lina+kernel@asahilina.net>,
	<cyan.vtb@gmail.com>,
	<dan.carpenter@linaro.org>,
	<bsevens@google.com>
Cc: <linux-sound@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH] ALSA: usb-audio: Add DSD support for Comtrue USB Audio device
Date: Thu, 31 Jul 2025 12:51:37 +0800
Message-ID: <001e01dc01d6$cc4c64e0$64e52ea0$@comtrue-inc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_001F_01DC0219.DA6FA4E0"
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AdwB0zvAsyNlTETcSKiGBDeb+Tco7w==
Content-Language: zh-tw

This is a multipart message in MIME format.

------=_NextPart_000_001F_01DC0219.DA6FA4E0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_001_0020_01DC0219.DA6FA4E0"


------=_NextPart_001_0020_01DC0219.DA6FA4E0
Content-Type: text/plain;
	charset="big5"
Content-Transfer-Encoding: quoted-printable

The vendor Comtrue Inc. (0x2fc6) produces USB audio chipsets like

the CT7601 which are capable of Native DSD playback.

=20

This patch adds QUIRK_FLAG_DSD_RAW for Comtrue (VID 0x2fc6), which =
enables

native DSD playback (DSD_U32_LE) on their USB Audio device. This has =
been

verified under Ubuntu 25.04 with JRiver.

=20

Best Regards !

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D

Noble Yang

Cell : +886-955-347822

=B1=E1=BF=B2=AA=D1=A5=F7=A6=B3=AD=AD=A4=BD=A5q

Comtrue Inc.

www.comtrue-inc.com <http://www.comtrue-inc.com/>=20

=B7s=A6a=A7} : =
=B7s=A6=CB=BF=A4=A6=CB=A5_=A5=AB=BF=A4=ACF=A4Q=B5=F310=B8=B92F=A4=A71

2F.-1, No. 10, Xianzheng 10th St., Zhubei City, Hsinchu County 302, =
Taiwan
(R.O.C.)

The information included in this email is privileged and confidential =
and
just for the exclusive use of the addressee.

For people other than the addressee the use, disclosure and reproduction =
is
strictly prohibited.

If this message has been received in error, please contact the sender =
and
delete all copies.

=20


------=_NextPart_001_0020_01DC0219.DA6FA4E0
Content-Type: text/html;
	charset="big5"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" =
xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" =
xmlns=3D"http://www.w3.org/TR/REC-html40"><head><meta =
http-equiv=3DContent-Type content=3D"text/html; charset=3Dbig5"><meta =
name=3DGenerator content=3D"Microsoft Word 15 (filtered =
medium)"><style><!--
/* Font Definitions */
@font-face
	{font-family:=B7s=B2=D3=A9=FA=C5=E9;
	panose-1:2 2 5 0 0 0 0 0 0 0;}
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Aptos;}
@font-face
	{font-family:"Aptos Display";}
@font-face
	{font-family:"Microsoft YaHei Light";
	panose-1:2 11 5 2 4 2 4 2 2 3;}
@font-face
	{font-family:"\@=B7s=B2=D3=A9=FA=C5=E9";
	panose-1:2 1 6 1 0 1 1 1 1 1;}
@font-face
	{font-family:"\@Microsoft YaHei Light";}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	font-size:12.0pt;
	font-family:"Aptos",sans-serif;
	mso-ligatures:standardcontextual;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Microsoft YaHei Light",sans-serif;
	color:windowtext;
	font-weight:normal;
	font-style:normal;}
.MsoChpDefault
	{mso-style-type:export-only;}
/* Page Definitions */
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 90.0pt 72.0pt 90.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]--></head><body lang=3DZH-TW =
link=3D"#467886" vlink=3D"#96607D" =
style=3D'word-wrap:break-word;text-justify-trim:punctuation'><div =
class=3DWordSection1><p class=3DMsoNormal><span lang=3DEN-US =
style=3D'font-size:10.0pt;font-family:"Microsoft YaHei =
Light",sans-serif'>The vendor Comtrue Inc. (0x2fc6) produces USB audio =
chipsets like<o:p></o:p></span></p><p class=3DMsoNormal><span =
lang=3DEN-US style=3D'font-size:10.0pt;font-family:"Microsoft YaHei =
Light",sans-serif'>the CT7601 which are capable of Native DSD =
playback.<o:p></o:p></span></p><p class=3DMsoNormal><span lang=3DEN-US =
style=3D'font-size:10.0pt;font-family:"Microsoft YaHei =
Light",sans-serif'><o:p>&nbsp;</o:p></span></p><p =
class=3DMsoNormal><span lang=3DEN-US =
style=3D'font-size:10.0pt;font-family:"Microsoft YaHei =
Light",sans-serif'>This patch adds QUIRK_FLAG_DSD_RAW for Comtrue (VID =
0x2fc6), which enables<o:p></o:p></span></p><p class=3DMsoNormal><span =
lang=3DEN-US style=3D'font-size:10.0pt;font-family:"Microsoft YaHei =
Light",sans-serif'>native DSD playback (DSD_U32_LE) on their USB Audio =
device. This has been<o:p></o:p></span></p><p class=3DMsoNormal><span =
lang=3DEN-US style=3D'font-size:10.0pt;font-family:"Microsoft YaHei =
Light",sans-serif'>verified under Ubuntu 2</span><span lang=3DEN-US =
style=3D'font-size:10.0pt;font-family:"Microsoft YaHei =
Light",sans-serif'>5</span><span lang=3DEN-US =
style=3D'font-size:10.0pt;font-family:"Microsoft YaHei =
Light",sans-serif'>.04 with JRiver.<o:p></o:p></span></p><p =
class=3DMsoNormal><span lang=3DEN-US =
style=3D'font-size:10.0pt;font-family:"Microsoft YaHei =
Light",sans-serif'><o:p>&nbsp;</o:p></span></p><p =
class=3DMsoNormal><span lang=3DEN-US =
style=3D'font-size:10.0pt;font-family:"Microsoft YaHei =
Light",sans-serif;mso-ligatures:none'>Best Regards =
!<o:p></o:p></span></p><p class=3DMsoNormal><span lang=3DEN-US =
style=3D'font-size:10.0pt;font-family:"Microsoft YaHei =
Light",sans-serif;mso-ligatures:none'>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<o:p></o:p></span></p><p =
class=3DMsoNormal><span lang=3DEN-US =
style=3D'font-size:10.0pt;font-family:"Microsoft YaHei =
Light",sans-serif;mso-ligatures:none'>Noble Yang<o:p></o:p></span></p><p =
class=3DMsoNormal><span lang=3DEN-US =
style=3D'font-size:10.0pt;font-family:"Microsoft YaHei =
Light",sans-serif;mso-ligatures:none'>Cell : =
+886-955-347822<o:p></o:p></span></p><p class=3DMsoNormal><span =
style=3D'font-size:10.0pt;font-family:"Microsoft YaHei =
Light",sans-serif;mso-ligatures:none'>=B1=E1=BF=B2=AA=D1=A5=F7=A6=B3=AD=AD=
=A4=BD=A5q<span lang=3DEN-US><o:p></o:p></span></span></p><p =
class=3DMsoNormal><span lang=3DEN-US =
style=3D'font-size:10.0pt;font-family:"Microsoft YaHei =
Light",sans-serif;mso-ligatures:none'>Comtrue =
Inc.<o:p></o:p></span></p><p class=3DMsoNormal><span lang=3DEN-US =
style=3D'font-size:10.0pt;font-family:"Microsoft YaHei =
Light",sans-serif;mso-ligatures:none'><a =
href=3D"http://www.comtrue-inc.com/">www.comtrue-inc.com</a><o:p></o:p></=
span></p><p class=3DMsoNormal><span =
style=3D'font-size:10.0pt;font-family:"Microsoft YaHei =
Light",sans-serif'>=B7s=A6a=A7} <span lang=3DEN-US>: =
</span>=B7s=A6=CB=BF=A4<span =
style=3D'color:#44546A'>=A6=CB=A5_=A5=AB=BF=A4=ACF=A4Q=B5=F3<span =
lang=3DEN-US>10</span>=B8=B9<span lang=3DEN-US>2F</span>=A4=A7<span =
lang=3DEN-US>1<o:p></o:p></span></span></span></p><div =
style=3D'mso-element:para-border-div;border:none;border-bottom:double =
windowtext 2.25pt;padding:0cm 0cm 1.0pt 0cm'><p class=3DMsoNormal =
style=3D'border:none;padding:0cm'><span lang=3DEN-US =
style=3D'font-size:10.0pt;font-family:"Microsoft YaHei =
Light",sans-serif;color:#434343;background:white'>2F.-1, No. 10, =
Xianzheng 10th St., Zhubei City, Hsinchu County 302, Taiwan =
(R.O.C.)</span><span lang=3DEN-US =
style=3D'font-size:10.0pt;font-family:"Microsoft YaHei =
Light",sans-serif;color:#44546A'><o:p></o:p></span></p></div><p =
class=3DMsoNormal><span lang=3DEN-US style=3D'font-family:"Microsoft =
YaHei Light",sans-serif'>The information included in this email is =
privileged and confidential and just for the exclusive use of the =
addressee.<o:p></o:p></span></p><p class=3DMsoNormal><span lang=3DEN-US =
style=3D'font-family:"Microsoft YaHei Light",sans-serif'>For people =
other than the addressee the use, disclosure and reproduction is =
strictly prohibited.<o:p></o:p></span></p><p class=3DMsoNormal><span =
lang=3DEN-US style=3D'font-family:"Microsoft YaHei Light",sans-serif'>If =
this message has been received in error, please contact the sender and =
delete all copies.<o:p></o:p></span></p><p class=3DMsoNormal><span =
lang=3DEN-US><o:p>&nbsp;</o:p></span></p></div></body></html>
------=_NextPart_001_0020_01DC0219.DA6FA4E0--

------=_NextPart_000_001F_01DC0219.DA6FA4E0
Content-Type: application/octet-stream;
	name="0001-ALSA-usb-audio-Add-DSD-support-for-Comtrue-USB-Audio.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="0001-ALSA-usb-audio-Add-DSD-support-for-Comtrue-USB-Audio.patch"

From 1b9dde1ef9987efcaf5d9bc9a932ac0ec3bbd8c5 Mon Sep 17 00:00:00 2001=0A=
From: "noble.yang" <noble.yang@comtrue-inc.com>=0A=
Date: Thu, 31 Jul 2025 12:11:11 +0800=0A=
Subject: [PATCH] ALSA: usb-audio: Add DSD support for Comtrue USB Audio =
device=0A=
=0A=
Signed-off-by: noble.yang <noble.yang@comtrue-inc.com>=0A=
---=0A=
 sound/usb/quirks.c | 2 ++=0A=
 1 file changed, 2 insertions(+)=0A=
=0A=
diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c=0A=
index bd24f3a78ea9..cbb66125f839 100644=0A=
--- a/sound/usb/quirks.c=0A=
+++ b/sound/usb/quirks.c=0A=
@@ -2408,6 +2408,8 @@ static const struct usb_audio_quirk_flags_table =
quirk_flags_table[] =3D {=0A=
 		   QUIRK_FLAG_DSD_RAW),=0A=
 	VENDOR_FLG(0x2d87, /* Cayin device */=0A=
 		   QUIRK_FLAG_DSD_RAW),=0A=
+        VENDOR_FLG(0x2fc6, /* Comture-inc devices */=0A=
+		   QUIRK_FLAG_DSD_RAW),	   =0A=
 	VENDOR_FLG(0x3336, /* HEM devices */=0A=
 		   QUIRK_FLAG_DSD_RAW),=0A=
 	VENDOR_FLG(0x3353, /* Khadas devices */=0A=
-- =0A=
2.48.1=0A=
=0A=

------=_NextPart_000_001F_01DC0219.DA6FA4E0
Content-Type: text/plain;
	name="cat proc asound card.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="cat proc asound card.txt"

cat /proc/asound/card*/stream0=0A=
Comtrue-inc Comtrue-inc UAC2 Device EVM-GB at usb-0000:00:14.0-5, high =
speed : USB Audio=0A=
=0A=
Playback:=0A=
  Status: Stop=0A=
  Interface 1=0A=
    Altset 1=0A=
    Format: S16_LE=0A=
    Channels: 2=0A=
    Endpoint: 0x01 (1 OUT) (ASYNC)=0A=
    Rates: 44100, 48000, 88200, 96000, 176400, 192000, 352800, 384000, =
705600, 768000=0A=
    Data packet interval: 125 us=0A=
    Bits: 16=0A=
    Channel map: FL FR=0A=
    Sync Endpoint: 0x81 (1 IN)=0A=
    Sync EP Interface: 1=0A=
    Sync EP Altset: 1=0A=
    Implicit Feedback Mode: No=0A=
  Interface 1=0A=
    Altset 2=0A=
    Format: S24_3LE=0A=
    Channels: 2=0A=
    Endpoint: 0x01 (1 OUT) (ASYNC)=0A=
    Rates: 44100, 48000, 88200, 96000, 176400, 192000, 352800, 384000, =
705600, 768000=0A=
    Data packet interval: 125 us=0A=
    Bits: 24=0A=
    Channel map: FL FR=0A=
    Sync Endpoint: 0x81 (1 IN)=0A=
    Sync EP Interface: 1=0A=
    Sync EP Altset: 2=0A=
    Implicit Feedback Mode: No=0A=
  Interface 1=0A=
    Altset 3=0A=
    Format: S32_LE=0A=
    Channels: 2=0A=
    Endpoint: 0x01 (1 OUT) (ASYNC)=0A=
    Rates: 44100, 48000, 88200, 96000, 176400, 192000, 352800, 384000, =
705600, 768000=0A=
    Data packet interval: 125 us=0A=
    Bits: 32=0A=
    Channel map: FL FR=0A=
    Sync Endpoint: 0x81 (1 IN)=0A=
    Sync EP Interface: 1=0A=
    Sync EP Altset: 3=0A=
    Implicit Feedback Mode: No=0A=
  Interface 1=0A=
    Altset 4=0A=
    Format: SPECIAL DSD_U32_BE=0A=
    Channels: 2=0A=
    Endpoint: 0x01 (1 OUT) (ASYNC)=0A=
    Rates: 44100, 48000, 88200, 96000, 176400, 192000, 352800, 384000, =
705600, 768000=0A=
    Data packet interval: 125 us=0A=
    Bits: 32=0A=
    DSD raw: DOP=3D0, bitrev=3D0=0A=
    Channel map: FL FR=0A=
    Sync Endpoint: 0x81 (1 IN)=0A=
    Sync EP Interface: 1=0A=
    Sync EP Altset: 4=0A=
    Implicit Feedback Mode: No=0A=
=0A=
Capture:=0A=
  Status: Stop=0A=
  Interface 2=0A=
    Altset 1=0A=
    Format: S16_LE=0A=
    Channels: 2=0A=
    Endpoint: 0x82 (2 IN) (ASYNC)=0A=
    Rates: 44100, 48000, 88200, 96000, 176400, 192000, 352800, 384000, =
705600, 768000=0A=
    Data packet interval: 125 us=0A=
    Bits: 16=0A=
    Channel map: FL FR=0A=
  Interface 2=0A=
    Altset 2=0A=
    Format: S24_3LE=0A=
    Channels: 2=0A=
    Endpoint: 0x82 (2 IN) (ASYNC)=0A=
    Rates: 44100, 48000, 88200, 96000, 176400, 192000, 352800, 384000, =
705600, 768000=0A=
    Data packet interval: 125 us=0A=
    Bits: 24=0A=
    Channel map: FL FR=0A=
  Interface 2=0A=
    Altset 3=0A=
    Format: S32_LE=0A=
    Channels: 2=0A=
    Endpoint: 0x82 (2 IN) (ASYNC)=0A=
    Rates: 44100, 48000, 88200, 96000, 176400, 192000, 352800, 384000, =
705600, 768000=0A=
    Data packet interval: 125 us=0A=
    Bits: 32=0A=
    Channel map: FL FR=0A=
  Interface 2=0A=
    Altset 4=0A=
    Format: SPECIAL DSD_U32_BE=0A=
    Channels: 2=0A=
    Endpoint: 0x82 (2 IN) (ASYNC)=0A=
    Rates: 44100, 48000, 88200, 96000, 176400, 192000, 352800, 384000, =
705600, 768000=0A=
    Data packet interval: 125 us=0A=
    Bits: 32=0A=
    DSD raw: DOP=3D0, bitrev=3D0=0A=
    Channel map: FL FR=0A=
=0A=

------=_NextPart_000_001F_01DC0219.DA6FA4E0--


