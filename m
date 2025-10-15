Return-Path: <linux-kernel+bounces-854078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EAB4BDD7D9
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 10:47:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 43FB64F9618
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 08:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64F56318135;
	Wed, 15 Oct 2025 08:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="Cfrv/KeQ"
Received: from relay10.grserver.gr (relay10.grserver.gr [37.27.248.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E08931691A;
	Wed, 15 Oct 2025 08:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.27.248.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760518002; cv=none; b=Hj17Yo9w16OVofg976jfxIlJsOMEXJyAe9atyX0pluRgkiY6X7UE5/Scsm+PW52+nzsTOtwltht3vssO8qC6qUhb8d40egI7caDXKLblibJLRB5vrfZzoFKyoxN7YmXEJG881YqeW64AQEF0yesADwEw306gjEzSMrDST69i/jM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760518002; c=relaxed/simple;
	bh=AvrVZvSdRrZLcX5vLWm9yLyy/bvVwF/8zg9BsIUzRw8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B5slFlBP8nV3RNgJ++NOSwesWc5HN2qqmVoZG5ornXrhVMyJiuwM1j09bd9m5Ox0L/RI6X/f4CN6JDcdEfgPXid+yhPij4ABTihiX9bNkzXNKIuwQqkTlNKmvOikocqwBEc5GSv7EgqrYGFq086CyZWF6LE6L7cVzVyRLQ88R14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=Cfrv/KeQ; arc=none smtp.client-ip=37.27.248.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from relay10 (localhost.localdomain [127.0.0.1])
	by relay10.grserver.gr (Proxmox) with ESMTP id E189441D5A;
	Wed, 15 Oct 2025 11:46:32 +0300 (EEST)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay10.grserver.gr (Proxmox) with ESMTPS id D28E4426AF;
	Wed, 15 Oct 2025 11:46:31 +0300 (EEST)
Received: from antheas-z13 (x5996a8de.customers.hiper-net.dk [89.150.168.222])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id 5F49A200A8C;
	Wed, 15 Oct 2025 11:46:29 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1760517991;
	bh=UHPAwJsbURDeuXyaK1kwN3As3IlCJrnZ/5+1mgpUMTw=; h=From:To:Subject;
	b=Cfrv/KeQUWVufHZXfpeMbE/QcNWJVOJO4ctoU2UOvS4cS7QSop122xtslpRS6o5OB
	 /Rw+kdO9UXXvmzANAVVSfGRvGAyz5GNNbX8zlGPR/FXGyiNiuXVhm5S1duJskbsI+Y
	 dqNYyeaVqgYBou98+puvQN2M+Fbz2K22Hli22sfMQlmpWG2IVe5N+JDmEh4Kzeh0yi
	 SDZ8ZVzIjUcEQH7ykh7L2uoWqXc71JX5xqOWF1YjcEkKjN19X+MI2QQOeLlyUKiQNo
	 Y9Boy49MEgxThhtZbUpgHJn6N1ZgjiglwVPER4u1dHx05mWGNyat3iNLhjDXYXG7Jy
	 lcg1IWTRlNlfA==
Authentication-Results: linux3247.grserver.gr;
	spf=pass (sender IP is 89.150.168.222) smtp.mailfrom=lkml@antheas.dev smtp.helo=antheas-z13
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
Subject: [PATCH v2 1/6] platform/x86: ayaneo-ec: Add Ayaneo Embedded
 Controller platform driver
Date: Wed, 15 Oct 2025 10:44:09 +0200
Message-ID: <20251015084414.1391595-2-lkml@antheas.dev>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251015084414.1391595-1-lkml@antheas.dev>
References: <20251015084414.1391595-1-lkml@antheas.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: 
 <176051799135.920817.6557791755054051739@linux3247.grserver.gr>
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
index 46126ce2f968..8c4d0c26ca77 100644
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
index 46e62feeda3c..ff2678927696 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -316,6 +316,16 @@ config ASUS_TF103C_DOCK
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
2.51.0



