Return-Path: <linux-kernel+bounces-750379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE7A2B15AA4
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 10:32:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0959C16C1B4
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 08:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6611729ACF1;
	Wed, 30 Jul 2025 08:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WmC2dTQj"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31AB929A9FA
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 08:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753864123; cv=none; b=d1w7IsHWeSdcHaOEiZ0rB21Lw1e/lkY/k/MqlUAZmRk10ZfoFKeRJD+lFhmDMLIkwgSlEQwJZ+944NWRqin5ImWkCl5mZPC6SKKVK2dLKwgnZ4IutE6KRuHzCJy3o+VEskj94jPlIhFHjR85v0fbW/zBFyXC/emWBsHdScjKZOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753864123; c=relaxed/simple;
	bh=ZcJ2JgK+m6G7VNBbCRvp0aVnvN/WcWX0nVtQG4Ay86E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XyRHiM169ked5GZrOhnLOBeiJ3up5jLAi5SxgYyE4fJUWtg6XCQb2SiUmisZ79p7BNqvRKOybhhZfTz6HpoznGXR6zSmZqmdHT15ssQe37COeRJyZXv4hY3zVCB2zQ46Jv3rOSehWun2R5X/QilUVNAyuYzAni7o0aKZyzdGrOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WmC2dTQj; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4563bc166a5so3343855e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 01:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753864119; x=1754468919; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lOXsofV7d5Y1QpSZQsIBgp8cuSodqQc2mblmLGbM94w=;
        b=WmC2dTQjvH0nw+sUIbvxrfV3s5+MHGavst2silOhyqGAhFYFccDU2mCikhva3J1+sn
         kNs/YozjCFwwPRn+1T+z7Y2f+sDi4qsekylhiqxdfX89WbcQrTkYh/yj08mfhLxjpiBi
         YeMYAlL+cA35eoollz+POTfOzGUhuG27UQ1yIEQgB7b52cPkzTjIQqxii+K0pwdCpKvA
         LTu/VF/JzD+HHmmruI1o2GVIRcKelg5PKPVdzsB2Cn0tiDhEt4ko/60M96lDWX9w36zp
         SU480GRLmkVkzzSKcqxSaKS88qZpy1o47CFxyY7ruziqLXFrP1vtpg+CXjPUuLWitp5F
         q0FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753864119; x=1754468919;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lOXsofV7d5Y1QpSZQsIBgp8cuSodqQc2mblmLGbM94w=;
        b=PJSeVIwucZ30awmjc73jWzTAzA3gi27Lbbh5L7aGjKZET7h8PFdxLRN0ytkz8jjliq
         DZgW2ecDI6Ap9ygxgDK2Wc0IjvIOdouJiBUG8unXkpTtekTl2SssUDcwqhBucMK6gXTb
         0z1s4ZtgxxQ5A06YcjKnCX0GLHvhXlE/h+NIuQ4WBZqu55MXnrc4vHZUCZYBAVpyzmzV
         ynQugY97lWtOolQqSLUm4PWjOybsL1P60nnekUKRllbkA0i7FgyLhrMvOu5NUcH105T2
         RZ9jup8IpmU83IWIy1Ybn6pN7FYaoKMfEhXGoWiBtrF9cpYRFR6esE0RyH8Ug+L2lac3
         4xzA==
X-Forwarded-Encrypted: i=1; AJvYcCVmqRdLAE/i6Ch6tIXkOvmH5iOK4jEwZOe0e5JE1wr3ilkexWrAriuDlUEs+TxbCq/c9cHiTlJSK5qi25c=@vger.kernel.org
X-Gm-Message-State: AOJu0YynSNJ4PR8aKgrV3xsY+ZJ1lOXDUpb7ZJKoWpMDjTt2qoebYXCZ
	Qi/MwyWXoJ3HXYs1cXSXImushGztG33JlqzGRxNzPsf2nMHc0XfSED1SkuEEcHUAeiZ3REnp9sS
	eATK9
X-Gm-Gg: ASbGncvWBjQ2CLVLxOJMVTGjgIsS1V+vtU/JW73m3CiBW9VXQK/3wvjr9q13VmdNhou
	QKKUUtrwmVuRNGCTW7wptsAGzCgUR9EMdUU4MZSnmyYVUhwI2sPlA6I10rLBORS9MJKz/bXGsIv
	7aowV/mRDvdmYmRnvWzG3POKY97ZMzfu9dkdHfeXCw09hDJnXeDE4Fhw/UgXtQGfCEfZLi2soC0
	GCFZW0jJ502u+uaiJPuCbCYXAwo69yKsptHlWg+Ffa5y+CZZCEnwQRkOGe+TNXuuOh/cehvDOAX
	tVKYto5pE/PMJNbAj6NB5ZHgoAzxB2xdJZn6on59kf602hUdcyg8Mm+Eo+uwZnjZtj7MzCBRDgQ
	2+B9zqV5gHEGfPWeFvfh86OoMODNxAnxebhnEXnBY2D6KbITQ
X-Google-Smtp-Source: AGHT+IHG9XCbSyvpKyHbL5s8I4UboMc3w6ID76nF1eFUwqG6ZVjNwX0+7ei9BR6ifR6BGxa85cRvvw==
X-Received: by 2002:a05:600c:1382:b0:455:f7b8:235c with SMTP id 5b1f17b1804b1-4589b00a4eamr8677265e9.14.1753864119339;
        Wed, 30 Jul 2025 01:28:39 -0700 (PDT)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4588d873f80sm41992125e9.0.2025.07.30.01.28.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 01:28:38 -0700 (PDT)
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: daniel.lezcano@linaro.org,
	tglx@linutronix.de
Cc: S32@nxp.com,
	linux-kernel@vger.kernel.org,
	ghennadi.procopciuc@oss.nxp.com
Subject: [PATCH v2 20/20] clocksource/drivers/nxp-pit: Add NXP Automotive s32g2 / s32g3 support
Date: Wed, 30 Jul 2025 10:27:22 +0200
Message-ID: <20250730082725.183133-21-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250730082725.183133-1-daniel.lezcano@linaro.org>
References: <20250730082725.183133-1-daniel.lezcano@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The previous changes put in place the encapsulation of the code in
order to allow multiple instances of the driver.

The S32G platform has two Periodic Interrupt Timer (PIT). The IP is
exactly the same as the VF platform.

Each PIT has four channels which are 32 bits wide and counting
down. The two first channels can be chained to implement a 64 bits
counter. The channel usage is kept unchanged with the original driver,
channel 2 is used as a clocksource, channel 3 is used as a
clockevent. Other channels are unused.

In order to support the S32G platform which has two PIT, we initialize
the timer and bind it to a CPU. The S32G platforms can have 2, 4 or 8
CPUs and this kind of configuration can appear unusual as we may endup
with two PIT used as a clockevent for the two first CPUs while the
other CPUs use the architected timers. However, in the context of the
automotive, the platform can be partioned to assign 2 CPUs for Linux
and the others CPUs to third party OS. The PIT is then used with their
specifities like the ability to freeze the time which is needed for
instance for debugging purpose.

The setup found for this platform is each timer instance is bound to
CPU0 and CPU1.

A counter is incremented when a timer is successfully initialized and
assigned to a CPU. This counter is used as an index for the CPU number
and to detect when we reach the maximum possible instances for the
platform. That in turn triggers the CPU hotplug callbacks to achieve
the per CPU setup. It is the exact same mechanism found in the NXP STM
driver.

If the timers must be bound to different CPUs, it would require an
additionnal mechanism which is not part of these changes.

Tested on a s32g274a-rdb2.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/timer-nxp-pit.c | 115 +++++++++++++++++++++++-----
 1 file changed, 97 insertions(+), 18 deletions(-)

diff --git a/drivers/clocksource/timer-nxp-pit.c b/drivers/clocksource/timer-nxp-pit.c
index 2a0ee4109ead..f2534172b9d4 100644
--- a/drivers/clocksource/timer-nxp-pit.c
+++ b/drivers/clocksource/timer-nxp-pit.c
@@ -1,14 +1,16 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright 2012-2013 Freescale Semiconductor, Inc.
+ * Copyright 2018,2021-2025 NXP
  */
-
 #include <linux/interrupt.h>
 #include <linux/clockchips.h>
+#include <linux/cpuhotplug.h>
 #include <linux/clk.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
 #include <linux/sched_clock.h>
+#include <linux/platform_device.h>
 
 /*
  * Each pit takes 0x10 Bytes register space
@@ -37,11 +39,23 @@
 struct pit_timer {
 	void __iomem *clksrc_base;
 	void __iomem *clkevt_base;
-	unsigned long cycle_per_jiffy;
 	struct clock_event_device ced;
 	struct clocksource cs;
+	int rate;
+};
+
+struct pit_timer_data {
+	int max_pit_instances;
 };
 
+static DEFINE_PER_CPU(struct pit_timer *, pit_timers);
+
+/*
+ * Global structure for multiple PITs initialization
+ */
+static int pit_instances;
+static int max_pit_instances = 1;
+
 static void __iomem *sched_clock_base;
 
 static inline struct pit_timer *ced_to_pit(struct clock_event_device *ced)
@@ -98,8 +112,8 @@ static u64 pit_timer_clocksource_read(struct clocksource *cs)
 	return (u64)~readl(PITCVAL(pit->clksrc_base));
 }
 
-static int __init pit_clocksource_init(struct pit_timer *pit, const char *name,
-				       void __iomem *base, unsigned long rate)
+static int pit_clocksource_init(struct pit_timer *pit, const char *name,
+				void __iomem *base, unsigned long rate)
 {
 	/*
 	 * The channels 0 and 1 can be chained to build a 64-bit
@@ -155,7 +169,7 @@ static int pit_set_periodic(struct clock_event_device *ced)
 {
 	struct pit_timer *pit = ced_to_pit(ced);
 
-	pit_set_next_event(pit->cycle_per_jiffy, ced);
+	pit_set_next_event(pit->rate / HZ, ced);
 
 	return 0;
 }
@@ -181,24 +195,28 @@ static irqreturn_t pit_timer_interrupt(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static int __init pit_clockevent_init(struct pit_timer *pit, const char *name,
-				      void __iomem *base, unsigned long rate,
-				      int irq, unsigned int cpu)
+static int pit_clockevent_per_cpu_init(struct pit_timer *pit, const char *name,
+				       void __iomem *base, unsigned long rate,
+				       int irq, unsigned int cpu)
 {
+	int ret;
+
 	/*
 	 * The channels 0 and 1 can be chained to build a 64-bit
 	 * timer. Let's use the channel 3 as a clockevent and leave
 	 * the channels 0 and 1 unused for anyone else who needs them
 	 */
 	pit->clkevt_base = base + PIT_CH(3);
-	pit->cycle_per_jiffy = rate / (HZ);
+	pit->rate = rate;
 
 	pit_timer_disable(pit->clkevt_base);
 
 	pit_timer_irqack(pit);
 
-	BUG_ON(request_irq(irq, pit_timer_interrupt, IRQF_TIMER | IRQF_IRQPOLL,
-			   name, &pit->ced));
+	ret = request_irq(irq, pit_timer_interrupt, IRQF_TIMER | IRQF_NOBALANCING,
+			  name, &pit->ced);
+	if (ret)
+		return ret;
 
 	pit->ced.cpumask = cpumask_of(cpu);
 	pit->ced.irq = irq;
@@ -210,6 +228,23 @@ static int __init pit_clockevent_init(struct pit_timer *pit, const char *name,
 	pit->ced.set_next_event	= pit_set_next_event;
 	pit->ced.rating	= 300;
 
+	per_cpu(pit_timers, cpu) = pit;
+
+	return 0;
+}
+
+static int pit_clockevent_starting_cpu(unsigned int cpu)
+{
+	struct pit_timer *pit = per_cpu(pit_timers, cpu);
+	int ret;
+
+	if (!pit)
+		return 0;
+
+	ret = irq_force_affinity(pit->ced.irq, cpumask_of(cpu));
+	if (ret)
+		return ret;
+
 	/*
 	 * The value for the LDVAL register trigger is calculated as:
 	 * LDVAL trigger = (period / clock period) - 1
@@ -218,12 +253,12 @@ static int __init pit_clockevent_init(struct pit_timer *pit, const char *name,
 	 * LDVAL trigger value is 1. And then the min_delta is
 	 * minimal LDVAL trigger value + 1, and the max_delta is full 32-bit.
 	 */
-	clockevents_config_and_register(&pit->ced, rate, 2, 0xffffffff);
+	clockevents_config_and_register(&pit->ced, pit->rate, 2, 0xffffffff);
 
 	return 0;
 }
 
-static int __init pit_timer_init(struct device_node *np)
+static int pit_timer_init(struct device_node *np)
 {
 	struct pit_timer *pit;
 	struct clk *pit_clk;
@@ -262,16 +297,31 @@ static int __init pit_timer_init(struct device_node *np)
 
 	clk_rate = clk_get_rate(pit_clk);
 
-	/* enable the pit module */
-	pit_module_enable(timer_base);
+	pit_module_disable(timer_base);
 
 	ret = pit_clocksource_init(pit, name, timer_base, clk_rate);
-	if (ret)
+	if (ret) {
+		pr_err("Failed to initialize clocksource '%pOF'\n", np);
 		goto out_pit_module_disable;
+	}
 
-	ret = pit_clockevent_init(pit, name, timer_base, clk_rate, irq, 0);
-	if (ret)
+	ret = pit_clockevent_per_cpu_init(pit, name, timer_base, clk_rate, irq, pit_instances);
+	if (ret) {
+		pr_err("Failed to initialize clockevent '%pOF'\n", np);
 		goto out_pit_clocksource_unregister;
+	}
+
+	/* enable the pit module */
+	pit_module_enable(timer_base);
+
+	pit_instances++;
+
+	if (pit_instances == max_pit_instances) {
+		ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "PIT timer:starting",
+					pit_clockevent_starting_cpu, NULL);
+		if (ret < 0)
+			goto out_pit_clocksource_unregister;
+	}
 
 	return 0;
 
@@ -289,4 +339,33 @@ static int __init pit_timer_init(struct device_node *np)
 
 	return ret;
 }
+
+static int pit_timer_probe(struct platform_device *pdev)
+{
+	const struct pit_timer_data *pit_timer_data;
+
+	pit_timer_data = of_device_get_match_data(&pdev->dev);
+	if (pit_timer_data)
+		max_pit_instances = pit_timer_data->max_pit_instances;
+
+	return pit_timer_init(pdev->dev.of_node);
+}
+
+static struct pit_timer_data s32g2_data = { .max_pit_instances = 2 };
+
+static const struct of_device_id pit_timer_of_match[] = {
+	{ .compatible = "nxp,s32g2-pit", .data = &s32g2_data },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, pit_timer_of_match);
+
+static struct platform_driver nxp_pit_driver = {
+	.driver = {
+		.name = "nxp-pit",
+		.of_match_table = pit_timer_of_match,
+	},
+	.probe = pit_timer_probe,
+};
+module_platform_driver(nxp_pit_driver);
+
 TIMER_OF_DECLARE(vf610, "fsl,vf610-pit", pit_timer_init);
-- 
2.43.0


