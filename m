Return-Path: <linux-kernel+bounces-733827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E29C8B07984
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 17:21:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF8897BB477
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 15:19:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1315026E143;
	Wed, 16 Jul 2025 15:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jtDk9F8P"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E36782F3C26
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 15:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752679239; cv=none; b=sqvEjJzUuFB2kwJJw69RzCRURHUdh+L+hu6qxyzmVSGc71iJglOV3sDPnWGWbNGTV3f32aUNhX5YaKjZezlE1Pzvv9tc+fzq1oGzFUnbhLry6uWpSF6vu1XQsjAegzYkzhIbNIfxPdRS1PdYdYqMEolJB1qFp7Ub8RlGbBJHLBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752679239; c=relaxed/simple;
	bh=FHbMUWIwDLjzzDs7EACZx+RwtXAev+AhH2JinKmvF9s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=K2Jc8kfiJWwEGg5KmPc7IOekq57hTJ8OY3XJvQY8Gau40UdzDd0hdyfH1McDp2izjFaPDeC8hCr3j2PWaJs4FrPDFR18mSfhMUp0u8iNP1s3aHcBIMrMMv4xZfil1amQLAYqqx7Q164KskToDtTTJuU/WWnLLczyuOVEhUtKkuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jtDk9F8P; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56GCsorI007299
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 15:20:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=bH6uNs2EMbe
	7CtZfXiVtThZ2PeSVgjpvGZz47v2mqpE=; b=jtDk9F8PHMl9kNWkKwMSmXcULF+
	PUJpskpLrHiP5JfJTBa9vy8RPQ86XDjZYX2apQWb9vIw+IDGmmBtyE4BTyIUBCaX
	P+30Jrac+YckoyjfoBi9QDjmd1ABQBhxed6P8Mpt7voOnt65a3bkRf/p8BPiGhGb
	Wk06ACWBxQ85RVvKBhAFUjLJSJSFImZkht3cbEQv7nj6aUo1kBUmaL0Pg4817yb5
	cCk5jVzhph66+XXMqIrLppd9xuzauJK+VzSFqU/BnGUeFp9az3sFEt0SHRFaA4j/
	N7hqxiEcMYHxH4ZfeKQhM5SpWGRtyKvkSHjUhNZVxB1tdW745Ql1ntP+uzw==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47wnh5vp15-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 15:20:37 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-748f3d4c7e7so21913b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 08:20:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752679236; x=1753284036;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bH6uNs2EMbe7CtZfXiVtThZ2PeSVgjpvGZz47v2mqpE=;
        b=MOFk7VFoM/y5hfmT375fVcGRIJWNYfMHuYk3sNjXCGJMvgeYbPyjDV6PFDC5DcuOEP
         oVZmC/0NtHSOhSsor3tLYiInj2prkKQzn1III8N/eAeHwxvf14j1jDHxPKArMelE7URA
         6gXtgwJtBhN0nVMIINc4lEAa0rTc19ZxHMEa4hC6ANAcu02DwvubtRVbz7oNiqGKhxSJ
         28zQfSl/cwsoh7jhy/AZ4Cup3l62EpNIO9IXYod2aqMShkxt63V87PAtHgR4WozkQeMG
         J4AM9JX6x0wsFL4kCzf5GRXMicHk3kD4rJeaSD/FVmmWtCR0zdQpAWz8Xuh/IFTae3xd
         h9Vw==
X-Forwarded-Encrypted: i=1; AJvYcCWI57+Jov5juCuO98KIdHXHXIxADUVsBuO/oILQnb1thTaUPxuet+nuNl+3B2p8drhnfdKcIg1iNkMNc0I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXmSUQmOtdPedg0g+tsFyMkUPgZlb5uGHSINLmNbnRNAmfD9bx
	ksKzXkLB9PNfDm10upW5B5byBznLdgRx65SKI8iVsJd69zCcmbA7iR3kU9SLs42vP8I8jtstoiF
	PGw7eupVhFDkx+DvRZz9NTq+wqJrCifhpty81kMqWTYf5foz0wBPkjVpi5SSxrz2+RBY=
X-Gm-Gg: ASbGnctis63GnGAbHLKS2g+tisOR8gBTSitH542t9v3+o0YAsAHQ03nTCAXpEpWPdSH
	OjAisOAXP5NcEg+8MEeH7qklRT1ra2zek+w4MX2UUDnSri7Pf9NmVoPChdomD3igiHe9Uu4IWZF
	KAKacSunR+6yok2qSBlxIBeyES4fyXVRqSFONjQUW1d6r26HIUpfe4KQwE0Ig5awcxZzCDT3e2G
	QmLBquLmpbm0hX9n2KC4Zh8jbGzEw8QSPjMNZCgF2kKYteNaGBnNKqyul4+7EwsjoHaKI9rizAb
	Y7HQMgR2Z/+XvbgHUlK9p3YYshIDmeSlv3mSx8IppPOBNCmpCVF7KnDQlm2ZXiexYQqaF9dO0Mu
	zj0m5K7DoK0Awa4NGSLg7cgUdabkCIP1j8rr25Oz6zdufQwLlipG+LSmWT+DL
X-Received: by 2002:a05:6a21:6daa:b0:234:98ee:daae with SMTP id adf61e73a8af0-23812457aa5mr4461485637.21.1752679236037;
        Wed, 16 Jul 2025 08:20:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHBtaZlHU0tQo2Ac+UAKtWkfyPrldBaiGlgpbsQEnA2s8MxScmuw65VlcnWVn6PGRrM3sdiZw==
X-Received: by 2002:a05:6a21:6daa:b0:234:98ee:daae with SMTP id adf61e73a8af0-23812457aa5mr4461416637.21.1752679235516;
        Wed, 16 Jul 2025 08:20:35 -0700 (PDT)
Received: from hu-pankpati-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3bbe6bd8f8sm13912054a12.38.2025.07.16.08.20.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 08:20:35 -0700 (PDT)
From: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
To: sboyd@kernel.org, mturquette@baylibre.com, andersson@kernel.org,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        quic_rjendra@quicinc.com, taniya.das@oss.qualcomm.com
Cc: linux-clk@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/7] dt-bindings: clock: qcom: Add bindings documentation for the Glymur TCSR
Date: Wed, 16 Jul 2025 20:50:12 +0530
Message-Id: <20250716152017.4070029-3-pankaj.patil@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250716152017.4070029-1-pankaj.patil@oss.qualcomm.com>
References: <20250716152017.4070029-1-pankaj.patil@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=dKimmPZb c=1 sm=1 tr=0 ts=6877c345 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=NoBSHRPQAjGLFGKXj-wA:9
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-GUID: LbbMPpUEBZw2VRGzEfoEshQbeybeA3uj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE2MDEzOCBTYWx0ZWRfX/Gejb49yny7h
 MmhObcnfXetn1yGdlLKYr6yxoX+80KXy8gNlosPKy+tMctmTz3B1PpOH+ucYkd3Nr4tPddQRbw7
 rARNVyDnFZrQDLCvvJwu4iZO0p3fOkRhqsomGja+CoC3NsuFJnDIvJmGpkz35f83IFy1yTgrViR
 DoX/jizUNYmwGP0XhjP+34G19AnlvPuHtBi2DwZ8hXTfaIdl0bJIdbznjcFPmMiiMvYrK6UqLbP
 QHn2R/v4n7eQveSKEeMJOCS0l6a1cmlEP4XueHU8zOQn+5I3bXJmOlx52p4qlQa7EQ8CllJ875d
 Pf6EfB2CQvLV2n+KAx9n7Y7okM4f6/XQo9mF9ZlQ7z5jkqghcZ1kzWUWVb2KK9k3qOt9xZFJlsz
 cdRLEOuo4pG0Kt5/BHO50HMRQ53WAQF2BEvfb9mHYCvqZvc3LTVIUIPijkgywsxgojBzB/zH
X-Proofpoint-ORIG-GUID: LbbMPpUEBZw2VRGzEfoEshQbeybeA3uj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-16_02,2025-07-16_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 mlxlogscore=999 mlxscore=0 spamscore=0
 adultscore=0 impostorscore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 phishscore=0 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507160138

From: Taniya Das <taniya.das@oss.qualcomm.com>

The Glymur TCSR block provides CLKREF clocks for EDP, PCIe, and USB. Add
this to the TCSR clock controller binding together with identifiers for
the clocks

Signed-off-by: Taniya Das <taniya.das@oss.qualcomm.com>
Signed-off-by: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
---
 .../bindings/clock/qcom,sm8550-tcsr.yaml      |  3 +++
 .../dt-bindings/clock/qcom,glymur-tcsrcc.h    | 24 +++++++++++++++++++
 2 files changed, 27 insertions(+)
 create mode 100644 include/dt-bindings/clock/qcom,glymur-tcsrcc.h

diff --git a/Documentation/devicetree/bindings/clock/qcom,sm8550-tcsr.yaml b/Documentation/devicetree/bindings/clock/qcom,sm8550-tcsr.yaml
index f3afbb25e868..9fbf88836782 100644
--- a/Documentation/devicetree/bindings/clock/qcom,sm8550-tcsr.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,sm8550-tcsr.yaml
@@ -8,12 +8,14 @@ title: Qualcomm TCSR Clock Controller on SM8550
 
 maintainers:
   - Bjorn Andersson <andersson@kernel.org>
+  - Taniya Das <taniya.das@oss.qualcomm.com>
 
 description: |
   Qualcomm TCSR clock control module provides the clocks, resets and
   power domains on SM8550
 
   See also:
+  - include/dt-bindings/clock/qcom,glymur-tcsr.h
   - include/dt-bindings/clock/qcom,sm8550-tcsr.h
   - include/dt-bindings/clock/qcom,sm8650-tcsr.h
   - include/dt-bindings/clock/qcom,sm8750-tcsr.h
@@ -22,6 +24,7 @@ properties:
   compatible:
     items:
       - enum:
+          - qcom,glymur-tcsr
           - qcom,sar2130p-tcsr
           - qcom,sm8550-tcsr
           - qcom,sm8650-tcsr
diff --git a/include/dt-bindings/clock/qcom,glymur-tcsrcc.h b/include/dt-bindings/clock/qcom,glymur-tcsrcc.h
new file mode 100644
index 000000000000..72614226b113
--- /dev/null
+++ b/include/dt-bindings/clock/qcom,glymur-tcsrcc.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#ifndef _DT_BINDINGS_CLK_QCOM_TCSR_CC_GLYMUR_H
+#define _DT_BINDINGS_CLK_QCOM_TCSR_CC_GLYMUR_H
+
+/* TCSR_CC clocks */
+#define TCSR_EDP_CLKREF_EN					0
+#define TCSR_PCIE_1_CLKREF_EN					1
+#define TCSR_PCIE_2_CLKREF_EN					2
+#define TCSR_PCIE_3_CLKREF_EN					3
+#define TCSR_PCIE_4_CLKREF_EN					4
+#define TCSR_USB2_1_CLKREF_EN					5
+#define TCSR_USB2_2_CLKREF_EN					6
+#define TCSR_USB2_3_CLKREF_EN					7
+#define TCSR_USB2_4_CLKREF_EN					8
+#define TCSR_USB3_0_CLKREF_EN					9
+#define TCSR_USB3_1_CLKREF_EN					10
+#define TCSR_USB4_1_CLKREF_EN					11
+#define TCSR_USB4_2_CLKREF_EN					12
+
+#endif
-- 
2.34.1


