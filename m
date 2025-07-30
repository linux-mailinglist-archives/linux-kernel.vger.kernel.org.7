Return-Path: <linux-kernel+bounces-750367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54EE5B15A91
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 10:29:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B609A7AACE0
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 08:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F1BF295523;
	Wed, 30 Jul 2025 08:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wqEIliuW"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03658293C45
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 08:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753864110; cv=none; b=Rrw96CgjAOcJuEcMcdn9t3nqVti6jCjSoklQH/4tP+vAL3eFJDAHvgiunkrULp+gP9EBjSox/I/j7Mt6Mz02LYlwOd3I0G1hxGMsXbYUK1VayI5w+ntJ5xNF66wpimsZ+Cqto9qRASmr/06ML1Xs1LtHwmo48H6j5gfo0+OrEX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753864110; c=relaxed/simple;
	bh=GfQzwNUl/+3omCCkQkujjBdEzx8xgVxwbwy3bH02h/E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i6WwJznz9WQf0RMZGrd6R/HFYgLWu9cCzoh9GYlYhz45LcwCPo1PfQVlJAbR+8kKJIl1pju03YNh1s+qbTJ0UifkVOSsPi78WrtSrzsu3kI5IT277G6aElWIVu+0/0ps/G+RJTT0Ec/LvHHSV5BHcoxgzkOxJQKnJ/mVFjq1yS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wqEIliuW; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3b783d851e6so3424794f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 01:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753864107; x=1754468907; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Kg1N7IKrT0Nex/PfaqDl7XqOb3/89XK53bW16WuXbM=;
        b=wqEIliuWzNSeU+r4jzEJqsqDFF6cHta1sBN9yc5G2PJn8tGTnH1+rQOLTV3ldaPiZt
         Hg27kqJJ06tjJLD5j/VfQL4srSDeLa5dMWHq38URMjIExC+IwBHC2G5Q2O+qn5mhklgp
         do7oGXSifk2EYKygpphpTB2JC5BDUKCezPzN9d/Z1oCbz+YxRHG1ERktnJj0QJ9bduiT
         q0U4xpPHNxX7phYpj6G6Y7c4e8Q3Tz+pEpewfw9FVdgEYiI6KKEkuf3zm5X15dm1Wez2
         uPOGS0bQJuZsgqbR7mI+KKK+IvNRHQmQ75m72e9UgJyz17DmJrEjPdQDXG++jzonWOdt
         xBGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753864107; x=1754468907;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8Kg1N7IKrT0Nex/PfaqDl7XqOb3/89XK53bW16WuXbM=;
        b=k8MK/02GrkI46ySgQsx9Sfiws+fWm0Yh35gP2D06ej/DFQsxF+ATYytodD3ZGWdY9P
         M+8ZBx5s2M8GzocWTfn4H/kB2FNRcxvdI4FSfsWV/phFgZKgf1VniY1jqsEwv+QnbaNi
         HrPekQHyxzhw4g4da1GvEOdellPNe68ix0/0wpPn95psE9SKeM7QQH4xK90pro95uiRe
         paEgLGzzRBl9oskzI3vgg8nDoyMuEA1RCYXrYRc/VKHPFKSYB0nLurLIl0hHZOUQUJCL
         0cEPJJqc/kxFDDgSxdsh35cV4ogYJDqmGR//2SFOkWCdvoJDRfBoWB7nSuAAhg0mdWu8
         qdzQ==
X-Forwarded-Encrypted: i=1; AJvYcCUmCp7LuAaETceqH7fV/UL+V8rbgtawJ6xkAE9mr9/VlGOs0XDrjT6hxmjBylso4CXVgZyVB+KITRcqCns=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWqCo6mE7iPH3gYCEHxZQYhif38WTZmX6B/iS1lrVHh+mnrwXz
	q16bhuea24bi1ovOIi155L22XDGouukGr3bSdY3wXYxj8IUiKK63ELNxOozotUmIhsw=
X-Gm-Gg: ASbGncugwFDeGK0gae/5d4W18kvXx9szffnTm25eGO+77SpaD8de60ekf4ckR+X72rK
	NBChJxcRlTuPZPKZkuhseEQVFwwP3Gjmf/8ZnwZDwMgkHMB0xOdh6YH+ohzw2M7KlcGwpkUCQG1
	63yXBuPkjCRc90rAZ1dl/ba3d0e/8rw5Mvk/rgHhPOZuIiN4gpSe6Oh0xe0AOsXEpqOncXObYLV
	SQkP3semtuqhO20FMQ4fBNIO9INVkb3b7wGGMhCxPWKDbgLAq11eAsVIIGaj22/d59Max19Wo10
	ffqzVH8sK6vX+S1Kt4S/gTfYdbBXiEioLs0ffS5YlzSRMOHg9pSDh6gg+6M93vWu2GcRR18B2yC
	zY/1CZxMzAnwsxME74tztIxJZ0RPIeVaUBSeDKYpfMdLlqsod
X-Google-Smtp-Source: AGHT+IGfrV1oS65LoHrjnQuwVg/JWvOsiypKJwdoZ5rsfC7kAm0dtOTzXRqOWgsRdhfqwug+YacotA==
X-Received: by 2002:a05:6000:238a:b0:3a4:e480:b5df with SMTP id ffacd0b85a97d-3b79500efd4mr2117066f8f.44.1753864107412;
        Wed, 30 Jul 2025 01:28:27 -0700 (PDT)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4588d873f80sm41992125e9.0.2025.07.30.01.28.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 01:28:26 -0700 (PDT)
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: daniel.lezcano@linaro.org,
	tglx@linutronix.de
Cc: S32@nxp.com,
	linux-kernel@vger.kernel.org,
	ghennadi.procopciuc@oss.nxp.com
Subject: [PATCH v2 09/20] clocksource/drivers/vf-pit: Register the clocksource from the driver
Date: Wed, 30 Jul 2025 10:27:11 +0200
Message-ID: <20250730082725.183133-10-daniel.lezcano@linaro.org>
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

The function clocksource_mmio_init() uses its own global static
clocksource variable making no possible to have several instances of a
clocksource using this function. In order to support that, let's add
the clocksource structure to the pit structure and use the
clocksource_register_hz() function instead.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/timer-vf-pit.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/clocksource/timer-vf-pit.c b/drivers/clocksource/timer-vf-pit.c
index d1aec6aaeb02..6a4043801eeb 100644
--- a/drivers/clocksource/timer-vf-pit.c
+++ b/drivers/clocksource/timer-vf-pit.c
@@ -44,6 +44,11 @@ static inline struct pit_timer *ced_to_pit(struct clock_event_device *ced)
 	return container_of(ced, struct pit_timer, ced);
 }
 
+static inline struct pit_timer *cs_to_pit(struct clocksource *cs)
+{
+	return container_of(cs, struct pit_timer, cs);
+}
+
 static inline void pit_timer_enable(struct pit_timer *pit)
 {
 	writel(PITTCTRL_TEN | PITTCTRL_TIE, pit->clkevt_base + PITTCTRL);
@@ -64,6 +69,13 @@ static u64 notrace pit_read_sched_clock(void)
 	return ~readl(clksrc_base + PITCVAL);
 }
 
+static u64 pit_timer_clocksource_read(struct clocksource *cs)
+{
+	struct pit_timer *pit = cs_to_pit(cs);
+
+	return (u64)~readl(pit->clksrc_base + PITCVAL);
+}
+
 static int __init pit_clocksource_init(struct pit_timer *pit, void __iomem *base,
 				       unsigned long rate)
 {
@@ -73,6 +85,11 @@ static int __init pit_clocksource_init(struct pit_timer *pit, void __iomem *base
 	 * the channels 0 and 1 unused for anyone else who needs them
 	 */
 	pit->clksrc_base = base + PIT_CH(2);
+	pit->cs.name = "vf-pit";
+	pit->cs.rating = 300;
+	pit->cs.read = pit_timer_clocksource_read;
+	pit->cs.mask = CLOCKSOURCE_MASK(32);
+	pit->cs.flags = CLOCK_SOURCE_IS_CONTINUOUS;
 
 	/* set the max load value and start the clock source counter */
 	writel(0, pit->clksrc_base + PITTCTRL);
@@ -83,8 +100,7 @@ static int __init pit_clocksource_init(struct pit_timer *pit, void __iomem *base
 
 	sched_clock_register(pit_read_sched_clock, 32, rate);
 
-	return clocksource_mmio_init(pit->clksrc_base + PITCVAL, "vf-pit", rate,
-				     300, 32, clocksource_mmio_readl_down);
+	return clocksource_register_hz(&pit->cs, rate);
 }
 
 static int pit_set_next_event(unsigned long delta, struct clock_event_device *ced)
-- 
2.43.0


