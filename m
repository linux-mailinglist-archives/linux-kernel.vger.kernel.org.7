Return-Path: <linux-kernel+bounces-829907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78BC5B982A6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 06:05:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AB762E598F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 04:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9699F21FF4C;
	Wed, 24 Sep 2025 04:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Blo7P9/d"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12C6F1FDE09
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 04:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758686744; cv=none; b=e2Lg45n3wzwlpRAmYtSjOqDnuypZOpsW4w8LWIPe4uiPpLiBU87luZu79rj8dDD4BzacsqCjEbhsyyohIk7MahgSl/gRPuGTuKn0W7cX/My4J7gBTTc8YJNUCuW6qrStu8h7IZF+vRJobChsCPdS92CHp4OesXNYTzCj6u6yZRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758686744; c=relaxed/simple;
	bh=NQPZF9e2c9CtsjhkZliyNOSlNI5BNbDFaXzN53vkEB4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nTbF0b7fCttiu3KZD4C1Rnx6LZ8xI2rCoBYGkBxwsB7g4tI0eDGNcpkdWmLG51ISaQn1atDVmLkUvm2z+vJKX4jAxlHTwMJ4jkoUXtb105suBMpFpFa6JiTkR/9trq1y9X0iNWjzgGTgzs8e4wuZ3AfUjMNl4ob6BP4aFpZCIYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Blo7P9/d; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3327f8ed081so3083825a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 21:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1758686742; x=1759291542; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Hj/VG0+ZBnyrZwY9mojsT9ngdgtjWP1naUzw+Q1A/nE=;
        b=Blo7P9/dMh/mF3FfifPxnRy45IcTrxapY5tdryDyJyoj8hBqhacczEBdE3zPEZvCQ4
         26ASjvKxlA7gx4W7XK43Svvj/pPl5xERRlDU5Sa2pKdNno26RMO6CULkAPCk41XZWsa8
         5B4GVk4gaSJmRDTZ7RxQ6NfBcMhLH99QXpO2nIXln66xCBhsznfHekavugqt0v2fKZb7
         qjf4s+K9MMLSmiPskY2QAnZNZlKt+Jw8SL1xN/2WUsnRKJ9isoC11ogDc6Yu9PPvO46T
         5b65NUAVc4FZN+TAAGo+DzvaWjiJtpMn38/Vq3+vnU2xJAGEycJX5nk+HXCt4fIVwyJz
         xDHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758686742; x=1759291542;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hj/VG0+ZBnyrZwY9mojsT9ngdgtjWP1naUzw+Q1A/nE=;
        b=Fn3nhIh54iXuEPr3NBFOPztxmXsGKpZZiGDhzOqDYVEd3XtHjNG718by4/yXY8q2s1
         adSH9ZeD9jx6sVagIXWcb3cc8sBL0GGPiZs56N8H9p7pWfqPr40WqXVQHkXxNFWTchw7
         sMCL8uHQRBhn4ZMiczr6gs6CgwTKhq5PwBCPQ5RTgnC28vMJBgEQvWTnvsX+WDNc9dzk
         wqECEOEZKHlRVnjV2nT+MMb38oOX+lLKHJD/zf7RXLPo0ignyc7TIuWdah1Rllxe1C3R
         ULbImxQBfnuqpqvlhnd6Eyh9K/8C1UhzauT7MPD4HbkS6NNW8sEaegywCP+XqPxv9kl8
         qsIw==
X-Forwarded-Encrypted: i=1; AJvYcCXjYtQK5JSoJFdxr042x6CGJ3CZoJ/xSnnn2kX7nT4EESIm10Loe2xRe02oSVINxVUkC6dGUoow4cxVM3w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaMiJYBjtA2Jn0juB6YRP4Pallcq/aiE187CHTvstMQ1bUOy7U
	kHWsBvI+TPUMT1CDEavACJHJhQsO7dZFjDwqYmYSUlnHYwrqK6VjPlghkEpT+Wy97kI=
X-Gm-Gg: ASbGncusExqTyMJ40gf9eEHEarVFAL3gk1NcMA5KY5nKCbEOTo6rmwQJtwcXGGK3b+3
	bbni5VRGbg+VXhjJufNeqsrhjxnC75SVBM9TepOCjCDZvMeyO4p7OI79by+jarvTZPcsu4PG/zr
	zm/jnVCd6q9atOG3KetugIMJDD++TtOMBpr62b0HDtHbPUG0sl90qq4G8ERDpfDRB1jr9RaQ72I
	00TNnKRNsCrlZdstz9Vkxk+FQ4PKHwJrvl8TjIb2TchHCCVkkftQFp9H0dxkMC3+jMSf4u/1P1h
	MtiSotFqrPoXBDyI4vpphtVDAmKVF7oU/UL4AVWbynnAmIq3v8SF+TdRsc+p5cJYPJBdRk23FKY
	ZGkvrpARlkZJpAR52vp+d6yQOyhLJwPizwajkVCDvI8AF9h7FfHM4K/ENpjyAdKhUYznwciE=
X-Google-Smtp-Source: AGHT+IGb5iPXT+ZtAJ3FiTP92YXhJI/RPFbN4furn0bB8MFVyoMrlhzBZRruGqdq83PrpiswhpPc8g==
X-Received: by 2002:a17:90b:58c5:b0:32b:dfdb:b276 with SMTP id 98e67ed59e1d1-332a98fc381mr5336158a91.34.1758686742150;
        Tue, 23 Sep 2025 21:05:42 -0700 (PDT)
Received: from [10.88.213.9] ([61.213.176.55])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3341bd8b206sm756958a91.2.2025.09.23.21.05.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Sep 2025 21:05:41 -0700 (PDT)
Message-ID: <aed938d0-e70a-4af6-9950-d4d0b7d6a93f@bytedance.com>
Date: Wed, 24 Sep 2025 12:05:36 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Re: [PATCH] vduse: Use fixed 4KB bounce pages for arm64 64KB page
 size
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
 xieyongji@bytedance.com
References: <20250915073429.54027-1-sheng.zhao@bytedance.com>
 <CACGkMEuvT3=a+6LyaFZFmCZzGS5tntPSbSJg=h6FAHdk89pC8g@mail.gmail.com>
 <2739dcc3-7c38-492c-854a-731298396a0c@bytedance.com>
 <CACGkMEv3pUBF3Uv2s3MM0Qn--fP3mwN92SqE9NX4gNuMALBTUg@mail.gmail.com>
Content-Language: en-US
From: Sheng Zhao <sheng.zhao@bytedance.com>
In-Reply-To: <CACGkMEv3pUBF3Uv2s3MM0Qn--fP3mwN92SqE9NX4gNuMALBTUg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2025/9/24 08:57, Jason Wang wrote:
> On Tue, Sep 23, 2025 at 8:37 PM Sheng Zhao <sheng.zhao@bytedance.com> wrote:
>>
>>
>>
>> On 2025/9/17 16:16, Jason Wang wrote:
>>> On Mon, Sep 15, 2025 at 3:34 PM <sheng.zhao@bytedance.com> wrote:
>>>>
>>>> From: Sheng Zhao <sheng.zhao@bytedance.com>
>>>>
>>>> The allocation granularity of bounce pages is PAGE_SIZE. This may cause
>>>> even small IO requests to occupy an entire bounce page exclusively. The
>>>> kind of memory waste will be more significant on arm64 with 64KB pages.
>>>
>>> Let's tweak the title as there are archs that are using non 4KB pages
>>> other than arm.
>>>
>>
>> Got it. I will modify this in v2.
>>
>>>>
>>>> So, optimize it by using fixed 4KB bounce pages.
>>>>
>>>> Signed-off-by: Sheng Zhao <sheng.zhao@bytedance.com>
>>>> ---
>>>>    drivers/vdpa/vdpa_user/iova_domain.c | 120 +++++++++++++++++----------
>>>>    drivers/vdpa/vdpa_user/iova_domain.h |   5 ++
>>>>    2 files changed, 83 insertions(+), 42 deletions(-)
>>>>
>>>> diff --git a/drivers/vdpa/vdpa_user/iova_domain.c b/drivers/vdpa/vdpa_user/iova_domain.c
>>>> index 58116f89d8da..768313c80b62 100644
>>>> --- a/drivers/vdpa/vdpa_user/iova_domain.c
>>>> +++ b/drivers/vdpa/vdpa_user/iova_domain.c
>>>> @@ -103,19 +103,26 @@ void vduse_domain_clear_map(struct vduse_iova_domain *domain,
>>>>    static int vduse_domain_map_bounce_page(struct vduse_iova_domain *domain,
>>>>                                            u64 iova, u64 size, u64 paddr)
>>>>    {
>>>> -       struct vduse_bounce_map *map;
>>>> +       struct vduse_bounce_map *map, *head_map;
>>>> +       struct page *tmp_page;
>>>>           u64 last = iova + size - 1;
>>>>
>>>>           while (iova <= last) {
>>>> -               map = &domain->bounce_maps[iova >> PAGE_SHIFT];
>>>> +               map = &domain->bounce_maps[iova >> BOUNCE_PAGE_SHIFT];
>>>
>>> BOUNCE_PAGE_SIZE is kind of confusing as it's not the size of any page
>>> at all when PAGE_SIZE is not 4K.
>>>
>>
>> How about BOUNCE_MAP_SIZE?
> 
> Fine with me.
> 
>>
>>>>                   if (!map->bounce_page) {
>>>> -                       map->bounce_page = alloc_page(GFP_ATOMIC);
>>>> -                       if (!map->bounce_page)
>>>> -                               return -ENOMEM;
>>>> +                       head_map = &domain->bounce_maps[(iova & PAGE_MASK) >> BOUNCE_PAGE_SHIFT];
>>>> +                       if (!head_map->bounce_page) {
>>>> +                               tmp_page = alloc_page(GFP_ATOMIC);
>>>> +                               if (!tmp_page)
>>>> +                                       return -ENOMEM;
>>>> +                               if (cmpxchg(&head_map->bounce_page, NULL, tmp_page))
>>>> +                                       __free_page(tmp_page);
>>>
>>> I don't understand why we need cmpxchg() logic.
>>>
>>> Btw, it looks like you want to make multiple bounce_map to point to
>>> the same 64KB page? I wonder what's the advantages of doing this. Can
>>> we simply keep the 64KB page in bounce_map?
>>>
>>> Thanks
>>>
>>
>> That's correct. We use fixed 4KB-sized bounce pages, and there will be a
>> many-to-one relationship between these 4KB bounce pages and the 64KB
>> memory pages.
>>
>> Bounce pages are allocated on demand. As a result, it may occur that
>> multiple bounce pages corresponding to the same 64KB memory page attempt
>> to allocate memory simultaneously, so we use cmpxchg to handle this
>> concurrency.
>>
>> In the current implementation, the bounce_map structure requires no
>> modification. However, if we keep the 64KB page into a single bounce_map
>> while still wanting to implement a similar logic, we may need an
>> additional array to store multiple orig_phys values in order to
>> accommodate the many-to-one relationship.
> 
> Or simply having a bitmap is sufficient per bounce_map?
> 

Yes, using a bitmap can mark the usage status of each 4KB, but it may 
not simplify things overall.

- we will inevitably need to add an additional array per bounce_map to 
store the orig_phys corresponding to each 4KB for subsequent copying 
(vduse_domain_bounce).

- compared to the current commit, this modification may only be a 
structural change and fail to reduce the amount of changes to the code 
logic. For instance, cmpxchg is still required.


Thanks

> Thanks
> 
>>
>> Thanks
>>
> 


