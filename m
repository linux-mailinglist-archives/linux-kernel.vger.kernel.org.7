Return-Path: <linux-kernel+bounces-783533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 89A7AB32EBE
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 11:23:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39AE5166DA2
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 09:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAE99260586;
	Sun, 24 Aug 2025 09:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="K1n5JrAp"
Received: from mail-m32100.qiye.163.com (mail-m32100.qiye.163.com [220.197.32.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7549F264A83
	for <linux-kernel@vger.kernel.org>; Sun, 24 Aug 2025 09:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756027281; cv=none; b=eB83WrEv4Ye3rDq6ZRa2KF7hT5o7kWeCUQ+InuhtJBcHuRDc94PJEaV6AbSDHYD5nv5auzaOlt2C6D7eiSZXq/1Z9QrpvXqlw0My1LF8uOe8Q7P320WpUC9wuF1LJN8Pwe2LMmB1tem9qKPOo64n1Vv5U5B46ptZYoB2bXEmL24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756027281; c=relaxed/simple;
	bh=abm45pLhmD4Cw1u1AfO8hLgUyTKER6N+f10k8Z/v82E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Yr4lyeVdgJlQtmwHnGJXXYVEOOjfOFJco/WlB8tHcjnP64kzOUmdRINCcuVugTpESLtHw7+AaZyio7DSy7ZwA/i3+wQhVrvmC68FoiFxMzwaXk3ZLFOUkuN3ezjZgEKVrSvzOGYso0OBKiaY74JEClAr3vpsb9nVu3tkXFl9deg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=K1n5JrAp; arc=none smtp.client-ip=220.197.32.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from zyb-HP-ProDesk-680-G2-MT.. (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 20643f35e;
	Sun, 24 Aug 2025 16:45:43 +0800 (GMT+08:00)
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
Subject: [PATCH v1 1/4] drm/bridge: analogix_dp: Apply DP helper API drm_dp_dpcd_read_link_status()
Date: Sun, 24 Aug 2025 16:45:26 +0800
Message-Id: <20250824084529.3317985-2-damon.ding@rock-chips.com>
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
X-HM-Tid: 0a98db4141d603a3kunm71d2620e2ad685
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQhhISVZIQxlLGEsaSE5NS0NWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=K1n5JrApL/05epZmMybeDKhmJCxEMLp8NBC30EVU8UMDmFq4k5yofuq07olJpJJzOWY5EleEKLYTnPz2l6cBAa4g5uSblUevRrGpnWUN768DJjXf/bJgwxYHfZ/nAtTQGMMGb5+byYJ0fKg988/pSKOGW46miurC0Uu8o72WsPQ=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=ee2Cm9agIGFWMrQ8tfeANTYqKDJm3XAtCYn236nugoU=;
	h=date:mime-version:subject:message-id:from;

Use existing DP helper API to read link status related DPCDs.

Signed-off-by: Damon Ding <damon.ding@rock-chips.com>
---
 drivers/gpu/drm/bridge/analogix/analogix_dp_core.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
index ed35e567d117..6a3f3fb0ec0a 100644
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


