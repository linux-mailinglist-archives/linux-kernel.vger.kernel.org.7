Return-Path: <linux-kernel+bounces-778155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AE78B2E207
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 18:13:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AA401724AE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 16:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FAAA322A19;
	Wed, 20 Aug 2025 16:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="K2SnrFQK"
Received: from relay11.grserver.gr (relay11.grserver.gr [78.46.171.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F3023909F;
	Wed, 20 Aug 2025 16:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.46.171.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755706004; cv=none; b=T6q12Sa117jIQ9NVknXQv/X42w3MQx3OSjA6sk+/9JuR/ZdBj6eXtYtv5/fyqlbFiNcQJPMCvJPCHO2yDnPbC9ruA69LxZdNhNo2ECFqTGiBZ0tBKNhcvhB1xsgBXDPCfm3v45YGx4MT+7JH+423TThIIZg6SHNNmuCtJqL+iaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755706004; c=relaxed/simple;
	bh=zb2g+r3cJ7UMel+RtIvaiOlpRn9I9h6P+DbCMImmBLk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=It+DKqj91KiGyZiuJnWZc0CUGYZf+dudwP5wT6a/KMcsPzrJeJ665DbRdvSjcmlbMc48Awm8L6s/WFXRQXVTc/M+ZjNUd8bnA8pMNd9epvolJ6QC7k0yTrDy/ZvmbPRqnQq7bzLEj/iy+I/WCBksz1Kr4EpDiePSnOGrk9fJFyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=K2SnrFQK; arc=none smtp.client-ip=78.46.171.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from relay11 (localhost.localdomain [127.0.0.1])
	by relay11.grserver.gr (Proxmox) with ESMTP id 04241C5C82;
	Wed, 20 Aug 2025 19:06:34 +0300 (EEST)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay11.grserver.gr (Proxmox) with ESMTPS id 7D7E9C5C7D;
	Wed, 20 Aug 2025 19:06:33 +0300 (EEST)
Received: from antheas-z13 (unknown [IPv6:2a05:f6c2:511b:0:7200:c86a:8976:4786])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id A1FD41FD4AC;
	Wed, 20 Aug 2025 19:06:32 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1755705993;
	bh=5lPVm50we/HBZRgiKKoeroZQYLufvKOV3QNKU3+SIrs=; h=From:To:Subject;
	b=K2SnrFQKeQg/ITN0jYvs9AgSJ7Aog2B3TvIujGtIu7kMFf4a+vuReUAfMm0TDqJmd
	 tbkzIH3sEUEF7n4YmMxiZLSjghc1MReEphsMrpNHQHys/3GDYHZJX8E5b45ALHIYUZ
	 zzM6sFzdBKFzZnXFepM+8woH0yZviuqYPaLCLbSTqE/JXUXJxI4xds8mUnFDZUlq0t
	 /U5RPrSZDEdxDWVY1DHiQD047Vt9w/tN+ky6u9Uc4KLb8X9VwhhStV5ywXntyEqleh
	 D78uWdtQ+QmQP1eZLxDIEeB92DMzY/pbZJDec6wObZXeB2wlS1tIxklixuyvfhl+oi
	 DIrlYbtE2a5rQ==
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
Subject: [PATCH v1 3/5] platform/x86: ayaneo-ec: Add charge control support
Date: Wed, 20 Aug 2025 18:06:26 +0200
Message-ID: <20250820160628.99678-4-lkml@antheas.dev>
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
 <175570599317.2162733.2479809423753195306@linux3247.grserver.gr>
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
index 0a7ca2c78456..c871a722e5ef 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -308,6 +308,7 @@ config AYANEO_EC
 	tristate "Ayaneo EC platform control"
 	depends on X86
 	depends on ACPI_EC
+	depends on ACPI_BATTERY
 	depends on HWMON
 	help
 	  Enables support for the platform EC of Ayaneo devices. This
diff --git a/drivers/platform/x86/ayaneo-ec.c b/drivers/platform/x86/ayaneo-ec.c
index 8b1902706b81..a4bdc6ae7af7 100644
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
@@ -159,11 +170,102 @@ static const struct hwmon_chip_info ayaneo_ec_chip_info = {
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
@@ -184,6 +286,15 @@ static int ayaneo_ec_probe(struct platform_device *pdev)
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
2.50.1



