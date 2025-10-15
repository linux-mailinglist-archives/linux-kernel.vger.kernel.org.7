Return-Path: <linux-kernel+bounces-854080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 278FFBDD7DF
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 10:47:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A17EB356310
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 08:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84FAB3191D2;
	Wed, 15 Oct 2025 08:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="U9n3eEmn"
Received: from relay10.grserver.gr (relay10.grserver.gr [37.27.248.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A111E3176E1;
	Wed, 15 Oct 2025 08:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.27.248.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760518003; cv=none; b=CxyUkqwxw1dhHS0eZQW9wDPKN/iRCqJxzx+pkDGnu8kNaw9zCX0wdVEOH3z47DsDfAblZj6OU3N9yZNoxBC5eN2oJhuXsFyUWbozBg8t672nKCCsL8apKwC7b7uwWqGMpapFnnZSWiIBV0dziqScbEbdWfr161PstHNLlpAS32E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760518003; c=relaxed/simple;
	bh=pyfnguZg/N1oJ2H+PoFx0QS+XO+tmuf5aOGf/zHjwGM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p2hthov+FqdSEChrqhT6NVr7Gl9TTdtX2YOAa3k8gDJPW63w2Cxp+2mAy5bXXlm/8Y2JovT6PAkXhFpYX7eEmoL/xDhGCdmQTrAYn3dPrviwLvxWtZijwbgPkvxy4ln1X0PTXDddvqALCTGzwQM7XGo9UHdQfBCUJTIt0qoH1hI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=U9n3eEmn; arc=none smtp.client-ip=37.27.248.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from relay10 (localhost.localdomain [127.0.0.1])
	by relay10.grserver.gr (Proxmox) with ESMTP id 6DCD2427C7;
	Wed, 15 Oct 2025 11:46:34 +0300 (EEST)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay10.grserver.gr (Proxmox) with ESMTPS id DC4A7426EB;
	Wed, 15 Oct 2025 11:46:33 +0300 (EEST)
Received: from antheas-z13 (x5996a8de.customers.hiper-net.dk [89.150.168.222])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id CBB4D200A81;
	Wed, 15 Oct 2025 11:46:31 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1760517993;
	bh=woJHWbWQEG/LxQTZNbpf2CcQBnVgMbYqjU4CUjGwV+o=; h=From:To:Subject;
	b=U9n3eEmn3gI7/UoqVcfshTQKSlaWAEj/oKo4hMvRO9QzQ8USgaAkRYBLKbpbGyiyi
	 mt51LpP9iBnHfPPz5Hl/wZe0Lorc26+mA6TzRYotM3xaMsPHItmJqMrK8zw5YQVIhl
	 kVPBrbB588yPsP5CHO4z66dH/CdDjAWXITpKcaHvw8hByDe6vFtZj66nb08ASHMHDp
	 RXNVKE0kpIz1WgDcba38FAHbzyxgiiIsodMmuwuRT/Ly6lOZZy94VEIMTpbfG/+hK2
	 1vhls5T92Ip6+BoBF+MY4PzihtnCtd+ezJwYtc82ttHp7yqwYRXEufhZTgsn2pV051
	 VR46RIdOMpVkw==
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
Subject: [PATCH v2 2/6] platform/x86: ayaneo-ec: Add hwmon support
Date: Wed, 15 Oct 2025 10:44:10 +0200
Message-ID: <20251015084414.1391595-3-lkml@antheas.dev>
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
 <176051799340.920880.7528872583679638862@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.3 at linux3247.grserver.gr
X-Virus-Status: Clean

Add hwmon single fan sensor reads and control for Ayaneo devices.
The register and method of access is the same for all devices.

Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
---
 drivers/platform/x86/Kconfig     |   2 +
 drivers/platform/x86/ayaneo-ec.c | 134 +++++++++++++++++++++++++++++++
 2 files changed, 136 insertions(+)

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index ff2678927696..f132a87fcee9 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -319,6 +319,8 @@ config ASUS_TF103C_DOCK
 config AYANEO_EC
 	tristate "Ayaneo EC platform control"
 	depends on X86
+	depends on ACPI_EC
+	depends on HWMON
 	help
 	  Enables support for the platform EC of Ayaneo devices. This
 	  includes fan control, fan speed, charge limit, magic
diff --git a/drivers/platform/x86/ayaneo-ec.c b/drivers/platform/x86/ayaneo-ec.c
index 90b86527ab0d..9884eed0cc84 100644
--- a/drivers/platform/x86/ayaneo-ec.c
+++ b/drivers/platform/x86/ayaneo-ec.c
@@ -7,13 +7,23 @@
  * Copyright (C) 2025 Antheas Kapenekakis <lkml@antheas.dev>
  */
 
+#include <linux/acpi.h>
 #include <linux/dmi.h>
+#include <linux/hwmon.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
 
+#define AYANEO_PWM_ENABLE_REG	 0x4A
+#define AYANEO_PWM_REG		 0x4B
+#define AYANEO_PWM_MODE_AUTO	 0x00
+#define AYANEO_PWM_MODE_MANUAL	 0x01
+
+#define AYANEO_FAN_REG		 0x76
+
 struct ayaneo_ec_quirk {
+	bool has_fan_control;
 };
 
 struct ayaneo_ec_platform_data {
@@ -22,6 +32,7 @@ struct ayaneo_ec_platform_data {
 };
 
 static const struct ayaneo_ec_quirk ayaneo3 = {
+	.has_fan_control = true,
 };
 
 static const struct dmi_system_id dmi_table[] = {
@@ -35,10 +46,126 @@ static const struct dmi_system_id dmi_table[] = {
 	{},
 };
 
+/* Callbacks for hwmon interface */
+static umode_t ayaneo_ec_hwmon_is_visible(const void *drvdata,
+				       enum hwmon_sensor_types type, u32 attr,
+				       int channel)
+{
+	switch (type) {
+	case hwmon_fan:
+		return 0444;
+	case hwmon_pwm:
+		return 0644;
+	default:
+		return 0;
+	}
+}
+
+static int ayaneo_ec_read(struct device *dev, enum hwmon_sensor_types type,
+			     u32 attr, int channel, long *val)
+{
+	u8 tmp;
+	int ret;
+
+	switch (type) {
+	case hwmon_fan:
+		switch (attr) {
+		case hwmon_fan_input:
+			ret = ec_read(AYANEO_FAN_REG, &tmp);
+			if (ret)
+				return ret;
+			*val = tmp << 8;
+			ret = ec_read(AYANEO_FAN_REG + 1, &tmp);
+			if (ret)
+				return ret;
+			*val += tmp;
+			return 0;
+		default:
+			break;
+		}
+		break;
+	case hwmon_pwm:
+		switch (attr) {
+		case hwmon_pwm_input:
+			ret = ec_read(AYANEO_PWM_REG, &tmp);
+			if (ret)
+				return ret;
+			*val = (255 * tmp) / 100;
+			if (*val < 0 || *val > 255)
+				return -EINVAL;
+			return 0;
+		case hwmon_pwm_enable:
+			ret = ec_read(AYANEO_PWM_ENABLE_REG, &tmp);
+			if (ret)
+				return ret;
+			if (tmp == AYANEO_PWM_MODE_MANUAL)
+				*val = 1;
+			else
+				*val = 2;
+			return 0;
+		default:
+			break;
+		}
+		break;
+	default:
+		break;
+	}
+	return -EOPNOTSUPP;
+}
+
+static int ayaneo_ec_write(struct device *dev, enum hwmon_sensor_types type,
+			      u32 attr, int channel, long val)
+{
+	switch (type) {
+	case hwmon_pwm:
+		switch (attr) {
+		case hwmon_pwm_enable:
+			switch (val) {
+			case 1:
+				return ec_write(AYANEO_PWM_ENABLE_REG,
+						AYANEO_PWM_MODE_MANUAL);
+			case 2:
+				return ec_write(AYANEO_PWM_ENABLE_REG,
+						AYANEO_PWM_MODE_AUTO);
+			default:
+				return -EINVAL;
+			}
+		case hwmon_pwm_input:
+			if (val < 0 || val > 255)
+				return -EINVAL;
+			return ec_write(AYANEO_PWM_REG, (val * 100) / 255);
+		default:
+			break;
+		}
+		break;
+	default:
+		break;
+	}
+	return -EOPNOTSUPP;
+}
+
+static const struct hwmon_ops ayaneo_ec_hwmon_ops = {
+	.is_visible = ayaneo_ec_hwmon_is_visible,
+	.read = ayaneo_ec_read,
+	.write = ayaneo_ec_write,
+};
+
+static const struct hwmon_channel_info *const ayaneo_ec_sensors[] = {
+	HWMON_CHANNEL_INFO(fan, HWMON_F_INPUT),
+	HWMON_CHANNEL_INFO(pwm, HWMON_PWM_INPUT | HWMON_PWM_ENABLE),
+	NULL,
+};
+
+static const struct hwmon_chip_info ayaneo_ec_chip_info = {
+	.ops = &ayaneo_ec_hwmon_ops,
+	.info = ayaneo_ec_sensors,
+};
+
 static int ayaneo_ec_probe(struct platform_device *pdev)
 {
 	const struct dmi_system_id *dmi_entry;
 	struct ayaneo_ec_platform_data *data;
+	struct device *hwdev;
 
 	dmi_entry = dmi_first_match(dmi_table);
 	if (!dmi_entry)
@@ -52,6 +179,13 @@ static int ayaneo_ec_probe(struct platform_device *pdev)
 	data->quirks = dmi_entry->driver_data;
 	platform_set_drvdata(pdev, data);
 
+	if (data->quirks->has_fan_control) {
+		hwdev = devm_hwmon_device_register_with_info(
+			&pdev->dev, "ayaneo_ec", NULL, &ayaneo_ec_chip_info, NULL);
+		if (IS_ERR(hwdev))
+			return PTR_ERR(hwdev);
+	}
+
 	return 0;
 }
 
-- 
2.51.0



