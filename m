Return-Path: <linux-kernel+bounces-773074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0F3CB29B20
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 09:47:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CC8617D3BD
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 07:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDC52287247;
	Mon, 18 Aug 2025 07:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GOQGfgl4"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3CDE28688D
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 07:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755503227; cv=none; b=iY6K+pfOd9R57DludCYDEniJUT9P9QyMwwO2sy3kVoisgT4SSc74n1yNS8fS9MPCwPVIjC4g8JTZ1pByYxV8TuF4P4qMpdTL8Q0qSuuFCG2GzHAvzSXQvLK8w6587pziDTlFyB7Ht7kNGk6ikZC1UwUD9aViRezHIPcNaVJ+y78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755503227; c=relaxed/simple;
	bh=5CN+l4NbZcQe0PhQ6yLSAnNFxIlbDcpts1lRALIZOYQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ImRblDjXgFSkMVnc4LLb31UB9iUdrKtCUf8jpb6/zA8d3DztuCihyfhOPfFt8LvsFXYY32elA0GUaq8jBXPcAfpBcAiTHYehEIINAMMZyWFNny/g2D0KfyUjzPTXXrVA6ebvSZrhUfN4W82gqwr1e1CYIKXmxyNKJ7nhFwJruIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GOQGfgl4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755503224;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ANc6RhPEo50rD5jXj4835QWtun/c5zMhU0XzbsSt4/4=;
	b=GOQGfgl4qpkmabc2V+33TnSYZnLBKu+Q46+gMr4T2ILAh6whTu033t3sTDz4Qvxcq3w85o
	54pr4RxyXOp9alFtclQ0ikB2NfsIbdS+WVa+Xp+4rLI2+AdNN4LeXcJRi9RGWYL0TG0oqO
	LsOl8Z5cDOr8UDoYVYJFP7H16OYxoTE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-260-8T4SWTmBNwK4O1DHjslHng-1; Mon, 18 Aug 2025 03:47:02 -0400
X-MC-Unique: 8T4SWTmBNwK4O1DHjslHng-1
X-Mimecast-MFC-AGG-ID: 8T4SWTmBNwK4O1DHjslHng_1755503222
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-45a1b0cc989so19997955e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 00:47:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755503221; x=1756108021;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ANc6RhPEo50rD5jXj4835QWtun/c5zMhU0XzbsSt4/4=;
        b=seJvhHCqwXvJSnQ4Me26Kwi2jbb+wkZYY49uJgFBd1kOlfcS5+xNS5FxF/dxsNHxjm
         +75qj6zW57ZlNoYEShDFP+SiMFpQqTG+ODt9k7Zv/U7oqbOTDB8EeTHmgJQ2ZZHhAURy
         /PMEIuLZMmPELqQGrvhZ6s8O5+47SkF8xym1IGNFohAEzf6tY2WCO32nJdjAa9Z3w4wu
         EpzHPW+guMb1aH4313mp8YjgCkgDnXV1tPq1uLayAAF6tUOzpt7rKYc00cHCtEdkt86V
         +NZHJq/G3Q/OKVFhBoxCLT/Vzp3htR37Dlzj2CUiPRS/QqjRz/MuPELHx5gwp6pOGq2H
         9GWw==
X-Forwarded-Encrypted: i=1; AJvYcCVexQCY4sHxKdYTOpglezh6FJfiKBnu3QPbpPkAgDDyZPMBqus5hPUAZGoRZwpFG/ZxXzlvT3nNTEo8UXI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKu4NVZ5VInPUgXzRQcW7XV0CtplsizXkM288RVnPJfjOrEr5w
	CvhT8Adsey7Lr7RyPU1FOnFUnSmE5jafjQlTQOYID+OsCHm6w9PLXGiqMGxyi8umO7d6DmOZW6I
	vm7Ngy/7J723dJQY75FdVLAG6Z+IhcXpRFUCJgT4TszKvomv7FFx7BDPHQd14WMVh/CdbnfZTgA
	==
X-Gm-Gg: ASbGncseSiXfoszXT/dLEmvf9bDTO7gpriLpIV6tV/FQv0UuR68MyD2KHiGF6ZvA2Y3
	FIzviUQ1fZepptL5fmqG7MdQiCmjGa61FStzfFBiLmfcA72tzxz7JlUGgU+3DXwe16SqHt1Pr6N
	1YnhoOCVHDAo/z6GZtag0cib3tDOLtr0lls3w5PniWTKsE+4O8JnE8viorrmsqblJ4C2LhJV8zU
	67gAhCfsFy1GXLmbL0cOD7NuDdvQN+233zqx5q9BKDi3G2hZ9B9yXtGwoJ/LbC1eaQJazZcpJ8O
	i12yCNmy3W3WvzyU8Nytcz2sPzwjlUeLMzwRG8siZXZfwYB8wWUfKgF3JlQEcIjpCqbTweMtTXt
	ZAr64JQCIA4mBF8W5xO1DfWUya0cPaY08aI29gOUIBBXfF0Pi4r8r4hYCJXc5Xmv1
X-Received: by 2002:a05:600c:19d2:b0:458:bf0a:6061 with SMTP id 5b1f17b1804b1-45a2185d9edmr93404425e9.24.1755503221610;
        Mon, 18 Aug 2025 00:47:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEKPm6IowLUkn7DYPzwgOTcOq2lC8kbIh5Hz5Bf3s8GHVwBYUdG5D9jiFOJIouRSYR7/+vYCA==
X-Received: by 2002:a05:600c:19d2:b0:458:bf0a:6061 with SMTP id 5b1f17b1804b1-45a2185d9edmr93404205e9.24.1755503221196;
        Mon, 18 Aug 2025 00:47:01 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f22:600:53c7:df43:7dc3:ae39? (p200300d82f22060053c7df437dc3ae39.dip0.t-ipconnect.de. [2003:d8:2f22:600:53c7:df43:7dc3:ae39])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a1c6d89b9sm168546025e9.12.2025.08.18.00.47.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Aug 2025 00:47:00 -0700 (PDT)
Message-ID: <fc444f71-849c-48b1-8a1a-9bea6410ca8e@redhat.com>
Date: Mon, 18 Aug 2025 09:46:59 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][v2] mm/hugetlb: early exit from
 hugetlb_pages_alloc_boot() when max_huge_pages=0
To: Andrew Morton <akpm@linux-foundation.org>, jane.chu@oracle.com
Cc: lirongqing <lirongqing@baidu.com>, muchun.song@linux.dev,
 osalvador@suse.de, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20250814102333.4428-1-lirongqing@baidu.com>
 <08cc4405-948a-446e-b198-5745c32f9ee1@oracle.com>
 <20250817195945.a845d2f5c045e4f60b07469f@linux-foundation.org>
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
In-Reply-To: <20250817195945.a845d2f5c045e4f60b07469f@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18.08.25 04:59, Andrew Morton wrote:
> On Sun, 17 Aug 2025 19:21:54 -0700 jane.chu@oracle.com wrote:
> 
>>
>> On 8/14/2025 3:23 AM, lirongqing wrote:
>>> From: Li RongQing <lirongqing@baidu.com>
>>>
>>> Optimize hugetlb_pages_alloc_boot() to return immediately when
>>> max_huge_pages is 0, avoiding unnecessary CPU cycles and the below
>>> log message when hugepages aren't configured in the kernel command
>>> line.
>>> [    3.702280] HugeTLB: allocation took 0ms with hugepage_allocation_threads=32
>>>
>>> Signed-off-by: Li RongQing <lirongqing@baidu.com>
>>> ---
>>> diff with v1: adding the reduced log messages in commit header
>>>
>>>    mm/hugetlb.c | 3 +++
>>>    1 file changed, 3 insertions(+)
>>>
>>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>>> index 753f99b..514fab5 100644
>>> --- a/mm/hugetlb.c
>>> +++ b/mm/hugetlb.c
>>> @@ -3654,6 +3654,9 @@ static void __init hugetlb_hstate_alloc_pages(struct hstate *h)
>>>    		return;
>>>    	}
>>>    
>>> +	if (!h->max_huge_pages)
>>> +		return;
>>> +
>>>    	/* do node specific alloc */
>>>    	if (hugetlb_hstate_alloc_pages_specific_nodes(h))
>>>    		return;
>>
>> Looks good.  Could you add stable: ?

Can you elaborate why you think this is stable material?

> 
> Sure, I did that.

I don't think this is stable material, but for the change itself

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers

David / dhildenb


