Return-Path: <linux-kernel+bounces-879012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 142CAC22062
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 20:41:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BFF6D4EE583
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 19:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F24CB30277A;
	Thu, 30 Oct 2025 19:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rong.moe header.i=i@rong.moe header.b="TBzHyEPt"
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84EB3115BD;
	Thu, 30 Oct 2025 19:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761853237; cv=pass; b=pLkqYkb2i24vts1NuV7XqLq31EUQ9WqQl9R6G5q+3HhnnypfW3WGArfcM66IGB9EAevPoJ+dLCX6zkYO8tmBxYzbooT/lVw8d+vSqoPY1tAR35i0tedBttC27egmsv1n7FoO1kBuxMCENiCq7Tvk2oT1M8alJbPtfIG6rzG9sH4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761853237; c=relaxed/simple;
	bh=EwYSFip0xkxdisetFsKc41eDAaNkw1CybzBwPukMbfU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sUCDsgMQZ/A1rWhqw96iVNyScAGwFq62TjdW968eNnhdNRfaC0m09C2c9kEFkyubv0HIBcbJmw/rCqpVdSaRWvYM0fQmU6R8igU8iTxZa/WuHeDksIbgD2CqGzrzdzS4NC1l20KBZ2DJ0D+JyKJ9tlt6srIf+Jd4L3oEt0w9yvY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe; spf=pass smtp.mailfrom=rong.moe; dkim=pass (1024-bit key) header.d=rong.moe header.i=i@rong.moe header.b=TBzHyEPt; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
ARC-Seal: i=1; a=rsa-sha256; t=1761853211; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=fO8u98XRtsck7+r0IMwlpCOZHX/H2jNkctJiGKn4iuIdKx6hL3QsGIgC1txkAhCKTu+O32BshqrjGcDm7Q5g9J6LqTedKluTWc/ivG6nBi7ryMOrvaP1QS/D5AVti16Xl1eKzChnrbMq+jm2jrLKF9tMWfGi/VWUdaBkZvxBLnY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1761853211; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=mZgUt+m54r4jkjTBdacgIeZ0G6OG0Fd7S0/uWDZzHYE=; 
	b=kZ61Q8u4la7Zd71DowcYbXcpve/r0TZrL0nSJey0cTEZZfeA1YN3ggdfqsJqgi5TTvgS/7zkKE/2lFHhtaUUcHaCCi1j5/8ekWoGjWCwuqbNIVK0e4Izrc6uYQQxrHIRyAAUdCsfHwH2CTWGUa5x9wG6VCnsOjayOr4GCPwM0cM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1761853211;
	s=zmail; d=rong.moe; i=i@rong.moe;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=mZgUt+m54r4jkjTBdacgIeZ0G6OG0Fd7S0/uWDZzHYE=;
	b=TBzHyEPtC84SwhnDv/s+IFXBLinJRMHTfqVGJdUFUF87Ta5NtV8Mo9uq9L+ira2z
	cUeHYm/J0VkEIMRqJay6YcF/iuvP/P7pIpe2+wNCl3oTRFIK21UXNhjrSKBOFPDL7Z5
	hpRiV6AMyaYPV27pIJYRuqGLtzlPvK0liDilEnLg=
Received: by mx.zohomail.com with SMTPS id 1761853209602940.0128653169317;
	Thu, 30 Oct 2025 12:40:09 -0700 (PDT)
From: Rong Zhang <i@rong.moe>
To: Mark Pearson <mpearson-lenovo@squebb.ca>,
	"Derek J. Clark" <derekjohn.clark@gmail.com>,
	Armin Wolf <W_Armin@gmx.de>,
	Hans de Goede <hansg@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Rong Zhang <i@rong.moe>,
	Guenter Roeck <linux@roeck-us.net>,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org
Subject: [PATCH v2 2/6] platform/x86: Rename lenovo-wmi-capdata01 to lenovo-wmi-capdata
Date: Fri, 31 Oct 2025 03:39:40 +0800
Message-ID: <20251030193955.107148-3-i@rong.moe>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251030193955.107148-1-i@rong.moe>
References: <20251030193955.107148-1-i@rong.moe>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Prepare for the upcoming changes to make it suitable to retrieve
and provide other Capability Data as well.

Signed-off-by: Rong Zhang <i@rong.moe>
Reviewed-by: Derek J. Clark <derekjohn.clark@gmail.com>
---
 drivers/platform/x86/lenovo/Kconfig           |   4 +-
 drivers/platform/x86/lenovo/Makefile          |   2 +-
 .../lenovo/{wmi-capdata01.c => wmi-capdata.c} | 124 +++++++++---------
 .../lenovo/{wmi-capdata01.h => wmi-capdata.h} |  10 +-
 drivers/platform/x86/lenovo/wmi-other.c       |  11 +-
 5 files changed, 78 insertions(+), 73 deletions(-)
 rename drivers/platform/x86/lenovo/{wmi-capdata01.c => wmi-capdata.c} (60%)
 rename drivers/platform/x86/lenovo/{wmi-capdata01.h => wmi-capdata.h} (60%)

diff --git a/drivers/platform/x86/lenovo/Kconfig b/drivers/platform/x86/lenovo/Kconfig
index d22b774e0236f..fb96a0f908f03 100644
--- a/drivers/platform/x86/lenovo/Kconfig
+++ b/drivers/platform/x86/lenovo/Kconfig
@@ -233,7 +233,7 @@ config YT2_1380
 	  To compile this driver as a module, choose M here: the module will
 	  be called lenovo-yogabook.
 
-config LENOVO_WMI_DATA01
+config LENOVO_WMI_DATA
 	tristate
 	depends on ACPI_WMI
 
@@ -264,7 +264,7 @@ config LENOVO_WMI_TUNING
 	tristate "Lenovo Other Mode WMI Driver"
 	depends on ACPI_WMI
 	select FW_ATTR_CLASS
-	select LENOVO_WMI_DATA01
+	select LENOVO_WMI_DATA
 	select LENOVO_WMI_EVENTS
 	select LENOVO_WMI_HELPERS
 	help
diff --git a/drivers/platform/x86/lenovo/Makefile b/drivers/platform/x86/lenovo/Makefile
index 7b2128e3a2142..29014d8c1376d 100644
--- a/drivers/platform/x86/lenovo/Makefile
+++ b/drivers/platform/x86/lenovo/Makefile
@@ -12,7 +12,7 @@ lenovo-target-$(CONFIG_LENOVO_YMC)	+= ymc.o
 lenovo-target-$(CONFIG_YOGABOOK)	+= yogabook.o
 lenovo-target-$(CONFIG_YT2_1380)	+= yoga-tab2-pro-1380-fastcharger.o
 lenovo-target-$(CONFIG_LENOVO_WMI_CAMERA)	+= wmi-camera.o
-lenovo-target-$(CONFIG_LENOVO_WMI_DATA01)	+= wmi-capdata01.o
+lenovo-target-$(CONFIG_LENOVO_WMI_DATA)		+= wmi-capdata.o
 lenovo-target-$(CONFIG_LENOVO_WMI_EVENTS)	+= wmi-events.o
 lenovo-target-$(CONFIG_LENOVO_WMI_HELPERS)	+= wmi-helpers.o
 lenovo-target-$(CONFIG_LENOVO_WMI_GAMEZONE)	+= wmi-gamezone.o
diff --git a/drivers/platform/x86/lenovo/wmi-capdata01.c b/drivers/platform/x86/lenovo/wmi-capdata.c
similarity index 60%
rename from drivers/platform/x86/lenovo/wmi-capdata01.c
rename to drivers/platform/x86/lenovo/wmi-capdata.c
index fc7e3454e71dc..c5e74b2bfeb36 100644
--- a/drivers/platform/x86/lenovo/wmi-capdata01.c
+++ b/drivers/platform/x86/lenovo/wmi-capdata.c
@@ -1,14 +1,17 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * Lenovo Capability Data 01 WMI Data Block driver.
+ * Lenovo Capability Data WMI Data Block driver.
  *
- * Lenovo Capability Data 01 provides information on tunable attributes used by
- * the "Other Mode" WMI interface. The data includes if the attribute is
- * supported by the hardware, the default_value, max_value, min_value, and step
- * increment. Each attribute has multiple pages, one for each of the thermal
- * modes managed by the Gamezone interface.
+ * Lenovo Capability Data provides information on tunable attributes used by
+ * the "Other Mode" WMI interface.
+ *
+ * Capability Data 01 includes if the attribute is supported by the hardware,
+ * and the default_value, max_value, min_value, and step increment. Each
+ * attribute has multiple pages, one for each of the thermal modes managed by
+ * the Gamezone interface.
  *
  * Copyright (C) 2025 Derek J. Clark <derekjohn.clark@gmail.com>
+ *   - Initial implementation (formerly named lenovo-wmi-capdata01)
  */
 
 #include <linux/acpi.h>
@@ -26,55 +29,55 @@
 #include <linux/types.h>
 #include <linux/wmi.h>
 
-#include "wmi-capdata01.h"
+#include "wmi-capdata.h"
 
 #define LENOVO_CAPABILITY_DATA_01_GUID "7A8F5407-CB67-4D6E-B547-39B3BE018154"
 
 #define ACPI_AC_CLASS "ac_adapter"
 #define ACPI_AC_NOTIFY_STATUS 0x80
 
-struct lwmi_cd01_priv {
+struct lwmi_cd_priv {
 	struct notifier_block acpi_nb; /* ACPI events */
 	struct wmi_device *wdev;
-	struct cd01_list *list;
+	struct cd_list *list;
 };
 
-struct cd01_list {
+struct cd_list {
 	struct mutex list_mutex; /* list R/W mutex */
 	u8 count;
 	struct capdata01 data[];
 };
 
 /**
- * lwmi_cd01_component_bind() - Bind component to master device.
- * @cd01_dev: Pointer to the lenovo-wmi-capdata01 driver parent device.
+ * lwmi_cd_component_bind() - Bind component to master device.
+ * @cd_dev: Pointer to the lenovo-wmi-capdata driver parent device.
  * @om_dev: Pointer to the lenovo-wmi-other driver parent device.
- * @data: capdata01_list object pointer used to return the capability data.
+ * @data: cd_list object pointer used to return the capability data.
  *
- * On lenovo-wmi-other's master bind, provide a pointer to the local capdata01
- * list. This is used to call lwmi_cd01_get_data to look up attribute data
+ * On lenovo-wmi-other's master bind, provide a pointer to the local capdata
+ * list. This is used to call lwmi_cd*_get_data to look up attribute data
  * from the lenovo-wmi-other driver.
  *
  * Return: 0
  */
-static int lwmi_cd01_component_bind(struct device *cd01_dev,
-				    struct device *om_dev, void *data)
+static int lwmi_cd_component_bind(struct device *cd_dev,
+				  struct device *om_dev, void *data)
 {
-	struct lwmi_cd01_priv *priv = dev_get_drvdata(cd01_dev);
-	struct cd01_list **cd01_list = data;
+	struct lwmi_cd_priv *priv = dev_get_drvdata(cd_dev);
+	struct cd_list **cd_list = data;
 
-	*cd01_list = priv->list;
+	*cd_list = priv->list;
 
 	return 0;
 }
 
-static const struct component_ops lwmi_cd01_component_ops = {
-	.bind = lwmi_cd01_component_bind,
+static const struct component_ops lwmi_cd_component_ops = {
+	.bind = lwmi_cd_component_bind,
 };
 
 /**
  * lwmi_cd01_get_data - Get the data of the specified attribute
- * @list: The lenovo-wmi-capdata01 pointer to its cd01_list struct.
+ * @list: The lenovo-wmi-capdata pointer to its cd_list struct.
  * @attribute_id: The capdata attribute ID to be found.
  * @output: Pointer to a capdata01 struct to return the data.
  *
@@ -83,7 +86,7 @@ static const struct component_ops lwmi_cd01_component_ops = {
  *
  * Return: 0 on success, or -EINVAL.
  */
-int lwmi_cd01_get_data(struct cd01_list *list, u32 attribute_id, struct capdata01 *output)
+int lwmi_cd01_get_data(struct cd_list *list, u32 attribute_id, struct capdata01 *output)
 {
 	u8 idx;
 
@@ -97,17 +100,17 @@ int lwmi_cd01_get_data(struct cd01_list *list, u32 attribute_id, struct capdata0
 
 	return -EINVAL;
 }
-EXPORT_SYMBOL_NS_GPL(lwmi_cd01_get_data, "LENOVO_WMI_CD01");
+EXPORT_SYMBOL_NS_GPL(lwmi_cd01_get_data, "LENOVO_WMI_CD");
 
 /**
- * lwmi_cd01_cache() - Cache all WMI data block information
- * @priv: lenovo-wmi-capdata01 driver data.
+ * lwmi_cd_cache() - Cache all WMI data block information
+ * @priv: lenovo-wmi-capdata driver data.
  *
  * Loop through each WMI data block and cache the data.
  *
  * Return: 0 on success, or an error.
  */
-static int lwmi_cd01_cache(struct lwmi_cd01_priv *priv)
+static int lwmi_cd_cache(struct lwmi_cd_priv *priv)
 {
 	int idx;
 
@@ -131,17 +134,17 @@ static int lwmi_cd01_cache(struct lwmi_cd01_priv *priv)
 }
 
 /**
- * lwmi_cd01_alloc() - Allocate a cd01_list struct in drvdata
- * @priv: lenovo-wmi-capdata01 driver data.
+ * lwmi_cd_alloc() - Allocate a cd_list struct in drvdata
+ * @priv: lenovo-wmi-capdata driver data.
  *
- * Allocate a cd01_list struct large enough to contain data from all WMI data
+ * Allocate a cd_list struct large enough to contain data from all WMI data
  * blocks provided by the interface.
  *
  * Return: 0 on success, or an error.
  */
-static int lwmi_cd01_alloc(struct lwmi_cd01_priv *priv)
+static int lwmi_cd_alloc(struct lwmi_cd_priv *priv)
 {
-	struct cd01_list *list;
+	struct cd_list *list;
 	size_t list_size;
 	int count, ret;
 
@@ -163,28 +166,28 @@ static int lwmi_cd01_alloc(struct lwmi_cd01_priv *priv)
 }
 
 /**
- * lwmi_cd01_setup() - Cache all WMI data block information
- * @priv: lenovo-wmi-capdata01 driver data.
+ * lwmi_cd_setup() - Cache all WMI data block information
+ * @priv: lenovo-wmi-capdata driver data.
  *
- * Allocate a cd01_list struct large enough to contain data from all WMI data
+ * Allocate a cd_list struct large enough to contain data from all WMI data
  * blocks provided by the interface. Then loop through each data block and
  * cache the data.
  *
  * Return: 0 on success, or an error code.
  */
-static int lwmi_cd01_setup(struct lwmi_cd01_priv *priv)
+static int lwmi_cd_setup(struct lwmi_cd_priv *priv)
 {
 	int ret;
 
-	ret = lwmi_cd01_alloc(priv);
+	ret = lwmi_cd_alloc(priv);
 	if (ret)
 		return ret;
 
-	return lwmi_cd01_cache(priv);
+	return lwmi_cd_cache(priv);
 }
 
 /**
- * lwmi_cd01_notifier_call() - Call method for lenovo-wmi-capdata01 driver notifier.
+ * lwmi_cd01_notifier_call() - Call method for cd01 notifier.
  * block call chain.
  * @nb: The notifier_block registered to lenovo-wmi-events driver.
  * @action: Unused.
@@ -199,17 +202,17 @@ static int lwmi_cd01_notifier_call(struct notifier_block *nb, unsigned long acti
 				   void *data)
 {
 	struct acpi_bus_event *event = data;
-	struct lwmi_cd01_priv *priv;
+	struct lwmi_cd_priv *priv;
 	int ret;
 
 	if (strcmp(event->device_class, ACPI_AC_CLASS) != 0)
 		return NOTIFY_DONE;
 
-	priv = container_of(nb, struct lwmi_cd01_priv, acpi_nb);
+	priv = container_of(nb, struct lwmi_cd_priv, acpi_nb);
 
 	switch (event->type) {
 	case ACPI_AC_NOTIFY_STATUS:
-		ret = lwmi_cd01_cache(priv);
+		ret = lwmi_cd_cache(priv);
 		if (ret)
 			return NOTIFY_BAD;
 
@@ -230,10 +233,9 @@ static void lwmi_cd01_unregister(void *data)
 	unregister_acpi_notifier(acpi_nb);
 }
 
-static int lwmi_cd01_probe(struct wmi_device *wdev, const void *context)
-
+static int lwmi_cd_probe(struct wmi_device *wdev, const void *context)
 {
-	struct lwmi_cd01_priv *priv;
+	struct lwmi_cd_priv *priv;
 	int ret;
 
 	priv = devm_kzalloc(&wdev->dev, sizeof(*priv), GFP_KERNEL);
@@ -243,7 +245,7 @@ static int lwmi_cd01_probe(struct wmi_device *wdev, const void *context)
 	priv->wdev = wdev;
 	dev_set_drvdata(&wdev->dev, priv);
 
-	ret = lwmi_cd01_setup(priv);
+	ret = lwmi_cd_setup(priv);
 	if (ret)
 		return ret;
 
@@ -257,27 +259,27 @@ static int lwmi_cd01_probe(struct wmi_device *wdev, const void *context)
 	if (ret)
 		return ret;
 
-	return component_add(&wdev->dev, &lwmi_cd01_component_ops);
+	return component_add(&wdev->dev, &lwmi_cd_component_ops);
 }
 
-static void lwmi_cd01_remove(struct wmi_device *wdev)
+static void lwmi_cd_remove(struct wmi_device *wdev)
 {
-	component_del(&wdev->dev, &lwmi_cd01_component_ops);
+	component_del(&wdev->dev, &lwmi_cd_component_ops);
 }
 
-static const struct wmi_device_id lwmi_cd01_id_table[] = {
+static const struct wmi_device_id lwmi_cd_id_table[] = {
 	{ LENOVO_CAPABILITY_DATA_01_GUID, NULL },
 	{}
 };
 
-static struct wmi_driver lwmi_cd01_driver = {
+static struct wmi_driver lwmi_cd_driver = {
 	.driver = {
-		.name = "lenovo_wmi_cd01",
+		.name = "lenovo_wmi_cd",
 		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
-	.id_table = lwmi_cd01_id_table,
-	.probe = lwmi_cd01_probe,
-	.remove = lwmi_cd01_remove,
+	.id_table = lwmi_cd_id_table,
+	.probe = lwmi_cd_probe,
+	.remove = lwmi_cd_remove,
 	.no_singleton = true,
 };
 
@@ -290,13 +292,13 @@ static struct wmi_driver lwmi_cd01_driver = {
  */
 int lwmi_cd01_match(struct device *dev, void *data)
 {
-	return dev->driver == &lwmi_cd01_driver.driver;
+	return dev->driver == &lwmi_cd_driver.driver;
 }
-EXPORT_SYMBOL_NS_GPL(lwmi_cd01_match, "LENOVO_WMI_CD01");
+EXPORT_SYMBOL_NS_GPL(lwmi_cd01_match, "LENOVO_WMI_CD");
 
-module_wmi_driver(lwmi_cd01_driver);
+module_wmi_driver(lwmi_cd_driver);
 
-MODULE_DEVICE_TABLE(wmi, lwmi_cd01_id_table);
+MODULE_DEVICE_TABLE(wmi, lwmi_cd_id_table);
 MODULE_AUTHOR("Derek J. Clark <derekjohn.clark@gmail.com>");
-MODULE_DESCRIPTION("Lenovo Capability Data 01 WMI Driver");
+MODULE_DESCRIPTION("Lenovo Capability Data WMI Driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/platform/x86/lenovo/wmi-capdata01.h b/drivers/platform/x86/lenovo/wmi-capdata.h
similarity index 60%
rename from drivers/platform/x86/lenovo/wmi-capdata01.h
rename to drivers/platform/x86/lenovo/wmi-capdata.h
index bd06c5751f68b..2a4746e38ad43 100644
--- a/drivers/platform/x86/lenovo/wmi-capdata01.h
+++ b/drivers/platform/x86/lenovo/wmi-capdata.h
@@ -2,13 +2,13 @@
 
 /* Copyright (C) 2025 Derek J. Clark <derekjohn.clark@gmail.com> */
 
-#ifndef _LENOVO_WMI_CAPDATA01_H_
-#define _LENOVO_WMI_CAPDATA01_H_
+#ifndef _LENOVO_WMI_CAPDATA_H_
+#define _LENOVO_WMI_CAPDATA_H_
 
 #include <linux/types.h>
 
 struct device;
-struct cd01_list;
+struct cd_list;
 
 struct capdata01 {
 	u32 id;
@@ -19,7 +19,7 @@ struct capdata01 {
 	u32 max_value;
 };
 
-int lwmi_cd01_get_data(struct cd01_list *list, u32 attribute_id, struct capdata01 *output);
+int lwmi_cd01_get_data(struct cd_list *list, u32 attribute_id, struct capdata01 *output);
 int lwmi_cd01_match(struct device *dev, void *data);
 
-#endif /* !_LENOVO_WMI_CAPDATA01_H_ */
+#endif /* !_LENOVO_WMI_CAPDATA_H_ */
diff --git a/drivers/platform/x86/lenovo/wmi-other.c b/drivers/platform/x86/lenovo/wmi-other.c
index 2a960b278f117..c6dc1b4cff841 100644
--- a/drivers/platform/x86/lenovo/wmi-other.c
+++ b/drivers/platform/x86/lenovo/wmi-other.c
@@ -34,7 +34,7 @@
 #include <linux/types.h>
 #include <linux/wmi.h>
 
-#include "wmi-capdata01.h"
+#include "wmi-capdata.h"
 #include "wmi-events.h"
 #include "wmi-gamezone.h"
 #include "wmi-helpers.h"
@@ -74,7 +74,10 @@ enum attribute_property {
 
 struct lwmi_om_priv {
 	struct component_master_ops *ops;
-	struct cd01_list *cd01_list; /* only valid after capdata01 bind */
+
+	/* only valid after capdata bind */
+	struct cd_list *cd01_list;
+
 	struct device *fw_attr_dev;
 	struct kset *fw_attr_kset;
 	struct notifier_block nb;
@@ -576,7 +579,7 @@ static void lwmi_om_fw_attr_remove(struct lwmi_om_priv *priv)
 static int lwmi_om_master_bind(struct device *dev)
 {
 	struct lwmi_om_priv *priv = dev_get_drvdata(dev);
-	struct cd01_list *tmp_list;
+	struct cd_list *tmp_list;
 	int ret;
 
 	ret = component_bind_all(dev, &tmp_list);
@@ -657,7 +660,7 @@ static struct wmi_driver lwmi_other_driver = {
 
 module_wmi_driver(lwmi_other_driver);
 
-MODULE_IMPORT_NS("LENOVO_WMI_CD01");
+MODULE_IMPORT_NS("LENOVO_WMI_CD");
 MODULE_IMPORT_NS("LENOVO_WMI_HELPERS");
 MODULE_DEVICE_TABLE(wmi, lwmi_other_id_table);
 MODULE_AUTHOR("Derek J. Clark <derekjohn.clark@gmail.com>");
-- 
2.51.0


