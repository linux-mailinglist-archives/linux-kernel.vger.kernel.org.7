Return-Path: <linux-kernel+bounces-788252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 71343B381D4
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 13:59:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D0821BA574E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 11:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24D812FF64E;
	Wed, 27 Aug 2025 11:59:04 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1668220B7EE
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 11:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756295943; cv=none; b=cRt91FmOzaIC4J473qkc6drcsC+QjVmrsEyCXTZWlmkzzJeIa9oQYgvKv1AFigmo4f5IAoxFOddyw7cvCnJ5R7SKD0vCm584qIaAQ3TF28qvfMxgPw9ASVj55fr1ztF9VKeh3t8uneLqeJlzL1j3bUSIAhpKDKboCMy7WmKUxzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756295943; c=relaxed/simple;
	bh=16tYvK3rpzPL+saplICJnVC9VoAju1VHDZ/3P7/sRsc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=gCeKRNgFLrvKhgsfAkog5c95aA3KtD4cjC6wZYolwYJF7bYqUABQiR9cuZNXqtC1sKY/w7mbqdDGo/eh4z0MS1Dw06fzPKJR0Lr3Vwuziaq3O032hA/Qbm7GmoLk95wMDEXW44//f4JyzO3qzI2VmGZWyewSCYiIjxCLaXtirNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4cBjjw0NpfzYQvpC
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 19:59:00 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 92A2F1A1552
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 19:58:58 +0800 (CST)
Received: from [10.67.110.36] (unknown [10.67.110.36])
	by APP3 (Coremail) with SMTP id _Ch0CgCHImr_8q5osVvZAQ--.64278S2;
	Wed, 27 Aug 2025 19:58:56 +0800 (CST)
Message-ID: <6d353178-43f4-4b1b-b28b-f2e6c534a886@huaweicloud.com>
Date: Wed, 27 Aug 2025 19:58:55 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next] x86: Prevent KASAN false positive warnings in
 __show_regs()
From: Tengda Wu <wutengda@huaweicloud.com>
To: Dave Hansen <dave.hansen@intel.com>,
 Alexander Potapenko <glider@google.com>
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>,
 Thomas Gleixner <tglx@linutronix.de>, Andrey Konovalov
 <andreyknvl@gmail.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, Dmitry Vyukov
 <dvyukov@google.com>, Ingo Molnar <mingo@redhat.com>,
 linux-kernel@vger.kernel.org, x86@kernel.org
References: <20250818130715.2904264-1-wutengda@huaweicloud.com>
 <1ede0349-320e-493e-a3fe-bc72efa4fd44@intel.com>
 <ebaaa130-0041-4871-8352-d33e285147ac@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <ebaaa130-0041-4871-8352-d33e285147ac@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_Ch0CgCHImr_8q5osVvZAQ--.64278S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJFWUXw1kXw1kXr4UJw18Xwb_yoWrAF1xpF
	Z8ta9avF45t34ftF42v3WxXr98GwsrJryvkrn3Gr15C3W7Zr1rJ3y5KF1YvF1fGryUCa47
	Jayjq34Dur93Ca7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AF
	wI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUF1
	v3UUUUU
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/


On 2025/8/21 11:13, Tengda Wu wrote:
> 
> 
> On 2025/8/21 5:36, Dave Hansen wrote:
>> On 8/18/25 06:07, Tengda Wu wrote:
>>> When process A accesses process B's `regs` from stack memory through
>>> __show_regs(), the stack of process B keeps changing during runtime.
>>> This causes false positives like "stack out-of-bounds" [1] or
>>> "out-of-bounds" [2] warnings when reading `regs` contents.
>>
>> Could you explain a little bit more how you know that these are false
>> positives?
> 
> Thanks for the question. We believe this is a false positive caused by a
> race condition during asynchronous stack tracing of a running process:
> 
> Process A (stack trace all processes)         Process B (running)
> 1. echo t > /proc/sysrq-trigger
> 
> show_trace_log_lvl
>   regs = unwind_get_entry_regs()
>   show_regs_if_on_stack(regs)
>                                               2. The stack data pointed by
>                                                  `regs` keeps changing, and
>                                                  so are the markings in its
>                                                  KASAN shadow region.
>     __show_regs(regs)
>       regs->ax, regs->bx, ...
>         3. hit KASAN redzones, OOB
> 
> When process A stacks process B without suspending it, the continuous
> changes in process B's stack (and corresponding KASAN shadow markings)
> may cause process A to hit KASAN redzones when accessing obsolete `regs`
> addresses, resulting in false positive reports.
> 
> A sample error log for this scenario is shown below:
> 
> [332706.551830] task:cat             state:R  running task     stack:0     pid:3983623 ppid:3977902 flags:0x00004002
> [332706.551847] Call Trace:
> [332706.551853]  <TASK>
> [332706.551860]  __schedule+0x809/0x1050
> [332706.551873]  ? __pfx___schedule+0x10/0x10
> [332706.551885]  ? __stack_depot_save+0x34/0x340
> [332706.551899]  schedule+0x82/0x160
> [332706.551911]  io_schedule+0x68/0xa0
> [332706.551923]  __folio_lock_killable+0x1db/0x410
> [332706.551940]  ? __pfx___folio_lock_killable+0x10/0x10
> [332706.551955]  ? __pfx_wake_page_function+0x10/0x10
> [332706.551969]  ? __filemap_get_folio+0x4b/0x3d0
> [332706.551982]  filemap_fault+0x67a/0xbd0
> [332706.551996]  ? __pfx_filemap_fault+0x10/0x10
> [332706.552008]  ? policy_node+0x8a/0xa0
> [332706.552021]  ? __mod_node_page_state+0x23/0xf0
> [332706.552035]  __do_fault+0x6d/0x340
> [332706.552048]  do_cow_fault+0xdd/0x300
> [332706.552061]  do_fault+0x141/0x1e0
> [332706.552074]  __handle_mm_fault+0x839/0xa70
> [332706.552089]  ? __pfx___handle_mm_fault+0x10/0x10
> [332706.552105]  ? find_vma+0x6a/0x90
> [332706.552117]  handle_mm_fault+0x27d/0x470
> [332706.552132]  exc_page_fault+0x336/0x6d0
> [332706.552145]  asm_exc_page_fault+0x22/0x30
> [332706.552157] RIP: 0010:rep_stos_alternative+0x40/0x80                                         --- (1)
> [332706.552173] Code: Unable to access opcode bytes at 0x7ffe929c4fd6.                           --- (2)
> [332706.552181] RSP: 3fa6:ffff88ba5e554200 EFLAGS: ffffffff9d50c0e0 ORIG_RAX: ffff88ba5e554200   --- (3)
> [332706.552195] ==================================================================
> [332706.552324] BUG: KASAN: out-of-bounds in __show_regs+0x4b/0x340                              --- (4)
> [332706.552433] Read of size 8 at addr ffff88d24999fb20 by task sysrq_t_test.sh/3977032
> 
> We focus on logs (1) to (4):
>  * Log (1) shows the current regs->ip (a kernel-mode address);
>  * Log (2) displays regs->ip - PROLOGUE_SIZE, which deviates significantly
>    from kernel-mode addresses, indicating regs->ip has changed.
>  * Log (3) then reveals anomalous values in regs->{ss,sp,flags}.
>  * Finally, Log (4) reports a KASAN OOB error when accessing regs->bx.
> 
> Stack tracing a running task cannot guarantee the accuracy of the printed
> regs values, but accessing regs addresses does not cause kernel instability.
> Similar cases have been consistently handled this way in the past. [1][2]
> We therefore consider this a KASAN false positive.
> 
> [1] https://lore.kernel.org/all/20220915150417.722975-40-glider@google.com/T/#u
> [2] https://lore.kernel.org/all/5f6e80c4b0c7f7f0b6211900847a247cdaad753c.1479398226.git.jpoimboe@redhat.com/T/#u

Gentle ping. 
Any comment or suggestion is appreciated.

Thanks,
Tengda


