Return-Path: <linux-kernel+bounces-790691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B9AAB3ABCE
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 22:40:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5CF21BA36E4
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 20:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B5912C236D;
	Thu, 28 Aug 2025 20:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Uiy/CrkH"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6A2298CD7
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 20:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756413538; cv=none; b=sgbG1gHbVOGtoh5SFDOWptwcd853VNTBG4ZKQOrQLVN5X92dgYrxpXV6sUCwgngeG499FZeLHk5AudSyZRqreTixYa9P4OJuds8X+bNG/3xAJ1x8rCGUyuoIEOIpHIKWwI/9kMtMga+n3qlxiWaPssDQYvwM4tTs2HZeXbUiQMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756413538; c=relaxed/simple;
	bh=anLVQJl4AjBIEJag0sUwCnvTo8CcHix1MyVpizJDkTo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LQ7AKIbxYP1kukopRx+dDiV0mAC89hBZ0VnwUUavqbvjpAxtZ1UK0a7JSv4Pywv7AT/L4i1GOveay3pGF9APfOfc1RaGevB3V7S0YOwdtOkLClV06D6A11tyyJYqHqZHSFbY5gfJrDztb3YfLho2j9HBW9kIq9B38Ff1JOv9Q2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Uiy/CrkH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756413536;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=xwZlhU01+EV1yk20M/2DYD/S7JKHDAZ7Ux0lm8SsNeM=;
	b=Uiy/CrkHe7vOncwO95CyfFcnKLmKywnCyJocAMNWGGozlJjjYm6W9WmsVvXQW7H1rzdrNx
	EtDyZ01rnKyCaEGJxdLoPOAEUfi6KjX50DAJLsjR8x5OQQFRu84Oe7YQzdGf/ChvyQGjXr
	p+jQ8NhQjsbF094P6zOJYHdjuM/mwV0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-500-s6JytKNkPYaWzji2ALKWhQ-1; Thu, 28 Aug 2025 16:38:54 -0400
X-MC-Unique: s6JytKNkPYaWzji2ALKWhQ-1
X-Mimecast-MFC-AGG-ID: s6JytKNkPYaWzji2ALKWhQ_1756413533
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-45b74ec7cd0so8910045e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 13:38:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756413533; x=1757018333;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xwZlhU01+EV1yk20M/2DYD/S7JKHDAZ7Ux0lm8SsNeM=;
        b=Ywha7M+jwR8e7BN8E9QF0Hax2m0N5qXr89ya/UfOICpgikFeqRbv9uqz416Cblmqvp
         80n2rY8qQF7+PVb0KhIxanZlBIdY7/V9lknzpseBGZ9frlsGeW0+M0m9AH5ApVZYdfjt
         Eoc6NdQQX2njTE+mdMRShhXokqlvKzTplDbyTzlZawpp2IW6Fwkabe4WRgqcQ7QeW2uR
         8Bx9WwHwWn0RVFjqUAAKkCuHbyR2GR6oxhv8LHxGFEfAowKRBDpThLq4rEFnBzEosmAj
         A8YfGWDFMdwNY/W7NlUOFpMjZexuYwCNzpIVoveotFrJ7HQv6NU9mgi5/FVOzVLbuzWn
         Yf8A==
X-Forwarded-Encrypted: i=1; AJvYcCV7k25TB+z6VGGQ5wrI2TFVYdbVCfhuJPB+3EHFZRpYlX4NjHoAYnPeDB6CfSRPMNfWwmQ3XZRwr6DRRK4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy11teYpE5Y+uiyV60mX87TkhOBOhnRMDbC6IFUDFyIB7ul1tFv
	aXenDDgQVCMgZiScyXgq/zTM+BOC/tAEyoIPxSK2elODRWuKV8lEhmz1sIottikC/KgY9S1MJ2Q
	bKEoLAzvzfIQw8p/jYowlAVfeulcOz2v5KRIWJKh0FZ+0SHl64VklVCivnSIWlUGyof30HTL5+w
	==
X-Gm-Gg: ASbGncuUiHLvXCRwWrP6NeiOWz27Zn5xnJv9qeCtYae9c9+axWt9b59GnXpcQNOqeu8
	qVdHfn0usgrRH3JZK4fAhzavdFclRYvUE9Mf6Fx8Px/IynkE0Y6uWzk2dLKA5lAM7LxZunv+9fP
	boYKoOrci+J3SH/CEubN96EEzmKaahH2thwfs24fMEWGdjQFq3hKHT5hqU0WvX0dsDXHdgwl6yn
	b2E0C+X0Y8Pvl6FLxX9kG+g2pIagKu/DHpAyGPj5+q880U+Vc5/CY5LqnRQpLsO3Uv6surhbmcS
	bjgjIcGbGYHfuaXfmsLaddAKz8dcVRiZR+Kqu1qDcT0e7WtS/xIKQtOpx5ubWxWauI1rrrtHBXC
	ubVpByAKWF226uZzkuV6dlbthfMqDmXv/lSVvp+fp6omRSxc5roGzBxObJCyU8D/lDqs=
X-Received: by 2002:a05:600c:1caa:b0:458:bbed:a806 with SMTP id 5b1f17b1804b1-45b6503919emr91828985e9.22.1756413532902;
        Thu, 28 Aug 2025 13:38:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEIljhHhdTBn7DEps/7ORUXkYgebAkXS/5XDYdHFvBoLjnLL6phiG8TBqHSGcnisU+IkK5BMQ==
X-Received: by 2002:a05:600c:1caa:b0:458:bbed:a806 with SMTP id 5b1f17b1804b1-45b6503919emr91828905e9.22.1756413532445;
        Thu, 28 Aug 2025 13:38:52 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f28:c100:2225:10aa:f247:7b85? (p200300d82f28c100222510aaf2477b85.dip0.t-ipconnect.de. [2003:d8:2f28:c100:2225:10aa:f247:7b85])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cf276c788esm596872f8f.17.2025.08.28.13.38.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Aug 2025 13:38:51 -0700 (PDT)
Message-ID: <56819052-d3f5-4209-824d-5cfbf49ff6e9@redhat.com>
Date: Thu, 28 Aug 2025 22:38:50 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/gup: Drain batched mlock folio processing before
 attempting migration
To: Hugh Dickins <hughd@google.com>
Cc: Will Deacon <will@kernel.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Keir Fraser <keirf@google.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>,
 Frederick Mayle <fmayle@google.com>,
 Andrew Morton <akpm@linux-foundation.org>, Peter Xu <peterx@redhat.com>,
 Rik van Riel <riel@surriel.com>, Vlastimil Babka <vbabka@suse.cz>,
 Ge Yang <yangge1116@126.com>
References: <20250815101858.24352-1-will@kernel.org>
 <c5bac539-fd8a-4db7-c21c-cd3e457eee91@google.com>
 <aKMrOHYbTtDhOP6O@willie-the-truck> <aKM5S4oQYmRIbT3j@willie-the-truck>
 <9e7d31b9-1eaf-4599-ce42-b80c0c4bb25d@google.com>
 <8376d8a3-cc36-ae70-0fa8-427e9ca17b9b@google.com>
 <a0d1d889-c711-494b-a85a-33cbde4688ba@redhat.com>
 <3194a67b-194c-151d-a961-08c0d0f24d9b@google.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <3194a67b-194c-151d-a961-08c0d0f24d9b@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 28.08.25 18:12, Hugh Dickins wrote:
> On Thu, 28 Aug 2025, David Hildenbrand wrote:
>> On 28.08.25 10:47, Hugh Dickins wrote:
> ...
>>> It took several days in search of the least bad compromise, but
>>> in the end I concluded the opposite of what we'd intended above.
>>>
>>> There is a fundamental incompatibility between my 5.18 2fbb0c10d1e8
>>> ("mm/munlock: mlock_page() munlock_page() batch by pagevec")
>>> and Ge Yang's 6.11 33dfe9204f29
>>> ("mm/gup: clear the LRU flag of a page before adding to LRU batch").
>>>
>>> It turns out that the mm/swap.c folio batches (apart from lru_add)
>>> are all for best-effort, doesn't matter if it's missed, operations;
>>> whereas mlock and munlock are more serious.  Probably mlock could
>>> be (not very satisfactorily) converted, but then munlock?  Because
>>> of failed folio_test_clear_lru()s, it would be far too likely to
>>> err on either side, munlocking too soon or too late.
>>>
>>> I've concluded that one or the other has to go.  If we're having
>>> a beauty contest, there's no doubt that 33dfe9204f29 is much nicer
>>> than 2fbb0c10d1e8 (which is itself far from perfect).  But functionally,
>>> I'm afraid that removing the mlock/munlock batching will show up as a
>>> perceptible regression in realistic workloadsg; and on consideration,
>>> I've found no real justification for the LRU flag clearing change.
>>
>> Just to understand what you are saying: are you saying that we will go back to
>> having a folio being part of multiple LRU caches?
> 
> Yes.  Well, if you count the mlock/munlock batches in as "LRU caches",
> then that has been so all along.

Yes ...

> 
>> :/ If so, I really rally
>> hope that we can find another way and not go back to that old handling.
> 
> For what reason?  It sounded like a nice "invariant" to keep in mind,
> but it's a limitation, and  what purpose was it actually serving?

I liked the semantics that if !lru, there could be at most one reference 
from the LRU caches.

That is, if there are two references, you don't even have to bother with 
flushing anything.

> 
> If it's the "spare room in struct page to keep the address of that one
> batch entry ... efficiently extract ..." that I was dreaming of: that
> has to be a future thing, when perhaps memdescs will allow an extensible
> structure to be attached, and extending it for an mlocked folio (to hold
> the mlock_count instead of squeezing it into lru.prev) would not need
> mlock/munlock batching at all (I guess: far from uppermost in my mind!),
> and including a field for "efficiently extract" from LRU batch would be
> nice.
> 
> But, memdescs or not, there will always be pressure to keep the common
> struct as small as possible, so I don't know if we would actually go
> that way.
> 
> But I suspect that was not your reason at all: please illuminate.

You are very right :)

Regarding the issue at hand:

There were discussions at LSF/MM about also putting (some) large folios 
onto the LRU caches.

In that context, GUP could take multiple references on the same folio, 
and a simple folio_expected_ref_count() + 1 would no longer do the trick.

I thought about this today, and likely it could be handled by scanning 
the page array for same folios etc. A bit nasty when wanting to cover 
all corner cases (folio pages must not be consecutive in the passed 
array ) ...


Apart from that issue, I liked the idea of a "single entry in the cache" 
for other reasons: it gives clear semantics. We cannot end up in a 
scenario where someone performs OPX and later someone OPY on a folio, 
but the way the lru caches are flushed we might end up processing OPX 
after OPY -- this should be able to happen in case of local or remote 
flushes IIRC.

Anyhow, I quickly scanned your code. The folio_expected_ref_count() 
should solve the issue for now. It's quite unfortunate that any raised 
reference will make us now flush all remote LRU caches.

Maybe we just want to limit it to !folio_test_large(), because flushing 
there really doesn't give us any chance in succeeding right now? Not 
sure if it makes any difference in practice, though, we'll likely be 
flushing remote LRU caches now more frequently either way.

-- 
Cheers

David / dhildenb


