Return-Path: <linux-kernel+bounces-750362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 78CE8B15A8D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 10:29:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A175218A66FB
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 08:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB2AC292B40;
	Wed, 30 Jul 2025 08:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zdWi2ZKU"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C291269817
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 08:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753864106; cv=none; b=K3TpE2ac37UE54yu4/5OEkrcqLtoqdhr2VptNN9s9dE3lLzzXxqAArea6vUROJMmSoCBWLspVZe56fazQM/D/k0QPxSbI/2WjVnNw6hJL8IUUHtZqnOp55y9aUMaQc+aIi8tIijQ9l4u5kvGZBHgkpy2V9/1EEzw/8fwZwwkJkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753864106; c=relaxed/simple;
	bh=0KuB3AybAjcPPMcV1rgQ1SlzNiGtShCdSCBHySW+pEQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cjRj7WV4GD+0YKtpzpsBoyByBn0IRR6smX67cH8ywZvIGQkE2pqxJGwBxUnKlTP1goo5DbAwViCMipPxFs/xKVuhyqvacjONY204dDBLYaWkKhdWbAqlNT3hO5fUQo/ISTn7bklkR2vpYNCDaOgvFBJmtnb5nH6VKMZlSlZHBdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zdWi2ZKU; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4563bc166a5so3342325e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 01:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753864102; x=1754468902; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JX9UHWpArLRDJEf0tCoCLNi/F9HBfmQyxuSXNQbke7w=;
        b=zdWi2ZKURIUr17j7AKfWZ5Z2vvMareaDf8NyOa26arblVaZXXik4xnC5QSzP/TijZj
         r6nnievBIexXzMQuJ+sAdzvnH7ShFNm1Oy6lR/Xgs6WCGjLT6kT9OfND3aiYlfH1RBS1
         bwciyfkXUZKL557QpofxQykfU9R8GZ6/+uXItVgbBHvPa2VLOdwSChcwswlKqnCOKDjL
         CN7z66PQR7bK3pi/f/CS69soSsScLLXOGvsHB8rNcSNyaQZrDLf+fV6xJ22C/GGApMT3
         wunsq6OCmuhbRNksb9Fs+oDrMsDtjvwfcYoLzbXw2QEbZvdDTJSLxcqcmmuPFiTcVUHy
         G8bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753864102; x=1754468902;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JX9UHWpArLRDJEf0tCoCLNi/F9HBfmQyxuSXNQbke7w=;
        b=pO78aKWfhk3Dzikh92NCQOnTOsH1+hqr8N8TpfOt7+l/L05NtJvUKqo5YhKIjHrWbj
         G0KKXa2a9/5cI0pfG14UEF1TZCoqbDUWgnHTiQecDEeRimNuyLUnuAghqxCD6nbmoWTz
         qFw5wIk3AXrb70DjnPIXrQSDIT1dJmLNyiQmtPuq5UKJeOCq44qzxheiptwR8Jpwl1K0
         gZhsg+1xQmIVO7geGou6lj1K9F/h3xj/kf30sEZF7l9QvEHQ4hIi0v/EeAVQUHAkDdfh
         xo8FTv7bXSy3V9apHPrBgJJ4V7ilFBWd5YC2Jf56GxSz4EHFq3uyuLKHKCuvnAoNDb7M
         u4oA==
X-Forwarded-Encrypted: i=1; AJvYcCVuJivsEQBMi/h/uwbfaGesp2s2OmZx/V1UYIbSWxVPW7kRc01nSFSnjho8dMJkMfPIRUfY5arv41zL4TU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+NPtNvPpinqrpYS1Q4gx5jH/YXbjsamqVEJqLBkqJnfgpG5mL
	Eub3UWE/vRs4cRKsOpNwCjsq+AaiyPNEpUm5s2PVsa6BWzF5r6bJlaAdNaGT5kOIpO928kmQWey
	LrMH/
X-Gm-Gg: ASbGncvHXHQjIK/KJDT2nSOuSYvpqbfehF7jtBaahdEats9I3x62PV/HpBoVAROJIHK
	xnRj+KtGetHZqhfVmL6q/92b30lm10KVisXSRZ8apm1tFoexWZ9vMrpY0TfiHLtAEKmf5DhVU/x
	/tPGOfDg1ACQYjEAzKgXlUAIZpBJeiOI2p1kr6JnRzHOOZA/NVfMSi1mfL1mLMMvG31nMEAcCkB
	YMZXu2DCdf2qaxrCdN5XbSxsXQB214qy+Erc951XbRXBbT8HNhDAu1Q9Y6il/8NI9Sj005YEWlj
	U+LZVmmacWwiFJFyZWtcrjHqFpGBgueocUTupiRZtmWlt+jBmyKwaeggWM0eNKh5xmGxzMUTjH+
	JuijbpeytNgJOSa9hzyTkVDU6l2sSQi8+FwpVSai26UZUkFkY
X-Google-Smtp-Source: AGHT+IEr4sIbEOQoJpsXhVryaTC6uW1YJY65yaNu6Py0k/3v8802CxrvIhlmPRM5HG4Qkbk0h4fWag==
X-Received: by 2002:a05:600c:3213:b0:458:6f13:aa4a with SMTP id 5b1f17b1804b1-4588d1364c0mr36778095e9.6.1753864102479;
        Wed, 30 Jul 2025 01:28:22 -0700 (PDT)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4588d873f80sm41992125e9.0.2025.07.30.01.28.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 01:28:22 -0700 (PDT)
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: daniel.lezcano@linaro.org,
	tglx@linutronix.de
Cc: S32@nxp.com,
	linux-kernel@vger.kernel.org,
	ghennadi.procopciuc@oss.nxp.com
Subject: [PATCH v2 04/20] clocksource/drivers/vf-pit: Rework the base address usage
Date: Wed, 30 Jul 2025 10:27:06 +0200
Message-ID: <20250730082725.183133-5-daniel.lezcano@linaro.org>
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


