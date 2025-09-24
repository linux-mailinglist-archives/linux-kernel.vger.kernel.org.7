Return-Path: <linux-kernel+bounces-831342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE71FB9C67F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 00:59:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62C374285FD
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 22:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D0142BD5B4;
	Wed, 24 Sep 2025 22:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kESsrkZT"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E430629992E
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 22:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758754748; cv=none; b=DR90DuvKUfCrjiqKY61JWska6EZEgPm+WEk/+7bpKGkFRBF3nnH82MeQrATRi1JtYO84vGa9k4vZn+DC75I+P72VACWTYwZKL9OQTLQONtqUmDu5VeRpI87/Cpim7TAnpv0+/fUNb6HruIPADCVecvExd6E/g4TXINW/BqqNt4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758754748; c=relaxed/simple;
	bh=yy3Xacla9UOxbqXpSFYiKXWgjPcQnywvRkT5dQdRoDE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=e+61s9ZIWOS/GqtFtc2Jwrux+Kl1V/9pJ6qAGNwL7bhGscKblHEJ1sWe0cOgvKwYmqEHCIb+slb52yUIT0dqR4QAjJ9LH1m8YSC6VKIWgQ7GtNhhM2KuJmHzE8uTJ0eCRrnpD93DDjBRwjftvqzsLDVG94hq1/fBeJAaKWj39iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kESsrkZT; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58OCkQ0K029712
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 22:59:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	XDXmYjaKFwBzPJwxWOUUE13s34TjJw8/HcqN0CXLaq8=; b=kESsrkZTgEelK5YC
	CqAmUELec/AyuN+ZQN+AVMIbaolhPEVPXzaBYj3b0pxo6R3/8gGwJvnhcSRHIEvI
	3ewMXz8AgG9Ays04HwIxMvIrtfB91UdnTclHJksiknp2QF0A75g3Ac1K5XnkUIEC
	dbxO2RG+DibEsK+rmUi/5Q6EsCWSMpfyozv61xf2v+q8/0HOhy0pnlkuW3Ga+BzK
	SVw6w9/UPk+s1QxSRvVX76Ft/NuS6srOsNX/luroafxRtFT5MzPxM8bEbVkgTYtT
	2oQfmZq1XJX18+HPij9TMOjXVFlO8EIvNZ6XF1hxGN/e7mi+T8vg3qM1knUXrdUK
	dtBCvQ==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499n1fnuec-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 22:59:06 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-780f914b5a4so324529b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 15:59:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758754745; x=1759359545;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XDXmYjaKFwBzPJwxWOUUE13s34TjJw8/HcqN0CXLaq8=;
        b=talDtMY5FQcxE/enWBqMoJPPejJKgaBGQjU1lend7iraMTaycEUNZwWepIoHN5r772
         t0H9r8W8foIoB+21F3wJtGR7iVgdY/bNmAJ35dEFPgVTkMqrpfOvsJd6rYDKEUqjeB2E
         jwdB9RjlwFQR5vo1TAA+bdh/k1G8Iwz/W5eLaITSS2CPkd7DFkgJQy/w59MwrJ8O56ON
         Mx1cNkMTDbsZS+G2V/KaNNuTHg9THJapVl+4zkkM0RuD6IxnmHglMt416PZqSCvPGUVC
         CtqGfhjPwoBcrGfVvFfwaLYbwYcR5tbK72E0IqO9QFqf6IzqWetDQMQmZnQJ+XGajBfL
         yD7g==
X-Forwarded-Encrypted: i=1; AJvYcCUTIejPmKRbDWZUWHSJS+CwrGD01c4PXUVVm/EahPpVBZNBNKDg8pX2Nkn/HgeJqJcaSa92W61HgdJvKcQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2OHfjR56y4BHIQIlEnKgagIX88y4EPzyeXyNAX9x7oDoXXVSV
	aGguQ0hqDwnDN6l7IR59Neg/ZZQpRIMgMigb74f2GDTVCPtq/KfGXJupXNjw+c2AzfqQNodET1p
	Ym4SKIFy3tirwHv0G21dYJZouxLLivuKViByxwHO5WQioLcgIbgagWwyB5qOy1XtcZxs=
X-Gm-Gg: ASbGncs/tOvUxUDjKhZ618oFaDM31OR1cYYiNPM0zD0hER5Ztsnr0z/4eWO1GoOGtKU
	9GuTiJZMU42wpRXF3ttFSwlpsTKg2NyRg2jFE4DzWvm+cC+3QnmBoZfYAzvnAQfsPFm2GpJakEv
	U7DHCsEgwsgltaORtfYeCDGO2+MEXZWv1pbB1T7mrKt+KOMHKfSjm/+8C/aPKoyzqKnN9YLnF0z
	d9chfKFx8YlSQMXKJYOVqLuRKzXebzwbVnOl4MAwcrIsbT9ZqW32qxYIU4UayBfwzdgmyWwMP9W
	7uRBRFvopBl2LvMDWnVeXi5/4zdr1jA0MTlz79WUUnaSE2mVv3Pd+hLF4T17+Ap/kyTNkWILqE8
	oHqYTPOo8o3hBEPM=
X-Received: by 2002:a05:6a00:4652:b0:77f:d4c:d815 with SMTP id d2e1a72fcca58-780fcf12f08mr1845297b3a.32.1758754745109;
        Wed, 24 Sep 2025 15:59:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHXdNFszcYpPVOWvP7/6u2P7TMeM6jhJHuAYUv08poAqLgqu8gdyWlL7gMQG3iJ5ZaalGJe9w==
X-Received: by 2002:a05:6a00:4652:b0:77f:d4c:d815 with SMTP id d2e1a72fcca58-780fcf12f08mr1845281b3a.32.1758754744615;
        Wed, 24 Sep 2025 15:59:04 -0700 (PDT)
Received: from hu-jingyw-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78102c2b70esm111166b3a.101.2025.09.24.15.59.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 15:59:04 -0700 (PDT)
From: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Date: Wed, 24 Sep 2025 15:58:54 -0700
Subject: [PATCH 2/9] dt-bindings: clock: qcom: Document the Kaanapali TCSR
 Clock Controller
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250924-knp-clk-v1-2-29b02b818782@oss.qualcomm.com>
References: <20250924-knp-clk-v1-0-29b02b818782@oss.qualcomm.com>
In-Reply-To: <20250924-knp-clk-v1-0-29b02b818782@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Taniya Das <quic_tdas@quicinc.com>,
        Taniya Das <taniya.das@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jingyi Wang <jingyi.wang@oss.qualcomm.com>, aiqun.yu@oss.qualcomm.com,
        tingwei.zhang@oss.qualcomm.com, trilok.soni@oss.qualcomm.com,
        yijie.yang@oss.qualcomm.com
X-Mailer: b4 0.15-dev-99b12
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758754740; l=845;
 i=jingyi.wang@oss.qualcomm.com; s=20250911; h=from:subject:message-id;
 bh=n3FQrcuYcggx7GKYI3TsEagZ4F/FDBIko9Z+j9mcdfs=;
 b=IQENasXY7UJWL4ilhrNMEq82ty5OnDeUF56XaQgoAs7z0brkBSWz8zHZOmQl/uS2VqHI7eiiE
 KtywVyWntZzAKphL0R0s8L8sB/qzZi3ZXKuiWrYT5C105JMSjK9C0lg
X-Developer-Key: i=jingyi.wang@oss.qualcomm.com; a=ed25519;
 pk=PSoHZ6KbUss3IW8FPRVMHMK0Jkkr/jV347mBYJO3iLo=
X-Proofpoint-ORIG-GUID: 3OY3dTfyOX2u_ycNRgsLO_uMSdlNAYpW
X-Proofpoint-GUID: 3OY3dTfyOX2u_ycNRgsLO_uMSdlNAYpW
X-Authority-Analysis: v=2.4 cv=No/Rc9dJ c=1 sm=1 tr=0 ts=68d477ba cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=m9xIYplGfBuRHQtD53gA:9
 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAzNyBTYWx0ZWRfX9eyozqxu3HG1
 iK5wSxmZFAAIE7f9Z2urOQ58ORJpxP2uJGPDf+6R9UzT1PQ2oerpGg1BnX+bt9kEY0zet0E0MJ+
 YUst12pTBVq3bz+XfdZDGFmkOzaxPgrw+e6hXxQseh+7obzjKXUjBA95WMbFmZi90MS+oNx/Hkg
 SxZFCkQALFykUG6a9a9I0Xdsq45XfxSYnECK93Oyawp03pSamETP+aBI3qOpHZB+lmQGieNhmQp
 RyMLBZFTxNdRGTI+dpKZ/9ikG1bzFJbskdE0ZurFJUVy36g/FRBiFJb2YxK+baZBS0YN1iPxuIT
 BQP7LNfMqIzdHFnuTAcI37VoncV5S6F/cZ326v0vzwoU6huWqwxflsziM1bK+zAN1hDMamjw6uL
 DJ3IALMT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 suspectscore=0 adultscore=0 malwarescore=0
 phishscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200037

From: Taniya Das <taniya.das@oss.qualcomm.com>

Add bindings documentation for the Kaanapali Clock Controller.

Signed-off-by: Taniya Das <taniya.das@oss.qualcomm.com>
Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/clock/qcom,sm8550-tcsr.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/clock/qcom,sm8550-tcsr.yaml b/Documentation/devicetree/bindings/clock/qcom,sm8550-tcsr.yaml
index 2c992b3437f2..784fef830681 100644
--- a/Documentation/devicetree/bindings/clock/qcom,sm8550-tcsr.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,sm8550-tcsr.yaml
@@ -25,6 +25,7 @@ properties:
     items:
       - enum:
           - qcom,glymur-tcsr
+          - qcom,kaanapali-tcsr
           - qcom,milos-tcsr
           - qcom,sar2130p-tcsr
           - qcom,sm8550-tcsr

-- 
2.25.1


