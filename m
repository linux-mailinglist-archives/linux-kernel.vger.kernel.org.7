Return-Path: <linux-kernel+bounces-812985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF8BAB53F42
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 01:52:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 765CD3AF59D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 23:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBE53266EFC;
	Thu, 11 Sep 2025 23:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="Bjtf+u0f"
Received: from mail-m15581.qiye.163.com (mail-m15581.qiye.163.com [101.71.155.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE873199BC
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 23:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757634728; cv=none; b=GqzQl1kDFjhawLogVozLtpNxHVPz2r25voC++gnsV8Nz6rYJImVYUBzk7iielaRDJW8mZCcSoBnmw23qhXVERMUr11aCjgeBMdowEwVCCv/8Xr1oMPSpeIDBYMxySwR6hgfqbTf5XkjbCSQ5XT//XU6RsmvG3yC5LLotERCAXrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757634728; c=relaxed/simple;
	bh=uTjXQjXfdr2DaOQmjtSLs1Yh3S+M0G+X//kkp9uXIkM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QO6QcdqDcyiOaqDR5ZqSWWro90113ei9eQ4GGZI1qec01J6cWtKU0gH54XPm2kHGtQzoJVH6oAHXtwM/IpiPUXgGdgDvfWipHWMsLhqWirvmQPcNs7wH/1cf2RXq1hv2c8wTw87JKDF5qyVd5AOUcPvUCpl/L7LjocabKDEsiSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=Bjtf+u0f; arc=none smtp.client-ip=101.71.155.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from zyb-HP-ProDesk-680-G2-MT.. (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 227a3f1ff;
	Thu, 11 Sep 2025 19:28:24 +0800 (GMT+08:00)
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
	dmitry.baryshkov@linaro.org,
	l.stach@pengutronix.de,
	dianders@chromium.org,
	m.szyprowski@samsung.com,
	andy.yan@rock-chips.com,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Damon Ding <damon.ding@rock-chips.com>
Subject: [PATCH v2 4/4] drm/bridge: analogix_dp: Apply DP helper APIs to get adjusted voltages and pre-emphasises
Date: Thu, 11 Sep 2025 19:27:56 +0800
Message-Id: <20250911112756.4008435-5-damon.ding@rock-chips.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250911112756.4008435-1-damon.ding@rock-chips.com>
References: <20250911112756.4008435-1-damon.ding@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a993888a88d03a3kunmb42177f792e41a
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ0MdGVYeQhlOQx5CT0pPQkJWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=Bjtf+u0fEDn3jrfxndE8TXornk4GEQZi4ryfhUoBEYETK/nGe2x69pt0OFBD1ua0l/508Z87Y23wUCHOM91hqG3UkAzIUwSmeqU3YDkYveFodCVYa+dE3c3zEmO7sz0T/8maK6W3kHJS6J8MC70sinGZFUuia6U9ufpG39y8/1U=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=p9erK0I539avIH40vDHFrp16O/+OOJmZ+BZcTCPtNCI=;
	h=date:mime-version:subject:message-id:from;

Replace analogix_dp_get_adjust_request_voltage() and
analogix_dp_get_adjust_request_pre_emphasis() with existing DP helper
APIs with the same function.

Signed-off-by: Damon Ding <damon.ding@rock-chips.com>
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 .../drm/bridge/analogix/analogix_dp_core.c    | 49 ++++---------------
 1 file changed, 9 insertions(+), 40 deletions(-)

diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
index 1f1de45ca46f..a6d4935234c2 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
@@ -293,25 +293,6 @@ static int analogix_dp_link_start(struct analogix_dp_device *dp)
 	return 0;
 }
 
-static unsigned char
-analogix_dp_get_adjust_request_voltage(u8 adjust_request[2], int lane)
-{
-	int shift = (lane & 1) * 4;
-	u8 link_value = adjust_request[lane >> 1];
-
-	return (link_value >> shift) & 0x3;
-}
-
-static unsigned char analogix_dp_get_adjust_request_pre_emphasis(
-					u8 adjust_request[2],
-					int lane)
-{
-	int shift = (lane & 1) * 4;
-	u8 link_value = adjust_request[lane >> 1];
-
-	return ((link_value >> shift) & 0xc) >> 2;
-}
-
 static void analogix_dp_reduce_link_rate(struct analogix_dp_device *dp)
 {
 	analogix_dp_training_pattern_dis(dp);
@@ -321,17 +302,15 @@ static void analogix_dp_reduce_link_rate(struct analogix_dp_device *dp)
 }
 
 static void analogix_dp_get_adjust_training_lane(struct analogix_dp_device *dp,
-						 u8 adjust_request[2])
+						 u8 link_status[DP_LINK_STATUS_SIZE])
 {
 	int lane, lane_count;
 	u8 voltage_swing, pre_emphasis, training_lane;
 
 	lane_count = dp->link_train.lane_count;
 	for (lane = 0; lane < lane_count; lane++) {
-		voltage_swing = analogix_dp_get_adjust_request_voltage(
-						adjust_request, lane);
-		pre_emphasis = analogix_dp_get_adjust_request_pre_emphasis(
-						adjust_request, lane);
+		voltage_swing = drm_dp_get_adjust_request_voltage(link_status, lane);
+		pre_emphasis = drm_dp_get_adjust_request_pre_emphasis(link_status, lane);
 		training_lane = DPCD_VOLTAGE_SWING_SET(voltage_swing) |
 				DPCD_PRE_EMPHASIS_SET(pre_emphasis);
 
@@ -348,7 +327,7 @@ static int analogix_dp_process_clock_recovery(struct analogix_dp_device *dp)
 {
 	int lane, lane_count, retval;
 	u8 voltage_swing, pre_emphasis, training_lane;
-	u8 link_status[DP_LINK_STATUS_SIZE], adjust_request[2];
+	u8 link_status[DP_LINK_STATUS_SIZE];
 
 	usleep_range(100, 101);
 
@@ -374,15 +353,10 @@ static int analogix_dp_process_clock_recovery(struct analogix_dp_device *dp)
 		return 0;
 	}
 
-	retval = drm_dp_dpcd_read(&dp->aux, DP_ADJUST_REQUEST_LANE0_1,
-				  adjust_request, 2);
-	if (retval < 0)
-		return retval;
-
 	for (lane = 0; lane < lane_count; lane++) {
 		training_lane = analogix_dp_get_lane_link_training(dp, lane);
-		voltage_swing = analogix_dp_get_adjust_request_voltage(adjust_request, lane);
-		pre_emphasis = analogix_dp_get_adjust_request_pre_emphasis(adjust_request, lane);
+		voltage_swing = drm_dp_get_adjust_request_voltage(link_status, lane);
+		pre_emphasis = drm_dp_get_adjust_request_pre_emphasis(link_status, lane);
 
 		if (DPCD_VOLTAGE_SWING_GET(training_lane) == voltage_swing &&
 		    DPCD_PRE_EMPHASIS_GET(training_lane) == pre_emphasis)
@@ -399,7 +373,7 @@ static int analogix_dp_process_clock_recovery(struct analogix_dp_device *dp)
 		}
 	}
 
-	analogix_dp_get_adjust_training_lane(dp, adjust_request);
+	analogix_dp_get_adjust_training_lane(dp, link_status);
 	analogix_dp_set_lane_link_training(dp);
 
 	retval = drm_dp_dpcd_write(&dp->aux, DP_TRAINING_LANE0_SET,
@@ -414,7 +388,7 @@ static int analogix_dp_process_equalizer_training(struct analogix_dp_device *dp)
 {
 	int lane_count, retval;
 	u32 reg;
-	u8 link_status[DP_LINK_STATUS_SIZE], adjust_request[2];
+	u8 link_status[DP_LINK_STATUS_SIZE];
 
 	usleep_range(400, 401);
 
@@ -429,12 +403,7 @@ static int analogix_dp_process_equalizer_training(struct analogix_dp_device *dp)
 		return -EIO;
 	}
 
-	retval = drm_dp_dpcd_read(&dp->aux, DP_ADJUST_REQUEST_LANE0_1,
-				  adjust_request, 2);
-	if (retval < 0)
-		return retval;
-
-	analogix_dp_get_adjust_training_lane(dp, adjust_request);
+	analogix_dp_get_adjust_training_lane(dp, link_status);
 
 	if (drm_dp_channel_eq_ok(link_status, lane_count)) {
 		/* traing pattern Set to Normal */
-- 
2.34.1


