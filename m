Return-Path: <linux-kernel+bounces-796700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 29EECB4060D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 16:05:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A10C189E0DA
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 14:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F4C42DF3CF;
	Tue,  2 Sep 2025 14:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YZc5s+Kt"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AACAB2DC32D
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 14:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756821632; cv=none; b=gZuz386O+6Rvna6sI7MALvvUvqtYZAn8H5IO0hM7SmSymW2ADvY36+QtRwcrIxa9R9utazs3GeOyolRe5K8hgtvn6LMj1tf9FxCY55QApfPr/3X69/djwYz+Z/wqJI9WVSEo+FQxjqX+aO5lEDtDOoQ0bDS6W7cZbC/RyY49CnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756821632; c=relaxed/simple;
	bh=YZAH/V1P/09om9Ubb2lCJps3ibSld2f8OjAoadqgER4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bgv4Jzgpd5e9w1uVWnBMohT6RhErAa5KdeZueHGmJLYAl1D0RawIL21WruSxsbbN5FXqpcNrQXrQ80weI8RqfMiImybcK8by7NWIsWkUW0VdG6X94lAXmkD0kBkLgQY7uKoE+4xlRvFgNOUwAAqBx42b3gIe2miQ6krt4oAHICw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YZc5s+Kt; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-afcb7ab87ffso93791966b.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 07:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756821629; x=1757426429; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=glTF6ghkk/uOHfwCIvpH7x76sV+73HSeA2VQ96I2mIw=;
        b=YZc5s+Ktls3nMHzyX7plYijupPYIpmU6pU8asrfszX6+/otlqiSjfmGKxObEgQzrSo
         ZbnGr5QbPGFw74FVzJHQWz9wSJnS/T3HlxuldcaOAfJNIJkg3UBKXQ+UMV9lVdDlJDsz
         Z10lfn2LF9lliEffPNOndB/fj57t8HIZrDO03VWEGBGhtiTAZpw4Ixq9D093/FHeCVHM
         poVXpzAl64leAWIILbz/bN30tZPcVpuZ10EbaQDziNa8ZxJQ2YhuGL5UeDDNb2EpCuP6
         bKz1BXYj7TbHiSWQasxj+3pjPzp3su/JtDEu6o53/enaCOpfaIUTUa87nBPKXfUphvbE
         uNog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756821629; x=1757426429;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=glTF6ghkk/uOHfwCIvpH7x76sV+73HSeA2VQ96I2mIw=;
        b=h7GtQ1XRbXzwDgSKsPxnEJZojadFy+BR9rUxJ3B+iT7Oh873ag/xpkouUpBqY5GYOX
         e0epqljmvje1RA9vSzl1qlT+VMrwjE8Dw1fkEn1uPTUmwrqvTL7SMg44Zbhbw6tOh9FG
         UqPWHjjwH7CC3Df1rle7hiHDPEFoKhjEwron7A9ewPYrvcJjmze68Xx01UvVTB9Q31XC
         PexIkTwKxjltfYLAxr7T7O8rW/Oyj4ppuNs+cxdd1igjkWE/JwXpg8jHegwhgAhRmA8F
         GBIbTSuIQKIWSano0dLMnNwQBRmQVrMAmUDyeyXmbGE/WGtabv7tpi66s5HU39L0PxFt
         4y/w==
X-Forwarded-Encrypted: i=1; AJvYcCVDig3nOXIVJOSVZNt7Idp6qSFDZ9C9+PzQyqhUsAGv/7xbrmZ7TzToT4a/jG+W1Rd1J4w62LVDAXoqqp8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCiz6cByLxRggj2cPWQcm4ti3GFPYQjGV1SvfafwCTj4MTtkhx
	UnPKDR0aVDTV3D1Azy2xDdwL04DeosIaf22ijHwHi76PT/xCExD98vXTGuM+7DhYJck=
X-Gm-Gg: ASbGncsptTZtDKLm4QloI1wKerbBCMvntmofKu05uLMgp2ku0DbtvQBQvsqbAy7YkIX
	QIGyWE0t+TTiKsRwBRutxmcO6T7FqVu6S/3ciUXPwu9AarZjROvi+mywRfs2q+WevN7tM441VC8
	H3yhZs+O9DozPYs7xfcQT1zdMHCuf7f1FEkqqln7s4Osd6TZv6kDTy1OYbk4NvO6xOyw8YCXJrS
	AXdE58LXRrGcypSVB4bjQyOuVmr5FTTP3vrUveMSEhIdo4RHnEZ9/P1q1V9A357fT5VpQMnqgtM
	caqozKKF9EEvT8Jm6CITYbzm/Rb887gkcn9lQRI71P4VmtQ9Jr6y+R3MZibkgYPrjphypJgi5Qq
	iQVeP8Zh8d57rHCGnmwjg8QfQDlDq1vVT1WdWHKnTe2SV
X-Google-Smtp-Source: AGHT+IGDAshsJg36aVD4eQnhtxPLKIJLVsKtgZ2Z0HAaLohyIGC1DvuIqRiP4HLvEGb1IvHql5sFCg==
X-Received: by 2002:a17:907:3e1e:b0:afe:fc35:4324 with SMTP id a640c23a62f3a-aff0ee058e5mr773663866b.1.1756821627646;
        Tue, 02 Sep 2025 07:00:27 -0700 (PDT)
Received: from kuoka.. ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b0445cb9296sm275455566b.61.2025.09.02.07.00.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 07:00:26 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [RESEND PATCH v3] arm64: dts: qcom: sm8750-mtp: Add WiFi and Bluetooth
Date: Tue,  2 Sep 2025 16:00:19 +0200
Message-ID: <20250902140018.247209-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6002; i=krzysztof.kozlowski@linaro.org;
 h=from:subject; bh=YZAH/V1P/09om9Ubb2lCJps3ibSld2f8OjAoadqgER4=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBotvhy+p2P0NQxpZzZk6TlU73cVU3cl0Oyx5PWE
 yAw1NdoyPuJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaLb4cgAKCRDBN2bmhouD
 1wJDD/oCb8b3kdJA3Ch5EjmwN4flY44wGkimwToCGnmLOOVQpF1M2COfSolr8OI/YdZ2kN5KdTE
 +zHJsPN2RsBIb+TrWyPmEOH9uBKDVH4nsdLmDeS4mJarjq7DmD1pkM2Im94D3qHEde8644tdPjy
 IRvueW5Su3F102iH3ObqvYcQN3vFL8wKCvr4AeHZvDn3vWLE4xK7UY/ihFmlj+kl09iySUS1wo3
 tUf3uJ8gU3/Uh5yTccjIrRfbinPZbpr+u+OIid0m+Iq7j04231mN2UnW7SZ58E0v1WsQLNngDl0
 loJ00jrCYlUV36oiA+K5JFcSUypbVufsEum4bOm8EJ9Y/EjIWJRT5IgogPI84ixkr9aaPle7+Ky
 Nx2NQYK+v/D1gDjBbICaJ1CeU7jll8mKezG2aht1aALFsofBl5Jd+P0zpzUJAG3j/H6Cy7oeAvV
 cx7hXBS8ev2X4xxZUJ0zLiUJKKVUnAZy92I1BLxpF7j6LTRQnDgokCaeOSEik1L+DrSMG2WK9rF
 wUG7b8OiCR4/axxWqI6ixEFasJy5P0jJNMJw8fMoPdPZjbTONCxKs9wltS6srGqM0QpvUh9DIz4
 4sMjFnLUedscM553V4ULCmH4ZmCO6tFLD2RvW7Be7SXEBjvdUNXIbapUdnTkLeBo7jTiOSa9wYk zdyf2SJbjo/DQFQ==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit

MTP8750 rev 2.0 (power grid v8) boards come as two different variants
with different WiFi chips: WCN7850 and WCN786x.  WCN7850 is already
supported by the kernel, but WCN786x is not.  Both of the board variants
are considered newest revisions and the difference is only in MCN
numbers and internal codenames.

Add WCN7850 WiFi and Bluetooth to the MTP8750, stating that this DTS
represents the WCN7850 variant.  The S4D and S5F regulators should
operate at 0.85 V, thus adjust lower constraint and regulator name.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes in v3:
1. Add also PCIe nodes, because they were not planned to be sent
   separately.
2. Drop pieces of comments as discussed with Dmitry.
v2: https://lore.kernel.org/all/20250811131055.154233-2-krzysztof.kozlowski@linaro.org/

Changes in v2:
1. Add missing &qupv3_2 enable, so Bluetooth works.
2. Adjust also S4D regulator constraint.

No dependencies, can be merged.
---
 arch/arm64/boot/dts/qcom/sm8750-mtp.dts | 147 +++++++++++++++++++++++-
 1 file changed, 143 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8750-mtp.dts b/arch/arm64/boot/dts/qcom/sm8750-mtp.dts
index 946ba53fe63a..3bbb53b7c71f 100644
--- a/arch/arm64/boot/dts/qcom/sm8750-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/sm8750-mtp.dts
@@ -201,6 +201,74 @@ vph_pwr: vph-pwr-regulator {
 		regulator-always-on;
 		regulator-boot-on;
 	};
+
+	/*
+	 * MTPs rev 2.0 (power grid v8) come with two different WiFi chips:
+	 * WCN7850 and WCN786x.
+	 * Device nodes here for the PMU, WiFi and Bluetooth describe the MTP
+	 * variant with WCN7850.
+	 */
+	wcn7850-pmu {
+		compatible = "qcom,wcn7850-pmu";
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&wlan_en>, <&bt_default>;
+
+		wlan-enable-gpios = <&tlmm 16 GPIO_ACTIVE_HIGH>;
+		bt-enable-gpios = <&pm8550ve_f_gpios 3 GPIO_ACTIVE_HIGH>;
+
+		vdd-supply = <&vreg_s5f_0p85>;
+		vddio-supply = <&vreg_l3f_1p8>;
+		vddio1p2-supply = <&vreg_l2f_1p2>;
+		vddaon-supply = <&vreg_s4d_0p85>;
+		vdddig-supply = <&vreg_s1d_0p97>;
+		vddrfa1p2-supply = <&vreg_s7i_1p2>;
+		vddrfa1p8-supply = <&vreg_s3g_1p8>;
+
+		clocks = <&rpmhcc RPMH_RF_CLK1>;
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
+			vreg_pmu_rfa_1p8: ldo7 {
+				regulator-name = "vreg_pmu_rfa_1p8";
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
@@ -426,7 +494,7 @@ vreg_s3d_1p2: smps3 {
 
 		vreg_s4d_0p85: smps4 {
 			regulator-name = "vreg_s4d_0p85";
-			regulator-min-microvolt = <500000>;
+			regulator-min-microvolt = <852000>;
 			regulator-max-microvolt = <1036000>;
 			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
 		};
@@ -472,9 +540,9 @@ regulators-2 {
 
 		qcom,pmic-id = "f";
 
-		vreg_s5f_0p5: smps5 {
-			regulator-name = "vreg_s5f_0p5";
-			regulator-min-microvolt = <500000>;
+		vreg_s5f_0p85: smps5 {
+			regulator-name = "vreg_s5f_0p85";
+			regulator-min-microvolt = <852000>;
 			regulator-max-microvolt = <1000000>;
 			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
 		};
@@ -891,6 +959,40 @@ &pon_resin {
 	status = "okay";
 };
 
+&pcie0 {
+	wake-gpios = <&tlmm 104 GPIO_ACTIVE_HIGH>;
+	perst-gpios = <&tlmm 102 GPIO_ACTIVE_LOW>;
+
+	pinctrl-0 = <&pcie0_default_state>;
+	pinctrl-names = "default";
+
+	status = "okay";
+};
+
+&pcie0_phy {
+	vdda-phy-supply = <&vreg_l1f_0p88>;
+	vdda-pll-supply = <&vreg_l3g_1p2>;
+
+	status = "okay";
+};
+
+&pcieport0 {
+	wifi@0 {
+		compatible = "pci17cb,1107";
+		reg = <0x10000 0x0 0x0 0x0 0x0>;
+
+		vddrfacmn-supply = <&vreg_pmu_rfa_cmn>;
+		vddaon-supply = <&vreg_pmu_aon_0p59>;
+		vddwlcx-supply = <&vreg_pmu_wlcx_0p8>;
+		vddwlmx-supply = <&vreg_pmu_wlmx_0p85>;
+		vddrfa0p8-supply = <&vreg_pmu_rfa_0p8>;
+		vddrfa1p2-supply = <&vreg_pmu_rfa_1p2>;
+		vddrfa1p8-supply = <&vreg_pmu_rfa_1p8>;
+		vddpcie0p9-supply = <&vreg_pmu_pcie_0p9>;
+		vddpcie1p8-supply = <&vreg_pmu_pcie_1p8>;
+	};
+};
+
 &pmih0108_eusb2_repeater {
 	status = "okay";
 
@@ -902,6 +1004,10 @@ &qupv3_1 {
 	status = "okay";
 };
 
+&qupv3_2 {
+	status = "okay";
+};
+
 &remoteproc_adsp {
 	firmware-name = "qcom/sm8750/adsp.mbn",
 			"qcom/sm8750/adsp_dtb.mbn";
@@ -1035,6 +1141,14 @@ spkr_1_sd_n_active: spkr-1-sd-n-active-state {
 };
 
 &tlmm {
+	bt_default: bt-default-state {
+		sw-ctrl-pins {
+			pins = "gpio18";
+			function = "gpio";
+			bias-pull-down;
+		};
+	};
+
 	wcd_default: wcd-reset-n-active-state {
 		pins = "gpio101";
 		function = "gpio";
@@ -1042,6 +1156,31 @@ wcd_default: wcd-reset-n-active-state {
 		bias-disable;
 		output-low;
 	};
+
+	wlan_en: wlan-en-state {
+		pins = "gpio16";
+		function = "gpio";
+		drive-strength = <8>;
+		bias-pull-down;
+	};
+};
+
+&uart14 {
+	status = "okay";
+
+	bluetooth {
+		compatible = "qcom,wcn7850-bt";
+
+		vddrfacmn-supply = <&vreg_pmu_rfa_cmn>;
+		vddaon-supply = <&vreg_pmu_aon_0p59>;
+		vddwlcx-supply = <&vreg_pmu_wlcx_0p8>;
+		vddwlmx-supply = <&vreg_pmu_wlmx_0p85>;
+		vddrfa0p8-supply = <&vreg_pmu_rfa_0p8>;
+		vddrfa1p2-supply = <&vreg_pmu_rfa_1p2>;
+		vddrfa1p8-supply = <&vreg_pmu_rfa_1p8>;
+
+		max-speed = <3200000>;
+	};
 };
 
 &ufs_mem_phy {
-- 
2.48.1


