Return-Path: <linux-kernel+bounces-736763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA1E2B0A186
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 13:05:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 818BE5A7980
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 11:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6325D2BEFE3;
	Fri, 18 Jul 2025 11:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ae3OEBR7"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB7642BE03E
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 11:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752836678; cv=none; b=eCdvAqww6GWLII9R73E4xNcMwUD8shCvVBdPDxA+4BGvg2eqvI1dSS9giGt+YmbzKwvsyqLyCx4k9dL7FP15Ma8KNH44R7a4LL71AbUI8Ups4eMLJsp7o49GZRuSklD64HbC7Dqni4a0uYHo1eNC+Qb9WnAyU3p1A3RjmgbpFbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752836678; c=relaxed/simple;
	bh=K4UzCk7l/usEqkMfYrs5O8hD83mwZskZbiHMNwCrxIg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Lo4Jao8XEELZblr7gkIebfplnvscrYYi6Km8Pwu8BR7WTP1rYkJoBXm9IdzXllou3m+ybaCz6OrgFghPeX0ARrLd9CmwKtChbYuBm/eAfF+26f8EOubsCTZK8ScQOkbpYhM+s41lNjPzoiuT9E9HCGW7oANdxhG28Sl3DcYHHcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ae3OEBR7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752836675;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=gD5Lm1/Db3vBqFiG+jWE8MvYk8ZZaCpGhPUn7DOAZnw=;
	b=Ae3OEBR7eGhQ2SCHj91cZzSP7KX4qLT06A9gTDqvTgUHB7BlXaZGet93aVjRBj3TQ2oG3L
	x88jq6XsmcG2vEt8+60VDI6cC33zONixRvuv6LOo1MUjv+K5k3pFLlTc1skdMc35wL4znG
	ANg6KppUQpjQxaPV7nVq8OK1wlqoRTQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-3kuXBmu2M_6w88QvKLxBZw-1; Fri, 18 Jul 2025 07:04:34 -0400
X-MC-Unique: 3kuXBmu2M_6w88QvKLxBZw-1
X-Mimecast-MFC-AGG-ID: 3kuXBmu2M_6w88QvKLxBZw_1752836673
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3b5f97cb8fbso945843f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 04:04:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752836673; x=1753441473;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gD5Lm1/Db3vBqFiG+jWE8MvYk8ZZaCpGhPUn7DOAZnw=;
        b=lniERHAOpX681m7yCEW/mBYGGok0pJt7ebXzD++RQXMB0tnkOQU5gkC22uBfPPh6BX
         FJ1d21uMcHsvtLMplV04GPHvfn6iwFvS5OZRi7caWavqn09wF/VgUStprlfnHT6NyP5L
         F1KvHJFwzJnwTEuiOA/npzveNjZTIENUvI5h64G51YHgMh0uAnJ8sLztsOWy6yBVHLMi
         roroMXKka67DqxFholjFmi4eoETlJfePS4GM7gf++/JaKGgJ68e+t7GTIJk4H1uaMk2M
         LMGH9S5cXf6aEg3OaoH9kUUIEZY4Q2k5GwcuDOKSPzCh7kImDPvMDYdL9+O5Rd5QOHf8
         GC0A==
X-Gm-Message-State: AOJu0Yzlq3M7TRS+UVeAbKKv/cg1U0Myj0b4mpvayr5w4tD9a7AL/EyU
	kCfzmw3bJDxofgovbS+rfmVEOwRNFR/zvIG1M+vLLwmrFN/lmbDUQpTIySgL6p1pDTjF7yM+nRD
	kQddP+nU8nwj62XiiS3XuuYGbojX476Oiz2KHq7oGf8ulUeMpTBi2siKGkn5LWHYmng==
X-Gm-Gg: ASbGnctH5VR1KxsZF4U295MN40B7FBJ2VpcPRbOkhuaY6cQcijmuASM77l6SaPRgWwm
	feso2Opb9hWydqXNSmV3zPKhN17gXlgxq+jf6lJS9CH/IWsdFiDZmgZODo21kaciV84DarXI1KC
	+NoyKxb6zLCDGSuumZh9rBiPSkyCaD0oNKQKzZYVPyLmmsrloeycurbx7yYpXTnaFBe5jjCmwgF
	xrz6hLTVxx8LKVL0x8nVSod/EBVhBOLJHIE7+b1kJzbvxPhPwTR/JF1RhiT/4AoXr2NGvO3B5/B
	EAE3DPFkhPDIHvwE/DYvWd+4cTTVQyr4hxKni92fMV4N7i0ANjYS8BU/1xXWlVNd5sj8jXM9dnT
	ZSaOUEczqi1bk5H5qfvN3ciuDoHlxElCXF8gDx3u+N62LTLD1QNZ9Pj5arPxCzjlsPJk=
X-Received: by 2002:a5d:5e85:0:b0:3a6:d93e:5282 with SMTP id ffacd0b85a97d-3b60e53d2abmr7181624f8f.59.1752836673217;
        Fri, 18 Jul 2025 04:04:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFslOamHxai0YudN9CgxoIU9NtEzyL1F7n+V5XjzgwJGeuez7anN3aHinujW5VSJzYCUXKb/A==
X-Received: by 2002:a5d:5e85:0:b0:3a6:d93e:5282 with SMTP id ffacd0b85a97d-3b60e53d2abmr7181577f8f.59.1752836672571;
        Fri, 18 Jul 2025 04:04:32 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f43:8900:f364:1333:2a67:d49e? (p200300d82f438900f36413332a67d49e.dip0.t-ipconnect.de. [2003:d8:2f43:8900:f364:1333:2a67:d49e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4563b5a527asm17121825e9.1.2025.07.18.04.04.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Jul 2025 04:04:32 -0700 (PDT)
Message-ID: <c8b9c805-2760-4b90-951a-3666cad6a4a4@redhat.com>
Date: Fri, 18 Jul 2025 13:04:30 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/9] mm/memory: convert print_bad_pte() to
 print_bad_page_map()
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 xen-devel@lists.xenproject.org, linux-fsdevel@vger.kernel.org,
 nvdimm@lists.linux.dev, Andrew Morton <akpm@linux-foundation.org>,
 Juergen Gross <jgross@suse.com>, Stefano Stabellini
 <sstabellini@kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 Dan Williams <dan.j.williams@intel.com>, Matthew Wilcox
 <willy@infradead.org>, Jan Kara <jack@suse.cz>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
 Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
 Hugh Dickins <hughd@google.com>, Oscar Salvador <osalvador@suse.de>,
 Lance Yang <lance.yang@linux.dev>
References: <20250717115212.1825089-1-david@redhat.com>
 <20250717115212.1825089-7-david@redhat.com>
 <73702a7c-d0a9-4028-8c82-226602eb3286@lucifer.local>
 <c93f873c-813e-42c9-ba01-93c2fa22fb8d@redhat.com>
 <200da552-4fc7-44d8-bbea-1669b4b45cf5@lucifer.local>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <200da552-4fc7-44d8-bbea-1669b4b45cf5@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

> 
> Yeah sorry I was in 'what locks do we need' mode and hadn't shifted back here,
> but I guess the intent is that the caller _must_ hold this lock.
> 
> I know it's nitty and annoying (sorry!) but as asserting seems to not be a
> possibility here, could we spell these out as a series of points like:
> 
> /*
>   * The caller MUST hold the following locks:
>   *
>   * - Leaf page table lock
>   * - Appropriate VMA lock to keep VMA stable
>   */
> 
> I don't _actually_ think you need the rmap lock then, as none of the page tables
> you access would be impacted by any rmap action afaict, with these locks held.

I don't enjoy wrong comments ;)

This can be called from rmap code when doing a vm_normal_page() while 
holding the PTL.

Really, I think we are over-thinking a helper that is triggered in 
specific context when the world is about to collide.

This is not your general-purpose API.

Maybe I should have never added a comment. Maybe I should just not have 
done this patch, because I really don't want to do more than the bare 
minimum to print_bad_page_map().

Because I deeply detest it, and no comments we will add will change that.

[...]

>>> But can you truly be sure of these existing? And we should then assert them
>>> here no? For rmap though we'd need the folio/vma.
>>
>> I hope you realize that this nastiness of a code is called in case our
>> system is already running into something extremely unexpected and will
>> probably be dead soon.
>>
>> So I am not to interested in adding anything more here. If you run into this
>> code you're in big trouble already.
> 
> Yes am aware :) my concern is NULL ptr deref or UAF, but with the locks
> held as stated those won't occur.
> 
> But f it's not sensible to do it then we don't have to :) I am a reasonable
> man, or like to think I am ;)
> 
> But I think we need clarity as per the above.
> 
>>
>>>
>>>> +	pgdp = pgd_offset(mm, addr);
>>>> +	pgdv = pgd_val(*pgdp);
>>>
>>> Before I went and looked again at the commit msg I said:
>>>
>>> 	"Shoudln't we strictly speaking use pgdp_get()? I see you use this
>>> 	 helper for other levels."
>>>
>>> But obviously yeah. You explained the insane reason why not.
>>
>> Had to find out the hard way ... :)
> 
> Pain.
> 
>>
>> [...]
>>
>>>> +/*
>>>> + * This function is called to print an error when a bad page table entry (e.g.,
>>>> + * corrupted page table entry) is found. For example, we might have a
>>>> + * PFN-mapped pte in a region that doesn't allow it.
>>>> + *
>>>> + * The calling function must still handle the error.
>>>> + */
>>>
>>> We have extremely strict locking conditions for the page table traversal... but
>>> no mention of them here?
>>
>> Yeah, I can add that.
> 
> Thanks!
> 
>>
>>>
>>>> +static void print_bad_page_map(struct vm_area_struct *vma,
>>>> +		unsigned long addr, unsigned long long entry, struct page *page)
>>>> +{
>>>> +	struct address_space *mapping;
>>>> +	pgoff_t index;
>>>> +
>>>> +	if (is_bad_page_map_ratelimited())
>>>> +		return;
>>>>
>>>>    	mapping = vma->vm_file ? vma->vm_file->f_mapping : NULL;
>>>>    	index = linear_page_index(vma, addr);
>>>>
>>>> -	pr_alert("BUG: Bad page map in process %s  pte:%08llx pmd:%08llx\n",
>>>> -		 current->comm,
>>>> -		 (long long)pte_val(pte), (long long)pmd_val(*pmd));
>>>> +	pr_alert("BUG: Bad page map in process %s  entry:%08llx", current->comm, entry);
>>>
>>> Sort of wonder if this is even useful if you don't know what the 'entry'
>>> is? But I guess the dump below will tell you.
>>
>> You probably missed in the patch description:
>>
>> "Whether it is a PTE or something else will usually become obvious from the
>> page table dump or from the dumped stack. If ever required in the future, we
>> could pass the entry level type similar to "enum rmap_level". For now, let's
>> keep it simple."
> 
> Yeah sorry I glossed over the commit msg, and now I pay for it ;) OK this
> is fine then.

Let me play with indicating the page table level, but it's the kind of 
stuff I wouldn't want to do in this series here.

>>
>>>
>>> Then we have VM_IO, which strictly must not have an associated page right?
>>
>> VM_IO just means read/write side-effects, I think you could have ones with
>> an memmap easily ... e.g., memory section (128MiB) spanning both memory and
>> MMIO regions.
> 
> Hmm, but why not have two separate VMAs? I guess I need to look into more
> what this flag actually effects.

Oh, I meant, that we might have a "struct page" for MMIO memory 
(pfn_valid() == true).

In a MIXEDMAP that will get refcounted. Not sure if there are users that 
use VM_IO in a MIXEDMAP, I would assume so but didn't check.

So VM_IO doesn't really interact with vm_normal_page(), really. It's all 
about PFNMAP and MIXEDMAP.

-- 
Cheers,

David / dhildenb


