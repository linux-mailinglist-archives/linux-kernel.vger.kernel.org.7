Return-Path: <linux-kernel+bounces-632196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95923AA93D1
	for <lists+linux-kernel@lfdr.de>; Mon,  5 May 2025 15:00:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C81A3ACE7D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 May 2025 12:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC34416F8E5;
	Mon,  5 May 2025 13:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GgohbvPG"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 431061A28D
	for <linux-kernel@vger.kernel.org>; Mon,  5 May 2025 13:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746450011; cv=none; b=RaZrFtV1mumEcG8ndvTF1ukt8aZDxwu/PvZ3UJPxNVXRDLd1h7zH42uJkhJxVwqygq+5lFyPolZuiYQDMMma6D/9BA28Kxpg6eAKo6nEy4eLLj+nW6qVLu7FeKz5ZXHghhQx1PbcGW78kR5e2N49KZatXAJqVm/nPOp6qVf4TUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746450011; c=relaxed/simple;
	bh=IEFNWtfPrrKgyGslNsJ0rdydjZNSgIJkM4pf21obWrg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WTRaP3DjkK4xjOnlf0zEUQ+q7yD7vPltLF3ax0NwZCwsOFIzOwyDQoF1rtr7yyZ9RmIVYfII7vx9q5JQgCdIe+Vt0G+itFA9TeaKdfRB6InH0FcLW+WTcQXNheOf7gHVm9bNDnMzRqAzeHOQfIjuw1P2JXDyPABIP1xHQreWEWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GgohbvPG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746450008;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=je5yctKBePZHtmMRZKSxwf/isS+GUB289Rc9tztHBLQ=;
	b=GgohbvPGuXzNk4OnC+UPBQK2oDGwUCO9LMYVStH2E6VtzfH0imKFJC0bKwP7DC43GQS1CB
	R4OaZv+29P3dMy8Pt9pGBGPQN5VmzQYGAiBoIMH6YE7Eutqe2bAWJr+2J5u/aCO5K8e8kV
	wm/7ISeHVeTibRPDwBRaDMZ6fMD1OzI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-224-jTlPpXkSPtKS_LwTrhJbNg-1; Mon, 05 May 2025 09:00:06 -0400
X-MC-Unique: jTlPpXkSPtKS_LwTrhJbNg-1
X-Mimecast-MFC-AGG-ID: jTlPpXkSPtKS_LwTrhJbNg_1746450006
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3912fe32b08so1870623f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 May 2025 06:00:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746450005; x=1747054805;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=je5yctKBePZHtmMRZKSxwf/isS+GUB289Rc9tztHBLQ=;
        b=tGbbRo+65W5IMXMpt5eKUCfyKtvy3WX3WGFkhGtCOd3JVVwiyG58uGMibpRALJe8Mx
         SVTVY3MXRnRt/ZTxgrRRHPOTf0KxEtHPaUoD4+A/QfhugsW5u3KZ/ozvG7fNvgGvMGjg
         zCwdixDHSYeOYlwIM+pC0lhFEDnzfgQeMbumlZmMxueeH+6MF2kOZpU1wPKCUBv8uuuG
         170LQQEox8XsPSwoUD/Fpr4nIpNW3cnQPcEz0ZoWEgYGJBSJj1QSrL68Nc053tVe6uAR
         jIATvXDzVDnxWqbqa+tCIDi3y5BDjRj4DIIGBpPFP10/XEWokPHsyOdZeiJKnUSSW5XW
         GgDw==
X-Gm-Message-State: AOJu0YyME2/Vij4EeWsIKypUm3k4jsKk7XLf4z1/M3lJRlnyYXqijBmd
	4Rf0nv+tWSG/wIhzhdtCHTWHOvfdwGWOr9JLhy5SX1O//pWmAtfM+xWAI37Yg9xR9atPF+3Lyk6
	NoVGxJtrPWiW6EvnTF/WkfohhLtlIAgsU8YzvlrmCF6KE3bUAVr6yJRQuW3LqsFucDf/qQdUkHZ
	c=
X-Gm-Gg: ASbGncsn4uZn2Aa30jEFUWvUQDPf2/tV4y7NcVjA4RxrcA+OgfsnhuV/nMObkqdtqyU
	Jz4O2VzsmREeIYYVKniCZPdt4SMILKnc1eGmiczZLbysjWuIonEnTnKIhE5XF9+TzAKEZpK+gRL
	BaFw/DyMbk+aetSLzZa7d+XHbdy8zlNwNKuRmNudFFV71XtOOCF6llOnZzRX5mGxjyv6tyPmkdg
	BXLgu8SzIUhu14hQdx2Am4Z2/TFXR1UWmO5v5NrPz2T04y0t1R+dYYSHENO0aXk8nzEqYYk25FP
	BlWWhXVwU0X+gpL3VjoUeEZDzAxDZl5y58pD1h287JXTpdIEynxhXBuU8dHWYLzl8mVnE/pO/hI
	ho2wfXest0hiov4Buk6y6qBZOcFq7Tf/eP4YU5bY=
X-Received: by 2002:a05:6000:2901:b0:38f:6287:6474 with SMTP id ffacd0b85a97d-3a09ceaf8cbmr6337830f8f.15.1746450005562;
        Mon, 05 May 2025 06:00:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG8+sbICSw53/kA+NmQw2Gp6nCdKw3+wguliwt/RdvnGaev2dGEidEgKuqoSFf1dl2vWgWnLg==
X-Received: by 2002:a05:6000:2901:b0:38f:6287:6474 with SMTP id ffacd0b85a97d-3a09ceaf8cbmr6337766f8f.15.1746450004985;
        Mon, 05 May 2025 06:00:04 -0700 (PDT)
Received: from ?IPV6:2003:cb:c73d:2400:3be1:a856:724c:fd29? (p200300cbc73d24003be1a856724cfd29.dip0.t-ipconnect.de. [2003:cb:c73d:2400:3be1:a856:724c:fd29])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a099ae7b09sm10197488f8f.48.2025.05.05.06.00.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 May 2025 06:00:04 -0700 (PDT)
Message-ID: <7035fb14-c9f6-4281-9f65-b220aaa8f5c3@redhat.com>
Date: Mon, 5 May 2025 15:00:02 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 05/11] mm: convert VM_PFNMAP tracking to pfnmap_track()
 + pfnmap_untrack()
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
 intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-trace-kernel@vger.kernel.org, Dave Hansen
 <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 "H. Peter Anvin" <hpa@zytor.com>, Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Tvrtko Ursulin
 <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Andrew Morton <akpm@linux-foundation.org>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
 Pedro Falcato <pfalcato@suse.de>, Peter Xu <peterx@redhat.com>,
 Suren Baghdasaryan <surenb@google.com>
References: <20250425081715.1341199-1-david@redhat.com>
 <20250425081715.1341199-6-david@redhat.com>
 <b92e3a0d-b878-43cf-9b68-9f7c228e45fa@lucifer.local>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <b92e3a0d-b878-43cf-9b68-9f7c228e45fa@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

>>
>> This change implies that we'll keep tracking the original PFN range even
>> after splitting + partially unmapping it: not too bad, because it was
>> not working reliably before. The only thing that kind-of worked before
>> was shrinking such a mapping using mremap(): we managed to adjust the
>> reservation in a hacky way, now we won't adjust the reservation but
>> leave it around until all involved VMAs are gone.
> 
> Hm, but what if we shrink a VMA, then map another one, might it be
> incorrectly storing PAT attributes for part of the range that is now mapped
> elsewhere?

Not "incorrectly". We'll simply undo the reservation of the cachemode 
for the original PFN range once everything of the original VMA is gone.

AFAIK, one can usually mmap() the "unmapped" part after shrinking again 
with the same cachemode, which should be the main use case.

Supporting partial un-tracking will require hooking into vma splitting 
code ... not something I am super happy about. :)

> 
> Also my god re: the 'kind of working' aspects of PAT, so frustrating.
> 
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
> 
> Generally looking good, afaict, but maybe let's get some input from Suren
> on VMA size.
> 
> Are there actually any PAT tests out here? I had a quick glance in
> tools/testing/selftests/x86,mm and couldn't find any, but didn't look
> _that_ card.

Heh, booting a simple VM gets PAT involved. I suspect because /dev/mem 
and BIOS/GPU/whatever hacks.

In the cover letter I have

"Briefly tested with some basic /dev/mem test I crafted. I want to 
convert them to selftests, but that might or might not require a bit of
more work (e.g., /dev/mem accessibility)."

> 
> Thanks in general for tackling this, this is a big improvement!
> 
>> ---
>>   include/linux/mm_inline.h |  2 +
>>   include/linux/mm_types.h  | 11 ++++++
>>   kernel/fork.c             | 54 ++++++++++++++++++++++++--
>>   mm/memory.c               | 81 +++++++++++++++++++++++++++++++--------
>>   mm/mremap.c               |  4 --
>>   5 files changed, 128 insertions(+), 24 deletions(-)
>>
>> diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
>> index f9157a0c42a5c..89b518ff097e6 100644
>> --- a/include/linux/mm_inline.h
>> +++ b/include/linux/mm_inline.h
>> @@ -447,6 +447,8 @@ static inline bool anon_vma_name_eq(struct anon_vma_name *anon_name1,
>>
>>   #endif  /* CONFIG_ANON_VMA_NAME */
>>
>> +void pfnmap_track_ctx_release(struct kref *ref);
>> +
>>   static inline void init_tlb_flush_pending(struct mm_struct *mm)
>>   {
>>   	atomic_set(&mm->tlb_flush_pending, 0);
>> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
>> index 56d07edd01f91..91124761cfda8 100644
>> --- a/include/linux/mm_types.h
>> +++ b/include/linux/mm_types.h
>> @@ -764,6 +764,14 @@ struct vma_numab_state {
>>   	int prev_scan_seq;
>>   };
>>
>> +#ifdef __HAVE_PFNMAP_TRACKING
>> +struct pfnmap_track_ctx {
>> +	struct kref kref;
>> +	unsigned long pfn;
>> +	unsigned long size;
> 
> Again, (super) nitty, but we really should express units. I suppose 'size'
> implies bytes to be honest as you'd unlikely say 'size' for number of pages
> (you'd go with nr_pages or something). But maybe a trailing /* in bytes */
> would help.
> 
> Not a big deal though!

"size" in the kernel is usually bytes, never pages ... but I might be wrong.

Anyhow, I can use "/* in bytes*/" here, although I doubt that many will 
benefit from this comment :)

> 
>> +};
>> +#endif
>> +
>>   /*
>>    * This struct describes a virtual memory area. There is one of these
>>    * per VM-area/task. A VM area is any part of the process virtual memory
>> @@ -877,6 +885,9 @@ struct vm_area_struct {
>>   	struct anon_vma_name *anon_name;
>>   #endif
>>   	struct vm_userfaultfd_ctx vm_userfaultfd_ctx;
>> +#ifdef __HAVE_PFNMAP_TRACKING
> 
> An aside, but absolutely hate '__HAVE_PFNMAP_TRACKING' as a name here. But
> you didn't create it, and it's not really sensible to change it in this
> series so. Just a rumble...

I cannot argue with that ... same here.

To be clear: I hate all of this with passion ;) With this series, I hate 
it a bit less.

[...]

> 
> Obviously my series will break this but should be _fairly_ trivial to
> update.
> 
> You will however have to make sure to update tools/testing/vma/* to handle
> the new functions in userland testing (they need to be stubbed otu).

Ah, I was happy it compiled but looks like I'll have to mess with that 
as well.

> 
> If it makes life easier, you can even send it to me off-list, or just send
> it without changing this in a respin and I can fix it up fairly quick for
> you.

Let me give it a try first, I'll let you know if it takes me too long.

Thanks!

[...]

>>   /**
>>    * remap_pfn_range - remap kernel memory to userspace
>>    * @vma: user vma to map to
>> @@ -2883,20 +2902,50 @@ int remap_pfn_range_notrack(struct vm_area_struct *vma, unsigned long addr,
>>    *
>>    * Return: %0 on success, negative error code otherwise.
>>    */
>> +#ifdef __HAVE_PFNMAP_TRACKING
>>   int remap_pfn_range(struct vm_area_struct *vma, unsigned long addr,
>>   		    unsigned long pfn, unsigned long size, pgprot_t prot)
> 
> OK so to expose some of my lack-of-knowledge of PAT - is this the
> 'entrypoint' to PAT tracking?

Only if you're using remap_pfn_range() ... there is other low-level 
tracking/reservation using the memtype_reserve() interface and friends.

> 
> So we have some kernel memory we remap to userland as PFN map, the kind
> that very well might be sensible to use PAT the change cache behaviour for,
> and each time this happens, it's mapped as PAT?

Right, anytime someone uses remap_pfn_range() on the full VMA, we track 
it (depending on RAM vs. !RAM this "tracking" has different semantics).

For RAM, we seem to only lookup the cachemode. For !RAM, we seem to 
reserve the memtype for the PFN range, which will fail if there already 
is an incompatible memtype reserved.

It's all ... very weird.

-- 
Cheers,

David / dhildenb


