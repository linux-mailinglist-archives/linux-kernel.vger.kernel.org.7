Return-Path: <linux-kernel+bounces-757319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B3E90B1C0C2
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 08:59:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 947C54E2F43
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 06:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7394C217705;
	Wed,  6 Aug 2025 06:59:15 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD2C21322F
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 06:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754463555; cv=none; b=thNpSI0RI7oWiHLP2IYH1LVKabsQgmkFh0tPDrVOKPNMz+rfT/toMeBgjVfi/9gdu+9uiP3hhPB5rIm1mete3tDRDM/njCfwZbXwQhE0zjmZDWVUkXa+CM8xHqJyRssmxwhMecCbZffNnBgY3gZQlv3BmxoF+XPFdiAnrfUFG/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754463555; c=relaxed/simple;
	bh=ja5efmt1mDm487Lrc1QF6xyqIXTixWdvxYlytfBgsM0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ElEnbN1mDL6xnVSRPxIl05/vh2fUuUeTYA5hJnLNEdcVt+uMnaAljP/srcgo+uUo2/15fLtP5+Lge8E4NRFLiDsG/guc9ZNNx3DP4/cXYy1xBgh2AZLHIXQYuz1yFTwKqkvElaqFGFJAt8aoVJqeUArC+98N71XJHlNYUL0UgFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4bxgxp47LNz14MD9;
	Wed,  6 Aug 2025 14:54:06 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id C2CAE140155;
	Wed,  6 Aug 2025 14:59:02 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 dggpemf500011.china.huawei.com (7.185.36.131) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 6 Aug 2025 14:59:01 +0800
Message-ID: <8972d8b9-ced3-f207-9c00-91b544d8ecc8@huawei.com>
Date: Wed, 6 Aug 2025 14:59:00 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH -next v7 7/7] arm64: entry: Switch to generic IRQ entry
Content-Language: en-US
To: Ada Couprie Diaz <ada.coupriediaz@arm.com>
CC: <catalin.marinas@arm.com>, <will@kernel.org>, <oleg@redhat.com>,
	<sstabellini@kernel.org>, <mark.rutland@arm.com>, <puranjay@kernel.org>,
	<broonie@kernel.org>, <mbenes@suse.cz>, <ryan.roberts@arm.com>,
	<akpm@linux-foundation.org>, <chenl311@chinatelecom.cn>,
	<anshuman.khandual@arm.com>, <kristina.martsenko@arm.com>,
	<liaochang1@huawei.com>, <ardb@kernel.org>, <leitao@debian.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<xen-devel@lists.xenproject.org>
References: <20250729015456.3411143-1-ruanjinjie@huawei.com>
 <20250729015456.3411143-8-ruanjinjie@huawei.com>
 <fb0b7a92-09e8-41b2-9ae7-09fb9b453961@arm.com>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <fb0b7a92-09e8-41b2-9ae7-09fb9b453961@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 dggpemf500011.china.huawei.com (7.185.36.131)



On 2025/8/5 23:07, Ada Couprie Diaz wrote:
> Hi Jinjie,
> 
> The code changes look good to me, just a small missing clean up I believe.
> 
> On 29/07/2025 02:54, Jinjie Ruan wrote:
> 
>> Currently, x86, Riscv, Loongarch use the generic entry. Convert arm64
>> to use the generic entry infrastructure from kernel/entry/*.
>> The generic entry makes maintainers' work easier and codes
>> more elegant.
>>
>> Switch arm64 to generic IRQ entry first, which removed duplicate 100+
>> LOC. The next patch serise will switch to generic entry completely later.
>> Switch to generic entry in two steps according to Mark's suggestion
>> will make it easier to review.
> 
> I think the commit message could be clearer, especially since now this
> series
> only moves arm64 to generic IRQ entry and not the complete generic entry.
> 
> What do you think of something like below ? It repeats a bit less and I
> think
> it helps understanding what is going on in this specific commit, as you
> already
> have details on the larger plans in the cover.
> 
>     Currently, x86, Riscv and Loongarch use the generic entry code,
> which makes
>     maintainer's work easier and code more elegant.
>     Start converting arm64 to use the generic entry infrastructure
>     from kernel/entry/* by switching it to generic IRQ entry, which
> removes 100+
>     lines of duplicate code.
>     arm64 will completely switch to generic entry in a later series.
> 

Yes, this is more concise and accurate, and make the motivation more
clearer.

>> The changes are below:
>>   - Remove *enter_from/exit_to_kernel_mode(), and wrap with generic
>>     irqentry_enter/exit(). Also remove *enter_from/exit_to_user_mode(),
>>     and wrap with generic enter_from/exit_to_user_mode() because they
>>     are exactly the same so far.
> Nit : "so far" can be removed
>>   - Remove arm64_enter/exit_nmi() and use generic
>> irqentry_nmi_enter/exit()
>>     because they're exactly the same, so the temporary arm64 version
>>     irqentry_state can also be removed.
>>
>>   - Remove PREEMPT_DYNAMIC code, as generic entry do the same thing
>>     if arm64 implement arch_irqentry_exit_need_resched().
> This feels unrelated, given that the part that needs
> `arch_irqentry_exit_need_resched()`
> is called whether or not PREEMPT_DYNAMIC is enabled ?

Yes, the language here needs to be reorganized in conjunction with your
comments from the fifth patch.

> 
> Given my comments on patch 5, I feel that the commit message should mention
> explicitly the implementation of `arch_irqentry_exit_need_resched()` and
> why,
> even though it was already mentioned in patch 5.
> (This is what I was referencing in patch 5 : as I feel it's useful to
> mention again
> the reasons when implementing it, it doesn't feel too out of place to
> introduce
> the generic part at the same time. But again, I might be wrong here.)
> 
> Then you can have another point explaining that
> `raw_irqentry_exit_cond_resched()`
> and the PREEMPT_DYNAMIC code is removed because they are identical to the
> generic entry code, similarly to your other points.
>> Tested ok with following test cases on Qemu virt platform:
>>   - Perf tests.
>>   - Different `dynamic preempt` mode switch.
>>   - Pseudo NMI tests.
>>   - Stress-ng CPU stress test.
>>   - MTE test case in
>> Documentation/arch/arm64/memory-tagging-extension.rst
>>     and all test cases in tools/testing/selftests/arm64/mte/*.
> Nit : I'm not sure if the commit message is the best place for this,
> given you
> already gave some details in the cover ?
> But I don't have much experience here, so I'll leave it up to you and
> others !

Yes, this can be removed as the cover letter already has it.

>> Suggested-by: Mark Rutland <mark.rutland@arm.com>
>> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
>> ---
>> [...]
>> diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
>> index db3f972f8cd9..1110eeb21f57 100644
>> --- a/arch/arm64/kernel/signal.c
>> +++ b/arch/arm64/kernel/signal.c
>> @@ -9,6 +9,7 @@
>>   #include <linux/cache.h>
>>   #include <linux/compat.h>
>>   #include <linux/errno.h>
>> +#include <linux/irq-entry-common.h>
>>   #include <linux/kernel.h>
>>   #include <linux/signal.h>
>>   #include <linux/freezer.h>
>> @@ -1576,7 +1577,7 @@ static void handle_signal(struct ksignal *ksig,
>> struct pt_regs *regs)
>>    * the kernel can handle, and then we build all the user-level
>> signal handling
>>    * stack-frames in one go after that.
>>    */
>> -void do_signal(struct pt_regs *regs)
>> +void arch_do_signal_or_restart(struct pt_regs *regs)
> Given that `do_signal(struct pt_regs *regs)` is defined in
> `arch/arm64/include/asm/exception.h`,
> and that there remains no users of `do_signal()`, I think it should be
> removed there.

Good catch! I'll remove it.

> 
> Thanks,
> Ada
> 

