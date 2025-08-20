Return-Path: <linux-kernel+bounces-777536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20911B2DAA8
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 13:15:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C96143B31F4
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 11:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ED342E0411;
	Wed, 20 Aug 2025 11:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="TlfxQRPi"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5693B1E51FE
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 11:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755688390; cv=none; b=T+NgpUCB+ZwfmsskZSaKpRiV7/tGX5n9AwqBYPHl82iOJ3jxciyBHo84FnqE1rL7nBDPomNYnBNcWqIZshV1vha3oYtlEBcgN3A+BXvpWHwkswF4TPRLnAX8NSMMZuyZM1UuNnsyqb4/twcZglNtVQbzj0T6oa5Hqsi6fx4+z1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755688390; c=relaxed/simple;
	bh=G2IN6MxvO+KWLWpnKAajLSmhZ1aBl/PI+qPwYxMNuSQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r6x/vBk/mUDAnqLEvzw9EBqSBE3v94Rv0vw74Q0UcleNeUmxGeI2VryL2UlwLAswLCfV/k9Cul3wK8NmyAd3toH39DftSy4BoHFsY+gmI7vBFgfTxsnxJkqgxYNg8HIpKbvCManBfiWdWV2e01krxVno8IHWYmNgKgb0BUNOCJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=TlfxQRPi; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 88DC443292;
	Wed, 20 Aug 2025 11:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1755688385;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ou3MSRgBG8cP602wOscwCCqhc/Oa+T0DZwTTZNBffYE=;
	b=TlfxQRPi7CCIbzE9v7GFaL7B4qSx0xwJC2B3ssCV6ueN+1gXFc6zORcuq9Sk8Xxcnk83Gy
	lGxCe6BMFQhgEyOf5BTdumULIco7b7+Pz4BVy+XwmjivQ7+Y7X8RJqeMCiQEN+F8sijIHO
	dRmhlReSijd+b9G3cg1p3hZA16sNytLVZ2F1rkMkkwE2VKFOMzm504vS3gniWL35/b9Qkx
	w2G85zGZ3MKYj/VJTCHAAqqbeyb/AYzKQulY1pjhiRifd9lNjVKZStPlTVVy56oOlvfS8R
	uS09Gk3wVnnTMrvjmKhtDPJG12kXpVXXLQvJAcQkGC7DVQOh2zM/D+pUPcRZgg==
Date: Wed, 20 Aug 2025 13:13:02 +0200
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
Message-ID: <20250820131302.6a2da5ef@booty>
In-Reply-To: <l2orbpdoh3cqqgqudbnbdlogo3bd57uu4nv3ax74uoahknzjgr@gbxxuky3huw6>
References: <20250808-drm-bridge-atomic-vs-remove-v1-0-a52e933b08a8@bootlin.com>
	<20250808-drm-bridge-atomic-vs-remove-v1-2-a52e933b08a8@bootlin.com>
	<l2orbpdoh3cqqgqudbnbdlogo3bd57uu4nv3ax74uoahknzjgr@gbxxuky3huw6>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduheekvdduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtjeertdertddvnecuhfhrohhmpefnuhgtrgcuvegvrhgvshholhhiuceolhhutggrrdgtvghrvghsohhlihessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgeelffefgfehhfdtvdefueefieevkefggfelkeeiudetkeektedvhedukefgvddvnecuffhomhgrihhnpegsohhothhlihhnrdgtohhmnecukfhppedvrgdtvdemieejtdemvddtvddtmegvrgdtudemsggvgedumeelhegvjeemfeegfeemledufegvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddvmeeijedtmedvtddvtdemvggrtddumegsvgegudemleehvgejmeefgeefmeeludefvgdphhgvlhhopegsohhothihpdhmrghilhhfrhhomheplhhutggrrdgtvghrvghsohhlihessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepudeipdhrtghpthhtohepmhhrihhprghrugeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghnughriigvjhdrhhgrjhgurgesihhnthgvlhdrtghomhdprhgtphhtthhopehnvghilhdrrghrmhhsthhrohhngheslhhinhgrr
 hhordhorhhgpdhrtghpthhtoheprhhfohhssheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnfgruhhrvghnthdrphhinhgthhgrrhhtsehiuggvrghsohhnsghorghrugdrtghomhdprhgtphhtthhopehjohhnrghssehkfihisghoohdrshgvpdhrtghpthhtohepjhgvrhhnvghjrdhskhhrrggsvggtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgrrghrthgvnhdrlhgrnhhkhhhorhhstheslhhinhhugidrihhnthgvlhdrtghomh
X-GND-Sasl: luca.ceresoli@bootlin.com

Hello Maxime,

On Tue, 19 Aug 2025 14:29:32 +0200
Maxime Ripard <mripard@kernel.org> wrote:

> > @@ -1005,7 +1041,24 @@ static void sn65dsi83_remove(struct i2c_client *client)
> >  {
> >  	struct sn65dsi83 *ctx = i2c_get_clientdata(client);
> >  
> > +	drm_bridge_unplug(&ctx->bridge);
> >  	drm_bridge_remove(&ctx->bridge);  
> 
> Shouldn't we merge drm_bridge_unplug with the release part of
> devm_drm_bridge_alloc?

I'm not sure I got what you are suggesting here, sorry.

Do you mean that __devm_drm_bridge_alloc() should add a devres action
to call drm_bridge_unplug(), so the unplug is called implicitly and
does not need to be called explicitly by all drivers?

If that's what you mean, I don't think that would work. Unless I'm
missing something, devres actions are always invoked just after the
driver .remove callback. But we need to call drm_bridge_unplug() at the
beginning (or just before) .remove, at least for drivers that need to do
something in .remove that cannot be done by devm.

In pseudocode:

mybridge_remove()
{
  drm_bridge_unplug(); <-- explicit call as in my patch
  xyz_disable();
  drm_bridge_unplug(); <-- implicitly done by devres
}

We want xyz_disable() to be done after drm_bridge_unplug(), so other
code paths using drm_bridge_enter/exit() won't mess with xyz.

devres actions cannot be added to be executed _before_ .remove, AFAIK.

> > +	/*
> > +	 * sn65dsi83_atomic_disable() should release some resources, but it
> > +	 * cannot if we call drm_bridge_unplug() before it can
> > +	 * drm_bridge_enter(). If that happens, let's release those
> > +	 * resources now.
> > +	 */
> > +	if (ctx->disable_resources_needed) {
> > +		if (!ctx->irq)
> > +			sn65dsi83_monitor_stop(ctx);
> > +
> > +		gpiod_set_value_cansleep(ctx->enable_gpio, 0);
> > +		usleep_range(10000, 11000);
> > +
> > +		regulator_disable(ctx->vcc);
> > +	}  
> 
> I'm not sure you need this. Wouldn't registering a devm action do the
> same thing?

Good idea, thanks. I'll give it a try.

Luca

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

