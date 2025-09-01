Return-Path: <linux-kernel+bounces-795184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 552AAB3EDF5
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 20:38:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 126C0482C27
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 18:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38D45324B26;
	Mon,  1 Sep 2025 18:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vy/q9uss"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E8D34CDD
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 18:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756751925; cv=none; b=SNfdnc5nBUUyHNUljbgs3QMtptNsJuAMma8v0EqkAN7ck67MP7jdyOyyCb3m+if4qQBVaiW05xrANrcnCLWfVZVbAw2zQjCMs690U9/KUMoyx0yEpadtJWnkpuwJDgzNjTebxytDfbjBu374ak7GfbDoBu9Ng+A/Ec1Ku5wwEyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756751925; c=relaxed/simple;
	bh=7RhJ2meIhP0qT1GxYoEcTF3zoKfZVQvXZVw2m64rt94=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WCWCWiYcbGegqTxF6mWYOSzBPIV9pf3dB9TU49MaIMXa1MD3dyX9/r6BQieeuBjz/jx/tQ5SLcNvuY7pN+unEkyGKY0WNQJVB1cmVXRL6gN5jJCvG0OLxCuhZGlPoJNZLVJFtRs0uIOCtut4/mFPyd6HAPfv82TaiQq0SfZZKbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Vy/q9uss; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756751922;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=aOMYfYkIB0MeR6VSaf6nAC5fx6q+m9vBzWbf+mnbIXw=;
	b=Vy/q9uss3sO+PRAmfYuQfZVBDUxGGycAal7O1SPXRl10Vl9lVNxl44eBE7ODeqnNjQIvVW
	cHSrefQlcDLOrUbh4vLEugz0Wutr4uDCoufkE173HyyR8GJGp1c1ZVuVOdzmwYCC1mu9NY
	M6BjQiyRY5hjnzjRMNhOeVvgeTyxMtw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-684-jA446K8PP--E392Y0UcZ5w-1; Mon, 01 Sep 2025 14:38:41 -0400
X-MC-Unique: jA446K8PP--E392Y0UcZ5w-1
X-Mimecast-MFC-AGG-ID: jA446K8PP--E392Y0UcZ5w_1756751920
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-45b87bc6869so14255135e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 11:38:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756751920; x=1757356720;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aOMYfYkIB0MeR6VSaf6nAC5fx6q+m9vBzWbf+mnbIXw=;
        b=Tyl3mhnrtkQAzpbY2ht7eMCdRXSCaENU2HMlu63nnmAigrp92IhoyTWa85HhCTgQJ+
         V/xiO+TL4EqNx59LJEgLsEOq7qWUw9LVzXzVHUCH/45Mbdx8/7h4jnmgmkdrhY6URnri
         z8AJO1tX88aiJCgC9Dt/EbpaLYo7NT3eMzi0M/NsCGXuV9zdDfNudn17iane3lqO2IUx
         2zYAU+/eUnj19tgfCbXLah3C+/n+U6nEOj+k4JF6HCF4myRTc26DJgoND/QgDMrH/QgW
         q+DYmSlbv6SLV2zTrEMATaN5gh4v51K+I7Gc6wDqAQ4Rp5jamu5/GsLJ0EykIoXY9GMG
         oi0w==
X-Forwarded-Encrypted: i=1; AJvYcCW3nrn9KPZyh0AbF6TEFSu6AyUCm5NMm5qltgGn7hY7izqTZGLCSdttFgFv1ofOWkVdhTKZDT7Et+haAMA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWLSUT2OM+w2tci6hz68wrMzFzIs32dCMUj/Jcs7V3pMQimudd
	pJsbBTxmx5qehQu70C+BBieWazUqb5tSyzSfjnyHZ9sHnPPkUkf88bM33IgeWN3mQfJhEn/PXlU
	kbBosjaJbNsK1u1BZ/9BfCCDs1BSuuNQb6gO5NhiUV1Namkfbn9Jd+Bv0yh+dBVT08w==
X-Gm-Gg: ASbGncv1ylwp0FrRndwmUfTcNOSCJPhJSaztKDAprkXfjEJfd4TY7POgjcF5Z+gJYvb
	NYJvXYeQeB9gs6PDL/Fp0VZ8SriI77/bwWtaQK1OIZJyi0Zhsuwo8VrsjBtZY/4ldgeJsPUXrb6
	TuqbgNg8gzX1QNuU9JN20gx7X5IVgqpvqHnVJqBsiU8c70TftwVlxJ8hnMFxhTw2bjvtKyo9hvh
	1hIeIXIsDtZoUWgnluNU6iP3OZ3cDbwnE0Vq9Ta7CYnnhIpImvjxcuWJs2HiMb6yY5lGAay/cCc
	BJf+E7mu6wXZoymrbLjOVz49IIYqypCno2b5GKWY/DKKHn4DG7qkSDdb8pvO9d0/Rj8NLgwFN8c
	S+8nVvO6IaiOl5cW3l+ruvdkZivYCMRq3pzISXrRilm7fs0Yk71sKaCsiATVxJAIqVx4=
X-Received: by 2002:a05:600c:c8f:b0:45b:7ce0:fb98 with SMTP id 5b1f17b1804b1-45b85528677mr78023235e9.5.1756751920251;
        Mon, 01 Sep 2025 11:38:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHq87FLfD4bNpAb7pWs0AmNW8xxuWnKcg9odd5omeYSbwlpcrZLSZ/gW4a3C/k//IJfK2+Qbg==
X-Received: by 2002:a05:600c:c8f:b0:45b:7ce0:fb98 with SMTP id 5b1f17b1804b1-45b85528677mr78022885e9.5.1756751919831;
        Mon, 01 Sep 2025 11:38:39 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f37:2b00:948c:dd9f:29c8:73f4? (p200300d82f372b00948cdd9f29c873f4.dip0.t-ipconnect.de. [2003:d8:2f37:2b00:948c:dd9f:29c8:73f4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b814da51esm145663325e9.8.2025.09.01.11.38.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Sep 2025 11:38:39 -0700 (PDT)
Message-ID: <776629b2-5459-4fa0-803e-23d4824e7b24@redhat.com>
Date: Mon, 1 Sep 2025 20:38:37 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 0/3] cgroups: Add support for pinned device memory
To: =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Maarten Lankhorst <dev@lankhorst.se>,
 Lucas De Marchi <lucas.demarchi@intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Maxime Ripard <mripard@kernel.org>,
 Natalie Vock <natalie.vock@gmx.de>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?=27Michal_Koutn=C3=BD=27?=
 <mkoutny@suse.com>, Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "'Liam R . Howlett'" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>,
 Thomas Zimmermann <tzimmermann@suse.de>
Cc: Michal Hocko <mhocko@suse.com>, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, linux-mm@kvack.org
References: <20250819114932.597600-5-dev@lankhorst.se>
 <dc21e54c-d7ae-4d7e-9acb-6a3fa573b20f@redhat.com>
 <9c296c72-768e-4893-a099-a2882027f2b9@lankhorst.se>
 <b6b13ad22345bcdf43325173052614c17e803d00.camel@linux.intel.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <b6b13ad22345bcdf43325173052614c17e803d00.camel@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 01.09.25 20:21, Thomas Hellström wrote:
> Hi,
> 
> On Mon, 2025-09-01 at 20:16 +0200, Maarten Lankhorst wrote:
>> Hello David,
>>
>> Den 2025-09-01 kl. 14:25, skrev David Hildenbrand:
>>> On 19.08.25 13:49, Maarten Lankhorst wrote:
>>>> When exporting dma-bufs to other devices, even when it is allowed
>>>> to use
>>>> move_notify in some drivers, performance will degrade severely
>>>> when
>>>> eviction happens.
>>>>
>>>> A perticular example where this can happen is in a multi-card
>>>> setup,
>>>> where PCI-E peer-to-peer is used to prevent using access to
>>>> system memory.
>>>>
>>>> If the buffer is evicted to system memory, not only the evicting
>>>> GPU wher
>>>> the buffer resided is affected, but it will also stall the GPU
>>>> that is
>>>> waiting on the buffer.
>>>>
>>>> It also makes sense for long running jobs not to be preempted by
>>>> having
>>>> its buffers evicted, so it will make sense to have the ability to
>>>> pin
>>>> from system memory too.
>>>>
>>>> This is dependant on patches by Dave Airlie, so it's not part of
>>>> this
>>>> series yet. But I'm planning on extending pinning to the memory
>>>> cgroup
>>>> controller in the future to handle this case.
>>>>
>>>> Implementation details:
>>>>
>>>> For each cgroup up until the root cgroup, the 'min' limit is
>>>> checked
>>>> against currently effectively pinned value. If the value will go
>>>> above
>>>> 'min', the pinning attempt is rejected.
>>>>
>>>> Pinned memory is handled slightly different and affects
>>>> calculating
>>>> effective min/low values. Pinned memory is subtracted from both,
>>>> and needs to be added afterwards when calculating.
>>>
>>> The term "pinning" is overloaded, and frequently we refer to
>>> pin_user_pages() and friends.
>>>
>>> So I'm wondering if there is an alternative term to describe what
>>> you want to achieve.
>>>
>>> Is it something like "unevictable" ?
>> It could be required to include a call pin_user_pages(), in case a

We'll only care about long-term pinnings (i.e., FOLL_LONGTERM). Ordinary 
short-term pinning is just fine.

(see how even "pinning" is overloaded? :) )

>> process wants to pin
>> from a user's address space to the gpu.
>>
>> It's not done yet, but it wouldn't surprise me if we want to include
>> it in the future.
>> Functionally it's similar to mlock() and related functions.

Traditionally, vfio, io_uring and rdma do exactly that: they use GUP to 
longterm pin and then account that memory towards RLIMIT_MEMLOCK.

If you grep for "rlimit(RLIMIT_MEMLOCK)", you'll see what I mean.

There are known issues with that: imagine long-term pinning the same 
folio through GUP with 2 interfaces (e.g., vfio, io_uring, rdma), or 
within the same interface.

You'd account the memory multiple times, which is horrible. And so far 
there is no easy way out.

>>
>> Perhaps call it mlocked instead?
> 
> I was under the impression that mlocked() memory can be migrated to
> other physical memory but not to swap? whereas pinned memory needs to
> remain the exact same physical memory.

Yes, exactly.

> 
> IMO "pinned" is pretty established within GPU drivers (dma-buf, TTM)
> and essentially means the same as "pin" in "pin_user_pages", so
> inventing a new name would probably cause even more confusion?

If it's the same thing, absolutely. But Marteen said "It's not done yet, 
but it wouldn't surprise me if we want to include it in the future".

So how is the memory we are talking about in this series "pinned" ?


-- 
Cheers

David / dhildenb


