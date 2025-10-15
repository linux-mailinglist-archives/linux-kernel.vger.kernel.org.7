Return-Path: <linux-kernel+bounces-855150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A95A3BE0666
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 21:29:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E2993B636F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 19:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BC8630CDB5;
	Wed, 15 Oct 2025 19:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="a6OAHrPr"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0BE530505D;
	Wed, 15 Oct 2025 19:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760556369; cv=none; b=UQJ10tng/NupSNyU+LivR0ygczSUUNIOwVi61gO6goPtyRPx3s9uPywOw7Qjbv6iSjGgYzdnrE0zKMqdq9lrXGeexGUcxsrzv1uoasG6qnQ6JijvuFSyrGl0w8XTHb5SeQCQuI/qi/yR6cGYbWXMOJJApO1UDWH+8ynUhpFnnhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760556369; c=relaxed/simple;
	bh=hjTh311Qfr8tYVMrGxn32+h/yy8kPpKZFgf0trqOPf8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NUkOjTZjDjhES/MTzb4N9CqVgbjYPVyiTatLx/E68hoDpmDDa1fF/SLVe8TsRp2LJfKoWXOJbw8T7/g35psd9GELurLeZ2fuEhZOJP0vIVcUab0Z7PsJJ5Kv+nnZxN9KJgkgVwehGG6jpMpq4p2+GfDk5KOkaR6c3f1yyPnRDmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=a6OAHrPr; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1760556364; x=1761161164; i=w_armin@gmx.de;
	bh=pWl1cLsmVfQr45d0VYdIOGnSN1VqB+3Sdwaikk//r8Y=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=a6OAHrPrgtt7loMhT00GR3Gzp8JurxbsJZ1DzOdKC7FqtPymwoWGnHzoU+oOPf/D
	 17VV5CQ/NZMdjRt4wWLjV2q9d8QNdYXyw8qjjHabx/kZQFXSsGQcdvx1renpnygBr
	 0Sh4FIG7w0SN9PdUCwN9p/sDV26Z8uGYHwsogOSrRC5PTvYD8M5vZMpkjxBtDvsxB
	 U/KQcB4e/KRBZIOu7cLRURHsYhscGdzdi84lFnrDe0pto2qvgCSzyGGt67eLZk97/
	 Yx6XEy1PNWr3aKhIy7QEiXPc0MxEkcWliNACM9LUdYs3nKD95DTA43nLfEFQ9T8k0
	 YdajiePC27fLQ9X7lA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.fritz.box ([93.202.247.91]) by mail.gmx.net
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1M4s0j-1v7Bal26jP-005vBe; Wed, 15 Oct 2025 21:26:04 +0200
From: Armin Wolf <W_Armin@gmx.de>
To: jlee@suse.com,
	basak.sb2006@gmail.com,
	faiz.faadhillah@gmail.com,
	rayanmargham4@gmail.com
Cc: kuurtb@gmail.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/4] platform/x86: acer-wmi: Fix setting of fan behavior
Date: Wed, 15 Oct 2025 21:25:48 +0200
Message-Id: <20251015192551.321200-2-W_Armin@gmx.de>
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
X-Provags-ID: V03:K1:otBH/UaF05REwDZAX+nHd7tH5r9IDD/lvvba2AJJyWIhE6Qx94A
 jzrqI2/bczR56NUNhjXvcb1YyHMv0GNvImvjmfsOyPFce/yR/wpWmpTdmtbLXMRq3ra1KvP
 UTY9vifbnE/pRn/A8guaevmb5CLn4qHCmGbDjYjOw8PjShw/zNQRVZFl6gRUv88oJXPfi+v
 8GFcqf4GS9Ewe5eOTUYPw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:xQFTwUoQv1g=;Cuv7cRhTczTGKyecSqeoeT2soZG
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
index 13eb22b35aa8..e24233f6e055 100644
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
+	if (fan_bitmap & ACER_GAMING_FAN_BEHAVIOR_CPU)
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


