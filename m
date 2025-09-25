Return-Path: <linux-kernel+bounces-831809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0943B9D98D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 08:30:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CBC22E0A29
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 06:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BC472EA48D;
	Thu, 25 Sep 2025 06:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hbD2kGQ8"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 951802E92B3
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 06:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758781761; cv=none; b=NAlusXTKgCaufNnpHMk1tvHJze/RiXM3gSO/b84qbUnF3hG8ZYw5oc5qyJOUz8ELuTP28HQx4lhW7fpMxEq2R/QQXuTngOXPM6D2HZ7AbchISTRe2/yY5Bj45y4VjBItHJAYOnI28+ZT2f2I0CPgEqMt4lZO5b3cpqmAJPDZSAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758781761; c=relaxed/simple;
	bh=D3joMpRcaeR3gLLXU5PCwDBHjh3jgbSRLlNslB9/hYs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=plxaQhnI01Wh8KTMk2ynFUvlAcIShjjOgVlp2cYRyM/OqWGD80/JU7wQxf/t+1Bzp8k94Fj/cn7QJob7kyYLOHl1/jcvYlZKytxB/dvVJQIK3W2Twf9e42YQSD3q1bQtPBImen5u5eN3KKAPAdTKt3dZY9S/hYbAy8MSY7jdxTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hbD2kGQ8; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58P0Pxl8025158
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 06:29:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4p33NgPxej04es67Nsx769+T5sIjjSqFb0zB/Kwm1+U=; b=hbD2kGQ8sZ566U9I
	78GIyL9K1zldxXPH9r7g1FBEDSSeHC2xpf4TxONeD8ndvBMEX3lll9SB/VQ2ff8a
	/bWHXqEYHuFj80FG4fjyh56Cf6uIVewR1zzb9Kaq4ChY0TiHR4N5R3uwFw2U2kQO
	aWDb4asp5ear/tE9tnponZl8MieKrRn/2Nki1L3tCDsRmzqHHwKz/sOKhuIAhvoq
	Y/3zRj2o8QZLJgPwqgoFZKS8k1Li3wjYXZlh0+Pw9B/kAECoYLjecOsi61A+PWkT
	c+o3Npx4g+axXBO3BdVlX+4+RMKZq0+YcAQbTwhKlzQo2/cHIszLzjts8m+oE9dE
	LzKVAg==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499kv171m2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 06:29:18 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-77f4912fe36so515749b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:29:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758781757; x=1759386557;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4p33NgPxej04es67Nsx769+T5sIjjSqFb0zB/Kwm1+U=;
        b=ILUjhTNa+tkHcvP+qO4/RWGar9/8c/j9g5tndatLcYL5Tba6T7rPpYRiBZgboUWK7c
         hsW0NvbJDKsSzKNyXiRp0G3VJWRAuS8etg4iH94Ax9WQlkUHRfhMtyggmGCU6eusUC7Q
         QTQE/SkGDnuCZvh8tjt/KAzXGCt8A9vmxDctWafpWPc7LzFSITgxMM5+fPT4hvoeBKNX
         GB1STb1sNhuMWqnPdeGc8fLUCf6JHeaePGQIm/6SpRgAzGQxd8AOlR4UUjEPUrwYkNFh
         MwPWx2Bl2Ck8Uzb7B7Fy2vvrAuKOPvT6PPe/isFJMzZkZPFc2yRsIi2GQoLapvmuwPsF
         iayA==
X-Forwarded-Encrypted: i=1; AJvYcCXMwAUOfztgYTle1rYpSaeIcR4cmF8+S4Xefsyh0yQMWEjGBP0rZf6uCDmPinDAlByOdRorcjNVAjs4Y4g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1Fm+uS1ZGHDHcVAaktr8/xZx4KSh39mtVsV2HCtg0b4AL8x+z
	YUHgFH78VWXczTVrKqppf8CwMEYd7ozEeVp2lQdVWFdQyd4Hv8eIgHuoL+xWAuNwpjPLCaOieDw
	u45AwZ6ZakavtW67+EIvD/VwqV401hPgbycXfwOnmLUoCXPnCuTrwW8nuY/gXvix/zaJiglIAHF
	Q=
X-Gm-Gg: ASbGncsMoN4Utti0WWZY2glVwClBUWO4aLAvuEA1sesRaQUZWYxtWWnsJk8NZUtqX4P
	qBspHuNgoOgYdA1hl2Df3GYVEdqqVdSKiKFK7gO0UJW1bGHo+8vfJ/ynBrH6OeKwYLyQkJDu9/6
	RLq1SgYVxf4cLnQ1GIBqJ5wXxtfHasZDWuQCkSgh3MxsLuCFYI2DTUdHySNsmVX8W+IJ8ky/HLR
	mBaDC4vZaPByd5qQSA9HO/qqQ+a5KRBXLbkzkCxIGbQ7yGJHEWBF094dY63XaGkv/vNtxKAUMHi
	QJLHZEWhFRFtyMo4kc9rzgxUHFCH+wC0hg/Rsbsdha3eSuJacENNuAgRGv94i/hQHiPC01hukZB
	ejrFd4a5AmF3+aZ77RAa25e1e9NoRFyNP4wlzkLfLq0tCr2p1qwj54JPgFA+D
X-Received: by 2002:a05:6a00:218d:b0:736:3ea8:4805 with SMTP id d2e1a72fcca58-780fcdf4844mr2785089b3a.7.1758781756875;
        Wed, 24 Sep 2025 23:29:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGZfyzzBkh9JSOcHQ5l9IcBwNXFRuCu6kft/cJooGDvfC5mFxMmtPNbwwJuJwp/7HfaNUir+g==
X-Received: by 2002:a05:6a00:218d:b0:736:3ea8:4805 with SMTP id d2e1a72fcca58-780fcdf4844mr2785066b3a.7.1758781756446;
        Wed, 24 Sep 2025 23:29:16 -0700 (PDT)
Received: from hu-pankpati-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7810239136dsm952962b3a.5.2025.09.24.23.29.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 23:29:16 -0700 (PDT)
From: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
Date: Thu, 25 Sep 2025 11:58:12 +0530
Subject: [PATCH v2 06/24] arm64: dts: qcom: glymur: Enable pdp0 mailbox
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250925-v3_glymur_introduction-v2-6-8e1533a58d2d@oss.qualcomm.com>
References: <20250925-v3_glymur_introduction-v2-0-8e1533a58d2d@oss.qualcomm.com>
In-Reply-To: <20250925-v3_glymur_introduction-v2-0-8e1533a58d2d@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Pankaj Patil <pankaj.patil@oss.qualcomm.com>,
        Sibi Sankar <sibi.sankar@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: ZnW4X71vclscEV8Pier5sx-GlfSptAul
X-Authority-Analysis: v=2.4 cv=RO2zH5i+ c=1 sm=1 tr=0 ts=68d4e13e cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=nkVSH_9X_D7H38LkyDMA:9
 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAyNSBTYWx0ZWRfXxv7HROjdZZFA
 vmRzX14tPSMtcMFjn15GEE8uMw2tGPDzRZDWG7a0AGXSCWngjBnUeBTV60yT9tCFz218CDH3DPU
 P3OuS5JjKu8fIh2jkDCHTeOsurFXAIO1ruD8HUDYHg3g538HdRRpCpbQdsWKIWCbYMt1rB8+k3t
 WzrlI1ntqdz6v81CpDS3DnICHcOPUJC5tRtWnskku3Yx4UsWmh+uT1FA9nRaAXiz0S19EOdRbnO
 wLtvYN8fqSDS2u51+PsanPYRjTxrLQR4BDOEtpFHJ43BUlnoUhClz3F8nIvy91PfVrQ/M8y1MAp
 BjQmKFzAGKeg3VASYdQKJJvW+kQlQU+TZrXkzZwfhq/NO9rfYEF3E0CtmhlkMoVKGwEYCAGQzOJ
 54HxeBRF
X-Proofpoint-ORIG-GUID: ZnW4X71vclscEV8Pier5sx-GlfSptAul
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 suspectscore=0 priorityscore=1501
 impostorscore=0 spamscore=0 adultscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200025

From: Sibi Sankar <sibi.sankar@oss.qualcomm.com>

Enable pdp0 mailbox node on Glymur SoCs.

Signed-off-by: Sibi Sankar <sibi.sankar@oss.qualcomm.com>
Signed-off-by: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/glymur.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/glymur.dtsi b/arch/arm64/boot/dts/qcom/glymur.dtsi
index 66a548400c720474cde8a8b82ee686be507a795f..ae013c64e096b7c90c0aa4cfc50f078a85518acb 100644
--- a/arch/arm64/boot/dts/qcom/glymur.dtsi
+++ b/arch/arm64/boot/dts/qcom/glymur.dtsi
@@ -4065,6 +4065,14 @@ watchdog@17600000 {
 			interrupts = <GIC_SPI 0 IRQ_TYPE_EDGE_RISING>;
 		};
 
+		pdp0_mbox: mailbox@17610000 {
+			compatible = "qcom,glymur-cpucp-mbox", "qcom,x1e80100-cpucp-mbox";
+			reg = <0 0x17610000 0 0x8000>, <0 0x19980000 0 0x8000>;
+			interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
+			#mbox-cells = <1>;
+			qcom,rx-chans = <0x7>;
+		};
+
 		timer@17810000 {
 			compatible = "arm,armv7-timer-mem";
 			reg = <0x0 0x17810000 0x0 0x1000>;

-- 
2.34.1


