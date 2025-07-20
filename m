Return-Path: <linux-kernel+bounces-738412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B9ABB0B7FE
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 21:39:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91E79189114C
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 19:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B27CB226165;
	Sun, 20 Jul 2025 19:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ct66e4xf"
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2BD62253EC
	for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 19:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753040351; cv=none; b=bm5uKb5ShJTjqgsfWhQANulnZA7IIRcryKgexZ/sIT6QzOA90m+Ra6kJhTGr+A7yBbU2dOjRtDoDzm9SsH3YMWzJGthzc/V/JRH0mdvDVjsxE8ab5rT5RkIZjcXJSmrpY7DUFS3LqkxBFpORI27wbbdMy2g/NceaZm/c/cjcbAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753040351; c=relaxed/simple;
	bh=iDtvHuWeWWAvaDrc1D90AZ0sVF5gJEyOSaBvzWOZYBo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TDd+lvSdCNv01E/feUhNTywA8RCO+f4KllgeAyQb8U8k6duUcAVFWNvAtkK4XcwEdZXw4iKvzLaTkv/y/j3qPjNTGAYu3o3c3jXYyhsWfvtgbTpOG4Krpz2Wrgfu1CVcemfXVPiwZBHh8CtvdtnmWjRPmd3wvllTubSopf8Gc5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ct66e4xf; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-73e82d2ea1dso1498982a34.2
        for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 12:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753040348; x=1753645148; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TzWMDQiQhqKDucj4xDCvdrZWSeCpiJ1tZaaA5u2Est8=;
        b=ct66e4xfWyBumlCu9mdkTKmo7lpkX7txgrmlVNZocTJPFVh1tbH2hrQ3S/PXrb7DwT
         QGyA0vqLPgWwF4RnWlo3sqZQy5/bVeuuOKFFiMc/atQk3ceL8V3fvuBkMhJVTPZAhRCe
         AGt6WU6GLn8m2MjevlH931ZIwKjIVEF7bsXFkxR4i/NjAcCXSqHVBDZiQ/LbDR3Vh6PR
         8Bt+9Ip0ENszW2iSzjkr7ssszsixlbxdSOu8TZpWTAbbD9o32EGg5wVdF0N3zBzLJCHT
         DAMTTkHaiKUNHnOZocAULkPweHjDu0oy717DVCPYceU6FViqGgffPzWwKzyNMtf3f+3q
         95aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753040348; x=1753645148;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TzWMDQiQhqKDucj4xDCvdrZWSeCpiJ1tZaaA5u2Est8=;
        b=oTHQG/bhkxH54UH7S5PmOEyx8ciZo3n/6KuSBJndul9Co1rbN79SeR4Vq1VvOrDAzK
         1nfhOJjdRJl9OmXHERffVcwz3dZzKbgfWHTtmFS965lkGOxRTclVkgzjgeBtoNCt0t2O
         PeH0f9RYSIB6Ev8dsEdv2ukvZpgpBrH3T+rWQ+Ri7Km2D6D0CVPYK0LaQ7z5pEF3LqCh
         eRvaIKcHf3lxYXkGgMKVuPOT9bxbhXrU7fr7F5IYWuBCfSl5bQhxMtOmAImLKYdHUNqx
         fdSiZoG8DNEYBY/O9O5PJA7fBGkv0X67f3JrbuAZK3ZUTZuO7U75/3qoJ9Xhd8Nu999a
         X9EA==
X-Forwarded-Encrypted: i=1; AJvYcCX/YJtrbtUWsRl9gnvyiqFYqMsDHIicmY9fuKSb8FMCcwZi9nUcLMm2ZaadQIJbqnEI/ewzLCB64AENw8k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz90sMfhu6HRGuVmB34nqodggO0Vaa73OLbxSl3Zwyez7j2wzAH
	msdoA5YOm1ZS75XjcamXdpe/Li7ExbAcqcPaF1k8k0ExIB0jKIgDkP+v+BVEwcLd8+Q=
X-Gm-Gg: ASbGncsBcICIvxE7C0640VAyQc2Ht2mItX9e3DwI7FKKLolWLh7dq7Ak+YSEsGoenfd
	U35mz3xybuLAe15ERmfSmcVqYWT2tjI76z11+yFiZQ0Bhp2KM3xLVpdJPABRWK5hWaIn/Ifb4l0
	sLKm3bcOtcQICOZ8J2dQOlO5E+GpBMn0Sx/wmDvEl5gfd6hFJ5h2HKFefYAoT8dxOLjX6qtpDuy
	jz+tuJKVXWnoG3Ke+xaPhwX/mZ8EqJo1K5Ag4H10EN0lG/g1ta7F+XcCJJOp9V759INGYGYlvGT
	wpYvQL3upnPTFtM595Wlm12UQa0BdlJ6PrgKWq+DjhXTmwQ/ofKtDBXKJMxl8Zu6NlJ2n5mHWDT
	xOR/zu3bSEfA=
X-Google-Smtp-Source: AGHT+IHG0eQajqarHbENrvaixxkoziriMrVyGz1oaBStUnyceEv9srArOzG9hJaXtUODGRIJ4Pm6Aw==
X-Received: by 2002:a05:6808:3a15:b0:40a:533c:c9cb with SMTP id 5614622812f47-41d05654bcdmr12175951b6e.38.1753040347679;
        Sun, 20 Jul 2025 12:39:07 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700::1fec])
        by smtp.gmail.com with UTF8SMTPSA id 5614622812f47-41fd498c1cbsm1799638b6e.27.2025.07.20.12.39.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Jul 2025 12:39:06 -0700 (PDT)
Date: Sun, 20 Jul 2025 14:39:04 -0500
From: Dan Carpenter <dan.carpenter@linaro.org>
To: AKASHI Takahiro <takahiro.akashi@linaro.org>,
	Michal Simek <michal.simek@amd.com>,
	Linus Walleij <linus.walleij@linaro.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>,
	Cristian Marussi <cristian.marussi@arm.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org, arm-scmi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH RFC v2 6/7] pinctrl-scmi: Add GPIO support
Message-ID: <bd79aa90-73f7-4d7b-a340-539b52a73bcf@sabinyo.mountain>
References: <cover.1753039612.git.dan.carpenter@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1753039612.git.dan.carpenter@linaro.org>

This adds GPIO support to the SCMI pin controller driver.  It's an RFC
patch because I'm not really sure how these are used and so I don't
know how they should be configured via devicetree.  I've labeled the
places where I think devicetree configuration would go with a FIXME.

This driver was based on work from Takahiro AKASHI.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/pinctrl/core.c         |   8 +-
 drivers/pinctrl/pinctrl-scmi.c | 206 ++++++++++++++++++++++++++++++++-
 2 files changed, 207 insertions(+), 7 deletions(-)

diff --git a/drivers/pinctrl/core.c b/drivers/pinctrl/core.c
index bbcc6881b119..91882c68bcd5 100644
--- a/drivers/pinctrl/core.c
+++ b/drivers/pinctrl/core.c
@@ -947,7 +947,6 @@ EXPORT_SYMBOL_GPL(pinctrl_gpio_set_config);
 int pinctrl_gpio_get_config(struct gpio_chip *gc, unsigned int offset, unsigned long *config)
 {
 	struct pinctrl_gpio_range *range;
-	const struct pinconf_ops *ops;
 	struct pinctrl_dev *pctldev;
 	int ret, pin;
 
@@ -955,19 +954,16 @@ int pinctrl_gpio_get_config(struct gpio_chip *gc, unsigned int offset, unsigned
 	if (ret)
 		return ret;
 
-	ops = pctldev->desc->confops;
-	if (!ops || !ops->pin_config_get)
-		return -EINVAL;
-
 	mutex_lock(&pctldev->mutex);
 	pin = gpio_to_pin(range, gc, offset);
-	ret = ops->pin_config_get(pctldev, pin, config);
+	ret = pin_config_get_for_pin(pctldev, pin, config);
 	mutex_unlock(&pctldev->mutex);
 
 	if (ret)
 		return ret;
 
 	*config = pinconf_to_config_argument(*config);
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(pinctrl_gpio_get_config);
diff --git a/drivers/pinctrl/pinctrl-scmi.c b/drivers/pinctrl/pinctrl-scmi.c
index fba0a3a2fc10..9a947ced0df7 100644
--- a/drivers/pinctrl/pinctrl-scmi.c
+++ b/drivers/pinctrl/pinctrl-scmi.c
@@ -6,6 +6,7 @@
  * Copyright 2024 NXP
  */
 
+#include <linux/bitmap.h>
 #include <linux/device.h>
 #include <linux/err.h>
 #include <linux/errno.h>
@@ -16,6 +17,9 @@
 #include <linux/slab.h>
 #include <linux/types.h>
 
+#include <linux/gpio/driver.h>
+
+#include <linux/pinctrl/consumer.h>
 #include <linux/pinctrl/machine.h>
 #include <linux/pinctrl/pinconf.h>
 #include <linux/pinctrl/pinconf-generic.h>
@@ -42,6 +46,7 @@ struct scmi_pinctrl {
 	unsigned int nr_functions;
 	struct pinctrl_pin_desc *pins;
 	unsigned int nr_pins;
+	struct gpio_chip *gc;
 };
 
 static int pinctrl_scmi_get_groups_count(struct pinctrl_dev *pctldev)
@@ -505,6 +510,197 @@ static int pinctrl_scmi_get_pins(struct scmi_pinctrl *pmx,
 	return 0;
 }
 
+static int pinctrl_gpio_get_direction(struct gpio_chip *gc, unsigned int offset)
+{
+	unsigned long config;
+	bool in, out;
+	int ret;
+
+	config = PIN_CONFIG_INPUT_ENABLE;
+	ret = pinctrl_gpio_get_config(gc, offset, &config);
+	if (ret)
+		return ret;
+	in = config;
+
+	config = PIN_CONFIG_OUTPUT_ENABLE;
+	ret = pinctrl_gpio_get_config(gc, offset, &config);
+	if (ret)
+		return ret;
+	out = config;
+
+	/* Consistency check - in theory both can be enabled! */
+	if (in && !out)
+		return GPIO_LINE_DIRECTION_IN;
+	if (!in && out)
+		return GPIO_LINE_DIRECTION_OUT;
+
+	return -EINVAL;
+}
+
+static int pinctrl_gpio_direction_output_wrapper(struct gpio_chip *gc,
+						 unsigned int offset, int val)
+{
+	return pinctrl_gpio_direction_output(gc, offset);
+}
+
+static int pinctrl_gpio_get(struct gpio_chip *gc, unsigned int offset)
+{
+	unsigned long config;
+	int ret;
+
+	config = PIN_CONFIG_INPUT_VALUE;
+	ret = pinctrl_gpio_get_config(gc, offset, &config);
+	if (ret)
+		return ret;
+
+	return config;
+}
+
+static void pinctrl_gpio_set(struct gpio_chip *gc, unsigned int offset, int val)
+{
+	unsigned long config;
+
+	config = PIN_CONF_PACKED(PIN_CONFIG_OUTPUT, val);
+	pinctrl_gpio_set_config(gc, offset, config);
+}
+
+static int pinctrl_gc_to_func(struct gpio_chip *gc)
+{
+	struct scmi_pinctrl *pmx = gpiochip_get_data(gc);
+
+	return (gc - pmx->gc);
+}
+
+static int gpio_add_pin_ranges(struct gpio_chip *gc)
+{
+	struct scmi_pinctrl *pmx = gpiochip_get_data(gc);
+	const char * const *p_groups;
+	unsigned int n_groups;
+	int func = pinctrl_gc_to_func(gc);
+	const unsigned int *pins;
+	unsigned int n_pins;
+	int offset = 0;
+	int group;
+	int ret;
+
+	ret = pmx->pctl_desc.pmxops->get_function_groups(pmx->pctldev, func, &p_groups, &n_groups);
+	if (ret)
+		return ret;
+
+	// FIXME: fix the correct group from the device tree
+	for (group = 0; group < n_groups; group++) {
+		ret = pinctrl_get_group_pins(pmx->pctldev, p_groups[group], &pins, &n_pins);
+		if (ret)
+			return ret;
+
+		ret = gpiochip_add_pingroup_range(gc, pmx->pctldev, offset, p_groups[group]);
+		if (ret)
+			return ret;
+
+		offset += n_pins;
+	}
+
+	return 0;
+}
+
+static int get_nr_pins_in_function(struct scmi_pinctrl *pmx, int func)
+{
+	const char * const *pin_groups;
+	unsigned int n_groups;
+	const unsigned int *pins;
+	unsigned int n_pins;
+	int total = 0;
+	int i, ret;
+
+	// FIXME: get the correct number of gc.ngpio
+	// Find the right group from the device tree
+	ret = pmx->pctl_desc.pmxops->get_function_groups(pmx->pctldev, func, &pin_groups, &n_groups);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < n_groups; i++) {
+		ret = pinctrl_get_group_pins(pmx->pctldev, pin_groups[i], &pins, &n_pins);
+		if (ret)
+			return ret;
+		total += n_pins;
+	}
+
+	return total;
+}
+
+static int register_scmi_pinctrl_gpio_handler(struct device *dev, struct scmi_pinctrl *pmx)
+{
+	struct fwnode_handle *gpio = NULL;
+	int ret, i;
+
+	gpio = fwnode_get_named_child_node(dev->fwnode, "gpio");
+	if (!gpio)
+		return 0;
+
+	pmx->gc = devm_kcalloc(dev, pmx->nr_functions, sizeof(*pmx->gc), GFP_KERNEL);
+	if (!pmx->gc)
+		return -ENOMEM;
+
+	for (i = 0; i < pmx->nr_functions; i++) {
+		const char *fn_name;
+
+		ret = pinctrl_ops->is_gpio(pmx->ph, i, FUNCTION_TYPE);
+		if (ret < 0)
+			return ret;
+		if (ret == false)
+			continue;
+
+		ret = pinctrl_ops->name_get(pmx->ph, i, FUNCTION_TYPE, &fn_name);
+		if (ret)
+			return ret;
+
+		pmx->gc[i].label = devm_kasprintf(dev, GFP_KERNEL, "%s", fn_name);
+		if (!pmx->gc[i].label)
+			return -ENOMEM;
+
+		pmx->gc[i].owner = THIS_MODULE;
+		pmx->gc[i].get = pinctrl_gpio_get;
+		pmx->gc[i].set = pinctrl_gpio_set;
+		pmx->gc[i].get_direction = pinctrl_gpio_get_direction;
+		pmx->gc[i].direction_input = pinctrl_gpio_direction_input;
+		pmx->gc[i].direction_output = pinctrl_gpio_direction_output_wrapper;
+		pmx->gc[i].add_pin_ranges = gpio_add_pin_ranges;
+
+		// FIXME: verify that this is correct
+		pmx->gc[i].can_sleep = true;
+
+		ret = get_nr_pins_in_function(pmx, i);
+		if (ret < 0)
+			return ret;
+		pmx->gc[i].ngpio = ret;
+
+		pmx->gc[i].parent = dev;
+		pmx->gc[i].base = -1;
+	}
+
+	return 0;
+}
+
+static int scmi_gpiochip_add_data(struct device *dev, struct scmi_pinctrl *pmx)
+{
+	int ret;
+	int i;
+
+	for (i = 0; i < pmx->nr_functions; i++) {
+		ret = pinctrl_ops->is_gpio(pmx->ph, i, FUNCTION_TYPE);
+		if (ret < 0)
+			return ret;
+		if (ret == false)
+			continue;
+
+		ret = devm_gpiochip_add_data(dev, &pmx->gc[i], pmx);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
 static const char * const scmi_pinctrl_blocklist[] = {
 	"fsl,imx95",
 	"fsl,imx94",
@@ -559,7 +755,15 @@ static int scmi_pinctrl_probe(struct scmi_device *sdev)
 	if (!pmx->functions)
 		return -ENOMEM;
 
-	return pinctrl_enable(pmx->pctldev);
+	ret = register_scmi_pinctrl_gpio_handler(dev, pmx);
+	if (ret)
+		return ret;
+
+	ret = pinctrl_enable(pmx->pctldev);
+	if (ret)
+		return ret;
+
+	return scmi_gpiochip_add_data(dev, pmx);
 }
 
 static const struct scmi_device_id scmi_id_table[] = {
-- 
2.47.2


