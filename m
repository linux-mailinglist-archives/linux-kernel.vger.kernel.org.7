Return-Path: <linux-kernel+bounces-736357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C67AFB09BEA
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 09:02:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 248C8A41A61
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 07:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D5D92206AC;
	Fri, 18 Jul 2025 07:01:31 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A64CF212B2F
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 07:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752822090; cv=none; b=jsPv+K7AULPnxgYzhF6MeX8sChuxGVrUFNIkvC+9FfP8n9fHyN37BQxgo6TPSVCL/kmhd//TXE0f9Ou7a/gh4ZuH92Jyzwponr1pFkEgdyiDtqOJ0bRyAYWLE9WeVXSiof8IVpFm3l//s3ZuSshgZIILBl9zDDZ1QWzRtlWfk8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752822090; c=relaxed/simple;
	bh=j2sqFF+CJglhl6Nw4iDMqcUaEPgO0a/BukzAkM+OGJs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZzTipRbuqR22XRN4HZp0CBfXeliWQT4rtMB37VJU76M2PZPL06dvwV5xUHZhCaxO4tUdS1wQotuPVkB7fm0btninruzYsqcl8YuaIXmeCC3xW5iZmZ8TUGA2GO3mntVdQC/BDPe0gF7Hlc0GbrvVNcfpdhG7mMDiVsBrl0xD9m0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4bk0wG0lV1zdbwy;
	Fri, 18 Jul 2025 14:57:18 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 3432C180B66;
	Fri, 18 Jul 2025 15:01:26 +0800 (CST)
Received: from kwepemq100007.china.huawei.com (7.202.195.175) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 18 Jul 2025 15:01:26 +0800
Received: from localhost.huawei.com (10.169.71.169) by
 kwepemq100007.china.huawei.com (7.202.195.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 18 Jul 2025 15:01:25 +0800
From: Yongbang Shi <shiyongbang@huawei.com>
To: <xinliang.liu@linaro.org>, <tiantao6@hisilicon.com>,
	<maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
	<tzimmermann@suse.de>, <airlied@gmail.com>, <daniel@ffwll.ch>,
	<kong.kongxinwei@hisilicon.com>, <dmitry.baryshkov@oss.qualcomm.com>
CC: <liangjian010@huawei.com>, <chenjianmin@huawei.com>,
	<fengsheng5@huawei.com>, <shiyongbang@huawei.com>, <libaihan@huawei.com>,
	<shenjian15@huawei.com>, <shaojijie@huawei.com>,
	<jani.nikula@linux.intel.com>, <dri-devel@lists.freedesktop.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v3 drm-dp 08/11] drm/hisilicon/hibmc: fix no showing when no connectors connected
Date: Fri, 18 Jul 2025 14:51:22 +0800
Message-ID: <20250718065125.2892404-9-shiyongbang@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250718065125.2892404-1-shiyongbang@huawei.com>
References: <20250718065125.2892404-1-shiyongbang@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemq100007.china.huawei.com (7.202.195.175)

From: Baihan Li <libaihan@huawei.com>

Our chip support KVM over IP feature, so hibmc diiver need to support
displaying without any connectors plugged in. If no connectors connected,
set the vdac connector status to 'connected' to handle BMC KVM. Use
is_connected to check all physical outputs.
For get_modes: using BMC modes for connector if no display is attached to
phys VGA cable, otherwise use EDID modes by drm_connector_helper_get_modes.

Fixes: 4c962bc929f1 ("drm/hisilicon/hibmc: Add vga connector detect functions")
Signed-off-by: Baihan Li <libaihan@huawei.com>
Signed-off-by: Yongbang Shi <shiyongbang@huawei.com>
---
ChangeLog:
v2 -> v3:
  - fix hibmc_connector_get_modes() and hibmc_vdac_detect() to realize BMC KVM, suggested by Dmitry Baryshkov.
---
 .../gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c    |  5 +-
 .../gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h   |  4 ++
 .../gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c  | 55 +++++++++++++------
 3 files changed, 45 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c
index 99b30a6c7e06..262ebe6138f0 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c
+++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c
@@ -58,9 +58,12 @@ static int hibmc_dp_detect(struct drm_connector *connector,
 {
 	struct hibmc_drm_private *priv = to_hibmc_drm_private(connector->dev);
 
-	if (!hibmc_dp_detect_link(&priv->dp))
+	if (!hibmc_dp_detect_link(&priv->dp)) {
+		priv->is_connected |= BIT(0);
 		return connector_status_connected;
+	}
 
+	priv->is_connected &= ~BIT(0);
 	return connector_status_disconnected;
 }
 
diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
index ca8502e2760c..d68588ecec9b 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
+++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
@@ -31,6 +31,7 @@ struct hibmc_vdac {
 	struct drm_connector connector;
 	struct i2c_adapter adapter;
 	struct i2c_algo_bit_data bit_data;
+	int phys_status;
 };
 
 struct hibmc_drm_private {
@@ -43,6 +44,9 @@ struct hibmc_drm_private {
 	struct drm_crtc crtc;
 	struct hibmc_vdac vdac;
 	struct hibmc_dp dp;
+
+	/* VGA and DP phys connect status, BIT(0) is DP, BIT(1) is VGA */
+	int is_connected;
 };
 
 static inline struct hibmc_vdac *to_hibmc_vdac(struct drm_connector *connector)
diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c
index 841e81f47b68..3cdf640d1785 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c
+++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c
@@ -25,27 +25,18 @@
 static int hibmc_connector_get_modes(struct drm_connector *connector)
 {
 	struct hibmc_vdac *vdac = to_hibmc_vdac(connector);
-	const struct drm_edid *drm_edid;
 	int count;
 
-	drm_edid = drm_edid_read_ddc(connector, &vdac->adapter);
-
-	drm_edid_connector_update(connector, drm_edid);
-
-	if (drm_edid) {
-		count = drm_edid_connector_add_modes(connector);
-		if (count)
-			goto out;
+	if (vdac->phys_status == connector_status_connected) {
+		count = drm_connector_helper_get_modes(connector);
+	} else {
+		drm_edid_connector_update(connector, NULL);
+		count = drm_add_modes_noedid(connector,
+					     connector->dev->mode_config.max_width,
+					     connector->dev->mode_config.max_height);
+		drm_set_preferred_mode(connector, 1024, 768); // 1024x768
 	}
 
-	count = drm_add_modes_noedid(connector,
-				     connector->dev->mode_config.max_width,
-				     connector->dev->mode_config.max_height);
-	drm_set_preferred_mode(connector, 1024, 768);
-
-out:
-	drm_edid_free(drm_edid);
-
 	return count;
 }
 
@@ -57,10 +48,38 @@ static void hibmc_connector_destroy(struct drm_connector *connector)
 	drm_connector_cleanup(connector);
 }
 
+static int hibmc_vdac_detect(struct drm_connector *connector,
+			     struct drm_modeset_acquire_ctx *ctx,
+			     bool force)
+{
+	struct hibmc_drm_private *priv = to_hibmc_drm_private(connector->dev);
+	struct hibmc_vdac *vdac = to_hibmc_vdac(connector);
+	enum drm_connector_status status;
+
+	status = drm_connector_helper_detect_from_ddc(connector, ctx, force);
+
+	vdac->phys_status = status;
+
+	if (status == connector_status_connected) {
+		priv->is_connected |= BIT(1);
+		return connector_status_connected;
+	}
+
+	priv->is_connected &= ~BIT(1);
+
+	/* if all connectors are disconnected,
+	 * return connected to support BMC KVM display.
+	 */
+	if (!priv->is_connected)
+		return connector_status_connected;
+
+	return connector_status_disconnected;
+}
+
 static const struct drm_connector_helper_funcs
 	hibmc_connector_helper_funcs = {
 	.get_modes = hibmc_connector_get_modes,
-	.detect_ctx = drm_connector_helper_detect_from_ddc,
+	.detect_ctx = hibmc_vdac_detect,
 };
 
 static const struct drm_connector_funcs hibmc_connector_funcs = {
-- 
2.33.0


