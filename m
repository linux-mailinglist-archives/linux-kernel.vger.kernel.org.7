Return-Path: <linux-kernel+bounces-780303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 576D1B30035
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 18:38:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C96F1CE3896
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 16:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E75992E11DD;
	Thu, 21 Aug 2025 16:32:09 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA932D46CB
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 16:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755793929; cv=none; b=GfY2FxWGQek/vPidI5vOR4xOOdtx2LkHY0lWytMrnErwyRSleiT1LusWEWnAi9eU0yvesDqYjyicScMFzdLTRH5ko9LDKJBXhxbaQEjr/w9kJwFRQ/Ryn6bOY37DdJVyd6wdtG9m/yD4lkHvKB6kM/hdpjt1pDRnzHC3z5hAA04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755793929; c=relaxed/simple;
	bh=ra9ISEyMXDs2zybscuSanrfQzAoOc8Qx/WwdPW0DGuw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=U933mmwmU8s9Q0i24olH3mivCsFX3ShOzV6Ej2Fd9h6k8YHzf4rIt7SnR+ng8Dgbe2NHfdNjspBO9p5WUp294rf7Pplkr3zAJq4meZVWfDe6y2Jjhc0OGGISwYjXhCxy33mkHy5RePg8iqBYGVsBMpDf/5RTz0b/+utA9iKcGVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from dude02.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::28])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <m.felsch@pengutronix.de>)
	id 1up8Cj-0004O7-Q8; Thu, 21 Aug 2025 18:31:57 +0200
From: Marco Felsch <m.felsch@pengutronix.de>
Date: Thu, 21 Aug 2025 18:31:58 +0200
Subject: [PATCH v3 4/4] usb: misc: onboard_dev: add ext-vbus-supply
 handling
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250821-v6-16-topic-usb-onboard-dev-v3-4-6d2b38a5d818@pengutronix.de>
References: <20250821-v6-16-topic-usb-onboard-dev-v3-0-6d2b38a5d818@pengutronix.de>
In-Reply-To: <20250821-v6-16-topic-usb-onboard-dev-v3-0-6d2b38a5d818@pengutronix.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Fabio Estevam <festevam@gmail.com>, 
 Matthias Kaehlcke <mka@chromium.org>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, kernel@pengutronix.de, 
 Marco Felsch <m.felsch@pengutronix.de>
X-Mailer: b4 0.14.2
X-SA-Exim-Connect-IP: 2a0a:edc0:0:1101:1d::28
X-SA-Exim-Mail-From: m.felsch@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Add support to power the port VBUS via host controlled regulators since
some embedded hub PCB designs don't connect the dedicated USB hub port
power GPIOs accordingly.

To support the above use-case this commits adds support to parse the OF
information and setup the regulators accordingly within the platform
driver part. Furthermore the usb driver registers the set/clear features
hooks via the new usb_hub_register_port_feature_hooks() if the
onboard_dev is a hub. Afterwards all generic hub handling is passed to
the onboard_dev driver too which allows us to control the regulators.

At the moment this feature is limited to the following hubs:
  - usb424,2412
  - usb424,2414
  - usb424,2417

Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
---
 drivers/usb/misc/onboard_usb_dev.c | 95 ++++++++++++++++++++++++++++++++++++++
 drivers/usb/misc/onboard_usb_dev.h |  3 ++
 2 files changed, 98 insertions(+)

diff --git a/drivers/usb/misc/onboard_usb_dev.c b/drivers/usb/misc/onboard_usb_dev.c
index 5b481876af1b2c10ce625fcf0fb8bfbe8905aa8c..bcb227c8dca2cecb3e49abfd41dcbe4e586d7d07 100644
--- a/drivers/usb/misc/onboard_usb_dev.c
+++ b/drivers/usb/misc/onboard_usb_dev.c
@@ -49,6 +49,8 @@ static DECLARE_WORK(attach_usb_driver_work, onboard_dev_attach_usb_driver);
 
 /************************** Platform driver **************************/
 
+#define MAX_DOWNSTREAM_PORTS	7
+
 struct usbdev_node {
 	struct usb_device *udev;
 	struct list_head list;
@@ -65,6 +67,7 @@ struct onboard_dev {
 	struct list_head udev_list;
 	struct mutex lock;
 	struct clk *clk;
+	struct regulator *ext_vbus_supplies[MAX_DOWNSTREAM_PORTS];
 };
 
 static int onboard_dev_get_regulators(struct onboard_dev *onboard_dev)
@@ -226,6 +229,53 @@ static int onboard_dev_add_usbdev(struct onboard_dev *onboard_dev,
 	return err;
 }
 
+static int onboard_dev_port_power(struct onboard_dev *onboard_dev, int port1,
+				  bool enable)
+{
+	struct regulator *vbus_supply;
+	unsigned int port = port1 - 1;
+
+	if (WARN_ON(port >= MAX_DOWNSTREAM_PORTS))
+		return -EINVAL;
+
+	vbus_supply = onboard_dev->ext_vbus_supplies[port];
+
+	/* External supplies are optional */
+	if (!vbus_supply)
+		return 0;
+
+	if (enable)
+		return regulator_enable(vbus_supply);
+
+	return regulator_disable(vbus_supply);
+}
+
+static int onboard_dev_add_ext_vbus_supplies(struct onboard_dev *onboard_dev)
+{
+	struct device *dev = onboard_dev->dev;
+	unsigned int i;
+
+	if (!onboard_dev->pdata->support_ext_vbus_supplies)
+		return 0;
+
+	for (i = 0; i < MAX_DOWNSTREAM_PORTS; i++) {
+		char supply_name[] = "portX-vbus";
+		struct regulator *reg;
+
+		sprintf(supply_name, "port%u-vbus", i + 1);
+		reg = devm_regulator_get_optional(dev, supply_name);
+		if (!IS_ERR(reg)) {
+			onboard_dev->ext_vbus_supplies[i] = reg;
+		} else {
+			if (PTR_ERR(reg) != -ENODEV)
+				return dev_err_probe(dev, PTR_ERR(reg),
+						     "failed to get %s-supply\n", supply_name);
+		}
+	}
+
+	return 0;
+}
+
 static void onboard_dev_remove_usbdev(struct onboard_dev *onboard_dev,
 				      const struct usb_device *udev)
 {
@@ -460,6 +510,10 @@ static int onboard_dev_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, PTR_ERR(onboard_dev->reset_gpio),
 				     "failed to get reset GPIO\n");
 
+	err = onboard_dev_add_ext_vbus_supplies(onboard_dev);
+	if (err)
+		return err;
+
 	mutex_init(&onboard_dev->lock);
 	INIT_LIST_HEAD(&onboard_dev->udev_list);
 
@@ -573,6 +627,44 @@ static struct platform_driver onboard_dev_driver = {
 #define VENDOR_ID_VIA		0x2109
 #define VENDOR_ID_XMOS		0x20B1
 
+static int onboard_dev_port_feature(struct usb_device *udev, bool set,
+				    int feature, int port1)
+{
+	struct device *dev = &udev->dev;
+	struct onboard_dev *onboard_dev = dev_get_drvdata(dev);
+
+	/*
+	 * Check usb_hub_register_port_feature_hooks() if you want to extent
+	 * the list of handled features. At the moment only power is synced
+	 * after adding the hook.
+	 */
+	switch (feature) {
+	case USB_PORT_FEAT_POWER:
+		return onboard_dev_port_power(onboard_dev, port1, set);
+	default:
+		return 0;
+	}
+}
+
+static int
+onboard_dev_set_port_feature(struct usb_device *udev, int feature, int port1)
+{
+	return onboard_dev_port_feature(udev, true, feature, port1);
+}
+
+static int
+onboard_dev_clear_port_feature(struct usb_device *udev, int feature, int port1)
+{
+	return onboard_dev_port_feature(udev, false, feature, port1);
+}
+
+static void
+onboard_dev_register_hub_hooks(struct usb_device *udev)
+{
+	usb_hub_register_port_feature_hooks(udev, onboard_dev_set_port_feature,
+					    onboard_dev_clear_port_feature);
+}
+
 /*
  * Returns the onboard_dev platform device that is associated with the USB
  * device passed as parameter.
@@ -632,6 +724,9 @@ static int onboard_dev_usbdev_probe(struct usb_device *udev)
 
 	dev_set_drvdata(dev, onboard_dev);
 
+	if (onboard_dev->pdata->is_hub)
+		onboard_dev_register_hub_hooks(udev);
+
 	err = onboard_dev_add_usbdev(onboard_dev, udev);
 	if (err)
 		return err;
diff --git a/drivers/usb/misc/onboard_usb_dev.h b/drivers/usb/misc/onboard_usb_dev.h
index e017b8e22f936be66da73789abb4f620e6af4d6a..75aa2ab9297e272a98de15270d3595d7df03fb9c 100644
--- a/drivers/usb/misc/onboard_usb_dev.h
+++ b/drivers/usb/misc/onboard_usb_dev.h
@@ -14,6 +14,7 @@ struct onboard_dev_pdata {
 	unsigned int num_supplies;	/* number of supplies */
 	const char * const supply_names[MAX_SUPPLIES];
 	bool is_hub;
+	bool support_ext_vbus_supplies;
 };
 
 static const struct onboard_dev_pdata microchip_usb424_data = {
@@ -21,6 +22,7 @@ static const struct onboard_dev_pdata microchip_usb424_data = {
 	.num_supplies = 1,
 	.supply_names = { "vdd" },
 	.is_hub = true,
+	.support_ext_vbus_supplies = true,
 };
 
 static const struct onboard_dev_pdata microchip_usb2514_data = {
@@ -28,6 +30,7 @@ static const struct onboard_dev_pdata microchip_usb2514_data = {
 	.num_supplies = 2,
 	.supply_names = { "vdd", "vdda" },
 	.is_hub = true,
+	.support_ext_vbus_supplies = true,
 };
 
 static const struct onboard_dev_pdata microchip_usb5744_data = {

-- 
2.39.5


