Return-Path: <linux-kernel+bounces-852564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D9563BD954E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 14:27:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FBFB1884E96
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 12:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1D85313E03;
	Tue, 14 Oct 2025 12:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SnvBhIjl"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF8F313554
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 12:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760444837; cv=none; b=bE/XjO7VJeS0RTbhfpjeKPJ1cd5ZLVp+Z9lr2xRs9BbUNQ5jX9io9sLl8nGYzFBNzocL2l+Tq6Dr/pQ3NH9XdWsGoxb62ci+nnsRWleRkbqkuBAPpozRwGF0DLiYnMzci3yjtVE7Zif559GtCQFfVXK2fmI7KGgyc9N2/mlotkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760444837; c=relaxed/simple;
	bh=ew0SSFYMiK6EJ51t2Eg3IxNFEbQ/0SwzC+Hzxc6wfBI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NMTCyWc/aEX3JrMcHU0l2HtKvxxZdS6l+VNEeBtjHqewjWEOpKOyBjzl8T0C2AliiCafx0QJbOpiQ4dWr3uglSSzZMgEmaiIOwZFbCYE1ILii37SsSsqAhJLBlVp/8ru4vIm8zZ+t75Q9jWzeZtNNDHML7QhvZlYMD/SsSFjRnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SnvBhIjl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760444831;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=HZXFr5KfRNnRAUwcPkoZ2FdzZWPO0u88EnCDpNDOJ2w=;
	b=SnvBhIjldj/YfL8QgtI95WK+X/syIJU6tB0hk5BWlrLJQKG61MLsxUOMs2FQCS3Q6QHyw8
	i+mna/0Ookw5Hgdh32PRQS+eM5zHP/hpvMvlr/b5wryxMHrnW2vmvqH4y+9fakITnvhu9O
	ATeZezH6EfrcdmnHTQ7MEaLidrDUvCo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-92-o11X8dUhODS1Eih7HznE1w-1; Tue, 14 Oct 2025 08:27:10 -0400
X-MC-Unique: o11X8dUhODS1Eih7HznE1w-1
X-Mimecast-MFC-AGG-ID: o11X8dUhODS1Eih7HznE1w_1760444829
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-46e39567579so27096785e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 05:27:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760444829; x=1761049629;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HZXFr5KfRNnRAUwcPkoZ2FdzZWPO0u88EnCDpNDOJ2w=;
        b=ns6uROdf3jvhVX8m6DlR7oulAPzgEeZQKNCaPGPHooNUnkgU31r7sBDIvWw+fLMM+0
         LBSPgNDCZpX7orIcslpG4c/g4Rajuucx5NyabddHrnYAn3SSh3g4AMOBjXo9xrKfRYcE
         g7Rk/7uvaGb970sQIre+RdLdr0PRIl7RZibJpZHGAFthLjk1a3kqHWLWjshnwcboMH8a
         gOJTrYcRdUIOB62cDNl9hZugo1zrDTUxROKSD2VmEDwv+lpcUrsBjo8PGv/cpZ1PYfQZ
         Ojpx9SazkLnExiOkqS/ed/h7NI+wmrlSEl8KMrxsNWh368Yw7xRy1dbYVwWm6s3BAnZd
         4ZRA==
X-Forwarded-Encrypted: i=1; AJvYcCVbFdn8CSY4PAEVKRXcluPYIiQxLce2OZkQIb4cyxF4gDgHWPMYL3nwWP0ZpRPVUZxsxob1mO0Vb89XOl0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy++Rw70j54oI7Urf7DeH3HJ+sv6JdNuY1ehlB71QtRxNhSXP68
	hxCrCW1ES+o1h+1AUePWNFsRLsfH7dFUyhZg01Abp5rOOK606cKaVEx0JXn2YfC3648GfmV4FeP
	MNkV/9fYiLiJt135mG9QA2HzVgrwYrQEtqB2/95CngNpHn+5E+wxKlRvkpDS+5S4muw==
X-Gm-Gg: ASbGncuPMYP3SkU9s3yPmiZC9IOXgF1QYOUGZvh9SsKp9zYJprnoPZba/xQVpMgUbou
	vV9BUNCNmviF2y+LJiInIGb0jAQ83aepKSF8F4Xo0nvOSzAk3l67628EzK2uu2Y/q3N5WA0S9dD
	sICaxc6pZNJgJYoI2EsGPl6Nxa94BTDsQb8v3QWg19efgd7PD3bX0jt33dkX501wREnL8m3Fze0
	+CzksViXKjS8QKMqDwoQRzrMYHLYSV4rsmdXu0S1Y+9lpD49gBcPPdeCyIL3SXVFQVaKR70vprM
	QR19kqV3BlFjttlUgj3WeBWCUiWMdjWnYww0HAKCj3BUvDOUYZVoKDauozVM87lDjyQNdSUl1Q=
	=
X-Received: by 2002:a05:600c:6287:b0:46f:b42e:e365 with SMTP id 5b1f17b1804b1-46fb42ee3f5mr106213985e9.39.1760444829045;
        Tue, 14 Oct 2025 05:27:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEvJYRneb0mqhfEJogc5WjuIbEc8spmQmpHChaTcpaaF0hqmSPkzGROCrzFQ++irStZBWlARA==
X-Received: by 2002:a05:600c:6287:b0:46f:b42e:e365 with SMTP id 5b1f17b1804b1-46fb42ee3f5mr106213725e9.39.1760444828650;
        Tue, 14 Oct 2025 05:27:08 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fb48a6069sm238539115e9.20.2025.10.14.05.27.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Oct 2025 05:27:08 -0700 (PDT)
Message-ID: <cfbd4f48-69a0-4ba9-bce8-f578d9602125@redhat.com>
Date: Tue, 14 Oct 2025 14:27:07 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mm-new v3 1/3] mm/khugepaged: optimize PTE scanning with
 if-else-if-else-if chain
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Lance Yang <lance.yang@linux.dev>
Cc: akpm@linux-foundation.org, ziy@nvidia.com, baolin.wang@linux.alibaba.com,
 Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com,
 dev.jain@arm.com, baohua@kernel.org, ioworker0@gmail.com,
 richard.weiyang@gmail.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20251008043748.45554-1-lance.yang@linux.dev>
 <20251008043748.45554-2-lance.yang@linux.dev>
 <3982686f-908f-4f92-b3ae-e6f141e617ef@lucifer.local>
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
In-Reply-To: <3982686f-908f-4f92-b3ae-e6f141e617ef@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14.10.25 14:17, Lorenzo Stoakes wrote:
> On Wed, Oct 08, 2025 at 12:37:46PM +0800, Lance Yang wrote:
>> From: Lance Yang <lance.yang@linux.dev>
>>
>> As pointed out by Dev, the PTE checks for disjoint conditions in the
>> scanning loops can be optimized. is_swap_pte, (pte_none && is_zero_pfn),
>> and pte_uffd_wp are mutually exclusive.
> 
> But you're not using is_swap_pte anywhere :) This comes back to my review
> quesiotn on the series this is dependent upon.
> 
>>
>> This patch refactors the loops in both __collapse_huge_page_isolate() and
>> hpage_collapse_scan_pmd() to use a continuous if-else-if-else-if chain
>> instead of separate if blocks. While at it, the redundant pte_present()
>> check before is_zero_pfn() is also removed.
> 
> I mean see review below, I don't see why you're doing this and I am
> unconvinced by how redundant that check is.
> 
> Also this just feels like it should be part of the series where you change
> these? I'm not sure why this is separate?

I think Lance is trying to unify both scanning functions to look alike, 
such that when he refactors them out in patch #3 it looks more straight 
forward.

The missing pte_present() check in hpage_collapse_scan_pmd() is interesting

Likely there is one such check missing there?

-- 
Cheers

David / dhildenb


