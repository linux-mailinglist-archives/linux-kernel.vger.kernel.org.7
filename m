Return-Path: <linux-kernel+bounces-868702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4533C05E57
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 13:23:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 994B91C2510F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 11:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 677823596E0;
	Fri, 24 Oct 2025 10:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lb+amBcs"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE0D358D29
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 10:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761303459; cv=none; b=XNnd6qswzSjIQ7FJMISOkx2x1q22b7MJ827BGIE/exIOGA0+KuQf41Mcv2GSdePBVYjMl+52rg8xExr+tzzjAkOXvtvZgF2od1QtNn3zklNkNVN6PSpG2pR79GXCsMVRzI3mKbGTVxbzekANTHjDZnxOKk61keIjOgZKMfIOmJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761303459; c=relaxed/simple;
	bh=oj5JSSIwffzeqzrjLvw57GX1wzHco1M6GQyX3QdaS3o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=M4cgHXc20bQY65Y1e74lsjEPLjv5cT0U6lkquKXCIJGTkyhI/BVFgyQbPlb3q4zb3lpn3ocn0Xxw6FVBB2sjWnZCxwNruxHfvE47mzIwgBPoAMbSEzpFhkhiaIZqo07NAlkcVNhOqNefF6VNGPC5NYjco7WGMgPkiC/BdsRnrS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lb+amBcs; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-58d29830058so1977858e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 03:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761303455; x=1761908255; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mG4iS2woxPf+3BthpgnKFGsPtU8cg+2wLUJdaVgtpEs=;
        b=lb+amBcsfXcxY8pmmlyiPL8mLtN7ehcr8iwuw+hsmrGL/qok7/ccO684mITJhSCwfh
         l5OiwcR/1V9gqE9JtWjym2Hvew/n5qJbT0odGGNFlxyWkc2ZrBfW6jw6ACGtZxCwhViG
         f0qpH/BD4fGR8S3ZTLEhuwwG6/dBeDu3tjBtluF0q5vfJyemv6+zSBLLrkk93+oVJSkl
         TPj6U7hAK+nA73sQ3c2bkKPDNh6KIGIeLVF2mbqVi2QDAha9meHy4ER0AQiko6dFPDtW
         ShAeg5ocWNKwPzSoDR4TVW4lgZ1eF6IE3wenU2iCbCwO/t7I/S1JzwlofioAudJw86Q5
         peYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761303455; x=1761908255;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mG4iS2woxPf+3BthpgnKFGsPtU8cg+2wLUJdaVgtpEs=;
        b=pQtI9q7BMapQPhW4cYp+Ktwq0+Y3L7sqTN2wQuxvwDRbe29khJNM+lqMIU77s4ZfcY
         SfV44yLvZUJ2jEDVGlsvNl6Fv+QzNLJQmu30LmN07jK5gY8rzwcJWErrsTJSKkn0C1se
         gtl44o4ATHNS4W15fcIyMcHSM06JW8jK9RhZJDA8iY9otmaeu6kY+xC3gIpRvJwexdX1
         +PaCHE+gG/KD4zK/n1foayrq0lbYPKZbtp2ii96Re1IbAWAYvXF4aLrt/2IJD0yqzSBf
         aijsUzIeGX3CtggazQ2rSWyJx9r3jqYiFvz39pOr+UXLX+5jZCW1AcHBcqMpUi2LkZdn
         rCbQ==
X-Forwarded-Encrypted: i=1; AJvYcCV2Gp6jSnhl2QpTGRyNFSOq0crZSp9ht84uO/h1T9KmisJiSw5wcJ5opbSgL8ZXAaT/RF1Y6wu6xgjxWlY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWF2t/m0zagfDo1c0caJ2a45arqWfljoUERObFfcIPRm3hYfAX
	dZnhRwsfSI12JC34hVHNk35wuvsoZ17j5TMjj766xHMa13rJf4SViTzo
X-Gm-Gg: ASbGncvPX0m6h07yAWIJwdL7m2DYKW9SeGsSVlxnnuzXyykZ0iitsPQSr1lsuLqZF2z
	vqtlJHxurteX5MvfQyar+PsDy4YqqIHoIuLETb6tNm8Vrl/Aw6xvK7vJvb4W1SSSLRHxjrdPfsp
	TojxopNus68gWH6FsVO38Jb2XHb7P35enfPpRpUY3z1XBA5HXTh/DEntSlOc+0894xNfl2HuezM
	YSqqouTVPORdo2Q08mPSMi/h61tgHWozWQHMetbcw5AHwd1FnRG0dBM/WiTBV4+T/wQPgB/tkM+
	pNTIISwRhoZpIZOYeUGLKerGfcxn/aNb1UsNdiZ8iriEilcxiunHgHxZIagabDSVK58nOo75Xyr
	9nuMU/YViiXiw8uhbjGJHTl7GnzWniQSGtRG+MpUFzNHe62evFnkoxD2NeeSdmBOr/uYVkXMXTX
	gatfWgANHEDN89Tjv8MGJkZW5/DNl94XcmySNdRRxaHns7
X-Google-Smtp-Source: AGHT+IFn/VYhset1Mavk5aaHD6oOqpyWmfVWIE+Q9SiIpmiHtPdRpiClOYLBhrBpbW1/acQWx81nsg==
X-Received: by 2002:a05:651c:1989:b0:372:628b:5cb4 with SMTP id 38308e7fff4ca-37797a8d5dbmr84012631fa.45.1761303455238;
        Fri, 24 Oct 2025 03:57:35 -0700 (PDT)
Received: from [192.168.1.168] (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-378d67db8fesm10375671fa.38.2025.10.24.03.57.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 03:57:34 -0700 (PDT)
From: Marcus Folkesson <marcus.folkesson@gmail.com>
Date: Fri, 24 Oct 2025 12:56:54 +0200
Subject: [PATCH 3/6] drm/sitronix/st7571-i2c: move common structures to
 st7571.h
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251024-st7571-split-v1-3-d3092b98130f@gmail.com>
References: <20251024-st7571-split-v1-0-d3092b98130f@gmail.com>
In-Reply-To: <20251024-st7571-split-v1-0-d3092b98130f@gmail.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Marcus Folkesson <marcus.folkesson@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7890;
 i=marcus.folkesson@gmail.com; h=from:subject:message-id;
 bh=oj5JSSIwffzeqzrjLvw57GX1wzHco1M6GQyX3QdaS3o=;
 b=owEBbQKS/ZANAwAKAYiATm9ZXVIyAcsmYgBo+1uGURp4KPR63s5xUVGroPgKmnyWXRI8G+tCN
 ZhCcl/XKC+JAjMEAAEKAB0WIQQFUaLotmy1TWTBLGWIgE5vWV1SMgUCaPtbhgAKCRCIgE5vWV1S
 Mt0cD/9ITP8vmZZ1IqUZsE68ywbqBSy3CJz3JG1YVBk68nNziH0SlZZJB15OJK9zjOk5euJtoVd
 SL8lF7hxg5ZSzeIrcSkBK+m9Bjcit5pArVHfGHPIeJ2guNMjs8jrN28xUwybE68DyjoyAC0il1x
 ckZ0p4EowHjnojIIJSbdbiWYENT2BLOc7JTht89l8678y+iOSvtB0ZI2k8XJ0snTZFGAhr1gVot
 nr6Na2abpVpUUbe0mCh0Ds/BRjvXfBzqp8IJyrkMaYk8ej/Ndhc+cDaKteOyaK5v5FwXbGJupO3
 +Ma2wwItXYvAqWMSUoUa1ypcly2minuGLNFKWkB8yqN+xVCJOu9X8cBtqrzGj+NhqAljwchcrPP
 MR2Jms4REJ5G35H8ArtIPTUdbJ1q/b0md3cM2SiO1UfeOPS59iRkObERlI9nvlfj1hlbXniYnat
 p6gOYKR5ReWHZxpeP2NWtTToKxI/yikPBYQUeCKJfdd0AouYnGvX2TJBTNoq8V8tbCtsIGdHwyW
 QVgkQjUfguXNALoTySFeTyS+fjcqVSlEaPe8KWcH+Xunmo6fjo6MbZqDmA6Y5ocR7f9TxLN30t4
 3dgUYBjwhydjOv/NVidfNW1SLNicQDUccfbCzW9bxUxKpMxmO2KibzRK7ZMNsjGyXTv09fzNR6H
 GFLCSX6nEshAugA==
X-Developer-Key: i=marcus.folkesson@gmail.com; a=openpgp;
 fpr=AB91D46C7E0F6E6FB2AB640EC0FE25D598F6C127

Move all structures that will be common for all interfaces (SPI/I2C) to
a separate header file.

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---
 MAINTAINERS                           |   1 +
 drivers/gpu/drm/sitronix/st7571-i2c.c |  91 +---------------------------
 drivers/gpu/drm/sitronix/st7571.h     | 108 ++++++++++++++++++++++++++++++++++
 3 files changed, 111 insertions(+), 89 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index cc8a7f3f1dabaf402b21f767ecb093a31ade248f..2814faae61eceecae1bccaaf92010e22dca81376 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8083,6 +8083,7 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/display/sitronix,st7567.yaml
 F:	Documentation/devicetree/bindings/display/sitronix,st7571.yaml
 F:	drivers/gpu/drm/sitronix/st7571-i2c.c
+F:	drivers/gpu/drm/sitronix/st7571.h
 
 DRM DRIVER FOR SITRONIX ST7701 PANELS
 M:	Jagan Teki <jagan@amarulasolutions.com>
diff --git a/drivers/gpu/drm/sitronix/st7571-i2c.c b/drivers/gpu/drm/sitronix/st7571-i2c.c
index 2b52919d7dd434bb16aa66274eae8730649f62f1..af27658a5e152534d445bc623893eee6b3ca00d5 100644
--- a/drivers/gpu/drm/sitronix/st7571-i2c.c
+++ b/drivers/gpu/drm/sitronix/st7571-i2c.c
@@ -35,6 +35,8 @@
 #include <video/display_timing.h>
 #include <video/of_display_timing.h>
 
+#include "st7571.h"
+
 #define ST7571_COMMAND_MODE			(0x00)
 #define ST7571_DATA_MODE			(0x40)
 
@@ -78,95 +80,6 @@
 #define DRIVER_MAJOR 1
 #define DRIVER_MINOR 0
 
-enum st7571_color_mode {
-	ST7571_COLOR_MODE_GRAY = 0,
-	ST7571_COLOR_MODE_BLACKWHITE = 1,
-};
-
-struct st7571_device;
-
-struct st7571_panel_constraints {
-	u32 min_nlines;
-	u32 max_nlines;
-	u32 min_ncols;
-	u32 max_ncols;
-	bool support_grayscale;
-};
-
-struct st7571_panel_data {
-	int (*init)(struct st7571_device *st7571);
-	int (*parse_dt)(struct st7571_device *st7571);
-	struct st7571_panel_constraints constraints;
-};
-
-struct st7571_panel_format {
-	void (*prepare_buffer)(struct st7571_device *st7571,
-			       const struct iosys_map *vmap,
-			       struct drm_framebuffer *fb,
-			       struct drm_rect *rect,
-			       struct drm_format_conv_state *fmtcnv_state);
-	int (*update_rect)(struct drm_framebuffer *fb, struct drm_rect *rect);
-	enum st7571_color_mode mode;
-	const u8 nformats;
-	const u32 formats[];
-};
-
-struct st7571_device {
-	struct drm_device drm;
-	struct device *dev;
-
-	struct drm_plane primary_plane;
-	struct drm_crtc crtc;
-	struct drm_encoder encoder;
-	struct drm_connector connector;
-
-	struct drm_display_mode mode;
-
-	const struct st7571_panel_format *pformat;
-	const struct st7571_panel_data *pdata;
-	struct i2c_client *client;
-	struct gpio_desc *reset;
-	struct regmap *regmap;
-
-	/*
-	 * Depending on the hardware design, the acknowledge signal may be hard to
-	 * recognize as a valid logic "0" level.
-	 * Therefor, ignore NAK if possible to stay compatible with most hardware designs
-	 * and off-the-shelf panels out there.
-	 *
-	 * From section 6.4 MICROPOCESSOR INTERFACE section in the datasheet:
-	 *
-	 * "By connecting SDA_OUT to SDA_IN externally, the SDA line becomes fully
-	 * I2C interface compatible.
-	 * Separating acknowledge-output from serial data
-	 * input is advantageous for chip-on-glass (COG) applications. In COG
-	 * applications, the ITO resistance and the pull-up resistor will form a
-	 * voltage  divider, which affects acknowledge-signal level. Larger ITO
-	 * resistance will raise the acknowledged-signal level and system cannot
-	 * recognize this level as a valid logic “0” level. By separating SDA_IN from
-	 * SDA_OUT, the IC can be used in a mode that ignores the acknowledge-bit.
-	 * For applications which check acknowledge-bit, it is necessary to minimize
-	 * the ITO resistance of the SDA_OUT trace to guarantee a valid low level."
-	 *
-	 */
-	bool ignore_nak;
-
-	bool grayscale;
-	bool inverted;
-	u32 height_mm;
-	u32 width_mm;
-	u32 startline;
-	u32 nlines;
-	u32 ncols;
-	u32 bpp;
-
-	/* Intermediate buffer in LCD friendly format */
-	u8 *hwbuf;
-
-	/* Row of (transformed) pixels ready to be written to the display */
-	u8 *row;
-};
-
 static inline struct st7571_device *drm_to_st7571(struct drm_device *drm)
 {
 	return container_of(drm, struct st7571_device, drm);
diff --git a/drivers/gpu/drm/sitronix/st7571.h b/drivers/gpu/drm/sitronix/st7571.h
new file mode 100644
index 0000000000000000000000000000000000000000..c6fd6f1d3aa33d6b43330ce8f2cb2d3f2321b29b
--- /dev/null
+++ b/drivers/gpu/drm/sitronix/st7571.h
@@ -0,0 +1,108 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Header file for:
+ * Driver for Sitronix ST7571, a 4 level gray scale dot matrix LCD controller
+ *
+ * Copyright (C) 2025 Marcus Folkesson <marcus.folkesson@gmail.com>
+ */
+
+#ifndef __ST7571_H__
+#define __ST7571_H__
+
+#include <drm/drm_connector.h>
+#include <drm/drm_crtc.h>
+#include <drm/drm_drv.h>
+#include <drm/drm_encoder.h>
+
+#include <linux/regmap.h>
+
+enum st7571_color_mode {
+	ST7571_COLOR_MODE_GRAY = 0,
+	ST7571_COLOR_MODE_BLACKWHITE = 1,
+};
+
+struct st7571_device;
+
+struct st7571_panel_constraints {
+	u32 min_nlines;
+	u32 max_nlines;
+	u32 min_ncols;
+	u32 max_ncols;
+	bool support_grayscale;
+};
+
+struct st7571_panel_data {
+	int (*init)(struct st7571_device *st7571);
+	int (*parse_dt)(struct st7571_device *st7571);
+	struct st7571_panel_constraints constraints;
+};
+
+struct st7571_panel_format {
+	void (*prepare_buffer)(struct st7571_device *st7571,
+			       const struct iosys_map *vmap,
+			       struct drm_framebuffer *fb,
+			       struct drm_rect *rect,
+			       struct drm_format_conv_state *fmtcnv_state);
+	int (*update_rect)(struct drm_framebuffer *fb, struct drm_rect *rect);
+	enum st7571_color_mode mode;
+	const u8 nformats;
+	const u32 formats[];
+};
+
+struct st7571_device {
+	struct drm_device drm;
+	struct device *dev;
+
+	struct drm_plane primary_plane;
+	struct drm_crtc crtc;
+	struct drm_encoder encoder;
+	struct drm_connector connector;
+
+	struct drm_display_mode mode;
+
+	const struct st7571_panel_format *pformat;
+	const struct st7571_panel_data *pdata;
+	struct i2c_client *client;
+	struct gpio_desc *reset;
+	struct regmap *regmap;
+
+	/*
+	 * Depending on the hardware design, the acknowledge signal may be hard to
+	 * recognize as a valid logic "0" level.
+	 * Therefor, ignore NAK if possible to stay compatible with most hardware designs
+	 * and off-the-shelf panels out there.
+	 *
+	 * From section 6.4 MICROPOCESSOR INTERFACE section in the datasheet:
+	 *
+	 * "By connecting SDA_OUT to SDA_IN externally, the SDA line becomes fully
+	 * I2C interface compatible.
+	 * Separating acknowledge-output from serial data
+	 * input is advantageous for chip-on-glass (COG) applications. In COG
+	 * applications, the ITO resistance and the pull-up resistor will form a
+	 * voltage  divider, which affects acknowledge-signal level. Larger ITO
+	 * resistance will raise the acknowledged-signal level and system cannot
+	 * recognize this level as a valid logic “0” level. By separating SDA_IN from
+	 * SDA_OUT, the IC can be used in a mode that ignores the acknowledge-bit.
+	 * For applications which check acknowledge-bit, it is necessary to minimize
+	 * the ITO resistance of the SDA_OUT trace to guarantee a valid low level."
+	 *
+	 */
+	bool ignore_nak;
+
+	bool grayscale;
+	bool inverted;
+	u32 height_mm;
+	u32 width_mm;
+	u32 startline;
+	u32 nlines;
+	u32 ncols;
+	u32 bpp;
+
+	/* Intermediate buffer in LCD friendly format */
+	u8 *hwbuf;
+
+	/* Row of (transformed) pixels ready to be written to the display */
+	u8 *row;
+};
+
+#endif /* __ST7571_H__ */

-- 
2.50.1


