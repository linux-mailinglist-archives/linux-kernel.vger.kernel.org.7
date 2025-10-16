Return-Path: <linux-kernel+bounces-855993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DC473BE2BF4
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 12:24:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 65B564ED96C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 10:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AB9F31691C;
	Thu, 16 Oct 2025 10:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VTZA3rah"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE6F2FF67A
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 10:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760610195; cv=none; b=fv4L4zLeTv/eUJsQpCHQif348So8epMw6sZYF1GByRu4hCeghmIPIkGeGC3cpqJN5CdZSqHUn001AlHwiMIfk3qckCqJNZD4KbiDRW3Wa9ktd1fQuim5eRSNH4l8a88lxiv1qB/MWJ3cexT2EDCcmmI4MLUTnpLs3sNETnJEwNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760610195; c=relaxed/simple;
	bh=ar5eqMmSWUAjAU2fKmuI8Gf7B+3xLb4YaRdEMoTPGpI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=to5Stu3QGLtSMEmFxnNkr8xdRp1NDVVBY5noOhkUzWnScvH/gEzmu4Ks7xJfqrBCdZCMAwQdhtVInVpePQPMlAebNOnsM0zUxB0MA7GT81zMvhHHWnovS3FLYi0xTIu/wbC5hDXcU8n0YnembWiSvkO2RKNTRe1p9rL6fINJw8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VTZA3rah; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59G6vJf6003849
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 10:23:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GcIU357i5Orn6jTpeFGX0iIFaUazv7bUr0neJeDI/88=; b=VTZA3rahlBMQoh4Y
	vXTouC9lgg5QYO3xP2gsWAmgZVo2YQ5xMiOAJuwRpIYv8qgjMUD/9ZZBU5fJGci6
	5wWjRixt3UzrFwMCHC5eZ0gZ4Kyx+pjgSMt2xxeWV7vkInAhySnIAwL7gkX7qQEv
	/Z6YqgDfpYboH7oOEf1sIIFdCIl22fbLh3ret++GrY4GCcx8z5ACqaHdnecriMs2
	ZbL6FFujowW3NAevAkldgnNb2k+EDpz68xXHQsD7vlE9dT51ZRVQ6IlI6jFfEhGN
	KdQNON7rR0I4TQHaEwtoeXQYssd8iiaZuTeAWLfrs1Ttd/J79V9AsW6dy7Mp4SLu
	zWA5aQ==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49sua8pjq1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 10:23:12 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-87c1115d604so20648356d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 03:23:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760610191; x=1761214991;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GcIU357i5Orn6jTpeFGX0iIFaUazv7bUr0neJeDI/88=;
        b=FWzatSloxbO6y+UyuoIq4zgcmcCmmRwMK4hA+xqhfu+GDzNGMJzvcbSTnNmVHdPZQP
         HgCVcXZfdUZa8GHy98oQWmD+Lok/8sFq2tv9OkyCYgxkLaLpFJJGmqloLOoIrh3SrpIR
         SCw//jGCeaLlnPmvYGapZB5dyuo+O+cIy+Pis2Y7fzha2InsIj1l/Q3RACP9CTeapi+s
         Q2mnbyuh19XRBPq5Gb5/vGLOL0gIiRtvrgoZDmIm+kgxGc6pZAlmCNlqMnxI2gsz3QFZ
         5vxi7yPf9X4zTwbw2ub6Bl/OE1Nk4H8pU0529/JILR0UEhuwAjgN1h7/qLDBg9cX/YA9
         Ilyw==
X-Forwarded-Encrypted: i=1; AJvYcCUfhFuwLvjhLiNJAqC+ZuY0zCxymN30Bc0OjiNv4JnS7V3c4Nd1t/qCIATu2eJ3oiS7TKjeo0UGa9w5fBo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3mJB0meRBqHMDTHd7Q1kNuJeX3Uiz5lK7iungiPBj+TBsC6EB
	y9CMCQ6IQ5PPe+IQYWg4oJlBw3hMy34e3o0zcunvjvajQdGg1OX9x5gVWznwPK/8ytxu8E4d8/e
	4EulceAIMaxVl4Lopkqee6DKWA/G6kGW3sQ3jFzgqQ2CXgC/TBN00V8lo43QCGiTwEuabXRR5Ka
	buhw==
X-Gm-Gg: ASbGncthcrK4bMBDykfK2jAbv5i9ggXjPRYKjqKgBQEY4pfG1Y9IghpV5qVW0rPBhpy
	9l7hWxZSLS5OIc+7kmqOWBU3nguOAEo2/kq0/tslrz4TerASalLD3/nKBfa4TFwIf5Bz0BUGf8h
	a67Xf4fbJiaTRlDl3DWZ3kVkPswrM0veVlwYmHcFma/2Tzw6B8ko1+2VuPCG2NjBWkWcjvOuw9t
	Bqd7oGg8ohFNJNQfG/FqYg8KJbdbWPFI7vsnb5/df3ufnAEbPV5MhoZp5NdJgh0eGMSXEYEu5nB
	NuUPT23DEw9atDhN/RbbPD7IEww8vPuWzdREpkGrums8IssnwVf21j4/tI8UfTe45ozIS079j8q
	kq0MBe/gBgBMrq4JtLocmWZfJKMfsAJ8q3T13IJN1GbSblctzXpn3R/DQnEMPdTzG9A==
X-Received: by 2002:a05:6214:801b:b0:87b:b639:c7b6 with SMTP id 6a1803df08f44-87bb639c870mr303584456d6.18.1760610190676;
        Thu, 16 Oct 2025 03:23:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFrBvEzaY8LjaehmQ12/HrFjsZgoyHaVtFAyv4/JaRtiDFouyeUPyR4kM+sgN1ZX0SwEy3CVw==
X-Received: by 2002:a05:6214:801b:b0:87b:b639:c7b6 with SMTP id 6a1803df08f44-87bb639c870mr303584166d6.18.1760610190087;
        Thu, 16 Oct 2025 03:23:10 -0700 (PDT)
Received: from WENMLIU-LAB01.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com. [129.46.232.65])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87c012b3ff9sm36777576d6.56.2025.10.16.03.23.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 03:23:09 -0700 (PDT)
From: Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>
Date: Thu, 16 Oct 2025 18:22:45 +0800
Subject: [PATCH 3/3] arm64: dts: qcom: sm6150: Add camss node
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251016-sm6150-camss-v1-3-e7f64ac32370@oss.qualcomm.com>
References: <20251016-sm6150-camss-v1-0-e7f64ac32370@oss.qualcomm.com>
In-Reply-To: <20251016-sm6150-camss-v1-0-e7f64ac32370@oss.qualcomm.com>
To: Robert Foss <rfoss@kernel.org>, Todor Tomov <todor.too@gmail.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760610168; l=4109;
 i=wenmeng.liu@oss.qualcomm.com; s=20250925; h=from:subject:message-id;
 bh=ar5eqMmSWUAjAU2fKmuI8Gf7B+3xLb4YaRdEMoTPGpI=;
 b=RNLhMmLfth22LDbdf6j3vk6ieHW2OIE7KuB1dSyP6k4CnQGdF8ggmbnbkT3GnMunRhYKNwD/C
 Bl+tXFUYgNHCjyam7x0W+UlciWeh4ZDSS+D4b3HNbzPdeCDDKNH9NVi
X-Developer-Key: i=wenmeng.liu@oss.qualcomm.com; a=ed25519;
 pk=fQJjf9C3jGDjE1zj2kO3NQLTbQEaZObVcXAzx5WLPX0=
X-Proofpoint-GUID: EzlTrO3loJfARAiFEIk1yJ08rGXLjXBS
X-Authority-Analysis: v=2.4 cv=e5MLiKp/ c=1 sm=1 tr=0 ts=68f0c790 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=jAly02E6oGAraaWWUQAA:9 a=GxgCAwTNdAn-dt3H:21
 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE0MDEzNCBTYWx0ZWRfX9wL1bvtuVxtg
 Ox3p3h5KSmnz+OYLJWNFJTd+6LuarUeM4gUFA9pzIbH6k9n449aX6tTgelF/o2z9e7+oZCQRN5X
 TJPSvCAgNKNzDpwE1C3x22H/akj36p1YasQ1Qq1zTEJ2e+4gmgkBRmQ6Sb9Hq/oGwhgLl3O1U7H
 KhRsyJvhSGLzWw6h9XSq1urHBEoTAkbZAJgbs9/pJDCpmZ3KcjkFJ2YUCXq3y4GAEXvNKRx5Z8V
 ws7T6d4ZAtJBoAXu5vzHfCTRdBUJldmhwjFVJLEQ9/H2tNQt4PyNQQau0x4qdm+f0KgulY8jnJf
 5an5NOY50AkolgVTozd3Y29fGNfs3ZrAv2zxkePs6MVl3NFfWhS+FurHss59CHKJQNkPEOE8Oxx
 V2hiu6Wx+kv3PDkjGBC0x108LE/5rQ==
X-Proofpoint-ORIG-GUID: EzlTrO3loJfARAiFEIk1yJ08rGXLjXBS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-16_01,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 spamscore=0 adultscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 malwarescore=0 bulkscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510140134

Add node for the SM6150 camera subsystem.

Signed-off-by: Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sm6150.dtsi | 121 +++++++++++++++++++++++++++++++++++
 1 file changed, 121 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm6150.dtsi b/arch/arm64/boot/dts/qcom/sm6150.dtsi
index 3d2a1cb02b628a5db7ca14bea784429be5a020f9..ebfb336439b4fdfa567c0e011cd4da88a6290dfd 100644
--- a/arch/arm64/boot/dts/qcom/sm6150.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6150.dtsi
@@ -3646,6 +3646,127 @@ videocc: clock-controller@ab00000 {
 			#power-domain-cells = <1>;
 		};
 
+		camss: isp@acb3000 {
+			compatible = "qcom,sm6150-camss";
+
+			reg = <0x0 0x0acb3000 0x0 0x1000>,
+			      <0x0 0x0acba000 0x0 0x1000>,
+			      <0x0 0x0acc8000 0x0 0x1000>,
+			      <0x0 0x0ac65000 0x0 0x1000>,
+			      <0x0 0x0ac66000 0x0 0x1000>,
+			      <0x0 0x0ac67000 0x0 0x1000>,
+			      <0x0 0x0acaf000 0x0 0x4000>,
+			      <0x0 0x0acb6000 0x0 0x4000>,
+			      <0x0 0x0acc4000 0x0 0x4000>;
+			reg-names = "csid0",
+				    "csid1",
+				    "csid_lite",
+				    "csiphy0",
+				    "csiphy1",
+				    "csiphy2",
+				    "vfe0",
+				    "vfe1",
+				    "vfe_lite";
+
+			clocks = <&camcc CAM_CC_CAMNOC_AXI_CLK>,
+				 <&camcc CAM_CC_CPAS_AHB_CLK>,
+				 <&camcc CAM_CC_CSIPHY0_CLK>,
+				 <&camcc CAM_CC_CSI0PHYTIMER_CLK>,
+				 <&camcc CAM_CC_CSIPHY1_CLK>,
+				 <&camcc CAM_CC_CSI1PHYTIMER_CLK>,
+				 <&camcc CAM_CC_CSIPHY2_CLK>,
+				 <&camcc CAM_CC_CSI2PHYTIMER_CLK>,
+				 <&gcc GCC_CAMERA_HF_AXI_CLK>,
+				 <&camcc CAM_CC_SOC_AHB_CLK>,
+				 <&camcc CAM_CC_IFE_0_CLK>,
+				 <&camcc CAM_CC_IFE_0_AXI_CLK>,
+				 <&camcc CAM_CC_IFE_0_CPHY_RX_CLK>,
+				 <&camcc CAM_CC_IFE_0_CSID_CLK>,
+				 <&camcc CAM_CC_IFE_1_CLK>,
+				 <&camcc CAM_CC_IFE_1_AXI_CLK>,
+				 <&camcc CAM_CC_IFE_1_CPHY_RX_CLK>,
+				 <&camcc CAM_CC_IFE_1_CSID_CLK>,
+				 <&camcc CAM_CC_IFE_LITE_CLK>,
+				 <&camcc CAM_CC_IFE_LITE_CPHY_RX_CLK>,
+				 <&camcc CAM_CC_IFE_LITE_CSID_CLK>;
+
+			clock-names = "camnoc_axi",
+				      "cpas_ahb",
+				      "csiphy0",
+				      "csiphy0_timer",
+				      "csiphy1",
+				      "csiphy1_timer",
+				      "csiphy2",
+				      "csiphy2_timer",
+				      "gcc_axi_hf",
+				      "soc_ahb",
+				      "vfe0",
+				      "vfe0_axi",
+				      "vfe0_cphy_rx",
+				      "vfe0_csid",
+				      "vfe1",
+				      "vfe1_axi",
+				      "vfe1_cphy_rx",
+				      "vfe1_csid",
+				      "vfe_lite",
+				      "vfe_lite_cphy_rx",
+				      "vfe_lite_csid";
+
+			interconnects = <&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ACTIVE_ONLY
+					 &config_noc SLAVE_CAMERA_CFG QCOM_ICC_TAG_ACTIVE_ONLY>,
+					<&mmss_noc MASTER_CAMNOC_HF0 QCOM_ICC_TAG_ALWAYS
+					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>;
+			interconnect-names = "ahb",
+					     "hf_mnoc";
+
+			interrupts = <GIC_SPI 464 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 466 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 468 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 477 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 478 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 479 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 465 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 467 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 469 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "csid0",
+					  "csid1",
+					  "csid_lite",
+					  "csiphy0",
+					  "csiphy1",
+					  "csiphy2",
+					  "vfe0",
+					  "vfe1",
+					  "vfe_lite";
+
+			iommus = <&apps_smmu 0x820 0x40>;
+
+			power-domains = <&camcc IFE_0_GDSC>,
+					<&camcc IFE_1_GDSC>,
+					<&camcc TITAN_TOP_GDSC>;
+			power-domain-names = "ife0",
+					     "ife1",
+					     "top";
+
+			status = "disabled";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+				};
+
+				port@1 {
+					reg = <1>;
+				};
+
+				port@2 {
+					reg = <2>;
+				};
+			};
+		};
+
 		camcc: clock-controller@ad00000 {
 			compatible = "qcom,qcs615-camcc";
 			reg = <0 0x0ad00000 0 0x10000>;

-- 
2.34.1


