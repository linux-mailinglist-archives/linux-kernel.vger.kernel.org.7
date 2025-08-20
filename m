Return-Path: <linux-kernel+bounces-778169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF330B2E226
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 18:19:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE81C188A2DB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 16:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C7FC326D65;
	Wed, 20 Aug 2025 16:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="QvwvBfuF"
Received: from relay12.grserver.gr (relay12.grserver.gr [88.99.38.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71B4242D72;
	Wed, 20 Aug 2025 16:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=88.99.38.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755706594; cv=none; b=hNxOq7QjSfJv/OcL1YY/9wMj6Kee2UNA9hsr+E2XdfIp04Njz+T6z0GlWWHimxALtcHTUmgz1LvgwlqUHtgrx63f1SvIXZPY0jMhMX1Ery7I0R4286tMdYEymOsNz+R5znT/vIqZtVgYkz/cHONEl7GT6PGdjf2xjBwQou6Ux0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755706594; c=relaxed/simple;
	bh=cTLPsHBn531ojToU3+KN2htdYGLw8ZmtzCz0FHCb8js=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pwefPn86hMwsm67WDvCXUPDidvl4CJnS4YLfpyEIYTevMtlVSZRa8MhnaNnuBCwCVHoHEq+Sg25gJYV8hQvJedEMmx9EhIpP2u4zj5DUYdh3M3xtoj9C6KcYljF3YTvNbTXE9l7ZCUkLJeKrHUuZIFC9Ct1MtzyLO8kxN6NLgGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=QvwvBfuF; arc=none smtp.client-ip=88.99.38.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from relay12 (localhost [127.0.0.1])
	by relay12.grserver.gr (Proxmox) with ESMTP id C54DFBDD12;
	Wed, 20 Aug 2025 19:06:32 +0300 (EEST)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay12.grserver.gr (Proxmox) with ESMTPS id E4AA6BDCB0;
	Wed, 20 Aug 2025 19:06:31 +0300 (EEST)
Received: from antheas-z13 (unknown [IPv6:2a05:f6c2:511b:0:7200:c86a:8976:4786])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id 040F3205624;
	Wed, 20 Aug 2025 19:06:30 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1755705991;
	bh=vQOykRQ/Qv/YWm2j41fZECGX/uzOVIyRStBZkJSOI2Q=; h=From:To:Subject;
	b=QvwvBfuFt6OIjGx9jIbXcic5icr7Ds0DXriEfkOAbjMjGdV0Mw5BxgLygxqs6shUv
	 TLrgWBls/8FeOEgq47ic8s4n3ihhpoT6C+ZzN33kvZt8lK+Dir+Vma8Kj5RRHumuUq
	 psMWr8dwypAqiaAm2JzvvVqlvwuWykK04D3tIEBkEcsZdfMjovRrSvVQNkOZh4nQ9J
	 oCIvxPkcNfRWOLMo7jr8dVO079fRXFEJ+9n7qx4W7Qqh4NSqHKAa5ZbjkaydNfzjwH
	 JKoV3stq1w9N/7+/Qjwx4kjEvmlo4o9xQbLjjFbUNUA4xCi/7mWOThbcAORtDU/POS
	 N31EknXntkPWQ==
Authentication-Results: linux3247.grserver.gr;
	spf=pass (sender IP is 2a05:f6c2:511b:0:7200:c86a:8976:4786) smtp.mailfrom=lkml@antheas.dev smtp.helo=antheas-z13
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
Subject: [PATCH v1 1/5] platform/x86: ayaneo-ec: Add Ayaneo Embedded
 Controller platform driver
Date: Wed, 20 Aug 2025 18:06:24 +0200
Message-ID: <20250820160628.99678-2-lkml@antheas.dev>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250820160628.99678-1-lkml@antheas.dev>
References: <20250820160628.99678-1-lkml@antheas.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: 
 <175570599153.2162638.11994229128294182856@linux3247.grserver.gr>
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
 drivers/platform/x86/Kconfig     | 10 ++++
 drivers/platform/x86/Makefile    |  3 ++
 drivers/platform/x86/ayaneo-ec.c | 89 ++++++++++++++++++++++++++++++++
 4 files changed, 108 insertions(+)
 create mode 100644 drivers/platform/x86/ayaneo-ec.c

diff --git a/MAINTAINERS b/MAINTAINERS
index daf520a13bdf..7afa7b8a3494 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4130,6 +4130,12 @@ W:	https://ez.analog.com/linux-software-drivers
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
index 6d238e120dce..6d4a33791cc1 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -304,6 +304,16 @@ config ASUS_TF103C_DOCK
 	  If you have an Asus TF103C tablet say Y or M here, for a generic x86
 	  distro config say M here.
 
+config AYANEO_EC
+	tristate "Ayaneo EC platform control"
+	depends on X86
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
index a0c5848513e3..f310e1233974 100644
--- a/drivers/platform/x86/Makefile
+++ b/drivers/platform/x86/Makefile
@@ -38,6 +38,9 @@ obj-$(CONFIG_ASUS_TF103C_DOCK)	+= asus-tf103c-dock.o
 obj-$(CONFIG_EEEPC_LAPTOP)	+= eeepc-laptop.o
 obj-$(CONFIG_EEEPC_WMI)		+= eeepc-wmi.o
 
+# Ayaneo
+obj-$(CONFIG_AYANEO_EC)		+= ayaneo-ec.o
+
 # Cisco/Meraki
 obj-$(CONFIG_MERAKI_MX100)	+= meraki-mx100.o
 
diff --git a/drivers/platform/x86/ayaneo-ec.c b/drivers/platform/x86/ayaneo-ec.c
new file mode 100644
index 000000000000..90b86527ab0d
--- /dev/null
+++ b/drivers/platform/x86/ayaneo-ec.c
@@ -0,0 +1,89 @@
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
+static const struct ayaneo_ec_quirk ayaneo3 = {
+};
+
+static const struct dmi_system_id dmi_table[] = {
+	{
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "AYANEO"),
+			DMI_EXACT_MATCH(DMI_BOARD_NAME, "AYANEO 3"),
+		},
+		.driver_data = (void *)&ayaneo3,
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
2.50.1



