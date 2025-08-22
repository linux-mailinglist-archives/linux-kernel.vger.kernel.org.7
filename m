Return-Path: <linux-kernel+bounces-782509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0EE8B32166
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 19:18:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48147AA82D2
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 17:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 877DD27701E;
	Fri, 22 Aug 2025 17:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EFGePOGa"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48524214A6A
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 17:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755883101; cv=none; b=KyeFfa9uwpnixEpQONmDYfUdMdylK9VDNI/eNQYmEEEO5JNgZ1rqRIK2yXquZCl9jzak+yA5AnXb8SCkKuBugvnJTtKS5nZ5yZl+3Ow82CrDBT3170p+iaL0SzJPou1vLbm21ItLg95LRjQXIfwXqJCdJVGTHrl+f5QBONI/rtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755883101; c=relaxed/simple;
	bh=qCOHcK3j4TNkKx0iUT3lYngH9vUkVeQPHiVxX9n9uXw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GgsFi9Boc42rnjYrlpt/M5PCMIfbpl9vFkw5q/M1uwnbhGk/dpRoYcoXoLwZ3UDFeb1tf1NNcfgHeYWQlKNxYltWDD/yfbL+3u9kJTZdL0HH3prWqTMnZNzYHklY1iaOLVH/D+oei/h1iWxZRiUseIiIkNdzMenU0Mt2Wy6CArQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=EFGePOGa; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=TgAdJ3j72gnDK10Zxbk1Jlr1gL3qO4aUda16rZ52SIc=; b=EFGePOGa6D2SXlxUpDRnjmCtgR
	yQtukIuL7IB5xaiOeg3u1jG2TssWZ64qIqI+TewseLBkChcx2+xSm69lZLM8FK8WbJSGoY/RP23yI
	WY79LyvzwIAlAGiTsyvo6Q18e/Vd5vjxYbX/xNsdnpB2PWx4T+LFGTbVFKmLwVotVNS7nKPPSlRO0
	b1ymmdHBMN4a8A1fm6/889OWlGZTj5Qg9/WWlpshs2MrPhbVhrfCXx1yImIwU4XUiU5D8rja0sY9q
	TdedtQXlnhupdQLxVtQDduSnCJYRRocNwY99v/JzUKhHUOFwo/SrCRGNTXFSwB5W5THmjkl5ec5JK
	HGWRWnyQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1upVP1-0000000ASDO-1DGI;
	Fri, 22 Aug 2025 17:18:11 +0000
Date: Fri, 22 Aug 2025 18:18:11 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Brendan Jackman <jackmanb@google.com>, peterz@infradead.org,
	bp@alien8.de, dave.hansen@linux.intel.com, mingo@redhat.com,
	tglx@linutronix.de, akpm@linux-foundation.org, david@redhat.com,
	derkling@google.com, junaids@google.com,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, reijiw@google.com,
	rientjes@google.com, rppt@kernel.org, vbabka@suse.cz,
	x86@kernel.org, yosry.ahmed@linux.dev,
	Liam Howlett <liam.howlett@oracle.com>,
	"Kirill A. Shutemov" <kas@kernel.org>,
	Harry Yoo <harry.yoo@oracle.com>, Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>, Andy Lutomirski <luto@kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>, Kees Cook <kees@kernel.org>
Subject: Re: [Discuss] First steps for ASI (ASI is fast again)
Message-ID: <aKimU6tf7-RnwISE@casper.infradead.org>
References: <20250812173109.295750-1-jackmanb@google.com>
 <cdccc1a6-c348-4cae-ab70-92c5bd3bd9fd@lucifer.local>
 <DC83J9RSZZ0E.3VKGEVIDMSA2R@google.com>
 <05c32a14-805c-4603-9afc-80e8f29b7957@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <05c32a14-805c-4603-9afc-80e8f29b7957@lucifer.local>

On Fri, Aug 22, 2025 at 03:22:04PM +0100, Lorenzo Stoakes wrote:
> > What I think we can do is an mm-global flush whenever there's a
> > possibility that the process is losing logical access to a physical
> > page. So basically I think that's whenever we evict from the page cache,
> > or the user closes a file.
> >
> > ("Logical access" = we would let them do a read() that gives them the
> > contents of the page).
> >
> > The key insight is that a) those events are reeelatively rare and b)
> > already often involve big TLB flushes. So doing global flushes there is
> > not that bad, and this allows us to forget about all the particular
> > details of which pages might have TLB entries on which CPUs and just say
> > "_some_ CPU in this MM might have _some_ stale TLB entry", which is
> > simple and efficient to track.
> 
> I guess rare to get truncation mid-way through a read(), closing it mid-way
> would be... a bug surely? :P

Truncation isn't a problem.  The contents of the file were visible to
the process before.  The folio can't get recycled while we have a
reference to it.  You might get stale data, but that's just the race
going one way instead of the other.

> > > Hmm, CoW generally a pain. Could you go into more detail as to what's the issue
> > > here?
> >
> > It's just that you have two user pages that you wanna touch at once
> > (src, dst). This crappy ephmap implementation doesn't suppport two
> > mappings at once in the same context, so the second allocation fails, so
> > you always get an asi_exit().
> 
> Right... well like can we just have space for 2 then? ;) it's mappings not
> actually allocating pages so... :)

For reference, kmap_local/atomic supports up to 16 at once.  That may
be excessive, but it's cheap.  Of course, kmap only supports a single
page at a time, not an entire folio.  Now, the tradeoffs for kmap_local
are based on how much address space is available to a 32-bit process (ie
1GB, shared between lowmem, vmalloc space, ioremap space, kmap space,
and probably a bunch of things I'm forgetting.

There's MUCH more space available on 64-bit and I'm sure we can find
32MB to allow us to map 16 * 2MB folios.  We can even make it easy and
always map on 2MB boundaries.  We might get into A Bit Of Trouble if
we decide that we want to map x86 1GB pages or ARM 512MB (I think ARM
actually goes up to 4TB theoretically).

If we're going this way, we might want to rework
folio_test_partial_kmap() callers to instead ask "what is the mapped
boundary of this folio", which might actually clean them up a bit.


