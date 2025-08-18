Return-Path: <linux-kernel+bounces-773306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 087B3B29E19
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 11:36:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70A681965BC4
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 09:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5520830E0D1;
	Mon, 18 Aug 2025 09:33:54 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A88230E82A
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 09:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755509633; cv=none; b=GtdE6h8u4QVKeFKKKh+BjH0wTnTOzrx6Q0dyCmDmvH0RyQ9H/mX+/GmBRXASrTbdydj9jKt/0tZbrTL4usjLrx4lUZWtYxC0MK6PWcLdgaCIXevSoS+hqn3wYkPnaxi7goynH3ybU9Olsv+9Zf0E/keLyJCRWzs81ymh31M7lwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755509633; c=relaxed/simple;
	bh=zgksYGCzndIYmqGNAPpkvT4sytdz2PUXcHcseyxBong=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QEGxvuxecN/lx6qD3iLxWK11ARLIRj8DnkoLw6wmWfzCCGymlA/pAewfbPYZue6PKwIuRxO++vp3G6Gb4uHszVuHxxZBHNPEn/VfH7LTXSqy+U+KM5O3VZ5gyec6W4h6Ay+kPOlj/epbrMyQup9Nkn2GwrptUs5alkxirjvNkyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com; spf=none smtp.mailfrom=foss.arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=foss.arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 868F01595;
	Mon, 18 Aug 2025 02:33:43 -0700 (PDT)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CC6923F58B;
	Mon, 18 Aug 2025 02:33:48 -0700 (PDT)
Date: Mon, 18 Aug 2025 10:33:45 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Jeremy Linton <jeremy.linton@arm.com>
Cc: "Christoph Lameter (Ampere)" <cl@gentwo.org>,
	Huang Shijie <shijie@os.amperecomputing.com>,
	Sudeep Holla <sudeep.holla@arm.com>, <catalin.marinas@arm.com>,
	<will@kernel.org>, <patches@amperecomputing.com>,
	<Shubhang@os.amperecomputing.com>, <krzysztof.kozlowski@linaro.org>,
	<bjorn.andersson@oss.qualcomm.com>, <geert+renesas@glider.be>,
	<arnd@arndb.de>, <nm@ti.com>, <ebiggers@kernel.org>,
	<nfraprado@collabora.com>,
	<prabhakar.mahadev-lad.rj@bp.renesas.com>,
	<linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: defconfig: enable CONFIG_SCHED_CLUSTER
Message-ID: <20250818-mysterious-aromatic-wasp-cdbaae@sudeepholla>
References: <e47757c3-6091-43b5-ba28-52e11de7d86a@arm.com>
 <cb383a76-8848-44cd-6f32-fd30478d9ebd@gentwo.org>
 <2d9259e4-1b58-435d-bf02-9c4badd52fd9@arm.com>
 <20250813-gifted-nimble-wildcat-6cdf65@sudeepholla>
 <d172f30d-28ad-dd46-1385-f010107bc789@gentwo.org>
 <c45b13b9-52ae-a52b-ce39-77f7ebe09507@gentwo.org>
 <aJ20imoeRL_tifky@bogus>
 <97278200-b877-47a6-84d4-34ea9dda4e6b@gentwo.org>
 <20250815-pheasant-of-eternal-tact-6f9bbc@sudeepholla>
 <1097a1d1-483d-44b3-b473-4350b5a4b04d@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1097a1d1-483d-44b3-b473-4350b5a4b04d@arm.com>

On Fri, Aug 15, 2025 at 11:46:35AM -0500, Jeremy Linton wrote:
> Hi,
> 
> 
> On 8/15/25 5:48 AM, Sudeep Holla wrote:
> > On Thu, Aug 14, 2025 at 09:30:06AM -0700, Christoph Lameter (Ampere) wrote:
> > > On Thu, 14 Aug 2025, Sudeep Holla wrote:
> > > 
> > > >    |  Different architectures use different terminology to denominate logically
> > > >    |  associated processors, but terms such as package, cluster, module, and
> > > >    |  socket are typical examples.
> > > > 
> > > > So how can one use these across architectures ? Package/Socket is quite
> > > > standard. Cluster can be group of processors or it can also be group of
> > > > processor clusters. One of the Arm vendors call it super cluster or something.
> > > > All these makes it super hard for a generic OS to interpret that information.
> > > > Just CONFIG_SCHED_CLUSTER was added with one notion of cluster which was soon
> > > > realised doesn't match with some other notion of it.
> > > 
> > > What the cluster actually is used for is up to the hardware. The linux
> > > scheduler provides this functionality. How and when this feature is used
> > > by firmware is a vendor issue. There was never a clear definition.
> > > 
> > 
> > Sure, since it is left to architecture to define what it means, it could
> > work. But what happens if we have multiple chiplet inside a socket and
> > each chiplet has multiple cluster. Do you envision using this SCHED_CLUSTER
> > at chiplet level if that works best on the platform ?
> > 
> > That could work, but we need to document all these with the best of our
> > knowledge now so that it is easy to revisit in the future.
> > 
> > > > We can enable it and I am sure someone will report a regression on their
> > > > platform and we need to disable it again. The benchmark doesn't purely
> > > > depend on just the "notion" of cluster but it is often related to the
> > > > private resource and how they are shared in the system. So even if you
> > > > strictly follow the notion of cluster as supported by CONFIG_SCHED_CLUSTER
> > > > it will fail on systems where the private resources are shared across the
> > > > "cluster" boundaries or some variant configuration.
> > > 
> > > That is not our problem. If the vendor provides clustering information and
> > > the scheduler uses that then the vendor can modify the firmware to not
> > > enable clustering.
> > > 
> > 
> > That is pure wrong. ACPI is describing the hardware. Deciding to put
> > clustering information in these tables only if it provides performance or
> > not hinder performance seem complete non-sense to me. That covering policy
> > in ACPI hardware description. Does ACPI spec mention anything about it ?
> > I mean remove some hardware description even if it is 100% accurate if it
> > hinders performance on one of the OSPM ? Doesn't sound correct at all.
> > 
> > > As mentioned before: We could create a blacklist to override the ACPI info
> > > from the vendor to ensure that clustering is off.
> > > 
> > 
> > Not a bad idea. We can see if allow or blocklist works as we start with one.
> 
> From a distro perspective it makes more sense to me to change it from a
> compile time option to a runtime kernel command line option with the default
> on/off set by this SCHED_CLUSTER flag rather than try to maintain a
> blocklist.
>

Right, that makes complete sense to me.

> 
> I agree the firmware needs a much clearer way to signal that these nodes
> represent something other than just side effects of the way the table is
> built. If the working group is hesitant to declare additional topological
> flags, maybe this idea of deriving additional topological information from
> nodes without caches is a reasonable spec clarification. That way some
> future NODE_IS_A_CLUSTER/DSU/CHIPLET/SUPERCLUSTER/RING/SLICE/WHATEVER
> doesn't turn the existing code into technical debt.
> 

100% agreed.

> But returning to the original point, its not clear to me that the HW
> 'cluster' information is really causing the performance boost vs, just
> having a medium size scheduling domain (aka just picking an arbitrary size
> 4-16 cores) under MC, or simply 'slicing' a L3 in the PPTT such that the MC
> domains are smaller, yields the same effect. I've seen a number of cases
> where 'lying' about the topology yields a better result in a benchmark. This
> is largely what is happening with these Firmware toggles that move/remove
> the NUMA domains too. Being able to manually reconfigure some of these
> scheduling levels at runtime might be useful...
> 

I share your concern and hence completely again representation of any fake
data in the ACPI topology just to get improved performance. Yes we have seen
that in the past.

-- 
Regards,
Sudeep

