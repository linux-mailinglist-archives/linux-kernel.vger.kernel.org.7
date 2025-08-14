Return-Path: <linux-kernel+bounces-768517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 57469B261DF
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 12:08:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 607CB16E18E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 10:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C70D2F83AE;
	Thu, 14 Aug 2025 10:08:03 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBA0E2F60D8
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 10:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755166083; cv=none; b=A6NpTJIn1ye/gDFK7eXg4C99+SioIR9a2GAhWExQ9IBpYWoVgp5YO0r1P8n3seuQjHE1u+uDdxPvI+UNd7VqFCd/BFz0+mANk46wYBtTDymb8SheaPlHEIXLSzpBiVw+6V+j+EXE1aIDw7bypHnuoDA/gkLhWuXmRrSfsCKrdr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755166083; c=relaxed/simple;
	bh=Qf08jHx3sNdCHJcQGcZR42E91SwZm82/gUFqBR8ewsM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SRLdRUALrQudEu3RAcewCiNs6TJgOlLLRE2OCQaSdIOw0pRIX9Cid/5nW6ZQUYHTAYDJccf5QUohOUGReauq+8CgkxAuymvhyqeAKdop4U49QHjSijEuHnnR1BA5NylYphya9Ww4+sEijXvlG9v1PniQSpy5iBT5UuQFcnWwf24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BECDB1691;
	Thu, 14 Aug 2025 03:07:50 -0700 (PDT)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0A0E53F738;
	Thu, 14 Aug 2025 03:07:55 -0700 (PDT)
Date: Thu, 14 Aug 2025 11:07:53 +0100
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
Message-ID: <aJ21eZPPmQVR3Nij@bogus>
References: <20250808025533.6422-1-shijie@os.amperecomputing.com>
 <e47757c3-6091-43b5-ba28-52e11de7d86a@arm.com>
 <cb383a76-8848-44cd-6f32-fd30478d9ebd@gentwo.org>
 <2d9259e4-1b58-435d-bf02-9c4badd52fd9@arm.com>
 <20250813-gifted-nimble-wildcat-6cdf65@sudeepholla>
 <d172f30d-28ad-dd46-1385-f010107bc789@gentwo.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d172f30d-28ad-dd46-1385-f010107bc789@gentwo.org>

On Wed, Aug 13, 2025 at 08:55:36AM -0700, Christoph Lameter (Ampere) wrote:
> On Wed, 13 Aug 2025, Sudeep Holla wrote:
> 
> > > The problem is that this information is being sourced from the ACPI PPTT.
> > > The ACPI specification (AFAIK) doesn't define a cluster, so the linux
> > > cluster information is being 'invented' based on however the firmware vendor
> > > choose to group CPU nodes in the PPTT. Which means its possible for them to
> > > unknowingly create clusters, or also fail to create them when they make
> > > sense.
> >
> > +1, completely agree. As Jeremy mentioned, it is hit or miss and cluster
> > is loosely defined and IIRC Huawei pushed this based on their platform at
> > the time and it did break some benchmarks on few other platforms. So it
> > is not a good idea to make it default config IMO.
> 
> Can we figure out which platforms benchmarks were affected and why?
> 

I am not sure on either. One way to figure out the affected platforms is
to merge this change and expect the platform users/maintainers to report.

> It seems the notion of a "cluster" on ARM64 is derived (I guess a better
> word than "invented" hehe)  from sibling information instead of PPTT. But
> using that information should work fine right?
> 

I have my doubts but I may be wrong. As mentioned in the other email in this
thread, "cluster" IMO is ill-defined both in ACPI and Arm architecture which
is the root cause for all the issue around it.

-- 
Regards,
Sudeep

