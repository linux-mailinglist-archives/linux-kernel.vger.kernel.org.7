Return-Path: <linux-kernel+bounces-742327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A06E9B0EFFF
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 12:37:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D323B5838EA
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 10:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABBDC2BE02F;
	Wed, 23 Jul 2025 10:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GfHpLglp"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E0082BD595
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 10:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753267030; cv=none; b=DT35sDYcNhlYJSgKWmAFHxEjkKcofxr1QACZydwaHYlSLiPAeSnAMdizBMybBnyQfIs9u8b+RihpZ/hgpv3NExMqkb+znRtL0DkTTJSpf2HmIr6pdhbj0Qqj66z9zalifPlj4iWiUoOhofPAMABh8kJyuVGoy9Ul9Plwfmc5LD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753267030; c=relaxed/simple;
	bh=LVNg2Q2O+pFfknd8M9tmBYGR3cuA1JPNjB0AsEwAFhw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eRJq5Rj0Jh6zn6mfr3Fnk2LiLYfj3h9AUre9tRYUfP9hP9oxFSFel9UTaAAs9g4xmccKADpxbXO+76Et2w0pJ64rJHwe1lme3j8HCA2vPtcsUTPBpNODrihgLbsOzBl1dP3k5sGV6g08rN9xdppA2MJGD89u8uuURVbfa+V2I88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GfHpLglp; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56N9FYO1026818
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 10:37:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=FlrT8Y+9FXC
	vRqpO942xG/ERKUUQGwNuz/enNNd3ois=; b=GfHpLglpyrHWWgxGAGKP/5hgj65
	MLPMW1CuW/NQMCU4Kgqw5Tk+etDDobJwA5ggBYwp2nP0YUx5x925T7EOZs01Y5VN
	VVwWsmY65eLZU2OCQzChBHACGuaVJWNUYEIDn7LH5KCiEj8SOa5eciL498qunwJg
	JCjZ9ekJ95tsk7oaJwWpnxCX+xy7tyCs1mLxwiloH/FFmfl74fRdrOtTayqtvs12
	wEEcxqYKWuH5FanydArTRKmm5j5QZzIcjOkRVZd70HUOz25dInmqfKHkB2IxnKfa
	jh5owvqBX2r9WGWPwg8gwUDMMEB6mCwj3uqOc/BbzIeuNPx0DwZevVvCidw==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48048s4u2t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 10:37:06 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b31f112c90aso705281a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 03:37:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753267026; x=1753871826;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FlrT8Y+9FXCvRqpO942xG/ERKUUQGwNuz/enNNd3ois=;
        b=sS+sev7AJ4kv0pCWpfoS/fOYoIxy7qEiwh9lQoi8rQuSEVJqlwzV2CtVYNw8Schlr5
         30uqEUAWyVvpNCtmh4XzVMC6Jh+JArKAmjYXWyYi4tOHbawvmSyIX3fqhNMQlXlnv4F/
         JDgcEDwW9PgGsxoarqFfFxuRqSaPliUvaRaqXRdj+QK6d32snTR45As5alOK77SDFmVv
         LdDOOEv+7RJCNHPGMiBxQNRLK5ieO5ymycL4+T+r18hybAvK5seOmgkzenl2MDKE8LIy
         4oiDiYhSBCcRWZKV36gJ2OS9NVAQKBQNC4hBwEWQ6MEhBxqVkiu/xhDnf7MMftxRgJUp
         CleQ==
X-Forwarded-Encrypted: i=1; AJvYcCX2SaeRFdntHat5V8x6jlDKDg1woFzW1pHGhNiiTwWVic6ps6RZ2uCjqamdczKkxP7Jpbi1EtndbK0tjh4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyu2QIRjwTuim5Ve4YhqYCjdh0mIfwdSnU6FEm5w93KqUmNLRSt
	RYRplql/Rl9QaaEz5y3MlsA0Z0bx8p5tRdYpB8Hxw8ZZFnBlgjKfGgEQJ8F+nkaL5EffIqqCDVa
	02Zy5qjhyrWSuO8gBuRZqxRSrjM8kJfka+dhQD3US016vn+LZ7bUhBveRh1jckp4VJlA=
X-Gm-Gg: ASbGncu779L4sAaDjQ5v4EHo4vZLVDwlTbObHCoXGrIspDd61H9UbaiRm3XfC+G6R/3
	xYphs1jMGX68UMeQnLAwOZxDQJE9jV/7IvcHihmoMwRR3UJuNi5eU+J/aAugR6craGZsu/GB5e3
	LfNNl9LudL0bypla3ULGgki8CumEWiQ4Dv7NnsLgjD8U6NluTHAh7MXi+9SzbDgIFGjcEmKgKpE
	J9XUHEHuldeLvq4y1un8oDW+uo2Ea2EVFE+gk5yxI/816btDFsPzFkJOUkuKhObvlfOY8FV8rKd
	RE18tDtHsDeenSkrpGKzVQpcnUUg3CDGQajw4f5vRlojgXXzPo6rUZi7XpunL2YoVLT4qDJYCDi
	5+/3tHPw4NH/lQi7LXPjeghCaftQv2OJhA88bIoFQ+vAlBQZCZy7O7PO/i9r+
X-Received: by 2002:a05:6300:6141:b0:238:351a:f95f with SMTP id adf61e73a8af0-23d48ead3b8mr3594464637.22.1753267025623;
        Wed, 23 Jul 2025 03:37:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE+STtEf2ZKozXNR0Q2hWZWs4URKYbpvEpcSQk8WkIj82o9SKmWQtKYke/Sx0wwkrPRzJMi+A==
X-Received: by 2002:a05:6300:6141:b0:238:351a:f95f with SMTP id adf61e73a8af0-23d48ead3b8mr3594422637.22.1753267025113;
        Wed, 23 Jul 2025 03:37:05 -0700 (PDT)
Received: from hu-pankpati-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-759cb678f21sm9458954b3a.104.2025.07.23.03.37.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 03:37:04 -0700 (PDT)
From: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
To: andersson@kernel.org, linus.walleij@linaro.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, quic_rjendra@quicinc.com
Cc: linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/2] dt-bindings: pinctrl: qcom: Add Glymur pinctrl bindings
Date: Wed, 23 Jul 2025 16:06:43 +0530
Message-Id: <20250723103644.4058213-2-pankaj.patil@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250723103644.4058213-1-pankaj.patil@oss.qualcomm.com>
References: <20250723103644.4058213-1-pankaj.patil@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIzMDA4OSBTYWx0ZWRfX2xgHFRKVUwqQ
 UhYeUqyFP/L7X7i22qINk0RY7cnKrv4Sx+OQjVjNZYxfAKrZn/SNBRszrl7jmYlMSvWMW3eZsrV
 KYlI1frmG9SitzyHBIv26KcR4c2WMBhaBhYOwwAQ1911ivzBW8u5MnUhnZxZjVZq0XY9zbey3CX
 T3r6pLI097+xIY10hqboVbUhvFap4UrFtxpfbFVkj1Knh5PTvFtm0ex5kx5bfnykZByZ4d/r69g
 rW98esG/iKyBl/LEfOdgBhrSBcWdAfTt+uXzrdON8zisjSFXWvZvPKvzopUtiYkoxFhCAl8B6ev
 9O/DEC7YUoImqLH7dpIVFi1NOEbJq8DN5QP+EItOcrrfRuig8MN5MW5aNuNuVY0eWxXlBQrnaLm
 29TjjadoWWkzYs7Usk9xhaiwho1olnitqgAenNNz+bzkGxkd0nZGz8Nmc1Y9V/NyPxjlotHr
X-Proofpoint-ORIG-GUID: KztZWwg4uF_zL_cZ0ueMCBkYw4V2c0n5
X-Proofpoint-GUID: KztZWwg4uF_zL_cZ0ueMCBkYw4V2c0n5
X-Authority-Analysis: v=2.4 cv=OPUn3TaB c=1 sm=1 tr=0 ts=6880bb53 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=Wb1JkmetP80A:10 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8 a=MZc3Y3F7moGl6OQG0A0A:9
 a=x9snwWr2DeNwDh03kgHS:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-23_02,2025-07-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 mlxlogscore=999 lowpriorityscore=0 suspectscore=0
 spamscore=0 mlxscore=0 bulkscore=0 priorityscore=1501 phishscore=0
 malwarescore=0 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507230089

Add DeviceTree binding for Glymur SoC TLMM block

Signed-off-by: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
---
Changes in v4:
Updated enum in bindings to line length of 80 char

Changes in v3:
Fixed indentation for example tlmm node

Changes in v2:
Updated gpio-line-names maxItems to 250
Fixed example node reg property
 .../bindings/pinctrl/qcom,glymur-tlmm.yaml    | 133 ++++++++++++++++++
 1 file changed, 133 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,glymur-tlmm.yaml

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,glymur-tlmm.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,glymur-tlmm.yaml
new file mode 100644
index 000000000000..38c360e77fa3
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,glymur-tlmm.yaml
@@ -0,0 +1,133 @@
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
+    maxItems: 250
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
+        enum: [ gpio, RESOUT_GPIO_N, aoss_cti, asc_cci, atest_char, atest_usb,
+                audio_ext_mclk0, audio_ext_mclk1, audio_ref_clk, cam_asc_mclk4,
+                cam_mclk, cci_async_in, cci_i2c_scl, cci_i2c_sda, cci_timer,
+                cmu_rng, cri_trng, dbg_out_clk, ddr_bist_complete,
+                ddr_bist_fail, ddr_bist_start, ddr_bist_stop, ddr_pxi,
+                edp0_hot, edp0_lcd, edp1_lcd, egpio, eusb0_ac_en, eusb1_ac_en,
+                eusb2_ac_en, eusb3_ac_en, eusb5_ac_en, eusb6_ac_en, gcc_gp1,
+                gcc_gp2, gcc_gp3, host2wlan_sol, i2c0_s_scl, i2c0_s_sda,
+                i2s0_data, i2s0_sck, i2s0_ws, i2s1_data, i2s1_sck, i2s1_ws,
+                ibi_i3c, jitter_bist, mdp_vsync_out, mdp_vsync_e, mdp_vsync_p,
+                mdp_vsync_s, pcie3a_clk, pcie3a_rst_n, pcie3b_clk,
+                pcie4_clk_req_n, pcie5_clk_req_n, pcie6_clk_req_n, phase_flag,
+                pll_bist_sync, pll_clk_aux, pmc_oca_n, pmc_uva_n, prng_rosc,
+                qdss_cti, qdss_gpio, qspi, qup0_se0, qup0_se1, qup0_se2,
+                qup0_se3_l0, qup0_se3, qup0_se4, qup0_se5, qup0_se6, qup0_se7,
+                qup1_se0, qup1_se1, qup1_se2, qup1_se3, qup1_se4, qup1_se5,
+                qup1_se6, qup1_se7, qup2_se0, qup2_se1, qup2_se2, qup2_se3,
+                qup2_se4, qup2_se5, qup2_se6, qup2_se7, qup3_se0, qup3_se1,
+                sd_write_protect, sdc4_clk, sdc4_cmd, sdc4_data, smb_acok_n,
+                sys_throttle, tb_trig_sdc2, tb_trig_sdc4, tmess_prng,
+                tsense_pwm, tsense_therm, usb0_dp, usb0_phy_ps, usb0_sbrx,
+                usb0_sbtx, usb0_tmu, usb1_dbg, usb1_dp, usb1_phy_ps, usb1_sbrx,
+                usb1_sbtx, usb1_tmu, usb2_dp, usb2_phy_ps, usb2_sbrx, usb2_sbtx,
+                usb2_tmu, vsense_trigger_mirnat, wcn_sw, wcn_sw_ctrl ]
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
+        reg = <0x0f100000 0xf00000>;
+        interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
+        gpio-controller;
+        #gpio-cells = <2>;
+        interrupt-controller;
+        #interrupt-cells = <2>;
+        gpio-ranges = <&tlmm 0 0 249>;
+        wakeup-parent = <&pdc>;
+        gpio-reserved-ranges = <4 4>, <10 2>, <33 3>, <44 4>;
+        qup_uart21_default: qup-uart21-default-state {
+            tx-pins {
+                pins = "gpio86";
+                function = "qup2_se5";
+                drive-strength = <2>;
+                bias-disable;
+            };
+
+            rx-pins {
+                pins = "gpio87";
+                function = "qup2_se5";
+                drive-strength = <2>;
+                bias-disable;
+            };
+        };
+    };
+...
-- 
2.34.1


