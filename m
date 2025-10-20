Return-Path: <linux-kernel+bounces-861001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E0378BF18CE
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 15:35:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 37B0D4F51E7
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 13:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51B5031986D;
	Mon, 20 Oct 2025 13:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XPYm/EvP"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D74923191CF
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 13:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760967296; cv=none; b=CPjJCUUoZiDQAwUNuwZ8ChjDDr5qDP49i7fh3lgjqswWBOuoZFpMh6KIryRy1tYghN4Q1FQWHj+SyybiduUZ2DVj6QaHfztrlWIKXu6i32ba4tL1kISZBlUw9m1Yk9t8pn+G7ch9n3K4K0e18ZJaq6v3ER74DzuHDMjP3kdy77A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760967296; c=relaxed/simple;
	bh=GIxGCdyAY56qMqKN9UC8yZm2LRHPKf+ZZlh1KifKFcY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i1NYI0SsEOj8YhmtwFqglXi3HSmvM00QcFYXAc44uLu0ZSwGQZX2qJBsXoqz8+3AKc7aOpBgUgvFvcArvuKu+45IB3IWNLxNAeg+b2EE8/Rm0oEpXdCy5TD6IHa5j3eKYHSUzobvT3RXRiEMYype+NAoc0ERizL7CuUKfPDN5V8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XPYm/EvP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760967293;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=i9ioeJHZmUdCr0Up9JCTGVq2r6uGNXm2isBNF4LcOWY=;
	b=XPYm/EvPTSEZv3ZO5vhARBnhAifKigpLbEIZ5+gPB+H8edzmN6zEj6Qe4VX1sc0gSbYdbX
	lu8zKZyeQyiYTok2f9QZucJslqcfVtntLq/uiIthJF6+fEjljMsxn6MpvKkzTVfL5iTK2V
	5RYHvvab1mwu/fEzK0XKok4M5XQhHhg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-204--RFziciYNqOkcna7i1PScw-1; Mon, 20 Oct 2025 09:34:51 -0400
X-MC-Unique: -RFziciYNqOkcna7i1PScw-1
X-Mimecast-MFC-AGG-ID: -RFziciYNqOkcna7i1PScw_1760967290
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-47113dcc1e0so36952085e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 06:34:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760967290; x=1761572090;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i9ioeJHZmUdCr0Up9JCTGVq2r6uGNXm2isBNF4LcOWY=;
        b=OjhZsGMtsLwq8owJ/cS/G2+x8E7yoMa3MmFmBuAG2qor/RWG2Ax4wLZIczAeURdefR
         EL3g2fpxJGJbDZQp1gsi0SUaX3EsOExXLBvAAhOd28nY2PsYL6ZsrD2lcm+kZK9VU5BA
         W9bBWuXBbTiOhCQxp6dNvSys0ie9e+i61O/cdQEVZl6/RMXKbj1ytTHrzYKaUDGrwPEY
         86AOwNDf9ib/RMUx1V7xQaMSMbMYwUInxYsgdWzDXZUjoHnU6bDKVgB8DCOg3Muk1Avo
         IKvIRcCauBPwo3w7Y6HHwny/N6Vj5lzW5jjEpfhhLQ3IEpbQBIpC5igJ2ep9Uj2WN9iG
         F79A==
X-Forwarded-Encrypted: i=1; AJvYcCUAWgR7Uo1qnIRkEAc+tBjRhU4LFAJR8Y+a5inkxFC0ISHHfcYKdrAVrmRT0lsla4sjGAIHnvz3pN8VIdY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaNE0uivhOtX+pYSeEsRF40TghSWTY1j38LjX/RnbUzEVolLUD
	NeHagJLRAAX6I1Zu89Y964n0ywVdnwxhgc8eTPrTPlyq2XXLSgiWKU1LelYXjpXUdEM5NXVz08C
	/mSPpitpwRn2Sk4SBm1hx8IPjJImI1ItSLMpxwp+N1qK2DRCHpDoospty7aHGPJGtWg==
X-Gm-Gg: ASbGncvpwCXfe9RlBgxZkwS47BAcQHIuWLhJr81k96TTKrY+0Gf9Xl+L/lWRo3JSeL3
	Xe83MROl+ShxZHIx1ltX39NN1Bv01TP1Y7JOb1M4dl/3sQNLxo0l+48BP2Grp9GccCEIm6S+PKi
	M9FFMO08xCiABNK8E4upsLwQCQO1KeR24R/zMohppO8RipbV44l9T2IFOr+JVZ17OUdAiz31Djl
	7MZprAE/u2ownb3PNx20YaNefwIRCbg8kBc/WdzpiH7W7qLT/86Ka6HAZsOx6mWc8jAuJcnIl0H
	hQVtTzd4uU5yAat4Zg4UX2Afw7/9fPVV5xm6XPzAAFNLg4/tcFvk6eScyx6n+XJF3ImkEvOMe+m
	dBlbgn5Fn8jkVwds6IRmbbubdVIK8Go1MNlDHVe7YyOhmEYxmpP20mpNiFf/rQtAnxmjcDYfxLa
	7DFMsF/Kz61dph6ndIP85BlTDyvJI=
X-Received: by 2002:a05:600c:3541:b0:46d:a04:50c6 with SMTP id 5b1f17b1804b1-4711791934dmr98877705e9.30.1760967290265;
        Mon, 20 Oct 2025 06:34:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFl1/eNGm+pkiPJ5iIQz2LUlBYM8XYMBsULDIjBA6gJeGNAM+fjBYKRlveufT3QXgRvz7K5Hg==
X-Received: by 2002:a05:600c:3541:b0:46d:a04:50c6 with SMTP id 5b1f17b1804b1-4711791934dmr98877285e9.30.1760967289770;
        Mon, 20 Oct 2025 06:34:49 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f0c:c200:fa4a:c4ff:1b32:21ce? (p200300d82f0cc200fa4ac4ff1b3221ce.dip0.t-ipconnect.de. [2003:d8:2f0c:c200:fa4a:c4ff:1b32:21ce])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427f00ce06bsm15128904f8f.45.2025.10.20.06.34.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Oct 2025 06:34:49 -0700 (PDT)
Message-ID: <78424672-065c-47fc-ba76-c5a866dcdc98@redhat.com>
Date: Mon, 20 Oct 2025 15:34:47 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/4] mm/userfaultfd: modulize memory types
To: Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
Cc: Mike Rapoport <rppt@kernel.org>, Muchun Song <muchun.song@linux.dev>,
 Nikita Kalyazin <kalyazin@amazon.com>, Vlastimil Babka <vbabka@suse.cz>,
 Axel Rasmussen <axelrasmussen@google.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 James Houghton <jthoughton@google.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Hugh Dickins
 <hughd@google.com>, Michal Hocko <mhocko@suse.com>,
 Ujwal Kundur <ujwal.kundur@gmail.com>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Oscar Salvador <osalvador@suse.de>, Suren Baghdasaryan <surenb@google.com>,
 Andrea Arcangeli <aarcange@redhat.com>
References: <20251014231501.2301398-1-peterx@redhat.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20251014231501.2301398-1-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15.10.25 01:14, Peter Xu wrote:
> [based on latest akpm/mm-new of Oct 14th, commit 36c6c5ce1b275]
> 
> v4:
> - Some cleanups within vma_can_userfault() [David]
> - Rename uffd_get_folio() to minor_get_folio() [David]
> - Remove uffd_features in vm_uffd_ops, deduce it from supported ioctls [David]
> 
> v1: https://lore.kernel.org/r/20250620190342.1780170-1-peterx@redhat.com
> v2: https://lore.kernel.org/r/20250627154655.2085903-1-peterx@redhat.com
> v3: https://lore.kernel.org/r/20250926211650.525109-1-peterx@redhat.com
> 
> This series is an alternative proposal of what Nikita proposed here on the
> initial three patches:
> 
>    https://lore.kernel.org/r/20250404154352.23078-1-kalyazin@amazon.com
> 
> This is not yet relevant to any guest-memfd support, but paving way for it.
> Here, the major goal is to make kernel modules be able to opt-in with any
> form of userfaultfd supports, like guest-memfd.  This alternative option
> should hopefully be cleaner, and avoid leaking userfault details into
> vm_ops.fault().
> 
> It also means this series does not depend on anything.  It's a pure
> refactoring of userfaultfd internals to provide a generic API, so that
> other types of files, especially RAM based, can support userfaultfd without
> touching mm/ at all.
> 
> To achieve it, this series introduced a file operation called vm_uffd_ops.
> The ops needs to be provided when a file type supports any of userfaultfd.
> 
> With that, I moved both hugetlbfs and shmem over, whenever possible.  So
> far due to concerns on exposing an uffd_copy() API, the MISSING faults are
> still separately processed and can only be done within mm/.  Hugetlbfs kept
> its special paths untouched.
> 
> An example of shmem uffd_ops:
> 
> static const struct vm_uffd_ops shmem_uffd_ops = {
> 	.supported_ioctls	=	BIT(_UFFDIO_COPY) |
> 					BIT(_UFFDIO_ZEROPAGE) |
> 					BIT(_UFFDIO_WRITEPROTECT) |
> 					BIT(_UFFDIO_CONTINUE) |
> 					BIT(_UFFDIO_POISON),
> 	.minor_get_folio	=	shmem_uffd_get_folio,
> };

This looks better than the previous version to me.

Long term the goal should be to move all hugetlb/shmem specific stuff 
out of mm/hugetlb.c and of course, we won't be adding any new ones to 
mm/userfaultfd.c

I agree with Liam that a better interface could be providing default 
handlers for the separate ioctls [1], but there is always the option to 
evolve this interface into something like that later.


[1] 
https://lkml.kernel.org/r/frnos5jtmlqvzpcrredcoummuzvllweku5dgp5ii5in6epwnw5@anu4dqsz6shy
-- 
Cheers

David / dhildenb


