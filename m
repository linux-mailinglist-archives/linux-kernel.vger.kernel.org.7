Return-Path: <linux-kernel+bounces-820610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56ACEB7CC0A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:09:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C3D17A6C0E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 12:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 504153233F7;
	Wed, 17 Sep 2025 12:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h1rqRLGK"
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A8D31A7E9
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 12:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758110867; cv=none; b=n9QkuD6brd1vHWv2ZPR6L6KZdKGaRO0Cn25BC/pvdOd7XJu29s38fNAxvYdbs+plBa1bP4z8QYmT9vtOpJpQb5I2qxasd4ykt39Gcqf1RPtSBMfgYAAD3Z0zwuMSTJsZSEBAD23JGzg2F3DCRZYNG6FDjlUikgHtq5oU45+1vgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758110867; c=relaxed/simple;
	bh=0Ha7m8b/+ZHVHZAlQIkXhY2JBJJqlstM5Tl623XLNO0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nRwOVfUtRVQ3jh8f55h1bsLA7toietgjQGdgu2H87MX37z19Pf0BlZGxJ4hCVO170Eeq8ojoLyq4FxonSv61oXyOWW7AWuSbvDby54TlTgeYbZ/QfyJlf/V0Kf/YGzac6YytyDnoGeX9/SNnvW2qu213AdkTEzqi54rXISpGGLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--srosek.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=h1rqRLGK; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--srosek.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-3ecdfe971abso550291f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 05:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758110863; x=1758715663; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=iM2iOBhF3jTNwGiyMt11FxfeniZGf805/faeSnHTQeo=;
        b=h1rqRLGKrFFIgQWSLGXPRud2BJGDA1O6bWOV2uskUQCr+YsiW9ZHpchmyZ0tw8tmS+
         M8WhmIP+KiCH/dHwOcE7foBNbBzJTFEFkd4yOetNES3aoynbMHqFrTjJAy8Ex8Ow2f4y
         E2MHBUD6JBB7jdHUKvphyl2wGiwx1tg7cFmTUCHpBEZLW0d38fe17id+9ecJfpBdqmTg
         4CHXg3bwufnOtZefGhsncXYdmusY8ut/q01KucjYnUL/08q/q6EtX2nx16MfI2tBHNUZ
         t5iJzmMguylJI9Zy68theTlt5jXk1wdlTKLXVSUbj7tYyXw+ORdnUKxLpgjxSOinXMZb
         Ffbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758110863; x=1758715663;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iM2iOBhF3jTNwGiyMt11FxfeniZGf805/faeSnHTQeo=;
        b=QpdcUawaCt1/uRAJBkmUnMM0WI74SHhyQ27Nu6ftdYg1KADDdEXYF8B3iEX4E+0MBw
         aOYWGAeOr+zvOAKx5lsrCS2YBeruV+nv66Q1d9y46ovmBTVbYLvuckIO/ZkLKseBJWet
         Mta1wvlnrv8RgEAWFsJul5+KGJobag8MY6NfSla+qDA5tFQJ5VP5mdmZkTIbu0yV1/8K
         0hQbdMAQSWc1RpWdqOC6Hnsz5BJjkFRDTE4iATNEb2Ocdz1NqhTg8IE77EgVT9z9C4/a
         31eO0kEOnR7TAaICUDV/IwCSpbCjBOvBf8fhcb/IzBDpn9FBX3XoWGomNJRduDPpqnqg
         wEyg==
X-Forwarded-Encrypted: i=1; AJvYcCWNotOgMrhNiuCuWpa1Rb73OTZWEmwtXAqpvtL9PLsCJIUJylD4PDcSoCfwM3F13c5glp1ZOPi4jdHXB3M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfTnOaklXxZhZKQWTXpbaK1TnNhgX/I4mmyJQlLA86zFeSBn72
	dpRHxkI2q8hiXigjRuEhbZO4mYsj7VL4BFzaADFwbSHsv7+cVvrRmvNqoqFKj+y1vVdELOY2qlC
	gnec7Mw==
X-Google-Smtp-Source: AGHT+IEFmZwObfFR6PR74lZUpnUMvooCASwa43V7SnenyQCqtdR5oiv4vgIEIY4/wx+xKfDpXGuPB3huCAc=
X-Received: from wrbhb2.prod.google.com ([2002:a05:6000:4902:b0:3ea:892d:90cf])
 (user=srosek job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6000:178e:b0:3e5:25c2:9637
 with SMTP id ffacd0b85a97d-3ecdf9ba45bmr1712866f8f.17.1758110863238; Wed, 17
 Sep 2025 05:07:43 -0700 (PDT)
Date: Wed, 17 Sep 2025 12:07:18 +0000
In-Reply-To: <20250917120719.2390847-1-srosek@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250917120719.2390847-1-srosek@google.com>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250917120719.2390847-6-srosek@google.com>
Subject: [PATCH v2 5/6] ACPI: platform: Add macro for acpi platform driver
From: Slawomir Rosek <srosek@google.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>, Alex Hung <alexhung@gmail.com>, 
	Hans de Goede <hansg@kernel.org>, Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>, 
	AceLan Kao <acelan.kao@canonical.com>, Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Zhang Rui <rui.zhang@intel.com>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Tomasz Nowicki <tnowicki@google.com>, 
	Stanislaw Kardach <skardach@google.com>, Michal Krawczyk <mikrawczyk@google.com>, 
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
	platform-driver-x86@vger.kernel.org, linux-pm@vger.kernel.org, 
	Slawomir Rosek <srosek@google.com>
Content-Type: text/plain; charset="UTF-8"

Introduce module_acpi_platform_driver() macro to simplify dynamic
enumeration of ACPI device objects on the platform bus by loadable
modules. Move common code from the intel-hid and intel-vbtn drivers
to the ACPI platform core.

Signed-off-by: Slawomir Rosek <srosek@google.com>
---
 drivers/acpi/acpi_platform.c      | 27 +++++++++++++++++++++++++
 drivers/platform/x86/intel/hid.c  | 33 +++----------------------------
 drivers/platform/x86/intel/vbtn.c | 30 +---------------------------
 include/linux/platform_device.h   | 17 ++++++++++++++++
 4 files changed, 48 insertions(+), 59 deletions(-)

diff --git a/drivers/acpi/acpi_platform.c b/drivers/acpi/acpi_platform.c
index 48d15dd785f6..adf32ffa6be6 100644
--- a/drivers/acpi/acpi_platform.c
+++ b/drivers/acpi/acpi_platform.c
@@ -190,6 +190,33 @@ struct platform_device *acpi_create_platform_device(struct acpi_device *adev,
 }
 EXPORT_SYMBOL_GPL(acpi_create_platform_device);
 
+static acpi_status
+__acpi_platform_driver_register_cb(acpi_handle handle, u32 lvl,
+				void *context, void **rv)
+{
+	const struct acpi_device_id *ids = context;
+	struct acpi_device *dev = acpi_fetch_acpi_dev(handle);
+
+	if (dev && acpi_match_device_ids(dev, ids) == 0)
+		if (!IS_ERR_OR_NULL(acpi_create_platform_device(dev, NULL))) {
+			dev_info(&dev->dev,
+				 "created platform device\n");
+		}
+
+	return AE_OK;
+}
+
+int __acpi_platform_driver_register(struct platform_driver *drv,
+				struct module *owner)
+{
+	acpi_walk_namespace(ACPI_TYPE_DEVICE, ACPI_ROOT_OBJECT, ACPI_UINT32_MAX,
+			    __acpi_platform_driver_register_cb, NULL,
+			    (void *)drv->driver.acpi_match_table, NULL);
+
+	return __platform_driver_register(drv, owner);
+}
+EXPORT_SYMBOL_GPL(__acpi_platform_driver_register);
+
 void __init acpi_platform_init(void)
 {
 	acpi_reconfig_notifier_register(&acpi_platform_notifier);
diff --git a/drivers/platform/x86/intel/hid.c b/drivers/platform/x86/intel/hid.c
index f25a427cccda..37f990686446 100644
--- a/drivers/platform/x86/intel/hid.c
+++ b/drivers/platform/x86/intel/hid.c
@@ -775,34 +775,7 @@ static struct platform_driver intel_hid_pl_driver = {
  *
  * As a workaround until the ACPI core figures out how to handle
  * this corner case, manually ask the ACPI platform device code to
- * claim the ACPI node.
+ * claim the ACPI node by using module_acpi_platform_driver()
+ * instead of the regular module_platform_driver().
  */
-static acpi_status __init
-check_acpi_dev(acpi_handle handle, u32 lvl, void *context, void **rv)
-{
-	const struct acpi_device_id *ids = context;
-	struct acpi_device *dev = acpi_fetch_acpi_dev(handle);
-
-	if (dev && acpi_match_device_ids(dev, ids) == 0)
-		if (!IS_ERR_OR_NULL(acpi_create_platform_device(dev, NULL)))
-			dev_info(&dev->dev,
-				 "intel-hid: created platform device\n");
-
-	return AE_OK;
-}
-
-static int __init intel_hid_init(void)
-{
-	acpi_walk_namespace(ACPI_TYPE_DEVICE, ACPI_ROOT_OBJECT,
-			    ACPI_UINT32_MAX, check_acpi_dev, NULL,
-			    (void *)intel_hid_ids, NULL);
-
-	return platform_driver_register(&intel_hid_pl_driver);
-}
-module_init(intel_hid_init);
-
-static void __exit intel_hid_exit(void)
-{
-	platform_driver_unregister(&intel_hid_pl_driver);
-}
-module_exit(intel_hid_exit);
+module_acpi_platform_driver(intel_hid_pl_driver);
diff --git a/drivers/platform/x86/intel/vbtn.c b/drivers/platform/x86/intel/vbtn.c
index 232cd12e3c9f..42932479de35 100644
--- a/drivers/platform/x86/intel/vbtn.c
+++ b/drivers/platform/x86/intel/vbtn.c
@@ -390,32 +390,4 @@ static struct platform_driver intel_vbtn_pl_driver = {
 	.remove = intel_vbtn_remove,
 };
 
-static acpi_status __init
-check_acpi_dev(acpi_handle handle, u32 lvl, void *context, void **rv)
-{
-	const struct acpi_device_id *ids = context;
-	struct acpi_device *dev = acpi_fetch_acpi_dev(handle);
-
-	if (dev && acpi_match_device_ids(dev, ids) == 0)
-		if (!IS_ERR_OR_NULL(acpi_create_platform_device(dev, NULL)))
-			dev_info(&dev->dev,
-				 "intel-vbtn: created platform device\n");
-
-	return AE_OK;
-}
-
-static int __init intel_vbtn_init(void)
-{
-	acpi_walk_namespace(ACPI_TYPE_DEVICE, ACPI_ROOT_OBJECT,
-			    ACPI_UINT32_MAX, check_acpi_dev, NULL,
-			    (void *)intel_vbtn_ids, NULL);
-
-	return platform_driver_register(&intel_vbtn_pl_driver);
-}
-module_init(intel_vbtn_init);
-
-static void __exit intel_vbtn_exit(void)
-{
-	platform_driver_unregister(&intel_vbtn_pl_driver);
-}
-module_exit(intel_vbtn_exit);
+module_acpi_platform_driver(intel_vbtn_pl_driver);
diff --git a/include/linux/platform_device.h b/include/linux/platform_device.h
index 074754c23d33..3b70b054d8a5 100644
--- a/include/linux/platform_device.h
+++ b/include/linux/platform_device.h
@@ -264,6 +264,14 @@ extern int __platform_driver_register(struct platform_driver *,
 					struct module *);
 extern void platform_driver_unregister(struct platform_driver *);
 
+/*
+ * use a macro to avoid include chaining to get THIS_MODULE
+ */
+#define acpi_platform_driver_register(drv) \
+	__acpi_platform_driver_register(drv, THIS_MODULE)
+extern int __acpi_platform_driver_register(struct platform_driver *,
+					struct module *);
+
 /* non-hotpluggable platform devices may use this so that probe() and
  * its support may live in __init sections, conserving runtime memory.
  */
@@ -292,6 +300,15 @@ static inline void platform_set_drvdata(struct platform_device *pdev,
 	module_driver(__platform_driver, platform_driver_register, \
 			platform_driver_unregister)
 
+/* module_acpi_platform_driver() - Helper macro for drivers that don't do
+ * anything special in module init/exit.  This eliminates a lot of
+ * boilerplate.  Each module may only use this macro once, and
+ * calling it replaces module_init() and module_exit()
+ */
+#define module_acpi_platform_driver(__platform_driver) \
+	module_driver(__platform_driver, acpi_platform_driver_register, \
+			platform_driver_unregister)
+
 /* builtin_platform_driver() - Helper macro for builtin drivers that
  * don't do anything special in driver init.  This eliminates some
  * boilerplate.  Each driver may only use this macro once, and
-- 
2.51.0.384.g4c02a37b29-goog


