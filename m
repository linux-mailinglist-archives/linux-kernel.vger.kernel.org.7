Return-Path: <linux-kernel+bounces-808018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 02617B4AC31
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 13:34:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A40317CB6C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 11:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39B33322531;
	Tue,  9 Sep 2025 11:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Snwcb7LZ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1EC4307ADA
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 11:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757417615; cv=none; b=WbzKyex5Y9Uk0yeXA0CvKX32qymFqiDPOnAvQyDNJl0xW4R2Njk0g0UmB0fdJc3Wqq3Yxl09qJkaEUYfE/JyGNv/J7fLyFnH5OpUaBybBbaYZgdXMz/hgWqNT9WAZbof7rbIkeClbc4eIkkWh0gY+3IOAEvXM/8FDPzYuRZLewM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757417615; c=relaxed/simple;
	bh=hfjOf1xnOafjLKZGlDUsXNrnNe7qC7dNOx1DXK6K3/4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kBGgRLs248ydX+MehPVgP7aW3ESbbR8LTcjuR9nEYwYh8S9tj0StZxvebEpXSYAgL+G8t2wnAukpuPFvW3R+l5e7kU/j6rz1e5ZH+axV4ouLuaFDEZN8caT7/BYPKgPwGCL1ZTji5W1QtaZwcbFfzC5RqCkHMJj+LyuLw9QwYno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Snwcb7LZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757417612;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=xE/Vu2E3p05NICS6N69pIOlWlxRgE7pJHsYgsRXCNRE=;
	b=Snwcb7LZUsDltsk38T9uUOKI6uopGGTHOXS5CcFaiwAr0zQyUXizh9XJX5t0mA0XVo93pP
	49Uwdvnh41K1HcdghaTHWkPYEhV4LDslJBenJM/0Yk89GgikyvuvWT+0BupfnBEoemFiXX
	Lq4ncpVMMBUR3LVmXrJOsB3CRN7dyP8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-C-xsB75rMK-8b3-bRTuleQ-1; Tue, 09 Sep 2025 07:33:31 -0400
X-MC-Unique: C-xsB75rMK-8b3-bRTuleQ-1
X-Mimecast-MFC-AGG-ID: C-xsB75rMK-8b3-bRTuleQ_1757417610
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-45b9a856d58so44294055e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 04:33:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757417610; x=1758022410;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xE/Vu2E3p05NICS6N69pIOlWlxRgE7pJHsYgsRXCNRE=;
        b=Qh3zhzUoTW8Mel9qhFvXgv1Lenqq9eX7TXKCLE5jVrCl1tpIiI8BrL+7/37TUgo15H
         AsA6UfsZTN7S1Z2uMzcCahhKcnyWYhsK5sjfRXyEN3iM1zipadAAn/znX1U6g+bVtHKk
         RA3+sAFlv5FICmddQXU22DDjs7iV/cjflaJxJj31Sln2pG++SbEzbidTfioWbKoyEsz1
         ulV1w6gydy1/1cMHtVDE4bVG6QmhF3K1Hzhm+VOuz56T5pjMEj57dT+pPyelwlNpzhpT
         JuImN+Q7AK5EAglaGQlRZlW4PheXF15uQSfOHB/GpicelmpTTOewTg7q76NCTx7fI/KA
         ggRA==
X-Forwarded-Encrypted: i=1; AJvYcCUSRGhvs2ltTV9vATeWuedAul/1glNoysbb7oZGEAF05VwPMXgSbDJ7aDO8fK9SqTiAdI9Pi7TyLHvxl+w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcBCzuk7j8LBtQAe8JLyBZihYqGDLGU9RsalDXtWjnXvLaLbg0
	Bv1/zSpvs8EZmJkKyxGqRGgLfppC07o5cypFICHooj6hiOcQXatHCyafkkcpRBLTyIGKzAHRZQ+
	Pb37SXAA05LU+t5xmEycukykhWxlnBjRYBAo1yAczklO+ut8iE3oLk5rjNjli7XigLA==
X-Gm-Gg: ASbGncv2en/+CHc5tvILHk9NcGVqPFB+bKNMoWRZ09imFJPbJlGryXtk+wqKjqpx4Hj
	K3CaoO5bbraJygSt/N05PNlFdsTXCQnilALDfteA7Zm86KeqySPTHdJBxnoE7KkTm2xXCtQF+53
	sfxtdK7tJC2OIdOYpVKLFFkZfsQbwpv6AuUGRmdH1yFFQ1acFeWgLVEc0sgIgwv4W2baen2hoOm
	Cl7UdgTsdGDL5R3yt4wTemE6nI0830/ZxuAfn8D3/5Op4O87EzNu0P+2dwX1UgjaJMzq/sZUkXJ
	VzGiFoJGJevt+PQVeOroDJznPXP7HsCmpYcqhFM75X7ijuJT6S+r8bcDBnWH0Y2ZsYGEkA==
X-Received: by 2002:a05:600c:1f87:b0:45c:17a:4c98 with SMTP id 5b1f17b1804b1-45dddebfab9mr99866035e9.19.1757417609743;
        Tue, 09 Sep 2025 04:33:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHBiBNYEQvS/i0JuqrW/UpaZO5yE2t7qOVdFFOzhd4nnV0hELSzpufBxKXQ1HQk90HyJp0cmw==
X-Received: by 2002:a05:600c:1f87:b0:45c:17a:4c98 with SMTP id 5b1f17b1804b1-45dddebfab9mr99865655e9.19.1757417609218;
        Tue, 09 Sep 2025 04:33:29 -0700 (PDT)
Received: from [192.168.3.141] (p57a1a41f.dip0.t-ipconnect.de. [87.161.164.31])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e75224bc2csm2256196f8f.54.2025.09.09.04.33.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Sep 2025 04:33:28 -0700 (PDT)
Message-ID: <0e410c31-62fe-4145-8e8c-31fb0d4d1326@redhat.com>
Date: Tue, 9 Sep 2025 13:33:26 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/6] mm/gup: local lru_add_drain() to avoid
 lru_add_drain_all()
To: Kiryl Shutsemau <kirill@shutemov.name>
Cc: Hugh Dickins <hughd@google.com>, Andrew Morton
 <akpm@linux-foundation.org>, Alexander Krabler <Alexander.Krabler@kuka.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
 Axel Rasmussen <axelrasmussen@google.com>, Chris Li <chrisl@kernel.org>,
 Christoph Hellwig <hch@infradead.org>, Frederick Mayle <fmayle@google.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Johannes Weiner <hannes@cmpxchg.org>,
 John Hubbard <jhubbard@nvidia.com>, Keir Fraser <keirf@google.com>,
 Konstantin Khlebnikov <koct9i@gmail.com>, Li Zhe <lizhe.67@bytedance.com>,
 Matthew Wilcox <willy@infradead.org>, Peter Xu <peterx@redhat.com>,
 Rik van Riel <riel@surriel.com>, Shivank Garg <shivankg@amd.com>,
 Vlastimil Babka <vbabka@suse.cz>, Wei Xu <weixugc@google.com>,
 Will Deacon <will@kernel.org>, yangge <yangge1116@126.com>,
 Yuanchu Xie <yuanchu@google.com>, Yu Zhao <yuzhao@google.com>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <41395944-b0e3-c3ac-d648-8ddd70451d28@google.com>
 <66f2751f-283e-816d-9530-765db7edc465@google.com>
 <ebaeb8d9-0b22-4304-9dba-40d37d82e369@redhat.com>
 <bq6mehuumf5gmf5tnm5jo3iiglqtn4yo3owkxhdddnkejd46jv@4hax34dkkzds>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <bq6mehuumf5gmf5tnm5jo3iiglqtn4yo3owkxhdddnkejd46jv@4hax34dkkzds>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 09.09.25 12:52, Kiryl Shutsemau wrote:
> On Tue, Sep 09, 2025 at 09:56:30AM +0200, David Hildenbrand wrote:
>> On 09.09.25 00:16, Hugh Dickins wrote:
>>> In many cases, if collect_longterm_unpinnable_folios() does need to
>>> drain the LRU cache to release a reference, the cache in question is
>>> on this same CPU, and much more efficiently drained by a preliminary
>>> local lru_add_drain(), than the later cross-CPU lru_add_drain_all().
>>>
>>> Marked for stable, to counter the increase in lru_add_drain_all()s
>>> from "mm/gup: check ref_count instead of lru before migration".
>>> Note for clean backports: can take 6.16 commit a03db236aebf ("gup:
>>> optimize longterm pin_user_pages() for large folio") first.
>>>
>>> Signed-off-by: Hugh Dickins <hughd@google.com>
>>> Cc: <stable@vger.kernel.org>
>>> ---
>>>    mm/gup.c | 15 +++++++++++----
>>>    1 file changed, 11 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/mm/gup.c b/mm/gup.c
>>> index 82aec6443c0a..b47066a54f52 100644
>>> --- a/mm/gup.c
>>> +++ b/mm/gup.c
>>> @@ -2287,8 +2287,8 @@ static unsigned long collect_longterm_unpinnable_folios(
>>>    		struct pages_or_folios *pofs)
>>>    {
>>>    	unsigned long collected = 0;
>>> -	bool drain_allow = true;
>>>    	struct folio *folio;
>>> +	int drained = 0;
>>>    	long i = 0;
>>>    	for (folio = pofs_get_folio(pofs, i); folio;
>>> @@ -2307,10 +2307,17 @@ static unsigned long collect_longterm_unpinnable_folios(
>>>    			continue;
>>>    		}
>>> -		if (drain_allow && folio_ref_count(folio) !=
>>> -				   folio_expected_ref_count(folio) + 1) {
>>> +		if (drained == 0 &&
>>> +				folio_ref_count(folio) !=
>>> +				folio_expected_ref_count(folio) + 1) {
>>
>> I would just have indented this as follows:
>>
>> 		if (drained == 0 &&
>> 		    folio_ref_count(folio) != folio_expected_ref_count(folio) + 1) {
> 
> Do we want folio_check_expected_ref_count(folio, offset)?

Not sure, if so outside of this patch series to also cover the other 
handful of cases.

	folio_has_unexpected_refs(folio, offset)

Would probably be clearer.

-- 
Cheers

David / dhildenb


