Return-Path: <linux-kernel+bounces-842986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D5581BBE229
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 15:05:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B611018859C7
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 13:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EDCF28D830;
	Mon,  6 Oct 2025 13:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ilvokhin.com header.i=@ilvokhin.com header.b="0HtQHuSZ"
Received: from mail.ilvokhin.com (mail.ilvokhin.com [178.62.254.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E9726E16F
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 13:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.62.254.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759755910; cv=none; b=jpjDZGwzo3Z47hWh019LJB3GKw9VunK6FPgwqfjdWQUN+gWSYN2fXsuCu1rGno8Q2o1k+TDP5y0+O+dEMy+YA78xT3lVhxt7/ytC0uCn5s2N7e61ejylbcB0ZdneR95mbE/zFGg1Bt0cZo4PrLT3bL1MLy1XT797OOWtcRu7rBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759755910; c=relaxed/simple;
	bh=HbbN7IS7sUncjPHukdoVKn7KhBTUeI3i3KR4BF3ztyY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RyaazIJxqfY/M4OwA6iGAuOo5zI8fgyjYs1jLCvtQRST7qlkXfcUqjgYrIsmknPuf2aimH9yShru+fMIeOapmzeHSYv1zT+OShbQ4KpEFrMTELvJBk7f4PwN7QxYgDqtT/cagbHN0ZdkXmB43uBlgflDWwH2bGpxvkPqNYqX4XA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ilvokhin.com; spf=pass smtp.mailfrom=ilvokhin.com; dkim=pass (1024-bit key) header.d=ilvokhin.com header.i=@ilvokhin.com header.b=0HtQHuSZ; arc=none smtp.client-ip=178.62.254.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ilvokhin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ilvokhin.com
Received: from shell.ilvokhin.com (shell.ilvokhin.com [138.68.190.75])
	(Authenticated sender: d@ilvokhin.com)
	by mail.ilvokhin.com (Postfix) with ESMTPSA id B73FE92EF7;
	Mon, 06 Oct 2025 13:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ilvokhin.com;
	s=mail; t=1759755906;
	bh=afYS5PVhnvRrPOZj/B9ZhYZyPYcWHB/01N4lbx0g2tI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=0HtQHuSZBnFpUkGKMfHfoapqemFnAl/1IcRfsDbXw3mDcs2EdZ43Nt/zc8t3t0W5O
	 lB+aP+Vha7opGAjDUK3kU8wcBAiagcFunY2MAd7I/UwPgvGtiBmysvSNH83WzZde3A
	 UwNc6U/UyJw37ZLfU0xsEFGZNPv/CSgIsVw2PFR8=
Date: Mon, 6 Oct 2025 13:05:05 +0000
From: Dmitry Ilvokhin <d@ilvokhin.com>
To: Usama Arif <usamaarif642@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Kairui Song <kasong@tencent.com>, Nhat Pham <nphamcs@gmail.com>,
	Baoquan He <bhe@redhat.com>, Barry Song <baohua@kernel.org>,
	Chris Li <chrisl@kernel.org>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
	Kiryl Shutsemau <kas@kernel.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH] mm: skip folio_activate() for mlocked folios
Message-ID: <aOO-gUHQmF6zyLwM@shell.ilvokhin.com>
References: <aN_bix3wDpwYPoVp@shell.ilvokhin.com>
 <550dd78f-bf85-41d6-9c3b-472784b2d94e@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <550dd78f-bf85-41d6-9c3b-472784b2d94e@gmail.com>

On Fri, Oct 03, 2025 at 03:36:08PM +0100, Usama Arif wrote:
> 
> 
> On 03/10/2025 15:19, Dmitry Ilvokhin wrote:
> > __mlock_folio() should update stats, when lruvec_add_folio() is called,
> > but if folio_test_clear_lru() check failed, then __mlock_folio() gives
> 
> nit: s/failed/fails/

I'll cut commit message in v2, so phrase will not be there anymore.

> > up early. From the other hand, folio_mark_accessed() calls
> 
> nit: s/From/On/

This one as well.

> > folio_activate() which also calls folio_test_clear_lru() down the line.
> > When folio_activate() successfully removed folio from LRU,
> > __mlock_folio() will not update any stats, which will lead to inaccurate
> > values in /proc/meminfo as well as cgroup memory.stat.
> > 
> > To prevent this case from happening also check for folio_test_mlocked()
> > in folio_mark_accessed(). If folio is not yet marked as unevictable, but
> > already marked as mlocked, then skip folio_activate() call to allow
> > __mlock_folio() to make all necessary updates.
> 
> Would it make sense to write over here that its safe to skip activating
> an mlocked folio?

Good point, will mention that, because that's my understanding as well.
I think mlocked folio should end up in the unevictable LRU eventually
and if so, mlocked folio being in active LRU is temporary anyway, so it
is should be safe to skip folio_activate() for mlocked folios.

> > 
> > To observe the problem mmap() and mlock() big file and check Unevictable
> > and Mlocked values from /proc/meminfo. On freshly booted system without
> > any other mlocked memory we expect them to match or be quite close.
> > 
> > See below for more detailed reproduction steps. Source code of stat.c
> > is available at [1].
> > 
> >   $ head -c 8G < /dev/urandom > /tmp/random.bin
> > 
> >   $ cc -pedantic -Wall -std=c99 stat.c -O3 -o /tmp/stat
> >   $ /tmp/stat
> >   Unevictable:     8389668 kB
> >   Mlocked:         8389700 kB
> > 
> >   Need to run binary twice. Problem does not reproduce on the first run,
> >   but always reproduces on the second run.
> > 
> >   $ /tmp/stat
> >   Unevictable:     5374676 kB
> >   Mlocked:         8389332 kB
> > 
> > [1]: https://gist.github.com/ilvokhin/e50c3d2ff5d9f70dcbb378c6695386dd
> > 
> > Co-developed-by: Kiryl Shutsemau <kas@kernel.org>
> > Signed-off-by: Kiryl Shutsemau <kas@kernel.org>
> > Signed-off-by: Dmitry Ilvokhin <d@ilvokhin.com>
> > ---
> 
> 
> Thanks for the patch!
> 
> Personally I would just use the comment you have written below to create the commit message.
> You probably dont really need to write all the function calls paths?
> 

I'll cut commit message a bit in v2 and make it more succinct, thanks
for the feedback.

> Also, I don't think you need () for all the functions in the commit message, although
> thats my personal preference.
> 
> Apart from changes in the commit message, lgtm.
> 
> Feel free to add after commit message fixups.
> 
> Acked-by: Usama Arif <usamaarif642@gmail.com>
> 

Thanks for the review.

> 
> >  mm/swap.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> > 
> > diff --git a/mm/swap.c b/mm/swap.c
> > index 2260dcd2775e..f682f070160b 100644
> > --- a/mm/swap.c
> > +++ b/mm/swap.c
> > @@ -469,6 +469,16 @@ void folio_mark_accessed(struct folio *folio)
> >  		 * this list is never rotated or maintained, so marking an
> >  		 * unevictable page accessed has no effect.
> >  		 */
> > +	} else if (folio_test_mlocked(folio)) {
> > +		/*
> > +		 * Pages that are mlocked, but not yet on unevictable LRU.
> > +		 * They might be still in mlock_fbatch waiting to be processed
> > +		 * and activating it here might interfere with
> > +		 * mlock_folio_batch(). __mlock_folio() will fail
> > +		 * folio_test_clear_lru() check and give up. It happens because
> > +		 * __folio_batch_add_and_move() clears LRU flag, when adding
> > +		 * folio to activate batch.
> > +		 */
> >  	} else if (!folio_test_active(folio)) {
> >  		/*
> >  		 * If the folio is on the LRU, queue it for activation via
> 

