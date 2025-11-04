Return-Path: <linux-kernel+bounces-885307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A89F1C3290A
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 19:13:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 69D904EE306
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 18:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34500341AC1;
	Tue,  4 Nov 2025 18:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cmXbuBOj"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E67E9340A5A
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 18:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762279817; cv=none; b=lKZnROcUWG2k57EKqBIaMuAAmklfnVA2I4xFT5OCpkV3tiAeJ5WcJ9Q0FVz7TIROF65r8fLezU9D1X/nixgZfhpp9CsyltNW4aNYLafTMxT/nNhuUD6du0UqyzvTDeW8RH5rCYlpATUpg0OKkZLHdH5HjtlV25WHirOC/HJjzeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762279817; c=relaxed/simple;
	bh=eyy7EC4ErwCa3WckkA1iMdTKsrVPw89x2GAqOyAqd+I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kIdR0cke/g5vMhC9FY542QI/OWwbob8fSBqFwkfcCxQIgqMeFb3witKpRh+KVs7k0QcWY6cXydwtX8hT5Ochtq7JN/UA3WWGcpQo1ObvuCah0/+CYluWNbIDJ2OScldLLMSXSm5zMKM6mYwtw+oAOWI/FYoNwPuR2Dlke1vuXpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cmXbuBOj; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-471191ac79dso64631005e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 10:10:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762279813; x=1762884613; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jjm6bAyoMllMD1Q/IvNTNZhpUzj787YRLXUAz9HfQNA=;
        b=cmXbuBOjK6uMxl0pF1py9t4RutNNiIqGB4O4BGSNIDt0nBpLEL3Al448tF006pHrDO
         iWLqUkUAmTNRrr9z++UPh75y+a7U8YMUbBlNhVkBKu1/GEIUN4nhJt07PIGaOyL4o3yr
         uSFJ6oM67afTGFd86gvrRTeozaOu0odaZ+ZGwIvZm9Giw0NnhIZ25CwvgrsuKw8ZJhFF
         YVTQ3EACI+gsQkGRIYre6AgiKDQi+YFfMUCmcJuD6YLjvdNab+b5wbbofB3f6iC9IQo1
         K+7bP0lbpfmT35p4zculnMGuOKUahTSN2nG9w5rCvNZVb3tTWEW3qLAe572/h2GigEXB
         rckw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762279813; x=1762884613;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jjm6bAyoMllMD1Q/IvNTNZhpUzj787YRLXUAz9HfQNA=;
        b=t/rn7+c6znLRpMyjQi8rf8r7h+yl/j9Bq0JspNVyPMyK8Z35S8tOxoQcfr2VhVCCeX
         +/dDfp0V96At9WBn+lAi52ZPcHrFWhZNBQjb8inBxfjWpZynu7UCb+pfuJyvIzOfUceB
         EN0VAEZV7jWPxjoHNGAZwS37DQH3FRLLVjVRS7hL30JHRTLbsokwYTvCDuazgQi87MeM
         O1+wIBj4aEF5Sb5HZVv8P6Wis8CBFPZA0sbdh0dEurr5RQSB72wKrqtnqydl+aK2keZd
         qQzNo0p43irPxF4hXR9+Y4Lp/5Nrso2Ig6b1kMiRFg/DI9ZW23B0wEa1iV46mvsDE7wH
         YXQw==
X-Forwarded-Encrypted: i=1; AJvYcCWPeNeqg+HeyHAxMQFORizTdllIvyRf9wTNam2HW2jkVNPiJ1VctiYd6CVkwRY4nhneqOoRR1Ehi2uAxpc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOdYxDIwVmowLFEeTIW3P4ENR2/s7PCaTWiwP90gVVjP/SuyQ2
	tYcHu7pthUggDll9kH3UgyGYwlPbqRUhwNlCIaofoTWo7sYn4PLz9kLe
X-Gm-Gg: ASbGncveZcvjcH9pIVogfLlJp+11/uRsUgBXHEpYbIzC2Zqj/pc9NF1Itv4y3NAVxRY
	M7pSoM3nCzZTZii9R/NwCtE7FjUFFlCE1I/btdeXw4gq03FGvPapTGNan6c3s8IZVXhbwF3ga3y
	r5NP7SKFET/Q8HMYBT6F52rmEk6IXY+SVDNBuDu+AFEAB38W4/I1NNWefJT+HV0pFMAKmKnQBPv
	6Z1UCkurcYCcpNphACap3YQqdESf7gpB4seFDgxhvEx/8jQePW+yaZkDWZwv20sf7GsU9bZKD7B
	KaJ9T4cjC5z8lPGV1LwLQSHHWNKpUHXWiwWupDKkDLJG0L/5oH97kj6n9EGNhqpX4AfqBSFMzwv
	e8zYMYBSJWD19O/TKXOstKEGeEf8h9QMZ8krL8HApsC4plSzdVQpEwIgypntby1v/nIqVTMNiKl
	TYfwVTTHhE1TWBADZX5WEoXuHS1kb0
X-Google-Smtp-Source: AGHT+IHUjkvK3LuEYexNwytgkWNuB+3vDFUmi2M1K/MsCvY3IVkIm6wl0qrMfqC1Lyu5Q0aWPSh04g==
X-Received: by 2002:a05:600c:a05:b0:475:da1a:5418 with SMTP id 5b1f17b1804b1-4775cdbd551mr2245645e9.1.1762279812965;
        Tue, 04 Nov 2025 10:10:12 -0800 (PST)
Received: from jernej-laptop ([178.79.73.218])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477558c1a03sm24688685e9.2.2025.11.04.10.10.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 10:10:12 -0800 (PST)
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
Subject: [PATCH v2 09/30] drm/sun4i: vi layer: Write attributes in one go
Date: Tue,  4 Nov 2025 19:09:21 +0100
Message-ID: <20251104180942.61538-10-jernej.skrabec@gmail.com>
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

It turns out that none of the VI channel registers were meant to be
read. Mostly it works fine but sometimes it returns incorrect values.

Rework VI layer code to write all registers in one go to avoid reads.

This rework will also allow proper code separation.

Reviewed-by: Chen-Yu Tsai <wens@kernel.org>
Tested-by: Ryan Walklin <ryan@testtoast.com>
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
2.51.2


