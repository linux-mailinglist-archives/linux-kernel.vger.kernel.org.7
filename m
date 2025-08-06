Return-Path: <linux-kernel+bounces-757558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 839B5B1C38E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 11:42:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 927B3161914
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 09:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E39E628A1D9;
	Wed,  6 Aug 2025 09:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="jLiteBcS"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 508CC1C3027
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 09:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754473318; cv=none; b=prApR4HuXc5+eTdK7uhR6lyWrkaoRGDq2r/FyqTrwgjVioZJg8An0QFsNVKUPOyjhcTKwgGni1C3I42DTsqCF+fUxqbbZUjS0OKhtqrXOOdz1O848SfIh/wJMlnZlo6rpzhE2drkN3GJWmj0sQ1EbzLsmlJCUhOpYBesFdTAH/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754473318; c=relaxed/simple;
	bh=/yG5AimmnLpDv8FHf2ZQhI/CqBBVygh/7tsG/7JrD00=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KbTVAJu9BhfCLHonmn5fHLNg2p8RxeGCzbXFZ8PR36qyujmDpTQlOaDJcbXs/jv+vsrLmOCFAoFF1mv2SkRXOmE+7cD3XSDSdTtQw4V2b+squCsQxjRGi6C7XU+EJu5RUs4pqhQH4yp7WvngY0Qgr7H5dcoXMjVvCzV1yJoc3mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=jLiteBcS; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id BE6634316E;
	Wed,  6 Aug 2025 09:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1754473314;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NZJODZEXyM0Btp0NhLuGNYblMjw4tGSyhRayjb63qFI=;
	b=jLiteBcScsmmXTcEUSGgHxsf8j8XdYx5gBw8FkcF1+UFbSGMiT0WnvzGql8tP6gQEVFzs+
	IAW6FTdSIIl2OF9EuRKGfu4Sn0zs/yBWIZsQbryjQc6yPbsErpcGetBVlwEOXX2kElONoS
	+7Oddy4b1DyuQkM7/6jLfd3txWtrK2Gx/9W78JpNyryIfI/SFIFDqPWZraWyhberKpgkHD
	BMXxWxC3KnAxydFAfSEoPRilYuEexSnz3w4oU6y8gqqK4wH2hHqEpVcoOmKRK6t0tgJobT
	JvJl6LCxkVRHfT82g/Ujx2EiCfRbtfDHHDiKMx/BYkNPaZ7FtKrgij1fA418vg==
Date: Wed, 6 Aug 2025 11:41:50 +0200
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Liu Ying <victor.liu@nxp.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org,
 Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
 jernej.skrabec@gmail.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, dmitry.baryshkov@oss.qualcomm.com, dianders@chromium.org,
 damon.ding@rock-chips.com, m.szyprowski@samsung.com
Subject: Re: [PATCH] drm/bridge: analogix_dp: Fix bailout for
 devm_drm_bridge_alloc()
Message-ID: <20250806114150.57e1ad97@booty>
In-Reply-To: <b5556cbe-76ed-4ddd-9b76-5896c2e1520c@nxp.com>
References: <20250806085424.518274-1-victor.liu@nxp.com>
	<20250806112641.7af982e3@booty>
	<b5556cbe-76ed-4ddd-9b76-5896c2e1520c@nxp.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduudejjedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecunecujfgurhepfffhvfevuffkjghfohfogggtgfesthejredtredtvdenucfhrhhomhepnfhutggrucevvghrvghsohhlihcuoehluhgtrgdrtggvrhgvshholhhisegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeeglefffefghefhtddvfeeufeeiveekgffgleekieduteekkeetvdehudekgfdvvdenucffohhmrghinhepsghoohhtlhhinhdrtghomhenucfkphepvdgrtddvmeeijedtmedvtddvtdemvggrtddumegsvgegudemleehvgejmeefgeefmeeludefvgenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtvdemieejtdemvddtvddtmegvrgdtudemsggvgedumeelhegvjeemfeegfeemledufegvpdhhvghlohepsghoohhthidpmhgrihhlfhhrohhmpehluhgtrgdrtggvrhgvshholhhisegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedukedprhgtphhtthhopehvihgtthhorhdrlhhiuhesnhigphdrtghomhdprhgtphhtthhopegurhhiqdguvghvvghlsehlihhsthhsrdhfrhgvvgguvghskhhtohhprdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrt
 ghpthhtoheprghnughriigvjhdrhhgrjhgurgesihhnthgvlhdrtghomhdprhgtphhtthhopehnvghilhdrrghrmhhsthhrohhngheslhhinhgrrhhordhorhhgpdhrtghpthhtoheprhhfohhssheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnfgruhhrvghnthdrphhinhgthhgrrhhtsehiuggvrghsohhnsghorghrugdrtghomhdprhgtphhtthhopehjohhnrghssehkfihisghoohdrshgv
X-GND-Sasl: luca.ceresoli@bootlin.com

On Wed, 6 Aug 2025 17:38:17 +0800
Liu Ying <victor.liu@nxp.com> wrote:

> On 08/06/2025, Luca Ceresoli wrote:
> > Hello Liu,
> > 
> > On Wed,  6 Aug 2025 16:54:24 +0800
> > Liu Ying <victor.liu@nxp.com> wrote:
> >   
> >> devm_drm_bridge_alloc() returns ERR_PTR on failure instead of a
> >> NULL pointer, so use IS_ERR() to check the returned pointer.
> >>
> >> Fixes: 48f05c3b4b70 ("drm/bridge: analogix_dp: Use devm_drm_bridge_alloc() API")
> >> Signed-off-by: Liu Ying <victor.liu@nxp.com>
> >> ---
> >>  drivers/gpu/drm/bridge/analogix/analogix_dp_core.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> >> index ed35e567d117..86cf898a09bb 100644
> >> --- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> >> +++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> >> @@ -1474,7 +1474,7 @@ analogix_dp_probe(struct device *dev, struct analogix_dp_plat_data *plat_data)
> >>  
> >>  	dp = devm_drm_bridge_alloc(dev, struct analogix_dp_device, bridge,
> >>  				   &analogix_dp_bridge_funcs);
> >> -	if (!dp)
> >> +	if (IS_ERR(dp))
> >>  		return ERR_PTR(-ENOMEM);  
> > 
> > Good catch, thanks!
> > 
> > You fix is correct but now I realized one additional fix is needed in
> > the following line:
> > 
> > -		return ERR_PTR(-ENOMEM);
> > +		return ERR_PTR(dp);  
> 
> You mean ERR_CAST(dp)?

Ah, indeed!

> > Can you send a v2 with that fixed?  
> 
> I find devm_drm_bridge_alloc() always returns ERR_PTR(-ENOMEM) in this
> driver context, so it seems fine to keep the existing ERR_PTR(-ENOMEM).
> If you prefer ERR_CAST(dp), I may send v2 to use ERR_CAST(dp).

The documentation says:

 * Returns:                  
 * Pointer to new bridge, or ERR_PTR on failure.

So let's follow that, which is a (relatively) immutable contract, and
not the implementation which might change over time.

This is also what all callers of devm_drm_bridge_alloc() do, unless I
missed something.

Thanks,
Luca

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

