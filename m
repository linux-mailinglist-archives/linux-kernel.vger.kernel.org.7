Return-Path: <linux-kernel+bounces-775062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D324B2BAD9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 09:34:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A49B1697B4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 07:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BF9424BCE8;
	Tue, 19 Aug 2025 07:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="etBdOUHd"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 130B1284887
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 07:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755588839; cv=none; b=s2sM32W9xajez4+L/r7lupaCX4QKJFJPXjUGMvU+XyFxFs5rZ6xBsbB5QMXPNQvb6yRrdKgtP1LmltekPPI6lEJ0J7bQeyBqPPGGJUp+J/41VS9JdvqA4HREIVp11byzviltR1XIN/2sGs4+31tIgvOLESz8PfpIxPyy1cqwQ0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755588839; c=relaxed/simple;
	bh=s8wWljx82nSn3UISxJXe4gm0rRVC2rvfTllTm0ErAx4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZrOA9W6U2ujtryfhT9v9EYB0F3B4TWzPBfAGVY/kVOJjucJ44sU04I5b7rhZHZbfbpQjRxCnhXyLB9KJRURYCC4gmo/YoDzdoD/VQT2BrdaAWplEafjty8342rcFv6ck00RSXGPP0vkwZPTCsdkCF+TFcwlSKtjxXJ9zSqJTgfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=etBdOUHd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755588836;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=/HGYaHU9kuiZzGF6yAbjynMbTPd773QG5CM75V2XmaU=;
	b=etBdOUHdqoGsvBZtyefACUKzbXhPY67RC5pubptToR9cBGJOZWJTzGNMnQdv/Ra3fKwX2C
	66o1++X3ZiG8Dc66a+ezNdu42nfCfefdPfAnjaDvG+Y7gmtk+IEx7d4M/RtIhioJbKiy1q
	5/am0swNVyd4c416N9f8AhaHUgeZZVk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-103-OYQzZCkfNneCsR09KCX5AA-1; Tue, 19 Aug 2025 03:33:54 -0400
X-MC-Unique: OYQzZCkfNneCsR09KCX5AA-1
X-Mimecast-MFC-AGG-ID: OYQzZCkfNneCsR09KCX5AA_1755588833
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-45a1b10418aso28839345e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 00:33:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755588833; x=1756193633;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/HGYaHU9kuiZzGF6yAbjynMbTPd773QG5CM75V2XmaU=;
        b=rw096buLnWxPmY3I2RzkQ1meU+SipXWCrcUGbHkt2ka4anlCPcIfl662AERsMeugKA
         omw1zfrADBVWd42dzCgtQ+5Dm0cgXa/XkmklrcsOXpj2cXxA0wF7d9GJKlgzWkQuSfCb
         MV6oR3n0O4yNhXSi74uBx1WOMIP6xRQF249K6nLFfWdslS3sNcXHmW2WuxVnPlyNUPDX
         okouq7wXhxR9epSEmGe+hypxm63vzgFdYFn9UN0ErG1K0eCCvMUbWuhX7hR8G2uyHYKt
         kyJmkE0GJ8esmh9qJsILiEsclOVOKNtD3t2t8WWpmWXmo2NaJ76AOuRHiWO6KS1F7NL2
         tqaQ==
X-Forwarded-Encrypted: i=1; AJvYcCV3Qt3ebByqFXZgfrSXZQUlQlhNfVoaW6lV2tn0+TZgtryW0BSSpSKOPznREOdIJMvx6W8CcR1Hmos2hhc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEFS2Ix8EJ29Tvk+rhBIJBm3jURIIeDXPJrNNdAifAAsQg0ewd
	1OQQuLS99EzeKzr/b6cO/ugMHbq6bucOPBNemHBdMdS8Cz+6wX1do80+LkBGjYSiHXAgGn4bt6V
	xaZ2l0MScj+jSWspUGCNPCN7kCpWjBjSrog0uJao/LuRSNd2w9FTyZpiNczQtcC2h+g==
X-Gm-Gg: ASbGncuJTiw/nXpVcCag8GZuilihUsBpQK4K5Ye5qAf3UjtIekXvz6Ky25hlUatsqPm
	MB3NUkVHho8Bbc4Wm+uAB22tRb760Z76zMJa0m3ZMJwqIeDMYCvrIgQH/mtks3gkUeyehSQ42m+
	P1EEuYiRY0q42ubotGYXDBuivkSm8EvBfZ25RfGPwiSTc2msX7qi1AVyEIurktTVebPOfEBY8rj
	VufolF7ZLztqT/rsoxE0UO3mSqv1q3PSXegLmE/y1NnJbWkzLZdS46zlC7vSXq7T44LM6QQQeuV
	5QVGNOdQc6ph0WOAMTsMU1cBUT3b5ioS9pnfS1yl0NuCb4o3P3wG69r66V4TPKqc7HmZk7o9Abl
	6gRAhF2LF6I+JZLAZM2OOR5snbrJmiFfSozApOVWAlrbGufsLrJ559bJPFaiCPht5oFM=
X-Received: by 2002:a05:600c:3b25:b0:45a:236a:23ba with SMTP id 5b1f17b1804b1-45b43e00b52mr10917425e9.22.1755588833143;
        Tue, 19 Aug 2025 00:33:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHAZTBDfDGb9kB6qEjLtHFg3XabkcqA3t8pGaVH7C0rdmn9M5ldhOM4WNjuzlwtQb5eKHBz4Q==
X-Received: by 2002:a05:600c:3b25:b0:45a:236a:23ba with SMTP id 5b1f17b1804b1-45b43e00b52mr10917095e9.22.1755588832681;
        Tue, 19 Aug 2025 00:33:52 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f07:8700:71be:5385:87b8:5a98? (p200300d82f07870071be538587b85a98.dip0.t-ipconnect.de. [2003:d8:2f07:8700:71be:5385:87b8:5a98])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c0777892f8sm2450088f8f.53.2025.08.19.00.33.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Aug 2025 00:33:52 -0700 (PDT)
Message-ID: <1f8301ba-4c2f-44f8-a7bb-1512768bb435@redhat.com>
Date: Tue, 19 Aug 2025 09:33:51 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: readahead: improve mmap_miss heuristic for concurrent
 faults
To: Roman Gushchin <roman.gushchin@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>
References: <20250815183224.62007-1-roman.gushchin@linux.dev>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250815183224.62007-1-roman.gushchin@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15.08.25 20:32, Roman Gushchin wrote:
> If two or more threads of an application faulting on the same folio,
> the mmap_miss counter can be decreased multiple times. It breaks the
> mmap_miss heuristic and keeps the readahead enabled even under extreme
> levels of memory pressure.
> 
> It happens often if file folios backing a multi-threaded application
> are getting evicted and re-faulted.
> 
> Fix it by skipping decreasing mmap_miss if the folio is locked.
> 
> This change was evaluated on several hundred thousands hosts in Google's
> production over a couple of weeks. The number of containers being
> stuck in a vicious reclaim cycle for a long time was reduced several
> fold (~10-20x), as well as the overall fleet-wide cpu time spent in
> direct memory reclaim was meaningfully reduced. No regressions were
> observed.
> 
> Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
> Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
> Cc: Jan Kara <jack@suse.cz>
> Cc: linux-mm@kvack.org
> ---
>   mm/filemap.c | 14 +++++++++++---
>   1 file changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/filemap.c b/mm/filemap.c
> index c21e98657e0b..983ba1019674 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -3324,9 +3324,17 @@ static struct file *do_async_mmap_readahead(struct vm_fault *vmf,
>   	if (vmf->vma->vm_flags & VM_RAND_READ || !ra->ra_pages)
>   		return fpin;
>   
> -	mmap_miss = READ_ONCE(ra->mmap_miss);
> -	if (mmap_miss)
> -		WRITE_ONCE(ra->mmap_miss, --mmap_miss);
> +	/*
> +	 * If the folio is locked, we're likely racing against another fault.
> +	 * Don't touch the mmap_miss counter to avoid decreasing it multiple
> +	 * times for a single folio and break the balance with mmap_miss
> +	 * increase in do_sync_mmap_readahead().
> +	 */
> +	if (likely(!folio_test_locked(folio))) {
> +		mmap_miss = READ_ONCE(ra->mmap_miss);
> +		if (mmap_miss)
> +			WRITE_ONCE(ra->mmap_miss, --mmap_miss);
> +	}

Makes sense to me, bud I am no readahead expert.

-- 
Cheers

David / dhildenb


