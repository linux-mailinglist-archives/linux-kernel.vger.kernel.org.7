Return-Path: <linux-kernel+bounces-720922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72FE9AFC222
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 07:40:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C266D426105
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 05:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1377221CC4B;
	Tue,  8 Jul 2025 05:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nFPJ3RUE"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCEE621B9D8
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 05:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751953169; cv=none; b=IyyN6LBkazvg8Ckmnc/Pn44uKtog0r0C4aveqKBb/UABLsHlwoCB2H7b23CK4noUlOptxiu8n1PUoBCE+FrUDKnCOSNZbzhc8NGQg3FEc6StbGnO2BhpAcmCYbE/CUYuMrSxkIvHjTLORL+EvTNgkizLHo4k8KxiZVInLuhHCzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751953169; c=relaxed/simple;
	bh=lT5PB7dXwIIXFO0i8eyvOSJB9GAulplW7fWVdwUDmgo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mJElUulGT+J52ls9f3F5CXK1Me2Zwrr/Iiz55q37VTNseZ939CvrPeRuoUXcA4xYJiQ+Hr/vYMpw0jESQq6ARCnYkXhRw5OPBUlqduIW3xf32/80v98tWZ5R8Y2uqLRCkiViTPVDytcxRdt0K6L3oX80KbEK7AULGJRG466iyjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nFPJ3RUE; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 567JcfTS027037
	for <linux-kernel@vger.kernel.org>; Tue, 8 Jul 2025 05:39:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	aPfLV9M00qAl9d8R2iZHb1VLVS8KvkSc9PWuCfqic0M=; b=nFPJ3RUEX5ODeghr
	IglHjO70DUVRFBOWRxhYBVsK39hLT2wgPFfWODrbCoXI/cTseCQ0PbBvkEeSdskf
	f26x5S0T/M0TrdAZuFsXuZXRllfEpqOfcZvfWLpBTWG5Da0yVMXc7QA4JWkPxV7S
	qYA/pj6lXHelxgmvwu2DVvL6WQY/57tFVcOW7brtwiFUOiXqS7AY0D4FF7U/pg4V
	lXhQchHtDJVmwL6H33fbAW57Ft5m7i2jKo1ZhuT4z9fZOkXYEyn2PCw+wyAtisW/
	W0jF2UpQWXBDgZFGVhOTRRLQL8RxvGrII//89nJ0H6RHNUAoLjX0N3nE/UEaDoiY
	ohkDPA==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47pv4xuekv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 05:39:25 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-74890390d17so3725889b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jul 2025 22:39:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751953164; x=1752557964;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aPfLV9M00qAl9d8R2iZHb1VLVS8KvkSc9PWuCfqic0M=;
        b=vBXFlXhb08DbdC6hRvkvsriRQP3Z+rnRO8Tu+Ghql/vnub83P6OYGyS3X0HXH9FvLW
         8j9osQNE62a8KkDgLPfx82nPoKrPx0M+NVR2u8yvQEBVKCFMIA6CQtdRATNCm+UtQFy/
         f4nWLzK0Hxq6ngOTlycPh+HZWy9bKeUhNHZXzYTPGrXxE5h2kpPWgGauY1LBTYWDV+Vb
         Iu8z3Ip84LGPc64pYZhsiM9FEWeO9AaAQ1sQzMPOmml5FAnns8s+XHLCGzeP5YklRwFY
         w1iyOealn82uWtBPwYr/nBCh4F2DCkKUzA3AKCpOErJl/IB82da3sT+k5E3XxMp/fRSm
         xTfQ==
X-Forwarded-Encrypted: i=1; AJvYcCXZIMUGcjMIDyX8ZgEaShMcD6BFeBZ39Ab2+GzVrlLRQ0ZhS8pCfQdW/4WWHOln5p/K57KJjgkgTyrrYz8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwX+RLKng7oxojVF+99RB0R8rbkYhLwcVQBE6IsFxL6eb735f0L
	ZfawbUCUSp/pTXkYLbHInQphL1cjOPG7YglzXRBW0PZzbsC7OfmRDSPvCZjk+DJa4d18XcVxi3D
	4a8C21Q4+m7rDo78DlAqd7JEJKyA1ngyABBab5T139AOjy86TQlWe4ZvClFnIiDL73NU=
X-Gm-Gg: ASbGncvEpCAkoGxq7vL4YuUQjWjwEuIKC6HGshh9JPw18t3WbMdVp8MBZX9GIywWjr/
	ttZoTKnw8qmRpjCndcRiotf3ReurSuLdtRaBH8HgCojd927rahAGLFvxAzAGGDQIBmORT5eiGOi
	f8FrHNOjTQGmvTiN679ahVgRfJxm9q6wknIgzL/CJPWJgQ3P/z2w3G9vQhR3hUv60lShNZWCGnA
	gYQ8KAXfWuQcozAxmNBpUUKOzHyPui5QpZT0U9VoM79VDKcR+CVkMLApAaHL9KAFD4Xx24SKwV5
	oIvKbQUIGxbGZTtw45e9spCnbH+VeK/nXFzfMLCi8MdUFiyUTECg41a7//D9ogE9DV3nHVThgND
	si97hczl/3HGDiIqOMGgkjQ+IUmEJ6r/wXNFM6QhqPckN81QuttOXyKh0Xg==
X-Received: by 2002:a05:6a21:6d82:b0:220:631c:e090 with SMTP id adf61e73a8af0-22b18713b55mr4540367637.0.1751953164519;
        Mon, 07 Jul 2025 22:39:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGChGw6sNcWe/JFiWUOFUfXXFqcpcUlbdGkgUolO6ruHnb30E2eS0cJZ1gNhCedjJUFmEWLRw==
X-Received: by 2002:a05:6a21:6d82:b0:220:631c:e090 with SMTP id adf61e73a8af0-22b18713b55mr4540326637.0.1751953164125;
        Mon, 07 Jul 2025 22:39:24 -0700 (PDT)
Received: from hu-kathirav-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b38ee450db7sm10531829a12.4.2025.07.07.22.39.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 22:39:23 -0700 (PDT)
From: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
Date: Tue, 08 Jul 2025 11:09:12 +0530
Subject: [PATCH v2 2/6] arm64: dts: qcom: ipq8074: Add the IMEM node
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250708-imem-v2-2-692eb92b228e@oss.qualcomm.com>
References: <20250708-imem-v2-0-692eb92b228e@oss.qualcomm.com>
In-Reply-To: <20250708-imem-v2-0-692eb92b228e@oss.qualcomm.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1751953154; l=1247;
 i=kathiravan.thirumoorthy@oss.qualcomm.com; s=20230906;
 h=from:subject:message-id; bh=lT5PB7dXwIIXFO0i8eyvOSJB9GAulplW7fWVdwUDmgo=;
 b=niksS5LQJ6TwnbzorWTwOgTbjlIOgt26OBcGHXsy3FMhrYCRiusb98n9UTlBGethU2GgMq/aW
 BZKDOD19mOdCfD+bVU+o0qxMGxEo7NDyzXqJ744lgepq3zZcealUPaz
X-Developer-Key: i=kathiravan.thirumoorthy@oss.qualcomm.com; a=ed25519;
 pk=xWsR7pL6ch+vdZ9MoFGEaP61JUaRf0XaZYWztbQsIiM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA4MDA0MyBTYWx0ZWRfXxFfSpe7+I4n3
 yO/UNvW2Q0NfgoaZcTbIS/BSOkJw9eOMHe3YeWidWcNCzp4rXwfQ0CcJnuE0jiURjtzvJ03ZSTH
 vwtrXqvjsZ6fPqWMoTlP9jBCJ17Nz2jAM8tWDoDP1YftWrpIzXdaX/WADM3cXEnMbeKjfKOHn6X
 qnBalLj8L7Pc7MV7eeu5M31pBOgE1RRrfTRy6eIN6FuPP9OUDL7AOJK1amgZq9mq7DIG6vsviK5
 w2lajIELR+KsLf6RZwzIER2ttw4gXfHMlQiFjdsHfWmIHOusXKBzvED2FV6pW57HtiJXHzgmD3q
 /NBr78D6Xk3AnSjr5g85xGWyXjITqo71I9RGLLZuQ0XQ08VTi31eHIe+PqjcN02/WLkfpMUa1UJ
 CyiTDJGlHWPJ1r7666xvdMXMX5a6e+l2HcBf+csw6oo+Q1jtqingghhkDAzVVAKoYdUXH3bt
X-Proofpoint-ORIG-GUID: tnAxCFhHpsUlO1ZILbdg4O6zehqGZIek
X-Authority-Analysis: v=2.4 cv=DNCP4zNb c=1 sm=1 tr=0 ts=686caf0d cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=iL0243cPoFzEVPe9DKIA:9
 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-GUID: tnAxCFhHpsUlO1ZILbdg4O6zehqGZIek
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-08_01,2025-07-07_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 spamscore=0 clxscore=1015 phishscore=0
 malwarescore=0 mlxlogscore=791 mlxscore=0 lowpriorityscore=0 bulkscore=0
 impostorscore=0 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507080043

Add the IMEM node to the device tree to extract debugging information
like system restart reason, which is populated via IMEM. Define the
IMEM region to enable this functionality.

As described, overall IMEM region is 24KB but only initial 4KB is
accessible by all masters in the SoC.

Signed-off-by: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
---
Changes in v2:
- Rounded off the size to 0x6000 (Konrad)
---
 arch/arm64/boot/dts/qcom/ipq8074.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/ipq8074.dtsi b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
index fffb47ec244899cf45984adbe8c4f9820bef5c5f..2ba07a02c222958b924c5bc178ac67f955088f7a 100644
--- a/arch/arm64/boot/dts/qcom/ipq8074.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
@@ -625,6 +625,15 @@ qpic_nand: nand-controller@79b0000 {
 			status = "disabled";
 		};
 
+		sram@8600000 {
+			compatible = "qcom,ipq8074-imem", "syscon", "simple-mfd";
+			reg = <0x08600000 0x6000>;
+			ranges = <0 0x08600000 0x6000>;
+
+			#address-cells = <1>;
+			#size-cells = <1>;
+		};
+
 		usb_0: usb@8af8800 {
 			compatible = "qcom,ipq8074-dwc3", "qcom,dwc3";
 			reg = <0x08af8800 0x400>;

-- 
2.34.1


