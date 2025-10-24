Return-Path: <linux-kernel+bounces-868172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F870C0491B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 08:51:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 172BF3BB15C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 06:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 808F927978C;
	Fri, 24 Oct 2025 06:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="ReKOryUm"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2921275AE2
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 06:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761288658; cv=none; b=e9GQqqam2HuH5y9/k9xwYzUb1HCp1z6AzHFix3FuuZ87Z+o1oYkdxFMlKSdf0SiKYkj34rmeAW8ZXedBzT5E1JzQb4vDI478nTXe7Njh/pQMnFnTMkl3Knkhc/wZL+d+tWWao16N0VhyebCSeA0kNbNyLGIZiToxjkfdb/IXW4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761288658; c=relaxed/simple;
	bh=WcKWVTEst9/JJcZqjxi1ilVl0onBTqOZEpLR3/ThDTY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WrPOVlVXJX6ikz3BWzO4AMkvzbND9g8Io73D1m5UOnDxUzBj4CevWqAyHtOuRgpk3AIHkgrzMsa0ldYMkz2IBPWXXS1vDpysrTtsokLwz6rAF0Ik92ENeT7cL9iHoWDoZ17aHw3xFvM6qfTp14Gnz8iw0rcS2tWGtpHpau5ctxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=ReKOryUm; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b6271ea3a6fso1172940a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 23:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1761288656; x=1761893456; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DHCxcy5rr5LIi478WtCZse20PdH2a3ydVXLtPEk9x3Y=;
        b=ReKOryUmM2d00VUlH7c8BzFSBxw8lzDmQev4w4hr7ccyXlHt2VD5SJZqWpkXdAvhHc
         D7TSIaO2jKYSxDNDrpxriB7IsaStvSBEcdt57A+qLfmmu4NN/mkYQofjl9RzcKkVm77T
         Go0pYZ93EV4EJeDXZfdXsTR32vdcet/B33aLBg0mpRxz5Dhs95ejX9zBGOSQk+p4Gq5R
         49y5ni/LlaT52D2UrxQfo3n2E10Vdeg21xo01FipeH9md84dnyUvP4I4h/oKY1twhpLh
         rGbe5Q82jpH3dBP+2d03dleq7u7Mxw9FJuN+YpAI17wWWixB8ENL4sVZxLuQ1W5eNyAA
         5OxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761288656; x=1761893456;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DHCxcy5rr5LIi478WtCZse20PdH2a3ydVXLtPEk9x3Y=;
        b=QQw6Y3gbHXMGCXnOWASB4xPPM87b0mK9s8l2+2NV0qUtLm6lhXno7kfi69B/BlfLl3
         Z5T445EdtieZS0YH6Cb7oGkrFz1ag5akHoSBYHUBy0aHIr9Wxty5lKBAjFX2utGQY+/W
         144rnjJ4eGNL+SWxc//Z3+cPznLXVwhqb+2AhMEfivs6jbfTw7vsqpch31D6agBb28vh
         5Z/th035WUjzb+9AfKLO20wmuKyEujKNzlErrR5sUq/kUWA/AcPMUCOS9ywE3zPYg7VQ
         qFCht/oGKO8BY5KDLBXNCx1ehSwRBafpe8cAUDfqSSYgZM+n+n5OFi/b2/8IAQbXMyIt
         8Oxw==
X-Forwarded-Encrypted: i=1; AJvYcCWMr9ZvCNuJO84fkodTyDwdJyWoh0pfulf/kqriV57JqLsu5uirfIIWQv81jTZ1VEi9niUV087kj4FGJMM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy281AinAsp0OT+nalwJRt74foRWmSlB4j2AysDbEibc1wMuNXR
	tHuDCjnL161nEuSjNHq/H+FxyKP0onqr54G++zAnFwuCTc/tjqaF0Bia7GWFPOh7Asg=
X-Gm-Gg: ASbGncvEMeCFtC4A5MCcW67bt/oYwfyo2dIO6fDx9yd+DK1L0HJc7WS7xlQ1CvZSD0B
	CD/Nen4Zaw6J8e+038A71o9NIfN++koewLekQfvDiJH1xsMLWOzgrK7yvnJsjjW47qkcNIUOtGH
	Wkt3uUG6KSUTXVOBVmnpE6u7hmZHTDZsi8FdZMF8ZL4izyXX7gf0YnmpgMXQm1yUyETzFjY8S70
	sWUrAGKUIOu3Cvqu1kS03HVB3lLwufkp7cwjMpsd2kx8haCB1bl4XcCiDI6pr4ndKuuCC46MjZ/
	5hi8BncKNquLMiBOfd82F9OTAJtQ6L4S7GLx+4dLcT1I5xJxh24KoaofIijkoWMnmbaz+wlmROS
	zcscXafXsMZoEL5y9UeHzstuLnZEuGT2MRYVOqIgTbzFI0Pio2SpVwdVmbeWozXCNXT0ejjbB07
	MQd9IxxhTRhJV7wNTCf3izVLDO4u070AiVNsdXIwGLsAdPhNsElFT05RAdrTvoDA==
X-Google-Smtp-Source: AGHT+IFom99rdUC4rqHBj2JdLSCZeZQXVVqQvty9JoHlT9qtIJ5LbSGWQ/CZd37bHNSPFzQXNSZTzg==
X-Received: by 2002:a17:903:1a4c:b0:27e:ef09:4ab6 with SMTP id d9443c01a7336-290c99ad18bmr336153455ad.0.1761288655816;
        Thu, 23 Oct 2025 23:50:55 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-91-142.pa.nsw.optusnet.com.au. [49.180.91.142])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2946e2578desm44175585ad.106.2025.10.23.23.50.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 23:50:55 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.98.2)
	(envelope-from <david@fromorbit.com>)
	id 1vCBdU-00000001NJi-0OGs;
	Fri, 24 Oct 2025 17:50:52 +1100
Date: Fri, 24 Oct 2025 17:50:52 +1100
From: Dave Chinner <david@fromorbit.com>
To: Andreas Dilger <adilger@dilger.ca>
Cc: Kiryl Shutsemau <kirill@shutemov.name>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Hugh Dickins <hughd@google.com>,
	Matthew Wilcox <willy@infradead.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Rik van Riel <riel@surriel.com>,
	Harry Yoo <harry.yoo@oracle.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	linux-mm <linux-mm@kvack.org>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC, PATCH 0/2] Large folios vs. SIGBUS semantics
Message-ID: <aPshzHsqp2Srau5T@dread.disaster.area>
References: <20251020163054.1063646-1-kirill@shutemov.name>
 <aPbFgnW1ewPzpBGz@dread.disaster.area>
 <d7s4dpxtfwf2kdp4zd7szy22lxrhdjilxrsrtpm7ckzsnosdmo@bq43jwx7omq3>
 <aPoTw1qaEhU5CYmI@dread.disaster.area>
 <AF891D9F-C006-411C-BC4C-3787622AB189@dilger.ca>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AF891D9F-C006-411C-BC4C-3787622AB189@dilger.ca>

On Thu, Oct 23, 2025 at 09:48:58AM -0600, Andreas Dilger wrote:
> > On Oct 23, 2025, at 5:38 AM, Dave Chinner <david@fromorbit.com> wrote:
> > On Tue, Oct 21, 2025 at 07:16:26AM +0100, Kiryl Shutsemau wrote:
> >> On Tue, Oct 21, 2025 at 10:28:02AM +1100, Dave Chinner wrote:
> >>> In critical paths like truncate, correctness and safety come first.
> >>> Performance is only a secondary consideration.  The overlap of
> >>> mmap() and truncate() is an area where we have had many, many bugs
> >>> and, at minimum, the current POSIX behaviour largely shields us from
> >>> serious stale data exposure events when those bugs (inevitably)
> >>> occur.
> >> 
> >> How do you prevent writes via GUP racing with truncate()?
> >> 
> >> Something like this:
> >> 
> >> 	CPU0				CPU1
> >> fd = open("file")
> >> p = mmap(fd)
> >> whatever_syscall(p)
> >>  get_user_pages(p, &page)
> >>  				truncate("file");
> >>  <write to page>
> >>  put_page(page);
> > 
> > Forget about truncate, go look at the comment above
> > writable_file_mapping_allowed() about using GUP this way.
> > 
> > i.e. file-backed mmap/GUP is a known broken anti-pattern. We've
> > spent the past 15+ years telling people that it is unfixably broken
> > and they will crash their kernel or corrupt there data if they do
> > this.
> > 
> > This is not supported functionality because real world production
> > use ends up exposing problems with sync and background writeback
> > races, truncate races, fallocate() races, writes into holes, writes
> > into preallocated regions, writes over shared extents that require
> > copy-on-write, etc, etc, ad nausiem.
> > 
> > If anyone is using filebacked mappings like this, then when it
> > breaks they get to keep all the broken pieces to themselves.
> 
> Should ftruncate("file") return ETXTBUSY in this case, so that users
> and applications know this doesn't work/isn't safe?

No, it is better to block waiting for the GUP to release the
reference (see below), but the general problem is that we cannot
reliably discriminate GUP references from other page cache based
references just by looking at the folio resident in the page cache.

However, when FSDAX is being used, trucate does, in fact, block
waiting for GUP references to be release. fsdax does not use page
references to track in use pages - the filesystem metadata tracks
allocated and free pages, not the mm/ subsystem. There are no
page cache references to the pages, because there is no page
cache. Hence we can use the difference between the map count and the
reference count to determine if there are any references we cannot
forcibly unmap (e.g. GUP) just by looking at the backing store folio
state.

Hence we can block truncate on non mapcount references via the
layout lease hooks like so: i.e.:

->setattr
 xfs_vn_setattr
   xfs_break_layouts(BREAK_UNMAP)
      xfs_break_dax_layouts()
        dax_break_layout_inode()
	  dax_break_layout()
	    page = dax_layout_busy_page_range()
	      page = dax_busy_page()
		 /* page returned if it is held by GUP */
	    wait_page_idle(page)
	         /* blocks until extra ref counts go away */

and only when all the non-mapcount page references are gone across
the truncate range is the truncate allowed to proceed.

IIRC, we decided to block truncate and other operations that need
backing store access exclusion rather than returned an error because
nobody expects operations like truncate to randomly fail like this.
Such behaviour would likely break applications in unexpected ways,
so it was decided to play it safe and block until the ref goes away.

This is one of the reasons for FOLL_LONGTERM  being added - we
can't allow longterm pinning of file-backed fsadax pages (e.g. RDMA
regions using filebacked mappings) because then operations like
truncate can be blocked for hours/days/weeks. This situation is
checked via vma_is_fsdax() in mm/gup.c::check_vma_flags()...

> Unfortunately,
> today's application developers barely even know how IO is done, so
> there is little chance that they would understand subtleties like this.

I think that even the experienced developers who know how to do IO
struggle to understand this sort of thing. Most kernel developers
run screaming from GUP before it drives them insane, too. :/

-Dave.
-- 
Dave Chinner
david@fromorbit.com

