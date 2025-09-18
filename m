Return-Path: <linux-kernel+bounces-822330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C93CCB838C2
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 10:37:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE7783B8EB5
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 08:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9402D2ED17A;
	Thu, 18 Sep 2025 08:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lmjJusBy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE292E9ED5
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 08:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758184645; cv=none; b=ZwkaFYK9RJKGbNQErZ1mCeaxtVm54wpOhwHniVDKPWR46nTTFZMlCNu4MxYA5eDt09ruMZjrWj4JAIR2f3ODSXSDw4Ys3FKxxbx6ON5dJAaTm4kuX+ILGFf6X3Eu17pzQFBsdgYqAngJLzv4dYvFMAoFV6D+STau81yOW0pbfo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758184645; c=relaxed/simple;
	bh=n6pcgK6RYDmP6b6B7FywOHg4pFSmSErWazePBn/crPs=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FVKDLNuAJgcAOV8uhqLbfBl/mypPa8NX7TaP9d7i5IuERKrhWSnaXm3id1ADmbkXq4yX3rrO0MDJcGeK4aT1BS18seAd0mGjxNR94LSoUTO4URFKph9WeMkCGMEAtKErHj1jKXjWBIbza+hEhl4hEAubULIks+fp0IClUDys/Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lmjJusBy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 008E7C4CEE7;
	Thu, 18 Sep 2025 08:37:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758184644;
	bh=n6pcgK6RYDmP6b6B7FywOHg4pFSmSErWazePBn/crPs=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=lmjJusBy6wTjGtDEz47xc5fyU1rL0tf2mSlWWmQ6Jo7TLlPyXizHw94sK2fAqmsX0
	 RSyFsHeUH1Tb1BdOFygVT8yI1hKcOkOvtfMMPFPXLF/dRtFAI9ewQpjPicQjB1NBvw
	 /MHhTvdmvf6uxBZ0wBuT2OAkDkNaK/9ajoqJDVShQR4XCRqhmyKfUq4y7jOlK3+rlf
	 tA+HP2zzpcgg88ES2Ngn89s1SFkxrIO9K9vn8udk/ipblhDOtcu1aOPEj0fCgtrQPm
	 6TT2NVYBI0mGjZgaETBGQxLI7m0nBqpHnAMhLBX08I539MqR3A9adWhlt9Xax7QIgQ
	 t1Ayp5bCzKhvA==
Date: Thu, 18 Sep 2025 11:37:15 +0300
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
Message-ID: <aMvEu9m7fJLnj862@kernel.org>
References: <aGVu1Isy-R9RszxW@kernel.org>
 <aGWMsfbayEco0j4R@x1.local>
 <aGbCbW7hUf3a2do2@kernel.org>
 <289eede1-d47d-49a2-b9b6-ff8050d84893@redhat.com>
 <aGfsaIIzHWfjcNFd@x1.local>
 <e7vr62s73dftijeveyg6lfgivctijz4qcar3teswjbuv6gog3k@4sbpuj35nbbh>
 <930d8830-3d5d-496d-80d8-b716ea6446bb@amazon.com>
 <jxekhkhbn7uk23oe24svxrs3vfuhseae57sqagndqgh2e7h33o@kfkygmrvjb5n>
 <aMp-kW3OLqtZs8sh@kernel.org>
 <du5pzxmfk6lile3ykpaloylwz4eni6disj2oe25eq6ipzqemiw@ybcouflfnlev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <du5pzxmfk6lile3ykpaloylwz4eni6disj2oe25eq6ipzqemiw@ybcouflfnlev>

On Wed, Sep 17, 2025 at 12:53:05PM -0400, Liam R. Howlett wrote:
> * Mike Rapoport <rppt@kernel.org> [250917 05:26]:
> > Hi Liam,
> > 
> > On Mon, Sep 08, 2025 at 12:53:37PM -0400, Liam R. Howlett wrote:
> > > 
> > > Reading through the patches, I'm not entirely sure what you are
> > > proposing.
> > > 
> > > What I was hoping to see by a generalization of the memory types is a
> > > much simpler shared code base until the code hit memory type specific
> > > areas where a function pointer could be used to keep things from getting
> > > complicated (or, I guess a switch statement..).
> > > 
> > > What we don't want is non-mm code specifying values for the function
> > > pointer and doing what they want, or a function pointer that returns a
> > > core mm resource (in the old example this was a vma, here it is a
> > > folio).
> > > 
> > > From this patch set:
> > > +        * Return: zero if succeeded, negative for errors.
> > > +        */
> > > +       int (*uffd_get_folio)(struct inode *inode, pgoff_t pgoff,
> > > +                             struct folio **folio);
> > > 
> > > This is one of the contention points in the current scenario as the
> > > folio would be returned.
> > 
> > I don't see a problem with it. It's not any different from
> > vma_ops->fault(): a callback for a filesystem to get a folio that will be
> > mapped afterwards by the mm code.
> > 
> 
> I disagree, the filesystem vma_ops->fault() is not a config option like
> this one.  So we are on a path to enable uffd by default, and it really
> needs work beyond this series.  Setting up a list head and passing in
> through every call stack is far from idea.

I don't follow you here. How addition of uffd callbacks guarded by a config
option to vma_ops leads to enabling uffd by by default?
 
> I also think the filesystem model is not one we want to duplicate in mm
> for memory types - think of the test issues we have now and then have a
> look at the xfstests support of filesystems [1].
> 
> So we are on a path of less test coverage, and more code that is
> actually about mm that is outside of mm.  So, is there another way?

There are quite a few vma_ops outside fs/ not covered by xfstest, so the
test coverage argument is moot at best.
And anything in the kernel can grab a folio and do whatever it pleases.

Nevertheless, let's step back for a second and instead focus on the problem
these patches are trying to solve, which is to allow guest_memfd implement
UFFD_CONTINUE (or minor fault in other terminology). 

This means uffd should be able to map a folio that's already in
guest_memfd page cache to the faulted address. Obviously, the page table
update happens in uffd. But it still has to find what to map and we need
some way to let guest_memfd tell that to uffd.

So we need a hook somewhere that will return a folio matching pgoff in
vma->file->inode.

Do you see a way to implement it otherwise?

-- 
Sincerely yours,
Mike.

