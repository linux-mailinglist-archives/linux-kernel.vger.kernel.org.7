Return-Path: <linux-kernel+bounces-829681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 416BCB979F0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 23:48:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB2917A4F81
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 21:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF34130F94D;
	Tue, 23 Sep 2025 21:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="jA+U/Yto"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11FE30DD08;
	Tue, 23 Sep 2025 21:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758664111; cv=none; b=ETecKIKKc5U9Q65zFIVx4F3IVGmA6WLkk7G03ktS0eMh3TiT8bSBgxgGc1zMElRgJqel/R9KdcWSwMij2AJw+rwuNqhjgRoUPVIIDDAGshOdputT7PGlyKlcvqUS50SrO7JiAPJxBwyQxae+R0U/MEECC6pV8Yd4m1gEQNA1kQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758664111; c=relaxed/simple;
	bh=4+2FcMpYoV1isFVulU/5/4nG+kK10gGwl2gZX8VERNc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=luJ3vCJZ2L8li4496tYQ60xgBxSZoJM0b6e6oPhzbC3jfyyMrgiwqs16+gU5jEH/L08F3yK8hCrtlRef0VqMzHh4Gh42RNlkr3ZsXdXlKllZPffLP2hJwBAyJQDGYrola2AmDnNenYvwdHSz/n/EDjLA/B3+BsHu9DDbNEALm6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=jA+U/Yto; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1758664106; x=1759268906; i=w_armin@gmx.de;
	bh=beXBLL4rR2MYV0Cm2O+Z6Dc8eHAGdTeXJnBQr17Ny8E=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=jA+U/YtoFhfc7eVUDtupNJUbwurQNre1H/aM6zN7R67lH1zXNlo1hmnoIRIL8saM
	 0aHPV6T62lp6ZLymMua3MUXKXOLfxibeALrme71YMPRAVymF43UdVQg1EBMwWxtfb
	 y76rm4tjcOgt9fSJ9h2DLH0k5vg/DknhCUbGT1HqyNtz/7QmyT8JuAAKXiXuE2j+X
	 nvV1OskcGgd+7bNQCf4+koMGBEEorvY0hsofi5zwQlauHw1uVtbgXSoQjNpGyJE0B
	 P3QoY9HbBbPr2bfU0k/0PM9a6jKZwdwqTFoiPG3uNl7AD/brX8jzyTd6APYEPNN1a
	 oMdn2HjtkSkh0DeBAA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.fritz.box ([93.202.247.91]) by mail.gmx.net
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MgNh1-1uQB1x0Q51-00jODo; Tue, 23 Sep 2025 23:48:26 +0200
From: Armin Wolf <W_Armin@gmx.de>
To: jlee@suse.com,
	basak.sb2006@gmail.com,
	rayanmargham4@gmail.com
Cc: kuurtb@gmail.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] platform/x86: acer-wmi: Add fan control support
Date: Tue, 23 Sep 2025 23:48:12 +0200
Message-Id: <20250923214814.325808-3-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250923214814.325808-1-W_Armin@gmx.de>
References: <20250923214814.325808-1-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:VPNEJHsS12UHsfCGfRsUHz4SDgMI6ZY4n0kW40uebmIpjm4V84a
 jz+zQS2Vo2JvJp5Az+ar/FOlbD/1UX0HX1Y4bRbCOZ0bmIyh1V6Jzl6sflH0JSM16Wudsg4
 vFaedKGSBuYG5MEI+cc6sF6tPJ4Z88RVrEJGZJGuPqSTe6vaS8UDk4f9RoKc3cVEqRQJ+aq
 5CndKj8rcT469fkYmibAA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:00VhLvQVaF0=;iJOPxjYoerrZLSp1B5fpm2caCOB
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


