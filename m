Return-Path: <linux-kernel+bounces-742450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21B5BB0F1DA
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 14:04:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D3A417FA85
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 12:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 082552E54D9;
	Wed, 23 Jul 2025 12:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j8YKL1qp"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 440662E54C7
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 12:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753272275; cv=none; b=U8gy0L/S93MRHlfuCilHXC8j0yrN9KbZCfN+ukaabWg86UxzyHW0KE/YksjeN65/DK6RAFsRhmL0m3KoE0b18LojJ08+4PH0Iiw+08zJktQfw7hrF/ToHTorAM2CNtDRKadYOwVLiZYgIxpXeR1uKKSRPV8WVjsr+RqSMT0p6es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753272275; c=relaxed/simple;
	bh=tZtnr1t9b0UyyBWJF2pBQb3rRxn1BtGGkwNYgLCrcY0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q1QTOBDzkohl35ghyNn4Fm8bQwCRoHnLq/lsXF5s461B3F1uEZ6XR4rjBEe5lbBce/KT/nN6ab3ef3QWL9V2dllCTdIlCQZVdw3IFo9yIXbR0kq2sp5kz1PHN5Q2O+TiNcnIxtsioFpHWWSwg9OC0WDuRLDnwMgt1JD6jded/gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=j8YKL1qp; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-606aadc1433so1357660a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 05:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753272272; x=1753877072; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RfFmbru/LCAFgBCMPMUZ+BBCwsaXUjK95SJrm5H8vz8=;
        b=j8YKL1qpZLwQ/iFxlAwIgYUybHsGGV0BKUXbwb0EkmTSqritWfpfUYPRxKLNutuk8v
         oxVbg6ZyNt900Ofl/jPZCvJM6Iq8nwOvaSYeIP5jsUtYmdQYNEexgbcVT3Aw37nhK43H
         uIoXyWtVKKUVfzABhExF34oHtloAN3nXOfmoKn5A447VcLkormZj55YK46JXTOvdomj2
         xZqWZgnQDJT5hIC3WEQo3w8i2VH5pLQefygtSxD3XyF+f+Ke24butXF9/aQ6lzee237B
         RTy02C/bFyB7zsGviXfr0KD8UN4tiIh99QzCQcCSARa7NU4HWSnAvu9DlVZpbOde2SkV
         EMZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753272272; x=1753877072;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RfFmbru/LCAFgBCMPMUZ+BBCwsaXUjK95SJrm5H8vz8=;
        b=geWsoEjpWq4P+5PShsXMtQ7/rXsGIcWvsmIQ7b4C1UZP3SLkrSgaOGWj7IfxqpwnGr
         KrMx66B4dz1bvo58IV9jtYDLaVElDqeeyHsLqzhqvAHyCUWvVeBUqa17SgZkdTIb1H5J
         2aWibZsR4sGmDdC+EiqffuVB2Bdzq1uzoaF6gQb9zga6Pf+FOlSss1SlLUV7n9d74tX9
         aWEtuq3AoU3nxJYtEH8n6nSxIwxyEDZtLywQNBuwFHEf5tUB89CIgTOfnUCEz3FQ0nKI
         XojxnEncLHhkOrZah7ouE/EISuXcqGSVwNtxSu3ZLg3WwShYYO4RDC8SLeUbvN/oSl7b
         wIGw==
X-Forwarded-Encrypted: i=1; AJvYcCVB3vfG9iylyiINFRyPIbV2BR5vcWh7zkllwyhqFwm3/vq7vTUGqpBLK6Pa/bYlJfO2LycsYT6JUmAPJUo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywds+X36mzAnomM2JUAN1SS1Wqq7MwZVucD5nIaOfyCFlIV+eNL
	8MZdE1XkOdyaeRgdL6JnM6dUIlyJBw4bnE3W2DGq/dXwK/OZo996sLLF8ZR3O8QYzwc=
X-Gm-Gg: ASbGncs6yh93dp1JfhqEeufDGG13SVly0+EV3jB+2ziFt/ZbN9BO9LKeoINRAyLDaWY
	NOwXC+Ms4OyC16JXylLsNH8ThSu6rwhBCTXFP+9LPuLV+RzBRPK3a9jmAH5z8vg2qP1CV8Dv5hj
	bvY8g+7O4F4SvoCKIQH0vuVSdP1eYAGLDoLHPi6+kuDmbOKzw+ZYptcmThtvvpvWpd+rbr24/HX
	g4t+wW2tiCnsS1ht3NBY22yiATp/xzZg3Yo7VF7G06jooOh6cQpRV5a9D+K4Di/tD8v1Hwjj+LZ
	L9Os29GNcqBTFHnE62CNbYNvGtJl6j1zUIWPdy1xDxyJT0sn54rS5U6Av1VAOgcCeuyRH0n8mWZ
	zJVkniVq4IqFSUSo9IQpBtTI9REAMss93
X-Google-Smtp-Source: AGHT+IFp/yhow1yu8WxEFj4kLLF/zSyEkqWJuG1rRXxqxsP0ns2I8R6QZIpkgSUWEiIfNYQhI6nfEQ==
X-Received: by 2002:a05:6402:5256:b0:612:ce8b:8e1d with SMTP id 4fb4d7f45d1cf-6149b5afb99mr910771a12.10.1753272271408;
        Wed, 23 Jul 2025 05:04:31 -0700 (PDT)
Received: from kuoka.. ([178.197.203.90])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-612c90bb932sm8391470a12.67.2025.07.23.05.04.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 05:04:30 -0700 (PDT)
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
Subject: [PATCH RFC DO NOT MERGE] arm64: dts: qcom: sm8750-mtp: Add WiFi and Bluetooth
Date: Wed, 23 Jul 2025 14:04:28 +0200
Message-ID: <20250723120427.52874-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5199; i=krzysztof.kozlowski@linaro.org;
 h=from:subject; bh=tZtnr1t9b0UyyBWJF2pBQb3rRxn1BtGGkwNYgLCrcY0=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBogM/LXCYJpbCtSYtFUWvWkh/NaxRT6HqG6wP+s
 aY4feQMUl+JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaIDPywAKCRDBN2bmhouD
 1yE0D/4+Mhb6DPOTnylAUmuSnIfu3oPq9s7n6FoVE7B3Y8VFy2wwFZ5KlGwV55B5cw2GDLxigNg
 16Fimj6sYCHavBIDtesFPceXbPGwn6fLkKBZw0keoyfSPvMiIFsrskQlXN5quxL8QMSVcMP7eqq
 7cEt4zvuX/IcA3R8O/cXOVf7f1XS+ZWkVmP8LbwIuFPBAXYjZMBPQi8pgO+NlJ10K523O9uHvqd
 mOAu6OAkd4DtK1vU+5g3UuOW+6/r2U8A+yFETjOYBnPGYmaRSXGdQnW/NpT1m+uKuAK+2tOEUU3
 edoOUJz+K98QiZGmSjWe/AwG7rV01l5mKSz1SodZCfg4SouONJqpgMLeFnpMdj8AjHCJR75On7T
 Tds1InQlsWyZznZi1bgFhZuGpbogvQ4V6Vo8+p+9BEmyJcdFY4HzYl6PsLULnatRkwTt54xNTUn
 cdXxWq0ijR6pnBra9Y9puNdSkm2xkNTfC24jUzvYkC2oKCCcOXtU1bT9sYYdfVVkxYDagU+Ti/u
 cuhDMMsaa0IdHI+J8ZcVOyK+zaQlf88gRsp3pFpzQYFj7rPpLAsUoiam+5l4ijW9G18S2K4h2Xo
 /bGRV++x3MW+s94mJeZ6aHk5m0LMWvYJk7VPm07SzanFJWPQeXe5ZAOtPsOjyFyT8WFAdfvBcUm J9m8eI0Ozhls5ew==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit

MTP8750 rev 2.0 (power grid v8) boards come as two different variants
with different WiFi chips: WCN7850 and WCN786x.  WCN7850 is already
supported by the kernel, but WCN786x is not.  Both of the board variants
are considered newest revisions and the difference is only in MCN
numbers and internal codenames.

Add WCN7850 WiFi and Bluetooth to the MTP8750, stating that this DTS
represents the WCN7850 variant.  The S5F regulator should operate at
0.85 V, thus adjust lower constraint and its label.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Posting as RFC because it depends on unpublished PCI DTS patches thus it
cannot be merged/build.

Bluetooth not yet tested, because my user-space is incomplete.  I am
working on fixing this but anyway I don't expect issues since it is
exactly the same as previous SoCs.
---
 arch/arm64/boot/dts/qcom/sm8750-mtp.dts | 127 +++++++++++++++++++++++-
 1 file changed, 124 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8750-mtp.dts b/arch/arm64/boot/dts/qcom/sm8750-mtp.dts
index 5a94c14425dc..e142927f7e75 100644
--- a/arch/arm64/boot/dts/qcom/sm8750-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/sm8750-mtp.dts
@@ -254,6 +254,77 @@ vph_pwr: vph-pwr-regulator {
 		regulator-always-on;
 		regulator-boot-on;
 	};
+
+	/*
+	 * MTPs rev 2.0 (power grid v8) come with two different WiFi chips:
+	 * WCN7850 and WCN786x.
+	 * They use the same enable GPIOs and share (almost) the same supplies.
+	 * The WCN7850 supplies are superset of WCN786x variant.
+	 *
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
@@ -525,9 +596,9 @@ regulators-2 {
 
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
@@ -1051,6 +1122,23 @@ &pcie0_phy {
 	status = "okay";
 };
 
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
 
@@ -1186,6 +1274,14 @@ spkr_1_sd_n_active: spkr-1-sd-n-active-state {
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
 	disp0_reset_n_active: disp0-reset-n-active-state {
 		pins = "gpio98";
 		function = "gpio";
@@ -1221,6 +1317,31 @@ wcd_default: wcd-reset-n-active-state {
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


