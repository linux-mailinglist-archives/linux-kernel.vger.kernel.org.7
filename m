Return-Path: <linux-kernel+bounces-736986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EEF9B0A651
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 16:25:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 830D1585FC8
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 14:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B5BF2DCF43;
	Fri, 18 Jul 2025 14:23:10 +0000 (UTC)
Received: from relay15.mail.gandi.net (relay15.mail.gandi.net [217.70.178.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A252DCBF5
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 14:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752848589; cv=none; b=ikoN/YyHi6ryiA8tPNGyyMvN3tFPxipqeZjeXy8ZuCoPqw0ZJkomT8MWE/sTu/7jRU8ir+cl9vwigi0dCz1fyu4qqjuRCUykb4p1T/Q0NhyS7qSbZaJ6lOipRifqnTNME3S0L67Rp/CgWJDApAcu5FGDGB0VnWv5Jhjxpmtx3J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752848589; c=relaxed/simple;
	bh=hX3IbLGKwnU11PAN+0mulvj/JkTXUyhcCd/13ZE6k9Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wy21TbOX0IULbrHX2j/OYV64QQQbKf7/jq5D7ORJw1knHU5nSqwdxvTBSFMBStLUaj2S7/Ll9vyuRDdkC6KHBuzA8Hq1FZ4EcNT004TeI5NPjFTY65UYfFkPoWRLKYxVLjEuvNyMiPYWrhpNvaQWMIr7FTkZvPT/KmrF4wRFJ6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.178.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 15719442C9;
	Fri, 18 Jul 2025 14:22:56 +0000 (UTC)
Message-ID: <404d38d7-f21b-4c97-b851-8b331deb3f8a@ghiti.fr>
Date: Fri, 18 Jul 2025 16:22:56 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [External] Re: [PATCH RFC 2/2] riscv: introduce percpu.h into
 include/asm
To: yunhui cui <cuiyunhui@bytedance.com>
Cc: yury.norov@gmail.com, linux@rasmusvillemoes.dk, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, dennis@kernel.org, tj@kernel.org,
 cl@gentwo.org, linux-mm@kvack.org
References: <20250618034328.21904-1-cuiyunhui@bytedance.com>
 <20250618034328.21904-2-cuiyunhui@bytedance.com>
 <c9ba6163-6703-441b-915c-d784044f862f@ghiti.fr>
 <b0583098-204a-4ad1-b173-4bd00a358d61@ghiti.fr>
 <CAEEQ3w=uz-kTe05-fnPa_BfkZ6ZocQHg-G001yBtLqRM2zEr+g@mail.gmail.com>
Content-Language: en-US
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <CAEEQ3w=uz-kTe05-fnPa_BfkZ6ZocQHg-G001yBtLqRM2zEr+g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeifeeilecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtvdejnecuhfhrohhmpeetlhgvgigrnhgurhgvucfihhhithhiuceorghlvgigsehghhhithhirdhfrheqnecuggftrfgrthhtvghrnhepuefffedvleetleetjefhjeehudejteetvedtvddvtdfhieetffelvdffgefgieeinecuffhomhgrihhnpehinhhfrhgruggvrggurdhorhhgnecukfhppedvtddtudemkeeiudemfeefkedvmegvfheltdemfedtfhgtmeegtdejtgemieehgehfmeefvdhfleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvtddtudemkeeiudemfeefkedvmegvfheltdemfedtfhgtmeegtdejtgemieehgehfmeefvdhfledphhgvlhhopeglkffrggeimedvtddtudemkeeiudemfeefkedvmegvfheltdemfedtfhgtmeegtdejtgemieehgehfmeefvdhflegnpdhmrghilhhfrhhomheprghlvgigsehghhhithhirdhfrhdpnhgspghrtghpthhtohepuddvpdhrtghpthhtoheptghuihihuhhnhhhuihessgihthgvuggrnhgtvgdrtghomhdprhgtphhtthhopeihuhhrhidrnhhorhhovhesghhmrghilhdrtghomhdprhgtphhtt
 hhopehlihhnuhigsehrrghsmhhushhvihhllhgvmhhovghsrdgukhdprhgtphhtthhopehprghulhdrfigrlhhmshhlvgihsehsihhfihhvvgdrtghomhdprhgtphhtthhopehprghlmhgvrhesuggrsggsvghlthdrtghomhdprhgtphhtthhopegrohhusegvvggtshdrsggvrhhkvghlvgihrdgvughupdhrtghpthhtoheplhhinhhugidqrhhishgtvheslhhishhtshdrihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh

Hi Yunhui,

On 7/18/25 08:40, yunhui cui wrote:
> Hi Alex,
>
> On Thu, Jul 17, 2025 at 9:06 PM Alexandre Ghiti <alex@ghiti.fr> wrote:
>> On 7/17/25 15:04, Alexandre Ghiti wrote:
>>> Hi Yunhui,
>>>
>>> On 6/18/25 05:43, Yunhui Cui wrote:
>>>> Current percpu operations rely on generic implementations, where
>>>> raw_local_irq_save() introduces substantial overhead. Optimization
>>>> is achieved through atomic operations and preemption disabling.
>>>>
>>>> Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
>>>> ---
>>>>    arch/riscv/include/asm/percpu.h | 138 ++++++++++++++++++++++++++++++++
>>>>    1 file changed, 138 insertions(+)
>>>>    create mode 100644 arch/riscv/include/asm/percpu.h
>>>>
>>>> diff --git a/arch/riscv/include/asm/percpu.h
>>>> b/arch/riscv/include/asm/percpu.h
>>>> new file mode 100644
>>>> index 0000000000000..423c0d01f874c
>>>> --- /dev/null
>>>> +++ b/arch/riscv/include/asm/percpu.h
>>>> @@ -0,0 +1,138 @@
>>>> +/* SPDX-License-Identifier: GPL-2.0-only */
>>>> +
>>>> +#ifndef __ASM_PERCPU_H
>>>> +#define __ASM_PERCPU_H
>>>> +
>>>> +#include <linux/preempt.h>
>>>> +
>>>> +#define PERCPU_RW_OPS(sz)                        \
>>>> +static inline unsigned long __percpu_read_##sz(void *ptr)        \
>>>> +{                                    \
>>>> +    return READ_ONCE(*(u##sz *)ptr);                \
>>>> +}                                    \
>>>> +                                    \
>>>> +static inline void __percpu_write_##sz(void *ptr, unsigned long
>>>> val)    \
>>>> +{                                    \
>>>> +    WRITE_ONCE(*(u##sz *)ptr, (u##sz)val);                \
>>>> +}
>>>> +
>>>> +#define __PERCPU_AMO_OP_CASE(sfx, name, sz, amo_insn)            \
>>>> +static inline void                            \
>>>> +__percpu_##name##_amo_case_##sz(void *ptr, unsigned long val)        \
>>>> +{                                    \
>>>> +    asm volatile (                            \
>>>> +    "amo" #amo_insn #sfx " zero, %[val], %[ptr]"            \
>>>> +    : [ptr] "+A" (*(u##sz *)ptr)                    \
>>>> +    : [val] "r" ((u##sz)(val))                    \
>>>> +    : "memory");                            \
>>>> +}
>>>> +
>>>> +#define __PERCPU_AMO_RET_OP_CASE(sfx, name, sz, amo_insn)        \
>>>> +static inline u##sz                            \
>>>> +__percpu_##name##_return_amo_case_##sz(void *ptr, unsigned long
>>>> val)    \
>>>> +{                                    \
>>>> +    register u##sz ret;                        \
>>>> +                                    \
>>>> +    asm volatile (                            \
>>>> +    "amo" #amo_insn #sfx " %[ret], %[val], %[ptr]"            \
>>>> +    : [ptr] "+A" (*(u##sz *)ptr), [ret] "=r" (ret)            \
>>>> +    : [val] "r" ((u##sz)(val))                    \
>>>> +    : "memory");                            \
>>>> +                                    \
>>>> +    return ret + val;                        \
>>>> +}
>>>> +
>>>> +#define PERCPU_OP(name, amo_insn)                    \
>>>> +    __PERCPU_AMO_OP_CASE(.b, name, 8, amo_insn)            \
>>>> +    __PERCPU_AMO_OP_CASE(.h, name, 16, amo_insn)            \
>>>> +    __PERCPU_AMO_OP_CASE(.w, name, 32, amo_insn)            \
>>>> +    __PERCPU_AMO_OP_CASE(.d, name, 64, amo_insn)            \
>>>> +
>>>> +#define PERCPU_RET_OP(name, amo_insn)                    \
>>>> +    __PERCPU_AMO_RET_OP_CASE(.b, name, 8, amo_insn) \
>>>> +    __PERCPU_AMO_RET_OP_CASE(.h, name, 16, amo_insn)        \
>>>> +    __PERCPU_AMO_RET_OP_CASE(.w, name, 32, amo_insn)        \
>>>> +    __PERCPU_AMO_RET_OP_CASE(.d, name, 64, amo_insn)
>>>> +
>>>> +PERCPU_RW_OPS(8)
>>>> +PERCPU_RW_OPS(16)
>>>> +PERCPU_RW_OPS(32)
>>>> +PERCPU_RW_OPS(64)
>>>> +
>>>> +PERCPU_OP(add, add)
>>>> +PERCPU_OP(andnot, and)
>>>> +PERCPU_OP(or, or)
>>>> +PERCPU_RET_OP(add, add)
>>>> +
>>>> +#undef PERCPU_RW_OPS
>>>> +#undef __PERCPU_AMO_OP_CASE
>>>> +#undef __PERCPU_AMO_RET_OP_CASE
>>>> +#undef PERCPU_OP
>>>> +#undef PERCPU_RET_OP
>>>> +
>>>> +#define _pcp_protect(op, pcp, ...)                    \
>>>> +({                                    \
>>>> +    preempt_disable_notrace();                    \
>>>> +    op(raw_cpu_ptr(&(pcp)), __VA_ARGS__);                \
>>>> +    preempt_enable_notrace();                    \
>>>> +})
>>>> +
>>>> +#define _pcp_protect_return(op, pcp, args...)                \
>>>> +({                                    \
>>>> +    typeof(pcp) __retval;                        \
>>>> +    preempt_disable_notrace();                    \
>>>> +    __retval = (typeof(pcp))op(raw_cpu_ptr(&(pcp)), ##args);    \
>>>> +    preempt_enable_notrace();                    \
>>>> +    __retval;                            \
>>>> +})
>>>> +
>>>> +#define this_cpu_read_1(pcp) _pcp_protect_return(__percpu_read_8, pcp)
>>>> +#define this_cpu_read_2(pcp) _pcp_protect_return(__percpu_read_16, pcp)
>>>> +#define this_cpu_read_4(pcp) _pcp_protect_return(__percpu_read_32, pcp)
>>>> +#define this_cpu_read_8(pcp) _pcp_protect_return(__percpu_read_64, pcp)
>>>> +
>>>> +#define this_cpu_write_1(pcp, val) _pcp_protect(__percpu_write_8,
>>>> pcp, (unsigned long)val)
>>>> +#define this_cpu_write_2(pcp, val) _pcp_protect(__percpu_write_16,
>>>> pcp, (unsigned long)val)
>>>> +#define this_cpu_write_4(pcp, val) _pcp_protect(__percpu_write_32,
>>>> pcp, (unsigned long)val)
>>>> +#define this_cpu_write_8(pcp, val) _pcp_protect(__percpu_write_64,
>>>> pcp, (unsigned long)val)
>>>> +
>>>> +#define this_cpu_add_1(pcp, val)
>>>> _pcp_protect(__percpu_add_amo_case_8, pcp, val)
>>>> +#define this_cpu_add_2(pcp, val)
>>>> _pcp_protect(__percpu_add_amo_case_16, pcp, val)
>>>> +#define this_cpu_add_4(pcp, val)
>>>> _pcp_protect(__percpu_add_amo_case_32, pcp, val)
>>>> +#define this_cpu_add_8(pcp, val)
>>>> _pcp_protect(__percpu_add_amo_case_64, pcp, val)
>>>> +
>>>> +#define this_cpu_add_return_1(pcp, val)        \
>>>> +_pcp_protect_return(__percpu_add_return_amo_case_8, pcp, val)
>>>> +
>>>> +#define this_cpu_add_return_2(pcp, val)        \
>>>> +_pcp_protect_return(__percpu_add_return_amo_case_16, pcp, val)
>>>> +
>>>> +#define this_cpu_add_return_4(pcp, val)        \
>>>> +_pcp_protect_return(__percpu_add_return_amo_case_32, pcp, val)
>>>> +
>>>> +#define this_cpu_add_return_8(pcp, val)        \
>>>> +_pcp_protect_return(__percpu_add_return_amo_case_64, pcp, val)
>>>> +
>>>> +#define this_cpu_and_1(pcp, val)
>>>> _pcp_protect(__percpu_andnot_amo_case_8, pcp, ~val)
>>>> +#define this_cpu_and_2(pcp, val)
>>>> _pcp_protect(__percpu_andnot_amo_case_16, pcp, ~val)
>>>> +#define this_cpu_and_4(pcp, val)
>>>> _pcp_protect(__percpu_andnot_amo_case_32, pcp, ~val)
>>>> +#define this_cpu_and_8(pcp, val)
>>>> _pcp_protect(__percpu_andnot_amo_case_64, pcp, ~val)
>>>
>>> Why do we define __percpu_andnot based on amoand, and use
>>> __percpu_andnot with ~val here? Can't we just define __percpu_and?


What about that ^?


>>>
>>>> +
>>>> +#define this_cpu_or_1(pcp, val) _pcp_protect(__percpu_or_amo_case_8,
>>>> pcp, val)
>>>> +#define this_cpu_or_2(pcp, val)
>>>> _pcp_protect(__percpu_or_amo_case_16, pcp, val)
>>>> +#define this_cpu_or_4(pcp, val)
>>>> _pcp_protect(__percpu_or_amo_case_32, pcp, val)
>>>> +#define this_cpu_or_8(pcp, val)
>>>> _pcp_protect(__percpu_or_amo_case_64, pcp, val)
>>>> +
>>>> +#define this_cpu_xchg_1(pcp, val) _pcp_protect_return(xchg_relaxed,
>>>> pcp, val)
>>>> +#define this_cpu_xchg_2(pcp, val) _pcp_protect_return(xchg_relaxed,
>>>> pcp, val)
>>>> +#define this_cpu_xchg_4(pcp, val) _pcp_protect_return(xchg_relaxed,
>>>> pcp, val)
>>>> +#define this_cpu_xchg_8(pcp, val) _pcp_protect_return(xchg_relaxed,
>>>> pcp, val)
>>>> +
>>>> +#define this_cpu_cmpxchg_1(pcp, o, n)
>>>> _pcp_protect_return(cmpxchg_relaxed, pcp, o, n)
>>>> +#define this_cpu_cmpxchg_2(pcp, o, n)
>>>> _pcp_protect_return(cmpxchg_relaxed, pcp, o, n)
>>>> +#define this_cpu_cmpxchg_4(pcp, o, n)
>>>> _pcp_protect_return(cmpxchg_relaxed, pcp, o, n)
>>>> +#define this_cpu_cmpxchg_8(pcp, o, n)
>>>> _pcp_protect_return(cmpxchg_relaxed, pcp, o, n)
>>>> +
>>>> +#include <asm-generic/percpu.h>
>>>> +
>>>> +#endif /* __ASM_PERCPU_H */
>>>
>>> It all looks good to me, just one thing, can you also implement
>>> this_cpu_cmpxchg64/128()?
>>>
>> One last thing sorry, can you add a cover letter too?
> Okay.
>
>> Thanks!
>>
>> Alex
>>
>>
>>> And since this is almost a copy/paste from arm64, either mention it at
>>> the top of the file or (better) merge both implementations somewhere
>>> to avoid redefining existing code :) But up to you.
> Actually, there's a concern here. We should account for scenarios
> where ZABHA isn't supported. Given that xxx_8() and xxx_16() are
> rarely used in practice, could we initially support only xxx_32() and
> xxx_64()? For xxx_8() and xxx_16(), we could default to the generic
> implementation.


Why isn't lr/sc enough?


>
>
>>> Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
>>>
>>> Thanks,
>>>
>>> Alex
>>>
>>>
>>>
> Thanks,
> Yunhui
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

