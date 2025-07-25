Return-Path: <linux-kernel+bounces-745130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F045B11568
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 02:46:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 346883BAEFC
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 00:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82415199252;
	Fri, 25 Jul 2025 00:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OjFtV0/6"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA25E14EC5B;
	Fri, 25 Jul 2025 00:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753404341; cv=none; b=CkIRMfAZz3xzYfspGctrK69lDzR1f794o397f+0AzfP9OWw21mwFrX28C8Boudh+daWDv0haONxbeMthoa5zgKXtJOWJhmfyGKrxvSyFUGiZ12mB+TLoZW32LSumvbYY2hzww5XJmaxXuXyOUlnlujWfPSXNAOn/JuTGf+PT+8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753404341; c=relaxed/simple;
	bh=Mh+eclJqn2KmGhnak3nS3V+Q78ZbhDJRCDH2qTIilAw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U6XfVFOxxEU1GVX2CXAQSbI86IL5kTfrjBTvbDuJXGItmcj4k1ggC2aczp0GLoa+TZMh8wubGB+iGHYiiJm8m0VT7l0ww07BFK5xVhQSqPGXYDz9VJ135OyLdIG1IZPKL20AgUOHnWzkcgiuFEL/QdLZuZkv8zb4HVO8ggxZUzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OjFtV0/6; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-23dea2e01e4so20301555ad.1;
        Thu, 24 Jul 2025 17:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753404339; x=1754009139; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SmNH4tStZ9mEGg18rDqVqWS9xxuO7qREoY1w+uBaNFs=;
        b=OjFtV0/6YOmJ68JLYAk1vKCnM3GVDCoQSZ9xkQ8t0tEoETf9vEJuBOEHxtoz/id9mS
         OCLO0QZ3KH4Vs+DmOQ4h6wQHyvwn2Jc7ioaZm41qvGy01MRY7RNUK/tjO0YrL234BJmj
         DcL5N7OCpGD+uoJ036k82CZasfCUufQP4bWxv77bqH7haCM7u0lL+WTcJMort8IePmnZ
         Ui1w1Mr6llfVuaj2lS/WQYGGP/m3tu/UN3Hr6dbJGQpZwY1XpRzLYIi1ciKdgJu2uKzt
         FRLrB61YaAIxs+bYhM7h9Zc91XLSqv2sO4/Vo0INWMJo1XcajgAt6RNffxX52tk6DGsE
         xc8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753404339; x=1754009139;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SmNH4tStZ9mEGg18rDqVqWS9xxuO7qREoY1w+uBaNFs=;
        b=Fy/sWnnjRBPrjyymckYXo2OCmrLp4NlQluXn/PMvJOI10tAdN0VQFkPIQlfG9840+Z
         UcTv49aOH8gPqyyLU5IhqaZi3VEjlK8/d8Aa0bTYTV40t4LQmFydPp2YhvYK9oMw8liz
         urjrWHnGJn9KoLGFEcby0fKEiwL/V90XYwZ0Tth1TSZu7YGOccfsP6T4apY2d3HgDyAy
         QUAtsMK1YNaQs+pdD4i1AA33A3/d3KBrkbuLj4E1EZqusK91+a+ENF/oHdB9p/y9nV63
         DHS5ZG9Nz4pcs5UsJPEGb0vcGF78hY0Ri0USFFAtuXjM0Egh37MVkHd1EZdrynQyx3HR
         Capw==
X-Forwarded-Encrypted: i=1; AJvYcCVeM+TluTR0e3DXUJnYhJojOf0dCv8FD6eiXi6MXCTTkezoKdijMoMoIiLvkO9QK53KKBz2g5qcxm1XzzxKwsYp+/4qeg==@vger.kernel.org, AJvYcCVoA2mvnEEO4bVdWr7Vsm9ov0jn4dEPCJmxQ7hsk5aUHSCk3APX3I2ix3V6Cn9O5u8EE0boo5hE/70p/9oR@vger.kernel.org, AJvYcCXK/FXovu1EQxxBHeFqot1mLplzSl6Z9poyDCaq2NcVRC4y5d+IGtyG7HbLFRqtsja+zDxIxm/gjyrKng==@vger.kernel.org
X-Gm-Message-State: AOJu0YyJvk0B1UU7+cfqe7QKv8QeIW0ciAu7H4VjHgBQ2A3cscw8X2N2
	y9gXjQIv9dHc56n1Z3Ed6xuT6OHZPbS5UAAaZwgdVeJm5oybQEIlpumf
X-Gm-Gg: ASbGncvJ6a/LZ59Eo4UDwLb7T9DYtp7y09Zck67w+cHW2Ppo58qk/HuoUPrXw7Tp2Ts
	hQDSatw6JY02idxCZhzP+uF3iSpU4fL3w33wdiFv6jwiJz/DWwxkKQNf4gWzrj97YXTj6ExUE+d
	5upx+kre9qEZk5RC51J33CI7E1TB1qy1rgKDzKfB9OVK9yoryNhnkZur7aHe9AEUXd8N8rr421h
	9gqVOKHhXwcYhjkFPPPoDJ5x6DA/0XuenB+ekACgMkov/kMgBYQ6xj9UoAbGqhhsQ1ebc8R9aYQ
	JLIAUwgHYv4aKH8o9Wa5+9DemL/FIrGBphbDp9cLcsCgRp3suINYLSQTG7f5uOb3ojeCueEb6lN
	6VUCEk0hieCnFcetk4gZ3Im4YpU8BMovGW4urkAZa8tDfV/S67PBIGu+8aQNzzuhnx+9yBUY1jl
	HtFQ==
X-Google-Smtp-Source: AGHT+IF7fYAn2B0khjRRHsl1eSsLz7XCM4Zw1fwLP9pR4fafl4us+eGXrYI7vpjPhxU4dkcGfDCe8Q==
X-Received: by 2002:a17:903:2f0f:b0:234:eb6:a35d with SMTP id d9443c01a7336-23f981a27ecmr132112425ad.27.1753404339112;
        Thu, 24 Jul 2025 17:45:39 -0700 (PDT)
Received: from bliptop (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fa4901b99sm24157905ad.188.2025.07.24.17.45.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 17:45:38 -0700 (PDT)
From: "Derek J. Clark" <derekjohn.clark@gmail.com>
To: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Hans de Goede <hansg@kernel.org>
Cc: Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	"Derek J . Clark" <derekjohn.clark@gmail.com>,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org
Subject: [PATCH 3/4] platform/x86: (ayn-ec) Add RGB Interface
Date: Thu, 24 Jul 2025 17:45:32 -0700
Message-ID: <20250725004533.63537-3-derekjohn.clark@gmail.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250725004533.63537-1-derekjohn.clark@gmail.com>
References: <20250725004533.63537-1-derekjohn.clark@gmail.com>
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
 drivers/platform/x86/ayn-ec.c | 282 ++++++++++++++++++++++++++++++++++
 1 file changed, 282 insertions(+)

diff --git a/drivers/platform/x86/ayn-ec.c b/drivers/platform/x86/ayn-ec.c
index b2054dc2358a..5b0931497bcc 100644
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
 
@@ -608,12 +647,254 @@ static struct attribute *ayn_sensors_attrs[] = {
 
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
 	int ret;
 
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
+
 	hwdev = devm_hwmon_device_register_with_info(dev, "aynec", NULL,
 						     &ayn_ec_chip_info,
 						     ayn_sensors_groups);
@@ -625,6 +906,7 @@ static struct platform_driver ayn_ec_driver = {
 		.name = "ayn-ec",
 	},
 	.probe = ayn_ec_probe,
+	.resume = ayn_ec_resume,
 };
 
 static struct platform_device *ayn_ec_device;
-- 
2.50.0


