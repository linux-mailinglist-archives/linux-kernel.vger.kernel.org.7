Return-Path: <linux-kernel+bounces-877212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8948C1D73A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 22:31:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E73521883058
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 21:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D811318135;
	Wed, 29 Oct 2025 21:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kpQH43vS"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDBEE31A056
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 21:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761773447; cv=none; b=NDk5MzZKcfBzD1hWvF6Sicrd5rHnT/RK2fiRF+maHU5QUz+XdjAvxiPq3kuApMs/UKKVJqrn+QSoMeKI+G/VumRN+dZOW4wG18Dg8aehp8Ptu7PFmQJ2hTHHjyc6QTwhRg6jqL4jqUNWSj3l4JLa+jy+blaYcTWy+HyxM0VQ/3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761773447; c=relaxed/simple;
	bh=oM4kL/PXCK2EPatzGpk867zg8TyU+43TUg05bDgKThA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=e98kbU7tefuKCWJcLACdpRm/GAFTPziDtWfM4WUju5Ak/l1IzldPxXf55/AM22MF3UpiTDCWdN2JK6R1seDLudcl89QwGNpan7oDH2qDzdhfUXH9EqcGoM8PBHgq5O4Hxc5sXzIUMOn/7unG0TngHtLHWUBm7hKAKWf5QfcQeB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kpQH43vS; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-471b80b994bso3903255e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 14:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761773443; x=1762378243; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZFhpMv0TS5z8Ka1Q09jnxxHQC5OXHmjo9VvdfZH94aA=;
        b=kpQH43vSVGPaS8MuW/rJmks9W1PLXnSfNjdCDq8P/yG05PntsiTt+KzqaJ6BRDtcGr
         dCulFsqqBNm3NxlaqO4k7IRehheIH6pwwc7ad2HzVSFrDOxQn2UowjQ2LBhP2HCpw6At
         hdy7ptBrVYIDrm4HVpGwClFOYIV9wScGgK/jRBhIIMe7k1JFzuXQv8xcniIWN2J0ooMG
         qXvvpdCUKunRWaf/cLYLFqck0iabbrpvWrq1fyPtQPmUkRa+Zsyqdj1vMGmuAxnJmog0
         Zagiq4jkR4WnXG0ZBYpQhwunxfaRPaMvamwgn9Gj9YEBhKgikYZ5MyCFsJv8Aw/3mXwF
         Y7xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761773443; x=1762378243;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZFhpMv0TS5z8Ka1Q09jnxxHQC5OXHmjo9VvdfZH94aA=;
        b=gCHNcNMxDqEkmH33JFbSlSiDiE18/R1wTpLzbm7Oq1ELuKGENsYsXqERoPkCtjfCI2
         9pucrN/tTFfb/j8F6q3811cuBuZNcbTiMxYWnfovEDpUG9aPE+Gc1F5iq1ZUzJw3ZZmJ
         WuHStpkCoghQXVl9xC5SlHp/U5RPhNucxsIu3C1L4uspfIqJ4jH7oKnNKqNgYFl+bPII
         gnG5/ZuD+VL7U1KnzA4JBtAIXVVIAbnUj8l9i83jvUXEhp2x50WL7QvdOLXdhRy5jmRZ
         aM+kY9wtgvPhCH0xBdBtB2U3/HTN/ne2AL7W+UAtjdYDq7/8MEhbhQatO52Xm5rPyaun
         tgWw==
X-Forwarded-Encrypted: i=1; AJvYcCVjFcsFoUc3WVoHDEgfDX/7y6A6PBaTwsM8MCoIeI4FWX+P88EdASBJaJWriYuyyt2vgu2LatFB/4f2MIk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMM+Pvr5/mWsI3wdAw1BlgWTViKePVLWgPsOBLOYMDqniO6Ew4
	wXpVvgQ97UcRXfvzHxe3FWjD1DmRTKIW9MdyGpplWM4VC7mFTQOG4C9Nmp+qz04gyEI=
X-Gm-Gg: ASbGncuZfSCTUXqW/mK5O6+k13agz2rkhcaLI0Llwvh9j1MrYNLlcbpeY9FLANoZIIS
	jTR/fOI9kBdTf2C2vQl5oWioyLTN45vf898eqLKEiHT6+t7OhDXV6XM+D5v/HrKvQg5HtltcZxT
	VCacoN6tu3BkcItS9VQmJGG9CDkXUOuQR02fq/ObTgK4a2wMixdmw7IDK5wgZJyMvyKnEAif+YP
	CCKE+KKsduHlQNJrNMk4sMzq4QNKs4snwltXA9yux/growJCGTdYI6qzHLI40vP5kn9ODQslngy
	yl8PSR4dy1jy+QmRd656yx5U7JlI2OoOB+93zF1rGAXZaZX/SiqX4xJQg+yn3c3ZAeuuYSfNYP2
	aIF2l23ECiHBDLrjOgG6AVE/KTyFjB3luqXNHOH8Lbr/nAZ1oHIVZdPik8E6NfMMCn0ZxXdI/xY
	rO7LV5Pday7HmFWraWUU3wEa9jm64u/A==
X-Google-Smtp-Source: AGHT+IHVKBgjvBcg1f/6q88hadZlvNZkx1IaeehmFQmwK/82FK+KqLJA2Oi5GwkBpiXwwokUglXnGg==
X-Received: by 2002:a05:6000:2006:b0:427:847:9d59 with SMTP id ffacd0b85a97d-429b4c9ee68mr1094202f8f.45.1761773443210;
        Wed, 29 Oct 2025 14:30:43 -0700 (PDT)
Received: from gpeter-l.roam.corp.google.com ([145.224.90.44])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952b7b43sm28573457f8f.6.2025.10.29.14.30.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 14:30:42 -0700 (PDT)
From: Peter Griffin <peter.griffin@linaro.org>
Date: Wed, 29 Oct 2025 21:29:25 +0000
Subject: [PATCH v2 4/4] clk: samsung: gs101: Enable auto_clock_gate mode
 for each gs101 CMU
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-automatic-clocks-v2-4-f8edd3a2d82b@linaro.org>
References: <20251029-automatic-clocks-v2-0-f8edd3a2d82b@linaro.org>
In-Reply-To: <20251029-automatic-clocks-v2-0-f8edd3a2d82b@linaro.org>
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
 bh=oM4kL/PXCK2EPatzGpk867zg8TyU+43TUg05bDgKThA=;
 b=owEBbQKS/ZANAwAKAc7ouNYCNHK6AcsmYgBpAod4kOXb2zATBSZi/XvWQU+uUmKxKhl+dduVU
 SSmHS8LRxaJAjMEAAEKAB0WIQQO/I5vVXh1DVa1SfzO6LjWAjRyugUCaQKHeAAKCRDO6LjWAjRy
 uvt4D/9OY4nx/ssfdyJfQsLWXa4i/pTsHM7F9uszUzRBnrjQQ8G6kzTI0gS4k5L+My4tHiYMzIg
 IB9D9hhN9dLM4lhsnR+cQDd6A8yFp5izu78n0pVC93sJe0ESdXmVI/0eEkHB9oCTcvhyPp8smOl
 j/tgdTiLclBB7KnLoe6bBRZTfy2Y6b91xIoyaDLuE1jRdln8b2h5zlE2XubIUqitTFSXlNacfI0
 r7PoQY646CnLo51RpsRpPsKDXqwEqegI0o7/0St4GPkXiKq532mUyegf89RZJe3SdfPUJFqZfN2
 5hRgje4cyWgXU1UDlbhUW4rkToPhpQODp4Aqp+CSa+yY+lutEFmNMpuYGMyLPHLzwzTY8Ek98it
 lE7IfuKN2+nKIiGyWsNjvSGHlLj8qNEQoBezUGShZBcecEHf+lddPfohia2mYmgka0LH6guH/c5
 J0wiZvDPJkGkPK7f2T87KG/8UEqYxpKbQJhWQOm3nlC7/SS+fbLcmalHoP2t0pAOTLr3+gA+w4B
 nNyBRayv7yVqytIVVDpX1FMkL2OR+FKX3BaW3eDS5saHqVp1ReNDyuaN4vEGi9E9rNANrqZ4xiB
 NgV+ZVB+k4exZjd6D4sJQyZJcavHSJhcLX7jjaHLTs67kilnRJh9Iu/ksj7enAiNZ6igT/vA4v6
 bTu4W3eS7BVVodw==
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
2.51.1.851.g4ebd6896fd-goog


