Return-Path: <linux-kernel+bounces-819299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC442B59E35
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 18:49:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08C991C02DC7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 16:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 175E82F7AA6;
	Tue, 16 Sep 2025 16:49:00 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77F91265CC2
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 16:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758041339; cv=none; b=R67rFcwYHCL0x1657OtB20DclJmM6OJFnVhus3tQK//iVvqBhGusl6jNkaZP//UvcoDQmcGhV1y9GXco2mbonHAQnPmYY9btqHYyTxoT3zEgOkCFzPgkNoHhRKsOqok7+Zib4dBaZ5GldOdkYBcJkNKNPDtozMebQHXPmbxHkZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758041339; c=relaxed/simple;
	bh=W/fGe0SrEgLFCOuOTmOeSIs2dMnQ1z4DeLt/Qq32juY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oM95QwxPfg+MqaAxPNopMnf+HKMKXraykIZnBpHqGxVIZOUt2Q3souCxUtcCiIe9ddtf7Oig1ayyGQYNb4RJ0M6cVJuqCJ5ohHhB96zrd/KmVf+s7DV6EDS7UgXd1KiWeehASJXxmwRpRGygrYcypQNbXAMwrAJAT1fPYozuox0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5DF5B113E;
	Tue, 16 Sep 2025 09:48:48 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 331993F673;
	Tue, 16 Sep 2025 09:48:56 -0700 (PDT)
Date: Tue, 16 Sep 2025 17:48:54 +0100
From: Leo Yan <leo.yan@arm.com>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>, coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org,
	Yeoreum Yun <yeoreum.yun@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	Linu Cherian <lcherian@marvell.com>, linux-kernel@vger.kernel.org,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	James Clark <james.clark@linaro.org>
Subject: Re: [PATCH v3] coresight: Fix possible deadlock in coresight_panic_cb
Message-ID: <20250916164854.GM12516@e132581.arm.com>
References: <20250912151314.3761026-1-sean.anderson@linux.dev>
 <20250915095820.GH12516@e132581.arm.com>
 <3e618117-96bd-44f3-bede-7cadfe0264dd@linux.dev>
 <20250916160027.GK12516@e132581.arm.com>
 <a35e2d54-f1f5-4ae4-9daa-ae1f3a8a302b@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a35e2d54-f1f5-4ae4-9daa-ae1f3a8a302b@linux.dev>

On Tue, Sep 16, 2025 at 12:14:40PM -0400, Sean Anderson wrote:

[...]

> > Could you check if the drafted patch below looks good to you? If so, I
> 
> As stated above I disagree with a half-hearted removal. If you want to do that,
> then I will resend v2 done with an rcu list and you can make your own follow-up.

It is fine to disagree, but please don't resend v2 :)

We have plan to refactor locking in CoreSight driver, I will try my
best to avoid adding new lock unless with a strong reason.

Thanks,
Leo

