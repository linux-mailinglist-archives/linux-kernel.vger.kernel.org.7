Return-Path: <linux-kernel+bounces-850494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB51EBD2FAA
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 14:32:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58F8F3C55C2
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 12:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DFBE264F9F;
	Mon, 13 Oct 2025 12:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UDWRACod"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC1F327732
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 12:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760358704; cv=none; b=Wbpsc8EiAYf/iCs50QIMyl2bEL7dnJSsC2mAZ51HABhJYXnHK/5mMeqFh+8HbgU74kTHTOrAylEPaNn5l0n3eMbLgSEq8VEVV48w78ShMEUXuN2Dcur/KX9lgKLAndih3KG6WmgFEoeSrnOX5OREGMmjrBkXgWXjlHvMy8+gQ6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760358704; c=relaxed/simple;
	bh=aLIYcFa7UxscQgcjQ0eNijAq6ndbZdSSSR6fkKvSbXw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eBekvb2vNHRgb80yORR/gCi/3XQPSMIs00esTINHeyIHBDTIsLc1N16cA6NjyP/Jg7U/eEUpuG1enkA4IsaG5FhsAjym4RruRTTuUYmUuP04SUts1g/054QeSZf2tIs885uqzeSZmqjXLDrmc1PkWWcPn1DwZYx2AdQ612h3370=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UDWRACod; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760358701;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=8dwWTFnY01JMgC2QZA9VOzV/hbuJXScWrhj4pWb1ZI0=;
	b=UDWRACodHEaMgoMazZNTXdzqwdi8oZVMWVwoVMCwf789rhjxn4vlcuwJNvymYFwdUoQNBD
	pYVQJ6hKi0V7GucssyP97cmAwhRD1KNfTArWmzj9LJ7VPHPb0+b/HNt/Q52ipx6J+5lyYY
	303KpDkxEh1HToIr4epQrS3S+XH9DR8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516-CFQlNKfUMEOcInJjPc-gFA-1; Mon, 13 Oct 2025 08:31:39 -0400
X-MC-Unique: CFQlNKfUMEOcInJjPc-gFA-1
X-Mimecast-MFC-AGG-ID: CFQlNKfUMEOcInJjPc-gFA_1760358698
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-42558f501adso3295641f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 05:31:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760358698; x=1760963498;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8dwWTFnY01JMgC2QZA9VOzV/hbuJXScWrhj4pWb1ZI0=;
        b=nQNQEjQYa7ijVzKBMiOUVGS6qTVeG2Mf3EdBMdaX8M5Ezsnv3YYMbgMcUrrj1SMQPn
         Vlda+I4dRbzs6c+jQCPTjnVmRcJX1wI8x5etjmmo1xI0scx7otyWVYQvrVAxsF2zmljc
         zmq6CxEaFGcRTOq+HSmK9yhYc13itEl9S+k/wzJGsJaDKc6WKEiLc3aOHmohwT3CxKqZ
         6eEESpsxPTMZNKZF/8210yM0C1XXD0yfqQJ06GOJ8gigP8JPpdF28AK4R9NJqcvUfJ8o
         Ah6pNleSQEInxWhLjGxp77VmhAm3jniRpEv8czaV+9hbSv7y7nFFDjO8bvQgn3xYiIQq
         J0Qw==
X-Forwarded-Encrypted: i=1; AJvYcCXI5uK43t5rHnOoqkIVXeeew5T/2jjO4R83MIEQ0bIUVaTpVB8zr9fkizu6jBgNMW3Os9DyVdnE/FXpYXE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsSsX1gqcq9X/hqnehWdcEO9vu1PjG4vjFJ6t2coMkxYpklIEY
	gWoiyCwJCOcQRAYdqXvfXsYjcu1Z4puCmMRV4J5dATLczXEVnisWy12h8+zzW1pRtWjwpYJ86VQ
	unOZumnsq+hmLmRm4mdTjQ1XWb1zwFPsDWQGOf9leFh4BtrQaJnwsWVqL7hjmTZWMWQ==
X-Gm-Gg: ASbGncsCqIAMwUVnzmHCiXRCK2AgaCpuZrmmV8fXALM2d1v7Pk/85J2Zq++H2OPJ2P+
	N5NRXM1oA8xiMnhpyJxukUVk2G8FrfvGA2f4pT49rJoFAwxAd8E8IFR+jc/OaS39Smr1fubzGVe
	T7mu1F5BodqPXvob+cq1cXbUqzwu45Z5EVcmiHhsTBeSWf4yd/nntWD1B63E76r3QBlkAdGVW91
	kzd+F91LEMBtBxlV5wwC8ljZv53xvyCqLrN6XT4Y48tXm2DmbWqoUTT5B7CJiToRkKo2PxMcIaJ
	DL1xoeCM7U0FFoiXhreEtFF01t4s8/IkmmqH1Cl11PDTSkw4PtPYOuk5D/f41TXbEIxyK5jktVv
	a4Aw=
X-Received: by 2002:a05:6000:25c6:b0:3fa:5925:4b11 with SMTP id ffacd0b85a97d-4266e8dd4a0mr13112711f8f.42.1760358698272;
        Mon, 13 Oct 2025 05:31:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH+rKhnncBM0Pv8kGyJiO+9pTdjKjpw6DAdSdAl+kaHZP46I4ToxAgGKi/qAMrrlAgZkXO50w==
X-Received: by 2002:a05:6000:25c6:b0:3fa:5925:4b11 with SMTP id ffacd0b85a97d-4266e8dd4a0mr13112679f8f.42.1760358697872;
        Mon, 13 Oct 2025 05:31:37 -0700 (PDT)
Received: from [192.168.3.141] (tmo-083-189.customers.d1-online.com. [80.187.83.189])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5e1284sm18037134f8f.45.2025.10.13.05.31.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Oct 2025 05:31:37 -0700 (PDT)
Message-ID: <dfc18351-bb77-4099-bcdd-eb2bd4f1bea5@redhat.com>
Date: Mon, 13 Oct 2025 14:31:35 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC RFC PATCH] mm: convert VM flags from macros to enum
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Ye Liu <ye.liu@linux.dev>, Andrew Morton <akpm@linux-foundation.org>,
 Ye Liu <liuye@kylinos.cn>, "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20251011093054.886460-1-ye.liu@linux.dev>
 <809f552d-3282-4746-ba49-066d2bd8d44f@lucifer.local>
 <7ca0960f-9d1a-4ba4-b074-a6502578b82e@redhat.com>
 <d619784b-b967-4795-aad9-6e79d4191b83@lucifer.local>
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
In-Reply-To: <d619784b-b967-4795-aad9-6e79d4191b83@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13.10.25 13:33, Lorenzo Stoakes wrote:
> On Mon, Oct 13, 2025 at 01:12:20PM +0200, David Hildenbrand wrote:
>> On 13.10.25 13:04, Lorenzo Stoakes wrote:
>>> On Sat, Oct 11, 2025 at 05:30:52PM +0800, Ye Liu wrote:
>>>> From: Ye Liu <liuye@kylinos.cn>
>>>>
>>>> Hello MM maintainers and drgn community,
>>>>
>>>> This RFC proposes to convert VM_* flags from #define macros to enum
>>>> vm_flags. The motivation comes from recent drgn development where we
>>>> encountered difficulties in implementing VM flag parsing due to the
>>>> current macro-based approach.
>>>
>>> This isn't going to work sorry, it's not valid to have flag values as an enum
>>
>> I don't follow, can you elaborate? IIRC, the compiler will use an integer
>> type to back the enum that will fit all values.
> 
> switch (flags) {
> 	case VAL1:
> 	case VAL2:
> 	etc.
> }
> 
> Is broken (compiler will say you cover all cases when you don't...)

I assume you mean theoretically, because there is no such code, right?

> 
> An enum implies independent values that exhaustively describe all state, however
> these flag values are not that - they're intended to be bit fields.
> 

Observe how we use an enum for FOLL_* flags, vm_fault_reason, fault_flag 
and probably other things.

But more importantly,

enum pageflags { ... :)

-- 
Cheers

David / dhildenb


