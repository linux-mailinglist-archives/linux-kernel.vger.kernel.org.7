Return-Path: <linux-kernel+bounces-819783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DBDB0B7D324
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:21:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B7171B27CC9
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 00:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE787145B16;
	Wed, 17 Sep 2025 00:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kGULXJ8f"
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E23736B
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 00:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758069060; cv=none; b=uyQ0jgNG8jFHiP7rdvQnplb+A0fe9S9+k82wvuVJuCThhibDTvp8ReEIYSDO9I06C1MwPgCoqyZH+ToBwZmD9RrE2LifAKvOPkLOMhGWrbw7reqvwcqSMFn1B+qKh9pUhi+AH7pHbTEFX7/7ddetmhVpu73zGUYTqAgAT/ntI9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758069060; c=relaxed/simple;
	bh=X+PlxhuoYBa9kCs/1qjvLCder9DZCDn37XvCstjg3Ps=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hEtDrE/qR78acEnkQsDCAACaIAf0E3kJ/GUOpKoFWswM45+RU0ibzxPvB2K/NAPmPZe3C6t2sYw6hNZJlUjTLq4hCrxvPG+Q16F1M/a6DH5rneJZZFHeHh5j5mszLzCG4B2n2J7DSC2ii7UeohIFnc+x4IGyPIeNdcBLJQjeaDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kGULXJ8f; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-8a967f3a873so1769801241.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 17:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758069058; x=1758673858; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CAKa0U7jZSpuvuM4buIty/jYeCtOj2xsvZscq/9Zh0w=;
        b=kGULXJ8f2q8c0gJRw3E7g+n3VQk+skk7LwjGPpbPMcaLXm5L4zKI9bodkKkWT8ooUG
         eMLlSftVfb5EgEI295HPnhPTfoRV/U10TfipHrPv5oEab48rgq/39U8DGHvCzPRTcB+r
         2glxliFDy+vAZPtt6iqWA9Wos0B6ih56XhSLcOGajMBKWJvuV0ketzgPRxbVuFmZ4+YQ
         sPxk2wpAwPNdlE/147QjzJKO51BeBZzOE9197A0tDftYYpkbr+JnNptNyxXjoUoaIytD
         kd45yN6DCWKzPoXhe4XTm07ny4QCbu/PVIWyL3Ms+TA6baco6cuiGOibPW1OFvQRUFlc
         osTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758069058; x=1758673858;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CAKa0U7jZSpuvuM4buIty/jYeCtOj2xsvZscq/9Zh0w=;
        b=dzdcmBt2iKHN4dschteNRD8cc5tQ57PgeKlAB9b2Nk/KyeUW0FlHGZ2o9Ukqj58bVP
         QqUnWxKqe2PqTU9+84OImb7i+IkJKJ/bgyD67ckHyPo/OpfzMAScBawU8U6uUC71V/5r
         EFZglQZ36COCi3QGmLVonZhAuEa8mOFb1Q31L8FbxprSxs/E62WHo8lMQZZFA4lnBqLk
         cJpROnGBkEkUZwen6rHGtz3gIXh8OSl693aWfpHlBcl2MAYBn5lcHF/NLywYtRBMnm9v
         Snuzswe8y73NDww0OCQmpv/5SK0auKg0HquQRUmZuVKRxWx1cJQSe0xrOxIDlVIsBwMC
         ojsA==
X-Forwarded-Encrypted: i=1; AJvYcCUZU9H+NOra4RW8kA0KdlnUltEtG5B6BjVaCK84vfGIcqm4ce6gYPTU42wojLVVMZP/c+zoBUs8x3Zw9hs=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywh+YTNv7m0teBn0kD8EKcKem4+yGagxKsIGJXtA4JUPjLHx5sI
	a1eKFt21xZrSBrxrxHDy3CvUSWNmbNxO3UZdQg4HNcFhg3l3d/veCm3p0i7uhJtlbAzEtAE91tv
	U/LkvMN8HQg6nqaCb2ON8KfsYTBPU4sQGa1sN3FS1
X-Gm-Gg: ASbGncuTWbz8y0KvSxFZdViZk2ntsETOdeIhRa2veGt4w/IjEJ2FEsHNpUCt3RWwDoU
	4SELissMHsHka6jQWUOaBcyQX3pV/0frBGas9x+X3pwWU8HTqnENeUoNa9Yn8e20ioLpwGnqZ9w
	8R14j31COoxbmrFpIruycovhNi6Xa4v6r1ClOJy43Uj0kxxk/DKu4SwcoWMVuExgO8NCoxj8CPX
	UM/7bM3uQRXLqLSYohql6Hd/ytPRR+LJXcxxvbRHF87
X-Google-Smtp-Source: AGHT+IGpcvzQc7vHHG+kc4oHBhDjO4zKXCvjee+xT79Ol/YyeJ/1u96xFdzMVFkD0elqQQ4hUMuBMrxsaBUf0oG58gU=
X-Received: by 2002:a05:6102:2c15:b0:522:b5e6:2f46 with SMTP id
 ada2fe7eead31-56d4d993fdbmr67674137.5.1758069057773; Tue, 16 Sep 2025
 17:30:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250910144653.212066-1-bharata@amd.com> <aMGbpDJhOx7wHqpo@casper.infradead.org>
 <aMGg9AOaCWfxDfqX@gourry-fedora-PF4VCD3F> <7e3e7327-9402-bb04-982e-0fb9419d1146@google.com>
In-Reply-To: <7e3e7327-9402-bb04-982e-0fb9419d1146@google.com>
From: Wei Xu <weixugc@google.com>
Date: Tue, 16 Sep 2025 17:30:46 -0700
X-Gm-Features: AS18NWA9y0jYxcd9ms5fIx1WiL1jSVSZ98u37raOtlChuyNgOvkjQE1POFTfnB4
Message-ID: <CAAPL-u-d6taxKZuhTe=T-0i2gdoDYSSqOeSVi3JmFt_dDbU4cQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/8] mm: Hot page tracking and promotion infrastructure
To: David Rientjes <rientjes@google.com>
Cc: Gregory Price <gourry@gourry.net>, Matthew Wilcox <willy@infradead.org>, 
	Bharata B Rao <bharata@amd.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Jonathan.Cameron@huawei.com, dave.hansen@intel.com, hannes@cmpxchg.org, 
	mgorman@techsingularity.net, mingo@redhat.com, peterz@infradead.org, 
	raghavendra.kt@amd.com, riel@surriel.com, sj@kernel.org, 
	ying.huang@linux.alibaba.com, ziy@nvidia.com, dave@stgolabs.net, 
	nifan.cxl@gmail.com, xuezhengchu@huawei.com, yiannis@zptcorp.com, 
	akpm@linux-foundation.org, david@redhat.com, byungchul@sk.com, 
	kinseyho@google.com, joshua.hahnjy@gmail.com, yuanchu@google.com, 
	balbirs@nvidia.com, alok.rathore@samsung.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2025 at 12:45=E2=80=AFPM David Rientjes <rientjes@google.co=
m> wrote:
>
> On Wed, 10 Sep 2025, Gregory Price wrote:
>
> > On Wed, Sep 10, 2025 at 04:39:16PM +0100, Matthew Wilcox wrote:
> > > On Wed, Sep 10, 2025 at 08:16:45PM +0530, Bharata B Rao wrote:
> > > > This patchset introduces a new subsystem for hot page tracking
> > > > and promotion (pghot) that consolidates memory access information
> > > > from various sources and enables centralized promotion of hot
> > > > pages across memory tiers.
> > >
> > > Just to be clear, I continue to believe this is a terrible idea and w=
e
> > > should not do this.  If systems will be built with CXL (and given the
> > > horrendous performance, I cannot see why they would be), the kernel
> > > should not be migrating memory around like this.
> >
> > I've been considered this problem from the opposite approach since LSFM=
M.
> >
> > Rather than decide how to move stuff around, what if instead we just
> > decide not to ever put certain classes of memory on CXL.  Right now, so
> > long as CXL is in the page allocator, it's the wild west - any page can
> > end up anywhere.
> >
> > I have enough data now from ZONE_MOVABLE-only CXL deployments on real
> > workloads to show local CXL expansion is valuable and performant enough
> > to be worth deploying - but the key piece for me is that ZONE_MOVABLE
> > disallows GFP_KERNEL.  For example: this keeps SLAB meta-data out of
> > CXL, but allows any given user-driven page allocation (including page
> > cache, file, and anon mappings) to land there.
> >
>
> This is similar to our use case, although the direct allocation can be
> controlled by cpusets or mempolicies as needed depending on the memory
> access latency required for the workload; nothing new there, though, it's
> the same argument as NUMA in general and the abstraction of these far
> memory nodes as separate NUMA nodes makes this very straightforward.
>
> > I'm hoping to share some of this data in the coming months.
> >
> > I've yet to see any strong indication that a complex hotness/movement
> > system is warranted (yet) - but that may simply be because we have
> > local cards with no switching involved. So far LRU-based promotion and
> > demotion has been sufficient.
> >
>
> To me, this is a key point.  As we've discussed in meetings, we're in the
> early days here.  The CHMU does provide a lot of flexibility, both to
> create very good and very bad hotness trackers.  But I think the key poin=
t
> is that we have multiple sources of hotness information depending on the
> platform and some of these sources only make sense for the kernel (or a
> BPF offload) to maintain as the source of truth.  Some of these sources
> will be clear-on-read so only one entity would be possible to have as the
> source of truth of page hotness.
>
> I've been pretty focused on the promotion story here rather than demotion
> because of how responsive it needs to be.  Harvesting the page table
> accessed bits or waiting on a sliding window through NUMA Balancing (even
> NUMAB=3D2) is not as responsive as needed for very fast promotion to top
> tier memory, hence things like the CHMU (or PEBS or IBS etc).
>
> A few things that I think we need to discuss and align on:
>
>  - the kernel as the source of truth for all memory hotness information,
>    which can then be abstracted and used for multiple downstream purposes=
,
>    memory tiering only being one of them
>
>  - the long-term plan for NUMAB=3D2 and memory tiering support in the ker=
nel
>    in general, are we planning on supporting this through NUMA hint fault=
s
>    forever despite their drawbacks (too slow, too much overhead for KVM)
>
>  - the role of the kernel vs userspace in driving the memory migration;
>    lots of discussion on hardware assists that can be leveraged for memor=
y
>    migration but today the balancing is driven in process context.  The
>    kthread as the driver of migration is yet to be a sold argument, but
>    are where a number of companies are currently looking
>
> There's also some feature support that is possible with these CXL memory
> expansion devices that have started to pop up in labs that can also
> drastically reduce overall TCO.  Perhaps Wei Xu, cc'd, will be able to
> chime in as well.
>
> This topic seems due for an alignment session as well, so will look to ge=
t
> that scheduled in the coming weeks if people are up for it.

Our experience is that workloads in hyper-scalar data centers such as
Google often have significant cold memory. Offloading this to CXL memory
devices, backed by cheaper, lower-performance media (e.g. DRAM with
hardware compression), can be a practical approach to reduce overall
TCO. Page promotion and demotion are then critical for such a tiered
memory system.

A kernel thread to drive hot page collection and promotion seems
logical, especially since hot page data from new sources (e.g. CHMU)
are collected outside the process execution context and in the form of
physical addresses.

I do agree that we need to balance the complexity and benefits of any
new data structures for hotness tracking.

> > It seems the closer to random-access the access pattern, the less
> > valuable ANY movement is. Which should be intuitive.  But, having
> > CXL beats touching disk every day of the week.
> >
> > So I've become conflicted on this work - but only because I haven't see=
n
> > the data to suggest such complexity is warranted.
> >
> > ~Gregory
> >

