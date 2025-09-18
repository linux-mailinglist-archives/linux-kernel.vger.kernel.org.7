Return-Path: <linux-kernel+bounces-823614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01667B87025
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 23:08:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A175D165AFF
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 21:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFECF2DAFA5;
	Thu, 18 Sep 2025 21:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wb2/b0r5"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3368526C3A7
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 21:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758229674; cv=none; b=L+2oP20X01g9KlrgpyhjJ74xaoOjJ1avH1xCIofSApE6guFQZomcgj7pzPB9zbZNOUCAJsxT+LcFrFmWFksd7nF7Vvvd0OYXtDvAIF4CTSeC568SyM/FiERzQj4eoYwuJw3tu2NhtGN/BJGePpLj7ejqkQkQ9ymn/k6Te+RuoLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758229674; c=relaxed/simple;
	bh=vxuJYble5SjCQjbvtnTcpdELW/TXEiNfs5sZGJyyjp8=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qhg4uPgPSIIaXEtm3GVRboY4MHRu9ppkA36OzgtieqKEVezsvaxfiZIvlU/C3DS4EeuT8FvVSyNjwijcTNGxky1+h0YxqkCwVvuK9h1MNDTKrvV9wvtKAvjmU7d4KUjJCerw2A4Nzx3NRqAaAYX0xK0uWt9569jygcXVZFN38ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Wb2/b0r5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758229670;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=roUBDBcfKj6FP3l8Gf9Nb2+udjPSnvi1fQaLWj3+7y0=;
	b=Wb2/b0r5jo8ZjzGgeBM1UsxRwLEjTZC7lDEGOXvac9H38gAvu5eT+GRFAq6f6l/dcL0I3x
	QG/IIYdmetIrco8fR0thEB5BdWCb3v9SBmWp4YzP1VlwA+KqWsr4MxA0OvmyM8XC71Qokh
	6rgBJPT0d3clnw7SGadZVZ09XxCxzJE=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558-JGQy6dpOOLeU2L1lCkZsgQ-1; Thu, 18 Sep 2025 17:07:48 -0400
X-MC-Unique: JGQy6dpOOLeU2L1lCkZsgQ-1
X-Mimecast-MFC-AGG-ID: JGQy6dpOOLeU2L1lCkZsgQ_1758229668
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-7966a34e19dso9905416d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 14:07:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758229667; x=1758834467;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=roUBDBcfKj6FP3l8Gf9Nb2+udjPSnvi1fQaLWj3+7y0=;
        b=EnMHvzTWfx3SqMqJVGjwOvV/vSfeKSS+QPsMOdfHj735rzPDB77Vy/THW+kU3hqO+S
         Pd6+7nZlN1ZY7Jaje8qsEA6/ZvS2vSNNEVhl1eMn+hPCl+HkC0anAb2NcLZFoW3mMCM/
         /rnBYV1dUveN1hbIRxxl2pC0NZKflsfke0lVNdjC+bV00g5FGNd0g5jjHPTPDOiorHgT
         8nevycRik7qGVrgi4+x3DSZ8UsSwulRdgBF7CELR0ZJxXLtCcFEQVYDtT9CQIZ4GtM09
         aS4YdtVZ3LH82QITipOs1viDPIiUKGzi5lDjb67L193LSJR8H4qQ+n6dqdwS0i91wJfn
         YCDA==
X-Forwarded-Encrypted: i=1; AJvYcCXmDfiU2609Tc6fL9QipQgLY4Syusg+Xu+cb13jU/znqThs4LX2rbVWd3n4LGPxAO3fCbg8SK5f5vntZ70=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXxwn4PKAGNfkmsMV6r/Z+w9dG3uko6Xpw+pyeqzWhNbcvjTmS
	z+8Q59IyeP3KEwNvtgXgINqc6OGqoARJK4kKqwXQPIR+n7qBvNBqHdiRbKHWEgYt3yIUrlI18q3
	7deDB7JUxgmV8cJE98mmGZnh1jlqWql86Ik7Ku452uD7N4TUIv6zyliwIRPtdk1yzrg==
X-Gm-Gg: ASbGncuKTgww/Rnd4bLtFA3i/REZgS4+WaUNjzojir5klqN6LlRkRPp8vpcMR288Pu7
	LcvfjUDLS4Z7bx7KGagOpy4mQokt4tc5uRocq4RLUhHESKhsCkJA0ywqrSK9zoUezjCXBFd+Fk3
	YwVwVrHyufHuQ98Ed03aRQ/+QPsP8q4AReymHqxrz12y76vmMADY5inyoZ1Ln7UuWHXIbfWCECp
	+aY0pux90+m+TMcUDpgeLuVM9ChFkHs9B5Z74UBy0eXqFxuRCNFKjpUKbQrZgNkXf6z7iLiGI2J
	xPhV6/MbF8sRD8I1UHt+YdpunrHYp3GUK0Hx1KR93WLTUphD8V4zdaVXfiAnmn6r8cNDaocQkSL
	RckQe7RMfzan3l3Ya4wj3hg==
X-Received: by 2002:ad4:5dea:0:b0:790:40cb:6df0 with SMTP id 6a1803df08f44-798c72124c8mr14225026d6.34.1758229667300;
        Thu, 18 Sep 2025 14:07:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEZ/WT6zqYgXmOWGIVR34EnFP0/c2WTo4aDRdjYQx1EN/bJVh35TR0Iu+LlyCr7SxHDPithFg==
X-Received: by 2002:ad4:5dea:0:b0:790:40cb:6df0 with SMTP id 6a1803df08f44-798c72124c8mr14224516d6.34.1758229666734;
        Thu, 18 Sep 2025 14:07:46 -0700 (PDT)
Received: from x1.local (bras-base-aurron9134w-grc-11-174-89-135-121.dsl.bell.ca. [174.89.135.121])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-79351f75812sm18704136d6.36.2025.09.18.14.07.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 14:07:46 -0700 (PDT)
Date: Thu, 18 Sep 2025 17:07:44 -0400
From: Peter Xu <peterx@redhat.com>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Nikita Kalyazin <kalyazin@amazon.com>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>,
	Muchun Song <muchun.song@linux.dev>,
	Hugh Dickins <hughd@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	James Houghton <jthoughton@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Andrea Arcangeli <aarcange@redhat.com>,
	Oscar Salvador <osalvador@suse.de>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Ujwal Kundur <ujwal.kundur@gmail.com>
Subject: Re: [PATCH v2 1/4] mm: Introduce vm_uffd_ops API
Message-ID: <aMx0oGwRpSTcfdnf@x1.local>
References: <jxekhkhbn7uk23oe24svxrs3vfuhseae57sqagndqgh2e7h33o@kfkygmrvjb5n>
 <aMp-kW3OLqtZs8sh@kernel.org>
 <du5pzxmfk6lile3ykpaloylwz4eni6disj2oe25eq6ipzqemiw@ybcouflfnlev>
 <aMvEu9m7fJLnj862@kernel.org>
 <4czztpp7emy7gnigoa7aap2expmlnrpvhugko7q4ycfj2ikuck@v6aq7tzr6yeq>
 <a1a48a0e-62d3-48d0-b9c2-492eb190b99f@amazon.com>
 <7cccbceb-b833-4a21-bdc4-1ff9d1d6c14f@lucifer.local>
 <74b92ce3-9e0e-4361-8117-7abda27f2dd4@redhat.com>
 <aMxNgyVRuiFq2Sms@x1.local>
 <cigo2r2x22bk7wzr6qvazcdkmt5kfqhbgb7nslpuff7djufucg@f6xucfuntz3q>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cigo2r2x22bk7wzr6qvazcdkmt5kfqhbgb7nslpuff7djufucg@f6xucfuntz3q>

On Thu, Sep 18, 2025 at 03:43:34PM -0400, Liam R. Howlett wrote:
> * Peter Xu <peterx@redhat.com> [250918 14:21]:
> > On Thu, Sep 18, 2025 at 07:53:46PM +0200, David Hildenbrand wrote:
> > > Re Nikita: If we could just reuse fault() for userfaultfd purposes, that
> > > might actually be pretty nice.
> > 
> > I commented on that.
> > 
> > https://lore.kernel.org/all/aEiwHjl4tsUt98sh@x1.local/

[1]

> > 
> > That'll need to leak FAULT_FLAG_USERFAULT_CONTINUE which isn't necessary,
> > make it extremely hard to know when to set the flag, and comlicates the
> > fault path which isn't necessary.
> > 
> > I think Mike's comment was spot on, that the new API is literally
> > do_fault() for shmem, but only used in userfaultfd context so it's even an
> > oneliner.
> > 
> > I do not maintain mm, so above is only my two cents, so I don't make
> > decisions.  Personally I still prefer the current approach of keep the mm
> > main fault path clean.
> 
> What we are trying to say is you can have a fault path that takes a type
> enum that calls into a function that does whatever you want.  It can
> even live in mm/userfaultfd.c.  It can then jump off to mm/guest-memfd.c
> which can contain super unique copying of memory if that's needed.

Per mentioning of mm/guest-memfd.c, are you suggesting to take guest-memfd
library approach?

We have in total of at least three proposals:

(a) https://lore.kernel.org/all/20250404154352.23078-1-kalyazin@amazon.com/
(b) this one
(c) https://lore.kernel.org/all/20250915161815.40729-1-kalyazin@amazon.com/

I reviewd (a) and (c) and I provided my comments.  If you prefer the
library approach, feel free to reply directly to (c) thread against my
email.

I chose (b), from when it was posted.

> 
> That way driver/i_know_better_that_everyone.c or fs/stature.c don't
> decide they can register their uffd and do cool stuff that totally won't
> tank the system in random strange ways.

What is the difference if they are allowed to register ->fault() and tank
the system?

> 
> Seriously, how many fault handlers are you expecting to have here?

First of all, it's not about "how many".  We can assume one user as of now.
Talking about any future user doesn't really help.  The choice I made above
on (b) is the best solution I think, with any known possible users.  The
plan might change, when more use cases pops up.  However we can only try to
make a fair decision with the current status quo.

OTOH, the vm_uffd_ops also provides other fields (besides uffd_*() hooks).
I wouldn't be surprised if a driver wants to opt-in with some of the fields
with zero hooks attached at all, when an userfaultfd feature is
automatically friendly to all kinds of memory types.

Consider one VMA that sets UFFDIO_WRITEPROTECT but without most of the
rest.

As I discussed, IMHO (b) is the clean way to describe userfaultfd demand
for any memory type.

> 
> I'd be surprised if a lot of the code in these memory types isn't
> shared, but I guess if they are all over the kernel they'll just clone
> the code and bugs (like the arch code does, but with less of a reason).
> 
> > Besides, this series also cleans up other places all over the places, the
> > vm_uffd_ops is a most simplified version of description for a memory type.
> 
> 6 files changed, 207 insertions(+), 76 deletions(-)
> 
> Can you please point me to which patch has clean up?

Patch 4.  If you want me to explain every change I touched that is a
cleanup, I can go into details.  Maybe it's faster if you read them, it's
not a huge patch.

> 
> The mm has uffd code _everywhere_, including mm/userfaultfd.c that jumps
> to fs/userfaultfd.c and back.  Every entry has a LIST_HEAD(uf) [1] [2]
> [3] in it that is passed through the entire call stack in case it is
> needed [4] [5] [6] [7] [8].   It has if statements in core mm functions
> in the middle of loops [9].  It complicates error handling and has
> tricky locking [10] (full disclosure, I helped with the locking..
> totally worth the complication).
> 
> This is a seriously complicated feature.

I know you're the expert of VMA, you worked a lot of it.  I understand
those things can caused you frustrations when touching those codes.  Though
please let's do not bring those into reviewing this series.  Those have
nothing to do with this series.

Frankly, I also wished if one day we can get rid of some of them.  It
really depends on how many users are there for the uffd events besides the
generic ones (fault traps).

> 
> How is a generic callback that splits out into, probably 4?, functions
> the deal breaker here?
> 
> How is leaking a flag the line that we won't cross?
> 
> > So IMHO it's beneficial in other aspects as well.  If uffd_copy() is a
> > concern, fine, we drop it.  We don't plan to have more use of UFFDIO_COPY
> > outside of the known three memory types after all.
> 
> EXACTLY!  There are three memory types and we're going to the most
> flexible interface possible, with the most danger.  With guest_memfd
> we're up to four functions we'd need.  Why not keep the mm code in the
> mm and have four functions to choose from?  If you want 5 we can always
> add another.

I assume for most of the rest comments, you're suggesting the library
approach.  If so, again, I suggest we discuss explicitly in that thread.

The library code may (or may not) be useful for other purposes.  For the
support of userfaultfd, it definitely doesn't need to be a dependency.
OTOH, we may still want some abstraction like this one with/without the
library.  If so, I don't really see why we need to pushback on this.

AFAIU, the only concern (after drop uffd_copy) is we'll expose
uffd_get_folio().  Please help explain why ->fault() isn't worse.

If we accepted ->fault() for all these years, I don't see a reason we
should reject ->uffd_get_folio(), especially one of the goals is to keep
the core mm path clean, per my comment to proposal (a).

-- 
Peter Xu


