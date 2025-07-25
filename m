Return-Path: <linux-kernel+bounces-745582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76D7CB11BE0
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 12:12:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 713993BB2F5
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 10:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 498402E2F05;
	Fri, 25 Jul 2025 10:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KCoNpFp+"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D610A2E3387
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 10:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753438125; cv=none; b=cuL+3Knof0mwW0Q3kaYnDk6L1jWHmDRl6ClrUje+IsD53LBvWVKe2eG8+Rl9P4XSLlBaq1eedlVNC7JndjOkQbZkSrij8ZWSncnzM9c9VGTymvELSUKr+Vnlu9aStZyfo/PZophMMv+BVHfmP6n1QRzsfyjguABcHbwhytvqp78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753438125; c=relaxed/simple;
	bh=/g0/ZP4wHtHkgn87d1qyuSHaHZRS6iAOtiw3E5bQBKQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=i7s+oxI4TW1tIahH2mowuAqv64bJ9wwCS0T1Od3Lf7Edl+my0iSUSbdMcRLx8TAsIxI9+pVaSx19zpAxyl35pypCHM3cSt6h81w5WApw51JZcOn5GtYWoDJT3JHPSpuEWmI9M8o8glK6U8RfeaTy/Dz0vrWfmq/E0HtbbfADNdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KCoNpFp+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56P2vgf4029476
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 10:08:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=0SmpNFp+B8v
	w9+MbCCEs5ee5DB9AM9lfQmDfPKr7t7U=; b=KCoNpFp+ntjOinka8/ykKwlqxo5
	eoWqWTAXhw/GyATRod1St33CuLKOTmsNOsWA00Y4rDkvOzSQIxesWwK/+kCH6OWm
	5mNJIzQhWfZaRf1jJGotTGU4sd0pqqEjOSlwtGrCgV8AiPaRycRQXVSsnRkPzuOM
	KF6kunFyKrzuDgzRcCXMingcKGtlWbq8QYdtL1LdGWxoqv2+r/pghS2K2z0im/vX
	asxBACcLDR2/qgj/vk8Jrtxzzczj0XtVzeVjxbmv5WmgAtn49r5Oiw2l7t4+VebF
	EOZYvWGtLq3p/SZ5SoSpQn/X/a8y35QLAqZL7yFXbvajI6JDPa63+Wa1qFQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 483w2t1nju-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 10:08:42 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2356ce66d7cso31481915ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 03:08:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753438121; x=1754042921;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0SmpNFp+B8vw9+MbCCEs5ee5DB9AM9lfQmDfPKr7t7U=;
        b=tTqlUrSQEHbQYEePL2K6GMtX1pI1womyyrf95VYo3xN23vh23Eh6eIj4omfOsmdg2i
         oRCieLYFZsO9mOp/hVUO4DspfIq4qDo8v/hKKUgdLIja8pWqZWiInqd88iOC6p/XvLKR
         G2Ym/0IRnmgluj7E3IPwu6gIXq1UtSZ4FZPrBNP9NMEjR/KsKTLlSwCzYyv4NvX+scyW
         By4tPZ3+XbRAKoRXGIfh6J9iV2gA1CmBMwqqxO3d5VZxP0PXco6VI+HwpOzb56PSDjpx
         oxLdxFZyiVf2toSTe8RInWyg6o2nkjjFIhETq+RShPj0/pRPg8gvwCdV8aqyps8ckfMh
         MhyA==
X-Forwarded-Encrypted: i=1; AJvYcCUkunFQxtPWBXWJup3B8xOpfk12fUREjR2I1U+27BmWCcFBmioE/jrJujlCOqJxMisDhBfDl6hBMVv2BGw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfcaVloXH0iljnOmI1x5h2hPNTReIEkZ+4aXBsy+pSDyy0oG4b
	muQDpXlzuGCgLAaHXxAgo0whwT9mw1K0isqVMlBvX+SfoSV975OsRZhbEp/bsWcYtzZ0Lwyyg5d
	1gitPVrk6igUv99vboUqqMacuscNjPFBRzXmQ+w5BuNCwkll5fyokhrgzpZ+fRyUQVvM=
X-Gm-Gg: ASbGncvV9EqjWTm2QkNR05ahrhziDhQEwnYR4Cx7pgh6TmDEPYXw9KJ28YIdKFHhHcu
	RGzyiAOnGrZ8gUnQZUuE5G4AlS+dHV56bw7bwbm0W2SFPbYUoDoeB5a80vXinigrKfqmFjOqqx4
	sB6oSYarRPetSTT7rbrcSlSqZmz8nKHwyUsXMd2Oj7MrfN11YKZwq+/jFNJRoNBH88iOILFDqGx
	IyeqcsUL56AZqoTabYKNdZSbt3DTvw6NcepJJ2EzCfXWGqe2sAjw+VAkNgzgdPXhkL+uNPg5+Wp
	j2Cgy9aUFWGHweWfh0gEn0+mY1cAXeWOSXzM9wZpdh9NA6SRWcsFf/XTN79LK5jJTjJCeZBdPUr
	2e4W624xFAAZQ/VNT5ho=
X-Received: by 2002:a17:903:234d:b0:234:b123:b4ff with SMTP id d9443c01a7336-23fb30cc681mr25581045ad.21.1753438120976;
        Fri, 25 Jul 2025 03:08:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEDcweS3brtm1EcH87xGsGwFbz42CYAlihlVwybMembexKMc5w9Vl7jZLv3ap78usO5Oa+23A==
X-Received: by 2002:a17:903:234d:b0:234:b123:b4ff with SMTP id d9443c01a7336-23fb30cc681mr25580555ad.21.1753438120566;
        Fri, 25 Jul 2025 03:08:40 -0700 (PDT)
Received: from jiegan.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fa48fd29dsm33641435ad.176.2025.07.25.03.08.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 03:08:39 -0700 (PDT)
From: Jie Gan <jie.gan@oss.qualcomm.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        James Clark <james.clark@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Tingwei Zhang <tingwei.zhang@oss.qualcomm.com>,
        Jinlong Mao <jinlong.mao@oss.qualcomm.com>
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, Jie Gan <quic_jiegan@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 06/10] dt-bindings: arm: add an interrupt property for Coresight CTCU
Date: Fri, 25 Jul 2025 18:08:02 +0800
Message-Id: <20250725100806.1157-7-jie.gan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250725100806.1157-1-jie.gan@oss.qualcomm.com>
References: <20250725100806.1157-1-jie.gan@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=BMKzrEQG c=1 sm=1 tr=0 ts=688357aa cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=Wb1JkmetP80A:10 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=gSyxy6DGYGa4b6s9XCEA:9
 a=uG9DUKGECoFWVXl0Dc02:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: 8cNySwPYth0gPb1UH3lNpwE5f2UM66al
X-Proofpoint-GUID: 8cNySwPYth0gPb1UH3lNpwE5f2UM66al
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI1MDA4NSBTYWx0ZWRfX4KDy0Bfql3Jk
 FTl9ZEGLmKPUKsG87v1q4El09zog73pO93Kz0l5d2Kzj8wzTIU7B+Oowrip+QRWrrDPVcUvPWY7
 b38+MgyZdlqLWx1vrS4uuJMWM73yzBQl9xaoUF4Y7kHA/Hk2AfPjIuwJtVCnzdLQlYg6SJiMWAC
 VveWg8iTJVT24WFzyuAPIdFy69t7+HNxXWaxiLs3ugK778hH6Bd6TNAnsdyLbuwQuMkqlXDEIxD
 fXCvmxXAAlDKqk5vyRshHcUqswQnf7+09j94crb6VyMWdC4XfrpyG3d8sufqumixzn3Fiv7Wkas
 QQUswLSfcKvvV+wxhr4LtZnklduzC6tCrja3pzhvOFOBuqHIKUiJ6S+DDWr/zNc1AI1e90NQWCU
 2vt8fPFNg+dbEIpbYI4GIB4MWWB4J9qp9e59E0p+8OEWV0LkodJSWZ8YopnWQKqYigd7iBYX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-25_02,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 mlxscore=0 spamscore=0 impostorscore=0 priorityscore=1501
 bulkscore=0 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0
 mlxlogscore=999 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507250085

Add an interrupt property to CTCU device. The interrupt will be triggered
when the data size in the ETR buffer exceeds the threshold of the
BYTECNTRVAL register. Programming a threshold in the BYTECNTRVAL register
of CTCU device will enable the interrupt.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Jie Gan <jie.gan@oss.qualcomm.com>
---
 .../bindings/arm/qcom,coresight-ctcu.yaml       | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom,coresight-ctcu.yaml b/Documentation/devicetree/bindings/arm/qcom,coresight-ctcu.yaml
index 843b52eaf872..ea05ad8f3dd3 100644
--- a/Documentation/devicetree/bindings/arm/qcom,coresight-ctcu.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom,coresight-ctcu.yaml
@@ -39,6 +39,16 @@ properties:
     items:
       - const: apb
 
+  interrupts:
+    items:
+      - description: Byte cntr interrupt for etr0
+      - description: Byte cntr interrupt for etr1
+
+  interrupt-names:
+    items:
+      - const: etr0
+      - const: etr1
+
   in-ports:
     $ref: /schemas/graph.yaml#/properties/ports
 
@@ -56,6 +66,8 @@ additionalProperties: false
 
 examples:
   - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
     ctcu@1001000 {
         compatible = "qcom,sa8775p-ctcu";
         reg = <0x1001000 0x1000>;
@@ -63,6 +75,11 @@ examples:
         clocks = <&aoss_qmp>;
         clock-names = "apb";
 
+        interrupts = <GIC_SPI 270 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 262 IRQ_TYPE_EDGE_RISING>;
+        interrupt-names = "etr0",
+                          "etr1";
+
         in-ports {
             #address-cells = <1>;
             #size-cells = <0>;
-- 
2.34.1


