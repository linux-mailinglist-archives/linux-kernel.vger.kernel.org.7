Return-Path: <linux-kernel+bounces-818021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 019A0B58BB4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 04:06:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFD312A4507
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 02:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 723EC1A2389;
	Tue, 16 Sep 2025 02:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="abY2U5cd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C8171F7575;
	Tue, 16 Sep 2025 02:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757988389; cv=none; b=KXmd9V2q8v7IZ5KDXmUhyJJioGOhFWUhs8ZF/c3Y8erl2gXhxaDjsSW8odlyWw+QRfbEO181Xh/+4eEmSd2NL/Vm3fnbuR+RBD1UmVU6KIdeD0PbB1CfFzicORDVWAIVJMkKawuY9qa60tqz5M02y+fV4lFMlSwy0Toivv8Przs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757988389; c=relaxed/simple;
	bh=mxa2ge1Pa588T0qc00m0cplT9m07ics72F3zATKyQGg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=szzvWRcBoj7S2RQEWL7D6Dt5MxAWH55lr1cUqbLJWRImO89mL36SlSAdNb6gGFl70JuiIJN0bzU6kwNowj5xUYJvXx8kkTp+vzJ/q+A7dLKMBsowoYcIpk2mwPiqdlFfBU3z2lP/H+NQDkYPXvr6YkNi8fxajMrm3CYWEJhslyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=abY2U5cd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0164DC4CEF5;
	Tue, 16 Sep 2025 02:06:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757988389;
	bh=mxa2ge1Pa588T0qc00m0cplT9m07ics72F3zATKyQGg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=abY2U5cdcn/WbQvN8td23yfz4eHMR+7D+/T8oRB3l3WTZOkhBx7u0oDaR0MNFBE8J
	 01B/OHTk8f8AcT8rca8sI5sDQcGs9lB/+y1q2ql9N7DOCdaICA24dQG7C5TDjedZlR
	 xzvIBfsfAvQVtxv3YI/idAARcInV3z6wnY5a+G2SXhK6ElbFEw1U7JcAwMNwx287Pa
	 oVPGtNSaZ6F6Q0SstCnQ1Q2PcTqKAxZnIV1vw3LbSyqWQRXNNZXUrSaciJyJ9ywbhi
	 OAzqHhGdKzTDS7nfpCgDbELCOSw0GyHMsNMWulULlZpn4uQAlYrsJ58JDGKs4y5wqs
	 eQp/i050x7KPQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E553DCAC597;
	Tue, 16 Sep 2025 02:06:28 +0000 (UTC)
From: Chuan Liu via B4 Relay <devnull+chuan.liu.amlogic.com@kernel.org>
Date: Tue, 16 Sep 2025 10:06:07 +0800
Subject: [PATCH v5 2/2] clk: amlogic: add video-related clocks for S4 SoC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250916-add_video_clk-v5-2-e25293589601@amlogic.com>
References: <20250916-add_video_clk-v5-0-e25293589601@amlogic.com>
In-Reply-To: <20250916-add_video_clk-v5-0-e25293589601@amlogic.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757988387; l=7840;
 i=chuan.liu@amlogic.com; s=20240902; h=from:subject:message-id;
 bh=XH2c+vl3VULVSg3x8U7T7qdAJtfPHe8TywXeWVH9qHE=;
 b=d2sAq3y6Do6R/tqSFTZHXjTvjMLeVqY1z6Ig1/NSVZX8Kilrp9q+if88PyS1RSfktbuU6SzO7
 gINQ1pOhAO/DsJwFBr9bNfIbUU2kQcu2uMcjG0Pn8dCOjYm/73hKyjQ
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
 drivers/clk/meson/s4-peripherals.c | 206 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 202 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/meson/s4-peripherals.c b/drivers/clk/meson/s4-peripherals.c
index 6d69b132d1e1..ba41fcd90588 100644
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
@@ -1106,7 +1107,6 @@ static struct clk_regmap s4_cts_enci_sel = {
 		.ops = &clk_regmap_mux_ops,
 		.parent_hws = s4_cts_parents,
 		.num_parents = ARRAY_SIZE(s4_cts_parents),
-		.flags = CLK_SET_RATE_PARENT,
 	},
 };
 
@@ -1122,7 +1122,21 @@ static struct clk_regmap s4_cts_encp_sel = {
 		.ops = &clk_regmap_mux_ops,
 		.parent_hws = s4_cts_parents,
 		.num_parents = ARRAY_SIZE(s4_cts_parents),
-		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap s4_cts_encl_sel = {
+	.data = &(struct clk_regmap_mux_data){
+		.offset = CLKCTRL_VIID_CLK_DIV,
+		.mask = 0xf,
+		.shift = 12,
+		.table = s4_cts_parents_val_table,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "cts_encl_sel",
+		.ops = &clk_regmap_mux_ops,
+		.parent_hws = s4_cts_parents,
+		.num_parents = ARRAY_SIZE(s4_cts_parents),
 	},
 };
 
@@ -1138,7 +1152,6 @@ static struct clk_regmap s4_cts_vdac_sel = {
 		.ops = &clk_regmap_mux_ops,
 		.parent_hws = s4_cts_parents,
 		.num_parents = ARRAY_SIZE(s4_cts_parents),
-		.flags = CLK_SET_RATE_PARENT,
 	},
 };
 
@@ -1169,7 +1182,6 @@ static struct clk_regmap s4_hdmi_tx_sel = {
 		.ops = &clk_regmap_mux_ops,
 		.parent_hws = s4_hdmi_tx_parents,
 		.num_parents = ARRAY_SIZE(s4_hdmi_tx_parents),
-		.flags = CLK_SET_RATE_PARENT,
 	},
 };
 
@@ -1205,6 +1217,22 @@ static struct clk_regmap s4_cts_encp = {
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
@@ -2735,6 +2763,165 @@ static struct clk_regmap s4_gen_clk = {
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
 static const struct clk_parent_data s4_pclk_parents = { .hw = &s4_sys_clk.hw };
 
 #define S4_PCLK(_name, _reg, _bit, _flags) \
@@ -3028,6 +3215,17 @@ static struct clk_hw *s4_peripherals_hw_clks[] = {
 	[CLKID_HDCP22_SKPCLK_SEL]	= &s4_hdcp22_skpclk_sel.hw,
 	[CLKID_HDCP22_SKPCLK_DIV]	= &s4_hdcp22_skpclk_div.hw,
 	[CLKID_HDCP22_SKPCLK]		= &s4_hdcp22_skpclk.hw,
+	[CLKID_CTS_ENCL_SEL]		= &s4_cts_encl_sel.hw,
+	[CLKID_CTS_ENCL]		= &s4_cts_encl.hw,
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
 
 static const struct meson_clkc_data s4_peripherals_clkc_data = {

-- 
2.42.0



