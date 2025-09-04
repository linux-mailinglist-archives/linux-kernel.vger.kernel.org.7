Return-Path: <linux-kernel+bounces-799821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BC31B430A8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 05:50:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3595317B479
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 03:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F06BE225A23;
	Thu,  4 Sep 2025 03:50:45 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A92C919F127
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 03:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756957845; cv=none; b=DcD5zxoktUuOXQlvMCm545oKQue78CqmGKaMg7VOc5GkjRajAjiQuXGhLWW79bgXHvJYxCs6iJGrrUY3LfzCgdJLTYWwhaKv0Qswehm6l076pxRumLGyNkI/da28tNDxZ7NZE5255zKh+nuDjfMixBcrjsiM/dKEe0eEtWRPGyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756957845; c=relaxed/simple;
	bh=dRIG/SZ+uchSsJrg0bDTlouOEqRxCMR5/5ovjUahhxM=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=TLtFo26ot7noYgF63xDtf1/p1FfwZ5CFmkQUbDO8uRwlIL96UZGZRUY6OJSnj2Wce8/JOtJJUnJFdLXMcAZx8xrtJ4IOwsxniA2uxWlwFyONXTaEFjZXr329V/uQKfP36OEG0qCuXF4e5Iuhh1s/sfXggKShgjNwXw93N0vwG88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8BxG9KQDLloG4EGAA--.13333S3;
	Thu, 04 Sep 2025 11:50:40 +0800 (CST)
Received: from [10.130.10.66] (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJCxM+SJDLlofwR9AA--.766S3;
	Thu, 04 Sep 2025 11:50:34 +0800 (CST)
Subject: Re: [PATCH v1 2/3] objtool/LoongArch: Fix unreachable instruction
 warnings about EFISTUB
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Nathan Chancellor
 <nathan@kernel.org>, loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20250901072156.31361-1-yangtiezhu@loongson.cn>
 <20250901072156.31361-3-yangtiezhu@loongson.cn>
 <20250901081904.GB4067720@noisy.programming.kicks-ass.net>
 <82c913b9-4403-cde9-0542-5bd6e04415f5@loongson.cn>
 <wt4qpgi5isj5m6wq33pomvm6borvafuzktekc7lgtoitscar5q@brixzj3lccbw>
 <ccbb40c1-5f2d-77e9-e8d2-52f2fdbad645@loongson.cn>
 <CAAhV-H5qhKepa-8sz3_AC=_RCChbVeEmnHKESMqpiJ0phMORbg@mail.gmail.com>
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <52056c29-4f21-83c9-db1f-ebd1875a3675@loongson.cn>
Date: Thu, 4 Sep 2025 11:50:32 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAAhV-H5qhKepa-8sz3_AC=_RCChbVeEmnHKESMqpiJ0phMORbg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJCxM+SJDLlofwR9AA--.766S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7Aw18Cr4kXF1rGw43tr4DKFX_yoW8KFWkpa
	yUCFWjkr4DJrW8J397tw48Wa4akrZxtrWSqa4YqryDA3WqqrnagrWDJry5CFZxWr4xtF1I
	va1xtF43WayjyagCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4
	xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v2
	6r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67
	vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
	wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc4
	0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AK
	xVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr
	1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8vApUUU
	UUU==

On 2025/9/4 上午10:21, Huacai Chen wrote:
> On Thu, Sep 4, 2025 at 10:18 AM Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
>>
>> On 2025/9/4 上午3:19, Josh Poimboeuf wrote:
>>> On Mon, Sep 01, 2025 at 04:39:29PM +0800, Tiezhu Yang wrote:
>>>> On 2025/9/1 下午4:19, Peter Zijlstra wrote:
>>>>> On Mon, Sep 01, 2025 at 03:21:55PM +0800, Tiezhu Yang wrote:
>>>>>> When compiling with LLVM and CONFIG_LTO_CLANG is set, there exist the
>>>>>> following objtool warnings:
>>
>> ...
>>
>>>> Josh suggested to do something to put these instructions in the data
>>>> section, but as said in the previous reply, it needs to modify the link
>>>> process and seems too complicated and expensive for this warning to some
>>>> extent.
>>>>
>>>> So I did this change for objtool.
>>>
>>> I don't like this workaround either, how exactly is it complicated and
>>> expensive to put the data in a data section?
>>
>> I can put them in a data section in the next version, this is
>> reasonable.
> No, from the ARM64 and RISC-V design, we can put jump instructions in
> the HEAD section, and this is what Jiaxun wants to do. Changing to a
> data section is not reasonable.

ARM64, RISC-V and LoongArch share the same logic in efistub:

$ grep -r "libstub/lib.a" arch/*/Makefile
arch/arm64/Makefile:libs-$(CONFIG_EFI_STUB) += 
$(objtree)/drivers/firmware/efi/libstub/lib.a
arch/loongarch/Makefile:libs-$(CONFIG_EFI_STUB) += 
$(objtree)/drivers/firmware/efi/libstub/lib.a
arch/riscv/Makefile:libs-$(CONFIG_EFI_STUB) += 
$(objtree)/drivers/firmware/efi/libstub/lib.a

If we can not put the these data to a data section, then we can not
link efistub separately, because if remove the following code in
arch/loongarch/Makefile:

libs-$(CONFIG_EFI_STUB) += $(objtree)/drivers/firmware/efi/libstub/lib.a

there exists the following build error:

    LD      vmlinux.o
   OBJCOPY modules.builtin.modinfo
   GEN     modules.builtin
   GEN     .vmlinux.objs
   MODPOST Module.symvers
   UPD     include/generated/utsversion.h
   CC      init/version-timestamp.o
   KSYMS   .tmp_vmlinux0.kallsyms.S
   AS      .tmp_vmlinux0.kallsyms.o
   LD      .tmp_vmlinux1
ld: arch/loongarch/kernel/head.o: in function `pe_header':
(.head.text+0x68): undefined reference to `__efistub_efi_pe_entry'

What should to do in the next step? I am looking forward to your
final conclusion.

Thanks,
Tiezhu


