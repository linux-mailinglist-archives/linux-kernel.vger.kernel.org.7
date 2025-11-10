Return-Path: <linux-kernel+bounces-892638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDCD2C45817
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 10:05:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C57DC3B51E8
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 09:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F09FE2FC879;
	Mon, 10 Nov 2025 09:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="O3rVIxIe"
Received: from mail-m19731116.qiye.163.com (mail-m19731116.qiye.163.com [220.197.31.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364D82FE07F
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 09:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762765450; cv=none; b=jMlvUu24KoKqv4/PH+kJWCRkqqWGEY0tBgqiWEyY/1RqzwvFX+IfF4ArQtoMuOwbEtDb+EFk1K+eJOlFpCYCGc5F2lzzazOEaPm0awzyLmkH8RfGeOKZVHPHI/YD7iaMjyrfLqB89yNPa8KvAiI8jpkVTxdUsKLaEpWbhfeCvso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762765450; c=relaxed/simple;
	bh=R1tqKA81avXdzlAK6WFcK+NANppncOlrQYe6DN5gepY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IM3KL7XKRSgCd8CCeoObsqa+u1xbY9iVuAR3U7a7msq7+5IJCG2Jy9dPWW6EOg7pRfvKeaO9hQYE6K5AvEjSbu/U8qcsvBgQ4/1ualepl/qLw4Ju2rGfrGEtTgxdr+bI6zSEqR8DjcSAFQACJ6S6Zb/lQSIsE1sneKgYaCHYV/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=O3rVIxIe; arc=none smtp.client-ip=220.197.31.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from zyb-HP-ProDesk-680-G2-MT.. (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 29068b539;
	Mon, 10 Nov 2025 16:58:50 +0800 (GMT+08:00)
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
Subject: [PATCH v3 4/4] drm/bridge: analogix_dp: Apply DP helper APIs to get adjusted voltages and pre-emphasises
Date: Mon, 10 Nov 2025 16:58:23 +0800
Message-Id: <20251110085823.1197472-5-damon.ding@rock-chips.com>
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
X-HM-Tid: 0a9a6cfd4baf03a3kunm91e8d29910ac63a
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQhgfSFZNHkpPHx0fGkhLSENWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=O3rVIxIeKj031LO6gC8cXthXGkyG4plX49kBzyYvzXi0wSxDYYzhUhxz7fm1nH6y5ySln8sCkNVijuHvfSYhUxL7WlUdiinr21ebE3cRqy2MpRSWbjfFvyhHdYMEa9Ye1MhmeaKT17LBK0GWTy2WrHi+dDBv1jRubn7w4gAKYQw=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=3gW86vskonft7Jl2Q50EbOmDui7TylloSuDk8Dc/iLU=;
	h=date:mime-version:subject:message-id:from;

Replace analogix_dp_get_adjust_request_voltage() and
analogix_dp_get_adjust_request_pre_emphasis() with existing DP helper
APIs with the same function.

Signed-off-by: Damon Ding <damon.ding@rock-chips.com>
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 .../drm/bridge/analogix/analogix_dp_core.c    | 49 ++++---------------
 1 file changed, 9 insertions(+), 40 deletions(-)

diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
index 227ef30b8a9e..6ec3d811b5f0 100644
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


