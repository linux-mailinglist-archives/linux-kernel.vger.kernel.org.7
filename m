Return-Path: <linux-kernel+bounces-821368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85436B81141
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 18:49:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2714317ECBC
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 16:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEDB52F8BC9;
	Wed, 17 Sep 2025 16:49:49 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6371F21FF36
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 16:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758127789; cv=none; b=X8z+6yCn/TGw+C9OQhA+dVR7DwtxA9kW6c6i7PJBsNMJa6mzRLtMmFcXKWBINkc/tVx/K15bdhuWD3Hck7/cnhBBLhqrEj3FV4q4oqFsstrw0ryGrU3UpKeq2ejTuuuAH+i62Fsi+H6sSgW0HMiLdzuytQWWOPmn+4wNqtrcdI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758127789; c=relaxed/simple;
	bh=9zgPgn+1YrC/OO84n+K6fqDLT2gig0vIuSnqwEZ2Pig=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hPV5ZWrQKvus+qreqS+zyx94BproC+LCTKLgf3Dv3JPlK8PLNNdVQ9E4dgjGn+A4ynNXT12SQOtuNBSwuU7sZkoaQTH1rHzV0iqmkwLNTE+vv+IxwoOc0r53mRPonsgKpJzxyJevzMaWPQcRVpdTTDjg0KWrAxZRywB5KCQuG+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cRl6R02Rxz6M5JT;
	Thu, 18 Sep 2025 00:46:55 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id D28A314020A;
	Thu, 18 Sep 2025 00:49:43 +0800 (CST)
Received: from localhost (10.203.177.15) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 17 Sep
 2025 18:49:42 +0200
Date: Wed, 17 Sep 2025 17:49:41 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Wei Xu <weixugc@google.com>
CC: David Rientjes <rientjes@google.com>, Gregory Price <gourry@gourry.net>,
	Matthew Wilcox <willy@infradead.org>, Bharata B Rao <bharata@amd.com>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
	<dave.hansen@intel.com>, <hannes@cmpxchg.org>, <mgorman@techsingularity.net>,
	<mingo@redhat.com>, <peterz@infradead.org>, <raghavendra.kt@amd.com>,
	<riel@surriel.com>, <sj@kernel.org>, <ying.huang@linux.alibaba.com>,
	<ziy@nvidia.com>, <dave@stgolabs.net>, <nifan.cxl@gmail.com>,
	<xuezhengchu@huawei.com>, <yiannis@zptcorp.com>, <akpm@linux-foundation.org>,
	<david@redhat.com>, <byungchul@sk.com>, <kinseyho@google.com>,
	<joshua.hahnjy@gmail.com>, <yuanchu@google.com>, <balbirs@nvidia.com>,
	<alok.rathore@samsung.com>
Subject: Re: [RFC PATCH v2 0/8] mm: Hot page tracking and promotion
 infrastructure
Message-ID: <20250917174941.000061d3@huawei.com>
In-Reply-To: <CAAPL-u-d6taxKZuhTe=T-0i2gdoDYSSqOeSVi3JmFt_dDbU4cQ@mail.gmail.com>
References: <20250910144653.212066-1-bharata@amd.com>
	<aMGbpDJhOx7wHqpo@casper.infradead.org>
	<aMGg9AOaCWfxDfqX@gourry-fedora-PF4VCD3F>
	<7e3e7327-9402-bb04-982e-0fb9419d1146@google.com>
	<CAAPL-u-d6taxKZuhTe=T-0i2gdoDYSSqOeSVi3JmFt_dDbU4cQ@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 16 Sep 2025 17:30:46 -0700
Wei Xu <weixugc@google.com> wrote:

> On Tue, Sep 16, 2025 at 12:45=E2=80=AFPM David Rientjes <rientjes@google.=
com> wrote:
> >
> > On Wed, 10 Sep 2025, Gregory Price wrote:
> > =20
> > > On Wed, Sep 10, 2025 at 04:39:16PM +0100, Matthew Wilcox wrote: =20
> > > > On Wed, Sep 10, 2025 at 08:16:45PM +0530, Bharata B Rao wrote: =20
> > > > > This patchset introduces a new subsystem for hot page tracking
> > > > > and promotion (pghot) that consolidates memory access information
> > > > > from various sources and enables centralized promotion of hot
> > > > > pages across memory tiers. =20
> > > >
> > > > Just to be clear, I continue to believe this is a terrible idea and=
 we
> > > > should not do this.  If systems will be built with CXL (and given t=
he
> > > > horrendous performance, I cannot see why they would be), the kernel
> > > > should not be migrating memory around like this. =20
> > >
> > > I've been considered this problem from the opposite approach since LS=
FMM.
> > >
> > > Rather than decide how to move stuff around, what if instead we just
> > > decide not to ever put certain classes of memory on CXL.  Right now, =
so
> > > long as CXL is in the page allocator, it's the wild west - any page c=
an
> > > end up anywhere.
> > >
> > > I have enough data now from ZONE_MOVABLE-only CXL deployments on real
> > > workloads to show local CXL expansion is valuable and performant enou=
gh
> > > to be worth deploying - but the key piece for me is that ZONE_MOVABLE
> > > disallows GFP_KERNEL.  For example: this keeps SLAB meta-data out of
> > > CXL, but allows any given user-driven page allocation (including page
> > > cache, file, and anon mappings) to land there.
> > > =20
> >
> > This is similar to our use case, although the direct allocation can be
> > controlled by cpusets or mempolicies as needed depending on the memory
> > access latency required for the workload; nothing new there, though, it=
's
> > the same argument as NUMA in general and the abstraction of these far
> > memory nodes as separate NUMA nodes makes this very straightforward.
> > =20
> > > I'm hoping to share some of this data in the coming months.
> > >
> > > I've yet to see any strong indication that a complex hotness/movement
> > > system is warranted (yet) - but that may simply be because we have
> > > local cards with no switching involved. So far LRU-based promotion and
> > > demotion has been sufficient.
> > > =20
> >
> > To me, this is a key point.  As we've discussed in meetings, we're in t=
he
> > early days here.  The CHMU does provide a lot of flexibility, both to
> > create very good and very bad hotness trackers.  But I think the key po=
int
> > is that we have multiple sources of hotness information depending on the
> > platform and some of these sources only make sense for the kernel (or a
> > BPF offload) to maintain as the source of truth.  Some of these sources
> > will be clear-on-read so only one entity would be possible to have as t=
he
> > source of truth of page hotness.
> >
> > I've been pretty focused on the promotion story here rather than demoti=
on
> > because of how responsive it needs to be.  Harvesting the page table
> > accessed bits or waiting on a sliding window through NUMA Balancing (ev=
en
> > NUMAB=3D2) is not as responsive as needed for very fast promotion to top
> > tier memory, hence things like the CHMU (or PEBS or IBS etc).
> >
> > A few things that I think we need to discuss and align on:
> >
> >  - the kernel as the source of truth for all memory hotness information,
> >    which can then be abstracted and used for multiple downstream purpos=
es,
> >    memory tiering only being one of them
> >
> >  - the long-term plan for NUMAB=3D2 and memory tiering support in the k=
ernel
> >    in general, are we planning on supporting this through NUMA hint fau=
lts
> >    forever despite their drawbacks (too slow, too much overhead for KVM)
> >
> >  - the role of the kernel vs userspace in driving the memory migration;
> >    lots of discussion on hardware assists that can be leveraged for mem=
ory
> >    migration but today the balancing is driven in process context.  The
> >    kthread as the driver of migration is yet to be a sold argument, but
> >    are where a number of companies are currently looking
> >
> > There's also some feature support that is possible with these CXL memory
> > expansion devices that have started to pop up in labs that can also
> > drastically reduce overall TCO.  Perhaps Wei Xu, cc'd, will be able to
> > chime in as well.
> >
> > This topic seems due for an alignment session as well, so will look to =
get
> > that scheduled in the coming weeks if people are up for it. =20
>=20
> Our experience is that workloads in hyper-scalar data centers such as
> Google often have significant cold memory. Offloading this to CXL memory
> devices, backed by cheaper, lower-performance media (e.g. DRAM with
> hardware compression), can be a practical approach to reduce overall
> TCO. Page promotion and demotion are then critical for such a tiered
> memory system.

For the hardware compression devices how are you dealing with capacity vari=
ation
/ overcommit?  Whilst there have been some discussions on that but without a
backing store of flash or similar it seems to be challenging to use
compressed memory in a tiering system (so as 'normalish' memory) unless you
don't mind occasionally and unexpectedly running out of memory (in nasty
async ways as dirty cache lines get written back).

Or do you mean zswap type use with a hardware offload of the actual
compression?

>=20
> A kernel thread to drive hot page collection and promotion seems
> logical, especially since hot page data from new sources (e.g. CHMU)
> are collected outside the process execution context and in the form of
> physical addresses.
>=20
> I do agree that we need to balance the complexity and benefits of any
> new data structures for hotness tracking.
>=20
> > > It seems the closer to random-access the access pattern, the less
> > > valuable ANY movement is. Which should be intuitive.  But, having
> > > CXL beats touching disk every day of the week.
> > >
> > > So I've become conflicted on this work - but only because I haven't s=
een
> > > the data to suggest such complexity is warranted.
> > >
> > > ~Gregory
> > > =20
>=20


