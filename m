Return-Path: <linux-kernel+bounces-831369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 99F4DB9C7AD
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 01:17:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 88F174E270A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 23:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0994D2D238C;
	Wed, 24 Sep 2025 23:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="R+WPdHZK"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2079C29C323
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758755776; cv=none; b=R/tgutmc1d9bSfoixyTcK+R+ul3VzfExV0uOXFhNgza8mpuE8bFdY5LonH9K1uNFyg5tv0F1/RXBuy6Bow2EptvsynI/RSoKJRZlAxKZ+DMvk7ngC9iu5U1PRmKWpOpEMy8WHZ2GxqdauUmWDy3Kz8RLGA2TmDdjs0gWQAiXuhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758755776; c=relaxed/simple;
	bh=xGmmn6FH30g7INYIt0TMFP6e87l2yakTWhyZU6ZF4fY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OdVanT58AulbYg9RkZztQaE1LUcB33wQPw6uTYDuLhf82csLzijM7n5bMFUeHcv8dN8raLcuIHDr3qIdgPfH7yGzQEWfF+UmZYq3EqeFBCFHHLDHFguFG9ZqZI0drLQ9EQAwhn+2WpISJBC3H55eSgNVRocv3eiSz2/Qlrk3mX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=R+WPdHZK; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58OD0LZw023856
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:16:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Gx+zCIdUcwT48FJd+FCgjnuAtSE6hL53Eqp2G4plvJU=; b=R+WPdHZKeTlpsbQD
	wkhK3Ud1Z5dKgww2y2umbmFm2INyJyo7RQgi40XtcWX4eIw8l+QeqZssWJQYl5Yi
	UG56BKW1rhh29ORKJz6laoyO6hcGujngGyGukK3aa4+TmwGzLu4e6cj+MCTIa1WE
	K0/VCo544R2l9jEMWkDEAqrLjw+VSjIZcvChxwF7K4vn/rc5Gmq9/MxBK0HYN25W
	so4Bxft9iXLmflVZANc7P72nDkoQNsquBv4nrZKKTdN5qTrisv0ahwYrkVW8HH9n
	EuevjBAX6pxYxsk+7khSiN9oOJpnHlu/GVGkMZwiZPhsAEOgjEncymDFu/vCexbZ
	egF/Hg==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49bwp0d1f2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:16:12 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-77f29f473a2so275016b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 16:16:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758755771; x=1759360571;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gx+zCIdUcwT48FJd+FCgjnuAtSE6hL53Eqp2G4plvJU=;
        b=uEG3ekYUAluNgruxNqSyoz9Ck6pNlNWnMB9WnfW7tqcHqJKzL2yYaFSej/sLukMw8P
         FYHVTUYBTbezUOpjNlnUOdryCbXvSrlmyESQt4fl6T9rBgxdXSxiwlm0mds39E8p1UES
         bUmEg/svkx5VaCTC0H5EIfPXvSDCzDPV1R6Ndi6kG+eC+7If2LMyZKVUTf0gkOUxUB1S
         xcSQuy75PBv2ameHOrz9ByRczfDfBtgTGkk0keI2iQV30M5k76lEJEUwLOUY/yVyoQB6
         mtlpvoxRwOhCprgFyhvegR2+ZXyF4TLKivVwxy6Fjem3jCTlJPRZSor6DK7Yo6UbfcHx
         2ZAQ==
X-Forwarded-Encrypted: i=1; AJvYcCVRKWiGiOULrtKLN/4DCV3YXCW+NfDyBbTXzr9jKJypKHlqnn3SxQeVJ1M+xL4/WdQZssgHkSSsJ9wXy+E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqovfdbJ+MDiDcKSswaxujh3rWMwH3rW7R0Gau1Z0rmAhKkN8d
	BCBDBMrvTNapdQ93I6DyxxRYGjy/D4+mXTo83EsYMmFidZrGgQM0lVXtw49YaIl3nlPZ46k+rvS
	/7u2gp3LzEUCsptU3l9X7nX4QPuYj06PZIa3POS6fe17+P+3jplQEgmB3JyImgSR1Fjs=
X-Gm-Gg: ASbGncsygLiDMfMxv7tzBmcHMZe6xajPFZFaWCzmyyUOqIrA/qEYfLJrN371MuZDwPu
	q2PXw7CEsGvEYc2XlA7GqcPlSBtNkE66rUNgrNh38NvlDw1DYK4O55SCaFCDPZMubT0T/OO0WKS
	iQIw/A/WyyofHHJEs2D2WnZr30X37ZHAm6g4VLrYS1rkgddKgMLUxaxbglxxWYe63w4qUjWt91U
	WJPwy6fKDHMCOlgdRQfAeodMoR23ieWvKDrgN41XfYiscXKuZ4DDa44QRhBJmgUkhk4rI3D51RN
	RW/uqR6UQFKcUnFoVBIKwb0Gs9tU1JnNqRXS4I1i4o/UDWDacLLL6yuZmHhhPb6eOLLM+vh63Pq
	6f7WQYuiLvxz2hxQ=
X-Received: by 2002:a05:6a00:2d17:b0:77f:2ab3:32d0 with SMTP id d2e1a72fcca58-780fcf2b244mr1725792b3a.31.1758755771359;
        Wed, 24 Sep 2025 16:16:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGK+h3lxJXotwXTLjn/aR6VhV04QOP4VcWsMHUcC289RH0bPqdKd2aFMk23rLgsGPkgOkiIbg==
X-Received: by 2002:a05:6a00:2d17:b0:77f:2ab3:32d0 with SMTP id d2e1a72fcca58-780fcf2b244mr1725760b3a.31.1758755770834;
        Wed, 24 Sep 2025 16:16:10 -0700 (PDT)
Received: from hu-jingyw-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78102c27686sm144845b3a.96.2025.09.24.16.16.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 16:16:10 -0700 (PDT)
From: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Date: Wed, 24 Sep 2025 16:16:03 -0700
Subject: [PATCH 1/2] dt-bindings: pinctrl: describe Kaanapali TLMM
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250924-knp-tlmm-v1-1-acabb59ae48c@oss.qualcomm.com>
References: <20250924-knp-tlmm-v1-0-acabb59ae48c@oss.qualcomm.com>
In-Reply-To: <20250924-knp-tlmm-v1-0-acabb59ae48c@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jingyi Wang <jingyi.wang@oss.qualcomm.com>, aiqun.yu@oss.qualcomm.com,
        tingwei.zhang@oss.qualcomm.com, trilok.soni@oss.qualcomm.com,
        yijie.yang@oss.qualcomm.com
X-Mailer: b4 0.15-dev-99b12
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758755768; l=5482;
 i=jingyi.wang@oss.qualcomm.com; s=20250911; h=from:subject:message-id;
 bh=xGmmn6FH30g7INYIt0TMFP6e87l2yakTWhyZU6ZF4fY=;
 b=xVEiFV9W72JVMct6eBYTnv1Fp76+MGyAZOLepvPLJFISjNFHOZKDqrQQrLcZ5mDHco+Nw0suU
 nozuv1rKEbgAHDzGy6t83cuCQhBpyN41m6UAWqEn5k2vjJUCLRCt3Ve
X-Developer-Key: i=jingyi.wang@oss.qualcomm.com; a=ed25519;
 pk=PSoHZ6KbUss3IW8FPRVMHMK0Jkkr/jV347mBYJO3iLo=
X-Authority-Analysis: v=2.4 cv=KNxaDEFo c=1 sm=1 tr=0 ts=68d47bbc cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8
 a=RS--hHaVoNrYE_hnkMsA:9 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-GUID: 159g8lSokMtgtdccHkSyEu86nt96np2x
X-Proofpoint-ORIG-GUID: 159g8lSokMtgtdccHkSyEu86nt96np2x
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIzMDEzOCBTYWx0ZWRfX0VJ/7KTWqMO8
 j4OyCDDVzCzwWCoNcrnTWli8Rt1f1pQQqKmVXPwL7aD44y1lNoxTyoaNp2Gv3b/B9LfanJNrYfj
 J7LsB8c+8XVcWA58fngYHNPshg5rsibYOtkxxOPkTPsbE0EAlZTF4Cg6uQuAKeJGjK/TnDNuOO7
 xXhD5BV8LK0T1pL/fX+Xq9y/hdnn9RIUscONYK1J9icW7ozTdlvGCHkFTmzzvUVhoa0R9nLoI6x
 RIaEL75nhHKdOOC51XN6JuwEtEzM3w6a9vA0Vzso56ZHkTQucsRGTNrzGNXHpRVR1eyLZtBZI6V
 XnSADUlxHvur0D9iUqTAtmunVRAajG5UpBj2Ij2Hia1STfpdlC2F/One154Ol5Erixsgqga6Z0o
 Ut8/G7iE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 clxscore=1015 phishscore=0 suspectscore=0
 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509230138

The Top Level Mode Multiplexer (TLMM) in the Kaanapali SoC provide GPIO and
pinctrl functionality for UFS, SDC and 217 GPIO pins.

Add a DeviceTree binding to describe the Kaanapali TLMM block.

Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
---
 .../bindings/pinctrl/qcom,kaanapali-tlmm.yaml      | 127 +++++++++++++++++++++
 1 file changed, 127 insertions(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,kaanapali-tlmm.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,kaanapali-tlmm.yaml
new file mode 100644
index 000000000000..53534a07a1f0
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,kaanapali-tlmm.yaml
@@ -0,0 +1,127 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pinctrl/qcom,kaanapali-tlmm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Technologies, Inc. Kaanapali TLMM block
+
+maintainers:
+  - Jingyi Wang <jingyi.wang@oss.qualcomm.com>
+
+description:
+  Top Level Mode Multiplexer pin controller in Qualcomm Kaanapali SoC.
+
+allOf:
+  - $ref: /schemas/pinctrl/qcom,tlmm-common.yaml#
+
+properties:
+  compatible:
+    const: qcom,kaanapali-tlmm
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  gpio-reserved-ranges:
+    minItems: 1
+    maxItems: 109
+
+  gpio-line-names:
+    maxItems: 217
+
+patternProperties:
+  "-state$":
+    oneOf:
+      - $ref: "#/$defs/qcom-kaanapali-tlmm-state"
+      - patternProperties:
+          "-pins$":
+            $ref: "#/$defs/qcom-kaanapali-tlmm-state"
+        additionalProperties: false
+
+$defs:
+  qcom-kaanapali-tlmm-state:
+    type: object
+    description:
+      Pinctrl node's client devices use subnodes for desired pin configuration.
+      Client device subnodes use below standard properties.
+    $ref: qcom,tlmm-common.yaml#/$defs/qcom-tlmm-state
+    unevaluatedProperties: false
+
+    properties:
+      pins:
+        description:
+          List of gpio pins affected by the properties specified in this
+          subnode.
+        items:
+          oneOf:
+            - pattern: "^gpio([0-9]|[1-9][0-9]|1[0-9][0-9]|20[0-9]|21[0-6])$"
+            - enum: [ ufs_reset, sdc2_clk, sdc2_cmd, sdc2_data ]
+        minItems: 1
+        maxItems: 36
+
+      function:
+        description:
+          Specify the alternative function to be configured for the specified
+          pins.
+        enum: [ gpio, aoss_cti, atest_char, atest_usb, audio_ext_mclk0,
+                audio_ext_mclk1, audio_ref_clk, cam_asc_mclk2, cam_asc_mclk4,
+                cam_mclk, cci_async_in, cci_i2c_scl, cci_i2c_sda, cci_timer,
+                cmu_rng, coex_uart1_rx, coex_uart1_tx, coex_uart2_rx,
+                coex_uart2_tx, dbg_out_clk, ddr_bist_complete, ddr_bist_fail,
+                ddr_bist_start, ddr_bist_stop, ddr_pxi0, ddr_pxi1, ddr_pxi2,
+                ddr_pxi3, dp_hot, egpio, gcc_gp1, gcc_gp2, gcc_gp3, gnss_adc0,
+                gnss_adc1, i2chub0_se0, i2chub0_se1, i2chub0_se2, i2chub0_se3,
+                i2chub0_se4, i2s0_data0, i2s0_data1, i2s0_sck, i2s0_ws,
+                i2s1_data0, i2s1_data1, i2s1_sck, i2s1_ws, ibi_i3c, jitter_bist,
+                mdp_esync0_out, mdp_esync1_out, mdp_vsync, mdp_vsync0_out,
+                mdp_vsync1_out, mdp_vsync2_out, mdp_vsync3_out, mdp_vsync5_out,
+                mdp_vsync_e, nav_gpio0, nav_gpio1, nav_gpio2, nav_gpio3,
+                pcie0_clk_req_n, phase_flag, pll_bist_sync, pll_clk_aux,
+                prng_rosc0, prng_rosc1, prng_rosc2, prng_rosc3, qdss_cti,
+                qdss_gpio_traceclk, qdss_gpio_tracectl, qdss_gpio_tracedata,
+                qlink_big_enable, qlink_big_request, qlink_little_enable,
+                qlink_little_request, qlink_wmss, qspi0, qspi1, qspi2, qspi3,
+                qspi_clk, qspi_cs, qup1_se0, qup1_se1, qup1_se2, qup1_se3,
+                qup1_se4, qup1_se5, qup1_se6, qup1_se7, qup2_se0, qup2_se1,
+                qup2_se2, qup2_se3, qup2_se4, qup3_se0, qup3_se1, qup3_se2,
+                qup3_se3, qup3_se4, qup3_se5, qup4_se0, qup4_se1, qup4_se2,
+                qup4_se3, qup4_se4, sd_write_protect, sdc40, sdc41, sdc42, sdc43,
+                sdc4_clk, sdc4_cmd, sys_throttle, tb_trig_sdc2, tb_trig_sdc4,
+                tmess_prng0, tmess_prng1, tmess_prng2, tmess_prng3, tsense_pwm1,
+                tsense_pwm2, tsense_pwm3, tsense_pwm4, tsense_pwm5, tsense_pwm6,
+                tsense_pwm7, uim0_clk, uim0_data, uim0_present, uim0_reset, uim1_clk,
+                uim1_data, uim1_present, uim1_reset, usb0_hs, usb_phy, vfr_0, vfr_1,
+                vsense_trigger_mirnat, wcn_sw, wcn_sw_ctrl ]
+
+    required:
+      - pins
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    tlmm: pinctrl@f100000 {
+        compatible = "qcom,kaanapali-tlmm";
+        reg = <0x0f100000 0x300000>;
+        interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
+        gpio-controller;
+        #gpio-cells = <2>;
+        gpio-ranges = <&tlmm 0 0 218>;
+        interrupt-controller;
+        #interrupt-cells = <2>;
+
+        qup-uart7-state {
+          pins = "gpio62", "gpio63";
+          function = "qup1_se7";
+        };
+    };
+...

-- 
2.25.1


