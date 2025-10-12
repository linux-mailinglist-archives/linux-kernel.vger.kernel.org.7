Return-Path: <linux-kernel+bounces-849694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93A39BD0B4B
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 21:24:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D8F23BF830
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 19:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 475942EBBA3;
	Sun, 12 Oct 2025 19:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mzg2CY/A"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E50FD2F25FB
	for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 19:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760297027; cv=none; b=i+5jYe4RYdx+QnPr3mIvMjcxAEZKg605OjT/ZFZj3bwhjxu6WiqrBCVfzczAzRTCD0NLFRxNptOskKEaCbPyrMOdYsBNxDoYIiozEW9S7flMJgk7Z1UAmD0B7cnj3uG/cdBGTnpDuZZPzFpRzDkq8KB/hl+oh/oVutaS0QH7vVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760297027; c=relaxed/simple;
	bh=u4zJwCXU32S2DxFOU42pX3PwMRTkMmLg20q8/nGcEqc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PwcUN0DIdQ32YwZap2cgxbibtv0SFF3PVfBdK9elxJbZy6Ym7MYqr+iVLKj3rLblami1G0N3HaIk+r2YBtvZ5JwkdkwVzT4QbKig1p4RWoqg9rkcjMwFsKvCX2QWN84iNfBxTR/G+ljL7qyQq6+j+2OuHbXWo95NxSuWfimhO98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mzg2CY/A; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b4539dddd99so728691866b.1
        for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 12:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760297024; x=1760901824; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fXCSCCah2zJTGYn4GhhYKHAkgqZ3YCUPfwGM8ymVWuc=;
        b=mzg2CY/AcUnqlPKiQTqTfXo1LlwpatB3Hq5OfEYIfZIwuMuh8Qsz1Of4opSpPiHLNr
         WLPbcg09PyWkt7PK4BXJFB1kvI3moykcSrC3NOWgJdtPBkA2GA9KxETvGz95PUfh2Xco
         QIZDflhHNRLpaUXEw5GTd1TwbkplNSUeKF9XjyKN6xqPungsU8USm0ZJANdQJheSW8Ay
         ymAmJil69aqaDK6He+Qa8gBdTQgjB3E+tBmA/dIcO4faul0h+GCvCf6QEe1YANCA1wgQ
         nftUnrOnpJq8YU7WU7YMj0bUEfxqcULBPW7an/VwqvoYnZZQTEwlui7lKMLv0VWAjpyz
         +uKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760297024; x=1760901824;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fXCSCCah2zJTGYn4GhhYKHAkgqZ3YCUPfwGM8ymVWuc=;
        b=YC2P3tYEZMnSgZpnfH35/Yv/EWU/frARJg4WVNm7W8VaOtXF68dXlnNK04frZTfXJc
         2AaFqaGUqTUX9jdrlcoOyZqlgeuCxiVGxUcUQQNMe3RhBePDlRE7mOnzlgsYBIC4Pv/A
         RyXT5tZEl0FbD0q/kd+cb1SlXVKITLZN85fh159MyOfl3qPfVg9uuZExwglWfv/KK+Zw
         f0TxeZoASM33Day5uo7Wgz+fZuH6R9ZjpWn7B67v6uUBjk8BL0AsAg4Aaa0OtFyQ6fdH
         UvOON2znLI4t2hJ4107xx6iG6viD3XVC+UVcVyu2BT/0iCOp30/V/ciJN9o+E3UM8fCT
         cWNg==
X-Forwarded-Encrypted: i=1; AJvYcCW7AemfEwQj7dYiDMuy1l16iYittabEyU5Fs/1YTwLlYit9yeay7AtuDMyz6DY7HAufw2DBCCxX/6jx8dE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfSZQGzAZs4G0YR+QNmeUK8+rnFpH3mv10qQFIpKOk31i9Je31
	HggJHLaW9urtPBMD/DJp9VbFsW7h7fzVEAOSttpqZFSIfQ+dF0nYMve/
X-Gm-Gg: ASbGncv82Fbt2RQcpYSlbCSRFDzkP2hp4p6NWRx+oRcRgrzFL8CwBSVaKqu5MT0luFd
	RqWmkp6g1OxT3+R5qulebbXps57FbhFuwxhBPso0AKa9AXzc/uAcdW8KCixSOOzMsnk15EXo7zH
	L+Xjia+BYz+iinstV+nieeSj4a62iaI29+t3Wy/dVYLbK2BdcYNiVRb0MbuskDIr7Ir/wYD4Hze
	qAdyN5/3pn78Dn7pOw59kBRXkX0IKKLNfSqhmg/2jpkt4vKIrZLNcnTIXe1KvjZ6ZOK8NXJSxNJ
	InOwEgQCGRg+EHB+th0Nystq9PjNKsL0vCKc/cXnOVSFCVCLKnzXWTHyY+tcT01od0WCZxLHI8f
	XfIqhU/N5KmFLDTwn1Z7ptXm6mZS8cV18xTVEIBuMj6aj5flgs8X1ChLdQTyWN5PjcNCqmaznYG
	rZQD9VpOvYhEpvh+h8E6+zJZ68+yMerLl6G6zOBFlZXQ==
X-Google-Smtp-Source: AGHT+IEiNoS/+6UzRTSzo2B8Y29/AU5s+BLBdQ9yTmKb3fJBI9Fgd7dqesLSL2/Rv8CrMfvApRR4kg==
X-Received: by 2002:a17:906:f584:b0:b43:b7ec:b8a1 with SMTP id a640c23a62f3a-b50aa38724bmr1988751866b.24.1760297024252;
        Sun, 12 Oct 2025 12:23:44 -0700 (PDT)
Received: from jernej-laptop (178-79-73-218.dynamic.telemach.net. [178.79.73.218])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b55d67d8283sm760176466b.38.2025.10.12.12.23.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Oct 2025 12:23:43 -0700 (PDT)
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
Subject: [PATCH 04/30] drm/sun4i: ui_layer: Move check from update to check callback
Date: Sun, 12 Oct 2025 21:23:04 +0200
Message-ID: <20251012192330.6903-5-jernej.skrabec@gmail.com>
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

DRM requires that all checks are done in atomic_check callback. Move
one check from atomic_commit to atomic_update callback.

Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
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
2.51.0


