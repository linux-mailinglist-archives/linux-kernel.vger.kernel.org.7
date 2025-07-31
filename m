Return-Path: <linux-kernel+bounces-751640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13BF3B16BBD
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 07:50:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E80755826B2
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 05:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 383F024169F;
	Thu, 31 Jul 2025 05:50:17 +0000 (UTC)
Received: from mail.comtrue-inc.com (220-134-147-48.hinet-ip.hinet.net [220.134.147.48])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C00F7323D;
	Thu, 31 Jul 2025 05:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.134.147.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753941016; cv=none; b=MZDQ4DsT6jFqq+vQLizF+8nGrP758t83SXQegD+FDnN4rROJhiAX4psfgK2UnuDddhi/F+PCys8OlWkJCa8vyWuamDzdOunE+5/pwHND9TMv5DIdAocCHihGRTIapfgY8oJV45kAOXdjEnnqyKWmE/2TyG6dB6nLom0TQjL6aew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753941016; c=relaxed/simple;
	bh=/PGEbJLad/rzApTa99/KJo2Q3FHJ7sKoF0VPaSh5NuI=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=c5pl0vvh6DxaWDpDqHi+HKdPKkNdXdqIc8iVCiJp5v8xhCZnY6jt9jigjmVmRYgwehy4hVJJaA7ajkdCiFm4aRmGtCWiv4XTruU73OTH8mpL+1WrmhoX184ssheY0tQ4rEaz+iDbVTCfncPE3oObzE3OliwhcS/0WfZsn5AeU8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=comtrue-inc.com; spf=pass smtp.mailfrom=comtrue-inc.com; arc=none smtp.client-ip=220.134.147.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=comtrue-inc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=comtrue-inc.com
Received: from T470p (111-240-71-216.dynamic-ip.hinet.net [111.240.71.216])
	by mail.comtrue-inc.com (Postfix) with ESMTPA id 1DB141816B7;
	Thu, 31 Jul 2025 13:50:13 +0800 (CST)
From: <noble.yang@comtrue-inc.com>
To: "'Takashi Iwai'" <tiwai@suse.de>
Cc: <tiwai@suse.com>,
	<perex@perex.cz>,
	<hulianqin@vivo.com>,
	<lina+kernel@asahilina.net>,
	<cyan.vtb@gmail.com>,
	<dan.carpenter@linaro.org>,
	<bsevens@google.com>,
	<linux-sound@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <001e01dc01d6$cc4c64e0$64e52ea0$@comtrue-inc.com> <875xf8udel.wl-tiwai@suse.de>
In-Reply-To: <875xf8udel.wl-tiwai@suse.de>
Subject: RE: [PATCH] ALSA: usb-audio: Add DSD support for Comtrue USB Audio device
Date: Thu, 31 Jul 2025 13:50:13 +0800
Message-ID: <002601dc01de$fc127db0$f4377910$@comtrue-inc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0027_01DC0222.0A371D40"
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJzuO2RCbJ8U0DTv9IeX9bqTdFdvwHMATWRsw3p8aA=
Content-Language: zh-tw

This is a multipart message in MIME format.

------=_NextPart_000_0027_01DC0222.0A371D40
Content-Type: text/plain;
	charset="big5"
Content-Transfer-Encoding: quoted-printable

Hello Takashi

Please try download it as below link
https://reurl.cc/8951Ro

Thanks
Noble

-----Original Message-----
From: Takashi Iwai <tiwai@suse.de>=20
Sent: Thursday, July 31, 2025 1:40 PM
To: noble.yang@comtrue-inc.com
Cc: tiwai@suse.com; perex@perex.cz; hulianqin@vivo.com;
lina+kernel@asahilina.net; cyan.vtb@gmail.com; dan.carpenter@linaro.org;
bsevens@google.com; linux-sound@vger.kernel.org;
linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: usb-audio: Add DSD support for Comtrue USB =
Audio
device

On Thu, 31 Jul 2025 06:51:37 +0200,
<noble.yang@comtrue-inc.com> wrote:
>=20
>=20
> The vendor Comtrue Inc. (0x2fc6) produces USB audio chipsets like
>=20
> the CT7601 which are capable of Native DSD playback.
>=20
> This patch adds QUIRK_FLAG_DSD_RAW for Comtrue (VID 0x2fc6), which=20
> enables
>=20
> native DSD playback (DSD_U32_LE) on their USB Audio device. This has=20
> been
>=20
> verified under Ubuntu 25.04 with JRiver.
>=20
> Best Regards !

I see no patch in the mail.  Could you try to send via git-send-email?


thanks,

Takashi

>=20
> =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
>=20
> Noble Yang
>=20
> Cell : +886-955-347822
>=20
> =B1=E1=BF=B2=AA=D1=A5=F7=A6=B3=AD=AD=A4=BD=A5q
>=20
> Comtrue Inc.
>=20
> www.comtrue-inc.com
>=20
> =B7s=A6a=A7} : =
=B7s=A6=CB=BF=A4=A6=CB=A5_=A5=AB=BF=A4=ACF=A4Q=B5=F310=B8=B92F=A4=A71
>=20
> 2F.-1, No. 10, Xianzheng 10th St., Zhubei City, Hsinchu County 302,=20
> Taiwan
> (R.O.C.)
>=20
> The information included in this email is privileged and confidential=20
> and just for the exclusive use of the addressee.
>=20
> For people other than the addressee the use, disclosure and=20
> reproduction is strictly prohibited.
>=20
> If this message has been received in error, please contact the sender=20
> and delete all copies.
>=20
>=20
> cat /proc/asound/card*/stream0
> Comtrue-inc Comtrue-inc UAC2 Device EVM-GB at usb-0000:00:14.0-5, high =

> speed : USB Audio
>=20
> Playback:
>   Status: Stop
>   Interface 1
>     Altset 1
>     Format: S16_LE
>     Channels: 2
>     Endpoint: 0x01 (1 OUT) (ASYNC)
>     Rates: 44100, 48000, 88200, 96000, 176400, 192000, 352800, 384000,
705600, 768000
>     Data packet interval: 125 us
>     Bits: 16
>     Channel map: FL FR
>     Sync Endpoint: 0x81 (1 IN)
>     Sync EP Interface: 1
>     Sync EP Altset: 1
>     Implicit Feedback Mode: No
>   Interface 1
>     Altset 2
>     Format: S24_3LE
>     Channels: 2
>     Endpoint: 0x01 (1 OUT) (ASYNC)
>     Rates: 44100, 48000, 88200, 96000, 176400, 192000, 352800, 384000,
705600, 768000
>     Data packet interval: 125 us
>     Bits: 24
>     Channel map: FL FR
>     Sync Endpoint: 0x81 (1 IN)
>     Sync EP Interface: 1
>     Sync EP Altset: 2
>     Implicit Feedback Mode: No
>   Interface 1
>     Altset 3
>     Format: S32_LE
>     Channels: 2
>     Endpoint: 0x01 (1 OUT) (ASYNC)
>     Rates: 44100, 48000, 88200, 96000, 176400, 192000, 352800, 384000,
705600, 768000
>     Data packet interval: 125 us
>     Bits: 32
>     Channel map: FL FR
>     Sync Endpoint: 0x81 (1 IN)
>     Sync EP Interface: 1
>     Sync EP Altset: 3
>     Implicit Feedback Mode: No
>   Interface 1
>     Altset 4
>     Format: SPECIAL DSD_U32_BE
>     Channels: 2
>     Endpoint: 0x01 (1 OUT) (ASYNC)
>     Rates: 44100, 48000, 88200, 96000, 176400, 192000, 352800, 384000,
705600, 768000
>     Data packet interval: 125 us
>     Bits: 32
>     DSD raw: DOP=3D0, bitrev=3D0
>     Channel map: FL FR
>     Sync Endpoint: 0x81 (1 IN)
>     Sync EP Interface: 1
>     Sync EP Altset: 4
>     Implicit Feedback Mode: No
>=20
> Capture:
>   Status: Stop
>   Interface 2
>     Altset 1
>     Format: S16_LE
>     Channels: 2
>     Endpoint: 0x82 (2 IN) (ASYNC)
>     Rates: 44100, 48000, 88200, 96000, 176400, 192000, 352800, 384000,
705600, 768000
>     Data packet interval: 125 us
>     Bits: 16
>     Channel map: FL FR
>   Interface 2
>     Altset 2
>     Format: S24_3LE
>     Channels: 2
>     Endpoint: 0x82 (2 IN) (ASYNC)
>     Rates: 44100, 48000, 88200, 96000, 176400, 192000, 352800, 384000,
705600, 768000
>     Data packet interval: 125 us
>     Bits: 24
>     Channel map: FL FR
>   Interface 2
>     Altset 3
>     Format: S32_LE
>     Channels: 2
>     Endpoint: 0x82 (2 IN) (ASYNC)
>     Rates: 44100, 48000, 88200, 96000, 176400, 192000, 352800, 384000,
705600, 768000
>     Data packet interval: 125 us
>     Bits: 32
>     Channel map: FL FR
>   Interface 2
>     Altset 4
>     Format: SPECIAL DSD_U32_BE
>     Channels: 2
>     Endpoint: 0x82 (2 IN) (ASYNC)
>     Rates: 44100, 48000, 88200, 96000, 176400, 192000, 352800, 384000,
705600, 768000
>     Data packet interval: 125 us
>     Bits: 32
>     DSD raw: DOP=3D0, bitrev=3D0
>     Channel map: FL FR
>=20

------=_NextPart_000_0027_01DC0222.0A371D40
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

------=_NextPart_000_0027_01DC0222.0A371D40
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

------=_NextPart_000_0027_01DC0222.0A371D40--


