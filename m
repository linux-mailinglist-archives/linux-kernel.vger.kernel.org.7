Return-Path: <linux-kernel+bounces-816338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C97FB57295
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 10:10:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A87231895C6B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 08:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B3E32EAB70;
	Mon, 15 Sep 2025 08:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N28QLdbe"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F3C52EA461
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 08:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757923845; cv=none; b=WlPnRpvSWbpWxFj71cAlTJ/pXQYfSNnW1A1o6yd7NeIHKGXTwAmJK9M9sIZqh2Xbox8KXFuavR97/VDGvLJUTEcF9XULnBfBgR+paOxOr6ygbjzDgdJIQT65dL9tXEgafw3G2Ffr2CpsHjx3XlzDLrTP1ixL3X2kAgA2B9scusU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757923845; c=relaxed/simple;
	bh=NWZASkeslEz1QOo6cAdvewIpf2QICve7vT6dQFoaVqc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FnnpdoAqdHO0NBR5flh/SCX1WMeKbSO4mK3fM6DzpD+oDRAdERRhU4/VMD/8XcC8bX5geiFm7lJ1XmUCkSmgFnR8NcjrzXKgs/Uj6JRf2OnNeuGQ3xex6g526oqeqT2qOufQ/1dvad+WUiaGgiUFdAD8ucjKY6kcf0SRgb+PbGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N28QLdbe; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757923842;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=KhuFMOmEPvdK2NhBlkWJP8nYDemufCbzLTzEFla3lLY=;
	b=N28QLdbe7w8UzE0MDf/ngYr00LX8kd04yMx4o6RJeXsYBy2iLycKXcOPw00FY4CJhJATJZ
	FH/Ua6P1XBJ/9nUqevRXy/e4KUo4hsCshrUvRnp+B7G8Hcgzn7+L85z25NPFgXp90SLDiX
	y73t5PbVJJ4XPrXa29NnW4hhOSatAiM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-450-suzI2T4pNIWc3IYvMPTgww-1; Mon, 15 Sep 2025 04:10:41 -0400
X-MC-Unique: suzI2T4pNIWc3IYvMPTgww-1
X-Mimecast-MFC-AGG-ID: suzI2T4pNIWc3IYvMPTgww_1757923840
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3dabec38299so2168505f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 01:10:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757923840; x=1758528640;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KhuFMOmEPvdK2NhBlkWJP8nYDemufCbzLTzEFla3lLY=;
        b=EkZ6ZDBesaB61dBmCgEOC4c25bzUIWf9cp9uokI01DLKQtzxv1uj5teIlcvclI6Ydk
         B6uU795jW+tI/LKUPuSqpybyIORlBrI5evlMhOUF63k/SWaDUyJXgeeKk9f9Z+Xy+h2K
         NhNFj6HjwRIjY/YsTywtUh7L8lGrQjA1Kuh4a38L9L/2h3JKX1rT1ADvZL6E7eVRtDfS
         hzPU+SABZyTf9sRdlcxCtyeTHLNS3l+yK7zH9LhyrTR0oiLlG01RIMHTZcz7ER4PPvf4
         fptYlKe5L0jzkYximhEX7Z1uDjc9tiZ7OM12yY5TmPprI6U21y2oZUCi3zP+3ZSA0zWh
         IRnw==
X-Forwarded-Encrypted: i=1; AJvYcCXWUetcvVi/oVp7dZESsDJwpqO4dzqo+BMZunTlClQQZrO0Eewyi6+kVQxRJ6bdZhQ6FZ70oPofw31Qg9Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyS/jqzRGVc7kmVD1N4CLy0zl30pz/f21tl4i01teAPBZSNI8yN
	ZXOvMbyP/x6XDK5L+Lu36vKVYOLonYRFLyQ0prZ3BlthzpCuJOLUOP0OwZiKbDJL+rLrVPfPADr
	0gM3mH0ePPbH1Npnmlq2w3uy7Bi/FEuY9bnspg1XCvDlLuVx53zMbaI1wUuwmO2Dqmkp2upquoQ
	==
X-Gm-Gg: ASbGncv+t5Ur5ecvCGivZkUgwpqpBB6dYC4MO+q0iOHMI+0H4KfDsdUCutwZ1bJucAb
	r77xHcJ95/ojI8MER7Ajbw+Fp1vGEse9XfAzr7GB5nLAtc2lBTCsrHSejbdNBjbk9E8rzxDawsc
	7+dxqRVFOdOTIP+UUm5PhUcAJohhR18fqS8G5R4EpK03zCKcx6UAbYiQDZ2dXMFJqLTpRvyR075
	uBKFK5fIC/WwuckMsvWcXcRhQXRHuNdKVuLHv0So1wsr5H3mZ0aeA5z6S8oEHemgxRA/PFtgo/q
	+TWeCsutwRlgCtw/CP4rNb6tocNEjfVQU0nkinlVc94NlMTA4XKwpOo5BUWRuxheOb3t9/ojFyE
	AZ68D5s0iFTOFYG1vPWrDzcQb8qjnFlbcj6G39xSnV4etwfzpBpkpLxvHJRpk4FsQq9Q=
X-Received: by 2002:a05:6000:4201:b0:3df:d8ea:1f7b with SMTP id ffacd0b85a97d-3e765a1a390mr9676799f8f.51.1757923839616;
        Mon, 15 Sep 2025 01:10:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGp6oIXo1DUhThKGGzGXbobDlfNMu7CwZvQ1iFxxb8VHtiveWuBMx+EZLBiC4LIDIMu8y5MYw==
X-Received: by 2002:a05:6000:4201:b0:3df:d8ea:1f7b with SMTP id ffacd0b85a97d-3e765a1a390mr9676762f8f.51.1757923839149;
        Mon, 15 Sep 2025 01:10:39 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f18:f900:e0ae:65d5:8bf8:8cfd? (p200300d82f18f900e0ae65d58bf88cfd.dip0.t-ipconnect.de. [2003:d8:2f18:f900:e0ae:65d5:8bf8:8cfd])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3eb9a95d225sm868315f8f.54.2025.09.15.01.10.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Sep 2025 01:10:38 -0700 (PDT)
Message-ID: <4de00290-7c29-42f5-b8aa-58a77b17c1d5@redhat.com>
Date: Mon, 15 Sep 2025 10:10:37 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v5 02/15] mm/huge_memory: add device-private THP support to PMD
 operations
To: Balbir Singh <balbirs@nvidia.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
Cc: damon@lists.linux.dev, dri-devel@lists.freedesktop.org,
 Andrew Morton <akpm@linux-foundation.org>, Zi Yan <ziy@nvidia.com>,
 Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
 Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>,
 Ying Huang <ying.huang@linux.alibaba.com>,
 Alistair Popple <apopple@nvidia.com>, Oscar Salvador <osalvador@suse.de>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Lyude Paul <lyude@redhat.com>,
 Danilo Krummrich <dakr@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Ralph Campbell <rcampbell@nvidia.com>,
 =?UTF-8?Q?Mika_Penttil=C3=A4?= <mpenttil@redhat.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Francois Dugast <francois.dugast@intel.com>
References: <20250908000448.180088-1-balbirs@nvidia.com>
 <20250908000448.180088-3-balbirs@nvidia.com>
 <17e3c19e-0719-4643-8db8-cf8c5b5aa022@redhat.com>
 <49776f0a-d891-40be-bce3-c2b1f16bd825@nvidia.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <49776f0a-d891-40be-bce3-c2b1f16bd825@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

>>> +
>>
>> Wrong indentation.
> 
> checkpatch.pl did not complain, what I see is
> 
> +		VM_WARN_ON(!is_pmd_migration_entry(pmd) &&
> +				!is_pmd_device_private_entry(pmd));
> 

David complains :)

> It looks different in your reply (is your email converting tabs to space?
> did you want me to align the conditions?

Indeed, looks wrong, not sure why. Likely I messed it up.

> 
> +		VM_WARN_ON(!is_pmd_migration_entry(pmd) &&
> +			   !is_pmd_device_private_entry(pmd));
> 
> 

Exactly.

> 
>>
>>> +        if (is_migration_entry(entry) &&
>>> +            !is_readable_migration_entry(entry)) {
>>
>> Dito.
>>
> 
> Same as above :)
> 
> 
>> Wonder if we want to be more explicit.
>>
>> if (is_readable_migration_entry(enrty) ||
>>      is_readable_exclusive_migration_entry)) {
>>
> 
> !is_readable_migration_entry => writable entry or read exclusive, did you mean is_writable_migration_entry()
> above?

Yes, sorry, my brain was dizzy after all the review lately.

if (is_writable_migration_entry(enrty) ||
     is_readable_exclusive_migration_entry))

[...]

>>
>> Couldn't we do here
>>
>> if (!pmd_present(pmdval))
>>      goto nomap;
>>
>> To replace the original pmd_none() .. check.
>>
>> A page table must always be present IIRC.
>>
> 
> I am not sure about the pmd_none(), a page table may not be present, I've not audited
> the callers. But I think we can do

IIRC page tables must always have the present bit set. So we can just 
simplify to the single pmd_present() check.

-- 
Cheers

David / dhildenb


