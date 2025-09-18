Return-Path: <linux-kernel+bounces-770479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52562B27B4C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 10:40:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36528AA67F3
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 08:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D57A02D6622;
	Fri, 15 Aug 2025 08:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wgc1fmb1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 081DA2459F8;
	Fri, 15 Aug 2025 08:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755247062; cv=none; b=DFU03qkJ/5JS1n/e6EPLr0YNlYfkKjh8J3lWK8Su4kY64hEEN6OmH5VnnaDA6HXGlhCKJjD6FFJEyMHIWp5qLmz7/8fbu52IAk9GisxnyLmpSUqU3pGLrH53uhQPS45jB4DJa8fO152yclDJnVGXGApKAtLi8K0RVrS/GNVI4xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755247062; c=relaxed/simple;
	bh=4rHg6PbdWwvxur/Olkz+xdYjJwYQBoyJ/1e2IHkd5pE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=otu1KjPNryZs8ywB6LG6a977OygiE4fEYUG+n/L8JRebKQi9OfmKu0BlaKLYaMQG3mUUWDKx36EbNrHOJJgZl/FbNOXt5P9cYeq6aaTJ32tAFvA+Y+FOszMm6gIQPEgGR/2RZPy1KrV4j2F6837zDqKZiqgMDaixjKANaHBBk5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wgc1fmb1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CABBDC4CEF6;
	Fri, 15 Aug 2025 08:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755247061;
	bh=4rHg6PbdWwvxur/Olkz+xdYjJwYQBoyJ/1e2IHkd5pE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Wgc1fmb19fj3lQCMGOnIlqh3QPjPJZgQ/Z6wwON00Gqg9XuOaWpWSlliLXna9Lva1
	 g3ePc+uHRYHptqlixdU5BGggUfoxCcKij+4ZuaezTa07gWZueQOzQXRv1Le6O9AY8B
	 Z2U6Mhjm/9kln9P4uNX+c2lnpUll8k+jbzlsx317xzzUHbqni4oiuxTQbLPG4d44O6
	 PYQImwzrQgLmX/UYRnV8FPrWxo7n9yz3PsfLufxo8MoVn1Php965sb7s2MOZyOdx4k
	 H80uN58/dMwn0TuVBPsfgMUPYMxYjl9HrJKrakbW5M5OS9tRiuA2G+Tf2NkLFoRGmX
	 IEY/bhbRmXfdg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2171CA0EE8;
	Fri, 15 Aug 2025 08:37:41 +0000 (UTC)
From: Chuan Liu via B4 Relay <devnull+chuan.liu.amlogic.com@kernel.org>
Date: Fri, 15 Aug 2025 16:37:39 +0800
Subject: [PATCH 13/13] arm64: dts: amlogic: S6: Add clk-measure controller
 node
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250815-add-more-socs-to-support-clk_measure-v1-13-59f04ba67457@amlogic.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755247057; l=7872;
 i=chuan.liu@amlogic.com; s=20240902; h=from:subject:message-id;
 bh=JGpYLHPu4HOmr+mDeiIXrC30j92VsgQpCg8JGdcHu0A=;
 b=sylv3HjOSOUxRyDdjkKPtqnqECv24/9zfray8sW2hRkH8c0a6IDZlEJc8fXAJVqS7Ler1D147
 0DzlafTi20JCRcJxAJIEXrj2sQN9uc9o53uCfGf6MD/8chNiiW+Kzc3
X-Developer-Key: i=chuan.liu@amlogic.com; a=ed25519;
 pk=fnKDB+81SoWGKW2GJNFkKy/ULvsDmJZRGBE7pR5Xcpo=
X-Endpoint-Received: by B4 Relay for chuan.liu@amlogic.com/20240902 with
 auth_id=203
X-Original-From: Chuan Liu <chuan.liu@amlogic.com>
Reply-To: chuan.liu@amlogic.com

From: Chuan Liu <chuan.liu@amlogic.com>

Add the clk-measure controller node for S6 SoC family.

Signed-off-by: Chuan Liu <chuan.liu@amlogic.com>
---
 arch/arm64/boot/dts/amlogic/amlogic-s6.dtsi | 312 ++++++++++++++++++++++++++++
 1 file changed, 312 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/amlogic-s6.dtsi b/arch/arm64/boot/dts/amlogic/amlogic-s6.dtsi
index 5f602f1170c0..b8dbdad91d79 100644
--- a/arch/arm64/boot/dts/amlogic/amlogic-s6.dtsi
+++ b/arch/arm64/boot/dts/amlogic/amlogic-s6.dtsi
@@ -189,6 +189,318 @@ gpiocc: gpio@300 {
 					gpio-ranges = <&periphs_pinctrl 0 (AMLOGIC_GPIO_CC<<8) 2>;
 				};
 			};
+
+			clk_msr: clock-measure@48000 {
+				compatible = "amlogic,clk-measure";
+				reg = <0x0 0x48000 0x0 0x1c>;
+				clkmsr-reg-v2;
+				clkmsr-indices = <0>,
+						 <1>,
+						 <2>,
+						 <3>,
+						 <4>,
+						 <5>,
+						 <6>,
+						 <7>,
+						 <8>,
+						 <9>,
+						 <10>,
+						 <11>,
+						 <12>,
+						 <13>,
+						 <15>,
+						 <18>,
+						 <19>,
+						 <20>,
+						 <21>,
+						 <22>,
+						 <23>,
+						 <24>,
+						 <25>,
+						 <26>,
+						 <27>,
+						 <28>,
+						 <29>,
+						 <30>,
+						 <32>,
+						 <33>,
+						 <34>,
+						 <36>,
+						 <37>,
+						 <38>,
+						 <39>,
+						 <40>,
+						 <49>,
+						 <50>,
+						 <51>,
+						 <52>,
+						 <53>,
+						 <54>,
+						 <55>,
+						 <57>,
+						 <58>,
+						 <59>,
+						 <60>,
+						 <61>,
+						 <62>,
+						 <63>,
+						 <64>,
+						 <65>,
+						 <66>,
+						 <67>,
+						 <70>,
+						 <71>,
+						 <72>,
+						 <73>,
+						 <74>,
+						 <75>,
+						 <76>,
+						 <77>,
+						 <78>,
+						 <79>,
+						 <80>,
+						 <81>,
+						 <82>,
+						 <84>,
+						 <85>,
+						 <86>,
+						 <87>,
+						 <88>,
+						 <89>,
+						 <93>,
+						 <99>,
+						 <106>,
+						 <108>,
+						 <109>,
+						 <110>,
+						 <111>,
+						 <113>,
+						 <114>,
+						 <115>,
+						 <116>,
+						 <117>,
+						 <118>,
+						 <121>,
+						 <130>,
+						 <132>,
+						 <133>,
+						 <134>,
+						 <135>,
+						 <136>,
+						 <137>,
+						 <138>,
+						 <139>,
+						 <140>,
+						 <141>,
+						 <142>,
+						 <143>,
+						 <144>,
+						 <145>,
+						 <147>,
+						 <148>,
+						 <149>,
+						 <150>,
+						 <151>,
+						 <152>,
+						 <153>,
+						 <154>,
+						 <160>,
+						 <161>,
+						 <162>,
+						 <163>,
+						 <164>,
+						 <165>,
+						 <166>,
+						 <167>,
+						 <168>,
+						 <169>,
+						 <175>,
+						 <176>,
+						 <177>,
+						 <178>,
+						 <179>,
+						 <180>,
+						 <181>,
+						 <182>,
+						 <183>,
+						 <184>,
+						 <185>,
+						 <186>,
+						 <187>,
+						 <188>,
+						 <189>,
+						 <190>,
+						 <191>,
+						 <192>,
+						 <193>,
+						 <194>,
+						 <195>,
+						 <196>,
+						 <197>,
+						 <198>,
+						 <199>,
+						 <201>,
+						 <204>,
+						 <205>,
+						 <206>,
+						 <207>,
+						 <208>,
+						 <209>,
+						 <210>;
+				clkmsr-names = "sys_clk",
+					       "axi_clk",
+					       "rtc_clk",
+					       "dspa",
+					       "mali_stack",
+					       "mali",
+					       "cpu_clk_div16",
+					       "mali_aclkm",
+					       "cecb_clk",
+					       "gp2_pll",
+					       "fclk_div5",
+					       "p21_usb2_ckout",
+					       "p20_usb2_ckout",
+					       "eth_mpll_test",
+					       "fclk_50m",
+					       "gp1_pll",
+					       "hifi_pll",
+					       "gp0_pll",
+					       "hifi1_pll",
+					       "eth_fclk_50m_ckout",
+					       "sys_pll_div16",
+					       "ddr_dpll_pt_clk",
+					       "mod_Tsin_A_CLK_IN",
+					       "ext_Tsin_B_CLK_IN",
+					       "mod_Tsin_C_CLK_IN",
+					       "mod_Tsin_D_CLK_IN",
+					       "dsi_pll_div_clk_out",
+					       "dsi_pll_clk",
+					       "eth_125m",
+					       "eth_rmii",
+					       "co_clkin_to_mac",
+					       "co_rx_clk",
+					       "co_tx_clk",
+					       "eth_phy_rxclk",
+					       "eth_phy_plltxclk",
+					       "ephy_test_clk",
+					       "hdmi_vx1_pix_clk",
+					       "vid_pll_div_clk_out",
+					       "enci",
+					       "encp",
+					       "encl",
+					       "vdac",
+					       "cdac",
+					       "lcd_an_ph2",
+					       "lcd_an_ph3",
+					       "hdmitx_pixel",
+					       "vdin_meas",
+					       "vpu",
+					       "vpu_clkb",
+					       "vpu_clkb_tmp",
+					       "vpu_clkc",
+					       "vid_lock",
+					       "vapb",
+					       "ge2d",
+					       "dsi_meas",
+					       "dsi_phy",
+					       "csi_phy",
+					       "cts_csi2_adapt_clk",
+					       "cts_csi2_data ",
+					       "csi_phy_out",
+					       "hdmitx_tmds",
+					       "hdmitx_sys",
+					       "hdmitx_fe",
+					       "rama_clk",
+					       "hdmitx_prif",
+					       "hdmitx_200m",
+					       "hdmitx_aud",
+					       "audio_tohdmitx_mclk",
+					       "audio_tohdmitx_bclk",
+					       "audio_tohdmitx_lrclk",
+					       "audio_tohdmitx_spdif_clk",
+					       "htx_aes_clk",
+					       "amfc",
+					       "vdec",
+					       "hevcf",
+					       "deskew_pll_clk_div32_out",
+					       "cmpr",
+					       "dewarpa",
+					       "sc",
+					       "aux_adc_clk",
+					       "sd_emmc_c",
+					       "sd_emmc_b",
+					       "sd_emmc_a",
+					       "gpio_msr_clk",
+					       "aux_clk_o",
+					       "spicc",
+					       "ts",
+					       "o_vad_clk",
+					       "audio_locker_in_clk",
+					       "audio_locker_out_clk",
+					       "audio_tdmout_c_sclk",
+					       "audio_tdmout_b_sclk",
+					       "audio_tdmout_a_sclk",
+					       "audio_tdmin_lb_sclk",
+					       "audio_tdmin_c_sclk",
+					       "audio_tdmin_b_sclk",
+					       "audio_tdmin_a_sclk",
+					       "audio_resamplea_clk",
+					       "audio_pdm_sysclk",
+					       "audio_spdifout_b_mst_clk",
+					       "audio_spdifout_mst_clk",
+					       "audio_spdifin_mst_clk",
+					       "audio_resampleb_clk",
+					       "pcie_pipe_clk",
+					       "pcie_ref_clk",
+					       "pcie_upcrx_cdrclk",
+					       "pcie_upcrx_clk_sync_b20",
+					       "pcie_u3p2pll1_clk_div16",
+					       "pcie_u3p2pll0_clkout",
+					       "pcie_ref_clk_p",
+					       "pwm_j",
+					       "pwm_i",
+					       "pwm_h",
+					       "pwm_g",
+					       "pwm_f",
+					       "pwm_e",
+					       "pwm_d",
+					       "pwm_c",
+					       "pwm_b",
+					       "pwm_a",
+					       "rng_ring_clk[0]",
+					       "rng_ring_clk[1]",
+					       "rng_ring_clk[2]",
+					       "rng_ring_clk[3]",
+					       "rng_ring_clk[4]",
+					       "am_ring_osc_clk_out[0]",
+					       "am_ring_osc_clk_out[1]",
+					       "am_ring_osc_clk_out[2]",
+					       "am_ring_osc_clk_out[3]",
+					       "am_ring_osc_clk_out[4]",
+					       "am_ring_osc_clk_out[5]",
+					       "am_ring_osc_clk_out[6]",
+					       "am_ring_osc_clk_out[7]",
+					       "am_ring_osc_clk_out[8]",
+					       "am_ring_osc_clk_out[9]",
+					       "am_ring_osc_clk_out[10]",
+					       "am_ring_osc_clk_out[11]",
+					       "am_ring_osc_clk_out[12]",
+					       "am_ring_osc_clk_out[13]",
+					       "am_ring_osc_clk_out[14]",
+					       "am_ring_osc_clk_out[15]",
+					       "am_ring_osc_clk_out[16]",
+					       "nna_core",
+					       "vc9000e_aclk",
+					       "vc9000e_core",
+					       "pcie_tl",
+					       "u3p2pll1_clk_div16",
+					       "u3p2pll0_clkout",
+					       "upctx_clk_sync_b20",
+					       "upcrx_carclk",
+					       "usb_pipe_clk",
+					       "earcrx_pll_out",
+					       "mclk_pll";
+			};
 		};
 	};
 };

-- 
2.42.0



