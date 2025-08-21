Return-Path: <linux-kernel+bounces-779710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 588C8B2F797
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 14:12:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBFDEAA1F35
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 12:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 311D6310652;
	Thu, 21 Aug 2025 12:11:55 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E010304BD5
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 12:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755778314; cv=none; b=OOub90a9cW6g6/tXqJQqIKKRKE6X+/9P4aPZnY5WtaiVBfoqkfh6bqFUQwyn/T1RGZmuISGIHOjXZQHFnqIoJ9/WBVVpVVSTbKAZKLE8YQ1Va9dlZclHtbT4qkT9wqC3nF98cmSahbejKUgK5XARL6RKKkIiwHoF426BOfKG9iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755778314; c=relaxed/simple;
	bh=/y4tdwvpUtv6uHtKE1IoK3I8Na/TpVBHfbqLyE9KWb0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JbX7+f4E5lG8qDUB72AX+snLEqBmiWjx4loQm2ODAHNQWUi2lZIB/eI08Y+LyyoK5FPiuk2lYh2WPII6aSN/k+sH9c+HPVJ/tPRqXvazIAMLXH8UXhaVE10jCzQJMmorKEQD6woqsfKPyFCt1fzOYBF9V3XuvuJwMne+WlhNXH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com; spf=none smtp.mailfrom=foss.arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=foss.arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 31820152B;
	Thu, 21 Aug 2025 05:11:44 -0700 (PDT)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7C4E53F63F;
	Thu, 21 Aug 2025 05:11:49 -0700 (PDT)
Date: Thu, 21 Aug 2025 13:11:46 +0100
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
Message-ID: <20250821-sloppy-urchin-of-fantasy-ecc4ce@sudeepholla>
References: <2d9259e4-1b58-435d-bf02-9c4badd52fd9@arm.com>
 <20250813-gifted-nimble-wildcat-6cdf65@sudeepholla>
 <d172f30d-28ad-dd46-1385-f010107bc789@gentwo.org>
 <c45b13b9-52ae-a52b-ce39-77f7ebe09507@gentwo.org>
 <aJ20imoeRL_tifky@bogus>
 <97278200-b877-47a6-84d4-34ea9dda4e6b@gentwo.org>
 <20250815-pheasant-of-eternal-tact-6f9bbc@sudeepholla>
 <1097a1d1-483d-44b3-b473-4350b5a4b04d@arm.com>
 <20250818-mysterious-aromatic-wasp-cdbaae@sudeepholla>
 <1e3ae52a-0aea-3146-429b-6a0035181b26@gentwo.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1e3ae52a-0aea-3146-429b-6a0035181b26@gentwo.org>

On Wed, Aug 20, 2025 at 04:44:29PM -0700, Christoph Lameter (Ampere) wrote:
> On Mon, 18 Aug 2025, Sudeep Holla wrote:
> 
> > > But returning to the original point, its not clear to me that the HW
> > > 'cluster' information is really causing the performance boost vs, just
> > > having a medium size scheduling domain (aka just picking an arbitrary size
> > > 4-16 cores) under MC, or simply 'slicing' a L3 in the PPTT such that the MC
> > > domains are smaller, yields the same effect. I've seen a number of cases
> > > where 'lying' about the topology yields a better result in a benchmark. This
> > > is largely what is happening with these Firmware toggles that move/remove
> > > the NUMA domains too. Being able to manually reconfigure some of these
> > > scheduling levels at runtime might be useful...
> > >
> >
> > I share your concern and hence completely again representation of any fake
> > data in the ACPI topology just to get improved performance. Yes we have seen
> > that in the past.
> 
> Depends on what you call fake. There are microarchitectural issues
> regarding the proximity of the processors that the customer may not know
> about and therefore the data provides by the vendor may be considered
> "fake". Certainly that is not the case for our processors.
> 

Fair enough. We have seen systems with fake data as those data seem to
accidentally improve performance.

> This is a common feature and widely available on other platforms.
> There is no need to do anything but enable the functionality. Having a
> special version of ACPI for arm64 or a special handling for arm64 does not
> make sense.
> 

I am not suggesting to make it any special on Arm64, we would never want
that unless absolutely needed and this is not one such thing.

> The ACPI subsystem provides the ability to add blacklists. If a vendor has
> problems with their firmward providing data that reduces the performance
> and is unable to fix it othereise then the vendor can use that feature to
> disable these ACPI features for their platform by submitting a patch.
> 

I don't have a strong opinion on that approach. IIUC, maintaining list
needs change in the kernel which Jeremy mentioned is not what distro
prefer over command line parameter. We can always have a parameter to
disable the feature and keep the build config enabled as in this patch.
So only platforms that have performance issue by enabling this will have
to add the command line parameter(hopefully that works for all)

> Please make arm64 work like the other Linux platforms and do not introduce
> special handling for ARM64.

Again I am not suggesting that and we never want that.

-- 
Regards,
Sudeep

