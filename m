Return-Path: <linux-kernel+bounces-774856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5920B2B85F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 06:33:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6184523A6A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 04:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D35525A331;
	Tue, 19 Aug 2025 04:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f8ISOjxu"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E0C225403
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 04:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755577991; cv=none; b=HwJDvGvJq01pd3XdRFfX/8LOjlZD5GNv/Mbo7nR14mzqZ08yv0qxWOU/n0AmFPUgKmtvjZ0k2CDlROnHr6Phjl0SG4fC3O6plkXfafwYQ1CdevBUqQ9togUJLM061xAV8PrB8IQW4MwGzJU99UIZaFrZ5WhQqcVa0v0Ugik+njU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755577991; c=relaxed/simple;
	bh=7/A2UQ1VApmog+rPkyrLFiq2w/miNpN4tNmt9Pu/YYE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iypNMvWJwm+yBf1OmhYJST6fttuIfMOAPOluG1Ytdnkk+6YsQYUOq4m3XfbrdaV81rXqahuGE6AOSXlSaCzKNTSY6P2TFifCLkx1f9JSmUgS0yEqNyBPQu1KjnPX1tX0HDb0ESxpAd/jMcqqOqBU4sz5/a9J1l+lnqZVkSHxLbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f8ISOjxu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755577989;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qG/E26p+ZfYqeJl4XChPlBI0YsV/ZEQedBJc5ags4o4=;
	b=f8ISOjxuypo2NCFOJFVrGYbv9iZQw2BH94VF0wR/Zicu3iKim3e+hSAbwGuR7UvB7OmEjH
	lt8sQG9io9GEBaYGRm7TlByWKg9PvkO2l1OqdcRIJtOhtmA1JNbe1861fvIWOQaBp3ARf4
	lG5DQV7KBK2IJvWMBHc+4KGRMKjPgho=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-161-7ETS74LdPJyw1B__r7BIOA-1; Tue, 19 Aug 2025 00:33:07 -0400
X-MC-Unique: 7ETS74LdPJyw1B__r7BIOA-1
X-Mimecast-MFC-AGG-ID: 7ETS74LdPJyw1B__r7BIOA_1755577986
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-55ce5255696so1733104e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 21:33:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755577984; x=1756182784;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qG/E26p+ZfYqeJl4XChPlBI0YsV/ZEQedBJc5ags4o4=;
        b=BYJNwrU5io4K2ILiT7vHayD86wHprAwaBcXMEIVcKUjtmhbcwOgw12lg2Cqb4FMuen
         /wIEfbIOF+1/5WXIxho4weq7h6MdORXKr1pQ7UTZ3TCx2y5JwqYtB6RUDwNof/591Fgs
         aTr2E2FL1TMCWicNyiy9gQOZpEW1TLYdE8XdTvh1J4EUuRLpDmuoQrqbSbx+jiZ+pCOi
         nxxaFysFWsz1BIfwE4Cj9MI800AGWhUB9FBtfA2wJKe48KY2qTffTnJ5Zrpm3yOI1VDe
         /yu+6croV3bwwaqSxH9kis0rwvbwafqdaQLYmrqM7FaGRZhGPwmna6zaVaGmpY7jjVud
         Kl9A==
X-Forwarded-Encrypted: i=1; AJvYcCU6h7FKC5RMbTkfSgCcE7xtwijcVRg1PX92sivjWRTBWra3EcffKY1TB2lDDZWYG/53nXXrHQW6Vdve1+U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiCffcLL4h2bP3OsiwcHFCa0n/OEJlqTNuwejT9giLAO0dcf8r
	exhRxAMypoJVJ8PxH+1YHL+qSGmzhJ72x10SU3d6/kko5ZuCCSty9Ofr3alGwzllXHzPqIReubz
	Yu6T42SiWSi1Y+UFGS+shik7VpXsC3ecf/26hBYhnaS0HzhCM+yfi6H7eiQtHH79M7uxmNKM+
X-Gm-Gg: ASbGncsCb2/9ajuAnDpxTP8IuJ1nWVgmPW6i/bZD2gxLLteoYLu9bcgli8wSNHM/mc7
	BfJRhfCP0dMJ+uZRPPHxm24bDi7chiNCymvat+lqCLJTGu8HM5pe+L+93ijvTbsmE9V797p7cy8
	LnciNx/vu32qSQl0sZLaj2AUwxn+juWK/jszZWA8lO7CuiQk8+hwyB6D9dNCAGlB+7uCwM1wP2N
	yHB8yTm2+hGuVID4mWsx7UCTBtEQHgIBdhlF0UcnVO4l+p9tvBmXsLpZm+7GAsjrOlLF/H0cx5j
	HRpX9BqGjJnnGDydbCG8AzCb0gjjj+eaNIuNI0HpYpp9WRTZBknZZK0Wxxuxasoj0w==
X-Received: by 2002:a05:6512:6318:b0:55c:c971:224a with SMTP id 2adb3069b0e04-55e00846b5emr289938e87.42.1755577984024;
        Mon, 18 Aug 2025 21:33:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFKVeAFak+03265wWqjfT393ZS1nH5/RODtNQm950oP5LIYFdFv+RPj0sv4qkxSrGh+nFgPwQ==
X-Received: by 2002:a05:6512:6318:b0:55c:c971:224a with SMTP id 2adb3069b0e04-55e00846b5emr289927e87.42.1755577983574;
        Mon, 18 Aug 2025 21:33:03 -0700 (PDT)
Received: from [192.168.1.86] (85-23-48-6.bb.dnainternet.fi. [85.23.48.6])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55cef3515f9sm1972164e87.30.2025.08.18.21.33.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Aug 2025 21:33:02 -0700 (PDT)
Message-ID: <614bb7b7-85c4-4e49-95e7-8faed5372cf6@redhat.com>
Date: Tue, 19 Aug 2025 07:33:02 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/4] mm: use current as mmu notifier's owner
To: Balbir Singh <balbirs@nvidia.com>, Alistair Popple <apopple@nvidia.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, David Hildenbrand <david@redhat.com>,
 Leon Romanovsky <leonro@nvidia.com>
References: <20250814072045.3637192-1-mpenttil@redhat.com>
 <20250814072045.3637192-3-mpenttil@redhat.com>
 <20250814124041.GD699432@nvidia.com>
 <2da9464b-3b3d-46bd-a68f-bfef1226bbf6@redhat.com>
 <20250814130403.GF699432@nvidia.com>
 <67b6e041-4bea-485d-a881-cc674d719685@redhat.com>
 <20250814141136.GG802098@nvidia.com>
 <c7bbbbc8-b9fc-40f5-b86f-e43b9a85aaef@redhat.com>
 <20250814172018.GJ802098@nvidia.com>
 <2982b6f1-7c14-46ef-afb0-7951f7cdc2aa@redhat.com>
 <pk4yq5kt5csh5yqd7f2s66eux6yvluxv3rcwrskaagyxcgo34j@6wei37bgqlye>
 <1e854923-c746-45ce-9f56-1c01a41992b3@redhat.com>
 <e054f622-69ad-4724-b12d-c2545d913170@nvidia.com>
Content-Language: en-US
From: =?UTF-8?Q?Mika_Penttil=C3=A4?= <mpenttil@redhat.com>
In-Reply-To: <e054f622-69ad-4724-b12d-c2545d913170@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 8/19/25 07:27, Balbir Singh wrote:

> On 8/15/25 17:11, Mika Penttilä wrote:
>> On 8/15/25 08:23, Alistair Popple wrote:
>>
>>> On Thu, Aug 14, 2025 at 08:45:43PM +0300, Mika Penttilä wrote:
>>>> On 8/14/25 20:20, Jason Gunthorpe wrote:
>>>>
>>>>> On Thu, Aug 14, 2025 at 08:00:01PM +0300, Mika Penttilä wrote:
>>>>>> as well as hmm test module with :
>>>>>>
>>>>>>          * Ignore invalidation callbacks for device private pages since
>>>>>>          * the invalidation is handled as part of the migration process.
>>>>>>          */
>>>>>>         if (range->event == MMU_NOTIFY_MIGRATE &&
>>>>>>             range->owner == dmirror->mdevice)
>>>>>>                 return true;
>>>>> If I recall this was about a very specific case where migration does a
>>>>> number of invalidations and some of the earlier ones are known to be
>>>>> redundant in this specific case. Redundant means it can be ignored
>>>>> without causing an inconsistency.
>>>>>
>>>>> Alistair would know, but I assumed this works OK because the above
>>>>> invalidation doesn't actually go on to free any pages but keeps them
>>>>> around until a later invalidation?
>> Thanks Alistair for your deep insights! 
>>
>>> Right, the pages don't actually get freed because a reference is taken on them
>>> during migrate_vma_setup(). However other device MMU's still need invalidating
>>> because the driver will go on to copy the page after this step. It's just
>>> assumed that the driver is able to be consistent with itself (ie. it will unmap/
>>> invalidate it's own MMU prior to initiating the copy).
>> And reference is taken as well in migrate on fault during hmm_range_fault
>> if migrating.
>>
>>> In practice I suspect what Mika is running into is that the page table
>>> synchronisation for migration works slightly differently for migrate_vma_*().
>>>
>>> Instead of using mmu_interval_notifier's which have a sequence number drivers
>>> typically use normal mmu_notifier's and take a device specific lock to block
>>> page table downgrades (eg. RW -> RO). This ensures it's safe to update the
>>> device page tables with the PFNs/permissions collected in migrate_vma_setup()
>>> (or the new PFN) by blocking other threads from updating the page table.
>>>
>>> The ususal problem with this approach is that when migrate_vma_setup() calls
>>> the mmu_notifier it deadlocks on the device specific lock in the notifier
>>> callback because it already holds the lock, which it can't drop before calling
>>> migrate_vma_setup().
>>>
>>> I think one of the main benefits of a series which consolidates these two
>>> page-table mirroring techniques into common code would also be to make the
>>> mirroring/invalidation logic the same for migration as hmm_range_fault(). Ie. to
>>> move to mmu_interval notifers with sequence numbers for migration, perhaps with
>>> filtering if required/safe and retries
>> Yes with the migrate_vma_setup() and collecting removed, the firing of mmu notifiers
>> and "collecting" are integral part of the hmm_range_fault() flow, so logical to use
>> interval notifiers for migrate also.
>>
>> I have removed the commit with the owner games. I studied it more and seems it was added
>> to mitigate a bug in an early version, which led me to do wrong conclusion of the root cause
>> of the hang. That version had unbalanced mmu_notifier_invalidate_range_start()
>> after returning from hmm_range_fault() with EBUSY (after done a folio split).
>> With that fixed, driving the migrate on fault using the interval notifiers seems to work well, 
>> filtering MMU_NOTIFY_MIGRATE for device for retries.
>>
> So this patch can be ignored in the series?

Yes this can be ignored. I will do more testing and repost after a while with this removed and
possibly with other changes if needed.

>
> Balbir
>
--Mika


