Return-Path: <linux-kernel+bounces-797988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58FF3B41818
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 10:11:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4234D3BB21D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 08:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFE082E7BDA;
	Wed,  3 Sep 2025 08:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TyrXk/NQ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA812E62B4
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 08:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756887074; cv=none; b=BMDIZKpBqp3kNoK6gVwQ6yn8A5fvIGxv1wa8Ngw1TSWcv4LXJq2gOXYNVyQso6sPgxJq0a750Au7XolwvuSYrAJscv4r0smCODpdy+mZUiA7ztsrWQE4GeWZb4+K5km0P8eh84PvbuVx3GM7NMl/vP+UuxiK1u/g0pDNG+6HU6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756887074; c=relaxed/simple;
	bh=WFb5NsGQMehScrncHkSRfKHFaad12RZWRtjrznFDSDs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rKoZaKOWq+w5IPbFJ+mK7LR5hViIXFZaxzzu/bGeZ0BI51JA+OQXt8RShzQvthFOYvuHmT5S5K1MkeLqnLC0ByiI0/gYG8P+quwV4xWtCNu+b1Dg4uyCnpgL5KIYvzZD15ilJhoy+My209hWVoZCLFgI9oGPWDpH43hi/XCdk0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TyrXk/NQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756887070;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=8UkxVY/g1eI/pJSPhScZgnxFl4cSUR/RLbF6nS7dre8=;
	b=TyrXk/NQksavwA4asZcQZ/ICxNncpkzWqSCaqzoatx3nLE4rANYLSCf3lSRqDzYLMaJyYx
	T6kXKC9HpuzwR/QciD3P050b5wPblEopY6bJD1havkxKR7b33faKOy0cPRPAYxYUKRW7Xt
	vOcuqr/wpB6Kbbtbm6YHIsJNlGjavUg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-70-8QWwsJxXMFey8MyyY4XTSg-1; Wed, 03 Sep 2025 04:11:09 -0400
X-MC-Unique: 8QWwsJxXMFey8MyyY4XTSg-1
X-Mimecast-MFC-AGG-ID: 8QWwsJxXMFey8MyyY4XTSg_1756887068
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-45b8af0b986so4852465e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 01:11:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756887068; x=1757491868;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8UkxVY/g1eI/pJSPhScZgnxFl4cSUR/RLbF6nS7dre8=;
        b=nO7tuZMPVJeJ8mA90Jjp4PHcoMPt5QvlJFHaM4HWzmFEDp6sAUSmVRGyfhCZwQJW27
         7N4yh3r4xltw9UdaXkrw3FEEf9eI47bgQ6ZdivH0yu/QSWxBkF0zY+Z5pOx9ALfCpqdI
         FEb2PPx1X/VCmA9au2GHNAhDJuFUD/sDyfPk9EsXaBIq4R/uMtkmuvDPPauPt/nzz68m
         pwk/wfwFOtUwDrFarxxbz8Kp6t+fRUcWVt+KVLx37ihK8cYADFMB9NbX8dYLEmXouhOs
         OYap3wLgpuUB4e1rvn4d+PE12zhxS89dxblkHEK8BjwxPR8Ua80lTnrsxY8oxhQ3ViWF
         swvQ==
X-Forwarded-Encrypted: i=1; AJvYcCUo1BHZU+fosYSHBhp3MB5tZCRt6owgATuiQDQ0IhhLSWEdinSO8DHQow50E67jXpAFlOadldQYiU+e99Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEu13/VbMnQBXAGYedDo2wtOF0U7th7zBX+clS+oXd9WGP716a
	XtGbjQws/gQtlOGExFn+kH0l1+TfYMHBWkHeGdk5Wa3ELEkDxwaQ1ouvtsGoRIWxhRCNulb8VWj
	oMJiXfhWrw6/gyi1ahkzBca/lle/GHR7IHqQgXIXkRRTltfwqkj/5AAejBoKD/deFiQ==
X-Gm-Gg: ASbGncux05rCqcLIuC27ChS198tbS859VL4BtdQ0APgTyy5Xc9nkzpQjUWkJ7sqw3+j
	UfJ99jrhACu85PaLo1n0WxjvqacTZSSdL0eHq6Ri3ZWZZ/ogteeGn91zm0udiifh9aH60QpNWLt
	tKu7ujyXR3UwkLNA+9eefpSzEh8BIR3LhjuGGScf3MY4iOBg20g5RQNAQN25OXxODDml2Ipx/ft
	U18z8Qtzi98x7t1Mwpn4mPfh7BoELu6bysUS/3uY8FodwJs/kPm62F9g1N+LW+pYLiJ03cvVlWR
	5+5vBfEL2swwNh5LQZjaCsF7UaHFnYQMg625dOAbTp0TTTGoom4/N98xmBSYnKX1C/E3WtuIH+Y
	8Chjwu9NubleJkBXDaVbfPNlqiEjoBEP+ceJNXNVXrLdGnOsAM67zwJyeMqhkMOj9Spg=
X-Received: by 2002:a05:600c:c4a1:b0:459:443e:b18a with SMTP id 5b1f17b1804b1-45b8559aff8mr131317575e9.14.1756887068425;
        Wed, 03 Sep 2025 01:11:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEDxGXVQhvmfQ7QL41Vte3hx4orJbJWoRMyeFq2/Ey7ZnhPJtVK5izMGQC+aAFle3fgJPi6zg==
X-Received: by 2002:a05:600c:c4a1:b0:459:443e:b18a with SMTP id 5b1f17b1804b1-45b8559aff8mr131317115e9.14.1756887067920;
        Wed, 03 Sep 2025 01:11:07 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f09:9c00:8173:2a94:640d:dd31? (p200300d82f099c0081732a94640ddd31.dip0.t-ipconnect.de. [2003:d8:2f09:9c00:8173:2a94:640d:dd31])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b7c461edasm140355785e9.9.2025.09.03.01.11.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Sep 2025 01:11:07 -0700 (PDT)
Message-ID: <cd52244b-12f6-43aa-9db2-925348566bed@redhat.com>
Date: Wed, 3 Sep 2025 10:11:05 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/9] mm, swap: tidy up swap device and cluster info
 helpers
To: Kairui Song <ryncsn@gmail.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 Matthew Wilcox <willy@infradead.org>, Hugh Dickins <hughd@google.com>,
 Chris Li <chrisl@kernel.org>, Barry Song <baohua@kernel.org>,
 Baoquan He <bhe@redhat.com>, Nhat Pham <nphamcs@gmail.com>,
 Kemeng Shi <shikemeng@huaweicloud.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Ying Huang <ying.huang@linux.alibaba.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Yosry Ahmed <yosryahmed@google.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Zi Yan <ziy@nvidia.com>,
 linux-kernel@vger.kernel.org
References: <20250822192023.13477-1-ryncsn@gmail.com>
 <20250822192023.13477-5-ryncsn@gmail.com>
 <39087ce8-6f6a-4998-95e4-813e265318d0@redhat.com>
 <CAMgjq7C+mChdnbcrYEkKyuuRN9-THXwBdFeCVwvW_m-_CWCzvw@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <CAMgjq7C+mChdnbcrYEkKyuuRN9-THXwBdFeCVwvW_m-_CWCzvw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 02.09.25 17:03, Kairui Song wrote:
> On Tue, Sep 2, 2025 at 10:14 PM David Hildenbrand <david@redhat.com> wrote:
>>
>> On 22.08.25 21:20, Kairui Song wrote:
>>> From: Kairui Song <kasong@tencent.com>
>>>
>>> swp_swap_info is the most commonly used helper for retrieving swap info.
>>> It has an internal check that may lead to a NULL return value, but
>>> almost none of its caller checks the return value, making the internal
>>> check pointless. In fact, most of these callers already ensured the
>>> entry is valid and never expect a NULL value.
>>>
>>> Tidy this up and shorten the name.
>>
>> Shorter != better. But yes, "swp_swap" was a mess.
>>
>>> If the caller can make sure the
>>> swap entry/type is valid and the device is pinned, use the new introduced
>>> swp_info/swp_type_info instead. They have more debug sanity checks and
>>> lower overhead as they are inlined.
>>>
>>> Callers that may expect a NULL value should use
>>> swp_get_info/swp_type_get_info instead.
>>
>> High-level comments:
>>
>> 1) I hate the "swp" vs. "swap". Is that a valuable distinction or could
>> we just convert it to "swap" as we touch it?
> 
> Totally agree. I was just blindly following the old style. It's kind
> of confusing indeed.

... and not a lot of space saved :)

> 
>>
>> You're converting swap_type_to_swap_info() to swp_type_to_swap_info(),
>> and I am not sure if that is the right direction :)
>>
>>
>> 2) Can we just call it "swap_entry" when we work on a swap entry and
>> "swap_type" when we work on a swap type in the function name?
>>
>> swp_info() is a rather bad function name.
>>
>>
>> 3) I am not sure about "to" -> "get". "to" is much more readable in that
>> context and consistent.
>>
>>
>> 4) swp_info[] vs. swap_info() gah.
>>
>>
>> I would just have done:
>>
>> swap_type_to_info(int type)
>> __swap_type_to_info(int type)
>> swap_entry_to_info(swp_entry_t entry)
>> __swap_entry_to_info(swp_entry_t entry)
>>
>> __ are the expert functions where we don't expect NULL.
>>
> 
> Thanks a lot for the suggestions! I also like the idea of using "__"
> to seperate the non-NULL version a lot and implis the caller have to
> careful.

Right, it's the "pro" version :)

> 
> My concern was that names will be getting very long in later commits
> following this convention. Which is also the reason I want to shorten
> them here.
> 
> A lot of SWAP relate operations will be cluster based, so it will be
> very common to get offset or the swap cluster from a swap entry.
> We will end up having a really long name like
> __swap_entry_to_cluster_offset (convert swap entry to offset inside a
> cluster).

That's a perfectly fine length though :)

> 
> Since we already have the swap entry type called `swp_entry_t` and
> helprs like `swp_offset` and 'swp_swap_info' that convert an entry to
> other swap things, so I thought that anything converts swap entry /
> offset to others are named `swp_*`.

Yeah, I think that's just bad historical baggage we should clean up at 
some point.

> 
> Maybe a bad practise here, we can fix it while at it, or at least no
> longer introduce more confusing names.
> 
> I can follow this suggested style, will it be a good idea if we have
> following set of helpers?
> 
> For swap cluster and swap device (swap_info_struct):
> swap_type_to_info(int)
> __swap_type_to_info(int)
> swap_entry_to_info(swp_entry_t)
> __swap_entry_to_info(swp_entry_t)
> __swap_offset_to_cluster(struct swap_info_struct *, pgoff_t)
> __swap_entry_to_cluster(swp_entry_t)

Looks great to me, but let's hear other opinions.

> 
> And for offsets, we still use:
> swp_offset() (Existing helper)

Yeah, there's also "swp_type" and "swp_offset_pfn". They really only 
extract basic properties of the entry, so they are a bit special.

I think we should call them "swap_entry_offset" "swap_entry_type" 
"swap_entry_pfn".

Now, that's not something I would expect in your series.

> swp_cluster_offset()

That one could later become swap_entry_cluster_offset()

> 
> Now all swp_* helpers are pure arithmetic operations (we just renamed
> swp_swap_info which seems the only exception). Is this better?

I'm already happy once we name+document the new functions properly.

I could probably live with "swp_cluster_offset" for the time being :)

-- 
Cheers

David / dhildenb


