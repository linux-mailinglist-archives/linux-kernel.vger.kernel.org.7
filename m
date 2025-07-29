Return-Path: <linux-kernel+bounces-748933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F7DFB147B8
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 07:43:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9802317F8C0
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 05:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 620DD22F386;
	Tue, 29 Jul 2025 05:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JGXYWVk7"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 603E823959D
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 05:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753767771; cv=none; b=TGWhNPKDrgdP7Pzx3YZ7gdtW8sPPMGqVJoXT6bWA1BfqLqc+5g5iB0p7TAcAPNMvoxHopHrp2bo3W7nXLFSiM1CvZdqAJN4CkLAm8sFPechAP1/fVfy5EEEUjYztpSP6wjNVJTJFRHTlatv93lTafPhV6VKhWwO2WUb1GRoFVlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753767771; c=relaxed/simple;
	bh=esSyQi0W7TyT2YkgO1r6tVX3e2HQHpTIX/6q2Ao/a/Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=t23icn6qRVO3TuYLg7oohklwYh/QkD0y8sK9BviXn5hfz2eo9J6vK6sh6VB/uAcF00CrFxO0G467jnpEIImpaXqfPO97Gq3bDf6F3CaCugJAcTV0yLEp+eUv9+AcUemct+4r8/cQ9Wipd7LS2FLO+/xcaag3RVUWZruFMTW/Z3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JGXYWVk7; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56SLd7rK004997
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 05:42:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6rnpiLU3hM22/JhSpmUfTbNPUyp22pzKiCZFvxt0pVU=; b=JGXYWVk79w1UQ9DB
	uWHR6uuD0pKY1y1X8F2Wq8hchuvhf51pE3Hw5W2wrIowEHPBt7aooHWbNWn8dWeU
	DdYTXzHK7Fh45ZpoMDGkfHv18VzoeZbPiq098AGb/GLC+w6zIXOFfrurNOdgxQNT
	aKLn88nakO4R2egjQNeZh3eLDsFkEm0doT+KroWoBr+s6yxK67qPaD5nOfhZ1abu
	14sWGf00hUaIhtWQbYKmQgF5lBwsLVh5/9JS5Oz7ucnWrNMVE3S+SEMFAQrN5KSC
	DS4HjUvmTlbiVFLhXm4YdUyqZp/1LYPkaTmhzYbbfbl7ZxxSDFwDiN9S+u6K83Iz
	RsKE2g==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 484nyty41v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 05:42:49 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-240012b74dfso18383075ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 22:42:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753767768; x=1754372568;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6rnpiLU3hM22/JhSpmUfTbNPUyp22pzKiCZFvxt0pVU=;
        b=j6a4nHYj/X0y3hlCiKeby5+06zrXKJ8bERLiSQfzSt6h0VXcsfoEXXwZB3xFSrZuF5
         VmrtAazyGPszzDH+NHRX+HxT5cyV1mKqR5FD57Bzj5QBCPN8m6LJ+2onELStMYZwR4MX
         FC90+4UKyrMJDsa7+8jsabpYfyLfivNBMCx7oNz0JCa4QUf5ubfgZFenQPKkTAUdhpjB
         PFIAjnbwm4XQOd+tmzhuFQ8xsQEEgzD72wrB3zqSspU9cVOL8amolehlkrbhCQ9+5DKQ
         J9DO4qTry11XBipBt46gRcQjnI/FLj3T8hI0XsObP2VpBFe2GMYmu+j0hdLIwO7i0SaN
         Jc1A==
X-Forwarded-Encrypted: i=1; AJvYcCXqant2rzyMrubTEU8Ar9DAZnpqg3uMokD4hh4fM1L7P79ET5CIPQszAs6cDjPCf3+/xvwJ79IM95kPHDA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9FcB1ZBxfd6hAOVnBUS2hDWEgojQ8MZNGSqHgAcdZsrhawaCj
	GSeIBwN36aaUtn/LGkjq/Ajn1TlIdT15ahXKsKPkYP66exdzu3S5kR+09C2Au6uvTkS5Is8CwO/
	p9BQ0odJ3NgzQAmGbOe1eQShAmuqL7IKFk54/ApXBqVYSfvGUioRE3RRrvKLRzKo5i+4=
X-Gm-Gg: ASbGnctlb9Nw1a/sn3RygZcsH0s86JkL9Nl3cMSLMuUbCqWVth2xACPzkR8GtamQ0Bs
	0+Tfcn51sX3Y22isRgdZhdkcChZDXT7Pn0Ea7/CvpX6XA150wF1BbBGQUY4ok1L2YY2CPS8eLhq
	L4O1iRqGdqhemF5eCUMRrwDltqT4H3gMOskoVEs7jtcaQpAaHnyGsoh7rZYOF6OZspD5Vrqh+fH
	xfo75ym942Up3M1QsSL7rwRbNDzBdEkcnhh/cyit5UUCHdKPJtW8ug3cAuoStN+1hojFS05kkIC
	UYUmsQ2kfWQOtt1DNyh3yBsHTWPoCtqD/zl2cKf4Hzkq/oOvIijcSTE/f6PjGVx7
X-Received: by 2002:a17:903:228c:b0:23f:d47a:c9d3 with SMTP id d9443c01a7336-23fd47ad8e2mr144843015ad.15.1753767768568;
        Mon, 28 Jul 2025 22:42:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGiYKbGhzM8cnhDQGbr6CQb4riSZZBU6sRu8Iv3TLyFtGnM8iE/iHelWGK4PqkoRYkCzceoMw==
X-Received: by 2002:a17:903:228c:b0:23f:d47a:c9d3 with SMTP id d9443c01a7336-23fd47ad8e2mr144842865ad.15.1753767768169;
        Mon, 28 Jul 2025 22:42:48 -0700 (PDT)
Received: from hu-tdas-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fe9b67485sm54505235ad.47.2025.07.28.22.42.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 22:42:47 -0700 (PDT)
From: Taniya Das <taniya.das@oss.qualcomm.com>
Date: Tue, 29 Jul 2025 11:12:35 +0530
Subject: [PATCH v3 1/7] dt-bindings: clock: qcom-rpmhcc: Add support for
 Glymur SoCs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250729-glymur-gcc-tcsrcc-rpmhcc-v3-1-227cfe5c8ef4@oss.qualcomm.com>
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
X-Proofpoint-GUID: W5PDT3yFBLfsbXoeTZvF0yGaZaCO_5Ng
X-Proofpoint-ORIG-GUID: W5PDT3yFBLfsbXoeTZvF0yGaZaCO_5Ng
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI5MDA0MSBTYWx0ZWRfX1SV5NikVJyx4
 Tbjrf90WUjf3lvUhxqcv4BykqqdJu3Y4BAmeA1JjLpWEuwKCNwi9Yq08iF8NmgMthEL5U5U5jmy
 zFaHd45IYEj77UOSYFkQ/EJT4VhQ6eEjW+b9/QW1Q687Nzzmf+gBoqLSJ3ZoOk3Ee0yHJkJvj9+
 mcVdjcRQ3WGyh7QPFMKZSSVOspVCuwiSVbg4uWzrQOXQhT+lJadCW3Lw09IZX17HoTfpfnDwES8
 YjH1y4pyN5tthuoku3bnCRQjHon3ICd0OKqtgtzifd5EgSUeW2XRI4A02CNHNN17FVcBNLNctjh
 QnFX4DxVnVuxut1NPq7+1YvkBMx8QspCkksX44mQIua3hpKN3g2KlOZ6jgAqunXZQfmOIXR4XUf
 MlL+y3wmB5RpdcrmzqKTmcEYZuYBWHll7tjiLA8XTod3YpUKT8mwgKkS1q3sRwolQs40llGB
X-Authority-Analysis: v=2.4 cv=CLoqXQrD c=1 sm=1 tr=0 ts=68885f59 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=Fi3-m60RFDWPkiaf7JwA:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-29_01,2025-07-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 adultscore=0 suspectscore=0 mlxlogscore=990 spamscore=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507290041

Document compatible for RPMh clock controller on Glymur platform.

Signed-off-by: Taniya Das <taniya.das@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/clock/qcom,rpmhcc.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/clock/qcom,rpmhcc.yaml b/Documentation/devicetree/bindings/clock/qcom,rpmhcc.yaml
index dcb872b9cf3e01f87d4fc546311eb758ee63af9a..27307e7bcfbc67853b91de5408b009cf6ca75ba5 100644
--- a/Documentation/devicetree/bindings/clock/qcom,rpmhcc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,rpmhcc.yaml
@@ -17,6 +17,7 @@ description: |
 properties:
   compatible:
     enum:
+      - qcom,glymur-rpmh-clk
       - qcom,qcs615-rpmh-clk
       - qcom,qdu1000-rpmh-clk
       - qcom,sa8775p-rpmh-clk

-- 
2.34.1


