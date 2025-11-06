Return-Path: <linux-kernel+bounces-888061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 960DDC39BD6
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 10:06:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D10AC3B1942
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 09:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F23FB30AAC7;
	Thu,  6 Nov 2025 09:05:25 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD5D4309F08
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 09:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762419923; cv=none; b=rsO7Y2a+ZO+d5UYFpvpV5QmKaDzfWNqxgUAzNE06i4Ywv3dfyL0dV7G7ly2v35YrebRqJ+U/bjLecL0FHKSY50+HeC9taaltCssy5uh2Q27FJjfqPfUlHjsS5+UiZ06YpFZMD/okvR90EpRGMAjgbBkCR2L4Ub2ubztbFzX2wYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762419923; c=relaxed/simple;
	bh=fOrGbqpVhsXQS19PTcdOeLM3ZbT5vwpqP5L8P523PPQ=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=oFOlwkIPN0AvoD/OXrSmPNgUjMhRfEbNtWxWlJht86/A3HfLTiJwPadOeCnrA52EN8vk5KrK29oJQux8o+FP/9wOyPtx/un2kBy4oNqxSUtaoR7ZTSibEa9gehSIY2oGMVJDgwJeR0JDvO+taUwVBdHFFbcURw7h3IGRGIU9DVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.62])
	by gateway (Coremail) with SMTP id _____8Bx1tDOZAxpXKEfAA--.3130S3;
	Thu, 06 Nov 2025 17:05:18 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
	by front1 (Coremail) with SMTP id qMiowJBxC8HKZAxplHcpAQ--.20539S3;
	Thu, 06 Nov 2025 17:05:16 +0800 (CST)
Subject: Re: [PATCH] Loongarch:Make pte/pmd_modify can set _PAGE_MODIFIED
To: Tianyang Zhang <zhangtianyang@loongson.cn>,
 Huacai Chen <chenhuacai@kernel.org>
Cc: kernel@xen0n.name, akpm@linux-foundation.org, willy@infradead.org,
 david@redhat.com, linmag7@gmail.com, thuth@redhat.com, apopple@nvidia.com,
 loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
 Liupu Wang <wangliupu@loongson.cn>
References: <20251104073006.1764241-1-zhangtianyang@loongson.cn>
 <CAAhV-H5JnmJqTZ1GnhcgODtjL5FLy8x5HNRJxs6us=gzcFon5Q@mail.gmail.com>
 <95e6f0a6-fd6c-a85f-5983-5a37eaf960a2@loongson.cn>
 <CAAhV-H4WrphWQqW7HoeD7xSvRuHV1KBt7jgESQU7N-y1HrSVVw@mail.gmail.com>
 <b839a6a6-3791-ba73-baff-e860aa879bbc@loongson.cn>
 <833f6790-f1bf-d089-84cf-9f55e1c9866f@loongson.cn>
 <e035d888-a7a6-0f46-fdc1-92331cc12a93@loongson.cn>
 <0d774995-c35c-60d2-32b8-91b32663b0c9@loongson.cn>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <7fa3a535-9b72-4538-a161-7e2940e61f3e@loongson.cn>
Date: Thu, 6 Nov 2025 17:02:52 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <0d774995-c35c-60d2-32b8-91b32663b0c9@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJBxC8HKZAxplHcpAQ--.20539S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWfJFy5ZrW7JF15XFWDtFy3KFX_yoWDKF47pr
	1kJFyUAFW5Jr1xJFy0qF17Xryjyr47J3WUXr1DJF1UJr1Dtryjqr1UXrn09r1rJr48Jr1U
	Jr1UJr43ZF4UJwbCm3ZEXasCq-sJn29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUPYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	GcCE3s1ln4kS14v26r126r1DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2
	x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r1D
	McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7
	I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCF
	x2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AKxVWUtVW8ZwC20s026c02F40E14v26r
	1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij
	64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr
	0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF
	0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jFApnUUUUU=



On 2025/11/6 下午4:50, Tianyang Zhang wrote:
> 
> 在 2025/11/6 上午10:10, Bibo Mao 写道:
>>
>>
>> On 2025/11/6 上午9:55, Tianyang Zhang wrote:
>>> Hi ,Bibao
>>>
>>> 在 2025/11/5 上午9:18, Bibo Mao 写道:
>>>>
>>>>
>>>> On 2025/11/5 上午9:07, Huacai Chen wrote:
>>>>> On Wed, Nov 5, 2025 at 8:57 AM Tianyang Zhang 
>>>>> <zhangtianyang@loongson.cn> wrote:
>>>>>>
>>>>>> Hi, Huacai
>>>>>>
>>>>>> 在 2025/11/4 下午4:00, Huacai Chen 写道:
>>>>>>> Hi, Tianyang,
>>>>>>>
>>>>>>> The subject line can be:
>>>>>>> LoongArch: Let {pte,pmd}_modify() record the status of 
>>>>>>> _PAGE_DIRTY (If
>>>>>>> I'm right in the later comments).
>>>>>> Ok. I got it
>>>>>>>
>>>>>>> On Tue, Nov 4, 2025 at 3:30 PM Tianyang Zhang 
>>>>>>> <zhangtianyang@loongson.cn> wrote:
>>>>>>>> In the current pte_modify operation, _PAGE_DIRTY might be 
>>>>>>>> cleared. Since
>>>>>>>> the hardware-page-walk does not have a predefined _PAGE_MODIFIED 
>>>>>>>> flag,
>>>>>>>> this could lead to loss of valid data in certain scenarios.
>>>>>>>>
>>>>>>>> The new modification involves checking whether the original PTE 
>>>>>>>> has the
>>>>>>>> _PAGE_DIRTY flag. If it exists, the _PAGE_MODIFIED bit is set, 
>>>>>>>> ensuring
>>>>>>>> that the pte_dirty interface can return accurate information.
>>>>>>> The description may be wrong here. Because pte_dirty() returns
>>>>>>> pte_val(pte) & (_PAGE_DIRTY | _PAGE_MODIFIED).
>>>>>>> If _PAGE_DIRTY isn't lost, pte_dirty() is always right, no matter
>>>>>>> whether there is or isn't _PAGE_MODIFIED.
>>>>>>>
>>>>>>> I think the real reason is we need to set _PAGE_MODIFIED in
>>>>>>> pte/pmd_modify to record the status of _PAGE_DIRTY, so that we can
>>>>>>> recover _PAGE_DIRTY afterwards, such as in pte/pmd_mkwrite().
>>>>>> Ok, I will adjust the description
>>>>> After some thinking, your original description may be right. Without
>>>>> this patch the scenario maybe like this:
>>>>> The pte is dirty _PAGE_DIRTY but without _PAGE_MODIFIED, after
>>>>> pte_modify() we lose _PAGE_DIRTY, then pte_dirty() returns false. So
>>>>> we need _PAGE_MODIFIED to record _PAGE_DIRTY here.
>>>> In theory pte_modify() is to modify RWX attribute. I think that it 
>>>> is a tricky to remove _PAGE_DIRTY and add _PAGE_MODIFIED with HW PTW 
>>>> system.
>>>>
>>>> Also _PAGE_ACCESSED is lost with pte_modify() API, is there any 
>>>> influence with HW PTW system, or wait until possible problems coming 
>>>> out.
>>>
>>> static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
>>> {
>>>          return __pte((pte_val(pte) & _PAGE_CHG_MASK) |
>>>                       (pgprot_val(newprot) & ~_PAGE_CHG_MASK));
>>> }
>>> In my understand, During the  pte_modify process, it is essential to 
>>> ensure that specific bits are inherited from the original PTE rather 
>>> than simply replaced(as set_pte),
>>>
>>> this guarantees the coherent operation of the memory management system.
>>>
>>> Since _PAGE_CHG_MASK explicitly requires preserving pte_modified, and 
>> The problem is how _PAGE_CHG_MASK should be defined, do you check with 
>> other architectures?
> 
> Under mainstream architectures(like ARM64/X86 ), if the pte_modify 
> interface clears the hard-dirty flag, it will set the soft-dirty flag 
> through some mechanism.
> 
> Thus, at least from the perspective of PAGE_DIRTY logic, this approach 
> is right.
> 
>>> there is an inherent correlation between pte_dirty and pte_modified, 
>>> these attributes must be evaluated and handled accordingly.
>>>
>>> The pte_valid attribute, being a hardware property, is inherently the 
>>> target of modification in the pte_modify interface. Therefore, it is 
>>> reasonable not to preserve it.
>> On HW PTW system, _PAGE_PRESENT will control whether trigger page 
>> fault rather than pte_valid/_PAGE_ACCESSED. For simple, do you think 
>> the following code is ok or not ?
> 
> "On HW PTW system, _PAGE_PRESENT will control whether trigger page fault 
> rather than pte_valid/_PAGE_ACCESSED"
> 
> Yes, indeed, in many cases, PAGE_PRESENT is precisely the cleanup target 
> of pte_modify.
Ok, I have no any question more :) Just do it.

Regards
Bibo Mao
> 
>>
>>  static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
>>  {
>> -       return __pte((pte_val(pte) & _PAGE_CHG_MASK) |
>> -                    (pgprot_val(newprot) & ~_PAGE_CHG_MASK));
>> +       unsigned long mask = _PAGE_CHG_MASK;
>> +
>> +       if (cpu_has_ptw)
>> +               mask |= _PAGE_DIRTY | _PAGE_ACCESSED;
>> +       return __pte((pte_val(pte) & mask) |
>> +                    (pgprot_val(newprot) & ~mask));
>>  }
>>
> This modification is inappropriate.
> 
> Firstly, _PAGE_ACCESSED(bit 0, as _PAGE_PRESENT) and _PAGE_DIRTY bits 
> are inherently the targets of pte_modify operations. Some 
> sub-memory-system like numa_balance precisely rely on
> 
> clearing these bits to trigger hardware exceptions and complete 
> subsequent processes, this appears to be unrelated to hardware-ptw
> 
> And, under hardware-ptw scenarios, the WRITE=0 && DIRTY=1 condition 
> should never occur, therefore, we cannot preserve the DIRTY bit in advance.
> 
> Thanks
> 
> Tianyang
> 
>> Regards
>> Bibo Mao
>>
>>>
>>> Thanks
>>>
>>> Tianyang
>>>
>>>>
>>>> Regards
>>>> Bibo Mao
>>>>>
>>>>> But the description also needs to be updated.
>>>>>
>>>>>>>
>>>>>>>> Co-developed-by: Liupu Wang <wangliupu@loongson.cn>
>>>>>>>> Signed-off-by: Liupu Wang <wangliupu@loongson.cn>
>>>>>>>> Signed-off-by: Tianyang Zhang <zhangtianyang@loongson.cn>
>>>>>>>> ---
>>>>>>>>    arch/loongarch/include/asm/pgtable.h | 17 +++++++++++++----
>>>>>>>>    1 file changed, 13 insertions(+), 4 deletions(-)
>>>>>>>>
>>>>>>>> diff --git a/arch/loongarch/include/asm/pgtable.h 
>>>>>>>> b/arch/loongarch/include/asm/pgtable.h
>>>>>>>> index bd128696e96d..106abfa5183b 100644
>>>>>>>> --- a/arch/loongarch/include/asm/pgtable.h
>>>>>>>> +++ b/arch/loongarch/include/asm/pgtable.h
>>>>>>>> @@ -424,8 +424,13 @@ static inline unsigned long 
>>>>>>>> pte_accessible(struct mm_struct *mm, pte_t a)
>>>>>>>>
>>>>>>>>    static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
>>>>>>>>    {
>>>>>>>> -       return __pte((pte_val(pte) & _PAGE_CHG_MASK) |
>>>>>>>> -                    (pgprot_val(newprot) & ~_PAGE_CHG_MASK));
>>>>>>>> +       unsigned long val = (pte_val(pte) & _PAGE_CHG_MASK) |
>>>>>>>> +                    (pgprot_val(newprot) & ~_PAGE_CHG_MASK);
>>>>>>>> +
>>>>>>>> +       if (pte_val(pte) & _PAGE_DIRTY)
>>>>>>>> +               val |= _PAGE_MODIFIED;
>>>>>>>> +
>>>>>>>> +       return __pte(val);
>>>>>>>>    }
>>>>>>>>
>>>>>>>>    extern void __update_tlb(struct vm_area_struct *vma,
>>>>>>>> @@ -547,9 +552,13 @@ static inline struct page *pmd_page(pmd_t pmd)
>>>>>>>>
>>>>>>>>    static inline pmd_t pmd_modify(pmd_t pmd, pgprot_t newprot)
>>>>>>>>    {
>>>>>>>> -       pmd_val(pmd) = (pmd_val(pmd) & _HPAGE_CHG_MASK) |
>>>>>>>> +       unsigned long val = (pmd_val(pmd) & _HPAGE_CHG_MASK) |
>>>>>>>>                                   (pgprot_val(newprot) & 
>>>>>>>> ~_HPAGE_CHG_MASK);
>>>>>>>> -       return pmd;
>>>>>>>> +
>>>>>>>> +       if (pmd_val(pmd) & _PAGE_DIRTY)
>>>>>>>> +               val |= _PAGE_MODIFIED;
>>>>>>>> +
>>>>>>>> +       return __pmd(val);
>>>>>>>>    }
>>>>>>> A minimal modification can be:
>>>>>>> diff --git a/arch/loongarch/include/asm/pgtable.h
>>>>>>> b/arch/loongarch/include/asm/pgtable.h
>>>>>>> index 1f20e9280062..907ece0199e0 100644
>>>>>>> --- a/arch/loongarch/include/asm/pgtable.h
>>>>>>> +++ b/arch/loongarch/include/asm/pgtable.h
>>>>>>> @@ -448,8 +448,13 @@ static inline unsigned long 
>>>>>>> pte_accessible(struct
>>>>>>> mm_struct *mm, pte_t a)
>>>>>>>
>>>>>>>    static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
>>>>>>>    {
>>>>>>> -       return __pte((pte_val(pte) & _PAGE_CHG_MASK) |
>>>>>>> -                    (pgprot_val(newprot) & ~_PAGE_CHG_MASK));
>>>>>>> +       pte_val(pte) = (pte_val(pte) & _PAGE_CHG_MASK) |
>>>>>>> +                       (pgprot_val(newprot) & ~_PAGE_CHG_MASK);
>>>>>>> +
>>>>>>> +       if (pte_val(pte) & _PAGE_DIRTY)
>>>>>>> +               pte_val(pte) |= _PAGE_MODIFIED;
>>>>>>> +
>>>>>>> +       return pte;
>>>>>>>    }
>>>>>>
>>>>>> +       pte_val(pte) = (pte_val(pte) & _PAGE_CHG_MASK) |
>>>>>> +                       (pgprot_val(newprot) & ~_PAGE_CHG_MASK);
>>>>>>
>>>>>> After this step, _PAGE_DIRTY may have already disappeared,
>>>>>> If no new variables are added, they can be modified in follow way:
>>>>>>
>>>>>>    static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
>>>>>>    {
>>>>>> +       if (pte_val(pte) & _PAGE_DIRTY)
>>>>>> +               pte_val(pte) |= _PAGE_MODIFIED;
>>>>>> +
>>>>>>          return __pte((pte_val(pte) & _PAGE_CHG_MASK) |
>>>>>>           (pgprot_val(newprot) & ~_PAGE_CHG_MASK));
>>>>>>
>>>>>>    }
>>>>> OK, it makes sense.
>>>>>
>>>>> Huacai
>>>>>>
>>>>>>>
>>>>>>>    extern void __update_tlb(struct vm_area_struct *vma,
>>>>>>> @@ -583,7 +588,11 @@ static inline struct page *pmd_page(pmd_t pmd)
>>>>>>>    static inline pmd_t pmd_modify(pmd_t pmd, pgprot_t newprot)
>>>>>>>    {
>>>>>>>           pmd_val(pmd) = (pmd_val(pmd) & _HPAGE_CHG_MASK) |
>>>>>>> -                               (pgprot_val(newprot) & 
>>>>>>> ~_HPAGE_CHG_MASK);
>>>>>>> +                       (pgprot_val(newprot) & ~_HPAGE_CHG_MASK);
>>>>>>> +
>>>>>>> +       if (pmd_val(pmd) & _PAGE_DIRTY)
>>>>>>> +               pmd_val(pmd) |= _PAGE_MODIFIED;
>>>>>>> +
>>>>>>>           return pmd;
>>>>>>>    }
>>>>>>>
>>>>>>> You needn't define a new variable.
>>>>>>>
>>>>>>>
>>>>>>> Huacai
>>>>>>>
>>>>>>>>    static inline pmd_t pmd_mkinvalid(pmd_t pmd)
>>>>>>>> -- 
>>>>>>>> 2.41.0
>>>>>>>>
>>>>>>>>
>>>>>> Thanks
>>>>>>
>>>>>> Tianyang
>>>>>>
> 


