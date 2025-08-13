Return-Path: <linux-kernel+bounces-766536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3596B247E4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 13:02:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5434A17238B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 11:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5F8C2F6577;
	Wed, 13 Aug 2025 11:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OAOmrdkl"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 253142F745C;
	Wed, 13 Aug 2025 11:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755082828; cv=none; b=CIImbWbNBreCmG6IQwpiRG7rNrqvvWB1eLjOmxDLi61DTmHULR4sOhivMn2EBmscrA5XmeUSXjmDRUOcKgKaUf4qu6yoKJI4UL41uvU6skJToml8YEnCdkXDBPKxytmfuA63e4R5LXiTi+p57Z/v9XYmZkD5Xw4DoQQ/cX84kK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755082828; c=relaxed/simple;
	bh=w1JqEw83SNBTWv0jasiNDsC1/Drx1lV2Z+u0Vqw+j0E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DPR0jfSoMm3JLl2Hjc5yqq0ctXNIMys2JdAhFzgBLykuo1m4c7JXOGJAoV95H7xW8EbazEK4NfkzAp/aDh42TWdaAsqkPZB4HH4GdwOGstMS6nXxzBGcCFV5768oYOm5ynDC9r85tqFFBzUU9lF2Q6FGanAIZY+mooft6utqu9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OAOmrdkl; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-af925cbd73aso1172940766b.1;
        Wed, 13 Aug 2025 04:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755082824; x=1755687624; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yqCY5jTvsISB32aIb6DjyduWoHu1F4uXkTH9VhadKk8=;
        b=OAOmrdklbRRz5qTC21/iwq4HYI39PlVefoMcGBsaXHLnooCUZnEreaLuG/0xFMiVHE
         V6VIOhJo5V1PAFobuVQyEL9tSkiYJjsx26vNH3zbE7BmijhV0aaYOIm/uysotLgFupXL
         JJoEskjObvofXoSckB/VZuzgkFPQw8defRgiIbJ8AC2+ftpTAL23PVNyB8UV/ewSVfjx
         4KZi1Ujs2giGFnBdkz5yid/zkwTxkQfUkWUuezXlqD5Ak0WULPPJJeMopk+ey73VSJIc
         uN4A+iCf0sl5nyIcHn8CN+k04Uw/QNTrocpa9NB5evgLGJ5tSuLGVMuzqRzsboGuim6n
         aWdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755082824; x=1755687624;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yqCY5jTvsISB32aIb6DjyduWoHu1F4uXkTH9VhadKk8=;
        b=ZeNnZ+l/o78RuopSIobTSxzcTIJPm8IZCUZXUT0r5VMRxVOCIljYYn/17ZpOt0wSAp
         x7hz+oznht/pipeH6zCfCS7QtIGxWpMHS9ulB/7NxjxsTmgTlP8hTtHrFv/C/xfIaCRT
         XgDbZAeSflFKE1UBJzSYsL2BGenZk4W28aGHUWgWw3138ge6j/PRF0jr8wpzOHCOV1Rf
         MHuU/y8k4MW6LvkUk0beeXoqhIYdv2dhhRVZc32KfZSkNE4KskmnPWjYpRPyOq3Yd5qU
         TLJHTAkAF5pm5ON5Mc8tfDcVckTyZ2G97+mFtHBMpp1poOYrI/93wFJMrRf7zHKMwLoZ
         GVeA==
X-Forwarded-Encrypted: i=1; AJvYcCVBiT87qANa+sxprqMi8luEs6YcVMc4AOKzoQ40D6UtiFrK5NBmnBV3lIEdfFjWbI0TzTZewYylKmQH@vger.kernel.org, AJvYcCVFP9Ai4NcSo2FwyZs99Nag0nlCsc/ovNJ6uX4TlytLFpTNgETLP6CyQ9QNafrK7SiYXiw/2O72FHFIjtIa@vger.kernel.org, AJvYcCXH9kwGxaLbVn0W39EMSdOO6vGiZ4TJknzPIztWsau3Sbw8j5Mpj+a9W08RArKYG2bxYd+QAksf758v@vger.kernel.org
X-Gm-Message-State: AOJu0YxSsoi4wY3G50karZzrZr4kYNgcA3dCRUcs6UJ7XTQWOqv7lBta
	h7/U8nrGllNx5DugAXZZV2KLhfwCkXCL8Vk6F88wL96U3EIHQjjeh9T/
X-Gm-Gg: ASbGnctetjxrGWafd6eguygm4r/X/Cdu0TAWaSpIDQChDpRswEb2oomP+FxysQDJUoT
	M4r8vZIwG2T1pH5CL8kvdq9GC69II/Xl3aijhUsxAhIkQuQGqn68RILRuSccaVtvEbNTACYxfgZ
	PHFQkUWkKXkcVwry0gRxUc630EXoOkJTZ5DArLy0PwaFLk9PPK2dOtUwIkJzmIUuAFDgVW+pVxi
	3hbBO9fzxaReFnJLMDa6z8ctxaUDcSfCJgpdAaXbzJ+aSsxCEjUrv5fqnZxT0BcXao/b++iL9Zk
	93XeSVonUsjk4vfXPOQzhHeXZUEhm1GNJ/KHPYNYQK+UkzJc3Gp9Fm8NgcztZ4KjPxqemLBweyW
	Z+HhPcvVsResbyMz/t9jrgjIYF4UPd4AVXYai9ty8ccDh2apGiMk5EuygMg38OtwSJtYnl5bbQZ
	4QdOTD
X-Google-Smtp-Source: AGHT+IElWT4jUqN4j0obVzzttcqV5DoHbMR5Zvr5dvyp/5WzfbnIQyveocNCX4Kkaq+kb4xzx0CmVA==
X-Received: by 2002:a17:907:d28:b0:af2:3c43:b104 with SMTP id a640c23a62f3a-afca4ef2446mr269934766b.54.1755082824277;
        Wed, 13 Aug 2025 04:00:24 -0700 (PDT)
Received: from tablet.my.domain (ip-31-0-121-4.multi.internet.cyfrowypolsat.pl. [31.0.121.4])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a0df10asm2377046966b.59.2025.08.13.04.00.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 04:00:23 -0700 (PDT)
From: Artur Weber <aweber.kernel@gmail.com>
Date: Wed, 13 Aug 2025 13:00:09 +0200
Subject: [PATCH v6 3/9] dt-bindings: clock: brcm,kona-ccu: Add BCM21664 and
 BCM281xx bus clocks
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250813-kona-bus-clock-v6-3-f5a63d4920a4@gmail.com>
References: <20250813-kona-bus-clock-v6-0-f5a63d4920a4@gmail.com>
In-Reply-To: <20250813-kona-bus-clock-v6-0-f5a63d4920a4@gmail.com>
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Alex Elder <elder@kernel.org>, 
 Stanislav Jakubek <stano.jakubek@gmail.com>, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 ~postmarketos/upstreaming@lists.sr.ht, linux-arm-kernel@lists.infradead.org, 
 Artur Weber <aweber.kernel@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6917;
 i=aweber.kernel@gmail.com; h=from:subject:message-id;
 bh=w1JqEw83SNBTWv0jasiNDsC1/Drx1lV2Z+u0Vqw+j0E=;
 b=owEBbQKS/ZANAwAKAbO7+KEToFFoAcsmYgBonHA9MGS6etGnq4xmAjxsYkZlZYUzXH7Nmv7nV
 FQdOGJaN3iJAjMEAAEKAB0WIQTmYwAOrB3szWrSiQ2zu/ihE6BRaAUCaJxwPQAKCRCzu/ihE6BR
 aF7ID/kBUfuPKk9hXnlY1z2lxPbC6H7PTSvsVGzn5iWqQpHOSk++ud1l5oU3Q6mx3HqHLdft607
 CsbKDv6NQ2Sz6uG0g5oNdPh8wG4yGF2tExBGPH5ETTGiskhRwj8zfXM7+qTBS6+UcmKl070Ud3Z
 JT+SOIm42qi43mK73zgQqq2Kb5fG+MpG53fHYWflVAmuhGdd+KpiOlRTd5K9N5MuwXqnt12hmD9
 DBuJF084QUfKNsD/GSIfQqlr/QUNu2lMNmpVaDA4vslvEjAXHBTQ5ro18bhZBO9XZj18rB5nqGg
 Vmv1B+kQVT7p/QrQUffT1bSETlezAkdm2Fkudyg03D55jh7gItfajNk3GUTrWjHShfFuVWWLvFF
 6ae734cYB5ij1z0Lf/AjeI4bKguFcy5GMDWs5OW4VkbCLbaN/KHUhfewdNyv0l/1MZ5F+x53Lsm
 +IfbIlbH7CwTs+uobXsKmjnspJ7ijUJLJvI9fBzrxXl3fnUT3SVaHi5JV+UXHThCp5M6P6rZcNq
 DW54TEkPJbkxPGpBi2DjlzUNBU2a0Qz89ntNT9HSA11kwXtOIgQUDSI3eTScNXV3NGo+nU6KHFi
 QjGGbs60hAaUZZqwFmPWqh+7203ASoqZCwaHUx3VFPOwcc/T1NKWq1sif4aZWeMHs0Ffa6YQlc4
 UxAXJ/2vP1kt3cw==
X-Developer-Key: i=aweber.kernel@gmail.com; a=openpgp;
 fpr=E663000EAC1DECCD6AD2890DB3BBF8A113A05168

Add bus clocks corresponding to peripheral clocks currently supported
by the BCM21664 and BCM281xx clock drivers and add the relevant clock
IDs to the dt-bindings headers (bcm21664.h, bcm281xx.h).

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
---
Changes in v4:
- Squash BCM21664 and BCM281xx bus clock bindings commits
---
 .../devicetree/bindings/clock/brcm,kona-ccu.yaml   | 49 ++++++++++++++++++++--
 include/dt-bindings/clock/bcm21664.h               | 13 ++++++
 include/dt-bindings/clock/bcm281xx.h               | 19 +++++++++
 3 files changed, 78 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/brcm,kona-ccu.yaml b/Documentation/devicetree/bindings/clock/brcm,kona-ccu.yaml
index e5656950b3bd0ad44ba47f0ada84b558e71df590..d00dcf916b45904177614c6f19a5df02abdf42f7 100644
--- a/Documentation/devicetree/bindings/clock/brcm,kona-ccu.yaml
+++ b/Documentation/devicetree/bindings/clock/brcm,kona-ccu.yaml
@@ -40,7 +40,7 @@ properties:
 
   clock-output-names:
     minItems: 1
-    maxItems: 10
+    maxItems: 20
 
 required:
   - compatible
@@ -61,6 +61,8 @@ allOf:
             - const: hub_timer
             - const: pmu_bsc
             - const: pmu_bsc_var
+            - const: hub_timer_apb
+            - const: pmu_bsc_apb
   - if:
       properties:
         compatible:
@@ -86,6 +88,13 @@ allOf:
             - const: usb_ic
             - const: hsic2_48m
             - const: hsic2_12m
+            - const: sdio1_ahb
+            - const: sdio2_ahb
+            - const: sdio3_ahb
+            - const: sdio4_ahb
+            - const: usb_ic_ahb
+            - const: hsic2_ahb
+            - const: usb_otg_ahb
   - if:
       properties:
         compatible:
@@ -116,6 +125,16 @@ allOf:
             - const: bsc2
             - const: bsc3
             - const: pwm
+            - const: uartb_apb
+            - const: uartb2_apb
+            - const: uartb3_apb
+            - const: uartb4_apb
+            - const: ssp0_apb
+            - const: ssp2_apb
+            - const: bsc1_apb
+            - const: bsc2_apb
+            - const: bsc3_apb
+            - const: pwm_apb
   - if:
       properties:
         compatible:
@@ -124,7 +143,9 @@ allOf:
     then:
       properties:
         clock-output-names:
-          const: hub_timer
+          items:
+            - const: hub_timer
+            - const: hub_timer_apb
   - if:
       properties:
         compatible:
@@ -142,6 +163,11 @@ allOf:
             - const: sdio2_sleep
             - const: sdio3_sleep
             - const: sdio4_sleep
+            - const: sdio1_ahb
+            - const: sdio2_ahb
+            - const: sdio3_ahb
+            - const: sdio4_ahb
+            - const: usb_otg_ahb
   - if:
       properties:
         compatible:
@@ -158,6 +184,13 @@ allOf:
             - const: bsc2
             - const: bsc3
             - const: bsc4
+            - const: uartb_apb
+            - const: uartb2_apb
+            - const: uartb3_apb
+            - const: bsc1_apb
+            - const: bsc2_apb
+            - const: bsc3_apb
+            - const: bsc4_apb
 
 additionalProperties: false
 
@@ -176,6 +209,16 @@ examples:
                            "bsc1",
                            "bsc2",
                            "bsc3",
-                           "pwm";
+                           "pwm",
+                           "uartb_apb",
+                           "uartb2_apb",
+                           "uartb3_apb",
+                           "uartb4_apb",
+                           "ssp0_apb",
+                           "ssp2_apb",
+                           "bsc1_apb",
+                           "bsc2_apb",
+                           "bsc3_apb",
+                           "pwm_apb";
     };
 ...
diff --git a/include/dt-bindings/clock/bcm21664.h b/include/dt-bindings/clock/bcm21664.h
index 7a380a51848ce100cbf94f9da2b997dbe3a65230..9f3614eb9036b5ce36b610fd7437338655a9cf97 100644
--- a/include/dt-bindings/clock/bcm21664.h
+++ b/include/dt-bindings/clock/bcm21664.h
@@ -25,6 +25,7 @@
 /* aon CCU clock ids */
 
 #define BCM21664_AON_CCU_HUB_TIMER		0
+#define BCM21664_AON_CCU_HUB_TIMER_APB		1
 
 /* master CCU clock ids */
 
@@ -36,6 +37,11 @@
 #define BCM21664_MASTER_CCU_SDIO2_SLEEP		5
 #define BCM21664_MASTER_CCU_SDIO3_SLEEP		6
 #define BCM21664_MASTER_CCU_SDIO4_SLEEP		7
+#define BCM21664_MASTER_CCU_SDIO1_AHB		8
+#define BCM21664_MASTER_CCU_SDIO2_AHB		9
+#define BCM21664_MASTER_CCU_SDIO3_AHB		10
+#define BCM21664_MASTER_CCU_SDIO4_AHB		11
+#define BCM21664_MASTER_CCU_USB_OTG_AHB		12
 
 /* slave CCU clock ids */
 
@@ -46,5 +52,12 @@
 #define BCM21664_SLAVE_CCU_BSC2			4
 #define BCM21664_SLAVE_CCU_BSC3			5
 #define BCM21664_SLAVE_CCU_BSC4			6
+#define BCM21664_SLAVE_CCU_UARTB_APB		7
+#define BCM21664_SLAVE_CCU_UARTB2_APB		8
+#define BCM21664_SLAVE_CCU_UARTB3_APB		9
+#define BCM21664_SLAVE_CCU_BSC1_APB		10
+#define BCM21664_SLAVE_CCU_BSC2_APB		11
+#define BCM21664_SLAVE_CCU_BSC3_APB		12
+#define BCM21664_SLAVE_CCU_BSC4_APB		13
 
 #endif /* _CLOCK_BCM21664_H */
diff --git a/include/dt-bindings/clock/bcm281xx.h b/include/dt-bindings/clock/bcm281xx.h
index 0c7a7e10cb425ddb597392939cb218545a48bf22..8e3ac4ab3e16fb33a82259ccb82287fdfbb749bc 100644
--- a/include/dt-bindings/clock/bcm281xx.h
+++ b/include/dt-bindings/clock/bcm281xx.h
@@ -33,6 +33,8 @@
 #define BCM281XX_AON_CCU_HUB_TIMER		0
 #define BCM281XX_AON_CCU_PMU_BSC		1
 #define BCM281XX_AON_CCU_PMU_BSC_VAR		2
+#define BCM281XX_AON_CCU_HUB_TIMER_APB		3
+#define BCM281XX_AON_CCU_PMU_BSC_APB		4
 
 /* hub CCU clock ids */
 
@@ -47,6 +49,13 @@
 #define BCM281XX_MASTER_CCU_USB_IC		4
 #define BCM281XX_MASTER_CCU_HSIC2_48M		5
 #define BCM281XX_MASTER_CCU_HSIC2_12M		6
+#define BCM281XX_MASTER_CCU_SDIO1_AHB		7
+#define BCM281XX_MASTER_CCU_SDIO2_AHB		8
+#define BCM281XX_MASTER_CCU_SDIO3_AHB		9
+#define BCM281XX_MASTER_CCU_SDIO4_AHB		10
+#define BCM281XX_MASTER_CCU_USB_IC_AHB		11
+#define BCM281XX_MASTER_CCU_HSIC2_AHB		12
+#define BCM281XX_MASTER_CCU_USB_OTG_AHB		13
 
 /* slave CCU clock ids */
 
@@ -60,5 +69,15 @@
 #define BCM281XX_SLAVE_CCU_BSC2			7
 #define BCM281XX_SLAVE_CCU_BSC3			8
 #define BCM281XX_SLAVE_CCU_PWM			9
+#define BCM281XX_SLAVE_CCU_UARTB_APB		10
+#define BCM281XX_SLAVE_CCU_UARTB2_APB		11
+#define BCM281XX_SLAVE_CCU_UARTB3_APB		12
+#define BCM281XX_SLAVE_CCU_UARTB4_APB		13
+#define BCM281XX_SLAVE_CCU_SSP0_APB		14
+#define BCM281XX_SLAVE_CCU_SSP2_APB		15
+#define BCM281XX_SLAVE_CCU_BSC1_APB		16
+#define BCM281XX_SLAVE_CCU_BSC2_APB		17
+#define BCM281XX_SLAVE_CCU_BSC3_APB		18
+#define BCM281XX_SLAVE_CCU_PWM_APB		19
 
 #endif /* _CLOCK_BCM281XX_H */

-- 
2.50.1


