Return-Path: <linux-kernel+bounces-879620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83299C2396F
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 08:43:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 651443BA4EE
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 07:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFD6832D7D1;
	Fri, 31 Oct 2025 07:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kpPeomOl";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fL+0e5gN"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A3CF32AAD0
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 07:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761896526; cv=none; b=gczm5qple4HwKyUZYMPlwM55jpvoZ5W/qEAfugBr9Y03nMjWkzwJmf0gtMapSAquULDPilMXpi9xV7YPZw303tfVJ/d1Y7hM1pwLJketNdsVMXr2ZQDnNdMTmwvg/5dpH0MFeuOGZknePlt+0QZKG0auQx+XQ7xDQtSnyTNp6Ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761896526; c=relaxed/simple;
	bh=qlUtzAzZxDCLyyPXTwLpPfLS4uA7aUaeJ2nseKmb40Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iULmMgcSYcFN420iO+tHeRjHDVG2jGXFNXK98rRQduwdoxbtSzzmtUUA2JyqNe901XnfvccF7PUsvj6/kmu/yo2Bgupq53/IYFX9h+XMqj+ik5MCX+sq1kehNbdW0hPFRio+i2Zac7zqlIKM7OjBNqfqZ+SY6LC0pR93ASlh4Ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kpPeomOl; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fL+0e5gN; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59V2BpBQ102638
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 07:42:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jEUn1B3/VYskPM+hcp4qb/Ei4KQ/Ans9UCSA4sJFPwI=; b=kpPeomOlj2aE5187
	a1tg2Dc6c53MMWB9yAFdxKx/Xbj14hiol8UVu8WpD3+jwrpJ5bXq3IkuYooUD5Sa
	7USJcgGcwkP193npPuXdLSCG+0F4O8/JPhKmNu9DhOqykDUC9xtkb3xP0iJ40wjN
	QPSTRwmTdxDPvdGgQ5YPGTdvNrghbftXJCFZgNPP1i1vI/672LjSNZeNfNgN99MG
	2Cc5bBh8kGbW0N6S+oxPI0JmZK3e5DEx20S6bocjb8YEPPqTGs6hAI1DH4I8dROF
	Kq9sNS134nWmyBmPiArdox9Dy3cZUKd5cFV1WiIB08g0xiuQjbcgKMXBXPh7gZV1
	+WvWGA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a4ahdjaey-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 07:42:04 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-290d860acbcso39938055ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 00:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761896524; x=1762501324; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jEUn1B3/VYskPM+hcp4qb/Ei4KQ/Ans9UCSA4sJFPwI=;
        b=fL+0e5gNNPYimRjAy7zJD9/1SiTjMRpcMmPYgjsv/BX9GYDOhjWr9C12L394zY/KC7
         YUiR2h9PE1/vHC+nAMW2HvZxmgjL2tdJespiMdeTjOfdPKI1JKedgIfdpC377xG1jJXG
         MZ4hcsVSl/EoJBpQYvbt79A4Lo2oJOXLBK0NUu27AxDBULh+ZUZtDdODjijQf/Jhjrx5
         dQVtFWfT7zhu5na4DorV+2rXwaOKO71QSlNTp1I87FDsPeWEFOYDg8hYlmgrMEZ+xKqN
         xmL0JsX04fwEtqb2tBiQ8B3dQEitBAl2htr96uLbIOyW83iC81YrPvbLCFzw3GVevvA/
         YPkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761896524; x=1762501324;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jEUn1B3/VYskPM+hcp4qb/Ei4KQ/Ans9UCSA4sJFPwI=;
        b=M77pJvxmOos0AkSbYJKRKBedDPNtW/FQNec77q3LRG4cxmaFxZmHZscZ8yX1stYgKE
         5xKNjlTVWHFTLsbq+R2oPnHgeYXSyMUzAT0Y19JK0VtCyjowfT2YPvKOQR9tZsom8gyL
         /lARJPxMH82pCY8G8OAIC6cwbhw80c6Nhg1peJUo2h6/gf2ohZXrGImXHKq1WNVqG9rz
         tUodTL3nrtRZY9JMT8MV2MbEuNTjGi7JHwnkQrqdik5JMMAroA7YYV2ghBQ89qUEwS0+
         +QriHw+4nTaEEw7ijih1qeYwD13uQI526oYWsLxXxOew7v5fmJ2eTLQFOc3TUQN1fwTP
         zwOQ==
X-Forwarded-Encrypted: i=1; AJvYcCVxHgF5fw1iXd0iBGTPdhSYGMk+N+4awc9s0flZF6GWhc767y/Mt6eg7Sfm2fzX36C7MK+eR84qSsNoYY0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxMpxiWAcFlNfNsAco61KPLGVC6LngFgfhlI5b+P4Q8N5FRKqU
	U080txXsva/L3CvOETNRS/w5ZDFGVIdHyLFt8JtZM8h7c3MhbILHJJl+H76wrPDaCnp2mUTDLDp
	Ea/GtX7thI/mdQleUlhyitsn7TFmfR6zIiwfMzafYoR+LkTlsoDVhrhk7AczDOLYtEIc=
X-Gm-Gg: ASbGncu7T34zPJlfs8pr+qevO9CyIgQ8qhQVIZYMTf0UY5NUoENc0/IEIQDCI+CW8rL
	8dSRstHKtJocWg3GbN5NRBbzAhYv29HxMnw++yMvQLSAfRKRJMxPlQ36G5hAJoOgC2TaIPWfXxj
	udKVh+N2TURjFPzay0Psf7aJF2YZCdTJSTSNKyu8kYIHzEvg/lj8WqbfqpZr2lvdXWP7zmHXycX
	cjyyfSqdK2OM5EEItX2McAciTops+Ry6XzEz+EID65jFtl6XIGmas1p4ToU0tfaEanul7vixH7u
	sh4dQuBiFmfzjT+ZNYqQJ0esH3H9k7G4iQlOQnsHZ45CdKnlmY7Bkk5trC/3+Au81gdvue3JNch
	vnuxSUyB8RXsmUaqR1aWdcqwxkcAjPQHvGiKiV2AyxXUVkbtyyA==
X-Received: by 2002:a17:902:f605:b0:24b:4a9a:703a with SMTP id d9443c01a7336-2951a3d4644mr40113375ad.17.1761896523539;
        Fri, 31 Oct 2025 00:42:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IErQsbrXyuB98W4VZPUZXjD0BZVT230MCSsO+Cs/nv14Hpl821fyNtz3MNGo8AVo+zWHBt37Q==
X-Received: by 2002:a17:902:f605:b0:24b:4a9a:703a with SMTP id d9443c01a7336-2951a3d4644mr40112935ad.17.1761896523025;
        Fri, 31 Oct 2025 00:42:03 -0700 (PDT)
Received: from hu-jingyw-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2952696f0c8sm13276735ad.71.2025.10.31.00.42.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 00:42:02 -0700 (PDT)
From: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Date: Fri, 31 Oct 2025 00:41:46 -0700
Subject: [PATCH v3 3/3] arm64: dts: qcom: Add header file for IPCC physical
 client IDs on Glymur platform
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251031-knp-ipcc-v3-3-62ffb4168dff@oss.qualcomm.com>
References: <20251031-knp-ipcc-v3-0-62ffb4168dff@oss.qualcomm.com>
In-Reply-To: <20251031-knp-ipcc-v3-0-62ffb4168dff@oss.qualcomm.com>
To: Manivannan Sadhasivam <mani@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: aiqun.yu@oss.qualcomm.com, tingwei.zhang@oss.qualcomm.com,
        trilok.soni@oss.qualcomm.com, yijie.yang@oss.qualcomm.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Jingyi Wang <jingyi.wang@oss.qualcomm.com>,
        Sibi Sankar <sibi.sankar@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-99b12
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761896518; l=2593;
 i=jingyi.wang@oss.qualcomm.com; s=20250911; h=from:subject:message-id;
 bh=6+n6xeXIQsCm4bVQMKIbgwhM/8zK3b3MTjTKsWiI6vA=;
 b=muuDjORrusoCJOFXDoPlj2+qe43LxVBqjAwpJdfoRCg/bKnNy9FuWMna4emTiZgOO5GFCoOke
 ofjPpCWIkF0Aycj2lyZBMJ2/g7VuDWmZLXsLOj0JkGazqN6W8poFtMf
X-Developer-Key: i=jingyi.wang@oss.qualcomm.com; a=ed25519;
 pk=PSoHZ6KbUss3IW8FPRVMHMK0Jkkr/jV347mBYJO3iLo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMxMDA2OSBTYWx0ZWRfXzkZLY6rOrkWB
 eHzhJ+Tx1l1SgVaPoPuVJlrr/ItA70eag6fypacRY/etZTMCHoDxxBwj8TBfXiyLb8nVMF7aYm4
 5igOK7Rx+Z9shOfM+a6fvoL9Y1BTf/QmWnhSqhspZOhhgXFhhz1mP+CMw9VgESFTRyYITbMPkfD
 FBSMl5SFvFBzZIgFCQqn5GUG6NVFG3WXv0oXiKdqFBRImbRPF265YLNaBkf+Eq7YYcPrfrnYEVZ
 yDlQkGg6cqJ7Uj9MLXHIsR1P8xKnaI8rVQsKIY5mqk9mhZLfFvgfFuAWYqQXtiJJeu3CgJ4h8hh
 qh8WFLMFVBTc+sPw0JmAb2CzN68h1ZYGxK+SWXaxUOuqc85yXASyI51ww9WznVu8Dows/0IY2VQ
 ltibrCXRyoE/emEX9WNMSJXMQWB0BA==
X-Proofpoint-GUID: _ZIF3Mzt1lwD4-VXcImKziUMBpwiwj0R
X-Authority-Analysis: v=2.4 cv=TsnrRTXh c=1 sm=1 tr=0 ts=6904684c cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=469midWMXU5kPErhl_0A:9
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: _ZIF3Mzt1lwD4-VXcImKziUMBpwiwj0R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-31_01,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 spamscore=0 bulkscore=0 phishscore=0 suspectscore=0 adultscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2510310069

From: Sibi Sankar <sibi.sankar@oss.qualcomm.com>

Physical client IDs are used on Glymur Inter Process Communication
Controller (IPCC), add a corresponding header file.

Signed-off-by: Sibi Sankar <sibi.sankar@oss.qualcomm.com>
Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/glymur-ipcc.h | 68 ++++++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/glymur-ipcc.h b/arch/arm64/boot/dts/qcom/glymur-ipcc.h
new file mode 100644
index 000000000000..700cd7114909
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/glymur-ipcc.h
@@ -0,0 +1,68 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#ifndef __DTS_GLYMUR_MAILBOX_IPCC_H
+#define __DTS_GLYMUR_MAILBOX_IPCC_H
+
+/* Glymur physical client IDs */
+#define IPCC_MPROC_AOP			0
+#define IPCC_MPROC_TZ			1
+#define IPCC_MPROC_MPSS			2
+#define IPCC_MPROC_LPASS		3
+#define IPCC_MPROC_SLPI			4
+#define IPCC_MPROC_SDC			5
+#define IPCC_MPROC_CDSP			6
+#define IPCC_MPROC_NPU			7
+#define IPCC_MPROC_APSS			8
+#define IPCC_MPROC_GPU			9
+#define IPCC_MPROC_ICP			11
+#define IPCC_MPROC_VPU			12
+#define IPCC_MPROC_PCIE0		13
+#define IPCC_MPROC_PCIE1		14
+#define IPCC_MPROC_PCIE2		15
+#define IPCC_MPROC_SPSS			16
+#define IPCC_MPROC_PCIE3		19
+#define IPCC_MPROC_PCIE4		20
+#define IPCC_MPROC_PCIE5		21
+#define IPCC_MPROC_PCIE6		22
+#define IPCC_MPROC_TME			23
+#define IPCC_MPROC_WPSS			24
+#define IPCC_MPROC_PCIE7		44
+#define IPCC_MPROC_SOCCP		46
+
+#define IPCC_COMPUTE_L0_LPASS		0
+#define IPCC_COMPUTE_L0_CDSP		1
+#define IPCC_COMPUTE_L0_APSS		2
+#define IPCC_COMPUTE_L0_GPU		3
+#define IPCC_COMPUTE_L0_CVP		6
+#define IPCC_COMPUTE_L0_ICP		7
+#define IPCC_COMPUTE_L0_VPU		8
+#define IPCC_COMPUTE_L0_DPU		9
+#define IPCC_COMPUTE_L0_SOCCP		11
+
+#define IPCC_COMPUTE_L1_LPASS		0
+#define IPCC_COMPUTE_L1_CDSP		1
+#define IPCC_COMPUTE_L1_APSS		2
+#define IPCC_COMPUTE_L1_GPU		3
+#define IPCC_COMPUTE_L1_CVP		6
+#define IPCC_COMPUTE_L1_ICP		7
+#define IPCC_COMPUTE_L1_VPU		8
+#define IPCC_COMPUTE_L1_DPU		9
+#define IPCC_COMPUTE_L1_SOCCP		11
+
+#define IPCC_PERIPH_LPASS		0
+#define IPCC_PERIPH_APSS		1
+#define IPCC_PERIPH_PCIE0		2
+#define IPCC_PERIPH_PCIE1		3
+#define IPCC_PERIPH_PCIE2		6
+#define IPCC_PERIPH_PCIE3		7
+#define IPCC_PERIPH_PCIE4		8
+#define IPCC_PERIPH_PCIE5		9
+#define IPCC_PERIPH_PCIE6		10
+#define IPCC_PERIPH_PCIE7		11
+#define IPCC_PERIPH_SOCCP		13
+#define IPCC_PERIPH_WPSS		16
+
+#endif

-- 
2.25.1


