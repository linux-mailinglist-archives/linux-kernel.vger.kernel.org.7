Return-Path: <linux-kernel+bounces-855389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC9C0BE1144
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 02:12:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E30519C50E7
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 00:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9F1613AC1;
	Thu, 16 Oct 2025 00:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lach.pw header.i=@lach.pw header.b="V4y7BwB9";
	dkim=permerror (0-bit key) header.d=lach.pw header.i=@lach.pw header.b="P3fIws/q"
Received: from mail.0la.ch (mail.0la.ch [78.47.82.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30BFADDD2
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 00:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.47.82.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760573529; cv=none; b=MZeKnxHVcaGeVboqLEbgBuslBFVXQMNV+2N7UnuSHaKD0sudznRkphA3jvQoaeTvqlRZugqgPzTtDDmluQANtsSeYZv8tWCuKItUwzvOepH91JePO+u1FCdQGC8kLGu5yX79itWMwxQg2zzm9VcVOWY4c43Xd8hN0DkhJthztF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760573529; c=relaxed/simple;
	bh=a4FHSoBjX6BoMpAIQjZ21qIvYfaPRkl3B9DKry1bli8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TIURAyEQdEg/Cxg5xTlygdjKDk9Iai3XJxGIkHHq+pSl6hC6mN5dnFWNLLf+s9bNBFYxsx4iCd1knG+zoCENlsl7y3I1VFGkfksrm9fjnKRVCxAFtC3KhHyaiz6JPX38/fWLsFcDrHpmuuoX0AlGPY1nehbL3GN16NtoaVjMw5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lach.pw; spf=pass smtp.mailfrom=lach.pw; dkim=pass (2048-bit key) header.d=lach.pw header.i=@lach.pw header.b=V4y7BwB9; dkim=permerror (0-bit key) header.d=lach.pw header.i=@lach.pw header.b=P3fIws/q; arc=none smtp.client-ip=78.47.82.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lach.pw
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lach.pw
DKIM-Signature: v=1; a=rsa-sha256; s=202502r; d=lach.pw; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1760573500; bh=89tz8HOxoS8Ul81Dor63mIb
	eoHc7opGGFVAFrfMdieA=; b=V4y7BwB95WUiWAy2EKRRjQ3HGDsAqCmfV2b9hPwk/FYf+/K5zX
	qy+p/tbfUmi3CjTxdcj0u7Yb8+zaHgozPVQy1fcYnCL87EZcwePmxuNXuBzr/WmZgr84uLIjotc
	nrYPH3UXwrTz5RrZsTeTZXL8mJGtSmnQyHrKHkKJRjU3A7bNIQMI6GutRdvXDrX5gFcaWrACDja
	g5YudvcqYhm0AidM5ANDZUKhfSGAZ8QRJprMPEkm7Ja+ukm1Pfq9eFAzsOp2igJkx4JHDQjPhwG
	jkCEMtmv5j9T0lpq7iHpke3zgkINTs9Qh2aVsDaeyfc8p21TyIt4jYvK8LSm9t7OZNQ==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202502e; d=lach.pw; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1760573500; bh=89tz8HOxoS8Ul81Dor63mIb
	eoHc7opGGFVAFrfMdieA=; b=P3fIws/qQFT2boo0kZuHGd32xA/PGpsCKzMAqKuyXBgCkQlEFt
	F3+OP/rNONLl5TViA3ktIl/TMDBmgdSXLCAg==;
From: Yaroslav Bolyukin <iam@lach.pw>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Cc: Harry Wentland <harry.wentland@amd.com>,
	Leo Li <sunpeng.li@amd.com>,
	Rodrigo Siqueira <siqueira@igalia.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Wayne Lin <Wayne.Lin@amd.com>,
	amd-gfx@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	Yaroslav Bolyukin <iam@lach.pw>
Subject: [PATCH v4 2/2] drm/amd: use fixed dsc bits-per-pixel from edid
Date: Thu, 16 Oct 2025 02:10:41 +0200
Message-ID: <20251016001038.13611-6-iam@lach.pw>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251016001038.13611-2-iam@lach.pw>
References: <20251016001038.13611-2-iam@lach.pw>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

VESA vendor header from DisplayID spec may contain fixed bit per pixel
rate, it should be respected by drm driver

Signed-off-by: Yaroslav Bolyukin <iam@lach.pw>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 0d03e324d5b9..ebe5bb4eecf8 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -6521,6 +6521,11 @@ static void fill_stream_properties_from_drm_display_mode(
 
 	stream->output_color_space = get_output_color_space(timing_out, connector_state);
 	stream->content_type = get_output_content_type(connector_state);
+
+	/* DisplayID Type VII pass-through timings. */
+	if (mode_in->dsc_passthrough_timings_support && info->dp_dsc_bpp != 0) {
+		stream->timing.dsc_fixed_bits_per_pixel_x16 = info->dp_dsc_bpp;
+	}
 }
 
 static void fill_audio_info(struct audio_info *audio_info,
@@ -7067,6 +7072,13 @@ create_stream_for_sink(struct drm_connector *connector,
 					&mode, preferred_mode, scale);
 
 			preferred_refresh = drm_mode_vrefresh(preferred_mode);
+
+			/*
+			 * HACK: In case of multiple supported modes, we should look at the matching mode to decide this flag.
+			 * But what is matching mode, how should it be decided?
+			 * Assuming that only preferred mode would have this flag.
+			 */
+			mode.dsc_passthrough_timings_support = preferred_mode->dsc_passthrough_timings_support;
 		}
 	}
 
@@ -7756,7 +7768,7 @@ create_validate_stream_for_sink(struct drm_connector *connector,
 			drm_dbg_kms(connector->dev, "%s:%d Validation failed with %d, retrying w/ YUV420\n",
 				    __func__, __LINE__, dc_result);
 			aconnector->force_yuv420_output = true;
-		}
+}
 		stream = create_validate_stream_for_sink(connector, drm_mode,
 							 dm_state, old_stream);
 		aconnector->force_yuv422_output = false;
-- 
2.51.0


