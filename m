Return-Path: <linux-kernel+bounces-763795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EB61B21A64
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 03:50:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7030E7A8E6A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 01:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39C6F2D8363;
	Tue, 12 Aug 2025 01:50:25 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FF862D3751
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 01:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754963424; cv=none; b=DywpCyiDxgm0I/kGWcjGq86Iz60QWZD2bef+7gmSC5aORkWNZaPJ7gFHPSmEWCg+H+r0d46LN3pWN5t0U66WhG9NtaUusTRQW4dRUpuM5zv03o2jp+PIswVvCesbn9l90E3+7Iua6545olwjZ51wM0fj8GAnTLaM9Z/F7QOX7ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754963424; c=relaxed/simple;
	bh=oW6UYWXXJQaXAymB2yds6ngAX7JBvTAjsPnr9QZmFVI=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=SChLOdCAO6uEDp+ve/NjVGq9upO0gbSolbhKnZWEqIPrzACpamnsNM0Tffkch96mrTbEnTD8xgv5xQ4CP37ZCVIhETMTTlCnFP3JDOL/KFJopUdXljtLaZSBFKfk2TnRkDtQuyqYP9vQe7JP9wBawHjiNsEZvppwHlT0YxeGdH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.62])
	by gateway (Coremail) with SMTP id _____8BxLHLZnZpopcI+AQ--.19059S3;
	Tue, 12 Aug 2025 09:50:17 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
	by front1 (Coremail) with SMTP id qMiowJCxM+TWnZpo45ZFAA--.65022S3;
	Tue, 12 Aug 2025 09:50:17 +0800 (CST)
Subject: Re: [PATCH] LoongArch: KVM: Use kvm_get_vcpu_by_id() instead of
 kvm_get_vcpu()
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Song Gao <gaosong@loongson.cn>, zhaotianrui@loongson.cn,
 lixianglai@loongson.cn, loongarch@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20250811025544.458422-1-gaosong@loongson.cn>
 <c5f2a6d5-d793-94f0-8d8c-5cc5b7d142b8@loongson.cn>
 <CAAhV-H5BAN68S5uYkSKwnU2yatoz-w5aGFak-ivMWwJkeZLjWg@mail.gmail.com>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <be6b436c-66d0-f966-10cf-205cb4aedfef@loongson.cn>
Date: Tue, 12 Aug 2025 09:48:24 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAAhV-H5BAN68S5uYkSKwnU2yatoz-w5aGFak-ivMWwJkeZLjWg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJCxM+TWnZpo45ZFAA--.65022S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxCr1xJry3XFWUZrW7WrWxuFX_yoW5GF48pF
	W3CF1qvFs5Kry7G34jqFn8ZF1jyr95tr1IgFn3tFyYkrnIqF18AFy8Zr909Fy0k34xGF40
	qr1fKa1a9a1UJacCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUvYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v2
	6F4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
	02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAF
	wI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4
	CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
	67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMI
	IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
	14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
	W8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07j8yCJU
	UUUU=



On 2025/8/11 下午9:23, Huacai Chen wrote:
> On Mon, Aug 11, 2025 at 6:53 PM Bibo Mao <maobibo@loongson.cn> wrote:
>>
>>
>>
>> On 2025/8/11 上午10:55, Song Gao wrote:
>>> Use kvm_get_vcpu() may can't get vcpu context, use kvm_get_vcpu_by_id()
>>> instead of kvm_get_vcpu().
>>>
>>> Signed-off-by: Song Gao <gaosong@loongson.cn>
>>> ---
>>>    arch/loongarch/kvm/intc/eiointc.c | 5 ++++-
>>>    arch/loongarch/kvm/intc/ipi.c     | 2 +-
>>>    2 files changed, 5 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/arch/loongarch/kvm/intc/eiointc.c b/arch/loongarch/kvm/intc/eiointc.c
>>> index a3a12af9ecbf..5180da91d2e6 100644
>>> --- a/arch/loongarch/kvm/intc/eiointc.c
>>> +++ b/arch/loongarch/kvm/intc/eiointc.c
>>> @@ -45,7 +45,10 @@ static void eiointc_update_irq(struct loongarch_eiointc *s, int irq, int level)
>>>        }
>>>
>>>        cpu = s->sw_coremap[irq];
>>> -     vcpu = kvm_get_vcpu(s->kvm, cpu);
>>> +     vcpu = kvm_get_vcpu_by_id(s->kvm, cpu);
>>> +     if (unlikely(vcpu == NULL)) {
>>> +             return;
>>> +     }
>> Brace {} is unnecessary with kernel coding style :), just something like
>> this:
>>          if (unlikely(vcpu == NULL))
>>                  return;
>>
>> The other looks good to me.
> Maybe add a print statement the same as kvm_ipi_regs_access()?
Both are ok for me now.

In future there may be change with return value and printk message with 
in-kernel MMIO/IOCSR read/write emulation.

About return value there should be -EOPNOTSUPP if addr is not in range 
of device, it will transfer the emulation to user space VMM. Other value 
such as -EINVAL should be supported, and should not transfer to VMM 
since the address is in range of device.

About printk message I have no idea now, it may cause lots of noise 
message in host because of bad guest kernel, however abnormal behavior 
should be recorded anyway.

Regards
Bibo Mao
> 
> Huacai
> 
>>
>> Regards
>> Bibo Mao
>>>        if (level) {
>>>                /* if not enable return false */
>>>                if (!test_bit(irq, (unsigned long *)s->enable.reg_u32))
>>> diff --git a/arch/loongarch/kvm/intc/ipi.c b/arch/loongarch/kvm/intc/ipi.c
>>> index e658d5b37c04..0348a83a7ed7 100644
>>> --- a/arch/loongarch/kvm/intc/ipi.c
>>> +++ b/arch/loongarch/kvm/intc/ipi.c
>>> @@ -298,7 +298,7 @@ static int kvm_ipi_regs_access(struct kvm_device *dev,
>>>        cpu = (attr->attr >> 16) & 0x3ff;
>>>        addr = attr->attr & 0xff;
>>>
>>> -     vcpu = kvm_get_vcpu(dev->kvm, cpu);
>>> +     vcpu = kvm_get_vcpu_by_id(dev->kvm, cpu);
>>>        if (unlikely(vcpu == NULL)) {
>>>                kvm_err("%s: invalid target cpu: %d\n", __func__, cpu);
>>>                return -EINVAL;
>>>
>>


