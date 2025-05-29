Return-Path: <linux-kernel+bounces-667161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 055A8AC812F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 May 2025 18:48:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6FBD4A6CC3
	for <lists+linux-kernel@lfdr.de>; Thu, 29 May 2025 16:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E35A622DA04;
	Thu, 29 May 2025 16:48:43 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2570D22D4EB;
	Thu, 29 May 2025 16:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748537323; cv=none; b=H4px/8ZfmTPni65fVta/DjYF0Ht2p1vEZmCsbiX3wa75qxh0Z+UhXIlLkNHEsPz1J7V/BKboutmI66d8JogX+V9391FHoz2c0GN9d4Z65USK4mX/tln7Uw6VA9Nht3//Xo0/G5UYEOxo8fw/86jSCkhKEH7DTcP9plyZRqVMrtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748537323; c=relaxed/simple;
	bh=VMJUu7GA7yCr7klV0J6AkeQHLeLdi1qD21FabNndM5w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FnqE45BtVQkLTkDNxYdqOo5G0e6fAQ1e5wKLXV6oRq8ETIkpbuUhDn1J6rB0hEDI0RjzAXldQKhKZK1O4QpxEDApykI3HPrWb9uRB2c1wwNBgRpyt4hXkYZWqi1Y9olaVr2HbaAtMAA8YlothtBLTHOj7Af6BhfK5NA+gY6gl9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BE3211764;
	Thu, 29 May 2025 09:48:24 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D3FA03F673;
	Thu, 29 May 2025 09:48:40 -0700 (PDT)
Date: Thu, 29 May 2025 17:48:39 +0100
From: Leo Yan <leo.yan@arm.com>
To: James Clark <james.clark@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
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
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, linux-doc@vger.kernel.org,
	kvmarm@lists.linux.dev
Subject: Re: [PATCH v2 00/11] perf: arm_spe: Armv8.8 SPE features
Message-ID: <20250529164839.GN2566836@e132581.arm.com>
References: <20250529-james-perf-feat_spe_eft-v2-0-a01a9baad06a@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250529-james-perf-feat_spe_eft-v2-0-a01a9baad06a@linaro.org>

On Thu, May 29, 2025 at 12:30:21PM +0100, James Clark wrote:
> Support 3 new SPE features: FEAT_SPEv1p4 filters, FEAT_SPE_EFT extended
> filtering, and SPE_FEAT_FDS data source filtering. The features are
> independent can be applied separately:
> 
>   * Prerequisite sysreg changes - patches 1 - 2
>   * FEAT_SPEv1p4 - patch 3
>   * FEAT_SPE_EFT - patch 4
>   * FEAT_SPE_FDS - patches 5 - 8
>   * FEAT_SPE_FDS Perf tool changes - patches 9 - 11
> 
> The first two features will work with old Perfs but a Perf change to
> parse the new config4 is required for the last feature.

I tested the load_filter_mask / store_filter_mask (FEAT_SPE_EFT) and
data_src_filter (SPE_FEAT_FDS), all of them work as expected.

Tested-by: Leo Yan <leo.yan@arm.com>

