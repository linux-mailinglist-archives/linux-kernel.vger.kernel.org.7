Return-Path: <linux-kernel+bounces-864170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D84D9BFA16F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 07:42:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B45554858E1
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 05:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68DA92F066D;
	Wed, 22 Oct 2025 05:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="WHR57tZ9";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="Z9nI3Omf"
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 320602ECD11;
	Wed, 22 Oct 2025 05:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761111672; cv=none; b=drbgHuDhWabK+ex0y04ML3yDD9/8/I0RPrTz0jyoV6aeLr8zEEau7nfRCLh+lkg/l0ADCCqEnjzIbz6etjf6xyPlsEU6pKCziNC+4aZY6aIjIA70VVBUh9IBzvUopr14Ezwo6iaNGUVy0mFEPIxoIkqsIXe6s2OHvv5dy97etkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761111672; c=relaxed/simple;
	bh=+X4TPBH0WyY4hRud1auR4fdOvPuQFnF33f5Yo/ePtbI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O2YMUW4d+LIEsYDDjoKXBocRXvLFbarW6XBqW/UAV/ddqabP/FQopJd3OjJAh1uKrpeHcPRK7FkIVHgCaVVtUSu1ADYvK30JR8j356B9/Se5hyaGLPV7KfjFcLeKAbha1vL6D3G9JCydlItwE3Efvb3ds2hcOb5tmj2ZDSO3XQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=WHR57tZ9; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=Z9nI3Omf; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1761111652; bh=VzcTSEXcoPEUdVfkEfXH82M
	yzhdOXCpjYXwU3FNqgWc=; b=WHR57tZ95dTpRfIBQpRhKZ5SauJxqGYeoQfYxGyc+EULRZbyw6
	8STCSmJH6b0eA1nKtc3mSqNSTd1u5yHld1YPw0WDSzQdkbletrhcDbgC+cM749mtejoq/mcIWKs
	MBRAUDqSfWMyJiG5i1hJO6ReVpf5yuoGZxC02mYeMsz+fZRZZUP0KKx3cZPS1QHIITwGiWUXE/L
	0I14qZ1h8CgBqcf7EJZkA2ZMaaTKx3WSy6rWxIlWyZGCJJ5StjXjXSQ5ERK3N7aEMEbn0LCT8Q4
	nee7EQHW0T11QFbxbiOBKHHJcpsXi+IyZWTuizrxKvrHlob7w7Pxe8pgr9qepF+dUmg==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1761111652; bh=VzcTSEXcoPEUdVfkEfXH82M
	yzhdOXCpjYXwU3FNqgWc=; b=Z9nI3Omf7w25UaswPRdXhkNksbPwKiJg5bkWlfJcIVAMrk6E82
	maFVKVN3Ov+IqbSwKe98KWyY4EBCtt9dfLCg==;
From: Piyush Raj Chouhan <pc1598@mainlining.org>
To: linux-arm-msm@vger.kernel.org
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	andersson@kernel.org,
	konradybcio@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	tony.luck@intel.com,
	gpiccoli@igalia.com,
	Piyush Raj Chouhan <pc1598@mainlining.org>
Subject: [PATCH 2/2] arm64: dts: qcom: sm8150: Add support for Xiaomi Redmi K20 Pro
Date: Wed, 22 Oct 2025 11:10:24 +0530
Message-ID: <20251022054026.22816-2-pc1598@mainlining.org>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251022054026.22816-1-pc1598@mainlining.org>
References: <20251022054026.22816-1-pc1598@mainlining.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add initial device tree support for the Xiaomi Redmi K20 Pro/ Xiaomi Mi 9T Pro
(codename raphael), based on the Qualcomm SM8150 (Snapdragon 855)
platform.

The supported features include:
- Display (Samsung AMS639RQ08 AMOLED panel)
- UFS storage
- USB Type-C (with role switching, High-Speed only)
- PMIC regulators (PM8150, PM8150L, PM8150B)
- GPIO keys (volume up, volume down, power)
- Remoteprocs (ADSP, CDSP, MPSS)
- Adreno 640 GPU with GMU
- WCN3990 WiFi
- Camera flash LEDs

Signed-off-by: Piyush Raj Chouhan <pc1598@mainlining.org>
---
 arch/arm64/boot/dts/qcom/Makefile             |   1 +
 .../boot/dts/qcom/sm8150-xiaomi-raphael.dts   | 995 ++++++++++++++++++
 2 files changed, 996 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/sm8150-xiaomi-raphael.dts

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index 296688f7cb26..d2b673d2625c 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -279,6 +279,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sm8150-microsoft-surface-duo.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm8150-mtp.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm8150-sony-xperia-kumano-bahamut.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm8150-sony-xperia-kumano-griffin.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= sm8150-xiaomi-raphael.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm8250-hdk.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm8250-mtp.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm8250-samsung-r8q.dtb
diff --git a/arch/arm64/boot/dts/qcom/sm8150-xiaomi-raphael.dts b/arch/arm64/boot/dts/qcom/sm8150-xiaomi-raphael.dts
new file mode 100644
index 000000000000..9ff938b61a31
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sm8150-xiaomi-raphael.dts
@@ -0,0 +1,995 @@
+// SPDX-License-Identifier: BSD-3-Clause
+
+/*
+ * Copyright (c) 2025, Piyush Raj Chouhan <pc1598@mainlining.org>.
+ */
+
+/dts-v1/;
+
+#include <dt-bindings/arm/qcom,ids.h>
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/leds/common.h>
+#include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
+#include <dt-bindings/regulator/qcom,rpmh-regulator.h>
+#include <dt-bindings/usb/pd.h>
+#include "sm8150.dtsi"
+#include "pm8150.dtsi"
+#include "pm8150b.dtsi"
+#include "pm8150l.dtsi"
+
+/* 
+ * Rewrite reserved memory maps inherited from sm8150.dtsi to match the ones
+ * used on xiaomi-raphael.
+ * Note: this list is ordered by its memory address in sm8150.dtsi.
+ */
+/delete-node/ &tz_mem;      /* same address but larger, no place for rmtfs_mem! */
+/delete-node/ &rmtfs_mem;   /* moved to completely different address */
+/delete-node/ &adsp_mem;    /* same start address, but larger size */
+/delete-node/ &mpss_mem;    /* same size, shifted higher, due to larger adsp_mem */
+/delete-node/ &venus_mem;   /* same size, shifted higher */
+/delete-node/ &slpi_mem;    /* same size, shifted higher */
+/delete-node/ &ipa_fw_mem;  /* same size, shifted higher */
+/delete-node/ &ipa_gsi_mem; /* same size, shifted higher */
+/delete-node/ &gpu_mem;     /* same size, shifted higher */
+/delete-node/ &spss_mem;    /* same size, shifted higher */
+/delete-node/ &cdsp_mem;    /* same size, shifted higher */
+
+/ {
+	model = "Xiaomi Redmi K20 Pro";
+	compatible = "xiaomi,raphael", "qcom,sm8150";
+	qcom,msm-id = <QCOM_ID_SM8150 0x20000>; /* SM8150 v2 */
+	qcom,board-id = <0x28008 0>;
+	chassis-type = "handset";
+
+	aliases {
+		serial0 = &uart2;
+		wifi0 = &wifi;
+	};
+
+	chosen {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		stdout-path = "serial0:115200n8";
+
+		framebuffer: framebuffer@9c000000 {
+			compatible = "simple-framebuffer";
+			reg = <0 0x9c000000 0 (1080 * 2340 * 4)>;
+			width = <1080>;
+			height = <2340>;
+			stride = <(1080 * 4)>;
+			format = "a8r8g8b8";
+			display = <&panel>;
+			clocks = <&gcc GCC_DISP_HF_AXI_CLK>;
+		};
+	};
+
+	disp_vci_vreg: disp-vci-vreg {
+		compatible = "regulator-fixed";
+		regulator-name = "disp_vci_vreg";
+		regulator-boot-on;
+		enable-active-high;
+		gpio = <&tlmm 99 GPIO_ACTIVE_HIGH>;
+	};
+
+	vreg_ibb: regulator-ibb {
+		compatible = "regulator-fixed";
+		regulator-name = "ibb";
+		regulator-min-microvolt = <6000000>;
+		regulator-max-microvolt = <6000000>;
+	};
+
+	vreg_lab: regulator-lab {
+		compatible = "regulator-fixed";
+		regulator-name = "lab";
+		regulator-min-microvolt = <6000000>;
+		regulator-max-microvolt = <6000000>;
+	};
+
+	reserved-memory {
+		tz_mem: memory@86200000 {
+			reg = <0x0 0x86200000 0x0 0x5500000>;
+			no-map;
+		};
+
+		adsp_mem: memory@8be00000 {
+			reg = <0x0 0x8be00000 0x0 0x2200000>;
+			no-map;
+		};
+
+		mpss_mem: memory@8e000000 {
+			reg = <0x0 0x8e000000 0x0 0x9600000>;
+			no-map;
+		};
+
+		venus_mem: memory@97600000 {
+			reg = <0x0 0x97600000 0x0 0x500000>;
+			no-map;
+		};
+
+		slpi_mem: memory@97b00000 {
+			reg = <0x0 0x97b00000 0x0 0x1400000>;
+			no-map;
+		};
+
+		ipa_fw_mem: memory@98f00000 {
+			reg = <0x0 0x98f00000 0x0 0x10000>;
+			no-map;
+		};
+
+		ipa_gsi_mem: memory@98f10000 {
+			reg = <0x0 0x98f10000 0x0 0x5000>;
+			no-map;
+		};
+
+		gpu_mem: memory@98f15000 {
+			reg = <0x0 0x98f15000 0x0 0x2000>;
+			no-map;
+		};
+
+		spss_mem: memory@99000000 {
+			reg = <0x0 0x99000000 0x0 0x100000>;
+			no-map;
+		};
+
+		cdsp_mem: memory@99100000 {
+			reg = <0x0 0x99100000 0x0 0x1400000>;
+			no-map;
+		};
+
+		cont_splash_mem: memory@9c000000 {
+			reg = <0x0 0x9c000000 0x0 0x2400000>;
+			no-map;
+		};
+
+		cdsp_sec_mem: memory@a4c00000 {
+			reg = <0x0 0xa4c00000 0x0 0x3c00000>;
+			no-map;
+		};
+
+		ramoops@a1600000 {
+			compatible = "ramoops";
+			reg = <0x0 0xa1600000 0x0 0x800000>;
+			console-size = <0x400000>;
+			pmsg-size = <0x200000>;
+			record-size = <0>;
+			ftrace-size = <0>;
+			ecc-size = <0>;
+			no-map;
+		};
+
+		rmtfs_mem: memory@fe101000 {
+			compatible = "qcom,rmtfs-mem";
+			reg = <0 0xfe101000 0 0x300000>;
+			qcom,client-id = <1>;
+			qcom,vmid = <15>;
+			no-map;
+		};
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+		pinctrl-names = "default";
+		pinctrl-0 = <&vol_up_n>;
+
+		key-vol-up {
+			label = "Volume Up";
+			linux,code = <KEY_VOLUMEUP>;
+			gpios = <&pm8150_gpios 6 GPIO_ACTIVE_LOW>;
+		};
+	};
+
+	vph_pwr: vph-pwr-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "vph_pwr";
+		regulator-min-microvolt = <3700000>;
+		regulator-max-microvolt = <3700000>;
+	};
+
+	/*
+	 * Apparently RPMh does not provide support for PM8150 S4 because it
+	 * is always-on; model it as a fixed regulator.
+	 */
+	vreg_s4a_1p8: pm8150-s4 {
+		compatible = "regulator-fixed";
+		regulator-name = "vreg_s4a_1p8";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		regulator-always-on;
+		regulator-boot-on;
+		vin-supply = <&vph_pwr>;
+	};
+};
+
+&apps_rsc {
+	regulators-0 {
+		compatible = "qcom,pm8150-rpmh-regulators";
+		qcom,pmic-id = "a";
+
+		vdd-s1-supply = <&vph_pwr>;
+		vdd-s2-supply = <&vph_pwr>;
+		vdd-s3-supply = <&vph_pwr>;
+		vdd-s4-supply = <&vph_pwr>;
+		vdd-s5-supply = <&vph_pwr>;
+		vdd-s6-supply = <&vph_pwr>;
+		vdd-s7-supply = <&vph_pwr>;
+		vdd-s8-supply = <&vph_pwr>;
+		vdd-s9-supply = <&vph_pwr>;
+		vdd-s10-supply = <&vph_pwr>;
+
+		vdd-l1-l8-l11-supply = <&vreg_s6a_0p9>;
+		vdd-l2-l10-supply = <&vreg_bob>;
+		vdd-l3-l4-l5-l18-supply = <&vreg_s6a_0p9>;
+		vdd-l6-l9-supply = <&vreg_s8c_1p3>;
+		vdd-l7-l12-l14-l15-supply = <&vreg_s5a_2p0>;
+		vdd-l13-l16-l17-supply = <&vreg_bob>;
+
+		vreg_s5a_2p0: smps5 {
+			regulator-min-microvolt = <1904000>;
+			regulator-max-microvolt = <2000000>;
+		};
+
+		vreg_s6a_0p9: smps6 {
+			regulator-min-microvolt = <920000>;
+			regulator-max-microvolt = <1128000>;
+		};
+
+		vdda_wcss_pll:
+		vreg_l1a_0p75: ldo1 {
+			regulator-min-microvolt = <752000>;
+			regulator-max-microvolt = <752000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vdd_pdphy:
+		vdda_usb_hs_3p1:
+		vreg_l2a_3p1: ldo2 {
+			regulator-min-microvolt = <3072000>;
+			regulator-max-microvolt = <3072000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l3a_0p8: ldo3 {
+			regulator-min-microvolt = <480000>;
+			regulator-max-microvolt = <932000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		/*
+		 * L4A supplies VDD_LPI_MX_* (VDD_LPI_MX_A_1). Board label: vreg_l4a_0p75.
+		 * PM8150 device spec: L4A nominal = 0.816 V, active min = 0.752 V, active max = 0.904 V,
+		 * IRATED = 300 mA. If the board programs L4A to ~0.752 V, keep min=752000 and max=816000.
+		 */
+		vreg_l4a_0p75: ldo4 {
+			regulator-min-microvolt = <752000>;
+			regulator-max-microvolt = <816000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vdd_usb_hs_core:
+		vdda_mipi_csi_0_0p9:
+		vdda_mipi_csi_1_0p9:
+		vdda_mipi_csi_2_0p9:
+		vdda_mipi_csi_3_0p9:
+		vdda_mipi_dsi_0_0p9:
+		vdda_mipi_dsi_1_0p9:
+		vdda_mipi_dsi_0_pll_0p9:
+		vdda_mipi_dsi_1_pll_0p9:
+		vdda_pcie_1ln_core:
+		vdda_pcie_2ln_core:
+		vdda_pll_hv_cc_ebi01:
+		vdda_pll_hv_cc_ebi23:
+		vdda_qrefs_0p875_5:
+		vdda_sp_sensor:
+		vdda_ufs_2ln_core_1:
+		vdda_ufs_2ln_core_2:
+		vdda_qlink_lv:
+		vdda_qlink_lv_ck:
+		vreg_l5a_0p875: ldo5 {
+			regulator-min-microvolt = <880000>;
+			regulator-max-microvolt = <880000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l6a_1p2: ldo6 {
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1200000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l7a_1p8: ldo7 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		/*
+		 * PM8150 LDO8 (L8A) — supplies vreg_l8a_0p75
+		 * Device spec: nominal 0.752 V, active min 0.752 V, active max 0.904 V, IRATED = 300 mA
+		 */
+		vreg_l8a_0p75: ldo8 {
+			regulator-min-microvolt = <752000>;
+			regulator-max-microvolt = <816000>;
+		};
+
+		vddpx_10:
+		vreg_l9a_1p2: ldo9 {
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1200000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l10a_2p95: ldo10 {
+			regulator-min-microvolt = <2950000>;
+			regulator-max-microvolt = <2960000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l11a_0p8: ldo11 {
+			regulator-min-microvolt = <800000>;
+			regulator-max-microvolt = <800000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vdd_qfprom:
+		vdd_qfprom_sp:
+		vdda_apc_cs_1p8:
+		vdda_gfx_cs_1p8:
+		vdda_usb_hs_1p8:
+		vdda_qrefs_vref_1p8:
+		vddpx_10_a:
+		vreg_l12a_1p8: ldo12 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l13a_2p7: ldo13 {
+			regulator-min-microvolt = <2704000>;
+			regulator-max-microvolt = <2704000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l14a_1p8: ldo14 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1880000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l15a_1p7: ldo15 {
+			regulator-min-microvolt = <1704000>;
+			regulator-max-microvolt = <1704000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l16a_2p7: ldo16 {
+			regulator-min-microvolt = <2704000>;
+			regulator-max-microvolt = <2960000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l17a_3p0: ldo17 {
+			regulator-min-microvolt = <2856000>;
+			regulator-max-microvolt = <3008000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l18a_1p05: ldo18 {
+			regulator-min-microvolt = <800000>;
+			regulator-max-microvolt = <800000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+	};
+
+	regulators-1 {
+		compatible = "qcom,pm8150l-rpmh-regulators";
+		qcom,pmic-id = "c";
+
+		vdd-s1-supply = <&vph_pwr>;
+		vdd-s2-supply = <&vph_pwr>;
+		vdd-s3-supply = <&vph_pwr>;
+		vdd-s4-supply = <&vph_pwr>;
+		vdd-s5-supply = <&vph_pwr>;
+		vdd-s6-supply = <&vph_pwr>;
+		vdd-s7-supply = <&vph_pwr>;
+		vdd-s8-supply = <&vph_pwr>;
+
+		vdd-l1-l8-supply = <&vreg_s4a_1p8>;
+		vdd-l2-l3-supply = <&vreg_s8c_1p3>;
+		vdd-l4-l5-l6-supply = <&vreg_bob>;
+		vdd-l7-l11-supply = <&vreg_bob>;
+		vdd-l9-l10-supply = <&vreg_bob>;
+
+		vdd-bob-supply = <&vph_pwr>;
+		vdd-flash-supply = <&vreg_bob>;
+		vdd-rgb-supply = <&vreg_bob>;
+
+		vreg_bob: bob {
+			regulator-min-microvolt = <3008000>;
+			regulator-max-microvolt = <4000000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_AUTO>;
+			regulator-allow-bypass;
+		};
+
+		vreg_s8c_1p3: smps8 {
+			regulator-min-microvolt = <1352000>;
+			regulator-max-microvolt = <1352000>;
+		};
+
+		vreg_l1c_1p8: ldo1 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vdda_wcss_adcdac_1:
+		vdda_wcss_adcdac_22:
+		vreg_l2c_1p3: ldo2 {
+			regulator-min-microvolt = <1304000>;
+			regulator-max-microvolt = <1304000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vdda_hv_ebi0:
+		vdda_hv_ebi1:
+		vdda_hv_ebi2:
+		vdda_hv_ebi3:
+		vdda_hv_refgen0:
+		vdda_mipi_dsi0_1p2:
+		vdda_qlink_hv_ck:
+		vreg_l3c_1p2: ldo3 {
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1200000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vddpx_5:
+		vreg_l4c_1p8: ldo4 {
+			regulator-min-microvolt = <1704000>;
+			regulator-max-microvolt = <2928000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vddpx_6:
+		vreg_l5c_1p8: ldo5 {
+			regulator-min-microvolt = <1704000>;
+			regulator-max-microvolt = <2928000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vddpx_2:
+		vreg_l6c_2p9: ldo6 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <2960000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l7c_3p0: ldo7 {
+			regulator-min-microvolt = <2856000>;
+			regulator-max-microvolt = <3104000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l8c_1p8: ldo8 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l9c_2p9: ldo9 {
+			regulator-min-microvolt = <2704000>;
+			regulator-max-microvolt = <2960000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l10c_3p3: ldo10 {
+			regulator-min-microvolt = <3000000>;
+			regulator-max-microvolt = <3312000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l11c_3p3: ldo11 {
+			regulator-min-microvolt = <3000000>;
+			regulator-max-microvolt = <3312000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+	};
+};
+
+&gmu {
+	status = "okay";
+};
+
+&gpi_dma2 {
+	status = "okay";
+};
+
+&gpu {
+	zap-shader {
+		memory-region = <&gpu_mem>;
+		firmware-name = "qcom/sm8150/xiaomi/raphael/a640_zap.mbn";
+	};
+
+	status = "okay";
+};
+
+&i2c19 {
+	/* goodix,gt9886 @5d  */
+};
+
+&mdss {
+	status = "okay";
+};
+
+&mdss_dsi0 {
+	vdda-supply = <&vdda_mipi_dsi0_1p2>;
+
+	status = "okay";
+	panel: panel@0 {
+		compatible = "samsung,ams639rq08";
+		reg = <0>;
+
+		vddio-supply = <&vreg_l14a_1p8>;
+		vdd3p3-supply = <&disp_vci_vreg>;
+		vsn-supply = <&vreg_ibb>;
+		vsp-supply = <&vreg_lab>;
+
+		reset-gpios = <&tlmm 6 GPIO_ACTIVE_LOW>;
+
+		pinctrl-names = "default", "sleep";
+		pinctrl-0 = <&panel_reset_pin &panel_te_pin>;
+
+		status = "okay";
+		port {
+			panel_in: endpoint {
+				remote-endpoint = <&mdss_dsi0_out>;
+			};
+		};
+	};
+};
+
+&mdss_dsi0_out {
+	data-lanes = <0 1 2 3>;
+	remote-endpoint = <&panel_in>;
+};
+
+&mdss_dsi0_phy {
+	vdds-supply = <&vreg_l5a_0p875>;
+
+	status = "okay";
+};
+
+&pm8150_gpios {
+	vol_up_n: vol-up-n-state {
+		pins = "gpio6";
+		function = PMIC_GPIO_FUNC_NORMAL;
+		input-enable;
+		bias-pull-up;
+	};
+};
+
+&pm8150b_typec {
+	vdd-vbus-supply = <&pm8150b_vbus>;
+	vdd-pdphy-supply = <&vdda_usb_hs_3p1>;
+
+	status = "okay";
+	connector {
+		compatible = "usb-c-connector";
+		power-role = "source";
+		data-role = "dual";
+		self-powered;
+
+		source-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_DUAL_ROLE |
+					 PDO_FIXED_USB_COMM | PDO_FIXED_DATA_SWAP)>;
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+
+				pm8150b_hs_in: endpoint {
+					remote-endpoint = <&usb_1_dwc3_hs>;
+				};
+			};
+		};
+	};
+};
+
+&pm8150b_vbus {
+	regulator-min-microamp = <500000>;
+	regulator-max-microamp = <3000000>;
+
+	status = "okay";
+};
+
+&pm8150l_flash {
+
+	status = "okay";
+	led-1 {
+		function = LED_FUNCTION_FLASH;
+		color = <LED_COLOR_ID_WHITE>;
+		led-sources = <1>;
+		led-max-microamp = <150000>;
+		flash-max-microamp = <1000000>;
+		flash-max-timeout-us = <1280000>;
+	};
+
+	led-2 {
+		function = LED_FUNCTION_FLASH;
+		color = <LED_COLOR_ID_YELLOW>;
+		led-sources = <2>;
+		led-max-microamp = <150000>;
+		flash-max-microamp = <1000000>;
+		flash-max-timeout-us = <1280000>;
+	};
+};
+
+&pm8150l_lpg {
+
+	status = "okay";
+	led@1 {
+		reg = <1>;
+		color = <LED_COLOR_ID_WHITE>;
+		function = LED_FUNCTION_STATUS;
+
+		status = "disabled";
+	};
+
+	led@2 {
+		reg = <2>;
+		color = <LED_COLOR_ID_RED>;
+		function = LED_FUNCTION_STATUS;
+		function-enumerator = <0>;
+	};
+
+	led@3 {
+		reg = <3>;
+		color = <LED_COLOR_ID_RED>;
+		function = LED_FUNCTION_STATUS;
+		function-enumerator = <1>;
+	};
+};
+
+&pm8150l_wled {
+	qcom,num-strings = <3>;
+	qcom,cabc;
+	qcom,cabc-sel = <1>;
+};
+
+&pon {
+	mode-bootloader = <0x2>;
+	mode-recovery = <0x1>;
+};
+
+&pon_pwrkey {
+	status = "okay";
+};
+
+&pon_resin {
+	linux,code = <KEY_VOLUMEDOWN>;
+
+	status = "okay";
+};
+
+&qupv3_id_1 {
+	status = "okay";
+};
+
+&qupv3_id_2 {
+	status = "okay";
+};
+
+&remoteproc_adsp {
+	firmware-name = "qcom/sm8150/xiaomi/raphael/adsp.mbn";
+
+	status = "okay";
+};
+
+&remoteproc_cdsp {
+	firmware-name = "qcom/sm8150/xiaomi/raphael/cdsp.mbn";
+
+	status = "okay";
+};
+
+&remoteproc_mpss {
+	firmware-name = "qcom/sm8150/xiaomi/raphael/modem.mbn";
+
+	status = "okay";
+};
+
+&remoteproc_slpi {
+	firmware-name = "qcom/sm8150/xiaomi/raphael/slpi.mbn";
+
+	status = "disabled";
+};
+
+&tlmm {
+	gpio-line-names =
+		"NFC_ESE_SPI_MISO",     /* GPIO_0 */
+		"NFC_ESE_SPI_MOSI",     /* GPIO_1 */
+		"NFC_ESE_SPI_CLK",      /* GPIO_2 */
+		"NFC_ESE_SPI_CS_N",     /* GPIO_3 */
+		"LCD_ID_DET1",          /* GPIO_4 */
+		"ERR_INT",              /* GPIO_5 */
+		"LCD_RESET_N",          /* GPIO_6 */
+		"",                     /* GPIO_7 */
+		"MDP_VSYNC_P",          /* GPIO_8 */
+		"MOTOR_DIR",            /* GPIO_9 */
+		"LASER_CE",             /* GPIO_10 */
+		"DIGITAL_HALL1_RSTN",   /* GPIO_11 */
+		"CAMF_RSTN",            /* GPIO_12 */
+		"CAMW_MCLK0",           /* GPIO_13 */
+		"CAMT_MCLK1",           /* GPIO_14 */
+		"CAMF_MCLK2",           /* GPIO_15 */
+		"CAMU_MCLK3",           /* GPIO_16 */
+		"CCI_I2C_SDA0",         /* GPIO_17 */
+		"CCI_I2C_SCL0",         /* GPIO_18 */
+		"CCI_I2C_SDA1",         /* GPIO_19 */
+		"CCI_I2C_SCL1",         /* GPIO_20 */
+		"MOTOR_M0",             /* GPIO_21 */
+		"FL_STROBE_TRIG",       /* GPIO_22 */
+		"CAMU_RSTN",            /* GPIO_23 */
+		"",                     /* GPIO_24 */
+		"",                     /* GPIO_25 */
+		"LASER_IRQ",            /* GPIO_26 */
+		"DIGITAL_HALL1_INT",    /* GPIO_27 */
+		"CAMW_RSTN",            /* GPIO_28 */
+		"",                     /* GPIO_29 */
+		"CAMT_RSTN",            /* GPIO_30 */
+		"CCI_I2C_SDA2",         /* GPIO_31 */
+		"CCI_I2C_SCL2",         /* GPIO_32 */
+		"MOTOR_M1",             /* GPIO_33 */
+		"CAMU_LDO_EN",          /* GPIO_34 */
+		"MOTOR_SLEEP",          /* GPIO_35 */
+		"MOTOR_FAULT",          /* GPIO_36 */
+		"FOD_SPI_RST",          /* GPIO_37 */
+		"USB_CC_DIR",           /* GPIO_38 */
+		"NFC_I2C_SDA",          /* GPIO_39 */
+		"NFC_I2C_SCL",          /* GPIO_40 */
+		"",                     /* GPIO_41 */
+		"",                     /* GPIO_42 */
+		"BT_HCI_UART_CTS_N",    /* GPIO_43 */
+		"BT_HCI_UART_RFR_N",    /* GPIO_44 */
+		"BT_HCI_UART_TXD",      /* GPIO_45 */
+		"BT_HCI_UART_RXD",      /* GPIO_46 */
+		"NFC_IRQ",              /* GPIO_47 */
+		"NFC_DWL_REQ",          /* GPIO_48 */
+		"AUDIO_SWITCH_EN",      /* GPIO_49 */
+		"WLAN_SW_CTRL",         /* GPIO_50 */
+		"APPS_I2C_SDA",         /* GPIO_51 */
+		"APPS_I2C_SCL",         /* GPIO_52 */
+		"",                     /* GPIO_53 */
+		"TP_RESET_N",           /* GPIO_54 */
+		"",                     /* GPIO_55 */
+		"",                     /* GPIO_56 */
+		"TP_I2C_SDA",           /* GPIO_57 */
+		"TP_I2C_SCL",           /* GPIO_58 */
+		"SPKR_PA_RST",          /* GPIO_59 */
+		"",                     /* GPIO_60 */
+		"QLINK_REQUEST",        /* GPIO_61 */
+		"QLINK_ENABLE",         /* GPIO_62 */
+		"WMSS_RESET_N",         /* GPIO_63 */
+		"SDM_GRFC_8",           /* GPIO_64 */
+		"SDM_GRFC_9",           /* GPIO_65 */
+		"SDM_GRFC_10",          /* GPIO_66 */
+		"SDM_GRFC_11",          /* GPIO_67 */
+		"",                     /* GPIO_68 */
+		"WLAN_COEX_UART_TXD",   /* GPIO_69 */
+		"WLAN_COEX_UART_RXD",   /* GPIO_70 */
+		"SDM_GRFC_0",           /* GPIO_71 */
+		"SDM_GRFC_1",           /* GPIO_72 */
+		"SDM_RFFE1_DATA",       /* GPIO_73 */
+		"SDM_RFFE1_CLK",        /* GPIO_74 */
+		"SDM_RFFE2_DATA",       /* GPIO_75 */
+		"SDM_RFFE2_CLK",        /* GPIO_76 */
+		"SDM_RFFE3_DATA",       /* GPIO_77 */
+		"SDM_RFFE3_CLK",        /* GPIO_78 */
+		"",                     /* GPIO_79 */
+		"",                     /* GPIO_80 */
+		"",                     /* GPIO_81 */
+		"",                     /* GPIO_82 */
+		"CAMW_VCM_2P8_EN",      /* GPIO_83 */
+		"CAMT_VCM_2P8_EN",      /* GPIO_84 */
+		"DBG_UART_TX",          /* GPIO_85 */
+		"DBG_UART_RX",          /* GPIO_86 */
+		"",                     /* GPIO_87 */
+		"TP_TA_INT_N",          /* GPIO_88 */
+		"",                     /* GPIO_89 */
+		"CAMW_LDO_EN",          /* GPIO_90 */
+		"",                     /* GPIO_91 */
+		"",                     /* GPIO_92 */
+		"CAMT_LDO_EN",          /* GPIO_93 */
+		"",                     /* GPIO_94 */
+		"CAMF_LDO_EN",          /* GPIO_95 */
+		"",                     /* GPIO_96 */
+		"CAM_DOVDD_EN",         /* GPIO_97 */
+		"TP_3P3_EN",            /* GPIO_98 */
+		"VCI_3P0_EN",           /* GPIO_99 */
+		"TP_1P8_EN",            /* GPIO_100 */
+		"",                     /* GPIO_101 */
+		"",                     /* GPIO_102 */
+		"NFC_ENABLE",           /* GPIO_103 */
+		"",                     /* GPIO_104 */
+		"UIM2_DATA",            /* GPIO_105 */
+		"UIM2_CLK",             /* GPIO_106 */
+		"UIM2_RESET",           /* GPIO_107 */
+		"UIM2_PRESENT",         /* GPIO_108 */
+		"UIM1_DATA",            /* GPIO_109 */
+		"UIM1_CLK",             /* GPIO_110 */
+		"UIM1_RESET",           /* GPIO_111 */
+		"UIM1_PRESENT",         /* GPIO_112 */
+		"NFC_LABBCLK3_EN",      /* GPIO_113 */
+		"AUDIO_I2C_SDA",        /* GPIO_114 */
+		"AUDIO_I2C_SCL",        /* GPIO_115 */
+		"",                     /* GPIO_116 */
+		"ALSPG_INT_N",          /* GPIO_117 */
+		"FOD_INT_N",            /* GPIO_118 */
+		"",                     /* GPIO_119 */
+		"",                     /* GPIO_120 */
+		"",                     /* GPIO_121 */
+		"TP_INT_N",             /* GPIO_122 */
+		"CODEC_INT1_N",         /* GPIO_123 */
+		"CODEC_INT2_N",         /* GPIO_124 */
+		"FOD_LDO_EN",           /* GPIO_125 */
+		"FOD_SPI_MISO",         /* GPIO_126 */
+		"FOD_SPI_MOSI",         /* GPIO_127 */
+		"FOD_SPI_CLK",          /* GPIO_128 */
+		"FOD_SPI_CS_N",         /* GPIO_129 */
+		"MOTOR_EN",             /* GPIO_130 */
+		"",                     /* GPIO_131 */
+		"ACCEL_INT",            /* GPIO_132 */
+		"GYRO_INT",             /* GPIO_133 */
+		"",                     /* GPIO_134 */
+		"",                     /* GPIO_135 */
+		"FORCED_USB_BOOT",      /* GPIO_136 */
+		"SPKR_I2S_BCK",         /* GPIO_137 */
+		"SPKR_I2S_WS",          /* GPIO_138 */
+		"SPKR_I2S_DOUT",        /* GPIO_139 */
+		"SPKR_I2S_DIN",         /* GPIO_140 */
+		"SPKR_INT",             /* GPIO_141 */
+		"",                     /* GPIO_142 */
+		"CODEC_RST_N",          /* GPIO_143 */
+		"CDC_SPI_MISO",         /* GPIO_144 */
+		"CDC_SPI_MOSI",         /* GPIO_145 */
+		"CDC_SPI_SCLK",         /* GPIO_146 */
+		"CDC_SPI_CS_N",         /* GPIO_147 */
+		"",                     /* GPIO_148 */
+		"CODEC_SLIMBUS_CLK",    /* GPIO_149 */
+		"CODEC_SLIMBUS_DATA0",  /* GPIO_150 */
+		"CODEC_SLIMBUS_DATA1",  /* GPIO_151 */
+		"",                     /* GPIO_152 */
+		"BT_FM_SLIMBUS_DATA",   /* GPIO_153 */
+		"BT_FM_SLIMBUS_CLK",    /* GPIO_154 */
+		"SSC_MAG_I2C_SDA",      /* GPIO_155 */
+		"SSC_MAG_I2C_SCL",      /* GPIO_156 */
+		"SSC_SPI1_MISO",        /* GPIO_157 */
+		"SSC_SPI1_MOSI",        /* GPIO_158 */
+		"SSC_SPI1_CLK",         /* GPIO_159 */
+		"SSC_SPI1_CS_N",        /* GPIO_160 */
+		"SSC_SENSOR_I2C_SDA",   /* GPIO_161 */
+		"SSC_SENSOR_I2C_SCL",   /* GPIO_162 */
+		"",                     /* GPIO_163 */
+		"",                     /* GPIO_164 */
+		"CCI_SYNC6",            /* GPIO_165 */
+		"",                     /* GPIO_166 */
+		"SSC_UART_1_TX",        /* GPIO_167 */
+		"SSC_UART_1_RX",        /* GPIO_168 */
+		"WL_CMD_CLK_CHAIN0",    /* GPIO_169 */
+		"WL_CMD_DATA_CHAIN0",   /* GPIO_170 */
+		"WL_CMD_CLK_CHAIN1",    /* GPIO_171 */
+		"WL_CMD_DATA_CHAIN1",   /* GPIO_172 */
+		"WL_BT_COEX_CLK",       /* GPIO_173 */
+		"WL_BT_COEX_DATA";      /* GPIO_174 */
+
+	/* GPIO 0..3 are NFC spi, gpios 126..129 are FP spi */
+	gpio-reserved-ranges = <0 4>, <126 4>;
+
+	/* Display panel pins */
+	panel_reset_pin: panel-reset-state {
+		pins = "gpio6";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+		output-low;
+		power-source = <1>;
+	};
+
+	panel_te_pin: panel-te-state {
+		pins = "gpio8";
+		function = "mdp_vsync";
+		drive-strength = <2>;
+		bias-pull-down;
+	};
+
+	/* Touch panel pins */
+	tp_active: tp-active-state {
+		pins = "gpio122", "gpio54";
+		function = "gpio";
+		drive-strength = <16>;
+		bias-pull-up;
+	};
+
+	tp_int_suspend: tp-int-suspend-state {
+		pins = "gpio122";
+		function = "gpio";
+		drive-strength = <16>;
+		slew-rate = <0>;
+		bias-pull-up;
+		input-enable;
+	};
+
+	tp_reset_suspend: tp-reset-suspend-state {
+		pins = "gpio54";
+		function = "gpio";
+		drive-strength = <16>;
+		slew-rate = <1>;
+		bias-disable;
+		output-high;
+	};
+};
+
+&uart2 {
+	status = "okay";
+};
+
+&ufs_mem_hc {
+	reset-gpios = <&tlmm 175 GPIO_ACTIVE_LOW>;
+
+	vcc-supply = <&vreg_l10a_2p95>;
+	vcc-max-microamp = <750000>;
+	vccq-supply = <&vreg_l9a_1p2>;
+	vccq-max-microamp = <700000>;
+	vccq2-supply = <&vreg_s4a_1p8>;
+	vccq2-max-microamp = <750000>;
+
+	status = "okay";
+};
+
+&ufs_mem_phy {
+	vdda-phy-supply = <&vdda_ufs_2ln_core_1>;
+	vdda-pll-supply = <&vreg_l3c_1p2>;
+
+	status = "okay";
+};
+
+&usb_1 {
+	qcom,select-utmi-as-pipe-clk;
+
+	status = "okay";
+};
+
+&usb_1_dwc3 {
+	dr_mode = "otg";
+	maximum-speed = "high-speed";
+
+	/* Remove USB3 phy */
+	phys = <&usb_1_hsphy>;
+	phy-names = "usb2-phy";
+
+	usb-role-switch;
+};
+
+&usb_1_dwc3_hs {
+	remote-endpoint = <&pm8150b_hs_in>;
+};
+
+&usb_1_hsphy {
+	vdda-pll-supply = <&vdd_usb_hs_core>;
+	vdda33-supply = <&vdda_usb_hs_3p1>;
+	vdda18-supply = <&vdda_usb_hs_1p8>;
+
+	status = "okay";
+};
+
+&wifi {
+	vdd-0.8-cx-mx-supply = <&vdda_wcss_pll>;
+	vdd-1.8-xo-supply = <&vreg_l7a_1p8>;
+	vdd-1.3-rfa-supply = <&vdda_wcss_adcdac_1>;
+	vdd-3.3-ch0-supply = <&vreg_l11c_3p3>;
+	vdd-3.3-ch1-supply = <&vreg_l10c_3p3>;
+
+	status = "okay";
+};
-- 
2.51.1


