Return-Path: <linux-kernel+bounces-861690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EFEFBBF35D1
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 22:18:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 966B2408497
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 20:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B2C22BEFF6;
	Mon, 20 Oct 2025 20:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DsVFQ66B"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F0942E11C6
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 20:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760991471; cv=none; b=gleavcKSoWWKKsIsfn6DqOE50VsrJuC2d7hbaWwtIpVXc+ZL71AuKieWzTf1o9Yv2Nshx4/1NfJjSZgfawPaKh9HVIXrCHb3mrnDRyDphkXtaR5zk2WRmyEJ1Sou4o6Fe/sQsJkMG/zZK+JJekfzqJlsNNI9jdjS0fwrBeBYMEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760991471; c=relaxed/simple;
	bh=B1SvTDscgWZ89+7lxg7U+zoQH0vLz+aMzJmXj4Etyoc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VkkFxJrG0uorCD8tTmF2Nv0nqRcfIuzeBmfpmj9G5G7ebernNIOONL6XvXCl0MAxqmI9LLTC1mw6IE7I26iiBC51C7awo55bFaIcm5+TMZV1zxcqm45sD4tqrObxECN36KVWn9DKoePK+es3G+9SRcoyGrgNu6Am/2YN1neT84o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DsVFQ66B; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760991467;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=/LsX7IYRgEtN8RM3fhERLxAXUAVS6aaKh4QVGEYl6rU=;
	b=DsVFQ66BvVsSOmNNIVoHEvy9jYiPBoZe8wlUqeWXrOf66ZzgRyAb9mH8TfRKybhXFWM7fq
	jTj9iC7eX1ywpL9MrD25F4qnVEm16FW9DflUFSyyPXezoCHI2mc+qhpsjzTNTt9kXg9DJe
	71uChHxGE/1EKx9Xj+MYEOlwQV4htoo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-282-eJPiI1R1OAar42ECrm-tFA-1; Mon, 20 Oct 2025 16:17:46 -0400
X-MC-Unique: eJPiI1R1OAar42ECrm-tFA-1
X-Mimecast-MFC-AGG-ID: eJPiI1R1OAar42ECrm-tFA_1760991465
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3f7b5c27d41so2856240f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 13:17:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760991465; x=1761596265;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/LsX7IYRgEtN8RM3fhERLxAXUAVS6aaKh4QVGEYl6rU=;
        b=Ov6wSLjUOGcB4OdklD0k1aXZhGvsZZjoBACb14T1wqVUGEhvD26QN6SEI13bdWxsuh
         MElPjOutr2+q8sesLv854IreSqtpp3x3DgDQ45RFKugynQb3AaABN3UCr/9IIYGkOe4F
         B017OA71ii0f8JiddOJRjJsiRtJFbZEWHISREQEeRI2rpT/wqMtxxHmBdYHMpOB+hsR6
         q0/WhdE0tNZz+f4mtZIQL/Mk0DB9xEVSfEccjIFKy5cBZczneLvMDIcWf62f0i92RqZ3
         E8nKx1ZeV8DOj1lrdCVYgMuY+hNZZWve1FnS5aVxPI3V+3Oj8AaZg9RqWGax/dXEdff5
         jiWg==
X-Forwarded-Encrypted: i=1; AJvYcCUm+27Qa/wBkykY95M2rdZB+kiPEUFeI/6JmVP1uNice93Usj472ucCov/mNKB1mYqlYl+OXdj4sK7dNIw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOq59e2shL86ED+8TgxiP29lArwP9qcKqqCkp+WJ39eRaiNDgD
	v2kyMOyvDivq4K3sbCvdN2VwD+MKXZRCaXH8K/g+e4YmsmLxPYXqhl+E+uBmeIgbh5gKUOr9Pex
	xTYUhX83+KW3fQeZxynZn1sXZ9s/XX47ow/N5QS2W7jXKmWyQ8H8YmQNpM34uVNhEww==
X-Gm-Gg: ASbGncsl69PAXVvFcR+bWX0zgwSL0sp++2hSpZW+wjiWpVHNRETmSBU2kFxzEzqhk99
	sAXcWrB7+laWL/YmAE0vwds/79dSmYkMMpUPZ6dBJY7Lg5yKS8a3/4CqglZnb59yvlQi3kWAQjw
	YK0+00sYlu4ZSPgZsfjezt6IU3mFeuMV6V4t8qeCAO82pH9QtJ+0X/B6hRcBrSiW+w1R7mpOk83
	0gao5s3LKCZhA/1Qa+UGiz//SM+xgkvM4aypl06ICdQBC/w07TzKF00RENSHF7OBJ38kiShCUv2
	3lwkAiJhLiA1I89raiTvv7y1wvpvS8SVaN1ZNLeygVQA6GrLv4isAIqhxs+D9zFqvzB9f5vojym
	g9N4+yAPTko/GLxb/DQo6JmZB7bay3nKJzsuVCRQ7lxjWuWrBQexgA15+3v9iIsuSYi/1p2fyE2
	tb1xaVFZccab0gOEKHLA58Tbs4VBw=
X-Received: by 2002:a05:6000:22c5:b0:3ee:1368:a921 with SMTP id ffacd0b85a97d-42704bf7238mr11374817f8f.28.1760991465005;
        Mon, 20 Oct 2025 13:17:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEuTyy6a9nphDhsuKGtPLcYJ1/Tp5XQ7o58XrEQGbeb6HrD9v7YC6cKG7PK+8bfVZuFDHicJA==
X-Received: by 2002:a05:6000:22c5:b0:3ee:1368:a921 with SMTP id ffacd0b85a97d-42704bf7238mr11374803f8f.28.1760991464565;
        Mon, 20 Oct 2025 13:17:44 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f0c:c200:fa4a:c4ff:1b32:21ce? (p200300d82f0cc200fa4ac4ff1b3221ce.dip0.t-ipconnect.de. [2003:d8:2f0c:c200:fa4a:c4ff:1b32:21ce])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427f00ce678sm17029551f8f.51.2025.10.20.13.17.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Oct 2025 13:17:44 -0700 (PDT)
Message-ID: <451b72a3-8052-4dfb-84e7-1e97c3388db0@redhat.com>
Date: Mon, 20 Oct 2025 22:17:42 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] page_alloc: allow migration of smaller hugepages
 during contig_alloc.
To: Gregory Price <gourry@gourry.net>
Cc: Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, kernel-team@meta.com,
 akpm@linux-foundation.org, vbabka@suse.cz, surenb@google.com,
 mhocko@suse.com, jackmanb@google.com, hannes@cmpxchg.org
References: <20251020170615.1000819-1-gourry@gourry.net>
 <487730c6-423a-4a03-a668-9b9ff92a5cfb@redhat.com>
 <aPZ0OKx_VnQ4H_w1@gourry-fedora-PF4VCD3F>
 <609E7E01-33A6-4931-AC89-1F4B2944FB64@nvidia.com>
 <272c425a-b191-4eef-af6e-2bca1db7a940@redhat.com>
 <aPaQNYsN_YPDOwQG@gourry-fedora-PF4VCD3F>
 <0d92a675-ab24-4b1c-be71-956f09a9e973@redhat.com>
 <aPaUZm0ZfIEW3gUr@gourry-fedora-PF4VCD3F>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <aPaUZm0ZfIEW3gUr@gourry-fedora-PF4VCD3F>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20.10.25 21:58, Gregory Price wrote:
> On Mon, Oct 20, 2025 at 09:46:21PM +0200, David Hildenbrand wrote:
>> On 20.10.25 21:40, Gregory Price wrote:
>>> On Mon, Oct 20, 2025 at 09:18:36PM +0200, David Hildenbrand wrote:
>>>>>
>>>>> Basically, what is the right way of checking a folio order without lock?
>>>>> Should we have a standardized helper function for that?
>>>>
>>>> As raised, snapshot_page() tries to stabilize the folio best it can.
>>>
>>> is snapshot_page() even worth it if we're already racing on flag checks?
>>
>> I think it tries to handle what compound_order() cannot easily handle, as it
>> will retry in case it detects an obvious race.
>>
>>>
>>> i.e. there's already a race condition between
>>>
>>> 	pfn_range_valid_contig(range) -> compaction(range)
>>
>> Can you elaborate how compaction comes into play here? I'm missing the
>> interaction.
>>
>> pfn_range_valid_contig() should be only called by alloc_contig_pages() and
>> not out of compaction context?
>>
> 
> I've been digging through the code a bit, so a quick shot from my notes
> 
> alloc_contig_pages_noprof
>    if (pfn_range_valid_contig(range))        <- check validity
>      __alloc_contig_pages(range)
>        alloc_contig_range_noprof(range)
>          start_isolate_page_range(range)     <- isolate
>          __alloc_contig_migrate_range(range)
>            isolate_migratepages_range(range) <- compact

Oh, that's what you mean with "compact", it's just isolation+migration.

> 
> Seems like all the checks done in pfn_range_valid_contig() already race
> with everything after it anyway since references aren't held?  Any of
> those pages could be freed (get bogus values), but i suppose not
> allocated (given the zone lock is held)?

Yes, it's completely racy.

I was primarily concerned about us calling functions that will 
VM_WARN_ON() etc due to the races; not that they would make us 
accept/jump over a range although we shouldn't.

Of course, regarding the latter, we want to try as good as possible to 
avoid jumping over ranges that we can actually handle.

-- 
Cheers

David / dhildenb


