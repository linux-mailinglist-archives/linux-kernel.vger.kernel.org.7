Return-Path: <linux-kernel+bounces-762689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73D68B209BD
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 15:11:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 869F91734BC
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 13:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C07D22D785;
	Mon, 11 Aug 2025 13:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fG4v4E7W"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466472DAFB3
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 13:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754917865; cv=none; b=V8zUu+8gek4c/pu/M+lGgipVfcpbbTwq1gxyh3fXAbBEFD8OZmy6H9if1d4+wKq8aDwfVahRZAj0cBbTSQYcbxn6tam4fI8NASZNusbz0j6+fDle6lFhoh+OwH3mnDF408adqmqqlNAgDdvSXVF5e/z+7IiTDhi8hKfD1GtbC8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754917865; c=relaxed/simple;
	bh=DgHbquI1ldhMOzME7c65t1MFr4ZHk8NPF4vihc+cKRs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Tx7p/z863N6n/pAOiQcLwQxHBewqVMdW3ePZCSx3gh78Uq6q2Bblmwvg73qIVxB7HVgw7pbdtM7rXgSx342IU/YmGajLK62HZ63zqJ8xP6MF7YTje/cHXaS0py8kW1kb7bhhYA0xj9AhzprbfTFIsw8Be2QoFGh9jUWG9Jz2Cuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fG4v4E7W; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-af92f13d27eso50389066b.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 06:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754917860; x=1755522660; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cxLWj8E73e/K4uSsXkDUscDbVL9WiPaJ2wWE0qh/QPk=;
        b=fG4v4E7W0h+U8Y9GBpMAWsn4nrFGHGZabHev3oY3YIN/RBORoAdgrzeCD2sIJte5lf
         Dsb6JsryiyMvNH94SQANU9TGNV+d1RsNiv0XWq95gQ7SEjKYywCb29ibpIJpZTbizdq8
         7XVExXhRKnmq9NFNsZYAb1t1uWhcHglUFj42lazkugjeAVP8ushZwD0wOsr2JyWG3Lce
         Cqa+Dvkqd1MIL7DUeTdwM5fOa7uPuoN7oBRi19Orf6fca5Jbux8bZ/NmH4FPDqQWTPdx
         cOkS2q6GN6fBfAbpuOYDA8cdxlbfZHoVACbWSsv974h+fOyuu3yJyuJxiWFIeTDr8+bi
         43hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754917860; x=1755522660;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cxLWj8E73e/K4uSsXkDUscDbVL9WiPaJ2wWE0qh/QPk=;
        b=XfhTUSyJS5rkIKyESEQha5wNxb3hNipTsb+Ejbn6TFqPT8JtMo+MQkAi1QXuMthMUC
         c5sQVCZgNx8KrQOT+iQHQ8AemivP2oUqg6wj+xE8OPfxYUqabJpm4ERi52Fr+K6aDJXb
         DININfrVe6ySNSNEZg7RPC0wFTY3/ENgTGQAb0mV3PoZLf5hiHXVZR6WlvXNF8fryb3d
         8jVX8GpvJLX2tEXN8hKeYxZ2cneR3tBWl3OyEm+ubhFRTaiM+u8fcvG9nM4RH26Fv62E
         7Wf6GYzFnNTGhhjv4Pf/2PMu4m3YNImZI3w9nAKR93nM4TDqNHF+jemAFblbZqR6QQyW
         tY3Q==
X-Forwarded-Encrypted: i=1; AJvYcCUdTDe7Fvt6GSQw6t/jwwtnK8HIwK311QhjDHYfQnMtb1JvcQBs2/tTecqUKWO1bZ3KZjOMouaDlqzp0GE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz46h1TRNYH2QW4LDvaG/qJ+Mrn3J8Bj1Dr3ofRzPCF/j3GyHbS
	X41CNdfuFQvGmRPTNgS3nNUheueM87jDv68XH+ABpKLNGDDsBWgna93lnENBRzEr01E=
X-Gm-Gg: ASbGncupV7ZFJ5qc3U/ksQDCsTXsxeMLvttmrwIZjq4vd8maf5AKx9X+Bt3+IDKSwGe
	ghE3qOvMi2ItA7m+y0yvsV2ty/Rw1H6ihETAaT0orEz1ZPnF8FHPixJmHtSeVpVV/4W83dmN/i4
	wJVYx4YgVUmZbXSdKZooNaILNROq7HCxYSTeCu6i5DXkiQuzbYbrTQu2ZPxSwuw471uH1pVxBxO
	aO7mK7uA4zaPJGqeqyxyBownnQ0lxRWpE4VTq4YN4rc7af7usjR7+8AXx9xWWlnE+QlBszKG9dG
	E4vc5mpmyS0+x2YUDaPpDqls+hnw2r7dJrnjc1TL5eIxr228Yu9h54iotZ7w0CuZafcPqD7UP/N
	H9dk2wDaY3cHQ4ixN6jDkgFRQc+Cjqbpozg==
X-Google-Smtp-Source: AGHT+IGPQgnQuuV1mDaRrL+GZJNlWxDGegyZBsOzS01XuMBg5rSaflPh/dQVNfUtdWimAua5yq5P8Q==
X-Received: by 2002:a17:906:c114:b0:ae3:bd92:e6aa with SMTP id a640c23a62f3a-af9deaeae67mr340461566b.6.1754917860503;
        Mon, 11 Aug 2025 06:11:00 -0700 (PDT)
Received: from kuoka.. ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a23fd00sm2008336466b.122.2025.08.11.06.10.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 06:10:59 -0700 (PDT)
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
Subject: [RFC PATCH v2] arm64: dts: qcom: sm8750-mtp: Add WiFi and Bluetooth
Date: Mon, 11 Aug 2025 15:10:56 +0200
Message-ID: <20250811131055.154233-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5650; i=krzysztof.kozlowski@linaro.org;
 h=from:subject; bh=DgHbquI1ldhMOzME7c65t1MFr4ZHk8NPF4vihc+cKRs=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBomevggI1Hwh1Xund/028jbpLP55dOyeUOm2tA2
 XWveOru7fyJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaJnr4AAKCRDBN2bmhouD
 1wJ1D/0Sa2QzQbam67+9OciXZitHMyFsww+tm/oFCVu4TE/pcaZ0C3/enChUyNmvwFmf6InoPUd
 QycYMHD1DVSZk9pBnIQ8oqrFkn//MDUo9EmVAUjnQffYks02HrvCP1gAwUzUHTQog+cOD7hRB0r
 bdg9moUZ+4eKKX2JAG4frggqOdhbc78HO9y9Vav78hLvA4IBz7+dJpO81LUwXDHUbTi8ykl6I07
 C7cUgsE/3lfVdXfDHdbz4Pee175AjH3bLEPSYitFt0NPlo79TwtSLCYHy/3QAdt+rlSYx+ZKK5n
 tkoQqYPR15vKJA1JdtQaNfEDlexaPbvoZhh+SiiIUyjF+XotwjlV0RPmhjmv372G4L6Kx2HXP0b
 8qoW7SKyQGFIHlCJ/fHUtcgL65TISLCjfmMjeSRMfYYnzPuzI9EzZQ6z75R3KZM78dnKNEz7ext
 IrA95AkM+GafGlhi7xPwn4ToU9wJ0QWfVU0I6T5gGJ3DW1P7wZ9I2htilwq0o2+zHmC6J4WuEnG
 bU/NagZ5jL32KT8XbmxupJ9AZ1b46UveAGwXetmjiexaNI2v/6nL1sWuXlVGL7fW3tMke6fmV8e
 T1aIL7fK2EnLs1oI6w1TQJfVj1FIoIUTCumBxETcBmmbCOHqQmV8rT86qWeUQn80/3EFS3Qfkaw J6QErp6rWcxPfnA==
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

Posting as RFC because it depends on unpublished PCI DTS patches thus it
cannot be merged/build.

Changes in v2:
1. Add missing &qupv3_2 enable, so Bluetooth works.
2. Adjust also S4D regulator constraint.
---
 arch/arm64/boot/dts/qcom/sm8750-mtp.dts | 133 +++++++++++++++++++++++-
 1 file changed, 129 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8750-mtp.dts b/arch/arm64/boot/dts/qcom/sm8750-mtp.dts
index 57ab028beef4..c25ef6cad9f6 100644
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
@@ -479,7 +550,7 @@ vreg_s3d_1p2: smps3 {
 
 		vreg_s4d_0p85: smps4 {
 			regulator-name = "vreg_s4d_0p85";
-			regulator-min-microvolt = <500000>;
+			regulator-min-microvolt = <852000>;
 			regulator-max-microvolt = <1036000>;
 			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
 		};
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
@@ -1047,6 +1118,23 @@ &pcie0_phy {
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
 
@@ -1063,6 +1151,10 @@ &qupv3_1 {
 	status = "okay";
 };
 
+&qupv3_2 {
+	status = "okay";
+};
+
 &remoteproc_adsp {
 	firmware-name = "qcom/sm8750/adsp.mbn",
 			"qcom/sm8750/adsp_dtb.mbn";
@@ -1182,6 +1274,14 @@ spkr_1_sd_n_active: spkr-1-sd-n-active-state {
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
@@ -1217,6 +1317,31 @@ wcd_default: wcd-reset-n-active-state {
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


