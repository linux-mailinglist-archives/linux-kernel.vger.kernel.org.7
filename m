Return-Path: <linux-kernel+bounces-780404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CA7AB30158
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 19:46:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 064CD7B177D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 17:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D978E34164B;
	Thu, 21 Aug 2025 17:46:38 +0000 (UTC)
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B209F1EB5B
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 17:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755798398; cv=none; b=LgAIDhHYtUqkVobXj+uJq0IEtnSz1CnBXFUg4lEdpMKKEThY92oZeGgSF5fZEZ+jdTe0i7VRqHdP8CDZeeAQD5j9tEc1drGClYu578UwXZC6y3ot+lemgDOZETMtUXzAqmjTjomhoaEfW2xjfgE7oas/wEtdy4IUgiABkiu2Gls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755798398; c=relaxed/simple;
	bh=T7i6VQ3gW+C6nSX0QDUuQ8Gc9MuqwC3zjyct9IN78/Q=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=gtFkh0ebw2ggssHO8dgPvhQgtFDJETDK2EwxkNpGxWB/R4kcOACmrk6rZDglOKblHGS25RIGkahBwwLPh4nCV6RQMYi5+ubwjZ0y4JobkTMvSCiYxvWgAB/UjyLLAABoDeceVD8zI26qtw+kW+KcqD85G+xUiMBBL7V9wJixwTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [192.168.0.104] (unknown [114.241.87.235])
	by APP-01 (Coremail) with SMTP id qwCowAB3pKhrW6doTDMdDg--.21682S2;
	Fri, 22 Aug 2025 01:46:19 +0800 (CST)
Message-ID: <4dba27c4-e7a5-4ffc-8073-08a83c68e527@iscas.ac.cn>
Date: Fri, 22 Aug 2025 01:46:19 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Vivian Wang <wangruikang@iscas.ac.cn>
Subject: Re: [PATCH v2 4/5] riscv: bitops: Use __riscv_has_extension_likely
To: Yury Norov <yury.norov@gmail.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>, Rasmus Villemoes
 <linux@rasmusvillemoes.dk>, Charlie Jenkins <charlie@rivosinc.com>,
 Xiao Wang <xiao.w.wang@intel.com>,
 =?UTF-8?Q?Christoph_M=C3=BCllner?= <christoph.muellner@vrull.eu>,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 Vivian Wang <uwu@dram.page>
References: <20250821-riscv-altn-helper-wip-v2-0-9586fa702f78@iscas.ac.cn>
 <20250821-riscv-altn-helper-wip-v2-4-9586fa702f78@iscas.ac.cn>
 <aKcwtXDJKRf4O_tF@yury>
Content-Language: en-US
In-Reply-To: <aKcwtXDJKRf4O_tF@yury>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowAB3pKhrW6doTDMdDg--.21682S2
X-Coremail-Antispam: 1UD129KBjvJXoWxCryUJFyftFykZrWxWw4kZwb_yoW5CF15pr
	9ayFyDKF4kJw1UCF97Ar1xAF1Fy393W3yfGrZIgr98JF12yw1Sgrn0k3WF9ryIyFWv9ryU
	uF4xG343Aa17CaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvmb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I
	8E87Iv6xkF7I0E14v26r4j6r4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
	0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr
	1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7
	MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r
	4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF
	67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2I
	x0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2
	z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnU
	UI43ZEXa7IU56yI5UUUUU==
X-CM-SenderInfo: pzdqw2pxlnt03j6l2u1dvotugofq/

On 8/21/25 22:44, Yury Norov wrote:

> On Thu, Aug 21, 2025 at 05:16:34PM +0800, Vivian Wang wrote:
>> Use __riscv_has_extension_likely() to check for RISCV_ISA_EXT_ZBB,
>> replacing the use of asm goto with ALTERNATIVE.
>>
>> The "likely" variant is used to match the behavior of the original
>> implementation using ALTERNATIVE("j %l[legacy]", "nop", ...).
>>
>> Signed-off-by: Vivian Wang <wangruikang@iscas.ac.cn>
>> ---
>>  arch/riscv/include/asm/bitops.h | 32 ++++++++------------------------
>>  1 file changed, 8 insertions(+), 24 deletions(-)
>>
>> diff --git a/arch/riscv/include/asm/bitops.h b/arch/riscv/include/asm/bitops.h
>> index d59310f74c2ba70caeb7b9b0e9221882117583f5..f70ccc0c2ffb86a6fda3bc373504143d0c6a1093 100644
>> --- a/arch/riscv/include/asm/bitops.h
>> +++ b/arch/riscv/include/asm/bitops.h
>> @@ -47,9 +47,8 @@
>>  
>>  static __always_inline unsigned long variable__ffs(unsigned long word)
>>  {
>> -	asm goto(ALTERNATIVE("j %l[legacy]", "nop", 0,
>> -				      RISCV_ISA_EXT_ZBB, 1)
>> -			  : : : : legacy);
>> +	if (!__riscv_has_extension_likely(0, RISCV_ISA_EXT_ZBB))
>> +		return generic___ffs(word);
> So, on the previous round you spent quite a lot of time explaining how
> 'unlikely()' version is handy over '!likely()', and now use just the
> latter. I feel really lost about how the code generation should look.

It's not "handy". The operative part is "has_extension", and both
functions return true if the extension is available and false if not.
Functionally:

    if (likely()) <-- equivalent --> if (unlikely())
    if (!likely()) <-- equivalent --> if (!unlikely())

Whereas:

    if (likely()) <-- **opposite of** --> if (!unlikely())
    if (unlikely()) <-- **opposite of** --> if (!likely())

All the asm goto dispatch stuff work like this:
static_branch_{likely,unlikely}, (arm64)
alternative_has_cap_{likely,unlikely},
__riscv_has_extension_{likely,unlikely}. Maybe it's confusing, but it
seems to be the convention.

And, codegen-wise:

ALTERNATIVE("j %l[no_alt]", "nop", ...) -> likely() ALTERNATIVE("nop",
"j %l[has_alt]", ...) -> unlikely()

Since the original code has the "likely" pattern, using "if (likely())"
preserves it. Whatever the codegen was, it's still the same.

> Can you please share bloat-o-meter report against this patch? Can you
> also show an example of code generation before and after? Have you
> tried the 'unlikely()` one? How the output looks?

Thanks for the tip on bloat-o-meter. I'll take a look tomorrow.

>>  	asm volatile (".option push\n"
>>  		      ".option arch,+zbb\n"
> Yeah, now the diff is much cleaner. Thanks.

This is why the condition at the top needed to be "!has_extension". So
the structure can be:

    if (!has_extension)
        return sw_version;

    multi_line
    zbb_version;

If I used "if (has_extension)" the code would need be

    if (has_extension) {
        multi_line
        zbb_version;
    } else {
        sw_version;
    }

And whether it was "likely" or "unlikely" had no bearing on the
structure of the code.

Vivian "dramforever" Wang


