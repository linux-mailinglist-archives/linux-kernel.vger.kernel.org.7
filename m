Return-Path: <linux-kernel+bounces-870878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47E37C0BE31
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 07:02:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0320B1892B3D
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 06:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03C6C2D97BA;
	Mon, 27 Oct 2025 06:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="eW3t6yED"
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3509236454
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 06:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761544955; cv=none; b=BRIloTO8AupGRO91dso4NTkTIgSMjZGbWezkQ0p1La4+c7velUeGh/dKPdkxUd4l/qLgXMkF88IupGQuzroKVdG3YAz/hxNMK72J4Vd5NnPCr2lXgOmPR9lOVOkKFgrfqGex7P6Mpwwryw8XON68rJ0NTehPeyf+EmR4Cso4WXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761544955; c=relaxed/simple;
	bh=wwxjb9DR1LvG1RHmq4IzS3Xkgi6qBkuv3E66RDriplY=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=r964zqqq3Eru8WPTKh531okXVIg07SiUkhs08yA5/JqmN3ghKD52sywgBKExt+QNzpt6Exs7oO+vcFlmziDfm3aeOM44X1yObKJoj76y1antUZknw9OnlYf8chGk3Qk9BxAfiHUmy+GBHOyTbqvlQ1WEMXLcBmr9KajKvD0zT+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=eW3t6yED; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761544944;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Bj8GkUukbIV/nY1dITAAUkOq2qqZTJboBaZcti6jOVo=;
	b=eW3t6yEDhpSPFgg2UJi5MB6cQTIbszIT8oDC7AjP4L3JyOp2HpNkvz00n6WHt/U2KGx+Ut
	RI61OU/Q/LncM/4s6Q3kJevv80jt51KK5SCbahc7PsDAmjBxRYip9U50cYBXHq0aJtDqch
	gpeQzoAP3Lpd/sOj54YC0svDbY+Y+Xs=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.100.1.1.5\))
Subject: Re: [PATCH v1 2/2] ALSA: hda/realtek: Add match for ASUS Xbox Ally
 projects
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Matthew Schwartz <matthew.schwartz@linux.dev>
In-Reply-To: <CAGwozwEwPj9VRRo2U50ccg=_qSM7p-1c_hw2y=OYA-pFc=p13w@mail.gmail.com>
Date: Sun, 26 Oct 2025 23:01:54 -0700
Cc: Shenghao Ding <shenghao-ding@ti.com>,
 Baojun Xu <baojun.xu@ti.com>,
 Takashi Iwai <tiwai@suse.com>,
 linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <35A5783A-CA60-4B10-8C7B-5820B65307FE@linux.dev>
References: <20251026191635.2447593-1-lkml@antheas.dev>
 <20251026191635.2447593-2-lkml@antheas.dev>
 <CAGwozwEwPj9VRRo2U50ccg=_qSM7p-1c_hw2y=OYA-pFc=p13w@mail.gmail.com>
To: Antheas Kapenekakis <lkml@antheas.dev>
X-Migadu-Flow: FLOW_OUT



> On Oct 26, 2025, at 12:19=E2=80=AFPM, Antheas Kapenekakis =
<lkml@antheas.dev> wrote:
>=20
> On Sun, 26 Oct 2025 at 20:16, Antheas Kapenekakis <lkml@antheas.dev> =
wrote:
>>=20
>> Bind the realtek codec to TAS2781 I2C audio amps on ASUS Xbox Ally
>> projects. While these projects work without a quirk, adding it =
increases
>> the output volume significantly.
>=20
> Also, if you can upstream the firmware files:
> TAS2XXX13840.bin
> TAS2XXX13841.bin
> TAS2XXX13940.bin
> TAS2XXX13941.bin

This is the firmware at [1], correct? I=E2=80=99m testing the series =
with that firmware on my ROG Xbox Ally X, and I found something =
interesting.

By default, with just your kernel patches and the firmware files hosted =
at [1], my unit is loading:

tas2781-hda i2c-TXNW2781:00-tas2781-hda.0: Loaded FW: TAS2XXX13840.bin, =
sha256: 58cffa36ae23a2d9b2349ecb6c1d4e89627934cd79218f6ada06eaffe6688246

However, with this firmware file,  TAS2XXX13840.bin, there is =
significant audio clipping above 75% speaker level on my individual =
unit.

Then, I tried renaming the other firmware file, TAS2XXX13841.bin, into =
TAS2XXX13840.bin. Now my unit is loading:

tas2781-hda i2c-TXNW2781:00-tas2781-hda.0: Loaded FW: TAS2XXX13840.bin, =
sha256: 0fda76e7142cb455df1860cfdb19bb3cb6871128b385595fe06b296a070f4b8c

With this firmware file, audio is perfect all the way to 100% speaker =
level.

If I recall, there have been other ASUS products that required matching =
amplifier hardware with firmware correctly, right? It looks like this =
might be another case of since it seems my unit is loading the wrong =
firmware for its amplifiers.

Matt

[1]: https://github.com/hhd-dev/hwfirm

>=20
> That would be great :)
>=20
> Antheas
>=20
>> Cc: stable@vger.kernel.org # 6.17
>> Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
>> ---
>> sound/hda/codecs/realtek/alc269.c | 2 ++
>> 1 file changed, 2 insertions(+)
>>=20
>> diff --git a/sound/hda/codecs/realtek/alc269.c =
b/sound/hda/codecs/realtek/alc269.c
>> index 8ad5febd822a..d1ad84eee6d1 100644
>> --- a/sound/hda/codecs/realtek/alc269.c
>> +++ b/sound/hda/codecs/realtek/alc269.c
>> @@ -6713,6 +6713,8 @@ static const struct hda_quirk =
alc269_fixup_tbl[] =3D {
>>        SND_PCI_QUIRK(0x1043, 0x12f0, "ASUS X541UV", =
ALC256_FIXUP_ASUS_MIC_NO_PRESENCE),
>>        SND_PCI_QUIRK(0x1043, 0x1313, "Asus K42JZ", =
ALC269VB_FIXUP_ASUS_MIC_NO_PRESENCE),
>>        SND_PCI_QUIRK(0x1043, 0x1314, "ASUS GA605K", =
ALC285_FIXUP_ASUS_GA605K_HEADSET_MIC),
>> +       SND_PCI_QUIRK(0x1043, 0x1384, "ASUS RC73XA", =
ALC287_FIXUP_TXNW2781_I2C),
>> +       SND_PCI_QUIRK(0x1043, 0x1394, "ASUS RC73YA", =
ALC287_FIXUP_TXNW2781_I2C),
>>        SND_PCI_QUIRK(0x1043, 0x13b0, "ASUS Z550SA", =
ALC256_FIXUP_ASUS_MIC_NO_PRESENCE),
>>        SND_PCI_QUIRK(0x1043, 0x1427, "Asus Zenbook UX31E", =
ALC269VB_FIXUP_ASUS_ZENBOOK),
>>        SND_PCI_QUIRK(0x1043, 0x1433, "ASUS =
GX650PY/PZ/PV/PU/PYV/PZV/PIV/PVV", ALC285_FIXUP_ASUS_I2C_HEADSET_MIC),
>> --
>> 2.51.1
>>=20
>>=20
>=20
>=20


