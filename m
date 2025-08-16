Return-Path: <linux-kernel+bounces-771810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8811BB28BC6
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 10:16:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 604D31659F1
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 08:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F6C22010EE;
	Sat, 16 Aug 2025 08:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bjrC1gPV"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F5554673
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 08:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755332168; cv=none; b=E0joP8UlAjx55+8c7FrJZ/XqirG2tAR3ktNx6/5jrYF8qygNHfAMZMvACD7i8WCYBRcxcVUO9igAzphKHeg+fST0EDiWfPWM3Z7plknKtRc9sNH5B4x0Nhtjd1b3LVL2xYiS92J5ia9jzTMkWs4vZESjUUAtQTAth3qW6ZXydZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755332168; c=relaxed/simple;
	bh=/5Yd7LteZK9ygBBMa5bwCKlmbRlKsf1aUubz/9JoKZQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MQBHpm5LTFHc/JJs/pCubAGw88kYf2I9eOp5EMFs6lqGUzgfyENfJRyHOSpgo4llWmMN8+dBBjm0URRZw3uIkrk1+h7nk7sJ0Nke/nYMCvF0XY7pVQnY6wOQ6F6L9Mm65VSPVDQoTrjfDkTIm8XPXR4GnXbc+zGFnp5VRy04V74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bjrC1gPV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755332165;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ixPgA/yl6vc1N1EOYUywRtyrJmPMeh0Q/AJGU5hM31I=;
	b=bjrC1gPVDSwmwQpMCqliTpsx0zzcMa/ElITQhytxjNpTMRPUtqZfbxqTloBQgHKTDJHSig
	e32n+FeDb0E6RNd62/cj9LkUSsZxsunPj1NCF9vIfFQZQzUfE+I3gdfdfDHnwOzZea2i/o
	iq9mdjNCLdbyGLSNYNAZ7h3gU/4+tgM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-yl1s_Vw4P_iIRnssCWCyyA-1; Sat, 16 Aug 2025 04:16:03 -0400
X-MC-Unique: yl1s_Vw4P_iIRnssCWCyyA-1
X-Mimecast-MFC-AGG-ID: yl1s_Vw4P_iIRnssCWCyyA_1755332162
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-45a1b0ccb6cso10800805e9.3
        for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 01:16:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755332162; x=1755936962;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ixPgA/yl6vc1N1EOYUywRtyrJmPMeh0Q/AJGU5hM31I=;
        b=Oh2gZqJaP7DU/c9+scc49TogDF8IM3z+wUdLP0Jlj+QJHNn0uUkL/l4w+xl36HwTE8
         exPjySE3rYXwByT8mlJnzPCpBLEAfP4GLhUcOY/EbhH0pNnS1cjIx+WFVbIcsZHOqrnE
         ljGXAOvK1icHJcLsiUbVKPz3I7TdGeWAPv5ESo1qXqU4oX4HfUgAAO15cMMc5m+t0Hrd
         9uZl2DbY2oK+/SwSnYgFE2csf7jgUxevn8nA94d56Y8XDRKj79MmakKwKzsQ0eOqDE8a
         uoywuUCZLW8e8HNSMbOkEv0EI2N+W7G2iEbDrjmfrnmOm66xd3jtFuz2AXguu8wn71tW
         L4vQ==
X-Forwarded-Encrypted: i=1; AJvYcCWSMmWjAqL6taqNi24oqoBOUsJhE9ZtTuIuaeaIX2oQvHRsT0sSokrvYoqzptjtQx7DGLiDnkSGwJOfZQM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyR3CgAqZj1iCfbdLFLIqxgdZfz33GldOATQKDvhviA85n5d1WQ
	9qtkQeKHHZvUDLVWI7u+4MlXmo0IwdDeICZ9MyvHHBSDcyGWSkyRZX6Raxc/2ihLAhHZ5mN1fd9
	zKuBa7LVmRuBb/U/tjGINq4Q2v9tSpb+Ate13DKoutjJZq5ypY9hyHQXYvs0CDMK/3g==
X-Gm-Gg: ASbGnct4bZ9vj8uquy1m8bi2ARzvLIYW/hH/zpc3yFLwJGJLxbry4IazeBHcRJweDhz
	DhNUyRlz2o3H7Tp5qlBfiM7s4c04FBVVkvdGWHxQ9obsWV3ySk6pcRs1TD1RI9XJNoz7FrtWTes
	FAcX9a4UkbflmDNvMGVWcy1aSbYpyyngvJEFwZDkHjzgCC+krk7DlzURXGeX09SEt20S31D2HI1
	lTlmBCNvcA7TDYlXAFty01ZMORMcDaBw0rb5hEGodm9Le92FIowxuj3geZsjZ6CfRcet3YzkH/l
	vtGrH53B4T/pVjkp6uiqpdZaTZJzs2sYemB8QDBa8rr9nkQGstHcDfYGzcTIKyUS0+fRUEUdqya
	N1Jd0ZCKcBVAuvZNYCTXLPMRU0xOf9IKZRbCGHMaWa09Gzm9DzoMHMrobty2CiK/4BMQ=
X-Received: by 2002:a05:600c:a43:b0:459:db69:56bd with SMTP id 5b1f17b1804b1-45a21839e02mr35650855e9.20.1755332162236;
        Sat, 16 Aug 2025 01:16:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFC3tYNHjWj0KMeKalzdh/MjaeikwufS6vOtijOjsl7Nwlxk/mLPaTTfDxnVXlSUFEAcUfeOA==
X-Received: by 2002:a05:600c:a43:b0:459:db69:56bd with SMTP id 5b1f17b1804b1-45a21839e02mr35650575e9.20.1755332161730;
        Sat, 16 Aug 2025 01:16:01 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f23:c700:d8ae:41bf:492a:9e4c? (p200300d82f23c700d8ae41bf492a9e4c.dip0.t-ipconnect.de. [2003:d8:2f23:c700:d8ae:41bf:492a:9e4c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a22210ab4sm47375495e9.3.2025.08.16.01.16.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Aug 2025 01:16:01 -0700 (PDT)
Message-ID: <92b16e68-0083-48aa-b281-5c235fd91bfe@redhat.com>
Date: Sat, 16 Aug 2025 10:15:59 +0200
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
 Rik van Riel <riel@surriel.com>, Vlastimil Babka <vbabka@suse.cz>
References: <20250815101858.24352-1-will@kernel.org>
 <c5bac539-fd8a-4db7-c21c-cd3e457eee91@google.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 xsFNBFXLn5EBEAC+zYvAFJxCBY9Tr1xZgcESmxVNI/0ffzE/ZQOiHJl6mGkmA1R7/uUpiCjJ
 dBrn+lhhOYjjNefFQou6478faXE6o2AhmebqT4KiQoUQFV4R7y1KMEKoSyy8hQaK1umALTdL
 QZLQMzNE74ap+GDK0wnacPQFpcG1AE9RMq3aeErY5tujekBS32jfC/7AnH7I0v1v1TbbK3Gp
 XNeiN4QroO+5qaSr0ID2sz5jtBLRb15RMre27E1ImpaIv2Jw8NJgW0k/D1RyKCwaTsgRdwuK
 Kx/Y91XuSBdz0uOyU/S8kM1+ag0wvsGlpBVxRR/xw/E8M7TEwuCZQArqqTCmkG6HGcXFT0V9
 PXFNNgV5jXMQRwU0O/ztJIQqsE5LsUomE//bLwzj9IVsaQpKDqW6TAPjcdBDPLHvriq7kGjt
 WhVhdl0qEYB8lkBEU7V2Yb+SYhmhpDrti9Fq1EsmhiHSkxJcGREoMK/63r9WLZYI3+4W2rAc
 UucZa4OT27U5ZISjNg3Ev0rxU5UH2/pT4wJCfxwocmqaRr6UYmrtZmND89X0KigoFD/XSeVv
 jwBRNjPAubK9/k5NoRrYqztM9W6sJqrH8+UWZ1Idd/DdmogJh0gNC0+N42Za9yBRURfIdKSb
 B3JfpUqcWwE7vUaYrHG1nw54pLUoPG6sAA7Mehl3nd4pZUALHwARAQABzSREYXZpZCBIaWxk
 ZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT7CwZoEEwEIAEQCGwMCF4ACGQEFCwkIBwICIgIG
 FQoJCAsCBBYCAwECHgcWIQQb2cqtc1xMOkYN/MpN3hD3AP+DWgUCaJzangUJJlgIpAAKCRBN
 3hD3AP+DWhAxD/9wcL0A+2rtaAmutaKTfxhTP0b4AAp1r/eLxjrbfbCCmh4pqzBhmSX/4z11
 opn2KqcOsueRF1t2ENLOWzQu3Roiny2HOU7DajqB4dm1BVMaXQya5ae2ghzlJN9SIoopTWlR
 0Af3hPj5E2PYvQhlcqeoehKlBo9rROJv/rjmr2x0yOM8qeTroH/ZzNlCtJ56AsE6Tvl+r7cW
 3x7/Jq5WvWeudKrhFh7/yQ7eRvHCjd9bBrZTlgAfiHmX9AnCCPRPpNGNedV9Yty2Jnxhfmbv
 Pw37LA/jef8zlCDyUh2KCU1xVEOWqg15o1RtTyGV1nXV2O/mfuQJud5vIgzBvHhypc3p6VZJ
 lEf8YmT+Ol5P7SfCs5/uGdWUYQEMqOlg6w9R4Pe8d+mk8KGvfE9/zTwGg0nRgKqlQXrWRERv
 cuEwQbridlPAoQHrFWtwpgYMXx2TaZ3sihcIPo9uU5eBs0rf4mOERY75SK+Ekayv2ucTfjxr
 Kf014py2aoRJHuvy85ee/zIyLmve5hngZTTe3Wg3TInT9UTFzTPhItam6dZ1xqdTGHZYGU0O
 otRHcwLGt470grdiob6PfVTXoHlBvkWRadMhSuG4RORCDpq89vu5QralFNIf3EysNohoFy2A
 LYg2/D53xbU/aa4DDzBb5b1Rkg/udO1gZocVQWrDh6I2K3+cCs7BTQRVy5+RARAA59fefSDR
 9nMGCb9LbMX+TFAoIQo/wgP5XPyzLYakO+94GrgfZjfhdaxPXMsl2+o8jhp/hlIzG56taNdt
 VZtPp3ih1AgbR8rHgXw1xwOpuAd5lE1qNd54ndHuADO9a9A0vPimIes78Hi1/yy+ZEEvRkHk
 /kDa6F3AtTc1m4rbbOk2fiKzzsE9YXweFjQvl9p+AMw6qd/iC4lUk9g0+FQXNdRs+o4o6Qvy
 iOQJfGQ4UcBuOy1IrkJrd8qq5jet1fcM2j4QvsW8CLDWZS1L7kZ5gT5EycMKxUWb8LuRjxzZ
 3QY1aQH2kkzn6acigU3HLtgFyV1gBNV44ehjgvJpRY2cC8VhanTx0dZ9mj1YKIky5N+C0f21
 zvntBqcxV0+3p8MrxRRcgEtDZNav+xAoT3G0W4SahAaUTWXpsZoOecwtxi74CyneQNPTDjNg
 azHmvpdBVEfj7k3p4dmJp5i0U66Onmf6mMFpArvBRSMOKU9DlAzMi4IvhiNWjKVaIE2Se9BY
 FdKVAJaZq85P2y20ZBd08ILnKcj7XKZkLU5FkoA0udEBvQ0f9QLNyyy3DZMCQWcwRuj1m73D
 sq8DEFBdZ5eEkj1dCyx+t/ga6x2rHyc8Sl86oK1tvAkwBNsfKou3v+jP/l14a7DGBvrmlYjO
 59o3t6inu6H7pt7OL6u6BQj7DoMAEQEAAcLBfAQYAQgAJgIbDBYhBBvZyq1zXEw6Rg38yk3e
 EPcA/4NaBQJonNqrBQkmWAihAAoJEE3eEPcA/4NaKtMQALAJ8PzprBEXbXcEXwDKQu+P/vts
 IfUb1UNMfMV76BicGa5NCZnJNQASDP/+bFg6O3gx5NbhHHPeaWz/VxlOmYHokHodOvtL0WCC
 8A5PEP8tOk6029Z+J+xUcMrJClNVFpzVvOpb1lCbhjwAV465Hy+NUSbbUiRxdzNQtLtgZzOV
 Zw7jxUCs4UUZLQTCuBpFgb15bBxYZ/BL9MbzxPxvfUQIPbnzQMcqtpUs21CMK2PdfCh5c4gS
 sDci6D5/ZIBw94UQWmGpM/O1ilGXde2ZzzGYl64glmccD8e87OnEgKnH3FbnJnT4iJchtSvx
 yJNi1+t0+qDti4m88+/9IuPqCKb6Stl+s2dnLtJNrjXBGJtsQG/sRpqsJz5x1/2nPJSRMsx9
 5YfqbdrJSOFXDzZ8/r82HgQEtUvlSXNaXCa95ez0UkOG7+bDm2b3s0XahBQeLVCH0mw3RAQg
 r7xDAYKIrAwfHHmMTnBQDPJwVqxJjVNr7yBic4yfzVWGCGNE4DnOW0vcIeoyhy9vnIa3w1uZ
 3iyY2Nsd7JxfKu1PRhCGwXzRw5TlfEsoRI7V9A8isUCoqE2Dzh3FvYHVeX4Us+bRL/oqareJ
 CIFqgYMyvHj7Q06kTKmauOe4Nf0l0qEkIuIzfoLJ3qr5UyXc2hLtWyT9Ir+lYlX9efqh7mOY
 qIws/H2t
In-Reply-To: <c5bac539-fd8a-4db7-c21c-cd3e457eee91@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16.08.25 06:14, Hugh Dickins wrote:
> On Fri, 15 Aug 2025, Will Deacon wrote:
> 
>> When taking a longterm GUP pin via pin_user_pages(),
>> __gup_longterm_locked() tries to migrate target folios that should not
>> be longterm pinned, for example because they reside in a CMA region or
>> movable zone. This is done by first pinning all of the target folios
>> anyway, collecting all of the longterm-unpinnable target folios into a
>> list, dropping the pins that were just taken and finally handing the
>> list off to migrate_pages() for the actual migration.
>>
>> It is critically important that no unexpected references are held on the
>> folios being migrated, otherwise the migration will fail and
>> pin_user_pages() will return -ENOMEM to its caller. Unfortunately, it is
>> relatively easy to observe migration failures when running pKVM (which
>> uses pin_user_pages() on crosvm's virtual address space to resolve
>> stage-2 page faults from the guest) on a 6.15-based Pixel 6 device and
>> this results in the VM terminating prematurely.
>>
>> In the failure case, 'crosvm' has called mlock(MLOCK_ONFAULT) on its
>> mapping of guest memory prior to the pinning. Subsequently, when
>> pin_user_pages() walks the page-table, the relevant 'pte' is not
>> present and so the faulting logic allocates a new folio, mlocks it
>> with mlock_folio() and maps it in the page-table.
>>
>> Since commit 2fbb0c10d1e8 ("mm/munlock: mlock_page() munlock_page()
>> batch by pagevec"), mlock/munlock operations on a folio (formerly page),
>> are deferred. For example, mlock_folio() takes an additional reference
>> on the target folio before placing it into a per-cpu 'folio_batch' for
>> later processing by mlock_folio_batch(), which drops the refcount once
>> the operation is complete. Processing of the batches is coupled with
>> the LRU batch logic and can be forcefully drained with
>> lru_add_drain_all() but as long as a folio remains unprocessed on the
>> batch, its refcount will be elevated.
>>
>> This deferred batching therefore interacts poorly with the pKVM pinning
>> scenario as we can find ourselves in a situation where the migration
>> code fails to migrate a folio due to the elevated refcount from the
>> pending mlock operation.
> 
> Thanks for the very full description, Will, that helped me a lot
> (I know very little of the GUP pinning end).
> 
> But one thing would help me to understand better: are the areas being
> pinned anonymous or shmem or file memory (or COWed shmem or file)?
> 
>  From "the faulting logic allocates a new folio" I first assumed
> anonymous, but later came to think "mlocks it with mlock_folio()"
> implies they are shmem or file folios (which, yes, can also be
> allocated by fault).
> 
> IIRC anonymous and COW faults would go the mlock_new_folio() way,
> where the folio goes on to the mlock folio batch without having yet
> reached LRU: those should be dealt with by the existing
> !folio_test_lru() check.

Very right. Because I don't remember easily running into that in 
wp_can_reuse_anon_folio(), where we also drain the lru if we spot a !lru 
folio.

Having to enlighten all such code to check for

	if (!folio_test_lru(folio) || folio_test_mlocked(folio))

is a bit suboptimal, but we could add a helper for that. (we might end 
up draining for actually mlocked folios though :( )


We recently changed in 33dfe9204f29 ("mm/gup: clear the LRU flag of a 
page before adding to LRU batch") that a folio can really only be once 
in an LRU batch.

So if we spot !folio_test_lru(folio) there might be at most one 
reference from LRU batches.


So naturally I wonder if we could somehow make it work that a folio is 
either on the ordinary LRU batch or on the mlock batch, but not on both. 
And that the folio LRU flag would be sufficient to check.

That would mean that we would clear the LRU flag when adding a folio to 
the mlock batch. But not sure how feasible that is (e.g., folio already 
isolated).

-- 
Cheers

David / dhildenb


