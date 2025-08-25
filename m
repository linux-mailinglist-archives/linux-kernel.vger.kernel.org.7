Return-Path: <linux-kernel+bounces-785153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C35CB346AE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 18:05:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65FB91893EB2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 16:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF22A29ACDB;
	Mon, 25 Aug 2025 16:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WUVd58tn"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5220123BD04
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 16:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756137886; cv=none; b=i/JWYXM+BqOGTu0NaynROR/bxj83MBBRjpnVRWjQAIp0zcyhXqXMnKVjlnN879y0eFGz1hmzakbn9/CZAAF4ACBQ26OskL1uIgRSBRkDcKgFxS1M2c0krjej2X0ZJ5TGCSJvmhOQJQPUUCove7PDGawxm5i1gvKwgTQFJ3HOSMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756137886; c=relaxed/simple;
	bh=JEewk6WChs3o5tXP+OZgBaKAuSuVZzT260KoHVExx3M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Apih9FWr/1JSBi87AntnRsgldxkpLVH41Tb9ojgporc4C85eqDcL7b752/eSW6i72+1tdZh390xLG3OMXmuTUsxnn17uVJOfU59qERa8HTCWJrh1DfbJnMJveTY9OVcl/aiU8Zi9Krah0Sk4lTMNWZNxrkt0pgD0EClUfrXnVYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WUVd58tn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756137884;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=6MyZ3OtNfCvOIDwHkcmUtPUBmP76mzb4s7J5R7w3h4k=;
	b=WUVd58tnD0eGzvsmBfBLTmz/cvh7vLjyryddY5p3wDCelFFaL5PBAmvTWgMZ1MM5COEtoY
	n05cohD/DyXC+0K6d1aaPoTGRGXzGavbFaPdNvfoeyRQrQ4FMR2HRxkZaXMWxMfn8jg70a
	AEve20k6tCiQeggHGLUzYVggKl0bekE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-209-aOy0MNggM1qb7PlakNLMVQ-1; Mon, 25 Aug 2025 12:04:43 -0400
X-MC-Unique: aOy0MNggM1qb7PlakNLMVQ-1
X-Mimecast-MFC-AGG-ID: aOy0MNggM1qb7PlakNLMVQ_1756137882
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3cabe21a5a5so145385f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 09:04:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756137882; x=1756742682;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6MyZ3OtNfCvOIDwHkcmUtPUBmP76mzb4s7J5R7w3h4k=;
        b=qSwQfkvFZSIRldkYexGBpl+g1BpmC2xeUcKaJ0Swe6OC6uURV81VqqOpuR1spFaKoq
         6/uwptzePXXB8fgkAZMUwTryVaWcGt2SEqDOn5QSdU6GC35veUymz3vf7+WaEW+5zRlF
         KXufXzh9/tatF4FJsLhU7hh2wySdYfCz+J9RVsKNC1sI0LckXdvZfTOzOUqeuMjopIgA
         kafKp8uFZc6e8TuKj3FS0Z8mmHyXjzS9l14LtfM6XLPRW4eriEzsnNP4h6iUfjb0/Kg0
         YHMpcM8ZIzTQKmJuXhkxupsGHsW6sb5vrET6KsEmTtDGOGFv5XjvtnKa+Eh6keUYMZ2Q
         Nfew==
X-Forwarded-Encrypted: i=1; AJvYcCXHsodnerF8CrrfOODm3QGhR7FgA/P9r3Iv2PMaKhvU7IShrDJsKyXxfcY3tnkSAkjUoF06jIj7MnMpR+o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTXia90VezS3cy7jfcz43Md5PK5/UMM/yoQu2mRUcowl2zjGuK
	GvYKDrIMYPOHAkvWxFWfnQL6YEhm/H7yWslqq1MDlSYGQa6eyZ+2+mlJckwEOj2336aQdzok+zp
	zVtQMf9HEFQ8rT+MLAFBzkGHaFdeZEHhE8BdyUy6x6gvT+BQnhkm0f1KBcKaJddHecg==
X-Gm-Gg: ASbGncv+S8vpKSX1CLyEyfqNPS1x1U/x8rI9PItaJAV6EwLB2YWygW0nIUiD6bob51U
	Pz0K8uVoaoIRJ076q1aQt/0ppOoXXx5NF20vQHXxh+x+6pDeGds140xRJBDDY0EzjnvuFryLzgE
	qBJLaJPXdYh25CpOr1rizeoXIskFLICe1lxyQoiRqcAjiM1a5cHzP0D5JFvEQzXSPK1jsyRJjwd
	tkbduE4mk1VZyiI4RuYXHxhPaXKHTMu+CE0XBUDXYsUOtcuPCdfspUlOHmP6VzV9xMuJ182xaAE
	A6L3T3WrxFrtkthTuyj9TlgR34vlESC1kki+7srM32QQz3Sk/S3LT/m7tBmP8BeduQN/MoF7sva
	it+fRpKFu5JGETjdYPUa2tLplXbfszuSjIhFJHxGW7ReiL2gO8uOdgQ9wkX24/y03yrI=
X-Received: by 2002:a05:6000:4021:b0:3b7:9d87:9808 with SMTP id ffacd0b85a97d-3cb04248189mr84056f8f.15.1756137881634;
        Mon, 25 Aug 2025 09:04:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGP2kHBp04DrmSVsxC1Pmyfq33GFQ537iiA7ViWhutMa83yN8mVo2ShcNNYVc3OSQ+D26O32Q==
X-Received: by 2002:a05:6000:4021:b0:3b7:9d87:9808 with SMTP id ffacd0b85a97d-3cb04248189mr84016f8f.15.1756137881091;
        Mon, 25 Aug 2025 09:04:41 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f4f:1300:42f1:98e5:ddf8:3a76? (p200300d82f4f130042f198e5ddf83a76.dip0.t-ipconnect.de. [2003:d8:2f4f:1300:42f1:98e5:ddf8:3a76])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b60ab957bsm42578115e9.12.2025.08.25.09.04.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Aug 2025 09:04:40 -0700 (PDT)
Message-ID: <4193fe50-dddb-495a-bc8f-e86c5e98fb1a@redhat.com>
Date: Mon, 25 Aug 2025 18:04:39 +0200
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
In-Reply-To: <9e7d31b9-1eaf-4599-ce42-b80c0c4bb25d@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 25.08.25 03:25, Hugh Dickins wrote:
> On Mon, 18 Aug 2025, Will Deacon wrote:
>> On Mon, Aug 18, 2025 at 02:31:42PM +0100, Will Deacon wrote:
>>> On Fri, Aug 15, 2025 at 09:14:48PM -0700, Hugh Dickins wrote:
>>>> I think replace the folio_test_mlocked(folio) part of it by
>>>> (folio_test_mlocked(folio) && !folio_test_unevictable(folio)).
>>>> That should reduce the extra calls to a much more reasonable
>>>> number, while still solving your issue.
>>>
>>> Alas, I fear that the folio may be unevictable by this point (which
>>> seems to coincide with the readahead fault adding it to the LRU above)
>>> but I can try it out.
>>
>> I gave this a spin but I still see failures with this change.
> 
> Many thanks, Will, for the precisely relevant traces (in which,
> by the way, mapcount=0 really means _mapcount=0 hence mapcount=1).
> 
> Yes, those do indeed illustrate a case which my suggested
> (folio_test_mlocked(folio) && !folio_test_unevictable(folio))
> failed to cover.  Very helpful to have an example of that.
> 
> And many thanks, David, for your reminder of commit 33dfe9204f29
> ("mm/gup: clear the LRU flag of a page before adding to LRU batch").
> 
> Yes, I strongly agree with your suggestion that the mlock batch
> be brought into line with its change to the ordinary LRU batches,
> and agree that doing so will be likely to solve Will's issue
> (and similar cases elsewhere, without needing to modify them).
> 
> Now I just have to cool my head and get back down into those
> mlock batches.  I am fearful that making a change there to suit
> this case will turn out later to break another case (and I just
> won't have time to redevelop as thorough a grasp of the races as
> I had back then).  But if we're lucky, applying that "one batch
> at a time" rule will actually make it all more comprehensible.
> 
> (I so wish we had spare room in struct page to keep the address
> of that one batch entry, or the CPU to which that one batch
> belongs: then, although that wouldn't eliminate all uses of
> lru_add_drain_all(), it would allow us to efficiently extract
> a target page from its LRU batch without a remote drain.)

I like the idea of identifying what exactly to drain, especially
regarding remote LRU draining.

With separately allocated folios we later might have that space, but it 
could mean growing the folio size, so it depends on other factors (and 
also how to store that information).

For now, I don't think we have any space to store this ... briefly 
thought about using folio->lru for that purpose, but the whole reason 
for batching is to no mess with folio->lru modifications but instead to 
... defer batch them :)


-- 
Cheers

David / dhildenb


