Return-Path: <linux-kernel+bounces-836444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 86896BA9B63
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 16:53:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 019AF192213E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 14:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19A8A309DA1;
	Mon, 29 Sep 2025 14:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ca/E6wAh"
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E009926E6FF
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 14:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759157614; cv=none; b=WmyLNHt512OyXhXgFdk0kQpig8foJ5nA9ztVLwZjkZpmvEiHUL8PJKsbHqIaaQALSmeLgKKbPSiGU835yO8TJ2lZBmckuJe0nMW6X81oFQbC3oYGad4SIbzb9dfqbdGfvymitpz0LfQpSnpW/GaDtDIB18LwbkjGkm+VbtWhL1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759157614; c=relaxed/simple;
	bh=tQz8pBFZ7eYZMhRBds1VenR6HZgGvMMGQCto6NLpFj4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NOEYWHGu6RW2TtoE49lGqJgTAvimUd4EAdqGZ06wJ3Cfw4Z63EHZ4wt6vjHGe+0/ZSWG4853kPYRFhnhMgqnjjiIimbS5O89oGVdXU3xd2eU0H/p4pGUhcey/NpULfolbPyu+I02cKBUqPprhOfkXoMrp7QxCE662yFHlT69Mc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ca/E6wAh; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id EB1144E40C1A;
	Mon, 29 Sep 2025 14:53:29 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id BFFD4606AE;
	Mon, 29 Sep 2025 14:53:29 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B915B102F198F;
	Mon, 29 Sep 2025 16:53:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1759157609; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=3pVpwTaco7yFHAe69ZBiTvXHcvn2qIWppyNoGTqmjTQ=;
	b=ca/E6wAhdfUjViADrg2w0zrDIpOzyj9i+1rFiYXvEsOH2M68QaaZA+3+H3QHiodUZFLosf
	pWmH4K7NLln+RKv4S+dpr39P3DQVy6c5AVOHnAVM3hcytr4PfOtnjoKRJ8eCZv2Zz55By0
	C0l5ai8pg7IqUWqXQcCUb3KdIcUAVkQLwlJlXHInfvNB2TK/BLIXqj7+d+PrMLy5Pmyp8N
	LZU+xgQWrqpTBXtMYLK1a9+BvMqvCnzCXrMBQZISA1PB6yWUrnksSZT8dRTB8wBy5oamt/
	7VnR4UIL3oSEFH5jZ/O0FsKkGD5I0sy1SKItyLw6WlT4YTxyRolMQO0tKOOj6A==
Date: Mon, 29 Sep 2025 16:53:21 +0200
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Maxime Ripard <mripard@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann
 <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, Laurent
 Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman
 <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, Hui Pu
 <Hui.Pu@gehealthcare.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/7] drm/bridge: lock the encoder bridge chain mutex
 during insertion
Message-ID: <20250929165321.28b8bbcd@booty>
In-Reply-To: <20250929-enigmatic-delicate-mussel-f36b89@houat>
References: <20250926-drm-bridge-alloc-encoder-chain-mutex-v1-0-23b62c47356a@bootlin.com>
	<20250926-drm-bridge-alloc-encoder-chain-mutex-v1-3-23b62c47356a@bootlin.com>
	<20250929-enigmatic-delicate-mussel-f36b89@houat>
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
X-Last-TLS-Session-Version: TLSv1.3

On Mon, 29 Sep 2025 14:46:18 +0200
Maxime Ripard <mripard@kernel.org> wrote:

> On Fri, Sep 26, 2025 at 05:59:44PM +0200, Luca Ceresoli wrote:
> > drm_bridge_attach() modifies the encoder bridge chain, so take a mutex
> > around such operations to allow users of the chain to protect themselves
> > from chain modifications while iterating.
> > 
> > This change does not apply to drm_bridge_detach() because:
> >  * only the drm_encoder.c calls it, not bridge drivers (unlike
> >    drm_bridge_attach())
> >  * the only drm_bridge_detach() caller is drm_encoder_cleanup() which
> >    already locks the mutex for the entire cleanup loop, thus additionally
> >    locking it here would deadlock
> >  * drm_bridge_detach() is recursively calling itself along the chain, so
> >    care would be needed to avoid deadlocks
> > Add a comment to clarify that is intended.
> > 
> > Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> > ---
> >  drivers/gpu/drm/drm_bridge.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> > 
> > diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
> > index 630b5e6594e0affad9ba48791207c7b403da5db8..90e467cf91a134342c80d2f958b928472aaf0d8b 100644
> > --- a/drivers/gpu/drm/drm_bridge.c
> > +++ b/drivers/gpu/drm/drm_bridge.c
> > @@ -453,10 +453,12 @@ int drm_bridge_attach(struct drm_encoder *encoder, struct drm_bridge *bridge,
> >  	bridge->dev = encoder->dev;
> >  	bridge->encoder = encoder;
> >  
> > +	drm_encoder_chain_lock(encoder);
> >  	if (previous)
> >  		list_add(&bridge->chain_node, &previous->chain_node);
> >  	else
> >  		list_add(&bridge->chain_node, &encoder->bridge_chain);
> > +	drm_encoder_chain_unlock(encoder);
> >  
> >  	if (bridge->funcs->attach) {
> >  		ret = bridge->funcs->attach(bridge, encoder, flags);
> > @@ -487,7 +489,9 @@ int drm_bridge_attach(struct drm_encoder *encoder, struct drm_bridge *bridge,
> >  err_reset_bridge:
> >  	bridge->dev = NULL;
> >  	bridge->encoder = NULL;
> > +	drm_encoder_chain_lock(encoder);
> >  	list_del(&bridge->chain_node);
> > +	drm_encoder_chain_unlock(encoder);
> >  
> >  	if (ret != -EPROBE_DEFER)
> >  		DRM_ERROR("failed to attach bridge %pOF to encoder %s: %d\n",
> > @@ -503,6 +507,11 @@ int drm_bridge_attach(struct drm_encoder *encoder, struct drm_bridge *bridge,
> >  }
> >  EXPORT_SYMBOL(drm_bridge_attach);
> >  
> > +/*
> > + * Invoked by the encoder during encoder cleanup in drm_encoder_cleanup(),
> > + * so should generally *not* be called by driver code.  
> 
> Why not?

Because this is what drm_bridge_attach() says O:-)

> * drm_bridge_attach - attach the bridge to an encoder's chain
...
> * Note that bridges attached to encoders are auto-detached during encoder
> * cleanup in drm_encoder_cleanup(), so drm_bridge_attach() should generally
> * *not* be balanced with a drm_bridge_detach() in driver code.

Also, it's what the code does.

> Also, it looks entirely unrelated to the rest of the patch.

Sure, I can split it. It is also redundant given that's repeating what
drm_bridge_attach() says.

I wrote this comment for future people looking at this code. If
_attach() takes a lock and _detach() does not, it could look like a
potential mistake, and someone could spend precious hours in trying to
fix it.

Maybe replace with:

  /* Must be called with the encoder bridge chain locked */

?

Luca

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

