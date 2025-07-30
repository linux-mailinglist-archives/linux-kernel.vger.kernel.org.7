Return-Path: <linux-kernel+bounces-750370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8D53B15A97
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 10:30:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F2145A2EE4
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 08:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5A5E29826A;
	Wed, 30 Jul 2025 08:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SkaZMaOz"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C8C0295D99
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 08:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753864114; cv=none; b=AsHd+B7IzGTxmPx1xg6SSLnnp6/xxWYpA9s0K8Lfse1U/OT6SXvGCeqBS47j4HznLG+kAiWCx3HVEkQ9jIs3B5iZtTGHRv0ZC4HImNBf6dXsJhPuLGRK87U7ckUeYu7g+6Am2cAiYfuCUtlBMezkPRiZr+Bp94giSXvOPar+pL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753864114; c=relaxed/simple;
	bh=4Vq6f8GD2mA4WRyWaYsGXrIFn7Q9er+rg8/kSAhjspw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c8MVIbh7G8edlZHnbF4uyI3eTIcI6pMaD5deXm3BjpI4+A4QozF/3gmkIpa8w7FPS5ePIeq23V8oB2m4tu/qQ+6agExcyoCvNiwLjDKBTp0SDuI/cbP1oANq22IyiN79CBc4E5ZQlrjcAeoXDZZwXGUPAVhyG6Nnl/vEyA/qalU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SkaZMaOz; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4589b3e3820so1594355e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 01:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753864110; x=1754468910; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z+cH/sZvNKu0NSHCUkuHwC3VCEIw4lvAIUfnj3iQdiM=;
        b=SkaZMaOzVycuAgS/BE7US2i99GoqbF+BW2XgNJvuEcvrxKFsC6pc3y2A76Jamqi+GG
         CUsTkb/ihefgFbopHk0f4Nf1U/ylddcgh3M6iX9r1djypKk8Y2Zagjiaol4cI2OgCsI3
         suuPufHy0nwCDlNJHv0a8/1Ec0KeNrgexpOiSPEYJSHHdRhO3TFy1VuBRYWJlfnZiOck
         8IKzHlMHO2V0sQiUviECfTF7gjvEWyxyK+/UjOP0vwm62YF81oo1gXGqZc7YoI+lawPD
         cavBoCCRrnatZ/TcRG+rs67CeIHtfSyg8gr5sZ4bEP0M0h43lsz+a8HWNSyY4/WkqcpV
         +DcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753864110; x=1754468910;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z+cH/sZvNKu0NSHCUkuHwC3VCEIw4lvAIUfnj3iQdiM=;
        b=nmwqdggKPXAJnPkv6XZmXSH4nBCb/svgr2fRUCB4lo3McDwtczdObkZNouq/ov8Z2G
         PCHaLxoJnULr0ueQ/yLvR/sCSq+pcp6ye8PQj9LeI6zQEpc64wnNXYvMI3g1qiVNiREO
         49zK+QzNCBl96iaPHqI3q99i2olYf/Zde9lI/0cutNgoMymkg7BT4/VMviL9/4ueBusG
         KDbNnjTIxko7ze6d362r9BXlievE/oNqtKaV+WTxx9+dRhwEe/QKJJzv0fkSU3zO9FoL
         wwm+kkUOfC//m5xgi3jHXI1KMh4rZ3FxnweEj0+b0HUEu73iPCBMGtKBmu1sc1IOZRhI
         Zcxg==
X-Forwarded-Encrypted: i=1; AJvYcCUskSDZ6ybpUNIK95snCz+GYbWTEXNlhUXOBfTpjJvZFB4XC52bWyhMlLu5uFlURHniDOSMAgYNnQ7MQy4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxm8jupEK+ohSvCx3bFSXZMxOoYfKskjKm+BbXszI8VLx0zC7J0
	BRacPulb3CErX2U6G/3S0FOV7LXtBfwj/7eX3xve9TeVg+TNKWQ6OYfwTSuMjNfllLc=
X-Gm-Gg: ASbGncv+sZ1UPGnDzvxsEP9Cw9dWi9T5nuNiVntKr2EQeyf5nKi98WsvsEjUwrlIjPb
	yUn2R8TJo0vLSgnLd5poYKpYsDrw9UtmQCNXU96oH1BH/Etj2/VS0OlZBgfLn7Klog5md9Jjvse
	/qHeZPtQrkeLmUKfi49G+A8QSedSom6eNVtftCkHmD/h6ACp2oYtP+pXeJPwkn6vqAJ/51yNbxG
	6fvbZO7FcqKi0EuO/+bf2pgnrQe5+xoImLvy7KR7FtebeIG/5mizOVaZoynn6LQuAKFuyw3daTc
	d6tjF4Ku86vphA8CdNdKGpZumXEp59EuWXnHnJrwUDkLQJnjxINIECFTwa5UOOLB172bQw5GNah
	7fq1DY6uhICSo1q5e8t7tBHGfL+WR6uSqperi9NRiajHXbpif
X-Google-Smtp-Source: AGHT+IFAA2gbjRUbN0adAOIR9Mpd8ZnNGawaNBqTp+YArdxKhSHaw+ZZftaQ7hqdUHT8V2PM9P8XyQ==
X-Received: by 2002:a05:600c:4e4b:b0:442:e9eb:cba2 with SMTP id 5b1f17b1804b1-45892b2ff51mr27014865e9.0.1753864110481;
        Wed, 30 Jul 2025 01:28:30 -0700 (PDT)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4588d873f80sm41992125e9.0.2025.07.30.01.28.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 01:28:30 -0700 (PDT)
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: daniel.lezcano@linaro.org,
	tglx@linutronix.de
Cc: S32@nxp.com,
	linux-kernel@vger.kernel.org,
	ghennadi.procopciuc@oss.nxp.com
Subject: [PATCH v2 12/20] clocksource/drivers/vf-pit: Use the node name for the interrupt and timer names
Date: Wed, 30 Jul 2025 10:27:14 +0200
Message-ID: <20250730082725.183133-13-daniel.lezcano@linaro.org>
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


