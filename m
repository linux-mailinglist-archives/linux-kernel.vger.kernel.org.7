Return-Path: <linux-kernel+bounces-867751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B128FC036F2
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 22:51:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0E0D3B51AC
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 20:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3650F27FB26;
	Thu, 23 Oct 2025 20:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tnIWBBpX"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA8A526F29F
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 20:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761252654; cv=none; b=U77KyI5ZGNDjkJV5K6gMw8DSEfC4DCZrKvzEsoer0PFEVdkM5engezmioPFf187vCwpCk3slaRmL3nUKVlNL+thsLhdHOyqk528hvPQnLxrNVrcn11qm4y/FDo0dKSHPQg1PtpJyM2LLB6PwX6hqXiJSQvOmrbXwEoRGP3yEpJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761252654; c=relaxed/simple;
	bh=2OVYsiaEALq8X/jeb/e/72PKIxNOL2+WIgOo7aBNVYU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GkySA79CqlGZRFRlOTTm690mgIGVol79R7fI78N0Uu67nl781iaf2Zl+V6wfrA1Qh3RAD6E/FAwdMEo3Zuc2lbYOa6Jjh8laRlXt2wCjT2x88Xy3lC1ZJ6I7EPKWB7Ax7RmZhgCaud5T0r8Ao4gzCkHNmdDQmjQnICIcDqTSii0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--willmcvicker.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tnIWBBpX; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--willmcvicker.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b6cff817142so555222a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 13:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761252652; x=1761857452; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nOlNjzKGrmabtYpeYty40nfBQK9A/mPHc8f9qhi2ylg=;
        b=tnIWBBpXceEWSY9PqiRvdLwM6u/meHVmvl2ad0cgxFvrYB+0VdhVrNEiRVOoObZ70F
         6Sc1HfP+rkJlg05kewPjPh15Fl4XM2cZmElGum3/ZgiCOuhjHvnPGxv+GRx1jpTFYwcw
         9ZA0vVpavSpf2uGF98b1q7ufDPvINooG/0J6EVNvinZ9sk7UaeVxW2Qt/al2o3+ivNNR
         O+h0dPr82sQZTovPxRTA6wREEXI4LNRAxTd4NCToJkohF47ey6PO8pujZoXBxUypePRT
         /6GbUM+4RC6f0Dp2QrrXnUHiu/B+iKOlTAZ4z0j04sgN7VHHglOaZiLOYaMlkNOn/NT/
         4hVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761252652; x=1761857452;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nOlNjzKGrmabtYpeYty40nfBQK9A/mPHc8f9qhi2ylg=;
        b=m5NTihZwZd0cZK0a6/KqvIrVMDm7IW0INAhPP+jDDpntOhse68MtLWrjkXmP9VKzBL
         b+afis+a4dx+J5GD6QsxOZXq3co/PnQyXQP5czpXflj9r8muFWXaMvIhpAOedY1V1HO6
         MmEkeFTWRdHbkw3SdTzMDL51SWUvIzk7VK/A6t5C8vOStp2CdwrMUzBen/cgOlP6tSSK
         h+iRWU03PmWJZpTYVPvIb3t+8Gf44dxdC0ho7EgHAX/lGgnwgAiL1THqeLcOkNzXlL6L
         QX6ryewHJEEUIovwQwLbjlgdZoorgcbn8h1yREAAPTZUcOy8Pof6d3S432DQb3VEY8l/
         amXg==
X-Forwarded-Encrypted: i=1; AJvYcCVlr49LrdpmvemX+2GUqd5bBNFFKDYcGLV3Idjz7iUVWNUB77A1At7wFXMSpaUEA3aGqvda7W+r32K5PbY=@vger.kernel.org
X-Gm-Message-State: AOJu0YypzyLkThibyrg2VYtpnvbj4aSEK5WlUPzASXqY4lZXKtuvhTRh
	3/gBq/z+IH2456vu2A1q7cdGQc3N0vZ7UNCtPK3OqDTPENPElBl0ERj3k5IX5GAq+aFdswMi7Eh
	ovzNV75VpzRBzrcsnh/UkTypMzDruYg==
X-Google-Smtp-Source: AGHT+IG8p3pkosaZ8VG4QyHxJWpBTvZC8r9Ms20gd0LJHErCKtPSqmFaP4ynOh3lhy9g1UGNqy/yUuBIw+1NXTJ6JfM=
X-Received: from pjgg16.prod.google.com ([2002:a17:90b:57d0:b0:33b:51fe:1a91])
 (user=willmcvicker job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:4322:b0:33b:2c70:78d8 with SMTP id adf61e73a8af0-33c619d0bd1mr5081679637.37.1761252652128;
 Thu, 23 Oct 2025 13:50:52 -0700 (PDT)
Date: Thu, 23 Oct 2025 20:50:28 +0000
In-Reply-To: <20251023205041.2027336-1-willmcvicker@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251023205041.2027336-1-willmcvicker@google.com>
X-Mailer: git-send-email 2.51.1.821.gb6fe4d2222-goog
Message-ID: <20251023205041.2027336-3-willmcvicker@google.com>
Subject: [PATCH 2/7] clocksource/drivers/exynos_mct: Don't register as a
 sched_clock on arm64
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


