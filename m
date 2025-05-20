Return-Path: <linux-kernel+bounces-656136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FBD2ABE22F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 May 2025 19:55:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE5673A619B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 May 2025 17:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9DDB25B69D;
	Tue, 20 May 2025 17:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YdHiRiIs"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4937D25A2D9
	for <linux-kernel@vger.kernel.org>; Tue, 20 May 2025 17:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747763732; cv=none; b=T3FZitEtJ0EuMUCAEiKCzxLdiLrifnLXBBehxOod/WosI/qY93XwRrjADzhebsDtlDC81u3gM6t2xS1Yj40MWYQpZackASmv9RT/mYsijhL1dmZ8UoP3KPxlCZcBXw5s+XJ98zS6XJgcuADY7SI5pQVKp+ZDeP++FfBaDc8Xz9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747763732; c=relaxed/simple;
	bh=2AxapESPd6arsBdy0/5exgEQ7b50oMeW5tpgEX2w3Ws=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Cljs8N0mLHYuRB0dWrGPsfAe8h5O/T3XD0smmNDR5VC5W4uqQqcoB8kDhjgoFKzrTnTWz3LC3joLS778kW5TmOXx79pY9SADud4UFaB9n+LcMA8dS4DJ6J3rxrtkbBeqEmvXpLmmq0HnLc5nBVlGsQjikrijSt3fJXDYDpnf9Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YdHiRiIs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747763727;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=xd8BqjevdHlHk/PYNVm+UuCQH8ny0UerkYhXm71qpt8=;
	b=YdHiRiIscY7LoUx3jnylGhAmK4PNSqFM/Dxszvkr8YDHSwc5WRfaVIJILgPuodKmOCyAtP
	MwsHRgGDbSuxOGvzOaHCSSMN+WHOfsx7XJZyDYkSHbphQmi8PtgAplIUoJofIEtV0W4k4q
	PaT790laHJ+p3XrmHUolKULniwrtRXY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-183-zyENGsmWMNCC6OyCxVfU_A-1; Tue, 20 May 2025 13:55:23 -0400
X-MC-Unique: zyENGsmWMNCC6OyCxVfU_A-1
X-Mimecast-MFC-AGG-ID: zyENGsmWMNCC6OyCxVfU_A_1747763721
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-44059976a1fso25337885e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 May 2025 10:55:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747763721; x=1748368521;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xd8BqjevdHlHk/PYNVm+UuCQH8ny0UerkYhXm71qpt8=;
        b=T2KEqlLJerFgfeQQ2j4vrg+/R64boK1Fow3xq/X+0mO57pRCcqfdbyhf4MUAshcHPR
         qnGJLCYh/5rDF/1DJfFS39a4NGmGfiN0n0I8NziVSfvAg0g9jnXjhg5kk8fB24cDlSrV
         lYAO6kkbUWxMzRG5LmokUOJDUOOCDh2Zu8KhToXBuLAxz5MPSa9dtcG/EJ/duzeaLK4z
         yIllDknu/+nZIXzkUQQtv6eVBoguGb3AwF+iji+yG2kat+XKqDWEnxu8csocOniUT8g0
         0ERs+aQ7EJtFEOpxHNKw+jufjbFzXVODJ8AVfyC4BYgbNyYwLsZqLTbHNWYc5D4a+Kbf
         4H0w==
X-Forwarded-Encrypted: i=1; AJvYcCWyYD4i9JUPRs+EJ0K0vQH8whbVK4Pl9aaSvcAjWHKPRom1mRNB9uUdIW8jEX5VcNkgF+s5sSr7wB2VFqs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBP6bPBR0Slt2fJdN5lQSwTHYbisNTW0yINUxpqEI9jSIWwCzG
	nv31DdogBrsrQCW1Ajh4KWx8rJZdUwq55PgLlIzrEew673Pr71c034ncNeOw2QIvAU14bhpknK5
	oTPAl/6eu9bL63f3LFu/RPp+tvCUAy8PNv3ooUi71k7OdB5g9THrkltmN4L50VBAA8g==
X-Gm-Gg: ASbGncsOZ5dgLLlbhrei/RAvt61DiSxPj1IxSGPoevGj0Wa03K8ZOX2EcFwzo4ucBj3
	cgg01/XYFAqBMYtTY7MJXJQZGBHWL6+DrFiY4Mx4QmGuQTt3QlQuwhVe5aWoLE/OyhRRezqHsDo
	HZYCVLFep7Z77JbbxVUFpHlmD9WSSAPJ15c1jXy7Zy8uewwAEW0tY9IH8bo7IgeuAm3EMA1XE1R
	pmM93hTmLfmojpzgOfrdf9yYz5SmPXErbLiuZnBmImbu4nmf/hCxeYvVEW4AO6xK/2ODLEjCPzk
	MCADjMg5ziDe6VDfiK6o/s4/Fe7U+XgR73LbH59QFc0MP7/OR1ghEQko5BooS7AuZadhg4dd2J6
	2KqrbTuepLA0o5DN0VwFpOv4M23a75B5l6D3a7T8=
X-Received: by 2002:a05:600c:a42:b0:43b:cc42:c54f with SMTP id 5b1f17b1804b1-442fd6276f7mr162872065e9.14.1747763720697;
        Tue, 20 May 2025 10:55:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHKesEOlRYKKs4QvsBTgkjv1xDEPaGKSngXeeqahgQMFUUdZzDvumqRTaAlzvfjXk069rWNhQ==
X-Received: by 2002:a05:600c:a42:b0:43b:cc42:c54f with SMTP id 5b1f17b1804b1-442fd6276f7mr162871745e9.14.1747763720235;
        Tue, 20 May 2025 10:55:20 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f28:7c00:a95e:ac49:f2ad:ab84? (p200300d82f287c00a95eac49f2adab84.dip0.t-ipconnect.de. [2003:d8:2f28:7c00:a95e:ac49:f2ad:ab84])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-447f6b297easm41646885e9.6.2025.05.20.10.55.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 May 2025 10:55:19 -0700 (PDT)
Message-ID: <fca5fe72-55a8-456c-a179-56776848091d@redhat.com>
Date: Tue, 20 May 2025 19:55:18 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/4] mm/memory_hotplug: Add interface for runtime
 (de)configuration of memory
To: Sumanth Korikkar <sumanthk@linux.ibm.com>
Cc: linux-mm <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>,
 Oscar Salvador <osalvador@suse.de>,
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 linux-s390 <linux-s390@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
References: <20241202082732.3959803-1-sumanthk@linux.ibm.com>
 <20241202082732.3959803-2-sumanthk@linux.ibm.com>
 <3151b9a0-3e96-4820-b6af-9f9ec4996ee1@redhat.com>
 <Z08WpCxt4lsIsjcN@li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com>
 <1b9285ba-4118-4572-9392-42ec6ba6728c@redhat.com>
 <aCx-SJdHd-3Z12af@li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <aCx-SJdHd-3Z12af@li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 20.05.25 15:06, Sumanth Korikkar wrote:
>> Maybe "standby memory" might make it clearer. The concept is s390x specific,
>> and it will likely stay s390x specific.
>>
>> I like the idea (frontend/tool interface), all we need is a way for these
>> commands to detect ranges and turn them from standby into usable memory.
>>
>>>
>>> The user can still determine the available memory ranges and make them
>>> configurable using tools like lsmem or chmem with this approach atleast
>>> on s390 with this approach.
>>>
>>>> My thinking was that s390x would expose the standby memory ranges somewhere
>>>> arch specific in sysfs. From there, one could simply trigger the adding
>>>> (maybe specifying e.g, memmap_on_memory) of selected ranges.
> 
> Hi David,

Hi!

> 
> Sorry for the late reply.
> 
> Potential design approach for enabling dynamic configuration and
> deconfiguration of hotplug memory with support for both altmap and
> non-altmap usage.
> 
> Introduces flexibility, allowing users to specify at runtime which
> memory ranges should utilize altmap, rather than relying on a static
> system-wide setting that applies uniformly to all hotplugged memory.
> 
> Introduce new interface on s390 with the following attributes:
> 
> 1) Attribute1:
> /sys/firmware/memory/block_size_bytes

I assume this will be the storage increment size.

 > > 2) Attribute2:
> /sys/firmware/memory/memoryX/config
> echo 0 > /sys/firmware/memory/memoryX/config  -> deconfigure memoryX
> echo 1 > /sys/firmware/memory/memoryX/config ->  configure memoryX

And these would configure individual storage increments, essentially 
calling add_memory() and (if possible because we could offline the 
memory) remove_memory().

> 
> 3) Attribute3:
> /sys/firmware/memory/memoryX/altmap_required
> echo 0 > /sys/firmware/memory/memoryX/altmap_required -> noaltmap
> echo 1 > /sys/firmware/memory/memoryX/altmap_required -> altmap
> echo N > /sys/firmware/memory/memoryX/altmap_required -> variable size
> 	 altmap grouping (possible future requirements),
> 	 where N specifies the number of memory blocks that the current
> 	 memory block manages altmap. There are two possibilities here:
>          * If the altmap cannot fit entirely within memoryX, it can
>            extend into memoryX+1, meaning the altmap metadata will span
>            across multiple memory blocks.
>          * If the altmap for memory range cannot fit within memoryX,
>            then config will return -EINVAL.

Do we really still need this when we can configure/deconfigure?

I mean, on s390x, the most important use case for memmap-on-memory was 
not wasting memory for offline memory blocks.

But with a configuration interface like this ... the only benefit is 
being able to more-reliably add memory in low-memory conditions. An 
unlikely scenario with standby storage IMHO.

Note that I dislike exposing "altmap" to the user :) Dax calls it 
"memmap_on_memory", and it is a device attrivute.

As soon as we go down that path we have the complexity of having to 
group memory blocks etc, and if we can just not go down that path right 
now it will make things a lot simpler.

(especially, as you document above, the semantics become *really* weird)

As yet another point, I am not sure if someone really needs a per-memory 
block control of the memmap-on-memory feature.

If we could simplify here, that would be great ...


>             
> NOTE: “altmap_required” attribute must be set before setting the block as
> configured via “config” attribute. (Dependancy)
> 
> 4) Additionally add the patch to check if the memory block is configured
> with altmap or not. Similar to [RFC PATCH 2/4] mm/memory_hotplug: Add
> memory block altmap sysfs attribute.
> 
> Most of the code changes will be s390 specific with this interface.
> 
> Request your inputs on the potential interface. Thank you.
> 
> Other questions:
> 1. I’m just wondering how variable-sized altmap grouping will be
> structured in the future. Is it organized by grouping the memory blocks
> that require altmap, with the first memory block storing the altmap
> metadata for all of them? Or is it possible for the altmap metadata to
> span across multiple memory blocks?

That exactly is unclear, which is why we should probably avoid doing 
that for now. Also, with other developments happening (memdesc), and 
ongoing effort to shrink "struct page", maybe we will not even need most 
of this in the future?

> 
> 2. OR, will dedicated memory blocks be used exclusively for altmap
> metadata, which the memory blocks requiring altmap would then consume? (To
> prevent fragmentation) ?

One idea I had was that you would do the add_memory() in bigger granularity.

Then, the memory blocks hosting the memmap would have to get onlined 
first. And offlining of them would fail until all dependent ones were 
offlined.

That would at least limit the impact.

Then, the question would be, how could you "group" these memory blocks 
from your interface to do a single add_memory() etc.

But again, maybe we can leave that part out for now ...

-- 
Cheers,

David / dhildenb


