Return-Path: <linux-kernel+bounces-819501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 993F4B5A1B3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 21:55:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F162A1C04A88
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 19:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3851A2E1C6F;
	Tue, 16 Sep 2025 19:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BCRD4Y7Y"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4684E2773F4
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 19:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758052549; cv=none; b=F3CWOiRy1Ez+Si9uMCtUbnLlsFqKNk2nQ91XHtkBu80qA2Q0FnZQsNX0DTbMHkZjvnqlA5YzckwqQhE/ggiOqMez/ZsBvwxz4lCidiM7eAXDmYhlt7d2QhBhqOfZAtkbUDlLqIrdA3VRGT4/+WmCeYt8CpSdezqoCHxbmJYj6I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758052549; c=relaxed/simple;
	bh=5z7/YrpYkv8Y1G46TDI/PHP2azhGPStvXkkV4b62cSI=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IYHvWsl2f2sFuxuRhwQEa+5w0NQo4I/a7Q+DsmLN0lpi2DwaOVhvnblxOCpYr1amXDm27T9HgJNR3iZeeu8SuuUYOwd1weKDpty1KULWFsKW3B1V1wRG6yaUbns+2zFmGpUY6pcpB6Aj3ls5ZcvziOr3XuBGbw96t+1NwAe7YU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BCRD4Y7Y; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758052546;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LCWQw5QvSmhTl1IZYTa8tC4TyGgvx1ILki+95+TRCAw=;
	b=BCRD4Y7YH7luvgYfOYz3YixfSrWrIE1T7zbfdOPQxuX0z+3sqA2Q09I0UJOWo+b6mjcCcv
	Uy7iw7Dlg34g4aEvpbmd6q/XHA2ebtumsRxo930stzDfBaaaYPk9GH1UTuhdviegKrCNoL
	tEKYIqKGSxSt3d2T7wXnApjXyle6iqc=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-471-a5VUU3qQOQKQdOGHWpIlpg-1; Tue, 16 Sep 2025 15:55:43 -0400
X-MC-Unique: a5VUU3qQOQKQdOGHWpIlpg-1
X-Mimecast-MFC-AGG-ID: a5VUU3qQOQKQdOGHWpIlpg_1758052543
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-82e5940eeefso67651785a.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 12:55:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758052543; x=1758657343;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LCWQw5QvSmhTl1IZYTa8tC4TyGgvx1ILki+95+TRCAw=;
        b=JN+qn8x1cy8XuppRBCrRFFEgvAHs+L1LaVgfFQAuH2BJKTZDJP2N37vqa9K76DqAyL
         KN2X3xAfA+mL/tCjjdNYJL6WQUC8dCJrXtb+kn30snXGAbWmRp6F0EIwkwkCjz4gW3jM
         GjvTGMKtFFrd7/yQi2Z3VXbgOtNJqIQfURr60k+wDSoko1yEGrOfA+L9JWy/8PcG8xc+
         OkQwC9VXriSKdm1lfq4q5UMABI5c9uNR4Il0q7V4UGwy4f1SCQPTR1M/tAOYiX6ceaCL
         YmyMKKcfu5uuCrOeB1zsv7Yrsf86J0GDrsWhIC6jPSbQO6hQVHcGWQDop16/7I5jyzES
         P+Sg==
X-Forwarded-Encrypted: i=1; AJvYcCXy1xxGyVQ/bN655cnwHq3FyBV7s+DsIo6pRoF6yE3bYNnzIi4EdEcxO4M58WGkN0rCo7OazxibchlAA64=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOmeT7gX0SjUsdjqa4/v5ZFBnHlz+ZYaMj4egMFfz8sYG8xUlZ
	7evBYFkBBE+qnMKR/PKdhLYqq3jWnqp2Ijk9baFfIWBXuEoPkVzK86EglZcJ/V+F1gQJ9+uS3J7
	5N2Ztu3+IFuUPU96JCBUD9X2A+vScVYbStUopPDgthguLSWASAfhztHEAzZuTs4y2Vg==
X-Gm-Gg: ASbGncue8sWs6XKbR9aR3FXXUIhSkcWwsX2cm+YNHuACaKS9vFQTBbMrWO10Gwppd92
	MSXU2PJ2qnG8H/snQI9eq/MPBBT0bGB92asNYSdHZCj/pd8/xp1b05o2rO3hfCO59Dh0Q+pc2W9
	orUyRyxZgBOsN0+XnJsAI4bHr5QPmTMIb+iuDEDl6gn7UK/O92o2OK3bXkrj/yq98cfUjiIbXTi
	N392fv/SGAfiUnBZqB2GK0r3BNgJsPCOuRsYdP4uGJILPgkf9ALrZnAgiBZuzu5ejmBqYjiNYvH
	0BXvtsfAsDhvmdROnXLnZD2i5Nup43c2
X-Received: by 2002:a05:620a:a1d5:20b0:7f3:c6ab:e836 with SMTP id af79cd13be357-82b9c840587mr328401085a.18.1758052542958;
        Tue, 16 Sep 2025 12:55:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHXCQVo06N/gkUqltuP4pDESRP+ZzHDPZ/4dTJPxZGrBFajWf3gdDStG1/Z5hNR6CAGkrK8Gg==
X-Received: by 2002:a05:620a:a1d5:20b0:7f3:c6ab:e836 with SMTP id af79cd13be357-82b9c840587mr328399085a.18.1758052542407;
        Tue, 16 Sep 2025 12:55:42 -0700 (PDT)
Received: from x1.local ([174.89.135.121])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-82aeb24fcebsm269020385a.56.2025.09.16.12.55.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 12:55:41 -0700 (PDT)
Date: Tue, 16 Sep 2025 15:55:29 -0400
From: Peter Xu <peterx@redhat.com>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
	David Hildenbrand <david@redhat.com>,
	Mike Rapoport <rppt@kernel.org>,
	Nikita Kalyazin <kalyazin@amazon.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
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
Message-ID: <aMnAscxj_h42wOAC@x1.local>
References: <aaaca9d4-b8df-45b8-a3a4-a431c99f26c7@lucifer.local>
 <CAJuCfpHN6vpDx+UNPEzJgZ_qD9USTJZ_+yZzQg2BpF_aRpufYw@mail.gmail.com>
 <982f4f94-f0bf-45dd-9003-081b76e57027@lucifer.local>
 <cda7c46b-c474-48f4-b703-e2f988470f3b@amazon.com>
 <aGVu1Isy-R9RszxW@kernel.org>
 <aGWMsfbayEco0j4R@x1.local>
 <aGbCbW7hUf3a2do2@kernel.org>
 <289eede1-d47d-49a2-b9b6-ff8050d84893@redhat.com>
 <aGfsaIIzHWfjcNFd@x1.local>
 <e7vr62s73dftijeveyg6lfgivctijz4qcar3teswjbuv6gog3k@4sbpuj35nbbh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e7vr62s73dftijeveyg6lfgivctijz4qcar3teswjbuv6gog3k@4sbpuj35nbbh>

On Fri, Jul 04, 2025 at 03:39:32PM -0400, Liam R. Howlett wrote:
> * Peter Xu <peterx@redhat.com> [250704 11:00]:
> > On Fri, Jul 04, 2025 at 11:34:15AM +0200, David Hildenbrand wrote:
> > > On 03.07.25 19:48, Mike Rapoport wrote:
> > > > On Wed, Jul 02, 2025 at 03:46:57PM -0400, Peter Xu wrote:
> > > > > On Wed, Jul 02, 2025 at 08:39:32PM +0300, Mike Rapoport wrote:
> > > > > 
> > > > > [...]
> > > > > 
> > > > > > > The main target of this change is the implementation of UFFD for
> > > > > > > KVM/guest_memfd (examples: [1], [2]) to avoid bringing KVM-specific code
> > > > > > > into the mm codebase.  We usually mean KVM by the "drivers" in this context,
> > > > > > > and it is already somewhat "knowledgeable" of the mm.  I don't think there
> > > > > > > are existing use cases for other drivers to implement this at the moment.
> > > > > > > 
> > > > > > > Although I can't see new exports in this series, there is now a way to limit
> > > > > > > exports to particular modules [3].  Would it help if we only do it for KVM
> > > > > > > initially (if/when actually needed)?
> > > > > > 
> > > > > > There were talks about pulling out guest_memfd core into mm, but I don't
> > > > > > remember patches about it. If parts of guest_memfd were already in mm/ that
> > > > > > would make easier to export uffd ops to it.
> > > > > 
> > > > > Do we have a link to such discussion?  I'm also curious whether that idea
> > > > > was acknowledged by KVM maintainers.
> > > > 
> > > > AFAIR it was discussed at one of David's guest_memfd calls
> > > 
> > > While it was discussed in the call a couple of times in different context
> > > (guest_memfd as a library / guest_memfd shim), I think we already discussed
> > > it back at LPC last year.
> > > 
> > > One of the main reasons for doing that is supporting guest_memfd in other
> > > hypervisors -- the gunyah hypervisor in the kernel wants to make use of it
> > > as well.
> > 
> > I see, thanks for the info. I found the series, it's here:
> > 
> > https://lore.kernel.org/all/20241113-guestmem-library-v3-0-71fdee85676b@quicinc.com/
> > 
> > Here, the question is whether do we still want to keep explicit calls to
> > shmem, hugetlbfs and in the future, guest-memfd.  The library-ize of
> > guest-memfd doesn't change a huge lot on answering this question, IIUC.
> 
> Can you explore moving hugetlb_mfill_atomic_pte and
> shmem_mfill_atomic_pte into mm/userfaultfd.c and generalizing them to
> use the same code?
> 
> That is, split the similar blocks into functions and reduce duplication.
> 
> These are under the UFFD config option and are pretty similar.  This
> will also limit the bleeding of mfill_atomic_mode out of uffd.

These are different problems to solve.

I did propose a refactoring of hugetlbfs in general years ago.  I didn't
finish that.  It's not only because it's a huge amount of work that almost
nobody likes to review (even if everybody likes to see landing), also that
since we decided to not add more complexity into hugetlbfs code like HGM
there's also less point on refactoring.

I hope we can be on the same page to understand the problem we want to
solve here.  The problem is we want to support userfaultfd on guest-memfd.
Your suggestion could be helpful, but IMHO it's orthogonal to the current
problem.  It's also not a dependency.  If it is, you should see code
duplications introduced in this series, which might not be needed after a
cleanup.  It's not like that.

This series simply resolves a totally different problem.  The order on
solving this problem or cleaning things elsewhere (or we decide to not do
it at all) are not deterministic, IMHO.

> 
> 
> 
> If you look at what the code does in userfaultfd.c, you can see that
> some refactoring is necessary for other reasons:
> 
> mfill_atomic() calls mfill_atomic_hugetlb(), or it enters a while
> (src_addr < src_start + len) to call mfill_atomic_pte().. which might
> call shmem_mfill_atomic_pte() in mm/shmem.c
> 
> mfill_atomic_hugetlb() calls, in a while (src_addr < src_start + len)
> loop and calls hugetlb_mfill_atomic_pte() in mm/hugetlb.c

Again, IMHO this still falls into hugetlbfs refactoring category.  I would
sincerely request that we put that as a separate topic to discuss, because
it's huge and community resources are limited on both developments and
reviews.

Shmem is already almost sharing code with anonymous, after all these two
memory types are the only ones that support userfaultfd besides hugetlbfs.

> 
> The shmem call already depends on the vma flags.. which it still does in
> your patch 4 here.  So you've replaced this:
> 
> if (!(dst_vma->vm_flags & VM_SHARED)) {
> ...
> } else {
>         shmem_mfill_atomic_pte()
> }
> 
> With...
> 
> if (!(dst_vma->vm_flags & VM_SHARED)) {
> ...
> } else {
> ...
>         uffd_ops->uffd_copy()
> }

I'm not 100% sure I get this comment.  It's intentional to depend on vma
flags here for shmem.  See Andrea's commit:

commit 5b51072e97d587186c2f5390c8c9c1fb7e179505
Author: Andrea Arcangeli <aarcange@redhat.com>
Date:   Fri Nov 30 14:09:28 2018 -0800

    userfaultfd: shmem: allocate anonymous memory for MAP_PRIVATE shmem

Are you suggesting we should merge it somehow?  I'd appreciate some
concrete example here if so.

> 
> So, really, what needs to happen first is userfaultfd needs to be
> sorted.
> 
> There's no point of creating a vm_ops_uffd if it will just serve as
> replacing the call locations of the functions like this, as it has done
> nothing to simplify the logic.

I had a vague feeling that you may not have understood the goal of this
series.  I thought we were on the same page there.  It could be partly my
fault if that's not obvious, I can try to be more explicit in the cover
letter next if I'm going to repost.

Please consider supporting guest-memfd as the goal, vm_ops_uffd is to allow
all changes to happen in guest-memfd.c.  Without it, it can't happen.
That's the whole point so far.

> 
> > However if we want to generalize userfaultfd capability for a type of
> > memory, we will still need something like the vm_uffd_ops hook to report
> > such information.  It means drivers can still overwrite these, with/without
> > an exported mfill_atomic_install_pte() functions.  I'm not sure whether
> > that eases the concern.
> 
> If we work through the duplication and reduction where possible, the
> path forward may be easier to see.
> 
> > 
> > So to me, generalizing the mem type looks helpful with/without moving
> > guest-memfd under mm/.
> 
> Yes, it should decrease the duplication across hugetlb.c and shmem.c,
> but I think that userfaultfd is the place to start.
> 
> > 
> > We do have the option to keep hard-code guest-memfd like shmem or
> > hugetlbfs. This is still "doable", but this likely means guest-memfd
> > support for userfaultfd needs to be done after that work.  I did quickly
> > check the status of gunyah hypervisor [1,2,3], I found that all of the
> > efforts are not yet continued in 2025.  The hypervisor last update was Jan
> > 2024 with a batch push [1].
> > 
> > I still prefer generalizing uffd capabilities using the ops.  That makes
> > guest-memfd support on MINOR not be blocked and it should be able to be
> > done concurrently v.s. guest-memfd library.  If guest-memfd library idea
> > didn't move on, it's non-issue either.
> > 
> > I've considered dropping uffd_copy() and MISSING support for vm_uffd_ops if
> > I'm going to repost - that looks like the only thing that people are
> > against with, even though that is not my preference, as that'll make the
> > API half-broken on its own.
> 
> The generalisation you did does not generalize much, as I pointed out
> above, and so it seems less impactful than it could be.
> 
> These patches also do not explore what this means for guest_memfd.  So
> it is not clear that the expected behaviour will serve the need.
> 
> You sent a link to an example user.  Can you please keep this work
> together in the patch set so that we know it'll work for your use case
> and allows us an easier way to pull down this work so we can examine it.
> 
> Alternatively, you can reduce and combine the memory types without
> exposing the changes externally, if they stand on their own.  But I
> don't think anyone is going to accept using a vm_ops change where a
> direct function call could be used.

While I was absent, Nikita sent a version that is based on the library
code.  That uses direct function calls:

https://lore.kernel.org/all/20250915161815.40729-3-kalyazin@amazon.com/

I think it's great we have the other sample of implementing this.

I believe Nikita has no strong opinion how this will land at last, whatever
way the community prefers.  I prefer this solution I sent.

Do you have a preference, when explicitly there's the other one to compare?

> 
> > Said that, I still prefer this against
> > hard-code and/or use CONFIG_GUESTMEM in userfaultfd code.
> 
> It also does nothing with regards to the CONFIG_USERFAULTFD in other
> areas.  My hope is that you could pull out the common code and make the
> CONFIG_ sections smaller.
> 
> And, by the way, it isn't the fact that we're going to copy something
> (or mfill_atomic it, I guess?) but the fact that we're handing out the
> pointer for something else to do that.  Please handle this manipulation
> in the core mm code without handing out pointers to folios, or page
> tables.

Is "return pointers to folios" also an issue now in the API?  Are you
NACKing uffd_get_folio() API that this series proposed?

> 
> You could do this with the address being passed in and figure out the
> type, or even a function pointer that you specifically pass in an enum
> of the type (I think this is what Lorenzo was suggesting somewhere),
> maybe with multiple flags for actions and fallback (MFILL|ZERO for
> example).

I didn't quickly get it.  I appreciate if there's some more elaborations.

Thanks,

-- 
Peter Xu


