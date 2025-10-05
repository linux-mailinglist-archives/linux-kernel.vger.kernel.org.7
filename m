Return-Path: <linux-kernel+bounces-842441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E12EBB9CE6
	for <lists+linux-kernel@lfdr.de>; Sun, 05 Oct 2025 22:22:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 46F3C4E0418
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Oct 2025 20:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90BD21EA7CB;
	Sun,  5 Oct 2025 20:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b="t9Mc9Bi3";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=valla.it header.i=@valla.it header.b="aCxm8IDv"
Received: from delivery.antispam.mailspamprotection.com (delivery.antispam.mailspamprotection.com [185.56.87.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04CED8488
	for <linux-kernel@vger.kernel.org>; Sun,  5 Oct 2025 20:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.56.87.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759695734; cv=pass; b=G2x/emFXfGycdUnKlU6AZLp7zVSjksALoiTO3Usr+T/2YA7YThVTLXlijURxKZL+PLCjhR55Bw+pMQ7U2jYire+BLFRtgCEAimveKff/lMYb/k8TPh9WYA2OyheIEJLXz18SMzullNefwazF2BXbBBdBTbvBu0K1PzLPB5G+wF4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759695734; c=relaxed/simple;
	bh=FXZJZnHFm7AcCELiEKqAF4gqy7DH+gDol0yrbGFFqMA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=PalUz9uUmcR7ep67fS+LwU1Ql8rWbc/rweqJeQe/TCY+EKjH8xZPiTY5InP8R9HL4NxrWckYCshjjRl1irxTmbwGBkbi5EKd8j5nUHtjMwaBT3VO7GzUbj/CcqfxaMsSUq7Txno8mAFSmWq7FcL2Ko2sXizO87lqowXY5CgieRU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it; spf=pass smtp.mailfrom=valla.it; dkim=pass (1024-bit key) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b=t9Mc9Bi3; dkim=pass (1024-bit key) header.d=valla.it header.i=@valla.it header.b=aCxm8IDv; arc=pass smtp.client-ip=185.56.87.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valla.it
ARC-Seal: i=1; cv=none; a=rsa-sha256; d=outgoing.instance-europe-west4-nf36.prod.antispam.mailspamprotection.com; s=arckey; t=1759695732;
	 b=hWcX4U+05ps+y8ycnySNyRvXYSQhvBWIbA7mbQLbdZYEn13UPc8Pywxf0anIEpdhqehPxhy2b+
	  g8akMkmjqg1QRD/Zd/hiULQymuMQ1VwucEPW1pPdFJ+XMD+GxZHHboN7/lJcYunSd9pUnPhcty
	  olOfXTAkcBeYxHAMFq5j3WrHqkL7pQvpHQAhX1jfCAMqNT+HrTIfFkZAjYnp+EFrqkjSVnemdp
	  Wdu2q9u7XjS1yWiHzR1eHxaHtM9AhdeGhouUcLwpfdEYWBERAtXPeRP15FW4lgRFWRs1mqXae/
	  TPiSxfLfYhtbGR4uWO0WetqoNkFXP6y3yCIyHn2SpWtjog==;
ARC-Authentication-Results: i=1; outgoing.instance-europe-west4-nf36.prod.antispam.mailspamprotection.com; smtp.remote-ip=35.214.173.214;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed; d=outgoing.instance-europe-west4-nf36.prod.antispam.mailspamprotection.com; s=arckey; t=1759695732;
	bh=FXZJZnHFm7AcCELiEKqAF4gqy7DH+gDol0yrbGFFqMA=;
	h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:
	  Subject:From:DKIM-Signature:DKIM-Signature;
	b=O21bnGUITxeQ3LhWAwVqZrcrGrCqANVQ0A5HuQDAvK7ivK82OukeeCeYekHRo6sAl+R/DEmB5k
	  uCnfc9e+drVYLZJlmPb3w4kPXhp2sxOFrAuU3PqVMkEvELX4BL5uAtodfBvhs63VFu/dUqRebY
	  ACT2NVIrOdnbUSuaJlCm87wZ59Zvchbwd3YOLRQdzna4EnUGajzUWj/9FGZSXi2WDYex8LiSYj
	  fpdyQXNLqnzfZoxQ28lWS1oIMAhBEMOClxGmkjSc4ngSSl+3V6Q3dp1dDCGv/8nW6WvZTm0VR1
	  mdwOiIvCP8SjE6euQiv5Iet+M/2ELpEsdwynhxl+zyjV4Q==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=antispam.mailspamprotection.com; s=default; h=CFBL-Feedback-ID:CFBL-Address
	:Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:Message-Id:Date:
	Subject:From:Reply-To:List-Unsubscribe;
	bh=zSVYyYOYyhfyYwoqIZwjause6u3NI8YS2rCw9RIrS0k=; b=t9Mc9Bi3GUQK/Ew0jQGcS2j9k0
	wpCCoKn2GV/F1yEnv/rjDLUmcgbvhK9fXoHog9Eapvzd3qlFNTnHySL47x3rOD1pVRJLaZU8UzweF
	68cjcYnG9PZ0wHmESMJkyAi+64Ntu7QGGim6DmaAr6Vk+NqMLouqlAEYs3JH2EIOoaKA=;
Received: from 214.173.214.35.bc.googleusercontent.com ([35.214.173.214] helo=esm19.siteground.biz)
	by instance-europe-west4-nf36.prod.antispam.mailspamprotection.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.1)
	(envelope-from <francesco@valla.it>)
	id 1v5VF0-00000008IgS-2dXZ
	for linux-kernel@vger.kernel.org;
	Sun, 05 Oct 2025 20:22:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=valla.it;
	s=default; h=Cc:To:Date:Subject:From:list-help:list-unsubscribe:
	list-subscribe:list-post:list-owner:list-archive;
	bh=zSVYyYOYyhfyYwoqIZwjause6u3NI8YS2rCw9RIrS0k=; b=aCxm8IDvaUEG7mhEdRVuHDaZRx
	hPJNPCAJT8RMaKw0j2SPj/0MkPToRFxiBdI9QzFR+CkTLsJgUDq8V770b94WfuOkUwrZWUciuWnRh
	xtkhzniAi2uSUnlkwAEjuZ/DqsvjMDINarSR7Va5OBayVsJhA1XXbHR61ZUMZPO+88gk=;
Received: from [87.16.13.60] (port=64461 helo=fedora.fritz.box)
	by esm19.siteground.biz with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.1)
	(envelope-from <francesco@valla.it>)
	id 1v5VEu-000000001im-02Nc;
	Sun, 05 Oct 2025 20:21:52 +0000
From: Francesco Valla <francesco@valla.it>
Subject: [PATCH 0/3] drm/draw: add check API to avoid spurious WARN
Date: Sun, 05 Oct 2025 22:21:33 +0200
Message-Id: <20251005-drm_draw_conv_check-v1-0-9c814d9362f6@valla.it>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAE3T4mgC/x3M0QpAQBBA0V/RPNsatIlfkTZmB5MszRZK/t3m8
 Tzc+0BkFY7QZg8onxJlDwlFngEtQ5jZiE+GEktbIFbG6+a8DpejPZyOFqbVNEQVWuTR2xpSeSh
 Pcv/Xrn/fD1Vs9yJlAAAA
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
X-SGantispam-id: 16c1ed4ba2dbe22484d7a0c7710b8558
AntiSpam-DLS: false
AntiSpam-DLSP: 
AntiSpam-DLSRS: 
AntiSpam-TS: 1.0
CFBL-Address: feedback@antispam.mailspamprotection.com; report=arf
CFBL-Feedback-ID: 1v5VF0-00000008IgS-2dXZ-feedback@antispam.mailspamprotection.com
Authentication-Results: outgoing.instance-europe-west4-nf36.prod.antispam.mailspamprotection.com;
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
Francesco Valla (3):
      drm/draw: add drm_draw_can_convert_from_xrgb8888
      drm/log: avoid WARN when searching for usable format
      drm/log: avoid WARN when checking format support

 drivers/gpu/drm/clients/drm_log.c   |  2 +-
 drivers/gpu/drm/drm_draw.c          | 84 +++++++++++++++++++++++++++----------
 drivers/gpu/drm/drm_draw_internal.h |  2 +
 drivers/gpu/drm/drm_panic.c         |  2 +-
 4 files changed, 65 insertions(+), 25 deletions(-)
---
base-commit: 7a405dbb0f036f8d1713ab9e7df0cd3137987b07
change-id: 20251003-drm_draw_conv_check-9cc3050ebd57

Best regards,
-- 
Francesco Valla <francesco@valla.it>


