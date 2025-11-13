Return-Path: <linux-kernel+bounces-898945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 29D35C565E4
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 09:52:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 274C0351AED
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 08:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2B8A2C0F6F;
	Thu, 13 Nov 2025 08:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PBZQgJ+A";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dZbDPD6B"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55116257824
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 08:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763023583; cv=none; b=l+O1YHrGEZB0VldE2imTFy2r89NjwlELDEnlPCE+Ppr/RmeQL6dI9nfNdFKV8BVw6fGArwEdaPcpp2dQKad31o2B2xkaroGgn4Yivisi0/cGE/DW4CvUTzD0gP1lTMM+M4hJQI9AlNHIYaB7HYxdjXu063JZQ2P7xwo1WukPnx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763023583; c=relaxed/simple;
	bh=jGAs8GDkTdepMafZ6RRqwys5UhmLlRnQZMfjPFvWU14=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rCXJS0zLZ8uXZlpmPvTiioYQYyztOqfcPBCcrUKZE7WHYRJtrmFrTyp7MAP42tKlSauw9yaVNNYB+jNoH49dnZLGuHknhq0f6y9GdEj6h9Fl1cuQdPVBGxGdsBfPc+OawlquOTfL5lCNt++H8x0y9Hg/eQUKEov7oB8oT4cNo1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PBZQgJ+A; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dZbDPD6B; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AD11g0v3036259
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 08:46:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=D3wze9fyhGDJ4KP1QzTcteRoRGZ7U9g3nAS
	QGeqMgHk=; b=PBZQgJ+AqRlc6m/JUx2XvTH9CE2LbP55t/P0RXhhEPZqf689daE
	KzU/o//WJtInYW4NExRqah3qogG8qJXlwOf8OFNkfTRbkk04QviWdPMS5X5mLtaB
	XD2b0bI67N1ElQ7CWJp/WMxLord2qnDiq9JRV0PEy6TDsy7k7HeHFI1hu7sL6CEH
	S8SCc8zDYvb5wwRVQ1LuVmGIztm21k5CGl5xrzSLub9Ho564BOJUnPgPYE4dDpwj
	RUcSKyR5z7GsDfmNE2ZNbs5AtPOSNPWPhLtpIoVwpli1HWPuvIYd3aL2YN55jvQo
	fSp6o0+PxC2ALLHcKfl6Kx97ZPZ1vGQs/IA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ad4ju9d2q-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 08:46:21 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-343bf6ded5cso1367274a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 00:46:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763023581; x=1763628381; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=D3wze9fyhGDJ4KP1QzTcteRoRGZ7U9g3nASQGeqMgHk=;
        b=dZbDPD6BK0xaq4DIKLgfsOOjbhBDJrUIQ6ZZ4wp+aVByDkxTLLzFSkLBf8sbLKlZXs
         lsXUVcbFgOI+URfOFEPgOifi6ASzZfg7HoykXHo8plZxjfgnsDhageTmwkwO7Gc5/Clg
         hifydP+EOo5B15wMFXLxI16u9lz9xl1SAOARPGrLxC+eW/Xinp5YpVJeg5gUPbNQ2Owh
         ELnnJKN2okZHWF+KdO4KpEWPCmftN0a25gHzdIJLJ7vfkWwGXUPUESNhF4N0EK9xEe3T
         U/ong1RAzw8Jbbxll4F7+7PElXgKESdvDEvKjZqossWNUwf3vfeTrTaNfN+ogOLwKASi
         5ywg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763023581; x=1763628381;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D3wze9fyhGDJ4KP1QzTcteRoRGZ7U9g3nASQGeqMgHk=;
        b=fIwkwp45/XBNY9AUhDmhbuqln4shl4umGfhSZixRWdhgHA8nBLYRIahXDxo9rRJ0IH
         DP+Xk+ofSMIy3vLd3lrUZ9n/9qEa166mbh18p10nxK4y/Xa624CyFWAImVqd9z1vGjVH
         Wst7uU9hw5LKTzypb5f9b4yGVh48D5fT0XYeSK/yGOZx3XR7sO3dWig01yGIgoHNPZ5n
         g4rnCTkKjle5Gr28XPnDpYTWJzOf7UWDuNwul6FyFzJ6a6R9Nzq1AGrSxOx7OltcI1Rg
         YLg/cw3aGbFyIMqnRnMOpYSa0gGVbMfpQtalGu46XF+zBaCKaVsq1afqzAbmrIkEdRat
         RJ9A==
X-Forwarded-Encrypted: i=1; AJvYcCXZc0/04zqH42XOPSUMkdQd4IEtaOSWPSQufQspfaIAXmQjNZRN2Xb5is/Ugg/BrCgCw810lJQXLx0lzFA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6nakzPqB9UeJ3mVtlBTjfkS5D/Y6fI4Gd7+KXnlY2M6qHHgtQ
	KLt/RtWtvc+BFHrNQceyhADTE0yhEttZdq9zh1G/k5LoU+GovyTEA/IKk2TA2GghH+vxAejiuJc
	8/KHG8uZr81xpa4/+qStpLW/Jc1Sw7NFOxcV07C5J97jnvLUuS+lbKRtbsZxX0yq1vqQ=
X-Gm-Gg: ASbGncsQF7IpOpR66KSu3pcw3+Vj6I1ckMAD74++RIBkNxnItH0WLxQkvD8jrNaB4wK
	SmuZhdxRflCUsWP+32MMSasVMY84OArXS1DOI8l4zE3hAq9z/lX76gELlI3aULuA0mQZEul5lwT
	CX5fCZ8UxnoirFXwVR8lAtKktf5tvKgkz5CfTsahtyLqVx/ccpDg+uTh8AO9QhFpKnjyXQLvNsK
	nsSnLD+8Lg8BbJgGPJeVezuudxqD1lykMDiopwadYezC9+jwKaK8758TNGd5gmkGTkWm3lpmmBn
	3fpVPu6fk51ekyQaTpf3fse2ciWrzu14PvKh9zQuh3ZwsAxCesepMMtiU8Ax8HX+M08g1FR2GGE
	RlwTRCasnWx6rgXEqeuE2XleojUT6fn3KVMIi
X-Received: by 2002:a17:90b:5625:b0:341:88ba:c6d3 with SMTP id 98e67ed59e1d1-343ddec5702mr7210234a91.23.1763023580737;
        Thu, 13 Nov 2025 00:46:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEqX2Ea/Aovz7+Slvwr4ycE1eB3ZqJee0sXrnYFeJDXMYYaEaRLil3IMHwxyr5d4Ygv6d5f6Q==
X-Received: by 2002:a17:90b:5625:b0:341:88ba:c6d3 with SMTP id 98e67ed59e1d1-343ddec5702mr7210205a91.23.1763023580146;
        Thu, 13 Nov 2025 00:46:20 -0800 (PST)
Received: from hu-kriskura-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bc375fe4da5sm1422954a12.26.2025.11.13.00.46.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 00:46:19 -0800 (PST)
From: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
Subject: [PATCH] arm64: dts: qcom: sdx75: Flatten usb controller node
Date: Thu, 13 Nov 2025 14:16:08 +0530
Message-Id: <20251113084608.3837064-1-krishna.kurapati@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: FAQ1yneNwGf0S3j6v3LSdD-Q70xH9b5r
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEzMDA2MiBTYWx0ZWRfXxtOrhsQXKfDq
 SwYPa4QGdYpniQ8ynDKMrIHnC9L2UUd/H1u/SzZHXrIKpYynPZ5tqh4eDg1pBI5TsNYydYI2k7I
 koy2BPi6riTmcKNvOClRkPBxtt1dkDAb7+DVIDzRDKGRObxER/XCQ+Xn0HvWI9cyfSuRk9DvtHk
 OztAEn4y5T8GrV3x6ncyx+b+merucNZs2c2JhnzyfBzGbGFYKCj2s2uj+Xb92kxjnD/H+YG+UeY
 jJ0q5d8J35nhQfa9Ph1wTWOCqa+iTDAlW5GrM0LOh2vIAKXaC6JEfUsyUSWQw9CIot1R5FDXbsW
 u9JxcyCdbbYwK1RF1gqYPxnY8p0oFLnMpEVTugzooIIa9Wx+V0kOdVw/h3SDbhrP0WjkWJVhmuN
 lm8oUTgHMv7UOxnrnb6lfKWB0j4zDw==
X-Authority-Analysis: v=2.4 cv=BdnVE7t2 c=1 sm=1 tr=0 ts=69159add cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=1q36Q9n_z7eM6CNx3OUA:9 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: FAQ1yneNwGf0S3j6v3LSdD-Q70xH9b5r
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-13_01,2025-11-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 bulkscore=0 priorityscore=1501 spamscore=0
 lowpriorityscore=0 suspectscore=0 malwarescore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511130062

Flatten usb controller node and update to using latest bindings
and flattened driver approach.

Also add the missing usb-role-switch property in base dt node.

Signed-off-by: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sdx75-idp.dts |  6 +--
 arch/arm64/boot/dts/qcom/sdx75.dtsi    | 67 ++++++++++++--------------
 2 files changed, 34 insertions(+), 39 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdx75-idp.dts b/arch/arm64/boot/dts/qcom/sdx75-idp.dts
index 06cacec3461f..6696e1aee243 100644
--- a/arch/arm64/boot/dts/qcom/sdx75-idp.dts
+++ b/arch/arm64/boot/dts/qcom/sdx75-idp.dts
@@ -337,11 +337,9 @@ &uart1 {
 };
 
 &usb {
-	status = "okay";
-};
-
-&usb_dwc3 {
 	dr_mode = "peripheral";
+
+	status = "okay";
 };
 
 &usb_hsphy {
diff --git a/arch/arm64/boot/dts/qcom/sdx75.dtsi b/arch/arm64/boot/dts/qcom/sdx75.dtsi
index f26ba90ba66d..6e7695146ff8 100644
--- a/arch/arm64/boot/dts/qcom/sdx75.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdx75.dtsi
@@ -1019,12 +1019,9 @@ opp-384000000 {
 			};
 		};
 
-		usb: usb@a6f8800 {
-			compatible = "qcom,sdx75-dwc3", "qcom,dwc3";
-			reg = <0x0 0x0a6f8800 0x0 0x400>;
-			#address-cells = <2>;
-			#size-cells = <2>;
-			ranges;
+		usb: usb@a600000 {
+			compatible = "qcom,sdx75-dwc3", "qcom,snps-dwc3";
+			reg = <0x0 0x0a600000 0x0 0xfc100>;
 
 			clocks = <&gcc GCC_USB30_SLV_AHB_CLK>,
 				 <&gcc GCC_USB30_MASTER_CLK>,
@@ -1041,21 +1038,35 @@ usb: usb@a6f8800 {
 					  <&gcc GCC_USB30_MASTER_CLK>;
 			assigned-clock-rates = <19200000>, <200000000>;
 
-			interrupts-extended = <&intc GIC_SPI 130 IRQ_TYPE_LEVEL_HIGH>,
+			interrupts-extended = <&intc GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>,
+					      <&intc GIC_SPI 130 IRQ_TYPE_LEVEL_HIGH>,
 					      <&intc GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>,
 					      <&pdc 10 IRQ_TYPE_EDGE_RISING>,
 					      <&pdc 9 IRQ_TYPE_EDGE_RISING>,
 					      <&pdc 17 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names = "pwr_event",
+			interrupt-names = "dwc_usb3",
+					  "pwr_event",
 					  "hs_phy_irq",
 					  "dp_hs_phy_irq",
 					  "dm_hs_phy_irq",
 					  "ss_phy_irq";
 
+			iommus = <&apps_smmu 0x80 0x0>;
+
+			snps,dis_u2_susphy_quirk;
+			snps,dis_enblslpm_quirk;
+			snps,dis-u1-entry-quirk;
+			snps,dis-u2-entry-quirk;
+
 			power-domains = <&gcc GCC_USB30_GDSC>;
 
 			resets = <&gcc GCC_USB30_BCR>;
 
+			phys = <&usb_hsphy>,
+			       <&usb_qmpphy>;
+			phy-names = "usb2-phy",
+				    "usb3-phy";
+
 			interconnects = <&system_noc MASTER_USB3_0 QCOM_ICC_TAG_ALWAYS
 					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>,
 					<&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ALWAYS
@@ -1063,38 +1074,24 @@ &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>,
 			interconnect-names = "usb-ddr",
 					     "apps-usb";
 
+			usb-role-switch;
 			status = "disabled";
 
-			usb_dwc3: usb@a600000 {
-				compatible = "snps,dwc3";
-				reg = <0x0 0x0a600000 0x0 0xcd00>;
-				interrupts = <GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>;
-				iommus = <&apps_smmu 0x80 0x0>;
-				snps,dis_u2_susphy_quirk;
-				snps,dis_enblslpm_quirk;
-				snps,dis-u1-entry-quirk;
-				snps,dis-u2-entry-quirk;
-				phys = <&usb_hsphy>,
-				       <&usb_qmpphy>;
-				phy-names = "usb2-phy",
-					    "usb3-phy";
-
-				ports {
-					#address-cells = <1>;
-					#size-cells = <0>;
-
-					port@0 {
-						reg = <0>;
-
-						usb_1_dwc3_hs: endpoint {
-						};
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+
+					usb_1_dwc3_hs: endpoint {
 					};
+				};
 
-					port@1 {
-						reg = <1>;
+				port@1 {
+					reg = <1>;
 
-						usb_1_dwc3_ss: endpoint {
-						};
+					usb_1_dwc3_ss: endpoint {
 					};
 				};
 			};
-- 
2.34.1


