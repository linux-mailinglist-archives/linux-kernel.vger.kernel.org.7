Return-Path: <linux-kernel+bounces-823417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72ADCB865F4
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 20:05:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 240C51CC4275
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 18:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 327CD2C0F7D;
	Thu, 18 Sep 2025 18:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TMGdhYSa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B3712C029D
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 18:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758218728; cv=none; b=EXc2d774ftBAgXNrUxNtF0kAGv46r6NuhMpTSsB2fQanRLmwfnc1lOE4ylHO+h3F+54PVrLrH/3e+KEQlLuOgxdv5yn4TklOjulz6iqtJ4+BNHJfGnuEECk40UPqYEzDgHjfWHrCe+GUmwBciItggTvDTCVfzZXhfFTC6MU0ytM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758218728; c=relaxed/simple;
	bh=tsq8/KIMhkwr8aDP5CrNQEAVsPpxQpbwsRK0rJgZrGE=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NxqkstKmVjVU+O4W72Cfl9GJk9MyH8hm+C2mWJZWO2RFd3B5a+LKfb/ElSYIzfS98S5JqvA6NUOz0SrfAoCGqEXq+aicEosRnDhh19CZN53rClMXGf7ocsrTnPhhDw4PQ7b2p95N92uN4Mim+IdOGKUi3VivbU3rCh68qGUwEmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TMGdhYSa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 897DDC4CEF0;
	Thu, 18 Sep 2025 18:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758218728;
	bh=tsq8/KIMhkwr8aDP5CrNQEAVsPpxQpbwsRK0rJgZrGE=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=TMGdhYSat7emupYTEzFzD7zPjV5zTJsTc13UxGPYN858mMyT+wcChY7q+MHe9BnYe
	 159cXvtfGkpYdTvIngkHDfFUAR1+FCkRMHcnJrgc5EpXlTZEXARn7tIzF0IVCUmo9t
	 oE5ZcASeNwoHJTLochmOaynIvZwKYA9AOaodzf/WRmbHsdBOiWIJZ/QkjYo6zQ2Ppl
	 dkZLTb+Oj45+lvq0lx41gWBqcyfUKY/Tq+bXIxW9Lg9EhYZL+XUNoVmbyKRFQiMQS4
	 XaNq1fxOFSk7fn8ogsxXK9euOnaP6s2fz/cWebWuR7D2neYbom+DxLETv7hglTwMHH
	 8kIodG9lN2gRQ==
Date: Thu, 18 Sep 2025 21:05:18 +0300
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
Message-ID: <aMxJ3inEs_RRyqen@kernel.org>
References: <aGbCbW7hUf3a2do2@kernel.org>
 <289eede1-d47d-49a2-b9b6-ff8050d84893@redhat.com>
 <aGfsaIIzHWfjcNFd@x1.local>
 <e7vr62s73dftijeveyg6lfgivctijz4qcar3teswjbuv6gog3k@4sbpuj35nbbh>
 <930d8830-3d5d-496d-80d8-b716ea6446bb@amazon.com>
 <jxekhkhbn7uk23oe24svxrs3vfuhseae57sqagndqgh2e7h33o@kfkygmrvjb5n>
 <aMp-kW3OLqtZs8sh@kernel.org>
 <du5pzxmfk6lile3ykpaloylwz4eni6disj2oe25eq6ipzqemiw@ybcouflfnlev>
 <aMvEu9m7fJLnj862@kernel.org>
 <4czztpp7emy7gnigoa7aap2expmlnrpvhugko7q4ycfj2ikuck@v6aq7tzr6yeq>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4czztpp7emy7gnigoa7aap2expmlnrpvhugko7q4ycfj2ikuck@v6aq7tzr6yeq>

On Thu, Sep 18, 2025 at 12:47:41PM -0400, Liam R. Howlett wrote:
> * Mike Rapoport <rppt@kernel.org> [250918 04:37]:
> > On Wed, Sep 17, 2025 at 12:53:05PM -0400, Liam R. Howlett wrote:
> > >
> > > I disagree, the filesystem vma_ops->fault() is not a config option like
> > > this one.  So we are on a path to enable uffd by default, and it really
> > > needs work beyond this series.  Setting up a list head and passing in
> > > through every call stack is far from idea.
> > 
> > I don't follow you here. How addition of uffd callbacks guarded by a config
> > option to vma_ops leads to enabling uffd by by default?
> 
> Any new memory type that uses the above interface now needs uffd
> enabled, anyone planning to use guest_memfd needs it enabled, anyone
> able to get a module using this interface needs it enabled (by whoever
> gives them the kernel they use).  Kernel provides now need to enable
> UFFD - which is different than the example provided.

My understanding of Peter's suggestion is that *if* uffd is enabled memory
type *may* implement the API, whatever API we'll come up with.
  
> > Nevertheless, let's step back for a second and instead focus on the problem
> > these patches are trying to solve, which is to allow guest_memfd implement
> > UFFD_CONTINUE (or minor fault in other terminology). 
> 
> Well, this is about modularizing memory types, but the first user is
> supposed to be the guest-memfd support.
> 
> > 
> > This means uffd should be able to map a folio that's already in
> > guest_memfd page cache to the faulted address. Obviously, the page table
> > update happens in uffd. But it still has to find what to map and we need
> > some way to let guest_memfd tell that to uffd.
> > 
> > So we need a hook somewhere that will return a folio matching pgoff in
> > vma->file->inode.
> > 
> > Do you see a way to implement it otherwise?
> 
> I must be missing something.
> 
> UFFDIO_CONTINUE currently enters through an ioctl that calls
> userfaultfd_continue() -> mfill_atomic_continue()... mfill_atomic() gets
> and uses the folio to actually do the work.  Right now, we don't hand
> out the folio, so what is different here?

The ioctl() is the mean of userspace to resolve a page fault and
mfill_atomic() needs something similar to ->fault() to actually get the
folio. And in case of shmem and guest_memfd the folio lives in the page
cache.
 
> I am under the impression that we don't need to return the folio, but
> may need to do work on it.  That is, we can give the mm side what it
> needs to call the related memory type functions to service the request.
> 
> For example, one could pass in the inode, pgoff, and memory type and the
> mm code could then call the fault handler for that memory type?

How calling the fault handler differs conceptually from calling
uffd_get_folio?
If you take a look at UFFD_CONTINUE for shmem, this is pretty much what's
happening. uffd side finds inode and pgoff and calls to a shmem_get_folio()
that's very much similar to shmem->fault().

-- 
Sincerely yours,
Mike.

