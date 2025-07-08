Return-Path: <linux-kernel+bounces-720925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33A86AFC229
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 07:40:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D61E8426613
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 05:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B809D22126C;
	Tue,  8 Jul 2025 05:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IEQY2DUI"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90AF118024
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 05:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751953178; cv=none; b=nJWlbjrLPA8Mc0wu3NwQAwB/NU5RQ89uL5DS9f1wJ/8z/NT5WClIV2VGmUmzBQ3LgMIKDNxluJB0RB3zG+JeNrDyd2u5w50GcFOGDQ1XS69DMRd2IVO3ys3i7do0Q3H8oK+3GiUHlo0pts19Rm9EuOGdvzinKUUGCuIIyxB85GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751953178; c=relaxed/simple;
	bh=VfK8mEDpXLVB6H57qiYobVaPCMl4DeUgsq+1SP8HFbU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OwwrQbLKNWCkxG58ortnLMQ8bbl/wMVI4F8KXmzOKG/c+3bLWJWTQ1ldOdkl1GJ3RVc91zCsqKGqzQXXFnql/iC835A+aMkYdpRYvlo1GIs0FJiEWoR8Mq8GQRNT8oWCL9Y4jtKsPvHL98QVLrSATqL9kN9LC7fktWtfWe9MU4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IEQY2DUI; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 567IXOln032557
	for <linux-kernel@vger.kernel.org>; Tue, 8 Jul 2025 05:39:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	g5I/YdYhWivNVueACzh2oQkNO+/A7/RRFIBqM+SoH94=; b=IEQY2DUIMQ6slCJf
	BGdelgsLzUtEVGb8KcUZbroUa+/GtpfLtgNewdO7vymrXRTK7Fu2xoxqtbp/w3/N
	BW2T05amihrY0PYMCUaO4lKA1LMQXIxKETpPqlFcFF6JnTWhBSvQn3zBzGrXSEGu
	fQeD9D70jUV5y6j+8k/x9yPEAdjY9Us7rApmRmd3FzgcKrOuTtAidoNinxBKZqP5
	yHa2VGqSWtUD+GqveYFJu9Pd/f2lEueK9WEBbqeCzCHw7aaQRAji4mzwACn1sBjQ
	sq6edHnclIC0YKE4EXrBILU9G4obPLYsguO3fKqkO0VaqS+hWA0FXv195JOVMp5p
	uzXyKA==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47psdqufj2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 05:39:35 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-748e1e474f8so6156845b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jul 2025 22:39:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751953174; x=1752557974;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g5I/YdYhWivNVueACzh2oQkNO+/A7/RRFIBqM+SoH94=;
        b=Rd45tnB9pWJ+asvF068F/ILNDVaTjTg+s9MF1FwB1PS25kDTgi9Jh7opC3kqFv0JRv
         hQ0dKXA4rWhU4Ge9LxUwrpfst60/Uqer1A8/ZtcViOXD0Y2LOCaCUVjWi9ZFnZi5YtP7
         q/zyNJFeOVjsVL1gfY/MCBNVvUmoaFPKqHNDMUnFmG9X32adXDrOZcXU27y65axuY9/r
         gcPOrzGqFrkpGb7gVreZb3CzHtFfGOq5Qzl+Z8sD92blauikuurDx6c8emxPXbp1mnQI
         ujfh6Ya13d9LT7FB2EPRrQ4f6E92Grnc9smwHP/bpUY1urYbl1BkpNDpxUqhzdKnY+c6
         gGhQ==
X-Forwarded-Encrypted: i=1; AJvYcCWQpSYjKfCu6gThFLNXO1SaQ8ItBet/JZ6Ey7Ua0LLqjlEB8lm3XPCbXfrfPm9+IkQq3a/fvDqHfAZBxI4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxr9/00o9gC0kNZZLDTaGURUOCx1WjwQxZndjaxJYczHhkpfmiN
	Jskdde7oylMejzqXp448bHRfQ4x/3eTsa5HFb/tjWu6Uf5vyk9uS9OaVhpiLQ1533JgnyfRMSCF
	cAiV2Ab2A4ikqXFCPy9+Vp8NhKbb6VV6YcbhNS460bwkmZrTD/jdoZG7ej4q7vIM4Q/M=
X-Gm-Gg: ASbGncvMQp2pMsZxxx6ffNU3Ol7BdHWHokTAGzOA8wC+1yu/LsGklGZZXy4y45Nz4wD
	gPC5GsF/jQyKD6xYYxp65/1mN/6545wSGI/lmGSO/YlasXmaxMIGobm4TOTesmaapHpQTaR6urt
	gkGSXlECNOX4LekgJqMXeviD7pM+CPFE7+t+XP1xKLp/dBTQnD9apzxwecprpjL4QSdXDeHnBNb
	3WvCqvF+82NrUYFW/XRuOozAMoXNHbtbWU+1zUb+Dj5QRoowL5vR0qcyN3ftviC+6NPD+atFaft
	1zkkQrdR9VHNsoUorLZhLH1UuRrVbJKNOOttjjZcikKpePp+RE+Ez6NduKF+TRqowuT51lQvJxw
	OyYBj3NAawQm6T4+8gOF6UaxFRnxB7l1SS1O94yyi4rh9Juaa+UwxWLWHEQ==
X-Received: by 2002:a05:6a20:d80a:b0:21f:83ae:3290 with SMTP id adf61e73a8af0-225ba5370f8mr24537723637.33.1751953174329;
        Mon, 07 Jul 2025 22:39:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGaR3Zf4jeFyswPR0CteXJAtjrD1bBYM5QPstP1VOUIEAlqfyBhmGfJ3hqAyq4EsiP2imSQdQ==
X-Received: by 2002:a05:6a20:d80a:b0:21f:83ae:3290 with SMTP id adf61e73a8af0-225ba5370f8mr24537687637.33.1751953173910;
        Mon, 07 Jul 2025 22:39:33 -0700 (PDT)
Received: from hu-kathirav-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b38ee450db7sm10531829a12.4.2025.07.07.22.39.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 22:39:33 -0700 (PDT)
From: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
Date: Tue, 08 Jul 2025 11:09:15 +0530
Subject: [PATCH v2 5/6] arm64: dts: qcom: ipq9574: Add the IMEM node
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250708-imem-v2-5-692eb92b228e@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1751953154; l=1206;
 i=kathiravan.thirumoorthy@oss.qualcomm.com; s=20230906;
 h=from:subject:message-id; bh=VfK8mEDpXLVB6H57qiYobVaPCMl4DeUgsq+1SP8HFbU=;
 b=nMg3aNuDKdIr2q8zeAB2OvDbVWDunZRHLbepwRF19vaXxBcg4E6YNjWdr+HKoy8u2Ctcu2SNQ
 F5F/LeaUd4MBHtLgkl/GJ8cwcUG3kR9V0sUn23lhvy5fn0PyJDONuKg
X-Developer-Key: i=kathiravan.thirumoorthy@oss.qualcomm.com; a=ed25519;
 pk=xWsR7pL6ch+vdZ9MoFGEaP61JUaRf0XaZYWztbQsIiM=
X-Authority-Analysis: v=2.4 cv=ffSty1QF c=1 sm=1 tr=0 ts=686caf17 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=g_gtcTFTaut2jdyMrvoA:9
 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-ORIG-GUID: xmhYmsqbKzXOPilP5DUWsnpX7B9W7RM3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA4MDA0MyBTYWx0ZWRfX0gKZsKlIQneM
 K3/ya3yEBBmYQFHCjOklx59J0MdUZaVs6tQ/VCqFG4xhS39Y4v9Oz2aGHxX7hyGfFdzVeF5QCWa
 C7lgZjbG5jHTs07bGqL7U7opdspxRd0tz4XTuBX7yt1TSfCdptmTkYL6bxH9RX07Bdy0TIruwQE
 BBSmOatIWYzkmJ0VgH0qG6swoVfOkIKwagD1aO/LKqDavLtOug9qsLGLMm76R/5kl1ET/btYJEj
 ksQk58/pUH0QDvExFuBNa4gK3dbBwfyl8a73a/YBv/j6mMjVhzrNcP76XG3PvGCYwWw0nGKn0+g
 l7kXN4ZzP2FCwfzebKMCHnIP2tnse3UYYQA9vCC1olxWxXQaCInTIHopsQmU8aZx5eDU98AGc8g
 iiZLmoFXz9R+8jNeWuyjNKE+ZWvSpIuiVkr9oLv+ZVHdmbi0tdtYrjwDuP5UH7/aYTThdpMd
X-Proofpoint-GUID: xmhYmsqbKzXOPilP5DUWsnpX7B9W7RM3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-08_01,2025-07-07_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 mlxlogscore=808 mlxscore=0 bulkscore=0 priorityscore=1501
 phishscore=0 clxscore=1015 suspectscore=0 impostorscore=0 lowpriorityscore=0
 spamscore=0 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507080043

Add the IMEM node to the device tree to extract debugging information
like system restart reason, which is populated via IMEM. Define the
IMEM region to enable this functionality.

As described, overall IMEM region is 32KB but only initial 4KB is
accessible by all masters in the SoC.

Signed-off-by: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
---
Changes in v2:
- No changes
---
 arch/arm64/boot/dts/qcom/ipq9574.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/ipq9574.dtsi b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
index 815b5f9540b80e91e81e02a97b20c0426f40b003..2a42e8a9c79274f2b983d31e0b7b587ad524b211 100644
--- a/arch/arm64/boot/dts/qcom/ipq9574.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
@@ -741,6 +741,15 @@ usb_0_qmpphy: phy@7d000 {
 			status = "disabled";
 		};
 
+		sram@8600000 {
+			compatible = "qcom,ipq9574-imem", "syscon", "simple-mfd";
+			reg = <0x08600000 0x8000>;
+			ranges = <0 0x08600000 0x8000>;
+
+			#address-cells = <1>;
+			#size-cells = <1>;
+		};
+
 		usb3: usb@8af8800 {
 			compatible = "qcom,ipq9574-dwc3", "qcom,dwc3";
 			reg = <0x08af8800 0x400>;

-- 
2.34.1


