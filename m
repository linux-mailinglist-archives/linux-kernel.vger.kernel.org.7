Return-Path: <linux-kernel+bounces-841405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 188F4BB737A
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 16:42:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B3A1E4E1299
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 14:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1692D26E6FA;
	Fri,  3 Oct 2025 14:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b="VUUxxGtG";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=valla.it header.i=@valla.it header.b="X8xWTx8W"
Received: from delivery.antispam.mailspamprotection.com (delivery.antispam.mailspamprotection.com [185.56.87.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 215D223AB8B
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 14:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.56.87.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759502545; cv=pass; b=oAVnstoa3WQTf1Ah0oIONKbs4itDpm+ypUm2EJZmg+CEso+sFlwmZD4ISzPp5f+qfOR/yuX8XiZxir+OlGFQU9WSMXh/6kDtFCMYkXWw0jxqpP1BQRdjONo31FBhyCTclwPCoIEScAhj4qsAYzKjAdCta6kYV2N6gOolfuk2gB0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759502545; c=relaxed/simple;
	bh=z5pWesQeBEu2tz3WESYSl81lA5ozGiJ2lIViR3AO4N8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gPvtQZrZpZHSHCyplVe0kHcm/vc3M0BN91BjDqgezyKS2wHRbXAqmWSmkL/gnr1qJaApUGmsQ0pUYYC1gXem+CeX6T+isDXGbo7rQ/sMGFA4YH+1DqMLXh1R21XZ7gfFdBvSqjGwRkH/B1GxFDTkRXGuXUHhoZIu1uAlZepxiwE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it; spf=pass smtp.mailfrom=valla.it; dkim=pass (1024-bit key) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b=VUUxxGtG; dkim=pass (1024-bit key) header.d=valla.it header.i=@valla.it header.b=X8xWTx8W; arc=pass smtp.client-ip=185.56.87.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valla.it
ARC-Seal: i=1; cv=none; a=rsa-sha256; d=outgoing.instance-europe-west4-nf36.prod.antispam.mailspamprotection.com; s=arckey; t=1759502543;
	 b=k1JjGXgAVAKf4cgxCOKu/sMJk74YpwYSG0aMW4FCpA992wfXuV5SdNdtZENlBtyQjkfGia6jba
	  NqRkdwuGrewmVFl6OZmhiQxKCw5LFnc63Fp95CnviSr0X32esKNZ3BSaV9NOFCN5sPO9joWmXe
	  +VWP8Rm5g8M7umtO7c2WIHiJuvBHmRV1iGV5NdA3OSvruEN5I8mAv6hwX2Ffug6jjuGF9fQMxU
	  MjWPS/daG9fq4Rlr/7So2zf69AGLThqux5MfVxIZL4/kY2YtqlkvRfzxURRvWrkITHd4kOesoD
	  kIcq3dryiU2IsHTqQ8RFh/cbGRAx35CdRCmooTeAjJJ/0A==;
ARC-Authentication-Results: i=1; outgoing.instance-europe-west4-nf36.prod.antispam.mailspamprotection.com; smtp.remote-ip=35.214.173.214;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed; d=outgoing.instance-europe-west4-nf36.prod.antispam.mailspamprotection.com; s=arckey; t=1759502543;
	bh=z5pWesQeBEu2tz3WESYSl81lA5ozGiJ2lIViR3AO4N8=;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	  Message-ID:Date:Subject:Cc:To:From:DKIM-Signature:DKIM-Signature;
	b=GSoxRFDV/gprnDF31hkPHZuVWcO5V7dBH9kPZfBYGKM1hxt1xg9g5xxac9rAQ64izZdW06uOgO
	  jenfLhua5+XXUyfMs4R/ibrfk3LgComo0idbkInEpzY3OUzSVeHe55uJW5QvYyCNHR1g/CxYKk
	  AqvhMQa7PFrI2Ni2Qv4drS7h+QYTkEg4wTPrRCt578ssdMbdLdJKtTgJSQXu0l0+adzQWpfhnV
	  enQbQFtnzaQPEP60VoltsknqzObyIFum7KC85aRIRnAfcVUTunYY+nvfsAAb7rNUjCtfkMqDoL
	  eU8qUZ+hkdOXa53a1QyasUDunorojJsciABvKz8mAKjMRQ==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=antispam.mailspamprotection.com; s=default; h=CFBL-Feedback-ID:CFBL-Address
	:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Reply-To:List-Unsubscribe;
	bh=9xIOa3STLJfIfWlCx0nyVc0lcGQQgCGdRx9kH4nGS4k=; b=VUUxxGtGmGUIPP2Jzww0hnkxtd
	fmyFrqFJ2P02z5fIVbrIkx51yHTE63W3KVxjaS8pvq4zy5kEcgyFPm0TaxAY0QlnI/+MOyeI1Z98o
	g0QxbfiPLfwXJtP7t7T3Od90uryrgCglUhxpNLhegl/vxzbkaunSJy8gn+oMjAU73qfo=;
Received: from 214.173.214.35.bc.googleusercontent.com ([35.214.173.214] helo=esm19.siteground.biz)
	by instance-europe-west4-nf36.prod.antispam.mailspamprotection.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.1)
	(envelope-from <francesco@valla.it>)
	id 1v4gz6-00000003k9J-05qD
	for linux-kernel@vger.kernel.org;
	Fri, 03 Oct 2025 14:42:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=valla.it;
	s=default; h=Date:Subject:Cc:To:From:list-help:list-unsubscribe:
	list-subscribe:list-post:list-owner:list-archive;
	bh=9xIOa3STLJfIfWlCx0nyVc0lcGQQgCGdRx9kH4nGS4k=; b=X8xWTx8WTHrKuBU+R71bjKlABL
	KEcHl3O8rRc1w7t20kn3PL4HiO1b25Ovk5SDqpQKFYk4GIuwrsHL/XyiePmnNK8Aa/2PZszBNVbTp
	2mMu6Zb75tgN/5WjFg87+UnkVSS9Mt6A9Q05GODu7bgTMP6VDG2pt38zqpNnF6Hl9dWU=;
Received: from [87.16.13.60] (port=60027 helo=fedora-2.fritz.box)
	by esm19.siteground.biz with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.1)
	(envelope-from <francesco@valla.it>)
	id 1v4gyp-00000000ERx-0Fjt;
	Fri, 03 Oct 2025 14:41:55 +0000
From: Francesco Valla <francesco@valla.it>
To: Javier Martinez Canillas <javierm@redhat.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jocelyn Falempe <jfalempe@redhat.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/draw: fix color truncation in drm_draw_fill24
Date: Fri, 03 Oct 2025 16:41:54 +0200
Message-ID: <3881844.vuYhMxLoTh@fedora-2.fritz.box>
In-Reply-To: <70cbbf88-7c1e-44f4-8091-ee76944d2f6b@redhat.com>
References:
 <20251003-drm_draw_fill24_fix-v1-1-8fb7c1c2a893@valla.it>
 <70cbbf88-7c1e-44f4-8091-ee76944d2f6b@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - esm19.siteground.biz
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - valla.it
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-SGantispam-id: e0a651a0c9111a21e0d0b72b9a774623
AntiSpam-DLS: false
AntiSpam-DLSP: 
AntiSpam-DLSRS: 
AntiSpam-TS: 1.0
CFBL-Address: feedback@antispam.mailspamprotection.com; report=arf
CFBL-Feedback-ID: 1v4gz6-00000003k9J-05qD-feedback@antispam.mailspamprotection.com
Authentication-Results: outgoing.instance-europe-west4-nf36.prod.antispam.mailspamprotection.com;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none

Hi Jocelyn,

On Friday, 3 October 2025 at 14:48:03 Jocelyn Falempe <jfalempe@redhat.com> wrote:
> On 10/3/25 12:33, Francesco Valla wrote:
> > The color parameter passed to drm_draw_fill24() was truncated to 16
> > bits, leading to an incorrect color drawn to the target iosys_map.
> > Fix this behavior, widening the parameter to 32 bits.
> > 
> Oh, you're right, my mistake.
> Did you find this by using a 24bit hardware, or by looking at the code?
> 
> Reviewed-by: Jocelyn Falempe <jfalempe@redhat.com>
> 
> Best regards,
> 

I am working on a graphical splash DRM client (which I hope I'll be
able to post soon) and testing it on a Beagleplay - which is
RG24-capable - I started to see a strange behavior with non-black
colors. After some investigation I found the cuplrit, and strangely
enough it wasn't me this time.

Best regards,

Francesco







