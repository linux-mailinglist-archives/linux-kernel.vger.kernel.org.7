Return-Path: <linux-kernel+bounces-871211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C64BEC0CA23
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 10:24:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D8A1F4F189B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 09:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A050A2E7F39;
	Mon, 27 Oct 2025 09:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZeArEhqO"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDDEA2E7BB4
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 09:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761556937; cv=none; b=BomDZ0bVZR6Q2VzUSxugbbJAK/PhoSc5w/Nw0f69CuoEIyOLMhbuSbblo0XOvWNXHwPXFoG6kAwuwx9D5nYS8J7cwJLv3pyh7U2J0TXgIDredsMDwoThQLG+1hClRkDUrbsT0e+DIb1LIGW1UhFduOFzB1jErCZkuGD+tsdT/lI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761556937; c=relaxed/simple;
	bh=NMH9CbbvFmTV0ED5geaJqAzjDltegQCfOWjYkTn1ZPQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s/6Wct8/J80pGn9vkqfXIrP5+1V9TedBtzHmDvTK81JAYVHUl8bLNTuSD8l8YpE/2vMYGtscJ/7rmKSs79TJsM4XqYqy74WUG3U59HHLm7sShxJZM/FShE0FqPD9whu3WNoms76r7GJlCApZ0IOQDTuDJr2fJmxOWvHlcPOpRdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZeArEhqO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761556934;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=A/GXeoHonKMlzjFGTYijF05WfyyHRvFPdjwbyNeXc3Y=;
	b=ZeArEhqOB2nPgT9UQdOsrhP+1You61yRQzP5NqROTx89v6lck5+75GFDk0LIDtb7amFQs+
	B/bndFWgO5eZ6CkdyOyPB/q9QgegFXScqpIETZYzej3ZQb4g07FK7yGJI/JdWzrx+nvRaD
	q34NxUqAonKLh8PeMRSsmlIuYx54b1k=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-57-4wgFUxU4PUOfBev5H5M4TQ-1; Mon, 27 Oct 2025 05:22:13 -0400
X-MC-Unique: 4wgFUxU4PUOfBev5H5M4TQ-1
X-Mimecast-MFC-AGG-ID: 4wgFUxU4PUOfBev5H5M4TQ_1761556932
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-42855d6875fso3978639f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 02:22:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761556932; x=1762161732;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A/GXeoHonKMlzjFGTYijF05WfyyHRvFPdjwbyNeXc3Y=;
        b=NeVAfKU2M62FXfmPrjNifpUKxgnC2oyC5XWHAFWIX6iGR5hr0sK3SH62yzCDCgMXV5
         +fTKFJCi1xtHZRPysfAw6vPnQpTl+BX82jU7WylHfSNM2RTjeGQn7TO/OD+SH7GdI1mF
         WjNk7UxaHn510UaHm7iOO9e57NOMBj6wlHaXiK3ZPPyRIeZz7oK+MJNzzP2KYR3A0ArO
         R28bqqajeJaXtk+fvZ5+hZ6klLXlRu/aiD640uJHZufrTGcRqJtDtXKpfkaPC++FK8IW
         LO47DTfEHkpF5eIHqW1slsTR4hOmOYS8d91ofUtuSZDx20CabLhiyO1x3Qr3xy2ftmkg
         psVA==
X-Forwarded-Encrypted: i=1; AJvYcCV79yDmLKq9cvrh5RddJOsiGrR10xEx1IQZdhjCjZBt3dRnqYsOq50FVGD2hKkQ8OI8EEyu09D0Q6m6Y4o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCl6KqUghzT7t5DIYG6wSWkEOoWUiPfZOA27rKbbuaiQ+Og6L1
	YuE7RAm0vcXlWvuj0i20Sjy63OcTztzG++Kl0SGn5lJU/tPidgqLLeamwQqtUUxObG6WHYLX7AY
	M3R4dSEifovYFPLeoREL2JXoIDSezbaPO/QC+WTzLVn2Q9XZdoJ+H49CWAayI1w9c0w==
X-Gm-Gg: ASbGncsjf/78G7NqY5AJ6RrCJ1NrUTyKMsUhkgN64TAteYY4q3KJF4xlvlrE5/fhOnj
	5X9EBTinYgFZ1oZQX56lVqzFUT0Ed493VDBLWdyIXSnuLjExZJkaHIht5V0rjXrnLGassWl/GpU
	IKnnRFbsj8Di+E+Fm6J0lyn2qhEJkvWVnCoO3kavfFTWcBo7w+IpJUCyJIw2eL5hAcbvgr/Oa0j
	ldxqfxEuPGBblHrTJ9F6TtJlzLzBapGJ+sAGgxeVtY0mDwDqm8edN1mbEa1dau0vhhCUSLv++Za
	y4y2FNrNdkZS7oDndVP1W5VrTUWCQswb9a/3BfYsQmW5fU7dZqFOW1jpLRluCNh/sCH46mM7HiI
	QQStLWUYWIDcJ2z31Seo9e4Umss42o23A0wNTcUIOzmfcfIf1xcER7PYP4gc0UP+IszDkEbXVwh
	22jhpkwrX+LPk0kHJcjzqZcjGc54M=
X-Received: by 2002:a05:6000:4024:b0:3e9:a1cb:ea8f with SMTP id ffacd0b85a97d-42704da3924mr26721890f8f.52.1761556931768;
        Mon, 27 Oct 2025 02:22:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHDRyzbYNgapAsDQVUP/dfMOneGlFTnaQdS54xLTyrz5QcB73wRWvx5krJws1/xS1I2xHKHjw==
X-Received: by 2002:a05:6000:4024:b0:3e9:a1cb:ea8f with SMTP id ffacd0b85a97d-42704da3924mr26721844f8f.52.1761556931254;
        Mon, 27 Oct 2025 02:22:11 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f3f:4b00:ee13:8c22:5cc5:d169? (p200300d82f3f4b00ee138c225cc5d169.dip0.t-ipconnect.de. [2003:d8:2f3f:4b00:ee13:8c22:5cc5:d169])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952cb7dcsm13518433f8f.11.2025.10.27.02.22.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Oct 2025 02:22:10 -0700 (PDT)
Message-ID: <8fc01e1d-11b4-4f92-be43-ea21a06fcef1@redhat.com>
Date: Mon, 27 Oct 2025 10:22:08 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 1/2] mm/memory: Do not populate page table entries
 beyond i_size
To: Hugh Dickins <hughd@google.com>, Kiryl Shutsemau <kirill@shutemov.name>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Matthew Wilcox <willy@infradead.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Rik van Riel <riel@surriel.com>, Harry Yoo <harry.yoo@oracle.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Shakeel Butt <shakeel.butt@linux.dev>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Darrick J. Wong" <djwong@kernel.org>, Dave Chinner <david@fromorbit.com>,
 linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, Kiryl Shutsemau <kas@kernel.org>
References: <20251023093251.54146-1-kirill@shutemov.name>
 <20251023093251.54146-2-kirill@shutemov.name>
 <96102837-402d-c671-1b29-527f2b5361bf@google.com>
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
In-Reply-To: <96102837-402d-c671-1b29-527f2b5361bf@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 27.10.25 09:20, Hugh Dickins wrote:
> On Thu, 23 Oct 2025, Kiryl Shutsemau wrote:
> 
>> From: Kiryl Shutsemau <kas@kernel.org>
>>
>> Accesses within VMA, but beyond i_size rounded up to PAGE_SIZE are
>> supposed to generate SIGBUS.
>>
>> Recent changes attempted to fault in full folio where possible. They did
>> not respect i_size, which led to populating PTEs beyond i_size and
>> breaking SIGBUS semantics.
>>
>> Darrick reported generic/749 breakage because of this.
>>
>> However, the problem existed before the recent changes. With huge=always
>> tmpfs, any write to a file leads to PMD-size allocation. Following the
>> fault-in of the folio will install PMD mapping regardless of i_size.
>>
>> Fix filemap_map_pages() and finish_fault() to not install:
>>    - PTEs beyond i_size;
>>    - PMD mappings across i_size;
> 
> Sorry for coming in late as usual, and complicating matters.
> 

No problem, we CCed you on earlier versions to get your input, and we 
were speculating that shmem behavior might be intended (one way or the 
other).

>>
>> Signed-off-by: Kiryl Shutsemau <kas@kernel.org>
>> Fixes: 19773df031bc ("mm/fault: try to map the entire file folio in finish_fault()")
>> Fixes: 357b92761d94 ("mm/filemap: map entire large folio faultaround")
> 
> ACK to restoring the correct POSIX behaviour to those filesystems
> which are being given large folios beyond EOF transparently,
> without any huge= mount option to permit it.
> 
>> Fixes: 800d8c63b2e9 ("shmem: add huge pages support")
> 
> But NAK to regressing the intentional behaviour of huge=always
> on shmem/tmpfs: the page size, whenever possible, is PMD-sized.  In
> 6.18-rc huge=always is currently (thanks to Baolin) behaving correctly
> again, as it had done for nine years: I insist we do not re-break it.

Just so we are on the same page: this is not about which folio sizes we 
allocate (like what Baolin fixed) but what/how much to map.

I guess this patch here would imply the following changes

1) A file with a size that is not PMD aligned will have the last 
(unaligned part) not mapped by PMDs.

2) Once growing a file, the previously-last-part would not be mapped by 
PMDs.


Of course, we would have only mapped the last part of the file by PMDs 
if the VMA would have been large enough in the first place. I'm curious, 
is that something that is commonly done by applications with shmem files 
(map beyond eof)?

-- 
Cheers

David / dhildenb


