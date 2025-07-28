Return-Path: <linux-kernel+bounces-748527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 146CBB14241
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 20:56:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D263188BD9C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 18:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDA5D276038;
	Mon, 28 Jul 2025 18:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=grimler.se header.i=@grimler.se header.b="AdLxBKNw"
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBCFB8BE8
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 18:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753729002; cv=none; b=XVVyabaMUIJcKZ86H/yQZEUKnHGPgdN/4Kqdp7rTwO0IjhAKKLG6kxCXbjPe5CpEW+6GXUhWLONfPl9QpE/OS/mFXKvS2qDuVMZlJ5/QBhy5SZohZ2Bcp3xumyP7ZaUqi8WJLWi7x9AqVq+EoPSXMxWHy7SZPYHRX3ReTlTd6vI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753729002; c=relaxed/simple;
	bh=vxlYLrRCullUV4UDOPB4cS4TOimPyODJGXbciEost6s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m5Skzq0sR3VaC9qnzEH+Ccdb5t55jwCQ/WZ81ztzse2kt4tPOzyT+SgCGUOSSKOe3UO2fYzPzQPtRCGTvF6awHs0UdCOiKn88whoXAxug7eHI/v7pdDD+bgShxw2jazWEb8p7oHEb8yg47bK1m/N/zNZN3yu71E0hHeKiEn3Jr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=grimler.se; spf=pass smtp.mailfrom=grimler.se; dkim=pass (1024-bit key) header.d=grimler.se header.i=@grimler.se header.b=AdLxBKNw; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=grimler.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grimler.se
Date: Mon, 28 Jul 2025 20:56:09 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grimler.se; s=key1;
	t=1753728985;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GsTJh65LY657rqwkxVWVgzfBPNOafbvVgWWFNGM+6ko=;
	b=AdLxBKNw43B4adzhvF90yj/2kXCTQ4k6U4mTfyNfit06LtIw5DxJYHqFBUpqzXQuVBnazH
	kkTf6Am29nrGFZPJkTE6Em6nIq3uRq3WtOQDGMvUO2zuuXDFPrZuvRZQmFs5UdVw06mIyJ
	o3y35B+xuSzWfcQZ5HIDh/WDP64Jexw=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Henrik Grimler <henrik@grimler.se>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
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
Subject: Re: [PATCH v2 2/3] drm/bridge: sii9234: use dev_err_probe where
 applicable
Message-ID: <20250728185609.GA160878@grimfrac.localdomain>
References: <20250724-exynos4-sii9234-driver-v2-0-faee244f1d40@grimler.se>
 <20250724-exynos4-sii9234-driver-v2-2-faee244f1d40@grimler.se>
 <opsrp4mlhwzoldthsna5wx32b755wl3uxrbqvocvnl5ssduf3k@76a7fycatbho>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <opsrp4mlhwzoldthsna5wx32b755wl3uxrbqvocvnl5ssduf3k@76a7fycatbho>
X-Migadu-Flow: FLOW_OUT

Hi Dmitry,

On Sun, Jul 27, 2025 at 07:38:12PM +0300, Dmitry Baryshkov wrote:
> On Thu, Jul 24, 2025 at 08:50:52PM +0200, Henrik Grimler wrote:
> > In case of error during resource acquisition the driver should print
> > an error message only if it is not deferred probe. Use dev_err_probe
> > helper to handle this, which will also record defer probe reason for
> > debugging.
[...]
> > @@ -836,9 +835,7 @@ static int sii9234_init_resources(struct sii9234 *ctx,
> >  	ctx->supplies[3].supply = "cvcc12";
> >  	ret = devm_regulator_bulk_get(ctx->dev, 4, ctx->supplies);
> >  	if (ret) {
> > -		if (ret != -EPROBE_DEFER)
> > -			dev_err(ctx->dev, "regulator_bulk failed\n");
> > -		return ret;
> > +		dev_err_probe(ctx->dev, ret, "regulator_bulk failed\n");
> 
> Drop the braces, use 'return dev_err_probe(...)'
> 
> >  	}
> >  
> >  	ctx->client[I2C_MHL] = client;

Thanks for reviewing and spotting that, will fix in next version!

Best regards,
Henrik Grimler

