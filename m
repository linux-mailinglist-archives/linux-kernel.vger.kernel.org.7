Return-Path: <linux-kernel+bounces-849704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95F89BD0B72
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 21:26:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E5A51897C0A
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 19:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E93A2F9C3E;
	Sun, 12 Oct 2025 19:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dxn7K1Uq"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAAD72F7AC3
	for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 19:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760297040; cv=none; b=bHliZtA5acw0+TeHBP4vKPtkargSiYrR9EXVrB/O1AQYXN4wlLtJodyf27KvQJSfxZGZ7nMMipkf4SOT4cRGELYqNEFLUYASRlRXY6BEXWNpStDF7baIhXXKUeq9IkEzg0QoToHwnTkLRUILAbMkMQx2wZK23j5zbHBEYQkGElA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760297040; c=relaxed/simple;
	bh=ZomKanEsSZDy+AK6wHEspIETpM6s5dDvAJVsDJCPg+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XbRWB/AxOt1kP+JMhdb15mS9/b7JpVuHCUolUsUEnoZ8wusdk7+FF0hGUZ1kI2jSCYipTciTYkY4XVrbi1JAZm5QffbCSJiCVhWLTwVHT0Mgjt1t9tCKu/3kvuWGO+O6hHXcX6M6A2L2/HbYRBtCfjACA3g+H3R3AuT3PLT0O4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dxn7K1Uq; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b3dbf11fa9eso592131666b.0
        for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 12:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760297037; x=1760901837; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4rXnVYjWRna1Dp2XBUdGu2XgFBNqeWg8iiIcPP8l+VE=;
        b=dxn7K1UqFbfguvmZKRfCwB8urCJOdZOfCTSnDiiG5w4Rn2cuGGIwxcDNwJdufR9STv
         Ecwr1DxqNOcSJ4IxjdNddLn5ClEledTHOSvyCvAVQWiAnqwP6LVSQqbzFz9wxj/bkn7k
         0JbuS2c13vi8etGkuguwQSefjT+MZ1GjcKeTmaEfiL2rMOPCZN19SfbTKj116kBDBlA9
         MvIMxJbwzmbg3G3/YrRuK7jMVsHhyGUGhGZ1WImFAtQv5TI+PvkEOpG+rmGDJSEs3W5H
         UWGV6sHo1c6m/OmQSY3synvznqoQTKhY+kTdMHt51uCy3DlqQT+qBq3gfUmkeHYil6tF
         5ibg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760297037; x=1760901837;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4rXnVYjWRna1Dp2XBUdGu2XgFBNqeWg8iiIcPP8l+VE=;
        b=JZGRlh6g02L7REqm+adkiztdcIyEbyxhsRuoNX+hVD1ITQtq5gctEIajFNKKm/dkxX
         7gbGd/GfJw3ATLx+FoxjZlrTnKNwb5kLvrBuob2Wy0OiyTxWHXAbw62tHI4NEiFqN0Bc
         pgR/O9eCLb0Q0aXDxGYpLfKUdOXC5GnJeWSd7Bf/5piffVuFjXKWKe3FNgeZUqUz7vsd
         k5gQ8McMtnuPmDHDq/5xDDP/M1Evg+5gO30oQ8YpCwZOTKVPPGgNbeICOm9DDyrTSb46
         R2Rnaz/hAzjWT7moxs7Tg9y+6cPKR6Zw7N5FoOaTjh+l7ksN3EaKIaH4haFJmgC0QcJ4
         4tww==
X-Forwarded-Encrypted: i=1; AJvYcCVagNOCZQV+bJDLBcB9Im1wpI2/dy1pY9U+kDGuJ5Kmm0YKWnIjF3c6LkSfZtiZq+0+uqgA/wqv3q9+bNA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2uvVLMsgRAUAUAtQz52GsNi0s4TG/f+R1uJWsA1+dUOWtfihj
	huKIQV0St7k5EP5JG2Q+ecCfdeTw5Z6RCdEfy1AJ5/LDy+rrEYfuo9qQ
X-Gm-Gg: ASbGncuOpHVtyqhCADifD0FDx+lSrJcSVt20WfUuKBbCzotekKE1435+YiohXbcISnD
	HRqX23H3s7Fso6Gnogn5U9iOtfP9BWvRdRzuTerlUnhqjlWNwVPNUVrMyITS4U0SA8e3ufZlf1V
	yifsrHi3HvuoMiyfvveiHEIgTMB0w6c0XUBETf7o1z/fNa2QETfjtQ2mqE94+JbnZC3Y2YT/u6g
	/YOI0EWkNY90xmHbGGUU4G2TH2Ekj0UNIL0/JTVp8qRWlMU6K2+Oue9bA1SzLf/1jkjnUE8MKWO
	gyLgfrox7QfT0/cAX0e3K5oNfejMMr3mhyVmpoZRKFR+sWUJWYtDUuISPQ8CczuQIzXX6o4ye1C
	Qf+0nfNTdkG3HS7NRGKQ8TZgmQQhMvyKRcwJ5AiGgXqC9dwna2TmDPzGdbxtMWRTdGdo6VZ2GNT
	mwl1zeITa7D/oh6ST1uG9n
X-Google-Smtp-Source: AGHT+IG0I+CtyMQ9AS5dyUihgRwKpeygER1fugmzO1P668vrEqp3088Kprh13QnASf90ghU3NNQmHg==
X-Received: by 2002:a17:907:2d07:b0:b04:708e:7348 with SMTP id a640c23a62f3a-b50ac2cf4cfmr2032278666b.30.1760297037018;
        Sun, 12 Oct 2025 12:23:57 -0700 (PDT)
Received: from jernej-laptop (178-79-73-218.dynamic.telemach.net. [178.79.73.218])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b55d67d8283sm760176466b.38.2025.10.12.12.23.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Oct 2025 12:23:56 -0700 (PDT)
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
Subject: [PATCH 14/30] drm/sun4i: ui_layer: Change index meaning
Date: Sun, 12 Oct 2025 21:23:14 +0200
Message-ID: <20251012192330.6903-15-jernej.skrabec@gmail.com>
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

In the pursuit of making UI/VI layer code independent of DE version,
change meaning of UI index to index of the plane within mixer. DE33 can
split amount of VI and UI planes between multiple mixer in whatever way
it deems acceptable, so simple calculation VI num + UI index won't be
meaningful anymore.

Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 drivers/gpu/drm/sun4i/sun8i_mixer.c    | 5 +++--
 drivers/gpu/drm/sun4i/sun8i_ui_layer.c | 5 ++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.c b/drivers/gpu/drm/sun4i/sun8i_mixer.c
index e7a66d9b622a..17c0ab5860b5 100644
--- a/drivers/gpu/drm/sun4i/sun8i_mixer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_mixer.c
@@ -343,6 +343,7 @@ static struct drm_plane **sun8i_layers_init(struct drm_device *drm,
 	}
 
 	for (i = 0; i < mixer->cfg->ui_num; i++) {
+		unsigned int index = mixer->cfg->vi_num + i;
 		struct sun8i_layer *layer;
 
 		if (i == 0)
@@ -350,14 +351,14 @@ static struct drm_plane **sun8i_layers_init(struct drm_device *drm,
 		else
 			type = DRM_PLANE_TYPE_OVERLAY;
 
-		layer = sun8i_ui_layer_init_one(drm, mixer, type, i);
+		layer = sun8i_ui_layer_init_one(drm, mixer, type, index);
 		if (IS_ERR(layer)) {
 			dev_err(drm->dev, "Couldn't initialize %s plane\n",
 				i ? "overlay" : "primary");
 			return ERR_CAST(layer);
 		}
 
-		planes[mixer->cfg->vi_num + i] = &layer->plane;
+		planes[index] = &layer->plane;
 	}
 
 	return planes;
diff --git a/drivers/gpu/drm/sun4i/sun8i_ui_layer.c b/drivers/gpu/drm/sun4i/sun8i_ui_layer.c
index 8d74eddaa294..4f6c8b0acba6 100644
--- a/drivers/gpu/drm/sun4i/sun8i_ui_layer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_ui_layer.c
@@ -270,7 +270,6 @@ struct sun8i_layer *sun8i_ui_layer_init_one(struct drm_device *drm,
 					    enum drm_plane_type type,
 					    int index)
 {
-	int channel = mixer->cfg->vi_num + index;
 	struct sun8i_layer *layer;
 	unsigned int plane_cnt;
 	int ret;
@@ -281,7 +280,7 @@ struct sun8i_layer *sun8i_ui_layer_init_one(struct drm_device *drm,
 
 	layer->mixer = mixer;
 	layer->type = SUN8I_LAYER_TYPE_UI;
-	layer->channel = channel;
+	layer->channel = index;
 	layer->overlay = 0;
 
 	/* possible crtcs are set later */
@@ -303,7 +302,7 @@ struct sun8i_layer *sun8i_ui_layer_init_one(struct drm_device *drm,
 		return ERR_PTR(ret);
 	}
 
-	ret = drm_plane_create_zpos_property(&layer->plane, channel,
+	ret = drm_plane_create_zpos_property(&layer->plane, index,
 					     0, plane_cnt - 1);
 	if (ret) {
 		dev_err(drm->dev, "Couldn't add zpos property\n");
-- 
2.51.0


