Return-Path: <linux-kernel+bounces-755402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65FD0B1A5E2
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 17:26:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82E4D175B8B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 15:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A39D2275AEB;
	Mon,  4 Aug 2025 15:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZJZLomdB"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 669A0273D6D
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 15:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754321052; cv=none; b=YuQDUkt+y+SYNar603JymwLqfyR10O5m1O5lalkF4DO/Xl1Nbh/m+nBtb655IMNVSnVHpMyPt4b5PKONsRyhqFMBgC7qbZCUo5pDc3fC/rGmDMq2PadkDxQTZmi9t1wWZ8slKq5kphPvqCfk/P3Ce1KKU6Ks9YxuTOtXle607DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754321052; c=relaxed/simple;
	bh=ZQF+EVPqcx9QLRXKTr1LjG0h/R3IyHQPuhVCVCcAuO0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aL2399/a/4fpGrCC7YdQXOMtVZf8YG8kVd5Ajf3K75AVuV94gu+x+lt2SBKe4KZtGe/NvuNeDHsJLmFiKIt3b7WHxsbMvgC7NorMaOYqH7ta3tyumSXz1TsvL/2gUpjMgcM0/IQHHxZtixG9Uhq6TAlHf/c3P0LivR78pWZ+Llw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZJZLomdB; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3b783ea502eso3473758f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 08:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754321049; x=1754925849; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TbVaJyUO7GiEiEqdQljEO7vQiGP467HVmO08HdyjiFo=;
        b=ZJZLomdBESzUkef4PmvP0BofUqRmHsIRA/wE2Wgdyxu4NniSvvk7nf3wUYeC8rs8nF
         hFBVg8dwWkVUpZVwuIz57e8INRlV9qQyZfn+wg2Jg5Fb7QUtkBTSH8ud0V8TtuUiZJMH
         kEHC9yqZyQBOSHUqH/+PWXGm+somQOVdFnQ9xdQPfVSHLTXn8oe/IpU54nvPaZPJPtM7
         u8uuuUk55OmugfsBIjcl+VJC9FuZC6ENJZ8F+T6mJLj5Hmkg19SA4W1RAFIOisy8hkL5
         FyLJZeviDfVQhJBVwcsIhQFwA5EelaHKzrmfAgNIGgVErYh3+qNHMjkY0eSuD3YV5kCA
         N7Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754321049; x=1754925849;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TbVaJyUO7GiEiEqdQljEO7vQiGP467HVmO08HdyjiFo=;
        b=mLUY9w1K+UCRSVonHTFn8LsCcq1URAdoWUklFRXeRS7p3koy67EY8AD2fyLLMcBMHc
         VmShOKVCZGiRXm2swmzBSpezWfCPPI8xSB3QqliYbkYzMRDz+Petnre6FLfTqBjdg4LO
         E9bcw9Y/Qsz8z1beIPa9XAaIw2Wa+xx/0SU7qBkx5TSSErofxHIAdAI8ngR5uUcKteSQ
         R6PH6eXCA4cx4zf5Onzt8S1jwuQUp07GEVmADEyzGkYzBVaS6wR/J4BY3sfrm9NB1qve
         in05NX6Pu/Wz9gzWWMy4Mgq3eHXL2vbnN1Am+xNqK+kLtsiqH/0G+y4H9++yKOnhB/og
         eF1Q==
X-Forwarded-Encrypted: i=1; AJvYcCWz1RjMReNnT7vYn4tELwsSL6YxFTK02P7n2qYh4IJVEh9llwqyKPr4Sqq5lZdRfXGmKBbUHMf7f02MmvA=@vger.kernel.org
X-Gm-Message-State: AOJu0YytIYeso2GCetbKafxjXpt9+/NGEHWFjpLem+OkYggDMWdiQOP5
	IztnxBHj6PAbAQGRxftZ8o+r90VP0Hq1fWjcDJ9kh6DyH4EY4XdOdeUjwVtpVWSd/a8=
X-Gm-Gg: ASbGncswbnJ59C6XLpH3r0dPuNJ3t/aZGDJDlhJifOEn418di/gh7IgBSyLliHS+5O8
	1P8IU0aSJgzU21NaDg2ysl0HUJoctvhaLIxt1Olhdwo4Ui4qaNpgmtquEAQEKvLSi1GmjXr6fjd
	BYZQFyzsgu6HxLPFmGe4j21ESFqosYhfK4FiZSAnAKM61FfVrSooqzC4tsqJDll1VZSLEARV7XM
	P7hNpJO+O0dqAja9MoaftDI1KUBxRiSx2+s69xBSmMkoxF339GUn7LrDwN5GG5M/QCAymXxlfro
	p50HaXTunjb+pfY4peq7ccAkLYRCGNZXL+gJrYjGDjqu4lNy12jHK1lQRtmxqkz9793kzEmIWuB
	o1s8GlVsq0fB84WWSKygDkPSwNaSbeXn4cLUYhGJag5hy4yJPGKBo4PnOxSI=
X-Google-Smtp-Source: AGHT+IFd0H5wUKE2CqwTEY+Ymp/L1RtxUK98szZDSTTw1G0toLs97LvobwJthRM7hQELBF1NlxYolg==
X-Received: by 2002:a05:6000:2f85:b0:3b8:d8d1:1e72 with SMTP id ffacd0b85a97d-3b8d95a4250mr7256538f8f.19.1754321048822;
        Mon, 04 Aug 2025 08:24:08 -0700 (PDT)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c4530b3sm16335579f8f.34.2025.08.04.08.24.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 08:24:08 -0700 (PDT)
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: daniel.lezcano@linaro.org,
	tglx@linutronix.de
Cc: S32@nxp.com,
	linux-kernel@vger.kernel.org,
	ghennadi.procopciuc@oss.nxp.com
Subject: [PATCH v3 15/20] clocksource/drivers/vf-pit: Encapsulate set counter function
Date: Mon,  4 Aug 2025 17:23:33 +0200
Message-ID: <20250804152344.1109310-16-daniel.lezcano@linaro.org>
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

Encapsulate the writel() calls to set the counter into a
self-explainatory function.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/timer-vf-pit.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/clocksource/timer-vf-pit.c b/drivers/clocksource/timer-vf-pit.c
index 609a4d9deb64..5551b61483f8 100644
--- a/drivers/clocksource/timer-vf-pit.c
+++ b/drivers/clocksource/timer-vf-pit.c
@@ -74,6 +74,11 @@ static inline void pit_timer_disable(struct pit_timer *pit)
 	writel(0, PITTCTRL(pit->clkevt_base));
 }
 
+static inline void pit_timer_set_counter(void __iomem *base, unsigned int cnt)
+{
+	writel(cnt, PITLDVAL(base));
+}
+
 static inline void pit_clocksource_enable(struct pit_timer *pit)
 {
 	writel(PITTCTRL_TEN, PITTCTRL(pit->clksrc_base));
@@ -118,7 +123,7 @@ static int __init pit_clocksource_init(struct pit_timer *pit, const char *name,
 
 	/* set the max load value and start the clock source counter */
 	pit_clocksource_disable(pit);
-	writel(~0, PITLDVAL(pit->clksrc_base));
+	pit_timer_set_counter(pit->clksrc_base, ~0);
 	pit_clocksource_enable(pit);
 
 	sched_clock_base = pit->clksrc_base + PITCVAL_OFFSET;
@@ -139,7 +144,7 @@ static int pit_set_next_event(unsigned long delta, struct clock_event_device *ce
 	 * hardware requirement.
 	 */
 	pit_timer_disable(pit);
-	writel(delta - 1, PITLDVAL(pit->clkevt_base));
+	pit_timer_set_counter(pit->clkevt_base, delta - 1);
 	pit_timer_enable(pit);
 
 	return 0;
-- 
2.43.0


