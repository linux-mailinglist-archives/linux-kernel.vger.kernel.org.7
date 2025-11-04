Return-Path: <linux-kernel+bounces-884391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A65E8C30157
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 09:56:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD5263ABA9E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 08:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01C8C26ED5F;
	Tue,  4 Nov 2025 08:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="0l18l1Ec"
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 697712264C7
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 08:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762246188; cv=none; b=mO/MjkP0yBJbc9+cGuJLPo0DOXeyClVWEvjEEVxXVxtiSPxbxbEMFmFPvqGSkM3vYm76YDSWy36hdp8tu93Wa//VdDHshGCJKxyoQquQ6GwYP3XpCawS81ZATtpIUtIv2IcYvsWdSy9IXRndHojPMlgtVfD7okC+jzcbDFcfFXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762246188; c=relaxed/simple;
	bh=wefYREvfSzi6Mbcb6iAa8IMRp2PZxdz6gU89b2qus8U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LVol5IlMWaulwNQz+sDrUbzBNvAGAXnc7imdaj0CFkQhkHIPJ+AZRGZ5ujzryRfIKltaJ40dooFUiXqsYvw9I/0rIFNFWaEC6El5SWmOK2yHEeKwwn8vt5ci3u4AsxcvWZZgepQsEbQu6Z2uFiFxXuUcM5VPjBSx8oLDm4IKB3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=0l18l1Ec; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id B47E21A1863;
	Tue,  4 Nov 2025 08:49:44 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 873B5606EF;
	Tue,  4 Nov 2025 08:49:44 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2B3E110B50978;
	Tue,  4 Nov 2025 09:49:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1762246183; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=+tnp7G3ycwRnFF38hQrrWjWXR0KKwEMtXOrxp4e42tw=;
	b=0l18l1EcsipvNaABsQ4OBR3pQhYZjQlb/sgy9nI/k3hijfsR0CbIIjE1gdyaJUb0Pe0mLX
	fOrlQbZ+I9IkAqQK8psRVPIyZ+mO1/FGxGDzOsGNfRpRzzQhHWz8wPIvlW1RIre658qLEW
	5Ybapx3Yly8nvatPJBzrEUckVxQGX8NCKtA+uL+zxU//Tp1J8lFMLoegWHwmC5XdvqotNf
	XDiAFVyqTRRUlNI2i9l8TmhPUUzwPsUbKtYn+DYBPMgMwGzvdPQQUALNN6Y8DGfzEaSRny
	ti73SUEEWACLJPMtc3fkJroYNyJ6tQ17aaTnnK0P9T9YXxssJC1YpdujjxxXhQ==
Date: Tue, 4 Nov 2025 09:49:37 +0100
From: Herve Codina <herve.codina@bootlin.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Jessica Zhang <jessica.zhang@oss.qualcomm.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 2/3] drm/panel: Add support for the Leadtek LTK08QV25BYL
 panel
Message-ID: <20251104094937.042afc40@bootlin.com>
In-Reply-To: <c47fc9bd-c041-4fc7-b08d-8f15622f4fba@linaro.org>
References: <20251021073408.195959-1-herve.codina@bootlin.com>
	<20251021073408.195959-3-herve.codina@bootlin.com>
	<c47fc9bd-c041-4fc7-b08d-8f15622f4fba@linaro.org>
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

Hi Neil,

On Wed, 29 Oct 2025 21:45:24 +0100
Neil Armstrong <neil.armstrong@linaro.org> wrote:

...

> > +
> > +static const struct drm_display_mode ltk028qv25byl_mode = {
> > +	.hdisplay       = 240,
> > +	.hsync_start    = 240 + 120,
> > +	.hsync_end      = 240 + 120 + 4,
> > +	.htotal         = 240 + 120 + 4 + 120,
> > +	.vdisplay       = 320,
> > +	.vsync_start    = 320 + 8,
> > +	.vsync_end      = 320 + 8 + 2,
> > +	.vtotal         = 320 + 8 + 2 + 6,
> > +	.clock          = 10000000 / 1000,  
> 
> Usually we calculate the clock from the mode parameters, won't it work here ?
> 

The panel has an internal oscillator an the data transfer need to be sync with
this oscillator.

10M pixel per sec is the value set by the vendor.
I tried to use a value based on other mode parameters such as
  (240 + 120 + 4 + 120) * (320 + 8 + 2 + 6) * 60 / 1000

and it didn't work. I also tried ' ... * 90 / 1000) and ' ... * 100 / 1000)
without better results.

I can add a comment if you want in the next iteration to spot the value:
--- 8< ---
	.clock          = 10000000 / 1000,  /* 10 Mbps, internal panel oscillator */
--- 8< ---

Let me know.


...

> > +	ctx->iovcc = devm_regulator_get(dev, "iovcc");
> > +	if (IS_ERR(ctx->iovcc))
> > +		return dev_err_probe(dev, PTR_ERR(ctx->iovcc),
> > +				     "Failed to get iovcc regulator\n");  
> 
> Can you switch to devm_regulator_bulk_get_const() ?

Yes, I will do that in the next iteration.

Best regards,
Hervé

