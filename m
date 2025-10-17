Return-Path: <linux-kernel+bounces-858442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0747BEAF36
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 19:01:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 831ED7C5B9B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 16:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C91FD29B78E;
	Fri, 17 Oct 2025 16:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lach.pw header.i=@lach.pw header.b="hQXiHEHg";
	dkim=permerror (0-bit key) header.d=lach.pw header.i=@lach.pw header.b="lj1oZQFj"
Received: from mail.0la.ch (mail.0la.ch [78.47.82.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E11C29ACFC
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 16:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.47.82.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760718491; cv=none; b=ZmDMjxtb9S4LAKQOKlBDywX7qXvt5GtkAknKvYL3uplvWjW2ngxmdoQIs66EdWi42f7XGQjeb5QxD6T+18B+MwmiFfS4crIQqKkyMAuog1fg3AUNmKviDAdmuyLfBdQSiKTvMLYbayCd4NxfKeRqsce0cUzcVjz/hfbE/UjjdSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760718491; c=relaxed/simple;
	bh=XlyX9KmI/7XEg1SE673Vd3+JhEoYiltwfGu9yc/mFYQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YFeFyHRuFhe13GBOWvRHnMKdMj7FcJk1XXlPzp3peYYv3UiqH/2uO5tr1k64sU1BCtAllN7yifA4Q8pqg+0n6rDK4yUFwLaoBBakML28fIIU/AjEF2ZqEtulwQtDmsxO9bV3k6lJnIrb0olFCvsNE8DRo8yYkBgoRfTsTS3MM3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lach.pw; spf=pass smtp.mailfrom=lach.pw; dkim=pass (2048-bit key) header.d=lach.pw header.i=@lach.pw header.b=hQXiHEHg; dkim=permerror (0-bit key) header.d=lach.pw header.i=@lach.pw header.b=lj1oZQFj; arc=none smtp.client-ip=78.47.82.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lach.pw
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lach.pw
DKIM-Signature: v=1; a=rsa-sha256; s=202502r; d=lach.pw; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1760718487; bh=poaIqRqvW/uM6YSuZpkgeWn
	8oXL5zJSPHa0GURysBWg=; b=hQXiHEHgbNGumN4uXpV4/QfOhrrJYnQTiZYptd3kmnbwfH21NV
	gTg+0dehgMMYuRAaaOSxv6zstyW2s4vxzy6bT9Nbgi7r9L4LoHPM4NIjYmP12a/nj1RoXm3kYJJ
	+u+Gr3YqyhkO4cLk8BvVMMhOOzMMJViBphul/+9WLRYkyd+3/HqXHVlRqoIn3tMq/Jgv7R0FTD6
	VZfPM6vYOgZ2bgSzzIOgb+U6x01xPKf0z/CfYWGFxFGNtcW/r78KYt8u+gQhAx5gzB0X02HODpR
	ICpFifwURi85sz8Jnwn2WODzWHugEWQc70p7Y70mXOGK+/2+jq0/7gPea7VKKwRKl/A==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202502e; d=lach.pw; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1760718487; bh=poaIqRqvW/uM6YSuZpkgeWn
	8oXL5zJSPHa0GURysBWg=; b=lj1oZQFjZZbnx7CmhOCMZqlySVx9AnTa8jFvbWHCJ+IetpHg0F
	rwQ4t8cbVg1AUpFWpoBUHuDkKCAHdCovqiCA==;
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
Subject: [PATCH v5 5/7] drm/edid: for consistency, use mask everywhere for block rev parsing
Date: Fri, 17 Oct 2025 18:27:34 +0200
Message-ID: <20251017162736.45368-6-iam@lach.pw>
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

Signed-off-by: Yaroslav Bolyukin <iam@lach.pw>
---
 drivers/gpu/drm/drm_displayid_internal.h | 1 +
 drivers/gpu/drm/drm_edid.c               | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_displayid_internal.h b/drivers/gpu/drm/drm_displayid_internal.h
index 8ea20b1c6921..38f9d628e2d6 100644
--- a/drivers/gpu/drm/drm_displayid_internal.h
+++ b/drivers/gpu/drm/drm_displayid_internal.h
@@ -139,6 +139,7 @@ struct displayid_formula_timings_9 {
 	u8 vrefresh;
 } __packed;
 
+#define DISPLAYID_BLOCK_DESCRIPTOR_PAYLOAD_BYTES	GENMASK(6, 4)
 struct displayid_formula_timing_block {
 	struct displayid_block base;
 	struct displayid_formula_timings_9 timings[];
diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
index a1dc4331c4cb..4fa39989e446 100644
--- a/drivers/gpu/drm/drm_edid.c
+++ b/drivers/gpu/drm/drm_edid.c
@@ -6903,7 +6903,8 @@ static int add_displayid_formula_modes(struct drm_connector *connector,
 	struct drm_display_mode *newmode;
 	int num_modes = 0;
 	bool type_10 = block->tag == DATA_BLOCK_2_TYPE_10_FORMULA_TIMING;
-	int timing_size = 6 + ((formula_block->base.rev & 0x70) >> 4);
+	int timing_size = 6 +
+		FIELD_GET(DISPLAYID_BLOCK_DESCRIPTOR_PAYLOAD_BYTES, formula_block->base.rev);
 
 	/* extended blocks are not supported yet */
 	if (timing_size != 6)
-- 
2.51.0


