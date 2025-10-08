Return-Path: <linux-kernel+bounces-845829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAD71BC63D4
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 20:06:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6CB2405E8D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 18:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 677BA34BA3B;
	Wed,  8 Oct 2025 18:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ilvokhin.com header.i=@ilvokhin.com header.b="1tmZCK1x"
Received: from mail.ilvokhin.com (mail.ilvokhin.com [178.62.254.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F35E519E7F7
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 18:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.62.254.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759946781; cv=none; b=Pg9JUqlONv7FLYACrpVbaHoBmkmXdk+ZYlwDMhff994FKQ1cHRvNv/fx7IJHzOaM00rcEwb+2BQ/lJ4NUrzwKRzRILlyko6qkN8D/fDODYk8kDXBliJf4mem1bM5PPQj9IkasF8OximvHSvw6qCHne/U0y09XTbES1tigVZWX08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759946781; c=relaxed/simple;
	bh=gPDdXHwGDPPwhVUKlfga4XOXSDCs1lm1NRlIg9spABk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VwVmY49WC/fp3cha//aJyZxJIJw8fMq0U0Jw0JR19TI7Y3f/BoxR0Ks5dqHl52nLVfkjEyqpxNy+RauEDTRs+0+DNAM2L3sLZJMFRPcrZ/0tYVqwKTHV9qR8UqIMCGiQe3veGNoLs47qtig1LQjBGb7ntRyEAGxVV3NloJusKTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ilvokhin.com; spf=pass smtp.mailfrom=ilvokhin.com; dkim=pass (1024-bit key) header.d=ilvokhin.com header.i=@ilvokhin.com header.b=1tmZCK1x; arc=none smtp.client-ip=178.62.254.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ilvokhin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ilvokhin.com
Received: from shell.ilvokhin.com (shell.ilvokhin.com [138.68.190.75])
	(Authenticated sender: d@ilvokhin.com)
	by mail.ilvokhin.com (Postfix) with ESMTPSA id 9E6F29305A;
	Wed, 08 Oct 2025 18:06:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ilvokhin.com;
	s=mail; t=1759946771;
	bh=16JmNkh/L9J4E7GX4fUjY6xQHv/dDmWkutKst5l0AuI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=1tmZCK1xDLJY1mwyn5+k+gXAM/CsAd+zcMYGvjqdJ4HUf9aOb/PgympVIgtUtxGut
	 ObW3bpDePslTWcJRn49K67MSfNylKstPsmlPZjy6W3wxa9gat59jREPBBMIo3M6JFg
	 XtZGrjt65SQ/0jW/Ua0H25O4Vfwkw5222rJqKzlY=
Date: Wed, 8 Oct 2025 18:06:07 +0000
From: Dmitry Ilvokhin <d@ilvokhin.com>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Kairui Song <kasong@tencent.com>, Nhat Pham <nphamcs@gmail.com>,
	Baoquan He <bhe@redhat.com>, Barry Song <baohua@kernel.org>,
	Chris Li <chrisl@kernel.org>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
	Kiryl Shutsemau <kas@kernel.org>,
	Usama Arif <usamaarif642@gmail.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com,
	hughd@google.com, yangge1116@126.com, david@redhat.com
Subject: Re: [PATCH v2] mm: skip folio_activate() for mlocked folios
Message-ID: <aOaoD0HQk7YPeLkE@shell.ilvokhin.com>
References: <aOPDRmk2Zd20qxfk@shell.ilvokhin.com>
 <ltvv3v4vibvlglpch6urayotenavpzxc7klbcyowjb4wrv3e7z@pzovtvtbmnsp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ltvv3v4vibvlglpch6urayotenavpzxc7klbcyowjb4wrv3e7z@pzovtvtbmnsp>

On Wed, Oct 08, 2025 at 09:17:49AM -0700, Shakeel Butt wrote:
> [Somehow I messed up the subject, so resending]
> 
> Cc Hugh, yangge, David
> 
> On Mon, Oct 06, 2025 at 01:25:26PM +0000, Dmitry Ilvokhin wrote:
> > __mlock_folio() does not move folio to unevicable LRU, when
> > folio_activate() removes folio from LRU.
> > 
> > To prevent this case also check for folio_test_mlocked() in
> > folio_mark_accessed(). If folio is not yet marked as unevictable, but
> > already marked as mlocked, then skip folio_activate() call to allow
> > __mlock_folio() to make all necessary updates. It should be safe to skip
> > folio_activate() here, because mlocked folio should end up in
> > unevictable LRU eventually anyway.
> > 
> > To observe the problem mmap() and mlock() big file and check Unevictable
> > and Mlocked values from /proc/meminfo. On freshly booted system without
> > any other mlocked memory we expect them to match or be quite close.
> > 
> > See below for more detailed reproduction steps. Source code of stat.c is
> > available at [1].
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
> > Acked-by: Usama Arif <usamaarif642@gmail.com>
> > ---
> > Changes in v2:
> >   - Rephrase commit message: frame it in terms of unevicable LRU, not stat
> >     accounting.
> > 
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
> 
> This makes sense as activating an mlocked folio should be a noop but I
> am wondering why we are seeing this now. By this, I mean mlock()ed
> memory being delayed to get to unevictable LRU. Also I remember Hugh
> recently [1] removed the difference betwen mlock percpu cache and other
> percpu caches of clearing LRU bit on entry. Does you repro work even
> with Hugh's changes or without it?
>

Thanks Shakeel for mentioning Hugh's patch, I was not aware of it.
Indeed, I could not reproduce problem on top of Hugh's patch anymore,
which totally make sense, because folio_test_clear_lru() is gone from
__folio_batch_add_and_move().

Now I wonder does folio_test_mlocked() check still make sense in the
current codebase?

> [1] https://lore.kernel.org/all/05905d7b-ed14-68b1-79d8-bdec30367eba@google.com/

