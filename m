Return-Path: <linux-kernel+bounces-783586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BC16FB32F52
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 13:18:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 883AD1B24767
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 11:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A85C2D5432;
	Sun, 24 Aug 2025 11:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=grimler.se header.i=@grimler.se header.b="PffkWfbx"
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E302D5C64
	for <linux-kernel@vger.kernel.org>; Sun, 24 Aug 2025 11:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756034265; cv=none; b=qSvg6edBRSauDaGepi6fszyoOPE8yjfKthuo2OvMwrTEfSFhWnllzdNZJ7Yepq3J/K8oHxIjlThQADB4eFVzhnsnmM2ocs1ZPFTZgsV/2Al5qmMLirzRsM7XD5G6FCot+DxsPsc5TZ9YXrAhdz6sqoLUqQ4kYrsAu+rYN3K1Tr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756034265; c=relaxed/simple;
	bh=tXujzRgrrBGUn2v030aF3lID+YnDxsftptuhhBvWKg4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GgmD9k8KNQ2/kED3PMxJ6CZ5nZiTFZ+1GRIV8G4mDhlnPGrMvC6WbeFK9TGrKJpoMj5zrpfiqIZVn+5Rw2z52/5/EVhoiq2xM3L/Xz6VZZeykykKVcUg1Tv3UvBa4c6eYtf1KLPqmzj4XoMuX7Qsix2+9cYs0B19pYitYDN25RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=grimler.se; spf=pass smtp.mailfrom=grimler.se; dkim=pass (1024-bit key) header.d=grimler.se header.i=@grimler.se header.b=PffkWfbx; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=grimler.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grimler.se
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grimler.se; s=key1;
	t=1756034260;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=37+dl7EpiJ+GXGLYXXe1onZHgckG1U2hI48/KV0d1I0=;
	b=PffkWfbxzXBAdOh6czW5cQrlRuQsFnWWrDGzH11GAZCfvecRlDqtv3lMN8b5oKcrvDOYiH
	0xnwivO8jQPgNxPk8NFeEIiPOA/VHcNw6QOhlz/O1IogfqlOMvzWVRBJzwWxqgP54+ekKk
	UmmasPAmFjDmxV6i+1qZZKjujXvz+K8=
From: Henrik Grimler <henrik@grimler.se>
Date: Sun, 24 Aug 2025 13:16:56 +0200
Subject: [PATCH v3 3/3] drm/bridge: sii9234: use extcon cable detection
 logic to detect MHL
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250824-exynos4-sii9234-driver-v3-3-80849e716a37@grimler.se>
References: <20250824-exynos4-sii9234-driver-v3-0-80849e716a37@grimler.se>
In-Reply-To: <20250824-exynos4-sii9234-driver-v3-0-80849e716a37@grimler.se>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-samsung-soc@vger.kernel.org, 
 ~postmarketos/upstreaming@lists.sr.ht, replicant@osuosl.org, 
 linux-kernel@vger.kernel.org, Henrik Grimler <henrik@grimler.se>
X-Developer-Signature: v=1; a=openpgp-sha256; l=4972; i=henrik@grimler.se;
 h=from:subject:message-id; bh=tXujzRgrrBGUn2v030aF3lID+YnDxsftptuhhBvWKg4=;
 b=kA0DAAoBsAduSQtxYWsByyZiAGiq9MGgu7d0a5IvpXE27Z/Vihx4bBp4EscBPD4qgCydQJkHr
 4kBMwQAAQoAHRYhBCx/Ka6XiR9kGanizbAHbkkLcWFrBQJoqvTBAAoJELAHbkkLcWFrLCcIAIm1
 nM3abFAj8mHjSAHke+KtItJOiyo8GtEdvaJzrlL/t0bAMxUDDWG7tW71BiFBCtbeW4pjD0RE6Vo
 lidu4/+xACv/LTWQ6038x4LHfOoczXxyIVxIZqJvYIBR0jQu2f69QVGUfDR9/o1GCMLLBObYyqP
 9gzyCSYiB1t2LfbSQnpaM5q1zF30Z6fJ9O1aslK6TV3Ot86RpSnwyMkLf3jziqOCkV2+QoEJPIU
 UAESmv8MKGrzOYJFwGpTrknV314YnoSG+ODiP1wypPakj/VBTbiAjJJf8VeVmV0CDkBOqL+ZTP/
 qV0EOSlEwhGj0lvLkAVIWaaEy8qm0zgkDnfIGWA=
X-Developer-Key: i=henrik@grimler.se; a=openpgp;
 fpr=2C7F29AE97891F6419A9E2CDB0076E490B71616B
X-Migadu-Flow: FLOW_OUT

To use MHL we currently need the MHL chip to be permanently on, which
consumes unnecessary power. Let's use extcon attached to MUIC to enable
the MHL chip only if it detects an MHL cable.

Signed-off-by: Henrik Grimler <henrik@grimler.se>
---
v3: add missing return in error path, spotted by Marek
    Use depends on EXTCON || !EXTCON instead of select
v2: add dependency on extcon. Issue reported by kernel test robot
    <lkp@intel.com>
---
 drivers/gpu/drm/bridge/Kconfig   |  1 +
 drivers/gpu/drm/bridge/sii9234.c | 89 ++++++++++++++++++++++++++++++++++++++--
 2 files changed, 87 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
index 6945029b35929a8e30054ac1a699bd88ab0487f2..bf73f8d900ebd8da9fa3444c0b2d9bfc901ea773 100644
--- a/drivers/gpu/drm/bridge/Kconfig
+++ b/drivers/gpu/drm/bridge/Kconfig
@@ -304,6 +304,7 @@ config DRM_SII902X
 config DRM_SII9234
 	tristate "Silicon Image SII9234 HDMI/MHL bridge"
 	depends on OF
+	depends on EXTCON || !EXTCON
 	help
 	  Say Y here if you want support for the MHL interface.
 	  It is an I2C driver, that detects connection of MHL bridge
diff --git a/drivers/gpu/drm/bridge/sii9234.c b/drivers/gpu/drm/bridge/sii9234.c
index e43248e515b3dcdde043997288d61f738417b8f0..72c6aeed6e12e43df3b052dadc0990f1609253f0 100644
--- a/drivers/gpu/drm/bridge/sii9234.c
+++ b/drivers/gpu/drm/bridge/sii9234.c
@@ -19,6 +19,7 @@
 
 #include <linux/delay.h>
 #include <linux/err.h>
+#include <linux/extcon.h>
 #include <linux/gpio/consumer.h>
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
@@ -26,6 +27,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
+#include <linux/of_graph.h>
 #include <linux/regulator/consumer.h>
 #include <linux/slab.h>
 
@@ -170,8 +172,12 @@ struct sii9234 {
 	struct drm_bridge bridge;
 	struct device *dev;
 	struct gpio_desc *gpio_reset;
-	int i2c_error;
 	struct regulator_bulk_data supplies[4];
+	struct extcon_dev *extcon;
+	struct notifier_block extcon_nb;
+	struct work_struct extcon_wq;
+	int cable_state;
+	int i2c_error;
 
 	struct mutex lock; /* Protects fields below and device registers */
 	enum sii9234_state state;
@@ -863,6 +869,70 @@ static int sii9234_init_resources(struct sii9234 *ctx,
 	return 0;
 }
 
+static void sii9234_extcon_work(struct work_struct *work)
+{
+	struct sii9234 *ctx =
+		container_of(work, struct sii9234, extcon_wq);
+	int state = extcon_get_state(ctx->extcon, EXTCON_DISP_MHL);
+
+	if (state == ctx->cable_state)
+		return;
+
+	ctx->cable_state = state;
+
+	if (state > 0)
+		sii9234_cable_in(ctx);
+	else
+		sii9234_cable_out(ctx);
+}
+
+static int sii9234_extcon_notifier(struct notifier_block *self,
+			unsigned long event, void *ptr)
+{
+	struct sii9234 *ctx =
+		container_of(self, struct sii9234, extcon_nb);
+
+	schedule_work(&ctx->extcon_wq);
+
+	return NOTIFY_DONE;
+}
+
+static int sii9234_extcon_init(struct sii9234 *ctx)
+{
+	struct extcon_dev *edev;
+	struct device_node *musb, *muic;
+	int ret;
+
+	/* Get micro-USB connector node */
+	musb = of_graph_get_remote_node(ctx->dev->of_node, 1, -1);
+	/* Then get micro-USB Interface Controller node */
+	muic = of_get_next_parent(musb);
+
+	if (!muic) {
+		dev_info(ctx->dev,
+			 "no extcon found, switching to 'always on' mode\n");
+		return 0;
+	}
+
+	edev = extcon_find_edev_by_node(muic);
+	of_node_put(muic);
+	if (IS_ERR(edev)) {
+		return dev_err_probe(ctx->dev, PTR_ERR(edev),
+			      "invalid or missing extcon\n");
+	}
+
+	ctx->extcon = edev;
+	ctx->extcon_nb.notifier_call = sii9234_extcon_notifier;
+	INIT_WORK(&ctx->extcon_wq, sii9234_extcon_work);
+	ret = extcon_register_notifier(edev, EXTCON_DISP_MHL, &ctx->extcon_nb);
+	if (ret) {
+		dev_err(ctx->dev, "failed to register notifier for MHL\n");
+		return ret;
+	}
+
+	return 0;
+}
+
 static enum drm_mode_status sii9234_mode_valid(struct drm_bridge *bridge,
 					 const struct drm_display_info *info,
 					 const struct drm_display_mode *mode)
@@ -915,12 +985,17 @@ static int sii9234_probe(struct i2c_client *client)
 	if (ret < 0)
 		return ret;
 
+	ret = sii9234_extcon_init(ctx);
+	if (ret < 0)
+		return ret;
+
 	i2c_set_clientdata(client, ctx);
 
 	ctx->bridge.of_node = dev->of_node;
 	drm_bridge_add(&ctx->bridge);
 
-	sii9234_cable_in(ctx);
+	if (!ctx->extcon)
+		sii9234_cable_in(ctx);
 
 	return 0;
 }
@@ -929,7 +1004,15 @@ static void sii9234_remove(struct i2c_client *client)
 {
 	struct sii9234 *ctx = i2c_get_clientdata(client);
 
-	sii9234_cable_out(ctx);
+	if (ctx->extcon) {
+		extcon_unregister_notifier(ctx->extcon, EXTCON_DISP_MHL,
+					   &ctx->extcon_nb);
+		flush_work(&ctx->extcon_wq);
+		if (ctx->cable_state > 0)
+			sii9234_cable_out(ctx);
+	} else {
+		sii9234_cable_out(ctx);
+	}
 	drm_bridge_remove(&ctx->bridge);
 }
 

-- 
2.50.1


