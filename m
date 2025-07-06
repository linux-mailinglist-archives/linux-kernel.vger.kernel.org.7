Return-Path: <linux-kernel+bounces-717524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DF3EAF9533
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jul 2025 16:15:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B69C4A0720
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jul 2025 14:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFA75130E58;
	Fri,  4 Jul 2025 14:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KPGp4YUx"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 716541B7F4
	for <linux-kernel@vger.kernel.org>; Fri,  4 Jul 2025 14:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751638537; cv=none; b=Me4sw2zN0vjeZMXRztuT88sozrtwWFj1uDu2kk2WbbG4ZpzuEEWpD7HyphiEPrESttllwd9QluAbI4cgOrLlRrCqJUG6Rk/7vNWohqIornTITqjpbi+Qj75nR+vTREpQ2buLgeRn1Z9iX09O9i4IlBFn05myEzH2aqr/NPMSmJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751638537; c=relaxed/simple;
	bh=irNBVMFL+eu4veuwB4jkQ2MKSYn0y5M8ZdcwNJK4p78=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T4QhJcDU8DXFpcma3/CGKumNnmFt/sCixNMVKNzlQdunASfVM3BlgZWxNx1N66g+w8jjX/YDTI4H+tGf4CW5e6dTVV7FgzXUDQ8hcizqiOu+mIOyiUk1s1xqQVq6hT9rYy0PyI5uNK6+mig/+gGY3HsiSGdo5JDvkjFoeO0AV0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KPGp4YUx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751638534;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=LBn7YewcGLqcJwIQMeePqXaU86WOWyp8TwMnIsNgXlU=;
	b=KPGp4YUxZmelhHhypD15KA0oQZBizbl5cQeKFnjf7wlt5xR224Yd+DVAmVSui82WrEVgOo
	RfzIon9F3s5Mu7yVH6c1wkxSdLJ7JRbjpxiXbHViwlBUmZWCCsbZTJttE+hAOd9tTdlDw9
	vdA26+vqjT+/EJfgW+GNVO+laWB8oiA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-3-V9ZTXphYM_SqkQzBgY0yVQ-1; Fri, 04 Jul 2025 10:15:33 -0400
X-MC-Unique: V9ZTXphYM_SqkQzBgY0yVQ-1
X-Mimecast-MFC-AGG-ID: V9ZTXphYM_SqkQzBgY0yVQ_1751638532
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3a503f28b09so560026f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jul 2025 07:15:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751638532; x=1752243332;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LBn7YewcGLqcJwIQMeePqXaU86WOWyp8TwMnIsNgXlU=;
        b=Aj64i1zt0d13dPPfYjS9g/AffFZTd7Un6R7rescfLH0ssUm4vw6RayfcEXcClkEJS1
         GldAn1DCZPAPt/ieJjNPi6ZtYQQPvLHk2s66hkFFCRra6SsRBpZlOOlXVTkKarNrtqEe
         /0fq7Sxi3kJg2RJGeVhGapJz66Tz8PL7P/ycfndFUl3txHHU/qW42KX3NvMn7C95HaXs
         83h7dit18ImmZgAg5kQhKntYW0OpPS5U0XGXCNDBG+ZozTUItB+ljkgRCZuOdFx0knY9
         bMD44f5pMtfIaUfY40BOb8awsWEEc4tszpeV5d+2hkIktYku+nDJheipFJMCgO34Ze5F
         1L4w==
X-Forwarded-Encrypted: i=1; AJvYcCXwa9GJFHoyEdn+FRNwUlfKZS6LAyud8nT7D78/J4bPicFkx7sYgoW9NxTWQAnMMRjoLZLmbNa0d3F9uhY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzIhbVpWchbXj4xcvdFDudJEfchtELwEjXw722vGrWkEwC/zIZ
	O4lqmhIaXL554hYibpjcHmb0kyCByG1KraDUnn1JknnIfIZG5czBOcfUMNrEpTBWHVautnZUUtM
	5wXa1hkmXVAmoBT8BWitRq1CbnAWJOoS/utln/GMTVBy2iX3GyjkzOqomxCUmnqM8rw==
X-Gm-Gg: ASbGncsmP0LZXoL7wz7IfAbnrIZggXHfxhixswp6Bc01H178WqqS/C+WfILzhkIN6pV
	hE0ITc9KEcS0huKagJLCouYDQyfgWwEVP4wAism0w1qsGHv1NzVHrcb0SXRGNohh+ahJw/DoEts
	CR1AAPfTXplCHLmDijx0VsDEkmYCi84MtK+h4masAL09bVJrQ+nuxKDbspjulVTVvYzmWdfk4TD
	y2MPm2XvCALSr2tmBvr9fh7AZ3E9ErofaMocH8fYfK50OdHnUULmdfBMibpPNxmTuC7f2FPOEt/
	+IU8AmQy2qLTE86qHKrh6k8ZN42np/9nFjEzjmjFNZLtuRoP0FxYQzdSyaynFEx++QIutI7QADK
	Pml86DP7wqGjn+9MialP9NlECKPALIXrpuYbtchGx4+MKJLs=
X-Received: by 2002:a05:6000:2386:b0:3a5:8977:e0fd with SMTP id ffacd0b85a97d-3b48f763f20mr3038216f8f.0.1751638531741;
        Fri, 04 Jul 2025 07:15:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFFFZfrZGXx1jIEHCw4iULGVHb/HshXOPXs2ODzOAd6Gc9BaMJ2C1ZIpAirKVHX6TqTgT60YQ==
X-Received: by 2002:a05:6000:2386:b0:3a5:8977:e0fd with SMTP id ffacd0b85a97d-3b48f763f20mr3038165f8f.0.1751638531220;
        Fri, 04 Jul 2025 07:15:31 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f2c:5500:988:23f9:faa0:7232? (p200300d82f2c5500098823f9faa07232.dip0.t-ipconnect.de. [2003:d8:2f2c:5500:988:23f9:faa0:7232])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454a9bcef22sm57156535e9.19.2025.07.04.07.15.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Jul 2025 07:15:30 -0700 (PDT)
Message-ID: <29cc7d2a-b174-4ed3-ae1a-22db478c62ec@redhat.com>
Date: Fri, 4 Jul 2025 16:15:28 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 6/6] KVM: arm64: Expose new KVM cap for cacheable
 PFNMAP
To: Jason Gunthorpe <jgg@nvidia.com>, ankita@nvidia.com
Cc: maz@kernel.org, oliver.upton@linux.dev, joey.gouly@arm.com,
 suzuki.poulose@arm.com, yuzenghui@huawei.com, catalin.marinas@arm.com,
 will@kernel.org, ryan.roberts@arm.com, shahuang@redhat.com,
 lpieralisi@kernel.org, ddutile@redhat.com, seanjc@google.com,
 aniketa@nvidia.com, cjia@nvidia.com, kwankhede@nvidia.com, kjaju@nvidia.com,
 targupta@nvidia.com, vsethi@nvidia.com, acurrid@nvidia.com,
 apopple@nvidia.com, jhubbard@nvidia.com, danw@nvidia.com, zhiw@nvidia.com,
 mochs@nvidia.com, udhoke@nvidia.com, dnigam@nvidia.com,
 alex.williamson@redhat.com, sebastianene@google.com, coltonlewis@google.com,
 kevin.tian@intel.com, yi.l.liu@intel.com, ardb@kernel.org,
 akpm@linux-foundation.org, gshan@redhat.com, linux-mm@kvack.org,
 tabba@google.com, qperret@google.com, kvmarm@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 maobibo@loongson.cn
References: <20250621042111.3992-1-ankita@nvidia.com>
 <20250621042111.3992-7-ankita@nvidia.com>
 <20250704134413.GE1410929@nvidia.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250704134413.GE1410929@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04.07.25 15:44, Jason Gunthorpe wrote:
> On Sat, Jun 21, 2025 at 04:21:11AM +0000, ankita@nvidia.com wrote:
>> From: Ankit Agrawal <ankita@nvidia.com>
>>
>> Introduce a new KVM capability to expose to the userspace whether
>> cacheable mapping of PFNMAP is supported.
>>
>> The ability to safely do the cacheable mapping of PFNMAP is contingent
>> on S2FWB and ARM64_HAS_CACHE_DIC. S2FWB allows KVM to avoid flushing
>> the D cache, ARM64_HAS_CACHE_DIC allows KVM to avoid flushing the icache
>> and turns icache_inval_pou() into a NOP. The cap would be false if
>> those requirements are missing and is checked by making use of
>> kvm_arch_supports_cacheable_pfnmap.
>>
>> This capability would allow userspace to discover the support.
>> It could for instance be used by userspace to prevent live-migration
>> across FWB and non-FWB hosts.
>>
>> CC: Catalin Marinas <catalin.marinas@arm.com>
>> CC: Jason Gunthorpe <jgg@nvidia.com>
>> CC: Oliver Upton <oliver.upton@linux.dev>
>> CC: David Hildenbrand <david@redhat.com>
>> Suggested-by: Marc Zyngier <maz@kernel.org>
>> Signed-off-by: Ankit Agrawal <ankita@nvidia.com>
>> ---
>>   Documentation/virt/kvm/api.rst | 13 ++++++++++++-
>>   arch/arm64/kvm/arm.c           |  7 +++++++
>>   include/uapi/linux/kvm.h       |  1 +
>>   3 files changed, 20 insertions(+), 1 deletion(-)
> 
> I don't know if any VMM will ever use this, but it looks OK

So, should we defer it to the point where we actually have a use case?

I mean, patch #4 could be simplified by modifying arm64 code in patch #5 
only. No need for a common kvm_arch function etc.

-- 
Cheers,

David / dhildenb


