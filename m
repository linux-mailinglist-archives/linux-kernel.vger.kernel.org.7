Return-Path: <linux-kernel+bounces-758298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3CDFB1CD50
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 22:16:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B791C3B9D79
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 20:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FC6C2BE7A6;
	Wed,  6 Aug 2025 20:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IGBWDV3K"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843D52BE64C
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 20:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754511288; cv=none; b=OX8PSKBLsR9vZ4DhfzpDflBqUsrQyNK6yJCUOnzeUNpQzADnif3vA8ugc8+xReT6uVUkhwc5Awz6PcrVtRYV+HITp8DGpw3sdHtomHu9Gh69AId9EOSaPN2xwADmO5yuPpSMECnV71XvZB5VQ72yQsmqi5wzudy2eiC4JSd8Or0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754511288; c=relaxed/simple;
	bh=NgXUl4YxXuF66+PoNM170cp1mBj+O8qZdlaedoWYNHw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ejYJqEMnge1/6nqUt0Xzcty8Nf7UOReKPUdk7f9zAwe5Dmx0kGJij1de5GSQxKXbIexNHMtLqKfVZcqh3I1KqFkTDesRt++kPShCajkyb4BlRgxUUfaBC6dL5Lr3yTUswh3yyE14j5o+/wy2qd626O2GF6P2y5ydF/qKLGQXNR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IGBWDV3K; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754511285;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=d5P3sES8n4ihLK1cm4EwCWnvXovipYsvkDDRkGH7Rt8=;
	b=IGBWDV3KuShD3n1w1IoeJfniyTqzgVSLnYaG12yBdHkJuwz4KczOYUYXtDMq78G1Qpa2OX
	y6hXHS2Tz11iojB/T/SgUyV89KpIYs7zfRkaGn2bYLTzVXXLA1irqDUaXVxUManD6aNDpR
	qw53AsPV65ncdlK1WRS/7EwRI9IPgp4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-41-xOmm69ofM8uCCYquF6-HWA-1; Wed, 06 Aug 2025 16:14:44 -0400
X-MC-Unique: xOmm69ofM8uCCYquF6-HWA-1
X-Mimecast-MFC-AGG-ID: xOmm69ofM8uCCYquF6-HWA_1754511283
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3b7806a620cso79990f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 13:14:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754511283; x=1755116083;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=d5P3sES8n4ihLK1cm4EwCWnvXovipYsvkDDRkGH7Rt8=;
        b=XKfFU/fq89q0cHawaAyStpqr0y6He8pqCqBkEUNe4zGmTck9unfTjY1zqA2WklThG+
         kngSVDFHv0s67K/x6STEUj8cu8i3x4Rpv6qWi4+pcslkS6RgZP11Y/rrh1sgs4OsOoCQ
         hXN61K+eJs5hjHyoz8mSMe+TqxD1I6GKdMbx0gr56sGfloprnEezUxD+BWgVAJhx+5rj
         6alXnmxkyTe4eCQ6JHJWETIGHzbgCcyVl+etwcumuKzAAk9i/H3Rlj0vGWBLLf+nnU3i
         wSO5o06Vy31uGkKiZOXUIw3QjHRVqt5kRy6nT96mqDwREcP7a7J2MSZEdywkKG8V+WuD
         6fFQ==
X-Forwarded-Encrypted: i=1; AJvYcCW1EPuV2hy7vozD4NADyoAnX0O+EZkgmdbGfY0Y+8y9vC6EyCl4+2Ccx1hxoCkbceTRWvP8KqNb5TCrFpM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3ymnVs4/gN8rE448vs4cSpfzXtEqnt0Ttn0JTME+sYK3U+k/a
	ll6y9ZSpcTsD7GKKrm55BG7AaToYgusnCmrDh8bprYxeCswy9dsWKxwipLI1kAIzpmhLFAJwIpB
	IYQB9/d6Ibyz7ILbQnsR43wcWcXO338xHnidh+/bz5bK9H+pLZ9PhThf4BxwOscxzjQ==
X-Gm-Gg: ASbGncsik8IHwv/4Vv4rOmIZszta8yDKvoWmmatJoxBol4gDZZRD5hIWEjOoykKe1aC
	js009tmLMQU18OScvOL8oqP+QERkgnCOSx9rupbBUAAxHQN1VnEHoJOXXcE7qJillCPJuTbMK8p
	VM7WMfU9KFUlF9HffyxHWMhQFyJslkNNndUlEjsQG9RIFG2qKb6IwtY87IAzsLwaqPlHEjIDtP3
	nm+TAhfyFHq0ws/bj9zIDuiTxm7YpaMo8fn9MYzQqEj2mwPnCakqDJaadfrSMTQOYZZyU+lw2x5
	v0CtsmWQF8LM1bTY9uhCG1yRh3J2iiI5KWztP9Gijz3hJCznTUEIT8UlxegzvQj5jb2Wc9cWa6q
	kxnJXV4Rl68PzsdTuRjt85eTOpKEjIfKxV5F/iXBWUhwXdXIlyZoJPMYDZixlB2SZZgI=
X-Received: by 2002:a05:6000:2388:b0:3b7:8146:4640 with SMTP id ffacd0b85a97d-3b8f9f79c9emr193999f8f.56.1754511282644;
        Wed, 06 Aug 2025 13:14:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHG0bY644qbBT42RA/yeTwcYjH2tuKmM7gFFv+ZX33Fj0TwtCMSS0ZQLo9cfyNEiDWpFtTRyg==
X-Received: by 2002:a05:6000:2388:b0:3b7:8146:4640 with SMTP id ffacd0b85a97d-3b8f9f79c9emr193986f8f.56.1754511282226;
        Wed, 06 Aug 2025 13:14:42 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f42:da00:badf:cc55:23d5:1679? (p200300d82f42da00badfcc5523d51679.dip0.t-ipconnect.de. [2003:d8:2f42:da00:badf:cc55:23d5:1679])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459c58ed0ecsm81898565e9.4.2025.08.06.13.14.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Aug 2025 13:14:41 -0700 (PDT)
Message-ID: <055a8a69-731d-43b8-887e-54d8718877cb@redhat.com>
Date: Wed, 6 Aug 2025 22:14:39 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2] mm/zswap: store <PAGE_SIZE compression failed page
 as-is
To: Nhat Pham <nphamcs@gmail.com>
Cc: SeongJae Park <sj@kernel.org>, "Liam R. Howlett"
 <Liam.Howlett@oracle.com>, Andrew Morton <akpm@linux-foundation.org>,
 Chengming Zhou <chengming.zhou@linux.dev>,
 Johannes Weiner <hannes@cmpxchg.org>, Jonathan Corbet <corbet@lwn.net>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Michal Hocko
 <mhocko@suse.com>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>,
 Yosry Ahmed <yosry.ahmed@linux.dev>, kernel-team@meta.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Takero Funaki <flintglass@gmail.com>
References: <20250805002954.1496-1-sj@kernel.org>
 <761a2899-6fd9-4bfe-aeaf-23bce0baa0f1@redhat.com>
 <CAKEwX=MVBJ+Okfsob4Z30_5Y4P8c2DWoS1dYN4dF5dgp4+CexA@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <CAKEwX=MVBJ+Okfsob4Z30_5Y4P8c2DWoS1dYN4dF5dgp4+CexA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 05.08.25 18:56, Nhat Pham wrote:
> On Tue, Aug 5, 2025 at 3:47 AM David Hildenbrand <david@redhat.com> wrote:
>>
>> On 05.08.25 02:29, SeongJae Park wrote:
>>> When zswap writeback is enabled and it fails compressing a given page,
>>> the page is swapped out to the backing swap device.  This behavior
>>> breaks the zswap's writeback LRU order, and hence users can experience
>>> unexpected latency spikes.  If the page is compressed without failure,
>>> but results in a size of PAGE_SIZE, the LRU order is kept, but the
>>> decompression overhead for loading the page back on the later access is
>>> unnecessary.
>>>
>>> Keep the LRU order and optimize unnecessary decompression overheads in
>>> the cases, by storing the original content in zpool as-is.
>>
>> Does this have any effect on the movability of the given page? IOW, does
>> page migration etc. still work when we store an ordinary page of an
>> shmem/anon folio here?
> 
> Good question. This depends on the backend allocator of zswap, but the
> only backend allocator remaining (zsmalloc) does implement page
> migration.

Right, but migration of these pages works completely different than 
folio migration.

But I think the part I was missing: we are still performing a copy to 
another page, it's just that we don't perform any compression.

So I guess *breaking* movability of folios is not a concern.

But yeah, whether these "as is" pages are movable or not is a good 
question as well -- in particular when zsmalloc supports page migration 
and the "as is" pages would not.

Maybe someone familiar with the code could shed a light on that.

-- 
Cheers,

David / dhildenb


