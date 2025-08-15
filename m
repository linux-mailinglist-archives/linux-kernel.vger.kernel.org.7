Return-Path: <linux-kernel+bounces-770924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B5C0B28083
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 15:20:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04062608081
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 13:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D419E302CD2;
	Fri, 15 Aug 2025 13:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="a8vGIPbU"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4C230148D
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 13:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755263913; cv=none; b=aA4e29ntixwa7GinqkaLpIoDZGjk62o3L0/9E84GUwEmyBcPRyq/T35EB+UpqDJt8cb4VqO/IXIprm+Ibv6LrDFQl1jAez2JjdW+9opj/7oPsSrIS+jkWyueuDaxN8v9srspfgcVNvTj1F8g2w5zc6bfbBnz3Ne13H1Jez1cuWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755263913; c=relaxed/simple;
	bh=iFGrvpCpH4OzqPsKWLDwUClOVbka/29o5GG8qAczHik=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qxIR7nJJX6/46Yo6dF84RS0JsY81KELGsA2cI2JOHIBIHPgHifJRFOTeQKf+Cy97poKIxeNa82grrLXwje/RYzh+F30iulSwO3/Olmvp+bI5skqbstrGjUhr6HbVj/ml6sZDngghPHcCMDWdOBpZzSrA7X0DiOOvECKpsN3QHDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=a8vGIPbU; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57F9lrM4016552
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 13:18:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	BNTmoIT+3QSEdOQTRVOgb+e3bVVubsrbyt1Z7+uuZKE=; b=a8vGIPbUhBbv7WyP
	cXShsEKMilHW1xOWWDfq/frwKaFouOlgq+znPSdndqnMeXEqf2oOZi0YizC5mtli
	pApWXRJLOdBDybEi5HmgzJU7tAuees+ThcwE9xR4312mYu4Db0OyjzTf607ZaW8C
	nXw1bF31pBZ48fxY7ofO6QMaKIjsjx6kT+tsRuRc4OSVA3bChwxgGwcpUocanaGJ
	FDeWCq/dqiABK96S47nWAFM5VGnxPfFuQPcPQ7om8Cvf8EsSo4IPR8tehzGh3i5M
	IWzex0WH9zOBS8tBHc6wIPauDRRM8d3bQi/jgXBKegUTq+FM4L4lPH6snQMWCdWI
	3JDFaw==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48fm3vwywd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 13:18:31 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b47158d6efbso1418289a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 06:18:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755263910; x=1755868710;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BNTmoIT+3QSEdOQTRVOgb+e3bVVubsrbyt1Z7+uuZKE=;
        b=HWylnv21mnYUU2coqoO0m8kg3tolSl6bseGvFITuOCMY+aG/vHJnk06nETXHXq7tAv
         +/uy17azD08VnWHoPrXg7B2VlnWAo1FmKFMGuzj+caQFkasg80F4dbOiJLH1fjl2n6iF
         A1pSyNdRzj5NXYtYv4kZXKd1XnF4qaEO4Kevdi8TQOFocFBFuCRaXBrgYCQ0g22MSpbS
         9yHuBS+HHYx4bGisvSkSnfdNTtnpsH7MsPhZ3oZyA3V7lj+MkjrMUyxA+h4jn63DXw0w
         DgLwDjPY/hmENdVZtAeA01GiLEsdY7uYdTd3rWFRPNTYtzHLbPfZhTJ5B6FLAkJ1E+aV
         Ew/A==
X-Forwarded-Encrypted: i=1; AJvYcCXF7ZxH5uCVPkMNW0gszYmiEGuSpSL+Q3yFF1EtLmir9KYjMn//hzg9np79wqHizTpehDd6JuWSbc1ks08=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/VyGKVwS6HDvZK/L75gVO4FPg3j29rA/9zpjs8j2rxYWkoiP/
	D0Y09TuWjEcbscED4f8xosXh1L+8UZvoD7T3jY38Ss2DnOJ+FYJjlg4trINgVUOfjn+J2AZJ1Gw
	EKr0XFM0Bu6k0QNde3acfIYHXsjICFky3IZmHscVunXjmlfWEK8da8kDWlAP8rAFRlww=
X-Gm-Gg: ASbGncsR7lmIBAtpjnVLO+34JnqiJ9gWeixLxP8Akj68O3dL5bYoA5xtEh4VYtLqerX
	2u3fTaaovyNfBpT0QEDtvqB0UwbZCooI8GgnnE4MQt87WEkHdpqaLmx1gGXcHGVaLrko3INlnb9
	qpurQlkN0/CHFfdhr1VAWaImNc/HYx0GkLQikuvaUYMNOuxPM7dWjSvr40YLAeLbkuzD3kTN5le
	OwUU06VJRFnXMdyGlUGPhYlF/99lTNJxBqRMGdTxIvKwmAK259gLmbmZsxaLFJDKOlvSv6PSbj3
	a9acPxXV5TpN82ET1v1Fx9K/RLFWROEaTOjQDeglZldrFSBbDxFRQSfYCeoJn8V3WIUy9O8x4hx
	mv3S0oPgjyc7mezN8ry0jOQ==
X-Received: by 2002:a05:6a20:a105:b0:235:2395:9b79 with SMTP id adf61e73a8af0-240bdbed996mr11657812637.20.1755263909693;
        Fri, 15 Aug 2025 06:18:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFVgtlGuHI3R5UTZppK/I92pbWdnaCgqxM5po9lFPqc8ruSdgnzkjF7GUIatpizm+XOrJCpEg==
X-Received: by 2002:a05:6a20:a105:b0:235:2395:9b79 with SMTP id adf61e73a8af0-240bdbed996mr11657761637.20.1755263909236;
        Fri, 15 Aug 2025 06:18:29 -0700 (PDT)
Received: from hu-yuanfang-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b472d7944e6sm1256386a12.54.2025.08.15.06.18.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 06:18:28 -0700 (PDT)
From: Yuanfang Zhang <yuanfang.zhang@oss.qualcomm.com>
Date: Fri, 15 Aug 2025 06:18:12 -0700
Subject: [PATCH 1/3] dt-bindings: arm: qcom: Add Coresight Interconnect
 TNOC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250815-itnoc-v1-1-62c8e4f7ad32@oss.qualcomm.com>
References: <20250815-itnoc-v1-0-62c8e4f7ad32@oss.qualcomm.com>
In-Reply-To: <20250815-itnoc-v1-0-62c8e4f7ad32@oss.qualcomm.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        James Clark <james.clark@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: kernel@oss.qualcomm.com, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yuanfang Zhang <yuanfang.zhang@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755263906; l=3400;
 i=yuanfang.zhang@oss.qualcomm.com; s=20250814; h=from:subject:message-id;
 bh=iFGrvpCpH4OzqPsKWLDwUClOVbka/29o5GG8qAczHik=;
 b=qyemCdR3P2VMmp7XSc+HQGGmjYmMzyTQG+snL1xiWIJZY/XORmtMi4kBRE3qJEpQsRwMvRJDo
 3CPb/IldSn1BjS12mEqgCgJiZjyfgJan0lEIGyUKjWy9sFlDUSulzWF
X-Developer-Key: i=yuanfang.zhang@oss.qualcomm.com; a=ed25519;
 pk=9oS/FoPW5k0CsqSDDrPlnV+kVIOUaAe0O5pr4M1wHgY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDEwNyBTYWx0ZWRfX5sXbEXlFwoGl
 8tmynoSWXgvVe+y/tVw/0cPpaqNJ2s+S7V364FmvuifdaD7a6o4pSVPvC9JcPw7pE+Kg51i/e4w
 1wnx20ofdXmmKXdX2eocZmzN9UNhuVBO42CkqJ2q994Mm9uDuq8K/fsLLPIn+L7usl2hNlJh7eK
 DlEfLjf9OCM92O2XUleHHvAXVfxerBiy+yAv3h52LOvsZeV4tqSJu8/F9atAXqp4o9STaXYGGcG
 LKywJZsDoTqsV93Zfm7ITgyQwhv7DWj4+wz0LNg4xcx1srLo4JMtLjZL0uu5f3/cPLJ+k1MO/Qh
 VAj1si/MlRUIhPgqE+BOrdEivol4f1HSOQ0rCEdOqT9yeYaq1Ju8+q9H5dOq32i9lwNc2L1yrMt
 dEFufCRT
X-Proofpoint-GUID: p0-8CANflTkS4k4LsjQv4XbYMhfe9a35
X-Authority-Analysis: v=2.4 cv=A+1sP7WG c=1 sm=1 tr=0 ts=689f33a7 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8
 a=v7KY3twRVyNl3kJcRO4A:9 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-ORIG-GUID: p0-8CANflTkS4k4LsjQv4XbYMhfe9a35
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-15_04,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 priorityscore=1501 malwarescore=0 spamscore=0
 phishscore=0 clxscore=1015 adultscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508110107

Add device tree binding for Qualcomm Coresight Interconnect Trace
Netwrok On Chip (ITNOC). This TNOC acts as a CoreSight
graph link that forwards trace data from a subsystem to the
Aggregator TNOC, without aggregation or ATID functionality.

Signed-off-by: Yuanfang Zhang <yuanfang.zhang@oss.qualcomm.com>
---
 .../bindings/arm/qcom,coresight-itnoc.yaml         | 108 +++++++++++++++++++++
 1 file changed, 108 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom,coresight-itnoc.yaml b/Documentation/devicetree/bindings/arm/qcom,coresight-itnoc.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..fd224e07ce68918b453210763aacda585d5a5ca2
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/qcom,coresight-itnoc.yaml
@@ -0,0 +1,108 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/qcom,coresight-itnoc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Interconnect Trace Network On Chip - ITNOC
+
+maintainers:
+  - Yuanfang Zhang <yuanfang.zhang@oss.qualcomm.com>
+
+description: |
+  The Interconnect TNOC is a CoreSight graph link that forwards trace data
+  from a subsystem to the Aggregator TNOC. Compared to Aggregator TNOC, it
+  does not have aggregation and ATID functionality.
+
+select:
+  properties:
+    compatible:
+      contains:
+        enum:
+          - qcom,coresight-itnoc
+  required:
+    - compatible
+
+properties:
+  $nodename:
+    pattern: "^tnoc(@[0-9a-f]+)?$"
+
+  compatible:
+    items:
+      - const: qcom,coresight-itnoc
+
+  reg:
+    maxItems: 1
+    description: Base address and size of the ITNOC registers.
+
+  clock-names:
+    items:
+      - const: apb
+
+  clocks:
+    maxItems: 1
+
+  in-ports:
+    $ref: /schemas/graph.yaml#/properties/ports
+
+    properties:
+      '#address-cells':
+        const: 1
+      '#size-cells':
+        const: 0
+
+    patternProperties:
+      '^port(@[0-9a-f]{1,2})?$':
+        description: Input connections from CoreSight Trace Bus
+        $ref: /schemas/graph.yaml#/properties/port
+    additionalProperties: false
+
+  out-ports:
+    $ref: /schemas/graph.yaml#/properties/ports
+
+    properties:
+      port:
+        description: out connections to aggregator TNOC
+        $ref: /schemas/graph.yaml#/properties/port
+    additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - in-ports
+  - out-ports
+
+additionalProperties: false
+
+examples:
+  - |
+    tnoc@109ac000 {
+        compatible = "qcom,coresight-itnoc";
+        reg = <0x109ac000 0x1000>;
+
+        clocks = <&aoss_qmp>;
+        clock-names = "apb";
+
+        in-ports {
+            #address-cells = <1>;
+            #size-cells = <0>;
+            port@0 {
+                reg = <0>;
+                tn_ic_in_tpdm_dcc: endpoint {
+                    remote-endpoint = <&tpdm_dcc_out_tn_ic>;
+                };
+            };
+        };
+
+        out-ports {
+            port {
+                tn_ic_out_tnoc_aggr: endpoint {
+                    /* to Aggregator TNOC input */
+                    remote-endpoint = <&tn_ag_in_tn_ic>;
+                };
+            };
+        };
+    };
+...

-- 
2.34.1


