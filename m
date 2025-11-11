Return-Path: <linux-kernel+bounces-894860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B8EE8C4C474
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 09:11:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DC6ED4F4FC9
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 08:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD5EA30F7FE;
	Tue, 11 Nov 2025 08:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="E4Mb6pXi"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388A12E6CA4;
	Tue, 11 Nov 2025 08:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762848416; cv=none; b=GbsV5uKgEhkOFm0tSMJDUfGk/zfeYKmSmHbp83IPB2Gp6l4fSAAhKrHHZi1zRQYADUzDw7eOJfTvuFZocwW8VP6RbLRvS5CFr8PBwuAFXtYFYZZ2N0L5H0fF9p/7qMjGtceHXp5mPOguxOwDzD6tfv6Byt1Mi6cgEtrWhPBmWIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762848416; c=relaxed/simple;
	bh=/uwVvW0pbTS9bjEBEuKG0TQTsZPUZ/jXto5yDTL859k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=MoQXhiIDWSJLRJzZE3HzkratsMCVxDz1CzGrhffvkHCfII5ZrTlkqOdW8rFjlQ3MYuSJaNT0UB2HjmOjFkXiZJtmWBbmQt7HpXpoy+86IqclXctmkuqbaYbIqHR3e5A++jKHpXucEA60Ky8z9lttfcEp7stI+evFeuEY/FTr2M0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=E4Mb6pXi; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id; bh=LVY/qXJT/dFIyE7
	zug1PdV0UNb0G6jAnlhPWKVUV4Ic=; b=E4Mb6pXioVvY20dtptb4Kjjl8meUPOj
	DZI8sSAd0I6Te2z2unvT0LXMg3IwPYFAYWPS+ZzACFxKLvKbPigf01UFcSVEiPig
	pLw5jnSHLoG88N32XEt2ScKC4rFupwPTZ2lzNVECxgkQk/MbHnBU7jiZG3rLau3h
	C9Vo3X7x8qmU=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wCnq6ln7hJpK0KCDA--.117S7;
	Tue, 11 Nov 2025 16:06:11 +0800 (CST)
From: Wenliang Yan <wenliang202407@163.com>
To: linux@roeck-us.net,
	Jean Delvare <jdelvare@suse.com>
Cc: christophe.jaillet@wanadoo.fr,
	conor+dt@kernel.org,
	corbet@lwn.net,
	devicetree@vger.kernel.org,
	krzk+dt@kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	robh@kernel.org,
	wenliang202407@163.com
Subject: [PATCH 5/8] hwmon:(ina3221)Introduce power attribute and other characteristics of other attribute
Date: Tue, 11 Nov 2025 03:05:43 -0500
Message-Id: <20251111080546.32421-6-wenliang202407@163.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20251111080546.32421-1-wenliang202407@163.com>
References: <20251111080546.32421-1-wenliang202407@163.com>
X-CM-TRANSID:_____wCnq6ln7hJpK0KCDA--.117S7
X-Coremail-Antispam: 1Uf129KBjvJXoWxtryfCryfCF48WFW5WF47CFg_yoW7tF43pa
	ykJ3yftr18Ar93Zw4Ika1UXFn8t34xGay7Ar1Ig397JanxAryvvr48K3WvvF90kryfZF1F
	k342qrW8Gr13JrUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0JjnManUUUUU=
X-CM-SenderInfo: xzhqzxhdqjjiisuqlqqrwthudrp/xtbCvxW3i2kS7nVYwwAA3t
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

SQ52210 has built-in current and power sensors as well as multiple
alert functions. Add power attributes and different critical
characteristics in hwmon to report the corresponding data.

Signed-off-by: Wenliang Yan <wenliang202407@163.com>
---
 Documentation/hwmon/ina3221.rst | 24 +++++++++++++
 drivers/hwmon/ina3221.c         | 60 +++++++++++++++++++++++++++++----
 2 files changed, 77 insertions(+), 7 deletions(-)

diff --git a/Documentation/hwmon/ina3221.rst b/Documentation/hwmon/ina3221.rst
index 8c12c54d2c24..224c6cf735ed 100644
--- a/Documentation/hwmon/ina3221.rst
+++ b/Documentation/hwmon/ina3221.rst
@@ -13,6 +13,13 @@ Supported chips:
 
 	       https://www.ti.com/
 
+  * Silergy SQ52210
+
+    Prefix: 'SQ52210'
+
+    Addresses: I2C 0x40 - 0x43
+
+
 Author: Andrew F. Davis <afd@ti.com>
 
 Description
@@ -23,6 +30,9 @@ side of up to three D.C. power supplies. The INA3221 monitors both shunt drop
 and supply voltage, with programmable conversion times and averaging, current
 and power are calculated host-side from these.
 
+The SQ52210 is a mostly compatible chip from Silergy. It incorporates internal
+current and power registers, and provides an extra configurable alert function.
+
 Sysfs entries
 -------------
 
@@ -72,3 +82,17 @@ update_interval         Data conversion time in millisecond, following:
                         Note that setting update_interval to 0ms sets both BC
                         and SC to 140 us (minimum conversion time).
 ======================= =======================================================
+
+Additional sysfs entries for sq52210
+-------------------------------------
+
+======================= =======================================================
+in[123]_crit            Critical high bus voltage
+in[123]_crit_alarm      Bus voltage critical high alarm
+in[123]_lcrit           Critical low bus voltage
+in[123]_lcrit_alarm     Bus voltage critical low alarm
+curr[123]_lcrit         Critical low current
+curr[123]_lcrit_alarm   Current critical low alarm
+power[123]_input        Current for channels 1, 2, and 3 respectively
+power[123]_crit         Critical high power
+power[123]_crit_alarm   Power critical high alarm
diff --git a/drivers/hwmon/ina3221.c b/drivers/hwmon/ina3221.c
index e339860ed3a2..77b2505a49a2 100644
--- a/drivers/hwmon/ina3221.c
+++ b/drivers/hwmon/ina3221.c
@@ -652,6 +652,8 @@ static umode_t ina3221_is_visible(const void *drvdata,
 {
 	const struct ina3221_data *ina = drvdata;
 	const struct ina3221_input *input = NULL;
+	bool has_alerts = ina->config->has_alerts;
+	bool has_power = ina->config->has_power;
 
 	switch (type) {
 	case hwmon_chip:
@@ -679,6 +681,16 @@ static umode_t ina3221_is_visible(const void *drvdata,
 			return 0444;
 		case hwmon_in_enable:
 			return 0644;
+		case hwmon_in_crit:
+		case hwmon_in_lcrit:
+			if (has_alerts)
+				return 0644;
+			return 0;
+		case hwmon_in_crit_alarm:
+		case hwmon_in_lcrit_alarm:
+			if (has_alerts)
+				return 0444;
+			return 0;
 		default:
 			return 0;
 		}
@@ -691,6 +703,28 @@ static umode_t ina3221_is_visible(const void *drvdata,
 		case hwmon_curr_crit:
 		case hwmon_curr_max:
 			return 0644;
+		case hwmon_curr_lcrit:
+			if (has_alerts)
+				return 0644;
+			return 0;
+		case hwmon_curr_lcrit_alarm:
+			if (has_alerts)
+				return 0444;
+			return 0;
+		default:
+			return 0;
+		}
+		case hwmon_power:
+		switch (attr) {
+		case hwmon_power_input:
+		case hwmon_power_crit_alarm:
+			if (has_power)
+				return 0444;
+			return 0;
+		case hwmon_power_crit:
+			if (has_alerts)
+				return 0644;
+			return 0;
 		default:
 			return 0;
 		}
@@ -701,7 +735,14 @@ static umode_t ina3221_is_visible(const void *drvdata,
 
 #define INA3221_HWMON_CURR_CONFIG (HWMON_C_INPUT | \
 				   HWMON_C_CRIT | HWMON_C_CRIT_ALARM | \
-				   HWMON_C_MAX | HWMON_C_MAX_ALARM)
+				   HWMON_C_MAX | HWMON_C_MAX_ALARM | \
+				   HWMON_C_LCRIT | HWMON_C_LCRIT_ALARM)
+#define SQ52210_HWMON_POWER_CONFIG (HWMON_P_INPUT | \
+				   HWMON_P_CRIT | HWMON_P_CRIT_ALARM)
+#define SQ52210_HWMON_BUS_CONFIG (HWMON_I_INPUT | \
+				   HWMON_I_ENABLE | HWMON_I_LABEL | \
+				   HWMON_I_LCRIT_ALARM | HWMON_I_LCRIT |\
+				   HWMON_I_CRIT_ALARM | HWMON_I_CRIT)
 
 static const struct hwmon_channel_info * const ina3221_info[] = {
 	HWMON_CHANNEL_INFO(chip,
@@ -711,9 +752,9 @@ static const struct hwmon_channel_info * const ina3221_info[] = {
 			   /* 0: dummy, skipped in is_visible */
 			   HWMON_I_INPUT,
 			   /* 1-3: input voltage Channels */
-			   HWMON_I_INPUT | HWMON_I_ENABLE | HWMON_I_LABEL,
-			   HWMON_I_INPUT | HWMON_I_ENABLE | HWMON_I_LABEL,
-			   HWMON_I_INPUT | HWMON_I_ENABLE | HWMON_I_LABEL,
+			   SQ52210_HWMON_BUS_CONFIG,
+			   SQ52210_HWMON_BUS_CONFIG,
+			   SQ52210_HWMON_BUS_CONFIG,
 			   /* 4-6: shunt voltage Channels */
 			   HWMON_I_INPUT,
 			   HWMON_I_INPUT,
@@ -727,6 +768,11 @@ static const struct hwmon_channel_info * const ina3221_info[] = {
 			   INA3221_HWMON_CURR_CONFIG,
 			   /* 4: summation of current channels */
 			   HWMON_C_INPUT | HWMON_C_CRIT | HWMON_C_CRIT_ALARM),
+	HWMON_CHANNEL_INFO(power,
+			   /* 1-3: power channels*/
+			   SQ52210_HWMON_POWER_CONFIG,
+			   SQ52210_HWMON_POWER_CONFIG,
+			   SQ52210_HWMON_POWER_CONFIG),
 	NULL
 };
 
@@ -748,7 +794,7 @@ static const struct hwmon_chip_info ina3221_chip_info = {
  * Calculate the value corresponding to one LSB of the current and
  * power registers.
  * formula : Current_LSB = Shunt_LSB / Rshunt
- *			 Power_LSB = power_lsb_factor * Current_LSB
+ *           Power_LSB = power_lsb_factor * Current_LSB
  */
 static int ina3221_set_shunt(struct ina3221_data *ina, unsigned long val)
 {
@@ -1023,8 +1069,8 @@ static int ina3221_probe(struct i2c_client *client)
 	}
 
 	hwmon_dev = devm_hwmon_device_register_with_info(dev, client->name, ina,
-							&ina3221_chip_info,
-							ina3221_groups);
+							 &ina3221_chip_info,
+							 ina3221_groups);
 	if (IS_ERR(hwmon_dev)) {
 		dev_err(dev, "Unable to register hwmon device\n");
 		ret = PTR_ERR(hwmon_dev);
-- 
2.17.1


