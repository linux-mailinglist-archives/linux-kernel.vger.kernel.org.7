Return-Path: <linux-kernel+bounces-638266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F6E4AAE336
	for <lists+linux-kernel@lfdr.de>; Wed,  7 May 2025 16:40:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B9751886DDE
	for <lists+linux-kernel@lfdr.de>; Wed,  7 May 2025 14:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFC5428A1D2;
	Wed,  7 May 2025 14:36:00 +0000 (UTC)
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D563289E18;
	Wed,  7 May 2025 14:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746628560; cv=none; b=ZUutLrJ2EeXEhO47IK8ajqEpk+Ao17/EO5EtupwePIdkDS+dBdRD6iH9ykJrChRL26KQO9+tRPB9juFIJeLduDgYlvZ7RAZopgOZHXjcJ/JNLXcYQ+C3e3WOsWs4P1ELmpzcd1SFu0lbLheQePpIHFXeRlN9pTMtF9r3MDzFWkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746628560; c=relaxed/simple;
	bh=2eMJh4QUmGLX4BNr0GiVvQHlmWhDqnp+WxQq1hpa6Ws=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dxZpsJEmYadWM5nNH/3vidhIuWOqhAz565XjQa6vd+VxeLO4C0SQBOa+V8QdrgS1wzb5W2IwQmCQXgwQA0qd4UEAyeHE5Qh+rIXWs5JEXgbXtEwoJgCtFrKvpPtLqJFKqMJzjCZSbzkNqFsjyVhzbfDfF8S1J6yDafaXzJKZ49c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id F11F743A1E;
	Wed,  7 May 2025 14:35:47 +0000 (UTC)
Message-ID: <dd877b46-5327-4f9e-91d0-30a9e863a9cb@ghiti.fr>
Date: Wed, 7 May 2025 16:35:47 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 05/12] riscv: ftrace: prepare ftrace for atomic code
 patching
Content-Language: en-US
To: Andy Chiu <andybnac@gmail.com>
Cc: linux-riscv@lists.infradead.org, alexghiti@rivosinc.com,
 palmer@dabbelt.com, Andy Chiu <andy.chiu@sifive.com>,
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 Mark Rutland <mark.rutland@arm.com>, puranjay12@gmail.com,
 paul.walmsley@sifive.com, greentime.hu@sifive.com, nick.hu@sifive.com,
 nylon.chen@sifive.com, eric.lin@sifive.com, vicent.chen@sifive.com,
 zong.li@sifive.com, yongxuan.wang@sifive.com, samuel.holland@sifive.com,
 olivia.chu@sifive.com, c2232430@gmail.com
References: <20250407180838.42877-1-andybnac@gmail.com>
 <20250407180838.42877-5-andybnac@gmail.com>
 <aea9f0cd-087a-43f2-8631-a6926ff9ced3@ghiti.fr>
 <735ba24d-e1f9-4d56-934b-18d0d2b91428@ghiti.fr>
 <CAFTtA3NqC+r9HBS2cJvwzZMyTECJe3VbWrsZgWo6e-LTgpPOaA@mail.gmail.com>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <CAFTtA3NqC+r9HBS2cJvwzZMyTECJe3VbWrsZgWo6e-LTgpPOaA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkeejudduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthekredttddvjeenucfhrhhomheptehlvgigrghnughrvgcuifhhihhtihcuoegrlhgvgiesghhhihhtihdrfhhrqeenucggtffrrghtthgvrhhnpedtgeeuhffhveeujeetveevieekleekvdffudefleevgefgieekkefggefhtddtveenucfkphepvddttddumeekiedumeeffeekvdemvghfledtmeekjeelfhemrgehrgdtmedurggrgeemrggsvdegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvddttddumeekiedumeeffeekvdemvghfledtmeekjeelfhemrgehrgdtmedurggrgeemrggsvdegpdhhvghloheplgfkrfggieemvddttddumeekiedumeeffeekvdemvghfledtmeekjeelfhemrgehrgdtmedurggrgeemrggsvdegngdpmhgrihhlfhhrohhmpegrlhgvgiesghhhihhtihdrfhhrpdhnsggprhgtphhtthhopedvuddprhgtphhtthhopegrnhguhigsnhgrtgesghhmrghilhdrtghomhdprhgtphhtthhopehlihhnuhigqdhrihhstghvsehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtoheprghlvgigghhhihhtihesrhhiv
 hhoshhinhgtrdgtohhmpdhrtghpthhtohepphgrlhhmvghrsegurggssggvlhhtrdgtohhmpdhrtghpthhtoheprghnugihrdgthhhiuhesshhifhhivhgvrdgtohhmpdhrtghpthhtohepsghjohhrnhesrhhivhhoshhinhgtrdgtohhmpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqthhrrggtvgdqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-GND-Sasl: alex@ghiti.fr

Hi Andy,

On 07/05/2025 16:18, Andy Chiu wrote:
> On Mon, May 5, 2025 at 10:06 PM Alexandre Ghiti <alex@ghiti.fr> wrote:
>> On 23/04/2025 10:22, Alexandre Ghiti wrote:
>>> Hi Andy,
>>>
>>> On 07/04/2025 20:08, Andy Chiu wrote:
>>>> From: Andy Chiu <andy.chiu@sifive.com>
>>>>
>>>> We use an AUIPC+JALR pair to jump into a ftrace trampoline. Since
>>>> instruction fetch can break down to 4 byte at a time, it is impossible
>>>> to update two instructions without a race. In order to mitigate it, we
>>>> initialize the patchable entry to AUIPC + NOP4. Then, the run-time code
>>>> patching can change NOP4 to JALR to eable/disable ftrcae from a
>>>> function. This limits the reach of each ftrace entry to +-2KB displacing
>>>> from ftrace_caller.
>>>>
>>>> Starting from the trampoline, we add a level of indirection for it to
>>>> reach ftrace caller target. Now, it loads the target address from a
>>>> memory location, then perform the jump. This enable the kernel to update
>>>> the target atomically.
>>>>
>>>> The new don't-stop-the-world text patching on change only one RISC-V
>>>> instruction:
>>>>
>>>>     |  -8: &ftrace_ops of the associated tracer function.
>>>>     | <ftrace enable>:
>>>>     |   0: auipc  t0, hi(ftrace_caller)
>>>>     |   4: jalr   t0, lo(ftrace_caller)
>>>>     |
>>>>     |  -8: &ftrace_nop_ops
>>>>     | <ftrace disable>:
>>>>     |   0: auipc  t0, hi(ftrace_caller)
>>>>     |   4: nop
>>>>
>>>> This means that f+0x0 is fixed, and should not be claimed by ftrace,
>>>> e.g. kprobe should be able to put a probe in f+0x0. Thus, we adjust the
>>>> offset and MCOUNT_INSN_SIZE accordingly.
>>>>
>>>> Co-developed-by: Björn Töpel <bjorn@rivosinc.com>
>>>> Signed-off-by: Björn Töpel <bjorn@rivosinc.com>
>>>> Signed-off-by: Andy Chiu <andy.chiu@sifive.com>
>>>> ---
>>>> Changelog v4:
>>>>    - Include Björn's fix for kprobe
>>>>    - Refactor code for better reading (Robbin, Björn)
>>>>    - Remove make_call_ra and friedns (Björn)
>>>>    - Update comments to match reality (Björn)
>>>>    - Drop code defined by !WITH_ARG
>>>>    - Add a synchronization point when updating ftrace_call_dest (Björn)
>>>> ---
>>>>    arch/riscv/include/asm/ftrace.h |  49 ++++++------
>>>>    arch/riscv/kernel/ftrace.c      | 130 ++++++++++++++++----------------
>>>>    arch/riscv/kernel/mcount-dyn.S  |   9 +--
>>>>    3 files changed, 92 insertions(+), 96 deletions(-)
>>>>
>>>> diff --git a/arch/riscv/include/asm/ftrace.h
>>>> b/arch/riscv/include/asm/ftrace.h
>>>> index d8b2138bd9c6..6a5c0a7fb826 100644
>>>> --- a/arch/riscv/include/asm/ftrace.h
>>>> +++ b/arch/riscv/include/asm/ftrace.h
>>>> @@ -20,10 +20,9 @@ extern void *return_address(unsigned int level);
>>>>    #define ftrace_return_address(n) return_address(n)
>>>>      void _mcount(void);
>>>> -static inline unsigned long ftrace_call_adjust(unsigned long addr)
>>>> -{
>>>> -    return addr;
>>>> -}
>>>> +unsigned long ftrace_call_adjust(unsigned long addr);
>>>> +unsigned long arch_ftrace_get_symaddr(unsigned long fentry_ip);
>>>> +#define ftrace_get_symaddr(fentry_ip)
>>>> arch_ftrace_get_symaddr(fentry_ip)
>>>>      /*
>>>>     * Let's do like x86/arm64 and ignore the compat syscalls.
>>>> @@ -57,12 +56,21 @@ struct dyn_arch_ftrace {
>>>>     * 2) jalr: setting low-12 offset to ra, jump to ra, and set ra to
>>>>     *          return address (original pc + 4)
>>>>     *
>>>> + * The first 2 instructions for each tracable function is compiled
>>>> to 2 nop
>>>> + * instructions. Then, the kernel initializes the first instruction
>>>> to auipc at
>>>> + * boot time (<ftrace disable>). The second instruction is patched
>>>> to jalr to
>>>> + * start the trace.
>>>> + *
>>>> + *<Image>:
>>>> + * 0: nop
>>>> + * 4: nop
>>>> + *
>>>>     *<ftrace enable>:
>>>> - * 0: auipc  t0/ra, 0x?
>>>> - * 4: jalr   t0/ra, ?(t0/ra)
>>>> + * 0: auipc  t0, 0x?
>>>> + * 4: jalr   t0, ?(t0)
>>>>     *
>>>>     *<ftrace disable>:
>>>> - * 0: nop
>>>> + * 0: auipc  t0, 0x?
>>>>     * 4: nop
>>>>     *
>>>>     * Dynamic ftrace generates probes to call sites, so we must deal with
>>>> @@ -75,10 +83,9 @@ struct dyn_arch_ftrace {
>>>>    #define AUIPC_OFFSET_MASK    (0xfffff000)
>>>>    #define AUIPC_PAD        (0x00001000)
>>>>    #define JALR_SHIFT        20
>>>> -#define JALR_RA            (0x000080e7)
>>>> -#define AUIPC_RA        (0x00000097)
>>>>    #define JALR_T0            (0x000282e7)
>>>>    #define AUIPC_T0        (0x00000297)
>>>> +#define JALR_RANGE        (JALR_SIGN_MASK - 1)
>>>>      #define to_jalr_t0(offset)                        \
>>>>        (((offset & JALR_OFFSET_MASK) << JALR_SHIFT) | JALR_T0)
>>>> @@ -96,26 +103,14 @@ do {                                    \
>>>>        call[1] = to_jalr_t0(offset);                    \
>>>>    } while (0)
>>>>    -#define to_jalr_ra(offset)                        \
>>>> -    (((offset & JALR_OFFSET_MASK) << JALR_SHIFT) | JALR_RA)
>>>> -
>>>> -#define to_auipc_ra(offset)                        \
>>>> -    ((offset & JALR_SIGN_MASK) ?                    \
>>>> -    (((offset & AUIPC_OFFSET_MASK) + AUIPC_PAD) | AUIPC_RA) :    \
>>>> -    ((offset & AUIPC_OFFSET_MASK) | AUIPC_RA))
>>>> -
>>>> -#define make_call_ra(caller, callee, call)                \
>>>> -do {                                    \
>>>> -    unsigned int offset =                        \
>>>> -        (unsigned long) (callee) - (unsigned long) (caller); \
>>>> -    call[0] = to_auipc_ra(offset);                    \
>>>> -    call[1] = to_jalr_ra(offset);                    \
>>>> -} while (0)
>>>> -
>>>>    /*
>>>> - * Let auipc+jalr be the basic *mcount unit*, so we make it 8 bytes
>>>> here.
>>>> + * Only the jalr insn in the auipc+jalr is patched, so we make it 4
>>>> + * bytes here.
>>>>     */
>>>> -#define MCOUNT_INSN_SIZE 8
>>>> +#define MCOUNT_INSN_SIZE    4
>>>> +#define MCOUNT_AUIPC_SIZE    4
>>>> +#define MCOUNT_JALR_SIZE    4
>>>> +#define MCOUNT_NOP4_SIZE    4
>>>>      #ifndef __ASSEMBLY__
>>>>    struct dyn_ftrace;
>>>> diff --git a/arch/riscv/kernel/ftrace.c b/arch/riscv/kernel/ftrace.c
>>>> index 1fd10555c580..cf78eef073a0 100644
>>>> --- a/arch/riscv/kernel/ftrace.c
>>>> +++ b/arch/riscv/kernel/ftrace.c
>>>> @@ -8,10 +8,21 @@
>>>>    #include <linux/ftrace.h>
>>>>    #include <linux/uaccess.h>
>>>>    #include <linux/memory.h>
>>>> +#include <linux/irqflags.h>
>>>>    #include <linux/stop_machine.h>
>>>>    #include <asm/cacheflush.h>
>>>>    #include <asm/text-patching.h>
>>>>    +unsigned long ftrace_call_adjust(unsigned long addr)
>>>> +{
>>>> +    return addr + MCOUNT_AUIPC_SIZE;
>>>> +}
>>>> +
>>>> +unsigned long arch_ftrace_get_symaddr(unsigned long fentry_ip)
>>>> +{
>>>> +    return fentry_ip - MCOUNT_AUIPC_SIZE;
>>>> +}
>>>> +
>>>
>>> Those functions cause the following errors when building with
>>> !CONFIG_DYNAMIC_FTRACE, but I'm not sure how to fix this:
>>>
>>> ../arch/riscv/kernel/ftrace.c: In function 'ftrace_call_adjust':
>>> ../arch/riscv/kernel/ftrace.c:19:35: error: 'MCOUNT_AUIPC_SIZE'
>>> undeclared (first use in this function)
>>>     19 |                 return addr + 8 + MCOUNT_AUIPC_SIZE;
>>>        |                                   ^~~~~~~~~~~~~~~~~
>>> ../arch/riscv/kernel/ftrace.c:19:35: note: each undeclared identifier
>>> is reported only once for each function it appears in
>>>    CC      fs/9p/vfs_dir.o
>>> ../arch/riscv/kernel/ftrace.c: In function 'arch_ftrace_get_symaddr':
>>> ../arch/riscv/kernel/ftrace.c:26:28: error: 'MCOUNT_AUIPC_SIZE'
>>> undeclared (first use in this function)
>>>     26 |         return fentry_ip - MCOUNT_AUIPC_SIZE;
>>>        |                            ^~~~~~~~~~~~~~~~~
>>>    CC      drivers/pci/pcie/pme.o
>>> ../arch/riscv/kernel/ftrace.c: In function 'ftrace_call_adjust':
>>> ../arch/riscv/kernel/ftrace.c:22:1: error: control reaches end of
>>> non-void function [-Werror=return-type]
>>>     22 | }
>>>        | ^
>>> ../arch/riscv/kernel/ftrace.c: In function 'arch_ftrace_get_symaddr':
>>> ../arch/riscv/kernel/ftrace.c:27:1: error: control reaches end of
>>> non-void function [-Werror=return-type]
>>>     27 | }
>>>        | ^
>>> cc1: some warnings being treated as errors
>>> make[5]: *** [../scripts/Makefile.build:203:
>>> arch/riscv/kernel/ftrace.o] Error 1
>>>
>> So I fixed those errors with the following, let me know if that's not
>> correct:
>>
>> diff --git a/arch/riscv/kernel/ftrace.c b/arch/riscv/kernel/ftrace.c
>> index d65f06bfb4573..4c6c24380cfd9 100644
>> --- a/arch/riscv/kernel/ftrace.c
>> +++ b/arch/riscv/kernel/ftrace.c
>> @@ -13,6 +13,7 @@
>>    #include <asm/cacheflush.h>
>>    #include <asm/text-patching.h>
>>
>> +#ifdef CONFIG_DYNAMIC_FTRACE
>>    unsigned long ftrace_call_adjust(unsigned long addr)
>>    {
>>           if (IS_ENABLED(CONFIG_DYNAMIC_FTRACE_WITH_CALL_OPS))
>> @@ -26,7 +27,6 @@ unsigned long arch_ftrace_get_symaddr(unsigned long
>> fentry_ip)
>>           return fentry_ip - MCOUNT_AUIPC_SIZE;
>>    }
>>
>> -#ifdef CONFIG_DYNAMIC_FTRACE
>>    void arch_ftrace_update_code(int command)
>>    {
>>           mutex_lock(&text_mutex);
>> @@ -191,7 +191,12 @@ int ftrace_update_ftrace_func(ftrace_func_t func)
>>           return 0;
>>    }
>>
>> -#endif
>> +#else /* CONFIG_DYNAMIC_FTRACE */
>> +unsigned long ftrace_call_adjust(unsigned long addr)
>> +{
>> +       return addr;
>> +}
>> +#endif /* CONFIG_DYNAMIC_FTRACE */
>>
>>    #ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
>>    int ftrace_modify_call(struct dyn_ftrace *rec, unsigned long old_addr,
>>
> Hi Alex,
>
> Yes, this is valid, thanks for noticing and fixing the error. I would
> personally prefer leaving the #else /* CONFIG_DYNAMIC_FTRACE */ part
> in ftrace.h, but it can also come later as a refactor. Or, I can
> respin the series, with fixes on this and the previous patch, along
> with some typos and variable declarations that Robin mentioned.


If you can respin a new patchset soon, that's nice, in the meantime I 
keep this version + my fixes (without Robbin remarks though) in my 
for-next branch as we definitely want this in 6.16 :)

So it's up to you!

Thanks,

Alex


>
> Thanks,
> Andy

