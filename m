Return-Path: <linux-kernel+bounces-842992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 223AFBBE25F
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 15:13:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 63F7B34AC61
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 13:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ABD929B200;
	Mon,  6 Oct 2025 13:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ilvokhin.com header.i=@ilvokhin.com header.b="l3eGI8Us"
Received: from mail.ilvokhin.com (mail.ilvokhin.com [178.62.254.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 072CA28CF42
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 13:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.62.254.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759756401; cv=none; b=Ma0+9XkKLNSswLCDDyxgPz8ghYNnfGQLu8HdSTCcZdV6J78qAXco0ktgzzHeJGOnrYLzsKwPTNIEPbX2qeEevkkBRkKbWYHnr68DNIIREqyWbKPogctlabF9NxCp7hVvMUE+FR2QwZl+A00DZJ7mFEUYKPn61hRkWLC7iO2G7ZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759756401; c=relaxed/simple;
	bh=1UEEWkH5//PrU6Nrh0T/VNYOo6LAPA69+n94q5/dC3k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qs0CDcaXfx29v10c09AKAPYzNsCEJ/otFQyiiVEurZzgYSgbbCF9uQ9VeYlhdN5rXds35JMBSQensHUt6Lmj0C/cMcpGpTaDImv5V7Gc1HhA0aOYIGqi0MDGiWsC14XihBqFhYXD7mGiTScIxvmhz22QLbqa1fualvhLqQe8unI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ilvokhin.com; spf=pass smtp.mailfrom=ilvokhin.com; dkim=pass (1024-bit key) header.d=ilvokhin.com header.i=@ilvokhin.com header.b=l3eGI8Us; arc=none smtp.client-ip=178.62.254.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ilvokhin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ilvokhin.com
Received: from shell.ilvokhin.com (shell.ilvokhin.com [138.68.190.75])
	(Authenticated sender: d@ilvokhin.com)
	by mail.ilvokhin.com (Postfix) with ESMTPSA id E921E92EFE;
	Mon, 06 Oct 2025 13:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ilvokhin.com;
	s=mail; t=1759756397;
	bh=hr1104ycRcsIOhou1aWTfKsVmRoAhTvW0HOxhU8+Ze0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=l3eGI8UsFrKDophnQmoitZ7Bot8B/Y3z/mfTGaDPGlYmKV4M3WyP2Y6ILAxAzzPfU
	 y4ogsiKwug6iSlcJkWwJwBecKxAN5FMxZ+wvGszHOg6iy9UxLcBvzrmTs9tYHuqs1V
	 o5dxZeOKkey/PoHSciSxIJ+X0jYVCd9ZCtsVEcXI=
Date: Mon, 6 Oct 2025 13:13:15 +0000
From: Dmitry Ilvokhin <d@ilvokhin.com>
To: Kiryl Shutsemau <kas@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Kairui Song <kasong@tencent.com>, Nhat Pham <nphamcs@gmail.com>,
	Baoquan He <bhe@redhat.com>, Barry Song <baohua@kernel.org>,
	Chris Li <chrisl@kernel.org>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
	Usama Arif <usamaarif642@gmail.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH] mm: skip folio_activate() for mlocked folios
Message-ID: <aOPAay5im1lJhHFm@shell.ilvokhin.com>
References: <aN_bix3wDpwYPoVp@shell.ilvokhin.com>
 <hnpzad4aehmp6ncgwhlinzx55z3zst5dlkhsjphpazccy5lzpv@hfj2eyewuplz>
 <aOOxAtD9oeiYlo7G@shell.ilvokhin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aOOxAtD9oeiYlo7G@shell.ilvokhin.com>

On Mon, Oct 06, 2025 at 12:07:48PM +0000, Dmitry Ilvokhin wrote:
> On Fri, Oct 03, 2025 at 03:41:05PM +0100, Kiryl Shutsemau wrote:
> > On Fri, Oct 03, 2025 at 02:19:55PM +0000, Dmitry Ilvokhin wrote:
> > > __mlock_folio() should update stats, when lruvec_add_folio() is called,
> > 
> > The update of stats is incidental to moving to unevicable LRU. But okay.
> > 
> 
> Good point. I'll rephrase commit message in terms of unevicable
> LRU instead of stat updates in v2.
> 
> > > but if folio_test_clear_lru() check failed, then __mlock_folio() gives
> > > up early. From the other hand, folio_mark_accessed() calls
> > > folio_activate() which also calls folio_test_clear_lru() down the line.
> > > When folio_activate() successfully removed folio from LRU,
> > > __mlock_folio() will not update any stats, which will lead to inaccurate
> > > values in /proc/meminfo as well as cgroup memory.stat.
> > > 
> > > To prevent this case from happening also check for folio_test_mlocked()
> > > in folio_mark_accessed(). If folio is not yet marked as unevictable, but
> > > already marked as mlocked, then skip folio_activate() call to allow
> > > __mlock_folio() to make all necessary updates.
> > > 
> > > To observe the problem mmap() and mlock() big file and check Unevictable
> > > and Mlocked values from /proc/meminfo. On freshly booted system without
> > > any other mlocked memory we expect them to match or be quite close.
> > > 
> > > See below for more detailed reproduction steps. Source code of stat.c
> > > is available at [1].
> > > 
> > >   $ head -c 8G < /dev/urandom > /tmp/random.bin
> > > 
> > >   $ cc -pedantic -Wall -std=c99 stat.c -O3 -o /tmp/stat
> > >   $ /tmp/stat
> > >   Unevictable:     8389668 kB
> > >   Mlocked:         8389700 kB
> > > 
> > >   Need to run binary twice. Problem does not reproduce on the first run,
> > >   but always reproduces on the second run.
> > > 
> > >   $ /tmp/stat
> > >   Unevictable:     5374676 kB
> > >   Mlocked:         8389332 kB
> > 
> > I think it is worth starting with the problem statement.
> > 
> > I like to follow this pattern of commit messages:
> > 
> > <Background, if needed>
> > 
> > <Issue statement>
> > 
> > <Proposed solution>
> >
> 
> Thanks for suggestion, v2 commit message will much this pattern.
> 
> > > 
> > > [1]: https://gist.github.com/ilvokhin/e50c3d2ff5d9f70dcbb378c6695386dd
> > > 
> > > Co-developed-by: Kiryl Shutsemau <kas@kernel.org>
> > > Signed-off-by: Kiryl Shutsemau <kas@kernel.org>
> > > Signed-off-by: Dmitry Ilvokhin <d@ilvokhin.com>
> > 
> > Your Co-developed-by is missing. See submitting-patches.rst.
> > 
> 
> I followed an example of a patch submitted by the From: author from
> submitting-patches.rst. This example doesn't have Co-developed-by tag
> from the From Author. That's being said, I found both cases usage in the
> mm commit log, so I'll add mine Co-developed-by tag in the v2.

Turns out scripts/checkpatch.pl is able to catch that with the following
message: "Co-developed-by: should not be used to attribute nominal patch
author", so I'll obey automation suggestion here and will not add mine
Co-developed-by tag here.

> 
> > > ---
> > >  mm/swap.c | 10 ++++++++++
> > >  1 file changed, 10 insertions(+)
> > > 
> > > diff --git a/mm/swap.c b/mm/swap.c
> > > index 2260dcd2775e..f682f070160b 100644
> > > --- a/mm/swap.c
> > > +++ b/mm/swap.c
> > > @@ -469,6 +469,16 @@ void folio_mark_accessed(struct folio *folio)
> > >  		 * this list is never rotated or maintained, so marking an
> > >  		 * unevictable page accessed has no effect.
> > >  		 */
> > > +	} else if (folio_test_mlocked(folio)) {
> > > +		/*
> > > +		 * Pages that are mlocked, but not yet on unevictable LRU.
> > > +		 * They might be still in mlock_fbatch waiting to be processed
> > > +		 * and activating it here might interfere with
> > > +		 * mlock_folio_batch(). __mlock_folio() will fail
> > > +		 * folio_test_clear_lru() check and give up. It happens because
> > > +		 * __folio_batch_add_and_move() clears LRU flag, when adding
> > > +		 * folio to activate batch.
> > > +		 */
> > >  	} else if (!folio_test_active(folio)) {
> > >  		/*
> > >  		 * If the folio is on the LRU, queue it for activation via
> > > -- 
> > > 2.47.3
> > > 
> > 
> > -- 
> >   Kiryl Shutsemau / Kirill A. Shutemov

