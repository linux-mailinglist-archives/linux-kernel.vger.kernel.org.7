Return-Path: <linux-kernel+bounces-798926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 79FEEB424C4
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 17:16:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89A221886296
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 15:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1516733A027;
	Wed,  3 Sep 2025 15:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PHxNAu8L"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93BCF3376B2
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 15:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756912469; cv=none; b=QPBbawXj14I6ndcpMC5hnvwyDAHorqLvAGonITmlLA/8Hmw7FXC8im1HWk3izmnJr88ZeS5/B2wUQnI9MCx/nQBtsG/6AX84u9Ucrny8p0WWYH+t2xP8QIlvxptP+UTmpEe48Hf9EPZFg5nvK9MfgrH5xO9evTuR7LjUNdRegl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756912469; c=relaxed/simple;
	bh=XGTNYwAh6SUrB3hie3zBaTpEKXaEKPaK3M5NlU6AlnY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Zr3rS4NkLum4Mk4iQ3fRPZl3gk+lPLM9I87BSlnLbqd4vszKwowgjoPR/bhWl0Kl70ZSeEn/Ary212WCXpon9eW3lpWmqiVjzYZeUjM2JKYgqnAphxjZ7+s++zisK4eRtQvI2FoiyyxFQK5/5PoEAG5QzqT5GQDdQkcWc0HoObc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PHxNAu8L; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 583DwqNc016640
	for <linux-kernel@vger.kernel.org>; Wed, 3 Sep 2025 15:14:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=28LYAYTs7dV
	FHgNtO4RYYE1fJnduC9OmiapRYB4psmA=; b=PHxNAu8LsILWQJhrLo20lxAZp1o
	LhVf8CSlZ7ri2baVjkVQ2v0/EGkiPADOOxJx+X/+a32zXQG59xAwuJEx/0TlPmop
	sTx+iOdIYX6+/3OxLFB+1NVQT98mbwsW2dol4S5ZfYIggfoSVUsyjnpyB5MTD6lF
	++6JfyR5hA9u9LIXc3xvtR1huzyW7IaBXd3mwCHsBQDxk2yYOGbA7B6txs2GsT39
	W+pj7oeWpVOdAEpwfG5/sLYaBHPHwBRdX5hdbxm/0UzjPyRebqcvghtJRcISImWN
	Sv12dEek4xNXDdQFJL9Q+88b4qj3QgKY5Zt6kY5JH4WJ7EeFwmXRn82n7CQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48xmxj0q1d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 15:14:26 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-24cb39fbd78so416815ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 08:14:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756912466; x=1757517266;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=28LYAYTs7dVFHgNtO4RYYE1fJnduC9OmiapRYB4psmA=;
        b=AexQGoU7esf6lqEE2wrVR7RecShomhYVYEqio/ZJRupFXD3z38YKTlC2nDOqnwdTUn
         4PQIbWgBOqkXraNmHk5fEkMWdZJ4ZOw7SY324SRn05l7W5gwfGrciGaTSmHh2FUkT0Lb
         9Mr4A9G1DdZa3P2P+CTNgokCOld/IUF2Fg1pZjtO6pKN+LnXNzhA5vJLsI0PMsz0Pymg
         XBGjsw0tgwUVpEDn6ti7XZT2NV+J+xa3GbCOX6HPgyynll/JMdWccL7LGm1roTOfHEYi
         UOs8E4pN8zs3TJzoL9CkOVvXZt0xYVvk170uWC0l2Zrlqg9DvWjUH+ltFjFX4kw9VcqA
         dYVw==
X-Forwarded-Encrypted: i=1; AJvYcCWezbXHjmDSMcKmg4+0iXWiksIl7ScUpYn+5XWKyTKfjeL+AAe5Q7z6KsPHcFPDVEY9Fe0hFVT3l5huDQ4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywu7ydVHlf7EPoEW3nTyowWbpHMR5uwYgXD0d+A3uQbfW7casqf
	i1nylDVu51S32FLto9XoYUE9Ao0dtOsmEiJRmfMx4/5ZB/DhlGPqoqcou3bmyF0t1vHBmiVjSLw
	oDrt3QHp7WzVzl8uQoW7D3VvT+0wf3cK6yVCcyhLCFp70L5HdVtKu7B/jdmMqk+B5258=
X-Gm-Gg: ASbGnct/BlH4hPAzRzD1Zmh683Y7yjR9Pbep1uX+eHd7ZiMfGG0ejtBqIerMfAENIKZ
	hndCfJhT5CpucTsKVm8R47PxIS/J0387vc/7E038Cfre8e+hGoEYmDjM38zHZcqglDqzlOLTsnT
	n2CaDKz/CKwHMhM9ej+f8SBh+kF/op10wg0P48LcDM8AXX/cnkx0LNHGqZXCM6ZjbFOOf1g8VC7
	c2yNnFG4Mu51nq1hiBXmIV8neMeINqXtSmv5r1mwRwfxIZ/YaHbrp1xuE60WQiQA5PRioB8CcS3
	R5YD0rdyq4BmjxD27rRB7NHH4Vwql5/F+BJ2xmG8eQpWFhz9KtAuM1+p4WIysvhS+bt/bXESNeO
	b
X-Received: by 2002:a17:902:d543:b0:246:4077:456f with SMTP id d9443c01a7336-24944b35030mr192538225ad.58.1756912465689;
        Wed, 03 Sep 2025 08:14:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE/jVXL55CUd5wuHJqnQAV4G/lWQy8YP2hW4F8a8GQCBf1WAC6F++wnzcYIk4FTLBQKKG5eIg==
X-Received: by 2002:a17:902:d543:b0:246:4077:456f with SMTP id d9443c01a7336-24944b35030mr192537735ad.58.1756912465087;
        Wed, 03 Sep 2025 08:14:25 -0700 (PDT)
Received: from hu-mohs-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24903758b89sm164818945ad.59.2025.09.03.08.14.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 08:14:24 -0700 (PDT)
From: Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>
To: Srinivas Kandagatla <srini@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org,
        linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@oss.qualcomm.com,
        prasad.kumpatla@oss.qualcomm.com,
        Prasad Kumpatla <quic_pkumpatl@quicinc.com>
Subject: [PATCH v9 7/8] arm64: dts: qcom: qcm6490-idp: Add WSA8830 speakers and WCD9370 headset codec
Date: Wed,  3 Sep 2025 20:43:36 +0530
Message-Id: <20250903151337.1037246-8-mohammad.rafi.shaik@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250903151337.1037246-1-mohammad.rafi.shaik@oss.qualcomm.com>
References: <20250903151337.1037246-1-mohammad.rafi.shaik@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTAzMDExNyBTYWx0ZWRfX0RoDSQi2fqxU
 N1rkmMMq9QgZp4+fu2vW05lxGXA/j4290RntmbdJm6mVEDMSBiGoPfG5ObM9/Y8Wom1xNQi6GOr
 v4B4YgY6WWwZjC6ILXR32LmJT7M8Z3UL2dqW48q8Sti0H5MvDGvxDal9uHZP1kTpcDBmLoJZV2e
 5zDEKA5joR6OtZlVeH6cKqTdEUWS6ADhGBrFg/G/3Umh/SJe6rf74pMGGxjrixEqQvVwstz4RT4
 4FjXiHw6pLqxAlv/tkq/1QhgWXTdGnnS8wV0WweXGbqQHE6PPWx2qXcGA99H8YOiiAccjgGXAVb
 PjE4n0rAWxSWPBoJxJBv3zFrYoNp0duoaNi5IbWXzxAa1M6u/+QSZ69RUEADv/gGXKuvn0BU6fh
 rfVZcbqr
X-Authority-Analysis: v=2.4 cv=a5cw9VSF c=1 sm=1 tr=0 ts=68b85b52 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=U1-NlgUr8jZUk8VuFV4A:9
 a=uG9DUKGECoFWVXl0Dc02:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: fwVdXAtdPvSV4CbNwR4T8L9aWsyZhmTh
X-Proofpoint-ORIG-GUID: fwVdXAtdPvSV4CbNwR4T8L9aWsyZhmTh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-03_08,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 phishscore=0 impostorscore=0 adultscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509030117

Add nodes for WSA8830 speakers and WCD9370 headset codec
on qcm6490-idp board and enable lpass macros along with
audio support pin controls.

Co-developed-by: Prasad Kumpatla <quic_pkumpatl@quicinc.com>
Signed-off-by: Prasad Kumpatla <quic_pkumpatl@quicinc.com>
Signed-off-by: Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/qcm6490-idp.dts | 123 +++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/sc7280.dtsi     |  12 +++
 2 files changed, 135 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcm6490-idp.dts b/arch/arm64/boot/dts/qcom/qcm6490-idp.dts
index 8ed6e28b0c29..379ee346a33a 100644
--- a/arch/arm64/boot/dts/qcom/qcm6490-idp.dts
+++ b/arch/arm64/boot/dts/qcom/qcm6490-idp.dts
@@ -18,6 +18,7 @@
 #include "pm7325.dtsi"
 #include "pm8350c.dtsi"
 #include "pmk8350.dtsi"
+#include "qcs6490-audioreach.dtsi"
 
 /delete-node/ &ipa_fw_mem;
 /delete-node/ &rmtfs_mem;
@@ -169,6 +170,30 @@ vph_pwr: vph-pwr-regulator {
 		regulator-min-microvolt = <3700000>;
 		regulator-max-microvolt = <3700000>;
 	};
+
+	wcd9370: audio-codec-0 {
+		compatible = "qcom,wcd9370-codec";
+
+		pinctrl-0 = <&wcd_default>;
+		pinctrl-names = "default";
+
+		reset-gpios = <&tlmm 83 GPIO_ACTIVE_HIGH>;
+
+		vdd-buck-supply = <&vreg_l17b_1p7>;
+		vdd-rxtx-supply = <&vreg_l18b_1p8>;
+		vdd-px-supply = <&vreg_l18b_1p8>;
+		vdd-mic-bias-supply = <&vreg_bob_3p296>;
+
+		qcom,micbias1-microvolt = <1800000>;
+		qcom,micbias2-microvolt = <1800000>;
+		qcom,micbias3-microvolt = <1800000>;
+		qcom,micbias4-microvolt = <1800000>;
+
+		qcom,rx-device = <&wcd937x_rx>;
+		qcom,tx-device = <&wcd937x_tx>;
+
+		#sound-dai-cells = <1>;
+	};
 };
 
 &apps_rsc {
@@ -536,6 +561,22 @@ &gpu_zap_shader {
 	firmware-name = "qcom/qcm6490/a660_zap.mbn";
 };
 
+&lpass_rx_macro {
+	status = "okay";
+};
+
+&lpass_tx_macro {
+	status = "okay";
+};
+
+&lpass_va_macro {
+	status = "okay";
+};
+
+&lpass_wsa_macro {
+	status = "okay";
+};
+
 &mdss {
 	status = "okay";
 };
@@ -716,6 +757,81 @@ &sdhc_2 {
 	cd-gpios = <&tlmm 91 GPIO_ACTIVE_LOW>;
 };
 
+&swr0 {
+	status = "okay";
+
+	wcd937x_rx: codec@0,4 {
+		compatible = "sdw20217010a00";
+		reg = <0 4>;
+
+		/*
+		 * WCD9370 RX Port 1 (HPH_L/R)       <==>    SWR1 Port 1 (HPH_L/R)
+		 * WCD9370 RX Port 2 (CLSH)          <==>    SWR1 Port 2 (CLSH)
+		 * WCD9370 RX Port 3 (COMP_L/R)      <==>    SWR1 Port 3 (COMP_L/R)
+		 * WCD9370 RX Port 4 (LO)            <==>    SWR1 Port 4 (LO)
+		 * WCD9370 RX Port 5 (DSD_L/R)       <==>    SWR1 Port 5 (DSD)
+		 */
+		qcom,rx-port-mapping = <1 2 3 4 5>;
+
+		/*
+		 * Static channels mapping between slave and master rx port channels.
+		 * In the order of slave port channels, which is
+		 * hph_l, hph_r, clsh, comp_l, comp_r, lo, dsd_r, dsd_l.
+		 */
+		qcom,rx-channel-mapping = /bits/ 8 <1 2 1 1 2 1 1 2>;
+	};
+};
+
+&swr1 {
+	status = "okay";
+
+	wcd937x_tx: codec@0,3 {
+		compatible = "sdw20217010a00";
+		reg = <0 3>;
+
+		/*
+		 * WCD9370 TX Port 1 (ADC1)               <=> SWR2 Port 2
+		 * WCD9370 TX Port 2 (ADC2, 3)            <=> SWR2 Port 2
+		 * WCD9370 TX Port 3 (DMIC0,1,2,3 & MBHC) <=> SWR2 Port 3
+		 * WCD9370 TX Port 4 (DMIC4,5,6,7)        <=> SWR2 Port 4
+		 */
+		qcom,tx-port-mapping = <1 1 2 3>;
+
+		/*
+		 * Static channel mapping between slave and master tx port channels.
+		 * In the order of slave port channels which is adc1, adc2, adc3,
+		 * mic0, dmic1, mbhc, dmic2, dmic3, dmci4, dmic5, dmic6, dmic7.
+		 */
+		qcom,tx-channel-mapping = /bits/ 8 <1 2 1 1 2 3 3 4 1 2 3 4>;
+	};
+};
+
+&swr2 {
+	status = "okay";
+
+	left_spkr: speaker@0,1 {
+		compatible = "sdw10217020200";
+		reg = <0 1>;
+		powerdown-gpios = <&tlmm 63 GPIO_ACTIVE_LOW>;
+		#sound-dai-cells = <0>;
+		sound-name-prefix = "SpkrLeft";
+		#thermal-sensor-cells = <0>;
+		vdd-supply = <&vreg_l18b_1p8>;
+		qcom,port-mapping = <1 2 3 7>;
+	};
+
+	right_spkr: speaker@0,2 {
+		compatible = "sdw10217020200";
+		reg = <0 2>;
+		powerdown-gpios = <&tlmm 62 GPIO_ACTIVE_LOW>;
+		#sound-dai-cells = <0>;
+		sound-name-prefix = "SpkrRight";
+		#thermal-sensor-cells = <0>;
+		vdd-supply = <&vreg_l18b_1p8>;
+		qcom,port-mapping = <4 5 6 8>;
+	};
+};
+
 &tlmm {
 	gpio-reserved-ranges = <32 2>, /* ADSP */
 			       <48 4>; /* NFC */
@@ -725,6 +841,13 @@ sd_cd: sd-cd-state {
 		function = "gpio";
 		bias-pull-up;
 	};
+
+	wcd_default: wcd-reset-n-active-state {
+		pins = "gpio83";
+		function = "gpio";
+		drive-strength = <16>;
+		bias-disable;
+	};
 };
 
 &uart5 {
diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index 5b78d111b2f2..4ac909214a86 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -3029,21 +3029,33 @@ lpass_dmic23_data: dmic23-data-state {
 			lpass_rx_swr_clk: rx-swr-clk-state {
 				pins = "gpio3";
 				function = "swr_rx_clk";
+				drive-strength = <2>;
+				slew-rate = <1>;
+				bias-disable;
 			};
 
 			lpass_rx_swr_data: rx-swr-data-state {
 				pins = "gpio4", "gpio5";
 				function = "swr_rx_data";
+				drive-strength = <2>;
+				slew-rate = <1>;
+				bias-bus-hold;
 			};
 
 			lpass_tx_swr_clk: tx-swr-clk-state {
 				pins = "gpio0";
 				function = "swr_tx_clk";
+				drive-strength = <2>;
+				slew-rate = <1>;
+				bias-disable;
 			};
 
 			lpass_tx_swr_data: tx-swr-data-state {
 				pins = "gpio1", "gpio2", "gpio14";
 				function = "swr_tx_data";
+				drive-strength = <2>;
+				slew-rate = <1>;
+				bias-bus-hold;
 			};
 
 			lpass_wsa_swr_clk: wsa-swr-clk-state {
-- 
2.34.1


