Return-Path: <linux-kernel+bounces-853300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BD552BDB287
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 22:08:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 573A24E9C66
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 20:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB67F30597C;
	Tue, 14 Oct 2025 20:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b="P8uu3ojH";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=valla.it header.i=@valla.it header.b="mtfEx+AW"
Received: from delivery.antispam.mailspamprotection.com (delivery.antispam.mailspamprotection.com [185.56.87.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD4CC2D0620
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 20:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.56.87.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760472519; cv=pass; b=MuPdZOrnxagaHPPPpZrrt8PjLMBIFH8s2e4qkCj9DHar7P6HoMVmllC4AAI3LFyFAFDXu3GufcZ1mYINYtYZsVi8QCar+kVvjwY3OY5icD7yceMkcRXRvx7VHpHkEekTigfqLReV1v4drkpjRroqTlA9R+dNWvT7yRBIG/QJgys=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760472519; c=relaxed/simple;
	bh=+5BTWhpo8xFj/7SCEKOUmnd3xUn/bC/gIZT0lglYOj4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oFpWmsujsyOwoYpy0lX1YGM0wMt6Z2ElOwI0wUAbIaBZ848/h2mg/NID8I6bfqbCBI/RH51zlihOk8Si3g9EKhY/KEWRHRceVUGEPyROkpwt/O3qKChFe9TsUZ6LAZyjsVlvb+dJuXj/0RClXVRUm/b14D6IikBr5wVS9GpwgeI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it; spf=pass smtp.mailfrom=valla.it; dkim=pass (1024-bit key) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b=P8uu3ojH; dkim=pass (1024-bit key) header.d=valla.it header.i=@valla.it header.b=mtfEx+AW; arc=pass smtp.client-ip=185.56.87.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valla.it
ARC-Seal: i=1; cv=none; a=rsa-sha256; d=outgoing.instance-europe-west4-rkph.prod.antispam.mailspamprotection.com; s=arckey; t=1760472517;
	 b=fcf+61wc0NXEsx7FUqX2SljLlOZ3YnkV00nEGJDd/tXiuTA6n9+YRwwcksHOAolfYCJm2xc3L/
	  Xu5CjeAIY9iTZQk23dB9fbHhCR0MF1tHL2uhjz4WJIik0fTHmiBZ9vJYaJHV8CuQQOAYNTW/C7
	  9cxmO5KCG2E9bpzXK3Px22gfEDU2KyBNu+UxlQdeG3uVmcTYfWRrNZADYzgh3msD5Jyz2Y/Vuw
	  IE1AU7fNKG2u6d992tUefhJp3aOFwu97TaleOhFUU1UN5Td6qv9ZXAtZI5fCgWhCwwEc3glOyF
	  LKAXl/a61vdWp6LYtT3zVvwdB+fUnpC90oIuUcC03VH9Gg==;
ARC-Authentication-Results: i=1; outgoing.instance-europe-west4-rkph.prod.antispam.mailspamprotection.com; smtp.remote-ip=35.214.173.214;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed; d=outgoing.instance-europe-west4-rkph.prod.antispam.mailspamprotection.com; s=arckey; t=1760472517;
	bh=+5BTWhpo8xFj/7SCEKOUmnd3xUn/bC/gIZT0lglYOj4=;
	h=Cc:To:In-Reply-To:References:Message-ID:Content-Transfer-Encoding:
	  Content-Type:MIME-Version:Subject:Date:From:DKIM-Signature:DKIM-Signature;
	b=XPt2HnWQyglcBTxjUvHaknAFbFrO8KwpDtkOXyH+Xesd69l5oFlSr4Dz1aAKCz/lcxkMnx2364
	  zF4XLbT6kE3ki3vhgZsmIea4ElTUWLPfukNmYyo1O5c5RY55XlyGBpuauyEtgyWh4qFba3bndr
	  xQ89nseWbANEopKlRVXrxWgnoNz9wXqgNsFE7YXWDSGe8o6d5X8ZXbqPJmYLOPQs3sW4cQ67NA
	  1L+nUem+Zr+eBo8kMKt1C24HLtGchfk8aGkilWl4nZyXwbodDd0dWyql6Ad2bKRefNLWn7sSB8
	  ZtwRc0iUu39PwdAxKhe8G5IHtGgupc66rrKK0aPZkFqwrw==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=antispam.mailspamprotection.com; s=default; h=CFBL-Feedback-ID:CFBL-Address
	:Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject
	:Date:From:Reply-To:List-Unsubscribe;
	bh=HBceqnriX2pNnf/J/de0sHN1Yjm6AqD5B1qKy0hJKpA=; b=P8uu3ojHvzqNpkj/i9aWbOfLfW
	pYEgWEl2vduAE4nD78UgTyQmLzmpcLoFmOs/WgVe7jm9l7FPXbvOSUhpwfC4dzxsW+pgxfMuw6cAk
	nBpenhculZoHdy+xxnoeY/wLuOUz5U1M2EVxNf2eNwrjq3msdEwdYJc7rzYtY5jx0zqg=;
Received: from 214.173.214.35.bc.googleusercontent.com ([35.214.173.214] helo=esm19.siteground.biz)
	by instance-europe-west4-rkph.prod.antispam.mailspamprotection.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.1)
	(envelope-from <francesco@valla.it>)
	id 1v8lJx-00000005Skw-1rsh
	for linux-kernel@vger.kernel.org;
	Tue, 14 Oct 2025 20:08:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=valla.it;
	s=default; h=Cc:To:Subject:Date:From:list-help:list-unsubscribe:
	list-subscribe:list-post:list-owner:list-archive;
	bh=HBceqnriX2pNnf/J/de0sHN1Yjm6AqD5B1qKy0hJKpA=; b=mtfEx+AWlTgtZYJAewjC2/MU9a
	325ma9wmCvTP4adpo3kaJVWrF2cviKekHd6v0eYy4nB2WBjS+FrTcWKHXiymchFCyGcplWwGObcPe
	/2g0/sH0DK7ZLoAiiM23a0jijSDJ9dZgpDocaBEIfOuF915QJxfIlT8y6lvVyrJ8teJ4=;
Received: from [87.16.13.60] (port=64127 helo=fedora.fritz.box)
	by esm19.siteground.biz with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.1)
	(envelope-from <francesco@valla.it>)
	id 1v8lJq-00000000E00-2SM1;
	Tue, 14 Oct 2025 20:08:26 +0000
From: Francesco Valla <francesco@valla.it>
Date: Tue, 14 Oct 2025 22:08:12 +0200
Subject: [PATCH v2 1/3] drm/draw: add drm_draw_can_convert_from_xrgb8888
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251014-drm_draw_conv_check-v2-1-05bef3eb06fb@valla.it>
References: <20251014-drm_draw_conv_check-v2-0-05bef3eb06fb@valla.it>
In-Reply-To: <20251014-drm_draw_conv_check-v2-0-05bef3eb06fb@valla.it>
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
X-SGantispam-id: fea8dbdeaa4e9fc8afce9fff3a582ff6
AntiSpam-DLS: false
AntiSpam-DLSP: 
AntiSpam-DLSRS: 
AntiSpam-TS: 1.0
CFBL-Address: feedback@antispam.mailspamprotection.com; report=arf
CFBL-Feedback-ID: 1v8lJx-00000005Skw-1rsh-feedback@antispam.mailspamprotection.com
Authentication-Results: outgoing.instance-europe-west4-rkph.prod.antispam.mailspamprotection.com;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none

Add drm_draw_can_convert_from_xrgb8888() function that can be used to
determine if a XRGB8888 color can be converted to the specified format.

Signed-off-by: Francesco Valla <francesco@valla.it>
---
 drivers/gpu/drm/drm_draw.c          | 29 +++++++++++++++++++++++++++++
 drivers/gpu/drm/drm_draw_internal.h |  2 ++
 2 files changed, 31 insertions(+)

diff --git a/drivers/gpu/drm/drm_draw.c b/drivers/gpu/drm/drm_draw.c
index 9dc0408fbbeadbe8282a2d6b210e0bfb0672967f..ccdd6b16e73fc01d58f45759cf3824be7aac155b 100644
--- a/drivers/gpu/drm/drm_draw.c
+++ b/drivers/gpu/drm/drm_draw.c
@@ -15,6 +15,35 @@
 #include "drm_draw_internal.h"
 #include "drm_format_internal.h"
 
+/**
+ * drm_draw_can_convert_from_xrgb8888 - check if xrgb8888 can be converted to the desired format
+ * @format: format
+ *
+ * Returns:
+ * True if XRGB8888 can be converted to the specified format, false otherwise.
+ */
+bool drm_draw_can_convert_from_xrgb8888(u32 format)
+{
+	switch (format) {
+	case DRM_FORMAT_RGB565:
+	case DRM_FORMAT_RGBA5551:
+	case DRM_FORMAT_XRGB1555:
+	case DRM_FORMAT_ARGB1555:
+	case DRM_FORMAT_RGB888:
+	case DRM_FORMAT_XRGB8888:
+	case DRM_FORMAT_ARGB8888:
+	case DRM_FORMAT_XBGR8888:
+	case DRM_FORMAT_ABGR8888:
+	case DRM_FORMAT_XRGB2101010:
+	case DRM_FORMAT_ARGB2101010:
+	case DRM_FORMAT_ABGR2101010:
+		return true;
+	default:
+		return false;
+	}
+}
+EXPORT_SYMBOL(drm_draw_can_convert_from_xrgb8888);
+
 /**
  * drm_draw_color_from_xrgb8888 - convert one pixel from xrgb8888 to the desired format
  * @color: input color, in xrgb8888 format
diff --git a/drivers/gpu/drm/drm_draw_internal.h b/drivers/gpu/drm/drm_draw_internal.h
index f121ee7339dc11537f677c833f0ee94fe0e799cd..2ab4cb341df94fc4173dd6f5e7a512bdcfa5e55c 100644
--- a/drivers/gpu/drm/drm_draw_internal.h
+++ b/drivers/gpu/drm/drm_draw_internal.h
@@ -24,6 +24,8 @@ static inline const u8 *drm_draw_get_char_bitmap(const struct font_desc *font,
 	return font->data + (c * font->height) * font_pitch;
 }
 
+bool drm_draw_can_convert_from_xrgb8888(u32 format);
+
 u32 drm_draw_color_from_xrgb8888(u32 color, u32 format);
 
 void drm_draw_blit16(struct iosys_map *dmap, unsigned int dpitch,

-- 
2.51.0


