Return-Path: <linux-kernel+bounces-754688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C9F4DB19AF3
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 07:06:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9F3C18927E0
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 05:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8790E21FF5E;
	Mon,  4 Aug 2025 05:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WyCviMyr"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8818C153BED
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 05:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754283988; cv=none; b=OM+YQdOpV95jHdsyYExESdacolj0C3A1pIFo56WEdyTkeG7MJGwXTK6/3CvrzpJ1+sjCgOVkgOU+x2lNaWPwxgvWlEEKr2tEMmglOPj370yiwITf0YoemUO5dJ2QcG/BetipMVmCiH6lebR8xY0G09z8Cn8jXabPIceaNoiHaNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754283988; c=relaxed/simple;
	bh=Ul1dVZpeOTw7qaiph5ZpTsDcTs9gmOxaff1msl2kru0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ORuvBTyuAXeU1JqkSwiekkSJ8WPUmTRVViO1vE3LOq4Vpnfhynjr3jN5qwOp083lzrl//HxdxqmVlh+BoC8SEx8XtFf7zdeR4eGQlIqhehBM86f6WD5fgj8SRst5eJtCj83XEeXhBffQFisNpY5jE7RngSM+tbXscQOePfBsvSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WyCviMyr; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 573JrNZa019944
	for <linux-kernel@vger.kernel.org>; Mon, 4 Aug 2025 05:06:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=rRAvA28iaBx
	d6Ygxlq1Y+dMf1EQJkDMl/h16ZgOVLds=; b=WyCviMyrpzJcpnJwG1Dnh468KUU
	/vrD70EZH6FbNpJl1zTo2P5Wl0kFHuqXOHwz3aKuaURfYB7cjUzrmiF6F8b7BKOi
	GmLLZrT3yNaGacOFWpDCKmM7uP+c5jM4jzDAh9jyPALubkhwPhwYjl1fO08m+kdm
	8sqYcQHZPtxD9cOobc0/yGM7Rgn5QBQbuOHQ8V4tNOKSStG6V5fXVCxLtEy++BTW
	lzd0J5eIHPkFLFpqi+0Hy7bwSEmapXkVas8RURDwu8a3ue+nuLCBKdYhP0H450MU
	dPGusjX2jcBboadQQbQsvm5JQmH6O/gJ2ZdAiH1bP33g76GHSF2U9DtGWYg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 489buqken9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 05:06:26 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-240012b74dfso23678285ad.2
        for <linux-kernel@vger.kernel.org>; Sun, 03 Aug 2025 22:06:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754283986; x=1754888786;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rRAvA28iaBxd6Ygxlq1Y+dMf1EQJkDMl/h16ZgOVLds=;
        b=ispOyHlugGdmi/tJR8fFYgpqErTgcgCEvJnkMTpTkw7e7tJRzK17biJ2TtzSBdqV90
         79MgPqFUUMW/+By3IBjwhrGGYL6KajbGP1NDJn55D/U0rydi+tHd7wUaN2ITjZTvmlDv
         /9qxriVnNaM+Ybn4rVeGkrcaCddkoxUvZPMr+QMMfrKOmwpSC+RLw605a/0PhuNtxyd5
         CX8GDlgmsppceO+EZGxOyP3xLRF4jj5LjkZ5egM/vFKwIXXboI6zwr2RYUMGkyhS8ZlA
         QvFcNrUXF+bKJ+Q41UfCyFJhOwdr1zbAQNxqE35iqVVAuum3cUB42226ynOfNPfl/Iuh
         I8lQ==
X-Forwarded-Encrypted: i=1; AJvYcCXMEiTLHLPyg6Jm7Xw2IMDDK/8/sNx7G7bKvxM97ZHqdNZkXEm4+oKdPkSDuxO6pbqvsaAsHCwoFJqwrM0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRiIMyBAtla0mHNgTTNP8U3rTnLP7pH1U4VdMjjdvVPFGdAYdJ
	vZk3fXtsY6SRfSQar8+uNdust1cTk+jNqlrRLFonHRzBp1lKhs1MmSUDk0IJCE3TbEsuJismhsY
	JjTgKLfgbMzGstgraOlIEl0WTqKLCLEzGNIKv72RnEOWzpRHmkUZB8hCBGGmsTAcSgeA=
X-Gm-Gg: ASbGncueHeAjlZxa3Nj+F2Mxx8xJGFtnIhhU30tm7TwrWmlPOQZZIbeFVZU41NRqPb7
	Y7JTk0AJz8B3AKb2MW1cNBXN2h61ko3trThPSJzjSR/ocz7SabV8MYbQFzmABB1l/4qAIKT3s/j
	rqDMLxN+I2pofViDIUp8xjCcE0YZwQJCnIqt3qTOZPbG2eLapmCOIiaBFr4/P7LQQkAdDjK+YRf
	PTpmFEklg4OKx5oJFrYRxMRzAxVvktCbDDNcWRhGKxpSv73OZQNhig1Ex047yRbeLEj6s1ezCaF
	IGRv2BNeyWuuBYeQIgZL6Nx2D2m42ywdSKAIYAEwkjKjjsBdWSxOPcttu7TI2y84Xb4TPzNzGge
	NW7o=
X-Received: by 2002:a17:903:1a6f:b0:234:c8ec:51b5 with SMTP id d9443c01a7336-24247356230mr131570175ad.53.1754283985542;
        Sun, 03 Aug 2025 22:06:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHpOOQvlVH6nFPP8utCjukSMyzVv08HQLDEblBTCrRyhJpR4aqOo+5iN+aSbXqu4CeNn50Q2Q==
X-Received: by 2002:a17:903:1a6f:b0:234:c8ec:51b5 with SMTP id d9443c01a7336-24247356230mr131569785ad.53.1754283985128;
        Sun, 03 Aug 2025 22:06:25 -0700 (PDT)
Received: from e0cec1fbb194.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1ef59b2sm99705135ad.7.2025.08.03.22.06.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Aug 2025 22:06:24 -0700 (PDT)
From: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Odelu Kukatla <quic_okukatla@quicinc.com>,
        Mike Tipton <mike.tipton@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
Subject: [PATCH 1/2] dt-bindings: interconnect: Add OSM L3 compatible for QCS615 SoC
Date: Mon,  4 Aug 2025 05:05:41 +0000
Message-ID: <20250804050542.100806-2-raviteja.laggyshetty@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250804050542.100806-1-raviteja.laggyshetty@oss.qualcomm.com>
References: <20250804050542.100806-1-raviteja.laggyshetty@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: qGjvSRwlFoQ9KOeWAKQV7YKtUFiO3GPb
X-Authority-Analysis: v=2.4 cv=VZT3PEp9 c=1 sm=1 tr=0 ts=68903fd2 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=bpSexm00WYn9fMQEYZEA:9
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA0MDAyNCBTYWx0ZWRfXy+T87/G2ZPsb
 oFweD3gIb7UGoCV9A7G3JRYX8xzWm2tjRdByStC1Nn3+568cwHzZd+p4hfc3RZIPcg6+d1dqDhe
 usYGD3y1MoDtHC5zrAi99B0bYy3AXMM9FrSAHJl4LAdlI1Fg5y0azkepweAkktMBK9CJMCGoepd
 slIrlOM60s++GQ7fiquA5nFdBKJ1AedT6J5FFcceWSjXTo1p8aByPoBdBf4f7zq/UaXK56DCMVp
 jPW9jHZpR7sSHeHfgi1ah5rC7UM1QRQ8+2NEaYTQwfcqv/0oCSgS6wtswcspiRALa3f756JO1pn
 T6vqkzWDMEqoz+5V9bM4d5rpqzxLm3Nv5N1WQKKTfuaVOGHjQFnYvTfER2rOXokGWyhF0NygBzJ
 uHV1bCawRVwViVmenqHq9EWYuqOeAEEzUQDGBpbBItMt2IvXs5zRTseawgDlUDKxc41QlSrl
X-Proofpoint-ORIG-GUID: qGjvSRwlFoQ9KOeWAKQV7YKtUFiO3GPb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-04_02,2025-08-01_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 mlxlogscore=999 malwarescore=0 bulkscore=0 phishscore=0
 spamscore=0 mlxscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 impostorscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2508040024

Add Operation State Manager (OSM) L3 interconnect provider binding for
QCS615 SoC. As the OSM hardware in QCS615 and SM8150 are same,
added a family-level compatible for SM8150 SoC. This shared fallback
compatible allows grouping of SoCs with similar hardware, reducing
the need to explicitly list each variant in the driver match table.

Signed-off-by: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
---
 .../devicetree/bindings/interconnect/qcom,osm-l3.yaml        | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml b/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml
index ab5a921c3495..4b9b98fbe8f2 100644
--- a/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml
+++ b/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml
@@ -41,6 +41,11 @@ properties:
               - qcom,qcs8300-epss-l3
           - const: qcom,sa8775p-epss-l3
           - const: qcom,epss-l3
+      - items:
+          - enum:
+              - qcom,qcs615-osm-l3
+          - const: qcom,sm8150-osm-l3
+          - const: qcom,osm-l3
 
   reg:
     maxItems: 1
-- 
2.43.0


