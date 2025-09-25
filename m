Return-Path: <linux-kernel+bounces-831828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CCC9B9DA47
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 08:35:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B17A07A7F47
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 06:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD0642F39A0;
	Thu, 25 Sep 2025 06:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JfzGkdcu"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D21682F3C0F
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 06:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758781817; cv=none; b=hyn9/ru1yvXXeRs9VzOuDIHA/WFg3SYk032OfjcC/3W256NoMDhilYgZ9qd9Sr1TguSojVstho5BNb0uiJAI33uJCPS2tbALv9yQDbquWdokkCwMWAkVVDfSYgrq7uDY52PkTMkgvuhKubvN2VQpTb5fvLAoi0eFOhz4kjHLsj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758781817; c=relaxed/simple;
	bh=V3DwzMhHyM+I6pHrP+uB1wED6tjExyI8wGLVQ1sZbgQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=reDV23KeqnZdS6xbrPMDbdHOx0WWcoXoVQRMYmyUt8gqQ7n+NNfyIxMQIGBLA3iOg13XugT9T2oGM6gOa+gtgsiKaqkAKEAFCc3R17+wQEjkVA18JaQM3QHipkWOXzh/nFk7XOO0w4PBX4DKTM43Wn/jYgbmgooIT3qQUV+z/nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JfzGkdcu; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58P0JS0j017434
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 06:30:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	uG7od70k/i9Kw+psrJ8W2o6B74N7yBSqMRRkTzry7hs=; b=JfzGkdcu1dUxPcB9
	CTI19k6lLwbQR1hejA216JnPw2fHiXE2awZi2bdzfMRAaLIkjfbshi6iD1RfKbgq
	nIPhU3GCnE02pLjU3XLptmmkrul5DGKLF1TpXQHf64c8/stIeWXSXFzdoChvieGg
	rPNO0V8xDK/5gppnmFJmRh2yIG9cbnWwgq9bxka2wwIrmrqLDaezzD/dXCJqxS1S
	K7ja1oH/chATp9wN6Io2NP4b2Jq6VQwKpPg+EDti0qt4bMu5MphyJFan5+n+j/SE
	MidsKzqIlk3ooXa6H5H80O7ByqqEhItfGEQdSLl/jVTuP8oQ3as76gS+8rz0D9az
	+7e7Lg==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49bhvk0bua-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 06:30:15 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-7810289cd5eso689260b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:30:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758781814; x=1759386614;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uG7od70k/i9Kw+psrJ8W2o6B74N7yBSqMRRkTzry7hs=;
        b=MnJvqHSO4IUQL+dKZLaTSDBY7Wu3SU0/IXK1mNr/ltuayyP5LxIrAsDaa2/zuYN0gF
         RiAa/8x1eszxmgjFJSVQ9TDeVNGc/Z6DAob7nZh5KogKc/yyA6x9PoRZliLtn7ZNA3L/
         lbjrqVgWnvH2JPSKreSrUEm97fjYkHsQtTtBBVI53Sn1sVVRV0R02hvFvuc2vmcl6bEv
         C1gAbpd4r6UEJeh9f5/KOgmOOa1/KqtF79SOB7bMEnpRzKEonWGhoattaXcqPaPA1YwL
         G7cU679q1tdRBZ4b6IO9TABXaLDO7zH/K8fWVS5zuEszU8BFyXRCNTlakDQKqdORXiHY
         N4mg==
X-Forwarded-Encrypted: i=1; AJvYcCWAoRfwjNSXVOk6HGIOomlNrbro04rMc6e+OTHZABg3khVjz2ougJEG08W6dM2lHv7tLVVXMHp52hRVQWE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFxQWuy/JkYgK1rA4lKxM/Lc4vBporV9rMIWIUVD03y1cziM6d
	qbco0NicROe9c4c6NyMCwBnhLMpSZ9MXwS0BpTL6mexf8Oqq7pijY8RA+Ud4/8ne5MuBdnuVEdZ
	xPKczFBda6pzVMpgNpha0trVkaes4vjuw3NKmu5aTvzKSzNHC87wmNCEYv7qO+lfHdm8=
X-Gm-Gg: ASbGncuwh63CDEwBhFXUI/JlBhfQfYWgf7pn12AoUFKr96YKvRfITBTG2kNRh8eXjbV
	Wy3GEF7ipZJG6MNb1GiQBvCWrZPY1WLweRRS0RSSiZ29AD/UmJigTXanG8alW4eeOUFwS/PKcij
	JO8aCHVdxjTH3lP6Lj6cFmjMFHodW/HONErl4ljaj9gB4CwtsNESm7hMtgw9C7JaGFW4WiJIS5A
	DFpbcczBsx+bV1lzskcWMbrAinxWKuLjfm++Vcm5gctUmuiqEhe+729AuZM82K44DOXEJRryKa/
	Fe5WZUUMoFTUxwRVafbIqog9sWoejBAfjik70VeDzK2jjG7UBOdxFAOAbLNxB9ZrZ2sQZmoDCTe
	D6KdJqbE6iGENcFYQ3Fl/gLVNDSPMRHeS7AE9+hgiKQxDUljZJf2Dc4cM4Mku
X-Received: by 2002:a05:6a00:2e1f:b0:77e:a3ca:4208 with SMTP id d2e1a72fcca58-780fcea307fmr2958935b3a.21.1758781814007;
        Wed, 24 Sep 2025 23:30:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHQPd0TE1eKYuyKpPDehcx5W+QqdsgoaJuQncMo5gRQZDfz0sC+9dqyrWdcCaP3Bv4LudrCZw==
X-Received: by 2002:a05:6a00:2e1f:b0:77e:a3ca:4208 with SMTP id d2e1a72fcca58-780fcea307fmr2958884b3a.21.1758781813455;
        Wed, 24 Sep 2025 23:30:13 -0700 (PDT)
Received: from hu-pankpati-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7810239136dsm952962b3a.5.2025.09.24.23.30.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 23:30:13 -0700 (PDT)
From: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
Date: Thu, 25 Sep 2025 11:58:30 +0530
Subject: [PATCH v2 24/24] arm64: dts: qcom: glymur: Add remoteprocs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250925-v3_glymur_introduction-v2-24-8e1533a58d2d@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: 9MJEXj_8xMMk22Lda36HkbJp76WgEdkn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIzMDAxMSBTYWx0ZWRfX54436RhB5PSi
 Vy2v6mYk2p10I9gaPyXmI4tPa7cbbJy3c0q2sZZdI3jvoYzKw7TXpQIcqqOSOy1lgjbRSK0O8TA
 QGVwRYQRrRpsNCCdj+rG6dz2RNfFn6NVqJaynyljNZ34BDzQaWJ1UZ2twvdmHEr6GYhi6pXvg1+
 20D3Rz/N0RlfNdWHhl1qszxaJeIQM2O0QHzEq86z6T+6yDfcABQSAmgw1xmjGPOHZQI5/aYAr9e
 rBf6SFdKaX6VhhPgMMlCDR/uCKTHKDKrfGTcngxjVZoFIfU5xAz/zVcsi4pBDnj84oL0CUYgNB1
 mrcZoX+aqrDZA+d8Tjyj5NuMBRlJV7SLduFvYX4oYk7Ucj3fawZrwI3jgjX25BpfYOYl86cZllS
 6Y//RJzQ
X-Proofpoint-GUID: 9MJEXj_8xMMk22Lda36HkbJp76WgEdkn
X-Authority-Analysis: v=2.4 cv=Csq/cm4D c=1 sm=1 tr=0 ts=68d4e177 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=kLNDb2lwuo9xn5iZXl0A:9
 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 adultscore=0 impostorscore=0 phishscore=0
 clxscore=1015 spamscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509230011

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


