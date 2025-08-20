Return-Path: <linux-kernel+bounces-778157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EA01B2E209
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 18:13:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74DA0173269
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 16:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BA4B322DD3;
	Wed, 20 Aug 2025 16:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="VlZW8vY5"
Received: from relay11.grserver.gr (relay11.grserver.gr [78.46.171.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C7AB158538;
	Wed, 20 Aug 2025 16:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.46.171.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755706006; cv=none; b=LtYXjIZSGOMCs41/5BqbaqPXMNgwLc+MoqpX8Vy1xGcEuaV9ItYBLAiB1C0U/qFFmDgJStYgzlNdZejYXfscrHiY0yEvbhIHbC0g9gn440e5GfnPfQyxM7fmGjY0GfmI1cX1Yv+HHIC5n0LTNSamsFz9+r3NH6ob9V+Jq4j2tGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755706006; c=relaxed/simple;
	bh=SCLob1P7lf6sUZckuXPDUNBl/7tApROfvewivZSn0Po=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IHfEyFhqxzOmmycBuzymQRo9VSijGj+a8AYXEQiIi7Q4PuH7OY58oey6c9fhaRQrI1F9srSUtNJrkNaOe9+3H6LWgOINsG1f4Ewf5Zk//ojfRA5IBiTwaF/uBj8iSQibRqYaueoclWbsNjuR4BhT1IIOOcNl1v57w+EtMYjou98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=VlZW8vY5; arc=none smtp.client-ip=78.46.171.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from relay11 (localhost.localdomain [127.0.0.1])
	by relay11.grserver.gr (Proxmox) with ESMTP id 2B044C5C89;
	Wed, 20 Aug 2025 19:06:35 +0300 (EEST)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay11.grserver.gr (Proxmox) with ESMTPS id 61D6FC5C7D;
	Wed, 20 Aug 2025 19:06:34 +0300 (EEST)
Received: from antheas-z13 (unknown [IPv6:2a05:f6c2:511b:0:7200:c86a:8976:4786])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id 7FA781FD027;
	Wed, 20 Aug 2025 19:06:33 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1755705994;
	bh=G/j1d5xYuzUU2coLnA/7L2dZMxo90xR3kuo3XTxCbC0=; h=From:To:Subject;
	b=VlZW8vY5fyjOxsTFQ1s8R0AAlqv2amR8qR5tT4n7pWRJ2heN7SfnLpp0FBgwgwF3S
	 aInLAdk32FS2wlTrwLUxC5zKIvZVSCcZBxe9sh1FHP7o4oSaYFdW+z1tPpwuA97PvR
	 2hSIBTHVUrXjCuGIzG8y8oYte6kFQ6CrEL/G9HEL+uH+PqikPHJNAR8eSvDnDOG/KU
	 Y7RPxRESEe+E5Wd0tHoK18IJ8mHU93KQjPjGCJDhWZjzm2BeBu435QaT4eNNNVlM8i
	 rmieh1Bdcc87fPeqAC9H3pg/lbRhJY/za5Ix8HGWQHGCcmqeVyiHRDhzSKzuZ7p+8d
	 upp/UbwlZxbzg==
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
Subject: [PATCH v1 4/5] platform/x86: ayaneo-ec: Add controller power and
 modules attributes
Date: Wed, 20 Aug 2025 18:06:27 +0200
Message-ID: <20250820160628.99678-5-lkml@antheas.dev>
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
 <175570599406.2162779.6203520223486516210@linux3247.grserver.gr>
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

This patch introduces two new firmware attributes:
 - `controller_modules`: a read-only attribute that indicates whether
   the left and right modules are connected (none, left, right, both).
 - `controller_power`: a read-write attribute that allows the user
   to turn the controller on or off (with 'on'/'off').

Therefore, after ejection is complete, userspace can power off the
controller, then wait until both modules have been reinserted
(`controller_modules` will return 'both') to turn on the controller.

Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
---
 drivers/platform/x86/ayaneo-ec.c | 235 ++++++++++++++++++++++++++++++-
 1 file changed, 234 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/ayaneo-ec.c b/drivers/platform/x86/ayaneo-ec.c
index a4bdc6ae7af7..eb7f9ae03b4f 100644
--- a/drivers/platform/x86/ayaneo-ec.c
+++ b/drivers/platform/x86/ayaneo-ec.c
@@ -16,6 +16,10 @@
 #include <linux/platform_device.h>
 #include <acpi/battery.h>
 
+#include "firmware_attributes_class.h"
+
+#define DRIVER_NAME "ayaneo-ec"
+
 #define AYANEO_PWM_ENABLE_REG	 0x4A
 #define AYANEO_PWM_REG		 0x4B
 #define AYANEO_PWM_MODE_AUTO	 0x00
@@ -30,20 +34,60 @@
 #define AYANEO_CHARGE_VAL_AUTO		0xaa
 #define AYANEO_CHARGE_VAL_INHIBIT	0x55
 
+#define AYANEO_POWER_REG	0x2d
+#define AYANEO_POWER_OFF	0xfe
+#define AYANEO_POWER_ON		0xff
+#define AYANEO_MODULE_REG	0x2f
+#define AYANEO_MODULE_LEFT	BIT(0)
+#define AYANEO_MODULE_RIGHT	BIT(1)
+
+enum ayaneo_fw_attr_id {
+	AYANEO_ATTR_CONTROLLER_MODULES,
+	AYANEO_ATTR_CONTROLLER_POWER,
+};
+
+static const char *const ayaneo_fw_attr_name[] = {
+	[AYANEO_ATTR_CONTROLLER_MODULES] = "controller_modules",
+	[AYANEO_ATTR_CONTROLLER_POWER] = "controller_power",
+};
+
+static const char *const ayaneo_fw_attr_desc[] = {
+	[AYANEO_ATTR_CONTROLLER_MODULES] =
+		"Which controller Magic Modules are connected (none, left, right, both)",
+	[AYANEO_ATTR_CONTROLLER_POWER] = "Controller power state (on, off)",
+};
+
+#define AYANEO_ATTR_ENUM_MAX_ATTRS 7
+#define AYANEO_ATTR_LANGUAGE_CODE "en_US.UTF-8"
+
 struct ayaneo_ec_quirk {
 	bool has_fan_control;
 	bool has_charge_control;
+	bool has_magic_modules;
+	bool has_controller_power;
 };
 
 struct ayaneo_ec_platform_data {
 	struct platform_device *pdev;
 	struct ayaneo_ec_quirk *quirks;
 	struct acpi_battery_hook battery_hook;
+	struct device *fw_attrs_dev;
+	struct kset *fw_attrs_kset;
+};
+
+struct ayaneo_fw_attr {
+	struct ayaneo_ec_platform_data *data;
+	enum ayaneo_fw_attr_id fw_attr_id;
+	struct attribute_group attr_group;
+	struct kobj_attribute display_name;
+	struct kobj_attribute current_value;
 };
 
 static const struct ayaneo_ec_quirk ayaneo3 = {
 	.has_fan_control = true,
 	.has_charge_control = true,
+	.has_magic_modules = true,
+	.has_controller_power = true,
 };
 
 static const struct dmi_system_id dmi_table[] = {
@@ -260,6 +304,159 @@ static int ayaneo_remove_battery(struct power_supply *battery,
 	return 0;
 }
 
+static void ayaneo_kset_unregister(void *data)
+{
+	struct kset *kset = data;
+
+	kset_unregister(kset);
+}
+
+static void ayaneo_fw_attrs_dev_unregister(void *data)
+{
+	struct device *fw_attrs_dev = data;
+
+	device_unregister(fw_attrs_dev);
+}
+
+static ssize_t display_name_language_code_show(struct kobject *kobj,
+					       struct kobj_attribute *attr,
+					       char *buf)
+{
+	return sysfs_emit(buf, "%s\n", AYANEO_ATTR_LANGUAGE_CODE);
+}
+
+static struct kobj_attribute fw_attr_display_name_language_code =
+	__ATTR_RO(display_name_language_code);
+
+static ssize_t display_name_show(struct kobject *kobj,
+				 struct kobj_attribute *attr, char *buf)
+{
+	struct ayaneo_fw_attr *fw_attr =
+		container_of(attr, struct ayaneo_fw_attr, display_name);
+
+	return sysfs_emit(buf, "%s\n", ayaneo_fw_attr_desc[fw_attr->fw_attr_id]);
+}
+
+static ssize_t current_value_show(struct kobject *kobj,
+				  struct kobj_attribute *attr, char *buf)
+{
+	struct ayaneo_fw_attr *fw_attr =
+		container_of(attr, struct ayaneo_fw_attr, current_value);
+	bool left, right;
+	char *out;
+	int ret;
+	u8 tmp;
+
+	switch (fw_attr->fw_attr_id) {
+	case AYANEO_ATTR_CONTROLLER_MODULES:
+		ret = ec_read(AYANEO_MODULE_REG, &tmp);
+		if (ret)
+			return ret;
+		left = !(tmp & AYANEO_MODULE_LEFT);
+		right = !(tmp & AYANEO_MODULE_RIGHT);
+
+		if (left && right)
+			out = "both";
+		else if (left)
+			out = "left";
+		else if (right)
+			out = "right";
+		else
+			out = "none";
+
+		return sysfs_emit(buf, "%s\n", out);
+	case AYANEO_ATTR_CONTROLLER_POWER:
+		ret = ec_read(AYANEO_POWER_REG, &tmp);
+		if (ret)
+			return ret;
+
+		if (tmp == AYANEO_POWER_OFF)
+			out = "off";
+		else
+			out = "on";
+
+		return sysfs_emit(buf, "%s\n", out);
+	}
+	return -EINVAL;
+}
+
+static ssize_t current_value_store(struct kobject *kobj,
+				   struct kobj_attribute *attr, const char *buf,
+				   size_t count)
+{
+	struct ayaneo_fw_attr *fw_attr =
+		container_of(attr, struct ayaneo_fw_attr, current_value);
+	int ret;
+
+	switch (fw_attr->fw_attr_id) {
+	case AYANEO_ATTR_CONTROLLER_POWER:
+		if (sysfs_streq(buf, "on"))
+			ret = ec_write(AYANEO_POWER_REG, AYANEO_POWER_ON);
+		else if (sysfs_streq(buf, "off"))
+			ret = ec_write(AYANEO_POWER_REG, AYANEO_POWER_OFF);
+		if (ret)
+			return ret;
+		return count;
+	case AYANEO_ATTR_CONTROLLER_MODULES:
+		return -EINVAL;
+	}
+	return -EINVAL;
+}
+
+static ssize_t type_show(struct kobject *kobj, struct kobj_attribute *attr,
+			 char *buf)
+{
+	return sysfs_emit(buf, "string\n");
+}
+
+static struct kobj_attribute fw_attr_type_string = {
+	.attr = { .name = "type", .mode = 0444 },
+	.show = type_show,
+};
+
+static int ayaneo_fw_attr_init(struct ayaneo_ec_platform_data *data,
+			       const enum ayaneo_fw_attr_id fw_attr_id,
+			       bool read_only)
+{
+	struct ayaneo_fw_attr *fw_attr;
+	struct attribute **attrs;
+	int idx = 0;
+
+	fw_attr = devm_kzalloc(&data->pdev->dev, sizeof(*fw_attr), GFP_KERNEL);
+	if (!fw_attr)
+		return -ENOMEM;
+
+	attrs = devm_kcalloc(&data->pdev->dev, AYANEO_ATTR_ENUM_MAX_ATTRS + 1,
+			     sizeof(*attrs), GFP_KERNEL);
+	if (!attrs)
+		return -ENOMEM;
+
+	fw_attr->data = data;
+	fw_attr->fw_attr_id = fw_attr_id;
+	fw_attr->attr_group.name = ayaneo_fw_attr_name[fw_attr_id];
+	fw_attr->attr_group.attrs = attrs;
+
+	attrs[idx++] = &fw_attr_type_string.attr;
+	attrs[idx++] = &fw_attr_display_name_language_code.attr;
+
+	sysfs_attr_init(&fw_attr->display_name.attr);
+	fw_attr->display_name.attr.name = "display_name";
+	fw_attr->display_name.attr.mode = 0444;
+	fw_attr->display_name.show = display_name_show;
+	attrs[idx++] = &fw_attr->display_name.attr;
+
+	sysfs_attr_init(&fw_attr->current_value.attr);
+	fw_attr->current_value.attr.name = "current_value";
+	fw_attr->current_value.attr.mode = read_only ? 0444 : 0644;
+	fw_attr->current_value.show = current_value_show;
+	fw_attr->current_value.store = current_value_store;
+	attrs[idx++] = &fw_attr->current_value.attr;
+
+	attrs[idx] = NULL;
+	return sysfs_create_group(&data->fw_attrs_kset->kobj,
+				  &fw_attr->attr_group);
+}
+
 static int ayaneo_ec_probe(struct platform_device *pdev)
 {
 	const struct dmi_system_id *dmi_entry;
@@ -295,12 +492,48 @@ static int ayaneo_ec_probe(struct platform_device *pdev)
 			return ret;
 	}
 
+	if (data->quirks->has_magic_modules || data->quirks->has_controller_power) {
+		data->fw_attrs_dev = device_create(&firmware_attributes_class, NULL,
+						MKDEV(0, 0), NULL, "%s",
+						DRIVER_NAME);
+		if (IS_ERR(data->fw_attrs_dev))
+			return PTR_ERR(data->fw_attrs_dev);
+
+		ret = devm_add_action_or_reset(&data->pdev->dev,
+					ayaneo_fw_attrs_dev_unregister,
+					data->fw_attrs_dev);
+		if (ret)
+			return ret;
+
+		data->fw_attrs_kset = kset_create_and_add("attributes", NULL,
+							&data->fw_attrs_dev->kobj);
+		if (!data->fw_attrs_kset)
+			return -ENOMEM;
+
+		ret = devm_add_action_or_reset(&data->pdev->dev, ayaneo_kset_unregister,
+					data->fw_attrs_kset);
+
+		if (data->quirks->has_magic_modules) {
+			ret = ayaneo_fw_attr_init(
+				data, AYANEO_ATTR_CONTROLLER_MODULES, true);
+			if (ret)
+				return ret;
+		}
+
+		if (data->quirks->has_controller_power) {
+			ret = ayaneo_fw_attr_init(
+				data, AYANEO_ATTR_CONTROLLER_POWER, false);
+			if (ret)
+				return ret;
+		}
+	}
+
 	return 0;
 }
 
 static struct platform_driver ayaneo_platform_driver = {
 	.driver = {
-		.name = "ayaneo-ec",
+		.name = DRIVER_NAME,
 	},
 	.probe = ayaneo_ec_probe,
 };
-- 
2.50.1



