Return-Path: <linux-kernel+bounces-721826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71F38AFCE49
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 16:54:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9622B166C78
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 14:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DB3B2E0916;
	Tue,  8 Jul 2025 14:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C0ukVnDG"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D71802E06E4
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 14:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751986395; cv=none; b=jfiOzteADYK658a1PfbO/CdZLsyGLnXzPMH5fTTagovGe/IpSSGkHDp6Baju2tgJo9Q6QQhGdGXeIGlWNoyfzroyj4ite2nqXPDVsDctt5Euq7czbWGtXf6Tay88WvHp4DCpjwkV7qAZCmcCwH6zJB6wzH7ZDDOK9ugYTTajHu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751986395; c=relaxed/simple;
	bh=27UJQTuzjtUvwJRhdOEfqpEv1rJY5sJH45Moky3qtuY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=derwxXPiIXIH1MldwDZMMLRXOdEtHRWM6T+qfgjJSTBUYGePEpIElRPL/NJRJ8KOUhnepXxyrOMrbQxMd0w84MeaI0Saze+bzyH1Z85eiErnjl+pk8rOkril9tntYBzs6K38+MdZcVdsR8O58PGl2c0yHetkMm5aIEfjY5HpfT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C0ukVnDG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751986392;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=rCe86JPMwO4c8v3NuQ7XE/NoQnHPDOm/+k7/uOfiFTs=;
	b=C0ukVnDG4MKsuG6WBsNpTgjVLI755rTKoFfwd7cUNNxLDxLW2GI4Ns6mbRr0hyJgSH8HHr
	2VqtBBhnQIV/DvPEV+blsQNCc26oOH73a8R7C+s/DfVOd0CiOagJ+wQrjfY7N4/oHOAofn
	F/NeYIev9wiUOE84Te4nailMQFVFh80=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-1Fx_o26eOXCaH2mrO59eRA-1; Tue, 08 Jul 2025 10:53:11 -0400
X-MC-Unique: 1Fx_o26eOXCaH2mrO59eRA-1
X-Mimecast-MFC-AGG-ID: 1Fx_o26eOXCaH2mrO59eRA_1751986390
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-45320bfc18dso23313865e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 07:53:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751986389; x=1752591189;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rCe86JPMwO4c8v3NuQ7XE/NoQnHPDOm/+k7/uOfiFTs=;
        b=Vorv7sJKSfV7Ll35JLp1EwcFafVXPchE1fu+YuyYCTUGvrlq0gxGI4gh3d4hSIXrwI
         nwteUa28XUDHwIS41jONYJ7sWaQcFQm4iHAclFbOo1x1KdPhbUvOZ8VFXnSX2ib0YJPZ
         XEWbQOeEimfadNp7WMiiQUrvTgZZDyHQ3Tv32KjsDORkFbr8P7FG+zCTDHfpK2nPhl96
         M1GkhTkPMoDSJhU2UfopQRg3Z6xJSnmX0zMoGP7L2zztMYmhk7hjJSnOlmcfmQQuv/0a
         YMPfCQu5ZELegTgwd2offzktdush9fDC2+YHSm/AM5WuROm8UIY7SAoUSklmtRHn63ZU
         jdHw==
X-Forwarded-Encrypted: i=1; AJvYcCU3yiVHAAxLAVxErQDkgtgPDV4OfkVwvuN+EplgTENiPjGPjh9tT0rzGavaXKxA6sQEBxrr7aBs6Ll/N7M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTzupjEZeMXSyiWubtp3UAiz/CYur/k8FL1jxZcfNIIWAQHdi4
	j0DqaYooAgjXFYXY9S16Jl5WVaxuUNjlZDXAGg3DJx4cOX37foxVp+yeGzUbuIrwIUtomWgCe1A
	t+PoA/MuGp/4zuJlDjyElzzLARKFL3qacxPQ4c6X/KBRj4QQ4pvRB5AzNTenf+Mum4w==
X-Gm-Gg: ASbGncuKaHXeCBRdjxSzYcXN7M2A4clH528LQaXDFWE0EiH4XsXwe/Rg0nmbosYVjId
	lB0EpjQNwfkWnHwhzeGnujQGDpml9dDE61ttSZI7fsgHGKL/sDkpmAGZCtV/dtMGXEAg7xAssO+
	1Ut6ItsyxSlAWs44NLlP6ft8bgCIU3DjMOsP/kC9bb5bjaB/0erLoiLIkdiFMBNArzdR4tTgSES
	5r0uJyyG7HkTEE+f/MdxdU0Yro2MLCD/VD7pPPw48JDM/+aIpOf1S0xxh2ygSZWz/thrMvhIdmM
	lXoFGwsGNjehF7AVtCMdiU3bpOgWekmfVIW5ZEMFKl+SqaiVhMDKg8qGdgXYdCQOfKEnLhm8lfo
	fb5SvtyPr0emCt7xRhp/WBUn9Vbkq0HKkNZsyvajUvvioo22C0Q==
X-Received: by 2002:a05:600c:3b9f:b0:43b:c857:e9d7 with SMTP id 5b1f17b1804b1-454cd84a5f6mr29763115e9.5.1751986389488;
        Tue, 08 Jul 2025 07:53:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFyQ1YV1EcrA7DvbDPcZdP9Gs2eH3nGVPlIrchq+doAOLrr7ZMWJQ8MCUy1QCD+Ev1FLwgAvQ==
X-Received: by 2002:a05:600c:3b9f:b0:43b:c857:e9d7 with SMTP id 5b1f17b1804b1-454cd84a5f6mr29762815e9.5.1751986388951;
        Tue, 08 Jul 2025 07:53:08 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f1a:f500:4346:f17c:2bde:808c? (p200300d82f1af5004346f17c2bde808c.dip0.t-ipconnect.de. [2003:d8:2f1a:f500:4346:f17c:2bde:808c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454cd49d0ecsm24545955e9.31.2025.07.08.07.53.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jul 2025 07:53:08 -0700 (PDT)
Message-ID: <6ac61b0b-980a-487e-8b88-8ff1bc3f9f17@redhat.com>
Date: Tue, 8 Jul 2025 16:53:03 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v1 resend 00/12] THP support for zone device page migration
To: Balbir Singh <balbirs@nvidia.com>, linux-mm@kvack.org
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
 Karol Herbst <kherbst@redhat.com>, Lyude Paul <lyude@redhat.com>,
 Danilo Krummrich <dakr@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?=
 <jglisse@redhat.com>, Shuah Khan <shuah@kernel.org>,
 Barry Song <baohua@kernel.org>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Matthew Wilcox <willy@infradead.org>,
 Peter Xu <peterx@redhat.com>, Zi Yan <ziy@nvidia.com>,
 Kefeng Wang <wangkefeng.wang@huawei.com>, Jane Chu <jane.chu@oracle.com>,
 Alistair Popple <apopple@nvidia.com>, Donet Tom <donettom@linux.ibm.com>
References: <20250703233511.2028395-1-balbirs@nvidia.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250703233511.2028395-1-balbirs@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04.07.25 01:34, Balbir Singh wrote:

So, I shared some feedback as reply to "[RFC 00/11] THP support for zone 
device pages".

It popped up in my mail box again after there apparently was a 
discussion a couple of days ago.

... and now I realize that this is apparently the same series with 
renamed subject. Gah.

So please, find my feedback there -- most of that should still apply, 
scanning your changelog ...


> Changelog v1:
> - Changes from RFC [2], include support for handling fault_folio and using
>    trylock in the fault path
> - A new test case has been added to measure the throughput improvement
> - General refactoring of code to keep up with the changes in mm
> - New split folio callback when the entire split is complete/done. The
>    callback is used to know when the head order needs to be reset.
> 
> Testing:
> - Testing was done with ZONE_DEVICE private pages on an x86 VM
> - Throughput showed upto 5x improvement with THP migration, system to device
>    migration is slower due to the mirroring of data (see buffer->mirror)
> 
> 
> Balbir Singh (12):
>    mm/zone_device: support large zone device private folios
>    mm/migrate_device: flags for selecting device private THP pages
>    mm/thp: zone_device awareness in THP handling code
>    mm/migrate_device: THP migration of zone device pages
>    mm/memory/fault: add support for zone device THP fault handling
>    lib/test_hmm: test cases and support for zone device private THP
>    mm/memremap: add folio_split support
>    mm/thp: add split during migration support
>    lib/test_hmm: add test case for split pages
>    selftests/mm/hmm-tests: new tests for zone device THP migration
>    gpu/drm/nouveau: add THP migration support
>    selftests/mm/hmm-tests: new throughput tests including THP
> 
>   drivers/gpu/drm/nouveau/nouveau_dmem.c | 246 +++++++---
>   drivers/gpu/drm/nouveau/nouveau_svm.c  |   6 +-
>   drivers/gpu/drm/nouveau/nouveau_svm.h  |   3 +-
>   include/linux/huge_mm.h                |  18 +-
>   include/linux/memremap.h               |  29 +-
>   include/linux/migrate.h                |   2 +
>   include/linux/mm.h                     |   1 +
>   lib/test_hmm.c                         | 428 +++++++++++++----
>   lib/test_hmm_uapi.h                    |   3 +
>   mm/huge_memory.c                       | 261 ++++++++---
>   mm/memory.c                            |   6 +-
>   mm/memremap.c                          |  50 +-
>   mm/migrate.c                           |   2 +
>   mm/migrate_device.c                    | 488 +++++++++++++++++---
>   mm/page_alloc.c                        |   1 +
>   mm/page_vma_mapped.c                   |  10 +
>   mm/pgtable-generic.c                   |   6 +
>   mm/rmap.c                              |  19 +-
>   tools/testing/selftests/mm/hmm-tests.c | 607 ++++++++++++++++++++++++-
>   19 files changed, 1874 insertions(+), 312 deletions(-)
> 


-- 
Cheers,

David / dhildenb


