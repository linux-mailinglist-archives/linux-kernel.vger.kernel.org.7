Return-Path: <linux-kernel+bounces-789582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45129B397A0
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 10:59:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DBDD171D44
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 08:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FE3C2EBBB7;
	Thu, 28 Aug 2025 08:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DJyhdxTs"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 315AD2E8882
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 08:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756371568; cv=none; b=fHVinUYAk+Rhy3qMrrclhrFGHOVSpDINOR2iquCWYNF2b7zX3PLES7K+gDvI34Tj7ds3Eey1+JnD86jiSz2EnUYBgGg9T+9USTbWezu0yDxhLlWhJDjD3ctdB41+CgY53G/KnujZN93lk6sxM7V80gSN/BzYlo79W3149Q1/VCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756371568; c=relaxed/simple;
	bh=mv6f08Qw5SA9ziG/QS7GDYllGSYFnyc0Lhyyo9B1qlM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B+J78GFgVJik1F5lUwPYwh+Pu1Osi50ODE+jzgJQhTpBiuE9kLQHaLeMxxrJUKWv/rIzEWNkwvyLIqJwb3LrWFBxUycD9PbsJekErq80U1bbf2ba0xNvE5wCgDzJDta+dMBCaOTPlZqtB/5cugNRWjK2HlSg8V7kF0egEiVnLps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DJyhdxTs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756371565;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=qGBV0trfmwtCdsO1on6+SbThI8fH1bwSfxhJY1VBlnI=;
	b=DJyhdxTsBPMmdT9t+iJaDI3ghMFopdgI5d/oX5HfnilKVgLu63V0VS0v6Xs7KsD2FjsaCi
	U5q0cfIcN95HiDoZNxFFT/wv8wQGEqbu/OVYzqHmU59dCXK2P+o9pKnd+OhbeFS2xuyiXz
	GEF878+eHQ1s8V5Xx7vaAQOF0bBHSkk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-481-Wz-IvInBPGKiQPAh8MWpWQ-1; Thu, 28 Aug 2025 04:59:24 -0400
X-MC-Unique: Wz-IvInBPGKiQPAh8MWpWQ-1
X-Mimecast-MFC-AGG-ID: Wz-IvInBPGKiQPAh8MWpWQ_1756371563
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-45a1ad21752so3754435e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 01:59:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756371563; x=1756976363;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qGBV0trfmwtCdsO1on6+SbThI8fH1bwSfxhJY1VBlnI=;
        b=YKewKfent1Pn37ea7VZmduzbqaLO7X5vseQ1lRHtmDJF7bGZx3gGrarzSetMZTYHmq
         xya0I9kbfjuIBRjr2SVhTeRwu3BwYGq2wTMa3aQ+yFp4f8mFIMAz0eyZp7ixnUO00itS
         c8cDtCJBaRISq72m7fZyivsjrYT1o5Jy5KI+dB8ca7AkeNUXpMP2/NhFK3R2j++iJDHP
         LyrpQwwK2s+NUWgdzvOohecjLRAgbRl+OO65MZ2GsUx1UNFUE6LaEiDv+v0bDyx54i8s
         O8+c7QpI3Q4ZfbNH+i5wxunIO04nu1Z7ujH0SyYdOayFpSSU4AFpr4Tc72Wp7b8SAVyQ
         Njrg==
X-Forwarded-Encrypted: i=1; AJvYcCU4vRdCBlW/g3dEnCXK4/YD6nnu0Eiv6sNAsEh8KayOAVmj4RbS72HOmzBQD9uPGvbhp0Kkf5sqCTWzm8g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnJvoKgSLr1qWe8YOC3vvMH6mr05bxuOnrpaduwAQ09MIJrKKQ
	jw7pGkKPj+VBeg63OKhGUVRBOkvbgWXk2+peVAZB+vHHQuZR4f7Cdpn0T3LWre60kpVqEuz6dxZ
	/LwjUxYMwbHYSvGNz7WC3ovHN+4ThugcoaeKhv/xERk7a9DqVemLA1avBPVCQH284vw==
X-Gm-Gg: ASbGnctF9eMw8A7OBfxY3py5q+caU5MiqcR6CSkeWDkwfxxfwLzMAJ/WqXUEMGqvHEK
	/+HDYfw3ZANiBUmXBQPG4Q0mF6jjVLbG/XNPy6Y+uqrP4mFH1gxwXvvkMEKZdMZT3uXnGGEdUTn
	log3aLKfoPtqMa3cpecDUaolBHY9hoviYpRKoozb8fYbmpxryYaGYKxo+t0YdpDIiliv+5EoPda
	zcnh7E6YOA/+pSAyf1JxbhGcpWMiFamOW+JoINh36CuHMSa/4N66cOr14OwuWpuCw/1YKMrB1bD
	eTA7o2pmKa8yjCygwB5F+o3a9i8fOPZai68EyoyskaE5wqkGyGDV/iOL791R6WPpHmtsLC0mG9i
	1mMGmM1wi0YJD0PdXBPUxjCnw94PvPrq45FhY98a7uxkPcUyDZKXM7JZscUsXvc6NlDU=
X-Received: by 2002:a05:600c:5246:b0:458:6f13:aa4a with SMTP id 5b1f17b1804b1-45b68b79262mr80522965e9.6.1756371562828;
        Thu, 28 Aug 2025 01:59:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFWdyMtBKjr7hAqURhS0tLFjeTMjbDj3wWx/dBhhAh6ZZbIaTVjgJ+6cEX3TylMiqVoySxXmw==
X-Received: by 2002:a05:600c:5246:b0:458:6f13:aa4a with SMTP id 5b1f17b1804b1-45b68b79262mr80522605e9.6.1756371562368;
        Thu, 28 Aug 2025 01:59:22 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f28:c100:2225:10aa:f247:7b85? (p200300d82f28c100222510aaf2477b85.dip0.t-ipconnect.de. [2003:d8:2f28:c100:2225:10aa:f247:7b85])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cd8bb9ee97sm3403595f8f.27.2025.08.28.01.59.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Aug 2025 01:59:21 -0700 (PDT)
Message-ID: <a0d1d889-c711-494b-a85a-33cbde4688ba@redhat.com>
Date: Thu, 28 Aug 2025 10:59:20 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/gup: Drain batched mlock folio processing before
 attempting migration
To: Hugh Dickins <hughd@google.com>, Will Deacon <will@kernel.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Keir Fraser <keirf@google.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 John Hubbard <jhubbard@nvidia.com>, Frederick Mayle <fmayle@google.com>,
 Andrew Morton <akpm@linux-foundation.org>, Peter Xu <peterx@redhat.com>,
 Rik van Riel <riel@surriel.com>, Vlastimil Babka <vbabka@suse.cz>,
 Ge Yang <yangge1116@126.com>
References: <20250815101858.24352-1-will@kernel.org>
 <c5bac539-fd8a-4db7-c21c-cd3e457eee91@google.com>
 <aKMrOHYbTtDhOP6O@willie-the-truck> <aKM5S4oQYmRIbT3j@willie-the-truck>
 <9e7d31b9-1eaf-4599-ce42-b80c0c4bb25d@google.com>
 <8376d8a3-cc36-ae70-0fa8-427e9ca17b9b@google.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <8376d8a3-cc36-ae70-0fa8-427e9ca17b9b@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 28.08.25 10:47, Hugh Dickins wrote:
> On Sun, 24 Aug 2025, Hugh Dickins wrote:
>> On Mon, 18 Aug 2025, Will Deacon wrote:
>>> On Mon, Aug 18, 2025 at 02:31:42PM +0100, Will Deacon wrote:
>>>> On Fri, Aug 15, 2025 at 09:14:48PM -0700, Hugh Dickins wrote:
>>>>> I think replace the folio_test_mlocked(folio) part of it by
>>>>> (folio_test_mlocked(folio) && !folio_test_unevictable(folio)).
>>>>> That should reduce the extra calls to a much more reasonable
>>>>> number, while still solving your issue.
>>>>
>>>> Alas, I fear that the folio may be unevictable by this point (which
>>>> seems to coincide with the readahead fault adding it to the LRU above)
>>>> but I can try it out.
>>>
>>> I gave this a spin but I still see failures with this change.
>>
>> Many thanks, Will, for the precisely relevant traces (in which,
>> by the way, mapcount=0 really means _mapcount=0 hence mapcount=1).
>>
>> Yes, those do indeed illustrate a case which my suggested
>> (folio_test_mlocked(folio) && !folio_test_unevictable(folio))
>> failed to cover.  Very helpful to have an example of that.
>>
>> And many thanks, David, for your reminder of commit 33dfe9204f29
>> ("mm/gup: clear the LRU flag of a page before adding to LRU batch").
>>
>> Yes, I strongly agree with your suggestion that the mlock batch
>> be brought into line with its change to the ordinary LRU batches,
>> and agree that doing so will be likely to solve Will's issue
>> (and similar cases elsewhere, without needing to modify them).
>>
>> Now I just have to cool my head and get back down into those
>> mlock batches.  I am fearful that making a change there to suit
>> this case will turn out later to break another case (and I just
>> won't have time to redevelop as thorough a grasp of the races as
>> I had back then).  But if we're lucky, applying that "one batch
>> at a time" rule will actually make it all more comprehensible.
>>
>> (I so wish we had spare room in struct page to keep the address
>> of that one batch entry, or the CPU to which that one batch
>> belongs: then, although that wouldn't eliminate all uses of
>> lru_add_drain_all(), it would allow us to efficiently extract
>> a target page from its LRU batch without a remote drain.)
>>
>> I have not yet begun to write such a patch, and I'm not yet sure
>> that it's even feasible: this mail sent to get the polite thank
>> yous out of my mind, to help clear it for getting down to work.
> 
> It took several days in search of the least bad compromise, but
> in the end I concluded the opposite of what we'd intended above.
> 
> There is a fundamental incompatibility between my 5.18 2fbb0c10d1e8
> ("mm/munlock: mlock_page() munlock_page() batch by pagevec")
> and Ge Yang's 6.11 33dfe9204f29
> ("mm/gup: clear the LRU flag of a page before adding to LRU batch").
> 
> It turns out that the mm/swap.c folio batches (apart from lru_add)
> are all for best-effort, doesn't matter if it's missed, operations;
> whereas mlock and munlock are more serious.  Probably mlock could
> be (not very satisfactorily) converted, but then munlock?  Because
> of failed folio_test_clear_lru()s, it would be far too likely to
> err on either side, munlocking too soon or too late.
> 
> I've concluded that one or the other has to go.  If we're having
> a beauty contest, there's no doubt that 33dfe9204f29 is much nicer
> than 2fbb0c10d1e8 (which is itself far from perfect).  But functionally,
> I'm afraid that removing the mlock/munlock batching will show up as a
> perceptible regression in realistic workloadsg; and on consideration,
> I've found no real justification for the LRU flag clearing change.

Just to understand what you are saying: are you saying that we will go 
back to having a folio being part of multiple LRU caches? :/ If so, I 
really rally hope that we can find another way and not go back to that 
old handling.

-- 
Cheers

David / dhildenb


