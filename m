Return-Path: <linux-kernel+bounces-771452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5090B2877A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 23:01:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31CF060768E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 21:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E80251CEAA3;
	Fri, 15 Aug 2025 21:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="d75MyhSf"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A5E1E86E
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 21:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755291678; cv=none; b=ggbqfGmPzz/17gp4lCHIYbd4qFzyx7WaDLoh5aN/Q6vJLpJUBvjsQ6uYVDccBr2RjeNCZQ2Zf8F1XBfpaL7BAPSWCMu3J2UFluNBbpn6XoMnPn8ZA4KpV7MX1uo9aI9Yz+hOS79z3LXW8midpW+riJFAlTm5nN0dHMW8R1w2kGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755291678; c=relaxed/simple;
	bh=6on7+z3Z7NbFUiDvbyqyq5WRoYXl/Q+kdhIaiAmNqpc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HZvWrLbVZjY6QsvJUFso1WQaU/QS0hdTJfgPoWwsUoZhioA88tzmovH2EENbZjnXtg40RjlzyjgmRS8IrCyqAa8s7HX4HcD6LeJY3H4ZQoFZ5ihODQWHJ7YfMDi9ZfMgCELnSQaxf6dwOVVRahIPSGpLVwbBNrhQIksYbOjTuXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=d75MyhSf; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=lsEgOfYReDOh4IeScG+w9uvaCMnr2rBubqG/o9UxO2E=; b=d75MyhSfylaCxBv15mdMmnc/s+
	BC717glqDCRGangpTzifcmjgJ6cvDfemaN4bsdJGaBarD0/hLuG7j035DoQ7DppH03tZUNUqkvOUy
	4DPDDXKdtGlkr8AVjgoaxQSbY+5VBi1kj0BcvN9+772k+l3eNNSMKVCDeXU1Jy0H4096RPgFzyNRB
	BgKPqAAyQfQ5sOm4flkDa2/LD3zCTvRJQFR5uWKJahRRwJx9yttwlIjyaeV4lCUia6KyuRMpbC7AE
	aSlyRBlru8S0G1u7rz9nrAT8C0q3vnpKvXHIzpQw+qlxG4G8EkA/y8ZbAcZQiiCXpQbTdtZovSkd4
	4btEHRvw==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1un1Y1-0000000HaoN-3DCg;
	Fri, 15 Aug 2025 21:01:13 +0000
Date: Fri, 15 Aug 2025 22:01:13 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Regression caused by commit 4687fdbb805a ("mm/filemap: Support
 VM_HUGEPAGE for file mappings")
Message-ID: <aJ-gGXNwOMeLBs0W@casper.infradead.org>
References: <87plcw8lyq.fsf@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87plcw8lyq.fsf@linux.dev>

On Fri, Aug 15, 2025 at 11:43:25AM -0700, Roman Gushchin wrote:
> The commit 4687fdbb805a ("mm/filemap: Support VM_HUGEPAGE for file
> mappings") causes a regression in our production for containers
> which are running short on memory. In some cases they are getting
> stuck for hours in a vicious reclaim cycle. Reverting this commit
> fixes the problem.
> 
> As I understand, the intention of the commit is to allocate large folios
> whenever possible, and the idea is to ignore device-specific readahead
> settings and the mmap_miss logic to achieve that, which makes total
> sense.
> 
> However under a heavy memory pressure there must be a mechanism to
> revert to order-0 folios, otherwise the memory pressure is inevitable
> increased. Maybe mmap_miss heuristics should still be applied? Any other
> ideas how to fix it?

What's supposed to happen is that we should have logic like:

                        if (order > min_order)
                                alloc_gfp |= __GFP_NORETRY | __GFP_NOWARN;

so we try a little bit to free memory if we can't allocate an order-9
folio immediately, but we shouldn't be retrying for hours.  Maybe
that got lost somewhere along the line because I don't see it now.

> Also, a side question: I wonder if it makes sense to allocate 1-2
> PMD-sized folios if mapping_large_folio_support() is not there?

Um, we don't?

        if (!mapping_large_folio_support(mapping) || ra->size < min_ra_size)
                goto fallback;


