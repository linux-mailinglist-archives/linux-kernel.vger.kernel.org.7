Return-Path: <linux-kernel+bounces-841634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CD28BB7DC8
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 20:15:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C4E354EEC37
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 18:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22DE92DCF58;
	Fri,  3 Oct 2025 18:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MFes8YcP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E01BD2DF125;
	Fri,  3 Oct 2025 18:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759515294; cv=none; b=mBI2jjFW393SlDlzGhVwCrkgEl1FrVEyDNuplDxbxubyCk9wVrN/jdSD3GOmNXEy32elouF7SIfKlN+IRhBLdu5OjGfemPoxATBqcRQaOqxmg91sC+CU4aygnw+VeQuQ1f9WZyQWTERDZTvSdx7yhvoZeE+UDKQ9uZJ+AByJ/lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759515294; c=relaxed/simple;
	bh=ZJl6Z4zTKGytpGVOdgWZO2i1ABAm4VCif1UcJ273pjc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OKqWd37+UAJkfSG4ynH0CkU9d4+snHgvEjSo/nstC70bYyt4A2+fFaZ7IclSFbKDvjWt/x36JNrTFdpB8Kuay9ZW+0tt0k1XhG5EXWPUftKU/NasWNlbugzuaJ5DpXlJiMc2kh6YnL4RwlGhjrLzrst0Re81d26+atapk5h1F/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MFes8YcP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A40C4C4CEF5;
	Fri,  3 Oct 2025 18:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759515293;
	bh=ZJl6Z4zTKGytpGVOdgWZO2i1ABAm4VCif1UcJ273pjc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=MFes8YcPFtDdJt26TK5qoXoKx5+iqgodw3RAICAYsxk6R6rNEQQ6yAW4qEsVdyCJk
	 FIE2pOGL+RqgYM11dwTkw/XXwKim4jL8H7IX/zwsjXzcgocZeKR7s3qpIcb4Eo6lnA
	 U4JSIXZRffmWrHWV6Awt3k1a1PBiEEKhmJuUlVC0x1x+JoJ3UdzOoYtRLrxo/8GJUH
	 Ban2gbsRRI4gZZOSccmcoG9/u6Bm2woHjoDLKSPMALrxvp4eRs9isO/KQKLoM9nQqW
	 JOThSm7EXa7vzXaaZ2YhCX8NWtVRnSDP5RpBaQhBn3mzOf3HiJdCsKs+ZHdDPLElr3
	 t/hibNSE6iqDw==
From: Konrad Dybcio <konradybcio@kernel.org>
Date: Fri, 03 Oct 2025 20:14:39 +0200
Subject: [PATCH v2 2/3] clk: qcom: gcc-x1e80100: Add missing USB4
 clocks/resets
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251003-topic-hamoa_gcc_usb4-v2-2-61d27a14ee65@oss.qualcomm.com>
References: <20251003-topic-hamoa_gcc_usb4-v2-0-61d27a14ee65@oss.qualcomm.com>
In-Reply-To: <20251003-topic-hamoa_gcc_usb4-v2-0-61d27a14ee65@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Rajendra Nayak <quic_rjendra@quicinc.com>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Wesley Cheng <wesley.cheng@oss.qualcomm.com>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
 Sibi Sankar <quic_sibis@quicinc.com>, Abel Vesa <abel.vesa@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
 Bryan O'Donoghue <bod@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759515280; l=37967;
 i=konrad.dybcio@oss.qualcomm.com; s=20230215; h=from:subject:message-id;
 bh=liXYC9eaZiKUosI/bNGxJuxsYBvYyPoyiVaSfLsHBbI=;
 b=SHRKm5xAQIqoczGb36+KUlgpNa7wEOI1M/FQBrxX3ayHC5i+q6A+8pjp66qLFBnZnZmnrARo/
 t/MOheIbua7AYPe94uDats678THN5BJYhIFkLyzA/boNx9lqXF7Wl63
X-Developer-Key: i=konrad.dybcio@oss.qualcomm.com; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Currently, some of the USB4 clocks/resets are described, but not all
of the back-end muxes are present. Configuring them properly is
necessary for proper operation of the hardware.

Add all the resets & muxes and wire up any unaccounted USB4 clock paths.

Fixes: 161b7c401f4b ("clk: qcom: Add Global Clock controller (GCC) driver for X1E80100")
Reviewed-by: Bryan O'Donoghue <bod@kernel.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
---
 drivers/clk/qcom/gcc-x1e80100.c | 698 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 681 insertions(+), 17 deletions(-)

diff --git a/drivers/clk/qcom/gcc-x1e80100.c b/drivers/clk/qcom/gcc-x1e80100.c
index 301fc9fc32d8e6e1ddf59c1d3350d84f6c06e4b6..8804ad5d70be0b7bf911f89877b1d847fc4d95ae 100644
--- a/drivers/clk/qcom/gcc-x1e80100.c
+++ b/drivers/clk/qcom/gcc-x1e80100.c
@@ -32,6 +32,33 @@ enum {
 	DT_USB3_PHY_0_WRAPPER_GCC_USB30_PIPE,
 	DT_USB3_PHY_1_WRAPPER_GCC_USB30_PIPE,
 	DT_USB3_PHY_2_WRAPPER_GCC_USB30_PIPE,
+	DT_GCC_USB4_0_PHY_DP0_GMUX_CLK_SRC,
+	DT_GCC_USB4_0_PHY_DP1_GMUX_CLK_SRC,
+	DT_GCC_USB4_0_PHY_PCIE_PIPEGMUX_CLK_SRC,
+	DT_GCC_USB4_0_PHY_PIPEGMUX_CLK_SRC,
+	DT_GCC_USB4_0_PHY_SYS_PIPEGMUX_CLK_SRC,
+	DT_GCC_USB4_1_PHY_DP0_GMUX_CLK_SRC,
+	DT_GCC_USB4_1_PHY_DP1_GMUX_CLK_SRC,
+	DT_GCC_USB4_1_PHY_PCIE_PIPEGMUX_CLK_SRC,
+	DT_GCC_USB4_1_PHY_PIPEGMUX_CLK_SRC,
+	DT_GCC_USB4_1_PHY_SYS_PIPEGMUX_CLK_SRC,
+	DT_GCC_USB4_2_PHY_DP0_GMUX_CLK_SRC,
+	DT_GCC_USB4_2_PHY_DP1_GMUX_CLK_SRC,
+	DT_GCC_USB4_2_PHY_PCIE_PIPEGMUX_CLK_SRC,
+	DT_GCC_USB4_2_PHY_PIPEGMUX_CLK_SRC,
+	DT_GCC_USB4_2_PHY_SYS_PIPEGMUX_CLK_SRC,
+	DT_QUSB4PHY_0_GCC_USB4_RX0_CLK,
+	DT_QUSB4PHY_0_GCC_USB4_RX1_CLK,
+	DT_QUSB4PHY_1_GCC_USB4_RX0_CLK,
+	DT_QUSB4PHY_1_GCC_USB4_RX1_CLK,
+	DT_QUSB4PHY_2_GCC_USB4_RX0_CLK,
+	DT_QUSB4PHY_2_GCC_USB4_RX1_CLK,
+	DT_USB4_0_PHY_GCC_USB4_PCIE_PIPE_CLK,
+	DT_USB4_0_PHY_GCC_USB4RTR_MAX_PIPE_CLK,
+	DT_USB4_1_PHY_GCC_USB4_PCIE_PIPE_CLK,
+	DT_USB4_1_PHY_GCC_USB4RTR_MAX_PIPE_CLK,
+	DT_USB4_2_PHY_GCC_USB4_PCIE_PIPE_CLK,
+	DT_USB4_2_PHY_GCC_USB4RTR_MAX_PIPE_CLK,
 };
 
 enum {
@@ -42,10 +69,40 @@ enum {
 	P_GCC_GPLL7_OUT_MAIN,
 	P_GCC_GPLL8_OUT_MAIN,
 	P_GCC_GPLL9_OUT_MAIN,
+	P_GCC_USB3_PRIM_PHY_PIPE_CLK_SRC,
+	P_GCC_USB3_SEC_PHY_PIPE_CLK_SRC,
+	P_GCC_USB3_TERT_PHY_PIPE_CLK_SRC,
+	P_GCC_USB4_0_PHY_DP0_GMUX_CLK_SRC,
+	P_GCC_USB4_0_PHY_DP1_GMUX_CLK_SRC,
+	P_GCC_USB4_0_PHY_PCIE_PIPEGMUX_CLK_SRC,
+	P_GCC_USB4_0_PHY_PIPEGMUX_CLK_SRC,
+	P_GCC_USB4_0_PHY_SYS_PIPEGMUX_CLK_SRC,
+	P_GCC_USB4_1_PHY_DP0_GMUX_CLK_SRC,
+	P_GCC_USB4_1_PHY_DP1_GMUX_CLK_SRC,
+	P_GCC_USB4_1_PHY_PCIE_PIPEGMUX_CLK_SRC,
+	P_GCC_USB4_1_PHY_PIPEGMUX_CLK_SRC,
+	P_GCC_USB4_1_PHY_SYS_PIPEGMUX_CLK_SRC,
+	P_GCC_USB4_2_PHY_DP0_GMUX_CLK_SRC,
+	P_GCC_USB4_2_PHY_DP1_GMUX_CLK_SRC,
+	P_GCC_USB4_2_PHY_PCIE_PIPEGMUX_CLK_SRC,
+	P_GCC_USB4_2_PHY_PIPEGMUX_CLK_SRC,
+	P_GCC_USB4_2_PHY_SYS_PIPEGMUX_CLK_SRC,
+	P_QUSB4PHY_0_GCC_USB4_RX0_CLK,
+	P_QUSB4PHY_0_GCC_USB4_RX1_CLK,
+	P_QUSB4PHY_1_GCC_USB4_RX0_CLK,
+	P_QUSB4PHY_1_GCC_USB4_RX1_CLK,
+	P_QUSB4PHY_2_GCC_USB4_RX0_CLK,
+	P_QUSB4PHY_2_GCC_USB4_RX1_CLK,
 	P_SLEEP_CLK,
 	P_USB3_PHY_0_WRAPPER_GCC_USB30_PIPE_CLK,
 	P_USB3_PHY_1_WRAPPER_GCC_USB30_PIPE_CLK,
 	P_USB3_PHY_2_WRAPPER_GCC_USB30_PIPE_CLK,
+	P_USB4_0_PHY_GCC_USB4_PCIE_PIPE_CLK,
+	P_USB4_0_PHY_GCC_USB4RTR_MAX_PIPE_CLK,
+	P_USB4_1_PHY_GCC_USB4_PCIE_PIPE_CLK,
+	P_USB4_1_PHY_GCC_USB4RTR_MAX_PIPE_CLK,
+	P_USB4_2_PHY_GCC_USB4_PCIE_PIPE_CLK,
+	P_USB4_2_PHY_GCC_USB4RTR_MAX_PIPE_CLK,
 };
 
 static struct clk_alpha_pll gcc_gpll0 = {
@@ -320,6 +377,342 @@ static const struct freq_tbl ftbl_gcc_gp1_clk_src[] = {
 	{ }
 };
 
+static const struct clk_parent_data gcc_parent_data_13[] = {
+	{ .index = DT_GCC_USB4_0_PHY_DP0_GMUX_CLK_SRC },
+	{ .index = DT_USB4_0_PHY_GCC_USB4RTR_MAX_PIPE_CLK },
+};
+
+static const struct clk_parent_data gcc_parent_data_14[] = {
+	{ .index = DT_GCC_USB4_0_PHY_DP1_GMUX_CLK_SRC },
+	{ .index = DT_USB4_0_PHY_GCC_USB4RTR_MAX_PIPE_CLK },
+};
+
+static const struct clk_parent_data gcc_parent_data_15[] = {
+	{ .index = DT_USB4_0_PHY_GCC_USB4_PCIE_PIPE_CLK },
+	{ .index = DT_BI_TCXO },
+};
+
+static const struct clk_parent_data gcc_parent_data_16[] = {
+	{ .index = DT_GCC_USB4_0_PHY_PCIE_PIPEGMUX_CLK_SRC },
+	{ .index = DT_USB4_0_PHY_GCC_USB4_PCIE_PIPE_CLK },
+};
+
+static const struct clk_parent_data gcc_parent_data_17[] = {
+	{ .index = DT_QUSB4PHY_0_GCC_USB4_RX0_CLK },
+	{ .index = DT_BI_TCXO },
+};
+
+static const struct clk_parent_data gcc_parent_data_18[] = {
+	{ .index = DT_QUSB4PHY_0_GCC_USB4_RX1_CLK },
+	{ .index = DT_BI_TCXO },
+};
+
+static const struct clk_parent_data gcc_parent_data_19[] = {
+	{ .index = DT_GCC_USB4_0_PHY_SYS_PIPEGMUX_CLK_SRC },
+	{ .index = DT_USB4_0_PHY_GCC_USB4_PCIE_PIPE_CLK },
+};
+
+static const struct clk_parent_data gcc_parent_data_20[] = {
+	{ .index = DT_GCC_USB4_1_PHY_DP0_GMUX_CLK_SRC },
+	{ .index = DT_USB4_1_PHY_GCC_USB4RTR_MAX_PIPE_CLK },
+};
+
+static const struct clk_parent_data gcc_parent_data_21[] = {
+	{ .index = DT_GCC_USB4_1_PHY_DP1_GMUX_CLK_SRC },
+	{ .index = DT_USB4_1_PHY_GCC_USB4RTR_MAX_PIPE_CLK },
+};
+
+static const struct clk_parent_data gcc_parent_data_22[] = {
+	{ .index = DT_USB4_1_PHY_GCC_USB4_PCIE_PIPE_CLK },
+	{ .index = DT_BI_TCXO },
+};
+
+static const struct clk_parent_data gcc_parent_data_23[] = {
+	{ .index = DT_GCC_USB4_1_PHY_PCIE_PIPEGMUX_CLK_SRC },
+	{ .index = DT_USB4_1_PHY_GCC_USB4_PCIE_PIPE_CLK },
+};
+
+static const struct clk_parent_data gcc_parent_data_24[] = {
+	{ .index = DT_QUSB4PHY_1_GCC_USB4_RX0_CLK },
+	{ .index = DT_BI_TCXO },
+};
+
+static const struct clk_parent_data gcc_parent_data_25[] = {
+	{ .index = DT_QUSB4PHY_1_GCC_USB4_RX1_CLK },
+	{ .index = DT_BI_TCXO },
+};
+
+static const struct clk_parent_data gcc_parent_data_26[] = {
+	{ .index = DT_GCC_USB4_1_PHY_SYS_PIPEGMUX_CLK_SRC },
+	{ .index = DT_USB4_1_PHY_GCC_USB4_PCIE_PIPE_CLK },
+};
+
+static const struct clk_parent_data gcc_parent_data_27[] = {
+	{ .index = DT_GCC_USB4_2_PHY_DP0_GMUX_CLK_SRC },
+	{ .index = DT_USB4_2_PHY_GCC_USB4RTR_MAX_PIPE_CLK },
+};
+
+static const struct clk_parent_data gcc_parent_data_28[] = {
+	{ .index = DT_GCC_USB4_2_PHY_DP1_GMUX_CLK_SRC },
+	{ .index = DT_USB4_2_PHY_GCC_USB4RTR_MAX_PIPE_CLK },
+};
+
+static const struct clk_parent_data gcc_parent_data_29[] = {
+	{ .index = DT_USB4_2_PHY_GCC_USB4_PCIE_PIPE_CLK },
+	{ .index = DT_BI_TCXO },
+};
+
+static const struct clk_parent_data gcc_parent_data_30[] = {
+	{ .index = DT_GCC_USB4_2_PHY_PCIE_PIPEGMUX_CLK_SRC },
+	{ .index = DT_USB4_2_PHY_GCC_USB4_PCIE_PIPE_CLK },
+};
+
+static const struct clk_parent_data gcc_parent_data_31[] = {
+	{ .index = DT_QUSB4PHY_2_GCC_USB4_RX0_CLK },
+	{ .index = DT_BI_TCXO },
+};
+
+static const struct clk_parent_data gcc_parent_data_32[] = {
+	{ .index = DT_QUSB4PHY_2_GCC_USB4_RX1_CLK },
+	{ .index = DT_BI_TCXO },
+};
+
+static const struct clk_parent_data gcc_parent_data_33[] = {
+	{ .index = DT_GCC_USB4_2_PHY_SYS_PIPEGMUX_CLK_SRC },
+	{ .index = DT_USB4_2_PHY_GCC_USB4_PCIE_PIPE_CLK },
+};
+
+static struct clk_regmap_phy_mux gcc_usb4_0_phy_dp0_clk_src = {
+	.reg = 0x9f06c,
+	.clkr = {
+		.hw.init = &(const struct clk_init_data) {
+			.name = "gcc_usb4_0_phy_dp0_clk_src",
+			.parent_data = gcc_parent_data_13,
+			.ops = &clk_regmap_phy_mux_ops,
+		},
+	},
+};
+
+static struct clk_regmap_phy_mux gcc_usb4_0_phy_dp1_clk_src = {
+	.reg = 0x9f114,
+	.clkr = {
+		.hw.init = &(const struct clk_init_data) {
+			.name = "gcc_usb4_0_phy_dp1_clk_src",
+			.parent_data = gcc_parent_data_14,
+			.ops = &clk_regmap_phy_mux_ops,
+		},
+	},
+};
+
+static struct clk_regmap_phy_mux gcc_usb4_0_phy_p2rr2p_pipe_clk_src = {
+	.reg = 0x9f0d4,
+	.clkr = {
+		.hw.init = &(const struct clk_init_data) {
+			.name = "gcc_usb4_0_phy_p2rr2p_pipe_clk_src",
+			.parent_data = gcc_parent_data_15,
+			.ops = &clk_regmap_phy_mux_ops,
+		},
+	},
+};
+
+static struct clk_regmap_phy_mux gcc_usb4_0_phy_pcie_pipe_mux_clk_src = {
+	.reg = 0x9f104,
+	.clkr = {
+		.hw.init = &(const struct clk_init_data) {
+			.name = "gcc_usb4_0_phy_pcie_pipe_mux_clk_src",
+			.parent_data = gcc_parent_data_16,
+			.ops = &clk_regmap_phy_mux_ops,
+		},
+	},
+};
+
+static struct clk_regmap_phy_mux gcc_usb4_0_phy_rx0_clk_src = {
+	.reg = 0x9f0ac,
+	.clkr = {
+		.hw.init = &(const struct clk_init_data) {
+			.name = "gcc_usb4_0_phy_rx0_clk_src",
+			.parent_data = gcc_parent_data_17,
+			.ops = &clk_regmap_phy_mux_ops,
+		},
+	},
+};
+
+static struct clk_regmap_phy_mux gcc_usb4_0_phy_rx1_clk_src = {
+	.reg = 0x9f0bc,
+	.clkr = {
+		.hw.init = &(const struct clk_init_data) {
+			.name = "gcc_usb4_0_phy_rx1_clk_src",
+			.parent_data = gcc_parent_data_18,
+			.ops = &clk_regmap_phy_mux_ops,
+		},
+	},
+};
+
+static struct clk_regmap_phy_mux gcc_usb4_0_phy_sys_clk_src = {
+	.reg = 0x9f0e4,
+	.clkr = {
+		.hw.init = &(const struct clk_init_data) {
+			.name = "gcc_usb4_0_phy_sys_clk_src",
+			.parent_data = gcc_parent_data_19,
+			.ops = &clk_regmap_phy_mux_ops,
+		},
+	},
+};
+
+static struct clk_regmap_phy_mux gcc_usb4_1_phy_dp0_clk_src = {
+	.reg = 0x2b06c,
+	.clkr = {
+		.hw.init = &(const struct clk_init_data) {
+			.name = "gcc_usb4_1_phy_dp0_clk_src",
+			.parent_data = gcc_parent_data_20,
+			.ops = &clk_regmap_phy_mux_ops,
+		},
+	},
+};
+
+static struct clk_regmap_phy_mux gcc_usb4_1_phy_dp1_clk_src = {
+	.reg = 0x2b114,
+	.clkr = {
+		.hw.init = &(const struct clk_init_data) {
+			.name = "gcc_usb4_1_phy_dp1_clk_src",
+			.parent_data = gcc_parent_data_21,
+			.ops = &clk_regmap_phy_mux_ops,
+		},
+	},
+};
+
+static struct clk_regmap_phy_mux gcc_usb4_1_phy_p2rr2p_pipe_clk_src = {
+	.reg = 0x2b0d4,
+	.clkr = {
+		.hw.init = &(const struct clk_init_data) {
+			.name = "gcc_usb4_1_phy_p2rr2p_pipe_clk_src",
+			.parent_data = gcc_parent_data_22,
+			.ops = &clk_regmap_phy_mux_ops,
+		},
+	},
+};
+
+static struct clk_regmap_phy_mux gcc_usb4_1_phy_pcie_pipe_mux_clk_src = {
+	.reg = 0x2b104,
+	.clkr = {
+		.hw.init = &(const struct clk_init_data) {
+			.name = "gcc_usb4_1_phy_pcie_pipe_mux_clk_src",
+			.parent_data = gcc_parent_data_23,
+			.ops = &clk_regmap_phy_mux_ops,
+		},
+	},
+};
+
+static struct clk_regmap_phy_mux gcc_usb4_1_phy_rx0_clk_src = {
+	.reg = 0x2b0ac,
+	.clkr = {
+		.hw.init = &(const struct clk_init_data) {
+			.name = "gcc_usb4_1_phy_rx0_clk_src",
+			.parent_data = gcc_parent_data_24,
+			.ops = &clk_regmap_phy_mux_ops,
+		},
+	},
+};
+
+static struct clk_regmap_phy_mux gcc_usb4_1_phy_rx1_clk_src = {
+	.reg = 0x2b0bc,
+	.clkr = {
+		.hw.init = &(const struct clk_init_data) {
+			.name = "gcc_usb4_1_phy_rx1_clk_src",
+			.parent_data = gcc_parent_data_25,
+			.ops = &clk_regmap_phy_mux_ops,
+		},
+	},
+};
+
+static struct clk_regmap_phy_mux gcc_usb4_1_phy_sys_clk_src = {
+	.reg = 0x2b0e4,
+	.clkr = {
+		.hw.init = &(const struct clk_init_data) {
+			.name = "gcc_usb4_1_phy_sys_clk_src",
+			.parent_data = gcc_parent_data_26,
+			.ops = &clk_regmap_phy_mux_ops,
+		},
+	},
+};
+
+static struct clk_regmap_phy_mux gcc_usb4_2_phy_dp0_clk_src = {
+	.reg = 0x1106c,
+	.clkr = {
+		.hw.init = &(const struct clk_init_data) {
+			.name = "gcc_usb4_2_phy_dp0_clk_src",
+			.parent_data = gcc_parent_data_27,
+			.ops = &clk_regmap_phy_mux_ops,
+		},
+	},
+};
+
+static struct clk_regmap_phy_mux gcc_usb4_2_phy_dp1_clk_src = {
+	.reg = 0x11114,
+	.clkr = {
+		.hw.init = &(const struct clk_init_data) {
+			.name = "gcc_usb4_2_phy_dp1_clk_src",
+			.parent_data = gcc_parent_data_28,
+			.ops = &clk_regmap_phy_mux_ops,
+		},
+	},
+};
+
+static struct clk_regmap_phy_mux gcc_usb4_2_phy_p2rr2p_pipe_clk_src = {
+	.reg = 0x110d4,
+	.clkr = {
+		.hw.init = &(const struct clk_init_data) {
+			.name = "gcc_usb4_2_phy_p2rr2p_pipe_clk_src",
+			.parent_data = gcc_parent_data_29,
+			.ops = &clk_regmap_phy_mux_ops,
+		},
+	},
+};
+
+static struct clk_regmap_phy_mux gcc_usb4_2_phy_pcie_pipe_mux_clk_src = {
+	.reg = 0x11104,
+	.clkr = {
+		.hw.init = &(const struct clk_init_data) {
+			.name = "gcc_usb4_2_phy_pcie_pipe_mux_clk_src",
+			.parent_data = gcc_parent_data_30,
+			.ops = &clk_regmap_phy_mux_ops,
+		},
+	},
+};
+
+static struct clk_regmap_phy_mux gcc_usb4_2_phy_rx0_clk_src = {
+	.reg = 0x110ac,
+	.clkr = {
+		.hw.init = &(const struct clk_init_data) {
+			.name = "gcc_usb4_2_phy_rx0_clk_src",
+			.parent_data = gcc_parent_data_31,
+			.ops = &clk_regmap_phy_mux_ops,
+		},
+	},
+};
+
+static struct clk_regmap_phy_mux gcc_usb4_2_phy_rx1_clk_src = {
+	.reg = 0x110bc,
+	.clkr = {
+		.hw.init = &(const struct clk_init_data) {
+			.name = "gcc_usb4_2_phy_rx1_clk_src",
+			.parent_data = gcc_parent_data_32,
+			.ops = &clk_regmap_phy_mux_ops,
+		},
+	},
+};
+
+static struct clk_regmap_phy_mux gcc_usb4_2_phy_sys_clk_src = {
+	.reg = 0x110e4,
+	.clkr = {
+		.hw.init = &(const struct clk_init_data) {
+			.name = "gcc_usb4_2_phy_sys_clk_src",
+			.parent_data = gcc_parent_data_33,
+			.ops = &clk_regmap_phy_mux_ops,
+		},
+	},
+};
+
 static struct clk_rcg2 gcc_gp1_clk_src = {
 	.cmd_rcgr = 0x64004,
 	.mnd_width = 16,
@@ -2790,6 +3183,11 @@ static struct clk_branch gcc_pcie_0_pipe_clk = {
 		.enable_mask = BIT(25),
 		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_pcie_0_pipe_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&gcc_usb4_0_phy_pcie_pipe_mux_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
 			.ops = &clk_branch2_ops,
 		},
 	},
@@ -2879,6 +3277,11 @@ static struct clk_branch gcc_pcie_1_pipe_clk = {
 		.enable_mask = BIT(30),
 		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_pcie_1_pipe_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&gcc_usb4_1_phy_pcie_pipe_mux_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
 			.ops = &clk_branch2_ops,
 		},
 	},
@@ -2968,6 +3371,11 @@ static struct clk_branch gcc_pcie_2_pipe_clk = {
 		.enable_mask = BIT(23),
 		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_pcie_2_pipe_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&gcc_usb4_2_phy_pcie_pipe_mux_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
 			.ops = &clk_branch2_ops,
 		},
 	},
@@ -5156,6 +5564,33 @@ static struct clk_regmap_mux gcc_usb3_prim_phy_pipe_clk_src = {
 	},
 };
 
+static const struct parent_map gcc_parent_map_34[] = {
+	{ P_GCC_USB3_PRIM_PHY_PIPE_CLK_SRC, 0 },
+	{ P_USB4_0_PHY_GCC_USB4RTR_MAX_PIPE_CLK, 1 },
+	{ P_GCC_USB4_0_PHY_PIPEGMUX_CLK_SRC, 3 },
+};
+
+static const struct clk_parent_data gcc_parent_data_34[] = {
+	{ .hw = &gcc_usb3_prim_phy_pipe_clk_src.clkr.hw },
+	{ .index = DT_USB4_0_PHY_GCC_USB4RTR_MAX_PIPE_CLK },
+	{ .index = DT_GCC_USB4_0_PHY_PIPEGMUX_CLK_SRC },
+};
+
+static struct clk_regmap_mux gcc_usb34_prim_phy_pipe_clk_src = {
+	.reg = 0x39070,
+	.shift = 0,
+	.width = 2,
+	.parent_map = gcc_parent_map_34,
+	.clkr = {
+		.hw.init = &(const struct clk_init_data) {
+			.name = "gcc_usb34_prim_phy_pipe_clk_src",
+			.parent_data = gcc_parent_data_34,
+			.num_parents = ARRAY_SIZE(gcc_parent_data_34),
+			.ops = &clk_regmap_mux_closest_ops,
+		},
+	},
+};
+
 static struct clk_branch gcc_usb3_prim_phy_pipe_clk = {
 	.halt_reg = 0x39068,
 	.halt_check = BRANCH_HALT_SKIP,
@@ -5167,7 +5602,7 @@ static struct clk_branch gcc_usb3_prim_phy_pipe_clk = {
 		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_usb3_prim_phy_pipe_clk",
 			.parent_hws = (const struct clk_hw*[]) {
-				&gcc_usb3_prim_phy_pipe_clk_src.clkr.hw,
+				&gcc_usb34_prim_phy_pipe_clk_src.clkr.hw,
 			},
 			.num_parents = 1,
 			.flags = CLK_SET_RATE_PARENT,
@@ -5227,6 +5662,33 @@ static struct clk_regmap_mux gcc_usb3_sec_phy_pipe_clk_src = {
 	},
 };
 
+static const struct parent_map gcc_parent_map_35[] = {
+	{ P_GCC_USB3_SEC_PHY_PIPE_CLK_SRC, 0 },
+	{ P_USB4_1_PHY_GCC_USB4RTR_MAX_PIPE_CLK, 1 },
+	{ P_GCC_USB4_1_PHY_PIPEGMUX_CLK_SRC, 3 },
+};
+
+static const struct clk_parent_data gcc_parent_data_35[] = {
+	{ .hw = &gcc_usb3_sec_phy_pipe_clk_src.clkr.hw },
+	{ .index = DT_USB4_1_PHY_GCC_USB4RTR_MAX_PIPE_CLK },
+	{ .index = DT_GCC_USB4_1_PHY_PIPEGMUX_CLK_SRC },
+};
+
+static struct clk_regmap_mux gcc_usb34_sec_phy_pipe_clk_src = {
+	.reg = 0xa1070,
+	.shift = 0,
+	.width = 2,
+	.parent_map = gcc_parent_map_35,
+	.clkr = {
+		.hw.init = &(const struct clk_init_data) {
+			.name = "gcc_usb34_sec_phy_pipe_clk_src",
+			.parent_data = gcc_parent_data_35,
+			.num_parents = ARRAY_SIZE(gcc_parent_data_35),
+			.ops = &clk_regmap_mux_closest_ops,
+		},
+	},
+};
+
 static struct clk_branch gcc_usb3_sec_phy_pipe_clk = {
 	.halt_reg = 0xa1068,
 	.halt_check = BRANCH_HALT_SKIP,
@@ -5238,7 +5700,7 @@ static struct clk_branch gcc_usb3_sec_phy_pipe_clk = {
 		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_usb3_sec_phy_pipe_clk",
 			.parent_hws = (const struct clk_hw*[]) {
-				&gcc_usb3_sec_phy_pipe_clk_src.clkr.hw,
+				&gcc_usb34_sec_phy_pipe_clk_src.clkr.hw,
 			},
 			.num_parents = 1,
 			.flags = CLK_SET_RATE_PARENT,
@@ -5298,6 +5760,33 @@ static struct clk_regmap_mux gcc_usb3_tert_phy_pipe_clk_src = {
 	},
 };
 
+static const struct parent_map gcc_parent_map_36[] = {
+	{ P_GCC_USB3_TERT_PHY_PIPE_CLK_SRC, 0 },
+	{ P_USB4_2_PHY_GCC_USB4RTR_MAX_PIPE_CLK, 1 },
+	{ P_GCC_USB4_2_PHY_PIPEGMUX_CLK_SRC, 3 },
+};
+
+static const struct clk_parent_data gcc_parent_data_36[] = {
+	{ .hw = &gcc_usb3_tert_phy_pipe_clk_src.clkr.hw },
+	{ .index = DT_USB4_2_PHY_GCC_USB4RTR_MAX_PIPE_CLK },
+	{ .index = DT_GCC_USB4_2_PHY_PIPEGMUX_CLK_SRC },
+};
+
+static struct clk_regmap_mux gcc_usb34_tert_phy_pipe_clk_src = {
+	.reg = 0xa2070,
+	.shift = 0,
+	.width = 2,
+	.parent_map = gcc_parent_map_36,
+	.clkr = {
+		.hw.init = &(const struct clk_init_data) {
+			.name = "gcc_usb34_tert_phy_pipe_clk_src",
+			.parent_data = gcc_parent_data_36,
+			.num_parents = ARRAY_SIZE(gcc_parent_data_36),
+			.ops = &clk_regmap_mux_closest_ops,
+		},
+	},
+};
+
 static struct clk_branch gcc_usb3_tert_phy_pipe_clk = {
 	.halt_reg = 0xa2068,
 	.halt_check = BRANCH_HALT_SKIP,
@@ -5309,7 +5798,7 @@ static struct clk_branch gcc_usb3_tert_phy_pipe_clk = {
 		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_usb3_tert_phy_pipe_clk",
 			.parent_hws = (const struct clk_hw*[]) {
-				&gcc_usb3_tert_phy_pipe_clk_src.clkr.hw,
+				&gcc_usb34_tert_phy_pipe_clk_src.clkr.hw,
 			},
 			.num_parents = 1,
 			.flags = CLK_SET_RATE_PARENT,
@@ -5335,12 +5824,17 @@ static struct clk_branch gcc_usb4_0_cfg_ahb_clk = {
 
 static struct clk_branch gcc_usb4_0_dp0_clk = {
 	.halt_reg = 0x9f060,
-	.halt_check = BRANCH_HALT,
+	.halt_check = BRANCH_HALT_SKIP,
 	.clkr = {
 		.enable_reg = 0x9f060,
 		.enable_mask = BIT(0),
 		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_usb4_0_dp0_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&gcc_usb4_0_phy_dp0_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
 			.ops = &clk_branch2_ops,
 		},
 	},
@@ -5348,12 +5842,17 @@ static struct clk_branch gcc_usb4_0_dp0_clk = {
 
 static struct clk_branch gcc_usb4_0_dp1_clk = {
 	.halt_reg = 0x9f108,
-	.halt_check = BRANCH_HALT,
+	.halt_check = BRANCH_HALT_SKIP,
 	.clkr = {
 		.enable_reg = 0x9f108,
 		.enable_mask = BIT(0),
 		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_usb4_0_dp1_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&gcc_usb4_0_phy_dp1_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
 			.ops = &clk_branch2_ops,
 		},
 	},
@@ -5385,6 +5884,11 @@ static struct clk_branch gcc_usb4_0_phy_p2rr2p_pipe_clk = {
 		.enable_mask = BIT(0),
 		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_usb4_0_phy_p2rr2p_pipe_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&gcc_usb4_0_phy_p2rr2p_pipe_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
 			.ops = &clk_branch2_ops,
 		},
 	},
@@ -5398,6 +5902,11 @@ static struct clk_branch gcc_usb4_0_phy_pcie_pipe_clk = {
 		.enable_mask = BIT(19),
 		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_usb4_0_phy_pcie_pipe_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&gcc_usb4_0_phy_pcie_pipe_mux_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
 			.ops = &clk_branch2_ops,
 		},
 	},
@@ -5405,12 +5914,17 @@ static struct clk_branch gcc_usb4_0_phy_pcie_pipe_clk = {
 
 static struct clk_branch gcc_usb4_0_phy_rx0_clk = {
 	.halt_reg = 0x9f0b0,
-	.halt_check = BRANCH_HALT,
+	.halt_check = BRANCH_HALT_SKIP,
 	.clkr = {
 		.enable_reg = 0x9f0b0,
 		.enable_mask = BIT(0),
 		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_usb4_0_phy_rx0_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&gcc_usb4_0_phy_rx0_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
 			.ops = &clk_branch2_ops,
 		},
 	},
@@ -5418,12 +5932,17 @@ static struct clk_branch gcc_usb4_0_phy_rx0_clk = {
 
 static struct clk_branch gcc_usb4_0_phy_rx1_clk = {
 	.halt_reg = 0x9f0c0,
-	.halt_check = BRANCH_HALT,
+	.halt_check = BRANCH_HALT_SKIP,
 	.clkr = {
 		.enable_reg = 0x9f0c0,
 		.enable_mask = BIT(0),
 		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_usb4_0_phy_rx1_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&gcc_usb4_0_phy_rx1_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
 			.ops = &clk_branch2_ops,
 		},
 	},
@@ -5439,6 +5958,11 @@ static struct clk_branch gcc_usb4_0_phy_usb_pipe_clk = {
 		.enable_mask = BIT(0),
 		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_usb4_0_phy_usb_pipe_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&gcc_usb34_prim_phy_pipe_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
 			.ops = &clk_branch2_ops,
 		},
 	},
@@ -5470,6 +5994,11 @@ static struct clk_branch gcc_usb4_0_sys_clk = {
 		.enable_mask = BIT(0),
 		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_usb4_0_sys_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&gcc_usb4_0_phy_sys_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
 			.ops = &clk_branch2_ops,
 		},
 	},
@@ -5512,12 +6041,17 @@ static struct clk_branch gcc_usb4_1_cfg_ahb_clk = {
 
 static struct clk_branch gcc_usb4_1_dp0_clk = {
 	.halt_reg = 0x2b060,
-	.halt_check = BRANCH_HALT,
+	.halt_check = BRANCH_HALT_SKIP,
 	.clkr = {
 		.enable_reg = 0x2b060,
 		.enable_mask = BIT(0),
 		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_usb4_1_dp0_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&gcc_usb4_1_phy_dp0_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
 			.ops = &clk_branch2_ops,
 		},
 	},
@@ -5525,12 +6059,17 @@ static struct clk_branch gcc_usb4_1_dp0_clk = {
 
 static struct clk_branch gcc_usb4_1_dp1_clk = {
 	.halt_reg = 0x2b108,
-	.halt_check = BRANCH_HALT,
+	.halt_check = BRANCH_HALT_SKIP,
 	.clkr = {
 		.enable_reg = 0x2b108,
 		.enable_mask = BIT(0),
 		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_usb4_1_dp1_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&gcc_usb4_1_phy_dp1_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
 			.ops = &clk_branch2_ops,
 		},
 	},
@@ -5562,6 +6101,11 @@ static struct clk_branch gcc_usb4_1_phy_p2rr2p_pipe_clk = {
 		.enable_mask = BIT(0),
 		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_usb4_1_phy_p2rr2p_pipe_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&gcc_usb4_1_phy_p2rr2p_pipe_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
 			.ops = &clk_branch2_ops,
 		},
 	},
@@ -5575,6 +6119,11 @@ static struct clk_branch gcc_usb4_1_phy_pcie_pipe_clk = {
 		.enable_mask = BIT(0),
 		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_usb4_1_phy_pcie_pipe_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&gcc_usb4_1_phy_pcie_pipe_mux_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
 			.ops = &clk_branch2_ops,
 		},
 	},
@@ -5582,12 +6131,17 @@ static struct clk_branch gcc_usb4_1_phy_pcie_pipe_clk = {
 
 static struct clk_branch gcc_usb4_1_phy_rx0_clk = {
 	.halt_reg = 0x2b0b0,
-	.halt_check = BRANCH_HALT,
+	.halt_check = BRANCH_HALT_SKIP,
 	.clkr = {
 		.enable_reg = 0x2b0b0,
 		.enable_mask = BIT(0),
 		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_usb4_1_phy_rx0_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&gcc_usb4_1_phy_rx0_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
 			.ops = &clk_branch2_ops,
 		},
 	},
@@ -5595,12 +6149,17 @@ static struct clk_branch gcc_usb4_1_phy_rx0_clk = {
 
 static struct clk_branch gcc_usb4_1_phy_rx1_clk = {
 	.halt_reg = 0x2b0c0,
-	.halt_check = BRANCH_HALT,
+	.halt_check = BRANCH_HALT_SKIP,
 	.clkr = {
 		.enable_reg = 0x2b0c0,
 		.enable_mask = BIT(0),
 		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_usb4_1_phy_rx1_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&gcc_usb4_1_phy_rx1_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
 			.ops = &clk_branch2_ops,
 		},
 	},
@@ -5616,6 +6175,11 @@ static struct clk_branch gcc_usb4_1_phy_usb_pipe_clk = {
 		.enable_mask = BIT(0),
 		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_usb4_1_phy_usb_pipe_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&gcc_usb34_sec_phy_pipe_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
 			.ops = &clk_branch2_ops,
 		},
 	},
@@ -5647,6 +6211,11 @@ static struct clk_branch gcc_usb4_1_sys_clk = {
 		.enable_mask = BIT(0),
 		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_usb4_1_sys_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&gcc_usb4_1_phy_sys_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
 			.ops = &clk_branch2_ops,
 		},
 	},
@@ -5689,12 +6258,17 @@ static struct clk_branch gcc_usb4_2_cfg_ahb_clk = {
 
 static struct clk_branch gcc_usb4_2_dp0_clk = {
 	.halt_reg = 0x11060,
-	.halt_check = BRANCH_HALT,
+	.halt_check = BRANCH_HALT_SKIP,
 	.clkr = {
 		.enable_reg = 0x11060,
 		.enable_mask = BIT(0),
 		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_usb4_2_dp0_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&gcc_usb4_2_phy_dp0_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
 			.ops = &clk_branch2_ops,
 		},
 	},
@@ -5702,12 +6276,17 @@ static struct clk_branch gcc_usb4_2_dp0_clk = {
 
 static struct clk_branch gcc_usb4_2_dp1_clk = {
 	.halt_reg = 0x11108,
-	.halt_check = BRANCH_HALT,
+	.halt_check = BRANCH_HALT_SKIP,
 	.clkr = {
 		.enable_reg = 0x11108,
 		.enable_mask = BIT(0),
 		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_usb4_2_dp1_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&gcc_usb4_2_phy_dp1_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
 			.ops = &clk_branch2_ops,
 		},
 	},
@@ -5739,6 +6318,11 @@ static struct clk_branch gcc_usb4_2_phy_p2rr2p_pipe_clk = {
 		.enable_mask = BIT(0),
 		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_usb4_2_phy_p2rr2p_pipe_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&gcc_usb4_2_phy_p2rr2p_pipe_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
 			.ops = &clk_branch2_ops,
 		},
 	},
@@ -5752,6 +6336,11 @@ static struct clk_branch gcc_usb4_2_phy_pcie_pipe_clk = {
 		.enable_mask = BIT(1),
 		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_usb4_2_phy_pcie_pipe_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&gcc_usb4_2_phy_pcie_pipe_mux_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
 			.ops = &clk_branch2_ops,
 		},
 	},
@@ -5759,12 +6348,17 @@ static struct clk_branch gcc_usb4_2_phy_pcie_pipe_clk = {
 
 static struct clk_branch gcc_usb4_2_phy_rx0_clk = {
 	.halt_reg = 0x110b0,
-	.halt_check = BRANCH_HALT,
+	.halt_check = BRANCH_HALT_SKIP,
 	.clkr = {
 		.enable_reg = 0x110b0,
 		.enable_mask = BIT(0),
 		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_usb4_2_phy_rx0_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&gcc_usb4_2_phy_rx0_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
 			.ops = &clk_branch2_ops,
 		},
 	},
@@ -5772,12 +6366,17 @@ static struct clk_branch gcc_usb4_2_phy_rx0_clk = {
 
 static struct clk_branch gcc_usb4_2_phy_rx1_clk = {
 	.halt_reg = 0x110c0,
-	.halt_check = BRANCH_HALT,
+	.halt_check = BRANCH_HALT_SKIP,
 	.clkr = {
 		.enable_reg = 0x110c0,
 		.enable_mask = BIT(0),
 		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_usb4_2_phy_rx1_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&gcc_usb4_2_phy_rx1_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
 			.ops = &clk_branch2_ops,
 		},
 	},
@@ -5793,6 +6392,11 @@ static struct clk_branch gcc_usb4_2_phy_usb_pipe_clk = {
 		.enable_mask = BIT(0),
 		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_usb4_2_phy_usb_pipe_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&gcc_usb34_tert_phy_pipe_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
 			.ops = &clk_branch2_ops,
 		},
 	},
@@ -6483,6 +7087,9 @@ static struct clk_regmap *gcc_x1e80100_clocks[] = {
 	[GCC_USB30_TERT_MOCK_UTMI_CLK_SRC] = &gcc_usb30_tert_mock_utmi_clk_src.clkr,
 	[GCC_USB30_TERT_MOCK_UTMI_POSTDIV_CLK_SRC] = &gcc_usb30_tert_mock_utmi_postdiv_clk_src.clkr,
 	[GCC_USB30_TERT_SLEEP_CLK] = &gcc_usb30_tert_sleep_clk.clkr,
+	[GCC_USB34_PRIM_PHY_PIPE_CLK_SRC] = &gcc_usb34_prim_phy_pipe_clk_src.clkr,
+	[GCC_USB34_SEC_PHY_PIPE_CLK_SRC] = &gcc_usb34_sec_phy_pipe_clk_src.clkr,
+	[GCC_USB34_TERT_PHY_PIPE_CLK_SRC] = &gcc_usb34_tert_phy_pipe_clk_src.clkr,
 	[GCC_USB3_MP_PHY_AUX_CLK] = &gcc_usb3_mp_phy_aux_clk.clkr,
 	[GCC_USB3_MP_PHY_AUX_CLK_SRC] = &gcc_usb3_mp_phy_aux_clk_src.clkr,
 	[GCC_USB3_MP_PHY_COM_AUX_CLK] = &gcc_usb3_mp_phy_com_aux_clk.clkr,
@@ -6508,11 +7115,18 @@ static struct clk_regmap *gcc_x1e80100_clocks[] = {
 	[GCC_USB4_0_DP1_CLK] = &gcc_usb4_0_dp1_clk.clkr,
 	[GCC_USB4_0_MASTER_CLK] = &gcc_usb4_0_master_clk.clkr,
 	[GCC_USB4_0_MASTER_CLK_SRC] = &gcc_usb4_0_master_clk_src.clkr,
+	[GCC_USB4_0_PHY_DP0_CLK_SRC] = &gcc_usb4_0_phy_dp0_clk_src.clkr,
+	[GCC_USB4_0_PHY_DP1_CLK_SRC] = &gcc_usb4_0_phy_dp1_clk_src.clkr,
 	[GCC_USB4_0_PHY_P2RR2P_PIPE_CLK] = &gcc_usb4_0_phy_p2rr2p_pipe_clk.clkr,
+	[GCC_USB4_0_PHY_P2RR2P_PIPE_CLK_SRC] = &gcc_usb4_0_phy_p2rr2p_pipe_clk_src.clkr,
 	[GCC_USB4_0_PHY_PCIE_PIPE_CLK] = &gcc_usb4_0_phy_pcie_pipe_clk.clkr,
 	[GCC_USB4_0_PHY_PCIE_PIPE_CLK_SRC] = &gcc_usb4_0_phy_pcie_pipe_clk_src.clkr,
+	[GCC_USB4_0_PHY_PCIE_PIPE_MUX_CLK_SRC] = &gcc_usb4_0_phy_pcie_pipe_mux_clk_src.clkr,
 	[GCC_USB4_0_PHY_RX0_CLK] = &gcc_usb4_0_phy_rx0_clk.clkr,
+	[GCC_USB4_0_PHY_RX0_CLK_SRC] = &gcc_usb4_0_phy_rx0_clk_src.clkr,
 	[GCC_USB4_0_PHY_RX1_CLK] = &gcc_usb4_0_phy_rx1_clk.clkr,
+	[GCC_USB4_0_PHY_RX1_CLK_SRC] = &gcc_usb4_0_phy_rx1_clk_src.clkr,
+	[GCC_USB4_0_PHY_SYS_CLK_SRC] = &gcc_usb4_0_phy_sys_clk_src.clkr,
 	[GCC_USB4_0_PHY_USB_PIPE_CLK] = &gcc_usb4_0_phy_usb_pipe_clk.clkr,
 	[GCC_USB4_0_SB_IF_CLK] = &gcc_usb4_0_sb_if_clk.clkr,
 	[GCC_USB4_0_SB_IF_CLK_SRC] = &gcc_usb4_0_sb_if_clk_src.clkr,
@@ -6524,11 +7138,18 @@ static struct clk_regmap *gcc_x1e80100_clocks[] = {
 	[GCC_USB4_1_DP1_CLK] = &gcc_usb4_1_dp1_clk.clkr,
 	[GCC_USB4_1_MASTER_CLK] = &gcc_usb4_1_master_clk.clkr,
 	[GCC_USB4_1_MASTER_CLK_SRC] = &gcc_usb4_1_master_clk_src.clkr,
+	[GCC_USB4_1_PHY_DP0_CLK_SRC] = &gcc_usb4_1_phy_dp0_clk_src.clkr,
+	[GCC_USB4_1_PHY_DP1_CLK_SRC] = &gcc_usb4_1_phy_dp1_clk_src.clkr,
 	[GCC_USB4_1_PHY_P2RR2P_PIPE_CLK] = &gcc_usb4_1_phy_p2rr2p_pipe_clk.clkr,
+	[GCC_USB4_1_PHY_P2RR2P_PIPE_CLK_SRC] = &gcc_usb4_1_phy_p2rr2p_pipe_clk_src.clkr,
 	[GCC_USB4_1_PHY_PCIE_PIPE_CLK] = &gcc_usb4_1_phy_pcie_pipe_clk.clkr,
 	[GCC_USB4_1_PHY_PCIE_PIPE_CLK_SRC] = &gcc_usb4_1_phy_pcie_pipe_clk_src.clkr,
+	[GCC_USB4_1_PHY_PCIE_PIPE_MUX_CLK_SRC] = &gcc_usb4_1_phy_pcie_pipe_mux_clk_src.clkr,
 	[GCC_USB4_1_PHY_RX0_CLK] = &gcc_usb4_1_phy_rx0_clk.clkr,
+	[GCC_USB4_1_PHY_RX0_CLK_SRC] = &gcc_usb4_1_phy_rx0_clk_src.clkr,
 	[GCC_USB4_1_PHY_RX1_CLK] = &gcc_usb4_1_phy_rx1_clk.clkr,
+	[GCC_USB4_1_PHY_RX1_CLK_SRC] = &gcc_usb4_1_phy_rx1_clk_src.clkr,
+	[GCC_USB4_1_PHY_SYS_CLK_SRC] = &gcc_usb4_1_phy_sys_clk_src.clkr,
 	[GCC_USB4_1_PHY_USB_PIPE_CLK] = &gcc_usb4_1_phy_usb_pipe_clk.clkr,
 	[GCC_USB4_1_SB_IF_CLK] = &gcc_usb4_1_sb_if_clk.clkr,
 	[GCC_USB4_1_SB_IF_CLK_SRC] = &gcc_usb4_1_sb_if_clk_src.clkr,
@@ -6540,11 +7161,18 @@ static struct clk_regmap *gcc_x1e80100_clocks[] = {
 	[GCC_USB4_2_DP1_CLK] = &gcc_usb4_2_dp1_clk.clkr,
 	[GCC_USB4_2_MASTER_CLK] = &gcc_usb4_2_master_clk.clkr,
 	[GCC_USB4_2_MASTER_CLK_SRC] = &gcc_usb4_2_master_clk_src.clkr,
+	[GCC_USB4_2_PHY_DP0_CLK_SRC] = &gcc_usb4_2_phy_dp0_clk_src.clkr,
+	[GCC_USB4_2_PHY_DP1_CLK_SRC] = &gcc_usb4_2_phy_dp1_clk_src.clkr,
 	[GCC_USB4_2_PHY_P2RR2P_PIPE_CLK] = &gcc_usb4_2_phy_p2rr2p_pipe_clk.clkr,
+	[GCC_USB4_2_PHY_P2RR2P_PIPE_CLK_SRC] = &gcc_usb4_2_phy_p2rr2p_pipe_clk_src.clkr,
 	[GCC_USB4_2_PHY_PCIE_PIPE_CLK] = &gcc_usb4_2_phy_pcie_pipe_clk.clkr,
 	[GCC_USB4_2_PHY_PCIE_PIPE_CLK_SRC] = &gcc_usb4_2_phy_pcie_pipe_clk_src.clkr,
+	[GCC_USB4_2_PHY_PCIE_PIPE_MUX_CLK_SRC] = &gcc_usb4_2_phy_pcie_pipe_mux_clk_src.clkr,
 	[GCC_USB4_2_PHY_RX0_CLK] = &gcc_usb4_2_phy_rx0_clk.clkr,
+	[GCC_USB4_2_PHY_RX0_CLK_SRC] = &gcc_usb4_2_phy_rx0_clk_src.clkr,
 	[GCC_USB4_2_PHY_RX1_CLK] = &gcc_usb4_2_phy_rx1_clk.clkr,
+	[GCC_USB4_2_PHY_RX1_CLK_SRC] = &gcc_usb4_2_phy_rx1_clk_src.clkr,
+	[GCC_USB4_2_PHY_SYS_CLK_SRC] = &gcc_usb4_2_phy_sys_clk_src.clkr,
 	[GCC_USB4_2_PHY_USB_PIPE_CLK] = &gcc_usb4_2_phy_usb_pipe_clk.clkr,
 	[GCC_USB4_2_SB_IF_CLK] = &gcc_usb4_2_sb_if_clk.clkr,
 	[GCC_USB4_2_SB_IF_CLK_SRC] = &gcc_usb4_2_sb_if_clk_src.clkr,
@@ -6660,16 +7288,52 @@ static const struct qcom_reset_map gcc_x1e80100_resets[] = {
 	[GCC_USB3_UNIPHY_MP0_BCR] = { 0x19000 },
 	[GCC_USB3_UNIPHY_MP1_BCR] = { 0x54000 },
 	[GCC_USB3PHY_PHY_PRIM_BCR] = { 0x50004 },
+	[GCC_USB4PHY_PHY_PRIM_BCR] = { 0x5000c },
 	[GCC_USB3PHY_PHY_SEC_BCR] = { 0x2a004 },
+	[GCC_USB4PHY_PHY_SEC_BCR] = { 0x2a00c },
 	[GCC_USB3PHY_PHY_TERT_BCR] = { 0xa3004 },
+	[GCC_USB4PHY_PHY_TERT_BCR] = { 0xa300c },
 	[GCC_USB3UNIPHY_PHY_MP0_BCR] = { 0x19004 },
 	[GCC_USB3UNIPHY_PHY_MP1_BCR] = { 0x54004 },
 	[GCC_USB4_0_BCR] = { 0x9f000 },
 	[GCC_USB4_0_DP0_PHY_PRIM_BCR] = { 0x50010 },
-	[GCC_USB4_1_DP0_PHY_SEC_BCR] = { 0x2a010 },
-	[GCC_USB4_2_DP0_PHY_TERT_BCR] = { 0xa3010 },
+	[GCC_USB4_0_MISC_USB4_SYS_BCR] = { .reg = 0xad0f8, .bit = 0 },
+	[GCC_USB4_0_MISC_RX_CLK_0_BCR] = { .reg = 0xad0f8, .bit = 1 },
+	[GCC_USB4_0_MISC_RX_CLK_1_BCR] = { .reg = 0xad0f8, .bit = 2 },
+	[GCC_USB4_0_MISC_USB_PIPE_BCR] = { .reg = 0xad0f8, .bit = 3 },
+	[GCC_USB4_0_MISC_PCIE_PIPE_BCR] = { .reg = 0xad0f8, .bit = 4 },
+	[GCC_USB4_0_MISC_TMU_BCR] = { .reg = 0xad0f8, .bit = 5 },
+	[GCC_USB4_0_MISC_SB_IF_BCR] = { .reg = 0xad0f8, .bit = 6 },
+	[GCC_USB4_0_MISC_HIA_MSTR_BCR] = { .reg = 0xad0f8, .bit = 7 },
+	[GCC_USB4_0_MISC_AHB_BCR] = { .reg = 0xad0f8, .bit = 8 },
+	[GCC_USB4_0_MISC_DP0_MAX_PCLK_BCR] = { .reg = 0xad0f8, .bit = 9 },
+	[GCC_USB4_0_MISC_DP1_MAX_PCLK_BCR] = { .reg = 0xad0f8, .bit = 10 },
 	[GCC_USB4_1_BCR] = { 0x2b000 },
+	[GCC_USB4_1_DP0_PHY_SEC_BCR] = { 0x2a010 },
+	[GCC_USB4_1_MISC_USB4_SYS_BCR] = { .reg = 0xae0f8, .bit = 0 },
+	[GCC_USB4_1_MISC_RX_CLK_0_BCR] = { .reg = 0xae0f8, .bit = 1 },
+	[GCC_USB4_1_MISC_RX_CLK_1_BCR] = { .reg = 0xae0f8, .bit = 2 },
+	[GCC_USB4_1_MISC_USB_PIPE_BCR] = { .reg = 0xae0f8, .bit = 3 },
+	[GCC_USB4_1_MISC_PCIE_PIPE_BCR] = { .reg = 0xae0f8, .bit = 4 },
+	[GCC_USB4_1_MISC_TMU_BCR] = { .reg = 0xae0f8, .bit = 5 },
+	[GCC_USB4_1_MISC_SB_IF_BCR] = { .reg = 0xae0f8, .bit = 6 },
+	[GCC_USB4_1_MISC_HIA_MSTR_BCR] = { .reg = 0xae0f8, .bit = 7 },
+	[GCC_USB4_1_MISC_AHB_BCR] = { .reg = 0xae0f8, .bit = 8 },
+	[GCC_USB4_1_MISC_DP0_MAX_PCLK_BCR] = { .reg = 0xae0f8, .bit = 9 },
+	[GCC_USB4_1_MISC_DP1_MAX_PCLK_BCR] = { .reg = 0xae0f8, .bit = 10 },
 	[GCC_USB4_2_BCR] = { 0x11000 },
+	[GCC_USB4_2_DP0_PHY_TERT_BCR] = { 0xa3010 },
+	[GCC_USB4_2_MISC_USB4_SYS_BCR] = { .reg = 0xaf0f8, .bit = 0 },
+	[GCC_USB4_2_MISC_RX_CLK_0_BCR] = { .reg = 0xaf0f8, .bit = 1 },
+	[GCC_USB4_2_MISC_RX_CLK_1_BCR] = { .reg = 0xaf0f8, .bit = 2 },
+	[GCC_USB4_2_MISC_USB_PIPE_BCR] = { .reg = 0xaf0f8, .bit = 3 },
+	[GCC_USB4_2_MISC_PCIE_PIPE_BCR] = { .reg = 0xaf0f8, .bit = 4 },
+	[GCC_USB4_2_MISC_TMU_BCR] = { .reg = 0xaf0f8, .bit = 5 },
+	[GCC_USB4_2_MISC_SB_IF_BCR] = { .reg = 0xaf0f8, .bit = 6 },
+	[GCC_USB4_2_MISC_HIA_MSTR_BCR] = { .reg = 0xaf0f8, .bit = 7 },
+	[GCC_USB4_2_MISC_AHB_BCR] = { .reg = 0xaf0f8, .bit = 8 },
+	[GCC_USB4_2_MISC_DP0_MAX_PCLK_BCR] = { .reg = 0xaf0f8, .bit = 9 },
+	[GCC_USB4_2_MISC_DP1_MAX_PCLK_BCR] = { .reg = 0xaf0f8, .bit = 10 },
 	[GCC_USB_0_PHY_BCR] = { 0x50020 },
 	[GCC_USB_1_PHY_BCR] = { 0x2a020 },
 	[GCC_USB_2_PHY_BCR] = { 0xa3020 },

-- 
2.51.0


