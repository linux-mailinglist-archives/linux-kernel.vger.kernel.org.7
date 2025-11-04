Return-Path: <linux-kernel+bounces-885302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C314C328DD
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 19:10:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B29484E9656
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 18:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B7BA33F8BB;
	Tue,  4 Nov 2025 18:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pb1s4dc0"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C0C33E376
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 18:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762279810; cv=none; b=SFZhDxfYZlYsgb3sZJ4Xv1ViWmxvvvjWjsr5o8AK4XeghLOnA1E9V+LzJT2Z8JdJThur/nKWI290DbdHqB4eWVtHq0MriAMnsBViF9pbqQzpk1OQci2DPjoobMqLd/ilkA1OQvS0LchXFDaA6/IMVIgUPhu0nmRPP7xKKog3+g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762279810; c=relaxed/simple;
	bh=v75gTyjSy2HSa3UfhJ4KqrZ90JgtcxjZBdZ9oY7/Htg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i9lLp138OiFIM4FfPxKg4Pp6y0DIxdK4/rmr1H6z+HE1KBMKfK0mWMuYfodzagT4x4nVEhaypeSk3Tkbiwi7TwBVagvUHZQ7AaSqJqfgbSCR+oD4YqjucyZ4GRR+mEljsJGjMq4jhDQ86fCrqTao8W6RiYFLJVtiJCuLJfi8SlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pb1s4dc0; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-471b80b994bso75232945e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 10:10:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762279807; x=1762884607; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S/mUaml8jAYrXfg/EZn9k2T0kOPXbCuOkx1KYxiElS0=;
        b=Pb1s4dc0TAaAKa4dtH82HncFEOP2d3Xl+UFNvQpEBUS+CVdKzeLuhSoIm7gJMIiezd
         0mOXpGCelbr+HnR8HykBGc+y2+vSleRaqe77+hTqK2pXD7qLvLA6efylTB1/aIMLvyK7
         viNHJaXO+TaaP70xWFLE6qBkui0+Ndj2uUqhG1m2SJriG8kvcAYk2yNY9m+odtgj4CfN
         aECuJJpqu26k0tQTrmyG89Bimp0TsBMxqu0fEDGkkS7AGbAhy6yGCkK/mLr2ypg6rcRm
         fBXP4Zdtjf2iKbqbpklHCLVxsCRZrGvMshsY+UEn2xlbdO8dVClkNhuEos0Fe28iB9Ml
         vjtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762279807; x=1762884607;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S/mUaml8jAYrXfg/EZn9k2T0kOPXbCuOkx1KYxiElS0=;
        b=qiaBmKT+yHadBtp7gQpLK+0lHEQ66AkeENjcJWMxp3hUqrGtCaNftDqEQU+6NSSSAR
         b76z7bkq14wvg5Q3XaqjwGa8uu8sXbWBq2IiUA6YtWCzFTfMPDcPxstHp9NmsZvzcEZh
         HlvBbJ3Nr7SYCEtEvdSvDmTBUe/SGzom4BrbS/StHT791ZA6+AuYEl0UYrm6nOBunKBX
         N2MfsSfEZkvIIRnSg5ForK17o3moPxfnr1027yyJIfk1dzT5TTkGjkrasVzx7uGPLNAS
         1BNnpBU1TltqGtlvrWfuq0MVPNLURwA4eIR0R+brXaSehFJ/YehBqsB6Qp83z4/cMF5P
         y3aw==
X-Forwarded-Encrypted: i=1; AJvYcCUSkfORi9xH0SAeylxEngY5VB0maRFScJyJO8MtNaLgk4nyNQDUHSW+LeJNMy2IiWqJXTnlYGZJ2p88ruI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWYNIh657kiNgdubBT99pZ+uBh4wPgnDLsJgRCP2Xi0gFlvQVa
	4voIV6bXrk8SIeKXE3r7QJBrXEl5TD7S5vwqyTcPbyZuv03pNvW86z0n
X-Gm-Gg: ASbGncvQoZUypr0rohxZTc9yCbH8S9MT7xvhkfbf56k04hdNu/omqyEdPIGtrT7kCLQ
	epTXbwlsmch78A8Dj/e/EUZPDS+RWZRKoJPt1a4YRb0Y4L0x9aJoDjNukQctsKnBm2+TUkDm0Hh
	U2iuYkICH+7tMVy6qUTENu7bVJKJ61d8LiPw+2ypjZpA3IPBzSZTBA+zq3tc0Ee3+L64mJf5h7+
	+2XMP7qXtUXIU3wVbH7C7BhYlIl6fX9yCP9QKkTZFn7FWClVQIrTsb0IumffY+8d2zy0rvbOv/9
	UjR7N7zvqZ1NdChj50XLRbrDyEajAT07mzyNm4GGLBKP3eOB23uMdp7VBNrOQzfBZT0BItja+n2
	y19886et4Mxb4ClyU1yHYnI8112dpS8/JYB2Kj4P1QMZVxLAHvWpuDRKadiCyqsoErMRx/H6+H9
	c9LWEqBCKiqnf+eQ+OLjjJtJvG4t/1
X-Google-Smtp-Source: AGHT+IFmRzImpuQKxnU59wlPaEzVIfge0eS811Rho4boK9lxVttq6F0W8N4VKTddLMFMzKY8tP/Egw==
X-Received: by 2002:a05:600c:608a:b0:475:de68:3c2e with SMTP id 5b1f17b1804b1-4775ce3ebedmr2220945e9.40.1762279806649;
        Tue, 04 Nov 2025 10:10:06 -0800 (PST)
Received: from jernej-laptop ([178.79.73.218])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477558c1a03sm24688685e9.2.2025.11.04.10.10.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 10:10:06 -0800 (PST)
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
Subject: [PATCH v2 04/30] drm/sun4i: ui_layer: Move check from update to check callback
Date: Tue,  4 Nov 2025 19:09:16 +0100
Message-ID: <20251104180942.61538-5-jernej.skrabec@gmail.com>
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

DRM requires that all checks are done in atomic_check callback. Move
one check from atomic_commit to atomic_check callback.

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
Tested-by: Ryan Walklin <ryan@testtoast.com>
Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
Changes in v2:
- fixed commit message

 drivers/gpu/drm/sun4i/sun8i_ui_layer.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun8i_ui_layer.c b/drivers/gpu/drm/sun4i/sun8i_ui_layer.c
index 9b786e5c7f3c..fce7b265c5d8 100644
--- a/drivers/gpu/drm/sun4i/sun8i_ui_layer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_ui_layer.c
@@ -134,16 +134,11 @@ static int sun8i_ui_layer_update_formats(struct sun8i_mixer *mixer, int channel,
 	struct drm_plane_state *state = plane->state;
 	const struct drm_format_info *fmt;
 	u32 val, ch_base, hw_fmt;
-	int ret;
 
 	ch_base = sun8i_channel_base(mixer, channel);
 
 	fmt = state->fb->format;
-	ret = sun8i_mixer_drm_format_to_hw(fmt->format, &hw_fmt);
-	if (ret || fmt->is_yuv) {
-		DRM_DEBUG_DRIVER("Invalid format\n");
-		return -EINVAL;
-	}
+	sun8i_mixer_drm_format_to_hw(fmt->format, &hw_fmt);
 
 	val = hw_fmt << SUN8I_MIXER_CHAN_UI_LAYER_ATTR_FBFMT_OFFSET;
 	regmap_update_bits(mixer->engine.regs,
@@ -201,7 +196,9 @@ static int sun8i_ui_layer_atomic_check(struct drm_plane *plane,
 	struct sun8i_layer *layer = plane_to_sun8i_layer(plane);
 	struct drm_crtc *crtc = new_plane_state->crtc;
 	struct drm_crtc_state *crtc_state;
-	int min_scale, max_scale;
+	const struct drm_format_info *fmt;
+	int min_scale, max_scale, ret;
+	u32 hw_fmt;
 
 	if (!crtc)
 		return 0;
@@ -211,6 +208,13 @@ static int sun8i_ui_layer_atomic_check(struct drm_plane *plane,
 	if (WARN_ON(!crtc_state))
 		return -EINVAL;
 
+	fmt = new_plane_state->fb->format;
+	ret = sun8i_mixer_drm_format_to_hw(fmt->format, &hw_fmt);
+	if (ret || fmt->is_yuv) {
+		DRM_DEBUG_DRIVER("Invalid plane format\n");
+		return -EINVAL;
+	}
+
 	min_scale = DRM_PLANE_NO_SCALING;
 	max_scale = DRM_PLANE_NO_SCALING;
 
-- 
2.51.2


