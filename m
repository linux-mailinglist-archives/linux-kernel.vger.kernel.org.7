Return-Path: <linux-kernel+bounces-602623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E35CCA87D35
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Apr 2025 12:13:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E05A162AA0
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Apr 2025 10:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D80C52690CE;
	Mon, 14 Apr 2025 10:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fL6hDZHh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B246264FB2;
	Mon, 14 Apr 2025 10:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744625576; cv=none; b=k7qbP7595yPDDwvBppV5J3PAVkbFxB+lbu+OuMaf2Q0NiM8AiPUrgyUFOfDAJ8pk5VGklqnXjkINUnhEuGytjoJtJbF76lgzbKiBLUglF8MFQMIvb3bAYVcs46oULBDFP8W+lnVSxXJ6wR+f7j5VeFdQCIBPzjeifawHNuR4d1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744625576; c=relaxed/simple;
	bh=lawTPlEWBNrpmsUAEJ3a2nqdx22fCqWe8OZPiyf0Vpk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Hy8dC6tz496g7/4qKQhPPdRs1HpNgI1FRzpr3X9r96J3vNc0e2Vm33hugSFdY4unQLVaB59rFA6p9+Mv+hVfgzY/dSX+uA8gLwH88iKXTSuyNfGZnuXGH9xjL9N8eTUV3R3/fmkiYRC09Oak1zfUrxkMhbXQAnmYAY7yODF3Gps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fL6hDZHh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D4B8DC4CEED;
	Mon, 14 Apr 2025 10:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744625575;
	bh=lawTPlEWBNrpmsUAEJ3a2nqdx22fCqWe8OZPiyf0Vpk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=fL6hDZHhHtmzEX7J0C+nt2NrcyxPHnF6KxscSkHIPGMhImzye42Bf7PXUGc7qmp4t
	 jFpfSwnXIokmmTnFxQ52PmFTQihDDSHkbMsR2RuCCXjymVm/q4MSosR9ZKJgUBysdj
	 ZpEK4NY9cvBHJHhMR6570mDTZUO/wIpCApyW24/+WuvRQBvV+Rf4QVeHkxcMjSh3Gn
	 +lGazLDZd49zSY1YoAdi1ShTU+pdYBF82UMr2ZDbuxHiM41cRfHusdLSB6X44yjUeW
	 r+q6ZKuD8WKQG9nb+EYnfsWlAzM1wWJ+bnv32AX78lk9Rx8gk9VyWF0BLBpOtc3wPi
	 rdPoHMca01g+Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9A6FC369B9;
	Mon, 14 Apr 2025 10:12:55 +0000 (UTC)
From: Chuan Liu via B4 Relay <devnull+chuan.liu.amlogic.com@kernel.org>
Date: Mon, 14 Apr 2025 18:12:31 +0800
Subject: [PATCH v2 4/7] soc: amlogic: clk-measure: Add support for C3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250414-clk-measure-v2-4-65077690053a@amlogic.com>
References: <20250414-clk-measure-v2-0-65077690053a@amlogic.com>
In-Reply-To: <20250414-clk-measure-v2-0-65077690053a@amlogic.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Chuan Liu <chuan.liu@amlogic.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744625573; l=6690;
 i=chuan.liu@amlogic.com; s=20240902; h=from:subject:message-id;
 bh=5IKQzZzkHNcYRV76KtgkiOFs5UjhFwnt2rPvLFuVIO4=;
 b=acBLkRsoLCAmiIu3KkKqmnuwU0PJ0hBmrQm/D4kygfXKowcuP2kispAcyKocZkJbjCJ8OINaD
 MY6JNigM/aKC8z/SH4kjYhYwjcS3NUqgl0oy+jaxP5ZK6TX0+nbgiI7
X-Developer-Key: i=chuan.liu@amlogic.com; a=ed25519;
 pk=fnKDB+81SoWGKW2GJNFkKy/ULvsDmJZRGBE7pR5Xcpo=
X-Endpoint-Received: by B4 Relay for chuan.liu@amlogic.com/20240902 with
 auth_id=203
X-Original-From: Chuan Liu <chuan.liu@amlogic.com>
Reply-To: chuan.liu@amlogic.com

From: Chuan Liu <chuan.liu@amlogic.com>

Add the clk-measurer clocks IDs for the Amlogic C3 SoC family.

Signed-off-by: Chuan Liu <chuan.liu@amlogic.com>
---
 drivers/soc/amlogic/meson-clk-measure.c | 157 ++++++++++++++++++++++++++++++++
 1 file changed, 157 insertions(+)

diff --git a/drivers/soc/amlogic/meson-clk-measure.c b/drivers/soc/amlogic/meson-clk-measure.c
index 82c008ade894..810454ac4119 100644
--- a/drivers/soc/amlogic/meson-clk-measure.c
+++ b/drivers/soc/amlogic/meson-clk-measure.c
@@ -494,6 +494,146 @@ static const struct meson_msr_id clk_msr_sm1[] = {
 	CLK_MSR_ID(127, "csi2_data"),
 };
 
+static const struct meson_msr_id clk_msr_c3[] = {
+	CLK_MSR_ID(0,	"sys_clk"),
+	CLK_MSR_ID(1,	"axi_clk"),
+	CLK_MSR_ID(2,	"rtc_clk"),
+	CLK_MSR_ID(3,	"p20_usb2_ckout"),
+	CLK_MSR_ID(4,	"eth_mpll_test"),
+	CLK_MSR_ID(5,	"sys_pll"),
+	CLK_MSR_ID(6,	"cpu_clk_div16"),
+	CLK_MSR_ID(7,	"ts_pll"),
+	CLK_MSR_ID(8,	"fclk_div2"),
+	CLK_MSR_ID(9,	"fclk_div2p5"),
+	CLK_MSR_ID(10,	"fclk_div3"),
+	CLK_MSR_ID(11,	"fclk_div4"),
+	CLK_MSR_ID(12,	"fclk_div5"),
+	CLK_MSR_ID(13,	"fclk_div7"),
+	CLK_MSR_ID(15,	"fclk_50m"),
+	CLK_MSR_ID(16,	"sys_oscin32k_i"),
+	CLK_MSR_ID(17,	"mclk_pll"),
+	CLK_MSR_ID(19,	"hifi_pll"),
+	CLK_MSR_ID(20,	"gp0_pll"),
+	CLK_MSR_ID(21,	"gp1_pll"),
+	CLK_MSR_ID(22,	"eth_mppll_50m_ckout"),
+	CLK_MSR_ID(23,	"sys_pll_div16"),
+	CLK_MSR_ID(24,	"ddr_dpll_pt_clk"),
+	CLK_MSR_ID(26,	"nna_core"),
+	CLK_MSR_ID(27,	"rtc_sec_pulse_out"),
+	CLK_MSR_ID(28,	"rtc_osc_clk_out"),
+	CLK_MSR_ID(29,	"debug_in_clk"),
+	CLK_MSR_ID(30,	"mod_eth_phy_ref_clk"),
+	CLK_MSR_ID(31,	"mod_eth_tx_clk"),
+	CLK_MSR_ID(32,	"eth_125m"),
+	CLK_MSR_ID(33,	"eth_rmii"),
+	CLK_MSR_ID(34,	"co_clkin_to_mac"),
+	CLK_MSR_ID(36,	"co_rx_clk"),
+	CLK_MSR_ID(37,	"co_tx_clk"),
+	CLK_MSR_ID(38,	"eth_phy_rxclk"),
+	CLK_MSR_ID(39,	"eth_phy_plltxclk"),
+	CLK_MSR_ID(40,	"ephy_test_clk"),
+	CLK_MSR_ID(66,	"vapb"),
+	CLK_MSR_ID(67,	"ge2d"),
+	CLK_MSR_ID(68,	"dewarpa"),
+	CLK_MSR_ID(70,	"mipi_dsi_meas"),
+	CLK_MSR_ID(71,	"dsi_phy"),
+	CLK_MSR_ID(79,	"rama"),
+	CLK_MSR_ID(94,	"vc9000e_core"),
+	CLK_MSR_ID(95,	"vc9000e_sys"),
+	CLK_MSR_ID(96,	"vc9000e_aclk"),
+	CLK_MSR_ID(97,	"hcodec"),
+	CLK_MSR_ID(106,	"deskew_pll_clk_div32_out"),
+	CLK_MSR_ID(107,	"mipi_csi_phy_clk_out[0]"),
+	CLK_MSR_ID(108,	"mipi_csi_phy_clk_out[1]"),
+	CLK_MSR_ID(110,	"spifc"),
+	CLK_MSR_ID(111,	"saradc"),
+	CLK_MSR_ID(112,	"ts"),
+	CLK_MSR_ID(113,	"sd_emmc_c"),
+	CLK_MSR_ID(114,	"sd_emmc_b"),
+	CLK_MSR_ID(115,	"sd_emmc_a"),
+	CLK_MSR_ID(116,	"gpio_msr_clk"),
+	CLK_MSR_ID(117,	"spicc_b"),
+	CLK_MSR_ID(118,	"spicc_a"),
+	CLK_MSR_ID(122,	"mod_audio_pdm_dclk_o"),
+	CLK_MSR_ID(124,	"o_earcrx_dmac_clk"),
+	CLK_MSR_ID(125,	"o_earcrx_cmdc_clk"),
+	CLK_MSR_ID(126,	"o_earctx_dmac_clk"),
+	CLK_MSR_ID(127,	"o_earctx_cmdc_clk"),
+	CLK_MSR_ID(128,	"o_tohdmitx_bclk"),
+	CLK_MSR_ID(129,	"o_tohdmitx_mclk"),
+	CLK_MSR_ID(130,	"o_tohdmitx_spdif_clk"),
+	CLK_MSR_ID(131,	"o_toacodec_bclk"),
+	CLK_MSR_ID(132,	"o_toacodec_mclk"),
+	CLK_MSR_ID(133,	"o_spdifout_b_mst_clk"),
+	CLK_MSR_ID(134,	"o_spdifout_mst_clk"),
+	CLK_MSR_ID(135,	"o_spdifin_mst_clk"),
+	CLK_MSR_ID(136,	"o_audio_mclk"),
+	CLK_MSR_ID(137,	"o_vad_clk"),
+	CLK_MSR_ID(138,	"o_tdmout_d_sclk"),
+	CLK_MSR_ID(139,	"o_tdmout_c_sclk"),
+	CLK_MSR_ID(140,	"o_tdmout_b_sclk"),
+	CLK_MSR_ID(141,	"o_tdmout_a_sclk"),
+	CLK_MSR_ID(142,	"o_tdminb_1b_sclk"),
+	CLK_MSR_ID(143,	"o_tdmin_1b_sclk"),
+	CLK_MSR_ID(144,	"o_tdmin_d_sclk"),
+	CLK_MSR_ID(145,	"o_tdmin_c_sclk"),
+	CLK_MSR_ID(146,	"o_tdmin_b_sclk"),
+	CLK_MSR_ID(147,	"o_tdmin_a_sclk"),
+	CLK_MSR_ID(148,	"o_resampleb_clk"),
+	CLK_MSR_ID(149,	"o_resamplea_clk"),
+	CLK_MSR_ID(150,	"o_pdmb_sysclk"),
+	CLK_MSR_ID(151,	"o_pdmb_dclk"),
+	CLK_MSR_ID(152,	"o_pdm_sysclk"),
+	CLK_MSR_ID(153,	"o_pdm_dclk"),
+	CLK_MSR_ID(154,	"c_alockerb_out_clk"),
+	CLK_MSR_ID(155,	"c_alockerb_in_clk"),
+	CLK_MSR_ID(156,	"c_alocker_out_clk"),
+	CLK_MSR_ID(157,	"c_alocker_in_clk"),
+	CLK_MSR_ID(158,	"audio_mst_clk[34]"),
+	CLK_MSR_ID(159,	"audio_mst_clk[35]"),
+	CLK_MSR_ID(160,	"pwm_n"),
+	CLK_MSR_ID(161,	"pwm_m"),
+	CLK_MSR_ID(162,	"pwm_l"),
+	CLK_MSR_ID(163,	"pwm_k"),
+	CLK_MSR_ID(164,	"pwm_j"),
+	CLK_MSR_ID(165,	"pwm_i"),
+	CLK_MSR_ID(166,	"pwm_h"),
+	CLK_MSR_ID(167,	"pwm_g"),
+	CLK_MSR_ID(168,	"pwm_f"),
+	CLK_MSR_ID(169,	"pwm_e"),
+	CLK_MSR_ID(170,	"pwm_d"),
+	CLK_MSR_ID(171,	"pwm_c"),
+	CLK_MSR_ID(172,	"pwm_b"),
+	CLK_MSR_ID(173,	"pwm_a"),
+	CLK_MSR_ID(174,	"AU_DAC1_CLK_TO_GPIO"),
+	CLK_MSR_ID(175,	"AU_ADC_CLK_TO_GPIO"),
+	CLK_MSR_ID(176,	"rng_ring_osc_clk[0]"),
+	CLK_MSR_ID(177,	"rng_ring_osc_clk[1]"),
+	CLK_MSR_ID(178,	"rng_ring_osc_clk[2]"),
+	CLK_MSR_ID(179,	"rng_ring_osc_clk[3]"),
+	CLK_MSR_ID(180,	"sys_cpu_ring_osc_clk[0]"),
+	CLK_MSR_ID(181,	"sys_cpu_ring_osc_clk[1]"),
+	CLK_MSR_ID(182,	"sys_cpu_ring_osc_clk[2]"),
+	CLK_MSR_ID(183,	"sys_cpu_ring_osc_clk[3]"),
+	CLK_MSR_ID(184,	"sys_cpu_ring_osc_clk[4]"),
+	CLK_MSR_ID(185,	"sys_cpu_ring_osc_clk[5]"),
+	CLK_MSR_ID(186,	"sys_cpu_ring_osc_clk[6]"),
+	CLK_MSR_ID(187,	"sys_cpu_ring_osc_clk[7]"),
+	CLK_MSR_ID(188,	"sys_cpu_ring_osc_clk[8]"),
+	CLK_MSR_ID(189,	"sys_cpu_ring_osc_clk[9]"),
+	CLK_MSR_ID(190,	"sys_cpu_ring_osc_clk[10]"),
+	CLK_MSR_ID(191,	"sys_cpu_ring_osc_clk[11]"),
+	CLK_MSR_ID(192,	"am_ring_osc_clk_out[12](dmc)"),
+	CLK_MSR_ID(193,	"am_ring_osc_clk_out[13](rama)"),
+	CLK_MSR_ID(194,	"am_ring_osc_clk_out[14](nna)"),
+	CLK_MSR_ID(195,	"am_ring_osc_clk_out[15](nna)"),
+	CLK_MSR_ID(200,	"rng_ring_osc_clk_1[0]"),
+	CLK_MSR_ID(201,	"rng_ring_osc_clk_1[1]"),
+	CLK_MSR_ID(202,	"rng_ring_osc_clk_1[2]"),
+	CLK_MSR_ID(203,	"rng_ring_osc_clk_1[3]"),
+
+};
+
 static int meson_measure_id(struct meson_msr_id *clk_msr_id,
 			    unsigned int duration)
 {
@@ -713,6 +853,19 @@ static const struct meson_msr_data clk_msr_sm1_data = {
 	.reg = &msr_reg_offset,
 };
 
+struct msr_reg_offset msr_reg_offset_v2 = {
+	.freq_ctrl = 0x0,
+	.duty_ctrl = 0x4,
+	.freq_val = 0x8,
+	.duty_val = 0x18,
+};
+
+static const struct meson_msr_data clk_msr_c3_data = {
+	.msr_table = (void *)clk_msr_c3,
+	.msr_count = ARRAY_SIZE(clk_msr_c3),
+	.reg = &msr_reg_offset_v2,
+};
+
 static const struct of_device_id meson_msr_match_table[] = {
 	{
 		.compatible = "amlogic,meson-gx-clk-measure",
@@ -738,6 +891,10 @@ static const struct of_device_id meson_msr_match_table[] = {
 		.compatible = "amlogic,meson-sm1-clk-measure",
 		.data = &clk_msr_sm1_data,
 	},
+	{
+		.compatible = "amlogic,c3-clk-measure",
+		.data = &clk_msr_c3_data,
+	},
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, meson_msr_match_table);

-- 
2.42.0



