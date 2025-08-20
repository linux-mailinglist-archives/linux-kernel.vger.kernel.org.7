Return-Path: <linux-kernel+bounces-778168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC9EFB2E21E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 18:18:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84AB118946CD
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 16:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C970322DCB;
	Wed, 20 Aug 2025 16:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="Mpk7NkW9"
Received: from relay10.grserver.gr (relay10.grserver.gr [37.27.248.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B8636CE15;
	Wed, 20 Aug 2025 16:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.27.248.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755706463; cv=none; b=aIhypOkOonBalRwvyx6uFi+2mmDlqn+d/2O2s0VxdFSshqgnLcgAZZ156ryHsvckH4+MIFjPwS63+lYwwgKkOycCEdAJVXL+CSG7MJAd0p8NTTY67ye22wej5I5pRddO1Nn+kFtrQfcoSKxbI5ZSHzbsgJuOqDAkwu6lubSwkag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755706463; c=relaxed/simple;
	bh=jlw6eb/npySk95Pgm3mazx5MZCLoghLMeP5mbM9vroU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fTLsWFHFGSy8iemoZQA+7Oa7WZLvBwZANztg9jNseWrJPolZSQr6bw/tTmF5r4+bzWQGOQdkz3IZg3s4NbetBRSBi6+7crWGO1HnNPSo2LwshomKu/p1nTluOA9tIfIKq60HN4AS6n7z1N8Du6uvQmy32VvagGyncPFN/bDRQDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=Mpk7NkW9; arc=none smtp.client-ip=37.27.248.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from relay10 (localhost.localdomain [127.0.0.1])
	by relay10.grserver.gr (Proxmox) with ESMTP id 7CC02467ED;
	Wed, 20 Aug 2025 19:06:33 +0300 (EEST)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay10.grserver.gr (Proxmox) with ESMTPS id D2CD24236A;
	Wed, 20 Aug 2025 19:06:32 +0300 (EEST)
Received: from antheas-z13 (unknown [IPv6:2a05:f6c2:511b:0:7200:c86a:8976:4786])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id D9C0720638D;
	Wed, 20 Aug 2025 19:06:31 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1755705992;
	bh=hsSk4r8iuluSzpP/KO4eAbRVqzRjXz2ofuhwVybQrZ0=; h=From:To:Subject;
	b=Mpk7NkW9B/PNBSibUr15GBw4/xUxh+rZoX+GujnXMDZhP2AzDc4YNBGVHe4bqjCY/
	 dGHZWmWR+bgiciazPu7fzVwA7VqHJ6FG8gooe8/Z5zhYA5EZxmMvWnJu8BIJvgy6UV
	 bqvjuS6aJsZ/Lm/0tDYbEvmepROKDk98yaVVFPlNCBFpL5WWiijw+XeQt1D24y1rDe
	 22P4gjFQdKT/ASX5slk+tEG8lGJWMYEgQRGsrSv1HIqY7ayi3khsw4d5bHNisjS4Ou
	 V/DT5X57vv64cocz10LULBvEMwtTcBFIemhkj8VA1e0sRdL0D9MZ4KurPXiM74NK7N
	 UAFbPES3pEGhw==
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
Subject: [PATCH v1 2/5] platform/x86: ayaneo-ec: Add hwmon support
Date: Wed, 20 Aug 2025 18:06:25 +0200
Message-ID: <20250820160628.99678-3-lkml@antheas.dev>
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
 <175570599240.2162693.14366500508778981372@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.3 at linux3247.grserver.gr
X-Virus-Status: Clean

Add hwmon single fan sensor reads and control for Ayaneo devices.
The register and method of access is the same for all devices.

Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
---
 drivers/platform/x86/Kconfig     |   2 +
 drivers/platform/x86/ayaneo-ec.c | 132 +++++++++++++++++++++++++++++++
 2 files changed, 134 insertions(+)

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 6d4a33791cc1..0a7ca2c78456 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -307,6 +307,8 @@ config ASUS_TF103C_DOCK
 config AYANEO_EC
 	tristate "Ayaneo EC platform control"
 	depends on X86
+	depends on ACPI_EC
+	depends on HWMON
 	help
 	  Enables support for the platform EC of Ayaneo devices. This
 	  includes fan control, fan speed, charge limit, magic
diff --git a/drivers/platform/x86/ayaneo-ec.c b/drivers/platform/x86/ayaneo-ec.c
index 90b86527ab0d..8b1902706b81 100644
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
@@ -35,10 +46,124 @@ static const struct dmi_system_id dmi_table[] = {
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
+			if (val == 1)
+				return ec_write(AYANEO_PWM_ENABLE_REG,
+						AYANEO_PWM_MODE_MANUAL);
+			else if (val == 2)
+				return ec_write(AYANEO_PWM_ENABLE_REG,
+						AYANEO_PWM_MODE_AUTO);
+			else
+				return -EINVAL;
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
@@ -52,6 +177,13 @@ static int ayaneo_ec_probe(struct platform_device *pdev)
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
2.50.1



