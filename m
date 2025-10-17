Return-Path: <linux-kernel+bounces-858445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83570BEACE3
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 18:41:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E30794308C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 16:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6948028B4FE;
	Fri, 17 Oct 2025 16:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lach.pw header.i=@lach.pw header.b="a78LpD75";
	dkim=permerror (0-bit key) header.d=lach.pw header.i=@lach.pw header.b="40Cjxs8R"
Received: from mail.0la.ch (mail.0la.ch [78.47.82.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB25299AB4
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 16:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.47.82.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760718499; cv=none; b=dvF0ItDH69PEvgnUyO8jzPxPrf64a2ZZfixvYczagOCC8iTRAiIUiSmQj43sHcRo9Xvbh0lqCMtOvLCsGrJoN8BXYcjEg9i3iryrc6hLemuLUmJoueNH4Jf+OHjdpAR73/E86uhvZDxhQD7IciqzmARrQqrUbCczWiWDKmThLqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760718499; c=relaxed/simple;
	bh=TGgNbmie2d2l+C4DMiHoryTY1ekn3hrtWDQmEiYx2F0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iVkys1k5l2IrXPm5hZxuXTPvAdO1b3xRI7MkAcLTdI2e3IKCtdtvVrHZrhCt+hy5DgHA4PNQGH4enkPcGUZrgl8U9X/j9FhrMXx0efAvQvHWtGQrsKmbR5nc9obSkYl8mVig2wqR0FrMWwTBDC8Lg8HBIiImQ98WO8a1HMI6YTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lach.pw; spf=pass smtp.mailfrom=lach.pw; dkim=pass (2048-bit key) header.d=lach.pw header.i=@lach.pw header.b=a78LpD75; dkim=permerror (0-bit key) header.d=lach.pw header.i=@lach.pw header.b=40Cjxs8R; arc=none smtp.client-ip=78.47.82.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lach.pw
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lach.pw
DKIM-Signature: v=1; a=rsa-sha256; s=202502r; d=lach.pw; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1760718488; bh=JSILuT7pxts1tl7Z9YYelL4
	TmLbyDJQ7KE/9p1BUbKg=; b=a78LpD75Oy+5RSAYuG1Ad3igqSxkA/aaYy1kl/Lres7H1uLFY9
	Y8+bfivC3peLK1X/6ztDKt20/G6lePd8va/o84E0fnUP/vze9e9w5B1a6VI2xWA0L5FFmXISTFz
	Qoo09/JrRhWyp3Fgtv7J/V1tPZryXpzKsBVvv08cYzL8CEvhjGidrwNUCGSkx8DdS5hB78GNK8k
	OQ0IxX1zcbBwzr9pXg3YNQwuk2efL/JLLDpTO+lEpPFEEhxX73c+Ll73z0NUx5g4V08J5l7O4tP
	fItkk+we9a6m1uoEyeWzA/ixzZRqC5v5SObL2uoRiMxIGNTRpg4vqb7QcgpCptjmBzg==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202502e; d=lach.pw; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1760718488; bh=JSILuT7pxts1tl7Z9YYelL4
	TmLbyDJQ7KE/9p1BUbKg=; b=40Cjxs8RtzhDNUVM89j9X11MTt2BAGg6c5VL3Q0FsquerniJaE
	BW+ra851ecf2mDHc3m9w1Kf/YqiFapW8RTBQ==;
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
Subject: [PATCH v5 6/7] drm/edid: parse DRM VESA dsc bpp target
Date: Fri, 17 Oct 2025 18:27:35 +0200
Message-ID: <20251017162736.45368-7-iam@lach.pw>
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

As per DisplayID v2.1a spec "DSC pass-through timing support",
VESA vendor-specific data block may contain target DSC bits per pixel
fields, that should be always used for the VII modes that declare they
only support working with this value (Pass-through Timing Support for
Target DSC Bits per Pixel).

Signed-off-by: Yaroslav Bolyukin <iam@lach.pw>
---
 drivers/gpu/drm/drm_displayid_internal.h |  4 ++++
 drivers/gpu/drm/drm_edid.c               | 16 ++++++++++++++++
 include/drm/drm_connector.h              |  6 ++++++
 3 files changed, 26 insertions(+)

diff --git a/drivers/gpu/drm/drm_displayid_internal.h b/drivers/gpu/drm/drm_displayid_internal.h
index 38f9d628e2d6..7246ffdcd908 100644
--- a/drivers/gpu/drm/drm_displayid_internal.h
+++ b/drivers/gpu/drm/drm_displayid_internal.h
@@ -148,6 +148,8 @@ struct displayid_formula_timing_block {
 #define DISPLAYID_VESA_DP_TYPE		GENMASK(2, 0)
 #define DISPLAYID_VESA_MSO_OVERLAP	GENMASK(3, 0)
 #define DISPLAYID_VESA_MSO_MODE		GENMASK(6, 5)
+#define DISPLAYID_VESA_DSC_BPP_INT	GENMASK(5, 0)
+#define DISPLAYID_VESA_DSC_BPP_FRACT	GENMASK(3, 0)
 
 #define DISPLAYID_VESA_DP_TYPE_EDP	0
 #define DISPLAYID_VESA_DP_TYPE_DP	1
@@ -157,6 +159,8 @@ struct displayid_vesa_vendor_specific_block {
 	u8 oui[3];
 	u8 data_structure_type;
 	u8 mso;
+	u8 dsc_bpp_int;
+	u8 dsc_bpp_fract;
 } __packed;
 
 /*
diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
index 4fa39989e446..1c51158fa3a3 100644
--- a/drivers/gpu/drm/drm_edid.c
+++ b/drivers/gpu/drm/drm_edid.c
@@ -6588,6 +6588,21 @@ static void drm_parse_vesa_specific_block(struct drm_connector *connector,
 			    connector->base.id, connector->name,
 			    info->mso_stream_count, info->mso_pixel_overlap);
 	}
+
+	if (block->num_bytes < 7) {
+		/* DSC bpp is optional */
+		return;
+	}
+
+	info->dp_dsc_bpp_x16 = FIELD_GET(DISPLAYID_VESA_DSC_BPP_INT, vesa->dsc_bpp_int) << 4 |
+			       FIELD_GET(DISPLAYID_VESA_DSC_BPP_FRACT, vesa->dsc_bpp_fract);
+
+	if (info->dp_dsc_bpp_x16 > 0) {
+		drm_dbg_kms(connector->dev,
+			    "[CONNECTOR:%d:%s] DSC bits per pixel x16 %u\n",
+			    connector->base.id, connector->name,
+			    info->dp_dsc_bpp_x16);
+	}
 }
 
 static void drm_update_vesa_specific_block(struct drm_connector *connector,
@@ -6636,6 +6651,7 @@ static void drm_reset_display_info(struct drm_connector *connector)
 	info->mso_stream_count = 0;
 	info->mso_pixel_overlap = 0;
 	info->max_dsc_bpp = 0;
+	info->dp_dsc_bpp_x16 = 0;
 
 	kfree(info->vics);
 	info->vics = NULL;
diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
index 8f34f4b8183d..7decfc288aa3 100644
--- a/include/drm/drm_connector.h
+++ b/include/drm/drm_connector.h
@@ -837,6 +837,12 @@ struct drm_display_info {
 	 */
 	u32 max_dsc_bpp;
 
+	/**
+	 * @dp_dsc_bpp: DP Display-Stream-Compression (DSC) timing's target
+	 * DSC bits per pixel in 6.4 fixed point format. 0 means undefined.
+	 */
+	u16 dp_dsc_bpp_x16;
+
 	/**
 	 * @vics: Array of vics_len VICs. Internal to EDID parsing.
 	 */
-- 
2.51.0


