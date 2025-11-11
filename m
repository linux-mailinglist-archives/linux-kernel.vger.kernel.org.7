Return-Path: <linux-kernel+bounces-894507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA46DC4B31E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 03:22:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F4291892BEB
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 02:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00C8D347BBE;
	Tue, 11 Nov 2025 02:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="KszgSewl"
Received: from mail-m49202.qiye.163.com (mail-m49202.qiye.163.com [45.254.49.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2C73009D8
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 02:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762827719; cv=none; b=H0n9cQkFae/KQmLB7iYH0Zs26d0M4zekt5Kx1BjdPAl4MWe9UyjLAuqVcxt7p18atuXEAAesRz72Guts2L62uneWp5kVOQXV6J/Qx0MGLQn7I5qz3fTMx9TiXywXOyVDgrKhr6ye8/+x/AaZFejra5y2udbxpStc1IHJ5pCihHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762827719; c=relaxed/simple;
	bh=+OqInWfl0YSF956LPDGhRXyxW00bOAexmJAtSjQbwqY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=a29LaBBo71ju2kfNxayWzA5+2KkXWeRtQ1n3/B7nQeHI+Opq+vTOZv5Fjs47r3JziHtGsroMYTkBrkLwMr193srfXZukC/ICJcq3uoew74BZ4TBq8kyCFgSEGvvP2fWDmGuOQLbAES8ukX/dYS4Fv3+Eg1VRdavhUQaKCJYMH1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=KszgSewl; arc=none smtp.client-ip=45.254.49.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from zyb-HP-ProDesk-680-G2-MT.. (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 291db184b;
	Tue, 11 Nov 2025 10:21:44 +0800 (GMT+08:00)
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
Subject: [RESEND v3] drm/bridge: analogix_dp: Reuse &link_train.training_lane[] to set DPCD DP_TRAINING_LANEx_SET
Date: Tue, 11 Nov 2025 10:21:03 +0800
Message-Id: <20251111022103.1350183-1-damon.ding@rock-chips.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9a70b819cb03a3kunm8a33c0b191ab9
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGktPTlYZTxhDSE5MTBhJTBhWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSEpKQk
	1VSktLVUpCWQY+
DKIM-Signature: a=rsa-sha256;
	b=KszgSewlAhdZ1P3u9tY4HyqMiKiwgqik950FR6TW67jv/LJLud0D3Xl5+CFjUW6OmVZhBAc46H+DYfbbTTkKZ53+/Osi/0dSWg2F7yhJTdDfEjk14AJ3CNRiouOI1JXE3URILQdX9+zU4k9x7dNorbMvVA5BPGm2B02fUVWEJOI=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=FynlO7hKXrvqRhcZEvwdzPsilQ/zR69sNn+xxKg5asY=;
	h=date:mime-version:subject:message-id:from;

In analogix_dp_link_start(), &link_train.training_lane[] is used to
set phy PE/VS configurations, and buf[] is initialized with the same
values to set DPCD DP_TRAINING_LANEx_SET.

It makes sense to reuse &link_train.training_lane[] to set DPCD
DP_TRAINING_LANEx_SET, which can remove the redundant assignments
and make codes more concise.

Signed-off-by: Damon Ding <damon.ding@rock-chips.com>
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

---

Changes in v2:
- Add Tested-by tag.

Changes in v3:
- Add Reviewed-by tag.
- Fix the spelling error 'consice' to 'concise'.
---
 drivers/gpu/drm/bridge/analogix/analogix_dp_core.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
index 6ec3d811b5f0..1e834d3656c1 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
@@ -281,12 +281,8 @@ static int analogix_dp_link_start(struct analogix_dp_device *dp)
 	if (retval < 0)
 		return retval;
 
-	for (lane = 0; lane < lane_count; lane++)
-		buf[lane] = DP_TRAIN_PRE_EMPH_LEVEL_0 |
-			    DP_TRAIN_VOLTAGE_SWING_LEVEL_0;
-
-	retval = drm_dp_dpcd_write(&dp->aux, DP_TRAINING_LANE0_SET, buf,
-				   lane_count);
+	retval = drm_dp_dpcd_write(&dp->aux, DP_TRAINING_LANE0_SET,
+				   dp->link_train.training_lane, lane_count);
 	if (retval < 0)
 		return retval;
 
-- 
2.34.1


