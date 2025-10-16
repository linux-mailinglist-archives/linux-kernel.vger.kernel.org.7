Return-Path: <linux-kernel+bounces-856751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 294F8BE4F69
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 20:00:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1061C5E3905
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 18:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C31FD3346AC;
	Thu, 16 Oct 2025 18:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="Q4iVrJfi"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76ADF10E3;
	Thu, 16 Oct 2025 18:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760637621; cv=none; b=YYZ6Z5d/mp/gJ9wam8FjjK/ZL54oj6lrWglJmqrQRxD41NPNtPqQ5aPKrtpmW/0WK1CuV+OzgQ60FA77TIGrq2PUX91g/RZcnr3q92+2iTK9W/5/8Sv/bOKFwn9n5hzBrn8hdDwqNIQ3gPkR62AlC9CjcD2/NhcWahvNp+jV3/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760637621; c=relaxed/simple;
	bh=3Gx3Igq+14hnHIf24ojm129hmEAMfuPZHAdEmjS+1G0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dtPYFk2Gz27bnuGofa+n8r+32R9DBmo2UNdvJ6bYMy5GeEq+LQsXpBvKq4iDZ285FpA79lyS93GXXKR+0PalZAQC3fxWaTo/0B0nHXY6n1KDjdzWw5djENLxTqo3/UZXdNojCY0L59GXvmKaFmz6xp3HY2pcxSXAJg6Yv7fefzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=Q4iVrJfi; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1760637616; x=1761242416; i=w_armin@gmx.de;
	bh=tmVbdxRvaSYbG130/KL3h85kTDGC1+fez6ZtkMzf5pM=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Q4iVrJfilQ2SWlRh/yi/T5/MjTmUQoWB/WL19geq8H1L586/wZHojLG/0NJOqfij
	 MUcCx4wLvFlMBcJRpA5UApuv/EH/CJVHGBnM6OPs1vHCyn1lw8chHis7/X1Qrw0E+
	 k0n8SDt+plS6WMZ24pDrE6RdoCaLSTdKELpVqmgqQdZr59W1gUVS4aXs8A+r4E5+8
	 WEacn3NlKqOl29GJnSVatfUV+RCMMGaZmT5aznFOmN5h1wc3CHOqiZ9q94lri7OVK
	 VGQireq9VJMv6IPW6uQXkkLM3RJEdtp29hkU/7/thNAQ/rnkJ09UnwVhIY5A390YR
	 7dMEcs4ZRX8i3kP+4g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.fritz.box ([93.202.247.91]) by mail.gmx.net
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MA7GS-1v3NSU1MvC-00FtOL; Thu, 16 Oct 2025 20:00:16 +0200
From: Armin Wolf <W_Armin@gmx.de>
To: jlee@suse.com,
	basak.sb2006@gmail.com,
	faiz.faadhillah@gmail.com,
	rayanmargham4@gmail.com
Cc: kuurtb@gmail.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/4] platform/x86: acer-wmi: Fix setting of fan behavior
Date: Thu, 16 Oct 2025 20:00:05 +0200
Message-Id: <20251016180008.465593-2-W_Armin@gmx.de>
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
X-Provags-ID: V03:K1:tUhYaaCn/DO/f8qrps1zW+0UPTjq6KVcw7ajK43pFkmC2vDIteH
 DbKO0Q0H0ghPrO9aDqqzbQv4LEKrki0s7BuwucnopqcCcjtpGiYC67oEyJimGOfSilu2++c
 3U5fjj74vXKTKjJORHRqJxFPb1AtIZZQ69hW1dnoVDBvaH6i+E5X/qIWD/G9/dNMif8OkxH
 wF9w1rTwKqZbklU2X40HQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:DPu97X6nut4=;vQ1na5FDbEa5YP1h27NfVcx/BJi
 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

After studying the linuwu_sense driver
(https://github.com/0x7375646F/Linuwu-Sense) i was able to understand
the meaning of the SetGamingFanBehavior() WMI method:

- the first 16-bit are a bitmap of all fans affected by a fan behavior
  change request.

- the next 8 bits contain four fan mode fields (2-bit), each being
  associated with a bit inside the fan bitmap.

There are three fan modes: auto, turbo and custom.

Use this newfound knowledge to fix the turbo fan handling by setting
the correct bits before calling SetGamingFanBehavior(). Also check
the result of the WMI method call and return an error should the ACPI
firmware signal failure.

Reviewed-by: Kurt Borja <kuurtb@gmail.com>
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/platform/x86/acer-wmi.c | 73 +++++++++++++++++++++++----------
 1 file changed, 51 insertions(+), 22 deletions(-)

diff --git a/drivers/platform/x86/acer-wmi.c b/drivers/platform/x86/acer-w=
mi.c
index 13eb22b35aa8..6fdfb1d0001f 100644
=2D-- a/drivers/platform/x86/acer-wmi.c
+++ b/drivers/platform/x86/acer-wmi.c
@@ -68,10 +68,18 @@ MODULE_LICENSE("GPL");
 #define ACER_WMID_SET_GAMING_LED_METHODID 2
 #define ACER_WMID_GET_GAMING_LED_METHODID 4
 #define ACER_WMID_GET_GAMING_SYS_INFO_METHODID 5
-#define ACER_WMID_SET_GAMING_FAN_BEHAVIOR 14
+#define ACER_WMID_SET_GAMING_FAN_BEHAVIOR_METHODID 14
 #define ACER_WMID_SET_GAMING_MISC_SETTING_METHODID 22
 #define ACER_WMID_GET_GAMING_MISC_SETTING_METHODID 23
=20
+#define ACER_GAMING_FAN_BEHAVIOR_CPU BIT(0)
+#define ACER_GAMING_FAN_BEHAVIOR_GPU BIT(3)
+
+#define ACER_GAMING_FAN_BEHAVIOR_STATUS_MASK GENMASK_ULL(7, 0)
+#define ACER_GAMING_FAN_BEHAVIOR_ID_MASK GENMASK_ULL(15, 0)
+#define ACER_GAMING_FAN_BEHAVIOR_SET_CPU_MODE_MASK GENMASK(17, 16)
+#define ACER_GAMING_FAN_BEHAVIOR_SET_GPU_MODE_MASK GENMASK(23, 22)
+
 #define ACER_GAMING_MISC_SETTING_STATUS_MASK GENMASK_ULL(7, 0)
 #define ACER_GAMING_MISC_SETTING_INDEX_MASK GENMASK_ULL(7, 0)
 #define ACER_GAMING_MISC_SETTING_VALUE_MASK GENMASK_ULL(15, 8)
@@ -121,6 +129,12 @@ enum acer_wmi_predator_v4_sensor_id {
 	ACER_WMID_SENSOR_GPU_TEMPERATURE	=3D 0x0A,
 };
=20
+enum acer_wmi_gaming_fan_mode {
+	ACER_WMID_FAN_MODE_AUTO		=3D 0x01,
+	ACER_WMID_FAN_MODE_TURBO	=3D 0x02,
+	ACER_WMID_FAN_MODE_CUSTOM	=3D 0x03,
+};
+
 enum acer_wmi_predator_v4_oc {
 	ACER_WMID_OC_NORMAL			=3D 0x0000,
 	ACER_WMID_OC_TURBO			=3D 0x0002,
@@ -1563,9 +1577,6 @@ static acpi_status WMID_gaming_set_u64(u64 value, u3=
2 cap)
 	case ACER_CAP_TURBO_LED:
 		method_id =3D ACER_WMID_SET_GAMING_LED_METHODID;
 		break;
-	case ACER_CAP_TURBO_FAN:
-		method_id =3D ACER_WMID_SET_GAMING_FAN_BEHAVIOR;
-		break;
 	default:
 		return AE_BAD_PARAMETER;
 	}
@@ -1616,25 +1627,43 @@ static int WMID_gaming_get_sys_info(u32 command, u=
64 *out)
 	return 0;
 }
=20
-static void WMID_gaming_set_fan_mode(u8 fan_mode)
+static int WMID_gaming_set_fan_behavior(u16 fan_bitmap, enum acer_wmi_gam=
ing_fan_mode mode)
 {
-	/* fan_mode =3D 1 is used for auto, fan_mode =3D 2 used for turbo*/
-	u64 gpu_fan_config1 =3D 0, gpu_fan_config2 =3D 0;
-	int i;
+	acpi_status status;
+	u64 input =3D 0;
+	u64 result;
+
+	input |=3D FIELD_PREP(ACER_GAMING_FAN_BEHAVIOR_ID_MASK, fan_bitmap);
+
+	if (fan_bitmap & ACER_GAMING_FAN_BEHAVIOR_CPU)
+		input |=3D FIELD_PREP(ACER_GAMING_FAN_BEHAVIOR_SET_CPU_MODE_MASK, mode)=
;
+
+	if (fan_bitmap & ACER_GAMING_FAN_BEHAVIOR_GPU)
+		input |=3D FIELD_PREP(ACER_GAMING_FAN_BEHAVIOR_SET_GPU_MODE_MASK, mode)=
;
+
+	status =3D WMI_gaming_execute_u64(ACER_WMID_SET_GAMING_FAN_BEHAVIOR_METH=
ODID, input,
+					&result);
+	if (ACPI_FAILURE(status))
+		return -EIO;
+
+	/* The return status must be zero for the operation to have succeeded */
+	if (FIELD_GET(ACER_GAMING_FAN_BEHAVIOR_STATUS_MASK, result))
+		return -EIO;
+
+	return 0;
+}
+
+static void WMID_gaming_set_fan_mode(enum acer_wmi_gaming_fan_mode mode)
+{
+	u16 fan_bitmap =3D 0;
=20
 	if (quirks->cpu_fans > 0)
-		gpu_fan_config2 |=3D 1;
-	for (i =3D 0; i < (quirks->cpu_fans + quirks->gpu_fans); ++i)
-		gpu_fan_config2 |=3D 1 << (i + 1);
-	for (i =3D 0; i < quirks->gpu_fans; ++i)
-		gpu_fan_config2 |=3D 1 << (i + 3);
-	if (quirks->cpu_fans > 0)
-		gpu_fan_config1 |=3D fan_mode;
-	for (i =3D 0; i < (quirks->cpu_fans + quirks->gpu_fans); ++i)
-		gpu_fan_config1 |=3D fan_mode << (2 * i + 2);
-	for (i =3D 0; i < quirks->gpu_fans; ++i)
-		gpu_fan_config1 |=3D fan_mode << (2 * i + 6);
-	WMID_gaming_set_u64(gpu_fan_config2 | gpu_fan_config1 << 16, ACER_CAP_TU=
RBO_FAN);
+		fan_bitmap |=3D ACER_GAMING_FAN_BEHAVIOR_CPU;
+
+	if (quirks->gpu_fans > 0)
+		fan_bitmap |=3D ACER_GAMING_FAN_BEHAVIOR_GPU;
+
+	WMID_gaming_set_fan_behavior(fan_bitmap, mode);
 }
=20
 static int WMID_gaming_set_misc_setting(enum acer_wmi_gaming_misc_setting=
 setting, u8 value)
@@ -1921,7 +1950,7 @@ static int acer_toggle_turbo(void)
 		WMID_gaming_set_u64(0x1, ACER_CAP_TURBO_LED);
=20
 		/* Set FAN mode to auto */
-		WMID_gaming_set_fan_mode(0x1);
+		WMID_gaming_set_fan_mode(ACER_WMID_FAN_MODE_AUTO);
=20
 		/* Set OC to normal */
 		if (has_cap(ACER_CAP_TURBO_OC)) {
@@ -1935,7 +1964,7 @@ static int acer_toggle_turbo(void)
 		WMID_gaming_set_u64(0x10001, ACER_CAP_TURBO_LED);
=20
 		/* Set FAN mode to turbo */
-		WMID_gaming_set_fan_mode(0x2);
+		WMID_gaming_set_fan_mode(ACER_WMID_FAN_MODE_TURBO);
=20
 		/* Set OC to turbo mode */
 		if (has_cap(ACER_CAP_TURBO_OC)) {
=2D-=20
2.39.5


