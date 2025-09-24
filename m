Return-Path: <linux-kernel+bounces-830362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D30F3B997A6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 12:46:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D87481B237DF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 10:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED74B2E041D;
	Wed, 24 Sep 2025 10:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bWV9XGoL"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B8226B098
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 10:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758710787; cv=none; b=rOHqaRZc9/Nd1GpTIByhl0CAWvWcjMUh66BZpMojLjEvYlWPHJvsv15VtCSJsQa7CS4dsznOmI4J59jNIHqVDUSmEsPiMmRwrlroTjPRz/IiQslcIP5ejsWg8iDTV2ms44ApLpl7yx98cPSh+De1EDS/eZ//V4B2JgIOqFziam8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758710787; c=relaxed/simple;
	bh=oHD8Qn5f+J6sXyazhMo8FObwWGHqKbWqqMu2oHiq4x8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XzrFTFszd17FzF1rvnO+GQtQF62IsWmHFzL+E44N3tgl9pFmV7vGF7RL1YNa3zxyA/RvE9JeUGSJQqHlqrk7fThakJzkkbN0znLH8A0ldm8de7x0OpVEzrX2DD1MXMCfItZSZO/pW3X3B6tkZVW/LowVFb7XPIAzFCwaRruDSiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bWV9XGoL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758710780;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=qgD8ucCUUYFMmg2u8cfnHO93saNGNzb3fowMQ2xbAZs=;
	b=bWV9XGoLA/8vUohZFpmmMaD4/WBcddCZ+rJDuJE0JLzqDGvYPiANk54XveHdfX+stqWfB1
	GNJlpuA0dEd29KLyT7DVuJhzUHcy/6w8MRKR1q0mxogZuBvZhLcvyxtT4/QgTh3D5/h1bh
	XHtLw59W71KbFe3oNySFxOCxblbUxjU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-8PnKMFqRPhqoyBqDBv_fwA-1; Wed, 24 Sep 2025 06:46:19 -0400
X-MC-Unique: 8PnKMFqRPhqoyBqDBv_fwA-1
X-Mimecast-MFC-AGG-ID: 8PnKMFqRPhqoyBqDBv_fwA_1758710778
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3ef21d77d2eso5286394f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 03:46:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758710778; x=1759315578;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qgD8ucCUUYFMmg2u8cfnHO93saNGNzb3fowMQ2xbAZs=;
        b=vM53hsg40jFGe/KhJ9qYleJF/pI0vKx40QW3zh2rg5FiRlcolyNLX4QVlO9ybJBWO/
         J6LJxdaVoBGATIWECmjHuiJ+g8JGY/wnIVLc3sV8Pr73Q5qytFkC/kisl6snuwXZfbGP
         WaoBIXD0F7/eE5epD23g+cEJth2fHZgj1s+oL4kX3kVO+loZUCgC5q00sMXEvmBhzYD3
         pYy66HbC3F6GeEMYszmfOrPRt+3DErYvjRlGx2NDEgdR5uD0dq/Ha9kKznpw89cOAh8e
         bbIuMy46NnYkHY5IhwIohrZM+SSkGF+Xl3TrXwy0AQzwNb4b+7qKvueoxQI0menfcID/
         TjdQ==
X-Gm-Message-State: AOJu0Yx0in/ow35IEqqceh+No2tXP0fiDq3DiqlkUsuHcrNSYwYZWQp2
	6btrUKL/zE/08dnyr9HA3qcEGo4Ic9PKMYNBPyRvdI/BmJZOoid2hcD33rKEoqMsFtaZusgG5uQ
	wemUzS8jKB7N/QHYP01+L4gbCUtkvmB4iZCR/8LSQOdCc2uEbBdXP900UaiouwdTmKA==
X-Gm-Gg: ASbGncuSK7wZO4YZOEbhsvsiJfcg4fnPZXHWDZGCdzOm4p73lT2WY91GcHqLrGfO6fY
	VIwyJ3A6G3V5Umbw71sSZhI0TyZOGlHakF4uA2UZYBDJINHERY3+zf52/pB9+2bQH7E/AH1qqla
	6aJ+PwnMSg6nDXx4welLksEfZu/gLV+4HEiG1xVOQV/Z0BjQ2OVh/2HDbj4XxnBLCFV7rDnGFHt
	DxgkITmVmDy40WI1kz6CbGE92eJvUBYOrrip7OsFV+O32fTseJb3/L5QJJzvsyedpimZojaapwn
	n3fGYXGAnY7qRLUmzZlkG14U3o/rdMzJTJcYzlXebGAPsOhTctCEgO/gftXsbJ142RMHtUO5Oe2
	8mjN2LP7Lv8FHD3h3q8wUcR6v/S3N65WvrJZSgh/40tGb43dz+p+vaSyoSbcb47yBjw==
X-Received: by 2002:a5d:40ce:0:b0:40d:86c9:5c9e with SMTP id ffacd0b85a97d-40d86c95d49mr287799f8f.40.1758710778092;
        Wed, 24 Sep 2025 03:46:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE1z5A9gGfOB4BPaBPx10lxb0eBipD/XjTy7i8GSxVaO2FgZTrlGe/MwQC8lJQLa3HUOJX0sQ==
X-Received: by 2002:a5d:40ce:0:b0:40d:86c9:5c9e with SMTP id ffacd0b85a97d-40d86c95d49mr287774f8f.40.1758710777676;
        Wed, 24 Sep 2025 03:46:17 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f14:2400:afc:9797:137c:a25b? (p200300d82f1424000afc9797137ca25b.dip0.t-ipconnect.de. [2003:d8:2f14:2400:afc:9797:137c:a25b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3f0e28c83d6sm22849574f8f.56.2025.09.24.03.46.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Sep 2025 03:46:17 -0700 (PDT)
Message-ID: <5844893c-66dc-4cfc-9a23-12bf24b55ee4@redhat.com>
Date: Wed, 24 Sep 2025 12:46:15 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v6 03/15] mm/rmap: extend rmap and migration support
 device-private entries
To: Balbir Singh <balbirs@nvidia.com>, Zi Yan <ziy@nvidia.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, damon@lists.linux.dev,
 dri-devel@lists.freedesktop.org, SeongJae Park <sj@kernel.org>,
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
References: <20250916122128.2098535-1-balbirs@nvidia.com>
 <20250916122128.2098535-4-balbirs@nvidia.com>
 <D4440A30-118E-40DF-99BD-6F58B708E597@nvidia.com>
 <1b896491-d9c0-4c8d-bc60-47579c773dce@nvidia.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <1b896491-d9c0-4c8d-bc60-47579c773dce@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


>>> +			if (!pmd_present(entry))
>>> +				continue;
>>> +			if (!pmd_dirty(entry) && !pmd_write(entry))
>>>   				continue;
>>>
>>>   			flush_cache_range(vma, address,
>>> @@ -2330,6 +2332,11 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
>>>   	while (page_vma_mapped_walk(&pvmw)) {
>>>   		/* PMD-mapped THP migration entry */
>>>   		if (!pvmw.pte) {
>>> +#ifdef CONFIG_ARCH_ENABLE_THP_MIGRATION
>>> +			unsigned long pfn;
>>> +			pmd_t pmdval;
>>> +#endif
>>> +
>>
>> This looks ugly. IIRC, we now can put variable definition in the middle.
>> Maybe for this case, these two can be moved to the below ifdef region.
>>
> 
> I can't find any examples of mixing declarations and could not find any clear
> guidance in the coding style

Rather not do it :)

__maybe_unsed might help avoiding the ifdef.

-- 
Cheers

David / dhildenb


