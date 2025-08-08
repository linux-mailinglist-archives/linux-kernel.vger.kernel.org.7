Return-Path: <linux-kernel+bounces-760345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1C8FB1E9EA
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 16:04:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E67ADAA0DBC
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 14:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDA0E27FB06;
	Fri,  8 Aug 2025 14:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ohHUP9ZB"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC0127F4CE
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 14:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754661848; cv=none; b=orh8XXnnytZKLy48Awa1scGlfv/xqg27pO0Bo3WJ5Zwt/JHwdIX1VaqqbnYvqcGo7+kFq/Te9fXz4LEu6NvCbUFKRfnXQFW4rhqTqqnJ/6cegeYDjgcdhzxT1fEg6VfgS0qttfP7HozhPQt9b1bc7Zhr3BPMuhXlVdQeHc5h7FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754661848; c=relaxed/simple;
	bh=ZcE/MeEUMeGZH7b8eex156Qe1QyWbt01WWmziNtbiYo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=CUIqB+rC+BxeOQi6jSVBas/6tjWKy02ZMX5TsyrKGDUevz/Je7XDExsQcvL7Y1ocsQsEZjKk1makczPbeFq7Sw2G0eDVh4yRWhrZ5N2CsnNPesDOra7LJtrkNUKaVS53mr78PcqjwaRGee+6efivOKQMEe42GWN9vWxmcs4BNTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ohHUP9ZB; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 578DhDtK022425
	for <linux-kernel@vger.kernel.org>; Fri, 8 Aug 2025 14:04:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:date:from:in-reply-to:message-id:references:subject:to; s=
	qcppdkim1; bh=NyOKCYdO8dRhX3Md2A7GJTuQQJa5hPZwpwoviRAY2wY=; b=oh
	HUP9ZBpWl90yj/7E65pT15eHepWZjgloKgxZQFrfaD3o7b9iBO9llSt1XWzoAaF7
	R7B/c0oEHE5mab3s8LB0eXQyK3DUA8VqIhv/C0cmHpt9JRY0A3/k1hEAwhPV+OxC
	y9c3Ptb4EfYnpzxLXwyCKnhk04QiPkiyy8LZPadIKvW5XluVU+mC00srULJIm47f
	WYOOMbFmMRVvs4HSIJFcXwsvWl8+xh0J0Cidu6Zd2Kb03P0we65aDRxN8TEbtszq
	6QBBhi/4liR2BGM4Zujj23q971Sd7SZJhHKpD0octitPOs59iEXSJ9JnjnaQS2GK
	IifOHmm3x4wWhCIiAuAw==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48cs5nchg7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 08 Aug 2025 14:04:06 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-76bca6c73f3so4386837b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Aug 2025 07:04:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754661844; x=1755266644;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NyOKCYdO8dRhX3Md2A7GJTuQQJa5hPZwpwoviRAY2wY=;
        b=MezwtLG5Ga3We66CqklrCSWq35CRBxRQ4TGXXcfGCcNGyKiFljDvxgCZlBpEeXEj6X
         cSbNw/LIrLP2tNN16iVZult182J6DOjYfgUmtqcx/t+9Jmk5RzRKPFvm6FPVIziWCGpN
         0HpWG+8fcEVMkdyW/AnR7ndm1FenEdNitr0s+AwiaI5I3OLQg/Sv3vrIS74TBVwnxeIn
         yPNbcd7Yx3sz5uYiwYPaae5scR861DAYdqH6MJdw3PWInyhcjEo5M0MEZtSrGfMHm2Jy
         JB3peEkiQZAz/NoV1JTtQ06Fu5Tpqzsp2h9TTuRYcn8wR6Ob7gTzhj/OrPXXhClt+HSw
         w6jQ==
X-Forwarded-Encrypted: i=1; AJvYcCVyYNVdzyfpY1QnrKqLEjpXY+6fZRvLvfl3mmA4srpDp1sVVB16zkVSUYmFGov1MjkIR+4duJodK83y78E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzC5hb+nxELcAQwy/L+Ul2iZ1OTK3ETZK61TF+Lu4hQYiGJKpCN
	iRX//2bzQ7KjywbWDqhj5m3jn3EVaatM/SU0ejzSUTfj4vzMy7QaQaHRVxxwgrzpnlDSkjWnzud
	8t4JHZuTUUXu6MfKHPZKzwyqy2KcOJ6N/YMWi/nbre2A9EXq0P1Eb8wySbXzaYGLlDB0=
X-Gm-Gg: ASbGncuIavNYb6KV5VU0JWGlPhs3QIYK3OhmKJWo24CR8Vt6AZIym9gKugYSzspdd+r
	VMrLt3JT+q7oFN1le7idDaDCfPRBQTLO20qWnUWhZ+s3mOaeNKWR6X1AYfJKQkR5yUMcxT0ItjM
	1DtRpwNwM+G93N0qOUH1zN8aCY/ag1rzR5gr7D2l/uZCC200+WoNnbXBls96tvlpmoffHjQr2U4
	7Ko2Juxq4TsdtpKtwXo6RduIdJyMgK9R6PAx5sT05B1DGM1lOADWw2N1DSX9XmgTPCzxdO9LDtd
	yEdsApOtFXvdEtfur6J8Kki0Iu034ROHUXrUypQtpuvhCF27ZzJxOK9/BIakjNPjC1vh1woLHg=
	=
X-Received: by 2002:a05:6a00:1409:b0:76b:f7af:c47d with SMTP id d2e1a72fcca58-76c460aa949mr4709696b3a.4.1754661844270;
        Fri, 08 Aug 2025 07:04:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEYzNEZoLYuCQsfE6sjScDxUN0v6Z/1i5E9FkZw7qvQySEK/E4ALZ6kvXwvvo8//QKF944E+Q==
X-Received: by 2002:a05:6a00:1409:b0:76b:f7af:c47d with SMTP id d2e1a72fcca58-76c460aa949mr4709633b3a.4.1754661843723;
        Fri, 08 Aug 2025 07:04:03 -0700 (PDT)
Received: from hu-okukatla-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76c2078afd8sm8595621b3a.117.2025.08.08.07.03.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 07:04:03 -0700 (PDT)
From: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>,
        Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mike Tipton <mike.tipton@oss.qualcomm.com>
Subject: [PATCH 3/3] arm64: dts: qcom: sa8775p: Add clocks for QoS configuration
Date: Fri,  8 Aug 2025 19:33:00 +0530
Message-Id: <20250808140300.14784-4-odelu.kukatla@oss.qualcomm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250808140300.14784-1-odelu.kukatla@oss.qualcomm.com>
References: <20250808140300.14784-1-odelu.kukatla@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=Q+XS452a c=1 sm=1 tr=0 ts=689603d6 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=BfUXBPTVPglUz1mEt9YA:9
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-GUID: P9ElSucQJ9E2STIy1BwCfM6ClUJiN1uO
X-Proofpoint-ORIG-GUID: P9ElSucQJ9E2STIy1BwCfM6ClUJiN1uO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA3MDA2OSBTYWx0ZWRfXwwc2Vo3RfoFL
 rc0X5VeEaps9NaedAMzDnIhia3GywZvuX51G0THH/glgg/tjgtMOTa0xvNAti6taI37l2imijO+
 jFh+njQolOJxI8QvpUhkCc5jBj9kCfjqAyRnUwbXMZSakR8zxVEY4mqcbNcIrYXhy5TeVZP2+S9
 F5CeI3ERTa3lVaugOtX3p2AqVVXC6Zk0sKD0vJiuxSb+phbgv+TSFuVSv79QOnVmeotO2ty4jUx
 uT+cg8wtOg6glwUMhx9mtGO6I/5JAlA11iacZyunm3jpreRwiekgqGjTVrUzODeqGfupqtMbWOl
 PQf9JWPaBZfFzfMoDeIjf0obWfpWh1zdZG8TpsIGYOGd6qOXw/e87Qn0IaucMrp4abTmhXcBls/
 bjJ2GSrN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-08_04,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0
 impostorscore=0 phishscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508070069
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Add register addresses and clocks which need to be enabled for
configuring QoS on sa8775p SoC.

Signed-off-by: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sa8775p.dtsi | 163 ++++++++++++++------------
 1 file changed, 91 insertions(+), 72 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sa8775p.dtsi b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
index 9997a29901f5..a24c1ce4384f 100644
--- a/arch/arm64/boot/dts/qcom/sa8775p.dtsi
+++ b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
@@ -518,90 +518,18 @@
 		};
 	};
 
-	aggre1_noc: interconnect-aggre1-noc {
-		compatible = "qcom,sa8775p-aggre1-noc";
-		#interconnect-cells = <2>;
-		qcom,bcm-voters = <&apps_bcm_voter>;
-	};
-
-	aggre2_noc: interconnect-aggre2-noc {
-		compatible = "qcom,sa8775p-aggre2-noc";
-		#interconnect-cells = <2>;
-		qcom,bcm-voters = <&apps_bcm_voter>;
-	};
-
 	clk_virt: interconnect-clk-virt {
 		compatible = "qcom,sa8775p-clk-virt";
 		#interconnect-cells = <2>;
 		qcom,bcm-voters = <&apps_bcm_voter>;
 	};
 
-	config_noc: interconnect-config-noc {
-		compatible = "qcom,sa8775p-config-noc";
-		#interconnect-cells = <2>;
-		qcom,bcm-voters = <&apps_bcm_voter>;
-	};
-
-	dc_noc: interconnect-dc-noc {
-		compatible = "qcom,sa8775p-dc-noc";
-		#interconnect-cells = <2>;
-		qcom,bcm-voters = <&apps_bcm_voter>;
-	};
-
-	gem_noc: interconnect-gem-noc {
-		compatible = "qcom,sa8775p-gem-noc";
-		#interconnect-cells = <2>;
-		qcom,bcm-voters = <&apps_bcm_voter>;
-	};
-
-	gpdsp_anoc: interconnect-gpdsp-anoc {
-		compatible = "qcom,sa8775p-gpdsp-anoc";
-		#interconnect-cells = <2>;
-		qcom,bcm-voters = <&apps_bcm_voter>;
-	};
-
-	lpass_ag_noc: interconnect-lpass-ag-noc {
-		compatible = "qcom,sa8775p-lpass-ag-noc";
-		#interconnect-cells = <2>;
-		qcom,bcm-voters = <&apps_bcm_voter>;
-	};
-
 	mc_virt: interconnect-mc-virt {
 		compatible = "qcom,sa8775p-mc-virt";
 		#interconnect-cells = <2>;
 		qcom,bcm-voters = <&apps_bcm_voter>;
 	};
 
-	mmss_noc: interconnect-mmss-noc {
-		compatible = "qcom,sa8775p-mmss-noc";
-		#interconnect-cells = <2>;
-		qcom,bcm-voters = <&apps_bcm_voter>;
-	};
-
-	nspa_noc: interconnect-nspa-noc {
-		compatible = "qcom,sa8775p-nspa-noc";
-		#interconnect-cells = <2>;
-		qcom,bcm-voters = <&apps_bcm_voter>;
-	};
-
-	nspb_noc: interconnect-nspb-noc {
-		compatible = "qcom,sa8775p-nspb-noc";
-		#interconnect-cells = <2>;
-		qcom,bcm-voters = <&apps_bcm_voter>;
-	};
-
-	pcie_anoc: interconnect-pcie-anoc {
-		compatible = "qcom,sa8775p-pcie-anoc";
-		#interconnect-cells = <2>;
-		qcom,bcm-voters = <&apps_bcm_voter>;
-	};
-
-	system_noc: interconnect-system-noc {
-		compatible = "qcom,sa8775p-system-noc";
-		#interconnect-cells = <2>;
-		qcom,bcm-voters = <&apps_bcm_voter>;
-	};
-
 	/* Will be updated by the bootloader. */
 	memory@80000000 {
 		device_type = "memory";
@@ -2675,6 +2603,62 @@
 			reg = <0 0x010d2000 0 0x1000>;
 		};
 
+		config_noc: interconnect@14c0000 {
+			compatible = "qcom,sa8775p-config-noc";
+			reg = <0x0 0x014c0000 0x0 0x13080>;
+			#interconnect-cells = <2>;
+			qcom,bcm-voters = <&apps_bcm_voter>;
+		};
+
+		system_noc: interconnect@01680000 {
+			compatible = "qcom,sa8775p-system-noc";
+			reg = <0x0 0x01680000 0x0 0x15080>;
+			#interconnect-cells = <2>;
+			qcom,bcm-voters = <&apps_bcm_voter>;
+		};
+
+		aggre1_noc: interconnect@16c0000 {
+			compatible = "qcom,sa8775p-aggre1-noc";
+			reg = <0x0 0x016c0000 0x0 0x18080>;
+			#interconnect-cells = <2>;
+			qcom,bcm-voters = <&apps_bcm_voter>;
+			clocks = <&gcc GCC_AGGRE_UFS_PHY_AXI_CLK>,
+				 <&gcc GCC_AGGRE_NOC_QUPV3_AXI_CLK>,
+				 <&gcc GCC_AGGRE_USB2_PRIM_AXI_CLK>,
+				 <&gcc GCC_AGGRE_USB3_PRIM_AXI_CLK>,
+				 <&gcc GCC_AGGRE_USB3_SEC_AXI_CLK>;
+		};
+
+		aggre2_noc: interconnect@1700000 {
+			compatible = "qcom,sa8775p-aggre2-noc";
+			reg = <0x0 0x01700000 0x0 0x1b080>;
+			#interconnect-cells = <2>;
+			qcom,bcm-voters = <&apps_bcm_voter>;
+			clocks = <&gcc GCC_AGGRE_UFS_CARD_AXI_CLK>,
+				 <&rpmhcc RPMH_IPA_CLK>;
+		};
+
+		pcie_anoc: interconnect@1760000 {
+			compatible = "qcom,sa8775p-pcie-anoc";
+			reg = <0x0 0x01760000 0x0 0xc080>;
+			#interconnect-cells = <2>;
+			qcom,bcm-voters = <&apps_bcm_voter>;
+		};
+
+		gpdsp_anoc: interconnect@1780000 {
+			compatible = "qcom,sa8775p-gpdsp-anoc";
+			reg = <0x0 0x01780000 0x0 0xe080>;
+			#interconnect-cells = <2>;
+			qcom,bcm-voters = <&apps_bcm_voter>;
+		};
+
+		mmss_noc: interconnect@17a0000 {
+			compatible = "qcom,sa8775p-mmss-noc";
+			reg = <0x0 0x017a0000 0x0 0x40000>;
+			#interconnect-cells = <2>;
+			qcom,bcm-voters = <&apps_bcm_voter>;
+		};
+
 		ufs_mem_hc: ufshc@1d84000 {
 			compatible = "qcom,sa8775p-ufshc", "qcom,ufshc", "jedec,ufs-2.0";
 			reg = <0x0 0x01d84000 0x0 0x3000>;
@@ -2784,6 +2768,13 @@
 			};
 		};
 
+		lpass_ag_noc: interconnect@3c40000 {
+			compatible = "qcom,sa8775p-lpass-ag-noc";
+			reg = <0x0 0x03c40000 0x0 0x17200>;
+			#interconnect-cells = <2>;
+			qcom,bcm-voters = <&apps_bcm_voter>;
+		};
+
 		stm: stm@4002000 {
 			compatible = "arm,coresight-stm", "arm,primecell";
 			reg = <0x0 0x4002000 0x0 0x1000>,
@@ -3859,6 +3850,20 @@
 			status = "disabled";
 		};
 
+		dc_noc: interconnect@90e0000 {
+			compatible = "qcom,sa8775p-dc-noc";
+			reg = <0x0 0x090e0000 0x0 0x5080>;
+			#interconnect-cells = <2>;
+			qcom,bcm-voters = <&apps_bcm_voter>;
+		};
+
+		gem_noc: interconnect@9100000 {
+			compatible = "qcom,sa8775p-gem-noc";
+			reg = <0x0 0x09100000 0x0 0xf6080>;
+			#interconnect-cells = <2>;
+			qcom,bcm-voters = <&apps_bcm_voter>;
+		};
+
 		usb_0: usb@a6f8800 {
 			compatible = "qcom,sa8775p-dwc3", "qcom,dwc3";
 			reg = <0 0x0a6f8800 0 0x400>;
@@ -6224,6 +6229,13 @@
 			status = "disabled";
 		};
 
+		nspa_noc: interconnect@260c0000 {
+			compatible = "qcom,sa8775p-nspa-noc";
+			reg = <0x0 0x260c0000 0x0 0x16080>;
+			#interconnect-cells = <2>;
+			qcom,bcm-voters = <&apps_bcm_voter>;
+		};
+
 		remoteproc_cdsp0: remoteproc@26300000 {
 			compatible = "qcom,sa8775p-cdsp0-pas";
 			reg = <0x0 0x26300000 0x0 0x10000>;
@@ -6356,6 +6368,13 @@
 			};
 		};
 
+		nspb_noc: interconnect@2a0c0000 {
+			compatible = "qcom,sa8775p-nspb-noc";
+			reg = <0x0 0x2a0c0000 0x0 0x16080>;
+			#interconnect-cells = <2>;
+			qcom,bcm-voters = <&apps_bcm_voter>;
+		};
+
 		remoteproc_cdsp1: remoteproc@2a300000 {
 			compatible = "qcom,sa8775p-cdsp1-pas";
 			reg = <0x0 0x2A300000 0x0 0x10000>;
-- 
2.17.1


