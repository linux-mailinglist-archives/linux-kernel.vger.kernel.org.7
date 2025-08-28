Return-Path: <linux-kernel+bounces-789439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5559B39565
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 09:38:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEF751C266BE
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 07:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 324832FFDF8;
	Thu, 28 Aug 2025 07:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="J70s0CH2"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D858D2FFDC7
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 07:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756366519; cv=none; b=mu2kDIwr2z/SLgWHizsNTLTxvo55aqP2Yht/YdgAecrkkfXcVeptoTtYC9LA1Erf0pooAgFW2XZjy2zL1MH/z9SvNQpxHRo/q41XbEeM24ozWIXkXI1jQaRQonoe4pdaggl691pxsZ4tOlT8w3F1S4KZvZ9wx7XD02IDDNFig7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756366519; c=relaxed/simple;
	bh=9CBfmxAvq02vasDOK9GiRt9O37eldSDYJzZR+Ih4/NI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qEeFYA2IzBQM1KeBHEKlmus9oWTrzAucQNjZuoFXmdS3BwAOcVt4LMHU/7W/Jyl8mOw9hI4i2QUcgO+03dmFb0Epul5CNufkjCqBpcUQx5kImWS1tOra0XgecfiRuBPHL7ZgRFL21AKdA8Zg5jMJHjwSgyuy2xqVDIlTZG5JZrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=J70s0CH2; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57S624KG023129
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 07:35:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Q4BKfFv3tKNplKEqotWZto9ii2lZDoPptOc//ona8r4=; b=J70s0CH2TbZMWrFW
	ydx+0oxW43XJgqe/W7RSawzCCuzmBsxHuY9ofWx7OUCjOZcLmQruHDqpHIKNERda
	tkvdDXdPOOm7M3iToQRpGT6Qc9f2rFO6rpbnVGph6j+SOUZFw1HXHkz938x5Kdal
	MH+4ybo+lI0QVYyRF3AgdYsdUD/S+YsO5ey1suh5JtGg8/KzVDsbacGwltg8GH2c
	K9zAaeblzmPlhDcuIQ1OyqzRZ4ZoALcYh3OGWaGtfoahyQH7E57mJghJToROoFGA
	P8ToTB5EZGR14WgW1TSDTHB/Jy7SODE0WxIOrgHICnn1zj7A5aw1sGGpY0QtGD9O
	UsZCIw==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q5y5q54h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 07:35:16 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b47174bdce2so552144a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 00:35:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756366515; x=1756971315;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q4BKfFv3tKNplKEqotWZto9ii2lZDoPptOc//ona8r4=;
        b=ksto8xL/C91kZa5EEVH+xUIiDh4SXlq/N9B0xPHQexdrhGmjro2d6Er0FaYTrV2s/0
         q/yl4UcSa30FKuJSfnCiM1xt0AMY2GFOiD8TRu8kNFvBX+jKgVl4sdIIqFRx6htSLxfX
         8RPo+z4fVZjAsvtqzJprKgIH6+A40oESxGYIZM/IAJWvERtJpgNKOeX5VKGSLJagxys4
         yVhpT/XnRRuUbGmlwc8CSBroLLCGv2DdMwqX/0xcsemDKNERZmgiXmbKELUERIP7pF67
         fagzRjfbmmUuf1ra/xiuFKmYqmLma3KYokKXCsHilgT8kThChoRXANt78kUBJUKrj3Ru
         w6Gg==
X-Forwarded-Encrypted: i=1; AJvYcCVzw/66Lg7/3cXuP3aalI4a9xQqmupGayeewwPc1n+0JETd8C0Vv/O6PFM3u4NIC8/Qx7WFw/HyCDdYTqM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzN4gjDOceXWFytP5322JGEdNk1r9fADWvUQSgo1TBFhryqmWfd
	LvLXblkVWh8putBfLcqU2+Bi9hQz6COf2Twvwe2plK8SeGCR18GLsejU/c2cXhs/SMTBnxlA5Ou
	cLu+itvg5RZ0OrfoYPKEDyMcqwElNYUWcwdNDFC9HXlrBx60Xqd5i+kIfy/Aedx9xeGg=
X-Gm-Gg: ASbGncsKUAOBjrYZiThHpjeVtd9nCjKKRV6LubnH+ybrQoITwW2kEcDVWgtlnRUAWuY
	A75zbWmin/URm329ho7MZP2JoebJOMasbC5r6w349KwpLjU1QswTp/c+ERLzZ6DvYiUa11r1UTj
	b9VwO/3u0WxSLrf4juj9Wv+0o3iE8ipG2g7TH1I5+h/uHgy42Cxcip9BfTV+BWrs6EqrV/cTqHB
	PNS/zyURSvDJsrhzpDi6V+QT0JmZdNpNEUNHB7p6INpMDw2IEWzV1gZ4dzg6caI7F9KPTqE7Gf7
	OwCkHHcfcGM1Y870KbSqncRn7AQ6HgiIqyFfpyaHSHlagnN8J5nuV1hfXqV6pYvQkSSghtlafWY
	=
X-Received: by 2002:a05:6a20:9148:b0:243:b38b:ebaa with SMTP id adf61e73a8af0-243b38bee66mr703703637.18.1756366515322;
        Thu, 28 Aug 2025 00:35:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEepxGLjZzmncLdDY7xaRKWaGRZvSK+T4t0mXkK1dDoy3G3QR1FaJMRplw1MYwIE797osj++w==
X-Received: by 2002:a05:6a20:9148:b0:243:b38b:ebaa with SMTP id adf61e73a8af0-243b38bee66mr703671637.18.1756366514840;
        Thu, 28 Aug 2025 00:35:14 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4b77dc7614sm9605810a12.8.2025.08.28.00.35.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 00:35:14 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Thu, 28 Aug 2025 13:04:22 +0530
Subject: [PATCH v8 1/5] arm64: dts: qcom: sc7280: Increase config size to
 256MB for ECAM feature
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250828-ecam_v4-v8-1-92a30e0fa02d@oss.qualcomm.com>
References: <20250828-ecam_v4-v8-0-92a30e0fa02d@oss.qualcomm.com>
In-Reply-To: <20250828-ecam_v4-v8-0-92a30e0fa02d@oss.qualcomm.com>
To: cros-qcom-dts-watchers@chromium.org,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        quic_vbadigan@quicinc.com, quic_mrana@quicinc.com,
        quic_vpernami@quicinc.com, mmareddy@quicinc.com,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Manivannan Sadhasivam <mani@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756366503; l=2217;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=9CBfmxAvq02vasDOK9GiRt9O37eldSDYJzZR+Ih4/NI=;
 b=D5t8rDZHiDMSu6zuQdZirT2Ko83CIgI4U8MZmO/xjF/Q87QzUXtZ3tgFS3hrfPpRPi5x+ANxe
 03+8XcT5J3YD9UhlC41r05kOwjPOLNJDsX874lcVMthp4GTE4zWFR/o
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzMyBTYWx0ZWRfX6wIM2cEqaSzA
 tJc36JpReZKJE+waivgDZYXH5xp1FTJBu/AATPok83NljPFtVtTJGmGjFG3vkUEsL6NyztWYNTn
 zMh+XMruz2Hp4XYy13T/6RWr19K0D+uBp+E1Czm26/rAG2J7ksSWeT5qFMlkx0GSEJ3PHQomV5w
 CYEJmAk0y4mGvIcmj4Fzwwh+OTu1OHBzpkHqb8zu1BnpFxDxeIgvwZ6A9AZgMve1S7wTrhMvlri
 SXXxAz2/E7+JhW0+wlVM+oSM8jQQn93gnmYLxar7zXSGsTXit0faMKLzfZNGGEkoFqXoaMMoBis
 IpDeSXtE+4J84usyjfzvl+bTxDRm5ZUFksNk5m1utTMZji/jhoxdyGPi4ys49sZ6IxKmIoGygmy
 UwetHTA1
X-Authority-Analysis: v=2.4 cv=Lco86ifi c=1 sm=1 tr=0 ts=68b006b4 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=bvY3E1ByFFb03tV5gjAA:9 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: -HhVKFw9RtD9Bt0Kg-di0qMDHRdASkk7
X-Proofpoint-ORIG-GUID: -HhVKFw9RtD9Bt0Kg-di0qMDHRdASkk7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-28_02,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 clxscore=1015 malwarescore=0 spamscore=0
 suspectscore=0 phishscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230033

PCIe ECAM(Enhanced Configuration Access Mechanism) feature requires
maximum of 256MB configuration space.

To enable this feature increase configuration space size to 256MB. If
the config space is increased, the BAR space needs to be truncated as
it resides in the same location. To avoid the bar space truncation move
config space, DBI, ELBI, iATU to upper PCIe region and use lower PCIe
iregion entirely for BAR region.

This depends on the commit: '10ba0854c5e6 ("PCI: qcom: Disable mirroring
of DBI and iATU register space in BAR region")'

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sc7280.dtsi | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index 64a2abd3010018e94eb50c534a509d6b4cf2473b..36afeb2e45937f8ad301c55caf296babdb499820 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -2202,11 +2202,11 @@ wifi: wifi@17a10040 {
 
 		pcie1: pcie@1c08000 {
 			compatible = "qcom,pcie-sc7280";
-			reg = <0 0x01c08000 0 0x3000>,
-			      <0 0x40000000 0 0xf1d>,
-			      <0 0x40000f20 0 0xa8>,
-			      <0 0x40001000 0 0x1000>,
-			      <0 0x40100000 0 0x100000>;
+			reg = <0x0 0x01c08000 0 0x3000>,
+			      <0x4 0x10001000 0 0xf1d>,
+			      <0x4 0x10001f20 0 0xa8>,
+			      <0x4 0x10000000 0 0x1000>,
+			      <0x4 0x00000000 0 0x10000000>;
 
 			reg-names = "parf", "dbi", "elbi", "atu", "config";
 			device_type = "pci";
@@ -2217,8 +2217,8 @@ pcie1: pcie@1c08000 {
 			#address-cells = <3>;
 			#size-cells = <2>;
 
-			ranges = <0x01000000 0x0 0x00000000 0x0 0x40200000 0x0 0x100000>,
-				 <0x02000000 0x0 0x40300000 0x0 0x40300000 0x0 0x1fd00000>;
+			ranges = <0x01000000 0x0 0x00000000 0x0 0x40000000 0x0 0x100000>,
+				 <0x02000000 0x0 0x40100000 0x0 0x40100000 0x0 0x1ff00000>;
 
 			interrupts = <GIC_SPI 307 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 308 IRQ_TYPE_LEVEL_HIGH>,

-- 
2.34.1


