Return-Path: <linux-kernel+bounces-827629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96C90B9240B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 18:38:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AA1B1901F52
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 16:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC484312801;
	Mon, 22 Sep 2025 16:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SlZ71WJP"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 688B226CE3C
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 16:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758559102; cv=none; b=j5PLig0vG21d/ISfUBhCTocZeQQjV7DdoUnGoj5FLm8WrEzVNIV+S14XS0UU9H80ktqz9VlVKmapgXtDepXN4qwJHiFg87yIV2591RZvAhbSNOELBLqAd9/TMEM4DxsUBTzxAraxJKpiDpEu1iFV8L77qE3NXiHFp9uyFJBklLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758559102; c=relaxed/simple;
	bh=XEBVLGs2bh6+NdjkLBOzJsUfP5W48c9dSets1mU/HlQ=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oH4VRd2wrCpAxHi8k9SJ6vAY5LVejyvjLJIdoZJ+NsKDXVTeAhw54AdxQNivY9ARE75ngq+RodTihiaiM67iStOSEgZfFapGJOZCQVfmpeXlwrqvEqhWNJzMm8RIa2hMRxzJY0QGFjjMIYCUJoESorjRVSO3LyU41Ss/NCzG04c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SlZ71WJP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758559098;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kRPJicGQTdnr4fyUdWpU6gJMxGkHyZtedzSbJu7STr0=;
	b=SlZ71WJPykSzlO5a/pGC+6BFdTbV6tY4r2Yq89kGy3hyMuzex65NmAHIRa8TR7hdXNv84C
	qAsYuvvtOGKjv6zdHJ2XAMUHQtAyQRb+nqrZ6H0yeHJSqwr4a3yhXgXa3e+FocB3hSdBil
	w6Hyzu/KamXdtZ9OKXb1+BVYnm9WyxU=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-74-HnPc_EQpPD-8243KJOBEOA-1; Mon, 22 Sep 2025 12:38:17 -0400
X-MC-Unique: HnPc_EQpPD-8243KJOBEOA-1
X-Mimecast-MFC-AGG-ID: HnPc_EQpPD-8243KJOBEOA_1758559096
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8500faee0c5so65394885a.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 09:38:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758559096; x=1759163896;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kRPJicGQTdnr4fyUdWpU6gJMxGkHyZtedzSbJu7STr0=;
        b=UTMk3UHB4QfO6NfY5oGo9FgfVILW/eE5731/xRcd0emWw40oEBXKlZpz4VIo+oh3lx
         yHvz9wIpFrePbfWUXTT+G0TBvMvvdXbK0BIPs7vpRUlLGtpJ/JswpOggNcXh+TTIbZ6Z
         kNMdJNpVPbU+BKg3kT/6nkvBS30wd9rSl85TWxZQ/icp7BcsrFp75tp0eKJUy4zxtS1e
         jXPN9yeQ5cDEtVO19/Ti8w6tXEvvW/6oJ1Lu5dhoi7iRre9o2U8nn/mvHCiozEfSKEu/
         QCCd7OYiFULrs/h+TEgms/x/JV6q6kDvj6DbYSEtY8gYz3uiSIQGeQFBxn97kjTlb08t
         Pvfw==
X-Forwarded-Encrypted: i=1; AJvYcCWM5TUEW9z/DtokxCHCZ+VmspMOTG8gEjJniD2xYr6i/IwtbOTQHoemihv3PTraQiuXO3g+zBtVrwKdBLk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyK7byUzsqG7/SsoWphPDFqp0r6/dtOgcXI5lkGQ3mM1r1ENVS/
	MRXtMwFKcSvpTK6NC0HUnq9Utbklv2oD0RUmB5OPqgLBkDaeS9+tPbochkcpKsS9ywnVzCJjQO/
	EZY7pTUxCVFYnZo3RAR7rDsAsClYxuiYcKlr9xST0j+O73W0rTPZbqFus7t0/jxPs/A==
X-Gm-Gg: ASbGncskjxrqVy5EuUJpp4249mfi2QCD5sWjKHUDy/BrwhdFpQ1xA+eY4JpqEEeCVI5
	mLESCNz+b/O21cR9iWv5xvYHP/uYL3o8SltIIafzeGFDa5e6bdoBppFE6Mep362L6IHpEYYkIi+
	2lzPkgmNkvZv42Gowjmkb6V6PNh5H2cgtt1tPIysno7WQRCnzktQLs6yBScGZf36J+aHaqxX7fz
	VPvYBf6AA8ulnBIFzSXnugCZ7DCo2Z29HdG2EDQViD8oijj4cP9N5pzx/6EMH2OsiuuOdi+UmLK
	N3WTMXy5C/cRSJy8UwSc/fCIXii/sb40
X-Received: by 2002:a05:620a:2683:b0:84a:a019:cdf5 with SMTP id af79cd13be357-84aa019cf13mr485438785a.53.1758559095940;
        Mon, 22 Sep 2025 09:38:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFCS5EDF7ht5BQNo1OOpXMisltQt1vHiFGmi7H0nOcZkAtQZS0HfCi5gZJpE5Oi/8k95h7sgw==
X-Received: by 2002:a05:620a:2683:b0:84a:a019:cdf5 with SMTP id af79cd13be357-84aa019cf13mr485434985a.53.1758559095449;
        Mon, 22 Sep 2025 09:38:15 -0700 (PDT)
Received: from x1.local ([142.188.210.50])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-83631a7fc2fsm817022185a.54.2025.09.22.09.38.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 09:38:14 -0700 (PDT)
Date: Mon, 22 Sep 2025 12:38:13 -0400
From: Peter Xu <peterx@redhat.com>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
	David Hildenbrand <david@redhat.com>,
	Mike Rapoport <rppt@kernel.org>,
	Nikita Kalyazin <kalyazin@amazon.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Suren Baghdasaryan <surenb@google.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>,
	Muchun Song <muchun.song@linux.dev>,
	Hugh Dickins <hughd@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	James Houghton <jthoughton@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Andrea Arcangeli <aarcange@redhat.com>,
	Oscar Salvador <osalvador@suse.de>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Ujwal Kundur <ujwal.kundur@gmail.com>
Subject: Re: [PATCH v2 1/4] mm: Introduce vm_uffd_ops API
Message-ID: <aNF7dT-YUccWygka@x1.local>
References: <982f4f94-f0bf-45dd-9003-081b76e57027@lucifer.local>
 <cda7c46b-c474-48f4-b703-e2f988470f3b@amazon.com>
 <aGVu1Isy-R9RszxW@kernel.org>
 <aGWMsfbayEco0j4R@x1.local>
 <aGbCbW7hUf3a2do2@kernel.org>
 <289eede1-d47d-49a2-b9b6-ff8050d84893@redhat.com>
 <aGfsaIIzHWfjcNFd@x1.local>
 <e7vr62s73dftijeveyg6lfgivctijz4qcar3teswjbuv6gog3k@4sbpuj35nbbh>
 <aMnAscxj_h42wOAC@x1.local>
 <oybstepupgh2s5lpwwk7scryem4mgk2t7wmkr5zhj7cz4da3bp@aylj2x6sgtap>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <oybstepupgh2s5lpwwk7scryem4mgk2t7wmkr5zhj7cz4da3bp@aylj2x6sgtap>

On Fri, Sep 19, 2025 at 01:22:01PM -0400, Liam R. Howlett wrote:
> > > The shmem call already depends on the vma flags.. which it still does in
> > > your patch 4 here.  So you've replaced this:
> > > 
> > > if (!(dst_vma->vm_flags & VM_SHARED)) {
> > > ...
> > > } else {
> > >         shmem_mfill_atomic_pte()
> > > }
> > > 
> > > With...
> > > 
> > > if (!(dst_vma->vm_flags & VM_SHARED)) {
> > > ...
> > > } else {
> > > ...
> > >         uffd_ops->uffd_copy()
> > > }
> > 
> > I'm not 100% sure I get this comment.  It's intentional to depend on vma
> > flags here for shmem.  See Andrea's commit:
> > 
> > commit 5b51072e97d587186c2f5390c8c9c1fb7e179505
> > Author: Andrea Arcangeli <aarcange@redhat.com>
> > Date:   Fri Nov 30 14:09:28 2018 -0800
> > 
> >     userfaultfd: shmem: allocate anonymous memory for MAP_PRIVATE shmem
> > 
> > Are you suggesting we should merge it somehow?  I'd appreciate some
> > concrete example here if so.
> 
> What I am saying is that the containing function, mfill_atomic_pte(),
> should be absorbed into each memory type's ->uffd_copy(), at least
> partially.
> 
> Shouldn't each memory type do all the necessary checks in ->uffd_copy()?
> 
> To put it another way, no shared memory vma will enter the if()
> statement, so why are we checking if they need to?
> 
> So if the default uffd_copy() does the if (!shared) stuff, you can just
> call uffd_ops->uffd_copy() with out any check there, right?

IIUC this is the only piece of technical side of discussion that was not
addressed, so I'm replying explicitly to this one.  Please let me know if I
missed something else.

Here we need to keep MAP_PRIVATE separate and as a common code to
UFFDIO_COPY / ZEROCOPY.  It not only applies to shmem even if it was about
shmem only at that time when Andrea fixed this case, it was simply because
hugetlbfs was working fine via its separate path.

In general, shmem is the file system, and when it's mapped MAP_PRIVATE (and
even if it's called shmem) we should bypass page cache, hence uffd_copy()
shouldn't be used.  It should apply to other file systems too when
UFFDIO_COPY/ZEROCOPY will be implemented via ->uffd_copy().

However since we're not going to export ->uffd_copy() in the new version,
it's also out of the picture.

Thanks,

-- 
Peter Xu


