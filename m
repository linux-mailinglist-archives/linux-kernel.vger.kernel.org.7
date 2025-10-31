Return-Path: <linux-kernel+bounces-880624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34394C2633F
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 17:48:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FE6856658E
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 16:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D9642F25E7;
	Fri, 31 Oct 2025 16:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="NKP3xKc1"
Received: from relay12.grserver.gr (relay12.grserver.gr [88.99.38.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79B32EC571;
	Fri, 31 Oct 2025 16:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=88.99.38.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761928630; cv=none; b=lGolVXgAL8AL25D9rYVGTcyb2D3BBmJ9Pw2gAY0EUXXBSr+x+cIdG4ykqlF/3JF3jQmB7tEz5EyWxfxBWhENvauyTSMZRj/YElOGl+Nlup2MpFio7vg4ViDnP6ADhQHRjcHqHpMUmrukGN8CjydMnD5q1j25IP8k95Fk5TRZ8D0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761928630; c=relaxed/simple;
	bh=NkMQqM6g8Z26yyC688U6scWFlt4xbGcpQ3OW0MO8lh8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SnZb+GfwC8/iH/4/OiPG0YYxAWUYzrYgKvylbEeaO2mBs16csVWskD1djKAE8ThpX7zRy+cKywChB9MQhCMZJp6TumGss5NqZB5jdxacWysnF9DPNW2PcoLnlYRrgM8+xv8Km6q9ZTmVG4wBHdxlmEHRGEQNY+tRPV5ADJvEspk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=NKP3xKc1; arc=none smtp.client-ip=88.99.38.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from relay12 (localhost [127.0.0.1])
	by relay12.grserver.gr (Proxmox) with ESMTP id C20A8BDD28;
	Fri, 31 Oct 2025 18:36:58 +0200 (EET)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay12.grserver.gr (Proxmox) with ESMTPS id E54A8BDCD8;
	Fri, 31 Oct 2025 18:36:57 +0200 (EET)
Received: from antheas-z13 (unknown [IPv6:2a05:f6c2:511b:0:8d8a:5967:d692:ea4e])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id 0A8A2200CBD;
	Fri, 31 Oct 2025 18:36:57 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1761928617;
	bh=oa44aZAO9DdfSe5ySrnFHWgZ/hRclz1+svHrWdk6014=; h=From:To:Subject;
	b=NKP3xKc1NnykuwHrVbFr2WdWPdTOGorPGgDmZxGATuKbYky8xQziSLtTnIHfkTAwY
	 9c06oUQMi7hhdHpaBPRBSnHoNpDRWZ7mv8JFHPUckeywjzfIOESZ8IJ016XQPSnKVq
	 8v4uv0CgHDmUvzHTuKJtEB4aecDOGpNpbDnWgoC5OTRUrJjV71okd7b+jTrl4P9lA5
	 J3uaqX3+r160hLaqr2CZwHoW3sxm2sXGrPHcGoJxerHxf/Lo/fB30AhAsDTV4xxif7
	 nwsmKYqBWy6kIs42QdcXDwdG9dPwXwsuoCsV+ZcEjaDvZiHg1V8eP4riMwlC2Ky0FU
	 bxVKKMkZC8ViQ==
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
	Antheas Kapenekakis <lkml@antheas.dev>,
	Armin Wolf <W_Armin@gmx.de>
Subject: [PATCH v3 4/6] platform/x86: ayaneo-ec: Add controller power and
 modules attributes
Date: Fri, 31 Oct 2025 17:36:49 +0100
Message-ID: <20251031163651.1465981-5-lkml@antheas.dev>
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
 <176192861758.3949204.7723636090175618120@linux3247.grserver.gr>
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

Reviewed-by: Armin Wolf <W_Armin@gmx.de>
Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
---
 .../ABI/testing/sysfs-platform-ayaneo-ec      |  19 ++++
 MAINTAINERS                                   |   1 +
 drivers/platform/x86/ayaneo-ec.c              | 106 ++++++++++++++++++
 3 files changed, 126 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-platform-ayaneo-ec

diff --git a/Documentation/ABI/testing/sysfs-platform-ayaneo-ec b/Documentation/ABI/testing/sysfs-platform-ayaneo-ec
new file mode 100644
index 000000000000..3c9c3580c685
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-platform-ayaneo-ec
@@ -0,0 +1,19 @@
+What:		/sys/devices/platform/ayaneo-ec/controller_power
+Date:		Oct 2025
+KernelVersion:	6.19
+Contact:	"Antheas Kapenekakis" <lkml@antheas.dev>
+Description:
+		Current controller power state. Allows turning on and off
+		the controller power (e.g. for power savings). Write 1 to
+		turn on, 0 to turn off. File is readable and writable.
+
+What:		/sys/devices/platform/ayaneo-ec/controller_modules
+Date:		Oct 2025
+KernelVersion:	6.19
+Contact:	"Antheas Kapenekakis"  <lkml@antheas.dev>
+Description:
+		Shows which controller modules are currently connected to
+		the device. Possible values are "left", "right" and "both".
+		File is read-only. The Windows software for this device
+		will only set controller power to 1 if both module sides
+		are connected (i.e. this file returns "both").
diff --git a/MAINTAINERS b/MAINTAINERS
index da9498d8cc89..b4d62ea9a926 100644
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
index 697bb053a7d6..0652c044ad76 100644
--- a/drivers/platform/x86/ayaneo-ec.c
+++ b/drivers/platform/x86/ayaneo-ec.c
@@ -8,6 +8,7 @@
  */
 
 #include <linux/acpi.h>
+#include <linux/bits.h>
 #include <linux/dmi.h>
 #include <linux/err.h>
 #include <linux/hwmon.h>
@@ -16,6 +17,7 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/power_supply.h>
+#include <linux/sysfs.h>
 #include <acpi/battery.h>
 
 #define AYANEO_PWM_ENABLE_REG	 0x4A
@@ -32,9 +34,17 @@
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
@@ -46,6 +56,7 @@ struct ayaneo_ec_platform_data {
 static const struct ayaneo_ec_quirk quirk_ayaneo3 = {
 	.has_fan_control = true,
 	.has_charge_control = true,
+	.has_magic_modules = true,
 };
 
 static const struct dmi_system_id dmi_table[] = {
@@ -266,6 +277,100 @@ static int ayaneo_remove_battery(struct power_supply *battery,
 	return 0;
 }
 
+static ssize_t controller_power_store(struct device *dev,
+				      struct device_attribute *attr,
+				      const char *buf,
+				      size_t count)
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
+				     struct device_attribute *attr,
+				     char *buf)
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
+	char *out;
+	int ret;
+	u8 val;
+
+	ret = ec_read(AYANEO_MODULE_REG, &val);
+	if (ret)
+		return ret;
+
+	switch (~val & (AYANEO_MODULE_LEFT | AYANEO_MODULE_RIGHT)) {
+	case AYANEO_MODULE_LEFT | AYANEO_MODULE_RIGHT:
+		out = "both";
+		break;
+	case AYANEO_MODULE_LEFT:
+		out = "left";
+		break;
+	case AYANEO_MODULE_RIGHT:
+		out = "right";
+		break;
+	default:
+		out = "none";
+		break;
+	}
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
@@ -307,6 +412,7 @@ static int ayaneo_ec_probe(struct platform_device *pdev)
 static struct platform_driver ayaneo_platform_driver = {
 	.driver = {
 		.name = "ayaneo-ec",
+		.dev_groups = ayaneo_ec_groups,
 	},
 	.probe = ayaneo_ec_probe,
 };
-- 
2.51.1



