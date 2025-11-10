Return-Path: <linux-kernel+bounces-893844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2655CC487B9
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 19:09:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C82E2189108A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 18:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0714B3191C6;
	Mon, 10 Nov 2025 18:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="k0ePDSxe"
Received: from relay11.grserver.gr (relay11.grserver.gr [78.46.171.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C96314D05;
	Mon, 10 Nov 2025 18:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.46.171.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762798142; cv=none; b=duXHqyrcH4xFl3ip1YFq9sYqIxnH4MKed6/elu97UZEkiLm6QBzvU2OtRmH0EkZP9STHlAZ/I7plKmNsNCg3EREK4Vs/J8c+WJXI1Kw9GSwD2Ly7XjLsLBIA+tXckOrRKcT2HHqGfsoHnRvQJ5CbEWHUe1wnlXAzOeErVmNck9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762798142; c=relaxed/simple;
	bh=jT2+rAJec85m4Pksligs+QJYHF/0GzOUbBikFjoA2h4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RUTOZs5F2C1ez3p5U7dSA1JFxOZful4MNQhZHdGdZg4/7ICr4MI9HG8GYmbKKhLNq5Mp6N8/gCFBRp4OQaFkKF71x/YSGdrQ3/PptlRESf8+o04fow5IxVnbi71KHYH7Rh+sVZjAhfXGOTTj3RsDoJItzSCa0MQo/Uumap49XeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=k0ePDSxe; arc=none smtp.client-ip=78.46.171.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from relay11 (localhost.localdomain [127.0.0.1])
	by relay11.grserver.gr (Proxmox) with ESMTP id BE07CC3014;
	Mon, 10 Nov 2025 20:08:52 +0200 (EET)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay11.grserver.gr (Proxmox) with ESMTPS id 29CC3C2CBB;
	Mon, 10 Nov 2025 20:08:52 +0200 (EET)
Received: from antheas-z13 (unknown [IPv6:2a05:f6c2:511b:0:8d8a:5967:d692:ea4e])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id 4E155200B90;
	Mon, 10 Nov 2025 20:08:51 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1762798131;
	bh=UE/BF9u0dcsC8aROs93IpCxBrcSjUBhKEdO3njtxFWI=; h=From:To:Subject;
	b=k0ePDSxevjT8hWjcBMmjUIkgvhjQo3KOutOlr4mUizIXvy9mXK6kr6u5JPiGCSsH3
	 +I8UamPP8xyDBeE/fCJkQZZHXi259Z1Y1xHXVxejQITj+fDcSlOtnuZp9utxaTizfS
	 9r3GmnDiFdwmsrZBgSDsLF6GNFXXNFI7puM+rnM/MzKU2BlVMfePKAHOq4ymlQuqzm
	 WXfsTV8EBoVc30ZO1uQnChez6dsSStSSFT3IRJjZa/379YCQ23yZRdShKWeGx4UDaE
	 ELdbsB2oB2SAdjD8dl3oGLvHSavYzR93o8buzwR1MhkZas/bADcMYHEUBYr84M3rLL
	 vNS77GMogzGJA==
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
	Armin-Wolf <W_Armin@gmx.de>
Subject: [PATCH v4 2/6] platform/x86: ayaneo-ec: Add hwmon support
Date: Mon, 10 Nov 2025 19:08:42 +0100
Message-ID: <20251110180846.1490726-3-lkml@antheas.dev>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251110180846.1490726-1-lkml@antheas.dev>
References: <20251110180846.1490726-1-lkml@antheas.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: 
 <176279813184.3664543.15707535675207559485@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.3 at linux3247.grserver.gr
X-Virus-Status: Clean

Add hwmon single fan sensor reads and control for Ayaneo devices.
The register and method of access is the same for all devices.

Reviewed-by: Armin-Wolf <W_Armin@gmx.de>
Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
---
 drivers/platform/x86/Kconfig     |   2 +
 drivers/platform/x86/ayaneo-ec.c | 136 +++++++++++++++++++++++++++++++
 2 files changed, 138 insertions(+)

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 1a7f8ae793ba..974c174b1a7e 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -318,6 +318,8 @@ config ASUS_TF103C_DOCK
 
 config AYANEO_EC
 	tristate "Ayaneo EC platform control"
+	depends on ACPI_EC
+	depends on HWMON
 	help
 	  Enables support for the platform EC of Ayaneo devices. This
 	  includes fan control, fan speed, charge limit, magic
diff --git a/drivers/platform/x86/ayaneo-ec.c b/drivers/platform/x86/ayaneo-ec.c
index 2fe66c8a89f4..108a23458a4f 100644
--- a/drivers/platform/x86/ayaneo-ec.c
+++ b/drivers/platform/x86/ayaneo-ec.c
@@ -7,14 +7,24 @@
  * Copyright (C) 2025 Antheas Kapenekakis <lkml@antheas.dev>
  */
 
+#include <linux/acpi.h>
 #include <linux/dmi.h>
 #include <linux/err.h>
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
@@ -23,6 +33,7 @@ struct ayaneo_ec_platform_data {
 };
 
 static const struct ayaneo_ec_quirk quirk_ayaneo3 = {
+	.has_fan_control = true,
 };
 
 static const struct dmi_system_id dmi_table[] = {
@@ -36,10 +47,128 @@ static const struct dmi_system_id dmi_table[] = {
 	{},
 };
 
+/* Callbacks for hwmon interface */
+static umode_t ayaneo_ec_hwmon_is_visible(const void *drvdata,
+					  enum hwmon_sensor_types type, u32 attr,
+					  int channel)
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
+			  u32 attr, int channel, long *val)
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
+			if (tmp > 100)
+				return -EIO;
+			*val = (255 * tmp) / 100;
+			return 0;
+		case hwmon_pwm_enable:
+			ret = ec_read(AYANEO_PWM_ENABLE_REG, &tmp);
+			if (ret)
+				return ret;
+			if (tmp == AYANEO_PWM_MODE_MANUAL)
+				*val = 1;
+			else if (tmp == AYANEO_PWM_MODE_AUTO)
+				*val = 2;
+			else
+				return -EIO;
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
+			   u32 attr, int channel, long val)
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
@@ -53,6 +182,13 @@ static int ayaneo_ec_probe(struct platform_device *pdev)
 	data->quirks = dmi_entry->driver_data;
 	platform_set_drvdata(pdev, data);
 
+	if (data->quirks->has_fan_control) {
+		hwdev = devm_hwmon_device_register_with_info(&pdev->dev,
+			"ayaneo_ec", NULL, &ayaneo_ec_chip_info, NULL);
+		if (IS_ERR(hwdev))
+			return PTR_ERR(hwdev);
+	}
+
 	return 0;
 }
 
-- 
2.51.2



