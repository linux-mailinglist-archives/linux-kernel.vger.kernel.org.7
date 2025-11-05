Return-Path: <linux-kernel+bounces-885639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18483C33926
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 01:59:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5A7C3B23E1
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 00:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E43A1240604;
	Wed,  5 Nov 2025 00:57:57 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EFF82475E3
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 00:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762304277; cv=none; b=PHze2zqXx6F0/lTxHPcydgY9tvcyckLeTMvs5rna91I+wvWqv4RZF7Y4NygOCmpb+uR8ajWHrYvwyXHtgnUbyAhm4elYRnYORl+qQz8YqP5GgAK0cksJkovRxwQJcFqztSanTkUgDAG/xvmL3aeWHimCGIZXJB7FoL6nDPglbJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762304277; c=relaxed/simple;
	bh=RJ2qShkAkgf9KUuinRwcp1XT9Op7jqa88P8wTWEQIkg=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=nIUpxleFVNlS+rIXmm2VYyEDqjU+Lx8GmgHi6XbigW3Zw8FdiqQLgLDMEAkuufSmLXj9eoyPvRnECU/yg/4GL3nznx/r5fJZaF1wxEJQYoQrMCFKqbAbvXMsTwhMmn/MDJVZZ3uwZQ9txwtXVKwjw/7b3DbL8K9rG0vghIhIwzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.24])
	by gateway (Coremail) with SMTP id _____8Cxrr8PoQppmPEeAA--.329S3;
	Wed, 05 Nov 2025 08:57:51 +0800 (CST)
Received: from [10.20.42.24] (unknown [10.20.42.24])
	by front1 (Coremail) with SMTP id qMiowJDxrcEMoQppDl0nAQ--.28498S3;
	Wed, 05 Nov 2025 08:57:50 +0800 (CST)
Subject: Re: [PATCH] Loongarch:Make pte/pmd_modify can set _PAGE_MODIFIED
To: Huacai Chen <chenhuacai@kernel.org>
Cc: kernel@xen0n.name, akpm@linux-foundation.org, willy@infradead.org,
 david@redhat.com, linmag7@gmail.com, thuth@redhat.com, maobibo@loongson.cn,
 apopple@nvidia.com, loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
 Liupu Wang <wangliupu@loongson.cn>
References: <20251104073006.1764241-1-zhangtianyang@loongson.cn>
 <CAAhV-H5JnmJqTZ1GnhcgODtjL5FLy8x5HNRJxs6us=gzcFon5Q@mail.gmail.com>
From: Tianyang Zhang <zhangtianyang@loongson.cn>
Message-ID: <95e6f0a6-fd6c-a85f-5983-5a37eaf960a2@loongson.cn>
Date: Wed, 5 Nov 2025 08:56:56 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAAhV-H5JnmJqTZ1GnhcgODtjL5FLy8x5HNRJxs6us=gzcFon5Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:qMiowJDxrcEMoQppDl0nAQ--.28498S3
X-CM-SenderInfo: x2kd0wxwld05hdqjqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWxuFy5WF13Ww47WF18Zw48KrX_yoWruw43pF
	s7AF109a15tF1xZayfXF17uF9xAwsrGas7Jwn0k3WkGa4jq3y8XF4xCrZ8ZFyrXFW8uw10
	v3yvgr45WF47JwbCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUB0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v2
	6F4UJVW0owAaw2AFwI0_Jrv_JF1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0c
	Ia020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_
	Jw1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrw
	CYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j
	6r4UMxCIbckI1I0E14v26r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwV
	AFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv2
	0xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4
	v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AK
	xVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUc0eHDUUUU

Hi, Huacai

在 2025/11/4 下午4:00, Huacai Chen 写道:
> Hi, Tianyang,
>
> The subject line can be:
> LoongArch: Let {pte,pmd}_modify() record the status of _PAGE_DIRTY (If
> I'm right in the later comments).
Ok. I got it
>
> On Tue, Nov 4, 2025 at 3:30 PM Tianyang Zhang <zhangtianyang@loongson.cn> wrote:
>> In the current pte_modify operation, _PAGE_DIRTY might be cleared. Since
>> the hardware-page-walk does not have a predefined _PAGE_MODIFIED flag,
>> this could lead to loss of valid data in certain scenarios.
>>
>> The new modification involves checking whether the original PTE has the
>> _PAGE_DIRTY flag. If it exists, the _PAGE_MODIFIED bit is set, ensuring
>> that the pte_dirty interface can return accurate information.
> The description may be wrong here. Because pte_dirty() returns
> pte_val(pte) & (_PAGE_DIRTY | _PAGE_MODIFIED).
> If _PAGE_DIRTY isn't lost, pte_dirty() is always right, no matter
> whether there is or isn't _PAGE_MODIFIED.
>
> I think the real reason is we need to set _PAGE_MODIFIED in
> pte/pmd_modify to record the status of _PAGE_DIRTY, so that we can
> recover _PAGE_DIRTY afterwards, such as in pte/pmd_mkwrite().
Ok, I will adjust the description
>
>> Co-developed-by: Liupu Wang <wangliupu@loongson.cn>
>> Signed-off-by: Liupu Wang <wangliupu@loongson.cn>
>> Signed-off-by: Tianyang Zhang <zhangtianyang@loongson.cn>
>> ---
>>   arch/loongarch/include/asm/pgtable.h | 17 +++++++++++++----
>>   1 file changed, 13 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/loongarch/include/asm/pgtable.h b/arch/loongarch/include/asm/pgtable.h
>> index bd128696e96d..106abfa5183b 100644
>> --- a/arch/loongarch/include/asm/pgtable.h
>> +++ b/arch/loongarch/include/asm/pgtable.h
>> @@ -424,8 +424,13 @@ static inline unsigned long pte_accessible(struct mm_struct *mm, pte_t a)
>>
>>   static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
>>   {
>> -       return __pte((pte_val(pte) & _PAGE_CHG_MASK) |
>> -                    (pgprot_val(newprot) & ~_PAGE_CHG_MASK));
>> +       unsigned long val = (pte_val(pte) & _PAGE_CHG_MASK) |
>> +                    (pgprot_val(newprot) & ~_PAGE_CHG_MASK);
>> +
>> +       if (pte_val(pte) & _PAGE_DIRTY)
>> +               val |= _PAGE_MODIFIED;
>> +
>> +       return __pte(val);
>>   }
>>
>>   extern void __update_tlb(struct vm_area_struct *vma,
>> @@ -547,9 +552,13 @@ static inline struct page *pmd_page(pmd_t pmd)
>>
>>   static inline pmd_t pmd_modify(pmd_t pmd, pgprot_t newprot)
>>   {
>> -       pmd_val(pmd) = (pmd_val(pmd) & _HPAGE_CHG_MASK) |
>> +       unsigned long val = (pmd_val(pmd) & _HPAGE_CHG_MASK) |
>>                                  (pgprot_val(newprot) & ~_HPAGE_CHG_MASK);
>> -       return pmd;
>> +
>> +       if (pmd_val(pmd) & _PAGE_DIRTY)
>> +               val |= _PAGE_MODIFIED;
>> +
>> +       return __pmd(val);
>>   }
> A minimal modification can be:
> diff --git a/arch/loongarch/include/asm/pgtable.h
> b/arch/loongarch/include/asm/pgtable.h
> index 1f20e9280062..907ece0199e0 100644
> --- a/arch/loongarch/include/asm/pgtable.h
> +++ b/arch/loongarch/include/asm/pgtable.h
> @@ -448,8 +448,13 @@ static inline unsigned long pte_accessible(struct
> mm_struct *mm, pte_t a)
>
>   static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
>   {
> -       return __pte((pte_val(pte) & _PAGE_CHG_MASK) |
> -                    (pgprot_val(newprot) & ~_PAGE_CHG_MASK));
> +       pte_val(pte) = (pte_val(pte) & _PAGE_CHG_MASK) |
> +                       (pgprot_val(newprot) & ~_PAGE_CHG_MASK);
> +
> +       if (pte_val(pte) & _PAGE_DIRTY)
> +               pte_val(pte) |= _PAGE_MODIFIED;
> +
> +       return pte;
>   }

+       pte_val(pte) = (pte_val(pte) & _PAGE_CHG_MASK) |
+                       (pgprot_val(newprot) & ~_PAGE_CHG_MASK);

After this step, _PAGE_DIRTY may have already disappeared,
If no new variables are added, they can be modified in follow way:

  static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
  {
+       if (pte_val(pte) & _PAGE_DIRTY)
+               pte_val(pte) |= _PAGE_MODIFIED;
+
        return __pte((pte_val(pte) & _PAGE_CHG_MASK) |
	 (pgprot_val(newprot) & ~_PAGE_CHG_MASK));

  }

>
>   extern void __update_tlb(struct vm_area_struct *vma,
> @@ -583,7 +588,11 @@ static inline struct page *pmd_page(pmd_t pmd)
>   static inline pmd_t pmd_modify(pmd_t pmd, pgprot_t newprot)
>   {
>          pmd_val(pmd) = (pmd_val(pmd) & _HPAGE_CHG_MASK) |
> -                               (pgprot_val(newprot) & ~_HPAGE_CHG_MASK);
> +                       (pgprot_val(newprot) & ~_HPAGE_CHG_MASK);
> +
> +       if (pmd_val(pmd) & _PAGE_DIRTY)
> +               pmd_val(pmd) |= _PAGE_MODIFIED;
> +
>          return pmd;
>   }
>
> You needn't define a new variable.
>
>
> Huacai
>
>>   static inline pmd_t pmd_mkinvalid(pmd_t pmd)
>> --
>> 2.41.0
>>
>>
Thanks

Tianyang


