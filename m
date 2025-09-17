Return-Path: <linux-kernel+bounces-820382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EAE2B7CF21
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:14:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AE751B29B5F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 09:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22349283145;
	Wed, 17 Sep 2025 09:47:25 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5DFE341AD7
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 09:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758102444; cv=none; b=oGLyBeN+uNdXRL9IIK4oH/nT0dit/QdUsXHcqgJ8ROQyqehs+AwMEoX0EYdqpfL2qD8koYspsT52RUPUDWHUhtQoL+dwLeEsySpl8vOw7wYxLlM+MrDgwZeXSZl7xZITBj1hBD9QLySBXv3uXRtj90DPg0aTiq3QnlQKafdD1Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758102444; c=relaxed/simple;
	bh=UTIf4txpaImQ0cFB7zAgM6nm9pOQSd8jCc/j9BwiWaA=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=TbQebSHq7MVOZZgZyrM6Xwd5pIUZ1e9i8mqkbx/76CYk0DDwd93h30HytBqn51QA9Lk/zlB8JDnqMOwQlhVm4MeYEoA5TbkFGaHP2X0H2SA7O0BDnbgGFiH/yt4zWus1wrgm7D4o9qt2saRKvOPl77NiNieTBNiFS+pwZwYp59Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8Bx37+mg8poME8LAA--.22981S3;
	Wed, 17 Sep 2025 17:47:18 +0800 (CST)
Received: from [10.130.10.66] (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJBxpeSjg8po9DebAA--.36350S3;
	Wed, 17 Sep 2025 17:47:17 +0800 (CST)
Subject: Re: [PATCH v2 3/4] objtool/LoongArch: Fix unreachable instruction
 warnings about entry points
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, loongarch@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20250917011007.4540-1-yangtiezhu@loongson.cn>
 <20250917011007.4540-4-yangtiezhu@loongson.cn>
 <CAAhV-H6yKyqU+jQ=-RoOOc0fyRgjFfdorJAk1LashV0Gt=Y=AQ@mail.gmail.com>
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <bfd7035b-ca08-66d2-bdc5-d28743144128@loongson.cn>
Date: Wed, 17 Sep 2025 17:47:14 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAAhV-H6yKyqU+jQ=-RoOOc0fyRgjFfdorJAk1LashV0Gt=Y=AQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJBxpeSjg8po9DebAA--.36350S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7Kw47WF48CFy3tFWrWrW7trc_yoW5JF43pF
	WUC390y3yvyF1qva1DJ3yagrWrZFn3Wr4aqFnxGryrA39Fv3ZFqw40yr1UXFyDKw47W340
	qrWrtFZ0gayUA3gCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
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

On 2025/9/17 下午3:07, Huacai Chen wrote:
> Hi, Tiezhu,
> 
> On Wed, Sep 17, 2025 at 9:10 AM Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
>>
>> When compiling with LLVM and CONFIG_LTO_CLANG is set, there exist the
>> following objtool warnings:
>>
>>    vmlinux.o: warning: objtool: kernel_entry+0x0: unreachable instruction
>>    vmlinux.o: warning: objtool: smpboot_entry+0x0: unreachable instruction
>>
>> kernel_entry() and smpboot_entry() are in arch/loongarch/kernel/head.S,
>> there is "OBJECT_FILES_NON_STANDARD_head.o := y" to skip objtool checking
>> for head.o, but the STACK_FRAME_NON_STANDARD macro does not work for link
>> time validation of vmlinux.o according to objtool documentation, just give
>> a proper unwind hint to fix the warnings.
>>
>> By the way, ASM_BUG() can be removed due to unnecessary, otherwise there
>> are following warnings:
>>
>>    kernel_entry+0xf4: start_kernel() missing __noreturn
>>    in .c/.h or NORETURN() in noreturns.h
>>
>>    smpboot_entry+0x68: start_secondary() missing __noreturn
>>    in .c/.h or NORETURN() in noreturns.h
>>
>> This is because the previous instructions of kernel_entry+0xf4 and
>> smpboot_entry+0x68 are the 'bl' instructions, start_kernel() and
>> start_secondary() are the respective call destination symbols which
>> are noreturn functions, then the 'bl' instructions are already marked
>> as dead end in annotate_call_site().
>>
>> For now, it is time to remove "OBJECT_FILES_NON_STANDARD_head.o := y"
>> in arch/loongarch/kernel/Makefile.

...

>> -OBJECT_FILES_NON_STANDARD_head.o := y
> This line should be kept, othewise we get:
> 
> arch/loongarch/kernel/head.o: warning: objtool: kernel_entry+0xf4:
> start_kernel() missing __noreturn in .c/.h or NORETURN() in
> noreturns.h
> 
> even without LTO. This is a regression, we can only remove it after
> the above warning be fixed.

As said in the commit message, ASM_BUG() needs to be removed
to fix the above warning.

I tested again with GCC and LLVM (with and without LTO),
there is no the warning what you said, please double check.

(1) GCC
make ARCH=loongarch defconfig
make ARCH=loongarch -j8

(2) LLVM without LTO
make ARCH=loongarch LLVM=1 clean defconfig
make ARCH=loongarch LLVM=1 olddefconfig all -j8

(3) LLVM with LTO
make ARCH=loongarch LLVM=1 clean defconfig
scripts/config -d LTO_NONE -e LTO_CLANG_THIN
make ARCH=loongarch LLVM=1 olddefconfig all -j8

Thanks,
Tiezhu


