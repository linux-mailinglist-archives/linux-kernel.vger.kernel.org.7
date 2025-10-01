Return-Path: <linux-kernel+bounces-838896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45825BB05FF
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 14:47:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05DC54C00CD
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 12:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 282F82EBBB8;
	Wed,  1 Oct 2025 12:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="P//ecjFt"
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E741CD15
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 12:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759322854; cv=none; b=EjLj62PIaFweMGOcPjG0TvRVOuSbzAQT3KkOIGyETyO+BRbDMqihp5hrrw5LOObc27tQVO/g53jtMZvxrQXhlz4t6TaX8zBIGu4wY3FUDt4ZBZIYC9s8blp6j7/bUByZK72FcTHP+hGA/9fC4diM//0F+2rS0p+MS802AuyxQEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759322854; c=relaxed/simple;
	bh=hhyWrJ7QAVi4G2Cn9/CA+nwXDWpcD2esXxuE9Y0cMYM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d3wYdav5MadHdG/dXFE8bbbweGKDdymlGVJsL8cJLD4hmthHlr2n23POV3YB62cs2FAxbFtPhEzdu9Sg1Pt7pihqu+6KsrsQ9SUFjqDPxS5Nv8yz8xSkY58ARBhIFGiJAXnoGMsFzX0i03criw1KvJ56rHvycoF4z9H5jV1718Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=P//ecjFt; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 1 Oct 2025 12:47:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1759322844;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8jbAq27x+6Ohu5C8t37JTrdMMIEZluW2VP8UzF113Oo=;
	b=P//ecjFtKiJHDjV1XNDMgZMod3wG/g+N0uto8cBhW/w2QUokuv+5sjW9PjMVw0541JzVn7
	/+iVWORug+p8yhf03THXsQackG2BTLJZapgBOYiszUzGePwoidnACPcC59PDr+Z3sDAd0e
	0aLjqGO3yym+RrB5xV0wcTX8Ub77vO0=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Jan Kara <jack@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-mm@kvack.org
Subject: Re: [PATCH] mm: readahead: make thp readahead conditional to
 mmap_miss logic
Message-ID: <aN0i107IF0oQ_PQb@google.com>
References: <20250930054815.132075-1-roman.gushchin@linux.dev>
 <hm56lqfeqcpjjpwkzuo4ktv7ayt763htehpi7ie2d47q52gm3w@mgbj42ivvv5g>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <hm56lqfeqcpjjpwkzuo4ktv7ayt763htehpi7ie2d47q52gm3w@mgbj42ivvv5g>
X-Migadu-Flow: FLOW_OUT

On Wed, Oct 01, 2025 at 01:35:39PM +0200, Jan Kara wrote:
> On Tue 30-09-25 07:48:15, Roman Gushchin wrote:
> > Commit 4687fdbb805a ("mm/filemap: Support VM_HUGEPAGE for file mappings")
> > introduced a special handling for VM_HUGEPAGE mappings: even if the
> > readahead is disabled, 1 or 2 HPAGE_PMD_ORDER pages are
> > allocated.
> > 
> > This change causes a significant regression for containers with a
> > tight memory.max limit, if VM_HUGEPAGE is widely used. Prior to this
> > commit, mmap_miss logic would eventually lead to the readahead
> > disablement, effectively reducing the memory pressure in the
> > cgroup. With this change the kernel is trying to allocate 1-2 huge
> > pages for each fault, no matter if these pages are used or not
> > before being evicted, increasing the memory pressure multi-fold.
> > 
> > To fix the regression, let's make the new VM_HUGEPAGE conditional
> > to the mmap_miss check, but keep independent from the ra->ra_pages.
> > This way the main intention of commit 4687fdbb805a ("mm/filemap:
> > Support VM_HUGEPAGE for file mappings") stays intact, but the
> > regression is resolved.
> > 
> > The logic behind this changes is simple: even if a user explicitly
> > requests using huge pages to back the file mapping (using VM_HUGEPAGE
> > flag), under a very strong memory pressure it's better to fall back
> > to ordinary pages.
> > 
> > Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
> > Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
> > Cc: Jan Kara <jack@suse.cz>
> > Cc: linux-mm@kvack.org
> 
> It would be good to get confirmation from Matthew that indeed this
> preserves what he had in mind with commit 4687fdbb805a92 but the change
> looks good to me.

Hi Jan!

Matthew and myself had a chat about this issue last week at Kernel Recipes
conference and in general agreed on this approach. But of course,
an explicit Ack from him will be appreciated.

Long-term it would be great to use a better metric for memory pressure
here, e.g. PSI. But it's far from trivial.

> Feel free to add:
> 
> Reviewed-by: Jan Kara <jack@suse.cz>

Thank you!

