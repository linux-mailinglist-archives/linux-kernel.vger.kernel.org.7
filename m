Return-Path: <linux-kernel+bounces-768011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E545B25BD5
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 08:33:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA18F624FA3
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 06:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D345225392B;
	Thu, 14 Aug 2025 06:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J8phELsS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0450F1F5827;
	Thu, 14 Aug 2025 06:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755153181; cv=none; b=jHqFKnxlMwjFNgc1y1Zp3wEUoiQsMCKaI0xS/j9xfZOai9lQrawdVA2dPpICsXa/5hvvnlje7Eq6Z1mGoEt9w0g2U4WYRAxPbNI/zFgMWj3g1q85md1OjuUOTo3jMeMtXbuP0rIBgSZC6lxO9N/hZUC1Ztmd1RmE1FIqmkSPjN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755153181; c=relaxed/simple;
	bh=VSgImVuCqCH2tx9gJklqhA/Q7iOTvOvF3jkJS6V32lM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cKsPBFkipmvDiNgV/IK5Bc4Tstzow1JjjZl+jmX5Z3YB/poW7E77VqS18QpCEdznSErhNiH0BiIQqlyiMtmO+SPtCalbXgAqTdWyATjRV6DlMMgBzujGikqIgTCNAmaBiVxFm1SdOclSnsWNuojTNkvuk4yGvv0mpsZb9qeJrL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J8phELsS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9DA97C4CEF4;
	Thu, 14 Aug 2025 06:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755153180;
	bh=VSgImVuCqCH2tx9gJklqhA/Q7iOTvOvF3jkJS6V32lM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=J8phELsSSCuexZ9uWF/rqirT7VfAFWsXFXLGCnkORHNLHl85ZbrcMyEIw96f9UTw3
	 jAU7Gn4q6b4tV6LL7tedVn4jsqomSLQDjSF7GMk2abgr/VXvjlsfcFbxtPWR7Vvx6r
	 58zlM17F5MvfJb861LXauuXjNQvw8VvDFIQIg9FmkYO+BRHXmNPJXI4Eaw8H0EPcc4
	 aIq1xznzP+bfW5oQXHkFDytYR4Mdy5NuAH7zRctIPY3tnC/aahvSGePQF+ogP7nKjX
	 DcbC6ureMAS3n0mRwU8zwDE4jeoTcoH1g2IQWLDtVmy2G2TZ8LRNnpuFr8NDIc8i5o
	 6Zk1W7cNaZ2iw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C49FCA0EE4;
	Thu, 14 Aug 2025 06:33:00 +0000 (UTC)
From: Chuan Liu via B4 Relay <devnull+chuan.liu.amlogic.com@kernel.org>
Date: Thu, 14 Aug 2025 14:32:45 +0800
Subject: [PATCH v2 2/2] clk: amlogic: add video-related clocks for S4 SoC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250814-add_video_clk-v2-2-bb2b5a5f2904@amlogic.com>
References: <20250814-add_video_clk-v2-0-bb2b5a5f2904@amlogic.com>
In-Reply-To: <20250814-add_video_clk-v2-0-bb2b5a5f2904@amlogic.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755153176; l=7096;
 i=chuan.liu@amlogic.com; s=20240902; h=from:subject:message-id;
 bh=sYvEeZ4oYnSosnGYzWTsQjmj6ZIK9npvOzvOGvDxsvM=;
 b=GskWItH4d/0b/sbn+Tk54ut4IfML7X3nSuWQxzqDIEhiXU8vGrZO/++k0PCCsuuaQy+dFr09u
 9YPTK4QYziMCJCENfTq1TbI3y1RJBxsxmeq4qJJv6Tv47oDgRNrdrtu
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
 drivers/clk/meson/s4-peripherals.c | 203 +++++++++++++++++++++++++++++++++++++
 1 file changed, 203 insertions(+)

diff --git a/drivers/clk/meson/s4-peripherals.c b/drivers/clk/meson/s4-peripherals.c
index c9400cf54c84..77c550376fc8 100644
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
@@ -3174,6 +3207,165 @@ static struct clk_regmap s4_gen_clk = {
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
 
@@ -3453,6 +3645,17 @@ static struct clk_hw *s4_periphs_hw_clks[] = {
 	[CLKID_HDCP22_SKPCLK_SEL]	= &s4_hdcp22_skpclk_mux.hw,
 	[CLKID_HDCP22_SKPCLK_DIV]	= &s4_hdcp22_skpclk_div.hw,
 	[CLKID_HDCP22_SKPCLK]		= &s4_hdcp22_skpclk_gate.hw,
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
 
 static const struct regmap_config clkc_regmap_config = {

-- 
2.42.0



