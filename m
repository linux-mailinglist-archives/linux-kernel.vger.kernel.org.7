Return-Path: <linux-kernel+bounces-832135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 03D2BB9E6CA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 11:38:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E8747A42A5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 09:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94F4B2EA485;
	Thu, 25 Sep 2025 09:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M3l3i22Q"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A0FF2E8B8F
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 09:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758793044; cv=none; b=EzX9rZCAztcv2L/XczKPCr0Pw4fZ5pjR3SklS1720kqGeJAqapE7MdOoxukl/VtPXggES0CaxU4pTPLHoPUcjYfcR5fBha1jiDoC+zgzqmUWUd2qnFddepyvum/FQ0mAyEb8ZXVJH7wHMT1qqmdJ8shvN7T7+6UK3Qd+zrOy0mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758793044; c=relaxed/simple;
	bh=RMkkUJImyJZZIGJ7Oyj1sNvmJyUF6Yw+gqvYZCTJLn0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T3KsMCmtqvEaGZNp2dNJLFeUYh81QS7P4dyGXIubVucL/kC7qSQzOuWjTarwlioULXxSXve/uOT/BTHg0H5RprB7Bot8AfSzxG/R5ZvxXlSsaYnJqMW9CKFyVSCaKJ/D8h1EyvTqOUYpW+icpZybu/ug6GvYcLbi8F9NdeUjEVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M3l3i22Q; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758793042;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=sZteDAWiG7VxkIsADkOw6B3yeLgEfE4eGqGu+VCIiwE=;
	b=M3l3i22Q2aphbDYg6SOFhqO6i24pQI1ySMW0xCjTuoddpL4LqGGwBEGekZqd55OgkbewCJ
	f5Efr6xReBPidmbX3pxJ+fdt9RMB25qNVPWTvVT0WIfmHx+KXn4kUX4yJ4h9DYFS03UIlh
	PhZ9YKC5HQB2CPLJNqTli5GY5z/G4Ko=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-451-58tsIeJ1PWq5ILJAkzrulA-1; Thu, 25 Sep 2025 05:37:20 -0400
X-MC-Unique: 58tsIeJ1PWq5ILJAkzrulA-1
X-Mimecast-MFC-AGG-ID: 58tsIeJ1PWq5ILJAkzrulA_1758793039
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3efa77de998so464283f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 02:37:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758793039; x=1759397839;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sZteDAWiG7VxkIsADkOw6B3yeLgEfE4eGqGu+VCIiwE=;
        b=J6M+S41IRyvig+qPJBiRVTDYpgJFJWDOJF1PQBNlvO8lKUkX5lg1ITC092AFTecDFt
         3feZ/uLjSe73rZzs7CBGixwMBxzONVaC7z39gmWbPtCyGbcVniCDJzLtODKDcDH1Kzah
         +nlT7E3dt3ze+kqoUDFiIfxbjTjnBDhTSAPx4zcpap91CKSkMurGOkl69Bwc0FAVz36c
         TUG+lf3MuAOfggbtD0MMucgoAfe1azblYzRusXxvO8N9hfE13/4YIgTSIBwaZSC9BLtY
         FblZjWxAzNa7wR9wlXXKlpWGi8W+TMOCdq3op8aZL5BUeSp5RyQNtq8m4a9bfBTILIAc
         p+mg==
X-Forwarded-Encrypted: i=1; AJvYcCXP+p6TXL94oZbP6ivVNNyEJ5KXToaiGONC7aEbUlAC2b2k+PNyINl0khbihzKDvhHNI596FE7JzPwMOy4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8xzfyw9dGXcwVQxb4pV91/RNlEgRWF6ZSZPfCfaccn5yj0SSg
	IhnSWucz1hg3RoInpHbnlnB4KJheD7YMvlU1QDGoTmCXFAkwX0uZRF2Qtjq6TExDyi9bLqFTRFs
	qlkMCZW8HxoDXJ84fhWqQmegooOwLbhSRff6dFggbKQYTOEtIeE4o2Z+DiGS7Ju90Jw==
X-Gm-Gg: ASbGnctI/F0sXIlHJ2KXzsuveWcuJrDasVVhB4vIFh1jX+fub7qts7mhKr1cYVfgnmw
	fm70Q+BL3VDba3J0/QDvMNyCyWteEue+ebKs8guoxnIx3+/gnl0HdZIx8lcfFIg0a6Ttl2zAVeJ
	tgq9pW83NRrHpUDmTGVhshr+k8zXfvwgd6Jdg/FKJjdk597wM5aOqw6aO54wGC02exoDyWsmVuY
	BJYIqVK7XFQkzMxBOnCExHwoS49vAZbq6kPfGZa7ZY+/oG9bfk3ORXQgHVMEycfBbTkoZXunx26
	OF4FL0LYw4ZXGeNCdVuHZ+HDrgU9TX5M6yktD9NAAWuwak7za9KsBrn1l+wqDZIsMrEJgJNgK6n
	ml6kObLskbzesjTJQMx1pDwKn4JS5ay8YYnvawh4km8OgjPxPZCUMNaLOcNHsly8fW525
X-Received: by 2002:a05:6000:3101:b0:3eb:df84:60f with SMTP id ffacd0b85a97d-40e4cc62f3fmr2681550f8f.48.1758793039374;
        Thu, 25 Sep 2025 02:37:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFA9Jm8uD5qp7JBwQIe1Kc6nNA+w35IPqMMEbFkiOgpMPy54NFOFR6LoswdfAvKNPYZ4HWLEA==
X-Received: by 2002:a05:6000:3101:b0:3eb:df84:60f with SMTP id ffacd0b85a97d-40e4cc62f3fmr2681517f8f.48.1758793038927;
        Thu, 25 Sep 2025 02:37:18 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f3f:f800:c101:5c9f:3bc9:3d08? (p200300d82f3ff800c1015c9f3bc93d08.dip0.t-ipconnect.de. [2003:d8:2f3f:f800:c101:5c9f:3bc9:3d08])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fc5602efdsm2323755f8f.34.2025.09.25.02.37.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Sep 2025 02:37:18 -0700 (PDT)
Message-ID: <95080e61-7009-4e5c-86aa-25ab7356f840@redhat.com>
Date: Thu, 25 Sep 2025 11:37:16 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drivers/base/node: merge register_one_node() and
 register_node() to a single function.
To: Mike Rapoport <rppt@kernel.org>
Cc: Donet Tom <donettom@linux.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>, Oscar Salvador
 <osalvador@suse.de>, Ritesh Harjani <ritesh.list@gmail.com>,
 Aboorva Devarajan <aboorvad@linux.ibm.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Madhavan Srinivasan <maddy@linux.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Danilo Krummrich <dakr@kernel.org>, Dave Jiang <dave.jiang@intel.com>
References: <cover.1758736423.git.donettom@linux.ibm.com>
 <40257b5228dec05e5b252f02438608eb8d681a2d.1758736423.git.donettom@linux.ibm.com>
 <0de65980-4333-434a-ae7d-2b7be46c2cca@redhat.com>
 <aNUMnK23qKTjgEdO@kernel.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <aNUMnK23qKTjgEdO@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 25.09.25 11:34, Mike Rapoport wrote:
> On Thu, Sep 25, 2025 at 10:54:07AM +0200, David Hildenbrand wrote:
>> On 24.09.25 20:40, Donet Tom wrote:
>>> register_one_node() and register_node() are small functions.
>>> This patch merges them into a single function named register_node()
>>> to improve code readability.
>>>
>>> No functional changes are introduced.
>>>
>>> Signed-off-by: Donet Tom <donettom@linux.ibm.com>
>>> ---
>>
>> [...]
>>
>>>    /**
>>>     * unregister_node - unregister a node device
>>>     * @node: node going away
>>> @@ -869,7 +842,13 @@ void register_memory_blocks_under_node_hotplug(int nid, unsigned long start_pfn,
>>>    }
>>>    #endif /* CONFIG_MEMORY_HOTPLUG */
>>> -int register_one_node(int nid)
>>> +/*
>>
>> We can directly convert this to proper kernel doc by using /**
>>
>>> + * register_node - Setup a sysfs device for a node.
>>> + * @nid - Node number to use when creating the device.
>>> + *
>>> + * Initialize and register the node device.
>>
>> and briefly describing what the return value means
>>
>> "Returns 0 on success, ..."
> 
> For kernel-doc it should be
> 
> Return: 0 on success, ...

Yeah; I recall that kerneldoc does not complain when using "Returns 
...", but probably it will not be indicated accordingly.

-- 
Cheers

David / dhildenb


