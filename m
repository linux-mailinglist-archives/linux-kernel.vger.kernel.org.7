Return-Path: <linux-kernel+bounces-778099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E2E44B2E15F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 17:41:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7F5D580A0B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 15:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D5BF211479;
	Wed, 20 Aug 2025 15:37:10 +0000 (UTC)
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EFA13770B
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 15:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755704229; cv=none; b=aOtVCUwRIQr0qRpl+82w8Dc3xJm0opH7ZWH91x9y9/q2OcIcztCDirk0g7AzU62zfm4UzF4eKk2iOKA9WOmfoCKUUAYVlp5u1jTTi+GErc/A2pztIjGbuVPFOofd0by82wJHnODU8A0OnqJ0zEmsIFE9ACQy3IbNym5jGsvV4Og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755704229; c=relaxed/simple;
	bh=+6PYyrVVyfLw6XY7WGq6n6M7IPbesbCQREi0HFYWync=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ScYtIdEUNcEc/Vw5u+Bo7/hR93PdhCWxzrojiaB9p6TmCK9vS2qpQy0Nlt91b5g9dDQFGw3LK0haF7VpTsu0v7We+RlSm7L0E/0DiBXaX+wTWnqgIfXysS9v5LIivTz/939vxjKx9l1G4q/S9P2wNeZne6udDJ1s1E1ryxbt+x4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [192.168.0.110] (unknown [114.241.87.235])
	by APP-05 (Coremail) with SMTP id zQCowAAXq1uV66VopRy+DQ--.7550S2;
	Wed, 20 Aug 2025 23:36:54 +0800 (CST)
Message-ID: <800585ca-29ff-40ef-bddd-8cc14806dbb1@iscas.ac.cn>
Date: Wed, 20 Aug 2025 23:36:54 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] riscv: bitops: Convert to use_alternative_likely
To: Yury Norov <yury.norov@gmail.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>, Rasmus Villemoes
 <linux@rasmusvillemoes.dk>, Vivian Wang <uwu@dram.page>,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250820-riscv-altn-helper-wip-v1-0-c3c626c1f7e6@iscas.ac.cn>
 <20250820-riscv-altn-helper-wip-v1-5-c3c626c1f7e6@iscas.ac.cn>
 <aKXj_zTwvk0SwUpV@yury>
Content-Language: en-US
From: Vivian Wang <wangruikang@iscas.ac.cn>
In-Reply-To: <aKXj_zTwvk0SwUpV@yury>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:zQCowAAXq1uV66VopRy+DQ--.7550S2
X-Coremail-Antispam: 1UD129KBjvJXoWxZF4UZry5Aw47ZFWfAry5Jwb_yoW5Gw13pF
	n3K3ZxCFWkGa4fu3Zrtw1qgr1Fy397G343Gr9agr1kXF1qk3ySyr15K3WrCryrAFWvv34I
	vr4UCa4rC3Z8uFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUk2b7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4
	A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IE
	w4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMc
	vjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCY1x0262kKe7AKxVWUtVW8ZwCF04k2
	0xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI
	8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41l
	IxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIx
	AIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2
	jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjxUqVcEUUUUU
X-CM-SenderInfo: pzdqw2pxlnt03j6l2u1dvotugofq/

On 8/20/25 23:04, Yury Norov wrote:

> On Wed, Aug 20, 2025 at 09:44:49PM +0800, Vivian Wang wrote:
>> Use use_alternative_likely() to check for RISCV_ISA_EXT_ZBB, replacing
>> the use of asm goto with ALTERNATIVE.
>>
>> The "likely" variant is used to match the behavior of the original
>> implementation using ALTERNATIVE("j %l[legacy]", "nop", ...).
>>
>> Signed-off-by: Vivian Wang <wangruikang@iscas.ac.cn>
>> ---
>>  arch/riscv/include/asm/bitops.h | 112 ++++++++++++++++++----------------------
>>  1 file changed, 50 insertions(+), 62 deletions(-)
>>
>> diff --git a/arch/riscv/include/asm/bitops.h b/arch/riscv/include/asm/bitops.h
>> index d59310f74c2ba70caeb7b9b0e9221882117583f5..0257d547a96293909d90b017c8a48b508d0fd642 100644
>> --- a/arch/riscv/include/asm/bitops.h
>> +++ b/arch/riscv/include/asm/bitops.h
>> @@ -47,20 +47,17 @@
>>  
>>  static __always_inline unsigned long variable__ffs(unsigned long word)
>>  {
>> -	asm goto(ALTERNATIVE("j %l[legacy]", "nop", 0,
>> -				      RISCV_ISA_EXT_ZBB, 1)
>> -			  : : : : legacy);
>> -
>> -	asm volatile (".option push\n"
>> -		      ".option arch,+zbb\n"
>> -		      "ctz %0, %1\n"
>> -		      ".option pop\n"
>> -		      : "=r" (word) : "r" (word) :);
>> -
>> -	return word;
>> -
>> -legacy:
>> -	return generic___ffs(word);
>> +	if (use_alternative_likely(0, RISCV_ISA_EXT_ZBB)) {
> I don't think that 'likely' is used properly here. The likely/unlikely
> wording has a meaning of a hint to the compiler:
>
>         if (unlikely(WARN_ON(cond))
>                 goto err;
>
> In your case, it's just meaningless, because whatever is 'likely' for
> one CPU, will be always 'unlikely' for another. 

As mentioned in the reply for patch 1, I do believe that unfortunately
we currently have no way of leaving the decision up to the compiler, so
we have to pick one. The situation is similar to
static_branch_{likely,unlikely}.

So I have preserved the original choice made here: The original asm goto
uses the "likely" pattern, so I kept it as "likely".

>> +		asm volatile (".option push\n"
>> +			      ".option arch,+zbb\n"
>> +			      "ctz %0, %1\n"
>> +			      ".option pop\n"
>> +			      : "=r" (word) : "r" (word) :);
>> +
>> +		return word;
>> +	} else {
>> +		return generic___ffs(word);
>> +	}
>>  }
> This tabs wipe most of the history. Can you reorganize your patch
> such that it preserves as much history as you can?
>
>         if (use_alternative_unlikely(...))
>                 return generic___ffs();
>
>         asm volatile (".option push\n"
>                       ".option arch,+zbb\n"
>                       "ctz %0, %1\n"
>                       ".option pop\n"
>                       : "=r" (word) : "r" (word) :);
>
>         return word;
>
> And so on.

Thanks for the tip, I'll give it a go at minimizing the diff for v2.

Vivian "dramforever" Wang


