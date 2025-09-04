Return-Path: <linux-kernel+bounces-801022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40653B43ED0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 16:33:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 467C3A0262D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 14:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4993F30FC15;
	Thu,  4 Sep 2025 14:29:50 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 082B2307ADD
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 14:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756996189; cv=none; b=LWz+nmwHeR6fxr4/qYwF0VkmfdNY/bPC2iJbWEfmK5hii8vBpq64WqknE2WxZjkkij7gmlHkLNj4cmueQiWCqYEMz5wDbqITt39u/fW145dKzeDhaOz9DNG7IseixOgx8TJCOl3j/oF9qOqqtgn0ihrsvOWQUqhHF74I/2gQs4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756996189; c=relaxed/simple;
	bh=3BCN/NZHgi2IOo6S6L3PYTbZhbqyQnoRvjPPz3UJlL8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uql/TeyShcfszS4l0fVJijAg+bJ+j5Vo+LwNm03YtvhRwBcVToV21N8POMuc3Ge+B8an0OH2hblzZFl/SHaBzyyAsDPU2SDbIyx0S70eYgYW/vhGu7KK3xYDYJh8d85nJKf90Cu0mEdbVcjPO42bUtvEu2e7KZ/hOMq6wTFX3HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com; spf=none smtp.mailfrom=foss.arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=foss.arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ABDF81596;
	Thu,  4 Sep 2025 07:29:38 -0700 (PDT)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B5E763F63F;
	Thu,  4 Sep 2025 07:29:45 -0700 (PDT)
Date: Thu, 4 Sep 2025 15:29:42 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Paul Benoit <paul@os.amperecomputing.com>
Cc: Andre Przywara <andre.przywara@arm.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] firmware: smccc: Fix Arm SMCCC SOC_ID name call
Message-ID: <20250904-powerful-futuristic-tench-bcebd4@sudeepholla>
References: <20250902172053.304911-1-andre.przywara@arm.com>
 <20250903-great-savvy-bloodhound-38c1ca@sudeepholla>
 <20250903-loutish-orangutan-of-experience-3dcfda@sudeepholla>
 <cc8000c0-e457-4bfc-94de-aeeddacab23b@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cc8000c0-e457-4bfc-94de-aeeddacab23b@os.amperecomputing.com>

On Wed, Sep 03, 2025 at 05:38:44PM -0400, Paul Benoit wrote:
> On 9/3/2025 10:49 AM, Sudeep Holla wrote:
> > On Wed, Sep 03, 2025 at 03:23:58PM +0100, Sudeep Holla wrote:
> > > On Tue, Sep 02, 2025 at 06:20:53PM +0100, Andre Przywara wrote:
> > > > Commit 5f9c23abc477 ("firmware: smccc: Support optional Arm SMCCC SOC_ID
> > > > name") introduced the SOC_ID name string call, which reports a human
> > > > readable string describing the SoC, as returned by firmware.
> > > > The SMCCC spec v1.6 describes this feature as AArch64 only, since we rely
> > > > on 8 characters to be transmitted per register. Consequently the SMCCC
> > > > call must use the AArch64 calling convention, which requires bit 30 of
> > > > the FID to be set. The spec is a bit confusing here, since it mentions
> > > > that in the parameter description ("2: SoC name (optionally implemented for
> > > > SMC64 calls, ..."), but still prints the FID explicitly as 0x80000002.
> > > > But as this FID is using the SMC32 calling convention (correct for the
> > > > other two calls), it will not match what mainline TF-A is expecting, so
> > > > any call would return NOT_SUPPORTED.
> > > > 
> > > 
> > > Good catch and I must admit I completely missed it inspite of discussing
> > > 32b vs 64b FID around the same time this was introduced.
> > > 
> > > > Add a 64-bit version of the ARCH_SOC_ID FID macro, and use that for the
> > > > SoC name version of the call.
> > > > 
> > > > Fixes: 5f9c23abc477 ("firmware: smccc: Support optional Arm SMCCC SOC_ID name")
> > > > Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> > > > ---
> > > > Hi,
> > > > 
> > > > as somewhat expected, this now fails on an Ampere machine, which
> > > > reported a string in /sys/devices/soc0/machine before, but is now missing
> > > > this file.
> > > > Any idea what's the best way to handle this? Let the code try the 32-bit
> > > > FID, when the 64-bit one fails? Or handle this as some kind of erratum?
> > > > 
> > > 
> > > Not sure about it yet. Erratum seems good option so that we can avoid
> > > others getting it wrong too as they might just run the kernel and be happy
> > > if the machine sysfs shows up as we decided to do fallback to 32b FID.
> > > 
> > > I will start a discussion to get the spec updated and pushed out and see
> > > how that goes.
> > > 
> > > The change itself looks good and happy to get it merged once we know
> > > what is the best approach(erratum vs fallback).
> > > 
> > 
> > Looking at the SMCCC spec(DEN0028 v1.6 G Edition) ->
> > Section 7.4.6 Implementation responsibilities
> > 
> > If implemented, the firmware:
> > ...
> > • must not implement SoC_ID_type == 2 for SMC32.
> > • can optionally implement SoC_ID_type == 2 for SMC64 (Function ID 0xC000_0002),
> > ...
> > 
> > So Ampere is not spec conformant here and hence I prefer to handle it as
> > erratum. Hopefully we can use SOC_ID version and revision to keep the scope
> > of erratum confined to smallest set of platforms.
> > 
> > Paul,
> > 
> > Thoughts ?
> > 
> 
> Am I correctly understanding that, if the SMC64 SOC_ID Name call fails,
> rather than an unconditional fallback to the SMC32 call, the SMC32
> fallback would only be occurring under the proposed erratum?
>

Correct, if we have unconditional fallback to the SMC32 call, then there
is a chance that this issue gets carried into newer Ampere systems as f/w
gets copied as well as other vendors will also not notice the issue if
they make similar mistake as the kernel silent makes a SMC32 call.

We do need details of  the SoC revision and version for which we need to
apply this workaround/erratum.

> I brought this issue up at a weekly team meeting today, and I'll also be
> communicating with the Ampere Computing firmware team regarding this
> issue.

Thanks!

-- 
Regards,
Sudeep

