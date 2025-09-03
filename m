Return-Path: <linux-kernel+bounces-799248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C078FB428FA
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 20:48:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5965E1BA51D7
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 18:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E791F31AF2A;
	Wed,  3 Sep 2025 18:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nrn2lb3/"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1594F17A2F6;
	Wed,  3 Sep 2025 18:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756925292; cv=none; b=uO8lzg81xZyhcFpZEGLZqNdlu+GHcWxxRxNfyuhdpU51z4c9aQ00B2BvmOEZlneVJ5GMkDF2obG7nCncfnTYJr45Y9ZB+18W7l7fBfLYoGpnzTDqoGxj9/t/9ie3fv+ZP8+3JOHB9Ub+tn+qnFemDZI9EcrhaE4arr+CSkGjRzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756925292; c=relaxed/simple;
	bh=XMPVwIUY68ac0ldSTejHDT9vUAHy4cmll0lFIAHwuIA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ln3n9Ch7R/oiEInlSYZZLDi7uSX0eq5O9mvxGU4VlgLCBkBGa4/MeMisqu0yZaJExN0PGu88npkq66dk9AW7sG/5U1YvLMeK3dkrHE6zZBCjlNUJtagqW/33g3Zy0oixExGqzX/W/rDdKUv24dvewBAdG5oCqk5MWfPvdrV2KLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nrn2lb3/; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-61caf8fc422so222883a12.2;
        Wed, 03 Sep 2025 11:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756925288; x=1757530088; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pnEq9cYri7Yu6Xes2AYp1EmwTJ9D6Qx1Hfho2heu06I=;
        b=nrn2lb3/kIGRS3x/iR48o/6UD/V4VQfXfKoG5wTPq+uVtO+I9sI/zME9QOwRRjc1TN
         OAK6HYLAC17CdkuZWPkgXWjpArlDrHdP2/yJiyX0IriXb2oPXI1Hf2bK5Tcg+G/aFB+w
         lvugeceDNpL5ETSO1HCr9fJ+au2Y0FkE3EwqRQhUjABhb38HRTIdwjaIAmuFnqY+H1VU
         J16iFGmFsXfMZXF7eEsezuXcEJSPbC1IiGpt2L90WNzZNihzIG0L82Z9IwQhdsHCPjnH
         DQKKoZd+sD0bZ+qI6BNJaZEi7cpK2wkj0///SNvejGNHh+PPi99zxA/HrzHbcsAW501J
         Fdrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756925288; x=1757530088;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pnEq9cYri7Yu6Xes2AYp1EmwTJ9D6Qx1Hfho2heu06I=;
        b=pQ85zc05BXsJxyiorg2j31HI9eATJ3Nh6tTB4l9CmC1LS8FfQBYvym3GCylL98pVmb
         gohTjEToJJcGQpoIijDSNbBZD1/4RC2umI/XWc7hgr2JPEvJZGlhkrcqTeudNe7QF+us
         FkyARHLxrAyhwaFMd0A4zeg602zCpcS9WBVDfPMz4iRC0TfPFc7wdlB7g4tSDIiebF7a
         dVotxZAcfnIR9K70zUoWuBINlCwP7/fyglM30vlsbcAEd7BWLZnRVEayP39EvHeoHCz+
         98o3mLfEg66C/LYT1yskrDwx/sJ4PKluDs1VCz9f4V8OgitxU7GIgDHOUhjWdLTZjtKT
         JaGQ==
X-Forwarded-Encrypted: i=1; AJvYcCV6F/DDlcYi2v+WJb3ividAxqC1UiPuxdxIPrdnxm2UsTpHdY6zG9PJuD2ZL83J0nl8eP0q79klbTI+AWzn@vger.kernel.org, AJvYcCXTICoD/3YLv6bfn7q+3mcSY/ZFrN5TTlWiXlvxFbSOdu5jXEDEYfxcRCKRmSD5seLSRpwSkR9i2NYz5A==@vger.kernel.org
X-Gm-Message-State: AOJu0YyCiqJwQniJFlIPUoiOUyN/Xl/RTeK53llfUXUooBzehJSlPJLh
	yOSsPQ4UhGu6tPn5V5ehARX2veiVYcShOm/Bw2qrchIejNNRvBm3SuaVor33ew==
X-Gm-Gg: ASbGncvQdYlxdeEITaT+hEAgcKSE2lhAgAvRwfJ5T2QCB+opuWaOJ97ORINe9gS0VZk
	2n0Gmta2ItK4Nz9O3ROvpbsIddeDRZoEcQa8gx9kVxrUZI9x71sb3bFaPkpvfl2/ehnv/9+LRcB
	JEw8brvYiD0WOjxRYqV1X5Dn2qW9YnOac0QzLP+x2d5yrOYBftrDxLkI5+hjCYzdbj9gGtv78GM
	wR1K0IEzTfDll+LC6quV75JNy6hIh8lgkIr8sVA149HOQJuRjclEUi+Ukh9i1/uGE8EylwWVAjf
	xD/MoB6Ev+WLXRLiH8SRGntVUjPxK6zEjGRToR2VCidew9gWiDk84XPxNsLG2pY9kKpQt6eN1Wo
	yXw4JRVQzTOvLhlZFjBviXCfRUpLO5evqKgu/2VubcMc=
X-Google-Smtp-Source: AGHT+IHW1e82FTZpcbEFE0hvW5wWmnYWGg38OrG1PB8/7dTy0kCCNgAjX6+Bm7Tz8VrE5BbF3KipFQ==
X-Received: by 2002:a05:6402:504b:b0:618:aed3:38a with SMTP id 4fb4d7f45d1cf-61d26ebbf9fmr13588130a12.31.1756925288153;
        Wed, 03 Sep 2025 11:48:08 -0700 (PDT)
Received: from puma.museclub.art ([2a00:6020:b3ea:9c00:26e7:b56a:5a2d:1d72])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61cfc575b94sm11860457a12.53.2025.09.03.11.48.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 11:48:07 -0700 (PDT)
From: Eugene Shalygin <eugene.shalygin@gmail.com>
To: eugene.shalygin@gmail.com
Cc: Michael Tandy <git@mjt.me.uk>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] hwmon: (asus-ec-sensors) sort declarations
Date: Wed,  3 Sep 2025 20:47:36 +0200
Message-ID: <20250903184753.5876-1-eugene.shalygin@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michael Tandy <git@mjt.me.uk>

Sort all the declarations in the source file. Contributors are asked
o insert new entries keeping alphabetical order, but the existing
ones were not completely sorted.

Signed-off-by: Michael Tandy <git@mjt.me.uk>
Signed-off-by: Eugene Shalygin <eugene.shalygin@gmail.com>
---
 drivers/hwmon/asus-ec-sensors.c | 170 ++++++++++++++++----------------
 1 file changed, 85 insertions(+), 85 deletions(-)

diff --git a/drivers/hwmon/asus-ec-sensors.c b/drivers/hwmon/asus-ec-sensors.c
index 728e21fddae8..ecb058e8755b 100644
--- a/drivers/hwmon/asus-ec-sensors.c
+++ b/drivers/hwmon/asus-ec-sensors.c
@@ -384,6 +384,52 @@ struct ec_board_info {
 	enum board_family family;
 };
 
+static const struct ec_board_info board_info_crosshair_viii_dark_hero = {
+	.sensors = SENSOR_SET_TEMP_CHIPSET_CPU_MB |
+		SENSOR_TEMP_T_SENSOR |
+		SENSOR_TEMP_VRM | SENSOR_SET_TEMP_WATER |
+		SENSOR_FAN_CPU_OPT | SENSOR_FAN_WATER_FLOW |
+		SENSOR_CURR_CPU | SENSOR_IN_CPU_CORE,
+	.mutex_path = ASUS_HW_ACCESS_MUTEX_ASMX,
+	.family = family_amd_500_series,
+};
+
+static const struct ec_board_info board_info_crosshair_viii_hero = {
+	.sensors = SENSOR_SET_TEMP_CHIPSET_CPU_MB |
+		SENSOR_TEMP_T_SENSOR |
+		SENSOR_TEMP_VRM | SENSOR_SET_TEMP_WATER |
+		SENSOR_FAN_CPU_OPT | SENSOR_FAN_CHIPSET |
+		SENSOR_FAN_WATER_FLOW | SENSOR_CURR_CPU |
+		SENSOR_IN_CPU_CORE,
+	.mutex_path = ASUS_HW_ACCESS_MUTEX_ASMX,
+	.family = family_amd_500_series,
+};
+
+static const struct ec_board_info board_info_crosshair_viii_impact = {
+	.sensors = SENSOR_SET_TEMP_CHIPSET_CPU_MB |
+		SENSOR_TEMP_T_SENSOR | SENSOR_TEMP_VRM |
+		SENSOR_FAN_CHIPSET | SENSOR_CURR_CPU |
+		SENSOR_IN_CPU_CORE,
+	.mutex_path = ASUS_HW_ACCESS_MUTEX_ASMX,
+	.family = family_amd_500_series,
+};
+
+static const struct ec_board_info board_info_crosshair_x670e_gene = {
+	.sensors = SENSOR_TEMP_CPU | SENSOR_TEMP_CPU_PACKAGE |
+		SENSOR_TEMP_T_SENSOR |
+		SENSOR_TEMP_MB | SENSOR_TEMP_VRM,
+	.mutex_path = ACPI_GLOBAL_LOCK_PSEUDO_PATH,
+	.family = family_amd_600_series,
+};
+
+static const struct ec_board_info board_info_crosshair_x670e_hero = {
+	.sensors = SENSOR_TEMP_CPU | SENSOR_TEMP_CPU_PACKAGE |
+		SENSOR_TEMP_MB | SENSOR_TEMP_VRM |
+		SENSOR_SET_TEMP_WATER,
+	.mutex_path = ACPI_GLOBAL_LOCK_PSEUDO_PATH,
+	.family = family_amd_600_series,
+};
+
 static const struct ec_board_info board_info_maximus_vi_hero = {
 	.sensors = SENSOR_SET_TEMP_CHIPSET_CPU_MB |
 		SENSOR_TEMP_T_SENSOR |
@@ -393,6 +439,22 @@ static const struct ec_board_info board_info_maximus_vi_hero = {
 	.family = family_intel_300_series,
 };
 
+static const struct ec_board_info board_info_maximus_xi_hero = {
+	.sensors = SENSOR_SET_TEMP_CHIPSET_CPU_MB |
+		SENSOR_TEMP_T_SENSOR |
+		SENSOR_TEMP_VRM | SENSOR_SET_TEMP_WATER |
+		SENSOR_FAN_CPU_OPT | SENSOR_FAN_WATER_FLOW,
+	.mutex_path = ASUS_HW_ACCESS_MUTEX_ASMX,
+	.family = family_intel_300_series,
+};
+
+static const struct ec_board_info board_info_maximus_z690_formula = {
+	.sensors = SENSOR_TEMP_T_SENSOR | SENSOR_TEMP_VRM |
+		SENSOR_SET_TEMP_WATER | SENSOR_FAN_WATER_FLOW,
+	.mutex_path = ASUS_HW_ACCESS_MUTEX_RMTW_ASMX,
+	.family = family_intel_600_series,
+};
+
 static const struct ec_board_info board_info_prime_x470_pro = {
 	.sensors = SENSOR_SET_TEMP_CHIPSET_CPU_MB |
 		SENSOR_TEMP_T_SENSOR | SENSOR_TEMP_VRM |
@@ -417,6 +479,14 @@ static const struct ec_board_info board_info_prime_x670e_pro_wifi = {
 	.family = family_amd_600_series,
 };
 
+static const struct ec_board_info board_info_pro_art_b550_creator = {
+	.sensors = SENSOR_SET_TEMP_CHIPSET_CPU_MB |
+		SENSOR_TEMP_T_SENSOR |
+		SENSOR_FAN_CPU_OPT,
+	.mutex_path = ASUS_HW_ACCESS_MUTEX_ASMX,
+	.family = family_amd_500_series,
+};
+
 static const struct ec_board_info board_info_pro_art_x570_creator_wifi = {
 	.sensors = SENSOR_SET_TEMP_CHIPSET_CPU_MB | SENSOR_TEMP_VRM |
 		SENSOR_TEMP_T_SENSOR | SENSOR_FAN_CPU_OPT |
@@ -441,14 +511,6 @@ static const struct ec_board_info board_info_pro_art_x870E_creator_wifi = {
 	.family = family_amd_800_series,
 };
 
-static const struct ec_board_info board_info_pro_art_b550_creator = {
-	.sensors = SENSOR_SET_TEMP_CHIPSET_CPU_MB |
-		SENSOR_TEMP_T_SENSOR |
-		SENSOR_FAN_CPU_OPT,
-	.mutex_path = ASUS_HW_ACCESS_MUTEX_ASMX,
-	.family = family_amd_500_series,
-};
-
 static const struct ec_board_info board_info_pro_ws_wrx90e_sage_se = {
 	/* Board also has a nct6798 with 7 more fans and temperatures */
 	.sensors = SENSOR_TEMP_CPU_PACKAGE | SENSOR_TEMP_T_SENSOR |
@@ -466,68 +528,6 @@ static const struct ec_board_info board_info_pro_ws_x570_ace = {
 	.family = family_amd_500_series,
 };
 
-static const struct ec_board_info board_info_crosshair_x670e_hero = {
-	.sensors = SENSOR_TEMP_CPU | SENSOR_TEMP_CPU_PACKAGE |
-		SENSOR_TEMP_MB | SENSOR_TEMP_VRM |
-		SENSOR_SET_TEMP_WATER,
-	.mutex_path = ACPI_GLOBAL_LOCK_PSEUDO_PATH,
-	.family = family_amd_600_series,
-};
-
-static const struct ec_board_info board_info_crosshair_x670e_gene = {
-	.sensors = SENSOR_TEMP_CPU | SENSOR_TEMP_CPU_PACKAGE |
-		SENSOR_TEMP_T_SENSOR |
-		SENSOR_TEMP_MB | SENSOR_TEMP_VRM,
-	.mutex_path = ACPI_GLOBAL_LOCK_PSEUDO_PATH,
-	.family = family_amd_600_series,
-};
-
-static const struct ec_board_info board_info_crosshair_viii_dark_hero = {
-	.sensors = SENSOR_SET_TEMP_CHIPSET_CPU_MB |
-		SENSOR_TEMP_T_SENSOR |
-		SENSOR_TEMP_VRM | SENSOR_SET_TEMP_WATER |
-		SENSOR_FAN_CPU_OPT | SENSOR_FAN_WATER_FLOW |
-		SENSOR_CURR_CPU | SENSOR_IN_CPU_CORE,
-	.mutex_path = ASUS_HW_ACCESS_MUTEX_ASMX,
-	.family = family_amd_500_series,
-};
-
-static const struct ec_board_info board_info_crosshair_viii_hero = {
-	.sensors = SENSOR_SET_TEMP_CHIPSET_CPU_MB |
-		SENSOR_TEMP_T_SENSOR |
-		SENSOR_TEMP_VRM | SENSOR_SET_TEMP_WATER |
-		SENSOR_FAN_CPU_OPT | SENSOR_FAN_CHIPSET |
-		SENSOR_FAN_WATER_FLOW | SENSOR_CURR_CPU |
-		SENSOR_IN_CPU_CORE,
-	.mutex_path = ASUS_HW_ACCESS_MUTEX_ASMX,
-	.family = family_amd_500_series,
-};
-
-static const struct ec_board_info board_info_maximus_xi_hero = {
-	.sensors = SENSOR_SET_TEMP_CHIPSET_CPU_MB |
-		SENSOR_TEMP_T_SENSOR |
-		SENSOR_TEMP_VRM | SENSOR_SET_TEMP_WATER |
-		SENSOR_FAN_CPU_OPT | SENSOR_FAN_WATER_FLOW,
-	.mutex_path = ASUS_HW_ACCESS_MUTEX_ASMX,
-	.family = family_intel_300_series,
-};
-
-static const struct ec_board_info board_info_maximus_z690_formula = {
-	.sensors = SENSOR_TEMP_T_SENSOR | SENSOR_TEMP_VRM |
-		SENSOR_SET_TEMP_WATER | SENSOR_FAN_WATER_FLOW,
-	.mutex_path = ASUS_HW_ACCESS_MUTEX_RMTW_ASMX,
-	.family = family_intel_600_series,
-};
-
-static const struct ec_board_info board_info_crosshair_viii_impact = {
-	.sensors = SENSOR_SET_TEMP_CHIPSET_CPU_MB |
-		SENSOR_TEMP_T_SENSOR | SENSOR_TEMP_VRM |
-		SENSOR_FAN_CHIPSET | SENSOR_CURR_CPU |
-		SENSOR_IN_CPU_CORE,
-	.mutex_path = ASUS_HW_ACCESS_MUTEX_ASMX,
-	.family = family_amd_500_series,
-};
-
 static const struct ec_board_info board_info_strix_b550_e_gaming = {
 	.sensors = SENSOR_SET_TEMP_CHIPSET_CPU_MB |
 		SENSOR_TEMP_T_SENSOR | SENSOR_TEMP_VRM |
@@ -645,6 +645,15 @@ static const struct ec_board_info board_info_strix_z790_i_gaming_wifi = {
 	.family = family_intel_700_series,
 };
 
+static const struct ec_board_info board_info_tuf_gaming_x670e_plus = {
+	.sensors = SENSOR_TEMP_CPU | SENSOR_TEMP_CPU_PACKAGE |
+		SENSOR_TEMP_MB | SENSOR_TEMP_VRM |
+		SENSOR_TEMP_WATER_IN | SENSOR_TEMP_WATER_OUT |
+		SENSOR_FAN_CPU_OPT,
+	.mutex_path = ACPI_GLOBAL_LOCK_PSEUDO_PATH,
+	.family = family_amd_600_series,
+};
+
 static const struct ec_board_info board_info_zenith_ii_extreme = {
 	.sensors = SENSOR_SET_TEMP_CHIPSET_CPU_MB | SENSOR_TEMP_T_SENSOR |
 		SENSOR_TEMP_VRM | SENSOR_SET_TEMP_WATER |
@@ -657,15 +666,6 @@ static const struct ec_board_info board_info_zenith_ii_extreme = {
 	.family = family_amd_500_series,
 };
 
-static const struct ec_board_info board_info_tuf_gaming_x670e_plus = {
-	.sensors = SENSOR_TEMP_CPU | SENSOR_TEMP_CPU_PACKAGE |
-		SENSOR_TEMP_MB | SENSOR_TEMP_VRM |
-		SENSOR_TEMP_WATER_IN | SENSOR_TEMP_WATER_OUT |
-		SENSOR_FAN_CPU_OPT,
-	.mutex_path = ACPI_GLOBAL_LOCK_PSEUDO_PATH,
-	.family = family_amd_600_series,
-};
-
 #define DMI_EXACT_MATCH_ASUS_BOARD_NAME(name, board_info)                      \
 	{                                                                      \
 		.matches = {                                                   \
@@ -685,14 +685,14 @@ static const struct dmi_system_id dmi_table[] = {
 					&board_info_prime_x570_pro),
 	DMI_EXACT_MATCH_ASUS_BOARD_NAME("PRIME X670E-PRO WIFI",
 					&board_info_prime_x670e_pro_wifi),
+	DMI_EXACT_MATCH_ASUS_BOARD_NAME("ProArt B550-CREATOR",
+					&board_info_pro_art_b550_creator),
 	DMI_EXACT_MATCH_ASUS_BOARD_NAME("ProArt X570-CREATOR WIFI",
 					&board_info_pro_art_x570_creator_wifi),
 	DMI_EXACT_MATCH_ASUS_BOARD_NAME("ProArt X670E-CREATOR WIFI",
 					&board_info_pro_art_x670E_creator_wifi),
 	DMI_EXACT_MATCH_ASUS_BOARD_NAME("ProArt X870E-CREATOR WIFI",
 					&board_info_pro_art_x870E_creator_wifi),
-	DMI_EXACT_MATCH_ASUS_BOARD_NAME("ProArt B550-CREATOR",
-					&board_info_pro_art_b550_creator),
 	DMI_EXACT_MATCH_ASUS_BOARD_NAME("Pro WS WRX90E-SAGE SE",
 					&board_info_pro_ws_wrx90e_sage_se),
 	DMI_EXACT_MATCH_ASUS_BOARD_NAME("Pro WS X570-ACE",
@@ -705,18 +705,18 @@ static const struct dmi_system_id dmi_table[] = {
 					&board_info_crosshair_viii_hero),
 	DMI_EXACT_MATCH_ASUS_BOARD_NAME("ROG CROSSHAIR VIII HERO (WI-FI)",
 					&board_info_crosshair_viii_hero),
-	DMI_EXACT_MATCH_ASUS_BOARD_NAME("ROG CROSSHAIR X670E HERO",
-					&board_info_crosshair_x670e_hero),
+	DMI_EXACT_MATCH_ASUS_BOARD_NAME("ROG CROSSHAIR VIII IMPACT",
+					&board_info_crosshair_viii_impact),
 	DMI_EXACT_MATCH_ASUS_BOARD_NAME("ROG CROSSHAIR X670E GENE",
 					&board_info_crosshair_x670e_gene),
+	DMI_EXACT_MATCH_ASUS_BOARD_NAME("ROG CROSSHAIR X670E HERO",
+					&board_info_crosshair_x670e_hero),
 	DMI_EXACT_MATCH_ASUS_BOARD_NAME("ROG MAXIMUS XI HERO",
 					&board_info_maximus_xi_hero),
 	DMI_EXACT_MATCH_ASUS_BOARD_NAME("ROG MAXIMUS XI HERO (WI-FI)",
 					&board_info_maximus_xi_hero),
 	DMI_EXACT_MATCH_ASUS_BOARD_NAME("ROG MAXIMUS Z690 FORMULA",
 					&board_info_maximus_z690_formula),
-	DMI_EXACT_MATCH_ASUS_BOARD_NAME("ROG CROSSHAIR VIII IMPACT",
-					&board_info_crosshair_viii_impact),
 	DMI_EXACT_MATCH_ASUS_BOARD_NAME("ROG STRIX B550-E GAMING",
 					&board_info_strix_b550_e_gaming),
 	DMI_EXACT_MATCH_ASUS_BOARD_NAME("ROG STRIX B550-I GAMING",
-- 
2.51.0


