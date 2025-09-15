Return-Path: <linux-kernel+bounces-816801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A7F37B5786D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 13:35:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C94791A24B6A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 11:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0D9F3019BE;
	Mon, 15 Sep 2025 11:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LK64fq/z"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 174F330148A
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 11:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757935772; cv=none; b=YKJS7wpbMq1f5JtDI2zpIcjI628A56HpZpGm3FycYKXvCYeXwbEvyeMh3qBsAqe2QU68AjlnGsTsD7lK+yWzLzL4YT7OzJCf1LHIUQZopSD78JFuxFAO8Mnc6b3NsAdFxAt6vsHdYWr9ZXS+m8kNJZEkO9Ybd4EPgR7xIT+hH9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757935772; c=relaxed/simple;
	bh=Kbm0ksDgoO9tgM5t54Hfg8uiuJWJuntpshuy6EIjCcE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XEm/8Tg/AtZdeuntBYLLdDS6qBizhtDSjwOtyJQCNEhRcrflQ+WNJfChjlWBOVee3r2MF7LuKnboBcV4R4uSD6VcBftbUqwsWgA5v9JoyB5gWLkgBdFTHnfoOGx0JYQrkHZjugw1NVgRiskrcsBa8GE4MOAWjJVhrIwgJIDVoDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LK64fq/z; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757935770;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=T3c8/ma9rmwVpnwsDyCojdkiFtcRxll8GhUqHuOo1hY=;
	b=LK64fq/z+rOWskCzgobYtM2Z2HHGtmdn9JoPNYgieZRG4adUbYzwYBKHsrVAijYTIQKK7J
	V0Lhew3fHaw40wjNBpU7ngY0A6Djjnw6oPTvTagIf75nSywSqBI7tAHbwudf7C5vIWhV7J
	UGy3QmXgYKAnArUlPl8nyPeiDG6nGpE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-445-dqTzsJj0POiFrc6BIq3I1g-1; Mon, 15 Sep 2025 07:29:28 -0400
X-MC-Unique: dqTzsJj0POiFrc6BIq3I1g-1
X-Mimecast-MFC-AGG-ID: dqTzsJj0POiFrc6BIq3I1g_1757935767
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-45f2f1a650dso4189255e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 04:29:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757935767; x=1758540567;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T3c8/ma9rmwVpnwsDyCojdkiFtcRxll8GhUqHuOo1hY=;
        b=bKHm9MRJt6fH0tejm7wA4FytgCFJdOgdvVn1LDSfWWkTgSB1RxpUCGgYJWuinOrFNM
         REz7q+xHBNwBamdzg9fyi484ZVND0A+pTM9UHIGbi8CK0XlMwgrsVW13UeBiELQeJKxb
         +vxZ6GPLKxiiK0TRTOgTb9c+EgtQj0xx6/MbBNBwp4RuxA0kuaBWPCRcmNQGy64MxI3F
         wpBCsoThQQpIgNdTQdQi2YYwzyLIEFzZSLrMCZ7OeIxMBSxK97Dpwi9iH8RjhkAq+HwE
         GbNpWAPs/NueTcLD9ovZwYtDX4lT6rKM6QZKbVhFN6OqYcFLNxmdC1tpcfZwOIKsLUq7
         B/RA==
X-Forwarded-Encrypted: i=1; AJvYcCUq8y1CWwWggSM9rDJtWxiQ+s5AoygpEfsaAhJVSXuqhrgcTldjQavzPt13BkbNtN08vgI3vMeWj1lVzic=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrZeJAVYlDLKFK5nSyZMh83nBxXPALc1mVrpqW58RdxW64xqrr
	DgfK9KrFdHLYPzUXcZfY+IIdTEq7C/4x8sV3ffDfdVnLtekjpz4KHcGs6oA9ZrcpsEr3lHIwbrx
	QDM2W2pSxJ4yqm7YOTwI/j78II/hoGzb7GZ5OWmhUux9qEJiCb3IQydXaHyKiu3opdw==
X-Gm-Gg: ASbGncu+lB/sKZTJ07eywxDzW4XyiMMg+uhHSbxVJIdcPyDfyVvYtBPuEdLwYsnobAt
	8xVzv53JT0hemzCiwKqXmyw/Nj+mdbIeTHamf0GfWr33f4LidDptYWcMG+JY36r7/Euepbk0C8q
	LMMV85UobuIhUnsgt3rxuO1w4zYKm1RsWLo+3j0jpNGXLeluznjrZXFyvmHb7dc4wJpTLKZz9sD
	ByHG0yW0Ro1QJUJC84o7AWa+Z89L6jUqyEa610LbX+aMeYCXj9rGU+bbWFrsUbU4zlzxsHR5rn+
	SezFcjf0pJ5opUbeuupf9kTmnbqzKSSK9qbwkWsX0WzQO10mzqXi4v/PUoJhyr2J5NfadFu61Km
	5GQ+wSEBjgRTsyd1F0cKnLjUOqzYToVvv9w7gY2msbJqUNE8ZnHCfM4h0/IB5XHiYEcc=
X-Received: by 2002:a05:600c:12c8:b0:459:d645:bff7 with SMTP id 5b1f17b1804b1-45f211d075emr77848255e9.12.1757935766930;
        Mon, 15 Sep 2025 04:29:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHXwSZAmD9XxC8mSwauh0HqDNFoXO/t7RfP7K5UEy8I9vZ6KWWwB8fAmEU7M97ekmJeVjPdJg==
X-Received: by 2002:a05:600c:12c8:b0:459:d645:bff7 with SMTP id 5b1f17b1804b1-45f211d075emr77847905e9.12.1757935766402;
        Mon, 15 Sep 2025 04:29:26 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f18:f900:e0ae:65d5:8bf8:8cfd? (p200300d82f18f900e0ae65d58bf88cfd.dip0.t-ipconnect.de. [2003:d8:2f18:f900:e0ae:65d5:8bf8:8cfd])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e017b3137sm180607445e9.19.2025.09.15.04.29.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Sep 2025 04:29:25 -0700 (PDT)
Message-ID: <a48c8d89-da30-4a7d-96f6-e5e17757b818@redhat.com>
Date: Mon, 15 Sep 2025 13:29:22 +0200
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
 <d0e81c75-ad63-4e37-9948-3ae89bc94334@redhat.com>
 <CAA1CXcA+pb5KvEnJJqdf1eSjaFiBZ82MRB+KDmyhj3DbiQqOxg@mail.gmail.com>
 <enrgrocqajwu5d3x34voghja7pbvau45oobxgabawrly44ld4u@ahch3xn6rtq5>
 <cd8e7f1c-a563-4ae9-a0fb-b0d04a4c35b4@redhat.com>
 <155c821d-402c-4627-a723-6f8c88a2f65c@lucifer.local>
 <ae9d88e2-bab9-49fc-a459-d7b9a8fe9351@redhat.com>
 <ff4b6935-fd13-478e-9187-219fb612aac3@lucifer.local>
 <e450009a-56c9-4820-bd0c-da1d782d3962@redhat.com>
 <2757fb07-78bf-4a39-8c60-8ca8be200994@lucifer.local>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <2757fb07-78bf-4a39-8c60-8ca8be200994@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15.09.25 13:23, Lorenzo Stoakes wrote:
> On Mon, Sep 15, 2025 at 01:14:32PM +0200, David Hildenbrand wrote:
>> On 15.09.25 13:02, Lorenzo Stoakes wrote:
>>> On Mon, Sep 15, 2025 at 12:52:03PM +0200, David Hildenbrand wrote:
>>>> On 15.09.25 12:43, Lorenzo Stoakes wrote:
>>>>> On Mon, Sep 15, 2025 at 12:22:07PM +0200, David Hildenbrand wrote:
>>>>>>
>>>>>> 0 -> ~100% used (~0% none)
>>>>>> 1 -> ~50% used (~50% none)
>>>>>> 2 -> ~25% used (~75% none)
>>>>>> 3 -> ~12.5% used (~87.5% none)
>>>>>> 4 -> ~11.25% used (~88,75% none)
>>>>>> ...
>>>>>> 10 -> ~0% used (~100% none)
>>>>>
>>>>> Oh and shouldn't this be inverted?
>>>>>
>>>>> 0 eagerness = we eat up all none PTE entries? Isn't that pretty eager? :P
>>>>> 10 eagerness = we aren't eager to eat up none PTE entries at all?
>>>>>
>>>>> Or am I being dumb here?
>>>>
>>>> Good question.
>>>>
>>>> For swappiness it's: 0 -> no swap (conservative)
>>>>
>>>> So intuitively I assumed: 0 -> no pte_none (conservative)
>>>>
>>>> You're the native speaker, so you tell me :)
>>>
>>> To me this is about 'eagerness to consume empty PTE entries' so 10 is more
>>> eager, 0 is not eager at all, i.e. inversion of what you suggest :)
>>
>> Just so we are on the same page: it is about "eagerness to collapse", right?
>>
>> Wouldn't a 0 mean "I am not eager, I will not waste any memory, I am very
>> careful and bail out on any pte_none" vs. 10 meaning "I am very eager, I
>> will collapse no matter what I find in the page table, waste as much memory
>> as I want"?
> 
> Yeah, this is my understanding of your scale, or is my understanding also
> inverted? :)
> 
> Right now it's:
> 
> eagerness max_ptes_none
> 
> 0 -> 511
> ...
> 10 -> 0
> 
> Right?

Just so we are on the same page, this is what I had:

0 -> ~100% used (~0% none)

So "0" -> 0 pte_none or 512 used.

(note the used vs. none)

-- 
Cheers

David / dhildenb


