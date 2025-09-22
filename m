Return-Path: <linux-kernel+bounces-827182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBA4EB9113C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 14:15:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D4097A9254
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 12:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71E7D306B32;
	Mon, 22 Sep 2025 12:15:01 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F2D23054D1
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 12:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758543300; cv=none; b=aKCzXtu3uKrV5yjsFyg5w6Rc6d78VJAq6YEJW790xoWnNx0eHvgndza6j4LahWPCqpPCrq4yHx8oVNOuZ5T6x5v6+eQFXf/R7zQplMCeZEprxTaVGQpHoC1X33FJVDjaVMkq1AkierGotnuhv6mKoUoznFsmXAi8ijX/NAbr/rM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758543300; c=relaxed/simple;
	bh=EMsFBN0HG7wi3fmEQBoTTCGhWjB5kON4APJ+WmB2fls=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fiUsm/+p5mp1Jtg6gLAUKS9fdN1ydGkibHJNNLeMdt9iIOSirXQgLfvVKw14+u2eAYfLxStUWB8OlCVQ3IE2He4csERkgToKEEJm6Gw/GYHtvdIAG+Xs2mQovIXfxaXI0k78epbRrv0yWeWR4EV2qT5dzJpyRrRItDJxg1+3L+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4cVhrB06myzYQvLJ
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 20:14:50 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 448AC1A06DE
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 20:14:54 +0800 (CST)
Received: from [10.67.110.36] (unknown [10.67.110.36])
	by APP3 (Coremail) with SMTP id _Ch0CgCHHz66PdFonPi_AQ--.15069S2;
	Mon, 22 Sep 2025 20:14:52 +0800 (CST)
Message-ID: <697be899-8501-405f-b4f6-eff306ae05e8@huaweicloud.com>
Date: Mon, 22 Sep 2025 20:14:50 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next v3] x86/dumpstack: Prevent KASAN false positive
 warnings in __show_regs
To: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org, jpoimboe@kernel.org,
 Andrey Ryabinin <ryabinin.a.a@gmail.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Alexander Potapenko
 <glider@google.com>, Andrey Konovalov <andreyknvl@gmail.com>,
 Dmitry Vyukov <dvyukov@google.com>, Ingo Molnar <mingo@redhat.com>,
 linux-kernel@vger.kernel.org
References: <20250830092556.3360776-1-wutengda@huaweicloud.com>
 <20250922094404.GAaNEaZIj-Hdilh_9H@fat_crate.local>
Content-Language: en-US
From: Tengda Wu <wutengda@huaweicloud.com>
In-Reply-To: <20250922094404.GAaNEaZIj-Hdilh_9H@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_Ch0CgCHHz66PdFonPi_AQ--.15069S2
X-Coremail-Antispam: 1UD129KBjvJXoW3GFW3Jr1DXFyUWrWfGFy5XFb_yoWxXry8p3
	yxta9avF4Fy34Fyr429F48Xr98Xr4DJryvqrs3Jw15JF1DCr18A3yFkF1jvF17ur97Ca45
	tayqqw1qk3yfCaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8
	ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1
	7KsUUUUUU==
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/

Hi Boris,

Thank you very much for your feedback and for taking another look at the patch.

On 2025/9/22 17:44, Borislav Petkov wrote:
> On Sat, Aug 30, 2025 at 09:25:56AM +0000, Tengda Wu wrote:
>> When task A walks task B's stack without suspending it, the continuous
>> changes in task B's stack (and corresponding KASAN shadow tags) may cause
>> task A to hit KASAN redzones when accessing obsolete values on the stack,
>> resulting in false positive reports. [1][2]
> 
> What kind of a use case is that even? Why do we care?

Running 'echo t > /proc/sysrq-trigger' will trigger this type of asynchronous
stack walk, as demonstrated in the use case provided below.

> 
>> The specific issue occurs as follows:
>>
>> Task A (walk other tasks' stacks)           Task B (running)
>> 1. echo t > /proc/sysrq-trigger
>>
>> show_trace_log_lvl
>>   regs = unwind_get_entry_regs()
>>   show_regs_if_on_stack(regs)
>>                                             2. The stack data pointed by
>>                                                `regs` keeps changing, and
>>                                                so are the tags in its
>>                                                KASAN shadow region.
>>     __show_regs(regs)
>>       regs->ax, regs->bx, ...
>>         3. hit KASAN redzones, OOB
>>
>> Fix this by detecting asynchronous stack unwinding scenarios through
>> `task != current` during unwinding, and disabling KASAN checks when this
>> scenario occurs.
>>
>> [1] https://lore.kernel.org/all/000000000000cb8e3a05c4ed84bb@google.com/
>> [2] KASAN out-of-bounds:
>> [332706.552324] BUG: KASAN: out-of-bounds in __show_regs+0x4b/0x340
>> [332706.552433] Read of size 8 at addr ffff88d24999fb20 by task sysrq_t_test.sh/3977032
>> [332706.552562]
>> [332706.552652] CPU: 36 PID: 3977032 Comm: sysrq_t_test.sh Kdump: loaded Not tainted 6.6.0+ #20
>> [332706.552783] Hardware name: Huawei RH2288H V3/BC11HGSA0, BIOS 3.35 10/20/2016
>> [332706.552906] Call Trace:
>> [332706.552998]  <TASK>
>> [332706.553089]  dump_stack_lvl+0x32/0x50
>> [332706.553193]  print_address_description.constprop.0+0x6b/0x3d0
>> [332706.553303]  print_report+0xbe/0x280
>> [332706.553409]  ? __virt_addr_valid+0xed/0x160
>> [332706.553512]  ? __show_regs+0x4b/0x340
>> [332706.553612]  kasan_report+0xa8/0xe0
>> [332706.553716]  ? __show_regs+0x4b/0x340
>> [332706.553816]  ? asm_exc_page_fault+0x22/0x30
>> [332706.553919]  __show_regs+0x4b/0x340
>> [332706.554021]  ? asm_exc_page_fault+0x22/0x30
>> [332706.554123]  show_trace_log_lvl+0x274/0x3b0
>> [332706.554229]  ? load_elf_binary+0xf6e/0x1610
>> [332706.554330]  ? rep_stos_alternative+0x40/0x80
>> [332706.554439]  sched_show_task+0x211/0x290
>> [332706.554544]  ? __pfx_sched_show_task+0x10/0x10
>> [332706.554648]  ? _find_next_bit+0x6/0xc0
>> [332706.554749]  ? _find_next_bit+0x37/0xc0
>> [332706.554852]  show_state_filter+0x72/0x130
>> [332706.554956]  sysrq_handle_showstate+0x7/0x10
>> [332706.555062]  __handle_sysrq+0x146/0x2d0
>> [332706.555165]  write_sysrq_trigger+0x2f/0x50
>> [332706.555270]  proc_reg_write+0xdd/0x140
>> [332706.555372]  vfs_write+0x1ff/0x5f0
>> [332706.555474]  ? __pfx_vfs_write+0x10/0x10
>> [332706.555576]  ? __pfx___handle_mm_fault+0x10/0x10
>> [332706.555682]  ? __fget_light+0x99/0xf0
>> [332706.555785]  ksys_write+0xb8/0x150
>> [332706.555887]  ? __pfx_ksys_write+0x10/0x10
>> [332706.555989]  ? ktime_get_coarse_real_ts64+0x4e/0x70
>> [332706.556094]  do_syscall_64+0x55/0x100
>> [332706.556196]  entry_SYSCALL_64_after_hwframe+0x78/0xe2
> 
> What is this stack dump here for?

This call stack corresponds to the exception thrown by the sysrq use case
mentioned above.

> 
> If it is absolutely needed, at least clean it up by removing hex numbers and
> timestamps because they're useless in a commit message.

Okay, I will clean up this useless information.

> 
>>
>> Fixes: 3b3fa11bc700 ("x86/dumpstack: Print any pt_regs found on the stack")
>> Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
>> ---
>> v3: Address Josh comment, move kasan checks to show_trace_log_lvl, and
>>     controlled by task != current.
>> v2: https://lore.kernel.org/all/20250829094744.3133324-1-wutengda@huaweicloud.com/
>> v1: https://lore.kernel.org/all/20250818130715.2904264-1-wutengda@huaweicloud.com/
>> ---
>>  arch/x86/kernel/dumpstack.c | 14 ++++++++++++++
>>  1 file changed, 14 insertions(+)
>>
>> diff --git a/arch/x86/kernel/dumpstack.c b/arch/x86/kernel/dumpstack.c
>> index 71ee20102a8a..6d1ae0d77ffc 100644
>> --- a/arch/x86/kernel/dumpstack.c
>> +++ b/arch/x86/kernel/dumpstack.c
>> @@ -189,9 +189,20 @@ static void show_trace_log_lvl(struct task_struct *task, struct pt_regs *regs,
>>  	unsigned long visit_mask = 0;
>>  	int graph_idx = 0;
>>  	bool partial = false;
>> +	bool kasan_disabled = false;
>>  
>>  	printk("%sCall Trace:\n", log_lvl);
>>  
>> +	/*
>> +	 * KASAN should be disabled during walking another task's stacks
>> +	 * to prevent false positives, as values on these stacks may change
>> +	 * concurrently with task execution.
>> +	 */
>> +	if (task && task != current) {
>> +		kasan_disable_current();
>> +		kasan_disabled = true;
>> +	}
> 
> I don't like the sprinking of KASAN checks all over the tree just to make this
> thing work.
> 
> If anything, you should disable KASAN like this:
> 
> show_trace_log_lvl:
> 	disable KASAN
> 	__show_trace_log_lvl
> 	enable KASAN
> 
> so that at least this thing is out of the way.

Yeah, that's a much cleaner approach.

> 
> But I'd like to hear first whether that's a use case we really want to
> support. Right now, it sounds like a meh to me: if you want to walk a task's
> stack with KASAN enabled, then stop it first.
> 
> Thx.
> 

I understand your point about keeping things simple and requiring the task to be
stopped.

However, the main challenge with stopping the task first is that it fundamentally
alters the state we're trying to inspect. The primary use case for an asynchronous
stack walk is to diagnose a task that is already misbehaving (e.g., spinning in a
hard lockup, not responding to stops). If we need to stop a task to get its stack,
we might not be able to stop it at all, or the act of stopping it could change the
call stack, hiding the root cause of the issue.

This is why my implementation selectively disables KASAN precisely for the async
walk scenario.

Thanks,
Tengda


