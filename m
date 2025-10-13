Return-Path: <linux-kernel+bounces-850475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D6A13BD2EC0
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 14:11:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5A4AE34B9CD
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 12:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F02C26F463;
	Mon, 13 Oct 2025 12:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OhDV7UBC"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143EA2749F1
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 12:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760357444; cv=none; b=LFJbIPuBKEndIjKYkXDYTqZSZhM8unM4qITZYkFsmk6r+ZuSijpXHM5DAWFzwtYxjAlM56iITcrzrpIm6NpKA2ckDLwVlzefsFiAV63Txy184sVSqikZymwyMaj4SOEnMNFQLnh6nzyvb8XU4whbehx0Hyi/llIQlDZGPKwBiZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760357444; c=relaxed/simple;
	bh=iV7dZN2zQM89gv73tquq9E0hkymmZBrU9u+MMIBTFjY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CurI0cT24OonZ0kHEPosm9/uZ/dQL9J6FIcmq+ZFUzW1Pj5Tc+Ynr1p+8TSPCU0Qlff0fDUJy3FS4I9wDRbxYwt20gYCezu+6piu7Ue390kTDRMtZDFre3SzCd6J0L7jd7r+LOh9T1ZKmn3lyyWqTW3LfhR2NGr2m8INgmjbdJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OhDV7UBC; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7841da939deso3568967b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 05:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760357441; x=1760962241; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Acgc74CjfZTp6MYYUhLSeaFHzttZXGEcLRcNsc8GaGo=;
        b=OhDV7UBCald3sVwzGuBbBOjK/uycq0PxNMJAlKGdrP1S30Wq0z0vI6K0TtWDyoeQiy
         nvBXD4rA4N8/dikYii51nvSzqcsdBypoomj4EuWV8O9xygxp2t42ZanQ3e1a5FUiDmdD
         rz8ULa5MiRq1C+EhJCE6uKQPVMpB2GXSvWGPjpDjuLCbe8Aj0VPXbExENBvCtdLFUXQk
         BAdKxhxPQVOnxXHcp8YHIzsRj4kV/2OrpKbIuOmCA7epodX98UmNocEDoGCyzZXP5FaE
         xjUX3DmzMNppx+LbW0Ja+d9/w3qOob04MWpaY+/t4tJ9HNaTZnHeYL9cG8lqXkNKSJmh
         XmJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760357441; x=1760962241;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Acgc74CjfZTp6MYYUhLSeaFHzttZXGEcLRcNsc8GaGo=;
        b=JQ5CpvWOEXw+7XVdS7GKDnRo9d4VS0novWnjDDqc6o6Tglq79mGvkelK6HkibpSzom
         smsrlhP+/+8Lkf/9eNZ8235ITkMkWmGBPZUpm9sMFyCuPvFfu7iDFi2PXgEDHAEarYpy
         ghv/0ukIaXoEkVm9iXuNUfqdMCF4z3sg39lF7/AwPy+mE2wiRhmDzRFn9zVjr5EfvWG7
         WGP52cJWvTZ/jb+WydlOT/gptSiBEBjJtLY6ktGwRLG+irOZ02g/9g0XTDx683Dm8jkA
         /Ea7pVmZYUq9HMmc/HGJGJvucTUKUT9hO10XGABUPv5ucxcyi5X5000VJ4wVjxaEkFPo
         ry6w==
X-Forwarded-Encrypted: i=1; AJvYcCUKwUsl8bqvsUOHJBb0iIa7RDIw+kcv4S3yEZD99vt9Odj1QTVespG4nAKvmW+RsVrhRsRiCVgnvPRRfyY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdlRxpTvuyE6Hkl/D5+OEM6W+mz+sF7P0W2uHtXdIZAssd1u10
	/FsyLoJ7SuTCgUk3l8TG6xVAVp9jXsLyPXeUzmqUTIdJcL5vDWvyf2dx
X-Gm-Gg: ASbGncsjfIu4WRTw1QFIBgF0Ro+oOeu3GNP6XUARiIcQ2Da0PHqQ9r7q7mNToSj5WUT
	dAei/s6R8iuBHlGETuqIB0UYr2kUvLO1rc4//2yHAP1xs8SZDkgGZIRsBNo/BBmHKV+IB+JQDd3
	K58b6mv02MMnxzFArmNsxhP7ylrMcGpxUr+Zlpkg9bruwfFNCuZXkS+5Difd67ja2mMAQWdyGoZ
	dO8cDZgJI+UYGTpsdaKexF4iVXRjWtt5q4CDMEFdDSD+CD6Fv3PxAQc3v+flgpFOnbeDZv+WC4/
	dJXSeubVbJs39LOb5oaaO0D7zeVQ7/AbjgwlQRs+cT4HMNcVEY1Msro4QVfqW98fXtcNjPy6qml
	57ZCihooO5UVWMn1j7SIb5AzqGG8CJZvR1y6wnHhlJJFjqxFoJnUUD7gwEDH7
X-Google-Smtp-Source: AGHT+IG1l95bYyByQDcEFgmzemofFZK+KCRGebeyQgiv1fQZrrpkj8XV9Ak8diBAriChOrSnAL/M0w==
X-Received: by 2002:a05:6a21:9993:b0:2c6:85b9:1df5 with SMTP id adf61e73a8af0-32da8134b33mr27183606637.3.1760357441241;
        Mon, 13 Oct 2025 05:10:41 -0700 (PDT)
Received: from MRSPARKLE.localdomain ([206.83.98.89])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b678df48a83sm9633354a12.31.2025.10.13.05.10.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 05:10:40 -0700 (PDT)
From: Jonathan Brophy <professorjonny98@gmail.com>
To: lee Jones <lee@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Jonathan Brophy <professor_jonny@hotmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Radoslav Tsvetkov <rtsvetkov@gradotech.eu>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-leds@vger.kernel.org
Subject: [PATCH v2 4/4] leds: Add Virtual Color LED Group driver
Date: Tue, 14 Oct 2025 01:09:48 +1300
Message-ID: <20251013120955.227572-5-professorjonny98@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251013120955.227572-1-professorjonny98@gmail.com>
References: <20251013120955.227572-1-professorjonny98@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Brophy <professor_jonny@hotmail.com>

Introduces a new driver that implements virtual LED groups,
aggregating multiple monochromatic LEDs into virtual groups and providing
priority-based control for concurrent state management.

Author: Radoslav Tsvetkov <rtsvetkov@gradotech.eu>
Co Author: Jonathan Brophy <professor_jonny@hotmail.com>
Copyright (C) 2024 Jonathan Brophy <professor_jonny@hotmail.com>

Co-developed-by: Radoslav Tsvetkov <rtsvetkov@gradotech.eu>
Signed-off-by: Radoslav Tsvetkov <rtsvetkov@gradotech.eu>
Tested-by: Jonathan Brophy <professor_jonny@hotmail.com>
Signed-off-by: Jonathan Brophy <professor_jonny@hotmail.com>
---
 drivers/leds/rgb/Kconfig                   |  17 +
 drivers/leds/rgb/Makefile                  |   1 +
 drivers/leds/rgb/leds-group-virtualcolor.c | 439 +++++++++++++++++++++
 3 files changed, 457 insertions(+)
 create mode 100644 drivers/leds/rgb/leds-group-virtualcolor.c

diff --git a/drivers/leds/rgb/Kconfig b/drivers/leds/rgb/Kconfig
index 222d943d826a..70a80fd46b9c 100644
--- a/drivers/leds/rgb/Kconfig
+++ b/drivers/leds/rgb/Kconfig
@@ -75,4 +75,21 @@ config LEDS_MT6370_RGB
 	  This driver can also be built as a module. If so, the module
 	  will be called "leds-mt6370-rgb".

+config LEDS_GROUP_VIRTUALCOLOR
+	tristate "Virtual LED Group Driver with Priority Control"
+	depends on OF || COMPILE_TEST
+	help
+	  This option enables support for virtual LED groups that aggregate
+	  multiple monochromatic LEDs with priority-based control. It allows
+	  managing concurrent LED activation requests by ensuring only the
+	  highest-priority LED state is active at any given time.
+
+	  Multiple LEDs can be grouped together and controlled as a single
+	  virtual LED with priority levels and blinking support. This is
+	  useful for systems that need to manage multiple LED indicators
+	  with different priority levels.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called leds-group-virtualcolor.
+
 endif # LEDS_CLASS_MULTICOLOR
diff --git a/drivers/leds/rgb/Makefile b/drivers/leds/rgb/Makefile
index a501fd27f179..693fd300b849 100644
--- a/drivers/leds/rgb/Makefile
+++ b/drivers/leds/rgb/Makefile
@@ -6,3 +6,4 @@ obj-$(CONFIG_LEDS_NCP5623)		+= leds-ncp5623.o
 obj-$(CONFIG_LEDS_PWM_MULTICOLOR)	+= leds-pwm-multicolor.o
 obj-$(CONFIG_LEDS_QCOM_LPG)		+= leds-qcom-lpg.o
 obj-$(CONFIG_LEDS_MT6370_RGB)		+= leds-mt6370-rgb.o
+obj-$(CONFIG_LEDS_GROUP_VIRTUALCOLOR)	+= leds-group-virtualcolor.o
diff --git a/drivers/leds/rgb/leds-group-virtualcolor.c b/drivers/leds/rgb/leds-group-virtualcolor.c
new file mode 100644
index 000000000000..e11ad155d3b4
--- /dev/null
+++ b/drivers/leds/rgb/leds-group-virtualcolor.c
@@ -0,0 +1,439 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Virtual LED Group Driver with Priority Control
+ *
+ * Implements virtual LED groups by aggregating multiple
+ * monochromatic LEDs. Provides priority-based control for managing
+ * concurrent LED activation requests, ensuring only the highest-priority
+ * LED state is active at any given time.
+ *
+ * Code created by Radoslav Tsvetkov <rtsvetkov@gradotech.eu>
+ * Copyright (C) 2024 Jonathan Brophy <professor_jonny@hotmail.com>
+ *
+ */
+
+#include <linux/gpio/consumer.h>
+#include <linux/leds.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+
+struct virtual_led {
+	struct led_classdev cdev;
+	struct led_classdev **monochromatics;
+	struct leds_virtualcolor *vc_data;
+	int num_monochromatics;
+	int priority;
+	unsigned long blink_delay_on;
+	unsigned long blink_delay_off;
+	struct list_head list;
+};
+
+struct leds_virtualcolor {
+	struct virtual_led *vleds;
+	int num_vleds;
+	struct list_head active_leds;
+	struct mutex lock; // Protects access to active LEDs
+};
+
+static void virtual_set_monochromatic_brightness(struct virtual_led *vled,
+						 enum led_brightness brightness)
+{
+	int i;
+
+	if (vled->blink_delay_on || vled->blink_delay_off) {
+		unsigned long blink_mask = (BIT(LED_BLINK_SW) | BIT(LED_BLINK_ONESHOT) |
+					    BIT(LED_SET_BLINK));
+
+		/*
+		 * Make sure the LED is not already blinking.
+		 * We don't want to call led_blink_set multiple times.
+		 */
+		if (!(vled->cdev.work_flags & blink_mask))
+			led_blink_set(&vled->cdev, &vled->blink_delay_on, &vled->blink_delay_off);
+
+		/* Update the blink delays if they have changed */
+		if (vled->blink_delay_on != vled->cdev.blink_delay_on ||
+		    vled->blink_delay_off != vled->cdev.blink_delay_off) {
+			vled->cdev.blink_delay_on = vled->blink_delay_on;
+			vled->cdev.blink_delay_off = vled->blink_delay_off;
+		}
+	}
+
+	for (i = 0; i < vled->num_monochromatics; i++)
+		led_set_brightness(vled->monochromatics[i], brightness);
+}
+
+static ssize_t priority_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct virtual_led *vled = dev_get_drvdata(dev);
+
+	return sprintf(buf, "%d\n", vled->priority);
+}
+
+static ssize_t priority_store(struct device *dev, struct device_attribute *attr, const char *buf,
+			      size_t count)
+{
+	struct virtual_led *vled = dev_get_drvdata(dev);
+	int new_priority;
+	int ret;
+
+	ret = kstrtoint(buf, 10, &new_priority);
+	if (ret < 0)
+		return ret;
+
+	vled->priority = new_priority;
+	return count;
+}
+
+static DEVICE_ATTR_RW(priority);
+
+static ssize_t blink_delay_on_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct virtual_led *vled = dev_get_drvdata(dev);
+
+	return sprintf(buf, "%lu\n", vled->blink_delay_on);
+}
+
+static ssize_t blink_delay_on_store(struct device *dev, struct device_attribute *attr,
+				    const char *buf, size_t count)
+{
+	struct virtual_led *vled = dev_get_drvdata(dev);
+	unsigned long new_delay;
+	int ret;
+
+	ret = kstrtoul(buf, 10, &new_delay);
+	if (ret < 0)
+		return ret;
+
+	/* Apply new delay immediately */
+	vled->blink_delay_on = new_delay;
+	virtual_set_monochromatic_brightness(vled, vled->cdev.brightness);
+
+	return count;
+}
+
+static ssize_t blink_delay_off_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct virtual_led *vled = dev_get_drvdata(dev);
+
+	return sprintf(buf, "%lu\n", vled->blink_delay_off);
+}
+
+static ssize_t blink_delay_off_store(struct device *dev, struct device_attribute *attr,
+				     const char *buf, size_t count)
+{
+	struct virtual_led *vled = dev_get_drvdata(dev);
+	unsigned long new_delay;
+	int ret;
+
+	ret = kstrtoul(buf, 10, &new_delay);
+	if (ret < 0)
+		return ret;
+
+	/* Apply new delay immediately */
+	vled->blink_delay_off = new_delay;
+	virtual_set_monochromatic_brightness(vled, vled->cdev.brightness);
+
+	return count;
+}
+
+static DEVICE_ATTR_RW(blink_delay_on);
+static DEVICE_ATTR_RW(blink_delay_off);
+
+static void restore_sysfs_write_access(void *data)
+{
+	struct led_classdev *led_cdev = data;
+
+	mutex_lock(&led_cdev->led_access);
+	led_sysfs_enable(led_cdev);
+	mutex_unlock(&led_cdev->led_access);
+}
+
+static bool virtual_led_is_active(struct list_head *head, struct virtual_led *vled)
+{
+	struct virtual_led *entry;
+
+	list_for_each_entry(entry, head, list) {
+		if (entry == vled)
+			return true;
+	}
+
+	return false;
+}
+
+static int virtual_led_brightness_set(struct led_classdev *cdev, enum led_brightness brightness)
+{
+	struct virtual_led *vled = container_of(cdev, struct virtual_led, cdev);
+	struct leds_virtualcolor *vc_data = vled->vc_data;
+	struct virtual_led *active;
+
+	mutex_lock(&vc_data->lock);
+
+	active = list_first_entry_or_null(&vc_data->active_leds, struct virtual_led, list);
+	if (active) {
+		/*
+		 * If the currently active LED has a higher priority,
+		 * ignore the new request.
+		 */
+		if (active->priority > vled->priority)
+			goto out_unlock;
+
+		/*
+		 * The currently active LED is going to be replaced,
+		 * turn off its monochromatic LEDs.
+		 */
+		virtual_set_monochromatic_brightness(active, LED_OFF);
+	}
+
+	if (brightness == LED_OFF) {
+		/*
+		 * If the LED is already active, remove it from the active list
+		 * and update the brightness of the next highest priority LED.
+		 */
+		if (virtual_led_is_active(&vc_data->active_leds, vled))
+			list_del(&vled->list);
+
+		active = list_first_entry_or_null(&vc_data->active_leds, struct virtual_led, list);
+		if (active)
+			virtual_set_monochromatic_brightness(active, active->cdev.brightness);
+	} else {
+		/* Add the LED to the active list and update the brightness */
+		if (!virtual_led_is_active(&vc_data->active_leds, vled))
+			list_add(&vled->list, &vc_data->active_leds);
+
+		active = list_first_entry_or_null(&vc_data->active_leds, struct virtual_led, list);
+		if (active)
+			virtual_set_monochromatic_brightness(active, brightness);
+	}
+
+out_unlock:
+	mutex_unlock(&vc_data->lock);
+
+	return 0;
+}
+
+static int leds_virtualcolor_init_vled(struct device *dev, struct device_node *child,
+				       struct virtual_led *vled, struct leds_virtualcolor *vc_data)
+{
+	struct led_init_data init_data = {};
+	u32 blink_interval;
+	u32 phandle_count;
+	u32 max_brightness;
+	int ret;
+	int i;
+
+	ret = of_property_read_u32(child, "priority", &vled->priority);
+	if (ret)
+		vled->priority = 0;
+
+	ret = of_property_read_u32(child, "blink", &blink_interval);
+	if (!ret) {
+		vled->blink_delay_on = blink_interval;
+		vled->blink_delay_off = blink_interval;
+	}
+
+	phandle_count = of_property_count_elems_of_size(child, "leds", sizeof(u32));
+	if (phandle_count <= 0) {
+		dev_err(dev, "No monochromatic LEDs specified for virtual LED %s\n",
+			vled->cdev.name);
+		return -EINVAL;
+	}
+
+	vled->num_monochromatics = phandle_count;
+	vled->monochromatics = devm_kcalloc(dev, vled->num_monochromatics,
+					    sizeof(*vled->monochromatics), GFP_KERNEL);
+	if (!vled->monochromatics)
+		return -ENOMEM;
+
+	for (i = 0; i < vled->num_monochromatics; i++) {
+		struct led_classdev *led_cdev;
+
+		led_cdev = devm_of_led_get_optional(dev, i);
+		if (IS_ERR(led_cdev)) {
+			/*
+			 * If the LED is not available yet, defer the probe.
+			 * The probe will be retried when it becomes available.
+			 */
+			if (PTR_ERR(led_cdev) == -EPROBE_DEFER)
+				return -EPROBE_DEFER;
+
+			ret = PTR_ERR(led_cdev);
+			dev_err(dev, "Failed to get monochromatic LED for %s, error %d\n",
+				vled->cdev.name, ret);
+			return ret;
+		}
+
+		vled->monochromatics[i] = led_cdev;
+	}
+
+	ret = of_property_read_u32(child, "max-brightness", &max_brightness);
+	if (ret)
+		vled->cdev.max_brightness = LED_FULL;
+	else
+		vled->cdev.max_brightness = max_brightness;
+
+	vled->cdev.brightness_set_blocking = virtual_led_brightness_set;
+	vled->cdev.flags = LED_CORE_SUSPENDRESUME;
+
+	init_data.fwnode = NULL; // Use OF, not fwnode
+	ret = devm_led_classdev_register_ext(dev, &vled->cdev, &init_data);
+	if (ret) {
+		dev_err(dev, "Failed to register virtual LED %s\n", vled->cdev.name);
+		return ret;
+	}
+
+	ret = device_create_file(vled->cdev.dev, &dev_attr_priority);
+	if (ret) {
+		dev_err(dev, "Failed to create sysfs attribute for priority\n");
+		return ret;
+	}
+
+	ret = device_create_file(vled->cdev.dev, &dev_attr_blink_delay_on);
+	if (ret) {
+		dev_err(dev, "Failed to create sysfs attribute for blink_delay_on\n");
+		return ret;
+	}
+
+	ret = device_create_file(vled->cdev.dev, &dev_attr_blink_delay_off);
+	if (ret) {
+		dev_err(dev, "Failed to create sysfs attribute for blink_delay_off\n");
+		return ret;
+	}
+
+	vled->vc_data = vc_data;
+
+	return 0;
+}
+
+static int leds_virtualcolor_disable_sysfs_access(struct device *dev, struct virtual_led *vled)
+{
+	int i;
+
+	for (i = 0; i < vled->num_monochromatics; i++) {
+		struct led_classdev *led_cdev = vled->monochromatics[i];
+
+		mutex_lock(&led_cdev->led_access);
+		led_sysfs_disable(led_cdev);
+		mutex_unlock(&led_cdev->led_access);
+
+		devm_add_action_or_reset(dev, restore_sysfs_write_access, led_cdev);
+	}
+
+	return 0;
+}
+
+static int leds_virtualcolor_probe(struct platform_device *pdev)
+{
+	struct leds_virtualcolor *vc_data;
+	struct device *dev = &pdev->dev;
+	struct device_node *child;
+	int count = 0;
+	int ret;
+
+	vc_data = devm_kzalloc(dev, sizeof(*vc_data), GFP_KERNEL);
+	if (!vc_data)
+		return -ENOMEM;
+
+	mutex_init(&vc_data->lock);
+	INIT_LIST_HEAD(&vc_data->active_leds);
+
+	vc_data->num_vleds = of_get_child_count(dev->of_node);
+	if (vc_data->num_vleds == 0) {
+		dev_err(dev, "No virtual LEDs defined in device tree\n");
+		ret = -EINVAL;
+		goto err_mutex_destroy;
+	}
+
+	vc_data->vleds = devm_kcalloc(dev, vc_data->num_vleds, sizeof(*vc_data->vleds), GFP_KERNEL);
+	if (!vc_data->vleds) {
+		ret = -ENOMEM;
+		goto err_mutex_destroy;
+	}
+
+	for_each_child_of_node(dev->of_node, child) {
+		struct virtual_led *vled = &vc_data->vleds[count];
+
+		ret = leds_virtualcolor_init_vled(dev, child, vled, vc_data);
+		if (ret) {
+			if (ret != -EPROBE_DEFER)
+				dev_err(dev, "Failed to initialize virtual LED %d\n", count);
+
+			of_node_put(child);
+			goto err_node_put;
+		}
+
+		count++;
+	}
+
+	platform_set_drvdata(pdev, vc_data);
+
+	if (of_property_read_bool(dev->of_node, "monochromatics-ro")) {
+		int i;
+
+		for (i = 0; i < count; i++) {
+			struct virtual_led *vled = &vc_data->vleds[i];
+
+			ret = leds_virtualcolor_disable_sysfs_access(dev, vled);
+			if (ret)
+				goto err_node_put;
+		}
+	}
+
+	return 0;
+
+err_node_put:
+	mutex_destroy(&vc_data->lock);
+	return ret;
+
+err_mutex_destroy:
+	mutex_destroy(&vc_data->lock);
+
+	return ret;
+}
+
+static void leds_virtualcolor_remove(struct platform_device *pdev)
+{
+	struct leds_virtualcolor *vc_data = platform_get_drvdata(pdev);
+	int i, j;
+
+	for (i = 0; i < vc_data->num_vleds; i++) {
+		struct virtual_led *vled = &vc_data->vleds[i];
+
+		device_remove_file(vled->cdev.dev, &dev_attr_priority);
+		device_remove_file(vled->cdev.dev, &dev_attr_blink_delay_on);
+		device_remove_file(vled->cdev.dev, &dev_attr_blink_delay_off);
+
+		for (j = 0; j < vled->num_monochromatics; j++) {
+			if (vled->monochromatics[j]) {
+				led_put(vled->monochromatics[j]);
+				vled->monochromatics[j] = NULL;
+			}
+		}
+	}
+
+	mutex_destroy(&vc_data->lock);
+}
+
+static const struct of_device_id leds_virtualcolor_of_match[] = {
+	{ .compatible = "leds-group-virtualcolor" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, leds_virtualcolor_of_match);
+
+static struct platform_driver leds_virtualcolor_driver = {
+	.probe  = leds_virtualcolor_probe,
+	.remove = leds_virtualcolor_remove,
+	.driver = {
+		.name           = "leds_virtualcolor",
+		.of_match_table = leds_virtualcolor_of_match,
+	},
+};
+
+module_platform_driver(leds_virtualcolor_driver);
+
+MODULE_AUTHOR("Radoslav Tsvetkov <rtsvetkov@gradotech.eu>");
+MODULE_DESCRIPTION("LEDs Virtual Color Driver with Priority Handling");
+MODULE_LICENSE("GPL");
\ No newline at end of file
--
2.43.0

