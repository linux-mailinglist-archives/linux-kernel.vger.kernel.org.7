Return-Path: <linux-kernel+bounces-853299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B6647BDB284
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 22:08:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6D76F4E7BA0
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 20:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 534E0305962;
	Tue, 14 Oct 2025 20:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b="o6nhI27z";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=valla.it header.i=@valla.it header.b="d9ONREMb"
Received: from delivery.antispam.mailspamprotection.com (delivery.antispam.mailspamprotection.com [185.56.87.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32518289811
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 20:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.56.87.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760472519; cv=pass; b=OZKPVuEh/ipHmgYJD3fwZRGCl/Q+XRmpbObzKrOirO/FwGxDUsIxdsz5slacfNyeEGZQ3dPpTNJm9KR1mjCm8VeMHIpb888TAnzxWTMWjMSKcJWUs3JSIcdm4CP0J2mZSR8OFEkfFC83au8J1a206yHP78BVZtOXPr7v48mIjMc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760472519; c=relaxed/simple;
	bh=wqPHiJhR6p7x9nFQSEE5+mrpd2a3R2rTv1YQaUqHyUA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=nmeHO4s4TWkAQXAzXX/FV1xpC6cP5S54risAsm+YpO/3IlCd3tnAMyqWZgwAz63DPkb5we9qzI+yQ3MbZuocdQJs1KFYu9vtOqd5bHJtChLe2zrnUri728o+Ru9nLB0VEaI/9a9xMmXC2KkpRASlxRgbFIQPek/NQX8A+Jn4w4o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it; spf=pass smtp.mailfrom=valla.it; dkim=pass (1024-bit key) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b=o6nhI27z; dkim=pass (1024-bit key) header.d=valla.it header.i=@valla.it header.b=d9ONREMb; arc=pass smtp.client-ip=185.56.87.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valla.it
ARC-Seal: i=1; cv=none; a=rsa-sha256; d=outgoing.instance-europe-west4-77p9.prod.antispam.mailspamprotection.com; s=arckey; t=1760472517;
	 b=fzv1kbkGvoA0jtA4W+PVIKLueY+uxzehbo7Jf94+QtkTNhNr+Dihr0qVw9I2Z4Akhc/aPlilhg
	  jLalflqW3u9QHqDEPBM5HLagFbtcFydp/uWAVYupFrlChPdZzmKgtOFKnoeShH0aPkTerFVLlb
	  3B7z72FV8iHeECQbZ92orVVy3iI50lDGO9yhXaS8sCG+66qWgoQio+jJQ83AuKwkSElCrk7cnI
	  Ke/1ZEqYg46mqWV66LyQsjhZE3c0XRwCju1cMdoWTaREP1ExIdqz88lN8MEVFFEun96oQZXn/W
	  8VkoYGgXhv9VcHqfnMRUQG6xnAuHTYkBc5NVKrSCZCGhDg==;
ARC-Authentication-Results: i=1; outgoing.instance-europe-west4-77p9.prod.antispam.mailspamprotection.com; smtp.remote-ip=35.214.173.214;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed; d=outgoing.instance-europe-west4-77p9.prod.antispam.mailspamprotection.com; s=arckey; t=1760472517;
	bh=wqPHiJhR6p7x9nFQSEE5+mrpd2a3R2rTv1YQaUqHyUA=;
	h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:
	  Subject:From:DKIM-Signature:DKIM-Signature;
	b=F9DN8onx4jWiPcF2T8iRaMnt4oNU8DdQDDbwRclhmmhpxEWWCVL+Hpkb9CVuWG8td1hMs+688P
	  JOxXcBCqgSbOlO/qtW7sWlI2+tt/xp0RJVXZZDOR7+g3zw39sRSS+3rYgYrlDdyuyDSXlmxB5K
	  paHKaQC08z4i/QcIPhr5F0IqlhDTrzZkp16xhUu3a/wK/XNKGhVNFLfPgBWT9VrjR3HvV1Gy87
	  u5qiQo7Js3QxJ7m3+IqPae1GQehr2bhXvg0tGCeNDaA5YaSEiEl4CUbdMb58UyAqFCpAb14dZK
	  zZ7hwNWaERxqlJETNa83cpxlcmdJQJkXo6CocT8sugxf6w==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=antispam.mailspamprotection.com; s=default; h=CFBL-Feedback-ID:CFBL-Address
	:Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:Message-Id:Date:
	Subject:From:Reply-To:List-Unsubscribe;
	bh=JTxuc9xqEIIWcfhoNtl0F+NmY63FucuPml9QbGzMvxs=; b=o6nhI27zdPizq++a442pOX2ouz
	dQxprgasFvb/63lKYcP0TLZKmOXXx87sEtasyWTwhvtWxbXFGjxa9+2qXUxhECobtgnboELM1OJga
	levMdj5WOmegX0giEthI34+C9FYSGx8QfBLSIA+WhVfd2YVUPsAyPw+56UrxulUeQ5Sk=;
Received: from 214.173.214.35.bc.googleusercontent.com ([35.214.173.214] helo=esm19.siteground.biz)
	by instance-europe-west4-77p9.prod.antispam.mailspamprotection.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.1)
	(envelope-from <francesco@valla.it>)
	id 1v8lJw-00000000iKR-15W1
	for linux-kernel@vger.kernel.org;
	Tue, 14 Oct 2025 20:08:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=valla.it;
	s=default; h=Cc:To:Date:Subject:From:list-help:list-unsubscribe:
	list-subscribe:list-post:list-owner:list-archive;
	bh=JTxuc9xqEIIWcfhoNtl0F+NmY63FucuPml9QbGzMvxs=; b=d9ONREMbyDM4DunZUIbgMEEZhA
	h3ElDn4xVE8R4w7trzFIm7ofUr1Tka7w2TlqtDMxNSjL24wU52xzN0q7VBiPP0W9aER/dUG/i5fkk
	VHMLMeTDjpUirAjO/5Ex2HL3ZZZ1EOOkL+3g2rLO40FCy17pSFtaFIrFBftA+JzIwYV4=;
Received: from [87.16.13.60] (port=64127 helo=fedora.fritz.box)
	by esm19.siteground.biz with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.1)
	(envelope-from <francesco@valla.it>)
	id 1v8lJp-00000000E00-2hH6;
	Tue, 14 Oct 2025 20:08:25 +0000
From: Francesco Valla <francesco@valla.it>
Subject: [PATCH v2 0/3] drm/draw: add check API to avoid spurious WARN
Date: Tue, 14 Oct 2025 22:08:11 +0200
Message-Id: <20251014-drm_draw_conv_check-v2-0-05bef3eb06fb@valla.it>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKut7mgC/23NQQ7CIBCF4as0sxYDVKp15T1MQxCmdmKlBhrUN
 NxdbOLO5f+S+WaBiIEwwrFaIGCiSJMvITcV2MH4KzJypUFyqQTnNXPhrl0wT20nn7Qd0N5Ya23
 NFceLU3sol4+APb1W9dyVHijOU3ivT5L4rj9P/fWSYLygB7Fzbd3IvjklM45mSzN0OecP8/2NL
 rUAAAA=
X-Change-ID: 20251003-drm_draw_conv_check-9cc3050ebd57
To: Jocelyn Falempe <jfalempe@redhat.com>, 
 Javier Martinez Canillas <javierm@redhat.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Francesco Valla <francesco@valla.it>
X-Mailer: b4 0.14.2
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - esm19.siteground.biz
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - valla.it
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-SGantispam-id: cffb2e68098e46dd1325c6efd4a3c4d2
AntiSpam-DLS: false
AntiSpam-DLSP: 
AntiSpam-DLSRS: 
AntiSpam-TS: 1.0
CFBL-Address: feedback@antispam.mailspamprotection.com; report=arf
CFBL-Feedback-ID: 1v8lJw-00000000iKR-15W1-feedback@antispam.mailspamprotection.com
Authentication-Results: outgoing.instance-europe-west4-77p9.prod.antispam.mailspamprotection.com;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none

When using the DRM draw support, the only way to check if a color can be
converted from XRGB8888 to a target format is currently to attempt an
actual conversion using drm_draw_color_from_xrgb8888(). This function
however will print a WARN the first time a conversion cannot be
performed, leading to two potential issues:

 - a WARN is emitted without a real reason if the caller is only
   attempting a conversion to check if a format can be supported (which
   is the case for two of the current user of this API);
 - a failing call following the first one is not emitting a WARN, but a
   "valid" color value (0x00000000) is returned nevertheless.

The first issue was observed while using drm_log on a Beagleplay, which
lists AR12 as the first format for its HDMI modesets.

The target of this patch set is to improve this situation; the first
patch introduces a new API devoted only to check if a conversion from
XRGB8888 to the specified format can be performed, while the other two
substitute drm_draw_color_from_xrgb8888() with this new API in the
current users (drm_panic and drm_log) where relevant.

Signed-off-by: Francesco Valla <francesco@valla.it>
---
Changes in v2:
- Moved to dedicated switch cases in separate functions instead of
  single one inside common function.
- Fix copy-paste error in commit message.

Link to v1: https://lore.kernel.org/r/20251005-drm_draw_conv_check-v1-0-9c814d9362f6@valla.it

---
Francesco Valla (3):
      drm/draw: add drm_draw_can_convert_from_xrgb8888
      drm/log: avoid WARN when searching for usable format
      drm/panic: avoid WARN when checking format support

 drivers/gpu/drm/clients/drm_log.c   |  2 +-
 drivers/gpu/drm/drm_draw.c          | 29 +++++++++++++++++++++++++++++
 drivers/gpu/drm/drm_draw_internal.h |  2 ++
 drivers/gpu/drm/drm_panic.c         |  2 +-
 4 files changed, 33 insertions(+), 2 deletions(-)
---
base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
change-id: 20251003-drm_draw_conv_check-9cc3050ebd57

Best regards,
-- 
Francesco Valla <francesco@valla.it>


