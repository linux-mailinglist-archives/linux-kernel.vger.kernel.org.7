Return-Path: <linux-kernel+bounces-822303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42530B837CF
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 10:16:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C21A3B2573
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 08:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40CD02F25F7;
	Thu, 18 Sep 2025 08:15:53 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24B8D29E11E;
	Thu, 18 Sep 2025 08:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758183352; cv=none; b=ic9fUgUoOYKouB5wU2BtLtJ91/G4IZvZhkSDNPCQfKdR6TeK4cfJ1QRIv2/OMSte6SRizX6qnodeRJ9zqnDdcZTgGCFrwmEcigapToe2mHmCjpGAZ568QVWWtZAxiSI8QBq9p3X8VcGQw9D7ciovEvBGG6JSoA2dTO0HNCqm4WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758183352; c=relaxed/simple;
	bh=lSAJttjP0UeL7hTVbrBaA1PbIrkGMzcauuCWdfzEWGw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wlz0oDAqN4j6WT+jAf9g1t5VynNGWaUTU1OX23Hn+mhzDcx1bvHuTKsV+cRMH+o4ka8lq7Xh6a/C5Qdj2QFcsoww13+apb73weLXsMgvIVxJ0oJ56hwi2vonDnnPtMnKQRpuYAqGH7tfLRmexfFvnah3r64+7OXKjWIyi0XMAUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3ABA11A32;
	Thu, 18 Sep 2025 01:15:42 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 161433F673;
	Thu, 18 Sep 2025 01:15:50 -0700 (PDT)
Date: Thu, 18 Sep 2025 09:15:48 +0100
From: Leo Yan <leo.yan@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: James Clark <james.clark@linaro.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Jonathan Corbet <corbet@lwn.net>, Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, linux-doc@vger.kernel.org,
	kvmarm@lists.linux.dev
Subject: Re: [PATCH v6 00/12] perf: arm_spe: Armv8.8 SPE features
Message-ID: <20250918081548.GQ12516@e132581.arm.com>
References: <20250808-james-perf-feat_spe_eft-v6-0-6daf498578c8@linaro.org>
 <20250808123913.GD3420125@e132581.arm.com>
 <aMruzdTu74rZ0RZ9@x1>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMruzdTu74rZ0RZ9@x1>

On Wed, Sep 17, 2025 at 02:24:29PM -0300, Arnaldo Carvalho de Melo wrote:
> On Fri, Aug 08, 2025 at 01:39:13PM +0100, Leo Yan wrote:
> > On Fri, Aug 08, 2025 at 12:22:57PM +0100, James Clark wrote:
> > > Support 3 new SPE features: FEAT_SPEv1p4 filters, FEAT_SPE_EFT extended
> > > filtering, and SPE_FEAT_FDS data source filtering. The features are
> > > independent can be applied separately:
> > > 
> > >   * Prerequisite sysreg changes - patch 1
> > >   * FEAT_SPEv1p4 - patches 2 - 3
> > >   * FEAT_SPE_EFT - patch 4
> > >   * FEAT_SPE_FDS - patches 5 - 9
> > >   * FEAT_SPE_FDS Perf tool changes - patches 10 - 12
> > > 
> > > The first two features will work with old Perfs but a Perf change to
> > > parse the new config4 is required for the last feature.
> > 
> > I tested FEAT_SPE_EFT (xxx_filter_mask), inv_data_src_filter
> > and inv_event_filter, all of them work as expected.
> > 
> > Tested-by: Leo Yan <leo.yan@arm.com>
> 
> Please let me know when I can merge the tools/perf bits.

Thanks for bringing up this, Arnaldo!

Just remind, James sent the latest series is v8 [1] couple weeks ago,
and I confirmed v8 can apply clearly on the latest mainline kernel.
We need kernel maintainers' review so can move forward.

Thanks,
Leo

[1] https://lore.kernel.org/linux-arm-kernel/20250901-james-perf-feat_spe_eft-v8-0-2e2738f24559@linaro.org/

