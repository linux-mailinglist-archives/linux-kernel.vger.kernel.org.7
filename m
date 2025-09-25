Return-Path: <linux-kernel+bounces-831855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E3E05B9DB6A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 08:43:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0033E1767DB
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 06:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC83D2FE574;
	Thu, 25 Sep 2025 06:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Yap+gqao"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13DCB2FD7D6
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 06:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758782082; cv=none; b=QB0MIhmq542EtLC7m/YlxYHKWi2NsMSqLIs/zczCzXoKiOCtxabVLeZEZh3AwO6mXaWinbslfkrKi+bOj0mvTTYt7NJjakiE/Nj91VMjOIUj7OcGTuyXBXxDI7sM6q/oCXlbLc0qBPmX3lkTKy0Ye/wbKip5jGtynxc0nY4vmBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758782082; c=relaxed/simple;
	bh=V3DwzMhHyM+I6pHrP+uB1wED6tjExyI8wGLVQ1sZbgQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MR2UA+5lH0g4d5avZaAjFm2QFw2xfACIaV5RZIB6vpkc+2Aa8ZeuJJEbzEl6m99q2E94eXR843sO6NGKuzmbz0pB0P8RBqamxGu7K3fTtYVYIBwG/ssdv8TicJkoxxIewOOUQiOWJXJagzeZpQH/e8En5/hq5o5ydkQAkPV0D1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Yap+gqao; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58ONq6SU021486
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 06:34:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	uG7od70k/i9Kw+psrJ8W2o6B74N7yBSqMRRkTzry7hs=; b=Yap+gqaoaxB307WT
	ZReni9pIutsXrCI/U9v4bxsTt6/i0SxDpWi7EktjBXP25PSJKj/utwyvV1xtxOdh
	R0CcJqQxiY9rQoFCX5xzmlzmMAJqilyriSAk9bB31pR5rIusHcsmE5vncrg6c9Hl
	8MgxEV7KiGLpKJ2yC97FaGrZ3Bbd2Asac8i9bk9cMc7NYBWadnwSpvFO2xLteGDg
	d3EMf4GZMzXcQMyqVfqL7Ua6hOE/UOm3XRe93WRdnWn243BI5/OB3zGtAQGfGEqF
	+8x6fem4sdwQu+yBXJRksDFIhQwdqjGvNJorbYO3e9lZbSh+C8L+3bsyiz8GsUk2
	uvTP3A==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49budaekmj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 06:34:39 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-25d21fddb85so11149665ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:34:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758782078; x=1759386878;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uG7od70k/i9Kw+psrJ8W2o6B74N7yBSqMRRkTzry7hs=;
        b=qUAFjwHCk/C4jLxkWf8/lW+Bn2wbUnvluBS817CupkA5zNiRcxm3KYaO2e9krUw5ya
         6pumWWU8YYW8+/yUbamxsEaKcbPxDdnn4wBM2TSGEUyHlFE5ARk1mGMHIkqwvFqWoZ9r
         2E2PgFvoq1PYIlwTwMdleJPAupKiuerHceGEU18OathnPhCnNcTFd0cdqYs+gYlo7J6L
         FFufd3TY6upOxpa0HMZcpBYgKJkUplYrRvOdJTJDlTKRdwRYCmTTlBeCKdFhrrH8SFeY
         2T3QsCv55bmXiWan8MORgJ3du5PV4al8CFl8C2elqb8E7LNYesEsZA45S7iOPyQKFIco
         Xm2w==
X-Forwarded-Encrypted: i=1; AJvYcCUFcyBR9nJYMJ/MtVUsiAoe7CFfYjFL256U9J5bNOiO7tV5FfwIFSV74qMSlS8O1GH9LWpANLk5euZW3HA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPm3BidroLYPsf5NO6bhpwpyGeCbzWyUM8xeHRKgXp3RtKqH24
	uO6T/wARFmCxPCEcWKhG2x5fZr4x7++CrjxfRCp+SNy9GVKugiwKFELfQFldbfE+PkBbEt85+8L
	0fH36Rvj2n9sAjtA/cpj40tsX32L9YjkCmoVvhYpKdUjsFxSbHAtQr7BeseljiEhZ5cs=
X-Gm-Gg: ASbGncvVA8hBGGo3IpjNoNhSSYsg2x0mjyHyGhbq2BoFXNwCQ2FxvrR6LjOn1I16tIF
	Q750wx/J0fNdOvEboGg9IHrTxmjxVsrJ2G6EQlCB6Z91EDJiScQcvOgTj+NesaBG1EuhaRDkE94
	1ol+3ua1md+h1c+euaQBajhVrwDe5oYVjK7ZwnYmJoxpbALgymQRo+Aq5n6LKBF1GWp+Oj20NUg
	ReEQbQjjN5U5phBo3UbewsK/fW08GtWPpGpPaAJwP2dvp2sxbqeV18rqncVRFPd7Qs0ITAT/mJD
	sHzN+cMaeVoLAWe4hk5UOQObs31epUpBlBtDzHP0rASyLNGwO8k2L9KAZ3yCJ98cLXe5Jn/j4mF
	L2mt4015FPBAWWrh5kG/JrU5GFmvc7+vZVIpsJOTKLxsUhxL4529hTuaZHhhz
X-Received: by 2002:a17:903:2348:b0:275:3ff9:ab88 with SMTP id d9443c01a7336-27ed4a4e174mr28604505ad.49.1758782077548;
        Wed, 24 Sep 2025 23:34:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGMClKDtQH+qECejIvMWPGGkEdMWo5ok4SO8IcD9cNru1IbuOp/phxArSeUpSw8LHoytbJ5Gg==
X-Received: by 2002:a17:903:2348:b0:275:3ff9:ab88 with SMTP id d9443c01a7336-27ed4a4e174mr28604085ad.49.1758782076937;
        Wed, 24 Sep 2025 23:34:36 -0700 (PDT)
Received: from hu-pankpati-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed671732asm13793515ad.49.2025.09.24.23.34.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 23:34:36 -0700 (PDT)
From: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
Date: Thu, 25 Sep 2025 12:02:32 +0530
Subject: [PATCH 24/24] arm64: dts: qcom: glymur: Add remoteprocs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250925-v3_glymur_introduction-v1-24-24b601bbecc0@oss.qualcomm.com>
References: <20250925-v3_glymur_introduction-v1-0-24b601bbecc0@oss.qualcomm.com>
In-Reply-To: <20250925-v3_glymur_introduction-v1-0-24b601bbecc0@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Pankaj Patil <pankaj.patil@oss.qualcomm.com>,
        Sibi Sankar <sibi.sankar@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: zLy0rhMzKIjaAuWnkNp0NCLu62vfQfHj
X-Proofpoint-ORIG-GUID: zLy0rhMzKIjaAuWnkNp0NCLu62vfQfHj
X-Authority-Analysis: v=2.4 cv=Yaq95xRf c=1 sm=1 tr=0 ts=68d4e27f cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=kLNDb2lwuo9xn5iZXl0A:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIzMDExMyBTYWx0ZWRfX2pUiE7Pkby2v
 ZPJP1w/WUSpBHHFqyaqONugKfFUxdJ8Mgjg6dJPTFVXJlMRg2ZqVdLC0jnVxxzzMp5bm/GneJUs
 aXGgFXk2HivpjMb4e1qNuyRRHScjyf8kvW/i/ECJ9UMeOzEBytdLGyGfXYb7NclCXa++wpe8Etk
 W+roJFf1mtWExUDWlDcXQiddBwmlqkv+in+Ve3W3mIQEhnZSc3Ts0mj7p5G4pz+Pzqko6Pit1tm
 ITl6hw3sO5OOH/EIWrdI7QvfxdzuwcD2iV2K6Wxm6pD55L1RdaDIf480uCCSxzFgcVTuJwel8Fc
 HEk3b40MqVLpLKwO0gFXc7igB8pm1N5D1Aen3+lRRt0BNFet3U62EAHQPuWmCoUTnZxPGfGVgaT
 B8yEkiRY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 suspectscore=0 priorityscore=1501 phishscore=0
 adultscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509230113

From: Sibi Sankar <sibi.sankar@oss.qualcomm.com>

Add remoteproc PAS loader for ADSP, CDSP and SoCCP with its SMP2P nodes.

Signed-off-by: Sibi Sankar <sibi.sankar@oss.qualcomm.com>
Signed-off-by: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/glymur-crd.dts |  21 +++
 arch/arm64/boot/dts/qcom/glymur.dtsi    | 234 ++++++++++++++++++++++++++++++++
 2 files changed, 255 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/glymur-crd.dts b/arch/arm64/boot/dts/qcom/glymur-crd.dts
index 100519aa5a7cd905285d3aa41ebe5f63ae00aeef..17c8f1a4f4061303982a210b7690783c96ef80b2 100644
--- a/arch/arm64/boot/dts/qcom/glymur-crd.dts
+++ b/arch/arm64/boot/dts/qcom/glymur-crd.dts
@@ -548,6 +548,27 @@ nvme_reg_en: nvme-reg-en-state {
 	};
 };
 
+&remoteproc_adsp {
+	firmware-name = "qcom/glymur/adsp.mbn",
+			"qcom/glymur/adsp_dtb.mbn";
+
+	status = "okay";
+};
+
+&remoteproc_cdsp {
+	firmware-name = "qcom/glymur/cdsp.mbn",
+			"qcom/glymur/cdsp_dtb.mbn";
+
+	status = "okay";
+};
+
+&remoteproc_soccp {
+	firmware-name = "qcom/glymur/soccp.mbn",
+			"qcom/glymur/soccp_dtb.mbn";
+
+	status = "okay";
+};
+
 &tlmm {
 	pcie5_default: pcie5-default-state {
 		clkreq-n-pins {
diff --git a/arch/arm64/boot/dts/qcom/glymur.dtsi b/arch/arm64/boot/dts/qcom/glymur.dtsi
index c48d3a70820e551822c5322761528159da127ca6..a131cd6c3d9e7f14ed1c4aef4b68e1860cc3bca5 100644
--- a/arch/arm64/boot/dts/qcom/glymur.dtsi
+++ b/arch/arm64/boot/dts/qcom/glymur.dtsi
@@ -782,6 +782,82 @@ smem_mem: smem-region@ffe00000 {
 
 	};
 
+	smp2p-adsp {
+		compatible = "qcom,smp2p";
+
+		interrupts-extended = <&ipcc GLYMUR_MPROC_LPASS
+					     IPCC_MPROC_SIGNAL_SMP2P
+					     IRQ_TYPE_EDGE_RISING>;
+
+		mboxes = <&ipcc GLYMUR_MPROC_LPASS IPCC_MPROC_SIGNAL_SMP2P>;
+
+		qcom,smem = <443>, <429>;
+		qcom,local-pid = <0>;
+		qcom,remote-pid = <2>;
+
+		smp2p_adsp_out: master-kernel {
+			qcom,entry-name = "master-kernel";
+			#qcom,smem-state-cells = <1>;
+		};
+
+		smp2p_adsp_in: slave-kernel {
+			qcom,entry-name = "slave-kernel";
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+	};
+
+	smp2p-cdsp {
+		compatible = "qcom,smp2p";
+
+		interrupts-extended = <&ipcc GLYMUR_MPROC_CDSP
+					     IPCC_MPROC_SIGNAL_SMP2P
+					     IRQ_TYPE_EDGE_RISING>;
+
+		mboxes = <&ipcc GLYMUR_MPROC_CDSP IPCC_MPROC_SIGNAL_SMP2P>;
+
+		qcom,smem = <94>, <432>;
+		qcom,local-pid = <0>;
+		qcom,remote-pid = <5>;
+
+		smp2p_cdsp_out: master-kernel {
+			qcom,entry-name = "master-kernel";
+			#qcom,smem-state-cells = <1>;
+		};
+
+		smp2p_cdsp_in: slave-kernel {
+			qcom,entry-name = "slave-kernel";
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+	};
+
+	smp2p-soccp {
+		compatible = "qcom,smp2p";
+
+		interrupts-extended = <&ipcc GLYMUR_MPROC_SOCCP
+					     IPCC_MPROC_SIGNAL_SMP2P
+					     IRQ_TYPE_EDGE_RISING>;
+
+		mboxes = <&ipcc GLYMUR_MPROC_SOCCP
+				IPCC_MPROC_SIGNAL_SMP2P>;
+
+		qcom,smem = <617>, <616>;
+		qcom,local-pid = <0>;
+		qcom,remote-pid = <19>;
+
+		soccp_smp2p_out: master-kernel {
+			qcom,entry-name = "master-kernel";
+			#qcom,smem-state-cells = <1>;
+		};
+
+		soccp_smp2p_in: slave-kernel {
+			qcom,entry-name = "slave-kernel";
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+	};
+
 	clk_virt: interconnect-0 {
 		compatible = "qcom,glymur-clk-virt";
 		#interconnect-cells = <2>;
@@ -2417,6 +2493,59 @@ &config_noc SLAVE_QUP_0 QCOM_ICC_TAG_ALWAYS>,
 			};
 		};
 
+		remoteproc_soccp: remoteproc-soccp@d00000 {
+			compatible = "qcom,glymur-soccp-pas", "qcom,kaanapali-soccp-pas";
+			reg = <0x0 0x00d00000 0x0 0x200000>;
+
+			interrupts-extended = <&intc GIC_SPI 167 IRQ_TYPE_EDGE_RISING>,
+					      <&soccp_smp2p_in 0 IRQ_TYPE_EDGE_RISING>,
+					      <&soccp_smp2p_in 1 IRQ_TYPE_EDGE_RISING>,
+					      <&soccp_smp2p_in 2 IRQ_TYPE_EDGE_RISING>,
+					      <&soccp_smp2p_in 3 IRQ_TYPE_EDGE_RISING>,
+					      <&soccp_smp2p_in 9 IRQ_TYPE_EDGE_RISING>,
+					      <&soccp_smp2p_in 10 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "wdog",
+					  "fatal",
+					  "ready",
+					  "handover",
+					  "stop-ack",
+					  "pong",
+					  "wake-ack";
+
+			clocks = <&rpmhcc RPMH_CXO_CLK>;
+			clock-names = "xo";
+
+			power-domains = <&rpmhpd RPMHPD_CX>,
+					<&rpmhpd RPMHPD_MX>;
+			power-domain-names = "cx",
+					     "mx";
+
+			memory-region = <&soccp_mem>,
+					<&soccpdtb_mem>;
+
+			qcom,smem-states = <&soccp_smp2p_out 0>,
+					   <&soccp_smp2p_out 10>,
+					   <&soccp_smp2p_out 9>,
+					   <&soccp_smp2p_out 8>;
+			qcom,smem-state-names = "stop",
+						"wakeup",
+						"sleep",
+						"ping";
+
+			status = "disabled";
+
+			glink-edge {
+				interrupts-extended = <&ipcc GLYMUR_MPROC_SOCCP
+							     IPCC_MPROC_SIGNAL_GLINK_QMP
+							     IRQ_TYPE_EDGE_RISING>;
+				mboxes = <&ipcc GLYMUR_MPROC_SOCCP
+						IPCC_MPROC_SIGNAL_GLINK_QMP>;
+				qcom,remote-pid = <19>;
+				label = "soccp";
+
+			};
+		};
+
 		usb_mp_hsphy0: phy@fa1000 {
 			compatible = "qcom,glymur-m31-eusb2-phy",
 				     "qcom,sm8750-m31-eusb2-phy";
@@ -2944,6 +3073,57 @@ pcie5_phy: phy@1b50000 {
 			status = "disabled";
 		};
 
+		remoteproc_adsp: remoteproc@6800000 {
+			compatible = "qcom,glymur-adsp-pas", "qcom,sm8550-adsp-pas";
+			reg = <0x0 0x06800000 0x0 0x10000>;
+
+			iommus = <&apps_smmu 0x1000 0x0>;
+
+			interrupts-extended = <&pdc 6 IRQ_TYPE_EDGE_RISING>,
+					      <&smp2p_adsp_in 0 IRQ_TYPE_EDGE_RISING>,
+					      <&smp2p_adsp_in 1 IRQ_TYPE_EDGE_RISING>,
+					      <&smp2p_adsp_in 2 IRQ_TYPE_EDGE_RISING>,
+					      <&smp2p_adsp_in 3 IRQ_TYPE_EDGE_RISING>,
+					      <&smp2p_adsp_in 7 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "wdog",
+					  "fatal",
+					  "ready",
+					  "handover",
+					  "stop-ack",
+					  "shutdown-ack";
+
+			clocks = <&rpmhcc RPMH_CXO_CLK>;
+			clock-names = "xo";
+
+			power-domains = <&rpmhpd RPMHPD_LCX>,
+					<&rpmhpd RPMHPD_LMX>;
+			power-domain-names = "lcx",
+					     "lmx";
+
+			interconnects = <&lpass_lpicx_noc MASTER_LPASS_PROC QCOM_ICC_TAG_ALWAYS
+					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>;
+
+			memory-region = <&adspslpi_mem>, <&q6_adsp_dtb_mem>;
+
+			qcom,qmp = <&aoss_qmp>;
+
+			qcom,smem-states = <&smp2p_adsp_out 0>;
+			qcom,smem-state-names = "stop";
+
+			status = "disabled";
+
+			glink-edge {
+				interrupts-extended = <&ipcc GLYMUR_MPROC_LPASS
+							     IPCC_MPROC_SIGNAL_GLINK_QMP
+							     IRQ_TYPE_EDGE_RISING>;
+				mboxes = <&ipcc GLYMUR_MPROC_LPASS
+						IPCC_MPROC_SIGNAL_GLINK_QMP>;
+
+				label = "lpass";
+				qcom,remote-pid = <2>;
+			};
+		};
+
 		tcsr_mutex: hwlock@1f40000 {
 			compatible = "qcom,tcsr-mutex";
 			reg = <0x0 0x01f40000 0x0 0x20000>;
@@ -5311,6 +5491,60 @@ nsp_noc: interconnect@320c0000 {
 			#interconnect-cells = <2>;
 		};
 
+		remoteproc_cdsp: remoteproc@32300000 {
+			compatible = "qcom,glymur-cdsp-pas", "qcom,sm8550-cdsp-pas";
+			reg = <0x0 0x32300000 0x0 0x10000>;
+
+			iommus = <&apps_smmu 0x2000 0x400>;
+
+			interrupts-extended = <&intc GIC_SPI 578 IRQ_TYPE_EDGE_RISING>,
+					      <&smp2p_cdsp_in 0 IRQ_TYPE_EDGE_RISING>,
+					      <&smp2p_cdsp_in 1 IRQ_TYPE_EDGE_RISING>,
+					      <&smp2p_cdsp_in 2 IRQ_TYPE_EDGE_RISING>,
+					      <&smp2p_cdsp_in 3 IRQ_TYPE_EDGE_RISING>,
+					      <&smp2p_cdsp_in 7 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "wdog",
+					  "fatal",
+					  "ready",
+					  "handover",
+					  "stop-ack",
+					  "shutdown-ack";
+
+			clocks = <&rpmhcc RPMH_CXO_CLK>;
+			clock-names = "xo";
+
+			power-domains = <&rpmhpd RPMHPD_CX>,
+					<&rpmhpd RPMHPD_MXC>,
+					<&rpmhpd RPMHPD_NSP>;
+			power-domain-names = "cx",
+					     "mxc",
+					     "nsp";
+
+			interconnects = <&nsp_noc MASTER_CDSP_PROC QCOM_ICC_TAG_ALWAYS
+					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>;
+
+			memory-region = <&cdsp_mem>,
+					<&q6_cdsp_dtb_mem>;
+
+			qcom,qmp = <&aoss_qmp>;
+
+			qcom,smem-states = <&smp2p_cdsp_out 0>;
+			qcom,smem-state-names = "stop";
+
+			status = "disabled";
+
+			glink-edge {
+				interrupts-extended = <&ipcc GLYMUR_MPROC_CDSP
+							     IPCC_MPROC_SIGNAL_GLINK_QMP
+							     IRQ_TYPE_EDGE_RISING>;
+				mboxes = <&ipcc GLYMUR_MPROC_CDSP
+						IPCC_MPROC_SIGNAL_GLINK_QMP>;
+
+				label = "cdsp";
+				qcom,remote-pid = <5>;
+			};
+		};
+
 		sram: sram@81e08000 {
 			compatible = "mmio-sram";
 			reg = <0x0 0x81e08600 0x0 0x300>;

-- 
2.34.1


