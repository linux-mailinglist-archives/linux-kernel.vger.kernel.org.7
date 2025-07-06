Return-Path: <linux-kernel+bounces-712809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DCA5AF0F42
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jul 2025 11:11:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C0AD3A1A42
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jul 2025 09:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96A8C23D29E;
	Wed,  2 Jul 2025 09:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bqjnEmUB"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F7923C4F8
	for <linux-kernel@vger.kernel.org>; Wed,  2 Jul 2025 09:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751447482; cv=none; b=rgXFa8rjpregFRI2+0v/rESNAUpH7+FrcHA4cxvS/OQtj2aCwdqQ72vbVjDjv0XRe65NVCAUvfO4yt/q1mk0MKrBu1LCTpox8b9iDjFaJqRUjilzlwtFGzLZGBpXHXjvx59KsHWQhW00fNdxscse2jIJux8wrIcU5HJRN6NLy3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751447482; c=relaxed/simple;
	bh=WRqtcuGqGlSNkkRKp5o9OVKUg6XS/83r0TXNPQQBlWk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g05GCsobQvIzv4I9wCd5zb1tQRueCFFUH+EZg41PH6UZtbToUZHnNRi0kd48gqQwJF6Yey/imxsvbrEN3DrLAL0rwW1Bk+BezVU7IO4Ijbd5aq8JunDJIAV8GfkBg3n2JBeB0cJq7YnOj6JB4VHjv823K9aW/FaR5Gm3uiZIYqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bqjnEmUB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751447480;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=gB2c1lvXTPUU8lAcDb8yV8BpUQhaQDga1PKrbM3zRiE=;
	b=bqjnEmUB8aG9pJ+B8CjSw5pcZT6/fbiuua0AR9SybVbh0akFR5YgduGGkt46LfbwyyD1Kn
	RAu3ZNjDi0WkhJr74O46wu1zIDdEBvtzjURD+eYCTRMtChBk2D+5lp8PYro837ZciCBm9V
	HcQuT2izBBRpSC1lHfMcEoK/8rtoxxo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-130-JlG-64oWNTaTzebiXs7ctg-1; Wed, 02 Jul 2025 05:11:19 -0400
X-MC-Unique: JlG-64oWNTaTzebiXs7ctg-1
X-Mimecast-MFC-AGG-ID: JlG-64oWNTaTzebiXs7ctg_1751447478
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-451d3f03b74so34212905e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jul 2025 02:11:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751447478; x=1752052278;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gB2c1lvXTPUU8lAcDb8yV8BpUQhaQDga1PKrbM3zRiE=;
        b=OFrbzM40ERvirxmDIRgoi4pca/6CNN6U/hK6R2UkzpVfn3KOkOEGmaR2Ur1c56fcMm
         xYm1UwpnwS2LBFrbuo/7DVLzE2LTu4+23t+5MqSIxesxyDs52JK2xDGaEOq0Xox8rSt2
         mu1IR0i+TukZSUnKmVcfNe+Q4HZAK0vwKnG2Bwx6+qC5/MUWmlx12uxDXKc41Qi35IdF
         YPQN8QZVF4WBgYYCfMCJeUpz+VsuCucDzA0Z22oHOnh6Un9P6Z5GYxgTSucFDFWJsdjb
         Yy62Batmkj6wYsuHEevNbWZQQOMwTvwWbRJynf6XUhIp4Ep1cjRaPTTe/dEaqZ1UZuAX
         1KDw==
X-Forwarded-Encrypted: i=1; AJvYcCXnjSpCKrAnTDUOfDRQsySa4xdVrcBh07UbtgXVcxdrMEqpRhfVBW8f4VXmijrhftCYGUBUWncY2zihZok=@vger.kernel.org
X-Gm-Message-State: AOJu0YyN/oTk+bMXNPcCpcmxhqbJ9ZgxGkBklVRk6w+CI24e+ZPzYmox
	oLfzH11KTshyIaJvSwSZLaD9f0v9Hke7R6bVj7JCMMl3sNjA5G9LCk6kN7j4NumTGu5ifs181hg
	Ogi0IazIH4v2Qwjan9sYgIsj8URs5SO1oACIXtp0aSzba0MQRuDgJ94rGchDXu2gMAw==
X-Gm-Gg: ASbGncv92zMRJFVY0OEhPYTZa5hR3pea64dszlFxfiqIOZRq4C076oyl95sy10UwImq
	P0FrhOvofnwmvG33T2wgqYqf/b19f3JOb8hKZACzFsR8HIpfrrcOKYBh5eKzUNEVF1iq8vw3s5m
	c65yPeO2Knfg0R6ts0xIEoQywM5OSDSRMYihucqjrm9ke5vt4zsEVc4Cv0Lq6GDN283kwn3VK5s
	Rxfjm32YfK4P9das/s/ml+TEFF9kL0zZ+zRq3mLsLQ6HZlstKMKPnP4URm86CXu/AERehK2UmPp
	YZXuOLGuePP68w6cKSiC3+28LHQQmqNr12CDAbVPP5Svr2YyvIWsgCU=
X-Received: by 2002:a05:600c:1d0e:b0:450:cabd:160 with SMTP id 5b1f17b1804b1-454a36db2d5mr26787555e9.3.1751447477638;
        Wed, 02 Jul 2025 02:11:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGAa4JTgVrvR64TMcVsUpXXyzC4HELXqfdtWbSrzoZ98bvqmNaf5eKbrOurVw/r1QXRfTvtWg==
X-Received: by 2002:a05:600c:1d0e:b0:450:cabd:160 with SMTP id 5b1f17b1804b1-454a36db2d5mr26787195e9.3.1751447477093;
        Wed, 02 Jul 2025 02:11:17 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4538a390d55sm196824095e9.6.2025.07.02.02.11.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Jul 2025 02:11:16 -0700 (PDT)
Message-ID: <62da3059-ee1f-4ec7-a7e3-af5153044d91@redhat.com>
Date: Wed, 2 Jul 2025 11:11:15 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/4] mm: smaller folio_pte_batch() improvements
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Oscar Salvador <osalvador@suse.de>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Zi Yan <ziy@nvidia.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
 Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>,
 Ying Huang <ying.huang@linux.alibaba.com>,
 Alistair Popple <apopple@nvidia.com>, Pedro Falcato <pfalcato@suse.de>,
 Rik van Riel <riel@surriel.com>, Harry Yoo <harry.yoo@oracle.com>
References: <20250627115510.3273675-1-david@redhat.com>
 <20250627115510.3273675-3-david@redhat.com>
 <aGTw5ipC-ITJGfv0@localhost.localdomain>
 <1d98e96b-4bc9-45c1-9861-e0f3c5930ec2@redhat.com>
 <753a8900-d9ff-436c-8758-17d363967b30@lucifer.local>
 <6092c44e-8800-47ec-9cfb-a1f062ea122a@redhat.com>
 <14e4407c-11b2-42bf-aa63-343762018877@lucifer.local>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <14e4407c-11b2-42bf-aa63-343762018877@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02.07.25 11:08, Lorenzo Stoakes wrote:
> On Wed, Jul 02, 2025 at 11:00:48AM +0200, David Hildenbrand wrote:
>> On 02.07.25 10:51, Lorenzo Stoakes wrote:
>>> On Wed, Jul 02, 2025 at 10:48:20AM +0200, David Hildenbrand wrote:
>>>> On 02.07.25 10:42, Oscar Salvador wrote:
>>>>> On Fri, Jun 27, 2025 at 01:55:08PM +0200, David Hildenbrand wrote:
>>>>>> Let's clean up a bit:
>>>>>>
>>>>>> (1) No need for start_ptep vs. ptep anymore, we can simply use ptep
>>>>>>
>>>>>> (2) Let's switch to "unsigned int" for everything
>>>>>>
>>>>>> (3) We can simplify the code by leaving the pte unchanged after the
>>>>>>        pte_same() check.
>>>>>>
>>>>>> (4) Clarify that we should never exceed a single VMA; it indicates a
>>>>>>        problem in the caller.
>>>>>>
>>>>>> No functional change intended.
>>>>>>
>>>>>> Signed-off-by: David Hildenbrand <david@redhat.com>
>>>>>
>>>>> Hi David :-),
>>>>>
>>>>> I have to confess that I fell in the same trap as Lorenzo wrt.
>>>>> __pte_batch_clear_ignored changing the pte value.
>>>>> So I'm not sure if it would be nice to place a little comment in
>>>>> __pte_batch_clear_ignored claryfing that pte's value remains unchanged ?
>>>>
>>>> I mean, that's how all our pte modification functions work, really? :)
>>>>
>>>> Thanks!
>>>
>>> I mean, it might be that me and Oscar are similarly 'challenged' in this
>>> respect :P (high 5 Oscar!) but I think the issue here is that it's sort of
>>> a compounded use, and in fact some functions do modify stuff, which is why
>>> we end up with all the ptep ptent etc. fun.
>>>
>>> Up to you re: comment, but I think maybe in cases where it's a reallly
>>> compounded set of stuff it's potentially useful.
>>>
>>> But obviously we still do do this all over the place elsewhere with no
>>> comment...
>>
>> Well, if you are not passing in a *value* and not a pointer to a function,
>> you would not expect for that *value* to change? :)
>>
>> Yes, once we pass pointers it's different. Or when we're using weird macros.
>>
>> Adding a comment that a function will not modify a value that is ...
>> passed-by-value? Maybe it's just me that doesn't get why that should be
>> particularly helpful :)
> 
> I think the issue is that we've passed around 'pte' as value and pointer (and of
> course, via macros...)  previously so that's the cause of the confusion, often.
> 
> This is why I really am a fan of us consistently saying ptep when passing a
> pointer.

100%: pte for pointers is absolutely nasty.

-- 
Cheers,

David / dhildenb


