Return-Path: <linux-kernel+bounces-849695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98374BD0B5A
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 21:24:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 594203BF82B
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 19:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F1902F4A00;
	Sun, 12 Oct 2025 19:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QQ8Bi3yj"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 379832F2900
	for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 19:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760297028; cv=none; b=AwxdoFpcsVyxg65w4dHaRUSpvsos4yfqOqsSxqHl8WWQDTt2zqmGIMhOKzzvYvJ75E1mccJyrrD41utLNzXg0daWoiJYsbf+hhBOwmTwlpjZ+k8R3M/0l0WjTFrIBSgyPfExlQiJCjnQrbxirWfYECabvLONzCvWD1CZfIHbzfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760297028; c=relaxed/simple;
	bh=NerHgxbZbmjyVYRLnhATBgZKX10HzgN5zpQm6t10Mcw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q5pa4kXPRSsONI/sBGyKNimvF1Me304j6je30YCHe6lB9gRa5gKbXo2eWhTV8Fxu/m591euDVb7cOAtr078iUxXga9UmNJsd8nXS/0ehPHw4oM4BUpbf/GcFhKVx3j8X0z7IEP1zMKOgpu+eEAVofGcVxPRPvxWowneFK3VcMvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QQ8Bi3yj; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b4aed12cea3so575816766b.1
        for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 12:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760297025; x=1760901825; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hnlOJ2n+kaG3xIG2KBBQJX6KsaJhFDRkiLuLt3jD0qw=;
        b=QQ8Bi3yjWAVcHU9hQS4MQ80BbFQ3s/ET8BZJM6q0GtC/ovZrHp03MsmKg5i+SbrrS1
         R6HRxOX5UW0anT2t2CyIpUY01pH9NfBPG22WksdCPf5mu0NYSKOGqXVHuTo6PxFI1XpC
         H5tscDHAunUxVxxZ681E73SI9Ovv0Rpw+jwVjsMlPXer0N/+6xuz4tuQGdakqmEvviCQ
         cRqjOoC/vji2VjlyBPuPL0zqR6KTDikjY/r6JcPKayBQ1N1ZzNUKGriXpo7921hgcizs
         7omf7sz/zvaLTbnmAMLg16lEfKCBMQUAHKICmSGU0PzYBPpvAqf4zHiojcfoDm42dz7c
         kW7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760297025; x=1760901825;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hnlOJ2n+kaG3xIG2KBBQJX6KsaJhFDRkiLuLt3jD0qw=;
        b=qXGPV2MiSwGWJUTAY/cQw8vnEq5qxLk+kIjKkPQsmFZVMUdsQldGlHL2PN2vieudM4
         MOljqeNKqgy4suH2xYxJpSpitblRWUJS2ZU0rJO0I01pulCCnvEXIfMZnlTKOZmZWg1u
         /H3fLTZ2UVUuVAzLD/LzIyMhuA6oIOZKGrbDZjqGyEqby35W3vGEtKunn85G4jyb31x0
         cvFdK69KiEJZ341S14YSueob+lSXHcqv3JsJkzNjg+1dTPJz+QxxxRAIShw3/8uKv1/k
         iW5cSPXzYBQzrBwEaOm0FkxsvD+/vPO3zJ/5475u9SbFZNwJVyWaCD1aVjyfNkTlAC3U
         D9pg==
X-Forwarded-Encrypted: i=1; AJvYcCV2HYSNVZ2wORBN9yDkly0j+nhNBP5VQ31lcXwg2Tn1vi1IeX7aysH9w4IpGYBXi/eEKCdKoraW/6NBLPc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+C0B5sa5zexbWhnV3+t341ASdiL7w5fZuMXjTd3O/QCetSdTN
	QhPPcnWoA8SX125R90gXbpeZDQQFouRQgjt9dM3JUSfXdLpDKYrX0D1R
X-Gm-Gg: ASbGnct0IotV0ilP2Ns1mI76fov45uwrnSGAV5IWv+4rRk5oGtFV6AbrY49kDYZjWjI
	nsat5KZRXcOF/Z/HRbNN10EJ0TEHoISwDUrkIBJa9maJXxezuq4eSOY6iajKnRYb6w6tZfp0Vgg
	547ZKuuVt5CFXlOWFXqcDzZItCnnseOXTJOGWrqtHNPHfLk78srN3e2EilBUYaY33z2KbqZ/7Jr
	mS1V7YyfcsP7bRjJuWVHL0GkUR4ffhm4fxEJ/5nAwOmUtv+9A0H1tWYvccVaoFPYixNx0+4gR7i
	PzSEB1E0Dkp/1fupeZPG9kRXS8BKnhPkAPlsxbPcyprK9Dr/K4dqXXlBmo5nPa/eGq/K3ZRx+Ee
	/7ShZVikMGMLxg0tAn265sEl9cnlZRVuv7yDl9QZLJLjR6a2RJNN0hR/5PgF1b9SsS4ImgtIOuz
	42b5NpyzWhVZN9g1cgkdfi
X-Google-Smtp-Source: AGHT+IFJXFSppj2HoIPfT0DNF82Abv4mtxDvrxkAHw6b76kGPg7cFa3ESgHvRApJqFhlZJceziWZkw==
X-Received: by 2002:a17:906:c149:b0:b45:60ad:daf1 with SMTP id a640c23a62f3a-b50aa8a92e3mr1797895266b.22.1760297025416;
        Sun, 12 Oct 2025 12:23:45 -0700 (PDT)
Received: from jernej-laptop (178-79-73-218.dynamic.telemach.net. [178.79.73.218])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b55d67d8283sm760176466b.38.2025.10.12.12.23.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Oct 2025 12:23:45 -0700 (PDT)
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
Subject: [PATCH 05/30] drm/sun4i: vi_layer: Move check from update to check callback
Date: Sun, 12 Oct 2025 21:23:05 +0200
Message-ID: <20251012192330.6903-6-jernej.skrabec@gmail.com>
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

DRM requires that all check are done in atomic_check callback. Move
one check from atomic_commit to atomic_update callback.

Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 drivers/gpu/drm/sun4i/sun8i_vi_layer.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun8i_vi_layer.c b/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
index bd6c7915bbc4..c80bdece5ffc 100644
--- a/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
@@ -217,16 +217,11 @@ static int sun8i_vi_layer_update_formats(struct sun8i_mixer *mixer, int channel,
 	struct drm_plane_state *state = plane->state;
 	u32 val, ch_base, csc_mode, hw_fmt;
 	const struct drm_format_info *fmt;
-	int ret;
 
 	ch_base = sun8i_channel_base(mixer, channel);
 
 	fmt = state->fb->format;
-	ret = sun8i_mixer_drm_format_to_hw(fmt->format, &hw_fmt);
-	if (ret) {
-		DRM_DEBUG_DRIVER("Invalid format\n");
-		return ret;
-	}
+	sun8i_mixer_drm_format_to_hw(fmt->format, &hw_fmt);
 
 	val = hw_fmt << SUN8I_MIXER_CHAN_VI_LAYER_ATTR_FBFMT_OFFSET;
 	regmap_update_bits(mixer->engine.regs,
@@ -322,7 +317,9 @@ static int sun8i_vi_layer_atomic_check(struct drm_plane *plane,
 	struct sun8i_layer *layer = plane_to_sun8i_layer(plane);
 	struct drm_crtc *crtc = new_plane_state->crtc;
 	struct drm_crtc_state *crtc_state;
-	int min_scale, max_scale;
+	const struct drm_format_info *fmt;
+	int min_scale, max_scale, ret;
+	u32 hw_fmt;
 
 	if (!crtc)
 		return 0;
@@ -332,6 +329,13 @@ static int sun8i_vi_layer_atomic_check(struct drm_plane *plane,
 	if (WARN_ON(!crtc_state))
 		return -EINVAL;
 
+	fmt = new_plane_state->fb->format;
+	ret = sun8i_mixer_drm_format_to_hw(fmt->format, &hw_fmt);
+	if (ret) {
+		DRM_DEBUG_DRIVER("Invalid plane format\n");
+		return ret;
+	}
+
 	min_scale = DRM_PLANE_NO_SCALING;
 	max_scale = DRM_PLANE_NO_SCALING;
 
-- 
2.51.0


