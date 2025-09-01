Return-Path: <linux-kernel+bounces-795118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D989FB3ED04
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 19:08:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40B72188EC77
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 17:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86CE5324B13;
	Mon,  1 Sep 2025 17:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nJrPgVs6"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D9D0320A3B;
	Mon,  1 Sep 2025 17:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756746488; cv=none; b=a4u7NvKJnHk3g43mThBDtd7NAWPFiyB3OVYlv6RGUgb1u+yquxF82Ev9N1D1y0JpY2DFxkm9Af4rRV5Mn8zOG/TF8dN7FDS/bDbY8NK8cpLgi1Iqu/a6ECr0KTqm57+xXwfBd2ezFOXmu+gZwH/vJgIjPPwL16yhBpnKAKQcUU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756746488; c=relaxed/simple;
	bh=eiYRv4PiodXuWUXQ+pwLBEVX4v6XW12+FFD1RQtJ8UI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=s9Tb+J8xSKzza/oIth8itG/thJNFr4rhOcyFQWmZVdGjTIUVBSevpO8anfPUNtZn2a2I0Rw6WmKluW4uzNxu79MnwSn3qW5KCVlad561W+CLblClpomGtwnbFujrlcPVg3/rfx8wcvHB9hebmXoT5k2UNaP8zAaZSkP3RNBI5WA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nJrPgVs6; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-55f6f434c96so2390631e87.2;
        Mon, 01 Sep 2025 10:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756746485; x=1757351285; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s89DomBRAbu/O4LB/Q5nvSr2vris+qA7JlDWb1MLm1A=;
        b=nJrPgVs6HgyAJdGnAzqkcDXTrXAxMHGBXoizEzwJ6eN/oCTqKCuLmiktLfLx3VOVi9
         MeJv65RNjI4KK8hO6+f/row36S7h/KbFYbK7Ba6UiACnOqGZO0e4SsN8kva2GL4MpOql
         bEHCp/uZDFgowaJ7WCSr5nzpG4VN0nIb7Q2wS1Q5XWHsCp1Qmfux1oTsGN9s6QgPt49f
         Q+htgKCw9dWO+rSQR80+T1aXqJqc8L/ji8cdRZnxJB/2wiUy2TyBwkKiwmIyluEg7JQa
         2VmNNyOLQ4juYkAt//kt/yZwugtqrKvGfqoVjqApO2OJKjIW1nPViZatayqW4GD7SWLZ
         VV8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756746485; x=1757351285;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s89DomBRAbu/O4LB/Q5nvSr2vris+qA7JlDWb1MLm1A=;
        b=epn57iavnKE+xHyXwM7FyjGnknM/s7p5xmT85nim/xEYkR61oxCHQ6w1wjyBp2zLmj
         3Il1oNHkoYu+H8rmzRXcldB6YUEUFWMXoDisgT/yjhb4LwX09IwK3IMBJ7+gtV/KfmMg
         D1xDBo2RiaUN4LB+iEnMNxsnGei4a/nvcvtZcZOWeyYuBT203m4sWkt9UVWZ4YB2JY7O
         44TbEAqiTH6deyyaoU/CjzE03t0pGn0QiyxPz8tRCGCgOVQPuT9mh31QnFO3U6Hp0Kue
         xDtMLe+ycg9DOo+lyn/eTSXnyFdkf+l1hb9m0YHpsCTxaI3EK70h7Q/BvAK16oI7OYWd
         sCPg==
X-Forwarded-Encrypted: i=1; AJvYcCVOakz4yoD9uiTFxYOHAqWWIvI92q6gOVMja4GGZJfrcYAPiZ4J6XisWpXrQtDCQVJ8545PsfPRThy/@vger.kernel.org, AJvYcCWvnJza5BDzne1IRPuXuCWsZxq0s6v+ItW89TrnTneeKEs+Qwkduf7aONa1fPZa9rKNLB0l2MuI9w6L@vger.kernel.org, AJvYcCX2l2WqgEqIworXaeay+oZTnTAl/U7xzBwVUok9xRPqN33cULTXMAiSVb0+LlsOPIQVNBkIxA7SyX9ERjZ9@vger.kernel.org
X-Gm-Message-State: AOJu0Ywwyi2qBSYDYM5Fs6PEith66ah7YU+giTOs64rrudb3DAOP3Oew
	DK43Ulhnr5Go9X7Ey2DhbO0aMr3H+AA9f4004kznezr9FIm1iqirxciLjSxBhg==
X-Gm-Gg: ASbGncvhjHh/jv7uYzTlKKxw7eM2ygQ9df+yrv0UvBqzOIHHmbgGZrqSqCGm1UoFwVC
	QWHTjSLOoGXKZUCUW9rNxswlqbyNXtnla3ihdGFIsU5L3VoXTELWl153V4YboBIQUPNBu3a7Rhy
	8tH0EBA0ykyOLKz918xZL0N4ZDu138WwX40HUB4YqR1CFNIR7tn3UtXpx3AfXMUu6S+u34OZTXm
	kwOsRHmbLJoNkgiiNNRB2nUFVadWnK+OCcIpv5KRGFkodjMKuIyDPUkwiQhEmEadd0RfLEZI0Er
	r6fgST8ufBdHKigW7BOW0oi74MWxiWLLOnrQ10aoIbju1xYoNOYMRkXVHueSBrWC5PanEATTsjo
	DAoYOZsScTgDUJwBJkbTU0UFOMYBs76B/jUjR6jjIb/DzIQ==
X-Google-Smtp-Source: AGHT+IG/yxuS8O3l/sMrrVuSFy3tnTN8OMpR5iB/E02xfaAUC6B8ViZk8KLBNLaPjCb8dMC2jYdlzA==
X-Received: by 2002:a05:6512:2513:b0:55f:4016:ad2b with SMTP id 2adb3069b0e04-55f708eae52mr2617302e87.30.1756746484295;
        Mon, 01 Sep 2025 10:08:04 -0700 (PDT)
Received: from tablet.my.domain ([2a00:f44:892:8a37:6b0:21e7:549b:225b])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55f7abf7abesm1137666e87.55.2025.09.01.10.07.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 10:08:03 -0700 (PDT)
From: Artur Weber <aweber.kernel@gmail.com>
Date: Mon, 01 Sep 2025 19:07:09 +0200
Subject: [PATCH RESEND v6 3/9] dt-bindings: clock: brcm,kona-ccu: Add
 BCM21664 and BCM281xx bus clocks
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250901-kona-bus-clock-v6-3-c3ac8215bd4d@gmail.com>
References: <20250901-kona-bus-clock-v6-0-c3ac8215bd4d@gmail.com>
In-Reply-To: <20250901-kona-bus-clock-v6-0-c3ac8215bd4d@gmail.com>
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
 bh=eiYRv4PiodXuWUXQ+pwLBEVX4v6XW12+FFD1RQtJ8UI=;
 b=owEBbQKS/ZANAwAKAbO7+KEToFFoAcsmYgBotdLJNRMOUM0hIcEOyf2oNbtXj/N2vZpO0s10+
 V/X4qGQ0TCJAjMEAAEKAB0WIQTmYwAOrB3szWrSiQ2zu/ihE6BRaAUCaLXSyQAKCRCzu/ihE6BR
 aC5oD/44khMgzlfCuwy3oGb4tNwkbvZRMG+Iy4VKhtZu6y5EFYGKCIrN3RfGTLSMzGtGSIYn+wK
 94wztcJVawVe1dhE/2WbJAE3yn0mS+dsf/4AU5BvYZyjLuzb1Xio6aU+5Nhe52vXnHxHRhbdvh1
 SnHIt+Nj9WW4z+TvtcUiwijFc0RWua/3m3t60e0/+Pl2bRJKseg3N8On0AxnXHPY+YDLwtbLCKL
 /C2n/4JO7RAPLvqLNbdiVwhtbzk4XmAwwJIh31c5bQlx1INe6x/wbE+WZsP8aMry0+KwxJQ/CLv
 NL6hzgu+ykToOVZJgdKIOM+6zPZGyvhX9B7LhRnVJzpRror+TRdiwBGfeGAJK1rtxYLfZdXLQVH
 4AE5qFpH4s6TPd0X8rsAhFeVtDT/0Q3L+AovSB1AOvvUibVIrtXhllp8u8I3DYzc/iua+jlXlOv
 8iv0UABvpf8yfZo7bqIWDBYuLPQOmFNsbqnVnJC4tWhZt9vr0C8cohnbWI65thlFQDDyoSdTwVq
 CWgpc0IsVbl5mQwDnVMJJdWMk4tM8HjUbJjuaBDg9urAoMwBKyTZuqXx5CgMbiufjcxiEit7jpK
 3+t4i+dpbxXTe4b1Jfn0hGg8QI6KhaWuAJJfZTSo4bqmwY/VC3oSqQRCShET964nFMDY0hStZ8C
 iOkUMHahlCgjzUw==
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
2.51.0


