Return-Path: <linux-kernel+bounces-730232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 414FFB04198
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 16:27:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 559731883F46
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 14:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0911722129F;
	Mon, 14 Jul 2025 14:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CsH3tKJm"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C677D253F2C
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 14:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752503257; cv=none; b=VYugsXfU7pJ0x7p4k7mozyzasz7T0MNj5sLxdqSd+Z6AeVaPlnyjAVs9lNzdhVXuit0mAJeSFmke8wWPfEiYQyj45GkXyWGpD5/w4+9f8pj/RiQswodHbAstjKO3RhBBVVGPIitKeIbsO5KFlnanmL7lEOGiqsU14pLqM+6U1p4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752503257; c=relaxed/simple;
	bh=j3j6khhnyLx9G2d2/JI/0pOgLNpWKTbF2jxJdS7pW+E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GeGzCz2GxJjxBi4vKQEvAH3Is8NMOlQb3V20MMF6b77g/b6WDS3Ug43HeLtRvMJCYvmCSZ0nvbJ62O+IxHf9yd0ja9W0TpHsQsc4M4eCERO/Fy6D5lBaISR4taCnwFQied0HnDGvVtrtYaevgGIqkxmgdTcCtNk1b2l5vIbVcjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CsH3tKJm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752503254;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=SLif49jv+ZvfHqLndwovPsHsTBrasj5ntlXYHSvszjo=;
	b=CsH3tKJm2EL6rAlkYKtz3CrjvYtH/i3nmodSDXpz/j6uALDAYoH3fpz/+jCaAIeS5A7YAh
	aWc+vit4Bj2GvXS0WT07vOtvZNWQyY2OhgO+c2XbW4b2PmrhdpD+tgQxAwemK9wN3/nNHv
	Kq2pyQepcQgsW8OyAMxZgWM7VgFTE84=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-04YY-ESUNFGCX6AVK3zVpw-1; Mon, 14 Jul 2025 10:27:33 -0400
X-MC-Unique: 04YY-ESUNFGCX6AVK3zVpw-1
X-Mimecast-MFC-AGG-ID: 04YY-ESUNFGCX6AVK3zVpw_1752503252
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3a523ce0bb2so2183354f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 07:27:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752503252; x=1753108052;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SLif49jv+ZvfHqLndwovPsHsTBrasj5ntlXYHSvszjo=;
        b=uiE3kKVxHtwcm0WtHgSDwV7hAFZQhlG1Y38c3YoRLLpyMAK4DhTg6fd3mjPZ/afQ4w
         3n6CG/CLW2Psb82AT8dBPtmrnOeJ7AT3IJPmYQgkFcKeLQ0WA9+x3nm5uDDCtMtRBXMN
         SrLh+RO7UixJ+s4oUPW5wNk/PYNIM5JoI1iCHNwg7sCVCajwEeNjw7VtvFAoM72VPa43
         YQRn8Yox4Zo9ezC0zrBFMUJsjCAvoQBKG+ROBRrWEHLXr/6Rdb13PcdYXDaOZetDXCys
         vtwUHCdsLTiSRofBg0MsHG2yhSb3wSvLj4JQQrWmjKYG/21pQ57Xmc/XzDHXg9clGH7a
         aGfQ==
X-Forwarded-Encrypted: i=1; AJvYcCVb2iV/VdHs4lPZw/AC/NmymfV09vWHgYMnjrLZUkca7xeCThdS3fiXQ8mzJB3afEZ1K4FJ88vImVQgTeE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1hsJCjLY2kP21Dp9/GBHVBfEo3P1yzEwDU/c1SiFfs3AK74O9
	9UzklS01aFRliTGTPx9EWdNZf5u+SroogELYe9mKsxUrmu6IV6B5NFpG/8+qW8n3n2IrslJePa5
	AZw1wU7pkgrFQeinDxdrtTGPUbzBXe9p/EzlQrSzgT0Hzihq2CcoyJDVjwYU6wRjU3w==
X-Gm-Gg: ASbGncsv/k5i/O72K1HFI5yXuIG1tSKIJO1nPfTRqqJbYsvutPtm+c7rWgY5OXPJoiH
	mtT36SDqdR4YA3emjp0IeEIddvUnJVs9hT/cQT7bGJgVHLYxJQJU0qf0WTPOH4lDFY90HsikX2j
	XteE35k1W3NojONS2q6PpCq9Z3xj0O3tE65Pws+5l0MTiicNpEAdCx6AQgYKhB+HvsmFkk0n8t0
	PA/0xa2enK2FgNmzNIm0H8j9Bn0sb6EUFLkwZsy5R4VSjcuuBpL69HjzhKEuB0toLzlnzz4YsTJ
	HiToomL1d5jlTJ1qaI2hjUcllYb7a3UkXOV0EhicDWNXLBcYJn/UaNNb8Ph0FcnYDzvhoUsxEBe
	5JT6wtWNS/LG0gzfxv/++87SEQeAzy622Fd4yZ5AxgqjHbubt5KpiyFZd/Vo5MJgZ
X-Received: by 2002:a05:6000:1882:b0:3a3:6595:9209 with SMTP id ffacd0b85a97d-3b5f2dfdfdfmr10757395f8f.36.1752503251872;
        Mon, 14 Jul 2025 07:27:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHb9yPQGfUemoQ/ftwZvJKjzlbImo6TEw+6kXEcwvLRV1cThxuF77rhGdAIcuPD1v8QuJos0g==
X-Received: by 2002:a05:6000:1882:b0:3a3:6595:9209 with SMTP id ffacd0b85a97d-3b5f2dfdfdfmr10757378f8f.36.1752503251480;
        Mon, 14 Jul 2025 07:27:31 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f38:ca00:ca3a:83da:653e:234? (p200300d82f38ca00ca3a83da653e0234.dip0.t-ipconnect.de. [2003:d8:2f38:ca00:ca3a:83da:653e:234])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4560f22cd29sm63831485e9.34.2025.07.14.07.27.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jul 2025 07:27:30 -0700 (PDT)
Message-ID: <5f1598d0-3645-4553-a3a4-4b458190ef53@redhat.com>
Date: Mon, 14 Jul 2025 16:27:30 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/vma: refactor vma_modify_flags_name() to
 vma_modify_name()
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
 Pedro Falcato <pfalcato@suse.de>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20250714135839.178032-1-lorenzo.stoakes@oracle.com>
 <ee19189f-7510-4ddd-85b0-34d6319f8fc6@redhat.com>
 <a4f46ca7-9531-4f6e-828d-256311756a15@lucifer.local>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <a4f46ca7-9531-4f6e-828d-256311756a15@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14.07.25 16:24, Lorenzo Stoakes wrote:
> On Mon, Jul 14, 2025 at 04:18:13PM +0200, David Hildenbrand wrote:
>> On 14.07.25 15:58, Lorenzo Stoakes wrote:
>>> The single instance in which we use this function doesn't actually need to
>>> change VMA flags, so remove this parameter and update the caller
>>> accordingly.
>>>
>>> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>>> ---
>>>    mm/madvise.c |  4 ++--
>>>    mm/vma.c     |  4 +---
>>>    mm/vma.h     | 15 +++++++--------
>>>    3 files changed, 10 insertions(+), 13 deletions(-)
>>>
>>> diff --git a/mm/madvise.c b/mm/madvise.c
>>> index 9de9b7c797c6..afa9e4db2adb 100644
>>> --- a/mm/madvise.c
>>> +++ b/mm/madvise.c
>>> @@ -162,8 +162,8 @@ static int madvise_update_vma(vm_flags_t new_flags,
>>>    		return 0;
>>>    	if (set_new_anon_name)
>>> -		vma = vma_modify_flags_name(&vmi, madv_behavior->prev, vma,
>>> -			range->start, range->end, new_flags, anon_name);
>>> +		vma = vma_modify_name(&vmi, madv_behavior->prev, vma,
>>> +			range->start, range->end, anon_name);
>>>    	else
>>
>> The doc of madvise_update_vma() is a bit misleading:
>>
>> "Update the vm_flags and/or anon_name"
>>
>> I assume it's xor? Do we want to sanity check that this will hold true?
> 
> Yeah should be xor, this is just a remnant of a past age :P
> 
> No need for sanity check I'd say, as the only code path that does this is very
> specific - with behaviour of __MADV_SET_ANON_VMA_NAME and new_flags not updated
> from vma->vm_flags.
> 
> I can send a fix-patch to update the comment for madvise_update_vma().

With that

Acked-by: David Hildenbrand <david@redhat.com>

Cheers buddy!

-- 
Cheers,

David / dhildenb


