Return-Path: <linux-kernel+bounces-799794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A0F7B4305D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 05:18:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C7D3204BDA
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 03:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C16F274FCB;
	Thu,  4 Sep 2025 03:18:40 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCD96272E41
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 03:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756955920; cv=none; b=c16SJlDAvELlVHsy86YByvn07BXzrWbjXd/CVaLSSHQFCaYwQUgMEDV1QGIfMZub/4ESS4R9eOpEUKCu2lDNAogOhvqnZ62Vn01LZZiUOZUl2UVNpewA8kZOa3FPOZ0+BGR/iElj47w30On+eUuOFOwv1eeVcE7RpR0AaWl1n+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756955920; c=relaxed/simple;
	bh=/GuSdoUa7Mg6kegPOB9iDxfDzkb16eBIAU06JZax8vg=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=nJHdh7HpeLbrYs0Ii77J1+y1POWNRy4EIbedRyUhaGchJrc8s88UaEg4NuagEOUlflIyVbdhM3rcB3+IQBCxYpjrP4RGlTtr4Ydlya7Yv02rQVZjIrfN7FYu3ke2921+y4LaTnMbQvEIkLCVys4IveXdtm27hSALTayGF/9MM0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8DxvdIHBblob38GAA--.13605S3;
	Thu, 04 Sep 2025 11:18:31 +0800 (CST)
Received: from [10.130.10.66] (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJCxM+QEBbloyvV8AA--.579S3;
	Thu, 04 Sep 2025 11:18:30 +0800 (CST)
Subject: Re: [PATCH v1 3/3] LoongArch: Fix unreachable instruction warnings
 about entry functions
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Huacai Chen <chenhuacai@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Nathan Chancellor <nathan@kernel.org>,
 loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20250901072156.31361-1-yangtiezhu@loongson.cn>
 <20250901072156.31361-4-yangtiezhu@loongson.cn>
 <ots6w2ntyudj5ucs5eowncta2vmfssatpcqwzpar3ekk577hxi@j45dd4dmwx6x>
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <3da2092b-e6ca-a7a1-9459-c2754adf19aa@loongson.cn>
Date: Thu, 4 Sep 2025 11:18:28 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ots6w2ntyudj5ucs5eowncta2vmfssatpcqwzpar3ekk577hxi@j45dd4dmwx6x>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJCxM+QEBbloyvV8AA--.579S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWxGryUAr18Zw17Aw1UXry8Xrc_yoW5WF17pF
	y5Ar4kCrWkJr1qva45Aa4UuFWDXa4Du3Z7uF4kKryUCw40qr10qr1qvr47WF98Kw48GFWY
	qF1xXw1ftFy8J3gCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUvYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
	8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AK
	xVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzV
	AYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
	14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIx
	kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
	wI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F
	4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jYSoJU
	UUUU=

On 2025/9/4 上午3:22, Josh Poimboeuf wrote:
> On Mon, Sep 01, 2025 at 03:21:56PM +0800, Tiezhu Yang wrote:
>> +++ b/arch/loongarch/kernel/Makefile
>> @@ -3,8 +3,6 @@
>>   # Makefile for the Linux/LoongArch kernel.
>>   #
>>   
>> -OBJECT_FILES_NON_STANDARD_head.o := y
>> -
>>   always-$(KBUILD_BUILTIN)	:= vmlinux.lds
>>   
>>   obj-y		+= head.o cpu-probe.o cacheinfo.o env.o setup.o entry.o genex.o \
>> diff --git a/arch/loongarch/kernel/head.S b/arch/loongarch/kernel/head.S
>> index e3865e92a917..a11880f3a7e1 100644
>> --- a/arch/loongarch/kernel/head.S
>> +++ b/arch/loongarch/kernel/head.S
>> @@ -42,6 +42,7 @@ SYM_DATA(kernel_fsize, .long _kernel_fsize);
>>   	.align 12
>>   
>>   SYM_CODE_START(kernel_entry)			# kernel entry point
>> +	UNWIND_HINT_UNDEFINED
> 
> Should this not be UNWIND_HINT_END_OF_STACK?

Yes, makes sense, will do it in the next version.

> I notice Loongarch doesn't seem to use that anywhere.  How does any ORC
> unwind succeed?  UNWIND_HINT_UNDEFINED sets an error condition which
> should cause a livepatch transition to stall.

Actually, kernel_entry() or smpboot_entry() is recognized as the last
frame, because at this point is_entry_func() is true and 
state->stack_info.type = STACK_TYPE_UNKNOWN in unwind_next_frame() of
arch/loongarch/kernel/unwind_orc.c.

Call Trace:
[<90000000031a36b4>] show_stack+0x5c/0x180
[<900000000319d4b0>] dump_stack_lvl+0x6c/0x9c
[<900000000458d3e0>] nmi_cpu_backtrace+0x160/0x168
[<90000000031a3b6c>] handle_backtrace+0xc/0x40
[<90000000032b1078>] __flush_smp_call_function_queue+0xd0/0x330
[<90000000031aec40>] loongson_ipi_interrupt+0xb0/0x168
[<900000000325b4d4>] __handle_irq_event_percpu+0x54/0x1a8
[<900000000325b63c>] handle_irq_event_percpu+0x14/0x80
[<9000000003262a48>] handle_percpu_irq+0x50/0xa0
[<900000000325aad4>] generic_handle_domain_irq+0x2c/0x80
[<9000000003bc4d24>] handle_cpu_irq+0x64/0xa0
[<90000000045a350c>] handle_loongarch_irq+0x2c/0x48
[<90000000045a35e4>] do_vint+0xbc/0xe0
[<90000000031a1624>] handle_vint+0x144/0x1e4
[<900000000321e2e8>] _nohz_idle_balance.isra.0+0x230/0x3a0
[<90000000031cd004>] handle_softirqs+0x10c/0x298
[<90000000031cd2e8>] __irq_exit_rcu+0x100/0x160
[<90000000045a35a4>] do_vint+0x7c/0xe0
[<90000000045a55cc>] idle_exit+0x0/0x4
[<90000000045a55d8>] arch_cpu_idle+0x8/0x30
[<90000000045a5698>] default_idle_call+0x18/0x50
[<90000000032250b0>] do_idle+0xb8/0x130
[<9000000003225374>] cpu_startup_entry+0x2c/0x38
[<90000000045a6240>] kernel_entry_end+0xdc/0xe0
[<90000000045c0d44>] start_kernel+0x65c/0x660
[<90000000045a60f0>] kernel_entry+0xf0/0xf8

Thanks,
Tiezhu


