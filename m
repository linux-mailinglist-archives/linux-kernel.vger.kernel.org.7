Return-Path: <linux-kernel+bounces-784963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38BFEB343EE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 16:32:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 446277AFD01
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 14:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 195C5307AF9;
	Mon, 25 Aug 2025 14:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Dn+wcVFP"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B639E303CBF
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 14:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756132039; cv=none; b=ENdDYz8UGHBp5fld+FsDmpKM4dYRyAtAhH4CdYpcr6e0FRDAG7tNTDYxgQr+Pvi08tH8egGjg/rNtsISxjEh/yRDhEb3fgfxRz4eyfQGrQLwLUJdku3WlmCHm7i8IC2rI6MkFJutExZAEWC3okBxXUsU+42Gj7Q68saUqvIyXJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756132039; c=relaxed/simple;
	bh=ssDaR4wz9jG+IVUW3bzaW/s+xN9zK8sGhakg0LDPY+Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XzaCTuijL74ggK1fAIGhpg8HFcxDx4FQGUnWBDOdNu06qZH9vN7EccJSD0qoQ2TMCHl5SQzmTXIiqlYW+y4WmIrOVOvFH6YUowT/KEqlIY1+TOynvbmKaAIu7SwJvCK9He6AcfeaMXXAJSjVcDcGY2TbeS7Qge6zXGX8S9bxEII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Dn+wcVFP; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-45a1b0bde14so24075415e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 07:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1756132033; x=1756736833; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NZFizNzZeDwxlG4/SOUoWjAfRTsGu/AR5Ui24dmicOw=;
        b=Dn+wcVFP/ZbbSXQlU1lU/pI4gkH4miaemZqAvEvmvVb9JifUYvI4iVgqmvC75NPG+P
         ZIGUbVctD/Mc0+GTVfu9o0KkzrWMJw6rMvT+HYnRarjhvVjBtRTftgnGWLQR5gNjUmcK
         hIyPvxHah7UtKszZWKaW6HwfAply8IImpmwr7k+EiRv55sPvJ7m9zKjhCgimKTe5Am8A
         pANPggrynbQVWpWNNQ5Rb9FTRyHWXYSwG7y/rtQfb3sXU+kLIg2DXHGp+izSp0lo0LfE
         zV6Mb8fB94v7S6VQWY3PJIwZwmKusm9bZQyTqMSCCeJc6tZwjBbxFIqpx74EEyGjum9S
         LuYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756132033; x=1756736833;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NZFizNzZeDwxlG4/SOUoWjAfRTsGu/AR5Ui24dmicOw=;
        b=K5qCWVL63Sp8Ycn9fvjk71N3l9BovpeGUlcI1tGAhm7ZvRjp+BnS3dLYTIZrjjeKT7
         BjPNvfj89fQeqzcLd/ADn7CjrFeq1bsm9pdz751ZIwEiaFLJSxgj94/C6OeW2totYtp5
         JMEqJiS5JV5NS+TZObZt+9ZqaVNfIT13K1fRmyWAr5QwUdEecNyKJY4G0V6EeReSRHaS
         xtAlciJhGgiPP/yvlee1yF5btbOACb9plcyD1Nm5FWURJFy7o1iFYXRtoy7JqoJY1cCN
         v4OjOi3ZiBsY4NR7spgXz+bGbT7itF51g/vSSm5w2/VDmHCth0KYAPM5rSTM7GR2M/yJ
         JAww==
X-Forwarded-Encrypted: i=1; AJvYcCXzAPqAKFHWeyOBejfw79mnyiaX19VcLXXpRVCzU80QVYF9AFPerNsYRwLVy3JqFtkZ+rXV5wdNCRFsh6I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfhbABADI6vLkaVLUnYUhuz8kxX0p+9Cg1Gu+OjF/l6SoVMdDs
	FH+0XMImaAPOxe+8gWDpEgWbtw70l7Jy+fnxy6VRkd4g6znSAZFwlFh1+dvJ5VpFEbo=
X-Gm-Gg: ASbGncvCyhu74fKBTp12g7EdMwJn60gTKBf93kja6WGRIGHEPRPy2fwOod+5ZUOpH3Z
	bcaFh72CNWa6HYcptUxlV4Xxn6olENveXtfihdis/u8MXzr50SGexz5GHuWaoDyvSOycA71eA3I
	6Mj1hrfp6JxDU/7UwX6rD9CsBuf3utJwYh38gzfopRCzxA10srVGoAHSpZ8wLYKrYKDreoTm2dM
	kyepQGsKelwAhOvMdHAI8Q1+cFXab1Txinp6DjA7IYxoLnbgpuE/+05l3SQkJTJpvxmbOXjhGpZ
	ou7v0kvhM2lcqH/tvoTYTJP2lQbxvhmBEtDHkZyQa/ZtjAoTkwFvlfTSyQmLoUXSYtVVZPF0Lzx
	ZvP38TKsJNmm8rKy3OnSJ5S4binIK9o5NGIPE
X-Google-Smtp-Source: AGHT+IEX7kxqjPNKgzRc5FzaaGAx++7bJd2BZ0Co0JpBuqwb92/9N/1Cu7pGDaS30PlQl+fwDeeX+g==
X-Received: by 2002:adf:e912:0:b0:3c6:cb4:e05e with SMTP id ffacd0b85a97d-3c60cb4e578mr7827667f8f.56.1756132032709;
        Mon, 25 Aug 2025 07:27:12 -0700 (PDT)
Received: from toaster.baylibre.com ([2a01:e0a:3c5:5fb1:b261:baab:ed3d:3cb6])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3c70e4b9e1fsm12634462f8f.14.2025.08.25.07.27.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 07:27:12 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Mon, 25 Aug 2025 16:26:34 +0200
Subject: [PATCH v2 09/12] clk: amlogic: use the common pclk definition
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250825-meson-clk-cleanup-24-v2-9-0f402f01e117@baylibre.com>
References: <20250825-meson-clk-cleanup-24-v2-0-0f402f01e117@baylibre.com>
In-Reply-To: <20250825-meson-clk-cleanup-24-v2-0-0f402f01e117@baylibre.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Kevin Hilman <khilman@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jerome Brunet <jbrunet@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=9875; i=jbrunet@baylibre.com;
 h=from:subject:message-id; bh=ssDaR4wz9jG+IVUW3bzaW/s+xN9zK8sGhakg0LDPY+Q=;
 b=owEBbQKS/ZANAwAKAeb8Dxw38tqFAcsmYgBorHK1XCoZgxVMFC8fEWvbXexWAF6ILhH1Z8QIs
 W7L+unfqrmJAjMEAAEKAB0WIQT04VmuGPP1bV8btxvm/A8cN/LahQUCaKxytQAKCRDm/A8cN/La
 hReZD/9IOkOqaQw7NpA3Ed83SvElIRCwDS93n8wA/pakL03R+G7MjmDwhrSnqIgeYkL9YyRRyZV
 dWWfJGtaHui0SDUokqEdnhDwxEajYUHwB1zAyxT7DVL+V0AcDL+/CmIfCZnBmQsGWDwlvHnOup8
 0quDjTTETx1wWkO6STK+2dI/T/VE+zES5ZDQGss0WzmNxmSL276QwfAp77cTOLnMr/GzJT4wn50
 kgFOjOLk3Adgs4eHzH7qD9VPUWbOKesg4xJr7wdHQwxDh0bhXmLbmvB7qiRzX4RJur5SWEGR75K
 jFQJrHx1zdVlybnWyCFWomOPxafXFMsMmA8O8G5RQywACwHbgvRhY2hahygzb4hYjNAk+G+GA1I
 Wy6YdUNksqln4vNZwDtMqwpGwPj9ABAdrMFvsiBWUg+ARapT1Pg6YVK9KXgBfuR1QWXLHrQ/oDd
 Hl9KLZ9M8YBjX+qbwgmIa4LYKKoF34GhCCClZxAH7j3RVLHKR7yjA54/tzEnghQ4Av4tkHNsa7/
 mV1aZnpSpcSWEDDd8xLKQI2Vb7Jj+g+FTZP3FVVBhdsLYMEoRztyOz2m5ipwyYMJqWCEZqbeZcO
 K9VLWEWIhf8qGpiCS0GL7YX4l3J5YfIv7znrvmoMTK8m5buRBlxszxNJEeyPuQqCPPNs5qHkz+o
 xZYAaw1yRw2Du0w==
X-Developer-Key: i=jbrunet@baylibre.com; a=openpgp;
 fpr=F29F26CF27BAE1A9719AE6BDC3C92AAF3E60AED9

Replace marcros defining pclks with the common one, reducing code
duplication.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/clk/meson/axg-aoclk.c      | 35 +++++++++-----------------
 drivers/clk/meson/c3-peripherals.c | 34 +++++++-------------------
 drivers/clk/meson/g12a-aoclk.c     | 50 +++++++++++++++-----------------------
 drivers/clk/meson/gxbb-aoclk.c     | 33 +++++++++----------------
 4 files changed, 51 insertions(+), 101 deletions(-)

diff --git a/drivers/clk/meson/axg-aoclk.c b/drivers/clk/meson/axg-aoclk.c
index 74c2f51424f11cc04a80a3a4918e4de0a5d11d08..902fbd34039cc06d512f1237a1e5d9050fd00b4b 100644
--- a/drivers/clk/meson/axg-aoclk.c
+++ b/drivers/clk/meson/axg-aoclk.c
@@ -34,30 +34,19 @@
 #define AO_RTC_ALT_CLK_CNTL0	0x94
 #define AO_RTC_ALT_CLK_CNTL1	0x98
 
-#define AXG_AO_GATE(_name, _bit, _flags)				\
-static struct clk_regmap axg_ao_##_name = {				\
-	.data = &(struct clk_regmap_gate_data) {			\
-		.offset = (AO_RTI_GEN_CNTL_REG0),			\
-		.bit_idx = (_bit),					\
-	},								\
-	.hw.init = &(struct clk_init_data) {				\
-		.name =  "axg_ao_" #_name,				\
-		.ops = &clk_regmap_gate_ops,				\
-		.parent_data = &(const struct clk_parent_data) {	\
-			.fw_name = "mpeg-clk",				\
-		},							\
-		.num_parents = 1,					\
-		.flags = (_flags),					\
-	},								\
-}
+static const struct clk_parent_data axg_ao_pclk_parents = { .fw_name = "mpeg-clk" };
 
-AXG_AO_GATE(remote,	0, CLK_IGNORE_UNUSED);
-AXG_AO_GATE(i2c_master,	1, CLK_IGNORE_UNUSED);
-AXG_AO_GATE(i2c_slave,	2, CLK_IGNORE_UNUSED);
-AXG_AO_GATE(uart1,	3, CLK_IGNORE_UNUSED);
-AXG_AO_GATE(uart2,	5, CLK_IGNORE_UNUSED);
-AXG_AO_GATE(ir_blaster,	6, CLK_IGNORE_UNUSED);
-AXG_AO_GATE(saradc,	7, CLK_IGNORE_UNUSED);
+#define AXG_AO_GATE(_name, _bit, _flags)		       \
+	MESON_PCLK(axg_ao_##_name, AO_RTI_GEN_CNTL_REG0, _bit, \
+		   &axg_ao_pclk_parents, _flags)
+
+static AXG_AO_GATE(remote,	0, CLK_IGNORE_UNUSED);
+static AXG_AO_GATE(i2c_master,	1, CLK_IGNORE_UNUSED);
+static AXG_AO_GATE(i2c_slave,	2, CLK_IGNORE_UNUSED);
+static AXG_AO_GATE(uart1,	3, CLK_IGNORE_UNUSED);
+static AXG_AO_GATE(uart2,	5, CLK_IGNORE_UNUSED);
+static AXG_AO_GATE(ir_blaster,	6, CLK_IGNORE_UNUSED);
+static AXG_AO_GATE(saradc,	7, CLK_IGNORE_UNUSED);
 
 static struct clk_regmap axg_ao_cts_oscin = {
 	.data = &(struct clk_regmap_gate_data){
diff --git a/drivers/clk/meson/c3-peripherals.c b/drivers/clk/meson/c3-peripherals.c
index e9c1ef99be13d0542b8a972ceffe69c8a9977118..02c9820cd98655e57a290859b595cf09d39e5fe3 100644
--- a/drivers/clk/meson/c3-peripherals.c
+++ b/drivers/clk/meson/c3-peripherals.c
@@ -164,30 +164,13 @@ static struct clk_regmap c3_rtc_clk = {
 	},
 };
 
-#define C3_PCLK(_name, _reg, _bit, _fw_name, _ops, _flags)		\
-struct clk_regmap c3_##_name = {					\
-	.data = &(struct clk_regmap_gate_data){				\
-		.offset = (_reg),					\
-		.bit_idx = (_bit),					\
-	},								\
-	.hw.init = &(struct clk_init_data) {				\
-		.name = "c3_" #_name,					\
-		.ops = _ops,						\
-		.parent_data = &(const struct clk_parent_data) {	\
-			.fw_name = (_fw_name),				\
-		},							\
-		.num_parents = 1,					\
-		.flags = (_flags),					\
-	},								\
-}
+static const struct clk_parent_data c3_sys_pclk_parents = { .fw_name = "sysclk" };
 
-#define C3_SYS_PCLK(_name, _reg, _bit, _flags)				\
-	C3_PCLK(_name, _reg, _bit, "sysclk",				\
-		&clk_regmap_gate_ops, _flags)
+#define C3_SYS_PCLK(_name, _reg, _bit, _flags) \
+	MESON_PCLK(c3_##_name, _reg, _bit, &c3_sys_pclk_parents, _flags)
 
-#define C3_SYS_PCLK_RO(_name, _reg, _bit)				\
-	C3_PCLK(_name, _reg, _bit, "sysclk",				\
-		&clk_regmap_gate_ro_ops, 0)
+#define C3_SYS_PCLK_RO(_name, _reg, _bit) \
+	MESON_PCLK_RO(c3_##_name, _reg, _bit, &c3_sys_pclk_parents, 0)
 
 static C3_SYS_PCLK(sys_reset_ctrl,	SYS_CLK_EN0_REG0, 1, 0);
 static C3_SYS_PCLK(sys_pwr_ctrl,	SYS_CLK_EN0_REG0, 3, 0);
@@ -290,9 +273,10 @@ static C3_SYS_PCLK(sys_vc9000e,		SYS_CLK_EN0_REG2, 2, 0);
 static C3_SYS_PCLK(sys_pwm_mn,		SYS_CLK_EN0_REG2, 3, 0);
 static C3_SYS_PCLK(sys_sd_emmc_b,	SYS_CLK_EN0_REG2, 4, 0);
 
-#define C3_AXI_PCLK(_name, _reg, _bit, _flags)				\
-	C3_PCLK(_name, _reg, _bit, "axiclk",				\
-		&clk_regmap_gate_ops, _flags)
+static const struct clk_parent_data c3_axi_pclk_parents = { .fw_name = "axiclk" };
+
+#define C3_AXI_PCLK(_name, _reg, _bit, _flags) \
+	MESON_PCLK(c3_##_name, _reg, _bit, &c3_axi_pclk_parents, _flags)
 
 /*
  * NOTE: axi_sys_nic provides the clock to the AXI bus of the system NIC. After
diff --git a/drivers/clk/meson/g12a-aoclk.c b/drivers/clk/meson/g12a-aoclk.c
index 45e4df393feb6f916b6e035ad71e379e6e30ee99..96981da271fa1453ebbe433e36cff4409661fa6a 100644
--- a/drivers/clk/meson/g12a-aoclk.c
+++ b/drivers/clk/meson/g12a-aoclk.c
@@ -37,22 +37,10 @@
 #define AO_RTC_ALT_CLK_CNTL0	0x94
 #define AO_RTC_ALT_CLK_CNTL1	0x98
 
-#define G12A_AO_PCLK(_name, _reg, _bit, _flags)				\
-static struct clk_regmap g12a_ao_##_name = {				\
-	.data = &(struct clk_regmap_gate_data) {			\
-		.offset = (_reg),					\
-		.bit_idx = (_bit),					\
-	},								\
-	.hw.init = &(struct clk_init_data) {				\
-		.name =  "g12a_ao_" #_name,				\
-		.ops = &clk_regmap_gate_ops,				\
-		.parent_data = &(const struct clk_parent_data) {	\
-			.fw_name = "mpeg-clk",				\
-		},							\
-		.num_parents = 1,					\
-		.flags = (_flags),					\
-	},								\
-}
+static const struct clk_parent_data g12a_ao_pclk_parents = { .fw_name = "mpeg-clk" };
+
+#define G12A_AO_PCLK(_name, _reg, _bit, _flags) \
+	MESON_PCLK(g12a_ao_##_name, _reg, _bit, &g12a_ao_pclk_parents, _flags)
 
 /*
  * NOTE: The gates below are marked with CLK_IGNORE_UNUSED for historic reasons
@@ -63,22 +51,22 @@ static struct clk_regmap g12a_ao_##_name = {				\
  *  - add a comment explaining why the use of CLK_IGNORE_UNUSED is desirable
  *    for a particular clock.
  */
-G12A_AO_PCLK(ahb,	AO_CLK_GATE0,    0, CLK_IGNORE_UNUSED);
-G12A_AO_PCLK(ir_in,	AO_CLK_GATE0,    1, CLK_IGNORE_UNUSED);
-G12A_AO_PCLK(i2c_m0,	AO_CLK_GATE0,    2, CLK_IGNORE_UNUSED);
-G12A_AO_PCLK(i2c_s0,	AO_CLK_GATE0,    3, CLK_IGNORE_UNUSED);
-G12A_AO_PCLK(uart,	AO_CLK_GATE0,    4, CLK_IGNORE_UNUSED);
-G12A_AO_PCLK(prod_i2c,	AO_CLK_GATE0,    5, CLK_IGNORE_UNUSED);
-G12A_AO_PCLK(uart2,	AO_CLK_GATE0,    6, CLK_IGNORE_UNUSED);
-G12A_AO_PCLK(ir_out,	AO_CLK_GATE0,    7, CLK_IGNORE_UNUSED);
-G12A_AO_PCLK(saradc,	AO_CLK_GATE0,    8, CLK_IGNORE_UNUSED);
+static G12A_AO_PCLK(ahb,	AO_CLK_GATE0,    0, CLK_IGNORE_UNUSED);
+static G12A_AO_PCLK(ir_in,	AO_CLK_GATE0,    1, CLK_IGNORE_UNUSED);
+static G12A_AO_PCLK(i2c_m0,	AO_CLK_GATE0,    2, CLK_IGNORE_UNUSED);
+static G12A_AO_PCLK(i2c_s0,	AO_CLK_GATE0,    3, CLK_IGNORE_UNUSED);
+static G12A_AO_PCLK(uart,	AO_CLK_GATE0,    4, CLK_IGNORE_UNUSED);
+static G12A_AO_PCLK(prod_i2c,	AO_CLK_GATE0,    5, CLK_IGNORE_UNUSED);
+static G12A_AO_PCLK(uart2,	AO_CLK_GATE0,    6, CLK_IGNORE_UNUSED);
+static G12A_AO_PCLK(ir_out,	AO_CLK_GATE0,    7, CLK_IGNORE_UNUSED);
+static G12A_AO_PCLK(saradc,	AO_CLK_GATE0,    8, CLK_IGNORE_UNUSED);
 
-G12A_AO_PCLK(mailbox,	AO_CLK_GATE0_SP, 0, CLK_IGNORE_UNUSED);
-G12A_AO_PCLK(m3,	AO_CLK_GATE0_SP, 1, CLK_IGNORE_UNUSED);
-G12A_AO_PCLK(ahb_sram,	AO_CLK_GATE0_SP, 2, CLK_IGNORE_UNUSED);
-G12A_AO_PCLK(rti,	AO_CLK_GATE0_SP, 3, CLK_IGNORE_UNUSED);
-G12A_AO_PCLK(m4_fclk,	AO_CLK_GATE0_SP, 4, CLK_IGNORE_UNUSED);
-G12A_AO_PCLK(m4_hclk,	AO_CLK_GATE0_SP, 5, CLK_IGNORE_UNUSED);
+static G12A_AO_PCLK(mailbox,	AO_CLK_GATE0_SP, 0, CLK_IGNORE_UNUSED);
+static G12A_AO_PCLK(m3,		AO_CLK_GATE0_SP, 1, CLK_IGNORE_UNUSED);
+static G12A_AO_PCLK(ahb_sram,	AO_CLK_GATE0_SP, 2, CLK_IGNORE_UNUSED);
+static G12A_AO_PCLK(rti,	AO_CLK_GATE0_SP, 3, CLK_IGNORE_UNUSED);
+static G12A_AO_PCLK(m4_fclk,	AO_CLK_GATE0_SP, 4, CLK_IGNORE_UNUSED);
+static G12A_AO_PCLK(m4_hclk,	AO_CLK_GATE0_SP, 5, CLK_IGNORE_UNUSED);
 
 static struct clk_regmap g12a_ao_cts_oscin = {
 	.data = &(struct clk_regmap_gate_data){
diff --git a/drivers/clk/meson/gxbb-aoclk.c b/drivers/clk/meson/gxbb-aoclk.c
index 2bf45fd7fe4ba0783e736fbbb126209870985b22..c7dfb3a06cb5f70c98f65bb91b937e1b870b34fe 100644
--- a/drivers/clk/meson/gxbb-aoclk.c
+++ b/drivers/clk/meson/gxbb-aoclk.c
@@ -23,29 +23,18 @@
 #define AO_RTC_ALT_CLK_CNTL0	0x94
 #define AO_RTC_ALT_CLK_CNTL1	0x98
 
-#define GXBB_AO_PCLK(_name, _bit, _flags)					\
-static struct clk_regmap gxbb_ao_##_name = {				\
-	.data = &(struct clk_regmap_gate_data) {			\
-		.offset = AO_RTI_GEN_CNTL_REG0,				\
-		.bit_idx = (_bit),					\
-	},								\
-	.hw.init = &(struct clk_init_data) {				\
-		.name = "gxbb_ao_" #_name,				\
-		.ops = &clk_regmap_gate_ops,				\
-		.parent_data = &(const struct clk_parent_data) {	\
-			.fw_name = "mpeg-clk",				\
-		},							\
-		.num_parents = 1,					\
-		.flags = (_flags),					\
-	},								\
-}
+static const struct clk_parent_data gxbb_ao_pclk_parents = { .fw_name = "mpeg-clk" };
 
-GXBB_AO_PCLK(remote,		0, CLK_IGNORE_UNUSED);
-GXBB_AO_PCLK(i2c_master,	1, CLK_IGNORE_UNUSED);
-GXBB_AO_PCLK(i2c_slave,		2, CLK_IGNORE_UNUSED);
-GXBB_AO_PCLK(uart1,		3, CLK_IGNORE_UNUSED);
-GXBB_AO_PCLK(uart2,		5, CLK_IGNORE_UNUSED);
-GXBB_AO_PCLK(ir_blaster,	6, CLK_IGNORE_UNUSED);
+#define GXBB_AO_PCLK(_name, _bit, _flags)			\
+	MESON_PCLK(gxbb_ao_##_name, AO_RTI_GEN_CNTL_REG0, _bit, \
+		   &gxbb_ao_pclk_parents, _flags)
+
+static GXBB_AO_PCLK(remote,	0, CLK_IGNORE_UNUSED);
+static GXBB_AO_PCLK(i2c_master,	1, CLK_IGNORE_UNUSED);
+static GXBB_AO_PCLK(i2c_slave,	2, CLK_IGNORE_UNUSED);
+static GXBB_AO_PCLK(uart1,	3, CLK_IGNORE_UNUSED);
+static GXBB_AO_PCLK(uart2,	5, CLK_IGNORE_UNUSED);
+static GXBB_AO_PCLK(ir_blaster,	6, CLK_IGNORE_UNUSED);
 
 static struct clk_regmap gxbb_ao_cts_oscin = {
 	.data = &(struct clk_regmap_gate_data){

-- 
2.47.2


