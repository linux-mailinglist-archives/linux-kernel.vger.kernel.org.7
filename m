Return-Path: <linux-kernel+bounces-849700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB30FBD0B69
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 21:25:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12D813AB961
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 19:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08F962F7AD6;
	Sun, 12 Oct 2025 19:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c9DzbOH0"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E1332F6569
	for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 19:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760297036; cv=none; b=cbYci8V+TNg2wUViVpRU6nwxTJTE8tfv+uDmFrQqPaww2DwRst7A99H8Fo8UMfarS6MfE+01rpDBUyYe3gu+n8/BrIFWMKKch803D4S7YgNd0XA62RQ0uH8AamBPJg27lCQa6QRxw9+Dq+nacUaZ7Fz/MSAZcIWVuhsIxOQFNFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760297036; c=relaxed/simple;
	bh=SaVD3AEZ10Hpq8T4pFkv4DgWHHFAOjNyqWufbjTCFFI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CuAkkCtGZ4006j8vnUFRPZPEs84p3BeikIhha3Mdnvl+K+mV5oOBUFUOiqoP6n8lvTit/s7HepTqPWiQzynW1qJdsXwSEo+iBgwWLG4RrBF7B7drIcCgRVcywI38kveUDttlFWu9toaNxDUSYB5+5M4gBUh+bR1odmbhfggkpXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c9DzbOH0; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-62fca01f0d9so7294808a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 12:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760297032; x=1760901832; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9r6Ut7kV6R9HZszR3tkt2ETSQ6gt6SVQ7s+jJ4oPNx0=;
        b=c9DzbOH0VaW0Qfb0vIXt7hLaCp0/9ezHPgYcS2bzj70mHBvQi2cKsMrCgl/cOTzymV
         J8KqmD1Tn5gBI/IYzA9YNugJApjrUJXEx9O2JP6JI1xpSWD1g3PwKrY1Tmsjf7O3tnFb
         MgbjzU+wpTyliPzkiLlEM7yzlA7I/iLLYmTNIqz2ucNrFHoMQmG3EQ4Nv2ClubEuIuVs
         P8cnF3jm5agVIErb42TeadDo2GHF/vvVOalGQ0MXLFFR5okGAjshYA6cCKIwDrPpi3Xd
         OXeniXbS67gxQ3qS4nQ7nv6Fk6MOuzmxTfngbGDDPOP3u4Jfko892oigbvv+y4WNUH0E
         bV9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760297032; x=1760901832;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9r6Ut7kV6R9HZszR3tkt2ETSQ6gt6SVQ7s+jJ4oPNx0=;
        b=USJi1AHZj/MALb4ZRnMdA8BzIRupWKywmv8J1uc/XOoi6SCqpHU58rgmYj/fMkGtHP
         WgbLtQBRUTqimjUElPcxGtkDuV/+M1E71OmBSx5/WrMws+e4RVm9bBDoCXSH6jhT3Je6
         9/DJpR8iLWac+BNI3zSNqDWHDgisvwHrgWYG78gkIRSq2Bvzpu86uoSCUBmQjJ38G6nx
         xGE8XSwccrQz20us87Xgrds1R22y/054SuuNux1Nkj3IhYPmEw2xcbfmPc8HzMPE0rvm
         WfJiay4IHDq4FFdy1LUhU7UpMCExZbG9f/0x1cCJobZVFJdDgk89avICH32gdEQjM6XF
         Cwqw==
X-Forwarded-Encrypted: i=1; AJvYcCVjvE34ZVnSlJqzyQd+yuHPPjFIxKme4vF1XpIZV3/eaHAW2bCzequAR9Gvf9hYbYV/qFGuD80XRbtVCKw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLFaJrEYQK4nu2Df6pKqvDgFThCOoHadT5oP9yWVw+ipsu8ocr
	uj3rZuB3Sfhn0XDWg4vEBLthRqYlD+/0Su8gkErrgqXroDHudUacSqX/
X-Gm-Gg: ASbGncv7JeqYysD6Dvnggsnj7aGUS83GImZrRlnM6dzgjr7kiSzlyLzyOOj330ZQ4CE
	1fBUozDXVwUksnpWKAxDabOQmtZMB1rWcSU8qGFnaDj+VgtQB2EP+sh2NfBBYLUr/oVp/YuINUh
	TUKbHmLJLk2WNs6VO0XC1i48thmnhCiysmcuQOm/NJjn3QWz6i9B+dZQbPVDvn65owlaABeq7Lt
	3tf21A60av6sg1o1acw+BFuqFUM4IjM5ffqhWtFcxReZMVbt8hHNNDQeBTOhNIuX33L0mtIpCDB
	FeaHO6WVk3lb1PpaS96x6W5EJlrNVl43KHXoHbSiolXwcb0/KxG7Uql6S2lpDxK5eTznVHIU/Rf
	VjIuY7wsOeyWf1hjkI9RF2cg0c6kL19phy7uzKoHz1+t/K7fEJZzqTFg4P+vZ1DZqaZJ1ayjKuL
	WfbTBdduU5VVqC0+WDQJ8K
X-Google-Smtp-Source: AGHT+IGoU1lxXeWRIACneUv9HL1g56vOt419IJ1ZpZA1Fk2BOr5WzpZW402UoRq7f5Pp8L61Pkb+Rg==
X-Received: by 2002:a17:906:ef05:b0:b50:a389:7ab0 with SMTP id a640c23a62f3a-b50aa48d2d7mr2059077466b.4.1760297032494;
        Sun, 12 Oct 2025 12:23:52 -0700 (PDT)
Received: from jernej-laptop (178-79-73-218.dynamic.telemach.net. [178.79.73.218])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b55d67d8283sm760176466b.38.2025.10.12.12.23.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Oct 2025 12:23:52 -0700 (PDT)
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
Subject: [PATCH 10/30] drm/sun4i: mixer: Remove setting layer enable bit
Date: Sun, 12 Oct 2025 21:23:10 +0200
Message-ID: <20251012192330.6903-11-jernej.skrabec@gmail.com>
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

This task is now done by plane atomic update callback. There is no fear
that bit would be set incorrectly, as all register reads are eliminated.

Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
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
2.51.0


