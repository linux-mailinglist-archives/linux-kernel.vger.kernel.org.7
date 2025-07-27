Return-Path: <linux-kernel+bounces-747058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43ECEB12F36
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 12:23:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D263176D3B
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 10:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E906F2139B5;
	Sun, 27 Jul 2025 10:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="D7kuqpIY"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C36D1FDE22
	for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 10:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753611793; cv=none; b=W/neULWvU3hgzakI2OWX8d641m2QfBGsvngfvPXJSwB7OFSxVjw626PFQ7KeShiKQ2U+6LM6Bl2lH3yTGeen8p+i3hU8xqm3HnTjHmeMsV5NbQS5ldxjePXOaaMfOuIrdzbcs4MEK+EdbM49gc6zQlyc35rbgYLTR4nuFlTLzDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753611793; c=relaxed/simple;
	bh=GOfYSmnjWjg50rzLw20CFzLtGaZOsWgHtUhEvGpajMk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AhTTdmLRxX2IwLpwpcwvTxVeCFdYqnZLUhKugMf/LKk3PIkySs/RTNgDXBfhXNfDTncmxECQraQGsVq0URezmng8jO6US/u/zZFeMRv3JwueZHr1o5o2IjipEZSDtNc6oPkIQ7R/CMP87bjU0fRkgdU8VJc1k4tno6VPUq2eVkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=D7kuqpIY; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56R9NmeA029400
	for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 10:23:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	m2SfRBHMNs8WMnGJqJgzx8xYCjZofwg+ucKkXG1V/Mc=; b=D7kuqpIYcR5jLIg2
	Qh83neysIRZjI2BzMt2m1n6x219mG5IfdJweAeSYadN0fo+req8gFsT6UHXBV2Cx
	n1kWLNzrVwo7MU8ZARZ839a1CRZUS29abyQ9+KnMvWwnwtPhx3ecdcTKrUIIIoXP
	2p61WpnL2a01+E/ElO2/V5RuZICvqzdEpAd1Urj/FvvHSxnHUj0PyvzGFEmPVF9h
	G21gMhDKVMfIxKbs+7NSF4/ah/Fzy3a+9D2NWy+6YoyBifYZ+d8bLRvbY3noGxJl
	y00nHeLtx+GsLec/F8JQ5+Cs+kM3IoBiHEoLBOfBusXIb6qtN2dHHBDOo/MvD5fM
	Eikehw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 484mcr273k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 10:23:10 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-23fc5b1c983so10129815ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 03:23:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753611788; x=1754216588;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m2SfRBHMNs8WMnGJqJgzx8xYCjZofwg+ucKkXG1V/Mc=;
        b=aD1urDFQdDlToXxGE52T/jNc21yzOVGYj5JaHmua1B1AW4IY5AkpHN8a4I4DE6nfyJ
         MQ3IMBDTy3HVfs7G/Dif9m0WtTJdpXIHcS3w1M+uhKJMwV6HI5eVOFWHShmUeB/vHy78
         QOdAQOc+8Z962erkk4opkCHX+WBSw7VzePG1qJjClg5mahBS4COZYPKwGWO7AOCGOMC/
         7u+DMTPuBq/M2kEC9B2e6Ne9CBDwI507/DFwKtCMumurQEf7IEj7voYddaTwI6m3UItz
         zA+N5aTh5QEemK4yx/9iZmeJliDbLWou00DY4aiXwB6ycNJjQVsZ1mGhvsUheuXkobe6
         Zh7w==
X-Forwarded-Encrypted: i=1; AJvYcCUv7hGC5nQcrIkJ/xH7PVA8yDkvTxc6MfnY4a1FiYUgsRCMDki6kexh0DRBg9ddhyaTSu+2Ehr4l2JXexU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwagNU4KWwqSD2W6mxLjIm21fWABmvCrIUERQF5mYHFLRqPN0Zt
	Fc199uU9w4XZ7rNHIPf5Ofluf9xxrc4XA4QZmvSxwIS1rL+2mjec0nC4uCzj8vXIdiNjPYceGZN
	90KQ6ceSJ7ocgrBo1Vgnk8ycJ/Ilc5XE4JlBwnakdTteocRJIlhXUQPpwuyEiwEj/cJEvAr0KaJ
	FOkQ==
X-Gm-Gg: ASbGncvvo0t+MXCSA9i97JU19zyhMuUN9xl+q97ucmcKNU+6VuYkqsNfcyA6eI+hcXX
	Ozc35N/V8375UdbFLV8Sx2QWfAllvZtCtn39Kh5MdMC9VuLn0hpUpofn1DJhj91etO9bpAmv8eY
	hUJUb7kSmYlSZUUEE2PPqO/mzrfyr+w/lkOvioHkSADUL0NiYyajgux2jG9XaqLQ1z/8QivxTnm
	wL6eJh00KorewKk8ZU/pmCuzG3GekkpU4VzJvvnkzOiji7uz453XIZQ3/Rr71//pQea/lALoHCc
	ilH4IO/ilxLw5fgzrfBfMavHRlsUWs18Ky8JHYWQJ9cMtwmL7MaSBt1GXRMfaD8JLgxJB+aPMC0
	206MQ14aGiNlnHBHGZbAdfKVsQso=
X-Received: by 2002:a17:903:1cb:b0:231:9817:6ec1 with SMTP id d9443c01a7336-23fb2b9994dmr122066665ad.17.1753611787774;
        Sun, 27 Jul 2025 03:23:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFcsErmuzawqbMa5LNkPKXlpUN8HUDwqsll44NNNp7K8yJMsUh3zzuAaxY8KmOH7lemHuZhBQ==
X-Received: by 2002:a17:903:1cb:b0:231:9817:6ec1 with SMTP id d9443c01a7336-23fb2b9994dmr122066475ad.17.1753611787256;
        Sun, 27 Jul 2025 03:23:07 -0700 (PDT)
Received: from yuzha-gv.ap.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fbe533b1esm31869715ad.158.2025.07.27.03.23.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Jul 2025 03:23:06 -0700 (PDT)
From: "Yu Zhang(Yuriy)" <yu.zhang@oss.qualcomm.com>
Date: Sun, 27 Jul 2025 18:22:37 +0800
Subject: [PATCH v7 2/2] arm64: dts: qcom: qcs615-ride: Enable WiFi/BT nodes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250727-615-v7-2-2adb6233bbb9@oss.qualcomm.com>
References: <20250727-615-v7-0-2adb6233bbb9@oss.qualcomm.com>
In-Reply-To: <20250727-615-v7-0-2adb6233bbb9@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Yu Zhang (Yuriy)" <yu.zhang@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753611779; l=4997;
 i=yu.zhang@oss.qualcomm.com; s=20250625; h=from:subject:message-id;
 bh=GOfYSmnjWjg50rzLw20CFzLtGaZOsWgHtUhEvGpajMk=;
 b=GXZNqmcf0bhDi84wB6QnO9hX2yVACm/TFHg9u3j5Ry2fTFPgYoVEInurPs1xNdlUBFQGtqh8+
 IgJ7VXAFf8IDoaELHEJ9uG2aPs1O4X6MDL0a66N/HUOimSjnjbV+Ckx
X-Developer-Key: i=yu.zhang@oss.qualcomm.com; a=ed25519;
 pk=ZS+pKT1eEx1+Yb0k2iKe8mk1Rk+MUki89iurrz9iucA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI3MDA5MCBTYWx0ZWRfXzgUJKsUl8dHP
 H9T41FsKLI/ORwP4ro6yuSlPzASS+85t89gUJAYpAw4k++NmZKOykSWO2AgDVUT3jbR8Q8uIsdu
 4eAWrrpKLGCGC/8SS3hrb9uc8qtKdFmQsm4noQGJRgsQAtuN9SyszTCvCGGTV3KFVcODF5dcH1X
 LxQp45z6qrlgjNGqLER7wa4WVYC8L6GYO2y6wbwfyyV930ruy5dIvMrczFQeqD2Wvbio8OPTa+r
 itQpSOKpj+FgcEzTWAL7q5mPeNjPYwtLwqWSudDLobZ8dw/NP1Yw8IcCK/RdPBL6HCEwQlj9WyD
 LhHWu8T9Nx/0WBUZ+8Wwv/duIzEnq07Nqb0glZ4ytTAPmNOrC6smMZOgaoXyJLXfYxlKaBREBCO
 k88Ka7nbbHnpk5cb07c83tVmHPcZfOiADFMqNU7eSokxL28vT3tWPQD6kqHOL2FiyckGp84d
X-Authority-Analysis: v=2.4 cv=Hth2G1TS c=1 sm=1 tr=0 ts=6885fe0e cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=cKvnr5XBRiLjHSnd2BMA:9
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: kB9LbcXaVHunfDmqjG2KR_fOtFjP-AWq
X-Proofpoint-ORIG-GUID: kB9LbcXaVHunfDmqjG2KR_fOtFjP-AWq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-27_03,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 mlxscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 mlxlogscore=999 clxscore=1015
 spamscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507270090

Enable WiFi/BT on qcs615-ride by adding a node for the PMU module of the
WCN6855 and assigning its LDO power outputs to the existing WiFi/BT
module.

Signed-off-by: Yu Zhang(Yuriy) <yu.zhang@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/qcs615-ride.dts | 135 +++++++++++++++++++++++++++++++
 1 file changed, 135 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcs615-ride.dts b/arch/arm64/boot/dts/qcom/qcs615-ride.dts
index 011f8ae077c256f079ce1b07720374a9bf721488..7d8064303547e8be1e749cffc8f3ec8d3f3ec59b 100644
--- a/arch/arm64/boot/dts/qcom/qcs615-ride.dts
+++ b/arch/arm64/boot/dts/qcom/qcs615-ride.dts
@@ -18,6 +18,7 @@ aliases {
 		mmc0 = &sdhc_1;
 		mmc1 = &sdhc_2;
 		serial0 = &uart0;
+		serial1 = &uart7;
 	};
 
 	chosen {
@@ -38,6 +39,22 @@ xo_board_clk: xo-board-clk {
 		};
 	};
 
+	vreg_conn_1p8: regulator-conn-1p8 {
+		compatible = "regulator-fixed";
+		regulator-name = "vreg_conn_1p8";
+		startup-delay-us = <4000>;
+		enable-active-high;
+		gpio = <&pm8150_gpios 1 GPIO_ACTIVE_HIGH>;
+	};
+
+	vreg_conn_pa: regulator-conn-pa {
+		compatible = "regulator-fixed";
+		regulator-name = "vreg_conn_pa";
+		startup-delay-us = <4000>;
+		enable-active-high;
+		gpio = <&pm8150_gpios 6 GPIO_ACTIVE_HIGH>;
+	};
+
 	regulator-usb2-vbus {
 		compatible = "regulator-fixed";
 		regulator-name = "USB2_VBUS";
@@ -47,6 +64,69 @@ regulator-usb2-vbus {
 		enable-active-high;
 		regulator-always-on;
 	};
+
+	wcn6855-pmu {
+		compatible = "qcom,wcn6855-pmu";
+
+		pinctrl-0 = <&bt_en_state>, <&wlan_en_state>;
+		pinctrl-names = "default";
+
+		bt-enable-gpios = <&tlmm 85 GPIO_ACTIVE_HIGH>;
+		wlan-enable-gpios = <&tlmm 98 GPIO_ACTIVE_HIGH>;
+
+		vddio-supply = <&vreg_conn_pa>;
+		vddaon-supply = <&vreg_s5a>;
+		vddpmu-supply = <&vreg_conn_1p8>;
+		vddpmumx-supply = <&vreg_conn_1p8>;
+		vddpmucx-supply = <&vreg_conn_pa>;
+		vddrfa0p95-supply = <&vreg_s5a>;
+		vddrfa1p3-supply = <&vreg_s6a>;
+		vddrfa1p9-supply = <&vreg_l15a>;
+		vddpcie1p3-supply = <&vreg_s6a>;
+		vddpcie1p9-supply = <&vreg_l15a>;
+
+		regulators {
+			vreg_pmu_rfa_cmn: ldo0 {
+				regulator-name = "vreg_pmu_rfa_cmn";
+			};
+
+			vreg_pmu_aon_0p59: ldo1 {
+				regulator-name = "vreg_pmu_aon_0p59";
+			};
+
+			vreg_pmu_wlcx_0p8: ldo2 {
+				regulator-name = "vreg_pmu_wlcx_0p8";
+			};
+
+			vreg_pmu_wlmx_0p85: ldo3 {
+				regulator-name = "vreg_pmu_wlmx_0p85";
+			};
+
+			vreg_pmu_btcmx_0p85: ldo4 {
+				regulator-name = "vreg_pmu_btcmx_0p85";
+			};
+
+			vreg_pmu_rfa_0p8: ldo5 {
+				regulator-name = "vreg_pmu_rfa_0p8";
+			};
+
+			vreg_pmu_rfa_1p2: ldo6 {
+				regulator-name = "vreg_pmu_rfa_1p2";
+			};
+
+			vreg_pmu_rfa_1p7: ldo7 {
+				regulator-name = "vreg_pmu_rfa_1p7";
+			};
+
+			vreg_pmu_pcie_0p9: ldo8 {
+				regulator-name = "vreg_pmu_pcie_0p9";
+			};
+
+			vreg_pmu_pcie_1p8: ldo9 {
+				regulator-name = "vreg_pmu_pcie_1p8";
+			};
+		};
+	};
 };
 
 &apps_rsc {
@@ -234,6 +314,25 @@ &pcie_phy {
 	status = "okay";
 };
 
+&pcie_port0 {
+	wifi@0 {
+		compatible = "pci17cb,1103";
+		reg = <0x10000 0x0 0x0 0x0 0x0>;
+
+		qcom,calibration-variant = "QC_QCS615_Ride";
+
+		vddrfacmn-supply = <&vreg_pmu_rfa_cmn>;
+		vddaon-supply = <&vreg_pmu_aon_0p59>;
+		vddwlcx-supply = <&vreg_pmu_wlcx_0p8>;
+		vddwlmx-supply = <&vreg_pmu_wlmx_0p85>;
+		vddrfa0p8-supply = <&vreg_pmu_rfa_0p8>;
+		vddrfa1p2-supply = <&vreg_pmu_rfa_1p2>;
+		vddrfa1p8-supply = <&vreg_pmu_rfa_1p7>;
+		vddpcie0p9-supply = <&vreg_pmu_pcie_0p9>;
+		vddpcie1p8-supply = <&vreg_pmu_pcie_1p8>;
+	};
+};
+
 &pm8150_gpios {
 	usb2_en: usb2-en-state {
 		pins = "gpio10";
@@ -257,6 +356,10 @@ &qupv3_id_0 {
 	status = "okay";
 };
 
+&qupv3_id_1 {
+	status = "okay";
+};
+
 &remoteproc_adsp {
 	firmware-name = "qcom/qcs615/adsp.mbn";
 
@@ -274,6 +377,13 @@ &rpmhcc {
 };
 
 &tlmm {
+	bt_en_state: bt-en-state {
+		pins = "gpio85";
+		function = "gpio";
+		bias-pull-down;
+		output-low;
+	};
+
 	pcie_default_state: pcie-default-state {
 		clkreq-pins {
 			pins = "gpio90";
@@ -296,6 +406,13 @@ wake-pins {
 			bias-pull-up;
 		};
 	};
+
+	wlan_en_state: wlan-en-state {
+		pins = "gpio98";
+		function = "gpio";
+		bias-pull-down;
+		output-low;
+	};
 };
 
 &sdhc_1 {
@@ -336,6 +453,24 @@ &uart0 {
 	status = "okay";
 };
 
+&uart7 {
+	status = "okay";
+
+	bluetooth {
+		compatible = "qcom,wcn6855-bt";
+		firmware-name = "QCA6698/hpnv21", "QCA6698/hpbtfw21.tlv";
+
+		vddrfacmn-supply = <&vreg_pmu_rfa_cmn>;
+		vddaon-supply = <&vreg_pmu_aon_0p59>;
+		vddwlcx-supply = <&vreg_pmu_wlcx_0p8>;
+		vddwlmx-supply = <&vreg_pmu_wlmx_0p85>;
+		vddbtcmx-supply = <&vreg_pmu_btcmx_0p85>;
+		vddrfa0p8-supply = <&vreg_pmu_rfa_0p8>;
+		vddrfa1p2-supply = <&vreg_pmu_rfa_1p2>;
+		vddrfa1p8-supply = <&vreg_pmu_rfa_1p7>;
+	};
+};
+
 &usb_1_hsphy {
 	vdd-supply = <&vreg_l5a>;
 	vdda-pll-supply = <&vreg_l12a>;

-- 
2.34.1


