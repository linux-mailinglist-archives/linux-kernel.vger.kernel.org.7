Return-Path: <linux-kernel+bounces-757581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26381B1C3DB
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 11:56:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6711F3A3BE9
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 09:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A8FF28A1D2;
	Wed,  6 Aug 2025 09:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="MNy6BW9c"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 916A227470
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 09:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754474209; cv=none; b=uB/51JzwKKuzBaQ13vyATAO3U6IYzRNrHeJnoG0sA1PstOvGM9Pjt4KMx8U5M6yRPoZB14Aje9l0Uz7AjCwxES2ZeOLBF0dogn92hSLvb3FZIFVB2MyeSzIORkXvLfWC8EMDjl7IOuxvGKRK8ZPQK949UjKypmcOAivaAN7mVXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754474209; c=relaxed/simple;
	bh=SovqiRTwNHkCLcpBLH3EnEJkUe49rgR8N935dMmvlLA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lIEuo8TEXkyYgcrPCRX6FTYRSjMdXJEMqK8AuvZ4N14zbGZW50+h7gxW87FeQXebANF9iqeRiThpYB/vec8IpqS7itjS8lL6X2HO1aGRwP7CF5nDb+HqKL8VziTl3cz4I2iUyOnoG66IsBWf7o4gGr//t7c2WSFk6rCHNNNIdO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=MNy6BW9c; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0AAB51FD33;
	Wed,  6 Aug 2025 09:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1754474199;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=URKB1mHsqhAynryiTP+/5gH3zHuLJzJnR0Qk30y2VY0=;
	b=MNy6BW9cqY/rzWePMhe4LstzwcW0lFTrwQ8Pe+ponNzzOS0JNFX3LuvQSXN9sdrwBqylEW
	u1VlzkGQjtw2lwAURUBO6Bg4qDzMUnIqwiZakTC+ojDEviDwezrmDBr5PXeazeDfyCvhes
	pm5ebXjwEnfwZguJazaJaA/AHyir6I2CFDplDGmyXIyqV9K+uLRLFK+BaPTfAKaRsREcbA
	RZRYcJjRlVWTJBJv3HtIwkgAVbARiW/HkHeENdcwNE3S7JsYIW4qF2joDB5WYuhg3IYRRK
	84gKJW072y+pjRJrw1U4k8kImNLfsywhjTjA1IaPX7XNapDAfa51JeIF+ioJXQ==
Date: Wed, 6 Aug 2025 11:56:35 +0200
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Liu Ying <victor.liu@nxp.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org,
 Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
 jernej.skrabec@gmail.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, dmitry.baryshkov@oss.qualcomm.com, dianders@chromium.org,
 damon.ding@rock-chips.com, m.szyprowski@samsung.com
Subject: Re: [PATCH v2] drm/bridge: analogix_dp: Fix bailout for
 devm_drm_bridge_alloc()
Message-ID: <20250806115635.58fb5ae2@booty>
In-Reply-To: <20250806095224.527938-1-victor.liu@nxp.com>
References: <20250806095224.527938-1-victor.liu@nxp.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-State: clean
X-GND-Score: 0
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduudejjeehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecunecujfgurhepfffhvfevuffkjghfohfogggtgfesthejredtredtvdenucfhrhhomhepnfhutggrucevvghrvghsohhlihcuoehluhgtrgdrtggvrhgvshholhhisegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeeglefffefghefhtddvfeeufeeiveekgffgleekieduteekkeetvdehudekgfdvvdenucffohhmrghinhepsghoohhtlhhinhdrtghomhenucfkphepvdgrtddvmeeijedtmedvtddvtdemvggrtddumegsvgegudemleehvgejmeefgeefmeeludefvgenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtvdemieejtdemvddtvddtmegvrgdtudemsggvgedumeelhegvjeemfeegfeemledufegvpdhhvghlohepsghoohhthidpmhgrihhlfhhrohhmpehluhgtrgdrtggvrhgvshholhhisegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedukedprhgtphhtthhopehvihgtthhorhdrlhhiuhesnhigphdrtghomhdprhgtphhtthhopegurhhiqdguvghvvghlsehlihhsthhsrdhfrhgvvgguvghskhhtohhprdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrt
 ghpthhtoheprghnughriigvjhdrhhgrjhgurgesihhnthgvlhdrtghomhdprhgtphhtthhopehnvghilhdrrghrmhhsthhrohhngheslhhinhgrrhhordhorhhgpdhrtghpthhtoheprhhfohhssheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnfgruhhrvghnthdrphhinhgthhgrrhhtsehiuggvrghsohhnsghorghrugdrtghomhdprhgtphhtthhopehjohhnrghssehkfihisghoohdrshgv
X-GND-Sasl: luca.ceresoli@bootlin.com

Hello Liu,

On Wed,  6 Aug 2025 17:52:24 +0800
Liu Ying <victor.liu@nxp.com> wrote:

> devm_drm_bridge_alloc() returns ERR_PTR on failure instead of a
> NULL pointer, so use IS_ERR() to check the returned pointer.
> While at it, on failure, return ERR_CAST(dp) instead of
> ERR_PTR(-ENOMEM) in order not to depend on devm_drm_bridge_alloc()
> error code implementation.
> 
> Fixes: 48f05c3b4b70 ("drm/bridge: analogix_dp: Use devm_drm_bridge_alloc() API")
> Signed-off-by: Liu Ying <victor.liu@nxp.com>
> ---
> v2:
> - Return ERR_CAST(dp) on failure.  (Luca)
> 
>  drivers/gpu/drm/bridge/analogix/analogix_dp_core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> index ed35e567d117..efe534977d12 100644
> --- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> +++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> @@ -1474,8 +1474,8 @@ analogix_dp_probe(struct device *dev, struct analogix_dp_plat_data *plat_data)
>  
>  	dp = devm_drm_bridge_alloc(dev, struct analogix_dp_device, bridge,
>  				   &analogix_dp_bridge_funcs);
> -	if (!dp)
> -		return ERR_PTR(-ENOMEM);
> +	if (IS_ERR(dp))
> +		return ERR_CAST(dp);

Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

