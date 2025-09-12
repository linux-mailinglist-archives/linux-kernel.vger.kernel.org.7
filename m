Return-Path: <linux-kernel+bounces-813247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96CE4B54293
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 08:12:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E8AF7B8C36
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 06:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DC7927F160;
	Fri, 12 Sep 2025 06:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="gKGW7HGM"
Received: from mail-m19731111.qiye.163.com (mail-m19731111.qiye.163.com [220.197.31.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720A0846F
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 06:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757657552; cv=none; b=BMEtIcVN4Mg9UrXtKsrGOe5AVJqjH0qS5QaRancD5yY8lQi7w6ZMy58M07JeZlNlu0QsyifGkfLbBPD4bposQU6PwvCEc0EKzltKjMKy/E/rQsojLk3KTO9yRAP7VkawdUWgWBkwi63GaXqAyvIuGxaPoTzTz3JVpAJKWIDGFgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757657552; c=relaxed/simple;
	bh=P89qHrULW0PhKlVw0dA+nvxpr2WOTElXxSahzQ9dWV8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ae/AWgww314tDb2fC6F2hQqQGbUhtnu3X/n0D3REmja8WhkTeQxhrKB3Ro2Jk3MsN3RaTQQJXpdE8RX6leHmUe7Pj6B+0Jk4Mcf9nMHF1vHWeBpciR2XU6994TS8laxDoOVrZtB+9/SC1uBykbZ23j91fQwXZxggjVNbJI+IE9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=gKGW7HGM; arc=none smtp.client-ip=220.197.31.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from zyb-HP-ProDesk-680-G2-MT.. (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 228d77b2b;
	Fri, 12 Sep 2025 11:49:59 +0800 (GMT+08:00)
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
Subject: [PATCH v2] drm/bridge: analogix_dp: Reuse &link_train.training_lane[] to set DPCD DP_TRAINING_LANEx_SET
Date: Fri, 12 Sep 2025 11:49:49 +0800
Message-Id: <20250912034949.4054878-1-damon.ding@rock-chips.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a993c0b532603a3kunmb7c2e7889d3f5d
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGR1DHVZLGENLTkMfGhpJSkNWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSEpKQk
	1VSktLVUpCWQY+
DKIM-Signature: a=rsa-sha256;
	b=gKGW7HGM9655ndLcjiYMalvGxzC/5ESbK8fhqs3KSjkARm/ig3Dw1jCDzBLn+OGDg/KdZbLabGZaE6+J8dfl8ItiXxUPjGzKHm0mzvUs4qJaArthP060E60aYS/seIF8nUE2bKQTKw3FEX/MTczwAIQSYD8HaTkUYdHTtRDeIQE=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=VN6yQDuRgH2v01VJP76imfc3f9rZYrLrxNyjR9mRFYg=;
	h=date:mime-version:subject:message-id:from;

In analogix_dp_link_start(), &link_train.training_lane[] is used to
set phy PE/VS configurations, and buf[] is initialized with the same
values to set DPCD DP_TRAINING_LANEx_SET.

It makes sense to reuse &link_train.training_lane[] to set DPCD
DP_TRAINING_LANEx_SET, which can remove the redundant assignments
and make codes more consice.

Signed-off-by: Damon Ding <damon.ding@rock-chips.com>
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

---

Changes in v2:
- Add Tested-by tag.
---
 drivers/gpu/drm/bridge/analogix/analogix_dp_core.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
index a6d4935234c2..0d7941d37771 100644
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


