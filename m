Return-Path: <linux-kernel+bounces-800642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F33CB43A0E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 13:28:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 282DB5A4181
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 11:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 513A42FF16C;
	Thu,  4 Sep 2025 11:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="eqXw2K6u"
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A77102FE579;
	Thu,  4 Sep 2025 11:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756985180; cv=none; b=RFjLqlFsZ/gcCvKLgjKfQ1M6kICP57lf/bHna74MR94xPT1H11ljaZZgT0OQ1MwCdmEC/afay0JgWHfDd9uQsZzRmIE71ac6CZnW91BnzyNg1MchwMUTggn7kBoC+gMPI12HggmNJknGOZtO4JfPpv1Qe/eOripbGZM8zbo8i0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756985180; c=relaxed/simple;
	bh=Jo1nt6tasCtJyjGAaPaNsdaYCYDHQr3OpA1cV+TWc0E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LRoeIuIs4J5CvZBhwkMixospjF2YwPW+z3hHOWJJw7YXDA7t2lDGBD3gfKDpaQ51S5jvcCE50ZMdyk7qzUFPYvWuyclvDkHNEkxlGCQBC7OqbRC4o1GZMVQnFExB7bTXZoVTEa/U2wimTvSJcAygokL/nHj+IMRDf/KcfUXUltI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=eqXw2K6u; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 584BQCFa3457475;
	Thu, 4 Sep 2025 06:26:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1756985172;
	bh=/J6HBMjH0Ozeryn1N7swY9fe6jx6vGCta22nNXq7D1o=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=eqXw2K6urSzUUhAux3Ayr4vLgZ2wNPYFdvyPBXIGMFp79MDwJ8Efww4GEcAUd0EPV
	 rpjsVZ8+GXfVd7Td2iNE+C5jPToo6eY5oHJhQk0eeSLyyLNaHVayrK0d2s64FZ9Eis
	 oi1qOoJtfH1HINEveDjD9ZifoPNHMsmOFONLM5NY=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 584BQCRA3772836
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Thu, 4 Sep 2025 06:26:12 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 4
 Sep 2025 06:26:11 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Thu, 4 Sep 2025 06:26:11 -0500
Received: from akashdeep-HP-Z2-Tower-G5-Workstation.dhcp.ti.com (akashdeep-hp-z2-tower-g5-workstation.dhcp.ti.com [10.24.68.177])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 584BPedM3179752;
	Thu, 4 Sep 2025 06:26:07 -0500
From: Akashdeep Kaur <a-kaur@ti.com>
To: <praneeth@ti.com>, <nm@ti.com>, <afd@ti.com>, <vigneshr@ti.com>,
        <d-gole@ti.com>, <u-kumar1@ti.com>, <sebin.francis@ti.com>,
        <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <vishalm@ti.com>
Subject: [PATCH v4 3/4] arm64: dts: ti: k3-pinctrl: Add the remaining macros
Date: Thu, 4 Sep 2025 16:55:37 +0530
Message-ID: <20250904112538.529857-4-a-kaur@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250904112538.529857-1-a-kaur@ti.com>
References: <20250904112538.529857-1-a-kaur@ti.com>
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
Add the missing macros for DeepSleep configuration control referenced
from "Table 14-6172. Description Of The Pad Configuration Register Bits"
in AM625 TRM[0].
Add some DeepSleep macros to provide combinations that can be used
directly in device tree files example PIN_DS_OUTPUT_LOW that
configures pin to be output and also sets its value to 0.

[0] https://www.ti.com/lit/ug/spruiv7b/spruiv7b.pdf

Signed-off-by: Akashdeep Kaur <a-kaur@ti.com>
---
 arch/arm64/boot/dts/ti/k3-pinctrl.h | 47 ++++++++++++++++++++++++++++-
 1 file changed, 46 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/k3-pinctrl.h b/arch/arm64/boot/dts/ti/k3-pinctrl.h
index c0f09be8d3f9..7c5b5783769c 100644
--- a/arch/arm64/boot/dts/ti/k3-pinctrl.h
+++ b/arch/arm64/boot/dts/ti/k3-pinctrl.h
@@ -3,15 +3,20 @@
  * This header provides constants for pinctrl bindings for TI's K3 SoC
  * family.
  *
- * Copyright (C) 2018-2024 Texas Instruments Incorporated - https://www.ti.com/
+ * Copyright (C) 2018-2025 Texas Instruments Incorporated - https://www.ti.com/
  */
 #ifndef DTS_ARM64_TI_K3_PINCTRL_H
 #define DTS_ARM64_TI_K3_PINCTRL_H
 
+#define WKUP_LVL_EN_SHIFT       (7)
+#define WKUP_LVL_POL_SHIFT      (8)
 #define ST_EN_SHIFT		(14)
 #define PULLUDEN_SHIFT		(16)
 #define PULLTYPESEL_SHIFT	(17)
 #define RXACTIVE_SHIFT		(18)
+#define DRV_STR_SHIFT           (19)
+#define ISO_OVERRIDE_EN_SHIFT   (22)
+#define ISO_BYPASS_EN_SHIFT     (23)
 #define DEBOUNCE_SHIFT		(11)
 #define FORCE_DS_EN_SHIFT	(15)
 #define DS_EN_SHIFT		(24)
@@ -19,6 +24,7 @@
 #define DS_OUT_VAL_SHIFT	(26)
 #define DS_PULLUD_EN_SHIFT	(27)
 #define DS_PULLTYPE_SEL_SHIFT	(28)
+#define WKUP_EN_SHIFT           (29)
 
 /* Schmitt trigger configuration */
 #define ST_DISABLE		(0 << ST_EN_SHIFT)
@@ -33,6 +39,29 @@
 #define INPUT_EN		(1 << RXACTIVE_SHIFT)
 #define INPUT_DISABLE		(0 << RXACTIVE_SHIFT)
 
+#define DS_PULL_DISABLE         (1 << DS_PULLUD_EN_SHIFT)
+#define DS_PULL_ENABLE          (0 << DS_PULLUD_EN_SHIFT)
+
+#define DS_PULL_UP              (1 << DS_PULLTYPE_SEL_SHIFT | DS_PULL_ENABLE)
+#define DS_PULL_DOWN            (0 << DS_PULLTYPE_SEL_SHIFT | DS_PULL_ENABLE)
+
+#define DS_STATE_EN             (1 << DS_EN_SHIFT)
+#define DS_STATE_DIS            (0 << DS_EN_SHIFT)
+
+#define DS_INPUT_EN             (1 << DS_OUT_DIS_SHIFT | DS_STATE_EN)
+#define DS_INPUT_DISABLE        (0 << DS_OUT_DIS_SHIFT | DS_STATE_EN)
+
+#define DS_OUT_VALUE_ZERO       (0 << DS_OUT_VAL_SHIFT)
+#define DS_OUT_VALUE_ONE        (1 << DS_OUT_VAL_SHIFT)
+
+/* Configuration to enable wake-up on pin activity */
+#define WKUP_ENABLE             (1 << WKUP_EN_SHIFT)
+#define WKUP_DISABLE            (0 << WKUP_EN_SHIFT)
+#define WKUP_ON_LEVEL           (1 << WKUP_LVL_EN_SHIFT)
+#define WKUP_ON_EDGE            (0 << WKUP_LVL_EN_SHIFT)
+#define WKUP_LEVEL_LOW          (0 << WKUP_LVL_POL_SHIFT)
+#define WKUP_LEVEL_HIGH         (1 << WKUP_LVL_POL_SHIFT)
+
 /* Only these macros are expected be used directly in device tree files */
 #define PIN_OUTPUT		(INPUT_DISABLE | PULL_DISABLE)
 #define PIN_OUTPUT_PULLUP	(INPUT_DISABLE | PULL_UP)
@@ -53,6 +82,10 @@
 #define PIN_DEBOUNCE_CONF5	(5 << DEBOUNCE_SHIFT)
 #define PIN_DEBOUNCE_CONF6	(6 << DEBOUNCE_SHIFT)
 
+#define PIN_DRIVE_STRENGTH_NOMINAL      (0 << DRV_STR_SHIFT)
+#define PIN_DRIVE_STRENGTH_SLOW         (1 << DRV_STR_SHIFT)
+#define PIN_DRIVE_STRENGTH_FAST         (2 << DRV_STR_SHIFT)
+
 #define PIN_DS_FORCE_DISABLE		(0 << FORCE_DS_EN_SHIFT)
 #define PIN_DS_FORCE_ENABLE		(1 << FORCE_DS_EN_SHIFT)
 #define PIN_DS_IO_OVERRIDE_DISABLE	(0 << DS_IO_OVERRIDE_EN_SHIFT)
@@ -65,6 +98,18 @@
 #define PIN_DS_PULLUD_DISABLE		(1 << DS_PULLUD_EN_SHIFT)
 #define PIN_DS_PULL_DOWN		(0 << DS_PULLTYPE_SEL_SHIFT)
 #define PIN_DS_PULL_UP			(1 << DS_PULLTYPE_SEL_SHIFT)
+#define PIN_DS_ISO_BYPASS               (1 << ISO_BYPASS_EN_SHIFT)
+#define PIN_DS_ISO_BYPASS_DISABLE       (0 << ISO_BYPASS_EN_SHIFT)
+
+#define PIN_DS_OUTPUT_LOW               (DS_INPUT_DISABLE | DS_OUT_VALUE_ZERO)
+#define PIN_DS_OUTPUT_HIGH              (DS_INPUT_DISABLE | DS_OUT_VALUE_ONE)
+#define PIN_DS_INPUT                    (DS_INPUT_EN | DS_PULL_DISABLE)
+#define PIN_DS_INPUT_PULLUP             (DS_INPUT_EN | DS_PULL_UP)
+#define PIN_DS_INPUT_PULLDOWN           (DS_INPUT_EN | DS_PULL_DOWN)
+
+#define PIN_WKUP_EN_LEVEL_LOW           (WKUP_ENABLE | WKUP_ON_LEVEL | WKUP_LEVEL_LOW)
+#define PIN_WKUP_EN_LEVEL_HIGH          (WKUP_ENABLE | WKUP_ON_LEVEL | WKUP_LEVEL_HIGH)
+#define PIN_WKUP_EN                     (WKUP_ENABLE | WKUP_ON_EDGE)
 
 /* Default mux configuration for gpio-ranges to use with pinctrl */
 #define PIN_GPIO_RANGE_IOPAD	(PIN_INPUT | 7)
-- 
2.34.1


