Return-Path: <linux-kernel+bounces-769343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE62FB26D32
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 19:00:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E6F1B62F73
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 16:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BFFE8F5B;
	Thu, 14 Aug 2025 17:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gu1DoccY"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF5CC25525F
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 17:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755190809; cv=none; b=GbyIAXuARJGPzaxTXcEMOFWa3J9Qqhp0PxMid9VruYFTrdRRfKXHGwV5PiPS1PdHYHxVjDeHla+3XMj/0eBe32tfK4A1AsUm3/li03urTDuqjPv1CLRXHF9XIsK+t1kG/0YSfDBKGqmCg0wwd4lUflCy0TzMF/PVCuc82iExKbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755190809; c=relaxed/simple;
	bh=uW5vwAxAMvU0rLLvXT6iVL7KckMjWQGzuaNHMn7UGjg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dznaW31hwAk0q8cQHbyZhLOLFhs4E3d/853J14eyt6YssSlP50Z8bCI1iaRUytNojNojvl7sVQs1FszakHh8zlc1cR4xT0pz/r+g+St6YjDFuafY2PcvqmFZkw6PdvjKZpBfbIGHrTuM23Nm1AghAEY1lh7Qcrec3C8oRPxQBWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Gu1DoccY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755190806;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZVrCmyYJ7+hVRCA1extRm8Ry35qk0L+BE8NF8QgnDsw=;
	b=Gu1DoccYtq7Vn0yhy2Y29rA1ye6cThKd5Tz1cojEIJHZIPtirv9IUFAkbZi7XIkdM2sUiN
	wxHMa5VwGxBZdtNexsFs7MxmtxjG7lz6DDtuAjIcyMY76vK8Ow+C4t6yOjpyBKFXnicenP
	kRpuw7KXMrJ5qo64iVjDB2HlU7nLhhY=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-1ghGD9WiPwGUBoK9ev0IEQ-1; Thu, 14 Aug 2025 13:00:05 -0400
X-MC-Unique: 1ghGD9WiPwGUBoK9ev0IEQ-1
X-Mimecast-MFC-AGG-ID: 1ghGD9WiPwGUBoK9ev0IEQ_1755190804
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-55ce52729d5so544457e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 10:00:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755190803; x=1755795603;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZVrCmyYJ7+hVRCA1extRm8Ry35qk0L+BE8NF8QgnDsw=;
        b=wizCw5+kC6QHacZAoJLg8NU0X4/I5QmHGT3hpZcKcyHCZ3auwRx7LXOibmGbfX570K
         9iD/jtQdWg4fRtSgHAARmBpXwf2RuAi0QOZ2dyXsADMN5pORdnGTM8Mwb+4kSmruMDPp
         a9jSkCEWo9A7q1GUN4k0dVgi3sXYiPSs0PJ6OoHCvQEJ4zB6X0aZ4xcukaqozLaRteNB
         RT9ZMrOBw1xjOQGejt2oQsVrqNIYj1Gm/ucRhKQ/Yat9iR/wnQwk04pZRZnJMNeK9Jq6
         UEmEQ0H2eNCFAhQqeQoBTvkLZ9994MMIQxjFgq43nRwVwWZPOPThSuxNcveAtqCDeqFd
         hUbg==
X-Forwarded-Encrypted: i=1; AJvYcCVZ1m0AfxBOB8VKUoFeI8wipAVhC7PldaDZjBtolBNOVqKpBLHUhStWNvBvWzVrxp29Vi9I3bF+nyT0L7I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkFjoHJ1l8Ayt7YvRYi6quFn9ZyE0k9glZAUuMNQjZ99lCYz6m
	nj7d0KZpvR94XB4gF6nKbklQLlUG1vgBPx6cmKXaOfr6XKmG0pPd4X5D0d1ZfUTvCHFIK8tDxYP
	HWPvkbk/M6Zx+JUVvJ67Do1erN5WGHnFCTgfHdL1MSW25iVaMu+aF5D6/wJ+t0LbB
X-Gm-Gg: ASbGncvMEpfQ464f6Ci/3pYFsejTJg0DW20fOkcIVbhvAbQbz0+1GEdfEHeG2TU+Syi
	fbZxdU2FFdmUVyxK8baIHpuZeH34xHUbvn64P7VlOra8T5ql2m+wQlaQxI6Pkwr5qIaHUz99pT0
	oh+zPQAxKW+4N2GutYSi1X3vq+r53hrM6PcV4ZmlqrUPWJemu6W/7vjXczKLdqeV9hPmVRfb/vb
	2SJDyjUsIIMHOYCbvl9P6+awQ0iLxPLLva6XCGYqdoL1CgJ1BNpDVJm2lll3L8LwnArk5g7ae/5
	yiZwQSQNRSWOlrwqzVdjcwwfAe3gbOMoJ8JygGLs75slnctv1H69/4Au5qxsK3cSag==
X-Received: by 2002:a05:6512:32d3:b0:553:2e37:6945 with SMTP id 2adb3069b0e04-55ce5029232mr1515217e87.32.1755190803375;
        Thu, 14 Aug 2025 10:00:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGeIK5K35ICkkmYZHKZpv6mu77wrgGmsQiud/3+kKsoxMAm+BhkPNxb08y2Da10qFDFHZ67Og==
X-Received: by 2002:a05:6512:32d3:b0:553:2e37:6945 with SMTP id 2adb3069b0e04-55ce5029232mr1515201e87.32.1755190802869;
        Thu, 14 Aug 2025 10:00:02 -0700 (PDT)
Received: from [192.168.1.86] (85-23-48-6.bb.dnainternet.fi. [85.23.48.6])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55ced007873sm711e87.63.2025.08.14.10.00.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Aug 2025 10:00:02 -0700 (PDT)
Message-ID: <c7bbbbc8-b9fc-40f5-b86f-e43b9a85aaef@redhat.com>
Date: Thu, 14 Aug 2025 20:00:01 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/4] mm: use current as mmu notifier's owner
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 David Hildenbrand <david@redhat.com>, Leon Romanovsky <leonro@nvidia.com>,
 Alistair Popple <apopple@nvidia.com>, Balbir Singh <balbirs@nvidia.com>
References: <20250814072045.3637192-1-mpenttil@redhat.com>
 <20250814072045.3637192-3-mpenttil@redhat.com>
 <20250814124041.GD699432@nvidia.com>
 <2da9464b-3b3d-46bd-a68f-bfef1226bbf6@redhat.com>
 <20250814130403.GF699432@nvidia.com>
 <67b6e041-4bea-485d-a881-cc674d719685@redhat.com>
 <20250814141136.GG802098@nvidia.com>
Content-Language: en-US
From: =?UTF-8?Q?Mika_Penttil=C3=A4?= <mpenttil@redhat.com>
In-Reply-To: <20250814141136.GG802098@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 8/14/25 17:11, Jason Gunthorpe wrote:

> On Thu, Aug 14, 2025 at 04:20:42PM +0300, Mika Penttilä wrote:
>> On 8/14/25 16:04, Jason Gunthorpe wrote:
>>
>>> On Thu, Aug 14, 2025 at 03:53:00PM +0300, Mika Penttilä wrote:
>>>> On 8/14/25 15:40, Jason Gunthorpe wrote:
>>>>> On Thu, Aug 14, 2025 at 10:19:26AM +0300, Mika Penttilä wrote:
>>>>>> When doing migration in combination with device fault handling,
>>>>>> detect the case in the interval notifier.
>>>>>>
>>>>>> Without that, we would livelock with our own invalidations
>>>>>> while migrating and splitting pages during fault handling.
>>>>>>
>>>>>> Note, pgmap_owner, used in some other code paths as owner for filtering,
>>>>>> is not readily available for split path, so use current for this use case.
>>>>>> Also, current and pgmap_owner, both being pointers to memory, can not be
>>>>>> mis-interpreted to each other.
>>>>>>
>>>>>> Cc: David Hildenbrand <david@redhat.com>
>>>>>> Cc: Jason Gunthorpe <jgg@nvidia.com>
>>>>>> Cc: Leon Romanovsky <leonro@nvidia.com>
>>>>>> Cc: Alistair Popple <apopple@nvidia.com>
>>>>>> Cc: Balbir Singh <balbirs@nvidia.com>
>>>>>>
>>>>>> Signed-off-by: Mika Penttilä <mpenttil@redhat.com>
>>>>>> ---
>>>>>>  lib/test_hmm.c   | 5 +++++
>>>>>>  mm/huge_memory.c | 6 +++---
>>>>>>  mm/rmap.c        | 4 ++--
>>>>>>  3 files changed, 10 insertions(+), 5 deletions(-)
>>>>>>
>>>>>> diff --git a/lib/test_hmm.c b/lib/test_hmm.c
>>>>>> index 761725bc713c..cd5c139213be 100644
>>>>>> --- a/lib/test_hmm.c
>>>>>> +++ b/lib/test_hmm.c
>>>>>> @@ -269,6 +269,11 @@ static bool dmirror_interval_invalidate(struct mmu_interval_notifier *mni,
>>>>>>  	    range->owner == dmirror->mdevice)
>>>>>>  		return true;
>>>>>>  
>>>>>> +	if (range->event == MMU_NOTIFY_CLEAR &&
>>>>>> +	    range->owner == current) {
>>>>>> +		return true;
>>>>>> +	}
>>>>> I don't understand this, there is nothing in hmm that says only
>>>>> current can call hmm_range_fault, and indeed most applications won't
>>>>> even gurantee that.
>>>> No it's the opposite, if we are ourselves the invalidator, don't care.
>>> I think you've missed the point, you cannot use range->owner in any
>>> way to tell "we are ourselves the invalidator". It is simply not the
>>> meaning of range->owner.
>> Usually it is the device but used similarly, look for instance nouveau:
> Yes, dev is fine, but current or struct task is not reasonable.
>
>> Yes the commit message could be better. 
>> But this is essentially the same as nouveau is doing with 
>> MMU_NOTIFY_EXCLUSIVE handling, just not using the dev as the
>> qualifier,
> I wouldn't necesarily assume anything nouveau is correct, but this is
> certainly not the same thing. nouveau is trying to eliminate an
> unncessary invalidation for it's HW when it knows the memory is
> already only private to this local device.

Yes but it is omitting
  mmu_interval_set_seq()
in that case while returning early, which is ok.

as well as hmm test module with :

         * Ignore invalidation callbacks for device private pages since
         * the invalidation is handled as part of the migration process.
         */
        if (range->event == MMU_NOTIFY_MIGRATE &&
            range->owner == dmirror->mdevice)
                return true;


> This is not a statement about callchain or recursion.

In my case the unnecessary invalidation (self caused) causes hang,
so whatever the reason for unnecessary, the mechanism is the same
and used elsewhere in kernel also.

So technically I think that would work. But there are others ways to do that
without using owner, so will look that way in next version.

>
> Jason
>

--Mika


