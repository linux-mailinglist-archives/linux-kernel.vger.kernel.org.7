Return-Path: <linux-kernel+bounces-779433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C7CDB2F415
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 11:36:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC581A2777A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 09:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D69722D9788;
	Thu, 21 Aug 2025 09:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e060DsRR"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D7619007D
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 09:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755768895; cv=none; b=qCKhaZXP+URVm1zG94CT3Dbea+xSIsDJ2AQA19hm9jpif3V5AEluMMWoEtCEpv133sKiYJO6lbXlzH/CpjpKp/NVqxs+J2v+BtCdejDgeCRP+pyE8A87YUlPpkMuBa2j4loh7EnisyBm9SwMFdj3GNiYugcJXRbkkkvAhqlA1xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755768895; c=relaxed/simple;
	bh=6Vk2rNv6sQPb2ve7Pj2mP/GF1p2TJt4JFMI53lJXfL8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kHMU5NVrtgNbA5uxhppO5xMBqMp51KadCe0NSN6sLoK2hV902Xb6oeY2DKUhQFddYfplQ/Uch0SB8ZGQQXO0D0CuhYLYuZ8BelJ80bzIrP7LZodP6jtE/cLu+w1GF7DDgYAWcmy69gaY6gTsupXg9SwFshqQnSjuYuRVQC2630Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e060DsRR; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755768893; x=1787304893;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=6Vk2rNv6sQPb2ve7Pj2mP/GF1p2TJt4JFMI53lJXfL8=;
  b=e060DsRRG+6ceEXyKtBuiE/PaJW+FzC3V4VF6BI5Gr1qxLumn3rbfGt6
   5CrlS5dU26wffayxyJF0MRfJcmstZzAIggmUbrsJmBZSeuYInGLSCBz3n
   UEk25uMOE1YZ1nIoHYSd9geNxi7uC1veX8RHUNokFxqOmGojU5OA4Ovns
   cYmI3j14Jp+7wArEoB/mSWrplVLq4/hURinqB+/0QUS6GV3dzBuJqQ7WH
   nnEaTJJdrSDYsCaZ/RDRvoT22NvylG6Cel8zyf1H82iDHwRaKYTa8ElbR
   UrX01uCu1WBgwOjwsIf/ANH2wZ2HjXkFTN2vBnoDAXPg+CKkFMuVpoqQx
   Q==;
X-CSE-ConnectionGUID: aauKTFn4RhSb/jit2fgX+g==
X-CSE-MsgGUID: HfWJ+AFnSq2Pi2NHOXjYPA==
X-IronPort-AV: E=McAfee;i="6800,10657,11527"; a="57978877"
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; 
   d="scan'208";a="57978877"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 02:34:52 -0700
X-CSE-ConnectionGUID: Y0heiNaWTYy4UVfXra6P2w==
X-CSE-MsgGUID: N5zt3aWDSC2Q5n+oE/9ILg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; 
   d="scan'208";a="172786862"
Received: from johunt-mobl9.ger.corp.intel.com (HELO [10.245.245.201]) ([10.245.245.201])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 02:34:31 -0700
Message-ID: <05360f1a920afe31ddd743d21f217d7bf8ff1c45.camel@linux.intel.com>
Subject: Re: [RFC PATCH 1/6] mm/mmu_notifier: Allow multiple struct
 mmu_interval_notifier passes
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: Matthew Brost <matthew.brost@intel.com>
Cc: Alistair Popple <apopple@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	intel-xe@lists.freedesktop.org, Andrew Morton <akpm@linux-foundation.org>, 
 Simona Vetter <simona.vetter@ffwll.ch>, Dave Airlie <airlied@gmail.com>,
 dri-devel@lists.freedesktop.org, 	linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Christian =?ISO-8859-1?Q?K=F6nig?=	
 <christian.koenig@amd.com>
Date: Thu, 21 Aug 2025 11:34:25 +0200
In-Reply-To: <aKSZ1JduQwAFSFQn@lstrano-desk.jf.intel.com>
References: <20250809135137.259427-1-thomas.hellstrom@linux.intel.com>
	 <20250809135137.259427-2-thomas.hellstrom@linux.intel.com>
	 <20250818160726.GH599331@ziepe.ca>
	 <aKNT8GUu0r3i4Ikq@lstrano-desk.jf.intel.com>
	 <20250818163617.GI599331@ziepe.ca>
	 <aKNYUaPS0PiRk/yj@lstrano-desk.jf.intel.com>
	 <20250818164655.GJ599331@ziepe.ca>
	 <4lsv2lcd7lssyvcjvkqe4t2foubxbhuxrt2ptzee3csymz5gg3@jwrg3xow72lm>
	 <e96dcfd4ce7c84a5b66ff9d5f082ea209266ce48.camel@linux.intel.com>
	 <aKSZ1JduQwAFSFQn@lstrano-desk.jf.intel.com>
Organization: Intel Sweden AB, Registration Number: 556189-6027
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-08-19 at 08:35 -0700, Matthew Brost wrote:
> On Tue, Aug 19, 2025 at 01:33:40PM +0200, Thomas Hellstr=C3=B6m wrote:
> > On Tue, 2025-08-19 at 19:55 +1000, Alistair Popple wrote:
> > > On Mon, Aug 18, 2025 at 01:46:55PM -0300, Jason Gunthorpe wrote:
> > > > On Mon, Aug 18, 2025 at 09:44:01AM -0700, Matthew Brost wrote:
> > > > > On Mon, Aug 18, 2025 at 01:36:17PM -0300, Jason Gunthorpe
> > > > > wrote:
> > > > > > On Mon, Aug 18, 2025 at 09:25:20AM -0700, Matthew Brost
> > > > > > wrote:
> > > > > > > I think this choice makes sense: it allows embedding the
> > > > > > > wait
> > > > > > > state from
> > > > > > > the initial notifier call into the pass structure. Patch
> > > > > > > [6]
> > > > > > > shows this
> > > > > > > by attaching the issued TLB invalidation fences to the
> > > > > > > pass.
> > > > > > > Since a
> > > > > > > single notifier may be invoked multiple times with
> > > > > > > different
> > > > > > > ranges but
> > > > > > > the same seqno,
> > > > > >=20
> > > > > > That should be explained, but also seems to be a bit of a
> > > > > > different
> > > > > > issue..
> > > > > >=20
> > > > > > If the design is really to only have two passes and this
> > > > > > linked
> > > > > > list
> > > > > > is about retaining state then there should not be so much
> > > > > > freedom to
> > > > > > have more passes.
> > > > >=20
> > > > > I=E2=80=99ll let Thomas weigh in on whether we really need more t=
han
> > > > > two
> > > > > passes;
> > > > > my feeling is that two passes are likely sufficient. It=E2=80=99s
> > > > > also
> > > > > worth
> > > > > noting that the linked list has an added benefit: the
> > > > > notifier
> > > > > tree only
> > > > > needs to be walked once (a small time-complexity win).
> > > >=20
> > > > You may end up keeping the linked list just with no way to add
> > > > a
> > > > third
> > > > pass.
> > >=20
> > > It seems to me though that linked list still adds unnecessary
> > > complexity. I
> > > think this would all be much easier to follow if we just added
> > > two
> > > new callbacks
> > > - invalidate_start() and invalidate_end() say.
> >=20
> > One thing that the linked list avoids, though, is traversing the
> > interval tree two times. It has O(n*log(n)) whereas the linked list
> > overhead is just O(n_2pass).
> >=20
> > >=20
> > > Admitedly that would still require the linked list (or something
> > > similar) to
> > > retain the ability to hold/pass a context between the start and
> > > end
> > > callbacks.
> > > Which is bit annoying, it's a pity we need to allocate memory in
> > > a
> > > performance
> > > sensitive path to effectively pass (at least in this case) a
> > > single
> > > pointer. I
> > > can't think of any obvious solutions to that though.
> >=20
> > One idea is for any two-pass notifier implementation to use a small
> > pool. That would also to some extent mitigate the risk of out-of-
> > memory
> > with GFP_NOWAIT.
> >=20
>=20
> I think we can attach a preallocated list entry to the driver-side
> notifier state; then you=E2=80=99d only need to allocate (or block) if th=
at
> notifier is invoked more than once while a wait action (e.g., a TLB
> invalidation) is outstanding. Multiple invocations are technically
> possible, but in practice I=E2=80=99d expect them to be rare.
>=20
> I=E2=80=99m not sure how much of a win this is, though. On Intel hardware=
,
> TLB
> invalidations are several orders of magnitude slower than the
> software
> steps our notifiers perform. Ultimately, whether to allocate or
> preallocate is a driver-side choice.

I agree we shouldn't enforce anything at this point. But if we envision
a situation where multiple subsystem two-pass notifiers subscribe, the
GFP_NOWAIT memory might be exhausted by the notifiers called first. A
greedy behavior that might eventually cause serialization anyway.

So to behave nicely towards other notifier subscriptions, an
implementation should ideally have something pre-allocated.

/Thomas


>=20
> Matt
>=20
> > /Thomas
> >=20
> >=20
> > >=20
> > > > Jason
> > > >=20
> >=20


