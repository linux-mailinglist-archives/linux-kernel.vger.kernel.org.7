Return-Path: <linux-kernel+bounces-748218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E54CAB13E01
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 17:15:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07500189FA6C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 15:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EFE52737FF;
	Mon, 28 Jul 2025 15:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i12jXtjY"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C11271456
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 15:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753715710; cv=none; b=g0yGFAIPJW3fPRUB30/gasdXaWB1VfYEhak6cEaeX7vmSwY+kcblrWBVw6xo/EKXjNg9p3k/ES77HpBp7HrKe4QSGJEyc0TdWvrMCh07KOszpw1n7zIeDYcpvJe7mJyNVlmf1WH62yrF2nYfwnOPidbDpUz65pFy0mPOYxqBMyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753715710; c=relaxed/simple;
	bh=bVEUEruTA04cqUCuVkdAjMIqDFpt+gMGh8+t8uN2bkc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e1QFJfFylNfKeCDwlFWO+unqCZrs3BOmfjSQTmtC8MtO5ivOxay8xKZt+RWf2UNoeeWCD6OVivVpcgYLzYHaCX840Hb5v7sEEavxYn0UQHisY5hUEXJQxl7Pu+LV/thICSGHEJNRL1ukEnIgMjf82ALxXKD6BXbCui3DaB3gBKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i12jXtjY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753715707;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=cFu6x9LoVQ1xdj0Ds1jK1/RRFvn+MmOixRu+6RDQgAk=;
	b=i12jXtjYUt0/u7lEJ1sb1Ts8WtkSX56CwudRjRjUJdRwaQLG+KAm1BNfC0BtL7/41j91AQ
	pzn+ss8U8zxj65xNpttRm5ZxL7Vb8+JwgYzfdNuqrB6P2R39NM+zenslpZurX/3zFs0OUx
	m/3gueGrNcGZqLu2K5N0ccTup5PdPPI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-599-IJ3JKQgPPiecbb3hdvzl2g-1; Mon, 28 Jul 2025 11:15:05 -0400
X-MC-Unique: IJ3JKQgPPiecbb3hdvzl2g-1
X-Mimecast-MFC-AGG-ID: IJ3JKQgPPiecbb3hdvzl2g_1753715704
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-45611579300so30903695e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 08:15:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753715704; x=1754320504;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cFu6x9LoVQ1xdj0Ds1jK1/RRFvn+MmOixRu+6RDQgAk=;
        b=F9zotDlBhu53AE96pkljRMK1e/atf2RhvZ2HG8NvV5Wg6P5lJ1iqcSG272ipflH8PT
         X1qXk7OTB4Bxb7XoCjD90+JGhwsxom7K+RVO+3HkAhErEh6L0ZZeydUUBnsBpPkOSumY
         rbce+/9nRD/HqdAZY4b8KUPsC0eduYBA4fGrxQWGpxNLFkAUtVqaTlpSqnKNAvuXg6EE
         qqqkWCprtLC3TFgn4kXe1YngHJH1227kUu94tAUx1mdkNivuGDRMaMytDu1Bl38uBffr
         6ePvMeZs7kvFvv9B9NcvFk9PcktslmzJw4MjVhVciSabaRLFg6I5T/D8wFU/JMuNmvt1
         kfaA==
X-Forwarded-Encrypted: i=1; AJvYcCU9oOcESZnLxNDZzwuy7MNhk1wK9yfZhwX7X6Japf1JkJBbQeJZiPu5Xub2OSUMi7CHnMHV/wJVcpOqFYI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgtOG3D6EAAbNqIq21qOpmsTJHslxRfpj9H3qvLsm+aMmizXkC
	iAuXcc4/kwQsRugrhzORTRrOOAg68Hpvhzah//6mBwmQIfqi5zaWZDssPAEoOBHGwURTP8KCK/J
	ILW3z7npGxNhT5lY/63EVzAxyZP8G4Uo62t7X9u+M4SMSSYO1xvhQV0sTgECz2rtyvg==
X-Gm-Gg: ASbGnctbvX610Std2dsxfDPYR3ZM8fnBDQuegewgEvDQnlC7zmykngLGmxw0qndC+6w
	hBe/0oQOOxAlxaf0oCqwDXjDaJPHOProAKaUradRUldPU4hXOIMhMyEy+gI9jfAlLmb891Fl66K
	vBoazCHUk/iCJebI/dyZIfguK/VK9HNdlImhGCKl3MWHimwUIYO1OFoS+/rl9NXHC4AyZnp8T83
	eJxuydiSE7JNC+LPGh9lrHJrCTKi5J6Cp9CTIgsPSFI0EIaigTCWN5GsdFqs1bO58jG/IvYzUsR
	+1FInWnzNMjALYfmAoUnaGwxLAltPh7cHfvQrqFECSM4hyBq59u1570pj+9rBF27VrIlwJzLBU/
	PZmp8GbG7UVqQEAdO9b2ZYBcYw9ee4Q/eXslokbrrD+zLcZwbtzOW4bb3qytjAXv4aIg=
X-Received: by 2002:a05:600c:1c94:b0:456:1442:86e with SMTP id 5b1f17b1804b1-4587911e78amr76809085e9.21.1753715704250;
        Mon, 28 Jul 2025 08:15:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEYgLa7yl+fyDCD5pCKzn8BbvKweRCfmV2xlQtPD8ua6fwJTJSoqSSEdQnuHq68gLQ0j11fEQ==
X-Received: by 2002:a05:600c:1c94:b0:456:1442:86e with SMTP id 5b1f17b1804b1-4587911e78amr76808825e9.21.1753715703645;
        Mon, 28 Jul 2025 08:15:03 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f47:2b00:c5f3:4053:2918:d17c? (p200300d82f472b00c5f340532918d17c.dip0.t-ipconnect.de. [2003:d8:2f47:2b00:c5f3:4053:2918:d17c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-458705377f0sm159681105e9.6.2025.07.28.08.15.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Jul 2025 08:15:03 -0700 (PDT)
Message-ID: <09794c70-06a2-44dc-8e54-bc6e6a7d6c74@redhat.com>
Date: Mon, 28 Jul 2025 17:15:02 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] Disable auto_movable_ratio for selfhosted memmap
To: Hannes Reinecke <hare@suse.de>, Michal Hocko <mhocko@suse.com>
Cc: Oscar Salvador <osalvador@suse.de>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Hannes Reinecke <hare@kernel.org>
References: <aIcxs2nk3RNWWbD6@localhost.localdomain>
 <aIc5XxgkbAwF6wqE@tiehlicka>
 <2f24e725-cddb-41c5-ba87-783930efb2aa@redhat.com>
 <aIc9DQ1PwsbiOQwc@tiehlicka>
 <79919ace-9cd2-4600-9615-6dc26ba19e19@redhat.com>
 <f859e5c3-7c96-4d97-a447-75070813450c@suse.de>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <f859e5c3-7c96-4d97-a447-75070813450c@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 28.07.25 11:37, Hannes Reinecke wrote:
> On 7/28/25 11:10, David Hildenbrand wrote:
>> On 28.07.25 11:04, Michal Hocko wrote:
>>> On Mon 28-07-25 10:53:08, David Hildenbrand wrote:
>>>> On 28.07.25 10:48, Michal Hocko wrote:
>>>>> On Mon 28-07-25 10:15:47, Oscar Salvador wrote:
>>>>>> Hi,
>>>>>>
>>>>>> Currently, we have several mechanisms to pick a zone for the new
>>>>>> memory we are
>>>>>> onlining.
>>>>>> Eventually, we will land on zone_for_pfn_range() which will pick
>>>>>> the zone.
>>>>>>
>>>>>> Two of these mechanisms are 'movable_node' and 'auto-movable' policy.
>>>>>> The former will put every single hotpluggled memory in ZONE_MOVABLE
>>>>>> (unless we can keep zones contiguous by not doing so), while the
>>>>>> latter
>>>>>> will put it in ZONA_MOVABLE IFF we are within the established ratio
>>>>>> MOVABLE:KERNEL.
>>>>>>
>>>>>> It seems, the later doesn't play well with CXL memory where CXL
>>>>>> cards hold really
>>>>>> large amounts of memory, making the ratio fail, and since CXL cards
>>>>>> must be removed
>>>>>> as a unit, it can't be done if any memory block fell within
>>>>>> !ZONE_MOVABLE zone.
>>>>>
>>>>> I suspect this is just an example of how our existing memory hotplug
>>>>> interface based on memory blocks is just suoptimal and it doesn't fit
>>>>> new usecases. We should start thinking about how a new v2 api should
>>>>> look like. I am not sure how that should look like but I believe we
>>>>> should be able to express a "device" as whole rather than having a very
>>>>> loosely bound generic memblocks. Anyway this is likely for a longer
>>>>> discussion and a long term plan rather than addressing this particular
>>>>> issue.
>>>>
>>>> We have that concept with memory groups in the kernel already.
>>>
>>> I must have missed that. I will have a look, thanks! Do we have any
>>> documentation for that? Memory group is an overloaded term in the
>>> kernel.
>>
>> It's an internal concept so far, the grouping is not exposed to user space.
>>
>> We have kerneldoc for e.g., "struct memory_group". E.g., from there
>>
>> "A memory group logically groups memory blocks; each memory block
>> belongs to at most one memory group. A memory group corresponds to a
>> memory device, such as a DIMM or a NUMA node, which spans multiple
>> memory blocks and might even span multiple non-contiguous physical
>> memory ranges."
>>
>>>
>>>> In dax/kmem we register a static memory group. It will be considered one
>>>> union.
>>>
>>> But we still do export those memory blocks and let udev or whoever act
>>> on those right? If that is the case then ....
>>
>> Yes.
>>
>>>
>>> [...]
>>>
>>>> daxctl wants to online memory itself. We want to keep that memory
>>>> offline
>>>> from a kernel perspective and let daxctl handle it in this case.
>>>>
>>>> We have that problem in RHEL where we currently require user space to
>>>> disable udev rules so daxctl "can win".
>>>
>>> ... this is the result. Those shouldn't really race. If udev is suppose
>>> to see the device then only in its entirity so regular memory block
>>> based onlining rules shouldn't even see that memory. Or am I completely
>>> missing the picture?
>>
>> We can't break user space, which relies on individual memory blocks.
>>
>> So udev or $whatever will right now see individual memory blocks. We
>> could export the group id to user space if that is of any help, but at
>> least for daxctl purposes, it will be sufficient to identify "oh, this
>> was added by dax/kmem" (which we can obtain from /proc/iomem) and say
>> "okay, I'll let user-space deal with it."
>>
>> Having the whole thing exposed as a unit is not really solving any
>> problems unless I am missing something important.
>>
> Basically it boils down to:
> Who should be responsible for onlining the memory?
> 
> As it stands we have two methods:
> - user-space as per sysfs attributes
> - kernel policy
> 
> And to make matters worse, we have two competing user-space programs:
> - udev
> - daxctl
> neither of which is (or can be made) aware of each other.
> This leads to races and/or inconsistencies.
> 
> As we've seen the current kernel policy (cf the 'ratio' discussion)
> doesn't really fit how users expect CXL to work, so one is tempted to
> not having the kernel to do the onlining. But then the user is caught
> in the udev vs daxctl race, requiring awkward cludges on either side.
 > > Can't we make daxctl aware of udev? IE updating daxctl call out to
> udev and just wait for udev to complete its thing?
> At worst we're running into a timeout if some udev rules are garbage,
> but daxctl will be able to see the final state and we would avoid
> the need for modifying and/or moving udev rules.
> (Which, incidentally, is required on SLES, too :-)

I will try moving away from udev for memory onlining completely in RHEL 
-- let's see if I will succeed ;) .

We really want to make use of auto-onlining in the kernel where 
possible, and do it manually in user space only in a handful of cases 
(e.g., CXL, standby memory on s390x). Configuring auto-onlining is the 
nasty bit that still needs to be done manually by the admin, and that's 
really the nasty bit.


> 
> Discussion point for LPC?

Yes, probably.

-- 
Cheers,

David / dhildenb


