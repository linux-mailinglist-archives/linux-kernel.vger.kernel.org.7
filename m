Return-Path: <linux-kernel+bounces-863847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B349BF942E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 01:39:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E9D024F2056
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 23:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B35D2C159A;
	Tue, 21 Oct 2025 23:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="OXiEj+wP"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E032BE655
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 23:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761089980; cv=none; b=ScFBEfozBqdAPPgiEFylvpLFHXtDt5V0dCeUSpDEXx8JoU0QU5wzbd6hY+TCy1Yz2lbVn6LmDFuxhuck70z/8UxC93EGyYqsnOKv8ovV5Kp5xWCf56eYIZgoUrG686mTxazMyua+LoO0OsRPcrBhVWZSD6ta1uifp6OMveZv29k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761089980; c=relaxed/simple;
	bh=uE6R0xgGK28/CHgA533bB00Mwj2oIm/4Ink+mD+7h90=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lzl6FhQPxYaS7+bIGWZis+Xm147ZWaFI28e3GGL92gFB0wOMcfRSwp0xw6xbeZm3z7ENrvblzxWlxR3SGPlLBhyeWd8BdK7Cr687crnYbDFZJyJ42tSjLi5ErqlT/5Y5rylBzuZ3eWzZKNY4/4UZzhvWpFea12mRcLKN7ifjpHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=OXiEj+wP; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-782bfd0a977so4597754b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 16:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1761089978; x=1761694778; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ekz2VvXis0CGgykoGefhdHPuzvi4qz8tP9mZjwte4JE=;
        b=OXiEj+wP6lJ/KRjZH95Z1ThhYlDJOdfT9XeoG7CFq5ozwwwW4qpoCtTuZmK6Dp57J+
         SM5nym47cWult5crmWn0VN/IKQsvP05uVqMMvwcCkUduFsiD8/emPSsbQeq8l76rIGCl
         pblXh9+5xjLWZNxEJLGUz2fXbsvSXIvRD8cj8t7ZZc7Uq/tGTT4OnKZh2Ei12j9PXB7b
         n0JcGBGeDFFGpEI8CnPv3atnxLGXUdHVbGG5Wxnm9RGcEIge3BKU1/Wzul1QbgxN2A+4
         XyYc+xVCHDOQxPjuR7VCwJDCgdbSwk5Yindvh9fBF00LeqeU7MUleKupWFmXZiEQMVnE
         GWLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761089978; x=1761694778;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ekz2VvXis0CGgykoGefhdHPuzvi4qz8tP9mZjwte4JE=;
        b=d0tgj8Yd+dPgI03WaoVlXcOvEXJGrTnOmdZzPvhU4/YAZytbi0QzN3BS8b+rGybOu5
         D6ElfYir0G6/ymVjGQ4XoKO6VZF8sNuCFLY2BXLW18RugNp55q3aIRw/ugQU10+dfPI4
         3s5wm4Mkres5VvWzUwiouABZslcxhA7CnrzEzAp68Nw9rQCrJc88FdN08yCDP7EDtO3r
         y8NRiLffUZjq7OvXzlflGDxfSrsHdXaFh1CLNg2k58n5+1CKTbv2JWL/Cn7gTfo1MRx8
         NpFBQWZvyxNcjAYefavKs3sZO6xWk55NGPO31tgMWtXLyRvMY1/7Mk1QxZ9XRu5DIJQB
         KSgw==
X-Forwarded-Encrypted: i=1; AJvYcCXhi9TVMJVsLw4o6jZ5g0OGoDAIpaEwYTSKZ7kEoCTARfNq4nequ3+2I6zADNR97qrJE8L1778eq2TZsWE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+U/xvcAQSvAUPNscO19DOtthK4QpQoeM24IljNUdoLjaoc9mG
	ibppFjoSg+ixVZBLfguadGSfnEG+fvQzlXpkizECQ/7De2YPr3dmsVeDHeBkebRPT1w=
X-Gm-Gg: ASbGnctK97mX2FJrnBTx8GyeFU1yLvX8BlA5T4pTXQZ33Gz302pFDDjfUsvo8ZA5J5P
	sNcVEaPrqa6TfyJqwcvknxQYWv992Bil9os/YfiCjTcaCoqd6FL6+6RF07Xg6VGQ9/IDfs3Bsdz
	hNJalYFdzKLKkXxZUJVjZ1wQaMduzgSiDxMe0vZnuF4v0NdqrGIe9TG1rW1zL4F5g1uME5ysS21
	lcQpkkQ6ESNe7DNxwPtnUH+SdLrUqC6MltWWEtsqEtnSXN/18UQL1ByJIkjPI8becaSy7D+chVG
	5CHiXemszBnsGmburKPi9PCQHMJqeeBk5EV3UiOt6ViUHN9QeNUkb+0yix4+9/QRjRcxhcllKlv
	ST58GoTXYFlsWRue9epZmusBFpvWsOv9XebWi2dnmNUxkhNpz+RF84kWY6kBEd+dLxHtMrw8lvv
	FNdMQn0rzhuFTVz6Jo6yR3vuAtHW5Z0eU2t0cQXixoZzqyuN3RIU6YBq8+Jzvkbg==
X-Google-Smtp-Source: AGHT+IEeKxOQzdS4L5wZVGG2YsfGQ4VfOG5WxuGIyPNKK1Wog0FyGOuQbFK7NwXfAtyNg8VMiQjC4w==
X-Received: by 2002:a05:6300:8002:b0:33b:1dce:9941 with SMTP id adf61e73a8af0-33b1dce9c71mr125201637.45.1761089977976;
        Tue, 21 Oct 2025 16:39:37 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-91-142.pa.nsw.optusnet.com.au. [49.180.91.142])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a22ff15c89sm12888451b3a.1.2025.10.21.16.39.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 16:39:37 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.98.2)
	(envelope-from <david@fromorbit.com>)
	id 1vBLx0-00000000NAO-1MVp;
	Wed, 22 Oct 2025 10:39:34 +1100
Date: Wed, 22 Oct 2025 10:39:34 +1100
From: Dave Chinner <david@fromorbit.com>
To: Kiryl Shutsemau <kirill@shutemov.name>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH] mm/filemap: Implement fast short reads
Message-ID: <aPgZthYaP7Flda0z@dread.disaster.area>
References: <20251017141536.577466-1-kirill@shutemov.name>
 <20251019215328.3b529dc78222787226bd4ffe@linux-foundation.org>
 <44ubh4cybuwsb4b6na3m4h3yrjbweiso5pafzgf57a4wgzd235@pgl54elpqgxa>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44ubh4cybuwsb4b6na3m4h3yrjbweiso5pafzgf57a4wgzd235@pgl54elpqgxa>

On Mon, Oct 20, 2025 at 12:33:08PM +0100, Kiryl Shutsemau wrote:
> On Sun, Oct 19, 2025 at 09:53:28PM -0700, Andrew Morton wrote:
> > On Fri, 17 Oct 2025 15:15:36 +0100 Kiryl Shutsemau <kirill@shutemov.name> wrote:
> > 
> > > From: Kiryl Shutsemau <kas@kernel.org>
> > > 
> > > The protocol for page cache lookup is as follows:
> > > 
> > >   1. Locate a folio in XArray.
> > >   2. Obtain a reference on the folio using folio_try_get().
> > >   3. If successful, verify that the folio still belongs to
> > >      the mapping and has not been truncated or reclaimed.

What about if it has been hole-punched?

The i_size checks after testing the folio is up to date catch races
with truncate down.  This "works" because truncate_setsize() changes
i_size before we invalidate the mapping and so we don't try to
access folios that have pending invalidation.

It also catches the case where the invalidation is only a partial
EOF folio zero (e.g. truncate down within the same EOF folio). In
this case, the deletion sequence number won't catch the invalidation
because no pages are freed from the page cache. Hence reads need to
check i_size to detect this case.

However, fallocate() operations such as hole punching and extent
shifting have exactly the same partial folio invalidation problems
as truncate but they don't change i_size like truncate does (both at
the front and rear edges of the ranges being operated on)

Hence invalidation races with fallocate() operations cannot be
detected via i_size checks and we have to serialise them differently.
fallocate() also requires barriers prevent new page cache operations
whilst the filesystem operation is in progress, so we actually need
the invalidation serialisation to also act as a page cache instantiation
barrier. This is what the mapping->invalidate_lock provides, and I
suspect that this new read fast path doesn't actually work correctly
w.r.t. fallocate() based invalidation because it can't detect races
with partial folio invalidations that are pending nor does it take
the mapping->invalidate_lock....

I also wonder if there might be other subtle races with
->remap_file_range based operations, because they also run
invalidations and need page cache instatiation barriers whilst the
operations run.  At least with XFS, remap operations hold both the
inode->i_rwsem and the mapping->invalidate_lock so nobody can access
the page cache across the destination range being operated on whilst
the extent mapping underlying the file is in flux.

Given these potential issues, I really wonder if this niche fast
path is really worth the potential pain racing against these sorts
of operations could bring us. It also increases the cognitive
load for anyone trying to understand how buffered reads interact
with everything else (i.e. yet another set of race conditions we
have to worry about when thinking about truncate!), and it is not
clear to me that it is (or can be made) safe w.r.t. more complex
invalidation interactions that filesystem have to handle these days.

So: is the benefit for this niche workload really worth the
additional complexity it adds to what is already a very complex set
of behaviours and interactions?

> > > +	if (!folio_test_referenced(folio))
> > > +		return 0;
> > > +
> > > +	/* i_size check must be after folio_test_uptodate() */
> > 
> > why?
> 
> There is comment for i_size_read() in slow path that inidicates that it
> is required, but, to be honest, I don't fully understand interaction
> uptodate vs i_size here.

As per above, it's detecting a race with a concurrent truncate that
is about to invalidate the folio but hasn't yet got to that folio in
the mapping.

This is where we'd also need to detect pending fallocate() or other
invalidations that are in progress, but there's no way to do that
easily....

-Dave.
-- 
Dave Chinner
david@fromorbit.com

