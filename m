Return-Path: <linux-kernel+bounces-766407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B4582B24654
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 11:59:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9DF21BC2CAB
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 09:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD3682F28E1;
	Wed, 13 Aug 2025 09:53:09 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF6862F068C
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 09:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755078789; cv=none; b=I1DuPeSQr+tj29CD6ocdlv1p1hoLBWoW0xUMhm9cfhpYbxtpv5ue9gvf6zhhTV5EaDUtAhh73Prg1SBaVuU2RQSuLs25nGa+2IM9wPKVYgcfs1KAAYU2EInI9BTLa6HttLlTzLcCfcfaOjjtfzwfj4lWH4dZBor4Xx24AUopauU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755078789; c=relaxed/simple;
	bh=TK2ZEXbIXqM/yWm4dlpLe3iG7f8iQZ4ViES2xGYTkNU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fksiHv02m3JbjX8hwbUP9agRBAxqD6s5egftzPF0r/HlJUEXqwmVcGJ+X1aokedrkB4Va+gfmYVGRlpk+Zy40PMY+8UNvLUkWOYN9jBXEaWzRuA6HtIlBw7EatRLEXmVDqp+cwDxqbC4eZ83hUZxy/jVH/sZjCne7QCp7mDpCjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4c23Wp10p9z1R92H;
	Wed, 13 Aug 2025 17:50:14 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 1E45A1401F0;
	Wed, 13 Aug 2025 17:53:04 +0800 (CST)
Received: from kwepemq100007.china.huawei.com (7.202.195.175) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 13 Aug 2025 17:53:03 +0800
Received: from localhost.huawei.com (10.169.71.169) by
 kwepemq100007.china.huawei.com (7.202.195.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 13 Aug 2025 17:53:03 +0800
From: Yongbang Shi <shiyongbang@huawei.com>
To: <xinliang.liu@linaro.org>, <tiantao6@hisilicon.com>,
	<maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
	<tzimmermann@suse.de>, <airlied@gmail.com>, <daniel@ffwll.ch>,
	<kong.kongxinwei@hisilicon.com>, <dmitry.baryshkov@oss.qualcomm.com>
CC: <liangjian010@huawei.com>, <chenjianmin@huawei.com>,
	<fengsheng5@huawei.com>, <shiyongbang@huawei.com>, <libaihan@huawei.com>,
	<shenjian15@huawei.com>, <shaojijie@huawei.com>,
	<dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 drm-dp 01/11] drm/hisilicon/hibmc: fix the i2c device resource leak when vdac init failed
Date: Wed, 13 Aug 2025 17:42:28 +0800
Message-ID: <20250813094238.3722345-2-shiyongbang@huawei.com>
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

Currently the driver missed to clean the i2c adapter when vdac init failed.
It may cause resource leak.

Fixes: a0d078d06e516 ("drm/hisilicon: Features to support reading resolutions from EDID")
Signed-off-by: Baihan Li <libaihan@huawei.com>
Signed-off-by: Yongbang Shi <shiyongbang@huawei.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h  |  1 +
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_i2c.c  |  5 +++++
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c | 11 ++++++++---
 3 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
index 274feabe7df0..ca8502e2760c 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
+++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
@@ -69,6 +69,7 @@ int hibmc_de_init(struct hibmc_drm_private *priv);
 int hibmc_vdac_init(struct hibmc_drm_private *priv);
 
 int hibmc_ddc_create(struct drm_device *drm_dev, struct hibmc_vdac *connector);
+void hibmc_ddc_del(struct hibmc_vdac *vdac);
 
 int hibmc_dp_init(struct hibmc_drm_private *priv);
 
diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_i2c.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_i2c.c
index 99b3b77b5445..44860011855e 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_i2c.c
+++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_i2c.c
@@ -95,3 +95,8 @@ int hibmc_ddc_create(struct drm_device *drm_dev, struct hibmc_vdac *vdac)
 
 	return i2c_bit_add_bus(&vdac->adapter);
 }
+
+void hibmc_ddc_del(struct hibmc_vdac *vdac)
+{
+	i2c_del_adapter(&vdac->adapter);
+}
diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c
index e8a527ede854..841e81f47b68 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c
+++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c
@@ -53,7 +53,7 @@ static void hibmc_connector_destroy(struct drm_connector *connector)
 {
 	struct hibmc_vdac *vdac = to_hibmc_vdac(connector);
 
-	i2c_del_adapter(&vdac->adapter);
+	hibmc_ddc_del(vdac);
 	drm_connector_cleanup(connector);
 }
 
@@ -110,7 +110,7 @@ int hibmc_vdac_init(struct hibmc_drm_private *priv)
 	ret = drmm_encoder_init(dev, encoder, NULL, DRM_MODE_ENCODER_DAC, NULL);
 	if (ret) {
 		drm_err(dev, "failed to init encoder: %d\n", ret);
-		return ret;
+		goto err;
 	}
 
 	drm_encoder_helper_add(encoder, &hibmc_encoder_helper_funcs);
@@ -121,7 +121,7 @@ int hibmc_vdac_init(struct hibmc_drm_private *priv)
 					  &vdac->adapter);
 	if (ret) {
 		drm_err(dev, "failed to init connector: %d\n", ret);
-		return ret;
+		goto err;
 	}
 
 	drm_connector_helper_add(connector, &hibmc_connector_helper_funcs);
@@ -131,4 +131,9 @@ int hibmc_vdac_init(struct hibmc_drm_private *priv)
 	connector->polled = DRM_CONNECTOR_POLL_CONNECT | DRM_CONNECTOR_POLL_DISCONNECT;
 
 	return 0;
+
+err:
+	hibmc_ddc_del(vdac);
+
+	return ret;
 }
-- 
2.33.0


