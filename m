Return-Path: <linux-kernel+bounces-748935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 05B6FB147C3
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 07:43:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8A841682BB
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 05:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3580C238C20;
	Tue, 29 Jul 2025 05:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="k70S/omx"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0649023E35B
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 05:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753767777; cv=none; b=kiKEcLFEig7rIKd7qpf4HPhEK5oX5g24zr8I6VX8NMzzIy0Ihn/YvK96rmK8lsr2wzWNkDAVowpYv2MxYQa4e69i9aLEpBEp2y/cPECeAjAQGpglPzmEZiwVIq35DW/wN59nEhTYXTc8+CgOzhK6SmWh51CXnW5UJVEW20qhvko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753767777; c=relaxed/simple;
	bh=+wJgt/MZzfS8zX94B7YslhfyO7jaHuU3tElYwRHGIX4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CrZqv+aTdk9S0lFqcrsOj5ZW0Nz1HLaa6QC9lVcFxYeM4EPN3iOKo5ZbSZjdiqEYs6nxiVqEdAT0sSzo+YL3lx1sRpAcEQPSPsoxEiMce8FmUB1/nWaqjUaGebR9RDEh2T3NR1FBGXaeemcaidGiXIxACAlCupg9YyXok/wwbJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=k70S/omx; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56SMdYfJ017601
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 05:42:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FDFklMpNhOXJhUUzrt6WRg7BRReJ4cQT/Ou85+l3lNw=; b=k70S/omxwDDGZS3t
	IfyiJFu0OVn/kVwtI9c6iuBmWVLicjUtxP/te1cbY30lVzURDepa0wZflYlEte7r
	IQAUTQNZR4z5115R8odLC9bDn3XzbnKpPuQJC3qKt/INAmNoyJCdelu50l7MT9rr
	Lzb0RjYnq1dyRosA9qVMzgAeTfpCRKBAps76dK4QmMv6Wf/AG9sM63+xgJYtDwRy
	vsxVOyRq4G/LMaFsOE+gSKAjHjf9iXCFX12Sga3IbhPJJpDG1hLY0OX0PIvBW9+J
	2/AeTO0KOKZeGlte8HFgOedWNzn530xKpUZOi7u8/udy10gu08DaXq2T/xJIJnmf
	bO/rxQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 484p1aewjh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 05:42:54 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-23824a9bc29so88240325ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 22:42:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753767774; x=1754372574;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FDFklMpNhOXJhUUzrt6WRg7BRReJ4cQT/Ou85+l3lNw=;
        b=Hl/1W6uTb9bYYvzseO4P++fzR0D006cHE+/YFyJ8hYUQuGeWn/2zsLqPWP6zsP0BIz
         LH79ub0XmmcDh3utHVGgE8yn/UzvAOOMrc3i8xS56/eHfSP6t5E0XxQ3Muhb0Mm+JAq+
         HfJMgz3l91DF0syDhe487+5nrgiDN1iTvkAq0kWKyXc2AJGZW9LH2CinzNy7klBSxrFN
         Iin4lulsyAKbvaz2iWXeJmnvHJPPWDHGFBCzanv2ArMiwsCPPNgKwy/+YqAlKvjR8sDF
         NAMo8F2FyGoP5gxyy0xImCN7t+ysDEDd05yd9xHWzRAg/iDytos7jOkgSWcWEkGCy6p8
         sNVA==
X-Forwarded-Encrypted: i=1; AJvYcCUtaAij9lZDQ31itBDBZGo0GKiOL2Hz/UP+CPKTuuzCAlvVnPun91F4GH3aXdZMH4pXt6lbtJBAz5SUYh0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxicZMwqXA9nK2w4/0BNSKi+I17pS2wf4au9pbtEH4DlfVp/cvp
	9GSpP23NO74S8Xt5WFxkw5y9pbErfwlUUaPOGApxaqJw/ZNspxtD/MYr+tyVivN9/DMLkY/0iFG
	MROSecqPQaZjp16x1iXYL6Wge5v280sI4RUsXPOEMNkpsJ+nEXpTv8WlGSACOn/B6oF4=
X-Gm-Gg: ASbGncuXAkw9PoxDng0lbmiAGRvwESdqYapTzh2VuphubnOeo09q1i865KZMSvPifDN
	x9w7CcwSzLc/HEc7OCiE7a/xeSL1PeoMyJHJ1h9Q2xMZgeSvZVWgYk0YKirTK2Co9ER7wG3FkNV
	J+RPv4wKiCxDm/8QitYeggJyZUYSdkxGZbgFDD7Y9sd5gTXxWucUC8GocEXPo0xRfo+QVd0Ty0k
	m68N5Sonw/FVKQ45LLEsBC/lWrRdI1wVXcFttJlJ84EPres7d6eNvncr8qX+aWDEktN06pBSbjL
	CZKVVHWu4/mcghHX8bjxflC72nj3gmkTjHJCVzbrgqWFxp6h3pQlR9CkLAl+EVJa
X-Received: by 2002:a17:903:22c1:b0:240:2610:a057 with SMTP id d9443c01a7336-2402610a284mr76973845ad.0.1753767773599;
        Mon, 28 Jul 2025 22:42:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFuyijweDxrMiwgBqN/idRldkyPp8drzrqj6AfWgmXdWv7KrRn2IrpZsZxZOMXJWFqdnEi80g==
X-Received: by 2002:a17:903:22c1:b0:240:2610:a057 with SMTP id d9443c01a7336-2402610a284mr76973435ad.0.1753767772540;
        Mon, 28 Jul 2025 22:42:52 -0700 (PDT)
Received: from hu-tdas-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fe9b67485sm54505235ad.47.2025.07.28.22.42.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 22:42:52 -0700 (PDT)
From: Taniya Das <taniya.das@oss.qualcomm.com>
Date: Tue, 29 Jul 2025 11:12:36 +0530
Subject: [PATCH v3 2/7] dt-bindings: clock: qcom: Document the Glymur TCSR
 Clock Controller
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250729-glymur-gcc-tcsrcc-rpmhcc-v3-2-227cfe5c8ef4@oss.qualcomm.com>
References: <20250729-glymur-gcc-tcsrcc-rpmhcc-v3-0-227cfe5c8ef4@oss.qualcomm.com>
In-Reply-To: <20250729-glymur-gcc-tcsrcc-rpmhcc-v3-0-227cfe5c8ef4@oss.qualcomm.com>
To: kernel@oss.qualcomm.com, Pankaj Patil <quic_pankpati@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Taniya Das <quic_tdas@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Taniya Das <taniya.das@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-aa3f6
X-Proofpoint-ORIG-GUID: 8YR2P3f3ijz_EDQdMzxkyDM_zSlifQi3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI5MDAzOSBTYWx0ZWRfX03+fvYyaFi74
 WcgB02QSZFxhAdMjIRdeomoPa+8BrLKngPeV85pbmy4wQxGcBMDTHLvme47EME9DCnLymsQAZ5j
 jWdlr5VNEzQAWncNhB8nHe2dJsNypZuFtZtjyEFV6SPb1d1Uw4b0IcsFfEeo40yOflfi7d1vRT/
 qtsbJMFAq96Yb8Sv3H6xzhg4MP7iHh21BA87pDMl48hl+OGmlVScivN/ltIx0OJm84PAelvJx1T
 8/fvjnICh8inDn2AvJetHKl2HihkJdR+KbDMyEsh04pYNArJOWgViPxjExMZo+NbeRBptko7rUq
 Mnfdf6xMX0Ob6zAxqaMpdEuUF85Ndg+K0uV52J21MxQIfWSXGkjli3LYccVM/lDxOREOUnh1iBH
 gsV3BCxk35ldL1812LhiFFTOgNqgh4hY2nHdDmqQjBcZyNrODMvzWdfBG3f3sy9jDTVlFwUE
X-Proofpoint-GUID: 8YR2P3f3ijz_EDQdMzxkyDM_zSlifQi3
X-Authority-Analysis: v=2.4 cv=KtNN2XWN c=1 sm=1 tr=0 ts=68885f5f cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8
 a=NoBSHRPQAjGLFGKXj-wA:9 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-29_01,2025-07-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 adultscore=0 mlxlogscore=999 bulkscore=0 spamscore=0 impostorscore=0
 mlxscore=0 malwarescore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507290039

Add bindings documentation for the Glymur TCSR Clock Controller.

Signed-off-by: Taniya Das <taniya.das@oss.qualcomm.com>
---
 .../bindings/clock/qcom,sm8550-tcsr.yaml           |  3 +++
 include/dt-bindings/clock/qcom,glymur-tcsr.h       | 24 ++++++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/qcom,sm8550-tcsr.yaml b/Documentation/devicetree/bindings/clock/qcom,sm8550-tcsr.yaml
index f3afbb25e8682de83fb16acaa35448545f77ce77..9fbf8883678245b20d99c13cd1a7cd8c0feee11b 100644
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
diff --git a/include/dt-bindings/clock/qcom,glymur-tcsr.h b/include/dt-bindings/clock/qcom,glymur-tcsr.h
new file mode 100644
index 0000000000000000000000000000000000000000..72614226b113bb60f1e430fc18e13c46c8b043d3
--- /dev/null
+++ b/include/dt-bindings/clock/qcom,glymur-tcsr.h
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


