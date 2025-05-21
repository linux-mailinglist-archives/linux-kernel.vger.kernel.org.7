Return-Path: <linux-kernel+bounces-657174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01259ABF07C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 May 2025 11:52:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 943653BDBBF
	for <lists+linux-kernel@lfdr.de>; Wed, 21 May 2025 09:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6509C25A2B0;
	Wed, 21 May 2025 09:52:02 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5951259C8B;
	Wed, 21 May 2025 09:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747821122; cv=none; b=KBFJ+xeF87q8uz6G8G/7V9PWj4WJPIdV7yRmtB14/N6ZdpRNYRqNVDzlD+5pVDauuhQXJD3Exahu2tNMhVWtXhHmmHbmmFzgWRDtK02ywy4K0K5H1bnoqnTEQS4vzbFKCLph96lGrdfH+pQJOzjrEu8OGRlf2VzaKNEzoT2L2no=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747821122; c=relaxed/simple;
	bh=LpXCQ/B/3LRSzVl5sAv4IFoyYafIpCfcQtXKvLccu+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qB5DvZljFGqDPrOEiv/ZfCRiMnr2J4j6mP8bVo56bX4zHME67jrqLtAIliCSNJ4llQPYk4lUO2w8076agpE3yWSLB3/QahgULuA4D+Q3VmgwW3gXcJSq1U4Ep9Rh/f22dn+MhBnUSmPosJE/b/0tIa7Q2OPcXakcN2vaN1yFDkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 364E61515;
	Wed, 21 May 2025 02:51:45 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8E2003F6A8;
	Wed, 21 May 2025 02:51:58 -0700 (PDT)
Date: Wed, 21 May 2025 10:51:54 +0100
From: Leo Yan <leo.yan@arm.com>
To: James Clark <james.clark@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Jonathan Corbet <corbet@lwn.net>, Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, linux-doc@vger.kernel.org,
	kvmarm@lists.linux.dev
Subject: Re: [PATCH 07/10] perf: arm_spe: Add support for filtering on data
 source
Message-ID: <20250521095154.GV412060@e132581.arm.com>
References: <20250506-james-perf-feat_spe_eft-v1-0-dd480e8e4851@linaro.org>
 <20250506-james-perf-feat_spe_eft-v1-7-dd480e8e4851@linaro.org>
 <20250520134632.GR412060@e132581.arm.com>
 <443141db-6950-4a15-83be-ad9e9c0e03a0@linaro.org>
 <20250520161003.GT412060@e132581.arm.com>
 <20250520162243.GU412060@e132581.arm.com>
 <5752f039-51c1-4452-b5df-03ff06da7be3@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5752f039-51c1-4452-b5df-03ff06da7be3@linaro.org>

On Wed, May 21, 2025 at 09:54:48AM +0100, James Clark wrote:
> On 20/05/2025 5:22 pm, Leo Yan wrote:

[...]

> I'm thinking I'd rather leave it consistent with PMSFCR_EL1.FT and
> automatically enable PMSFCR_EL1.FDS for any non zero data-source filter.

This is fine for me.

Just a minor thing, for the case PMSDSFR_EL1 = 0xFFFF,FFFF,FFFF,FFFF,
we might consider to clear the PMSFCR_EL1.FDS bit.  This would be a bit
performance benefit for disabling data source filter rather than
enabling the filter with unaffecting all data sources.

> This means we don't need a tool change to set some other flag when a filter
> is provided (even if it's zero) and it's much simpler. It also doesn't
> prevent the possibility of adding the enable flag in the future if someone
> comes out with a need for it, but I don't think it needs to be done now.

The question comes down to the complexity in user-space tools.

Perf initializes the attribute configs to zeros. If we want to set all
bits in config4 as a default value, we would need additional change
in the perf tool. Also initializing config4 to all ones is likely to
cause confusion if other tools want to enable the feature.

I agree that a cleaner way would be to use an enable flag + mask, we can
defer to add flag if needed.

> TBH I can't imagine a case where someone would want to filter out any samples
> that have any data source. Surely you'd only be looking for a selected set
> of data sources, or no filtering at all.

Agreed this is a rare case.

Thanks,
Leo

