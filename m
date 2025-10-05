Return-Path: <linux-kernel+bounces-842453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id F35A8BBCC21
	for <lists+linux-kernel@lfdr.de>; Sun, 05 Oct 2025 22:54:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DF08B4E4CAE
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Oct 2025 20:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B861191F98;
	Sun,  5 Oct 2025 20:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b="ghoIGgWQ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=valla.it header.i=@valla.it header.b="gunbTzzo"
Received: from delivery.antispam.mailspamprotection.com (delivery.antispam.mailspamprotection.com [185.56.87.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59ED1C9DE5
	for <linux-kernel@vger.kernel.org>; Sun,  5 Oct 2025 20:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.56.87.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759697634; cv=pass; b=r7LsfiDTF9ecq5WogJrTjs7MSxZRGWebrBcmMjallcVy4C6UAdaVZQF6vcXWNfakVBrZlbvaHgeA1bwR/zI9nVpJ21nvsn19k07/KsG5RopqDDlW/TDT4uSi58CT5QHDr5KBOADwYayBTVC0CAh1yzhaCKv9p/xZuOn1yqWwxzg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759697634; c=relaxed/simple;
	bh=DMujsWVb0XBsms7mI+BZ4jG8OwIgPWKdo+JBJu5h68M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KvbuT6OzxFMHgpgA7v2AA0bdxMGCIO79hW8ofbyBMYcHvfv0cV4ABml+VJzkMhvdL2j0GZ7pFQ4YFJFjp3oFPRbdxmoLrFVFWSew898GRt342Amq6Dxs/p/rXTS+0sJKaFMO3hWAiE7Hao+xf4X1nJs2kLNKA3tKw7dOME8+eJ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it; spf=pass smtp.mailfrom=valla.it; dkim=pass (1024-bit key) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b=ghoIGgWQ; dkim=pass (1024-bit key) header.d=valla.it header.i=@valla.it header.b=gunbTzzo; arc=pass smtp.client-ip=185.56.87.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valla.it
ARC-Seal: i=1; cv=none; a=rsa-sha256; d=outgoing.instance-europe-west4-nf36.prod.antispam.mailspamprotection.com; s=arckey; t=1759697632;
	 b=GkhTphA1bD7w+4GEGiPxiAr4n+M+rq/NGpoL+cXQ8reRwWrYvTaeZGV/jZzfif0PthigYLvy/0
	  Vr0bNZCNrdlMO4sN+/9CBXlAdnoY7Qyv4RGyRLufEUVEocIXNXVWmGahIUYvKQNY5mejCDlgaT
	  rj2pZVhGuybgwgpbAfbRkpuK9DF3savo+dhmDafmYG+Xtru/7YmSBBSy+RS8p3zUc2UrjYNVNk
	  K9tgxEHwBLBlBmTmkm1G3qn8/AJAbt4dcpz8TPx3PcjvgFdcHeO9ZYwGY5a+C5/6uZV/P1VVBO
	  Cgh1sR8hpfETU44ytU+0i16e3mBul3NJwm8tTa6ODP/Apw==;
ARC-Authentication-Results: i=1; outgoing.instance-europe-west4-nf36.prod.antispam.mailspamprotection.com; smtp.remote-ip=35.214.173.214;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed; d=outgoing.instance-europe-west4-nf36.prod.antispam.mailspamprotection.com; s=arckey; t=1759697632;
	bh=DMujsWVb0XBsms7mI+BZ4jG8OwIgPWKdo+JBJu5h68M=;
	h=Cc:To:In-Reply-To:References:Message-ID:Content-Transfer-Encoding:
	  Content-Type:MIME-Version:Subject:Date:From:DKIM-Signature:DKIM-Signature;
	b=Gfm+Ooh1E3kbD0Ny7i5XPVHCTNlDOMvA56S6miCYYlofBCWXZpy48HF9y9PeXacfR8+kX60Xxi
	  tfWAuCwOMQqnOZQ5djNNJ8gcCPN0+X7Nu6k0urlEL7yxRcjswzcoacfBVPrQgX+LtNxCZCU6S9
	  WKFXBLhUawHyCxui9ojKXz2N2ZGPAPwwlQadCI3kNdYceS4uETcl9jDAcExfRhx/X2XVV/pt4C
	  Rz5BmZRGVC8RSsJIi8Qf5mirR+X/4TDXOX2WYuKPXQ/GXX7QmtfvL2liKDnRQML50N2KpMXsgA
	  I5LOucFtX8e4kE/ABxKngeh2uZmsGiuM5aJyoXoMtLc9dw==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=antispam.mailspamprotection.com; s=default; h=CFBL-Feedback-ID:CFBL-Address
	:Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject
	:Date:From:Reply-To:List-Unsubscribe;
	bh=ab/UoitdFlXPH53JKWWYVjj8RBffXVQrAXU9vps/ES0=; b=ghoIGgWQv83QBCGyxEzOzpBnPY
	yCbvhtAwLaviYISxuSwqIBwab2Ir4YIzzC867xzVrWX7eDoWcaYkaM6j8sISFNYHrn041GfPKcV/g
	hQVupPLRAzr07V3FfbZ7HKL/QvfiXTzSY8M0pMmJI+sDV9ISupiuwFTwWNgo3Et1uM+w=;
Received: from 214.173.214.35.bc.googleusercontent.com ([35.214.173.214] helo=esm19.siteground.biz)
	by instance-europe-west4-nf36.prod.antispam.mailspamprotection.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.1)
	(envelope-from <francesco@valla.it>)
	id 1v5VF1-00000008Ii7-2rki
	for linux-kernel@vger.kernel.org;
	Sun, 05 Oct 2025 20:22:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=valla.it;
	s=default; h=Cc:To:Subject:Date:From:list-help:list-unsubscribe:
	list-subscribe:list-post:list-owner:list-archive;
	bh=ab/UoitdFlXPH53JKWWYVjj8RBffXVQrAXU9vps/ES0=; b=gunbTzzondc57kzWj29s1Tz4aA
	5664+ptkekCB0xBm4HZX1kmnb6QTRDH8TXyQM+c11XmLKwHRuThhC+hJZRXkQnEGvgTMAHAioBRNb
	Sw0f3GZkfYkcXwLP1ljHKzd6qpo0u4Q1Ypzi0ue7Sgtzrc/G3tTH2aewTbV/uWy7PfFA=;
Received: from [87.16.13.60] (port=64461 helo=fedora.fritz.box)
	by esm19.siteground.biz with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.1)
	(envelope-from <francesco@valla.it>)
	id 1v5VEu-000000001im-416r;
	Sun, 05 Oct 2025 20:21:53 +0000
From: Francesco Valla <francesco@valla.it>
Date: Sun, 05 Oct 2025 22:21:34 +0200
Subject: [PATCH 1/3] drm/draw: add drm_draw_can_convert_from_xrgb8888
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251005-drm_draw_conv_check-v1-1-9c814d9362f6@valla.it>
References: <20251005-drm_draw_conv_check-v1-0-9c814d9362f6@valla.it>
In-Reply-To: <20251005-drm_draw_conv_check-v1-0-9c814d9362f6@valla.it>
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
X-SGantispam-id: 848ddd08561cc6884978eb8aaef64364
AntiSpam-DLS: false
AntiSpam-DLSP: 
AntiSpam-DLSRS: 
AntiSpam-TS: 1.0
CFBL-Address: feedback@antispam.mailspamprotection.com; report=arf
CFBL-Feedback-ID: 1v5VF1-00000008Ii7-2rki-feedback@antispam.mailspamprotection.com
Authentication-Results: outgoing.instance-europe-west4-nf36.prod.antispam.mailspamprotection.com;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none

Add drm_draw_can_convert_from_xrgb8888() function that can be used to
determine if a XRGB8888 color can be converted to the specified format.

Signed-off-by: Francesco Valla <francesco@valla.it>
---
 drivers/gpu/drm/drm_draw.c          | 84 +++++++++++++++++++++++++++----------
 drivers/gpu/drm/drm_draw_internal.h |  2 +
 2 files changed, 63 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/drm_draw.c b/drivers/gpu/drm/drm_draw.c
index 9dc0408fbbeadbe8282a2d6b210e0bfb0672967f..2641026a103d3b28cab9f5d378604b0604520fe4 100644
--- a/drivers/gpu/drm/drm_draw.c
+++ b/drivers/gpu/drm/drm_draw.c
@@ -15,45 +15,83 @@
 #include "drm_draw_internal.h"
 #include "drm_format_internal.h"
 
-/**
- * drm_draw_color_from_xrgb8888 - convert one pixel from xrgb8888 to the desired format
- * @color: input color, in xrgb8888 format
- * @format: output format
- *
- * Returns:
- * Color in the format specified, casted to u32.
- * Or 0 if the format is not supported.
- */
-u32 drm_draw_color_from_xrgb8888(u32 color, u32 format)
+static int __drm_draw_color_from_xrgb8888(u32 color, u32 format, u32 *out_color)
 {
 	switch (format) {
 	case DRM_FORMAT_RGB565:
-		return drm_pixel_xrgb8888_to_rgb565(color);
+		*out_color = drm_pixel_xrgb8888_to_rgb565(color);
+		break;
 	case DRM_FORMAT_RGBA5551:
-		return drm_pixel_xrgb8888_to_rgba5551(color);
+		*out_color = drm_pixel_xrgb8888_to_rgba5551(color);
+		break;
 	case DRM_FORMAT_XRGB1555:
-		return drm_pixel_xrgb8888_to_xrgb1555(color);
+		*out_color = drm_pixel_xrgb8888_to_xrgb1555(color);
+		break;
 	case DRM_FORMAT_ARGB1555:
-		return drm_pixel_xrgb8888_to_argb1555(color);
+		*out_color = drm_pixel_xrgb8888_to_argb1555(color);
+		break;
 	case DRM_FORMAT_RGB888:
+		fallthrough;
 	case DRM_FORMAT_XRGB8888:
-		return color;
+		*out_color = color;
+		break;
 	case DRM_FORMAT_ARGB8888:
-		return drm_pixel_xrgb8888_to_argb8888(color);
+		*out_color = drm_pixel_xrgb8888_to_argb8888(color);
+		break;
 	case DRM_FORMAT_XBGR8888:
-		return drm_pixel_xrgb8888_to_xbgr8888(color);
+		*out_color = drm_pixel_xrgb8888_to_xbgr8888(color);
+		break;
 	case DRM_FORMAT_ABGR8888:
-		return drm_pixel_xrgb8888_to_abgr8888(color);
+		*out_color = drm_pixel_xrgb8888_to_abgr8888(color);
+		break;
 	case DRM_FORMAT_XRGB2101010:
-		return drm_pixel_xrgb8888_to_xrgb2101010(color);
+		*out_color = drm_pixel_xrgb8888_to_xrgb2101010(color);
+		break;
 	case DRM_FORMAT_ARGB2101010:
-		return drm_pixel_xrgb8888_to_argb2101010(color);
+		*out_color = drm_pixel_xrgb8888_to_argb2101010(color);
+		break;
 	case DRM_FORMAT_ABGR2101010:
-		return drm_pixel_xrgb8888_to_abgr2101010(color);
+		*out_color = drm_pixel_xrgb8888_to_abgr2101010(color);
+		break;
 	default:
-		WARN_ONCE(1, "Can't convert to %p4cc\n", &format);
-		return 0;
+		return -1;
 	}
+
+	return 0;
+}
+
+/**
+ * drm_draw_can_convert_from_xrgb8888 - check if xrgb8888 can be converted to the desired format
+ * @format: format
+ *
+ * Returns:
+ * True if XRGB8888 can be converted to the specified format, false otherwise.
+ */
+bool drm_draw_can_convert_from_xrgb8888(u32 format)
+{
+	u32 out_color;
+
+	return __drm_draw_color_from_xrgb8888(0, format, &out_color) == 0;
+}
+EXPORT_SYMBOL(drm_draw_can_convert_from_xrgb8888);
+
+/**
+ * drm_draw_color_from_xrgb8888 - convert one pixel from xrgb8888 to the desired format
+ * @color: input color, in xrgb8888 format
+ * @format: output format
+ *
+ * Returns:
+ * Color in the format specified, casted to u32.
+ * Or 0 if the format is not supported.
+ */
+u32 drm_draw_color_from_xrgb8888(u32 color, u32 format)
+{
+	u32 out_color = 0;
+
+	if (__drm_draw_color_from_xrgb8888(color, format, &out_color))
+		WARN_ONCE(1, "Can't convert to %p4cc\n", &format);
+
+	return out_color;
 }
 EXPORT_SYMBOL(drm_draw_color_from_xrgb8888);
 
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


