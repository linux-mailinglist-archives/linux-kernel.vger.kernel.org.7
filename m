Return-Path: <linux-kernel+bounces-812814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCE3FB53D0D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 22:23:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89B51488229
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 20:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E8A42777EA;
	Thu, 11 Sep 2025 20:22:59 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389D2274666
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 20:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757622179; cv=none; b=nEwdle+tbvW86PyOdCxqyhxDwctsusnNhQ6FZPkAPHYBwDfSsTsQhljhjrEBp6cX7WTHAvBTduq6/A//0HHQ25m6rWrde4xgq3zalq94LQMh5Re5gtRNj/1bqpEl4yq3F7x8A37wZ7SeW5qgUU/3SvGg4wkg+1+ecSZ71FlligM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757622179; c=relaxed/simple;
	bh=mqB2Y48gPtHTzfdJ6YtGV87Inzqp8PZP5LW7ZF1aqCY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AAjhAnoKs+kUY0U5fFUjkcAxFfw0MBRxi0O+SkNAEswgP/xUhY+fd1VqGOtmpJd6ikIWoHTPhdox61MkGA0Sn/DfEyKM23aAg4ty89s2iC81swI4HiC7mcFO9gqOKsAEf4YGjeOPf8d7mAJpNollCfRO6brVIVg19DEMRYA9p/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from dude02.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::28])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <m.felsch@pengutronix.de>)
	id 1uwnog-0005yg-L6; Thu, 11 Sep 2025 22:22:50 +0200
From: Marco Felsch <m.felsch@pengutronix.de>
Date: Thu, 11 Sep 2025 22:22:43 +0200
Subject: [PATCH v4 2/5] usb: hub: add infrastructure to pass onboard_dev
 port features
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250911-v6-16-topic-usb-onboard-dev-v4-2-1af288125d74@pengutronix.de>
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

On board devices may require special handling for en-/disable port
features due to PCB design decisions e.g. enable/disable the VBUS power
on the port via a host controlled regulator or GPIO.

This commit adds the necessary infrastructure to prepare the common code
base for such use-cases.

Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
---
 drivers/usb/core/hub.c | 55 ++++++++++++++++++++++++++++++++++++++++++++++++--
 drivers/usb/core/hub.h |  2 ++
 include/linux/usb.h    |  3 +++
 3 files changed, 58 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index 256fe8c86828d51c33442345acdb7f3fe80a98ce..50ae500e2ad3711996609fc84806803449a5bf16 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -457,9 +457,19 @@ static int clear_hub_feature(struct usb_device *hdev, int feature)
  */
 int usb_clear_port_feature(struct usb_device *hdev, int port1, int feature)
 {
-	return usb_control_msg(hdev, usb_sndctrlpipe(hdev, 0),
+	struct usb_hub *hub = usb_hub_to_struct_hub(hdev);
+	int ret;
+
+	ret = usb_control_msg(hdev, usb_sndctrlpipe(hdev, 0),
 		USB_REQ_CLEAR_FEATURE, USB_RT_PORT, feature, port1,
 		NULL, 0, 1000);
+	if (ret)
+		return ret;
+
+	if (hub->onboard_hub_clear_port_feature)
+		ret = hub->onboard_hub_clear_port_feature(hdev, feature, port1);
+
+	return ret;
 }
 
 /*
@@ -467,9 +477,19 @@ int usb_clear_port_feature(struct usb_device *hdev, int port1, int feature)
  */
 static int set_port_feature(struct usb_device *hdev, int port1, int feature)
 {
-	return usb_control_msg(hdev, usb_sndctrlpipe(hdev, 0),
+	struct usb_hub *hub = usb_hub_to_struct_hub(hdev);
+	int ret;
+
+	ret = usb_control_msg(hdev, usb_sndctrlpipe(hdev, 0),
 		USB_REQ_SET_FEATURE, USB_RT_PORT, feature, port1,
 		NULL, 0, 1000);
+	if (ret)
+		return ret;
+
+	if (hub->onboard_hub_set_port_feature)
+		ret = hub->onboard_hub_set_port_feature(hdev, feature, port1);
+
+	return ret;
 }
 
 static char *to_led_name(int selector)
@@ -6544,6 +6564,37 @@ void usb_hub_adjust_deviceremovable(struct usb_device *hdev,
 	}
 }
 
+/**
+ * usb_hub_register_port_feature_hooks - Register port set/get feature hooks
+ * @hdev: USB device belonging to the usb hub
+ * @set_port_feature: set_feature hook which gets called by the hub core
+ * @clear_port_feature: clear_feature hook which gets called by the hub core
+ *
+ * Register set/get_port_feature hooks for a onboard_dev hub.
+ */
+void usb_hub_register_port_feature_hooks(struct usb_device *hdev,
+		int (*set_port_feature)(struct usb_device *, int, int),
+		int (*clear_port_feature)(struct usb_device *, int, int))
+{
+	struct usb_hub *hub = usb_hub_to_struct_hub(hdev);
+
+	if (WARN_ON_ONCE(is_root_hub(hdev) || !hub))
+		return;
+
+	if (set_port_feature)
+		hub->onboard_hub_set_port_feature = set_port_feature;
+	if (clear_port_feature)
+		hub->onboard_hub_clear_port_feature = clear_port_feature;
+
+	/*
+	 * Keep it simple for now. Just check the power state and re-sync it
+	 * after adding the hooks since the onboard-dev may do some additional
+	 * logic e.g. controlling regulators.
+	 */
+	hub_power_on(hub, false);
+}
+EXPORT_SYMBOL_GPL(usb_hub_register_port_feature_hooks);
+
 #ifdef CONFIG_ACPI
 /**
  * usb_get_hub_port_acpi_handle - Get the usb port's acpi handle
diff --git a/drivers/usb/core/hub.h b/drivers/usb/core/hub.h
index 297adf2c6078809ca582104f228e5222c464f999..31800b5922ba896dc7cac5f9e3ed1a77e7c5a801 100644
--- a/drivers/usb/core/hub.h
+++ b/drivers/usb/core/hub.h
@@ -76,6 +76,8 @@ struct usb_hub {
 	struct timer_list	irq_urb_retry;
 	struct usb_port		**ports;
 	struct list_head        onboard_devs;
+	int (*onboard_hub_set_port_feature)(struct usb_device *udev, int feature, int port1);
+	int (*onboard_hub_clear_port_feature)(struct usb_device *udev, int feature, int port1);
 };
 
 /**
diff --git a/include/linux/usb.h b/include/linux/usb.h
index 92c752f5446ff37ef09b9296f7711e1a622680ea..1415a826953ac5488619073e2f659188f7988d6e 100644
--- a/include/linux/usb.h
+++ b/include/linux/usb.h
@@ -928,6 +928,9 @@ int usb_hub_claim_port(struct usb_device *hdev, unsigned port1,
 		struct usb_dev_state *owner);
 int usb_hub_release_port(struct usb_device *hdev, unsigned port1,
 		struct usb_dev_state *owner);
+void usb_hub_register_port_feature_hooks(struct usb_device *hdev,
+		int (*set_port_feature)(struct usb_device *, int, int),
+		int (*clear_port_feature)(struct usb_device *, int, int));
 
 /**
  * usb_make_path - returns stable device path in the usb tree

-- 
2.47.3


