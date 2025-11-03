Return-Path: <linux-kernel+bounces-883308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89CD3C2D207
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 17:29:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8D913BCB02
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 16:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F148313E1E;
	Mon,  3 Nov 2025 16:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K8p8WP9r"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617CE3101C2
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 16:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762186296; cv=none; b=Dsb5Rsv8SdtPoLDnzXNa/EHtUyHRKGYHew4Pb3YxGUInwsutOVau7XKa0B3mTpZ3rEOwTVgMDwpKEh8wES8LNqKhtzzIoh9T6b1Onvm50KxjA+dKRMt8gnL8Hrsrs1KuDaiofdWW7FjkqEaxAOziOncy6bGrXuCnzs56lQHF4bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762186296; c=relaxed/simple;
	bh=t3uCVlNB2xJvfnPV0X/hGGm+4C1tih7qB1AMxkuOk3s=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d2Xw2QbCPPVqzWb8tHllRHe0cOFnrpcNEFa4/WDpoTQgCeROQaX1A5HveGU/vjHeLG7vyUhRyKuW1y9H9bEhRPS9j5YhGCRb4qsKt5ODFZPAXBFTWtONMtI9GiyT2G0vYWLGXWjMTmbEIL0fOF26zCJoHBMXtOsNtWZBxFammL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K8p8WP9r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0C59C4CEE7;
	Mon,  3 Nov 2025 16:11:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762186295;
	bh=t3uCVlNB2xJvfnPV0X/hGGm+4C1tih7qB1AMxkuOk3s=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=K8p8WP9rT5MxIAnfnxfqwVuhJ0DnYjbNVkEk8Ii1JA8elVgIjBSFsM4Iu+x/ZCI3c
	 dPZE5rbVRMx7VmX4a0AsIYVnsWDfyct4kktvU7CFb427nTX8O0RRyhiRliyEFopkDu
	 YrI7hkvPtsHGccYOL/e767fSIzzbElpa38AnXNjt7zajMnbjoJvpZ9Sba67iFWsvLQ
	 0NPj0z66MzqlMSqDio+rPwd7e1TVY1woUkCQ9UEIG2ptPlZ4Lu1UF6dS9eN5MU030c
	 bxiXfGKcu6Q+D+LR8VUj/RYno21OP8zVX8G4ddiIGaL0tL93VlVmynrHqneNaOvMd0
	 cdkYD63GTiyNw==
Date: Mon, 3 Nov 2025 18:11:26 +0200
From: Mike Rapoport <rppt@kernel.org>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Muchun Song <muchun.song@linux.dev>,
	Nikita Kalyazin <kalyazin@amazon.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	James Houghton <jthoughton@google.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Hugh Dickins <hughd@google.com>, Michal Hocko <mhocko@suse.com>,
	Ujwal Kundur <ujwal.kundur@gmail.com>,
	Oscar Salvador <osalvador@suse.de>,
	Suren Baghdasaryan <surenb@google.com>,
	Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: [PATCH v4 0/4] mm/userfaultfd: modulize memory types
Message-ID: <aQjULib7JriWnVTq@kernel.org>
References: <20251014231501.2301398-1-peterx@redhat.com>
 <78424672-065c-47fc-ba76-c5a866dcdc98@redhat.com>
 <aPZDVuscFsYSlQjI@x1.local>
 <dtepn7obw5syd47uhyxavytodp7ws2pzr2yuchda32wcwn4bj4@wazn24gijumu>
 <aPe0oWR9-Oj58Asz@x1.local>
 <nnxhd7zxjza6m4w4lr5qyev2krbkp4yfcgcwq6nkaqrqt6bzpb@iklep2xxp5gv>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nnxhd7zxjza6m4w4lr5qyev2krbkp4yfcgcwq6nkaqrqt6bzpb@iklep2xxp5gv>

Hi Liam,

On Thu, Oct 30, 2025 at 01:13:24PM -0400, Liam R. Howlett wrote:
> * Peter Xu <peterx@redhat.com> [251021 12:28]:
> 
> ...
> 
> > Can you send some patches and show us the code, help everyone to support
> > guest-memfd minor fault, please?
> 
> Patches are here:
> 
> https://git.infradead.org/?p=users/jedix/linux-maple.git;a=shortlog;h=refs/heads/modularized_mem

It's really cool you picked up the gauntlet and invested this effort into
refactoring of uffd!

I agree that userfault code begs for cleanups after the sh^W stuff has been
piling over and over, but ...
 
> This is actually modularized memory types.  That means there is no
> hugetlb.h or shmem.h included in mm/userfaultfd.c code.
> 
> uffd_flag_t has been removed.  This was turning into a middleware and
> it is not necessary.  Neither is supported_ioctls.
> 
> hugetlb now uses the same functions as every other memory type,
> including anon memory.
> 
> Any memory type can change functionality without adding instructions or
> flags or anything to some other code.
> 
> This code passes uffd-unit-test and uffd-wp-mremap (skipped the swap
> tests).
> 
> guest-memfd can implement whatever it needs to (or use others
> implementations), like shmem_uffd_ops here:
> 
> static const struct vm_uffd_ops shmem_uffd_ops = {
>         .copy                   =       shmem_mfill_atomic_pte_copy,
>         .zeropage               =       shmem_mfill_atomic_pte_zeropage,
>         .cont                   =       shmem_mfill_atomic_pte_continue,
>         .poison                 =       mfill_atomic_pte_poison,
>         .writeprotect           =       uffd_writeprotect,
>         .is_dst_valid           =       shmem_is_dst_valid,
>         .increment              =       mfill_size,
>         .failed_do_unlock       =       uffd_failed_do_unlock,
>         .page_shift             =       uffd_page_shift,
>         .complete_register      =       uffd_complete_register,
> };   

... I don't think it's the right level of abstraction to add as uffd_ops to
vmap_ops.
 
As I see it, we have two levels where things are different: hugetlb vs
others at the very core of mfill_atomic() and then how different pte-based
types implement a single page operations, i.e copy/zeropage/continue.

So to separate hugetlb code from userfault we need something like 

	->get_parent_pagetable()
	->pagesize()
	->mfill_atomic_page()

and apparently something like your complete_register() and maybe
is_dst_valid().

But to provide hooks for shmem, anon and potentially guest_memfd() we
should be looking at callbacks to get a folio to populate a PTE, either for
copy or continue, and Peter's ->minor_get_folio() seems to me the right
level of abstraction to expose at vm_uffd_ops.

I believe we can extract ->get_folio() and ->put_folio() from
shmem_mfill_atomic_pte() and call them from mfill_atomic_pte_copy().

> Where guest-memfd needs to write the one function:
> guest_memfd_pte_continue(), from what I understand.
> 
> Obviously some of the shmem_ functions would need to be added to a
> header, or such.
> 
> And most of that can come from shmem_mfill_atomic_pte_continue(), from
> what I understand.  This is about 40 lines of code, but may require
> exposing some shmem functions to keep the code that compact.

This seems to me an overkill to implement MFILL_ATOMIC_CONTINUE for
guest_memfd().
I think it should be able to register a callback to provide a singe folio
at a given file offset if that folio is in the guest_memfd's page cache.
No reason for guest_memfd to start re-implementing locking, acquiring of
PMD and updating the page table, even if it only needs to call functions
from userfaultfd

> So we don't need to expose getting a folio to a module, or decode any
> special flags or whatever.  We just call the function that needs to be
> called on the vma that is found.

Agree about exposing flags to a module and about limiting API to functions
only.
 
> Thanks,
> Liam
> 

-- 
Sincerely yours,
Mike.

