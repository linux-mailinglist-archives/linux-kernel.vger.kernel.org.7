Return-Path: <linux-kernel+bounces-885306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 979B1C32904
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 19:12:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC743463CDE
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 18:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BC75340DB0;
	Tue,  4 Nov 2025 18:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nnAXxZXt"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 762D333FE2B
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 18:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762279815; cv=none; b=iZ0l5GBuOHAyiXfH58qWoCpLOdTWy89xg9PcRZeJaDvfhoctQkzG1IWvmRdCxBz+qsnsjhyWSOkl0sIDpgn1qoqaNiYj2niaILW2KrrrgiQ08xlGYb8Iq9XEHSPw//8lHZt+1/Qw91ESNU/OGMe5GWpFTalxbkqQlseT/uUxtfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762279815; c=relaxed/simple;
	bh=iGnNI0++SonwGyedd4a7sun41aecxIvT8MUtouuGC4I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L3JqlEtcck6Ar5H3hJPmG+asYFfsXmhBO6izLpabMeul8SH/hVbA9lkjysGDNRkyVxRXVff6A1TwgF+Z1G1hYmJDE+Wb73jbktmpXTEKLxZ2fJNedbqpbPs7b6+aWLTgj8jy4BXabszj/7V1wzyaY4LzYom2Samhq4Zz0K/xR20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nnAXxZXt; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4711810948aso41623845e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 10:10:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762279812; x=1762884612; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2V+kePNpXO72CJenp34f7uw6E8+eMdcIi2DhwUlA3KQ=;
        b=nnAXxZXtIxxPzqzRI3ZBAbTp73sbVl9UHZ1qvBqb0YbJzW++ueLCbVD1+k+TwQd2kw
         fcOjR5rn5T12FbA9bAF1KAQKCn22NqLLsHxkY5LiCGwIJqNpTeFj+DIxXM2ZpKvA3xX7
         gfj/4xQ97/YiO8P9Ay0J2SKMhZoGYKSZBfFm36a/w0C1+jH19MuwvOpgdzjJLYux22Ts
         ndR+iE9GvrFpWWdaAnNcOjO4JiuTOzIfI1fhuJZYONePM61RM+DgMu6zwuu0q/gmOO1S
         yofyGSpQ1g2sF2DpCnKY9BGgeZ1jXx6yF4hZq4jYwRSiOZPXl3N0DgGp5YdWn3cy7p5z
         CFxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762279812; x=1762884612;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2V+kePNpXO72CJenp34f7uw6E8+eMdcIi2DhwUlA3KQ=;
        b=vj202ZkX696kSVMur8lElF0SNZy0Nk18W/2KXQl7hd+g+eqSCtr9jsRA1q0T57r98W
         I2iIASmpqMJarh4GB5Y9oOr5Tk9chdzbWfEPIwmhKLQT6cZXgRjupix1B+g4XsQiW/t6
         lpFnR7gn8HyxEws+Bhn65K5jp2g6EP6NzbwRZjjS6IZ4Bnj3dqJR4Yvqujhd2l54voAD
         LzbR6kACeIAgr4MARJt06oXQKliomjUpuJmkVS7ASfB46UCwjnnA3gD+HZ8v3pm0KCfN
         n1Cn8KcxmIC9EvBpDcKtesoN7xWK//INXZM+UGPnlA0WIWOMT5vRcaRfaHxR64edCorR
         dNOg==
X-Forwarded-Encrypted: i=1; AJvYcCV29+o3A8XN93q7xympzYi7aw3lUsOH9TcOfnw/vNE+3tVmsGxeZwD94BBzpZLRAlGZDK3yhRXeFcoISMM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKNquyTG6J7rx/N/54Kpz5izjkX7WCeNvXuLaKXlKSOavfbQhe
	7Y61oboAXe2+j5xTJ5GEzBBxuGSRUJQMjZ9sZijjDF5zyY6O5VVkl8pI
X-Gm-Gg: ASbGncu4eWhsSQgQJWx9uqnosqlQ3v9taSHI/GynOqxraIYSHxM9ZLjPnUqOwR5HzF3
	7ohV/71h2QfoV8qkPhDgpu0qTsQmb8Dw8yet8UXHMnQDfW401rNlYVqg1IcjxNboPGKI0AxLNPf
	Q+TnAFODvGXVbE6PgtfeRxwKrH5VUYln+qUXyTJDq9eIrrEzOByP1naGigSSVxuZScWaEln+0a+
	TEkkOF2MXHu91d1o8g0tGPkGkFm2j/C7js0vPXEYjCZpExkfIuTpfixWBGa/sbf6qE0PBRnMMjY
	n/AJGc6mlwv9PrRxNer+sYK+2Z4baUpM1Nai1ISN8/qUwlGAOGPQrSVNFLZLCXkT+ukyJAtkzPw
	Zzb2t9SxDzoIyqDorwPtrvIwNVgLUc7T5ySKOveCjoff9UIlEiI1umzlyR14hsEFxUepERaTLCg
	c875+Td/JeXllsoTFGRw==
X-Google-Smtp-Source: AGHT+IFZg22fNOBq2/+K7yxgA1ojsJmdSdVgUH3x4JG8OH5BRdNvWipWSBISKSpBHgCgvYmvB7tQTA==
X-Received: by 2002:a05:600c:6990:b0:475:de68:3c28 with SMTP id 5b1f17b1804b1-4775cdad710mr2567035e9.8.1762279811690;
        Tue, 04 Nov 2025 10:10:11 -0800 (PST)
Received: from jernej-laptop ([178.79.73.218])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477558c1a03sm24688685e9.2.2025.11.04.10.10.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 10:10:11 -0800 (PST)
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
	Chen-Yu Tsai <wens@kernel.org>,
	Ryan Walklin <ryan@testtoast.com>
Subject: [PATCH v2 08/30] drm/sun4i: ui layer: Write attributes in one go
Date: Tue,  4 Nov 2025 19:09:20 +0100
Message-ID: <20251104180942.61538-9-jernej.skrabec@gmail.com>
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

It turns out that none of the UI channel registers were meant to be
read. Mostly it works fine but sometimes it returns incorrect values.

Rework UI layer code to write all registers in one go to avoid reads.

This rework will also allow proper code separation.

Reviewed-by: Chen-Yu Tsai <wens@kernel.org>
Tested-by: Ryan Walklin <ryan@testtoast.com>
Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 drivers/gpu/drm/sun4i/sun8i_ui_layer.c | 50 +++++++++-----------------
 1 file changed, 16 insertions(+), 34 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun8i_ui_layer.c b/drivers/gpu/drm/sun4i/sun8i_ui_layer.c
index 12c83c54f9bc..8634d2ee613a 100644
--- a/drivers/gpu/drm/sun4i/sun8i_ui_layer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_ui_layer.c
@@ -25,25 +25,27 @@
 #include "sun8i_ui_scaler.h"
 #include "sun8i_vi_scaler.h"
 
-static void sun8i_ui_layer_update_alpha(struct sun8i_mixer *mixer, int channel,
-					int overlay, struct drm_plane *plane)
+static void sun8i_ui_layer_update_attributes(struct sun8i_mixer *mixer,
+					     int channel, int overlay,
+					     struct drm_plane *plane)
 {
-	u32 mask, val, ch_base;
+	struct drm_plane_state *state = plane->state;
+	const struct drm_format_info *fmt;
+	u32 val, ch_base, hw_fmt;
 
 	ch_base = sun8i_channel_base(mixer, channel);
+	fmt = state->fb->format;
+	sun8i_mixer_drm_format_to_hw(fmt->format, &hw_fmt);
 
-	mask = SUN8I_MIXER_CHAN_UI_LAYER_ATTR_ALPHA_MODE_MASK |
-		SUN8I_MIXER_CHAN_UI_LAYER_ATTR_ALPHA_MASK;
-
-	val = SUN8I_MIXER_CHAN_UI_LAYER_ATTR_ALPHA(plane->state->alpha >> 8);
-
-	val |= (plane->state->alpha == DRM_BLEND_ALPHA_OPAQUE) ?
+	val = SUN8I_MIXER_CHAN_UI_LAYER_ATTR_ALPHA(state->alpha >> 8);
+	val |= (state->alpha == DRM_BLEND_ALPHA_OPAQUE) ?
 		SUN8I_MIXER_CHAN_UI_LAYER_ATTR_ALPHA_MODE_PIXEL :
 		SUN8I_MIXER_CHAN_UI_LAYER_ATTR_ALPHA_MODE_COMBINED;
+	val |= hw_fmt << SUN8I_MIXER_CHAN_UI_LAYER_ATTR_FBFMT_OFFSET;
+	val |= SUN8I_MIXER_CHAN_UI_LAYER_ATTR_EN;
 
-	regmap_update_bits(mixer->engine.regs,
-			   SUN8I_MIXER_CHAN_UI_LAYER_ATTR(ch_base, overlay),
-			   mask, val);
+	regmap_write(mixer->engine.regs,
+		     SUN8I_MIXER_CHAN_UI_LAYER_ATTR(ch_base, overlay), val);
 }
 
 static void sun8i_ui_layer_update_coord(struct sun8i_mixer *mixer, int channel,
@@ -111,24 +113,6 @@ static void sun8i_ui_layer_update_coord(struct sun8i_mixer *mixer, int channel,
 	}
 }
 
-static void sun8i_ui_layer_update_formats(struct sun8i_mixer *mixer, int channel,
-					  int overlay, struct drm_plane *plane)
-{
-	struct drm_plane_state *state = plane->state;
-	const struct drm_format_info *fmt;
-	u32 val, ch_base, hw_fmt;
-
-	ch_base = sun8i_channel_base(mixer, channel);
-
-	fmt = state->fb->format;
-	sun8i_mixer_drm_format_to_hw(fmt->format, &hw_fmt);
-
-	val = hw_fmt << SUN8I_MIXER_CHAN_UI_LAYER_ATTR_FBFMT_OFFSET;
-	regmap_update_bits(mixer->engine.regs,
-			   SUN8I_MIXER_CHAN_UI_LAYER_ATTR(ch_base, overlay),
-			   SUN8I_MIXER_CHAN_UI_LAYER_ATTR_FBFMT_MASK, val);
-}
-
 static void sun8i_ui_layer_update_buffer(struct sun8i_mixer *mixer, int channel,
 					 int overlay, struct drm_plane *plane)
 {
@@ -220,12 +204,10 @@ static void sun8i_ui_layer_atomic_update(struct drm_plane *plane,
 	if (!new_state->crtc || !new_state->visible)
 		return;
 
+	sun8i_ui_layer_update_attributes(mixer, layer->channel,
+					 layer->overlay, plane);
 	sun8i_ui_layer_update_coord(mixer, layer->channel,
 				    layer->overlay, plane);
-	sun8i_ui_layer_update_alpha(mixer, layer->channel,
-				    layer->overlay, plane);
-	sun8i_ui_layer_update_formats(mixer, layer->channel,
-				      layer->overlay, plane);
 	sun8i_ui_layer_update_buffer(mixer, layer->channel,
 				     layer->overlay, plane);
 }
-- 
2.51.2


