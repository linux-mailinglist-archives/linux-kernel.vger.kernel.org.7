Return-Path: <linux-kernel+bounces-720926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 897F8AFC22D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 07:40:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 875C74260D2
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 05:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A3B121ADB9;
	Tue,  8 Jul 2025 05:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="D/QWhK+Y"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2249B22128B
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 05:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751953181; cv=none; b=qfPXBklvz4t70FsPmY7K/rnlXzcalI6awW3xl3gt+8ujpzfLq/1W6PCRHCYBLODnkjR1lR17ySBDjc9HaCZCGi+gOnNSrSwC6FaGuCCdU0QBF9i1r8nFcTf11UDnlTrYZzMmWteERZBi0eJNh1QdeKvEFCisClwzGzS3R6UKpPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751953181; c=relaxed/simple;
	bh=ownEk5dLe364vVv1oL3tRqmLqrzvEbK/2+ThZRJADx8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OaBKpPf1I7GG4i+jQdz9VlmhwgsRCYrGsby9kYqv+g32c+AG+nPixVllqCGWhKpnWS36RBQL78zLmJh2gO7B4g2xWSY2EFpee/uelHA48DxtXedWJBKkP+3sZ07CuN4a6hU/BsH63xWzVLkHBfvPSJm7b8KuxDLcAY4Q1CwPD04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=D/QWhK+Y; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 567IocpL023446
	for <linux-kernel@vger.kernel.org>; Tue, 8 Jul 2025 05:39:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	04CccGlKtJRX7YBKLRNEu8n8djxL2dzY144bh1/pQnk=; b=D/QWhK+Yv2lkz+7h
	20e9H/ZmoWbO5mV0AZOmBSjypJ7pma48PQ2DyqQyNPUX2dko/TCEGUjLDPUfG0KA
	DG1ueG++bbg6/jxGOMllTZSI2jcjFLLgOW+C5//hjrzsoefjg4pKlbYHRBsj5ojF
	KdIXNtDiqs6Y5yOsGu292EshOzZ2JuLV4kYbE6V5T2lxaYFmkcHG7zV9eaMNF1gW
	Yeq8SippwrF8ZL6oUqypRDgrLFmkxOUlWukcFjo28/J9NtKKSvh87uze5qPCRvbg
	bR5gqEX42l02iiz/pLapZa0JqAVbMa8xW+XpWgLzFK2eM/qn0hxtzwhxC6TMa3ou
	OBQKvQ==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47psdqufjb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 05:39:39 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-748a4f5e735so3959240b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jul 2025 22:39:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751953177; x=1752557977;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=04CccGlKtJRX7YBKLRNEu8n8djxL2dzY144bh1/pQnk=;
        b=TBBfkEOlSZYYWki3J7aUlE4i0L2QHT2j2TZmPZOxfFJ9QoTOYvzFnz9CIjECdSXfOX
         P3h3KLmN90mBKvlF63WAF8M4bt0CNRvvq+0kfX2SzbZxQpjL5gpTkZQktpaOTNH8RCJZ
         a1t8Q8/u4XjF5WdHGdPksfNKxbw2JZltCht1xpQZ9kXNFPjqlnarjQcR0/ApZOnKjeuq
         kasF4XlpLv1ETercDq4mE/Y+yjfru6nQqeki1Vh8FjCbzq4aL8bbnvNAzNL5FOt2dqIY
         L/sBO8brNy5JKabp44JBQz12a7mNxgi5YeX0guc6J8R9FvlhdcAaDE10idgHQb8JCWtD
         piPw==
X-Forwarded-Encrypted: i=1; AJvYcCWtrKATtDmxaSYoJivCx90/36oR5d410gzU1D/yLeeKWRn2rnSw/eYaZAwA9t0lCMOpr86wJQKRdorSSrU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTECKD+FcSU+MaGDKqs569a/rcHD5Tu/2NbRGfBMb1kZgkG9+z
	5SYOBlNW0fjThwrpH/cBxMHIwCULTuzuwbWkzxLCwrFfN3SrQ5grYe2LD6ZV93nTTHm0PKi+Lnr
	PcTQHRHReteH7zd0B4y/2iMoQ6/42qgws94Y/RMKLKMGKX7WN9Hao7KzZBfVXBBHhNW/GSbpD4G
	I=
X-Gm-Gg: ASbGncsKFBNH/fbrva026TrHhJc7bl5pjrSgSmKxN+GUX7xNsJ5O4dsGffPilHF5QzB
	/8vOvn3QU23wCCQgilqSKipQPEMmFBgn0odmm7tSyX+NsKoCapbzfNUxhgZd3siBCSaBD1dz2i6
	D9OqELd5YRBDlzUyoRLG4tScPMXBT4xUcBnjYRRqAn780E504nBJA1IH70W/Ler36V/4JsLeI8u
	BwEXrV1tOd+ppdcfQnFbf91Kx+D0vX/aIkAznA6QWSaj/qt+ZqaKAY/Er/8/NbKLnX+37U5AzVh
	SKktGwRJd23Bs9nLIVD0Nn92hykuI8BU7XJGPLeZoADnvqnVdpv1uBrDGQyno1bnqeOr4pcrkQa
	/ufWGi40GMtKG4KKCLX05gU1VKuzBXpr80MujwF5fLFekd7CDx7QXbFTiKQ==
X-Received: by 2002:a05:6a20:b40b:b0:215:d28e:8dc2 with SMTP id adf61e73a8af0-2260b6806demr22351437637.31.1751953177600;
        Mon, 07 Jul 2025 22:39:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHzYSSafP4wH1VYFxgER7PuBaQuUi+K71SgzgFMWYsmO27JSdT6hwd9rluUl4bUdjd1buKy8w==
X-Received: by 2002:a05:6a20:b40b:b0:215:d28e:8dc2 with SMTP id adf61e73a8af0-2260b6806demr22351395637.31.1751953177125;
        Mon, 07 Jul 2025 22:39:37 -0700 (PDT)
Received: from hu-kathirav-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b38ee450db7sm10531829a12.4.2025.07.07.22.39.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 22:39:36 -0700 (PDT)
From: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
Date: Tue, 08 Jul 2025 11:09:16 +0530
Subject: [PATCH v2 6/6] arm64: dts: qcom: ipq5332: Add the IMEM node
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250708-imem-v2-6-692eb92b228e@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1751953154; l=1207;
 i=kathiravan.thirumoorthy@oss.qualcomm.com; s=20230906;
 h=from:subject:message-id; bh=ownEk5dLe364vVv1oL3tRqmLqrzvEbK/2+ThZRJADx8=;
 b=H22kuYrHgocB3daOHf+deZbRY+2BRf73sagk7lcXCMqkr7/XrZwz366x5z1u/eK59pp+TpcNe
 tIBnjYfyonvDavNv03odNkS+6T0kCeYzGAs4A3u74EcGiyp8yn3RJPA
X-Developer-Key: i=kathiravan.thirumoorthy@oss.qualcomm.com; a=ed25519;
 pk=xWsR7pL6ch+vdZ9MoFGEaP61JUaRf0XaZYWztbQsIiM=
X-Authority-Analysis: v=2.4 cv=ffSty1QF c=1 sm=1 tr=0 ts=686caf1b cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=g_gtcTFTaut2jdyMrvoA:9
 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-ORIG-GUID: cAHtk5Ql2rnYk8qATyr-gr9L9Kobpf4L
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA4MDA0MyBTYWx0ZWRfXyP9BfIFWfyll
 Cv0JqiieG8YrJe9IpGbLEwWxzNdgD9APQqCfqdLG0taaExcO+rXg9Tu1r2b9vpqju2mQ4QQ2+pf
 vELEzvi8jNEH5PUx1Um6W6oh8KlyMhapS6CldqzLj+1kDASVJzM7Pu5Xv2TUN6tBanybm02grJP
 ODyOmzA4hUY4Qfy8iG9UeXoDWppJw/qgKPHzQZ7s+Uyt9kLtCOT/EEySwy5GldNr1oCl0hySgQ1
 fKSt5a8c3TAbfuXXK4CVbbmI/pXaiTF4l3C4lNrARlra/9fnVf/QTLTmc5CXgSO2NVLBq5FQ02A
 SjOuE0DxKGw5Bp/ubPM8DHibjXDksEj6DefvIXUoCvx9ovlLHYzr3SLULdCgtcBROSlmLDEJThM
 0Nb0tlUn8aszA+kgkUZXC+8WQDSspbe82JeB1L2jwvVjReVgUcrKfklBJJGvpObrIS/d61fy
X-Proofpoint-GUID: cAHtk5Ql2rnYk8qATyr-gr9L9Kobpf4L
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

As described, overall IMEM region is 80KB but only initial 4KB is
accessible by all masters in the SoC.

Signed-off-by: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
---
Changes in v2:
- No changes
---
 arch/arm64/boot/dts/qcom/ipq5332.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/ipq5332.dtsi b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
index bd28c490415ff61624f6ff0461d79e975f2c397f..6f54f6e758309932a35d7156f32ccdf09dd36ee0 100644
--- a/arch/arm64/boot/dts/qcom/ipq5332.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
@@ -423,6 +423,15 @@ blsp1_spi2: spi@78b7000 {
 			status = "disabled";
 		};
 
+		sram@8600000 {
+			compatible = "qcom,ipq5332-imem", "syscon", "simple-mfd";
+			reg = <0x08600000 0x14000>;
+			ranges = <0 0x08600000 0x14000>;
+
+			#address-cells = <1>;
+			#size-cells = <1>;
+		};
+
 		usb: usb@8af8800 {
 			compatible = "qcom,ipq5332-dwc3", "qcom,dwc3";
 			reg = <0x08af8800 0x400>;

-- 
2.34.1


