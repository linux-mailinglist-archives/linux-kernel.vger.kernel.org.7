Return-Path: <linux-kernel+bounces-717518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D8ACDAF9524
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jul 2025 16:13:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F29041897D02
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jul 2025 14:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9BE018A6DF;
	Fri,  4 Jul 2025 14:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IWmmmWFd"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FCBC156677
	for <linux-kernel@vger.kernel.org>; Fri,  4 Jul 2025 14:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751638411; cv=none; b=boLkRforYy736qjL7pDuorgEkn8UineHzurfphOa3M1j2eGyriYxEwDDoM9PUPeAgo0q8+CTqINqXvnT9NgxPJjD1L77UlfwcSymTxeoQLN96++IGWydDv+eoM8nFYpDWGjN1vXrfEN6r/Ru1kmkYm3dk52svyPVyZgs5ysU+zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751638411; c=relaxed/simple;
	bh=k7p6T8UsDHqfedr8fzoAhZxpsqIZxWMrnLsbvt7yJ6s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bdNcySb2f1+y0ksImlOBxNMPcAibrN+GG76Uyna3ZeY36sQKhQ9Z4hdrbP6A4YyJPKw+YI5V28xurFlRDO5d4dR40fsDQja7nESHhCF3Xx1DeHnYInevwjwVyW6obpMp1xO2Sea9SrE9ZA2KRTbmBpumRPjOIwS7+truQ3fS9Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IWmmmWFd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751638408;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=66jwWf5WSWH6aoArMkkqiDugR24CPiwQ2W8r/VhkBtI=;
	b=IWmmmWFdBuzvocF3n4flFVzZdfla8HxSpnPqUYPO16LDLGpA1hOdoDdOF62e2lafxRivzz
	5uKlbuCzpcSCtvf26m+0e6bD4uqwGbXRIzfnpUdk6iDjG4pzLsrSkEEAYaSYrYVzJXzejN
	6yns3o7/E/VKfQAvvrJfV2XBrt+5OX8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-82-IlTrpnqUMEeWLVHrmP9e9g-1; Fri, 04 Jul 2025 10:13:27 -0400
X-MC-Unique: IlTrpnqUMEeWLVHrmP9e9g-1
X-Mimecast-MFC-AGG-ID: IlTrpnqUMEeWLVHrmP9e9g_1751638406
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4532514dee8so6643415e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jul 2025 07:13:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751638406; x=1752243206;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=66jwWf5WSWH6aoArMkkqiDugR24CPiwQ2W8r/VhkBtI=;
        b=tfNz46RtcN89k544W9DqPlqweeDhGa8/QzJjpTgSOEH/JBNq4rVzhg8u2iJdX6Nq/K
         TzVcN9MxtQRHwlHYeg3msF+uETA+YjFdZZQnTHT/QlDjwtPfWIWQT1EM4/hRsy1amxPR
         3r2lIbHr+MJUDVPCNn+Wp41rcem9H00TCeT/kTE2UbTXqQT9OQLKxT2mz3iB7N/X/A35
         eB5YfehgnDCRc4rKrqF4CUsZv5ZYYrlHVDdf6V7fkTo+LnV6ESwDLRv64x9OMbdW0zdD
         5kHxPvydQl84YunqQbfHqJyFXA7TYZbK8bsdmko7g3V6gWT9BfhHPpwrhoAGHrVlXhlk
         1ogg==
X-Forwarded-Encrypted: i=1; AJvYcCWCAPUTqq9mHVAql96nuvpLgYw97fBnAkqimiTmKBHlagcNIiMszh3/E9HyZIEUz6a2uCls4uzWY3EAp9w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHzTvbq62XBQxWw1RBB7au8B/u0Et1GJNRs2qxvkKLB0Zy2f0I
	SSekU7IUYGFcvQk5tHrX3LNz5n8U8NMCorTqnjn68eMP0A7btHKwZZwuTqSsaTmFyOSyxC7pYuM
	8vKl/rxjNiPozMzaIw3y/tRYSC0OsLHsCDm36cfgzJlQMBzewGWsJqlqKXM9mNLGtuQ==
X-Gm-Gg: ASbGncv5Hq3B1L+98ynPpnDbcVZ56B4OrGZg3H79omSTvS3TXQVXUZCr4j1V6SqlY4g
	rLFZMXqfXmFBR9x7HILRad1RL3hFVzZKYslk/mkkjoGOt31XXw+ynEaFp4fximpI3GgSdatCgaG
	uH0wks08oBmvtLv6rE7UDJuPDbzV+/+kQGm+6/vSS0IsgNzwWNJ9aNg/b+x60aTrBk4YF3/uwVQ
	PhEl4rAZCio/cbcNLlA746+mhlxbIZBk8naR9YI5YLFNuXmFN6922lk57JPpArxdSM8Of2GSkJL
	eU/lVMcaoncsB5FbNqRCWVQh7vmOWvjlW69lv3eEwi6XwBafnIZZt2D/FNb0hzrV24tonAT53Z+
	dbZK4X0cQAOmBhucGifAvdQ8jCkEbhi+43LYFGkyBXf0SO74=
X-Received: by 2002:a05:600c:c16c:b0:454:aec9:1db5 with SMTP id 5b1f17b1804b1-454b30df141mr31187185e9.16.1751638405715;
        Fri, 04 Jul 2025 07:13:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE3/ZP6YJd4U4iMxyo/3QGq6Le91Xz4xHpipCk15FkeiV8LSbzIkEeChr/ZjP5+m4GsKle6eQ==
X-Received: by 2002:a05:600c:c16c:b0:454:aec9:1db5 with SMTP id 5b1f17b1804b1-454b30df141mr31186425e9.16.1751638405241;
        Fri, 04 Jul 2025 07:13:25 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f2c:5500:988:23f9:faa0:7232? (p200300d82f2c5500098823f9faa07232.dip0.t-ipconnect.de. [2003:d8:2f2c:5500:988:23f9:faa0:7232])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454a1705ed5sm47240875e9.2.2025.07.04.07.13.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Jul 2025 07:13:24 -0700 (PDT)
Message-ID: <07e0fddd-76ba-4905-95f4-b98063215866@redhat.com>
Date: Fri, 4 Jul 2025 16:13:22 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 5/6] KVM: arm64: Allow cacheable stage 2 mapping using
 VMA flags
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
 <20250621042111.3992-6-ankita@nvidia.com>
 <20250704140431.GH1410929@nvidia.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250704140431.GH1410929@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04.07.25 16:04, Jason Gunthorpe wrote:
> On Sat, Jun 21, 2025 at 04:21:10AM +0000, ankita@nvidia.com wrote:
>> --- a/arch/arm64/kvm/mmu.c
>> +++ b/arch/arm64/kvm/mmu.c
>> @@ -1681,18 +1681,53 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
>>   	if (is_error_noslot_pfn(pfn))
>>   		return -EFAULT;
>>   
>> +	/*
>> +	 * Check if this is non-struct page memory PFN, and cannot support
>> +	 * CMOs. It could potentially be unsafe to access as cachable.
>> +	 */
>>   	if (vm_flags & (VM_PFNMAP | VM_MIXEDMAP) && !pfn_is_map_memory(pfn)) {
>>   		/*
>> -		 * If the page was identified as device early by looking at
>> -		 * the VMA flags, vma_pagesize is already representing the
>> -		 * largest quantity we can map.  If instead it was mapped
>> -		 * via __kvm_faultin_pfn(), vma_pagesize is set to PAGE_SIZE
>> -		 * and must not be upgraded.
>> -		 *
>> -		 * In both cases, we don't let transparent_hugepage_adjust()
>> -		 * change things at the last minute.
>> +		 * COW VM_PFNMAP is possible when doing a MAP_PRIVATE
>> +		 * /dev/mem mapping on systems that allow such mapping.
>> +		 * Reject such case.
>>   		 */
>> -		s2_force_noncacheable = true;
>> +		if (is_cow_mapping(vm_flags))
>> +			return -EINVAL;
> 
> I still would like an explanation why we need to block this.
> 
> COW PFNMAP is like MIXEDMAP, you end up with a VMA where there is a
> mixture of MMIO and normal pages. Arguably you are supposed to use
> vm_normal_page() not pfn_is_map_memory(), but that seems difficult for
> KVM.
> 
> Given we exclude the cachable case with the pfn_is_map_memory() we
> know this is the non-struct page memory already, so why do we need to
> block the COW?
> 
> I think the basic rule we are going for is that within the VMA the
> non-normal/special PTE have to follow the vma->vm_pgprot while the
> normal pages have to be cachable.
> 
> So if we find a normal page (ie pfn_is_map_memory()) then we know it
> is cachable and s2_force_noncacheable = false. Otherwise we use the
> vm_pgprot to decide if the special PTE is cachable.
> 
> David can you think of any reason to have this is_cow_mapping() test?

I think with that reasoning, it should be fine to drop it.

I think, the COW test made sense when we were talking about limiting it 
to VM_PFNMAP only and simplifying by dropping other checks. Then, it 
would have identified that something is certainly not "normal" memory.

-- 
Cheers,

David / dhildenb


