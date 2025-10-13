Return-Path: <linux-kernel+bounces-850138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF3D7BD1FEF
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 10:20:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0038B1898F02
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 08:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BD362F2903;
	Mon, 13 Oct 2025 08:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ciCcqHEH"
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A672F28EE
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 08:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760343621; cv=none; b=C+lHsBQzeHLfXQBa+p2m/tSrw+EcNKFlj4subOGFojMpV0cGCqq2JMZtQOn/cTb648kG4HGSl0gOc8aYYANLfKSNY8SZDLEENKY2vnLaYu3FYvBTkebxgRaXqkg/ukVS0L9hMvtAlrPFFypN3++acuyrTKMdfY+3lZ+CTMe34os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760343621; c=relaxed/simple;
	bh=bWQe4catjplmIwu9viZHb1YKyb9MgQYyB1f2VOwS1ow=;
	h=From:To:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=QgTk4IcQIkq6o9k84oVsNT+e8ZZ6Jtysfmxcjh0gVb2yuzHcG57OL8L3dFX/BN9PptgbHNJMI8YKQnFz123X3mDEV7QwjE9rZ4mbSwbdiq+0pO9BQ6l3fnBlxz93l1IMien5qBnXNznJfsN81QpFxq+2Dt594ns42BY2I3VKBP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=ciCcqHEH; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20251013082016epoutp019451c08df2c6a9c13d2b4dfa3b7f5ff1~t-zE4ZkR51347813478epoutp01a
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 08:20:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20251013082016epoutp019451c08df2c6a9c13d2b4dfa3b7f5ff1~t-zE4ZkR51347813478epoutp01a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1760343616;
	bh=pRHrDBnOjjwGnV8jPr9JRBFXDzkVoPpuS0SbkJwjTKk=;
	h=From:To:In-Reply-To:Subject:Date:References:From;
	b=ciCcqHEHcmnmrlWu36dqAQUFQ354QbhyADVPgOgqarP6UZnl1EQb2F+lxF4jLApIv
	 yJoym91LuElcn4AzSRS7pmNmfDjfvBZzuMRMXkFAtKZh0z+rOXOe8eA+hAfvj5vwph
	 Uvz2jhSEjF9FpewuwkKiT2tz5nt894sB4foAXCt0=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas1p2.samsung.com (KnoxPortal) with ESMTPS id
	20251013082016epcas1p21c08be95fe2ee390cf9c96c11ed7ad2d~t-zEsaHiv2051620516epcas1p2E;
	Mon, 13 Oct 2025 08:20:16 +0000 (GMT)
Received: from epcas1p3.samsung.com (unknown [182.195.38.192]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4clVdq5dHSz2SSKm; Mon, 13 Oct
	2025 08:20:15 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
	20251013082015epcas1p4db542f2000d6dd8ecac911d0fa1814f1~t-zD8AF3q2088920889epcas1p44;
	Mon, 13 Oct 2025 08:20:15 +0000 (GMT)
Received: from wkonkim01 (unknown [10.253.100.198]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20251013082015epsmtip1b7209ee2dd056f8c8409f0f72f323e26~t-zD3UieL0807408074epsmtip1X;
	Mon, 13 Oct 2025 08:20:15 +0000 (GMT)
From: "Wonkon Kim" <wkon.kim@samsung.com>
To: "'Bart Van Assche'" <bvanassche@acm.org>,
	<James.Bottomley@HansenPartnership.com>, <martin.petersen@oracle.com>,
	<peter.wang@mediatek.com>, <linux-scsi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
In-Reply-To: <4c894d68-7d0e-49a0-b582-477bcc7f351d@acm.org>
Subject: RE: [PATCH] ufs: core: Initialize a variable mode for PA_PWRMODE
Date: Mon, 13 Oct 2025 17:20:14 +0900
Message-ID: <000001dc3c1a$33e23030$9ba69090$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQFhT2clGfJ4dWcII9qWXyagEihcgwJWi3eIAdcMmwG1lCIXkA==
Content-Language: ko
X-CMS-MailID: 20251013082015epcas1p4db542f2000d6dd8ecac911d0fa1814f1
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
cpgsPolicy: CPGSC10-711,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20251002070057epcas1p49ac487359f24f6813ba8f9f44bcf0924
References: <CGME20251002070057epcas1p49ac487359f24f6813ba8f9f44bcf0924@epcas1p4.samsung.com>
	<20251002070027.228638-1-wkon.kim@samsung.com>
	<4c894d68-7d0e-49a0-b582-477bcc7f351d@acm.org>

> On 10/2/25 12:00 AM, Wonkon Kim wrote:
> >   static bool ufshcd_is_pwr_mode_restore_needed(struct ufs_hba *hba)
> >   =7B
> >   	struct ufs_pa_layer_attr *pwr_info =3D &hba->pwr_info;
> > -	u32 mode;
> > +	u32 mode =3D 0;
> >
> >   	ufshcd_dme_get(hba, UIC_ARG_MIB(PA_PWRMODE), &mode);
>=20
> Since there is more code that passes a pointer to an uninitialized
> variable to ufshcd_dme_get(), the untested patch below may be a better
> solution:
>=20
> diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c index
> 127b691402f9..5226fbca29ec 100644
> --- a/drivers/ufs/core/ufshcd.c
> +++ b/drivers/ufs/core/ufshcd.c
> =40=40 -4277,8 +4277,8 =40=40 int ufshcd_dme_get_attr(struct ufs_hba *hba=
, u32
> attr_sel,
>   			get, UIC_GET_ATTR_ID(attr_sel),
>   			UFS_UIC_COMMAND_RETRIES - retries);
>=20
> -	if (mib_val && =21ret)
> -		*mib_val =3D uic_cmd.argument3;
> +	if (mib_val)
> +		*mib_val =3D ret =3D=3D 0 ? uic_cmd.argument3 : 0;
>=20
>   	if (peer && (hba->quirks & UFSHCD_QUIRK_DME_PEER_ACCESS_AUTO_MODE)
>   	    && pwr_mode_change)
>=20
>=20

There are some attributes to use 0 as valid value.
e.g. PA_MAXRXHSGEAR is set to 0 for NO_HS=3D0
If it has 0 for valid value, most of value 0 are regarded as FALSE, unsuppo=
rted or minimum.
And these cases seems to check ret for command success/fail in code.
However, is it ok to set 0 for ufshcd_send_uic_cmd() fail?

If it can't, it needs to initialize mode.
Value 0 for PA_PWRMODE is invalid.


Thanks,
Wonkon Kim.


