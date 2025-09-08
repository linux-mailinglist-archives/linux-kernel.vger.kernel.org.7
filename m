Return-Path: <linux-kernel+bounces-805984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D8FEAB4904E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 15:52:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2B4316A17C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 13:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 021F2310620;
	Mon,  8 Sep 2025 13:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="dzYUrE+u"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B3630CD85
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 13:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757339360; cv=none; b=TuV2LgkS71LpN2foDPK4Q3ZL0VNfg1CkkTFH+/M6cin2uJqO3D90W3Xp+4DiKgYbvmGH/ItiLkgSBQ5Ki8/HdYky2RMMDacd5wV8ER2jvivSZAXSA4SoaNuJ6w3aLj8Cg16kty96uQ+60AvDjbD/gq8f0qGIr2Bs7SK7idoHGfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757339360; c=relaxed/simple;
	bh=ys7eARtWG4+X4mdw4FXYMFMW+K2qnW8JP2s1r4860Vs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FcF1uo1BH6g7fRwNT3ay1UkuAo9vg9j8OEU/tkNOIrQdGAoHgW1dtyRTVYqmtS4JMqEgv4dmyqfMomAmqVmOmKB78Dir4ZyRROw6oVayicKVgc2LhhcUeQMOGuktUX6WmJJHdSuhoJwU81R+eYYbEDE7RxaKNpsebXibX6Qehlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=dzYUrE+u; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2DEEF43A28;
	Mon,  8 Sep 2025 13:49:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1757339348;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kiPoiA09kCRQsZO7G/mkcjC5y5kAdNXv8UqvN5aY7o8=;
	b=dzYUrE+uGmhjenuz7HJfAvbMQsuLUTbU4ysJxkdgOVoOjyqf+NeUXng1TE52/+LXkpWhSm
	THN5L/9Rd48psOcOa1aM7s/sePVKzd0scSzBgKIMHFm4C/C9JrsZOAEBX3LvoNJKEZoOQt
	2DvKfuxOtYhGd2fnSN0c9HryDMZ6cDAC3jRB4paaPNUC9HpUMOgWoaG75PMcrv9IiYclDl
	pKBE0D8VuY0EOKYRY0uYJ97SxBJ+qidu2cJex0VNG8cbN8nWzOOY24JIO/eAPT9plYT/kG
	hqQqNXt2dTvBsiASaQfTT8Q5fDP/oScHudyYn19C3SQVs052Vz5qG9TZ7olihQ==
Date: Mon, 8 Sep 2025 15:49:06 +0200
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
Message-ID: <20250908154906.16693078@booty>
In-Reply-To: <20250827-charming-arcane-stingray-cfb8b6@houat>
References: <20250808-drm-bridge-atomic-vs-remove-v1-0-a52e933b08a8@bootlin.com>
	<20250808-drm-bridge-atomic-vs-remove-v1-2-a52e933b08a8@bootlin.com>
	<l2orbpdoh3cqqgqudbnbdlogo3bd57uu4nv3ax74uoahknzjgr@gbxxuky3huw6>
	<20250820131302.6a2da5ef@booty>
	<20250827-charming-arcane-stingray-cfb8b6@houat>
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
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddujeeilecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkjghfohfogggtgfesthejfedtredtvdenucfhrhhomhepnfhutggrucevvghrvghsohhlihcuoehluhgtrgdrtggvrhgvshholhhisegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeegheffjeffkeduhfekkeelgfejueehkeffleehjefgieejheeileektddthfejtdenucffohhmrghinhepsghoohhtlhhinhdrtghomhenucfkphepvdgrtddvmeeijedtmedvtddvtdemvggrtddumegsvgegudemleehvgejmeefgeefmeeludefvgenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtvdemieejtdemvddtvddtmegvrgdtudemsggvgedumeelhegvjeemfeegfeemledufegvpdhhvghlohepsghoohhthidpmhgrihhlfhhrohhmpehluhgtrgdrtggvrhgvshholhhisegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeduiedprhgtphhtthhopehmrhhiphgrrhgusehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrnhgurhiivghjrdhhrghjuggrsehinhhtvghlrdgtohhmpdhrtghpthhtohepnhgvihhlrdgrrhhmshhtrhhonhhgsehlihhnrghro
 hdrohhrghdprhgtphhtthhopehrfhhoshhssehkvghrnhgvlhdrohhrghdprhgtphhtthhopefnrghurhgvnhhtrdhpihhntghhrghrthesihguvggrshhonhgsohgrrhgurdgtohhmpdhrtghpthhtohepjhhonhgrsheskhifihgsohhordhsvgdprhgtphhtthhopehjvghrnhgvjhdrshhkrhgrsggvtgesghhmrghilhdrtghomhdprhgtphhtthhopehmrggrrhhtvghnrdhlrghnkhhhohhrshhtsehlihhnuhigrdhinhhtvghlrdgtohhm
X-GND-Sasl: luca.ceresoli@bootlin.com

Hi Maxime,

On Wed, 27 Aug 2025 09:46:03 +0200
Maxime Ripard <mripard@kernel.org> wrote:

> On Wed, Aug 20, 2025 at 01:13:02PM +0200, Luca Ceresoli wrote:
> > Hello Maxime,
> > 
> > On Tue, 19 Aug 2025 14:29:32 +0200
> > Maxime Ripard <mripard@kernel.org> wrote:
> >   
> > > > @@ -1005,7 +1041,24 @@ static void sn65dsi83_remove(struct i2c_client *client)
> > > >  {
> > > >  	struct sn65dsi83 *ctx = i2c_get_clientdata(client);
> > > >  
> > > > +	drm_bridge_unplug(&ctx->bridge);
> > > >  	drm_bridge_remove(&ctx->bridge);    
> > > 
> > > Shouldn't we merge drm_bridge_unplug with the release part of
> > > devm_drm_bridge_alloc?  
> > 
> > I'm not sure I got what you are suggesting here, sorry.
> > 
> > Do you mean that __devm_drm_bridge_alloc() should add a devres action
> > to call drm_bridge_unplug(), so the unplug is called implicitly and
> > does not need to be called explicitly by all drivers?  
> 
> Yes
> 
> > If that's what you mean, I don't think that would work. Unless I'm
> > missing something, devres actions are always invoked just after the
> > driver .remove callback.  
> 
> Yes, they are called in reverse order of registration, after remove.
> 
> > But we need to call drm_bridge_unplug() at the beginning (or just
> > before) .remove, at least for drivers that need to do something in
> > .remove that cannot be done by devm.
> > 
> > In pseudocode:
> > 
> > mybridge_remove()
> > {
> >   drm_bridge_unplug(); <-- explicit call as in my patch
> >   xyz_disable();
> >   drm_bridge_unplug(); <-- implicitly done by devres
> > }
> > 
> > We want xyz_disable() to be done after drm_bridge_unplug(), so other
> > code paths using drm_bridge_enter/exit() won't mess with xyz.  
> 
> It's not clear to me why doing it before xyz_disable() is important
> here? If anything, it would prevent from disabling the hardware for
> example, even though you still have your memory mapping, clocks, power
> domains, regulators, etc. to properly disable it.
> 
> You're still correct that it's a bad idea though because we want to do
> it before we start freeing all those, so it needs to execute as the
> before the devm actions ...
> 
> > devres actions cannot be added to be executed _before_ .remove, AFAIK.  
> 
> ... and we can't do that either.

I understand your words as "the drm_bridge_unplug() is OK where it is,
your patch is OK in this respect". Correct?

So if this is correct, and my reply on the devres cleanups is also
correct (other reply in this thread), that means the whole patch is OK.

Let me know if I'm wrong. :-)

Best regards,
Luca

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

