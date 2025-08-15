Return-Path: <linux-kernel+bounces-771508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA7AEB28835
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 00:12:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39AA85E2C02
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 22:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3707125DB06;
	Fri, 15 Aug 2025 22:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JxjxCkJg"
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF2F619F12D
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 22:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755295969; cv=none; b=BwjruiwKCXedLeF9+9trLC4hY+/9GaxrU933UvondSfbbAKKM1LmtXhw4egM0beN2SbUw//c99pOdkQTWiEo1unjDXeUXiuNwJRkkJ5iEJVeUMA4PLkMHTzvFl7k+aa7SVfer+MohCQnlryD4bLf1vHZs/cjrsLcbP/qW7OP9e8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755295969; c=relaxed/simple;
	bh=XsDjkh8cFdz0pOTA4DpAebSVkpz90zI+N+ArULPuMco=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bx8ls35+8mBBn0TUlRGSycImmlaV93AM43l9XKr/mIkfp8yYm6S63QhvBIwbpv5DtlXbdR5ULk+HmWDcKg5Vdudj9iAtpjrymYGK/9XsqWU9GxV/1S52Dy9MYBX91ScWtrerQJOwBjOFQX/YkLylkKKC4qOoVLZpxY2uzrDDtYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JxjxCkJg; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755295964;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7aMzF7zLYEW4cbiDJEQWA8qoxDxBNLq3HfkBAC7ZA/4=;
	b=JxjxCkJg/4qMeRz3ovAU11EoP3v60Ug/FOMSkRBGceB/7zg+O2z3dM32LXse3Lo2wQklPc
	bDAPS22SJbdrJ3TYHzMEFEPmbaW0/IIeSXBzuOmcmhnEJJQ4LrRanwl9L1THTqw7y2oLnQ
	HuRnRbu4Qc8pMCQi1u1NDNmPqfzx9OU=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Matthew Wilcox <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,  "linux-mm@kvack.org"
 <linux-mm@kvack.org>,  "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: Re: Regression caused by commit 4687fdbb805a ("mm/filemap: Support
 VM_HUGEPAGE for file mappings")
In-Reply-To: <aJ-gGXNwOMeLBs0W@casper.infradead.org> (Matthew Wilcox's message
	of "Fri, 15 Aug 2025 22:01:13 +0100")
References: <87plcw8lyq.fsf@linux.dev> <aJ-gGXNwOMeLBs0W@casper.infradead.org>
Date: Fri, 15 Aug 2025 15:12:39 -0700
Message-ID: <87plcwdyjs.fsf@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Matthew Wilcox <willy@infradead.org> writes:

> On Fri, Aug 15, 2025 at 11:43:25AM -0700, Roman Gushchin wrote:
>> The commit 4687fdbb805a ("mm/filemap: Support VM_HUGEPAGE for file
>> mappings") causes a regression in our production for containers
>> which are running short on memory. In some cases they are getting
>> stuck for hours in a vicious reclaim cycle. Reverting this commit
>> fixes the problem.
>> 
>> As I understand, the intention of the commit is to allocate large folios
>> whenever possible, and the idea is to ignore device-specific readahead
>> settings and the mmap_miss logic to achieve that, which makes total
>> sense.
>> 
>> However under a heavy memory pressure there must be a mechanism to
>> revert to order-0 folios, otherwise the memory pressure is inevitable
>> increased. Maybe mmap_miss heuristics should still be applied? Any other
>> ideas how to fix it?
>
> What's supposed to happen is that we should have logic like:
>
>                         if (order > min_order)
>                                 alloc_gfp |= __GFP_NORETRY | __GFP_NOWARN;
>
> so we try a little bit to free memory if we can't allocate an order-9
> folio immediately, but we shouldn't be retrying for hours.  Maybe
> that got lost somewhere along the line because I don't see it now.

Yeah, I see it in __filemap_get_folio(), but not in ra_alloc_folio().
I'll prepare a fix for this.

>
>> Also, a side question: I wonder if it makes sense to allocate 1-2
>> PMD-sized folios if mapping_large_folio_support() is not there?
>
> Um, we don't?
>
>         if (!mapping_large_folio_support(mapping) || ra->size < min_ra_size)
>                 goto fallback;

Sorry, I wasn't clear, I mean we're still allocating 2-4MB of readahead.
Shouldn't we do something like this instead?

--

diff --git a/mm/filemap.c b/mm/filemap.c
index 983ba1019674..e5fb9034118d 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3222,7 +3222,8 @@ static struct file *do_sync_mmap_readahead(struct vm_fault *vmf)
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
        /* Use the readahead code, even if readahead is disabled */
-       if ((vm_flags & VM_HUGEPAGE) && HPAGE_PMD_ORDER <= MAX_PAGECACHE_ORDER) {
+       if ((vm_flags & VM_HUGEPAGE) && HPAGE_PMD_ORDER <= MAX_PAGECACHE_ORDER &&
+           mapping_large_folio_support(mapping)) {
                fpin = maybe_unlock_mmap_for_io(vmf, fpin);
                ractl._index &= ~((unsigned long)HPAGE_PMD_NR - 1);
                ra->size = HPAGE_PMD_NR;


