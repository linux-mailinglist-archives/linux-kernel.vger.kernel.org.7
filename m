Return-Path: <linux-kernel+bounces-876025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EDEC7C1A792
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 14:02:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2835F58293F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 12:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 945D33563E0;
	Wed, 29 Oct 2025 12:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="WR9+EXbh"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34F035504E
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 12:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761740946; cv=none; b=XmebRPGuQz0xslGiM3Idml2el8S3sHxH+yA5RWgmlb5mQ9LX89o9tBalsUE+BdRWDlNnJEp37NYURSS+HlmW2+gZe8U524yho6CKO4eXjmbxu4RbtQlBYRPUJIFX4Wzc7KFahWNS21osU8m0Tws5Dl/yXQsG/63i/6QAXWWJEhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761740946; c=relaxed/simple;
	bh=pihEqw63iH8miaFJi/OO1LHWkAM8Q7yQvsG/Unqag2M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UKuQnIt/LZO8Xe5p/IgA78F0ZAYXej0WdAxc/qT4ScQ6G63aJFTDKQ87VOB/avXIMqKyNfkAsqg5CqYFjzczaPArmhXO8oaHtKlvADdga//dmMhyknJmJNuNn9wgfkeky9rkf3GZJYYs4FWXvFDdzKR5yLfaHy/IiOMnbIC+ohU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=WR9+EXbh; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-47118259fd8so56018645e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 05:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1761740942; x=1762345742; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cKWwb+CWR52sgUt18Trk69nB3HUB32xJzIqtVQA5qjo=;
        b=WR9+EXbh1JT2hN6kYidRWlnEbB9zJanMCKu74aeCF+PQz1Ym4bYQxSFviEAsFcM9uH
         CveF8xtcFMNZ0R/Gjk8J2Qs9rEpTC2ZdljqlwZSH9Ltzwj4ftfqEAFWzSXcWIMXwpQsI
         pp44SWFtnPrYDOkL8pq7gPQiH422RUmXwXnq14B8L9P7bREyU6VdVykuiVDfDHHJxy/t
         5aqFy+/+Nx0TnAj8jC9Ligr5czwxlP0QhriQC9oWOYJ41ZYwsgHSQPgtRvfMPCzJQDZc
         3WfDiZi/TG5j1tfUBx9smtuYaPT6RHj4t/+wFmTSBIbQMl5Zj50qVihkDOfveWi6vUBq
         TL3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761740942; x=1762345742;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cKWwb+CWR52sgUt18Trk69nB3HUB32xJzIqtVQA5qjo=;
        b=sc20qGI+rKFmOmkXFMp2huUHcKyJSxT1mTN/GCKTQ4lyIM6Awf/FfC8aNLyqmW3/2Z
         XbbGD81ni29Yf+MaXtUY+TNGAucMswxal4fygXNysShDCteu+Z3aulAPH8YSpaCSBl+c
         F8gQRYKDd9EQ/blsvHCaXf2mGb6qcdYd8lKv/vCsWp0wF1IgF76MKXcTRJSLGDmDrXij
         OXRDmIyi2aqxobUmfLPmR680t65iGVFFujRgezYyR0/heV+YKBbhJ6GkeGrg2EVM21A7
         IQEL05nqHRCU+4PO4odbm6XdwkFygYrCeRfqjIeBflcy6byWM98cutm1lWYqiJCQ07+Y
         HBKQ==
X-Forwarded-Encrypted: i=1; AJvYcCVkqJaEJ0yicT62WPu+pOzFpTqaBriEEfvUiU4IQKMbt3jhJHOdZ86ObX9l3XivP2OoidwDA02i8nyHEIw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcA7fNv4ReFZ3is4ddx5lRhOKJxSJVnKcO1H6zqVSY0df3eEWV
	L4hRdWJH2+M9UPrqOQIoK1qH26wyuGuVQSec+ZWmMb4xBck7reQw0kFa3mkX4S2ry2c=
X-Gm-Gg: ASbGnct0T9js6YpTmE+KlWvOr1rd8eLcmVLDkqVJu/LQgUZrQjklbPBMVkMDpQU+qC7
	0Xrobe8uUyONij7ua402GHwHwlI1f2N32cGZgapLgKT39PSZ133+PIgysHp7pwX0jkk/M06R/5C
	Pugj9Zj3f/hkucy6x+9Wvutg+ujdwh4KHw+mAmbz3DxWuZ9giGlPiJnRdSs2unQGpe/1ZGgpl0c
	Br3+tUYEu+dBnJykJdIW1KZFh3PK468JazmpLx+V/kJCgohejJMp2e+/jduD65+6sPbvGRpocsH
	Hmp6FcpqfjejYaPA1z5E7oIAScitACMMGPj+Nkj/zHUjuPgsYkFa6rCMLvlWL+yg1hWDNwpEnfd
	XdwjWw51smeXqVNmLMA/N610lu2ywRnXxN6oLRbm0gL7t15uixWTsoMWORZwcRSS19DKSDZ+VUI
	4d/Od9
X-Google-Smtp-Source: AGHT+IE2bEto6dm9kgomx9Gy3unCJ/VhB2xVUZhKdQJiKPMytSociWC/cTOVz5iTb0q8YRFWnxzeig==
X-Received: by 2002:a05:600c:46cc:b0:471:95a:60c9 with SMTP id 5b1f17b1804b1-4771e19ac2dmr27909795e9.8.1761740942232;
        Wed, 29 Oct 2025 05:29:02 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:69f2:5f2d:9ffc:a805])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4771e3a88fdsm52775545e9.10.2025.10.29.05.29.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 05:29:01 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 29 Oct 2025 13:28:42 +0100
Subject: [PATCH v3 08/10] reset: make the provider of reset-gpios the
 parent of the reset device
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-reset-gpios-swnodes-v3-8-638a4cb33201@linaro.org>
References: <20251029-reset-gpios-swnodes-v3-0-638a4cb33201@linaro.org>
In-Reply-To: <20251029-reset-gpios-swnodes-v3-0-638a4cb33201@linaro.org>
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
 bh=GNsd7cWIVZyy+GvsDtQHGz7ZcDSeeiM7GomXTvhzcVM=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBpAgh+tbOHr2GtTYTKacQBaZS5LtYi0PYkjtcyS
 ZfHQCN0aDiJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaQIIfgAKCRARpy6gFHHX
 ct0eD/wJC+3IUqoToQlEO+77Y3Otupc+hBKyQ/4jPAzJRFTzE3xxnUdKdBUpWyvfHGdP7wSZPg6
 srN+4v97xnr+HgiTv3gF5tBVCxevzClXWLcVa+AMvcsdBw4qcFHif3XyiINmNtuOsGAoamIzh1d
 zOzwAGGOvQjqLaNrHmrHr558/Q/Ih8SBsEEHOeabr297FYe20dyCHEcDC3/mPDFN/L8CSCW9uoH
 qObFhUFkpqCCq0fz4XrY5Q5ZCtHnq5YHRl6b8gvaJbF8tEtgxsZ4R5muPFvfCvh1Eynp14oD2DF
 7JMOyHum/eWLWPQ0wFKyn9ktXBx1bldmIo0dcWIel96W0fXuuBUV4qvh43g1uiKkGB6APT5NAyI
 rZqWCJ/tiXOb00mzC6jhA0+EyseKzkQzwI86HT3GtElh0RVblkaxzJO9d32EjJt0HMPuMfbD6sH
 kkFzbokCJEkGmkZYBCuexXDTAi1iuYwqPaGaKMNLGeXrCrxmkYDbfmZVECPRLcVgv1b7Zk+NkJE
 8TXmT1AfQCtJmqJOvRnSz11OWaAltF2XzUypqfJub/tz0l3c7c2rENCt0UJ6N+iJENi1c1/5T5O
 idZ29DHHttNu5Q+fOhvGSDZIjO7e3tLEZJ5FolBTx5I9fGGZG5bkT74NnDuTfSs623EMAhbskn2
 2wbdyblzG9NPa9A==
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
index 5a696e2dbcc224a633e2b321da53b7bc699cb5f3..13236ab69f10ec80e19b982be2bee5e4b0f99388 100644
--- a/drivers/reset/core.c
+++ b/drivers/reset/core.c
@@ -849,11 +849,11 @@ static void __reset_control_put_internal(struct reset_control *rstc)
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
 
@@ -868,10 +868,6 @@ static int __reset_add_reset_gpio_lookup(int id, struct device_node *np,
 		return -EINVAL;
 	}
 
-	struct gpio_device *gdev __free(gpio_device_put) = gpio_device_find_by_fwnode(fwnode);
-	if (!gdev)
-		return -EPROBE_DEFER;
-
 	label_tmp = gpio_device_get_label(gdev);
 	if (!label_tmp)
 		return -EINVAL;
@@ -926,6 +922,11 @@ static int __reset_add_reset_gpio_device(const struct of_phandle_args *args)
 	 */
 	lockdep_assert_not_held(&reset_list_mutex);
 
+	struct gpio_device *gdev __free(gpio_device_put) =
+		gpio_device_find_by_fwnode(of_fwnode_handle(args->np));
+	if (!gdev)
+		return -EPROBE_DEFER;
+
 	guard(mutex)(&reset_gpio_lookup_mutex);
 
 	list_for_each_entry(rgpio_dev, &reset_gpio_lookup_list, list) {
@@ -946,7 +947,7 @@ static int __reset_add_reset_gpio_device(const struct of_phandle_args *args)
 		goto err_ida_free;
 	}
 
-	ret = __reset_add_reset_gpio_lookup(id, args->np, args->args[0],
+	ret = __reset_add_reset_gpio_lookup(gdev, id, args->np, args->args[0],
 					    args->args[1]);
 	if (ret < 0)
 		goto err_kfree;
@@ -958,7 +959,8 @@ static int __reset_add_reset_gpio_device(const struct of_phandle_args *args)
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
2.48.1


