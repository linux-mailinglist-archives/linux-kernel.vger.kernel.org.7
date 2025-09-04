Return-Path: <linux-kernel+bounces-801518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 490B9B44610
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 21:02:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F39E83B5F09
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 19:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3863242909;
	Thu,  4 Sep 2025 19:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YAp9xXlK"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D278820102B
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 19:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757012560; cv=none; b=hEUTWVgBjkIQ8JT6/SUZANISUr635jiClzq+qY4Wso2AJEogBEVGVdEH6elidNRhJG/i5I/nTGp1AQ5QtGvVx4/Qof5/RZXGpd6IuH8g/yRHSdrU3NLUaX63kVKQoVkUJp3k+DlZPBIm33QlBjjdVGVZoAN81AUQP9lEsAqQ3oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757012560; c=relaxed/simple;
	bh=jwjL5k2DLwLMyX+pXUvvLnAesbmTkuwy08Ylx3ZuZz0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ukuiz4dANaCw/yJUYzub2XYtGac2w9p7PbbHjMXYSa9M+uEgtkE/+Kc7QDqCu357TCIEFJ9iy+ANo2oEkjiR4mQbtfhGqV5zYzo9Xv1HdqK2n2XInRn7vr16nDUJdwLK0aJDIW7pKrXcH5QaqdHPlUmcV6fK9oB0FLUcfDoHNzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YAp9xXlK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757012555;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=YWDZyeF0BbjxRVALgIyy2T6Wp2Aa5vTrXwhQeMo3Hq8=;
	b=YAp9xXlKxcAHDTwMAAftiq38llqquqykK/c6AuvcGEsBl98l87qUgIFrCmhv6i0wmZmuC6
	KBP/0s/FU/lJFwmc8q8ZET46obB3OniEQ4waSRbeZDwaR/JADljfauXSMqgwuCB0JhQDHP
	cCs60xgCVaDVvWjeN06fz2jIdA+baUg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-354-yoc7XkV5P8CtpZ_m_pXV_A-1; Thu, 04 Sep 2025 15:02:34 -0400
X-MC-Unique: yoc7XkV5P8CtpZ_m_pXV_A-1
X-Mimecast-MFC-AGG-ID: yoc7XkV5P8CtpZ_m_pXV_A_1757012553
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-45b80aecb97so12034855e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 12:02:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757012553; x=1757617353;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YWDZyeF0BbjxRVALgIyy2T6Wp2Aa5vTrXwhQeMo3Hq8=;
        b=mlRf4NAFS1iPphJjY6bdsPlsSfiHBBQ+j/P0+8PABwLToZ3MtK7AB3lAIi0sD8HQwH
         6D6Q6PrPPDg5v4ql9pHV8A2zfFWxQgwfqoaQlr18njXswz4E77DhJGo7Ng++sa4D8U3q
         6X9azhGRcgQG6zoloUN/tVYzEdo67vN32+b47vu584/dr7o/eYmDRpSEoBLpB6VRnWGV
         LxyEdAoA5Eactiw9IxjB3y8AZfJS8Z5PrZBwkf6Zha4dlmDvKvvbQjNSAkIHF78huj74
         AdCe2H0CKBY1h/FjC2JXAcA4cNOSvW93dsZeiYSLI6ke18IkXRW8KhPcOlPNNJAkUStX
         qSrQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+LNbePOq3EqaoAdWMtVKrmetlobrn/jQpLVsudsWuHjDjEohHzdHhYU4RIL18ONOBerBuVy67pCLBf5g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiHlQJ2A6tKx3fz20i8TxRUlbwJHyliE83/OjTecLDz/L2RGyK
	T4yuI8v0uS8ebdFBg0egTLOdobaF3M7353oo7epOEipLq+FHeloJ6wRwMDM1qy0Zh9s3lMuaALM
	VESEeE4Cd+7gieUl9I2Y+EaudIP1DRGlxyfpMdudOy1TCNPsdMMndfpOftZXmxrJimA==
X-Gm-Gg: ASbGncuaWYT4QmCxAekZDAW3nqWW5+bsK9YI+XGFmyS70yF8gJqYTWTPSRi3qCI8erP
	YFQQaz59725Vwnap9i1eBLdHdxxnqAG7On7v2atiwqTkzt8S43k7nBOT9/WKyAB6TsIL2KDRa4H
	qYDRDZ9V+7JE3dPMLWr2LraXkkGR4/6JC/6pXNAuAcu5h+53xhry5lWlOdqhZueCAFtv85dK3/b
	2GJiAz1JfiG247Vl2oh1uYQBww66AJL3a4kTanQqOw/uwUL5u0P9WGkur9sw3e9shVwzUDfOYXX
	9hLB17SO+Gkk7iAaLlJoFmqwETl5jb1+hbwnJDYG9WhPCQliEPoPk7sj4CGg4Cx3c54iexNxuG2
	KtPBsQmfBDH2rldBKnaVlo+XhRPhHdxBkCVrJA8Cjg6X7FGTHe6VlLH0S3Kv0kCO8
X-Received: by 2002:a05:600c:c87:b0:45b:9912:9f1e with SMTP id 5b1f17b1804b1-45b99732e41mr94535465e9.3.1757012553188;
        Thu, 04 Sep 2025 12:02:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHO6hTNkTOa99PCxfFMSEdvMjsQNm8Z6EmDgjkyJrk1Q282hJMJh5qxS9ISP4s9BH1ZtQpyFA==
X-Received: by 2002:a05:600c:c87:b0:45b:9912:9f1e with SMTP id 5b1f17b1804b1-45b99732e41mr94535145e9.3.1757012552638;
        Thu, 04 Sep 2025 12:02:32 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f25:1e00:ce4c:be3:97b3:6587? (p200300d82f251e00ce4c0be397b36587.dip0.t-ipconnect.de. [2003:d8:2f25:1e00:ce4c:be3:97b3:6587])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b9ab7c7dbsm118390555e9.11.2025.09.04.12.02.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Sep 2025 12:02:31 -0700 (PDT)
Message-ID: <8e1881b8-3867-4cea-b03e-50c05ed8148d@redhat.com>
Date: Thu, 4 Sep 2025 21:02:30 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: centralize and fix max map count limit checking
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Kalesh Singh <kaleshsingh@google.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, akpm@linux-foundation.org,
 minchan@kernel.org, kernel-team@android.com, android-mm@google.com,
 Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20250903232437.1454293-1-kaleshsingh@google.com>
 <827c844f-7106-4f62-a108-1f83544aa56e@lucifer.local>
 <43ryds7hzhs5bpaxznco7fppmakdb4f46agwtsc5erudqfoz2x@7y4jgbtft7jj>
 <413ee338-1795-433c-b3d4-72c870488d95@lucifer.local>
 <84aad392-3bff-4f98-b612-5e9a046edb36@redhat.com>
 <CAC_TJvc=5=iS8gCumJWqH5eF4XufFSogqtWHJmiH5WBN1A6gng@mail.gmail.com>
 <4chxl7uxr4exy2z2dcshxla3c5nzzo2tbnelsbbky7pdzrih6a@hzfnpbenfmub>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <4chxl7uxr4exy2z2dcshxla3c5nzzo2tbnelsbbky7pdzrih6a@hzfnpbenfmub>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 04.09.25 20:49, Liam R. Howlett wrote:
> * Kalesh Singh <kaleshsingh@google.com> [250904 13:51]:
>> On Thu, Sep 4, 2025 at 10:42 AM David Hildenbrand <david@redhat.com> wrote:
>>>
>>> On 04.09.25 19:33, Lorenzo Stoakes wrote:
>>>> On Thu, Sep 04, 2025 at 01:22:51PM -0400, Liam R. Howlett wrote:
>>>>>>> diff --git a/mm/mremap.c b/mm/mremap.c
>>>>>>> index e618a706aff5..793fad58302c 100644
>>>>>>> --- a/mm/mremap.c
>>>>>>> +++ b/mm/mremap.c
>>>>>>> @@ -1040,7 +1040,7 @@ static unsigned long prep_move_vma(struct vma_remap_struct *vrm)
>>>>>>>      * We'd prefer to avoid failure later on in do_munmap:
>>>>>>>      * which may split one vma into three before unmapping.
>>>>>>>      */
>>>>>>> -  if (current->mm->map_count >= sysctl_max_map_count - 3)
>>>>>>> +  if (exceeds_max_map_count(current->mm, 4))
>>>>>>>             return -ENOMEM;
>>>>>>
>>>>>> In my version this would be:
>>>>>>
>>>>>>      if (map_count_capacity(current->mm) < 4)
>>>>>>              return -ENOMEM;
>>>>>>
>>>>>
>>>>> Someone could write map_count_capacity(current->mm) <= 4 and reintroduce
>>>>> what this is trying to solve.  And with the way it is written in this
>>>>> patch, someone could pass in the wrong number.
>>>>
>>>> Right, but I think 'capacity' is pretty clear here, if the caller does something
>>>> silly then that's on them...
>>>>
>>>>>
>>>>> I'm not sure this is worth doing.  There are places we allow the count
>>>>> to go higher.
>>>>
>>>> ...But yeah, it's kinda borderline as to how useful this is.
>>>>
>>>> I _do_ however like the 'put map count in one place statically' rather than
>>>> having a global, so a minimal version of this could be to just have a helper
>>>> function that gets the sysctl_max_map_count, e.g.:
>>>>
>>>> if (current->mm->mmap_count >= max_map_count() - 3)
>>>
>>> I enjoy seeing sysctl_max_map_count hidden. But map_count_capacity() is
>>> even more readable, so I like it.
>>>
>>> I don't complete like the "capacity" term, but I cannot think of
>>> something better right now. Maybe something around "free" or
>>> "remaining", not sure.
>>>
>>> I also don't completely like "map_count" (I know, I know, we call it
>>> like that in structures), because it reminds me of the mapcount ...
>>> talking somehow about "vmas" would be quite clear.
>>
>> Thanks David, my original implementation started with vma_limit() :).
>> Maybe something like vma_count_remaining() ?
> 
> Yes, reducing this confusion would very much be helpful.  In fact, if
> you put it in its own function we could change the actual name with
> lower impact.  map_count vs mapcount is annoying.
> 
> vma_headroom() ?
> additional_vma_space() ?

VMA space might be interpreted as VA space.

I think basing it on "vma_count" would be good.

vma_count_capacity()

vma_count_headroom()

vma_count_remaining()

vma_count_avail()

vma_count_left()

> 
> Maybe David would like:
> remedy_vma_space() which would be !poison_vma_space().. that's pretty
> clear.. :)

:D Careful, sensitive topic; I know that Lorenzo is still crying about 
this late at night when nobody watches, screaming "DAVID, WHYYYYYYY" ;)

-- 
Cheers

David / dhildenb


