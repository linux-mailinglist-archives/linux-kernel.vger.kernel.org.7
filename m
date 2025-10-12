Return-Path: <linux-kernel+bounces-849699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 73E55BD0B66
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 21:25:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9261C3479AD
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 19:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C0E12F7463;
	Sun, 12 Oct 2025 19:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mu+Y2JKc"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0FC2F60B6
	for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 19:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760297034; cv=none; b=GsFL1OGBYW4mcHzpQgUOZtarCe/tTfR4uBrj5Umtayvfu5lLnN5q1UQigqUbZ81wSMTo3YlcRX/bHoTJ6xfMGwoicfo21QvyVeAgXvwAK5sRGryGR7mmVv6en78PNQc8SHtmjYZFs51xCX23mDh7JLHkdVNy6muJQNscLVJB51A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760297034; c=relaxed/simple;
	bh=aUmmA0K5M3pKV/DONNVTH0LdjYjNZicMZg+Z8mCeaio=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lj+t+3rUYgDuFtMlXDMh9Wsx265vVb1ymQMOk6fYShZ3BtBANQ6gUOjBlhMlB4gO87wJVcvY6MGVW43HA7m2Y8dHjdmihvcsg77BO3NS5K0O1J06++dSOZ/khaHqahvMHbrUvfHAHFRt0JsTT1QM5qTvUnFl5udiDxsRiEA2oRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mu+Y2JKc; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b3b27b50090so653285166b.0
        for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 12:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760297031; x=1760901831; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4j2gKZWvQ3G/p6x29ljxN7hGavAjse3Wea8WQURA1i4=;
        b=mu+Y2JKc39vr9cqEuIU8L0Hn57TUq3MfAzekdPXqKnc73ELwZW3khXcD5N6OLs5beO
         d+4ggT/vy9osnRnAVje/HFUBSWGYgc+kU8C+pDAsI06N1vjUxCyb57KUzXaQsahPSMvB
         SJ/WbKEy/V3iCA96ckdliQ6dL9V4l8m93HHTe9+q9O9fhEvvpXjiRYfW85Y7zrnZBDOP
         kKNPPd9pE/J+hz1Y4+xM6PhAHm0i3/R28CTl2T0KVdKafeV4CYxdadLeN0MdalOqLM7S
         QZBKZelMbaSNtZUMUXqa4bcsD9VD1UHhKtOJx31M7PV2EDywKCU188UBFB/PqZgziw9z
         Popg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760297031; x=1760901831;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4j2gKZWvQ3G/p6x29ljxN7hGavAjse3Wea8WQURA1i4=;
        b=QHNgQmAozUVqyMjjiI+Y+u7CFrnk+I3Jtu/sUOKuak25Mj/dvVLVY/U4ZVk+/QJcjE
         O/F1M8KzKQkQoufbW98FPKBse4Rey48/e6jZONtvYD3QamYaj1y+TWgN3yZ6F6WlmMcr
         JuViXd+8J/Q3Pq7aQYOtI4wan/n/A0YUviEAmmQLPWILCKujDQO7owCzwGmZmFUNYokL
         6OLWbvG0RRCzbu5R2wUo3cVviwrNZyZsfzU+T5m4ZEy1Scn3hvf26buIqWjXP/UoczeP
         vxtwO6YUdmdiOBFmU2GQXBqSK3d0fBRUan0+bp0/MQGiGcG+A7Q2uW77z04ZvBBuvH5l
         JpZw==
X-Forwarded-Encrypted: i=1; AJvYcCVtO4JPxz434KouHavr7MVzvzwm+ThAeKLqL0+1tmjFMLoy/X220qkKUa8p2ua4RkjoH4GgkCSWArOUkLk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjrAUe300rmUSVNxHTIDwZncPW8GSQrhvzMp4rzxhtQ9gCZL+e
	Gob5PUNe2glktvhKXkvhfVWKr3oHJgWF8ZywIcg2JP4aXKQmfSh/5rAm
X-Gm-Gg: ASbGncs+ESeMfYFHyNYEkROUaqEGL7uYN5e5kvCfIS2IBfn64caL1nNAOK8EjLOu0dq
	7/exP0MdkyeB0QdZqKAItIXYYGW2EFIZM0A0ldbs4vcayypjhxW58fySKI+ktbK4A+dZpDTVWip
	UQAN0qVRnkgvqScdZBokxaG3Zbzev62Ed8qqufa6D5QuwjW541wwIdM9ObIx4HFhShAbCv+A7JP
	jLej5yik76ZfISUAs0zAD/1ybmu4lNjXkaR4ojpFInQscun50F6cqb35p9MFeQyy5/jXTDpa+gz
	rEBBRKjNroTDK/FkOTYLd9T3Rja9hJoouKaUYk9q1p/y0SDurr+XFho/FSiCPae1FHSZFCEPivs
	mkBI4h3l9CLSHlWMn24uC2qIjVr8jJ9oRtfS+2d7aEMMduJyWQsVctDz2LAOo4vX16SYkEbaLi7
	BmE6JEmAfJ18jkWkk771c9wIeHqAXxcMMrr+jE15VY6Q==
X-Google-Smtp-Source: AGHT+IEs/WFctDa89+D/WqWhY5uZ3WvAavRVXRQFM/TxuoPg9kA4sKepU26nxFXJKsHh5KgVUQFpfg==
X-Received: by 2002:a17:907:724a:b0:b04:5b0a:5850 with SMTP id a640c23a62f3a-b50ac1c3f18mr2033310866b.40.1760297030814;
        Sun, 12 Oct 2025 12:23:50 -0700 (PDT)
Received: from jernej-laptop (178-79-73-218.dynamic.telemach.net. [178.79.73.218])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b55d67d8283sm760176466b.38.2025.10.12.12.23.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Oct 2025 12:23:50 -0700 (PDT)
From: Jernej Skrabec <jernej.skrabec@gmail.com>
To: mripard@kernel.org,
	wens@csie.org
Cc: maarten.lankhorst@linux.intel.com,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	samuel@sholland.org,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH 09/30] drm/sun4i: vi layer: Write attributes in one go
Date: Sun, 12 Oct 2025 21:23:09 +0200
Message-ID: <20251012192330.6903-10-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251012192330.6903-1-jernej.skrabec@gmail.com>
References: <20251012192330.6903-1-jernej.skrabec@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It turns out that none of the VI channel registers were meant to be
read. Mostly it works fine but sometimes it returns incorrect values.

Rework VI layer code to write all registers in one go to avoid reads.

This rework will also allow proper code separation.

Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 drivers/gpu/drm/sun4i/sun8i_vi_layer.c | 71 ++++++++++----------------
 1 file changed, 27 insertions(+), 44 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun8i_vi_layer.c b/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
index 1f4fa63ef153..dcc4429368d6 100644
--- a/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
@@ -18,34 +18,35 @@
 #include "sun8i_vi_layer.h"
 #include "sun8i_vi_scaler.h"
 
-static void sun8i_vi_layer_update_alpha(struct sun8i_mixer *mixer, int channel,
-					int overlay, struct drm_plane *plane)
+static void sun8i_vi_layer_update_attributes(struct sun8i_mixer *mixer,
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
 
+	val = hw_fmt << SUN8I_MIXER_CHAN_VI_LAYER_ATTR_FBFMT_OFFSET;
+	if (!fmt->is_yuv)
+		val |= SUN8I_MIXER_CHAN_VI_LAYER_ATTR_RGB_MODE;
+	val |= SUN8I_MIXER_CHAN_VI_LAYER_ATTR_EN;
 	if (mixer->cfg->de_type >= SUN8I_MIXER_DE3) {
-		mask = SUN50I_MIXER_CHAN_VI_LAYER_ATTR_ALPHA_MASK |
-		       SUN50I_MIXER_CHAN_VI_LAYER_ATTR_ALPHA_MODE_MASK;
-		val = SUN50I_MIXER_CHAN_VI_LAYER_ATTR_ALPHA
-			(plane->state->alpha >> 8);
-
-		val |= (plane->state->alpha == DRM_BLEND_ALPHA_OPAQUE) ?
+		val |= SUN50I_MIXER_CHAN_VI_LAYER_ATTR_ALPHA(state->alpha >> 8);
+		val |= (state->alpha == DRM_BLEND_ALPHA_OPAQUE) ?
 			SUN50I_MIXER_CHAN_VI_LAYER_ATTR_ALPHA_MODE_PIXEL :
 			SUN50I_MIXER_CHAN_VI_LAYER_ATTR_ALPHA_MODE_COMBINED;
-
-		regmap_update_bits(mixer->engine.regs,
-				   SUN8I_MIXER_CHAN_VI_LAYER_ATTR(ch_base,
-								  overlay),
-				   mask, val);
 	} else if (mixer->cfg->vi_num == 1) {
-		regmap_update_bits(mixer->engine.regs,
-				   SUN8I_MIXER_FCC_GLOBAL_ALPHA_REG,
-				   SUN8I_MIXER_FCC_GLOBAL_ALPHA_MASK,
-				   SUN8I_MIXER_FCC_GLOBAL_ALPHA
-					(plane->state->alpha >> 8));
+		regmap_write(mixer->engine.regs,
+			     SUN8I_MIXER_FCC_GLOBAL_ALPHA_REG,
+			     SUN8I_MIXER_FCC_GLOBAL_ALPHA(state->alpha >> 8));
 	}
+
+	regmap_write(mixer->engine.regs,
+		     SUN8I_MIXER_CHAN_VI_LAYER_ATTR(ch_base, overlay), val);
 }
 
 static void sun8i_vi_layer_update_coord(struct sun8i_mixer *mixer, int channel,
@@ -194,23 +195,14 @@ static u32 sun8i_vi_layer_get_csc_mode(const struct drm_format_info *format)
 	}
 }
 
-static void sun8i_vi_layer_update_formats(struct sun8i_mixer *mixer, int channel,
-					  int overlay, struct drm_plane *plane)
+static void sun8i_vi_layer_update_colors(struct sun8i_mixer *mixer, int channel,
+					 int overlay, struct drm_plane *plane)
 {
 	struct drm_plane_state *state = plane->state;
-	u32 val, ch_base, csc_mode, hw_fmt;
 	const struct drm_format_info *fmt;
-
-	ch_base = sun8i_channel_base(mixer, channel);
+	u32 csc_mode;
 
 	fmt = state->fb->format;
-	sun8i_mixer_drm_format_to_hw(fmt->format, &hw_fmt);
-
-	val = hw_fmt << SUN8I_MIXER_CHAN_VI_LAYER_ATTR_FBFMT_OFFSET;
-	regmap_update_bits(mixer->engine.regs,
-			   SUN8I_MIXER_CHAN_VI_LAYER_ATTR(ch_base, overlay),
-			   SUN8I_MIXER_CHAN_VI_LAYER_ATTR_FBFMT_MASK, val);
-
 	csc_mode = sun8i_vi_layer_get_csc_mode(fmt);
 	if (csc_mode != SUN8I_CSC_MODE_OFF) {
 		sun8i_csc_set_ccsc_coefficients(mixer, channel, csc_mode,
@@ -220,15 +212,6 @@ static void sun8i_vi_layer_update_formats(struct sun8i_mixer *mixer, int channel
 	} else {
 		sun8i_csc_enable_ccsc(mixer, channel, false);
 	}
-
-	if (!fmt->is_yuv)
-		val = SUN8I_MIXER_CHAN_VI_LAYER_ATTR_RGB_MODE;
-	else
-		val = 0;
-
-	regmap_update_bits(mixer->engine.regs,
-			   SUN8I_MIXER_CHAN_VI_LAYER_ATTR(ch_base, overlay),
-			   SUN8I_MIXER_CHAN_VI_LAYER_ATTR_RGB_MODE, val);
 }
 
 static void sun8i_vi_layer_update_buffer(struct sun8i_mixer *mixer, int channel,
@@ -340,12 +323,12 @@ static void sun8i_vi_layer_atomic_update(struct drm_plane *plane,
 	if (!new_state->crtc || !new_state->visible)
 		return;
 
+	sun8i_vi_layer_update_attributes(mixer, layer->channel,
+					 layer->overlay, plane);
 	sun8i_vi_layer_update_coord(mixer, layer->channel,
 				    layer->overlay, plane);
-	sun8i_vi_layer_update_alpha(mixer, layer->channel,
-				    layer->overlay, plane);
-	sun8i_vi_layer_update_formats(mixer, layer->channel,
-				      layer->overlay, plane);
+	sun8i_vi_layer_update_colors(mixer, layer->channel,
+				     layer->overlay, plane);
 	sun8i_vi_layer_update_buffer(mixer, layer->channel,
 				     layer->overlay, plane);
 }
-- 
2.51.0


