Return-Path: <linux-kernel+bounces-898832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 18643C561C1
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 08:50:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B4D71342C28
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 07:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC59F32ED41;
	Thu, 13 Nov 2025 07:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Fs46xumC"
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD47C301004
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 07:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763020203; cv=none; b=t5Bft7FisgcXF6/ButQT2wEvAR657PcGStlrPb4uHBehaLUbZvIilx49S1L3aB8vSXkkvhzf32Z+EGJ5Uk+E7ApBho+Jr42eockjpnqs/6tDJtPMY2b2NX2PRQlvMl7D+wsUnY/R+6bQTpq+Il6Wflg0leCuUI9I6Yzy1sdxLHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763020203; c=relaxed/simple;
	bh=CYUxaRVdnkO8INxjVez/NqLTT9qn9nO8JWbhwLdLjS0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MhB14+GdtHIqGV4qkA26ZYd9Pi3z8rZGpr+nlLE6inOYHoscW+k4jn99VTUL42HRRhFMsCkb4rFyvb6IfHSue7f5Xm0bJSE1msuViFKkfkrlcdKfJBAZMwIaS2XtZy6uD3WqWUq9ZJ7NeTDUjXQ4OeUtMhY1+jsDczUH0fvt1Z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Fs46xumC; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id CBC944E4167F;
	Thu, 13 Nov 2025 07:49:57 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 9EB986068C;
	Thu, 13 Nov 2025 07:49:57 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5A522102F182C;
	Thu, 13 Nov 2025 08:49:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1763020196; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=09Mb+D15S2RcxtFci5mixnzc0SY2qTDKvhXPP64yilY=;
	b=Fs46xumC4ZEDToBHMg6mg0OPZqWRZAmd9zvldAPBvUTz43MO9GtMdL5dJxBViBkw4KtS7i
	evYsG0CpsuMizfmOHty4UAWYT5kB91RcWk+JlD2tgJs/Abj+6wMl3vxdWUXFtdZOY3rdfX
	vCYR+ID+eiPmsenNo4aJ39xOz9fUOK/MMQRC9kQflZzRsMCtEqFd4G6vfczCObUKAX3nWm
	LRGBO+UeFHGXlZMN95IbUhUQYwxaHKXEo0TjiCPAzuCepl1w9y9oJn8cuyqdxQLX0YzQMV
	KvW040fwSeF0MVJZJy53v6x+Dup8szK6kgNhZynKmvfyg1xS3t2cjrnxKQcRXg==
Date: Thu, 13 Nov 2025 08:49:50 +0100
From: Herve Codina <herve.codina@bootlin.com>
To: =?UTF-8?B?Sm/Do28=?= Paulo =?UTF-8?B?R29uw6dhbHZlcw==?=
 <jpaulo.silvagoncalves@gmail.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, Laurent
 Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman
 <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Tomi Valkeinen
 <tomi.valkeinen@ideasonboard.com>, =?UTF-8?B?Sm/Do28=?= Paulo
 =?UTF-8?B?R29uw6dhbHZlcw==?= <joao.goncalves@toradex.com>,
 linux-kernel@vger.kernel.org, regressions@lists.linux.dev
Subject: Re: [REGRESSION] TI SN65DSI83 is being reset making display to
 blink On/Off
Message-ID: <20251113084950.44a09e8e@bootlin.com>
In-Reply-To: <bhkn6hley4xrol5o3ytn343h4unkwsr26p6s6ltcwexnrsjsdx@mgkdf6ztow42>
References: <bhkn6hley4xrol5o3ytn343h4unkwsr26p6s6ltcwexnrsjsdx@mgkdf6ztow42>
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
X-Last-TLS-Session-Version: TLSv1.3

Hi João

On Mon, 10 Nov 2025 16:03:51 -0300
João Paulo Gonçalves <jpaulo.silvagoncalves@gmail.com> wrote:

> Hello,
> 
> After commit ad5c6ecef27e ("drm: bridge: ti-sn65dsi83: Add error
> recovery mechanism"), our DSI display stopped working correctly. The
> display internally uses a TI SN65DSI83 to convert DSI-to-LVDS, and with
> the change, it keeps blinking on and off because the bridge is being
> reset by the error recovery mechanism.
> 
> Even before the change, it was possible to see the message below from
> the driver indicating that the bridge's internal PLL was not locked
> (register 0xE5, bit 0 in [1]):
> 
> [ 11.198616] sn65dsi83 2-002c: Unexpected link status 0x01
> 
> However, it was working. After the change, it stopped working. Masking
> the PLL error makes it work again:
> 
> diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi83.c b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
> index 033c44326552..89a0a2ab45b1 100644
> --- a/drivers/gpu/drm/bridge/ti-sn65dsi83.c
> +++ b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
> @@ -429,7 +429,7 @@ static void sn65dsi83_handle_errors(struct sn65dsi83 *ctx)
>          */
> 
>         ret = regmap_read(ctx->regmap, REG_IRQ_STAT, &irq_stat);
> -       if (ret || irq_stat) {
> +       if (ret || (irq_stat & ~REG_IRQ_STAT_CHA_PLL_UNLOCK)) {
>                 /*
>                  * IRQ acknowledged is not always possible (the bridge can be in
>                  * a state where it doesn't answer anymore). To prevent an
> 
> Any suggestions on how to proceed here?
> 
> #regzbot introduced: ad5c6ecef27e
> 
> [1] https://www.ti.com/lit/ds/symlink/sn65dsi83.pdf
> 

The PLL should be locked.

Also in the datasheet, in 'Table 7-2. Initialization Sequence', the status
is checked at the end of the initialization sequence and the sequence has to
be done again when the status register value is not 0x00.

Even before monitoring (irq or polling method), you have an issue with your PLL
mentioned with the "sn65dsi83 2-002c: Unexpected link status 0x01" message.

I don't understand even how your panel can be correctly driven with the bridge
PLL unlock.

I don't think that masking the error would be the correct solution.
The root cause has to be identified. The "sn65dsi83 2-002c: Unexpected link
status 0x01" should not appear.

Can you check your clocks ?
Does your hardware use the REFCLK external clock ?

The driver expects the clock from the MIPI D-PHY channel A HS continuous (bit 0
in 0x0A register).

Best regards,
Hervé

clock

