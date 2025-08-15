Return-Path: <linux-kernel+bounces-770476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63A3FB27B49
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 10:39:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C97B1CC325C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 08:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 667012D23B9;
	Fri, 15 Aug 2025 08:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dRUY8i29"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F33EC244669;
	Fri, 15 Aug 2025 08:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755247062; cv=none; b=q/FnMD1OF8974cx8+eI8k7fdJLVuag5AiXKtc/VuqRXERD7VOUKpvFsZ5mt3C7z4Wh5w6BN5xliiHZdFhCPrgd5RVio1Fdf05tWjBUHHttpz2DA1PBBtLGJXks3L4IIU+Go1Ia1plLxqT/sMBzwNPYXROYa6oZ1oVtIyxUkk6N8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755247062; c=relaxed/simple;
	bh=w8PuFRxUJIBQ12aPBQSflZiYsOlXd4t/Q+krqWmUilk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RzOFl+kDH1pRYEJVTZrsrDQ/zkak4Ivb7A6dO9xMd1N64QqoSVhkvEbjtqfD0vQowIxwndEIGBDjfSxje3oce4DiP67AnCuHxUZ4TTYrxFVXrstZXdK/Iyr6+/vCuV8O+tgxwkNX8CKdhVtcf6n9KkOZZcSpDEy1K1HL5dkxEC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dRUY8i29; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B86A1C4CEFF;
	Fri, 15 Aug 2025 08:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755247061;
	bh=w8PuFRxUJIBQ12aPBQSflZiYsOlXd4t/Q+krqWmUilk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=dRUY8i29gNTXApnwckckf+KVaTC7DU0W4GIErzmztOCaNWpMYTjDnYuofJzyP5XvM
	 wxCxRcsbCjPEJanHGlnuZK5TD8LOoADszZghp6P8nOqdOisjQczwSWdenGqK7Jv389
	 uB5cx3uHRygcoxSki7O4Ad5hg21HBrGXLAwkn2ib8lzv4gK0JPPXXh/UMK1p7HLE9A
	 rXAv/k9EtD/jw8WW3ZO7eDryAlEoQjCLyTeJIs8odJie46KYlh5ubMND2p9GWs2hAq
	 722cqAz0JU/GOczofhZi2SCzsMnnfqjU6fEtfM0EyHoLravbppeWr3p56qmueD+RP3
	 8IY7yqJNuwGeA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A99C8CA0EE9;
	Fri, 15 Aug 2025 08:37:41 +0000 (UTC)
From: Chuan Liu via B4 Relay <devnull+chuan.liu.amlogic.com@kernel.org>
Date: Fri, 15 Aug 2025 16:37:37 +0800
Subject: [PATCH 11/13] arm64: dts: amlogic: S7: Add clk-measure controller
 node
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250815-add-more-socs-to-support-clk_measure-v1-11-59f04ba67457@amlogic.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755247057; l=6696;
 i=chuan.liu@amlogic.com; s=20240902; h=from:subject:message-id;
 bh=PoSXtN4p9w7+3ZDjnmmafQk3tbymutEzrxBWWPNf4KQ=;
 b=BFSveRD3UTKVYfTKrMSrEV9ZMwR8xJv08Vqf3Za4QljmCsTJEo63bA1428WunmBhvVHzAYkBq
 r63tG7I+Zo5C5WaXthTNqXqXvDcTQja4pF5t4oZF8mHeoe6QrFIRPoV
X-Developer-Key: i=chuan.liu@amlogic.com; a=ed25519;
 pk=fnKDB+81SoWGKW2GJNFkKy/ULvsDmJZRGBE7pR5Xcpo=
X-Endpoint-Received: by B4 Relay for chuan.liu@amlogic.com/20240902 with
 auth_id=203
X-Original-From: Chuan Liu <chuan.liu@amlogic.com>
Reply-To: chuan.liu@amlogic.com

From: Chuan Liu <chuan.liu@amlogic.com>

Add the clk-measure controller node for S7 SoC family.

Signed-off-by: Chuan Liu <chuan.liu@amlogic.com>
---
 arch/arm64/boot/dts/amlogic/amlogic-s7.dtsi | 253 ++++++++++++++++++++++++++++
 1 file changed, 253 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/amlogic-s7.dtsi b/arch/arm64/boot/dts/amlogic/amlogic-s7.dtsi
index 260918b37b9a..f6b2dae3db39 100644
--- a/arch/arm64/boot/dts/amlogic/amlogic-s7.dtsi
+++ b/arch/arm64/boot/dts/amlogic/amlogic-s7.dtsi
@@ -175,6 +175,259 @@ gpiocc: gpio@300 {
 					gpio-ranges = <&periphs_pinctrl 0 (AMLOGIC_GPIO_CC<<8) 2>;
 				};
 			};
+			clk_msr: clock-measure@48000 {
+				compatible = "amlogic,clk-measure";
+				reg = <0x0 0x48000 0x0 0x1c>;
+				clkmsr-reg-v2;
+				clkmsr-indices = <0>,
+						 <1>,
+						 <2>,
+						 <5>,
+						 <6>,
+						 <8>,
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
+						 <76>,
+						 <77>,
+						 <78>,
+						 <80>,
+						 <81>,
+						 <82>,
+						 <84>,
+						 <85>,
+						 <86>,
+						 <87>,
+						 <88>,
+						 <93>,
+						 <99>,
+						 <106>,
+						 <110>,
+						 <111>,
+						 <113>,
+						 <114>,
+						 <115>,
+						 <116>,
+						 <118>,
+						 <121>,
+						 <130>,
+						 <131>,
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
+						 <146>,
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
+						 <192>;
+				clkmsr-names = "sys_clk",
+					       "axi_clk",
+					       "rtc_clk",
+					       "mali",
+					       "cpu_clk_div16",
+					       "cecb_clk",
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
+					       "hdmitx_tmds",
+					       "hdmitx_sys",
+					       "hdmitx_fe",
+					       "hdmitx_prif",
+					       "hdmitx_200m",
+					       "hdmitx_aud",
+					       "audio_tohdmitx_mclk",
+					       "audio_tohdmitx_bclk",
+					       "audio_tohdmitx_lrclk",
+					       "audio_tohdmitx_spdif_clk",
+					       "htx_aes_clk",
+					       "vdec",
+					       "hevcf",
+					       "deskew_pll_clk_div32_out",
+					       "sc",
+					       "saradc",
+					       "sd_emmc_c",
+					       "sd_emmc_b",
+					       "sd_emmc_a",
+					       "gpio_msr_clk",
+					       "spicc",
+					       "ts",
+					       "o_vad_clk",
+					       "au_dac_clk_x128",
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
+					       "mod_audio_pdm_dclk_o",
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
+					       "osc_ring_clk[0](a55 core0 14_slvt)",
+					       "osc_ring_clk[1](a55 core1 14_slvt)",
+					       "osc_ring_clk[2](a55 core2 14_slvt)",
+					       "osc_ring_clk[3](a55 core3 14_slvt)",
+					       "osc_ring_clk[4](a55_pwr[0] 16_slvt)",
+					       "osc_ring_clk[5](a55_pwr[1] 14_lvt)",
+					       "osc_ring_clk[6](a55_pwr[2] 14_rvt)",
+					       "osc_ring_clk[7](mali[0] 14_lvt)",
+					       "osc_ring_clk[8](mali[1] 14_rvt)",
+					       "osc_ring_clk[9](dos[0] 16_lvt)",
+					       "osc_ring_clk[10](dos[1] 14_rvt)",
+					       "osc_ring_clk[11](ddr[0] 9t_14_lvt)",
+					       "osc_ring_clk[12](top[0] 16_rvt)";
+			};
 		};
 	};
 };

-- 
2.42.0



