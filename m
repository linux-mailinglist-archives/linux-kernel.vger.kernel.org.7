Return-Path: <linux-kernel+bounces-750376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C418B15A9F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 10:32:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9490C562E96
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 08:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E20AA29AB10;
	Wed, 30 Jul 2025 08:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uKhB59BG"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550A129A30D
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 08:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753864121; cv=none; b=Ud/Y13eQ/iVh8JfrlkY0/tnJxkd19cePsNWqE6OV2C+20Ym/U5qd14PkDk6ZKbQNWkEqlXJR1Zj9X1li7Nfo2SYoup1uevdlF+o3vNhZgLq0237jKg/WHUgYdip+/GiSA8nUm/bA1w0fABlRTLRPa7PdMM59QcUlS3NliOzRJPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753864121; c=relaxed/simple;
	bh=en/OY3XLqc1O//ZVLEZYulnfPivo0Zt69dJ8GP35/bU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L+DdtH9FXadlknARQPLyCwv276v29OjUUkIxy24ildLFLdfa6QOcI0l5q8r6sEYXl7gkKQc8nC1SM5uK/qs7JExfkfEQ1NH5DsBmojZIdzERXS52Tkm3bvMrzZi/MLcLrTiBfHa4ayQ9EHFnTh0+hZDB7jd50Sp79JLsOqOGfI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uKhB59BG; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-455b00339c8so40996285e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 01:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753864116; x=1754468916; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Qf9GWiTx8t5XpstrbrV7wRgtkdmLHoze8ER6REIaJw=;
        b=uKhB59BG0zzYj0HO8GH2Rqq0bFFI15EI10sdt7p9PONPwJDkZ7ofWt/pixSWWOzF6j
         KdfNW+bjHTiKnJEXaU3VJ+aPdhceCMrwqRG8QyypBGu4CjpxtXsBNljwHcBGkeWQVJwS
         UObVxWoILJmvX0GC3/VD7PTBY6S+N0mwTr9hLsl2yO1MhsHkKR6T1B3pPXntwplMfUF6
         X2C3MI1DjNTFFVPuM38mTXscqkv20N4rjkZvmUO0TJupJR8/aRXkLRXwd+FRtrRyZf63
         Q9w4o8AUPT5fAF4M2FiRRvyJwAAmY4ngvTVi4Ul9q1XubVM6b1s/ezQIrZ/BqJtmzRG/
         0mjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753864116; x=1754468916;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/Qf9GWiTx8t5XpstrbrV7wRgtkdmLHoze8ER6REIaJw=;
        b=Ogn0V0Fec+eFyGqygPo47Riie4GdggIEJMFz/6k6QuXJksS2UskbuD2zHoLYDJDr/P
         IT/sYdxfpK6+smh3tf0MabqD4Nrms+zCyeioJA3x+4tseqnQp2LYZcbGEt39vd/LPtQP
         pR1vLuGdYYuAlwzDXY4X8m3WCttvKzRoJHK+7KXvZfJQNn5CgcUgiySr269imYBh6Gvn
         /4OiLH8TRzAfrSGg3a+VnUTnM2HAKA9oIxAbMA+hrL4NMv1qQnbgdz61Jl31lUiO6GBg
         kE1IijRre6RKobBTCsB7ZGU5q5omyGCHid4+6W5feQ/d1zFL8JSgXANeGnv13VCQ3cs7
         hZOw==
X-Forwarded-Encrypted: i=1; AJvYcCU6xITxTYZ6sb6uJOChLlMaLV7wgZJm9fQDWgVxYkfEhogrlUMjHpopadfuFlbXkeCVGaht1I94j6qIF6Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKF6yX9WyQGE1M5g+gMr/pNWJBvU7XtPA5QmmDm33F30UAeLhI
	PoZyfI5aPqvoNU69uWOusvy3yE6ktVwahVaU3SWkYerfeEeuSI3bT6QZULxuYgT3lwx25qeWqGh
	Ymtza
X-Gm-Gg: ASbGncvUxrayg/uklMwTUMUjlS+3+Q/z8maRfKBMPG4x0thAXOtY/GOQfEtGLWO0ctB
	S7hPYVhnAaAtjVZbBa1UF1F0PuOGtmOLBz9+KyMvPqBit+II0paOmg670pouy5Qzi8tD0YN3xIr
	wkg/8ypqH8jtq1AE+1QhdBNcP6w3nNkZ1J+rb73auAefRwFZ5DYZy75PN2yjU2Lzg0Mc0+X8J8S
	sPLZbMenNTNJkONxiF2bJeqEy6As3hBYruBpmLjFHf3c8TqFvwevkdElgqtDk0SdoQV8oCdawGR
	bzDKpcUiFwoVYKkM06rmd+qHIwbZCzN95j1vQHznPfpzUfc6MHIkmKPW3uXMDiTlLS014RwwzyE
	whAV/2PHFuOA4UZHRZTvmFPFdw7QEiYvGMe6NVLKiAmjc2C6g
X-Google-Smtp-Source: AGHT+IF0P4NjR58gS3i3Eahg/S4gOnvIX2fG9O6KEAH8KgU9JNvL/AVfYxeeaH/j7enBOMruDsq88Q==
X-Received: by 2002:a05:600c:4685:b0:43d:563:6fef with SMTP id 5b1f17b1804b1-45892bbf51bmr19874105e9.21.1753864115719;
        Wed, 30 Jul 2025 01:28:35 -0700 (PDT)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4588d873f80sm41992125e9.0.2025.07.30.01.28.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 01:28:35 -0700 (PDT)
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: daniel.lezcano@linaro.org,
	tglx@linutronix.de
Cc: S32@nxp.com,
	linux-kernel@vger.kernel.org,
	ghennadi.procopciuc@oss.nxp.com
Subject: [PATCH v2 17/20] clocksource/drivers/vf-pit: Unify the function name for irq ack
Date: Wed, 30 Jul 2025 10:27:19 +0200
Message-ID: <20250730082725.183133-18-daniel.lezcano@linaro.org>
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

Most the function are under the form pit_timer_*, let's change the
interrupt acknowledgement function name to have the same format.

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


