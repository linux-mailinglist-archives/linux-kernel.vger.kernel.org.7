Return-Path: <linux-kernel+bounces-893841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14A97C487B1
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 19:09:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 258B33A439A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 18:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D08EC314B73;
	Mon, 10 Nov 2025 18:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="Jn/T6OQK"
Received: from relay13.grserver.gr (relay13.grserver.gr [178.156.171.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549B52E92BA;
	Mon, 10 Nov 2025 18:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.156.171.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762798139; cv=none; b=tZ9qWKTV/9Lj3RT+UtUhAIn2RIKU6WJiCgDXlGampgDZZrqVaOUD05oTeGYaPhyOAwJtXKtTmuh6d9ZdluI4TbQwlQxGkqMzTWiUOg2IPXQViTyeKt3BDGhSYpWM600uT9RlmWjw46/sbKCsYGLSNR7Vfk93Ncd4i6XMH9RlrWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762798139; c=relaxed/simple;
	bh=ZQuJNwIZQjYCB2Ur2PhZH1//YriBqukPRRd0WBh99gc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CZ49HVcB2vgib7WD0AfxsZkXu6lMQLd6N2P6E+H1UQvlOnRfOXbrXQ5BVVhO83E5Q/dDnatc4rsaZAe0M//u2xNXw5wKDHUgAI5nUGIIQq/Tyji2GgJvydI6usDhvEgZuuJYir1xLjbxDgXA02NdNe65pQgN6p5Jc/KNj//fzG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=Jn/T6OQK; arc=none smtp.client-ip=178.156.171.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from relay13 (localhost [127.0.0.1])
	by relay13.grserver.gr (Proxmox) with ESMTP id 99E385E620;
	Mon, 10 Nov 2025 20:08:56 +0200 (EET)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay13.grserver.gr (Proxmox) with ESMTPS id E2B5D5E612;
	Mon, 10 Nov 2025 20:08:55 +0200 (EET)
Received: from antheas-z13 (unknown [IPv6:2a05:f6c2:511b:0:8d8a:5967:d692:ea4e])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id 932D61FE461;
	Mon, 10 Nov 2025 20:08:54 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1762798135;
	bh=r5vFPIuIqw2Ozjx2rDjoRsAOF4F3nnf121dTH3jiqOk=; h=From:To:Subject;
	b=Jn/T6OQKO86JxAmfufGVkQpEnV6fWJxiVtniEn8FhDAAx4GPsMumFhzSHSkSFFgLy
	 7rYLc/6tm56cUywBA2lFX969u3EPhSWq95UzXDY9TaGm16bCiae4P76tnSkfDsPV3+
	 5Z6ZSqCEaQLJZ22nRo69F160c4+L+b4j5WE20YZi2efONj0QgJx0n1MEoy7DJXMPLh
	 ri8+WEASGT5MzQDiyC37b4fiuXW9u0S4yF5YY07kR1VhXLWk+boDoK1SKMWyTE3g4Y
	 AUEPNUGvK8irmF8gy17IWw7yRCNj3Bpa5TA1+Qtwp8g8BUTp1aTKOdsKwLCAL+pNML
	 fsjXuTNiDnCrA==
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
	Antheas Kapenekakis <lkml@antheas.dev>
Subject: [PATCH v4 6/6] platform/x86: ayaneo-ec: Add suspend hook
Date: Mon, 10 Nov 2025 19:08:46 +0100
Message-ID: <20251110180846.1490726-7-lkml@antheas.dev>
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
 <176279813508.3664791.15761385760381332320@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.3 at linux3247.grserver.gr
X-Virus-Status: Clean

The Ayaneo EC resets after hibernation, losing the charge control state.
Add a small PM hook to restore this state on hibernation resume.

The fan speed is also lost during hibernation, but since hibernation
failures are common with this class of devices, setting a low fan speed
when the userspace program controlling the fan will potentially not
take over could cause the device to overheat, so it is not restored.

Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
---
 drivers/platform/x86/ayaneo-ec.c | 84 +++++++++++++++++++++++++++++++-
 1 file changed, 83 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/ayaneo-ec.c b/drivers/platform/x86/ayaneo-ec.c
index 9548e3d22093..ee97c326c429 100644
--- a/drivers/platform/x86/ayaneo-ec.c
+++ b/drivers/platform/x86/ayaneo-ec.c
@@ -51,6 +51,11 @@ struct ayaneo_ec_platform_data {
 	struct platform_device *pdev;
 	struct ayaneo_ec_quirk *quirks;
 	struct acpi_battery_hook battery_hook;
+
+	// Protects access to restore_pwm
+	struct mutex hwmon_lock;
+	bool restore_charge_limit;
+	bool restore_pwm;
 };
 
 static const struct ayaneo_ec_quirk quirk_fan = {
@@ -207,10 +212,16 @@ static int ayaneo_ec_read(struct device *dev, enum hwmon_sensor_types type,
 static int ayaneo_ec_write(struct device *dev, enum hwmon_sensor_types type,
 			   u32 attr, int channel, long val)
 {
+	struct ayaneo_ec_platform_data *data = dev_get_drvdata(dev);
+	int ret;
+
+	guard(mutex)(&data->hwmon_lock);
+
 	switch (type) {
 	case hwmon_pwm:
 		switch (attr) {
 		case hwmon_pwm_enable:
+			data->restore_pwm = false;
 			switch (val) {
 			case 1:
 				return ec_write(AYANEO_PWM_ENABLE_REG,
@@ -224,6 +235,17 @@ static int ayaneo_ec_write(struct device *dev, enum hwmon_sensor_types type,
 		case hwmon_pwm_input:
 			if (val < 0 || val > 255)
 				return -EINVAL;
+			if (data->restore_pwm) {
+				/*
+				 * Defer restoring PWM control to after
+				 * userspace resumes successfully
+				 */
+				ret = ec_write(AYANEO_PWM_ENABLE_REG,
+					       AYANEO_PWM_MODE_MANUAL);
+				if (ret)
+					return ret;
+				data->restore_pwm = false;
+			}
 			return ec_write(AYANEO_PWM_REG, (val * 100) / 255);
 		default:
 			break;
@@ -453,11 +475,14 @@ static int ayaneo_ec_probe(struct platform_device *pdev)
 
 	data->pdev = pdev;
 	data->quirks = dmi_entry->driver_data;
+	ret = devm_mutex_init(&pdev->dev, &data->hwmon_lock);
+	if (ret)
+		return ret;
 	platform_set_drvdata(pdev, data);
 
 	if (data->quirks->has_fan_control) {
 		hwdev = devm_hwmon_device_register_with_info(&pdev->dev,
-			"ayaneo_ec", NULL, &ayaneo_ec_chip_info, NULL);
+			"ayaneo_ec", data, &ayaneo_ec_chip_info, NULL);
 		if (IS_ERR(hwdev))
 			return PTR_ERR(hwdev);
 	}
@@ -474,10 +499,67 @@ static int ayaneo_ec_probe(struct platform_device *pdev)
 	return 0;
 }
 
+static int ayaneo_freeze(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct ayaneo_ec_platform_data *data = platform_get_drvdata(pdev);
+	int ret;
+	u8 tmp;
+
+	if (data->quirks->has_charge_control) {
+		ret = ec_read(AYANEO_CHARGE_REG, &tmp);
+		if (ret)
+			return ret;
+
+		data->restore_charge_limit = tmp == AYANEO_CHARGE_VAL_INHIBIT;
+	}
+
+	if (data->quirks->has_fan_control) {
+		ret = ec_read(AYANEO_PWM_ENABLE_REG, &tmp);
+		if (ret)
+			return ret;
+
+		data->restore_pwm = tmp == AYANEO_PWM_MODE_MANUAL;
+
+		/*
+		 * Release the fan when entering hibernation to avoid
+		 * overheating if hibernation fails and hangs.
+		 */
+		if (data->restore_pwm) {
+			ret = ec_write(AYANEO_PWM_ENABLE_REG, AYANEO_PWM_MODE_AUTO);
+			if (ret)
+				return ret;
+		}
+	}
+
+	return 0;
+}
+
+static int ayaneo_restore(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct ayaneo_ec_platform_data *data = platform_get_drvdata(pdev);
+	int ret;
+
+	if (data->quirks->has_charge_control && data->restore_charge_limit) {
+		ret = ec_write(AYANEO_CHARGE_REG, AYANEO_CHARGE_VAL_INHIBIT);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static const struct dev_pm_ops ayaneo_pm_ops = {
+	.freeze = ayaneo_freeze,
+	.restore = ayaneo_restore,
+};
+
 static struct platform_driver ayaneo_platform_driver = {
 	.driver = {
 		.name = "ayaneo-ec",
 		.dev_groups = ayaneo_ec_groups,
+		.pm = &ayaneo_pm_ops,
 	},
 	.probe = ayaneo_ec_probe,
 };
-- 
2.51.2



