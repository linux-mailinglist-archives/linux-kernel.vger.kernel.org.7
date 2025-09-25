Return-Path: <linux-kernel+bounces-832683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0110FBA0190
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 17:01:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63B124A2FA4
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 15:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67D031D63C2;
	Thu, 25 Sep 2025 15:01:15 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DFB51A26B
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 15:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758812474; cv=none; b=b12p8slBlgIReSmPQEYTHc5Xmn2AUHiQJU0hmViwB7bOZood1XwmiQiAQI0RwdBe7KB1Q2cita5l+OJ7e9jSOv9PapWikGqAxAHBQU2NmPzUTMbHzt6ArbhWCdwlVjv5OnC8ibSBXfAYGPzUzSgYkfRsGoY1PpP8ZVy9uOm36Ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758812474; c=relaxed/simple;
	bh=UC5g0qS6iV8WPBD9un6eGtI5r4+442ANxvlC/E6M6K4=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lhjNR99ZvG0Z9ROjS/8O6RNJhqYEAkgGR0LYrTD20T8d895ICuXzn1PNI1Qk+u8snno5RJOEM1ShAtYn3lJT6UnYFWRdj2YxDzdo/vIfmQ/pdQRwceBEMRLWgF6u/Gxs7yeDmc0W5knopGyOc3z7IliQAW6+hoonxoIQaCY1Byk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cXcK72fQHz6M4l7;
	Thu, 25 Sep 2025 22:58:03 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id AD7361402F2;
	Thu, 25 Sep 2025 23:01:03 +0800 (CST)
Received: from localhost (10.47.28.112) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 25 Sep
 2025 16:01:02 +0100
Date: Thu, 25 Sep 2025 16:00:58 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Yiannis Nikolakopoulos <yiannis.nikolakop@gmail.com>
CC: Wei Xu <weixugc@google.com>, David Rientjes <rientjes@google.com>, Gregory
 Price <gourry@gourry.net>, Matthew Wilcox <willy@infradead.org>, Bharata B
 Rao <bharata@amd.com>, <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
	<dave.hansen@intel.com>, <hannes@cmpxchg.org>, <mgorman@techsingularity.net>,
	<mingo@redhat.com>, <peterz@infradead.org>, <raghavendra.kt@amd.com>,
	<riel@surriel.com>, <sj@kernel.org>, <ying.huang@linux.alibaba.com>,
	<ziy@nvidia.com>, <dave@stgolabs.net>, <nifan.cxl@gmail.com>,
	<xuezhengchu@huawei.com>, <akpm@linux-foundation.org>, <david@redhat.com>,
	<byungchul@sk.com>, <kinseyho@google.com>, <joshua.hahnjy@gmail.com>,
	<yuanchu@google.com>, <balbirs@nvidia.com>, <alok.rathore@samsung.com>,
	<yiannis@zptcorp.com>, Adam Manzanares <a.manzanares@samsung.com>
Subject: Re: [RFC PATCH v2 0/8] mm: Hot page tracking and promotion
 infrastructure
Message-ID: <20250925160058.00002645@huawei.com>
In-Reply-To: <5A7E0646-0324-4463-8D93-A1105C715EB3@gmail.com>
References: <20250910144653.212066-1-bharata@amd.com>
	<aMGbpDJhOx7wHqpo@casper.infradead.org>
	<aMGg9AOaCWfxDfqX@gourry-fedora-PF4VCD3F>
	<7e3e7327-9402-bb04-982e-0fb9419d1146@google.com>
	<CAAPL-u-d6taxKZuhTe=T-0i2gdoDYSSqOeSVi3JmFt_dDbU4cQ@mail.gmail.com>
	<20250917174941.000061d3@huawei.com>
	<5A7E0646-0324-4463-8D93-A1105C715EB3@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml500011.china.huawei.com (7.191.174.215) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Thu, 25 Sep 2025 16:03:46 +0200
Yiannis Nikolakopoulos <yiannis.nikolakop@gmail.com> wrote:

Hi Yiannis,


> > On 17 Sep 2025, at 18:49, Jonathan Cameron <jonathan.cameron@huawei.com=
> wrote:
> >=20
> > On Tue, 16 Sep 2025 17:30:46 -0700
> > Wei Xu <weixugc@google.com> wrote:
> >  =20
> >> On Tue, Sep 16, 2025 at 12:45=E2=80=AFPM David Rientjes <rientjes@goog=
le.com> wrote: =20
> >>>=20
> >>> On Wed, 10 Sep 2025, Gregory Price wrote:
> >>>  =20
> >>>> On Wed, Sep 10, 2025 at 04:39:16PM +0100, Matthew Wilcox wrote:   =20
> >>>>> On Wed, Sep 10, 2025 at 08:16:45PM +0530, Bharata B Rao wrote:   =20
> >>>>>> This patchset introduces a new subsystem for hot page tracking
> >>>>>> and promotion (pghot) that consolidates memory access information
> >>>>>> from various sources and enables centralized promotion of hot
> >>>>>> pages across memory tiers.   =20
> >>>>>=20
> >>>>> Just to be clear, I continue to believe this is a terrible idea and=
 we
> >>>>> should not do this.  If systems will be built with CXL (and given t=
he
> >>>>> horrendous performance, I cannot see why they would be), the kernel
> >>>>> should not be migrating memory around like this.   =20
> >>>>=20
> >>>> I've been considered this problem from the opposite approach since L=
SFMM.
> >>>>=20
> >>>> Rather than decide how to move stuff around, what if instead we just
> >>>> decide not to ever put certain classes of memory on CXL.  Right now,=
 so
> >>>> long as CXL is in the page allocator, it's the wild west - any page =
can
> >>>> end up anywhere.
> >>>>=20
> >>>> I have enough data now from ZONE_MOVABLE-only CXL deployments on real
> >>>> workloads to show local CXL expansion is valuable and performant eno=
ugh
> >>>> to be worth deploying - but the key piece for me is that ZONE_MOVABLE
> >>>> disallows GFP_KERNEL.  For example: this keeps SLAB meta-data out of
> >>>> CXL, but allows any given user-driven page allocation (including page
> >>>> cache, file, and anon mappings) to land there.
> >>>>  =20
> >>>  =20
> [snip]
> >>> There's also some feature support that is possible with these CXL mem=
ory
> >>> expansion devices that have started to pop up in labs that can also
> >>> drastically reduce overall TCO.  Perhaps Wei Xu, cc'd, will be able to
> >>> chime in as well.
> >>>=20
> >>> This topic seems due for an alignment session as well, so will look t=
o get
> >>> that scheduled in the coming weeks if people are up for it.   =20
> >>=20
> >> Our experience is that workloads in hyper-scalar data centers such as
> >> Google often have significant cold memory. Offloading this to CXL memo=
ry
> >> devices, backed by cheaper, lower-performance media (e.g. DRAM with
> >> hardware compression), can be a practical approach to reduce overall
> >> TCO. Page promotion and demotion are then critical for such a tiered
> >> memory system. =20
> >=20
> > For the hardware compression devices how are you dealing with capacity =
variation
> > / overcommit?   =20
> I understand that this is indeed one of the key questions from the upstre=
am
> kernel=E2=80=99s perspective.
> So, I am jumping in to answer w.r.t. what we do in ZeroPoint; obviously I=
 can
> not speak of other solutions/deployments. However, our HW interface follo=
ws=20
> existing open specifications from OCP=E2=80=8B [1], so what I am describi=
ng below is
> more widely applicable.
>=20
> At a very high level, the way our HW works is that the DPA is indeed
> overcommitted. Then, there is a control plane over CXL.io (PCIe) which
> exposes the real remaining capacity, as well as some configurable
> MSI-X interrupts that raise warnings when the capacity crosses over
> certain configurable thresholds.
>=20
> Last year I presented this interface in LSF/MM [2]. Based on the feedback=
 I
> got there, we have an early prototype that acts as the *last* memory tier
> before reclaim (kind of "compressed tier in lieu of discard" as was
> suggested to me by Dan).
>=20
> What is different from standard tiering is that the control plane is
> checked on demotion to make sure there is still capacity left. If not, the
> demotion fails. While this seems stable so far, a missing piece is to
> ensure that this tier is mainly written by demotions and not arbitrary ke=
rnel
> allocations (at least as a starting point). I want to explore how mempoli=
cies
> can help there, or something of the sort that Gregory described.
>=20
> This early prototype still needs quite some work in order to find the rig=
ht
> abstractions. Hopefully, I will be able to push an RFC in the near future
> (a couple of months).
>=20
> > Whilst there have been some discussions on that but without a
> > backing store of flash or similar it seems to be challenging to use
> > compressed memory in a tiering system (so as 'normalish' memory) unless=
 you
> > don't mind occasionally and unexpectedly running out of memory (in nasty
> > async ways as dirty cache lines get written back). =20
> There =E2=80=8Bare several things that may be done on the device side. Fo=
r now, I
> think the kernel should be unaware of these. But with what I described
> above, the goal is to have the capacity thresholds configured in a way
> that we can absorb the occasional dirty cache lines that are written back.

In worst case they are far from occasional. It's not hard to imagine a mali=
cious
program that ensures that all L3 in a system (say 256MiB+) is full of cache=
 lines
from the far compressed memory all of which are changed in a fashion that m=
akes
the allocation much less compressible.  If you are doing compression at cac=
he line
granularity that's not so bad because it would only be 256MiB margin needed.
If the system in question is doing large block side compression, say 4KiB.
Then we have a 64x write amplification multiplier. If the virus is streamin=
g over
memory the evictions we are seeing at the result of new lines being fetched
to be made much less compressible.

Add a accelerator (say DPDK or other zero copy into userspace buffers) into=
 the
mix and you have a mess. You'll need to be extremely careful with what goes
in this compressed memory or hold enormous buffer capacity against fast
changes in compressability.

Key is that all software is potentially malicious (sometimes accidentally s=
o ;)

Now, if we can put this into a special pool where it is acceptable to drop =
the writes
and return poison (so the application crashes) then that may be fine.

Or block writes.   Running compressed memory as read only CoW is one way to
avoid this problem.


> >=20
> > Or do you mean zswap type use with a hardware offload of the actual
> > compression? =20
> I would categorize this as a completely different discussion (and product
> line for us).
>=20
> [1] https://www.opencompute.org/documents/hyperscale-tiered-memory-expand=
er-specification-for-compute-express-link-cxl-1-pdf
> [2] https://www.youtube.com/watch?v=3DtXWEbaJmZ_s
>=20
> Thanks,
> Yiannis
>=20
> PS: Sending from a personal email address to avoid issues with
> confidentiality footers of the corporate domain.

