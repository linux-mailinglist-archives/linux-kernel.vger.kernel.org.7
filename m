Return-Path: <linux-kernel+bounces-851364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 556CEBD6475
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 22:53:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CFE8E34C66A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 20:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AB8F30AD11;
	Mon, 13 Oct 2025 20:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aMsfr7kY"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D1112EC0BB
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 20:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760388724; cv=none; b=IHXPfGEi3cEEsR2oFx1NZxz0iDelaDZov64cuNwJarGa0FG3h8iTLtIUC1qdSN13Cit1AkFST0hefxaZ6jD1Tij9yx0SKVO3U10hSbUr1nWutc+Aot81UyL+viIBYeyWl42wpdVEs2ovzQDTNnoH9HqafOAcW1qQxaS0O5r+yiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760388724; c=relaxed/simple;
	bh=fQZhEsh+9ZgYadJsDPZd2/yZYZlJq55drQnSNUYsOok=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=u42egZfhQP4MpPvDBBfHdIe99boQ8HRGF8btt6wvld1PO883FeTbt/RQMsmZ9xviesUpk/wQG2I/KiN7IAuiHrar9GSN1Wy669y6blLGRXQI2n+69h+wCABjovStzGMiLg9t2GjvCG9tDMnIUEO3IYdSlEhW1r1ztMAZftl3n0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aMsfr7kY; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-46faa5b0372so28279355e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 13:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760388721; x=1760993521; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UlfTuxpg2vZermn3xEvTp73moBNB2p5ILIMcqfhHtkI=;
        b=aMsfr7kY3LXRQ3g8vIFlZcnamUYeQFzURCk6YdVYnuCfF7dgsIY/W/aFO2+3hoPKD7
         qUfwA49aTeZvD2Nzg5YvpVVyrI1hLoSTmISvnQ88U0TelTmLYh10qNteYc+Y0uYwO/F+
         t+Zl9ic0Rqd8lVWHoaWCuyGSjzxpbn+Rkmn7u5rKB7VDaeyTyEXaz6LyH7sOazG2MHTI
         FL8ZVN+AzuZsbUUuhROqB4vRQZjfr1d/EvUoJHAffFdzDgNM1gyDYIvKXhtecxBLXJmE
         NkcDH/10JRR3BFDfeQfSBsKd8tZT9YVB9C+j5lsB+dTUOOGffCap0vxCMBmC5Mez//MF
         3mgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760388721; x=1760993521;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UlfTuxpg2vZermn3xEvTp73moBNB2p5ILIMcqfhHtkI=;
        b=OAZt7+DiCKwKioxlZbdQXWjoqMiAV2yFVMOdIlo5hJeh8QUlE7/dX/LgfNvqq7bjPS
         nVvpWHYu6pkLbxkQS30iOmLLqM31xj7k90jUJ1V1uvKXkSCWvyLEevvO/yzbrODnO+B6
         lGu+OEYewPoxWCW3N0Gc/kyh0Dahm1jyNt7XAKYLkiZnimMeQjvKM2qxhjqzhJtnq5yG
         aqcCwQqHbNlMisTfemxM3Y5c338/mQ5NPd3P67SfQjXrxZgxSvz/hDJA3sLXYoUFpH+s
         kvU9wqFUuYOnNhmNEiH2H9TMw5eptcdrtmJ77ZJq06odh5AOoX2Ag6xWbQ1i/zZUYhpx
         qdZQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/v8gsSwBWYqLIhZtTqKaoniMIwilhdzOwWH9WmLjGtiO7P2Rt0YGOmwRiVvreSi9YPfdLUeIoZFObgi8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhvBJEWRGQRrz0ZZTM4p4r87c6tBGr38RQxAYVVE4Cu7A7xpm5
	JsYqOQhatLH6vb7QeNQj7PV/XNYtRcqdVcRJ5NkfSvPZsZDFx6PdXaq/Wk3MiEA1ZuA=
X-Gm-Gg: ASbGncsDyeIZZLbnvcg4nxz5cetIZKk9gyJSnqzit1H3LdIKxCOWrJLPG6lY7VHI71w
	RwgV2q7HPyCsEWVGCZC5Zu6GiBM1pZINpygacTHBE+2lZwiJemfMBBGcWNZimN4GHblbAoS/MB+
	bGnlIIAZFd+wW8W+Due1z1ZeARAgJMhMEbZ/Y5EApCTVaWybmrlFt0o6O591D6q0SC6BQk0q3Sa
	fd9zX1YkPpiuWDPvQpfg/MVqlk1jXGNSYZJ8D2ewdOSQUxKwtKKi243p56s3KGHmNWUdKG7S3K6
	Tf0Ua7S2no2VnmjW0hWxBnyLI4K34rv0DCiRYnavzt7m4yRX1VD3YtYoPG+xuSjcgnJ7vPenp5b
	8bB7HBRfyX8iSFonJFmNMkNjsBMBnq3L8m7Bi9DLq8ldHzaoFMzQtdLhwrGe9C9nx4p5OXPwgLB
	g=
X-Google-Smtp-Source: AGHT+IG1NwQmtOjjZ2/dGF38ZzGggflM2yvAgmMVXAjSdlZJTXywrvmzmtGp19sycSBPbak19TsvNQ==
X-Received: by 2002:a05:600c:4752:b0:46e:3dad:31ea with SMTP id 5b1f17b1804b1-46fa9af8fb0mr166311105e9.17.1760388720655;
        Mon, 13 Oct 2025 13:52:00 -0700 (PDT)
Received: from gpeter-l.roam.corp.google.com ([145.224.67.171])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fab3e3206sm133512615e9.4.2025.10.13.13.51.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 13:51:59 -0700 (PDT)
From: Peter Griffin <peter.griffin@linaro.org>
Date: Mon, 13 Oct 2025 21:51:37 +0100
Subject: [PATCH 8/9] clk: samsung: gs101: Enable auto_clock_gate mode for
 each gs101 CMU
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251013-automatic-clocks-v1-8-72851ee00300@linaro.org>
References: <20251013-automatic-clocks-v1-0-72851ee00300@linaro.org>
In-Reply-To: <20251013-automatic-clocks-v1-0-72851ee00300@linaro.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Sam Protsenko <semen.protsenko@linaro.org>, 
 Sylwester Nawrocki <s.nawrocki@samsung.com>, 
 Chanwoo Choi <cw00.choi@samsung.com>
Cc: Will McVicker <willmcvicker@google.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 kernel-team@android.com, Peter Griffin <peter.griffin@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7486;
 i=peter.griffin@linaro.org; h=from:subject:message-id;
 bh=fQZhEsh+9ZgYadJsDPZd2/yZYZlJq55drQnSNUYsOok=;
 b=owEBbQKS/ZANAwAKAc7ouNYCNHK6AcsmYgBo7WZaFmB5oO6bxerWS75hxLV3Q/O3DBVJInhcK
 HuIddY42LCJAjMEAAEKAB0WIQQO/I5vVXh1DVa1SfzO6LjWAjRyugUCaO1mWgAKCRDO6LjWAjRy
 uiUMD/90qqTQd5Jt7lfdvd8T1Ib2G44/7tTA/l6AJ9HgSoevW3uhesRJ1AHoyZY43EA44Ym1MlG
 OoJ0nbcq9iGwa0QQpxvoLrmHKqcsJvIqb/VrInAdkaDLbGMcH7AobRgYppbwnHjKDuBDM2+fkMG
 NwNKjj4p1MNOCfbnFYoElEhHI/F4S8Sq55lGAvGja5/CIRLD3woKLLDOeIby93HMnuV6/sTf8s9
 gK6a/VOor46whtehVuH5TyWVWSUBa2NyNvaN3DB0jJYZ12wVwrMI1bY0+QUz7EjCQJl/R8f51xX
 s/jcLl0fV6rn+brULQ6mrpu66BdLSmZDHIOBpY+BibhyqdJJZwJLp9EZkSOt9G1zlu4jb72hbMW
 D5baSNrIzgbB2kypuclaRzN91foPFpiYA26dwyzWk6LVOyT5+1CmNMGHLMTONwT99CtdxW8L6jQ
 nqHI92of3SR5vFisBnthTY59IWQkZjjWLkjtCSlLGTxusAEkI7Yf9ugpa/gTKC2yvHeqZZnZKsH
 eX22vl6nHQQxhNYhIbjiI4mQtIdQvhsxImJ79WtgR8ALoPfCM5yp+qyD8mvPKfRxx+/ZRxLWigr
 Ssu9j1PU88KjtSi8Y/OlAK4NNUD/kaVWDBrjefABDGGXW67zU7CZcP+/nTLkgyFFKQrMwu+8Kzm
 7wP1hmxcQmJWa/Q==
X-Developer-Key: i=peter.griffin@linaro.org; a=openpgp;
 fpr=0EFC8E6F5578750D56B549FCCEE8B8D6023472BA

Enable auto clock mode, and define the additional fields which are used
when this mode is enabled.

/sys/kernel/debug/clk/clk_summary now reports approximately 308 running
clocks and 298 disabled clocks. Prior to this commit 586 clocks were
running and 17 disabled. To ensure compatability with older DTs the
resource size is checked and an error issued if the DT needs updating.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
 drivers/clk/samsung/clk-gs101.c | 80 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 80 insertions(+)

diff --git a/drivers/clk/samsung/clk-gs101.c b/drivers/clk/samsung/clk-gs101.c
index 70b26db9b95ad0b376d23f637c7683fbc8c8c600..baf41ae6c9e2480cb83531acf7eae190c6aff819 100644
--- a/drivers/clk/samsung/clk-gs101.c
+++ b/drivers/clk/samsung/clk-gs101.c
@@ -9,6 +9,7 @@
 #include <linux/clk-provider.h>
 #include <linux/mod_devicetable.h>
 #include <linux/of.h>
+#include <linux/of_address.h>
 #include <linux/platform_device.h>
 
 #include <dt-bindings/clock/google,gs101.h>
@@ -17,6 +18,8 @@
 #include "clk-exynos-arm64.h"
 #include "clk-pll.h"
 
+int check_cmu_res_size(struct device_node *np);
+
 /* NOTE: Must be equal to the last clock ID increased by one */
 #define CLKS_NR_TOP	(CLK_GOUT_CMU_TPU_UART + 1)
 #define CLKS_NR_APM	(CLK_APM_PLL_DIV16_APM + 1)
@@ -26,6 +29,10 @@
 #define CLKS_NR_PERIC0	(CLK_GOUT_PERIC0_SYSREG_PERIC0_PCLK + 1)
 #define CLKS_NR_PERIC1	(CLK_GOUT_PERIC1_SYSREG_PERIC1_PCLK + 1)
 
+#define GS101_GATE_DBG_OFFSET 0x4000
+#define GS101_DRCG_EN_OFFSET  0x104
+#define GS101_MEMCLK_OFFSET   0x108
+
 /* ---- CMU_TOP ------------------------------------------------------------- */
 
 /* Register Offset definitions for CMU_TOP (0x1e080000) */
@@ -1433,6 +1440,9 @@ static const struct samsung_cmu_info top_cmu_info __initconst = {
 	.nr_clk_ids		= CLKS_NR_TOP,
 	.clk_regs		= cmu_top_clk_regs,
 	.nr_clk_regs		= ARRAY_SIZE(cmu_top_clk_regs),
+	.auto_clock_gate	= true,
+	.gate_dbg_offset	= GS101_GATE_DBG_OFFSET,
+	.option_offset		= CMU_CMU_TOP_CONTROLLER_OPTION,
 };
 
 static void __init gs101_cmu_top_init(struct device_node *np)
@@ -1900,6 +1910,11 @@ static const struct samsung_gate_clock apm_gate_clks[] __initconst = {
 	     CLK_CON_GAT_GOUT_BLK_APM_UID_XIU_DP_APM_IPCLKPORT_ACLK, 21, CLK_IS_CRITICAL, 0),
 };
 
+static const unsigned long dcrg_memclk_sysreg[] __initconst = {
+	GS101_DRCG_EN_OFFSET,
+	GS101_MEMCLK_OFFSET,
+};
+
 static const struct samsung_cmu_info apm_cmu_info __initconst = {
 	.mux_clks		= apm_mux_clks,
 	.nr_mux_clks		= ARRAY_SIZE(apm_mux_clks),
@@ -1912,6 +1927,12 @@ static const struct samsung_cmu_info apm_cmu_info __initconst = {
 	.nr_clk_ids		= CLKS_NR_APM,
 	.clk_regs		= apm_clk_regs,
 	.nr_clk_regs		= ARRAY_SIZE(apm_clk_regs),
+	.sysreg_clk_regs	= dcrg_memclk_sysreg,
+	.nr_sysreg_clk_regs	= ARRAY_SIZE(dcrg_memclk_sysreg),
+	.auto_clock_gate	= true,
+	.gate_dbg_offset	= GS101_GATE_DBG_OFFSET,
+	.drcg_offset		= GS101_DRCG_EN_OFFSET,
+	.memclk_offset		= GS101_MEMCLK_OFFSET,
 };
 
 /* ---- CMU_HSI0 ------------------------------------------------------------ */
@@ -2375,7 +2396,14 @@ static const struct samsung_cmu_info hsi0_cmu_info __initconst = {
 	.nr_clk_ids		= CLKS_NR_HSI0,
 	.clk_regs		= hsi0_clk_regs,
 	.nr_clk_regs		= ARRAY_SIZE(hsi0_clk_regs),
+	.sysreg_clk_regs	= dcrg_memclk_sysreg,
+	.nr_sysreg_clk_regs	= ARRAY_SIZE(dcrg_memclk_sysreg),
 	.clk_name		= "bus",
+	.auto_clock_gate        = true,
+	.gate_dbg_offset        = GS101_GATE_DBG_OFFSET,
+	.option_offset		= HSI0_CMU_HSI0_CONTROLLER_OPTION,
+	.drcg_offset		= GS101_DRCG_EN_OFFSET,
+	.memclk_offset		= GS101_MEMCLK_OFFSET,
 };
 
 /* ---- CMU_HSI2 ------------------------------------------------------------ */
@@ -2863,7 +2891,14 @@ static const struct samsung_cmu_info hsi2_cmu_info __initconst = {
 	.nr_clk_ids		= CLKS_NR_HSI2,
 	.clk_regs		= cmu_hsi2_clk_regs,
 	.nr_clk_regs		= ARRAY_SIZE(cmu_hsi2_clk_regs),
+	.sysreg_clk_regs	= dcrg_memclk_sysreg,
+	.nr_sysreg_clk_regs	= ARRAY_SIZE(dcrg_memclk_sysreg),
 	.clk_name		= "bus",
+	.auto_clock_gate        = true,
+	.gate_dbg_offset        = GS101_GATE_DBG_OFFSET,
+	.option_offset		= HSI2_CMU_HSI2_CONTROLLER_OPTION,
+	.drcg_offset		= GS101_DRCG_EN_OFFSET,
+	.memclk_offset		= GS101_MEMCLK_OFFSET,
 };
 
 /* ---- CMU_MISC ------------------------------------------------------------ */
@@ -3423,11 +3458,37 @@ static const struct samsung_cmu_info misc_cmu_info __initconst = {
 	.nr_clk_ids		= CLKS_NR_MISC,
 	.clk_regs		= misc_clk_regs,
 	.nr_clk_regs		= ARRAY_SIZE(misc_clk_regs),
+	.sysreg_clk_regs	= dcrg_memclk_sysreg,
+	.nr_sysreg_clk_regs	= ARRAY_SIZE(dcrg_memclk_sysreg),
 	.clk_name		= "bus",
+	.auto_clock_gate	= true,
+	.gate_dbg_offset	= GS101_GATE_DBG_OFFSET,
+	.option_offset		= MISC_CMU_MISC_CONTROLLER_OPTION,
+	.drcg_offset		= GS101_DRCG_EN_OFFSET,
+	.memclk_offset		= GS101_MEMCLK_OFFSET,
 };
 
+/* for old DT compatbility with incorrect CMU size*/
+int check_cmu_res_size(struct device_node *np)
+{
+	struct resource res;
+	resource_size_t size;
+
+	if (of_address_to_resource(np, 0, &res))
+		return -ENODEV;
+
+	size = resource_size(&res);
+	if (size != 0x10000) {
+		pr_warn("%pOF: resource to small. Please update your DT\n", np);
+		return -ENODEV;
+	}
+	return 0;
+}
+
 static void __init gs101_cmu_misc_init(struct device_node *np)
 {
+	if (check_cmu_res_size(np))
+		return;
 	exynos_arm64_register_cmu(NULL, np, &misc_cmu_info);
 }
 
@@ -4010,6 +4071,10 @@ static const struct samsung_gate_clock peric0_gate_clks[] __initconst = {
 	     21, 0, 0),
 };
 
+static const unsigned long dcrg_sysreg[] __initconst = {
+	GS101_DRCG_EN_OFFSET,
+};
+
 static const struct samsung_cmu_info peric0_cmu_info __initconst = {
 	.mux_clks		= peric0_mux_clks,
 	.nr_mux_clks		= ARRAY_SIZE(peric0_mux_clks),
@@ -4020,7 +4085,13 @@ static const struct samsung_cmu_info peric0_cmu_info __initconst = {
 	.nr_clk_ids		= CLKS_NR_PERIC0,
 	.clk_regs		= peric0_clk_regs,
 	.nr_clk_regs		= ARRAY_SIZE(peric0_clk_regs),
+	.sysreg_clk_regs	= dcrg_sysreg,
+	.nr_sysreg_clk_regs	= ARRAY_SIZE(dcrg_sysreg),
 	.clk_name		= "bus",
+	.auto_clock_gate        = true,
+	.gate_dbg_offset        = GS101_GATE_DBG_OFFSET,
+	.option_offset		= PERIC0_CMU_PERIC0_CONTROLLER_OPTION,
+	.drcg_offset		= GS101_DRCG_EN_OFFSET,
 };
 
 /* ---- CMU_PERIC1 ---------------------------------------------------------- */
@@ -4368,7 +4439,13 @@ static const struct samsung_cmu_info peric1_cmu_info __initconst = {
 	.nr_clk_ids		= CLKS_NR_PERIC1,
 	.clk_regs		= peric1_clk_regs,
 	.nr_clk_regs		= ARRAY_SIZE(peric1_clk_regs),
+	.sysreg_clk_regs	= dcrg_sysreg,
+	.nr_sysreg_clk_regs	= ARRAY_SIZE(dcrg_sysreg),
 	.clk_name		= "bus",
+	.auto_clock_gate        = true,
+	.gate_dbg_offset        = GS101_GATE_DBG_OFFSET,
+	.option_offset		= PERIC1_CMU_PERIC1_CONTROLLER_OPTION,
+	.drcg_offset		= GS101_DRCG_EN_OFFSET,
 };
 
 /* ---- platform_driver ----------------------------------------------------- */
@@ -4378,6 +4455,9 @@ static int __init gs101_cmu_probe(struct platform_device *pdev)
 	const struct samsung_cmu_info *info;
 	struct device *dev = &pdev->dev;
 
+	if (check_cmu_res_size(dev->of_node))
+		return -ENODEV;
+
 	info = of_device_get_match_data(dev);
 	exynos_arm64_register_cmu(dev, dev->of_node, info);
 

-- 
2.51.0.760.g7b8bcc2412-goog


