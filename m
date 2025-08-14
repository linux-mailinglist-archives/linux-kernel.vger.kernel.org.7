Return-Path: <linux-kernel+bounces-768458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EEF5FB2613A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 11:43:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52A851CC7B41
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 09:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A75A52F60BD;
	Thu, 14 Aug 2025 09:31:58 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B343074A4
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 09:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755163918; cv=none; b=CR6LYESwTgI94+Dg4VPnVbDcqo6fe2U3redx8t8RGUj0nH6oh+w8wkEKcEwMvK/Xt0jpXgan5uVwLvSAoEFS/iEbdDmtKyebmESKhLIVJo1lEyt+yTOOKsippWMqdijf0n/PxyYeRsjQsRKVTsBVR/Gl/b+QvtxrPX1g+qlyRmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755163918; c=relaxed/simple;
	bh=lZyCdvmCPu4dSWES6kAli7yS99lbKG3WbFWtB+TIPv8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=rwz4G97NMFVwXjgWuIMuXYLFkbmfoJtbK12+/v8kaDtzcm35roIzOiRB+IZ5MlVq35os0xD5EWGN6SY1MHsIYArlPQAGneDoW3kpffhC11vGW1u8Zz6sVw4riDxYnnrDxteSs94axkMY8I/EVKMRRq9Ee4uh9f892tcnrVzp7QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4c2g313LRmztTJC;
	Thu, 14 Aug 2025 17:30:53 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id 796DD14027A;
	Thu, 14 Aug 2025 17:31:53 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 dggpemf500011.china.huawei.com (7.185.36.131) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 14 Aug 2025 17:31:51 +0800
Message-ID: <7c342b54-553c-013e-bed0-bc723c20464a@huawei.com>
Date: Thu, 14 Aug 2025 17:31:30 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH -next v7 5/7] arm64: entry: Refactor
 preempt_schedule_irq() check code
Content-Language: en-US
To: Mark Rutland <mark.rutland@arm.com>
CC: <catalin.marinas@arm.com>, <will@kernel.org>, <oleg@redhat.com>,
	<sstabellini@kernel.org>, <puranjay@kernel.org>, <broonie@kernel.org>,
	<mbenes@suse.cz>, <ryan.roberts@arm.com>, <akpm@linux-foundation.org>,
	<chenl311@chinatelecom.cn>, <ada.coupriediaz@arm.com>,
	<anshuman.khandual@arm.com>, <kristina.martsenko@arm.com>,
	<liaochang1@huawei.com>, <ardb@kernel.org>, <leitao@debian.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<xen-devel@lists.xenproject.org>
References: <20250729015456.3411143-1-ruanjinjie@huawei.com>
 <20250729015456.3411143-6-ruanjinjie@huawei.com>
 <aJsh5oM3CoUELkvY@J2N7QTR9R3>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <aJsh5oM3CoUELkvY@J2N7QTR9R3>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 dggpemf500011.china.huawei.com (7.185.36.131)



On 2025/8/12 19:13, Mark Rutland wrote:
> On Tue, Jul 29, 2025 at 09:54:54AM +0800, Jinjie Ruan wrote:
>> ARM64 requires an additional check whether to reschedule on return
>> from interrupt. So add arch_irqentry_exit_need_resched() as the default
>> NOP implementation and hook it up into the need_resched() condition in
>> raw_irqentry_exit_cond_resched(). This allows ARM64 to implement
>> the architecture specific version for switching over to
>> the generic entry code.
>>
>> To align the structure of the code with irqentry_exit_cond_resched()
>> from the generic entry code, hoist the need_irq_preemption()
>> and IS_ENABLED() check earlier. And different preemption check functions
>> are defined based on whether dynamic preemption is enabled.
>>
>> Suggested-by: Mark Rutland <mark.rutland@arm.com>
>> Suggested-by: Kevin Brodsky <kevin.brodsky@arm.com>
>> Suggested-by: Thomas Gleixner <tglx@linutronix.de>
>> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
>> ---
>>  arch/arm64/include/asm/preempt.h |  4 ++++
>>  arch/arm64/kernel/entry-common.c | 35 ++++++++++++++++++--------------
>>  kernel/entry/common.c            | 16 ++++++++++++++-
>>  3 files changed, 39 insertions(+), 16 deletions(-)
> 
> Can you please split the change to kernel/entry/common.c into a separate
> patch? That doesn't depend on the arm64-specific changes, and it'll make
> it easier to handle any conflcits when merging this.

Sure, I'll split the change into separate patch.

> 
> Mark.
> 
>>
>> diff --git a/arch/arm64/include/asm/preempt.h b/arch/arm64/include/asm/preempt.h
>> index 0159b625cc7f..0f0ba250efe8 100644
>> --- a/arch/arm64/include/asm/preempt.h
>> +++ b/arch/arm64/include/asm/preempt.h
>> @@ -85,6 +85,7 @@ static inline bool should_resched(int preempt_offset)
>>  void preempt_schedule(void);
>>  void preempt_schedule_notrace(void);
>>  
>> +void raw_irqentry_exit_cond_resched(void);
>>  #ifdef CONFIG_PREEMPT_DYNAMIC
>>  
>>  DECLARE_STATIC_KEY_TRUE(sk_dynamic_irqentry_exit_cond_resched);
>> @@ -92,11 +93,14 @@ void dynamic_preempt_schedule(void);
>>  #define __preempt_schedule()		dynamic_preempt_schedule()
>>  void dynamic_preempt_schedule_notrace(void);
>>  #define __preempt_schedule_notrace()	dynamic_preempt_schedule_notrace()
>> +void dynamic_irqentry_exit_cond_resched(void);
>> +#define irqentry_exit_cond_resched()	dynamic_irqentry_exit_cond_resched()
>>  
>>  #else /* CONFIG_PREEMPT_DYNAMIC */
>>  
>>  #define __preempt_schedule()		preempt_schedule()
>>  #define __preempt_schedule_notrace()	preempt_schedule_notrace()
>> +#define irqentry_exit_cond_resched()	raw_irqentry_exit_cond_resched()
>>  
>>  #endif /* CONFIG_PREEMPT_DYNAMIC */
>>  #endif /* CONFIG_PREEMPTION */
>> diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-common.c
>> index 7c2299c1ba79..4f92664fd46c 100644
>> --- a/arch/arm64/kernel/entry-common.c
>> +++ b/arch/arm64/kernel/entry-common.c
>> @@ -285,19 +285,8 @@ static void noinstr arm64_exit_el1_dbg(struct pt_regs *regs,
>>  		lockdep_hardirqs_on(CALLER_ADDR0);
>>  }
>>  
>> -#ifdef CONFIG_PREEMPT_DYNAMIC
>> -DEFINE_STATIC_KEY_TRUE(sk_dynamic_irqentry_exit_cond_resched);
>> -#define need_irq_preemption() \
>> -	(static_branch_unlikely(&sk_dynamic_irqentry_exit_cond_resched))
>> -#else
>> -#define need_irq_preemption()	(IS_ENABLED(CONFIG_PREEMPTION))
>> -#endif
>> -
>>  static inline bool arm64_preempt_schedule_irq(void)
>>  {
>> -	if (!need_irq_preemption())
>> -		return false;
>> -
>>  	/*
>>  	 * DAIF.DA are cleared at the start of IRQ/FIQ handling, and when GIC
>>  	 * priority masking is used the GIC irqchip driver will clear DAIF.IF
>> @@ -672,6 +661,24 @@ static __always_inline void __el1_pnmi(struct pt_regs *regs,
>>  	arm64_exit_nmi(regs, state);
>>  }
>>  
>> +void raw_irqentry_exit_cond_resched(void)
>> +{
>> +	if (!preempt_count()) {
>> +		if (need_resched() && arm64_preempt_schedule_irq())
>> +			preempt_schedule_irq();
>> +	}
>> +}
>> +
>> +#ifdef CONFIG_PREEMPT_DYNAMIC
>> +DEFINE_STATIC_KEY_TRUE(sk_dynamic_irqentry_exit_cond_resched);
>> +void dynamic_irqentry_exit_cond_resched(void)
>> +{
>> +	if (!static_branch_unlikely(&sk_dynamic_irqentry_exit_cond_resched))
>> +		return;
>> +	raw_irqentry_exit_cond_resched();
>> +}
>> +#endif
>> +
>>  static __always_inline void __el1_irq(struct pt_regs *regs,
>>  				      void (*handler)(struct pt_regs *))
>>  {
>> @@ -681,10 +688,8 @@ static __always_inline void __el1_irq(struct pt_regs *regs,
>>  	do_interrupt_handler(regs, handler);
>>  	irq_exit_rcu();
>>  
>> -	if (!preempt_count() && need_resched()) {
>> -		if (arm64_preempt_schedule_irq())
>> -			preempt_schedule_irq();
>> -	}
>> +	if (IS_ENABLED(CONFIG_PREEMPTION))
>> +		irqentry_exit_cond_resched();
>>  
>>  	exit_to_kernel_mode(regs, state);
>>  }
>> diff --git a/kernel/entry/common.c b/kernel/entry/common.c
>> index b82032777310..4aa9656fa1b4 100644
>> --- a/kernel/entry/common.c
>> +++ b/kernel/entry/common.c
>> @@ -142,6 +142,20 @@ noinstr irqentry_state_t irqentry_enter(struct pt_regs *regs)
>>  	return ret;
>>  }
>>  
>> +/**
>> + * arch_irqentry_exit_need_resched - Architecture specific need resched function
>> + *
>> + * Invoked from raw_irqentry_exit_cond_resched() to check if need resched.
>> + * Defaults return true.
>> + *
>> + * The main purpose is to permit arch to skip preempt a task from an IRQ.
>> + */
>> +static inline bool arch_irqentry_exit_need_resched(void);
>> +
>> +#ifndef arch_irqentry_exit_need_resched
>> +static inline bool arch_irqentry_exit_need_resched(void) { return true; }
>> +#endif
>> +
>>  void raw_irqentry_exit_cond_resched(void)
>>  {
>>  	if (!preempt_count()) {
>> @@ -149,7 +163,7 @@ void raw_irqentry_exit_cond_resched(void)
>>  		rcu_irq_exit_check_preempt();
>>  		if (IS_ENABLED(CONFIG_DEBUG_ENTRY))
>>  			WARN_ON_ONCE(!on_thread_stack());
>> -		if (need_resched())
>> +		if (need_resched() && arch_irqentry_exit_need_resched())
>>  			preempt_schedule_irq();
>>  	}
>>  }
>> -- 
>> 2.34.1
>>
> 
> 

