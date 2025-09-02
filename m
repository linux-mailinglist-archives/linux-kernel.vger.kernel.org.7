Return-Path: <linux-kernel+bounces-797295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1662CB40E86
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 22:22:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 249B21B61215
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 20:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D8D43451C9;
	Tue,  2 Sep 2025 20:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="hBkpiwO/"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D161D432D
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 20:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756844557; cv=none; b=cMOapk0ELTYPxzg3IWxj6JPqNIp6l4GHEvm/hft1+0dUlQQCz0D1s5SXB4AZ/KKbMSvmXC5saMxTgVqTiUEyhyyFfCb3VlgegXk7M2Zl5l6ASHYylY6ewGu6R/TxVT1/jwS1A/x6zx3PQLyxGXrxPUc6fL0B/VvS/sU/5xKeD3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756844557; c=relaxed/simple;
	bh=KHA3OTYDrxohM+F5nBqSD1koWav84WhhtxYj8tGqRLk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=me3ceyLMjvjYg+hcSJ769/zehFSXW9zSSrgqHna8vBzunU/tFM2/6wNn50VA2tuCFT7VAv5/xKv7McTGOhJhvOXYnHmtCiTEAz+CHrmC97D4wyZDqR/+di0ijmpbeTmnTPVpggswW9HB8n44mY6NbU8EBeSFsQQDRpmkUJN3whg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=hBkpiwO/; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (230.215-178-91.adsl-dyn.isp.belgacom.be [91.178.215.230])
	by perceval.ideasonboard.com (Postfix) with UTF8SMTPSA id DE083B63;
	Tue,  2 Sep 2025 22:21:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1756844485;
	bh=KHA3OTYDrxohM+F5nBqSD1koWav84WhhtxYj8tGqRLk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hBkpiwO/WE/7uKBGJ0uPvqn2BWlR0kQGt9VKcqI22pYOVr7TFhum2lSMa5CoaqOym
	 EPAWs+FZfsrV8d8WFdEOgAnUujqQoTaFjIYjvYYjC79c3ZtCIwDR6BTyt1Q/d4ZRLX
	 VO7BaWfDyIaGPuAXLkRnNrtKzMqX3OajnjNL23EM=
Date: Tue, 2 Sep 2025 22:22:12 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Maxime Ripard <mripard@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>, Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Jyri Sarha <jyri.sarha@iki.fi>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Devarsh Thakkar <devarsht@ti.com>, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/29] drm/bridge: Implement atomic_print_state
Message-ID: <20250902202212.GU13448@pendragon.ideasonboard.com>
References: <20250902-drm-state-readout-v1-0-14ad5315da3f@kernel.org>
 <20250902-drm-state-readout-v1-6-14ad5315da3f@kernel.org>
 <056b0335-f104-4b67-9882-6beaecd21c76@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <056b0335-f104-4b67-9882-6beaecd21c76@suse.de>

On Tue, Sep 02, 2025 at 03:22:40PM +0200, Thomas Zimmermann wrote:
> Am 02.09.25 um 10:32 schrieb Maxime Ripard:
> > Bridges have some fields in their state worth printing, but we don't
> > provide an atomic_print_state implementation to show those fields.
> >
> > Let's do so.
> >
> > Signed-off-by: Maxime Ripard <mripard@kernel.org>
> > ---
> >   drivers/gpu/drm/drm_bridge.c | 18 ++++++++++++++++++
> >   1 file changed, 18 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
> > index dd439d55177a867acb7ab73c02182bada44d93c9..e803dfd8fd5aae9c16931445213df04d8715b9f6 100644
> > --- a/drivers/gpu/drm/drm_bridge.c
> > +++ b/drivers/gpu/drm/drm_bridge.c
> > @@ -370,13 +370,31 @@ drm_bridge_atomic_destroy_priv_state(struct drm_private_obj *obj,
> >   	struct drm_bridge *bridge = drm_priv_to_bridge(obj);
> >   
> >   	bridge->funcs->atomic_destroy_state(bridge, state);
> >   }
> >   
> > +static void
> > +drm_bridge_atomic_print_priv_state(struct drm_printer *p,
> > +				   const struct drm_private_state *s)
> > +{
> > +	const struct drm_bridge_state *state =
> > +		container_of_const(s, struct drm_bridge_state, base);
> 
> Maybe adopt drm_priv_to_bridge_state() to accept const pointers?
> 
> https://elixir.bootlin.com/linux/v6.16.4/source/include/drm/drm_atomic.h#L1236

container_of_const() can helper, but drm_priv_to_bridge_state() will
need to be turned into a macro.

> > +	struct drm_bridge *bridge = drm_priv_to_bridge(s->obj);
> > +
> > +	drm_printf(p, "bridge: %s", drm_get_connector_type_name(bridge->type));

It would be nice to identify the bridge more precisely, but bridges have
no object ID :-/ The raw pointer may not be very useful. I wonder if we
should give an object ID to drm_private_obj instances, even if we don't
expose them to userspace. That's not a topic for this series of course.

Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

> > +	drm_printf(p, "\tinput bus configuration:");
> > +	drm_printf(p, "\t\tcode: %04x", state->input_bus_cfg.format);
> > +	drm_printf(p, "\t\tflags: %08x", state->input_bus_cfg.flags);
> > +	drm_printf(p, "\toutput bus configuration:");
> > +	drm_printf(p, "\t\tcode: %04x", state->output_bus_cfg.format);
> > +	drm_printf(p, "\t\tflags: %08x", state->output_bus_cfg.flags);
> > +}
> > +
> >   static const struct drm_private_state_funcs drm_bridge_priv_state_funcs = {
> >   	.atomic_duplicate_state = drm_bridge_atomic_duplicate_priv_state,
> >   	.atomic_destroy_state = drm_bridge_atomic_destroy_priv_state,
> > +	.atomic_print_state = drm_bridge_atomic_print_priv_state,
> >   };
> >   
> >   static bool drm_bridge_is_atomic(struct drm_bridge *bridge)
> >   {
> >   	return bridge->funcs->atomic_reset != NULL;
> >

-- 
Regards,

Laurent Pinchart

