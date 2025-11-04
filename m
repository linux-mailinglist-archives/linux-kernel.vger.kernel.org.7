Return-Path: <linux-kernel+bounces-885304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DF29C328EC
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 19:11:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5FF2C4EA331
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 18:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C28B6340261;
	Tue,  4 Nov 2025 18:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U0Y4kWWl"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E84C733F8AB
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 18:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762279812; cv=none; b=qyWZlpvYvI+TpzjO57T/6goHjnpHXW4HHWDkJIIKucLco+l/KA8OqG81LSfeAV+mNKOxvLmfl23Fv2QYMO07TIVJ/fB9WSlzfeXgG00mXhKqSb+FGLCjBtChubk28oQ5w1uK/pQ/7XGK48+3NYEN6p+AcLAlvl3pBr7BI2RZO1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762279812; c=relaxed/simple;
	bh=UMLQniINjUdHSGOyeKlaW/QFkXzdQJ8JOe+PvNsMFsM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h5GH8B8NCP9eELkPNUvA60u1eE//civ+oS2kzyS25TBM+TqM5ERgrhyYaJ7YrjQMMKlIhAGYt24JVGU6d9tCXkSoT/mItiY1D2Ca8XoAugalwjzCkJiefu02fme0ilHYBlq+vOjsIj6emCDu0E+uu+4SrqxMPYajaOmuiZpa28U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U0Y4kWWl; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4711b95226dso75722655e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 10:10:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762279809; x=1762884609; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9UxxEnvD5E7Y1WhJtD+AnEMx6VMSP1mmylf6BBTY00A=;
        b=U0Y4kWWlkLG96+xJrOkLAo+nIWH8iViG/aYh9lqzr0g4euqqC7MSFUW2l1tpOVeI5f
         iWoB+mu8drcxIkCXNUocv/gdpHdjkqWsWmnLehnqA9HMB/BbmEG61zDpcWFXC1Kytsxj
         a5s0REM+zkA5hOHUCqI3gYiZqYHcjOxh2FTusq9kqsQn0xsMPPfpmt29Q5r9RWjwzNDn
         z3TRH0fgXhXk7Q7XmXxo3LmCjXC82iuQ+0a0YrMOG52d3l95EtW1ff+DjxvuNmqc6FuJ
         Uj2TpaG2YcK8YTL4HOZCXw2lMPwjRmsFhB3OuiYZCx65N1kH+8rnzA++9nLyxt5a8LvX
         wokQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762279809; x=1762884609;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9UxxEnvD5E7Y1WhJtD+AnEMx6VMSP1mmylf6BBTY00A=;
        b=iKfRqM7gZAOMIRZr+ymumj0j3mqIYeUUJU6xIHfozHBKWYxcEO1xO753ciLbAJvjeS
         1hsjC7fAIMx8Wbx5mC+Ki6PBT6ZVychDo5Tdh9EH0Dq+cxB4e8vDJJlYytWQcG7sZP9q
         iy2mrGYM4lsLtrCA8F6/etYoM0QU8wAz0Rx4jgdJkMXgPgJ+HEOZoXd7r+zKCuQ4oS3M
         AdvPUec9hSwoT9s0ytdo6DGtIwrEQ4HAstruXm6Wy46MmjMYDffqAX+f3ojNUdnkJUIO
         OJeePJdxPy4eghtDJ0wfPPcY0q15iExFbrAEGayH1LhRO3ulpUszHhLDdP2F3JkPm6rr
         zgZg==
X-Forwarded-Encrypted: i=1; AJvYcCWHVtERg7FtcYSnYdjNEPA4ZdpG1xoPINeYKhcYl4r+THh3dMqkLvcNx4YgXO/CBaQGdPsVHmtfI9ILd00=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQsCeS5B5r6QXMnnTDU1KPhNmJhLf2rlGkoNFa8zC6KNfaVzE4
	cHrhRmt5ObLhFGTH9t66DYLq8Q8oUFmpJLEHIfGtmQ/eArLie9X84mAh
X-Gm-Gg: ASbGncvOIlBuztgYRzuWc+EVB+GnU2Lc33tawb94kgb8ukQlAEQhlL1RKCh0i8s6JaC
	3rMFAmOaFc+DJNvHh9jR1nYwf5XGANYmwGxzFM3tYt3Tndpm2u6LJ2xi059pUJ1Fh7TemFTs9vt
	Si/aWr/8xrV9H3dBL2C3KqyQdQqyl647yLgAIAdyGxXmK8T631NavhzzpLyoJRFBbRrPQoFYPme
	fQmCVKbCC/GKvtXxaQB8/Qr5/jxAZRk/ECB73an2F2pmxSKFsIpars6KHR0IFg6wYbtNj+6y4C3
	q04+u8531LsNHbnOgE6rcsAoBeHtacEOfF7HpiKXqAr90dfQzKLstu/pxVNOOwVZHKXUz6aqwDA
	0SahSJjIesoEWnyTET7k29/EDPcJZIHE1QSixbj3sa95EqM66qSmtBnK9R5hsbOC7pcGrrJuAly
	UskiC1bMaK8KTdwXrNKw==
X-Google-Smtp-Source: AGHT+IEJHAiuBYWEtNzJWv6C7uhRnDsBy6FovSk1I1qNjU8+nmp3MeD3eeYgDnF9LcKCHm1OTcNSBg==
X-Received: by 2002:a05:600c:530d:b0:477:55ce:f3c2 with SMTP id 5b1f17b1804b1-4775cdc5874mr2504965e9.14.1762279809223;
        Tue, 04 Nov 2025 10:10:09 -0800 (PST)
Received: from jernej-laptop ([178.79.73.218])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477558c1a03sm24688685e9.2.2025.11.04.10.10.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 10:10:08 -0800 (PST)
From: Jernej Skrabec <jernej.skrabec@gmail.com>
To: wens@csie.org
Cc: mripard@kernel.org,
	maarten.lankhorst@linux.intel.com,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	samuel@sholland.org,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Ryan Walklin <ryan@testtoast.com>
Subject: [PATCH v2 06/30] drm/sun4i: layers: Make atomic commit functions void
Date: Tue,  4 Nov 2025 19:09:18 +0100
Message-ID: <20251104180942.61538-7-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251104180942.61538-1-jernej.skrabec@gmail.com>
References: <20251104180942.61538-1-jernej.skrabec@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Functions called by atomic_commit callback should not fail. None of them
actually returns error, so make them void.

No functional change.

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
Tested-by: Ryan Walklin <ryan@testtoast.com>
Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 drivers/gpu/drm/sun4i/sun8i_ui_layer.c | 20 +++++++-------------
 drivers/gpu/drm/sun4i/sun8i_vi_layer.c | 20 +++++++-------------
 2 files changed, 14 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun8i_ui_layer.c b/drivers/gpu/drm/sun4i/sun8i_ui_layer.c
index fce7b265c5d8..8baa1d0b53bd 100644
--- a/drivers/gpu/drm/sun4i/sun8i_ui_layer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_ui_layer.c
@@ -46,9 +46,9 @@ static void sun8i_ui_layer_update_alpha(struct sun8i_mixer *mixer, int channel,
 			   mask, val);
 }
 
-static int sun8i_ui_layer_update_coord(struct sun8i_mixer *mixer, int channel,
-				       int overlay, struct drm_plane *plane,
-				       unsigned int zpos)
+static void sun8i_ui_layer_update_coord(struct sun8i_mixer *mixer, int channel,
+					int overlay, struct drm_plane *plane,
+					unsigned int zpos)
 {
 	struct drm_plane_state *state = plane->state;
 	u32 src_w, src_h, dst_w, dst_h;
@@ -124,12 +124,10 @@ static int sun8i_ui_layer_update_coord(struct sun8i_mixer *mixer, int channel,
 	regmap_write(bld_regs,
 		     SUN8I_MIXER_BLEND_ATTR_INSIZE(bld_base, zpos),
 		     outsize);
-
-	return 0;
 }
 
-static int sun8i_ui_layer_update_formats(struct sun8i_mixer *mixer, int channel,
-					 int overlay, struct drm_plane *plane)
+static void sun8i_ui_layer_update_formats(struct sun8i_mixer *mixer, int channel,
+					  int overlay, struct drm_plane *plane)
 {
 	struct drm_plane_state *state = plane->state;
 	const struct drm_format_info *fmt;
@@ -144,12 +142,10 @@ static int sun8i_ui_layer_update_formats(struct sun8i_mixer *mixer, int channel,
 	regmap_update_bits(mixer->engine.regs,
 			   SUN8I_MIXER_CHAN_UI_LAYER_ATTR(ch_base, overlay),
 			   SUN8I_MIXER_CHAN_UI_LAYER_ATTR_FBFMT_MASK, val);
-
-	return 0;
 }
 
-static int sun8i_ui_layer_update_buffer(struct sun8i_mixer *mixer, int channel,
-					int overlay, struct drm_plane *plane)
+static void sun8i_ui_layer_update_buffer(struct sun8i_mixer *mixer, int channel,
+					 int overlay, struct drm_plane *plane)
 {
 	struct drm_plane_state *state = plane->state;
 	struct drm_framebuffer *fb = state->fb;
@@ -184,8 +180,6 @@ static int sun8i_ui_layer_update_buffer(struct sun8i_mixer *mixer, int channel,
 	regmap_write(mixer->engine.regs,
 		     SUN8I_MIXER_CHAN_UI_LAYER_TOP_LADDR(ch_base, overlay),
 		     lower_32_bits(dma_addr));
-
-	return 0;
 }
 
 static int sun8i_ui_layer_atomic_check(struct drm_plane *plane,
diff --git a/drivers/gpu/drm/sun4i/sun8i_vi_layer.c b/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
index c80bdece5ffc..dae6f83cea6e 100644
--- a/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
@@ -48,9 +48,9 @@ static void sun8i_vi_layer_update_alpha(struct sun8i_mixer *mixer, int channel,
 	}
 }
 
-static int sun8i_vi_layer_update_coord(struct sun8i_mixer *mixer, int channel,
-				       int overlay, struct drm_plane *plane,
-				       unsigned int zpos)
+static void sun8i_vi_layer_update_coord(struct sun8i_mixer *mixer, int channel,
+					int overlay, struct drm_plane *plane,
+					unsigned int zpos)
 {
 	struct drm_plane_state *state = plane->state;
 	const struct drm_format_info *format = state->fb->format;
@@ -191,8 +191,6 @@ static int sun8i_vi_layer_update_coord(struct sun8i_mixer *mixer, int channel,
 	regmap_write(bld_regs,
 		     SUN8I_MIXER_BLEND_ATTR_INSIZE(bld_base, zpos),
 		     outsize);
-
-	return 0;
 }
 
 static u32 sun8i_vi_layer_get_csc_mode(const struct drm_format_info *format)
@@ -211,8 +209,8 @@ static u32 sun8i_vi_layer_get_csc_mode(const struct drm_format_info *format)
 	}
 }
 
-static int sun8i_vi_layer_update_formats(struct sun8i_mixer *mixer, int channel,
-					 int overlay, struct drm_plane *plane)
+static void sun8i_vi_layer_update_formats(struct sun8i_mixer *mixer, int channel,
+					  int overlay, struct drm_plane *plane)
 {
 	struct drm_plane_state *state = plane->state;
 	u32 val, ch_base, csc_mode, hw_fmt;
@@ -246,12 +244,10 @@ static int sun8i_vi_layer_update_formats(struct sun8i_mixer *mixer, int channel,
 	regmap_update_bits(mixer->engine.regs,
 			   SUN8I_MIXER_CHAN_VI_LAYER_ATTR(ch_base, overlay),
 			   SUN8I_MIXER_CHAN_VI_LAYER_ATTR_RGB_MODE, val);
-
-	return 0;
 }
 
-static int sun8i_vi_layer_update_buffer(struct sun8i_mixer *mixer, int channel,
-					int overlay, struct drm_plane *plane)
+static void sun8i_vi_layer_update_buffer(struct sun8i_mixer *mixer, int channel,
+					 int overlay, struct drm_plane *plane)
 {
 	struct drm_plane_state *state = plane->state;
 	struct drm_framebuffer *fb = state->fb;
@@ -305,8 +301,6 @@ static int sun8i_vi_layer_update_buffer(struct sun8i_mixer *mixer, int channel,
 								 overlay, i),
 			     lower_32_bits(dma_addr));
 	}
-
-	return 0;
 }
 
 static int sun8i_vi_layer_atomic_check(struct drm_plane *plane,
-- 
2.51.2


