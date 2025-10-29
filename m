Return-Path: <linux-kernel+bounces-876366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C2F5C1B656
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 15:50:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86350462956
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 14:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 002352820DB;
	Wed, 29 Oct 2025 14:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KOJwjUj+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B04A1DF994
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 14:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761748478; cv=none; b=HzhSqkVEyV8lIZ3Ex+g1GwIS4kv9Co/ZMHbv5pc8t+ftO39WeTpTbCuAO3966OglyAq6bia7rkqhGX/bYAM4JtxaDmgidabjXGwIItSs9uPQ+hVXtTUf5ODSy+xYuuWNBmS/OSUbOau8UnlH9fPpxYHlSH6DG0NMwqpBe6+DQy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761748478; c=relaxed/simple;
	bh=Lmse1AZ3gGks6XmD4IjseElJAQddbStkJvahKA7w2ss=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rA5L7m9rV18BWnw5Duck3Xymc/rfONWeAXyEBOOd2eWacb0p+5zJSdpyRjDKmPPZIYOp6hAd3H6LRvf+VozI5sLSs0G/tlF/SSQWmObFg3AX5pxzXZ4DwxQQaW6S1bZtM0Ud42LbbvFcaEXDDrdaxq5DmCvjltw241v8IR9zSDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KOJwjUj+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761748475;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=gEmkGkexw0CRk9bcDpskexAnNi17SX4ocXzcH4GVlU0=;
	b=KOJwjUj+NPiblLaZDy4LoYyQjXKRByXu0gCIGiC0Uf81wVTQO5DYbDzyCPoUWdwWjZt/yx
	RtJJZJiEoz0PYWUpXAU5Fne7OQ/w+VXY+NhQeK+7ww9MOvkKOwRHlXw8sDP+pmSr9VLKSb
	L0s6JieHU/gZBhuElEcNI+8If33djHo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-343-DLIIayuaPE-ZiD3BHfPV3Q-1; Wed, 29 Oct 2025 10:34:27 -0400
X-MC-Unique: DLIIayuaPE-ZiD3BHfPV3Q-1
X-Mimecast-MFC-AGG-ID: DLIIayuaPE-ZiD3BHfPV3Q_1761748466
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-426ec5e9278so4573926f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 07:34:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761748466; x=1762353266;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gEmkGkexw0CRk9bcDpskexAnNi17SX4ocXzcH4GVlU0=;
        b=jxJSn0isnSFp/GxFDItgvK4dd8+GcN9qLldL8ykF1AGgIepYUgOX2rOnr9WpJE0g7s
         8SFvZjAdG4vwHcmULHGVNoGwEWCBRblfWqGLD+JNQi2xb+3IPfyTwgxYbGIoj5po43pE
         1FkT9On6s1oBX1eDKja1w/2QZoBhGFLQHk7pKiWLakGQ/HvpEoYQlAPdJ2wXTZrQGhoa
         EuoiXNgjmiTuhImYv09NMyVLYyY+he/awtTlG+uzxCQi1+9+nddvWcn7UVXVlBhz5CCg
         1QnMSBUWLV8l7P7+A5WFbAtQlYArhRS9KE4Tz7i4kNMQDCHVEqcZeqOT+Ba5P9a6b5iN
         H+Rg==
X-Forwarded-Encrypted: i=1; AJvYcCV20ri1DlOKLz0BLsx1lWd5QHaEe3/ArVXJ/F1gRToRwiVYrGSzqDK6ue9l1p5uoU8uAYk9ih4/r4q3n9I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkZzcDx/28QEO9n5JpWsTHAwv/eUHgAz93ENH8vUoplN94XWGv
	skmHMmrfIOf8r7mopIquzF6nQSOjV6r+hQXwNR66u48FGpR8IQVFqMjJyYSAmbVl+B6RUT8xPu1
	sdX8nSmwgw9cgfi+RbIjsmq26pp3PPF23JcFYXTimGCFaE2p8+tYy5J/KBKw43Xfx6Q==
X-Gm-Gg: ASbGncvftVAbFx3wXvwY5H6Ru1GEx6aKO+6bHbAnHcK4TFWcHNI5jLpvYEiP6Boirl4
	ouhRz2sBr9ka82uP4H0zRdUUbKZ7g6KjnO3zOjP37ia0RnsBwwJvpHs+biHvW6dF5vypTMsimmW
	d0tMiHLFmqXZrREiB4SYU1XhXuHXT0n5j5AtHA9AXqJSqYfnMMIEA96iZjgNKWiwx4zstbU6a8A
	zVuplUmD8vSRq9VvIdOE3QyZRJG4zQRA3EsLMJEGjOulszskie+ilEopc+SUIbaST/lkHdpLBGa
	Snye09DKZ6EWd8cMwcE+1SYzueNyJ/erPScygeN52t5owBcrVKUp0ElJ6HQi3A7wOQLZH4QiMAZ
	0JZMqh5nBJKJ0iuX4NSENPw==
X-Received: by 2002:a05:6000:186d:b0:426:d734:1378 with SMTP id ffacd0b85a97d-429aef7600fmr2321371f8f.4.1761748465823;
        Wed, 29 Oct 2025 07:34:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFvlxYXsZF/5V2TIO1U8LhBcmcpqSHG8cv2bVPzCWRyBRIJRSugy1iaEGIczCZxlK6usnQ7Zw==
X-Received: by 2002:a05:6000:186d:b0:426:d734:1378 with SMTP id ffacd0b85a97d-429aef7600fmr2321347f8f.4.1761748465329;
        Wed, 29 Oct 2025 07:34:25 -0700 (PDT)
Received: from [10.32.64.156] (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952de4a1sm27199830f8f.37.2025.10.29.07.34.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Oct 2025 07:34:24 -0700 (PDT)
Message-ID: <57b83fd3-8a6c-4d98-bd6d-1c97c71b91a3@redhat.com>
Date: Wed, 29 Oct 2025 15:34:23 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] Revert "mm/ksm: convert break_ksm() from
 walk_page_range_vma() to folio_walk"
To: Pedro Demarchi Gomes <pedrodemargomes@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Xu Xin <xu.xin16@zte.com.cn>, Chengming Zhou <chengming.zhou@linux.dev>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20251028131945.26445-1-pedrodemargomes@gmail.com>
 <20251028131945.26445-2-pedrodemargomes@gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20251028131945.26445-2-pedrodemargomes@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 28.10.25 14:19, Pedro Demarchi Gomes wrote:
> This reverts commit e317a8d8b4f600fc7ec9725e26417030ee594f52 and changes
> PageKsm(page) to folio_test_ksm(page_folio(page)).
> 
> This reverts break_ksm() to use walk_page_range_vma() instead of
> folio_walk_start().
> This will make it easier to later modify break_ksm() to perform a proper
> range walk.
> 
> Suggested-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Pedro Demarchi Gomes <pedrodemargomes@gmail.com>
> ---
>   mm/ksm.c | 63 ++++++++++++++++++++++++++++++++++++++++++--------------
>   1 file changed, 47 insertions(+), 16 deletions(-)
> 
> diff --git a/mm/ksm.c b/mm/ksm.c
> index 4f672f4f2140..2a9a7fd4c777 100644
> --- a/mm/ksm.c
> +++ b/mm/ksm.c
> @@ -607,6 +607,47 @@ static inline bool ksm_test_exit(struct mm_struct *mm)
>   	return atomic_read(&mm->mm_users) == 0;
>   }
>   
> +static int break_ksm_pmd_entry(pmd_t *pmd, unsigned long addr, unsigned long next,
> +			struct mm_walk *walk)
> +{
> +	struct page *page = NULL;
> +	spinlock_t *ptl;
> +	pte_t *pte;
> +	pte_t ptent;
> +	int ret;
> +
> +	pte = pte_offset_map_lock(walk->mm, pmd, addr, &ptl);
> +	if (!pte)
> +		return 0;
> +	ptent = ptep_get(pte);
> +	if (pte_present(ptent)) {
> +		page = vm_normal_page(walk->vma, addr, ptent);

folio = vm_normal_folio()

> +	} else if (!pte_none(ptent)) {
> +		swp_entry_t entry = pte_to_swp_entry(ptent);
> +
> +		/*
> +		 * As KSM pages remain KSM pages until freed, no need to wait
> +		 * here for migration to end.
> +		 */
> +		if (is_migration_entry(entry))
> +			page = pfn_swap_entry_to_page(entry);

folio = pfn_swap_entry_folio()

> +	}
> +	/* return 1 if the page is an normal ksm page or KSM-placed zero page */
> +	ret = (page && folio_test_ksm(page_folio(page))) || is_ksm_zero_pte(ptent);


The you can directly work with folios here.

-- 
Cheers

David / dhildenb


