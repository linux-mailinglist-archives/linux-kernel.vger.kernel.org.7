Return-Path: <linux-kernel+bounces-770765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04AA5B27EA7
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 12:48:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B158A7B6D84
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 10:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A5553002B7;
	Fri, 15 Aug 2025 10:48:33 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 909802750F2
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 10:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755254913; cv=none; b=Mqwc+/S999Ww2UL59ePFIhhn3W33iKeYwdQJyVB2BVBxrGXoJajTHBK+5qztJ+QTyYLuLJh23ZP7ok7vJZJg5ksH05enNdPv79WVli5ZbuEW/fbuvgS9Zg87IFLcwRMlofzoCZaK8HW25yT8pEhL1V8LG702B0XiB4HimyHXx2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755254913; c=relaxed/simple;
	bh=ospka4PVjRg/pgAvcMaczaoSNCIOhmeFc7wb06Pd6kw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ACdhS7FiktIE/jh/FK+BXylDPXaW5dwwTOY3GkRjXPnjK0TWirbur0wRgy5UbrPUanZHRIrin+4UkpkSjOegYfJ9tpZTK0elTxZ0k7GzQxgODoZU51RG7zzKZQ8OjW97o0k1+CC5rjN2Fahn4PYK6iYiL8+k8g/czAgo7+VT6h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com; spf=none smtp.mailfrom=foss.arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=foss.arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A65411691;
	Fri, 15 Aug 2025 03:48:22 -0700 (PDT)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9F0693F738;
	Fri, 15 Aug 2025 03:48:27 -0700 (PDT)
Date: Fri, 15 Aug 2025 11:48:24 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: "Christoph Lameter (Ampere)" <cl@gentwo.org>
Cc: Jeremy Linton <jeremy.linton@arm.com>,
	Huang Shijie <shijie@os.amperecomputing.com>,
	Sudeep Holla <sudeep.holla@arm.com>, catalin.marinas@arm.com,
	will@kernel.org, patches@amperecomputing.com,
	Shubhang@os.amperecomputing.com, krzysztof.kozlowski@linaro.org,
	bjorn.andersson@oss.qualcomm.com, geert+renesas@glider.be,
	arnd@arndb.de, nm@ti.com, ebiggers@kernel.org,
	nfraprado@collabora.com, prabhakar.mahadev-lad.rj@bp.renesas.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: defconfig: enable CONFIG_SCHED_CLUSTER
Message-ID: <20250815-pheasant-of-eternal-tact-6f9bbc@sudeepholla>
References: <20250808025533.6422-1-shijie@os.amperecomputing.com>
 <e47757c3-6091-43b5-ba28-52e11de7d86a@arm.com>
 <cb383a76-8848-44cd-6f32-fd30478d9ebd@gentwo.org>
 <2d9259e4-1b58-435d-bf02-9c4badd52fd9@arm.com>
 <20250813-gifted-nimble-wildcat-6cdf65@sudeepholla>
 <d172f30d-28ad-dd46-1385-f010107bc789@gentwo.org>
 <c45b13b9-52ae-a52b-ce39-77f7ebe09507@gentwo.org>
 <aJ20imoeRL_tifky@bogus>
 <97278200-b877-47a6-84d4-34ea9dda4e6b@gentwo.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <97278200-b877-47a6-84d4-34ea9dda4e6b@gentwo.org>

On Thu, Aug 14, 2025 at 09:30:06AM -0700, Christoph Lameter (Ampere) wrote:
> On Thu, 14 Aug 2025, Sudeep Holla wrote:
> 
> >   |  Different architectures use different terminology to denominate logically
> >   |  associated processors, but terms such as package, cluster, module, and
> >   |  socket are typical examples.
> >
> > So how can one use these across architectures ? Package/Socket is quite
> > standard. Cluster can be group of processors or it can also be group of
> > processor clusters. One of the Arm vendors call it super cluster or something.
> > All these makes it super hard for a generic OS to interpret that information.
> > Just CONFIG_SCHED_CLUSTER was added with one notion of cluster which was soon
> > realised doesn't match with some other notion of it.
> 
> What the cluster actually is used for is up to the hardware. The linux
> scheduler provides this functionality. How and when this feature is used
> by firmware is a vendor issue. There was never a clear definition.
> 

Sure, since it is left to architecture to define what it means, it could
work. But what happens if we have multiple chiplet inside a socket and
each chiplet has multiple cluster. Do you envision using this SCHED_CLUSTER
at chiplet level if that works best on the platform ?

That could work, but we need to document all these with the best of our
knowledge now so that it is easy to revisit in the future.

> > We can enable it and I am sure someone will report a regression on their
> > platform and we need to disable it again. The benchmark doesn't purely
> > depend on just the "notion" of cluster but it is often related to the
> > private resource and how they are shared in the system. So even if you
> > strictly follow the notion of cluster as supported by CONFIG_SCHED_CLUSTER
> > it will fail on systems where the private resources are shared across the
> > "cluster" boundaries or some variant configuration.
> 
> That is not our problem. If the vendor provides clustering information and
> the scheduler uses that then the vendor can modify the firmware to not
> enable clustering.
> 

That is pure wrong. ACPI is describing the hardware. Deciding to put
clustering information in these tables only if it provides performance or
not hinder performance seem complete non-sense to me. That covering policy
in ACPI hardware description. Does ACPI spec mention anything about it ?
I mean remove some hardware description even if it is 100% accurate if it
hinders performance on one of the OSPM ? Doesn't sound correct at all.

> As mentioned before: We could create a blacklist to override the ACPI info
> from the vendor to ensure that clustering is off.
> 

Not a bad idea. We can see if allow or blocklist works as we start with one.

> What we should not do is disabling clustering for all.
> 

Not completely against it but I have concerns on how all these scale with
multiple chiplets within a socket or any such variants.

> > > We could add a blacklist for those platforms to avoid regressions but we
> > > should not allow that to hinder us to enable full support for clustering
> > > on ARM64.
> > >
> >
> > Sure, but we need to improve the "cluster" definition in the ACPI and Arm
> > specification, get an agreement on what it means for other architecture
> > first IMO. We don't want to revisit the same topic again without these as
> > IIRC this is the second time we are discussion around this topic.
> 
> The vendors need flexibility to use this feature when it makes sense.
> 

Sure, but too much flexibility might also hinder future changes when adding
some other feature(chiplet again is one thing I can think of now)

> Having a clear definition would limit the use of clustering feature and
> limits innovation. Vendors can control the clustering via ACPI and the
> firmware they provide with their system.
> 

Not sure if that should be right direction TBH, but again not against the
idea of enabling the feature on some platforms if we are going to enable it
by default.

> We could change definition but that but that would be a decadelong
> process which will encounter resistance from vendors that make uses of the
> clustering feature that does not fall into the stricter definition.
> 

I understand and get the point, but decadelong is bit of an exaggeration 😉.
Not discussing these in ACPI or similar forum is not a good idea as we know
there are new h/w features that are being added and current specification
may not provide ways to express all of those.

-- 
Regards,
Sudeep

