Return-Path: <linux-kernel+bounces-845677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8667BC5EC8
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 18:02:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B44034261F2
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 15:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0D5C2F0C7E;
	Wed,  8 Oct 2025 15:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G0jy+nMg"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F7F929D27E
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 15:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759938211; cv=none; b=AY6Q/vhjJL5zthKauwJCbTaWUl4j3wsyKB6TdlHvIFloYbxEMzXTYbGNDy+gIlTh6rQPUzAD0fS3QZX7ke+UBUwr310c7HWvlrbDHm7/5rkOX4iYhAqULM3KkBDiIWMqXkZ4Q/KWtxl7usqAU2NqH+2gWUEK4b2efzt5V96sjok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759938211; c=relaxed/simple;
	bh=ERlHrk6EJ6JZBnRe2MdPcCm5Je+F3pbGM2LW3RuE074=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lmX25xwYIVddBbCdCFtwLwOZR+5VN/MMvL3l3mSz5csnIYstztNJyGY3s5x0V6BT81chnFDMVNs+3l3/pdlDBNdE+FNNCFR4TiTuacv814YmrQGSnUaov+0GbF22ryMe+k7V0HOaeboX/3s6WmyhqE1mcpRH2cojXO5ExuZnG0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G0jy+nMg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759938209;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=YUhSb2gRG9q7wfoqgmoV/rOSyHa9AmwtjacpyBWGooo=;
	b=G0jy+nMgii99F7EGr5iZ/7JuNu0x3qu/y2h0XwlZtJphzo3mwSxZhAoqFpUnGdeBkIYHS1
	wLQe3a2DoEJqVd7/9mA2cKJam/1COn85A7LWwdp3jhk0t96/DFDRQI77wZQGADe594MAoN
	bFzO12lLqjhQOfrrwUc1xHVuPcGSzO8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-158-JYRJAxNJNW-R7tWVMT_IrQ-1; Wed, 08 Oct 2025 11:43:28 -0400
X-MC-Unique: JYRJAxNJNW-R7tWVMT_IrQ-1
X-Mimecast-MFC-AGG-ID: JYRJAxNJNW-R7tWVMT_IrQ_1759938207
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3ee888281c3so68970f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 08:43:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759938207; x=1760543007;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YUhSb2gRG9q7wfoqgmoV/rOSyHa9AmwtjacpyBWGooo=;
        b=RBLPjy0fL3DEEFu4uchoVGDlg6i8RIKKNPFhtAtvYr1wbHAEW6FP0dHHKd/wED+eNS
         pNq6E0R+dL9mTm4zW0U//2tni56gQ+f6ilIWobsz0U85AdOPtOTwfDqLC2imSA7delfI
         oR6Co4CvDxnP3HhGnxfXOb+gmqnWhyUzkHAl/u0aH8SN4yYaRPW8OiWzC/kuMm6iJNOr
         uTBTVpLlP+f9UzVCBzm2Xy7xo545aVQcsWdwJwmet8xYa37T2OXPVT+HJc1Cas3MbOkH
         7gqu0k+77+cYZpASOK5uau9z2RMrfF6s4nIDR7EvfUKAsla4j6lUnue/F6QROIxaql4U
         gCUQ==
X-Forwarded-Encrypted: i=1; AJvYcCUkrnYqTjf8L0ywkO1lZ8Kz/AkK4hJI8I93slfDYnTnkV15p9zTlV344fX3niiAIYGZyj0Tqliahezm9nM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3UVjdyIscjlUlaWlm2X89EKQ6Xi/ZeC2uqFWTVtvTB6YIjw7o
	0itpS7Fgv4ptXYx/peR7u+IUYU9ojGWvQJ9HJwMY6AbDhakVo4RCLFOCtV2yZavasOWZgah4ZJb
	aRK/yHj9/0fgXU3RbfmOxdROFxqBh4JnW2A84K8YQQqKZOgKA3AX3o5eDYo142cXdjA==
X-Gm-Gg: ASbGnctABybYaf3V3UrVA+TUKl0ZRgKNM57RJFw//XB853Z3bfixEC8cpxrk8yw7lyP
	6kJ2/qQ5mTGkgFu1gxOyId21z3YQAvPDibPnpGWI80Ypscbac1yCOU7C6A/3yjhzewJ7AR8mgdw
	7aiD7bQKMTRVr58leSR1qitGvvuPHXUri+TEop6S3pHNkQM/hbxWxJ2mZhlQ19VnzPBUrNJ/o0R
	OifolewBXCuwxXRaVUDDo5XgL3K4lKpvpVN8zcILWGgcf4Z8R6MF3FZ+PSVpr52Bu2sp4mr3/Ew
	caA3FMhLA6Uoc+1e/9yVhaLr7xKbM+3EplzgCwbuDHM499YthXwqpFzFEAn+cr4P5Sjzu5Z9sTu
	GKCxCKHX4
X-Received: by 2002:a5d:5f47:0:b0:3eb:c276:a361 with SMTP id ffacd0b85a97d-4266e8dd630mr2663630f8f.54.1759938206741;
        Wed, 08 Oct 2025 08:43:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEg/1BjAZFBrqRhTVifCxpXqhRM9mNYNtgY3LS18mLzhLVabrk7varIJms3tUeaWhS9aL+yvg==
X-Received: by 2002:a5d:5f47:0:b0:3eb:c276:a361 with SMTP id ffacd0b85a97d-4266e8dd630mr2663607f8f.54.1759938206331;
        Wed, 08 Oct 2025 08:43:26 -0700 (PDT)
Received: from [192.168.3.141] (tmo-083-189.customers.d1-online.com. [80.187.83.189])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8f4bdcsm30484973f8f.54.2025.10.08.08.43.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Oct 2025 08:43:25 -0700 (PDT)
Message-ID: <83e33641-8c42-4341-8e6e-5c75d00f93b9@redhat.com>
Date: Wed, 8 Oct 2025 17:43:23 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "mm, hugetlb: remove hugepages_treat_as_movable
 sysctl"
To: Michal Hocko <mhocko@suse.com>
Cc: Gregory Price <gourry@gourry.net>, linux-mm@kvack.org, corbet@lwn.net,
 muchun.song@linux.dev, osalvador@suse.de, akpm@linux-foundation.org,
 hannes@cmpxchg.org, laoar.shao@gmail.com, brauner@kernel.org,
 mclapinski@google.com, joel.granados@kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Mel Gorman <mgorman@suse.de>,
 Alexandru Moise <00moses.alexander00@gmail.com>,
 Mike Kravetz <mike.kravetz@oracle.com>, David Rientjes <rientjes@google.com>
References: <20251007214412.3832340-1-gourry@gourry.net>
 <402170e6-c49f-4d28-a010-eb253fc2f923@redhat.com>
 <aOZ8PPWMchRN_t5-@tiehlicka>
 <271f9af4-695c-4aa5-9249-2d21ad3db76e@redhat.com>
 <aOaCAG6e5a7BDUxK@tiehlicka>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <aOaCAG6e5a7BDUxK@tiehlicka>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08.10.25 17:23, Michal Hocko wrote:
> On Wed 08-10-25 17:14:26, David Hildenbrand wrote:
>> On 08.10.25 16:59, Michal Hocko wrote:
>>> On Wed 08-10-25 10:58:23, David Hildenbrand wrote:
>>>> On 07.10.25 23:44, Gregory Price wrote:
>>> [...]
>>>>> @@ -926,7 +927,8 @@ static inline gfp_t htlb_alloc_mask(struct hstate *h)
>>>>>     {
>>>>>     	gfp_t gfp = __GFP_COMP | __GFP_NOWARN;
>>>>> -	gfp |= hugepage_movable_supported(h) ? GFP_HIGHUSER_MOVABLE : GFP_HIGHUSER;
>>>>> +	gfp |= (hugepage_movable_supported(h) || hugepages_treat_as_movable) ?
>>>>> +	       GFP_HIGHUSER_MOVABLE : GFP_HIGHUSER;
>>>>
>>>> I mean, this is as ugly as it gets.
>>>>
>>>> Can't we just let that old approach RIP where it belongs? :)
>>>>
>>>> If something unmovable, it does not belong on ZONE_MOVABLE, as simple as that.
>>>
>>> yes, I do agree. This is just muddying the semantic of the zone.
>>>
>>> Maybe what we really want is to have a configurable zone rather than a
>>> very specific consumer of it instead. What do I mean by that? We clearly
>>> have physically (DMA, DMA32) and usability (NORMAL, MOVABLE) constrained
>>> zones. So rather than having a MOVABLE zone we can have a single zone
>>> $FOO_NAME zone with configurable attributes - like allocation
>>> constrains (kernel, user, movable, etc). Now that we can overlap zones
>>> this should allow for quite a lot flexibility. Implementation wise this
>>> would require some tricks as we have 2 zone types for potentially 3
>>> different major usecases (kernel allocations, userspace reserved ranges
>>> without movability and movable allocations). I haven't thought this
>>> through completely and mostly throwing this as an idea (maybe won't
>>> work). Does that make sense?
>>
>> I suggested something called PREFER_MOVABLE in the past, that would prefer
>> movable allocations but nothing would stop unmovable allocations to end up
>> on it. But only as a last resort or when explicitly requested (e.g.,
>> gigantic pages).
>>
>> Maybe that's similar to what you have in mind?
> 
> Slightly different because what I was thinking about was more towards
> guarantee/predictability. Last resort is quite hard to plan around. It
> might be a peak memory pressure to eat up portion of a memory block and
> then fragmenting it to prevent other use planned for that memroy block.
> That is why I called it user allocations because those are supposed to
> be configured for userspace consumation and planned for that use. So you
> would get pretty much a guarantee that no kernel allocations will fall
> there.

What could end up on it that would not already end up on ZONE_MOVABLE? I 
guess long-term pinned pages, secretmem, guest_memfd, gigantic pages.

Anything else?

I'm not quite clear yet on the use case, though. If all the user 
allocations end up fragmenting the memory, there is also not a lot of 
benefit to be had from that zone long term.

-- 
Cheers

David / dhildenb


