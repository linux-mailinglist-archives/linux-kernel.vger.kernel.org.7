Return-Path: <linux-kernel+bounces-892637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D28CC45802
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 10:04:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 279883A8CB4
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 09:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 470BB2FDC23;
	Mon, 10 Nov 2025 09:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="isisVvWW"
Received: from mail-m1973191.qiye.163.com (mail-m1973191.qiye.163.com [220.197.31.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581C92F531F
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 09:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762765445; cv=none; b=TXsgkfZLk2BkcpHjrXFJQ+rYECUNvXRAIpIrIdX1RnY6BahEdxler/GKsHfyZB6S1zYkm6Y3tIyaMfLgMjt7JlTIrA1UVOtgDXSE6YTUa6Vqm0sbUhLmQ9wKE9dGpNO1GNbnd0xvA0qgy7iaqp7JJ1nYNkw5k8z9IbXORudXc+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762765445; c=relaxed/simple;
	bh=yvC+CCFGt3Y5FviGJEXi9s2h/Xa/HmtxK69tea4rtAg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rNgohlm/eIxgQzchGtegwn61toIr52LXkJMC7tECmwIcbz0ygTHjE04rIkX3/EG1ELeFkcQZf3l8saJB7Lpa0gHSbK3ZZDsLJFU9N3y2uBGOfsegxK6ltgcNxnEckIJnCFxMWczUOBghqQNBBUFQquV8vsgBg8NT9V7XVPIF0s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=isisVvWW; arc=none smtp.client-ip=220.197.31.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from zyb-HP-ProDesk-680-G2-MT.. (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 29068b519;
	Mon, 10 Nov 2025 16:58:45 +0800 (GMT+08:00)
From: Damon Ding <damon.ding@rock-chips.com>
To: andrzej.hajda@intel.com,
	neil.armstrong@linaro.org,
	rfoss@kernel.org
Cc: Laurent.pinchart@ideasonboard.com,
	jonas@kwiboo.se,
	jernej.skrabec@gmail.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	dmitry.baryshkov@oss.qualcomm.com,
	dianders@chromium.org,
	m.szyprowski@samsung.com,
	andy.yan@rock-chips.com,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Damon Ding <damon.ding@rock-chips.com>
Subject: [PATCH v3 2/4] drm/bridge: analogix_dp: Apply DP helper API drm_dp_clock_recovery_ok()
Date: Mon, 10 Nov 2025 16:58:21 +0800
Message-Id: <20251110085823.1197472-3-damon.ding@rock-chips.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251110085823.1197472-1-damon.ding@rock-chips.com>
References: <20251110085823.1197472-1-damon.ding@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9a6cfd38cd03a3kunm91e8d29910ac5a4
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQx8dQlZDTx0aShkaSUgeQ05WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=isisVvWW6T9/iEDC2gXGFaFeJK7H2lY8LqNlkzY9ZqHUMxzmokU0h7An+20xhBdN+6EAjERSiNvWcz1WfCDlljQgfEeIAxx+kTX77VVjL+HeAmDL4EQsuxq3kjH5k/HU9vnMcZxHAc84jtC8T2vgvUHqKQ0uYd2gziFnKSLUCLw=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=sARP1g8D/HlADCNL1dJQ0QMblSBZD96CIe/D0u1aQxs=;
	h=date:mime-version:subject:message-id:from;

Use existing DP helper API instead of analogix_dp_clock_recovery_ok()
with the same function.

Signed-off-by: Damon Ding <damon.ding@rock-chips.com>
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 .../drm/bridge/analogix/analogix_dp_core.c    | 20 +++----------------
 1 file changed, 3 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
index 7bd91f186ff7..d3ab1f416600 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
@@ -301,19 +301,6 @@ static unsigned char analogix_dp_get_lane_status(u8 link_status[2], int lane)
 	return (link_value >> shift) & 0xf;
 }
 
-static int analogix_dp_clock_recovery_ok(u8 link_status[2], int lane_count)
-{
-	int lane;
-	u8 lane_status;
-
-	for (lane = 0; lane < lane_count; lane++) {
-		lane_status = analogix_dp_get_lane_status(link_status, lane);
-		if ((lane_status & DP_LANE_CR_DONE) == 0)
-			return -EINVAL;
-	}
-	return 0;
-}
-
 static int analogix_dp_channel_eq_ok(u8 link_status[2], u8 link_align,
 				     int lane_count)
 {
@@ -398,7 +385,7 @@ static int analogix_dp_process_clock_recovery(struct analogix_dp_device *dp)
 	if (retval < 0)
 		return retval;
 
-	if (analogix_dp_clock_recovery_ok(link_status, lane_count) == 0) {
+	if (drm_dp_clock_recovery_ok(link_status, lane_count)) {
 		/* set training pattern 2 for EQ */
 		analogix_dp_set_training_pattern(dp, TRAINING_PTN2);
 
@@ -464,7 +451,7 @@ static int analogix_dp_process_equalizer_training(struct analogix_dp_device *dp)
 	if (retval < 0)
 		return retval;
 
-	if (analogix_dp_clock_recovery_ok(link_status, lane_count)) {
+	if (!drm_dp_clock_recovery_ok(link_status, lane_count)) {
 		analogix_dp_reduce_link_rate(dp);
 		return -EIO;
 	}
@@ -668,8 +655,7 @@ static int analogix_dp_fast_link_train(struct analogix_dp_device *dp)
 			return ret;
 		}
 
-		if (analogix_dp_clock_recovery_ok(link_status,
-						  dp->link_train.lane_count)) {
+		if (!drm_dp_clock_recovery_ok(link_status, dp->link_train.lane_count)) {
 			DRM_DEV_ERROR(dp->dev, "Clock recovery failed\n");
 			analogix_dp_reduce_link_rate(dp);
 			return -EIO;
-- 
2.34.1


