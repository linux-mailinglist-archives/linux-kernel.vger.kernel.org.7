Return-Path: <linux-kernel+bounces-862523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04234BF584A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 11:31:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6F113A428D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 09:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9788F24676D;
	Tue, 21 Oct 2025 09:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KSXYc5C4"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B7442236F3
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 09:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761039056; cv=none; b=oZX5QYNO83kEiGd5rPHEfS66rllOIAvO0CgMbC90dZo0x9TRZaX2Bfwx0p2q96T/vEMol/C0ePZv8pR3yhuOSEFheJpVXVi+rWs0cBDEIPbYOw2PtZpLSdq8j0dXEsnLFQQmp4UZGQEWwwgCOOX3bak8A60AF4EYNbKfjKNLq4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761039056; c=relaxed/simple;
	bh=NCTPdYZ+LcRQLlXzZ50IhvxVTAZPMSC8DfeGUFVBNkM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ksb0LMAJPKJACU20BlcL2CirKIGM5dw/XGTE//JzuCPf5yn2euMczy6udj4RKtSxI5YB/B3ifTDJEGpxjV3J6uc+0SVQeZOeeR+NcTU2s0LZTHOa1vpyxAqqoNu3nMC6j8rUIFaEFcFcoLbpU5IkEVEOce+H9ETWeZiQwdpmiLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KSXYc5C4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761039053;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=miVaLSQJ+GrWVKZVzwOoIEwF8/pGqrxPxyZhLDn1EvM=;
	b=KSXYc5C4kH8yumcxBTZMVkbUWy6nq6wySj7LkhPPJVVBjVrroOI7mYv0ZzaVk1H+Nnie7D
	95rq2pHUYf+7m7Pva05NyO4/blhcMThIZYt1PAmyuN6x1SACBrJvPi40Sg99ZWy8UdTIf9
	zQoJXaGLqPyARqwB8qqFCx4Rt6siTDM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-mkJBXwp5MMqvWrieCElcDA-1; Tue, 21 Oct 2025 05:30:52 -0400
X-MC-Unique: mkJBXwp5MMqvWrieCElcDA-1
X-Mimecast-MFC-AGG-ID: mkJBXwp5MMqvWrieCElcDA_1761039051
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-47114d373d5so52005455e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 02:30:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761039051; x=1761643851;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=miVaLSQJ+GrWVKZVzwOoIEwF8/pGqrxPxyZhLDn1EvM=;
        b=RpwcZE9+LelZK7G2eu4arluMjm2vaOaEtQypok6kBz4F17x/+CWLphNOhfWyZB4qsx
         u8FF4dPRQ0aooZIbRSNdY9Cu7CxcpxM1nW29IExRsypFH0/XresDpz5/9MKND2vF+m6c
         Hnhj4l5Ozbz9TpdNaLYF9IoCAOTHdTuah/e/HfBAekHq1cyVvKKI8yuxeH2GgsHgGYMd
         jMNldJGXAw4AHS6aIAeftHQV+Oe5WWDagI3EglRrn1CYT4Qvqmav9yFmP7EfGVu+2j4s
         kXLDpSqG6BPclRhwt/dHBQffhpaoxe+Bytbnmq7DkCBuMiYkg07scVBkbP4xTA8azpo8
         iUpg==
X-Gm-Message-State: AOJu0YzmIiC+ZJeTLYH+jGCcOy0daQGoRB8+zg3qFhBpkXgiQ7vq9cma
	rBk5tODqYyIifglAJNHBvOURXpo4rD3nV3REiSZD1D5WOjZ/LYwPwvi41gwS0M7QgIf13MzSH8h
	URg3mE0BBATf9NA/tt9/qHC8jOBpS30Oqy2dowusiGG7uvsCcUXXXKpHHStDOMFf3fuUmiQAAwg
	==
X-Gm-Gg: ASbGncuCaG9y4PT0RwgIKtBCP5JYF4J3pdMemjGM96JSR7ddK01f95uZEoKfrLYdKLh
	WdoOCOhIZrVQSIPCFiqKbKMOTi4l/UIKpBa2aTcdIURpf6YUSQRoohXd5Qtl3ImEk7dpv5SZBgF
	i5Zq32xc3qoQbeLuEs1V9d/RO7FzgAt5gouh0In4dgwYCgFWGteADh87ItmYQxTtOeDojSeUHhs
	NMYvtXLLy4VrjFTLeJq/AopvWIC/Kz1JxJ0yhlZB82HZPa9rYnOBHC6UzPw0JSVvLkI7R+JQgMm
	mIQ+PYkgSfPWyN0qQHIXTwMy9MxOe1o5qFw3M7rGhoqVhVS8vGYGLanKu/Q7vYKerZnc94frTow
	/vZBXfoQ+shANjOg8qJb+3owlyFA8KyWwz3GHiMeRJIDtIr6XLKn5KtfY65tD9+T1FzJby67Vln
	5LsLAfbbZi+fcqtHkNtQxyJCTHe28=
X-Received: by 2002:a05:600c:470d:b0:471:7c8:ddf7 with SMTP id 5b1f17b1804b1-471178a7447mr104678045e9.14.1761039050879;
        Tue, 21 Oct 2025 02:30:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE2QRfO9MmiqYi1btl3MqpiES6HqQddhDz+ykAs9uV4ny3W+IOmzAxSH4+KOxeQR5hSjWOplg==
X-Received: by 2002:a05:600c:470d:b0:471:7c8:ddf7 with SMTP id 5b1f17b1804b1-471178a7447mr104677905e9.14.1761039050466;
        Tue, 21 Oct 2025 02:30:50 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f4e:3200:c99d:a38b:3f3a:d4b3? (p200300d82f4e3200c99da38b3f3ad4b3.dip0.t-ipconnect.de. [2003:d8:2f4e:3200:c99d:a38b:3f3a:d4b3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47496cf4cf7sm12324015e9.8.2025.10.21.02.30.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 02:30:50 -0700 (PDT)
Message-ID: <10402943-b613-4bd6-ab78-f34efa74a95c@redhat.com>
Date: Tue, 21 Oct 2025 11:30:48 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2] page_alloc: allow migration of smaller hugepages
 during contig_alloc.
To: Gregory Price <gourry@gourry.net>, linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com,
 akpm@linux-foundation.org, vbabka@suse.cz, surenb@google.com,
 mhocko@suse.com, jackmanb@google.com, hannes@cmpxchg.org, ziy@nvidia.com
References: <20251020210816.1089910-1-gourry@gourry.net>
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
In-Reply-To: <20251020210816.1089910-1-gourry@gourry.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20.10.25 23:08, Gregory Price wrote:
> We presently skip regions with hugepages entirely when trying to do
> contiguous page allocation.  Instead, if hugepage migration is enabled,
> consider regions with hugepages smaller than the requested allocation.
> 
> Compaction `isolate_migrate_pages_block()` already expects requests

Please, let's not talk about "compaction" here, it's just confusing to 
talk about compaction for something that is not compaction but uses some 
primitives (because not properly separated yet)

Just say "isolate_migrate_pages_block() already expects ..."

> with hugepages to originate from alloc_contig, and hugetlb code also
> does a migratable check when isolating in `folio_isolate_hugetlb()`.
> 
> Suggested-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Gregory Price <gourry@gourry.net>
> ---
>   mm/page_alloc.c | 15 +++++++++++++--
>   1 file changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 600d9e981c23..da2e65bf63e3 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -7048,8 +7048,19 @@ static bool pfn_range_valid_contig(struct zone *z, unsigned long start_pfn,
>   		if (PageReserved(page))
>   			return false;
>   
> -		if (PageHuge(page))
> -			return false;
> +		if (PageHuge(page)) {
> +			unsigned int order;
> +
> +			if (!IS_ENABLED(CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION))
> +				return false;
> +
> +			/* Don't consider moving same size/larger pages */
> +			page = compound_head(page);
> +			order = compound_order(page);
> +			if ((order >= MAX_PAGE_ORDER) ||
> +			    (nr_pages < (1 << order)))
> +				return false;

This is roughly what we do in pageblock_skip_persistent(), just with a 
hardcoded pageblock size.

I'm not sure about the MAX_PAGE_ORDER check, though. If an arch supports 
two hugetlb sizes that exceed MAX_PAGE_ORDER, it would not work as expected.

Doesn't arm64 support that with cont-PMD vs. PUD hugetlb folios? 
MAX_FOLIO_ORDER would be better.

-- 
Cheers

David / dhildenb


