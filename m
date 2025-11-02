Return-Path: <linux-kernel+bounces-881996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B751CC2967D
	for <lists+linux-kernel@lfdr.de>; Sun, 02 Nov 2025 21:28:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 597583AFF6C
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Nov 2025 20:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8663123814D;
	Sun,  2 Nov 2025 20:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AgsrtHw0"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE452264CC
	for <linux-kernel@vger.kernel.org>; Sun,  2 Nov 2025 20:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762115260; cv=none; b=Jf/JoaSKVmkuhaV69tjGaohNzC08fos4Cj0lyxZjum5M36BDC55OgeDUm3ygPMaXCh+6UcyEtdChNyUJz4IzeuNG46jvrDajstFJXu0WGPRz/+bNHwWOxbZWLvSvg4LRQ1bT3TSJ5/OAuCZroR1/8XEp+RlbgI4XZZmWwe16LZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762115260; c=relaxed/simple;
	bh=ArSvj5nXGIoLUhxaTwM0e0vrMG9VC4hP4JEZ9NlwLy4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=osfVvWo+3/R8Xb52w+/oem2J1Pe8Jp0JfoPPbHE4IbLD3WMtGW9Fny8vrtwBuWBuVhKSN189L/wRmazTvox9ZTTWaa6A/MWvFLCgHGNhEIp6j0XzS5s1QTY+99kCbmagunNxv+zjp/kEGfPjXiwGJ7fQSogbirVTvpw5Y84qCAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AgsrtHw0; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4710665e7deso17143405e9.1
        for <linux-kernel@vger.kernel.org>; Sun, 02 Nov 2025 12:27:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762115257; x=1762720057; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pjBT7bI6FeaMlwLFqK21S9i1STzhdgd24lkDcjg28sI=;
        b=AgsrtHw007ztDt80nTsmNJj+rGAXj63TC0e8BvfDRi2jhQjJd85gtlaKPLxjWrq/LI
         Ps1bQNJxRyn6vQ8EVJYEM6IHqzKi/Gr3+zP5azf65lJ/BO+yIrhSLNlRA17uCLjWqjxk
         IRnn1Pur7tCOB1+GfkyIuTVtuUalhFfM/5bXLGSob3FjkPzpeRglRelp9GPB+nssKaS1
         GcQdwNi7Dy43tLFnCapISs66lOnoaHhidzA7ctgea7rrLQOerV392NOD/eZ/8DeVhT86
         hNk7djKycVIGUrvMbLUDVO45g/DMToA6C1PgRp7n18kycW//PveycDBUuBRBnKMzj9cO
         bYWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762115257; x=1762720057;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pjBT7bI6FeaMlwLFqK21S9i1STzhdgd24lkDcjg28sI=;
        b=JNkjkIkJmtTbWsotMZ666NedJ4te2MfiR9uPtLNWwjxZETR3tzD1KRB5q2vQJcKPI5
         phzurylx5JQ9EDKfhHU65Er33T6ATDsLREGu1MgYmY4yS2Z5Le2i4EspSkI/e0zfH9Hh
         vKzGE3oY9EDtHZ6FegwdNIe+i3bZOVJ/Xe/0kBzvPAYioV11tRL01xaKRlURnhG630D1
         7hqDHtI51ARpOheP3Fc3HITdw4Q4MqWQ3/Hgityq1A76IMfwz84vpYD4a+lqhSGEZYdr
         7Sb5krwUhFCgjQ3NrCwmJ17eFPNUKwZ7riOyBTuVTPQ+MSnf+p1ihdetgWi2vgjogqwP
         LwWA==
X-Forwarded-Encrypted: i=1; AJvYcCX1ZkCaPG6cFqCQsUCguA2UanD128B6j0RxBLULzUZ4xDuHCfTXH31zOFNQNk+dSo4zL3OI37ajd9goPzk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxLseM17dwd6Rp+H0iD2LR6cQDj9UWcugUMfs4HCeiXIIjCxLf
	efHcTRnr6mK6qg1ekmlRx9ngOrySvEI78uChkRNfOMjLf+vsPW7+Bb3e6fMtk6bwhI0=
X-Gm-Gg: ASbGncsXoPXMNzWfyHO7eOnh5r+8E3ZuwHUD+yl+ddYTRBE+JULBWeLFKKuLhT9H6XH
	unGs2AGCBO5qHTKuYMSQhELWZyZhXQB/x2XupnTdvDfjeNBdAAV1EcqLdhcnG2RZqosw6H37aDa
	t1h6/98YWDXt2RUbl5SwADr29szrfQ8rcj+u3f6RQC1hffQAiq2Z1M8Rx9i/PhRfHZcBn5IfAZS
	c9QGJxQw70+WuHYn+Gxul3cnA7U740tH6DOrYMNp9tzjMGJgzkpyZYuYwhsgTWrwgES3b1xRhKf
	diFnkXM4ZTX+hlZMiY4VwzB7wBsM8JhVAgQ8BvtVTNSZ4Pvki7lsCI4nz3E80gT4jL/o9Wky5bs
	d0xnGTjfxMdFVGQSBPO7ktQAEu3xS7zO5TAJMWxRdHcHORcXOGfKo1X9d/JSR6fK7rINH6GZiwx
	OfehzTQGcnJhik2ZE38dEJ4xDUNQ204q7Ttp6ndEL8IA==
X-Google-Smtp-Source: AGHT+IHclmceGA6xzLYK7AZwfvYGojs4HfrUGxVjb+fGjreUEWAioSECHuNNDZPvqg7GQ77Jc1vnDA==
X-Received: by 2002:a05:600c:6207:b0:46e:206a:78cc with SMTP id 5b1f17b1804b1-477308be7c3mr112935755e9.28.1762115256976;
        Sun, 02 Nov 2025 12:27:36 -0800 (PST)
Received: from gpeter-l.roam.corp.google.com ([145.224.65.248])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4773c374f84sm114664165e9.0.2025.11.02.12.27.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Nov 2025 12:27:35 -0800 (PST)
From: Peter Griffin <peter.griffin@linaro.org>
Date: Sun, 02 Nov 2025 20:27:17 +0000
Subject: [PATCH v3 4/4] clk: samsung: gs101: Enable auto_clock_gate mode
 for each gs101 CMU
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251102-automatic-clocks-v3-4-ff10eafe61c8@linaro.org>
References: <20251102-automatic-clocks-v3-0-ff10eafe61c8@linaro.org>
In-Reply-To: <20251102-automatic-clocks-v3-0-ff10eafe61c8@linaro.org>
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
 kernel-team@android.com, Peter Griffin <peter.griffin@linaro.org>, 
 Krzysztof Kozlowski <krzk@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6237;
 i=peter.griffin@linaro.org; h=from:subject:message-id;
 bh=ArSvj5nXGIoLUhxaTwM0e0vrMG9VC4hP4JEZ9NlwLy4=;
 b=owEBbQKS/ZANAwAKAc7ouNYCNHK6AcsmYgBpB76tfGyRfQkS/Vg9YDiwdRGOaYsOiZdACXdoB
 K8PM1sF53WJAjMEAAEKAB0WIQQO/I5vVXh1DVa1SfzO6LjWAjRyugUCaQe+rQAKCRDO6LjWAjRy
 uucWD/0RNZPQkDYgBH6LMcJ2iFEd+R6tP0ILXN0GZ828NPV/Q2QPGkoUVdbjo3vu/zAIlqUMB9+
 hnzKKcf7mtvSKpALlgGR9DYR8EOmhCLCduvh5NSC6zp1aG4H9xqtZveKLFo1eMdGlF+Q/ApyBqw
 hCtCP0GulpTQsZDT002zvkMKkR1LBOS9o1cQpfWzgy3aTM/WFiAFM3Bbb8JxUhGRn9krxEpW6/P
 INbBQLsJPkSjQUFkOu9hMnLyBDVtfkzL/oadfrh5E4CMOReLneNAQMErJwNPXvlAcUsdAkwTKmy
 EBcz4iiBzpDhNIQKIH8+5yKsKpLPz1PqClDGyfMnhFYYBG02jUa+wl8iczsigdDyN9lDauLdi56
 dlGQ163DTGy/h2qu+TfW2i1+X5Z31eLuCCZwJRCDoNOf9HpU1g36RIDBZxun6fe6I8M7xcQtlyw
 K3L6ReuliSvVG4uh28gUdmtoCpgeEkG/FaYTr/vaPFfJdt+BHMZxYj+ayb/G7i1L/ML6oFREe46
 vEe98evNnenD4TWa8gcUTE/4/wLvUNvvObQAdsJVzIqmzQFVg5uOJRM/84rtm1FqdEIaigAqWDh
 PPXxlMMT42lcmb5Be8cA9mRJQWTRr6CtRlSR91sqDIUdv/RAhmOqgOvP9XBlQ6x4n6Yzhr0l87S
 GHNr6GQDt5kyvhQ==
X-Developer-Key: i=peter.griffin@linaro.org; a=openpgp;
 fpr=0EFC8E6F5578750D56B549FCCEE8B8D6023472BA

Enable auto clock mode, and define the additional fields which are used
when this mode is enabled.

/sys/kernel/debug/clk/clk_summary now reports approximately 308 running
clocks and 298 disabled clocks. Prior to this commit 586 clocks were
running and 17 disabled.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
 drivers/clk/samsung/clk-gs101.c | 56 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/drivers/clk/samsung/clk-gs101.c b/drivers/clk/samsung/clk-gs101.c
index 70b26db9b95ad0b376d23f637c7683fbc8c8c600..68c5ed8f0fe1cac5169313b6ec705f9eec44ff53 100644
--- a/drivers/clk/samsung/clk-gs101.c
+++ b/drivers/clk/samsung/clk-gs101.c
@@ -9,6 +9,7 @@
 #include <linux/clk-provider.h>
 #include <linux/mod_devicetable.h>
 #include <linux/of.h>
+#include <linux/of_address.h>
 #include <linux/platform_device.h>
 
 #include <dt-bindings/clock/google,gs101.h>
@@ -26,6 +27,10 @@
 #define CLKS_NR_PERIC0	(CLK_GOUT_PERIC0_SYSREG_PERIC0_PCLK + 1)
 #define CLKS_NR_PERIC1	(CLK_GOUT_PERIC1_SYSREG_PERIC1_PCLK + 1)
 
+#define GS101_GATE_DBG_OFFSET 0x4000
+#define GS101_DRCG_EN_OFFSET  0x104
+#define GS101_MEMCLK_OFFSET   0x108
+
 /* ---- CMU_TOP ------------------------------------------------------------- */
 
 /* Register Offset definitions for CMU_TOP (0x1e080000) */
@@ -1433,6 +1438,9 @@ static const struct samsung_cmu_info top_cmu_info __initconst = {
 	.nr_clk_ids		= CLKS_NR_TOP,
 	.clk_regs		= cmu_top_clk_regs,
 	.nr_clk_regs		= ARRAY_SIZE(cmu_top_clk_regs),
+	.auto_clock_gate	= true,
+	.gate_dbg_offset	= GS101_GATE_DBG_OFFSET,
+	.option_offset		= CMU_CMU_TOP_CONTROLLER_OPTION,
 };
 
 static void __init gs101_cmu_top_init(struct device_node *np)
@@ -1900,6 +1908,11 @@ static const struct samsung_gate_clock apm_gate_clks[] __initconst = {
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
@@ -1912,6 +1925,12 @@ static const struct samsung_cmu_info apm_cmu_info __initconst = {
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
@@ -2375,7 +2394,14 @@ static const struct samsung_cmu_info hsi0_cmu_info __initconst = {
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
@@ -2863,7 +2889,14 @@ static const struct samsung_cmu_info hsi2_cmu_info __initconst = {
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
@@ -3423,7 +3456,14 @@ static const struct samsung_cmu_info misc_cmu_info __initconst = {
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
 
 static void __init gs101_cmu_misc_init(struct device_node *np)
@@ -4010,6 +4050,10 @@ static const struct samsung_gate_clock peric0_gate_clks[] __initconst = {
 	     21, 0, 0),
 };
 
+static const unsigned long dcrg_sysreg[] __initconst = {
+	GS101_DRCG_EN_OFFSET,
+};
+
 static const struct samsung_cmu_info peric0_cmu_info __initconst = {
 	.mux_clks		= peric0_mux_clks,
 	.nr_mux_clks		= ARRAY_SIZE(peric0_mux_clks),
@@ -4020,7 +4064,13 @@ static const struct samsung_cmu_info peric0_cmu_info __initconst = {
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
@@ -4368,7 +4418,13 @@ static const struct samsung_cmu_info peric1_cmu_info __initconst = {
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

-- 
2.51.1.930.gacf6e81ea2-goog


