Return-Path: <linux-kernel+bounces-885312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82112C32928
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 19:15:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FE193AB6FA
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 18:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FF2734404D;
	Tue,  4 Nov 2025 18:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IYHJJnnb"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD94233E364
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 18:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762279823; cv=none; b=HaBGFMTqRPSeBpMipc108EIZb6BKWTA7enDfacWCwthhDM9jNAdStxRln/hRbgj57JaQFd73/qVNe38sHXh1Os7iUpq9cZBlu0GlllkqhMBNDcrmiqaySdoqH9n1GTZnQwKF2tJTv1/HRxi5HbjSu1TcUAPZ9U1Gj/vqPO83qyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762279823; c=relaxed/simple;
	bh=aukqhPkb3SXDec5/cqcnl9bh4tAlZZ6WtRNZI9Bwr+g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L+IzF4Enup65krN5GRhw0y2n+zLyOGH5AreQYiemGdpn2srS81DemI0exTNfUemU1mVZv95k5dB+5CdWEOUt1dwzWIHSczYdyo+K/UY+a1KEqoXuYXM+TrcT7S1eYtFXB6dX5miW2/OdcPy5G/RQ7YN9t6TFjodqufaQwHIICU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IYHJJnnb; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-47112a73785so38744485e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 10:10:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762279820; x=1762884620; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RkKFWxjvfnPBPsn+5nRw8D/GMWr7S+bsKZMhSPQ9djA=;
        b=IYHJJnnbuL8e1A86DkX8d78uPgIjtXTT2CLULzbYh0RgqSRKCnhoW5ktZTVSHx1E0U
         1RO43OYMlG9R6PHZqBMNRP6xzsnEu9HiP3j62BCQqMkVZf9ra7nlBKM9BfmwXRKqhadB
         gsetMRoiACfOlzHipB+Z4lhKdzG/oE6dDBICgqTzrz2PzH9s9y/g+QGvHRafCYNfaCgZ
         eLAkMrhPrj6L398lTIEgb0KrxLiCuHAZmWGTXLoey6p8Dd7L9lAWBV3gF8kcc1Iot31r
         baVz1B3MuBe8N0l6Ydcop31Y73YjAYZlyAppezrjORYM76X0ce2RAUgx0JSDJP3C+hjL
         hv+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762279820; x=1762884620;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RkKFWxjvfnPBPsn+5nRw8D/GMWr7S+bsKZMhSPQ9djA=;
        b=mZmsxNBFKsRzO8Y+U/Rb/SkeapiAJly7ijkeNBJWtER7Tcup+8DdRivz4AdmGhztH/
         c4gqKFLXjfRkOqCLI4DRwG07orovlkjFwrT1mCXMIDKLHqSAG6ANmiWEARamQXf7vQiI
         Z8IteYJPELeTpdu6mLgVixaclP04fZGKlovmitNI3HQZahvXUr+f5lDjvy/OR4ZCAz3P
         uZtNxaZ0NUUFQhAId2ymNJYRbEeJ/IhfQOisJ+T7aBm3S44JZ7buEeyBWF+7ROZJWxu+
         ebRVYgdG06/bb46gzOchsUVtrXZHplRFkOKDBQqRoaGw1tQLzfTEoJCkfO8xtOrLkhYl
         eisg==
X-Forwarded-Encrypted: i=1; AJvYcCXasE5Mb5Oq21+K0/AZq4Ecthn3nUxd4jtGbtfEGP/tS50LGV4IQxaxQCrp4QBBN8py7dMEau8UAWOHarQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywwj+Z7ytsSvlTeI4zwxAVuusISGazBZijf+a25PU/gN/jz7mxB
	0ZVvOw/pjQI8BInl60LmV8oHj4gLH0A0D87OMdBliMs7hsvOgOjTt233
X-Gm-Gg: ASbGncuPSVhkO36C+CVhnubRsr1mWIlXP4m+vYEhnLtCBA5NomT7R3aXWscUhSvvROW
	PbNK+5UMMCQ2HWtfpGR/NSkWHcQdMtN8gIe0Rhkg/t11Cb9PGA8mJhZLnDYiANUYu2eKPrTxOBw
	KDJbtGUsezLTYzsU0md5EXUZWdu31SHd9otBIi1R4IXe1xkhfahrmB4LCV/IGTLZeruEc6vLLGO
	r5PBdST97eX9jFAoESK2XoiwCDmazgKFHfJEUfBc/SiHHvmXTQcoBFm4cs32rbsgbT2kDdxrwPW
	eWJGYPxXdsRa2rWmqEmGEeJ/czYtsl8Sf5Rp1afiSfGCs1JPSBo1utuPJREJo5nlF8mpfwyjYc2
	ZGBL45V9dl40uDA6iCVbEO7FzpByB2wjmOTR4/qCHqxzb4wp7+S7DfqkhkWbfB2PKB0LHfXpEsK
	+PfTZzLjHecQ35AjTVCA==
X-Google-Smtp-Source: AGHT+IE0VNeGup3E339ZS9R9hdH9raL7VWlmheMAS7dvWwXActLDGmTaSE0UPI06AOF5H0yvEXihPQ==
X-Received: by 2002:a05:600c:a0d:b0:477:1622:7f78 with SMTP id 5b1f17b1804b1-4775ce24859mr2137695e9.40.1762279819619;
        Tue, 04 Nov 2025 10:10:19 -0800 (PST)
Received: from jernej-laptop ([178.79.73.218])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477558c1a03sm24688685e9.2.2025.11.04.10.10.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 10:10:19 -0800 (PST)
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
Subject: [PATCH v2 14/30] drm/sun4i: ui_layer: Change index meaning
Date: Tue,  4 Nov 2025 19:09:26 +0100
Message-ID: <20251104180942.61538-15-jernej.skrabec@gmail.com>
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

In the pursuit of making UI/VI layer code independent of DE version,
change meaning of UI index to index of the plane within mixer. DE33 can
split amount of VI and UI planes between multiple mixer in whatever way
it deems acceptable, so simple calculation VI num + UI index won't be
meaningful anymore.

Reviewed-by: Chen-Yu Tsai <wens@kernel.org>
Tested-by: Ryan Walklin <ryan@testtoast.com>
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
2.51.2


