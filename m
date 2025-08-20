Return-Path: <linux-kernel+bounces-778092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CFAB3B2E13D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 17:35:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 614D41C878E7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 15:28:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F86932276B;
	Wed, 20 Aug 2025 15:25:55 +0000 (UTC)
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C2D36CDF0
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 15:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755703554; cv=none; b=lKfdZurI4rOtQrKmcDB3E3zKwk5N+hzckmvaNX41smKTxAPm2mQZIq4jPUP58hHk5ZWZ4BrnJnBoJPJ5LovLpGYNdkAaCbedxz1lUoX/9/XGrSfwMxuL8iWDWrRBNAcT3azhHRe5jycxHG3UP3a315b/hoXbwa0rimcb3Ub/U3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755703554; c=relaxed/simple;
	bh=g4PXaaeVsThK1sTCvKKYodOttxogDDBSbOid3oIpN64=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dvjwVt1rTNAL2sCyfFFS81SKSxMjWSABiPcLQE+/2JmtuQxD7L7ML6uUgF4r7fxzwC/UoSNdFDAfx1fWMPOccYvqmO0f9Wv72NxccsrgrkEcuwj9jZNeqkrrko7hWsAVViZqFjNPEgt7DrZg2nIQQr+K7he2390Ruw7Df9jlsUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [192.168.0.110] (unknown [114.241.87.235])
	by APP-05 (Coremail) with SMTP id zQCowACHHF3q6KVoZZq9DQ--.1809S2;
	Wed, 20 Aug 2025 23:25:30 +0800 (CST)
Message-ID: <544577b2-6810-4bef-b588-e1c662d5be13@iscas.ac.cn>
Date: Wed, 20 Aug 2025 23:25:30 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] riscv: Introduce use_alternative_{likely,unlikely}
To: Yury Norov <yury.norov@gmail.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>, Rasmus Villemoes
 <linux@rasmusvillemoes.dk>, Vivian Wang <uwu@dram.page>,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 =?UTF-8?Q?Ayd=C4=B1n_Mercan?= <aydin@mercan.dev>
References: <20250820-riscv-altn-helper-wip-v1-0-c3c626c1f7e6@iscas.ac.cn>
 <20250820-riscv-altn-helper-wip-v1-1-c3c626c1f7e6@iscas.ac.cn>
 <aKXiH1eqGliLNb8u@yury>
Content-Language: en-US
From: Vivian Wang <wangruikang@iscas.ac.cn>
In-Reply-To: <aKXiH1eqGliLNb8u@yury>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowACHHF3q6KVoZZq9DQ--.1809S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAw4fAw4xtr45Ar4DJFyrWFg_yoWruFWkpF
	45G3Z0yF4kJF1xtF9Fqw1UZr4Y934rK3y3XF9Igr1DA3ZIy34ftryrKr15uryay3s8u342
	vF1xJa48C3W2kFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvvb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4
	A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IE
	w4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMc
	vjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY
	1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8Jw
	C20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAF
	wI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjx
	v20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2
	jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73Uj
	IFyTuYvjxUqiFxDUUUU
X-CM-SenderInfo: pzdqw2pxlnt03j6l2u1dvotugofq/

Hi Yury,

Thanks for the review.

On 8/20/25 22:56, Yury Norov wrote:
> On Wed, Aug 20, 2025 at 09:44:45PM +0800, Vivian Wang wrote:
>> Introduce convenience helpers use_alternative_likely() and
>> use_alternative_unlikely() to implement the pattern of using asm goto to
>> check if an alternative is selected. Existing code will be converted in
>> subsequent patches.
>>
>> Similar to arm64 alternative_has_cap_{likely,unlikely}, but for riscv,
>> alternatives are not all CPU capabilities.
>>
>> Suggested-by: Aydın Mercan <aydin@mercan.dev>
>> Signed-off-by: Vivian Wang <wangruikang@iscas.ac.cn>
>> ---
>>  arch/riscv/include/asm/alternative-macros.h | 73 +++++++++++++++++++++++++++++
>>  1 file changed, 73 insertions(+)
>>
>> diff --git a/arch/riscv/include/asm/alternative-macros.h b/arch/riscv/include/asm/alternative-macros.h
>> index 231d777d936c2d29c858decaa9a3fa5f172efbb8..be9835b5e4eba03d76db3a73da19ac9e2981c4db 100644
>> --- a/arch/riscv/include/asm/alternative-macros.h
>> +++ b/arch/riscv/include/asm/alternative-macros.h
>> @@ -158,4 +158,77 @@
>>  	_ALTERNATIVE_CFG_2(old_content, new_content_1, vendor_id_1, patch_id_1, CONFIG_k_1,	\
>>  					new_content_2, vendor_id_2, patch_id_2, CONFIG_k_2)
>>  
>> +/*
>> + * use_alternative_{likely,unlikely}() returns true if the alternative is
>> + * applied and false otherwise, but in a way where the compiler can optimize
>> + * this check down to a nop instruction that's patched into a jump, or vice
>> + * versa.
>> + *
>> + * Always returns false if the alternatives mechanism is not available.
>> + *
>> + * Usage example:
>> + *   if (use_alternative_likely(0, RISCV_ISA_ZBB))
>> + *
>> + * Similar to static keys, "likely" means use a nop if the alternative is
>> + * selected, and jump if unselected; "unlikely" is the other way around.
>> + */
>> +
>> +#ifndef __ASSEMBLER__
>> +
>> +#include <linux/types.h>
>> +
>> +#ifdef CONFIG_RISCV_ALTERNATIVE
>> +
>> +static __always_inline bool use_alternative_likely(u16 vendor_id, u32 patch_id)
>> +{
>> +	BUILD_BUG_ON(!__builtin_constant_p(vendor_id));
>> +	BUILD_BUG_ON(!__builtin_constant_p(patch_id));
>> +
>> +	asm goto(ALTERNATIVE("j %l[no_alt]", "nop", %[vendor_id], %[patch_id], 1)
>> +		 :
>> +		 : [vendor_id] "i"(vendor_id),
>> +		   [patch_id] "i"(patch_id)
>> +		 :
>> +		 : no_alt);
>> +
>> +	return true;
>> +
>> +no_alt:
>> +	return false;
>> +}
> Apart from those BUILD_BUG_ON()s, it looks similar to
> __riscv_has_extension_likely(). Can you make sure you don't duplicate
> it?
>
> If so, can you describe what's the difference between those two in the
> commit message?

Whoops, *completely* missed that. Thanks for the catch.

It turns out I was trying to find uses of this pattern by searching for
"j<space>%l[...]". The block in __riscv_has_extension_{likely,unlikely}
uses "j<tab>%l[...]".

I'll just use __riscv_has_extension_{likely,unlikely} in v2 and drop this.

>> +static __always_inline bool use_alternative_unlikely(u16 vendor_id, u32 patch_id)
>> +{
>> +	BUILD_BUG_ON(!__builtin_constant_p(vendor_id));
>> +	BUILD_BUG_ON(!__builtin_constant_p(patch_id));
>> +
>> +	asm goto(ALTERNATIVE("nop", "j %l[alt]", %[vendor_id], %[patch_id], 1)
>> +		 :
>> +		 : [vendor_id] "i"(vendor_id),
>> +		   [patch_id] "i"(patch_id)
>> +		 :
>> +		 : alt);
>> +
>> +	return false;
>> +
>> +alt:
>> +	return true;
>> +}
> This 'unlikely' version is just an negation of 'likely' one, and it
> looks like an attempt to save on one negation. On the other hand, the
> function is __always_inline, which means that compiler should normally
> take care of it. Can you prove with objdump that it really works as
> intended? I mean that 
>
>         if (use_alternative_unlikely())
>                 do_something();
>
> generates a better code than 
>         
>         if (!use_alternative_likely())
>                 do_something();

use_alternative_likely() and use_alternative_unlikely() are not
negations of each other and in fact should be functionally equivalent. I
also briefly explained the difference in the comment, but the difference
is which case is nop i.e. fallthrough, and which case requires a jump
instruction. The likely case should get a "nop", and the unlikely case
should get a "j %l[...]". This choice does work as intended [1].

I don't think it is possible to give both options to the compiler, so at
least for now AIUI users have to pick one.

The same applies to __riscv_has_extension_{likely,unlikely}.

Vivian "dramforever" Wang

[1]: https://godbolt.org/z/v8zTEhzTx



