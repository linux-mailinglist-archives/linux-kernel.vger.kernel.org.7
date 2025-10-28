Return-Path: <linux-kernel+bounces-874329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4BE2C160DB
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 18:08:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BABE51A66D6C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 17:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B614933A01C;
	Tue, 28 Oct 2025 17:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b="XPUaSY9G";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=valla.it header.i=@valla.it header.b="LAjIXLYA"
Received: from delivery.antispam.mailspamprotection.com (delivery.antispam.mailspamprotection.com [185.56.87.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 124EE28A3EF
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 17:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.56.87.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761671129; cv=pass; b=m8dESfybeOHEmNH1IDtBErKGum19uBrG/H8uEtO1WuwX+5NKOxMI5VEeKJyOVWA1OVnAoINdAIHREPzgKw/bPtNPP+dCFE6VCsz2G9HyN/fqDt/p+Fb9YJRuEbI31w/vJaLxfK1LFx4FQe3BhqIweNjfZe1iMbGkUiA8ivcXtnU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761671129; c=relaxed/simple;
	bh=OZ0ZtiH9Ffd/H3YhMXhZvm8XE+UAipi6AHVisU+hxWU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LdITW5I7BbBNrJFrd19JnNlNSijjnKentKrLsr9oUCCr35BBNj63wRAGAyKFc4wzpASQ2DcoMvhBhx1/Vv/Ps1Vjmfv01ChgKDaJsXZzbR3Ev69PboM94ax9XH7qGy7I912MzCc1d2ogqwT/yDeWXT+QLIqyUIVu3/Gk5c4zp9s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it; spf=pass smtp.mailfrom=valla.it; dkim=pass (1024-bit key) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b=XPUaSY9G; dkim=pass (1024-bit key) header.d=valla.it header.i=@valla.it header.b=LAjIXLYA; arc=pass smtp.client-ip=185.56.87.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valla.it
ARC-Seal: i=1; cv=none; a=rsa-sha256; d=outgoing.instance-europe-west4-4wj9.prod.antispam.mailspamprotection.com; s=arckey; t=1761671127;
	 b=P2omGGEwROmecSyNaHG81rg8m7Ww3YS976nlfVkFceT+4ALMX0sf8LZ8vgKALnrKjG7Qtstevj
	  HYKSvNuk0XCK4g2124E+aOUm8toZSEvQCxtEFCCe8wCGSzT5eRperSsEmPJna7QbfgHw0P0gQX
	  IH38gfAUvQe8hrNLDz66qNBHgSy1cLLv2OsjmEhgk0kMLvOIAniNEJUPJzqDDjMjRjHKcWxJoE
	  1WZKfcwSxm6/4HmpRnW90UUOXCiORXh7dr1qUUuJCKtgGeuii5m1w/IbCpcPps4cf7PZfM7Ysj
	  PF1aPs9GPryMnxxEqoTXPQpwJ7gyV7gY1xHVBxoiAXM0hg==;
ARC-Authentication-Results: i=1; outgoing.instance-europe-west4-4wj9.prod.antispam.mailspamprotection.com; smtp.remote-ip=35.214.173.214;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed; d=outgoing.instance-europe-west4-4wj9.prod.antispam.mailspamprotection.com; s=arckey; t=1761671127;
	bh=OZ0ZtiH9Ffd/H3YhMXhZvm8XE+UAipi6AHVisU+hxWU=;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	  To:From:DKIM-Signature:DKIM-Signature;
	b=GJDEfxoTS+OUxPbbTopq8KOjUx4TWJA1uhHz7PR22kskiMe11LRqPPpey1CR7xAd5fjM4ytAZI
	  fn2B9uwHSOk9dSGWoe4FG5T/6UDbCaWAG0Ouy3xJB1pvc87HxrgikoYfj61C8LSNc1X77e1ytq
	  dd5b2uC+1AgRGuoK3XES4anTe2toB6zWl7YqrK5EGlwkCNVViLlC4PxJ/F/qeowCie8418RUZ0
	  YEm2Oow1Hxx508vx/Ce6jVVIxI/zJFs65fPZpWpGCrbKCj74tXgNAQ+HTfkJREz9ZXkxH8I0Ks
	  MRuftlZ0NQlBHzmmpB70cieXXLYlZb1gsr3ODeVOlz7AFg==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=antispam.mailspamprotection.com; s=default; h=CFBL-Feedback-ID:CFBL-Address
	:Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	List-Unsubscribe:Content-Transfer-Encoding;
	bh=nFXGsd0wvJCB2aoq6ydUjxoEpP8AS5JY0g0UJ7Jo4rk=; b=XPUaSY9GM0qe4RKiJPoxKoWn4T
	aICUJzD6pNO0bSg2sATeZMq/bF0b4nV3B6DVCwC0W9vr1uTIvpNS4ZIurrg5hVJCNRRxZprPFxIPD
	MDG+t8/V0TApxpTP1cvl7hIPIJtyYp6o4UyspV3bQ1aJJbjPZlRvrHnBdoFl6nmDZPuA=;
Received: from 214.173.214.35.bc.googleusercontent.com ([35.214.173.214] helo=esm19.siteground.biz)
	by instance-europe-west4-4wj9.prod.antispam.mailspamprotection.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.1)
	(envelope-from <francesco@valla.it>)
	id 1vDm9G-0000000F3xt-2gG4
	for linux-kernel@vger.kernel.org;
	Tue, 28 Oct 2025 16:02:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=valla.it;
	s=default; h=Date:Subject:Cc:To:From:list-help:list-unsubscribe:
	list-subscribe:list-post:list-owner:list-archive;
	bh=nFXGsd0wvJCB2aoq6ydUjxoEpP8AS5JY0g0UJ7Jo4rk=; b=LAjIXLYAuKe+nn91fplPC8zwte
	Ub+TSBb3J+TqyLvVF4RU3DTnoGllzWP9T+jeUeALMF3MBgHttDcK3t6DYSFJnb/+D3Bp41AiTeG1l
	xWRwKT05PmIKAGN487/QO54yYlwiqTgVuLa29SgACOLG1ZQO7W3YCgvCS2xQGS4abhg0=;
Received: from [87.17.42.198] (port=63724 helo=fedora.localnet)
	by esm19.siteground.biz with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.1)
	(envelope-from <francesco@valla.it>)
	id 1vDm8f-000000009YH-2cLa;
	Tue, 28 Oct 2025 16:01:37 +0000
From: Francesco Valla <francesco@valla.it>
To: Liu Ying <victor.liu@nxp.com>, Marek Vasut <marex@denx.de>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Fabian Pflug <f.pflug@pengutronix.de>, dri-devel@lists.freedesktop.org,
 imx@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/bridge: ldb: add support for an external bridge
Date: Tue, 28 Oct 2025 17:01:24 +0100
Message-ID: <2860884.vuYhMxLoTh@fedora>
In-Reply-To: <1944228.tdWV9SEqCh@steina-w>
References:
 <20251028-imx93_ldb_bridge-v1-1-fca2e7d60e0a@valla.it>
 <1944228.tdWV9SEqCh@steina-w>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5090209.OV4Wx5bFTl";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - esm19.siteground.biz
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - valla.it
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-SGantispam-id: 723bc1ca69d378485273679a25d3335b
AntiSpam-DLS: false
AntiSpam-DLSP: 
AntiSpam-DLSRS: 
AntiSpam-TS: 1.0
CFBL-Address: feedback@antispam.mailspamprotection.com; report=arf
CFBL-Feedback-ID: 1vDm9G-0000000F3xt-2gG4-feedback@antispam.mailspamprotection.com
Authentication-Results: outgoing.instance-europe-west4-4wj9.prod.antispam.mailspamprotection.com;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none

--nextPart5090209.OV4Wx5bFTl
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Francesco Valla <francesco@valla.it>
Date: Tue, 28 Oct 2025 17:01:24 +0100
Message-ID: <2860884.vuYhMxLoTh@fedora>
In-Reply-To: <1944228.tdWV9SEqCh@steina-w>
MIME-Version: 1.0

Hi,

On Tuesday, 28 October 2025 at 13:27:37 Alexander Stein <alexander.stein@ew.tq-group.com> wrote:
> Hi Francesco,
> 
> Am Dienstag, 28. Oktober 2025, 13:12:29 CET schrieb Francesco Valla:
> > One option for the LVDS port of the LDB is to be connected to an
> > additional bridge, such as a LVDS to HDMI converter. Add support for
> > such case, along with the direct connection to a panel.
> > 
> > Signed-off-by: Francesco Valla <francesco@valla.it>
> > ---
> > I was trying to add display support for the i.MX93 FRDM on top of the
> > patch sent some time ago by Fabian Pflug [1], using some of the work
> > already done by Alexander Stein but not yet merged [2], but then I
> > noticed that the support for LVDS-HDMI converter bridges was missing
> > from the LDB driver already present for the i.MX93.
> > 
> > Not a fail of the driver itself, obviously, but I wonder if/how the
> > existing i.MX8MP setups (e.g.: [3]), which use the same driver, work
> > correclty. Unfortunately I don't have the i.MX8MP hardware to test them.
> > 
> > Anyhow, a patch for such setup is attached; it was tested on the i.MX93
> > FRDM using [1] and [2] plus some more devicetree modifications.
> > 
> > [1] https://lore.kernel.org/all/20251022-fpg-nxp-imx93-frdm-v3-1-03ec40a1ccc0@pengutronix.de
> > [2] https://lore.kernel.org/all/20250304154929.1785200-1-alexander.stein@ew.tq-group.com
> > [3] https://elixir.bootlin.com/linux/v6.17.5/source/arch/arm64/boot/dts/freescale/imx8mp-evk-lvds0-imx-dlvds-hdmi-channel0.dtso
> > 
> > Regards,
> > Francesco
> > ---
> >  drivers/gpu/drm/bridge/fsl-ldb.c | 26 +++++++++++++++++---------
> >  1 file changed, 17 insertions(+), 9 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/bridge/fsl-ldb.c b/drivers/gpu/drm/bridge/fsl-ldb.c
> > index 5c3cf37200bcee1db285c97e2b463c9355ee6acb..fad436f2e0bfac8b42096a6fcd0022da0f35284e 100644
> > --- a/drivers/gpu/drm/bridge/fsl-ldb.c
> > +++ b/drivers/gpu/drm/bridge/fsl-ldb.c
> > @@ -294,7 +294,6 @@ static int fsl_ldb_probe(struct platform_device *pdev)
> >  	struct device *dev = &pdev->dev;
> >  	struct device_node *panel_node;
> >  	struct device_node *remote1, *remote2;
> > -	struct drm_panel *panel;
> >  	struct fsl_ldb *fsl_ldb;
> >  	int dual_link;
> >  
> > @@ -335,15 +334,24 @@ static int fsl_ldb_probe(struct platform_device *pdev)
> >  		fsl_ldb_is_dual(fsl_ldb) ? "dual-link mode" :
> >  		fsl_ldb->ch0_enabled ? "channel 0" : "channel 1");
> >  
> > -	panel = of_drm_find_panel(panel_node);
> > -	of_node_put(panel_node);
> > -	if (IS_ERR(panel))
> > -		return PTR_ERR(panel);
> > -
> > -	fsl_ldb->panel_bridge = devm_drm_panel_bridge_add(dev, panel);
> > -	if (IS_ERR(fsl_ldb->panel_bridge))
> > -		return PTR_ERR(fsl_ldb->panel_bridge);
> > +	/* First try to get an additional bridge, if not found go for a panel */
> > +	fsl_ldb->panel_bridge = of_drm_find_bridge(panel_node);
> > +	if (fsl_ldb->panel_bridge) {
> > +		of_node_put(panel_node);
> > +	} else {
> > +		struct drm_panel *panel;
> >  
> > +		panel = of_drm_find_panel(panel_node);
> > +		of_node_put(panel_node);
> > +		if (IS_ERR(panel))
> > +			return dev_err_probe(dev, PTR_ERR(panel),
> > +					     "Failed to find panel");
> > +
> > +		fsl_ldb->panel_bridge = devm_drm_panel_bridge_add(dev, panel);
> > +		if (IS_ERR(fsl_ldb->panel_bridge))
> > +			return dev_err_probe(dev, PTR_ERR(fsl_ldb->panel_bridge),
> > +					     "Failed to add panel bridge");
> > +	}
> 
> Without looking into the details this somehow looks similar to
> drm_of_find_panel_or_bridge(), or drmm_of_get_bridge for the managed variant.
> 
> Best regards,
> Alexander
> 
> >  
> >  	if (fsl_ldb_is_dual(fsl_ldb)) {
> >  		struct device_node *port1, *port2;
> > 
> > ---
> > base-commit: fd57572253bc356330dbe5b233c2e1d8426c66fd
> > change-id: 20251028-imx93_ldb_bridge-3c011e7856dc
> > 
> > Best regards,
> > 
> 
> 
> 

Well, I did not know of devm_drm_of_get_bridge(), and unfortunately the
driver I checked (Samsung DSIM) has not yet been updated to use it.
Sorry for the noise.

I'll wait for more feedback (if any) and then send a v2 - which looks
much cleaner now.

Thank you!

Regards,
Francesco

--nextPart5090209.OV4Wx5bFTl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRUrtjevJ039mawAeLir2xSXEi5AAUCaQDo1AAKCRDir2xSXEi5
AA83AP0VODlMOPiFo+Etj7oaFVsgFDTnwBhEX54ICokuPyWjewEA/RnsnW2CT6zy
NlUewINvfCea60Pz3od7UPV/AbPhvgg=
=eIuv
-----END PGP SIGNATURE-----

--nextPart5090209.OV4Wx5bFTl--




