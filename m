Return-Path: <linux-kernel+bounces-768309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 72331B25F9C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 10:53:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E66527B01F1
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 08:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FBDE2E9EDF;
	Thu, 14 Aug 2025 08:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eN+XB0Nb"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2934A2741CD
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 08:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755161578; cv=none; b=MTUhygFnMfPzrFOfs5foOE63P9Et6J3di1G6imRJ87JNiSNRsnpFsCf6XKugVEburpqsHHe7Hq4AkTg2PZMY1PmrgMhZ75OClTd67AMKspCa8M8B76hY8LIL+mXn1Hut2xHu78227a0VDd+94e+WGjzSKIiqARGoAuETKzyvRfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755161578; c=relaxed/simple;
	bh=VO/XqcSD3T9bRV+GvDZsTJwOmB/gxlb+z0LFlAiA8e0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LHRMPgNu+qxJaUGCiIJIj9KD56UPNryYIV8CR8UXXA6vzT6thNQOZETfTi5jsqTXi9zbeJOrRi73///JlFLnR99XqRVFaOyq1LemgEkbKs/RNrrJ7hwOqYRixe5hBBzMQ+6mO2xAzlg3Y/HEAH/jDFl7vKHEdO0ZKsMOmjz/Evk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eN+XB0Nb; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57DMDOqh027018
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 08:52:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=YY+jHz5mvoy
	usButmdCoBF7o4RYZY+zFj5xw1jAtys8=; b=eN+XB0NbGXEBozjN5tXDEXR0wqs
	JiKBUy1t13SE0cnKS57IBBocZOxP0TjO4DsTvkUSSkpTq+VKwvSnIzlO36QRAe0l
	eJuFfIapVJ96IR4/QjvRCT7s4Brzsvx6yNjSVaAr6rtzHktdQm1v1FI8Lz2jOIuM
	yxdYf/fLvpym3BKuxWBFr7AHMUsxZFs9hk1pheD/DVtJd5VrszrxMV1abD8eE8wj
	p0uCsMaAIsRJCtDmUem0RKJL/BgOzn6hTRkHmcpShVjSiCOrhIyTn6cX16KseLZx
	E78dSLWdTRAeo3F6WJhUOTd9cRAqSSMbZ5jbZCrYfwVxb1tooRpXtn29+Cg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ffhjtv49-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 08:52:55 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7e87069063aso269334885a.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 01:52:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755161575; x=1755766375;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YY+jHz5mvoyusButmdCoBF7o4RYZY+zFj5xw1jAtys8=;
        b=nwEk5NFcwhJJbp21pVMfOX75fdtRNBrd1FOOHphlS4DgvTTmWAnTB87nAQ1b3Dcfb+
         4Rm4C04IMu9wagbjqG0l5POsrA13eey+IT4ObBvVQQd0f+KKmkbifJms05+L1kXPzx3X
         ftUj3qjEM+zlwzO8qjSR3ZXjDJJbtLw8wAx+M/LUXbNZ0wzuOi297WH94Yg4mmObCiK0
         gq4KSR/uINC2LhhT0mxV6q0QCdClhqdgpy0ngj5/xb29DGsRa0Ywc8BC+AdmEHga2L01
         6+0Id17tiaCaalqLbYQjDw3v+exgnJyqG+28Td1d8BNWeYfzqnD00fAWzp73/vFPWACC
         diYA==
X-Forwarded-Encrypted: i=1; AJvYcCUI+X++RlZyKQKZ+H7ONoQWhU1YdrrXOlyXoItSsbb2gcbGcbo5pKLlXSTlXUzKRRoaypMFpeQm6+oVxGk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhmKz2028xaab79lkvocZEd1fvD4sh8hNsPioUfj+Vf3pZEe7P
	9BivkEKFnMNvipAoUXGL5ta+4v6lTkA1QYlcLTvjGe+sc199O/4QIXLNFnl3VO0jrP+rgHZWruz
	vHVzzaXntDm5iQgNXLwezTTr6ni3sBAvvoQmVPuULS2sFEl6S/QdFkkrO2oujs5Mrqy8=
X-Gm-Gg: ASbGncuuqSFGwWIQAy3y3SM91AK55wlenWLqWzKQk9eFrIxwQiMt6RZH3sBtDZtpVyl
	Dowlu6d2UG5tZecUIECVdCW2K/zAwx4nnMQeIZFyP4nntGL9/IuQzCfSeYcDXUi79FZPuqxfK+F
	NeBo4SQXrWzYck/Gq+91EPAbJwCy2S9OehAAOme2HgWPH6Ksoyd8LPVHIp9mw7z6NOsfF0kudqz
	O7cvRTJFc0Vj1kBFQ5/yo2k0cTbkvcOhILMW2h7HyxUGNLwdw/zLVY8SJ1/kG8Yt3aczOnbKPW0
	9t0nzp7eKhRtQOLU2iGLtLd+snfT3J6vaOz5YV+h65tqVmMk2oPpsCx6OP0bwzRpCuO81aGSM+f
	yLBRMefAYOc3B
X-Received: by 2002:a05:620a:44c5:b0:7e8:5f66:b2e0 with SMTP id af79cd13be357-7e8700cdd31mr328932585a.0.1755161574943;
        Thu, 14 Aug 2025 01:52:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHh38wOcsdNJkvL4KisYWyGtxcxEIxXog8BCbgZ1oRBY00G/LSJD7ZoVbRkvJslRPMiyE1swQ==
X-Received: by 2002:a05:620a:44c5:b0:7e8:5f66:b2e0 with SMTP id af79cd13be357-7e8700cdd31mr328929085a.0.1755161574312;
        Thu, 14 Aug 2025 01:52:54 -0700 (PDT)
Received: from trex.. (205.red-83-60-94.dynamicip.rima-tde.net. [83.60.94.205])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a1c6bc93fsm13155895e9.2.2025.08.14.01.52.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 01:52:53 -0700 (PDT)
From: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
To: jorge.ramirez@oss.qualcomm.com, quic_vgarodia@quicinc.com,
        quic_dikshita@quicinc.com, bryan.odonoghue@linaro.org,
        mchehab@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, andersson@kernel.org, konradybcio@kernel.org
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v10 1/8] media: dt-bindings: venus: Add qcm2290 dt schema
Date: Thu, 14 Aug 2025 10:52:41 +0200
Message-Id: <20250814085248.2371130-2-jorge.ramirez@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250814085248.2371130-1-jorge.ramirez@oss.qualcomm.com>
References: <20250814085248.2371130-1-jorge.ramirez@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDA3NCBTYWx0ZWRfX49HHWEnMOBLv
 OO3IjKqTMgdh0q2skT6ee0SUIV+V2Vtnu+kaBd93D8I3SzF5H1KQlfpICCjoZqGfbQgeCIuEu1A
 Bb4tXuPz37F95vN9kNBFOhDlKuZ2b2RpWfVemhCB2fbqtCSnsinDpnNYtOC3MjmuMdvQpGBsqXg
 2Z2v8BYOoiPhJCokAufGZTGrPcZF8wv2pnwqo28SvtK1bDxJkv1n28b/diqrdV4GrycyiHGo0TM
 H9KL3jVPjXTIFCMe4/k3ovRtoBvNKQXqApGbm1OFnIPLx5jVrsdtI1G2fvb/4i5IFsr9g/Ecxku
 HzDFOG2mvM7YM59RPE67IAIwt1EKrRqucfksCpbWDixhmB1CydLtQ8v7ftcSYRtvNzPYVVhNwAq
 mkjNsDgr
X-Proofpoint-GUID: 83l3bVVmoyeTpHe7PYOsCozPpHvPQbwn
X-Authority-Analysis: v=2.4 cv=TJFFS0la c=1 sm=1 tr=0 ts=689da3e7 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=Rr2dNH5/fcnoRoBmcVUeRg==:17
 a=2OwXVqhp2XgA:10 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8
 a=Wl4eHCndyL1IYbKsAYUA:9 a=NFOGd7dJGGMPyQGDc5-O:22 a=sptkURWiP4Gy88Gu7hUp:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: 83l3bVVmoyeTpHe7PYOsCozPpHvPQbwn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-13_02,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 adultscore=0 impostorscore=0 malwarescore=0
 phishscore=0 clxscore=1015 spamscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508110074

Add a schema for the venus video encoder/decoder on the qcm2290.

The order of the IOMMU list is strict: the first two entries correspond
to non-secure IOMMUs, and the remaining three to secure IOMMUs.

Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 .../bindings/media/qcom,qcm2290-venus.yaml    | 130 ++++++++++++++++++
 1 file changed, 130 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/qcom,qcm2290-venus.yaml

diff --git a/Documentation/devicetree/bindings/media/qcom,qcm2290-venus.yaml b/Documentation/devicetree/bindings/media/qcom,qcm2290-venus.yaml
new file mode 100644
index 000000000000..3f3ee82fc878
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/qcom,qcm2290-venus.yaml
@@ -0,0 +1,130 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/media/qcom,qcm2290-venus.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm QCM2290 Venus video encode and decode accelerators
+
+maintainers:
+  - Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
+
+description:
+  The Venus AR50_LITE IP is a video encode and decode accelerator present
+  on Qualcomm platforms.
+
+allOf:
+  - $ref: qcom,venus-common.yaml#
+
+properties:
+  compatible:
+    const: qcom,qcm2290-venus
+
+  power-domains:
+    maxItems: 3
+
+  power-domain-names:
+    items:
+      - const: venus
+      - const: vcodec0
+      - const: cx
+
+  clocks:
+    maxItems: 6
+
+  clock-names:
+    items:
+      - const: core
+      - const: iface
+      - const: bus
+      - const: throttle
+      - const: vcodec0_core
+      - const: vcodec0_bus
+
+  iommus:
+    maxItems: 5
+
+  interconnects:
+    maxItems: 2
+
+  interconnect-names:
+    items:
+      - const: video-mem
+      - const: cpu-cfg
+
+  operating-points-v2: true
+  opp-table:
+    type: object
+
+required:
+  - compatible
+  - power-domain-names
+  - iommus
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,gcc-qcm2290.h>
+    #include <dt-bindings/interconnect/qcom,qcm2290.h>
+    #include <dt-bindings/interconnect/qcom,rpm-icc.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/power/qcom-rpmpd.h>
+
+    venus: video-codec@5a00000 {
+        compatible = "qcom,qcm2290-venus";
+        reg = <0x5a00000 0xf0000>;
+
+        interrupts = <GIC_SPI 225 IRQ_TYPE_LEVEL_HIGH>;
+
+        power-domains = <&gcc GCC_VENUS_GDSC>,
+                        <&gcc GCC_VCODEC0_GDSC>,
+                        <&rpmpd QCM2290_VDDCX>;
+        power-domain-names = "venus",
+                             "vcodec0",
+                             "cx";
+
+        operating-points-v2 = <&venus_opp_table>;
+
+        clocks = <&gcc GCC_VIDEO_VENUS_CTL_CLK>,
+                 <&gcc GCC_VIDEO_AHB_CLK>,
+                 <&gcc GCC_VENUS_CTL_AXI_CLK>,
+                 <&gcc GCC_VIDEO_THROTTLE_CORE_CLK>,
+                 <&gcc GCC_VIDEO_VCODEC0_SYS_CLK>,
+                 <&gcc GCC_VCODEC0_AXI_CLK>;
+        clock-names = "core",
+                       "iface",
+                       "bus",
+                       "throttle",
+                       "vcodec0_core",
+                       "vcodec0_bus";
+
+        memory-region = <&pil_video_mem>;
+
+        iommus = <&apps_smmu 0x860 0x0>,
+                 <&apps_smmu 0x880 0x0>,
+                 <&apps_smmu 0x861 0x04>,
+                 <&apps_smmu 0x863 0x0>,
+                 <&apps_smmu 0x804 0xe0>;
+
+        interconnects = <&mmnrt_virt MASTER_VIDEO_P0 RPM_ALWAYS_TAG
+                         &bimc SLAVE_EBI1 RPM_ALWAYS_TAG>,
+                        <&bimc MASTER_APPSS_PROC RPM_ACTIVE_TAG
+                         &config_noc SLAVE_VENUS_CFG RPM_ACTIVE_TAG>;
+        interconnect-names = "video-mem",
+                             "cpu-cfg";
+
+        venus_opp_table: opp-table {
+            compatible = "operating-points-v2";
+
+            opp-133333333 {
+                opp-hz = /bits/ 64 <133333333>;
+                required-opps = <&rpmpd_opp_low_svs>;
+            };
+
+            opp-240000000 {
+                opp-hz = /bits/ 64 <240000000>;
+                required-opps = <&rpmpd_opp_svs>;
+            };
+        };
+    };
-- 
2.34.1


