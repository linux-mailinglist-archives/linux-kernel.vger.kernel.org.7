Return-Path: <linux-kernel+bounces-879016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A11DEC22080
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 20:42:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 258444625EB
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 19:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94F4730BB8F;
	Thu, 30 Oct 2025 19:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rong.moe header.i=i@rong.moe header.b="YAyQ9LJk"
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A88A9327213;
	Thu, 30 Oct 2025 19:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761853246; cv=pass; b=ooCDirbxVTJDnPEQ+XShP10bC6GSlAoXxcl/6tvPNqufSWiN7dyBX0tp0TtsxFVpkQVOW4mpdFUq9pjOR+VpypUusrZdsn4Q3ryIuqOivlsSjdoViFrcfOUIAsEcxD6LxD11/HowRPixxyRGyxNp/Yu449htPbeP91fHSFzFkOM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761853246; c=relaxed/simple;
	bh=q6WtKQAoxPCvMTJZdkOGurrVpKvULJLhoj61UqI/9qQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JN/fC0mBUmtOLmT9HL33WZJxR5yCrdsOPlhxIWHtZoCzhzlIWG5z580u6rOu5Ur8yQNbMNQXihBe7OK3uwde941XWe4pTnXv7fVxKG++dyZEnqGMJaK/1sMvhMsiUOBdNvaz37Stev4i63RbqdRRWA/+HnCPBJl9r78DCjgtKOI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe; spf=pass smtp.mailfrom=rong.moe; dkim=pass (1024-bit key) header.d=rong.moe header.i=i@rong.moe header.b=YAyQ9LJk; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
ARC-Seal: i=1; a=rsa-sha256; t=1761853223; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=ZhM54fHbdyYa75NOnDxRmZi9JfU9kP1ZMhS3oscjJtEDfzLvnaE8BHsC3mBHSxwNuEDFGhN3xYo7fkXblxVUCRrO28bolYpX28mGIN8UVFTdJxmGe1d7lqjYkGNie8wV8cnALDgR5m4VPLFKA8cbqb9MDJ2pG600FJBcNdzxfJ4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1761853223; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=EBc5iQ2a7NL60QeclBbv+d71fEVTq+rLL7MfSHy/b5M=; 
	b=MtzzgCbIWh1X0pj2YK4qn42jXaqQbLn9PpgCaQPq8ESnM+FjCcbvX7DClchFuSkrlejiCiFV5D1d6AJoKmR0/kmEhxujuG10nnTVnCuTO7DKQwOatMR+0VTEi0H63WdzeA69B+McWFN3VQU6S3wk+hAMnBpTR1tiyjQ4xfHIfl4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1761853223;
	s=zmail; d=rong.moe; i=i@rong.moe;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=EBc5iQ2a7NL60QeclBbv+d71fEVTq+rLL7MfSHy/b5M=;
	b=YAyQ9LJkDx3T9K2ejbew5VaZvrZXFK+NidlRoxpdlJYjpMtm54960oQd68V0A7co
	1hLSrpAGzspW5YmofvcF/zoczKG1wVGon2hoTJvIwxXzk5e3m6T5jzvarCQ+aDWKqGi
	Qj0tvNWXVJnTpFxCpQ2Wy2CAJ0h/CBgINRj3MqUk=
Received: by mx.zohomail.com with SMTPS id 1761853221156673.3177126437446;
	Thu, 30 Oct 2025 12:40:21 -0700 (PDT)
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
Subject: [PATCH v2 6/6] platform/x86: lenovo-wmi-other: Add HWMON for fan speed RPM
Date: Fri, 31 Oct 2025 03:39:44 +0800
Message-ID: <20251030193955.107148-7-i@rong.moe>
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

Register an HWMON device for fan spped RPM according to Capability Data
00 and Fan Test Data provided by lenovo-wmi-capdata. The corresponding
HWMON nodes are:

 - fanX_enable: enable/disable the fan (tunable)
 - fanX_input: current RPM
 - fanX_max: maximum RPM
 - fanX_min: minimum RPM
 - fanX_target: target RPM (tunable)

Signed-off-by: Rong Zhang <i@rong.moe>
---
Changes in v2:
- Define 4 fan channels instead of 2 (thanks Derek J. Clark)
- Squash min/max reporting patch into this one (ditto)
- Query 0x04050000 for interface availability (ditto)
  - New parameter "expose_all_fans" to skip this check
- Enforce min/max RPM constraint on set (ditto)
  - New parameter "relax_fan_constraint" to disable this behavior
  - Drop parameter "ignore_fan_cap", superseded by the next one
  - New parameter "expose_all_fans" to expose fans w/o such data
- Assume auto mode on probe (ditto)
- Reword documentation (ditto)
- Do not register HWMON device if no fan can be exposed
- fanX_target: Return -EBUSY instead of raw target value when fan stops
---
 .../wmi/devices/lenovo-wmi-other.rst          |  11 +
 drivers/platform/x86/lenovo/Kconfig           |   1 +
 drivers/platform/x86/lenovo/wmi-other.c       | 467 +++++++++++++++++-
 3 files changed, 467 insertions(+), 12 deletions(-)

diff --git a/Documentation/wmi/devices/lenovo-wmi-other.rst b/Documentation/wmi/devices/lenovo-wmi-other.rst
index 821282e07d93c..10e47c60982e5 100644
--- a/Documentation/wmi/devices/lenovo-wmi-other.rst
+++ b/Documentation/wmi/devices/lenovo-wmi-other.rst
@@ -31,6 +31,8 @@ under the following path:
 
   /sys/class/firmware-attributes/lenovo-wmi-other/attributes/<attribute>/
 
+Besides, this driver also exports attributes to HWMON.
+
 LENOVO_CAPABILITY_DATA_00
 -------------------------
 
@@ -39,6 +41,11 @@ WMI GUID ``362A3AFE-3D96-4665-8530-96DAD5BB300E``
 The LENOVO_CAPABILITY_DATA_00 interface provides various information that
 does not rely on the gamezone thermal mode.
 
+The following HWMON attributes are implemented:
+ - fanX_enable: enable/disable the fan (tunable)
+ - fanX_input: current RPM
+ - fanX_target: target RPM (tunable)
+
 LENOVO_CAPABILITY_DATA_01
 -------------------------
 
@@ -70,6 +77,10 @@ WMI GUID ``B642801B-3D21-45DE-90AE-6E86F164FB21``
 The LENOVO_FAN_TEST_DATA interface provides reference data for self-test of
 cooling fans.
 
+The following HWMON attributes are implemented:
+ - fanX_max: maximum RPM
+ - fanX_min: minimum RPM
+
 WMI interface description
 =========================
 
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
index 20c6ff0be37a1..e067e55e95562 100644
--- a/drivers/platform/x86/lenovo/wmi-other.c
+++ b/drivers/platform/x86/lenovo/wmi-other.c
@@ -14,7 +14,16 @@
  * These attributes typically don't fit anywhere else in the sysfs and are set
  * in Windows using one of Lenovo's multiple user applications.
  *
+ * Besides, this driver also exports tunable fan speed RPM to HWMON. Min/max RPM
+ * are also provided for reference.
+ *
  * Copyright (C) 2025 Derek J. Clark <derekjohn.clark@gmail.com>
+ *   - fw_attributes
+ *   - binding to Capability Data 01
+ *
+ * Copyright (C) 2025 Rong Zhang <i@rong.moe>
+ *   - HWMON
+ *   - binding to Capability Data 00 and Fan
  */
 
 #include <linux/acpi.h>
@@ -25,6 +34,7 @@
 #include <linux/device.h>
 #include <linux/export.h>
 #include <linux/gfp_types.h>
+#include <linux/hwmon.h>
 #include <linux/idr.h>
 #include <linux/kdev_t.h>
 #include <linux/kobject.h>
@@ -43,12 +53,21 @@
 
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
+#define LWMI_FEATURE_ID_FAN_TEST 0x05
+
 #define LWMI_TYPE_ID_NONE 0x00
 
 #define LWMI_FEATURE_VALUE_GET 17
@@ -59,7 +78,24 @@
 #define LWMI_ATTR_MODE_ID_MASK GENMASK(15, 8)
 #define LWMI_ATTR_TYPE_ID_MASK GENMASK(7, 0)
 
+#define LWMI_FAN_ID_BASE 1
+#define LWMI_FAN_NR 4
+#define LWMI_FAN_ID(x) ((x) + LWMI_FAN_ID_BASE)
+
+#define LWMI_ATTR_ID_FAN_RPM(x)						\
+	(FIELD_PREP(LWMI_ATTR_DEV_ID_MASK, LWMI_DEVICE_ID_FAN) |	\
+	 FIELD_PREP(LWMI_ATTR_FEAT_ID_MASK, LWMI_FEATURE_ID_FAN_RPM) |	\
+	 FIELD_PREP(LWMI_ATTR_TYPE_ID_MASK, LWMI_FAN_ID(x)))
+
+#define LWMI_ATTR_ID_FAN_TEST							\
+	(FIELD_PREP(LWMI_ATTR_DEV_ID_MASK, LWMI_DEVICE_ID_FAN) |		\
+	 FIELD_PREP(LWMI_ATTR_FEAT_ID_MASK, LWMI_FEATURE_ID_FAN_TEST) |		\
+	 FIELD_PREP(LWMI_ATTR_TYPE_ID_MASK, LWMI_TYPE_ID_NONE))
+
+#define LWMI_FAN_STOP_RPM 1
+
 #define LWMI_OM_FW_ATTR_BASE_PATH "lenovo-wmi-other"
+#define LWMI_OM_HWMON_NAME "lenovo_wmi_other"
 
 static BLOCKING_NOTIFIER_HEAD(om_chain_head);
 static DEFINE_IDA(lwmi_om_ida);
@@ -76,15 +112,391 @@ struct lwmi_om_priv {
 	struct component_master_ops *ops;
 
 	/* only valid after capdata bind */
+	struct cd_list *cd00_list;
 	struct cd_list *cd01_list;
+	struct cd_list *cd_fan_list;
 
+	struct device *hwmon_dev;
 	struct device *fw_attr_dev;
 	struct kset *fw_attr_kset;
 	struct notifier_block nb;
 	struct wmi_device *wdev;
 	int ida_id;
+
+	struct fan_info {
+		u32 supported;
+		u32 last_target;
+		long min_rpm;
+		long max_rpm;
+	} fan_info[LWMI_FAN_NR];
+};
+
+/*
+ * Visibility of fan channels:
+ *
+ * +---------------------+---------+------------------+-----------------------+------------+
+ * |                     | default | +expose_all_fans | +relax_fan_constraint | +both      |
+ * +---------------------+---------+------------------+-----------------------+------------+
+ * | canonical           | RW      | RW               | RW+relaxed            | RW+relaxed |
+ * +---------------------+---------+------------------+-----------------------+------------+
+ * | -capdata_fan        | N       | RO               | N                     | RW+relaxed |
+ * +---------------------+---------+------------------+-----------------------+------------+
+ * | -FAN_TEST.supported | N       | RW               | N                     | RW+relaxed |
+ * +---------------------+---------+------------------+-----------------------+------------+
+ * | -both               | N       | RO               | N                     | RW+relaxed |
+ * +---------------------+---------+------------------+-----------------------+------------+
+ *
+ * Note: LWMI_ATTR_ID_FAN_RPM[idx].supported is always checked before exposing a channel.
+ */
+static bool expose_all_fans;
+module_param(expose_all_fans, bool, 0444);
+MODULE_PARM_DESC(expose_all_fans,
+	"This option skips some capability checks and solely relies on per-channel ones "
+	"to expose fan attributes. Use with caution.");
+
+static bool relax_fan_constraint;
+module_param(relax_fan_constraint, bool, 0444);
+MODULE_PARM_DESC(relax_fan_constraint,
+	"Do not enforce fan RPM constraint (min/max RPM) "
+	"and enables fan tuning when such data is missing. "
+	"Enabling this may results in HWMON attributes being out-of-sync. Use with caution.");
+
+/* ======== HWMON (component: lenovo-wmi-capdata 00 & fan) ======== */
+
+/**
+ * lwmi_om_fan_get_set() - Get or set fan RPM value of specified fan
+ * @priv: Driver private data structure
+ * @channel: Fan channel index (0-based)
+ * @val: Pointer to value (input for set, output for get)
+ * @set: True to set value, false to get value
+ *
+ * Communicates with WMI interface to either retrieve current fan RPM
+ * or set target fan RPM.
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
+	bool visible = false;
+
+	if (type == hwmon_fan) {
+		switch (attr) {
+		case hwmon_fan_enable:
+		case hwmon_fan_target:
+			if (!(priv->fan_info[channel].supported & LWMI_SUPP_MAY_SET))
+				return 0;
+
+			if (relax_fan_constraint ||
+			    (priv->fan_info[channel].min_rpm >= 0 &&
+			     priv->fan_info[channel].max_rpm >= 0))
+				return 0644;
+
+			/*
+			 * Reaching here implies expose_all_fans is set.
+			 * See lwmi_om_hwmon_add().
+			 */
+			dev_warn_once(&priv->wdev->dev,
+				      "fan tuning disabled due to missing RPM constraint\n");
+			return 0;
+		case hwmon_fan_input:
+			visible = priv->fan_info[channel].supported & LWMI_SUPP_MAY_GET;
+			break;
+		case hwmon_fan_min:
+			visible = priv->fan_info[channel].min_rpm >= 0;
+			break;
+		case hwmon_fan_max:
+			visible = priv->fan_info[channel].max_rpm >= 0;
+			break;
+		}
+	}
+
+	return visible ? 0444 : 0;
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
+			*val = priv->fan_info[channel].last_target != LWMI_FAN_STOP_RPM;
+			return 0;
+		case hwmon_fan_target:
+			if (priv->fan_info[channel].last_target == LWMI_FAN_STOP_RPM)
+				return -EBUSY;
+
+			*val = priv->fan_info[channel].last_target;
+			return 0;
+		case hwmon_fan_min:
+			*val = priv->fan_info[channel].min_rpm;
+			return 0;
+		case hwmon_fan_max:
+			*val = priv->fan_info[channel].max_rpm;
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
+	u32 raw, min_rpm, max_rpm;
+	int err;
+
+	if (type == hwmon_fan) {
+		switch (attr) {
+		case hwmon_fan_enable:
+			if (val == 0)
+				raw = LWMI_FAN_STOP_RPM;
+			else if (val == 1)
+				raw = 0; /* auto */
+			else
+				return -EINVAL;
+
+			goto fan_set;
+		case hwmon_fan_target:
+			if (val == 0) {
+				raw = 0;
+				goto fan_set;
+			}
+
+			min_rpm = relax_fan_constraint
+					? LWMI_FAN_STOP_RPM + 1
+					: priv->fan_info[channel].min_rpm;
+			max_rpm = relax_fan_constraint
+					? U16_MAX
+					: priv->fan_info[channel].max_rpm;
+
+			if (val < min_rpm || val > max_rpm)
+				return -EDOM;
+
+			raw = val;
+fan_set:
+			err = lwmi_om_fan_get_set(priv, channel, &raw, true);
+			if (err)
+				return err;
+
+			priv->fan_info[channel].last_target = raw;
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
+			   HWMON_F_ENABLE | HWMON_F_INPUT | HWMON_F_TARGET |
+			   HWMON_F_MIN | HWMON_F_MAX,
+			   HWMON_F_ENABLE | HWMON_F_INPUT | HWMON_F_TARGET |
+			   HWMON_F_MIN | HWMON_F_MAX,
+			   HWMON_F_ENABLE | HWMON_F_INPUT | HWMON_F_TARGET |
+			   HWMON_F_MIN | HWMON_F_MAX,
+			   HWMON_F_ENABLE | HWMON_F_INPUT | HWMON_F_TARGET |
+			   HWMON_F_MIN | HWMON_F_MAX),
+	NULL
 };
 
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
+	struct capdata_fan capdata_fan;
+	struct capdata00 capdata00;
+	int i, err, valid;
+
+	if (expose_all_fans) {
+		dev_warn(&priv->wdev->dev, "all fans exposed. Use with caution\n");
+	} else if (!priv->cd_fan_list) {
+		goto unsupported;
+	} else {
+		err = lwmi_cd00_get_data(priv->cd00_list, LWMI_ATTR_ID_FAN_TEST, &capdata00);
+		if (err || !(capdata00.supported & LWMI_SUPP_VALID))
+			goto unsupported;
+	}
+
+	if (relax_fan_constraint)
+		dev_warn(&priv->wdev->dev, "fan RPM constraint relaxed. Use with caution\n");
+
+	valid = 0;
+	for (i = 0; i < LWMI_FAN_NR; i++) {
+		err = lwmi_cd00_get_data(priv->cd00_list, LWMI_ATTR_ID_FAN_RPM(i), &capdata00);
+
+		priv->fan_info[i] = (struct fan_info) {
+			.supported = err ? 0 : capdata00.supported,
+			/*
+			 * Assume 0 on probe as the EC resets all fans to auto mode on (re)boot.
+			 *
+			 * Note that S0ix (s2idle) preserves the RPM target, so we
+			 * don't need suspend/resume callbacks. This behavior has not
+			 * been tested on S3-capable devices, but I doubt if such devices
+			 * even have this interface.
+			 */
+			.last_target = 0,
+			.min_rpm = -ENODATA,
+			.max_rpm = -ENODATA,
+		};
+
+		if (!(priv->fan_info[i].supported & LWMI_SUPP_VALID))
+			continue;
+
+		valid++;
+
+		if (!priv->cd_fan_list)
+			/*
+			 * Reaching here implies expose_all_fans is set.
+			 * fanX_{target,enable} will be gated by lwmi_om_hwmon_is_visible(),
+			 * unless relax_fan_constraint is also set.
+			 */
+			continue;
+
+		err = lwmi_cd_fan_get_data(priv->cd_fan_list, LWMI_FAN_ID(i), &capdata_fan);
+		if (!err) {
+			priv->fan_info[i].min_rpm = capdata_fan.min_rpm;
+			priv->fan_info[i].max_rpm = capdata_fan.max_rpm;
+			continue;
+		}
+
+		if (!expose_all_fans) {
+			/*
+			 * Fan attribute from capdata00 may be dummy (i.e.,
+			 * get: constant dummy RPM, set: no-op with retval == 0).
+			 *
+			 * If fan capdata is available and a fan is missing from it,
+			 * make the fan invisible.
+			 */
+			dev_dbg(&priv->wdev->dev, "missing RPM constraint for fan%d, hiding\n",
+				LWMI_FAN_ID(i));
+			priv->fan_info[i].supported = 0;
+			valid--;
+		}
+	}
+
+	if (valid == 0)
+		goto unsupported;
+
+	priv->hwmon_dev = hwmon_device_register_with_info(&priv->wdev->dev, LWMI_OM_HWMON_NAME,
+							  priv, &lwmi_om_hwmon_chip_info, NULL);
+	if (IS_ERR(priv->hwmon_dev)) {
+		err = PTR_ERR(priv->hwmon_dev);
+		priv->hwmon_dev = NULL;
+		return err;
+	}
+	return 0;
+
+unsupported:
+	dev_warn(&priv->wdev->dev, "fan reporting/tuning is unsupported on this device\n");
+	return 0;
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
+	if (priv->hwmon_dev)
+		hwmon_device_unregister(priv->hwmon_dev);
+}
+
+/* ======== fw_attributes (component: lenovo-wmi-capdata 01) ======== */
+
 struct tunable_attr_01 {
 	struct capdata01 *capdata;
 	struct device *dev;
@@ -547,6 +959,7 @@ static int lwmi_om_fw_attr_add(struct lwmi_om_priv *priv)
 
 err_free_ida:
 	ida_free(&lwmi_om_ida, priv->ida_id);
+	priv->fw_attr_dev = NULL;
 	return err;
 }
 
@@ -556,6 +969,9 @@ static int lwmi_om_fw_attr_add(struct lwmi_om_priv *priv)
  */
 static void lwmi_om_fw_attr_remove(struct lwmi_om_priv *priv)
 {
+	if (!priv->fw_attr_dev)
+		return;
+
 	for (unsigned int i = 0; i < ARRAY_SIZE(cd01_attr_groups) - 1; i++)
 		sysfs_remove_group(&priv->fw_attr_kset->kobj,
 				   cd01_attr_groups[i].attr_group);
@@ -564,15 +980,17 @@ static void lwmi_om_fw_attr_remove(struct lwmi_om_priv *priv)
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
@@ -586,26 +1004,45 @@ static int lwmi_om_master_bind(struct device *dev)
 	if (ret)
 		return ret;
 
-	priv->cd01_list = binder.cd01_list;
-	if (!priv->cd01_list)
+	if (!binder.cd00_list && !binder.cd01_list)
 		return -ENODEV;
 
-	return lwmi_om_fw_attr_add(priv);
+	priv->cd00_list = binder.cd00_list;
+	if (priv->cd00_list) {
+		priv->cd_fan_list = binder.cd_fan_list;
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
 
+	lwmi_om_hwmon_remove(priv);
 	lwmi_om_fw_attr_remove(priv);
+
 	component_unbind_all(dev, NULL);
 }
 
@@ -624,6 +1061,9 @@ static int lwmi_other_probe(struct wmi_device *wdev, const void *context)
 	if (!priv)
 		return -ENOMEM;
 
+	/* Sentinel for on-demand ida_free(). */
+	priv->ida_id = -EIDRM;
+
 	priv->wdev = wdev;
 	dev_set_drvdata(&wdev->dev, priv);
 
@@ -654,7 +1094,9 @@ static void lwmi_other_remove(struct wmi_device *wdev)
 	struct lwmi_om_priv *priv = dev_get_drvdata(&wdev->dev);
 
 	component_master_del(&wdev->dev, &lwmi_om_master_ops);
-	ida_free(&lwmi_om_ida, priv->ida_id);
+
+	if (priv->ida_id >= 0)
+		ida_free(&lwmi_om_ida, priv->ida_id);
 }
 
 static const struct wmi_device_id lwmi_other_id_table[] = {
@@ -679,5 +1121,6 @@ MODULE_IMPORT_NS("LENOVO_WMI_CD");
 MODULE_IMPORT_NS("LENOVO_WMI_HELPERS");
 MODULE_DEVICE_TABLE(wmi, lwmi_other_id_table);
 MODULE_AUTHOR("Derek J. Clark <derekjohn.clark@gmail.com>");
+MODULE_AUTHOR("Rong Zhang <i@rong.moe>");
 MODULE_DESCRIPTION("Lenovo Other Mode WMI Driver");
 MODULE_LICENSE("GPL");
-- 
2.51.0


