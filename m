Return-Path: <linux-kernel+bounces-768880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27353B26708
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 15:24:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F25916374F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 13:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA8BA2FCC1E;
	Thu, 14 Aug 2025 13:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FdFq7v5v"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7253C15E8B
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 13:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755177655; cv=none; b=f8sStJKHNoBrozGO7mZcRwdn/iFtldMxrmzmqn8G7woZC0GIebOb87z0O5lC1PMSOKMkqjXQeTacr3wRlXdGCpIry8UWIlopew3rwosGRNBiNbf1Z65WZYS8CMLcUyiN1oSybI2DHt+w6jBhQ0pQGdr7eXqfBk/Kk76Pixtzl/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755177655; c=relaxed/simple;
	bh=zTNC/4eq5veW9+1xQ3P6/mA8C3u94zDak9iq+m3TOLk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bi0kR5Y7fNdRv38WWud6mmKNg9DLAqBQY6K+zaT4wvW0+zylKd18c59lvqhsij9ib8Y4mgFB5PoRVR5Ok0wBLZ5lQDahSwDgY0ABsVGu6UGa0dWDzdlvfAASuBwG+k37CYOBXMSajtGz0AEswhdH0wmQ/o8zWW1LT8eEguQUixk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FdFq7v5v; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755177652;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A7jDafqYB98HwVmHR1rUWCQQF4cRrv10NE/cqOShDxE=;
	b=FdFq7v5vV6ZWLt5BNVtKyx1Do0Fn5VavcAF0N4lC0amRxMlAGDahyGbVbyocjV4PCakLWN
	6MSiNiFAWZHfIvAKNY0GDP9Eo+XJkB6kJmZZhislnCarvktFhJykmaiS/qgsTy+L+Mn3L4
	L1DYHnrGNTVrz2L2aNpOPByyVPecNq0=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-478-UJG6ceFVMfe7cNUxARakww-1; Thu, 14 Aug 2025 09:20:46 -0400
X-MC-Unique: UJG6ceFVMfe7cNUxARakww-1
X-Mimecast-MFC-AGG-ID: UJG6ceFVMfe7cNUxARakww_1755177645
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-333f933c559so3102641fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 06:20:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755177644; x=1755782444;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A7jDafqYB98HwVmHR1rUWCQQF4cRrv10NE/cqOShDxE=;
        b=o91dm1V8+eSrULl4XCxzJGRDf33VPU1+By9I1IRuWGiFwqNrAmfjQjTnsIGhuLl7KG
         d5vMtstAu/tTho59Y5Hbmf6LtDKXtQJJR11KvYn9CZ5FDgZUlEMBgcaLiHnmJjGFa/d8
         ghspEZpS0DAWDdkrslu0HljzjBhVO6NZ39S8xA+yHDQGdHjfzLiAsMIzxa3xJuSF/jgu
         REc0Zqs77oWmBmx2C1LHL8CSlG2QFOxSk6Mi9TgFDsAnG/AhvU91iklakAh5Zyy1y4Sk
         DEEcLo0t1Xn9vbba1B4C0kxhGUUGkoQlxH0/GcDrv0HvKE+Z77vNq6wZ6RrVLBRj3gUV
         KQCg==
X-Forwarded-Encrypted: i=1; AJvYcCXS8YOTyuAtJ6j2gDZ9lTnKKiJPTp8natXQp5KvfN9mEiTjenPgg5lrtg/lHErztJg3HgjlE8ytMnYZHAc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBFIhf5NfoMkSKHMdIHXfhEclfujFbgnpwpDTGwAhrRqIxya0T
	e7bCJ0A+7NSgHqSlk3uX9QYqF09LvnaomAXYnCkhLcMm5hY29HPRWEYKCK6S/zogbFCKmNw9Mxv
	/WujepC96xKFrEVsiMKyKaHdHaqPxLPiNzEabuAsJyzdAqwBOQ5szI0zwSeEEaJcb
X-Gm-Gg: ASbGncuXozeZEUy6/TSkmDA6YQXp1dnrDEOIPKlkZkuSZJW5d4FurjPaLuPMvI8Bsd4
	m4IdDztgDrY1a1Lk0L9/FxknLFsSLFh5h2o+uPxJy1xiKHVQie2U0LtpJDrBHo7HyEk7JDKV9yS
	dPy5E6mw2ocYkiy4DwMZxN2IgGXuMgV8+pot8J6k2kGAhPmrlVWmJoGJjUGcjTy8cj8C151hhn0
	xrDjC8jdWCZIX+wqCO6d9gxoJMLcScqbZ2QklXcClBd79fxvBc0PWwR+er6ZDRFLPoUrp21P5ru
	O1VCrlXwEOCwLFGNxWCFgzN8Xj+1/wTy98F0FsmJ5mfisLW9E0meqE2ism+tVHKDgA==
X-Received: by 2002:a05:6512:ea7:b0:55b:9796:5d6e with SMTP id 2adb3069b0e04-55ce4fda8b4mr814850e87.6.1755177644439;
        Thu, 14 Aug 2025 06:20:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFWihT0k4QKDaAkdeReoErFsWLC1uspW0xCEZNbMy9GEmljSgmnx/hsb8xuhqqpYddj4a50qA==
X-Received: by 2002:a05:6512:ea7:b0:55b:9796:5d6e with SMTP id 2adb3069b0e04-55ce4fda8b4mr814835e87.6.1755177643940;
        Thu, 14 Aug 2025 06:20:43 -0700 (PDT)
Received: from [192.168.1.86] (85-23-48-6.bb.dnainternet.fi. [85.23.48.6])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b88ca3327sm5640778e87.127.2025.08.14.06.20.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Aug 2025 06:20:43 -0700 (PDT)
Message-ID: <67b6e041-4bea-485d-a881-cc674d719685@redhat.com>
Date: Thu, 14 Aug 2025 16:20:42 +0300
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
Content-Language: en-US
From: =?UTF-8?Q?Mika_Penttil=C3=A4?= <mpenttil@redhat.com>
In-Reply-To: <20250814130403.GF699432@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 8/14/25 16:04, Jason Gunthorpe wrote:

> On Thu, Aug 14, 2025 at 03:53:00PM +0300, Mika Penttilä wrote:
>> On 8/14/25 15:40, Jason Gunthorpe wrote:
>>> On Thu, Aug 14, 2025 at 10:19:26AM +0300, Mika Penttilä wrote:
>>>> When doing migration in combination with device fault handling,
>>>> detect the case in the interval notifier.
>>>>
>>>> Without that, we would livelock with our own invalidations
>>>> while migrating and splitting pages during fault handling.
>>>>
>>>> Note, pgmap_owner, used in some other code paths as owner for filtering,
>>>> is not readily available for split path, so use current for this use case.
>>>> Also, current and pgmap_owner, both being pointers to memory, can not be
>>>> mis-interpreted to each other.
>>>>
>>>> Cc: David Hildenbrand <david@redhat.com>
>>>> Cc: Jason Gunthorpe <jgg@nvidia.com>
>>>> Cc: Leon Romanovsky <leonro@nvidia.com>
>>>> Cc: Alistair Popple <apopple@nvidia.com>
>>>> Cc: Balbir Singh <balbirs@nvidia.com>
>>>>
>>>> Signed-off-by: Mika Penttilä <mpenttil@redhat.com>
>>>> ---
>>>>  lib/test_hmm.c   | 5 +++++
>>>>  mm/huge_memory.c | 6 +++---
>>>>  mm/rmap.c        | 4 ++--
>>>>  3 files changed, 10 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/lib/test_hmm.c b/lib/test_hmm.c
>>>> index 761725bc713c..cd5c139213be 100644
>>>> --- a/lib/test_hmm.c
>>>> +++ b/lib/test_hmm.c
>>>> @@ -269,6 +269,11 @@ static bool dmirror_interval_invalidate(struct mmu_interval_notifier *mni,
>>>>  	    range->owner == dmirror->mdevice)
>>>>  		return true;
>>>>  
>>>> +	if (range->event == MMU_NOTIFY_CLEAR &&
>>>> +	    range->owner == current) {
>>>> +		return true;
>>>> +	}
>>> I don't understand this, there is nothing in hmm that says only
>>> current can call hmm_range_fault, and indeed most applications won't
>>> even gurantee that.
>> No it's the opposite, if we are ourselves the invalidator, don't care.
> I think you've missed the point, you cannot use range->owner in any
> way to tell "we are ourselves the invalidator". It is simply not the
> meaning of range->owner.

Usually it is the device but used similarly, look for instance nouveau:


static bool nouveau_svm_range_invalidate(struct mmu_interval_notifier *mni,
                                         const struct mmu_notifier_range *range,
                                         unsigned long cur_seq)
{
        struct svm_notifier *sn =
                container_of(mni, struct svm_notifier, notifier);

        if (range->event == MMU_NOTIFY_EXCLUSIVE &&
            range->owner == sn->svmm->vmm->cli->drm->dev)
                return true;

Where we return in case are the initiator of the make_device_exclusive. Otherwise,
it would also hang in next mmu_interval_read_begin().

owner is void * and admit used in a creative way here, but it can't be wrongly interpreted
as dev if current.

>
>>> So if this plan relies on something like the above in drivers I don't
>>> see how it can work.
>>>
>>> If this is just some hack for tests, try instead to find a solution
>>> that more accurately matches what a real driver should do.
>>>
>>> But this also seems overall troublesome to your goal, if you do a
>>> migrate inside hmm_range_fault() it will generate an invalidation call
>>> back and that will increment the seqlock and we will loop
>>> hmm_range_fault() again which rewalks.
>> That's the problem this solves.
>> The semantics is "if we are the invalidator don't wait for invalidate end",
>> aka don't mmu_interval_set_seq() that would make hang in the next mmu_interval_read_begin(),
>> waiting the invalidate to end
> I doubt we can skip mmu_interval_set_seq(), doing so can corrupt concurrent
> hmm_range_fault in some other thread.
>
> Nor, as I said, can we actually skip the invalidation toward HW
> anyhow.
>
> At the very least this commit message fails to explain the new locking
> proposal, or justify why it can work.

Yes the commit message could be better. 
But this is essentially the same as nouveau is doing with 
MMU_NOTIFY_EXCLUSIVE handling, just not using the dev as the qualifier,
because that is not easily available in the context.

--Mika

> Jason
>


