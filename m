Return-Path: <linux-kernel+bounces-808075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D3171B4ACCE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 13:51:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9AB9189E806
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 11:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6655430DD09;
	Tue,  9 Sep 2025 11:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BoLA4okF"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A266B2FF679
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 11:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757418659; cv=none; b=Q+cld3VssvvdM7qdb/Do1TSqms9FqPH9k/V+ZGlNI8qq+juETXikRGMQbcy1iOzAxweEQb9HZkpWDSiGJQHOFUiartX1skOnv9AK6gzPG4C2KZe/WnlItCJEjMasz/yS5p3frWp27Sqgy5d+rHcFmDn+fCuZnFKy1GMgEk/Mw7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757418659; c=relaxed/simple;
	bh=2n0fXqoZ6LrgkaP/DSmo/LhsRRE3Z+h4X2s4DuRlSpY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Kipdhh+0arRqmvv7HFkV196LLC/YZmZfmlHjJRKBxWcPvc1huxI85GnY8XoRxrfkk4cobJZ5YbSKcmLIeoPR4N0Xrz+TkyLkdjoqzf7blNmK/BErfI5CeMiL4OFDMZpaOIo/IdcJg2V2xXbewgdbg6FjYg0ZRmfRjyFBvYVnpmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BoLA4okF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757418656;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=dKhIp6hIrUR6EZQSai8TLK9KbdoogTZRgdnHTmgwxEY=;
	b=BoLA4okFrh/31z27+nxfr9S1ITPg4IMeH8LX33URvuaRmFFwctwGG696NrWZO3h+CoRHQL
	stswVWhGbDmacixX4KY2lR63LcGu95WeiLBGMi90UPTwsGK9w70HzMN4AOVIdOh24tKPM+
	f2FTINRjydaWRy+UBYcjkOOkQhVUan4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-182--aMLRd51Mq28FcYZMpzTdA-1; Tue, 09 Sep 2025 07:50:55 -0400
X-MC-Unique: -aMLRd51Mq28FcYZMpzTdA-1
X-Mimecast-MFC-AGG-ID: -aMLRd51Mq28FcYZMpzTdA_1757418654
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-45de14da365so23408585e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 04:50:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757418654; x=1758023454;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dKhIp6hIrUR6EZQSai8TLK9KbdoogTZRgdnHTmgwxEY=;
        b=P5S2faUKUOYQ569OQOXmrrEly9WwYg8NnettO30zGQ4lwCAadmhAiGwyaEKxvK0ZRl
         uEGlSqDNoubpO/b3xlWkCaBIEk1osN/WKKFi9/Aa1YeE3ISiTmMeycaKgVaLHLcYylKp
         QSy633sRYMseymcakQmHzUf6VzGE1PLHV/WqalwMZzZdGfOWsXwlvBdqFdCzh7Iom8kA
         kvjaJs2SIvk+9sKH2ZgnQHMdg6WoB1Z+5kZoOWwaFqwXXieXvwmTuI9HASQ890xnCmLF
         h7czFlC/f75sP33+8qPqbzyoyUMDMVxD/zYorV+XeWwhkC+0Wz6sCc6NhvFWFpoMERD/
         Ek2A==
X-Forwarded-Encrypted: i=1; AJvYcCXc5liz0trhFathiaoHlQ+jwaWyjIB7pOHn3EVcDl61C/hia1Dj+ThguwWKuZhgeUcXQFMZEqC+Pu+dzfc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3D1UFyaIwZNu+91pkV1HENJjTY9JyN3+I0VZxEC2R27twUjy7
	N+ymae0grJbl7RsVkzgIt8du7i7/ebvif67EiUKRep1nWCJKh+0w4w1RS2nHtT6LfsBXtjt3lPt
	uAm+Vi9j1zvqVBjckdV7Pob4w7pQWduqBcWwKN9d2+JI8xQ4zuk3f3uWilL9XBmBEeQ==
X-Gm-Gg: ASbGncuy5vxOCcVcslxuE+WKKsYellD4DxEuwd44/rtz6PjMqySCcOyHsr3YjI+w2cA
	MLKUX9TCrV7dZc+DQIF3BQhgL79w9c27f6kUbHn7lTVe0MrPtHUAV7rbxGOmLNQ1RdWxnjG8WQx
	tWE85fYhdy18J/q0eGjhGHnFhXwRLuwjwnCVbXg33I+zjuwhdfzvFqj/YWvBlnaO2iWiqtVxMFS
	/4EqaZK9ICulwugoTC3+gej5sBVcS3Fr0BjkXk2PLLGTmVYYJwWZv8OMyIJYRjSMt4yDBM5tk/z
	t2YeAVzKhBA+ZnpOswj5J6mw688cA0ftW36lJeTb1oDxGH182jgkaV0ZKsm5CTOsB7HQXwanWCW
	mr5CMXEpLz1ZIIIpDxtO3AS9s/mqnkoB6a0s87lpLU55YEGfZudftEtVyjMSKkqhueQk=
X-Received: by 2002:a05:600c:1390:b0:45a:236a:23ba with SMTP id 5b1f17b1804b1-45ddded76a6mr93180005e9.22.1757418653870;
        Tue, 09 Sep 2025 04:50:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFLYxXGJ3JeYQUXq3Qs+8TSlviw2rq3zJWOHMDGMzgm5GnZu4lD6nyVRrpMbata0TKkHbHy/g==
X-Received: by 2002:a05:600c:1390:b0:45a:236a:23ba with SMTP id 5b1f17b1804b1-45ddded76a6mr93179675e9.22.1757418653373;
        Tue, 09 Sep 2025 04:50:53 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f23:9c00:d1f6:f7fe:8f14:7e34? (p200300d82f239c00d1f6f7fe8f147e34.dip0.t-ipconnect.de. [2003:d8:2f23:9c00:d1f6:f7fe:8f14:7e34])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b9a6ecfafsm339135615e9.21.2025.09.09.04.50.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Sep 2025 04:50:52 -0700 (PDT)
Message-ID: <655d2d29-8fe6-4684-aba4-4803bed0d4d0@redhat.com>
Date: Tue, 9 Sep 2025 13:50:51 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/gup: Drain batched mlock folio processing before
 attempting migration
To: Will Deacon <will@kernel.org>, Hugh Dickins <hughd@google.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Keir Fraser <keirf@google.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 John Hubbard <jhubbard@nvidia.com>, Frederick Mayle <fmayle@google.com>,
 Andrew Morton <akpm@linux-foundation.org>, Peter Xu <peterx@redhat.com>,
 Rik van Riel <riel@surriel.com>, Vlastimil Babka <vbabka@suse.cz>,
 Ge Yang <yangge1116@126.com>
References: <20250815101858.24352-1-will@kernel.org>
 <c5bac539-fd8a-4db7-c21c-cd3e457eee91@google.com>
 <aKMrOHYbTtDhOP6O@willie-the-truck> <aKM5S4oQYmRIbT3j@willie-the-truck>
 <9e7d31b9-1eaf-4599-ce42-b80c0c4bb25d@google.com>
 <8376d8a3-cc36-ae70-0fa8-427e9ca17b9b@google.com>
 <aLGVsXpyUx9-ZRIl@willie-the-truck>
 <7ce169c2-09b7-39e3-d00b-ba1db6dd258c@google.com>
 <aMAR1A1CidQrIFEW@willie-the-truck>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <aMAR1A1CidQrIFEW@willie-the-truck>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 09.09.25 13:39, Will Deacon wrote:
> On Fri, Aug 29, 2025 at 08:46:52AM -0700, Hugh Dickins wrote:
>> On Fri, 29 Aug 2025, Will Deacon wrote:
>>> On Thu, Aug 28, 2025 at 01:47:14AM -0700, Hugh Dickins wrote:
>>>> diff --git a/mm/gup.c b/mm/gup.c
>>>> index adffe663594d..9f7c87f504a9 100644
>>>> --- a/mm/gup.c
>>>> +++ b/mm/gup.c
>>>> @@ -2291,6 +2291,8 @@ static unsigned long collect_longterm_unpinnable_folios(
>>>>   	struct folio *folio;
>>>>   	long i = 0;
>>>>   
>>>> +	lru_add_drain();
>>>> +
>>>>   	for (folio = pofs_get_folio(pofs, i); folio;
>>>>   	     folio = pofs_next_folio(folio, pofs, &i)) {
>>>>   
>>>> @@ -2307,7 +2309,8 @@ static unsigned long collect_longterm_unpinnable_folios(
>>>>   			continue;
>>>>   		}
>>>>   
>>>> -		if (!folio_test_lru(folio) && drain_allow) {
>>>> +		if (drain_allow && folio_ref_count(folio) !=
>>>> +				   folio_expected_ref_count(folio) + 1) {
>>>>   			lru_add_drain_all();
>>>
>>> How does this synchronise with the folio being added to the mlock batch
>>> on another CPU?
>>>
>>> need_mlock_drain(), which is what I think lru_add_drain_all() ends up
>>> using to figure out which CPU batches to process, just looks at the
>>> 'nr' field in the batch and I can't see anything in mlock_folio() to
>>> ensure any ordering between adding the folio to the batch and
>>> incrementing its refcount.
>>>
>>> Then again, my hack to use folio_test_mlocked() would have a similar
>>> issue because the flag is set (albeit with barrier semantics) before
>>> adding the folio to the batch, meaning the drain could miss the folio.
>>>
>>> I guess there's some higher-level synchronisation making this all work,
>>> but it would be good to understand that as I can't see that
>>> collect_longterm_unpinnable_folios() can rely on much other than the pin.
>>
>> No such strict synchronization: you've been misled if people have told
>> you that this pinning migration stuff is deterministically successful:
>> it's best effort - or will others on the Cc disagree?
>>
>> Just as there's no synchronization between the calculation inside
>> folio_expected_ref_count() and the reading of folio's refcount.
>>
>> It wouldn't make sense for this unpinnable collection to anguish over
>> such synchronization, when a moment later the migration is liable to
>> fail (on occasion) for other transient reasons.  All ending up reported
>> as -ENOMEM apparently? that looks unhelpful.
> 
> I see this was tangentially discussed with David on the patches you sent
> and I agree that it's a distinct issue from what we're solving here,
> however, -ENOMEM is a particularly problematic way to report transient
> errors with migration due to a race. For KVM, the -ENOMEM will bubble
> back up to userspace and the VMM is likely to destroy the VM altogether
> whereas -EAGAIN would return back to the guest and retry the faulting
> instruction.

Migration code itself will retry multiple times, which usually takes 
care of most races.

Not all of course.

Now, I recall John was working on that at some point (I recall an RFC 
patch, but I might be daydreaming), and I recall discussions at LSF/MM 
around improving handling when we are mixing a flood of short-therm gup 
with a single long-term gup that wants to migrate these (short-term 
pinned) pages.

Essentially, we would have to temporarily prevent new short-term GUP 
pins in order to make the long-term GUP-pin succeed in migrating the folio.

-- 
Cheers

David / dhildenb


