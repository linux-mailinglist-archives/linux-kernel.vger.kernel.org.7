Return-Path: <linux-kernel+bounces-813455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64E77B545B1
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 10:41:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 157FDAA4F19
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 08:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55CB82D5950;
	Fri, 12 Sep 2025 08:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AlmVoUjq"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D781E1DE9
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 08:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757666479; cv=none; b=Oc2YSi9Ve3bQf8f1z/bScWWZpHRZnXbV0z0/ILTErKrxxoDPGb2lhDQzU7uMTmU7WdlxfyiHMvSDclltiS6qxJ+spa6iJ99E5gu4b+GR/CFtivX65VqaE4VMZraEx06hPEqwXZPZrBHLGoKTf6SYcFKcee6OryUZOc7e+DLiZ74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757666479; c=relaxed/simple;
	bh=GskethQiCYGbxpWebwWDCUkezuP2ZFyCy/v/f/43Uao=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XWlb7BTEGSnOjxswT+TalbnS8RwGyKolWb8n11bHTgohJwH/RhMyxDuipAoy1oQGoAPg3K35ZVcGHJs967U4+H36k/9gBXlWzui73j0IQA2dPRy7OZcbd795AgT5WHEk6lVkZ0cAJndXFBYi3Gl6l1E36PTqfcQLu2CThf2KCkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AlmVoUjq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757666475;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=4OzxzOM1+YKpzQLdMTSo1m5QIHmsRAkL5OBReEyJoKA=;
	b=AlmVoUjqFjTEVqTx4vAZ8Lq7h+f8BjJEWcumSuS1WF0DNuqlBTguwyNZ4WAB34IxKXeLTm
	DXm79VzhXmPaTVgK9UrUKgBOnRYFylN0EUNpgSP7YNO1A/iK7zuDaKRhWQEbutQTHcWHb0
	BWkpcweOAfqdixY6GQYmM7iY0GcpTuo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-269-KypRRoauPMSUwebTlEOItg-1; Fri, 12 Sep 2025 04:41:14 -0400
X-MC-Unique: KypRRoauPMSUwebTlEOItg-1
X-Mimecast-MFC-AGG-ID: KypRRoauPMSUwebTlEOItg_1757666473
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-45cb4f23156so10079475e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 01:41:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757666473; x=1758271273;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4OzxzOM1+YKpzQLdMTSo1m5QIHmsRAkL5OBReEyJoKA=;
        b=DhPm8tVnyny3JQAY7rdjgVxJeSogbSFD7bR7Gvtiee9v6X3VICte9uQW/NnL2zThsY
         nl/CzIiVfPO1RsrJDyF6QYpfAMm44R8n2GvS4bXP9EIcbhhOvpHhTBMPSzJtakKupBIJ
         lvbCMzJsVdDOSf1yHVva0hrpLxdydOblTnt56adwFzjE8f7jZ4DopSrvToOw/k3TuWxP
         4IA7tiQ1TD/14u/C/odn3Wgu3yEYXeRCanE6cDqFyWk4I8RpbA2BxKhzVEpzqrGjTBK+
         OfJBysLcKMtmxOgfqlYxZ8kcd9cV67Xoq6sbILqqC/WeJj9+MAR9VEewfr//UDa+SUyp
         8q/w==
X-Forwarded-Encrypted: i=1; AJvYcCWicLqfd+wzx1vJvQsu3Jdgawt/hvmYmY0WyplvEYH8I0BlX+eP3IpCymnRMPg+rDZAJrz1AS2fdd6CLzU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzR3vj2djASCgfjbxJdZWQwyYBFjBFGM0KK38Cy6faia0q86D4q
	fkCDc/V6RD/I0GmaJ/Ic2soFTErTq3p1aPek/A5ZpTU/y+Mv0in3hy4mtSgQbldp0AD2btTo79f
	VtGGxjn0LBsjV+2dPPRKuhUTu7WvHCQ6sFTe7onMYidj5daBCRltivsRYcOaSkdEWUg==
X-Gm-Gg: ASbGncvqaC1tUxUlxpjrLn7zRCNE19/T8jtNBhrsiAOwzGXnqdyxyFz289oTjXOvpiM
	j9TBTYmv8+oCw/3yVXAWJ/QkXDf9WlNvabsc6qYIFTQhZIw0p03ELt872106P898H00oWiMW8S5
	XqRMeAEaImrksnmAbaFvfSqCvv9tZB5KvHa1ioDm/+PORtk0Gc5aclfh7DMLAEUi3btImxieY4f
	46hPd9lZJqhjoRl+7cYgFsTzflL/qMImYCbGBqMB/O3CZiShb9MNIv+dcvPe19r2m1g35LPNlO2
	dQs+fcKz03Zd10MOUECoHNgb7Zjg3shCEV+EK++rdpNimimkVkfWkoAQNX/Lk2Yz4RWncYEiJ2d
	2dHq5H97sfPvYrlnQcniflKYaOVamdEsBTXr1c9mDNiCKTsmXxSz7C4X8eNGILy2/0r0=
X-Received: by 2002:a05:600c:290:b0:45b:9c93:d236 with SMTP id 5b1f17b1804b1-45f211fc26emr13650545e9.27.1757666472912;
        Fri, 12 Sep 2025 01:41:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH9nGjkCKKbvLuBZ8vdUOgkbUs8ycWo8YuG0foTEaRFm80gh0VfBYYzZsIurpnaFqL5oI4Ciw==
X-Received: by 2002:a05:600c:290:b0:45b:9c93:d236 with SMTP id 5b1f17b1804b1-45f211fc26emr13650275e9.27.1757666472437;
        Fri, 12 Sep 2025 01:41:12 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f20:da00:b70a:d502:3b51:1f2d? (p200300d82f20da00b70ad5023b511f2d.dip0.t-ipconnect.de. [2003:d8:2f20:da00:b70a:d502:3b51:1f2d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e0372b983sm53570065e9.9.2025.09.12.01.41.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 01:41:11 -0700 (PDT)
Message-ID: <04d2d781-fd5e-4778-b042-d4dbeb8c5d49@redhat.com>
Date: Fri, 12 Sep 2025 10:41:10 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 1/5] mm: softdirty: Add pgtable_soft_dirty_supported()
To: Chunyan Zhang <zhang.lyra@gmail.com>
Cc: Chunyan Zhang <zhangchunyan@iscas.ac.cn>,
 linux-riscv@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>, Deepak Gupta <debug@rivosinc.com>,
 Ved Shanbhogue <ved@rivosinc.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Andrew Morton <akpm@linux-foundation.org>, Peter Xu <peterx@redhat.com>,
 Arnd Bergmann <arnd@arndb.de>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>
References: <20250911095602.1130290-1-zhangchunyan@iscas.ac.cn>
 <20250911095602.1130290-2-zhangchunyan@iscas.ac.cn>
 <9bcaf3ec-c0a1-4ca5-87aa-f84e297d1e42@redhat.com>
 <CAAfSe-sAru+FuhVWRa+i5_sj6m4318pLFrgP0Gsd0DVWzjE-hg@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <CAAfSe-sAru+FuhVWRa+i5_sj6m4318pLFrgP0Gsd0DVWzjE-hg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

[...]

>>> +/*
>>> + * We should remove the VM_SOFTDIRTY flag if the soft-dirty bit is
>>> + * unavailable on which the kernel is running, even if the architecture
>>> + * provides the resource and soft-dirty is compiled in.
>>> + */
>>> +#ifdef CONFIG_MEM_SOFT_DIRTY
>>> +     if (!pgtable_soft_dirty_supported())
>>> +             mnemonics[ilog2(VM_SOFTDIRTY)][0] = 0;
>>> +#endif
>>
>> You can now drop the ifdef.
> 
> Ok, you mean define VM_SOFTDIRTY 0x08000000 no matter if
> MEM_SOFT_DIRTY is compiled in, right?
> 
> Then I need memcpy() to set mnemonics[ilog2(VM_SOFTDIRTY)] here.

The whole hunk will not be required when we make sure VM_SOFTDIRTY never 
gets set, correct?

> 
>>
>> But, I wonder if could we instead just stop setting the flag. Then we don't
>> have to worry about any VM_SOFTDIRTY checks.
>>
>> Something like the following
>>
>> diff --git a/include/linux/mm.h b/include/linux/mm.h
>> index 892fe5dbf9de0..8b8bf63a32ef7 100644
>> --- a/include/linux/mm.h
>> +++ b/include/linux/mm.h
>> @@ -783,6 +783,7 @@ static inline void vma_init(struct vm_area_struct *vma, struct mm_struct *mm)
>>    static inline void vm_flags_init(struct vm_area_struct *vma,
>>                                   vm_flags_t flags)
>>    {
>> +       VM_WARN_ON_ONCE(!pgtable_soft_dirty_supported() && (flags & VM_SOFTDIRTY));
>>          ACCESS_PRIVATE(vma, __vm_flags) = flags;
>>    }
>>
>> @@ -801,6 +802,7 @@ static inline void vm_flags_reset(struct vm_area_struct *vma,
>>    static inline void vm_flags_reset_once(struct vm_area_struct *vma,
>>                                         vm_flags_t flags)
>>    {
>> +       VM_WARN_ON_ONCE(!pgtable_soft_dirty_supported() && (flags & VM_SOFTDIRTY));
>>          vma_assert_write_locked(vma);
>>          WRITE_ONCE(ACCESS_PRIVATE(vma, __vm_flags), flags);
>>    }
>> @@ -808,6 +810,7 @@ static inline void vm_flags_reset_once(struct vm_area_struct *vma,
>>    static inline void vm_flags_set(struct vm_area_struct *vma,
>>                                  vm_flags_t flags)
>>    {
>> +       VM_WARN_ON_ONCE(!pgtable_soft_dirty_supported() && (flags & VM_SOFTDIRTY));
>>          vma_start_write(vma);
>>          ACCESS_PRIVATE(vma, __vm_flags) |= flags;
>>    }
>> diff --git a/mm/mmap.c b/mm/mmap.c
>> index 5fd3b80fda1d5..40cb3fbf9a247 100644
>> --- a/mm/mmap.c
>> +++ b/mm/mmap.c
>> @@ -1451,8 +1451,10 @@ static struct vm_area_struct *__install_special_mapping(
>>                  return ERR_PTR(-ENOMEM);
>>
>>          vma_set_range(vma, addr, addr + len, 0);
>> -       vm_flags_init(vma, (vm_flags | mm->def_flags |
>> -                     VM_DONTEXPAND | VM_SOFTDIRTY) & ~VM_LOCKED_MASK);
>> +       vm_flags |= mm->def_flags | VM_DONTEXPAND;
> 
> Why use '|=' rather than not directly setting vm_flags which is an
> uninitialized variable?

vm_flags is passed in by the caller?

But just to clarify: this code was just a quick hack, adjust it as you need.

[...]

>>>
>>> +     if (!pgtable_soft_dirty_supported())
>>> +             return;
>>> +
>>>        if (pmd_present(pmd)) {
>>>                /* See comment in change_huge_pmd() */
>>>                old = pmdp_invalidate(vma, addr, pmdp);
>>
>> That would all be handled with the above never-set-VM_SOFTDIRTY.

I meant that there is no need to add the pgtable_soft_dirty_supported() 
check.

> 
> Sorry I'm not sure I understand here, you mean no longer need #ifdef
> CONFIG_MEM_SOFT_DIRTY for these function definitions, right?

Likely we could drop them. VM_SOFTDIRTY will never be set so the code 
will not be invoked.

And for architectures where VM_SOFTDIRTY is never even possible 
(!CONFIG_MEM_SOFT_DIRTY) we keep it as 0.

That way, the compiler can even optimize out all of that code because

"vma->vm_flags & VM_SOFTDIRTY" -> "vma->vm_flags & 0"

will never be true.

> 
>>
>>> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
>>> index 4c035637eeb7..2a3578a4ae4c 100644
>>> --- a/include/linux/pgtable.h
>>> +++ b/include/linux/pgtable.h
>>> @@ -1537,6 +1537,18 @@ static inline pgprot_t pgprot_modify(pgprot_t oldprot, pgprot_t newprot)
>>>    #define arch_start_context_switch(prev)     do {} while (0)
>>>    #endif
>>>
>>> +/*
>>> + * Some platforms can customize the PTE soft-dirty bit making it unavailable
>>> + * even if the architecture provides the resource.
>>> + * Adding this API allows architectures to add their own checks for the
>>> + * devices on which the kernel is running.
>>> + * Note: When overiding it, please make sure the CONFIG_MEM_SOFT_DIRTY
>>> + * is part of this macro.
>>> + */
>>> +#ifndef pgtable_soft_dirty_supported
>>> +#define pgtable_soft_dirty_supported()       IS_ENABLED(CONFIG_MEM_SOFT_DIRTY)
>>> +#endif
>>> +
>>>    #ifdef CONFIG_HAVE_ARCH_SOFT_DIRTY
>>>    #ifndef CONFIG_ARCH_ENABLE_THP_MIGRATION
>>>    static inline pmd_t pmd_swp_mksoft_dirty(pmd_t pmd)
>>> diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
>>> index 830107b6dd08..b32ce2b0b998 100644
>>> --- a/mm/debug_vm_pgtable.c
>>> +++ b/mm/debug_vm_pgtable.c
>>> @@ -690,7 +690,7 @@ static void __init pte_soft_dirty_tests(struct pgtable_debug_args *args)
>>>    {
>>>        pte_t pte = pfn_pte(args->fixed_pte_pfn, args->page_prot);
>>>
>>> -     if (!IS_ENABLED(CONFIG_MEM_SOFT_DIRTY))
>>> +     if (!pgtable_soft_dirty_supported())
>>>                return;
>>>
>>>        pr_debug("Validating PTE soft dirty\n");
>>> @@ -702,7 +702,7 @@ static void __init pte_swap_soft_dirty_tests(struct pgtable_debug_args *args)
>>>    {
>>>        pte_t pte;
>>>
>>> -     if (!IS_ENABLED(CONFIG_MEM_SOFT_DIRTY))
>>> +     if (!pgtable_soft_dirty_supported())
>>>                return;
>>>
>>>        pr_debug("Validating PTE swap soft dirty\n");
>>> @@ -718,7 +718,7 @@ static void __init pmd_soft_dirty_tests(struct pgtable_debug_args *args)
>>>    {
>>>        pmd_t pmd;
>>>
>>> -     if (!IS_ENABLED(CONFIG_MEM_SOFT_DIRTY))
>>> +     if (!pgtable_soft_dirty_supported())
>>>                return;
>>>
>>>        if (!has_transparent_hugepage())
>>> @@ -734,8 +734,8 @@ static void __init pmd_swap_soft_dirty_tests(struct pgtable_debug_args *args)
>>>    {
>>>        pmd_t pmd;
>>>
>>> -     if (!IS_ENABLED(CONFIG_MEM_SOFT_DIRTY) ||
>>> -             !IS_ENABLED(CONFIG_ARCH_ENABLE_THP_MIGRATION))
>>> +     if (!pgtable_soft_dirty_supported() ||
>>> +         !IS_ENABLED(CONFIG_ARCH_ENABLE_THP_MIGRATION))
>>>                return;
>>>
>>>        if (!has_transparent_hugepage())
>>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>>> index 9c38a95e9f09..218d430a2ec6 100644
>>> --- a/mm/huge_memory.c
>>> +++ b/mm/huge_memory.c
>>> @@ -2271,12 +2271,13 @@ static inline int pmd_move_must_withdraw(spinlock_t *new_pmd_ptl,
>>>
>>>    static pmd_t move_soft_dirty_pmd(pmd_t pmd)
>>>    {
>>> -#ifdef CONFIG_MEM_SOFT_DIRTY
>>> -     if (unlikely(is_pmd_migration_entry(pmd)))
>>> -             pmd = pmd_swp_mksoft_dirty(pmd);
>>> -     else if (pmd_present(pmd))
>>> -             pmd = pmd_mksoft_dirty(pmd);
>>> -#endif
>>> +     if (pgtable_soft_dirty_supported()) {
>>> +             if (unlikely(is_pmd_migration_entry(pmd)))
>>> +                     pmd = pmd_swp_mksoft_dirty(pmd);
>>> +             else if (pmd_present(pmd))
>>> +                     pmd = pmd_mksoft_dirty(pmd);
>>> +     }
>>> +
>>
>> Wondering, should simply the arch take care of that and we can just clal
>> pmd_swp_mksoft_dirty / pmd_mksoft_dirty?
> 

I think we have that already in include/linux/pgtable.h:

We have stubs that just don't do anything.

For riscv support you would handle runtime-enablement in these helpers.

> 
>>
>>>        return pmd;
>>>    }
>>>
>>> diff --git a/mm/internal.h b/mm/internal.h
>>> index 45b725c3dc03..c6ca62f8ecf3 100644
>>> --- a/mm/internal.h
>>> +++ b/mm/internal.h
>>> @@ -1538,7 +1538,7 @@ static inline bool vma_soft_dirty_enabled(struct vm_area_struct *vma)
>>>         * VM_SOFTDIRTY is defined as 0x0, then !(vm_flags & VM_SOFTDIRTY)
>>>         * will be constantly true.
>>>         */
>>> -     if (!IS_ENABLED(CONFIG_MEM_SOFT_DIRTY))
>>> +     if (!pgtable_soft_dirty_supported())
>>>                return false;
>>>
>>
>> That should be handled with the above never-set-VM_SOFTDIRTY.
> 
> We don't need to check if (!pgtable_soft_dirty_supported()) if I
> understand correctly.
Hm, let me think about that. No, I think this has to stay as the comment
says, so this case here is special.

-- 
Cheers

David / dhildenb


