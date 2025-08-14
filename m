Return-Path: <linux-kernel+bounces-768824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 965F3B265EB
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 14:53:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 681327AB3DB
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 12:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 677A32E9EB4;
	Thu, 14 Aug 2025 12:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PwWfBMR6"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B0A2E571
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 12:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755175987; cv=none; b=PtM1Cx1o+/195mXarx46XlOY3VGORCRPrKVk4GqPJ9peDRX2rjWdO7sTFqkkYb2+XrfCfqsbE4SopVGn8bZsuADZUoxIhgoLm7oWRjC+rRWbMwMzkplZDmV+g6hLzsFacpvjAvQt4W2Cv0GRQlOzMoVFj5QSQyUIoiy3DhUNEts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755175987; c=relaxed/simple;
	bh=oqk5ODhhRGDrESKCetTY8f3SD8kBaBEd4tnav7BkdPs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aiC+LMaUE2u1n4sbncixA++RaQ1tj7sf2nM8TsiU3LwFwFCMTHGCkpseU1nJSI5JSxHPOLHkn8HxgLgSz4fjlGx1wXGivEU7hkV965Bv+hezpOPgXK0nGsODEDIuszwOBDV3HhvE2fpMqdN+XxW1BNdJcgFgnTER3eTFz39tVyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PwWfBMR6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755175984;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gkqp06LVuvnkdhq6f0nGSY6KoGjayeRy+bW/wP7Ou6M=;
	b=PwWfBMR6JgmtZWfxAX5dm6fK01dfRBTH5Y68+G+LffZ7CKkgxaWN2+Cf2t/pUq+1MB+rpg
	NL3msajOtfVLIMETMBx5fdm+wuzP+WUWd1eqeEjlqAa1pY0ZaOF9zp0Li5Xyt94FGpAZS1
	XC/VXbuAGYjwG9+dbDJC5WIITtGR4Bc=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-410-c-I0ACZjOCeYeXcoveWL7A-1; Thu, 14 Aug 2025 08:53:03 -0400
X-MC-Unique: c-I0ACZjOCeYeXcoveWL7A-1
X-Mimecast-MFC-AGG-ID: c-I0ACZjOCeYeXcoveWL7A_1755175982
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-55ce520e01eso640648e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 05:53:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755175982; x=1755780782;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gkqp06LVuvnkdhq6f0nGSY6KoGjayeRy+bW/wP7Ou6M=;
        b=J07jt9jKKALsKZFfSwTo2HD2OnwpGKghwtn5ZcLe8PdHjHW7r65BtPtm3CkiSaHMjd
         NexIo3kTwX5kSl0kQpHcxFyClHGutM6D3yjTuYP4VYCdDUL1TZ4kvrIijGJaDU+N0guv
         esYskxwP3HMRIHtnIbwZh2Ys+OBQkkl3TTuyQ6OIWYwFcnjGQDBFtRVSZ8hagrv9UVTr
         DFh17dj8F0f+65ebLac+iIXFq1y5zTlbljLHd36TE2f6QBSgeFgMDe/Sen8tZmxWNC5w
         TGfy/0P3Rvc6hrDQ+VwELD68Ta+4/fnoB3MvwXh2RlSFpn2HB/l26UYt3Uc3ZCKtIWEx
         NaFQ==
X-Forwarded-Encrypted: i=1; AJvYcCUzoat/VeQiUo8wt0g/2AqISR5NRHXwepxZUak+V6OcMiORnj5BWukaESxXqD+/10diUOBab6pz2WEQQtQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzqecGsFRFrYbcmo6FAJWoh6BD+98pV9XzWkUQuijkPF8cD9bc
	GS8A+b8xv0XaN0AcbqD4vEuqxAMGB8D2reDliBSOjYkm809OIR9M+VIJFXUHmMWfWqyxprTBLA/
	uZTy/HmNTTbHlgtEW7n9wYhJmar8hkQSCbEdBljUvykPUze3BUdWiuHG6Mnp80bN7
X-Gm-Gg: ASbGnctA5zfzGU1tBZCNZw7WQce4wK331Mx5MVymCTSlyVyOTtZbj/2yB/nCkhrB6oM
	gt5rHnpSCZW7RPUDecM/Tbbsm7HGPlwKTp2hs2fNdOTqJGkWuJ2ajLEWbOilTAeLx858PPKNPgI
	0sb1jSP+zakbfA1GvzFpL4tGEcjhKmVpKuiv+NRoXWCPM1KurSJmeU4z2vXMGLH7CxI4awy56An
	yajNt7KM7JazaEhddm16VOHVBlbhiDj77+OA30mVD+kT+4iaFjvVGxf4kd03jaDkPslfnchMWv7
	bn+HA3hf1R5HC9ZvJn2Tnc7n1l4FlWwTBUVoPx5nt0VkuT/oWR/eTclTCvWo6UTzmA==
X-Received: by 2002:a05:6512:400d:b0:553:2868:635e with SMTP id 2adb3069b0e04-55ce50007a3mr883138e87.23.1755175981819;
        Thu, 14 Aug 2025 05:53:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEG375rEOoKk7hMuMXUSDUYkUvzFBpA7PIhf/LyWe5qb95ux5we6DJ4lF3xD0lmIWTi01DiGA==
X-Received: by 2002:a05:6512:400d:b0:553:2868:635e with SMTP id 2adb3069b0e04-55ce50007a3mr883116e87.23.1755175981298;
        Thu, 14 Aug 2025 05:53:01 -0700 (PDT)
Received: from [192.168.1.86] (85-23-48-6.bb.dnainternet.fi. [85.23.48.6])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b9fd163dbsm4752367e87.156.2025.08.14.05.53.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Aug 2025 05:53:00 -0700 (PDT)
Message-ID: <2da9464b-3b3d-46bd-a68f-bfef1226bbf6@redhat.com>
Date: Thu, 14 Aug 2025 15:53:00 +0300
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
Content-Language: en-US
From: =?UTF-8?Q?Mika_Penttil=C3=A4?= <mpenttil@redhat.com>
In-Reply-To: <20250814124041.GD699432@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 8/14/25 15:40, Jason Gunthorpe wrote:
> On Thu, Aug 14, 2025 at 10:19:26AM +0300, Mika Penttilä wrote:
>> When doing migration in combination with device fault handling,
>> detect the case in the interval notifier.
>>
>> Without that, we would livelock with our own invalidations
>> while migrating and splitting pages during fault handling.
>>
>> Note, pgmap_owner, used in some other code paths as owner for filtering,
>> is not readily available for split path, so use current for this use case.
>> Also, current and pgmap_owner, both being pointers to memory, can not be
>> mis-interpreted to each other.
>>
>> Cc: David Hildenbrand <david@redhat.com>
>> Cc: Jason Gunthorpe <jgg@nvidia.com>
>> Cc: Leon Romanovsky <leonro@nvidia.com>
>> Cc: Alistair Popple <apopple@nvidia.com>
>> Cc: Balbir Singh <balbirs@nvidia.com>
>>
>> Signed-off-by: Mika Penttilä <mpenttil@redhat.com>
>> ---
>>  lib/test_hmm.c   | 5 +++++
>>  mm/huge_memory.c | 6 +++---
>>  mm/rmap.c        | 4 ++--
>>  3 files changed, 10 insertions(+), 5 deletions(-)
>>
>> diff --git a/lib/test_hmm.c b/lib/test_hmm.c
>> index 761725bc713c..cd5c139213be 100644
>> --- a/lib/test_hmm.c
>> +++ b/lib/test_hmm.c
>> @@ -269,6 +269,11 @@ static bool dmirror_interval_invalidate(struct mmu_interval_notifier *mni,
>>  	    range->owner == dmirror->mdevice)
>>  		return true;
>>  
>> +	if (range->event == MMU_NOTIFY_CLEAR &&
>> +	    range->owner == current) {
>> +		return true;
>> +	}
> I don't understand this, there is nothing in hmm that says only
> current can call hmm_range_fault, and indeed most applications won't
> even gurantee that.

No it's the opposite, if we are ourselves the invalidator, don't care.

> So if this plan relies on something like the above in drivers I don't
> see how it can work.
>
> If this is just some hack for tests, try instead to find a solution
> that more accurately matches what a real driver should do.
>
> But this also seems overall troublesome to your goal, if you do a
> migrate inside hmm_range_fault() it will generate an invalidation call
> back and that will increment the seqlock and we will loop
> hmm_range_fault() again which rewalks.

That's the problem this solves.
The semantics is "if we are the invalidator don't wait for invalidate end",
aka don't mmu_interval_set_seq() that would make hang in the next mmu_interval_read_begin(),
waiting the invalidate to end

>
> Jason
>
--Mika


