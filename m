Return-Path: <linux-kernel+bounces-716627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D302AF88FF
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jul 2025 09:17:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B50EF587F72
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jul 2025 07:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4394027C16A;
	Fri,  4 Jul 2025 07:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="yk6ICD5y"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F3EC2797BF
	for <linux-kernel@vger.kernel.org>; Fri,  4 Jul 2025 07:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751613440; cv=none; b=S3PQwz535v1l/eRICwqgoeDdYnhJYqnmKBbal9BRHcBBz/lG3NN/urs34E45rfiVZPo9D/YhtyAubzr10TV6LADiKown8aLxhFUtgRAyh6SEjHZ2LevsEk68LlJMoEiBI1KtFeQeVs7q2ZBYpelQjxhOa5aVrl/1600rgNdRFVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751613440; c=relaxed/simple;
	bh=FzXklFVjqrZr+SNrWbePFtX/rmT1HkalKzR8jd8RWwE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=d+7kR4O0RTrUTh8nunm20Ps9hC5rByFHiGqXpd7AatZo2/d28CuGABmTcibZaFCWsmJXVHz3lkE1dIPxnhu44HrWQvq+J9hq+0AX0JmYKsmDt4QKhnmFyUzesxTaZmg4E2aCVnomFWykn6NpQkcGceKrFVpgZsYmhP+qCc3RXMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=yk6ICD5y; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ae0bc7aa21bso133453166b.2
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jul 2025 00:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1751613435; x=1752218235; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CbL047G9lXnFwlZAVcS5MLkbJc5GoCbXnI45FXbnG9E=;
        b=yk6ICD5y+Y1sW/8dmFFdlK9QAzgBOVJEzOtO0JnZcic/BlKU9px7xdma4ZdRfs6g8c
         QrdhaUj1EucldwUBLJ2vg3asewg0QsFvw7wF3ne55z4lk55bJlS3yL25IzxYlVXjnRbt
         otY/crCPy/MVxcre6nSevjJVyc/EmuVjfzbeDiSRHwMWaZaJIA4FuoJPO6g67E2dmzNb
         g6oWWyoxeMbZvwwdbaB3VCRAleaSRvRorpzJQu+TZHwFAG1ZcJ11FaUUcvQ7FZYz4H2h
         RKe3KkzqRQJPBKd3tXOzeK9UA5GOO1CTwP4FzxpKUKyURvoJxRfm9C+lIPfgKpDJ4WFx
         iSuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751613435; x=1752218235;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CbL047G9lXnFwlZAVcS5MLkbJc5GoCbXnI45FXbnG9E=;
        b=NfTJ4j0VrAJfEeZheWA48D+4rXxISD59ow9sKzKdM2ErLV9/lVTTOl3NBO1GJqnCXh
         qCsPUgpc1vjRXLxnPxNWVeUQG4aZ5PvP4+d/R7aLULR4peop5EkKyFo30D8p8ZgcA/CS
         UDYxnV+MBat8u9ydudcAfFe5u+1Bj6QfgIeW99UvW0UiAoFRPeDTBsEzP7AM6v4C1uOm
         53girPGBce1r1irV1RQ7rZO67pONbTkb96w0XNfOLxvqi3ars3e1l6+eKTiqmMvUfwIE
         0IA0rGxkvZGjWEl+xcnQXDREXHD459DEqjk+iNOGtLRmkl/RyK2Iy4Eqdo/Qk50JyUO6
         BVjg==
X-Forwarded-Encrypted: i=1; AJvYcCVOW2K1hoZodyJca//x+g60N77JlZvOwjshjXUoaWYewmEcMX2MOToAwY5cDbjzxXCBB6k3+BFKNzOquwA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZLjL4w6A9DwTvM88jhUxFnxpU5vv0OVe0OGh4L5dgIMUizM5D
	GN7XMDKBHJgXOuv3ZRojW0kZkDtRiNbjKaREwRMe+eClxcRXC0GRkhYmGZfPKRhh/aU=
X-Gm-Gg: ASbGncuUPLZuLu+HWRF2VDfNnC5173L/nvnxsKdFqKcXxRxCdXms14SRAtn/ImSXGnX
	cYzx/rB9RU/z/H3XlU53AYEvqDABnnhB+XITvNbNmqoP6LomDwHx1wYyQ+LHn4t5sedDhMOnjKm
	d3pA8GEXze5h1kgU8ucNowH4YxA6siexSNBhh6KoMbuhunZG7/yLHVfMPSbs5oXp5+drq2YvNPE
	JSiMvIFwNpyNsii83745DmGTUuQJwIZJAH/3nV1JC5LpCf0kY2orr0M7ATmqlHrqGW/WHgUCDs3
	GF/kYvLly+4phchVu3xxQrV5w0cV0OCnt2rw08V8t0VRdGDYds9+e9TVyLNNqAkcTRGjRdNyNR6
	nYYR2TwXQUe047x/MwTmIkcJsTpP0crkk
X-Google-Smtp-Source: AGHT+IE4RFK6HSCC+LlUzBO9CqClz/MtRIky3Bq4DryRySXV5Eq48ppHNGpcRmodOkRaMx/+dIuqfg==
X-Received: by 2002:a17:907:6d04:b0:ae0:34d4:28a5 with SMTP id a640c23a62f3a-ae3fe3dafd3mr91767866b.0.1751613434633;
        Fri, 04 Jul 2025 00:17:14 -0700 (PDT)
Received: from otso.local (144-178-202-139.static.ef-service.nl. [144.178.202.139])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae3f66d1ae3sm119401766b.7.2025.07.04.00.17.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jul 2025 00:17:13 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Fri, 04 Jul 2025 09:16:54 +0200
Subject: [PATCH v2 02/11] dt-bindings: clock: qcom: document the Milos
 Global Clock Controller
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250704-sm7635-clocks-v2-2-9e47a7c0d47f@fairphone.com>
References: <20250704-sm7635-clocks-v2-0-9e47a7c0d47f@fairphone.com>
In-Reply-To: <20250704-sm7635-clocks-v2-0-9e47a7c0d47f@fairphone.com>
To: Bjorn Andersson <andersson@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1751613431; l=10876;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=FzXklFVjqrZr+SNrWbePFtX/rmT1HkalKzR8jd8RWwE=;
 b=9lfvr/dgbSfRlcgadz3Y45f1Hsoket2t3FHYF0sfdIVqJ62qSomdiy5QFoEgzzrnvoE9uzGSb
 K1HHNXB5N4UB0/+wPITrMxYcILsnCzsDRW0YTh/RUUuyhnNMLadVAh/
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

Add bindings documentation for the Milos (e.g. SM7635) Global Clock
Controller.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 .../devicetree/bindings/clock/qcom,milos-gcc.yaml  |  62 ++++++
 include/dt-bindings/clock/qcom,milos-gcc.h         | 210 +++++++++++++++++++++
 2 files changed, 272 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/qcom,milos-gcc.yaml b/Documentation/devicetree/bindings/clock/qcom,milos-gcc.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..cf244c155f9a6523d770555f860c27991f3d6b86
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/qcom,milos-gcc.yaml
@@ -0,0 +1,62 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/qcom,milos-gcc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Global Clock & Reset Controller on Milos
+
+maintainers:
+  - Luca Weiss <luca.weiss@fairphone.com>
+
+description: |
+  Qualcomm global clock control module provides the clocks, resets and power
+  domains on Milos.
+
+  See also: include/dt-bindings/clock/qcom,milos-gcc.h
+
+properties:
+  compatible:
+    const: qcom,milos-gcc
+
+  clocks:
+    items:
+      - description: Board XO source
+      - description: Sleep clock source
+      - description: PCIE 0 Pipe clock source
+      - description: PCIE 1 Pipe clock source
+      - description: UFS Phy Rx symbol 0 clock source
+      - description: UFS Phy Rx symbol 1 clock source
+      - description: UFS Phy Tx symbol 0 clock source
+      - description: USB3 Phy wrapper pipe clock source
+
+required:
+  - compatible
+  - clocks
+  - '#power-domain-cells'
+
+allOf:
+  - $ref: qcom,gcc.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,rpmh.h>
+    clock-controller@100000 {
+        compatible = "qcom,milos-gcc";
+        reg = <0x00100000 0x1f4200>;
+        clocks = <&rpmhcc RPMH_CXO_CLK>,
+                 <&sleep_clk>,
+                 <&pcie0_phy>,
+                 <&pcie1_phy>,
+                 <&ufs_mem_phy 0>,
+                 <&ufs_mem_phy 1>,
+                 <&ufs_mem_phy 2>,
+                 <&usb_1_qmpphy>;
+        #clock-cells = <1>;
+        #reset-cells = <1>;
+        #power-domain-cells = <1>;
+    };
+
+...
diff --git a/include/dt-bindings/clock/qcom,milos-gcc.h b/include/dt-bindings/clock/qcom,milos-gcc.h
new file mode 100644
index 0000000000000000000000000000000000000000..a530ca39e1ef8089ab200ee4368290f997b12ce9
--- /dev/null
+++ b/include/dt-bindings/clock/qcom,milos-gcc.h
@@ -0,0 +1,210 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (c) 2023, Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2025, Luca Weiss <luca.weiss@fairphone.com>
+ */
+
+#ifndef _DT_BINDINGS_CLK_QCOM_GCC_MILOS_H
+#define _DT_BINDINGS_CLK_QCOM_GCC_MILOS_H
+
+/* GCC clocks */
+#define GCC_GPLL0						0
+#define GCC_GPLL0_OUT_EVEN					1
+#define GCC_GPLL2						2
+#define GCC_GPLL4						3
+#define GCC_GPLL6						4
+#define GCC_GPLL7						5
+#define GCC_GPLL9						6
+#define GCC_AGGRE_NOC_PCIE_AXI_CLK				7
+#define GCC_AGGRE_UFS_PHY_AXI_CLK				8
+#define GCC_AGGRE_UFS_PHY_AXI_HW_CTL_CLK			9
+#define GCC_AGGRE_USB3_PRIM_AXI_CLK				10
+#define GCC_BOOT_ROM_AHB_CLK					11
+#define GCC_CAMERA_AHB_CLK					12
+#define GCC_CAMERA_HF_AXI_CLK					13
+#define GCC_CAMERA_HF_XO_CLK					14
+#define GCC_CAMERA_SF_AXI_CLK					15
+#define GCC_CAMERA_SF_XO_CLK					16
+#define GCC_CFG_NOC_PCIE_ANOC_AHB_CLK				17
+#define GCC_CFG_NOC_USB3_PRIM_AXI_CLK				18
+#define GCC_CNOC_PCIE_SF_AXI_CLK				19
+#define GCC_DDRSS_GPU_AXI_CLK					20
+#define GCC_DDRSS_PCIE_SF_QTB_CLK				21
+#define GCC_DISP_AHB_CLK					22
+#define GCC_DISP_GPLL0_DIV_CLK_SRC				23
+#define GCC_DISP_HF_AXI_CLK					24
+#define GCC_DISP_XO_CLK						25
+#define GCC_GP1_CLK						26
+#define GCC_GP1_CLK_SRC						27
+#define GCC_GP2_CLK						28
+#define GCC_GP2_CLK_SRC						29
+#define GCC_GP3_CLK						30
+#define GCC_GP3_CLK_SRC						31
+#define GCC_GPU_CFG_AHB_CLK					32
+#define GCC_GPU_GPLL0_CLK_SRC					33
+#define GCC_GPU_GPLL0_DIV_CLK_SRC				34
+#define GCC_GPU_MEMNOC_GFX_CLK					35
+#define GCC_GPU_SNOC_DVM_GFX_CLK				36
+#define GCC_PCIE_0_AUX_CLK					37
+#define GCC_PCIE_0_AUX_CLK_SRC					38
+#define GCC_PCIE_0_CFG_AHB_CLK					39
+#define GCC_PCIE_0_MSTR_AXI_CLK					40
+#define GCC_PCIE_0_PHY_RCHNG_CLK				41
+#define GCC_PCIE_0_PHY_RCHNG_CLK_SRC				42
+#define GCC_PCIE_0_PIPE_CLK					43
+#define GCC_PCIE_0_PIPE_CLK_SRC					44
+#define GCC_PCIE_0_PIPE_DIV2_CLK				45
+#define GCC_PCIE_0_PIPE_DIV2_CLK_SRC				46
+#define GCC_PCIE_0_SLV_AXI_CLK					47
+#define GCC_PCIE_0_SLV_Q2A_AXI_CLK				48
+#define GCC_PCIE_1_AUX_CLK					49
+#define GCC_PCIE_1_AUX_CLK_SRC					50
+#define GCC_PCIE_1_CFG_AHB_CLK					51
+#define GCC_PCIE_1_MSTR_AXI_CLK					52
+#define GCC_PCIE_1_PHY_RCHNG_CLK				53
+#define GCC_PCIE_1_PHY_RCHNG_CLK_SRC				54
+#define GCC_PCIE_1_PIPE_CLK					55
+#define GCC_PCIE_1_PIPE_CLK_SRC					56
+#define GCC_PCIE_1_PIPE_DIV2_CLK				57
+#define GCC_PCIE_1_PIPE_DIV2_CLK_SRC				58
+#define GCC_PCIE_1_SLV_AXI_CLK					59
+#define GCC_PCIE_1_SLV_Q2A_AXI_CLK				60
+#define GCC_PCIE_RSCC_CFG_AHB_CLK				61
+#define GCC_PCIE_RSCC_XO_CLK					62
+#define GCC_PDM2_CLK						63
+#define GCC_PDM2_CLK_SRC					64
+#define GCC_PDM_AHB_CLK						65
+#define GCC_PDM_XO4_CLK						66
+#define GCC_QMIP_CAMERA_NRT_AHB_CLK				67
+#define GCC_QMIP_CAMERA_RT_AHB_CLK				68
+#define GCC_QMIP_DISP_AHB_CLK					69
+#define GCC_QMIP_GPU_AHB_CLK					70
+#define GCC_QMIP_PCIE_AHB_CLK					71
+#define GCC_QMIP_VIDEO_CV_CPU_AHB_CLK				72
+#define GCC_QMIP_VIDEO_CVP_AHB_CLK				73
+#define GCC_QMIP_VIDEO_V_CPU_AHB_CLK				74
+#define GCC_QMIP_VIDEO_VCODEC_AHB_CLK				75
+#define GCC_QUPV3_WRAP0_CORE_2X_CLK				76
+#define GCC_QUPV3_WRAP0_CORE_CLK				77
+#define GCC_QUPV3_WRAP0_QSPI_REF_CLK				78
+#define GCC_QUPV3_WRAP0_QSPI_REF_CLK_SRC			79
+#define GCC_QUPV3_WRAP0_S0_CLK					80
+#define GCC_QUPV3_WRAP0_S0_CLK_SRC				81
+#define GCC_QUPV3_WRAP0_S1_CLK					82
+#define GCC_QUPV3_WRAP0_S1_CLK_SRC				83
+#define GCC_QUPV3_WRAP0_S2_CLK					84
+#define GCC_QUPV3_WRAP0_S2_CLK_SRC				85
+#define GCC_QUPV3_WRAP0_S3_CLK					86
+#define GCC_QUPV3_WRAP0_S3_CLK_SRC				87
+#define GCC_QUPV3_WRAP0_S4_CLK					88
+#define GCC_QUPV3_WRAP0_S4_CLK_SRC				89
+#define GCC_QUPV3_WRAP0_S5_CLK					90
+#define GCC_QUPV3_WRAP0_S5_CLK_SRC				91
+#define GCC_QUPV3_WRAP0_S6_CLK					92
+#define GCC_QUPV3_WRAP0_S6_CLK_SRC				93
+#define GCC_QUPV3_WRAP1_CORE_2X_CLK				94
+#define GCC_QUPV3_WRAP1_CORE_CLK				95
+#define GCC_QUPV3_WRAP1_QSPI_REF_CLK				96
+#define GCC_QUPV3_WRAP1_QSPI_REF_CLK_SRC			97
+#define GCC_QUPV3_WRAP1_S0_CLK					98
+#define GCC_QUPV3_WRAP1_S0_CLK_SRC				99
+#define GCC_QUPV3_WRAP1_S1_CLK					100
+#define GCC_QUPV3_WRAP1_S1_CLK_SRC				101
+#define GCC_QUPV3_WRAP1_S2_CLK					102
+#define GCC_QUPV3_WRAP1_S2_CLK_SRC				103
+#define GCC_QUPV3_WRAP1_S3_CLK					104
+#define GCC_QUPV3_WRAP1_S3_CLK_SRC				105
+#define GCC_QUPV3_WRAP1_S4_CLK					106
+#define GCC_QUPV3_WRAP1_S4_CLK_SRC				107
+#define GCC_QUPV3_WRAP1_S5_CLK					108
+#define GCC_QUPV3_WRAP1_S5_CLK_SRC				109
+#define GCC_QUPV3_WRAP1_S6_CLK					110
+#define GCC_QUPV3_WRAP1_S6_CLK_SRC				111
+#define GCC_QUPV3_WRAP_0_M_AHB_CLK				112
+#define GCC_QUPV3_WRAP_0_S_AHB_CLK				113
+#define GCC_QUPV3_WRAP_1_M_AHB_CLK				114
+#define GCC_QUPV3_WRAP_1_S_AHB_CLK				115
+#define GCC_SDCC1_AHB_CLK					116
+#define GCC_SDCC1_APPS_CLK					117
+#define GCC_SDCC1_APPS_CLK_SRC					118
+#define GCC_SDCC1_ICE_CORE_CLK					119
+#define GCC_SDCC1_ICE_CORE_CLK_SRC				120
+#define GCC_SDCC2_AHB_CLK					121
+#define GCC_SDCC2_APPS_CLK					122
+#define GCC_SDCC2_APPS_CLK_SRC					123
+#define GCC_UFS_PHY_AHB_CLK					124
+#define GCC_UFS_PHY_AXI_CLK					125
+#define GCC_UFS_PHY_AXI_CLK_SRC					126
+#define GCC_UFS_PHY_AXI_HW_CTL_CLK				127
+#define GCC_UFS_PHY_ICE_CORE_CLK				128
+#define GCC_UFS_PHY_ICE_CORE_CLK_SRC				129
+#define GCC_UFS_PHY_ICE_CORE_HW_CTL_CLK				130
+#define GCC_UFS_PHY_PHY_AUX_CLK					131
+#define GCC_UFS_PHY_PHY_AUX_CLK_SRC				132
+#define GCC_UFS_PHY_PHY_AUX_HW_CTL_CLK				133
+#define GCC_UFS_PHY_RX_SYMBOL_0_CLK				134
+#define GCC_UFS_PHY_RX_SYMBOL_0_CLK_SRC				135
+#define GCC_UFS_PHY_RX_SYMBOL_1_CLK				136
+#define GCC_UFS_PHY_RX_SYMBOL_1_CLK_SRC				137
+#define GCC_UFS_PHY_TX_SYMBOL_0_CLK				138
+#define GCC_UFS_PHY_TX_SYMBOL_0_CLK_SRC				139
+#define GCC_UFS_PHY_UNIPRO_CORE_CLK				140
+#define GCC_UFS_PHY_UNIPRO_CORE_CLK_SRC				141
+#define GCC_UFS_PHY_UNIPRO_CORE_HW_CTL_CLK			142
+#define GCC_USB30_PRIM_ATB_CLK					143
+#define GCC_USB30_PRIM_MASTER_CLK				144
+#define GCC_USB30_PRIM_MASTER_CLK_SRC				145
+#define GCC_USB30_PRIM_MOCK_UTMI_CLK				146
+#define GCC_USB30_PRIM_MOCK_UTMI_CLK_SRC			147
+#define GCC_USB30_PRIM_MOCK_UTMI_POSTDIV_CLK_SRC		148
+#define GCC_USB30_PRIM_SLEEP_CLK				149
+#define GCC_USB3_PRIM_PHY_AUX_CLK				150
+#define GCC_USB3_PRIM_PHY_AUX_CLK_SRC				151
+#define GCC_USB3_PRIM_PHY_COM_AUX_CLK				152
+#define GCC_USB3_PRIM_PHY_PIPE_CLK				153
+#define GCC_USB3_PRIM_PHY_PIPE_CLK_SRC				154
+#define GCC_VIDEO_AHB_CLK					155
+#define GCC_VIDEO_AXI0_CLK					156
+#define GCC_VIDEO_XO_CLK					157
+
+/* GCC resets */
+#define GCC_CAMERA_BCR						0
+#define GCC_DISPLAY_BCR						1
+#define GCC_GPU_BCR						2
+#define GCC_PCIE_0_BCR						3
+#define GCC_PCIE_0_LINK_DOWN_BCR				4
+#define GCC_PCIE_0_NOCSR_COM_PHY_BCR				5
+#define GCC_PCIE_0_PHY_BCR					6
+#define GCC_PCIE_0_PHY_NOCSR_COM_PHY_BCR			7
+#define GCC_PCIE_1_BCR						8
+#define GCC_PCIE_1_LINK_DOWN_BCR				9
+#define GCC_PCIE_1_NOCSR_COM_PHY_BCR				10
+#define GCC_PCIE_1_PHY_BCR					11
+#define GCC_PCIE_1_PHY_NOCSR_COM_PHY_BCR			12
+#define GCC_PCIE_RSCC_BCR					13
+#define GCC_PDM_BCR						14
+#define GCC_QUPV3_WRAPPER_0_BCR					15
+#define GCC_QUPV3_WRAPPER_1_BCR					16
+#define GCC_QUSB2PHY_PRIM_BCR					17
+#define GCC_QUSB2PHY_SEC_BCR					18
+#define GCC_SDCC1_BCR						19
+#define GCC_SDCC2_BCR						20
+#define GCC_UFS_PHY_BCR						21
+#define GCC_USB30_PRIM_BCR					22
+#define GCC_USB3_DP_PHY_PRIM_BCR				23
+#define GCC_USB3_PHY_PRIM_BCR					24
+#define GCC_USB3PHY_PHY_PRIM_BCR				25
+#define GCC_VIDEO_AXI0_CLK_ARES					26
+#define GCC_VIDEO_BCR						27
+
+/* GCC power domains */
+#define PCIE_0_GDSC						0
+#define PCIE_0_PHY_GDSC						1
+#define PCIE_1_GDSC						2
+#define PCIE_1_PHY_GDSC						3
+#define UFS_PHY_GDSC						4
+#define UFS_MEM_PHY_GDSC					5
+#define USB30_PRIM_GDSC						6
+#define USB3_PHY_GDSC						7
+
+#endif

-- 
2.50.0


