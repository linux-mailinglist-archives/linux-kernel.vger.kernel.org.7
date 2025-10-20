Return-Path: <linux-kernel+bounces-861424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26171BF2B0F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 19:24:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEB5D3A80BC
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 17:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 879DB302777;
	Mon, 20 Oct 2025 17:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="izzz8RtE"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1502256C7E
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 17:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760981053; cv=none; b=NjM47KgusscjKSedhD0je7Wpy8SU+zQlKS0xqee0B98EZsspNE1OmRIazYNgdFM+VEnBhsGhOA7tif9QFrNr6e1H37InXYc47r/VIk9j3yVE6fNuPYRPv7BXURsEDkHSZqRxv+et/qGS8MaWPTGlvsJD929kTdXkbDC5H1tehdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760981053; c=relaxed/simple;
	bh=v2lhZDr7mIypjFfh0/NA4nB9qNtL5qZkIVx1LJin3MY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o1C8daxikxjtGRvJZOu4/qtjvf7YilXwcvUqIPOy/DgFhtsn74tAHJhAJhcAfgRFPfdj6b2gg6D4SsaERvYYNfCG+vxSme41mR/ZDj0mYAVBCxs7rH3ASU4oAGalEgZA/JVFBXclqm+q7UFrkz62EECU+U27ek39I9jZVPLJ61Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=izzz8RtE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760981049;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=PkbmHRpDCxeDNyWG0JbMmVpVwZeYwoVX6o0X4ue/QI4=;
	b=izzz8RtEMuui9wDZ8EDGQzqfN7CMIZEptM08n0Ut1RKsn1657ri0zpeEh25f1QTZ6RI8Tf
	6QRWD3njsyYeVeBpaYq7ddox+3ih1o189hXJESABFiOcX9VMWjyvakHTYtMIrzXcnZqIJ7
	SNMuc0zln20AhqU6une06oLnB43eEGg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-65-CxTfr5rAM7OQNH7PxoG81Q-1; Mon, 20 Oct 2025 13:24:08 -0400
X-MC-Unique: CxTfr5rAM7OQNH7PxoG81Q-1
X-Mimecast-MFC-AGG-ID: CxTfr5rAM7OQNH7PxoG81Q_1760981047
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-470fd92ad57so98339925e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 10:24:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760981047; x=1761585847;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PkbmHRpDCxeDNyWG0JbMmVpVwZeYwoVX6o0X4ue/QI4=;
        b=OS900ZPRrqHs50aQhCQu7BVRCpAYUAjRPZa/2QEqGQMGIlLfQSUb2naq+bhUf6WCBN
         Nls4mVrHu4ofcjrjQItybiqUeFTBzx515vpbEWfuXL4ePJfcIh9cjQxLJAv5y15dhmn+
         7T8uXwschu2y67kM7iHFH+4K/mnHJbCVMFRoMmIlLpr4G9lnB+GJgH7wBts3ai364+m0
         sKqpWKCBKtNqnLM6CcGYlGUQVDJSq2FNOHkWtK7C2xEVbJm9Lf0VWKzR3qS4MX0ycZYD
         6wne/gmTWM/Duw77qc1S46Lbd60QfpUNupg6moWM6VRGkqwGObd+kWCds+C7B0p8El1/
         pSFw==
X-Gm-Message-State: AOJu0Yy7jJbx2eRJY4RPEt6GCHhKrRobVl5jpytCaHXKAnpoqfXhiAMk
	yt2m5xlAGPfVh8vfpp/GKG+oDazUivN8xVPUdWSg2sCay/je3G4x0XwJvMqFxKYztSqZeZ8EP2m
	qrn/OtJ6m6jb1kCwvzrlA4GcjxBZGEENFfwpAX0VTZjiwNDy8UpzvxnL4T9E+Im/rbQI+zIhHAg
	==
X-Gm-Gg: ASbGncsK52Fdm7euP7zkt6mc+z182Llc930NVmcQefVqpLhUcmhwtr8dj7Ezxc2oaly
	X91U5NTE+xXl9TuvNUTI1wAcKv1vUePfDDx88H629jQxWQMjtOPU175ZX71m5gjyXYVAIZcq6Wo
	WOcEzcbBJZchpfzz0Ljp1PB25ur4+wa+htylRfZ+W4E3R5Ed6o195JyOkwLtlG+Y9vPQn3Dy+rk
	MsWFkQGmirraNBcPXSs22MC5jkUwqpJ85nQmSCvdNEeo7U2+JK95AhKI76TeQ9x65gsb+kFMhCH
	EvD74tsL5Do3uk0uTM2v2wKMPnAfj5a2OnI+EMD5qhx8tfjAhaH35XWLUKvx/jy15PGAakfF/c3
	2CJidJjT+FuJteB+xy/OdAGGvzNYpF9W2Drm7lAhrdXkd9pj7SfjwZpC1HhpObRZu1FdEyyJZGj
	ReDdsKZgGne1Im9ZVG8OKQmj6YZxk=
X-Received: by 2002:a05:6000:26d2:b0:3e6:f91e:fa72 with SMTP id ffacd0b85a97d-42704d83dfdmr8237935f8f.7.1760981046800;
        Mon, 20 Oct 2025 10:24:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEtZi7BkIMkMcjZVLDSYdQKUlTpcWMTz2FEi6s+HPJefynVtdLFdvUqgsu8TTNfqXt1CY23BA==
X-Received: by 2002:a05:6000:26d2:b0:3e6:f91e:fa72 with SMTP id ffacd0b85a97d-42704d83dfdmr8237917f8f.7.1760981046415;
        Mon, 20 Oct 2025 10:24:06 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f0c:c200:fa4a:c4ff:1b32:21ce? (p200300d82f0cc200fa4ac4ff1b3221ce.dip0.t-ipconnect.de. [2003:d8:2f0c:c200:fa4a:c4ff:1b32:21ce])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47154d3843csm154741245e9.11.2025.10.20.10.24.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Oct 2025 10:24:05 -0700 (PDT)
Message-ID: <487730c6-423a-4a03-a668-9b9ff92a5cfb@redhat.com>
Date: Mon, 20 Oct 2025 19:24:04 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] page_alloc: allow migration of smaller hugepages
 during contig_alloc.
To: Gregory Price <gourry@gourry.net>, linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com,
 akpm@linux-foundation.org, vbabka@suse.cz, surenb@google.com,
 mhocko@suse.com, jackmanb@google.com, hannes@cmpxchg.org, ziy@nvidia.com
References: <20251020170615.1000819-1-gourry@gourry.net>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20251020170615.1000819-1-gourry@gourry.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20.10.25 19:06, Gregory Price wrote:
> We presently skip regions with hugepages entirely when trying to do
> contiguous page allocation.  Instead, if hugepage migration is enabled,
> consider regions with hugepages smaller than the target contiguous
> allocation request as valid targets for allocation.
> 
> Compaction `isolate_migrate_pages_block()` already expects requests
> with hugepages to originate from alloc_contig, and hugetlb code also
> does a migratable check when isolating in `folio_isolate_hugetlb()`.
> 
> We add the migration check here to avoid calling compaction on a
> region if we know migration is not possible at all.
> 
> Suggested-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Gregory Price <gourry@gourry.net>
> ---
>   mm/page_alloc.c | 10 ++++++++--
>   1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 600d9e981c23..e0760eafe032 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -7048,8 +7048,14 @@ static bool pfn_range_valid_contig(struct zone *z, unsigned long start_pfn,
>   		if (PageReserved(page))
>   			return false;
>   
> -		if (PageHuge(page))
> -			return false;
> +		if (PageHuge(page)) {
> +			struct folio *folio = page_folio(page);
> +
> +			/* Don't consider moving same size/larger pages */
> +			if (!folio_test_hugetlb_migratable(folio) ||
> +			    (1 << folio_order(folio) >= nr_pages))

We have folio_nr_pages().

Do we really need the folio_hugetlb_migratable() check?

> +				return false;

This code is completely racy. folio_nr_pages() should be fine AFAIKT (no 
VM_WARN_ON() etc), not sure about folio_test_hugetlb_migratable().

If it becomes a problem we could do a snapshot_page() to take a snapshot 
we can query.

-- 
Cheers

David / dhildenb


