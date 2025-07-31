Return-Path: <linux-kernel+bounces-752051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 88181B170CE
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 13:57:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A53BE178878
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 11:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7325D2C15A3;
	Thu, 31 Jul 2025 11:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="JvO7/Uud"
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD1B230BE0;
	Thu, 31 Jul 2025 11:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753963068; cv=none; b=VClw1oia6rqhDK5y1VnoiRcqRt3JE9vBvZfEQk8rXI+m99FT2az0HL0g/YPCvQs2BHfDwR09vdueeznIJ1hy05afz/VcLjaOpSgjkSEzjreW0BG2Yvxx6WYu/HQsjHAPvKA0srcvphwBOnll7XFgE1+UE31JlZCN75ChS+nFo1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753963068; c=relaxed/simple;
	bh=JjGeHLTQkgS/mQ/y/mEXY75fIdzQC288Mg/mpOAt6+g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k9N7VqqmaaOmkkcIROX4dgrfIUyJdEWxyuITZOIvKqQq1socP1nylviWvxjDbsbkvuuHsv2+AOPiekeEnHSUOUpWSyF1V2fIE7e67krocbvEO+4jaOAkcoY8DhvT7LKyzZMS8VdVvDHGT/GasthkNOXP3kWvwWoHoPHv+yPJjqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=JvO7/Uud; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 56VBveGH2995875;
	Thu, 31 Jul 2025 06:57:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1753963060;
	bh=VUhi9nC9YeRWmVZFH255GZ/Sq30z2FhAM7qKgOtn4Os=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=JvO7/Uudh3PTnwhqzoeZ+n/DvUDgZ84gDNEYLD7cJZ9i3ij0edrUyBfyxuzSmw5k5
	 0rEWjxbdT32UrjnUQ4jVfQiVH2eg1gpgJVeTu5OhiqHbgSC/eaykyIpzeFQWAV+PmS
	 Pe8NAvDVYMjMpiXMjV5Bxccsg9LgLuuSv28DMAb8=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
	by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 56VBveRi3301646
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Thu, 31 Jul 2025 06:57:40 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 31
 Jul 2025 06:57:40 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Thu, 31 Jul 2025 06:57:40 -0500
Received: from akashdeep-HP-Z2-Tower-G5-Workstation.dhcp.ti.com (akashdeep-hp-z2-tower-g5-workstation.dhcp.ti.com [10.24.68.177])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 56VBudQR2861468;
	Thu, 31 Jul 2025 06:57:36 -0500
From: Akashdeep Kaur <a-kaur@ti.com>
To: <vigneshr@ti.com>, <praneeth@ti.com>, <nm@ti.com>, <afd@ti.com>,
        <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <vishalm@ti.com>, <sebin.francis@ti.com>
Subject: [PATCH 3/3] arm64: dts: ti: k3-pinctrl: Add the remaining macros
Date: Thu, 31 Jul 2025 17:26:31 +0530
Message-ID: <20250731115631.3263798-4-a-kaur@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250731115631.3263798-1-a-kaur@ti.com>
References: <20250731115631.3263798-1-a-kaur@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Add the drive strength, schmitt trigger enable macros to pinctrl file.
Add the missing macros for deep sleep configuration control.
Reword the existing deep sleep macros to provide combinations that can
directly be used in device tree files.

Signed-off-by: Akashdeep Kaur <a-kaur@ti.com>
---
 arch/arm64/boot/dts/ti/k3-pinctrl.h | 66 +++++++++++++++++++++++------
 1 file changed, 54 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-pinctrl.h b/arch/arm64/boot/dts/ti/k3-pinctrl.h
index c0f09be8d3f9..f26f1fcf6f74 100644
--- a/arch/arm64/boot/dts/ti/k3-pinctrl.h
+++ b/arch/arm64/boot/dts/ti/k3-pinctrl.h
@@ -3,7 +3,7 @@
  * This header provides constants for pinctrl bindings for TI's K3 SoC
  * family.
  *
- * Copyright (C) 2018-2024 Texas Instruments Incorporated - https://www.ti.com/
+ * Copyright (C) 2018-2025 Texas Instruments Incorporated - https://www.ti.com/
  */
 #ifndef DTS_ARM64_TI_K3_PINCTRL_H
 #define DTS_ARM64_TI_K3_PINCTRL_H
@@ -19,6 +19,13 @@
 #define DS_OUT_VAL_SHIFT	(26)
 #define DS_PULLUD_EN_SHIFT	(27)
 #define DS_PULLTYPE_SEL_SHIFT	(28)
+#define WKUP_EN_SHIFT		    (29)
+#define WKUP_LVL_EN_SHIFT	    (7)
+#define WKUP_LVL_POL_SHIFT	    (8)
+#define ST_EN_SHIFT		        (14)
+#define DRV_STR_SHIFT		    (19)
+#define DS_ISO_OVERRIDE_EN_SHIFT (22)
+#define DS_ISO_BYPASS_EN_SHIFT  (23)
 
 /* Schmitt trigger configuration */
 #define ST_DISABLE		(0 << ST_EN_SHIFT)
@@ -33,6 +40,26 @@
 #define INPUT_EN		(1 << RXACTIVE_SHIFT)
 #define INPUT_DISABLE		(0 << RXACTIVE_SHIFT)
 
+#define DS_PULL_DISABLE		(1 << DS_PULLUD_EN_SHIFT)
+#define DS_PULL_ENABLE		(0 << DS_PULLUD_EN_SHIFT)
+
+#define DS_PULL_UP			(1 << DS_PULLTYPE_SEL_SHIFT | DS_PULL_ENABLE)
+#define DS_PULL_DOWN		(0 << DS_PULLTYPE_SEL_SHIFT | DS_PULL_ENABLE)
+
+#define DS_INPUT_EN		    (1 << DS_OUT_DIS_SHIFT)
+#define DS_INPUT_DISABLE    (0 << DS_OUT_DIS_SHIFT)
+
+#define DS_OUT_VALUE_ZERO   (0 << DS_OUT_VAL_SHIFT)
+#define DS_OUT_VALUE_ONE    (1 << DS_OUT_VAL_SHIFT)
+
+#define WKUP_ENABLE		    (1 << WKUP_EN_SHIFT)
+#define WKUP_ON_LEVEL		(1 << WKUP_LVL_EN_SHIFT)
+#define WKUP_ON_EDGE        (0 << WKUP_LVL_EN_SHIFT)
+#define WKUP_LEVEL_LOW      (0 << WKUP_LVL_POL_SHIFT)
+#define WKUP_LEVEL_HIGH		(1 << WKUP_LVL_POL_SHIFT)
+
+#define WKUP_DISABLE        (0 << WKUP_EN_SHIFT)
+
 /* Only these macros are expected be used directly in device tree files */
 #define PIN_OUTPUT		(INPUT_DISABLE | PULL_DISABLE)
 #define PIN_OUTPUT_PULLUP	(INPUT_DISABLE | PULL_UP)
@@ -53,18 +80,33 @@
 #define PIN_DEBOUNCE_CONF5	(5 << DEBOUNCE_SHIFT)
 #define PIN_DEBOUNCE_CONF6	(6 << DEBOUNCE_SHIFT)
 
+#define PIN_DRIVE_STRENGTH_NOMINAL	(0 << DRV_STR_SHIFT)
+#define PIN_DRIVE_STRENGTH_SLOW	    (1 << DRV_STR_SHIFT)
+#define PIN_DRIVE_STRENGTH_FAST	    (2 << DRV_STR_SHIFT)
+
+#define PIN_SCHMITT_TRIGGER_DISABLE	(0 << ST_EN_SHIFT)
+#define PIN_SCHMITT_TRIGGER_ENABLE	(1 << ST_EN_SHIFT)
+
 #define PIN_DS_FORCE_DISABLE		(0 << FORCE_DS_EN_SHIFT)
-#define PIN_DS_FORCE_ENABLE		(1 << FORCE_DS_EN_SHIFT)
-#define PIN_DS_IO_OVERRIDE_DISABLE	(0 << DS_IO_OVERRIDE_EN_SHIFT)
-#define PIN_DS_IO_OVERRIDE_ENABLE	(1 << DS_IO_OVERRIDE_EN_SHIFT)
-#define PIN_DS_OUT_ENABLE		(0 << DS_OUT_DIS_SHIFT)
-#define PIN_DS_OUT_DISABLE		(1 << DS_OUT_DIS_SHIFT)
-#define PIN_DS_OUT_VALUE_ZERO		(0 << DS_OUT_VAL_SHIFT)
-#define PIN_DS_OUT_VALUE_ONE		(1 << DS_OUT_VAL_SHIFT)
-#define PIN_DS_PULLUD_ENABLE		(0 << DS_PULLUD_EN_SHIFT)
-#define PIN_DS_PULLUD_DISABLE		(1 << DS_PULLUD_EN_SHIFT)
-#define PIN_DS_PULL_DOWN		(0 << DS_PULLTYPE_SEL_SHIFT)
-#define PIN_DS_PULL_UP			(1 << DS_PULLTYPE_SEL_SHIFT)
+#define PIN_DS_FORCE_ENABLE		    (1 << FORCE_DS_EN_SHIFT)
+#define PIN_DS_ISO_OVERRIDE_DISABLE	(0 << DS_ISO_OVERRIDE_EN_SHIFT)
+#define PIN_DS_ISO_OVERRIDE	        (1 << DS_ISO_OVERRIDE_EN_SHIFT)
+#define PIN_DS_ISO_BYPASS           (1 << DS_ISO_BYPASS_EN_SHIFT)
+#define PIN_DS_ISO_BYPASS_DISABLE   (0 << DS_ISO_BYPASS_EN_SHIFT)
+
+#define DS_STATE_VAL        (1 << DS_EN_SHIFT)
+#define ACTIVE_STATE_VAL    (0 << DS_EN_SHIFT)
+
+#define PIN_DS_OUTPUT_LOW       (DS_STATE_VAL | DS_INPUT_DISABLE | DS_OUT_VALUE_ZERO)
+#define PIN_DS_OUTPUT_HIGH      (DS_STATE_VAL | DS_INPUT_DISABLE | DS_OUT_VALUE_ONE)
+#define PIN_DS_INPUT            (DS_STATE_VAL | DS_INPUT_EN | DS_PULL_DISABLE)
+#define PIN_DS_INPUT_PULLUP	    (DS_STATE_VAL | DS_INPUT_EN | DS_PULL_UP)
+#define PIN_DS_INPUT_PULLDOWN   (DS_STATE_VAL | DS_INPUT_EN | DS_PULL_DOWN)
+
+#define WKUP_EN_EDGE		(WKUP_ENABLE | WKUP_ON_EDGE)
+#define WKUP_EN_LEVEL_LOW	(WKUP_ENABLE | WKUP_ON_LEVEL | WKUP_LEVEL_LOW)
+#define WKUP_EN_LEVEL_HIGH	(WKUP_ENABLE | WKUP_ON_LEVEL | WKUP_LEVEL_HIGH)
+#define WKUP_EN		        WKUP_EN_EDGE
 
 /* Default mux configuration for gpio-ranges to use with pinctrl */
 #define PIN_GPIO_RANGE_IOPAD	(PIN_INPUT | 7)
-- 
2.34.1


