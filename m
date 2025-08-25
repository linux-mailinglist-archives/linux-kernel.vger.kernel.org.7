Return-Path: <linux-kernel+bounces-785711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D9D7FB34FEA
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 02:03:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0825424084D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 00:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48C8A1C84B8;
	Tue, 26 Aug 2025 00:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BDc/wCqJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81FD81A3154;
	Tue, 26 Aug 2025 00:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756166554; cv=none; b=XAMHxIW1TWadx4MvsNII9YzZ1ab5fqiKb2sYxNrCY4sAuXqxvlHWvmX35sXyvF45liy4qoxWO8K+kwAnoR69D4RQem9+WPNimIELBh1p3X2r45HKvxe5RorZ5ySO7c+2OjPxhwHbLls6axejQH2NfdmTvOrh5wR2LwaSwvjSOlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756166554; c=relaxed/simple;
	bh=KuUc+uyBlDaH4JxtsPrNSreSkkGC/S4jpGH/vLbHTBI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TNG/cTdVltLfu6pVaotv4yLXi7uUZrbYANezPsim2VVIHKGryNd2ytf/xAgllLQZvNIpc1GBnl+Q5WFPyFsg3GhdJY8xLMwwYR+3Wfw9UBYcQleU2d6mN57zgc9K8bUtbNu7mCQO1ZqhSHi1IEFOTa1M8p062BhSTXQLqRxx05c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BDc/wCqJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69F73C116C6;
	Tue, 26 Aug 2025 00:02:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756166554;
	bh=KuUc+uyBlDaH4JxtsPrNSreSkkGC/S4jpGH/vLbHTBI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BDc/wCqJWoa/EnTgU/jKMWb2ezv28bgdfMU5zwa7Cl3FYDV3W2ZVrDdCrCBrcV8m5
	 18dCQYD2d+SQugakU3gd5lX3bm9Z/3b5/o9AgQOBdPKiRPpNyXtgutLx/KyQsOjlg9
	 uIl+5k04qq6iwddrNMxHXX20otsgfX0rpb0uZcVohudptZ2OrUYC6vrx1lJpbx6NA/
	 rwBmwCM89MUviDczJMBv04C5ygpRiYN8aQmV/y+Kgr9UcGDs3d7nooKgc+0NIOvmI5
	 bwUi4VY8BFFvkjtEJfZtO/qI2yJI+vQixYVS7TWHLTZF1Jpbh3kldHw4vwqlNdp4Dz
	 2A8b/Y5/zc33A==
From: Jisheng Zhang <jszhang@kernel.org>
To: Richard Leitner <richard.leitner@linux.dev>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/3] usb: usb251xb: support usage case without I2C control
Date: Tue, 26 Aug 2025 07:45:09 +0800
Message-ID: <20250825234509.1041-4-jszhang@kernel.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250825234509.1041-1-jszhang@kernel.org>
References: <20250825234509.1041-1-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, the usb251xb assumes i2c control. But from HW point of
view, the hub supports usage case without any i2c, we only want the
gpio controls.

Refactor the code so that register writes for configuration are only
performed if the device has a i2c_client provided and also register as
a platform driver. This allows the driver to be used to manage GPIO
based control of the device.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 drivers/usb/misc/usb251xb.c | 108 +++++++++++++++++++++++++++++++-----
 1 file changed, 95 insertions(+), 13 deletions(-)

diff --git a/drivers/usb/misc/usb251xb.c b/drivers/usb/misc/usb251xb.c
index cb2f946de42c..7c0778631bea 100644
--- a/drivers/usb/misc/usb251xb.c
+++ b/drivers/usb/misc/usb251xb.c
@@ -17,6 +17,7 @@
 #include <linux/module.h>
 #include <linux/nls.h>
 #include <linux/of.h>
+#include <linux/platform_device.h>
 #include <linux/regulator/consumer.h>
 #include <linux/slab.h>
 
@@ -242,15 +243,19 @@ static int usb251xb_check_dev_children(struct device *dev, void *child)
 static int usb251x_check_gpio_chip(struct usb251xb *hub)
 {
 	struct gpio_chip *gc = gpiod_to_chip(hub->gpio_reset);
-	struct i2c_adapter *adap = hub->i2c->adapter;
+	struct i2c_adapter *adap;
 	int ret;
 
+	if (!hub->i2c)
+		return 0;
+
 	if (!hub->gpio_reset)
 		return 0;
 
 	if (!gc)
 		return -EINVAL;
 
+	adap = hub->i2c->adapter;
 	ret = usb251xb_check_dev_children(&adap->dev, gc->parent);
 	if (ret) {
 		dev_err(hub->dev, "Reset GPIO chip is at the same i2c-bus\n");
@@ -271,7 +276,8 @@ static void usb251xb_reset(struct usb251xb *hub)
 	if (!hub->gpio_reset)
 		return;
 
-	i2c_lock_bus(hub->i2c->adapter, I2C_LOCK_SEGMENT);
+	if (hub->i2c)
+		i2c_lock_bus(hub->i2c->adapter, I2C_LOCK_SEGMENT);
 
 	gpiod_set_value_cansleep(hub->gpio_reset, 1);
 	usleep_range(1, 10);	/* >=1us RESET_N asserted */
@@ -280,7 +286,8 @@ static void usb251xb_reset(struct usb251xb *hub)
 	/* wait for hub recovery/stabilization */
 	usleep_range(500, 750);	/* >=500us after RESET_N deasserted */
 
-	i2c_unlock_bus(hub->i2c->adapter, I2C_LOCK_SEGMENT);
+	if (hub->i2c)
+		i2c_unlock_bus(hub->i2c->adapter, I2C_LOCK_SEGMENT);
 }
 
 static int usb251xb_connect(struct usb251xb *hub)
@@ -289,6 +296,12 @@ static int usb251xb_connect(struct usb251xb *hub)
 	int err, i;
 	char i2c_wb[USB251XB_I2C_REG_SZ];
 
+	if (!hub->i2c) {
+		usb251xb_reset(hub);
+		dev_info(dev, "hub is put in default configuration.\n");
+		return 0;
+	}
+
 	memset(i2c_wb, 0, USB251XB_I2C_REG_SZ);
 
 	if (hub->skip_config) {
@@ -698,18 +711,13 @@ static int usb251xb_i2c_probe(struct i2c_client *i2c)
 	return usb251xb_probe(hub);
 }
 
-static int usb251xb_suspend(struct device *dev)
+static int usb251xb_suspend(struct usb251xb *hub)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct usb251xb *hub = i2c_get_clientdata(client);
-
 	return regulator_disable(hub->vdd);
 }
 
-static int usb251xb_resume(struct device *dev)
+static int usb251xb_resume(struct usb251xb *hub)
 {
-	struct i2c_client *client = to_i2c_client(dev);
-	struct usb251xb *hub = i2c_get_clientdata(client);
 	int err;
 
 	err = regulator_enable(hub->vdd);
@@ -719,7 +727,23 @@ static int usb251xb_resume(struct device *dev)
 	return usb251xb_connect(hub);
 }
 
-static DEFINE_SIMPLE_DEV_PM_OPS(usb251xb_pm_ops, usb251xb_suspend, usb251xb_resume);
+static int usb251xb_i2c_suspend(struct device *dev)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct usb251xb *hub = i2c_get_clientdata(client);
+
+	return usb251xb_suspend(hub);
+}
+
+static int usb251xb_i2c_resume(struct device *dev)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct usb251xb *hub = i2c_get_clientdata(client);
+
+	return usb251xb_resume(hub);
+}
+
+static DEFINE_SIMPLE_DEV_PM_OPS(usb251xb_i2c_pm_ops, usb251xb_i2c_suspend, usb251xb_i2c_resume);
 
 static const struct i2c_device_id usb251xb_id[] = {
 	{ "usb2422" },
@@ -739,13 +763,71 @@ static struct i2c_driver usb251xb_i2c_driver = {
 	.driver = {
 		.name = DRIVER_NAME,
 		.of_match_table = usb251xb_of_match,
-		.pm = pm_sleep_ptr(&usb251xb_pm_ops),
+		.pm = pm_sleep_ptr(&usb251xb_i2c_pm_ops),
 	},
 	.probe = usb251xb_i2c_probe,
 	.id_table = usb251xb_id,
 };
 
-module_i2c_driver(usb251xb_i2c_driver);
+static int usb251xb_plat_probe(struct platform_device *pdev)
+{
+	struct usb251xb *hub;
+
+	hub = devm_kzalloc(&pdev->dev, sizeof(*hub), GFP_KERNEL);
+	if (!hub)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, hub);
+	hub->dev = &pdev->dev;
+
+	return usb251xb_probe(hub);
+}
+
+static int usb251xb_plat_suspend(struct device *dev)
+{
+	return usb251xb_suspend(dev_get_drvdata(dev));
+}
+
+static int usb251xb_plat_resume(struct device *dev)
+{
+	return usb251xb_resume(dev_get_drvdata(dev));
+}
+
+static DEFINE_SIMPLE_DEV_PM_OPS(usb251xb_plat_pm_ops, usb251xb_plat_suspend, usb251xb_plat_resume);
+
+static struct platform_driver usb251xb_plat_driver = {
+	.driver = {
+		.name = DRIVER_NAME,
+		.of_match_table = usb251xb_of_match,
+		.pm = pm_sleep_ptr(&usb251xb_plat_pm_ops),
+	},
+	.probe		= usb251xb_plat_probe,
+};
+
+static int __init usb251xb_init(void)
+{
+	int err;
+
+	err = i2c_add_driver(&usb251xb_i2c_driver);
+	if (err)
+		return err;
+
+	err = platform_driver_register(&usb251xb_plat_driver);
+	if (err) {
+		i2c_del_driver(&usb251xb_i2c_driver);
+		return err;
+	}
+
+	return 0;
+}
+module_init(usb251xb_init);
+
+static void __exit usb251xb_exit(void)
+{
+	platform_driver_unregister(&usb251xb_plat_driver);
+	i2c_del_driver(&usb251xb_i2c_driver);
+}
+module_exit(usb251xb_exit);
 
 MODULE_AUTHOR("Richard Leitner <richard.leitner@skidata.com>");
 MODULE_DESCRIPTION("USB251x/xBi USB 2.0 Hub Controller Driver");
-- 
2.50.0


