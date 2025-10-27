Return-Path: <linux-kernel+bounces-871011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85F75C0C3B1
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 09:07:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CA403A25F0
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 08:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0EDF2E7F3E;
	Mon, 27 Oct 2025 08:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lRhi6/iz"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B6F2E7BA0
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 08:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761552390; cv=none; b=JVPWqBjdfN6r26HEXX3n4mzA1HlFfaVSTg5L5AlcF6Q7nb7cnv/51TU/P0NxgDmri8VtdKMpYlVlzZrQzv5B7iA3OPtLMj1Dp0glYotkUV71ylERS6Z2E3Ds803Evwp2i6cyj5O8c5xwaY3GOAv6v+PBB2gV9QTtFQ9jzCFRamQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761552390; c=relaxed/simple;
	bh=oj5JSSIwffzeqzrjLvw57GX1wzHco1M6GQyX3QdaS3o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iK+lhC+6jRfAP0jb+2NAf+ZK7cSzsC6zQzQXTb/jnYCl3L3hv7J/OyCbWjrU26hK0PA2qNQcRpdwLTTKfsOPIGtFji2RmI1qftMIJfbkaQQyGYjgThN/TtSBB/bggihAHIE2gZXQCc7ywuoFa6wWoL2uX2zb5Vz8nlRyf/aUm4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lRhi6/iz; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-591ea9ccfc2so5566331e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 01:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761552387; x=1762157187; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mG4iS2woxPf+3BthpgnKFGsPtU8cg+2wLUJdaVgtpEs=;
        b=lRhi6/izwadKlJ/20JoqowZQBC599XHjH+51RUw5JkR4UaNyqW7fkKqJ8giGScLQ9w
         4k4iKf+QGBPpa/Onemn9qyNniDRs3bj39fsB9Fg7knAe1LdOm3KVP2X4iSbAKFhM6iZC
         6V0I4hoNt0YNqAAKa7zQ0eRPcbbmXdIhs1zTopoJwyI5Cq5E+nMXIqHqc94glc2hdZSm
         Z24QfCnLk7XtwqkhjM4Sll+7cGasBcH87OLwuDmBbUJIENQnM5UtdhTZK/Wudx323FkV
         vAbCFCNr8Gflslr4gVWSgQE2eGyD/vLO0keAPpW9cOuwaV8loi2K78yWas7fjbSQbvma
         H8Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761552387; x=1762157187;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mG4iS2woxPf+3BthpgnKFGsPtU8cg+2wLUJdaVgtpEs=;
        b=PlpLVXHO0iOhOKBHfR6Legievr7dNdCRjSQM/odZctaX2jJpcBDLx8vZ5tBVThcXW3
         8r92S/Z6TabLA6/QPbZ6nCx4MT1GcAcUYoMJi5d6X/uwt2MVdqX98WeurcgIbqtEOPtM
         ed7coKsfcyHeMHl9fz44cXwV+GB9T6B3iA7+Y01XUUOKuKZR3AjgL238RTlKVz0L5Qqn
         Ur9pwnbkzd4U6IQlnQPe1nOd9jrFUljUMSYSD79ZYdUTwcA/z8RTzrYZmecZIG1J4qv5
         cZSB4aWcKk5hIAHjDfCkDl52Kz0J8x/CZRK8BFHBE307Bhi51vHs7xvTpWdKg9uRX5S9
         ypHg==
X-Forwarded-Encrypted: i=1; AJvYcCWBL/6bcj+R0yrtiLim1ZpSMqTwW2M+FA0vZ2M5mSQ+u8h1AxKpGgZ9w8GJipBSyUWeJboMnqJhes0hK0Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQa2SkqNSswgwcFQFpJJ/H9zi8ljNAnQfNE9NTdLLi5mJDrT/K
	S2Z5Hx52XZdjctk90NNKflspxE3JmOJeKrXPnvV+hw5/P8vEu5hEYQPC
X-Gm-Gg: ASbGncsbEcirCiRLKVLzm10gekm48oZl1R5ZBTw1I3kOeYhKB0irDCvGCwBAOBYZU5w
	Uvw/76a0enhFzK+WuSSQSK15lvlsVr0he+lRNoQRFFVvUPRxEGCbNEWio76AUuWWo3WHDEnLdMs
	Df8zoMAzdYYddvTX/ILx3y1htnkczOPH4TsGP9izNGPztDNK1mRIa8DCrG0UdIINeD5X1nxYIh8
	MbnbH2DKcZBSpiCI31WFkDOY4fSrVazynCXX9tNS3AO5bovf1ATFzHkcGVniLwfNSKU0/h/QaDT
	b/v1XWm3vKvQUoE2ktmEhddh5UQA4G4Y/cyAfaCHr4/VWqW7A/15zi9wctpSl60JQ4YQBxiFpRh
	k9+Czoy/J311CXp0GY9FRqpkXQEFEH18ahRJImSvdV04e/l2N9y2M8K4OogJGimjjxG1pyNsE0P
	t2FHWiqgCDkLzwbnxUsXGAK4J3rVepj5mnfqfqaynhAJxm
X-Google-Smtp-Source: AGHT+IE7lymUIggT5POZWMrgs3TqPtDu6HHycwtT2bdPZdUD1qE3qAPOhZ/+mLdtO5qNpBF5VygU1g==
X-Received: by 2002:a05:6512:b26:b0:593:7bc:970a with SMTP id 2adb3069b0e04-59307bc976bmr964639e87.3.1761552386680;
        Mon, 27 Oct 2025 01:06:26 -0700 (PDT)
Received: from [192.168.1.168] (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59301f41ce8sm2210689e87.6.2025.10.27.01.06.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 01:06:25 -0700 (PDT)
From: Marcus Folkesson <marcus.folkesson@gmail.com>
Date: Mon, 27 Oct 2025 09:05:43 +0100
Subject: [PATCH v2 3/6] drm/sitronix/st7571-i2c: move common structures to
 st7571.h
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251027-st7571-split-v2-3-8352fb278d21@gmail.com>
References: <20251027-st7571-split-v2-0-8352fb278d21@gmail.com>
In-Reply-To: <20251027-st7571-split-v2-0-8352fb278d21@gmail.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Marcus Folkesson <marcus.folkesson@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7890;
 i=marcus.folkesson@gmail.com; h=from:subject:message-id;
 bh=oj5JSSIwffzeqzrjLvw57GX1wzHco1M6GQyX3QdaS3o=;
 b=owEBbQKS/ZANAwAKAYiATm9ZXVIyAcsmYgBo/yfotsdwL2JDtbBx3/1RqTJkbA+8FY1KPli9n
 I/PzE9iU3yJAjMEAAEKAB0WIQQFUaLotmy1TWTBLGWIgE5vWV1SMgUCaP8n6AAKCRCIgE5vWV1S
 MpvLD/92QqkcZ6aKJTaa83b4u4tqUaO7+BeNnR3XmC3/Kr1Jy4fUBqtKwFIMPLzpeTjvrkUOUZz
 7jX+Gor6w+iiYjZumiEON/PPrRnNUVcCAOdSPpismXuRysLUKXCVB3i4bPs0WEAznRYQ4WsmijS
 dMKVBa5As70LmSeolYw8Rly/1e9Ip/Hg6GcHwdwKfnAxdvLblV/oiwEifTQG2953043a1IeLavI
 WO11TU3SH5qoZW9IyuBEF9Mh9ionSPLoXUHvuyfmg4Qs8fNzaTuafwA98NclvjqdrnIA+TQ+M1q
 S2efMRXlaOUu0jk9bx2v4gxnNMHcJenEFeq579DkC4i3H8wOMWclmgNDYj4g6v1PF/qA8FOLGzg
 wlJ1oQx7pBErIb9UbL+O4LTmqKjgQxpS1mQNsCfXgL+c/qpeFrYQWpOLHCcF8P/5rrcxpESRv8Y
 OT5dR28uAJbZgwpbD5YVnC9sH0QqNojluHEbE36flV7UyS6fI+ngS9IC1IUSyXdz9DdI/gJQV8+
 mSgofGp9osVCY0mcmsptYI1Y/Z+v19U5YwBqX8x8dEgL91sPvVOEaprVkvSDj77uDO2YiSNRvz9
 s+lO9u3GDcYPpxNs7nGHnsNTTv6h2/Q9eHCGnsarlDzahslrNBm57pXI4GQ2ba71qEFM5qCg9PD
 8RA4/YvhX7srcXQ==
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


