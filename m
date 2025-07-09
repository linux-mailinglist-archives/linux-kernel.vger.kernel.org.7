Return-Path: <linux-kernel+bounces-724562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7BB7AFF461
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 00:07:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0190E179E27
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 22:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFF4523B619;
	Wed,  9 Jul 2025 22:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZwR2qLEa"
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02BCE21C9F4
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 22:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752098844; cv=none; b=ifkGSbBMlIiXWywYTOlv1cxX1Wp5o47aW1lWfkkvHo/djKNlOoBZVxeltpZwkNJdXQFfm29pV8sqtse/ih5T0YNXzywLgYWoe+zzbPG5Y1gOgGFGOX564gAUU1snmWnHx5MAv673Mzv4BKKi2pgrS4cojtZo4gXJSuks4c0ac0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752098844; c=relaxed/simple;
	bh=/zq4p4HkPI7Oc1xmcxi0ZWNtvP0lcG7H2B/OLTyWTwY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QkXFCseKsAjkwOOiSrku5dLIoxMxC8OF0iIVVBGAhQ3Ml1pnHjBsFGJZRyCgPO4QxKxj2C/X+WpOO/thp1gSfHUj5Tca4x8Mk+ismVIzAq0Iek9hNGEspqx4kvs9LbmVBDuIv3P0UiANuCnys61kKNmzkBSUGvU8Pw4U5ICWr+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZwR2qLEa; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <b28cb9d6-a280-4d27-a987-d707ee0dadce@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752098834;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iKT+aLQckbA47j8c6j24QKkcEoUaV7BFT/xYV2Y2qOI=;
	b=ZwR2qLEaRaITQBcOf2TE4tfqc9nZSgPX6Xo7MFvCAOYpbJT49MGp6p0sqEvCh+QtIWz9nA
	Oin+fRnWvlvrUyJxmHSZRvQlaYj2+d/womtC4naa3nmVgLiJSOtW4dtMzttun2XtSOyiA4
	B+6TB6ubJhNZ1plXopB6cyRLsBXjLtQ=
Date: Wed, 9 Jul 2025 23:07:09 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] drm/tidss: oldi: convert to devm_drm_bridge_alloc() API
To: Jayesh Choudhary <j-choudhary@ti.com>, jyri.sarha@iki.fi,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 dri-devel@lists.freedesktop.org, devarsht@ti.com,
 tomi.valkeinen@ideasonboard.com
Cc: airlied@gmail.com, simona@ffwll.ch, linux-kernel@vger.kernel.org
References: <20250701055002.52336-1-j-choudhary@ti.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Aradhya Bhatia <aradhya.bhatia@linux.dev>
In-Reply-To: <20250701055002.52336-1-j-choudhary@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hi Jayesh,

Thank you for testing the OLDI series out, and finding and reporting the
issue.

On 01/07/25 06:50, Jayesh Choudhary wrote:
> DRM bridges now uses "devm_drm_bridge_alloc()" for allocation and
> initialization. "devm_kzalloc()" is not allowed anymore and it results
> in WARNING. So convert it.
> 
> Fixes: 7246e0929945 ("drm/tidss: Add OLDI bridge support")
> Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
> ---
> 
> Warning log:
> <https://gist.github.com/Jayesh2000/e42c235bb57cb0f0af06c8c3bf886ef2>
> 
>  drivers/gpu/drm/tidss/tidss_oldi.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/tidss/tidss_oldi.c b/drivers/gpu/drm/tidss/tidss_oldi.c
> index 8223b8fec8ce..b0f99656e87e 100644
> --- a/drivers/gpu/drm/tidss/tidss_oldi.c
> +++ b/drivers/gpu/drm/tidss/tidss_oldi.c
> @@ -534,11 +534,10 @@ int tidss_oldi_init(struct tidss_device *tidss)
>  			continue;
>  		}
>  
> -		oldi = devm_kzalloc(tidss->dev, sizeof(*oldi), GFP_KERNEL);
> -		if (!oldi) {
> -			ret = -ENOMEM;
> -			goto err_put_node;
> -		}
> +		oldi = devm_drm_bridge_alloc(tidss->dev, struct tidss_oldi, bridge,
> +					     &tidss_oldi_bridge_funcs);
> +		if (IS_ERR(oldi))
> +			return PTR_ERR(oldi);

The 'child' and 'oldi_parent' device nodes need to be put back before
the error is returned.

This should do it.
	
	ret = PTR_ERR(oldi);
	goto err_put_node;

>  
>  		oldi->parent_vp = parent_vp;
>  		oldi->oldi_instance = oldi_instance;
> @@ -577,7 +576,6 @@ int tidss_oldi_init(struct tidss_device *tidss)
>  		/* Register the bridge. */
>  		oldi->bridge.of_node = child;
>  		oldi->bridge.driver_private = oldi;
> -		oldi->bridge.funcs = &tidss_oldi_bridge_funcs;
>  		oldi->bridge.timings = &default_tidss_oldi_timings;
>  
>  		tidss->oldis[tidss->num_oldis++] = oldi;

With that changed,

Reviewed-by: Aradhya Bhatia <aradhya.bhatia@linux.dev>

-- 
Regards
Aradhya


