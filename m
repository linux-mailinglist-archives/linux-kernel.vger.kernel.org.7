Return-Path: <linux-kernel+bounces-829695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9779B97A52
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 23:53:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 632BD7B3686
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 21:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6506311595;
	Tue, 23 Sep 2025 21:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="KRhYAldR"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E1430F549;
	Tue, 23 Sep 2025 21:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758664342; cv=none; b=naew6NKI6fKZ8e8bYsP8ZqQ3kMnLXrR9RUf0wya2UYzYogzhmwNlDddty5py4rC08kLpqlUfd/GBy94g/1JtIodpuNxxEfs04rGgVf5X6fqYxvKj3MtHWrmre411fKA6mEv5tUSEHqoI+ybnnwAdX6YKaoXPAX+ocjIHi5q6V08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758664342; c=relaxed/simple;
	bh=0Hko0YjOXc8iSttwyVz9XzJLfxo3AdthaBQwWF2NZSs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qS5kAATcBcgwgxLPvCgU3dEjPA7WCr/416O+Imqd+cBBVhcnQ4WZ1gA8LjYSQeHvghs2X1wq5nxrmnioBssJsPRluTjDjHKdMyjqc1nZjVN/y6Bz0fYof98sV6rnDAjIuImckEaiXyw5u+j2X2F+Km7MP3rjrRhS5pwgFuCPmtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=KRhYAldR; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1758664334; x=1759269134; i=w_armin@gmx.de;
	bh=ncukTtGDvsvGlLf2pWf1tZEqsvu3zsxVMl4/P0oVMZY=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=KRhYAldRwC2Rpk6RIyJ/6oTu807u80AIrIgsKEWSV+Rn0075rCuZtTxPHGOcV1NR
	 63JjJ5DQRrU1ddFg89ObTP0JzJv2h4otIGayYQpjHoJ6rDTnF1S9oVZqvRKfcDJeZ
	 NfP+Qq/33UW8GlcEU4g8GvntaiTHeYoo/2UyE56eWG/mFVT11ghZaGAGEJyyRFWNl
	 n6wfXxelzLErx0EoRuKFIYcMI/7XgcWc91iUmLbGMaTCTxGqa3XYeNTDMREVjN2So
	 JuCgjrFIvAjDqHKxK9AEdxV0QmWHH7tabeogQHgWc6g4IE+t1VXL20IfGiAFHGAbZ
	 Zcgu/LOhvlKUoYkLFw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.fritz.box ([93.202.247.91]) by mail.gmx.net
 (mrgmx105 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MwwZX-1u7YAv1TYp-00xthq; Tue, 23 Sep 2025 23:52:14 +0200
From: Armin Wolf <W_Armin@gmx.de>
To: jlee@suse.com,
	basak.sb2006@gmail.com,
	rayanmargham4@gmail.com
Cc: kuurtb@gmail.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/4] platform/x86: acer-wmi: Fix setting of fan behavior
Date: Tue, 23 Sep 2025 23:52:02 +0200
Message-Id: <20250923215205.326367-2-W_Armin@gmx.de>
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
X-Provags-ID: V03:K1:X9l5qCZHsWbKs7qf/EpWM1DNJMEghpkhL7wIOGYnspFSsIxrM/o
 xRhoWBtI8dlDIj+v/CPh6di2UEoRH6V39wgsoamzTtMqttAxMrUUFMv/rqrJjBgTrZCP+02
 5XZu71X+wfzNPySmgUoMdcDH31G/Vhro9tgHs4BvrtV+Tdo0r88pda+iZRwve7sdMAaX01w
 jBnaGXw7RO1FStlxcRJNA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:qBj0x4AvfGY=;Oc+h/QrKZd1EUvssuOMYcadDwyu
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


