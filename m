Return-Path: <linux-kernel+bounces-843053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AE2ABBE505
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 16:19:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7E8214EE773
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 14:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E00A2D248B;
	Mon,  6 Oct 2025 14:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iqVuiyvO"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9076227BA4
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 14:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759760342; cv=none; b=X6Tp6DnWwbaANlLxsbl+enkgPLwV7s49mqLYRM/Oct7AFnfF5IKGSS5eH/FqkPfqoL16iXUhGPFu0U/rtJJEWsDHw5tZeyb+IKUXaczCSBaQ5ejwsgQa/tOz0QxlEmvKbVkicZ2sgLT91ksxflDTFbY9hJsXnXWRAxw/8I6KVQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759760342; c=relaxed/simple;
	bh=3YlzqWZfkEV9YOTu/vVbgtu8eEcM5Bv8Q/DxaHF5jt8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QTeLZX6Hpw7ynqCjEfw+HMer5bFBKbNK9ex1HQnkp5UO5i8B07VGjes8J32R4erfpBulog5r42q2Rv2BNsJE+mqqZ8QR7LwRBrkcYDds0RfUODqDb3O3MvNPSfirWFLA6eSvEKTc6mnsZyQHmGWHPvNu5KCMO1vUMUiQp22oTqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iqVuiyvO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759760339;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=mu5vHzQSpKvoNJE+2NhZfMelQ4GUHMcWAcPCQHUhiTg=;
	b=iqVuiyvO0D/KD4RVKCdGcqbc+4sbcSCDWOT48E0pgx8p78uG9DKokRN94g3kQsM8/1mHuy
	e9kE1xQM2VYSE1V0djG0oRaniSkeGpX6+S7hl7rwNTJL1cAKsupAxN2K6nLKhLevGwP0PO
	jXQh1doKE05LhpuFBFhytM8T/A6lfZI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-92-5xhp8h0mOau0bYQXS8GLdw-1; Mon, 06 Oct 2025 10:18:56 -0400
X-MC-Unique: 5xhp8h0mOau0bYQXS8GLdw-1
X-Mimecast-MFC-AGG-ID: 5xhp8h0mOau0bYQXS8GLdw_1759760335
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3f6b44ab789so2576911f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 07:18:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759760335; x=1760365135;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mu5vHzQSpKvoNJE+2NhZfMelQ4GUHMcWAcPCQHUhiTg=;
        b=aj+sfA2q4q8Am6gy8Wt52szgaePMvmpFsLtBFXlqZ1yyygmX2uvo30ILBPfKBR3twt
         cUJIwfPo8y7JK1irAAORXlk5t1BYCKg3VUOANRaWR/hueIe2LxQqOt1up6Jvc4dJHqxF
         z7QXxQZor3cCOIc4IcwXDScPk6VW7xyQWTcZue4T/7pK9SwSXDpjAi5JgWMQc1t01UXt
         /8ocO97rUCtjamW8VaeLK7fupzv3nzRmL8Mrk/LGg1QmBbn5AIUO/ZvFIi7/TGDYuhIR
         VlxsQMlzNK4Di6qAtKuHyIGkMvV0AkMybxv72olpI3CojDQKGWZO6NPCS+Er4m7kg0xz
         h1SQ==
X-Forwarded-Encrypted: i=1; AJvYcCXwgE7qrRDfPkl/BgFr5WMvu1aWcqCgt1GvKhNAepYp9Dg04XKoxor+oM0HXTQ+hXw5oXJuOzIWV27VU18=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuFRKCr6lx0a2t63YW/geHDs00ZXkbRi+WljIPYJB838ev+TEI
	bEem+QAgmED5ngiAQOZZ2stPlgByejuos9E3zPawULzSCM1jWncY/MjiGaOLyyiDmN7tW0YET9h
	Hw1/Ed5BNeWjpuNPWW1bY4fSKJRm6OlklpnIslFzAjKGP3bkFi9+h75ZJF9g6VgLe4Q==
X-Gm-Gg: ASbGncvvSaCVaAm+rQZHX49NVSaFQAF/k6Fd+5/tbU/26tiKvmwqxriq2HpveFldAfn
	JJszgfd5wSccDf8qpQPv+hyXGprAbi3OJf0bK7t0UFcMsiCn523STdkmypISdgdzwoipL/SKReT
	GnyVZuNnDBzt4sY0YPbXG4C27MIXxAW5KUZ4HPuqAfyLgAgyS2zb6WQfXhiKfxxHkFVCif1au95
	WpoUdnkEFa1Gy4E9fvhIwasenE0mC/+S0DttHjJ5wkFqt69pb6lSyEyXGQOkWEFOGSOm0G77xT3
	HhMkDQc1b+xz0yQ6ZZ5CCMxD/fOcOHrMYxCWvPT2NpkkngXv56YoX4tmongyk+iiWW7aW8mXmGd
	FcfMZMpzo
X-Received: by 2002:a5d:588f:0:b0:3ee:158c:8bc3 with SMTP id ffacd0b85a97d-4256719e6e4mr9281462f8f.36.1759760335265;
        Mon, 06 Oct 2025 07:18:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG/fCfExas8mbEXCQflYkuuVr+7p6ZsXgqYs8eseHXvI+uIq0sprPLuJqkcRw5lRJBk93lPDA==
X-Received: by 2002:a5d:588f:0:b0:3ee:158c:8bc3 with SMTP id ffacd0b85a97d-4256719e6e4mr9281433f8f.36.1759760334739;
        Mon, 06 Oct 2025 07:18:54 -0700 (PDT)
Received: from [192.168.3.141] (tmo-083-110.customers.d1-online.com. [80.187.83.110])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8a6c54sm21431530f8f.11.2025.10.06.07.18.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Oct 2025 07:18:54 -0700 (PDT)
Message-ID: <09eaca7b-9988-41c7-8d6e-4802055b3f1e@redhat.com>
Date: Mon, 6 Oct 2025 16:18:51 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mm-new v2 1/1] mm/khugepaged: abort collapse scan on
 non-swap entries
To: Lance Yang <lance.yang@linux.dev>, Wei Yang <richard.weiyang@gmail.com>
Cc: akpm@linux-foundation.org, lorenzo.stoakes@oracle.com,
 Liam.Howlett@oracle.com, baohua@kernel.org, baolin.wang@linux.alibaba.com,
 dev.jain@arm.com, hughd@google.com, ioworker0@gmail.com,
 kirill@shutemov.name, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 mpenttil@redhat.com, npache@redhat.com, ryan.roberts@arm.com, ziy@nvidia.com
References: <20251001032251.85888-1-lance.yang@linux.dev>
 <20251001085425.5iq2mgfom6sqkbbx@master>
 <1d09acbf-ccc9-4f06-9392-669c98e34661@linux.dev>
 <20251005010511.ysek2nqojebqngf3@master>
 <31c3f774-edb7-420a-a6a8-3e21f2abd776@linux.dev>
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
In-Reply-To: <31c3f774-edb7-420a-a6a8-3e21f2abd776@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05.10.25 04:12, Lance Yang wrote:
> 
> 
> On 2025/10/5 09:05, Wei Yang wrote:
>> On Wed, Oct 01, 2025 at 06:05:57PM +0800, Lance Yang wrote:
>>>
>>>
>>> On 2025/10/1 16:54, Wei Yang wrote:
>>>> On Wed, Oct 01, 2025 at 11:22:51AM +0800, Lance Yang wrote:
>>>>> From: Lance Yang <lance.yang@linux.dev>
>>>>>
>>>>> Currently, special non-swap entries (like migration, hwpoison, or PTE
>>>>> markers) are not caught early in hpage_collapse_scan_pmd(), leading to
>>>>> failures deep in the swap-in logic.
>>>>>
>>>>> hpage_collapse_scan_pmd()
>>>>> `- collapse_huge_page()
>>>>>        `- __collapse_huge_page_swapin() -> fails!
>>>>>
>>>>> As David suggested[1], this patch skips any such non-swap entries
>>>>> early. If any one is found, the scan is aborted immediately with the
>>>>> SCAN_PTE_NON_PRESENT result, as Lorenzo suggested[2], avoiding wasted
>>>>> work.
>>>>>
>>>>> [1] https://lore.kernel.org/linux-mm/7840f68e-7580-42cb-a7c8-1ba64fd6df69@redhat.com
>>>>> [2] https://lore.kernel.org/linux-mm/7df49fe7-c6b7-426a-8680-dcd55219c8bd@lucifer.local
>>>>>
>>>>> Suggested-by: David Hildenbrand <david@redhat.com>
>>>>> Suggested-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>>>>> Signed-off-by: Lance Yang <lance.yang@linux.dev>
>>>>> ---
>>>>> v1 -> v2:
>>>>> - Skip all non-present entries except swap entries (per David) thanks!
>>>>> - https://lore.kernel.org/linux-mm/20250924100207.28332-1-lance.yang@linux.dev/
>>>>>
>>>>> mm/khugepaged.c | 32 ++++++++++++++++++--------------
>>>>> 1 file changed, 18 insertions(+), 14 deletions(-)
>>>>>
>>>>> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
>>>>> index 7ab2d1a42df3..d0957648db19 100644
>>>>> --- a/mm/khugepaged.c
>>>>> +++ b/mm/khugepaged.c
>>>>> @@ -1284,7 +1284,23 @@ static int hpage_collapse_scan_pmd(struct mm_struct *mm,
>>>>> 	for (addr = start_addr, _pte = pte; _pte < pte + HPAGE_PMD_NR;
>>>>> 	     _pte++, addr += PAGE_SIZE) {
>>>>> 		pte_t pteval = ptep_get(_pte);
>>>>> -		if (is_swap_pte(pteval)) {
>>>>
>>>> It looks is_swap_pte() is mis-leading?
>>>
>>> Hmm.. not to me, IMO. is_swap_pte() just means:
>>>
>>> !pte_none(pte) && !pte_present(pte)
>>>
>>
>> Maybe it has some reason.
>>
>> I took another look into __collapse_huge_page_swapin(), which just check
>> is_swap_pte() before do_swap_page().

Thanks for pointing that out.

A function that is called __collapse_huge_page_swapin() and documented 
to "Bring missing pages in from swap" will handle other types as well.

Unbelievable horrible.

So let's think this through so we can document it in the changelog properly.

We could have currently ended up in do_swap_page() with

(1) Migration entries. We would have waited.

-> Maybe worth it to wait, maybe not. I suspect we don't stumble into
    that frequently such that we don't care. We could always unlock this
    separately later.


(2) Device-exclusive entries. We would have converted to non-exclusive.

-> See make_device_exclusive(), we cannot tolerate PMD entries and have
    to split them through FOLL_SPLIT_PMD. As popped up during a recent
    discussion, collapsing here is actually counter-productive, because
    the next conversion will PTE-map it again. (until recently, it would
    not have worked with large folios at all IIRC).

-> Ok to not collapse.

(3) Device-private entries. We would have migrated to RAM.

-> Device-private still does not support THPs, so collapsing right now 
just means that the next device access would split the folio again.

-> Ok to not collapse.

(4) HWPoison entries

-> Cannot collapse

(5) Markers

-> Cannot collapse


I suggest we add that in some form to the patch description, stating 
that we can unlock later what we really need, and not account it towards 
max_swap_ptes.

>>
>> We have filtered non-swap entries in hpage_collapse_scan_pmd(), but we drop
>> mmap lock before isolation. This looks we may have a chance to get non-swap
>> entry.
> 
> Thanks for pointing that out!
> 
> Yep, there is a theoretical window between dropping the mmap lock
> after the initial scan and re-acquiring it for isolation.
> 
>>
>> Do you think it is reasonable to add a non_swap_entry() check before
>> do_swap_page()?
> 
> However, that seems unlikely in practice. IMHO, the early check in
> hpage_collapse_scan_pmd() is sufficient for now, so I'd prefer to
> keep it as-is :)

I think we really should add that check, as per reasoning above.

I was looking into some possible races with uffd-wp being set before we 
enter do_swap_page(), but I think it might be okay (although very 
confusing).

-- 
Cheers

David / dhildenb


