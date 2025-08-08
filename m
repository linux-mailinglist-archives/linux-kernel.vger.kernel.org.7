Return-Path: <linux-kernel+bounces-759957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D738FB1E4EE
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 10:54:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAEF858653A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 08:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 336A226B951;
	Fri,  8 Aug 2025 08:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QO2vVE+W"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C7EB26560A
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 08:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754643190; cv=none; b=F+8dxN4QonsIHA8//j9M/9rhlLYkjWgmdFz8UxAzlJP048Zy+KNwN6gk5/ODBglkmpQA2irHOtUYoDWfP1SQZBpoYk8qFKZ6esv5j5oBt2X9xAqrhqbNqV2OK3/l/AfBuHOLo6lRfpk3L0fMejrJ6Upbuyf6lAJRzLmUrFEfNPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754643190; c=relaxed/simple;
	bh=VO/XqcSD3T9bRV+GvDZsTJwOmB/gxlb+z0LFlAiA8e0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Qs5XmGuaUtC4VpQxF47qg6o/a21wNbZ7gf22o9TdBdaTffqQefvTKmXEKuL2yU65nr0tiUUsKyrLm1dSSyizERsq+9ah+sNJk63rk7WC39q4j0qiSvO5uKaSi61QJmtdCu+GpXIS6ZIyoAJWeHhOmfH+EcshDViBtnM7UHTMbfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QO2vVE+W; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5786ls8V003607
	for <linux-kernel@vger.kernel.org>; Fri, 8 Aug 2025 08:53:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=YY+jHz5mvoy
	usButmdCoBF7o4RYZY+zFj5xw1jAtys8=; b=QO2vVE+WImiB2QQHiDqCqsQQfy+
	RKEuhoNN0jAyOPrnDz8Bbg8+msNSO/P+LXXGqp+/OdweCQ4XPsA2X7FLB5C0Yjoj
	pdIgeFOBO1V45AFoqZJ7GeBliptt8tO1DkxWqByXoQl5xcycYSTZIy/jSkxdfZUC
	ofXaYIaVWYc3jrbUA37B7u6HszAHw7bMxcRXRFGSDqm3HuvUGDFJ+ChdS5Dtk1LM
	l5N4RfbW/IHeuur9/rp6eCrasfUITJkxCqbVqyYqzuzK706a31QqHeQo/y179cPt
	cJ4WvE9fKS8zzI5gjioaLAuSiLM+I/PxcGxX6PIRn+wgQp9drn20r+cB9Mg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48bpw01jpw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 08 Aug 2025 08:53:06 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4af1a20cbcfso47303311cf.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Aug 2025 01:53:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754643185; x=1755247985;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YY+jHz5mvoyusButmdCoBF7o4RYZY+zFj5xw1jAtys8=;
        b=GUBLieWk8gwcTq3XgKwAxbVn10CpBYlAfVfPn0/9H9b6eBTLbAY2MFNNYIjv7A10EC
         Ht50NouvRFfDVpa1l5nXPyoAD2jqCAwUALOft0vX3WY+VZsIYwgmjyhib2ffKvyj1f+R
         SUVaUKdX+OqWBQdF+p1m8hJp+SNMGVWe7GyIUirUk+eTsaRjqnjUusVjj3+YkAcZyZEw
         pUDSD9aZDKDcPkzueaOyVWtHi0rJVt9trVqjDMf9nMTexQGHUdaNMeSZyMWgkWeNpPIp
         EE2vlHN8qjBpIxmH57aoWtwWESJn0tu0vQn15kXTZwrZU0BB9aRQUXUhRWmO70xQhjSR
         kVsg==
X-Forwarded-Encrypted: i=1; AJvYcCXyuWiuu5B4bYUtb8aKhB/VO8lzSZ5xiT5cPYwcJ2AeTHNaRu4KBR7f3/2jVFFhTy3kEfmws0nl9TcuQzo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzD6f0HTBr6iFxbAkx+sQynqUVNBK2Xz5EmuH3IXdX4Zqk+JLT
	EapqHYQD1wbiKu1RZwXNZWphozMpf/nwQdSBYiGagfe66SGPwbZ0+ABCZY6S1mj99Nr1WslrBRK
	sFFc/RdDitXXB3j0Vg5euk9w3l2X9tHJT6pVa92nsnThFOCWTpD0uo5V2Y8L8G0Qi5T0vX7zC6k
	kb4w==
X-Gm-Gg: ASbGnctXGQPfCUrvLW+7kYDzJVdidyCaDrGuF20Yk0O/IA0SfZWYORSDr4otZCsAW46
	DMSF0ZMZUIL+nDjTgAoUlgrVWOcJJgWXlNw+owVVuQu+z9htJv/dYU8Tqov0WZLiyxVzkXHkJFu
	+yVimYWI4oOzrPtR6Wja+zvOSbQv1qJlVgVW0C6+sa+ceaFpQJgXDpy6TmDXR4BO8ESkpFT/J/j
	rYfAuiISVjzbLYQ9tCAG9/S6jhpjUAYiiAT3YdQTj7NRJIDnCItXPJy2piHrJ4LIvPLc8jRmnKx
	a2Hxfam3vf6zOJpiWteXvUctpxYK7RRkmIqujKJALkI917WL81LInOF5ne2HAQtBfZvJFl6lQkI
	5kqLLGINGS/2A
X-Received: by 2002:ac8:5a52:0:b0:4b0:71cb:5e2 with SMTP id d75a77b69052e-4b0aee53c93mr28851411cf.57.1754643185512;
        Fri, 08 Aug 2025 01:53:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFWE1wy483FvBMCB8gBXqvEqz7+Bjfkn4t+XKPgdXxmTF4S/YKJVwzhPdLQiJy08CuS7YtZ/w==
X-Received: by 2002:ac8:5a52:0:b0:4b0:71cb:5e2 with SMTP id d75a77b69052e-4b0aee53c93mr28851201cf.57.1754643185091;
        Fri, 08 Aug 2025 01:53:05 -0700 (PDT)
Received: from trex.. (205.red-83-60-94.dynamicip.rima-tde.net. [83.60.94.205])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459e5e99e04sm123818745e9.11.2025.08.08.01.53.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 01:53:04 -0700 (PDT)
From: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
To: jorge.ramirez@oss.qualcomm.com, quic_vgarodia@quicinc.com,
        quic_dikshita@quicinc.com, bryan.odonoghue@linaro.org,
        krzk+dt@kernel.org, konradybcio@kernel.org,
        dmitry.baryshkov@oss.qualcomm.com, mchehab@kernel.org, robh@kernel.org,
        andersson@kernel.org
Cc: linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v9 1/8] media: dt-bindings: venus: Add qcm2290 dt schema
Date: Fri,  8 Aug 2025 10:52:53 +0200
Message-Id: <20250808085300.1403570-2-jorge.ramirez@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250808085300.1403570-1-jorge.ramirez@oss.qualcomm.com>
References: <20250808085300.1403570-1-jorge.ramirez@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 4v32ALHISjg1zV9yCtfI5Suds8IK4nZT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA2MDAwOSBTYWx0ZWRfX9cBdFeojYlh/
 WnfRwrdtHRC0vhkidFOpW87osfzwMegD8ZZhVrceNWsh5AXaAptexxekF4VkwgomwQmWNlyIpOd
 XcsyujtGxTCMHtFPflMwZN4bCVUHz3CHHe295SP0C30Hq8EFK6qud8PZkoOK6S3c/JNhUGCRXY8
 QFCl9YKwr6x1+rlav2pFOuCIov8YMKWnMId5/RPhTeiig2hKR9cfZgdsut6M1wp3D5m0A4wIhta
 SDtSuvDdnrbgCDzLHkaEzwZrB/uqCUyVNfPnl9sJO065+eiugf2ELyI4IC63iVQFk20Slsdb+4h
 i+hbCQLEbXqSSixDsHBvf6mvEt1j8TWmei6k5t7K737JA7RRUbRZbeqsnrO0+zFBLwFwl27mPvc
 8LCD1sP6
X-Proofpoint-ORIG-GUID: 4v32ALHISjg1zV9yCtfI5Suds8IK4nZT
X-Authority-Analysis: v=2.4 cv=NsLRc9dJ c=1 sm=1 tr=0 ts=6895baf2 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=Rr2dNH5/fcnoRoBmcVUeRg==:17
 a=2OwXVqhp2XgA:10 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8
 a=Wl4eHCndyL1IYbKsAYUA:9 a=dawVfQjAaf238kedN5IG:22 a=sptkURWiP4Gy88Gu7hUp:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-08_02,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 impostorscore=0 bulkscore=0 phishscore=0
 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508060009

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


