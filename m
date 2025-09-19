Return-Path: <linux-kernel+bounces-824346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DCD6B88BCA
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 12:02:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 949E91C25974
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 10:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A73FE307499;
	Fri, 19 Sep 2025 09:59:43 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C465E2F9DBF;
	Fri, 19 Sep 2025 09:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758275983; cv=none; b=W2et8orZ1a7wijbzTR6HAx9otlnaGpEyPA0hVCMEcLX5niKR6wj5UOoNRhprOXP6ZBwdmO4gLGb/fqT6tjNiiDuikETTAWRgYl8kRkSU/HbYiB/rWLRHLcDH7desNLBIMrr5rgJW/QTCJOjTEQhAkOvHdY3L2kZVF3NRZfeeEOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758275983; c=relaxed/simple;
	bh=rrndocteEEVIObFqTQPqvhoyUdFbklBf9nZtdyS9ThY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sa/edMjufKi/8VS5stnvloFFTN0XcmbLBViRkUMq3p2Sh1sPsZRtmoG29XWFOKM50WMskqAdm/g/86FgvBCY/wMSJbLIPzXQtIzoaZUSBT85H32U7NtKanTlKz00FWQBb0A8oAsp83U3NiCc3UMqG4Z/6s/UctyOH3uHJPaSwCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F17571688;
	Fri, 19 Sep 2025 02:59:32 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C03E73F673;
	Fri, 19 Sep 2025 02:59:40 -0700 (PDT)
Date: Fri, 19 Sep 2025 10:59:39 +0100
From: Leo Yan <leo.yan@arm.com>
To: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Jonathan Corbet <corbet@lwn.net>, Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	James Clark <james.clark@linaro.org>, kernel-team@android.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, linux-doc@vger.kernel.org,
	kvmarm@lists.linux.dev
Subject: Re: [PATCH v8 00/12] perf: arm_spe: Armv8.8 SPE features
Message-ID: <20250919095939.GR12516@e132581.arm.com>
References: <20250901-james-perf-feat_spe_eft-v8-0-2e2738f24559@linaro.org>
 <175820142456.3469431.6863967464115578024.b4-ty@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <175820142456.3469431.6863967464115578024.b4-ty@kernel.org>

On Thu, Sep 18, 2025 at 05:43:08PM +0100, Will Deacon wrote:
> On Mon, 01 Sep 2025 13:40:29 +0100, James Clark wrote:
> > Support 3 new SPE features: FEAT_SPEv1p4 filters, FEAT_SPE_EFT extended
> > filtering, and SPE_FEAT_FDS data source filtering. The features are
> > independent can be applied separately:
> > 
> >   * Prerequisite sysreg changes - patch 1
> >   * FEAT_SPEv1p4 - patches 2 - 3
> >   * FEAT_SPE_EFT - patch 4
> >   * FEAT_SPE_FDS - patches 5 - 9
> >   * FEAT_SPE_FDS Perf tool changes - patches 10 - 12
> > 
> > [...]
> 
> I took the first 6 patches but 7 and 8 still need maintainer acks before
> I can pick up 9 as well.

Thanks Will!

Just ping Arm64 virtualization and perf maintainers if could take a look
patch 7 and 8 before the merge window.

Thanks,
Leo

