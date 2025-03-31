Return-Path: <linux-kernel+bounces-582232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10C9EA76AE9
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Mar 2025 17:43:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44912188D988
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Mar 2025 15:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7801D22171A;
	Mon, 31 Mar 2025 15:20:36 +0000 (UTC)
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE0E221569
	for <linux-kernel@vger.kernel.org>; Mon, 31 Mar 2025 15:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743434435; cv=none; b=qDrit2SqsIYmrAXcJpwR+f96dmjPmqym28s+13LY3+jNNaAY8ZeOy2l9tx8PvEp3ZNM61xCp/kgHxS8co/fH6sksjdbdcSrLSzqvNU7Z/2aVCaMis/vQVEewiU9+LyPXxHqYju0wkZVEa+rAvxH9roCFa/h0z09H00FKiHFgjms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743434435; c=relaxed/simple;
	bh=fkB778aQG/md6T5XUhtR3HkW/ub93X1uiil2DTJJ6+Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OafKHmW6Yo/etSZne/9XWoHPmsQ29KDDPbEAPfIaxQ6U+7nRbL2GRgo30PS4kTl9tFvJEUQ9qv2daF8vEOLwC5nh8q/ZTSQ/t8OQ1LoxFRK+vZMC7EO+ZBSkzq6R38R5y8PqsvWrhHZf8Ttw3KNvtaxb12+42NafjNeyov8M9y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id A544344307;
	Mon, 31 Mar 2025 15:20:23 +0000 (UTC)
Message-ID: <b72fd79e-c006-4857-a5f1-9e7842806004@ghiti.fr>
Date: Mon, 31 Mar 2025 17:20:22 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/5] riscv: save the SR_SUM status over switches
Content-Language: en-US
To: Cyril Bur <cyrilbur@tenstorrent.com>, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, paul.walmsley@sifive.com, charlie@rivosinc.com,
 jrtc27@jrtc27.com, ben.dooks@codethink.co.uk
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 jszhang@kernel.org, syzbot+e74b94fe601ab9552d69@syzkaller.appspotmail.com
References: <20250320224423.1838493-1-cyrilbur@tenstorrent.com>
 <20250320224423.1838493-2-cyrilbur@tenstorrent.com>
 <7556bdd0-1015-4175-a810-d2d53662ba64@ghiti.fr>
 <b5755b70-8fbf-4738-b9c1-08947de959be@tenstorrent.com>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <b5755b70-8fbf-4738-b9c1-08947de959be@tenstorrent.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddukedtvdeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthekredttddvjeenucfhrhhomheptehlvgigrghnughrvgcuifhhihhtihcuoegrlhgvgiesghhhihhtihdrfhhrqeenucggtffrrghtthgvrhhnpedvleeivdevgeekudefjeeigeeuvdekueeiuedufeethffhiedvleeileduuddtgfenucffohhmrghinhepvghnthhrhidrshgspdhinhhfrhgruggvrggurdhorhhgnecukfhppedvtddtudemkeeiudemfeefkedvmegvfheltdemieefledtmeelfhgttgemuddtgeehmedvgeekkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvtddtudemkeeiudemfeefkedvmegvfheltdemieefledtmeelfhgttgemuddtgeehmedvgeekkedphhgvlhhopeglkffrggeimedvtddtudemkeeiudemfeefkedvmegvfheltdemieefledtmeelfhgttgemuddtgeehmedvgeekkegnpdhmrghilhhfrhhomheprghlvgigsehghhhithhirdhfrhdpnhgspghrtghpthhtohepuddupdhrtghpthhtoheptgihrhhilhgsuhhrsehtvghnshhtohhrrhgvnhhtrdgtohhmpdhrtghpthhtohepphgrlhhmvghrsegurggssggvlhhtr
 dgtohhmpdhrtghpthhtoheprghouhesvggvtghsrdgsvghrkhgvlhgvhidrvgguuhdprhgtphhtthhopehprghulhdrfigrlhhmshhlvgihsehsihhfihhvvgdrtghomhdprhgtphhtthhopegthhgrrhhlihgvsehrihhvohhsihhntgdrtghomhdprhgtphhtthhopehjrhhttgdvjeesjhhrthgtvdejrdgtohhmpdhrtghpthhtohepsggvnhdrughoohhkshestghouggvthhhihhnkhdrtghordhukhdprhgtphhtthhopehlihhnuhigqdhrihhstghvsehlihhsthhsrdhinhhfrhgruggvrggurdhorhhg
X-GND-Sasl: alex@ghiti.fr

Hi Cyril,

On 31/03/2025 05:16, Cyril Bur wrote:
>
>
> On 21/3/2025 8:09 pm, Alexandre Ghiti wrote:
>> Hi Cyril/Ben,
>>
>> On 20/03/2025 23:44, Cyril Bur wrote:
>>> From: Ben Dooks <ben.dooks@codethink.co.uk>
>>>
>>> When threads/tasks are switched we need to ensure the old execution's
>>> SR_SUM state is saved and the new thread has the old SR_SUM state
>>> restored.
>>>
>>> The issue is seen under heavy load especially with the syz-stress tool
>>> running, with crashes as follows in schedule_tail:
>>>
>>> Unable to handle kernel access to user memory without uaccess routines
>>> at virtual address 000000002749f0d0
>>> Oops [#1]
>>> Modules linked in:
>>> CPU: 1 PID: 4875 Comm: syz-executor.0 Not tainted
>>> 5.12.0-rc2-syzkaller-00467-g0d7588ab9ef9 #0
>>> Hardware name: riscv-virtio,qemu (DT)
>>> epc : schedule_tail+0x72/0xb2 kernel/sched/core.c:4264
>>>   ra : task_pid_vnr include/linux/sched.h:1421 [inline]
>>>   ra : schedule_tail+0x70/0xb2 kernel/sched/core.c:4264
>>> epc : ffffffe00008c8b0 ra : ffffffe00008c8ae sp : ffffffe025d17ec0
>>>   gp : ffffffe005d25378 tp : ffffffe00f0d0000 t0 : 0000000000000000
>>>   t1 : 0000000000000001 t2 : 00000000000f4240 s0 : ffffffe025d17ee0
>>>   s1 : 000000002749f0d0 a0 : 000000000000002a a1 : 0000000000000003
>>>   a2 : 1ffffffc0cfac500 a3 : ffffffe0000c80cc a4 : 5ae9db91c19bbe00
>>>   a5 : 0000000000000000 a6 : 0000000000f00000 a7 : ffffffe000082eba
>>>   s2 : 0000000000040000 s3 : ffffffe00eef96c0 s4 : ffffffe022c77fe0
>>>   s5 : 0000000000004000 s6 : ffffffe067d74e00 s7 : ffffffe067d74850
>>>   s8 : ffffffe067d73e18 s9 : ffffffe067d74e00 s10: ffffffe00eef96e8
>>>   s11: 000000ae6cdf8368 t3 : 5ae9db91c19bbe00 t4 : ffffffc4043cafb2
>>>   t5 : ffffffc4043cafba t6 : 0000000000040000
>>> status: 0000000000000120 badaddr: 000000002749f0d0 cause:
>>> 000000000000000f
>>> Call Trace:
>>> [<ffffffe00008c8b0>] schedule_tail+0x72/0xb2 kernel/sched/core.c:4264
>>> [<ffffffe000005570>] ret_from_exception+0x0/0x14
>>> Dumping ftrace buffer:
>>>     (ftrace buffer empty)
>>> ---[ end trace b5f8f9231dc87dda ]---
>>>
>>> The issue comes from the put_user() in schedule_tail
>>> (kernel/sched/core.c)
>>> doing the following:
>>>
>>> asmlinkage __visible void schedule_tail(struct task_struct *prev)
>>> {
>>> ...
>>>          if (current->set_child_tid)
>>>                  put_user(task_pid_vnr(current), 
>>> current->set_child_tid);
>>> ...
>>> }
>>>
>>> the put_user() macro causes the code sequence to come out as follows:
>>>
>>> 1:    __enable_user_access()
>>> 2:    reg = task_pid_vnr(current);
>>> 3:    *current->set_child_tid = reg;
>>> 4:    __disable_user_access()
>>>
>>> This means the task_pid_vnr() is being called with user-access enabled
>>> which itself is not a good idea, but that is a separate issue. Here we
>>> have a function that /might/ sleep being called with the SR_SUM and if
>>> it does, then it returns with the SR_SUM flag possibly cleared thus
>>> causing the above abort.
>>>
>>> To try and deal with this, and stop the SR_SUM leaking out into other
>>> threads (this has also been tested and see under stress. It can rarely
>>> happen but it /does/ under load) make sure the __switch_to() will save
>>> and restore the SR_SUM flag, and clear it possibly for the next thread
>>> if it does not need it.
>>>
>>> Note, test code to be supplied once other checks have been finished.
>>>
>>> There may be further issues with the mstatus flags with this, this
>>> can be discussed further once some initial testing has been done.
>>
>>
>> The whole changelog is outdated, it needs to be reworded:
>>
>> "To prevent the evaluation of preemptible functions in unsafe_get/ 
>> put_XXX() which could clear SUM bit set by get_user_access()... etc etc"
>>
>
> Hi Alex and Ben,
>
> Commit messages are not my forte and this one is complex. I've been 
> wondering how to reword it - I feel that Bens text should live on, it 
> isn't incorrect. Also I would very much appreciate if you could look 
> over what I've written Ben.
>
> I'll start it off the same and hopefully I've messaged the end 
> successfully:
>
>
> From: Ben Dooks <ben.dooks@codethink.co.uk>
>
> When threads/tasks are switched we need to ensure the old execution's
> SR_SUM state is saved and the new thread has the old SR_SUM state
> restored.
>
> The issue is seen under heavy load especially with the syz-stress tool
> running, with crashes as follows in schedule_tail:


"The issue was seen ... "


>
> Unable to handle kernel access to user memory without uaccess routines
> at virtual address 000000002749f0d0
> Oops [#1]
> Modules linked in:
> CPU: 1 PID: 4875 Comm: syz-executor.0 Not tainted
> 5.12.0-rc2-syzkaller-00467-g0d7588ab9ef9 #0
> Hardware name: riscv-virtio,qemu (DT)
> epc : schedule_tail+0x72/0xb2 kernel/sched/core.c:4264
>   ra : task_pid_vnr include/linux/sched.h:1421 [inline]
>   ra : schedule_tail+0x70/0xb2 kernel/sched/core.c:4264
> epc : ffffffe00008c8b0 ra : ffffffe00008c8ae sp : ffffffe025d17ec0
>   gp : ffffffe005d25378 tp : ffffffe00f0d0000 t0 : 0000000000000000
>   t1 : 0000000000000001 t2 : 00000000000f4240 s0 : ffffffe025d17ee0
>   s1 : 000000002749f0d0 a0 : 000000000000002a a1 : 0000000000000003
>   a2 : 1ffffffc0cfac500 a3 : ffffffe0000c80cc a4 : 5ae9db91c19bbe00
>   a5 : 0000000000000000 a6 : 0000000000f00000 a7 : ffffffe000082eba
>   s2 : 0000000000040000 s3 : ffffffe00eef96c0 s4 : ffffffe022c77fe0
>   s5 : 0000000000004000 s6 : ffffffe067d74e00 s7 : ffffffe067d74850
>   s8 : ffffffe067d73e18 s9 : ffffffe067d74e00 s10: ffffffe00eef96e8
>   s11: 000000ae6cdf8368 t3 : 5ae9db91c19bbe00 t4 : ffffffc4043cafb2
>   t5 : ffffffc4043cafba t6 : 0000000000040000
> status: 0000000000000120 badaddr: 000000002749f0d0 cause:
> 000000000000000f
> Call Trace:
> [<ffffffe00008c8b0>] schedule_tail+0x72/0xb2 kernel/sched/core.c:4264
> [<ffffffe000005570>] ret_from_exception+0x0/0x14
> Dumping ftrace buffer:
>     (ftrace buffer empty)
> ---[ end trace b5f8f9231dc87dda ]---
>
> The issue comes from the put_user() in schedule_tail 
> (kernel/sched/core.c) doing the following:
>
> asmlinkage __visible void schedule_tail(struct task_struct *prev)
> {
> ...
>          if (current->set_child_tid)
>                  put_user(task_pid_vnr(current), current->set_child_tid);
> ...
> }
>
> the put_user() macro causes the code sequence to come out as follows:
>
> 1:    __enable_user_access()
> 2:    reg = task_pid_vnr(current);
> 3:    *current->set_child_tid = reg;
> 4:    __disable_user_access()
>

"The problem is that we may have a sleeping function as argument which 
could clear SR_SUM causing the panic above. So this was fixed by 
evaluating the argument of the put_user() macro outside the user-enabled 
section in commit XXXX ("")"


> This means the task_pid_vnr() is being called with user-access enabled
> which itself is not a good idea, but that is a separate issue. Here we 
> have a function that /might/ sleep being called with the SR_SUM and if
> it does, then it returns with the SR_SUM flag possibly cleared thus
> causing the above abort.


^^ I would remove that then.


>
> To try and deal with this, and stop the SR_SUM leaking out into other 
> threads (this has also been tested and see under stress. It can rarely 
> happen but it /does/ under load) make sure the __switch_to() will save 
> and restore the SR_SUM flag, and clear it possibly for the next thread 
> if it does not need it.
>

I'd move that after "we must ensure code flow..." and I'd remove "and 
clear it possibly..." since we won't clear it in the next version.


> In order for riscv to take advantage of unsafe_get/put_XXX() macros 


"and to avoid the same issue we had with put_user() and sleeping functions"


> we must ensure code flow can go through switch_to() from within a 
> region of code with SR_SUM enabled and come back with SR_SUM still 
> enabled. This patch addresses the problem allowing future work to 
> enable full use of unsafe_get/put_XXX() macros without needing to take 
> a CSR bit flip cost on every access.
>
>
>>
>>>
>>> Reported-by: syzbot+e74b94fe601ab9552d69@syzkaller.appspotmail.com
>>> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
>>> Signed-off-by: Cyril Bur <cyrilbur@tenstorrent.com>
>>> ---
>>>   arch/riscv/include/asm/processor.h | 1 +
>>>   arch/riscv/kernel/asm-offsets.c    | 5 +++++
>>>   arch/riscv/kernel/entry.S          | 8 ++++++++
>>>   3 files changed, 14 insertions(+)
>>>
>>> diff --git a/arch/riscv/include/asm/processor.h 
>>> b/arch/riscv/include/ asm/processor.h
>>> index 5f56eb9d114a..0de05d652e0f 100644
>>> --- a/arch/riscv/include/asm/processor.h
>>> +++ b/arch/riscv/include/asm/processor.h
>>> @@ -103,6 +103,7 @@ struct thread_struct {
>>>       struct __riscv_d_ext_state fstate;
>>>       unsigned long bad_cause;
>>>       unsigned long envcfg;
>>> +    unsigned long flags;
>>
>>
>> I would prefer the use of status since it stores the sstatus csr.
>
> I will change it in the next version of my series.
>
>>
>>
>>>       u32 riscv_v_flags;
>>>       u32 vstate_ctrl;
>>>       struct __riscv_v_ext_state vstate;
>>> diff --git a/arch/riscv/kernel/asm-offsets.c 
>>> b/arch/riscv/kernel/asm- offsets.c
>>> index e89455a6a0e5..556ebcbb7e22 100644
>>> --- a/arch/riscv/kernel/asm-offsets.c
>>> +++ b/arch/riscv/kernel/asm-offsets.c
>>> @@ -34,6 +34,7 @@ void asm_offsets(void)
>>>       OFFSET(TASK_THREAD_S9, task_struct, thread.s[9]);
>>>       OFFSET(TASK_THREAD_S10, task_struct, thread.s[10]);
>>>       OFFSET(TASK_THREAD_S11, task_struct, thread.s[11]);
>>> +    OFFSET(TASK_THREAD_FLAGS, task_struct, thread.flags);
>>>       OFFSET(TASK_TI_CPU, task_struct, thread_info.cpu);
>>>       OFFSET(TASK_TI_FLAGS, task_struct, thread_info.flags);
>>> @@ -347,6 +348,10 @@ void asm_offsets(void)
>>>             offsetof(struct task_struct, thread.s[11])
>>>           - offsetof(struct task_struct, thread.ra)
>>>       );
>>> +    DEFINE(TASK_THREAD_FLAGS_RA,
>>> +          offsetof(struct task_struct, thread.flags)
>>> +        - offsetof(struct task_struct, thread.ra)
>>> +    );
>>>       DEFINE(TASK_THREAD_F0_F0,
>>>             offsetof(struct task_struct, thread.fstate.f[0])
>>> diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
>>> index 33a5a9f2a0d4..c278b3ac37b9 100644
>>> --- a/arch/riscv/kernel/entry.S
>>> +++ b/arch/riscv/kernel/entry.S
>>> @@ -397,9 +397,17 @@ SYM_FUNC_START(__switch_to)
>>>       REG_S s9,  TASK_THREAD_S9_RA(a3)
>>>       REG_S s10, TASK_THREAD_S10_RA(a3)
>>>       REG_S s11, TASK_THREAD_S11_RA(a3)
>>> +
>>> +    /* save (and disable the user space access flag) */
>>> +    li    s0, SR_SUM
>>> +    csrrc s1, CSR_STATUS, s0
>>
>>
>> Here (again), I don't think we need to clear sstatus.
>
> I don't think so either, the bit definitely has no effect in userspace:
> > SUM has no effect when page-based virtual memory is not in effect, 
> nor when executing in U-mode.
>
> However, I wonder if Ben had a plan? If not I'll make it a read next 
> version of the series.
>
> Thanks,
>
> Cyril
>
>>
>>
>>> +    REG_S s1, TASK_THREAD_FLAGS_RA(a3)
>>> +
>>>       /* Save the kernel shadow call stack pointer */
>>>       scs_save_current
>>>       /* Restore context from next->thread */
>>> +    REG_L s0,  TASK_THREAD_FLAGS_RA(a4)
>>> +    csrs  CSR_STATUS, s0
>>>       REG_L ra,  TASK_THREAD_RA_RA(a4)
>>>       REG_L sp,  TASK_THREAD_SP_RA(a4)
>>>       REG_L s0,  TASK_THREAD_S0_RA(a4)
>>
>>
>> Thanks,
>>
>> Alex
>>
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv


Hopefully that's better!

Thanks,

Alex


