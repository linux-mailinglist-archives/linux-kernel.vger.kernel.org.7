Return-Path: <linux-kernel+bounces-858185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ADA6BE93AD
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 16:37:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 662FA504268
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 14:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05CD632E140;
	Fri, 17 Oct 2025 14:36:23 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D1F932C92F
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 14:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760711782; cv=none; b=gnBbdS1G4gmIibN+E3GzFlxhnK3+tPPMvHkwv9l0miwEnrPHaAIRl08zYez3rhuarMkF10pa56PjTQc2Y+OKvkPy/zWW5qA0CnFkHJ5CY+WDu3G0JEr3UyA6PbJok0F5B8kMBu9pt5hkAezJFGUPTfMrI8JRPx51HP/f9VdTQbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760711782; c=relaxed/simple;
	bh=aogwpZ64pvO5nEiWiw9puljCAZrx4LmdzP5QuzJuC6M=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=grrqWM7fyqt4l9QIhjxtQfCQH2hcpF/zOdTQ08+sffMaGkxYlP2qstk/P3nyPg93AcdOkEDEex630aucNp9chW8NAiWN4P9b5WYeO4E/goqmFSt0YRs9t2X1CLkbGybh3Lwdz6Ej7JqHFofaw6jTdH6MmrxTTTXCiLEfaXUZsgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cp6kQ1HMKz6L5Dj;
	Fri, 17 Oct 2025 22:33:18 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id A2C5B1402FF;
	Fri, 17 Oct 2025 22:36:16 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 17 Oct
 2025 15:36:15 +0100
Date: Fri, 17 Oct 2025 15:36:13 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Gregory Price <gourry@gourry.net>
CC: Yiannis Nikolakopoulos <yiannis.nikolakop@gmail.com>, Wei Xu
	<weixugc@google.com>, David Rientjes <rientjes@google.com>, Matthew Wilcox
	<willy@infradead.org>, Bharata B Rao <bharata@amd.com>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
	<dave.hansen@intel.com>, <hannes@cmpxchg.org>, <mgorman@techsingularity.net>,
	<mingo@redhat.com>, <peterz@infradead.org>, <raghavendra.kt@amd.com>,
	<riel@surriel.com>, <sj@kernel.org>, <ying.huang@linux.alibaba.com>,
	<ziy@nvidia.com>, <dave@stgolabs.net>, <nifan.cxl@gmail.com>,
	<xuezhengchu@huawei.com>, <akpm@linux-foundation.org>, <david@redhat.com>,
	<byungchul@sk.com>, <kinseyho@google.com>, <joshua.hahnjy@gmail.com>,
	<yuanchu@google.com>, <balbirs@nvidia.com>, <alok.rathore@samsung.com>,
	<yiannis@zptcorp.com>, "Adam Manzanares" <a.manzanares@samsung.com>
Subject: Re: [RFC PATCH v2 0/8] mm: Hot page tracking and promotion
 infrastructure
Message-ID: <20251017153613.00004940@huawei.com>
In-Reply-To: <aPJPnZ01Gzi533v4@gourry-fedora-PF4VCD3F>
References: <20250917174941.000061d3@huawei.com>
	<5A7E0646-0324-4463-8D93-A1105C715EB3@gmail.com>
	<20250925160058.00002645@huawei.com>
	<aNVbC2o8WlYKjEfL@gourry-fedora-PF4VCD3F>
	<20250925162426.00007474@huawei.com>
	<aNVohF0sPNZSuTgI@gourry-fedora-PF4VCD3F>
	<20250925182308.00001be4@huawei.com>
	<aNWRuKGurAntxhxG@gourry-fedora-PF4VCD3F>
	<aNzWwz5OYLOjwjLv@gourry-fedora-PF4VCD3F>
	<CAOi6=wTsY=EWt=yQ_7QJONsJpTM_3HKp0c42FKaJ8iJ2q8-n+w@mail.gmail.com>
	<aPJPnZ01Gzi533v4@gourry-fedora-PF4VCD3F>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml100011.china.huawei.com (7.191.174.247) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Fri, 17 Oct 2025 10:15:57 -0400
Gregory Price <gourry@gourry.net> wrote:

> On Fri, Oct 17, 2025 at 11:53:31AM +0200, Yiannis Nikolakopoulos wrote:
> > On Wed, Oct 1, 2025 at 9:22=E2=80=AFAM Gregory Price <gourry@gourry.net=
> wrote: =20
> > > 1. Carve out an explicit proximity domain (NUMA node) for the compres=
sed
> > >    region via SRAT.
> > >    https://docs.kernel.org/driver-api/cxl/platform/acpi/srat.html
> > >
> > > 2. Make sure this proximity domain (NUMA node) has separate data in t=
he
> > >    HMAT so it can be an explicit demotion target for higher tiers
> > >    https://docs.kernel.org/driver-api/cxl/platform/acpi/hmat.html =20
> > This makes sense. I've done a dirty hardcoding trick in my prototype
> > so that my node is always the last target. I'll have a look on how to
> > make this right. =20
>=20
> I think it's probably a CEDT/CDAT/HMAT/SRAT/etc negotiation.
>=20
> Essentially the platform needs to allow a single device to expose
> multiple numa nodes based on different expected performance.  From
> those ranges.  Then software needs to program the HDM decoders
> appropriately.

It's a bit 'fuzzy' to justify but maybe (for CXL) a CFWMS flag (so CEDT
as you mention) to say this host memory region may be backed by
compressed memory?

Might be able to justify it from spec point of view by arguing that
compression is a QoS related characteristic. Always possible host
hardware will want to handle it differently before it even hits the
bus even if it's just a case throttling writing differently.

That then ends up in it's own NUMA node.  Whether we take on the
splitting CFMWS entries into multiple NUMA nodes depending on what
backing devices end up in them is something we kicked into the long
grass originally, but that can definitely be revisited.  That
doesn't matter for initial support of compressed memory though if
we can do it via a seperate CXL Fixed Memory Window Structure (CFMWS)
in CEDT.

>=20
> > > 5. in `alloc_migration_target()` mm/migrate.c
> > >    Since nid is not a valid buddy-allocator target, everything here
> > >    will fail.  So we can simply append the following to the bottom
> > >
> > >    device_folio_alloc =3D nid_to_alloc(nid, DEVICE_FOLIO_ALLOC);
> > >    if (device_folio_alloc)
> > >        folio =3D device_folio_alloc(...)
> > >    return folio; =20
> > In my current prototype alloc_migration_target was working (naively).
> > Steps 3, 4 and 5 seem like an interesting thing to try after all this
> > discussion. =20
> > > =20
>=20
> Right because the memory is directly accessible to the buddy allocator.
> What i'm proposing would remove this memory from the buddy allocator and
> force more explicit integration (in this case with this function).
>=20
> more explicitly: in this design __folio_alloc can never access this
>                  memory.
>=20
> ~Gregory


