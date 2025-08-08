Return-Path: <linux-kernel+bounces-760109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A830AB1E687
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 12:36:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50D14720AED
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 10:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A98832741B3;
	Fri,  8 Aug 2025 10:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="JNuVMsns"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82BC81990C7
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 10:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754649381; cv=none; b=twZhif0g5+0c5H9Y/Hh5FmCWU3gumh2BYdxQCi30bb10Tb1bUyyNZFKMT7X8VTkmze7jeLEd4h5LKG6JDLTCWGHdNFzB61vcq2ZTU69b3pcf/mWbRmZeTPtFuMHXya0z2auU5O0fIxs6bjJvFgB6XXlKrPt7299ZKWNOtEUN3TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754649381; c=relaxed/simple;
	bh=JcZGTciaD4zebk7GYD3eQi8/W1xLrBL3TKgjtTdUqbo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=o3ouPFeT/Z+rLwQZ2atv9qrADDttmPeL4P41TAllkIssYDfAONEATtR7TP90qhbhkLnWBft61D776m3f/fhym5oh7vGoVCzbd5+r1K/r3qUxWWqeVE4LZPgCpi3IzkUZuwV7AU6RqxH560iDYBz+M/wgvQa2Tco+i+sNuBFl27U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=JNuVMsns; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-af66d49daffso346851666b.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Aug 2025 03:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1754649375; x=1755254175; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=btGvPQZiWOXn0B7/gk/rJTMjXaXvcBsb2KTNKeGgrXA=;
        b=JNuVMsnskGxXKl+9FiSg7IDxYmt1/ZCGBnp8p3uyPGwRgO22lB+Rgr77LY12IjYwqZ
         44nQZABxzJdWFIfEogCzdNoM8tJFBMZo18Lc0N/JIZj6qRRAGYitkzxBr0Ophl6cC6QZ
         znRWjkNLI/EIq9v9ntBHFXWGwkMI2PnzvBP9pHUC8rCodM3MKBlxWDEaFpFZOJhamOYo
         Sfe26QWaRPsEwG8agIHzCBGkYKbM4s2Mjo5F+d1YJ+gj5AGkNvH0SyNdvodlhytj6iA2
         oPFaLmiPZzP5k3fj39Q5TZkEnSnhwKJwgbXpZfVFU7+ftADz/H0yMSpz/2eBdccUOuqL
         eeGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754649375; x=1755254175;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=btGvPQZiWOXn0B7/gk/rJTMjXaXvcBsb2KTNKeGgrXA=;
        b=ZrX9hZCbwT7M+hynYWQ8IGeOp01FQZ01cd7Dn7gL3+10wFj5ZcDYmK9yUt2H3zFEfa
         atwn77ceiWjoRufqmin5GeN482THxcAYe5PBp5IYG4Q2Q3NhWxJkKZz4ml8bqFBap2lM
         L1oikQIEJHqDheH09U+E1Pr7LCc6jTdL0fERdf4y96y13bC4Z9njsoN6FBIlSWbEuY9R
         ZUyu/1ajdQpccjr52A6deN9R6jAU8D3hNTnH6KwzJDxsqKHtCUA7PbLIImSHu9t7CIxT
         q/63cwY7SZQr9hfboQMYD0AfYY5WA5BiSDkV7IMwVuOZc1BEVVZEdfgC/2gX1Gu9vDbN
         VeaA==
X-Gm-Message-State: AOJu0YxVr3B/aWbW4Sn4PMphe0CD2Y9o/tfLsZR/l0KzslLDQ5e8Ag/D
	zwBqdh8VzT9TApAfhycKl+rvEeoIKiK4wAxCnCagypbOJes00uWbbj+NA+1JlcN4n7A=
X-Gm-Gg: ASbGncuWMC4W2Nka5YzcE3MTVkFbnAk4J+5t8LzTgSxgYC9FSnP8ARkCdbRoyBNS73Z
	99vdvZ+IDUVwI1bvRMlnzztXdkJL7R3PaDMAffYKjnZ48YnUSuB6nLEWZVIJA5xSpRUoY9mH+2J
	4kHueFV5IfZF7eJuVL7tO7/AiH2mjawp65vW31O1Cb5SC8bRqSPwGM2hY/gAPhgZMmSWiy/A36l
	Tf2TDogzHw1F7xoi0R2eLzjJNn0M2MEOxzOqp7CUXbGhX0b9c/BUvI/dOe8zYmLCJHg4qCQtKgs
	ED7X3ui5JFE5b2NSZsrfw0S98CDLA4DE3SALj5E+IIibBfYNADpt4UknL5pLbWuqmwNA0NTVPs+
	sQ3vRQnxdJ8qaaDMN9w==
X-Google-Smtp-Source: AGHT+IHPJarRWHkntpryCQMay/z/dGeZNCx9bTRjfxRmN868x4k6N/J3VqA3kieOj4uH956h/8KgfQ==
X-Received: by 2002:a17:907:7f25:b0:af9:8d62:b1ab with SMTP id a640c23a62f3a-af9c6377171mr240207166b.10.1754649374718;
        Fri, 08 Aug 2025 03:36:14 -0700 (PDT)
Received: from localhost ([2001:4090:a244:8691:4b7a:7bbd:bac:c56e])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-af91a0a1bf9sm1478135166b.31.2025.08.08.03.36.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 03:36:14 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
Date: Fri, 08 Aug 2025 12:35:21 +0200
Subject: [PATCH] clocksource/drivers/arm_global_timer: Add auto-detection
 for initial prescaler values
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250808-topic-am43-arm-global-timer-v6-16-v1-1-82067d327580@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAOjSlWgC/x3NwQqDMAyA4VeRnBdonQvdXmV4iF10AWslFRmI7
 27Z8bv8/wFFTKXAqznAZNeieanwtwbil5dJUD/V0Lr24YILuOVVI3Lq7siWcJrzwDNumsRwJ/S
 ERGN0kZ7B8wC1s5qM+vs/3v15XiqB6NFzAAAA
X-Change-ID: 20250808-topic-am43-arm-global-timer-v6-16-66fc0c6981ab
To: Daniel Lezcano <daniel.lezcano@linaro.org>, 
 Thomas Gleixner <tglx@linutronix.de>, 
 Patrice Chotard <patrice.chotard@foss.st.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 "Mendez, Judith" <jm@ti.com>, Kevin Hilman <khilman@baylibre.com>, 
 Markus Schneider-Pargmann <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5483; i=msp@baylibre.com;
 h=from:subject:message-id; bh=JcZGTciaD4zebk7GYD3eQi8/W1xLrBL3TKgjtTdUqbo=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhoypl8Ve2F1+911mjeheTTud/v0S97/eFJ93sMzoiUnvt
 K9VHxPZOkpZGMS4GGTFFFk6E0PT/svvPJa8aNlmmDmsTCBDGLg4BWAiGa2MDPNlVnicO/WObc+b
 ygrN90f3V7o+3NM72dQqbVW6p/rvE7mMDAcOVfSlnNW/ZqbLuXtq0+Qbu/fM8NHQ323vkLHZ4dI
 qW34A
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41

am43xx has a clock tree where the global timer clock is an indirect child
of the CPU clock used for frequency scaling:

  dpll_mpu_ck -- CPU/cpufreq
        |
        v
  dpll_mpu_m2_ck -- divider
        |
        v
  mpu_periphclk -- fixed divider by 2 used for global timer

When CPU frequency changes, the global timer's clock notifier rejects
the change because the hardcoded prescaler (1 or 2) cannot accommodate
the frequency range across all CPU OPPs (300, 600, 720, 800, 1000 MHz).

Add platform-specific prescaler auto-detection to solve this issue:

- am43xx: prescaler = 50 (calculated as initial_freq/GCD of all OPP
  freqs) This allows the timer to work across all CPU frequencies after
  the fixed divider by 2. Tested on am4372-idk-evm.

- zynq-7000: prescaler = 2 (preserves previous Kconfig default)

- Other platforms: prescaler = 1 (previous default)

The Kconfig option now defaults to 0 (auto-detection) but can still
override the auto-detected value when set to a non-zero value,
preserving existing customization workflows.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 drivers/clocksource/Kconfig            |  4 ++--
 drivers/clocksource/arm_global_timer.c | 44 ++++++++++++++++++++++++++++++----
 2 files changed, 41 insertions(+), 7 deletions(-)

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 645f517a1ac26d0c12d4b2b46591321ddf6e20b3..92df191b25b1af339dffc791f81ff541b09a87a8 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -395,8 +395,7 @@ config ARM_GLOBAL_TIMER
 
 config ARM_GT_INITIAL_PRESCALER_VAL
 	int "ARM global timer initial prescaler value"
-	default 2 if ARCH_ZYNQ
-	default 1
+	default 0
 	depends on ARM_GLOBAL_TIMER
 	help
 	  When the ARM global timer initializes, its current rate is declared
@@ -406,6 +405,7 @@ config ARM_GT_INITIAL_PRESCALER_VAL
 	  bounds about how much the parent clock is allowed to decrease or
 	  increase wrt the initial clock value.
 	  This affects CPU_FREQ max delta from the initial frequency.
+	  Use 0 to use auto-detection in the driver.
 
 config ARM_TIMER_SP804
 	bool "Support for Dual Timer SP804 module"
diff --git a/drivers/clocksource/arm_global_timer.c b/drivers/clocksource/arm_global_timer.c
index 2d86bbc2764a04944e453038013142b2495d26b9..5e3d6bb7e437badeba45d8bf2c1df14eb3427448 100644
--- a/drivers/clocksource/arm_global_timer.c
+++ b/drivers/clocksource/arm_global_timer.c
@@ -263,14 +263,13 @@ static void __init gt_delay_timer_init(void)
 	register_current_timer_delay(&gt_delay_timer);
 }
 
-static int __init gt_clocksource_init(void)
+static int __init gt_clocksource_init(unsigned int psv)
 {
 	writel(0, gt_base + GT_CONTROL);
 	writel(0, gt_base + GT_COUNTER0);
 	writel(0, gt_base + GT_COUNTER1);
 	/* set prescaler and enable timer on all the cores */
-	writel(FIELD_PREP(GT_CONTROL_PRESCALER_MASK,
-			  CONFIG_ARM_GT_INITIAL_PRESCALER_VAL - 1) |
+	writel(FIELD_PREP(GT_CONTROL_PRESCALER_MASK, psv - 1) |
 	       GT_CONTROL_TIMER_ENABLE, gt_base + GT_CONTROL);
 
 #ifdef CONFIG_CLKSRC_ARM_GLOBAL_TIMER_SCHED_CLOCK
@@ -338,11 +337,45 @@ static int gt_clk_rate_change_cb(struct notifier_block *nb,
 	return NOTIFY_DONE;
 }
 
+struct gt_prescaler_config {
+	const char *compatible;
+	unsigned long prescaler;
+};
+
+static const struct gt_prescaler_config gt_prescaler_configs[] = {
+	/*
+	 * On am43 the global timer clock is a child of the clock used for CPU
+	 * OPPs, so the initial prescaler has to be compatible with all OPPs
+	 * which are 300, 600, 720, 800 and 1000 with a fixed divider of 2, this
+	 * gives us a GCD of 10. Initial frequency is 1000, so the prescaler is
+	 * 50.
+	 */
+	{ .compatible = "ti,am43", .prescaler = 50 },
+	{ .compatible = "xlnx,zynq-7000", .prescaler = 2 },
+	{ .compatible = NULL }
+};
+
+static unsigned long gt_get_initial_prescaler_value(struct device_node *np)
+{
+	const struct gt_prescaler_config *config;
+
+	if (CONFIG_ARM_GT_INITIAL_PRESCALER_VAL != 0)
+		return CONFIG_ARM_GT_INITIAL_PRESCALER_VAL;
+
+	for (config = gt_prescaler_configs; config->compatible; config++) {
+		if (of_machine_is_compatible(config->compatible))
+			return config->prescaler;
+	}
+
+	return 1;
+}
+
 static int __init global_timer_of_register(struct device_node *np)
 {
 	struct clk *gt_clk;
 	static unsigned long gt_clk_rate;
 	int err;
+	unsigned long psv;
 
 	/*
 	 * In A9 r2p0 the comparators for each processor with the global timer
@@ -378,8 +411,9 @@ static int __init global_timer_of_register(struct device_node *np)
 		goto out_unmap;
 	}
 
+	psv = gt_get_initial_prescaler_value(np);
 	gt_clk_rate = clk_get_rate(gt_clk);
-	gt_target_rate = gt_clk_rate / CONFIG_ARM_GT_INITIAL_PRESCALER_VAL;
+	gt_target_rate = gt_clk_rate / psv;
 	gt_clk_rate_change_nb.notifier_call =
 		gt_clk_rate_change_cb;
 	err = clk_notifier_register(gt_clk, &gt_clk_rate_change_nb);
@@ -404,7 +438,7 @@ static int __init global_timer_of_register(struct device_node *np)
 	}
 
 	/* Register and immediately configure the timer on the boot CPU */
-	err = gt_clocksource_init();
+	err = gt_clocksource_init(psv);
 	if (err)
 		goto out_irq;
 

---
base-commit: 038d61fd642278bab63ee8ef722c50d10ab01e8f
change-id: 20250808-topic-am43-arm-global-timer-v6-16-66fc0c6981ab

Best regards,
-- 
Markus Schneider-Pargmann <msp@baylibre.com>


