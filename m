Return-Path: <linux-kernel+bounces-695026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B218AE1438
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jun 2025 08:49:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 184EC5A0732
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jun 2025 06:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1CD72253EE;
	Fri, 20 Jun 2025 06:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JTuZOP4e"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F361E22259B;
	Fri, 20 Jun 2025 06:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750402156; cv=none; b=SAI1+eQUqkFCdi3lYwFDDv7y4kUog8RWW+v43kngogUKvA/8sFFXGWdKBqQyRYRD/T4ZsXWT+e0UwCS6RlPwBFXwnrDWlRmM/TkUaOW2W54A6s/C1L8ja23uc30hcA+D0q2pBBgqmYPZ5WiyyJId1qumwwxLltaoKN+E1ztZUjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750402156; c=relaxed/simple;
	bh=dWjbD6KBgrU4FBPtFvD9ZEHN+mTCM8TeFgskVQpY85k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tBZS7Ylse+X1LzKxyXu0lQtpzq47+7FmbC7VsZEaEHHYMUmaLDEpEmScuNfXxjoYlN5hvV2FBFSrT8byyzOzxktl+GF/cTRNm/NdFPFgI/KuI1G6HVIyHnFs++nAXW3sMHdixQTwkRfCa6skcNZjf/Q81dpYpLGacMcHXFleOV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JTuZOP4e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A82E0C4CEED;
	Fri, 20 Jun 2025 06:49:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750402155;
	bh=dWjbD6KBgrU4FBPtFvD9ZEHN+mTCM8TeFgskVQpY85k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=JTuZOP4enqXmt0to8ky1dALaqA11QnOKhx5xbs3PFY/C1yLAxyDQXGxjWHX0PeaJ+
	 wkDH9e9tw6BLddXmjLADngfEpS2PsnGF7bp9Gv4eafjn8rUVozsbbVqwuVc50DGFVx
	 Us6IQhDEiglh1H6z2RawfXeCmNGN/euCT0yPZ4OzUA8JE9X1mGR3PYPtZe1KJhUn40
	 TvHTxgg6+/faqabi4OZGm/b0G9bY1N/9qMSAeHkt8HUjVrg50gtpnkRKnZgkiZnwCj
	 XwghAj5vLwq3AvcLRKoercR59AwpD3e2r2tmZv4GYeQay3aSa9CbRoXYTMY+0mhrml
	 3SQSJcnA8Ohog==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94E77C77B7C;
	Fri, 20 Jun 2025 06:49:15 +0000 (UTC)
From: Sung-Chi Li via B4 Relay <devnull+lschyi.chromium.org@kernel.org>
Date: Fri, 20 Jun 2025 14:49:13 +0800
Subject: [PATCH v5 2/3] hwmon: (cros_ec) add PWM control over fans
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250620-cros_ec_fan-v5-2-5979ea1abb31@chromium.org>
References: <20250620-cros_ec_fan-v5-0-5979ea1abb31@chromium.org>
In-Reply-To: <20250620-cros_ec_fan-v5-0-5979ea1abb31@chromium.org>
To: Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, 
 Jonathan Corbet <corbet@lwn.net>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas@weissschuh.net>
Cc: chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org, 
 linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org, 
 Sung-Chi Li <lschyi@google.com>, Sung-Chi Li <lschyi@chromium.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1750402154; l=12717;
 i=lschyi@chromium.org; s=20250429; h=from:subject:message-id;
 bh=EPMPuA+MsJiIZ+4q1IGqpD+DfKgpA6trMJYZ9Lp8P1A=;
 b=4UTTyX2BbUqnOgKxluxfCgdaLKmlJUoIfsoF/cVoAOmqJw5VtZcD2srCm18hbNR9Di9uQxuqb
 vIiEZOX1PDvDpA5LQI0+aHgugw5CKAI0MB/HFYsqBsTwWoqannGNyLI
X-Developer-Key: i=lschyi@chromium.org; a=ed25519;
 pk=9gCZPRJmYyHDt6VN9FV2UreFcUr73JFrwYvmsltW9Y8=
X-Endpoint-Received: by B4 Relay for lschyi@chromium.org/20250429 with
 auth_id=392
X-Original-From: Sung-Chi Li <lschyi@chromium.org>
Reply-To: lschyi@chromium.org

From: Sung-Chi Li <lschyi@chromium.org>

Newer EC firmware supports controlling fans through host commands, so
adding corresponding implementations for controlling these fans in the
driver for other kernel services and userspace to control them.

The driver will first probe the supported host command versions (get and
set of fan PWM values, get and set of fan control mode) to see if the
connected EC fulfills the requirements of controlling the fan, then
exposes corresponding sysfs nodes for userspace to control the fan with
corresponding read and write implementations.
As EC will automatically change the fan mode to auto when the device is
suspended, the power management hooks are added as well to keep the fan
control mode and fan PWM value consistent during suspend and resume. As
we need to access the hwmon device in the power management hook, update
the driver by storing the hwmon device in the driver data as well.

Signed-off-by: Sung-Chi Li <lschyi@chromium.org>
Acked-by: Thomas Weißschuh <linux@weissschuh.net>
---
 Documentation/hwmon/cros_ec_hwmon.rst |   5 +-
 drivers/hwmon/cros_ec_hwmon.c         | 224 ++++++++++++++++++++++++++++++++++
 2 files changed, 228 insertions(+), 1 deletion(-)

diff --git a/Documentation/hwmon/cros_ec_hwmon.rst b/Documentation/hwmon/cros_ec_hwmon.rst
index 47ecae983bdbef4bfcafc5dd2fff3de039f77f8e..355557a08c9a54b4c177bafde3743e7dc02218be 100644
--- a/Documentation/hwmon/cros_ec_hwmon.rst
+++ b/Documentation/hwmon/cros_ec_hwmon.rst
@@ -23,4 +23,7 @@ ChromeOS embedded controller used in Chromebooks and other devices.
 
 The channel labels exposed via hwmon are retrieved from the EC itself.
 
-Fan and temperature readings are supported.
+Fan and temperature readings are supported. PWM fan control is also supported if
+the EC also supports setting fan PWM values and fan mode. Note that EC will
+switch fan control mode back to auto when suspended. This driver will restore
+the fan state to what they were before suspended when resumed.
diff --git a/drivers/hwmon/cros_ec_hwmon.c b/drivers/hwmon/cros_ec_hwmon.c
index 5514cf780b8beab272670d6591ed298ddac5afbf..e26590e6e3b5894678791696a41820120bde6cd5 100644
--- a/drivers/hwmon/cros_ec_hwmon.c
+++ b/drivers/hwmon/cros_ec_hwmon.c
@@ -7,6 +7,7 @@
 
 #include <linux/device.h>
 #include <linux/hwmon.h>
+#include <linux/math.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
@@ -17,10 +18,17 @@
 
 #define DRV_NAME	"cros-ec-hwmon"
 
+#define CROS_EC_HWMON_PWM_GET_FAN_DUTY_CMD_VERSION	0
+#define CROS_EC_HWMON_PWM_SET_FAN_DUTY_CMD_VERSION	1
+#define CROS_EC_HWMON_THERMAL_AUTO_FAN_CTRL_CMD_VERSION	2
+
 struct cros_ec_hwmon_priv {
 	struct cros_ec_device *cros_ec;
 	const char *temp_sensor_names[EC_TEMP_SENSOR_ENTRIES + EC_TEMP_SENSOR_B_ENTRIES];
 	u8 usable_fans;
+	bool fan_control_supported;
+	u8 manual_fans; /* bits to indicate whether the fan is set to manual */
+	u8 manual_fan_pwm[EC_FAN_SPEED_ENTRIES];
 };
 
 static int cros_ec_hwmon_read_fan_speed(struct cros_ec_device *cros_ec, u8 index, u16 *speed)
@@ -36,6 +44,42 @@ static int cros_ec_hwmon_read_fan_speed(struct cros_ec_device *cros_ec, u8 index
 	return 0;
 }
 
+static int cros_ec_hwmon_read_pwm_value(struct cros_ec_device *cros_ec, u8 index, u8 *pwm_value)
+{
+	struct ec_params_pwm_get_fan_duty req = {
+		.fan_idx = index,
+	};
+	struct ec_response_pwm_get_fan_duty resp;
+	int ret;
+
+	ret = cros_ec_cmd(cros_ec, CROS_EC_HWMON_PWM_GET_FAN_DUTY_CMD_VERSION,
+			  EC_CMD_PWM_GET_FAN_DUTY, &req, sizeof(req), &resp, sizeof(resp));
+	if (ret < 0)
+		return ret;
+
+	*pwm_value = (u8)DIV_ROUND_CLOSEST(le32_to_cpu(resp.percent) * 255, 100);
+	return 0;
+}
+
+static int cros_ec_hwmon_read_pwm_enable(struct cros_ec_device *cros_ec, u8 index,
+					 u8 *control_method)
+{
+	struct ec_params_auto_fan_ctrl_v2 req = {
+		.cmd = EC_AUTO_FAN_CONTROL_CMD_GET,
+		.fan_idx = index,
+	};
+	struct ec_response_auto_fan_control resp;
+	int ret;
+
+	ret = cros_ec_cmd(cros_ec, CROS_EC_HWMON_THERMAL_AUTO_FAN_CTRL_CMD_VERSION,
+			  EC_CMD_THERMAL_AUTO_FAN_CTRL, &req, sizeof(req), &resp, sizeof(resp));
+	if (ret < 0)
+		return ret;
+
+	*control_method = resp.is_auto ? 2 : 1;
+	return 0;
+}
+
 static int cros_ec_hwmon_read_temp(struct cros_ec_device *cros_ec, u8 index, u8 *temp)
 {
 	unsigned int offset;
@@ -75,6 +119,8 @@ static int cros_ec_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
 {
 	struct cros_ec_hwmon_priv *priv = dev_get_drvdata(dev);
 	int ret = -EOPNOTSUPP;
+	u8 control_method;
+	u8 pwm_value;
 	u16 speed;
 	u8 temp;
 
@@ -92,6 +138,16 @@ static int cros_ec_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
 			if (ret == 0)
 				*val = cros_ec_hwmon_is_error_fan(speed);
 		}
+	} else if (type == hwmon_pwm) {
+		if (attr == hwmon_pwm_enable) {
+			ret = cros_ec_hwmon_read_pwm_enable(priv->cros_ec, channel, &control_method);
+			if (ret == 0)
+				*val = control_method;
+		} else if (attr == hwmon_pwm_input) {
+			ret = cros_ec_hwmon_read_pwm_value(priv->cros_ec, channel, &pwm_value);
+			if (ret == 0)
+				*val = pwm_value;
+		}
 	} else if (type == hwmon_temp) {
 		if (attr == hwmon_temp_input) {
 			ret = cros_ec_hwmon_read_temp(priv->cros_ec, channel, &temp);
@@ -124,6 +180,74 @@ static int cros_ec_hwmon_read_string(struct device *dev, enum hwmon_sensor_types
 	return -EOPNOTSUPP;
 }
 
+static int cros_ec_hwmon_set_fan_pwm_val(struct cros_ec_device *cros_ec, u8 index, u8 val)
+{
+	struct ec_params_pwm_set_fan_duty_v1 req = {
+		.fan_idx = index,
+		.percent = DIV_ROUND_CLOSEST((uint32_t)val * 100, 255),
+	};
+	int ret;
+
+	ret = cros_ec_cmd(cros_ec, CROS_EC_HWMON_PWM_SET_FAN_DUTY_CMD_VERSION,
+			  EC_CMD_PWM_SET_FAN_DUTY, &req, sizeof(req), NULL, 0);
+	if (ret < 0)
+		return ret;
+	return 0;
+}
+
+static int cros_ec_hwmon_write_pwm_input(struct cros_ec_device *cros_ec, u8 index, u8 val)
+{
+	u8 control_method;
+	int ret;
+
+	ret = cros_ec_hwmon_read_pwm_enable(cros_ec, index, &control_method);
+	if (ret)
+		return ret;
+	if (control_method != 1)
+		return -EOPNOTSUPP;
+
+	return cros_ec_hwmon_set_fan_pwm_val(cros_ec, index, val);
+}
+
+static int cros_ec_hwmon_write_pwm_enable(struct cros_ec_device *cros_ec, u8 index, u8 val)
+{
+	struct ec_params_auto_fan_ctrl_v2 req = {
+		.fan_idx = index,
+		.cmd = EC_AUTO_FAN_CONTROL_CMD_SET,
+	};
+	int ret;
+
+	/* No CrOS EC supports no fan speed control */
+	if (val == 0)
+		return -EOPNOTSUPP;
+
+	req.set_auto = (val != 1) ? true : false;
+	ret = cros_ec_cmd(cros_ec, CROS_EC_HWMON_THERMAL_AUTO_FAN_CTRL_CMD_VERSION,
+			  EC_CMD_THERMAL_AUTO_FAN_CTRL, &req, sizeof(req), NULL, 0);
+	if (ret < 0)
+		return ret;
+	return 0;
+}
+
+static int cros_ec_hwmon_write(struct device *dev, enum hwmon_sensor_types type, u32 attr,
+			       int channel, long val)
+{
+	struct cros_ec_hwmon_priv *priv = dev_get_drvdata(dev);
+
+	if (type == hwmon_pwm) {
+		switch (attr) {
+		case hwmon_pwm_input:
+			return cros_ec_hwmon_write_pwm_input(priv->cros_ec, channel, val);
+		case hwmon_pwm_enable:
+			return cros_ec_hwmon_write_pwm_enable(priv->cros_ec, channel, val);
+		default:
+			return -EOPNOTSUPP;
+		}
+	}
+
+	return -EOPNOTSUPP;
+}
+
 static umode_t cros_ec_hwmon_is_visible(const void *data, enum hwmon_sensor_types type,
 					u32 attr, int channel)
 {
@@ -132,6 +256,9 @@ static umode_t cros_ec_hwmon_is_visible(const void *data, enum hwmon_sensor_type
 	if (type == hwmon_fan) {
 		if (priv->usable_fans & BIT(channel))
 			return 0444;
+	} else if (type == hwmon_pwm) {
+		if (priv->fan_control_supported && priv->usable_fans & BIT(channel))
+			return 0644;
 	} else if (type == hwmon_temp) {
 		if (priv->temp_sensor_names[channel])
 			return 0444;
@@ -146,6 +273,11 @@ static const struct hwmon_channel_info * const cros_ec_hwmon_info[] = {
 			   HWMON_F_INPUT | HWMON_F_FAULT,
 			   HWMON_F_INPUT | HWMON_F_FAULT,
 			   HWMON_F_INPUT | HWMON_F_FAULT),
+	HWMON_CHANNEL_INFO(pwm,
+			   HWMON_PWM_INPUT | HWMON_PWM_ENABLE,
+			   HWMON_PWM_INPUT | HWMON_PWM_ENABLE,
+			   HWMON_PWM_INPUT | HWMON_PWM_ENABLE,
+			   HWMON_PWM_INPUT | HWMON_PWM_ENABLE),
 	HWMON_CHANNEL_INFO(temp,
 			   HWMON_T_INPUT | HWMON_T_FAULT | HWMON_T_LABEL,
 			   HWMON_T_INPUT | HWMON_T_FAULT | HWMON_T_LABEL,
@@ -177,6 +309,7 @@ static const struct hwmon_channel_info * const cros_ec_hwmon_info[] = {
 static const struct hwmon_ops cros_ec_hwmon_ops = {
 	.read = cros_ec_hwmon_read,
 	.read_string = cros_ec_hwmon_read_string,
+	.write = cros_ec_hwmon_write,
 	.is_visible = cros_ec_hwmon_is_visible,
 };
 
@@ -232,6 +365,22 @@ static void cros_ec_hwmon_probe_fans(struct cros_ec_hwmon_priv *priv)
 	}
 }
 
+static inline bool is_cros_ec_cmd_available(struct cros_ec_device *cros_ec,
+					    u16 cmd, u8 version)
+{
+	int ret;
+
+	ret = cros_ec_get_cmd_versions(cros_ec, cmd);
+	return ret >= 0 && (ret & EC_VER_MASK(version));
+}
+
+static bool cros_ec_hwmon_probe_fan_control_supported(struct cros_ec_device *cros_ec)
+{
+	return is_cros_ec_cmd_available(cros_ec, EC_CMD_PWM_GET_FAN_DUTY, CROS_EC_HWMON_PWM_GET_FAN_DUTY_CMD_VERSION) &&
+	       is_cros_ec_cmd_available(cros_ec, EC_CMD_PWM_SET_FAN_DUTY, CROS_EC_HWMON_PWM_SET_FAN_DUTY_CMD_VERSION) &&
+	       is_cros_ec_cmd_available(cros_ec, EC_CMD_THERMAL_AUTO_FAN_CTRL, CROS_EC_HWMON_THERMAL_AUTO_FAN_CTRL_CMD_VERSION);
+}
+
 static int cros_ec_hwmon_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -258,13 +407,86 @@ static int cros_ec_hwmon_probe(struct platform_device *pdev)
 
 	cros_ec_hwmon_probe_temp_sensors(dev, priv, thermal_version);
 	cros_ec_hwmon_probe_fans(priv);
+	priv->fan_control_supported = cros_ec_hwmon_probe_fan_control_supported(priv->cros_ec);
 
 	hwmon_dev = devm_hwmon_device_register_with_info(dev, "cros_ec", priv,
 							 &cros_ec_hwmon_chip_info, NULL);
+	platform_set_drvdata(pdev, priv);
 
 	return PTR_ERR_OR_ZERO(hwmon_dev);
 }
 
+static int cros_ec_hwmon_suspend(struct platform_device *pdev, pm_message_t state)
+{
+	struct cros_ec_hwmon_priv *priv = platform_get_drvdata(pdev);
+	u8 control_method;
+	size_t i;
+	int ret;
+
+	if (!priv->fan_control_supported)
+		return 0;
+
+	/* EC sets fan control to auto after suspended, store settings before suspending. */
+	for (i = 0; i < EC_FAN_SPEED_ENTRIES; i++) {
+		if (!(priv->usable_fans & BIT(i)))
+			continue;
+
+		ret = cros_ec_hwmon_read_pwm_enable(priv->cros_ec, i, &control_method);
+		if (ret) {
+			dev_warn(&pdev->dev, "failed to get mode setting for fan %zu: %d\n", i, ret);
+			continue;
+		}
+
+		if (control_method != 1) {
+			priv->manual_fans &= ~BIT(i);
+			continue;
+		} else {
+			priv->manual_fans |= BIT(i);
+		}
+
+		ret = cros_ec_hwmon_read_pwm_value(priv->cros_ec, i, &priv->manual_fan_pwm[i]);
+		/*
+		 * If storing the value failed, invalidate the stored mode value by setting it
+		 * to auto control. EC will automatically switch to auto mode for that fan after
+		 * suspended.
+		 */
+		if (ret) {
+			dev_warn(&pdev->dev, "failed to get PWM setting for fan %zu: %pe\n", i, ERR_PTR(ret));
+			priv->manual_fans &= ~BIT(i);
+			continue;
+		}
+	}
+
+	return 0;
+}
+
+static int cros_ec_hwmon_resume(struct platform_device *pdev)
+{
+	const struct cros_ec_hwmon_priv *priv = platform_get_drvdata(pdev);
+	size_t i;
+	int ret;
+
+	if (!priv->fan_control_supported)
+		return 0;
+
+	/* EC sets fan control to auto after suspend, restore to settings before suspend. */
+	for (i = 0; i < EC_FAN_SPEED_ENTRIES; i++) {
+		if (!(priv->manual_fans & BIT(i)))
+			continue;
+
+		/*
+		 * Setting fan PWM value to EC will change the mode to manual for that fan in EC as
+		 * well, so we do not need to issue a separate fan mode to manual call.
+		 */
+		ret = cros_ec_hwmon_set_fan_pwm_val(priv->cros_ec, i, priv->manual_fan_pwm[i]);
+		if (ret)
+			dev_warn(&pdev->dev, "failed to restore settings for fan %zu: %pe\n", i,
+				 ERR_PTR(ret));
+	}
+
+	return 0;
+}
+
 static const struct platform_device_id cros_ec_hwmon_id[] = {
 	{ DRV_NAME, 0 },
 	{}
@@ -273,6 +495,8 @@ static const struct platform_device_id cros_ec_hwmon_id[] = {
 static struct platform_driver cros_ec_hwmon_driver = {
 	.driver.name	= DRV_NAME,
 	.probe		= cros_ec_hwmon_probe,
+	.suspend	= pm_ptr(cros_ec_hwmon_suspend),
+	.resume		= pm_ptr(cros_ec_hwmon_resume),
 	.id_table	= cros_ec_hwmon_id,
 };
 module_platform_driver(cros_ec_hwmon_driver);

-- 
2.50.0.rc2.701.gf1e915cc24-goog



