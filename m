Return-Path: <linux-kernel+bounces-810682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA86BB51DD5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 18:35:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71D9A162E24
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 16:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C97926D4EB;
	Wed, 10 Sep 2025 16:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="zr7tmHzH"
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59045267387
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 16:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757522104; cv=none; b=XZW0pyX/QZa/NHYCmLcq8gn+DhrCv6qZE3/EFbZWxgk12IIIR4zpLBd7iw37otr008fsSrtr2xgRJTv7Go9lCkwdljZaZ8LNYU+/D0G48mTiyOwkDbRvGcxXODfM5c4fmDCJ008DsKLAKsToNymc/CzZz59cCySjN1hkI3E2pww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757522104; c=relaxed/simple;
	bh=jKAsUD4oHPGtqjOd3Tc7AifQDyVp2WbT7gojou8pCrg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tC98e8hsGJco/OcEjJ4DjDDQp1f5txMvNbNWSaL0J0lIIKiJ1+8J9soPSe7MOt9yA5Lm/czc3wum1f2bEpUd22h6CqKO4tOp5XvmnLjeu+WqeKeDM7FJjQ1UG2rpt81OL3VBlqmzPFaLB8Dmkz2X9AYBFk+tiwxbeOAl8gvx8/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=zr7tmHzH; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id CB2101A0D5A;
	Wed, 10 Sep 2025 16:35:00 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id B9F1A606D4;
	Wed, 10 Sep 2025 16:35:00 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 57FD4102F292B;
	Wed, 10 Sep 2025 18:34:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1757522099; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=X2b6+Nl1KIR1LF6HdKe9hNfppcCRQR7JbvwrsgEtuuY=;
	b=zr7tmHzHIJb8fsqhH5CSxTqc7cBc4qfgcCHpVhfiOjZvoFh3BFCEn7apF3H6VxngpnQZK7
	KZ4SxLqZQSA+eGH1PZ3K+b/Gq1oaNYQnPofWeQlCXUwBkDX72zCReycxQPGaVviCj6R33k
	5bzbvYesJRL+NjKoWUx5dwruJCZ5blf1caEf07+wOoZjATlNbTh75Whhppl+CLK5IPEN3K
	p2QvOUZqxElzV8sfPcZa/4wc7DeQCcu0s0l0OIi27goVrzcWsOnzW946HsDjj8DoclKWV+
	sz815RByWtUiakpOedJHD4IHhMcoH1tmyUoz7GmbOsTikPhMbgjot2tey7d7PA==
Date: Wed, 10 Sep 2025 18:34:40 +0200
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Maxime Ripard <mripard@kernel.org>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, Laurent
 Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman
 <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann
 <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>, Hui Pu <Hui.Pu@gehealthcare.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Dmitry Baryshkov <lumag@kernel.org>
Subject: Re: [PATCH 2/2] drm/bridge: ti-sn65dsi83: protect device resources
 on unplug
Message-ID: <20250910183440.3fe50fac@booty>
In-Reply-To: <20250910-amazing-camouflaged-barracuda-bb79cb@houat>
References: <20250808-drm-bridge-atomic-vs-remove-v1-0-a52e933b08a8@bootlin.com>
	<20250808-drm-bridge-atomic-vs-remove-v1-2-a52e933b08a8@bootlin.com>
	<l2orbpdoh3cqqgqudbnbdlogo3bd57uu4nv3ax74uoahknzjgr@gbxxuky3huw6>
	<20250820131302.6a2da5ef@booty>
	<20250908154901.64f1a639@booty>
	<20250910-amazing-camouflaged-barracuda-bb79cb@houat>
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

Hi Maxime,

On Wed, 10 Sep 2025 09:52:21 +0200
Maxime Ripard <mripard@kernel.org> wrote:

> On Mon, Sep 08, 2025 at 03:49:01PM +0200, Luca Ceresoli wrote:
> > Hello Maxime,
> > 
> > On Wed, 20 Aug 2025 13:13:02 +0200
> > Luca Ceresoli <luca.ceresoli@bootlin.com> wrote:
> >   
> > > > > +	/*
> > > > > +	 * sn65dsi83_atomic_disable() should release some resources, but it
> > > > > +	 * cannot if we call drm_bridge_unplug() before it can
> > > > > +	 * drm_bridge_enter(). If that happens, let's release those
> > > > > +	 * resources now.
> > > > > +	 */
> > > > > +	if (ctx->disable_resources_needed) {
> > > > > +		if (!ctx->irq)
> > > > > +			sn65dsi83_monitor_stop(ctx);
> > > > > +
> > > > > +		gpiod_set_value_cansleep(ctx->enable_gpio, 0);
> > > > > +		usleep_range(10000, 11000);
> > > > > +
> > > > > +		regulator_disable(ctx->vcc);
> > > > > +	}      
> > > > 
> > > > I'm not sure you need this. Wouldn't registering a devm action do the
> > > > same thing?    
> > > 
> > > Good idea, thanks. I'll give it a try.  
> > 
> > I'm catching up with this series after being busy a few weeks...
> > 
> > I looked at this, but contrary my initial impression I think it would
> > not be an improvement.
> > 
> > The reason is at least one of these cleanup actions (namely the
> > regulator_disable()) must be done only if there is a matching enable,
> > which is in atomic_pre_enable. This is why I introduced a flag in the
> > first place.
> > 
> > I'm not sure which usage of devres you had in mind, but I see two
> > options.
> > 
> > Option 1: in probe, add a devres action to call a function like:
> > 
> > sn65dsi83_cleanups()
> > {
> > 	if (ctx->disable_resources_needed) {
> > 		/* the same cleanups */
> > 	}    
> > }
> > 
> > But that is just a more indirect way of doing the same thing, and
> > relies on the same flag.
> > 
> > Option 2: have a function to unconditionally do the cleanups:
> > 
> > sn65dsi83_cleanups()
> > {
> > 	/* the same cleanups (no if) */
> > }
> > 
> > And then:
> >  * in atomic_pre_enable, instead of setting the flag
> >    add a devres action to call sn65dsi83_cleanups()
> >  * in atomic_disable, instead of clearing the flag
> >    remove the devres action
> > 
> > Even this option looks like more complicated and less readable code
> > to do the same thing.
> > 
> > Do you have in mind a better option that I haven't figured out?  
> 
> Would using devm_add_action in atomic_pre_enable, and
> devm_release_action in atomic_post_disable work?
> 
> That way, if you have a typical enable / disable cycle, the action will
> get registered and executed properly, and if you only have an enable but
> no matching disable, it will be collected after remove.

So you're OK with option 2. I just implemented it, works well and the
resulting code is a bit cleaner. Queued for v2.

Luca

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

