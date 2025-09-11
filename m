Return-Path: <linux-kernel+bounces-812909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E993CB53E08
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 23:47:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2B5B18A0003
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 21:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C46392DF6E6;
	Thu, 11 Sep 2025 21:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="H3dLQbcD"
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE53F2DEA7B
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 21:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757627100; cv=none; b=Ztl8VHrnIslDt9KVPbWKik/eUA7N3D1qGg1e/ALKmKx+GGyqCo0CAEMj3xVrn3ztC/rT0BQ6L/W37gJ0zB0/VMcEoDFpINk8X+DBouPfAJL1p9pPOmgNhAHYablRYop9q/r/DYpnyqWe0InoGgtbvu4HMvqz6+d0EOMd+u/6KOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757627100; c=relaxed/simple;
	bh=eH6fm5pzpaE7JZf8WIIl08Tft5ebABJ4h0vZtfafd0s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o3cvLZ/VRYtRAmJmkncjSAqHwcHPiHSY0I3pJoah9wfST4n2h3alTfwWYsDveETmEAAIZ+vUaYHpp700Xl1v95EXqwPdDc2X05eB2j4SUAhFZ0LX8d+/ZbWW95BnSZXT+J6PZ3J2yJ9c+3S+Y/5LE80wUJdm8rGAhZa41Dnj5BQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=H3dLQbcD; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 11 Sep 2025 14:44:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757627095;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0A29RAJZH8PG2jCbsFMQRYsD8GmFmnNdYOX2gwfe4Lw=;
	b=H3dLQbcDZZfN0YTwx8Yx5vRwlMz8fXhAnF+DfEkbdJyg3YoJt9VzaKBAzCtvpUS9yIeFog
	aQMsWa9vB6Mj/4XGLcWaJ0A7p8SyBtbbgPBb4rOkMx9j3HHqfFDreElJsT1kJ94gTj6sAu
	6zIXWg2AXMnSItiuKyIxhJFw3Wq1+PU=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, vbabka@suse.cz, 
	mhocko@suse.com, jackmanb@google.com, hannes@cmpxchg.org, ziy@nvidia.com, 
	usamaarif642@gmail.com, 00107082@163.com, pasha.tatashin@soleen.com, 
	souravpanda@google.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] alloc_tag: avoid warnings when freeing non-compound
 "tail" pages
Message-ID: <yfebg4bs4nck7kvc3d3irbxpfja45pcyjbtip2jtcojiv5pj4f@jp53hiso6vga>
References: <20250909233409.1013367-1-surenb@google.com>
 <20250909233409.1013367-4-surenb@google.com>
 <zxbgiqf4d3nlww2xxoea7rud3q4oj2osk657xnhu6r7du4lf3p@es7mqt7joo7b>
 <CAJuCfpFV0d=JSwA8zDpdrg4C2TpTTZypeX0Qype-EFKHho2bQQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpFV0d=JSwA8zDpdrg4C2TpTTZypeX0Qype-EFKHho2bQQ@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Sep 11, 2025 at 01:12:11PM -0700, Suren Baghdasaryan wrote:
> On Thu, Sep 11, 2025 at 1:01 PM Shakeel Butt <shakeel.butt@linux.dev> wrote:
> >
> > On Tue, Sep 09, 2025 at 04:34:09PM -0700, Suren Baghdasaryan wrote:
> > > When freeing "tail" pages of a non-compount high-order page, we properly
> > > subtract the allocation tag counters, however later when these pages are
> > > released, alloc_tag_sub() will issue warnings because tags for these pages
> > > are NULL.
> > > This issue was originally anticipated by Vlastimil in his review [1] and
> > > then recently reported by David.
> > > Prevent warnings by marking the tags empty.
> > >
> > > [1] https://lore.kernel.org/all/6db0f0c8-81cb-4d04-9560-ba73d63db4b8@suse.cz/
> > >
> > > Suggested-by: David Wang <00107082@163.com>
> > > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > > ---
> > >  mm/page_alloc.c | 9 ++++++++-
> > >  1 file changed, 8 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > > index 1760346bbd24..d21a411e807e 100644
> > > --- a/mm/page_alloc.c
> > > +++ b/mm/page_alloc.c
> > > @@ -5240,9 +5240,16 @@ static void ___free_pages(struct page *page, unsigned int order,
> > >               __free_frozen_pages(page, order, fpi_flags);
> > >       else if (!head) {
> > >               pgalloc_tag_sub_pages(tag, (1 << order) - 1);
> > > -             while (order-- > 0)
> > > +             while (order-- > 0) {
> > > +                     /*
> > > +                      * The "tail" pages of this non-compound high-order
> > > +                      * page will have no code tags, so to avoid warnings
> > > +                      * mark them as empty.
> > > +                      */
> > > +                     clear_page_tag_ref(page + (1 << order));
> >
> > Do we need something similar for the release_pages() code path or is it
> > happening already?
> 
> Pages released with release_pages() should have valid tags, so I
> expect no warnings.
> 

Oh so this is orthogonal to your first patch which is replacing
__free_page with release_pages(). This non-compound high-order page is
not an issue in the codepath vm_module_tags_populate(), correct?

