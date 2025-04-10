Return-Path: <linux-kernel+bounces-598343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76F08A84530
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Apr 2025 15:45:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CD3D440685
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Apr 2025 13:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 241142857FA;
	Thu, 10 Apr 2025 13:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mwzxzi8q"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A31D8283C98
	for <linux-kernel@vger.kernel.org>; Thu, 10 Apr 2025 13:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744292477; cv=none; b=nWD03esa/UpzcRr67d5PaqwWZhcuz67vr8rK6DIZFXngxOODa0nfG/rCiMCYM3sEE4ceT3KePM2gn1Qp2ZKLhMZfO6jBuH0zJis9nt0iJNxfzwKOlfEEX9DYewZlgEFuQcNJSQZGJ2p6wnBA6YtYU4pz05wq2fcPx+4DzAX1NQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744292477; c=relaxed/simple;
	bh=k7HZ3J6Sdznt73jGRL/V1rXRjiNjVKh9Rezm6vCsJlQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o8s+tbD2S6JhbYOWNrvdo5XsTeh5hpi2CGM5IFeyzkZmWhHOdMpm4Y9LFq2IhsjwcDfSDY6ZvR1tJ5Opdjfj+pL0BoWp3Rt2sD/0ZQXSQT4JK985eFjiGXAPcEJ+oEP25UGuMilSG073RQZcSq8KW/bzhgDkXUhPBYtbKzoTyaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Mwzxzi8q; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744292474;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=VtKjRccRoZwfHOkp6JnSpQLVWKCEwxlpsURyTo3+C1M=;
	b=Mwzxzi8qOwFF9VNzk23BZYYx1DJc1lwQAWGcyWfVrKfumnI3i01IQVXGd8EArU3PQY7pPv
	1eZSSNviLy978QGc3Mg85BXk1/Oe11zpQB6aO5akcfccr8sPIOGr2tPWGsXknP8Imx2Nsi
	2wDZvxjFHCVpg7XqZ7+NDeNHElUYvN0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-32-1D_e0WhHN42X8UnTdt-TVg-1; Thu, 10 Apr 2025 09:41:13 -0400
X-MC-Unique: 1D_e0WhHN42X8UnTdt-TVg-1
X-Mimecast-MFC-AGG-ID: 1D_e0WhHN42X8UnTdt-TVg_1744292472
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-39abdadb0f0so429190f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Apr 2025 06:41:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744292472; x=1744897272;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VtKjRccRoZwfHOkp6JnSpQLVWKCEwxlpsURyTo3+C1M=;
        b=B40t1CFiBH543ZSGQyqqr4UlVxG8KR4VnZaQUfHA1YTY9X0/R2Hz3MNRmwi0S8kVxd
         0kXP7QNim0GlEMaI8MjH3oXQD942pDH/f1WVWp1TVyZPjNZSIKpoK37grPycNA4EuxTL
         fw0BWk3uZN4yr6D5qfhZx58QbcklxInPVqfRqyK1tn0qWwC4hycTafdsj6QKiSY3oVhd
         YYI2ZVBU5OaGisnpTAdvLFQZhTmcCdE7M7CP/f8LeQRQdaI5jAcwzN/wZnfATz0dIvdK
         XLoLDaYHtC82psACKGqsHoA8BjIXm5Jk1jE6C5xyqY5t0CZKwXF5FEJXPxYungVnwD7/
         q5Yg==
X-Forwarded-Encrypted: i=1; AJvYcCVJWe1yIQ2w6vBSnAIZhHunejzhgqYvfM4a1HzGaYugeO1BThaxVieFufD2k4P3WJf/E0FcrO7B/DuFtZU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywejw2aV+vPiWL4OCzmAvvhZ3+XFiKcms4ObDpd6Pg825nLlCNq
	97bKVLvMonx9RoEuXPd/3EHY3kl+4v0kHAYAPUoQg78Z0K0Au6Rx5jZZWrbOnfSJ/ji3TiwcC6z
	cUk3/k4KOhu0noBErbVxeJFU3pz3zKjSwX25SOwdwZxcAd5cXjPQrEkhieTWkmQ==
X-Gm-Gg: ASbGncuEb3jANPJpZmc4UESG+CZhXq215bGG9tYEkSP76PTEjVF7PMfA7NPkw8dRbyu
	jZVLT/bNyB8nY3poR5XLppRDUp92jSx8MPGMPLVVXyOa5BCQO1DqqreBr5ocJP6TkqORLiq3GHo
	/wS0Uk7qYKUq7okJZYPXotWY0VR7EgJr/pXbRcROldSj+XTolLWSYsR5zvvOzCjxGnkJf2oHVJk
	jk6qjAXMnDf7l8om+8DjBrtZOdAJmxil14cxOmMjtAzVbL9dEDkggK04m7E/9+OElolxBg7FZim
	UfVIpDfDwLK9SML5KAcmXVWWCZTiZZqLLjnhpxKcteseCJ88Qs8R4IJSsDxKA0DAbnSrNe8fVlH
	K6ZdLkbtc28l6zZoy5vINA2Rabx5fk66AtBuobHQ=
X-Received: by 2002:a05:6000:4287:b0:39b:ede7:8906 with SMTP id ffacd0b85a97d-39d8f46d4a8mr2098072f8f.19.1744292472120;
        Thu, 10 Apr 2025 06:41:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH0jqojO5GuXCmEsovcLJk3mS+EZg4SREWFZQBmCngBxQV0Ac/y+yZfGPR3I7oxkT/akTCJmQ==
X-Received: by 2002:a05:6000:4287:b0:39b:ede7:8906 with SMTP id ffacd0b85a97d-39d8f46d4a8mr2098046f8f.19.1744292471789;
        Thu, 10 Apr 2025 06:41:11 -0700 (PDT)
Received: from ?IPV6:2003:cb:c71a:5900:d106:4706:528a:7cd5? (p200300cbc71a5900d1064706528a7cd5.dip0.t-ipconnect.de. [2003:cb:c71a:5900:d106:4706:528a:7cd5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43f235a5e9dsm53785615e9.36.2025.04.10.06.41.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Apr 2025 06:41:11 -0700 (PDT)
Message-ID: <3270dbbb-0bd3-4217-90f5-441210fef87b@redhat.com>
Date: Thu, 10 Apr 2025 15:41:04 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 3/3] mm/mempolicy: Support memory hotplug in weighted
 interleave
To: Honggyu Kim <honggyu.kim@sk.com>, Rakie Kim <rakie.kim@sk.com>,
 akpm@linux-foundation.org
Cc: kernel_team@skhynix.com, gourry@gourry.net, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
 joshua.hahnjy@gmail.com, dan.j.williams@intel.com,
 ying.huang@linux.alibaba.com, Jonathan.Cameron@huawei.com,
 osalvador@suse.de, yunjeong.mun@sk.com
References: <20250408073243.488-1-rakie.kim@sk.com>
 <20250408073243.488-4-rakie.kim@sk.com>
 <19562f7e-38ce-41fc-8dfc-bfd6b1259291@redhat.com>
 <b58f2dd6-d978-487a-b420-badfb4847c00@sk.com>
 <203ed4e9-4691-483c-bf42-3035b3ad3539@redhat.com>
 <755ad3ff-17d5-4610-94ce-2f2d775b518d@sk.com>
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
 ZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT7CwZgEEwEIAEICGwMGCwkIBwMCBhUIAgkKCwQW
 AgMBAh4BAheAAhkBFiEEG9nKrXNcTDpGDfzKTd4Q9wD/g1oFAl8Ox4kFCRKpKXgACgkQTd4Q
 9wD/g1oHcA//a6Tj7SBNjFNM1iNhWUo1lxAja0lpSodSnB2g4FCZ4R61SBR4l/psBL73xktp
 rDHrx4aSpwkRP6Epu6mLvhlfjmkRG4OynJ5HG1gfv7RJJfnUdUM1z5kdS8JBrOhMJS2c/gPf
 wv1TGRq2XdMPnfY2o0CxRqpcLkx4vBODvJGl2mQyJF/gPepdDfcT8/PY9BJ7FL6Hrq1gnAo4
 3Iv9qV0JiT2wmZciNyYQhmA1V6dyTRiQ4YAc31zOo2IM+xisPzeSHgw3ONY/XhYvfZ9r7W1l
 pNQdc2G+o4Di9NPFHQQhDw3YTRR1opJaTlRDzxYxzU6ZnUUBghxt9cwUWTpfCktkMZiPSDGd
 KgQBjnweV2jw9UOTxjb4LXqDjmSNkjDdQUOU69jGMUXgihvo4zhYcMX8F5gWdRtMR7DzW/YE
 BgVcyxNkMIXoY1aYj6npHYiNQesQlqjU6azjbH70/SXKM5tNRplgW8TNprMDuntdvV9wNkFs
 9TyM02V5aWxFfI42+aivc4KEw69SE9KXwC7FSf5wXzuTot97N9Phj/Z3+jx443jo2NR34XgF
 89cct7wJMjOF7bBefo0fPPZQuIma0Zym71cP61OP/i11ahNye6HGKfxGCOcs5wW9kRQEk8P9
 M/k2wt3mt/fCQnuP/mWutNPt95w9wSsUyATLmtNrwccz63XOwU0EVcufkQEQAOfX3n0g0fZz
 Bgm/S2zF/kxQKCEKP8ID+Vz8sy2GpDvveBq4H2Y34XWsT1zLJdvqPI4af4ZSMxuerWjXbVWb
 T6d4odQIG0fKx4F8NccDqbgHeZRNajXeeJ3R7gAzvWvQNLz4piHrO/B4tf8svmRBL0ZB5P5A
 2uhdwLU3NZuK22zpNn4is87BPWF8HhY0L5fafgDMOqnf4guJVJPYNPhUFzXUbPqOKOkL8ojk
 CXxkOFHAbjstSK5Ca3fKquY3rdX3DNo+EL7FvAiw1mUtS+5GeYE+RMnDCsVFm/C7kY8c2d0G
 NWkB9pJM5+mnIoFNxy7YBcldYATVeOHoY4LyaUWNnAvFYWp08dHWfZo9WCiJMuTfgtH9tc75
 7QanMVdPt6fDK8UUXIBLQ2TWr/sQKE9xtFuEmoQGlE1l6bGaDnnMLcYu+Asp3kDT0w4zYGsx
 5r6XQVRH4+5N6eHZiaeYtFOujp5n+pjBaQK7wUUjDilPQ5QMzIuCL4YjVoylWiBNknvQWBXS
 lQCWmavOT9sttGQXdPCC5ynI+1ymZC1ORZKANLnRAb0NH/UCzcsstw2TAkFnMEbo9Zu9w7Kv
 AxBQXWeXhJI9XQssfrf4Gusdqx8nPEpfOqCtbbwJMATbHyqLt7/oz/5deGuwxgb65pWIzufa
 N7eop7uh+6bezi+rugUI+w6DABEBAAHCwXwEGAEIACYCGwwWIQQb2cqtc1xMOkYN/MpN3hD3
 AP+DWgUCXw7HsgUJEqkpoQAKCRBN3hD3AP+DWrrpD/4qS3dyVRxDcDHIlmguXjC1Q5tZTwNB
 boaBTPHSy/Nksu0eY7x6HfQJ3xajVH32Ms6t1trDQmPx2iP5+7iDsb7OKAb5eOS8h+BEBDeq
 3ecsQDv0fFJOA9ag5O3LLNk+3x3q7e0uo06XMaY7UHS341ozXUUI7wC7iKfoUTv03iO9El5f
 XpNMx/YrIMduZ2+nd9Di7o5+KIwlb2mAB9sTNHdMrXesX8eBL6T9b+MZJk+mZuPxKNVfEQMQ
 a5SxUEADIPQTPNvBewdeI80yeOCrN+Zzwy/Mrx9EPeu59Y5vSJOx/z6OUImD/GhX7Xvkt3kq
 Er5KTrJz3++B6SH9pum9PuoE/k+nntJkNMmQpR4MCBaV/J9gIOPGodDKnjdng+mXliF3Ptu6
 3oxc2RCyGzTlxyMwuc2U5Q7KtUNTdDe8T0uE+9b8BLMVQDDfJjqY0VVqSUwImzTDLX9S4g/8
 kC4HRcclk8hpyhY2jKGluZO0awwTIMgVEzmTyBphDg/Gx7dZU1Xf8HFuE+UZ5UDHDTnwgv7E
 th6RC9+WrhDNspZ9fJjKWRbveQgUFCpe1sa77LAw+XFrKmBHXp9ZVIe90RMe2tRL06BGiRZr
 jPrnvUsUUsjRoRNJjKKA/REq+sAnhkNPPZ/NNMjaZ5b8Tovi8C0tmxiCHaQYqj7G2rgnT0kt
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <755ad3ff-17d5-4610-94ce-2f2d775b518d@sk.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10.04.25 15:25, Honggyu Kim wrote:
> Hi David,
> 
> On 4/9/2025 8:52 PM, David Hildenbrand wrote:
>> On 09.04.25 13:39, Honggyu Kim wrote:
>>> Hi David,
>>>
>>> On 4/9/2025 6:05 PM, David Hildenbrand wrote:
>>>> On 08.04.25 09:32, Rakie Kim wrote:
> [...snip...]
>>>>> Signed-off-by: Rakie Kim <rakie.kim@sk.com>
>>>>> Signed-off-by: Honggyu Kim <honggyu.kim@sk.com>
>>>>> Signed-off-by: Yunjeong Mun <yunjeong.mun@sk.com>
>>>>
>>>> Why are the other SOF in there? Are there Co-developed-by missing?
>>>
>>> I initially found the problem and fixed it with my internal implementation but
>>> Rakie also had his idea so he started working on it.  His initial implementation
>>> has almost been similar to mine.
>>>
>>> I thought Signed-off-by is a way to express the patch series contains our
>>> contribution, but if you think it's unusual, then I can add this.
>>
>> Please see Documentation/process/submitting-patches.rst,
> 
> Thanks for the info.
> 
>> and note that these are not "patch delivery" SOB.
>>
>> "
>> The Signed-off-by: tag indicates that the signer was involved in the
>> development of the patch, or that he/she was in the patch's delivery path.
> 
> Yunjeong and I have been involved in finding the problem and also concluded this
> issue is related to hotplug together with our initial implementations before
> this patch.  So I guess it is the former case.

IIRC, usually we use Co-developed-by + SOB only if there are actual code 
contributions: when you would consider someone a "co-author".

"Co-developed-by: denotes authorship"

For suggestions we use Suggested-by, and for things that popped up 
during a review, it's usually a good idea that reviewers supply a 
Reviewed-by at the end.


So I guess Co-developed-by + SOB is appropriate if people consider 
themselves co-authors, in addition  to the main author.

> 
>> "
>>
>> and
>>
>> "
>> Co-developed-by: states that the patch was co-created by multiple developers;
>> it is used to give attribution to co-authors (in addition to the author
>> attributed by the From: tag) when several people work on a single patch.  Since
>> Co-developed-by: denotes authorship, every Co-developed-by: must be immediately
>> followed by a Signed-off-by: of the associated co-author.  Standard sign-off
> 
> So the Co-developed-by comes before Signed-off-by.

Yes.

-- 
Cheers,

David / dhildenb


