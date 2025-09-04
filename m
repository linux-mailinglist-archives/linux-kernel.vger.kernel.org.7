Return-Path: <linux-kernel+bounces-801293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67DC0B44361
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 18:45:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B196517C068
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 16:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A57130C35F;
	Thu,  4 Sep 2025 16:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Gq/d+ta1"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3478130BF63
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 16:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757004026; cv=none; b=PCknCxMdLwAxNtQb7LEJ9Kuxo8azTg2BxDwVO0IrMGEdYiqRgA5NHpsyDOUGB78C3bfpvrZ3/cJS7L7Js5otg3t/aIXMO9cPK6SYR73XO9nkQTq7YM6zFYfNgESoTSbNHH4xCKnL0HlsOnzwA5wYo5C0RA8z9TYBUnwgTG97dqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757004026; c=relaxed/simple;
	bh=7mhTBB4svXSgzedxS2sKUinK/GsrJ13ZbXexdU6hXAg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=acn/gmrOO/HftBrcATy8OEWnLLk8KMDxy44nkb/2Leb1DoIpqv/qD4WIuwZ3JglQwp0NrXw8GYmy2nRof/gWsgtrYREG8NdPLZvxYqUeBIpyzj/xzFn0l1I3t8IRVMTRiRCSTG6otSerkowcXBVZoX3xqzURo6Kyv3DCyY7VVxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Gq/d+ta1; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5849X7wo022145
	for <linux-kernel@vger.kernel.org>; Thu, 4 Sep 2025 16:40:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LLLFa1vgqgzhTWyXHQNG3xljguUOpM2dwOXSKlCIgOw=; b=Gq/d+ta1LGKa7X8f
	xgVG/lmshqku4IWctLWgQh1eVSo2aOK9Ho/jqc576HSFFWNr0GUH4sW/Zs7DCc62
	5UTMgDyqPITIv88aCIGv3SgJvwFcY1J0/Wbhe2BjQ8Zh4wBlQnbu2gsoi79YvGEx
	Gi8fP6ey9zkb4WahA+fg+ClaWtBYs3fR5DbkD2hp3CZBcadmGBi3HsU/CJsFsrz5
	1r/LRLFnqiJZaNXiOSLlLRuFt2DGnnjvbeEgipNkTWMXVP1Ng1HwgmJjMoiqOdNx
	zt4DdpqdADu6GUIIsYduTIBlJAhnY5zlnvDT8O/H6LyWXtDpmbIWfRK54K3lDB19
	BN3OtA==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48utk981h8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 16:40:24 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-77241858ec1so1197840b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 09:40:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757004023; x=1757608823;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LLLFa1vgqgzhTWyXHQNG3xljguUOpM2dwOXSKlCIgOw=;
        b=KCE2679skpe6GT4Qq0ZkO9Quq/54tnoovAN/HoMLlbLxv1mBKP51/NqoBa8zvMG/Ec
         zU9Htj/0pT8mpr9+44PvzA07gVs3amT+TReOqo4mjt1yEa0VfyeVUa8p0KjK5L2cG2Q2
         11Yhe9hX7mvi9n5IxkU9DK1bQi1jBzw/29Gimfd5AMrPtsIWAJonsikt6R2rxpIJpmrP
         DWgsIZvAfCFCLiNYEpvf0AWunHQoJzLH9Epw2ISTijdWIgioK/tWVDOHOW2oFhYwiwdN
         dlZDX4XHOM8fuiCQsvOk1qIRQLlTRXdhTG74iBAaLCgDCWafK49CwD6S9DMX56gX9uLm
         N/ng==
X-Forwarded-Encrypted: i=1; AJvYcCVBsxr/0f2QWeIYodmLQeKVwc/D7RcSaarZozRdfZ+MP21HKA9E3rSle9VOiuXbmiYBIRVL9yL+F0aA2Oo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkleUHeAPZXe+7njm4EPiXbHUnd/dNwbiss2qX/2U5Yqg5KOH9
	dYuZbB4EMztp9xECa4lSAwCGTXbrHKXAnu7y34OtRREHOui24JKllY73YNJK5/6stQM+7z1scR7
	Hv6oWuphID5ZUjpuFL15MxFKWBkwhxaYpRbtI0kplbM2s9bIwBhbinMo0MvZdcz76AdA=
X-Gm-Gg: ASbGnctPEyo1qH5gpXyjPCiTWLFE32xdA8FpdUMngq038KB9puDT6nZ/STVcJzX9N1f
	eh/9PnmyhoyOmYBuLWQrxIyL2b8HbLKEDO/CBDIlMfLN3wGoS6agBOs7f6Jyg7FkSm/icHICzAc
	iuPTUB9uTViZOKMtPFRgxAjS91vD6Yuc9oeKrbtrL4HdVLvKWFpjCPiGgwQU4GO4YOgDTOk3zYw
	f8/slHthSbwhR1/FekM1+d0si3lxk3WNiNPgwwjnWTH14kSbicrivthLcsKYAXAM1YNvb+qUeEV
	YkxilIgGhZNmGcrzKE/MNSNMijf0UrYPD/T2pLYINepUfpv3CLiTeajLh723ftJmBjZs
X-Received: by 2002:a05:6a21:6daa:b0:243:95c4:e681 with SMTP id adf61e73a8af0-243d6dd5ab3mr28357430637.2.1757004023340;
        Thu, 04 Sep 2025 09:40:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFuNo1sZ5orbQxvhguCAh0osRzXm3m+81fnaQsPma3tdpJgpVRtibJ9Oeu8EQ6S/Y+S0RnwVA==
X-Received: by 2002:a05:6a21:6daa:b0:243:95c4:e681 with SMTP id adf61e73a8af0-243d6dd5ab3mr28357385637.2.1757004022822;
        Thu, 04 Sep 2025 09:40:22 -0700 (PDT)
Received: from hu-wasimn-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4cd006e2c6sm17346371a12.2.2025.09.04.09.40.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 09:40:22 -0700 (PDT)
From: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
Date: Thu, 04 Sep 2025 22:09:08 +0530
Subject: [PATCH v3 12/14] arm64: dts: qcom: lemans-evk: Enable 2.5G
 Ethernet interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250904-lemans-evk-bu-v3-12-8bbaac1f25e8@oss.qualcomm.com>
References: <20250904-lemans-evk-bu-v3-0-8bbaac1f25e8@oss.qualcomm.com>
In-Reply-To: <20250904-lemans-evk-bu-v3-0-8bbaac1f25e8@oss.qualcomm.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc: kernel@oss.qualcomm.com, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
        linux-i2c@vger.kernel.org,
        Mohd Ayaan Anwar <quic_mohdayaa@quicinc.com>,
        Wasim Nazir <wasim.nazir@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-e44bb
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757003953; l=3602;
 i=wasim.nazir@oss.qualcomm.com; s=20250807; h=from:subject:message-id;
 bh=bKUautJj8bbERUSto/29GMUNDvM8H52kZaOY4JPKqO8=;
 b=Lfmp9xIvwkHZb/i/QoksB+5bNmIUT/8hdNBJ0Yl7G9Wbyagc52ldUwgblEf9DbYHLrbrLa0MN
 tmDM7D1ppkcBpVZylKyQ9RnoWM5xls/VyFtLh8/MSBRpBIDUVbnxCYn
X-Developer-Key: i=wasim.nazir@oss.qualcomm.com; a=ed25519;
 pk=4ymqwKogZUOQnbcvSUHyO19kcEVTLEk3Qc4u795hiZM=
X-Proofpoint-GUID: 6lHHxurzRSBGYIdit49uJDq9Qd70z9l9
X-Proofpoint-ORIG-GUID: 6lHHxurzRSBGYIdit49uJDq9Qd70z9l9
X-Authority-Analysis: v=2.4 cv=ccnSrmDM c=1 sm=1 tr=0 ts=68b9c0f8 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=z9nD9lg9_nmlpaFE3BIA:9 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDA0MiBTYWx0ZWRfX8xeNvvWzmeuE
 59MbZ8Ppe0qj9bIPSBlIakh1rlVbKwJUVDUXAR8zK9e0+3/Um/9ePFPQ2LECpKkuvAi0X0dcqCI
 cjbQZSctwxDLmofqziHcIRVOun+b+WfupJwOY9TRZ8uRYKhuEsnU4mlP+jGFvAvYKRZlu05JAki
 yHzUYnwFz1B1A7wlQHw9VmaSVsQrP4GiUXNyIeCcuXdUM4A4WUMtyG2oQ42+NfEolAP54Pp4HFs
 WC1sx3kqGX8QBUR4p4ayqxrd/wcCTbt6Q18Vw7S+0uC5dNu3wKW/webOqHCC/8bzsqOvsesBX0x
 xIsUU6fezGHTn8LpxqspX54OYlShzgvakUq6JWVpnvwGMJr2kq1olxuFemWDbx2WXbySH+D/YU+
 0KxsS7IC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-04_06,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 clxscore=1015 suspectscore=0 spamscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300042

From: Mohd Ayaan Anwar <quic_mohdayaa@quicinc.com>

Enable the QCA8081 2.5G Ethernet PHY on port 0. Add MDC and MDIO pin
functions for ethernet0, and enable the internal SGMII/SerDes PHY node.
Additionally, support fetching the MAC address from EEPROM via an nvmem
cell.

Signed-off-by: Mohd Ayaan Anwar <quic_mohdayaa@quicinc.com>
Signed-off-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/lemans-evk.dts | 115 ++++++++++++++++++++++++++++++++
 1 file changed, 115 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/lemans-evk.dts b/arch/arm64/boot/dts/qcom/lemans-evk.dts
index 7a85ba044ed4..9abdc8c9f2e9 100644
--- a/arch/arm64/boot/dts/qcom/lemans-evk.dts
+++ b/arch/arm64/boot/dts/qcom/lemans-evk.dts
@@ -16,6 +16,7 @@ / {
 	compatible = "qcom,lemans-evk", "qcom,qcs9100", "qcom,sa8775p";
 
 	aliases {
+		ethernet0 = &ethernet0;
 		mmc1 = &sdhc;
 		serial0 = &uart10;
 	};
@@ -300,6 +301,94 @@ vreg_l8e: ldo8 {
 	};
 };
 
+&ethernet0 {
+	phy-handle = <&hsgmii_phy0>;
+	phy-mode = "2500base-x";
+
+	pinctrl-0 = <&ethernet0_default>;
+	pinctrl-names = "default";
+
+	snps,mtl-rx-config = <&mtl_rx_setup>;
+	snps,mtl-tx-config = <&mtl_tx_setup>;
+
+	nvmem-cells = <&mac_addr0>;
+	nvmem-cell-names = "mac-address";
+
+	status = "okay";
+
+	mdio {
+		compatible = "snps,dwmac-mdio";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		hsgmii_phy0: ethernet-phy@1c {
+			compatible = "ethernet-phy-id004d.d101";
+			reg = <0x1c>;
+			reset-gpios = <&pmm8654au_2_gpios 8 GPIO_ACTIVE_LOW>;
+			reset-assert-us = <11000>;
+			reset-deassert-us = <70000>;
+		};
+	};
+
+	mtl_rx_setup: rx-queues-config {
+		snps,rx-queues-to-use = <4>;
+		snps,rx-sched-sp;
+
+		queue0 {
+			snps,dcb-algorithm;
+			snps,map-to-dma-channel = <0x0>;
+			snps,route-up;
+			snps,priority = <0x1>;
+		};
+
+		queue1 {
+			snps,dcb-algorithm;
+			snps,map-to-dma-channel = <0x1>;
+			snps,route-ptp;
+		};
+
+		queue2 {
+			snps,avb-algorithm;
+			snps,map-to-dma-channel = <0x2>;
+			snps,route-avcp;
+		};
+
+		queue3 {
+			snps,avb-algorithm;
+			snps,map-to-dma-channel = <0x3>;
+			snps,priority = <0xc>;
+		};
+	};
+
+	mtl_tx_setup: tx-queues-config {
+		snps,tx-queues-to-use = <4>;
+
+		queue0 {
+			snps,dcb-algorithm;
+		};
+
+		queue1 {
+			snps,dcb-algorithm;
+		};
+
+		queue2 {
+			snps,avb-algorithm;
+			snps,send_slope = <0x1000>;
+			snps,idle_slope = <0x1000>;
+			snps,high_credit = <0x3e800>;
+			snps,low_credit = <0xffc18000>;
+		};
+
+		queue3 {
+			snps,avb-algorithm;
+			snps,send_slope = <0x1000>;
+			snps,idle_slope = <0x1000>;
+			snps,high_credit = <0x3e800>;
+			snps,low_credit = <0xffc18000>;
+		};
+	};
+};
+
 &gpi_dma0 {
 	status = "okay";
 };
@@ -352,6 +441,10 @@ nvmem-layout {
 			compatible = "fixed-layout";
 			#address-cells = <1>;
 			#size-cells = <1>;
+
+			mac_addr0: mac-addr@0 {
+				reg = <0x0 0x6>;
+			};
 		};
 	};
 };
@@ -499,11 +592,33 @@ &sdhc {
 	status = "okay";
 };
 
+&serdes0 {
+	phy-supply = <&vreg_l5a>;
+
+	status = "okay";
+};
+
 &sleep_clk {
 	clock-frequency = <32768>;
 };
 
 &tlmm {
+	ethernet0_default: ethernet0-default-state {
+		ethernet0_mdc: ethernet0-mdc-pins {
+			pins = "gpio8";
+			function = "emac0_mdc";
+			drive-strength = <16>;
+			bias-pull-up;
+		};
+
+		ethernet0_mdio: ethernet0-mdio-pins {
+			pins = "gpio9";
+			function = "emac0_mdio";
+			drive-strength = <16>;
+			bias-pull-up;
+		};
+	};
+
 	pcie0_default_state: pcie0-default-state {
 		clkreq-pins {
 			pins = "gpio1";

-- 
2.51.0


