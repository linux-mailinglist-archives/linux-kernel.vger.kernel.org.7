Return-Path: <linux-kernel+bounces-885308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 05377C328F2
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 19:11:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8030134C2D2
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 18:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA773329C5D;
	Tue,  4 Nov 2025 18:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HoTqOwlg"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F238533F370
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 18:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762279818; cv=none; b=szWr7BNi4M5en3ZOW9zIwnkPNR5nVqqPjkMPoAD0F0rUHrcNtLGlqchTo3hsbOrqqT6KJ7qAxf1v7WtJb29oxpXTtbi44wvZ7aTkXyJJIQMZWvr1c7VvJG+Nd5yCzvYWyQCkhiXF0Ck6mTI5tx5qdjT+Bm7Tf3tRn3fkL4b9yGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762279818; c=relaxed/simple;
	bh=FlT80Jvt6ahoDIAqeU5jws3NHItu0JW+7T1K9WvKkP4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kU1nL7wy5dM5wRFWc3qL62cIjeuR8INOvNtfUfySKfssYySDeLEuIPQP68ycib1dR9NVoytTdZhUqDT8MqK3NVagiL0x9krfPyIKJPaiPDPsum1WNMoNn45aw2HHDEER2XEc4isjvtT/Q8G0YHTeBowSbw5HxzHymc6S1Rsv3gE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HoTqOwlg; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-47754e9cc7fso7991795e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 10:10:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762279814; x=1762884614; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vqox3UkaoHNgrz/QIvGOJuxPYXtBZjdwtd1IyKwMyfs=;
        b=HoTqOwlgLhEDlwhwKTwsewIme7uylP5CzGdhMhLD25ZYyuTINI6Vp/4vO97JhaDyDe
         ls9NszGvlO9yj244AIPDE8NFHSyIRPsjBvOeTfUFeW1w9dEzwHj3sOhRtxV5LZ2wIsP/
         R0SiatuwXmPMuwRHH0aDlYXw4RLdH5zVFQJPaFlZ8fM0WZm6ETLX4Tp9B1B2cP9fEidZ
         QQSXvR4O+9fUkcBhVf+QFYw0oOFkX9Izjpf1+eb5XOQfQX7XxBJImBC+CV5JC4kcGX5w
         Zd2d43/39dmpJMwdxdjbyfug916/PkrFfGgDioJ/9swEBCN5CjDOguB7HjPU1dd8y2uX
         O8MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762279814; x=1762884614;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vqox3UkaoHNgrz/QIvGOJuxPYXtBZjdwtd1IyKwMyfs=;
        b=hWMWuN7J5+L0qEWO30GQW343djVcwv+gj3qEWFvb+WyRp5pnJuhkmZPzP6IkT4wP7r
         H1p+HlrL0MQWqttug54MMigBNFhEz09+DQKx/0PRyKbz/XlCyS+fjis08IfkpgWoy6pU
         KbaEEQp6zGJjkkxB9d6Sca2TTb0X0kEFSLM/I5gTtdKBANhA6RTcWdqQOzri2wWAjXHZ
         dVLhhd7R9yBfCHrKRuqtZg55srfWCfMsfeClPM25b+33gbFspkJIYFwiKaWOKSmf4Cmo
         VSV9wse9ih33W9qVZAlDaAwDKZnTO+DWp582G2wLQOxBdf3ioQWQcRNyCZy0uwY5cZmK
         H7ew==
X-Forwarded-Encrypted: i=1; AJvYcCVl5Ax5IFgwYyk5WmdaCDTInq1yaSvpo8mmuAmMPuGXkR3m5OCn2I9utWVvEgxpwiWeSHMo43oYkfjQ8hE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEaSJ6tFtyOAq1zLSF2MmVVjVwb4n+/AIt54SH6Rs7SNZRG6ZA
	wTf+UG0stCgEauOGIweL7joAKRiSIN8PyKGY29qWvCSc7VmSQviYSLPH
X-Gm-Gg: ASbGncviT87Lap19BN0XYB6pP35/yhdW4FRc7r9A2byR+a/BDf4VhFgMDfXlADwEe6P
	ojOKuSFlKLTM7SLsVY18C3S5DHXGV9iA32u55IZq2qjcmg2/EO+gWmC4JELq4VwvaoKd1PXzD1R
	AUHV4mrTC/Wg0yXaPHgHzkDi4OzjzsTCN/1Vc2q/g3Pdvd72uYpLE5SMVxNZ3upVkMn42jgrg1b
	8ogB9Y/1WmDIcFZwc5if0PXMoG6Tu1Aqj3p/VZ5/ckdW6HNKDuzvLLQeYYtwZiQ8jHUFbHbfhlu
	nmDu5ZD9YxO1Exb95gGNHQiYgQLGg6HK3homd5/3jiiE9/IdiDOatesYnXa2vWRzZfS7JWfOMfx
	00g2/7CgUeoBVO1DVSulewKnUFeXYkBWND34b01P7Dpvs55mkatcsJW0XpARyMnXl9XJMnlxCwN
	2pb3GQGEuA8Yl2w4REww==
X-Google-Smtp-Source: AGHT+IGHcjr5LVZvJCkn6ps5FsbaEzRecmaWoSpniwlTk12WxNdiygIkQQYkFJg+89wFF5L7fhoGZA==
X-Received: by 2002:a05:600c:821b:b0:477:54cd:2029 with SMTP id 5b1f17b1804b1-4775cdf4f48mr2528695e9.4.1762279814190;
        Tue, 04 Nov 2025 10:10:14 -0800 (PST)
Received: from jernej-laptop ([178.79.73.218])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477558c1a03sm24688685e9.2.2025.11.04.10.10.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 10:10:13 -0800 (PST)
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
Subject: [PATCH v2 10/30] drm/sun4i: mixer: Move layer enabling to atomic_update
Date: Tue,  4 Nov 2025 19:09:22 +0100
Message-ID: <20251104180942.61538-11-jernej.skrabec@gmail.com>
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

Enable or disable layer only in layer atomic update callback. Doing so
will enable having separate layer driver later for DE33.

There is no fear that enable bit would be set incorrectly, as all
read-modify-write sequences for that register are now eliminated.

Reviewed-by: Chen-Yu Tsai <wens@kernel.org>
Tested-by: Ryan Walklin <ryan@testtoast.com>
Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
Changes in v2:
- rewrited commit message

 drivers/gpu/drm/sun4i/sun8i_mixer.c    | 24 ------------------------
 drivers/gpu/drm/sun4i/sun8i_ui_layer.c | 13 ++++++++++++-
 drivers/gpu/drm/sun4i/sun8i_vi_layer.c | 13 ++++++++++++-
 3 files changed, 24 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.c b/drivers/gpu/drm/sun4i/sun8i_mixer.c
index a3194b71dc6d..1fca05a760b8 100644
--- a/drivers/gpu/drm/sun4i/sun8i_mixer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_mixer.c
@@ -250,24 +250,6 @@ int sun8i_mixer_drm_format_to_hw(u32 format, u32 *hw_format)
 	return -EINVAL;
 }
 
-static void sun8i_layer_enable(struct sun8i_layer *layer, bool enable)
-{
-	u32 ch_base = sun8i_channel_base(layer->mixer, layer->channel);
-	u32 val, reg, mask;
-
-	if (layer->type == SUN8I_LAYER_TYPE_UI) {
-		val = enable ? SUN8I_MIXER_CHAN_UI_LAYER_ATTR_EN : 0;
-		mask = SUN8I_MIXER_CHAN_UI_LAYER_ATTR_EN;
-		reg = SUN8I_MIXER_CHAN_UI_LAYER_ATTR(ch_base, layer->overlay);
-	} else {
-		val = enable ? SUN8I_MIXER_CHAN_VI_LAYER_ATTR_EN : 0;
-		mask = SUN8I_MIXER_CHAN_VI_LAYER_ATTR_EN;
-		reg = SUN8I_MIXER_CHAN_VI_LAYER_ATTR(ch_base, layer->overlay);
-	}
-
-	regmap_update_bits(layer->mixer->engine.regs, reg, mask, val);
-}
-
 static void sun8i_mixer_commit(struct sunxi_engine *engine,
 			       struct drm_crtc *crtc,
 			       struct drm_atomic_state *state)
@@ -304,12 +286,6 @@ static void sun8i_mixer_commit(struct sunxi_engine *engine,
 				 plane->base.id, layer->channel, layer->overlay,
 				 enable, zpos, x, y, w, h);
 
-		/*
-		 * We always update the layer enable bit, because it can clear
-		 * spontaneously for unknown reasons.
-		 */
-		sun8i_layer_enable(layer, enable);
-
 		if (!enable)
 			continue;
 
diff --git a/drivers/gpu/drm/sun4i/sun8i_ui_layer.c b/drivers/gpu/drm/sun4i/sun8i_ui_layer.c
index 8634d2ee613a..9d5d5e0b7e63 100644
--- a/drivers/gpu/drm/sun4i/sun8i_ui_layer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_ui_layer.c
@@ -25,6 +25,15 @@
 #include "sun8i_ui_scaler.h"
 #include "sun8i_vi_scaler.h"
 
+static void sun8i_ui_layer_disable(struct sun8i_mixer *mixer,
+				   int channel, int overlay)
+{
+	u32 ch_base = sun8i_channel_base(mixer, channel);
+
+	regmap_write(mixer->engine.regs,
+		     SUN8I_MIXER_CHAN_UI_LAYER_ATTR(ch_base, overlay), 0);
+}
+
 static void sun8i_ui_layer_update_attributes(struct sun8i_mixer *mixer,
 					     int channel, int overlay,
 					     struct drm_plane *plane)
@@ -201,8 +210,10 @@ static void sun8i_ui_layer_atomic_update(struct drm_plane *plane,
 	struct sun8i_layer *layer = plane_to_sun8i_layer(plane);
 	struct sun8i_mixer *mixer = layer->mixer;
 
-	if (!new_state->crtc || !new_state->visible)
+	if (!new_state->crtc || !new_state->visible) {
+		sun8i_ui_layer_disable(mixer, layer->channel, layer->overlay);
 		return;
+	}
 
 	sun8i_ui_layer_update_attributes(mixer, layer->channel,
 					 layer->overlay, plane);
diff --git a/drivers/gpu/drm/sun4i/sun8i_vi_layer.c b/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
index dcc4429368d6..727117658c6c 100644
--- a/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
@@ -18,6 +18,15 @@
 #include "sun8i_vi_layer.h"
 #include "sun8i_vi_scaler.h"
 
+static void sun8i_vi_layer_disable(struct sun8i_mixer *mixer,
+				   int channel, int overlay)
+{
+	u32 ch_base = sun8i_channel_base(mixer, channel);
+
+	regmap_write(mixer->engine.regs,
+		     SUN8I_MIXER_CHAN_VI_LAYER_ATTR(ch_base, overlay), 0);
+}
+
 static void sun8i_vi_layer_update_attributes(struct sun8i_mixer *mixer,
 					     int channel, int overlay,
 					     struct drm_plane *plane)
@@ -320,8 +329,10 @@ static void sun8i_vi_layer_atomic_update(struct drm_plane *plane,
 	struct sun8i_layer *layer = plane_to_sun8i_layer(plane);
 	struct sun8i_mixer *mixer = layer->mixer;
 
-	if (!new_state->crtc || !new_state->visible)
+	if (!new_state->crtc || !new_state->visible) {
+		sun8i_vi_layer_disable(mixer, layer->channel, layer->overlay);
 		return;
+	}
 
 	sun8i_vi_layer_update_attributes(mixer, layer->channel,
 					 layer->overlay, plane);
-- 
2.51.2


