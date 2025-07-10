Return-Path: <linux-kernel+bounces-725065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34271AFFA66
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 09:07:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75E44174E4E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 07:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B0922877DB;
	Thu, 10 Jul 2025 07:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="m6uLqEfr"
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B88FC1D
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 07:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752131265; cv=none; b=Ix2vmEdffOqrP/6q47mVXQJljIfcU05L7Z2Fjd8hd48lvzwjh6j/mjrI5AbJUP142urRJHuxUEx/nIKxyY5JiujfaBTKNcqkHDl7PTn+mXbitTb53/0sXt5NkfYhgxFnzkk3PURKDeUqgK/mIFbJb07gxYrkgOFaNycXSNvkj/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752131265; c=relaxed/simple;
	bh=Fa8cNJqXyqhTY+lay0tanZOJxMosTm8d38KlOTsaTVM=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=NuPQfcHIuV5N/WceNF6JI4r7SmBAIGPPsqv4JNcxHeSdUvW4Cf5hfnchEPvk6b/Ro9U3iADO43Omidy/b1cffyCuoE0nXb2QHV1dR4ih0P4Nz2zJNcDV20OEMv3asVKzwsDUZP/bPc5tM6ER+qHtHRlwVs+19rz7wurh3PUNXDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=m6uLqEfr; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20250710070735epoutp03f2688a7d4e4c4c6dcddbf47bac6d08e6~Q0hf45Gn_3233932339epoutp03z
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 07:07:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20250710070735epoutp03f2688a7d4e4c4c6dcddbf47bac6d08e6~Q0hf45Gn_3233932339epoutp03z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1752131255;
	bh=ocJtS6jXeU938kHSDICEvHMlpPd1ymK+OTM7LO9g54I=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=m6uLqEfr/gRB3eWvwZ7i7m721EbN+D/FA5rp8N0lfd1Ya2jYLn/Eh5ck7zzPmu2g0
	 DWsGYQ5FKMCTeqMlciF0ro8Q5rGaTPfCSoei8jp4iPGvziYcEqL8AKLSVx88LhV9jA
	 as8DmFfLHcSM0XgCqiwPIQF6lU4bSMGa/Gs77jUk=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
	epcas2p4.samsung.com (KnoxPortal) with ESMTPS id
	20250710070734epcas2p403d8929c9d056f22eb961ef63e1d3703~Q0hfCFwFu1887718877epcas2p40;
	Thu, 10 Jul 2025 07:07:34 +0000 (GMT)
Received: from epcas2p4.samsung.com (unknown [182.195.36.98]) by
	epsnrtp04.localdomain (Postfix) with ESMTP id 4bd5Wn4TQBz6B9mL; Thu, 10 Jul
	2025 07:07:33 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
	20250710070732epcas2p4e181084f4733cc0514c2257e468cccf2~Q0hdkQnfD1887318873epcas2p4P;
	Thu, 10 Jul 2025 07:07:32 +0000 (GMT)
Received: from KORCO193562 (unknown [12.36.160.57]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20250710070732epsmtip185e7fbac963c7ffe1a1942119a27b49c~Q0hdhicsW2331023310epsmtip1R;
	Thu, 10 Jul 2025 07:07:32 +0000 (GMT)
From: =?ks_c_5601-1987?B?sejAur/s?= <ew.kim@samsung.com>
To: "'Mark Brown'" <broonie@kernel.org>
Cc: <s.nawrocki@samsung.com>, <lgirdwood@gmail.com>, <perex@perex.cz>,
	<tiwai@suse.com>, <linux-sound@vger.kernel.org>,
	<alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <aG4sb7UcqvHz_Z5r@finisterre.sirena.org.uk>
Subject: RE: [PATCH] ASoC: samsung: Implement abox generic structure
Date: Thu, 10 Jul 2025 16:07:32 +0900
Message-ID: <01a301dbf169$4e7656c0$eb630440$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="ks_c_5601-1987"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQGD3td0XDcdc/GKkWKGNfQw8ZJQZQD9NwnZAhfWmTW0wmquUA==
Content-Language: ko
X-CMS-MailID: 20250710070732epcas2p4e181084f4733cc0514c2257e468cccf2
X-Msg-Generator: CA
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
cpgsPolicy: CPGSC10-234,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250709002150epcas2p467416bdbc16754726599a0cacb1feecc
References: <CGME20250709002150epcas2p467416bdbc16754726599a0cacb1feecc@epcas2p4.samsung.com>
	<20250709001002.378246-1-ew.kim@samsung.com>
	<aG4sb7UcqvHz_Z5r@finisterre.sirena.org.uk>

Thank you for your detailed review.
We will proceed to remove unnecessary logs and code, as well as make
changes to some APIs accordingly.

Based on the feedback provided during your review, we will revise our work
and submit it again upon completion.

> -----Original Message-----
> From: Mark Brown <broonie@kernel.org>
> Sent: Wednesday, July 9, 2025 5:47 PM
> To: ew.kim@samsung.com
> Cc: s.nawrocki@samsung.com; lgirdwood@gmail.com; perex@perex.cz;
> tiwai@suse.com; linux-sound@vger.kernel.org; alsa-devel@alsa-project.org;
> linux-kernel@vger.kernel.org
> Subject: Re: [PATCH] ASoC: samsung: Implement abox generic structure
> 
> On Wed, Jul 09, 2025 at 09:10:02AM +0900, ew.kim@samsung.com wrote:
> > From: ew kim <ew.kim@samsung.com>
> >
> > Implemet basic abox generic drivers.
> > This driver is a management driver for the generic drivers used in
> > Automotive Abox, connecting them to SOC drivers.
> > It supports various Exynos Automotive SOCs.
> 
> I can't really tell what the driver is supposed to do from this - what is
> abox?  Looking at the code I'm not really much clearer, to a large extent
> because it doesn't seem to integrate with the subsystem (or other kernel
> subsystems) at all.  It looks like this might be intended to control a DSP
> offload system, but it's not 100% clear, and it seems like there's an
> ioctl() interface which it looks like it's exposing internal abstractions
> to userspace.  This needs to be some combination of much more clearly
> explained and better integrated with the existing kernel subsystems, right
> now I can't really review it effectively because it's hard for me to tell
> what the code is trying to do.
> 
> I've got a few very supreficial comments below but really there's a
> structural problem that needs to be addressed first.
> 
> > +++ b/sound/soc/samsung/auto_abox/generic/abox_generic.c
> > @@ -0,0 +1,568 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (c) 2020 Samsung Electronics Co., Ltd.
> > + *        http://www.samsung.com/
> 
> It's now 2025...
> 
> Please also make the entire comment a C++ one so things look more
> intentional.
> 
> > +//#define DEBUG
> 
> Just delete this, it can be added if needed.
> 
> > +#include <linux/clk.h>
> > +#include <linux/io.h>
> > +#include <linux/module.h>
> > +#include <linux/of.h>
> > +#include <linux/of_address.h>
> > +#include <linux/of_platform.h>
> > +#include <linux/delay.h>
> > +#include <linux/suspend.h>
> > +#include <sound/soc.h>
> > +#include <sound/soc-dapm.h>
> > +#include <sound/pcm_params.h>
> > +#include <linux/of_reserved_mem.h>
> > +#include <linux/types.h>
> > +#include <linux/kernel.h>
> > +#include <linux/init.h>
> > +#include <linux/sched/clock.h>
> > +#include <linux/ktime.h>
> > +#include <linux/iommu.h>
> > +#include <linux/clk-provider.h>
> > +#include <linux/kmod.h>
> > +#include <linux/umh.h>
> > +#include <linux/string.h>
> 
> Do you really need all these headers?
> 
> > +static struct abox_generic_data *g_abox_generic_data;
> 
> This isn't really the kernel style - neither the g_ naming, nor the
> concept of having a global for a driver.
> 
> > +/**
> > + * @cnotice
> > + * @prdcode
> > + * @Sub_SW_Component{abox_generic}
> > + * @ALM_Link {work item url}
> > + * @purpose "get value from virtual address"
> > + * @logic "return global abox_generic_data"
> > + * \image html
> > + * @params
> > + * @param{in, -, -, -}
> > + * @endparam
> > + * @retval {-, struct *abox_generic_data, !NULL, NULL}  */
> 
> This is not the style for kernel comments, and doesn't seem to make
> terribly much sense.


