Return-Path: <linux-kernel+bounces-770475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C4F6B27B46
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 10:38:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C929D7A07F5
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 08:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD2A72D12E6;
	Fri, 15 Aug 2025 08:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LipGcAHL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E80C2242D6A;
	Fri, 15 Aug 2025 08:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755247062; cv=none; b=C9FhapBN8Opoh9P8RuwkhkoqYmcevrDVuL3qv9xSAzAYLJHW3BL85sdtSrdKQXpngQRGSZ4k2AGzb/Kqjeq0dLRgabQtEcu1dCf7uecKr6+eTiGCR9j/EKc0PR62CvQybGDGRYHe1d6Cr7LTePTcPH0cOMovzRqfORR1LCGxyPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755247062; c=relaxed/simple;
	bh=ZE9QZXldOA2fAz/Jp9Rj+ACinn8pv88gC+RHGtrNOgc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=T/wdbA9E6ssu3QUBmpS79NYia4g1nnuOUUVY4511pfgHJp1snmAP3WO63AaT2PZvWkjAF0GGQ5STXHi8mACVCNEzY+CCIyWq8Iqju5L8ETKG70F8UDuSoEs6PLtTYlB/lcZioAVDNfYo+QFmDpxZOLqkZXbjd8pSVRQ+WujqiWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LipGcAHL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A4698C19425;
	Fri, 15 Aug 2025 08:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755247061;
	bh=ZE9QZXldOA2fAz/Jp9Rj+ACinn8pv88gC+RHGtrNOgc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=LipGcAHL3pQsOu63SdsbGhO2+N7EYeC/+86EeZeB+5r/wZ7TOg0/4CgAlpvEz179d
	 vBPCZo3SASzYwoK7tDFYoY5zdU+7dJtEOyDZ1ETvlgAQbpu14ica2cJcfDp2kgDQFB
	 jBxOzRY4PoV/zEb5oeCJGSSP4cNzIQ2O4sQJvHPqAXKfVvAqzjqKsP71IJsEBBYVWZ
	 /2STKpZvH5d0KB6xJPLkktJhxNTJE09R99Rm5F1+yciB1qzEcFkLKFWPz4M0V74KFx
	 H7R0ubFpMu7uhpkyhwjPgeRop8NgAQhwFihR/nuRFar3FYWhvOXAtx7Nb6v4hUaTT8
	 C22WH8yxA8mDQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D05ACA0EE4;
	Fri, 15 Aug 2025 08:37:41 +0000 (UTC)
From: Chuan Liu via B4 Relay <devnull+chuan.liu.amlogic.com@kernel.org>
Date: Fri, 15 Aug 2025 16:37:36 +0800
Subject: [PATCH 10/13] arm64: dts: amlogic: A5: Add clk-measure controller
 node
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250815-add-more-socs-to-support-clk_measure-v1-10-59f04ba67457@amlogic.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755247057; l=4959;
 i=chuan.liu@amlogic.com; s=20240902; h=from:subject:message-id;
 bh=+rNhxW5k+895xe8+dWTUbJTXjfJCo6DlrCn7/3Oc7eA=;
 b=3tf/QeTEs7Rnm4u+NO5CEpipA5qttEyM8fZzYxsaHoHpoc3j5zJngsaeFQ1MMnMExrV39Nl42
 14hJ8lqPF7EAXLtsjOXo9FZcfejmRqiZ9OFyOVq720u1UY8dTS0yGxW
X-Developer-Key: i=chuan.liu@amlogic.com; a=ed25519;
 pk=fnKDB+81SoWGKW2GJNFkKy/ULvsDmJZRGBE7pR5Xcpo=
X-Endpoint-Received: by B4 Relay for chuan.liu@amlogic.com/20240902 with
 auth_id=203
X-Original-From: Chuan Liu <chuan.liu@amlogic.com>
Reply-To: chuan.liu@amlogic.com

From: Chuan Liu <chuan.liu@amlogic.com>

Add the clk-measure controller node for A5 SoC family.

Signed-off-by: Chuan Liu <chuan.liu@amlogic.com>
---
 arch/arm64/boot/dts/amlogic/amlogic-a5.dtsi | 202 ++++++++++++++++++++++++++++
 1 file changed, 202 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/amlogic-a5.dtsi b/arch/arm64/boot/dts/amlogic/amlogic-a5.dtsi
index b1da8cbaa25a..4db3ff4a0522 100644
--- a/arch/arm64/boot/dts/amlogic/amlogic-a5.dtsi
+++ b/arch/arm64/boot/dts/amlogic/amlogic-a5.dtsi
@@ -67,4 +67,206 @@ gpio_intc: interrupt-controller@4080 {
 		amlogic,channel-interrupts =
 			<10 11 12 13 14 15 16 17 18 19 20 21>;
 	};
+
+	clk_msr: clock-measure@48000 {
+		compatible = "amlogic,clk-measure";
+		reg = <0x0 0x48000 0x0 0x1c>;
+		clkmsr-reg-v2;
+		clkmsr-indices = <0>,
+				 <1>,
+				 <2>,
+				 <3>,
+				 <6>,
+				 <10>,
+				 <11>,
+				 <12>,
+				 <13>,
+				 <14>,
+				 <15>,
+				 <16>,
+				 <17>,
+				 <18>,
+				 <19>,
+				 <20>,
+				 <21>,
+				 <23>,
+				 <24>,
+				 <25>,
+				 <26>,
+				 <27>,
+				 <28>,
+				 <30>,
+				 <31>,
+				 <35>,
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
+				 <186>,
+				 <187>,
+				 <188>,
+				 <189>;
+		clkmsr-names = "sys_clk",
+			       "axi_clk",
+			       "rtc_clk",
+			       "dspa",
+			       "cpu_clk_div16",
+			       "fclk_div5",
+			       "mpll0",
+			       "mpll1",
+			       "mpll2",
+			       "mpll3",
+			       "fclk_50m",
+			       "sys_oscin32k_i",
+			       "rtc_pll",
+			       "mpll_clk_test_out",
+			       "hifi_pll",
+			       "gp0_pll",
+			       "gp1_pll",
+			       "sys_pll_div16",
+			       "ddr_dpll_pt_clk",
+			       "nna_axi",
+			       "nna_core",
+			       "rtc_sec_pulse_out",
+			       "rtc_osc_clk_out",
+			       "mod_eth_phy_ref_clk",
+			       "mod_eth_tx_clk",
+			       "mod_eth_rx_clk_rmii",
+			       "rama_clk",
+			       "deskew_pll_clk_div32_out",
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
+			       "earctx_dmdc_clk",
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
+			       "dmc_osc_ring(LVT16)",
+			       "dsp_osc_ring(SVT16)",
+			       "axi_srama_osc_ring(SVT16)",
+			       "nna_osc_ring[0](ULVT20)",
+			       "nna_osc_ring[1](LVT16)",
+			       "sys_cpu_osc_ring[0](ULVT16)",
+			       "sys_cpu_osc_ring[1](ULVT20)",
+			       "sys_cpu_osc_ring[2](ULVT16)",
+			       "sys_cpu_osc_ring[3](LVT16)",
+			       "axi_sramb_osc_ring(SVT16)";
+	};
 };

-- 
2.42.0



