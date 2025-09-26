Return-Path: <linux-kernel+bounces-833622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 428D8BA275F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 07:39:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A5DD1C047CC
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 05:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 630BD278161;
	Fri, 26 Sep 2025 05:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cyh8n6x/"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47BD02773E6
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 05:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758865165; cv=none; b=FDaz8VWqvX9BsQSL8MjLyb6M9c/6u6pbJx16z9N84wMpS/Bw2I+Au58ANzJ+twTWTUs14jgvVuQK8USbDMYbtxS80r1nmXlVuap/Nu3BMVxSoeBiJHSErnfZaZ8Wh3Czw5dcotC+FuUstogJYaeGKOLHLUfSMQZCZ3m0vwNhqE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758865165; c=relaxed/simple;
	bh=Beq3zJ9Yir84ESXbuDFoAJxQDiqZxmnkRmEwjSUBkHg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kWOOFh5S3Z4qlA8WLmR6n1eX+YPWsl60jBXqTNKJmJHwzcoft4y9o9yZHoKnnDLHC2WiSgBxJB+1XdojwuzAsMBCCWWRsQ/GYsAdavYgdktgFmR/AIuPBtg+ac6TmaGV6SsC4hOEvPb1Y/+XIoj8E2Tc50Cu0f7SEam+0X8+vfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cyh8n6x/; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-267f0fe72a1so14687285ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 22:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758865163; x=1759469963; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5pe1j9chdIMcilasNbgcFZSIoZX4HxLtPrmn8vQTZBk=;
        b=cyh8n6x/xiQqoJZ1DU5M+LcnGz7n7fWcs9anzCnhSL0jAO1MaBTHSz2kuwqZdLdZnU
         30d1LDvDiaJ1B4XtGGxlF8McgEdcoMkgPVHn4/lUFSlvh78d5ZUVVMxck5UAqSWA/v0S
         E33S9MYg2gu1fpsVld1TUJznh5WaYVI2EpSGW6EqvNerPbLineyAxG7wVrlUg20MM5+6
         wWVmPLLdMncaKT3UZP/tuFprzS1+lz5Wi6dGdPlHbq1CJOJNX2yPNkqHPPTlwv1PQtOa
         scUZoxDulLwmwhMtrEW06vCO06Qpiq8qG+GmagJs0EbcC69+msUwWEbyDxs0H2/j/ay/
         Pnkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758865163; x=1759469963;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5pe1j9chdIMcilasNbgcFZSIoZX4HxLtPrmn8vQTZBk=;
        b=flq/JbqElUKSyQ4/fl9sIWGDMmWr4Xi5QGxUnvpmgQoVnAWjtcwCS3VdLFGlV1fFe5
         /n6O6SuAZWXRuiacoE3Pm6Qe8lPaiNSjZv2/bmcHn3GdXbrzKxSAvG52YUWY4gnURcPS
         OjyuU8hvAe2/nxSlLZziVkX2gc0AJMeT6NwG99H0N7HDv7E8fEcXL9so4bxaekmt35Nt
         GybJ+eW6ct53boKCX8CrbcdiKjn+nOWf4lNVFEA52zFpakc5tpGHSnNr/Qcm0KH1kiyr
         dvEahjGSQR3IrtUnpYdkgJ0dWyDk7yEBwLCwrrU2SKSXByaMHdTB/DiwpaWMc1FMoZi8
         e5ZA==
X-Forwarded-Encrypted: i=1; AJvYcCVtUfWUHEWXvfey2N8F/RhB5lsfDTDeuC4HxMi/POVTdBTjNTG+Eg3CjiIvYP82sMXbSi9Ix8OUOVojJ2E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwatmBsknoCr/xWT3O/WWkDV+ajBUEuZGTgVKNAv3JnTiLPGvIh
	hbqMSe/1Tomg6qRNcuqFaGebJAz47n/lSACWA4FE/apaIKvMPwwteGzU
X-Gm-Gg: ASbGncsCrc3MbIVAWSc7SppLyoSCvHxxmllfXw45MKQGa5kagQ21rby0/kPcnJhQg7y
	hs2coyUJ5xolsX8FSd4QvRz3re+TNjonmfnu4CPFah9kcy41IwxuLDqXLyMLEZbt8uZf5A6uYaw
	PG+rbKwENNKdSCJ4EWv3cZSVpKjfzT4V0UBoGjILdaikNzdTpO++uxJdDEG/6SOZ6mqKxqKjyri
	hVd20a6znor9HSRlu3xgaRN83ezmMFxmwoY5GIJaGFkwhS8dsQ5sx8HXk76quTHuO/4+X09ZyED
	YNWaR7DuWfcICLLKFcbe3ERqxhtIjSVfsf2ZgyYSZBmQVnq3PSOWrdKGyivD15zXZT20NI3Iw2j
	5G718v2zGlw7Hpt1A+kMfo6mwBTcJ69HS29oAhQ==
X-Google-Smtp-Source: AGHT+IF24GY09FqC/mRcjEGwNAmt8xciN/1UqlJHXn7H6rCSb/JbypwirnWt+vUczaGlevlr9OSdRA==
X-Received: by 2002:a17:902:c102:b0:269:b65a:cbb2 with SMTP id d9443c01a7336-27ed4a46418mr42444775ad.47.1758865163454;
        Thu, 25 Sep 2025 22:39:23 -0700 (PDT)
Received: from HYB-iPCgmhaB8Cy.ad.analog.com ([59.9.235.253])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed66fb07dsm41925025ad.36.2025.09.25.22.39.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 22:39:23 -0700 (PDT)
From: Joan-Na-adi <joan.na.devcode@gmail.com>
X-Google-Original-From: Joan-Na-adi <joan.na@analog.com>
To: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Joan Na <joan.na@analog.com>
Subject: [PATCH 1/3] dt-bindings: regulator: Add MAX77675 binding header
Date: Fri, 26 Sep 2025 14:37:55 +0900
Message-Id: <20250926053757.480086-2-joan.na@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250926053757.480086-1-joan.na@analog.com>
References: <20250926053757.480086-1-joan.na@analog.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Joan Na <joan.na@analog.com>

Add binding header for the MAX77675 PMIC regulator. This header defines
voltage ID and regulator index macros used both in device tree sources
and in the driver implementation.

Signed-off-by: Joan Na <joan.na@analog.com>
---
 .../regulator/maxim,max77675-regulator.h      | 78 +++++++++++++++++++
 1 file changed, 78 insertions(+)
 create mode 100644 include/dt-bindings/regulator/maxim,max77675-regulator.h

diff --git a/include/dt-bindings/regulator/maxim,max77675-regulator.h b/include/dt-bindings/regulator/maxim,max77675-regulator.h
new file mode 100644
index 000000000000..df12cae5e250
--- /dev/null
+++ b/include/dt-bindings/regulator/maxim,max77675-regulator.h
@@ -0,0 +1,78 @@
+/* SPDX-License-Identifier: GPL-2.0-only OR BSD 2-Clause */
+/*
+ * This header provides macros for MAXIM MAX77675 device bindings.
+ *
+ * Copyright (c) 2025, Analog Device inc.
+ * Author: Joan Na <joan.na@analog.com>
+ */
+
+#ifndef _DT_BINDINGS_REGULATOR_MAX77675_
+#define _DT_BINDINGS_REGULATOR_MAX77675_
+
+// Define the voltage limits for 12.5mV and 25mV steps
+#define MAX77675_MIN_UV            500000    // 500 mV
+
+#define MAX77675_MAX_UV_25MV       5500000   // 5.5V in microvolts for 25mV step
+#define MAX77675_MAX_UV_12_5MV     3687500   // 3.6875V in microvolts for 12.5mV step
+
+#define MAX77675_STEP_25MV         25000     // 25 mV
+#define MAX77675_STEP_12_5MV       12500     // 12.5 mV
+
+#define MAX77675_NUM_LEVELS_25MV   201
+#define MAX77675_NUM_LEVELS_12_5MV 255
+
+/* FPS source */
+#define MAX77675_FPS_SLOT_0       0
+#define MAX77675_FPS_SLOT_1       1
+#define MAX77675_FPS_SLOT_2       2
+#define MAX77675_FPS_SLOT_3       3
+#define MAX77675_FPS_NONE         4
+#define MAX77675_FPS_DEF          5
+
+/* nEN Manual Reset Time Configuration (MRT) */
+#define MAX77675_MRT_4S           0x0
+#define MAX77675_MRT_8S           0x1
+#define MAX77675_MRT_12S          0x2
+#define MAX77675_MRT_16S          0x3
+
+/* Internal Pull-Up Disable (PU_DIS) */
+#define MAX77675_PU_EN            0x0
+#define MAX77675_PU_DIS           0x1
+
+/* Bias Low-Power Mode (BIAS_LPM) */
+#define MAX77675_BIAS_NORMAL      0x0
+#define MAX77675_BIAS_LPM_REQ     0x1
+
+/* SIMO Internal Channel Disable (SIMO_INT_CH_DIS) */
+#define MAX77675_SIMO_INT_NORMAL  0x0
+#define MAX77675_SIMO_INT_LDO     0x1
+
+/* nEN Mode Configuration */
+#define MAX77675_EN_PUSH_BUTTON   0x0
+#define MAX77675_EN_SLIDE_SWITCH  0x1
+#define MAX77675_EN_LOGIC         0x2
+#define MAX77675_EN_RESERVED      0x3
+
+/* Debounce Timer Enable (DBEN_nEN) */
+#define MAX77675_DBEN_100US       0x0
+#define MAX77675_DBEN_30MS        0x1
+
+/* Rising slew rate control for SBB0 when ramping up */
+#define MAX77675_SR_2MV_PER_US    0x0  // 2 mV/us
+#define MAX77675_SR_USE_DVS       0x1  // Use DVS slew rate setting (maxim,dvs-slew-rate)
+
+/* Dynamic Voltage Scaling (DVS) Slew Rate */
+#define MAX77675_DVS_SLEW_5MV     0x0  // 5 mV/us
+#define MAX77675_DVS_SLEW_10MV    0x1  // 10 mV/us
+
+/* Latency Mode */
+#define MAX77675_LAT_MODE_HIGH_LATENCY    0  // Low quiescent current, high latency (~100us)
+#define MAX77675_LAT_MODE_LOW_LATENCY     1   // High quiescent current, low latency (~10us)
+
+/* SIMO Buck-Boost Drive Strength (All Channels) */
+#define MAX77675_DRV_SBB_FASTEST      0  // Fastest transition (~0.6 ns)
+#define MAX77675_DRV_SBB_FAST         1  // Faster transition (~1.2 ns)
+#define MAX77675_DRV_SBB_MEDIUM       2  // Moderate transition (~1.8 ns)
+#define MAX77675_DRV_SBB_SLOWEST      3  // Slowest transition (~8 ns)
+
+#endif
--
2.34.1


