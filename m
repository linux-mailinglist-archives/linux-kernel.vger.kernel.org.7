Return-Path: <linux-kernel+bounces-867764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A5E5C0373D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 22:54:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 67951566C31
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 20:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27E05299A8A;
	Thu, 23 Oct 2025 20:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yBV2Tw/v"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E73F23BF8F
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 20:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761252788; cv=none; b=KySRukyfRfJLJY0E3TGctqRcyVDF2l6ZvNiDvcE0KnTJR9c7nJy04r+JL2ru4WPb/6Vpx2AJueyei3x0bTQNQ9rgtVZ0NLdO+PNRqjcMFotzsjNsHWPPXTRn0ZJHfxLOLk5IGYRJozEGm2AEEGpLmZZpSbkFKYlST1/poX8RCwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761252788; c=relaxed/simple;
	bh=2OVYsiaEALq8X/jeb/e/72PKIxNOL2+WIgOo7aBNVYU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jax2wLVpNNiwTG0VEa3LuKfmSXuBWbwczhxJBR2m6KZh9qAAj//WTDNEuSnhEkhLuL8Et4FfS4kJyhTb6nG8cXiVMxbvPA5XTEI5oPybEHWtETX3SAcylCYmGptCO/5BCC8RyJdsIU24kF2sgS6QsAlLGTGuU/5WOyExR3aF7No=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--willmcvicker.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yBV2Tw/v; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--willmcvicker.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-336b646768eso1330033a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 13:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761252785; x=1761857585; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nOlNjzKGrmabtYpeYty40nfBQK9A/mPHc8f9qhi2ylg=;
        b=yBV2Tw/vzcH6yAbKfyYONLU77dQp5VlaNoqUQCJcWpseDX5Wn6jzayn/xvvg9JNxFi
         20U+VbLFK4LRLaxPH8pRoB1W8TEfFC+9XJ6JW0HnMnvyH16apzzc5/N+tC3n0L5rMMfV
         Xkk1/RT31z9Pc6oiGq2v8nytw8v4WMj+/2jkl5XrMBScF986yFIhPlN98mjf/A9uMxVB
         8Piwni9MPjptHFlbxB3PtwfBk4Nmj5Daay+f15HdT0suO+tjJ5fXN6mNV46zidrw9RL5
         oPFHbVAFinjO+eWmSChIXalxhYePRBvpb3hRqgT48C9Ve5W6ooZ4wku8aMDaHrjlOMT/
         3FBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761252785; x=1761857585;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nOlNjzKGrmabtYpeYty40nfBQK9A/mPHc8f9qhi2ylg=;
        b=k/jyFJkR8x+CLSPGU/TJD+eJ496kl8sPywjypOHRAhFBFQv2/JP0CooOKmRLytH84Y
         VLTsCh2elw38XfYaIBcP1PL3he3YtHpyBIJZTxgl5fAifHt8MdyELs0d4JMqys3Vyprn
         k14M+eH+Bxp4DoMsZygWVY8V6uXwz0//sHikJlAX5LyVIfOBv+FdU29FsE0DrJdVqKp9
         IpF0CcoAo80B2tAzmEPOfpe6qSCB5TPDmlaR9IXvXSOyVGrYu3BLt71Ai2EN5ijebRNa
         /k+e0q55DviutlfhEJQ7tNs1QCUv2xAsrSNPN3IfcTOuK+lOP3NdvJhibNpDsmJv0Iw/
         d7Fw==
X-Forwarded-Encrypted: i=1; AJvYcCXGTIyo9FLe9K2gBxJbeqVS1b4o3S7D5FpfF5M5R3FcfkeT5oYY2rXrIhsTgfLBJdfVqyrdotkBJW7/OQc=@vger.kernel.org
X-Gm-Message-State: AOJu0YytmUZb5Dv2lGKSh1LiSxQInAYfyt2eFW4q3YL8hZZMVgCvZ6oq
	/sfhw3snGmJ6JtcLPUHSZkYVimBp2sqqyK1rmiOGA72uiWOMw9BG036Eu1XbvgVuOvyHNGtXIjH
	+bvBGfHQi3YXXWsa9pmYxLX9G1cdzeQ==
X-Google-Smtp-Source: AGHT+IFP81I1iyalJE6aYdlbb3aYFaFBB5LVK9Iwi6HZICalmHAgswwkY0DX0NqFtFW5Im4RHwVUP8KP+TPcn7qo9cA=
X-Received: from pjxx4.prod.google.com ([2002:a17:90b:58c4:b0:33d:98cb:883b])
 (user=willmcvicker job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90a:c2c3:b0:327:f216:4360 with SMTP id 98e67ed59e1d1-33bcf853706mr35210162a91.8.1761252785336;
 Thu, 23 Oct 2025 13:53:05 -0700 (PDT)
Date: Thu, 23 Oct 2025 20:52:44 +0000
In-Reply-To: <20251023205257.2029526-1-willmcvicker@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251023205257.2029526-1-willmcvicker@google.com>
X-Mailer: git-send-email 2.51.1.821.gb6fe4d2222-goog
Message-ID: <20251023205257.2029526-3-willmcvicker@google.com>
Subject: [PATCH v5 2/7] clocksource/drivers/exynos_mct: Don't register as a
 sched_clock on arm64
From: Will McVicker <willmcvicker@google.com>
To: Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Krzysztof Kozlowski <krzk@kernel.org>, 
	Alim Akhtar <alim.akhtar@samsung.com>, Hosung Kim <hosung0.kim@samsung.com>, 
	Will McVicker <willmcvicker@google.com>, Ingo Molnar <mingo@kernel.org>, 
	Peter Griffin <peter.griffin@linaro.org>, Youngmin Nam <youngmin.nam@samsung.com>
Cc: Donghoon Yu <hoony.yu@samsung.com>, Rob Herring <robh@kernel.org>, 
	Saravana Kannan <saravanak@google.com>, John Stultz <jstultz@google.com>, 
	Tudor Ambarus <tudor.ambarus@linaro.org>, 
	"=?UTF-8?q?Andr=C3=A9=20Draszik?=" <andre.draszik@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, linux-samsung-soc@vger.kernel.org, 
	kernel-team@android.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Donghoon Yu <hoony.yu@samsung.com>

The MCT register is unfortunately very slow to access, but importantly
does not halt in the c2 idle state. So for ARM64, we can improve
performance by not registering the MCT for sched_clock, allowing the
system to use the faster ARM architected timer for sched_clock instead.

The MCT is still registered as a clocksource, and a clockevent in order
to be a wakeup source for the arch_timer to exit the "c2" idle state.

Since ARM32 SoCs don't have an architected timer, the MCT must continue
to be used for sched_clock. Detailed discussion on this topic can be
found at [1].

[1] https://lore.kernel.org/linux-samsung-soc/1400188079-21832-1-git-send-email-chirantan@chromium.org/

[Original commit from https://android.googlesource.com/kernel/gs/+/630817f7080e92c5e0216095ff52f6eb8dd00727

Signed-off-by: Donghoon Yu <hoony.yu@samsung.com>
Signed-off-by: Youngmin Nam <youngmin.nam@samsung.com>
Signed-off-by: Will McVicker <willmcvicker@google.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Acked-by: John Stultz <jstultz@google.com>
Tested-by: Youngmin Nam <youngmin.nam@samsung.com> # AOSP -> Linux port
Reviewed-by: Youngmin Nam <youngmin.nam@samsung.com> # AOSP -> Linux port
---
 drivers/clocksource/exynos_mct.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/clocksource/exynos_mct.c b/drivers/clocksource/exynos_mct.c
index da09f467a6bb..96361d5dc57d 100644
--- a/drivers/clocksource/exynos_mct.c
+++ b/drivers/clocksource/exynos_mct.c
@@ -219,12 +219,18 @@ static struct clocksource mct_frc = {
 	.resume		= exynos4_frc_resume,
 };
 
+/*
+ * Since ARM devices do not have an architected timer, they need to continue
+ * using the MCT as the main clocksource for timekeeping, sched_clock, and the
+ * delay timer. For AARCH64 SoCs, the architected timer is the preferred
+ * clocksource due to it's superior performance.
+ */
+#if defined(CONFIG_ARM)
 static u64 notrace exynos4_read_sched_clock(void)
 {
 	return exynos4_read_count_32();
 }
 
-#if defined(CONFIG_ARM)
 static struct delay_timer exynos4_delay_timer;
 
 static cycles_t exynos4_read_current_timer(void)
@@ -250,12 +256,13 @@ static int __init exynos4_clocksource_init(bool frc_shared)
 	exynos4_delay_timer.read_current_timer = &exynos4_read_current_timer;
 	exynos4_delay_timer.freq = clk_rate;
 	register_current_timer_delay(&exynos4_delay_timer);
+
+	sched_clock_register(exynos4_read_sched_clock, 32, clk_rate);
 #endif
 
 	if (clocksource_register_hz(&mct_frc, clk_rate))
 		panic("%s: can't register clocksource\n", mct_frc.name);
 
-	sched_clock_register(exynos4_read_sched_clock, 32, clk_rate);
 
 	return 0;
 }
-- 
2.51.1.821.gb6fe4d2222-goog


