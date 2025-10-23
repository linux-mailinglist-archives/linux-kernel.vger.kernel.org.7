Return-Path: <linux-kernel+bounces-867768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1E57C03767
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 22:56:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E24F83B7FF1
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 20:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A6902D373F;
	Thu, 23 Oct 2025 20:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qo8WL8Fe"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 936CC2C326C
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 20:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761252796; cv=none; b=QSX4mGxKhnvcOi9rmE6mPjCwRcJi4aHLwa/z4wDFKnGx2RIacDnRIsgj/fbHnuUTOmOtLDdBdKo9POj5Fqnex9hKgJu/pKGSsEnseTRFx0d3J9skqpIy8nMGPsbRIisU6FKKX5ZVhB0LiHjI4CsQvjx2IqiY6M61k226OWwXtFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761252796; c=relaxed/simple;
	bh=CESpfuQKSTARvsi02223z0qLzhBNqlIQPJ9hcvIXEto=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VYTb7MUoqeD9s6upGFybJ7krf334pW1EGeAM+nonYIxqmf5xJuEiLH/jINOMGya7vrxJQxpbIymAbZ1wt4W116qop8U/hk/p2zzXEQvlbBSPRUzSpJgEMr4fvFES7sbX1d0ZpkJ/gDioPZU46jtn4/olPpcnMAPVGKyIJwMAl9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--willmcvicker.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qo8WL8Fe; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--willmcvicker.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-33bcb7796d4so1313317a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 13:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761252794; x=1761857594; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=t8LUdY9Gbr3c9MBtkrMrb9ELOUUlz3DwF1vW+da8Cus=;
        b=qo8WL8Fed5pF3kxSuXW5qWclP8e8/mKOfIB7k2P/qhW6S9yypXdv3551/hkOUcjxYY
         bEV0W6urYZ5Z692LAzwNfDpXXfY2630FRxUvePjKTfQLslSCW1UnFLa3mrIJsWEOtLFJ
         24xy8nKPDXk3STKDJd65gntVlKMcN8mqaGl3+/sRQsnQv3XJZKLc4qbkW2fSVSmKq6Dz
         DMmozBMgTt9s4GLB0nR5bQ4xpWTXjfq3dCcpzeTP59RSxWHsKp7X5K36V85la1jNCdj0
         5lA/RJd7qfKmrVhU5/EwTSkc8nXa+roAfFNuIZFPjf3AiObgXLefoRQ5JNXjW0QhBt5n
         twpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761252794; x=1761857594;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t8LUdY9Gbr3c9MBtkrMrb9ELOUUlz3DwF1vW+da8Cus=;
        b=U5tKl/JU5dDy50G7kkXGqwx0qEQZHYwNcYnNggIjDdjfm8MqGyOLU9HJ8KAE6N32cg
         HcfirxZ8MsTwztj04jP2K6qy82Q/t6SfcXTXgsjicp41bIwtPibgdLr2Vp848iI50EOz
         fi0KPYJ6KTmyRMvCWeaGFdqLPuiIYW5Z/jB1SyF/jd4y51dumGt/4Bxyg1YrsuSN4JGz
         2+1FlWHVAyU/SZ27RHhtyi8JvWewPkpH2Dwdf+kBDk3xpaRtCcIi7RtfUnQ6JldiVqQM
         SCvwWJmNa6kA1UYJMkbOPlNnFI9YROEOc+5/QtijzBeIBEszA6Nt7tdE8aWe/l4t/ItJ
         I1zA==
X-Forwarded-Encrypted: i=1; AJvYcCWumMeXroSQISXk0BZ1zuvrEyiNeWX23JO/SDrWgF/6quc/qVGHFmyb1RpXJ7SCEzGp3YiFWsBzRwbCMCE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxd8q0uj1AnIqYjfOcss2ltqTvDHiO//hTpf/icHy+Ju2kWKFyr
	+0+ZWa+Gu4e8C4P5F6uZ5HHkHd2DU+amRBraQTAYmhP5iA2ysqORb8PF2Zjup22qbifaDptsb1q
	3GLl7Mz42F0lDWBiWv6SixwtOMVnFeA==
X-Google-Smtp-Source: AGHT+IGBf1IJzGzHW/dQ74bgawMiYQGBddoxKJ6LePC8746ZA/Ftq/tF6PBMtE1kkx8goimn/4nF1bVNeCHWhrBhu3o=
X-Received: from pjbei7.prod.google.com ([2002:a17:90a:e547:b0:33b:cba3:7277])
 (user=willmcvicker job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90a:c88c:b0:330:6d5e:f17e with SMTP id 98e67ed59e1d1-33fafc1cdfcmr4966565a91.24.1761252793850;
 Thu, 23 Oct 2025 13:53:13 -0700 (PDT)
Date: Thu, 23 Oct 2025 20:52:48 +0000
In-Reply-To: <20251023205257.2029526-1-willmcvicker@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251023205257.2029526-1-willmcvicker@google.com>
X-Mailer: git-send-email 2.51.1.821.gb6fe4d2222-goog
Message-ID: <20251023205257.2029526-7-willmcvicker@google.com>
Subject: [PATCH v5 6/7] clocksource/drivers/exynos_mct: Add module support
From: Will McVicker <willmcvicker@google.com>
To: Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Krzysztof Kozlowski <krzk@kernel.org>, 
	Alim Akhtar <alim.akhtar@samsung.com>, Hosung Kim <hosung0.kim@samsung.com>, 
	Will McVicker <willmcvicker@google.com>, Ingo Molnar <mingo@kernel.org>, 
	Peter Griffin <peter.griffin@linaro.org>, Youngmin Nam <youngmin.nam@samsung.com>
Cc: Donghoon Yu <hoony.yu@samsung.com>, Rob Herring <robh@kernel.org>, 
	Saravana Kannan <saravanak@google.com>, John Stultz <jstultz@google.com>, 
	Tudor Ambarus <tudor.ambarus@linaro.org>, 
	"=?UTF-8?q?Andr=C3=A9=20Draszik?=" <andre.draszik@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, linux-samsung-soc@vger.kernel.org, 
	kernel-team@android.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Donghoon Yu <hoony.yu@samsung.com>

On Arm64 platforms the Exynos MCT driver can be built as a module. On
boot (and even after boot) the arch_timer is used as the clocksource and
tick timer. Once the MCT driver is loaded, it can be used as the wakeup
source for the arch_timer.

Signed-off-by: Donghoon Yu <hoony.yu@samsung.com>
Signed-off-by: Youngmin Nam <youngmin.nam@samsung.com>
Signed-off-by: Will McVicker <willmcvicker@google.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
[original commit from https://android.googlesource.com/kernel/gs/+/8a52a8288ec7d88ff78f0b37480dbb0e9c65bbfd]
Reviewed-by: Youngmin Nam <youngmin.nam@samsung.com> # AOSP -> Linux port
Tested-by: Youngmin Nam <youngmin.nam@samsung.com> # AOSP -> Linux port
---
 drivers/clocksource/Kconfig      |  3 +-
 drivers/clocksource/exynos_mct.c | 56 +++++++++++++++++++++++++++-----
 2 files changed, 49 insertions(+), 10 deletions(-)

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index ffcd23668763..9450cfaf982f 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -451,7 +451,8 @@ config ATMEL_TCB_CLKSRC
 	  Support for Timer Counter Blocks on Atmel SoCs.
 
 config CLKSRC_EXYNOS_MCT
-	bool "Exynos multi core timer driver" if COMPILE_TEST
+	tristate "Exynos multi core timer driver" if ARM64
+	default y if ARCH_EXYNOS || COMPILE_TEST
 	depends on ARM || ARM64
 	depends on ARCH_ARTPEC || ARCH_EXYNOS || COMPILE_TEST
 	help
diff --git a/drivers/clocksource/exynos_mct.c b/drivers/clocksource/exynos_mct.c
index fece6bbc190e..a87caf3928ef 100644
--- a/drivers/clocksource/exynos_mct.c
+++ b/drivers/clocksource/exynos_mct.c
@@ -15,9 +15,11 @@
 #include <linux/cpu.h>
 #include <linux/delay.h>
 #include <linux/percpu.h>
+#include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_irq.h>
 #include <linux/of_address.h>
+#include <linux/platform_device.h>
 #include <linux/clocksource.h>
 #include <linux/sched_clock.h>
 
@@ -217,6 +219,7 @@ static struct clocksource mct_frc = {
 	.mask		= CLOCKSOURCE_MASK(32),
 	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
 	.resume		= exynos4_frc_resume,
+	.owner		= THIS_MODULE,
 };
 
 /*
@@ -241,7 +244,7 @@ static cycles_t exynos4_read_current_timer(void)
 }
 #endif
 
-static int __init exynos4_clocksource_init(bool frc_shared)
+static int exynos4_clocksource_init(bool frc_shared)
 {
 	/*
 	 * When the frc is shared, the main processor should have already
@@ -336,6 +339,7 @@ static struct clock_event_device mct_comp_device = {
 	.set_state_oneshot	= mct_set_state_shutdown,
 	.set_state_oneshot_stopped = mct_set_state_shutdown,
 	.tick_resume		= mct_set_state_shutdown,
+	.owner			= THIS_MODULE,
 };
 
 static irqreturn_t exynos4_mct_comp_isr(int irq, void *dev_id)
@@ -476,6 +480,7 @@ static int exynos4_mct_starting_cpu(unsigned int cpu)
 	evt->features = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT |
 			CLOCK_EVT_FEAT_PERCPU;
 	evt->rating = MCT_CLKEVENTS_RATING;
+	evt->owner = THIS_MODULE;
 
 	exynos4_mct_write(TICK_BASE_CNT, mevt->base + MCT_L_TCNTB_OFFSET);
 
@@ -511,7 +516,7 @@ static int exynos4_mct_dying_cpu(unsigned int cpu)
 	return 0;
 }
 
-static int __init exynos4_timer_resources(struct device_node *np)
+static int exynos4_timer_resources(struct device_node *np)
 {
 	struct clk *mct_clk, *tick_clk;
 
@@ -539,7 +544,7 @@ static int __init exynos4_timer_resources(struct device_node *np)
  * @local_idx: array mapping CPU numbers to local timer indices
  * @nr_local: size of @local_idx array
  */
-static int __init exynos4_timer_interrupts(struct device_node *np,
+static int exynos4_timer_interrupts(struct device_node *np,
 					   unsigned int int_type,
 					   const u32 *local_idx,
 					   size_t nr_local)
@@ -653,7 +658,7 @@ static int __init exynos4_timer_interrupts(struct device_node *np,
 	return err;
 }
 
-static int __init mct_init_dt(struct device_node *np, unsigned int int_type)
+static int mct_init_dt(struct device_node *np, unsigned int int_type)
 {
 	bool frc_shared = of_property_read_bool(np, "samsung,frc-shared");
 	u32 local_idx[MCT_NR_LOCAL] = {0};
@@ -701,15 +706,48 @@ static int __init mct_init_dt(struct device_node *np, unsigned int int_type)
 	return exynos4_clockevent_init();
 }
 
-
-static int __init mct_init_spi(struct device_node *np)
+static int mct_init_spi(struct device_node *np)
 {
 	return mct_init_dt(np, MCT_INT_SPI);
 }
 
-static int __init mct_init_ppi(struct device_node *np)
+static int mct_init_ppi(struct device_node *np)
 {
 	return mct_init_dt(np, MCT_INT_PPI);
 }
-TIMER_OF_DECLARE(exynos4210, "samsung,exynos4210-mct", mct_init_spi);
-TIMER_OF_DECLARE(exynos4412, "samsung,exynos4412-mct", mct_init_ppi);
+
+static int exynos4_mct_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	int (*mct_init)(struct device_node *np);
+
+	mct_init = of_device_get_match_data(dev);
+	if (!mct_init)
+		return -EINVAL;
+
+	return mct_init(dev->of_node);
+}
+
+static const struct of_device_id exynos4_mct_match_table[] = {
+	{ .compatible = "samsung,exynos4210-mct", .data = &mct_init_spi, },
+	{ .compatible = "samsung,exynos4412-mct", .data = &mct_init_ppi, },
+	{}
+};
+MODULE_DEVICE_TABLE(of, exynos4_mct_match_table);
+
+static struct platform_driver exynos4_mct_driver = {
+	.probe		= exynos4_mct_probe,
+	.driver		= {
+		.name	= "exynos-mct",
+		.of_match_table = exynos4_mct_match_table,
+	},
+};
+
+static __init int exynos_mct_init(void)
+{
+  return platform_driver_register(&exynos4_mct_driver);
+}
+module_init(exynos_mct_init);
+
+MODULE_DESCRIPTION("Exynos Multi Core Timer Driver");
+MODULE_LICENSE("GPL");
-- 
2.51.1.821.gb6fe4d2222-goog


