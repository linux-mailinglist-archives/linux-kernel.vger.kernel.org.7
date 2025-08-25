Return-Path: <linux-kernel+bounces-784967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47AB2B343F8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 16:33:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C2D77A4C62
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 14:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27E2F3090FD;
	Mon, 25 Aug 2025 14:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="GwYgvgXE"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 527C3305E1D
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 14:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756132043; cv=none; b=qC2vQzV9iqKHCuv9zV8kKRlKplULvE+Mlab//pW5bljiHsiILKAjZ30Z+mBIrW+3ECRF0PGKEPIqphIdWdqQ4t2RxiwcTQUdu+ZthMcsKFHD1t8Ma8WHugUBvhVgZ9bBQi2cLIpHAgTZ03IMhTOA82mhufbY5Eus8ePvH0x2vtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756132043; c=relaxed/simple;
	bh=ps9sLzPPWk2M8ivkTmXUaslXwG8/bmatTRMHNFG1fME=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hrfzN4MaxBtae83jB9pN2iVGu/0B+fh37Tp/W6PBrhrK1fsaDHPhk7NXo/fSZWqRCHVqQPxa+MgeSAMYJvxECjih3b30ktUYY9mZ1yJHVo2aFHUoJOV0zqO1M2sgx32XbfGYPaSSbLq5dTM/MBG34EqbAw5DY78TlbMDWvpnhgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=GwYgvgXE; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3c8fe6bd1a2so429613f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 07:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1756132035; x=1756736835; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ztmX1UDMK5rFccXy1oFM7d/s55AHNRDE1K8M0+F4fD8=;
        b=GwYgvgXEuCdmuBiCuD8TSEMhxeZat/mKZzXPkF5uTP6ryX9HP4yZ0VkzHNIddp8DpP
         HWpJDetJypDWuVPZN+wJml9Jz+s4tWooTo90+NVZ7btJ1onMz8akN9dArVDe9t7+PV04
         e+oh2AXlK1l0X1vdZFL80/EhX5+ZXaJG6e+JxCIIlKcn0AE5gwfycbFpHbaTYaVbckIH
         n8G17RKyvZw9jIXY9LLaiVmKh+nLhxD/lUv0iaZAJFGETSZIv7hDdWvBTeF2D1nkeWqP
         IcnL7U8E07+24psTmpke1Pp724a3U30g4wGjCFBE/kasKkYgDX2g0JwSy4OnILlfE5sG
         zFyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756132035; x=1756736835;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ztmX1UDMK5rFccXy1oFM7d/s55AHNRDE1K8M0+F4fD8=;
        b=MJkc8EcPZBL6CBUuPjXkmJ2NS2EWvOAFJbAZgxP9wluTH9TJo5J4Y5OGNdjluLXoDW
         vwxhKKqRZDtjO9XS7t+sXcSKgVyPbaQMGQlN1TIG+T2cDeEh4szvQb5JBuPdan3qM7kX
         jitjP5l0oONvb5wVdLlxmR3DJz6vxM45rJivvmGk9+lvpW9E0BGvUkw9OhBc28v8xGj4
         /B0XAFVduuNA5P+xEoG6HuWPNBmo0WR/HV8WmX5+uaEu70/smCVCX4UYZao6pA9rI2pB
         m4b/ePcnY9Gw3RJ1GnItOkib08g5sfE1H33k/ll96hbitxzPKYgoBZZJ80OQD8dZzuzb
         gVSQ==
X-Forwarded-Encrypted: i=1; AJvYcCVqVDD+eYek947o/EzTHEfoc/+0Hkdna9mgtEORJik5NO5cOTn4Ly614qy3tGdSnU4URWEIeuIGWT/7L2Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZZ9rAB0tuTSNvLjQQfpe8lPvv1WoMUylBQHf17MCxeEjVBo0k
	T6US2V2H+N7zB4a52is8Dy1pjbvwuGcUxN46Sb5LRjJ93kusPqkn6K3i3FkCXM8pbLE=
X-Gm-Gg: ASbGncsH7RQyagMYzrWbVWFenNsqLb0v5OpbjnTef5j1ReEyrdbQy7n89XjcTZ/DsRq
	oY7i4rVgmw3eWrYYQtqO6eL8L49Vqj2/F/xc9H25G74ygJMtCJPn8clYVRFBP8VrS9W7C39yz7z
	yPpt7kEKnhonL+On4qa2tb3MgwQpcrWnUBh5WKTx3yndLhME9I9/d1ABH6jVo3+reY+TKnVpOCl
	qMJT9YODJAX4iU4DMEG/NMvzBCVR3wFRop3gaY3CVNxFsj1zNkcWru0eSKChU9JCgFXjpJoNxgw
	89oRdvzmaXuMDl4bgHEuT9MC14hvBO22SUWwnjYghCrnm/NJiuhFCQAeljkhMNAUjhRKLi0v+ic
	0Z1818xyQQrkGp282IjPyWtjiI/hHUuaL/w88
X-Google-Smtp-Source: AGHT+IFnC0MUZSq/sl9kL/TcEekI5S6Ch+nzFMuQT2QCGnMv7MVM3STVdYmSZ5zm0xBhJbPzwkXGqQ==
X-Received: by 2002:a05:6000:238a:b0:3b8:d79a:6a60 with SMTP id ffacd0b85a97d-3c5daa27b08mr9526344f8f.3.1756132034951;
        Mon, 25 Aug 2025 07:27:14 -0700 (PDT)
Received: from toaster.baylibre.com ([2a01:e0a:3c5:5fb1:b261:baab:ed3d:3cb6])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3c70e4b9e1fsm12634462f8f.14.2025.08.25.07.27.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 07:27:14 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Mon, 25 Aug 2025 16:26:37 +0200
Subject: [PATCH v2 12/12] clk: amlogic: c3-peripherals: use helper for
 basic composite clocks
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250825-meson-clk-cleanup-24-v2-12-0f402f01e117@baylibre.com>
References: <20250825-meson-clk-cleanup-24-v2-0-0f402f01e117@baylibre.com>
In-Reply-To: <20250825-meson-clk-cleanup-24-v2-0-0f402f01e117@baylibre.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Kevin Hilman <khilman@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jerome Brunet <jbrunet@baylibre.com>, 
 Chuan Liu <chuan.liu@amlogic.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=32323; i=jbrunet@baylibre.com;
 h=from:subject:message-id; bh=ps9sLzPPWk2M8ivkTmXUaslXwG8/bmatTRMHNFG1fME=;
 b=owEBbQKS/ZANAwAKAeb8Dxw38tqFAcsmYgBorHK4qpXm7JmpvPobuRaQvfv+8Nfs2wLyI4+RD
 dk9RSaqFQCJAjMEAAEKAB0WIQT04VmuGPP1bV8btxvm/A8cN/LahQUCaKxyuAAKCRDm/A8cN/La
 hRGoEACDZa/T4n3cZ+Et6j5Ca+v57X1x5SyuJ2iXWhlDxHe0rIZIRSBjD5FqDgNP8mePJIPqeOy
 2YaS4wC25muwGthDedfsI6xl7XNhwxlCgKZ5h4CPT04FFyzHM3lXJtGqD4dkg07zLCTTfCz8Wdm
 WA7eRVBgKHlhd1ZBzjvkTyy1z1dwcHEegWC2tydllMeTYuLRViF+Tn+VHr8+7h8GwjuqOUNpMz6
 ePO23AlWSuH7g6YssXUqKMLjhuijjzDlY1uZSvr9pxgWRR7YVz7O5FFV6qtSFCRJlEMywEl6DER
 mxWzs/7yug9/r40V4AAOgJm+jdwWkeshUssX6XcEUkYbtLlhB7+CpTUzgY/4jHVh/lZ9dI42aOZ
 Tu1ytx2J34WeRVMO3QcL8QmkXWzJA/AyAB6bRWXYohgCKprY4byIfuQnaWTpaJm2tuiGLLrItRz
 sOj2AS73uipN0gd2VJMelZ81x30d6g2MS8cJF2p883WZ6kCTbrXcAww3rU+ZKlSEg37WtE6Bj7J
 92osANTpGYvFn49R1taeZOGT++1gKomnKByigaVhRiATOY+7AHatcRtAZb9IUzwt61UKAMEG8Bp
 z72ZPSjjHi28E4/zIJJnCIXF8XwZxn8+rbm5cT9k8XSNSk/8MPlJBhsdazQ6s33okylcFquTCHB
 NnnmDwwLOOG3xWA==
X-Developer-Key: i=jbrunet@baylibre.com; a=openpgp;
 fpr=F29F26CF27BAE1A9719AE6BDC3C92AAF3E60AED9

Use the composite clock helpers to define simple composite clocks of
the c3-peripherals clock controller.

This reduces the verbosity of the controller code on these very simple
parts, making maintenance simpler.

Reviewed-by: Chuan Liu <chuan.liu@amlogic.com>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/clk/meson/c3-peripherals.c | 1029 +++---------------------------------
 1 file changed, 63 insertions(+), 966 deletions(-)

diff --git a/drivers/clk/meson/c3-peripherals.c b/drivers/clk/meson/c3-peripherals.c
index fd35f9b7994720d069c5f72142d6064790d40b60..b158756cfee4dd4bad5c0c9576da02d2cb8ee515 100644
--- a/drivers/clk/meson/c3-peripherals.c
+++ b/drivers/clk/meson/c3-peripherals.c
@@ -467,52 +467,9 @@ static const struct clk_parent_data c3_saradc_parents[] = {
 	{ .fw_name = "sysclk" }
 };
 
-static struct clk_regmap c3_saradc_sel = {
-	.data = &(struct clk_regmap_mux_data) {
-		.offset = SAR_CLK_CTRL0,
-		.mask = 0x1,
-		.shift = 9,
-	},
-	.hw.init = &(struct clk_init_data) {
-		.name = "saradc_sel",
-		.ops = &clk_regmap_mux_ops,
-		.parent_data = c3_saradc_parents,
-		.num_parents = ARRAY_SIZE(c3_saradc_parents),
-	},
-};
-
-static struct clk_regmap c3_saradc_div = {
-	.data = &(struct clk_regmap_div_data) {
-		.offset = SAR_CLK_CTRL0,
-		.shift = 0,
-		.width = 8,
-	},
-	.hw.init = &(struct clk_init_data) {
-		.name = "saradc_div",
-		.ops = &clk_regmap_divider_ops,
-		.parent_hws = (const struct clk_hw *[]) {
-			&c3_saradc_sel.hw
-		},
-		.num_parents = 1,
-		.flags = CLK_SET_RATE_PARENT,
-	},
-};
-
-static struct clk_regmap c3_saradc = {
-	.data = &(struct clk_regmap_gate_data) {
-		.offset = SAR_CLK_CTRL0,
-		.bit_idx = 8,
-	},
-	.hw.init = &(struct clk_init_data) {
-		.name = "saradc",
-		.ops = &clk_regmap_gate_ops,
-		.parent_hws = (const struct clk_hw *[]) {
-			&c3_saradc_div.hw
-		},
-		.num_parents = 1,
-		.flags = CLK_SET_RATE_PARENT,
-	},
-};
+static C3_COMP_SEL(saradc, SAR_CLK_CTRL0, 9, 0x1, c3_saradc_parents);
+static C3_COMP_DIV(saradc, SAR_CLK_CTRL0, 0, 8);
+static C3_COMP_GATE(saradc, SAR_CLK_CTRL0, 8);
 
 static const struct clk_parent_data c3_pwm_parents[] = {
 	{ .fw_name = "oscin" },
@@ -588,99 +545,13 @@ static const struct clk_parent_data c3_spicc_parents[] = {
 	{ .fw_name = "gp1" }
 };
 
-static struct clk_regmap c3_spicc_a_sel = {
-	.data = &(struct clk_regmap_mux_data) {
-		.offset = SPICC_CLK_CTRL,
-		.mask = 0x7,
-		.shift = 7,
-	},
-	.hw.init = &(struct clk_init_data) {
-		.name = "spicc_a_sel",
-		.ops = &clk_regmap_mux_ops,
-		.parent_data = c3_spicc_parents,
-		.num_parents = ARRAY_SIZE(c3_spicc_parents),
-	},
-};
-
-static struct clk_regmap c3_spicc_a_div = {
-	.data = &(struct clk_regmap_div_data) {
-		.offset = SPICC_CLK_CTRL,
-		.shift = 0,
-		.width = 6,
-	},
-	.hw.init = &(struct clk_init_data) {
-		.name = "spicc_a_div",
-		.ops = &clk_regmap_divider_ops,
-		.parent_hws = (const struct clk_hw *[]) {
-			&c3_spicc_a_sel.hw
-		},
-		.num_parents = 1,
-		.flags = CLK_SET_RATE_PARENT,
-	},
-};
-
-static struct clk_regmap c3_spicc_a = {
-	.data = &(struct clk_regmap_gate_data) {
-		.offset = SPICC_CLK_CTRL,
-		.bit_idx = 6,
-	},
-	.hw.init = &(struct clk_init_data) {
-		.name = "spicc_a",
-		.ops = &clk_regmap_gate_ops,
-		.parent_hws = (const struct clk_hw *[]) {
-			&c3_spicc_a_div.hw
-		},
-		.num_parents = 1,
-		.flags = CLK_SET_RATE_PARENT,
-	},
-};
-
-static struct clk_regmap c3_spicc_b_sel = {
-	.data = &(struct clk_regmap_mux_data) {
-		.offset = SPICC_CLK_CTRL,
-		.mask = 0x7,
-		.shift = 23,
-	},
-	.hw.init = &(struct clk_init_data) {
-		.name = "spicc_b_sel",
-		.ops = &clk_regmap_mux_ops,
-		.parent_data = c3_spicc_parents,
-		.num_parents = ARRAY_SIZE(c3_spicc_parents),
-	},
-};
-
-static struct clk_regmap c3_spicc_b_div = {
-	.data = &(struct clk_regmap_div_data) {
-		.offset = SPICC_CLK_CTRL,
-		.shift = 16,
-		.width = 6,
-	},
-	.hw.init = &(struct clk_init_data) {
-		.name = "spicc_b_div",
-		.ops = &clk_regmap_divider_ops,
-		.parent_hws = (const struct clk_hw *[]) {
-			&c3_spicc_b_sel.hw
-		},
-		.num_parents = 1,
-		.flags = CLK_SET_RATE_PARENT,
-	},
-};
+static C3_COMP_SEL(spicc_a, SPICC_CLK_CTRL, 7, 0x7, c3_spicc_parents);
+static C3_COMP_DIV(spicc_a, SPICC_CLK_CTRL, 0, 6);
+static C3_COMP_GATE(spicc_a, SPICC_CLK_CTRL,  6);
 
-static struct clk_regmap c3_spicc_b = {
-	.data = &(struct clk_regmap_gate_data) {
-		.offset = SPICC_CLK_CTRL,
-		.bit_idx = 22,
-	},
-	.hw.init = &(struct clk_init_data) {
-		.name = "spicc_b",
-		.ops = &clk_regmap_gate_ops,
-		.parent_hws = (const struct clk_hw *[]) {
-			&c3_spicc_b_div.hw
-		},
-		.num_parents = 1,
-		.flags = CLK_SET_RATE_PARENT,
-	},
-};
+static C3_COMP_SEL(spicc_b, SPICC_CLK_CTRL, 23, 0x7, c3_spicc_parents);
+static C3_COMP_DIV(spicc_b, SPICC_CLK_CTRL, 16, 6);
+static C3_COMP_GATE(spicc_b, SPICC_CLK_CTRL, 22);
 
 static const struct clk_parent_data c3_spifc_parents[] = {
 	{ .fw_name = "gp0" },
@@ -693,52 +564,9 @@ static const struct clk_parent_data c3_spifc_parents[] = {
 	{ .fw_name = "fdiv7" }
 };
 
-static struct clk_regmap c3_spifc_sel = {
-	.data = &(struct clk_regmap_mux_data) {
-		.offset = SPIFC_CLK_CTRL,
-		.mask = 0x7,
-		.shift = 9,
-	},
-	.hw.init = &(struct clk_init_data) {
-		.name = "spifc_sel",
-		.ops = &clk_regmap_mux_ops,
-		.parent_data = c3_spifc_parents,
-		.num_parents = ARRAY_SIZE(c3_spifc_parents),
-	},
-};
-
-static struct clk_regmap c3_spifc_div = {
-	.data = &(struct clk_regmap_div_data) {
-		.offset = SPIFC_CLK_CTRL,
-		.shift = 0,
-		.width = 7,
-	},
-	.hw.init = &(struct clk_init_data) {
-		.name = "spifc_div",
-		.ops = &clk_regmap_divider_ops,
-		.parent_hws = (const struct clk_hw *[]) {
-			&c3_spifc_sel.hw
-		},
-		.num_parents = 1,
-		.flags = CLK_SET_RATE_PARENT,
-	},
-};
-
-static struct clk_regmap c3_spifc = {
-	.data = &(struct clk_regmap_gate_data) {
-		.offset = SPIFC_CLK_CTRL,
-		.bit_idx = 8,
-	},
-	.hw.init = &(struct clk_init_data) {
-		.name = "spifc",
-		.ops = &clk_regmap_gate_ops,
-		.parent_hws = (const struct clk_hw *[]) {
-			&c3_spifc_div.hw
-		},
-		.num_parents = 1,
-		.flags = CLK_SET_RATE_PARENT,
-	},
-};
+static C3_COMP_SEL(spifc, SPIFC_CLK_CTRL, 9, 0x7, c3_spifc_parents);
+static C3_COMP_DIV(spifc, SPIFC_CLK_CTRL, 0, 7);
+static C3_COMP_GATE(spifc, SPIFC_CLK_CTRL,  8);
 
 static const struct clk_parent_data c3_sd_emmc_parents[] = {
 	{ .fw_name = "oscin" },
@@ -751,146 +579,17 @@ static const struct clk_parent_data c3_sd_emmc_parents[] = {
 	{ .fw_name = "gp0" }
 };
 
-static struct clk_regmap c3_sd_emmc_a_sel = {
-	.data = &(struct clk_regmap_mux_data) {
-		.offset = SD_EMMC_CLK_CTRL,
-		.mask = 0x7,
-		.shift = 9,
-	},
-	.hw.init = &(struct clk_init_data) {
-		.name = "sd_emmc_a_sel",
-		.ops = &clk_regmap_mux_ops,
-		.parent_data = c3_sd_emmc_parents,
-		.num_parents = ARRAY_SIZE(c3_sd_emmc_parents),
-	},
-};
-
-static struct clk_regmap c3_sd_emmc_a_div = {
-	.data = &(struct clk_regmap_div_data) {
-		.offset = SD_EMMC_CLK_CTRL,
-		.shift = 0,
-		.width = 7,
-	},
-	.hw.init = &(struct clk_init_data) {
-		.name = "sd_emmc_a_div",
-		.ops = &clk_regmap_divider_ops,
-		.parent_hws = (const struct clk_hw *[]) {
-			&c3_sd_emmc_a_sel.hw
-		},
-		.num_parents = 1,
-		.flags = CLK_SET_RATE_PARENT,
-	},
-};
-
-static struct clk_regmap c3_sd_emmc_a = {
-	.data = &(struct clk_regmap_gate_data) {
-		.offset = SD_EMMC_CLK_CTRL,
-		.bit_idx = 7,
-	},
-	.hw.init = &(struct clk_init_data) {
-		.name = "sd_emmc_a",
-		.ops = &clk_regmap_gate_ops,
-		.parent_hws = (const struct clk_hw *[]) {
-			&c3_sd_emmc_a_div.hw
-		},
-		.num_parents = 1,
-		.flags = CLK_SET_RATE_PARENT,
-	},
-};
-
-static struct clk_regmap c3_sd_emmc_b_sel = {
-	.data = &(struct clk_regmap_mux_data) {
-		.offset = SD_EMMC_CLK_CTRL,
-		.mask = 0x7,
-		.shift = 25,
-	},
-	.hw.init = &(struct clk_init_data) {
-		.name = "sd_emmc_b_sel",
-		.ops = &clk_regmap_mux_ops,
-		.parent_data = c3_sd_emmc_parents,
-		.num_parents = ARRAY_SIZE(c3_sd_emmc_parents),
-	},
-};
-
-static struct clk_regmap c3_sd_emmc_b_div = {
-	.data = &(struct clk_regmap_div_data) {
-		.offset = SD_EMMC_CLK_CTRL,
-		.shift = 16,
-		.width = 7,
-	},
-	.hw.init = &(struct clk_init_data) {
-		.name = "sd_emmc_b_div",
-		.ops = &clk_regmap_divider_ops,
-		.parent_hws = (const struct clk_hw *[]) {
-			&c3_sd_emmc_b_sel.hw
-		},
-		.num_parents = 1,
-		.flags = CLK_SET_RATE_PARENT,
-	},
-};
-
-static struct clk_regmap c3_sd_emmc_b = {
-	.data = &(struct clk_regmap_gate_data) {
-		.offset = SD_EMMC_CLK_CTRL,
-		.bit_idx = 23,
-	},
-	.hw.init = &(struct clk_init_data) {
-		.name = "sd_emmc_b",
-		.ops = &clk_regmap_gate_ops,
-		.parent_hws = (const struct clk_hw *[]) {
-			&c3_sd_emmc_b_div.hw
-		},
-		.num_parents = 1,
-		.flags = CLK_SET_RATE_PARENT,
-	},
-};
-
-static struct clk_regmap c3_sd_emmc_c_sel = {
-	.data = &(struct clk_regmap_mux_data) {
-		.offset = NAND_CLK_CTRL,
-		.mask = 0x7,
-		.shift = 9,
-	},
-	.hw.init = &(struct clk_init_data) {
-		.name = "sd_emmc_c_sel",
-		.ops = &clk_regmap_mux_ops,
-		.parent_data = c3_sd_emmc_parents,
-		.num_parents = ARRAY_SIZE(c3_sd_emmc_parents),
-	},
-};
+static C3_COMP_SEL(sd_emmc_a, SD_EMMC_CLK_CTRL, 9, 0x7, c3_sd_emmc_parents);
+static C3_COMP_DIV(sd_emmc_a, SD_EMMC_CLK_CTRL, 0, 7);
+static C3_COMP_GATE(sd_emmc_a, SD_EMMC_CLK_CTRL,  7);
 
-static struct clk_regmap c3_sd_emmc_c_div = {
-	.data = &(struct clk_regmap_div_data) {
-		.offset = NAND_CLK_CTRL,
-		.shift = 0,
-		.width = 7,
-	},
-	.hw.init = &(struct clk_init_data) {
-		.name = "sd_emmc_c_div",
-		.ops = &clk_regmap_divider_ops,
-		.parent_hws = (const struct clk_hw *[]) {
-			&c3_sd_emmc_c_sel.hw
-		},
-		.num_parents = 1,
-		.flags = CLK_SET_RATE_PARENT,
-	},
-};
+static C3_COMP_SEL(sd_emmc_b, SD_EMMC_CLK_CTRL, 25, 0x7, c3_sd_emmc_parents);
+static C3_COMP_DIV(sd_emmc_b, SD_EMMC_CLK_CTRL, 16, 7);
+static C3_COMP_GATE(sd_emmc_b, SD_EMMC_CLK_CTRL, 23);
 
-static struct clk_regmap c3_sd_emmc_c = {
-	.data = &(struct clk_regmap_gate_data) {
-		.offset = NAND_CLK_CTRL,
-		.bit_idx = 7,
-	},
-	.hw.init = &(struct clk_init_data) {
-		.name = "sd_emmc_c",
-		.ops = &clk_regmap_gate_ops,
-		.parent_hws = (const struct clk_hw *[]) {
-			&c3_sd_emmc_c_div.hw
-		},
-		.num_parents = 1,
-		.flags = CLK_SET_RATE_PARENT,
-	},
-};
+static C3_COMP_SEL(sd_emmc_c, NAND_CLK_CTRL, 9, 0x7, c3_sd_emmc_parents);
+static C3_COMP_DIV(sd_emmc_c, NAND_CLK_CTRL, 0, 7);
+static C3_COMP_GATE(sd_emmc_c, NAND_CLK_CTRL, 7);
 
 static struct clk_regmap c3_ts_div = {
 	.data = &(struct clk_regmap_div_data) {
@@ -996,52 +695,9 @@ static const struct clk_parent_data c3_mipi_dsi_meas_parents[] = {
 	{ .fw_name = "fdiv7" }
 };
 
-static struct clk_regmap c3_mipi_dsi_meas_sel = {
-	.data = &(struct clk_regmap_mux_data) {
-		.offset = VDIN_MEAS_CLK_CTRL,
-		.mask = 0x7,
-		.shift = 21,
-	},
-	.hw.init = &(struct clk_init_data) {
-		.name = "mipi_dsi_meas_sel",
-		.ops = &clk_regmap_mux_ops,
-		.parent_data = c3_mipi_dsi_meas_parents,
-		.num_parents = ARRAY_SIZE(c3_mipi_dsi_meas_parents),
-	},
-};
-
-static struct clk_regmap c3_mipi_dsi_meas_div = {
-	.data = &(struct clk_regmap_div_data) {
-		.offset = VDIN_MEAS_CLK_CTRL,
-		.shift = 12,
-		.width = 7,
-	},
-	.hw.init = &(struct clk_init_data) {
-		.name = "mipi_dsi_meas_div",
-		.ops = &clk_regmap_divider_ops,
-		.parent_hws = (const struct clk_hw *[]) {
-			&c3_mipi_dsi_meas_sel.hw
-		},
-		.num_parents = 1,
-		.flags = CLK_SET_RATE_PARENT,
-	},
-};
-
-static struct clk_regmap c3_mipi_dsi_meas = {
-	.data = &(struct clk_regmap_gate_data) {
-		.offset = VDIN_MEAS_CLK_CTRL,
-		.bit_idx = 20,
-	},
-	.hw.init = &(struct clk_init_data) {
-		.name = "mipi_dsi_meas",
-		.ops = &clk_regmap_gate_ops,
-		.parent_hws = (const struct clk_hw *[]) {
-			&c3_mipi_dsi_meas_div.hw
-		},
-		.num_parents = 1,
-		.flags = CLK_SET_RATE_PARENT,
-	},
-};
+static C3_COMP_SEL(mipi_dsi_meas, VDIN_MEAS_CLK_CTRL, 21, 0x7, c3_mipi_dsi_meas_parents);
+static C3_COMP_DIV(mipi_dsi_meas, VDIN_MEAS_CLK_CTRL, 12, 7);
+static C3_COMP_GATE(mipi_dsi_meas, VDIN_MEAS_CLK_CTRL, 20);
 
 static const struct clk_parent_data c3_dsi_phy_parents[] = {
 	{ .fw_name = "gp1" },
@@ -1054,52 +710,9 @@ static const struct clk_parent_data c3_dsi_phy_parents[] = {
 	{ .fw_name = "fdiv7" }
 };
 
-static struct clk_regmap c3_dsi_phy_sel = {
-	.data = &(struct clk_regmap_mux_data) {
-		.offset = MIPIDSI_PHY_CLK_CTRL,
-		.mask = 0x7,
-		.shift = 12,
-	},
-	.hw.init = &(struct clk_init_data) {
-		.name = "dsi_phy_sel",
-		.ops = &clk_regmap_mux_ops,
-		.parent_data = c3_dsi_phy_parents,
-		.num_parents = ARRAY_SIZE(c3_dsi_phy_parents),
-	},
-};
-
-static struct clk_regmap c3_dsi_phy_div = {
-	.data = &(struct clk_regmap_div_data) {
-		.offset = MIPIDSI_PHY_CLK_CTRL,
-		.shift = 0,
-		.width = 7,
-	},
-	.hw.init = &(struct clk_init_data) {
-		.name = "dsi_phy_div",
-		.ops = &clk_regmap_divider_ops,
-		.parent_hws = (const struct clk_hw *[]) {
-			&c3_dsi_phy_sel.hw
-		},
-		.num_parents = 1,
-		.flags = CLK_SET_RATE_PARENT,
-	},
-};
-
-static struct clk_regmap c3_dsi_phy = {
-	.data = &(struct clk_regmap_gate_data) {
-		.offset = MIPIDSI_PHY_CLK_CTRL,
-		.bit_idx = 8,
-	},
-	.hw.init = &(struct clk_init_data) {
-		.name = "dsi_phy",
-		.ops = &clk_regmap_gate_ops,
-		.parent_hws = (const struct clk_hw *[]) {
-			&c3_dsi_phy_div.hw
-		},
-		.num_parents = 1,
-		.flags = CLK_SET_RATE_PARENT,
-	},
-};
+static C3_COMP_SEL(dsi_phy, MIPIDSI_PHY_CLK_CTRL, 12, 0x7, c3_dsi_phy_parents);
+static C3_COMP_DIV(dsi_phy, MIPIDSI_PHY_CLK_CTRL, 0, 7);
+static C3_COMP_GATE(dsi_phy, MIPIDSI_PHY_CLK_CTRL, 8);
 
 static const struct clk_parent_data c3_vout_mclk_parents[] = {
 	{ .fw_name = "fdiv2p5" },
@@ -1112,52 +725,9 @@ static const struct clk_parent_data c3_vout_mclk_parents[] = {
 	{ .fw_name = "fdiv7" }
 };
 
-static struct clk_regmap c3_vout_mclk_sel = {
-	.data = &(struct clk_regmap_mux_data) {
-		.offset = VOUTENC_CLK_CTRL,
-		.mask = 0x7,
-		.shift = 9,
-	},
-	.hw.init = &(struct clk_init_data) {
-		.name = "vout_mclk_sel",
-		.ops = &clk_regmap_mux_ops,
-		.parent_data = c3_vout_mclk_parents,
-		.num_parents = ARRAY_SIZE(c3_vout_mclk_parents),
-	},
-};
-
-static struct clk_regmap c3_vout_mclk_div = {
-	.data = &(struct clk_regmap_div_data) {
-		.offset = VOUTENC_CLK_CTRL,
-		.shift = 0,
-		.width = 7,
-	},
-	.hw.init = &(struct clk_init_data) {
-		.name = "vout_mclk_div",
-		.ops = &clk_regmap_divider_ops,
-		.parent_hws = (const struct clk_hw *[]) {
-			&c3_vout_mclk_sel.hw
-		},
-		.num_parents = 1,
-		.flags = CLK_SET_RATE_PARENT,
-	},
-};
-
-static struct clk_regmap c3_vout_mclk = {
-	.data = &(struct clk_regmap_gate_data) {
-		.offset = VOUTENC_CLK_CTRL,
-		.bit_idx = 8,
-	},
-	.hw.init = &(struct clk_init_data) {
-		.name = "vout_mclk",
-		.ops = &clk_regmap_gate_ops,
-		.parent_hws = (const struct clk_hw *[]) {
-			&c3_vout_mclk_div.hw
-		},
-		.num_parents = 1,
-		.flags = CLK_SET_RATE_PARENT,
-	},
-};
+static C3_COMP_SEL(vout_mclk, VOUTENC_CLK_CTRL, 9, 0x7, c3_vout_mclk_parents);
+static C3_COMP_DIV(vout_mclk, VOUTENC_CLK_CTRL, 0, 7);
+static C3_COMP_GATE(vout_mclk, VOUTENC_CLK_CTRL, 8);
 
 static const struct clk_parent_data c3_vout_enc_parents[] = {
 	{ .fw_name = "gp1" },
@@ -1170,52 +740,9 @@ static const struct clk_parent_data c3_vout_enc_parents[] = {
 	{ .fw_name = "fdiv7" }
 };
 
-static struct clk_regmap c3_vout_enc_sel = {
-	.data = &(struct clk_regmap_mux_data) {
-		.offset = VOUTENC_CLK_CTRL,
-		.mask = 0x7,
-		.shift = 25,
-	},
-	.hw.init = &(struct clk_init_data) {
-		.name = "vout_enc_sel",
-		.ops = &clk_regmap_mux_ops,
-		.parent_data = c3_vout_enc_parents,
-		.num_parents = ARRAY_SIZE(c3_vout_enc_parents),
-	},
-};
-
-static struct clk_regmap c3_vout_enc_div = {
-	.data = &(struct clk_regmap_div_data) {
-		.offset = VOUTENC_CLK_CTRL,
-		.shift = 16,
-		.width = 7,
-	},
-	.hw.init = &(struct clk_init_data) {
-		.name = "vout_enc_div",
-		.ops = &clk_regmap_divider_ops,
-		.parent_hws = (const struct clk_hw *[]) {
-			&c3_vout_enc_sel.hw
-		},
-		.num_parents = 1,
-		.flags = CLK_SET_RATE_PARENT,
-	},
-};
-
-static struct clk_regmap c3_vout_enc = {
-	.data = &(struct clk_regmap_gate_data) {
-		.offset = VOUTENC_CLK_CTRL,
-		.bit_idx = 24,
-	},
-	.hw.init = &(struct clk_init_data) {
-		.name = "vout_enc",
-		.ops = &clk_regmap_gate_ops,
-		.parent_hws = (const struct clk_hw *[]) {
-			&c3_vout_enc_div.hw
-		},
-		.num_parents = 1,
-		.flags = CLK_SET_RATE_PARENT,
-	},
-};
+static C3_COMP_SEL(vout_enc, VOUTENC_CLK_CTRL, 25, 0x7, c3_vout_enc_parents);
+static C3_COMP_DIV(vout_enc, VOUTENC_CLK_CTRL, 16, 7);
+static C3_COMP_GATE(vout_enc, VOUTENC_CLK_CTRL, 24);
 
 static const struct clk_parent_data c3_hcodec_pre_parents[] = {
 	{ .fw_name = "fdiv2p5" },
@@ -1228,99 +755,13 @@ static const struct clk_parent_data c3_hcodec_pre_parents[] = {
 	{ .fw_name = "oscin" }
 };
 
-static struct clk_regmap c3_hcodec_0_sel = {
-	.data = &(struct clk_regmap_mux_data) {
-		.offset = VDEC_CLK_CTRL,
-		.mask = 0x7,
-		.shift = 9,
-	},
-	.hw.init = &(struct clk_init_data) {
-		.name = "hcodec_0_sel",
-		.ops = &clk_regmap_mux_ops,
-		.parent_data = c3_hcodec_pre_parents,
-		.num_parents = ARRAY_SIZE(c3_hcodec_pre_parents),
-	},
-};
+static C3_COMP_SEL(hcodec_0,  VDEC_CLK_CTRL, 9, 0x7, c3_hcodec_pre_parents);
+static C3_COMP_DIV(hcodec_0,  VDEC_CLK_CTRL, 0, 7);
+static C3_COMP_GATE(hcodec_0,  VDEC_CLK_CTRL, 8);
 
-static struct clk_regmap c3_hcodec_0_div = {
-	.data = &(struct clk_regmap_div_data) {
-		.offset = VDEC_CLK_CTRL,
-		.shift = 0,
-		.width = 7,
-	},
-	.hw.init = &(struct clk_init_data) {
-		.name = "hcodec_0_div",
-		.ops = &clk_regmap_divider_ops,
-		.parent_hws = (const struct clk_hw *[]) {
-			&c3_hcodec_0_sel.hw
-		},
-		.num_parents = 1,
-		.flags = CLK_SET_RATE_PARENT,
-	},
-};
-
-static struct clk_regmap c3_hcodec_0 = {
-	.data = &(struct clk_regmap_gate_data) {
-		.offset = VDEC_CLK_CTRL,
-		.bit_idx = 8,
-	},
-	.hw.init = &(struct clk_init_data) {
-		.name = "hcodec_0",
-		.ops = &clk_regmap_gate_ops,
-		.parent_hws = (const struct clk_hw *[]) {
-			&c3_hcodec_0_div.hw
-		},
-		.num_parents = 1,
-		.flags = CLK_SET_RATE_PARENT,
-	},
-};
-
-static struct clk_regmap c3_hcodec_1_sel = {
-	.data = &(struct clk_regmap_mux_data) {
-		.offset = VDEC3_CLK_CTRL,
-		.mask = 0x7,
-		.shift = 9,
-	},
-	.hw.init = &(struct clk_init_data) {
-		.name = "hcodec_1_sel",
-		.ops = &clk_regmap_mux_ops,
-		.parent_data = c3_hcodec_pre_parents,
-		.num_parents = ARRAY_SIZE(c3_hcodec_pre_parents),
-	},
-};
-
-static struct clk_regmap c3_hcodec_1_div = {
-	.data = &(struct clk_regmap_div_data) {
-		.offset = VDEC3_CLK_CTRL,
-		.shift = 0,
-		.width = 7,
-	},
-	.hw.init = &(struct clk_init_data) {
-		.name = "hcodec_1_div",
-		.ops = &clk_regmap_divider_ops,
-		.parent_hws = (const struct clk_hw *[]) {
-			&c3_hcodec_1_sel.hw
-		},
-		.num_parents = 1,
-		.flags = CLK_SET_RATE_PARENT,
-	},
-};
-
-static struct clk_regmap c3_hcodec_1 = {
-	.data = &(struct clk_regmap_gate_data) {
-		.offset = VDEC3_CLK_CTRL,
-		.bit_idx = 8,
-	},
-	.hw.init = &(struct clk_init_data) {
-		.name = "hcodec_1",
-		.ops = &clk_regmap_gate_ops,
-		.parent_hws = (const struct clk_hw *[]) {
-			&c3_hcodec_1_div.hw
-		},
-		.num_parents = 1,
-		.flags = CLK_SET_RATE_PARENT,
-	},
-};
+static C3_COMP_SEL(hcodec_1, VDEC3_CLK_CTRL, 9, 0x7, c3_hcodec_pre_parents);
+static C3_COMP_DIV(hcodec_1, VDEC3_CLK_CTRL, 0, 7);
+static C3_COMP_GATE(hcodec_1, VDEC3_CLK_CTRL, 8);
 
 static const struct clk_parent_data c3_hcodec_parents[] = {
 	{ .hw = &c3_hcodec_0.hw },
@@ -1353,99 +794,13 @@ static const struct clk_parent_data c3_vc9000e_parents[] = {
 	{ .fw_name = "gp0" }
 };
 
-static struct clk_regmap c3_vc9000e_aclk_sel = {
-	.data = &(struct clk_regmap_mux_data) {
-		.offset = VC9000E_CLK_CTRL,
-		.mask = 0x7,
-		.shift = 9,
-	},
-	.hw.init = &(struct clk_init_data) {
-		.name = "vc9000e_aclk_sel",
-		.ops = &clk_regmap_mux_ops,
-		.parent_data = c3_vc9000e_parents,
-		.num_parents = ARRAY_SIZE(c3_vc9000e_parents),
-	},
-};
-
-static struct clk_regmap c3_vc9000e_aclk_div = {
-	.data = &(struct clk_regmap_div_data) {
-		.offset = VC9000E_CLK_CTRL,
-		.shift = 0,
-		.width = 7,
-	},
-	.hw.init = &(struct clk_init_data) {
-		.name = "vc9000e_aclk_div",
-		.ops = &clk_regmap_divider_ops,
-		.parent_hws = (const struct clk_hw *[]) {
-			&c3_vc9000e_aclk_sel.hw
-		},
-		.num_parents = 1,
-		.flags = CLK_SET_RATE_PARENT,
-	},
-};
-
-static struct clk_regmap c3_vc9000e_aclk = {
-	.data = &(struct clk_regmap_gate_data) {
-		.offset = VC9000E_CLK_CTRL,
-		.bit_idx = 8,
-	},
-	.hw.init = &(struct clk_init_data) {
-		.name = "vc9000e_aclk",
-		.ops = &clk_regmap_gate_ops,
-		.parent_hws = (const struct clk_hw *[]) {
-			&c3_vc9000e_aclk_div.hw
-		},
-		.num_parents = 1,
-		.flags = CLK_SET_RATE_PARENT,
-	},
-};
-
-static struct clk_regmap c3_vc9000e_core_sel = {
-	.data = &(struct clk_regmap_mux_data) {
-		.offset = VC9000E_CLK_CTRL,
-		.mask = 0x7,
-		.shift = 25,
-	},
-	.hw.init = &(struct clk_init_data) {
-		.name = "vc9000e_core_sel",
-		.ops = &clk_regmap_mux_ops,
-		.parent_data = c3_vc9000e_parents,
-		.num_parents = ARRAY_SIZE(c3_vc9000e_parents),
-	},
-};
-
-static struct clk_regmap c3_vc9000e_core_div = {
-	.data = &(struct clk_regmap_div_data) {
-		.offset = VC9000E_CLK_CTRL,
-		.shift = 16,
-		.width = 7,
-	},
-	.hw.init = &(struct clk_init_data) {
-		.name = "vc9000e_core_div",
-		.ops = &clk_regmap_divider_ops,
-		.parent_hws = (const struct clk_hw *[]) {
-			&c3_vc9000e_core_sel.hw
-		},
-		.num_parents = 1,
-		.flags = CLK_SET_RATE_PARENT,
-	},
-};
+static C3_COMP_SEL(vc9000e_aclk, VC9000E_CLK_CTRL, 9, 0x7, c3_vc9000e_parents);
+static C3_COMP_DIV(vc9000e_aclk, VC9000E_CLK_CTRL, 0, 7);
+static C3_COMP_GATE(vc9000e_aclk, VC9000E_CLK_CTRL, 8);
 
-static struct clk_regmap c3_vc9000e_core = {
-	.data = &(struct clk_regmap_gate_data) {
-		.offset = VC9000E_CLK_CTRL,
-		.bit_idx = 24,
-	},
-	.hw.init = &(struct clk_init_data) {
-		.name = "vc9000e_core",
-		.ops = &clk_regmap_gate_ops,
-		.parent_hws = (const struct clk_hw *[]) {
-			&c3_vc9000e_core_div.hw
-		},
-		.num_parents = 1,
-		.flags = CLK_SET_RATE_PARENT,
-	},
-};
+static C3_COMP_SEL(vc9000e_core, VC9000E_CLK_CTRL, 25, 0x7, c3_vc9000e_parents);
+static C3_COMP_DIV(vc9000e_core, VC9000E_CLK_CTRL, 16, 7);
+static C3_COMP_GATE(vc9000e_core, VC9000E_CLK_CTRL, 24);
 
 static const struct clk_parent_data c3_csi_phy_parents[] = {
 	{ .fw_name = "fdiv2p5" },
@@ -1458,52 +813,9 @@ static const struct clk_parent_data c3_csi_phy_parents[] = {
 	{ .fw_name = "oscin" }
 };
 
-static struct clk_regmap c3_csi_phy0_sel = {
-	.data = &(struct clk_regmap_mux_data) {
-		.offset = ISP0_CLK_CTRL,
-		.mask = 0x7,
-		.shift = 25,
-	},
-	.hw.init = &(struct clk_init_data) {
-		.name = "csi_phy0_sel",
-		.ops = &clk_regmap_mux_ops,
-		.parent_data = c3_csi_phy_parents,
-		.num_parents = ARRAY_SIZE(c3_csi_phy_parents),
-	},
-};
-
-static struct clk_regmap c3_csi_phy0_div = {
-	.data = &(struct clk_regmap_div_data) {
-		.offset = ISP0_CLK_CTRL,
-		.shift = 16,
-		.width = 7,
-	},
-	.hw.init = &(struct clk_init_data) {
-		.name = "csi_phy0_div",
-		.ops = &clk_regmap_divider_ops,
-		.parent_hws = (const struct clk_hw *[]) {
-			&c3_csi_phy0_sel.hw
-		},
-		.num_parents = 1,
-		.flags = CLK_SET_RATE_PARENT,
-	},
-};
-
-static struct clk_regmap c3_csi_phy0 = {
-	.data = &(struct clk_regmap_gate_data) {
-		.offset = ISP0_CLK_CTRL,
-		.bit_idx = 24,
-	},
-	.hw.init = &(struct clk_init_data) {
-		.name = "csi_phy0",
-		.ops = &clk_regmap_gate_ops,
-		.parent_hws = (const struct clk_hw *[]) {
-			&c3_csi_phy0_div.hw
-		},
-		.num_parents = 1,
-		.flags = CLK_SET_RATE_PARENT,
-	},
-};
+static C3_COMP_SEL(csi_phy0, ISP0_CLK_CTRL, 25, 0x7, c3_csi_phy_parents);
+static C3_COMP_DIV(csi_phy0, ISP0_CLK_CTRL, 16, 7);
+static C3_COMP_GATE(csi_phy0, ISP0_CLK_CTRL, 24);
 
 static const struct clk_parent_data c3_dewarpa_parents[] = {
 	{ .fw_name = "fdiv2p5" },
@@ -1516,52 +828,9 @@ static const struct clk_parent_data c3_dewarpa_parents[] = {
 	{ .fw_name = "fdiv7" }
 };
 
-static struct clk_regmap c3_dewarpa_sel = {
-	.data = &(struct clk_regmap_mux_data) {
-		.offset = DEWARPA_CLK_CTRL,
-		.mask = 0x7,
-		.shift = 9,
-	},
-	.hw.init = &(struct clk_init_data) {
-		.name = "dewarpa_sel",
-		.ops = &clk_regmap_mux_ops,
-		.parent_data = c3_dewarpa_parents,
-		.num_parents = ARRAY_SIZE(c3_dewarpa_parents),
-	},
-};
-
-static struct clk_regmap c3_dewarpa_div = {
-	.data = &(struct clk_regmap_div_data) {
-		.offset = DEWARPA_CLK_CTRL,
-		.shift = 0,
-		.width = 7,
-	},
-	.hw.init = &(struct clk_init_data) {
-		.name = "dewarpa_div",
-		.ops = &clk_regmap_divider_ops,
-		.parent_hws = (const struct clk_hw *[]) {
-			&c3_dewarpa_sel.hw
-		},
-		.num_parents = 1,
-		.flags = CLK_SET_RATE_PARENT,
-	},
-};
-
-static struct clk_regmap c3_dewarpa = {
-	.data = &(struct clk_regmap_gate_data) {
-		.offset = DEWARPA_CLK_CTRL,
-		.bit_idx = 8,
-	},
-	.hw.init = &(struct clk_init_data) {
-		.name = "dewarpa",
-		.ops = &clk_regmap_gate_ops,
-		.parent_hws = (const struct clk_hw *[]) {
-			&c3_dewarpa_div.hw
-		},
-		.num_parents = 1,
-		.flags = CLK_SET_RATE_PARENT,
-	},
-};
+static C3_COMP_SEL(dewarpa, DEWARPA_CLK_CTRL, 9, 0x7, c3_dewarpa_parents);
+static C3_COMP_DIV(dewarpa, DEWARPA_CLK_CTRL, 0, 7);
+static C3_COMP_GATE(dewarpa, DEWARPA_CLK_CTRL, 8);
 
 static const struct clk_parent_data c3_isp_parents[] = {
 	{ .fw_name = "fdiv2p5" },
@@ -1574,52 +843,9 @@ static const struct clk_parent_data c3_isp_parents[] = {
 	{ .fw_name = "oscin" }
 };
 
-static struct clk_regmap c3_isp0_sel = {
-	.data = &(struct clk_regmap_mux_data) {
-		.offset = ISP0_CLK_CTRL,
-		.mask = 0x7,
-		.shift = 9,
-	},
-	.hw.init = &(struct clk_init_data) {
-		.name = "isp0_sel",
-		.ops = &clk_regmap_mux_ops,
-		.parent_data = c3_isp_parents,
-		.num_parents = ARRAY_SIZE(c3_isp_parents),
-	},
-};
-
-static struct clk_regmap c3_isp0_div = {
-	.data = &(struct clk_regmap_div_data) {
-		.offset = ISP0_CLK_CTRL,
-		.shift = 0,
-		.width = 7,
-	},
-	.hw.init = &(struct clk_init_data) {
-		.name = "isp0_div",
-		.ops = &clk_regmap_divider_ops,
-		.parent_hws = (const struct clk_hw *[]) {
-			&c3_isp0_sel.hw
-		},
-		.num_parents = 1,
-		.flags = CLK_SET_RATE_PARENT,
-	},
-};
-
-static struct clk_regmap c3_isp0 = {
-	.data = &(struct clk_regmap_gate_data) {
-		.offset = ISP0_CLK_CTRL,
-		.bit_idx = 8,
-	},
-	.hw.init = &(struct clk_init_data) {
-		.name = "isp0",
-		.ops = &clk_regmap_gate_ops,
-		.parent_hws = (const struct clk_hw *[]) {
-			&c3_isp0_div.hw
-		},
-		.num_parents = 1,
-		.flags = CLK_SET_RATE_PARENT,
-	},
-};
+static C3_COMP_SEL(isp0, ISP0_CLK_CTRL, 9, 0x7, c3_isp_parents);
+static C3_COMP_DIV(isp0, ISP0_CLK_CTRL, 0, 7);
+static C3_COMP_GATE(isp0, ISP0_CLK_CTRL, 8);
 
 static const struct clk_parent_data c3_nna_core_parents[] = {
 	{ .fw_name = "oscin" },
@@ -1632,52 +858,9 @@ static const struct clk_parent_data c3_nna_core_parents[] = {
 	{ .fw_name = "hifi" }
 };
 
-static struct clk_regmap c3_nna_core_sel = {
-	.data = &(struct clk_regmap_mux_data) {
-		.offset = NNA_CLK_CTRL,
-		.mask = 0x7,
-		.shift = 9,
-	},
-	.hw.init = &(struct clk_init_data) {
-		.name = "nna_core_sel",
-		.ops = &clk_regmap_mux_ops,
-		.parent_data = c3_nna_core_parents,
-		.num_parents = ARRAY_SIZE(c3_nna_core_parents),
-	},
-};
-
-static struct clk_regmap c3_nna_core_div = {
-	.data = &(struct clk_regmap_div_data) {
-		.offset = NNA_CLK_CTRL,
-		.shift = 0,
-		.width = 7,
-	},
-	.hw.init = &(struct clk_init_data) {
-		.name = "nna_core_div",
-		.ops = &clk_regmap_divider_ops,
-		.parent_hws = (const struct clk_hw *[]) {
-			&c3_nna_core_sel.hw
-		},
-		.num_parents = 1,
-		.flags = CLK_SET_RATE_PARENT,
-	},
-};
-
-static struct clk_regmap c3_nna_core = {
-	.data = &(struct clk_regmap_gate_data) {
-		.offset = NNA_CLK_CTRL,
-		.bit_idx = 8,
-	},
-	.hw.init = &(struct clk_init_data) {
-		.name = "nna_core",
-		.ops = &clk_regmap_gate_ops,
-		.parent_hws = (const struct clk_hw *[]) {
-			&c3_nna_core_div.hw
-		},
-		.num_parents = 1,
-		.flags = CLK_SET_RATE_PARENT,
-	},
-};
+static C3_COMP_SEL(nna_core, NNA_CLK_CTRL, 9, 0x7, c3_nna_core_parents);
+static C3_COMP_DIV(nna_core, NNA_CLK_CTRL, 0, 7);
+static C3_COMP_GATE(nna_core, NNA_CLK_CTRL, 8);
 
 static const struct clk_parent_data c3_ge2d_parents[] = {
 	{ .fw_name = "oscin" },
@@ -1690,52 +873,9 @@ static const struct clk_parent_data c3_ge2d_parents[] = {
 	{ .hw = &c3_rtc_clk.hw }
 };
 
-static struct clk_regmap c3_ge2d_sel = {
-	.data = &(struct clk_regmap_mux_data) {
-		.offset = GE2D_CLK_CTRL,
-		.mask = 0x7,
-		.shift = 9,
-	},
-	.hw.init = &(struct clk_init_data) {
-		.name = "ge2d_sel",
-		.ops = &clk_regmap_mux_ops,
-		.parent_data = c3_ge2d_parents,
-		.num_parents = ARRAY_SIZE(c3_ge2d_parents),
-	},
-};
-
-static struct clk_regmap c3_ge2d_div = {
-	.data = &(struct clk_regmap_div_data) {
-		.offset = GE2D_CLK_CTRL,
-		.shift = 0,
-		.width = 7,
-	},
-	.hw.init = &(struct clk_init_data) {
-		.name = "ge2d_div",
-		.ops = &clk_regmap_divider_ops,
-		.parent_hws = (const struct clk_hw *[]) {
-			&c3_ge2d_sel.hw
-		},
-		.num_parents = 1,
-		.flags = CLK_SET_RATE_PARENT,
-	},
-};
-
-static struct clk_regmap c3_ge2d = {
-	.data = &(struct clk_regmap_gate_data) {
-		.offset = GE2D_CLK_CTRL,
-		.bit_idx = 8,
-	},
-	.hw.init = &(struct clk_init_data) {
-		.name = "ge2d",
-		.ops = &clk_regmap_gate_ops,
-		.parent_hws = (const struct clk_hw *[]) {
-			&c3_ge2d_div.hw
-		},
-		.num_parents = 1,
-		.flags = CLK_SET_RATE_PARENT,
-	},
-};
+static C3_COMP_SEL(ge2d, GE2D_CLK_CTRL, 9, 0x7, c3_ge2d_parents);
+static C3_COMP_DIV(ge2d, GE2D_CLK_CTRL, 0, 7);
+static C3_COMP_GATE(ge2d, GE2D_CLK_CTRL, 8);
 
 static const struct clk_parent_data c3_vapb_parents[] = {
 	{ .fw_name = "fdiv2p5" },
@@ -1748,52 +888,9 @@ static const struct clk_parent_data c3_vapb_parents[] = {
 	{ .fw_name = "oscin" },
 };
 
-static struct clk_regmap c3_vapb_sel = {
-	.data = &(struct clk_regmap_mux_data) {
-		.offset = VAPB_CLK_CTRL,
-		.mask = 0x7,
-		.shift = 9,
-	},
-	.hw.init = &(struct clk_init_data) {
-		.name = "vapb_sel",
-		.ops = &clk_regmap_mux_ops,
-		.parent_data = c3_vapb_parents,
-		.num_parents = ARRAY_SIZE(c3_vapb_parents),
-	},
-};
-
-static struct clk_regmap c3_vapb_div = {
-	.data = &(struct clk_regmap_div_data) {
-		.offset = VAPB_CLK_CTRL,
-		.shift = 0,
-		.width = 7,
-	},
-	.hw.init = &(struct clk_init_data) {
-		.name = "vapb_div",
-		.ops = &clk_regmap_divider_ops,
-		.parent_hws = (const struct clk_hw *[]) {
-			&c3_vapb_sel.hw
-		},
-		.num_parents = 1,
-		.flags = CLK_SET_RATE_PARENT,
-	},
-};
-
-static struct clk_regmap c3_vapb = {
-	.data = &(struct clk_regmap_gate_data) {
-		.offset = VAPB_CLK_CTRL,
-		.bit_idx = 8,
-	},
-	.hw.init = &(struct clk_init_data) {
-		.name = "vapb",
-		.ops = &clk_regmap_gate_ops,
-		.parent_hws = (const struct clk_hw *[]) {
-			&c3_vapb_div.hw
-		},
-		.num_parents = 1,
-		.flags = CLK_SET_RATE_PARENT,
-	},
-};
+static C3_COMP_SEL(vapb, VAPB_CLK_CTRL, 9, 0x7, c3_vapb_parents);
+static C3_COMP_DIV(vapb, VAPB_CLK_CTRL, 0, 7);
+static C3_COMP_GATE(vapb, VAPB_CLK_CTRL, 8);
 
 static struct clk_hw *c3_peripherals_hw_clks[] = {
 	[CLKID_RTC_XTAL_CLKIN]		= &c3_rtc_xtal_clkin.hw,

-- 
2.47.2


