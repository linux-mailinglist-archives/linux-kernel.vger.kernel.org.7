Return-Path: <linux-kernel+bounces-738410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04259B0B7FB
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 21:39:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6F693BD6C8
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 19:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB9A62185A8;
	Sun, 20 Jul 2025 19:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E1q5u3x4"
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 043942264B0
	for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 19:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753040336; cv=none; b=rmWKPHE/sRKU5a2LxHKSS1KUXZNmRtWiRoSt2LGLvy1GuHoAEqxzOfPiAaHQuSxI8Ck/V3j6a9i0PFzvNvCvbz52cTklu3JZYvyJRPE5QTrJPCZoZxD3PPdWBK9hAOE32Xr0Gw6KE7QcblUlGWtlPr0jtnRiYt9ZRsima3S6HSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753040336; c=relaxed/simple;
	bh=mYX7pyCKmgBI3xkaCZ3OcyOD6ECMbja6Ks4OfZzYD0U=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CXviSwP7a69Iu2sia91BzYcX7s8TBy5NHex/j1yzcsrraHqhawi9DqlengBCtYFoZQC1k0NXhrTCLuuKscsDuy8K50ZjTqWa1ibrESsGcI+fZaBbF4tQ/yXAYBIxEYiIL2w/9n6a5ipHUfVieVnBqDDnxBeNB2hKb1Hc5LwCaX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=E1q5u3x4; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-30297d04cdbso628585fac.1
        for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 12:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753040332; x=1753645132; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mJ8CW0vLOfnenhTuOWc+TeZEp3L4Zf69FjBvFuh8CCU=;
        b=E1q5u3x4B/jU8dBh3OI7i5oFnomFS/yqXGh7i7eibqWMDCDVF+YHgXvPPkmK0g131u
         KZltk0AjUoyYqdF+ly+ZJFucbWBIK0sB6mMrCFyRhjne1rjfBcMIsYjd3a9ThdE2WX4D
         XbpPChMrsUZl5NZDdySchkilblrGn9LM49JrFEQDPCs1U3JW4FEIry34/pDOcNf4KLEZ
         L8+Be9LuHlLt2LyeYc6sbzd6UREd7qT4PEysPrQgnvnpz6F3Xpdv9FgSX9SShVdRQOad
         vPyo2eM7lp5G43DgTC3m7Hew5KvdgmVK+POkBGBDk74wrj5imbvO+nx5mtu+BowgQBKk
         w5cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753040332; x=1753645132;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mJ8CW0vLOfnenhTuOWc+TeZEp3L4Zf69FjBvFuh8CCU=;
        b=m5ercNqVh1ClRh45A8qAorT6izruzZwLqbI+VwXs6FiURRMRFk/YTHUmsrkd9Br7Ai
         HCjHY5TpjTRBkLbz15xAFgKfsn4hR8Wqm5gbw3qtjw3oCG6aXRC1vPV42gt5KnJw0FYx
         ClYlYZYpMuUumGL2golWOTgqz6oHE/FFoRhRxEktqbQC0TvItKLdgUunEabtF6CJvus1
         a0tY3REAty7dIvC6gAI9EvXE7MFl0q6oC1B0kEVPvWkSZ+geykv/Q4K7Nap0Q9CuO8hf
         U07ho9Zl9B9J8TVYue2cBbfU3e/MrXtoWY9QKc68dyBpW6bL0GMbZ+P7EwzwyRNl7EVx
         K4Sw==
X-Forwarded-Encrypted: i=1; AJvYcCX0koSnWYWpzEBiefLHiYRAHdzXMNb6D52TzCMSOlLoICwVcrZo2lNzzrRyr7GHeYdLZ6wW7aDv9buqMoY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzksXyX1r8EXUgs6LSl3fNt2li25UIRniLUPZl7lWecfYYwAgEe
	OUZVv3KTnRcDjnujZwS9I06Um97Gy1lfMetakvSoBkM9ydRI3PT9C+6pWz2XgxBKrBw=
X-Gm-Gg: ASbGncvnPAhMHpfv1liAxYn+J0guelAK+HSjGWTclkDaiTt2as5zXbQsOsSNlJYT9q9
	2de/2Qm8PK423LOUjRVVMt4QOnmjLC/Q1Rnzsho6YMsN4gZzGsHaB3uhopZQuVmRPDyoM6yqlBV
	gxdV80TT4jLZsfpNQVo87AEeSF0Jma4NrA8kS/AFPQsCKqtOOPcKZWNk2D0F+pmgJiFu+PMNcEL
	6cOhP8EgVFnKPG7iWUKl6TFKyL/QVItQPApRLmhL4ZwPgvkMpJzYy6f3YdABhHD3CWz1f3WhT1X
	KV8EpynFOaI8FjvsrMi4gM5QDrk0m8yNVIYOEuN8+zGe/7g1G6Z+c190C8skFj8NIrBU57+yR2N
	9CliMwgk6zfviaw==
X-Google-Smtp-Source: AGHT+IFbjLhU8/44DbMUEvvTUW/4Nyns5hHtifrjZpoaHHE4Bl1HkYPNemmL3YlLCmSkuw2CsDAi/w==
X-Received: by 2002:a05:6870:4149:b0:2ef:ac47:798a with SMTP id 586e51a60fabf-2ffb2246fc7mr13966393fac.9.1753040332019;
        Sun, 20 Jul 2025 12:38:52 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700::1fec])
        by smtp.gmail.com with UTF8SMTPSA id 586e51a60fabf-30104256720sm2795172fac.33.2025.07.20.12.38.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Jul 2025 12:38:50 -0700 (PDT)
From: AKASHI Takahiro <dan.carpenter@linaro.org>
X-Google-Original-From: AKASHI Takahiro <takahiro.akashi@linaro.org>
Date: Sun, 20 Jul 2025 14:38:48 -0500
To: AKASHI Takahiro <takahiro.akashi@linaro.org>,
	Michal Simek <michal.simek@amd.com>,
	Linus Walleij <linus.walleij@linaro.org>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RFC v2 3/7] pinctrl: introduce pinctrl_gpio_get_config()
Message-ID: <c15de1d1-e72a-48d8-ac45-95a6578e29b1@sabinyo.mountain>
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

This is a counterpart of pinctrl_gpio_set_config(), which will initially
be used to implement gpio_get interface in SCMI pinctrl based GPIO driver.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/pinctrl/core.c           | 35 ++++++++++++++++++++++++++++++++
 include/linux/pinctrl/consumer.h |  9 ++++++++
 2 files changed, 44 insertions(+)

diff --git a/drivers/pinctrl/core.c b/drivers/pinctrl/core.c
index 73b78d6eac67..bbcc6881b119 100644
--- a/drivers/pinctrl/core.c
+++ b/drivers/pinctrl/core.c
@@ -30,6 +30,7 @@
 #include <linux/pinctrl/consumer.h>
 #include <linux/pinctrl/devinfo.h>
 #include <linux/pinctrl/machine.h>
+#include <linux/pinctrl/pinconf.h>
 #include <linux/pinctrl/pinctrl.h>
 
 #include "core.h"
@@ -937,6 +938,40 @@ int pinctrl_gpio_set_config(struct gpio_chip *gc, unsigned int offset,
 }
 EXPORT_SYMBOL_GPL(pinctrl_gpio_set_config);
 
+/**
+ * pinctrl_gpio_get_config() - Get the config for a given GPIO pin
+ * @gc: GPIO chip structure from the GPIO subsystem
+ * @offset: hardware offset of the GPIO relative to the controller
+ * @config: the configuration to query.  On success it holds the result
+ */
+int pinctrl_gpio_get_config(struct gpio_chip *gc, unsigned int offset, unsigned long *config)
+{
+	struct pinctrl_gpio_range *range;
+	const struct pinconf_ops *ops;
+	struct pinctrl_dev *pctldev;
+	int ret, pin;
+
+	ret = pinctrl_get_device_gpio_range(gc, offset, &pctldev, &range);
+	if (ret)
+		return ret;
+
+	ops = pctldev->desc->confops;
+	if (!ops || !ops->pin_config_get)
+		return -EINVAL;
+
+	mutex_lock(&pctldev->mutex);
+	pin = gpio_to_pin(range, gc, offset);
+	ret = ops->pin_config_get(pctldev, pin, config);
+	mutex_unlock(&pctldev->mutex);
+
+	if (ret)
+		return ret;
+
+	*config = pinconf_to_config_argument(*config);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(pinctrl_gpio_get_config);
+
 static struct pinctrl_state *find_state(struct pinctrl *p,
 					const char *name)
 {
diff --git a/include/linux/pinctrl/consumer.h b/include/linux/pinctrl/consumer.h
index 73de70362b98..e5815b3382dc 100644
--- a/include/linux/pinctrl/consumer.h
+++ b/include/linux/pinctrl/consumer.h
@@ -35,6 +35,8 @@ int pinctrl_gpio_direction_output(struct gpio_chip *gc,
 				  unsigned int offset);
 int pinctrl_gpio_set_config(struct gpio_chip *gc, unsigned int offset,
 				unsigned long config);
+int pinctrl_gpio_get_config(struct gpio_chip *gc, unsigned int offset,
+			    unsigned long *config);
 
 struct pinctrl * __must_check pinctrl_get(struct device *dev);
 void pinctrl_put(struct pinctrl *p);
@@ -96,6 +98,13 @@ pinctrl_gpio_direction_output(struct gpio_chip *gc, unsigned int offset)
 	return 0;
 }
 
+static inline int
+pinctrl_gpio_get_config(struct gpio_chip *gc, unsigned int offset,
+			unsigned long *config)
+{
+	return 0;
+}
+
 static inline int
 pinctrl_gpio_set_config(struct gpio_chip *gc, unsigned int offset,
 			    unsigned long config)
-- 
2.47.2


