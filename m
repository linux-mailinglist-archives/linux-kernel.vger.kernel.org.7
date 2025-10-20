Return-Path: <linux-kernel+bounces-861073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B7DBCBF1BA2
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 16:07:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C80134F5821
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 14:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F062D2FB619;
	Mon, 20 Oct 2025 14:05:44 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 424C61BCA1C
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 14:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760969144; cv=none; b=CGmdMXbvyYnloJKADP8MVm0XiWVXKGV2A2UM4lDL7xAyIFfL4TfrXuUiUyqDA/bpi0TLZMIo5RwpZ571fztmYGbW8jjpYtmgkz3QCvw9v2i4qmVxRw2m3uagqe0kZAn+c3jD4r/RlOytR7O+PmoSndyzxeUvU98uay8LuWZEpZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760969144; c=relaxed/simple;
	bh=RpoNb0pgX3O7cPBwegEGEMrpnRO3n1ClmHup9YXQbz8=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nXs2Qzvea6c2Snmeyt/tWQknzYJKNYM3iEhOhfQOMgBWmVJrAx1LOS+vVOqmqh3vFR9LiEKnqXree+JU841ct1YkrRrnU/vJbuj2Aun8CvMOvFpAPxfXDWREdAsN01koWjPgCF+0b67NY2shd6GgHoRdVOkb2fLAa5wAN6bhRt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cqxvN3hyYz6L4t4;
	Mon, 20 Oct 2025 22:02:24 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 99F0E1402FC;
	Mon, 20 Oct 2025 22:05:31 +0800 (CST)
Received: from localhost (10.48.157.75) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 20 Oct
 2025 15:05:29 +0100
Date: Mon, 20 Oct 2025 15:05:26 +0100
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
Message-ID: <20251020150526.000078b6@huawei.com>
In-Reply-To: <aPJZtQS4wJ1fkJq-@gourry-fedora-PF4VCD3F>
References: <20250925160058.00002645@huawei.com>
	<aNVbC2o8WlYKjEfL@gourry-fedora-PF4VCD3F>
	<20250925162426.00007474@huawei.com>
	<aNVohF0sPNZSuTgI@gourry-fedora-PF4VCD3F>
	<20250925182308.00001be4@huawei.com>
	<aNWRuKGurAntxhxG@gourry-fedora-PF4VCD3F>
	<aNzWwz5OYLOjwjLv@gourry-fedora-PF4VCD3F>
	<CAOi6=wTsY=EWt=yQ_7QJONsJpTM_3HKp0c42FKaJ8iJ2q8-n+w@mail.gmail.com>
	<aPJPnZ01Gzi533v4@gourry-fedora-PF4VCD3F>
	<20251017153613.00004940@huawei.com>
	<aPJZtQS4wJ1fkJq-@gourry-fedora-PF4VCD3F>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500011.china.huawei.com (7.191.174.215) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Fri, 17 Oct 2025 10:59:01 -0400
Gregory Price <gourry@gourry.net> wrote:

> On Fri, Oct 17, 2025 at 03:36:13PM +0100, Jonathan Cameron wrote:
> > On Fri, 17 Oct 2025 10:15:57 -0400
> > Gregory Price <gourry@gourry.net> wrote:  
> > > 
> > > Essentially the platform needs to allow a single device to expose
> > > multiple numa nodes based on different expected performance.  From
> > > those ranges.  Then software needs to program the HDM decoders
> > > appropriately.  
> > 
> > It's a bit 'fuzzy' to justify but maybe (for CXL) a CFWMS flag (so CEDT
> > as you mention) to say this host memory region may be backed by
> > compressed memory?
> >
> > Might be able to justify it from spec point of view by arguing that
> > compression is a QoS related characteristic. Always possible host
> > hardware will want to handle it differently before it even hits the
> > bus even if it's just a case throttling writing differently.
> >  
> 
> That's a Consortium discussion to have (and I am not of the
> consortium :P), but yeah you could do it that way.

The moment I know it's raised there I (and others involved in consortium)
can't talk about it in public. (I love standards org IP rules!)
So it's useful to have a pre discussion before that happens.  We've
done this before for other topics and it can be very productive.

> 
> More generally could have a "Not-for-general-consumption bit" instead
> of specifically a compressed bit.  Maybe both a "No-Consume" and a
> "Special Node" bit would be useful separately.
> 
> Of course then platforms need to be made to understand all these:
> 
> "No-Consume" -> force EFI_MEMORY_SP or leave it reserved
> "Special Node" -> allocate its own PXM / Provide discrete CFMWS
> 
> Naming obviously non-instructive here, may as well call them Nancy and
> Bob bits.

For compression specifically I think there is value in making it
explicitly compression because the host hardware might handle that
differently. The other bits might be worth having as well
though. SPM was all about 'you could' use it as normal memory but
someone put it there for something else. This more a case of
SPOM. Specific Purpose Only Memory - eats babies if you don't know
the extra rules for each instance of that.

> 
> > That then ends up in it's own NUMA node.  Whether we take on the
> > splitting CFMWS entries into multiple NUMA nodes depending on what
> > backing devices end up in them is something we kicked into the long
> > grass originally, but that can definitely be revisited.  That
> > doesn't matter for initial support of compressed memory though if
> > we can do it via a seperate CXL Fixed Memory Window Structure (CFMWS)
> > in CEDT.
> >  
> 
> This is the way I would initially approach it tbh - but i'm also not a
> hardware/firmware person, so i don't know exactly what bits a device
> would set to tell BIOS/EFI "Hey, give this chunk its own CFMWS", or if
> that lies solely with BIOS/EFI.

It's not a device thing wrt to nodes today (and there are good reasons
why it should not be at that granularity e.g. node explosion has costs).
The BIOS might pre setup the decoders and even lock them, but I'd expect
we'll move away from that to fully OS managed over time (to get flexibility)
- exception to that being when confidential compute is making its
usual mess of things.

Maybe the BIOS would have a look at devices and decide to enable a
compressed memory CFMWS if it finds devices that need it and not do
so otherwise, though not doing so breaks hotplug of compressed memory devices.

So my guess is either we need to fix Linux to allow splitting a fixed
memory window up into multiple NUMA nodes, or platforms have to spin
extra fixed memory windows (host side PA ranges with a NUMA node for each).

Which option depends a bit on whether we expect host hardware to either
handle compressed differently from normal ram, or at least separate it
for QoS reasons.

What fun.

J
> 
> ~Gregory


