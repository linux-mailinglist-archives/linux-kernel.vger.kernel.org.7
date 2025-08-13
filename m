Return-Path: <linux-kernel+bounces-766413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ED79B2465D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 12:00:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C3381BC5C96
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 09:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E11D42F3C3F;
	Wed, 13 Aug 2025 09:53:14 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F722F532C
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 09:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755078794; cv=none; b=bNBbakDzU8G6m1l+arUWwhsVKnzXJ9xvXExNBZh5/cDbg033/utzG6wTb807IzFyI/wCnfP41FMhnp57RHfh02u1Z04V4Ggc/VRaGY5pKf+Ty7VuqTRqO8WsNRjiQ9/G+71X+XS4UVBwcmq+cXtJqe1BDexE+T3TNWUR1Ut3Rk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755078794; c=relaxed/simple;
	bh=m4e3YXfGrUlumjQ+IJCNZGv1+A7H492zZT3A0cl7GUA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QdONUkCR1YELarotXNtC/uRSqZLzMorb0gWAZduyVzNzuPx+qfkNel33Xh1vulFS3ybtUAvezkykbk3DldDV40AYMv1ylN37u5gQYIhsSrLWqzchI/yK5iJGUA6jzrsFj6WmSN0YgFM6CCC7c6X1mvJkLzkBiXxLJ55idShWWXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4c23TP2Mw7z14MNq;
	Wed, 13 Aug 2025 17:48:09 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
	by mail.maildlp.com (Postfix) with ESMTPS id B8749140145;
	Wed, 13 Aug 2025 17:53:08 +0800 (CST)
Received: from kwepemq100007.china.huawei.com (7.202.195.175) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 13 Aug 2025 17:53:08 +0800
Received: from localhost.huawei.com (10.169.71.169) by
 kwepemq100007.china.huawei.com (7.202.195.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 13 Aug 2025 17:53:05 +0800
From: Yongbang Shi <shiyongbang@huawei.com>
To: <xinliang.liu@linaro.org>, <tiantao6@hisilicon.com>,
	<maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
	<tzimmermann@suse.de>, <airlied@gmail.com>, <daniel@ffwll.ch>,
	<kong.kongxinwei@hisilicon.com>, <dmitry.baryshkov@oss.qualcomm.com>
CC: <liangjian010@huawei.com>, <chenjianmin@huawei.com>,
	<fengsheng5@huawei.com>, <shiyongbang@huawei.com>, <libaihan@huawei.com>,
	<shenjian15@huawei.com>, <shaojijie@huawei.com>,
	<dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 drm-dp 05/11] drm/hisilicon/hibmc: fix rare monitors cannot display problem
Date: Wed, 13 Aug 2025 17:42:32 +0800
Message-ID: <20250813094238.3722345-6-shiyongbang@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250813094238.3722345-1-shiyongbang@huawei.com>
References: <20250813094238.3722345-1-shiyongbang@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemq100007.china.huawei.com (7.202.195.175)

From: Baihan Li <libaihan@huawei.com>

In some case, the dp link training success at 8.1Gbps, but the sink's
maximum supported rate is less than 8.1G. So change the default 8.1Gbps
link rate to the rate that reads from devices' capabilities.

Fixes: 54063d86e036 ("drm/hisilicon/hibmc: add dp link moduel in hibmc drivers")
Signed-off-by: Baihan Li <libaihan@huawei.com>
Signed-off-by: Yongbang Shi <shiyongbang@huawei.com>
---
ChangeLog:
v3 -> v4:
  - remove non-related changes, suggested by Dmitry Baryshkov.
---
 drivers/gpu/drm/hisilicon/hibmc/dp/dp_link.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_link.c b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_link.c
index 74f7832ea53e..0726cb5b736e 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_link.c
+++ b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_link.c
@@ -325,6 +325,17 @@ static int hibmc_dp_link_downgrade_training_eq(struct hibmc_dp_dev *dp)
 	return hibmc_dp_link_reduce_rate(dp);
 }
 
+static void hibmc_dp_update_caps(struct hibmc_dp_dev *dp)
+{
+	dp->link.cap.link_rate = dp->dpcd[DP_MAX_LINK_RATE];
+	if (dp->link.cap.link_rate > DP_LINK_BW_8_1 || !dp->link.cap.link_rate)
+		dp->link.cap.link_rate = DP_LINK_BW_8_1;
+
+	dp->link.cap.lanes = dp->dpcd[DP_MAX_LANE_COUNT] & DP_MAX_LANE_COUNT_MASK;
+	if (dp->link.cap.lanes > HIBMC_DP_LANE_NUM_MAX)
+		dp->link.cap.lanes = HIBMC_DP_LANE_NUM_MAX;
+}
+
 int hibmc_dp_link_training(struct hibmc_dp_dev *dp)
 {
 	struct hibmc_dp_link *link = &dp->link;
@@ -334,8 +345,7 @@ int hibmc_dp_link_training(struct hibmc_dp_dev *dp)
 	if (ret)
 		drm_err(dp->dev, "dp aux read dpcd failed, ret: %d\n", ret);
 
-	dp->link.cap.link_rate = dp->dpcd[DP_MAX_LINK_RATE];
-	dp->link.cap.lanes = 0x2;
+	hibmc_dp_update_caps(dp);
 
 	ret = hibmc_dp_get_serdes_rate_cfg(dp);
 	if (ret < 0)
-- 
2.33.0


