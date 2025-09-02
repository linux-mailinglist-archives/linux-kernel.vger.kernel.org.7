Return-Path: <linux-kernel+bounces-797238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9983B40DD9
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 21:26:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78FAD7B150C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 19:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5B9134F488;
	Tue,  2 Sep 2025 19:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="Qx3Zx3/O"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB45D34DCDB
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 19:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756841169; cv=none; b=BCQdf6D1Zx+aXBKDcViUc/8+WSbntpECtz22UbotGpTGIeh6q+iBym/9J+zKhx5EkG5UXVxvX6d8ytJSLQpfZsWWnKfPelBfaVO1kI9sZcqBzk2P1Ua0STju9PlXcnNALDPZTY6npPq+LilWN+iz+qg5sCjzQISeeu3ELKpPaBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756841169; c=relaxed/simple;
	bh=K5FHRQfG74/3uwGbvOqfy7sOkX4EOSJRWCw0QqjgE6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D/5a6fQRoR1Y73cMxhNLA+32bJbDGYXdjABZk1RrkzpCmUNOfjWals2sQFph+Ze7oRzHvXwE/eSL1yYpj0r/K5Q/LC+TF06MwNIBQVYyAj8B1dvkCj8Jn47EPgsNfN4C96WP/WfA80BzTGGNWQfp7wi1+OkMm6himjVyJDD9czU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=Qx3Zx3/O; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (230.215-178-91.adsl-dyn.isp.belgacom.be [91.178.215.230])
	by perceval.ideasonboard.com (Postfix) with UTF8SMTPSA id 31BCFC6D;
	Tue,  2 Sep 2025 21:24:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1756841097;
	bh=K5FHRQfG74/3uwGbvOqfy7sOkX4EOSJRWCw0QqjgE6Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Qx3Zx3/OJBChrh02xfFc8tk4nkT0jirENKy+hIYIvJgK+HwPNUf8dONhnxoH299Db
	 fTY9Hrix/FRqg8a+Ym1WXxgwM1v7PiOGaPz9AeLBAWkuClv3FUEZ6jX+fOhnUZOfio
	 SHZweFoA2blSFFYMkYBCIQqbIsb1kQKMEDEoEzgg=
Date: Tue, 2 Sep 2025 21:25:44 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Maxime Ripard <mripard@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>, Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Jyri Sarha <jyri.sarha@iki.fi>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Devarsh Thakkar <devarsht@ti.com>, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/29] drm/atomic: Fix unused but set warning in
 for_each_old_plane_in_state
Message-ID: <20250902192544.GQ13448@pendragon.ideasonboard.com>
References: <20250902-drm-state-readout-v1-0-14ad5315da3f@kernel.org>
 <20250902-drm-state-readout-v1-2-14ad5315da3f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250902-drm-state-readout-v1-2-14ad5315da3f@kernel.org>

Hi Maxime,

Thank you for the patch.

On Tue, Sep 02, 2025 at 10:32:30AM +0200, Maxime Ripard wrote:
> The for_each_old_plane_in_state() macro triggers a compiler warning if
> the plane parameter passed to it isn't used in the code block.
> 
> Add a similar workaround than in most other macros.
> 
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> ---
>  include/drm/drm_atomic.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/include/drm/drm_atomic.h b/include/drm/drm_atomic.h
> index 38636a593c9d98cadda85ccd67326cb152f0dd27..689a29bdeb4a06672ab6fffecb513d58ff6e07f9 100644
> --- a/include/drm/drm_atomic.h
> +++ b/include/drm/drm_atomic.h
> @@ -1053,11 +1053,13 @@ void drm_state_dump(struct drm_device *dev, struct drm_printer *p);
>  	for ((__i) = 0;							\
>  	     (__i) < (__state)->dev->mode_config.num_total_plane;	\
>  	     (__i)++)							\
>  		for_each_if ((__state)->planes[__i].ptr &&		\
>  			     ((plane) = (__state)->planes[__i].ptr,	\
> +			      (void)(plane) /* Only to avoid unused-but-set-variable warning */, \
>  			      (old_plane_state) = (__state)->planes[__i].old_state, 1))
> +

While at it, shouldn't you apply the same workaround to the
old_plane_state variable, like done for new_plane_state in
for_each_new_plane_in_state() ? Or is it expected that drivers will
always make use of it.

Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

>  /**
>   * for_each_new_plane_in_state - iterate over all planes in an atomic update
>   * @__state: &struct drm_atomic_state pointer
>   * @plane: &struct drm_plane iteration cursor
>   * @new_plane_state: &struct drm_plane_state iteration cursor for the new state

-- 
Regards,

Laurent Pinchart

