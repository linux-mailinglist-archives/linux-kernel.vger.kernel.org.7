Return-Path: <linux-kernel+bounces-814567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D588BB555A4
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 19:53:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7115D4E0206
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 17:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2206D329F13;
	Fri, 12 Sep 2025 17:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c3PBUW6S"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4521730DED0
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 17:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757699612; cv=none; b=d3SAXQ79tcDUfw5sujAJq0unjtqPdUQ5Y9FhoCTnyb7ZcAQ+Y8ZOf6evuZOvxniE6LQmtT/SkHkLdW53NYJZsCSsNfap1CtfD5lrUllu11ullGztABuWEL9CfSbayoimFfKYtWqQnnmjH0tHIJaIQKXfR8mYfdQxa5QbNs1fsrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757699612; c=relaxed/simple;
	bh=eb3P4Y2a7fEPFMxbLKxl8jSsdcS3SIyS1X+Y/7z8lHw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=atePb37prLzA007k1couHfzDH0ktOM7x8UG+pQIK8W0Pboj37MpQBi2PNu690xoNS5nmPGj4rJElhpAvTNByKssAL8kdq8RCkbIXUxKQBgMwi1AaeGymWdnLYypRDwU2dB0jwVPZ6BZVWgVZ2dnBExXrwJjB2BGLfOfW4618FEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c3PBUW6S; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757699609;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=GWaQp0kZeJAdEBYzp9zyFZzreyIaLb6taNvlZ6KnZNg=;
	b=c3PBUW6SvNIfGA/WxS+jlWLefUy6t1jXL7obEtFSTwnh3hUFOM8C9lf479B7pj3TymjKZn
	k1LzQu4sWHS/ghO1wgeylj5191z1KL4OAPR8HOkZ4blEc0rNW0cTnekJHWryaPrEGxzL06
	ldporLL1Tdwm+fJxSCGg03mQ2AUMDqY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-77-WMHj1JrvOgKo8Y_kgKlOEA-1; Fri, 12 Sep 2025 13:53:27 -0400
X-MC-Unique: WMHj1JrvOgKo8Y_kgKlOEA-1
X-Mimecast-MFC-AGG-ID: WMHj1JrvOgKo8Y_kgKlOEA_1757699607
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-45df9e11fc6so13094305e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 10:53:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757699606; x=1758304406;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GWaQp0kZeJAdEBYzp9zyFZzreyIaLb6taNvlZ6KnZNg=;
        b=cstJdoH833y4gT9ICnE0pcZuXIWhakxnhKi+kjvaoDxs++rx6w2j9NXYh1p1NFqpLB
         BBuwpLPGNJWP1OP0d71DrSN7GdYqiavcYW+vig9pRT+XgvyoMY9TIpQbrEq4BhXMuv70
         94qXfvQ1P08bXcnEdeGUMDBK2U3f+cl/odm73H5ev5FGZXMNTYQNeiDW2b/Gh0zBFlqu
         CGWJkaa0gxTAyKEb1wzp141FfyuMZBVcVq7CyfVBK9YR/D3xRBKb74AcyBTkgmNeg718
         9VUE0N+tVP85kS/G4NXYqZpFKNGQwX7EvrcY2GqKxHezb+Qd/FQo7wPjZip5SB2T3d1I
         QL1w==
X-Forwarded-Encrypted: i=1; AJvYcCWsJGfXrPTu0fR4hof4aqP+/EehmS9mtJLB5S5+Qy6sRNzRBJwqj3nemb7vnxVmidJSrM6zj1JKmiWmH7c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4VAKCRqLdWsEZO0E47g9L0YVh72ANCZP2vWTu03+KSQdWqP6Q
	uWS5wOpD5QVMer8gCfDgKm0rehD2PZT7Cqq8yPMf2UGTL3giuCwhOV1zBTk/UGA5gjzzizerlQh
	FcVLz+WVKTT6As3xUYdTUARRAUIdohlxYwEMpa6KX/9S3Avgqdd1SIZex1L/02Q0qOg==
X-Gm-Gg: ASbGncuNU69rpv//o531YB7psQP1QHtgk3ujCujErpDxWc8YfeCzCYU9VxXjsOQfkOu
	Bo0lOZKmvcyBKAh4h2EGa9DmETWzh8oONHLVeOq3fwK6egYdVdk8med2ezca9WPEjWA892vbw34
	4GL+cJg6D4dN4osbHzjK/CKAl+2c58FJa9VR2v3qsBiF1DL7NZJ202VlbCkQxMjXqP+lQzqJcP+
	OI0hrGmqjrH8OZLJIuX3moyKQrAdeGCx9yhfADWN0J7hbauB33WupQdEscHpFIGEbvAALyjjfWA
	C7QxGrgBkCf79Sx9saXw2bLVx7SwywvbCSJec+6rthDAsgwI3XK7K1+wHbGlKtZEauDn7mvAE/Z
	aXJO+cRY12g2vOvWT/iVl1qbAWbVpiCQL6DwJqLyJsvkTdPyD4in/kwF8xUwsE1QuBPk=
X-Received: by 2002:a05:600c:8a1b:20b0:45d:d3a1:70dd with SMTP id 5b1f17b1804b1-45f21221e50mr29826075e9.35.1757699606572;
        Fri, 12 Sep 2025 10:53:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEnvTRCdvZUrWLKVO8/YsaHIQ6vlWYzWujC55SFweNtk2eP8Jx1ikBkDI8/I9BWLAS+Y/KDYg==
X-Received: by 2002:a05:600c:8a1b:20b0:45d:d3a1:70dd with SMTP id 5b1f17b1804b1-45f21221e50mr29825535e9.35.1757699606102;
        Fri, 12 Sep 2025 10:53:26 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f20:da00:b70a:d502:3b51:1f2d? (p200300d82f20da00b70ad5023b511f2d.dip0.t-ipconnect.de. [2003:d8:2f20:da00:b70a:d502:3b51:1f2d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e0157cc84sm36555805e9.7.2025.09.12.10.53.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 10:53:25 -0700 (PDT)
Message-ID: <ed784d6c-6c2a-4e0b-ad2f-e953bf310ce8@redhat.com>
Date: Fri, 12 Sep 2025 19:53:22 +0200
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
References: <20250912032810.197475-1-npache@redhat.com>
 <ppzgohmkll7dbf2aiwhw7f4spf6kxjtwwe3djkx26pwy4ekrnd@mgeantq5sn2z>
 <43f42d9d-f814-4b54-91a6-3073f7c7cedf@redhat.com>
 <ab8c2e03-53fb-402c-a674-c2c6ab11f54e@redhat.com>
 <rapl4xr55zv2nq3jh5ulk4wvfyxa2kmbnnb4uram6q43y4cbwn@dv5m52ocyqne>
 <80c50bf4-27b1-483c-9977-2519369c2630@redhat.com>
 <7ri4u7uxsv6elyohqiq2w5oxv4yhk2tyniwglfxtiueiyofb3n@l4exlmlf5ty4>
 <59641180-a0d9-400c-aaeb-0c9e93954bf5@redhat.com>
 <c5bcecb8-13e7-4db5-849e-2120c69b2af5@lucifer.local>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <c5bcecb8-13e7-4db5-849e-2120c69b2af5@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12.09.25 17:51, Lorenzo Stoakes wrote:
> On Fri, Sep 12, 2025 at 05:45:26PM +0200, David Hildenbrand wrote:
>> On 12.09.25 17:41, Kiryl Shutsemau wrote:
>>> On Fri, Sep 12, 2025 at 04:56:47PM +0200, David Hildenbrand wrote:
>>>> On 12.09.25 16:35, Kiryl Shutsemau wrote:
>>>>> On Fri, Sep 12, 2025 at 04:28:09PM +0200, David Hildenbrand wrote:
>>>>>> On 12.09.25 15:47, David Hildenbrand wrote:
>>>>>>> On 12.09.25 14:19, Kiryl Shutsemau wrote:
>>>>>>>> On Thu, Sep 11, 2025 at 09:27:55PM -0600, Nico Pache wrote:
>>>>>>>>> The following series provides khugepaged with the capability to collapse
>>>>>>>>> anonymous memory regions to mTHPs.
>>>>>>>>>
>>>>>>>>> To achieve this we generalize the khugepaged functions to no longer depend
>>>>>>>>> on PMD_ORDER. Then during the PMD scan, we use a bitmap to track individual
>>>>>>>>> pages that are occupied (!none/zero). After the PMD scan is done, we do
>>>>>>>>> binary recursion on the bitmap to find the optimal mTHP sizes for the PMD
>>>>>>>>> range. The restriction on max_ptes_none is removed during the scan, to make
>>>>>>>>> sure we account for the whole PMD range. When no mTHP size is enabled, the
>>>>>>>>> legacy behavior of khugepaged is maintained. max_ptes_none will be scaled
>>>>>>>>> by the attempted collapse order to determine how full a mTHP must be to be
>>>>>>>>> eligible for the collapse to occur. If a mTHP collapse is attempted, but
>>>>>>>>> contains swapped out, or shared pages, we don't perform the collapse. It is
>>>>>>>>> now also possible to collapse to mTHPs without requiring the PMD THP size
>>>>>>>>> to be enabled.
>>>>>>>>>
>>>>>>>>> When enabling (m)THP sizes, if max_ptes_none >= HPAGE_PMD_NR/2 (255 on
>>>>>>>>> 4K page size), it will be automatically capped to HPAGE_PMD_NR/2 - 1 for
>>>>>>>>> mTHP collapses to prevent collapse "creep" behavior. This prevents
>>>>>>>>> constantly promoting mTHPs to the next available size, which would occur
>>>>>>>>> because a collapse introduces more non-zero pages that would satisfy the
>>>>>>>>> promotion condition on subsequent scans.
>>>>>>>>
>>>>>>>> Hm. Maybe instead of capping at HPAGE_PMD_NR/2 - 1 we can count
>>>>>>>> all-zeros 4k as none_or_zero? It mirrors the logic of shrinker.
>>>>>>>
>>>>>>> BTW, I thought further about this and I agree: if we count zero-filled
>>>>>>> pages towards none_or_zero one we can avoid the "creep" problem.
>>>>>>>
>>>>>>> The scanning-for-zero part is rather nasty, though.
>>>>>>
>>>>>> Aaand, thinking again from the other direction, this would mean that just
>>>>>> because pages became zero after some time that we would no longer collapse
>>>>>> because none_or_zero would then be higher. Hm ....
>>>>>>
>>>>>> How I hate all of this so very very much :)
>>>>>
>>>>> This is not new. Shrinker has the same problem: it cannot distinguish
>>>>> between hot 4k that happened to be zero from the 4k that is there just
>>>>> because of we faulted in 2M a time.
>>>>
>>>> Right. And so far that problem is isolated to the shrinker.
>>>>
>>>> To me so far "none_or_zero" really meant "will I consume more memory when
>>>> collapsing". That's not true for zero-filled pages, obviously.
>>>
>>> Well, KSM can reclaim these zero-filled memory until we collapse it.
>>
>> KSM is used so rarely (for good reasons) that I would never ever build an
>> argument based on its existence :P
>>
>> But yes: during the very first shrinker discussion I raised that KSM can do
>> the same thing. Obviously that was not good enough.
>>
>> --
>> Cheers
>>
>> David / dhildenb
>>
> 
> With all this stuff said, do we have an actual plan for what we intend to do
> _now_?

Oh no, no I have to use my brain and it's Friday evening.

> 
> As Nico has implemented a basic solution here that we all seem to agree is not
> what we want.
> 
> Without needing special new hardware or major reworks, what would this parameter
> look like?
> 
> What would the heuristics be? What about the eagerness scales?
> 
> I'm but a simple kernel developer, 

:)

and interested in simple pragmatic stuff :)
> do you have a plan right now David?

Ehm, if you ask me that way ...

> 
> Maybe we can start with something simple like a rough percentage per eagerness
> entry that then gets scaled based on utilisation?

... I think we should probably:

1) Start with something very simple for mTHP that doesn't lock us into any particular direction.

2) Add an "eagerness" parameter with fixed scale and use that for mTHP as well

3) Improve that "eagerness" algorithm using a dynamic scale or #whatever

4) Solve world peace and world hunger

5) Connect it all to memory pressure / reclaim / shrinker / heuristics / hw hotness / #whatever


I maintain my initial position that just using

max_ptes_none == 511 -> collapse mTHP always
max_ptes_none != 511 -> collapse mTHP only if we all PTEs are non-none/zero

As a starting point is probably simple and best, and likely leaves room for any
changes later.


Of course, we could do what Nico is proposing here, as 1) and change it all later.

It's just when it comes to documenting all that stuff in patch #15 that I feel like
"alright, we shouldn't be doing it longterm like that, so let's not make anybody
depend on any weird behavior here by over-domenting it".

I mean

"
+To prevent "creeping" behavior where collapses continuously promote to larger
+orders, if max_ptes_none >= HPAGE_PMD_NR/2 (255 on 4K page size), it is
+capped to HPAGE_PMD_NR/2 - 1 for mTHP collapses. This is due to the fact
+that introducing more than half of the pages to be non-zero it will always
+satisfy the eligibility check on the next scan and the region will be collapse.
"

Is just way, way to detailed.

I would just say "The kernel might decide to use a more conservative approach
when collapsing smaller THPs" etc.


Thoughts?

-- 
Cheers

David / dhildenb


