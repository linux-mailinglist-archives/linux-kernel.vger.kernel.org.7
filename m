Return-Path: <linux-kernel+bounces-856753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E56DBE4F75
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 20:00:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF4593A91A4
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 18:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EB9A226D0F;
	Thu, 16 Oct 2025 18:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="clscMXLz"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 290FA7464;
	Thu, 16 Oct 2025 18:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760637623; cv=none; b=YguDacq5N8NSDQkQnwSWnqyMTvl1HYHHIbMN5Y4oGrG2+SOM6sL2J/mTsA23Ve5SyGyop6lLGFcjR5SKd2gu4O9XIJrgrnaQzdkvA2LwbAXwA1W9YwQ9afYY9Llf65qo2i5Bx6YYFtDxjPRSQIyiwZL6UD42Eww6SIHkwqsJLT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760637623; c=relaxed/simple;
	bh=JqnGziaHuNL7vOt77CIXeRzvCDvf4lgXO43CIV58ojs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cOVtzolHsZ2jqT/jghHxNQZhui/eqFIyguPxh8pM9MeR9ahNaJ5n2M2wtAY9TT1wAFF1R6WN1786Nx3x1t2QTCWdAC8Z/yO3177jKwdKCxPqylq7RxbqEUs/ksYbhsmKlDOYgzktNaFSJra90P32PipKTs7wJASwzhl2X2swZM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=clscMXLz; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1760637619; x=1761242419; i=w_armin@gmx.de;
	bh=Bqfx/GpBcFgH7naS1WdwE1K0hdtq8LnOOEEMSfMq6Os=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=clscMXLzeVT9a09xxZbsRxh/e/iWAVhURFpfoiTS1SL/6uehsVDrE3/ojArVWYSX
	 t5pHZu7GZf2pcWS1jMR1ORfqnvZu87EHRLlY8n2ujjkTv+u7yUp6MGX7CWHE91EiV
	 ANAYij5kL5EhNlPQ3/ptdHDYh3dMy06Ah+Kj+43ggSlLi9NwxptdLY3pVFNEpZ5hh
	 2yvBFzch7cO11hdQNrLml+B9fuKg7+Ph1fhhzFz0PoTSYYmd08ikoK33GwOTT3Hyj
	 2UTfJHBFA0Tgr+HoUPRV2oMEYuYHLy6vIGn/MeZ9EfwSD2NLJ9gmpytfgT+NkJk7P
	 7IURKadnQFOB5iL8pw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.fritz.box ([93.202.247.91]) by mail.gmx.net
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1Mkpav-1uV9Aa0AZD-00q0fa; Thu, 16 Oct 2025 20:00:19 +0200
From: Armin Wolf <W_Armin@gmx.de>
To: jlee@suse.com,
	basak.sb2006@gmail.com,
	faiz.faadhillah@gmail.com,
	rayanmargham4@gmail.com
Cc: kuurtb@gmail.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/4] platform/x86: acer-wmi: Add fan control support
Date: Thu, 16 Oct 2025 20:00:06 +0200
Message-Id: <20251016180008.465593-3-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251016180008.465593-1-W_Armin@gmx.de>
References: <20251016180008.465593-1-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1xaiYtSWioftcz34FtoE9N9dx0tMSaYust93LPI9rm34KAhRAEl
 gz702F3PEm/jjgfZIHMvWakMFFjTVHJei4QZ2DnnbjgRX4rQRnAJxEQyq7X/norRQppPKOE
 gvMtPgm7eEanqhwOdmVVAezt7Q0PjpZsQ5lysEqrA9JiOe3mwz+scWkeMAnaDkOHcCR2HJY
 KmeI/GVY0wyXjw03p1Tbg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:8I16+4h1wKQ=;U3NV6/SRUcsd8Ax9wfGyGjmqQWD
 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

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
index 6fdfb1d0001f..80b6b79157fd 100644
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


