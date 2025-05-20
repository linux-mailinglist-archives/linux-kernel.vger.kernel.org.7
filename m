Return-Path: <linux-kernel+bounces-656023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D9ADDABE09B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 May 2025 18:25:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34C90188958A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 May 2025 16:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5B3D26C3AD;
	Tue, 20 May 2025 16:22:54 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC4181DB356;
	Tue, 20 May 2025 16:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747758174; cv=none; b=YLhTj/N8BRVzFcxte+Qr4C3SifbWmTdWimwg+r55qjfD1alkf8yENQl/XFBHlxhLZyW3XSRZhanacJlVxt4BaXdkI9zx3ECkP9s8ieop6NxYT8Bpl9RGSJ6eVxqX9XJtqL2cJUJZQ4rxcIEsuD6RFpVpic2JY0tRHbPgj3OJHgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747758174; c=relaxed/simple;
	bh=TSLEjjv6+H/htSfF8goosdAaQZvhHFQIi6xN9xhIFDY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pd7jYzNZAf5DPyAkHWM5XCcKbknlhTqjb/fsxx2xBz3kCMR+01UDPq6UY8e5OicilQpsgNwbWCxBFUMCTgaiiNf9MV9N0XZLQVjmHNc8LYHfOibnlyuAsSAeJ83oe2PrNwtGBq8RYyvtyXmlof/EQv17I/xMsOZk0hT8uOQokQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 89D2E1516;
	Tue, 20 May 2025 09:22:38 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9FD9C3F5A1;
	Tue, 20 May 2025 09:22:51 -0700 (PDT)
Date: Tue, 20 May 2025 17:22:43 +0100
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
Message-ID: <20250520162243.GU412060@e132581.arm.com>
References: <20250506-james-perf-feat_spe_eft-v1-0-dd480e8e4851@linaro.org>
 <20250506-james-perf-feat_spe_eft-v1-7-dd480e8e4851@linaro.org>
 <20250520134632.GR412060@e132581.arm.com>
 <443141db-6950-4a15-83be-ad9e9c0e03a0@linaro.org>
 <20250520161003.GT412060@e132581.arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250520161003.GT412060@e132581.arm.com>

On Tue, May 20, 2025 at 05:10:03PM +0100, Leo Yan wrote:

[...]

> If 'PMSFCR_EL1.FDS == 0 and PMSDSFR_EL1 == 0x0' is the init state, as
> you said, when user passed 0xFFFF,FFFF,FFFF,FFFF for data filter, we
> cannot distinguish it from the init state, as a result, we will fail
> to handle this case.

Correct a typo. The case above, it means "when a user passes 0x0 for
data source filter ....".

Sorry for spamming.

Leo

