Return-Path: <linux-kernel+bounces-785837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 314A3B351A8
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 04:29:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D6A324560B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 02:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32F7A247299;
	Tue, 26 Aug 2025 02:28:44 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3767C22B586
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 02:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756175323; cv=none; b=XphxGcR0b23FpnCD7DHxaBOA+Oa1n9+o9XMWNiAo71QSAHm9sgp7P0h6AcrGgF5oCgyiVIBV76qYcn/PzWJBjKjpf9cBfjlFIekfPzcbaJDxsVR5QogMOlvR7ZBtJMy5dUEQhWT3NAx2RnJLSjLWP0lofV4HYXYbp1SNUX+eBwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756175323; c=relaxed/simple;
	bh=VjTnvR1qt8VNw7nktqcrsUlKqEQLmvaYHKeIZ/noFic=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KBl+kKKzjwMYxTRjVcJ1yl3gFhx4hM35xNI0MhohD13hxJq+UOsj8AuxNIihlDDJCB22O5noTDd0W5Zt4xfPZ0fYeLi5Kl0TRO0BAYRUP4mSfOQ+QX7aoTZT8TyPg0IWShcRrTgxC99OnOp3AWotaotgGmODMYYHZIHYCY0Lylg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4c9s5t2jGWz14MjR;
	Tue, 26 Aug 2025 10:28:18 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
	by mail.maildlp.com (Postfix) with ESMTPS id AF7CA180B6A;
	Tue, 26 Aug 2025 10:28:24 +0800 (CST)
Received: from kwepemq100007.china.huawei.com (7.202.195.175) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 26 Aug 2025 10:28:24 +0800
Received: from localhost.huawei.com (10.169.71.169) by
 kwepemq100007.china.huawei.com (7.202.195.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 26 Aug 2025 10:28:23 +0800
From: Yongbang Shi <shiyongbang@huawei.com>
To: <xinliang.liu@linaro.org>, <tiantao6@hisilicon.com>,
	<maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
	<tzimmermann@suse.de>, <airlied@gmail.com>, <daniel@ffwll.ch>,
	<kong.kongxinwei@hisilicon.com>, <dmitry.baryshkov@oss.qualcomm.com>
CC: <liangjian010@huawei.com>, <chenjianmin@huawei.com>,
	<fengsheng5@huawei.com>, <shiyongbang@huawei.com>, <libaihan@huawei.com>,
	<shenjian15@huawei.com>, <shaojijie@huawei.com>,
	<dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 drm-dp 1/4] drm/hisilicon/hibmc: fix dp probabilistical detect errors after HPD irq
Date: Tue, 26 Aug 2025 10:17:41 +0800
Message-ID: <20250826021744.3237574-2-shiyongbang@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250826021744.3237574-1-shiyongbang@huawei.com>
References: <20250826021744.3237574-1-shiyongbang@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemq100007.china.huawei.com (7.202.195.175)

From: Baihan Li <libaihan@huawei.com>

The issue is that drm_connector_helper_detect_from_ddc() returns wrong
status when plugging or unplugging the monitor. To perform a DP detect(),
add read_dpcd_cap() and read_sink_count() to detect DP monitor, and 200ms
delay doesn't need anymore.

Fixes: 3c7623fb5bb6 ("drm/hisilicon/hibmc: Enable this hot plug detect of irq feature")
Signed-off-by: Baihan Li <libaihan@huawei.com>
Signed-off-by: Yongbang Shi <shiyongbang@huawei.com>
---
ChangeLog:
v4 -> v5:
  - fix the commit message and DP detect_ctx(), suggested by Dmitry Baryshkov.
---
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c
index d06832e62e96..123372ae2d40 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c
+++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c
@@ -12,6 +12,7 @@
 
 #include "hibmc_drm_drv.h"
 #include "dp/dp_hw.h"
+#include "dp/dp_comm.h"
 
 #define DP_MASKED_SINK_HPD_PLUG_INT	BIT(2)
 
@@ -34,7 +35,16 @@ static int hibmc_dp_connector_get_modes(struct drm_connector *connector)
 static int hibmc_dp_detect(struct drm_connector *connector,
 			   struct drm_modeset_acquire_ctx *ctx, bool force)
 {
-	mdelay(200);
+	struct hibmc_dp *dp = to_hibmc_dp(connector);
+	int ret;
+
+	ret = drm_dp_read_dpcd_caps(&dp->aux, dp->dp_dev->dpcd);
+	if (ret)
+		return connector_status_disconnected;
+
+	ret = drm_dp_read_sink_count(&dp->aux);
+	if (ret <= 0)
+		return connector_status_disconnected;
 
 	return drm_connector_helper_detect_from_ddc(connector, ctx, force);
 }
-- 
2.33.0


