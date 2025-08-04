Return-Path: <linux-kernel+bounces-755403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF88DB1A5E4
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 17:27:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5673E3ACAED
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 15:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0B66277020;
	Mon,  4 Aug 2025 15:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Qow4Wy3R"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 977AC275AE7
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 15:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754321054; cv=none; b=nwE8C4xqYS4Job5hTYPr/qb5l0EshEmdo9cocRo9D3OhojQFTjRLsTgEWyXwBujWzSbQ52umJRdSPtCpOMm76uUxATy/SQYGwY9+on94a81tbPpl7Or9mfGgOSdrTS5a9aNsRgSmnDt0f81i73a/WlQzz0sZkpgm2KleGgPZY8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754321054; c=relaxed/simple;
	bh=4wUMG106laRuIHpbrM4t5F3/jxrsablQ7YM7IMrfxTg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BlG8o5x1A4CEQiE+MbfXp8l6n6gtUb7wVMNZi2CZDRR+TCyox1wIGj75V8kBbvzd7ryacW/3jEDAupQVJqYvQ6Tbk2epzqK+th3w/iXozqqk+IFtgFaDUt6vHlZ7UFgKrtscuJHO81IvS2z9uiG2Avgy0y6TF6o1d1PcqJf+l0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Qow4Wy3R; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3b8db5e9b35so1580091f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 08:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754321051; x=1754925851; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gdWn//c212Ti3HpbT8pEOaw/we9iaNvG2SciGLwX7ak=;
        b=Qow4Wy3RPsXA8Jn74NfPM/znYrdb7BvOVULs1Z8GdWsdYn1cmkpcFWWT840B+qpXGu
         QLKT2D3Ln1EOXZzAcRSfpc5o711Kyj8xTn/cOq8SmuHubFH5V5shnqIa647Isze/VoBh
         oNPD/JuWzv9xYvM9a6Ba2JpRk/F/dMhfvZubEnu9mGrtDhEQJee8cwuaMmzR+qgBG7d9
         BqJ3gCwNynyZ85f4763qbOsnD1gFN0dg9AF2DVD1lzm63M+wOjSac8ZN7x7BdOW0yDe0
         0tF2n+SA90l40rU7/TEnPfnSO4uZ4ggTABG0yP4BHb7+xlCpxyNW9ZvL2H8NHtHYk0LO
         4SGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754321051; x=1754925851;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gdWn//c212Ti3HpbT8pEOaw/we9iaNvG2SciGLwX7ak=;
        b=fkgiAvudfXzB8Oag7ICxAM4fyZBNFqqK7VqYAP/Y+SGR91dgWSo+e4ZB1APNEQ9a71
         ayHvUdhb8KR4W11VnGIF7kIXIWibzKAPkt5BjFr73QqtH1IX72Akwme2j9uw7Pfi51Ls
         8wN8fRLxvoH8Mlk5dO8ZnlkDIXYyOc4icxQDsXVzo6znK91BeA7Zgj7kF7gjjswV0lFm
         v5K/svHbFbgt2eKP4RZ7t2uv5yF96w3YhLUtsba9Ua7hNTO5vUhfUupC8vDbdMSiuxIo
         i8VIhQfqrj3XBpJKypf16cRxPCncpwEqZFu9DHs+VfI0z6kNn3ZAax+oRK19pQuCmdC2
         eI2w==
X-Forwarded-Encrypted: i=1; AJvYcCXgK5pTfnAzSGXn4FaQ0Vv5TcS2zkqiNulB7LYEhOs2DwLfpkAl7u8Y5EZulKCFKY5DHKlW4jGbXHuPNtI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVR/j/IaOAqPwDmCQdMkLjSrJj4XZmsp02Pfhha4roO/URtfOM
	p3USxwiVtbbvhlGnwVzcjWIwqQRG5kcBsCSFO+jhqevw5bXM7sDumbnN90R5VZVU1iQ=
X-Gm-Gg: ASbGncu9MzsIUdKxsriuWyteUr3ruelyfWnCXOoTrBwRfQJq8UPSv7ib9BCVcGc+Y+P
	hORE4gdw6NgpKb2j8gLk29ABc8peyV60iVccSq1DxjIV3rWHJfb+jU1OiBioqH7e/uucTL663TT
	KW1mjbneYUekurEgfW4uLOPCSlR8rgAByfRASgC/+PMOX68Tv23sNfEMyHPW0J+MIBcGyL1xrO/
	7B3aqBVPD6DXXpIW+ajYjJEqxATK3Qn+JghsrA9RFyEGCW1RCSr9vmUv9W6BoZMTQAUQiUlbZGP
	UMzVrqCkNvCAZfA4QVRIdOkpz3ubsx63erbpDCnr6rcsjDAKyCBLXvq0ny06ySHGCqU1YLwN2qi
	f6lZATjHWts+IwQDnQKfCbAlDZRNC0GOfDNq4IuADIuMKUMja4769wmwAxGY=
X-Google-Smtp-Source: AGHT+IH5f+9LZNBrPQYkYXLRM0ZOVndeywyqyYYPF/dMlXp+s0WJGrfW5CLFB6uOvk9rzZsgIP5Fww==
X-Received: by 2002:a05:6000:2303:b0:3b7:911c:83f with SMTP id ffacd0b85a97d-3b8d9469a23mr7183871f8f.9.1754321050876;
        Mon, 04 Aug 2025 08:24:10 -0700 (PDT)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c4530b3sm16335579f8f.34.2025.08.04.08.24.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 08:24:10 -0700 (PDT)
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: daniel.lezcano@linaro.org,
	tglx@linutronix.de
Cc: S32@nxp.com,
	linux-kernel@vger.kernel.org,
	ghennadi.procopciuc@oss.nxp.com
Subject: [PATCH v3 17/20] clocksource/drivers/vf-pit: Unify the function name for irq ack
Date: Mon,  4 Aug 2025 17:23:35 +0200
Message-ID: <20250804152344.1109310-18-daniel.lezcano@linaro.org>
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

Most the function are under the form pit_timer_*, let's change the
interrupt acknowledgment function name to have the same format.

No functional changes intended.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/timer-vf-pit.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clocksource/timer-vf-pit.c b/drivers/clocksource/timer-vf-pit.c
index 3825159a0ca7..2a0ee4109ead 100644
--- a/drivers/clocksource/timer-vf-pit.c
+++ b/drivers/clocksource/timer-vf-pit.c
@@ -81,7 +81,7 @@ static inline void pit_timer_set_counter(void __iomem *base, unsigned int cnt)
 	writel(cnt, PITLDVAL(base));
 }
 
-static inline void pit_irq_acknowledge(struct pit_timer *pit)
+static inline void pit_timer_irqack(struct pit_timer *pit)
 {
 	writel(PITTFLG_TIF, PITTFLG(pit->clkevt_base));
 }
@@ -165,7 +165,7 @@ static irqreturn_t pit_timer_interrupt(int irq, void *dev_id)
 	struct clock_event_device *ced = dev_id;
 	struct pit_timer *pit = ced_to_pit(ced);
 
-	pit_irq_acknowledge(pit);
+	pit_timer_irqack(pit);
 
 	/*
 	 * pit hardware doesn't support oneshot, it will generate an interrupt
@@ -195,7 +195,7 @@ static int __init pit_clockevent_init(struct pit_timer *pit, const char *name,
 
 	pit_timer_disable(pit->clkevt_base);
 
-	pit_irq_acknowledge(pit);
+	pit_timer_irqack(pit);
 
 	BUG_ON(request_irq(irq, pit_timer_interrupt, IRQF_TIMER | IRQF_IRQPOLL,
 			   name, &pit->ced));
-- 
2.43.0


