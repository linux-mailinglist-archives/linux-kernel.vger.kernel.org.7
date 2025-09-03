Return-Path: <linux-kernel+bounces-798149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64675B41A07
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 11:30:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 162DC1A840F2
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 09:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43CEB2F1FFC;
	Wed,  3 Sep 2025 09:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gRD29229"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C99B42D595D
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 09:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756891720; cv=none; b=XkIEC9do2t79M+loscd97G16EEO3zmuERBxwu6b+a6AZhtEnwaS7reGLUnJTBCKIFhHR6mzp4hadOCGiZd7+v5JpURLSqK6DzxA6OZLRqgUqGrQVUDRrx/laO+ZiES5JpztxtarjSWjhoEjVfO9+Cprm2WuFxFyBXHLhFI1LFL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756891720; c=relaxed/simple;
	bh=03XIJd0Nz3YnwP4D/oijLsPOkXfl06YuJAjoy/gdFX0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ppjiMJIFYUEna5PPsI9S5aWFQaOG1wfIaC1Sx5kfHr96dT8uLmqutVwOt75bWUBojDR67eBgBZN/BNr77qx0Ldg/XDOP21p0e58B1HvCbPDODdEG+BH0gBfM18UsXvO68RsD19nGUp/rA6uaJ2Hb3WEzAZ44oSUBnSzq9y7wY/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gRD29229; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756891717;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=XagSL380WccLaX3yNvgvVCZJRmkRkG29drasxwyScUk=;
	b=gRD29229umt5B8pdP7aoVquZ9gMsVkM/CGKS3pSbnGNNywICZiPZj7RgdsXek1/GPcfh28
	fPZ3LfZ38ck5Q1QIBS04FzUOCo4/omJjx7255t9S9dSGRaV5XyCS+S/L/g9XJyc3t+1Y2s
	GIPkNSDXZbk5jW63SinWkhSoZmfZ+6s=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-99-F0r3V4GmMfu8ewaGScpIZA-1; Wed, 03 Sep 2025 05:28:36 -0400
X-MC-Unique: F0r3V4GmMfu8ewaGScpIZA-1
X-Mimecast-MFC-AGG-ID: F0r3V4GmMfu8ewaGScpIZA_1756891715
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-45b9c1b756cso6554165e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 02:28:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756891715; x=1757496515;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XagSL380WccLaX3yNvgvVCZJRmkRkG29drasxwyScUk=;
        b=O3OiTsZ9Ee7IX3y7Z6fdXO4moJUH1Rrv5ibPihYFT+MVvj5cdk26s86JiDIpGpgJF6
         UtksjsgWqQYNH/htvN9VUhzVU3FH8Zke3MA7IYuO2ntkBFuFObYP5zeNZlj45Sd1q/4Z
         h2Xocept4AD4CD7sZ5HspOpFq/MLlV/+quVq+/mpgeUDZTuzpoQq/PYoXelioxAWriFc
         XUy6wR+17r+TbkLaGGDqtlhlGe9CFTfuzY1LQHarPkvI1eoxmZX7x4putfvUfpNvrdE/
         7VGlrYdEwlkoDADAXqeHSXjy4HtgpUlSE+OG8pQOFpKz9LOJ9VBNdIA3UXRaKha4oVs7
         FryA==
X-Forwarded-Encrypted: i=1; AJvYcCXX8wu33jrJ6mhj0wDh6C4aPIBk+ymLN0MGDIHG/RH8wcje9Cpji0fNcEpJgdvpyXxh8YJhxyvjSc96rmg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRKAslFTdpV3AZVnYMZAn0VYNWSIruAW4bOALndJdbUqRweYJ5
	yIzVkH0zZ/KgmUitVH5u05gZ1CAVSu4DVNDBS4q4r9fKfwSzraLBm/LDKd8hTVSeU9N8oH6a8RN
	hodht67Ho3e9gKpyKrY7x9qG/YXtP0td3hRMg0cgbNyS5R8DCy0kqCpmndnTHPig9fQ==
X-Gm-Gg: ASbGnctrBexvH/WI59Ro3YTqChaXTXHy7Urlx1reI6BXLAHjW7C4NZpnsA/ZoQrFB4Y
	gnSmrh0kyLubJdVry2xkKRoKektYxbG2ullUuBjKQ+9bBzuoyOF3vGo1yQjGaNnMyN5B9/c24Xr
	iWzRtw4IBqTGwvLVwHl1EnSsue4f8F8HRVrZ5s5VC6CMNl428d490Wsq4jnYbtnoga2qb44eneK
	R9llPxjd/Y9BsQ/1eHxOBzoVuqLAi+yxJo6EbFDGza4rI26C6TapIq53JZqn3gFTckZe0S0sSAq
	cGCxexsoH7QaZxuGL1Et3F+DxKiiWyTqmKxZQPP9EBSmvMPlRvtiHn3/6ry3VgTT8O0pMBfg8fD
	flgeJm73VMmP6D6cKjAFYjF5GydK6ixl0Gp6nZYXDOc/LVRAVLUR2Q23AbAAMpWhoq3A=
X-Received: by 2002:a05:600c:4513:b0:456:1a69:94fa with SMTP id 5b1f17b1804b1-45b8554eb6amr113087295e9.13.1756891715124;
        Wed, 03 Sep 2025 02:28:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH3OIdbpC7eGStYBAaUEmvB6GqC1LGQrt2fa6m2+JUmDdqtUbkPiWQgVRbPGhaX+85Ybhui+g==
X-Received: by 2002:a05:600c:4513:b0:456:1a69:94fa with SMTP id 5b1f17b1804b1-45b8554eb6amr113087045e9.13.1756891714619;
        Wed, 03 Sep 2025 02:28:34 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f09:9c00:8173:2a94:640d:dd31? (p200300d82f099c0081732a94640ddd31.dip0.t-ipconnect.de. [2003:d8:2f09:9c00:8173:2a94:640d:dd31])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b9bcda91dsm54688595e9.6.2025.09.03.02.28.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Sep 2025 02:28:34 -0700 (PDT)
Message-ID: <baa1e5f6-d559-4874-a7c1-7daa7f1c3ce2@redhat.com>
Date: Wed, 3 Sep 2025 11:28:32 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/9] mm, swap: tidy up swap device and cluster info
 helpers
To: Chris Li <chrisl@kernel.org>, Baoquan He <bhe@redhat.com>
Cc: Kairui Song <kasong@tencent.com>, linux-mm@kvack.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Matthew Wilcox <willy@infradead.org>, Hugh Dickins <hughd@google.com>,
 Barry Song <baohua@kernel.org>, Nhat Pham <nphamcs@gmail.com>,
 Kemeng Shi <shikemeng@huaweicloud.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Ying Huang <ying.huang@linux.alibaba.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Yosry Ahmed <yosryahmed@google.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Zi Yan <ziy@nvidia.com>,
 linux-kernel@vger.kernel.org
References: <20250822192023.13477-1-ryncsn@gmail.com>
 <20250822192023.13477-5-ryncsn@gmail.com> <aK5/1so7a0i80+dz@MiWiFi-R3L-srv>
 <CACePvbU8pnjWCiWcSXRr4UdpuD_wdtrouLMz_fNB_=KRrdHLmQ@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <CACePvbU8pnjWCiWcSXRr4UdpuD_wdtrouLMz_fNB_=KRrdHLmQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 27.08.25 19:44, Chris Li wrote:
> On Tue, Aug 26, 2025 at 8:47 PM Baoquan He <bhe@redhat.com> wrote:
>>
>> On 08/23/25 at 03:20am, Kairui Song wrote:
>> ......
>>> diff --git a/mm/swap.h b/mm/swap.h
>>> index 223b40f2d37e..7b3efaa51624 100644
>>> --- a/mm/swap.h
>>> +++ b/mm/swap.h
>>> @@ -15,6 +15,8 @@ extern int page_cluster;
>>>   #define swap_entry_order(order)      0
>>>   #endif
>>>
>>> +extern struct swap_info_struct *swap_info[];
>>> +
>>>   /*
>>>    * We use this to track usage of a cluster. A cluster is a block of swap disk
>>>    * space with SWAPFILE_CLUSTER pages long and naturally aligns in disk. All
>>> @@ -53,9 +55,28 @@ enum swap_cluster_flags {
>>>   #include <linux/swapops.h> /* for swp_offset */
>>>   #include <linux/blk_types.h> /* for bio_end_io_t */
>>>
>>> +/*
>>> + * Callers of all swp_* helpers here must ensure the entry is valid, and
>>> + * pin the swap device by reference or in other ways.
>>> + */
>>> +static inline struct swap_info_struct *swp_type_info(int type)
>>> +{
>>> +     struct swap_info_struct *si;
>>> +
>>> +     si = READ_ONCE(swap_info[type]); /* rcu_dereference() */
>>> +     VM_WARN_ON_ONCE(percpu_ref_is_zero(&si->users)); /* race with swapoff */
>>> +     return si;
>>> +}
>>> +
>>> +static inline struct swap_info_struct *swp_info(swp_entry_t entry)
>>> +{
>>> +     return swp_type_info(swp_type(entry));
>>> +}
>>
>> swp_type_info() is only used by swp_info() in the whole series, can we
>> open code it in swp_info()?
> 
> BTW, off topic here. I really don't like the "_info" suffix. Anything
> you can put into a C struct by definition is some kind of information.

I guess we use "info" when we just have to have some metadata and we 
don't really find a better description / abstraction.

So I don't completely hate the "_info" suffix here.

> Same to the _struct. Anything defined by a struct is a struct. Don't
> need to say that.

Yeah, at some point people thought it would be a good idea to do that 
(mm_struct, vm_area_struct).

> The "struct swap_info_struct" gets two of the unnecessary words. It
> should be something like  "struct swap_file" or "struct swap_device".
> Renaming it is too invasive to the code base and it will mess up the
> git annotation history.

I wouldn't be scared about doing something like that that actually 
improves the code.

You'd likely have to find an abstraction for "swap_file" and 
"swap_device", and maybe that was the challenge back then.

swap_info_struct has a comment above it "in-memory structure used to 
track swap areas". So naturally I would just have call this "swap_area".

-- 
Cheers

David / dhildenb


