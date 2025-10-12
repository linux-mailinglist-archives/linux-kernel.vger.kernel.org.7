Return-Path: <linux-kernel+bounces-849698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F574BD0B63
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 21:25:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 597FA4EAC53
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 19:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 688182F6176;
	Sun, 12 Oct 2025 19:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VVI/UJK+"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D672F549C
	for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 19:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760297032; cv=none; b=gL67qcYds2OoL4AZU5W5fVa0qQyig8dbnj9DZP+ZT96sP4/lCP8S1okRG8bdxjPVd2pZWWDoLYet0mS3ODldSSiokANGMxmaP9ECd9cniPpCtP8mCUaMbSrr5juo7cgM/hYNtQz84qD/tkDae6smdo6xh6aR4NsB0Nn40sQxHWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760297032; c=relaxed/simple;
	bh=5DSQADF6PYceeHGtb5MtZGmBEcXfqbbawxpIMOZcwi4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jm0EaNbxCTdOFkCi+LDy9nmP02pRMMD6PsXNGYtTgcTYU1Ztvj5n5wf2ZJPz77xmx7fyFjBFwjnfjPVpxRT1v6dSE2OUYrPd80Y0FGRYEzjDF4qvRXGpLGDj0t6fACu9LgWp9JBAR7JA71mmJlBF1Msi7bdNQz0DLo5KFXS2AEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VVI/UJK+; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-639df8d869fso6717842a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 12:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760297029; x=1760901829; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S9SmCp0RhICJrtT3B0EVlMoJ5KkuRntCLc/b84MPeMA=;
        b=VVI/UJK+L54hXF6ysdizD+bKxKxDlLObUdUVAxafbSIJQgbI+2GFwjoTPjRRNicp5d
         /nOGUTt/FoNFU8Df0ZY/qJmOFVgo6qrmEvIz+YbDNgy+epDl5wj79mh7L4jwCvBjGZqo
         EXZGHsI0mqlhA9FWUCe2+zFd+BXd9DHM3Qql6p5Yl6oUzpENNZ2tZDbNWOLS3v7q4toW
         U5D8h+QoXPnkl1QTnBge8pv4advm/a41/uv+t8XU7id01+WMF1IfJHAO6wvR+cEWtVgO
         unxmmRSz7Y/YnCqJsZ2HxOnD1DEmuiIkDYglaGMzxo38c5YZMa8TTv2YaR1Fd0Fa2B5t
         XoqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760297029; x=1760901829;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S9SmCp0RhICJrtT3B0EVlMoJ5KkuRntCLc/b84MPeMA=;
        b=qCkcZ5kdr4AsBpjlJ+RyaRxc0+pBjtuDHiKp78BTU24uwYzQiTjrHfeOhO1g1YqKF9
         thPcugOExG0QcIYVW9Wbfr97adDc84ffv3ONcJLikEt3LItnl5ODF3bE/MYfSV5sYZBn
         qjhfnZgWMepSPuvwRbbi8jk4Q8V/aeMedaNWx2pEwR67jqnqQpN3m100Qz4S0eOhEitj
         3v0aJ1u7ovKqdTElcQOTqxzNQwfnbTUfyXLg6cBD+BHAUaBCKSzRyJXpRSycNGtgJi7h
         0OfAQ42f++Hdn1mTKz7NOafUp+NklEQB3XPV9ynUjYy/zNw4ENwKZFhIGlRiuDPOehOi
         TgWw==
X-Forwarded-Encrypted: i=1; AJvYcCWBXrStTxzpHanDOtoywsqx+yxnQSOSZalRoBMWI3OvHc5hPbw1KyogMfQHEyOp7wffuxFD/RDcmet+J04=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2yh6xTFfcG+SFXi2Scvd27QVj+kcq5QWkIfKWjO0XzF9sJ5D9
	Ya8wVtAKZZqN7lhmJm482y5j2rYPfpeCKDMx2Ly1HEQa3AJ7AbRQIwEm
X-Gm-Gg: ASbGncsgQISYwDqhoiDDa2U4J4wi9b5pojGfFrClKxFq5l8GZ0qq20xw/0uE6m9Hmzq
	0k43AuTcb9tAKXbzj7SWoyb8xLmCHeAB1XSntRf+GJIlGlf9Mmzwggs7UXv6D94Y1TFJOlJ9dHe
	tEc+GJ7SkGuCibdEwvkKuUrfu02cHrpzAK23/dm0Gqdj5iCzgERpQjwaMyoAuS88QoQDBwxQ8NV
	3zfSkVrlm+Ut2PwOZdrkRbLfNef+R1/DQdfTnPxOFrvmatXSPJtd16h6cm9V1QYLqZisEWck/tn
	Fht1taMcYGAd81hKfB/CRPVbXfvOjWQuiJyS881alo/0cTtoZ+7oGxCqwOPib1LwqVmNxUCWW4K
	5U2p4gdAWC47DT7Yv+3dj3O2qwLtjt0bknNyQ8IYU4WkW7EyxArG+KOQeGi500Im0W+WJ62aRNN
	4igPOa9ohxQWsZjgYNvu/FUXt9QHlx3AQ7VH3e1VKyBA==
X-Google-Smtp-Source: AGHT+IF7Qq6jQqzYZdDrJkaw6UlpFKkxTue0qnLTmhRFyadA1ihDqW2+FAH2PNlrJyvCEAGwchJGLg==
X-Received: by 2002:a17:907:980f:b0:b3e:c99b:c78a with SMTP id a640c23a62f3a-b50ac5d07e0mr2126585466b.54.1760297029128;
        Sun, 12 Oct 2025 12:23:49 -0700 (PDT)
Received: from jernej-laptop (178-79-73-218.dynamic.telemach.net. [178.79.73.218])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b55d67d8283sm760176466b.38.2025.10.12.12.23.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Oct 2025 12:23:48 -0700 (PDT)
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
Subject: [PATCH 08/30] drm/sun4i: ui layer: Write attributes in one go
Date: Sun, 12 Oct 2025 21:23:08 +0200
Message-ID: <20251012192330.6903-9-jernej.skrabec@gmail.com>
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

It turns out that none of the UI channel registers were meant to be
read. Mostly it works fine but sometimes it returns incorrect values.

Rework UI layer code to write all registers in one go to avoid reads.

This rework will also allow proper code separation.

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
2.51.0


