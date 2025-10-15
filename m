Return-Path: <linux-kernel+bounces-855151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A02FBE066F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 21:29:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 516094F9753
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 19:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 131B130DD3F;
	Wed, 15 Oct 2025 19:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="Xrfh6hU4"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFC7230CDA0;
	Wed, 15 Oct 2025 19:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760556372; cv=none; b=nk9/TWLc2ST6FL1wPYqG1pEp5jrItu3VGhATMN140w8OCe6H5BnzHrcrJBndMgOB/fkYNMiF4HEsIxi588uIAhbS7IJaCayQzpOwwdyu078E8D0PYWr4WiZMoldND5rANh5CGNlg7P2ubpew2tWIbWK9n4d06yLgqbQmbdZ+23E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760556372; c=relaxed/simple;
	bh=BeVutDlmHfyEgq29MHh/eG0rhBXlQg6FhLUHmKlvP9c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FJjbZ84nIB8vIzdbLoytWjN+P0MOpOa6aszN1ngw9oDl4JuokNY33xif6hhHihH5nMchLsIHE9GgKBHQOjA00UvjzDQhCrdk1RmBoL47spjjVvOmZ28HIIeIYjAmN7t+DxJaQz1rRbQPTGGFmiwJ24Xz0JPFeRHUO+0+NMJRvak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=Xrfh6hU4; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1760556366; x=1761161166; i=w_armin@gmx.de;
	bh=8x++w5kKtkb5L638igKLwgbhTTNSnMUOsVRa1Fazw3Y=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Xrfh6hU48/b7VYsoOxSt+pelwWqm1FKU1mzl8skw4CTuYLBZXrsKriWQSTCscUnX
	 qvK4lJbuPfWcgU9o/+lOouTtqzWNdtwgAkPgTXEr1d1PPoW4QxANYLHyIxfKjYrCR
	 XAifgYspgAcdCckBCmzd7vWQ/DDYlIVh6oeBGI/PZTTimnYmt7GSCTNDDC9yXZPxF
	 MLw9vqGeNXy8rNTEznspm34d2ZrHtHLDz2Ycxh0YF47f1tU5RIAYdkUPDLjVE66FU
	 yjPRTmb3iP6CG/iVIH8uYfon/fB18V63mo7Qbdg0DKwEtnd2vqEQrdSC3pG3Y4CDU
	 RisimBXqUkMM+049XA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.fritz.box ([93.202.247.91]) by mail.gmx.net
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MgNh7-1ua2hV342h-00cdJZ; Wed, 15 Oct 2025 21:26:06 +0200
From: Armin Wolf <W_Armin@gmx.de>
To: jlee@suse.com,
	basak.sb2006@gmail.com,
	faiz.faadhillah@gmail.com,
	rayanmargham4@gmail.com
Cc: kuurtb@gmail.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/4] platform/x86: acer-wmi: Add fan control support
Date: Wed, 15 Oct 2025 21:25:49 +0200
Message-Id: <20251015192551.321200-3-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251015192551.321200-1-W_Armin@gmx.de>
References: <20251015192551.321200-1-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:zF6fSZK5c7p1EJst8KtnjLkefDzW307A/aW0RBHsbT171lcgjgr
 Tc1skzdh62pYiGJrEs/Z83Ip1VbNpPlfltq+LZJe7U8oDl7+0yPokfOix2IyYxJ2pEtnRnf
 V2Mqa1gfOEYQA/kyOq7PJhfkG0RKfSDbVdKyvGg5f2ISzB7W/kcCrkDWRGS9gL8aDeDdRu3
 0lLDNb2MFJJNfyNSYfK4g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:xFt8Ph7DB+Y=;cxgYTafd4Yny7+vtQAEqqmw6Wmg
 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
 PjBELjfbkxVvoPajs=

Add support for controlling the fan speed using the
SetGamingFanSpeed() and GetGamingFanSpeed() WMI methods.

This feature is only enabled if the machine has ACER_CAP_PWM enabled
and depend on ACER_CAP_HWMON for detecting the number of available
fans.

Reviewed-by: Kurt Borja <kuurtb@gmail.com>
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/platform/x86/acer-wmi.c | 208 +++++++++++++++++++++++++++++++-
 1 file changed, 207 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/acer-wmi.c b/drivers/platform/x86/acer-w=
mi.c
index e24233f6e055..4a408693379b 100644
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
@@ -69,6 +71,9 @@ MODULE_LICENSE("GPL");
 #define ACER_WMID_GET_GAMING_LED_METHODID 4
 #define ACER_WMID_GET_GAMING_SYS_INFO_METHODID 5
 #define ACER_WMID_SET_GAMING_FAN_BEHAVIOR_METHODID 14
+#define ACER_WMID_GET_GAMING_FAN_BEHAVIOR_METHODID 15
+#define ACER_WMID_SET_GAMING_FAN_SPEED_METHODID 16
+#define ACER_WMID_GET_GAMING_FAN_SPEED_METHODID 17
 #define ACER_WMID_SET_GAMING_MISC_SETTING_METHODID 22
 #define ACER_WMID_GET_GAMING_MISC_SETTING_METHODID 23
=20
@@ -79,6 +84,12 @@ MODULE_LICENSE("GPL");
 #define ACER_GAMING_FAN_BEHAVIOR_ID_MASK GENMASK_ULL(15, 0)
 #define ACER_GAMING_FAN_BEHAVIOR_SET_CPU_MODE_MASK GENMASK(17, 16)
 #define ACER_GAMING_FAN_BEHAVIOR_SET_GPU_MODE_MASK GENMASK(23, 22)
+#define ACER_GAMING_FAN_BEHAVIOR_GET_CPU_MODE_MASK GENMASK(9, 8)
+#define ACER_GAMING_FAN_BEHAVIOR_GET_GPU_MODE_MASK GENMASK(15, 14)
+
+#define ACER_GAMING_FAN_SPEED_STATUS_MASK GENMASK_ULL(7, 0)
+#define ACER_GAMING_FAN_SPEED_ID_MASK GENMASK_ULL(7, 0)
+#define ACER_GAMING_FAN_SPEED_VALUE_MASK GENMASK_ULL(15, 8)
=20
 #define ACER_GAMING_MISC_SETTING_STATUS_MASK GENMASK_ULL(7, 0)
 #define ACER_GAMING_MISC_SETTING_INDEX_MASK GENMASK_ULL(7, 0)
@@ -129,6 +140,11 @@ enum acer_wmi_predator_v4_sensor_id {
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
@@ -1653,6 +1674,41 @@ static int WMID_gaming_set_fan_behavior(u16 fan_bit=
map, enum acer_wmi_gaming_fan
 	return 0;
 }
=20
+static int WMID_gaming_get_fan_behavior(u16 fan_bitmap, enum acer_wmi_gam=
ing_fan_mode *mode)
+{
+	acpi_status status;
+	u32 input =3D 0;
+	u64 result;
+	int value;
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
+	/* Theoretically multiple fans can be specified, but this is currently u=
nused */
+	if (fan_bitmap & ACER_GAMING_FAN_BEHAVIOR_CPU) {
+		value =3D FIELD_GET(ACER_GAMING_FAN_BEHAVIOR_GET_CPU_MODE_MASK, result)=
;
+	} else {
+		if (fan_bitmap & ACER_GAMING_FAN_BEHAVIOR_GPU)
+			value =3D FIELD_GET(ACER_GAMING_FAN_BEHAVIOR_GET_GPU_MODE_MASK, result=
);
+		else
+			return -EINVAL;
+	}
+
+	if (value < ACER_WMID_FAN_MODE_AUTO || value > ACER_WMID_FAN_MODE_CUSTOM=
)
+		return -ENXIO;
+
+	*mode =3D value;
+
+	return 0;
+}
+
 static void WMID_gaming_set_fan_mode(enum acer_wmi_gaming_fan_mode mode)
 {
 	u16 fan_bitmap =3D 0;
@@ -1666,6 +1722,55 @@ static void WMID_gaming_set_fan_mode(enum acer_wmi_=
gaming_fan_mode mode)
 	WMID_gaming_set_fan_behavior(fan_bitmap, mode);
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
@@ -2792,6 +2897,16 @@ static const enum acer_wmi_predator_v4_sensor_id ac=
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
@@ -2803,6 +2918,11 @@ static umode_t acer_wmi_hwmon_is_visible(const void=
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
@@ -2810,8 +2930,12 @@ static umode_t acer_wmi_hwmon_is_visible(const void=
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
@@ -2820,6 +2944,9 @@ static int acer_wmi_hwmon_read(struct device *dev, e=
num hwmon_sensor_types type,
 			       u32 attr, int channel, long *val)
 {
 	u64 command =3D ACER_WMID_CMD_GET_PREDATOR_V4_SENSOR_READING;
+	enum acer_wmi_gaming_fan_mode mode;
+	u16 fan_bitmap;
+	u8 fan, speed;
 	u64 result;
 	int ret;
=20
@@ -2845,6 +2972,80 @@ static int acer_wmi_hwmon_read(struct device *dev, =
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
+			ret =3D WMID_gaming_get_fan_behavior(fan_bitmap, &mode);
+			if (ret < 0)
+				return ret;
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
+	enum acer_wmi_gaming_fan_mode mode;
+	u16 fan_bitmap;
+	u8 fan, speed;
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
+			return WMID_gaming_set_fan_behavior(fan_bitmap, mode);
+		default:
+			return -EOPNOTSUPP;
+		}
 	default:
 		return -EOPNOTSUPP;
 	}
@@ -2860,11 +3061,16 @@ static const struct hwmon_channel_info *const acer=
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


