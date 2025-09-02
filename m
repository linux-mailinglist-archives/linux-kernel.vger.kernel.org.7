Return-Path: <linux-kernel+bounces-797263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A975B40E1E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 21:49:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C96225E0D26
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 19:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31250343206;
	Tue,  2 Sep 2025 19:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="kbv/mDMW"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10612DF152
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 19:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756842589; cv=none; b=LyJAqPiXGXVSQ9dpTXdAS68fCU4l5upukMK9cwTmK8EDKCihe10VwLlNWFI+HUgWIBjcdsremasKBE+Ip6Emaa4E0CMRCcEGCtJ1IC2vqWQUd7aUXhy8CjOQUUX2/3K0GEGqsLTOcWujLczRv1kaSXsp2HtimyBRQx+E9a678gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756842589; c=relaxed/simple;
	bh=j2FGCZt5h71J5kGeIF0TOdjUL86/+YlDqZ3I/3KmapY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ryeKKgPEjOttEkjwXN6lvmWU8/rWCkSqOe+tTfwjzgY9H5Dv+/yWuAxLQxp1pqzMcX11t2b1JkrnFonejYgwSWU4U4kB4uDiZfNK4wkiaD/7AuIn7duKhzwOCzFjwubg/q5HPveWlwdONBSGVaOuLiDBkyXEW7AAC8cD5PR5D6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=kbv/mDMW; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (230.215-178-91.adsl-dyn.isp.belgacom.be [91.178.215.230])
	by perceval.ideasonboard.com (Postfix) with UTF8SMTPSA id 6EC62C6D;
	Tue,  2 Sep 2025 21:48:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1756842517;
	bh=j2FGCZt5h71J5kGeIF0TOdjUL86/+YlDqZ3I/3KmapY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kbv/mDMW6rjxbT/gMIOMbGm0SrkceC3cVvn/XJCsdjQFkqC7H0iofOrciZo+tZgMN
	 /0ySLXZGttjRXob7orwueR+tpTs3oGqCdWXR5fJpaJkl/s6Y1ZM5mct1SV/dAWda0e
	 0h94cKvZzb2oN4ou6xlaM7tKfJqxusVhICyY1T0k=
Date: Tue, 2 Sep 2025 21:49:24 +0200
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
Subject: Re: [PATCH 05/29] drm/atomic_state_helper: Fix bridge state
 initialization
Message-ID: <20250902194924.GT13448@pendragon.ideasonboard.com>
References: <20250902-drm-state-readout-v1-0-14ad5315da3f@kernel.org>
 <20250902-drm-state-readout-v1-5-14ad5315da3f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250902-drm-state-readout-v1-5-14ad5315da3f@kernel.org>

Hi Maxime,

On Tue, Sep 02, 2025 at 10:32:33AM +0200, Maxime Ripard wrote:
> Bridges implement their state using a drm_private_obj and an

s/and an/and a/

> hand-crafted reset implementation.
> 
> Since drm_private_obj doesn't have a set of reset helper like the other
> states, __drm_atomic_helper_bridge_reset() was initializing both the

s/was initializing/initializes/

> drm_private_state and the drm_bridge_state structures.
> 
> This initialization however was missing the drm_private_state.obj

s/was missing/is missing/

Or do I incorrectly think that the commit message should describe the
current situation in the present tense ?

> pointer to the drm_private_obj the state was allocated for, creating a
> NULL pointer dereference when trying to access it.
> 
> Fixes: 751465913f04 ("drm/bridge: Add a drm_bridge_state object")
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> ---
>  drivers/gpu/drm/drm_atomic_state_helper.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_atomic_state_helper.c b/drivers/gpu/drm/drm_atomic_state_helper.c
> index 7142e163e618ea0d7d9d828e1bd9ff2a6ec0dfeb..b962c342b16aabf4e3bea52a914e5deb1c2080ce 100644
> --- a/drivers/gpu/drm/drm_atomic_state_helper.c
> +++ b/drivers/gpu/drm/drm_atomic_state_helper.c
> @@ -707,10 +707,17 @@ void drm_atomic_helper_connector_destroy_state(struct drm_connector *connector,
>  	__drm_atomic_helper_connector_destroy_state(state);
>  	kfree(state);
>  }
>  EXPORT_SYMBOL(drm_atomic_helper_connector_destroy_state);
>  
> +static void __drm_atomic_helper_private_obj_reset(struct drm_private_obj *obj,
> +						  struct drm_private_state *state)
> +{
> +	memset(state, 0, sizeof(*state));

As Thomas mentioned, the memset is likely not needed.

Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

> +	state->obj = obj;
> +}
> +
>  /**
>   * __drm_atomic_helper_private_obj_duplicate_state - copy atomic private state
>   * @obj: CRTC object
>   * @state: new private object state
>   *
> @@ -796,10 +803,11 @@ EXPORT_SYMBOL(drm_atomic_helper_bridge_destroy_state);
>   */
>  void __drm_atomic_helper_bridge_reset(struct drm_bridge *bridge,
>  				      struct drm_bridge_state *state)
>  {
>  	memset(state, 0, sizeof(*state));
> +	__drm_atomic_helper_private_obj_reset(&bridge->base, &state->base);
>  	state->bridge = bridge;
>  }
>  EXPORT_SYMBOL(__drm_atomic_helper_bridge_reset);
>  
>  /**
> 

-- 
Regards,

Laurent Pinchart

