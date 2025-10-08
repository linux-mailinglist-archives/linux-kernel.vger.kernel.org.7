Return-Path: <linux-kernel+bounces-845184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D1521BC3CEB
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 10:20:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A81AF19E3EE1
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 08:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 344CC2F7AA7;
	Wed,  8 Oct 2025 08:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XEhyXyt7"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D142F657A
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 08:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759911500; cv=none; b=e4RvxB5Pm/vXpEdwW+hJNz0BjRgfeWGsuq7lxmn0VPbgpCqNsNJUa9T/JinZJt4RVYY9VGgk9qrEt8UkhcpsCttOxry3Hnkj1/Zv8kMOGxCSC0ygn67o6flieSc6819+8Q2ndAE4bLZgiYkWoudqerc/owDMkXJfJiOtSG1IG5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759911500; c=relaxed/simple;
	bh=9QSz0UBr1qcH6DHX15eW7V2Ihup+N9/N0aIE+Q79+oY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gsQhVGFGg+Br4hn+uOIoRGTqbOswbcEZasYTDXcO360vkU2Wh3qZQ2LnPbyY4h71Late5jGi3JJjK7JyWM3VV5jfUkCiMXFMxuHODDuseKNZLAJiDbffHLiiYYCreDjduf8KZOcLuRYactocObBT1RRmSLtGPnb0Z4qR174EJRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XEhyXyt7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759911497;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=g2/UyH6Gp/CXE49aAkLm4ZAwJ2vJKxqomz6AYx7ZppY=;
	b=XEhyXyt78a9FH358LcvaYz2KU0VBPPA62f9jwQpYDFsg+6IiEiCuduwHkml5ibH82He0io
	/lMwuuBPCx6XW9zvBJExvaWxzkp0v1p2a+/iX6Xl3f30WX0utGkOg6TUu7n4XV5dqMaegy
	mi4BKmfnwXnt5BL6GHo7/OLhZzQqtes=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-oNLrHmS6P7WnnnxJH7jc9A-1; Wed, 08 Oct 2025 04:18:15 -0400
X-MC-Unique: oNLrHmS6P7WnnnxJH7jc9A-1
X-Mimecast-MFC-AGG-ID: oNLrHmS6P7WnnnxJH7jc9A_1759911495
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-46e38bd6680so24212745e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 01:18:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759911494; x=1760516294;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g2/UyH6Gp/CXE49aAkLm4ZAwJ2vJKxqomz6AYx7ZppY=;
        b=wiUaWKlQYQnnoXYdFDRtQeqslNQYk5gW8mzxzpZBSESNQ/QgXl96So4SheEoE/02oK
         dcNYw90X4AVtsjFF2EcOlFcXofejTgHY135t4DpmiFvoI23nhZxE+Vdq86NU8CCOhy3y
         Oh/gdUHYYUKES+Z+pDDd9+Rwa6GZ3u3vbHwEOq1ttz2/LQrdZId8hZB7A5A479P59LB/
         7miHLkMfya5Ze+GTvFDRaZvLGEA5DUsBaWCo0TSvibYdDZUUYWX9Eb/SvwebNCDEy70q
         S600GMhLd9yIrb2VM55y+TdIHrgaCFAT5BN/uiADOlM6wGXFeRzEdc5mPHcKXC9uJ6SD
         evMQ==
X-Forwarded-Encrypted: i=1; AJvYcCW1XktFiTmXAX+8wW77T/bo1bWyy7wzHfrC5lYC7R0l9YY8V3B3gDNaqBu4P5XK9ZB7jY2m8s52QeHkOjw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+/Ix1j5N+7ROurCL/ZtQv5W8oJum/LUS+i5D1HAWbznZSa8u6
	L5LslrYTz8eMC45/yZddwbc/eT/ra0wNSQcyGwG3cB1w/bDaEbXWAJRYKofh1Pl54/OEoclJu9H
	YEAxqo1FrqdV04OukpBy9hYp7CrVYwyVp1zYBIzZrfcLf9aiqls5Q59frhX4ef2GDYQ==
X-Gm-Gg: ASbGncvEHx6N1IMZf/MCbWLrHSCaHeQqtEefqLeXVD+cEgrhaJ1NgWg1MFzukFuykS/
	73IvJ/zvb73ZUAp+9ydgZhsuEchRz0N1euSL9KktvQr98i0tFwAXcq+jxBtsCmY39g3WZiM5h/S
	zMPC2as9SvM6/DiXP93X4Db/lO5dxWYo6e5LqKYXJZ0ZY5ZN9EzfKxAXrLa3O4zIX0ZKjU9AtBa
	tu2k5dtrh7dnWAS8OsoS9hhCb9RY/ei1Lr/3+wjrsd5UvIYaDuG2RZt/vyPHOA4PZrJ2BEAb10C
	VAONoOiQd/l9KNLnKhAGZceDyn7BcAejWKk9BR2R9K5rqBsulZgpdQvWQT4eQqT5XqdhsnbNqdH
	lGSTju1js
X-Received: by 2002:a05:600d:8221:b0:46f:aa02:98b2 with SMTP id 5b1f17b1804b1-46faa02ed74mr10646735e9.19.1759911494578;
        Wed, 08 Oct 2025 01:18:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHnk/Uz45vHv0Js/TEnqVijah4F9gyUTG/QIQ/MO0GiLdnBWej945AxIiLU6GGin5Yz5QFb0w==
X-Received: by 2002:a05:600d:8221:b0:46f:aa02:98b2 with SMTP id 5b1f17b1804b1-46faa02ed74mr10646415e9.19.1759911494097;
        Wed, 08 Oct 2025 01:18:14 -0700 (PDT)
Received: from [192.168.3.141] (tmo-083-110.customers.d1-online.com. [80.187.83.110])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fa9c162f0sm26588105e9.9.2025.10.08.01.18.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Oct 2025 01:18:13 -0700 (PDT)
Message-ID: <3c572565-0b21-4136-b0e0-59a5ed858104@redhat.com>
Date: Wed, 8 Oct 2025 10:18:09 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mm-new v3 1/1] mm/khugepaged: abort collapse scan on
 non-swap entries
To: Lance Yang <lance.yang@linux.dev>, akpm@linux-foundation.org
Cc: lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, baohua@kernel.org,
 baolin.wang@linux.alibaba.com, dev.jain@arm.com, hughd@google.com,
 ioworker0@gmail.com, kirill@shutemov.name, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, mpenttil@redhat.com, npache@redhat.com,
 ryan.roberts@arm.com, ziy@nvidia.com, richard.weiyang@gmail.com
References: <20251008032657.72406-1-lance.yang@linux.dev>
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
In-Reply-To: <20251008032657.72406-1-lance.yang@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08.10.25 05:26, Lance Yang wrote:
> From: Lance Yang <lance.yang@linux.dev>
> 
> Currently, special non-swap entries (like PTE markers) are not caught
> early in hpage_collapse_scan_pmd(), leading to failures deep in the
> swap-in logic.
> 
> A function that is called __collapse_huge_page_swapin() and documented
> to "Bring missing pages in from swap" will handle other types as well.
> 
> As analyzed by David[1], we could have ended up with the following
> entry types right before do_swap_page():
> 
>    (1) Migration entries. We would have waited.
>        -> Maybe worth it to wait, maybe not. We suspect we don't stumble
>           into that frequently such that we don't care. We could always
>           unlock this separately later.
> 
>    (2) Device-exclusive entries. We would have converted to non-exclusive.
>        -> See make_device_exclusive(), we cannot tolerate PMD entries and
>           have to split them through FOLL_SPLIT_PMD. As popped up during
>           a recent discussion, collapsing here is actually
>           counter-productive, because the next conversion will PTE-map
>           it again.
>        -> Ok to not collapse.
> 
>    (3) Device-private entries. We would have migrated to RAM.
>        -> Device-private still does not support THPs, so collapsing right
>           now just means that the next device access would split the
>           folio again.
>        -> Ok to not collapse.
> 
>    (4) HWPoison entries
>        -> Cannot collapse
> 
>    (5) Markers
>        -> Cannot collapse
> 
> First, this patch adds an early check for these non-swap entries. If
> any one is found, the scan is aborted immediately with the
> SCAN_PTE_NON_PRESENT result, as Lorenzo suggested[2], avoiding wasted
> work. While at it, convert pte_swp_uffd_wp_any() to pte_swp_uffd_wp()
> since we are in the swap pte branch.
> 
> Second, as Wei pointed out[3], we may have a chance to get a non-swap
> entry, since we will drop and re-acquire the mmap lock before
> __collapse_huge_page_swapin(). To handle this, we also add a
> non_swap_entry() check there.
> 
> Note that we can unlock later what we really need, and not account it
> towards max_swap_ptes.
> 
> [1] https://lore.kernel.org/linux-mm/09eaca7b-9988-41c7-8d6e-4802055b3f1e@redhat.com
> [2] https://lore.kernel.org/linux-mm/7df49fe7-c6b7-426a-8680-dcd55219c8bd@lucifer.local
> [3] https://lore.kernel.org/linux-mm/20251005010511.ysek2nqojebqngf3@master
> 
> Acked-by: David Hildenbrand <david@redhat.com>
> Reviewed-by: Wei Yang <richard.weiyang@gmail.com>
> Reviewed-by: Dev Jain <dev.jain@arm.com>
> Suggested-by: David Hildenbrand <david@redhat.com>
> Suggested-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Signed-off-by: Lance Yang <lance.yang@linux.dev>
> ---

Sorry for not replying earlier to your other mail.

LGTM.

We can always handle migration entries later if this shows up to be a 
problem (this time, in a clean way ...) and not count them towards 
actual "swap" entries.

-- 
Cheers

David / dhildenb


