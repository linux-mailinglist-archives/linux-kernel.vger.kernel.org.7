Return-Path: <linux-kernel+bounces-763181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 878B5B2114C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 18:14:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4805618A5D1D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 16:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 817D8311C2F;
	Mon, 11 Aug 2025 16:02:51 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF43B311C01
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 16:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754928171; cv=none; b=rN47B6nivZc2rEHqbDx8BMZZq3VqUMKMvMpmB37y8zplbU7uDm4/DbMh/75hJ1pUKPE6BB3sqzT1zbe2z2yOI+4wgHL1nKNWtBW8PKzZsybmjwATSeOdc0jBj/Sz5A2LaaHN+9ePx1G2FjGPFWR1C/8mXiDHe9sJ16yVElCgZ9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754928171; c=relaxed/simple;
	bh=SheW9JNJ5lhKVMVE2BprGv9VQWuakz8dUzktDH70wXs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=GPKF6A6f8x6xh0qQUyXlYq1LkkU16PFa+F1WtkKlm/xP56XMSnUXpaNJR/B62ppL9LImstywMmvNJ7COEimYFQiyuRLpSFjw1auAetPC8PVZ+qjIXGTNtjyVnl4HPbbiTh773sMS2f3en5EqEu4Nx1G+qEW/KSIJVCRwAB9kjLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CC053266C;
	Mon, 11 Aug 2025 09:02:40 -0700 (PDT)
Received: from [10.1.28.163] (e137867.arm.com [10.1.28.163])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BCB213F738;
	Mon, 11 Aug 2025 09:02:44 -0700 (PDT)
Message-ID: <4242ef37-efeb-446f-abbc-0104b805ad12@arm.com>
Date: Mon, 11 Aug 2025 17:02:42 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next v7 5/7] arm64: entry: Refactor
 preempt_schedule_irq() check code
To: Jinjie Ruan <ruanjinjie@huawei.com>
References: <20250729015456.3411143-1-ruanjinjie@huawei.com>
 <20250729015456.3411143-6-ruanjinjie@huawei.com>
From: Ada Couprie Diaz <ada.coupriediaz@arm.com>
Cc: catalin.marinas@arm.com, will@kernel.org, oleg@redhat.com,
 sstabellini@kernel.org, mark.rutland@arm.com, puranjay@kernel.org,
 broonie@kernel.org, mbenes@suse.cz, ryan.roberts@arm.com,
 akpm@linux-foundation.org, chenl311@chinatelecom.cn,
 anshuman.khandual@arm.com, kristina.martsenko@arm.com,
 liaochang1@huawei.com, ardb@kernel.org, leitao@debian.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 xen-devel@lists.xenproject.org, Ada Couprie Diaz <ada.coupriediaz@arm.com>
Content-Language: en-US
Organization: Arm Ltd.
In-Reply-To: <20250729015456.3411143-6-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 29/07/2025 02:54, Jinjie Ruan wrote:

> ARM64 requires an additional check whether to reschedule on return
> from interrupt. So add arch_irqentry_exit_need_resched() as the default
> NOP implementation and hook it up into the need_resched() condition in
> raw_irqentry_exit_cond_resched(). This allows ARM64 to implement
> the architecture specific version for switching over to
> the generic entry code.
>
> To align the structure of the code with irqentry_exit_cond_resched()
> from the generic entry code, hoist the need_irq_preemption()
> and IS_ENABLED() check earlier. And different preemption check functions
> are defined based on whether dynamic preemption is enabled.
>
> Suggested-by: Mark Rutland <mark.rutland@arm.com>
> Suggested-by: Kevin Brodsky <kevin.brodsky@arm.com>
> Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
Unrelated to the other thread : I noticed that compiling this patch
with `allnoconfig` would fail :
- `raw_irqentry_exit_cond_resched` has no previous prototype,
   as it is defined within `#ifdef CONFIG_PREEMPTION`
- `irqentry_exit_cond_resched()` is not declared, as it is also within
   `#ifdef CONFIG_PREEMPTION`

The patch below fixes the issue, but introduces merge conflicts in
patches 6 and 7, plus the `#ifdef` needs to be moved accordingly
in patch 6 and the empty "without preemption" `irq_exit_cond_resched()`
needs to be removed in patch 7.

I hope this can be useful,
Ada

---
diff --git a/arch/arm64/include/asm/preempt.h 
b/arch/arm64/include/asm/preempt.h
index 0f0ba250efe8..d9aba8b1e466 100644
--- a/arch/arm64/include/asm/preempt.h
+++ b/arch/arm64/include/asm/preempt.h
@@ -103,6 +103,8 @@ void dynamic_irqentry_exit_cond_resched(void);
  #define irqentry_exit_cond_resched() raw_irqentry_exit_cond_resched()

  #endif /* CONFIG_PREEMPT_DYNAMIC */
+#else /* CONFIG_PREEMPTION */
+#define irqentry_exit_cond_resched() {}
  #endif /* CONFIG_PREEMPTION */

  #endif /* __ASM_PREEMPT_H */
diff --git a/arch/arm64/kernel/entry-common.c 
b/arch/arm64/kernel/entry-common.c
index 4f92664fd46c..abd7a315145e 100644
--- a/arch/arm64/kernel/entry-common.c
+++ b/arch/arm64/kernel/entry-common.c
@@ -661,6 +661,7 @@ static __always_inline void __el1_pnmi(struct 
pt_regs *regs,
         arm64_exit_nmi(regs, state);
  }

+#ifdef CONFIG_PREEMPTION
  void raw_irqentry_exit_cond_resched(void)
  {
         if (!preempt_count()) {
@@ -668,6 +669,7 @@ void raw_irqentry_exit_cond_resched(void)
                         preempt_schedule_irq();
         }
  }
+#endif

  #ifdef CONFIG_PREEMPT_DYNAMIC
  DEFINE_STATIC_KEY_TRUE(sk_dynamic_irqentry_exit_cond_resched);


