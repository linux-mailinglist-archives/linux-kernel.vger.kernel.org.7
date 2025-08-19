Return-Path: <linux-kernel+bounces-775090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DB07B2BB25
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 09:54:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A25C617E98D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 07:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C35773101AB;
	Tue, 19 Aug 2025 07:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="P350YEkl"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B9830F812
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 07:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755589980; cv=none; b=hBIvSjDYLFgdjBOgNFJ8z9IkBrLLN6wFwUkCCcFnrJXZxz0QgI3JPVwuvkBahJ5gJXltnEcnKS16PX1JDhp1nOc+2JVvm8PsjjctENJzVQWqUn1KAovfByjlz4VbS9nrcl6eYiJVZm5DQlezJh36xWd9ijS3kF7LUdZFrYji+5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755589980; c=relaxed/simple;
	bh=v2yMuPIutn0ukBdsJ3Tt74LERYJHFoOO/j19VwhQEzw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=IBb3crbSwcuEQ57xpZL8POH5maO7CDIITBp8i02f3Od646yyAc2X1wlfSMDwfVLIQMhYwWhoxcXdtBkmBpH2z+ZQjHcyFcT7YrPukjKzaTDhhiKRIZanhQhg3qsQ8kjK/o9hMbXx36uaj/ebZ8G/RrDuEpC0uBCJ8eBClaHx/j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=P350YEkl; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-afcb7a7bad8so663936466b.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 00:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1755589975; x=1756194775; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tnZk+Dq5pVLCqYugFkq/rFRBfkBcZKXShdlCaPfswJo=;
        b=P350YEkl8/T0Jt7M2kcYyvTawVVHUi+U9j+YDVaDVSUeVOYsxx3zRULmcTC7UEw8XB
         nMN75mK8HnbJa8ALZ1y2dQFBriZxb59lcmrJhjxkcKho4CPWmQ8XHXI+PaZbgDUdDzlC
         Q92P5gGd2o8eeExSAUOs5cz1g4SStxa9PGC1C8BUF9CzvAu3BEWY1FW3yjMFf3y5RMkv
         UrJydNVmh0lH9lGBuLHJparTwArNpWbb/ccE5mjqe9l+r5qpU/lrITRc4uCcWmALDQ12
         Qujv3jSR4YqyUGN5nbLK1cs5HeWiy4vg++pkUKoy6JKMXGwZwgpA/DReyLnH2yIUmoZp
         FHEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755589975; x=1756194775;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tnZk+Dq5pVLCqYugFkq/rFRBfkBcZKXShdlCaPfswJo=;
        b=OKKg0InOdOgIldBl51tQ98eK8DMkpkol6fGiE8MBNjMGh38ZVKR3vi01G5yGDhRLJL
         kq66utp6tuC6zarobHycHfbXd/5brfS6l2kw2uVy2ol9K8mdTCbcRmPCBtYhWcnqvufI
         bFfVDMxFouywCl3HogGw+gyogXLax9ftc++rXj420r0eanxum+A8PBWvYUgFG1zba7As
         5i8iubaTuyd/l0I32nEK0xCQU6e+6y9/nIf1/o0sAp3GQfqiPETI8fyQ4Qh6NS2Bry99
         eq6dIE3kam2i+ieVRqMsspf89ROfgwYuDs7I79r31ZrK1tq82HDIgfqIlDwF1XgFWm2G
         5ZpQ==
X-Gm-Message-State: AOJu0Yzy15pwHC5yh7eePDiUcyiYTcoJeBtrUE9XLqhplRHI1N85xP8I
	0lB974Pi8QeQavJqNZYAs42KtibbpsU12GpGKkH/RUmkD8SuSp8AyoHocjsn8Wckcgk=
X-Gm-Gg: ASbGncv8RDZKTIoCs7OtKHRFgcyH8EHxcUhwsK37rzl/JPMF7wqUVMv9iGQxaeHj9+E
	0NkcyJ35lvtO0xf9kukzwoU5HHhlwNcYWOvSYt6ZXHEbGB8eXuUX+K1+nDYf9ep3l1/U/4v2ZOK
	+IsXPRH3qCIXnqrIi0p877hyNQz5eF+M1PX6lA5aVx+zolhFI/PZMUiuS0WZLLBrLcTCeUJPXZy
	sJBatS90JeHkyf6HuZTYted4d4elm938gH6qGiZgExPfjOD4YQuwi2l2ex+cgKCSN9uXaDCcYM5
	s4Os7bsawyqReJLkkYy8FKPphRKsRSlOInfX//k+EH0Akv/wrKNITUoilMFKrzxZe5UnkNcm+iO
	IzeSzHcaVLPzFkjM5jg==
X-Google-Smtp-Source: AGHT+IFyJ+Vk10rgdQW1uK7bd8eUmV3xvgLBqXlkJPVA1/vrzHUujvO97X9ocMR8gxA5zTahLQaLVQ==
X-Received: by 2002:a17:907:96a9:b0:af9:1411:9fcc with SMTP id a640c23a62f3a-afddc957097mr167714066b.3.1755589975111;
        Tue, 19 Aug 2025 00:52:55 -0700 (PDT)
Received: from localhost ([2001:4090:a245:849b:bc8d:b969:7631:815])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-61a757bc1b4sm1252537a12.49.2025.08.19.00.52.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 00:52:54 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
Date: Tue, 19 Aug 2025 09:52:41 +0200
Subject: [PATCH v2] clocksource/drivers/arm_global_timer: Add
 auto-detection for initial prescaler values
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250819-topic-am43-arm-global-timer-v6-16-v2-1-6d082e2a5161@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAEgtpGgC/5WNQQ6DIBAAv2I4dxvAirSn/qPxABR1ExGzGFJj/
 HupP+hx5jCzs+QJfWKPamfkMyaMcwF5qZgbzTx4wHdhJrlsuOYa1rigAxNuNRgKMEzRmglWDJ4
 gKxAKlOodd+quhbGsdBbyPX7Ox6srPGJaI23nMouf/aeeBQjQkqv2Xcu20fxpzTahJX91MbDuO
 I4v4Qbkq9UAAAA=
X-Change-ID: 20250808-topic-am43-arm-global-timer-v6-16-66fc0c6981ab
To: Daniel Lezcano <daniel.lezcano@linaro.org>, 
 Thomas Gleixner <tglx@linutronix.de>, 
 Patrice Chotard <patrice.chotard@foss.st.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 "Mendez, Judith" <jm@ti.com>, Kevin Hilman <khilman@baylibre.com>, 
 Markus Schneider-Pargmann <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5741; i=msp@baylibre.com;
 h=from:subject:message-id; bh=v2yMuPIutn0ukBdsJ3Tt74LERYJHFoOO/j19VwhQEzw=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhowlugHPvfayPI49/fB0sdAF2ab4p3qNR38+y9tXpq34p
 W3SXPM3HaUsDGJcDLJiiiydiaFp/+V3HktetGwzzBxWJpAhDFycAjCR7VaMDEum/57Memv+/e36
 N3YFL5nzIP8q77ZbF5M/bjm28KhIlG8JI8OUDUssrTQDL4UG77lt+dzrnLv5E5+1Dz8wrHsxO8b
 z42ZuAA==
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

Reviewed-by: Kevin Hilman <khilman@baylibre.com>
Tested-by: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
Changes in v2:
- Rebased to v6.17-rc1
- Link to v1: https://lore.kernel.org/r/20250808-topic-am43-arm-global-timer-v6-16-v1-1-82067d327580@baylibre.com
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
base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
change-id: 20250808-topic-am43-arm-global-timer-v6-16-66fc0c6981ab

Best regards,
-- 
Markus Schneider-Pargmann <msp@baylibre.com>


