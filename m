Return-Path: <linux-kernel+bounces-811457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F4FCB52954
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 08:57:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D45A356122C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 06:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 001E626980B;
	Thu, 11 Sep 2025 06:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HtVN6w51"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21AFC2571B3;
	Thu, 11 Sep 2025 06:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757573799; cv=none; b=Muxv3HKhgo1PQ9l99VWHhTsKqNpJgURm19DPdxgQcZkxMtb56rjMj0V3xTYk7/ZAGtXdeWRBYZ8ey/cnOGrl12ooogz3Elo8W8/VtLdrKLMJZ6XX9FdNy7xHiZNOviGoA5HUyUy2Q52d0pgXFZdT4jd3LlboVix5CoHwvCZIcog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757573799; c=relaxed/simple;
	bh=oIM7g2ij+hRTtmsTUxg3aNAIPq94pwM+yFfdyQVRgp4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ozw9c2f+QDrm3ryjsw+/4tlD48ehhDOt6woU4qXBjk5LpSkWJxSleWEpY8SW+aiW4blx3iMB29BotrttRCAqcZtmIT2SXejNF4GewUbwHaKR36FrxvNsddO6HLH1qRNw0nMtoIHRjIz6bUt3w8qXlZkMYeLmeZ/CWTTEF9V4l3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HtVN6w51; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BBD13C4CEF9;
	Thu, 11 Sep 2025 06:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757573798;
	bh=oIM7g2ij+hRTtmsTUxg3aNAIPq94pwM+yFfdyQVRgp4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=HtVN6w51yenlx8NQFda6zv2A/9DA23KXbIlqC1UuFHSj2SwSLNfrIZUgPwT+z0n+j
	 cto1U+73uyOsymUvLGJ6wniL7SU1n4w7iuzwDU0PJ1NLQqObMjl+CdjNq3XbQ9mOlO
	 Y6UqsIH4zCuccjMkkp422SWn87iLxUjJJplgUrYPB0OA5kgZXRpr+5K3rxr/pPqzmn
	 g/gfY6XtIRDw2kJvwDgS+LCA0Ouw6BZTqmxN7kXEtnTef63tLiUg3X1X1UGuV7BEpf
	 GvmRqhsKF1Hxpa5TclbFM+nyMWo1TnvOWgDCwO/pvxBH5Z5xTr/wjMb87n8yzmtQSq
	 SmafPquHyzVRA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B11CCCAC592;
	Thu, 11 Sep 2025 06:56:38 +0000 (UTC)
From: Sung-Chi Li via B4 Relay <devnull+lschyi.google.com@kernel.org>
Date: Thu, 11 Sep 2025 06:56:36 +0000
Subject: [PATCH v6 3/3] hwmon: (cros_ec) register fans into thermal
 framework cooling devices
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250911-cros_ec_fan-v6-3-a1446cc098af@google.com>
References: <20250911-cros_ec_fan-v6-0-a1446cc098af@google.com>
In-Reply-To: <20250911-cros_ec_fan-v6-0-a1446cc098af@google.com>
To: Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 Guenter Roeck <linux@roeck-us.net>, Jonathan Corbet <corbet@lwn.net>
Cc: chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org, 
 linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org, 
 Sung-Chi Li <lschyi@google.com>, Sung-Chi Li <lschyi@chromium.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757573797; l=5416;
 i=lschyi@google.com; s=20250911; h=from:subject:message-id;
 bh=dck84HE8xEadqj5AMVaS+UMpm+4v/AhxG0nwdDKi0AE=;
 b=mNVajCQGJdiIFYhdqiYR2OqG/1lXeEbf6zST4/BPgFRx9SMdU/ddWPbQAnyA2rfjZ1kkV38aa
 gkvdBoFtPC8BUkeggHOR7fXDgNV2+A5gds8KwMgIHIXSW2R1ehiyUPX
X-Developer-Key: i=lschyi@google.com; a=ed25519;
 pk=fBhhFxZrEyInLLODzeoq06UxQhKVqNjmZ2680pwMBCM=
X-Endpoint-Received: by B4 Relay for lschyi@google.com/20250911 with
 auth_id=518
X-Original-From: Sung-Chi Li <lschyi@google.com>
Reply-To: lschyi@google.com

From: Sung-Chi Li <lschyi@chromium.org>

Register fans connected under EC as thermal cooling devices as well, so
these fans can then work with the thermal framework.

During the driver probing phase, we will also try to register each fan
as a thermal cooling device based on previous probe result (whether the
there are fans connected on that channel, and whether EC supports fan
control). The basic get max state, get current state, and set current
state methods are then implemented as well.

Signed-off-by: Sung-Chi Li <lschyi@chromium.org>
Acked-by: Thomas Weißschuh <linux@weissschuh.net>
---
 Documentation/hwmon/cros_ec_hwmon.rst |  2 +
 drivers/hwmon/cros_ec_hwmon.c         | 83 +++++++++++++++++++++++++++++++++++
 2 files changed, 85 insertions(+)

diff --git a/Documentation/hwmon/cros_ec_hwmon.rst b/Documentation/hwmon/cros_ec_hwmon.rst
index 355557a08c9a54b4c177bafde3743e7dc02218be..6db812708325f7abb6d319af3312b4079e6923c6 100644
--- a/Documentation/hwmon/cros_ec_hwmon.rst
+++ b/Documentation/hwmon/cros_ec_hwmon.rst
@@ -27,3 +27,5 @@ Fan and temperature readings are supported. PWM fan control is also supported if
 the EC also supports setting fan PWM values and fan mode. Note that EC will
 switch fan control mode back to auto when suspended. This driver will restore
 the fan state to what they were before suspended when resumed.
+If a fan is controllable, this driver will register that fan as a cooling device
+in the thermal framework as well.
diff --git a/drivers/hwmon/cros_ec_hwmon.c b/drivers/hwmon/cros_ec_hwmon.c
index 9eddc554ddefde42f70c09689b64ad9e636a3020..48331703f2f50decf245805d735de39105e5f39f 100644
--- a/drivers/hwmon/cros_ec_hwmon.c
+++ b/drivers/hwmon/cros_ec_hwmon.c
@@ -13,6 +13,7 @@
 #include <linux/platform_device.h>
 #include <linux/platform_data/cros_ec_commands.h>
 #include <linux/platform_data/cros_ec_proto.h>
+#include <linux/thermal.h>
 #include <linux/types.h>
 #include <linux/units.h>
 
@@ -31,6 +32,11 @@ struct cros_ec_hwmon_priv {
 	u8 manual_fan_pwm[EC_FAN_SPEED_ENTRIES];
 };
 
+struct cros_ec_hwmon_cooling_priv {
+	struct cros_ec_hwmon_priv *hwmon_priv;
+	u8 index;
+};
+
 static int cros_ec_hwmon_read_fan_speed(struct cros_ec_device *cros_ec, u8 index, u16 *speed)
 {
 	int ret;
@@ -308,6 +314,42 @@ static const struct hwmon_channel_info * const cros_ec_hwmon_info[] = {
 	NULL
 };
 
+static int cros_ec_hwmon_cooling_get_max_state(struct thermal_cooling_device *cdev,
+					       unsigned long *val)
+{
+	*val = 255;
+	return 0;
+}
+
+static int cros_ec_hwmon_cooling_get_cur_state(struct thermal_cooling_device *cdev,
+					       unsigned long *val)
+{
+	const struct cros_ec_hwmon_cooling_priv *priv = cdev->devdata;
+	u8 read_val;
+	int ret;
+
+	ret = cros_ec_hwmon_read_pwm_value(priv->hwmon_priv->cros_ec, priv->index, &read_val);
+	if (ret)
+		return ret;
+
+	*val = read_val;
+	return 0;
+}
+
+static int cros_ec_hwmon_cooling_set_cur_state(struct thermal_cooling_device *cdev,
+					       unsigned long val)
+{
+	const struct cros_ec_hwmon_cooling_priv *priv = cdev->devdata;
+
+	return cros_ec_hwmon_write_pwm_input(priv->hwmon_priv->cros_ec, priv->index, val);
+}
+
+static const struct thermal_cooling_device_ops cros_ec_thermal_cooling_ops = {
+	.get_max_state = cros_ec_hwmon_cooling_get_max_state,
+	.get_cur_state = cros_ec_hwmon_cooling_get_cur_state,
+	.set_cur_state = cros_ec_hwmon_cooling_set_cur_state,
+};
+
 static const struct hwmon_ops cros_ec_hwmon_ops = {
 	.read = cros_ec_hwmon_read,
 	.read_string = cros_ec_hwmon_read_string,
@@ -386,6 +428,46 @@ static bool cros_ec_hwmon_probe_fan_control_supported(struct cros_ec_device *cro
 					CROS_EC_HWMON_THERMAL_AUTO_FAN_CTRL_CMD_VERSION);
 }
 
+static void cros_ec_hwmon_register_fan_cooling_devices(struct device *dev,
+						       struct cros_ec_hwmon_priv *priv)
+{
+	struct cros_ec_hwmon_cooling_priv *cpriv;
+	struct thermal_cooling_device *cdev;
+	const char *type;
+	size_t i;
+
+	if (!IS_ENABLED(CONFIG_THERMAL))
+		return;
+
+	if (!priv->fan_control_supported)
+		return;
+
+	for (i = 0; i < EC_FAN_SPEED_ENTRIES; i++) {
+		if (!(priv->usable_fans & BIT(i)))
+			continue;
+
+		cpriv = devm_kzalloc(dev, sizeof(*cpriv), GFP_KERNEL);
+		if (!cpriv)
+			continue;
+
+		type = devm_kasprintf(dev, GFP_KERNEL, "%s-fan%zu", dev_name(dev), i);
+		if (!type) {
+			dev_warn(dev, "no memory to compose cooling device type for fan %zu\n", i);
+			continue;
+		}
+
+		cpriv->hwmon_priv = priv;
+		cpriv->index = i;
+		cdev = devm_thermal_of_cooling_device_register(dev, NULL, type, cpriv,
+							       &cros_ec_thermal_cooling_ops);
+		if (IS_ERR(cdev)) {
+			dev_warn(dev, "failed to register fan %zu as a cooling device: %pe\n", i,
+				 cdev);
+			continue;
+		}
+	}
+}
+
 static int cros_ec_hwmon_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -413,6 +495,7 @@ static int cros_ec_hwmon_probe(struct platform_device *pdev)
 	cros_ec_hwmon_probe_temp_sensors(dev, priv, thermal_version);
 	cros_ec_hwmon_probe_fans(priv);
 	priv->fan_control_supported = cros_ec_hwmon_probe_fan_control_supported(priv->cros_ec);
+	cros_ec_hwmon_register_fan_cooling_devices(dev, priv);
 
 	hwmon_dev = devm_hwmon_device_register_with_info(dev, "cros_ec", priv,
 							 &cros_ec_hwmon_chip_info, NULL);

-- 
2.51.0.384.g4c02a37b29-goog



