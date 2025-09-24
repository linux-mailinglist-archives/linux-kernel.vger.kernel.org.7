Return-Path: <linux-kernel+bounces-831298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B4D6B9C4D9
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 23:49:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E5B017AA59
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 21:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1692528488A;
	Wed, 24 Sep 2025 21:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="lxv8VUY/"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 286C625484D
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 21:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758750538; cv=none; b=W+2BXKKKubTNqjzCbFNyU+un1HFBCeW4S37Zg8YGoBit29VPYcU6DpafFoD/ppais5SixpZMy7vDvPFCibtku/Rx7MDDucxP61eo9+qP4yJ6se9AZu9tCVaKVGt/pDWNe4bH0v7gxoRc2Pw9W5z22wgAq89nQYILRnzrPVfCtuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758750538; c=relaxed/simple;
	bh=LwHAJMWEWezja30W7awpKO7lKGm9NbfVkdhRpvtnsiU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cmFlKjx/uKv1SkfmG3f/hywypCjQUkyCONO2vemUsuP+tH/7brlcqf1gqMm2V+5P08yGMmkjDldYboZxeioLJWZIT3k8XFCwK32f1L7PpG/De53t/r7XE3L2rKhdgxWgzYi6Zt4FPkW20HV/iHwcwXwUMTkHkT6fjXYr7/3IvaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=lxv8VUY/; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with UTF8SMTPSA id A77F615E9;
	Wed, 24 Sep 2025 23:47:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1758750449;
	bh=LwHAJMWEWezja30W7awpKO7lKGm9NbfVkdhRpvtnsiU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lxv8VUY/RVeZSuXBzGOE7RYuGxIfSOa14TPaHMg0+44v8VzcMgR5Oe4zi3+naWfC5
	 RWwmec+bZnl4gBDBEhT/582QZQdokuJBInJRMdV/wNvY+vPJAuVA91NT/b+8vZbaw6
	 hj5ZF5GWItdByQ+16ZYXPAamHySHr4rx2aQxLP6Q=
Date: Thu, 25 Sep 2025 00:48:20 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Sebastian Reichel <sre@kernel.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Michael Riesch <michael.riesch@collabora.com>,
	Marek Vasut <marek.vasut@mailbox.org>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	kernel@collabora.com,
	Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: Re: [PATCH] drm/panel: sitronix-st7789v: fix sync flags for
 t28cp45tn89
Message-ID: <20250924214820.GA24727@pendragon.ideasonboard.com>
References: <20250924-t28cp45tn89-fix-v1-1-8e8f52239c84@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250924-t28cp45tn89-fix-v1-1-8e8f52239c84@collabora.com>

On Wed, Sep 24, 2025 at 11:46:30PM +0200, Sebastian Reichel wrote:
> From: Sebastian Reichel <sebastian.reichel@collabora.com>
> 
> I planned to set the polarity of horizontal and vertical sync, but
> accidentally described vertical sync twice with different polarity
> instead.
> 
> Note, that there is no functional change, because the driver only
> makes use of DRM_MODE_FLAG_P[HV]SYNC to divert from the default
> active-low polarity.
> 
> Reported-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> Closes: https://lore.kernel.org/all/20250923132616.GH20765@pendragon.ideasonboard.com/
> Fixes: a411558cc143 ("drm/panel: sitronix-st7789v: add Inanbo T28CP45TN89 support")
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

> ---
>  drivers/gpu/drm/panel/panel-sitronix-st7789v.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-sitronix-st7789v.c b/drivers/gpu/drm/panel/panel-sitronix-st7789v.c
> index 04d91929eedda092b966b8cffdef5b267748f190..dedf0a390a88dd45a8179e2d22e872128c87cfda 100644
> --- a/drivers/gpu/drm/panel/panel-sitronix-st7789v.c
> +++ b/drivers/gpu/drm/panel/panel-sitronix-st7789v.c
> @@ -261,7 +261,7 @@ static const struct drm_display_mode t28cp45tn89_mode = {
>  	.vtotal = 320 + 8 + 4 + 4,
>  	.width_mm = 43,
>  	.height_mm = 57,
> -	.flags = DRM_MODE_FLAG_PVSYNC | DRM_MODE_FLAG_NVSYNC,
> +	.flags = DRM_MODE_FLAG_NHSYNC | DRM_MODE_FLAG_PVSYNC,
>  };
>  
>  static const struct drm_display_mode et028013dma_mode = {
> 
> ---
> base-commit: 07e27ad16399afcd693be20211b0dfae63e0615f
> change-id: 20250924-t28cp45tn89-fix-0931500ee88a

-- 
Regards,

Laurent Pinchart

