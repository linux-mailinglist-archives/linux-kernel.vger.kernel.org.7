Return-Path: <linux-kernel+bounces-812815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F944B53D0E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 22:23:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B24D3567E1C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 20:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B81A3277CB3;
	Thu, 11 Sep 2025 20:22:59 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B887274669
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 20:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757622179; cv=none; b=Arujg2rt/3/JvVdZoMJ9inzkGJKCZRs3iHGdnhxAciB8dcqQPmxeRrbHfqShuGrYPurIeFxVyfPKW7o9ORPi5+WcE9322NBpaeMV5JID2lXj8m+H/Wq1kiG1Xt5X9QxUV9cTzVFS6Q8E7gCD8Ke0Q1m+k6C/UAT0gvIpVBuvOSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757622179; c=relaxed/simple;
	bh=t3Qxwy3AnC9M50lFGea/MNR0jGvER4KJxcZ+31kFsDs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FXpiRafYw95PiX/dI89arcRu3vPNBuVd4yR1a66hJBh1CVKNln/x78jX4aOxI95pnEzk0cFUsxLZaCt/e7pBIh6WX6Z9fd4xaiaZKIITCzIgTO55oZrkfkHdx3TXeUhevowDFYuK8eplAc6t9rWq7v1Dm+6EhkkyT/UHPvFpeVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from dude02.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::28])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <m.felsch@pengutronix.de>)
	id 1uwnog-0005yg-QY; Thu, 11 Sep 2025 22:22:50 +0200
From: Marco Felsch <m.felsch@pengutronix.de>
Date: Thu, 11 Sep 2025 22:22:46 +0200
Subject: [PATCH v4 5/5] usb: misc: onboard_dev: add hub downstream port
 host vbus-supply handling
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250911-v6-16-topic-usb-onboard-dev-v4-5-1af288125d74@pengutronix.de>
References: <20250911-v6-16-topic-usb-onboard-dev-v4-0-1af288125d74@pengutronix.de>
In-Reply-To: <20250911-v6-16-topic-usb-onboard-dev-v4-0-1af288125d74@pengutronix.de>
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

Some PCB designs don't use the dedicated USB hub port power GPIOs.
Instead they route the signals to the host. So the host is in charge to
power the VBUS supplies.

As first step the USB hub OF information is parsed and possible optional
vbus-supply regulators are added. This is done during the platform
driver probe() function.

Afterwards, during the usb driver probe() function and in case this is
an USB hub, the set/clear features hooks are registered via the new
usb_hub_register_port_feature_hooks().

After this registration all generic usb hub set/clear features calls are
passed to the onboard_dev driver too. This allows the driver to
en-/disable the regulators.

Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
---
 drivers/usb/misc/onboard_usb_dev.c | 117 +++++++++++++++++++++++++++++++++++++
 1 file changed, 117 insertions(+)

diff --git a/drivers/usb/misc/onboard_usb_dev.c b/drivers/usb/misc/onboard_usb_dev.c
index 5b481876af1b2c10ce625fcf0fb8bfbe8905aa8c..1ceea75d30d320e5d2203c768b9641876ebd37ad 100644
--- a/drivers/usb/misc/onboard_usb_dev.c
+++ b/drivers/usb/misc/onboard_usb_dev.c
@@ -54,6 +54,12 @@ struct usbdev_node {
 	struct list_head list;
 };
 
+struct onboard_dev_port_regulator {
+	struct regulator *vbus_supply;
+	unsigned int port;
+	struct list_head list;
+};
+
 struct onboard_dev {
 	struct regulator_bulk_data supplies[MAX_SUPPLIES];
 	struct device *dev;
@@ -65,6 +71,7 @@ struct onboard_dev {
 	struct list_head udev_list;
 	struct mutex lock;
 	struct clk *clk;
+	struct list_head ext_vbus_supplies;
 };
 
 static int onboard_dev_get_regulators(struct onboard_dev *onboard_dev)
@@ -226,6 +233,71 @@ static int onboard_dev_add_usbdev(struct onboard_dev *onboard_dev,
 	return err;
 }
 
+static int onboard_dev_port_power(struct onboard_dev *onboard_dev, int port1,
+				  bool enable)
+{
+	struct onboard_dev_port_regulator *regulator;
+	struct regulator *vbus_supply = NULL;
+
+	list_for_each_entry(regulator, &onboard_dev->ext_vbus_supplies, list) {
+		if (regulator->port == port1) {
+			vbus_supply = regulator->vbus_supply;
+			break;
+		}
+	}
+
+	/* External supplies are optional, return no error */
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
+
+	if (!onboard_dev->pdata->is_hub)
+		return 0;
+
+	INIT_LIST_HEAD(&onboard_dev->ext_vbus_supplies);
+
+	for_each_child_of_node_scoped(dev->of_node, child) {
+		struct onboard_dev_port_regulator *regulator;
+		struct regulator *port_supply;
+		u32 port;
+
+		port_supply = devm_of_regulator_get_optional(dev, child, "vbus");
+		if (IS_ERR(port_supply)) {
+			if (PTR_ERR(port_supply) == -ENODEV)
+				continue;
+			return PTR_ERR(port_supply);
+		}
+
+		/*
+		 * The VBUS of this downstream port is controlled by a host
+		 * managed regulator
+		 */
+		if (of_property_read_u32(child, "reg", &port)) {
+			dev_err(dev, "Failed to parse USB device reg property\n");
+			return -EINVAL;
+		}
+
+		regulator = devm_kzalloc(dev, sizeof(*regulator), GFP_KERNEL);
+		if (!regulator)
+			return -ENOMEM;
+
+		regulator->vbus_supply = port_supply;
+		regulator->port = port;
+		list_add(&regulator->list, &onboard_dev->ext_vbus_supplies);
+	}
+
+	return 0;
+}
+
 static void onboard_dev_remove_usbdev(struct onboard_dev *onboard_dev,
 				      const struct usb_device *udev)
 {
@@ -460,6 +532,10 @@ static int onboard_dev_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, PTR_ERR(onboard_dev->reset_gpio),
 				     "failed to get reset GPIO\n");
 
+	err = onboard_dev_add_ext_vbus_supplies(onboard_dev);
+	if (err)
+		return dev_err_probe(dev, err, "failed to parse port vbus supplies\n");
+
 	mutex_init(&onboard_dev->lock);
 	INIT_LIST_HEAD(&onboard_dev->udev_list);
 
@@ -573,6 +649,44 @@ static struct platform_driver onboard_dev_driver = {
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
@@ -632,6 +746,9 @@ static int onboard_dev_usbdev_probe(struct usb_device *udev)
 
 	dev_set_drvdata(dev, onboard_dev);
 
+	if (onboard_dev->pdata->is_hub)
+		onboard_dev_register_hub_hooks(udev);
+
 	err = onboard_dev_add_usbdev(onboard_dev, udev);
 	if (err)
 		return err;

-- 
2.47.3


