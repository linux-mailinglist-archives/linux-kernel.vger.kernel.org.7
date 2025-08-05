Return-Path: <linux-kernel+bounces-756234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20662B1B191
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 11:58:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD6D43BC722
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 09:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43AF4269B1C;
	Tue,  5 Aug 2025 09:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Isu8XnYg"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE921C6FE9
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 09:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754387899; cv=none; b=KYV5DRNclBVz09M3tb4Xp/KPaFRO231E7RAfMXcPbfy/xRLCVxAV5DUcKqOK0IFDPniKyvQC8rUdhSokhfSduVWuAzH9PfkjAhdZ1GPNtub21zlBijU0ZXCBi7+Lili7Gchvus1WiMdkPxRN9uMn2DASVuACs1Lpp1aX71JQwaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754387899; c=relaxed/simple;
	bh=63XBpclL/3lBBsJrLJ1tYtR9dM+pxjTnD1twIxqFJ9o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UyoaobFnWhQCLsMNsaLeVVarXCc6jUnFhztPXIEppRqM7nx6b4ulOZM7yyOMqgENdCoGmpInT3JVTbDBY/dNxpglZzY8YgPElr6W7GvHNA5ww1h8OIsWYetljyhswEPXgOuGV8uy2OT8JJ7k1hW1sW/TZbpBMmvRIvKWqM5+Odc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Isu8XnYg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754387895;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=zm/u8bmVSBWBP7KMq+8GNg/jH0DTBhPVQW1hnHzNiv8=;
	b=Isu8XnYggxaBh4yPf1FgNEmE1IFo9+tImEr4CTacd0NqXiuL0xLsY47XBMSEADeHu4MDSp
	3tlJdZfvEFdscJk+H+9RJe9auB3VSeGo4A0HIvTmOFnNKFMBPla7M+38bPmo8MpuOh02XM
	BsKbrU3+i+lYIbqDstmTmazYa0FSR2Y=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-KTssONLdNIyfsYS8rrcQrA-1; Tue, 05 Aug 2025 05:58:14 -0400
X-MC-Unique: KTssONLdNIyfsYS8rrcQrA-1
X-Mimecast-MFC-AGG-ID: KTssONLdNIyfsYS8rrcQrA_1754387893
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-459d7da3647so13088235e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 02:58:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754387893; x=1754992693;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zm/u8bmVSBWBP7KMq+8GNg/jH0DTBhPVQW1hnHzNiv8=;
        b=QZWugWz8NFpCpukYuNHOFf+eMzPWVr/6c2hrWd9NshU2mAQfTjU8/b5SsGP6LuWFkY
         xzOmZn2o55gSaD+JE/RbNczFDiuA4Qk9A/hoV+iig1GgBp2PDk95axoueUz/Zi4iXXmT
         cAYdRlL9YxOMYGSGQuGd+zziM38XMl6GZOfWAsXHnAC8DfGmpyd4bbK+w73YBfeeO2SH
         n660IdxSMDAhdiGfl6MwHgM6e42SCXk3U+SB16w0/UcV3qAs1ZpsrsVHOB2M+4SBmnKf
         lw6C9Bz8xKFLg2AaHE3keYdFeAd4oyBzKZUIv0wEFZXyYYwy16DHCCpIiG3Zh1PbhOqK
         Qkfg==
X-Forwarded-Encrypted: i=1; AJvYcCVLUz6CMFTsB+ZHJaWWICh3u0ur1J8xClz33XLVF0FroldPOXOjRXRPIu/74BuqqGdLeUEfIUBEVwhdU3k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzgAYmCjSxu5lAgddbA6Olg6LvDC0ne2j3XpTqAt7c7yOwqQDt
	Y6kYHtphuy7yLOtkHL+ykB+jbY6LDQVUxyGaEypLdrMSJlTD120qO63y5NuOPBlAu/ekB0LbkXq
	5c9LZtXUym9QMlkzkxUzKL74XlRJeI4mRN35c+AaFm+XW+CcdmxVzEGtcBTA75SXiog==
X-Gm-Gg: ASbGncuQ4B57z5v/1rKewLbbWN1ryz4CT2j4XJj1cYrza6uj9JjYUj1LRWl5QlVS4kM
	coC8YztuyaWd57kGuK7BDyVP1xrVHnGRSan+Q39JnAI9IMMh6qNyWC4DaPOC7acLEUvFIbJ0vZp
	DlJbXBdgxCGecR+xrNjO+89YHNINxyEjr9t5/LBJtQWyRuV/IKImp8h5unW/lop2ZUwtKUeOtqF
	hjLiqMjyOz0Y6XtL2/6yMr5OBMFAXNZsAYUq+HeoywfII8NzFDUHnCQhxu4Uoz+OK34PkcKVDEL
	Qk32c5WVi5hMsQoFV2mLGRz1Uun4n8sqwK/xVOU0e4FVN/XGJSO3bXYTNp8pYNUZmtp5grA=
X-Received: by 2002:a05:600c:4ecd:b0:459:e048:af42 with SMTP id 5b1f17b1804b1-459e048af80mr27344275e9.24.1754387892699;
        Tue, 05 Aug 2025 02:58:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHu9rgyjmk0uonkMuGZyFuLrvh1XIgvJwkQbJZTilgPx9GuSO2bLOzz+iugEJg9v4l3IBuIMg==
X-Received: by 2002:a05:600c:4ecd:b0:459:e048:af42 with SMTP id 5b1f17b1804b1-459e048af80mr27343985e9.24.1754387892256;
        Tue, 05 Aug 2025 02:58:12 -0700 (PDT)
Received: from [192.168.3.141] (p57a1a26f.dip0.t-ipconnect.de. [87.161.162.111])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c48de68sm18520294f8f.67.2025.08.05.02.58.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Aug 2025 02:58:11 -0700 (PDT)
Message-ID: <486c5773-c7fa-4e19-b429-90823ed2f7d5@redhat.com>
Date: Tue, 5 Aug 2025 11:58:04 +0200
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
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <CAJDx_rgrp1TpOt-iDcsSGRTL=qZZsK_dpKL1bSkyunPGcGXt5g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 05.08.25 03:22, Juan Yescas wrote:
> On Mon, Aug 4, 2025 at 11:50 AM David Hildenbrand <david@redhat.com> wrote:
>>
>> On 04.08.25 20:20, Juan Yescas wrote:
>>> Hi David/Zi,
>>>
>>> Is there any reason why the MIGRATE_CMA pages are not in the PCP lists?
>>>
>>> There are many devices that need fast allocation of MIGRATE_CMA pages,
>>> and they have to get them from the buddy allocator, which is a bit
>>> slower in comparison to the PCP lists.
>>>
>>> We also have cases where the MIGRATE_CMA memory requirements are big.
>>> For example, GPUs need MIGRATE_CMA memory in the ranges of 30MiB to 500MiBs.
>>> These cases would benefit if we have THPs for CMAs.
>>>
>>> Could we add the support for MIGRATE_CMA pages on the PCP and THP lists?
>>
>> Remember how CMA memory is used:
>>
>> The owner allocates it through cma_alloc() and friends, where the CMA
>> allocator will try allocating *specific physical memory regions* using
>> alloc_contig_range(). It doesn't just go ahead and pick a random CMA
>> page from the buddy (or PCP) lists. Doesn't work (just imagine having
>> different CMA areas etc).
>>
>> Anybody else is free to use CMA pages for MOVABLE allocations. So we
>> treat them as being MOVABLE on the PCP.
>>
>> Having a separate CMA PCP list doesn't solve or speedup anything, really.
>>
> 
> Thanks David for the quick overview.
> 
>> I still have no clue what this patch here tried to solve: it doesn't
>> make any sense.
>>
> 
> The story started with this out of tree patch that is part of Android.
> 
> https://lore.kernel.org/lkml/cover.1604282969.git.cgoldswo@codeaurora.org/T/#u
> 
> This patch introduced the __GFP_CMA flag that allocates pages from
> MIGRATE_MOVABLE
> or MIGRATE_CMA. What it happens then, it is that the MIGRATE_MOVABLE
> pages in the
> PCP lists were consumed pretty fast. To solve this issue, the PCP
> MIGRATE_CMA list was added.
> This list is initialized by rmqueue_bulk() when it is empty. That's
> how we end up with the PCP MIGRATE_CMA list
> in Android. In addition to this, the THP list for MIGRATE_MOVABLE was
> allowed to contain
> MIGRATE_CMA pages. This is causing THP MIGRATE_CMA pages to be used
> for THP MIGRATE_MOVABLE
> making later allocations from THP MIGRATE_CMA to fail.

Okay, so this patch here really is not suitable for the upstream kernel 
as is. It's purely targeted at the OOT Android patch.

> 
> These workarounds are mainly because we need to solve this issue upstream:
> 
> - When devices reserve big blocks of MIGRATE_CMA pages, the
> underutilized MIGRATE_CMA
> can fall back to MIGRATE_MOVABLE and these pages can be pinned, so if
> we require MIGRATE_CMA
> pages, the allocations might fail.
> 
> I remember that you presented the problem in LPC. Were you able to
> make some progress on that?

There is the problem of CMA pages getting allocated by someone for a 
MOVABLE allocation, to then short-term pin it for DMA. Long-term 
pinnings are disallowed (we just recently fixed a bug where we 
accidentally allowed it).

One concern is that a steady stream of short-term pinnings can turn such 
pages unmovable. We discussed ideas on how to handle that, but there is 
no solution upstream yet.

-- 
Cheers,

David / dhildenb


