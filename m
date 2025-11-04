Return-Path: <linux-kernel+bounces-885301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C756C328BF
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 19:10:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 37D8C4E5218
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 18:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9A5333F360;
	Tue,  4 Nov 2025 18:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZjeGOpk/"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4686B33E357
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 18:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762279809; cv=none; b=HHZOPVcepFrEx6qVZx8lSUNcRRe51+0ddHt+7tQ+Y4ZMvis37gRpE2sKX7MOvjbAI1elLSjZk86QoqrFRdqxedAvJSguLi9C40xMeXFSN+UknnzXvOWqObjzrqX1IJVj1HVorNRwfHsU/NgOItOGUWMatG06luwy5XoNKGaPulY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762279809; c=relaxed/simple;
	bh=EhvcCC5M8Ffhpn9lWdXwL6pO1wy+yi3roBXaKFO/oSE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c7xC3csR0vQiuJnEvtJ4XoqGi9Ac+aQmkNgkek2m0AtnjV3ogZ6HGGdD2tNF/rXeB6REURVuNW804KmdHzrMprQhcp6R4bqkq9vXl96WF+sKbW+zfL1BlVc7d56hCD3A5/k4hkigv/F7lBKV+7Qq92S/OsuQEUw0+kEDWsLf80Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZjeGOpk/; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-47117f92e32so47876835e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 10:10:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762279805; x=1762884605; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dL+KOGGetvWAx0akok8/ovUlD3VF5A+umltWwuLE0k8=;
        b=ZjeGOpk/lEIypuP2B6tTZ6HU53B2IbHFhtIMuD356PxVm40UCM47QLC/Rq8hVRLTPG
         j/0WpecrdfY2gaIX0HjjM+osDHPugf5PRDAeWkOqFg1aqScB/+ruOxw89XAd5kwHCVPp
         rAGQI42fJ8N6yGkWIauBRWf6LMvNm2fiL+WxWkusfQUfh1iHziRnWUoIFyNkWHRq6MlJ
         noGLvws+7k1V1cPs5vHfG+8PRpqX7ftGkvztJ4o+J+aFXWMgIBNaxRozXdAbk2P8StfK
         r+ys9As/sXPMiZ9GGTLRwKfODUAbUoiU98WJy9WkoVqlUb9qQf+pD5oIk973+BUBsgFa
         tr1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762279805; x=1762884605;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dL+KOGGetvWAx0akok8/ovUlD3VF5A+umltWwuLE0k8=;
        b=ndoX/ptIH7y0IL3nxk0X7SfhpD6zwR4y1zOGd+o49rAo7cof1jhR+g7nyvE1PQ4qMa
         OFQ0KHQEF6CLLNHnG1YMZxoANOEXjlJqu4b49+q6Vz0F4Jq+TDz2txsQ/WQ+52UJafBe
         dimf+ixspd0fKRjMMs0lHTJ8Qmu2P/Pvg/2XJISfIfxHfaMfVgnezowRiJjtvAl4T/0+
         OVFv5r/0X+tfTZ1htjPTA7sruQufM6IaB09589BKrhWshvZyN39eX7MKHySz/9dYa8Ya
         O22uwf4kUJ2zR/n29Ul8ZHhnCcFk8Sh1BHGDzLSb+BuHWITJP5OZ+OGR5G/L1QKd6lAd
         sJuw==
X-Forwarded-Encrypted: i=1; AJvYcCXpbRfBFQTmC2ujtgWkRiV4BHgUibeHaErjRI3Kh5AW3cBLlTXC4Ta2PlOG20t+n/QYrdgzAYVuzulnoFk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyt47xdpl9cjpi6WkR/wpQvZx7MjG2x4mUhSYdCdy39h9luoy59
	5eTC4WjsBotk4hn5tQm7RYdg6ym1U6hoErmtzT1Eg/gTT/t/rUKMXxR/
X-Gm-Gg: ASbGncv8iYRi2p18X6PfQ+jJqrr1x7WLEbk598d3nyvT7h+UwdWVw3W8GB6w7NYesvT
	3MYVtorEAQqwSI3wMQ911AjNuK1xpHgnNdxmiCKfwLPRCjWVrvj24IpZT2Hl6LjSQN/1A/grA4h
	JAXupyjczUMAQCp07wq0Y258RLcS4/I2+zb2ZaWFrTEfTCfIAl1m0hXOvDSHF6jEYYzmAg34m2/
	NyUYBTEZIPevqf4eO4ES3h7ToaM0HGJQ0Ea5VJEc8m4iFId8PpsMKfo0v0a386ZRKbBBECBbhlQ
	v5UepsKtvUaIL1DsD7tQY5G4E561eMr78XN84aU9c/DRgH+RZlfKJueaUthh4cpJTjJzYZjPI5J
	CcKxBv08ak98bnVto7C1vtdB4VEgRDmphpRckUz/Vlu4pYl/SRWVpoWacbyFS+CF6RxrTqjworU
	QobPdePsixcVIMm6ompg==
X-Google-Smtp-Source: AGHT+IFE1Vnf7zp2knUPF6yAEnxj56xkN0ItjqfzEh1DT7fbSwSU9DzT/Mss/kHxDSruSnpGcPcZVA==
X-Received: by 2002:a05:600c:699a:b0:46e:32f7:98fc with SMTP id 5b1f17b1804b1-4775cdf46b2mr2500505e9.21.1762279805418;
        Tue, 04 Nov 2025 10:10:05 -0800 (PST)
Received: from jernej-laptop ([178.79.73.218])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477558c1a03sm24688685e9.2.2025.11.04.10.10.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 10:10:05 -0800 (PST)
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
Subject: [PATCH v2 03/30] drm/sun4i: de2: Initialize layer fields earlier
Date: Tue,  4 Nov 2025 19:09:15 +0100
Message-ID: <20251104180942.61538-4-jernej.skrabec@gmail.com>
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

drm_universal_plane_init() can already call some callbacks, like
format_mod_supported, during initialization. Because of that, fields
should be initialized beforehand.

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
Tested-by: Ryan Walklin <ryan@testtoast.com>
Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 drivers/gpu/drm/sun4i/sun8i_ui_layer.c | 9 +++++----
 drivers/gpu/drm/sun4i/sun8i_vi_layer.c | 9 +++++----
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun8i_ui_layer.c b/drivers/gpu/drm/sun4i/sun8i_ui_layer.c
index f97be0040aab..9b786e5c7f3c 100644
--- a/drivers/gpu/drm/sun4i/sun8i_ui_layer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_ui_layer.c
@@ -304,6 +304,11 @@ struct sun8i_layer *sun8i_ui_layer_init_one(struct drm_device *drm,
 	if (!layer)
 		return ERR_PTR(-ENOMEM);
 
+	layer->mixer = mixer;
+	layer->type = SUN8I_LAYER_TYPE_UI;
+	layer->channel = channel;
+	layer->overlay = 0;
+
 	if (index == 0)
 		type = DRM_PLANE_TYPE_PRIMARY;
 
@@ -334,10 +339,6 @@ struct sun8i_layer *sun8i_ui_layer_init_one(struct drm_device *drm,
 	}
 
 	drm_plane_helper_add(&layer->plane, &sun8i_ui_layer_helper_funcs);
-	layer->mixer = mixer;
-	layer->type = SUN8I_LAYER_TYPE_UI;
-	layer->channel = channel;
-	layer->overlay = 0;
 
 	return layer;
 }
diff --git a/drivers/gpu/drm/sun4i/sun8i_vi_layer.c b/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
index a09ee4097537..bd6c7915bbc4 100644
--- a/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
@@ -485,6 +485,11 @@ struct sun8i_layer *sun8i_vi_layer_init_one(struct drm_device *drm,
 	if (!layer)
 		return ERR_PTR(-ENOMEM);
 
+	layer->mixer = mixer;
+	layer->type = SUN8I_LAYER_TYPE_VI;
+	layer->channel = index;
+	layer->overlay = 0;
+
 	if (mixer->cfg->de_type >= SUN8I_MIXER_DE3) {
 		formats = sun8i_vi_layer_de3_formats;
 		format_count = ARRAY_SIZE(sun8i_vi_layer_de3_formats);
@@ -543,10 +548,6 @@ struct sun8i_layer *sun8i_vi_layer_init_one(struct drm_device *drm,
 	}
 
 	drm_plane_helper_add(&layer->plane, &sun8i_vi_layer_helper_funcs);
-	layer->mixer = mixer;
-	layer->type = SUN8I_LAYER_TYPE_VI;
-	layer->channel = index;
-	layer->overlay = 0;
 
 	return layer;
 }
-- 
2.51.2


