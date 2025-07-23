Return-Path: <linux-kernel+bounces-742103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D906B0ED39
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 10:30:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1008E1C82B8C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 08:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02B7F279DDF;
	Wed, 23 Jul 2025 08:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZMY87mwA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A52A27A915
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 08:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753259404; cv=none; b=dd+K8hDDMdNbvF3Jn8rut7KtemmbYGgA3xPZ5gXv2RHWZEC9bvH96xy1XERwTIblxwR7hYz48pLsRxegM6JsnmFzaiWqL8BT4uBYkQX5gE3Ztb8v9Vs0toDCaDollZ4utERCdKN7sNz3dlRF043KTljqP7hkqn6d8iVai0XSyy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753259404; c=relaxed/simple;
	bh=ypX3F6FEtHUpWnHV8fMyxlBQTRUCX2vP8Ra6yftMLBk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=dq+phU7+4CZ4QRNd4BSxS+8tgvb3wm42xYvxQBLUjPnL9SbNpqDlp5jTXWKOYiGNC1aNQvUpsLeFbKsJMRLOz62vz8t/yoje3WS8GFPacs0k0wrLCng95v/6MrC0sTWpHatmzMSiFTFCt5L3gFEfV19Wdtvcsa0i3N1S6EZB2W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZMY87mwA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BDF53C4CEE7;
	Wed, 23 Jul 2025 08:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753259403;
	bh=ypX3F6FEtHUpWnHV8fMyxlBQTRUCX2vP8Ra6yftMLBk=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=ZMY87mwALtXEms6czrxU64yUF6Yk6GarkxRl9Ig6nmV3KwkmCeJBwU2ELq9ACUo4k
	 E00Al66kQ/605d1XlKkKYUf+c32L2iAMltkADQ+1vsyPl86hEeaGPp6HxOLfuVFbPI
	 Pe+z137Xe6n4WflJ66OWgpCMV+lGpnHxbvR3pIyPThCFULW2YdzJeOaABwplk8SDPV
	 7LYbeIATMEXJDD+THyJfye62IZpDH/6ow1YD7OqXHdL+RG6RELc4ckcBz5IdkA4ew6
	 xWIM0gP8LCqLgVDxarpIFW5+Hrsbo/N3YDBhTXFDiKqCg3zcYcosechHSGKqNW3QBp
	 TCY+SOokyA8NQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B44F8C83F1A;
	Wed, 23 Jul 2025 08:30:03 +0000 (UTC)
From: leqi via B4 Relay <devnull+quic_leqi.quicinc.com@kernel.org>
Date: Wed, 23 Jul 2025 16:29:29 +0800
Subject: [PATCH] arm64: dts: qcom: Add initial audio support for
 Hamoa-IOT-EVK
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250723-initial_audio_support_for_qualcomm_hamoa_iot_evk_board-v1-1-816991701952@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAHqdgGgC/zWO2wqDMBBEf0Xy3IgXVJRS+h9Fwmo2dWl1NVEpi
 P/eoO3LwJmHObMJh5bQiSrYhMWVHPHgIb4Eou1geKIk7VkkUZJFRZJKGmgmeCtYNLFyyziynZV
 hq6YF3i33veqgZ1DEs8L1pRoGq2Ua52mCugDdlMKPjxYNfQ7xoz7Z4rR4/3yWokfn4PBXwfXUx
 7n8bZ8n5BrLSJrcZDoyJXjFnZ0L/0dCHzdR7/sXxSGqNOYAAAA=
X-Change-ID: 20250723-initial_audio_support_for_qualcomm_hamoa_iot_evk_board-31632ed7adb9
To: kernel@oss.qualcomm.com
Cc: linux-kernel@vger.kernel.org, kernel@quicinc.com, 
 leqi <quic_leqi@quicinc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753259402; l=7930;
 i=quic_leqi@quicinc.com; s=20250723; h=from:subject:message-id;
 bh=a2svwikEYCyvL62ztRMaDH16IYFKiZybi/L8fuaDPN8=;
 b=qLLOkSPB5dda+w7KLGnBobNLNBp0YqM/dsAq09z6J3ZLB2SZSoAZHvDW7bF1Iyh3BEPwjSj/5
 UOTZ23VbbMEB0KROVDmpL18K7bHSOkN0aYWyYebBSnn+SNcY34+AYgw
X-Developer-Key: i=quic_leqi@quicinc.com; a=ed25519;
 pk=zFi/rGGqo+G9Nw0VmaL7OqH7uu58kmZCRPPUqE9PH64=
X-Endpoint-Received: by B4 Relay for quic_leqi@quicinc.com/20250723 with
 auth_id=465
X-Original-From: leqi <quic_leqi@quicinc.com>
Reply-To: quic_leqi@quicinc.com

From: leqi <quic_leqi@quicinc.com>

This patch adds initial audio codec support for the Hamoa-IOT-EVK board,
including WCD9385 configuration, micbias voltage settings, GPIO reset,
and power supply bindings. It enables basic audio functionality for
testing and development.

Signed-off-by: leqi <quic_leqi@quicinc.com>
---
This patch adds initial audio codec support for the Qualcomm Hamoa-IOT-EVK board.
It brings up the WCD9385 codec with basic configuration, including micbias voltage
settings, GPIO reset handling, and power supply bindings.

The DTS changes are adapted from the existing X1 CRD DTS and have not yet been
validated on Hamoa-IOT-EVK hardware. They are intended to enable initial bring-up
and provide a foundation for further testing and development.
---
 arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts | 232 +++++++++++++++++++++++++++++
 1 file changed, 232 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts b/arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts
index 843f39c9d59286a9303a545411b2518d7649a059..91618e22e86c46c698b3639f60bc19314705b391 100644
--- a/arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts
+++ b/arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts
@@ -124,6 +124,94 @@ pmic_glink_ss2_con_sbu_in: endpoint {
 		};
 	};
 
+	sound {
+		compatible = "qcom,x1e80100-sndcard";
+		model = "X1E80100-EVK";
+		audio-routing = "WooferLeft IN", "WSA WSA_SPK1 OUT",
+				"TweeterLeft IN", "WSA WSA_SPK2 OUT",
+				"WooferRight IN", "WSA2 WSA_SPK2 OUT",
+				"TweeterRight IN", "WSA2 WSA_SPK2 OUT",
+				"IN1_HPHL", "HPHL_OUT",
+				"IN2_HPHR", "HPHR_OUT",
+				"AMIC2", "MIC BIAS2",
+				"VA DMIC0", "MIC BIAS3",
+				"VA DMIC1", "MIC BIAS3",
+				"VA DMIC2", "MIC BIAS1",
+				"VA DMIC3", "MIC BIAS1",
+				"VA DMIC0", "VA MIC BIAS3",
+				"VA DMIC1", "VA MIC BIAS3",
+				"VA DMIC2", "VA MIC BIAS1",
+				"VA DMIC3", "VA MIC BIAS1",
+				"TX SWR_INPUT1", "ADC2_OUTPUT";
+
+		wcd-playback-dai-link {
+			link-name = "WCD Playback";
+
+			cpu {
+				sound-dai = <&q6apmbedai RX_CODEC_DMA_RX_0>;
+			};
+
+			codec {
+				sound-dai = <&wcd938x 0>, <&swr1 0>, <&lpass_rxmacro 0>;
+			};
+
+			platform {
+				sound-dai = <&q6apm>;
+			};
+		};
+
+		wcd-capture-dai-link {
+			link-name = "WCD Capture";
+
+			cpu {
+				sound-dai = <&q6apmbedai TX_CODEC_DMA_TX_3>;
+			};
+
+			codec {
+				sound-dai = <&wcd938x 1>, <&swr2 1>, <&lpass_txmacro 0>;
+			};
+
+			platform {
+				sound-dai = <&q6apm>;
+			};
+		};
+
+		wsa-dai-link {
+			link-name = "WSA Playback";
+
+			cpu {
+				sound-dai = <&q6apmbedai WSA_CODEC_DMA_RX_0>;
+			};
+
+			codec {
+				sound-dai = <&left_woofer>, <&left_tweeter>,
+					    <&swr0 0>, <&lpass_wsamacro 0>,
+					    <&right_woofer>, <&right_tweeter>,
+					    <&swr3 0>, <&lpass_wsa2macro 0>;
+			};
+
+			platform {
+				sound-dai = <&q6apm>;
+			};
+		};
+
+		va-dai-link {
+			link-name = "VA Capture";
+
+			cpu {
+				sound-dai = <&q6apmbedai VA_CODEC_DMA_TX_0>;
+			};
+
+			codec {
+				sound-dai = <&lpass_vamacro 0>;
+			};
+
+			platform {
+				sound-dai = <&q6apm>;
+			};
+		};
+	};
+
 	vph_pwr: regulator-vph-pwr {
 		compatible = "regulator-fixed";
 
@@ -353,6 +441,33 @@ vreg_wwan: regulator-wwan {
 		regulator-boot-on;
 	};
 
+	wcd938x: audio-codec {
+		compatible = "qcom,wcd9385-codec";
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&wcd_default>;
+
+		reset-gpios = <&tlmm 191 GPIO_ACTIVE_LOW>;
+
+		qcom,micbias1-microvolt = <1800000>;
+		qcom,micbias2-microvolt = <1800000>;
+		qcom,micbias3-microvolt = <1800000>;
+		qcom,micbias4-microvolt = <1800000>;
+		qcom,mbhc-buttons-vthreshold-microvolt = <75000 150000 237000 500000
+							  500000 500000 500000 500000>;
+		qcom,mbhc-headset-vthreshold-microvolt = <1700000>;
+		qcom,mbhc-headphone-vthreshold-microvolt = <50000>;
+		qcom,rx-device = <&wcd_rx>;
+		qcom,tx-device = <&wcd_tx>;
+
+		vdd-buck-supply = <&vreg_l15b_1p8>;
+		vdd-rxtx-supply = <&vreg_l15b_1p8>;
+		vdd-io-supply = <&vreg_l15b_1p8>;
+		vdd-mic-bias-supply = <&vreg_bob1>;
+
+		#sound-dai-cells = <1>;
+	};
+
 	wcn7850-pmu {
 		compatible = "qcom,wcn7850-pmu";
 
@@ -572,6 +687,32 @@ retimer_ss1_con_sbu_out: endpoint {
 	};
 };
 
+&lpass_tlmm {
+	spkr_01_sd_n_active: spkr-01-sd-n-active-state {
+		pins = "gpio12";
+		function = "gpio";
+		drive-strength = <16>;
+		bias-disable;
+		output-low;
+	};
+
+	spkr_23_sd_n_active: spkr-23-sd-n-active-state {
+		pins = "gpio13";
+		function = "gpio";
+		drive-strength = <16>;
+		bias-disable;
+		output-low;
+	};
+};
+
+&lpass_vamacro {
+	pinctrl-0 = <&dmic01_default>, <&dmic23_default>;
+	pinctrl-names = "default";
+
+	vdd-micb-supply = <&vreg_l1b_1p8>;
+	qcom,dmic-sample-rate = <4800000>;
+};
+
 &pcie6a {
 	vddpe-3v3-supply = <&vreg_nvme>;
 };
@@ -645,6 +786,90 @@ &smb2360_2_eusb2_repeater {
 	vdd3-supply = <&vreg_l8b_3p0>;
 };
 
+&swr0 {
+	status = "okay";
+
+	pinctrl-0 = <&wsa_swr_active>, <&spkr_01_sd_n_active>;
+	pinctrl-names = "default";
+
+	/* WSA8845, Left Woofer */
+	left_woofer: speaker@0,0 {
+		compatible = "sdw20217020400";
+		reg = <0 0>;
+		reset-gpios = <&lpass_tlmm 12 GPIO_ACTIVE_LOW>;
+		#sound-dai-cells = <0>;
+		sound-name-prefix = "WooferLeft";
+		vdd-1p8-supply = <&vreg_l15b_1p8>;
+		vdd-io-supply = <&vreg_l12b_1p2>;
+		qcom,port-mapping = <1 2 3 7 10 13>;
+	};
+
+	/* WSA8845, Left Tweeter */
+	left_tweeter: speaker@0,1 {
+		compatible = "sdw20217020400";
+		reg = <0 1>;
+		reset-gpios = <&lpass_tlmm 12 GPIO_ACTIVE_LOW>;
+		#sound-dai-cells = <0>;
+		sound-name-prefix = "TweeterLeft";
+		vdd-1p8-supply = <&vreg_l15b_1p8>;
+		vdd-io-supply = <&vreg_l12b_1p2>;
+		qcom,port-mapping = <4 5 6 7 11 13>;
+	};
+};
+
+&swr1 {
+	status = "okay";
+
+	/* WCD9385 RX */
+	wcd_rx: codec@0,4 {
+		compatible = "sdw20217010d00";
+		reg = <0 4>;
+		qcom,rx-port-mapping = <1 2 3 4 5>;
+	};
+};
+
+&swr2 {
+	status = "okay";
+
+	/* WCD9385 TX */
+	wcd_tx: codec@0,3 {
+		compatible = "sdw20217010d00";
+		reg = <0 3>;
+		qcom,tx-port-mapping = <2 2 3 4>;
+	};
+};
+
+&swr3 {
+	status = "okay";
+
+	pinctrl-0 = <&wsa2_swr_active>, <&spkr_23_sd_n_active>;
+	pinctrl-names = "default";
+
+	/* WSA8845, Right Woofer */
+	right_woofer: speaker@0,0 {
+		compatible = "sdw20217020400";
+		reg = <0 0>;
+		reset-gpios = <&lpass_tlmm 13 GPIO_ACTIVE_LOW>;
+		#sound-dai-cells = <0>;
+		sound-name-prefix = "WooferRight";
+		vdd-1p8-supply = <&vreg_l15b_1p8>;
+		vdd-io-supply = <&vreg_l12b_1p2>;
+		qcom,port-mapping = <1 2 3 7 10 13>;
+	};
+
+	/* WSA8845, Right Tweeter */
+	right_tweeter: speaker@0,1 {
+		compatible = "sdw20217020400";
+		reg = <0 1>;
+		reset-gpios = <&lpass_tlmm 13 GPIO_ACTIVE_LOW>;
+		#sound-dai-cells = <0>;
+		sound-name-prefix = "TweeterRight";
+		vdd-1p8-supply = <&vreg_l15b_1p8>;
+		vdd-io-supply = <&vreg_l12b_1p2>;
+		qcom,port-mapping = <4 5 6 7 11 13>;
+	};
+};
+
 &tlmm {
 	eusb3_reset_n: eusb3-reset-n-state {
 		pins = "gpio6";
@@ -733,6 +958,13 @@ usb2_pwr_3p3_reg_en: usb2-pwr-3p3-reg-en-state {
 		bias-disable;
 	};
 
+	wcd_default: wcd-reset-n-active-state {
+		pins = "gpio191";
+		function = "gpio";
+		drive-strength = <16>;
+		bias-disable;
+		output-low;
+	};
 
 	wcn_bt_en: wcn-bt-en-state {
 		pins = "gpio116";

---
base-commit: 3b28da3245e8c43f3f5948513b4e859a3d0fa820
change-id: 20250723-initial_audio_support_for_qualcomm_hamoa_iot_evk_board-31632ed7adb9
prerequisite-message-id: <20250716-hamoa_initial-v1-0-f6f5d0f9a163@oss.qualcomm.com>
prerequisite-patch-id: 3c553b55d143eafc1036ce2e88df558ec61c4e83
prerequisite-patch-id: a4b2dabd376d32ecb159141c17113a8f3fc4ddfa
prerequisite-patch-id: 24bf2ada12dc10f9980ed2c56347e5b6f7964ebd
prerequisite-patch-id: c764e86c94055e56aaf9e701341bba52a54a998b

Best regards,
-- 
leqi <quic_leqi@quicinc.com>



