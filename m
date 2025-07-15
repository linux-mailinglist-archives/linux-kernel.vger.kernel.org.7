Return-Path: <linux-kernel+bounces-732480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AD57B06773
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 22:04:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0742505DE9
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 20:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A907A285C98;
	Tue, 15 Jul 2025 20:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R3xIs9F3"
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46FA5DF76
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 20:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752609842; cv=none; b=WM1iXU0Whbap+PewBq/jltjylJWvuzjYN+njzpK6fVk+xYp9/muSJhHSzD1wctknBhrtDX/kKv2aw270WqMfC3wd8wg5tb+eXtX05GqjxzKb0DPxmmpJgPPj0PmEc/2artt3JKKxD/dwVTPtDJIaMPu1Ik3thkqCs+0fajED+A0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752609842; c=relaxed/simple;
	bh=CMAqecEgnff8KyzHnOWoYVsueyN+z5RUOjX1C9O7c7k=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=h8KKUZ9KzyDXcqmZEWslR/KPXh2x8/auSuRrVYgU0ZV4d4fIxmHCIAzVJB0J7Bftv83awv6+zq190wxZhXWUSGYdrmfOkF7zt08qyMvctS4xt9wcwBV1VTxkc450NY2l+xZ82Qs7ARdmsBmegjJ/dCo6xUpRhcvZRxpfF3Ox8Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=R3xIs9F3; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e812c817de0so4797960276.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 13:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752609838; x=1753214638; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gLzCTDimsLXvC+jdo33w/q/KLfPuAvI4MactKfhPqLo=;
        b=R3xIs9F3Dks4VExb9H9nCFNkeouCJ7Hg+EaqIZi30mqKWjrDxRphstos2iDSNAMOgG
         Kk0xNpGnmFOdhs75Quvb2eVJn8YdXTC0hHZ2UjHPR7Aw1qVJbpaGshbc+TeJh23Ct2yk
         o//KAUrPQ1R4EOKYw3MM3hVt610gFpekXHe7CjlwTEq/bbIrT901Iy3iFFnCaHoHvjlQ
         OXvUgrc1s9+F3MhvDugutF4lMhqbMewYC9RQ+WqpaUgqHFHlJq4HN/qvKJdildY5Z6XR
         nfBT7F9Qd6TedS+NRPgp25o38FA9njWpM4yfp+KEs1RacedZ2gmlJkI5KCOrqloqfANG
         FKdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752609838; x=1753214638;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gLzCTDimsLXvC+jdo33w/q/KLfPuAvI4MactKfhPqLo=;
        b=iO/o+91cvTiLH2NdR7VaU9BYlHHX8e7cWl4aIM7ERj/zq2y9ZwThyH6+zi66UizlVX
         cGyzXCJFM1nJImH1r6onpiMS2/+i1V/HZSdC5wrSUg7Xj3xXhoetAz7irnXZNKlXf5BW
         DAB0kQ3e/ewOSrdkUV1so2jPfewrrwYYbTSwqtyBlYTZxRp0AE1SJxavt7MQi3zLfPP9
         d/RuFTWtgZv8H+llZfGq93xGFE6aADtJ8+7tuNRJKtoTLn0yNa/WR4VrVKowYlXkHKbu
         7VOFVZFA5ULdw0sigDy5EwOOSovzm9p9o9WjRZFejIN3Z74zCn4YJ0aAXHVJYJUTiXyF
         Tx7A==
X-Forwarded-Encrypted: i=1; AJvYcCUk+Kt19WyS2Ju7MMIS2cprIYHqsDpDzioHPp45/WjHCamLDP42j9e+N7Uq+vywYdsLZ98LzS1F1eBj9tE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBLizpsxyhlMcqHAr9PjYOgRT4kRnprMpvcxWT6yZHzcQqbnue
	RHBJ2peBZJud+2ECt/Z8/yBTVgsVYZTnhs3OltLT0F09I6cAUmuJE1ufjCs5dDTibg==
X-Gm-Gg: ASbGncsOqeMTR5T94+MMed1AOUlFAMLJG9JWVAHBFN432EagUFTDWp+GNt9VdIQsrd9
	wHWZjuOv5rc0DLXdpoq1nLyt7qmR+PW3/lHQ/ihaoBLHZlIWnzfO5IcJ6NNcEm0t/bZAo1xDMwu
	ycrBmiGv5mGMw39F9P+z7iw81RYVCxjPfJMC2H5kyTTBo5XM+F4RPHBOBnR+7ee8reyAR65hn0F
	e+8fqodhrDvvqgHNyxQAOZpZCT5/NgOGSnZq3NWGGbyUqjvhNJHJNZqt7/1WQNO2Ii2Elm826yr
	MdpkEX9LVj1VGvugDo9RkRTV6MwXbzqyEBJIBCNBelAk/6qHSQZwR45Ftp2OOFUFtq2ZP64er+0
	fHYWWEP/3HjWSgrzzZbpckCAa6QEvMEzUsHvf4iMd9+k7crw24Zx8x+kR/qAvMZ1FP4eQ57lpDc
	7liTingaM=
X-Google-Smtp-Source: AGHT+IE8e8oTp/srzMadQ4RpA3XUHOZCYJ3r0yBdYsSop60esVd23h5obNFSbNqhcNyVsOhQHAseDA==
X-Received: by 2002:a05:6902:220d:b0:e8b:c02e:385b with SMTP id 3f1490d57ef6-e8bc2530fccmr240593276.46.1752609838129;
        Tue, 15 Jul 2025 13:03:58 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e8b7afcd1d2sm3729461276.45.2025.07.15.13.03.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 13:03:57 -0700 (PDT)
Date: Tue, 15 Jul 2025 13:03:40 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
    Andrew Morton <akpm@linux-foundation.org>
cc: Baolin Wang <baolin.wang@linux.alibaba.com>, 
    Matthew Wilcox <willy@infradead.org>, hughd@google.com, david@redhat.com, 
    ziy@nvidia.com, Liam.Howlett@oracle.com, npache@redhat.com, 
    ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org, vbabka@suse.cz, 
    rppt@kernel.org, surenb@google.com, mhocko@suse.com, linux-mm@kvack.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm: fault in complete folios instead of individual
 pages for tmpfs
In-Reply-To: <d0b24095-d7fc-459d-85ed-9c0797e9fca3@lucifer.local>
Message-ID: <3bf50873-4d1b-a7c7-112e-3a17ac16077f@google.com>
References: <440940e78aeb7430c5cc8b6d2088ae98265b9809.1751599072.git.baolin.wang@linux.alibaba.com> <20250704151858.73d35a24b4c2f53bdb0c1b85@linux-foundation.org> <4c055849-d7dd-4b9f-9666-fcb0bccf8681@linux.alibaba.com> <007c4a94-c94a-418e-9907-7510422f8ca4@lucifer.local>
 <23f1c3ab-16ca-41db-b008-22448d9e08f2@linux.alibaba.com> <d0b24095-d7fc-459d-85ed-9c0797e9fca3@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 9 Jul 2025, Lorenzo Stoakes wrote:
> On Tue, Jul 08, 2025 at 03:53:56PM +0800, Baolin Wang wrote:
> > On 2025/7/7 21:33, Lorenzo Stoakes wrote:
> > > On Sun, Jul 06, 2025 at 10:02:35AM +0800, Baolin Wang wrote:
> > > > On 2025/7/5 06:18, Andrew Morton wrote:
> > > > > On Fri,  4 Jul 2025 11:19:26 +0800 Baolin Wang <baolin.wang@linux.alibaba.com> wrote:
> > > > >
> > > > > > After commit acd7ccb284b8 ("mm: shmem: add large folio support for tmpfs"),
> > > > > > tmpfs can also support large folio allocation (not just PMD-sized large
> > > > > > folios).
> > > > > >
> > > > > > However, when accessing tmpfs via mmap(), although tmpfs supports large folios,
> > > > > > we still establish mappings at the base page granularity, which is unreasonable.
> > > > > >
> > > > > > We can map multiple consecutive pages of a tmpfs folios at once according to
> > > > > > the size of the large folio. On one hand, this can reduce the overhead of page
> > > > > > faults; on the other hand, it can leverage hardware architecture optimizations
> > > > > > to reduce TLB misses, such as contiguous PTEs on the ARM architecture.
> > > > > >
> > > > > > Moreover, tmpfs mount will use the 'huge=' option to control large folio
> > > > > > allocation explicitly. So it can be understood that the process's RSS statistics
> > > > > > might increase, and I think this will not cause any obvious effects for users.
> > > > > >
> > > > > > Performance test:
> > > > > > I created a 1G tmpfs file, populated with 64K large folios, and write-accessed it
> > > > > > sequentially via mmap(). I observed a significant performance improvement:
> > > > >
> > > > > That doesn't sound like a crazy thing to do.
> > > > >
> > > > > > Before the patch:
> > > > > > real	0m0.158s
> > > > > > user	0m0.008s
> > > > > > sys	0m0.150s
> > > > > >
> > > > > > After the patch:
> > > > > > real	0m0.021s
> > > > > > user	0m0.004s
> > > > > > sys	0m0.017s
> > > > >
> > > > > And look at that.
> > > > >
> > > > > > diff --git a/mm/memory.c b/mm/memory.c
> > > > > > index 0f9b32a20e5b..9944380e947d 100644
> > > > > > --- a/mm/memory.c
> > > > > > +++ b/mm/memory.c
> > > > > > @@ -5383,10 +5383,10 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
> > > > > >    	/*
> > > > > >    	 * Using per-page fault to maintain the uffd semantics, and same
> > > > > > -	 * approach also applies to non-anonymous-shmem faults to avoid
> > > > > > +	 * approach also applies to non shmem/tmpfs faults to avoid
> > > > > >    	 * inflating the RSS of the process.
> > > > > >    	 */
> > > > > > -	if (!vma_is_anon_shmem(vma) || unlikely(userfaultfd_armed(vma)) ||
> > > > > > +	if (!vma_is_shmem(vma) || unlikely(userfaultfd_armed(vma)) ||
> > > > > >    	    unlikely(needs_fallback)) {
> > > > > >    		nr_pages = 1;
> > > > > >    	} else if (nr_pages > 1) {
> > > > >
> > > > > and that's it?
> > > > >
> > > > > I'm itching to get this into -stable, really.  What LTS user wouldn't
> > > > > want this?
> > > >
> > > > This is an improvement rather than a bugfix, so I don't think it needs to go
> > > > into LTS.
> > > >
> > > > Could it be viewed as correcting an oversight in
> > > > > acd7ccb284b8?
> > > >
> > > > Yes, I should have added this optimization in the series of the commit
> > > > acd7ccb284b8. But obviously, I missed this :(.
> > >
> > > Buuut if this was an oversight for that patch that causes an unnecessary
> > > perf degradation, surely this should have fixes tag + cc stable no?
> >
> > IMO, this commit acd7ccb284b8 won't cause perf degradation, instead it is
> > used to introduce a new feature, while the current patch is a further
> > reasonable optimization. As I mentioned, this is an improvement, not a
> > bugfix or a patch to address performance regression.
> 
> 4Well :) you say yourself it was an oversight, and it very clearly has a perf
> _impact_, which if you compare backwards to acd7ccb284b8 is a degradation, but I
> get your point.
> 
> However, since you say 'oversight' this seems to me that you really meant to
> have included it but hadn't noticed, and additionally, since it just seems to be
> an unequivical good - let's maybe flip this round - why NOT backport it to
> stable?

I strongly agree with Baolin: this patch is good, thank you, but it is
a performance improvement, a new feature, not a candidate for the stable
tree.  I'm surprised anyone thinks otherwise: Andrew, please delete that
stable tag before advancing the patch from mm-unstable to mm-stable.

And the Fixee went into 6.14, so it couldn't go to 6.12 LTS anyway.

An unequivocal good? I'm not so sure.

I expect it ought to be limited, by fault_around_bytes (or suchlike).

If I understand all the mTHP versus large folio versus PMD-huge handling
correctly (and of course I do not, I'm still weeks if not months away
from understanding most of it), the old vma_is_anon_shmem() case would
be limited by the shmem mTHP tunables, and one can reasonably argue that
they would already take fault_around_bytes-like considerations into account;
but the newly added file-written cases are governed by huge= mount options
intended for PMD-size, but (currently) permitting all lesser orders.
I don't think that mounting a tmpfs huge=always implies that mapping
256 PTEs for one fault is necessarily a good strategy.

But looking in the opposite direction, why is there now a vma_is_shmem()
check there in finish_fault() at all?  If major filesystems are using
large folios, why aren't they also allowed to benefit from mapping
multiple PTEs at once (in this shared-writable case which the existing
fault-around does not cover - I presume to avoid write amplification,
but that's not an issue when the folio is large already).

It's fine to advance cautiously, keeping this to shmem in coming release;
but I think it should be extended soon (without any backport to stable),
and consideration given to limiting it.

Hugh

