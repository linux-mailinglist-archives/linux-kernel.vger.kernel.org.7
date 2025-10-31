Return-Path: <linux-kernel+bounces-880621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id F2D2DC26261
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 17:37:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 71F8D351ED2
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 16:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3D112ECD31;
	Fri, 31 Oct 2025 16:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="YHOLOb8C"
Received: from relay10.grserver.gr (relay10.grserver.gr [37.27.248.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19E9A296159;
	Fri, 31 Oct 2025 16:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.27.248.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761928625; cv=none; b=n2D3lIU8eEtTnUYkyyHvmFwRCDiB3pq5JRPm0pGTqdXXxaVlZzzPRmWqh6MDSNz5ULzOijIKGdLfiQicDPzt7bTTwKtjnfXb16ywYUYJGOjMdkJttsJkK7rC+SmBEsRT8GA8EH5dum30qvvqZjxOQaPf4D4dB2IZuV9EsqoegBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761928625; c=relaxed/simple;
	bh=5/MkzF4b0enGlcC8P6GU9B36DychBhk89uhfjulbGpA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OLpRW76oAATTLOBZTnOxBJhfwFs7nX4vBCIOFWemPmYCEVJ0JkAY9Tt+9f5dk/905h8nPlkJhz2yy6TYOT2e4g54sQtyY/wSGNA7SzF3MVLUEX63hz7SOn1HS9rLYlhC7gjpdW0o5Av1WyRI74QGycYX4gBcdg3UgQ2jSqm3ngU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=YHOLOb8C; arc=none smtp.client-ip=37.27.248.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from relay10 (localhost.localdomain [127.0.0.1])
	by relay10.grserver.gr (Proxmox) with ESMTP id 58E6D464D1;
	Fri, 31 Oct 2025 18:37:00 +0200 (EET)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay10.grserver.gr (Proxmox) with ESMTPS id D6A6E45F00;
	Fri, 31 Oct 2025 18:36:59 +0200 (EET)
Received: from antheas-z13 (unknown [IPv6:2a05:f6c2:511b:0:8d8a:5967:d692:ea4e])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id D801E200C43;
	Fri, 31 Oct 2025 18:36:58 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1761928619;
	bh=eaCcJl1/Nu0H6MYEFWCb5trAxgrURxKusB7XqUtYWpw=; h=From:To:Subject;
	b=YHOLOb8C5iZo7FcEwOLHEQnbtpDuP6hUOLS3cg6FUQWvmUcj8MMY82W6iHORlcADt
	 SMUcCwb1GUerLPgo6C0l4UQq5m29hX6fUaCC5QNC5eD0zVzPSLLgSfU7/lEL3gWHCN
	 HPv4eKFLZlU2qR9LA9LJHbiapFb4ruZ8hKQ76VYlRWO6d4Q5JkUTtYrLvQ2zr22TTC
	 prpZAXnmAnZKEFvauF48wTmgYxMZQyp6CmEu1hr0HRsnoNrjRByvff6PusXcp+qQZU
	 EhY9gjtPwGN8g0SJEiBPFJEcmrXNVb5SsJwwrzwTZUMH6fkhACVmAZ1NJr2zBneNv4
	 MsxfpHRVm4m7A==
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
Subject: [PATCH v3 6/6] platform/x86: ayaneo-ec: Add suspend hook
Date: Fri, 31 Oct 2025 17:36:51 +0100
Message-ID: <20251031163651.1465981-7-lkml@antheas.dev>
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
 <176192861939.3949331.11112013268147092094@linux3247.grserver.gr>
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
 drivers/platform/x86/ayaneo-ec.c | 73 ++++++++++++++++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/drivers/platform/x86/ayaneo-ec.c b/drivers/platform/x86/ayaneo-ec.c
index 9548e3d22093..e1ad5968d3b4 100644
--- a/drivers/platform/x86/ayaneo-ec.c
+++ b/drivers/platform/x86/ayaneo-ec.c
@@ -41,6 +41,8 @@
 #define AYANEO_MODULE_LEFT	BIT(0)
 #define AYANEO_MODULE_RIGHT	BIT(1)
 
+#define AYANEO_CACHE_LEN	1
+
 struct ayaneo_ec_quirk {
 	bool has_fan_control;
 	bool has_charge_control;
@@ -51,6 +53,9 @@ struct ayaneo_ec_platform_data {
 	struct platform_device *pdev;
 	struct ayaneo_ec_quirk *quirks;
 	struct acpi_battery_hook battery_hook;
+
+	bool restore_charge_limit;
+	bool restore_pwm;
 };
 
 static const struct ayaneo_ec_quirk quirk_fan = {
@@ -207,10 +212,14 @@ static int ayaneo_ec_read(struct device *dev, enum hwmon_sensor_types type,
 static int ayaneo_ec_write(struct device *dev, enum hwmon_sensor_types type,
 			   u32 attr, int channel, long val)
 {
+	struct ayaneo_ec_platform_data *data = platform_get_drvdata(
+		to_platform_device(dev));
+	int ret;
 	switch (type) {
 	case hwmon_pwm:
 		switch (attr) {
 		case hwmon_pwm_enable:
+			data->restore_pwm = false;
 			switch (val) {
 			case 1:
 				return ec_write(AYANEO_PWM_ENABLE_REG,
@@ -224,6 +233,15 @@ static int ayaneo_ec_write(struct device *dev, enum hwmon_sensor_types type,
 		case hwmon_pwm_input:
 			if (val < 0 || val > 255)
 				return -EINVAL;
+			if (data->restore_pwm) {
+				// Defer restoring PWM control to after
+				// userspace resumes successfully
+				ret = ec_write(AYANEO_PWM_ENABLE_REG,
+					       AYANEO_PWM_MODE_MANUAL);
+				if (ret)
+					return ret;
+				data->restore_pwm = false;
+			}
 			return ec_write(AYANEO_PWM_REG, (val * 100) / 255);
 		default:
 			break;
@@ -474,10 +492,65 @@ static int ayaneo_ec_probe(struct platform_device *pdev)
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
+		// Release the fan when entering hibernation to avoid
+		// overheating if hibernation fails and hangs
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
2.51.1



