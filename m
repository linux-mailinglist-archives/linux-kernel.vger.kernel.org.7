Return-Path: <linux-kernel+bounces-858444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 25E08BEAB44
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 18:28:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4A53535F325
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 16:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E456296BD6;
	Fri, 17 Oct 2025 16:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lach.pw header.i=@lach.pw header.b="EFplJfyJ";
	dkim=permerror (0-bit key) header.d=lach.pw header.i=@lach.pw header.b="U5669QGm"
Received: from mail.0la.ch (mail.0la.ch [78.47.82.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C2E29BDBA
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 16:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.47.82.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760718496; cv=none; b=MKQOp2c/JBRkETeWzMUzzvPBZF0V1811LPFWaybikclY5TdfeRr4R69fLkegsPK1p47AyfXLTcZj8Of9q56GCueEysipyWHDNSrZJNajYuFcoRSRr5pdnNvDSwRSIINO47dq4FoYVKhLMVxDWn0p6NG/8XoQU+xgsT/EVdg3p4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760718496; c=relaxed/simple;
	bh=4oAEoeB1mFtG0XtyAa/+4j5yC1oh80L70QHYtqE4Fm4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bdDVoB3I49pG7GquPi6iWwHqIeBQ2QX2BTvFiwIbrISrZOwjmDyChAdaD7C6ObkXPZq8yJAU5ccAkrfECRBpeQ9JPeBw7Fnq8wED5j/qAMayIq7rltVY85rWjCtV1U5Urstu3Un60MZjqvS7PxiGkc3qc4noEJVSGGZr1Wphwsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lach.pw; spf=pass smtp.mailfrom=lach.pw; dkim=pass (2048-bit key) header.d=lach.pw header.i=@lach.pw header.b=EFplJfyJ; dkim=permerror (0-bit key) header.d=lach.pw header.i=@lach.pw header.b=U5669QGm; arc=none smtp.client-ip=78.47.82.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lach.pw
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lach.pw
DKIM-Signature: v=1; a=rsa-sha256; s=202502r; d=lach.pw; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1760718490; bh=i9hlKm1uSeiiZmxzIePKHJs
	FghgJVFB5WZw8+mDTUPw=; b=EFplJfyJJoitcPwcsbwdy5k+puBP4RaTYvZTqH9xG370gTOVM7
	XtE8rWdlfVFMjmFRtdOsP/VLtK66hH9TnLelszHq2b/+CT+8h0QZ/ONMvu5rpfYscdYeIigU9lu
	1MBXlw5nsHTjjbpr+v6RoZddAkCvP8gZN9Z41Rc4y/kjvS9Plzi8v+k5TfjEgCt2Wg3c6e872wh
	HnIHrCdnUv2mdd+9Bo2uG21vDYxnRsbM2qgNXWTYFfaHeWNitMSDU3VM5JziYPnxVNLp3TFXIKI
	jLxh28X/CsPgY/RS6d+PiKNGplYVecmPZWjVIZsrX0V+/iR6shghgbvHRmGGniXSaDQ==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202502e; d=lach.pw; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1760718490; bh=i9hlKm1uSeiiZmxzIePKHJs
	FghgJVFB5WZw8+mDTUPw=; b=U5669QGmRWqlZWa8ap/q7ljLN8cyBMgPlOdCAOoNMt4IoTM9TD
	6K8Lm8Rqi+8ozJiDsbA0M3nmpAFHyPl2q3Dg==;
From: Yaroslav Bolyukin <iam@lach.pw>
To: =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
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
Subject: [PATCH v5 7/7] drm/amd: use fixed dsc bits-per-pixel from edid
Date: Fri, 17 Oct 2025 18:27:36 +0200
Message-ID: <20251017162736.45368-8-iam@lach.pw>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017162736.45368-1-iam@lach.pw>
References: <20251017162736.45368-1-iam@lach.pw>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

VESA vendor header from DisplayID spec may contain fixed bit per pixel
rate, it should be used by drm driver for the modes that declare
they are only supported with the declared fixed bits per pixel value.

It is however unclear how to deal with the modes created from userspace.
Current implementation assumes that fixed bits per pixel value should
always be used if the preferred display mode has this flag set, which is
the case for all the known hardware.

Signed-off-by: Yaroslav Bolyukin <iam@lach.pw>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 0d03e324d5b9..739d5dabcf41 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -6521,6 +6521,11 @@ static void fill_stream_properties_from_drm_display_mode(
 
 	stream->output_color_space = get_output_color_space(timing_out, connector_state);
 	stream->content_type = get_output_content_type(connector_state);
+
+	/* DisplayID Type VII pass-through timings. */
+	if (mode_in->dsc_passthrough_timings_support && info->dp_dsc_bpp_x16 != 0) {
+		stream->timing.dsc_fixed_bits_per_pixel_x16 = info->dp_dsc_bpp_x16;
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
 
-- 
2.51.0


