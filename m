Return-Path: <linux-kernel+bounces-756641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E7A5B1B723
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 17:07:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D6BD18950C2
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 15:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09C9613B58A;
	Tue,  5 Aug 2025 15:07:07 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36937263F3C
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 15:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754406426; cv=none; b=PnKskDqGWMIAvP1BeQCpo8BUzHL2qI8+jKlciW1g49fGf2m3vnObDH5JD92ry0JHMoGv27wUpSIrIclEMNvx3jHhSUMQACtDngEVyuW2nc4nyOzoI5i9keNLDawAxOH3MZxG/PSbLxA3AoGoZjHbJRjnMX5AbJJSpTkEGf+CeLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754406426; c=relaxed/simple;
	bh=K341mltDGgeg6pHczdXkhUZl87sYT4L3t7I25NJfKls=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=lb3RFgkvdYZlIZ863qmhCAmuZTwyfzHFkXcNKYApT3mCe8UFIVdBQ+9mUV7kjsTZ7muuzKPgiXCnR8HJApfYC5ugIg3TTRI+sLfIdW/MEsrkNdV2kO4ZggkoSb0/e1vxJdjRl0UDD4dAK5P49K96X1fqGQH7ISTIzLj8JwP5xPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 77E4C2BCE;
	Tue,  5 Aug 2025 08:06:56 -0700 (PDT)
Received: from [10.1.29.177] (e137867.arm.com [10.1.29.177])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 423853F673;
	Tue,  5 Aug 2025 08:07:00 -0700 (PDT)
Message-ID: <44fd646c-4e31-4ca6-9e22-f715ad19e0d7@arm.com>
Date: Tue, 5 Aug 2025 16:06:58 +0100
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
In-Reply-To: <20250729015456.3411143-6-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Jinjie,

On 29/07/2025 02:54, Jinjie Ruan wrote:
> ARM64 requires an additional check whether to reschedule on return
> from interrupt. So add arch_irqentry_exit_need_resched() as the default
> NOP implementation and hook it up into the need_resched() condition in
> raw_irqentry_exit_cond_resched(). This allows ARM64 to implement
> the architecture specific version for switching over to
> the generic entry code.
I was a bit confused by this, as I didn't see the link with the generic 
entry
given you implement `raw_irqentry_exit_cond_resched()` in arch/arm64
as well in this patch : I expected the arm64 implementation to be added.
I share more thoughts below.

What do you think about something along those lines ?

	Compared to the generic entry code, arm64 does additional checks
	when deciding to reschedule on return from an interrupt.
	Introduce arch_irqentry_exit_need_resched() in the need_resched() condition
	of the generic raw_irqentry_exit_cond_resched(), with a NOP default.
	This will allow arm64 to implement its architecture specific checks when
	switching over to the generic entry code.

> [...]
> diff --git a/kernel/entry/common.c b/kernel/entry/common.c
> index b82032777310..4aa9656fa1b4 100644
> --- a/kernel/entry/common.c
> +++ b/kernel/entry/common.c
> @@ -142,6 +142,20 @@ noinstr irqentry_state_t irqentry_enter(struct pt_regs *regs)
>   	return ret;
>   }
>   
> +/**
> + * arch_irqentry_exit_need_resched - Architecture specific need resched function
> + *
> + * Invoked from raw_irqentry_exit_cond_resched() to check if need resched.
Very nit : "to check if resched is needed." ?
> + * Defaults return true.
> + *
> + * The main purpose is to permit arch to skip preempt a task from an IRQ.
If feel that "to avoid preemption of a task" instead of "to skip preempt 
a task"
would make this much clearer, what do you think ?
> + */
> +static inline bool arch_irqentry_exit_need_resched(void);
> +
> +#ifndef arch_irqentry_exit_need_resched
> +static inline bool arch_irqentry_exit_need_resched(void) { return true; }
> +#endif
> +

I've had some trouble reviewing this patch : on the one hand because
I didn't notice `arch_irqentry_exit_need_resched()` was added in
the common entry code, which is on me !
On the other hand, I felt that the patch itself was a bit disconnected :
we add `arch_irqentry_exit_need_resched()` in the common entry code,
with a default NOP, but in the same function we add to arm64,
while mentioning that this is for arm64's additional checks,
which we only implement in patch 7.

Would it make sense to move the `arch_irqentry_exit_need_resched()`
part of the patch to patch 7, so that the introduction and
arch-specific implementation appear together ?
To me it seems easier to wrap my head around, as it would look like
"Move arm64 to generic entry, but it does additional checks : add a new
arch-specific function controlling re-scheduling, defaulting to true,
and implement it for arm64". I feel it could help making patch 7's
commit message clearer as well.

 From what I gathered on the archive `arch_irqentry_exit_need_resched()`
being added here was suggested previously, so others might not have the
same opinion.

Maybe improving the commit message and comment for this would be enough
as well, as per my suggestions above.


Otherwise the changes make sense and I don't see any functional issues !

Thanks,
Ada


