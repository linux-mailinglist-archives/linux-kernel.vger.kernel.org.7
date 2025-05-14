Return-Path: <linux-kernel+bounces-648188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15628AB7331
	for <lists+linux-kernel@lfdr.de>; Wed, 14 May 2025 19:46:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9D2318914E6
	for <lists+linux-kernel@lfdr.de>; Wed, 14 May 2025 17:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D07391A08AB;
	Wed, 14 May 2025 17:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C2M5kH1y"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 934252AD2F
	for <linux-kernel@vger.kernel.org>; Wed, 14 May 2025 17:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747244803; cv=none; b=WI/fzVSBr2e/r2j6O8iuLRn15OvqGIrLHOlxnN41VNLdF51GzVJV5jwMOJnSrrGmTLJ4X0EEmpvJXbkAijas3Stxh7yYMUtxzCn5iGTsqOCRf/2H866L81U/IH/HF6lPUQ6fEeI0OkNNjQcNvDggXuralo9KVt7G3XUiZUf3XZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747244803; c=relaxed/simple;
	bh=bZia1Vh3ocrDUazIpDxPRgAJ5leoVhGLQRoyxrcOmYk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kl6Ajd0f4PMm5Os/FJ2BnnC2sRarX0EnsTvpPMtwnc4cOm4eJY/A8YDcxuViNGb6Bw3KwQd5c0778ZlBF3DzSEyjKgyGsaDNnbYxNmZIAF90uqnmdNXHeJ5k8j+IKeAzezZLjP7cp+uGCY5vNHkmfwigwv8zqbuUcwP6F7C6dg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C2M5kH1y; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747244800;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=yoiwcZisTgluVXVCyfT7mtJmVLY0rEZAMjXE2C3fb2c=;
	b=C2M5kH1yd0DFPjma/+lA4B/CnGJBX6RMMOovsk58P0cKlXLkxfxw3bbXlwdNUqA+vv1BNS
	XwE6Srst0tqaITB26iJK5RjiCmZyGGSnUw7BguH6EXd0TDOxSw/e5pitlJc0gbJ9tt7jSk
	0DYqX9X2A+AZDA5QZCoJeE0rNRktm6U=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-438-fHQripxQMv21i-FinuXp6A-1; Wed, 14 May 2025 13:46:39 -0400
X-MC-Unique: fHQripxQMv21i-FinuXp6A-1
X-Mimecast-MFC-AGG-ID: fHQripxQMv21i-FinuXp6A_1747244798
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3a1c86b62e8so23029f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 May 2025 10:46:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747244797; x=1747849597;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yoiwcZisTgluVXVCyfT7mtJmVLY0rEZAMjXE2C3fb2c=;
        b=Wb6ySsKoqMB/xF3PIb5eEEvxbpkJh7o9vIM8qjxXtley7nty8UaFkT1AnQsEeXGw8l
         WEfp8Yn84X+hp+LchjAWL6g7vYwzzYHGzKwP+BzEJKuG21tGOpxoepOzW5fpBpdsUEZG
         uE0LRJG9Ec97xqcl18IgVivH8vAtPnqdRLzoOTKgeKqirzyqoxERSMMWvAepJnzsgSbq
         rbZc+j4ipdRri8hzTRF3NFbljX/KrfokCYe93Bbfxg2YO9XmcYi7uNbod2mlAo/Sx2ba
         AL+4v+DR0CKFZrrMkiiygL7YjWDs2Fr9APsl+at4wMObBG+P0GCLQwlUB5QQ1WPsE9Dr
         CkVg==
X-Gm-Message-State: AOJu0Yw6gIR7Vk5YvDSLhlUIgAO8iRntIozdQ+iQ5k6w7YC6bJFbUcDA
	W2B35xbX9qE9IVZtv2Qtf74UPZryzMmnehVgnGLygi3jy0HbxrYZUTTHrG1jeTIGL55m6bv89o5
	N1eTTljMr5Y5zw4KSsz+cs3Vus1Psf3sZEoIMc6jSFsvlre7XzdezpJTthsLBnA==
X-Gm-Gg: ASbGncs2oSEtICKKjcKrv1mcWreK+WlgRpwBwar2zG0E6m6Ux49vzl9KfAL4dsk93HY
	toagiQ3BJ/DYHDbZJGiQujlZ3q6Hu+AspDr4lP7XZnEmtBDc0ZxOBI5ODmW/N0Tm6scd+5lTHkd
	r7+xymwknLUquJ4jsQB2LvTX8gGKlyutnFgI3B3Q2eo35g5GKFSvww7bs5FtHj6Sg6Z05YD07ol
	8vT3zyY2Y4xG9iR3wFu5GaZvdq4cwxXN6If2in/i4aLL735g4X+EKPCLn+aMKdm/EyKiVDqB/IH
	Who9L+lUPYmPMX1qr/g2gWNp5XBE4F9Pd3W7ZpV1Ovc9wrZVNzY5ujC/PA6Z0YpQ81wcVrL5U/H
	vjTsIINXWjAk0fwaPuWh34zkl+dH//UEets180Zs=
X-Received: by 2002:a05:6000:40c8:b0:3a1:f937:6e58 with SMTP id ffacd0b85a97d-3a3496c1e17mr4099967f8f.27.1747244797692;
        Wed, 14 May 2025 10:46:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEEYDR+YGH1enKcCd2/3IQssTMBPIsXCsHtF6Psuh+ujkE8oVsa4pruFbxedGUYbOMdVRZVJA==
X-Received: by 2002:a05:6000:40c8:b0:3a1:f937:6e58 with SMTP id ffacd0b85a97d-3a3496c1e17mr4099947f8f.27.1747244797306;
        Wed, 14 May 2025 10:46:37 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f15:6200:d485:1bcd:d708:f5df? (p200300d82f156200d4851bcdd708f5df.dip0.t-ipconnect.de. [2003:d8:2f15:6200:d485:1bcd:d708:f5df])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442f39ef8bbsm39252235e9.37.2025.05.14.10.46.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 May 2025 10:46:36 -0700 (PDT)
Message-ID: <7c508718-da88-4a37-b134-29aa89ee9899@redhat.com>
Date: Wed, 14 May 2025 19:46:35 +0200
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
 <d0e94a6e-6296-495a-b10a-569d41a65adb@redhat.com>
 <B0D9F799-481A-48E2-8AD7-DC193618869A@nvidia.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <B0D9F799-481A-48E2-8AD7-DC193618869A@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

>>>> Next, the page is removed from its memory
>>>>> block. When will PG_offline_skippable be used? The second phase when
>>>>> the page is being removed from its memory block?
>>>>
>>>> PG_offline_skippable is used during memory offlining, while we look for any pages that are not PageBuddy (... or hwpoisoned ...), to migrate them off the memory so they get converted to PageBuddy.
>>>>
>>>> PageOffline + PageOfflineSkippable are checked on that phase, such that they don't require any migration.
>>>
>>> Hmm, if you just do not want to get PageOffline migrated, not setting it
>>> __PageMovable would work right? PageOffline + __PageMovable is used by
>>> ballooning, as these inflated pages can be migrated. PageOffline without
>>> __PageMovable should be virtio-mem. Am I missing any other user?
>>
>> Sure. Just imagine !CONFIG_BALLOON_COMPACTION.
>>
>> In summary, we have
>>
>> 1) Migratable PageOffline pages (balloon compaction)
>>
>> 2) Unmigratable PageOffline pages (e.g., XEN balloon, hyper-v balloon,
>>     memtrace, in the future likely some memory holes, ... )
>>
>> 3) Skippable PageOffline pages (virtio-mem)
> 
> Thank you for all the explanation. Now I understand how memory offline
> and memory hotunplug work and shall begin to check the patches. :)

Sure, if you think the doc or some comments could be updated, I'm happy 
to review such changes.

It's always very helpful to receive feedback from someone that's new to 
this code.

-- 
Cheers,

David / dhildenb


