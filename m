Return-Path: <linux-kernel+bounces-785076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A19C9B34588
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 17:20:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09E693AD224
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 15:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FC5A2FE049;
	Mon, 25 Aug 2025 15:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CINF72oH"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45695217705
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 15:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756135154; cv=none; b=XZv6PDju4x9aaZH2ASiza06W/s4U4T7M70Lwj7tvql/mxvYksIGEIehPvkKDdeq8DZkZfHu0SmBHzbVUfdR+kT3/7T24pGqbDnWKfu9sg4JCJAvBYjSDd1E8NpbFrWNR/TGsvrzu1mtG04piIwLpKxg1GRG3WrCpqmlEl0vEbuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756135154; c=relaxed/simple;
	bh=KPwlyLK21cGKDGSckK6VsH2QynNnJtplwMtkOmcmZms=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DLma4k2xOyRDYcY5Ia7HyRTS8+oqEpUk0kYVyw2okmSURzhQ+6N2l3RsZrmh6hnblwciAcXAcC6y98w0WiNyDwFXYgNHHofMWalRzPyPy/LaGBN0wW1QQxvkem1YvUWYZQtFmyn8tvuSLBCbjxcEkSqB/L87kAEauS0uvHOA4hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CINF72oH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756135151;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=+8Qu0u/8VaalAB9h3u7E2OosCBBMleTFRkPyST5G7FQ=;
	b=CINF72oHWZtFzvwgxT36v7RGc9CxV5oiuIKXRgeOmM0BMwbikFC4SXzOdo3My4sBRqzRP0
	qoIx6jMiIdNJdkdN2tx/btlyDze3S7ZU0UJpa5q48buiegg09AK9/39l9vhARRhSXjxoJb
	TklCbD41Ty/KGx4hlEpa0W5Q3GvpL0M=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-8YxGQowSMdStBGVSQF-4wQ-1; Mon, 25 Aug 2025 11:19:08 -0400
X-MC-Unique: 8YxGQowSMdStBGVSQF-4wQ-1
X-Mimecast-MFC-AGG-ID: 8YxGQowSMdStBGVSQF-4wQ_1756135148
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3b9edf5b346so1945763f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 08:19:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756135147; x=1756739947;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+8Qu0u/8VaalAB9h3u7E2OosCBBMleTFRkPyST5G7FQ=;
        b=cDujuS9+FaogRACiySkrabq/SwZQkCGcJGPi7AcQQ2EMiCe5gV/DJ+bJnElfCYiO6/
         F3SDUqS+8YkPy9eepgs2YXpQ4cGEBExBmuVGaBOYHDj7zMlbtzvKhn+FZxxk29P1lwNs
         aVNWFiUY8/4fo1i0uc2PcJ6v45diPxEs9sL91+G0KSlSheLYpDHWUdyKZp/tZAgorUp7
         4GczOCBWwXj4o1Ij7oqyU5MgfmgOHF702RsS18OMIFoxSkBM0788t9fr63jmtkLCqLEa
         U96DMoTfPvo49DkbV8oxgKpAffOac1aETWX+smIdPKO4Ny7xfudKoFQWjrpzRaimG7nB
         xg7A==
X-Forwarded-Encrypted: i=1; AJvYcCU23CxmavRUeFEfuMTqSqsohbmf+CXynO5XswN+y0S9DMggdwdtYkzybaSoffDwiObk/+EUjyoCkuoy3tE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz256ynjaFA/ziJwxlqIjFycyZFzLazgflwQ4oesi0/bPpczvVu
	Ld+bwT50PBGj1K/9dgP4OzWXD1s68IEUDjZy7+lBFRqErLW/p/srF7Q3InT+4XbYCCbONtiL/t9
	QAwleyI9Fw24p8/SlStf1vDfaC+csYhOFsXg0OP9sGvLwtcy9dv28TU8upWKfk2nAZA==
X-Gm-Gg: ASbGncupV+BsG+yfS6sxtotKLgMQjwXG63CdSR3dgagtWuKd+pVjiW+s/xLzn6fDclz
	U1jsziyZVcoDhLqcz8+SGLwr/S5cCKNbm5P7Pfedcel//C2gcwEvx46iy4wgNfuf9bmwiNt7HKZ
	Yq7V92SGAHsz6nqps8W9KL2vm1R4xCBd3GIQnBplQPlbfYMcHtGCOf1Z7mrTjtulE6ilqOZuAdP
	Lu1mLgTYsLZ7VmYi3wGq4AFptnDvDW1pocnbtvWnhAHBzd9Vu5jPN/4hmTUcZVummO2Rh0x82gM
	FPB628E8UuJz9Xul9D/Dj0S3dxNn6HYbLSqevWmgMAyJTzkC6vd/VF1i3H24WOhbIBxqdCcnZ5z
	c58k0fZ3VFK7F/01murrWtl3TD06iA4mL4w3xWp89UZdURZcVE2EwXi2kfIuOxuwqn0w=
X-Received: by 2002:a05:6000:18ad:b0:3b7:8892:ed8d with SMTP id ffacd0b85a97d-3c5da54ed40mr9321929f8f.6.1756135147607;
        Mon, 25 Aug 2025 08:19:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFmEeHLhPWiRsJMGTJgizh/SfTOdCkPcXSvkHli8LnUFicyIhY8gIYgsb1MvnwzeW9ZvuUg5g==
X-Received: by 2002:a05:6000:18ad:b0:3b7:8892:ed8d with SMTP id ffacd0b85a97d-3c5da54ed40mr9321902f8f.6.1756135147153;
        Mon, 25 Aug 2025 08:19:07 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f4f:1300:42f1:98e5:ddf8:3a76? (p200300d82f4f130042f198e5ddf83a76.dip0.t-ipconnect.de. [2003:d8:2f4f:1300:42f1:98e5:ddf8:3a76])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ca6240b4e1sm2156715f8f.21.2025.08.25.08.19.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Aug 2025 08:19:06 -0700 (PDT)
Message-ID: <dc92aef8-757f-4432-923e-70d92d13fb37@redhat.com>
Date: Mon, 25 Aug 2025 17:19:05 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [DISCUSSION] Unconditionally lock folios when calling rmap_walk()
To: Lokesh Gidra <lokeshgidra@google.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Harry Yoo <harry.yoo@oracle.com>, Zi Yan <ziy@nvidia.com>,
 Barry Song <21cnbao@gmail.com>,
 "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
 Peter Xu <peterx@redhat.com>, Suren Baghdasaryan <surenb@google.com>,
 Kalesh Singh <kaleshsingh@google.com>, android-mm <android-mm@google.com>,
 linux-kernel <linux-kernel@vger.kernel.org>, Jann Horn <jannh@google.com>,
 Rik van Riel <riel@surriel.com>, Vlastimil Babka <vbabka@suse.cz>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>
References: <CA+EESO4Z6wtX7ZMdDHQRe5jAAS_bQ-POq5+4aDx5jh2DvY6UHg@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <CA+EESO4Z6wtX7ZMdDHQRe5jAAS_bQ-POq5+4aDx5jh2DvY6UHg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 22.08.25 19:29, Lokesh Gidra wrote:
> Hi all,
> 
> Currently, some callers of rmap_walk() conditionally avoid try-locking
> non-ksm anon folios. This necessitates serialization through anon_vma
> write-lock elsewhere when folio->mapping and/or folio->index (fields
> involved in rmap_walk()) are to be updated. This hurts scalability due
> to coarse granularity of the lock. For instance, when multiple threads
> invoke userfaultfd’s MOVE ioctl simultaneously to move distinct pages
> from the same src VMA, they all contend for the corresponding
> anon_vma’s lock. Field traces for arm64 android devices reveal over
> 30ms of uninterruptible sleep in the main UI thread, leading to janky
> user interactions.
> 
> Among all rmap_walk() callers that don’t lock anon folios,
> folio_referenced() is the most critical (others are
> page_idle_clear_pte_refs(), damon_folio_young(), and
> damon_folio_mkold()). The relevant code in folio_referenced() is:
> 
> if (!is_locked && (!folio_test_anon(folio) || folio_test_ksm(folio))) {
>          we_locked = folio_trylock(folio);
>          if (!we_locked)
>                  return 1;
> }
> 
> It’s unclear why locking anon_vma exclusively (when updating
> folio->mapping, like in uffd MOVE) is beneficial over walking rmap
> with folio locked. It’s in the reclaim path, so should not be a
> critical path that necessitates some special treatment, unless I’m
> missing something.
> 
> Therefore, I propose simplifying the locking mechanism by ensuring the
> folio is locked before calling rmap_walk().

Essentially, what you mean is roughly:

diff --git a/mm/rmap.c b/mm/rmap.c
index 34333ae3bd80f..0800e73c0796e 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1005,7 +1005,7 @@ int folio_referenced(struct folio *folio, int is_locked,
         if (!folio_raw_mapping(folio))
                 return 0;
  
-       if (!is_locked && (!folio_test_anon(folio) || folio_test_ksm(folio))) {
+       if (!is_locked) {
                 we_locked = folio_trylock(folio);
                 if (!we_locked)
                         return 1;


The downside of that change is that ordinary (!ksm) folios will observe being locked
when we are actually only trying to asses if they were referenced.

Does it matter?

I can only speculate that it might have been very relevant before
6c287605fd56 ("mm: remember exclusively mapped anonymous pages with PG_anon_exclusive").

Essentially any R/O fault would have resulted in us copying the page, simply because
there is concurrent folio_referenced() happening.

Before 09854ba94c6a ("mm: do_wp_page() simplification") that wasn't an issue, but
it would have meant that the write fault would be stuck until folio_referenced()
would be done, which is also suboptimal.

So likely, avoiding grabbing the folio lock was beneficial.


Today, this would only affect R/O pages after fork (PageAnonExclusive not set).


Staring at shrink_active_list()->folio_referenced(), we isolate the folio first
(grabbing reference+clearing LRU), so do_wp_page()->wp_can_reuse_anon_folio()
would already refuse to reuse immediately, because it would spot a raised reference.
The folio lock does not make a difference anymore.


Is there any other anon-specific (!ksm) folio locking? Nothing exciting comes to mind,
except maybe some folio splitting or khugepaged that maybe would have to wait.

But khugepaged would already also fail to isolate these folios, so probably it's not that
relevant anymore ...

-- 
Cheers

David / dhildenb


