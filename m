Return-Path: <linux-kernel+bounces-867753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F56DC036FB
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 22:51:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4296E4EB53F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 20:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38FAA2C15AE;
	Thu, 23 Oct 2025 20:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kwDf1OUY"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0805229D270
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 20:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761252658; cv=none; b=XXp3Ve65Wf6o7B/ZHTXxxCFJK5dK91EOuMB0QCEXG+vTSFOJzHVKLSvYtXQS1EteDpdPIIiBZ9Ar9hLkDPnJhTEcET1fjlNl/GcqEm51jVOoKV3636Yr7YgJdv5B82Tgk+6nwfFprNadUfgdDkvF8sAZaGwbAnH2ulvSvM59gTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761252658; c=relaxed/simple;
	bh=n8cqZMaXb4WTd1saP6x9nx7lED6lPw7jzNOTy2/I9Vo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=s0d7EgFSHUZ4Y1vM684HoEpMd4zeZiHYsvoTHdOEnk3NzdfHBU8+X34Dncv1aObp4Apqlu+r4tuwt9kV3FNJWFgJXSKerTcCKAXjJIh3l/Oz5KqKsXPyQAZrCdc4OnEn/5PklcPNF5kKGeKTmc1ag99jlIBD+3NOFs0Ak6fCn0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--willmcvicker.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kwDf1OUY; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--willmcvicker.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-780f914b5a4so1055062b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 13:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761252656; x=1761857456; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=salcdC7S6u/qcABB4HnnPaySmiqlvAFAzi3hyX+XJeI=;
        b=kwDf1OUYPNkz8oL4LMyG4VQpfc5KQXcY+4LunG+SoK+pftsTi78Mnppiv50quUNXt+
         DNj1VZ6hkRP06W98BQK0JAz4NxeUfKjv54xtIjG14H2nnOFBWy1Z2jSHuAYbGniNBK2u
         riFEemOtAckV1Evb06IM/U8IlXaEQNk0xmRK8WkDP55YnK5BuR7QgxdFjCzyOim8MZ6g
         7KGTI6IV3zVOP9XEBBq45jE+qKip+nZ70jEqJWvxtOtfV9fCep7gSE0JplI2DHY+Ug77
         jJiag0D98G90MiaRnDsY8jnC0ACK+DGQz0fAnGYfc/dWAEluZBISXXNmIn+yCVisIjKu
         fmaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761252656; x=1761857456;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=salcdC7S6u/qcABB4HnnPaySmiqlvAFAzi3hyX+XJeI=;
        b=PbQw3BGl5n6JPXG0spYVd5PAAN35EWA/IW8EoIEuwG96VEBNSGMromWYnCUcsjbwXT
         KDwkEXuSD+DQ94r/QSQ3FhDr3t6jSdcuMCSFBWluo1qc7swzhOpiocVcLd6vq0SPk/Fp
         /QzWYQCTcm+hNxL7Hsrp7Ar97YQ73fuU3ogg1JTGwimEXss/eJZzJPW4zJZyejheazno
         0vg/2wFRL7G0oeWx2bTk61mcFDXQwlueXwU5/PcrYRcgl3un5nlb/AGSLRgDFMbq7YEQ
         5fzBuEKRo4kpLfvpDhonX/dqFT63w9DT8BGURqdW9QOOVV0mRm9hDfq18oBhnZrXAR7T
         WNqg==
X-Forwarded-Encrypted: i=1; AJvYcCVUTwTnNpLnmdUw44meaBfUyC8Qtg9MY1YwxG57H1rykCG1GoUnW2ATWRbCA33avE791Gnf9U6+ry1/PKY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkNSdqYUWra0ZtRcUAhHLYlkS4sLsL483/WdnsYhaQ87B0X33l
	/UMy84gVXHSJlV+QFjO4GUMfDS6k9u09lgx05ckUJ45Rw96RZhFRZ2jr51Q7s7WSeehK4d7gAjz
	GP0EAQmj5PRMyhmqp+qVkzymZ6h72LA==
X-Google-Smtp-Source: AGHT+IETotZz5W0RAewxokNGtYUCB28DdEc6PiIk8ALIvsRgLEcx3podfH3b9UqPF76nl00xJnrSRtGNgN/gaeVnwNQ=
X-Received: from pjyq10.prod.google.com ([2002:a17:90a:e08a:b0:330:793a:2e77])
 (user=willmcvicker job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:a109:b0:334:a440:f244 with SMTP id adf61e73a8af0-334a8606ea3mr34560423637.36.1761252656337;
 Thu, 23 Oct 2025 13:50:56 -0700 (PDT)
Date: Thu, 23 Oct 2025 20:50:30 +0000
In-Reply-To: <20251023205041.2027336-1-willmcvicker@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251023205041.2027336-1-willmcvicker@google.com>
X-Mailer: git-send-email 2.51.1.821.gb6fe4d2222-goog
Message-ID: <20251023205041.2027336-5-willmcvicker@google.com>
Subject: [PATCH 4/7] clocksource/drivers/exynos_mct: Use percpu interrupts
 only on ARM64
From: Will McVicker <willmcvicker@google.com>
To: Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Krzysztof Kozlowski <krzk@kernel.org>, 
	Alim Akhtar <alim.akhtar@samsung.com>, Peter Griffin <peter.griffin@linaro.org>, 
	Ingo Molnar <mingo@kernel.org>, Youngmin Nam <youngmin.nam@samsung.com>, 
	Will McVicker <willmcvicker@google.com>, Hosung Kim <hosung0.kim@samsung.com>
Cc: Donghoon Yu <hoony.yu@samsung.com>, Rob Herring <robh@kernel.org>, 
	Saravana Kannan <saravanak@google.com>, John Stultz <jstultz@google.com>, 
	Tudor Ambarus <tudor.ambarus@linaro.org>, 
	"=?UTF-8?q?Andr=C3=A9=20Draszik?=" <andre.draszik@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, linux-samsung-soc@vger.kernel.org, 
	kernel-team@android.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"

From: Marek Szyprowski <m.szyprowski@samsung.com>

For some unknown reasons forcing percpu interrupts for local timers
breaks CPU hotplug for 'little' cores on legacy ARM 32bit Exynos based
machines (for example Exynos5422-based Odroid-XU3/XU4 boards). Use percpu
flag only when driver is compiled for newer ARM64 architecture.

Fixes: f3cec54ee3bf ("clocksource/drivers/exynos_mct: Set local timer interrupts as percpu")
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Reviewed-by: Peter Griffin <peter.griffin@linaro.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/clocksource/exynos_mct.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clocksource/exynos_mct.c b/drivers/clocksource/exynos_mct.c
index a5ef7d64b1c2..1429b9d03a58 100644
--- a/drivers/clocksource/exynos_mct.c
+++ b/drivers/clocksource/exynos_mct.c
@@ -597,7 +597,8 @@ static int __init exynos4_timer_interrupts(struct device_node *np,
 			if (request_irq(mct_irq,
 					exynos4_mct_tick_isr,
 					IRQF_TIMER | IRQF_NOBALANCING |
-					IRQF_PERCPU,
+					(IS_ENABLED(CONFIG_ARM64) ?
+					 IRQF_PERCPU : 0),
 					pcpu_mevt->name, pcpu_mevt)) {
 				pr_err("exynos-mct: cannot register IRQ (cpu%d)\n",
 									cpu);
-- 
2.51.1.821.gb6fe4d2222-goog


