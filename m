Return-Path: <linux-kernel+bounces-859864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DA6D7BEECF1
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 23:06:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AF3FF4EA11A
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 21:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EE51239E7F;
	Sun, 19 Oct 2025 21:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rong.moe header.i=i@rong.moe header.b="MSaJ7ZOe"
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FCDD23D28C;
	Sun, 19 Oct 2025 21:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760907937; cv=pass; b=AwEdn8IVoRGkEpLbB0NvICPAYk7a9K8wQBAJPYxsgPJV15vhC3twgTnm1FssDrxjeQCI98z6BkRfGRU3EPIyvXZcXO23ABLkmkklW9vaUNidXaDOpBJLUhHq/bUClSBK//Hk3of7nekohUYa+bSiVoglV25A8jpzVYywOv/z9eU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760907937; c=relaxed/simple;
	bh=OaprJbwje+Xl9JbayaYn5/GI1tElGDgZnu9rvvgb4Xk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c7PBfO1jGEY3QUi9mOGksagc10X5+Yd/Hc6lv8gQXvh6e8Qm5VobFBqVUJnMPjrXNfx4dI5kheT/iQl0u3kYuV6IkhcsLHrD3Nbn95SYYHd3c9m0tPAf8jtIjpChfDIYZl3WyjWrQ0WXPpau/6bPI6paSnyDHn0Pp5iyZK6HGwc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe; spf=pass smtp.mailfrom=rong.moe; dkim=pass (1024-bit key) header.d=rong.moe header.i=i@rong.moe header.b=MSaJ7ZOe; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
ARC-Seal: i=1; a=rsa-sha256; t=1760907912; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=h/2K0aW12uJkaDq2ARDI22kbUc3+E07B19kNRcTUUN+Bd4YBpRsCZEGe6OtRiX4mhX/iJWWPzauRT3zDWvpnvMNcidAm3gYbYkcKvXsF0/a/uouMUIkhyhYvyHhm1rG/0B4pf9GLovdeWigygJsYHk4G9bclnVP2JXsBeiUIWrY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1760907912; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=U2Ir+b9C0zMSpon1Jv8i/FhV+jNWU5a/GVZ8v0qJwbc=; 
	b=UQA+cDlc0QgpSRCU6iPSY4MZoy/PiiXFNrXjSRHPVf8BuYWoTMHAYQKL2nfNTyoeoh65ACT+d1PgraUgb48WFx1axrHy4FHahThPhI1TzPg1jdXgEpUqIxSdHam6FTvw+jzAKqcS8nlFEIwmwNV1undyD7uoD89TNrAJl5sgIYw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1760907912;
	s=zmail; d=rong.moe; i=i@rong.moe;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=U2Ir+b9C0zMSpon1Jv8i/FhV+jNWU5a/GVZ8v0qJwbc=;
	b=MSaJ7ZOe9cEvasIylaa/Bkrqw3qArYB5fcpV/RESp1WKvUZPAQvJ3Ri8HpwMe2Hq
	SH84r2Fwhb4Qck9Ap9iuFgeZh54ve4gpH2hbeU0HdmDLXbLFKluGIiznaCnoRekn3aE
	XHUwawZOK9IsXDYBvUT3OQu5oSC6ENeajPnlF4IM=
Received: by mx.zohomail.com with SMTPS id 1760907910578695.2158463740977;
	Sun, 19 Oct 2025 14:05:10 -0700 (PDT)
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
Subject: [PATCH 4/6] platform/x86: lenovo-wmi-other: Add HWMON for fan speed RPM
Date: Mon, 20 Oct 2025 05:04:47 +0800
Message-ID: <20251019210450.88830-5-i@rong.moe>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251019210450.88830-1-i@rong.moe>
References: <20251019210450.88830-1-i@rong.moe>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Register an HWMON device for fan spped RPM according to Capability Data
00 provided by lenovo-wmi-capdata. The corresponding HWMON nodes are:

 - fanX_enable: enable/disable the fan (tunable)
 - fanX_input: current RPM
 - fanX_target: target RPM (tunable)

Signed-off-by: Rong Zhang <i@rong.moe>
---
 .../wmi/devices/lenovo-wmi-other.rst          |   5 +
 drivers/platform/x86/lenovo/Kconfig           |   1 +
 drivers/platform/x86/lenovo/wmi-other.c       | 324 +++++++++++++++++-
 3 files changed, 317 insertions(+), 13 deletions(-)

diff --git a/Documentation/wmi/devices/lenovo-wmi-other.rst b/Documentation/wmi/devices/lenovo-wmi-other.rst
index adbd7943c6756..cb6a9bfe5a79e 100644
--- a/Documentation/wmi/devices/lenovo-wmi-other.rst
+++ b/Documentation/wmi/devices/lenovo-wmi-other.rst
@@ -31,6 +31,11 @@ under the following path:
 
   /sys/class/firmware-attributes/lenovo-wmi-other/attributes/<attribute>/
 
+Besides, this driver also exports fan speed RPM to HWMON:
+ - fanX_enable: enable/disable the fan (tunable)
+ - fanX_input: current RPM
+ - fanX_target: target RPM (tunable)
+
 LENOVO_CAPABILITY_DATA_00
 -------------------------
 
diff --git a/drivers/platform/x86/lenovo/Kconfig b/drivers/platform/x86/lenovo/Kconfig
index fb96a0f908f03..be9af04511462 100644
--- a/drivers/platform/x86/lenovo/Kconfig
+++ b/drivers/platform/x86/lenovo/Kconfig
@@ -263,6 +263,7 @@ config LENOVO_WMI_GAMEZONE
 config LENOVO_WMI_TUNING
 	tristate "Lenovo Other Mode WMI Driver"
 	depends on ACPI_WMI
+	select HWMON
 	select FW_ATTR_CLASS
 	select LENOVO_WMI_DATA
 	select LENOVO_WMI_EVENTS
diff --git a/drivers/platform/x86/lenovo/wmi-other.c b/drivers/platform/x86/lenovo/wmi-other.c
index 20c6ff0be37a1..f8771ed3c6642 100644
--- a/drivers/platform/x86/lenovo/wmi-other.c
+++ b/drivers/platform/x86/lenovo/wmi-other.c
@@ -14,7 +14,15 @@
  * These attributes typically don't fit anywhere else in the sysfs and are set
  * in Windows using one of Lenovo's multiple user applications.
  *
+ * Besides, this driver also exports tunable fan speed RPM to HWMON.
+ *
  * Copyright (C) 2025 Derek J. Clark <derekjohn.clark@gmail.com>
+ *   - fw_attributes
+ *   - binding to Capability Data 01
+ *
+ * Copyright (C) 2025 Rong Zhang <i@rong.moe>
+ *   - HWMON
+ *   - binding to Capability Data 00
  */
 
 #include <linux/acpi.h>
@@ -25,6 +33,7 @@
 #include <linux/device.h>
 #include <linux/export.h>
 #include <linux/gfp_types.h>
+#include <linux/hwmon.h>
 #include <linux/idr.h>
 #include <linux/kdev_t.h>
 #include <linux/kobject.h>
@@ -43,12 +52,20 @@
 
 #define LENOVO_OTHER_MODE_GUID "DC2A8805-3A8C-41BA-A6F7-092E0089CD3B"
 
+#define LWMI_SUPP_VALID BIT(0)
+#define LWMI_SUPP_MAY_GET (LWMI_SUPP_VALID | BIT(1))
+#define LWMI_SUPP_MAY_SET (LWMI_SUPP_VALID | BIT(2))
+
 #define LWMI_DEVICE_ID_CPU 0x01
 
 #define LWMI_FEATURE_ID_CPU_SPPT 0x01
 #define LWMI_FEATURE_ID_CPU_SPL 0x02
 #define LWMI_FEATURE_ID_CPU_FPPT 0x03
 
+#define LWMI_DEVICE_ID_FAN 0x04
+
+#define LWMI_FEATURE_ID_FAN_RPM 0x03
+
 #define LWMI_TYPE_ID_NONE 0x00
 
 #define LWMI_FEATURE_VALUE_GET 17
@@ -59,7 +76,18 @@
 #define LWMI_ATTR_MODE_ID_MASK GENMASK(15, 8)
 #define LWMI_ATTR_TYPE_ID_MASK GENMASK(7, 0)
 
+/* Only fan1 and fan2 are present on supported devices. */
+#define LWMI_FAN_ID_BASE 1
+#define LWMI_FAN_NR 2
+#define LWMI_FAN_ID(x) ((x) + LWMI_FAN_ID_BASE)
+
+#define LWMI_ATTR_ID_FAN_RPM(x)						\
+	(FIELD_PREP(LWMI_ATTR_DEV_ID_MASK, LWMI_DEVICE_ID_FAN) |	\
+	 FIELD_PREP(LWMI_ATTR_FEAT_ID_MASK, LWMI_FEATURE_ID_FAN_RPM) |	\
+	 FIELD_PREP(LWMI_ATTR_TYPE_ID_MASK, LWMI_FAN_ID(x)))
+
 #define LWMI_OM_FW_ATTR_BASE_PATH "lenovo-wmi-other"
+#define LWMI_OM_HWMON_NAME "lenovo_wmi_other"
 
 static BLOCKING_NOTIFIER_HEAD(om_chain_head);
 static DEFINE_IDA(lwmi_om_ida);
@@ -76,15 +104,256 @@ struct lwmi_om_priv {
 	struct component_master_ops *ops;
 
 	/* only valid after capdata bind */
+	struct cd_list *cd00_list;
 	struct cd_list *cd01_list;
 
+	struct device *hwmon_dev;
 	struct device *fw_attr_dev;
 	struct kset *fw_attr_kset;
 	struct notifier_block nb;
 	struct wmi_device *wdev;
 	int ida_id;
+
+	struct fan_info {
+		u32 supported;
+		long target;
+	} fan_info[LWMI_FAN_NR];
 };
 
+/* ======== HWMON (component: lenovo-wmi-capdata 00) ======== */
+
+/**
+ * lwmi_om_fan_get_set() - Get or set fan RPM value of specified fan
+ * @priv: Driver private data structure
+ * @channel: Fan channel index (0-based)
+ * @val: Pointer to value (input for set, output for get)
+ * @set: True to set value, false to get value
+ *
+ * Communicates with WMI interface to either retrieve current fan RPM
+ * or set target fan speed.
+ *
+ * Return: 0 on success, or an error code.
+ */
+static int lwmi_om_fan_get_set(struct lwmi_om_priv *priv, int channel, u32 *val, bool set)
+{
+	struct wmi_method_args_32 args;
+	u32 method_id, retval;
+	int err;
+
+	method_id = set ? LWMI_FEATURE_VALUE_SET : LWMI_FEATURE_VALUE_GET;
+	args.arg0 = LWMI_ATTR_ID_FAN_RPM(channel);
+	args.arg1 = set ? *val : 0;
+
+	err = lwmi_dev_evaluate_int(priv->wdev, 0x0, method_id,
+				    (unsigned char *)&args, sizeof(args), &retval);
+	if (err)
+		return err;
+
+	if (!set)
+		*val = retval;
+	else if (retval != 1)
+		return -EIO;
+
+	return 0;
+}
+
+/**
+ * lwmi_om_hwmon_is_visible() - Determine visibility of HWMON attributes
+ * @drvdata: Driver private data
+ * @type: Sensor type
+ * @attr: Attribute identifier
+ * @channel: Channel index
+ *
+ * Determines whether a HWMON attribute should be visible in sysfs
+ * based on hardware capabilities and current configuration.
+ *
+ * Return: permission mode, or 0 if invisible.
+ */
+static umode_t lwmi_om_hwmon_is_visible(const void *drvdata, enum hwmon_sensor_types type,
+					u32 attr, int channel)
+{
+	struct lwmi_om_priv *priv = (struct lwmi_om_priv *)drvdata;
+	bool r = false, w = false;
+
+	if (type == hwmon_fan) {
+		switch (attr) {
+		case hwmon_fan_enable:
+		case hwmon_fan_target:
+			r = w = priv->fan_info[channel].supported & LWMI_SUPP_MAY_SET;
+			break;
+		case hwmon_fan_input:
+			r = priv->fan_info[channel].supported & LWMI_SUPP_MAY_GET;
+			break;
+		}
+	}
+
+	if (!r)
+		return 0;
+
+	return w ? 0644 : 0444;
+}
+
+/**
+ * lwmi_om_hwmon_read() - Read HWMON sensor data
+ * @dev: Device pointer
+ * @type: Sensor type
+ * @attr: Attribute identifier
+ * @channel: Channel index
+ * @val: Pointer to store value
+ *
+ * Reads current sensor values from hardware through WMI interface.
+ *
+ * Return: 0 on success, or an error code.
+ */
+static int lwmi_om_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
+			      u32 attr, int channel, long *val)
+{
+	struct lwmi_om_priv *priv = dev_get_drvdata(dev);
+	u32 retval = 0;
+	int err;
+
+	if (type == hwmon_fan) {
+		switch (attr) {
+		case hwmon_fan_input:
+			err = lwmi_om_fan_get_set(priv, channel, &retval, false);
+			if (err)
+				return err;
+
+			*val = retval;
+			return 0;
+		case hwmon_fan_enable:
+		case hwmon_fan_target:
+			/* -ENODATA before first set. */
+			err = (int)priv->fan_info[channel].target;
+			if (err < 0)
+				return err;
+
+			if (attr == hwmon_fan_enable)
+				*val = priv->fan_info[channel].target != 1;
+			else
+				*val = priv->fan_info[channel].target;
+			return 0;
+		}
+	}
+
+	return -EOPNOTSUPP;
+}
+
+/**
+ * lwmi_om_hwmon_write() - Write HWMON sensor data
+ * @dev: Device pointer
+ * @type: Sensor type
+ * @attr: Attribute identifier
+ * @channel: Channel index
+ * @val: Value to write
+ *
+ * Writes configuration values to hardware through WMI interface.
+ *
+ * Return: 0 on success, or an error code.
+ */
+static int lwmi_om_hwmon_write(struct device *dev, enum hwmon_sensor_types type,
+			       u32 attr, int channel, long val)
+{
+	struct lwmi_om_priv *priv = dev_get_drvdata(dev);
+	u32 raw;
+	int err;
+
+	if (type == hwmon_fan) {
+		switch (attr) {
+		case hwmon_fan_enable:
+		case hwmon_fan_target:
+			if (attr == hwmon_fan_enable) {
+				if (val == 0)
+					raw = 1; /* stop */
+				else if (val == 1)
+					raw = 0; /* auto */
+				else
+					return -EINVAL;
+			} else {
+				/*
+				 * val > U16_MAX seems safe but meaningless.
+				 */
+				if (val < 0 || val > U16_MAX)
+					return -EINVAL;
+				raw = val;
+			}
+
+			err = lwmi_om_fan_get_set(priv, channel, &raw, true);
+			if (err)
+				return err;
+
+			priv->fan_info[channel].target = raw;
+			return 0;
+		}
+	}
+
+	return -EOPNOTSUPP;
+}
+
+static const struct hwmon_channel_info * const lwmi_om_hwmon_info[] = {
+	/* Must match LWMI_FAN_NR. */
+	HWMON_CHANNEL_INFO(fan,
+			   HWMON_F_ENABLE | HWMON_F_INPUT | HWMON_F_TARGET,
+			   HWMON_F_ENABLE | HWMON_F_INPUT | HWMON_F_TARGET),
+	NULL
+};
+
+static const struct hwmon_ops lwmi_om_hwmon_ops = {
+	.is_visible = lwmi_om_hwmon_is_visible,
+	.read = lwmi_om_hwmon_read,
+	.write = lwmi_om_hwmon_write,
+};
+
+static const struct hwmon_chip_info lwmi_om_hwmon_chip_info = {
+	.ops = &lwmi_om_hwmon_ops,
+	.info = lwmi_om_hwmon_info,
+};
+
+/**
+ * lwmi_om_hwmon_add() - Register HWMON device
+ * @priv: Driver private data
+ *
+ * Initializes capability data and registers the HWMON device.
+ *
+ * Return: 0 on success, or an error code.
+ */
+static int lwmi_om_hwmon_add(struct lwmi_om_priv *priv)
+{
+	struct capdata00 capdata00;
+	int i, err;
+
+	for (i = 0; i < LWMI_FAN_NR; i++) {
+		err = lwmi_cd00_get_data(priv->cd00_list, LWMI_ATTR_ID_FAN_RPM(i),
+					 &capdata00);
+		if (err)
+			continue;
+
+		priv->fan_info[i] = (struct fan_info) {
+			.supported = capdata00.supported,
+			.target = -ENODATA,
+		};
+	}
+
+	priv->hwmon_dev = hwmon_device_register_with_info(&priv->wdev->dev, LWMI_OM_HWMON_NAME,
+							  priv, &lwmi_om_hwmon_chip_info, NULL);
+
+	return PTR_ERR_OR_ZERO(priv->hwmon_dev);
+}
+
+/**
+ * lwmi_om_hwmon_remove() - Unregister HWMON device
+ * @priv: Driver private data
+ *
+ * Unregisters the HWMON device and resets all fans to automatic mode.
+ * Ensures hardware doesn't remain in manual mode after driver removal.
+ */
+static void lwmi_om_hwmon_remove(struct lwmi_om_priv *priv)
+{
+	hwmon_device_unregister(priv->hwmon_dev);
+}
+
+/* ======== fw_attributes (component: lenovo-wmi-capdata 01) ======== */
+
 struct tunable_attr_01 {
 	struct capdata01 *capdata;
 	struct device *dev;
@@ -564,15 +833,17 @@ static void lwmi_om_fw_attr_remove(struct lwmi_om_priv *priv)
 	device_unregister(priv->fw_attr_dev);
 }
 
+/* ======== Self (master: lenovo-wmi-other) ======== */
+
 /**
  * lwmi_om_master_bind() - Bind all components of the other mode driver
  * @dev: The lenovo-wmi-other driver basic device.
  *
- * Call component_bind_all to bind the lenovo-wmi-capdata01 driver to the
- * lenovo-wmi-other master driver. On success, assign the capability data 01
- * list pointer to the driver data struct for later access. This pointer
- * is only valid while the capdata01 interface exists. Finally, register all
- * firmware attribute groups.
+ * Call component_bind_all to bind the lenovo-wmi-capdata devices to the
+ * lenovo-wmi-other master driver. On success, assign the capability data
+ * list pointers to the driver data struct for later access. These pointers
+ * are only valid while the capdata interfaces exist. Finally, register the
+ * HWMON device and all firmware attribute groups.
  *
  * Return: 0 on success, or an error code.
  */
@@ -586,26 +857,47 @@ static int lwmi_om_master_bind(struct device *dev)
 	if (ret)
 		return ret;
 
-	priv->cd01_list = binder.cd01_list;
-	if (!priv->cd01_list)
+	if (!binder.cd00_list && !binder.cd01_list)
 		return -ENODEV;
 
-	return lwmi_om_fw_attr_add(priv);
+	priv->cd00_list = binder.cd00_list;
+	if (priv->cd00_list) {
+		ret = lwmi_om_hwmon_add(priv);
+		if (ret)
+			return ret;
+	}
+
+	priv->cd01_list = binder.cd01_list;
+	if (priv->cd01_list) {
+		ret = lwmi_om_fw_attr_add(priv);
+		if (ret) {
+			if (priv->cd00_list)
+				lwmi_om_hwmon_remove(priv);
+			return ret;
+		}
+	}
+
+	return 0;
 }
 
 /**
  * lwmi_om_master_unbind() - Unbind all components of the other mode driver
  * @dev: The lenovo-wmi-other driver basic device
  *
- * Unregister all capability data attribute groups. Then call
- * component_unbind_all to unbind the lenovo-wmi-capdata01 driver from the
- * lenovo-wmi-other master driver. Finally, free the IDA for this device.
+ * Unregister the HWMON device and all capability data attribute groups. Then
+ * call component_unbind_all to unbind the lenovo-wmi-capdata driver from the
+ * lenovo-wmi-other master driver.
  */
 static void lwmi_om_master_unbind(struct device *dev)
 {
 	struct lwmi_om_priv *priv = dev_get_drvdata(dev);
 
-	lwmi_om_fw_attr_remove(priv);
+	if (priv->cd00_list)
+		lwmi_om_hwmon_remove(priv);
+
+	if (priv->cd01_list)
+		lwmi_om_fw_attr_remove(priv);
+
 	component_unbind_all(dev, NULL);
 }
 
@@ -624,6 +916,9 @@ static int lwmi_other_probe(struct wmi_device *wdev, const void *context)
 	if (!priv)
 		return -ENOMEM;
 
+	/* Sentinel for on-demand ida_free(). */
+	priv->ida_id = -EIDRM;
+
 	priv->wdev = wdev;
 	dev_set_drvdata(&wdev->dev, priv);
 
@@ -654,7 +949,9 @@ static void lwmi_other_remove(struct wmi_device *wdev)
 	struct lwmi_om_priv *priv = dev_get_drvdata(&wdev->dev);
 
 	component_master_del(&wdev->dev, &lwmi_om_master_ops);
-	ida_free(&lwmi_om_ida, priv->ida_id);
+
+	if (priv->ida_id >= 0)
+		ida_free(&lwmi_om_ida, priv->ida_id);
 }
 
 static const struct wmi_device_id lwmi_other_id_table[] = {
@@ -679,5 +976,6 @@ MODULE_IMPORT_NS("LENOVO_WMI_CD");
 MODULE_IMPORT_NS("LENOVO_WMI_HELPERS");
 MODULE_DEVICE_TABLE(wmi, lwmi_other_id_table);
 MODULE_AUTHOR("Derek J. Clark <derekjohn.clark@gmail.com>");
+MODULE_AUTHOR("Rong Zhang <i@rong.moe>");
 MODULE_DESCRIPTION("Lenovo Other Mode WMI Driver");
 MODULE_LICENSE("GPL");
-- 
2.51.0


