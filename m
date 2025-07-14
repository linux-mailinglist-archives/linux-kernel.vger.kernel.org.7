Return-Path: <linux-kernel+bounces-729793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CC30B03B9D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 12:09:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 964431756A5
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 10:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4BDF23B616;
	Mon, 14 Jul 2025 10:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="FndN3beY"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC0D23F417
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 10:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752487739; cv=none; b=sRVYXgedfeYMD9Imekg+bsORvEjeTXp5W3qwwDn9z0/VlN16TkRCkbPRTUDOHS99T7WWumUd9Z+0SuOh4LyZImh4OfGEuKiLkyNZA+sZM4MsBEUKQ9uY+BTHru1Gy8SMYteSl22Tv2LTDX5U8Q4xNof1+yvYxAKbgfqueGE4BSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752487739; c=relaxed/simple;
	bh=sUbfXG/kIveTshOzurB1Oe+PyDBe1n88waGVjM3wNbY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m25a4akLpDSZ0spaLVg8bbBA2kFr116Wx3u9OJgsIQyF0DFNzG76b5JJQdnn51jeSAiULXnDvOjhPrWZateMzYS3ICj1XgRzkQyQusKKObKPT6Efypb6tyDI0m+H9aSN7yA0/zG2DzcNZtIEjMlQDmArvL6pVQv8Dx1SAVKRvqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=FndN3beY; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1CF1B43185;
	Mon, 14 Jul 2025 10:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1752487727;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xgutdRjLLdQi2RnkqaGrlwK27BoBj8ki0FopHfGLe9A=;
	b=FndN3beY+pz3fPT55Ct9FIe1LlXQ/Q/0trzzGTE7v8shKaH6N8hB6rSUm5xc18XaWT6uXM
	WBa/3dW/YemVx5qHH4SV+U/urhVy7ebch00KZ+tby7S8Jz1aQKkhH1coLFGtqkFDqsTFnR
	IJBGe8FLiHYPZSFtmB/Zj4h0Mos6wc5s2K/U5FWZ/Af3yzyKzsXaHtz6v3j6EK6YY1/ECn
	+El+AYDpTXnPJ1wT1dWQPHgw1g6eRf+aod4AHiIhqPlbv3nQAkC9dSfImFuSsIrwO1JTvC
	Fyhg88E/VCE50CEOgXoHYDUA2Z8lLgF7W9haRc3nM0OMYJ8u/iK8d2o1dg+Npw==
Date: Mon, 14 Jul 2025 12:08:42 +0200
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Maxime Ripard <mripard@kernel.org>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, Laurent
 Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman
 <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann
 <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>, Liu Ying <victor.liu@nxp.com>, Shawn Guo
 <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix
 Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, Philipp Zabel
 <p.zabel@pengutronix.de>, Hui Pu <Hui.Pu@gehealthcare.com>, Thomas
 Petazzoni <thomas.petazzoni@bootlin.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 8/9] drm/bridge: put the bridge returned by
 drm_bridge_get_next_bridge()
Message-ID: <20250714120842.3b336998@booty>
In-Reply-To: <20250710-classic-bouncy-caiman-8e2045@houat>
References: <20250709-drm-bridge-alloc-getput-drm_bridge_get_next_bridge-v1-0-48920b9cf369@bootlin.com>
	<20250709-drm-bridge-alloc-getput-drm_bridge_get_next_bridge-v1-8-48920b9cf369@bootlin.com>
	<20250710-classic-bouncy-caiman-8e2045@houat>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdehudeijecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkjghfohfogggtgfesthejredtredtvdenucfhrhhomhepnfhutggrucevvghrvghsohhlihcuoehluhgtrgdrtggvrhgvshholhhisegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeeglefffefghefhtddvfeeufeeiveekgffgleekieduteekkeetvdehudekgfdvvdenucffohhmrghinhepsghoohhtlhhinhdrtghomhenucfkphepvdgrtddvmeeijedtmedvtddvtdemvggrtddumegsvgegudemleehvgejmeefgeefmeeludefvgenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtvdemieejtdemvddtvddtmegvrgdtudemsggvgedumeelhegvjeemfeegfeemledufegvpdhhvghlohepsghoohhthidpmhgrihhlfhhrohhmpehluhgtrgdrtggvrhgvshholhhisegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvgedprhgtphhtthhopehmrhhiphgrrhgusehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrnhgurhiivghjrdhhrghjuggrsehinhhtvghlrdgtohhmpdhrtghpthhtohepnhgvihhlrdgrrhhmshhtrhhonhhgsehlihhnrghro
 hdrohhrghdprhgtphhtthhopehrfhhoshhssehkvghrnhgvlhdrohhrghdprhgtphhtthhopefnrghurhgvnhhtrdhpihhntghhrghrthesihguvggrshhonhgsohgrrhgurdgtohhmpdhrtghpthhtohepjhhonhgrsheskhifihgsohhordhsvgdprhgtphhtthhopehjvghrnhgvjhdrshhkrhgrsggvtgesghhmrghilhdrtghomhdprhgtphhtthhopehmrggrrhhtvghnrdhlrghnkhhhohhrshhtsehlihhnuhigrdhinhhtvghlrdgtohhm
X-GND-Sasl: luca.ceresoli@bootlin.com

Hi Maxime,

On Thu, 10 Jul 2025 09:27:09 +0200
Maxime Ripard <mripard@kernel.org> wrote:

> Hi,
> 
> On Wed, Jul 09, 2025 at 06:48:07PM +0200, Luca Ceresoli wrote:
> > The bridge returned by drm_bridge_get_next_bridge() is refcounted. Put it
> > when done.
> > 
> > Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>  
> 
> You should really expand a bit more your commit logs, and provide the
> context of why you think putting drm_bridge_put where you do is a good idea.
> 
> > ---
> >  drivers/gpu/drm/drm_bridge.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
> > index 0b450b334afd82e0460f18fdd248f79d0a2b153d..05e85457099ab1e0a23ea7842c9654c9a6881dfb 100644
> > --- a/drivers/gpu/drm/drm_bridge.c
> > +++ b/drivers/gpu/drm/drm_bridge.c
> > @@ -1147,6 +1147,8 @@ drm_atomic_bridge_propagate_bus_flags(struct drm_bridge *bridge,
> >  	} else {
> >  		next_bridge_state = drm_atomic_get_new_bridge_state(state,
> >  								next_bridge);
> > +		drm_bridge_put(next_bridge);
> > +
> >  		/*
> >  		 * No bridge state attached to the next bridge, just leave the
> >  		 * flags to 0.  
> 
> In particular, I don't think it is here.
> 
> You still have a variable in scope after that branch that you would have
> given up the reference for, which is pretty dangerous.
> 
> Also, the bridge state lifetime is shorter than the bridge lifetime
> itself, so we probably want to have the drm_bridge_put after we're done
> with next_bridge_state too.

Totally agree about this.

I theory moving the _put just after the last usage of next_bridge_state
would be enough. However...

> Overall, I think using __free here is probably the most robust solution.

...I'm OK with using use __free here, even though it doesn't look
strictly necessary. However for patch 9 the code path is slightly more
complex, so I'll use __free for both.

With this change, this patch would become:

@@ -1121,7 +1121,6 @@ drm_atomic_bridge_propagate_bus_flags(struct drm_bridge *bridge,
                                      struct drm_atomic_state *state)
 {
        struct drm_bridge_state *bridge_state, *next_bridge_state;
-       struct drm_bridge *next_bridge;
        u32 output_flags = 0;
 
        bridge_state = drm_atomic_get_new_bridge_state(state, bridge);
@@ -1130,7 +1129,7 @@ drm_atomic_bridge_propagate_bus_flags(struct drm_bridge *bridge,
        if (!bridge_state)
                return;
 
-       next_bridge = drm_bridge_get_next_bridge(bridge);
+       struct drm_bridge *next_bridge __free(drm_bridge_put) = drm_bridge_get_next_bridge(bridge);
 
        /*
         * Let's try to apply the most common case here, that is, propagate

And a tentative commit message body is:

  The bridge returned by drm_bridge_get_next_bridge() is refcounted. Put
  it when done. We need to ensure it is not put before either
  next_bridge or next_bridge_state is in use, thus for simplicity use a
  cleanup action.

I'll resend with the above changes (unless you have more improvements to
suggest) in a few days, to wait for any feedback on patch 1.

Luca

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

