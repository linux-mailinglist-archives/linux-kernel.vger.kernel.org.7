Return-Path: <linux-kernel+bounces-783537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DEEDB32EC1
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 11:25:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52FE07AFA82
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 09:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3DB5261B70;
	Sun, 24 Aug 2025 09:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="HfBMHENu"
Received: from mail-m15595.qiye.163.com (mail-m15595.qiye.163.com [101.71.155.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FDCB1C7017
	for <linux-kernel@vger.kernel.org>; Sun, 24 Aug 2025 09:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756027541; cv=none; b=Gwe64/Jh1sO81ekcEs4XkAw5Yh1c72BuyV9qv5rxy9qjwwCswj3+ViIpKb9YGOfBFuz15ZmPOGywPksaDwhFX9YYDTxKolYrVeFBifrCWJdVwT9Tcht6oNOUOiWgJKA1fxvxHOrXwJVa/kYA2W6yi6OO9ELXf2aKo7mjPYDfuCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756027541; c=relaxed/simple;
	bh=ej+R/Oq3T7y6fNL0qyF8mHT/g0H5M6S7pqVpNiyohsw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ah/UTDHqBz+EO37F6RLXNEljkUHtFcaq3YdIgiSnES3zE3RXGl/AHkV4ZRYq0qJlpdEhem/IY8Gvmz/+DYJmOaPhR/Z+NUgfetKDqqyQbX8XsAbN5Q4Vei1D2GEP65JktLQf2AILAReXPSY+db1M6aDP+5A/FhgphwMQuWU+mTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=HfBMHENu; arc=none smtp.client-ip=101.71.155.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from zyb-HP-ProDesk-680-G2-MT.. (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 2061d68a8;
	Sun, 24 Aug 2025 11:42:47 +0800 (GMT+08:00)
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
Subject: [PATCH v1] drm/bridge: analogix_dp: Reuse &link_train.training_lane[] to set DPCD DP_TRAINING_LANEx_SET
Date: Sun, 24 Aug 2025 11:41:38 +0800
Message-Id: <20250824034138.3207855-1-damon.ding@rock-chips.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a98da2be6d203a3kunme50173fe286e82
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGkhOTlZCTB9DSx1KHx5MQ05WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSEpKQk
	1VSktLVUpCWQY+
DKIM-Signature: a=rsa-sha256;
	b=HfBMHENuq1cOiPb6Rcqorn47hRqYt1a5mik2233TjXGi3lq2rCbIw+mrvigLBzFaSwOUEc2htBvTLIBb/QwomabZND9vvREe7u6fNwrz3t9woYfHUbOoIKST21gd5aKDFqYQgknstbuQTRRO3Bt1l4tA8zLbvf4oAcYGus3awjk=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=NUUE6zxynpgWq/cJHFAolsgWAo9l5vDKKEudpxIVWow=;
	h=date:mime-version:subject:message-id:from;

In analogix_dp_link_start(), &link_train.training_lane[] is used to
set phy PE/VS configurations, and buf[] is initialized with the same
values to set DPCD DP_TRAINING_LANEx_SET.

It makes sense to reuse &link_train.training_lane[] to set DPCD
DP_TRAINING_LANEx_SET, which can remove the redundant assignments
and make codes more consice.

Signed-off-by: Damon Ding <damon.ding@rock-chips.com>
---
 drivers/gpu/drm/bridge/analogix/analogix_dp_core.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
index ed35e567d117..ec8443d66075 100644
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


