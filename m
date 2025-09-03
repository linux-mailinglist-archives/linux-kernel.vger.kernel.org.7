Return-Path: <linux-kernel+bounces-798825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 31B7DB4237D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 16:24:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4EFD1A88058
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 14:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5782D30AAB8;
	Wed,  3 Sep 2025 14:24:05 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1FFA1E4AE
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 14:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756909445; cv=none; b=GkkPcb221grLhoXw2/jmqT5eV5PTymMbT1Q+pV5bbeafVK8Xhd2PBwxWuKRNJcmLEnT3SWkWk0QrwmXITyWAFn2RGkwt1s4sengz3Yt33TdxPeklGBXxKDOwpyArZWePsFZ+zV8muqfL2oB30OW2d8ofJIkDPB8+rwLklMebrOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756909445; c=relaxed/simple;
	bh=WdEveljDIG6lr/JSLrBZ9A3acJaY8Dnr/O7LfSt7M5c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KxrgwJfUf9Xmawa9tSpxJ8SQl2oAWKtl87beVrrfP8Zac0TfopFaY+gbbGJO3PoFu8q9tV2MZruuI1i8sQUYJ9cG4f8T/9tueQXlmtds0Dp2uP7FflOmxfgimx1Do8YBxzNZ+1NXy2j4AWMyZ3t7wnhf4DkHpqOOurLA9zl994w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com; spf=none smtp.mailfrom=foss.arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=foss.arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2FF9E1688;
	Wed,  3 Sep 2025 07:23:54 -0700 (PDT)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 399023F6A8;
	Wed,  3 Sep 2025 07:24:01 -0700 (PDT)
Date: Wed, 3 Sep 2025 15:23:58 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Andre Przywara <andre.przywara@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Paul Benoit <paul@os.amperecomputing.com>,
	<linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] firmware: smccc: Fix Arm SMCCC SOC_ID name call
Message-ID: <20250903-great-savvy-bloodhound-38c1ca@sudeepholla>
References: <20250902172053.304911-1-andre.przywara@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250902172053.304911-1-andre.przywara@arm.com>

On Tue, Sep 02, 2025 at 06:20:53PM +0100, Andre Przywara wrote:
> Commit 5f9c23abc477 ("firmware: smccc: Support optional Arm SMCCC SOC_ID
> name") introduced the SOC_ID name string call, which reports a human
> readable string describing the SoC, as returned by firmware.
> The SMCCC spec v1.6 describes this feature as AArch64 only, since we rely
> on 8 characters to be transmitted per register. Consequently the SMCCC
> call must use the AArch64 calling convention, which requires bit 30 of
> the FID to be set. The spec is a bit confusing here, since it mentions
> that in the parameter description ("2: SoC name (optionally implemented for
> SMC64 calls, ..."), but still prints the FID explicitly as 0x80000002.
> But as this FID is using the SMC32 calling convention (correct for the
> other two calls), it will not match what mainline TF-A is expecting, so
> any call would return NOT_SUPPORTED.
> 

Good catch and I must admit I completely missed it inspite of discussing
32b vs 64b FID around the same time this was introduced.

> Add a 64-bit version of the ARCH_SOC_ID FID macro, and use that for the
> SoC name version of the call.
> 
> Fixes: 5f9c23abc477 ("firmware: smccc: Support optional Arm SMCCC SOC_ID name")
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
> Hi,
> 
> as somewhat expected, this now fails on an Ampere machine, which
> reported a string in /sys/devices/soc0/machine before, but is now missing
> this file.
> Any idea what's the best way to handle this? Let the code try the 32-bit
> FID, when the 64-bit one fails? Or handle this as some kind of erratum?
> 

Not sure about it yet. Erratum seems good option so that we can avoid
others getting it wrong too as they might just run the kernel and be happy
if the machine sysfs shows up as we decided to do fallback to 32b FID.

I will start a discussion to get the spec updated and pushed out and see
how that goes.

The change itself looks good and happy to get it merged once we know
what is the best approach(erratum vs fallback).

-- 
Regards,
Sudeep

