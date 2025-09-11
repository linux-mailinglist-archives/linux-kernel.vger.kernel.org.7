Return-Path: <linux-kernel+bounces-812010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AFA6EB531AE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 14:03:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68A9B482ED8
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 12:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B69031B833;
	Thu, 11 Sep 2025 12:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="gaBeiJIo"
Received: from mail-m155105.qiye.163.com (mail-m155105.qiye.163.com [101.71.155.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 548A52E9EAD
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 12:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757592223; cv=none; b=G50yAyhAP9F2Nf/3QrUD2hP5Gim4K//DOoewHFjJHlUEimHtdvMIkXdcQKhjjOWYSADF4dOyGRXozXZ7rOkiqafqFLDMxUedsWYVyTJaGxwhBFAAp2aEgSFqbjbQMjQV7KvDvNUIxXb0fDVr4vf5Xe4lyD2jzEjbZKpG2aWL/EY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757592223; c=relaxed/simple;
	bh=M6numbXerfZFvhMNy2FNl5JEAc+HUi2+l5l0V5jonHY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AM76vtk/PnvVi+owLlC2wRGqMJDXDRYlU6H+3Jzf8hvP80CPeNN46YVO2GBQY6++wRnlW/3G9GoE2iEpBw+Iqo4n6zwqQQ3vKAda8k53qHim1jCLIvjP17SXhKEMQUDi2fnM4ZknTD/K1gtQKETUtJ7qCWuFpIv5Oi4RQJP9T6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=gaBeiJIo; arc=none smtp.client-ip=101.71.155.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from zyb-HP-ProDesk-680-G2-MT.. (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 227a3f1de;
	Thu, 11 Sep 2025 19:28:03 +0800 (GMT+08:00)
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
Subject: [PATCH v2 1/4] drm/bridge: analogix_dp: Apply DP helper API drm_dp_dpcd_read_link_status()
Date: Thu, 11 Sep 2025 19:27:53 +0800
Message-Id: <20250911112756.4008435-2-damon.ding@rock-chips.com>
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
X-HM-Tid: 0a993888586b03a3kunmb42177f792e2f9
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGh5LSFZJSUhJHUpPQh1MSElWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=gaBeiJIos+p3tCjOoEv8swg4LGf7QQLFpl8Zkbrv9S1eXSfMvDxk5IOT8cj3egbHHFLNiXgC4xIkXwKz3wY457qLOECfLl8IEuJemNB7fhk9wbXa2pAywpr0pUYH68Vqqu1L2APHxpRSZqo0JcdX50E2UAAi5eCkYeR66wMT3GY=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=d0kIzp1y0sLQmYMhHbvsjRYJBfu9ixHJpYQ97wF09ak=;
	h=date:mime-version:subject:message-id:from;

Use existing DP helper API to read link status related DPCDs.

Signed-off-by: Damon Ding <damon.ding@rock-chips.com>
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
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


