Return-Path: <linux-kernel+bounces-896839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 50C18C515C5
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 10:31:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1D9D84F280F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 09:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66FB02F3600;
	Wed, 12 Nov 2025 09:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="U2p6h2ff"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B5BC20DD48
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 09:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762939373; cv=none; b=uLGmRuXgssqj8FQbmpglfH61QJgxBvFrTughTpGydQv6eOPnCYTYQuSdlA8x0e9M1/l9oySVgRpOTMbHxeurMQ+ABrHtXIfHvcb2l/6pBTosF+taoru40sut5lNjumEKRjHQOGv9sIDqJISvpO2OpefpmqUH46VdgcJe8Dur/Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762939373; c=relaxed/simple;
	bh=FZ/0jtKLUWgbygyUSbN0xOSCJOX3o33PqNVNNKTnnDQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=Bdu64fyrkSRlI4nhtOH4Ot14DOi0FjitjLN5knHKSSKbDdLX+mrthAkzO0yXl2hEns3Z/T+6cDLuXtOWoVqn5myTm2Ydunos0j4q0swTrERqG9nKs/6ZdP5COzFfO6y7jplqT2jEFW+DwN/gM7FTBtwQYfye+jBU8tZUq8z7zzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=U2p6h2ff; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [192.168.88.20] (91-158-153-178.elisa-laajakaista.fi [91.158.153.178])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 4F6D082E;
	Wed, 12 Nov 2025 10:20:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1762939248;
	bh=FZ/0jtKLUWgbygyUSbN0xOSCJOX3o33PqNVNNKTnnDQ=;
	h=Date:Subject:To:References:From:Cc:In-Reply-To:From;
	b=U2p6h2ffYXJisMvYH5tmIdQvTGEntz98xt7rm/EAE/BsRwoy32GxbGLIXcizC6Uay
	 dFQvOlsMygWVOlGdwCZDs2Z6qLwY7nVTs53y+A79rNIkHiHzI67aAp52FRh4Jlr3EB
	 NOP6Dn3JMBLJBNF+eEC7dV5QNjfmw2/DhFdjgJv4=
Message-ID: <3a05be44-97f6-4c0f-b565-0f70947d7fff@ideasonboard.com>
Date: Wed, 12 Nov 2025 11:22:43 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 6/6] drm/bridge: cadence: cdns-mhdp8546-core: Handle
 HDCP state in bridge atomic check
To: Harikrishna Shenoy <h-shenoy@ti.com>
References: <20251014094527.3916421-1-h-shenoy@ti.com>
 <20251014094527.3916421-7-h-shenoy@ti.com>
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Content-Language: en-US
Cc: Laurent.pinchart@ideasonboard.com, airlied@gmail.com,
 andrzej.hajda@intel.com, andy.yan@rock-chips.com, aradhya.bhatia@linux.dev,
 devarsht@ti.com, dianders@chromium.org, dri-devel@lists.freedesktop.org,
 javierm@redhat.com, jernej.skrabec@gmail.com, jonas@kwiboo.se,
 linux-kernel@vger.kernel.org, linux@treblig.org, luca.ceresoli@bootlin.com,
 lumag@kernel.org, lyude@redhat.com, maarten.lankhorst@linux.intel.com,
 mordan@ispras.ru, mripard@kernel.org, neil.armstrong@linaro.org,
 rfoss@kernel.org, s-jain1@ti.com, simona@ffwll.ch, tzimmermann@suse.de,
 u-kumar1@ti.com
Autocrypt: addr=tomi.valkeinen@ideasonboard.com; keydata=
 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
In-Reply-To: <20251014094527.3916421-7-h-shenoy@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 14/10/2025 12:45, Harikrishna Shenoy wrote:
> Now that we have DBANC framework and legacy connector functions removed,
> handle the HDCP disabling in bridge atomic check rather than in connector
> atomic check in !(DBANC) usecase.

This sounds odd. The patch is only adding new code, so "handle the HDCP
disabling in bridge atomic check rather than in connector atomic check
in !(DBANC) usecase." doesn't quite make sense.

Afaiu in patch 3 you removed the HDCP code for !DBANC, and here you add
it for DBANC.

Correct me if I'm wrong, but HDCP support for DBANC is currently broken
in upstream, as the HDCP code is only for the !DBANC case?

Isn't this patch then similar to patch 2, which is a fix for a missing
feature with DBANC? So should this also be a fix, and perhaps be moved
as after patch 2?

 Tomi

> Signed-off-by: Harikrishna Shenoy <h-shenoy@ti.com>
> ---
>  .../drm/bridge/cadence/cdns-mhdp8546-core.c   | 23 +++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
> index 06ac5c2ee78f..120eb7ffe20c 100644
> --- a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
> +++ b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
> @@ -1962,6 +1962,10 @@ static int cdns_mhdp_atomic_check(struct drm_bridge *bridge,
>  {
>  	struct cdns_mhdp_device *mhdp = bridge_to_mhdp(bridge);
>  	const struct drm_display_mode *mode = &crtc_state->adjusted_mode;
> +	struct drm_connector_state *old_state, *new_state;
> +	struct drm_atomic_state *state = crtc_state->state;
> +	struct drm_connector *conn = mhdp->connector;
> +	u64 old_cp, new_cp;
>  
>  	mutex_lock(&mhdp->link_mutex);
>  
> @@ -1981,6 +1985,25 @@ static int cdns_mhdp_atomic_check(struct drm_bridge *bridge,
>  	if (mhdp->info)
>  		bridge_state->input_bus_cfg.flags = *mhdp->info->input_bus_flags;
>  
> +	if (conn && mhdp->hdcp_supported) {
> +		old_state = drm_atomic_get_old_connector_state(state, conn);
> +		new_state = drm_atomic_get_new_connector_state(state, conn);
> +		old_cp = old_state->content_protection;
> +		new_cp = new_state->content_protection;
> +
> +		if (old_state->hdcp_content_type != new_state->hdcp_content_type &&
> +		    new_cp != DRM_MODE_CONTENT_PROTECTION_UNDESIRED) {
> +			new_state->content_protection = DRM_MODE_CONTENT_PROTECTION_DESIRED;
> +			crtc_state = drm_atomic_get_new_crtc_state(state, new_state->crtc);
> +			crtc_state->mode_changed = true;
> +		}
> +
> +		if (!new_state->crtc) {
> +			if (old_cp == DRM_MODE_CONTENT_PROTECTION_ENABLED)
> +				new_state->content_protection = DRM_MODE_CONTENT_PROTECTION_DESIRED;
> +		}
> +	}
> +
>  	mutex_unlock(&mhdp->link_mutex);
>  	return 0;
>  }


