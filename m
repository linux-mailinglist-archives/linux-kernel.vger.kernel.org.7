Return-Path: <linux-kernel+bounces-787278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 76B0AB373F1
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 22:40:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1C38D4E044B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 20:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAFB72F5329;
	Tue, 26 Aug 2025 20:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="WsrL/x64"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 402E030CD81;
	Tue, 26 Aug 2025 20:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756240823; cv=none; b=NM9gYbPHZACCkBZnIosNAcwbgxBNGN0PgOw4PzRlzCHWN9MFQrMlHcHa+LQemvYnmX6WV7+80pYAs4RNC6+bHbLatckYU7y4Dk5faYj/AnIM8Z5n7lMNRpTPPa0drfYl3FGYxt1EXaaeO5fR3XzB6AOmuy3RD0am+4t9GU3gmcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756240823; c=relaxed/simple;
	bh=GhpOGo4RZ153MgfBnG4eLx6oXoIOzID0mHPt/bMurIs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VxMcCgEXysIDnVp7DvleNlsmV1w2YLP2wsbVZlp36CyFsWlffcPVl0SOLo0tOamCZDsWLFaM4V8uHC47/kWRS/sVw+RYsdE+hiHRHI3BTZQEIFQzUd70GB7VBaYTxEWr+6wk8wKh/lFPJ4lywVeQm4EKYVTfkjv+ek6sHONkwiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=WsrL/x64; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1756240818; x=1756845618; i=w_armin@gmx.de;
	bh=uLyBfhgH5aiYwW97ZclpfkwgeTbWJkasjUGB464pPMs=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=WsrL/x646/SzD1sPlOKDxMnJsdBguW+cTKpVNNLx/Xc1NXb2EMNAf6Y7OhyuMaXz
	 OmvIdpyT2yehdYdc1sMV9agd5B6ZDNq/L5ZdaogHa14ZqFnsQBYRDljTQTbUAMHXR
	 5YzamN+conuZgru02GZ47tqwkLH1diPSNFLOxxxiuC2f0cx6DzQKijAp/zrMCPl/I
	 Om84KB50Yl9ZpK5166z3VxHFQUA3lshvosTdsyV+OjQOZxnzi30rIwbTUFS8EWBC7
	 ETZHqm/B4Lp71NxeV/vMVOD5AHzsbwvEdh4bfSQNCFh8KKfRDbQ4NJmBck7Riqxdf
	 P0Zm7327I4I2aC7Oiw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost.localdomain ([176.2.184.62]) by mail.gmx.net
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1M8ygO-1utk191ZR8-004shm; Tue, 26 Aug 2025 22:40:18 +0200
From: Armin Wolf <W_Armin@gmx.de>
To: jlee@suse.com
Cc: hansg@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lynne@bune.city
Subject: [PATCH] platform/x86: acer-wmi: Stop using ACPI bitmap for platform profile choices
Date: Tue, 26 Aug 2025 22:40:07 +0200
Message-Id: <20250826204007.5088-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:WC/v40Hn5GdgY11w8TArpadD/cT1VePFSl1q+3EgkrcDkAvzVPT
 8HUJ0Plr+m31mij8Uk6lpfJBjxwM9kDZZLBrxVfehT9NsnCu5yyKUgoapykNgwyMpt7+Qto
 9kVYm2kkPtpf7uf9jUlsqjaao+l6gdajmYA1t9UNYqufSmwxOs996eg72hFn9DdR0fXadC1
 Fs6w6UcE/M9uAqJz36fnQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:NWvmMfXZ+kg=;X5b2T1PdCWR8sl6HdJjt7vN/Gwa
 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

It turns out that the platform firmware on some models does not return
valid data when reading the bitmap of supported platform profiles.
This prevents the driver from loading on said models, even when the
platform profile interface itself works.

Fix this by stop using said bitmap until we have figured out how
the OEM software itself detects available platform profiles.

Tested-by: Lynne Megido <lynne@bune.city>
Reported-by: Lynne Megido <lynne@bune.city>
Closes: https://lore.kernel.org/platform-driver-x86/3f56e68f-85df-4c0a-982=
c-43f9d635be38@bune.city/
Fixes: 191e21f1a4c3 ("platform/x86: acer-wmi: use an ACPI bitmap to set th=
e platform profile choices")
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/platform/x86/acer-wmi.c | 71 ++++++---------------------------
 1 file changed, 12 insertions(+), 59 deletions(-)

diff --git a/drivers/platform/x86/acer-wmi.c b/drivers/platform/x86/acer-w=
mi.c
index 69336bd778ee..13eb22b35aa8 100644
=2D-- a/drivers/platform/x86/acer-wmi.c
+++ b/drivers/platform/x86/acer-wmi.c
@@ -129,6 +129,7 @@ enum acer_wmi_predator_v4_oc {
 enum acer_wmi_gaming_misc_setting {
 	ACER_WMID_MISC_SETTING_OC_1			=3D 0x0005,
 	ACER_WMID_MISC_SETTING_OC_2			=3D 0x0007,
+	/* Unreliable on some models */
 	ACER_WMID_MISC_SETTING_SUPPORTED_PROFILES	=3D 0x000A,
 	ACER_WMID_MISC_SETTING_PLATFORM_PROFILE		=3D 0x000B,
 };
@@ -794,9 +795,6 @@ static bool platform_profile_support;
  */
 static int last_non_turbo_profile =3D INT_MIN;
=20
-/* The most performant supported profile */
-static int acer_predator_v4_max_perf;
-
 enum acer_predator_v4_thermal_profile {
 	ACER_PREDATOR_V4_THERMAL_PROFILE_QUIET		=3D 0x00,
 	ACER_PREDATOR_V4_THERMAL_PROFILE_BALANCED	=3D 0x01,
@@ -2014,7 +2012,7 @@ acer_predator_v4_platform_profile_set(struct device =
*dev,
 	if (err)
 		return err;
=20
-	if (tp !=3D acer_predator_v4_max_perf)
+	if (tp !=3D ACER_PREDATOR_V4_THERMAL_PROFILE_TURBO)
 		last_non_turbo_profile =3D tp;
=20
 	return 0;
@@ -2023,55 +2021,14 @@ acer_predator_v4_platform_profile_set(struct devic=
e *dev,
 static int
 acer_predator_v4_platform_profile_probe(void *drvdata, unsigned long *cho=
ices)
 {
-	unsigned long supported_profiles;
-	int err;
+	set_bit(PLATFORM_PROFILE_PERFORMANCE, choices);
+	set_bit(PLATFORM_PROFILE_BALANCED_PERFORMANCE, choices);
+	set_bit(PLATFORM_PROFILE_BALANCED, choices);
+	set_bit(PLATFORM_PROFILE_QUIET, choices);
+	set_bit(PLATFORM_PROFILE_LOW_POWER, choices);
=20
-	err =3D WMID_gaming_get_misc_setting(ACER_WMID_MISC_SETTING_SUPPORTED_PR=
OFILES,
-					   (u8 *)&supported_profiles);
-	if (err)
-		return err;
-
-	/* Iterate through supported profiles in order of increasing performance=
 */
-	if (test_bit(ACER_PREDATOR_V4_THERMAL_PROFILE_ECO, &supported_profiles))=
 {
-		set_bit(PLATFORM_PROFILE_LOW_POWER, choices);
-		acer_predator_v4_max_perf =3D ACER_PREDATOR_V4_THERMAL_PROFILE_ECO;
-		last_non_turbo_profile =3D ACER_PREDATOR_V4_THERMAL_PROFILE_ECO;
-	}
-
-	if (test_bit(ACER_PREDATOR_V4_THERMAL_PROFILE_QUIET, &supported_profiles=
)) {
-		set_bit(PLATFORM_PROFILE_QUIET, choices);
-		acer_predator_v4_max_perf =3D ACER_PREDATOR_V4_THERMAL_PROFILE_QUIET;
-		last_non_turbo_profile =3D ACER_PREDATOR_V4_THERMAL_PROFILE_QUIET;
-	}
-
-	if (test_bit(ACER_PREDATOR_V4_THERMAL_PROFILE_BALANCED, &supported_profi=
les)) {
-		set_bit(PLATFORM_PROFILE_BALANCED, choices);
-		acer_predator_v4_max_perf =3D ACER_PREDATOR_V4_THERMAL_PROFILE_BALANCED=
;
-		last_non_turbo_profile =3D ACER_PREDATOR_V4_THERMAL_PROFILE_BALANCED;
-	}
-
-	if (test_bit(ACER_PREDATOR_V4_THERMAL_PROFILE_PERFORMANCE, &supported_pr=
ofiles)) {
-		set_bit(PLATFORM_PROFILE_BALANCED_PERFORMANCE, choices);
-		acer_predator_v4_max_perf =3D ACER_PREDATOR_V4_THERMAL_PROFILE_PERFORMA=
NCE;
-
-		/* We only use this profile as a fallback option in case no prior
-		 * profile is supported.
-		 */
-		if (last_non_turbo_profile < 0)
-			last_non_turbo_profile =3D ACER_PREDATOR_V4_THERMAL_PROFILE_PERFORMANC=
E;
-	}
-
-	if (test_bit(ACER_PREDATOR_V4_THERMAL_PROFILE_TURBO, &supported_profiles=
)) {
-		set_bit(PLATFORM_PROFILE_PERFORMANCE, choices);
-		acer_predator_v4_max_perf =3D ACER_PREDATOR_V4_THERMAL_PROFILE_TURBO;
-
-		/* We need to handle the hypothetical case where only the turbo profile
-		 * is supported. In this case the turbo toggle will essentially be a
-		 * no-op.
-		 */
-		if (last_non_turbo_profile < 0)
-			last_non_turbo_profile =3D ACER_PREDATOR_V4_THERMAL_PROFILE_TURBO;
-	}
+	/* Set default non-turbo profile */
+	last_non_turbo_profile =3D ACER_PREDATOR_V4_THERMAL_PROFILE_BALANCED;
=20
 	return 0;
 }
@@ -2108,19 +2065,15 @@ static int acer_thermal_profile_change(void)
 		if (cycle_gaming_thermal_profile) {
 			platform_profile_cycle();
 		} else {
-			/* Do nothing if no suitable platform profiles where found */
-			if (last_non_turbo_profile < 0)
-				return 0;
-
 			err =3D WMID_gaming_get_misc_setting(
 				ACER_WMID_MISC_SETTING_PLATFORM_PROFILE, &current_tp);
 			if (err)
 				return err;
=20
-			if (current_tp =3D=3D acer_predator_v4_max_perf)
+			if (current_tp =3D=3D ACER_PREDATOR_V4_THERMAL_PROFILE_TURBO)
 				tp =3D last_non_turbo_profile;
 			else
-				tp =3D acer_predator_v4_max_perf;
+				tp =3D ACER_PREDATOR_V4_THERMAL_PROFILE_TURBO;
=20
 			err =3D WMID_gaming_set_misc_setting(
 				ACER_WMID_MISC_SETTING_PLATFORM_PROFILE, tp);
@@ -2128,7 +2081,7 @@ static int acer_thermal_profile_change(void)
 				return err;
=20
 			/* Store last profile for toggle */
-			if (current_tp !=3D acer_predator_v4_max_perf)
+			if (current_tp !=3D ACER_PREDATOR_V4_THERMAL_PROFILE_TURBO)
 				last_non_turbo_profile =3D current_tp;
=20
 			platform_profile_notify(platform_profile_device);
=2D-=20
2.39.5


