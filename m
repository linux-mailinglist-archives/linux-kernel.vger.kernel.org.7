Return-Path: <linux-kernel+bounces-756968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B82FB1BBA5
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 23:09:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D61B718A79B7
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 21:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CDD4231845;
	Tue,  5 Aug 2025 21:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QhCRPr2Q"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95774632
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 21:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754428135; cv=none; b=dhcdGk4oMEstqhemgJb39rhLb8PPHEaH9ad3JgF3/FfHs/TDGEnfnwKKNI7OB7H8/wxrTOSTXIyC1e1Am67hze6cjvVzI/YcJS6Bghc9t0u1crlCxOr0C5+TZ9JaTzLfVjL2qKgfv/lDz9OTCJWlR8qZZ0M0tPdCLpG6Ecn7WKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754428135; c=relaxed/simple;
	bh=fu0eK55NKWjFfXuUU5kvQlF0TSSqNolo84o61Yv99A8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eXjbSs3AguJU7lQCWbeW6RDWqSgmnUFJ8BVH2+TdpIYlo+3m8o1ZGtqSoT4Yyp6NLHmUuqOD44a6fHCjbzHN1thLtj/J467Wp++jo+2n//qUGIS9IOGJwOXxUyW1da6hpYv+xiaDRrIscxhLxRREici7LAUi6v1eTHAtP3GtiWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QhCRPr2Q; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754428132;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=u/eL0tC2humxAnE4NSMATRiPYyHhDovlDD4H4yRhz90=;
	b=QhCRPr2QZvD2rezNv5jH9dDUr2Oaq8dfmysXaGwzSqH6eWjB4Db/qTJTi0j2CKduXj/tjV
	av9i9ss8xCiy92ruEMtGryFOGM2p9tzFaLIRuKLzjMsY1NW42OdLjvoMGVjJ/167kasVcC
	GlPdt3BkOcU+SxYIVhNr9ek7NTvW4YU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-356-0G4xkw7aPcKg9hZrfMfXYA-1; Tue, 05 Aug 2025 17:08:51 -0400
X-MC-Unique: 0G4xkw7aPcKg9hZrfMfXYA-1
X-Mimecast-MFC-AGG-ID: 0G4xkw7aPcKg9hZrfMfXYA_1754428130
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-458bf93f729so16509405e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 14:08:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754428130; x=1755032930;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=u/eL0tC2humxAnE4NSMATRiPYyHhDovlDD4H4yRhz90=;
        b=RalH8FjY1h14ERbOoxsf2SnH7W/SzrsD1n5k2xZjwKXz7R6Ydbq/OtIsBMFcez+L0g
         dnbr+ATbyhuZytPWYJvKQpR5i1Y+a3FrKbE9sMFnGCmgArvnUjn6aNWmcIBposPiDjY5
         0p14egJ5TL623QqE+LwYuAheWDCpoRCtM8i3zm1yl8/EDK1+yO+mngTsPoOE0oDReHjL
         59oRRml9+4wGZWaljW4mIJ6GjjLr+yMxPvl4PLmXe2UGG/uSmyYqIwXIh3Xh1dwkn8UR
         TufJe2vaIBicrMpZb1cxdS82Onc/NXfyoLKHnTbJEg4f4wWN5F3fwagPr1y5T1i4qjq0
         LSXQ==
X-Forwarded-Encrypted: i=1; AJvYcCUB7SyyYis4nphiuvWQcM9Mok7RPIMSe2uPhFVk7Za7QyxmVmLIM0BGDoxR+dX2xpuUfKPt5bQEAkui1dU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJRZm3/oMTOqsnlqX4lC6BBkoHRNPGxHgrwujj0gnqZUznbU7e
	Pn8ArzGOvBJ3fhCPpSe/CsuCZaoLIHkQkkUObOxYa+o5PtAk7izs1k/v99Ti1MQs32Ye+M3fE3v
	UjywhuOtXLqjYxwnnV3JkG9nsX4T9k9I2wf+d8KasrD6PBBB3QfhODFbUI1ClCr4oiQ==
X-Gm-Gg: ASbGncu7dgS4hHMhnefmTLmxOafqw41AewotwtsT9/bnJtFeHQkNbBBIxOpNUao5h4n
	U39ZVTfcBnxdnkEN2Pkq2r74uQy9LrO3/OzujEkcJlAfaN+vw6FORUHqVXCvIGMNlZTnU12O422
	K5HlVEgpS2neyF0qF0Um+DOXbtqetckCaQiam4MZ0ARqmSagPKGpY8McFOO9f5HMyQ9tX5LzKUx
	JtgtuB6GxcuucIHBZL6HKXlxPvf3S+0ou1LQAPRmvs59pRCZq/Sint9+xii56UOsORE7wEoqy09
	xB8VaCTXM7U1BUwF9GB3yu0eVvjowxeFuiD2kH+Jf8db0ZYLXSJnBF5tMg/XG/0bVDtqLpMoy21
	d+YD26l4wFe/5uXPkeecyQWonE7hn0YgYbLnvxVS97HVP5nMNoznecow1/mBEC1t7n9c=
X-Received: by 2002:a05:600c:4fd5:b0:456:26a1:a0c1 with SMTP id 5b1f17b1804b1-459e70eeb5cmr2928275e9.17.1754428130190;
        Tue, 05 Aug 2025 14:08:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFcSYv4Sqy94KAApt5uEeACzubGuEsOE55mxZ7I9ESflZEKKHfxakUYforoYyFFXqPR+btRNg==
X-Received: by 2002:a05:600c:4fd5:b0:456:26a1:a0c1 with SMTP id 5b1f17b1804b1-459e70eeb5cmr2928115e9.17.1754428129737;
        Tue, 05 Aug 2025 14:08:49 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f4b:5100:3004:3864:4049:722e? (p200300d82f4b5100300438644049722e.dip0.t-ipconnect.de. [2003:d8:2f4b:5100:3004:3864:4049:722e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459e5879d76sm20391725e9.24.2025.08.05.14.08.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Aug 2025 14:08:49 -0700 (PDT)
Message-ID: <6dee6cd9-c67f-480f-b728-21c3a7b72004@redhat.com>
Date: Tue, 5 Aug 2025 23:08:48 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] mm/page_alloc: Add PCP list for THP CMA
To: Juan Yescas <jyescas@google.com>
Cc: akash.tyagi@mediatek.com, Andrew Morton <akpm@linux-foundation.org>,
 angelogioacchino.delregno@collabora.com, hannes@cmpxchg.org,
 Brendan Jackman <jackmanb@google.com>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
 Linux Memory Management List <linux-mm@kvack.org>, matthias.bgg@gmail.com,
 Michal Hocko <mhocko@suse.com>, Suren Baghdasaryan <surenb@google.com>,
 Vlastimil Babka <vbabka@suse.cz>, wsd_upstream@mediatek.com,
 Zi Yan <ziy@nvidia.com>, Kalesh Singh <kaleshsingh@google.com>,
 "T.J. Mercier" <tjmercier@google.com>,
 Isaac Manjarres <isaacmanjarres@google.com>
References: <CAJDx_rgzkZognxWzOXJ-ZxdTtUaM3FT6bmpkwxMz03XiX3fKAQ@mail.gmail.com>
 <d395b14a-9a84-4f25-b4f0-45e8500fc5fe@redhat.com>
 <CAJDx_rgrp1TpOt-iDcsSGRTL=qZZsK_dpKL1bSkyunPGcGXt5g@mail.gmail.com>
 <486c5773-c7fa-4e19-b429-90823ed2f7d5@redhat.com>
 <CAJDx_ri==3SxFcuKXHpNjrtxbp0hLyhM+zXeJ-LQX38rfbUChw@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <CAJDx_ri==3SxFcuKXHpNjrtxbp0hLyhM+zXeJ-LQX38rfbUChw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 05.08.25 18:57, Juan Yescas wrote:
> On Tue, Aug 5, 2025 at 2:58 AM David Hildenbrand <david@redhat.com> wrote:
>>
>> On 05.08.25 03:22, Juan Yescas wrote:
>>> On Mon, Aug 4, 2025 at 11:50 AM David Hildenbrand <david@redhat.com> wrote:
>>>>
>>>> On 04.08.25 20:20, Juan Yescas wrote:
>>>>> Hi David/Zi,
>>>>>
>>>>> Is there any reason why the MIGRATE_CMA pages are not in the PCP lists?
>>>>>
>>>>> There are many devices that need fast allocation of MIGRATE_CMA pages,
>>>>> and they have to get them from the buddy allocator, which is a bit
>>>>> slower in comparison to the PCP lists.
>>>>>
>>>>> We also have cases where the MIGRATE_CMA memory requirements are big.
>>>>> For example, GPUs need MIGRATE_CMA memory in the ranges of 30MiB to 500MiBs.
>>>>> These cases would benefit if we have THPs for CMAs.
>>>>>
>>>>> Could we add the support for MIGRATE_CMA pages on the PCP and THP lists?
>>>>
>>>> Remember how CMA memory is used:
>>>>
>>>> The owner allocates it through cma_alloc() and friends, where the CMA
>>>> allocator will try allocating *specific physical memory regions* using
>>>> alloc_contig_range(). It doesn't just go ahead and pick a random CMA
>>>> page from the buddy (or PCP) lists. Doesn't work (just imagine having
>>>> different CMA areas etc).
>>>>
>>>> Anybody else is free to use CMA pages for MOVABLE allocations. So we
>>>> treat them as being MOVABLE on the PCP.
>>>>
>>>> Having a separate CMA PCP list doesn't solve or speedup anything, really.
>>>>
>>>
>>> Thanks David for the quick overview.
>>>
>>>> I still have no clue what this patch here tried to solve: it doesn't
>>>> make any sense.
>>>>
>>>
>>> The story started with this out of tree patch that is part of Android.
>>>
>>> https://lore.kernel.org/lkml/cover.1604282969.git.cgoldswo@codeaurora.org/T/#u
>>>
>>> This patch introduced the __GFP_CMA flag that allocates pages from
>>> MIGRATE_MOVABLE
>>> or MIGRATE_CMA. What it happens then, it is that the MIGRATE_MOVABLE
>>> pages in the
>>> PCP lists were consumed pretty fast. To solve this issue, the PCP
>>> MIGRATE_CMA list was added.
>>> This list is initialized by rmqueue_bulk() when it is empty. That's
>>> how we end up with the PCP MIGRATE_CMA list
>>> in Android. In addition to this, the THP list for MIGRATE_MOVABLE was
>>> allowed to contain
>>> MIGRATE_CMA pages. This is causing THP MIGRATE_CMA pages to be used
>>> for THP MIGRATE_MOVABLE
>>> making later allocations from THP MIGRATE_CMA to fail.
>>
>> Okay, so this patch here really is not suitable for the upstream kernel
>> as is. It's purely targeted at the OOT Android patch.
>>
> Right, it is a temporary solution for the pinned MIGRATE_CMA pages.
> 
>>>
>>> These workarounds are mainly because we need to solve this issue upstream:
>>>
>>> - When devices reserve big blocks of MIGRATE_CMA pages, the
>>> underutilized MIGRATE_CMA
>>> can fall back to MIGRATE_MOVABLE and these pages can be pinned, so if
>>> we require MIGRATE_CMA
>>> pages, the allocations might fail.
>>>
>>> I remember that you presented the problem in LPC. Were you able to
>>> make some progress on that?
>>
>> There is the problem of CMA pages getting allocated by someone for a
>> MOVABLE allocation, to then short-term pin it for DMA. Long-term
>> pinnings are disallowed (we just recently fixed a bug where we
>> accidentally allowed it).
>>
> Nice, it is great the issue got caught and fixed upstream :)
> 
>> One concern is that a steady stream of short-term pinnings can turn such
>> pages unmovable. We discussed ideas on how to handle that, but there is
>> no solution upstream yet.
> 
> Are there any plans to continue the discussion? Is it in the priority
> list?

Ohh, it's somewheeeeeere on the todo list :)

Do you (or one of your colleagues) have capacity to work on that? One 
idea was to flag folios as "pending on migration" and disallow any 
further short-term pins until migration is done. IIRC, there were other 
ideas (e.g., isolated pageblock).

> Maybe
> a topic we can discuss in LPC Japan?

Sounds good, feel free to propose this as a topic. I wills end out the 
announcement of the MM MC probably next week.

-- 
Cheers,

David / dhildenb


