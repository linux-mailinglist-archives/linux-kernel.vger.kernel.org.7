Return-Path: <linux-kernel+bounces-767821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9350DB25983
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 04:29:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBE0D1B66EF3
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 02:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40C1D2580F0;
	Thu, 14 Aug 2025 02:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ri3Lmuz+"
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B471EB195;
	Thu, 14 Aug 2025 02:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755138571; cv=none; b=XjDBY/7AO1fVc4fmKZSjdTzeFXhmN3QLItPSlhPaqIgsfRExzme3XA6SivlisBjfYrOZ4mW1USJVgKhFC2eapuoPLgpHGLIuLpax8rgNXwVul5AGhDjFmlHASmhl+NXedI7QxWzaO2BnU05qoJHoo281EWqMshvTfa31sAWwlqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755138571; c=relaxed/simple;
	bh=mW15UHDn6wnzhPqCoXDGZKCsA6Pf/u7eGY8nwJzI24o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SmDbHdFEIcc9s6CljvDMI55k+j3TlRWIlDalbwXZZQ0kqoR2ENxL65b1SGg6vS2y/bEdkO07W1/Jom+LxR/GorAB0WnYUDdKwymvHevmMR/HJ8Gs9RKqQWkgE1SOCExhMTT8vZMtAkZg0R7GtLhdKcdTScXJr8UFlvdVP5WZd4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ri3Lmuz+; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57E2TBSM2283045;
	Wed, 13 Aug 2025 21:29:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1755138551;
	bh=itwmlhg4+q60oicA+ZGoF7Spdlc+N8ObdJ05D9SACGU=;
	h=From:To:CC:Subject:Date:References:In-Reply-To;
	b=ri3Lmuz+7XBAB7VgGiZO2yQfCs/56dEcXVLUFNkUgaD6IbvKeb0TXggumdmRucdgg
	 ULYM3YK+6ZoPE6WWJJXsiljkA5kCGLx6cK4a/rTls2nqYtz0mFZf3LbxvB0+yhwUnx
	 JD3jWeNmf5yGBM8aLyUlfugq38wmOSLrFgvVpNlE=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57E2TAT91399281
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Wed, 13 Aug 2025 21:29:10 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 13
 Aug 2025 21:29:10 -0500
Received: from DLEE100.ent.ti.com ([fe80::ad4d:c227:3f85:880d]) by
 DLEE100.ent.ti.com ([fe80::ad4d:c227:3f85:880d%17]) with mapi id
 15.01.2507.055; Wed, 13 Aug 2025 21:29:10 -0500
From: "Xu, Baojun" <baojun.xu@ti.com>
To: Takashi Iwai <tiwai@suse.de>
CC: "broonie@kernel.org" <broonie@kernel.org>,
        "andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "Ding, Shenghao"
	<shenghao-ding@ti.com>,
        "13916275206@139.com" <13916275206@139.com>,
        "linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [EXTERNAL] Re: [PATCH v1] ALSA: hda/tas2781: Normalize the volume
 kcontrol name
Thread-Topic: [EXTERNAL] Re: [PATCH v1] ALSA: hda/tas2781: Normalize the
 volume kcontrol name
Thread-Index: AQHcDDpRRAd6Fte3skKvVBN7u6KS07RhDa0AgABcAOg=
Date: Thu, 14 Aug 2025 02:29:10 +0000
Message-ID: <417f8e1c8a314ae4a77070f313d8af2c@ti.com>
References: <20250813100842.12224-1-baojun.xu@ti.com>,<87ectfw7j5.wl-tiwai@suse.de>
In-Reply-To: <87ectfw7j5.wl-tiwai@suse.de>
Accept-Language: en-GB, zh-CN, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-c2processedorg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

Answer in line.

> ________________________________________
> From: Takashi Iwai <tiwai@suse.de>
> Sent: 13 August 2025 23:44
> To: Xu, Baojun
> Cc: broonie@kernel.org; andriy.shevchenko@linux.intel.com; alsa-devel@als=
a-project.org; Ding, Shenghao; 13916275206@139.com; linux-sound@vger.kernel=
.org; linux-kernel@vger.kernel.org
> Subject: [EXTERNAL] Re: [PATCH v1] ALSA: hda/tas2781: Normalize the volum=
e kcontrol name
>=20
> On Wed, 13 Aug 2025 12:08:42 +0200,
> Baojun Xu wrote:
> >
> > Change the name of the kcontrol from "Gain" to "Volume".
>=20
> Could you describe "why this change is needed"?
>=20
This name is in kcontrol, which is open to users.
Volume is more normalized and common.
Gain is a more professional term in smart amplifiers.

>=20
> thanks,
>=20
> Takashi
>=20
> >
> > Signed-off-by: Baojun Xu <baojun.xu@ti.com>
> > ---
>>  sound/hda/codecs/side-codecs/tas2781_hda_i2c.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/sound/hda/codecs/side-codecs/tas2781_hda_i2c.c b/sound/hda=
/codecs/side-codecs/tas2781_hda_i2c.c
> > index 92aae19cfc8f..e4bc3bc756b0 100644
> > --- a/sound/hda/codecs/side-codecs/tas2781_hda_i2c.c
> > +++ b/sound/hda/codecs/side-codecs/tas2781_hda_i2c.c
> > @@ -256,7 +256,7 @@ static const struct snd_kcontrol_new tas2770_snd_co=
ntrols[] =3D {
> >  };
> >
> >  static const struct snd_kcontrol_new tas2781_snd_controls[] =3D {
> > -     ACARD_SINGLE_RANGE_EXT_TLV("Speaker Analog Gain", TAS2781_AMP_LEV=
EL,
> > +     ACARD_SINGLE_RANGE_EXT_TLV("Speaker Analog Volume", TAS2781_AMP_L=
EVEL,
> >               1, 0, 20, 0, tas2781_amp_getvol,
>>               tas2781_amp_putvol, amp_vol_tlv),
> >       ACARD_SINGLE_BOOL_EXT("Speaker Force Firmware Load", 0,
> > --
> > 2.43.0
> >
>=20
>=20

Best Regards
Jim=

