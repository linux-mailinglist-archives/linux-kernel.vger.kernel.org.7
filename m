Return-Path: <linux-kernel+bounces-861087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 25B8CBF1C0B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 16:12:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4DE11895880
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 14:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AD61303C93;
	Mon, 20 Oct 2025 14:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N1k1w/RT"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3767113BC0C
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 14:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760969565; cv=none; b=ccH8diJ+7F9xS1PKQW2jmvTLIe8Kh7bAKKBHNkzq9iY6DfwIOfZeYWkeg3VtyTbdXoGxJ+uLVQ7Qgn/5gMVib/uDzB36bUZHxvN3Ocmlzd1G3ar+txtGKbwvjCE47ke1LXdV7HeVZvgNceZhkdspfZ6wK2yQv46UJ55Brll6pis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760969565; c=relaxed/simple;
	bh=vFpz1lMFpRUo2Y/sezIcRFYzNBkFK6VIX42Nt0bW78U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IIsFs6C0JduYY0gDJsI6YIT7iLf5YweDomiYVmMcu+JnZbd2uOCAJZwRP7XKPcQ2VHfNPphusOqrofdYtYwaUOEDDlLFL7g0GhC6ehnaXjSKnCn3oJ7BmOn0TsY6Vhel+CA7gcGfQ1YiZ7XBBK0AlDZSCVuXuxaUFd9FyerF/94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N1k1w/RT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760969563;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=c1SLWf+q8pqu9k/Xw2FidgUt4uiKg7Qzo/H06ERg2kQ=;
	b=N1k1w/RTScwkxltY8Pz3tGTv0koqE59lbZ4u0wdFFkzUGniepavdj4BjFUzc537GxlpOra
	RYzzrrCRpLFM7l7Yau4MpD9hy5xJWQsAswPx0tv29Mr+J8X5dIA9zE+QInjuFR1RBUplk1
	EqGa/vU5we5gheo9qgJhqnuQ1eJ3lOw=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-367-V-t6rvghPrGzS_VeTU_e8g-1; Mon, 20 Oct 2025 10:12:41 -0400
X-MC-Unique: V-t6rvghPrGzS_VeTU_e8g-1
X-Mimecast-MFC-AGG-ID: V-t6rvghPrGzS_VeTU_e8g_1760969561
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-81a8065daf4so81555976d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 07:12:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760969561; x=1761574361;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c1SLWf+q8pqu9k/Xw2FidgUt4uiKg7Qzo/H06ERg2kQ=;
        b=cDyiKt2HBg3PjZvHW3D+dK9/P/WJBxP+BzfX50W6qGAHgIf2j6MACaZOGh2PT7LwD5
         PsB7ysF4mMyLNaz4nMoWEf5OQ5q5P3+sO50BKBl8QM6z+XV5Oi7Df0gTkRPpuwcTFnbh
         rquhfQIrix8nXioF5ZVXqCUhtV2VyWXSbYx9/eib+IS2hC8wMm6qrlLo36BciEnX68+O
         S2h0uryAHcK9S3Ju+Ho9R9AT6MNYwvrBHPWSPrVvMM6gdWtwDXusnqO9O9y5dAZwTVIO
         0XqrDsUvbV/pHVYvTQmtP6ejjgNkhJbd3pgAwg7IFJ9sA08k4FbizLgoA9U9rjEvc/Bn
         5HCA==
X-Gm-Message-State: AOJu0YyU33EYZ2EsYeURDfBoa1ECSdGKeGow/6bP461EJfNEJfg7Sgrn
	gLLE03rTX6T9xDEGjx8I7ASvsDttdjyk9tqyn0gkra+F5vLyagNJg9jMCxzyM+QqlhPak8+QSRC
	1qIpQH+Tz9TriQg/Kca/C9aWLfxfi3xbw4pa4/SMptpePXp7zaa4dEa4AyfoIm6eBiQ==
X-Gm-Gg: ASbGncvL9aT3O4QEEE6/UmOTDw9bS22OhulxK7ICgaopipMbrIwTckAXQ6+gnFuy0jx
	8DjbVWiXb4EUtaRyRv6KMVaJVsT1ZuOO51EPoO8HpTmtHDdcUnvg72u5rlkvEDSlsC4Rtca9nq6
	3MLnqHILwFWKF3o+jnKMSmOdVVPbxXmSU7x3uZc+fmi3MhsdvSB9yGMrcMcuMzS4mdOFBbFQFcQ
	+N9QCEV5gyuzoDlUUKNrZj6c4FVtYhRc4xdoN/BMMjWjp2+kCgQH8uZ/cW0kmkB7wn9JON8P0hM
	NSJHCUEduiiEpzuhWNNkY7ethAPLdTPXHaQuXHHfm8oNi/gSTk98BQ8yJ0KNYb4Dq3I=
X-Received: by 2002:a05:6214:d8f:b0:87c:43f0:374a with SMTP id 6a1803df08f44-87c43f03a03mr110220636d6.29.1760969561057;
        Mon, 20 Oct 2025 07:12:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEPrzPkMbuISrfnHZgsrYNiZtDHPQtpyHP3udmFtcHznS6vhG46dJMdI4kcVza4Yso3LXCMzA==
X-Received: by 2002:a05:6214:d8f:b0:87c:43f0:374a with SMTP id 6a1803df08f44-87c43f03a03mr110220286d6.29.1760969560391;
        Mon, 20 Oct 2025 07:12:40 -0700 (PDT)
Received: from x1.local ([142.188.210.50])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87cf52209cesm51317176d6.23.2025.10.20.07.12.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 07:12:39 -0700 (PDT)
Date: Mon, 20 Oct 2025 10:12:38 -0400
From: Peter Xu <peterx@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Mike Rapoport <rppt@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Nikita Kalyazin <kalyazin@amazon.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	James Houghton <jthoughton@google.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Hugh Dickins <hughd@google.com>, Michal Hocko <mhocko@suse.com>,
	Ujwal Kundur <ujwal.kundur@gmail.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Oscar Salvador <osalvador@suse.de>,
	Suren Baghdasaryan <surenb@google.com>,
	Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: [PATCH v4 0/4] mm/userfaultfd: modulize memory types
Message-ID: <aPZDVuscFsYSlQjI@x1.local>
References: <20251014231501.2301398-1-peterx@redhat.com>
 <78424672-065c-47fc-ba76-c5a866dcdc98@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <78424672-065c-47fc-ba76-c5a866dcdc98@redhat.com>

On Mon, Oct 20, 2025 at 03:34:47PM +0200, David Hildenbrand wrote:
> On 15.10.25 01:14, Peter Xu wrote:
> > [based on latest akpm/mm-new of Oct 14th, commit 36c6c5ce1b275]
> > 
> > v4:
> > - Some cleanups within vma_can_userfault() [David]
> > - Rename uffd_get_folio() to minor_get_folio() [David]
> > - Remove uffd_features in vm_uffd_ops, deduce it from supported ioctls [David]
> > 
> > v1: https://lore.kernel.org/r/20250620190342.1780170-1-peterx@redhat.com
> > v2: https://lore.kernel.org/r/20250627154655.2085903-1-peterx@redhat.com
> > v3: https://lore.kernel.org/r/20250926211650.525109-1-peterx@redhat.com
> > 
> > This series is an alternative proposal of what Nikita proposed here on the
> > initial three patches:
> > 
> >    https://lore.kernel.org/r/20250404154352.23078-1-kalyazin@amazon.com
> > 
> > This is not yet relevant to any guest-memfd support, but paving way for it.
> > Here, the major goal is to make kernel modules be able to opt-in with any
> > form of userfaultfd supports, like guest-memfd.  This alternative option
> > should hopefully be cleaner, and avoid leaking userfault details into
> > vm_ops.fault().
> > 
> > It also means this series does not depend on anything.  It's a pure
> > refactoring of userfaultfd internals to provide a generic API, so that
> > other types of files, especially RAM based, can support userfaultfd without
> > touching mm/ at all.
> > 
> > To achieve it, this series introduced a file operation called vm_uffd_ops.
> > The ops needs to be provided when a file type supports any of userfaultfd.
> > 
> > With that, I moved both hugetlbfs and shmem over, whenever possible.  So
> > far due to concerns on exposing an uffd_copy() API, the MISSING faults are
> > still separately processed and can only be done within mm/.  Hugetlbfs kept
> > its special paths untouched.
> > 
> > An example of shmem uffd_ops:
> > 
> > static const struct vm_uffd_ops shmem_uffd_ops = {
> > 	.supported_ioctls	=	BIT(_UFFDIO_COPY) |
> > 					BIT(_UFFDIO_ZEROPAGE) |
> > 					BIT(_UFFDIO_WRITEPROTECT) |
> > 					BIT(_UFFDIO_CONTINUE) |
> > 					BIT(_UFFDIO_POISON),
> > 	.minor_get_folio	=	shmem_uffd_get_folio,
> > };
> 
> This looks better than the previous version to me.
> 
> Long term the goal should be to move all hugetlb/shmem specific stuff out of
> mm/hugetlb.c and of course, we won't be adding any new ones to
> mm/userfaultfd.c
> 
> I agree with Liam that a better interface could be providing default
> handlers for the separate ioctls [1], but there is always the option to
> evolve this interface into something like that later.

Thanks for accepting this current form.

> 
> 
> [1] https://lkml.kernel.org/r/frnos5jtmlqvzpcrredcoummuzvllweku5dgp5ii5in6epwnw5@anu4dqsz6shy

I have replied to that, here:

https://lore.kernel.org/all/aOVEDii4HPB6outm@x1.local/

If we ignore hugetlbfs, most of the hooks may not be needed, as explained.

If we introduce hooks only for hugetlbfs, IMHO it's going backwards.  When
we want to get rid of hugetlbfs paths, we will have something more to get
rid of..

We can wait until some use cases to appear, that may help us to better
understand what might be more suitable to be abstracted. Especially, if
there will be any consumer for missing faults.  However if guest-memfd has
it optional, my expectation so far is there'll be no real demand on that
for the foreseeable future.

Thanks,

-- 
Peter Xu


