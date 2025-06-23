Return-Path: <linux-kernel+bounces-697837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 32B83AE3935
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jun 2025 11:00:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9E03189554C
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jun 2025 09:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61442235045;
	Mon, 23 Jun 2025 09:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="f/sGyA8/"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A369231848
	for <linux-kernel@vger.kernel.org>; Mon, 23 Jun 2025 09:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750669220; cv=none; b=ENPv1mHyM3+vojC97+znWBeaUeFI9SmhRrPL9PAqRrurBmEtuoM/gwxYQuVIEfhTOpX/OqBX5g3OEKilBEiy3KlfGSpP9LDEHGEde6IXW1ElMKy5LODS3BC7IADc2mZUe2p20IVh1XgPoc2+ESMouke3Es7eyOZpRUvc8mW2Jd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750669220; c=relaxed/simple;
	bh=d38zEk5ZaqdAay7/FyuW9ygn6cdXVn5igg9V9CUJrRU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kW4OZWxrbKMWVxibhFrmqdFxRTfLXTK80YmKjrbZgwDkGMHMVTF07RkBhDZ8h4w/yw0gUqMg2TyzA3nTe45QACeHafLPjHzwalQFy2UAc7foW1nPsIo4OZs41snrHXkO7eAYpBuaQSNH8hoRvq7NGv9pZ8LJnHxLV8XhSgmdNYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=f/sGyA8/; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-453398e90e9so25377375e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jun 2025 02:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1750669217; x=1751274017; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AXrjLqYiHV1UqIkacQ78pU7saslEmRuVemdbUKcNXL0=;
        b=f/sGyA8/CsQtVGvG0DdPa3hfje8XpM/Iv7Gtw7g3W6B/z+ErcxBVru2h+cbzpaNEN0
         GfyEuH7OtPqKEI1BbVKMXlcReQEWNwmUqsavo3o0hBAMKwEOcraYSKYlxgsf+SOuPUuM
         ZgLv2NIAT+SHPqBqBYvB2XgSGRyRQ7Rwbz7MyZ3qvaol4BYpv3V+SLAZxakpjpmjKc2u
         df7wsqvBAWHSk7veXk3vnAhcgXpuGhN6OwT1CY+/+QcY06/86NzPxtsbJIkGlDL3XvrZ
         gcrnCducLRDM62v9Rcq8rabpEPbNhtGRKstTR7/jJgR+J5LzqiS1wCd4QJHVA/DTe/Ux
         OFAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750669217; x=1751274017;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AXrjLqYiHV1UqIkacQ78pU7saslEmRuVemdbUKcNXL0=;
        b=Df9vkWk+TqksBJady37RvgcJKhtoVG5G7ABqkVsCqvuT3xs13eExG5Ae0MwWp+i3jC
         9/6T9RIZ+qre5IuU0/YNh5r16nQ0sMZoGu2SPEetKXTsab13wMZki67J81yV/tHvIXSE
         x9oFakY2cWvCyGaSgRQR1LSzWD5e/1bpEPQ7va8P46jnpFNXifKk/HxhT5e7O2wIq1dm
         88kQYukWmNBE2HGdfDk5nsUxJU5uHlnLWF00DzkjRIlK37aQCoTJ53vRIAPC0UcO1D6n
         xSF9MJDkyzpXiyQk2RIsNDdL6JK3NRxMAakla/v+tL2PHadikCRic3xGioDaoHl7J7sd
         IajA==
X-Forwarded-Encrypted: i=1; AJvYcCVGvW06JC97sMevMK5DuLh+1+vmJf8neHnWDT/fLcUsjjb0HQ7kzOlNMhyns+ARyxY3MsU0fkiwzckC7VM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqB/JsPJHYl92cvcsUTthbY74iqbUhZ0PXLaARawvezVdTFJme
	P/zInMI824CEtwUcsWDS7VGZ7sv38nJMlHWTH13jonIdeAJ8sZcY1URpT6Gkv6akw4o=
X-Gm-Gg: ASbGncv/tpHjtlghuNua+UU6Bs7U7h9UV7l7Q2BfGzMEXDif5wqjFpjOOIZL6YZlvWt
	PYK/8KFlbFGBUwJmTzSmWJNXMqS329BYMdEaTazjyIrCEeSAIx7ePQvqaQp1Gj0dMIyRWcEhj1d
	C/3pMOmIYbJ3bqiPm/F0mKs0zqqaFi0ylHJW9rsxZquDOUAruzFNv19X0p2lO+zXboERQY7gKfr
	kHW3DGnhKGhkuDwQyyJZwi2/xm2iYAMJC1X5ku76ue5bjqUMVBJ8MJbIziGka3g/eyVlkARwjKZ
	CTD1/datIVGGPiZPNsdSf9k0iyu+n382bZmmc3O5BzQLqeKazShJqKc=
X-Google-Smtp-Source: AGHT+IFj1OCV8PRKybyL+z12L2wsuEmBhGyO6RABq1Km1Mn/ENvlckiiRHoM5umZFcF/EESy6kYBIA==
X-Received: by 2002:a05:600c:4e8a:b0:450:d3b9:4b96 with SMTP id 5b1f17b1804b1-453659c9ca0mr96282455e9.13.1750669216650;
        Mon, 23 Jun 2025 02:00:16 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:5ce:238e:62a6:cbbc])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-453632312a3sm113401145e9.1.2025.06.23.02.00.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 02:00:15 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 23 Jun 2025 10:59:52 +0200
Subject: [PATCH v2 4/9] gpio: sysfs: don't use driver data in sysfs
 callbacks for line attributes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250623-gpio-sysfs-chip-export-v2-4-d592793f8964@linaro.org>
References: <20250623-gpio-sysfs-chip-export-v2-0-d592793f8964@linaro.org>
In-Reply-To: <20250623-gpio-sysfs-chip-export-v2-0-d592793f8964@linaro.org>
To: Ahmad Fatoum <a.fatoum@pengutronix.de>, 
 Kent Gibson <warthog618@gmail.com>, 
 =?utf-8?q?Jan_L=C3=BCbbe?= <jlu@pengutronix.de>, 
 Marek Vasut <marex@denx.de>, Geert Uytterhoeven <geert+renesas@glider.be>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=9621;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=R3AZXpoOp6EIWO/0eo1g3jnJMbaa3WsMdtY3unSTx9g=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBoWReZarv//rd58fVHSACYfkVYYe+Vp7TEbJ+ot
 DOEdl0eeM2JAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaFkXmQAKCRARpy6gFHHX
 cvxeEACDnrZYIeBF6eByaDw8IjxxUYG0jdB0latSGDg8mSXvqlGzWjIlgXzoVkpPz0jr7Xk4NoK
 X2lK9PrdOObXpB8cXpYynfbZGiUoax/xIB7W7jzE2gC51exzblrVLOmf++vBAMLKI7pQFS+uQnu
 LfAU0bsomaHttZXoKPpto8a3Mg8RNZcYb2vlzljLrTrOvtEtuQSnTEV/eDFj+75B3Z1rLwp+R6s
 HikMt/1pUX0dld9nEgMvlgoT7n1YWDhVnh8vCu355IyvtCdrZUWrzk5G6tCYO2kym8Jd5Dv8+Yf
 ozdRFBPouXNl3NLzg7omsfsFzp1NkEgFcIoJNghmr82cArjhmQ4yzCLfQ7cgSBUT3XZkSOoU2l8
 7Te5DbqlW0i3LkP7VLG9fc/1AD6Ux+Sa8/yqsCpxXEKObHUNnBTnrtYVJnjbrMyZgcwjrVTuTWM
 yNPplbXAXECld5YoStCHEHLf8X8YYv6qxGAuceMhLl1SOFiJTxYPQfJLyMlQr89xL2JUb5rfD5g
 ljKdwBaKrQSBUVOoYr3rAJxmi9q15NXuwUvtYSLllQlfvnTRljW6/Phfqj/kjUjS8k03deLDof4
 kr+EgD1E8+EblB6y///vEqVFPTGwh6Jw3Ee8gu+/tzRd7GFROqR7j2xpEOv3O4pzb/z95Utz1Y/
 qmCevso0ocfe1qg==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Currently each exported GPIO is represented in sysfs as a separate class
device. This allows us to simply use dev_get_drvdata() to retrieve the
pointer passed to device_create_with_groups() from sysfs ops callbacks.

However, we're preparing to add a parallel set of per-line sysfs
attributes that will live inside the associated gpiochip group. They are
not registered as class devices and so have the parent device passed as
argument to their callbacks (the GPIO chip class device).

Put the attribute structs inside the GPIO descriptor data and
dereference the relevant ones using container_of() in the callbacks.
This way, we'll be able to reuse the same code for both the legacy and
new GPIO attributes.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpiolib-sysfs.c | 122 +++++++++++++++++++++++++++++--------------
 1 file changed, 82 insertions(+), 40 deletions(-)

diff --git a/drivers/gpio/gpiolib-sysfs.c b/drivers/gpio/gpiolib-sysfs.c
index 0e2c6b2d0940b1d4e4ad0a90aa172e7d01908969..2f1df2ceb7360200c718ea95089720ebfa5a513a 100644
--- a/drivers/gpio/gpiolib-sysfs.c
+++ b/drivers/gpio/gpiolib-sysfs.c
@@ -32,6 +32,15 @@ struct kernfs_node;
 #define GPIO_IRQF_TRIGGER_BOTH		(GPIO_IRQF_TRIGGER_FALLING | \
 					 GPIO_IRQF_TRIGGER_RISING)
 
+enum {
+	GPIO_SYSFS_LINE_ATTR_DIRECTION = 0,
+	GPIO_SYSFS_LINE_ATTR_VALUE,
+	GPIO_SYSFS_LINE_ATTR_EDGE,
+	GPIO_SYSFS_LINE_ATTR_ACTIVE_LOW,
+	GPIO_SYSFS_LINE_ATTR_SENTINEL,
+	GPIO_SYSFS_LINE_ATTR_SIZE,
+};
+
 struct gpiod_data {
 	struct gpio_desc *desc;
 
@@ -41,6 +50,14 @@ struct gpiod_data {
 	unsigned char irq_flags;
 
 	bool direction_can_change;
+
+	struct device_attribute dir_attr;
+	struct device_attribute val_attr;
+	struct device_attribute edge_attr;
+	struct device_attribute active_low_attr;
+	struct attribute *attrs[GPIO_SYSFS_LINE_ATTR_SIZE];
+	struct attribute_group attr_group;
+	const struct attribute_group *attr_groups[2];
 };
 
 struct gpiodev_data {
@@ -79,7 +96,8 @@ static DEFINE_MUTEX(sysfs_lock);
 static ssize_t direction_show(struct device *dev,
 			      struct device_attribute *attr, char *buf)
 {
-	struct gpiod_data *data = dev_get_drvdata(dev);
+	struct gpiod_data *data = container_of(attr, struct gpiod_data,
+					       dir_attr);
 	struct gpio_desc *desc = data->desc;
 	int value;
 
@@ -95,7 +113,8 @@ static ssize_t direction_store(struct device *dev,
 			       struct device_attribute *attr, const char *buf,
 			       size_t size)
 {
-	struct gpiod_data *data = dev_get_drvdata(dev);
+	struct gpiod_data *data = container_of(attr, struct gpiod_data,
+					       dir_attr);
 	struct gpio_desc *desc = data->desc;
 	ssize_t status;
 
@@ -112,12 +131,12 @@ static ssize_t direction_store(struct device *dev,
 
 	return status ? : size;
 }
-static DEVICE_ATTR_RW(direction);
 
 static ssize_t value_show(struct device *dev, struct device_attribute *attr,
 			  char *buf)
 {
-	struct gpiod_data *data = dev_get_drvdata(dev);
+	struct gpiod_data *data = container_of(attr, struct gpiod_data,
+					       val_attr);
 	struct gpio_desc *desc = data->desc;
 	ssize_t status;
 
@@ -133,7 +152,8 @@ static ssize_t value_show(struct device *dev, struct device_attribute *attr,
 static ssize_t value_store(struct device *dev, struct device_attribute *attr,
 			   const char *buf, size_t size)
 {
-	struct gpiod_data *data = dev_get_drvdata(dev);
+	struct gpiod_data *data = container_of(attr, struct gpiod_data,
+					       val_attr);
 	struct gpio_desc *desc = data->desc;
 	ssize_t status;
 	long value;
@@ -150,7 +170,6 @@ static ssize_t value_store(struct device *dev, struct device_attribute *attr,
 
 	return size;
 }
-static DEVICE_ATTR_PREALLOC(value, S_IWUSR | S_IRUGO, value_show, value_store);
 
 static irqreturn_t gpio_sysfs_irq(int irq, void *priv)
 {
@@ -247,7 +266,8 @@ static const char *const trigger_names[] = {
 static ssize_t edge_show(struct device *dev, struct device_attribute *attr,
 			 char *buf)
 {
-	struct gpiod_data *data = dev_get_drvdata(dev);
+	struct gpiod_data *data = container_of(attr, struct gpiod_data,
+					       edge_attr);
 	int flags;
 
 	scoped_guard(mutex, &data->mutex)
@@ -262,7 +282,8 @@ static ssize_t edge_show(struct device *dev, struct device_attribute *attr,
 static ssize_t edge_store(struct device *dev, struct device_attribute *attr,
 			  const char *buf, size_t size)
 {
-	struct gpiod_data *data = dev_get_drvdata(dev);
+	struct gpiod_data *data = container_of(attr, struct gpiod_data,
+					       edge_attr);
 	ssize_t status = size;
 	int flags;
 
@@ -289,7 +310,6 @@ static ssize_t edge_store(struct device *dev, struct device_attribute *attr,
 
 	return size;
 }
-static DEVICE_ATTR_RW(edge);
 
 /* Caller holds gpiod-data mutex. */
 static int gpio_sysfs_set_active_low(struct gpiod_data *data, int value)
@@ -318,7 +338,8 @@ static int gpio_sysfs_set_active_low(struct gpiod_data *data, int value)
 static ssize_t active_low_show(struct device *dev,
 			       struct device_attribute *attr, char *buf)
 {
-	struct gpiod_data *data = dev_get_drvdata(dev);
+	struct gpiod_data *data = container_of(attr, struct gpiod_data,
+					       active_low_attr);
 	struct gpio_desc *desc = data->desc;
 	int value;
 
@@ -332,7 +353,8 @@ static ssize_t active_low_store(struct device *dev,
 				struct device_attribute *attr,
 				const char *buf, size_t size)
 {
-	struct gpiod_data *data = dev_get_drvdata(dev);
+	struct gpiod_data *data = container_of(attr, struct gpiod_data,
+					       active_low_attr);
 	ssize_t status;
 	long value;
 
@@ -344,48 +366,34 @@ static ssize_t active_low_store(struct device *dev,
 
 	return gpio_sysfs_set_active_low(data, value) ?: size;
 }
-static DEVICE_ATTR_RW(active_low);
 
 static umode_t gpio_is_visible(struct kobject *kobj, struct attribute *attr,
 			       int n)
 {
-	struct device *dev = kobj_to_dev(kobj);
-	struct gpiod_data *data = dev_get_drvdata(dev);
-	struct gpio_desc *desc = data->desc;
+	struct device_attribute *dev_attr = container_of(attr,
+						struct device_attribute, attr);
 	umode_t mode = attr->mode;
-	bool show_direction = data->direction_can_change;
+	struct gpiod_data *data;
 
-	if (attr == &dev_attr_direction.attr) {
-		if (!show_direction)
+	if (strcmp(attr->name, "direction") == 0) {
+		data = container_of(dev_attr, struct gpiod_data, dir_attr);
+
+		if (!data->direction_can_change)
 			mode = 0;
-	} else if (attr == &dev_attr_edge.attr) {
-		if (gpiod_to_irq(desc) < 0)
+	} else if (strcmp(attr->name, "edge") == 0) {
+		data = container_of(dev_attr, struct gpiod_data, edge_attr);
+
+		if (gpiod_to_irq(data->desc) < 0)
 			mode = 0;
-		if (!show_direction && test_bit(FLAG_IS_OUT, &desc->flags))
+
+		if (!data->direction_can_change &&
+		    test_bit(FLAG_IS_OUT, &data->desc->flags))
 			mode = 0;
 	}
 
 	return mode;
 }
 
-static struct attribute *gpio_attrs[] = {
-	&dev_attr_direction.attr,
-	&dev_attr_edge.attr,
-	&dev_attr_value.attr,
-	&dev_attr_active_low.attr,
-	NULL,
-};
-
-static const struct attribute_group gpio_group = {
-	.attrs = gpio_attrs,
-	.is_visible = gpio_is_visible,
-};
-
-static const struct attribute_group *gpio_groups[] = {
-	&gpio_group,
-	NULL
-};
-
 /*
  * /sys/class/gpio/gpiochipN/
  *   /base ... matching gpio_chip.base (N)
@@ -645,6 +653,21 @@ gdev_get_data(struct gpio_device *gdev) __must_hold(&sysfs_lock)
 	return dev_get_drvdata(cdev);
 };
 
+static void gpiod_attr_init(struct device_attribute *dev_attr, const char *name,
+			    ssize_t (*show)(struct device *dev,
+					    struct device_attribute *attr,
+					    char *buf),
+			    ssize_t (*store)(struct device *dev,
+					     struct device_attribute *attr,
+					     const char *buf, size_t count))
+{
+	sysfs_attr_init(&dev_attr->attr);
+	dev_attr->attr.name = name;
+	dev_attr->attr.mode = 0644;
+	dev_attr->show = show;
+	dev_attr->store = store;
+}
+
 /**
  * gpiod_export - export a GPIO through sysfs
  * @desc: GPIO to make available, already requested
@@ -664,6 +687,7 @@ gdev_get_data(struct gpio_device *gdev) __must_hold(&sysfs_lock)
 int gpiod_export(struct gpio_desc *desc, bool direction_may_change)
 {
 	struct gpio_device *gdev;
+	struct attribute **attrs;
 	struct gpiod_data *data;
 	struct device *dev;
 	int status;
@@ -709,8 +733,26 @@ int gpiod_export(struct gpio_desc *desc, bool direction_may_change)
 	else
 		data->direction_can_change = false;
 
+	gpiod_attr_init(&data->dir_attr, "direction",
+			direction_show, direction_store);
+	gpiod_attr_init(&data->val_attr, "value", value_show, value_store);
+	gpiod_attr_init(&data->edge_attr, "edge", edge_show, edge_store);
+	gpiod_attr_init(&data->active_low_attr, "active_low",
+			active_low_show, active_low_store);
+
+	attrs = data->attrs;
+	data->attr_group.is_visible = gpio_is_visible;
+	attrs[GPIO_SYSFS_LINE_ATTR_DIRECTION] = &data->dir_attr.attr;
+	attrs[GPIO_SYSFS_LINE_ATTR_VALUE] = &data->val_attr.attr;
+	attrs[GPIO_SYSFS_LINE_ATTR_EDGE] = &data->edge_attr.attr;
+	attrs[GPIO_SYSFS_LINE_ATTR_ACTIVE_LOW] =
+						&data->active_low_attr.attr;
+
+	data->attr_group.attrs = data->attrs;
+	data->attr_groups[0] = &data->attr_group;
+
 	dev = device_create_with_groups(&gpio_class, &gdev->dev,
-					MKDEV(0, 0), data, gpio_groups,
+					MKDEV(0, 0), data, data->attr_groups,
 					"gpio%u", desc_to_gpio(desc));
 	if (IS_ERR(dev)) {
 		status = PTR_ERR(dev);

-- 
2.48.1


