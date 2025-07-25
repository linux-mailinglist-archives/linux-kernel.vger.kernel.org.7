Return-Path: <linux-kernel+bounces-745962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61678B120FB
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 17:33:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9808B1620A7
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 15:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C32F377111;
	Fri, 25 Jul 2025 15:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="gOe7LK/f"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FAB1237164
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 15:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753457585; cv=none; b=OPMbd7ViPY2JSV93CUroX4i+j1lRLWV3W2tp41WQABtWXtvJjlBBe/3Er7Byt3sK66jnsN5fDreiDlQLzwAqVUWUSrAhChsd3BhevqZyaRmYYFOPiyIRZqqiHUqUzwDUrxskyiEicg1xOtDysjtwEm+KZP1jUCfnUOrhwITIiJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753457585; c=relaxed/simple;
	bh=anQbCV1o/PZdSHFN0mhA9yp1DbOS2JLpNl+NXQjo0i8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Im/Yl55lodNjJbrWVCDNQCGe8QLQeqRAFjMyHpjJ2/8nlOyy2b8T57+k0/NwEhqbv3b2KhHMN0F5JkwLH3I9De1u5k7Z1GgOi3mrKJ5krf99hkBKqN2tQ0QC/ZUTwLowzhMk6zVoJo0OnLEgVyMAtUhVwds6j7pVznxcs8X5Mbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=gOe7LK/f; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id BC9F443370;
	Fri, 25 Jul 2025 15:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1753457574;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VUw48bVGzQDtnzpFCZ6F0zUPopLUUADYRFUd0lfoHsE=;
	b=gOe7LK/fGYNTmz+SyIELCjPFaJaCHIQ1cZCxpO6F/7sKlMOxRRHmUVPl7IAXCdbmAmgzzJ
	qhK1BlYOirxaOuv7zUtH+7p+NHrT7W6MoGw6U1vHfQA3q6tieo1SqT5AB7M/5eaJxkGkDh
	83V53TpmJLyk2exzGH7/QY3Nr79ar/ovL9WHSEUPkTnM/j18kUW2laDfMW3XjN4q70C7Bn
	d4RvcOiRc1ArRt3EaCCaQHPmX90dMQCNFor+oGojqc5TmT1eBTWfPQ7A+mhqaGcjJZp8H7
	E3OoJs+8MH+AAVPMtTkqeQ2oGKbCKz9KUKrzwRmSNF45iIk+nck7NEh0a/V7Dg==
Date: Fri, 25 Jul 2025 17:32:48 +0200
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Maxime Ripard <mripard@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann
 <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, Laurent
 Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman
 <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, Inki Dae
 <inki.dae@samsung.com>, Jagan Teki <jagan@amarulasolutions.com>, Marek
 Szyprowski <m.szyprowski@samsung.com>, Jani Nikula
 <jani.nikula@linux.intel.com>, Dmitry Baryshkov <lumag@kernel.org>, Hui Pu
 <Hui.Pu@gehealthcare.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-sunxi@lists.linux.dev, Kevin Hilman <khilman@baylibre.com>, Jerome
 Brunet <jbrunet@baylibre.com>, Martin Blumenstingl
 <martin.blumenstingl@googlemail.com>, linux-amlogic@lists.infradead.org
Subject: Re: [PATCH 00/32] drm/mipi-dsi: avoid DSI host drivers to have
 pointers to DSI devices
Message-ID: <20250725173248.4cdca9e4@booty>
In-Reply-To: <20250725-juicy-falcon-of-climate-d87ea6@houat>
References: <20250625-drm-dsi-host-no-device-ptr-v1-0-e36bc258a7c5@bootlin.com>
	<20250707-strange-warm-bear-cb4ee8@houat>
	<20250707115853.128f2e6f@booty>
	<20250707121319.1e40a73a@booty>
	<20250725-juicy-falcon-of-climate-d87ea6@houat>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdekfeeltdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkjghfohfogggtgfesthejredtredtvdenucfhrhhomhepnfhutggrucevvghrvghsohhlihcuoehluhgtrgdrtggvrhgvshholhhisegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpedtleejjeduvddutefftdduleefudfgudeltdeuffeuudefgfdugeekgedtieehudenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdgsohhothhlihhnrdgtohhmnecukfhppedvrgdtvdemieejtdemvddtvddtmegvrgdtudemsggvgedumeelhegvjeemfeegfeemledufegvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddvmeeijedtmedvtddvtdemvggrtddumegsvgegudemleehvgejmeefgeefmeeludefvgdphhgvlhhopegsohhothihpdhmrghilhhfrhhomheplhhutggrrdgtvghrvghsohhlihessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepvdehpdhrtghpthhtohepmhhrihhprghrugeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgrrghrthgvnhdrlhgrnhhkhhhorhhstheslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhop
 ehtiihimhhmvghrmhgrnhhnsehsuhhsvgdruggvpdhrtghpthhtoheprghirhhlihgvugesghhmrghilhdrtghomhdprhgtphhtthhopehsihhmohhnrgesfhhffihllhdrtghhpdhrtghpthhtoheprghnughriigvjhdrhhgrjhgurgesihhnthgvlhdrtghomhdprhgtphhtthhopehnvghilhdrrghrmhhsthhrohhngheslhhinhgrrhhordhorhhgpdhrtghpthhtoheprhhfohhssheskhgvrhhnvghlrdhorhhg
X-GND-Sasl: luca.ceresoli@bootlin.com

Hi Maxime,

On Fri, 25 Jul 2025 17:22:47 +0200
Maxime Ripard <mripard@kernel.org> wrote:

...

> > The question is: should a DSI host bridge driver:
> > 
> >  A) wait for a DSI device to .attach before drm_bridge_add()ing itself,
> >     or
> >  B) drm_bridge_add() itself unconditionally, and let the DSI device
> >     .attach whenever it happens?
> > 
> > A) is what many drivers (IIRC the majority) does. It implies the card
> > will not be populated until .attach, which in the hotplug case could
> > happen very late
> > 
> > B) is done by a few drivers and allows the card to appear in the
> > hotplug case without the device, which is needed for hotplug.
> > 
> > I had tried simply moving drm_bridge_add() from .attach to probe in
> > the samsung-dsim driver in the pase but that would not work. Now I did
> > yet another check at the code and I suspect it can be done with a small
> > additional change, but cannot access the hardware to test it currently.
> > 
> > Answering this last question might change and simplify the requirements
> > discussed in the (very lengthy, sorry about that) discussion above.  
> 
> You're not going to like the answer too much, but I think that it is
> that "nobody knows".
> 
> The bad news is that I can't give you an answer, but the good one is
> that it gives us some leeway.
> 
> As I said in my previous mail, we should probably figure it out,
> document it, and then make it work for your drivers. Once we have a
> documentation we can point to, the rest will fall in line.

Thanks for taking time to reply this!

I just sent a patch to do the mentioned change in samsung-dsim [0] to
start discussion on real code. I'd appreciate if you could prioritize
that patch over all other patches I have sent.

[0] https://lore.kernel.org/all/20250725-drm-bridge-samsung-dsim-add-in-probe-v1-1-b23d29c23fbd@bootlin.com/

Best regards,
Luca

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

