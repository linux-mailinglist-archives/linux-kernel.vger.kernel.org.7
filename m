Return-Path: <linux-kernel+bounces-755407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AFF9B1A5ED
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 17:28:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEE2918A1C61
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 15:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC82C279327;
	Mon,  4 Aug 2025 15:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R4qPIAul"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1891277C9A
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 15:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754321059; cv=none; b=ObW9bzct5I97/KlyJO6YHZCnCf38qeBCLI+K9dRv3i9i6QppDl9gjrtwSlZTGNeBKIf3nMWH3CLX/X+gyNVjil3sDKsSjJSRhVplp7w3oRa9xpXcu7Y4EG114J6ODUjajVcrfUDkA7KYZ4nokg3zso2qAxsL8sY2Q1Ac2CAiqJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754321059; c=relaxed/simple;
	bh=SxSdDuOd/saSwqxbdaTkThxkcFHiMlCdeoHVKc1v12g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lsnck81ZbUyT4c5Hiy/JASSa4Z0/IaWYmPrEN5gsz/Q5tWK61KfMsrK2zkQTXITddGcoDC5j61p1niQklJA8cvvXNgMwZSSHL+iH4zJTH+c4uUgfh/3Mfk3Uu6+XaLfw4g/JginLESr2dXKTCxgX23J9oqSWXpebOJ3XHSNzi38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=R4qPIAul; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3b78294a233so3600646f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 08:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754321054; x=1754925854; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Tni21YLH9b+7e/VOhKpLNMRnejjKTgmzrSKVqGkVtM=;
        b=R4qPIAulVLhI6t4kwhCaX1oRmaNH2iSl5Jzg/NYX+6lKER++82a9gHDEqzZP7cZDkb
         VcYKBGRi1DeJxeCckcQ49nF/mHKjcmhEg6ZfPqvhgH56NbGEbBs95aarQKiwfz156gv7
         au+ENo9qLckUmInWV+aPHIuywGwNjiwFiYAszBzL7yPvhajS9ulEOCRtBUn92A9ILM7W
         76I0SMm3RsVJLRwQmFjJxo2+o03m/c+SSns5A+huvOK9Hn6tar+coOtLYnBK2k39j8yl
         UTBuLWU1SSyGtZCRyVyGlMJw3fHM8y4wRFSGrZXRM8HYjBpM/7bJ5nQAoG9G+CMM18cw
         cRzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754321054; x=1754925854;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9Tni21YLH9b+7e/VOhKpLNMRnejjKTgmzrSKVqGkVtM=;
        b=Gm7cqVamaAsbVodiDAChSXUR2ZfhK629veul7/DKMpAt9M6xedRsl3QwnmvznRmSjo
         swYIV4pAFkupqmbfhgiwI5Ci1j0rFWgTskE5z14++cTBgGWzXjRiAh9rwMFtSdcULZdq
         8zFGhF9kbFOTE+YVA9HVGC1J4x2NKofcVVs3jihQFk74/yr3Mf0pdrKoTm4bJj95JWgg
         Y2n7HOsliKG4bW0S7Vl9a3baguexprjYcaDbP6mZmuM+nsmiUzCrGHUdeWmy/rN+YY8Z
         K+akAGwkhxVs9Ah24ExTdDFvZCZcy6NkJ1cdXyxZgSK3hpoZ4tT7/AORxiHuoizY08Dm
         bulQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1PXf6MaRafKfdKDhTXdIzDUj24e1XRyrjymdQ8PsK41M5u8a9gyvxdWuJ+SN+cvpNpafCaqhmHyX+DX0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyx3b8eD6yUFMGQAjjv87BQwjC3I4wWjkGLNPvnZZ60mQVaR+I+
	jK5f0UpJPUIlddkAT/O83iwePcte8lT14K9NdAfIA9D2boedmeNuRL08cfaO+iRzZB8=
X-Gm-Gg: ASbGncupMORu1nyacw3CAeZMnnQ9bTtB2FSUb3fLyzKE0IPBqFJ+xau0qrIjqGCrCRG
	fgggPrQOO03mzpHfARyESZadYqkAoGdULbc/+YAjCHpO6FJ8y9C60QZzeKLv7N9Uc036LxrUjqO
	r8LqzKvwUIfXTRAMiredAGLNG3r7vFIPHPMn2c5YHG65v/MTGhu9Bp6fJqXh6xCa1jfvftPxMOG
	F3ldjfHBrVnTVSyNMxveA7W5Wvl7SvBfeOQfg7RVq6M6Bftq+5edvmdTmNMfS/AGd6QLN54PnrB
	rE9leH/YTWrnYhw2PI32Od1C/+2eEUkGKpA4mcYIrrM/8Anq8SGqIrUO50zdIeJ37px6VCTb6FK
	6P72WmD/dNrvS4V2vajJl5Apf4S3XIHmCJlZVRd21cjcMBSwH
X-Google-Smtp-Source: AGHT+IGdQDf3AGGIIQma73kvQFrp2lXLoGChUyWc5yEILcqzb6RWnGKTCRdlJagG2NMmvWU7piCXAQ==
X-Received: by 2002:a05:6000:420d:b0:3b7:8af8:b91d with SMTP id ffacd0b85a97d-3b8d94bb49amr7783554f8f.35.1754321054032;
        Mon, 04 Aug 2025 08:24:14 -0700 (PDT)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c4530b3sm16335579f8f.34.2025.08.04.08.24.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 08:24:13 -0700 (PDT)
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: daniel.lezcano@linaro.org,
	tglx@linutronix.de
Cc: S32@nxp.com,
	linux-kernel@vger.kernel.org,
	ghennadi.procopciuc@oss.nxp.com
Subject: [PATCH v3 20/20] clocksource/drivers/nxp-pit: Add NXP Automotive s32g2 / s32g3 support
Date: Mon,  4 Aug 2025 17:23:38 +0200
Message-ID: <20250804152344.1109310-21-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250804152344.1109310-1-daniel.lezcano@linaro.org>
References: <20250804152344.1109310-1-daniel.lezcano@linaro.org>
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
 drivers/clocksource/timer-nxp-pit.c | 128 +++++++++++++++++++++++-----
 1 file changed, 109 insertions(+), 19 deletions(-)

diff --git a/drivers/clocksource/timer-nxp-pit.c b/drivers/clocksource/timer-nxp-pit.c
index 2a0ee4109ead..2d0a3554b6bf 100644
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
@@ -210,6 +228,32 @@ static int __init pit_clockevent_init(struct pit_timer *pit, const char *name,
 	pit->ced.set_next_event	= pit_set_next_event;
 	pit->ced.rating	= 300;
 
+	per_cpu(pit_timers, cpu) = pit;
+
+	return 0;
+}
+
+static void pit_clockevent_per_cpu_exit(struct pit_timer *pit, unsigned int cpu)
+{
+	pit_timer_disable(pit->clkevt_base);
+	free_irq(pit->ced.irq, &pit->ced);
+	per_cpu(pit_timers, cpu) = NULL;
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
+	if (ret) {
+		pit_clockevent_per_cpu_exit(pit, cpu);
+		return ret;
+	}
+
 	/*
 	 * The value for the LDVAL register trigger is calculated as:
 	 * LDVAL trigger = (period / clock period) - 1
@@ -218,12 +262,12 @@ static int __init pit_clockevent_init(struct pit_timer *pit, const char *name,
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
@@ -253,7 +297,7 @@ static int __init pit_timer_init(struct device_node *np)
 	pit_clk = of_clk_get(np, 0);
 	if (IS_ERR(pit_clk)) {
 		ret = PTR_ERR(pit_clk);
-		goto out_iounmap;
+		goto out_irq_dispose_mapping;
 	}
 
 	ret = clk_prepare_enable(pit_clk);
@@ -262,16 +306,31 @@ static int __init pit_timer_init(struct device_node *np)
 
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
 
@@ -282,6 +341,8 @@ static int __init pit_timer_init(struct device_node *np)
 	clk_disable_unprepare(pit_clk);
 out_clk_put:
 	clk_put(pit_clk);
+out_irq_dispose_mapping:
+	irq_dispose_mapping(irq);
 out_iounmap:
 	iounmap(timer_base);
 out_kfree:
@@ -289,4 +350,33 @@ static int __init pit_timer_init(struct device_node *np)
 
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


