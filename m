Return-Path: <linux-kernel+bounces-897759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 984BFC539D7
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 18:15:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BD56566DA8
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 16:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B7F73451CD;
	Wed, 12 Nov 2025 16:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="uXGm9niC"
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5545D328270
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 16:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762965299; cv=none; b=dMCr3pTd4gxjYF6iXMM7yidPaPO5Gpw5fWmZPIxLdp3QUBsvl/jaH7kWeo//DO29u5sDtyp5ef0PcECczjY2GAX1P3Jb1B5UGiznZzHc0Hyqp8bX/4zi5QbkYPZ8uJt4YGX4rmso9Dm9XGejQesv9k+IVz6Z+zXy5nf4OJyW9ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762965299; c=relaxed/simple;
	bh=iddbU73MIU0wsEL139orRGRzGpm285N28O0OK4pFHlQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IaFzETj3df4GRrt3zwyU9MYhRbz8acE4gvFU6vAxNy4twDsnkQuTfMDA4BFoe8T87Gg1uj2a1hmb2weVXBNsyEqsltoBRz8GF1PgawrUlfAnSykyw1xymRVQtxSQbisXkpmRWr3vQ8/N3D2wg/d78Y04SQ0iqVgfC27GXpgX2FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=uXGm9niC; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id C39D01A1A42;
	Wed, 12 Nov 2025 16:34:55 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 996F86070B;
	Wed, 12 Nov 2025 16:34:55 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 10D10102F1BA8;
	Wed, 12 Nov 2025 17:34:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1762965294; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=0pMT+aT4AJiznRBcaHknDkWgDDjg3dsj5pXkKOf+n0k=;
	b=uXGm9niCgFce1r9ejT7Q27ZwTUZBk8vJxQc2SmlAWHeACNSg4Aqfw3fZVCw4CbfNctuvB3
	hzOZKd9NarrtUO0cuGkE1IDaGe1Mp7imOKTqORu/f7D4ANOyKZa1dv4mhT61OsCZPNALaL
	rRX4inqocvpaHXArIQyEdNPJXYcxTLq8szAKB7KwzdJo5ajk6XdxPu4P5njHRJ4zxUSzu4
	xg8eXeXXqmYfYYegYgVY6xC14Yvds1tRcRDAZm1N0lifgSx8ZtBwE3YS7SmWHZxpIiVYqb
	F2KcpeH6cpUzwxkn9P2EPNg+gAC/o3hmd5M4ehrgZfvA/tdv1Z/fStH/7C86CQ==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Wed, 12 Nov 2025 17:34:35 +0100
Subject: [PATCH v3 2/2] drm/bridge: ti-sn65dsi83: protect device resources
 on unplug
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251112-drm-bridge-atomic-vs-remove-v3-2-85db717ce094@bootlin.com>
References: <20251112-drm-bridge-atomic-vs-remove-v3-0-85db717ce094@bootlin.com>
In-Reply-To: <20251112-drm-bridge-atomic-vs-remove-v3-0-85db717ce094@bootlin.com>
To: Maxime Ripard <mripard@kernel.org>, Simona Vetter <simona@ffwll.ch>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>
Cc: Hui Pu <Hui.Pu@gehealthcare.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Dmitry Baryshkov <lumag@kernel.org>
X-Mailer: b4 0.14.2
X-Last-TLS-Session-Version: TLSv1.3

To support hot-unplug of this bridge we need to protect access to device
resources in case sn65dsi83_remove() happens concurrently to other code.

Some care is needed for the case when the unplug happens before
sn65dsi83_atomic_disable() has a chance to enter the critical section
(i.e. a successful drm_bridge_enter() call), which occurs whenever the
hardware is removed while the display is active. When that happens,
sn65dsi83_atomic_disable() in unable to release the resources taken by
sn65dsi83_atomic_pre_enable().

To ensure those resources are released exactly once on device removal:

 * move the code to release them to a dedicated function
 * register that function when the resources are taken in
   sn65dsi83_atomic_pre_enable()
 * if sn65dsi83_atomic_disable() happens before sn65dsi83_remove()
   (typical non-hot-unplug case):
   * sn65dsi83_atomic_disable() can enter the critical section
     (drm_bridge_enter() returns 0) -> it releases and executes the
     devres action
 * if sn65dsi83_atomic_disable() happens after sn65dsi83_remove()
   (typical hot-unplug case):
   * sn65dsi83_remove() -> drm_bridge_unplug() prevents
     sn65dsi83_atomic_disable() from entering the critical section
     (drm_bridge_enter() returns nonzero), so sn65dsi83_atomic_disable()
     cannot release and execute the devres action
   * the devres action is executed at the end of sn65dsi83_remove()

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

---

Changes in v3:
- Don't call drm_bridge_remove(), it's now in drm_bridge_unplug()
- use gotos for error management in sn65dsi83_atomic_pre_enable()
- simplify sn65dsi83_release_resources() comment

Changes in v2:
- Use a devres action instead of a flag
---
 drivers/gpu/drm/bridge/ti-sn65dsi83.c | 86 +++++++++++++++++++++++++++--------
 1 file changed, 66 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi83.c b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
index 033c44326552ab167d4e8d9b74957c585e4c6fb7..ac74b9e85b97604c95a255fc2c59bd0e7a3137f5 100644
--- a/drivers/gpu/drm/bridge/ti-sn65dsi83.c
+++ b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
@@ -406,6 +406,10 @@ static void sn65dsi83_reset_work(struct work_struct *ws)
 {
 	struct sn65dsi83 *ctx = container_of(ws, struct sn65dsi83, reset_work);
 	int ret;
+	int idx;
+
+	if (!drm_bridge_enter(&ctx->bridge, &idx))
+		return;
 
 	/* Reset the pipe */
 	ret = sn65dsi83_reset_pipe(ctx);
@@ -415,12 +419,18 @@ static void sn65dsi83_reset_work(struct work_struct *ws)
 	}
 	if (ctx->irq)
 		enable_irq(ctx->irq);
+
+	drm_bridge_exit(idx);
 }
 
 static void sn65dsi83_handle_errors(struct sn65dsi83 *ctx)
 {
 	unsigned int irq_stat;
 	int ret;
+	int idx;
+
+	if (!drm_bridge_enter(&ctx->bridge, &idx))
+		return;
 
 	/*
 	 * Schedule a reset in case of:
@@ -441,6 +451,8 @@ static void sn65dsi83_handle_errors(struct sn65dsi83 *ctx)
 
 		schedule_work(&ctx->reset_work);
 	}
+
+	drm_bridge_exit(idx);
 }
 
 static void sn65dsi83_monitor_work(struct work_struct *work)
@@ -463,6 +475,37 @@ static void sn65dsi83_monitor_stop(struct sn65dsi83 *ctx)
 	cancel_delayed_work_sync(&ctx->monitor_work);
 }
 
+/*
+ * Release resources taken by sn65dsi83_atomic_pre_enable().
+ *
+ * Invoked by sn65dsi83_atomic_disable() normally, or by devres after
+ * sn65dsi83_remove() in case this happens befora atomic_disable.
+ */
+static void sn65dsi83_release_resources(void *data)
+{
+	struct sn65dsi83 *ctx = (struct sn65dsi83 *)data;
+	int ret;
+
+	if (ctx->irq) {
+		/* Disable irq */
+		regmap_write(ctx->regmap, REG_IRQ_EN, 0x0);
+		regmap_write(ctx->regmap, REG_IRQ_GLOBAL, 0x0);
+	} else {
+		/* Stop the polling task */
+		sn65dsi83_monitor_stop(ctx);
+	}
+
+	/* Put the chip in reset, pull EN line low, and assure 10ms reset low timing. */
+	gpiod_set_value_cansleep(ctx->enable_gpio, 0);
+	usleep_range(10000, 11000);
+
+	ret = regulator_disable(ctx->vcc);
+	if (ret)
+		dev_err(ctx->dev, "Failed to disable vcc: %d\n", ret);
+
+	regcache_mark_dirty(ctx->regmap);
+}
+
 static void sn65dsi83_atomic_pre_enable(struct drm_bridge *bridge,
 					struct drm_atomic_state *state)
 {
@@ -478,11 +521,15 @@ static void sn65dsi83_atomic_pre_enable(struct drm_bridge *bridge,
 	__le16 le16val;
 	u16 val;
 	int ret;
+	int idx;
+
+	if (!drm_bridge_enter(bridge, &idx))
+		return;
 
 	ret = regulator_enable(ctx->vcc);
 	if (ret) {
 		dev_err(ctx->dev, "Failed to enable vcc: %d\n", ret);
-		return;
+		goto err_exit;
 	}
 
 	/* Deassert reset */
@@ -625,7 +672,7 @@ static void sn65dsi83_atomic_pre_enable(struct drm_bridge *bridge,
 		dev_err(ctx->dev, "failed to lock PLL, ret=%i\n", ret);
 		/* On failure, disable PLL again and exit. */
 		regmap_write(ctx->regmap, REG_RC_PLL_EN, 0x00);
-		return;
+		goto err_add_action;
 	}
 
 	/* Trigger reset after CSR register update. */
@@ -633,6 +680,11 @@ static void sn65dsi83_atomic_pre_enable(struct drm_bridge *bridge,
 
 	/* Wait for 10ms after soft reset as specified in datasheet */
 	usleep_range(10000, 12000);
+
+err_add_action:
+	devm_add_action(ctx->dev, sn65dsi83_release_resources, ctx);
+err_exit:
+	drm_bridge_exit(idx);
 }
 
 static void sn65dsi83_atomic_enable(struct drm_bridge *bridge,
@@ -640,6 +692,10 @@ static void sn65dsi83_atomic_enable(struct drm_bridge *bridge,
 {
 	struct sn65dsi83 *ctx = bridge_to_sn65dsi83(bridge);
 	unsigned int pval;
+	int idx;
+
+	if (!drm_bridge_enter(bridge, &idx))
+		return;
 
 	/* Clear all errors that got asserted during initialization. */
 	regmap_read(ctx->regmap, REG_IRQ_STAT, &pval);
@@ -659,32 +715,22 @@ static void sn65dsi83_atomic_enable(struct drm_bridge *bridge,
 		/* Use the polling task */
 		sn65dsi83_monitor_start(ctx);
 	}
+
+	drm_bridge_exit(idx);
 }
 
 static void sn65dsi83_atomic_disable(struct drm_bridge *bridge,
 				     struct drm_atomic_state *state)
 {
 	struct sn65dsi83 *ctx = bridge_to_sn65dsi83(bridge);
-	int ret;
+	int idx;
 
-	if (ctx->irq) {
-		/* Disable irq */
-		regmap_write(ctx->regmap, REG_IRQ_EN, 0x0);
-		regmap_write(ctx->regmap, REG_IRQ_GLOBAL, 0x0);
-	} else {
-		/* Stop the polling task */
-		sn65dsi83_monitor_stop(ctx);
-	}
-
-	/* Put the chip in reset, pull EN line low, and assure 10ms reset low timing. */
-	gpiod_set_value_cansleep(ctx->enable_gpio, 0);
-	usleep_range(10000, 11000);
+	if (!drm_bridge_enter(bridge, &idx))
+		return;
 
-	ret = regulator_disable(ctx->vcc);
-	if (ret)
-		dev_err(ctx->dev, "Failed to disable vcc: %d\n", ret);
+	devm_release_action(ctx->dev, sn65dsi83_release_resources, ctx);
 
-	regcache_mark_dirty(ctx->regmap);
+	drm_bridge_exit(idx);
 }
 
 static enum drm_mode_status
@@ -1005,7 +1051,7 @@ static void sn65dsi83_remove(struct i2c_client *client)
 {
 	struct sn65dsi83 *ctx = i2c_get_clientdata(client);
 
-	drm_bridge_remove(&ctx->bridge);
+	drm_bridge_unplug(&ctx->bridge);
 }
 
 static const struct i2c_device_id sn65dsi83_id[] = {

-- 
2.51.1


