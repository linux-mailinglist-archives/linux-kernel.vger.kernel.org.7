Return-Path: <linux-kernel+bounces-841201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0BD1BB67A4
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 12:46:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D8D53BB794
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 10:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E38222E8DE3;
	Fri,  3 Oct 2025 10:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b="tVu5dxOP";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=valla.it header.i=@valla.it header.b="QFSC0CtG"
Received: from delivery.antispam.mailspamprotection.com (delivery.antispam.mailspamprotection.com [185.56.87.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 706BDC148
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 10:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.56.87.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759488375; cv=pass; b=Rv+WUcn87ktilBlSBTlMMtlVsQJTjA8QvVO2aK8cf3fDPVJtE8tL/Iwg1YmThvh1YkOIGx4z8bg/QAql4qWKkLNeNm0THXG0ouPVeWeL5SI1n+TAvPriR8i2yyvujsTlrDSxOXO8TH8tJe5G0rg6z36wCape3hL5+GdD/yXrtPw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759488375; c=relaxed/simple;
	bh=oxztwgSohn0Urt4wlKgp0INnLZf70XV4Jyinfy0e++o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=m8+DMT7hqlqdtv3ucNTRzxE+GISPRKmZ4Rsr9U4pkRSwEil4zcqUxqHSmn+D+y8NuJla/0QJU9Ylxf5DOYpFF5WF+tgmvurC+OYiXr25IIn377Zgo4I0KEINsAq3yWJYRdAB9L0617a05lj7JM4PEbeWizhASHZYIUWQ9Y1YSyE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it; spf=pass smtp.mailfrom=valla.it; dkim=pass (1024-bit key) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b=tVu5dxOP; dkim=pass (1024-bit key) header.d=valla.it header.i=@valla.it header.b=QFSC0CtG; arc=pass smtp.client-ip=185.56.87.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valla.it
ARC-Seal: i=1; cv=none; a=rsa-sha256; d=outgoing.instance-europe-west4-68s4.prod.antispam.mailspamprotection.com; s=arckey; t=1759488373;
	 b=HQAjfftVtdRtpTub0FcRO40r1KOqGGKXOMFwcJECpy6McJajrU2UsyF+zxu/pbZ6X70DTTIchQ
	  sT2jJDiU/WMduACGogImwZrzrhZ8BRa7rEcSGVYi68aczD4djPlhpDLwCm/nDrQqk2Pd2AEQ8q
	  StPgbO2ZQNMkIjk+bbH0Jlk5qI8D7hL1tPHfYW0/GW+VIwNwb2WLMLVQOe9hjnHshFYeOOdkk9
	  hubTdTPtsNMhiQn9oc6PP1Udgl6S2Tv4kJfJXOdJbMb08G9ddMFIvJ4vZeY4nXw99Qkguun2qu
	  3QQbA8qsj73mA02JmvtEjsQxVWUFEJpGzS+jFaBVBxu7tg==;
ARC-Authentication-Results: i=1; outgoing.instance-europe-west4-68s4.prod.antispam.mailspamprotection.com; smtp.remote-ip=35.214.173.214;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed; d=outgoing.instance-europe-west4-68s4.prod.antispam.mailspamprotection.com; s=arckey; t=1759488373;
	bh=oxztwgSohn0Urt4wlKgp0INnLZf70XV4Jyinfy0e++o=;
	h=Cc:To:Message-ID:Content-Transfer-Encoding:Content-Type:MIME-Version:
	  Subject:Date:From:DKIM-Signature:DKIM-Signature;
	b=kBMm8Y8UeFiCv/sJn/h9IV4ogSZQbdDOrPGJvVNBGYOZSXuTZdS+dCcwysRetbY4H33AeIQwVP
	  xkxvvB8x4H4uitJxCUCkfecB/4DpiDAxCuCQhkVKVnH1COwaW9law8Jybg1Imt4kywKb6wYzV6
	  WbwMUyN6t2fqD5RrnohWTAzZoSfv7k7+TuwYSyAZ3JcdFAI4q3uoJ09b4KlC4dfEylsGsgDcNY
	  BkfKvRciSbUvouKaxL08LktvSGwQvkSSK4oQF8ultwX9h3kXlPQM0QZ+HrUL3+Uba4WpFd7a2M
	  jPwl4l914G7XlX8x6hyLy3KwbsbtrUYmYEZ3STcyCvyUHQ==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=antispam.mailspamprotection.com; s=default; h=CFBL-Feedback-ID:CFBL-Address
	:Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject
	:Date:From:Reply-To:List-Unsubscribe;
	bh=hXsRLCbKNIXlJVJ6hEdkFul81XBtMTzLFWhNEYewW3s=; b=tVu5dxOPctYKTUDsk8+hBpwKwM
	QUSO6jPCi/hnIW8aYn6G0P76uOcgF6sFS8QH1+fJCsHoqe+vnhHXrmSdp6mWVpY1vNIviLsL8kOob
	89+rfbbZKEohUD95kUZjq6bcABYNLkRifCTfGWZpBv4GX1S+sCq0TGLmx59NZVxdF+Bs=;
Received: from 214.173.214.35.bc.googleusercontent.com ([35.214.173.214] helo=esm19.siteground.biz)
	by instance-europe-west4-68s4.prod.antispam.mailspamprotection.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.1)
	(envelope-from <francesco@valla.it>)
	id 1v4d6y-00000006lae-1dgG
	for linux-kernel@vger.kernel.org;
	Fri, 03 Oct 2025 10:34:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=valla.it;
	s=default; h=Cc:To:Subject:Date:From:list-help:list-unsubscribe:
	list-subscribe:list-post:list-owner:list-archive;
	bh=hXsRLCbKNIXlJVJ6hEdkFul81XBtMTzLFWhNEYewW3s=; b=QFSC0CtG6aJxxkXHpCPLA1lI0z
	zWCImVm3kWJI7cN7S1Wyot7YK2zjgcpKSXNvENIGQMj4phbyTzjG+S6U/8ywRcOvIoTZQiMZTnp9U
	cqo4Dz8+NYz0a3iUKM24hfEQ8PSY9YRGogzJoPSQe90VK8Tq/EBFt16j60WDpsWoczBE=;
Received: from [87.16.13.60] (port=61630 helo=fedora-2.fritz.box)
	by esm19.siteground.biz with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.1)
	(envelope-from <francesco@valla.it>)
	id 1v4d6j-00000000PzU-2xlq;
	Fri, 03 Oct 2025 10:33:49 +0000
From: Francesco Valla <francesco@valla.it>
Date: Fri, 03 Oct 2025 12:33:03 +0200
Subject: [PATCH] drm/draw: fix color truncation in drm_draw_fill24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251003-drm_draw_fill24_fix-v1-1-8fb7c1c2a893@valla.it>
X-B4-Tracking: v=1; b=H4sIAF6m32gC/x2MSwqAMAwFryJZW6ipLvQqIlJM1IA/UlBBvLvB1
 TAD7z2QWIUTNNkDyqck2TeTIs9gmOM2sRMyB/RYFd4HR7r2pPHqR1kWLA2341ghBYx1CAS2PJQ
 t/69t974fXhyDJ2UAAAA=
X-Change-ID: 20251003-drm_draw_fill24_fix-ea52d32a933d
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
X-SGantispam-id: fc134f1d95ecc020baa07fbfacc6ad51
AntiSpam-DLS: false
AntiSpam-DLSP: 
AntiSpam-DLSRS: 
AntiSpam-TS: 1.0
CFBL-Address: feedback@antispam.mailspamprotection.com; report=arf
CFBL-Feedback-ID: 1v4d6y-00000006lae-1dgG-feedback@antispam.mailspamprotection.com
Authentication-Results: outgoing.instance-europe-west4-68s4.prod.antispam.mailspamprotection.com;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none

The color parameter passed to drm_draw_fill24() was truncated to 16
bits, leading to an incorrect color drawn to the target iosys_map.
Fix this behavior, widening the parameter to 32 bits.

Fixes: 31fa2c1ca0b2 ("drm/panic: Move drawing functions to drm_draw")

Signed-off-by: Francesco Valla <francesco@valla.it>
---
 drivers/gpu/drm/drm_draw.c          | 2 +-
 drivers/gpu/drm/drm_draw_internal.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_draw.c b/drivers/gpu/drm/drm_draw.c
index 9dc0408fbbeadbe8282a2d6b210e0bfb0672967f..5b956229c82fb6e232e3342705a226c8e14c8568 100644
--- a/drivers/gpu/drm/drm_draw.c
+++ b/drivers/gpu/drm/drm_draw.c
@@ -127,7 +127,7 @@ EXPORT_SYMBOL(drm_draw_fill16);
 
 void drm_draw_fill24(struct iosys_map *dmap, unsigned int dpitch,
 		     unsigned int height, unsigned int width,
-		     u16 color)
+		     u32 color)
 {
 	unsigned int y, x;
 
diff --git a/drivers/gpu/drm/drm_draw_internal.h b/drivers/gpu/drm/drm_draw_internal.h
index f121ee7339dc11537f677c833f0ee94fe0e799cd..20cb404e23ea6263b535ea2b81b25f84c37be8a2 100644
--- a/drivers/gpu/drm/drm_draw_internal.h
+++ b/drivers/gpu/drm/drm_draw_internal.h
@@ -47,7 +47,7 @@ void drm_draw_fill16(struct iosys_map *dmap, unsigned int dpitch,
 
 void drm_draw_fill24(struct iosys_map *dmap, unsigned int dpitch,
 		     unsigned int height, unsigned int width,
-		     u16 color);
+		     u32 color);
 
 void drm_draw_fill32(struct iosys_map *dmap, unsigned int dpitch,
 		     unsigned int height, unsigned int width,

---
base-commit: e406d57be7bd2a4e73ea512c1ae36a40a44e499e
change-id: 20251003-drm_draw_fill24_fix-ea52d32a933d

Best regards,
-- 
Francesco Valla <francesco@valla.it>


