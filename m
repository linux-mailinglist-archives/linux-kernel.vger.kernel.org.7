Return-Path: <linux-kernel+bounces-832440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 724A2B9F51F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 14:46:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BEE8384DD8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 12:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2583C1DE3C0;
	Thu, 25 Sep 2025 12:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LnfFiGMU"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 927A71DB958
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 12:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758804363; cv=none; b=Q95Nnjrh3LyC2Eqm4nHC9hzdFnsp8nYmd/YwgXkAc0sxiLN+QKfl2bsJhdhpueEvUnCbjKGg5JKrN8BR1Gx1lz7nZMTbaclpg9ymox8sAAVrZd5Z9Z13vFRx3fKREYlfb4lDgbVtFIPONrpD3W8htGXnoj9EifZLDSBX/Es95Kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758804363; c=relaxed/simple;
	bh=lqw3QVxCJ52vW1mw11aIRcHlx/xxKc4Ej4xi/bLOrRE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mXq5PgCO0ZIRGuyLSqk5D4Sfnklulk48qeT38tKi6dTwOrE2dPa9O625GdqCI4PotEEWaO7mDfNefMvFuMfrUU1Dr9WFuUO2QphXZwDTumOpttKJlTfruYj11PzXdnPvEcKf1ws2OoGUmkIJ1XMrDSGLEy+VmcX+El5MvifYMZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LnfFiGMU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758804359;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=tliHUGl1NX2itzYwArqZpvvubj/ojpB0Xta8m0g/P9c=;
	b=LnfFiGMUbLv1N5MjxyW8ABb+emaLyDtTaK6+lwfzJy7Xjv2kCkDGq4XQ7FfybYjRZsnzSx
	0V6ViZK6rRLeU6MRU1N6Hp2svsGJV3TcQ+pACK++nqkp6kKcjCSWaLJXmbOzc92k3azGtY
	5ALUqgMlpNtmMinyzm/FYhzNgwA0ZaE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-14-_kMasxprOXC65sHE7AAv1g-1; Thu, 25 Sep 2025 08:45:57 -0400
X-MC-Unique: _kMasxprOXC65sHE7AAv1g-1
X-Mimecast-MFC-AGG-ID: _kMasxprOXC65sHE7AAv1g_1758804357
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-45cb604427fso5457265e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 05:45:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758804356; x=1759409156;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tliHUGl1NX2itzYwArqZpvvubj/ojpB0Xta8m0g/P9c=;
        b=ANt7wS+viGGdu06v8KPc5sEke3fIyPTPitwvGGmuzDM+RjLazvKBXM/Ic0xdJP0nIi
         8Mrz4ds0qY0u3HETgSCSmGHPCzUTPl0s+lOGWI+qeq5ajwfHSNauQlL6Z85SpTgE0gq4
         uWjGrV2ksckYIdmH7tTgKoaYbWKtzZTxFSm2+G9W7r8ayJiPZjbmyMA1Bo3t4IYxUIWZ
         AG2YX48fo7xry4onmSiuNFk9DlSmO0jchtaFEv+ol9Dn//BoPrfFUGN9j8IqBeRBadk3
         dsNyqPmqBAuP1yTsYjUpkSg7+P8P64qaB2YvO55xGh9r82JIxq/oNsRp2mJe+BsUvuKl
         JUWg==
X-Forwarded-Encrypted: i=1; AJvYcCVn39KIAjoMuXbO6rI5si6PLkRG+h7MOqi7ko5fsDRpVj4hmzT23qJH4wXfK50eMYlkioQXeDgKu1hTWoM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPD6jEE+vn4EUr0iHJUPiBIavOfFb1lO60skcDUjGS4Ahi4/ht
	tosinsqIE2Z1Eg+j8VbAqOol28fJ/pF6Uqe7gbpUpQ8vJnkmMoO/eDmWCKGmbkyAwsgn1Cf4fDd
	Ik6iigiFQoyI3zF0RJu4bcqbTqvNXqmccJG7yTMOyh1Ubaf9GxWp45RCkov5ccgsO1Q==
X-Gm-Gg: ASbGncsMuNYD6+V1b0GBDvppsce20bav7DTKV4CUQTsJsUcAYL0VTaXVxGfYxNZUJcU
	xrJUaMdCwUWA8Tc2B+V59c9n+cJRJaty45XfKwPhfohLpNQwWd6QdFuTos7+YlKBTXO4qxWH8X6
	giKIDewRHu6pquH7SHp3n8+9R4J+DaF7AzFiltHmP4wIS/6QlPbK3KC3x/Mk6KLYeViNR/xlPh8
	aV2hBhIn+rkgFV7OTh3Tlqhn2btS5CbR4Ou9xZozCLA+1ylMGyEZyU+YuyAO2GFdQv9EmCutCNs
	03adClrQNuikbrFW3KXC4iXLxGlCVqHnaXtVnCQbh6a2dD65RXCzafLvSbGKWCYMVFMJLx32e/F
	LH48Rxa7iUzM0e0VJwZMrmj8Tt5b4BFXX9KmoCZSJ/O0+LMRmnLFm0Z+IVlHgqcqHszvg
X-Received: by 2002:a05:600c:4743:b0:459:d451:3364 with SMTP id 5b1f17b1804b1-46e329eb11cmr37972655e9.24.1758804356469;
        Thu, 25 Sep 2025 05:45:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFJhKsYlnFC8iB/Ma/engXkSgdIOoZQ/qaChN82QOE7O7GuUbNoaCoYIvsSrrRCZmzhX+hwTQ==
X-Received: by 2002:a05:600c:4743:b0:459:d451:3364 with SMTP id 5b1f17b1804b1-46e329eb11cmr37972425e9.24.1758804356075;
        Thu, 25 Sep 2025 05:45:56 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f3f:f800:c101:5c9f:3bc9:3d08? (p200300d82f3ff800c1015c9f3bc93d08.dip0.t-ipconnect.de. [2003:d8:2f3f:f800:c101:5c9f:3bc9:3d08])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fb74e46bcsm2945522f8f.8.2025.09.25.05.45.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Sep 2025 05:45:55 -0700 (PDT)
Message-ID: <43ae76b9-14e2-45b9-83b0-4e5fdb6bfb3e@redhat.com>
Date: Thu, 25 Sep 2025 14:45:54 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm/memblock: Correct totalram_pages accounting with
 KMSAN
To: SeongJae Park <sj@kernel.org>, Alexander Potapenko <glider@google.com>
Cc: akpm@linux-foundation.org, vbabka@suse.cz, rppt@kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, elver@google.com,
 dvyukov@google.com, kasan-dev@googlegroups.com,
 Aleksandr Nogikh <nogikh@google.com>
References: <20250925123759.59479-1-sj@kernel.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250925123759.59479-1-sj@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 25.09.25 14:37, SeongJae Park wrote:
> Hello,
> 
> On Wed, 24 Sep 2025 12:03:01 +0200 Alexander Potapenko <glider@google.com> wrote:
> 
>> When KMSAN is enabled, `kmsan_memblock_free_pages()` can hold back pages
>> for metadata instead of returning them to the early allocator. The callers,
>> however, would unconditionally increment `totalram_pages`, assuming the
>> pages were always freed. This resulted in an incorrect calculation of the
>> total available RAM, causing the kernel to believe it had more memory than
>> it actually did.
>>
>> This patch refactors `memblock_free_pages()` to return the number of pages
>> it successfully frees. If KMSAN stashes the pages, the function now
>> returns 0; otherwise, it returns the number of pages in the block.
>>
>> The callers in `memblock.c` have been updated to use this return value,
>> ensuring that `totalram_pages` is incremented only by the number of pages
>> actually returned to the allocator. This corrects the total RAM accounting
>> when KMSAN is active.
>>
>> Cc: Aleksandr Nogikh <nogikh@google.com>
>> Fixes: 3c2065098260 ("init: kmsan: call KMSAN initialization routines")
>> Signed-off-by: Alexander Potapenko <glider@google.com>
>> Reviewed-by: David Hildenbrand <david@redhat.com>
> [...]
>> --- a/mm/mm_init.c
>> +++ b/mm/mm_init.c
>> @@ -2548,24 +2548,25 @@ void *__init alloc_large_system_hash(const char *tablename,
>>   	return table;
>>   }
>>   
>> -void __init memblock_free_pages(struct page *page, unsigned long pfn,
>> -							unsigned int order)
>> +unsigned long __init memblock_free_pages(struct page *page, unsigned long pfn,
>> +					 unsigned int order)
>>   {
>>   	if (IS_ENABLED(CONFIG_DEFERRED_STRUCT_PAGE_INIT)) {
>>   		int nid = early_pfn_to_nid(pfn);
>>   
>>   		if (!early_page_initialised(pfn, nid))
>> -			return;
>> +			return 0;
>>   	}
> 
> I found this patch on mm-new tree is making my test machine (QEMU) reports much
> less MemTotal even though KMSAN is disabled.  And modifying the above part to
> be considered as free success (returning '1UL << order') fixed my issue.
> Because the commit message says the purpose of this change is only for
> KMSAN-stashed memory, maybe the above behavior change is not really intended?
> 
> I'm not familiar with this code so I'm unsure if the workaround is the right
> fix.  But since I have no time to look this in deep for now, reporting first.

Good point, I think there is something off here.

-- 
Cheers

David / dhildenb


