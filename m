Return-Path: <linux-kernel+bounces-831675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A288EB9D4BB
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 05:14:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5B7A19C1E08
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 03:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E1262E6CD7;
	Thu, 25 Sep 2025 03:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="cs594Cpc"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 721472E54D1
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 03:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758770032; cv=none; b=RPVgmziWWML2qZRV5PUaprLSDDZqE1fOwBIXd0fTBJsaXbeKDQvE93hRM2hpuLSjoL6eytMALnapquSr3YsqgLeMuHxelnW3seDZxdhL6MBtvc/kT80y/lus4E7srkvSelxTDhlvPNUOsj1tyzDoK8VjAKD+Fq+mlGatjSea08k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758770032; c=relaxed/simple;
	bh=ZNlC3ytCdpA4bDAK7K9EiMrHky4cTsXH4Nuw/wqaWNw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eLxf081w4rGT9zsEs+0lEF2U1ZnhoAy9pNwKhsw0jDN+uNBP+LfssWVUaK0KSL5SCXt5KSWmZRsNh2HYPLvs+SEUIfU5xYWwvRQyVkGdfp9crfLsIasUDXayBSWEiQF60YI/4pAi7LCRbyAgCidDPvK5Hu9N18HQOOoPdRaSNQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=cs594Cpc; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b55562f3130so353777a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 20:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1758770029; x=1759374829; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8DQBEP1I37Fp+YiRWxVEQEnfIH7lwteqMCyAj13M1Bo=;
        b=cs594Cpc4qJ4A4btWqKniSwLd+xsVUkbKt3D6v0b3GEpMQtpCLmNulGBu3YjhGJ+hM
         xs8lCM8hxsYkcr/cqejnRorSg/jZD4tceER4UCx3HXgEEtxO9Tsyx7OP5WftyfgvtgN6
         cQXo/sTjmzjLyr4iv2c0ppSMvFFhsxmnzGM5vkOwn6FUUlpKNRKHOAw5m4ITNd1jqiKZ
         30zhblfN5xMewbogs+uAJT3mMfBYopCUajL0IDLJcpowTxfMtVLvwP8nYU3NszMNi7AW
         HqB6MJILAuuI3eAARI0KG6fmAEPZdgsBrRm+aKMbmiEC3MXMIGGkgk0ikbyFcNmMfDyD
         09Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758770029; x=1759374829;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8DQBEP1I37Fp+YiRWxVEQEnfIH7lwteqMCyAj13M1Bo=;
        b=DhIymo/MRM0lniMZKTcoKPszQEM/NuROsN+K8Bz2NVLi1dMi+f/WU6qj+sTp9NNceB
         zSD7r32CNgcSXJiPfnV0xU5zHTw63UgNufZfYn6r5f4mpq+8W3bzvhtJWGA1bAy1MSw6
         qcJF6TkawWQ6/DnSUpLny8As4WNdpMo1N7UIimsLhseXbhqkhnZvOl8G7rcUj8lRztCk
         5cuGLlP26Bb3Ms3Hq1ks0PmRmIjfG3kBKMPazDI/QHN/B5+fZHras5s4I5GxzhlWMQcz
         LP7KV2HAHRpTn+EoKLxraVny2XOjn/9PkFDD1PaJ6ijiCl6tWOXn7Ln4iGIQ9sG5okex
         v6Lw==
X-Forwarded-Encrypted: i=1; AJvYcCVuKYs99VrgVVS4cddF2X2UUG1pZqCvqYgjzfI+ZIUpGKzJfOJdlSYBLRZDAdg32pXAebDsGDY4LEOU/Zs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyegmmdAheAup3dyhLhFyiv650DZnFTTTHB0ep6xhuXaLn78UgY
	t96tfZ7dM9vwfWfAx2DaMOpNrg0tUPKcB4s6c0YRVeOYuNu/+yILo8ivitmxUed8NYE=
X-Gm-Gg: ASbGncsaesskYAR6zJBwxSJLv1BlIBAJs/65MpuyZQ+8+isuD4iiHkFDEPE5/wnCTf1
	fM0zz4tTnvxrHYQs8FkoMLyvKTRwZRQQ38M9ih1L71EUH34oq5pcXQGo5HtSROJ61LS/GhVfuri
	too6UAvr/yvCbzyhu75g/yyeQSfbWcY/S2Oq0oT0HNH7IMJwFuxeWmllvJl4egJFLQ6Kjn+cRLY
	FfnrxRd1/qJBeGdNiEAk0zf+CUxuXoKE8vzC+PysvqzWCLHNwGnX8eWVbAfgrs9VBolOQHqgYs+
	A/cVIw1RyA7d3yDoSP9k1okqxOX2MMRK6B/DGI8h6nzSX3CkevZG4ZFLLrBeXisxDecbF7/j3FI
	VRtozORkQy05ED0B4xWPQvdyI/b7sY0Fo3Tj4Q7BTWM6uLAbjrARerWp1dilORXiGgPCkdDo=
X-Google-Smtp-Source: AGHT+IFwrZ1Zmz34+evkbaU0P/TQ5i+vEtwAvIefdhc9mbN+PrhLj0MOENqxK3Ytq4hnXblZiofRnw==
X-Received: by 2002:a17:902:cec8:b0:267:af07:6528 with SMTP id d9443c01a7336-27ed4a7a906mr19270025ad.35.1758770029420;
        Wed, 24 Sep 2025 20:13:49 -0700 (PDT)
Received: from [10.88.213.9] ([61.213.176.56])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed6ae693fsm7605015ad.152.2025.09.24.20.13.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Sep 2025 20:13:48 -0700 (PDT)
Message-ID: <1a899ea7-c58f-4b65-9888-c26adc8da00f@bytedance.com>
Date: Thu, 25 Sep 2025 11:13:43 +0800
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
 <aed938d0-e70a-4af6-9950-d4d0b7d6a93f@bytedance.com>
 <CACGkMEv4TZOAyxaTkCvZ4rgyVsPet+r3pNSauHaGOYHim3Loag@mail.gmail.com>
 <b5bc34c2-b82a-475d-ba15-a7f67495b56a@bytedance.com>
 <CACGkMEsLg-oi3BU1EgRVb2hB9P1bfxEyZoH03+vtEGe=YmNQHg@mail.gmail.com>
Content-Language: en-US
From: Sheng Zhao <sheng.zhao@bytedance.com>
In-Reply-To: <CACGkMEsLg-oi3BU1EgRVb2hB9P1bfxEyZoH03+vtEGe=YmNQHg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2025/9/25 08:20, Jason Wang wrote:
> On Wed, Sep 24, 2025 at 2:38 PM Sheng Zhao <sheng.zhao@bytedance.com> wrote:
>>
>>
>>
>> On 2025/9/24 12:15, Jason Wang wrote:
>>> On Wed, Sep 24, 2025 at 12:05 PM Sheng Zhao <sheng.zhao@bytedance.com> wrote:
>>>>
>>>>
>>>>
>>>> On 2025/9/24 08:57, Jason Wang wrote:
>>>>> On Tue, Sep 23, 2025 at 8:37 PM Sheng Zhao <sheng.zhao@bytedance.com> wrote:
>>>>>>
>>>>>>
>>>>>>
>>>>>> On 2025/9/17 16:16, Jason Wang wrote:
>>>>>>> On Mon, Sep 15, 2025 at 3:34 PM <sheng.zhao@bytedance.com> wrote:
>>>>>>>>
>>>>>>>> From: Sheng Zhao <sheng.zhao@bytedance.com>
>>>>>>>>
>>>>>>>> The allocation granularity of bounce pages is PAGE_SIZE. This may cause
>>>>>>>> even small IO requests to occupy an entire bounce page exclusively. The
>>>>>>>> kind of memory waste will be more significant on arm64 with 64KB pages.
>>>>>>>
>>>>>>> Let's tweak the title as there are archs that are using non 4KB pages
>>>>>>> other than arm.
>>>>>>>
>>>>>>
>>>>>> Got it. I will modify this in v2.
>>>>>>
>>>>>>>>
>>>>>>>> So, optimize it by using fixed 4KB bounce pages.
>>>>>>>>
>>>>>>>> Signed-off-by: Sheng Zhao <sheng.zhao@bytedance.com>
>>>>>>>> ---
>>>>>>>>      drivers/vdpa/vdpa_user/iova_domain.c | 120 +++++++++++++++++----------
>>>>>>>>      drivers/vdpa/vdpa_user/iova_domain.h |   5 ++
>>>>>>>>      2 files changed, 83 insertions(+), 42 deletions(-)
>>>>>>>>
>>>>>>>> diff --git a/drivers/vdpa/vdpa_user/iova_domain.c b/drivers/vdpa/vdpa_user/iova_domain.c
>>>>>>>> index 58116f89d8da..768313c80b62 100644
>>>>>>>> --- a/drivers/vdpa/vdpa_user/iova_domain.c
>>>>>>>> +++ b/drivers/vdpa/vdpa_user/iova_domain.c
>>>>>>>> @@ -103,19 +103,26 @@ void vduse_domain_clear_map(struct vduse_iova_domain *domain,
>>>>>>>>      static int vduse_domain_map_bounce_page(struct vduse_iova_domain *domain,
>>>>>>>>                                              u64 iova, u64 size, u64 paddr)
>>>>>>>>      {
>>>>>>>> -       struct vduse_bounce_map *map;
>>>>>>>> +       struct vduse_bounce_map *map, *head_map;
>>>>>>>> +       struct page *tmp_page;
>>>>>>>>             u64 last = iova + size - 1;
>>>>>>>>
>>>>>>>>             while (iova <= last) {
>>>>>>>> -               map = &domain->bounce_maps[iova >> PAGE_SHIFT];
>>>>>>>> +               map = &domain->bounce_maps[iova >> BOUNCE_PAGE_SHIFT];
>>>>>>>
>>>>>>> BOUNCE_PAGE_SIZE is kind of confusing as it's not the size of any page
>>>>>>> at all when PAGE_SIZE is not 4K.
>>>>>>>
>>>>>>
>>>>>> How about BOUNCE_MAP_SIZE?
>>>>>
>>>>> Fine with me.
>>>>>
>>>>>>
>>>>>>>>                     if (!map->bounce_page) {
>>>>>>>> -                       map->bounce_page = alloc_page(GFP_ATOMIC);
>>>>>>>> -                       if (!map->bounce_page)
>>>>>>>> -                               return -ENOMEM;
>>>>>>>> +                       head_map = &domain->bounce_maps[(iova & PAGE_MASK) >> BOUNCE_PAGE_SHIFT];
>>>>>>>> +                       if (!head_map->bounce_page) {
>>>>>>>> +                               tmp_page = alloc_page(GFP_ATOMIC);
>>>>>>>> +                               if (!tmp_page)
>>>>>>>> +                                       return -ENOMEM;
>>>>>>>> +                               if (cmpxchg(&head_map->bounce_page, NULL, tmp_page))
>>>>>>>> +                                       __free_page(tmp_page);
>>>>>>>
>>>>>>> I don't understand why we need cmpxchg() logic.
>>>>>>>
>>>>>>> Btw, it looks like you want to make multiple bounce_map to point to
>>>>>>> the same 64KB page? I wonder what's the advantages of doing this. Can
>>>>>>> we simply keep the 64KB page in bounce_map?
>>>>>>>
>>>>>>> Thanks
>>>>>>>
>>>>>>
>>>>>> That's correct. We use fixed 4KB-sized bounce pages, and there will be a
>>>>>> many-to-one relationship between these 4KB bounce pages and the 64KB
>>>>>> memory pages.
>>>>>>
>>>>>> Bounce pages are allocated on demand. As a result, it may occur that
>>>>>> multiple bounce pages corresponding to the same 64KB memory page attempt
>>>>>> to allocate memory simultaneously, so we use cmpxchg to handle this
>>>>>> concurrency.
>>>>>>
>>>>>> In the current implementation, the bounce_map structure requires no
>>>>>> modification. However, if we keep the 64KB page into a single bounce_map
>>>>>> while still wanting to implement a similar logic, we may need an
>>>>>> additional array to store multiple orig_phys values in order to
>>>>>> accommodate the many-to-one relationship.
>>>>>
>>>>> Or simply having a bitmap is sufficient per bounce_map?
>>>>>
>>>>
>>>> Yes, using a bitmap can mark the usage status of each 4KB, but it may
>>>> not simplify things overall.
>>>>
>>>> - we will inevitably need to add an additional array per bounce_map to
>>>> store the orig_phys corresponding to each 4KB for subsequent copying
>>>> (vduse_domain_bounce).
>>>
>>> I may miss something, the PAGE_SIZE is 64KB in this case, why do we
>>> need to store per 4KB orig_phys?
>>>
>>
>> Since one orig_phys originates from one IO request. If we want the
>> minimum size of bounce pages occupied by an IO request to be 4KB instead
>> of 64KB. we need to store their respective orig_phys values for each 4KB
>> corresponding to the IO request.
>>
>> In other words, we may not be able to guarantee that the orig_phys
>> values of all IO requests within the same 64KB memory page are
>> contiguous, so we need to store them separately.
> 
> Ok, let's leave a comment to explain this design.
> 
> Thanks
> 

Sure, I will add the relevant comments in v2.

Thanks

>>
>> Thanks
>>>>
>>>> - compared to the current commit, this modification may only be a
>>>> structural change and fail to reduce the amount of changes to the code
>>>> logic. For instance, cmpxchg is still required.
>>>
>>> Thanks
>>>
>>>>
>>>>
>>>> Thanks
>>>>
>>>>> Thanks
>>>>>
>>>>>>
>>>>>> Thanks
>>>>>>
>>>>>
>>>>
>>>
>>
> 


