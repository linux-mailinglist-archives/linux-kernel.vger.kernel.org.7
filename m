Return-Path: <linux-kernel+bounces-835384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 333C0BA6F56
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 12:51:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC48916B024
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 10:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8104F2D7DE0;
	Sun, 28 Sep 2025 10:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="IT1F4DCP"
Received: from mail-m155115.qiye.163.com (mail-m155115.qiye.163.com [101.71.155.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 283D42D0C9A
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 10:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759056696; cv=none; b=buWrcprFtzup3QBVqdhJf4E70+C/9Zfm9gVZCEyTzCw1P+OB0kBIHqD1jOQQXU2ciRLsYnELUGSOc6ESiQobj5bZ5mxDVdHFc/MvFiZtW2lzJpfq4016IOSFGZF7vzLciHRKIkb33iYKMmdLYQUTUzZsPaZRAQggrTLFw6y1/aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759056696; c=relaxed/simple;
	bh=+OqInWfl0YSF956LPDGhRXyxW00bOAexmJAtSjQbwqY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HQ+8jmRjhGl3P5FYGs5bZ3ad+kcCKL/E9VQxCt4CugmGYTvXqRaHnvRaIj99jOq1Yih94k02EGUsUO39IXxqr5PVM43+6VNJ366xmYzg4G2tcCHfv9FmtmTT9TMXm+4r+miUANIU9xjV8k3Y+WcZRqrakSsCouJrQx2SGkyZeKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=IT1F4DCP; arc=none smtp.client-ip=101.71.155.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from zyb-HP-ProDesk-680-G2-MT.. (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 2456a8421;
	Sun, 28 Sep 2025 18:46:15 +0800 (GMT+08:00)
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
Subject: [PATCH v3] drm/bridge: analogix_dp: Reuse &link_train.training_lane[] to set DPCD DP_TRAINING_LANEx_SET
Date: Sun, 28 Sep 2025 18:46:07 +0800
Message-Id: <20250928104607.4007586-1-damon.ding@rock-chips.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a998fee2d3103a3kunmd764ef2a1dfb70
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGhlOGlYaSk1NSk9PTBlLS09WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSEpKQk
	1VSktLVUpCWQY+
DKIM-Signature: a=rsa-sha256;
	b=IT1F4DCPXlqAccWRPgv/W3I6jHk+5zOxO0dclq6r2ZBGt3I0BPYV/NGweipI3gMf+ooeGgPcEPMZgRhjKY6Z2InZGSSRYBKqwr1eZaCGlS1WiIAgqggpKBu8iwKIr3J514LgzTFCZ2xkUYsLmaiUsrbvuUo7yTZeclX5LTDg0MA=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
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


