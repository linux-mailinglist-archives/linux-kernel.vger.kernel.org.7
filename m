Return-Path: <linux-kernel+bounces-858446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6B35BEAB4D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 18:29:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 870B91AE041B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 16:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF40C2BEC4E;
	Fri, 17 Oct 2025 16:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lach.pw header.i=@lach.pw header.b="Zsy8CkoL";
	dkim=permerror (0-bit key) header.d=lach.pw header.i=@lach.pw header.b="/wCOTQlk"
Received: from mail.0la.ch (mail.0la.ch [78.47.82.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B232877C2
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 16:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.47.82.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760718503; cv=none; b=Jmk1qSjuduB4yRtOLyYj6XBvhUwGQ9fM+9v3m2Gu08mLUyp6C3pDmqJKUhLJ8G6kRVhiU1OYbaq2XK/WLKA7p4YHt0K6GaVb9HHtpT9nM+LwiFmoINzYi5GiVNNsdXT+dVNWkzZiZNKgR2cg3pnOzsp8t+6CxMEydjzeYtvegEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760718503; c=relaxed/simple;
	bh=JO+zCEoLR5+AqKWtcuvPiErpr3/jceX5afNZook+voo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FINmyMoXpv4+rTx8toXJ5bWEl2+06YgaGtBB+26YFEGQ9EVvEgcZ6+ByxFiG49f1U5WfEU/cJOOyu9xzj1DYfGWGFuquxF0f/mAX8Q6ld2uvcIL+iZTyfXygDV8/Kt4QvM8j11xDQpyuOgEpF0wj+BZ1/LDfvKwntxBiR4Uf2pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lach.pw; spf=pass smtp.mailfrom=lach.pw; dkim=pass (2048-bit key) header.d=lach.pw header.i=@lach.pw header.b=Zsy8CkoL; dkim=permerror (0-bit key) header.d=lach.pw header.i=@lach.pw header.b=/wCOTQlk; arc=none smtp.client-ip=78.47.82.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lach.pw
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lach.pw
DKIM-Signature: v=1; a=rsa-sha256; s=202502r; d=lach.pw; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1760718480; bh=FySvhxgkGPeEce3SsSP+zgs
	Qe5XpsgsiK22GvDAXT0k=; b=Zsy8CkoLpRzeAbXtMsK6wQjVizDFWmG3thi/0CONQLus7t9j5U
	JThsjA9WaEZeoVWq1xKeEGOVhDV+EP834vWlBnPDDMeASDoQGcFPUPmFZsW5Ot+cfz5UJ4xgBGT
	iBXETSCf3duhdBMqmjT17cNKBHv/KuycDTBSiDBOyHirN2hOIGs4jAm5m15D817PI00wBEAGQHP
	80Ol+PaCpbh6ewQbXZpJdXWk+72G8mwmcPh1j3x9ks46pR3pLC065KNb2q8uWdKgH2KWCQDm4RP
	+S3/DM+hmsrnXm2JJQlCaNCl8AE43Px6Qo/x4XGSFHXyQIqSWJASjeNInD8FKrMOtuw==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202502e; d=lach.pw; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1760718480; bh=FySvhxgkGPeEce3SsSP+zgs
	Qe5XpsgsiK22GvDAXT0k=; b=/wCOTQlktcCTumqs5csZjjrMi5y+59YiUCTusdRmhNkAAAb09t
	eGt75Fe5zYX/qe1hgFPI4uSLjhXSU+2ddmDQ==;
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
Subject: [PATCH v5 1/7] drm/edid: rename VESA block parsing functions to more generic name
Date: Fri, 17 Oct 2025 18:27:30 +0200
Message-ID: <20251017162736.45368-2-iam@lach.pw>
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

Those functions would also parse DSC Bits Per Pixel value in the future
commits.

Signed-off-by: Yaroslav Bolyukin <iam@lach.pw>
---
 drivers/gpu/drm/drm_edid.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
index e2e85345aa9a..4fcde52291ce 100644
--- a/drivers/gpu/drm/drm_edid.c
+++ b/drivers/gpu/drm/drm_edid.c
@@ -6524,8 +6524,8 @@ static void drm_get_monitor_range(struct drm_connector *connector,
 		    info->monitor_range.min_vfreq, info->monitor_range.max_vfreq);
 }
 
-static void drm_parse_vesa_mso_data(struct drm_connector *connector,
-				    const struct displayid_block *block)
+static void drm_parse_vesa_specific_block(struct drm_connector *connector,
+					  const struct displayid_block *block)
 {
 	struct displayid_vesa_vendor_specific_block *vesa =
 		(struct displayid_vesa_vendor_specific_block *)block;
@@ -6584,8 +6584,8 @@ static void drm_parse_vesa_mso_data(struct drm_connector *connector,
 		    info->mso_stream_count, info->mso_pixel_overlap);
 }
 
-static void drm_update_mso(struct drm_connector *connector,
-			   const struct drm_edid *drm_edid)
+static void drm_update_vesa_specific_block(struct drm_connector *connector,
+					   const struct drm_edid *drm_edid)
 {
 	const struct displayid_block *block;
 	struct displayid_iter iter;
@@ -6593,7 +6593,7 @@ static void drm_update_mso(struct drm_connector *connector,
 	displayid_iter_edid_begin(drm_edid, &iter);
 	displayid_iter_for_each(block, &iter) {
 		if (block->tag == DATA_BLOCK_2_VENDOR_SPECIFIC)
-			drm_parse_vesa_mso_data(connector, block);
+			drm_parse_vesa_specific_block(connector, block);
 	}
 	displayid_iter_end(&iter);
 }
@@ -6753,7 +6753,7 @@ static void update_display_info(struct drm_connector *connector,
 	if (edid->features & DRM_EDID_FEATURE_RGB_YCRCB422)
 		info->color_formats |= DRM_COLOR_FORMAT_YCBCR422;
 
-	drm_update_mso(connector, drm_edid);
+	drm_update_vesa_specific_block(connector, drm_edid);
 
 out:
 	if (drm_edid_has_internal_quirk(connector, EDID_QUIRK_NON_DESKTOP)) {
-- 
2.51.0


