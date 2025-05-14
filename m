Return-Path: <linux-kernel+bounces-648160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99D14AB72C9
	for <lists+linux-kernel@lfdr.de>; Wed, 14 May 2025 19:28:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF92A860FD0
	for <lists+linux-kernel@lfdr.de>; Wed, 14 May 2025 17:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 805BD27E7F3;
	Wed, 14 May 2025 17:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Csry1Naq"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B08B61A9B24
	for <linux-kernel@vger.kernel.org>; Wed, 14 May 2025 17:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747243694; cv=none; b=c6OxADctaq6Pzw49qpfi8cKXroaP82CpeRL1bg3fqi3NhIXbz+m5MtWdvyI6oJaSZiMs3x0auVPDS+1I4V3qwlLnp3tJbazHNRD1fkmMMms5tn5OJo4/0dPQHRmudOLAVAiLg8iwFRRpN+dZKMci9lYcedOpAx5heNTU0MLNwHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747243694; c=relaxed/simple;
	bh=D21WjG1qzRDpE+7KnlXCuEwjs9Nd2MHKUFNYeD8ht+s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ahu8NcooYMqGNm/7afIT6dmO7168oaewUHbLEVdifddkPSaot1gp26gwuJTv2nDRZPdQ8tWB2MUxxvkOn1xYKEg5haW1ZkpNyI0f+B3ntqj1AXzyGXrfeYYnpmG+KVDmzutATid12KBVoihIYmaztoC3w5m0Ahl98twqxzhKtvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Csry1Naq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747243691;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=KKipJVFxVSWLoYR/8ZGOjC3q1DU2kFx1BCdCiRvnpUc=;
	b=Csry1Naq0/zNr32jbz+oX85Tgy7foNLSxTrzz1mZ+BdyC6cvBDPPinSvL6ygCjBDhEAwtu
	6fYu0r8LwXBc5HC+LYXO8+sSPNsmBkDbrPEAwPNTSfsC2+1IKGv80jAOzwPVTSt4XjmvBX
	dPllX33jxOkUavwPeSaO8iWBTH8j+O8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-416-pxADKeCON_mRDWm8FZ_P4Q-1; Wed, 14 May 2025 13:28:10 -0400
X-MC-Unique: pxADKeCON_mRDWm8FZ_P4Q-1
X-Mimecast-MFC-AGG-ID: pxADKeCON_mRDWm8FZ_P4Q_1747243689
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3a0b7ceaa20so12957f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 May 2025 10:28:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747243689; x=1747848489;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KKipJVFxVSWLoYR/8ZGOjC3q1DU2kFx1BCdCiRvnpUc=;
        b=FApB2fRlkK7HwIAtq6Lg2GZ3NO6kCC2YpymmpInES7SdxVfshZJRQXs6abvXIYcDZN
         VpfiTtbRKac1v5uU/NjIk9euhjDVzLPhRt+WpmacJIKQgMksZ0TIvhy5+3IQiptPSsc1
         feSLzbSDJ/X995+2+7SnIiCWsN0yUmZLVzMfojg8159f8FaimO7SxhZsx2EiX8FcV150
         /FsfEN83hOyyLqROCzGJLpSbjkpJIzaVXDQz/8Xvqjze2OvXG6z8RKzkD7KvXiiEOxUN
         66twuO/INhKaBieT/qGtyvE84I2wcO99Z+/5ts7YA9ylpaksVYISR+LY5pvRgQiqlW/J
         WE1Q==
X-Gm-Message-State: AOJu0Yw+Vm8EXUkZV0hmHxlaQpTkoUuz2Osww5cqsibUMSyXWndisyqq
	JGVPDyr1HGBLH7M1+FelxajRYwHfOVAsRl37Fz/lbUR6CIyXbRROg5+B0XS1+UtlhVe4c7cNvZ+
	Pl+RETguXMQVKRhH/+2Pciga1uNc7wrok0NXl0dwsvlmh9dzfuqoXKRkJFeHeXw==
X-Gm-Gg: ASbGncsHVR+CfVVJT9XPewLqXXPV2CKZXSbF6uz8XDcgh5awE7spxJWJVps81ZYFxjf
	TmOLrRusjFPfIK6H2bos2DkCr24ymT34IeBfsfMJy+02YQbV7cVJN0n8OOBAVNd0aYi7SaH1jGn
	W7OulTBHRVnbqejnTWECMCdO2VUoELwxg+F/ZAESpdVfSMaUSv7sAm7SLI6j8gnFjl1oCRPOjRq
	6AOI4ejfn+6Dteq//dzOp7Ac529w3xPKj7WEXTZjrUmmt41MwTvUYwA4fsEDCBw7jtDr9BXKxBa
	jkWQ4+uIQ7YSxH0O6Eyo+WYW0C8YyiTz1fGi36uKHvo4t3G27wM88w9beLANbFXt4zwLZL0+fze
	2uB0ka3GHXBA18B6iBUTJpLMvzmw4Dwk0JhWsS04=
X-Received: by 2002:a5d:64cb:0:b0:39e:e259:91fd with SMTP id ffacd0b85a97d-3a3496a5a2cmr3518669f8f.17.1747243689001;
        Wed, 14 May 2025 10:28:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF9bmLBHqr24D274Cr0f3nYtV6J5X+qHvcp130O9F6XbCxww4ZuGOdjE3AGxWL4N/WVXtcEKw==
X-Received: by 2002:a5d:64cb:0:b0:39e:e259:91fd with SMTP id ffacd0b85a97d-3a3496a5a2cmr3518651f8f.17.1747243688589;
        Wed, 14 May 2025 10:28:08 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f15:6200:d485:1bcd:d708:f5df? (p200300d82f156200d4851bcdd708f5df.dip0.t-ipconnect.de. [2003:d8:2f15:6200:d485:1bcd:d708:f5df])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442f396c0ddsm38494445e9.30.2025.05.14.10.28.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 May 2025 10:28:08 -0700 (PDT)
Message-ID: <d0e94a6e-6296-495a-b10a-569d41a65adb@redhat.com>
Date: Wed, 14 May 2025 19:28:06 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/2] mm/memory_hotplug: introduce and use
 PG_offline_skippable
To: Zi Yan <ziy@nvidia.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>, Oscar Salvador
 <osalvador@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Brendan Jackman <jackmanb@google.com>, Johannes Weiner <hannes@cmpxchg.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>
References: <20250514111544.1012399-1-david@redhat.com>
 <4B7FCC74-EAB2-426B-AFE0-4250FE4F7480@nvidia.com>
 <8ce464e2-1447-4e60-8abe-f4ddd511d7a7@redhat.com>
 <1662085A-4536-4020-957D-90FB262C6014@nvidia.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <1662085A-4536-4020-957D-90FB262C6014@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

>>
>> Note that PageOffline() is a bit confusing because it's "Memory block online but page is logically offline (e.g., has a memmap that can be touched, but the page content should not be touched)".
> 
> So PageOffline() is before memory block offline, which is the first phase of
> memory hotunplug.

Yes.

> 
>>
>> (memory block offline -> all pages offline and have effectively no state because the memmap is stale)
> 
> What do you mean by memmap is stale? When a memory block is offline, memmap is
> still present, so pfn scanner can see these pages. pfn scanner checks memmap
> to know that it should not touch these pages, right?

See pfn_to_online_page() for exactly that use case.

For an offline memory section (either because it was just added or 
because it was just offlined), the memmap is assumed to contain garbage 
and should not be touched.

See remove_pfn_range_from_zone() -> page_init_poison().

> 
>>
>>> removed from page allocator.
>>
>> Usually, all pages are freed back to the buddy (isolated pageblock -> put onto the isolated list). Memory offlining code can then simply grab these "free" pages from the buddy -- no PageOffline involved.
>>
>> If something fails during memory offlining, these isolated pages are simply put back on the appropriate migratetype list and become ordinary free pages that can be allocated immediately.
> 
> I am familiar with this part. Then, when PageOffline is used?
> 
>  From the comment in page-flags.h, I see two examples: inflated pages by balloon driver
> and not onlined pages when onlining the section. These are two different operations:
> 1) inflated pages are going to be offline, 2) not onlined pages are going to be
> online. But you mentioned above that Memory off lining code does not involve
> PageOffline, so inflated pages by balloon driver is not part of memory offlining
> code, but a different way of offlining pages. Am I getting it right?

Yes. PageOffline means logically offline, for whatever reason someone 
decides to turn pages logically offline.

Memory ballooning uses and virtio-mem are two users, there are more.

> 
> I read a little bit more on memory ballooning and virtio-mem and understand
> that memory ballooning still keeps the inflated page but guest cannot allocate
> and use it, whereas virtio-mem and memory hotunplug remove the page from
> Linux completely (i.e., Linux no longer sees the memory).

In virtio-mem terms, they are considered "fake offline" -- memory 
behaves as if it would never have been onlined, but there is a memmap 
for it. Like a (current) memory hole.

> 
> It seems that I am mixing memory offlining and memory hotunplug. IIUC,
> memory offlining means no one can allocate and use the offlined memory, but
> Linux still sees it; memory hotunplug means Linux no longer sees it (no related
> memmap and other metadata). Am I getting it right?

The doc has this "Phases of Memory Hotplug" description, where it is 
roughly divided into that, yes.

> 
>>
>> Some PageOffline pages can be migrated using the non-folio migration: this is done for memory ballooning (memory comapction). As they get migrated, they are freed back to the buddy, PageOffline() is cleared -- they become PageBuddy() -- and the above applies.
> 
> After a PageOffline page is migrated, the destination page becomes PageOffline, right?
> OK, I see it in balloon_page_insert().

Yes.

> 
>>
>> Other PageOffline pages can be skipped during memory offlining (virtio-mem use case, what we are doing her). We don't want them to ever go through the buddy, especially because if memory offlining fails they must definitely not be treated like free pages that can be allocated immediately.
> 
> What do you mean by "skipped during memory offlining"? Are you implying when
> virtio-mem is offlining some pages by marking it PageOffline and PG_offline_skippable,
> someone else can do memory offlining in parallel?

It could happen (e.g., manually offline a Linux memory block using 
sysfs), but that is not the primary use case.

virtio-mem unplugs memory in the following sequence:

1) alloc_contig_range() small blocks (e.g., 2 MiB)

2) Report the blocks to the hypervisor

3) Mark them fake-offline: PageOffline (+ PageOfflineSkippable now)

Once all small blocks that comprise a Linux memory block (e.g., 128 MiB) 
are fake-offline, offline the memory block and remove the memory using 
offline_and_remove_memory().

In that operation -- offline_and_remove_memory() -- memory offlining 
code must be able to skip these PageOffline pages, otherwise 
offline_and_remove_memory() will just fail, saying that there are 
unmovable pages in there.

> 
>>
>> Next, the page is removed from its memory
>>> block. When will PG_offline_skippable be used? The second phase when
>>> the page is being removed from its memory block?
>>
>> PG_offline_skippable is used during memory offlining, while we look for any pages that are not PageBuddy (... or hwpoisoned ...), to migrate them off the memory so they get converted to PageBuddy.
>>
>> PageOffline + PageOfflineSkippable are checked on that phase, such that they don't require any migration.
> 
> Hmm, if you just do not want to get PageOffline migrated, not setting it
> __PageMovable would work right? PageOffline + __PageMovable is used by
> ballooning, as these inflated pages can be migrated. PageOffline without
> __PageMovable should be virtio-mem. Am I missing any other user?

Sure. Just imagine !CONFIG_BALLOON_COMPACTION.

In summary, we have

1) Migratable PageOffline pages (balloon compaction)

2) Unmigratable PageOffline pages (e.g., XEN balloon, hyper-v balloon,
    memtrace, in the future likely some memory holes, ... )

3) Skippable PageOffline pages (virtio-mem)

-- 
Cheers,

David / dhildenb


