Return-Path: <linux-kernel+bounces-831409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EEDFEB9C954
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 01:31:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E32B01BC41DE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 23:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C3BC28AAEE;
	Wed, 24 Sep 2025 23:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="O7b0lg8B"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BADD27E1AC
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758756705; cv=none; b=Nbmbd4gIh0Qi8mADjDBTbPRpcH3EoHDtVmdSjDSqz9B/z4TK8x5mixSy0jzc0+NAsCJM3QVf1GWOX+SniuUe7h0of/9Hp0vgZI6qLYIlio0x6Ep0oukYp8FRboWXq7sOHMM7ZQtG1/HE7oAzKEjiIlh0BlLP9yyQpKOckpcMngA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758756705; c=relaxed/simple;
	bh=wXNnd7mo5fJeF+EfIqe4rvJrO/zhXKq6+nkowY9OvnI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Fvj6HvoTYEUuMFpnTKnnX4kLlcEHbUYiHYqIpFzAO570kNyp5R4oLsGdsoUJouSM8r/iqCEdqgHoQAxicyfab4Q4bjFO8+tp82YqEjGSDn84gTS3DUKkrXP2ygj83dojHC0vhIGiRlsOoT2pUDmDkXW6r3wkFxiPdyk2Qxu36s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=O7b0lg8B; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58OCwCQL017456
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:31:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	bIBMNjflRa5jzwbyfLjwjF4RUv1x+p6yVbJhMuG67JM=; b=O7b0lg8B3ZUSAxf0
	TbazgpNlHKXtzHI3mL9OSp0v7uUXckU18PNJP/8GghBgD8nes5LWVDGYPpGqVhGv
	Cyvxf3FEypzm8Y6RInIIu6cybWkKxBA5Dm8Y6cvHKLnHSTzJ6F9sOS7W7xWFD+R0
	5TcbSD2EPo8wWhjMm+VXeo/HSLrz7SI+nqRts7a8d6PVfSktgF4y5RIBpNyPc+y9
	KjOO6LaWmScKvs/5BRoDnxOW01TXT1VYM6hDuMyyCCzp1MKSnXSbqwLdjw7J100+
	JgaEYWZybyu3PtrPjqwcPi+mQFZ1VVudFzx9FEY1yJsA/FwV5cZlGuq/MRzb2jIn
	lm21Mg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49bhvjycce-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:31:43 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-32df881dce2so357989a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 16:31:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758756702; x=1759361502;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bIBMNjflRa5jzwbyfLjwjF4RUv1x+p6yVbJhMuG67JM=;
        b=Kzhu76wRzWi023ErKdP5oByH3f2Dd9kEyvZzlmboyaIR2/T/Ai42Vyq+cQ5mhbXVqH
         fXPQRVUrZ+kWqivqoxNCAhpzNotROLPrH+ndxDO/9+xtGRqpjUNNqUtLBPEXcgTO2YvR
         1I3cISKkhu/X0GD33vTkcc5n2TCxSbv62qRV8fgdmj5/+sZ8EbsciWSANKfb4yOEF/dT
         Rg6SGJPJvYGJ825ADMizL9XI6CrRT7FWw9sCTlh+sGBMRpPsXs+gAQqWlrsG6VDLHHMA
         GhQeQFVbiy+kHeM5HJBrIE/PSsZkX0FgfITgalGBMgPzKYkOOw2Tit5JixNYllF+gNei
         6uoQ==
X-Forwarded-Encrypted: i=1; AJvYcCWTPrHttXPrFz/l5UMGtdFL2rsoOii0EvBjn9fxNe6QgCOgcTKikneLYEhrcHloLeRC6/nwzs9UCjXzAYI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxz/1Ig1jcoy++bosDqvOXbrkKGZADSGImghZ54+mU0/mnSiL5i
	dXS6UGgmxnDRGmDIbvhxzMH7s40yQ2ry63TKK6liZ/MS2BuqKhOZkpEics1wt1jSNHcPXzd3ovp
	vqBXj/2nHvgiesRO9bpMK+0fGIfkNKEr/wxB7L1div4LsOGhU/MRnb7n8t0OtqMsyyQUZoAq4Zt
	GPIw==
X-Gm-Gg: ASbGncsy1FKpiSxVrJq4fcJySApX/0JHZBK1UrgKaXQR1k8hCNnBR50PXHt6kVn//W8
	WESjjytOEVnpy3eFwDAEBwvSzGpolOPVkxGvtTgZrIPulCnRcWPMudWVaCp8xVrCBo4Gf80UY2/
	O48xQBpEGoutEPqSI7f/zlAnqghouPGzkkEbRzqMiq4L/56kOSVjIk6aw/VUd7oXvGUjCo7H6pb
	iWxYguWVcGn4/I/R6GwicKik2NbRrB59PrGtFRaaBE8f8apgpmBlmsX8Eoxb4ygNLL7jJCutPk/
	lfJdo0yVg61f6CWPhcxwK/1ruwL/2ASuKRGcJ9dkGinCeaBJwGdDHyyqcScqbJefpD+gDtiuoqb
	zD/V9tQsPE1cLgAg=
X-Received: by 2002:a17:90b:4a4c:b0:330:84c8:92d7 with SMTP id 98e67ed59e1d1-3342a28b80cmr1757094a91.12.1758756702042;
        Wed, 24 Sep 2025 16:31:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEbGHswp8+HdmDWy6LMMlKCl6gUqqzepmWEukpmqovXR2wNzS4aq1fg6hLyaHQizCT5NKll3A==
X-Received: by 2002:a17:90b:4a4c:b0:330:84c8:92d7 with SMTP id 98e67ed59e1d1-3342a28b80cmr1757069a91.12.1758756701617;
        Wed, 24 Sep 2025 16:31:41 -0700 (PDT)
Received: from hu-jingyw-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33474f14e4bsm194322a91.28.2025.09.24.16.31.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 16:31:41 -0700 (PDT)
From: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Date: Wed, 24 Sep 2025 16:31:36 -0700
Subject: [PATCH 1/3] dt-bindings: soc: qcom: add qcom,kaanapali-imem
 compatible
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250924-knp-soc-binding-v1-1-93a072e174f9@oss.qualcomm.com>
References: <20250924-knp-soc-binding-v1-0-93a072e174f9@oss.qualcomm.com>
In-Reply-To: <20250924-knp-soc-binding-v1-0-93a072e174f9@oss.qualcomm.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Robert Marko <robimarko@gmail.com>,
        Das Srinagesh <quic_gurus@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jingyi Wang <jingyi.wang@oss.qualcomm.com>, aiqun.yu@oss.qualcomm.com,
        tingwei.zhang@oss.qualcomm.com, trilok.soni@oss.qualcomm.com,
        yijie.yang@oss.qualcomm.com
X-Mailer: b4 0.15-dev-99b12
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758756699; l=786;
 i=jingyi.wang@oss.qualcomm.com; s=20250911; h=from:subject:message-id;
 bh=wXNnd7mo5fJeF+EfIqe4rvJrO/zhXKq6+nkowY9OvnI=;
 b=c5aPrZjdPN/hNG3ybepN8IMXT7vQqDz7rID1e8NYhAnvcF13FX+kLpHriPIgTY3U5ofqRxVHr
 S3C4btxFeumAQ4rpWwbz/HvfNf4oJIEvI0x+iGGgJIniUTLf7JKJadX
X-Developer-Key: i=jingyi.wang@oss.qualcomm.com; a=ed25519;
 pk=PSoHZ6KbUss3IW8FPRVMHMK0Jkkr/jV347mBYJO3iLo=
X-Proofpoint-ORIG-GUID: 1bgP5qzGlQD4ZUshl93PUEqAVz1M-ki9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIzMDAxMSBTYWx0ZWRfX37O54V1EhuNh
 LZUoZpdn98KwtzFkI1q8ieY2cW89FcjCQEuEHW2BIbDFH7J5P5PIkgMJAwBdHW73iUjZHJjUh1p
 VGbRWi5X+4HxHHkGb1C0uK9wRI6RS7yaVnHgS9h30aFVBsRCV+jGskJpMemx6Ga1p3j+EXWAckl
 CjQorHCO+Mc4QNW9ECm7o4TqFYXj4GBfYK5voWNFZLSN9WWgalgAE2Ep8OIdGcioGW3HML9OFfu
 BDIZSq4wrWqmYhSSt8Ms29v79uItp7LR1g+uiFHpd7FQZ/twKS0v9f2A3l7Hf50Jff2FpucEcx4
 /Z2I+YjM6yIiqXEq9JM312ag7b8sKx5Eof0ZCLwYHcbiPmZNDv2DVaIgF5y/Iyr66wJzGzkrj68
 bSTtf3A8
X-Proofpoint-GUID: 1bgP5qzGlQD4ZUshl93PUEqAVz1M-ki9
X-Authority-Analysis: v=2.4 cv=Csq/cm4D c=1 sm=1 tr=0 ts=68d47f5f cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=Ety4sU5WZCxzx5fwigcA:9
 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 adultscore=0 impostorscore=0 phishscore=0
 clxscore=1015 spamscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509230011

Document qcom,kaanapali-imem compatible. It has child node for debug
purpose.

Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/sram/qcom,imem.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/sram/qcom,imem.yaml b/Documentation/devicetree/bindings/sram/qcom,imem.yaml
index 6a627c57ae2f..1e29a8ff287f 100644
--- a/Documentation/devicetree/bindings/sram/qcom,imem.yaml
+++ b/Documentation/devicetree/bindings/sram/qcom,imem.yaml
@@ -19,6 +19,7 @@ properties:
       - enum:
           - qcom,apq8064-imem
           - qcom,ipq5424-imem
+          - qcom,kaanapali-imem
           - qcom,msm8226-imem
           - qcom,msm8974-imem
           - qcom,msm8976-imem

-- 
2.25.1


