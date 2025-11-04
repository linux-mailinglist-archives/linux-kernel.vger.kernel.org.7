Return-Path: <linux-kernel+bounces-885303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30760C328F5
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 19:11:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D9AB462B2F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 18:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71C2D33FE0D;
	Tue,  4 Nov 2025 18:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dU7YFxQF"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA0C33F370
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 18:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762279811; cv=none; b=M5OirocztO+CRXNmtcRXiiIuP7kAGMxizP7T/NDvYis64ru8AfGcMTN0YJeW5KDZi5t21cSW9369BN/8ZsfcEHQe/T7melvlpVx+F3OwT5qpcuqdTKgApQ7X/nj+OtXQlJvNnpO9iRscHP25W5uC+d8zhLlRlSjcrdYgGeedOHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762279811; c=relaxed/simple;
	bh=9iuYPe+y3PbTHR/R97DFIicMKJlmsqd/U6tW26GqMxw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qoWV7F+ZepVrBG9SJ5rBg2E+BPQZS8TEbJ2FhsPoP8OuIn/7XLtMHTdwvbsjdj85kVJI3Qqv3UMLZJ2DsyyXxMWbD2IypjpYWcZnN+APNekB3r8ZdjltvL67ckOPCpHVqqqDk1lPJtXnpBFY0ZNe2ofJJZ0aJnYMsF1LhPHrYoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dU7YFxQF; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-47118259fd8so43594895e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 10:10:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762279808; x=1762884608; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nl1ilT/sObHTqPC76FAptDP4x6azYGMRqYkHZHMZay0=;
        b=dU7YFxQF/bA8qjijCi+FFeJkHL/EjATM/swP80KQtWWVLQae2QCDiB8bwfYbPDM7xf
         X4WWgBJIV+8P0aGodDlbOnOb/pTVQOpH7X73JPYQDxceqrpW/A6L21BgtHu8aeLPBB7T
         gTVaVA+9DEl8XDxP2OtEK3nQmpCbZLnpfjju27xGRkCuOm9soUsK4mRMrV8LiLK1JNZC
         Sj/OWztzJAdbejPNl27S3YbjSP/bvgHI0rMr05cALxLzXIpfYzOVxTx3rJ7IqLRa3zIg
         2W78e81JF2pXHuR6mEzv16X8hZ2ywyKEFL94UOdD5mj1axf6TJUXUJicfll4ly0sl9OR
         Py4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762279808; x=1762884608;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nl1ilT/sObHTqPC76FAptDP4x6azYGMRqYkHZHMZay0=;
        b=Ouhahfhzv4cHmA4s+0gDPtSkzg9rg5ah5pstSwC3cIlrXaiLYgSiwUUeGmqSsn5bcT
         d1YvXGoP0iV0PPw5swoziWp1H/Dk0FH4gb0v0nzmTsScA7CpIwVRhNz4HwYAj2A/k1oG
         Seyq3CUaKN5N/6NOSSb1h//Jp99tw+udCBy3UTHzCP+OTJgG/Qngg0VfBZKkiYNwcYIl
         EdctA4vkauETgibLC2Vgsrib3vWPwytS3+7AVuIRC2HPc3mowocORB0DFO5ZD8OGeKrY
         ARtiar/V674LosVg+fCfWPh9TjeawmYSBLgGQgSaGKok+0d5HIYjDMTi5M9skwzKjf5K
         +2Lg==
X-Forwarded-Encrypted: i=1; AJvYcCWwF8lUeJZQP3TLTqq0W+rx2fXWiCkDPFhEV1J5atW032DujygHdZcfU8xaLmoPywhDorQp9YcVsYVmrpE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFxkdmNEcVwlIzwONqP5DMjcvhXjqewMoDxwk605ZXk0C+AWNF
	ISFmIJ3kwamLOcToI4wGY66uHm3DYKfVB3/RW8eGgSnuSbNDHzl7p6zA
X-Gm-Gg: ASbGncvlC2P/Vcr6E8gEvWfvDCFCHbazlitRYp9dAGFvJd3LpQhHTHcFwn3uJpCTwUg
	DXrIRtSeh9E22VzPfEmqwU53DQJeoMa20iFI7gCVnEpDBnzxskg+rAuRAwaX2WLgo1U+iOTgmGX
	ATpAWaYJV7wU/VxK5PB8ZVOes0Etv9jfLGoABnry+/tM/Au0z5j2q2684xHS1voAn52VU/QTLeu
	jKvL8sXuAEdRzQjfAjxaOr9RpcK8AdaicqpOlbZPhrhE9g9X0bgjI4Qe7xwX9crbK0l26UhmhWO
	CzRO4mJedwRySErq9f6HqTX3AgR9+PntueaJwwmQcw5zpAPZagIKq7QGgfRrVuUYXR5pIZIr/va
	6UfOUb4MNqKPGgr8WVLxSAGv2/D77LmBjflA9aIP7IulsyHVVZftAdWkWTw5Sv960x4H4edpE0J
	rihna5ILlrYxBqxM9quQ==
X-Google-Smtp-Source: AGHT+IEaQ0kJCmYAyDupR48ISzZYJfw4Ug61ieLu3o3gUFaY4n5a/nzq0x9jBMUVbLw7oK4nsgRXfg==
X-Received: by 2002:a05:600c:34d0:b0:471:6f4:601f with SMTP id 5b1f17b1804b1-4775cdf54aemr2431095e9.19.1762279807980;
        Tue, 04 Nov 2025 10:10:07 -0800 (PST)
Received: from jernej-laptop ([178.79.73.218])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477558c1a03sm24688685e9.2.2025.11.04.10.10.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 10:10:07 -0800 (PST)
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
Subject: [PATCH v2 05/30] drm/sun4i: vi_layer: Move check from update to check callback
Date: Tue,  4 Nov 2025 19:09:17 +0100
Message-ID: <20251104180942.61538-6-jernej.skrabec@gmail.com>
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

DRM requires that all check are done in atomic_check callback. Move
one check from atomic_commit to atomic_check callback.

Tested-by: Ryan Walklin <ryan@testtoast.com>
Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
Changes in v2:
- fixed commit message

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
2.51.2


