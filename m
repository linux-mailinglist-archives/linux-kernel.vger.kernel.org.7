Return-Path: <linux-kernel+bounces-731858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EC31B05AA2
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 14:52:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 855087A4300
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 12:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B34982E0415;
	Tue, 15 Jul 2025 12:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pe5MYIjP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E672264A9;
	Tue, 15 Jul 2025 12:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752583903; cv=none; b=ZcAY7/yYOpOXRb2MfuY8qYStsaDAdF30ZB03njK7v863r1HZYXIeWFx2fKDWyZWfn+6MgRgNUc6SzrzmRo7DoaZds5xpkODta5u7vpdybGOC3LCXKLxRu+K83pT0XAYg1/+9XeGkJRjbSNVDJxJQLOqlDmyCnkkE9WeA+Dv/HyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752583903; c=relaxed/simple;
	bh=85dpZxDXnCCzOPyZ7BS5N9GgXCmsv2H8dUvkNv/cJN0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tUpcKnwVPGZhVde93ZV3svXLlzMoKix1bOx1DYrbgQvZoCqnJWsZypmWebST96aA5kI7+/lnQmwddXk/lsJGhgvbD/wUXQRFEd59NZPz4nYOIHzyCdrV5Xh5Ng3SoOd0EjoHYc970XpR6pvAHXjxqYzy3oYMwoBNXTrmiybzZBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pe5MYIjP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 760A5C4CEF1;
	Tue, 15 Jul 2025 12:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752583903;
	bh=85dpZxDXnCCzOPyZ7BS5N9GgXCmsv2H8dUvkNv/cJN0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=pe5MYIjPKmTHjoFFQpWcLcj+S+aKet22gikbF2F7h+s0vRasKsX5F321Wth68tjnY
	 TlNWeJ90IW11QdLL2vJ/4js5WXJ8qxAhzTsiVUV0pNTEisT6DJm/L9p+4SLYJmcpyS
	 4+FtOXk6yz+uh3L1s0SIl3rf891P5ZXdIg7ZCtKIGHbQybPVx4MQYmOr0e6V+fQ/VJ
	 QxydYep9eHnr8PDSNtCX34nDfL1Zo5tLlH4Bb8HXbIf4p5CEB1W/y+JxqNIoCE7UhN
	 2xruvgMElJeIzOP1SjJbGIMnfZq8ixuesGXkqm/Og8KqrBvTJZeIM19t8yKEp2iV2N
	 LuPMy4LZBG0og==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 666B9C83F27;
	Tue, 15 Jul 2025 12:51:43 +0000 (UTC)
From: Chuan Liu via B4 Relay <devnull+chuan.liu.amlogic.com@kernel.org>
Date: Tue, 15 Jul 2025 20:51:39 +0800
Subject: [PATCH 2/2] clk: amlogic: add video-related clocks for S4 SoC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250715-add_video_clk-v1-2-40e7f633f361@amlogic.com>
References: <20250715-add_video_clk-v1-0-40e7f633f361@amlogic.com>
In-Reply-To: <20250715-add_video_clk-v1-0-40e7f633f361@amlogic.com>
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jerome Brunet <jbrunet@baylibre.com>, Kevin Hilman <khilman@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, Chuan Liu <chuan.liu@amlogic.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752583900; l=8635;
 i=chuan.liu@amlogic.com; s=20240902; h=from:subject:message-id;
 bh=Krtad04/LG3f+yownUO/6hPuVzIprI6Y8mPsJSZ7oMw=;
 b=jMVksC6mymjR/byiSiIbxFAfx7pwBYMaXcaQETql3fxq9FmaUM3nN9ryk8syF2Odt2oCBZWxJ
 RjEY4HOiEX0BWIlX5Euy1Nr9fgwZqRu9fMde0pvZjR6DRkHeT2LdkmL
X-Developer-Key: i=chuan.liu@amlogic.com; a=ed25519;
 pk=fnKDB+81SoWGKW2GJNFkKy/ULvsDmJZRGBE7pR5Xcpo=
X-Endpoint-Received: by B4 Relay for chuan.liu@amlogic.com/20240902 with
 auth_id=203
X-Original-From: Chuan Liu <chuan.liu@amlogic.com>
Reply-To: chuan.liu@amlogic.com

From: Chuan Liu <chuan.liu@amlogic.com>

Add video encoder, demodulator and CVBS clocks.

Signed-off-by: Chuan Liu <chuan.liu@amlogic.com>
---
 drivers/clk/meson/s4-peripherals.c | 256 +++++++++++++++++++++++++++++++++++++
 1 file changed, 256 insertions(+)

diff --git a/drivers/clk/meson/s4-peripherals.c b/drivers/clk/meson/s4-peripherals.c
index c9400cf54c84..f43526d506b1 100644
--- a/drivers/clk/meson/s4-peripherals.c
+++ b/drivers/clk/meson/s4-peripherals.c
@@ -44,6 +44,7 @@
 #define CLKCTRL_VDIN_MEAS_CLK_CTRL                 0x0f8
 #define CLKCTRL_VAPBCLK_CTRL                       0x0fc
 #define CLKCTRL_HDCP22_CTRL                        0x100
+#define CLKCTRL_CDAC_CLK_CTRL                      0x108
 #define CLKCTRL_VDEC_CLK_CTRL                      0x140
 #define CLKCTRL_VDEC2_CLK_CTRL                     0x144
 #define CLKCTRL_VDEC3_CLK_CTRL                     0x148
@@ -1117,6 +1118,22 @@ static struct clk_regmap s4_cts_encp_sel = {
 	},
 };
 
+static struct clk_regmap s4_cts_encl_sel = {
+	.data = &(struct clk_regmap_mux_data){
+		.offset = CLKCTRL_VIID_CLK_DIV,
+		.mask = 0xf,
+		.shift = 12,
+		.table = mux_table_cts_sel,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "cts_encl_sel",
+		.ops = &clk_regmap_mux_ops,
+		.parent_hws = s4_cts_parent_hws,
+		.num_parents = ARRAY_SIZE(s4_cts_parent_hws),
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
 static struct clk_regmap s4_cts_vdac_sel = {
 	.data = &(struct clk_regmap_mux_data){
 		.offset = CLKCTRL_VIID_CLK_DIV,
@@ -1196,6 +1213,22 @@ static struct clk_regmap s4_cts_encp = {
 	},
 };
 
+static struct clk_regmap s4_cts_encl = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = CLKCTRL_VID_CLK_CTRL2,
+		.bit_idx = 3,
+	},
+	.hw.init = &(struct clk_init_data) {
+		.name = "cts_encl",
+		.ops = &clk_regmap_gate_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&s4_cts_encl_sel.hw
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
 static struct clk_regmap s4_cts_vdac = {
 	.data = &(struct clk_regmap_gate_data){
 		.offset = CLKCTRL_VID_CLK_CTRL2,
@@ -1228,6 +1261,56 @@ static struct clk_regmap s4_hdmi_tx = {
 	},
 };
 
+static struct clk_regmap s4_lcd_an_sel = {
+	.data = &(struct clk_regmap_mux_data){
+		.offset = CLKCTRL_VIID_CLK_DIV,
+		.mask = 0x1,
+		.shift = 11,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "lcd_an_sel",
+		.ops = &clk_regmap_mux_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&s4_vclk_div6.hw,
+			&s4_vclk_div12.hw,
+		},
+		.num_parents = 2,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap s4_lcd_an_ph2 = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = CLKCTRL_VID_CLK_CTRL2,
+		.bit_idx = 7,
+	},
+	.hw.init = &(struct clk_init_data) {
+		.name = "lcd_an_ph2",
+		.ops = &clk_regmap_gate_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&s4_lcd_an_sel.hw
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap s4_lcd_an_ph3 = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = CLKCTRL_VID_CLK_CTRL2,
+		.bit_idx = 7,
+	},
+	.hw.init = &(struct clk_init_data) {
+		.name = "lcd_an_ph3",
+		.ops = &clk_regmap_gate_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&s4_lcd_an_sel.hw
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
 /* HDMI Clocks */
 static const struct clk_parent_data s4_hdmi_parent_data[] = {
 	{ .fw_name = "xtal", },
@@ -3174,6 +3257,165 @@ static struct clk_regmap s4_gen_clk = {
 	},
 };
 
+/* CVBS DAC */
+static struct clk_regmap s4_cdac_sel = {
+	.data = &(struct clk_regmap_mux_data) {
+		.offset = CLKCTRL_CDAC_CLK_CTRL,
+		.mask = 0x3,
+		.shift = 16,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "cdac_sel",
+		.ops = &clk_regmap_mux_ops,
+		.parent_data = (const struct clk_parent_data []) {
+			{ .fw_name = "xtal", },
+			{ .fw_name = "fclk_div5" },
+		},
+		.num_parents = 2,
+	},
+};
+
+static struct clk_regmap s4_cdac_div = {
+	.data = &(struct clk_regmap_div_data) {
+		.offset = CLKCTRL_CDAC_CLK_CTRL,
+		.shift = 0,
+		.width = 16,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "cdac_div",
+		.ops = &clk_regmap_divider_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&s4_cdac_sel.hw
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap s4_cdac = {
+	.data = &(struct clk_regmap_gate_data) {
+		.offset = CLKCTRL_CDAC_CLK_CTRL,
+		.bit_idx = 20,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "cdac",
+		.ops = &clk_regmap_gate_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&s4_cdac_div.hw
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap s4_demod_core_sel = {
+	.data = &(struct clk_regmap_mux_data) {
+		.offset = CLKCTRL_DEMOD_CLK_CTRL,
+		.mask = 0x3,
+		.shift = 9,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "demod_core_sel",
+		.ops = &clk_regmap_mux_ops,
+		.parent_data = (const struct clk_parent_data []) {
+			{ .fw_name = "xtal" },
+			{ .fw_name = "fclk_div7" },
+			{ .fw_name = "fclk_div4" }
+		},
+		.num_parents = 3,
+	},
+};
+
+static struct clk_regmap s4_demod_core_div = {
+	.data = &(struct clk_regmap_div_data) {
+		.offset = CLKCTRL_DEMOD_CLK_CTRL,
+		.shift = 0,
+		.width = 7,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "demod_core_div",
+		.ops = &clk_regmap_divider_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&s4_demod_core_sel.hw
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap s4_demod_core = {
+	.data = &(struct clk_regmap_gate_data) {
+		.offset = CLKCTRL_DEMOD_CLK_CTRL,
+		.bit_idx = 8
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "demod_core",
+		.ops = &clk_regmap_gate_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&s4_demod_core_div.hw
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+/* CVBS ADC */
+static struct clk_regmap s4_adc_extclk_in_sel = {
+	.data = &(struct clk_regmap_mux_data) {
+		.offset = CLKCTRL_DEMOD_CLK_CTRL,
+		.mask = 0x7,
+		.shift = 25,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "adc_extclk_in_sel",
+		.ops = &clk_regmap_mux_ops,
+		.parent_data = (const struct clk_parent_data []) {
+			{ .fw_name = "xtal" },
+			{ .fw_name = "fclk_div4" },
+			{ .fw_name = "fclk_div3" },
+			{ .fw_name = "fclk_div5" },
+			{ .fw_name = "fclk_div7" },
+			{ .fw_name = "mpll2" },
+			{ .fw_name = "gp0_pll" },
+			{ .fw_name = "hifi_pll" }
+		},
+		.num_parents = 8,
+	},
+};
+
+static struct clk_regmap s4_adc_extclk_in_div = {
+	.data = &(struct clk_regmap_div_data) {
+		.offset = CLKCTRL_DEMOD_CLK_CTRL,
+		.shift = 16,
+		.width = 7,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "adc_extclk_in_div",
+		.ops = &clk_regmap_divider_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&s4_adc_extclk_in_sel.hw
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap s4_adc_extclk_in = {
+	.data = &(struct clk_regmap_gate_data) {
+		.offset = CLKCTRL_DEMOD_CLK_CTRL,
+		.bit_idx = 24
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "adc_extclk_in",
+		.ops = &clk_regmap_gate_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&s4_adc_extclk_in_div.hw
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
 #define MESON_GATE(_name, _reg, _bit) \
 	MESON_PCLK(_name, _reg, _bit, &s4_sys_clk.hw)
 
@@ -3453,6 +3695,20 @@ static struct clk_hw *s4_periphs_hw_clks[] = {
 	[CLKID_HDCP22_SKPCLK_SEL]	= &s4_hdcp22_skpclk_mux.hw,
 	[CLKID_HDCP22_SKPCLK_DIV]	= &s4_hdcp22_skpclk_div.hw,
 	[CLKID_HDCP22_SKPCLK]		= &s4_hdcp22_skpclk_gate.hw,
+	[CLKID_CTS_ENCL_SEL]		= &s4_cts_encl_sel.hw,
+	[CLKID_CTS_ENCL]		= &s4_cts_encl.hw,
+	[CLKID_LCD_AN_SEL]		= &s4_lcd_an_sel.hw,
+	[CLKID_LCD_AN_PH2]		= &s4_lcd_an_ph2.hw,
+	[CLKID_LCD_AN_PH3]		= &s4_lcd_an_ph3.hw,
+	[CLKID_CDAC_SEL]		= &s4_cdac_sel.hw,
+	[CLKID_CDAC_DIV]		= &s4_cdac_div.hw,
+	[CLKID_CDAC]			= &s4_cdac.hw,
+	[CLKID_DEMOD_CORE_SEL]		= &s4_demod_core_sel.hw,
+	[CLKID_DEMOD_CORE_DIV]		= &s4_demod_core_div.hw,
+	[CLKID_DEMOD_CORE]		= &s4_demod_core.hw,
+	[CLKID_ADC_EXTCLK_IN_SEL]	= &s4_adc_extclk_in_sel.hw,
+	[CLKID_ADC_EXTCLK_IN_DIV]	= &s4_adc_extclk_in_div.hw,
+	[CLKID_ADC_EXTCLK_IN]		= &s4_adc_extclk_in.hw,
 };
 
 static const struct regmap_config clkc_regmap_config = {

-- 
2.42.0



