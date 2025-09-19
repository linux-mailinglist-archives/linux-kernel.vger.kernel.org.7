Return-Path: <linux-kernel+bounces-824253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F389B8881B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 11:05:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A0823ABE10
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 09:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EA0D2EB853;
	Fri, 19 Sep 2025 09:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eEQfYBVF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F621BEF7E
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 09:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758272716; cv=none; b=ry0+96S9U76+/ydM4ryt8WN2Faqx8OnWQQkGkvh7HU8QfEvUVUfojNDYMd+3VockcTqKg+10UN9ypMPFT+saSyPJ+JH1gocrt+BVVpZPYIDgZr2YDxODPX3tXixYXmNI+UWGiGdAwQEGrzoyBRkEHjy1FEaMCVI4q+Me+1fJWZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758272716; c=relaxed/simple;
	bh=zJ0SjfgXXTUUnk4huOKfaCwNac4EUk7FP0wHBE8bpMY=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZZcf2ypoLBdcvWjSPS0Tyky+5ewvtcUIppFPmsP+ylSRVsen8tRWA4CgnKtd+3qt7oqQpDn7CQBFCorW1jI7ZptQ/lc/edaKPBxuR/pw9RKMJvtqFHKLBm3YuYuPToFlDxRWAezdIw3v2G3oEISHhxVRdn66b5AUJQOed1/nyME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eEQfYBVF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31ED8C4CEF0;
	Fri, 19 Sep 2025 09:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758272716;
	bh=zJ0SjfgXXTUUnk4huOKfaCwNac4EUk7FP0wHBE8bpMY=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=eEQfYBVFHz8m3XUwc47GQ8nRASXr13i6epRajw7PQnSfSQkAevDpXLmGSN0jbAuK/
	 1IKCyy8Soxwtnn9LSoy97u5JXEiq5bL1JvvzgqoEE8lpvMcAdk8LS8bNdaDLELEzA5
	 sd09AODeRewtQ4s5iljD9BaafvExaTJjoIXjIvPTRTjzyGPvLbRwKgLBBHzPuxUr3W
	 8TFy2c1e+sIgARhqlJfzfKH2/x2SSLpfzMaYNyuTVr6kwJp7AbYaAPcfbGVPTpSiHQ
	 Ti+p2P4f4MeID2Rr5tcNVKLIrOArhcXZsmasCTLVwkos6RaxTvdu6kUjeM57eZmC6/
	 IzTj7GQ71WQVw==
Date: Fri, 19 Sep 2025 12:05:06 +0300
From: Mike Rapoport <rppt@kernel.org>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Nikita Kalyazin <kalyazin@amazon.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
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
Message-ID: <aM0cwg1GcXUY31wj@kernel.org>
References: <aGfsaIIzHWfjcNFd@x1.local>
 <e7vr62s73dftijeveyg6lfgivctijz4qcar3teswjbuv6gog3k@4sbpuj35nbbh>
 <930d8830-3d5d-496d-80d8-b716ea6446bb@amazon.com>
 <jxekhkhbn7uk23oe24svxrs3vfuhseae57sqagndqgh2e7h33o@kfkygmrvjb5n>
 <aMp-kW3OLqtZs8sh@kernel.org>
 <du5pzxmfk6lile3ykpaloylwz4eni6disj2oe25eq6ipzqemiw@ybcouflfnlev>
 <aMvEu9m7fJLnj862@kernel.org>
 <4czztpp7emy7gnigoa7aap2expmlnrpvhugko7q4ycfj2ikuck@v6aq7tzr6yeq>
 <aMxJ3inEs_RRyqen@kernel.org>
 <2rkvuudmsf5tv66wya4f7m5niwnodu42owzmro5jzyc4fcep5n@lre7hir4qjli>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2rkvuudmsf5tv66wya4f7m5niwnodu42owzmro5jzyc4fcep5n@lre7hir4qjli>

On Thu, Sep 18, 2025 at 02:32:31PM -0400, Liam R. Howlett wrote:
> * Mike Rapoport <rppt@kernel.org> [250918 14:05]:
> 
> ...
> 
> >  
> > > I am under the impression that we don't need to return the folio, but
> > > may need to do work on it.  That is, we can give the mm side what it
> > > needs to call the related memory type functions to service the request.
> > > 
> > > For example, one could pass in the inode, pgoff, and memory type and the
> > > mm code could then call the fault handler for that memory type?
> > 
> > How calling the fault handler differs conceptually from calling
> > uffd_get_folio?
> > If you take a look at UFFD_CONTINUE for shmem, this is pretty much what's
> > happening. uffd side finds inode and pgoff and calls to a shmem_get_folio()
> > that's very much similar to shmem->fault().
> 
> I believe the location of the code that handles the folio.  One would
> decouple the folio processing from the mm while the other would decouple
> which processing of the folio is done within the mm.
> 
> Does that make sense?

No :)

In short, uffd_get_folio() is a special case of ->fault().

tl;dr version is that the whole processing is page fault handling with a
brief excursion to userspace. For VMAs registered with uffd, page faults
are intercepted by uffd and delivered as events to userpsace. There are
several ways for userspace to resolve a page fault, in this case we are
talking about UFFD_CONTINUE. Its semantics is similar to a minor fault - if
the faulted folio is already in the page cache of the address space backing
the VMA, it is mapped into the page table. If the folio is not in the page
cache uffd returns -EFAULT.

So the processing of the folio that uffd_get_folio() is exactly what
->fault() would do for a folio found in the page cache of inode backing the
VMA. And unlike ->fault(), uffd_get_folio() should not allocate a new folio
if its not in the page cache.

-- 
Sincerely yours,
Mike.

