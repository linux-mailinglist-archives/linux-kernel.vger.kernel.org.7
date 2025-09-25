Return-Path: <linux-kernel+bounces-831827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFB9AB9DA3B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 08:34:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95A1A4A57A6
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 06:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B76B12EA15C;
	Thu, 25 Sep 2025 06:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bWzNhRWU"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1D122F39AB
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 06:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758781815; cv=none; b=O+b/3OsfBdpzkbP1+kFE+kGqdJ/GNICWLOtVTk0RJ/LO4C+qRwrGj5qOiTtedwZZ/0OrENueNJsPyNvymeek2uPKo7Zncf0QViDbFplh3GctorMR8DYI/yvjVlh84GoOZBtXEyCVxjTuCYA2tmBgRFZ1kFPcnFjJwPtP2V4m+ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758781815; c=relaxed/simple;
	bh=UBz35o+vsNPHHJAJAKQ5dGZIU0Ub2P7wIu4H4iRumkA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=B6FLEOlBK5oBjMoIegXx/Bhy5sPzRgXVP2+rtIjbDRPwcvi2R+rM9AV3KtWlPS/C5A90tabuvCV1K1DkIWU8koA0TrdlXaIZvcDA31oSFzGQBM4cPEzpj43IgAVP3iQyooAkaz6DfVMcbK1nfxD/L7D+mLzfoDDpqhF94MiugzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bWzNhRWU; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58P0rHJb002802
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 06:30:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	CgPRZoAtn2ocSBxx9IZf3nb9Goo0KbV0/KKkG9aBkSc=; b=bWzNhRWU45Ng/yP3
	qhzNOuEzfuc83XZ0PdCAh7nlbWON2WBbEHRNy176OctUeRJ500gvjM0yc5ByHvWX
	5DQE4XPGc0cFFKMzMyhidnOvFBsXCSvCfmKB4eP7+d0ETwFxlCuxIKkX1TxkJyLa
	YjxHYN0Wl3ibih7YBu71qwl7m+7uLhOMGJh8u59hgRtsg1k44W6We/9IguQyXQxh
	v+vm7JA9yxCBpWNqKSr+NwJ4pDV7id80ipX/93WfAPlZj91o8tuKH4qhoguOzwmd
	pRIxLX8dowUjKT2TwZKTx2kzBqBur3yId41CMYliCH4RKPWxHE/nijIvlJq3roZN
	tHQiQA==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49bajf1j91-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 06:30:12 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-780f7238196so503156b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:30:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758781811; x=1759386611;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CgPRZoAtn2ocSBxx9IZf3nb9Goo0KbV0/KKkG9aBkSc=;
        b=eHNd90rxCPsq+5u6UsVYVfO054G3KZBH/2P9mbXZ4ckHC+czSY9vx7eMlraLt2Bs57
         wuIrIUKShGwgPggkwlwGe1ks9po8DHdOYIJHBovqC1RIjB/GJqMwwFKh5hmarBqI7GA8
         p3SfH+VeSY4FSUpDZSNtbG1To8WesgJIcLU6nPFlUMQM2ZN9nrP25IvqCJA2V7fvhr7/
         xZj7tH/uThaJoUmEsoeVMRZGuOybGZmbHuZA/ISvoe39uEclmBIUMETJEDDMeMAI306S
         1eJ54aVmg81NuuusopFAnDSgKLp2UpOr13K43WGubSePYkVlck+dQal1W/VM2PDFtGwX
         wmHQ==
X-Forwarded-Encrypted: i=1; AJvYcCULkz5vAHoI3LxdZs1yseBo53O9wrTbJoNCuc8eKvKBz/nNjIS8r+3S4PmF/rfiMpHPWY3ta5SX7lUXx7k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUwy3pUlDIiyRX1NoinREvm24Te9Yz6s7MkraBeCF5P8BmML3O
	XzKeYQKZJxRipebwHA1cZ6MgkOegzqA2lIz91nnEiWK/5W/EscVV1seylFFBJA0k36Jt+u1uLYj
	Ov3hlNFyefsntIRpIec5fdaMjJcacd2GN1dNYzcZq0/h2lmFZZmSUhvmnPBbGb3hXiak=
X-Gm-Gg: ASbGncs0brEogc7r2wehfPJfawDTcmIJhW746dFBr+Bo3YYXldllTV9xQudc0awd2Vz
	ED6RMFiJq+ulkHgofj2lX744Gwx++qZbVOo7fQaZE6wkCNC8Lj7hbzsYMk1F2MoDXBEdkxUuabt
	I4Akp5FdmRy5PLl1ygbLumYBVw0m3m3o0A0Ph392k/vLlTzj6ClQum5MMaLaCi4yEnSnTzOohsd
	O1los5zNPSKVcrXNFRcvFwhb8wKGUX4nXY8ilzCKtqy/wVBn5w0+mwnR7ZO/9wmd/hfRpRYKTDh
	9RWBXEE2hWo9ucf4bzOI8lR83FjvJk8MvSnWMWEFM9pgC/BK1efQ0dtdPRAoIYZnqs8GGOXQk9o
	JkPTb1Rm5eRUFGW38iREDq8Qc24hUZ1+v57PyJIV/VFK9O7YqD+aHkJ2g/GHL
X-Received: by 2002:a05:6a00:3cc8:b0:772:823b:78b5 with SMTP id d2e1a72fcca58-780fce04facmr2939485b3a.8.1758781811049;
        Wed, 24 Sep 2025 23:30:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEc/wH9Jp1jUCwdp5i/ddk12eHSjL40pT96LOvTQ9FriEO2D29JB+mkGxlMiYb0TuN6aW1RLg==
X-Received: by 2002:a05:6a00:3cc8:b0:772:823b:78b5 with SMTP id d2e1a72fcca58-780fce04facmr2939433b3a.8.1758781810041;
        Wed, 24 Sep 2025 23:30:10 -0700 (PDT)
Received: from hu-pankpati-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7810239136dsm952962b3a.5.2025.09.24.23.30.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 23:30:09 -0700 (PDT)
From: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
Date: Thu, 25 Sep 2025 11:58:29 +0530
Subject: [PATCH v2 23/24] arm64: dts: qcom: glymur: Add USB support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250925-v3_glymur_introduction-v2-23-8e1533a58d2d@oss.qualcomm.com>
References: <20250925-v3_glymur_introduction-v2-0-8e1533a58d2d@oss.qualcomm.com>
In-Reply-To: <20250925-v3_glymur_introduction-v2-0-8e1533a58d2d@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Pankaj Patil <pankaj.patil@oss.qualcomm.com>,
        Wesley Cheng <wesley.cheng@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: dC4Ne57ePTJwQFQid4ccU4JKlSV1ufbU
X-Authority-Analysis: v=2.4 cv=fY2ty1QF c=1 sm=1 tr=0 ts=68d4e174 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=eIqh0il2kew2myUVSeUA:9
 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIyMDE2OCBTYWx0ZWRfXxqy2z2WbKNuA
 lKwpPU0Be4QB+yDQ2bO4CszUN587/m4Jcm+V9J7smkYUH3Deb/26HMSfVflWEw7FIFJODCRzJo0
 4WB4zZsKpjZJOMuKuz1WLQFipdOKv05PZ161F/BtRe1SwLiiIl9VZX9080vIXKuIFSUOrsLTfEK
 NcKyeC37llKOmTugbxhuzOdT+cc49YKkdbU/hshf7ltYFXGvyP/jAWGRMrupvbK0KTKN5AYbSWp
 p30UigN3Pzdp4jRUrpWDFwWsRycZuR29wy+IGu6+vIuq1uku+26QWWgNN8HGx05hTH9ABqmfv4y
 tyxRXypDu/29aq2/1o8UbbEt2DYep3rXii12SOCO5x0/NW/NwE0NDfyUS/VvQKgxFQsUF9v/yRe
 gr6isyv5
X-Proofpoint-ORIG-GUID: dC4Ne57ePTJwQFQid4ccU4JKlSV1ufbU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 impostorscore=0
 phishscore=0 bulkscore=0 priorityscore=1501 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509220168

From: Wesley Cheng <wesley.cheng@oss.qualcomm.com>

The Glymur USB system contains 3 USB type C ports, and 1 USB multiport
controller.  This encompasses 5 SS USB QMP PHYs (3 combo and 2 uni) and 5
M31 eUSB2 PHYs.  The controllers are SNPS DWC3 based, and will use the
flattened DWC3 QCOM design.

Signed-off-by: Wesley Cheng <wesley.cheng@oss.qualcomm.com>
Signed-off-by: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/glymur-crd.dts | 243 ++++++++++++++
 arch/arm64/boot/dts/qcom/glymur.dtsi    | 569 ++++++++++++++++++++++++++++++++
 2 files changed, 812 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/glymur-crd.dts b/arch/arm64/boot/dts/qcom/glymur-crd.dts
index 03aacdb1dd7e2354fe31e63183519e53fa022829..100519aa5a7cd905285d3aa41ebe5f63ae00aeef 100644
--- a/arch/arm64/boot/dts/qcom/glymur-crd.dts
+++ b/arch/arm64/boot/dts/qcom/glymur-crd.dts
@@ -99,10 +99,74 @@ ports {
 
 				port@0 {
 					reg = <0>;
+
+					pmic_glink_hs_in: endpoint {
+						remote-endpoint = <&usb_0_dwc3_hs>;
+					};
+				};
+
+				port@1 {
+					reg = <1>;
+
+					pmic_glink_ss_in: endpoint {
+						remote-endpoint = <&usb_dp_qmpphy_out>;
+					};
+				};
+			};
+		};
+
+		connector@1 {
+			compatible = "usb-c-connector";
+			reg = <1>;
+			power-role = "dual";
+			data-role = "dual";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+
+					pmic_glink_hs_in1: endpoint {
+						remote-endpoint = <&usb_1_dwc3_hs>;
+					};
 				};
 
 				port@1 {
 					reg = <1>;
+
+					pmic_glink_ss_in1: endpoint {
+						remote-endpoint = <&usb_1_ss1_qmpphy_out>;
+					};
+				};
+			};
+		};
+
+		connector@2 {
+			compatible = "usb-c-connector";
+			reg = <2>;
+			power-role = "dual";
+			data-role = "dual";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+
+					pmic_glink_hs_in2: endpoint {
+						remote-endpoint = <&usb_2_dwc3_hs>;
+					};
+				};
+
+				port@1 {
+					reg = <1>;
+
+					pmic_glink_ss_in2: endpoint {
+						remote-endpoint = <&usb_1_ss2_qmpphy_out>;
+					};
 				};
 			};
 		};
@@ -529,3 +593,182 @@ &pcie5port0 {
 	perst-gpios = <&tlmm 152 GPIO_ACTIVE_LOW>;
 	wake-gpios = <&tlmm 154 GPIO_ACTIVE_LOW>;
 };
+
+&i2c5 {
+	status = "ok";
+
+	clock-frequency = <400000>;
+
+	ptn3222_0: redriver@43 {
+		compatible = "nxp,ptn3222";
+		reg = <0x43>;
+
+		reset-gpios = <&tlmm 8 GPIO_ACTIVE_LOW>;
+
+		vdd3v3-supply = <&vreg_l8b_e0_1p50>;
+		vdd1v8-supply = <&vreg_l15b_e0_1p8>;
+
+		#phy-cells = <0>;
+	};
+
+	ptn3222_1: redriver@4f {
+		compatible = "nxp,ptn3222";
+		reg = <0x4f>;
+
+		reset-gpios = <&tlmm 184 GPIO_ACTIVE_LOW>;
+
+		vdd3v3-supply = <&vreg_l8b_e0_1p50>;
+		vdd1v8-supply = <&vreg_l15b_e0_1p8>;
+
+		#phy-cells = <0>;
+	};
+};
+
+&smb2370_j_e2_eusb2_repeater {
+	vdd18-supply = <&vreg_l15b_e0_1p8>;
+	vdd3-supply = <&vreg_l7b_e0_2p79>;
+};
+
+&smb2370_k_e2_eusb2_repeater {
+	vdd18-supply = <&vreg_l15b_e0_1p8>;
+	vdd3-supply = <&vreg_l7b_e0_2p79>;
+};
+
+&smb2370_l_e2_eusb2_repeater {
+	vdd18-supply = <&vreg_l15b_e0_1p8>;
+	vdd3-supply = <&vreg_l7b_e0_2p79>;
+};
+
+&usb_1_ss0_hsphy {
+	vdd-supply = <&vreg_l3f_e0_0p72>;
+	vdda12-supply = <&vreg_l4h_e0_1p2>;
+
+	phys = <&smb2370_j_e2_eusb2_repeater>;
+
+	status = "okay";
+};
+
+&usb_1_ss0_qmpphy {
+	vdda-phy-supply = <&vreg_l4h_e0_1p2>;
+	vdda-pll-supply = <&vreg_l3f_e0_0p72>;
+	refgen-supply = <&vreg_l2f_e0_0p82>;
+
+	status = "okay";
+};
+
+&usb_dp_qmpphy_out {
+	remote-endpoint = <&pmic_glink_ss_in>;
+};
+
+&usb_0_dwc3_hs {
+	remote-endpoint = <&pmic_glink_hs_in>;
+};
+
+&usb_1_ss0 {
+	dr_mode = "otg";
+	usb-role-switch;
+
+	status = "okay";
+};
+
+&usb_1_ss1_qmpphy_out {
+	remote-endpoint = <&pmic_glink_ss_in1>;
+};
+
+&usb_1_dwc3_hs {
+	remote-endpoint = <&pmic_glink_hs_in1>;
+};
+
+&usb_1_ss1_hsphy {
+	vdd-supply = <&vreg_l3f_e0_0p72>;
+	vdda12-supply = <&vreg_l4h_e0_1p2>;
+
+	phys = <&smb2370_k_e2_eusb2_repeater>;
+
+	status = "okay";
+};
+
+&usb_1_ss1_qmpphy {
+	vdda-phy-supply = <&vreg_l4h_e0_1p2>;
+	vdda-pll-supply = <&vreg_l1h_e0_0p89>;
+	refgen-supply = <&vreg_l2f_e0_0p82>;
+
+	status = "okay";
+};
+
+&usb1_ss1 {
+	dr_mode = "otg";
+	usb-role-switch;
+
+	status = "okay";
+};
+
+&usb_1_ss2_qmpphy_out {
+	remote-endpoint = <&pmic_glink_ss_in2>;
+};
+
+&usb_2_dwc3_hs {
+	remote-endpoint = <&pmic_glink_hs_in2>;
+};
+
+&usb_1_ss2_hsphy {
+	vdd-supply = <&vreg_l4c_e1_0p72>;
+	vdda12-supply = <&vreg_l4f_e1_1p08>;
+
+	phys = <&smb2370_l_e2_eusb2_repeater>;
+
+	status = "okay";
+};
+
+&usb_1_ss2_qmpphy {
+	vdda-phy-supply = <&vreg_l4f_e1_1p08>;
+	vdda-pll-supply = <&vreg_l4c_e1_0p72>;
+	refgen-supply = <&vreg_l1c_e1_0p82>;
+
+	status = "okay";
+};
+
+&usb1_ss2 {
+	dr_mode = "otg";
+	usb-role-switch;
+
+	status = "okay";
+};
+
+&usb_mp_hsphy0 {
+	vdd-supply = <&vreg_l2h_e0_0p72>;
+	vdda12-supply = <&vreg_l4h_e0_1p2>;
+
+	phys = <&ptn3222_0>;
+
+	status = "okay";
+};
+
+&usb_mp_hsphy1 {
+	vdd-supply = <&vreg_l2h_e0_0p72>;
+	vdda12-supply = <&vreg_l4h_e0_1p2>;
+
+	phys = <&ptn3222_1>;
+
+	status = "okay";
+};
+
+&usb_mp_qmpphy0 {
+	vdda-phy-supply = <&vreg_l4h_e0_1p2>;
+	vdda-pll-supply = <&vreg_l2h_e0_0p72>;
+	refgen-supply = <&vreg_l4f_e1_1p08>;
+
+	status = "okay";
+};
+
+&usb_mp_qmpphy1 {
+	vdda-phy-supply = <&vreg_l4h_e0_1p2>;
+	vdda-pll-supply = <&vreg_l2h_e0_0p72>;
+	refgen-supply = <&vreg_l4f_e1_1p08>;
+
+	status = "okay";
+};
+
+&usb_mp {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/qcom/glymur.dtsi b/arch/arm64/boot/dts/qcom/glymur.dtsi
index 8a563d55bdd4902222039946dd75eaf4d3a4895b..c48d3a70820e551822c5322761528159da127ca6 100644
--- a/arch/arm64/boot/dts/qcom/glymur.dtsi
+++ b/arch/arm64/boot/dts/qcom/glymur.dtsi
@@ -2417,6 +2417,231 @@ &config_noc SLAVE_QUP_0 QCOM_ICC_TAG_ALWAYS>,
 			};
 		};
 
+		usb_mp_hsphy0: phy@fa1000 {
+			compatible = "qcom,glymur-m31-eusb2-phy",
+				     "qcom,sm8750-m31-eusb2-phy";
+
+			reg = <0 0x00fa1000 0 0x29c>;
+			#phy-cells = <0>;
+
+			clocks = <&tcsrcc TCSR_USB2_1_CLKREF_EN>;
+			clock-names = "ref";
+
+			resets = <&gcc GCC_QUSB2PHY_HS0_MP_BCR>;
+
+			status = "disabled";
+		};
+
+		usb_mp_hsphy1: phy@fa2000  {
+			compatible = "qcom,glymur-m31-eusb2-phy",
+				     "qcom,sm8750-m31-eusb2-phy";
+
+			reg = <0 0x00fa2000 0 0x29c>;
+			#phy-cells = <0>;
+
+			clocks = <&tcsrcc TCSR_USB2_2_CLKREF_EN>;
+			clock-names = "ref";
+
+			resets = <&gcc GCC_QUSB2PHY_HS1_MP_BCR>;
+
+			status = "disabled";
+		};
+
+		usb_mp_qmpphy0: phy@fa3000 {
+			compatible = "qcom,glymur-qmp-usb3-uni-phy";
+			reg = <0 0x00fa3000 0 0x2000>;
+
+			clocks = <&gcc GCC_USB3_MP_PHY_AUX_CLK>,
+				 <&tcsrcc TCSR_USB3_0_CLKREF_EN>,
+				 <&rpmhcc RPMH_CXO_CLK>,
+				 <&gcc GCC_USB3_MP_PHY_COM_AUX_CLK>,
+				 <&gcc GCC_USB3_MP_PHY_PIPE_0_CLK>;
+			clock-names = "aux",
+				      "clkref",
+				      "ref",
+				      "com_aux",
+				      "pipe";
+
+			power-domains = <&gcc GCC_USB3_MP_SS0_PHY_GDSC>;
+
+			resets = <&gcc GCC_USB3_MP_SS0_PHY_BCR>,
+				 <&gcc GCC_USB3UNIPHY_PHY_MP0_BCR>;
+			reset-names = "phy",
+				      "phy_phy";
+
+			clock-output-names = "usb3_uni_phy_0_pipe_clk_src";
+			#clock-cells = <0>;
+			#phy-cells = <0>;
+
+			status = "disabled";
+		};
+
+		usb_mp_qmpphy1: phy@fa5000 {
+			compatible = "qcom,glymur-qmp-usb3-uni-phy";
+			reg = <0 0x00fa5000 0 0x2000>;
+
+			clocks = <&gcc GCC_USB3_MP_PHY_AUX_CLK>,
+				 <&tcsrcc TCSR_USB3_1_CLKREF_EN>,
+				 <&rpmhcc RPMH_CXO_CLK>,
+				 <&gcc GCC_USB3_MP_PHY_COM_AUX_CLK>,
+				 <&gcc GCC_USB3_MP_PHY_PIPE_1_CLK>;
+			clock-names = "aux",
+				      "clkref",
+				      "ref",
+				      "com_aux",
+				      "pipe";
+
+			power-domains = <&gcc GCC_USB3_MP_SS1_PHY_GDSC>;
+
+			resets = <&gcc GCC_USB3_MP_SS1_PHY_BCR>,
+				 <&gcc GCC_USB3UNIPHY_PHY_MP1_BCR>;
+			reset-names = "phy",
+				      "phy_phy";
+
+			clock-output-names = "usb3_uni_phy_1_pipe_clk_src";
+
+			#clock-cells = <0>;
+			#phy-cells = <0>;
+
+			status = "disabled";
+		};
+
+		usb_1_ss0_hsphy: phy@fd3000 {
+			compatible = "qcom,glymur-m31-eusb2-phy",
+				     "qcom,sm8750-m31-eusb2-phy";
+
+			reg = <0 0x00fd3000 0 0x29c>;
+			#phy-cells = <0>;
+
+			resets = <&gcc GCC_QUSB2PHY_PRIM_BCR>;
+
+			status = "disabled";
+		};
+
+		usb_1_ss0_qmpphy: phy@fd5000 {
+			compatible = "qcom,glymur-qmp-usb3-dp-phy";
+			reg = <0 0x00fd5000 0 0x8000>;
+
+			clocks = <&gcc GCC_USB3_PRIM_PHY_AUX_CLK>,
+				 <&rpmhcc RPMH_CXO_CLK>,
+				 <&gcc GCC_USB3_PRIM_PHY_COM_AUX_CLK>,
+				 <&gcc GCC_USB3_PRIM_PHY_PIPE_CLK>;
+			clock-names = "aux",
+				      "ref",
+				      "com_aux",
+				      "usb3_pipe";
+
+			resets = <&gcc GCC_USB3_PHY_PRIM_BCR>,
+				 <&gcc GCC_USB3PHY_PHY_PRIM_BCR>;
+
+			reset-names = "phy",
+				      "common";
+
+			power-domains = <&gcc GCC_USB_0_PHY_GDSC>;
+
+			#clock-cells = <1>;
+			#phy-cells = <1>;
+
+			orientation-switch;
+
+			status = "disabled";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+
+					usb_dp_qmpphy_out: endpoint {
+					};
+				};
+
+				port@1 {
+					reg = <1>;
+
+					usb_1_ss0_qmpphy_usb_ss_in: endpoint {
+						remote-endpoint = <&usb_1_ss0>;
+					};
+				};
+
+				port@2 {
+					reg = <2>;
+
+					usb_dp_qmpphy_dp_in: endpoint {
+					};
+				};
+			};
+		};
+
+		usb_1_ss1_hsphy: phy@fdd000  {
+			compatible = "qcom,glymur-m31-eusb2-phy",
+				     "qcom,sm8750-m31-eusb2-phy";
+
+			reg = <0 0x00fdd000 0 0x29c>;
+			#phy-cells = <0>;
+
+			resets = <&gcc GCC_QUSB2PHY_SEC_BCR>;
+
+			status = "disabled";
+		};
+
+		usb_1_ss1_qmpphy: phy@fde000 {
+			compatible = "qcom,glymur-qmp-usb3-dp-phy";
+			reg = <0 0x00fde000 0 0x8000>;
+
+			clocks = <&gcc GCC_USB3_SEC_PHY_AUX_CLK>,
+				 <&rpmhcc RPMH_CXO_CLK>,
+				 <&gcc GCC_USB3_SEC_PHY_COM_AUX_CLK>,
+				 <&gcc GCC_USB3_SEC_PHY_PIPE_CLK>,
+				 <&tcsrcc TCSR_USB4_1_CLKREF_EN>;
+			clock-names = "aux",
+				      "ref",
+				      "com_aux",
+				      "usb3_pipe",
+				      "clkref";
+
+			power-domains = <&gcc GCC_USB_1_PHY_GDSC>;
+
+			resets = <&gcc GCC_USB3_PHY_SEC_BCR>,
+				 <&gcc GCC_USB3PHY_PHY_SEC_BCR>;
+			reset-names = "phy",
+				      "common";
+
+			#clock-cells = <1>;
+			#phy-cells = <1>;
+			orientation-switch;
+
+			status = "disabled";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+
+					usb_1_ss1_qmpphy_out: endpoint {
+					};
+				};
+
+				port@1 {
+					reg = <1>;
+
+					usb_1_ss1_qmpphy_usb_ss_in: endpoint {
+						remote-endpoint = <&usb1_ss1>;
+					};
+				};
+
+				port@2 {
+					reg = <2>;
+
+					usb_1_ss1_qmpphy_dp_in: endpoint {
+					};
+				};
+			};
+		};
+
 		cnoc_main: interconnect@1500000 {
 			compatible = "qcom,glymur-cnoc-main";
 			reg = <0x0 0x01500000 0x0 0x17080>;
@@ -2777,6 +3002,350 @@ lpass_ag_noc: interconnect@7e40000 {
 			#interconnect-cells = <2>;
 		};
 
+		usb_1_ss2_hsphy: phy@88e0000  {
+			compatible = "qcom,glymur-m31-eusb2-phy",
+				     "qcom,sm8750-m31-eusb2-phy";
+
+			reg = <0 0x088e0000 0 0x29c>;
+			#phy-cells = <0>;
+
+			clocks = <&tcsrcc TCSR_USB2_4_CLKREF_EN>;
+			clock-names = "ref";
+
+			resets = <&gcc GCC_QUSB2PHY_TERT_BCR>;
+
+			status = "disabled";
+		};
+
+		usb_1_ss2_qmpphy: phy@88e1000 {
+			compatible = "qcom,glymur-qmp-usb3-dp-phy";
+			reg = <0 0x088e1000 0 0x8000>;
+
+			clocks = <&gcc GCC_USB3_TERT_PHY_AUX_CLK>,
+				 <&rpmhcc RPMH_CXO_CLK>,
+				 <&gcc GCC_USB3_TERT_PHY_COM_AUX_CLK>,
+				 <&gcc GCC_USB3_TERT_PHY_PIPE_CLK>,
+				 <&tcsrcc TCSR_USB4_2_CLKREF_EN>;
+			clock-names = "aux",
+				      "ref",
+				      "com_aux",
+				      "usb3_pipe",
+				      "clkref";
+
+			power-domains = <&gcc GCC_USB_2_PHY_GDSC>;
+
+			resets = <&gcc GCC_USB3_PHY_TERT_BCR>,
+				 <&gcc GCC_USB3PHY_PHY_TERT_BCR>;
+			reset-names = "phy",
+				      "common";
+
+			#clock-cells = <1>;
+			#phy-cells = <1>;
+			orientation-switch;
+
+			status = "disabled";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+
+					usb_1_ss2_qmpphy_out: endpoint {
+					};
+				};
+
+				port@1 {
+					reg = <1>;
+
+					usb_1_ss2_qmpphy_usb_ss_in: endpoint {
+						remote-endpoint = <&usb1_ss2>;
+					};
+				};
+
+				port@2 {
+					reg = <2>;
+
+					usb_1_ss2_qmpphy_dp_in: endpoint {
+					};
+				};
+			};
+		};
+
+		usb_1_ss0: usb@a600000 {
+			compatible = "qcom,glymur-dwc3", "qcom,snps-dwc3";
+			reg = <0 0x0a600000 0 0xfc100>;
+
+			clocks = <&gcc GCC_CFG_NOC_USB3_PRIM_AXI_CLK>,
+				 <&gcc GCC_USB30_PRIM_MASTER_CLK>,
+				 <&gcc GCC_AGGRE_USB3_PRIM_AXI_CLK>,
+				 <&gcc GCC_USB30_PRIM_SLEEP_CLK>,
+				 <&gcc GCC_USB30_PRIM_MOCK_UTMI_CLK>,
+				 <&gcc GCC_CFG_NOC_USB_ANOC_AHB_CLK>,
+				 <&gcc GCC_CFG_NOC_USB_ANOC_SOUTH_AHB_CLK>;
+			clock-names = "cfg_noc",
+				      "core",
+				      "iface",
+				      "sleep",
+				      "mock_utmi",
+				      "noc_aggr_north",
+				      "noc_aggr_south";
+
+			interrupts-extended = <&intc GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>,
+					      <&intc GIC_SPI 371 IRQ_TYPE_LEVEL_HIGH>,
+					      <&pdc 90 IRQ_TYPE_EDGE_BOTH>,
+					      <&pdc 60 IRQ_TYPE_EDGE_BOTH>,
+					      <&pdc 17 IRQ_TYPE_EDGE_BOTH>;
+			interrupt-names = "dwc_usb3",
+					  "pwr_event",
+					  "dp_hs_phy_irq",
+					  "dm_hs_phy_irq",
+					  "ss_phy_irq";
+
+			power-domains = <&gcc GCC_USB30_PRIM_GDSC>;
+			resets = <&gcc GCC_USB30_PRIM_BCR>;
+
+			iommus = <&apps_smmu 0x1420 0x0>;
+			phys = <&usb_1_ss0_hsphy>,
+			       <&usb_1_ss0_qmpphy QMP_USB43DP_USB3_PHY>;
+			phy-names = "usb2-phy",
+				    "usb3-phy";
+
+			snps,dis_u2_susphy_quirk;
+			snps,dis_enblslpm_quirk;
+			snps,dis_u3_susphy_quirk;
+			snps,usb2-lpm-disable;
+
+			dr_mode = "peripheral";
+
+			status = "disabled";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+
+					usb_0_dwc3_hs: endpoint {
+					};
+				};
+
+				port@1 {
+					reg = <1>;
+
+					usb_0_dwc3_ss: endpoint {
+						remote-endpoint = <&usb_1_ss0_qmpphy_usb_ss_in>;
+					};
+				};
+			};
+		};
+
+		usb1_ss1: usb@a800000 {
+			compatible = "qcom,glymur-dwc3", "qcom,snps-dwc3";
+			reg = <0 0x0a800000 0 0xfc100>;
+
+			clocks = <&gcc GCC_CFG_NOC_USB3_SEC_AXI_CLK>,
+				 <&gcc GCC_USB30_SEC_MASTER_CLK>,
+				 <&gcc GCC_AGGRE_USB3_SEC_AXI_CLK>,
+				 <&gcc GCC_USB30_SEC_SLEEP_CLK>,
+				 <&gcc GCC_USB30_SEC_MOCK_UTMI_CLK>,
+				 <&gcc GCC_CFG_NOC_USB_ANOC_AHB_CLK>,
+				 <&gcc GCC_CFG_NOC_USB_ANOC_SOUTH_AHB_CLK>;
+			clock-names = "cfg_noc",
+				      "core",
+				      "iface",
+				      "sleep",
+				      "mock_utmi",
+				      "noc_aggr_north",
+				      "noc_aggr_south";
+
+			interrupts-extended = <&intc GIC_SPI 875 IRQ_TYPE_LEVEL_HIGH>,
+					      <&intc GIC_SPI 369 IRQ_TYPE_LEVEL_HIGH>,
+					      <&pdc 88 IRQ_TYPE_EDGE_BOTH>,
+					      <&pdc 87 IRQ_TYPE_EDGE_BOTH>,
+					      <&pdc 76 IRQ_TYPE_EDGE_BOTH>;
+			interrupt-names = "dwc_usb3",
+					  "pwr_event",
+					  "dp_hs_phy_irq",
+					  "dm_hs_phy_irq",
+					  "ss_phy_irq";
+
+			resets = <&gcc GCC_USB30_SEC_BCR>;
+			power-domains = <&gcc GCC_USB30_SEC_GDSC>;
+
+			iommus = <&apps_smmu 0x1460 0x0>;
+
+			phys = <&usb_1_ss1_hsphy>,
+			       <&usb_1_ss1_qmpphy QMP_USB43DP_USB3_PHY>;
+			phy-names = "usb2-phy",
+				    "usb3-phy";
+
+			snps,dis_u2_susphy_quirk;
+			snps,dis_enblslpm_quirk;
+			snps,dis_u3_susphy_quirk;
+			snps,usb2-lpm-disable;
+
+			status = "disabled";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+
+					usb_1_dwc3_hs: endpoint {
+					};
+				};
+
+				port@1 {
+					reg = <1>;
+
+					usb_1_dwc3_ss: endpoint {
+						remote-endpoint = <&usb_1_ss1_qmpphy_usb_ss_in>;
+					};
+				};
+			};
+		};
+
+		usb1_ss2: usb@a000000 {
+			compatible = "qcom,glymur-dwc3", "qcom,snps-dwc3";
+			reg = <0 0x0a000000 0 0xfc100>;
+
+			clocks = <&gcc GCC_CFG_NOC_USB3_TERT_AXI_CLK>,
+				 <&gcc GCC_USB30_TERT_MASTER_CLK>,
+				 <&gcc GCC_AGGRE_USB3_TERT_AXI_CLK>,
+				 <&gcc GCC_USB30_TERT_SLEEP_CLK>,
+				 <&gcc GCC_USB30_TERT_MOCK_UTMI_CLK>,
+				 <&gcc GCC_CFG_NOC_USB_ANOC_AHB_CLK>,
+				 <&gcc GCC_CFG_NOC_USB_ANOC_SOUTH_AHB_CLK>;
+			clock-names = "cfg_noc",
+				      "core",
+				      "iface",
+				      "sleep",
+				      "mock_utmi",
+				      "noc_aggr_north",
+				      "noc_aggr_south";
+
+			interrupts-extended = <&intc GIC_SPI 871 IRQ_TYPE_LEVEL_HIGH>,
+					      <&intc GIC_SPI 370 IRQ_TYPE_LEVEL_HIGH>,
+					      <&pdc 89 IRQ_TYPE_EDGE_BOTH>,
+					      <&pdc 81 IRQ_TYPE_EDGE_BOTH>,
+					      <&pdc 75 IRQ_TYPE_EDGE_BOTH>;
+			interrupt-names = "dwc_usb3",
+					  "pwr_event",
+					  "dp_hs_phy_irq",
+					  "dm_hs_phy_irq",
+					  "ss_phy_irq";
+
+			resets = <&gcc GCC_USB30_TERT_BCR>;
+			power-domains = <&gcc GCC_USB30_TERT_GDSC>;
+
+			iommus = <&apps_smmu 0x420 0x0>;
+
+			phys = <&usb_1_ss2_hsphy>,
+			       <&usb_1_ss2_qmpphy QMP_USB43DP_USB3_PHY>;
+			phy-names = "usb2-phy",
+				    "usb3-phy";
+
+			snps,dis_u2_susphy_quirk;
+			snps,dis_enblslpm_quirk;
+			snps,dis_u3_susphy_quirk;
+			snps,usb2-lpm-disable;
+
+			status = "disabled";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+
+					usb_2_dwc3_hs: endpoint {
+					};
+				};
+
+				port@1 {
+					reg = <1>;
+
+					usb_2_dwc3_ss: endpoint {
+						remote-endpoint = <&usb_1_ss2_qmpphy_usb_ss_in>;
+					};
+				};
+			};
+		};
+
+		usb_mp: usb@a400000 {
+			compatible = "qcom,glymur-dwc3-mp", "qcom,snps-dwc3";
+			reg = <0 0x0a400000 0 0xfc100>;
+
+			clocks = <&gcc GCC_CFG_NOC_USB3_MP_AXI_CLK>,
+				 <&gcc GCC_USB30_MP_MASTER_CLK>,
+				 <&gcc GCC_AGGRE_USB3_MP_AXI_CLK>,
+				 <&gcc GCC_USB30_MP_SLEEP_CLK>,
+				 <&gcc GCC_USB30_MP_MOCK_UTMI_CLK>,
+				 <&gcc GCC_CFG_NOC_USB_ANOC_AHB_CLK>,
+				 <&gcc GCC_CFG_NOC_USB_ANOC_SOUTH_AHB_CLK>;
+			clock-names = "cfg_noc",
+				      "core",
+				      "iface",
+				      "sleep",
+				      "mock_utmi",
+				      "noc_aggr_north",
+				      "noc_aggr_south";
+
+			interrupts-extended = <&intc GIC_SPI 132 IRQ_TYPE_LEVEL_HIGH>,
+					      <&intc GIC_SPI 345 IRQ_TYPE_LEVEL_HIGH>,
+					      <&intc GIC_SPI 346 IRQ_TYPE_LEVEL_HIGH>,
+					      <&intc GIC_SPI 162 IRQ_TYPE_LEVEL_HIGH>,
+					      <&intc GIC_SPI 163 IRQ_TYPE_LEVEL_HIGH>,
+					      <&pdc 12 IRQ_TYPE_LEVEL_HIGH>,
+					      <&pdc 11 IRQ_TYPE_LEVEL_HIGH>,
+					      <&pdc 14 IRQ_TYPE_LEVEL_HIGH>,
+					      <&pdc 13 IRQ_TYPE_LEVEL_HIGH>,
+					      <&pdc 78 IRQ_TYPE_LEVEL_HIGH>,
+					      <&pdc 77 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "dwc_usb3",
+					  "pwr_event_1",
+					  "pwr_event_2",
+					  "hs_phy_1",
+					  "hs_phy_2",
+					  "dp_hs_phy_1",
+					  "dm_hs_phy_1",
+					  "dp_hs_phy_2",
+					  "dm_hs_phy_2",
+					  "ss_phy_1",
+					  "ss_phy_2";
+
+			resets = <&gcc GCC_USB30_MP_BCR>;
+			power-domains = <&gcc GCC_USB30_MP_GDSC>;
+
+			iommus = <&apps_smmu 0xda0 0x0>;
+
+			phys = <&usb_mp_hsphy0>,
+			       <&usb_mp_qmpphy0>,
+			       <&usb_mp_hsphy1>,
+			       <&usb_mp_qmpphy1>;
+			phy-names = "usb2-0",
+				    "usb3-0",
+				    "usb2-1",
+				    "usb3-1";
+
+			snps,dis_u2_susphy_quirk;
+			snps,dis_enblslpm_quirk;
+			snps,usb3_lpm_capable;
+			snps,dis_u3_susphy_quirk;
+			snps,usb2-lpm-disable;
+
+			dr_mode = "host";
+
+			status = "disabled";
+
+		};
+
 		dispcc: clock-controller@af00000 {
 			compatible = "qcom,glymur-dispcc";
 			reg = <0 0x0af00000 0 0x20000>;

-- 
2.34.1


