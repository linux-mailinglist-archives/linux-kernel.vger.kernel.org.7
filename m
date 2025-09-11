Return-Path: <linux-kernel+bounces-812635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B1CEBB53AB4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 19:49:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C979566AEE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 17:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A659D35A2B3;
	Thu, 11 Sep 2025 17:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EFvG700E"
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA32362081
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 17:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757612973; cv=none; b=K8C09bRlxzLM57+BPvRS9sjJ/0f8THbcjAbV/iHw8zY46vzQUkIVNGe1Rm2+SL7aew2kAoP8MAlW45P/zp4tcqxD9pCZyQv1ejzyuy9kGb84Nm8JU/b2dn5sV4HWupdUcpTOeUkc78VZ03/vzgSv2ky7J0pGHdFK7jFRLU4MeKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757612973; c=relaxed/simple;
	bh=wlwojsA7LzX49/RHPo5R55BGPt7j0cpIigJ0mzMY7C8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LZujn3SVerCADxVX6MQcLVyGholgNgnvIpuNz6bxX5Wg3OwKzWa/EZ85CsEkvmxGX2aGYMIisCONzVzVTHMixsqV7KcqewUQy+/dzG90XRYArZL6VYohvualPNnF7LB2CDcqF8igSgRe9PC+Jk0qll7sbuWddQxJDgjdLW9s0sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EFvG700E; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757612963;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=lMLhoZdhoWhFz7FF9+I0+eNAAPfeFR/F2M6sYRcTU34=;
	b=EFvG700EnBtme1kNOJANhvuLWC3f0OpetSn862Is355HfA9hea3hPwqt59QYyxlVudrkeW
	bBVB9+VD5Ob5ygn9WF/PuIGMFWHI/jsI6Pf9n0CBhHiTd6aFlZKDieq9yjVTD3woQAn/sB
	QVpJqMPazmLDPG82/IY5h5Px87YuVhI=
From: Matthew Schwartz <matthew.schwartz@linux.dev>
To: chiahsuan.chung@amd.com,
	alexander.deucher@amd.com,
	harry.wentland@amd.com,
	simona@ffwll.ch,
	airlied@gmail.com,
	sunpeng.li@amd.com
Cc: amd-gfx@lists.freedesktop.org,
	zaeem.mohamed@amd.com,
	mario.limonciello@amd.com,
	misyl@froggi.es,
	linux-kernel@vger.kernel.org,
	Matthew Schwartz <matthew.schwartz@linux.dev>
Subject: [PATCH v2] drm/amd/display: Only restore backlight after amdgpu_dm_init or dm_resume
Date: Thu, 11 Sep 2025 10:48:51 -0700
Message-ID: <20250911174851.2767335-1-matthew.schwartz@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On clients that utilize AMD_PRIVATE_COLOR properties for HDR support,
brightness sliders can include a hardware controlled portion and a
gamma-based portion. This is the case on the Steam Deck OLED when using
gamescope with Steam as a client.

When a user sets a brightness level while HDR is active, the gamma-based
portion and/or hardware portion are adjusted to achieve the desired
brightness. However, when a modeset takes place while the gamma-based
portion is in-use, restoring the hardware brightness level overrides the
user's overall brightness level and results in a mismatch between what
the slider reports and the display's current brightness.

To avoid overriding gamma-based brightness, only restore HW backlight
level after boot or resume. This ensures that the backlight level is
set correctly after the DC layer resets it while avoiding interference
with subsequent modesets.

Fixes: 7875afafba84 ("drm/amd/display: Fix brightness level not retained over reboot")
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4551
Signed-off-by: Matthew Schwartz <matthew.schwartz@linux.dev>
---
v2: Drop set_backlight_level and use dm->restore_backlight in
amdgpu_dm_commit_streams
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 12 ++++++++----
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  7 +++++++
 2 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 7808a647a306c..2a5fa85505e84 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2037,6 +2037,8 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 
 	dc_hardware_init(adev->dm.dc);
 
+	adev->dm.restore_backlight = true;
+
 	adev->dm.hpd_rx_offload_wq = hpd_rx_irq_create_workqueue(adev);
 	if (!adev->dm.hpd_rx_offload_wq) {
 		drm_err(adev_to_drm(adev), "failed to create hpd rx offload workqueue.\n");
@@ -3407,6 +3409,7 @@ static int dm_resume(struct amdgpu_ip_block *ip_block)
 		dc_set_power_state(dm->dc, DC_ACPI_CM_POWER_STATE_D0);
 
 		dc_resume(dm->dc);
+		adev->dm.restore_backlight = true;
 
 		amdgpu_dm_irq_resume_early(adev);
 
@@ -9802,7 +9805,6 @@ static void amdgpu_dm_commit_streams(struct drm_atomic_state *state,
 	bool mode_set_reset_required = false;
 	u32 i;
 	struct dc_commit_streams_params params = {dc_state->streams, dc_state->stream_count};
-	bool set_backlight_level = false;
 
 	/* Disable writeback */
 	for_each_old_connector_in_state(state, connector, old_con_state, i) {
@@ -9922,7 +9924,6 @@ static void amdgpu_dm_commit_streams(struct drm_atomic_state *state,
 			acrtc->hw_mode = new_crtc_state->mode;
 			crtc->hwmode = new_crtc_state->mode;
 			mode_set_reset_required = true;
-			set_backlight_level = true;
 		} else if (modereset_required(new_crtc_state)) {
 			drm_dbg_atomic(dev,
 				       "Atomic commit: RESET. crtc id %d:[%p]\n",
@@ -9979,13 +9980,16 @@ static void amdgpu_dm_commit_streams(struct drm_atomic_state *state,
 	 * to fix a flicker issue.
 	 * It will cause the dm->actual_brightness is not the current panel brightness
 	 * level. (the dm->brightness is the correct panel level)
-	 * So we set the backlight level with dm->brightness value after set mode
+	 * So we set the backlight level with dm->brightness value after initial
+	 * set mode. Use restore_backlight flag to avoid setting backlight level
+	 * for every subsequent mode set.
 	 */
-	if (set_backlight_level) {
+	if (dm->restore_backlight) {
 		for (i = 0; i < dm->num_of_edps; i++) {
 			if (dm->backlight_dev[i])
 				amdgpu_dm_backlight_set_level(dm, i, dm->brightness[i]);
 		}
+		dm->restore_backlight = false;
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index b937da0a4e4a0..6aae51c1beb36 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -610,6 +610,13 @@ struct amdgpu_display_manager {
 	 */
 	u32 actual_brightness[AMDGPU_DM_MAX_NUM_EDP];
 
+	/**
+	 * @restore_backlight:
+	 *
+	 * Flag to indicate whether to restore backlight after modeset.
+	 */
+	bool restore_backlight;
+
 	/**
 	 * @aux_hpd_discon_quirk:
 	 *
-- 
2.51.0


