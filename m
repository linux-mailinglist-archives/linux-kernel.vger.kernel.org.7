Return-Path: <linux-kernel+bounces-830390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 19BD8B99895
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 13:06:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C08CB17FB4B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 11:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 321112E6105;
	Wed, 24 Sep 2025 11:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dT7yiylI"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE9352E2EE7
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 11:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758711954; cv=none; b=pAZyi2ss5eYR/Er16+OuwSCo1bTPYqPYfKdfmmWsW7lDRk10B5dEOke3OT3MaxmK0kUhqIE7oMWyW6nJyo5b9Lv/L4Yxz5h8sjzQzdznjifhEO8v5qKEHYLDjPnA8MrQf8U9EWXLj3SDN4W9QtywA4BMYGjDy7dBGwIYP0qKzrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758711954; c=relaxed/simple;
	bh=fvUBgljBKVg43zzTcyNN9gbB3w/x7fiREhcYmZZivJc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mt+aZXcv1JE61t8bJP5bi4DAX6VMRMTd25rP/Hxmpn1ZcN1a4Pi5wxhlVYXiEsz7/oKemAYhnN9TFJ0N60ZoB97Gt8Ig/xy8sKDJlU+VA/z6uK9VPkUHU5Aqj2jIB+tiWEoLhD3i5VRl7XaeltAZ5nIg29aq2TmDslVzhIVmzU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dT7yiylI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758711948;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=pJfstQJzF7vQWtME8nc3e37MPEdGJfdg+SENn3HGjjw=;
	b=dT7yiylIJrBfLUptE3Bv9xggagrRl7wY84nGwWX1uXRvKpQqo/vZDiRurbFN/FBDI1fT5m
	Kn2c58j0aAkmOxnXWcxqoRhdEQ3ESleQ4J4CzU8+5q2f9vgSNWW6JNH6w8nE0nf4FLUz8g
	IXLM/Gyh2Lsnx5duGXoW6y0OTDsfvvI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-488-fuXq1JsBMNunna_WnTFHRQ-1; Wed, 24 Sep 2025 07:05:46 -0400
X-MC-Unique: fuXq1JsBMNunna_WnTFHRQ-1
X-Mimecast-MFC-AGG-ID: fuXq1JsBMNunna_WnTFHRQ_1758711946
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-46e31191379so747975e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 04:05:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758711945; x=1759316745;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pJfstQJzF7vQWtME8nc3e37MPEdGJfdg+SENn3HGjjw=;
        b=MYtqp5fyoHyBk/p5ZOp67WN8BHKQ58NQKQNI9dsGLb/VG7FOMRqgXamqe/e55Q18eH
         eNAB35BBI6Sse/V7WOUL7SltEAKub7Sr4ndY+aiOr2FnCaLSzr4FqjhoaAyOIghtBmqd
         tDQfFErV3IBxAqRe1Y7QQMYFW9E17tev3XjjcK8Jjz2CxFWPV7s/molAu6tCTWvCsyYK
         33VmYCLUe+pkFLkOI9VbrxwPVe8s5KehtcmYS9hZLSw4E+j0VK7ee6ykg7UOdpmR6uoi
         7zJOjDhDDLvlyllsbYp/xAbbK1i1KhD/SCiUP/O5+HbVXyGg9k6VvffFocqqVyexv8AL
         Qukw==
X-Gm-Message-State: AOJu0YzYaoL7SHgyci+jllWINzp6BJnjTEFZT0qlCHQ0SUfyvt61TKE+
	S0Py5OYl9QLLBrRLwqbsnB95UFIyiY0GPOt1yXDvWiWVRa3euUXjOd1I0nL1t6ks3/LgQletWO7
	C18yiv8X5SCAhG52EL/NstyCIru8kP0RE6u9qfdbEJI4jABhOnSflpXZ/Wmjm//x8Kw==
X-Gm-Gg: ASbGncuXE7Z45hqH+uRyAz0OUW90DvLAvW5ngq+QNl17I7s/ZtdoLHagSUOi391QWsU
	tpE2m61c9CSYb7F+6x3ZzvepFblsoA0Mskpx3u4ioTvfCGm06Jf7YWG8r2Nj8plAtt2FOkQ5/ks
	9qtIu7uJOGEOxtvFPn/R3FBEAzn4nzcwF0Huh5ZsbgyAFQT9KdaIZM4giOALcKKVUZcddOqec/u
	ylH+U7YRVgY80dNdUlnlsCwmX6j1mA0RE6powigch4ancAk3tosw8rPW6Rp0y4Qu8BhR98a7uog
	t/GBT1eerU/IuTz5tD4Zkupzacp2B8atGsv8vUlaevoBpphOh5GnDrpwGRJCq2M1XTOi6fvHv90
	RK+t96IOD6FpWLRRuIUjkyZsaHhowEEKB1E++1zhIhpz30YMquWNuw1lAEqY3QuOQRA==
X-Received: by 2002:a05:600c:4703:b0:45d:cfee:7058 with SMTP id 5b1f17b1804b1-46e1dad1bcemr54121265e9.22.1758711945451;
        Wed, 24 Sep 2025 04:05:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHbaeHw9ntX1+d3BLrDR31uBudOw3xXPWA7XtzGS71JBGdZjAGfyJ4Rw0XfiWGDvgzwltJ3qw==
X-Received: by 2002:a05:600c:4703:b0:45d:cfee:7058 with SMTP id 5b1f17b1804b1-46e1dad1bcemr54120805e9.22.1758711944957;
        Wed, 24 Sep 2025 04:05:44 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f14:2400:afc:9797:137c:a25b? (p200300d82f1424000afc9797137ca25b.dip0.t-ipconnect.de. [2003:d8:2f14:2400:afc:9797:137c:a25b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e2a9af289sm28426105e9.6.2025.09.24.04.05.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Sep 2025 04:05:44 -0700 (PDT)
Message-ID: <6743ead5-4d61-4274-a24f-13a8a8265aee@redhat.com>
Date: Wed, 24 Sep 2025 13:05:42 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 10/16] mm: define clear_pages(), clear_user_pages()
To: Ankur Arora <ankur.a.arora@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
 akpm@linux-foundation.org, bp@alien8.de, dave.hansen@linux.intel.com,
 hpa@zytor.com, mingo@redhat.com, mjguzik@gmail.com, luto@kernel.org,
 peterz@infradead.org, acme@kernel.org, namhyung@kernel.org,
 tglx@linutronix.de, willy@infradead.org, raghavendra.kt@amd.com,
 boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
References: <20250917152418.4077386-1-ankur.a.arora@oracle.com>
 <20250917152418.4077386-11-ankur.a.arora@oracle.com>
 <5ec85b0b-9848-4cee-98f4-37953d504773@redhat.com> <87y0q4ewzf.fsf@oracle.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <87y0q4ewzf.fsf@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 23.09.25 22:26, Ankur Arora wrote:
> 
> David Hildenbrand <david@redhat.com> writes:
> 
>> On 17.09.25 17:24, Ankur Arora wrote:
>>> Define fallback versions of clear_pages(), clear_user_pages().
>>> In absence of architectural primitives, we just clear pages
>>> sequentially.
>>> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
>>> ---
>>>    include/linux/mm.h | 38 ++++++++++++++++++++++++++++++++++++++
>>>    1 file changed, 38 insertions(+)
>>> diff --git a/include/linux/mm.h b/include/linux/mm.h
>>> index 1ae97a0b8ec7..0cde9b01da5e 100644
>>> --- a/include/linux/mm.h
>>> +++ b/include/linux/mm.h
>>> @@ -3768,6 +3768,44 @@ static inline void clear_page_guard(struct zone *zone, struct page *page,
>>>    				unsigned int order) {}
>>>    #endif	/* CONFIG_DEBUG_PAGEALLOC */
>>>    +#ifndef clear_pages
>>> +/**
>>> + * clear_pages() - clear a page range using a kernel virtual address.
>>
>> I'd just call this "clear a page range for kernel-internal use"
>>
>>> + * @addr: start address
>>> + * @npages: number of pages
>>> + *
>>> + * Assumes that (@addr, +@npages) references a kernel region.
>>
>> And say here simply that "Use clear_user_pages() instead for clearing a page
>> range to be mapped to user space".
> 
> So, comments that actually speak to the use instead of technically
> correct but unhelpful generalities :). Thanks, good lesson.
> 
>>> + * Does absolutely no exception handling.
>>> + */
>>> +static inline void clear_pages(void *addr, unsigned int npages)
>>> +{
>>> +	do {
>>> +		clear_page(addr);
>>> +		addr += PAGE_SIZE;
>>> +	} while (--npages);
>>> +}
>>> +#endif
>>> +
>>> +#ifndef clear_user_pages
>>> +/**
>>> + * clear_user_pages() - clear a page range mapped by the user.
>>
>> I'd call this then "clear a page range to be mapped to user space"
>>
>> Because it's usually called before we actually map it and it will properly flush
>> the dcache if required.
> 
> Makes sense.
> 
>>> + * @addr: kernel mapped address
>>
>> "start address"
>>
>>> + * @vaddr: user mapped address
>>
>> "start address of the user mapping" ?
>>
>>> + * @pg: start page
>>
>> Please just call it "page". I know, clear_user_page() has this weird page vs. pg
>> thingy, but let's do it better here.
>>
>>> + * @npages: number of pages
>>> + *
>>> + * Assumes that the region (@addr, +@npages) has been validated
>>> + * already so this does no exception handling.
>>> + */
>>> +#define clear_user_pages(addr, vaddr, pg, npages)	\
>>> +do {							\
>>> +	clear_user_page(addr, vaddr, pg);		\
>>> +	addr += PAGE_SIZE;				\
>>> +	vaddr += PAGE_SIZE;				\
>>> +	pg++;						\
>>> +} while (--npages)
>>> +#endif
>>
>> Should indent with one tab.
> 
> Will do. Also acking to the ones above.
> 
>> Any reason this is not a static inline function?
> 
> Alas yes. Most architecture code defines clear_user_page() as a macro
> where, if they need a to flush the dcache or otherwise do something
> special, they need access to some external primitive. And this primitive
> which might not be visible in contexts that we include this header.
> 
> For instance this one on sparc:
>    https://lore.kernel.org/lkml/202509030338.DlQJTxIk-lkp@intel.com/
> 
> Defining as a macro to get around that. But maybe there's a better
> way?

Can we just move it to mm/utils.c and not have it be an inline function?


-- 
Cheers

David / dhildenb


