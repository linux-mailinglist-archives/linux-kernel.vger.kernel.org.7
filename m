Return-Path: <linux-kernel+bounces-743891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 82F75B10515
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 11:00:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49FEB7A7D77
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 08:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75190275B09;
	Thu, 24 Jul 2025 08:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EQtU3pZK"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D235A274FCB
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 08:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753347183; cv=none; b=ha8zFsVgYHSlEIBl1e8p9KEMA/uR+RkNVkS8KEel0f4ZxLya4F0p7vLCCP7f+mlnY4HHv+UkhEhhXeqKGEyXRsLphutA15d1xXp8KZsJP1NnuHmYKu6fW4l4pzjC+3oZnZ13CpkblUnihqABBwuCwZTWwzMlaR7MUsfG/2gCLuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753347183; c=relaxed/simple;
	bh=IRi5oEmDJUpMIypzUFpLa5hQ8fOukFELiqlwbtSM4s0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=msi4HbO2tsGb3pyKHRxfHiRIyRTqrEREYjZ+Z/DfJsIbK9qXIb8OeYz9VKrz2spVRdDm4lh/9ha+r+itBs6llj2cE6EqPV3mqrAoASZviidQHv1jsw5DIQboIrrrSMOw7lq9MdDkLRQ8MwhlvtY3MvW2Lu+djQJtRXhZ4RFQfpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EQtU3pZK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753347180;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=eSRWHNR3oSryq2XtU/spTQx/p9VSczkNbYfeDDaHpfg=;
	b=EQtU3pZKsVcqalR19MUJ3IPfcgJkxvCcvkv1hHYnmA1IJCW8sem4JY+9WN+b/zWmR+CAbA
	Mj/lHor23rCjzbThtd8lgbGcMR3JvKe4BnsuOUF2lmnaK1ZxNbEWLmoPZ0aWOmwmvOb7FZ
	hFWbBKw2ym+ZNMxDKl0ZNnbxI6fzU7M=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-119-vLOyQKllOeKyJcTHyPFIvw-1; Thu, 24 Jul 2025 04:52:59 -0400
X-MC-Unique: vLOyQKllOeKyJcTHyPFIvw-1
X-Mimecast-MFC-AGG-ID: vLOyQKllOeKyJcTHyPFIvw_1753347178
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-451ecc3be97so3965445e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 01:52:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753347178; x=1753951978;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eSRWHNR3oSryq2XtU/spTQx/p9VSczkNbYfeDDaHpfg=;
        b=hz2TmqzMP3ST8PUValQB5t2EiA1NCZsbT0/XQTHrUUmhUpnXSYE3rq5HvWaf1QlaFS
         yW6vZQax9xvzBb6sdK3FjjC9eTaAY/dXIB8Kg0ADdgRQlL+UN7fOUuQxcUh/1LBw2qiY
         E2MADqH+sc8w8kZRmeKJ8CshMccosjArQIcA7qvvmADSrg/Vf0uzXI1nHymm6s1jY4AK
         A9QbSkJ4kKQL/wmZQlkGheITf2uyU0CzthEyukcca9JMKt0vPf7zlZ7iQl+WyIm4R9zH
         Bg0Abu3uLHbuRsYtOtLsmo2jOF0jpTOdm8+zxyS3kScmc1+5fsPRylix+Z6sMPqRt0Vh
         cHPA==
X-Forwarded-Encrypted: i=1; AJvYcCXDnI2pgPZeAdQg2rZ7GVIy/1iVrPsw9Qwn3QRtuEGRHjt/YAdq8UFUlHxG2Jj5AJDHR/kf4+R7NwEOqEw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXabEU5Y+iXFWtvyMAyuHnePbsLetJ6Z53RzpKtRTN905Aza5x
	Yatu59SI7xSvfe4blnfYPiwVNNwVI5PgsfyjHI+2snRl6CIakOQ0vNjEnEAnR1SypHQJYS+f/sd
	WA3GfrgUMtr3XY8cvhK/2oWb0VzjkmCelYMvcHng1y4Fq2GZ6NDP2eGgsMyNBOe3bPw==
X-Gm-Gg: ASbGnctZ0xyYKu9v5sueJUxmFWrH+InK0Y5CCzew7XuDexqPjaGhs775+OJ8/T4Y272
	U4xnR+4zdNwNwr4rQtAGgDY5zUCfZ7NCs0XIZn5TJQKR5hhnZrdmgPuufZgxeclqHMGtanTbiRg
	SkF9fMtUitONrjugGWWg4HvdyqmaQmtnnSJG8IMSySO++c2/UE917XZMS4NeIsDsLuTK5Caceun
	8XVRWvO/LwlCe32VpYk2hKCwnpNjkW5ZlNnoTSpPlbDn3MeVp2HmwIHVCfy/T2+QDBzt992pDLP
	vXpZhLA7a6u16sNUc4GHUjBsCYb7ZZbjn/yXl5DbQ4vvVcGC3Yu9wSkw/DpFIn2f8Bt4UJ/Epec
	0Mx7xbipRz9y+vRe+fD7tjjwLir+LAuoXMDDdzqgNZn+wfq2qm8onVV/16k3TYC+4
X-Received: by 2002:a05:6000:1884:b0:3a8:30b8:cb93 with SMTP id ffacd0b85a97d-3b768ef953dmr4588651f8f.32.1753347177755;
        Thu, 24 Jul 2025 01:52:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEoD8bQhLMR7nrUTvI3JvUWW9/Pn8ZIBrS4iPYjqfRFSc5RU+yNx7pIBUo5X7x71tBeIaa94w==
X-Received: by 2002:a05:6000:1884:b0:3a8:30b8:cb93 with SMTP id ffacd0b85a97d-3b768ef953dmr4588610f8f.32.1753347177191;
        Thu, 24 Jul 2025 01:52:57 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f1f:5e00:c941:d6fb:3e30:b42? (p200300d82f1f5e00c941d6fb3e300b42.dip0.t-ipconnect.de. [2003:d8:2f1f:5e00:c941:d6fb:3e30:b42])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b76fcc43c2sm1436739f8f.83.2025.07.24.01.52.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Jul 2025 01:52:56 -0700 (PDT)
Message-ID: <a3f1af02-ef3f-40f8-be79-4c3929a59bb7@redhat.com>
Date: Thu, 24 Jul 2025 10:52:54 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] mm/hmm: HMM API to enable P2P DMA for device
 private pages
To: Alistair Popple <apopple@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: Matthew Wilcox <willy@infradead.org>, Yonatan Maman <ymaman@nvidia.com>,
 =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>, Leon Romanovsky
 <leon@kernel.org>, Lyude Paul <lyude@redhat.com>,
 Danilo Krummrich <dakr@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Ben Skeggs <bskeggs@nvidia.com>,
 Michael Guralnik <michaelgur@nvidia.com>, Or Har-Toov <ohartoov@nvidia.com>,
 Daisuke Matsuda <dskmtsd@gmail.com>, Shay Drory <shayd@nvidia.com>,
 linux-mm@kvack.org, linux-rdma@vger.kernel.org,
 dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Gal Shalom <GalShalom@nvidia.com>
References: <20250718115112.3881129-1-ymaman@nvidia.com>
 <20250718115112.3881129-2-ymaman@nvidia.com>
 <aHpXXKTaqp8FUhmq@casper.infradead.org> <20250718144442.GG2206214@ziepe.ca>
 <aH4_QaNtIJMrPqOw@casper.infradead.org>
 <7lvduvov3rvfsgixbkyyinnzz3plpp3szxam46ccgjmh6v5d7q@zoz4k723vs3d>
 <aIBcTpC9Te7YIe4J@ziepe.ca>
 <cn7hcxskr5prkc3jnd4vzzeau5weevzumcspzfayeiwdexkkfe@ovvgraqo7svh>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <cn7hcxskr5prkc3jnd4vzzeau5weevzumcspzfayeiwdexkkfe@ovvgraqo7svh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 23.07.25 06:10, Alistair Popple wrote:
> On Wed, Jul 23, 2025 at 12:51:42AM -0300, Jason Gunthorpe wrote:
>> On Tue, Jul 22, 2025 at 10:49:10AM +1000, Alistair Popple wrote:
>>>> So what is it?
>>>
>>> IMHO a hack, because obviously we shouldn't require real physical addresses for
>>> something the CPU can't actually address anyway and this causes real
>>> problems
>>
>> IMHO what DEVICE PRIVATE really boils down to is a way to have swap
>> entries that point to some kind of opaque driver managed memory.
>>
>> We have alot of assumptions all over about pfn/phys to page
>> relationships so anything that has a struct page also has to come with
>> a fake PFN today..
> 
> Hmm ... maybe. To get that PFN though we have to come from either a special
> swap entry which we already have special cases for, or a struct page (which is
> a device private page) which we mostly have to handle specially anyway. I'm not
> sure there's too many places that can sensibly handle a fake PFN without somehow
> already knowing it is device-private PFN.
> 
>>> (eg. it doesn't actually work on anything other than x86_64). There's no reason
>>> the "PFN" we store in device-private entries couldn't instead just be an index
>>> into some data structure holding pointers to the struct pages. So instead of
>>> using pfn_to_page()/page_to_pfn() we would use device_private_index_to_page()
>>> and page_to_device_private_index().
>>
>> It could work, but any of the pfn conversions would have to be tracked
>> down.. Could be troublesome.
> 
> I looked at this a while back and I'm reasonably optimistic that this is doable
> because we already have to treat these specially everywhere anyway.
How would that look like?

E.g., we have code like

if (is_device_private_entry(entry)) {
	page = pfn_swap_entry_to_page(entry);
	folio = page_folio(page);

	...
	folio_get(folio);
	...
}

We could easily stop allowing pfn_swap_entry_to_page(), turning these 
into non-pfn swap entries.

Would it then be something like

if (is_device_private_entry(entry)) {
	page = device_private_entry_to_page(entry);
	
	...
}

Whereby device_private_entry_to_page() obtains the "struct page" not via 
the PFN but some other magical (index) value?

-- 
Cheers,

David / dhildenb


