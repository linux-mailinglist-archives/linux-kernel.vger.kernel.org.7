Return-Path: <linux-kernel+bounces-730201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A8C6B04148
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 16:18:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7CB627A84EB
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 14:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE8302571C2;
	Mon, 14 Jul 2025 14:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DrSLAt8o"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80FAD246787
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 14:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752502702; cv=none; b=eELWY21D842rjDJNApY5mUiQaeZeuiqofEi4dpsQ65raQssWjHeVUgpFrEJXqwvCfIVkxH+9nEcfkkMQA+k5AgiHMRQEUOa8Hjdu6e9ssg2za7+eLJ5z+lOmVEHkf0MYi7yLwwsF8T8E8VHcdlDFbGowsxoJA3qzc86PnuyM+uI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752502702; c=relaxed/simple;
	bh=R/69WRnWJQ0bSIrNALHoxXiO/EnyzE/KdbifGQnoIk0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AdH+Jq/gIwVibiMRfLg9e4+JBQ3ocFmVQTkcCrKRiOltQFQTAffv2m8jK3LxWXc0T9+NtU/Bthv5sNHUxIoALw93IiV1qsT8KtOmxER3KMiyDpwAmAVijiEB2wIkQRzgdcmMP9El5M082/0hYWO6BGwkdKv1RLDo6xHlDEk2v/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DrSLAt8o; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752502699;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=eAJ3iCVhDdz6z6h3YYRgguFqsc8zl+o4S274gAq3QzQ=;
	b=DrSLAt8odfUyitC9Ihjmm9Nf2beqQT8KPvqglg/m5Op6t0aYejHY5sXBEkq6jRtfqNBM3v
	4t6nywHqmRDd9zFSyVqK3fQGEzlgYzkjqatekaHHglGnNpoTXica246QDU8TIHkdBcfKW0
	+hfQmxN2K5OF03xmSSooCx1Gt45jDzw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-541-GP3vU1zKNv-49zLZCqdeFw-1; Mon, 14 Jul 2025 10:18:18 -0400
X-MC-Unique: GP3vU1zKNv-49zLZCqdeFw-1
X-Mimecast-MFC-AGG-ID: GP3vU1zKNv-49zLZCqdeFw_1752502697
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-451d7de4ae3so28145335e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 07:18:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752502697; x=1753107497;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eAJ3iCVhDdz6z6h3YYRgguFqsc8zl+o4S274gAq3QzQ=;
        b=OphL4o6vIVxEV4uCA23SCxo2Ulhxh0gJ1ImGjkln9DVocR7NK568pjID3BRvPfHW2H
         SEyQFoEbqYN4v/ketlxcer1wr0eNDfXrRklmesWT5WY2Ef9bjhdMTFQM/864uGA3VePL
         yyGAGC9CWtyTGjZwqXoKah+pUEgfbH4F7ij7TO51WqcSrRHSuenmajh+EOGGj8G9HpJ7
         cUoWpbwEsE99kY8219gvdNfAO8O2ZFGlC7F9TNK+wEk1+59d1ESwMI4KdjJVud8RVYFH
         QYOtssu4igrh4jOOeEuaGbPCGIx2PG0cclXR05PoYcWwrRccVjSFMj7yIbDUAiFjzrHf
         Z3gA==
X-Forwarded-Encrypted: i=1; AJvYcCVShXeM8/K5h4xhT//CQu56lsKaW2mGqNFqRIA+4b3mx0ZViaoBoc9G6xgim/7yPVAvZgGGNV0IhWh0WNg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yws5xgBWdgDwINYiJxLQ6XBoc6s5fQXUaUzsKZZoOtjKpPfm6e5
	LGhzj9MbBlOrXmhvDUDRBRV9SBeR/x0TsaOsgE9CiDedMGDYqHmMB0bgLe3eqj+HsKc5Ldz1qW4
	Y451HvKfxyxZGegsHQNNIUjj2jLTOiFJEJLvhmyjOgY3TkJqqx/FPisLzo5OMj/OYvA==
X-Gm-Gg: ASbGncuMaQDtoWkheZhrIWjO6HwEpVVqKcGg/wqQq7k0ASkU/gPurCLY+l4Tlw4m6TJ
	YCsIaaOA2+64OKr9J2uoktuQJ1jxDQeiyql9wJPP9kkRpDgO3V94GYe11X4UrVRmggovZvRiMT3
	iKUPkBitXxT2DWKxBhp/D9R/e0U0SZAFIBl8gifDfawacpCrSotbuxyXA0XaVZSmMJUkEz9Ysrz
	e87iWgjI9GyqPmh0kl3MArnUXYeLYJLIKwxOL5TGsoIcMgmBGRu8UIAZQIijkpayN8GcfRkd2Ne
	swvq2wX3wSD6bCX2esfPf/qUlKjMcJXxVc1Y0ifpMyC6dQE4U03bkw2GMg0DQD3VT1Tmu76Zndf
	QxgvrvSa4KtR8qYtPxVL+4UrOqGsF8Rf3rHhz3zYe/O01KC5EEx5U6zFenVpzsq5+
X-Received: by 2002:a05:600c:a08c:b0:456:22f0:d9ca with SMTP id 5b1f17b1804b1-45622f0de79mr13353515e9.26.1752502696734;
        Mon, 14 Jul 2025 07:18:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEbT9ZPIoGGCqiO8MFBsH9vqN4nFX90UcX2di/BtWtN0bS6sk4srxVganZc03A1dsYc4N/AGw==
X-Received: by 2002:a05:600c:a08c:b0:456:22f0:d9ca with SMTP id 5b1f17b1804b1-45622f0de79mr13353295e9.26.1752502696314;
        Mon, 14 Jul 2025 07:18:16 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f38:ca00:ca3a:83da:653e:234? (p200300d82f38ca00ca3a83da653e0234.dip0.t-ipconnect.de. [2003:d8:2f38:ca00:ca3a:83da:653e:234])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-456114a417csm55711175e9.25.2025.07.14.07.18.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jul 2025 07:18:14 -0700 (PDT)
Message-ID: <ee19189f-7510-4ddd-85b0-34d6319f8fc6@redhat.com>
Date: Mon, 14 Jul 2025 16:18:13 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/vma: refactor vma_modify_flags_name() to
 vma_modify_name()
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
 Pedro Falcato <pfalcato@suse.de>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20250714135839.178032-1-lorenzo.stoakes@oracle.com>
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
In-Reply-To: <20250714135839.178032-1-lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14.07.25 15:58, Lorenzo Stoakes wrote:
> The single instance in which we use this function doesn't actually need to
> change VMA flags, so remove this parameter and update the caller
> accordingly.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ---
>   mm/madvise.c |  4 ++--
>   mm/vma.c     |  4 +---
>   mm/vma.h     | 15 +++++++--------
>   3 files changed, 10 insertions(+), 13 deletions(-)
> 
> diff --git a/mm/madvise.c b/mm/madvise.c
> index 9de9b7c797c6..afa9e4db2adb 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -162,8 +162,8 @@ static int madvise_update_vma(vm_flags_t new_flags,
>   		return 0;
>   
>   	if (set_new_anon_name)
> -		vma = vma_modify_flags_name(&vmi, madv_behavior->prev, vma,
> -			range->start, range->end, new_flags, anon_name);
> +		vma = vma_modify_name(&vmi, madv_behavior->prev, vma,
> +			range->start, range->end, anon_name);
>   	else

The doc of madvise_update_vma() is a bit misleading:

"Update the vm_flags and/or anon_name"

I assume it's xor? Do we want to sanity check that this will hold true?

In general, LGTM.

-- 
Cheers,

David / dhildenb


