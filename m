Return-Path: <linux-kernel+bounces-701967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ABA3BAE7BD4
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jun 2025 11:14:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 733AC7AC37C
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jun 2025 09:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1B6629E11C;
	Wed, 25 Jun 2025 09:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="q4sFxnI1"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E355C29E0F1
	for <linux-kernel@vger.kernel.org>; Wed, 25 Jun 2025 09:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750842754; cv=none; b=AoJ1WsD2jVzba3h2X/iMedd8N9rg3JdFNiiN244Viw3mPKFnukIKcC/+QcN5T4fvAe1dCC+KR2loA1AxAX0lwAdkIazDROmJev8bHSwH0LI29szLXZxacTplyAAigaA4uoE7D6WWGXCtp24os1eIiJVNn4ATp5L9cY6va4dfv+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750842754; c=relaxed/simple;
	bh=DxlVCyB+GdvlrR0MvcbC7FI8ijyu6mY76oogTWBXjIE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sFmpiiNKn2ZcVDXN2qvpvGlqK/fD0RWHPV18PlfdEZ2BsanYHeARHoETrUcvowohsIfZaXkLXixTwFmmWRGQH932ifjzQKJVtrAl94Ep9oJwku88b8VuYpKJeehH/cysKbziSb7N5INuGVan2gejhsmRLXvJwELv6BKZ6nxQQRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=q4sFxnI1; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-addcea380eeso1031231566b.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jun 2025 02:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1750842750; x=1751447550; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=woO+xdDN4+RcnKlqQsquJ25kEqCmZPuEPcEuwDa8tPI=;
        b=q4sFxnI1yRXbNedXtMNjfFIPOMnnd4co3SZVjxN2um0b1ptgImD+Vd8s4MJKbLw44P
         EZZ3xvAizREYOwCXdPmoGoNq30DGA/nQiPVFkwbfRy7LUP2lk+UZzkKSn84adqGg3EKx
         xhbxWzoFVQJ+kpqzLbyB8S0FtTvlb3FBxv0VT32KsMbgp050CZBHkWk7/VsJBPAQPlRS
         olvf3VG6vuhkJMyNacjGTZWFoZ/nSM/+RG/MhbmzCH0S7/beSiwam/KNCI9wpnPc5D+e
         DIa/DeAv46bEvXYSYlNZ54FnIFg0//7gg+GAdodeLowfvHa9M/J25xjrs7ibE/cGNg1K
         XVKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750842750; x=1751447550;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=woO+xdDN4+RcnKlqQsquJ25kEqCmZPuEPcEuwDa8tPI=;
        b=HwOTVpu9mHoNZqU0iFLQQ11T43LyEyitt3aaAnIFhFF51g0kMT2aWi+XvhlvcViC1B
         g98j20lKt9WJE8oShpHbd62qrUrJBLgD4Y54+z68bnUIcxSPwLOTK1chvhJD8gmn0bOZ
         GgiGXjr/ReP+DNiGPIHU+JnUFs5ONtFNg92ZVvSF2ggxbTfuoz/pVr4N4DgZSRPehY/f
         MouBVgnX3Sdm87aEl3ow7PVJvv62TsgLV6oPNJyI0S3wknWfHnkmdJxMC4JENAp0CNLr
         snkestpx60PX5tySQouXRdk/uaq5Nb6ZPTwgGxwcWQ2DcJbvmcgIwLFPEGXwKKSa7Eyj
         QjIQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0vadAEm9wPxeoi5ltSLv4LVaS+Rz89L8Hk1zaKZg46T3s5j9YCjPK//tdRr+rWeCNgO4WOhcbEZvtbh4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYA9iBeW2QJiRF+anUP81ntr8romkLp7iyltAt5qXU94ypcVXZ
	5VCqNO9G8VKqN7maGnkziK8z37nv+uh/mDDyYdCOzJVsNvHML7iXZDoTi7M4iJ2yiD8=
X-Gm-Gg: ASbGncvZ/SFI72WVtu9YdG91gKoyvbvyOUxfTni4YHHq1I+6ApHItXjQFdx7RgODRWO
	1Pqcd0QkJvfsNoqxUXYaDc285QBktv5jfNhFWT4+604osZIPFg3DiBqI/6pbhEYYJBxsv7hBtd4
	wtzUZIZvO5jHijT1GK/o8i08EtwBtae4SvjC1YuIj6oJ1mhs+FpbqKO17EDvUzau3utfb2ohxRe
	FFtlxJaVGbSrLBmCni7i10w85lfFwPZOpPM0ypyJ3CFc1GcamoHalWgoUQW58nTPakjqoz2G8RX
	4U7Gew7i4e7WmTJb049Qpec/5nW325TUOcPBTl23snMSsWhCk/yXeeUG88bp7DKI1Z7igXdOaQZ
	MVRKiqebPMeaceAwDdTUwtxNIPBkrQn6E
X-Google-Smtp-Source: AGHT+IHQUWmpKdh57HUovY6Aq3zrFSRHIzv8yVxVY8UQbzyLFDYma2l2jkcg4Ub4mCvBBAl6HuQGHg==
X-Received: by 2002:a17:906:caea:b0:add:ed0d:a581 with SMTP id a640c23a62f3a-ae0be861c3cmr242554166b.17.1750842750105;
        Wed, 25 Jun 2025 02:12:30 -0700 (PDT)
Received: from otso.local (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae0b887ab4csm154937366b.129.2025.06.25.02.12.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 02:12:29 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Wed, 25 Jun 2025 11:12:19 +0200
Subject: [PATCH 01/10] dt-bindings: clock: qcom: document the SM7635 Global
 Clock Controller
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250625-sm7635-clocks-v1-1-ca3120e3a80e@fairphone.com>
References: <20250625-sm7635-clocks-v1-0-ca3120e3a80e@fairphone.com>
In-Reply-To: <20250625-sm7635-clocks-v1-0-ca3120e3a80e@fairphone.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1750842748; l=10877;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=DxlVCyB+GdvlrR0MvcbC7FI8ijyu6mY76oogTWBXjIE=;
 b=IgQkcJDIYCa9NFxxlxn7KL6M+RIXPDB+jkNEx6sdIxk/pJ8EMVKz8LudgtJkT/GlHWGEVJk/j
 n98GA1nKy7mDGeGbYFyUsCIMCZfk9AEY4kRtMvNhmb1//X6h/pv4GD6
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

Add bindings documentation for the SM7635 Global Clock Controller.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 .../devicetree/bindings/clock/qcom,sm7635-gcc.yaml |  62 ++++++
 include/dt-bindings/clock/qcom,sm7635-gcc.h        | 210 +++++++++++++++++++++
 2 files changed, 272 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/qcom,sm7635-gcc.yaml b/Documentation/devicetree/bindings/clock/qcom,sm7635-gcc.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..66061119d659772c36f61a697a1769077c60ebb0
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/qcom,sm7635-gcc.yaml
@@ -0,0 +1,62 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/qcom,sm7635-gcc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Global Clock & Reset Controller on SM7635
+
+maintainers:
+  - Luca Weiss <luca.weiss@fairphone.com>
+
+description: |
+  Qualcomm global clock control module provides the clocks, resets and power
+  domains on SM7635.
+
+  See also:: include/dt-bindings/clock/qcom,sm7635-gcc.h
+
+properties:
+  compatible:
+    const: qcom,sm7635-gcc
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
+        compatible = "qcom,sm7635-gcc";
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
diff --git a/include/dt-bindings/clock/qcom,sm7635-gcc.h b/include/dt-bindings/clock/qcom,sm7635-gcc.h
new file mode 100644
index 0000000000000000000000000000000000000000..f76cb8843a1e99a24fae0fb9a1ac731028193b9d
--- /dev/null
+++ b/include/dt-bindings/clock/qcom,sm7635-gcc.h
@@ -0,0 +1,210 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (c) 2023, Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2025, Luca Weiss <luca.weiss@fairphone.com>
+ */
+
+#ifndef _DT_BINDINGS_CLK_QCOM_GCC_SM7635_H
+#define _DT_BINDINGS_CLK_QCOM_GCC_SM7635_H
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


