Return-Path: <linux-kernel+bounces-888737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 36107C3BC52
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 15:34:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id ADE013512D3
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 14:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B12D3431F1;
	Thu,  6 Nov 2025 14:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="YF5neq0L"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A7F341ADE
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 14:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762439577; cv=none; b=A9UtHGIA91FVYBmms3pUPA/nT6GqIW/gftkxIyJs0vUjkCk5974kN9HmXMd59cRk3r8FLmQn3ToGT4C1nzbSlLm8NR+Fg1k8VmcfcY4KEVY0GXlmLeHOlk/zAU5yRq8WEriLZzuG55zHz4OVswR60aj3cQqSP5yn5pIoro04QfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762439577; c=relaxed/simple;
	bh=WYtsFizQbM4aE384TZ7sPETgegiBGiPMgwHuc6DOszI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tJc2AxAIkEvrZxdFdNzjm2jwwoR6TvFbw3CXY04Bh4vt7EihK/1SBmAuNKSSm+pVZsAhXrkRQJuLrTnJXxX+huEuunzEncYrmOtZ0jkfQXSm3FJxLQmBBP+S4x4G4FQ3nxwaBBUMBi1wUjiFttOEZU6BLU29U94JHtcKJ6jyZIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=YF5neq0L; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-477563bcaacso7778025e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 06:32:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1762439574; x=1763044374; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q7IcwkvxZCoeChL6F0/utOZdZpB2dEpp7MA1q4biiOc=;
        b=YF5neq0LuZSHmReuqY3tsUucWbfhNm1STm0BAeH4xA3Q6/5j3PC2PZiVuVGToooGeg
         UX5ICkKqIR5Vsm2M1THtGDM3jiOv2sZIiDdsLoz7UriH4wHywsUIgdtxeCcdVTrtX3sU
         d5NwXVGcJLKpA/jnhfqAHg6daID1upjNqAcjrmJrM4bMGs6JvKUKWFlYpdxjo9bsY8O0
         gN6/UkiDE0fBDFgIkBVG8N7FN94k/LeNqJToHoSCxDwbbcuG0xKa26DL8XjdtAqcz2hE
         6QhuKLVhZOLsIq+uCW3IZggqfoZw/0AajJma7t9q1st7HahuRNCvJr5dRN5IAlM3qrpD
         SSVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762439574; x=1763044374;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q7IcwkvxZCoeChL6F0/utOZdZpB2dEpp7MA1q4biiOc=;
        b=J28m/1qWtBalkKdL6rfJxQ6OukDCAt2EoBl7uRiRp437iL+312jkZvMSI/APB10sLy
         83nzl5394ddF/XjRuXIlBIABAJN0QWxqxgsPKvx3HnO4xkryYw6awFVPRXckeDFSV7jb
         5KWH6cKUPCH4vOckvrBO34+6m1NsfiVFJnPKdIjZA7HxMjxMj3XozBI6HJVPev3mZeFC
         lCQTab/ScOb4wWiwWjEPMrdE8ZEWve+S3+13WSiKiLTdV0Uu5NtXVYn4WDyt1G/+seBO
         7PF6CENXMIuAVu9rr9lhc8xKl+XQEyU9Z09Z9wWbJejoZ6lwIfcoRzUlH8d7NA8eyJzv
         NEiQ==
X-Forwarded-Encrypted: i=1; AJvYcCWJpaxBHQLAa5fTwLu2hxarBLPZ0sogxX9BdKPIJBRtUgvJI8+Q9WP1de/2uu5nJzOFSlZaoH8yGwPk3b8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7C3E64C8v72ACtAXYaiIEYGoETj0hDKRiECzhfZox5OcZ1GBG
	rda0fm72S/CNNi4niGylzJKvyl4nBtQ72Iq6AdsoxBkcZiNWPdz/7eYNP9eCzznin3k=
X-Gm-Gg: ASbGncuB/MEnXuOGcd6/XLf4Jy8Dc8A+fBS71hpqdnEuuVZpox0ld7Qzf0Ek/v8F3YO
	gGiU/FJ+5WwUUsTatdGeCISqiLYXIII/SJse3GAjOQPURlbWwHRrLB2IRPaiuNMEzLD/XXH/Z6x
	lCssLbyvBUi8ecgIbB5+s3I7xhuJ3dHFd2oJnPvVXNPpbctmt3UO8LPArApOHBZIEect4yIrVYS
	mjmfyEkzGLtvCWypUUEHYfZJjsa5Bx6kXtqsADiFOiktOPT/7FK2VPxEFYVi/rMHHi5pFDl3uaF
	iIt91E4gWEX3NCN3JlzWC73szv8c7IwS/DCA103N80QJJ8McQcpmeFtv+gS7n29BPrgEK5gxAs0
	PgxzxQsAwiJ7mwSs2qRPq3voulii9Y7HdyZI9VYYRbLc3s9Q1ZYMjOgGOc+A+Cnd4ksRO
X-Google-Smtp-Source: AGHT+IHJdCKOGEmHwglYreXy5Bse1Ht9Zj2E+rvSJcOa7E6LW1TY2KvZ//8CiDhbRc9P4HFHJuuwfA==
X-Received: by 2002:a05:600c:1c94:b0:477:fcb:2256 with SMTP id 5b1f17b1804b1-4775ce23efemr74189185e9.17.1762439573533;
        Thu, 06 Nov 2025 06:32:53 -0800 (PST)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:d9de:4038:a78:acab])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47763de4fb5sm18871515e9.2.2025.11.06.06.32.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 06:32:52 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 06 Nov 2025 15:32:35 +0100
Subject: [PATCH v6 6/8] reset: make the provider of reset-gpios the parent
 of the reset device
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251106-reset-gpios-swnodes-v6-6-69aa852de9e4@linaro.org>
References: <20251106-reset-gpios-swnodes-v6-0-69aa852de9e4@linaro.org>
In-Reply-To: <20251106-reset-gpios-swnodes-v6-0-69aa852de9e4@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3056;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=Ii5gmVXHOWj2TYAgDLdwPMX22jyvG1TmKArdiO0SOxI=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBpDLGI5l3FF3L3dsFEJ/gvixZtSLWIepU2+Aso+
 YY1e1LkzYOJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaQyxiAAKCRARpy6gFHHX
 cpZ5EADbU7IR5S1TwL7Fd99QpM8Zu7t+FI68IXzt5a8gczcc8DHYtzF814Z4g+uLAosB9HysHM9
 bgQ9kJ6RptXNasK4DBVpPBWZUoJqh1FrO3P6ZEn05eNRjC1hGK5wbUXUK6QuVgt8cv+4GsffJgc
 yD0YY344Q2MNZoACpGMXk+Wol+46SpvC0S7nZyvZjQaDgce9OdKegYKZraO/T9P1/Z2dc7WRek9
 ntSAx6+BPc1pJfBNwXye4Xgh2YMR+sYiooRo0at3VsAkz9dtl/8ZyiPpHdNnwjOXpHGysZx0DwR
 FmZfcDuxMLURmQ7Oz5aQmHxTcTrPQ6tZoZr5/8vGVuKzMcAI1/KlgNoRmJ8Ub6nz/WSkrOKedX4
 kNZSMoQUjUWdbZyu7Cl4uFbydqL7czxfFHc2z3l+KS3iGiCKAJkm4yL9RDRFBK/bUARKg7Np6Vf
 TM0gw19HFDXWiU84ITZdYMEWk4rIJcsPxKQtEg1I5ARjdNISOAn0xNPFIi29R7oGfPqsCC08RMG
 SKGkYxNtPy6wlm1CAfVld627EufBBupmHoOoqYlJwskfKwmVqH1So4/DqnDAU1fd3gZCJQ/SbmZ
 iBjnmE3YKQCLrpeEDrtMy5eH+8F6K7FJ7GYZVv/ytQoGCtHnZeO5SZBuAkVoaZabjg94L+t4Pwb
 PGgwI84FvtIuyzg==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Auxiliary devices really do need a parent so ahead of converting the
reset-gpios driver to registering on the auxiliary bus, make the GPIO
device that provides the reset GPIO the parent of the reset-gpio device.
To that end move the lookup of the GPIO device by fwnode to the
beginning of __reset_add_reset_gpio_device() which has the added benefit
of bailing out earlier, before allocating resources for the virtual
device, if the chip is not up yet.

Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/reset/core.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/reset/core.c b/drivers/reset/core.c
index b3d3339dd6d30495b498b3f650d18fdd96a6bca7..31dcd25b465d795dda275f751ed6ce28d4dc27ee 100644
--- a/drivers/reset/core.c
+++ b/drivers/reset/core.c
@@ -822,11 +822,11 @@ static void __reset_control_put_internal(struct reset_control *rstc)
 	kref_put(&rstc->refcnt, __reset_control_release);
 }
 
-static int __reset_add_reset_gpio_lookup(int id, struct device_node *np,
+static int __reset_add_reset_gpio_lookup(struct gpio_device *gdev, int id,
+					 struct device_node *np,
 					 unsigned int gpio,
 					 unsigned int of_flags)
 {
-	const struct fwnode_handle *fwnode = of_fwnode_handle(np);
 	unsigned int lookup_flags;
 	const char *label_tmp;
 
@@ -841,10 +841,6 @@ static int __reset_add_reset_gpio_lookup(int id, struct device_node *np,
 		return -EINVAL;
 	}
 
-	struct gpio_device *gdev __free(gpio_device_put) = gpio_device_find_by_fwnode(fwnode);
-	if (!gdev)
-		return -EPROBE_DEFER;
-
 	label_tmp = gpio_device_get_label(gdev);
 	if (!label_tmp)
 		return -EINVAL;
@@ -899,6 +895,11 @@ static int __reset_add_reset_gpio_device(const struct of_phandle_args *args)
 	 */
 	lockdep_assert_not_held(&reset_list_mutex);
 
+	struct gpio_device *gdev __free(gpio_device_put) =
+		gpio_device_find_by_fwnode(of_fwnode_handle(args->np));
+	if (!gdev)
+		return -EPROBE_DEFER;
+
 	guard(mutex)(&reset_gpio_lookup_mutex);
 
 	list_for_each_entry(rgpio_dev, &reset_gpio_lookup_list, list) {
@@ -919,7 +920,7 @@ static int __reset_add_reset_gpio_device(const struct of_phandle_args *args)
 		goto err_ida_free;
 	}
 
-	ret = __reset_add_reset_gpio_lookup(id, args->np, args->args[0],
+	ret = __reset_add_reset_gpio_lookup(gdev, id, args->np, args->args[0],
 					    args->args[1]);
 	if (ret < 0)
 		goto err_kfree;
@@ -931,7 +932,8 @@ static int __reset_add_reset_gpio_device(const struct of_phandle_args *args)
 	 * Hold reference as long as rgpio_dev memory is valid.
 	 */
 	of_node_get(rgpio_dev->of_args.np);
-	pdev = platform_device_register_data(NULL, "reset-gpio", id,
+	pdev = platform_device_register_data(gpio_device_to_device(gdev),
+					     "reset-gpio", id,
 					     &rgpio_dev->of_args,
 					     sizeof(rgpio_dev->of_args));
 	ret = PTR_ERR_OR_ZERO(pdev);

-- 
2.51.0


