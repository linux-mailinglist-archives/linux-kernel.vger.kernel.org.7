Return-Path: <linux-kernel+bounces-746601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AD762B128D0
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 05:39:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE8F97A3D93
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 03:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49DB520125F;
	Sat, 26 Jul 2025 03:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ReHpKknc"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CDEE1F17EB;
	Sat, 26 Jul 2025 03:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753501131; cv=none; b=fEg9JDSwPFHfIlG9k/BJa/+EnfWNkp8NyqGb3nGujLAEdJSA1d2Q88B+rzWuCRcntv05nlufhC1He1QKDMT/WI7b+CJjcrzBheExU3znZ5nqMO3yH98NKLVVxNqZTevMlbV1KQssgXc97MOIk2Ik50ptxSANgOmlV3CsZtBRvOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753501131; c=relaxed/simple;
	bh=qMccuERQ2VERfK2KQwVm7Eq1mAauLj8r33/cRrV624I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cWP+Zpkt99A2psKVMmVQOqHel5pW1iyIMZvYJOcZ0Uuz6tB/vGRBl1LXmDJs6HhRgTbzUi20zwCwJQpBy9tUxuznTosgGOwvQFZvOd81JCAbw8BnWaiDNfVnEgOyji/8cOo8C5ojsAeGoL+BwCbrOinJl3c2UjA0zd1jPZQjzZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ReHpKknc; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b3220c39cffso2901432a12.0;
        Fri, 25 Jul 2025 20:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753501129; x=1754105929; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YM1d0/lGL1+75gVv7USWsP7dD2kt+Rmlur8V9H1htiE=;
        b=ReHpKkncIU0ZzHK/JLchScDdAc80hzdgIUzqNPudSLz6NtUwNAQjRZwhJkdIqrIQHL
         rxTVB7gaYNd492Qlvxw+FdfOT1FzTsBM7mnubOUadwxeOAPo/YZsWteFsT4xSQWrD2sU
         5QibrQXwH7Wte3rAJOnQjCknK+ALp6eTCMH2gUbCBMtsW+niz47A+5ILgU04fDMf8asw
         7jqPlwzgo/HAuy5dTVgcKodNOsWM7tVnO97e5SOR6oBc2ptgIyTdro/osyvRsd8QfQPQ
         LqxN5673W94flFtmD1eXzzCJk60GWZQTL4ri8Ecysj9NZ/oSm6K/okp/5er5XD+rYTPu
         d9XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753501129; x=1754105929;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YM1d0/lGL1+75gVv7USWsP7dD2kt+Rmlur8V9H1htiE=;
        b=EIOvMTgrl1vC5RHjBhETyBlrV/SbLHObQxmxLDFTFO0nKyjIsPKRerhq+sdCF8mN55
         gFOQEttOH6c9OBOPquQawgz5tJCLiLjB3yR6zxL5lW+zSpPB+qaTqGKntQ0Hfd3MG0+w
         8fKlS7nCQJkCd/5SMK8IldkEIvIaEuU2qajEWE3TeE6DPSS3GCDic7qexvwZSYPaURwo
         vObcwSmt4C66TB3molFERG1dTNwmzNhfAuIGstiWqobTGnr/idCZS15nWlaQ2Xamvdn2
         hd/Seiqnnbo2BQ0xQlD1ZL6b1LFltwbh0pkQD1pAcQ0g87E2F2FEDhb+z1sCy0y/aonh
         5NRw==
X-Forwarded-Encrypted: i=1; AJvYcCUb6le83+cZwH4dIA0CQBdeivp0TCZKze5Y6MnEfYhmaRuRwRHNKpLQlkJhrLFiXkIW2GkjVI2CWmjjdZCLrfYjwvo1Mg==@vger.kernel.org, AJvYcCWcwfHHikSFbQ/U7tjNsw9UWR9GedW3ub7b9Z4dNDuuq2edmG8phWjKKHi9lVVDxpvR7L03B8kT8WJl8lcB@vger.kernel.org, AJvYcCXCvldZus8/4DLAKmzl/vFQbs96DtFZJ95SUREFWHebP7rox57uUlMuqvAIPUo7+duoUzrMzSDJVvh3VvM=@vger.kernel.org, AJvYcCXjhGjnF2Sn1Y6+0bFNrKny+2jICCRayZ07DwM8hPMpYqKuts7h+7FJimJviiRbenFrNq76YVwInYg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuICIK0JgzYXYHBQq8BcUymEu2agkbDmWawz6mzxn+MBW/mjlL
	j/Zh4lrexpOoiv0VpPbCFK+Q9YzMfsVZxe12eEialPb/wcdusnaUB3JYQU0OSg==
X-Gm-Gg: ASbGncvuFo0iMeoS9IdX0f4pCMtR0dfZIvKY0Q9/nX3suk/hSX+b64UzMKiLZzoU2sa
	9Jc+tmm/xx9vD/qk4wC5Hze2aXgWhxx8Wi+r9QWK8KKrE/bq5zO9Ft2IW5GMPlqdM1DJt2gTibS
	nnUTCJBnchPbZZHa5o+9hpZ5/wkCQ/xoI4pAz6iiV6ay94dZD/qpEf/Xx1tju3NQzYDkI7XIH09
	YcTAqjpLXCiPQAPYvVxKOZsQ8v/QC0Gu/UQ5sRIUxNWdIamyGOQmkUE/WNwJvxlYMryDhOqAsHb
	cPLN4Ka+PW5OcJ7GYC/DlTqVGpDj0TKqjjfSlFXxQkwU9c5p3d0FalD6IDsvinBxD9y025OwLgb
	aSsGUm60KwhUlS+YpD6ISZ7/ZTZac0WTtZXeR8EPSoGHwaW16HHeYA6G2cVxXMRxBOurdCQAYb8
	c+fwtGc82WpP6w
X-Google-Smtp-Source: AGHT+IEOv3C4wSNmSjsRBU2Egsl0G/lGSmF/VtbOk5540yQjUw6S+QEtrrTP16UZ1SgsM3ftK9kjiw==
X-Received: by 2002:a05:6a20:3ca5:b0:232:57c8:1bf4 with SMTP id adf61e73a8af0-23d700164ebmr6365956637.9.1753501128714;
        Fri, 25 Jul 2025 20:38:48 -0700 (PDT)
Received: from bliptop (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31e832f8942sm779204a91.4.2025.07.25.20.38.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 20:38:48 -0700 (PDT)
From: "Derek J. Clark" <derekjohn.clark@gmail.com>
To: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Hans de Goede <hansg@kernel.org>
Cc: Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Alok Tiwari <alok.a.tiwari@oracle.com>,
	"Derek J . Clark" <derekjohn.clark@gmail.com>,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH v2 3/4] platform/x86: (ayn-ec) Add RGB Interface
Date: Fri, 25 Jul 2025 20:38:40 -0700
Message-ID: <20250726033841.7474-4-derekjohn.clark@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250726033841.7474-1-derekjohn.clark@gmail.com>
References: <20250726033841.7474-1-derekjohn.clark@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adds an EC controlled LED Multicolor Class Device for controlling the
RGB rings around the joysticks.

The EC provides a single register for each of the colors red, green, and
blue, as well as a mode switching register. The EC accepts values
[0-255] for all colors. There are two available effects: breathe, which is
the default when the device is started, and monocolor. When resuming from
sleep the user selected effect will be overwritten by the EC, so the
driver retains the last setting and resets on resume. When setting a
color, each color register is set before a final "write" code is sent to
the device. The EC may briefly reflect the "write" code when writing, but
quickly changes to the "monocolor" value once complete. The driver
interprets both of these values as "monocolor" in _show to simplify the
sysfs exposed to the user.

Two custom attributes are added to the standard LED parent device:
effect, a RW file descriptor used to set the effect, and effect_index,
which enumerates the available valid options.

Signed-off-by: Derek J. Clark <derekjohn.clark@gmail.com>
---
 drivers/platform/x86/ayn-ec.c | 283 ++++++++++++++++++++++++++++++++++
 1 file changed, 283 insertions(+)

diff --git a/drivers/platform/x86/ayn-ec.c b/drivers/platform/x86/ayn-ec.c
index 3b4daa7603ee..3bede03a60fe 100644
--- a/drivers/platform/x86/ayn-ec.c
+++ b/drivers/platform/x86/ayn-ec.c
@@ -28,6 +28,8 @@
 #include <linux/hwmon.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
+#include <linux/led-class-multicolor.h>
+#include <linux/leds.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/sysfs.h>
@@ -57,6 +59,17 @@
 #define AYN_SENSOR_PROC_TEMP_REG	0x09 /* CPU Core */
 #define AYN_SENSOR_VCORE_TEMP_REG	0x08 /* vCore */
 
+/* EC Controlled RGB registers */
+#define AYN_LED_MC_RED_REG	0xB0 /* Range 0x00-0xFF */
+#define AYN_LED_MC_GREEN_REG	0xB1 /* Range 0x00-0xFF */
+#define AYN_LED_MC_BLUE_REG	0xB2 /* Range 0x00-0xFF */
+#define AYN_RGB_EFFECT_REG	0xB3
+
+/* RGB effect modes */
+#define AYN_RGB_EFFECT_BREATHE		0x00
+#define AYN_RGB_EFFECT_MONOCOLOR	0x55
+#define AYN_RGB_EFFECT_WRITE		0xAA
+
 /* Handle ACPI lock mechanism */
 #define ACPI_LOCK_DELAY_MS 500
 
@@ -68,7 +81,9 @@ enum ayn_model {
 };
 
 struct ayn_device {
+	struct led_classdev *led_cdev;
 	u32 ayn_lock; /* ACPI EC Lock */
+	u8 rgb_effect;
 } drvdata;
 
 struct thermal_sensor {
@@ -85,6 +100,30 @@ static struct thermal_sensor thermal_sensors[] = {
 	{}
 };
 
+/* RGB effect values */
+enum RGB_EFFECT_OPTION {
+	BREATHE,
+	MONOCOLOR,
+};
+
+static const char *const RGB_EFFECT_TEXT[] = {
+	[BREATHE] = "breathe",
+	[MONOCOLOR] = "monocolor",
+};
+
+#define DEVICE_ATTR_RW_NAMED(_name, _attrname)               \
+	struct device_attribute dev_attr_##_name = {         \
+		.attr = { .name = _attrname, .mode = 0644 }, \
+		.show = _name##_show,                        \
+		.store = _name##_store,                      \
+	}
+
+#define DEVICE_ATTR_RO_NAMED(_name, _attrname)               \
+	struct device_attribute dev_attr_##_name = {         \
+		.attr = { .name = _attrname, .mode = 0444 }, \
+		.show = _name##_show,                        \
+	}
+
 /* Handle ACPI lock mechanism */
 #define ACPI_LOCK_DELAY_MS 500
 
@@ -606,10 +645,253 @@ static struct attribute *ayn_sensors_attrs[] = {
 
 ATTRIBUTE_GROUPS(ayn_sensors);
 
+/**
+ * rgb_effect_write() - Set the RGB effect stored in drvdata.rgb_effect.
+ */
+static int rgb_effect_write(void)
+{
+	return write_to_ec(AYN_RGB_EFFECT_REG, drvdata.rgb_effect);
+};
+
+/**
+ * rgb_effect_read() - Read the RGB effect and store it in drvdata.rgb_effect.
+ */
+static int rgb_effect_read(void)
+{
+	int ret;
+	long effect;
+
+	ret = read_from_ec(AYN_RGB_EFFECT_REG, 1, &effect);
+	if (ret)
+		return ret;
+
+	switch (effect) {
+	case AYN_RGB_EFFECT_WRITE:
+	case AYN_RGB_EFFECT_MONOCOLOR:
+		drvdata.rgb_effect = AYN_RGB_EFFECT_WRITE;
+		break;
+	default:
+		drvdata.rgb_effect = AYN_RGB_EFFECT_BREATHE;
+	}
+
+	return 0;
+}
+
+/**
+ * rgb_effect_store() - Store the given RGB effect and set it.
+ *
+ * @dev: parent device of the given attribute.
+ * @attr: The attribute to write to.
+ * @buf: Input value string from sysfs write.
+ * @count: The number of bytes written.
+ *
+ * Return: The number of bytes written, or an error.
+ */
+static ssize_t rgb_effect_store(struct device *dev,
+				struct device_attribute *attr, const char *buf,
+				size_t count)
+{
+	int ret;
+
+	ret = sysfs_match_string(RGB_EFFECT_TEXT, buf);
+	if (ret < 0)
+		return ret;
+
+	if (ret)
+		drvdata.rgb_effect = AYN_RGB_EFFECT_WRITE;
+	else
+		drvdata.rgb_effect = AYN_RGB_EFFECT_BREATHE;
+
+	ret = rgb_effect_write();
+	if (ret)
+		return ret;
+
+	return count;
+};
+
+/**
+ * rgb_effect_show() - Read the current RGB effect.
+ *
+ * @dev: parent device of the given attribute.
+ * @attr: The attribute to read.
+ * @buf: Buffer to read to.
+ *
+ * Return: The number of bytes read, or an error.
+ */
+static ssize_t rgb_effect_show(struct device *dev,
+			       struct device_attribute *attr, char *buf)
+{
+	int ret, i;
+
+	ret = rgb_effect_read();
+	if (ret)
+		return ret;
+
+	switch (drvdata.rgb_effect) {
+	case AYN_RGB_EFFECT_WRITE:
+	case AYN_RGB_EFFECT_MONOCOLOR:
+		i = MONOCOLOR;
+		break;
+	default:
+		i = BREATHE;
+		break;
+	}
+
+	return sysfs_emit(buf, "%s\n", RGB_EFFECT_TEXT[i]);
+};
+
+static DEVICE_ATTR_RW_NAMED(rgb_effect, "effect");
+
+/**
+ * rgb_effect_show() - Display the RGB effects available.
+ *
+ * @dev: parent device of the given attribute.
+ * @attr: The attribute to read.
+ * @buf: Buffer to read to.
+ *
+ * Return: The number of bytes read, or an error.
+ */
+static ssize_t rgb_effect_index_show(struct device *dev,
+				     struct device_attribute *attr, char *buf)
+{
+	size_t count = 0;
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(RGB_EFFECT_TEXT); i++)
+		count += sysfs_emit_at(buf, count, "%s ", RGB_EFFECT_TEXT[i]);
+
+	buf[count - 1] = '\n';
+
+	return count;
+}
+
+static DEVICE_ATTR_RO_NAMED(rgb_effect_index, "effect_index");
+
+/**
+ * ayn_led_mc_brightness_set() - Write the brightness for the RGB LED.
+ *
+ * @led_cdev: Parent LED device for the led_classdev_mc.
+ * @brightness: Brightness value to write [0-255].
+ */
+static void ayn_led_mc_brightness_set(struct led_classdev *led_cdev,
+				      enum led_brightness brightness)
+{
+	struct led_classdev_mc *led_cdev_mc = lcdev_to_mccdev(led_cdev);
+	struct mc_subled s_led;
+	int i, ret, val;
+
+	switch (drvdata.rgb_effect) {
+	case AYN_RGB_EFFECT_WRITE:
+	case AYN_RGB_EFFECT_MONOCOLOR:
+		break;
+	case AYN_RGB_EFFECT_BREATHE:
+		return;
+	}
+
+	led_cdev->brightness = brightness;
+	for (i = 0; i < led_cdev_mc->num_colors; i++) {
+		s_led = led_cdev_mc->subled_info[i];
+		val = brightness * s_led.intensity / led_cdev->max_brightness;
+		ret = write_to_ec(s_led.channel, val);
+		if (ret) {
+			dev_err(led_cdev->dev,
+				"Error setting brightness:  %d\n", ret);
+			return;
+		}
+	}
+
+	/* Must write mode again to change to set color */
+	write_to_ec(AYN_RGB_EFFECT_REG, AYN_RGB_EFFECT_WRITE);
+};
+
+/**
+ * ayn_led_mc_brightness_get() - Get the brightness for the RGB LED.
+ *
+ * @led_cdev: Parent LED device for the led_classdev_mc.
+ *
+ * Return: Current brightness.
+ */
+static enum led_brightness ayn_led_mc_brightness_get(struct led_classdev *led_cdev)
+{
+	return led_cdev->brightness;
+};
+
+static struct attribute *ayn_led_mc_attrs[] = {
+	&dev_attr_rgb_effect.attr,
+	&dev_attr_rgb_effect_index.attr,
+	NULL,
+};
+
+static struct attribute_group ayn_led_mc_group = {
+	.attrs = ayn_led_mc_attrs,
+};
+
+struct mc_subled ayn_led_mc_subled_info[] = {
+	{
+		.color_index = LED_COLOR_ID_RED,
+		.brightness = 0,
+		.intensity = 0,
+		.channel = AYN_LED_MC_RED_REG,
+	},
+	{
+		.color_index = LED_COLOR_ID_GREEN,
+		.brightness = 0,
+		.intensity = 0,
+		.channel = AYN_LED_MC_GREEN_REG,
+	},
+	{
+		.color_index = LED_COLOR_ID_BLUE,
+		.brightness = 0,
+		.intensity = 0,
+		.channel = AYN_LED_MC_BLUE_REG,
+	},
+};
+
+struct led_classdev_mc ayn_led_mc = {
+	.led_cdev = {
+		.name = "ayn:rgb:joystick_rings",
+		.brightness = 0,
+		.max_brightness = 255,
+		.brightness_set = ayn_led_mc_brightness_set,
+		.brightness_get = ayn_led_mc_brightness_get,
+		.color = LED_COLOR_ID_RGB,
+	},
+	.num_colors = ARRAY_SIZE(ayn_led_mc_subled_info),
+	.subled_info = ayn_led_mc_subled_info,
+};
+
+static int ayn_ec_resume(struct platform_device *pdev)
+{
+	struct led_classdev *led_cdev = drvdata.led_cdev;
+	int ret;
+
+	ret = rgb_effect_write();
+	if (ret)
+		return ret;
+
+	ayn_led_mc_brightness_set(led_cdev, led_cdev->brightness);
+
+	return 0;
+}
+
 static int ayn_ec_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct device *hwdev;
+	int ret;
+
+	ret = devm_led_classdev_multicolor_register(dev, &ayn_led_mc);
+	if (ret)
+		return ret;
+
+	ret = devm_device_add_group(ayn_led_mc.led_cdev.dev, &ayn_led_mc_group);
+	if (ret)
+		return ret;
+
+	drvdata.led_cdev = &ayn_led_mc.led_cdev;
+	ret = rgb_effect_read();
+	if (ret)
+		return ret;
 
 	hwdev = devm_hwmon_device_register_with_info(dev, "aynec", NULL,
 						     &ayn_ec_chip_info,
@@ -622,6 +904,7 @@ static struct platform_driver ayn_ec_driver = {
 		.name = "ayn-ec",
 	},
 	.probe = ayn_ec_probe,
+	.resume = ayn_ec_resume,
 };
 
 static struct platform_device *ayn_ec_device;
-- 
2.50.1


