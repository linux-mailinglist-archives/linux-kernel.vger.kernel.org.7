Return-Path: <linux-kernel+bounces-800385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C14E7B43716
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 11:28:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62B181C281EE
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 09:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B82A2F60B2;
	Thu,  4 Sep 2025 09:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JiNys9ep"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9232D2F549A
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 09:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756978111; cv=none; b=dGMMe/HAks4LTuooRsGpWTRfmPlUh/6MuVuEAzxy+mk4HbpjEMLW4Usa8f2YW6wWG0ADbHRcSjg7zm9coMqH+JdM2YKrzdHj2rtTSA2dOQIMxxaIT+uGL/h8G9tmBkEDAwsSQDaJf48MYa1sHppP4Fru8o280Ah6yp5iXmnaD2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756978111; c=relaxed/simple;
	bh=RjQ15hYpYJFqtL0XN7PebA4MBoAWIMYdscOdhdKr1oU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=myFETy09AiG+X1iK2wSCXEbN/ePTanFrg06jbiyTYh/wrvEaVGoPO0w1Jkw1IE2w1szYJNK6RiXcQKA5erGbSzlb1fkZ7pDCmwQlvw+TXXRwYqqeaFnTpejMBBtMRwQByFEVXLwZpd+ut56ReemSmbJR1njpaFWGxEB4RUbZvQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JiNys9ep; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756978107;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=rqtVp+dWESwWsztacKgmL2rUMUmFFYmojnDpgO2tdkE=;
	b=JiNys9epNiYevvMizoilLaFkqjQ6IX3y1POh7NDCAdP+AbTF4eEMBVCvPNybnyJt7AaMLL
	+3PioFHOfVW2dhWw8N7uE7d68sMLFj2iz1/As54yoDYsHILfSai7N+54OIJCh20x+UyUQD
	b8+Y9UPHdEro5adnuu2DFSgXCqqVUJU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-98-DGNutcATMC-rGCv9BcTQJw-1; Thu, 04 Sep 2025 05:28:25 -0400
X-MC-Unique: DGNutcATMC-rGCv9BcTQJw-1
X-Mimecast-MFC-AGG-ID: DGNutcATMC-rGCv9BcTQJw_1756978105
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3db4cfcc23eso396026f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 02:28:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756978104; x=1757582904;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rqtVp+dWESwWsztacKgmL2rUMUmFFYmojnDpgO2tdkE=;
        b=LWDV/a+axMkTtEA+9Zkv8QKuhM2843oaMaSeeGGeiCaZTQkhXQCeqj/kruZgW0UA10
         rFGgJJDdD1XOrPWNnZ1JtRNQqm1jvHErASj7c4DQ7yRmJ8nHLJ4dmnghWPLN4Xm3ocUY
         Xlt90VSx9YtpQ6NEkb6uUCAEcoaBgKqbL2S0GdRDoLqduqmCT02/4HKP2/Npj9TX8pAd
         1ZyXWHAPSIeQDmIaxw8rX8WlBF33ByB0kMpeAIs3FRZMsnY0kw47HjcuPmr0/VIVQpWJ
         Z+EEEHsrRo84KTIxOPXy1eQ8r+U0Cg7jY/A1SlPVgHLR3TGoeRH9rQ0XEJaLimQzQluS
         Q6ig==
X-Forwarded-Encrypted: i=1; AJvYcCXOhsS5wcZvpI4fVkk27bDi2zILaWLhf91tw3EORCVUO3WHmnNklQpKpNKBJgPdnuBU/yXuKBeTZrUgpkc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxiiaosAI3ZJD7UFBg3hOnPmbP99R2lrT8oa21W8NFcrvgEIo6
	af8g9dyQPilCtlNQ30uN6xJQRT7vOhyuReWoeDxfbf6HZbOKMLBpg7kMD9LEEyGcf9mOL1OKsEr
	Gby9BlmsKm9Br6i2QuHAiRhnM82aeyoofBw7q6vxw6T7CjI5tScIRHCkKYndiR71EVg==
X-Gm-Gg: ASbGnctcL+ndIYyhgnGSjEQfV3ySePGBE4TNJYMYptUcvxBJLszfkrV9xbTA97nRPbq
	rTbpRK80/KF8Qug3S7rZmcemsWN8iUjDhIfWh+xBw4m/BTtMRTBtVzs3hhwwktAeDOO+gm6bekC
	15bBJdyangt1CIm7iyvhj7M8DbVYyN74koHqxcs/ITjX9oR2L+9faw0SxblOwh1ZCnsyWgZ9s5h
	QM/3pA0H2+VNf8oSq19lWeRPm6FO+Rylzz2HCuNqx7gQr3ThscnIkmJWSzEzmgqQrYwgROHQjmC
	h3V373e3Nv5B4L+KaWKrnOROtET78GyZ/XO8eB6+HqxQjxKFBIJp/6jtOHo6e7zHLu/+zZ3YswO
	YLLUWA89XbfD2jdJCjwXJy5xprU8YNKH45hJWBpfZsXkU3m5dp7MTdV3hrXcFXxbZ
X-Received: by 2002:a05:6000:178f:b0:3d6:fe34:1178 with SMTP id ffacd0b85a97d-3d6fe3416c6mr10383636f8f.27.1756978104553;
        Thu, 04 Sep 2025 02:28:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHPjjpCqdHOizCp1x9jFe7gjDg5+srRLP3tm8qElUsk9XFS3CXOS6UY0v+F/eqM7CoYz+ymVQ==
X-Received: by 2002:a05:6000:178f:b0:3d6:fe34:1178 with SMTP id ffacd0b85a97d-3d6fe3416c6mr10383620f8f.27.1756978104124;
        Thu, 04 Sep 2025 02:28:24 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f25:1e00:ce4c:be3:97b3:6587? (p200300d82f251e00ce4c0be397b36587.dip0.t-ipconnect.de. [2003:d8:2f25:1e00:ce4c:be3:97b3:6587])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3df4fd372ccsm4936283f8f.32.2025.09.04.02.28.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Sep 2025 02:28:23 -0700 (PDT)
Message-ID: <21b8a9a7-b737-4ed6-9690-dfe07ee233b5@redhat.com>
Date: Thu, 4 Sep 2025 11:28:22 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/9] mm, swap: use the swap table for the swap cache and
 switch API
To: Kairui Song <ryncsn@gmail.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 Matthew Wilcox <willy@infradead.org>, Hugh Dickins <hughd@google.com>,
 Chris Li <chrisl@kernel.org>, Barry Song <baohua@kernel.org>,
 Baoquan He <bhe@redhat.com>, Nhat Pham <nphamcs@gmail.com>,
 Kemeng Shi <shikemeng@huaweicloud.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Ying Huang <ying.huang@linux.alibaba.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Yosry Ahmed <yosryahmed@google.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Zi Yan <ziy@nvidia.com>,
 linux-kernel@vger.kernel.org
References: <20250822192023.13477-1-ryncsn@gmail.com>
 <20250822192023.13477-7-ryncsn@gmail.com>
 <c492b99e-b6fb-4da8-8055-1e93c6141a12@redhat.com>
 <CAMgjq7DAbMMmPVPqiGg_-2vghpPc9Jn8rkVNDFgq3reFx6CZtw@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <CAMgjq7DAbMMmPVPqiGg_-2vghpPc9Jn8rkVNDFgq3reFx6CZtw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

>>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>>> index 2a47cd3bb649..209580d395a1 100644
>>> --- a/mm/huge_memory.c
>>> +++ b/mm/huge_memory.c
>>> @@ -3721,7 +3721,7 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
>>>        /* Prevent deferred_split_scan() touching ->_refcount */
>>>        spin_lock(&ds_queue->split_queue_lock);
>>>        if (folio_ref_freeze(folio, 1 + extra_pins)) {
>>> -             struct address_space *swap_cache = NULL;
>>> +             struct swap_cluster_info *swp_ci = NULL;
>>
>> I'm wondering if we could also perform this change upfront, so we can ...
> 
> This one seems not very doable on itsown since the cluster idea wasn't
> used out side of swap before this patch..

I think there might be a way, but it's not that trivial. Anyhow, long 
story short, try to move as much as you that logically makes sense can 
out of this patch.

-- 
Cheers

David / dhildenb


