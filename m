Return-Path: <linux-kernel+bounces-789889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BB87B39C32
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 14:06:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B4083BD044
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 12:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E053930F537;
	Thu, 28 Aug 2025 12:06:27 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF9A258EDA
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 12:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756382787; cv=none; b=EuM+84b3lxX1zo3RTauToedt1DhDpBurxXr7O2tHiv/iLwOqWIKC8wtRFdZxULTI8XSZf3mYHdzkVOp61C+ceLEoCBaLALP0VLfjNTH2/aOK6qtiHHc8u1T3pk/oV9CW8rjvrIzaLCcm2l6/umVUB9xCUydgEbVM8hRj/8YSxBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756382787; c=relaxed/simple;
	bh=pz0FsRAAhtZHqcceacx7gDVhnc/14bOoACWD64zEPmY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GW4Zv8xjm8fLOlM/sBUubZK3LIUijOtEu0u5evaxrJur1bLHJRHAfMyelya5aiiZlwOOLfzuYgOO+CBC+XDuhuLbl9QBMWeKx/1AWCmuWWDj1gokNr9FPxv48Il0EWBFHZe1J/pCKgrkfaThTkJ8OC6irMkkXvT5mM/LjSvZFys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4cCKqx2wh9zKHMxj
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 20:06:21 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 1DEB71A158E
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 20:06:21 +0800 (CST)
Received: from [10.67.110.36] (unknown [10.67.110.36])
	by APP2 (Coremail) with SMTP id Syh0CgC335Y5RrBo+yROAg--.35735S2;
	Thu, 28 Aug 2025 20:06:17 +0800 (CST)
Message-ID: <2956719f-58bf-40ac-9c63-6f9a8092ae1d@huaweicloud.com>
Date: Thu, 28 Aug 2025 20:06:17 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next] x86: Prevent KASAN false positive warnings in
 __show_regs()
To: Andrey Ryabinin <ryabinin.a.a@gmail.com>, x86@kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Alexander Potapenko <glider@google.com>,
 Andrey Konovalov <andreyknvl@gmail.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, Dmitry Vyukov
 <dvyukov@google.com>, Ingo Molnar <mingo@redhat.com>,
 linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Josh Poimboeuf <jpoimboe@redhat.com>
References: <20250818130715.2904264-1-wutengda@huaweicloud.com>
 <1cd29a46-3c17-42ca-af41-ed0a645b29c3@gmail.com>
Content-Language: en-US
From: Tengda Wu <wutengda@huaweicloud.com>
In-Reply-To: <1cd29a46-3c17-42ca-af41-ed0a645b29c3@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgC335Y5RrBo+yROAg--.35735S2
X-Coremail-Antispam: 1UD129KBjvJXoWxKw4fuw4kKF1ftF13Gw4fuFg_yoW3JF17pa
	n7Aan2gF48C34FvFW7ZF48Xr9xZw4DXrn2k3s3Gr13AF1Y9r1fX3y3CF1jvF13Ar98Ca43
	tayqqw1qyr43CaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8
	ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IUb
	mii3UUUUU==
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/


Hi Andrey,

On 2025/8/27 22:45, Andrey Ryabinin wrote:
> 
> 
> On 8/18/25 3:07 PM, Tengda Wu wrote:
>> When process A accesses process B's `regs` from stack memory through
>> __show_regs(), the stack of process B keeps changing during runtime.
>> This causes false positives like "stack out-of-bounds" [1] or
>> "out-of-bounds" [2] warnings when reading `regs` contents.
>>
>> Add __no_sanitize_address attribute to __show_regs() to suppress these
>> false positives while maintaining the ability to debug register states
>> across processes.
>>
>> [1] https://lore.kernel.org/all/000000000000cb8e3a05c4ed84bb@google.com/
>> [2] A similar KASAN report:
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
>>
>> Fixes: 3b3fa11bc700 ("x86/dumpstack: Print any pt_regs found on the stack")
>> Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
>> ---
>>  arch/x86/include/asm/kdebug.h | 2 +-
>>  arch/x86/kernel/process_32.c  | 1 +
>>  arch/x86/kernel/process_64.c  | 1 +
>>  3 files changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/x86/include/asm/kdebug.h b/arch/x86/include/asm/kdebug.h
>> index d1514e70477b..2e0570d75bbc 100644
>> --- a/arch/x86/include/asm/kdebug.h
>> +++ b/arch/x86/include/asm/kdebug.h
>> @@ -36,7 +36,7 @@ extern void die(const char *, struct pt_regs *,long);
>>  void die_addr(const char *str, struct pt_regs *regs, long err, long gp_addr);
>>  extern int __must_check __die(const char *, struct pt_regs *, long);
>>  extern void show_stack_regs(struct pt_regs *regs);
>> -extern void __show_regs(struct pt_regs *regs, enum show_regs_mode,
>> +extern void __no_sanitize_address __show_regs(struct pt_regs *regs, enum show_regs_mode,
>>  			const char *log_lvl);
>>  extern void show_iret_regs(struct pt_regs *regs, const char *log_lvl);
>>  extern unsigned long oops_begin(void);
>> diff --git a/arch/x86/kernel/process_32.c b/arch/x86/kernel/process_32.c
>> index 3ef15c2f152f..1b7ed4dee18b 100644
>> --- a/arch/x86/kernel/process_32.c
>> +++ b/arch/x86/kernel/process_32.c
>> @@ -56,6 +56,7 @@
>>  
>>  #include "process.h"
>>  
>> +__no_sanitize_address
>>  void __show_regs(struct pt_regs *regs, enum show_regs_mode mode,
>>  		 const char *log_lvl)
>>  {
>> diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
>> index 52a5c03c353c..921c96154ce3 100644
>> --- a/arch/x86/kernel/process_64.c
>> +++ b/arch/x86/kernel/process_64.c
>> @@ -66,6 +66,7 @@
>>  #include "process.h"
>>  
>>  /* Prints also some state that isn't saved in the pt_regs */
>> +__no_sanitize_address
>>  void __show_regs(struct pt_regs *regs, enum show_regs_mode mode,
>>  		 const char *log_lvl)
>>  {
> 
> 
> __no_sanitize_address affects only __show_regs() function.
> But the `regs` are passed down in show_iret_regs()->show_ip()->show_opcodes()
> and all these also accesses `regs`

Indeed. Thanks for pointing that out.

> 
> I see several options here:
> 
> 1. Use kasan_disable_current()/kasan_enable_current() to wrap code accessing `regs`.
> And maybe something like:
>          if (!on_current_stack(regs))
>                  kasan_disable_current();
> 
> so we skip kasan reports only if `regs` belong to other task.

This looks like the best fit.

> 
> 2. Sprinkle over __no_sanitize_address all functions accessing `regs`.
> But this disable all memory access checks all the time in these functions.
> 

As Dave said, this does not provide finer-grained control than Option 1.

> 3. Use READ_ONCE_NOCHECK() to read regs->

This might affect code readability, as there are too many `regs->xxx`
inside these functions.

> 
> 4. Introduce memcpy_no_sanitize_address(), and use it to copy snapshot of `regs`
> somewhere (on the stack of current task ?). But pt_regs is 168 bytes, I'm not sure if this
> is acceptable stack usage increment.

This sounds a bit complicated.


So, for Option 1:

It seems there's no existing on_current_stack function available.
Implementing an on_current_stack function would be somewhat
challenging for me. 

How about just check the task directly inside show_trace_log_lvl?
I've traced all kernel paths calling __show_regs() and found that
asynchronous stack walkers always reaches here. — seems suitable?

Here is a sample patch:

diff --git a/arch/x86/kernel/dumpstack.c b/arch/x86/kernel/dumpstack.c
index 71ee20102a8a..e519aeb00705 100644
--- a/arch/x86/kernel/dumpstack.c
+++ b/arch/x86/kernel/dumpstack.c
@@ -189,9 +189,15 @@ static void show_trace_log_lvl(struct task_struct *task, struct pt_regs *regs,
        unsigned long visit_mask = 0;
        int graph_idx = 0;
        bool partial = false;
+       bool kasan_disabled = false;
 
        printk("%sCall Trace:\n", log_lvl);
 
+       if (task != current) {
+               kasan_disable_current();
+               kasan_disabled = true;
+       }
+
        unwind_start(&state, task, regs, stack);
        stack = stack ?: get_stack_pointer(task, regs);
        regs = unwind_get_entry_regs(&state, &partial);
@@ -301,6 +307,9 @@ static void show_trace_log_lvl(struct task_struct *task, struct pt_regs *regs,
                if (stack_name)
                        printk("%s </%s>\n", log_lvl, stack_name);
        }
+
+       if (kasan_disabled)
+               kasan_enable_current();
 }


Best regards,
Tengda


