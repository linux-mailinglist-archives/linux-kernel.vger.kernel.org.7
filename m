Return-Path: <linux-kernel+bounces-798401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 79EB8B41D5B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 13:48:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C3F61BA5D3E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 11:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0ED22FCBEA;
	Wed,  3 Sep 2025 11:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ux+wfHK1"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AFBF2FAC00
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 11:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756900071; cv=none; b=DotvItNFeSu/5IV85ZHOqldiszKqrPMFV/t0RQDdsbAbhdoN5UC+sKxqlLT8mY5CiwLrErLmO//q2R1xjbyL2m5of7XqbdU7aIjtgS+TJYTccmRXcvmhhZJ86TcCbQCYkj/nC8aC2ZExFgIy8xH0ZsNMsSw7HJZK5Nlhnacc7z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756900071; c=relaxed/simple;
	bh=ysbyanGTOQDdoDKZfJO9JNRcUI5DPnSHLHid2+/WQqs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qKdMgXVoigcrD0SpnrjE2BMpBxs5jgYa72ZJZbxDUupJOt++JFGA/+YT72FzTAcFnsKQIFihaSDAoe6EGxGaSPRxfa9Q6KvQ7yQmpQkupoyQTftT1LrR/kjCiMkTDVZwCjRFYnp0Xl+VZ/XVgo9qDHmL6HZYVTcrVzjEgGjDEFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ux+wfHK1; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 583BEosW013907
	for <linux-kernel@vger.kernel.org>; Wed, 3 Sep 2025 11:47:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xhPpuYTt60KwuxaKo5to6sQuHTwQVddj1aOmX6ZkoGM=; b=Ux+wfHK1cBoB0Hvk
	rvAIe88ITSgQ8Ttq360ZDVtd/GKWMsEJi4mP/3PoEqHp2JzC8LXsKHpgR4b9B0+Z
	Rp/+9bzgcciDH32xHnN8UQKqQHlMxJ7F693ZEU8AM3B2xQHk0y/Q1IrmpOv5F/zb
	OHXOeUc210RTJhpX8lO5s80mo2T7c0oKvP1LrkQjBkK676GnX8g578HGPynFvg/y
	2ocspCZP7PAVse9jCgE8AnoWS6mWTtJs4VHxYra/ztJNb2XD5yXYdXUKWxBpBnYH
	41SircZLP1Nm6ctowKulcUwim9LaP38B+9fyI3T6AdB4AKwCTX7FEeTSGcsjX1Ei
	97/tAg==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48w8wy7cs2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 11:47:47 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b47174c65b0so8940926a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 04:47:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756900066; x=1757504866;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xhPpuYTt60KwuxaKo5to6sQuHTwQVddj1aOmX6ZkoGM=;
        b=XnI5rB8mUBOCfG9LPSeq61kwI6pnKNB4xOM7EiFycRpiG9CAtNzCZyB6dlp8wICfAl
         dy6wVnyLW0iJCLCVHdOMaIyYAUP8Cc9BK4wreXwwZcQ+cZKOnGfug12pq0EzKDwcNhah
         +kyDZiqhrb3+QtvWnLhSWuaHvDmQrAld69B1dtprpUc3njSIrCTeXCMqzvHUKGb5b3zI
         ZTEZEQV/spo4jjN4JcryX5YmSzRZfwfS1oQXA+JVtKUtizyQaCJI6iAmd4ZYaAPFTlEa
         qRNU+c3SNlmp/zkdXI3qbw9RmNv0zlRYmTUXSCx+dQr4k/DaTa7grXMDLUc+qwrinwuh
         BZDA==
X-Forwarded-Encrypted: i=1; AJvYcCWISq25u4V7PdJSe9Q3/0HC6m/rqavVcB/04mmn7UnH11UCanve6pKsZ6w3Zt1XbdN2WdbCRrQEeM4C0EE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2H+S/S7YWD8I86IGpeVtYWfdraWDxHhoygiloyO/w0xTRznmj
	oYywpBxBPTMotWjt8BSJqn65STAtoT5PM6sPtu+Lu4ennYam4WY9GEf9YgDoh6lr1BxT2jn7UJ+
	t4eMEYckZ9hvM6gcxc8NOPn9WulzfC2LROvI3gkf9dak5pmnWXd/2/igUhUwLmMgBTw0=
X-Gm-Gg: ASbGncueQeX3FuSyRoIdbtMf6ouzDQZMAv7UrFi6M8pIic4SyJFpSQQv3iQxF38gT3t
	Tgg9c4Op1DjvoxO0vgrXtA3dIRvbJaRQ0I+lzuQLEb42ufkaSSv1DtO9ZOr6TFDjWrTha/hHoxr
	IZmxsvX0CDN0dC4Q3TuF+O8+KWxNLgF9TwhFmuRqpJj49ZJ4za6IGShdtK0rLZZfv+57pR1Xzwf
	Xj8/IZwDwtYnB7/QcapxTrgsh2L5+1Pk5OGZaqwBfUas9YeYjgkMl36hMutX0ckC2v3iLXS1PVC
	oWWvEpy3nP2gIftXe4ayqrYjAcxE6s28VQu40g7j+l8AkY2nEoTVAy4RbViwVL1LNVRc
X-Received: by 2002:a05:6a20:3c8e:b0:243:c36f:6a5b with SMTP id adf61e73a8af0-243d6e6912dmr22964625637.24.1756900065696;
        Wed, 03 Sep 2025 04:47:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEFAmG0Z03at+D5Pdmb3Z8BI8QwxUitl/Q9M4OQtvK1yAW0xniPbq3DRETbxohnwIERBbRMZA==
X-Received: by 2002:a05:6a20:3c8e:b0:243:c36f:6a5b with SMTP id adf61e73a8af0-243d6e6912dmr22964592637.24.1756900065252;
        Wed, 03 Sep 2025 04:47:45 -0700 (PDT)
Received: from hu-wasimn-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4f8a0a2851sm6584074a12.37.2025.09.03.04.47.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 04:47:44 -0700 (PDT)
From: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
Date: Wed, 03 Sep 2025 17:17:03 +0530
Subject: [PATCH v2 02/13] arm64: dts: qcom: lemans: Add SDHC controller and
 SDC pin configuration
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250903-lemans-evk-bu-v2-2-bfa381bf8ba2@oss.qualcomm.com>
References: <20250903-lemans-evk-bu-v2-0-bfa381bf8ba2@oss.qualcomm.com>
In-Reply-To: <20250903-lemans-evk-bu-v2-0-bfa381bf8ba2@oss.qualcomm.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>
Cc: kernel@oss.qualcomm.com, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
        Monish Chunara <quic_mchunara@quicinc.com>,
        Wasim Nazir <wasim.nazir@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-e44bb
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756900050; l=3338;
 i=wasim.nazir@oss.qualcomm.com; s=20250807; h=from:subject:message-id;
 bh=zv+OQgP7QtiWYcdAbwJZxI9mvZNQ5t0ZoDEvN2ren5k=;
 b=+pX2aDcvWB0Up+pV7UeQ36u+TUFaBDJt3mfpFYzvaSXU8X+AOhKStUH0wVGQsCKuIZpqhLntb
 sxtFEPktuRoAlmJELhEAWZ9UBStrShpYQe5dwwOEvkV9lL2vuX36Pn0
X-Developer-Key: i=wasim.nazir@oss.qualcomm.com; a=ed25519;
 pk=4ymqwKogZUOQnbcvSUHyO19kcEVTLEk3Qc4u795hiZM=
X-Authority-Analysis: v=2.4 cv=Ycq95xRf c=1 sm=1 tr=0 ts=68b82ae3 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=uosFifNmqa3Wiex5iiQA:9 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: VMBTv11LylwzFHKwl42kcaeivqutKaoQ
X-Proofpoint-ORIG-GUID: VMBTv11LylwzFHKwl42kcaeivqutKaoQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTAxMDEwMSBTYWx0ZWRfX+3gLffdasHEy
 RL9bSbN+jbj4C+25n/EPQW5CtaWBXEMFWe/3siFxBndgEEV1lfa38IXec9uKn93u/FhVxwbvTK9
 1WSKaErnbAlWBynCbfQ2SN5bUpokwWwFZSSt3ZCEViTzEkTY+vPswoivptEFTjoIHxz+A+JPqmt
 Wm3M/B9OFYohIEPD4KmAMBqf2fbAKoYJW8XshY1WyfT0CeqQwyZOy18a4FMb3c+mvnK5oCCgpzx
 xunBMAsq8XD+ffbBvN7GNSz11H7G0TRno5V4AH9TRNRrPlGEHFLFg7Dujnusj3lItEBcfVB2nnH
 NT1P7D6W6Xnj00gOXpuzKbb5APux+sXvnbSdpasdPiyKCU8+tYghxtcm0qxSkScI9lwgAsmLn//
 GeCLJMOX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-03_06,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 adultscore=0 phishscore=0 malwarescore=0
 bulkscore=0 suspectscore=0 impostorscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509010101

From: Monish Chunara <quic_mchunara@quicinc.com>

Introduce the SDHC v5 controller node for the Lemans platform.
This controller supports either eMMC or SD-card, but only one
can be active at a time. SD-card is the preferred configuration
on Lemans targets, so describe this controller.

Define the SDC interface pins including clk, cmd, and data lines
to enable proper communication with the SDHC controller.

Signed-off-by: Monish Chunara <quic_mchunara@quicinc.com>
Co-developed-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
Signed-off-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/lemans.dtsi | 91 ++++++++++++++++++++++++++++++++++++
 1 file changed, 91 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/lemans.dtsi b/arch/arm64/boot/dts/qcom/lemans.dtsi
index 99a566b42ef2..9e4709dce32b 100644
--- a/arch/arm64/boot/dts/qcom/lemans.dtsi
+++ b/arch/arm64/boot/dts/qcom/lemans.dtsi
@@ -3834,6 +3834,57 @@ apss_tpdm2_out: endpoint {
 			};
 		};
 
+		sdhc: mmc@87c4000 {
+			compatible = "qcom,sa8775p-sdhci", "qcom,sdhci-msm-v5";
+			reg = <0x0 0x087c4000 0x0 0x1000>;
+
+			interrupts = <GIC_SPI 383 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 521 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "hc_irq", "pwr_irq";
+
+			clocks = <&gcc GCC_SDCC1_AHB_CLK>,
+				 <&gcc GCC_SDCC1_APPS_CLK>;
+			clock-names = "iface", "core";
+
+			interconnects = <&aggre1_noc MASTER_SDC 0 &mc_virt SLAVE_EBI1 0>,
+					<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_SDC1 0>;
+			interconnect-names = "sdhc-ddr", "cpu-sdhc";
+
+			power-domains = <&rpmhpd SA8775P_CX>;
+			operating-points-v2 = <&sdhc_opp_table>;
+
+			iommus = <&apps_smmu 0x0 0x0>;
+			dma-coherent;
+
+			resets = <&gcc GCC_SDCC1_BCR>;
+
+			no-sdio;
+			no-mmc;
+
+			qcom,dll-config = <0x0007642c>;
+			qcom,ddr-config = <0x80040868>;
+
+			status = "disabled";
+
+			sdhc_opp_table: opp-table {
+				compatible = "operating-points-v2";
+
+				opp-100000000 {
+					opp-hz = /bits/ 64 <100000000>;
+					required-opps = <&rpmhpd_opp_low_svs>;
+					opp-peak-kBps = <1800000 400000>;
+					opp-avg-kBps = <100000 0>;
+				};
+
+				opp-384000000 {
+					opp-hz = /bits/ 64 <384000000>;
+					required-opps = <&rpmhpd_opp_nom>;
+					opp-peak-kBps = <5400000 1600000>;
+					opp-avg-kBps = <390000 0>;
+				};
+			};
+		};
+
 		usb_0_hsphy: phy@88e4000 {
 			compatible = "qcom,sa8775p-usb-hs-phy",
 				     "qcom,usb-snps-hs-5nm-phy";
@@ -5643,6 +5694,46 @@ qup_uart21_rx: qup-uart21-rx-pins {
 					function = "qup3_se0";
 				};
 			};
+
+			sdc_default: sdc-default-state {
+				clk-pins {
+					pins = "sdc1_clk";
+					bias-disable;
+					drive-strength = <16>;
+				};
+
+				cmd-pins {
+					pins = "sdc1_cmd";
+					bias-pull-up;
+					drive-strength = <10>;
+				};
+
+				data-pins {
+					pins = "sdc1_data";
+					bias-pull-up;
+					drive-strength = <10>;
+				};
+			};
+
+			sdc_sleep: sdc-sleep-state {
+				clk-pins {
+					pins = "sdc1_clk";
+					drive-strength = <2>;
+					bias-bus-hold;
+				};
+
+				cmd-pins {
+					pins = "sdc1_cmd";
+					drive-strength = <2>;
+					bias-bus-hold;
+				};
+
+				data-pins {
+					pins = "sdc1_data";
+					drive-strength = <2>;
+					bias-bus-hold;
+				};
+			};
 		};
 
 		sram: sram@146d8000 {

-- 
2.51.0


