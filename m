Return-Path: <linux-kernel+bounces-783521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E897B32E92
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 11:01:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 403C61896DE8
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 09:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C5E921A444;
	Sun, 24 Aug 2025 09:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="VeaQFn94"
Received: from mail-m15598.qiye.163.com (mail-m15598.qiye.163.com [101.71.155.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF5AF1FDE14
	for <linux-kernel@vger.kernel.org>; Sun, 24 Aug 2025 09:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756026074; cv=none; b=sK48hYkbeFAHXmQUrsNWFzqJt+m25LZFnkdndwbuV6+5ZH4pvOQBzsPZQVvtYOVDb3Rivm+RYJdLx/jGlNoqOlsOCeUAZmTRFyoFw2QW3W9w0vFAql8Yrr9BR0xqjg/Vi0tH3M0/2uopnQ1ikJgKKZk47TwrHWx7R5GNK6x91jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756026074; c=relaxed/simple;
	bh=bCJ+s9Hfyt/deCAZFlqnwvcg5Wh8bF0bpYDdqeEANRc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Sgr4JNvJ0rRqVGtQLYuWI0/qC23aRycRCcPUaIRViRVFTMm6mWYpSVw2qssjgBvYEAlV0DKNjAyxR4EtkiX0NdcN+DqWO7X75DS5qU6OJAzCtZg64BAPMN9ODIvzAKZ12aOQX9hOigOZsvbuMknMzMo9JaF+1q6haKGkqe9fj3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=VeaQFn94; arc=none smtp.client-ip=101.71.155.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from zyb-HP-ProDesk-680-G2-MT.. (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 20643f361;
	Sun, 24 Aug 2025 16:45:45 +0800 (GMT+08:00)
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
Subject: [PATCH v1 2/4] drm/bridge: analogix_dp: Apply DP helper API drm_dp_clock_recovery_ok()
Date: Sun, 24 Aug 2025 16:45:27 +0800
Message-Id: <20250824084529.3317985-3-damon.ding@rock-chips.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250824084529.3317985-1-damon.ding@rock-chips.com>
References: <20250824084529.3317985-1-damon.ding@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a98db41480603a3kunm71d2620e2ad69e
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGUIaQ1YeTEsfQk8aGB0aGk5WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSEpKQk
	1VSktLVUpCWQY+
DKIM-Signature: a=rsa-sha256;
	b=VeaQFn94L+wyz4Rw5Y5kZepE9VGCGXUo/WWA6xLCSDGtYdqwZpU2XIjQ4sy7TTeejHbHjzzF08a2XgcQtDeqEBfb75jjfSvahXubBRWjyjx1lTmANWQLwafiH5FWPohNAgPxeIjva5nEwgy9GacnfDl2NdyqzeP2SNnoTaC1GGo=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=A9bgi49Xgv4Om5tHr8MtwDx3tD7Zaj9Nr4+eowxlYhU=;
	h=date:mime-version:subject:message-id:from;

Use existing DP helper API instead of analogix_dp_clock_recovery_ok()
with the same function.

Signed-off-by: Damon Ding <damon.ding@rock-chips.com>
---
 .../drm/bridge/analogix/analogix_dp_core.c    | 20 +++----------------
 1 file changed, 3 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
index 6a3f3fb0ec0a..fde190eac34e 100644
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


