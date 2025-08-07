Return-Path: <linux-kernel+bounces-759436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65376B1DD81
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 21:33:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F05B584A9C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 19:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D72051FAC23;
	Thu,  7 Aug 2025 19:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xi9eMMs0"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2CA4AEE2
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 19:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754595221; cv=none; b=e922NSnTT/Rtrkn0ViWqe05Y5Fub/sfrJ8qpWuV3Yw53XV6VNdSFsdcTfLitLfN7noEo8GDQ0ieo7O1MIisXMpEv61nVu4e+tZHIZ+hKvHVolGhqCIPrkUkQGv96p/r/EGFE9w7VilivdJfMPO2pnaL6xNsN2vnprKH8KIBmU3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754595221; c=relaxed/simple;
	bh=0PpTd1ChISQ71JxJkunjCFPnT9Z5REI9zAzFmUaURfo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ke+dfEbnaDp2TYjZNA01r5ul1vstX/WdcEMU8Aca0od+33EGoSbSkODjWo/M5WVFDvRvoGKi7ALU6QM36n6knxVzx7P2f8gG94z9jRedh31BwkiENIikI3hx+abukqQyfypzc+gELoIP7ronM2K8LNH6L/UjOWGwvfsV2DqU4gA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xi9eMMs0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754595215;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=L3sfW+BuUN8qg0raSUf+jpJ80763tcAVtLgdzo6FODg=;
	b=Xi9eMMs0QN3dnKyuDFhVRN/u+u6ey/77miMTF3kJIeTniJdBWOdkXUlPvHpJfnAP9gEV7O
	/kqgIwy/+OPnuJmtIlFJro7T8S4FMdhade1RGVbFboo6f4iQunyWmi5cAO1d4nNh9xdego
	/BPk+sYk2MnqB9IZeqi21mnVXAAnS9I=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-261-DgPzpR74Nsi3bCtDxZ-x4w-1; Thu, 07 Aug 2025 15:33:34 -0400
X-MC-Unique: DgPzpR74Nsi3bCtDxZ-x4w-1
X-Mimecast-MFC-AGG-ID: DgPzpR74Nsi3bCtDxZ-x4w_1754595213
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-459db6e35c3so10833545e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Aug 2025 12:33:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754595213; x=1755200013;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=L3sfW+BuUN8qg0raSUf+jpJ80763tcAVtLgdzo6FODg=;
        b=l0AooEVJH7wx2wbjbKs61IaewnOLd5qRT2S5Z0fkIMD4YZB1FGQsk6ImuK17o3nnNf
         LVryOww7CnN/5eSi8UUwJ91E2As3ieieaNtFch2xxH2Aoj+hS4l67pnrIIXLMGQpBAe5
         EmFAiMDhPMnWp2la4+mmutQMNVGEHczzjahq0airJb18CHTiuwRUUCTMoDrlHMMPBN0k
         4H/gul64JJm+NIcbAJ3g1cySH0OdlrNxPQGIpvZXb2OAFFDlpG2FPY2ZINGXvCz4TmBE
         i0XZoaYuI6o/PYst4d4yns0LprjLqPqwLoG+rviOtlrj3J0b3dBAM5Pw6/+fV+zOtFG7
         we/w==
X-Forwarded-Encrypted: i=1; AJvYcCXP7eY0qe3XxnOMe5oZ20lIgfpT3Eqs+uIpcMBC+K5jqDHaWzMPNnJnv7TMt06520WScW0keXuwC5q4XHU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzB4mCxWzy/njSK+Cx+vhEl+oMztto2k9IpTZm1TsdSVa7cM+Qr
	+PaaENUhe+L3FvvAI8nqobkOf+kwiFo7oFUeODTyj/6ZPG7FiaIiHw+f3jzoRGDhBlbSsrKzdoD
	CIsoWOhlAdHf3bRlDK/OGwGBN+2ipLY70pX+yuBiDrNFQ4UeEdX6M3/8c6LfCTdmlzg==
X-Gm-Gg: ASbGncv0rqsE78t8wUQrGkOsinsXuhHrAwAENnAWVx1+Fc94BHkKcXWJROM/xC8N8Pv
	tUKgLAFq7RLjrIRk8t9umT5y4i1PDIwvUr2RLUVUn58GUDpjFu8cUOlUYl7aD/1mx+HJ93yt6HL
	jGTK09M61NId7aKVlY0cCYEyauxhwj0bJlXRC/ksUd2JBkM2JwJFq6OY1YgmAemFeP/FF1mQBhg
	j+Oc0E/aU2HEk2+hsX3wXnR3DhFef23hOX32FArYA98QzJJwO6WuZe5BZLJI4ODwPxpaxjZHPMB
	yUvvDxIqE50/p8FUet6oe5ie6pbYjJoQuF6HNSbNVs5YVHVQYyoJck97Oo2tE0GdCnfqnHMJQa/
	jOLs316XT7OAvehjIjtzEnB9IyaA4V149uUAycAOWZBIg5vt9I1Xy4w8UnR3TSli8tMo=
X-Received: by 2002:a05:600c:474a:b0:455:fc16:9eb3 with SMTP id 5b1f17b1804b1-459f4f3e33bmr1378065e9.33.1754595212778;
        Thu, 07 Aug 2025 12:33:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFKzAaiLE4wWUDzv/kHmD0X6RwWzUT4LbWdsvRdTyvoc2LKZ8O7shwZOIhexGhHBHA6I/MKBg==
X-Received: by 2002:a05:600c:474a:b0:455:fc16:9eb3 with SMTP id 5b1f17b1804b1-459f4f3e33bmr1377855e9.33.1754595212308;
        Thu, 07 Aug 2025 12:33:32 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f49:bc00:12fa:1681:c754:1630? (p200300d82f49bc0012fa1681c7541630.dip0.t-ipconnect.de. [2003:d8:2f49:bc00:12fa:1681:c754:1630])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459e587d378sm103146285e9.23.2025.08.07.12.33.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Aug 2025 12:33:31 -0700 (PDT)
Message-ID: <cb010f6c-4fd1-4d5d-87f5-4223ddb70f5a@redhat.com>
Date: Thu, 7 Aug 2025 21:33:30 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH HOTFIX 6.17] mm/mremap: avoid expensive folio lookup on
 mremap folio pte batch
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Pedro Falcato <pfalcato@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
 Barry Song <baohua@kernel.org>, Dev Jain <dev.jain@arm.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20250807185819.199865-1-lorenzo.stoakes@oracle.com>
 <ujfeyn2awquoc4pc7qxcnavgqcu57kvmdb66x2hyaeoiasq3w4@u5qlyyklfrld>
 <c556f29b-fffb-48d2-beda-a9e2b70aa4a4@lucifer.local>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <c556f29b-fffb-48d2-beda-a9e2b70aa4a4@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 07.08.25 21:22, Lorenzo Stoakes wrote:
> On Thu, Aug 07, 2025 at 08:14:09PM +0100, Pedro Falcato wrote:
>> On Thu, Aug 07, 2025 at 07:58:19PM +0100, Lorenzo Stoakes wrote:
>>> It was discovered in the attached report that commit f822a9a81a31 ("mm:
>>> optimize mremap() by PTE batching") introduced a significant performance
>>> regression on a number of metrics on x86-64, most notably
>>> stress-ng.bigheap.realloc_calls_per_sec - indicating a 37.3% regression in
>>> number of mremap() calls per second.
>>>
>>> I was able to reproduce this locally on an intel x86-64 raptor lake system,
>>> noting an average of 143,857 realloc calls/sec (with a stddev of 4,531 or
>>> 3.1%) prior to this patch being applied, and 81,503 afterwards (stddev of
>>> 2,131 or 2.6%) - a 43.3% regression.
>>>
>>> During testing I was able to determine that there was no meaningful
>>> difference in efforts to optimise the folio_pte_batch() operation, nor
>>> checking folio_test_large().
>>>
>>> This is within expectation, as a regression this large is likely to
>>> indicate we are accessing memory that is not yet in a cache line (and
>>> perhaps may even cause a main memory fetch).
>>>
>>> The expectation by those discussing this from the start was that
>>> vm_normal_folio() (invoked by mremap_folio_pte_batch()) would likely be the
>>> culprit due to having to retrieve memory from the vmemmap (which mremap()
>>> page table moves does not otherwise do, meaning this is inevitably cold
>>> memory).
>>>
>>> I was able to definitively determine that this theory is indeed correct and
>>> the cause of the issue.
>>>
>>> The solution is to restore part of an approach previously discarded on
>>> review, that is to invoke pte_batch_hint() which explicitly determines,
>>> through reference to the PTE alone (thus no vmemmap lookup), what the PTE
>>> batch size may be.
>>>
>>> On platforms other than arm64 this is currently hardcoded to return 1, so
>>> this naturally resolves the issue for x86-64, and for arm64 introduces
>>> little to no overhead as the pte cache line will be hot.
>>>
>>> With this patch applied, we move from 81,503 realloc calls/sec to
>>> 138,701 (stddev of 496.1 or 0.4%), which is a -3.6% regression, however
>>> accounting for the variance in the original result, this is broadly
>>> restoring performance to its prior state.
>>>
>>
>> So, do we still have a regression then? If so, do we have any idea why?
> 
> It's within 1 stddev of the original results, so I'd say it's possibly
> noise.

It's very likely noise. And even if it's not, even a simple code layout 
change by the compiler can provoke something like that.

-- 
Cheers,

David / dhildenb


