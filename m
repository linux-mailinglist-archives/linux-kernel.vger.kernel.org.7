Return-Path: <linux-kernel+bounces-770480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35ECDB27B4B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 10:40:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62AB45E71DB
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 08:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0B532D6408;
	Fri, 15 Aug 2025 08:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nCaoseks"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 537702528FD;
	Fri, 15 Aug 2025 08:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755247062; cv=none; b=n0jzGJX7rQ2RdEPxEHNZN/vS5fepbvMl1yuyShSF8hw4GM9K4r8foQ/LgnyRFd0w/WuQlzkouuyydQUCRWBNI1Qbnw7QdFzcJ1/rDeFOosRE4MiCrtagIMOG4C7UzzELHBCdZcODN5WqTZOKZXVMN46W3m2vmDQgJZdJHpU7snE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755247062; c=relaxed/simple;
	bh=zHm9FDgn4q6/xxPLyj5fLKXqr5ss/Uk6/ql8RR2vJxs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HDXX0h79thJgEmMqy2Bwa8XcDwuJsLn3VIz2uYTvjYZRYLuxo31F7ZEtXOCm6ucI9Qxh8nuCcxOxHOjxY6t+0AJFPtugKWIRywRHWZOlDprzGZ/h5fNteQSdyc3yQ7kWE1dnIDPgkzeT5BsSzIPXHNwDkCEsr4pe0//2RChkmBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nCaoseks; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BDD5FC4CEEB;
	Fri, 15 Aug 2025 08:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755247061;
	bh=zHm9FDgn4q6/xxPLyj5fLKXqr5ss/Uk6/ql8RR2vJxs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=nCaoseksLGQ42FqntIfyukpMp95F70Ks6gg2tVLDjMTkEVkQZH8XB6WC0F7vu4xQY
	 yf7VtUDeHLLTsRXI0o64ERlcAf9401Az7G9MT+sjuJr0IuF96r9DoD21yafnQ2URSy
	 EoVy6I22o6dkyAUjnQ7/PspAf8JWcF/RZyd0+/dTtJ47egh7SvL7Eu+1p+RtUyDM+U
	 e7zFfbhQsZXK4YuzVM7IT3buzBb6Kcr3uPlJJ3e2SD6S9EZrrJtTdnq04HUp66Giyg
	 Ju6Tv39tv8rd22WDhCVoA6Kzx7zQ+xwi6XsndPb/FbVzNA3aPI2NiDA2iKUFm1X+3M
	 r0yvwYP8RSXeg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B62ACCA0EE6;
	Fri, 15 Aug 2025 08:37:41 +0000 (UTC)
From: Chuan Liu via B4 Relay <devnull+chuan.liu.amlogic.com@kernel.org>
Date: Fri, 15 Aug 2025 16:37:38 +0800
Subject: [PATCH 12/13] arm64: dts: amlogic: S7D: Add clk-measure controller
 node
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250815-add-more-socs-to-support-clk_measure-v1-12-59f04ba67457@amlogic.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755247057; l=6399;
 i=chuan.liu@amlogic.com; s=20240902; h=from:subject:message-id;
 bh=Vv1XnmhYWT2bsyKCicoFjDp0lmFh6QrlHLuGDXvx8XI=;
 b=JVTdbUXHo0i01T7e5acBX+rmguv7bUz3qeR6KpGdWPBzXBe3X/bijI6wn2BQ9RWIn0aNIWQ2k
 QM94obZUizJAf1UnQX/YGPACOeLuWpyCOAz0W/BHKhxynCqIWbPWxol
X-Developer-Key: i=chuan.liu@amlogic.com; a=ed25519;
 pk=fnKDB+81SoWGKW2GJNFkKy/ULvsDmJZRGBE7pR5Xcpo=
X-Endpoint-Received: by B4 Relay for chuan.liu@amlogic.com/20240902 with
 auth_id=203
X-Original-From: Chuan Liu <chuan.liu@amlogic.com>
Reply-To: chuan.liu@amlogic.com

From: Chuan Liu <chuan.liu@amlogic.com>

Add the clk-measure controller node for S7D SoC family.

Signed-off-by: Chuan Liu <chuan.liu@amlogic.com>
---
 arch/arm64/boot/dts/amlogic/amlogic-s7d.dtsi | 243 +++++++++++++++++++++++++++
 1 file changed, 243 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/amlogic-s7d.dtsi b/arch/arm64/boot/dts/amlogic/amlogic-s7d.dtsi
index c4d260d5bb58..a958cde53fa1 100644
--- a/arch/arm64/boot/dts/amlogic/amlogic-s7d.dtsi
+++ b/arch/arm64/boot/dts/amlogic/amlogic-s7d.dtsi
@@ -184,6 +184,249 @@ gpiocc: gpio@300 {
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
+						 <4>,
+						 <5>,
+						 <6>,
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
+						 <31>,
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
+						 <89>,
+						 <93>,
+						 <97>,
+						 <99>,
+						 <106>,
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
+					       "mali_stack",
+					       "mali",
+					       "cpu_clk_div16",
+					       "cecb_clk",
+					       "mali_aclkm",
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
+					       "mod_Tsin_B_CLK_IN",
+					       "earcrx_pll_clk_out",
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
+					       "amfc",
+					       "vdec",
+					       "hcodec",
+					       "hevcf",
+					       "deskew_pll_clk_div32_out",
+					       "sc",
+					       "saradc",
+					       "sd_emmc_c",
+					       "sd_emmc_b",
+					       "sd_emmc_a",
+					       "gpio_msr_clk",
+					       "aux_clk_o",
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
+					       "osc_ring_clk[2](a55 core1 14_slvt)",
+					       "osc_ring_clk[3](a55 core1 14_slvt)",
+					       "osc_ring_clk[4](a55_pwr[0] 16_slvt)",
+					       "osc_ring_clk[5](a55_pwr[1] 14_lvt)",
+					       "osc_ring_clk[6](a55_pwr[2] 14_rvt)",
+					       "osc_ring_clk[7](mali[1] 14_lvt)",
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



