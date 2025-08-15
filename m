Return-Path: <linux-kernel+bounces-770353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 847CBB279DE
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 09:16:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6599AC36CE
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 07:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0D0E2C3770;
	Fri, 15 Aug 2025 07:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lc5Vw6kq"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2103C29ACC4
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 07:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755241912; cv=none; b=rzg0eK3DH6I0v/R7I3Qmj6Bzh1+SwB7DNmXG33eLWsvlfd3JjU+PqSPyERBqlePuz7KJr4LlwOMWGdQVOUW13TiCHq3i2aZoAQwxMS4qbfve7eM5iY4Hdr9tWryG68kzsQB/ejNtBsycKzO2dd+D9UrcyUtuzbI5/UI7GWpzggY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755241912; c=relaxed/simple;
	bh=HmtK/QnIlqo/vYEDbysvdF8yiu4U1nO6lGdBQdMQOVA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ejh4u4SKsVX/luAGg5uRT/RKhjRrkKaBTKxTYGZhsP6KnRSG8UoSq1M/bj5HjV1ux9FiusBTVa3KFKtuRnBu937pMKlXRq7Y3KARp9FIrDEhZpdtAt7vULoEHzPIBlemFWYrmlzArQYFoiv6CjoCLuNcmGh20cKZaDw70Y4ueTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Lc5Vw6kq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755241909;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=64tD7SquxlFNDEbC3pNsIE3pob3nz1tYkUOwDAu4r0E=;
	b=Lc5Vw6kqUzFpqK5mUJHxQsES7X9dL2Nl+/eGZ4HbJYFVgRdz0f+yJP+81fV/xhv2F/bnLZ
	fw6AeorPTXj6DT7/ZAgIrgAH7wwjcmsXAVqjkiLvKDuRzDZplYHmEQZ1407Ksvc9CCviZ5
	RtWIQMIONO1Z926I6QKtCoQb/0XjriQ=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-60-n4d3FUM7MjuXLiCHGT-qeA-1; Fri, 15 Aug 2025 03:11:47 -0400
X-MC-Unique: n4d3FUM7MjuXLiCHGT-qeA-1
X-Mimecast-MFC-AGG-ID: n4d3FUM7MjuXLiCHGT-qeA_1755241906
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-55ce524a96aso936986e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 00:11:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755241904; x=1755846704;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=64tD7SquxlFNDEbC3pNsIE3pob3nz1tYkUOwDAu4r0E=;
        b=AE2Ludi49v4I7vKiOzh3sMJm4ll9l9UUWtQA0SL/ZMNoQnRQmGJE4XAJollxbDDPwT
         OCUDSM5W9qGhVh2hhbbZARko32GM4B4VP2WSSKc3NZkoBBK4s6TD7RPddVjrYDDFZ+tB
         +F2eZhqbqMTyqI8VOCW0hFnsY1Ts7LcZ/IimMc5WKj1t4mpz4eHIUmDrsj2+URIv8pNB
         ohOMUsuBA+Ui59UYSFGuvII40LyZj7fA3eiaTeIwtShVnFFnS2hQ2cIujSyjixVHDKz0
         CFufwtP94KtHwzPW7jx/jZHW1K+JPOR5M/ZvY6ULZHKV/95xBPKC4nSPlZH2Src2/0rC
         xsYA==
X-Forwarded-Encrypted: i=1; AJvYcCWGb7fRDaU0Diu+VjEy18KBI+qDSeKoUB/q5/o++tXkhEgyaoHEfEYsF/6aPrErj29aCx/ydupkkxwEMJI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywfn8pbRZs4T9J0D/DSm4m/urnFMP5yf9t56DekAC/hqsQcfrP5
	7a1LnMA3hTEfaEQRj9Xdo+pL9cMtBadJKj+kHF4NcATzgVACZP2WNgQ+f6inJC58xNlGHwoeWJb
	DLyhBkAiQC0SFOt3E820pGf9a2t7vjw/fvEK4oHR5MT4CySlwK6soWDeSUff1TAXq96uTAH3z
X-Gm-Gg: ASbGncsROJK5vpZMh2vNT0A2ShFNxNK3DwYBq4YsRgxh66DJmOLca4IAlSaHHymy0xq
	GEMg1YKB5FpgvXtkdUqnt2ZU4+coRPF0ik63u7fcbadB5MLhjZnNqskcbdOqW0JZ8ka0HnQB8pC
	GidEHEYL3U4dtm0FqXB04VUyzl2yBuPws791EZ1gT0+imH8Y5kl13AhwLxjfauQ9X7uS98Zrw7F
	4eCGKjxJZgU0uPOXRGFL5AVIlO6Lz/ob3hAz4ezY12dAoY4jw9qjjARNCyiZC1hWWV+z8i6Fgvs
	NDCHadefKiufxgJOzRmfPY55xBT9hq+QI+LmDwEca/UoDtT+R9FljKE8rTgUi0AK7w==
X-Received: by 2002:a05:6512:3da5:b0:55c:d674:4a1d with SMTP id 2adb3069b0e04-55ceebae268mr322970e87.56.1755241904420;
        Fri, 15 Aug 2025 00:11:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG6vMtE71fmtMMpJ1PZZijtMSMe5cHVNFNkTB26zZbYwP1tHYjcj98dWZzlOVlyT7bdSoGmUQ==
X-Received: by 2002:a05:6512:3da5:b0:55c:d674:4a1d with SMTP id 2adb3069b0e04-55ceebae268mr322955e87.56.1755241903918;
        Fri, 15 Aug 2025 00:11:43 -0700 (PDT)
Received: from [192.168.1.86] (85-23-48-6.bb.dnainternet.fi. [85.23.48.6])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55cef35a187sm129113e87.46.2025.08.15.00.11.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Aug 2025 00:11:42 -0700 (PDT)
Message-ID: <1e854923-c746-45ce-9f56-1c01a41992b3@redhat.com>
Date: Fri, 15 Aug 2025 10:11:41 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/4] mm: use current as mmu notifier's owner
To: Alistair Popple <apopple@nvidia.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, David Hildenbrand <david@redhat.com>,
 Leon Romanovsky <leonro@nvidia.com>, Balbir Singh <balbirs@nvidia.com>
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
Content-Language: en-US
From: =?UTF-8?Q?Mika_Penttil=C3=A4?= <mpenttil@redhat.com>
In-Reply-To: <pk4yq5kt5csh5yqd7f2s66eux6yvluxv3rcwrskaagyxcgo34j@6wei37bgqlye>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/15/25 08:23, Alistair Popple wrote:

> On Thu, Aug 14, 2025 at 08:45:43PM +0300, Mika Penttilä wrote:
>> On 8/14/25 20:20, Jason Gunthorpe wrote:
>>
>>> On Thu, Aug 14, 2025 at 08:00:01PM +0300, Mika Penttilä wrote:
>>>> as well as hmm test module with :
>>>>
>>>>          * Ignore invalidation callbacks for device private pages since
>>>>          * the invalidation is handled as part of the migration process.
>>>>          */
>>>>         if (range->event == MMU_NOTIFY_MIGRATE &&
>>>>             range->owner == dmirror->mdevice)
>>>>                 return true;
>>> If I recall this was about a very specific case where migration does a
>>> number of invalidations and some of the earlier ones are known to be
>>> redundant in this specific case. Redundant means it can be ignored
>>> without causing an inconsistency.
>>>
>>> Alistair would know, but I assumed this works OK because the above
>>> invalidation doesn't actually go on to free any pages but keeps them
>>> around until a later invalidation?

Thanks Alistair for your deep insights! 

> Right, the pages don't actually get freed because a reference is taken on them
> during migrate_vma_setup(). However other device MMU's still need invalidating
> because the driver will go on to copy the page after this step. It's just
> assumed that the driver is able to be consistent with itself (ie. it will unmap/
> invalidate it's own MMU prior to initiating the copy).

And reference is taken as well in migrate on fault during hmm_range_fault
if migrating.

>
> In practice I suspect what Mika is running into is that the page table
> synchronisation for migration works slightly differently for migrate_vma_*().
>
> Instead of using mmu_interval_notifier's which have a sequence number drivers
> typically use normal mmu_notifier's and take a device specific lock to block
> page table downgrades (eg. RW -> RO). This ensures it's safe to update the
> device page tables with the PFNs/permissions collected in migrate_vma_setup()
> (or the new PFN) by blocking other threads from updating the page table.
>
> The ususal problem with this approach is that when migrate_vma_setup() calls
> the mmu_notifier it deadlocks on the device specific lock in the notifier
> callback because it already holds the lock, which it can't drop before calling
> migrate_vma_setup().
>
> I think one of the main benefits of a series which consolidates these two
> page-table mirroring techniques into common code would also be to make the
> mirroring/invalidation logic the same for migration as hmm_range_fault(). Ie. to
> move to mmu_interval notifers with sequence numbers for migration, perhaps with
> filtering if required/safe and retries

Yes with the migrate_vma_setup() and collecting removed, the firing of mmu notifiers
and "collecting" are integral part of the hmm_range_fault() flow, so logical to use
interval notifiers for migrate also.

I have removed the commit with the owner games. I studied it more and seems it was added
to mitigate a bug in an early version, which led me to do wrong conclusion of the root cause
of the hang. That version had unbalanced mmu_notifier_invalidate_range_start()
after returning from hmm_range_fault() with EBUSY (after done a folio split).
With that fixed, driving the migrate on fault using the interval notifiers seems to work well, 
filtering MMU_NOTIFY_MIGRATE for device for retries.

>
>  - Alistair

--Mika



