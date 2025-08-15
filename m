Return-Path: <linux-kernel+bounces-770477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EA02B27B4A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 10:39:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5EA1A24064
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 08:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61CB42D23B6;
	Fri, 15 Aug 2025 08:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GG1Ie9jT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0052D24466C;
	Fri, 15 Aug 2025 08:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755247062; cv=none; b=Jwqhd5odLJXeVmTb2aufzyna2n+rMLwqcykAZzmJYeZa+ME02DVKnzIuM9ytKKHkdcx7g2W9zOQ8v+AsiIhn0BVgQpi3ZxI3r1SQvrwYD99x62W9AWQ9FpZL46kfIbA+KqHo7WtDQ3hFwAjFktTblQbdiUF08mxxvHJl4Bk2w+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755247062; c=relaxed/simple;
	bh=VFGd5hRIkRHvzlQy80MpxiKKkC07jgnJaMdRjA7K6w4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Eh+0IARCI6qdBf/6efPN5dRdCBXYC4XWTutSd7NP3XnBaBzna3I66yCXNC6lfuaGiRVEDHVvE9ft78dtA1mO1zMSig4/XqV8BlkvDCZvJd+ARrZRClZCvObeRQFZhzozQ1QFooesA5/PSt8hBGeXEW8w1BpW6GGbDsqW+htiS5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GG1Ie9jT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 982DDC19424;
	Fri, 15 Aug 2025 08:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755247061;
	bh=VFGd5hRIkRHvzlQy80MpxiKKkC07jgnJaMdRjA7K6w4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=GG1Ie9jTwDKhOS4SsBEhMfLscvhIJRDyDLL6yAHAg45liuMjDsPHKalqlOBylHAGv
	 r5pVn3ok9JF5z0OhCQ2i/ZNScsvTne7c2xkZAhy8hhqxQV5no3xjcE+EF4zF/pTxmP
	 mBrxyRmMshfFpROvSNZ/gmNNlezod3xJcpHxdD+MSoh/BoDTYy1C8/Ysw8/RkPtWq8
	 p/7+YN8f78/sCrsMJWZ3g6hv+9FbpjNfXtpfazTVt8uZSgCDHvKtHjuAAAyEb+GzWw
	 4/Mqb3/zgXGt51FjmJ0ADIfuOrKUlbn9vpmbAVdB55BOtfUV6j8r25xrbLTOCniBI0
	 a497iJbNsG7KA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9196DCA0EE8;
	Fri, 15 Aug 2025 08:37:41 +0000 (UTC)
From: Chuan Liu via B4 Relay <devnull+chuan.liu.amlogic.com@kernel.org>
Date: Fri, 15 Aug 2025 16:37:35 +0800
Subject: [PATCH 09/13] arm64: dts: amlogic: A4: Add clk-measure controller
 node
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250815-add-more-socs-to-support-clk_measure-v1-9-59f04ba67457@amlogic.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755247057; l=5269;
 i=chuan.liu@amlogic.com; s=20240902; h=from:subject:message-id;
 bh=X0XY9aZjdMBy/BejERaULKB1+6dEiqZglq+Tq7M/WTk=;
 b=r7nrSwjawPgfJtx0VHM0LteREbh/rLUqECbuzDuRObH93zlbrdxKoHYaVrS33WF3uPmy86T+3
 tAQjLfMTPz9CuYpGDyRCoMp91fHSeBCv0ATINdpo3wpoBmJQBrSvH5m
X-Developer-Key: i=chuan.liu@amlogic.com; a=ed25519;
 pk=fnKDB+81SoWGKW2GJNFkKy/ULvsDmJZRGBE7pR5Xcpo=
X-Endpoint-Received: by B4 Relay for chuan.liu@amlogic.com/20240902 with
 auth_id=203
X-Original-From: Chuan Liu <chuan.liu@amlogic.com>
Reply-To: chuan.liu@amlogic.com

From: Chuan Liu <chuan.liu@amlogic.com>

Add the clk-measure controller node for A4 SoC family.

Signed-off-by: Chuan Liu <chuan.liu@amlogic.com>
---
 arch/arm64/boot/dts/amlogic/amlogic-a4.dtsi | 212 ++++++++++++++++++++++++++++
 1 file changed, 212 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/amlogic-a4.dtsi b/arch/arm64/boot/dts/amlogic/amlogic-a4.dtsi
index 563bc2e662fa..471a4bd24bfb 100644
--- a/arch/arm64/boot/dts/amlogic/amlogic-a4.dtsi
+++ b/arch/arm64/boot/dts/amlogic/amlogic-a4.dtsi
@@ -170,6 +170,218 @@ gpio_intc: interrupt-controller@4080 {
 			<10 11 12 13 14 15 16 17 18 19 20 21>;
 	};
 
+	clk_msr: clock-measure@48000 {
+		compatible = "amlogic,clk-measure";
+		reg = <0x0 0x48000 0x0 0x1c>;
+		clkmsr-reg-v2;
+		clkmsr-indices = <0>,
+				 <1>,
+				 <2>,
+				 <3>,
+				 <4>,
+				 <5>,
+				 <6>,
+				 <8>,
+				 <10>,
+				 <15>,
+				 <16>,
+				 <17>,
+				 <19>,
+				 <20>,
+				 <21>,
+				 <22>,
+				 <23>,
+				 <24>,
+				 <27>,
+				 <28>,
+				 <30>,
+				 <31>,
+				 <32>,
+				 <33>,
+				 <34>,
+				 <35>,
+				 <36>,
+				 <37>,
+				 <38>,
+				 <39>,
+				 <40>,
+				 <41>,
+				 <51>,
+				 <52>,
+				 <79>,
+				 <106>,
+				 <111>,
+				 <112>,
+				 <113>,
+				 <115>,
+				 <116>,
+				 <117>,
+				 <118>,
+				 <119>,
+				 <120>,
+				 <121>,
+				 <122>,
+				 <123>,
+				 <124>,
+				 <125>,
+				 <126>,
+				 <127>,
+				 <128>,
+				 <129>,
+				 <130>,
+				 <131>,
+				 <132>,
+				 <133>,
+				 <134>,
+				 <135>,
+				 <136>,
+				 <137>,
+				 <138>,
+				 <139>,
+				 <140>,
+				 <141>,
+				 <142>,
+				 <143>,
+				 <144>,
+				 <145>,
+				 <146>,
+				 <147>,
+				 <148>,
+				 <149>,
+				 <150>,
+				 <151>,
+				 <152>,
+				 <153>,
+				 <154>,
+				 <155>,
+				 <156>,
+				 <157>,
+				 <158>,
+				 <159>,
+				 <162>,
+				 <163>,
+				 <164>,
+				 <165>,
+				 <166>,
+				 <167>,
+				 <168>,
+				 <169>,
+				 <176>,
+				 <177>,
+				 <178>,
+				 <179>,
+				 <180>,
+				 <181>,
+				 <182>,
+				 <183>,
+				 <184>,
+				 <185>,
+				 <186>;
+		clkmsr-names = "sys_clk",
+			       "axi_clk",
+			       "rtc_clk",
+			       "p22_usb2_ckout",
+			       "p21_usb2_ckout",
+			       "p20_usb2_ckout",
+			       "cpu_clk_div16",
+			       "eth_mpll_test",
+			       "fclk_div5",
+			       "fclk_50m",
+			       "sys_oscin32k_i",
+			       "rtc_pll",
+			       "hifi_pll",
+			       "gp0_pll",
+			       "gp1_pll",
+			       "eth_fclk_50m_clkout",
+			       "sys_pll_div16",
+			       "ddr_dpll_pt_clk",
+			       "rtc_sec_pulse_out",
+			       "rtc_osc_clk_out",
+			       "mod_eth_phy_ref_clk",
+			       "mod_eth_tx_clk",
+			       "eth_125m",
+			       "eth_rmii",
+			       "co_clkin_to_mac",
+			       "mod_eth_rx_clk_rmii",
+			       "co_rx_clk",
+			       "co_tx_clk",
+			       "eth_phy_rxclk",
+			       "eth_phy_plltxclk",
+			       "ephy_test_clk",
+			       "audio_core_clk",
+			       "vout_venc_clk_ph",
+			       "vout_venc_clk",
+			       "rama_clk",
+			       "deskew_pll_test_clk",
+			       "saradc",
+			       "ts",
+			       "sd_emmc_c",
+			       "sd_emmc_a",
+			       "gpio_msr_clk",
+			       "spicc_1",
+			       "spicc_0",
+			       "o_mst_sclk_vad",
+			       "o_mst_mclk_vad",
+			       "o_pdm_sysclk",
+			       "mod_audio_pdm_dclk_o",
+			       "o_vad_clk",
+			       "earcrx_dmac_clk",
+			       "earcrx_cmdc_clk",
+			       "earctx_dmac_clk",
+			       "earctx_cmdc_clk",
+			       "tohdmitx_bclk",
+			       "tohdmitx_mclk",
+			       "tohdmitx_spdif_clk",
+			       "toacodec_bclk",
+			       "toacodec_mclk",
+			       "spdifout_b_mst_clk",
+			       "spdifout_mst_clk",
+			       "spdifin_mst_clk",
+			       "audio_mclk",
+			       "vad_clk",
+			       "tdmout_d_sclk",
+			       "tdmout_c_sclk",
+			       "tdmout_b_sclk",
+			       "tdmout_a_sclk",
+			       "tdminb_lb_sclk",
+			       "tdmin_lb_sclk",
+			       "tdmin_d_sclk",
+			       "tdmin_c_sclk",
+			       "tdmin_b_sclk",
+			       "tdmin_a_sclk",
+			       "resampleb_clk",
+			       "resamplea_clk",
+			       "pdmb_sysclk",
+			       "pdmb_dclk",
+			       "pdm_sysclk",
+			       "pdm_dclk",
+			       "alockerb_out_clk",
+			       "alockerb_in_clk",
+			       "alocker_out_clk",
+			       "alocker_in_clk",
+			       "audio_mst_clk[34]",
+			       "audio_mst_clk[35]",
+			       "pwm_h",
+			       "pwm_g",
+			       "pwm_f",
+			       "pwm_e",
+			       "pwm_d",
+			       "pwm_c",
+			       "pwm_b",
+			       "pwm_a",
+			       "rng_ring_osc_clk[0]",
+			       "rng_ring_osc_clk[1]",
+			       "rng_ring_osc_clk[2]",
+			       "rng_ring_osc_clk[3]",
+			       "sys_cpu_osc_ring[0](ULVT16)",
+			       "sys_cpu_osc_ring[1](ULVT20)",
+			       "sys_cpu_osc_ring[2](ULVT16)",
+			       "sys_cpu_osc_ring[3](ULVT16)",
+			       "sys_cpu_osc_ring[4](ULVT16)",
+			       "am_ring_osc_clk_out_top[0](SVT16)",
+			       "am_ring_osc_clk_out_top[1](LVT20)";
+	};
+
 	ao_pinctrl: pinctrl@8e700 {
 		compatible = "amlogic,pinctrl-a4";
 		#address-cells = <2>;

-- 
2.42.0



