Return-Path: <linux-kernel+bounces-733801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F61CB0794B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 17:14:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EAAE1C44628
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 15:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34929288CAF;
	Wed, 16 Jul 2025 15:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="d7L3Zb74"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53CC2882A0
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 15:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752678526; cv=none; b=fGmbg5+joBW+/zFjxCRC39KCthT8pYbpzDFkTtrCUgoMXRigXJ1o8+/BUlZkYB1Hrm+KadSPG/ceNzvxdRmkmciF1t6o2WrKVL+4fiaXX0T/cPp4dC6wQOSi7D1LNJva+XQMxdDs/KvusC9YV/inSNtgo6qr0uMRQ902HEM6HlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752678526; c=relaxed/simple;
	bh=ihxEo3F2oGvFSAfvy9ZRtQwJhHZpLy2gs3SPOW/Vg24=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=B1Wvjcfvwqme9rvTFNm71sYv6UUonQPSwW31GpiSCFZXao49UK896AJ018G4GbHYTJNPUuEJWq1L2H9GjGvaFx3tAFyBMgvSeoF0zTXTwB9xaoTTBuJ7xXfhB63VYlfvxFvdZrLWHM+FV+7XjCw85vF+FEwSsiVfrgftUpJG85M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=d7L3Zb74; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56GD2eP7023598
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 15:08:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=N+5ZTCNwIsI
	AtPOS8xEDMk0BGYkhezLOgVzMiDvz2cI=; b=d7L3Zb74R+E8dDbj5BIdkz6/YZK
	SiTaWum/J2dhO4C9kcC9KH5UkgSWZJ/WAfuX2mW2E7ouVz7arhfVUOB/gttY5XjE
	nFXQLSsltQh7HS9VT5jtKJZfIPy/U/mAGiVGs17tWeDTn6zSN1gwCL/kdNCMRYoe
	WJDQHPzTwDilJqv+vc93WqjhHCaqnP7pK/qYFrMNyL+gTG8hvYZyuZe+TagaQPi+
	i1CwbFCb3hdorwRoQ1CbZGKXRTSmrCybGvQzeR+HBzLooYGvUcMDqoefTRotXZTc
	3lEHXnkjKaD1crdmKzSGcHxz5T4jikCtdHxtDMICxvgcY0bCbYvVMK/DR8w==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47wkrun5xg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 15:08:44 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b38fc4d8dbaso8055680a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 08:08:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752678523; x=1753283323;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N+5ZTCNwIsIAtPOS8xEDMk0BGYkhezLOgVzMiDvz2cI=;
        b=ZqLpEONmgCgy/B0jYbxQaFaU5xGQgs5VVmrDeVAtYHsBaMwm92/yHtP40WT/GWcd1b
         Z8f0IY+P1jVfaCMJkBA1R8buZNp5OSjNo+5p+ZPigpYxNhlvLhKz4X7kbBw4ioCURTnk
         sI/Rr0AQ0E3578B6Glz+P2naWtfoZbCyolcp6YIdxjCEalG65KFhb89IWWB5d4cN0Rav
         joIIypp0igantGhjw+MUSRhgfXt41cpMlHyMkBgQB7EV6cicWWHw9rOFWtE3Qpvr1sbq
         aupb1NQeZBXY6CIElxFgIyWaEh5cQjd+KkFZV9ErXVwgXk6t02pOApyc9JQsbLljmg7j
         H9+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWu5s8CbZLeF1Cj7IEw+3h7vsZbAQkGSBvMhhBuZK8dcCo2AohU1wMT/FaEAnhxaaej0l7WBwfxshfuEFo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzw2444h4YbFsIJ2IDjSCH5szGz/mX6/nhXgfKtiwIUWR/9vZo7
	h+ZrRfxemetr2JotBOR+Hy9EC36vv4CT1jasewP50UUYr1TZaeeRTj8V+cGpbWQ78sOkELjc8qn
	b95z/8QRLI5D2WvBr94Mo1CLjF9YnkovcSzn9K60cF8LNNvru+dfJ3h+h+yQCS+kbLm4=
X-Gm-Gg: ASbGncsJkrxkM9qnxQHzkvZKPDj2gchhqg8mFUdTE4pdTX3yV/p34Kzg7Vd6jMvh05h
	WyQ+P1Qpe4GNS1WfT/nQIDvWCm4bLwYBng533QavoWaiQ1M3DHKmSH2/1i9X6Pcu+bkNkf18E7i
	f9Y6CjKMHj+xaIcvwq1ZYoj0XVVDNZsKZz1tIe8iV5bxozYxSO/3btHAxjmSUqc6iKbX8MBAtmh
	+nfPwrPmLK6I7bmJPUWGvzao7QVIotJOi6xlEQnKmo4OPAzVi46OCHBxtwpjq4MhWD8T34zE3P6
	zRDxnFAC63dwL11tqjDSNevmFwxdk7AiE4RP+IKBhLO1ZRcoNnF9ETzciI0T6Tfm3ub6CHsBf3s
	jEteqmkKgd4oEtuCrh2MA7BHE1MXw5mst4uuDkDeuJN1pqqZkX9dOZXsfZi1b
X-Received: by 2002:a05:6a20:a109:b0:232:1668:849f with SMTP id adf61e73a8af0-2381376841bmr4817149637.38.1752678522951;
        Wed, 16 Jul 2025 08:08:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFGHNJXAOaeNOjSazGKGjs4TDK6pDqSGhXNbcwlHJ7ti5SgNtEhaR5S1i9hxf7bO4tF7J+uzA==
X-Received: by 2002:a05:6a20:a109:b0:232:1668:849f with SMTP id adf61e73a8af0-2381376841bmr4817106637.38.1752678522532;
        Wed, 16 Jul 2025 08:08:42 -0700 (PDT)
Received: from hu-pankpati-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3bbe6f56a9sm13713112a12.59.2025.07.16.08.08.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 08:08:42 -0700 (PDT)
From: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
To: andersson@kernel.org, linus.walleij@linaro.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, quic_rjendra@quicinc.com
Cc: linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: pinctrl: qcom: Add Glymur pinctrl bindings
Date: Wed, 16 Jul 2025 20:38:21 +0530
Message-Id: <20250716150822.4039250-2-pankaj.patil@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250716150822.4039250-1-pankaj.patil@oss.qualcomm.com>
References: <20250716150822.4039250-1-pankaj.patil@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: PZaud_5M7QtpPZ2hwvhsSgzJEjEyjjeI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE2MDEzNiBTYWx0ZWRfX23XImjodvloL
 3LMbtdm1evkmf7LSTFPaiYLXRaJ3SrsGoQksOkYrYTeH7g8/Bpts/8W1t/pP6zGLSbE2a2IdurY
 9KG3EWccCy+SP/XeZ5gjazBRsFJf8bBKOHgR0vHVzeva0RezgmP5gCIBiuF0+sB54UhxUe+c8BL
 DRhlMshIn9N9J3iS+4DGrtdfVdOnb/fW+MLurmzJWA+1jC1pwciPvHXcfxrXFmv/3Gytyh0eE1A
 tB7txbv9u8qa+24polaykhR1W9b4cVtHiySdongw+uIKcdt80lpbwiRGdWhJ0TkVCe01zkRpljy
 4ClSlJhVd154jGQf64vlVzBNeXpXMYonEq1kK3Idx/gLULKG+Qluqb1ttTU4Sx77kU118ZecyPv
 jI46xpSIDiq8o/NW9KbgcJYkSIpkcR/OybY5dIICfUfdA8yUO0AUVEDTzfepOvmaz1+hiE7E
X-Authority-Analysis: v=2.4 cv=WqUrMcfv c=1 sm=1 tr=0 ts=6877c07c cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=Wb1JkmetP80A:10 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8 a=u--hiq7dTte3EtGYD-cA:9
 a=_Vgx9l1VpLgwpw_dHYaR:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-ORIG-GUID: PZaud_5M7QtpPZ2hwvhsSgzJEjEyjjeI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-16_02,2025-07-16_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 adultscore=0 priorityscore=1501 impostorscore=0 clxscore=1011
 lowpriorityscore=0 malwarescore=0 spamscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507160136

Add DeviceTree binding for Glymur SoC TLMM block

Signed-off-by: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
---
 .../bindings/pinctrl/qcom,glymur-tlmm.yaml    | 128 ++++++++++++++++++
 1 file changed, 128 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,glymur-tlmm.yaml

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,glymur-tlmm.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,glymur-tlmm.yaml
new file mode 100644
index 000000000000..d767a6f5b5b5
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,glymur-tlmm.yaml
@@ -0,0 +1,128 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pinctrl/qcom,glymur-tlmm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Technologies, Inc. Glymur TLMM block
+
+maintainers:
+  - Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
+
+description:
+  Top Level Mode Multiplexer pin controller in Qualcomm Glymur SoC.
+
+allOf:
+  - $ref: /schemas/pinctrl/qcom,tlmm-common.yaml#
+
+properties:
+  compatible:
+    const: qcom,glymur-tlmm
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  gpio-reserved-ranges:
+    minItems: 1
+    maxItems: 119
+
+  gpio-line-names:
+    maxItems: 238
+
+patternProperties:
+  "-state$":
+    oneOf:
+      - $ref: "#/$defs/qcom-glymur-tlmm-state"
+      - patternProperties:
+          "-pins$":
+            $ref: "#/$defs/qcom-glymur-tlmm-state"
+        additionalProperties: false
+
+$defs:
+  qcom-glymur-tlmm-state:
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
+            - pattern: "^gpio([0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9])$"
+            - enum: [ ufs_reset, sdc2_clk, sdc2_cmd, sdc2_data ]
+        minItems: 1
+        maxItems: 36
+
+      function:
+        description:
+          Specify the alternative function to be configured for the specified
+          pins.
+        enum: [ gpio, RESOUT_GPIO_N, aoss_cti, asc_cci, atest_char, atest_usb, audio_ext_mclk0,
+                audio_ext_mclk1, audio_ref_clk, cam_asc_mclk4, cam_mclk, cci_async_in, cci_i2c_scl,
+                cci_i2c_sda, cci_timer, cmu_rng, cri_trng, dbg_out_clk, ddr_bist_complete,
+                ddr_bist_fail, ddr_bist_start, ddr_bist_stop, ddr_pxi, edp0_hot, edp0_lcd,
+                edp1_lcd, egpio, eusb0_ac_en, eusb1_ac_en, eusb2_ac_en, eusb3_ac_en, eusb5_ac_en,
+                eusb6_ac_en, gcc_gp1, gcc_gp2, gcc_gp3, host2wlan_sol, i2c0_s_scl, i2c0_s_sda,
+                i2s0_data, i2s0_sck, i2s0_ws, i2s1_data, i2s1_sck, i2s1_ws, ibi_i3c, jitter_bist,
+                mdp_vsync_out, mdp_vsync_e, mdp_vsync_p, mdp_vsync_s, pcie3a_clk, pcie3a_rst_n,
+                pcie3b_clk, pcie4_clk_req_n, pcie5_clk_req_n, pcie6_clk_req_n, phase_flag,
+                pll_bist_sync, pll_clk_aux, pmc_oca_n, pmc_uva_n, prng_rosc, qdss_cti, qdss_gpio,
+                qspi, qup0_se0, qup0_se1, qup0_se2, qup0_se3_l0, qup0_se3, qup0_se4, qup0_se5,
+                qup0_se6, qup0_se7, qup1_se0, qup1_se1, qup1_se2, qup1_se3, qup1_se4, qup1_se5,
+                qup1_se6, qup1_se7, qup2_se0, qup2_se1, qup2_se2, qup2_se3, qup2_se4, qup2_se5,
+                qup2_se6, qup2_se7, qup3_se0, qup3_se1, sd_write_protect, sdc4_clk,
+                sdc4_cmd, sdc4_data, smb_acok_n, sys_throttle, tb_trig_sdc2, tb_trig_sdc4,
+                tmess_prng, tsense_pwm, tsense_therm, usb0_dp, usb0_phy_ps, usb0_sbrx, usb0_sbtx,
+                usb0_tmu, usb1_dbg, usb1_dp, usb1_phy_ps, usb1_sbrx, usb1_sbtx, usb1_tmu, usb2_dp,
+                usb2_phy_ps, usb2_sbrx, usb2_sbtx, usb2_tmu, vsense_trigger_mirnat, wcn_sw,
+                wcn_sw_ctrl ]
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
+    tlmm: pinctrl@f100000 {
+        compatible = "qcom,glymur-tlmm";
+        reg = <0 0x0f100000 0 0xf00000>;
+        interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
+        gpio-controller;
+        #gpio-cells = <2>;
+        interrupt-controller;
+        #interrupt-cells = <2>;
+        gpio-ranges = <&tlmm 0 0 249>;
+        wakeup-parent = <&pdc>;
+        gpio-reserved-ranges = <4 4>, <10 2>, <33 3>, <44 4>;
+        qup_uart21_default: qup-uart21-default-state {
+          tx-pins {
+            pins = "gpio86";
+            function = "qup2_se5";
+            drive-strength = <2>;
+            bias-disable;
+          };
+
+          rx-pins {
+            pins = "gpio87";
+            function = "qup2_se5";
+            drive-strength = <2>;
+            bias-disable;
+          };
+        };
+    };
+...
-- 
2.34.1


