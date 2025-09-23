Return-Path: <linux-kernel+bounces-828921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C3F3B95DB1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 14:37:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 424A67A4B24
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 12:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 937A4322C9C;
	Tue, 23 Sep 2025 12:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="aeU3D51E"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8CBE38DEC
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 12:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758631039; cv=none; b=dEnzYKb1H9POjcVdnxt1Ez2YbC8/rOlPv8+ROGpjZKfckjvkKz3tKEtsZEZphUol+lSRJXUZBNP7ywEy8/L6euwxGegLzhzzB4/BLc/w1NH/gm5OvcdzupyukBz8bWbVMQsI7CLfWesuIDybeFHZqtqQIWExV+Ot6F04CiR/Ir0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758631039; c=relaxed/simple;
	bh=4/rN8y5+hFoB6Cf/znI8mLfQe+LliZ/NJWGVQ6hJxaI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bHsT/jsMUGppUbEBbL1ZfwAo98i2Ckp4jbGtvhckv2roTfTRqWpPmOQHeLBCV6uwJLlcL7bTvmhQAOGgph7O1xsNDyKm1/RIyP7t3ae2Ot9g7eoE56dPh48LY4VBIml2440ngDLaDLzJwEFvTjV1erVtYY3kkALI3Pf4mvthaLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=aeU3D51E; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b550eff972eso3296258a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 05:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1758631036; x=1759235836; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4210Fm1QpLo6WEa68t+fTvLZqwxqcYrVkyyGk5pqsks=;
        b=aeU3D51EXkCu/J1azOakagyOUqN4s8/oG5tEVsmHs8DnMqx5YRXXbzHKnZO6tyP+7Y
         EwvZzPw04sm+R6nQA0YM674rmUoeQ3UH9ap+dgiDq/sRQltLXf5PhCfCSwtqJ3Vbg9+8
         yTa1Bq9pbOq2564RO8t8s6WuG6byc0nkqbKgjWAp8YUVvXtAGFPJNAuZvg9oUCHD1935
         DAEI8vFhQDMyD4Tn2V5Vr4azdk429B5oOEGekw0Si2RwUGExpqhK2A+eMn1xYdhkmrKg
         ipXYInPpkPvaCJp8RiHbec6NwXjDDNnrNHQzpQ9X0/UUc84q1gvpXkAlPMljzZqD5Pyw
         OfHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758631036; x=1759235836;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4210Fm1QpLo6WEa68t+fTvLZqwxqcYrVkyyGk5pqsks=;
        b=OBds8T6104g3FQGpenpvcJYzTxkvSeZvggxuevBwx7HCbTKbxs2qf7MPlVcTPZX+MC
         Gumiyb1OCpE7dgWnzASUJs1b4gceONWYr5MpDVtt6F0FdgP1qa7KribrKrYBsJlE3JLN
         N/qPRC/YqW1ayvdRi+S+EZvU9k11dOHQkj0YdcfdCcCQnxMgV+DErjAXEDamvZy7+Stt
         JnKUueWuL6cNL2MYdpFcxQi7Qxd56dEco3t0GsbIUTF7uv0rX71FHTgSbse65pWTtFCf
         VcQceJuyYZA9c0KMtuByQRQ6HkZdC1Z8qg+yERSGrrB/fQ4EqdKV8lAs+pHvaGfQXnl5
         88BA==
X-Forwarded-Encrypted: i=1; AJvYcCWJszno7tNsYH4CQOQ2JUMbYALtHiwS3I8pzJHRU4eaB8lweOeCyZMy6czq62UXIvkYaKQ16fNWylMj6Ew=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+9+3Bw/hFV1VgXThDHJ05/BCHQatNGiV4tccOmyhrdmO2W07G
	Wjxkm6COF5cnpP2JkkTTdFeDOh0Y8/Ah56FI8QPRZptKfnOtinkL0Tcw0erWqdWw8HU=
X-Gm-Gg: ASbGncsKGjQmPXNSmbE+j1Yd290drooD5raScOu+3XQ92XAxGBU/sBEOwnKnSD0emie
	vDAVJYV0ojLYB8m6eI6fm2YUBK/Ml/xOAkCl7JnAHy3ZDabNQgCudhayLb85htloaYwe4QteWsO
	Ng6bO+a6jH72vkA8KSt18z/eMVkZrHOnoKFM8QF1/oumqu61baRN9KZaNVsCyQ5940fX55UTdjd
	hOVBWB1tnE6BTt68MltX0ZL2Gk5S5mYTjuEAJRhbDvpE7DtjKvaSy/ImhPMCQYgv5d1R00AZxNl
	jxYMG+gPYJEnxi9cwNGuALMvVvUUahD7gcYqwzPyHptdqpZHduRsPkqWOSbB3VPbp0nvoHJOEt6
	3ebpsBCWERhpHctUnMtSROVwu2TtHs2+1AnRQZo8JHyP+E67THSFObSdD7O2n2xwka++g9Ao=
X-Google-Smtp-Source: AGHT+IE39Ar0QDkR4Xr9h08I1/hHt1iycT4gYz0WAi6LZWYuJ7bIzRYt764/EzbqkiDYrN0iB/PnTQ==
X-Received: by 2002:a17:903:2c0b:b0:275:b1cf:6dd7 with SMTP id d9443c01a7336-27cc48a0b06mr27799065ad.34.1758631035835;
        Tue, 23 Sep 2025 05:37:15 -0700 (PDT)
Received: from [10.88.213.9] ([61.213.176.57])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-269803601e3sm162427175ad.144.2025.09.23.05.37.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Sep 2025 05:37:15 -0700 (PDT)
Message-ID: <2739dcc3-7c38-492c-854a-731298396a0c@bytedance.com>
Date: Tue, 23 Sep 2025 20:37:09 +0800
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
Content-Language: en-US
From: Sheng Zhao <sheng.zhao@bytedance.com>
In-Reply-To: <CACGkMEuvT3=a+6LyaFZFmCZzGS5tntPSbSJg=h6FAHdk89pC8g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2025/9/17 16:16, Jason Wang wrote:
> On Mon, Sep 15, 2025 at 3:34 PM <sheng.zhao@bytedance.com> wrote:
>>
>> From: Sheng Zhao <sheng.zhao@bytedance.com>
>>
>> The allocation granularity of bounce pages is PAGE_SIZE. This may cause
>> even small IO requests to occupy an entire bounce page exclusively. The
>> kind of memory waste will be more significant on arm64 with 64KB pages.
> 
> Let's tweak the title as there are archs that are using non 4KB pages
> other than arm.
> 

Got it. I will modify this in v2.

>>
>> So, optimize it by using fixed 4KB bounce pages.
>>
>> Signed-off-by: Sheng Zhao <sheng.zhao@bytedance.com>
>> ---
>>   drivers/vdpa/vdpa_user/iova_domain.c | 120 +++++++++++++++++----------
>>   drivers/vdpa/vdpa_user/iova_domain.h |   5 ++
>>   2 files changed, 83 insertions(+), 42 deletions(-)
>>
>> diff --git a/drivers/vdpa/vdpa_user/iova_domain.c b/drivers/vdpa/vdpa_user/iova_domain.c
>> index 58116f89d8da..768313c80b62 100644
>> --- a/drivers/vdpa/vdpa_user/iova_domain.c
>> +++ b/drivers/vdpa/vdpa_user/iova_domain.c
>> @@ -103,19 +103,26 @@ void vduse_domain_clear_map(struct vduse_iova_domain *domain,
>>   static int vduse_domain_map_bounce_page(struct vduse_iova_domain *domain,
>>                                           u64 iova, u64 size, u64 paddr)
>>   {
>> -       struct vduse_bounce_map *map;
>> +       struct vduse_bounce_map *map, *head_map;
>> +       struct page *tmp_page;
>>          u64 last = iova + size - 1;
>>
>>          while (iova <= last) {
>> -               map = &domain->bounce_maps[iova >> PAGE_SHIFT];
>> +               map = &domain->bounce_maps[iova >> BOUNCE_PAGE_SHIFT];
> 
> BOUNCE_PAGE_SIZE is kind of confusing as it's not the size of any page
> at all when PAGE_SIZE is not 4K.
> 

How about BOUNCE_MAP_SIZE?

>>                  if (!map->bounce_page) {
>> -                       map->bounce_page = alloc_page(GFP_ATOMIC);
>> -                       if (!map->bounce_page)
>> -                               return -ENOMEM;
>> +                       head_map = &domain->bounce_maps[(iova & PAGE_MASK) >> BOUNCE_PAGE_SHIFT];
>> +                       if (!head_map->bounce_page) {
>> +                               tmp_page = alloc_page(GFP_ATOMIC);
>> +                               if (!tmp_page)
>> +                                       return -ENOMEM;
>> +                               if (cmpxchg(&head_map->bounce_page, NULL, tmp_page))
>> +                                       __free_page(tmp_page);
> 
> I don't understand why we need cmpxchg() logic.
> 
> Btw, it looks like you want to make multiple bounce_map to point to
> the same 64KB page? I wonder what's the advantages of doing this. Can
> we simply keep the 64KB page in bounce_map?
> 
> Thanks
> 

That's correct. We use fixed 4KB-sized bounce pages, and there will be a 
many-to-one relationship between these 4KB bounce pages and the 64KB 
memory pages.

Bounce pages are allocated on demand. As a result, it may occur that 
multiple bounce pages corresponding to the same 64KB memory page attempt 
to allocate memory simultaneously, so we use cmpxchg to handle this 
concurrency.

In the current implementation, the bounce_map structure requires no 
modification. However, if we keep the 64KB page into a single bounce_map 
while still wanting to implement a similar logic, we may need an 
additional array to store multiple orig_phys values in order to 
accommodate the many-to-one relationship.

Thanks


