Return-Path: <linux-kernel+bounces-729585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 825F8B038B0
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 10:05:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 949B517AEA3
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 08:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B66B23C8C5;
	Mon, 14 Jul 2025 08:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JAPttOUt"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A2423C397;
	Mon, 14 Jul 2025 08:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752480283; cv=none; b=lPYz0Ck/uMoSDG3Rg9xzxXIQ21l7fFDvzaDcbN/5O7ErPHCrpu08NmNnN//wHdRPMW0ej/GCLmZSNWyb0v/U+s4jbiB5vN6NjEcRGlpra5dwxzBFmfFyCB41aYmxEoJBTyWWO7kbe0UELmmMLJxxpgbnJtqbXtphb15enySQqog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752480283; c=relaxed/simple;
	bh=lEahKLLZv0LLgcdxOGD69aUK2W4QHfqMPLiGWzoEYP0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rNFs9BTYUtcqVMmodKnI3RIS0+LDpq1suuZBkm2K91DudruwgC6sMzk9ofXVoXQtsndIjwJmlaSOwxz4A6IFbYnp1KW3PqgxwNUc7D6aBManM9Uh4nbqVJXOaVpqUyV+hycYMVQ3rwcqQrL2IBf8D1JIkUGSF4RE3LzSQe3T+PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JAPttOUt; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-553b16a0e38so4246505e87.1;
        Mon, 14 Jul 2025 01:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752480280; x=1753085080; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p263TqCClLXlOHu3dp7Z4XuoCZcYckTKI9E2PFULeZU=;
        b=JAPttOUto2l8iLucogK/EaaJr4/Y/c1GCYm8eX3JuHZxeZ8dLPZiV9UiSaNqShOKte
         +VV5FYnG5Mi6mCvI8UGo685u+MEU0ZRjjl5AmqjNSx3SnZrYoWc8M5vTPRY3dC2rORG+
         C0Eqy+bjA9YSuHjrvWjbm1V/w8u1Z+rtTno9NWPUbtdnwkYwEdG4ZYmTw/uGZ7Y4XpGy
         kKmGhjAR2MGj8SmnwI5FGPBMBdBB+7Ok3dgrGUATAND3Dea+2j5NWk01g0CthLoOXa4c
         7oZGI5epLe5B1nY37hXzJ87MldmPT59Cc1BUpGmiL0pD84xKQuDlQ/SfFBjnkC5YmXo2
         yReA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752480280; x=1753085080;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p263TqCClLXlOHu3dp7Z4XuoCZcYckTKI9E2PFULeZU=;
        b=T0EBBU9IuAqmr2TAzqpHyUX9vRjHme5/B4lqTVzoj2x7WiKfjZIKODVPAMEEFqmXbv
         TBDKqi4ekSFikJqBEKjq/FxM8Y4glKYJfAG/IwTIM9yoNu9Jak4bIiOptrssKHF4iIIu
         gBqbDInxjGuWryrSlakaFjbW2lkcqHPveTpkqsegQXoMU7aPO2pK2H4jjp2AwKQn4mxA
         C6JIHHN/jqtXalDarfN1fzGARBBytEKGUy9pzFCcEN3BiH4KWO1x3vKIA7zSecMz9ep5
         dR6b3jHqACRaaSb3ngpRH9s4ZgOM2ZQqtv3iA+JI+Q8jCl2ISvb6xSqcPDwjlsB3sNYC
         054g==
X-Forwarded-Encrypted: i=1; AJvYcCV2uWQSY7YSV4o/OmCiJVDTlA6NBxlW2dm1c3et2UsJq0E4mluHFovy41XLYFgW797ABPbpR4VRWa5wjRTB@vger.kernel.org, AJvYcCViCZWpwYI4PLsvd+5VkJuPuc0BpaviDMQqJoGkuCNvZRi3knZiX0g7h5OcJWlG8H8ghZWSjIatCZj/@vger.kernel.org
X-Gm-Message-State: AOJu0YyiNG7l4WznqcjWqNKH+MeS6w6dFkvOjhlKahHrJ8BJDMZpnrno
	r/YAkFFEfI+/Y55Vt5wCu/YNtj7g5D8fIbh4z4aMGAD95F6QN8c25HGt
X-Gm-Gg: ASbGncu6Nsb5+1wzwXvNusVUanGZ5KTOg0dBZztFAQo++emxKbanAluDX6io16Z7sQQ
	6NK23Op/wj/YutPSD6/x8GzpjnTQ3oEaPUMoEWfEOMXOVNl9Egioz+XJVIN4HRJyTLAl5silbvw
	F0IRJZLndp1N9876h+bfPMwEtV14oRc+5Re1piCuPQKDB/k8oLZztP6MbCXbTMnBjSCrDj8FWYP
	AMDdytGW7miUp8a6SQ3mS/wjg2tmFYgHDP/kCDBjUIs/bUF0klGIGszPFA7YM7syGxbbyrXpIto
	t5IKVXhPxei70GS1aTmeKmXXmas88936H587qilBPYlRsCjF51h6s6LQMulP6auajJi4BoRPJiW
	zOnQ+BfJpmkpsTLSf14oWDEVKkIDwpqdhvs5sVSOUODmIlE7MsopCupzkeKcSZ75KEH0=
X-Google-Smtp-Source: AGHT+IE3ZGGk8mZi8PoK4ms4CTR4TyCRXk7fcOY1Cm8zIS7n5cos+N2F2WJeqZ5ykBVRsyCfAC7TLg==
X-Received: by 2002:a05:6512:1384:b0:553:a490:fee0 with SMTP id 2adb3069b0e04-55a044d1e73mr3798544e87.10.1752480279357;
        Mon, 14 Jul 2025 01:04:39 -0700 (PDT)
Received: from [192.168.1.198] (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55943b6c08esm1864385e87.187.2025.07.14.01.04.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 01:04:38 -0700 (PDT)
From: Marcus Folkesson <marcus.folkesson@gmail.com>
Date: Mon, 14 Jul 2025 10:04:03 +0200
Subject: [PATCH 5/5] drm/st7571-i2c: add support for 2bit grayscale for
 XRGB8888
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250714-st7571-format-v1-5-a27e5112baff@gmail.com>
References: <20250714-st7571-format-v1-0-a27e5112baff@gmail.com>
In-Reply-To: <20250714-st7571-format-v1-0-a27e5112baff@gmail.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Javier Martinez Canillas <javierm@redhat.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Marcus Folkesson <marcus.folkesson@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3579;
 i=marcus.folkesson@gmail.com; h=from:subject:message-id;
 bh=lEahKLLZv0LLgcdxOGD69aUK2W4QHfqMPLiGWzoEYP0=;
 b=owEBbQKS/ZANAwAIAYiATm9ZXVIyAcsmYgBodLoKlMDoV62CdpZv99GtIylRkXaQLIgIy6fzV
 /c8d65lA0CJAjMEAAEIAB0WIQQFUaLotmy1TWTBLGWIgE5vWV1SMgUCaHS6CgAKCRCIgE5vWV1S
 MhgJD/46rCLbofHMykyf7wYDHr1TeW7OTQOPfm4/xt0V5SR16spFYk9WNtfROaJOvNKjD22h14J
 8l8hAIBl9TyUgpPB1RgyQt6E6KcIWLb3crFcefFMorm5BK+kfuNOl+fUDmaU0H7vzEArNP/jF6a
 UGZL0lq/KAEZFHnepTZ5gx/oDWkLftwDA4N84po1d7zo1jWewiDsrooiwIkYPzdrep04nYGy9JB
 X1ZE+iVHzJX9q2aoUTAfq6FmgNCJsEhlrlx/R0eVQjgTyOW1DtP2ZxpXKaGc5wXTcNtZHrdIRTy
 7vIl3LMqXbu4KpNBqkmZcCqSl/JbykhneDMeId8clmcdzsajmfJ960T36E6XU4CBUJrEe1FZ4cf
 MPBAH5M12rWvpqVntdnQH+EBg36hsvQ6hsG0BpK0twJ936RBSv+LMs8VV0Vv7Zl4EKPH4H+HIdC
 gmKnqNcqPha7EtYe+26O7P0FYqipFVd5ZFaEkeYDuSBwHWIl+0IRiQiEcbjt6GxMMqycs2Eo9pn
 T9CmDtOQjyN8uIMjtK2+CebhgSoMFnEqEJElDIEhurPahT/GsRPnMsvwz3WsNAMY6JSj+fa/hhx
 nxexDgw6d1G8G5d8m8Yuo9AzFLA0RbWcaewPi1RvZdA2BdqbStpDfdLXLDZI/8CfL8+5zz/GVdL
 p0wjLz3aZ5HqxCw==
X-Developer-Key: i=marcus.folkesson@gmail.com; a=openpgp;
 fpr=AB91D46C7E0F6E6FB2AB640EC0FE25D598F6C127

Add support for 2bit grayscale and use it for XRGB8888 when grayscale is
supported.

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---
 drivers/gpu/drm/sitronix/st7571-i2c.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/sitronix/st7571-i2c.c b/drivers/gpu/drm/sitronix/st7571-i2c.c
index 6a5d719f8b0044ec700ff119972b580c904ffb27..2af800a4c5e4960f3dfcebfeda4554b56015915f 100644
--- a/drivers/gpu/drm/sitronix/st7571-i2c.c
+++ b/drivers/gpu/drm/sitronix/st7571-i2c.c
@@ -215,10 +215,11 @@ static int st7571_send_command_list(struct st7571_device *st7571,
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
@@ -233,7 +234,7 @@ static inline u8 st7571_transform_xy(const char *p, int x, int y)
 
 	for (int i = 0; i < 8; i++) {
 		int row_idx = y + i;
-		u8 byte = p[row_idx * 16 + x];
+		u8 byte = p[row_idx * row_len + x];
 		u8 bit = (byte >> xrest) & 1;
 
 		result |= (bit << i);
@@ -300,11 +301,11 @@ static void st7571_prepare_buffer_grayscale(struct st7571_device *st7571,
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
@@ -330,7 +331,7 @@ static int st7571_fb_update_rect_monochrome(struct drm_framebuffer *fb, struct d
 
 	for (int y = rect->y1; y < rect->y2; y += ST7571_PAGE_HEIGHT) {
 		for (int x = rect->x1; x < rect->x2; x++)
-			row[x] = st7571_transform_xy(st7571->hwbuf, x, y);
+			row[x] = st7571_transform_xy(st7571->hwbuf, x, y, 1);
 
 		st7571_set_position(st7571, rect->x1, y);
 
@@ -355,14 +356,13 @@ static int st7571_fb_update_rect_grayscale(struct drm_framebuffer *fb, struct dr
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
@@ -370,7 +370,7 @@ static int st7571_fb_update_rect_grayscale(struct drm_framebuffer *fb, struct dr
 
 	for (int y = rect->y1; y < rect->y2; y += ST7571_PAGE_HEIGHT) {
 		for (int x = x1; x < x2; x++)
-			row[x] = st7571_transform_xy(st7571->hwbuf, x, y);
+			row[x] = st7571_transform_xy(st7571->hwbuf, x, y, 2);
 
 		st7571_set_position(st7571, rect->x1, y);
 
@@ -391,7 +391,7 @@ static int st7571_fb_update_rect_grayscale(struct drm_framebuffer *fb, struct dr
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


