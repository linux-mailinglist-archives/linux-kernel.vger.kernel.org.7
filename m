Return-Path: <linux-kernel+bounces-755399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A01BB1A5DE
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 17:26:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BDAB17AEECD
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 15:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 568FF274B51;
	Mon,  4 Aug 2025 15:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C91Th1ps"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E767B2749CA
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 15:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754321048; cv=none; b=HRbEkn2KdVLgahVavjr9NLkTiLKvfGRgO8nrg7OwW+S4XA214ONNkDjoJdHocAfGUqbmDeq9paN7SxZP1AjHxE6tGCYuIOSQGhjOb8eGw30Ul5kgIBwaBTTap4oFunkbF12qre1ZDoqoL6lLEWEaXRYvoXveH9dPyoi0Knkyv7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754321048; c=relaxed/simple;
	bh=4Vq6f8GD2mA4WRyWaYsGXrIFn7Q9er+rg8/kSAhjspw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OU4Xfyc5yWwdzhp3lE5wNXpjFq2BhjcLc3aUoEKTTcEx4AnpUtOTktvMVTsvmZVMBwOhl9fCj4TMcvFSF4/Qty5SXbR72i8SSV6wh4Ovc+DQf0sEZ3n2cJNcg3wf6R93gzzqhJqR3qzYnVJ9DUarq3IYyAcFzPisbzylM2tPlZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=C91Th1ps; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4561ed868b5so29987755e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 08:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754321045; x=1754925845; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z+cH/sZvNKu0NSHCUkuHwC3VCEIw4lvAIUfnj3iQdiM=;
        b=C91Th1ps7mt7vrDL8qaUk6IF0oFF1QvkA2XSMRJhDDyRTNXv4f02LqPw2XW0CpkTwF
         A+l1mr93NQSUbdR6D/huzYDcl1vA7gWzM8a/U3yMN72ChgtWNFLNV9vgzU93fgqvdNrq
         QjUaBoydRGTgmsNH+RwyFf+6nfasN94lUGVOJy1HQmGYbbbLLeYzabRG8yji+LrPcWxE
         TNtnTzCwhbJukYrl82RN0Y60pTN1tvQQiLGpnCyC0R/V0QYw+ESgetpY7L/P2LVuuDF2
         mmW9sO5PubzGXz4aqECYsv9bQfo9syM5VVgy8TTRBn0ENvdB14u9fikVeBNiJBVI7HyB
         77Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754321045; x=1754925845;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z+cH/sZvNKu0NSHCUkuHwC3VCEIw4lvAIUfnj3iQdiM=;
        b=DGg5UOk10q1MHYNuaR/KP+8arViobNJKlTR45SqfzxCNEcQ++Q22ijGn5BsN3+1YV8
         M6v6YzDElF+sp5UE39DRjzXqX8AWn9NjCgksxjb21pNolnbYYj+2X4E69H4KwFpYdKpb
         UK3YPLbxySDFqsXaAI/vE9N5NsR1RII9qyJzUQR/ZwRXUZ0fCADsrzQxMq5S9CMh34BP
         Y6mbJ+bm01vvPKlkwiTKFx3yY+d+YdMlZRPlGBo08Inx0ar5Lv7N9JixXAkmhaAIAe6q
         VfPMWAZeRQJUQmm4xEFp4ZVpin9bHKZ1y7N56xVym602dRzpvqChmIrl2T4i1I12miD7
         dbYQ==
X-Forwarded-Encrypted: i=1; AJvYcCW7/VRtiPQ1u0VGBFWoC3dhe0MFyig9MsJGVKdD8xr1P8/DUTtq1FWPZ4J07tpvEbDfV4B8RXDKlPMEM0c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yww33vtS+1eFTmCTtdc/o7RZE1/l5YbdqxFqIuKquoaTKF3eHz6
	iC/rSK2ZshdnkAYQGGNEEStzf6DgqtkoxViCy10/HYTEOEDVOuU9fZAJnN0JqxpNlIw=
X-Gm-Gg: ASbGncui3c/Mq2g0KmBfno+QTatMN+WquMB1vLBH0cOxCB/dhm85z8EmihpcUGTKk/z
	6D5QPZoeU/qaK0pUt+/kv4SBFsMjMaXRrhNfYp28mdx45YHQnotxW4arUXoIwuugeI8jk94M+7y
	uKTDNv23X23BjqMpFefajPJdOfTHLM5QP37dr0BdTEzHMii2ihNNmWAUm/d6+QzfAUZQz5GuWWT
	9S6yCgMgFqXiGeLJiuebBi+eYtE4TVtlim9VfH7LwpvET8uASZcDFnZ0nU94LK1oKoZs1AH4Gm0
	2CrRSammD72cUFX7aeUsNd6sJIuw6MIoO2EqUBwFjDY/eCbp5CNLhdQGvfN+J+MZhgT2pez5foH
	LbemTtZKaMRuCVMp+Pz09SEFTXj+boKJyfmqsoR3ubvjCTIxHAlENmgLyqlQ=
X-Google-Smtp-Source: AGHT+IGGClohuwM4eZZNeboHrsguQadNJzvZGAgcOeVJ9FpE3p0p5SKfrNu6L3Y9/q0vSA4jhgxvJw==
X-Received: by 2002:a05:6000:401f:b0:3b7:9b4d:70e9 with SMTP id ffacd0b85a97d-3b8d94c1058mr6446338f8f.43.1754321045280;
        Mon, 04 Aug 2025 08:24:05 -0700 (PDT)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c4530b3sm16335579f8f.34.2025.08.04.08.24.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 08:24:04 -0700 (PDT)
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: daniel.lezcano@linaro.org,
	tglx@linutronix.de
Cc: S32@nxp.com,
	linux-kernel@vger.kernel.org,
	ghennadi.procopciuc@oss.nxp.com
Subject: [PATCH v3 12/20] clocksource/drivers/vf-pit: Use the node name for the interrupt and timer names
Date: Mon,  4 Aug 2025 17:23:30 +0200
Message-ID: <20250804152344.1109310-13-daniel.lezcano@linaro.org>
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

In order to differentiate from userspace the pit timer given the
device tree, let's use the node name for the interrupt and the timer
names.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/timer-vf-pit.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/clocksource/timer-vf-pit.c b/drivers/clocksource/timer-vf-pit.c
index 4f1b85ba5de3..2a255b45561d 100644
--- a/drivers/clocksource/timer-vf-pit.c
+++ b/drivers/clocksource/timer-vf-pit.c
@@ -79,8 +79,8 @@ static u64 pit_timer_clocksource_read(struct clocksource *cs)
 	return (u64)~readl(PITCVAL(pit->clksrc_base));
 }
 
-static int __init pit_clocksource_init(struct pit_timer *pit, void __iomem *base,
-				       unsigned long rate)
+static int __init pit_clocksource_init(struct pit_timer *pit, const char *name,
+				       void __iomem *base, unsigned long rate)
 {
 	/*
 	 * The channels 0 and 1 can be chained to build a 64-bit
@@ -88,7 +88,7 @@ static int __init pit_clocksource_init(struct pit_timer *pit, void __iomem *base
 	 * the channels 0 and 1 unused for anyone else who needs them
 	 */
 	pit->clksrc_base = base + PIT_CH(2);
-	pit->cs.name = "vf-pit";
+	pit->cs.name = name;
 	pit->cs.rating = 300;
 	pit->cs.read = pit_timer_clocksource_read;
 	pit->cs.mask = CLOCKSOURCE_MASK(32);
@@ -162,8 +162,9 @@ static irqreturn_t pit_timer_interrupt(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static int __init pit_clockevent_init(struct pit_timer *pit, void __iomem *base,
-				      unsigned long rate, int irq, unsigned int cpu)
+static int __init pit_clockevent_init(struct pit_timer *pit, const char *name,
+				      void __iomem *base, unsigned long rate,
+				      int irq, unsigned int cpu)
 {
 	/*
 	 * The channels 0 and 1 can be chained to build a 64-bit
@@ -178,12 +179,12 @@ static int __init pit_clockevent_init(struct pit_timer *pit, void __iomem *base,
 	pit_irq_acknowledge(pit);
 
 	BUG_ON(request_irq(irq, pit_timer_interrupt, IRQF_TIMER | IRQF_IRQPOLL,
-			   "VF pit timer", &pit->ced));
+			   name, &pit->ced));
 
 	pit->ced.cpumask = cpumask_of(cpu);
 	pit->ced.irq = irq;
 
-	pit->ced.name = "VF pit timer";
+	pit->ced.name = name;
 	pit->ced.features = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT;
 	pit->ced.set_state_shutdown = pit_shutdown;
 	pit->ced.set_state_periodic = pit_set_periodic;
@@ -208,6 +209,7 @@ static int __init pit_timer_init(struct device_node *np)
 	struct pit_timer *pit;
 	struct clk *pit_clk;
 	void __iomem *timer_base;
+	const char *name = of_node_full_name(np);
 	unsigned long clk_rate;
 	int irq, ret;
 
@@ -244,11 +246,11 @@ static int __init pit_timer_init(struct device_node *np)
 	/* enable the pit module */
 	writel(~PITMCR_MDIS, timer_base + PITMCR);
 
-	ret = pit_clocksource_init(pit, timer_base, clk_rate);
+	ret = pit_clocksource_init(pit, name, timer_base, clk_rate);
 	if (ret)
 		goto out_disable_unprepare;
 
-	ret = pit_clockevent_init(pit, timer_base, clk_rate, irq, 0);
+	ret = pit_clockevent_init(pit, name, timer_base, clk_rate, irq, 0);
 	if (ret)
 		goto out_pit_clocksource_unregister;
 
-- 
2.43.0


