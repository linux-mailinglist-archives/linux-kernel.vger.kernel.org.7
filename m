Return-Path: <linux-kernel+bounces-739089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E77D4B0C1A0
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 12:46:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8ED5918839B9
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 10:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FB2D296151;
	Mon, 21 Jul 2025 10:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OMInJzBg"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 589C4293C53;
	Mon, 21 Jul 2025 10:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753094663; cv=none; b=JlH7ZeEmLUrAcuvy7JIF0/Qd9YNR2FUhYXuYqcXUrl0jS6a4FJBKh6n6f7g++QrI/RoJHoawAFDcH2kmXa2tdd1bNG6E2oDjyQi0dCKNT8iQLImpBMTvgImGlSjzC8C8fvihX8m5eRSl4mTVZehKqitKg1coZ+k1S0mLJSRcKVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753094663; c=relaxed/simple;
	bh=ja2G1eJ+TGuBldLn7eDuIWTNyT69bULS5f7eLL4mV1U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=huBFeO3G7YMD2sYe0pt2lWIONgGaWO+D51KxBiNV8oXRa2/edNAgY0fIDpJnzp5E6mLuXU1sRarXatgfd1UdPZFqEJ3yC5pm7NhIC3tDIvxUYceSxGTfGTlW2cTVe4Izbh+QM/M9/76OrUNnN5MGQ3Q0XmeiF2CTj7A4o+KWb84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OMInJzBg; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5561d41fc96so4829371e87.1;
        Mon, 21 Jul 2025 03:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753094659; x=1753699459; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cEVQJX/SYaok2ELlEAnWGTHXSwBKm7K9AhgOU6uSUA4=;
        b=OMInJzBgkmGJbBkAp3sX0fZpWX0RR84w4u4/xwOTZYo+x5ttoofgVsUBG5KloOZZs/
         gQl9WZUkV/9qTIjW6vJCfDNmjHvdpP+YEFMQJ3h8dpix/EN/Pqw6roUJ3ZGE7dVp3F/O
         6LK09kvYkrnimXvxaTyYcJrgVAzwe6fCGZlEV9MGZx7fMvHcT6LJSWnyCRIg4848sJDd
         oTUpiwiObzS5nWVuaL/VcQrurtNLsSR7h+mN0TsJH/nOWrZfSjZu4AJKb7upG//T83fh
         X/GfxIzroo5jLoGQrCgqDJtmYMBNn/tbsHrsgBy+UIP/ZC1Ffbys3GjNYDWQZO18ABdT
         7elw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753094659; x=1753699459;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cEVQJX/SYaok2ELlEAnWGTHXSwBKm7K9AhgOU6uSUA4=;
        b=aiZSycnHiXO4zK3O1f3GW36AEUiA1lERGK3e1n34OxmH0jZHx/nlE+bJwrhE5+oOv9
         TL5cXxptr7NrqkKkXkc5qv3rRnFOz5hw5Ug89ldm75KN9myK4U7cbU7hk4gD8iNVco1A
         joc1UcYzRhZkn9FN1cFGNF3/RPwUVbo8pMPb+6R2jHg7bIL7kxzMZvlFob1Ba/VbKasI
         ahJL8ESpurBWlUQ6njKNsLncpXJ2IkmdYqCJDjFV8JNve9iLomUPVf2nC/6EKtA6yOsU
         XGEOFNCMp6XyzG2MnokZmEtBoD5kuPMyH6ZfgA/dAj8MdoV3LP8p1ZkX1Bhq8r9BrCqF
         E67A==
X-Forwarded-Encrypted: i=1; AJvYcCXj35NXLrIDu5bGq46fDumMhfkTxFGeYv654EPg78kjxil8s7O5zihw/HoIoQrO5Xv9GgMB2H0Q4MIf@vger.kernel.org, AJvYcCXsiLaw3wwygTpT5uRASEuIqU+TttTB75EhSVHipjcxxFLh7rcXUGxpiMCwxqy65hvolJ93xuzwT0gwFy//@vger.kernel.org
X-Gm-Message-State: AOJu0YzispUcr+WvkpP6KCOLdnKyJTv3AQXqmNuPGmusU044WifWFOZS
	H0sFbM29b4OS3GXNZt/z+K7xhW9t5Un5tSbFLC7yNT7/vuHtF1ZIP4pBhO2YL2h9KvM=
X-Gm-Gg: ASbGnct8ZCgi9BvR4VEKE5EhlosF6lM5rKGmm9TeBbJY4JSKVTsP6yl5PwdcZ+m+LeY
	MV9SeJwOCo9UjNPncRkvN6nADpFGDJ5swx6LSyekp92vIKcWDWGuhS2cIDoAJ0kJXgnUmBsP6sd
	KcdKICHIUrMJr1mg1sMuFEAzevHVLeaK314oh2ia2fWU8SqUk6/ic/3U2mr3aqFtkcosZZuDqo7
	WWj8GrDIGVWSjr4DO5vYGC8VStVJg+C31l8A+sI4c1KEehdfwxkXt3ICO5X0VcY1iMdJUurhVUx
	WCf9tq+ED/RUKhbiBdKetngRv7xmpLBI9DQ5O2gm3Ui0K/RSlUYmZDFqz/SIgzxYu9keV54dcSd
	gfOQx8tApDPzZMsEHjeDslDUETNIhVLgKoIjbXOMIn7uCI/M2fTxrCwuX88c9Asd/5hY=
X-Google-Smtp-Source: AGHT+IHXrE/b7Rgb/FIQPijG5gK8yp/2SErYc3pBimq59GRkoNvzydms1sqxH8TRJFa3u4jKeHLB9Q==
X-Received: by 2002:a05:6512:4002:b0:551:f0ce:80e3 with SMTP id 2adb3069b0e04-55a23f2d1e1mr5119301e87.25.1753094658913;
        Mon, 21 Jul 2025 03:44:18 -0700 (PDT)
Received: from [192.168.1.198] (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55a31db89bbsm1505164e87.237.2025.07.21.03.44.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 03:44:18 -0700 (PDT)
From: Marcus Folkesson <marcus.folkesson@gmail.com>
Date: Mon, 21 Jul 2025 12:43:36 +0200
Subject: [PATCH v2 6/6] drm/st7571-i2c: add support for 2bit grayscale for
 XRGB8888
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250721-st7571-format-v2-6-159f4134098c@gmail.com>
References: <20250721-st7571-format-v2-0-159f4134098c@gmail.com>
In-Reply-To: <20250721-st7571-format-v2-0-159f4134098c@gmail.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Javier Martinez Canillas <javierm@redhat.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Marcus Folkesson <marcus.folkesson@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3639;
 i=marcus.folkesson@gmail.com; h=from:subject:message-id;
 bh=ja2G1eJ+TGuBldLn7eDuIWTNyT69bULS5f7eLL4mV1U=;
 b=owEBbQKS/ZANAwAIAYiATm9ZXVIyAcsmYgBofhnyibw5+htt8L/mz/Z6LY19g2cML7+of3ndE
 OqD2okki9yJAjMEAAEIAB0WIQQFUaLotmy1TWTBLGWIgE5vWV1SMgUCaH4Z8gAKCRCIgE5vWV1S
 MoaXD/9EaTHWfHlZ+G1qRPSwOSFiQsBlb/EiAKzsJwKXxKbakXiCIXx9td6UhhxPUR/IyJuvVn/
 mHP3Goy+tleR+6GD5woJb/5ZhNT1i7ixI918yfPeDF96GbX3EPp8/8Fqn/cbvvOMxAqBt/Y47Zu
 9KffqVAa0Jkw3q9+yse1eX+9aaO0PjzAr8Sdsf4xbggmoRMU4kKNN0mgo6jqy25XP1Mi6beXDHf
 HzToFKyAcESqeLuN8d4OG/ELhs62cLRYpL5A5C2NdIU4kHH0RCjGhDFyQgTLE5WaUzV07rFz9Sx
 VVRzRyG8FIpc1N2p5r60+FJNTJuDL08znCG1187KgPiL2fk8g6DdijmeapZlviN3FZtE2wDNklC
 PHfs3DeZfD9YGgn9OsbvQoC3taMhet8qvpBIHTxMNM15sH2hkjlTwt2IKGLy+SqOK26d9oSJ11R
 V7Xl4yIEiRi88m4ZXo4UJR+n0PdfUAOmvzLNpkwQ1NEK5UUDUHqO+gT07DuQRUp3YkBAQYoF+XH
 qm3I5q7S0RM23k+oAsFTw2kllk2tLXJ+T4+UydTIIaL9F1VcWdmZnVlh/vF/+qBN1T+EeOF3818
 9uF0ru6G7rAw+XGorLS5VnqeGI+6Q60cKFfXp7dcXenUypYI40xLMDhQ1KV2k+AWk59BJYFpB4e
 DgdrnByYHPxK3NQ==
X-Developer-Key: i=marcus.folkesson@gmail.com; a=openpgp;
 fpr=AB91D46C7E0F6E6FB2AB640EC0FE25D598F6C127

Add support for 2bit grayscale and use it for XRGB8888 when grayscale is
supported.

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---
 drivers/gpu/drm/sitronix/st7571-i2c.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/sitronix/st7571-i2c.c b/drivers/gpu/drm/sitronix/st7571-i2c.c
index 9f2de057ce9d990fdd77e395a6c32ba1e2f36137..6c5935c37a2abf99116f8c2f67eec25bad90c8a8 100644
--- a/drivers/gpu/drm/sitronix/st7571-i2c.c
+++ b/drivers/gpu/drm/sitronix/st7571-i2c.c
@@ -219,10 +219,11 @@ static int st7571_send_command_list(struct st7571_device *st7571,
 	return ret;
 }
 
-static inline u8 st7571_transform_xy(const char *p, int x, int y)
+static inline u8 st7571_transform_xy(const char *p, int x, int y, u8 bpp)
 {
 	int xrest = x % 8;
 	u8 result = 0;
+	u8 row_len = 16 * bpp;
 
 	/*
 	 * Transforms an (x, y) pixel coordinate into a vertical 8-bit
@@ -237,7 +238,7 @@ static inline u8 st7571_transform_xy(const char *p, int x, int y)
 
 	for (int i = 0; i < 8; i++) {
 		int row_idx = y + i;
-		u8 byte = p[row_idx * 16 + x];
+		u8 byte = p[row_idx * row_len + x];
 		u8 bit = (byte >> xrest) & 1;
 
 		result |= (bit << i);
@@ -304,11 +305,11 @@ static void st7571_prepare_buffer_grayscale(struct st7571_device *st7571,
 	struct iosys_map dst;
 
 	switch (fb->format->format) {
-	case DRM_FORMAT_XRGB8888: /* Only support XRGB8888 in monochrome mode */
-		dst_pitch = DIV_ROUND_UP(drm_rect_width(rect), 8);
+	case DRM_FORMAT_XRGB8888:
+		dst_pitch = DIV_ROUND_UP(drm_rect_width(rect), 4);
 		iosys_map_set_vaddr(&dst, st7571->hwbuf);
 
-		drm_fb_xrgb8888_to_mono(&dst, &dst_pitch, vmap, fb, rect, fmtcnv_state);
+		drm_fb_xrgb8888_to_gray2(&dst, &dst_pitch, vmap, fb, rect, fmtcnv_state);
 		break;
 
 	case DRM_FORMAT_R1:
@@ -334,7 +335,7 @@ static int st7571_fb_update_rect_monochrome(struct drm_framebuffer *fb, struct d
 
 	for (int y = rect->y1; y < rect->y2; y += ST7571_PAGE_HEIGHT) {
 		for (int x = rect->x1; x < rect->x2; x++)
-			row[x] = st7571_transform_xy(st7571->hwbuf, x, y);
+			row[x] = st7571_transform_xy(st7571->hwbuf, x, y, 1);
 
 		st7571_set_position(st7571, rect->x1, y);
 
@@ -359,14 +360,13 @@ static int st7571_fb_update_rect_grayscale(struct drm_framebuffer *fb, struct dr
 	rect->y2 = min_t(unsigned int, round_up(rect->y2, ST7571_PAGE_HEIGHT), st7571->nlines);
 
 	switch (format) {
-	case DRM_FORMAT_XRGB8888:
-		/* Threated as monochrome (R1) */
-		fallthrough;
 	case DRM_FORMAT_R1:
-		x1 = rect->x1;
-		x2 = rect->x2;
+		x1 = rect->x1 * 1;
+		x2 = rect->x2 * 1;
 		break;
 	case DRM_FORMAT_R2:
+		fallthrough;
+	case DRM_FORMAT_XRGB8888:
 		x1 = rect->x1 * 2;
 		x2 = rect->x2 * 2;
 		break;
@@ -374,7 +374,7 @@ static int st7571_fb_update_rect_grayscale(struct drm_framebuffer *fb, struct dr
 
 	for (int y = rect->y1; y < rect->y2; y += ST7571_PAGE_HEIGHT) {
 		for (int x = x1; x < x2; x++)
-			row[x] = st7571_transform_xy(st7571->hwbuf, x, y);
+			row[x] = st7571_transform_xy(st7571->hwbuf, x, y, 2);
 
 		st7571_set_position(st7571, rect->x1, y);
 
@@ -395,7 +395,7 @@ static int st7571_fb_update_rect_grayscale(struct drm_framebuffer *fb, struct dr
 			 * For monochrome formats, write the same value twice to get
 			 * either a black or white pixel.
 			 */
-			if (format == DRM_FORMAT_R1 || format == DRM_FORMAT_XRGB8888)
+			if (format == DRM_FORMAT_R1)
 				regmap_bulk_write(st7571->regmap, ST7571_DATA_MODE, row + x, 1);
 		}
 	}

-- 
2.49.0


