Return-Path: <linux-kernel+bounces-730300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29F80B04283
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 17:05:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3FE13A3A35
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 15:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27FE124886F;
	Mon, 14 Jul 2025 15:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CM+u0ni9"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D922459E3
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 15:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752505392; cv=none; b=if4CGvby06/YU/usGI7/rC+B2m8rMq4qNRkDYdTjoV0ERC66Ciwd4WEL/ATb1yTPKSd0k+dR2Xz2BqUKKFbvJAkEqYftxTVH8bp3M2eUNMDfoRrLyag49+79UZjY8IbJp3zvpqrECUkR0msJiZ8Lwl4raYwgC8zvq6yCKK72fhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752505392; c=relaxed/simple;
	bh=00ai1vT86FyKJTE1vnL9+eUZTPeH0WmXZLEAASJdmfU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cEQPbSWUQpQS8UK5RHFgOxlM63Xkf2lVginpPXiNn5wRQ3hIn9o6B48K+k/TllEKPz/NLwEQwPyHmXdoxXbhM8ZELw+aakEUMrPENuPUycBz5quEHfPSHMpKlLWBG199Krh559AtyAJcxMAwmHAu7yUAv428Mvg+8TKrhZ6yMwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CM+u0ni9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752505389;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lwmzTKO/GSYqR+lG0EQi+tXrUbMLT5Q43haASi9H4ls=;
	b=CM+u0ni9r4X4/xiBNfoaN7uu3+eX/EPtZK42bCWB2iLFT101yu/bYrPVGBKt8ePPmjIt5B
	rCdVNBqJEfJC3VPSp2HVT8WWwrD4W04p6hsNEVsWH9b/4GqZ2DfrRX3yh6NUfh+7wpoqHc
	ehMPrjJ5vwiOksY/fc2GgKPtp1rSaQ0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-XnqSSqzYPQK5ET6XUXaIVg-1; Mon, 14 Jul 2025 11:03:07 -0400
X-MC-Unique: XnqSSqzYPQK5ET6XUXaIVg-1
X-Mimecast-MFC-AGG-ID: XnqSSqzYPQK5ET6XUXaIVg_1752505387
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-453817323afso28148005e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 08:03:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752505387; x=1753110187;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lwmzTKO/GSYqR+lG0EQi+tXrUbMLT5Q43haASi9H4ls=;
        b=k+EzRInjwpcelQyTvS/Q2r6ir7Tf4tegYXFYg84fR/cRsIhVMJD5Ozsw6X9rmB7fMu
         ed32Jy7jcNr2gmraSe3o11GSujaBB6hi8G/UR3M0JqpAOGl9g3oQCOSlFrBcDgN8tEao
         0GFdqMnUkrQO48rp6lHgtVQeRYighokPiZgx/WTBTamcX/Ezm2hGMNTYV+athnKZwos8
         LFikFugrvCzlVpDjXNyMXkb8g4cGjYRc+fn6p97CT4QQXsErKnK9qjSsMbzSaLM5KIxb
         tC8y6kTWmfoTpfHsrLw+TluB/9I90szXyozkYImf/c4ctpolNgJgFlQrz2KB4vpm/Gjt
         F7MA==
X-Forwarded-Encrypted: i=1; AJvYcCX+ZPEs29HKEU2WjkN2TugEAQkGkZXC3sbbBkdONjqDxUdjldtgrmS1yTSrcIrkPi6kHoz71IfmkRokAys=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyHd/cF9ML46+6UzlL6x9+ZcTi1Xpr9CNhh0mGMKwLtPeSRPva
	qY+yLSJRs5aBf2U0CalPQeyHZAyy09k4NQIoBjDbCF+hg2V7iD3xyY9p7Dx5V2Fwg14MXwLjjbY
	4k/08QPW4D88DtZTCyWWKVhogbJRL8ftE4CiuQ9CJkXu2GZDr7ZnqVetqBoFxxx+1Qw==
X-Gm-Gg: ASbGncvQHY5X4vBADXD7WwDOwoDdzkMbCKOMYutRFxRZuT/1LnVLAQJjuVQ7MrEJg3w
	7G2VNc8LTVIZOCozyaQmmfb2/44zUj/FI+ddlfCjM3kw45Tz92BioW1q1rzvPZtJsQ+y41svdIP
	ze1ad8suMH6etI07D8sx+YW9nd5n8ndk4NMg64/JUr+1BRC7V1n2DtIYGD0IBNH0kn11rxwli1U
	dCXNuq4nGteNIzHS7r2qtvNDoDyc/Te2/RZH5Syano+RTl1hQYGNdUlnRcUob/foRWDYnqjUbDz
	dv02qUm9j3PCwFnZcHVwytdRN3x9NSMBiGMHrjkrl1WL/Nqz1TdsxY4QfzCRJrZ55L1uPU+TLOS
	DrIBKSQVrqbI8fZgxsdr3aQaUG10LT3NOHr6PYlYobPkAG1N6z8RlbFSyX2h0DD2c
X-Received: by 2002:a05:600c:6304:b0:43d:46de:b0eb with SMTP id 5b1f17b1804b1-454ec16cb2emr137861705e9.12.1752505385740;
        Mon, 14 Jul 2025 08:03:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGnaDWYjHfj3OLHTsn1djM3rKSwDzbTsVxLu0KMQAFJlVPHgfDa8igMCz9eQPvEPmF5axsR0A==
X-Received: by 2002:a05:600c:6304:b0:43d:46de:b0eb with SMTP id 5b1f17b1804b1-454ec16cb2emr137860775e9.12.1752505385077;
        Mon, 14 Jul 2025 08:03:05 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f38:ca00:ca3a:83da:653e:234? (p200300d82f38ca00ca3a83da653e0234.dip0.t-ipconnect.de. [2003:d8:2f38:ca00:ca3a:83da:653e:234])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454dd474a9csm134751645e9.16.2025.07.14.08.03.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jul 2025 08:03:04 -0700 (PDT)
Message-ID: <0925c64b-c721-4dc5-913a-c43a94dc64a3@redhat.com>
Date: Mon, 14 Jul 2025 17:03:03 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] mm/mseal: move madvise() logic to mm/madvise.c
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
 Pedro Falcato <pfalcato@suse.de>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Jeff Xu <jeffxu@chromium.org>
References: <cover.1752497324.git.lorenzo.stoakes@oracle.com>
 <5d932ec1f9d0ea115aac65067e4cb8241a06e791.1752497324.git.lorenzo.stoakes@oracle.com>
 <5e21df9f-7f75-412b-a173-fe6da49952e5@redhat.com>
 <b9bb8416-24a0-4bd2-97c1-055460cece23@lucifer.local>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Organization: Red Hat
In-Reply-To: <b9bb8416-24a0-4bd2-97c1-055460cece23@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

>> or sth like that would surely clean that up further.
> 
> Well, I plan to make this not a thing soon so I'd rather not.
> 
> The intent is to make _all_ VMA flags work on 32-bit kernels. I have done some
> preparatory work and next cycle intend to do more on this.
> 
> So I'd rather avoid any config changes on this until I've given this a shot.

Sure, if that is in sight.

>>
>>> +/* Does the madvise operation result in discarding of mapped data? */
>>> +static bool is_discard(int behavior)
>>> +{
>>> +	switch (behavior) {
>>> +	case MADV_FREE:
>>> +	case MADV_DONTNEED:
>>> +	case MADV_DONTNEED_LOCKED:
>>> +	case MADV_REMOVE:
>>> +	case MADV_DONTFORK:
>>> +	case MADV_WIPEONFORK:
>>> +	case MADV_GUARD_INSTALL:
>>> +		return true;
>>> +	}
>>> +
>>> +	return false;
>>> +}
>>> +
>>> +/*
>>> + * We are restricted from madvise()'ing mseal()'d VMAs only in very particular
>>> + * circumstances - discarding of data from read-only anonymous SEALED mappings.
>>> + *
>>> + * This is because users cannot trivally discard data from these VMAs, and may
>>
>> s/trivally/trivially/
> 
> Ack thanks - Andrew can you fixup? Can send a fix-patch otherwise.
> 
>>
>>> + * only do so via an appropriate madvise() call.
>>> + */
>>> +static bool can_madvise_modify(struct madvise_behavior *madv_behavior)
>>> +{
>>> +	struct vm_area_struct *vma = madv_behavior->vma;
>>> +
>>> +	/* If the operation won't discard, we're good. */
>>> +	if (!is_discard(madv_behavior->behavior))
>>> +		return true;
>>
>>
>> Conceptually, I would do this first and then handle all the discard cases /
>> exceptions.
> 
> Hm I'm confused :P we do do this first? I think the idea with this is we can
> very cheaply ignore any MADV_ that isn't applicable.
> 
> Did you mean to put this comment under line below?
> 
> I mean it's not exactly a perf hotspot so don't mind moving them around.

I was thinking of this (start with sealed, then go into details about 
discards):

/* If the VMA isn't sealed, we're all good. */
if (can_modify_vma(vma))
	return true;

/* In a sealed VMA, we only care about discard operations. */
if (!is_discard(madv_behavior->behavior))
	return true;

/* But discards of file-backed mappings are fine. */
if (!vma_is_anonymous(vma))
	return true;

...


But now I wonder, why is it okay to discard anon pages in a MAP_PRIVATE 
file mapping?

-- 
Cheers,

David / dhildenb


