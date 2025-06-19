Return-Path: <linux-kernel+bounces-693442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B914ADFEF0
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jun 2025 09:43:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C44B8189B3C9
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jun 2025 07:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77FE525D204;
	Thu, 19 Jun 2025 07:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FMNFZ1nU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7BE7248868;
	Thu, 19 Jun 2025 07:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750318977; cv=none; b=b1hbZueK0BW6DteIijaTwQNEHhD77YAkf3rxq7/hNHmR/qTqW1L+Gcd84yMivp1+rwrJWmp2QqCrzRQWNJEUeYpj051l4vXeuswqtwJ+h/A/c8KMToTA9CaSLSDJc26lNGAtaGnw395dPtzDT/BxZeNn7Gvp7V+NHO8w65p7Rag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750318977; c=relaxed/simple;
	bh=RikCrKLnCHgGPRI5B8T21KzfkjhIAbjsuwYMRU52dRA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WwA2Ed+Ctex/PMAVySb+0HwTjQiCoCV47JGdYxRGcQnP2zJmYes+HP7aW4HpdnWnkD1LOaWGyI81OuxoMM0/I8f+lKyRWbkT67/54OS1sfkgJSK6HFVDabPggjtl5AI+B8HJH0c7VhsbViWKrq4RD0SrJeLorsN3SAJhrrVbKbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FMNFZ1nU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5505DC4CEF0;
	Thu, 19 Jun 2025 07:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750318977;
	bh=RikCrKLnCHgGPRI5B8T21KzfkjhIAbjsuwYMRU52dRA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=FMNFZ1nUawzVMsnxuAV8ZvSLCdcu6V/8dqwWDMNXcZ8307//KT+H9Jh96rABj7OKA
	 Ysd5TiqF4xmP2sxZdMC38/ZG5x4lqrjStLb+h+3svSfJXCtcuWcLu0awC6v7EfI2JD
	 m0oUHZL0zskinZOrW1roH4IBkcB85Dn0EPHgu93HsJan7fVMlC4DfHACHaJdGgZSq0
	 MYy/+96SYmgKOuTlxa1dXL7pJeykeLxw0CHYUPC4WUOjjc1fTBBi/oiq1CpnV3ekH7
	 ydwx5Jslr00WDLHFDWgz9OAX08/1YgTzY7RiKomz76eWThraxI6O81aPnZCRt8sXtf
	 RT7MpY5upztrw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46D00C761AE;
	Thu, 19 Jun 2025 07:42:57 +0000 (UTC)
From: Sung-Chi Li via B4 Relay <devnull+lschyi.chromium.org@kernel.org>
Date: Thu, 19 Jun 2025 15:42:56 +0800
Subject: [PATCH v4 3/3] hwmon: (cros_ec) register fans into thermal
 framework cooling devices
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250619-cros_ec_fan-v4-3-ca11548ce449@chromium.org>
References: <20250619-cros_ec_fan-v4-0-ca11548ce449@chromium.org>
In-Reply-To: <20250619-cros_ec_fan-v4-0-ca11548ce449@chromium.org>
To: Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, 
 Jonathan Corbet <corbet@lwn.net>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas@weissschuh.net>
Cc: chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org, 
 linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org, 
 Sung-Chi Li <lschyi@google.com>, Sung-Chi Li <lschyi@chromium.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1750318976; l=5521;
 i=lschyi@chromium.org; s=20250429; h=from:subject:message-id;
 bh=dGrNQjFZmAqqQuLX31fi6rvA+UA6e5udimOyMjEIouo=;
 b=0dwadgCMsVUj2zNX3LAZTyaW6PXKOphWxSH6/DPNS5uCEwqeWx63ZWVIgvgYoHCvDsHjphEi1
 L4uaCbewRHCA9AiGKf2p1+FNA5FaKMC2pN+rrjROQ6BHBtWACsiXCfq
X-Developer-Key: i=lschyi@chromium.org; a=ed25519;
 pk=9gCZPRJmYyHDt6VN9FV2UreFcUr73JFrwYvmsltW9Y8=
X-Endpoint-Received: by B4 Relay for lschyi@chromium.org/20250429 with
 auth_id=392
X-Original-From: Sung-Chi Li <lschyi@chromium.org>
Reply-To: lschyi@chromium.org

From: Sung-Chi Li <lschyi@chromium.org>

Register fans connected under EC as thermal cooling devices as well, so
these fans can then work with the thermal framework.

During the driver probing phase, we will also try to register each fan
as a thermal cooling device based on previous probe result (whether the
there are fans connected on that channel, and whether EC supports fan
control). The basic get max state, get current state, and set current
state methods are then implemented as well.

Signed-off-by: Sung-Chi Li <lschyi@chromium.org>
---
 Documentation/hwmon/cros_ec_hwmon.rst |  2 +
 drivers/hwmon/cros_ec_hwmon.c         | 85 +++++++++++++++++++++++++++++++++++
 2 files changed, 87 insertions(+)

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
index c0c4ffa6f85419edf5dacd730192e7f1c28e2e5c..572b194e51fb1a05fa5151abb0826d1c8ba2948d 100644
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
@@ -306,6 +312,42 @@ static const struct hwmon_channel_info * const cros_ec_hwmon_info[] = {
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
+	return ret;
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
@@ -381,6 +423,48 @@ static bool cros_ec_hwmon_probe_fan_control_supported(struct cros_ec_device *cro
 	       is_cros_ec_cmd_available(cros_ec, EC_CMD_THERMAL_AUTO_FAN_CTRL, CROS_EC_HWMON_THERMAL_AUTO_FAN_CTRL_CMD_VERSION);
 }
 
+static void cros_ec_hwmon_register_fan_cooling_devices(struct device *dev,
+						       struct cros_ec_hwmon_priv *priv)
+{
+	struct cros_ec_hwmon_cooling_priv *cpriv;
+	struct thermal_cooling_device *cdev;
+	char *type;
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
+		if (!cpriv) {
+			dev_warn(dev, "no memory for registering fan %zu as a cooling device\n", i);
+			continue;
+		}
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
@@ -408,6 +492,7 @@ static int cros_ec_hwmon_probe(struct platform_device *pdev)
 	cros_ec_hwmon_probe_temp_sensors(dev, priv, thermal_version);
 	cros_ec_hwmon_probe_fans(priv);
 	priv->fan_control_supported = cros_ec_hwmon_probe_fan_control_supported(priv->cros_ec);
+	cros_ec_hwmon_register_fan_cooling_devices(dev, priv);
 
 	hwmon_dev = devm_hwmon_device_register_with_info(dev, "cros_ec", priv,
 							 &cros_ec_hwmon_chip_info, NULL);

-- 
2.50.0.rc2.701.gf1e915cc24-goog



