Return-Path: <linux-kernel+bounces-734851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D69BAB08728
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 09:42:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A03803B8FE5
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 07:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D181324EABC;
	Thu, 17 Jul 2025 07:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="B9dNw4iF"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C93DBA27
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 07:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752738125; cv=none; b=ON+dUhSGPFQWCdTClJQSCZLmGcksd+txi/3THSw88DcCnsCZ/XZgLo//ZjQPEqQyNmPd5G9AShZAQINiCyGNrrsypjvTV1Clj2HgALEUd1f/A7ayKg72yhO6HxcDWvDDkXr0P+U1K7xOUiq3rRj4lM16fO6wuZxrvR7hYirr5Wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752738125; c=relaxed/simple;
	bh=vp6VrCKiHtGy2eFhrzHWBN12YyVCFgEVXIkG7FQXb58=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tq8jOyeI3IDrn/A/j7zLv8y58T8mgJis2U+qXtNLp2+//Zj5BnU55NMd9E4wY1yAQ52tPxMmJo2CLfPxKqeiFVq+gRFB+FbMRKZrlWTdISLWGNj+mXRIeWld+qrGYlzDEktQfJIQNq2TWwJlqOkUWQeR5mnvdhGg81APTrsMtCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=B9dNw4iF; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 21B744435F;
	Thu, 17 Jul 2025 07:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1752738116;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fTCB0MhY9raHq4U1R98VXnyfrvr0fz0dGAYz6OpWrYk=;
	b=B9dNw4iF6UKwg1ZkWqIJx6e7Mo8h44VxR9cpdH6QWwJn+5BCZ9x5WmWYAJ32fv8kE4Pwsn
	8SY+CGygPll7ZarxMecksxqNBVvQYvXJPzdubGtgY8EmKG96c/wgxeISDx7M9pTECt9+2p
	mvBEbCnhgCKMADb27/1qVLU2PJpWxo1f1lYtyq/YbEo3zEDIqC+RP4n9mQ3u8sj64o5M1n
	xylUfS0VOuzJogj/DwJzIo7oxCSOSNoOBz5sFqvwULUb1+XNSNNv/T45b14NlSIO/fy1Za
	q5v6dU+UtGUT2DOJHm9gcS/nP3Lr/3DTl9ypkbMRN1W5VQVU+RX9g5Y0ypdq4A==
Date: Thu, 17 Jul 2025 09:41:53 +0200
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Michael Walle <mwalle@kernel.org>
Cc: Jyri Sarha <jyri.sarha@iki.fi>, Tomi Valkeinen
 <tomi.valkeinen@ideasonboard.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/tidss: encoder: convert to devm_drm_bridge_alloc()
Message-ID: <20250717094153.35f854b7@booty>
In-Reply-To: <20250716134107.4084945-1-mwalle@kernel.org>
References: <20250716134107.4084945-1-mwalle@kernel.org>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeitddtudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkjghfohfogggtgfesthejredtredtvdenucfhrhhomhepnfhutggrucevvghrvghsohhlihcuoehluhgtrgdrtggvrhgvshholhhisegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpedtleejjeduvddutefftdduleefudfgudeltdeuffeuudefgfdugeekgedtieehudenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdgsohhothhlihhnrdgtohhmnecukfhppedvrgdtvdemieejtdemvddtvddtmegvrgdtudemsggvgedumeelhegvjeemfeegfeemledufegvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddvmeeijedtmedvtddvtdemvggrtddumegsvgegudemleehvgejmeefgeefmeeludefvgdphhgvlhhopegsohhothihpdhmrghilhhfrhhomheplhhutggrrdgtvghrvghsohhlihessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepuddtpdhrtghpthhtohepmhifrghllhgvsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehjhihrihdrshgrrhhhrgesihhkihdrfhhipdhrtghpthhtohepthhomhhirdhvrghlkhgvihhnvghnsehiu
 ggvrghsohhnsghorghrugdrtghomhdprhgtphhtthhopehmrggrrhhtvghnrdhlrghnkhhhohhrshhtsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohepmhhrihhprghrugeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthiiihhmmhgvrhhmrghnnhesshhushgvrdguvgdprhgtphhtthhopegrihhrlhhivggusehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhimhhonhgrsehffhiflhhlrdgthh
X-GND-Sasl: luca.ceresoli@bootlin.com

Hello Michael,

On Wed, 16 Jul 2025 15:41:07 +0200
Michael Walle <mwalle@kernel.org> wrote:

> Convert the tidss encoder to use devm_drm_bridge_alloc(). Instead of
> allocating the memory by drmm_simple_encoder_alloc() use
> devm_drm_bridge_alloc() and initialize the encoder afterwards.
> 
> Fixes: a7748dd127ea ("drm/bridge: get/put the bridge reference in drm_bridge_add/remove()")
> Signed-off-by: Michael Walle <mwalle@kernel.org>
> ---
>  drivers/gpu/drm/tidss/tidss_encoder.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/tidss/tidss_encoder.c b/drivers/gpu/drm/tidss/tidss_encoder.c
> index 95b4aeff2775..81a04f767770 100644
> --- a/drivers/gpu/drm/tidss/tidss_encoder.c
> +++ b/drivers/gpu/drm/tidss/tidss_encoder.c
> @@ -90,14 +90,18 @@ int tidss_encoder_create(struct tidss_device *tidss,
>  	struct drm_connector *connector;
>  	int ret;
>  
> -	t_enc = drmm_simple_encoder_alloc(&tidss->ddev, struct tidss_encoder,
> -					  encoder, encoder_type);
> +	t_enc = devm_drm_bridge_alloc(tidss->dev, struct tidss_encoder,
> +				      bridge, &tidss_bridge_funcs);
>  	if (IS_ERR(t_enc))
>  		return PTR_ERR(t_enc);
>  
> +	ret = drm_simple_encoder_init(&tidss->ddev, &t_enc->encoder,
> +				      encoder_type);

Nit: this should be a single line (< 100 chars).

> +	if (ret)
> +		return ret;
> +
>  	t_enc->tidss = tidss;
>  	t_enc->next_bridge = next_bridge;
> -	t_enc->bridge.funcs = &tidss_bridge_funcs;
>  
>  	enc = &t_enc->encoder;
>  	enc->possible_crtcs = possible_crtcs;

This patch switches from drmm_ to devm_, but I haven't checked in
detail whether this introduces a different lifetime. At a very quick
glance however it looks fine.

With that assumption, looks like a correct patch.

However allocating an encoder using a bridge alloc function (while we
used to call an encoder allocation function) looks counter-intuitive.

We had discussed on IRC a different idea, adding a wrapper structure
around the bridge. Quoting your proposal:

  struct tidss_encoder_bridge {
    struct drm_bridge bridge;
    struct tidss_encoder *encoder
  }

and then in the bridge funcs go from drm_bridge to tidss_encoder_brigde
and use the pointer to get the original private struct.

That would be cleaner and more intuitive, but use a bit more memory and
have an additional pointer deref, thus I think we can live with the
patch you just sent, at least for now.

In the long term it may be that more and more components of the DRM
subsystem become dynamically allocated like bridges and panels [0] have
recently become. So at some point it may make sense to add the bridge
wrapper struct and then go back to drmm_simple_encoder_alloc() for
allocation.

[0] https://lore.kernel.org/all/20250331-b4-panel-refcounting-v4-1-dad50c60c6c9@redhat.com/

Luca

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

