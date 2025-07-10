Return-Path: <linux-kernel+bounces-725077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B070AFFA8F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 09:14:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F48B7A692B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 07:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F1ED2882B9;
	Thu, 10 Jul 2025 07:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Hn7uV2pU"
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48ACC288C19
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 07:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752131645; cv=none; b=Q5caBRlBsKIVcFVEjL1GCJLu1lg/2JS6xo2kSUbAc4AycRphmAAHtD4azGNA6stMCQlL7y3zYb9oBwF9AYlU9r5WRyvkOCgNVkmMNYqFF76GVLgyeNXro6ciQR7b8o4KDeFhpHfdhO1+QEKLCYhrN9yvbEqIXUd5dbif77UJzLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752131645; c=relaxed/simple;
	bh=knkp7wMKbsABbkeqQGYzCKn8oUpavpWUPxjTLnM5OpQ=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=oWm6sp+uV+ZYvGW8f6ynSlw/qWs4IWqNQ3Y914sHZPwnTG/hksUXedifpp6+NZGh7Vg4YAG7G0PiE7wJvhxEh8boBA3SSjoIo/AmugspHSFaYXW7q2cvIaIoER1EGqYkJT3gUAOVlkSASwT95j5C92bZeEOg1PO1YFwPth6s4Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=Hn7uV2pU; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20250710071400epoutp03ea3e9c8baf5c88ce2aaf57c48b2f644a~Q0nGFMluj0569005690epoutp03H
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 07:14:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20250710071400epoutp03ea3e9c8baf5c88ce2aaf57c48b2f644a~Q0nGFMluj0569005690epoutp03H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1752131640;
	bh=db3k/JVyQIT3D+uIpPvlN0puBLX9tVayW0NaKXlwODE=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=Hn7uV2pUG2DOwb6fX3VAd+Z5X4Y00LmMPEEDGe94tGlZvXWEni/pt4T5qq9J/QYjo
	 UHa+ST07jxGZeWesa4QDBcgH9BhyYnUZBnPdeMyrj7ZO6kk21Y2FXy/ayK9r+6IL12
	 jmod+7t8/jq9oSjpip6j+nKjEwD0ilUUBGjN0OKc=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
	epcas2p4.samsung.com (KnoxPortal) with ESMTPS id
	20250710071359epcas2p40556834430e3072773cb6a064010719d~Q0nFnmFFV0398403984epcas2p4X;
	Thu, 10 Jul 2025 07:13:59 +0000 (GMT)
Received: from epcas2p2.samsung.com (unknown [182.195.36.90]) by
	epsnrtp01.localdomain (Postfix) with ESMTP id 4bd5gB4sz7z6B9mG; Thu, 10 Jul
	2025 07:13:58 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
	20250710071358epcas2p3ea3c58a4f178a8a61d79b9442d71d29e~Q0nEMgXPa1715817158epcas2p3y;
	Thu, 10 Jul 2025 07:13:58 +0000 (GMT)
Received: from KORCO193562 (unknown [12.36.160.57]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20250710071357epsmtip2a55452f835a0527fa20e47a9ce589a7a~Q0nEJmIT63222932229epsmtip2G;
	Thu, 10 Jul 2025 07:13:57 +0000 (GMT)
From: =?UTF-8?B?6rmA7J2A7Jqw?= <ew.kim@samsung.com>
To: "'Krzysztof Kozlowski'" <krzk@kernel.org>, <s.nawrocki@samsung.com>,
	<lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
	<tiwai@suse.com>
Cc: <linux-sound@vger.kernel.org>, <alsa-devel@alsa-project.org>,
	<linux-kernel@vger.kernel.org>
In-Reply-To: <7d2401d6-d897-49d7-a3be-50de0727b037@kernel.org>
Subject: RE: [PATCH] ASoC: samsung: Implement abox generic structure
Date: Thu, 10 Jul 2025 16:13:57 +0900
Message-ID: <01a401dbf16a$33fbd0d0$9bf37270$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQGD3td0XDcdc/GKkWKGNfQw8ZJQZQD9NwnZAq8SWvi0vbM/0A==
Content-Language: ko
X-CMS-MailID: 20250710071358epcas2p3ea3c58a4f178a8a61d79b9442d71d29e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
cpgsPolicy: CPGSC10-234,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250709002150epcas2p467416bdbc16754726599a0cacb1feecc
References: <CGME20250709002150epcas2p467416bdbc16754726599a0cacb1feecc@epcas2p4.samsung.com>
	<20250709001002.378246-1-ew.kim@samsung.com>
	<7d2401d6-d897-49d7-a3be-50de0727b037@kernel.org>

Thank you for your review.
We will proceed to remove unnecessary Doxygen comments and logs as suggeste=
d.

Based on the feedback provided, we will revise the work accordingly and res=
ubmit it for further review.

> -----Original Message-----
> From: Krzysztof Kozlowski <krzk=40kernel.org>
> Sent: Wednesday, July 9, 2025 10:58 PM
> To: ew.kim=40samsung.com; s.nawrocki=40samsung.com; lgirdwood=40gmail.com=
;
> broonie=40kernel.org; perex=40perex.cz; tiwai=40suse.com
> Cc: linux-sound=40vger.kernel.org; alsa-devel=40alsa-project.org; linux-
> kernel=40vger.kernel.org
> Subject: Re: =5BPATCH=5D ASoC: samsung: Implement abox generic structure
>=20
> On 09/07/2025 02:10, ew.kim=40samsung.com wrote:
> > +/**
> > + * =40cnotice
> > + * =40prdcode
> > + * =40Sub_SW_Component=7Babox generic=7D
> > + * =40ALM_Link =7Bwork item url=7D
> > + * =40purpose =22Disbaling the abox generic=22
> > + * =40logic =22Disbale the abox generic=22
> > + * =5Cimage html
> > + * =40params
> > + * =40param=7Bin, pdev->dev, struct::device, =21NULL=7D
> > + * =40endparam
> > + * =40noret
> > + */
> > +static void samsung_abox_generic_remove(struct platform_device *pdev)
> > +=7B
> > +	struct device *dev =3D &pdev->dev;
> > +	struct abox_generic_data *data =3D dev_get_drvdata(dev);
> > +
> > +	dev_info(dev, =22%s=5Cn=22, __func__);
>=20
> This is just poor code. Clean it up from all such oddities popular in
> downstream. Look at upstream code. Do you see such code there? No.
>=20
> > +
> > +	if (=21data) =7B
> > +		dev_err(dev, =22%s: Invalid abox generic data=5Cn=22, __func__);
> > +		return;
> > +	=7D
> > +	return;
> > +=7D
> > +
> > +/**
> > + * =40cnotice
> > + * =40prdcode
> > + * =40Sub_SW_Component=7Babox generic=7D
> > + * =40ALM_Link =7Bwork item url=7D
> > + * =40purpose =22shutdown of the abox generic=22
> > + * =40logic =22Disbale the abox hardware by calling the following
> > +function
> > + * pm_runtime_disable(dev)=22
> > + * =5Cimage html
> > + * =40params
> > + * =40param=7Bin, pdev->dev, struct:: device, =21NULL=7D
> > + * =40endparam
> > + * =40noret
> > + */
> > +static void samsung_abox_generic_shutdown(struct platform_device
> > +*pdev) =7B
> > +	struct device *dev =3D &pdev->dev;
> > +	struct abox_generic_data *data =3D dev_get_drvdata(dev);
> > +
> > +	if (=21data) =7B
> > +		dev_err(dev, =22%s: Invalid abox generic data=5Cn=22, __func__);
> > +		return;
> > +	=7D
> > +	return;
> > +=7D
> > +
> > +static const struct of_device_id samsung_abox_generic_match=5B=5D =3D =
=7B
> > +	=7B
> > +		.compatible =3D =22samsung,abox_generic=22,
> > +	=7D,
> > +	=7B=7D,
> > +=7D;
> > +MODULE_DEVICE_TABLE(of, samsung_abox_generic_match);
> > +
> > +static const struct dev_pm_ops samsung_abox_generic_pm =3D =7B
> > +	SET_SYSTEM_SLEEP_PM_OPS(abox_generic_suspend, abox_generic_resume)
> > +=7D;
> > +
> > +struct platform_driver samsung_abox_generic_driver =3D =7B
> > +	.probe  =3D samsung_abox_generic_probe,
> > +	.remove =3D samsung_abox_generic_remove,
> > +	.shutdown =3D samsung_abox_generic_shutdown,
> > +	.driver =3D =7B
> > +		.name =3D =22samsung-abox-generic=22,
> > +		.owner =3D THIS_MODULE,
>=20
> So that's indeed 2013 code you upstream. We really want you to clean it u=
p
> before you post some ancient stuff like that.
>=20
>=20
> > +		.of_match_table =3D of_match_ptr(samsung_abox_generic_match),
> > +		.pm =3D &samsung_abox_generic_pm,
> > +	=7D,
> > +=7D;
> > +
> > +module_platform_driver(samsung_abox_generic_driver);
> > +/* Module information */
>=20
> Useless comment.
>=20
> > +MODULE_AUTHOR(=22Eunwoo Kim, <ew.kim=40samsung.com>=22);
> > +MODULE_DESCRIPTION(=22Samsung ASoC A-Box Generic Driver=22);
> > +MODULE_ALIAS(=22platform:samsung-abox-generic=22);
>=20
> No, drop. This was raised so many times already...
>=20
> > +MODULE_LICENSE(=22GPL v2=22);
> > +
> > diff --git
> > a/sound/soc/samsung/auto_abox/generic/include/abox_generic.h
> > b/sound/soc/samsung/auto_abox/generic/include/abox_generic.h
> > new file mode 100644
> > index 000000000000..1c954272e2b5
> > --- /dev/null
> > +++ b/sound/soc/samsung/auto_abox/generic/include/abox_generic.h
> > =40=40 -0,0 +1,87 =40=40
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * ALSA SoC - Samsung ABOX Share Function and Data structure
> > + * for Exynos specific extensions
> > + *
> > + * Copyright (C) 2013-2020 Samsung Electronics Co., Ltd.
> > + *
> > + * EXYNOS - sound/soc/samsung/abox/include/abox_generic.h
>=20
> Same with paths. Do you see them anywhere in the kernel?
>=20
> > + */
> > +
> > +=23ifndef __SND_SOC_ABOX_GENERIC_BASE_H =23define
> > +__SND_SOC_ABOX_GENERIC_BASE_H
> > +
> > +=23define ABOX_GENERIC_DATA
> 	abox_generic_get_abox_generic_data();
> > +
> > +struct snd_soc_pcm_runtime;
> > +
> > +enum abox_soc_ioctl_cmd =7B
> > +	ABOX_SOC_IOCTL_GET_NUM_OF_RDMA,
> > +	ABOX_SOC_IOCTL_GET_NUM_OF_WDMA,
> > +	ABOX_SOC_IOCTL_GET_NUM_OF_UAIF,
> > +	ABOX_SOC_IOCTL_GET_SOC_TIMER,
> > +	ABOX_SOC_IOCTL_SET_DMA_BUFFER,
> > +	ABOX_SOC_IOCTL_SET_PP_POINTER,
> > +	ABOX_SOC_IOCTL_SET_PERF_PERIOD,
> > +	ABOX_SOC_IOCTL_CHECK_TIME_MUTEX,
> > +	ABOX_SOC_IOCTL_CHECK_TIME_NO_MUTEX,
> > +	ABOX_SOC_IOCTL_PCM_DUMP_INTR,
> > +	ABOX_SOC_IOCTL_PCM_DUMP_CLOSE,
> > +	ABOX_SOC_IOCTL_PCM_DUMP_ADD_CONTROL,
> > +	ABOX_SOC_IOCTL_MAX
> > +=7D;
> > +
> > +typedef int (*SOC_IOCTL)(struct device *soc_dev, enum
> > +abox_soc_ioctl_cmd cmd, void *data);
>=20
> Follow coding style.
>=20
> > +
> > +struct abox_generic_data =7B
> > +	struct platform_device *pdev;
> > +	struct platform_device **pdev_pcm_playback;
> > +	struct platform_device **pdev_pcm_capture;
> > +	unsigned int num_of_pcm_playback;
> > +	unsigned int num_of_pcm_capture;
> > +	unsigned int num_of_i2s_dummy;
> > +	unsigned int num_of_rdma;
> > +	unsigned int num_of_wdma;
> > +	unsigned int num_of_uaif;
> > +	struct device *soc_dev;
> > +	SOC_IOCTL soc_ioctl;
> > +=7D;
> > +
> > +
> > +/************ Internal API ************/
>=20
> Then why do you expose it via header?
>=20
> > +
> > +struct abox_generic_data *abox_generic_get_abox_generic_data(void);
> > +
> > +int abox_generic_set_dma_buffer(struct device *pcm_dev);
> > +
> > +int abox_generic_request_soc_ioctl(struct device *generic_dev, enum
> abox_soc_ioctl_cmd cmd,
> > +	void *data);
> > +
> > +int abox_generic_set_pp_pointer(struct device *pcm_dev);
> > +
> > +
> > +
> > +
> > +/************ External API ************/
> > +
> > +extern struct device *abox_generic_find_fe_dev_from_rtd(struct
> > +snd_soc_pcm_runtime *be);
>=20
> You cannot have external API. All API is internal first.
>=20
> > +
> > +extern struct platform_device *abox_generic_get_pcm_platform_dev(int
> pcm_id,
> > +	int stream_type);
> > +
> Best regards,
> Krzysztof



