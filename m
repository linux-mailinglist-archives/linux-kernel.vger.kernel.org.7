Return-Path: <linux-kernel+bounces-731342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28AEAB052D4
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 09:24:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C56A7A20E3
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 07:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0700B27603A;
	Tue, 15 Jul 2025 07:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="yoSKjm9r"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FFB928A73E
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 07:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752563965; cv=none; b=nTI0BouFgcsBRm9rqZHbzlm1GH/d66CBcgVyhSTn8KcS3+BqzlZ8/cJw6BOmK3512DmnT33MeM8rYEb/t27gJgISOD9i1bETmdr3L0fJ177TEDenliLIq1hcDNrh7ZpANfmH84247G5EDYQ9MnF3vnhN8eI8jnTTHOP6WWyJThI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752563965; c=relaxed/simple;
	bh=CtlJuptn1iL4IKBp0RtnlJ33d5bOL7hNwbE9KGg32hU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Tl6At54hetAyQEwL3sLV9KyjrkrwncswHBloCiBqEOjxqUcPP/TteGwbvpDXWXxmCNmgSJS5Y/FxZFKtWshyiLyPFcnHcWPGAjvnmMahbN4y9F20jOtdB4WSNrbbKgW9bCRvYPQ1dXfgm/PZACcnHPJH9HHqPK77gX+sOg10F7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=yoSKjm9r; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-608acb0a27fso7120133a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 00:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1752563960; x=1753168760; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Elg4FLgRXQQbbxiu3aQgurp8VMDU0VAh8zp0Pr6xRrE=;
        b=yoSKjm9rG5eHUY5CrsG+2WoKdkO/9yAOHIcRG2oNYCXrvNoTffAeYAfs76fa+UhNfu
         qx9JaxaIcZW0PWvUbTxkgsRVYVOe8nwGEeEmZ8MPuEQh0yj8ndQEiZlafI5GnrxdlD5g
         oZkhsE88CjRAfV55BpSXccWZ3L5+OVTm92w66L9W4dDEF9+shNhRuk6ZABdqEHXYfScU
         0K59Ykhiaxz6HZECMT4CJlZISsqNQkHawsxLJTiAaYF0lRbk2HlUQzq7b23tzXkzCZfp
         6KOMfkVWaeNeNv6VP3PpFyzB5yWrolp5PtIRcGbzozYfi+u8+Tctt8w4CXfrOtgPEdZJ
         hzyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752563960; x=1753168760;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Elg4FLgRXQQbbxiu3aQgurp8VMDU0VAh8zp0Pr6xRrE=;
        b=G4E4E4/xpUu1hgf9EaqmCaeEbyp6WVs2IPZNEnRVNrS5skMmrGJpqYAOHNsPxA4HaE
         bzCe2fVzmszv5W90mQyayRO5BRaV3KHuq15OxiVhWUzNIoWib2ygjofoH3GvJ0zadH2Q
         QYi/zSE/9rcf/tDIevm4lF6cgvZBG2XQngEy70OM/jNlMnaslk/SHqw6gdRj7xsPywj0
         C2+B2Kiy9zaDsnRrrLJIJ6rYtLSrvQDaWK5e7B7bHwHn/fSxxRvMeBmVEtNha7sGZpII
         GHclH+kohH6FqOmB3JP+6UrP+05H5KlVERQCNcyBctPycxcriaMv8Pw2dy0379qNgEQx
         U8EA==
X-Forwarded-Encrypted: i=1; AJvYcCWgy4eQxafLCNGwsDeH4q3qJvkiDp3h5b36Z2dvrMuA3KKlKzkH8dLU09nmq/L8dp3a/7m9+Ux/27B0H/Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdOJKOmULVyEWzkFyOWRi5LCu28oiwg1BaIoK7YgYLebbClsH/
	aEGkaWP67cujL0ju30jylky2E+FtEywll1mKc2O1nEGlFCcuMkAzCX/968UjGucBq7I=
X-Gm-Gg: ASbGncvYqjKGw9BHk9UDglo84PrcrM3QNX+/XZsV5si9wjhAaZ+g2JT2pQAIuF05sJD
	CYl9uG0m1ZSyr3ux1ASCh3u5YJf9kXoqMQlYFSLDumtgVdihU+sxlrGo8iXySHZy9lz2LIjAaiD
	hopDXChp9vQKzx+uGb8ZNIHrRYPn9St4hYnUcvY7CSnjkLnfX7tTB3eQ/NzAUkR/ceiR0lwcAW7
	jELpx73o49L+wccF52H7gUcdsp54OcasigWRxwZA/qYHOHPfpP5S62tkHi1EvKZPlc5F2t3o/RS
	XWzm/fWxoCnVtSYy3CAGjVSn0J4LPYLxsYeL2yf0HioovJOVXFq4r5TCjSTIZWBmzPlDCWcJpLx
	VuBj8Dgiu/QGroX9HHHLJLzi3c/HAzoyH4kTktaRRfnAu/VNU9lVJm65S
X-Google-Smtp-Source: AGHT+IHwifhTTMNtst73yrck3jQLdM0eBYspiEOGN9kQIJsXdaux1M0kB4WKiXb0CgqiPDeQZyMpZg==
X-Received: by 2002:a05:6402:909:b0:609:9115:60f8 with SMTP id 4fb4d7f45d1cf-611e847f9e0mr12887313a12.21.1752563959742;
        Tue, 15 Jul 2025 00:19:19 -0700 (PDT)
Received: from otso.local (212095005088.public.telering.at. [212.95.5.88])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-611c976fcfcsm6873715a12.66.2025.07.15.00.19.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 00:19:19 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Tue, 15 Jul 2025 09:19:04 +0200
Subject: [PATCH v3 04/11] dt-bindings: clock: qcom: document the Milos
 Camera Clock Controller
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250715-sm7635-clocks-v3-4-18f9faac4984@fairphone.com>
References: <20250715-sm7635-clocks-v3-0-18f9faac4984@fairphone.com>
In-Reply-To: <20250715-sm7635-clocks-v3-0-18f9faac4984@fairphone.com>
To: Bjorn Andersson <andersson@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Luca Weiss <luca.weiss@fairphone.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752563952; l=6948;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=CtlJuptn1iL4IKBp0RtnlJ33d5bOL7hNwbE9KGg32hU=;
 b=AjNYOuq7bNFCFQfTRhkyoPaakLnKf9M0GisflI0r5v7+Jg+IMTRYDS1v3b2d48al7Q2NOGXe2
 XiR6eNijeZHCmwpg3b2hrOO7D8uwmxUKQXsH0xno1xWD5xEOmIolPGp
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

Add bindings documentation for the Milos (e.g. SM7635) Camera Clock Controller.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 .../bindings/clock/qcom,milos-camcc.yaml           |  51 ++++++++
 include/dt-bindings/clock/qcom,milos-camcc.h       | 131 +++++++++++++++++++++
 2 files changed, 182 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/qcom,milos-camcc.yaml b/Documentation/devicetree/bindings/clock/qcom,milos-camcc.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..f63149ecf3e1b98e60dba27093737ec84b66a899
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/qcom,milos-camcc.yaml
@@ -0,0 +1,51 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/qcom,milos-camcc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Camera Clock & Reset Controller on Milos
+
+maintainers:
+  - Luca Weiss <luca.weiss@fairphone.com>
+
+description: |
+  Qualcomm camera clock control module provides the clocks, resets and power
+  domains on Milos.
+
+  See also: include/dt-bindings/clock/qcom,milos-camcc.h
+
+properties:
+  compatible:
+    const: qcom,milos-camcc
+
+  clocks:
+    items:
+      - description: Board XO source
+      - description: Sleep clock source
+      - description: Camera AHB clock from GCC
+
+required:
+  - compatible
+  - clocks
+
+allOf:
+  - $ref: qcom,gcc.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,milos-gcc.h>
+    clock-controller@adb0000 {
+        compatible = "qcom,milos-camcc";
+        reg = <0x0adb0000 0x40000>;
+        clocks = <&bi_tcxo_div2>,
+                 <&sleep_clk>,
+                 <&gcc GCC_CAMERA_AHB_CLK>;
+        #clock-cells = <1>;
+        #reset-cells = <1>;
+        #power-domain-cells = <1>;
+    };
+
+...
diff --git a/include/dt-bindings/clock/qcom,milos-camcc.h b/include/dt-bindings/clock/qcom,milos-camcc.h
new file mode 100644
index 0000000000000000000000000000000000000000..21925dca9a20c9525c3800885e2d1357ab7b4661
--- /dev/null
+++ b/include/dt-bindings/clock/qcom,milos-camcc.h
@@ -0,0 +1,131 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (c) 2023, Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2025, Luca Weiss <luca.weiss@fairphone.com>
+ */
+
+#ifndef _DT_BINDINGS_CLK_QCOM_CAM_CC_MILOS_H
+#define _DT_BINDINGS_CLK_QCOM_CAM_CC_MILOS_H
+
+/* CAM_CC clocks */
+#define CAM_CC_PLL0						0
+#define CAM_CC_PLL0_OUT_EVEN					1
+#define CAM_CC_PLL0_OUT_ODD					2
+#define CAM_CC_PLL1						3
+#define CAM_CC_PLL1_OUT_EVEN					4
+#define CAM_CC_PLL2						5
+#define CAM_CC_PLL2_OUT_EVEN					6
+#define CAM_CC_PLL3						7
+#define CAM_CC_PLL3_OUT_EVEN					8
+#define CAM_CC_PLL4						9
+#define CAM_CC_PLL4_OUT_EVEN					10
+#define CAM_CC_PLL5						11
+#define CAM_CC_PLL5_OUT_EVEN					12
+#define CAM_CC_PLL6						13
+#define CAM_CC_PLL6_OUT_EVEN					14
+#define CAM_CC_BPS_AHB_CLK					15
+#define CAM_CC_BPS_AREG_CLK					16
+#define CAM_CC_BPS_CLK						17
+#define CAM_CC_BPS_CLK_SRC					18
+#define CAM_CC_CAMNOC_ATB_CLK					19
+#define CAM_CC_CAMNOC_AXI_CLK_SRC				20
+#define CAM_CC_CAMNOC_AXI_HF_CLK				21
+#define CAM_CC_CAMNOC_AXI_SF_CLK				22
+#define CAM_CC_CAMNOC_NRT_AXI_CLK				23
+#define CAM_CC_CAMNOC_RT_AXI_CLK				24
+#define CAM_CC_CCI_0_CLK					25
+#define CAM_CC_CCI_0_CLK_SRC					26
+#define CAM_CC_CCI_1_CLK					27
+#define CAM_CC_CCI_1_CLK_SRC					28
+#define CAM_CC_CORE_AHB_CLK					29
+#define CAM_CC_CPAS_AHB_CLK					30
+#define CAM_CC_CPHY_RX_CLK_SRC					31
+#define CAM_CC_CRE_AHB_CLK					32
+#define CAM_CC_CRE_CLK						33
+#define CAM_CC_CRE_CLK_SRC					34
+#define CAM_CC_CSI0PHYTIMER_CLK					35
+#define CAM_CC_CSI0PHYTIMER_CLK_SRC				36
+#define CAM_CC_CSI1PHYTIMER_CLK					37
+#define CAM_CC_CSI1PHYTIMER_CLK_SRC				38
+#define CAM_CC_CSI2PHYTIMER_CLK					39
+#define CAM_CC_CSI2PHYTIMER_CLK_SRC				40
+#define CAM_CC_CSI3PHYTIMER_CLK					41
+#define CAM_CC_CSI3PHYTIMER_CLK_SRC				42
+#define CAM_CC_CSIPHY0_CLK					43
+#define CAM_CC_CSIPHY1_CLK					44
+#define CAM_CC_CSIPHY2_CLK					45
+#define CAM_CC_CSIPHY3_CLK					46
+#define CAM_CC_FAST_AHB_CLK_SRC					47
+#define CAM_CC_GDSC_CLK						48
+#define CAM_CC_ICP_ATB_CLK					49
+#define CAM_CC_ICP_CLK						50
+#define CAM_CC_ICP_CLK_SRC					51
+#define CAM_CC_ICP_CTI_CLK					52
+#define CAM_CC_ICP_TS_CLK					53
+#define CAM_CC_MCLK0_CLK					54
+#define CAM_CC_MCLK0_CLK_SRC					55
+#define CAM_CC_MCLK1_CLK					56
+#define CAM_CC_MCLK1_CLK_SRC					57
+#define CAM_CC_MCLK2_CLK					58
+#define CAM_CC_MCLK2_CLK_SRC					59
+#define CAM_CC_MCLK3_CLK					60
+#define CAM_CC_MCLK3_CLK_SRC					61
+#define CAM_CC_MCLK4_CLK					62
+#define CAM_CC_MCLK4_CLK_SRC					63
+#define CAM_CC_OPE_0_AHB_CLK					64
+#define CAM_CC_OPE_0_AREG_CLK					65
+#define CAM_CC_OPE_0_CLK					66
+#define CAM_CC_OPE_0_CLK_SRC					67
+#define CAM_CC_SLEEP_CLK					68
+#define CAM_CC_SLEEP_CLK_SRC					69
+#define CAM_CC_SLOW_AHB_CLK_SRC					70
+#define CAM_CC_SOC_AHB_CLK					71
+#define CAM_CC_SYS_TMR_CLK					72
+#define CAM_CC_TFE_0_AHB_CLK					73
+#define CAM_CC_TFE_0_CLK					74
+#define CAM_CC_TFE_0_CLK_SRC					75
+#define CAM_CC_TFE_0_CPHY_RX_CLK				76
+#define CAM_CC_TFE_0_CSID_CLK					77
+#define CAM_CC_TFE_0_CSID_CLK_SRC				78
+#define CAM_CC_TFE_1_AHB_CLK					79
+#define CAM_CC_TFE_1_CLK					80
+#define CAM_CC_TFE_1_CLK_SRC					81
+#define CAM_CC_TFE_1_CPHY_RX_CLK				82
+#define CAM_CC_TFE_1_CSID_CLK					83
+#define CAM_CC_TFE_1_CSID_CLK_SRC				84
+#define CAM_CC_TFE_2_AHB_CLK					85
+#define CAM_CC_TFE_2_CLK					86
+#define CAM_CC_TFE_2_CLK_SRC					87
+#define CAM_CC_TFE_2_CPHY_RX_CLK				88
+#define CAM_CC_TFE_2_CSID_CLK					89
+#define CAM_CC_TFE_2_CSID_CLK_SRC				90
+#define CAM_CC_TOP_SHIFT_CLK					91
+#define CAM_CC_XO_CLK_SRC					92
+
+/* CAM_CC resets */
+#define CAM_CC_BPS_BCR						0
+#define CAM_CC_CAMNOC_BCR					1
+#define CAM_CC_CAMSS_TOP_BCR					2
+#define CAM_CC_CCI_0_BCR					3
+#define CAM_CC_CCI_1_BCR					4
+#define CAM_CC_CPAS_BCR						5
+#define CAM_CC_CRE_BCR						6
+#define CAM_CC_CSI0PHY_BCR					7
+#define CAM_CC_CSI1PHY_BCR					8
+#define CAM_CC_CSI2PHY_BCR					9
+#define CAM_CC_CSI3PHY_BCR					10
+#define CAM_CC_ICP_BCR						11
+#define CAM_CC_MCLK0_BCR					12
+#define CAM_CC_MCLK1_BCR					13
+#define CAM_CC_MCLK2_BCR					14
+#define CAM_CC_MCLK3_BCR					15
+#define CAM_CC_MCLK4_BCR					16
+#define CAM_CC_OPE_0_BCR					17
+#define CAM_CC_TFE_0_BCR					18
+#define CAM_CC_TFE_1_BCR					19
+#define CAM_CC_TFE_2_BCR					20
+
+/* CAM_CC power domains */
+#define CAM_CC_CAMSS_TOP_GDSC					0
+
+#endif

-- 
2.50.1


