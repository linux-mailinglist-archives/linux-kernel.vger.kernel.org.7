Return-Path: <linux-kernel+bounces-731348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2B94B052EE
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 09:25:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06AE03BD345
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 07:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFBFB2DCF57;
	Tue, 15 Jul 2025 07:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="DcdJlQ9X"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0DE2D948D
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 07:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752563975; cv=none; b=C/+HH8imxJRtOEbHN2B7cXTlLBq2MxByYPwGvshcuZWHcREMXfLon1VUWOkseqVRSLFTL1mrVn/VPdzatJwnMAHxH7HsKTnwkzjT0Og44DuO25mXzzAklQFTCVl8ZnUd3JSU6JXRntb/76S3EP/bWADnd0psk3CVmzIbWOSV8U8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752563975; c=relaxed/simple;
	bh=CiLnJnnUrfqRenJj+981Vs9REuGXiJVfcw8J0barKMU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=T/J5+Si/hPO2FiU1jBqvHzpueZ2TfeYAilczOEdJAIo6iAO5vNqm+Ntx4YBK/BCKCeFoq3KDrueH+AHRNGI5k97X4uwCjkzOdvw9gds5C9eBsmhjoY5GfENq6ElWC2D2YpICKPvg+Ad/Giniuui6xmasQtHcNmBezMQJyaZ5L2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=DcdJlQ9X; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-60c9d8a169bso9043318a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 00:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1752563969; x=1753168769; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KcfQqYLe3zmIGP6Ac4Qc6scoF3iQeb2uH1PNmMZXhL0=;
        b=DcdJlQ9XG3X9lx0xLZxqkgbr0+gHULzedYjK9uCBULdmZMBsKoIqA/v6bjnJ+tiWrV
         t44H5RftunfRSYJ9ApRvCmRTVnGY5F603dFietodfP8daW2ACX1IJtTE2BrC9MIm752e
         aBNy78VRknb4cZlRq9z5I7lSfvH0nqX9nXd36UQz74hubaOiQnIbnt8f2ECbgqvhjRuz
         gYwLfK/lESfgcDywOw4ZtsKnjJVqgBEu79zebXViaSzkunU3MeLUBHuR/nNS64Mt4LQ6
         lBdU67DNtPtWm3+XE6Rcm4nF7wvHBFSn5O8Q+HEKSjfe8eFXeWurmH2yfOWleW0tlPZb
         KS7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752563969; x=1753168769;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KcfQqYLe3zmIGP6Ac4Qc6scoF3iQeb2uH1PNmMZXhL0=;
        b=vRbANH5mBPPswNODewbI9LwYFRxaY4jQlGjKcQubmfYxlYMQlOIXifUXNI4qWyEYwE
         tTn9DNuN81EGL7neum6DQqmS2yq01qUQo8V4mOpIMXFt3Dk7KrUFgOmqRLSfDnfrVhOX
         SarsTzW/d1vus9TGjI88mc6RdrzFLF2KHWGcmc0K8+Z9b0/5F9QiEilAAs4a22PSEhdA
         30BRbT0Ah/KkoZCWtaVqDGLnb850em/nog/z3EiqXPC0hBbj9Q68jLF2WRnvgl4fZSEH
         1fHbir27FmiutMG8gUYWviKZnl0oxdmTMnaliDrEHaCkZmS3UFRMAu/21J5atSffPw34
         O1xQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4VUoXF/NigONxJkp/zItlJHwXCxAs2g6uIqBRPnjlOMrxFDTMO2Dlh4l8qD7LzN7DmGlhZ/iflF75pzw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9wsZFpEMxLq27xFNfFeB++pwC3dbiVK7oc+xlH34pGe9JseUi
	hucZ+ucCVs5eRGBAWqUs0cGjS7SYSE8RhJah+p4RuhKW1YiT0GkJ6hqYFbsHIHqa2D8=
X-Gm-Gg: ASbGnculS/arR4J50I8sQqM2tFVge9O68H3qPZ8OieNJCHlsYIvcZGsOXbrp5lxBTKe
	Pr+SKxPeY4xH9Rgpq85pAtSOYda53gE6ixTjEqOdLQC43Tnpid3TMVPoBT952BkgEsGzDpUkyxi
	TpqACsfKPqZWepZ7yHkvNxHEQq7AdwfKPz5GCMpZRUAEaCLQvnxnVqXGboeDYcTWAZDCvSvw/Fj
	DH+jLPEticumuRGt69RkximjT/qvnI0n/L5XGCh9qfj1t5UY1LF17ukdZ2deFaHer7WrohWKCuX
	Oj9G7NyLBUrFF8G3Gfc5ucY4q/vs6tZ4ciPP1Cl5JOYREUCHX/wRJbtxhQEC2JCPkbdbbRNfXE2
	IHbXQH5MC+5fDthnewhnTJtwaYgjoIAOu32vDg/H/1+lizhA/ioY5s2IX
X-Google-Smtp-Source: AGHT+IGqhGp56tVmzfJsu+xrpGc/fQR2gSpYpE7uD2xa7nnJ/A/Mjq5oXuFg53VJ1sr31mXo0sfU1w==
X-Received: by 2002:a05:6402:40c7:b0:609:9115:60f1 with SMTP id 4fb4d7f45d1cf-611e84a9cabmr13048623a12.16.1752563969337;
        Tue, 15 Jul 2025 00:19:29 -0700 (PDT)
Received: from otso.local (212095005088.public.telering.at. [212.95.5.88])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-611c976fcfcsm6873715a12.66.2025.07.15.00.19.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 00:19:28 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Tue, 15 Jul 2025 09:19:10 +0200
Subject: [PATCH v3 10/11] dt-bindings: clock: qcom: document the Milos
 Video Clock Controller
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250715-sm7635-clocks-v3-10-18f9faac4984@fairphone.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752563952; l=3601;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=CiLnJnnUrfqRenJj+981Vs9REuGXiJVfcw8J0barKMU=;
 b=US3XVRm8A5UmyOXxkhOQwajQxY/HeHuBektXtw5i5s4xc4rE+276irs9sWeSLVz+gZ0ezPOwz
 3Q+dzzGxoMdB5s/FextWXFFFtWc+IXJQ4enLrYdUnj/eNvyaVZlVHDd
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

Add bindings documentation for the Milos (e.g. SM7635) Video Clock
Controller.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 .../bindings/clock/qcom,milos-videocc.yaml         | 53 ++++++++++++++++++++++
 include/dt-bindings/clock/qcom,milos-videocc.h     | 36 +++++++++++++++
 2 files changed, 89 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/qcom,milos-videocc.yaml b/Documentation/devicetree/bindings/clock/qcom,milos-videocc.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..14c31efe1308aadbea61eb7be7e56039a923aec5
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/qcom,milos-videocc.yaml
@@ -0,0 +1,53 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/qcom,milos-videocc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Video Clock & Reset Controller on Milos
+
+maintainers:
+  - Luca Weiss <luca.weiss@fairphone.com>
+
+description: |
+  Qualcomm video clock control module provides the clocks, resets and power
+  domains on Milos.
+
+  See also: include/dt-bindings/clock/qcom,milos-videocc.h
+
+properties:
+  compatible:
+    const: qcom,milos-videocc
+
+  clocks:
+    items:
+      - description: Board XO source
+      - description: Board active XO source
+      - description: Sleep clock source
+      - description: Video AHB clock from GCC
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
+    clock-controller@aaf0000 {
+        compatible = "qcom,milos-videocc";
+        reg = <0x0aaf0000 0x10000>;
+        clocks = <&bi_tcxo_div2>,
+                 <&bi_tcxo_ao_div2>,
+                 <&sleep_clk>,
+                 <&gcc GCC_VIDEO_AHB_CLK>;
+        #clock-cells = <1>;
+        #reset-cells = <1>;
+        #power-domain-cells = <1>;
+    };
+
+...
diff --git a/include/dt-bindings/clock/qcom,milos-videocc.h b/include/dt-bindings/clock/qcom,milos-videocc.h
new file mode 100644
index 0000000000000000000000000000000000000000..3544db81ffae6fb7c72b123063b9af4337742054
--- /dev/null
+++ b/include/dt-bindings/clock/qcom,milos-videocc.h
@@ -0,0 +1,36 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (c) 2023, Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2025, Luca Weiss <luca.weiss@fairphone.com>
+ */
+
+#ifndef _DT_BINDINGS_CLK_QCOM_VIDEO_CC_MILOS_H
+#define _DT_BINDINGS_CLK_QCOM_VIDEO_CC_MILOS_H
+
+/* VIDEO_CC clocks */
+#define VIDEO_CC_PLL0						0
+#define VIDEO_CC_AHB_CLK					1
+#define VIDEO_CC_AHB_CLK_SRC					2
+#define VIDEO_CC_MVS0_CLK					3
+#define VIDEO_CC_MVS0_CLK_SRC					4
+#define VIDEO_CC_MVS0_DIV_CLK_SRC				5
+#define VIDEO_CC_MVS0_SHIFT_CLK					6
+#define VIDEO_CC_MVS0C_CLK					7
+#define VIDEO_CC_MVS0C_DIV2_DIV_CLK_SRC				8
+#define VIDEO_CC_MVS0C_SHIFT_CLK				9
+#define VIDEO_CC_SLEEP_CLK					10
+#define VIDEO_CC_SLEEP_CLK_SRC					11
+#define VIDEO_CC_XO_CLK						12
+#define VIDEO_CC_XO_CLK_SRC					13
+
+/* VIDEO_CC resets */
+#define VIDEO_CC_INTERFACE_BCR					0
+#define VIDEO_CC_MVS0_BCR					1
+#define VIDEO_CC_MVS0C_CLK_ARES					2
+#define VIDEO_CC_MVS0C_BCR					3
+
+/* VIDEO_CC power domains */
+#define VIDEO_CC_MVS0_GDSC					0
+#define VIDEO_CC_MVS0C_GDSC					1
+
+#endif

-- 
2.50.1


