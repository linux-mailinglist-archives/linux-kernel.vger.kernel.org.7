Return-Path: <linux-kernel+bounces-813487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BDEFEB54625
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 10:57:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 738C4AA6879
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 08:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E56C4272E5E;
	Fri, 12 Sep 2025 08:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZWkxpAFm"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97EB31853
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 08:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757667452; cv=none; b=c14qnkPE3BpmQO56lqnpg6dZrnryn5sLUbCSKbp5ClpifnHa554/15YFPo/6kMJ9/4kV8Lx4zLObkJpVMmicd1fDAeCilNiTwez5upO/f23MWS938/BjiqwfeNJZp7r/N25F+A3wl4UHvFomG3R3Uo3MBQGW96rQRfoccTAEgwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757667452; c=relaxed/simple;
	bh=fpKtIlCngJqv24+1H7PvTzd73heVi2FFo2HFuJVTGlw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ptFsMZ1AaV/3ae3xiTL9MH8bfDpSH9TmZu6WrSmNAS22BzZYb83sLdvm4Bd/H6LUmai2wRzqD9ZjoC/UjmdYhjEuzXDivNLbtxEBNM238soxtD1oAX/H3FAPAqFuwViP3sMGvFneumVfTApROyiuUheg3de2m6+ft8LAXJHKUAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZWkxpAFm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757667449;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=oYE8QUsnZZBUYnfQv+SJzLEXu1JDXkSZkMxoL/oX96Y=;
	b=ZWkxpAFmCLf5nZCu6vaG3RlDvRXBWmSc9g0ZOUTN2lSF4CaKPJg4C1SId99GfT1MvoTGW6
	3HQyoujZknmeBlTsrrcnHtMOp4Dc98ZzGxFqY7R+KdJbEqWY9K/oI78zgCTw22rsiENkYe
	pL2GGDopCLz/DG5zOkBMKR5Y01wzwD8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-15-MnYay6nfP2-uFBEtuZ67PQ-1; Fri, 12 Sep 2025 04:57:27 -0400
X-MC-Unique: MnYay6nfP2-uFBEtuZ67PQ-1
X-Mimecast-MFC-AGG-ID: MnYay6nfP2-uFBEtuZ67PQ_1757667446
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-45b9a856d58so15788955e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 01:57:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757667446; x=1758272246;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oYE8QUsnZZBUYnfQv+SJzLEXu1JDXkSZkMxoL/oX96Y=;
        b=kqvI1DRLTqu1JZr1qmAqoNwT+JTgclY6pdgDn09wGo6mJS1YG/h+RmgSlDJt+4jmrb
         xFWJiAFQOssWPfrjcGa70NKo57ld3jmL0d5uiN7ztwgKHjShhUv6wgj62VERuEsvs50b
         8ogj26kmu9cnGw+5fMS6wxq/CajOWAzGsS2yVk5LtwwEMZDS0jEsnwjpwOF/1/gFLjJg
         UVgFIyIwyvB2vv7YaN/w5Jf0Nx6COOkS0TRtpVTFAEzGvFehor8QrSHZSTj8SmG4e0ea
         2ki9ME6OGvfOzrkoNZUB2l/3WJxSHaskW/hqIV9lS+kVjLZq/zNUEBLzxwf7ZDK8OWEO
         Nkuw==
X-Forwarded-Encrypted: i=1; AJvYcCXI36oi/OHE4a6mn1QABxGou43urp7zMIjyCL5mbkUSnwj5lZ5ckeEyZkVHrdahSqfiaFEvXxzWRL6nuiU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz18o2tZJlVucwLj+CHmo0csyx7M9Y6SA+AQR4SQsHO7UfioCy1
	b8z/G/Am97NX/rgyNEVtP6xO3ctMLXiZYRKCuENxJgysa2XzlwMXI8IlXe07pX2eE7MRLAPqcBL
	/s67HcztdDWz0RaE9oH/HeoGd3SaDd1szm76gYpAeQtZc2u+OYPM9IpVLew8dKnoycA==
X-Gm-Gg: ASbGnct5Dwyc1NzoL3/4y5o8Ux+xZNlFG+MU0++dp77GdwN+/Ih7E6fciS1keL1ZxCG
	GyYEdIltdqDeH0YjLmjVMIKh/bQO6iie1zKglRnlKNDLx9zTlMLJKd5noeyLNTpdofTD7QscDEt
	C/4g5fUxWng/Ud0ZLBLpJ7dUnbceMyhzc3rgheKf2laHN6zTzWsJtTOJ12E3c0bovpy+5FnDRmH
	n9PLGXxs6afbenvSj5+Nptuc+kBH0TPJwibgHSyhFjGijrzJbVhYTR7dmOBXvzVu80YFIgNxF8y
	JVlaKgMEROzxSPjE3zitx87n9urJgV0w7S/LYU0PgAfIGrZTntLB1D4tCHWBQGk6jfk4qbj7+L1
	TBZtq1/Fj0fQyuXAbFWMUL10vV+5a9quP+gYy1sKe7N54DG8GZsNN+p7pvfQ/QLawn38=
X-Received: by 2002:a05:600c:4f83:b0:458:bf0a:6061 with SMTP id 5b1f17b1804b1-45f211f87c8mr27523445e9.24.1757667446425;
        Fri, 12 Sep 2025 01:57:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHbKnkz4E7alPqaRs8JDqHCnR8JIg+ATRKJh19s0WfXd11H9UFjVPHs8lZIrKmlmJxg+ga5Pg==
X-Received: by 2002:a05:600c:4f83:b0:458:bf0a:6061 with SMTP id 5b1f17b1804b1-45f211f87c8mr27523045e9.24.1757667445965;
        Fri, 12 Sep 2025 01:57:25 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f20:da00:b70a:d502:3b51:1f2d? (p200300d82f20da00b70ad5023b511f2d.dip0.t-ipconnect.de. [2003:d8:2f20:da00:b70a:d502:3b51:1f2d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e01575fadsm57722265e9.6.2025.09.12.01.57.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 01:57:25 -0700 (PDT)
Message-ID: <65a84778-b329-457b-a834-aa823f7db29b@redhat.com>
Date: Fri, 12 Sep 2025 10:57:23 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] mm: vmscan: remove folio_test_private() check in
 pageout()
To: Baolin Wang <baolin.wang@linux.alibaba.com>, akpm@linux-foundation.org,
 hannes@cmpxchg.org
Cc: mhocko@kernel.org, zhengqi.arch@bytedance.com, shakeel.butt@linux.dev,
 lorenzo.stoakes@oracle.com, hughd@google.com, willy@infradead.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <cover.1757648598.git.baolin.wang@linux.alibaba.com>
 <b8c0fe71982aa1cafafd59d8e71064efaac16007.1757648598.git.baolin.wang@linux.alibaba.com>
 <e6fc05fa-a622-47fc-acf4-9a5be98032aa@redhat.com>
 <94cfb423-1dc5-43e1-bd1f-75b8d43fdc1a@redhat.com>
 <b6fa0add-e739-499d-9fbf-32454b5e137a@linux.alibaba.com>
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
In-Reply-To: <b6fa0add-e739-499d-9fbf-32454b5e137a@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12.09.25 10:31, Baolin Wang wrote:
> 
> 
> On 2025/9/12 16:24, David Hildenbrand wrote:
>> On 12.09.25 10:24, David Hildenbrand wrote:
>>> On 12.09.25 05:45, Baolin Wang wrote:
>>>> Currently, we no longer attempt to write back filesystem folios in
>>>> pageout(),
>>>> and only tmpfs/shmem folios and anonymous swapcache folios can be
>>>> written back.
>>>
>>> Can you point me at the code where that is fenced off?
> 
> Please see the following check in pageout():
> 
> if (!shmem_mapping(mapping) && !folio_test_anon(folio))
> 	return PAGE_ACTIVATE;
> 

Oh! I was assuming that we had an earlier check for that, not a check 
afterwards. It would be worth spelling that out in the patch description.

Makes sense, thanks!

-- 
Cheers

David / dhildenb


