Return-Path: <linux-kernel+bounces-733845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2B88B079C0
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 17:26:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8054F3B3976
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 15:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB6D22F1987;
	Wed, 16 Jul 2025 15:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T8jFtMlj"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4F5230BD2
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 15:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752679464; cv=none; b=Jgx5HVMxM8j0u6A+u6bjuErZcnKI3oiN68V4P4NLpOSbLw9KLOxM+/vwG+cTbYPEbaM2mIXvkyKEyX8nT2vsKBv2qmTBqley981oBeMcv4N6bPpwx5Wm8UPGv0uuFNr7qwGMVHIvBE84Yaf0TgNiZSdRouy29nHgXpMzVekMdzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752679464; c=relaxed/simple;
	bh=DSlA9dD8ZHLAS7jGHsLfZpClyYfaGsrYQtqA4+tdm4Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZdCr5Q2dMDHDCCWq9mFOx4G7cBj7G0kaEBTS3G55NRlpTQlQVUvkDZO0hgG12Abw5YvaLhbJ2vXUjlJfs139jb/tLOv5G5JV5RsSKwGkQrZB4/yZJTFw5xAqrK/FMG+vo/3wPE6fLxVluy02M4iWTEg00iaNhmswgUK7srQEJ+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T8jFtMlj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752679461;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=SNFlWBNpt9SYbkpdkC3AxTClHyrZUSfwmCSW8R0rlhI=;
	b=T8jFtMlj0ndhFitistB6zgL5ci8LHXjlRuIdHxevm6gDmV9Td+/V1QBBmx+7bJ3Ek1tIF7
	a36fjWFzBK5eUvnNII7/JaiaxKeOk7uw4tp1qV1sf3iXGz1PCXWti5wDVpxBB/dExSYT5v
	BKYO37uEDoF792EUc1m+/OGRnt3sjCw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-142-xeu0YGDMPRWUxOFxKlvPdA-1; Wed, 16 Jul 2025 11:24:19 -0400
X-MC-Unique: xeu0YGDMPRWUxOFxKlvPdA-1
X-Mimecast-MFC-AGG-ID: xeu0YGDMPRWUxOFxKlvPdA_1752679459
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4560b81ff9eso27826665e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 08:24:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752679458; x=1753284258;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SNFlWBNpt9SYbkpdkC3AxTClHyrZUSfwmCSW8R0rlhI=;
        b=ASrevdJDofJO7boVlJrKdox2dEh3L1ECAsZ7xrB8x85ktkymEy1Et22KFOmBM06lVG
         QBb/Crpz3xsLdNgcE9Zu4JuNELiYGozP65bF7XdZ7WnxDl33rEJMbxHCb4lr0HGODjLS
         OTJZSifLcjECHZOu654VY12CsFHynrotMU8ChVwtuFxYflT2Dej7njf4wewj0U128ZxO
         WdFzp+uXCtLjOV4g+KyVpaFhs0MERm019IWHh0merXNF3Qlr40wJRfM/hSw9Ya4MEy7F
         mFe5eBvNGWtbvDK0Ya/30YJdqXLKovSv3mQx5W9p1rvv0sHwASTRLbolnDzC/69kTEOk
         HM7A==
X-Forwarded-Encrypted: i=1; AJvYcCXK5JYTgHjXZdplJ25ukLqupn97wyYntEHQ6opR66l+NM1tqWk52/VMtoOCH5mom06MjwwOSqaeY14IlAw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx98h0McpiDE3UHSFz4pAkgvTWHkgsVvXnrg1fL1rluQmUwdq77
	QS1vHvVq4YvtQeh6wZxMDJNo+u+LqA2/SQXhIrXO04RVfKvfE/l88pnIVnQW/zMoK/4KM58Bmqf
	tq6OdUinql9hRksZJ1zUUdKoGwfzU6hFWRtA5aByqanux5DslKckmOh5wCMWjJxhxtw==
X-Gm-Gg: ASbGncvIIJRdMhup8U21Nv+EDrw+zdKkzwtOLWbgvtR3d/eVm371Dzl0MzXbrlYaeyf
	HlOaU9DNSLdQXcexh6uJxJb6NKK6zktqUG/RVjiOG0ola+eOs6/1+W1CNH78jJAUPbAHo7XObgI
	W+2wWLUtldN6wP+Kmzj4AbzfDI03i6lVq4ZRO335kIN4+B2Xu2Jq5ls3YNqMkKvnDdUEGJuDQEG
	owPe13vmDergIQmqxbzFNJG2Vx6UmVqDLfT6I9ey5kvpYHgZmpDOiEHtwC7mk4/8UiZGlPMHdwF
	ecyWb0LParBOPQspb6thyslo36IJfFzk2l7OJLtDR03ZTeldv0K3rMyScoC+Zal8glSVYireR5a
	tus/s3Iyt7hHWclHBX79pobqiOUzP6ZESnClEp5f0jZZTNeqQ1G64lnUK4GhDTXjlNjg=
X-Received: by 2002:a05:600c:1987:b0:456:12ad:ec30 with SMTP id 5b1f17b1804b1-4562dfe73c0mr37112665e9.13.1752679458466;
        Wed, 16 Jul 2025 08:24:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFxuqbrkcZx4M5Xzniv4108zBNJL/oqX3SoCcALdEHsTatmbIhhC93lstqiOhvQonpy37IcTg==
X-Received: by 2002:a05:600c:1987:b0:456:12ad:ec30 with SMTP id 5b1f17b1804b1-4562dfe73c0mr37112315e9.13.1752679458022;
        Wed, 16 Jul 2025 08:24:18 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f1d:ed00:1769:dd7c:7208:eb33? (p200300d82f1ded001769dd7c7208eb33.dip0.t-ipconnect.de. [2003:d8:2f1d:ed00:1769:dd7c:7208:eb33])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8dc22a8sm18558624f8f.34.2025.07.16.08.24.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jul 2025 08:24:17 -0700 (PDT)
Message-ID: <da5aea8a-bae5-4cd5-83a1-94cfcb61a29f@redhat.com>
Date: Wed, 16 Jul 2025 17:24:15 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] mm: move huge_zero_page declaration from huge_mm.h
 to mm.h
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Suren Baghdasaryan <surenb@google.com>,
 Ryan Roberts <ryan.roberts@arm.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Borislav Petkov <bp@alien8.de>,
 Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>,
 Vlastimil Babka <vbabka@suse.cz>, Zi Yan <ziy@nvidia.com>,
 Mike Rapoport <rppt@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>,
 Michal Hocko <mhocko@suse.com>, Andrew Morton <akpm@linux-foundation.org>,
 Thomas Gleixner <tglx@linutronix.de>, Nico Pache <npache@redhat.com>,
 Dev Jain <dev.jain@arm.com>, "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
 willy@infradead.org, linux-mm@kvack.org, x86@kernel.org,
 linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 "Darrick J . Wong" <djwong@kernel.org>, mcgrof@kernel.org,
 gost.dev@samsung.com, hch@lst.de, Pankaj Raghav <p.raghav@samsung.com>
References: <20250707142319.319642-1-kernel@pankajraghav.com>
 <20250707142319.319642-2-kernel@pankajraghav.com>
 <a0233f30-b04d-461e-a662-b6f20dca02c5@lucifer.local>
 <hi7i4k7gbbd27mtjyucwxjgwhjq7z4wtzm2nd6fqfnd5m7yo52@k7vwf576a44x>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <hi7i4k7gbbd27mtjyucwxjgwhjq7z4wtzm2nd6fqfnd5m7yo52@k7vwf576a44x>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16.07.25 09:47, Pankaj Raghav (Samsung) wrote:
> On Tue, Jul 15, 2025 at 03:08:40PM +0100, Lorenzo Stoakes wrote:
>> On Mon, Jul 07, 2025 at 04:23:15PM +0200, Pankaj Raghav (Samsung) wrote:
>>> From: Pankaj Raghav <p.raghav@samsung.com>
>>>
>>> Move the declaration associated with huge_zero_page from huge_mm.h to
>>> mm.h. This patch is in preparation for adding static PMD zero page as we
>>> will be reusing some of the huge_zero_page infrastructure.
>>
>> Hmm this is really iffy.
>>
>> The whole purpose of huge_mm.h is to handle huge page stuff, and now you're
>> moving it to a general header... not a fan of this - now we have _some_
>> huge stuff in mm.h and some stuff here.
>>
>> Yes this might be something we screwed up already, but that's not a recent
>> to perpetuate mistakes.
>>
>> Surely you don't _need_ to do this and this is a question of fixing up
>> header includes right?
>>
>> Or is them some horrible cyclical header issue here?
>>
>> Also your commit message doesn't give any reason as to why you _need_ to do
>> this also. For something like this where you're doing something that at
>> face value seems to contradict the purpose of these headers, you need to
>> explain why.
>>
> 
> In one of the earlier versions, David asked me to experiment by moving some of these
> declarations to mm.h and see how it looks. Mainly because, as you
> guessed it later, we can use it without THP being enabled.

I assume, in the future, most setups we care about (-> performance) will 
have THP compiled in. So likely we can defer moving it until it's really 
required.

-- 
Cheers,

David / dhildenb


