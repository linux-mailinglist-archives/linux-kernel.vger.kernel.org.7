Return-Path: <linux-kernel+bounces-778156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BF8DB2E20B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 18:13:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D9CF17313D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 16:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D12E4322DC6;
	Wed, 20 Aug 2025 16:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="llRstwbm"
Received: from relay11.grserver.gr (relay11.grserver.gr [78.46.171.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC917322552;
	Wed, 20 Aug 2025 16:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.46.171.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755706005; cv=none; b=jEh4eT4UW6GVfN+3YZtBHJ0v+PdCD3WeTRY+FZOMm4ATIP8Je/eaOM2ii0HQpeU1uk5l6pn+QW3Nd9IUFO0K3z2Vcb3et2N+iMqKYRgeOGJSVW/PqmDCL0K0w5AhIeIh+ZbC/n3BEssKiujVI9Y8h5lgIAbSM7KG9f+x2PMHe6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755706005; c=relaxed/simple;
	bh=OyjLUoxtggp5d0+RZpYLfQvewHpf4cKCUFH27ITNgXU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=asIyOL2AUk1hJ/RB88g15cSoSAe3Hz0gMBii+MjsD/LMF58MOwTf04/D0bqqAUyVtxlqPKR6ZwaxLlcJsBUw5jnNHZzwJJ1GO3oePH3byG/AafrrnWZQyPUwoXuiOE+/NWcYrsGQuzkp5ZmsxKkBV57HvrHF17qNEJgXP5MMdHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=llRstwbm; arc=none smtp.client-ip=78.46.171.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from relay11 (localhost.localdomain [127.0.0.1])
	by relay11.grserver.gr (Proxmox) with ESMTP id DB58BC5C8C;
	Wed, 20 Aug 2025 19:06:35 +0300 (EEST)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay11.grserver.gr (Proxmox) with ESMTPS id 21AF9C5C88;
	Wed, 20 Aug 2025 19:06:35 +0300 (EEST)
Received: from antheas-z13 (unknown [IPv6:2a05:f6c2:511b:0:7200:c86a:8976:4786])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id 53EDA205624;
	Wed, 20 Aug 2025 19:06:34 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1755705994;
	bh=aDYXMKRx6Z5R2mtYbT8/3FxTRnPKyI8a7RykQdzlWVQ=; h=From:To:Subject;
	b=llRstwbmO0UkCV3zSsUGx+ZjPn/TRdd+IZcrbpKDDqim9sTMRqnZrtADkp3Rn1Fg7
	 2w5OyEsMozm5G1O61Zwyj9EL7/NZJwjVcr3LupWIdFTVPyjGWBjg6HkyhqwV90ikMi
	 gAOl6VEmw3Hscj71TSnEwUuPvkY3/c1R3woyxUgv7j9BEOVJY2wdHWKG8tuXK8p9iW
	 AC4jRmuGQrmObguie5YHj+zushLNwCTNcLm6n9lXbAQ7Dnz8uQND/u+wKquvn+/cU1
	 Z6tHhFhPjg4gE4CXxK6mxkhG5c8C97hExEsWxP66xLIaSpKd2aOOXPg6EvvOFbH+EZ
	 HlPhUV93YMZUQ==
Authentication-Results: linux3247.grserver.gr;
	spf=pass (sender IP is 2a05:f6c2:511b:0:7200:c86a:8976:4786) smtp.mailfrom=lkml@antheas.dev smtp.helo=antheas-z13
Received-SPF: pass (linux3247.grserver.gr: connection is authenticated)
From: Antheas Kapenekakis <lkml@antheas.dev>
To: platform-driver-x86@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	Hans de Goede <hansg@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Derek John Clark <derekjohn.clark@gmail.com>,
	=?UTF-8?q?Joaqu=C3=ADn=20Ignacio=20Aramend=C3=ADa?= <samsagax@gmail.com>,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Antheas Kapenekakis <lkml@antheas.dev>
Subject: [PATCH v1 5/5] platform/x86: ayaneo-ec: Move Ayaneo devices from
 oxpec to ayaneo-ec
Date: Wed, 20 Aug 2025 18:06:28 +0200
Message-ID: <20250820160628.99678-6-lkml@antheas.dev>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250820160628.99678-1-lkml@antheas.dev>
References: <20250820160628.99678-1-lkml@antheas.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: 
 <175570599483.2162826.3848553097643706063@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.3 at linux3247.grserver.gr
X-Virus-Status: Clean

Currently, the oxpec driver contains Ayaneo devices. Move them to the
new ayaneo-ec driver, which is dedicated to them.

As this driver supports charge inhibition for Ayaneo, add support for it
for the AIR, AIR 1S, AB05-Medoncino, AIR Pro, and Kun, referenced from
the out-of-tree ayaneo-platform driver.

In addition, update the readmes of oxpec to reflect this change.

Link: https://github.com/ShadowBlip/ayaneo-platform
Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
---
 drivers/platform/x86/Kconfig     |   4 +-
 drivers/platform/x86/ayaneo-ec.c |  66 ++++++++++++++++++
 drivers/platform/x86/oxpec.c     | 115 +------------------------------
 3 files changed, 68 insertions(+), 117 deletions(-)

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index c871a722e5ef..06b53b0a3818 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -1031,9 +1031,7 @@ config OXP_EC
 	help
 		Enables support for the platform EC of OneXPlayer and AOKZOE
 		handheld devices. This includes fan speed, fan controls, and
-		disabling the default TDP behavior of the device. Due to legacy
-		reasons, this driver also provides hwmon functionality to Ayaneo
-		devices and the OrangePi Neo.
+		disabling the default TDP behavior of the device.
 
 source "drivers/platform/x86/tuxedo/Kconfig"
 
diff --git a/drivers/platform/x86/ayaneo-ec.c b/drivers/platform/x86/ayaneo-ec.c
index eb7f9ae03b4f..d70fd0bd620e 100644
--- a/drivers/platform/x86/ayaneo-ec.c
+++ b/drivers/platform/x86/ayaneo-ec.c
@@ -83,6 +83,15 @@ struct ayaneo_fw_attr {
 	struct kobj_attribute current_value;
 };
 
+static const struct ayaneo_ec_quirk quirk_fan = {
+	.has_fan_control = true,
+};
+
+static const struct ayaneo_ec_quirk quirk_charge_limit = {
+	.has_fan_control = true,
+	.has_charge_control = true,
+};
+
 static const struct ayaneo_ec_quirk ayaneo3 = {
 	.has_fan_control = true,
 	.has_charge_control = true,
@@ -91,6 +100,63 @@ static const struct ayaneo_ec_quirk ayaneo3 = {
 };
 
 static const struct dmi_system_id dmi_table[] = {
+
+	{
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "AYANEO"),
+			DMI_MATCH(DMI_BOARD_NAME, "AYANEO 2"),
+		},
+		.driver_data = (void *)&quirk_fan,
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "AYANEO"),
+			DMI_MATCH(DMI_BOARD_NAME, "FLIP"),
+		},
+		.driver_data = (void *)&quirk_fan,
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "AYANEO"),
+			DMI_MATCH(DMI_BOARD_NAME, "GEEK"),
+		},
+		.driver_data = (void *)&quirk_fan,
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "AYANEO"),
+			DMI_EXACT_MATCH(DMI_BOARD_NAME, "AIR"),
+		},
+		.driver_data = (void *)&quirk_charge_limit,
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "AYANEO"),
+			DMI_EXACT_MATCH(DMI_BOARD_NAME, "AIR 1S"),
+		},
+		.driver_data = (void *)&quirk_charge_limit,
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "AYANEO"),
+			DMI_EXACT_MATCH(DMI_BOARD_NAME, "AB05-Mendocino"),
+		},
+		.driver_data = (void *)&quirk_charge_limit,
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "AYANEO"),
+			DMI_EXACT_MATCH(DMI_BOARD_NAME, "AIR Pro"),
+		},
+		.driver_data = (void *)&quirk_charge_limit,
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "AYANEO"),
+			DMI_EXACT_MATCH(DMI_BOARD_NAME, "KUN"),
+		},
+		.driver_data = (void *)&quirk_charge_limit,
+	},
 	{
 		.matches = {
 			DMI_MATCH(DMI_BOARD_VENDOR, "AYANEO"),
diff --git a/drivers/platform/x86/oxpec.c b/drivers/platform/x86/oxpec.c
index eb076bb4099b..2074650f5ba0 100644
--- a/drivers/platform/x86/oxpec.c
+++ b/drivers/platform/x86/oxpec.c
@@ -1,8 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * Platform driver for OneXPlayer and AOKZOE devices. For the time being,
- * it also exposes fan controls for AYANEO, and OrangePi Handhelds via
- * hwmon sysfs.
+ * Platform driver for OneXPlayer and AOKZOE devices.
  *
  * Fan control is provided via pwm interface in the range [0-255].
  * Old AMD boards use [0-100] as range in the EC, the written value is
@@ -43,14 +41,6 @@ static bool unlock_global_acpi_lock(void)
 
 enum oxp_board {
 	aok_zoe_a1 = 1,
-	aya_neo_2,
-	aya_neo_air,
-	aya_neo_air_1s,
-	aya_neo_air_plus_mendo,
-	aya_neo_air_pro,
-	aya_neo_flip,
-	aya_neo_geek,
-	aya_neo_kun,
 	orange_pi_neo,
 	oxp_2,
 	oxp_fly,
@@ -124,62 +114,6 @@ static const struct dmi_system_id dmi_table[] = {
 		},
 		.driver_data = (void *)aok_zoe_a1,
 	},
-	{
-		.matches = {
-			DMI_MATCH(DMI_BOARD_VENDOR, "AYANEO"),
-			DMI_MATCH(DMI_BOARD_NAME, "AYANEO 2"),
-		},
-		.driver_data = (void *)aya_neo_2,
-	},
-	{
-		.matches = {
-			DMI_MATCH(DMI_BOARD_VENDOR, "AYANEO"),
-			DMI_EXACT_MATCH(DMI_BOARD_NAME, "AIR"),
-		},
-		.driver_data = (void *)aya_neo_air,
-	},
-	{
-		.matches = {
-			DMI_MATCH(DMI_BOARD_VENDOR, "AYANEO"),
-			DMI_EXACT_MATCH(DMI_BOARD_NAME, "AIR 1S"),
-		},
-		.driver_data = (void *)aya_neo_air_1s,
-	},
-	{
-		.matches = {
-			DMI_MATCH(DMI_BOARD_VENDOR, "AYANEO"),
-			DMI_EXACT_MATCH(DMI_BOARD_NAME, "AB05-Mendocino"),
-		},
-		.driver_data = (void *)aya_neo_air_plus_mendo,
-	},
-	{
-		.matches = {
-			DMI_MATCH(DMI_BOARD_VENDOR, "AYANEO"),
-			DMI_EXACT_MATCH(DMI_BOARD_NAME, "AIR Pro"),
-		},
-		.driver_data = (void *)aya_neo_air_pro,
-	},
-	{
-		.matches = {
-			DMI_MATCH(DMI_BOARD_VENDOR, "AYANEO"),
-			DMI_MATCH(DMI_BOARD_NAME, "FLIP"),
-		},
-		.driver_data = (void *)aya_neo_flip,
-	},
-	{
-		.matches = {
-			DMI_MATCH(DMI_BOARD_VENDOR, "AYANEO"),
-			DMI_MATCH(DMI_BOARD_NAME, "GEEK"),
-		},
-		.driver_data = (void *)aya_neo_geek,
-	},
-	{
-		.matches = {
-			DMI_MATCH(DMI_BOARD_VENDOR, "AYANEO"),
-			DMI_EXACT_MATCH(DMI_BOARD_NAME, "KUN"),
-		},
-		.driver_data = (void *)aya_neo_kun,
-	},
 	{
 		.matches = {
 			DMI_MATCH(DMI_BOARD_VENDOR, "OrangePi"),
@@ -658,13 +592,6 @@ static int oxp_pwm_enable(void)
 	case orange_pi_neo:
 		return write_to_ec(ORANGEPI_SENSOR_PWM_ENABLE_REG, PWM_MODE_MANUAL);
 	case aok_zoe_a1:
-	case aya_neo_2:
-	case aya_neo_air:
-	case aya_neo_air_plus_mendo:
-	case aya_neo_air_pro:
-	case aya_neo_flip:
-	case aya_neo_geek:
-	case aya_neo_kun:
 	case oxp_2:
 	case oxp_fly:
 	case oxp_mini_amd:
@@ -685,14 +612,6 @@ static int oxp_pwm_disable(void)
 	case orange_pi_neo:
 		return write_to_ec(ORANGEPI_SENSOR_PWM_ENABLE_REG, PWM_MODE_AUTO);
 	case aok_zoe_a1:
-	case aya_neo_2:
-	case aya_neo_air:
-	case aya_neo_air_1s:
-	case aya_neo_air_plus_mendo:
-	case aya_neo_air_pro:
-	case aya_neo_flip:
-	case aya_neo_geek:
-	case aya_neo_kun:
 	case oxp_2:
 	case oxp_fly:
 	case oxp_mini_amd:
@@ -713,14 +632,6 @@ static int oxp_pwm_read(long *val)
 	case orange_pi_neo:
 		return read_from_ec(ORANGEPI_SENSOR_PWM_ENABLE_REG, 1, val);
 	case aok_zoe_a1:
-	case aya_neo_2:
-	case aya_neo_air:
-	case aya_neo_air_1s:
-	case aya_neo_air_plus_mendo:
-	case aya_neo_air_pro:
-	case aya_neo_flip:
-	case aya_neo_geek:
-	case aya_neo_kun:
 	case oxp_2:
 	case oxp_fly:
 	case oxp_mini_amd:
@@ -760,14 +671,6 @@ static int oxp_pwm_fan_speed(long *val)
 	case oxp_g1_i:
 		return read_from_ec(OXP_2_SENSOR_FAN_REG, 2, val);
 	case aok_zoe_a1:
-	case aya_neo_2:
-	case aya_neo_air:
-	case aya_neo_air_1s:
-	case aya_neo_air_plus_mendo:
-	case aya_neo_air_pro:
-	case aya_neo_flip:
-	case aya_neo_geek:
-	case aya_neo_kun:
 	case oxp_fly:
 	case oxp_mini_amd:
 	case oxp_mini_amd_a07:
@@ -796,14 +699,6 @@ static int oxp_pwm_input_write(long val)
 		/* scale to range [0-184] */
 		val = (val * 184) / 255;
 		return write_to_ec(OXP_SENSOR_PWM_REG, val);
-	case aya_neo_2:
-	case aya_neo_air:
-	case aya_neo_air_1s:
-	case aya_neo_air_plus_mendo:
-	case aya_neo_air_pro:
-	case aya_neo_flip:
-	case aya_neo_geek:
-	case aya_neo_kun:
 	case oxp_mini_amd:
 	case oxp_mini_amd_a07:
 		/* scale to range [0-100] */
@@ -840,14 +735,6 @@ static int oxp_pwm_input_read(long *val)
 		/* scale from range [0-184] */
 		*val = (*val * 255) / 184;
 		break;
-	case aya_neo_2:
-	case aya_neo_air:
-	case aya_neo_air_1s:
-	case aya_neo_air_plus_mendo:
-	case aya_neo_air_pro:
-	case aya_neo_flip:
-	case aya_neo_geek:
-	case aya_neo_kun:
 	case oxp_mini_amd:
 	case oxp_mini_amd_a07:
 		ret = read_from_ec(OXP_SENSOR_PWM_REG, 1, val);
-- 
2.50.1



