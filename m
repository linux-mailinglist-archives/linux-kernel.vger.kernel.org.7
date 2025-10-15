Return-Path: <linux-kernel+bounces-854079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F313BDD7E8
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 10:47:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74F48189C969
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 08:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64FE4318136;
	Wed, 15 Oct 2025 08:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="QeWYWTkb"
Received: from relay11.grserver.gr (relay11.grserver.gr [78.46.171.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E9D31690D;
	Wed, 15 Oct 2025 08:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.46.171.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760518002; cv=none; b=Hu2baEX+PCIpI5KgHC0B1FpYiDIdFeEVFk3xRj1LQ0Fl9EX09r7mbj9Sei0UlHzVWCMoMsLCO99qTM0E7okvRgIinzMLx4w69xHi4kFOAx7X6VJK/8vRlR5qLCosnmH2XPwCVQ46y75F8N9Ru7LXTVylfeB/zLnsXf4W0kqJUe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760518002; c=relaxed/simple;
	bh=CG81GUh4GUO5ZQxcFMuSE3z1Q+jDnttN5+TYKdFoxEE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CEfjXG1I3GnQ35rcVWkoKt5F+XvpWYcZhaQv2GNEcHM98K/pYjeObFNDCWcITIP29fhGaC07cqKH3fWTB47mNXDWmAvvhU0/bGXqO2wnZHTgysK0VgMkvDaVwO6CSxbU4z93cDTpgb+Ei2p5h2LBOk7mH0uEv5LWJDjH2Q3Nrzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=QeWYWTkb; arc=none smtp.client-ip=78.46.171.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from relay11 (localhost.localdomain [127.0.0.1])
	by relay11.grserver.gr (Proxmox) with ESMTP id 7505BC5546;
	Wed, 15 Oct 2025 11:46:38 +0300 (EEST)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay11.grserver.gr (Proxmox) with ESMTPS id BFA02C56B9;
	Wed, 15 Oct 2025 11:46:37 +0300 (EEST)
Received: from antheas-z13 (x5996a8de.customers.hiper-net.dk [89.150.168.222])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id D3ED4200A81;
	Wed, 15 Oct 2025 11:46:35 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1760517997;
	bh=cQwxQxc6TruRuBos9LalVuLShmHa9nKoYG/4GYxYSlk=; h=From:To:Subject;
	b=QeWYWTkbAUaBeEzcZWCuUOxXkSgiwo8bVdvVv5NeWnlFYtmEIgJ8xuz/oujMKPgx5
	 TYCOzc6X3NRbtlL7GaS7ogHuewz5+MA68SlOyAtQmheuEu3i00MTX7V1lbge2uhwIr
	 n4Xx52s+sxyJrpwhcHf3aPZCgETcHGHpI9CbfSSOZ1i3EKCATSD3ES+BTw4nL04CKZ
	 IbsbkdNVyzAC8kMHtOSXmfc//R6ISlxQqa/9q2XLM1SzkCTcGhyNHLFX3WdZZ0lyPx
	 t2/F4dK17JXSrClpm9GawH6cfY0noCZowcw1fZX+liHlt0XzacNLrnPYjtr5dN7IPS
	 UdHHd+riRd+Vg==
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
Subject: [PATCH v2 4/6] platform/x86: ayaneo-ec: Add controller power and
 modules attributes
Date: Wed, 15 Oct 2025 10:44:12 +0200
Message-ID: <20251015084414.1391595-5-lkml@antheas.dev>
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
 <176051799744.921006.3548139830714446726@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.3 at linux3247.grserver.gr
X-Virus-Status: Clean

The Ayaneo 3 features hot-swappable controller modules. The ejection
and management is done through HID. However, after ejecting the modules,
the controller needs to be power cycled via the EC to re-initialize.

For this, the EC provides a variable that holds whether the left or
right modules are connected, and a power control register to turn
the controller on or off. After ejecting the modules, the controller
should be turned off. Then, after both modules are reinserted,
the controller may be powered on again to re-initialize.

This patch introduces two new sysfs attributes:
 - `controller_modules`: a read-only attribute that indicates whether
   the left and right modules are connected (none, left, right, both).
 - `controller_power`: a read-write attribute that allows the user
   to turn the controller on or off (with '1'/'0').

Therefore, after ejection is complete, userspace can power off the
controller, then wait until both modules have been reinserted
(`controller_modules` will return 'both') to turn on the controller.

Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
---
 .../ABI/testing/sysfs-platform-ayaneo         |  19 ++++
 MAINTAINERS                                   |   1 +
 drivers/platform/x86/ayaneo-ec.c              | 100 ++++++++++++++++++
 3 files changed, 120 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-platform-ayaneo

diff --git a/Documentation/ABI/testing/sysfs-platform-ayaneo b/Documentation/ABI/testing/sysfs-platform-ayaneo
new file mode 100644
index 000000000000..1fa32ba60fd0
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-platform-ayaneo
@@ -0,0 +1,19 @@
+What:		/sys/devices/platform/<platform>/controller_power
+Date:		Oct 2025
+KernelVersion:	6.9
+Contact:	"Antheas Kapenekakis" <lkml@antheas.dev>
+Description:
+		Current controller power state. Allows turning on and off
+		the controller power (e.g. for power savings). Write 1 to
+		turn on, 0 to turn off. File is readable and writable.
+
+What:		/sys/devices/platform/<platform>/controller_modules
+Date:		Oct 2025
+KernelVersion:	6.9
+Contact:	"Antheas Kapenekakis"  <lkml@antheas.dev>
+Description:
+		Shows which controller modules are currently connected to
+		the device. Possible values are "left", "right" and "both".
+		File is read-only. The Windows software for this device
+		will only set controller power to 1 if both module sides
+		are connected (i.e. this file returns "both").
diff --git a/MAINTAINERS b/MAINTAINERS
index 8c4d0c26ca77..3dfa004555dd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4191,6 +4191,7 @@ AYANEO PLATFORM EC DRIVER
 M:	Antheas Kapenekakis <lkml@antheas.dev>
 L:	platform-driver-x86@vger.kernel.org
 S:	Maintained
+F:	Documentation/ABI/testing/sysfs-platform-ayaneo
 F:	drivers/platform/x86/ayaneo-ec.c
 
 AZ6007 DVB DRIVER
diff --git a/drivers/platform/x86/ayaneo-ec.c b/drivers/platform/x86/ayaneo-ec.c
index 23c283f5eb61..363b61fc6e12 100644
--- a/drivers/platform/x86/ayaneo-ec.c
+++ b/drivers/platform/x86/ayaneo-ec.c
@@ -30,9 +30,17 @@
 #define AYANEO_CHARGE_VAL_AUTO		0xaa
 #define AYANEO_CHARGE_VAL_INHIBIT	0x55
 
+#define AYANEO_POWER_REG	0x2d
+#define AYANEO_POWER_OFF	0xfe
+#define AYANEO_POWER_ON		0xff
+#define AYANEO_MODULE_REG	0x2f
+#define AYANEO_MODULE_LEFT	BIT(0)
+#define AYANEO_MODULE_RIGHT	BIT(1)
+
 struct ayaneo_ec_quirk {
 	bool has_fan_control;
 	bool has_charge_control;
+	bool has_magic_modules;
 };
 
 struct ayaneo_ec_platform_data {
@@ -44,6 +52,7 @@ struct ayaneo_ec_platform_data {
 static const struct ayaneo_ec_quirk ayaneo3 = {
 	.has_fan_control = true,
 	.has_charge_control = true,
+	.has_magic_modules = true,
 };
 
 static const struct dmi_system_id dmi_table[] = {
@@ -262,6 +271,96 @@ static int ayaneo_remove_battery(struct power_supply *battery,
 	return 0;
 }
 
+static ssize_t controller_power_store(struct device *dev,
+			    struct device_attribute *attr, const char *buf,
+			    size_t count)
+{
+	bool value;
+	int ret;
+
+	ret = kstrtobool(buf, &value);
+	if (ret)
+		return ret;
+
+	ret = ec_write(AYANEO_POWER_REG, value ? AYANEO_POWER_ON : AYANEO_POWER_OFF);
+	if (ret)
+		return ret;
+
+	return count;
+}
+
+static ssize_t controller_power_show(struct device *dev,
+			   struct device_attribute *attr, char *buf)
+{
+	int ret;
+	u8 val;
+
+	ret = ec_read(AYANEO_POWER_REG, &val);
+	if (ret)
+		return ret;
+
+	return sysfs_emit(buf, "%d\n", val == AYANEO_POWER_ON);
+}
+
+static DEVICE_ATTR_RW(controller_power);
+
+static ssize_t controller_modules_show(struct device *dev,
+				       struct device_attribute *attr, char *buf)
+{
+	bool left, right;
+	char *out;
+	int ret;
+	u8 val;
+
+	ret = ec_read(AYANEO_MODULE_REG, &val);
+	if (ret)
+		return ret;
+
+	left = !(val & AYANEO_MODULE_LEFT);
+	right = !(val & AYANEO_MODULE_RIGHT);
+
+	if (left && right)
+		out = "both";
+	else if (left)
+		out = "left";
+	else if (right)
+		out = "right";
+	else
+		out = "none";
+
+	return sysfs_emit(buf, "%s\n", out);
+}
+
+static DEVICE_ATTR_RO(controller_modules);
+
+static struct attribute *aya_mm_attrs[] = {
+	&dev_attr_controller_power.attr,
+	&dev_attr_controller_modules.attr,
+	NULL
+};
+
+static umode_t aya_mm_is_visible(struct kobject *kobj,
+				 struct attribute *attr, int n)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct platform_device *pdev = to_platform_device(dev);
+	struct ayaneo_ec_platform_data *data = platform_get_drvdata(pdev);
+
+	if (data->quirks->has_magic_modules)
+		return attr->mode;
+	return 0;
+}
+
+static const struct attribute_group aya_mm_attribute_group = {
+	.is_visible = aya_mm_is_visible,
+	.attrs = aya_mm_attrs,
+};
+
+static const struct attribute_group *ayaneo_ec_groups[] = {
+	&aya_mm_attribute_group,
+	NULL
+};
+
 static int ayaneo_ec_probe(struct platform_device *pdev)
 {
 	const struct dmi_system_id *dmi_entry;
@@ -303,6 +402,7 @@ static int ayaneo_ec_probe(struct platform_device *pdev)
 static struct platform_driver ayaneo_platform_driver = {
 	.driver = {
 		.name = "ayaneo-ec",
+		.dev_groups = ayaneo_ec_groups,
 	},
 	.probe = ayaneo_ec_probe,
 };
-- 
2.51.0



