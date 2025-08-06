Return-Path: <linux-kernel+bounces-757425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C6B6B1C1F4
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 10:16:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD40F720933
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 08:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC32D221710;
	Wed,  6 Aug 2025 08:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tzUYNT8X"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 263E022156C
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 08:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754468161; cv=none; b=mtJqiOIEq6/+TpUGHm7NkTJMMAsXjUZOoGTGyQo/JoOvKE9BVxTcRovPch3PF2U4y9tkPP12wXrRMGq29sX9vEGcVhaugVfvE561Tf0vHvhj965s03yc0HoUl6h7EZ46BB9HhO+0RxjuP7sO/KPrE72p1lKQPg2PDn5n1PdkrPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754468161; c=relaxed/simple;
	bh=Fbs+mcsucsTbbAfdd4KqOVe7ihhq3xMWZSnPSsrgkFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WOFXkQJU7WdFo2AFOk37vHdKa3uyDsSkb5ychetCb30ArluTcQaWyMrmrqqgJwn+XlSSgQA0YmuYSr6johqc1qjCsXFJWbeXZ8x7U7l/eH2v7qk2BWiday4LYaXzW4sCxPmfosskAWPSy3on2+TsC62/BPTRteqz+wk1y0OvaJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tzUYNT8X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E2A4C4CEE7;
	Wed,  6 Aug 2025 08:15:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754468160;
	bh=Fbs+mcsucsTbbAfdd4KqOVe7ihhq3xMWZSnPSsrgkFQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tzUYNT8Xalxuyjn5JF7yGta6JqVi66uQJ+BbyjUmL04iS+TZaM/+LppSVJAnVg4pQ
	 kYzdfZco3vWBTi95h50psAZoaikqE/wlh0X9bNUSdH3lLHLgF5qBIdMhdEndhaQHah
	 u4RVYMufQmBtCcm58SIX17ENIcivOMPkNLbYClBIRRsB2vmrb1Vhbkabj9M+BgOVGg
	 KT5U0lCMuUdvKQ4DYyNgKEK2sQMYGctCc2oMdYXLYR3gib/bXVucP9/FZ7KEAthQo0
	 4bEU+t8p+/SqmpMlR7X8gMfI7HmKNT9UqMfV5MXQDCeiUymAXDLn56Osq3IAoMpddH
	 bsogXwSP11smA==
Date: Wed, 6 Aug 2025 09:15:53 +0100
From: Will Deacon <will@kernel.org>
To: David Hildenbrand <david@redhat.com>
Cc: Dev Jain <dev.jain@arm.com>, akpm@linux-foundation.org,
	ryan.roberts@arm.com, willy@infradead.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, catalin.marinas@arm.com,
	Liam.Howlett@oracle.com, lorenzo.stoakes@oracle.com, vbabka@suse.cz,
	jannh@google.com, anshuman.khandual@arm.com, peterx@redhat.com,
	joey.gouly@arm.com, ioworker0@gmail.com, baohua@kernel.org,
	kevin.brodsky@arm.com, quic_zhenhuah@quicinc.com,
	christophe.leroy@csgroup.eu, yangyicong@hisilicon.com,
	linux-arm-kernel@lists.infradead.org, hughd@google.com,
	yang@os.amperecomputing.com, ziy@nvidia.com
Subject: Re: [PATCH v5 6/7] mm: Optimize mprotect() by PTE batching
Message-ID: <aJMPOTripINrafxh@willie-the-truck>
References: <20250718090244.21092-1-dev.jain@arm.com>
 <20250718090244.21092-7-dev.jain@arm.com>
 <7567c594-7588-49e0-8b09-2a591181b24d@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7567c594-7588-49e0-8b09-2a591181b24d@redhat.com>

On Wed, Aug 06, 2025 at 10:08:33AM +0200, David Hildenbrand wrote:
> On 18.07.25 11:02, Dev Jain wrote:
> > Use folio_pte_batch to batch process a large folio. Note that, PTE
> > batching here will save a few function calls, and this strategy in certain
> > cases (not this one) batches atomic operations in general, so we have
> > a performance win for all arches. This patch paves the way for patch 7
> > which will help us elide the TLBI per contig block on arm64.
> > 
> > The correctness of this patch lies on the correctness of setting the
> > new ptes based upon information only from the first pte of the batch
> > (which may also have accumulated a/d bits via modify_prot_start_ptes()).
> > 
> > Observe that the flag combination we pass to mprotect_folio_pte_batch()
> > guarantees that the batch is uniform w.r.t the soft-dirty bit and the
> > writable bit. Therefore, the only bits which may differ are the a/d bits.
> > So we only need to worry about code which is concerned about the a/d bits
> > of the PTEs.
> > 
> > Setting extra a/d bits on the new ptes where previously they were not set,
> > is fine - setting access bit when it was not set is not an incorrectness
> > problem but will only possibly delay the reclaim of the page mapped by
> > the pte (which is in fact intended because the kernel just operated on this
> > region via mprotect()!). Setting dirty bit when it was not set is again
> > not an incorrectness problem but will only possibly force an unnecessary
> > writeback.
> > 
> > So now we need to reason whether something can go wrong via
> > can_change_pte_writable(). The pte_protnone, pte_needs_soft_dirty_wp,
> > and userfaultfd_pte_wp cases are solved due to uniformity in the
> > corresponding bits guaranteed by the flag combination. The ptes all
> > belong to the same VMA (since callers guarantee that [start, end) will
> > lie within the VMA) therefore the conditional based on the VMA is also
> > safe to batch around.
> > 
> > Since the dirty bit on the PTE really is just an indication that the folio
> > got written to - even if the PTE is not actually dirty but one of the PTEs
> > in the batch is, the wp-fault optimization can be made. Therefore, it is
> > safe to batch around pte_dirty() in can_change_shared_pte_writable()
> > (in fact this is better since without batching, it may happen that
> > some ptes aren't changed to writable just because they are not dirty,
> > even though the other ptes mapping the same large folio are dirty).
> > 
> > To batch around the PageAnonExclusive case, we must check the corresponding
> > condition for every single page. Therefore, from the large folio batch,
> > we process sub batches of ptes mapping pages with the same
> > PageAnonExclusive condition, and process that sub batch, then determine
> > and process the next sub batch, and so on. Note that this does not cause
> > any extra overhead; if suppose the size of the folio batch is 512, then
> > the sub batch processing in total will take 512 iterations, which is the
> > same as what we would have done before.
> > 
> > For pte_needs_flush():
> > 
> > ppc does not care about the a/d bits.
> > 
> > For x86, PAGE_SAVED_DIRTY is ignored. We will flush only when a/d bits
> > get cleared; since we can only have extra a/d bits due to batching,
> > we will only have an extra flush, not a case where we elide a flush due
> > to batching when we shouldn't have.
> > 
> > Signed-off-by: Dev Jain <dev.jain@arm.com>
> 
> 
> I wanted to review this, but looks like it's already upstream and I suspect
> it's buggy (see the upstream report I cc'ed you on)

Please excuse my laziness, but do you have a link to the report? I've
been looking at some oddities on arm64 coming back from some of the CI
systems and was heading in the direction of a recent mm regression
judging by the first-known-bad-build in linux-next.

https://lore.kernel.org/r/CA+G9fYumD2MGjECCv0wx2V_96_FKNtFQpT63qVNrrCmomoPYVQ@mail.gmail.com

Will

