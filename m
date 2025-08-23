Return-Path: <linux-kernel+bounces-783318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C5C2B32B9F
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 21:23:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14E459E7BDB
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 19:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A72222253AE;
	Sat, 23 Aug 2025 19:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=grimler.se header.i=@grimler.se header.b="TNbRB91S"
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E9B41B0F19
	for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 19:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755976976; cv=none; b=Zr2VbhOtAN7a+bWl0WSj8pXDvNC/PVUt5F7z0RNQVjFU/3fP6K+6/CJZzlpNehV35BrGKVjcFpGbh9ERn53BAUa5plHRnggS2iXZVlVC0H6Xz1GedCFg/Zt56Meq11mcmVbgyZwC+INDMYJlXUJBH5TUW+wOV9FlOisX0Xiy2hU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755976976; c=relaxed/simple;
	bh=UJB0OMh2svnWOnuezZc3FQ26C6QBucSsahwHP6z1sxY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ruwkmXahbklt5HafCRIoP+j0mJEfYmOfIHb72XsdSp+da//Yt8w4qkhfZgPYOKyu6KHifJ2oKHTU9ULbDrxRn0cwuabBzbRx2L58AYRe8tDQSDNWaFxj+/5ZjVs8uyQc719UJTGZ5A4MmCkglKizTqJf+SjzhgSSvV8OluOVnwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=grimler.se; spf=pass smtp.mailfrom=grimler.se; dkim=pass (1024-bit key) header.d=grimler.se header.i=@grimler.se header.b=TNbRB91S; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=grimler.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grimler.se
Date: Sat, 23 Aug 2025 21:22:19 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grimler.se; s=key1;
	t=1755976969;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VcLqrYHEBrH1mrq5kiugR3DV3EXDpYKMiX/phMutVNs=;
	b=TNbRB91SBweOilbXQPHxhNl15IfsyArK3Zus/7g2+MTA8wOghBoe6CxWdUBNVH5LKSWFdv
	wMCKs9r9VpfGu1XPQOB/C9SBGQ3jbR4Iz3TJI7ZQJ6Fkfo9zvDekJWu0x/gqfR+KPkwxHg
	XNnfywAcFPtN6wWLpC09cWGpkwsIuOs=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Henrik Grimler <henrik@grimler.se>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	dri-devel@lists.freedesktop.org, linux-samsung-soc@vger.kernel.org,
	~postmarketos/upstreaming@lists.sr.ht, replicant@osuosl.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] drm/bridge: sii9234: use extcon cable detection
 logic to detect MHL
Message-ID: <20250823192219.GA127144@grimfrac.localdomain>
References: <20250724-exynos4-sii9234-driver-v2-0-faee244f1d40@grimler.se>
 <CGME20250724185204eucas1p1d699db3abebc702ea8261b2e41a77c52@eucas1p1.samsung.com>
 <20250724-exynos4-sii9234-driver-v2-3-faee244f1d40@grimler.se>
 <1840a54c-c03a-42e3-a3a8-52e38919df38@samsung.com>
 <20250818142622.GA286180@grimfrac.localdomain>
 <1979fe6e-7a54-4812-9878-b4ce286401b2@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1979fe6e-7a54-4812-9878-b4ce286401b2@samsung.com>
X-Migadu-Flow: FLOW_OUT

Hi Marek,

On Fri, Aug 22, 2025 at 09:37:25AM +0200, Marek Szyprowski wrote:
> On 18.08.2025 16:26, Henrik Grimler wrote:
> > On Thu, Aug 14, 2025 at 01:26:33PM +0200, Marek Szyprowski wrote:
> >> On 24.07.2025 20:50, Henrik Grimler wrote:
> >>> To use MHL we currently need the MHL chip to be permanently on, which
> >>> consumes unnecessary power. Let's use extcon attached to MUIC to enable
> >>> the MHL chip only if it detects an MHL cable.
> >>>
> >>> Signed-off-by: Henrik Grimler <henrik@grimler.se>
> >>> ---
> >>> v2: add dependency on extcon. Issue reported by kernel test robot
> >>>       <lkp@intel.com>
> >>> ---
> >>>    drivers/gpu/drm/bridge/Kconfig   |  1 +
> >>>    drivers/gpu/drm/bridge/sii9234.c | 89 ++++++++++++++++++++++++++++++++++++++--
> >>>    2 files changed, 87 insertions(+), 3 deletions(-)
> >>>
> >>> diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
> >>> index b9e0ca85226a603a24f90c6879d1499f824060cb..f18a083f6e1c6fe40bde5e65a1548acc61a162ae 100644
> >>> --- a/drivers/gpu/drm/bridge/Kconfig
> >>> +++ b/drivers/gpu/drm/bridge/Kconfig
> >>> @@ -303,6 +303,7 @@ config DRM_SII902X
> >>>    config DRM_SII9234
> >>>    	tristate "Silicon Image SII9234 HDMI/MHL bridge"
> >>>    	depends on OF
> >>> +	select EXTCON
> >>>    	help
> >>>    	  Say Y here if you want support for the MHL interface.
> >>>    	  It is an I2C driver, that detects connection of MHL bridge
> >>> diff --git a/drivers/gpu/drm/bridge/sii9234.c b/drivers/gpu/drm/bridge/sii9234.c
> >>> index 0e0bb1bf71fdcef788715cfd6fa158a6992def33..4d84ba01ea76816bebdbc29d48a041c9c6cd508e 100644
> >>> --- a/drivers/gpu/drm/bridge/sii9234.c
> >>> +++ b/drivers/gpu/drm/bridge/sii9234.c
> > [ ...]
> >
> >>> +
> >>> +	edev = extcon_find_edev_by_node(muic);
> >>> +	of_node_put(muic);
> >>> +	if (IS_ERR(edev)) {
> >>> +		dev_err_probe(ctx->dev, PTR_ERR(edev),
> >>> +			      "invalid or missing extcon\n");
> >>> +	}
> >> It looks that the original logic got lost somehow in the above code
> >> block, what causes kernel oops if compiled as module and loaded before
> >> extcon provider. Please handle -EPROBE_DEFER and propagate error value,
> >> like the original code did in sii8620 driver:
> >>
> >>           if (IS_ERR(edev)) {
> >>                   if (PTR_ERR(edev) == -EPROBE_DEFER)
> >>                           return -EPROBE_DEFER;
> >>                   dev_err(ctx->dev, "Invalid or missing extcon\n");
> >>                   return PTR_ERR(edev);
> >>           }
> > Thanks for detecting the issue! I think my code is just missing return
> > before dev_err_probe (same mistake as I did on patch 2). With return
> > added I have not been able to reproduce any kernel oops, but if
> > CONFIG_DRM_SII9234=y and CONFIG_EXTCON_MAX77693=m then it seems like
> > linux gets stuck probing sii9234 and waiting for the extcon provider
> > (verified with some printf debugging). This happens for me both with:
> >
> > 	edev = extcon_find_edev_by_node(muic);
> > 	of_node_put(muic);
> > 	if (IS_ERR(edev)) {
> > 		return dev_err_probe(ctx->dev, PTR_ERR(edev),
> > 				     "Invalid or missing extcon\n");
> > 	}
> >
> > and
> >
> > 	edev = extcon_find_edev_by_node(muic);
> > 	of_node_put(muic);
> > 	if (IS_ERR(edev)) {
> > 		if (PTR_ERR(edev) == -EPROBE_DEFER)
> > 			return -EPROBE_DEFER;
> > 		dev_err(ctx->dev, "Invalid or missing extcon\n");
> > 		return PTR_ERR(edev);
> > 	}
> >
> > I am not sure what to do to fix the issue, as far as I can see probe
> > logic and extcon handling is the same as in sil-sii8620 and ite-it6505
> > (i.e. the other bridges that use extcon). Will investigate further.
> 
> Indeed your code lacked only the return directive, I've noticed that 
> just after sending my reply.
> 
> I'm not sure if there is a simple way to solve the endless probe issue 
> with sii9234=y and max77963=m. We have to rely on the user to either 
> keep all drivers compiled-in or configured as modules here. Afair the 
> same issue happens with sii8620 and max77843.

Thanks for the insights! Will leave that for now then and send a v3.

Best regards,
Henrik Grimler

> Best regards
> -- 
> Marek Szyprowski, PhD
> Samsung R&D Institute Poland
> 

