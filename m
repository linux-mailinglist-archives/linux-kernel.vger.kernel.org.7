Return-Path: <linux-kernel+bounces-892627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D445BC457A7
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 09:59:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8736334743C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 08:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC1AF2FDC50;
	Mon, 10 Nov 2025 08:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="HQA2C4dJ"
Received: from mail-m1973170.qiye.163.com (mail-m1973170.qiye.163.com [220.197.31.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64CB5823DD
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 08:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762765141; cv=none; b=nFdfav4nF4PHp5W+LkMVQqBku8NBJQJ4Ffc6Qa0zuHTn7RSPxN8jVvWfJ1a7TiQlmp7bvzEWYYC8bM2rCXv8FYls88jb79Hwfp5oFWMZJjCYlmNUJJKMFs1LWj/r6gstuXPD+VStYE8YIYh13fAMwVQtRT8v23vudtBJgvgWGXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762765141; c=relaxed/simple;
	bh=CauuCtrNaszlp7OxPzvo67mloy+uPuF28pY7oK0OQ8g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dItvZteJZ8MLe+yyoilSby6tIjzD/B7GqyQ49j57i43omaZlHWNmw+5/Xe/h1LlCDFsPHChoIGFcFllJZR6lZ4PTc8etmXiVrn80IdFzI4vMTgibm5ufGk/lr9vg0KjFU5tJLESMBIZib3jvmYlMOZShyJGff3rbgo6ydgetTTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=HQA2C4dJ; arc=none smtp.client-ip=220.197.31.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from zyb-HP-ProDesk-680-G2-MT.. (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 29068b52a;
	Mon, 10 Nov 2025 16:58:48 +0800 (GMT+08:00)
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
Subject: [PATCH v3 3/4] drm/bridge: analogix_dp: Apply DP helper API drm_dp_channel_eq_ok()
Date: Mon, 10 Nov 2025 16:58:22 +0800
Message-Id: <20251110085823.1197472-4-damon.ding@rock-chips.com>
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
X-HM-Tid: 0a9a6cfd428203a3kunm91e8d29910ac5fa
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGUxJSlZIT0MdH0xOSkoYTBlWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSEpKQk
	1VSktLVUpCWQY+
DKIM-Signature: a=rsa-sha256;
	b=HQA2C4dJYtRg38FpaqNubCZ013kLk+yIT2eNE9L/yXnFHlW3Shaj9g6SJ5vrwHtYRqQC9XwejjALAhdpLzgSmBezL3gie8cMj3cnS0shQEDoyIsjvmoO+w0yG8IMEpr8zA3zXMGckGNoL78NAV7Gd8HffRYA7YlanSafaxyNlkI=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=jGmiTlCG+5VZwO6ZGasoSIwARtRizbq9A5KR+nzRaJ4=;
	h=date:mime-version:subject:message-id:from;

Use existing DP helper API instead of analogix_dp_channel_eq_ok()
with the same function.

In addtion, remove unused function analogix_dp_get_lane_status()

Signed-off-by: Damon Ding <damon.ding@rock-chips.com>
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 .../drm/bridge/analogix/analogix_dp_core.c    | 49 ++-----------------
 1 file changed, 4 insertions(+), 45 deletions(-)

diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
index d3ab1f416600..227ef30b8a9e 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
@@ -293,33 +293,6 @@ static int analogix_dp_link_start(struct analogix_dp_device *dp)
 	return 0;
 }
 
-static unsigned char analogix_dp_get_lane_status(u8 link_status[2], int lane)
-{
-	int shift = (lane & 1) * 4;
-	u8 link_value = link_status[lane >> 1];
-
-	return (link_value >> shift) & 0xf;
-}
-
-static int analogix_dp_channel_eq_ok(u8 link_status[2], u8 link_align,
-				     int lane_count)
-{
-	int lane;
-	u8 lane_status;
-
-	if ((link_align & DP_INTERLANE_ALIGN_DONE) == 0)
-		return -EINVAL;
-
-	for (lane = 0; lane < lane_count; lane++) {
-		lane_status = analogix_dp_get_lane_status(link_status, lane);
-		lane_status &= DP_CHANNEL_EQ_BITS;
-		if (lane_status != DP_CHANNEL_EQ_BITS)
-			return -EINVAL;
-	}
-
-	return 0;
-}
-
 static unsigned char
 analogix_dp_get_adjust_request_voltage(u8 adjust_request[2], int lane)
 {
@@ -441,7 +414,7 @@ static int analogix_dp_process_equalizer_training(struct analogix_dp_device *dp)
 {
 	int lane_count, retval;
 	u32 reg;
-	u8 link_align, link_status[DP_LINK_STATUS_SIZE], adjust_request[2];
+	u8 link_status[DP_LINK_STATUS_SIZE], adjust_request[2];
 
 	usleep_range(400, 401);
 
@@ -461,14 +434,9 @@ static int analogix_dp_process_equalizer_training(struct analogix_dp_device *dp)
 	if (retval < 0)
 		return retval;
 
-	retval = drm_dp_dpcd_readb(&dp->aux, DP_LANE_ALIGN_STATUS_UPDATED,
-				   &link_align);
-	if (retval < 0)
-		return retval;
-
 	analogix_dp_get_adjust_training_lane(dp, adjust_request);
 
-	if (!analogix_dp_channel_eq_ok(link_status, link_align, lane_count)) {
+	if (drm_dp_channel_eq_ok(link_status, lane_count)) {
 		/* traing pattern Set to Normal */
 		retval = analogix_dp_training_pattern_dis(dp);
 		if (retval < 0)
@@ -606,7 +574,7 @@ static int analogix_dp_full_link_train(struct analogix_dp_device *dp,
 static int analogix_dp_fast_link_train(struct analogix_dp_device *dp)
 {
 	int ret;
-	u8 link_align, link_status[DP_LINK_STATUS_SIZE];
+	u8 link_status[DP_LINK_STATUS_SIZE];
 
 	analogix_dp_set_link_bandwidth(dp, dp->link_train.link_rate);
 	ret = analogix_dp_wait_pll_locked(dp);
@@ -640,14 +608,6 @@ static int analogix_dp_fast_link_train(struct analogix_dp_device *dp)
 	 * speed
 	 */
 	if (verify_fast_training) {
-		ret = drm_dp_dpcd_readb(&dp->aux, DP_LANE_ALIGN_STATUS_UPDATED,
-					&link_align);
-		if (ret < 0) {
-			DRM_DEV_ERROR(dp->dev, "Read align status failed %d\n",
-				      ret);
-			return ret;
-		}
-
 		ret = drm_dp_dpcd_read_link_status(&dp->aux, link_status);
 		if (ret < 0) {
 			DRM_DEV_ERROR(dp->dev, "Read link status failed %d\n",
@@ -661,8 +621,7 @@ static int analogix_dp_fast_link_train(struct analogix_dp_device *dp)
 			return -EIO;
 		}
 
-		if (analogix_dp_channel_eq_ok(link_status, link_align,
-					      dp->link_train.lane_count)) {
+		if (!drm_dp_channel_eq_ok(link_status, dp->link_train.lane_count)) {
 			DRM_DEV_ERROR(dp->dev, "Channel EQ failed\n");
 			analogix_dp_reduce_link_rate(dp);
 			return -EIO;
-- 
2.34.1


