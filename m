Return-Path: <linux-kernel+bounces-770632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C58EB27D58
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 11:41:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4D50602D50
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 09:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 064772F9989;
	Fri, 15 Aug 2025 09:38:23 +0000 (UTC)
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [52.229.205.26])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADBAB191F91;
	Fri, 15 Aug 2025 09:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.229.205.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755250699; cv=none; b=UxRsABXgrp5UP8qPNvJ3es2NhDKatGXSAmTfiCQg8d6aFH92cIMKZnIRMdPhYLJ0zeFe+jrFqcyFLrhBaPbbozzwJ3rljX/VfcNCUb0702/5Exm8Gztq5uvCi4+ggeC1+sI6aBo1bZLObFAwzhO74DJMELZUi8qwTYzsTML7dbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755250699; c=relaxed/simple;
	bh=aE3RNCdREZrcPAZgkYMBGTu6ejb912R7H9GkfJPUxII=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=o/nkxOy6RH5uhwb2fRpgZjAjFvhBR0ZxNYdkOJfJRZZRlkPMJ2VcRJp07Fckwz9TAmf2I60g1C5iDhjVldEDSlg5432a4WVolDq191D8unhxTjp7P4prjXt+4hECgsTzg5oWTfwbQz+cG2OTkgEA+wfe0IsXuwPu71GfA2Y9UYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=52.229.205.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eswincomputing.com
Received: from E0005152DT.eswin.cn (unknown [10.12.96.41])
	by app2 (Coremail) with SMTP id TQJkCgD3lpX0_55oLgm_AA--.28243S2;
	Fri, 15 Aug 2025 17:37:58 +0800 (CST)
From: dongxuyang@eswincomputing.com
To: mturquette@baylibre.com,
	sboyd@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	linux-riscv@lists.infradead.org
Cc: ningyu@eswincomputing.com,
	linmin@eswincomputing.com,
	huangyifeng@eswincomputing.com,
	pinkesh.vaghela@einfochips.com,
	Xuyang Dong <dongxuyang@eswincomputing.com>
Subject: [PATCH v4 3/3] riscv: dts: eswin: Add clock driver support
Date: Fri, 15 Aug 2025 17:37:54 +0800
Message-Id: <20250815093754.1143-1-dongxuyang@eswincomputing.com>
X-Mailer: git-send-email 2.31.1.windows.1
In-Reply-To: <20250815093539.975-1-dongxuyang@eswincomputing.com>
References: <20250815093539.975-1-dongxuyang@eswincomputing.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:TQJkCgD3lpX0_55oLgm_AA--.28243S2
X-Coremail-Antispam: 1UD129KBjvAXoWDGw48KFy5Zw4DWF1UAF43KFg_yoWxZr1fKo
	W2k39xGF17GFy8KayDX34rG34akrZ3JF43Cr4DZF4fXw47Wr43J3s7J3W5WasaqryjkFyv
	qwn7J3WDJF4q9a1xn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUYN7AC8VAFwI0_Xr0_Wr1l1xkIjI8I6I8E6xAIw20EY4v20xva
	j40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2
	x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8
	Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26r
	xl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
	6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E
	8cxan2IY04v7M4kE6xkIj40Ew7xC0wCY1x0262kKe7AKxVW8ZVWrXwCY02Avz4vE-syl42
	xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWU
	GwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI4
	8JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4U
	JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcV
	C2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7sRihF4tUUUUU==
X-CM-SenderInfo: pgrqw5xx1d0w46hv4xpqfrz1xxwl0woofrz/

From: Xuyang Dong <dongxuyang@eswincomputing.com>

Add clock device tree support for eic7700 SoC.

Signed-off-by: Yifeng Huang <huangyifeng@eswincomputing.com>
Signed-off-by: Xuyang Dong <dongxuyang@eswincomputing.com>
---
 arch/riscv/boot/dts/eswin/eic7700-clocks.dtsi | 2283 +++++++++++++++++
 1 file changed, 2283 insertions(+)
 create mode 100644 arch/riscv/boot/dts/eswin/eic7700-clocks.dtsi

diff --git a/arch/riscv/boot/dts/eswin/eic7700-clocks.dtsi b/arch/riscv/boot/dts/eswin/eic7700-clocks.dtsi
new file mode 100644
index 000000000000..405d06f9190e
--- /dev/null
+++ b/arch/riscv/boot/dts/eswin/eic7700-clocks.dtsi
@@ -0,0 +1,2283 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright (c) 2025, Beijing ESWIN Computing Technology Co., Ltd.
+ */
+
+/ {
+	clock-controller@51828000 {
+		compatible = "eswin,eic7700-clock";
+		reg = <0x000000 0x51828000 0x000000 0x80000>;
+		#clock-cells = <0>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		/* fixed clock */
+		fixed_rate_clk_apll_fout2: fixed-rate-apll-fout2 {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <0>;
+			clock-output-names = "fixed_rate_clk_apll_fout2";
+		};
+		fixed_rate_clk_apll_fout3: fixed-rate-apll-fout3 {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <0>;
+			clock-output-names = "fixed_rate_clk_apll_fout3";
+		};
+		fixed_rate_clk_spll0_fout1: fixed-rate-spll0-fout1 {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <1600000000>;
+			clock-output-names = "fixed_rate_clk_spll0_fout1";
+		};
+		fixed_rate_clk_spll0_fout2: fixed-rate-spll0-fout2 {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <800000000>;
+			clock-output-names = "fixed_rate_clk_spll0_fout2";
+		};
+		fixed_rate_clk_spll0_fout3: fixed-rate-spll0-fout3 {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <400000000>;
+			clock-output-names = "fixed_rate_clk_spll0_fout3";
+		};
+		fixed_rate_clk_spll1_fout1: fixed-rate-spll1-fout1 {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <1500000000>;
+			clock-output-names = "fixed_rate_clk_spll1_fout1";
+		};
+		fixed_rate_clk_spll1_fout2: fixed-rate-spll1-fout2 {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <300000000>;
+			clock-output-names = "fixed_rate_clk_spll1_fout2";
+		};
+		fixed_rate_clk_spll1_fout3: fixed-rate-spll1-fout3 {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <250000000>;
+			clock-output-names = "fixed_rate_clk_spll1_fout3";
+		};
+		fixed_rate_clk_spll2_fout1: fixed-rate-spll2-fout1 {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <2080000000>;
+			clock-output-names = "fixed_rate_clk_spll2_fout1";
+		};
+		fixed_rate_clk_spll2_fout2: fixed-rate-spll2-fout2 {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <1040000000>;
+			clock-output-names = "fixed_rate_clk_spll2_fout2";
+		};
+		fixed_rate_clk_spll2_fout3: fixed-rate-spll2-fout3 {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <416000000>;
+			clock-output-names = "fixed_rate_clk_spll2_fout3";
+		};
+		fixed_rate_clk_vpll_fout1: fixed-rate-vpll-fout1 {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <1188000000>;
+			clock-output-names = "fixed_rate_clk_vpll_fout1";
+		};
+		fixed_rate_clk_vpll_fout2: fixed-rate-vpll-fout2 {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <594000000>;
+			clock-output-names = "fixed_rate_clk_vpll_fout2";
+		};
+		fixed_rate_clk_vpll_fout3: fixed-rate-vpll-fout3 {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <49500000>;
+			clock-output-names = "fixed_rate_clk_vpll_fout3";
+		};
+		fixed_rate_clk_xtal_24m: fixed-rate-xtal-24m {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <24000000>;
+			clock-output-names = "fixed_rate_clk_xtal_24m";
+		};
+		fixed_rate_clk_xtal_32k: fixed-rate-xtal-32K {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <32768>;
+			clock-output-names = "fixed_rate_clk_xtal_32k";
+		};
+		fixed_rate_ext_mclk: fixed-rate-ext-mclk {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <0>;
+			clock-output-names = "fixed_rate_ext_mclk";
+		};
+		fixed_rate_lpddr_ref_bak: fixed-rate-lpddr {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <50000000>;
+			clock-output-names = "fixed_rate_lpddr_ref_bak";
+		};
+		/* pll */
+		clk_apll_fout1: clk-apll-fout1-pll@50 {
+			compatible = "eswin,pll-clock";
+			reg = <0x50>, <0x54>, <0x58>, <0xa4>;
+			#clock-cells = <0>;
+			enable-shift = <0>;
+			enable-width = <1>;
+			refdiv-shift = <12>;
+			refdiv-width = <6>;
+			fbdiv-shift = <20>;
+			fbdiv-width = <12>;
+			frac-shift = <4>;
+			frac-width = <24>;
+			postdiv1-shift = <1>;
+			postdiv1-width = <3>;
+			postdiv2-shift = <16>;
+			postdiv2-width = <3>;
+			lock-shift = <4>;
+			lock-width = <1>;
+			clock-output-names = "clk_apll_fout1";
+		};
+		clk_pll_cpu: clk-cpu-pll@64 {
+			compatible = "eswin,pll-clock";
+			reg = <0x64>, <0x68>, <0x6c>, <0xa4>;
+			#clock-cells = <0>;
+			enable-shift = <0>;
+			enable-width = <1>;
+			refdiv-shift = <12>;
+			refdiv-width = <6>;
+			fbdiv-shift = <20>;
+			fbdiv-width = <12>;
+			frac-shift = <4>;
+			frac-width = <24>;
+			postdiv1-shift = <1>;
+			postdiv1-width = <3>;
+			postdiv2-shift = <16>;
+			postdiv2-width = <3>;
+			lock-shift = <5>;
+			lock-width = <1>;
+			clock-output-names = "clk_pll_cpu";
+		};
+		/* fixed factor clock */
+		fixed_factor_clk_1m_div24: fixed-factor-clk-1m-div24 {
+			compatible = "fixed-factor-clock";
+			#clock-cells = <0>;
+			clocks = <&fixed_rate_clk_xtal_24m>;
+			clock-div = <24>;
+			clock-mult = <1>;
+			clock-output-names = "fixed_factor_clk_1m_div24";
+		};
+		fixed_factor_cpu_div2: fixed-factor-cpu-div2 {
+			compatible = "fixed-factor-clock";
+			#clock-cells = <0>;
+			clocks = <&mux_cpu_root_3mux1>;
+			clock-div = <2>;
+			clock-mult = <1>;
+			clock-output-names = "fixed_factor_cpu_div2";
+		};
+		fixed_factor_hsp_rmii_ref_div6: fixed-factor-hsp-rmii-ref-div6 {
+			#clock-cells = <0>;
+			compatible = "fixed-factor-clock";
+			clocks = <&fixed_rate_clk_spll1_fout2>;
+			clock-div = <6>;
+			clock-mult = <1>;
+			clock-output-names = "fixed_factor_hsp_rmii_ref_div6";
+		};
+		fixed_factor_lpcpu_bus_div2: fixed-factor-lpcpu-bus-div2 {
+			#clock-cells = <0>;
+			compatible = "fixed-factor-clock";
+			clocks = <&mux_lpcpu_core_clk_2mux1>;
+			clock-div = <2>;
+			clock-mult = <1>;
+			clock-output-names = "fixed_factor_lpcpu_bus_div2";
+		};
+		fixed_factor_mipi_txesc_div10: fixed-factor-mipi-txesc-div10 {
+			compatible = "fixed-factor-clock";
+			#clock-cells = <0>;
+			clocks = <&mux_syscfg_clk_root_2mux1>;
+			clock-div = <10>;
+			clock-mult = <1>;
+			clock-output-names = "fixed_factor_mipi_txesc_div10";
+		};
+		fixed_factor_pcie_aux_div4: fixed-factor-pcie-aux-div4 {
+			#clock-cells = <0>;
+			compatible = "fixed-factor-clock";
+			clocks = <&mux_syscfg_clk_root_2mux1>;
+			clock-div = <4>;
+			clock-mult = <1>;
+			clock-output-names = "fixed_factor_pcie_aux_div4";
+		};
+		fixed_factor_pcie_cr_div2: fixed-factor-pcie-cr-div2 {
+			compatible = "fixed-factor-clock";
+			#clock-cells = <0>;
+			clocks = <&mux_syscfg_clk_root_2mux1>;
+			clock-div = <2>;
+			clock-mult = <1>;
+			clock-output-names = "fixed_factor_pcie_cr_div2";
+		};
+		fixed_factor_pvt_div20: fixed-factor-pvt-div20 {
+			compatible = "fixed-factor-clock";
+			#clock-cells = <0>;
+			clocks = <&fixed_rate_clk_xtal_24m>;
+			clock-div = <20>;
+			clock-mult = <1>;
+			clock-output-names = "fixed_factor_pvt_div20";
+		};
+		fixed_factor_scpu_bus_div2: fixed-factor-scpu-bus-div2 {
+			compatible = "fixed-factor-clock";
+			#clock-cells = <0>;
+			clocks = <&mux_scpu_core_clk_2mux1>;
+			clock-div = <2>;
+			clock-mult = <1>;
+			clock-output-names = "fixed_factor_scpu_bus_div2";
+		};
+		fixed_factor_u84_core_lp_div2: fixed-factor-u84-core-lp-div2 {
+			#clock-cells = <0>;
+			compatible = "fixed-factor-clock";
+			clocks = <&gate_clk_spll0_fout2>;
+			clock-div = <2>;
+			clock-mult = <1>;
+			clock-output-names = "fixed_factor_u84_core_lp_div2";
+		};
+		/* mux clock */
+		mux_bootspi_clk_2mux1: bootspi-clk-2mux1-mux@104 {
+			compatible = "eswin,mux-clock";
+			reg = <0x104>;
+			#clock-cells = <0>;
+			clocks = <&divider_bootspi_div>,
+				 <&fixed_rate_clk_xtal_24m>;
+			shift = <0>;
+			width = <1>;
+			clock-output-names = "mux_bootspi_clk_2mux1";
+		};
+		mux_scpu_core_clk_2mux1: scpu-core-clk-2mux1-mux@10c {
+			compatible = "eswin,mux-clock";
+			reg = <0x10c>;
+			#clock-cells = <0>;
+			clocks = <&divider_scpu_core_div>,
+				 <&fixed_rate_clk_xtal_24m>;
+			shift = <0>;
+			width = <1>;
+			clock-output-names = "mux_scpu_core_clk_2mux1";
+		};
+		mux_lpcpu_core_clk_2mux1: lpcpu-core-clk-2mux1-mux@114 {
+			compatible = "eswin,mux-clock";
+			reg = <0x114>;
+			#clock-cells = <0>;
+			clocks = <&divider_lpcpu_core_div>,
+				 <&fixed_rate_clk_xtal_24m>;
+			shift = <0>;
+			width = <1>;
+			clock-output-names = "mux_lpcpu_core_clk_2mux1";
+		};
+		mux_ddr_aclk_root_2mux1: ddr-aclk-root-2mux1-mux@124 {
+			compatible = "eswin,mux-clock";
+			reg = <0x124>;
+			#clock-cells = <0>;
+			clocks = <&fixed_rate_clk_spll2_fout1>,
+				 <&fixed_rate_clk_spll0_fout1>;
+			shift = <16>;
+			width = <1>;
+			clock-output-names = "mux_ddr_aclk_root_2mux1";
+		};
+		mux_dsp_aclk_root_2mux1: dsp-aclk-root-2mux1-mux@138 {
+			compatible = "eswin,mux-clock";
+			reg = <0x138>;
+			#clock-cells = <0>;
+			clocks = <&fixed_rate_clk_spll2_fout1>,
+				 <&fixed_rate_clk_spll0_fout1>;
+			shift = <0>;
+			width = <1>;
+			clock-output-names = "mux_dsp_aclk_root_2mux1";
+		};
+		mux_d2d_aclk_root_2mux1: d2d-aclk-root-2mux1-mux@140 {
+			compatible = "eswin,mux-clock";
+			reg = <0x140>;
+			#clock-cells = <0>;
+			clocks = <&fixed_rate_clk_spll2_fout1>,
+				 <&fixed_rate_clk_spll0_fout1>;
+			shift = <0>;
+			width = <1>;
+			clock-output-names = "mux_d2d_aclk_root_2mux1";
+		};
+		mux_sata_phy_2mux1: sata-phy-2mux1-mux@154 {
+			compatible = "eswin,mux-clock";
+			reg = <0x154>;
+			#clock-cells = <0>;
+			clocks = <&divider_sata_phy_ref_div>,
+				 <&fixed_rate_lpddr_ref_bak>;
+			shift = <9>;
+			width = <1>;
+			clock-output-names = "mux_sata_phy_2mux1";
+		};
+		mux_eth_core_2mux1: eth-core-2mux1-mux@158 {
+			compatible = "eswin,mux-clock";
+			reg = <0x158>;
+			#clock-cells = <0>;
+			clocks = <&fixed_rate_clk_spll1_fout3>,
+				 <&fixed_rate_lpddr_ref_bak>;
+			shift = <1>;
+			width = <1>;
+			clock-output-names = "mux_eth_core_2mux1";
+		};
+		mux_rmii_ref_2mux1: rmii-ref-2mux1-mux@158 {
+			compatible = "eswin,mux-clock";
+			reg = <0x158>;
+			#clock-cells = <0>;
+			clocks = <&fixed_factor_hsp_rmii_ref_div6>,
+				 <&fixed_rate_lpddr_ref_bak>;
+			shift = <2>;
+			width = <1>;
+			clock-output-names = "mux_rmii_ref_2mux1";
+		};
+		mux_mshcore_root_3mux1_0: mshcore0-root-3mux1-mux@160 {
+			compatible = "eswin,mux-clock";
+			reg = <0x160>;
+			#clock-cells = <0>;
+			clocks = <&fixed_rate_clk_spll0_fout3>,
+				 <&fixed_rate_clk_spll2_fout3>;
+			shift = <0>;
+			width = <1>;
+			clock-output-names = "mux_mshcore_root_3mux1_0";
+		};
+		mux_mshcore_root_3mux1_1: mshcore1-root-3mux1-mux@164 {
+			compatible = "eswin,mux-clock";
+			reg = <0x164>;
+			#clock-cells = <0>;
+			clocks = <&fixed_rate_clk_spll0_fout3>,
+				 <&fixed_rate_clk_spll2_fout3>;
+			shift = <0>;
+			width = <1>;
+			clock-output-names = "mux_mshcore_root_3mux1_1";
+		};
+		mux_mshcore_root_3mux1_2: mshcore2-root-3mux1-mux@168 {
+			compatible = "eswin,mux-clock";
+			reg = <0x168>;
+			#clock-cells = <0>;
+			clocks = <&fixed_rate_clk_spll0_fout3>,
+				 <&fixed_rate_clk_spll2_fout3>;
+			shift = <0>;
+			width = <1>;
+			clock-output-names = "mux_mshcore_root_3mux1_2";
+		};
+		mux_npu_llclk_3mux1: npu-llclk-3mux1-mux@17c {
+			compatible = "eswin,mux-clock";
+			reg = <0x17c>;
+			#clock-cells = <0>;
+			clocks = <&divider_npu_llc_src0_div>,
+				 <&divider_npu_llc_src1_div>,
+				 <&fixed_rate_clk_vpll_fout1>;
+			shift = <0>;
+			width = <2>;
+			clock-output-names = "mux_npu_llclk_3mux1";
+		};
+		mux_npu_core_3mux1: npu-core-3mux1-mux@180 {
+			compatible = "eswin,mux-clock";
+			reg = <0x180>;
+			#clock-cells = <0>;
+			clocks = <&fixed_rate_clk_spll1_fout1>,
+				 <&fixed_rate_clk_vpll_fout1>,
+				 <&fixed_rate_clk_spll2_fout2>;
+			shift = <0>;
+			width = <2>;
+			clock-output-names = "mux_npu_core_3mux1";
+		};
+		mux_npu_e31_3mux1: npu-e31-3mux1-mux@180 {
+			compatible = "eswin,mux-clock";
+			reg = <0x180>;
+			#clock-cells = <0>;
+			clocks = <&fixed_rate_clk_spll1_fout1>,
+				 <&fixed_rate_clk_vpll_fout1>,
+				 <&fixed_rate_clk_spll2_fout2>;
+			shift = <8>;
+			width = <2>;
+			clock-output-names = "mux_npu_e31_3mux1";
+		};
+		mux_vi_dw_root_2mux1: vi-dw-root-2mux1-mux@184 {
+			compatible = "eswin,mux-clock";
+			reg = <0x184>;
+			#clock-cells = <0>;
+			clocks = <&fixed_rate_clk_vpll_fout1>,
+				 <&fixed_rate_clk_spll0_fout1>;
+			shift = <0>;
+			width = <1>;
+			clock-output-names = "mux_vi_dw_root_2mux1";
+		};
+		mux_vi_aclk_root_2mux1: vi-aclk-root-2mux1-mux@188 {
+			compatible = "eswin,mux-clock";
+			reg = <0x188>;
+			#clock-cells = <0>;
+			clocks = <&fixed_rate_clk_spll0_fout1>,
+				 <&fixed_rate_clk_spll2_fout1>;
+			shift = <0>;
+			width = <1>;
+			clock-output-names = "mux_vi_aclk_root_2mux1";
+		};
+		mux_vi_dig_isp_root_2mux1: vi-dig-isp-root-2mux1-mux@18c {
+			compatible = "eswin,mux-clock";
+			reg = <0x18c>;
+			#clock-cells = <0>;
+			clocks = <&fixed_rate_clk_vpll_fout1>,
+				 <&fixed_rate_clk_spll0_fout1>;
+			shift = <0>;
+			width = <1>;
+			clock-output-names = "mux_vi_dig_isp_root_2mux1";
+		};
+		mux_vi_dvp_root_2mux1: vi-dvp-root-2mux1-mux@190 {
+			compatible = "eswin,mux-clock";
+			reg = <0x190>;
+			#clock-cells = <0>;
+			clocks = <&fixed_rate_clk_vpll_fout1>,
+				 <&fixed_rate_clk_spll0_fout1>;
+			shift = <0>;
+			width = <1>;
+			clock-output-names = "mux_vi_dvp_root_2mux1";
+		};
+		mux_vo_aclk_root_2mux1: vo-aclk-root-2mux1-mux@1b0 {
+			compatible = "eswin,mux-clock";
+			reg = <0x1b0>;
+			#clock-cells = <0>;
+			clocks = <&fixed_rate_clk_spll0_fout1>,
+				 <&fixed_rate_clk_spll2_fout1>;
+			shift = <0>;
+			width = <1>;
+			clock-output-names = "mux_vo_aclk_root_2mux1";
+		};
+		mux_vo_pixel_root_2mux1: vo-pixel-root-2mux1-mux@1b8 {
+			compatible = "eswin,mux-clock";
+			reg = <0x1b8>;
+			#clock-cells = <0>;
+			clocks = <&fixed_rate_clk_vpll_fout1>,
+				 <&fixed_rate_clk_spll2_fout2>;
+			shift = <0>;
+			width = <1>;
+			clock-output-names = "mux_vo_pixel_root_2mux1";
+		};
+		mux_vo_mclk_2mux_ext_mclk: vo-mclk-2mux-ext-mclk-mux@1bc {
+			compatible = "eswin,mux-clock";
+			reg = <0x1bc>;
+			#clock-cells = <0>;
+			clocks = <&divider_vo_mclk_div>,
+				 <&fixed_rate_ext_mclk>;
+			shift = <0>;
+			width = <1>;
+			clock-output-names = "mux_vo_mclk_2mux_ext_mclk";
+		};
+		mux_vcaclk_root_2mux1: vcaclk-root-2mux1-mux@1c4 {
+			compatible = "eswin,mux-clock";
+			reg = <0x1c4>;
+			#clock-cells = <0>;
+			clocks = <&fixed_rate_clk_spll0_fout1>,
+				 <&fixed_rate_clk_spll2_fout1>;
+			shift = <0>;
+			width = <1>;
+			clock-output-names = "mux_vcaclk_root_2mux1";
+		};
+		mux_vcdec_root_2mux1: vcdec-root-2mux1-mux@1c8 {
+			compatible = "eswin,mux-clock";
+			reg = <0x1c8>;
+			#clock-cells = <0>;
+			clocks = <&fixed_rate_clk_spll0_fout1>,
+				 <&fixed_rate_clk_spll2_fout1>;
+			shift = <0>;
+			width = <1>;
+			clock-output-names = "mux_vcdec_root_2mux1";
+		};
+		mux_aondma_axi2mux1: aondma-axi2mux1-mux@1e4 {
+			compatible = "eswin,mux-clock";
+			reg = <0x1e4>;
+			#clock-cells = <0>;
+			clocks = <&divider_aondma_axi_div>,
+				 <&fixed_rate_clk_xtal_24m>;
+			shift = <20>;
+			width = <1>;
+			clock-output-names = "mux_aondma_axi2mux1";
+		};
+		mux_cpu_aclk_2mux1: cpu-aclk-2mux1-mux@208 {
+			compatible = "eswin,mux-clock";
+			reg = <0x208>;
+			#clock-cells = <0>;
+			clocks = <&fixed_factor_cpu_div2>,
+				 <&mux_cpu_root_3mux1>;
+			shift = <20>;
+			width = <1>;
+			clock-output-names = "mux_cpu_aclk_2mux1";
+		};
+		mux_cpu_root_3mux1: cpu-root-3mux1-mux@208 {
+			compatible = "eswin,mux-clock";
+			reg = <0x208>;
+			#clock-cells = <0>;
+			clocks = <&clk_pll_cpu>,
+				 <&fixed_factor_u84_core_lp_div2>,
+				 <&fixed_rate_clk_xtal_24m>;
+			shift = <0>;
+			width = <2>;
+			clock-output-names = "mux_cpu_root_3mux1";
+		};
+		mux_syscfg_clk_root_2mux1: syscfg-clk-root-2mux1-mux@20c {
+			compatible = "eswin,mux-clock";
+			reg = <0x20c>;
+			#clock-cells = <0>;
+			clocks = <&divider_sys_cfg_div>,
+				 <&fixed_rate_clk_xtal_24m>;
+			shift = <0>;
+			width = <1>;
+			clock-output-names = "mux_syscfg_clk_root_2mux1";
+		};
+		/* div clock */
+		divider_noc_nsp_div: noc-nsp-div@100 {
+			compatible = "eswin,divider-clock";
+			reg = <0x100>;
+			#clock-cells = <0>;
+			clocks = <&fixed_rate_clk_spll2_fout1>;
+			shift = <0>;
+			width = <3>;
+			div-flags = <0x1>;
+			clock-output-names = "divider_noc_nsp_div";
+		};
+		divider_bootspi_div: bootspi-div@104 {
+			compatible = "eswin,divider-clock";
+			reg = <0x104>;
+			#clock-cells = <0>;
+			clocks = <&gate_clk_spll0_fout2>;
+			shift = <4>;
+			width = <6>;
+			div-flags = <0x1>;
+			clock-output-names = "divider_bootspi_div";
+		};
+		divider_scpu_core_div: scpu-core-div@10c {
+			compatible = "eswin,divider-clock";
+			reg = <0x10c>;
+			#clock-cells = <0>;
+			clocks = <&fixed_rate_clk_spll0_fout1>;
+			shift = <4>;
+			width = <4>;
+			div-flags = <0x1>;
+			clock-output-names = "divider_scpu_core_div";
+		};
+		divider_lpcpu_core_div: lpcpu-core-div@114 {
+			compatible = "eswin,divider-clock";
+			reg = <0x114>;
+			#clock-cells = <0>;
+			clocks = <&fixed_rate_clk_spll0_fout1>;
+			shift = <4>;
+			width = <4>;
+			div-flags = <0x1>;
+			clock-output-names = "divider_lpcpu_core_div";
+		};
+		divider_ddr_aclk_div: ddr-aclk-div@124 {
+			compatible = "eswin,divider-clock";
+			reg = <0x124>;
+			#clock-cells = <0>;
+			clocks = <&mux_ddr_aclk_root_2mux1>;
+			shift = <20>;
+			width = <4>;
+			div-flags = <0x1>;
+			clock-output-names = "divider_ddr_aclk_div";
+		};
+		divider_gpu_aclk_div: gpu-aclk-div@12c {
+			compatible = "eswin,divider-clock";
+			reg = <0x12c>;
+			#clock-cells = <0>;
+			clocks = <&fixed_rate_clk_spll0_fout1>;
+			shift = <4>;
+			width = <4>;
+			div-flags = <0x1>;
+			clock-output-names = "divider_gpu_aclk_div";
+		};
+		divider_dsp_aclk_div: dsp-aclk-div@138 {
+			compatible = "eswin,divider-clock";
+			reg = <0x138>;
+			#clock-cells = <0>;
+			clocks = <&mux_dsp_aclk_root_2mux1>;
+			shift = <4>;
+			width = <4>;
+			div-flags = <0x1>;
+			clock-output-names = "divider_dsp_aclk_div";
+		};
+		divider_dsp_0_aclk_div: dsp-0-aclk-div@13c {
+			compatible = "eswin,divider-clock";
+			reg = <0x13c>;
+			#clock-cells = <0>;
+			clocks = <&gate_dspt_aclk>;
+			shift = <19>;
+			width = <1>;
+			div-flags = <0x5>;
+			clock-output-names = "divider_dsp_0_aclk_div";
+		};
+		divider_dsp_1_aclk_div: dsp-1-aclk-div@13c {
+			compatible = "eswin,divider-clock";
+			reg = <0x13c>;
+			#clock-cells = <0>;
+			clocks = <&gate_dspt_aclk>;
+			shift = <20>;
+			width = <1>;
+			div-flags = <0x5>;
+			clock-output-names = "divider_dsp_1_aclk_div";
+		};
+		divider_dsp_2_aclk_div: dsp-2-aclk-div@13c {
+			compatible = "eswin,divider-clock";
+			reg = <0x13c>;
+			#clock-cells = <0>;
+			clocks = <&gate_dspt_aclk>;
+			shift = <21>;
+			width = <1>;
+			div-flags = <0x5>;
+			clock-output-names = "divider_dsp_2_aclk_div";
+		};
+		divider_dsp_3_aclk_div: dsp-3-aclk-div@13c {
+			compatible = "eswin,divider-clock";
+			reg = <0x13c>;
+			#clock-cells = <0>;
+			clocks = <&gate_dspt_aclk>;
+			shift = <22>;
+			width = <1>;
+			div-flags = <0x5>;
+			clock-output-names = "divider_dsp_3_aclk_div";
+		};
+		divider_d2d_aclk_div: d2d-aclk-div@140 {
+			compatible = "eswin,divider-clock";
+			reg = <0x140>;
+			#clock-cells = <0>;
+			clocks = <&mux_d2d_aclk_root_2mux1>;
+			shift = <4>;
+			width = <4>;
+			div-flags = <0x1>;
+			clock-output-names = "divider_d2d_aclk_div";
+		};
+		divider_hsp_aclk_div: hsp-aclk-div@148 {
+			compatible = "eswin,divider-clock";
+			reg = <0x148>;
+			#clock-cells = <0>;
+			clocks = <&fixed_rate_clk_spll0_fout1>;
+			shift = <4>;
+			width = <4>;
+			div-flags = <0x1>;
+			clock-output-names = "divider_hsp_aclk_div";
+		};
+		divider_sata_phy_ref_div: sata-phy-ref-div@154 {
+			compatible = "eswin,divider-clock";
+			reg = <0x154>;
+			#clock-cells = <0>;
+			clocks = <&fixed_rate_clk_spll1_fout2>;
+			shift = <0>;
+			width = <4>;
+			div-flags = <0x1>;
+			clock-output-names = "divider_sata_phy_ref_div";
+		};
+		divider_eth_txclk_div_0: eth-0-txclk-div@158 {
+			compatible = "eswin,divider-clock";
+			reg = <0x158>;
+			#clock-cells = <0>;
+			clocks = <&mux_eth_core_2mux1>;
+			shift = <4>;
+			width = <7>;
+			div-flags = <0x1>;
+			clock-output-names = "divider_eth_txclk_div_0";
+		};
+		divider_eth_txclk_div_1: eth-1-txclk-div@15c {
+			compatible = "eswin,divider-clock";
+			reg = <0x15c>;
+			#clock-cells = <0>;
+			clocks = <&mux_eth_core_2mux1>;
+			shift = <4>;
+			width = <7>;
+			div-flags = <0x1>;
+			clock-output-names = "divider_eth_txclk_div_1";
+		};
+		divider_mshc_core_div_0: mshc-0-core-div@160 {
+			compatible = "eswin,divider-clock";
+			reg = <0x160>;
+			#clock-cells = <0>;
+			clocks = <&mux_mshcore_root_3mux1_0>;
+			shift = <4>;
+			width = <12>;
+			div-flags = <0x5>;
+			clock-output-names = "divider_mshc_core_div_0";
+		};
+		divider_mshc_core_div_1: mshc-1-core-div@164 {
+			compatible = "eswin,divider-clock";
+			reg = <0x164>;
+			#clock-cells = <0>;
+			clocks = <&mux_mshcore_root_3mux1_1>;
+			shift = <4>;
+			width = <12>;
+			div-flags = <0x5>;
+			clock-output-names = "divider_mshc_core_div_1";
+		};
+		divider_mshc_core_div_2: mshc-2-core-div@168 {
+			compatible = "eswin,divider-clock";
+			reg = <0x168>;
+			#clock-cells = <0>;
+			clocks = <&mux_mshcore_root_3mux1_2>;
+			shift = <4>;
+			width = <12>;
+			div-flags = <0x5>;
+			clock-output-names = "divider_mshc_core_div_2";
+		};
+		divider_pcie_aclk_div: pcie-aclk-div@170 {
+			compatible = "eswin,divider-clock";
+			reg = <0x170>;
+			#clock-cells = <0>;
+			clocks = <&fixed_rate_clk_spll2_fout2>;
+			shift = <4>;
+			width = <4>;
+			div-flags = <0x1>;
+			clock-output-names = "divider_pcie_aclk_div";
+		};
+		divider_npu_aclk_div: npu-aclk-div@178 {
+			compatible = "eswin,divider-clock";
+			reg = <0x178>;
+			#clock-cells = <0>;
+			clocks = <&fixed_rate_clk_spll0_fout1>;
+			shift = <4>;
+			width = <4>;
+			div-flags = <0x1>;
+			clock-output-names = "divider_npu_aclk_div";
+		};
+		divider_npu_llc_src0_div: npu-llc-src0-div@17c {
+			compatible = "eswin,divider-clock";
+			reg = <0x17c>;
+			#clock-cells = <0>;
+			clocks = <&fixed_rate_clk_spll0_fout1>;
+			shift = <4>;
+			width = <4>;
+			div-flags = <0x1>;
+			clock-output-names = "divider_npu_llc_src0_div";
+		};
+		divider_npu_llc_src1_div: npu-llc-src1-div@17c {
+			compatible = "eswin,divider-clock";
+			reg = <0x17c>;
+			#clock-cells = <0>;
+			clocks = <&fixed_rate_clk_spll2_fout1>;
+			shift = <8>;
+			width = <4>;
+			div-flags = <0x1>;
+			clock-output-names = "divider_npu_llc_src1_div";
+		};
+		divider_npu_coreclk_div: npu-coreclk-div@180 {
+			compatible = "eswin,divider-clock";
+			reg = <0x180>;
+			#clock-cells = <0>;
+			clocks = <&mux_npu_core_3mux1>;
+			shift = <4>;
+			width = <4>;
+			div-flags = <0x5>;
+			clock-output-names = "divider_npu_coreclk_div";
+		};
+		divider_npu_e31_div: npu-e31-div@180 {
+			compatible = "eswin,divider-clock";
+			reg = <0x180>;
+			#clock-cells = <0>;
+			clocks = <&mux_npu_e31_3mux1>;
+			shift = <12>;
+			width = <4>;
+			div-flags = <0x5>;
+			clock-output-names = "divider_npu_e31_div";
+		};
+		divider_vi_dw_div: vi-dw-div@184 {
+			compatible = "eswin,divider-clock";
+			reg = <0x184>;
+			#clock-cells = <0>;
+			clocks = <&mux_vi_dw_root_2mux1>;
+			shift = <4>;
+			width = <4>;
+			div-flags = <0x1>;
+			clock-output-names = "divider_vi_dw_div";
+		};
+		divider_vi_aclk_div: vi-aclk-div@188 {
+			compatible = "eswin,divider-clock";
+			reg = <0x188>;
+			#clock-cells = <0>;
+			clocks = <&mux_vi_aclk_root_2mux1>;
+			shift = <4>;
+			width = <4>;
+			div-flags = <0x1>;
+			clock-output-names = "divider_vi_aclk_div";
+		};
+		divider_vi_dig_isp_div: vi-dig-isp-div@18c {
+			compatible = "eswin,divider-clock";
+			reg = <0x18c>;
+			#clock-cells = <0>;
+			clocks = <&mux_vi_dig_isp_root_2mux1>;
+			shift = <4>;
+			width = <4>;
+			div-flags = <0x1>;
+			clock-output-names = "divider_vi_dig_isp_div";
+		};
+		divider_vi_dvp_div: vi-dvp-div@190 {
+			compatible = "eswin,divider-clock";
+			reg = <0x190>;
+			#clock-cells = <0>;
+			clocks = <&mux_vi_dvp_root_2mux1>;
+			shift = <4>;
+			width = <4>;
+			div-flags = <0x1>;
+			clock-output-names = "divider_vi_dvp_div";
+		};
+		divider_vi_shutter_div_0: vi-shutter-0-div@194 {
+			compatible = "eswin,divider-clock";
+			reg = <0x194>;
+			#clock-cells = <0>;
+			clocks = <&fixed_rate_clk_vpll_fout2>;
+			shift = <4>;
+			width = <7>;
+			div-flags = <0x1>;
+			clock-output-names = "divider_vi_shutter_div_0";
+		};
+		divider_vi_shutter_div_1: vi-shutter-1-div@198 {
+			compatible = "eswin,divider-clock";
+			reg = <0x198>;
+			#clock-cells = <0>;
+			clocks = <&fixed_rate_clk_vpll_fout2>;
+			shift = <4>;
+			width = <7>;
+			div-flags = <0x1>;
+			clock-output-names = "divider_vi_shutter_div_1";
+		};
+		divider_vi_shutter_div_2: vi-shutter-2-div@19c {
+			compatible = "eswin,divider-clock";
+			reg = <0x19c>;
+			#clock-cells = <0>;
+			clocks = <&fixed_rate_clk_vpll_fout2>;
+			shift = <4>;
+			width = <7>;
+			div-flags = <0x1>;
+			clock-output-names = "divider_vi_shutter_div_2";
+		};
+		divider_vi_shutter_div_3: vi-shutter-3-div@1a0 {
+			compatible = "eswin,divider-clock";
+			reg = <0x1a0>;
+			#clock-cells = <0>;
+			clocks = <&fixed_rate_clk_vpll_fout2>;
+			shift = <4>;
+			width = <7>;
+			div-flags = <0x1>;
+			clock-output-names = "divider_vi_shutter_div_3";
+		};
+		divider_vi_shutter_div_4: vi-shutter-4-div@1a4 {
+			compatible = "eswin,divider-clock";
+			reg = <0x1a4>;
+			#clock-cells = <0>;
+			clocks = <&fixed_rate_clk_vpll_fout2>;
+			shift = <4>;
+			width = <7>;
+			div-flags = <0x1>;
+			clock-output-names = "divider_vi_shutter_div_4";
+		};
+		divider_vi_shutter_div_5: vi-shutter-5-div@1a8 {
+			compatible = "eswin,divider-clock";
+			reg = <0x1a8>;
+			#clock-cells = <0>;
+			clocks = <&fixed_rate_clk_vpll_fout2>;
+			shift = <4>;
+			width = <7>;
+			div-flags = <0x1>;
+			clock-output-names = "divider_vi_shutter_div_5";
+		};
+		divider_vo_aclk_div: vo-aclk-div@1b0 {
+			compatible = "eswin,divider-clock";
+			reg = <0x1b0>;
+			#clock-cells = <0>;
+			clocks = <&mux_vo_aclk_root_2mux1>;
+			shift = <4>;
+			width = <4>;
+			div-flags = <0x1>;
+			clock-output-names = "divider_vo_aclk_div";
+		};
+		divider_iesmclk_div: iesmclk-div@1b4 {
+			compatible = "eswin,divider-clock";
+			reg = <0x1b4>;
+			#clock-cells = <0>;
+			clocks = <&fixed_rate_clk_spll0_fout3>;
+			shift = <4>;
+			width = <4>;
+			div-flags = <0x1>;
+			clock-output-names = "divider_iesmclk_div";
+		};
+		divider_vo_pixel_div: vo-pixel-div@1b8 {
+			compatible = "eswin,divider-clock";
+			reg = <0x1b8>;
+			#clock-cells = <0>;
+			clocks = <&mux_vo_pixel_root_2mux1>;
+			shift = <4>;
+			width = <6>;
+			div-flags = <0x1>;
+			clock-output-names = "divider_vo_pixel_div";
+		};
+		divider_vo_mclk_div: vo-mclk-div@1bc {
+			compatible = "eswin,divider-clock";
+			reg = <0x1bc>;
+			#clock-cells = <0>;
+			clocks = <&clk_apll_fout1>;
+			shift = <4>;
+			width = <8>;
+			div-flags = <0x1>;
+			clock-output-names = "divider_vo_mclk_div";
+		};
+		divider_vo_cec_div: vo-cec-div@1c0 {
+			compatible = "eswin,divider-clock";
+			reg = <0x1c0>;
+			#clock-cells = <0>;
+			clocks = <&fixed_rate_clk_vpll_fout2>;
+			shift = <16>;
+			width = <16>;
+			div-flags = <0x5>;
+			clock-output-names = "divider_vo_cec_div";
+		};
+		divider_vc_aclk_div: vc-aclk-div@1c4 {
+			compatible = "eswin,divider-clock";
+			reg = <0x1c4>;
+			#clock-cells = <0>;
+			clocks = <&mux_vcaclk_root_2mux1>;
+			shift = <4>;
+			width = <4>;
+			div-flags = <0x1>;
+			clock-output-names = "divider_vc_aclk_div";
+		};
+		divider_g2d_div: g2d-div@1cc {
+			compatible = "eswin,divider-clock";
+			reg = <0x1cc>;
+			#clock-cells = <0>;
+			clocks = <&mux_dsp_aclk_root_2mux1>;
+			shift = <4>;
+			width = <4>;
+			div-flags = <0x1>;
+			clock-output-names = "divider_g2d_div";
+		};
+		divider_aondma_axi_div: aondma-axi-div@1e4 {
+			compatible = "eswin,divider-clock";
+			reg = <0x1d4>;
+			#clock-cells = <0>;
+			clocks = <&fixed_rate_clk_spll0_fout1>;
+			shift = <4>;
+			width = <4>;
+			div-flags = <0x1>;
+			clock-output-names = "divider_aondma_axi_div";
+		};
+		divider_je_div: je-div@1d4 {
+			compatible = "eswin,divider-clock";
+			reg = <0x1d4>;
+			#clock-cells = <0>;
+			clocks = <&mux_vcdec_root_2mux1>;
+			shift = <4>;
+			width = <4>;
+			div-flags = <0x1>;
+			clock-output-names = "divider_je_div";
+		};
+		divider_jd_div: jd-div@1d8 {
+			compatible = "eswin,divider-clock";
+			reg = <0x1d8>;
+			#clock-cells = <0>;
+			clocks = <&mux_vcdec_root_2mux1>;
+			shift = <4>;
+			width = <4>;
+			div-flags = <0x1>;
+			clock-output-names = "divider_jd_div";
+		};
+		divider_vd_div: vd-div@1dc {
+			compatible = "eswin,divider-clock";
+			reg = <0x1dc>;
+			#clock-cells = <0>;
+			clocks = <&mux_vcdec_root_2mux1>;
+			shift = <4>;
+			width = <4>;
+			div-flags = <0x1>;
+			clock-output-names = "divider_vd_div";
+		};
+		divider_ve_div: ve-div@1e0 {
+			compatible = "eswin,divider-clock";
+			reg = <0x1e0>;
+			#clock-cells = <0>;
+			clocks = <&mux_vcdec_root_2mux1>;
+			shift = <4>;
+			width = <4>;
+			div-flags = <0x1>;
+			clock-output-names = "divider_ve_div";
+		};
+		divider_aon_rtc_div: aon-rtc-div@1ec{
+			compatible = "eswin,divider-clock";
+			reg = <0x1ec>;
+			#clock-cells = <0>;
+			clocks = <&fixed_factor_clk_1m_div24>;
+			shift = <21>;
+			width = <11>;
+			div-flags = <0x1>;
+			clock-output-names = "divider_aon_rtc_div";
+		};
+		divider_u84_rtc_toggle: u84-rtc-toggle-div@1ec {
+			compatible = "eswin,divider-clock";
+			reg = <0x1ec>;
+			#clock-cells = <0>;
+			clocks = <&fixed_rate_clk_xtal_24m>;
+			shift = <16>;
+			width = <5>;
+			div-flags = <0x5>;
+			clock-output-names = "divider_u84_rtc_toggle";
+		};
+		divider_crypto_div: crypto-div@1f4 {
+			compatible = "eswin,divider-clock";
+			reg = <0x1f4>;
+			#clock-cells = <0>;
+			clocks = <&fixed_rate_clk_spll0_fout1>;
+			shift = <4>;
+			width = <4>;
+			div-flags = <0x1>;
+			clock-output-names = "divider_crypto_div";
+		};
+		divider_sys_cfg_div: sys-cfg-div@20c {
+			compatible = "eswin,divider-clock";
+			reg = <0x20c>;
+			#clock-cells = <0>;
+			clocks = <&fixed_rate_clk_spll0_fout3>;
+			shift = <4>;
+			width = <3>;
+			div-flags = <0x1>;
+			clock-output-names = "divider_sys_cfg_div";
+		};
+		/* gate clock */
+		gate_clk_spll0_fout2: clk-spll0-fout2-gate@8 {
+			compatible = "eswin,gate-clock";
+			reg = <0x8>;
+			#clock-cells = <0>;
+			clocks = <&fixed_rate_clk_spll0_fout2>;
+			bit-index = <31>;
+			clock-output-names = "gate_clk_spll0_fout2";
+		};
+		gate_noc_nsp_clk: noc-nsp-clk-gate@100 {
+			compatible = "eswin,gate-clock";
+			reg = <0x100>;
+			#clock-cells = <0>;
+			clocks = <&divider_noc_nsp_div>;
+			bit-index = <31>;
+			clock-output-names = "gate_noc_nsp_clk";
+		};
+		gate_clk_bootspi: clk-bootspi-gate@104 {
+			compatible = "eswin,gate-clock";
+			reg = <0x104>;
+			#clock-cells = <0>;
+			clocks = <&mux_bootspi_clk_2mux1>;
+			bit-index = <31>;
+			clock-output-names = "gate_clk_bootspi";
+		};
+		gate_clk_bootspi_cfg: clk-bootspi-cfg-gate@108 {
+			compatible = "eswin,gate-clock";
+			reg = <0x108>;
+			#clock-cells = <0>;
+			clocks = <&mux_syscfg_clk_root_2mux1>;
+			bit-index = <31>;
+			clock-output-names = "gate_clk_bootspi_cfg";
+		};
+		gate_clk_scpu_core: clk-scpu-core-gate@10c {
+			compatible = "eswin,gate-clock";
+			reg = <0x10c>;
+			#clock-cells = <0>;
+			clocks = <&mux_scpu_core_clk_2mux1>;
+			bit-index = <31>;
+			clock-output-names = "gate_clk_scpu_core";
+		};
+		gate_clk_scpu_bus: clk-scpu-bus-gate@110 {
+			compatible = "eswin,gate-clock";
+			reg = <0x110>;
+			#clock-cells = <0>;
+			clocks = <&fixed_factor_scpu_bus_div2>;
+			bit-index = <31>;
+			clock-output-names = "gate_clk_scpu_bus";
+		};
+		gate_clk_lpcpu_core: clk-lpcpu-core-gate@114 {
+			compatible = "eswin,gate-clock";
+			reg = <0x114>;
+			#clock-cells = <0>;
+			clocks = <&mux_lpcpu_core_clk_2mux1>;
+			bit-index = <31>;
+			clock-output-names = "gate_clk_lpcpu_core";
+		};
+		gate_clk_lpcpu_bus: clk-lpcpu-bus-gate@118 {
+			compatible = "eswin,gate-clock";
+			reg = <0x118>;
+			#clock-cells = <0>;
+			clocks = <&fixed_factor_lpcpu_bus_div2>;
+			bit-index = <31>;
+			clock-output-names = "gate_clk_lpcpu_bus";
+		};
+		gate_tcu_aclk: tcu-aclk-gate@11c {
+			compatible = "eswin,gate-clock";
+			reg = <0x11c>;
+			#clock-cells = <0>;
+			clocks = <&divider_ddr_aclk_div>;
+			bit-index = <31>;
+			clock-output-names = "gate_tcu_aclk";
+		};
+		gate_tcu_cfg_clk: tcu-cfg-clk-gate@120 {
+			compatible = "eswin,gate-clock";
+			reg = <0x120>;
+			#clock-cells = <0>;
+			clocks = <&mux_syscfg_clk_root_2mux1>;
+			bit-index = <31>;
+			clock-output-names = "gate_tcu_cfg_clk";
+		};
+		gate_ddrt_cfg_clk: ddrt-cfg-clk-gate@124 {
+			compatible = "eswin,gate-clock";
+			reg = <0x124>;
+			#clock-cells = <0>;
+			clocks = <&mux_syscfg_clk_root_2mux1>;
+			bit-index = <9>;
+			clock-output-names = "gate_ddrt_cfg_clk";
+		};
+		gate_ddrt0_p0_aclk: ddrt0-p0-aclk-gate@124 {
+			compatible = "eswin,gate-clock";
+			reg = <0x124>;
+			#clock-cells = <0>;
+			clocks = <&divider_ddr_aclk_div>;
+			bit-index = <4>;
+			clock-output-names = "gate_ddrt0_p0_aclk";
+		};
+		gate_ddrt0_p1_aclk: ddrt0-p1-aclk-gate@124 {
+			compatible = "eswin,gate-clock";
+			reg = <0x124>;
+			#clock-cells = <0>;
+			clocks = <&divider_ddr_aclk_div>;
+			bit-index = <5>;
+			clock-output-names = "gate_ddrt0_p1_aclk";
+		};
+		gate_ddrt0_p2_aclk: ddrt0-p2-aclk-gate@124 {
+			compatible = "eswin,gate-clock";
+			reg = <0x124>;
+			#clock-cells = <0>;
+			clocks = <&divider_ddr_aclk_div>;
+			bit-index = <6>;
+			clock-output-names = "gate_ddrt0_p2_aclk";
+		};
+		gate_ddrt0_p3_aclk: ddrt0-p3-aclk-gate@124 {
+			compatible = "eswin,gate-clock";
+			reg = <0x124>;
+			#clock-cells = <0>;
+			clocks = <&divider_ddr_aclk_div>;
+			bit-index = <7>;
+			clock-output-names = "gate_ddrt0_p3_aclk";
+		};
+		gate_ddrt0_p4_aclk: ddrt0-p4-aclk-gate@124 {
+			compatible = "eswin,gate-clock";
+			reg = <0x124>;
+			#clock-cells = <0>;
+			clocks = <&divider_ddr_aclk_div>;
+			bit-index = <8>;
+			clock-output-names = "gate_ddrt0_p4_aclk";
+		};
+		gate_ddrt1_p0_aclk: ddrt1-p0-aclk-gate@128 {
+			compatible = "eswin,gate-clock";
+			reg = <0x128>;
+			#clock-cells = <0>;
+			clocks = <&divider_ddr_aclk_div>;
+			bit-index = <4>;
+			clock-output-names = "gate_ddrt1_p0_aclk";
+		};
+		gate_ddrt1_p1_aclk: ddrt1-p1-aclk-gate@128 {
+			compatible = "eswin,gate-clock";
+			reg = <0x128>;
+			#clock-cells = <0>;
+			clocks = <&divider_ddr_aclk_div>;
+			bit-index = <5>;
+			clock-output-names = "gate_ddrt1_p1_aclk";
+		};
+		gate_ddrt1_p2_aclk: ddrt1-p2-aclk-gate@128 {
+			compatible = "eswin,gate-clock";
+			reg = <0x128>;
+			#clock-cells = <0>;
+			clocks = <&divider_ddr_aclk_div>;
+			bit-index = <6>;
+			clock-output-names = "gate_ddrt1_p2_aclk";
+		};
+		gate_ddrt1_p3_aclk: ddrt1-p3-aclk-gate@128 {
+			compatible = "eswin,gate-clock";
+			reg = <0x128>;
+			#clock-cells = <0>;
+			clocks = <&divider_ddr_aclk_div>;
+			bit-index = <7>;
+			clock-output-names = "gate_ddrt1_p3_aclk";
+		};
+		gate_ddrt1_p4_aclk: ddrt1-p4-aclk-gate@128 {
+			compatible = "eswin,gate-clock";
+			reg = <0x128>;
+			#clock-cells = <0>;
+			clocks = <&divider_ddr_aclk_div>;
+			bit-index = <8>;
+			clock-output-names = "gate_ddrt1_p4_aclk";
+		};
+		gate_gpu_aclk: gpu-aclk-gate@12c {
+			compatible = "eswin,gate-clock";
+			reg = <0x12c>;
+			#clock-cells = <0>;
+			clocks = <&divider_gpu_aclk_div>;
+			bit-index = <31>;
+			clock-output-names = "gate_gpu_aclk";
+		};
+		gate_gpu_cfg_clk: gpu-cfg-clk-gate@130 {
+			compatible = "eswin,gate-clock";
+			reg = <0x130>;
+			#clock-cells = <0>;
+			clocks = <&mux_syscfg_clk_root_2mux1>;
+			bit-index = <31>;
+			clock-output-names = "gate_gpu_cfg_clk";
+		};
+		gate_gpu_gray_clk: gpu-gray-clk-gate@134 {
+			compatible = "eswin,gate-clock";
+			reg = <0x134>;
+			#clock-cells = <0>;
+			clocks = <&fixed_rate_clk_xtal_24m>;
+			bit-index = <31>;
+			clock-output-names = "gate_gpu_gray_clk";
+		};
+		gate_dspt_aclk: dspt-aclk-gate@138 {
+			compatible = "eswin,gate-clock";
+			reg = <0x138>;
+			#clock-cells = <0>;
+			clocks = <&divider_dsp_aclk_div>;
+			bit-index = <31>;
+			clock-output-names = "gate_dspt_aclk";
+		};
+		gate_dspt_cfg_clk: dspt-cfg-clk-gate@13c {
+			compatible = "eswin,gate-clock";
+			reg = <0x13c>;
+			#clock-cells = <0>;
+			clocks = <&mux_syscfg_clk_root_2mux1>;
+			bit-index = <31>;
+			clock-output-names = "gate_dspt_cfg_clk";
+		};
+		gate_d2d_aclk: d2d-aclk-gate@140 {
+			compatible = "eswin,gate-clock";
+			reg = <0x140>;
+			#clock-cells = <0>;
+			clocks = <&divider_d2d_aclk_div>;
+			bit-index = <31>;
+			clock-output-names = "gate_d2d_aclk";
+		};
+		gate_d2d_cfg_clk: d2d-cfg-clk-gate@144 {
+			compatible = "eswin,gate-clock";
+			reg = <0x144>;
+			#clock-cells = <0>;
+			clocks = <&mux_syscfg_clk_root_2mux1>;
+			bit-index = <31>;
+			clock-output-names = "gate_d2d_cfg_clk";
+		};
+		gate_clk_hsp_aclk: clk-hsp-aclk-gate@148 {
+			compatible = "eswin,gate-clock";
+			reg = <0x148>;
+			#clock-cells = <0>;
+			clocks = <&divider_hsp_aclk_div>;
+			bit-index = <31>;
+			clock-output-names = "gate_clk_hsp_aclk";
+		};
+		gate_hsp_dma0_clk: hsp-dma0-clk-gate@148 {
+			compatible = "eswin,gate-clock";
+			reg = <0x148>;
+			#clock-cells = <0>;
+			clocks = <&gate_clk_hsp_aclk>;
+			bit-index = <0>;
+			clock-output-names = "gate_hsp_dma0_clk";
+		};
+		gate_hsp_dma0_clk_test: hsp-dma0-clk-test-gate@148 {
+			compatible = "eswin,gate-clock";
+			reg = <0x148>;
+			#clock-cells = <0>;
+			clocks = <&gate_clk_hsp_aclk>;
+			bit-index = <1>;
+			clock-output-names = "gate_hsp_dma0_clk_test";
+		};
+		gate_clk_hsp_cfgclk: clk-hsp-cfgclk-gate@14c {
+			compatible = "eswin,gate-clock";
+			reg = <0x14c>;
+			#clock-cells = <0>;
+			clocks = <&mux_syscfg_clk_root_2mux1>;
+			bit-index = <31>;
+			clock-output-names = "gate_clk_hsp_cfgclk";
+		};
+		gate_hsp_sata_rbc_clk: hsp-sata-rbc-clk-gate@150 {
+			compatible = "eswin,gate-clock";
+			reg = <0x150>;
+			#clock-cells = <0>;
+			clocks = <&fixed_rate_clk_spll1_fout2>;
+			bit-index = <0>;
+			clock-output-names = "gate_hsp_sata_rbc_clk";
+		};
+		gate_hsp_sata_oob_clk: hsp-sata-oob-clk-gate@154 {
+			compatible = "eswin,gate-clock";
+			reg = <0x154>;
+			#clock-cells = <0>;
+			clocks = <&mux_sata_phy_2mux1>;
+			bit-index = <31>;
+			clock-output-names = "gate_hsp_sata_oob_clk";
+		};
+		gate_hsp_eth0_core_clk: hsp-eth0-core-clk-gate@158 {
+			compatible = "eswin,gate-clock";
+			reg = <0x158>;
+			#clock-cells = <0>;
+			clocks = <&divider_eth_txclk_div_0>;
+			bit-index = <0>;
+			clock-output-names = "gate_hsp_eth0_core_clk";
+		};
+		gate_hsp_rmii_ref_0: hsp-rmii-ref-0-gate@158 {
+			compatible = "eswin,gate-clock";
+			reg = <0x158>;
+			#clock-cells = <0>;
+			clocks = <&mux_rmii_ref_2mux1>;
+			bit-index = <31>;
+			clock-output-names = "gate_hsp_rmii_ref_0";
+		};
+		gate_hsp_eth1_core_clk: hsp-eth1-core-clk-gate@15c {
+			compatible = "eswin,gate-clock";
+			reg = <0x15c>;
+			#clock-cells = <0>;
+			clocks = <&divider_eth_txclk_div_1>;
+			bit-index = <0>;
+			clock-output-names = "gate_hsp_eth1_core_clk";
+		};
+		gate_hsp_rmii_ref_1: hsp-rmii-ref-1-gate@15c {
+			compatible = "eswin,gate-clock";
+			reg = <0x15c>;
+			#clock-cells = <0>;
+			clocks = <&mux_rmii_ref_2mux1>;
+			bit-index = <31>;
+			clock-output-names = "gate_hsp_rmii_ref_1";
+		};
+		gate_hsp_mshc0_core_clk: hsp-mshc0-core-clk-gate@160 {
+			compatible = "eswin,gate-clock";
+			reg = <0x160>;
+			#clock-cells = <0>;
+			clocks = <&divider_mshc_core_div_0>;
+			bit-index = <16>;
+			clock-output-names = "gate_hsp_mshc0_core_clk";
+		};
+		gate_hsp_mshc1_core_clk: hsp-mshc1-core-clk-gate@164 {
+			compatible = "eswin,gate-clock";
+			reg = <0x164>;
+			#clock-cells = <0>;
+			clocks = <&divider_mshc_core_div_1>;
+			bit-index = <16>;
+			clock-output-names = "gate_hsp_mshc1_core_clk";
+		};
+		gate_hsp_mshc2_core_clk: hsp-mshc2-core-clk-gate@168 {
+			compatible = "eswin,gate-clock";
+			reg = <0x168>;
+			#clock-cells = <0>;
+			clocks = <&divider_mshc_core_div_2>;
+			bit-index = <16>;
+			clock-output-names = "gate_hsp_mshc2_core_clk";
+		};
+		gate_pciet_aclk: pciet-aclk-gate@170 {
+			compatible = "eswin,gate-clock";
+			reg = <0x170>;
+			#clock-cells = <0>;
+			clocks = <&divider_pcie_aclk_div>;
+			bit-index = <31>;
+			clock-output-names = "gate_pciet_aclk";
+		};
+		gate_pciet_aux_clk: pciet-aux-clk-gate@174 {
+			compatible = "eswin,gate-clock";
+			reg = <0x174>;
+			#clock-cells = <0>;
+			clocks = <&fixed_factor_pcie_aux_div4>;
+			bit-index = <1>;
+			clock-output-names = "gate_pciet_aux_clk";
+		};
+		gate_pciet_cfg_clk: pciet-cfg-clk-gate@174 {
+			compatible = "eswin,gate-clock";
+			reg = <0x174>;
+			#clock-cells = <0>;
+			clocks = <&mux_syscfg_clk_root_2mux1>;
+			bit-index = <31>;
+			clock-output-names = "gate_pciet_cfg_clk";
+		};
+		gate_pciet_cr_clk: pciet-cr-clk-gate@174 {
+			compatible = "eswin,gate-clock";
+			reg = <0x174>;
+			#clock-cells = <0>;
+			clocks = <&fixed_factor_pcie_cr_div2>;
+			bit-index = <0>;
+			clock-output-names = "gate_pciet_cr_clk";
+		};
+		gate_npu_aclk: npu-aclk-gate@178 {
+			compatible = "eswin,gate-clock";
+			reg = <0x178>;
+			#clock-cells = <0>;
+			clocks = <&divider_npu_aclk_div>;
+			bit-index = <31>;
+			clock-output-names = "gate_npu_aclk";
+		};
+		gate_npu_cfg_clk: npu-cfg-clk-gate@178 {
+			compatible = "eswin,gate-clock";
+			reg = <0x178>;
+			#clock-cells = <0>;
+			clocks = <&mux_syscfg_clk_root_2mux1>;
+			bit-index = <30>;
+			clock-output-names = "gate_npu_cfg_clk";
+		};
+		gate_npu_llc_aclk: npu-llc-aclk-gate@17c {
+			compatible = "eswin,gate-clock";
+			reg = <0x17c>;
+			#clock-cells = <0>;
+			clocks = <&mux_npu_llclk_3mux1>;
+			bit-index = <31>;
+			clock-output-names = "gate_npu_llc_aclk";
+		};
+		gate_npu_clk: npu-clk-gate@180 {
+			compatible = "eswin,gate-clock";
+			reg = <0x180>;
+			#clock-cells = <0>;
+			clocks = <&divider_npu_coreclk_div>;
+			bit-index = <31>;
+			clock-output-names = "gate_npu_clk";
+		};
+		gate_npu_e31_clk: npu-e31-clk-gate@180 {
+			compatible = "eswin,gate-clock";
+			reg = <0x180>;
+			#clock-cells = <0>;
+			clocks = <&divider_npu_e31_div>;
+			bit-index = <30>;
+			clock-output-names = "gate_npu_e31_clk";
+		};
+		gate_vi_dig_dw_clk: vi-dig-dw-clk-gate@184 {
+			compatible = "eswin,gate-clock";
+			reg = <0x184>;
+			#clock-cells = <0>;
+			clocks = <&divider_vi_dw_div>;
+			bit-index = <31>;
+			clock-output-names = "gate_vi_dig_dw_clk";
+		};
+		gate_vi_aclk: vi-aclk-gate@188 {
+			compatible = "eswin,gate-clock";
+			reg = <0x188>;
+			#clock-cells = <0>;
+			clocks = <&divider_vi_aclk_div>;
+			bit-index = <31>;
+			clock-output-names = "gate_vi_aclk";
+		};
+		gate_vi_cfg_clk: vi-cfg-clk-gate@188 {
+			compatible = "eswin,gate-clock";
+			reg = <0x188>;
+			#clock-cells = <0>;
+			clocks = <&mux_syscfg_clk_root_2mux1>;
+			bit-index = <30>;
+			clock-output-names = "gate_vi_cfg_clk";
+		};
+		gate_vi_dig_isp_clk: vi-dig-isp-clk-gate@18c {
+			compatible = "eswin,gate-clock";
+			reg = <0x18c>;
+			#clock-cells = <0>;
+			clocks = <&divider_vi_dig_isp_div>;
+			bit-index = <31>;
+			clock-output-names = "gate_vi_dig_isp_clk";
+		};
+		gate_vi_dvp_clk: vi-dvp-clk-gate@190 {
+			compatible = "eswin,gate-clock";
+			reg = <0x190>;
+			#clock-cells = <0>;
+			clocks = <&divider_vi_dvp_div>;
+			bit-index = <31>;
+			clock-output-names = "gate_vi_dvp_clk";
+		};
+		gate_vi_shutter_0: vi-shutter-0-gate@194 {
+			compatible = "eswin,gate-clock";
+			reg = <0x194>;
+			#clock-cells = <0>;
+			clocks = <&divider_vi_shutter_div_0>;
+			bit-index = <31>;
+			clock-output-names = "gate_vi_shutter_0";
+		};
+		gate_vi_shutter_1: vi-shutter-1-gate@198 {
+			compatible = "eswin,gate-clock";
+			reg = <0x198>;
+			#clock-cells = <0>;
+			clocks = <&divider_vi_shutter_div_1>;
+			bit-index = <31>;
+			clock-output-names = "gate_vi_shutter_1";
+		};
+		gate_vi_shutter_2: vi-shutter-2-gate@19c {
+			compatible = "eswin,gate-clock";
+			reg = <0x19c>;
+			#clock-cells = <0>;
+			clocks = <&divider_vi_shutter_div_2>;
+			bit-index = <31>;
+			clock-output-names = "gate_vi_shutter_2";
+		};
+		gate_vi_shutter_3: vi-shutter-3-gate@1a0 {
+			compatible = "eswin,gate-clock";
+			reg = <0x1a0>;
+			#clock-cells = <0>;
+			clocks = <&divider_vi_shutter_div_3>;
+			bit-index = <31>;
+			clock-output-names = "gate_vi_shutter_3";
+		};
+		gate_vi_shutter_4: vi-shutter-4-gate@1a4 {
+			compatible = "eswin,gate-clock";
+			reg = <0x1a4>;
+			#clock-cells = <0>;
+			clocks = <&divider_vi_shutter_div_4>;
+			bit-index = <31>;
+			clock-output-names = "gate_vi_shutter_4";
+		};
+		gate_vi_shutter_5: vi-shutter-5-gate@1a8 {
+			compatible = "eswin,gate-clock";
+			reg = <0x1a8>;
+			#clock-cells = <0>;
+			clocks = <&divider_vi_shutter_div_5>;
+			bit-index = <31>;
+			clock-output-names = "gate_vi_shutter_5";
+		};
+		gate_vi_phy_cfg: vi-phy-cfg-gate@1ac {
+			compatible = "eswin,gate-clock";
+			reg = <0x1ac>;
+			#clock-cells = <0>;
+			clocks = <&fixed_rate_clk_xtal_24m>;
+			bit-index = <1>;
+			clock-output-names = "gate_vi_phy_cfg";
+		};
+		gate_vi_phy_txclkesc: vi-phy-txclkesc-gate@1ac {
+			compatible = "eswin,gate-clock";
+			reg = <0x1ac>;
+			#clock-cells = <0>;
+			clocks = <&fixed_factor_mipi_txesc_div10>;
+			bit-index = <0>;
+			clock-output-names = "gate_vi_phy_txclkesc";
+		};
+		gate_vo_aclk: vo-aclk-gate@1b0 {
+			compatible = "eswin,gate-clock";
+			reg = <0x1b0>;
+			#clock-cells = <0>;
+			clocks = <&divider_vo_aclk_div>;
+			bit-index = <31>;
+			clock-output-names = "gate_vo_aclk";
+		};
+		gate_vo_cfg_clk: vo-cfg-clk-gate@1b0 {
+			compatible = "eswin,gate-clock";
+			reg = <0x1b0>;
+			#clock-cells = <0>;
+			clocks = <&mux_syscfg_clk_root_2mux1>;
+			bit-index = <30>;
+			clock-output-names = "gate_vo_cfg_clk";
+		};
+		gate_vo_hdmi_iesmclk: vo-hdmi-iesmclk-gate@1b4 {
+			compatible = "eswin,gate-clock";
+			reg = <0x1b4>;
+			#clock-cells = <0>;
+			clocks = <&divider_iesmclk_div>;
+			bit-index = <31>;
+			clock-output-names = "gate_vo_hdmi_iesmclk";
+		};
+		gate_vo_pixel_clk: vo-pixel-clk-gate@1b8 {
+			compatible = "eswin,gate-clock";
+			reg = <0x1b8>;
+			#clock-cells = <0>;
+			clocks = <&divider_vo_pixel_div>;
+			bit-index = <31>;
+			clock-output-names = "gate_vo_pixel_clk";
+		};
+		gate_vo_i2s_mclk: vo-i2s-mclk-gate@1bc {
+			compatible = "eswin,gate-clock";
+			reg = <0x1bc>;
+			#clock-cells = <0>;
+			clocks = <&mux_vo_mclk_2mux_ext_mclk>;
+			bit-index = <31>;
+			clock-output-names = "gate_vo_i2s_mclk";
+		};
+		gate_vo_cr_clk: vo-cr-clk-gate@1c0 {
+			compatible = "eswin,gate-clock";
+			reg = <0x1c0>;
+			#clock-cells = <0>;
+			clocks = <&fixed_factor_mipi_txesc_div10>;
+			bit-index = <1>;
+			clock-output-names = "gate_vo_cr_clk";
+		};
+		gate_vc_aclk: vc-aclk-gate@1c4 {
+			compatible = "eswin,gate-clock";
+			reg = <0x1c4>;
+			#clock-cells = <0>;
+			clocks = <&divider_vc_aclk_div>;
+			bit-index = <31>;
+			clock-output-names = "gate_vc_aclk";
+		};
+		gate_g2d_aclk: g2d-aclk-gate@1cc {
+			compatible = "eswin,gate-clock";
+			reg = <0x1cc>;
+			#clock-cells = <0>;
+			clocks = <&divider_g2d_div>;
+			bit-index = <31>;
+			clock-output-names = "gate_g2d_aclk";
+		};
+		gate_g2d_cfg_clk: g2d-cfg-clk-gate@1cc {
+			compatible = "eswin,gate-clock";
+			reg = <0x1cc>;
+			#clock-cells = <0>;
+			clocks = <&mux_syscfg_clk_root_2mux1>;
+			bit-index = <28>;
+			clock-output-names = "gate_g2d_cfg_clk";
+		};
+		gate_g2d_clk: g2d-clk-gate@1cc {
+			compatible = "eswin,gate-clock";
+			reg = <0x1cc>;
+			#clock-cells = <0>;
+			clocks = <&divider_g2d_div>;
+			bit-index = <30>;
+			clock-output-names = "gate_g2d_clk";
+		};
+		gate_vc_cfg_clk: vc-cfg-clk-gate@1d0 {
+			compatible = "eswin,gate-clock";
+			reg = <0x1d0>;
+			#clock-cells = <0>;
+			clocks = <&mux_syscfg_clk_root_2mux1>;
+			bit-index = <0>;
+			clock-output-names = "gate_vc_cfg_clk";
+		};
+		gate_vc_jd_pclk: vc-jd-pclk-gate@1d0 {
+			compatible = "eswin,gate-clock";
+			reg = <0x1d0>;
+			#clock-cells = <0>;
+			clocks = <&mux_syscfg_clk_root_2mux1>;
+			bit-index = <1>;
+			clock-output-names = "gate_vc_jd_pclk";
+		};
+		gate_vc_je_pclk: vc-je-pclk-gate@1d0 {
+			compatible = "eswin,gate-clock";
+			reg = <0x1d0>;
+			#clock-cells = <0>;
+			clocks = <&mux_syscfg_clk_root_2mux1>;
+			bit-index = <2>;
+			clock-output-names = "gate_vc_je_pclk";
+		};
+		gate_vc_mon_pclk: vc-mon-pclk-gate@1d0 {
+			compatible = "eswin,gate-clock";
+			reg = <0x1d0>;
+			#clock-cells = <0>;
+			clocks = <&mux_syscfg_clk_root_2mux1>;
+			bit-index = <3>;
+			clock-output-names = "gate_vc_mon_pclk";
+		};
+		gate_vc_vd_pclk: vc-vd-pclk-gate@1d0 {
+			compatible = "eswin,gate-clock";
+			reg = <0x1d0>;
+			#clock-cells = <0>;
+			clocks = <&mux_syscfg_clk_root_2mux1>;
+			bit-index = <4>;
+			clock-output-names = "gate_vc_vd_pclk";
+		};
+		gate_vc_ve_pclk: vc-ve-pclk-gate@1d0 {
+			compatible = "eswin,gate-clock";
+			reg = <0x1d0>;
+			#clock-cells = <0>;
+			clocks = <&mux_syscfg_clk_root_2mux1>;
+			bit-index = <5>;
+			clock-output-names = "gate_vc_ve_pclk";
+		};
+		gate_vc_je_clk: vc-je-clk-gate@1d4 {
+			compatible = "eswin,gate-clock";
+			reg = <0x1d4>;
+			#clock-cells = <0>;
+			clocks = <&divider_je_div>;
+			bit-index = <31>;
+			clock-output-names = "gate_vc_je_clk";
+		};
+		gate_vc_jd_clk: vc-jd-clk-gate@1d8 {
+			compatible = "eswin,gate-clock";
+			reg = <0x1d8>;
+			#clock-cells = <0>;
+			clocks = <&divider_jd_div>;
+			bit-index = <31>;
+			clock-output-names = "gate_vc_jd_clk";
+		};
+		gate_vc_vd_clk: vc-vd-clk-gate@1dc {
+			compatible = "eswin,gate-clock";
+			reg = <0x1dc>;
+			#clock-cells = <0>;
+			clocks = <&divider_vd_div>;
+			bit-index = <31>;
+			clock-output-names = "gate_vc_vd_clk";
+		};
+		gate_vc_ve_clk: vc-ve-clk-gate@1e0 {
+			compatible = "eswin,gate-clock";
+			reg = <0x1e0>;
+			#clock-cells = <0>;
+			clocks = <&divider_ve_div>;
+			bit-index = <31>;
+			clock-output-names = "gate_vc_ve_clk";
+		};
+		gate_aondma_aclk: aondma-aclk-gate@1e4 {
+			compatible = "eswin,gate-clock";
+			reg = <0x1e4>;
+			#clock-cells = <0>;
+			clocks = <&mux_aondma_axi2mux1>;
+			bit-index = <31>;
+			clock-output-names = "gate_aondma_aclk";
+		};
+		gate_aon_aclk: aon-aclk-gate@1e4 {
+			compatible = "eswin,gate-clock";
+			reg = <0x1e4>;
+			#clock-cells = <0>;
+			clocks = <&mux_aondma_axi2mux1>;
+			bit-index = <29>;
+			clock-output-names = "gate_aon_aclk";
+		};
+		gate_clk_aondma_cfg: clk-aondma-cfg-gate@1e4 {
+			compatible = "eswin,gate-clock";
+			reg = <0x1e4>;
+			#clock-cells = <0>;
+			clocks = <&mux_syscfg_clk_root_2mux1>;
+			bit-index = <30>;
+			clock-output-names = "gate_clk_aondma_cfg";
+		};
+		gate_timer3_clk8: timer3-clk8-gate@1e8 {
+			compatible = "eswin,gate-clock";
+			reg = <0x1e8>;
+			#clock-cells = <0>;
+			clocks = <&fixed_rate_clk_vpll_fout3>;
+			bit-index = <8>;
+			clock-output-names = "gate_timer3_clk8";
+		};
+		gate_timer_pclk_0: timer-pclk-0-gate@1e8 {
+			compatible = "eswin,gate-clock";
+			reg = <0x1e8>;
+			#clock-cells = <0>;
+			clocks = <&mux_syscfg_clk_root_2mux1>;
+			bit-index = <4>;
+			clock-output-names = "gate_timer_pclk_0";
+		};
+		gate_timer_pclk_1: timer-pclk-1-gate@1e8 {
+			compatible = "eswin,gate-clock";
+			reg = <0x1e8>;
+			#clock-cells = <0>;
+			clocks = <&mux_syscfg_clk_root_2mux1>;
+			bit-index = <5>;
+			clock-output-names = "gate_timer_pclk_1";
+		};
+		gate_timer_pclk_2: timer-pclk-2-gate@1e8 {
+			compatible = "eswin,gate-clock";
+			reg = <0x1e8>;
+			#clock-cells = <0>;
+			clocks = <&mux_syscfg_clk_root_2mux1>;
+			bit-index = <6>;
+			clock-output-names = "gate_timer_pclk_2";
+		};
+		gate_timer_pclk_3: timer-pclk-3-gate@1e8 {
+			compatible = "eswin,gate-clock";
+			reg = <0x1e8>;
+			#clock-cells = <0>;
+			clocks = <&mux_syscfg_clk_root_2mux1>;
+			bit-index = <7>;
+			clock-output-names = "gate_timer_pclk_3";
+		};
+		gate_time_clk_0: time-clk-0-gate@1e8 {
+			compatible = "eswin,gate-clock";
+			reg = <0x1e8>;
+			#clock-cells = <0>;
+			clocks = <&fixed_rate_clk_xtal_24m>;
+			bit-index = <0>;
+			clock-output-names = "gate_time_clk_0";
+		};
+		gate_time_clk_1: time-clk-1-gate@1e8 {
+			compatible = "eswin,gate-clock";
+			reg = <0x1e8>;
+			#clock-cells = <0>;
+			clocks = <&fixed_rate_clk_xtal_24m>;
+			bit-index = <1>;
+			clock-output-names = "gate_time_clk_1";
+		};
+		gate_time_clk_2: time-clk-2-gate@1e8 {
+			compatible = "eswin,gate-clock";
+			reg = <0x1e8>;
+			#clock-cells = <0>;
+			clocks = <&fixed_rate_clk_xtal_24m>;
+			bit-index = <2>;
+			clock-output-names = "gate_time_clk_2";
+		};
+		gate_time_clk_3: time-clk-3-gate@1e8 {
+			compatible = "eswin,gate-clock";
+			reg = <0x1e8>;
+			#clock-cells = <0>;
+			clocks = <&fixed_rate_clk_xtal_24m>;
+			bit-index = <3>;
+			clock-output-names = "gate_time_clk_3";
+		};
+		gate_clk_rtc: clk-rtc-gate@1ec {
+			compatible = "eswin,gate-clock";
+			reg = <0x1ec>;
+			#clock-cells = <0>;
+			clocks = <&divider_aon_rtc_div>;
+			bit-index = <1>;
+			clock-output-names = "gate_clk_rtc";
+		};
+		gate_clk_rtc_cfg: clk-rtc-cfg-gate@1ec {
+			compatible = "eswin,gate-clock";
+			reg = <0x1ec>;
+			#clock-cells = <0>;
+			clocks = <&mux_syscfg_clk_root_2mux1>;
+			bit-index = <2>;
+			clock-output-names = "gate_clk_rtc_cfg";
+		};
+		gate_clk_pka_cfg: clk-pka-cfg-gate@1f0 {
+			compatible = "eswin,gate-clock";
+			reg = <0x1f0>;
+			#clock-cells = <0>;
+			clocks = <&mux_syscfg_clk_root_2mux1>;
+			bit-index = <31>;
+			clock-output-names = "gate_clk_pka_cfg";
+		};
+		gate_clk_crypto: clk-crypto-gate@1f4 {
+			compatible = "eswin,gate-clock";
+			reg = <0x1f4>;
+			#clock-cells = <0>;
+			clocks = <&divider_crypto_div>;
+			bit-index = <30>;
+			clock-output-names = "gate_clk_crypto";
+		};
+		gate_clk_spacc_cfg: clk-spacc-cfg-gate@1f4 {
+			compatible = "eswin,gate-clock";
+			reg = <0x1f4>;
+			#clock-cells = <0>;
+			clocks = <&mux_syscfg_clk_root_2mux1>;
+			bit-index = <31>;
+			clock-output-names = "gate_clk_spacc_cfg";
+		};
+		gate_clk_trng_cfg: clk-trng-cfg-gate@1f8 {
+			compatible = "eswin,gate-clock";
+			reg = <0x1f8>;
+			#clock-cells = <0>;
+			clocks = <&mux_syscfg_clk_root_2mux1>;
+			bit-index = <31>;
+			clock-output-names = "gate_clk_trng_cfg";
+		};
+		gate_clk_otp_cfg: clk-otp-cfg-gate@1fc {
+			compatible = "eswin,gate-clock";
+			reg = <0x1fc>;
+			#clock-cells = <0>;
+			clocks = <&mux_syscfg_clk_root_2mux1>;
+			bit-index = <31>;
+			clock-output-names = "gate_clk_otp_cfg";
+		};
+		gate_i2c0_pclk: i2c0-pclk-gate@200 {
+			compatible = "eswin,gate-clock";
+			reg = <0x200>;
+			#clock-cells = <0>;
+			clocks = <&mux_syscfg_clk_root_2mux1>;
+			bit-index = <7>;
+			clock-output-names = "gate_i2c0_pclk";
+		};
+		gate_i2c1_pclk: i2c1-pclk-gate@200 {
+			compatible = "eswin,gate-clock";
+			reg = <0x200>;
+			#clock-cells = <0>;
+			clocks = <&mux_syscfg_clk_root_2mux1>;
+			bit-index = <8>;
+			clock-output-names = "gate_i2c1_pclk";
+		};
+		gate_i2c2_pclk: i2c2-pclk-gate@200 {
+			compatible = "eswin,gate-clock";
+			reg = <0x200>;
+			#clock-cells = <0>;
+			clocks = <&mux_syscfg_clk_root_2mux1>;
+			bit-index = <9>;
+			clock-output-names = "gate_i2c2_pclk";
+		};
+		gate_i2c3_pclk: i2c3-pclk-gate@200 {
+			compatible = "eswin,gate-clock";
+			reg = <0x200>;
+			#clock-cells = <0>;
+			clocks = <&mux_syscfg_clk_root_2mux1>;
+			bit-index = <10>;
+			clock-output-names = "gate_i2c3_pclk";
+		};
+		gate_i2c4_pclk: i2c4-pclk-gate@200 {
+			compatible = "eswin,gate-clock";
+			reg = <0x200>;
+			#clock-cells = <0>;
+			clocks = <&mux_syscfg_clk_root_2mux1>;
+			bit-index = <11>;
+			clock-output-names = "gate_i2c4_pclk";
+		};
+		gate_i2c5_pclk: i2c5-pclk-gate@200 {
+			compatible = "eswin,gate-clock";
+			reg = <0x200>;
+			#clock-cells = <0>;
+			clocks = <&mux_syscfg_clk_root_2mux1>;
+			bit-index = <12>;
+			clock-output-names = "gate_i2c5_pclk";
+		};
+		gate_i2c6_pclk: i2c6-pclk-gate@200 {
+			compatible = "eswin,gate-clock";
+			reg = <0x200>;
+			#clock-cells = <0>;
+			clocks = <&mux_syscfg_clk_root_2mux1>;
+			bit-index = <13>;
+			clock-output-names = "gate_i2c6_pclk";
+		};
+		gate_i2c7_pclk: i2c7-pclk-gate@200 {
+			compatible = "eswin,gate-clock";
+			reg = <0x200>;
+			#clock-cells = <0>;
+			clocks = <&mux_syscfg_clk_root_2mux1>;
+			bit-index = <14>;
+			clock-output-names = "gate_i2c7_pclk";
+		};
+		gate_i2c8_pclk: i2c8-pclk-gate@200 {
+			compatible = "eswin,gate-clock";
+			reg = <0x200>;
+			#clock-cells = <0>;
+			clocks = <&mux_syscfg_clk_root_2mux1>;
+			bit-index = <15>;
+			clock-output-names = "gate_i2c8_pclk";
+		};
+		gate_i2c9_pclk: i2c9-pclk-gate@200 {
+			compatible = "eswin,gate-clock";
+			reg = <0x200>;
+			#clock-cells = <0>;
+			clocks = <&mux_syscfg_clk_root_2mux1>;
+			bit-index = <16>;
+			clock-output-names = "gate_i2c9_pclk";
+		};
+		gate_lsp_fan_pclk: lsp-fan-pclk-gate@200 {
+			compatible = "eswin,gate-clock";
+			reg = <0x200>;
+			#clock-cells = <0>;
+			clocks = <&mux_syscfg_clk_root_2mux1>;
+			bit-index = <0>;
+			clock-output-names = "gate_lsp_fan_pclk";
+		};
+		gate_lsp_pvt_pclk: lsp-pvt-pclk-gate@200 {
+			compatible = "eswin,gate-clock";
+			reg = <0x200>;
+			#clock-cells = <0>;
+			clocks = <&mux_syscfg_clk_root_2mux1>;
+			bit-index = <1>;
+			clock-output-names = "gate_lsp_pvt_pclk";
+		};
+		gate_lsp_ssi0_pclk: lsp-ssi0-pclk-gate@200 {
+			compatible = "eswin,gate-clock";
+			reg = <0x200>;
+			#clock-cells = <0>;
+			clocks = <&mux_syscfg_clk_root_2mux1>;
+			bit-index = <26>;
+			clock-output-names = "gate_lsp_ssi0_pclk";
+		};
+		gate_lsp_ssi1_pclk: lsp-ssi1-pclk-gate@200 {
+			compatible = "eswin,gate-clock";
+			reg = <0x200>;
+			#clock-cells = <0>;
+			clocks = <&mux_syscfg_clk_root_2mux1>;
+			bit-index = <27>;
+			clock-output-names = "gate_lsp_ssi1_pclk";
+		};
+		gate_lsp_timer_pclk: lsp-timer-pclk-gate@200 {
+			compatible = "eswin,gate-clock";
+			reg = <0x200>;
+			#clock-cells = <0>;
+			clocks = <&mux_syscfg_clk_root_2mux1>;
+			bit-index = <25>;
+			clock-output-names = "gate_lsp_timer_pclk";
+		};
+		gate_lspart0_pclk: lsp-uart0-pclk-gate@200 {
+			compatible = "eswin,gate-clock";
+			reg = <0x200>;
+			#clock-cells = <0>;
+			clocks = <&mux_syscfg_clk_root_2mux1>;
+			bit-index = <17>;
+			clock-output-names = "gate_lsp_uart0_pclk";
+		};
+		gate_lsp_uart1_pclk: lsp-uart1-pclk-gate@200 {
+			compatible = "eswin,gate-clock";
+			reg = <0x200>;
+			#clock-cells = <0>;
+			clocks = <&mux_syscfg_clk_root_2mux1>;
+			bit-index = <18>;
+			clock-output-names = "gate_lsp_uart1_pclk";
+		};
+		gate_lsp_uart2_pclk: lsp-uart2-pclk-gate@200 {
+			compatible = "eswin,gate-clock";
+			reg = <0x200>;
+			#clock-cells = <0>;
+			clocks = <&mux_syscfg_clk_root_2mux1>;
+			bit-index = <19>;
+			clock-output-names = "gate_lsp_uart2_pclk";
+		};
+		gate_lsp_uart3_pclk: lsp-uart3-pclk-gate@200 {
+			compatible = "eswin,gate-clock";
+			reg = <0x200>;
+			#clock-cells = <0>;
+			clocks = <&mux_syscfg_clk_root_2mux1>;
+			bit-index = <20>;
+			clock-output-names = "gate_lsp_uart3_pclk";
+		};
+		gate_lsp_uart4_pclk: lsp-uart4-pclk-gate@200 {
+			compatible = "eswin,gate-clock";
+			reg = <0x200>;
+			#clock-cells = <0>;
+			clocks = <&mux_syscfg_clk_root_2mux1>;
+			bit-index = <21>;
+			clock-output-names = "gate_lsp_uart4_pclk";
+		};
+		gate_lsp_wdt0_pclk: lsp-wdt0-pclk-gate@200 {
+			compatible = "eswin,gate-clock";
+			reg = <0x200>;
+			#clock-cells = <0>;
+			clocks = <&mux_syscfg_clk_root_2mux1>;
+			bit-index = <28>;
+			clock-output-names = "gate_lsp_wdt0_pclk";
+		};
+		gate_lsp_wdt1_pclk: lsp-wdt1-pclk-gate@200 {
+			compatible = "eswin,gate-clock";
+			reg = <0x200>;
+			#clock-cells = <0>;
+			clocks = <&mux_syscfg_clk_root_2mux1>;
+			bit-index = <29>;
+			clock-output-names = "gate_lsp_wdt1_pclk";
+		};
+		gate_lsp_wdt2_pclk: lsp-wdt2-pclk-gate@200 {
+			compatible = "eswin,gate-clock";
+			reg = <0x200>;
+			#clock-cells = <0>;
+			clocks = <&mux_syscfg_clk_root_2mux1>;
+			bit-index = <30>;
+			clock-output-names = "gate_lsp_wdt2_pclk";
+		};
+		gate_lsp_wdt3_pclk: lsp-wdt3-pclk-gate@200 {
+			compatible = "eswin,gate-clock";
+			reg = <0x200>;
+			#clock-cells = <0>;
+			clocks = <&mux_syscfg_clk_root_2mux1>;
+			bit-index = <31>;
+			clock-output-names = "gate_lsp_wdt3_pclk";
+		};
+		gate_clk_mailbox_0: clk-mailbox-0-gate@204 {
+			compatible = "eswin,gate-clock";
+			reg = <0x204>;
+			#clock-cells = <0>;
+			clocks = <&mux_syscfg_clk_root_2mux1>;
+			bit-index = <0>;
+			clock-output-names = "gate_clk_mailbox_0";
+		};
+		gate_clk_mailbox_1: clk-mailbox-1-gate@204 {
+			compatible = "eswin,gate-clock";
+			reg = <0x204>;
+			#clock-cells = <0>;
+			clocks = <&mux_syscfg_clk_root_2mux1>;
+			bit-index = <1>;
+			clock-output-names = "gate_clk_mailbox_1";
+		};
+		gate_clk_mailbox_2: clk-mailbox-2-gate@204 {
+			compatible = "eswin,gate-clock";
+			reg = <0x204>;
+			#clock-cells = <0>;
+			clocks = <&mux_syscfg_clk_root_2mux1>;
+			bit-index = <2>;
+			clock-output-names = "gate_clk_mailbox_2";
+		};
+		gate_clk_mailbox_3: clk-mailbox-3-gate@204 {
+			compatible = "eswin,gate-clock";
+			reg = <0x204>;
+			#clock-cells = <0>;
+			clocks = <&mux_syscfg_clk_root_2mux1>;
+			bit-index = <3>;
+			clock-output-names = "gate_clk_mailbox_3";
+		};
+		gate_clk_mailbox_4: clk-mailbox-4-gate@204 {
+			compatible = "eswin,gate-clock";
+			reg = <0x204>;
+			#clock-cells = <0>;
+			clocks = <&mux_syscfg_clk_root_2mux1>;
+			bit-index = <4>;
+			clock-output-names = "gate_clk_mailbox_4";
+		};
+		gate_clk_mailbox_5: clk-mailbox-5-gate@204 {
+			compatible = "eswin,gate-clock";
+			reg = <0x204>;
+			#clock-cells = <0>;
+			clocks = <&mux_syscfg_clk_root_2mux1>;
+			bit-index = <5>;
+			clock-output-names = "gate_clk_mailbox_5";
+		};
+		gate_clk_mailbox_6: clk-mailbox-6-gate@204 {
+			compatible = "eswin,gate-clock";
+			reg = <0x204>;
+			#clock-cells = <0>;
+			clocks = <&mux_syscfg_clk_root_2mux1>;
+			bit-index = <6>;
+			clock-output-names = "gate_clk_mailbox_6";
+		};
+		gate_clk_mailbox_7: clk-mailbox-7-gate@204 {
+			compatible = "eswin,gate-clock";
+			reg = <0x204>;
+			#clock-cells = <0>;
+			clocks = <&mux_syscfg_clk_root_2mux1>;
+			bit-index = <7>;
+			clock-output-names = "gate_clk_mailbox_7";
+		};
+		gate_clk_mailbox_8: clk-mailbox-8-gate@204 {
+			compatible = "eswin,gate-clock";
+			reg = <0x204>;
+			#clock-cells = <0>;
+			clocks = <&mux_syscfg_clk_root_2mux1>;
+			bit-index = <8>;
+			clock-output-names = "gate_clk_mailbox_8";
+		};
+		gate_clk_mailbox_9: clk-mailbox-9-gate@204 {
+			compatible = "eswin,gate-clock";
+			reg = <0x204>;
+			#clock-cells = <0>;
+			clocks = <&mux_syscfg_clk_root_2mux1>;
+			bit-index = <9>;
+			clock-output-names = "gate_clk_mailbox_9";
+		};
+		gate_clk_mailbox_10: clk-mailbox-10-gate@204 {
+			compatible = "eswin,gate-clock";
+			reg = <0x204>;
+			#clock-cells = <0>;
+			clocks = <&mux_syscfg_clk_root_2mux1>;
+			bit-index = <10>;
+			clock-output-names = "gate_clk_mailbox_10";
+		};
+		gate_clk_mailbox_11: clk-mailbox-11-gate@204 {
+			compatible = "eswin,gate-clock";
+			reg = <0x204>;
+			#clock-cells = <0>;
+			clocks = <&mux_syscfg_clk_root_2mux1>;
+			bit-index = <11>;
+			clock-output-names = "gate_clk_mailbox_11";
+		};
+		gate_clk_mailbox_12: clk-mailbox-12-gate@204 {
+			compatible = "eswin,gate-clock";
+			reg = <0x204>;
+			#clock-cells = <0>;
+			clocks = <&mux_syscfg_clk_root_2mux1>;
+			bit-index = <12>;
+			clock-output-names = "gate_clk_mailbox_12";
+		};
+		gate_clk_mailbox_13: clk-mailbox-13-gate@204 {
+			compatible = "eswin,gate-clock";
+			reg = <0x204>;
+			#clock-cells = <0>;
+			clocks = <&mux_syscfg_clk_root_2mux1>;
+			bit-index = <13>;
+			clock-output-names = "gate_clk_mailbox_13";
+		};
+		gate_clk_mailbox_14: clk-mailbox-14-gate@204 {
+			compatible = "eswin,gate-clock";
+			reg = <0x204>;
+			#clock-cells = <0>;
+			clocks = <&mux_syscfg_clk_root_2mux1>;
+			bit-index = <14>;
+			clock-output-names = "gate_clk_mailbox_14";
+		};
+		gate_clk_mailbox_15: clk-mailbox-15-gate@204 {
+			compatible = "eswin,gate-clock";
+			reg = <0x204>;
+			#clock-cells = <0>;
+			clocks = <&mux_syscfg_clk_root_2mux1>;
+			bit-index = <15>;
+			clock-output-names = "gate_clk_mailbox_15";
+		};
+		gate_pvt0_clk: pvt0-clk-gate@204 {
+			compatible = "eswin,gate-clock";
+			reg = <0x204>;
+			#clock-cells = <0>;
+			clocks = <&fixed_factor_pvt_div20>;
+			bit-index = <16>;
+			clock-output-names = "gate_pvt0_clk";
+		};
+		gate_pvt1_clk: pvt1-clk-gate@204 {
+			compatible = "eswin,gate-clock";
+			reg = <0x204>;
+			#clock-cells = <0>;
+			clocks = <&fixed_factor_pvt_div20>;
+			bit-index = <17>;
+			clock-output-names = "gate_pvt1_clk";
+		};
+		gate_cpu_ext_src_core_0: cpu-ext-src-core-0-gate@208 {
+			compatible = "eswin,gate-clock";
+			reg = <0x208>;
+			#clock-cells = <0>;
+			clocks = <&mux_cpu_root_3mux1>;
+			bit-index = <28>;
+			clock-output-names = "gate_cpu_ext_src_core_0";
+		};
+		gate_cpu_ext_src_core_1: cpu-ext-src-core-1-gate@208 {
+			compatible = "eswin,gate-clock";
+			reg = <0x208>;
+			#clock-cells = <0>;
+			clocks = <&mux_cpu_root_3mux1>;
+			bit-index = <29>;
+			clock-output-names = "gate_cpu_ext_src_core_1";
+		};
+		gate_cpu_ext_src_core_2: cpu-ext-src-core-2-gate@208 {
+			compatible = "eswin,gate-clock";
+			reg = <0x208>;
+			#clock-cells = <0>;
+			clocks = <&mux_cpu_root_3mux1>;
+			bit-index = <30>;
+			clock-output-names = "gate_cpu_ext_src_core_2";
+		};
+		gate_cpu_ext_src_core_3: cpu-ext-src-core-3-gate@208 {
+			compatible = "eswin,gate-clock";
+			reg = <0x208>;
+			#clock-cells = <0>;
+			clocks = <&mux_cpu_root_3mux1>;
+			bit-index = <31>;
+			clock-output-names = "gate_cpu_ext_src_core_3";
+		};
+		gate_clk_cpu_trace_clk_0: clk-cpu-trace-clk-0-gate@208 {
+			compatible = "eswin,gate-clock";
+			reg = <0x208>;
+			#clock-cells = <0>;
+			clocks = <&mux_cpu_root_3mux1>;
+			bit-index = <24>;
+			clock-output-names = "gate_clk_cpu_trace_clk_0";
+		};
+		gate_clk_cpu_trace_clk_1: clk-cpu-trace-clk-1-gate@208 {
+			compatible = "eswin,gate-clock";
+			reg = <0x208>;
+			#clock-cells = <0>;
+			clocks = <&mux_cpu_root_3mux1>;
+			bit-index = <25>;
+			clock-output-names = "gate_clk_cpu_trace_clk_1";
+		};
+		gate_clk_cpu_trace_clk_2: clk-cpu-trace-clk-2-gate@208 {
+			compatible = "eswin,gate-clock";
+			reg = <0x208>;
+			#clock-cells = <0>;
+			clocks = <&mux_cpu_root_3mux1>;
+			bit-index = <26>;
+			clock-output-names = "gate_clk_cpu_trace_clk_2";
+		};
+		gate_clk_cpu_trace_clk_3: clk-cpu-trace-clk-3-gate@208 {
+			compatible = "eswin,gate-clock";
+			reg = <0x208>;
+			#clock-cells = <0>;
+			clocks = <&mux_cpu_root_3mux1>;
+			bit-index = <27>;
+			clock-output-names = "gate_clk_cpu_trace_clk_3";
+		};
+		gate_clk_cpu_trace_com_clk: clk-cpu-trace-com-clk-gate@208 {
+			compatible = "eswin,gate-clock";
+			reg = <0x208>;
+			#clock-cells = <0>;
+			clocks = <&mux_cpu_aclk_2mux1>;
+			bit-index = <23>;
+			clock-output-names = "gate_clk_cpu_trace_com_clk";
+		};
+		gate_aon_i2c0_pclk: aon-i2c0-pclk-gate@210 {
+			compatible = "eswin,gate-clock";
+			reg = <0x210>;
+			#clock-cells = <0>;
+			clocks = <&mux_syscfg_clk_root_2mux1>;
+			bit-index = <31>;
+			clock-output-names = "gate_aon_i2c0_pclk";
+		};
+		gate_aon_i2c1_pclk: aon-i2c1-pclk-gate@214 {
+			compatible = "eswin,gate-clock";
+			reg = <0x214>;
+			#clock-cells = <0>;
+			clocks = <&mux_syscfg_clk_root_2mux1>;
+			bit-index = <31>;
+			clock-output-names = "gate_aon_i2c1_pclk";
+		};
+	};
+};
--
2.17.1


