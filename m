Return-Path: <linux-kernel+bounces-756643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3BACB1B725
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 17:08:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 989E2624EC0
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 15:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B66762798FE;
	Tue,  5 Aug 2025 15:07:49 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C05CE279780
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 15:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754406469; cv=none; b=VYGWmtdvLliwZh3Lkl0/h/cpto563/ojL9u2aHL7sA9EzqWPnX3MrPoMuEeuSqNqLiNQvGRzXrvSej3yBm6S1feHHQhao4pibGmGAdbH0PUKrXyQs+3OL/aKnEMb8SRxOG2Xvjvso9pATB4D35TnXXYYTKqTTTwD06xwSgM7SRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754406469; c=relaxed/simple;
	bh=daHwRNMz2v7MP9nihhKUh2CRr7k4R63GJDoOueWJzp4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=MVoHz3oLJPD6Mf78Snff+p+KawtuTg3ZC3R9eQwvNv4GpOOGkjkGuDyotfWHX9s6e69cbMcFVjO4jEU9ujGo612UBlsE0M69Yqp+GRhXRxlGGwZg4VGeqp217I8dAJuJ/gKgg6MuD60KnFHjbDB1RhnjGpdGGLtthubstnBz/Us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 18C202BF2;
	Tue,  5 Aug 2025 08:07:39 -0700 (PDT)
Received: from [10.1.29.177] (e137867.arm.com [10.1.29.177])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BAE723F673;
	Tue,  5 Aug 2025 08:07:42 -0700 (PDT)
Message-ID: <fb0b7a92-09e8-41b2-9ae7-09fb9b453961@arm.com>
Date: Tue, 5 Aug 2025 16:07:40 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next v7 7/7] arm64: entry: Switch to generic IRQ entry
To: Jinjie Ruan <ruanjinjie@huawei.com>
References: <20250729015456.3411143-1-ruanjinjie@huawei.com>
 <20250729015456.3411143-8-ruanjinjie@huawei.com>
From: Ada Couprie Diaz <ada.coupriediaz@arm.com>
Cc: Ada Couprie Diaz <ada.coupriediaz@arm.com>, catalin.marinas@arm.com,
 will@kernel.org, oleg@redhat.com, sstabellini@kernel.org,
 mark.rutland@arm.com, puranjay@kernel.org, broonie@kernel.org,
 mbenes@suse.cz, ryan.roberts@arm.com, akpm@linux-foundation.org,
 chenl311@chinatelecom.cn, anshuman.khandual@arm.com,
 kristina.martsenko@arm.com, liaochang1@huawei.com, ardb@kernel.org,
 leitao@debian.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org
Content-Language: en-US
Organization: Arm Ltd.
In-Reply-To: <20250729015456.3411143-8-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jinjie,

The code changes look good to me, just a small missing clean up I believe.

On 29/07/2025 02:54, Jinjie Ruan wrote:

> Currently, x86, Riscv, Loongarch use the generic entry. Convert arm64
> to use the generic entry infrastructure from kernel/entry/*.
> The generic entry makes maintainers' work easier and codes
> more elegant.
>
> Switch arm64 to generic IRQ entry first, which removed duplicate 100+
> LOC. The next patch serise will switch to generic entry completely later.
> Switch to generic entry in two steps according to Mark's suggestion
> will make it easier to review.

I think the commit message could be clearer, especially since now this 
series
only moves arm64 to generic IRQ entry and not the complete generic entry.

What do you think of something like below ? It repeats a bit less and I 
think
it helps understanding what is going on in this specific commit, as you 
already
have details on the larger plans in the cover.

	Currently, x86, Riscv and Loongarch use the generic entry code, which makes
	maintainer's work easier and code more elegant.
	Start converting arm64 to use the generic entry infrastructure
	from kernel/entry/* by switching it to generic IRQ entry, which removes 100+
	lines of duplicate code.
	arm64 will completely switch to generic entry in a later series.

> The changes are below:
>   - Remove *enter_from/exit_to_kernel_mode(), and wrap with generic
>     irqentry_enter/exit(). Also remove *enter_from/exit_to_user_mode(),
>     and wrap with generic enter_from/exit_to_user_mode() because they
>     are exactly the same so far.
Nit : "so far" can be removed
>   - Remove arm64_enter/exit_nmi() and use generic irqentry_nmi_enter/exit()
>     because they're exactly the same, so the temporary arm64 version
>     irqentry_state can also be removed.
>
>   - Remove PREEMPT_DYNAMIC code, as generic entry do the same thing
>     if arm64 implement arch_irqentry_exit_need_resched().
This feels unrelated, given that the part that needs 
`arch_irqentry_exit_need_resched()`
is called whether or not PREEMPT_DYNAMIC is enabled ?

Given my comments on patch 5, I feel that the commit message should mention
explicitly the implementation of `arch_irqentry_exit_need_resched()` and 
why,
even though it was already mentioned in patch 5.
(This is what I was referencing in patch 5 : as I feel it's useful to 
mention again
the reasons when implementing it, it doesn't feel too out of place to 
introduce
the generic part at the same time. But again, I might be wrong here.)

Then you can have another point explaining that 
`raw_irqentry_exit_cond_resched()`
and the PREEMPT_DYNAMIC code is removed because they are identical to the
generic entry code, similarly to your other points.
> Tested ok with following test cases on Qemu virt platform:
>   - Perf tests.
>   - Different `dynamic preempt` mode switch.
>   - Pseudo NMI tests.
>   - Stress-ng CPU stress test.
>   - MTE test case in Documentation/arch/arm64/memory-tagging-extension.rst
>     and all test cases in tools/testing/selftests/arm64/mte/*.
Nit : I'm not sure if the commit message is the best place for this, 
given you
already gave some details in the cover ?
But I don't have much experience here, so I'll leave it up to you and 
others !
> Suggested-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
> [...]
> diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
> index db3f972f8cd9..1110eeb21f57 100644
> --- a/arch/arm64/kernel/signal.c
> +++ b/arch/arm64/kernel/signal.c
> @@ -9,6 +9,7 @@
>   #include <linux/cache.h>
>   #include <linux/compat.h>
>   #include <linux/errno.h>
> +#include <linux/irq-entry-common.h>
>   #include <linux/kernel.h>
>   #include <linux/signal.h>
>   #include <linux/freezer.h>
> @@ -1576,7 +1577,7 @@ static void handle_signal(struct ksignal *ksig, struct pt_regs *regs)
>    * the kernel can handle, and then we build all the user-level signal handling
>    * stack-frames in one go after that.
>    */
> -void do_signal(struct pt_regs *regs)
> +void arch_do_signal_or_restart(struct pt_regs *regs)
Given that `do_signal(struct pt_regs *regs)` is defined in 
`arch/arm64/include/asm/exception.h`,
and that there remains no users of `do_signal()`, I think it should be 
removed there.

Thanks,
Ada

