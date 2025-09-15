Return-Path: <linux-kernel+bounces-816730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28C08B577B0
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 13:10:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D808F3ACF45
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 11:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBB372FC013;
	Mon, 15 Sep 2025 11:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DevQs4s5"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C7A2F618F
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 11:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757934631; cv=none; b=s1o25/LhQU/0F4QYnqVXlTylTekwprPxtVIu8CG3PkaF9/IiWeA3F7eFHBroYqhtaFYKZI2uEuqzv/PqsGbUNi0iaYenudGntpcszX5OKX2S4QYZd2+21FNjpdcFnZzUAPMJ7u3lThjLIBCqD0VfuC6bQw7ncqkGFvd+NRM4FB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757934631; c=relaxed/simple;
	bh=zTdqhsCkY8b8KFuRARbwA7YyFd47J97V0a/3yBq9UVo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PqtemmUMXNzxrcwv4w3QRoR8rTjDJU1xE6R9mLPzSBEdfTvV2R0X2hvY6cupQiR9CRt3UbWzE86o3OVgdPYVK4sdpHMTqK/il1Mm/cJWWB1b6wym9/mApepgnaZPezsPdpPkylih8AAkkJ6rjkYvbQmleXWtboQW7sAWHORQmjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DevQs4s5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757934628;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=/CAWql+JAQ14jPTZVQe0ITQlkc1jfaNDWNcoF73KKLg=;
	b=DevQs4s50DXw5YetJFo0L1iR6BHGuuahpYEfSIFI0oFA2Y0mraTTgUqJ0BAQYslzLUfR42
	Dkk6G6tjyCf+Biu3iwBoknnUusLQQy5I5dlKfPRIK0qhXVORzUFin0X2RlYdB9/v+A6XSI
	6Zb9mXaTNLxqbVKNfBo2cVThHBbAxUY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-179-jchX6Ox3NDCMu7Y6Y_G7rw-1; Mon, 15 Sep 2025 07:10:27 -0400
X-MC-Unique: jchX6Ox3NDCMu7Y6Y_G7rw-1
X-Mimecast-MFC-AGG-ID: jchX6Ox3NDCMu7Y6Y_G7rw_1757934626
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3e95627b120so892273f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 04:10:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757934626; x=1758539426;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/CAWql+JAQ14jPTZVQe0ITQlkc1jfaNDWNcoF73KKLg=;
        b=FaQT9RtL/Uf5mfba5PHXKv+SK68P1iT+VpRkJlRDG0AspVtFs5C8K8vPYQSH5nop91
         8pDe9invAHq6+MvYzRGYJwVSkJaL7g6BXUajYvJJZ+nZiFxZ+37SE//PXnxs2uvT7keI
         C7kqzgvQo87gr16tamnNWhMEQ+ZcuyMovQnaTafS/qwRmWIAUyqcnLKUczfxjUG6amHZ
         rOOw288jeb1Vdhdl4jOKIz7+zM1Q4e0z+qapaprOg03QXNRRARlRyTepUMna3WSR1ANj
         6E/nNUgpxTBLeXNAi3MCLh9bfmsD7U8XCie9PhjGbwY+6gCBSIuYZZw/WSrPhibMfPJm
         zMzg==
X-Forwarded-Encrypted: i=1; AJvYcCUQ3lbnWeSB0PHP2cLBWJ1tozvOyuWdQ0mmlbJ5NBbjz0tuq7H3K0DKrcJsqKExqFZ+BRw0DAygu02/D5A=@vger.kernel.org
X-Gm-Message-State: AOJu0YykM4HX2YoYcL83acqzmS8Q7xkiJLYk1RlaaxfuBs8MfIuhUpEY
	c2BFzDLkccQjIPD91SfiD6rCpkiHtGOx6Y5kQ5YB+IggBQQWUUhPxQPdIioK3xmEbTWRUkjKP2x
	JBbgxliJ0P7DW04BKlNedOvtg6arMaODGaT8kYKnvMHtfo37R8uKGoO79Rn6z+M7W2Q==
X-Gm-Gg: ASbGncuXh7cm5t3XjPSt2LguGA49yVj2qGv5jE6kcTKC1WuKMKZJiMrmVgRAt4tgKb8
	y7ke38QCBghRRyUtDrvBPU4OK1uIlJmtsreO8mkr3I+BtJj00Ph3CHqVdoJMRnVehUegkoU1fxd
	4G5xEQXAXARrRff1yfYFaUgIDPVlRtY+engB6a7iWLAiy2D4zqmksdtT9ag5MWdNO0xCEmvSEHu
	fJ1qGdgryVvqW+1MA6ncGSrsxvnMjRrs436HGacU3C0ND7ZKNyp6kGbzZFEdbPkeZaW/tayMDW6
	+kMiv5M0itt5itqSxLg1TSRC9IphAQckDKPKf7HrAydSdltYZOr5s/RysNPpHjFygpRGbWxziD7
	zdv2g5qB9ZM6L+3j0343Ir8y0YWZ/ByF+2XwYqDOY1q+gZ1zPtiKxdmPG+iL5KQgxvL4=
X-Received: by 2002:a05:6000:2005:b0:3e2:bbd1:e90a with SMTP id ffacd0b85a97d-3e7659c4dcdmr8167266f8f.37.1757934626122;
        Mon, 15 Sep 2025 04:10:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFTQVs1VB/MdL+atPfDHzXpL4rT+6Y4YLYWGCYu3x8Erf1i5OLLyh+BaEPetWMGx0DNJ4HYug==
X-Received: by 2002:a05:6000:2005:b0:3e2:bbd1:e90a with SMTP id ffacd0b85a97d-3e7659c4dcdmr8167245f8f.37.1757934625670;
        Mon, 15 Sep 2025 04:10:25 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f18:f900:e0ae:65d5:8bf8:8cfd? (p200300d82f18f900e0ae65d58bf88cfd.dip0.t-ipconnect.de. [2003:d8:2f18:f900:e0ae:65d5:8bf8:8cfd])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e8c7375fb7sm9147411f8f.14.2025.09.15.04.10.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Sep 2025 04:10:24 -0700 (PDT)
Message-ID: <1312fa3e-88dd-490a-9e07-9749c625933b@redhat.com>
Date: Mon, 15 Sep 2025 13:10:22 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 00/15] khugepaged: mTHP support
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Kiryl Shutsemau <kas@kernel.org>, Nico Pache <npache@redhat.com>,
 linux-mm@kvack.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, ziy@nvidia.com,
 baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com,
 ryan.roberts@arm.com, dev.jain@arm.com, corbet@lwn.net, rostedt@goodmis.org,
 mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 akpm@linux-foundation.org, baohua@kernel.org, willy@infradead.org,
 peterx@redhat.com, wangkefeng.wang@huawei.com, usamaarif642@gmail.com,
 sunnanyong@huawei.com, vishal.moola@gmail.com,
 thomas.hellstrom@linux.intel.com, yang@os.amperecomputing.com,
 aarcange@redhat.com, raquini@redhat.com, anshuman.khandual@arm.com,
 catalin.marinas@arm.com, tiwai@suse.de, will@kernel.org,
 dave.hansen@linux.intel.com, jack@suse.cz, cl@gentwo.org,
 jglisse@google.com, surenb@google.com, zokeefe@google.com,
 hannes@cmpxchg.org, rientjes@google.com, mhocko@suse.com,
 rdunlap@infradead.org, hughd@google.com, richard.weiyang@gmail.com,
 lance.yang@linux.dev, vbabka@suse.cz, rppt@kernel.org, jannh@google.com,
 pfalcato@suse.de
References: <ppzgohmkll7dbf2aiwhw7f4spf6kxjtwwe3djkx26pwy4ekrnd@mgeantq5sn2z>
 <d0e81c75-ad63-4e37-9948-3ae89bc94334@redhat.com>
 <CAA1CXcA+pb5KvEnJJqdf1eSjaFiBZ82MRB+KDmyhj3DbiQqOxg@mail.gmail.com>
 <enrgrocqajwu5d3x34voghja7pbvau45oobxgabawrly44ld4u@ahch3xn6rtq5>
 <cd8e7f1c-a563-4ae9-a0fb-b0d04a4c35b4@redhat.com>
 <2c5328ee-fb6e-45cf-a151-868cc8e7ff97@lucifer.local>
 <4508810d-7645-4f57-a0c5-2ee9f44206fc@lucifer.local>
 <34754ca4-fced-4a3c-8ff8-c00967d487de@redhat.com>
 <92352257-5be4-4aaa-b97f-c4e879ac6959@lucifer.local>
 <de3f5502-ef81-4f44-96a9-995e512301a3@redhat.com>
 <5099d9fe-4a07-4acd-95c8-782ffc74df37@lucifer.local>
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
In-Reply-To: <5099d9fe-4a07-4acd-95c8-782ffc74df37@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15.09.25 12:59, Lorenzo Stoakes wrote:
> On Mon, Sep 15, 2025 at 12:52:53PM +0200, David Hildenbrand wrote:
>> On 15.09.25 12:48, Lorenzo Stoakes wrote:
>>> On Mon, Sep 15, 2025 at 12:44:34PM +0200, David Hildenbrand wrote:
>>>>>>> Mapping that to actual THP sizes (#pages in a thp) on an arch will be easy.
>>>>>>
>>>>>> And at different mTHP levels too right?
>>>>>>
>>>>>
>>>>> Another point here, since we have to keep:
>>>>>
>>>>> /sys/kernel/mm/transparent_hugepage/khugepaged/max_ptes_none
>>>>>
>>>>> Around, and users will try to set values there, presumably we will now add:
>>>>>
>>>>> /sys/kernel/mm/transparent_hugepage/khugepaged/eagerness
>>>>>
>>>>> How will we map <-> the two tunables?
>>>>
>>>> Well, the easy case if someone updates eagerness, then we simply et it to
>>>> whatever magic value we compute and document.
>>>>
>>>> The other direction is more problematic, likely we'll simply warn and do
>>>> something reasonable (map it to whatever eagerness scale is closest or
>>>> simply indicate it as "-1" -- user intervened or sth like that)
>>>
>>> I don't love the idea of a -1 situation, as that's going to create some
>>> confusion.
>>
>> swapiness also has a "max" parameter, so we could just say "override" /"
>> disabled" / whatever?
> 
> I don't love the user being able to override this though, let's just nuke their
> ability to set this pleeeease.
> 
> Because if they can override it, then we have to do some deeply nasty scaling
> for mTHP again.

There are ways to have it working internally, just using a different 
"scale" instead of the 100 -> 50 -> 25 etc.

I am afraid we cannot change the parameter to ignore other values 
because of the interaction with the shrinker that easily .... we might 
be able to detracted at wait a bunch of kernel releases probably.

-- 
Cheers

David / dhildenb


