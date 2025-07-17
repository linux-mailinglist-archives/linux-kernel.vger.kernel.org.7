Return-Path: <linux-kernel+bounces-735328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D6A3B08DD7
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 15:05:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F46D16E6DC
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 13:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 214622C374B;
	Thu, 17 Jul 2025 13:04:32 +0000 (UTC)
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4A329E0F0
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 13:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752757471; cv=none; b=hZTtKI0tNb5jo5tVEu2BcNi/s3TKCdKCYo3hRkbSgXs0y0aQ/ywj3oY2H8zYQQ6HNEbauWU85pyWZ9SiLIV/N1VeH3CvfLtOSQx4FObBSkUnoY9kfdwHRu75RYtmiCYUbykF5CKk6viNtyUBRCv3oe9C7N0L6zO3Z8BYPBOuiGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752757471; c=relaxed/simple;
	bh=qkPsoDqnM3r2ppec/sCnOUprALKeMus65hQBw9GelUk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ucSztHlLX6BZpo2DiFQIswm49hxXkZfSD0vW3quwUte+Ju9r0G0NCK8PKQr4tJWbdo4qhtEcZ3PqrOET+KmaCDswabA/1ERox5pi7r/SoW076GpEgGAgJsEBCnAO/sPD/PMUEFDsJ1wP8yUCG7R1CZMPkPRLT3kvWofigrSTtQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6497E44380;
	Thu, 17 Jul 2025 13:04:24 +0000 (UTC)
Message-ID: <c9ba6163-6703-441b-915c-d784044f862f@ghiti.fr>
Date: Thu, 17 Jul 2025 15:04:22 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 2/2] riscv: introduce percpu.h into include/asm
To: Yunhui Cui <cuiyunhui@bytedance.com>, yury.norov@gmail.com,
 linux@rasmusvillemoes.dk, paul.walmsley@sifive.com, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, dennis@kernel.org, tj@kernel.org,
 cl@gentwo.org, linux-mm@kvack.org
References: <20250618034328.21904-1-cuiyunhui@bytedance.com>
 <20250618034328.21904-2-cuiyunhui@bytedance.com>
Content-Language: en-US
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20250618034328.21904-2-cuiyunhui@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeitdeihecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvfhfhjggtgfesthejredttddvjeenucfhrhhomheptehlvgigrghnughrvgcuifhhihhtihcuoegrlhgvgiesghhhihhtihdrfhhrqeenucggtffrrghtthgvrhhnpeeufeegheehgedtvdegleegjeejfedukeegteffieejgfevjeduheffffdtlefhhfenucfkphepudekhedrvddufedrudehgedrudehudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedukeehrddvudefrdduheegrdduhedupdhhvghloheplgdutddrudegrddtrddufegnpdhmrghilhhfrhhomheprghlvgigsehghhhithhirdhfrhdpnhgspghrtghpthhtohepuddvpdhrtghpthhtoheptghuihihuhhnhhhuihessgihthgvuggrnhgtvgdrtghomhdprhgtphhtthhopeihuhhrhidrnhhorhhovhesghhmrghilhdrtghomhdprhgtphhtthhopehlihhnuhigsehrrghsmhhushhvihhllhgvmhhovghsrdgukhdprhgtphhtthhopehprghulhdrfigrlhhmshhlvgihsehsihhfihhvvgdrtghomhdprhgtphhtthhopehprghlmhgvrhesuggrsggsvghlthdrtghomhdprhgtphhtthhopegrohhusegvvggtshdrs
 ggvrhhkvghlvgihrdgvughupdhrtghpthhtoheplhhinhhugidqrhhishgtvheslhhishhtshdrihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-GND-Sasl: alex@ghiti.fr

Hi Yunhui,

On 6/18/25 05:43, Yunhui Cui wrote:
> Current percpu operations rely on generic implementations, where
> raw_local_irq_save() introduces substantial overhead. Optimization
> is achieved through atomic operations and preemption disabling.
>
> Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> ---
>   arch/riscv/include/asm/percpu.h | 138 ++++++++++++++++++++++++++++++++
>   1 file changed, 138 insertions(+)
>   create mode 100644 arch/riscv/include/asm/percpu.h
>
> diff --git a/arch/riscv/include/asm/percpu.h b/arch/riscv/include/asm/percpu.h
> new file mode 100644
> index 0000000000000..423c0d01f874c
> --- /dev/null
> +++ b/arch/riscv/include/asm/percpu.h
> @@ -0,0 +1,138 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +
> +#ifndef __ASM_PERCPU_H
> +#define __ASM_PERCPU_H
> +
> +#include <linux/preempt.h>
> +
> +#define PERCPU_RW_OPS(sz)						\
> +static inline unsigned long __percpu_read_##sz(void *ptr)		\
> +{									\
> +	return READ_ONCE(*(u##sz *)ptr);				\
> +}									\
> +									\
> +static inline void __percpu_write_##sz(void *ptr, unsigned long val)	\
> +{									\
> +	WRITE_ONCE(*(u##sz *)ptr, (u##sz)val);				\
> +}
> +
> +#define __PERCPU_AMO_OP_CASE(sfx, name, sz, amo_insn)			\
> +static inline void							\
> +__percpu_##name##_amo_case_##sz(void *ptr, unsigned long val)		\
> +{									\
> +	asm volatile (							\
> +	"amo" #amo_insn #sfx " zero, %[val], %[ptr]"			\
> +	: [ptr] "+A" (*(u##sz *)ptr)					\
> +	: [val] "r" ((u##sz)(val))					\
> +	: "memory");							\
> +}
> +
> +#define __PERCPU_AMO_RET_OP_CASE(sfx, name, sz, amo_insn)		\
> +static inline u##sz							\
> +__percpu_##name##_return_amo_case_##sz(void *ptr, unsigned long val)	\
> +{									\
> +	register u##sz ret;						\
> +									\
> +	asm volatile (							\
> +	"amo" #amo_insn #sfx " %[ret], %[val], %[ptr]"			\
> +	: [ptr] "+A" (*(u##sz *)ptr), [ret] "=r" (ret)			\
> +	: [val] "r" ((u##sz)(val))					\
> +	: "memory");							\
> +									\
> +	return ret + val;						\
> +}
> +
> +#define PERCPU_OP(name, amo_insn)					\
> +	__PERCPU_AMO_OP_CASE(.b, name, 8, amo_insn)			\
> +	__PERCPU_AMO_OP_CASE(.h, name, 16, amo_insn)			\
> +	__PERCPU_AMO_OP_CASE(.w, name, 32, amo_insn)			\
> +	__PERCPU_AMO_OP_CASE(.d, name, 64, amo_insn)			\
> +
> +#define PERCPU_RET_OP(name, amo_insn)					\
> +	__PERCPU_AMO_RET_OP_CASE(.b, name, 8, amo_insn)			\
> +	__PERCPU_AMO_RET_OP_CASE(.h, name, 16, amo_insn)		\
> +	__PERCPU_AMO_RET_OP_CASE(.w, name, 32, amo_insn)		\
> +	__PERCPU_AMO_RET_OP_CASE(.d, name, 64, amo_insn)
> +
> +PERCPU_RW_OPS(8)
> +PERCPU_RW_OPS(16)
> +PERCPU_RW_OPS(32)
> +PERCPU_RW_OPS(64)
> +
> +PERCPU_OP(add, add)
> +PERCPU_OP(andnot, and)
> +PERCPU_OP(or, or)
> +PERCPU_RET_OP(add, add)
> +
> +#undef PERCPU_RW_OPS
> +#undef __PERCPU_AMO_OP_CASE
> +#undef __PERCPU_AMO_RET_OP_CASE
> +#undef PERCPU_OP
> +#undef PERCPU_RET_OP
> +
> +#define _pcp_protect(op, pcp, ...)					\
> +({									\
> +	preempt_disable_notrace();					\
> +	op(raw_cpu_ptr(&(pcp)), __VA_ARGS__);				\
> +	preempt_enable_notrace();					\
> +})
> +
> +#define _pcp_protect_return(op, pcp, args...)				\
> +({									\
> +	typeof(pcp) __retval;						\
> +	preempt_disable_notrace();					\
> +	__retval = (typeof(pcp))op(raw_cpu_ptr(&(pcp)), ##args);	\
> +	preempt_enable_notrace();					\
> +	__retval;							\
> +})
> +
> +#define this_cpu_read_1(pcp)		_pcp_protect_return(__percpu_read_8, pcp)
> +#define this_cpu_read_2(pcp)		_pcp_protect_return(__percpu_read_16, pcp)
> +#define this_cpu_read_4(pcp)		_pcp_protect_return(__percpu_read_32, pcp)
> +#define this_cpu_read_8(pcp)		_pcp_protect_return(__percpu_read_64, pcp)
> +
> +#define this_cpu_write_1(pcp, val)	_pcp_protect(__percpu_write_8, pcp, (unsigned long)val)
> +#define this_cpu_write_2(pcp, val)	_pcp_protect(__percpu_write_16, pcp, (unsigned long)val)
> +#define this_cpu_write_4(pcp, val)	_pcp_protect(__percpu_write_32, pcp, (unsigned long)val)
> +#define this_cpu_write_8(pcp, val)	_pcp_protect(__percpu_write_64, pcp, (unsigned long)val)
> +
> +#define this_cpu_add_1(pcp, val)	_pcp_protect(__percpu_add_amo_case_8, pcp, val)
> +#define this_cpu_add_2(pcp, val)	_pcp_protect(__percpu_add_amo_case_16, pcp, val)
> +#define this_cpu_add_4(pcp, val)	_pcp_protect(__percpu_add_amo_case_32, pcp, val)
> +#define this_cpu_add_8(pcp, val)	_pcp_protect(__percpu_add_amo_case_64, pcp, val)
> +
> +#define this_cpu_add_return_1(pcp, val)		\
> +_pcp_protect_return(__percpu_add_return_amo_case_8, pcp, val)
> +
> +#define this_cpu_add_return_2(pcp, val)		\
> +_pcp_protect_return(__percpu_add_return_amo_case_16, pcp, val)
> +
> +#define this_cpu_add_return_4(pcp, val)		\
> +_pcp_protect_return(__percpu_add_return_amo_case_32, pcp, val)
> +
> +#define this_cpu_add_return_8(pcp, val)		\
> +_pcp_protect_return(__percpu_add_return_amo_case_64, pcp, val)
> +
> +#define this_cpu_and_1(pcp, val)	_pcp_protect(__percpu_andnot_amo_case_8, pcp, ~val)
> +#define this_cpu_and_2(pcp, val)	_pcp_protect(__percpu_andnot_amo_case_16, pcp, ~val)
> +#define this_cpu_and_4(pcp, val)	_pcp_protect(__percpu_andnot_amo_case_32, pcp, ~val)
> +#define this_cpu_and_8(pcp, val)	_pcp_protect(__percpu_andnot_amo_case_64, pcp, ~val)


Why do we define __percpu_andnot based on amoand, and use 
__percpu_andnot with ~val here? Can't we just define __percpu_and?


> +
> +#define this_cpu_or_1(pcp, val)	_pcp_protect(__percpu_or_amo_case_8, pcp, val)
> +#define this_cpu_or_2(pcp, val)	_pcp_protect(__percpu_or_amo_case_16, pcp, val)
> +#define this_cpu_or_4(pcp, val)	_pcp_protect(__percpu_or_amo_case_32, pcp, val)
> +#define this_cpu_or_8(pcp, val)	_pcp_protect(__percpu_or_amo_case_64, pcp, val)
> +
> +#define this_cpu_xchg_1(pcp, val)	_pcp_protect_return(xchg_relaxed, pcp, val)
> +#define this_cpu_xchg_2(pcp, val)	_pcp_protect_return(xchg_relaxed, pcp, val)
> +#define this_cpu_xchg_4(pcp, val)	_pcp_protect_return(xchg_relaxed, pcp, val)
> +#define this_cpu_xchg_8(pcp, val)	_pcp_protect_return(xchg_relaxed, pcp, val)
> +
> +#define this_cpu_cmpxchg_1(pcp, o, n)	_pcp_protect_return(cmpxchg_relaxed, pcp, o, n)
> +#define this_cpu_cmpxchg_2(pcp, o, n)	_pcp_protect_return(cmpxchg_relaxed, pcp, o, n)
> +#define this_cpu_cmpxchg_4(pcp, o, n)	_pcp_protect_return(cmpxchg_relaxed, pcp, o, n)
> +#define this_cpu_cmpxchg_8(pcp, o, n)	_pcp_protect_return(cmpxchg_relaxed, pcp, o, n)
> +
> +#include <asm-generic/percpu.h>
> +
> +#endif /* __ASM_PERCPU_H */


It all looks good to me, just one thing, can you also implement 
this_cpu_cmpxchg64/128()?

And since this is almost a copy/paste from arm64, either mention it at 
the top of the file or (better) merge both implementations somewhere to 
avoid redefining existing code :) But up to you.

Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Thanks,

Alex



