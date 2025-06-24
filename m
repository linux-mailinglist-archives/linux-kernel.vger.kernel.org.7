Return-Path: <linux-kernel+bounces-700121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B7EF3AE642E
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jun 2025 14:04:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C64D44A35E0
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jun 2025 12:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDC8C283FF0;
	Tue, 24 Jun 2025 12:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="oPO4EzlQ"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E47221A42F
	for <linux-kernel@vger.kernel.org>; Tue, 24 Jun 2025 12:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750766632; cv=none; b=idEGjogt2r0EBFnj1QmM85qEnQfyVTNVaWQvwiX5sHmqpbLLOWrctxRaYhqGC1iqF51kYNkgFte/Uyb9SrfhIsUiWYWt5WM0YbjQavlBXNt3vdAgUOeVYaaec8vKmFP+e5HbWvMeEYe3tbqCayxZk65PGi+69EU4Hc10JujzN9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750766632; c=relaxed/simple;
	bh=ai6ZAgrONJPMVHW95BV/Zgq/ABAtIRDlHa5S/GZjhNc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j6LkVts8E+Kpjb5nOqsGINql3XAaB8kGMhLuyBsghC2rqY1JMVHTuSVO0kXbCdhKqlMayA1mjfhk1GjrtVXRq3NDJTZCW9+PLStRrTxJF5I9Wum0lFPHWPheYDoKzO1/UEJ1KNS6jI7E/aXnyNyBpuZFFlmvzBzqXRIKLFaXj0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=oPO4EzlQ; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 803C943E8E;
	Tue, 24 Jun 2025 12:03:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1750766627;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CHAiwzXpqXLDPpuzv59uAE+lMbsVeaPtdYUt36LhKe4=;
	b=oPO4EzlQfgkv+lBMzEzWfmiYztuxZnDxePJIipcIYbh5eapFgQuZqJWEnYKghyN7xyVlQy
	WDPyNhxPBMDSrospGpMzgM6GdSzIp/lZSRQDqWiMRd7c8L6O3Bao3Eb4nxhRPzzZiXXx0o
	u5yOaKTTDFzV9sYotPkc/1U8A47oqb+pgXhc3oZTivTe6WGuOPMs1CfkBaLfm4NpGLZe0d
	eQuN3JOj+sV5ylcOsCjIacsxpv/BHQJ5swRzPdqKRdk4BnQku/eb/P1c0D0ghzhiD9OOUh
	rKm/iUcAKTgCug12jhCVZhqqTrHS2tvjtHzQdf3WONBAjM/EyC3tu1A+qHF1rQ==
Date: Tue, 24 Jun 2025 14:03:45 +0200
From: Herve Codina <herve.codina@bootlin.com>
To: Mike Looijmans <mike.looijmans@topic.nl>
Cc: dri-devel@lists.freedesktop.org, Andrzej Hajda
 <andrzej.hajda@intel.com>, David Airlie <airlied@gmail.com>, Jernej Skrabec
 <jernej.skrabec@gmail.com>, Jonas Karlman <jonas@kwiboo.se>, Laurent
 Pinchart <Laurent.pinchart@ideasonboard.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Simona Vetter <simona@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/bridge: ti-sn65dsi83: Improve error reporting and
 handling
Message-ID: <20250624140345.77e8780d@bootlin.com>
In-Reply-To: <20250624114630.303058-1-mike.looijmans@topic.nl>
References: <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.213ecd1f-6e92-42df-b45b-58dd7ea05682@emailsignatures365.codetwo.com>
	<20250624114630.303058-1-mike.looijmans@topic.nl>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgdduleekgecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkjghfohfogggtgfesthekredtredtjeenucfhrhhomhepjfgvrhhvvgcuvehoughinhgruceohhgvrhhvvgdrtghoughinhgrsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeeviefffeegiedtleelieeghfejleeuueevkeevteegffehledtkeegudeigffgvdenucfkphepvdgrtddumegvtdgrmedvkeehmegsleektdemvgegtdgtmeeitgegfeemsgehsggsmegrgedvkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemvgdtrgemvdekheemsgelkedtmegvgedttgemiegtgeefmegshegssgemrgegvdekpdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpehhvghrvhgvrdgtohguihhnrgessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepudegpdhrtghpthhtohepmhhikhgvrdhlohhoihhjmhgrnhhssehtohhpihgtrdhnlhdprhgtphhtthhopegurhhiqdguvghvvghlsehlihhsthhsrdhfrhgvvgguvghskhhtohhprdhorhhgpdhrtghpthhtoheprghnughriigvjhdrhhgrjhgurgesihhnthgvlhdrtghomhdprhgtp
 hhtthhopegrihhrlhhivggusehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhgvrhhnvghjrdhskhhrrggsvggtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhonhgrsheskhifihgsohhordhsvgdprhgtphhtthhopefnrghurhgvnhhtrdhpihhntghhrghrthesihguvggrshhonhgsohgrrhgurdgtohhmpdhrtghpthhtohepmhgrrghrthgvnhdrlhgrnhhkhhhorhhstheslhhinhhugidrihhnthgvlhdrtghomh
X-GND-Sasl: herve.codina@bootlin.com

Hi Mike,

On Tue, 24 Jun 2025 13:45:15 +0200
Mike Looijmans <mike.looijmans@topic.nl> wrote:

> The datasheet advises to wait 5ms after starting the video stream before
> resetting the error registers. The driver only waits 1ms. Change the
> sequence to match the datasheet:
> - Turn on the DSI
> - Wait 5ms
> - Write 0xFF to CSR 0xE5 to clear the error registers
> 
> Don't read the error register (which may fail), just write 0xff as the
> datasheet suggests.
> 
> The driver creates a timer or IRQ handler that reads the error register,
> which implements the "wait some time and read the register" part.
> 
> When using a timer to poll the status register, the timer did not stop
> when the error handler triggers a reset. This has been observed to cause
> a series of multiple resets. Let handle_errors return a bool indicating
> whether all is fine, and only extend the time when it returns true. That
> also allows the IRQ disable call to move to the interrupt routine.
> 
> When the error handler does trigger, log a message that explains the
> reset cause.
> 
> Fixes: ad5c6ecef27e ("drm: bridge: ti-sn65dsi83: Add error recovery mechanism")
> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
> ---
> 
>  drivers/gpu/drm/bridge/ti-sn65dsi83.c | 50 +++++++++++++++------------
>  1 file changed, 28 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi83.c b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
...

> @@ -929,7 +926,16 @@ static irqreturn_t sn65dsi83_irq(int irq, void *data)
>  {
>  	struct sn65dsi83 *ctx = data;
>  
> -	sn65dsi83_handle_errors(ctx);
> +	if (!sn65dsi83_handle_errors(ctx)) {
> +		/*
> +		 * IRQ acknowledged is not always possible (the bridge can be in
> +		 * a state where it doesn't answer anymore). To prevent an
> +		 * interrupt storm, disable interrupt. The interrupt will be
> +		 * after the reset.

I think I have missed a verb in the last sentence when I previously wrote
the comment.
  "The interrupt will be re-enabled after the reset."
                         ^^^^^^^^^^
Can you fix it ?

Other than that,

Reviewed-by: Herve Codina <herve.codina@bootlin.com>

Thanks,
Hervé

