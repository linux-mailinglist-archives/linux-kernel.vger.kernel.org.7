Return-Path: <linux-kernel+bounces-854084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2962DBDD80C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 10:48:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D24E9542EB4
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 08:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBF9031A04F;
	Wed, 15 Oct 2025 08:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="n1Ly7GVM"
Received: from relay13.grserver.gr (relay13.grserver.gr [178.156.171.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F2793164AB;
	Wed, 15 Oct 2025 08:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.156.171.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760518018; cv=none; b=OQSwfk0CTCLTIQ6cNGJf/je5YPYb+ONuy95+V9qxetdcb2PeOfZw4NN/ltgHDeDLKKUDx2x6LomQ/EU1oJZebyLKLFprRBbj6MdVQysgW2GEyFQVmMn83wEkhR85jjImwtsEzNZSzxlMdfeQelZyBLfxVuIWYHBhJDtHfIjybKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760518018; c=relaxed/simple;
	bh=Z9tbIZw9pU5In5EkC/io3NickM+4mf4QkuHUv1cvOAs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nCTaU+4lWuJX1NBOnfzgOcK2PUyZIoqsQXnPJZP2Dwu8H9yLhspld3q1r/vQ4gcwfSMKGkDjre1Qu4CCRgDeUhH9OVZU6f6fMq4OypAZCyKpuKxYLKPN161mMlcSJ1FLNJ1EYsh2BOYfNZ5/u6Jw/c2hZ0wt4YA6+hFjw5V8A00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=n1Ly7GVM; arc=none smtp.client-ip=178.156.171.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from relay13 (localhost [127.0.0.1])
	by relay13.grserver.gr (Proxmox) with ESMTP id 0FE465E5E8;
	Wed, 15 Oct 2025 11:46:48 +0300 (EEST)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay13.grserver.gr (Proxmox) with ESMTPS id 853085E63F;
	Wed, 15 Oct 2025 11:46:40 +0300 (EEST)
Received: from antheas-z13 (x5996a8de.customers.hiper-net.dk [89.150.168.222])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id 04F7B1FD853;
	Wed, 15 Oct 2025 11:46:37 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1760517999;
	bh=ed1IvVEHRhOzq/wl0zxJt8n+k65sCASTGhGSPUkKVc4=; h=From:To:Subject;
	b=n1Ly7GVM8LIaFjeOFHel8nn1WMX2vin6baDBSKipwrMdwP52RvONjhs3HGMH8xOo5
	 4V3KgKJOIQBDyCervWIRfgcgqU5wSCbTyLAeWXq28Jym8b/havtXdcu977IEHoJsGj
	 VjAXzIYGKyXQ/W57RWjnz/VO36AuBbglWJfHjzBNgzvYyzcauRDTz8gIXz2T42s8Bq
	 XzPUSbFq3eVLTzXBEYNw4TYvTR5WLPxB5bPGpdY66pzjianftmtdPfMvjza7XTeACt
	 EvUnCg/9Vn7T8lXYt7JsyhxQlNRk0Ti182AT/UEffFykxzWeCQR475LH0q4njslM7H
	 7dFLrB1iJp3UA==
Authentication-Results: linux3247.grserver.gr;
	spf=pass (sender IP is 89.150.168.222) smtp.mailfrom=lkml@antheas.dev smtp.helo=antheas-z13
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
Subject: [PATCH v2 5/6] platform/x86: ayaneo-ec: Move Ayaneo devices from
 oxpec to ayaneo-ec
Date: Wed, 15 Oct 2025 10:44:13 +0200
Message-ID: <20251015084414.1391595-6-lkml@antheas.dev>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251015084414.1391595-1-lkml@antheas.dev>
References: <20251015084414.1391595-1-lkml@antheas.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: 
 <176051799961.921061.10136963435320844236@linux3247.grserver.gr>
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
Tested-by: Derek J. Clark <derekjohn.clark@gmail.com>
Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
---
 drivers/platform/x86/Kconfig     |   4 +-
 drivers/platform/x86/ayaneo-ec.c |  65 +++++++++++++++++
 drivers/platform/x86/oxpec.c     | 115 +------------------------------
 3 files changed, 67 insertions(+), 117 deletions(-)

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index f5b2edc6bc67..4d4be1634152 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -1043,9 +1043,7 @@ config OXP_EC
 	help
 		Enables support for the platform EC of OneXPlayer and AOKZOE
 		handheld devices. This includes fan speed, fan controls, and
-		disabling the default TDP behavior of the device. Due to legacy
-		reasons, this driver also provides hwmon functionality to Ayaneo
-		devices and the OrangePi Neo.
+		disabling the default TDP behavior of the device.
 
 source "drivers/platform/x86/tuxedo/Kconfig"
 
diff --git a/drivers/platform/x86/ayaneo-ec.c b/drivers/platform/x86/ayaneo-ec.c
index 363b61fc6e12..73e9dd39c703 100644
--- a/drivers/platform/x86/ayaneo-ec.c
+++ b/drivers/platform/x86/ayaneo-ec.c
@@ -49,6 +49,15 @@ struct ayaneo_ec_platform_data {
 	struct acpi_battery_hook battery_hook;
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
@@ -56,6 +65,62 @@ static const struct ayaneo_ec_quirk ayaneo3 = {
 };
 
 static const struct dmi_system_id dmi_table[] = {
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
index 54377b282ff8..144a454103b9 100644
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
@@ -131,62 +121,6 @@ static const struct dmi_system_id dmi_table[] = {
 		},
 		.driver_data = (void *)oxp_fly,
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
@@ -672,13 +606,6 @@ static int oxp_pwm_enable(void)
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
@@ -699,14 +626,6 @@ static int oxp_pwm_disable(void)
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
@@ -727,14 +646,6 @@ static int oxp_pwm_read(long *val)
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
@@ -774,14 +685,6 @@ static int oxp_pwm_fan_speed(long *val)
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
@@ -810,14 +713,6 @@ static int oxp_pwm_input_write(long val)
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
@@ -854,14 +749,6 @@ static int oxp_pwm_input_read(long *val)
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
2.51.0



