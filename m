Return-Path: <linux-kernel+bounces-845921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A042BC6813
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 21:52:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26AA5405012
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 19:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9C9D270ED9;
	Wed,  8 Oct 2025 19:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AKAlqxU4"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80DE21C8630
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 19:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759953151; cv=none; b=VaHQzWl3k6BwlvMNneZrH8xGTeV/5Dtheg6maI16/luu2WDpgKEiw+NcG00Wla89EWjU6W3QkXnTuanQevnIeL2ngDWnpVQjj12YuVVjvcLkpEfL8z2/3z9qXGteK3euwxxJnKJDz4nmU7103yw+M4X5pn5Hfd6wlP31J35OBmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759953151; c=relaxed/simple;
	bh=f4lr5plTPmT72ZArDdPUKOMGD7bcpZzT/GwCWENFslQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FNgE0yoWDDZebbCMvYLM/P1wV7YOamld1/CyTkcy7k/9qaPNbsR6XdqveUFi9FkZ0HRdaddDVEkvljc4fb9zkwN72UXcrlW/IAEoSt5LM70deSmjABO65+l65BhvXxKqZHjLvUSAdqpFnZswT2oi6/olhKHZYtpqfz+lz6BmCl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AKAlqxU4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759953148;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=RtTlwRw/t9hpT+l94+pAzSz0mGXw5QPtsOjkoODOmNY=;
	b=AKAlqxU4+Icxrnmj+wGyWqPwFKKTtFeVh33XXj9pneYNBkZzmtJ968dbQGvdPrkAmsEKMI
	iIkXpPVo0g9z1kn4+iG7tjaq3GYa/sbLX1litS8TlEFLMSb9OwB4qXKYrZDZE7fNE2XiH4
	bkt2VzBQBFkhwGBhaLTdnvljpSct+K0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-363-lgI9oqXYPRuxP80d4yBk0Q-1; Wed, 08 Oct 2025 15:52:26 -0400
X-MC-Unique: lgI9oqXYPRuxP80d4yBk0Q-1
X-Mimecast-MFC-AGG-ID: lgI9oqXYPRuxP80d4yBk0Q_1759953146
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-46e44b9779eso1018425e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 12:52:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759953146; x=1760557946;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RtTlwRw/t9hpT+l94+pAzSz0mGXw5QPtsOjkoODOmNY=;
        b=ea2gyL8ZGiaPY1iCyvz36b1LAR6VJM9n0XL+CNZkk6MjFZ9yvXzyioqp6fOaCj6Df0
         RjYLuAeTijfxas+5AC9IiF44hLYlhQqtCUwriRPEp1o8bKjtxqlCMMM/32UF9knUtWPO
         KVAxkHVX9SjlUitVLga/Tzj5as1W/QpxEUNjAGHNjnSZ9d5tDq56UpoA/jA4fsphHZ9U
         +MfHsxZ5WVkrdOVuuxJIscOoYqEAg3YFIgwkrpREpJ12hDFxBJIuYTsLfaC4QY8QQ6jE
         bDAmQb00EY32x9W8yaq4iMsHK3qF1Yg5KZqRYjM2nSoRuurksPTtYke0QM3PzClp/FEI
         21aA==
X-Forwarded-Encrypted: i=1; AJvYcCUUJxsvWyZF2dQUNWYu934TCMbsGUUD4KRB41iXhv6aRvy12KjmjbOoAdLEAViNrV1THEBFwQ29/cxms4g=@vger.kernel.org
X-Gm-Message-State: AOJu0YymtIPkdJxPAHoXT89wQ0Jswi/UQ/ZnXtia/G9Fuk0KfM7zmIuJ
	ahjhW7v16MFS+RZ8bEebdXzmPqeVQRNsjsDCaJJcqNQxODq2OUJQhu2Dj6XEcAXhlQSQiII5EBz
	99yHWab5FPe4eHU9hb1jS+W+ZvZ7sIt+lv9xXUAQwJlqJGRU0ceaPJn3rkJxAay2ouw==
X-Gm-Gg: ASbGnctBXYZcpHJuVHB6rLj+3AZ6nS5Eh0sNGGMu1p1hThdZ53rUlQ3KhdVGhx6pnA+
	wz86k2PvaZ3v4H1XqcLIYKYDEnHcgM7+BDltCKLDCNSriCTP93qNisJiuo94tS14W78I3/MrlEC
	SiK3BudYJ2LRtmIWr79YSg9O6l03CiBHf8Aev0bRYpBk7KsN09IlkC3a6Iv+3sN9acc9iHg0XmO
	joPHGjOReUYiyquuqRmIUg+o9XDxVQAn6L90VgUQhy2lGdIkX6vCv/JI6a0bZZd5bTx/JzCV+kg
	Dp2CY93iXW5TdUzeHTqMbJvvK1mGiYBndMmWG6jkYFIAMNYDmyDodeEcPclItEOdyHqc9MH55ti
	XCfp1U5El
X-Received: by 2002:a05:600c:529a:b0:46e:3e25:1626 with SMTP id 5b1f17b1804b1-46fa9aefe15mr33101615e9.19.1759953145618;
        Wed, 08 Oct 2025 12:52:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFMCtqEpQgXh2ZeUUnrUMZuhOCP6i4VisyQMUewSPB0pVRauuNVK/j/FRYcpK2qrZwm7+c6bg==
X-Received: by 2002:a05:600c:529a:b0:46e:3e25:1626 with SMTP id 5b1f17b1804b1-46fa9aefe15mr33101455e9.19.1759953145211;
        Wed, 08 Oct 2025 12:52:25 -0700 (PDT)
Received: from [192.168.3.141] (tmo-083-189.customers.d1-online.com. [80.187.83.189])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8e9719sm31915894f8f.31.2025.10.08.12.52.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Oct 2025 12:52:23 -0700 (PDT)
Message-ID: <1763f0d9-37fc-4c3e-b31b-2cfac33d5c95@redhat.com>
Date: Wed, 8 Oct 2025 21:52:09 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "mm, hugetlb: remove hugepages_treat_as_movable
 sysctl"
To: Gregory Price <gourry@gourry.net>
Cc: linux-mm@kvack.org, corbet@lwn.net, muchun.song@linux.dev,
 osalvador@suse.de, akpm@linux-foundation.org, hannes@cmpxchg.org,
 laoar.shao@gmail.com, brauner@kernel.org, mclapinski@google.com,
 joel.granados@kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Mel Gorman <mgorman@suse.de>,
 Michal Hocko <mhocko@suse.com>,
 Alexandru Moise <00moses.alexander00@gmail.com>,
 David Rientjes <rientjes@google.com>
References: <20251007214412.3832340-1-gourry@gourry.net>
 <402170e6-c49f-4d28-a010-eb253fc2f923@redhat.com>
 <aOZyt-7sf5PFCdpb@gourry-fedora-PF4VCD3F>
 <f4d0e176-b1d4-47f0-be76-4bff3dd7339a@redhat.com>
 <aOa0UPnxJVGvqc8S@gourry-fedora-PF4VCD3F>
 <b6d472ba-e6cf-4c96-935d-88c842ab3cd8@redhat.com>
 <aOa_A_i1HUt1wzCj@gourry-fedora-PF4VCD3F>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <aOa_A_i1HUt1wzCj@gourry-fedora-PF4VCD3F>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08.10.25 21:44, Gregory Price wrote:
> On Wed, Oct 08, 2025 at 09:01:09PM +0200, David Hildenbrand wrote:
>>>
>>> fwiw this works cleanly.  Just dropping this here, but should continue
>>> the zone conversation.  I need to check, but does this actually allow
>>> pinnable allocations?  I thought pinning kicked off migration.
>>
>> Yes, it should because longterm pinning -> unmovable.
>>
> 
> You know i just realized, my test here only works before I allocated 1GB
> pages on both node0 and node1.  If I only allocate 1gb hugetlb on node1,
> then the migrate pages call fails - because there are no 1gb pages
> available there.
> 
> I imagine this would cause hot-unplug/offline to fail since it uses the
> same migration mechanisms.
> 
> Worse I would imagine this would fail for 2MB.
> 
> Seems like the 1GB limitation is arbitrary if 2MB causes the same issue.

Yeah, with hugetlb allocations there are no guarantees either. It's just 
that page compaction / defragmentation makes it much less likely to fail 
in many scenarios.

-- 
Cheers

David / dhildenb


