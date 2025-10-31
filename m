Return-Path: <linux-kernel+bounces-880619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5997C2636C
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 17:50:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6B4D56170C
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 16:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C18B028CF5E;
	Fri, 31 Oct 2025 16:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="GaE4hFsG"
Received: from relay11.grserver.gr (relay11.grserver.gr [78.46.171.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04633232395;
	Fri, 31 Oct 2025 16:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.46.171.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761928622; cv=none; b=Z74kSeNLigh/f6SYl4494DVtmAn/nFzKMOcD16kAyzq8SDni5YPttqhbRaRGZxkk+VupJxBt4KALUfgFS7Gi6uR8R9kaMKiu//gsszE5LDtPMyouFccJ7yVV1PvCkMbJi4wkSDei1vmQrLBkJzAR5azUH9zkVWcILmQc9HCz6i4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761928622; c=relaxed/simple;
	bh=TK78dgmBHPfa2+zhWQMNxJ0NT173ZzSSI39b1zX1ZEc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b6ig9dErGwKpRTO9/ZH/ksLxvPBniUBLb0SPbG7yhwRMU/Gq/YZ9U8wml+PswjAeEBr4P8aN231fyCi5hcC6hCmk8ENgPsp6eTt/KwjSRIpOLCMV95nbM8OY5C0p62s/4ngqlrPBJPHBW32GN1Apg2uF1P8hL7INQLxzjPMg+YA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=GaE4hFsG; arc=none smtp.client-ip=78.46.171.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from relay11 (localhost.localdomain [127.0.0.1])
	by relay11.grserver.gr (Proxmox) with ESMTP id 069D6C61CC;
	Fri, 31 Oct 2025 18:36:56 +0200 (EET)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay11.grserver.gr (Proxmox) with ESMTPS id 2EE18C6187;
	Fri, 31 Oct 2025 18:36:55 +0200 (EET)
Received: from antheas-z13 (unknown [IPv6:2a05:f6c2:511b:0:8d8a:5967:d692:ea4e])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id 2AB05200C57;
	Fri, 31 Oct 2025 18:36:54 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1761928614;
	bh=9xbmwqw86szpYNRWeyB2pOlJShw5/Q14Vdztv1tqfZU=; h=From:To:Subject;
	b=GaE4hFsG+blfKOYRios2athEmGsJWpzhWFE8GteyAKCDphZP/ZyJAXw5ERoGbYoQG
	 8KjaOaZjh8ssCah/BkHxnxwGduaATjJe6bMbOiLXC+VaGSZXQaztKLhG7l3kL1SEGy
	 tnmg5v7axkfhwpTIwzy6R/Z/gxSCoyYrhbYNxEVw3iWTXZNZIOdvBBjHSPVpw7VW/g
	 p56EDl4GQ8b6QLigJ99Vawy4W3o71GOzV7in2/SUGAm6tXTxXMeHLHm4LVFueca482
	 cKaa6mO57q1xQgYj5DCbNgq4A0ft7HSRp4pHE+T/Lj/s2UuX3cC+cYkqBNDk2rFbjL
	 F+gno3EZnAgXA==
Authentication-Results: linux3247.grserver.gr;
	spf=pass (sender IP is 2a05:f6c2:511b:0:8d8a:5967:d692:ea4e) smtp.mailfrom=lkml@antheas.dev smtp.helo=antheas-z13
Received-SPF: pass (linux3247.grserver.gr: connection is authenticated)
From: Antheas Kapenekakis <lkml@antheas.dev>
To: platform-driver-x86@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	Hans de Goede <hansg@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Derek John Clark <derekjohn.clark@gmail.com>,
	=?UTF-8?q?Joaqu=C3=ADn=20Ignacio=20Aramend=C3=ADa?= <samsagax@gmail.com>,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Antheas Kapenekakis <lkml@antheas.dev>
Subject: [PATCH v3 1/6] platform/x86: ayaneo-ec: Add Ayaneo Embedded
 Controller platform driver
Date: Fri, 31 Oct 2025 17:36:46 +0100
Message-ID: <20251031163651.1465981-2-lkml@antheas.dev>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251031163651.1465981-1-lkml@antheas.dev>
References: <20251031163651.1465981-1-lkml@antheas.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: 
 <176192861479.3949040.16198203735017726164@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.3 at linux3247.grserver.gr
X-Virus-Status: Clean

Recent Ayaneo devices feature an ACPI mapped Embedded Controller (EC)
with standard addresses across models that provides access to fan
speed, fan control, battery charge limits, and controller power
controls. Introduce a new driver stub that will handle these driver
features.

Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
---
 MAINTAINERS                      |  6 +++
 drivers/platform/x86/Kconfig     |  9 ++++
 drivers/platform/x86/Makefile    |  3 ++
 drivers/platform/x86/ayaneo-ec.c | 90 ++++++++++++++++++++++++++++++++
 4 files changed, 108 insertions(+)
 create mode 100644 drivers/platform/x86/ayaneo-ec.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 545a4776795e..da9498d8cc89 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4187,6 +4187,12 @@ W:	https://ez.analog.com/linux-software-drivers
 F:	Documentation/devicetree/bindings/pwm/adi,axi-pwmgen.yaml
 F:	drivers/pwm/pwm-axi-pwmgen.c
 
+AYANEO PLATFORM EC DRIVER
+M:	Antheas Kapenekakis <lkml@antheas.dev>
+L:	platform-driver-x86@vger.kernel.org
+S:	Maintained
+F:	drivers/platform/x86/ayaneo-ec.c
+
 AZ6007 DVB DRIVER
 M:	Mauro Carvalho Chehab <mchehab@kernel.org>
 L:	linux-media@vger.kernel.org
diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 46e62feeda3c..ebe7d2ab8758 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -316,6 +316,15 @@ config ASUS_TF103C_DOCK
 	  If you have an Asus TF103C tablet say Y or M here, for a generic x86
 	  distro config say M here.
 
+config AYANEO_EC
+	tristate "Ayaneo EC platform control"
+	help
+	  Enables support for the platform EC of Ayaneo devices. This
+	  includes fan control, fan speed, charge limit, magic
+	  module detection, and controller power control.
+
+	  If you have an Ayaneo device, say Y or M here.
+
 config MERAKI_MX100
 	tristate "Cisco Meraki MX100 Platform Driver"
 	depends on GPIOLIB
diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
index c7db2a88c11a..274a685eb92d 100644
--- a/drivers/platform/x86/Makefile
+++ b/drivers/platform/x86/Makefile
@@ -39,6 +39,9 @@ obj-$(CONFIG_ASUS_TF103C_DOCK)	+= asus-tf103c-dock.o
 obj-$(CONFIG_EEEPC_LAPTOP)	+= eeepc-laptop.o
 obj-$(CONFIG_EEEPC_WMI)		+= eeepc-wmi.o
 
+# Ayaneo
+obj-$(CONFIG_AYANEO_EC)		+= ayaneo-ec.o
+
 # Cisco/Meraki
 obj-$(CONFIG_MERAKI_MX100)	+= meraki-mx100.o
 
diff --git a/drivers/platform/x86/ayaneo-ec.c b/drivers/platform/x86/ayaneo-ec.c
new file mode 100644
index 000000000000..2fe66c8a89f4
--- /dev/null
+++ b/drivers/platform/x86/ayaneo-ec.c
@@ -0,0 +1,90 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Platform driver for the Embedded Controller (EC) of Ayaneo devices. Handles
+ * hwmon (fan speed, fan control), battery charge limits, and magic module
+ * control (connected modules, controller disconnection).
+ *
+ * Copyright (C) 2025 Antheas Kapenekakis <lkml@antheas.dev>
+ */
+
+#include <linux/dmi.h>
+#include <linux/err.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+
+struct ayaneo_ec_quirk {
+};
+
+struct ayaneo_ec_platform_data {
+	struct platform_device *pdev;
+	struct ayaneo_ec_quirk *quirks;
+};
+
+static const struct ayaneo_ec_quirk quirk_ayaneo3 = {
+};
+
+static const struct dmi_system_id dmi_table[] = {
+	{
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "AYANEO"),
+			DMI_EXACT_MATCH(DMI_BOARD_NAME, "AYANEO 3"),
+		},
+		.driver_data = (void *)&quirk_ayaneo3,
+	},
+	{},
+};
+
+static int ayaneo_ec_probe(struct platform_device *pdev)
+{
+	const struct dmi_system_id *dmi_entry;
+	struct ayaneo_ec_platform_data *data;
+
+	dmi_entry = dmi_first_match(dmi_table);
+	if (!dmi_entry)
+		return -ENODEV;
+
+	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->pdev = pdev;
+	data->quirks = dmi_entry->driver_data;
+	platform_set_drvdata(pdev, data);
+
+	return 0;
+}
+
+static struct platform_driver ayaneo_platform_driver = {
+	.driver = {
+		.name = "ayaneo-ec",
+	},
+	.probe = ayaneo_ec_probe,
+};
+
+static struct platform_device *ayaneo_platform_device;
+
+static int __init ayaneo_ec_init(void)
+{
+	ayaneo_platform_device =
+		platform_create_bundle(&ayaneo_platform_driver,
+				       ayaneo_ec_probe, NULL, 0, NULL, 0);
+
+	return PTR_ERR_OR_ZERO(ayaneo_platform_device);
+}
+
+static void __exit ayaneo_ec_exit(void)
+{
+	platform_device_unregister(ayaneo_platform_device);
+	platform_driver_unregister(&ayaneo_platform_driver);
+}
+
+MODULE_DEVICE_TABLE(dmi, dmi_table);
+
+module_init(ayaneo_ec_init);
+module_exit(ayaneo_ec_exit);
+
+MODULE_AUTHOR("Antheas Kapenekakis <lkml@antheas.dev>");
+MODULE_DESCRIPTION("Ayaneo Embedded Controller (EC) platform features");
+MODULE_LICENSE("GPL");
-- 
2.51.1



