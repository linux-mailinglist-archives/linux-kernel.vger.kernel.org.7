Return-Path: <linux-kernel+bounces-880622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2209C263D5
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 17:54:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15D14566094
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 16:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 189492EFDBF;
	Fri, 31 Oct 2025 16:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="HJeNEIue"
Received: from relay13.grserver.gr (relay13.grserver.gr [178.156.171.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E1E92BEC52;
	Fri, 31 Oct 2025 16:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.156.171.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761928629; cv=none; b=SXwUi2RG+5OLhFp9+S3Sr3bJx25SlF8iUY3N9IEqsVhbo4/lT/hAi8Mjq4m/J5jJngiUztPAbtTraNfM8SPR0Ex+ZllHyJOSN9mii/GeO5JUSoAbw+3Ks4e9yLA+em6X4M7ifcsUJ9QbttNSy24ol9bqlgpyNekltWMQVAMr6H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761928629; c=relaxed/simple;
	bh=bqMMOXmrP6uw3H7Bwv7/NxVVe3fH/sA/ndd5CNBuZpA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Whgm3p0ipj0Ra1haz8j0VzJ6nY/LNI1rBb1CfW4w77jThcPJLx+qk3KwVKiDo9U3ff63+Rl2EB9Zm8+wI7aZZabJSePILMZb+uNYbvtVVwukyAYWSn0slfNI9AAHvy3X4I384S4NowGVkTDs2azmubJ6Lk1F9TJWT+WboF2FMqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=HJeNEIue; arc=none smtp.client-ip=178.156.171.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from relay13 (localhost [127.0.0.1])
	by relay13.grserver.gr (Proxmox) with ESMTP id 8BFEE5E570;
	Fri, 31 Oct 2025 18:36:59 +0200 (EET)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay13.grserver.gr (Proxmox) with ESMTPS id 849C95E58F;
	Fri, 31 Oct 2025 18:36:57 +0200 (EET)
Received: from antheas-z13 (unknown [IPv6:2a05:f6c2:511b:0:8d8a:5967:d692:ea4e])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id 14414200C57;
	Fri, 31 Oct 2025 18:36:55 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1761928616;
	bh=ixQIUvCQ1yl5bg3IC8Mc7sxYdE18wX74fvM8zpBiMjc=; h=From:To:Subject;
	b=HJeNEIueoIZ0nLM+dd+L4OhixmrA95F4RJTrJFMyX6pyTZ7SwS3lskA1hbCIBi+/6
	 50SBGDRssYZRJE+BDc8tC+ngRDklX3Kpkk15NIJjk1/2WUngsLlcEFwTwxWjt/tnaa
	 xqKpgqpK9DLQivhXQ0kTSEc3ZpQW/RKl/mjnvZqbBQrGZvdOo6sSS3vZDXTHIQv8yF
	 abb/kxVcqZ/0uRcSsqh71S63hpOuiwDBtV6gAqzPSLNzMcPnD3u0Ud/c8vXEVe5N3Q
	 HSU3naSDB2uQhbHgArIqVdJJycCtstcau5E2+5X07Kths7Gdp/lFxSB94IZyWD1T/m
	 qiyq+X6+Odrbw==
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
Subject: [PATCH v3 3/6] platform/x86: ayaneo-ec: Add charge control support
Date: Fri, 31 Oct 2025 17:36:48 +0100
Message-ID: <20251031163651.1465981-4-lkml@antheas.dev>
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
 <176192861661.3949147.132334295208550071@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.3 at linux3247.grserver.gr
X-Virus-Status: Clean

Ayaneo devices support charge inhibition via the EC. This inhibition
only works while the device is powered on, and resets between restarts.
However, it is maintained across suspend/resume cycles.

The EC does not support charge threshold control. Instead, userspace
software on Windows manually toggles charge inhibition depending on
battery level.

Reviewed-by: Armin Wolf <W_Armin@gmx.de>
Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
---
 drivers/platform/x86/Kconfig     |   1 +
 drivers/platform/x86/ayaneo-ec.c | 112 +++++++++++++++++++++++++++++++
 2 files changed, 113 insertions(+)

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index b3beaff4b03a..a45449ae83f8 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -319,6 +319,7 @@ config ASUS_TF103C_DOCK
 config AYANEO_EC
 	tristate "Ayaneo EC platform control"
 	depends on ACPI_EC
+	depends on ACPI_BATTERY
 	depends on HWMON
 	help
 	  Enables support for the platform EC of Ayaneo devices. This
diff --git a/drivers/platform/x86/ayaneo-ec.c b/drivers/platform/x86/ayaneo-ec.c
index 108a23458a4f..697bb053a7d6 100644
--- a/drivers/platform/x86/ayaneo-ec.c
+++ b/drivers/platform/x86/ayaneo-ec.c
@@ -15,6 +15,8 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/power_supply.h>
+#include <acpi/battery.h>
 
 #define AYANEO_PWM_ENABLE_REG	 0x4A
 #define AYANEO_PWM_REG		 0x4B
@@ -23,17 +25,27 @@
 
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
 
 static const struct ayaneo_ec_quirk quirk_ayaneo3 = {
 	.has_fan_control = true,
+	.has_charge_control = true,
 };
 
 static const struct dmi_system_id dmi_table[] = {
@@ -164,11 +176,102 @@ static const struct hwmon_chip_info ayaneo_ec_chip_info = {
 	.info = ayaneo_ec_sensors,
 };
 
+static int ayaneo_psy_ext_get_prop(struct power_supply *psy,
+				   const struct power_supply_ext *ext,
+				   void *data,
+				   enum power_supply_property psp,
+				   union power_supply_propval *val)
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
+				   const struct power_supply_ext *ext,
+				   void *data,
+				   enum power_supply_property psp,
+				   const union power_supply_propval *val)
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
+					const struct power_supply_ext *ext,
+					void *data,
+					enum power_supply_property psp)
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
+			      struct acpi_battery_hook *hook)
+{
+	struct ayaneo_ec_platform_data *data =
+		container_of(hook, struct ayaneo_ec_platform_data, battery_hook);
+
+	return power_supply_register_extension(battery, &ayaneo_psy_ext,
+					       &data->pdev->dev, NULL);
+}
+
+static int ayaneo_remove_battery(struct power_supply *battery,
+				 struct acpi_battery_hook *hook)
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
@@ -189,6 +292,15 @@ static int ayaneo_ec_probe(struct platform_device *pdev)
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
2.51.1



