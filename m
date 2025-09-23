Return-Path: <linux-kernel+bounces-829694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B348B97A49
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 23:52:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2278332127D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 21:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F1ED30FF1E;
	Tue, 23 Sep 2025 21:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="uXRoY31c"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA75030E84A;
	Tue, 23 Sep 2025 21:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758664341; cv=none; b=mPEc07dmZyeeJyMi8DlTHzXhAR9hkl5jkK4ZE36x1bGGXWBCrQV8xoUShWSMK7NNP7JzASCcMfWEcDVoWC8LbjQPqOir2YPwL7b9v6N5isW36QgXVJ4mag+noDjK9FtU0teDlmV/t54s7ghDx1z3P3sslYF/cdG+TKPtlqHLwaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758664341; c=relaxed/simple;
	bh=4+2FcMpYoV1isFVulU/5/4nG+kK10gGwl2gZX8VERNc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Llgq/iphLeT1QWLD4DzSVVnfvqH3AoKCkWnpMzgddxvvioj6A7c+Awz9PEyuT7WgRM+30V7zN9OIy3swy483ajracmz0inDq1b9KEbQoLdvAsv4lvZhXXcUP4noBReTpEWtTv/pId/xpEFFsi8l7Z+l7q7JZC5USwomaYbRlBAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=uXRoY31c; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1758664336; x=1759269136; i=w_armin@gmx.de;
	bh=beXBLL4rR2MYV0Cm2O+Z6Dc8eHAGdTeXJnBQr17Ny8E=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=uXRoY31cHxOgQJRUgN1l5TPS/LGJJXpmmGWmjqsBZcN/99hIa4YH24w+3iEnunSW
	 XaVkaWjXW0ldyIvrN/zrkihlKbhjymUCM8JzSjRm07iEkHdx/yKedN8jfUGncpFRf
	 UfJW5OeBaIF9/BXesKxzUvGyN9Ox0zGwxV5Rzai/BtGnS5yB0eeevUay3jtaXvima
	 /Xu8ekLl84C2tJafqwsqJjJmTWqNIHtin9sJXmtrCjpHnXYijh2h+mMgM05JRq+4V
	 ksY77wCFQm988iGOrKZ+pFmokGngU5W4yyVAQCijRBIqgdFUGl1JUkgUP7OCIoqxJ
	 CwNVmPGwh4WHegsxYg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.fritz.box ([93.202.247.91]) by mail.gmx.net
 (mrgmx105 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MIx3C-1ulImA1fuU-00JsNz; Tue, 23 Sep 2025 23:52:16 +0200
From: Armin Wolf <W_Armin@gmx.de>
To: jlee@suse.com,
	basak.sb2006@gmail.com,
	rayanmargham4@gmail.com
Cc: kuurtb@gmail.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/4] platform/x86: acer-wmi: Add fan control support
Date: Tue, 23 Sep 2025 23:52:03 +0200
Message-Id: <20250923215205.326367-3-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250923215205.326367-1-W_Armin@gmx.de>
References: <20250923215205.326367-1-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:IGdS4Y3S7+k2KOp7hpoULEz2Xx5XT2DykOehlF3LCWhfndlAEp6
 Qsm6tq9SxxyYAm+hUKymPEw6whpJ2Pik78IyQwQ9rQLKm01gVFile2Ob8bmdV3QPqKfi/yQ
 ewnK9aYPwhK8i/U+DVMVqvXSIZGWB7RC+HaFHQZvJroRshZoBSMkE+L+PERhWwjbzrwSTZM
 BJAWJPUYevu1/0LBy68tA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:nIps1Xf4KWI=;5t7c96gbVL2jKMGVajt6bLxzVbn
 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

Add support for controlling the fan speed using the
SetGamingFanSpeed() and GetGamingFanSpeed() WMI methods.

This feature is only enabled if the machine has ACER_CAP_PWM enabled
and depend on ACER_CAP_HWMON for detecting the number of available
fans.

Reviewed-by: Kurt Borja <kuurtb@gmail.com>
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/platform/x86/acer-wmi.c | 221 +++++++++++++++++++++++++++++++-
 1 file changed, 219 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/acer-wmi.c b/drivers/platform/x86/acer-w=
mi.c
index a41555ee8589..345b6e24ae31 100644
=2D-- a/drivers/platform/x86/acer-wmi.c
+++ b/drivers/platform/x86/acer-wmi.c
@@ -12,10 +12,12 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
=20
 #include <linux/kernel.h>
+#include <linux/minmax.h>
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/types.h>
 #include <linux/dmi.h>
+#include <linux/fixp-arith.h>
 #include <linux/backlight.h>
 #include <linux/leds.h>
 #include <linux/platform_device.h>
@@ -69,11 +71,16 @@ MODULE_LICENSE("GPL");
 #define ACER_WMID_GET_GAMING_LED_METHODID 4
 #define ACER_WMID_GET_GAMING_SYS_INFO_METHODID 5
 #define ACER_WMID_SET_GAMING_FAN_BEHAVIOR_METHODID 14
+#define ACER_WMID_GET_GAMING_FAN_BEHAVIOR_METHODID 15
+#define ACER_WMID_SET_GAMING_FAN_SPEED_METHODID 16
+#define ACER_WMID_GET_GAMING_FAN_SPEED_METHODID 17
 #define ACER_WMID_SET_GAMING_MISC_SETTING_METHODID 22
 #define ACER_WMID_GET_GAMING_MISC_SETTING_METHODID 23
=20
+#define ACER_GAMING_FAN_BEHAVIOR_STATUS_MASK GENMASK_ULL(7, 0)
 #define ACER_GAMING_FAN_BEHAVIOR_ID_MASK GENMASK_ULL(15, 0)
 #define ACER_GAMING_FAN_BEHAVIOR_SET_MODE_MASK GENMASK_ULL(23, 16)
+#define ACER_GAMING_FAN_BEHAVIOR_GET_MODE_MASK GENMASK_ULL(23, 8)
=20
 #define ACER_GAMING_FAN_BEHAVIOR_CPU BIT(0)
 #define ACER_GAMING_FAN_BEHAVIOR_GPU BIT(3)
@@ -81,6 +88,10 @@ MODULE_LICENSE("GPL");
 #define ACER_GAMING_FAN_BEHAVIOR_CPU_MODE_MASK GENMASK(1, 0)
 #define ACER_GAMING_FAN_BEHAVIOR_GPU_MODE_MASK GENMASK(7, 6)
=20
+#define ACER_GAMING_FAN_SPEED_STATUS_MASK GENMASK_ULL(7, 0)
+#define ACER_GAMING_FAN_SPEED_ID_MASK GENMASK_ULL(7, 0)
+#define ACER_GAMING_FAN_SPEED_VALUE_MASK GENMASK_ULL(15, 8)
+
 #define ACER_GAMING_MISC_SETTING_STATUS_MASK GENMASK_ULL(7, 0)
 #define ACER_GAMING_MISC_SETTING_INDEX_MASK GENMASK_ULL(7, 0)
 #define ACER_GAMING_MISC_SETTING_VALUE_MASK GENMASK_ULL(15, 8)
@@ -130,6 +141,11 @@ enum acer_wmi_predator_v4_sensor_id {
 	ACER_WMID_SENSOR_GPU_TEMPERATURE	=3D 0x0A,
 };
=20
+enum acer_wmi_gaming_fan_id {
+	ACER_WMID_CPU_FAN	=3D 0x01,
+	ACER_WMID_GPU_FAN	=3D 0x04,
+};
+
 enum acer_wmi_gaming_fan_mode {
 	ACER_WMID_FAN_MODE_AUTO		=3D 0x01,
 	ACER_WMID_FAN_MODE_TURBO	=3D 0x02,
@@ -292,6 +308,7 @@ struct hotkey_function_type_aa {
 #define ACER_CAP_TURBO_FAN		BIT(9)
 #define ACER_CAP_PLATFORM_PROFILE	BIT(10)
 #define ACER_CAP_HWMON			BIT(11)
+#define ACER_CAP_PWM			BIT(12)
=20
 /*
  * Interface type flags
@@ -386,6 +403,7 @@ struct quirk_entry {
 	u8 cpu_fans;
 	u8 gpu_fans;
 	u8 predator_v4;
+	u8 pwm;
 };
=20
 static struct quirk_entry *quirks;
@@ -405,6 +423,9 @@ static void __init set_quirks(void)
 	if (quirks->predator_v4)
 		interface->capability |=3D ACER_CAP_PLATFORM_PROFILE |
 					 ACER_CAP_HWMON;
+
+	if (quirks->pwm)
+		interface->capability |=3D ACER_CAP_PWM;
 }
=20
 static int __init dmi_matched(const struct dmi_system_id *dmi)
@@ -1651,6 +1672,27 @@ static int WMID_gaming_set_fan_behavior(u16 fan_bit=
map, u8 mode_bitmap)
 	return 0;
 }
=20
+static int WMID_gaming_get_fan_behavior(u16 fan_bitmap, u8 *mode_bitmap)
+{
+	acpi_status status;
+	u32 input =3D 0;
+	u64 result;
+
+	input |=3D FIELD_PREP(ACER_GAMING_FAN_BEHAVIOR_ID_MASK, fan_bitmap);
+	status =3D WMI_gaming_execute_u32_u64(ACER_WMID_GET_GAMING_FAN_BEHAVIOR_=
METHODID, input,
+					    &result);
+	if (ACPI_FAILURE(status))
+		return -EIO;
+
+	/* The return status must be zero for the operation to have succeeded */
+	if (FIELD_GET(ACER_GAMING_FAN_BEHAVIOR_STATUS_MASK, result))
+		return -EIO;
+
+	*mode_bitmap =3D FIELD_GET(ACER_GAMING_FAN_BEHAVIOR_GET_MODE_MASK, resul=
t);
+
+	return 0;
+}
+
 static void WMID_gaming_set_fan_mode(u8 fan_mode)
 {
 	u16 mode_bitmap =3D 0;
@@ -1669,6 +1711,55 @@ static void WMID_gaming_set_fan_mode(u8 fan_mode)
 	WMID_gaming_set_fan_behavior(fan_bitmap, mode_bitmap);
 }
=20
+static int WMID_gaming_set_gaming_fan_speed(u8 fan, u8 speed)
+{
+	acpi_status status;
+	u64 input =3D 0;
+	u64 result;
+
+	if (speed > 100)
+		return -EINVAL;
+
+	input |=3D FIELD_PREP(ACER_GAMING_FAN_SPEED_ID_MASK, fan);
+	input |=3D FIELD_PREP(ACER_GAMING_FAN_SPEED_VALUE_MASK, speed);
+
+	status =3D WMI_gaming_execute_u64(ACER_WMID_SET_GAMING_FAN_SPEED_METHODI=
D, input, &result);
+	if (ACPI_FAILURE(status))
+		return -EIO;
+
+	switch (FIELD_GET(ACER_GAMING_FAN_SPEED_STATUS_MASK, result)) {
+	case 0x00:
+		return 0;
+	case 0x01:
+		return -ENODEV;
+	case 0x02:
+		return -EINVAL;
+	default:
+		return -ENXIO;
+	}
+}
+
+static int WMID_gaming_get_gaming_fan_speed(u8 fan, u8 *speed)
+{
+	acpi_status status;
+	u32 input =3D 0;
+	u64 result;
+
+	input |=3D FIELD_PREP(ACER_GAMING_FAN_SPEED_ID_MASK, fan);
+
+	status =3D WMI_gaming_execute_u32_u64(ACER_WMID_GET_GAMING_FAN_SPEED_MET=
HODID, input,
+					    &result);
+	if (ACPI_FAILURE(status))
+		return -EIO;
+
+	if (FIELD_GET(ACER_GAMING_FAN_SPEED_STATUS_MASK, result))
+		return -ENODEV;
+
+	*speed =3D FIELD_GET(ACER_GAMING_FAN_SPEED_VALUE_MASK, result);
+
+	return 0;
+}
+
 static int WMID_gaming_set_misc_setting(enum acer_wmi_gaming_misc_setting=
 setting, u8 value)
 {
 	acpi_status status;
@@ -2840,6 +2931,16 @@ static const enum acer_wmi_predator_v4_sensor_id ac=
er_wmi_fan_channel_to_sensor_
 	[1] =3D ACER_WMID_SENSOR_GPU_FAN_SPEED,
 };
=20
+static const enum acer_wmi_gaming_fan_id acer_wmi_fan_channel_to_fan_id[]=
 =3D {
+	[0] =3D ACER_WMID_CPU_FAN,
+	[1] =3D ACER_WMID_GPU_FAN,
+};
+
+static const u16 acer_wmi_fan_channel_to_fan_bitmap[] =3D {
+	[0] =3D ACER_GAMING_FAN_BEHAVIOR_CPU,
+	[1] =3D ACER_GAMING_FAN_BEHAVIOR_GPU,
+};
+
 static umode_t acer_wmi_hwmon_is_visible(const void *data,
 					 enum hwmon_sensor_types type, u32 attr,
 					 int channel)
@@ -2851,6 +2952,11 @@ static umode_t acer_wmi_hwmon_is_visible(const void=
 *data,
 	case hwmon_temp:
 		sensor_id =3D acer_wmi_temp_channel_to_sensor_id[channel];
 		break;
+	case hwmon_pwm:
+		if (!has_cap(ACER_CAP_PWM))
+			return 0;
+
+		fallthrough;
 	case hwmon_fan:
 		sensor_id =3D acer_wmi_fan_channel_to_sensor_id[channel];
 		break;
@@ -2858,8 +2964,12 @@ static umode_t acer_wmi_hwmon_is_visible(const void=
 *data,
 		return 0;
 	}
=20
-	if (*supported_sensors & BIT(sensor_id - 1))
+	if (*supported_sensors & BIT(sensor_id - 1)) {
+		if (type =3D=3D hwmon_pwm)
+			return 0644;
+
 		return 0444;
+	}
=20
 	return 0;
 }
@@ -2868,8 +2978,10 @@ static int acer_wmi_hwmon_read(struct device *dev, =
enum hwmon_sensor_types type,
 			       u32 attr, int channel, long *val)
 {
 	u64 command =3D ACER_WMID_CMD_GET_PREDATOR_V4_SENSOR_READING;
+	u8 fan, speed, mode_bitmap;
+	u16 fan_bitmap;
+	int mode, ret;
 	u64 result;
-	int ret;
=20
 	switch (type) {
 	case hwmon_temp:
@@ -2893,6 +3005,106 @@ static int acer_wmi_hwmon_read(struct device *dev,=
 enum hwmon_sensor_types type,
=20
 		*val =3D FIELD_GET(ACER_PREDATOR_V4_SENSOR_READING_BIT_MASK, result);
 		return 0;
+	case hwmon_pwm:
+		switch (attr) {
+		case hwmon_pwm_input:
+			fan =3D acer_wmi_fan_channel_to_fan_id[channel];
+			ret =3D WMID_gaming_get_gaming_fan_speed(fan, &speed);
+			if (ret < 0)
+				return ret;
+
+			*val =3D fixp_linear_interpolate(0, 0, 100, U8_MAX, speed);
+			return 0;
+		case hwmon_pwm_enable:
+			fan_bitmap =3D acer_wmi_fan_channel_to_fan_bitmap[channel];
+			ret =3D WMID_gaming_get_fan_behavior(fan_bitmap, &mode_bitmap);
+			if (ret < 0)
+				return ret;
+
+			switch (channel) {
+			case 0:
+				mode =3D FIELD_GET(ACER_GAMING_FAN_BEHAVIOR_CPU_MODE_MASK,
+						 mode_bitmap);
+				break;
+			case 1:
+				mode =3D FIELD_GET(ACER_GAMING_FAN_BEHAVIOR_GPU_MODE_MASK,
+						 mode_bitmap);
+				break;
+			default:
+				return -EINVAL;
+			}
+
+			switch (mode) {
+			case ACER_WMID_FAN_MODE_AUTO:
+				*val =3D 2;
+				return 0;
+			case ACER_WMID_FAN_MODE_TURBO:
+				*val =3D 0;
+				return 0;
+			case ACER_WMID_FAN_MODE_CUSTOM:
+				*val =3D 1;
+				return 0;
+			default:
+				return -ENXIO;
+			}
+		default:
+			return -EOPNOTSUPP;
+		}
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static int acer_wmi_hwmon_write(struct device *dev, enum hwmon_sensor_typ=
es type,
+				u32 attr, int channel, long val)
+{
+	u8 fan, speed, mode_bitmap;
+	u16 fan_bitmap;
+	int mode;
+
+	switch (type) {
+	case hwmon_pwm:
+		switch (attr) {
+		case hwmon_pwm_input:
+			fan =3D acer_wmi_fan_channel_to_fan_id[channel];
+			speed =3D fixp_linear_interpolate(0, 0, U8_MAX, 100,
+							clamp_val(val, 0, U8_MAX));
+
+			return WMID_gaming_set_gaming_fan_speed(fan, speed);
+		case hwmon_pwm_enable:
+			fan_bitmap =3D acer_wmi_fan_channel_to_fan_bitmap[channel];
+
+			switch (val) {
+			case 0:
+				mode =3D ACER_WMID_FAN_MODE_TURBO;
+				break;
+			case 1:
+				mode =3D ACER_WMID_FAN_MODE_CUSTOM;
+				break;
+			case 2:
+				mode =3D ACER_WMID_FAN_MODE_AUTO;
+				break;
+			default:
+				return -EINVAL;
+			}
+
+			switch (channel) {
+			case 0:
+				mode_bitmap =3D FIELD_PREP(ACER_GAMING_FAN_BEHAVIOR_CPU_MODE_MASK,
+							 mode);
+				break;
+			case 1:
+				mode_bitmap =3D FIELD_PREP(ACER_GAMING_FAN_BEHAVIOR_GPU_MODE_MASK,
+							 mode);
+				break;
+			default:
+				return -EINVAL;
+			}
+
+			return WMID_gaming_set_fan_behavior(fan_bitmap, mode_bitmap);
+		default:
+			return -EOPNOTSUPP;
+		}
 	default:
 		return -EOPNOTSUPP;
 	}
@@ -2908,11 +3120,16 @@ static const struct hwmon_channel_info *const acer=
_wmi_hwmon_info[] =3D {
 			   HWMON_F_INPUT,
 			   HWMON_F_INPUT
 			   ),
+	HWMON_CHANNEL_INFO(pwm,
+			   HWMON_PWM_INPUT | HWMON_PWM_ENABLE,
+			   HWMON_PWM_INPUT | HWMON_PWM_ENABLE
+			   ),
 	NULL
 };
=20
 static const struct hwmon_ops acer_wmi_hwmon_ops =3D {
 	.read =3D acer_wmi_hwmon_read,
+	.write =3D acer_wmi_hwmon_write,
 	.is_visible =3D acer_wmi_hwmon_is_visible,
 };
=20
=2D-=20
2.39.5


