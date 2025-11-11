Return-Path: <linux-kernel+bounces-895781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60E42C4EE45
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 16:58:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8963D189DE22
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 15:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17D5936CDE0;
	Tue, 11 Nov 2025 15:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dp1MyIGy"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5420936C588
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 15:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762876598; cv=none; b=tH5D8BJnEnjgPyk2i2qZGQmcKJ5tYSkStqmqsEtCTIY/tQTBEjdg2eXKdTBWZcon1cKwtszu3lkk/voEBxY7Ue8/7yC21ndBT79u8JjtIVRW5/lDB2XLuHt4iUbS/gvhkXQoFr61YPz/USoyd4tv2kuzVfrqpkkNehQ8Ok+l6mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762876598; c=relaxed/simple;
	bh=zN24KWDJZb1WgQ/Z3lpGNyeeBBk4det6/dpjp/Gy6y0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kM6lgVHAk56NiIVXifmi3ESTQ36MI3Vuc4kgPjnit+5ZMWqvLykV4V7j5X9XDRPTHLTuBdxBhfDlT9iTxe1yj0VFO+fOHDa3IKjySIg58GJK3NvtG/H96qg6FWwWXR9zuDfQo27MhfVGkYw53EI3y1r7zyfaZDN+eH0nwkF8DPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dp1MyIGy; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4775e891b5eso22302125e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 07:56:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762876595; x=1763481395; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7fIZgZpE0U6JBB52ynsnA5QA9drzTFVpt2SE1VH4l3E=;
        b=Dp1MyIGyKy4vdvAztHJrXTK8tBNtkvNU242YXH2GKP7AQYbFOXmLPlZ4c2hyADO7ty
         ACuPJhnmloPnw7K+wmu7/AN2RelrmgjozS2b8S+cvZLGC5zyiCY5+5WBEyterD/ltGsw
         Yv1UQSCDkSPtl1U8uXtH6SAqVDmHiNHWf5Rg0j/USPtiR2/DZ5/JcmJWfCUQ3t82AWmX
         e/NAKtQxXcA/SE5Chn0MgGhE1uaBp26436AY8dStcR49ciXnd/FDgpz9X6eTauab/bge
         NKFYR2+s60/tZDmn69TsVoZAA0+E7wjdW8SW1mpNPYoJelIw/eYKelIs4awNTzXOHYUN
         FXxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762876595; x=1763481395;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7fIZgZpE0U6JBB52ynsnA5QA9drzTFVpt2SE1VH4l3E=;
        b=PzxOxvRde9MtNvuaQNGyQSd7oCqIby86+OfCEAwUo2hT5aYoPO/ti+Xla0n+mX+m7s
         CRkfxJlrH/w4tFzxm9vVQUDQRf0GAvdiiWgla3aVndmtvV0DG/DRP/Cftr+DqTZLbTJl
         fkZsUkqak1ef2MKJJ2IsIy93E6lOlOePUobkVb0dmFr9y0ZockFRtlSRAj+n2bgG0fQt
         1X/C5HaobQQpM9gV0nAYnRJFthZEEGnRScftzno5Bis9nlbqP9wEm/PdwH2bOdu1k1gG
         5fzYDDqGkdfY8QF1hq7lVx1Sxw/oGcJzPLUGb/EgQW+CGjA3DqmNoJGOcMWaYudkSl+1
         G4nw==
X-Forwarded-Encrypted: i=1; AJvYcCVtHjlTl8x5oh1Qy/n+2veZ3drzSVXirFsUBBnjDDPIi3GrqzodMC3JZVoayNNIVNHtJh5zWQgU5NRJDyE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhEuHdJtk5MYJ8C7TZG9/H2Qk5jxMYfg7QBk66gJyoUhZ+inMG
	OcO2RsCNxStGSpMS/mHCrkThFaq1RO2r6nJ/1t7IVDs5mqUX83fWIPsp
X-Gm-Gg: ASbGncs0bFesNuWdwZXNG16CBBjHYJqkoHFF7Juj2rV0vy0jnfJjn5T+kMg4abtXBeF
	Lp/MEBGbWIMRA8AeMdtTth72+Ie9OxSg82v564ImgMQX/1nz0Xims6ErkA2GLDZkDOwkbVdE9r/
	RQkSu2OeTfm7mRZJJJYeeiuGmdXAuH6dsMAGoKgq/pcY1GAfzc8UBuEDKylEDv/J06XfZGs9KH6
	X7W3ZlLzOuaazlhUJrY+Tq48k4qJUrj9s5lq9bDA7MwsGpOZHi03w0OY7bN/+SwZfKRWYpOi3or
	Pi3NYj1hOqQPFjbGxxGs41I/a9VzkC3jUnmD4xnRAnywLgWAvgKCctP5A+fuOF0xtv8zHdNl/55
	BRBiUUyK0CSZbCABA2uL7jjLwAUeoYyt63vEPA9XNBTziuw3KNkpg/PGCpGmNSC1op0Crc3gLOh
	jAlwuRPdndM2coHvICIPd0z3ohx07f3A==
X-Google-Smtp-Source: AGHT+IHJrBECeJh0b66lv3P+gg5fs729mTYmWDJdAcvMZDVj5CNLrnzuFJRU38R+n0e9SoVI8pc0zA==
X-Received: by 2002:a05:600c:46d5:b0:477:3fcf:3651 with SMTP id 5b1f17b1804b1-47773298023mr98870775e9.39.1762876594567;
        Tue, 11 Nov 2025 07:56:34 -0800 (PST)
Received: from Ansuel-XPS24 (93-34-90-37.ip49.fastwebnet.it. [93.34.90.37])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-42abe63e13csm28676766f8f.19.2025.11.11.07.56.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 07:56:34 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Felix Fietkau <nbd@nbd.name>,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Christian Marangi <ansuelsmth@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 4/5] dt-bindings: clock: airoha: Document support for AN7583 clock
Date: Tue, 11 Nov 2025 16:56:20 +0100
Message-ID: <20251111155623.9024-5-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251111155623.9024-1-ansuelsmth@gmail.com>
References: <20251111155623.9024-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document support for Airoha AN7583 clock based on the EN7523
clock schema.

Add additional binding for additional clock and reset lines.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/clock/airoha,en7523-scu.yaml     |  5 +-
 include/dt-bindings/clock/en7523-clk.h        |  3 +
 .../dt-bindings/reset/airoha,an7583-reset.h   | 62 +++++++++++++++++++
 3 files changed, 69 insertions(+), 1 deletion(-)
 create mode 100644 include/dt-bindings/reset/airoha,an7583-reset.h

diff --git a/Documentation/devicetree/bindings/clock/airoha,en7523-scu.yaml b/Documentation/devicetree/bindings/clock/airoha,en7523-scu.yaml
index fe2c5c1baf43..2d53b96356c5 100644
--- a/Documentation/devicetree/bindings/clock/airoha,en7523-scu.yaml
+++ b/Documentation/devicetree/bindings/clock/airoha,en7523-scu.yaml
@@ -30,6 +30,7 @@ properties:
   compatible:
     items:
       - enum:
+          - airoha,an7583-scu
           - airoha,en7523-scu
           - airoha,en7581-scu
 
@@ -69,7 +70,9 @@ allOf:
   - if:
       properties:
         compatible:
-          const: airoha,en7581-scu
+          enum:
+            - airoha,an7583-scu
+            - airoha,en7581-scu
     then:
       properties:
         reg:
diff --git a/include/dt-bindings/clock/en7523-clk.h b/include/dt-bindings/clock/en7523-clk.h
index edfa64045f52..0fbbcb7b1b25 100644
--- a/include/dt-bindings/clock/en7523-clk.h
+++ b/include/dt-bindings/clock/en7523-clk.h
@@ -14,4 +14,7 @@
 
 #define EN7581_CLK_EMMC		8
 
+#define AN7583_CLK_MDIO0	9
+#define AN7583_CLK_MDIO1	10
+
 #endif /* _DT_BINDINGS_CLOCK_AIROHA_EN7523_H_ */
diff --git a/include/dt-bindings/reset/airoha,an7583-reset.h b/include/dt-bindings/reset/airoha,an7583-reset.h
new file mode 100644
index 000000000000..7ff07986f8ba
--- /dev/null
+++ b/include/dt-bindings/reset/airoha,an7583-reset.h
@@ -0,0 +1,62 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (c) 2024 AIROHA Inc
+ * Author: Christian Marangi <ansuelsmth@gmail.com>
+ */
+
+#ifndef __DT_BINDINGS_RESET_CONTROLLER_AIROHA_AN7583_H_
+#define __DT_BINDINGS_RESET_CONTROLLER_AIROHA_AN7583_H_
+
+/* RST_CTRL2 */
+#define AN7583_XPON_PHY_RST		 0
+#define AN7583_GPON_OLT_RST		 1
+#define AN7583_CPU_TIMER2_RST		 2
+#define AN7583_HSUART_RST		 3
+#define AN7583_UART4_RST		 4
+#define AN7583_UART5_RST		 5
+#define AN7583_I2C2_RST			 6
+#define AN7583_XSI_MAC_RST		 7
+#define AN7583_XSI_PHY_RST		 8
+#define AN7583_NPU_RST			 9
+#define AN7583_TRNG_MSTART_RST		10
+#define AN7583_DUAL_HSI0_RST		11
+#define AN7583_DUAL_HSI1_RST		12
+#define AN7583_DUAL_HSI0_MAC_RST	13
+#define AN7583_DUAL_HSI1_MAC_RST	14
+#define AN7583_XPON_XFI_RST             15
+#define AN7583_WDMA_RST			16
+#define AN7583_WOE0_RST			17
+#define AN7583_HSDMA_RST		18
+#define AN7583_TDMA_RST			19
+#define AN7583_EMMC_RST			20
+#define AN7583_SOE_RST			21
+#define AN7583_XFP_MAC_RST		22
+#define AN7583_MDIO0                    23
+#define AN7583_MDIO1                    24
+/* RST_CTRL1 */
+#define AN7583_PCM1_ZSI_ISI_RST		25
+#define AN7583_FE_PDMA_RST		26
+#define AN7583_FE_QDMA_RST		27
+#define AN7583_PCM_SPIWP_RST		28
+#define AN7583_CRYPTO_RST		29
+#define AN7583_TIMER_RST		30
+#define AN7583_PCM1_RST			31
+#define AN7583_UART_RST			32
+#define AN7583_GPIO_RST			33
+#define AN7583_GDMA_RST			34
+#define AN7583_I2C_MASTER_RST		35
+#define AN7583_PCM2_ZSI_ISI_RST		36
+#define AN7583_SFC_RST			37
+#define AN7583_UART2_RST		38
+#define AN7583_GDMP_RST			39
+#define AN7583_FE_RST			40
+#define AN7583_USB_HOST_P0_RST		41
+#define AN7583_GSW_RST			42
+#define AN7583_SFC2_PCM_RST		43
+#define AN7583_PCIE0_RST		44
+#define AN7583_PCIE1_RST		45
+#define AN7583_CPU_TIMER_RST		46
+#define AN7583_PCIE_HB_RST		47
+#define AN7583_XPON_MAC_RST		48
+
+#endif /* __DT_BINDINGS_RESET_CONTROLLER_AIROHA_AN7583_H_ */
-- 
2.51.0


