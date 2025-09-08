Return-Path: <linux-kernel+bounces-806096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93D78B491D9
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 16:40:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13D0E167A24
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 14:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F21D730EF94;
	Mon,  8 Sep 2025 14:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C9ikHv1F"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16EFE30EF63
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 14:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757342185; cv=none; b=o68rXZ3+dURSAmYlwVx+klTeFpDR96gbAKzwziSHqr2o1KOYQTR3EQkMTuXuQr5zxQA9SEQUH95UWkJs32MqYi7SNbcawkzm9H6DIp2CsrH45nMjmNKQmpAXqGOlN54Fspux4mGrZNTBM8H2jAZ4C8lf8bxqmbxSfwm4BSTy6Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757342185; c=relaxed/simple;
	bh=FoWjCSXPqmUw4tXtyFyHHdkvzWrcngHUe9sCWzpWVCw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PVUcMX3Ce0DYuBS+f+SnCkNh8WrMqCZCv8gHfiaelJvzpctq+s8AF9RDgxuILK2XyxYd6kgYCDicji9wiHKu6WQwzIuANWuiN1cy5UZ6dI8Oz52rJy/A11Av7TPzf5u9LtZzNpyjom0FkPQMU9KVVaaHvb6O8zMybKCMj+Qg1ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C9ikHv1F; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757342177;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=lrYPeuNTiOD7YUu2tmRr54ytzGFvKCHl5sfVYrawVLU=;
	b=C9ikHv1FTdiZKlfOnAc3xLlcOqS0KgbNr29vTR6A2UYApXfueAI92e9vxsEGhvIiXAj/Q5
	K76CSRiSEn01LWyMWW9xq6xkuc5U3hI6XMeXhCCuQw+QS7BZKj2K+b56XHJsVgXFMPJ402
	Nx2Islly4jizTcfuDU1Xq/UkFxKJiyg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-179-4Pp2oB4BM3OCvTJFgsGXIA-1; Mon, 08 Sep 2025 10:35:42 -0400
X-MC-Unique: 4Pp2oB4BM3OCvTJFgsGXIA-1
X-Mimecast-MFC-AGG-ID: 4Pp2oB4BM3OCvTJFgsGXIA_1757342121
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3e5190bcba1so2238521f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 07:35:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757342120; x=1757946920;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lrYPeuNTiOD7YUu2tmRr54ytzGFvKCHl5sfVYrawVLU=;
        b=mhfOE5ehZAagrq6dA9DT18gU58UGWSqtLYBYweRQqjW+sTg7rh/X2xmrwef5Sbz0L9
         7MiC0kGET8KSq1BrKul8o/zyHICXeVoD56EJalV3NxqQtafrJP36ioAn+7//o7cB9NYf
         qWtfvbdc+JMBaxzBnJVAJ5v5xMi8ZVvCpmPFBgS6XEHxCEG7qJrzVIc9rC8KE38siWU7
         3GhidCvBcNK8wlRhMePgeYUSQvEk7RGMxkP73m34yZyAnV1gLxG+c0oUYJpWy9nbbuwJ
         +ALoJ2pGaQxKVoZQCbDsgzRysFY4NMUX0EBRU0KsXTm7K8vTGHtWkcgMkYR2YXNeIExk
         jB/Q==
X-Forwarded-Encrypted: i=1; AJvYcCX53250b9LmzW9MQQd0lDw/Q/3UBfdkehmNTMH70PQfjEjWf+ljtSIBU4I/Qi6A3ayFWEqlZDG2X2mroZI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzA00AbJli0U6UaTueH9NHXuc+WZ2glE4XR1c5mgVm7ChrJZ0Fi
	2dDNmUkz6g2lc68b+2HcODJo1noMVq4+Ovb0un0SEQI6frbHVJYCgChMJPbvAE1v3yK/pEYlj6p
	Gsq7b3ahvg3TxMuUaUmEoliTYW2LF7gDKtQ4kmBxaiUL5dKGoKhi/LIvxp3d8YXE9Vw==
X-Gm-Gg: ASbGnctX9EkWTmJYwN1aKsAnFZ5v4TETjGYb7xNchnmxxJg2UDQgVLnqNxMUUTmtjUy
	IdjKz5+BriJtMYsAmjopxjbnxCCBpp3iLnAW5eEg7svV8/PLe1CnTqpv2+j0wCKyA2CdSCIxvgk
	4Y+eM3DDN/wpjDFzkpokizrhn2rzTr67PpRoC0Cx5um3h0b4lduOlE6CQowB/nwD8yMwEF+ZZqo
	DlD3t9QV1ObwpdJTVPj8HpBn+nD9WetbNCZLo8//2U2fs3ioWxj4LJiNQ3a9gD+UnUtOGJa8tst
	aXO4S/QVE0pAUtzwpcWABUP6x+5IeAZuoYmTJikSJC+WfhNCx0HuZaM0lyYOiLWlAqARe82QIeE
	jud5ZZtphZl99UpP67v+fUt1eNhr3+wanSf4O/H6dRmbCagHPtiiDI6C6e+Lsmrfb
X-Received: by 2002:a05:6000:2489:b0:3e5:2082:8941 with SMTP id ffacd0b85a97d-3e642f9050amr6551060f8f.23.1757342119757;
        Mon, 08 Sep 2025 07:35:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEZLff5juSqm9neyAsOLAPZdqcSj6VvngesFbghyJRBNktZZTQa0GV4i8Hiyffrg0PBXtPEMA==
X-Received: by 2002:a05:6000:2489:b0:3e5:2082:8941 with SMTP id ffacd0b85a97d-3e642f9050amr6551014f8f.23.1757342119247;
        Mon, 08 Sep 2025 07:35:19 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f25:700:d846:15f3:6ca0:8029? (p200300d82f250700d84615f36ca08029.dip0.t-ipconnect.de. [2003:d8:2f25:700:d846:15f3:6ca0:8029])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e18537589dsm16164452f8f.54.2025.09.08.07.35.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Sep 2025 07:35:18 -0700 (PDT)
Message-ID: <3f76748b-8f99-4e63-ba39-adadc2f58838@redhat.com>
Date: Mon, 8 Sep 2025 16:35:16 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/7] mm: folio_may_be_cached() unless folio_test_large()
To: Hugh Dickins <hughd@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Will Deacon <will@kernel.org>,
 Shivank Garg <shivankg@amd.com>, Matthew Wilcox <willy@infradead.org>,
 Christoph Hellwig <hch@infradead.org>, Keir Fraser <keirf@google.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>,
 Frederick Mayle <fmayle@google.com>, Peter Xu <peterx@redhat.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, Vlastimil Babka <vbabka@suse.cz>,
 Alexander Krabler <Alexander.Krabler@kuka.com>, Ge Yang
 <yangge1116@126.com>, Li Zhe <lizhe.67@bytedance.com>,
 Chris Li <chrisl@kernel.org>, Yu Zhao <yuzhao@google.com>,
 Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>,
 Wei Xu <weixugc@google.com>, Konstantin Khlebnikov <koct9i@gmail.com>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <a28b44f7-cdb4-8b81-4982-758ae774fbf7@google.com>
 <861c061c-51cd-b940-49df-9f55e1fee2c8@google.com>
 <7fe2380f-a83e-4a9e-8c5e-8459c9af0d5f@redhat.com>
 <7113d289-fb8e-4589-7eb5-1f7139965ade@google.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <7113d289-fb8e-4589-7eb5-1f7139965ade@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08.09.25 13:19, Hugh Dickins wrote:
> On Mon, 1 Sep 2025, David Hildenbrand wrote:
>> On 31.08.25 11:16, Hugh Dickins wrote:
>>> mm/swap.c and mm/mlock.c agree to drain any per-CPU batch as soon as
>>> a large folio is added: so collect_longterm_unpinnable_folios() just
>>> wastes effort when calling lru_add_drain_all() on a large folio.
>>>
>>> But although there is good reason not to batch up PMD-sized folios,
>>> we might well benefit from batching a small number of low-order mTHPs
>>> (though unclear how that "small number" limitation will be implemented).
>>>
>>> So ask if folio_may_be_cached() rather than !folio_test_large(), to
>>> insulate those particular checks from future change.  Name preferred
>>> to "folio_is_batchable" because large folios can well be put on a batch:
>>> it's just the per-CPU LRU caches, drained much later, which need care.
>>>
>>> Marked for stable, to counter the increase in lru_add_drain_all()s
>>> from "mm/gup: check ref_count instead of lru before migration".
>>>
>>> Suggested-by: David Hildenbrand <david@redhat.com>
>>> Signed-off-by: Hugh Dickins <hughd@google.com>
>>> Cc: <stable@vger.kernel.org>
>>> ---
>>>    include/linux/swap.h | 10 ++++++++++
>>>    mm/gup.c             |  5 +++--
>>>    mm/mlock.c           |  6 +++---
>>>    mm/swap.c            |  2 +-
>>>    4 files changed, 17 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/include/linux/swap.h b/include/linux/swap.h
>>> index 2fe6ed2cc3fd..b49a61c32238 100644
>>> --- a/include/linux/swap.h
>>> +++ b/include/linux/swap.h
>>> @@ -385,6 +385,16 @@ void folio_add_lru_vma(struct folio *, struct
>>> vm_area_struct *);
>>>    void mark_page_accessed(struct page *);
>>>    void folio_mark_accessed(struct folio *);
>>>    
>>
>> Two smaller things:
>>
>> (1) We have other "folio_maybe_*" functions, so this one should likely
>>      better start with that as well.
>>
>> (2) With things like fscache in mind, the function can be a bit
>>      misleading.
>>
>> So I wonder if (a) we should just add kerneldoc to document it clearly (lru
>> cache, mlock cache?) and (b) maybe call it folio_may_be_lru_cached(). Not sure
>> if we can find a better abstraction for these two caches.
>>
>> Thinking again, "maybe_cached" might be a bit misleading because it implements
>> a very very very bad heuristic for small folios.
>>
>> Maybe it's more like "supports being cached".
>>
>> folio_lru_caching_supported()
> 
> folio_may_be_cached() -> folio_may_be_lru_cached(), yes, that's
> very much better, thanks.
> 
> (Settimg aside that I've never perceived those pagevecs/batches as a
> "cache"; but lru_cache_disable() gave us that terminology, and we've
> gone with the flow ever since.  lru_add_drain() would be better named
> lru_cache_drain() now, I've always got hung up on "adding a drain".)

Yeah, the terminology is not that intuitive :)

Not sure if using "batched" instead of "cached" might be clearer long-term?

> 
> "may be" rather than "maybe" was intentional: perhaps too subtle,
> but to a native speaker it neatly expresses both the "we can do this"
> and "might this have been done" cases.

I would wish we could find something that also non-native speakers can 
immediately understand ;)

"may_get_lru_cached" / "may_get_lru_batched"?

/me could not even phrase it in German properly

> 
> kernel-doc?  I don't think so, this is very much an mm-internal
> matter, and I don't care for the way kernel-doc forces us towards
> boilerplate ("@folio: The folio.") rather than helpful comment.

So a comment that this is an internal helper might be nice. Or we just 
move it straight to mm/internal.h ?

-- 
Cheers

David / dhildenb


