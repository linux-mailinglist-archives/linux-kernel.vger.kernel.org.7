Return-Path: <linux-kernel+bounces-755391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF974B1A5D3
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 17:24:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4AC16219F9
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 15:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BE7821882F;
	Mon,  4 Aug 2025 15:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="f1Ml/XY2"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3A8221DB6
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 15:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754321039; cv=none; b=DRU/2Z0Rk4P5iYe4J1CHY2OBput4S14bUy8+6DO/7St+PycK6tQY79Q9c3cy8A/Hlod63gJJiFgTk184ct4VNkMPZBbxcCz8lf1vUjdPGaazQ/DmIl8WnFD5Q8gkyVv1Flvl+IrNqLMXp2QeBWqewiCvrHspbTGYjY2r4BQSVkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754321039; c=relaxed/simple;
	bh=0KuB3AybAjcPPMcV1rgQ1SlzNiGtShCdSCBHySW+pEQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MFcvyvaS/qi3YKcTqt+/NOdgbMxqZLTcZI6b8w9xfX5/yttS1HQnMluyZZ67PbqWvluwwFBKGiiIg5qlpUWNRtYB2GRhjEnR8t9Zi94Sw49WqcA6SjJschHpb5WQusWPTTC6vRZrRpi8ftTVeaCSViG34tnEaMpzwG93+BBOToc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=f1Ml/XY2; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-45994a72356so12786525e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 08:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754321036; x=1754925836; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JX9UHWpArLRDJEf0tCoCLNi/F9HBfmQyxuSXNQbke7w=;
        b=f1Ml/XY2IhLGBamo1mvXVnDsGP5qIqS0cA/q5r3UHoAJWcOiewrRm3hpsArO17zU4j
         l/jVf3PP5HAbHeO5CPwgiy/Y/1tPnnMOWTbbtXYha/FVyQtnb/V73gSck0aX0zcFWvKz
         HMJfMUYIMq2MGKJ1tK9UG5GupRva34SmfKQpBe8FOVVTCx68y5DPfpKNKe7MW4zY16V/
         pCdQOKPNfI2GDwpAp4yLxShKZpfE3ubJRYLivLYdTG4iWIwntevt19lKWVjd8f+Dhq1J
         H924lav0BK//GBxof2eATmQeiRi/APmw2Afcdt9/jM/nLftpHw3hiLGh8SprD/aZi2dM
         wNcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754321036; x=1754925836;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JX9UHWpArLRDJEf0tCoCLNi/F9HBfmQyxuSXNQbke7w=;
        b=dV+XSocp2QXdCK7FVFoPhjBMdD2eOEgD5EVeHEVa1Erizod9RVYIP7CkMJnQcl9SMv
         F0Lfh5dXE4O3vu6cpj/eSOXg1uvCiWmoJ3Tl6y03OBa6qT3tcGj8JLvj4HV1tmLyWwwm
         pPf23Svam0VraQgtlfAciAE6A8udWybCGiCS34zFaox8BsIW7eX9F114lpGCvJ8smTDf
         Dd8tUV4uF72jd7xGFZkdBlhqa10YPCw2Az1LuGYlMSCzj+WkQnViuxbVGRc82CvBscUN
         ++5CuXs7CfYDiANGcpF7DHgpxafI6cbswrPnOQIGIzKzhKzhxlzNG+I80lFMm5W9Hm9p
         DO9A==
X-Forwarded-Encrypted: i=1; AJvYcCXsypwGwHpqwKuF/rvNLPB9QyX2LM11wJ9rGXMYw0PnFW23kfDcAVt+kqBaLcqnVgDcGThKsguP7UBb6tE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZ5qWCpWALHQQlk1P/MzbsLPie0gQLLFi1UQeZhlTNhJIV87N3
	zu9fl6Yg51GXxD1Gs/vepA1VQYpx5eUuLowB4qbqLAbvbrqViBrwtyxSup6+xJiVhrM=
X-Gm-Gg: ASbGnctx4jHNv3Z3jDrp6lbqJIh7RMXcZaym0auzj5pI7c4VdNh7Q0uiD0fQO81xrD2
	5IJySg382fFiBeDxrQ0y+VrIESZdkFxUe61+cJmdtyCO6UAsB4N4+vcA2jMxhdWJDm2/bDt9GbO
	ihQjSrAxPPdXtWsAiO4+qr7RbgLRGpYQROktVNYXMn+eUFMWjYVM4bnbxkE4ZHqHddNdxhKwo49
	fA6U0GKNLg6HxzMsCz4VW5PIEZeFfSZ2lELPNVLpA12Vwm0Z5vmmmdu4xtYZBqAWFhhDCIdqjTe
	vhbm8XdMj51/K/zZrD6j/Oq6raQTpdEPgcwBjnCrCQRYQZspGNc8n9NA8wEm4MAcekhucMS/BFz
	B1ZcURIuLLeGsJfriMHBiL6rMDu+y0WZkc3iPIaCYxT7M6WJK
X-Google-Smtp-Source: AGHT+IHBBm75qtH/5q49rzEs2X0rQ2Qe1eQuzRyWsZFIgX6JXKzK6/Uw83nQn5Mhhlqu8QIZ0WlEIw==
X-Received: by 2002:a05:600c:444d:b0:456:1157:59ac with SMTP id 5b1f17b1804b1-458b59ed217mr81147485e9.7.1754321036168;
        Mon, 04 Aug 2025 08:23:56 -0700 (PDT)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c4530b3sm16335579f8f.34.2025.08.04.08.23.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 08:23:55 -0700 (PDT)
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: daniel.lezcano@linaro.org,
	tglx@linutronix.de
Cc: S32@nxp.com,
	linux-kernel@vger.kernel.org,
	ghennadi.procopciuc@oss.nxp.com
Subject: [PATCH v3 04/20] clocksource/drivers/vf-pit: Rework the base address usage
Date: Mon,  4 Aug 2025 17:23:22 +0200
Message-ID: <20250804152344.1109310-5-daniel.lezcano@linaro.org>
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

This change passes the base address to the clockevent and clocksource
initialization functions in order to use different base address in the
next changes.

No functional changes intended.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/timer-vf-pit.c | 35 +++++++++++++++++++-----------
 1 file changed, 22 insertions(+), 13 deletions(-)

diff --git a/drivers/clocksource/timer-vf-pit.c b/drivers/clocksource/timer-vf-pit.c
index e4a8b32fff75..6a5f940ad0bc 100644
--- a/drivers/clocksource/timer-vf-pit.c
+++ b/drivers/clocksource/timer-vf-pit.c
@@ -66,8 +66,16 @@ static u64 notrace pit_read_sched_clock(void)
 	return ~readl(clksrc_base + PITCVAL);
 }
 
-static int __init pit_clocksource_init(struct pit_timer *pit, unsigned long rate)
+static int __init pit_clocksource_init(struct pit_timer *pit, void __iomem *base,
+				       unsigned long rate)
 {
+	/*
+	 * The channels 0 and 1 can be chained to build a 64-bit
+	 * timer. Let's use the channel 2 as a clocksource and leave
+	 * the channels 0 and 1 unused for anyone else who needs them
+	 */
+	pit->clksrc_base = base + PIT_CH(2);
+
 	/* set the max load value and start the clock source counter */
 	writel(0, pit->clksrc_base + PITTCTRL);
 	writel(~0, pit->clksrc_base + PITLDVAL);
@@ -76,8 +84,9 @@ static int __init pit_clocksource_init(struct pit_timer *pit, unsigned long rate
 	clksrc_base = pit->clksrc_base;
 
 	sched_clock_register(pit_read_sched_clock, 32, rate);
+
 	return clocksource_mmio_init(pit->clksrc_base + PITCVAL, "vf-pit", rate,
-			300, 32, clocksource_mmio_readl_down);
+				     300, 32, clocksource_mmio_readl_down);
 }
 
 static int pit_set_next_event(unsigned long delta, struct clock_event_device *ced)
@@ -137,8 +146,16 @@ static irqreturn_t pit_timer_interrupt(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static int __init pit_clockevent_init(struct pit_timer *pit, unsigned long rate, int irq)
+static int __init pit_clockevent_init(struct pit_timer *pit, void __iomem *base,
+				      unsigned long rate, int irq)
 {
+	/*
+	 * The channels 0 and 1 can be chained to build a 64-bit
+	 * timer. Let's use the channel 3 as a clockevent and leave
+	 * the channels 0 and 1 unused for anyone else who needs them
+	 */
+	pit->clkevt_base = base + PIT_CH(3);
+
 	writel(0, pit->clkevt_base + PITTCTRL);
 
 	writel(PITTFLG_TIF, pit->clkevt_base + PITTFLG);
@@ -182,14 +199,6 @@ static int __init pit_timer_init(struct device_node *np)
 		return -ENXIO;
 	}
 
-	/*
-	 * PIT0 and PIT1 can be chained to build a 64-bit timer,
-	 * so choose PIT2 as clocksource, PIT3 as clockevent device,
-	 * and leave PIT0 and PIT1 unused for anyone else who needs them.
-	 */
-	pit_timer.clksrc_base = timer_base + PIT_CH(2);
-	pit_timer.clkevt_base = timer_base + PIT_CH(3);
-
 	irq = irq_of_parse_and_map(np, 0);
 	if (irq <= 0)
 		return -EINVAL;
@@ -208,10 +217,10 @@ static int __init pit_timer_init(struct device_node *np)
 	/* enable the pit module */
 	writel(~PITMCR_MDIS, timer_base + PITMCR);
 
-	ret = pit_clocksource_init(&pit_timer, clk_rate);
+	ret = pit_clocksource_init(&pit_timer, timer_base, clk_rate);
 	if (ret)
 		return ret;
 
-	return pit_clockevent_init(&pit_timer, clk_rate, irq);
+	return pit_clockevent_init(&pit_timer, timer_base, clk_rate, irq);
 }
 TIMER_OF_DECLARE(vf610, "fsl,vf610-pit", pit_timer_init);
-- 
2.43.0


