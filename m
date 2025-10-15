Return-Path: <linux-kernel+bounces-854081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D881BDD7FD
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 10:48:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 956AE19A4F84
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 08:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84C9931960F;
	Wed, 15 Oct 2025 08:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="mfOe8X4H"
Received: from relay12.grserver.gr (relay12.grserver.gr [88.99.38.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C18C31690E;
	Wed, 15 Oct 2025 08:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=88.99.38.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760518005; cv=none; b=iLsfhceeXD6BPfg317HkLXJM3k+lC7DvBEmHwuLi8A+tBZb7LhXZDBmiIU5oZLP0F7DHiMywGLukoiFK1iR55y/fAId3JJveLwjmkCgqWS7I1NZdm6NJZ9aPKmC/LDvZMAWY3vlge3oc4PQFDmUcrqpYHbBaHX+KN2A8bgiYZoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760518005; c=relaxed/simple;
	bh=FA4Em+hL8eYFHWx+CkmuzHQihWTQh8GAUQaOv2C36jI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pdlhAzPzgqIs8gfdwKQ9wLdfamnwy0wYm22GqscmQ71v09myj11Qid+o0uU1m8GO9zuefvcqXBc1mzmCnmOoCt+74wHpT12oJKVZpB8UibyH+SKA4yJrIzqyx9eT725WMVfAsftGIHDtUax1zEM+OdKRqNxRx/I2b4SKBpwdwJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=mfOe8X4H; arc=none smtp.client-ip=88.99.38.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from relay12 (localhost [127.0.0.1])
	by relay12.grserver.gr (Proxmox) with ESMTP id 53752BD9E0;
	Wed, 15 Oct 2025 11:46:36 +0300 (EEST)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay12.grserver.gr (Proxmox) with ESMTPS id BCA41BDAA7;
	Wed, 15 Oct 2025 11:46:35 +0300 (EEST)
Received: from antheas-z13 (x5996a8de.customers.hiper-net.dk [89.150.168.222])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id CF49D200A8C;
	Wed, 15 Oct 2025 11:46:33 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1760517995;
	bh=aiIpJlHk4qSmwTPNGmk1NA68aArD73CnQ8C4MX03jh8=; h=From:To:Subject;
	b=mfOe8X4HCcA6mzDAgeXQPOUopAyVteONBsg8BRz7BFqy6MyGktpsOqZrt0VhfydeB
	 syNBr1uOV6sEkOFhEsfnBhJxsTgS0h7BdohlYlSk1KKD7FSN4eoiPsAWtcJJnLMkc2
	 YzcfRUiPn8K6fmlhj21mavVT8zt9r7lXVn/U48A/34eMr4QOmM/RtbO4AVVOJsYNts
	 0AwAEH7xrc3cLCGIk0HfwbgVX9RLCOeEDa224vGMQt47W7TSL32nIjaBFCGduDY1c0
	 SlUyPJtTEYpPgfFWtMdjoHDEalL73mV+n0Sm6jY6CEQMcoD8icvDdVDdrjiOALwQdj
	 FvQeVqQ06sqAw==
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
Subject: [PATCH v2 3/6] platform/x86: ayaneo-ec: Add charge control support
Date: Wed, 15 Oct 2025 10:44:11 +0200
Message-ID: <20251015084414.1391595-4-lkml@antheas.dev>
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
 <176051799542.920943.4632876775525167142@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.3 at linux3247.grserver.gr
X-Virus-Status: Clean

Ayaneo devices support charge inhibition via the EC. This inhibition
only works while the device is powered on, and resets between restarts.
However, it is maintained across suspend/resume cycles.

The EC does not support charge threshold control. Instead, userspace
software on Windows manually toggles charge inhibition depending on
battery level.

Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
---
 drivers/platform/x86/Kconfig     |   1 +
 drivers/platform/x86/ayaneo-ec.c | 111 +++++++++++++++++++++++++++++++
 2 files changed, 112 insertions(+)

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index f132a87fcee9..f5b2edc6bc67 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -320,6 +320,7 @@ config AYANEO_EC
 	tristate "Ayaneo EC platform control"
 	depends on X86
 	depends on ACPI_EC
+	depends on ACPI_BATTERY
 	depends on HWMON
 	help
 	  Enables support for the platform EC of Ayaneo devices. This
diff --git a/drivers/platform/x86/ayaneo-ec.c b/drivers/platform/x86/ayaneo-ec.c
index 9884eed0cc84..23c283f5eb61 100644
--- a/drivers/platform/x86/ayaneo-ec.c
+++ b/drivers/platform/x86/ayaneo-ec.c
@@ -14,6 +14,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <acpi/battery.h>
 
 #define AYANEO_PWM_ENABLE_REG	 0x4A
 #define AYANEO_PWM_REG		 0x4B
@@ -22,17 +23,27 @@
 
 #define AYANEO_FAN_REG		 0x76
 
+#define EC_CHARGE_CONTROL_BEHAVIOURS                         \
+	(BIT(POWER_SUPPLY_CHARGE_BEHAVIOUR_AUTO) |           \
+	 BIT(POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE))
+#define AYANEO_CHARGE_REG		0x1e
+#define AYANEO_CHARGE_VAL_AUTO		0xaa
+#define AYANEO_CHARGE_VAL_INHIBIT	0x55
+
 struct ayaneo_ec_quirk {
 	bool has_fan_control;
+	bool has_charge_control;
 };
 
 struct ayaneo_ec_platform_data {
 	struct platform_device *pdev;
 	struct ayaneo_ec_quirk *quirks;
+	struct acpi_battery_hook battery_hook;
 };
 
 static const struct ayaneo_ec_quirk ayaneo3 = {
 	.has_fan_control = true,
+	.has_charge_control = true,
 };
 
 static const struct dmi_system_id dmi_table[] = {
@@ -161,11 +172,102 @@ static const struct hwmon_chip_info ayaneo_ec_chip_info = {
 	.info = ayaneo_ec_sensors,
 };
 
+static int ayaneo_psy_ext_get_prop(struct power_supply *psy,
+				const struct power_supply_ext *ext,
+				void *data,
+				enum power_supply_property psp,
+				union power_supply_propval *val)
+{
+	int ret;
+	u8 tmp;
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR:
+		ret = ec_read(AYANEO_CHARGE_REG, &tmp);
+		if (ret)
+			return ret;
+
+		if (tmp == AYANEO_CHARGE_VAL_INHIBIT)
+			val->intval = POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE;
+		else
+			val->intval = POWER_SUPPLY_CHARGE_BEHAVIOUR_AUTO;
+		return 0;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int ayaneo_psy_ext_set_prop(struct power_supply *psy,
+				const struct power_supply_ext *ext,
+				void *data,
+				enum power_supply_property psp,
+				const union power_supply_propval *val)
+{
+	u8 raw_val;
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR:
+		switch (val->intval) {
+		case POWER_SUPPLY_CHARGE_BEHAVIOUR_AUTO:
+			raw_val = AYANEO_CHARGE_VAL_AUTO;
+			break;
+		case POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE:
+			raw_val = AYANEO_CHARGE_VAL_INHIBIT;
+			break;
+		default:
+			return -EINVAL;
+		}
+		return ec_write(AYANEO_CHARGE_REG, raw_val);
+	default:
+		return -EINVAL;
+	}
+}
+
+static int ayaneo_psy_prop_is_writeable(struct power_supply *psy,
+				     const struct power_supply_ext *ext,
+				     void *data,
+				     enum power_supply_property psp)
+{
+	return true;
+}
+
+static const enum power_supply_property ayaneo_psy_ext_props[] = {
+	POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR,
+};
+
+static const struct power_supply_ext ayaneo_psy_ext = {
+	.name			= "ayaneo-charge-control",
+	.properties		= ayaneo_psy_ext_props,
+	.num_properties		= ARRAY_SIZE(ayaneo_psy_ext_props),
+	.charge_behaviours	= EC_CHARGE_CONTROL_BEHAVIOURS,
+	.get_property		= ayaneo_psy_ext_get_prop,
+	.set_property		= ayaneo_psy_ext_set_prop,
+	.property_is_writeable	= ayaneo_psy_prop_is_writeable,
+};
+
+static int ayaneo_add_battery(struct power_supply *battery,
+			   struct acpi_battery_hook *hook)
+{
+	struct ayaneo_ec_platform_data *data =
+		container_of(hook, struct ayaneo_ec_platform_data, battery_hook);
+
+	return power_supply_register_extension(battery, &ayaneo_psy_ext,
+					       &data->pdev->dev, NULL);
+}
+
+static int ayaneo_remove_battery(struct power_supply *battery,
+			      struct acpi_battery_hook *hook)
+{
+	power_supply_unregister_extension(battery, &ayaneo_psy_ext);
+	return 0;
+}
+
 static int ayaneo_ec_probe(struct platform_device *pdev)
 {
 	const struct dmi_system_id *dmi_entry;
 	struct ayaneo_ec_platform_data *data;
 	struct device *hwdev;
+	int ret;
 
 	dmi_entry = dmi_first_match(dmi_table);
 	if (!dmi_entry)
@@ -186,6 +288,15 @@ static int ayaneo_ec_probe(struct platform_device *pdev)
 			return PTR_ERR(hwdev);
 	}
 
+	if (data->quirks->has_charge_control) {
+		data->battery_hook.add_battery = ayaneo_add_battery;
+		data->battery_hook.remove_battery = ayaneo_remove_battery;
+		data->battery_hook.name = "Ayaneo Battery";
+		ret = devm_battery_hook_register(&pdev->dev, &data->battery_hook);
+		if (ret)
+			return ret;
+	}
+
 	return 0;
 }
 
-- 
2.51.0



