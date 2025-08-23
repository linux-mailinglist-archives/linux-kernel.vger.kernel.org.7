Return-Path: <linux-kernel+bounces-783013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13C6BB32861
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 13:49:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62CDD1BC79B3
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 11:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC3292566E2;
	Sat, 23 Aug 2025 11:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ZmgDDqX2"
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D35D42F872
	for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 11:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755949790; cv=none; b=UZSOxqLNo9Rf7z6cUVricmHc3PIo+30tDSA9JGxIcFoGsom2qYEJg00GbFWYpF5wik0eS7qIJ+x2oUiz7ppG94yxWOiZkb9kuHMnXnvzw5cAzKDAP/UhZFzMZnDvMDCeBaeICApgJjc5/qIxmIL/UpjuDw10ISbMBclwKDAYmGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755949790; c=relaxed/simple;
	bh=o1RpCWhfORcxBtd2lZKYg1CKOTkPhfuLfoc5oR1Lwhw=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=gAHh2YGFA/ougcrnqMw3mIO1s9j/4JaEaDBT1QthGBm80aj3bbr1XacX68le+wu8hV8aUqZo1nrb5zBpoytm9QrzwHEdMtlrExyqxQxXtDQx2EMjPARc/DlC4evJBLqhrliqXfNJM6fxbAeLMPaM/HsrFMDTtBAhj8QQt8rGIrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=ZmgDDqX2; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20250823114944epoutp01bbc8502e5191300f93c18f9def0eb978~eYwaLN4Fo2216822168epoutp019
	for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 11:49:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20250823114944epoutp01bbc8502e5191300f93c18f9def0eb978~eYwaLN4Fo2216822168epoutp019
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1755949784;
	bh=mQPgL7zodvejOKqrhn0V4sG0yzzxNSz8kWdaZzz+MYw=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=ZmgDDqX22bDtLdXRQmSKWph5jAbCMTfEZ6xdPpOT0E+rpjMUXiBEETAo8ozqcDYhH
	 Mt8hD0iOfIfp+y7hfZudGHgIIkAMS3qudvSauK933U9sjeWADSIjLE4cKPkS4Wy7ZP
	 48aIIQctziepHJWty6QBWM9AzkJeNdd5zX8OpDyg=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPS id
	20250823114943epcas5p41e4d427f2c33267ac1c280a2583bcc0b~eYwZkIJNb0178801788epcas5p4B;
	Sat, 23 Aug 2025 11:49:43 +0000 (GMT)
Received: from epcas5p1.samsung.com (unknown [182.195.38.94]) by
	epsnrtp01.localdomain (Postfix) with ESMTP id 4c8Fj25y79z6B9m4; Sat, 23 Aug
	2025 11:49:42 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20250823114942epcas5p143d475885a37ec024bc0590408457db2~eYwYG5e6z0521905219epcas5p1_;
	Sat, 23 Aug 2025 11:49:42 +0000 (GMT)
Received: from FDSFTE196 (unknown [107.116.189.214]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20250823114938epsmtip19a9bbf2438abd0f903ac1ae13e019400~eYwUVX9gK2438024380epsmtip1k;
	Sat, 23 Aug 2025 11:49:38 +0000 (GMT)
From: "Inbaraj E" <inbaraj.e@samsung.com>
To: "'Krzysztof Kozlowski'" <krzk@kernel.org>, <mturquette@baylibre.com>,
	<sboyd@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <s.nawrocki@samsung.com>, <s.hauer@pengutronix.de>,
	<shawnguo@kernel.org>, <cw00.choi@samsung.com>, <rmfrfs@gmail.com>,
	<laurent.pinchart@ideasonboard.com>, <martink@posteo.de>,
	<mchehab@kernel.org>, <linux-fsd@tesla.com>, <will@kernel.org>,
	<catalin.marinas@arm.com>, <pankaj.dubey@samsung.com>,
	<shradha.t@samsung.com>, <ravi.patel@samsung.com>
Cc: <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <alim.akhtar@samsung.com>,
	<linux-samsung-soc@vger.kernel.org>, <kernel@puri.sm>,
	<kernel@pengutronix.de>, <festevam@gmail.com>,
	<linux-media@vger.kernel.org>, <imx@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>
In-Reply-To: <b1f59033-12d0-4395-85f1-e296a5dbca5f@kernel.org>
Subject: RE: [PATCH v2 12/12] media: fsd-csis: Add support for FSD CSIS DMA
Date: Sat, 23 Aug 2025 17:19:36 +0530
Message-ID: <00e301dc1424$033ed5a0$09bc80e0$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQK5oFMD+tt4mLQU5V9KgVyIDaUIUQLOIzgLAmiUCqAC0LEeUbJ0pR0Q
Content-Language: en-in
X-CMS-MailID: 20250823114942epcas5p143d475885a37ec024bc0590408457db2
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-541,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250814141103epcas5p14516cbe45c21d28ba9e231da99940aa1
References: <20250814140943.22531-1-inbaraj.e@samsung.com>
	<CGME20250814141103epcas5p14516cbe45c21d28ba9e231da99940aa1@epcas5p1.samsung.com>
	<20250814140943.22531-13-inbaraj.e@samsung.com>
	<b1f59033-12d0-4395-85f1-e296a5dbca5f@kernel.org>

Hi Krzysztof,

Thanks for the review.

> 
> On 14/08/2025 16:09, Inbaraj E wrote:
> > FSD CSIS IP bundles DMA engine for receiving frames from MIPI-CSI2 bus.
> > Add support internal DMA controller to capture the frames.
> >
> > Signed-off-by: Inbaraj E <inbaraj.e@samsung.com>
> 
> I commented on order of patches and got more surprise - final driver patch
> after DTS defconfig. It's really wrong order.

I'll fix in next patchset.

> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -3334,6 +3334,14 @@ S:	Maintained
> >  F:	Documentation/devicetree/bindings/media/samsung,s5p-mfc.yaml
> >  F:	drivers/media/platform/samsung/s5p-mfc/
> >
> > +ARM/SAMSUNG FSD BRIDGE DRIVER
> 
> TESLA FSD BRIDGE DRIVER
> (because ARM/foo are only SoC maintainer entries)
> 

I'll change in next patchset.

> > +M:	Inbaraj E <inbaraj.e@samsung.com>
> > +L:	linux-arm-kernel@lists.infradead.org (moderated for non-
> subscribers)
> 
> Replace above list with samsung-soc list.
> 

I'll change in next patchset.
 
> > +L:	linux-media@vger.kernel.org
> > +S:	Maintained
> >  source "drivers/media/platform/samsung/exynos-gsc/Kconfig"
> >  source "drivers/media/platform/samsung/exynos4-is/Kconfig"
> > +
> > +config VIDEO_FSD_CSIS
> 
> VIDEO_TSLA_FSD_CSIS

I'll change in next patchset.

> 
> > +	tristate "FSD SoC MIPI-CSI2 media controller driver"
> > +	depends on VIDEO_DEV && VIDEO_V4L2_SUBDEV_API
> > +	depends on HAS_DMA
> > +	depends on OF
> 
> OF seems unneeded dependency
> 
> But you miss ARCH_TESLA_FSD instead.
> 
> 

I'll remove OF and add ARCH_TESLA_FSD in next patchset.

> > +	select VIDEOBUF2_DMA_CONTIG
> > +	select V4L2_FWNODE
> > +	help
> > +	  This is a video4linux2 driver for FSD SoC MIPI-CSI2 Rx.
> 
> Tesla FSD

I'll add in next patchset.

> > new file mode 100644
> > index 000000000000..74f46038d506
> > --- /dev/null
> > +++ b/drivers/media/platform/samsung/fsd-csis/fsd-csis.c
> > @@ -0,0 +1,1709 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Copyright (c) 2022-2025 Samsung Electronics Co., Ltd.
> > + *             https://www.samsung.com
> > + *
> > + * FSD CSIS V4L2 Capture driver for FSD SoC.
> 
> "Tesla FSD" in both places

I'll change in next patchset.

> 
> > + */
> > +
> > +#include <linux/clk.h>
> > +#include <linux/pm_runtime.h>
> > +#include <linux/regmap.h>
> > +#include <media/v4l2-device.h>
> > +#include <media/v4l2-ioctl.h>
> > +#include <media/videobuf2-dma-contig.h> #include <media/v4l2-mc.h>
> 
> How can you depend on OF if there is no single OF header?

> > +
> > +	ret = devm_request_irq(dev, irq,
> > +			csis_irq_handler, IRQF_SHARED, pdev->name, csis);
> 
> Please align these (checkpatch --strict)

I'll fix in next patchset

> 
> > +
> > +	ret = fsd_csis_clk_get(csis);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	pm_runtime_enable(dev);
> > +	if (!pm_runtime_enabled(dev)) {
> 
> That's odd code. Why?
> 
> > +		ret = fsd_csis_runtime_resume(dev);
> 
> Even more questions why?

If CONFIG_PM is enabled, the clocks are enabled manually in the
driver through fsd_csis_runtime_resume API.

If CONFIG_PM is enabled, the clocks are managed through the PM
runtime framework.

Can you please help me understand what wrong here?

> 
> > +		if (ret < 0)
> > +			return ret;
> > +	}
> > +
> > +	platform_set_drvdata(pdev, csis);
> > +
> > +	ret = fsd_csis_enable_pll(csis);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = fsd_csis_media_init(csis);
> > +	if (ret)
> > +		return ret;
> 
> I think you miss clean up of csis->pll completely. Just use
> devm_clk_get_enabled and convert everything here to devm.
> 
> 

I'll fix in next patchset.

> > +
> > +	ret = fsd_csis_async_register(csis);
> > +	if (ret)
> > +		goto err_media_cleanup;
> > +
> > +	return 0;
> > +
> > +err_media_cleanup:
> > +	fsd_csis_media_cleanup(csis);
> 
> Also this...
> 

if fsd_csis_media_init fails, the cleanup is handled internally.
Here, cleanup is used only for fsd_csis_async_register failure.

can you please help me understand what is wrong here?
 
> > +
> > +	return ret;
> > +}
> > +
> > +static void fsd_csis_remove(struct platform_device *pdev) {
> > +	struct fsd_csis *csis = platform_get_drvdata(pdev);
> > +
> > +static struct platform_driver fsd_csis_driver = {
> > +	.probe		= fsd_csis_probe,
> > +	.remove		= fsd_csis_remove,
> > +	.driver		= {
> > +		.name		= FSD_CSIS_MODULE_NAME,
> > +		.of_match_table = of_match_ptr(fsd_csis_of_match),
> 
> Drop of_match_ptr, it is not really correct.

Will drop in next patchset.

Regards,
Inbaraj E


