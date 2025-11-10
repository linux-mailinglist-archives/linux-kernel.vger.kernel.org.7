Return-Path: <linux-kernel+bounces-892636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EDFBAC457FC
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 10:04:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7216434798B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 09:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BC7D2FD1D3;
	Mon, 10 Nov 2025 09:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="NUWIWey8"
Received: from mail-m3298.qiye.163.com (mail-m3298.qiye.163.com [220.197.32.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F06272F83BB
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 09:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762765444; cv=none; b=Bi9o1JyKm4Rwup/wj6P72tCTHYALBRGW8mKEaqAxBooPnRBfDcYWd+KvYpCMng7caQB+XzcvFseU1wrCwTGFbrXAcXiIKsd1aBCFM3rlhtToEoT9Vge48TTumbrviQS6hpFytZPnorMOnKq1APosaYucRJxaW3lFmRv3ivDbzPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762765444; c=relaxed/simple;
	bh=O98FhgpPH9AmIUQ8MrpeFFgnfOqvIBLEm8/jN4cQmbg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jQtsdkFAdxSRyDomhfWNdLf0HZil+GIxji18d/dEj70aXOKSAg1pvp1rLkPOzCXtl8IRXfTNUhtfKzF3GTj7PbzNlV7DhviT2CvKMmyujRzYALiKgjMGPTygbPw5C1y2bCUDCAGGyu7duQ+nA/3WoOKb1IKNvyjxbvplQ/3bAKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=NUWIWey8; arc=none smtp.client-ip=220.197.32.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from zyb-HP-ProDesk-680-G2-MT.. (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 29068b50b;
	Mon, 10 Nov 2025 16:58:43 +0800 (GMT+08:00)
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
Subject: [PATCH v3 1/4] drm/bridge: analogix_dp: Apply DP helper API drm_dp_dpcd_read_link_status()
Date: Mon, 10 Nov 2025 16:58:20 +0800
Message-Id: <20251110085823.1197472-2-damon.ding@rock-chips.com>
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
X-HM-Tid: 0a9a6cfd2f3e03a3kunm91e8d29910ac565
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGkhMGFZCS0JJS04fTU5CQ05WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=NUWIWey8vWlRCm2+/SQQjN/ucK09iFzZZuILU2h+TBiT4BBAfo68c2CMBpW0Pd3BIxl4Ewy4HhPh4F71PPN+AmqSoYa9/yr2AyCxw8FZjmQzBa4XPAAZAJFXPJY849+PKkiAzD8EOkLnUzTMICMj95dKW1xe6k9bsk/mYPvofbM=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=og7lZ+NbbOS0YUmwxs59NRtyf8yZrXQ1o4bVbOZgqkU=;
	h=date:mime-version:subject:message-id:from;

Use existing DP helper API to read link status related DPCDs.

Signed-off-by: Damon Ding <damon.ding@rock-chips.com>
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/bridge/analogix/analogix_dp_core.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
index efe534977d12..7bd91f186ff7 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
@@ -388,13 +388,13 @@ static int analogix_dp_process_clock_recovery(struct analogix_dp_device *dp)
 {
 	int lane, lane_count, retval;
 	u8 voltage_swing, pre_emphasis, training_lane;
-	u8 link_status[2], adjust_request[2];
+	u8 link_status[DP_LINK_STATUS_SIZE], adjust_request[2];
 
 	usleep_range(100, 101);
 
 	lane_count = dp->link_train.lane_count;
 
-	retval = drm_dp_dpcd_read(&dp->aux, DP_LANE0_1_STATUS, link_status, 2);
+	retval = drm_dp_dpcd_read_link_status(&dp->aux, link_status);
 	if (retval < 0)
 		return retval;
 
@@ -454,13 +454,13 @@ static int analogix_dp_process_equalizer_training(struct analogix_dp_device *dp)
 {
 	int lane_count, retval;
 	u32 reg;
-	u8 link_align, link_status[2], adjust_request[2];
+	u8 link_align, link_status[DP_LINK_STATUS_SIZE], adjust_request[2];
 
 	usleep_range(400, 401);
 
 	lane_count = dp->link_train.lane_count;
 
-	retval = drm_dp_dpcd_read(&dp->aux, DP_LANE0_1_STATUS, link_status, 2);
+	retval = drm_dp_dpcd_read_link_status(&dp->aux, link_status);
 	if (retval < 0)
 		return retval;
 
@@ -619,7 +619,7 @@ static int analogix_dp_full_link_train(struct analogix_dp_device *dp,
 static int analogix_dp_fast_link_train(struct analogix_dp_device *dp)
 {
 	int ret;
-	u8 link_align, link_status[2];
+	u8 link_align, link_status[DP_LINK_STATUS_SIZE];
 
 	analogix_dp_set_link_bandwidth(dp, dp->link_train.link_rate);
 	ret = analogix_dp_wait_pll_locked(dp);
@@ -661,8 +661,7 @@ static int analogix_dp_fast_link_train(struct analogix_dp_device *dp)
 			return ret;
 		}
 
-		ret = drm_dp_dpcd_read(&dp->aux, DP_LANE0_1_STATUS, link_status,
-				       2);
+		ret = drm_dp_dpcd_read_link_status(&dp->aux, link_status);
 		if (ret < 0) {
 			DRM_DEV_ERROR(dp->dev, "Read link status failed %d\n",
 				      ret);
-- 
2.34.1


