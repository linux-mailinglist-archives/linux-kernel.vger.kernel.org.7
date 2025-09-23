Return-Path: <linux-kernel+bounces-829679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB4A7B979DE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 23:48:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAFF91AE079B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 21:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C31A630E0FB;
	Tue, 23 Sep 2025 21:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="sJtstLiV"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39D827A44A;
	Tue, 23 Sep 2025 21:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758664109; cv=none; b=LZne9gHoErOOzHP1uJi0k1ftUqAd9GaSwVXN6FQD1J/Gq1zGPf6JdtbEEKKctx+qXUn4OK2YtztG9CY59gxaOg+Lqx6g4jGkcRfdwbcXDq3R89tKYsJO2oFz2T4xjelT3I5TPjmCzRYv8WxAfKhwt4obhFvmvLbVVpYX1VdDZ1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758664109; c=relaxed/simple;
	bh=0Hko0YjOXc8iSttwyVz9XzJLfxo3AdthaBQwWF2NZSs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Fc7U2vx6psCYoiGC5/uKtPGAac0qbe3BHZ9HdX1GrfSiX98qMac3wQ6XRN4n2NBtd/WsIDiczowYIgxOCHTQiaEb9X8Em37dICZvcil2G1yvJ0I4bmXxvxao+agZXcSh6ja/eS0CSRG+1B866M3l/DQqlyzI9PTd8NmCyciiU60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=sJtstLiV; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1758664103; x=1759268903; i=w_armin@gmx.de;
	bh=ncukTtGDvsvGlLf2pWf1tZEqsvu3zsxVMl4/P0oVMZY=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=sJtstLiVZrg5ClugM2weq7tmLE/o3SCm32rHBES3gHS5TzfiSZ9qqQX6vzCcX8MV
	 aDVGRsjNiaKtwKBiYW6wU+oLV19chJ/49YqnS+3ddNtBlEML6CYv32VuVrdvjB6O6
	 Vabbza/zN86PQf/G/GqMQW7gSKYrAfK04n6BPngsg2BUwEB+7lxvFGNK819DV8HEl
	 eKOxelS0JC973lLThpCFbUz+2V5SjEdDwjHZH8A23rzK7EgKcWarLMS1s1vNxHY6X
	 gGz8tyDlB8pqrSz9lJWJjpw1ZYW9fl5RPHVjZcvsrhM0/yOtt62E/uejM4iP/BNQ3
	 +TCTFy1ubsPzbslYKA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.fritz.box ([93.202.247.91]) by mail.gmx.net
 (mrgmx105 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MfpOT-1uPd4I0YGn-00gnC1; Tue, 23 Sep 2025 23:48:23 +0200
From: Armin Wolf <W_Armin@gmx.de>
To: jlee@suse.com,
	basak.sb2006@gmail.com,
	rayanmargham4@gmail.com
Cc: kuurtb@gmail.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] platform/x86: acer-wmi: Fix setting of fan behavior
Date: Tue, 23 Sep 2025 23:48:11 +0200
Message-Id: <20250923214814.325808-2-W_Armin@gmx.de>
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
X-Provags-ID: V03:K1:9ap26mEFLFLekCxu6Hn4gF8PvLmPzx1y2WqlGhPLep/oUvdlQ7c
 9U7FK0wvYunsNRzVCdOlch4m8LtCGywNf6nULg8kLFTy8xl+LcQKuo3KNvV6sxC8XaZTJUt
 Bue9w+Sg76AA6Ge/cpdQUZBWTTeUfuz1pfFIHuaMK34EpejCIRRdaA+NDVwoWFgJDEfNXUP
 ZYhuMScJiV+aZOtqZmRVA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Xld7y2BjN0k=;QxipzQmU4Rh/w+k8TzpUeRrSTO+
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
 drivers/platform/x86/acer-wmi.c | 76 +++++++++++++++++++++++----------
 1 file changed, 53 insertions(+), 23 deletions(-)

diff --git a/drivers/platform/x86/acer-wmi.c b/drivers/platform/x86/acer-w=
mi.c
index 69336bd778ee..a41555ee8589 100644
=2D-- a/drivers/platform/x86/acer-wmi.c
+++ b/drivers/platform/x86/acer-wmi.c
@@ -68,10 +68,19 @@ MODULE_LICENSE("GPL");
 #define ACER_WMID_SET_GAMING_LED_METHODID 2
 #define ACER_WMID_GET_GAMING_LED_METHODID 4
 #define ACER_WMID_GET_GAMING_SYS_INFO_METHODID 5
-#define ACER_WMID_SET_GAMING_FAN_BEHAVIOR 14
+#define ACER_WMID_SET_GAMING_FAN_BEHAVIOR_METHODID 14
 #define ACER_WMID_SET_GAMING_MISC_SETTING_METHODID 22
 #define ACER_WMID_GET_GAMING_MISC_SETTING_METHODID 23
=20
+#define ACER_GAMING_FAN_BEHAVIOR_ID_MASK GENMASK_ULL(15, 0)
+#define ACER_GAMING_FAN_BEHAVIOR_SET_MODE_MASK GENMASK_ULL(23, 16)
+
+#define ACER_GAMING_FAN_BEHAVIOR_CPU BIT(0)
+#define ACER_GAMING_FAN_BEHAVIOR_GPU BIT(3)
+
+#define ACER_GAMING_FAN_BEHAVIOR_CPU_MODE_MASK GENMASK(1, 0)
+#define ACER_GAMING_FAN_BEHAVIOR_GPU_MODE_MASK GENMASK(7, 6)
+
 #define ACER_GAMING_MISC_SETTING_STATUS_MASK GENMASK_ULL(7, 0)
 #define ACER_GAMING_MISC_SETTING_INDEX_MASK GENMASK_ULL(7, 0)
 #define ACER_GAMING_MISC_SETTING_VALUE_MASK GENMASK_ULL(15, 8)
@@ -121,6 +130,12 @@ enum acer_wmi_predator_v4_sensor_id {
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
@@ -1565,9 +1580,6 @@ static acpi_status WMID_gaming_set_u64(u64 value, u3=
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
@@ -1618,25 +1630,43 @@ static int WMID_gaming_get_sys_info(u32 command, u=
64 *out)
 	return 0;
 }
=20
+static int WMID_gaming_set_fan_behavior(u16 fan_bitmap, u8 mode_bitmap)
+{
+	acpi_status status;
+	u64 input =3D 0;
+	u64 result;
+
+	input |=3D FIELD_PREP(ACER_GAMING_FAN_BEHAVIOR_ID_MASK, fan_bitmap);
+	input |=3D FIELD_PREP(ACER_GAMING_FAN_BEHAVIOR_SET_MODE_MASK, mode_bitma=
p);
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
 static void WMID_gaming_set_fan_mode(u8 fan_mode)
 {
-	/* fan_mode =3D 1 is used for auto, fan_mode =3D 2 used for turbo*/
-	u64 gpu_fan_config1 =3D 0, gpu_fan_config2 =3D 0;
-	int i;
-
-	if (quirks->cpu_fans > 0)
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
+	u16 mode_bitmap =3D 0;
+	u16 fan_bitmap =3D 0;
+
+	if (quirks->cpu_fans > 0) {
+		fan_bitmap |=3D ACER_GAMING_FAN_BEHAVIOR_CPU;
+		mode_bitmap |=3D FIELD_PREP(ACER_GAMING_FAN_BEHAVIOR_CPU_MODE_MASK, fan=
_mode);
+	}
+
+	if (quirks->gpu_fans > 0) {
+		fan_bitmap |=3D ACER_GAMING_FAN_BEHAVIOR_GPU;
+		mode_bitmap |=3D FIELD_PREP(ACER_GAMING_FAN_BEHAVIOR_GPU_MODE_MASK, fan=
_mode);
+	}
+
+	WMID_gaming_set_fan_behavior(fan_bitmap, mode_bitmap);
 }
=20
 static int WMID_gaming_set_misc_setting(enum acer_wmi_gaming_misc_setting=
 setting, u8 value)
@@ -1923,7 +1953,7 @@ static int acer_toggle_turbo(void)
 		WMID_gaming_set_u64(0x1, ACER_CAP_TURBO_LED);
=20
 		/* Set FAN mode to auto */
-		WMID_gaming_set_fan_mode(0x1);
+		WMID_gaming_set_fan_mode(ACER_WMID_FAN_MODE_AUTO);
=20
 		/* Set OC to normal */
 		if (has_cap(ACER_CAP_TURBO_OC)) {
@@ -1937,7 +1967,7 @@ static int acer_toggle_turbo(void)
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


