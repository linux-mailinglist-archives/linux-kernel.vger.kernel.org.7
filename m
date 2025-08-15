Return-Path: <linux-kernel+bounces-770469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB06AB27B43
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 10:38:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23BDB626300
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 08:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88AB625743E;
	Fri, 15 Aug 2025 08:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KIQskRPg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5073225A4F;
	Fri, 15 Aug 2025 08:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755247061; cv=none; b=iN6+knmcC8+26DhOzIXRmHzKIb05nI/2F3RAXCzLx5rLhtE5e8e+u/N6/56XiBqjUZLnAEeLCigE5lsRy0tG6dl2vyxaXsJAX0DfPvwwVtPKxrw+cRYO5Cy7l28FIJN8xnKc3sSGX8DS8XqhTU/bn20tynEI8WPejOi8t2S1A1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755247061; c=relaxed/simple;
	bh=Vag6wGtu+suGJmuhRU5XEAgwSSUZw7icX5H63EyrARo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fnzznP/7pOJ/W1SyO8B18kbsyJGiq3Ni547zecfA/cTdZi2RxyTKhHIRWL2zheXwI8tI85+WOwruIRbG9DaeXOxXlkQcnUx/PqQlydQGbbJyvsgaB4CEFNdvDi+u6PKKyV9sqodEpZ5KcugsO9lvug5eWyQ91Ke/DbLeFRvUrEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KIQskRPg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 53C51C4CEF8;
	Fri, 15 Aug 2025 08:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755247061;
	bh=Vag6wGtu+suGJmuhRU5XEAgwSSUZw7icX5H63EyrARo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=KIQskRPgr6ey4+Awv/m0V64oz39jwPYMPXd1XTv6HGMo5WEpP8w85zi1I2oj9plPH
	 J5rsm1lujvG0oD8qFCDli1psAJfGj+Ka48zYGTKJYxO2ydYUN8NXJca3XtY1Qpnmtu
	 cSESLT6PA84R449Wp9s10ozeMHgfw19Gjf743SFcS1Fr0PEH6oJhOsZXZkJvOhHbyK
	 biDfQuk5YNf8xzrK7fqhF9XB/LLx0w9soSmzUULL8UvtfS2R9/bML2a877ok2TV/n0
	 01PDMryhqYi5Kcls1LB+JXgPwQX1Iai7nzyu8xgMZHf2w2ac53wHsTypor4fzPZtw1
	 8+gn0jdj/bl2Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47018CA0EE0;
	Fri, 15 Aug 2025 08:37:41 +0000 (UTC)
From: Chuan Liu via B4 Relay <devnull+chuan.liu.amlogic.com@kernel.org>
Date: Fri, 15 Aug 2025 16:37:29 +0800
Subject: [PATCH 03/13] ARM: dts: amlogic: add clk-measure IDs and names for
 meson SoC family
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250815-add-more-socs-to-support-clk_measure-v1-3-59f04ba67457@amlogic.com>
References: <20250815-add-more-socs-to-support-clk_measure-v1-0-59f04ba67457@amlogic.com>
In-Reply-To: <20250815-add-more-socs-to-support-clk_measure-v1-0-59f04ba67457@amlogic.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Chuan Liu <chuan.liu@amlogic.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755247057; l=4791;
 i=chuan.liu@amlogic.com; s=20240902; h=from:subject:message-id;
 bh=l3K7Yyi1QbVnRco0ODiFhzNHVuFGmS+WerLaTtYEH3c=;
 b=TrZmR2cg/qIqhAS3j+OceUmOc0G8xq6bmRF+Evy0oSHZU1h9Vjc2E1+VmdaPFXyyHZ4HCSZov
 /hyPeKpDH24CCDnFx0uECIES85Ac/7fJn4dTJFn+lMSTbVaj3RbnT2I
X-Developer-Key: i=chuan.liu@amlogic.com; a=ed25519;
 pk=fnKDB+81SoWGKW2GJNFkKy/ULvsDmJZRGBE7pR5Xcpo=
X-Endpoint-Received: by B4 Relay for chuan.liu@amlogic.com/20240902 with
 auth_id=203
X-Original-From: Chuan Liu <chuan.liu@amlogic.com>
Reply-To: chuan.liu@amlogic.com

From: Chuan Liu <chuan.liu@amlogic.com>

In the clk-measure driver, the method has been changed to obtain the
supported IDs and their corresponding names for SoC clk-measure through
DTS, adding support for mes8 and mes8b here.

Signed-off-by: Chuan Liu <chuan.liu@amlogic.com>
---
 arch/arm/boot/dts/amlogic/meson8.dtsi  | 92 ++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/amlogic/meson8b.dtsi | 92 ++++++++++++++++++++++++++++++++++
 2 files changed, 184 insertions(+)

diff --git a/arch/arm/boot/dts/amlogic/meson8.dtsi b/arch/arm/boot/dts/amlogic/meson8.dtsi
index a609b5a0fda4..2f9ecd2eb4cf 100644
--- a/arch/arm/boot/dts/amlogic/meson8.dtsi
+++ b/arch/arm/boot/dts/amlogic/meson8.dtsi
@@ -462,6 +462,98 @@ pwm_ef: pwm@86c0 {
 	clock-measure@8758 {
 		compatible = "amlogic,meson8-clk-measure";
 		reg = <0x8758 0x1c>;
+		clkmsr-indices = <0>,
+				 <1>,
+				 <2>,
+				 <3>,
+				 <6>,
+				 <7>,
+				 <8>,
+				 <9>,
+				 <11>,
+				 <13>,
+				 <14>,
+				 <15>,
+				 <16>,
+				 <18>,
+				 <19>,
+				 <20>,
+				 <21>,
+				 <22>,
+				 <23>,
+				 <24>,
+				 <26>,
+				 <28>,
+				 <30>,
+				 <31>,
+				 <32>,
+				 <33>,
+				 <34>,
+				 <35>,
+				 <36>,
+				 <38>,
+				 <39>,
+				 <40>,
+				 <41>,
+				 <42>,
+				 <43>,
+				 <44>,
+				 <45>,
+				 <46>,
+				 <47>,
+				 <48>,
+				 <49>,
+				 <59>,
+				 <60>,
+				 <61>,
+				 <62>,
+				 <63>;
+		clkmsr-names = "ring_osc_out_ee0",
+			       "ring_osc_out_ee1",
+			       "ring_osc_out_ee2",
+			       "a9_ring_osck",
+			       "vid_pll",
+			       "clk81",
+			       "encp",
+			       "encl",
+			       "eth_rmii",
+			       "amclk",
+			       "fec_clk_0",
+			       "fec_clk_1",
+			       "fec_clk_2",
+			       "a9_clk_div16",
+			       "hdmi_sys",
+			       "rtc_osc_clk_out",
+			       "i2s_clk_in_src0",
+			       "clk_rmii_from_pad",
+			       "hdmi_ch0_tmds",
+			       "lvds_fifo",
+			       "sc_clk_int",
+			       "sar_adc",
+			       "mpll_clk_test_out",
+			       "audac_clkpi",
+			       "vdac",
+			       "sdhc_rx",
+			       "sdhc_sd",
+			       "mali",
+			       "hdmi_tx_pixel",
+			       "vdin_meas",
+			       "pcm_sclk",
+			       "pcm_mclk",
+			       "eth_rx_tx",
+			       "pwm_d",
+			       "pwm_c",
+			       "pwm_b",
+			       "pwm_a",
+			       "pcm2_sclk",
+			       "ddr_dpll_pt",
+			       "pwm_f",
+			       "pwm_e",
+			       "hcodec",
+			       "usb_32k_alt",
+			       "gpio",
+			       "vid2_pll",
+			       "mipi_csi_cfg";
 	};
 
 	pinctrl_cbus: pinctrl@8030 {
diff --git a/arch/arm/boot/dts/amlogic/meson8b.dtsi b/arch/arm/boot/dts/amlogic/meson8b.dtsi
index 2d77b9876bf4..74fd000569a2 100644
--- a/arch/arm/boot/dts/amlogic/meson8b.dtsi
+++ b/arch/arm/boot/dts/amlogic/meson8b.dtsi
@@ -416,6 +416,98 @@ pwm_ef: pwm@86c0 {
 	clock-measure@8758 {
 		compatible = "amlogic,meson8b-clk-measure";
 		reg = <0x8758 0x1c>;
+		clkmsr-indices = <0>,
+				 <1>,
+				 <2>,
+				 <3>,
+				 <6>,
+				 <7>,
+				 <8>,
+				 <9>,
+				 <11>,
+				 <13>,
+				 <14>,
+				 <15>,
+				 <16>,
+				 <18>,
+				 <19>,
+				 <20>,
+				 <21>,
+				 <22>,
+				 <23>,
+				 <24>,
+				 <26>,
+				 <28>,
+				 <30>,
+				 <31>,
+				 <32>,
+				 <33>,
+				 <34>,
+				 <35>,
+				 <36>,
+				 <38>,
+				 <39>,
+				 <40>,
+				 <41>,
+				 <42>,
+				 <43>,
+				 <44>,
+				 <45>,
+				 <46>,
+				 <47>,
+				 <48>,
+				 <49>,
+				 <59>,
+				 <60>,
+				 <61>,
+				 <62>,
+				 <63>;
+		clkmsr-names = "ring_osc_out_ee0",
+			       "ring_osc_out_ee1",
+			       "ring_osc_out_ee2",
+			       "a9_ring_osck",
+			       "vid_pll",
+			       "clk81",
+			       "encp",
+			       "encl",
+			       "eth_rmii",
+			       "amclk",
+			       "fec_clk_0",
+			       "fec_clk_1",
+			       "fec_clk_2",
+			       "a9_clk_div16",
+			       "hdmi_sys",
+			       "rtc_osc_clk_out",
+			       "i2s_clk_in_src0",
+			       "clk_rmii_from_pad",
+			       "hdmi_ch0_tmds",
+			       "lvds_fifo",
+			       "sc_clk_int",
+			       "sar_adc",
+			       "mpll_clk_test_out",
+			       "audac_clkpi",
+			       "vdac",
+			       "sdhc_rx",
+			       "sdhc_sd",
+			       "mali",
+			       "hdmi_tx_pixel",
+			       "vdin_meas",
+			       "pcm_sclk",
+			       "pcm_mclk",
+			       "eth_rx_tx",
+			       "pwm_d",
+			       "pwm_c",
+			       "pwm_b",
+			       "pwm_a",
+			       "pcm2_sclk",
+			       "ddr_dpll_pt",
+			       "pwm_f",
+			       "pwm_e",
+			       "hcodec",
+			       "usb_32k_alt",
+			       "gpio",
+			       "vid2_pll",
+			       "mipi_csi_cfg";
 	};
 
 	pinctrl_cbus: pinctrl@8030 {

-- 
2.42.0



