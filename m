Return-Path: <linux-kernel+bounces-865137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 46C1EBFC3C9
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 15:45:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BF82D3581D0
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 13:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1577134D4C9;
	Wed, 22 Oct 2025 13:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="QlFkgtWQ"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10FC134CFD7
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 13:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761140493; cv=none; b=l1cmKDa4p3PDzlN7KKgKS5231gDrG5x5QHH/J6VLVu1Pmu8tBZ1wCRk5AMCWW1aaiJ9lWlmqLezgEokzq5eprTYNwiP983BHkpB0N3yZELlSaoUDHtzbOIxyy131FXTX99+K3Xa1lH7ZYQL29k8bTWIcx/OGu5dKaUyFwqw8eQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761140493; c=relaxed/simple;
	bh=kmXAtSE3HnrhoN6jQo1dJ1cDI3xe1YoDYFqyP0G5bLM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HXmPT8CHCuCeh3ve18UxiIdqQMIEh0xUw6msCDl0TCiKTVHwj8yBMqvZ6J3jCmDvTlY59foKqPTEpqhCKJN8MTFBi4FmanBVvtTq85AhfJ4Ni8v/HASZIAks00HvERDXsv7Zh7gf2f6MydmWuDSrHvnySflCF5tlsMRKcQ2b7cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=QlFkgtWQ; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-4270a0127e1so3446925f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 06:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1761140489; x=1761745289; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SfExIwUemKJ5MA3EQ5p1dELGI8YLjDgxSK0E7YT4mrQ=;
        b=QlFkgtWQ8TulI+HF1rimjT3uZh9Cd7tKnUZzESmeKxI6uYyTRK8xnaSRfJs2PJOVbL
         94dHZ+CEMvVQnlFeDVz+Y8UZdgjTpgbvBKOz6bcFb/SWct6W/wMnO6Qlcg7fqRY1YCF2
         tQalEY4dBDnDpEqwab4R8SCr40oPvPjN5D5gLtDCmN5T0uY13LQM2KDZDHuC0CyM2IFm
         AKu8iCdaIQd/dBFjjKxL5M8oYK400XD5Yz7DQW5NdI5u7gvp09jXp8MpKO/duR+S5SFE
         SchivIeR688jMMbDYDUTKt+753Bd32NYPeDX+k9hQjfzjxT7zqh5J91V9xTdBtKP2gtQ
         wMVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761140489; x=1761745289;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SfExIwUemKJ5MA3EQ5p1dELGI8YLjDgxSK0E7YT4mrQ=;
        b=u76/H0e+fA40JRdG6cv6ag8u/CcGF1LAZR3bQ3KlEEofzLFUYyJeDF0nVuHzhT20/+
         AKDszFEXqWlvqvWdbqniq2chQ89isJ51+Q6idsyebWTKT7GuobOb2GdyVYafxMkmxcIu
         SNk5Lj7TarR6LmYqdoW2rWHwNr3VlfwWw7tLdHzkxJpmeqcYXzn1SfJvvQDpCLa2H0YA
         Zs2aBjbD3MTB2zNoMQ8nKS7AUtpOEeAVJ0PxhHLc7bbf4jUROjnrosxD15ZmCaYlh6qd
         XGmoMdo4gYyZ86n1YKwGWEVSAxwXt6t/P8nxXgyIZudHWyrZhJ8L70ZI1xnW2bPBb+m8
         3o6w==
X-Forwarded-Encrypted: i=1; AJvYcCVz21f9lPWibPxFF6J0yZXsQA6AxUw4hnFfYw9qgCjbL2D38BTbLj0N0j0X42Xh8uVK/RaF9Ng2EC5/bFY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNTZsWrlwebEBHUjQJlpbWnhVlelWGTzXWkvOFyzunhuErif8s
	Bn92L3avd1eqYtYjTTk7TuBQHghm2DZcJZmkhOpUJyj1lSts5JGM45UA9sNeYkYkjLE=
X-Gm-Gg: ASbGnctSUG5iQLhzACl9SWZOJPantNc1Ljw6+QsK3DWuMohUw0E8pWv7cOs1Gidy4V3
	5/VYMRgbuGx9sBI+HTsMDPPnwXHnp79RHUVuG8ts5rV/aeEmHBNpDgGDoBgVx5DHndb7amdKKXk
	IXhCQBkNXmePRrll3IFDIZvJLdxs9KiER5Ap/3wT74/AaZxqgTKXS98NAz6TFs73OEKHRcOuYEi
	S1i6GXjZwzXk8wPduum9JYPUz4JeKOjgW3uGJBYWz/Je/JOX00thu2T/ND9xpn4xzrLVEQWli5f
	r2s0JST4+FO/icyRcGkhuFqV+7GJX/fnrH92uEPGZKydPqmsqAwvmQGuo0OulCwtaChCSsfyZ01
	Ixcx1TW9s6PzwdmXFSiyA4fmszQXC8y9EcXJuiF8ne3KV5uA9kWLDUZMR4kQUrFNz0QRLYpg=
X-Google-Smtp-Source: AGHT+IEPEOA7RggYEmPoDIO0+E2RmnVfpYLMBEbq6FywxOG4KxPHzSHzjlI3TZkyFbZBEIQnBiWT3A==
X-Received: by 2002:a05:6000:25c8:b0:428:3d75:b0e8 with SMTP id ffacd0b85a97d-4283d75c950mr11436344f8f.62.1761140489390;
        Wed, 22 Oct 2025 06:41:29 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:69df:73af:f16a:eada])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427f00b97f8sm24863066f8f.36.2025.10.22.06.41.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 06:41:28 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 22 Oct 2025 15:41:08 +0200
Subject: [PATCH v2 9/9] reset: gpio: use software nodes to setup the GPIO
 lookup
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251022-reset-gpios-swnodes-v2-9-69088530291b@linaro.org>
References: <20251022-reset-gpios-swnodes-v2-0-69088530291b@linaro.org>
In-Reply-To: <20251022-reset-gpios-swnodes-v2-0-69088530291b@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Daniel Scally <djrscally@gmail.com>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-acpi@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7182;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=GpqWfoRVxSyb5DxpZnAD2OmXLWj91GbiRae7HNISm60=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBo+N70O1r3YA0TWjKCf0+bm/mCXjIsUNvLh8W+3
 J5Ki2AlLESJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaPje9AAKCRARpy6gFHHX
 cjkjEACIIOMqMkMMhSh7gXtXg69x48pRB8KTsR3Yxzk4wWwJ3Q9RkxfvTniioGQKgiFgNnTxYaB
 0ZJX3otVkm1XsxqWQboShGoMAbOTRg5Ztpo966I88p8oS7Y3gTbo5FUROnMQm6KH0t3O6M3Lwzu
 QOx2STBaRZwM9E/ev7srtjthqMAjZsksjLnUexE66XIhUkxGtmTAgrADh/1vj/8zQ0SrbDQigOQ
 2HDAl+zgcSx5bs9kZRY7e3F7Bc4B3uLv+aSf1t7Mwsbav2tMF1AcB2iS2+A69+4l7NnMJqlOcfs
 oSXOSLKwt6G/B8jdZ3kMFvqehFofq/gUTDBqpYLHfNPfht2Wo0zL8agaEYJeDyN0ToGwtN88wdN
 t+FgLKShzNp/dKxzv3U6SNg9MRLM0+gaxNy5rmms64kmFo1Iippo1UKm6wsb9QNPNwr585CDbkw
 qhdDuGav/eGtT4jl8W9SXtln9d5qOtk7vO3+IX4urill/whCP6nhfecIVOGZJB6zY7HhkcYpOiM
 kPZcf/24w89KuqXfclgdcVCrQE2D+fzGBivmvFJdTvvIifn0aekF0KWNA8enpTV2nwcQeQg8B+M
 vyQWOw5mwbBDvlRUSutJAy2cLDSpgnHggPSUBeL5qXi1StdrCS4w4FTi3F3Z5ujl8RB0fdTBNEW
 qv4RIgsyrgYbm1A==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

GPIO machine lookup is a nice mechanism for associating GPIOs with
consumers if we don't know what kind of device the GPIO provider is or
when it will become available. However in the case of the reset-gpio, we
are already holding a reference to the device and so can reference its
firmware node. Let's setup a software node that references the relevant
GPIO and attach it to the auxiliary device we're creating.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/reset/core.c | 131 ++++++++++++++++++++++++++++++---------------------
 1 file changed, 77 insertions(+), 54 deletions(-)

diff --git a/drivers/reset/core.c b/drivers/reset/core.c
index c9f13020ca3a7b9273488497a7d4240d0af762b0..20378de4b813ab79a103ea81cf2cbcd2b76c0ccf 100644
--- a/drivers/reset/core.c
+++ b/drivers/reset/core.c
@@ -14,6 +14,7 @@
 #include <linux/export.h>
 #include <linux/gpio/driver.h>
 #include <linux/gpio/machine.h>
+#include <linux/gpio/property.h>
 #include <linux/idr.h>
 #include <linux/kernel.h>
 #include <linux/kref.h>
@@ -77,10 +78,12 @@ struct reset_control_array {
 /**
  * struct reset_gpio_lookup - lookup key for ad-hoc created reset-gpio devices
  * @of_args: phandle to the reset controller with all the args like GPIO number
+ * @swnode: Software node containing the reference to the GPIO provider
  * @list: list entry for the reset_gpio_lookup_list
  */
 struct reset_gpio_lookup {
 	struct of_phandle_args of_args;
+	struct fwnode_handle *swnode;
 	struct list_head list;
 };
 
@@ -849,52 +852,45 @@ static void __reset_control_put_internal(struct reset_control *rstc)
 	kref_put(&rstc->refcnt, __reset_control_release);
 }
 
-static int __reset_add_reset_gpio_lookup(struct gpio_device *gdev, int id,
-					 struct device_node *np,
-					 unsigned int gpio,
-					 unsigned int of_flags)
+static void reset_gpio_aux_device_release(struct device *dev)
 {
-	unsigned int lookup_flags;
-	const char *label_tmp;
+	struct auxiliary_device *adev = to_auxiliary_dev(dev);
 
-	/*
-	 * Later we map GPIO flags between OF and Linux, however not all
-	 * constants from include/dt-bindings/gpio/gpio.h and
-	 * include/linux/gpio/machine.h match each other.
-	 */
-	if (of_flags > GPIO_ACTIVE_LOW) {
-		pr_err("reset-gpio code does not support GPIO flags %u for GPIO %u\n",
-		       of_flags, gpio);
-		return -EINVAL;
+	kfree(adev);
+}
+
+static int reset_add_gpio_aux_device(struct device *parent,
+				     struct fwnode_handle *swnode,
+				     int id, void *pdata)
+{
+	struct auxiliary_device *adev;
+	int ret;
+
+	adev = kzalloc(sizeof(*adev), GFP_KERNEL);
+	if (!adev)
+		return -ENOMEM;
+
+	adev->id = id;
+	adev->name = "gpio";
+	adev->dev.parent = parent;
+	adev->dev.platform_data = pdata;
+	adev->dev.release = reset_gpio_aux_device_release;
+	device_set_node(&adev->dev, swnode);
+
+	ret = auxiliary_device_init(adev);
+	if (ret) {
+		kfree(adev);
+		return ret;
 	}
 
-	label_tmp = gpio_device_get_label(gdev);
-	if (!label_tmp)
-		return -EINVAL;
+	ret = __auxiliary_device_add(adev, "reset");
+	if (ret) {
+		auxiliary_device_uninit(adev);
+		kfree(adev);
+		return ret;
+	}
 
-	char *label __free(kfree) = kstrdup(label_tmp, GFP_KERNEL);
-	if (!label)
-		return -ENOMEM;
-
-	/* Size: one lookup entry plus sentinel */
-	struct gpiod_lookup_table *lookup __free(kfree) = kzalloc(struct_size(lookup, table, 2),
-								  GFP_KERNEL);
-	if (!lookup)
-		return -ENOMEM;
-
-	lookup->dev_id = kasprintf(GFP_KERNEL, "reset.gpio.%d", id);
-	if (!lookup->dev_id)
-		return -ENOMEM;
-
-	lookup_flags = GPIO_PERSISTENT;
-	lookup_flags |= of_flags & GPIO_ACTIVE_LOW;
-	lookup->table[0] = GPIO_LOOKUP(no_free_ptr(label), gpio, "reset",
-				       lookup_flags);
-
-	/* Not freed on success, because it is persisent subsystem data. */
-	gpiod_add_lookup_table(no_free_ptr(lookup));
-
-	return 0;
+	return ret;
 }
 
 /*
@@ -902,9 +898,11 @@ static int __reset_add_reset_gpio_lookup(struct gpio_device *gdev, int id,
  */
 static int __reset_add_reset_gpio_device(const struct of_phandle_args *args)
 {
+	struct property_entry properties[] = { {}, {} };
 	struct reset_gpio_lookup *rgpio_dev;
-	struct auxiliary_device *adev;
-	int id, ret;
+	unsigned int offset, of_flags;
+	struct device *parent;
+	int id, ret, lflags;
 
 	/*
 	 * Currently only #gpio-cells=2 is supported with the meaning of:
@@ -915,11 +913,30 @@ static int __reset_add_reset_gpio_device(const struct of_phandle_args *args)
 	if (args->args_count != 2)
 		return -ENOENT;
 
+	offset = args->args[0];
+	of_flags = args->args[1];
+
+	/*
+	 * Later we map GPIO flags between OF and Linux, however not all
+	 * constants from include/dt-bindings/gpio/gpio.h and
+	 * include/linux/gpio/machine.h match each other.
+	 *
+	 * FIXME: Find a better way of translating OF flags to GPIO lookup
+	 * flags.
+	 */
+	if (of_flags > GPIO_ACTIVE_LOW) {
+		pr_err("reset-gpio code does not support GPIO flags %u for GPIO %u\n",
+		       of_flags, offset);
+		return -EINVAL;
+	}
+
 	struct gpio_device *gdev __free(gpio_device_put) =
 		gpio_device_find_by_fwnode(of_fwnode_handle(args->np));
 	if (!gdev)
 		return -EPROBE_DEFER;
 
+	parent = gpio_device_to_device(gdev);
+
 	/*
 	 * Registering reset-gpio device might cause immediate
 	 * bind, resulting in its probe() registering new reset controller thus
@@ -936,6 +953,12 @@ static int __reset_add_reset_gpio_device(const struct of_phandle_args *args)
 		}
 	}
 
+	lflags = GPIO_PERSISTENT | (of_flags & GPIO_ACTIVE_LOW);
+
+	properties[0] = PROPERTY_ENTRY_GPIO_FWNODE("reset-gpios",
+						   parent->fwnode,
+						   offset, lflags);
+
 	id = ida_alloc(&reset_gpio_ida, GFP_KERNEL);
 	if (id < 0)
 		return id;
@@ -947,11 +970,6 @@ static int __reset_add_reset_gpio_device(const struct of_phandle_args *args)
 		goto err_ida_free;
 	}
 
-	ret = __reset_add_reset_gpio_lookup(gdev, id, args->np, args->args[0],
-					    args->args[1]);
-	if (ret < 0)
-		goto err_kfree;
-
 	rgpio_dev->of_args = *args;
 	/*
 	 * We keep the device_node reference, but of_args.np is put at the end
@@ -959,19 +977,24 @@ static int __reset_add_reset_gpio_device(const struct of_phandle_args *args)
 	 * Hold reference as long as rgpio_dev memory is valid.
 	 */
 	of_node_get(rgpio_dev->of_args.np);
-	adev = auxiliary_device_create(gpio_device_to_device(gdev), "reset",
-				       "gpio", &rgpio_dev->of_args, id);
-	ret = PTR_ERR_OR_ZERO(adev);
+
+	rgpio_dev->swnode = fwnode_create_software_node(properties, NULL);
+	if (IS_ERR(rgpio_dev->swnode))
+		goto err_put_of_node;
+
+	ret = reset_add_gpio_aux_device(parent, rgpio_dev->swnode, id,
+					&rgpio_dev->of_args);
 	if (ret)
-		goto err_put;
+		goto err_del_swnode;
 
 	list_add(&rgpio_dev->list, &reset_gpio_lookup_list);
 
 	return 0;
 
-err_put:
+err_del_swnode:
+	fwnode_remove_software_node(rgpio_dev->swnode);
+err_put_of_node:
 	of_node_put(rgpio_dev->of_args.np);
-err_kfree:
 	kfree(rgpio_dev);
 err_ida_free:
 	ida_free(&reset_gpio_ida, id);

-- 
2.48.1


