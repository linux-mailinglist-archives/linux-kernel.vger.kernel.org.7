Return-Path: <linux-kernel+bounces-825620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C010B8C577
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 12:22:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3F17E4E11B3
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 10:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 143482F616A;
	Sat, 20 Sep 2025 10:22:25 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C137426E712;
	Sat, 20 Sep 2025 10:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758363744; cv=none; b=WHVqHufH03cyYbcaRhn+kdMxb9aJMtjFFe4Yr37xihC0/733x9IAauJwo6oNtHb5ytVPrbZwblTo+I/UoUgLRqHXkFUzNJWCcehHdB5PNopuEILm5X5Sh5eKt9QW5rU7Nr5waqe4NrlZk7hBMUGo0pkZXHqyVMq7RzAyRumok0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758363744; c=relaxed/simple;
	bh=AMr0dm6XYmM343FpYxFM70WEL37BjWwZQn2RFC6QeBM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=KReAHp9I7msn2sACZThtIHFfE9rISAD4bJLlfNUCdPKAwu5HOKXBUtYSZnT7XqgJDkTg4rvSneHnzLzC2gN+vnuS98Z9nlQXcXIaadxk/cvfYSXfve+U6sDpwwh3kNCn5aZWroQ69cbR8a90G8oTP7dBcBO9/8TR9/HJzAX5juU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [117.22.84.112])
	by gateway (Coremail) with SMTP id _____8AxSNFYgM5ofIoMAA--.27483S3;
	Sat, 20 Sep 2025 18:22:16 +0800 (CST)
Received: from [192.168.0.111] (unknown [117.22.84.112])
	by front1 (Coremail) with SMTP id qMiowJCxH8JSgM5oE0+hAA--.1490S3;
	Sat, 20 Sep 2025 18:22:10 +0800 (CST)
Message-ID: <7eafa4a6-55bf-2fcb-19ef-b18bd51bfd39@loongson.cn>
Date: Sat, 20 Sep 2025 18:22:11 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v1 1/2] LoongArch: Make LTO case independent in Makefile
Content-Language: en-US
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>, Nathan Chancellor <nathan@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, WANG Rui <wangrui@loongson.cn>,
 rust-for-linux@vger.kernel.org, loongarch@lists.linux.dev,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev
References: <20250909092707.3127-1-yangtiezhu@loongson.cn>
 <20250909092707.3127-2-yangtiezhu@loongson.cn>
 <20250920061536.GA1460394@ax162>
 <CAAhV-H5=w82CDx=1=PZjf4FVW_dGWe_e__QazwDTwE3kKXtPLQ@mail.gmail.com>
 <c9c4c0e6-946d-95de-9c03-a4b8e1636b81@loongson.cn>
In-Reply-To: <c9c4c0e6-946d-95de-9c03-a4b8e1636b81@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJCxH8JSgM5oE0+hAA--.1490S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWxKw1fXrW7uF1fWw4rWr43twc_yoW7Xr1Dpw
	s7CFyDKrWrJr4ktr9rtw45XFy5tr4Dtw1xXF1UtF18AFsFvr1Yqr18Xr1qgFykJws7JrWI
	qryrGFy7ZF4UAwbCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9Fb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4
	xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v2
	6r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67
	vIY487MxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
	6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17
	CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF
	0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIx
	AIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2
	KfnxnUUI43ZEXa7IU8VwZ7UUUUU==

On 9/20/25 17:19, Tiezhu Yang wrote:
> On 9/20/25 16:23, Huacai Chen wrote:
>> On Sat, Sep 20, 2025 at 2:15 PM Nathan Chancellor <nathan@kernel.org> 
>> wrote:
>>>
>>> Hi Tiezhu,
>>>
>>> On Tue, Sep 09, 2025 at 05:27:06PM +0800, Tiezhu Yang wrote:
>>>> LTO is not only used for Clang, it maybe used for Rust, make LTO 
>>>> case out
>>>> of CONFIG_CC_HAS_ANNOTATE_TABLEJUMP in Makefile.
>>>>
>>>> This is preparation for later patch, no function changes.
>>>>
>>>> Suggested-by: WANG Rui <wangrui@loongson.cn>
>>>> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
>>>> ---
>>>>   arch/loongarch/Makefile | 10 +++++-----
>>>>   1 file changed, 5 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/arch/loongarch/Makefile b/arch/loongarch/Makefile
>>>> index a3a9759414f4..9d80af7f75c8 100644
>>>> --- a/arch/loongarch/Makefile
>>>> +++ b/arch/loongarch/Makefile
>>>> @@ -102,16 +102,16 @@ KBUILD_CFLAGS                   += $(call 
>>>> cc-option,-mthin-add-sub) $(call cc-option,-Wa$(comma)
>>>>
>>>>   ifdef CONFIG_OBJTOOL
>>>>   ifdef CONFIG_CC_HAS_ANNOTATE_TABLEJUMP
>>>> +KBUILD_CFLAGS                        += -mannotate-tablejump
>>>> +else
>>>> +KBUILD_CFLAGS                        += -fno-jump-tables # keep 
>>>> compatibility with older compilers
>>>> +endif
>>>> +ifdef CONFIG_LTO_CLANG
>>>>   # The annotate-tablejump option can not be passed to LLVM backend 
>>>> when LTO is enabled.
>>>>   # Ensure it is aware of linker with LTO, 
>>>> '--loongarch-annotate-tablejump' also needs to
>>>>   # be passed via '-mllvm' to ld.lld.
>>>> -KBUILD_CFLAGS                        += -mannotate-tablejump
>>>> -ifdef CONFIG_LTO_CLANG
>>>>   KBUILD_LDFLAGS                       += -mllvm 
>>>> --loongarch-annotate-tablejump
>>>>   endif
>>>> -else
>>>> -KBUILD_CFLAGS                        += -fno-jump-tables # keep 
>>>> compatibility with older compilers
>>>> -endif
>>>>   endif
>>>>
>>>>   KBUILD_RUSTFLAGS             += 
>>>> --target=loongarch64-unknown-none-softfloat -Ccode-model=small
>>>> -- 
>>>> 2.42.0
>>>>
>>>
>>> This change is now in -next as commit b15212824a01 ("LoongArch: Make LTO
>>> case independent in Makefile"), where it breaks the build for clang-18,
>>> as '--loongarch-annotate-tablejump' is unimplemented there but there is
>>> no version check before using it.
>>>
>>>    $ make -skj"$(nproc)" ARCH=loongarch LLVM=1 mrproper defconfig
>>>
>>>    $ scripts/config -d LTO_NONE -e LTO_CLANG_THIN
>>>
>>>    $ make -skj"$(nproc)" ARCH=loongarch LLVM=1 olddefconfig vmlinuz.efi
>>>    ld.lld: error: -mllvm: ld.lld: Unknown command line argument 
>>> '--loongarch-annotate-tablejump'.
>>>    ...
>>>
>>>    $ scripts/config -s CC_HAS_ANNOTATE_TABLEJUMP
>>>    undef
>> Hmm, maybe we need this?
>> diff --git a/arch/loongarch/Makefile b/arch/loongarch/Makefile
>> index ae419e32f22e..fcfa793f9bb0 100644
>> --- a/arch/loongarch/Makefile
>> +++ b/arch/loongarch/Makefile
>> @@ -115,7 +115,7 @@ ifdef CONFIG_LTO_CLANG
>>   # The annotate-tablejump option can not be passed to LLVM backend
>> when LTO is enabled.
>>   # Ensure it is aware of linker with LTO,
>> '--loongarch-annotate-tablejump' also needs to
>>   # be passed via '-mllvm' to ld.lld.
>> -KBUILD_LDFLAGS                 += -mllvm
>> --loongarch-annotate-tablejump
>> +KBUILD_LDFLAGS                 += $(call ld-option,-mllvm
>> --loongarch-annotate-tablejump)
>>   endif
>>   endif
> 
> We need to handle the other case to use -fno-jump-tables if llvm does
> not support -loongarch-annotate-tablejump.
> 
> So, it is better to update the minimal version of llvm to 20, which
> includes the following two important commits:
> 
> [LoongArch] Add options for annotate tablejump
> https://github.com/llvm/llvm-project/commit/4c2c17756739
> 
> [LoongArch] Avoid indirect branch jumps using the ra register
> https://github.com/llvm/llvm-project/commit/21ef17c62645
> 
> If you are OK, I will send a patch to modify the following file:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/scripts/min-tool-version.sh#n29 
> 
> 
> and keep arch/loongarch/Makefile as is.

The other way is to keep scripts/min-tool-version.sh as is, and only
modify arch/loongarch/Makefile, something like this (not tested):

config LLD_HAS_ANNOTATE_TABLEJUMP
	def_bool LLD_VERSION >= 200000

ifdef CONFIG_LTO_CLANG
ifdef CONFIG_LLD_HAS_ANNOTATE_TABLEJUMP
KBUILD_LDFLAGS			+= -mllvm --loongarch-annotate-tablejump
else
KBUILD_LDFLAGS			+= -mllvm --no-jump-tables
endif

Update the minimal llvm version or change Makefile to compat various
llvm versions, which one do you prefer? Pease let me know.

Thanks,
Tiezhu


