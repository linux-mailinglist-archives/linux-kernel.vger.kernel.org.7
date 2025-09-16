Return-Path: <linux-kernel+bounces-819345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 481BFB59F0E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 19:17:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5A431B28BF0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 17:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDB9C24678F;
	Tue, 16 Sep 2025 17:17:07 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C19E722D7B0
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 17:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758043027; cv=none; b=CmcjWXbWH5zZB868aoHD3Dkui+KR+OcLgdKFSgu28B0E/dGs6qR44s9R4l9Q7CdUy1Vc3iTd1zQHVAhonTbX1NDqrHXMEPS5X5n/HRrT0Ix0wa49yRsFXsH0p96TIS9O8U7UEUBn6kHl8kjtnbLNVpJ88EiFxC/Rntxee5fGgnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758043027; c=relaxed/simple;
	bh=S20ekEiB9KmNO+02R+hvGf+d6QJg236616by3vTcnb4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qALz6/Tuku/skzHiRPpDp40eGYygPt1ZxIeW5M/LpRKw/Mvxq1y2LrXcXsY9SBNAaX+iqINgVIxygZ6mVwcGia5Ng9S9gcxLd6KjznnU8gWmjKQS/iScU/QPKumFEH6xn9RvDUduX3ByYpCEmSLa1k6kKOvwdUlRlSpEv2uY4jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BB22D12FC;
	Tue, 16 Sep 2025 10:16:56 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 91D553F694;
	Tue, 16 Sep 2025 10:17:04 -0700 (PDT)
Date: Tue, 16 Sep 2025 18:17:02 +0100
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
Message-ID: <20250916171702.GO12516@e132581.arm.com>
References: <20250912151314.3761026-1-sean.anderson@linux.dev>
 <20250915095820.GH12516@e132581.arm.com>
 <3e618117-96bd-44f3-bede-7cadfe0264dd@linux.dev>
 <20250916160027.GK12516@e132581.arm.com>
 <a35e2d54-f1f5-4ae4-9daa-ae1f3a8a302b@linux.dev>
 <20250916164854.GM12516@e132581.arm.com>
 <42f1c98c-1432-47bb-9203-e878f011ff6e@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42f1c98c-1432-47bb-9203-e878f011ff6e@linux.dev>

On Tue, Sep 16, 2025 at 12:51:11PM -0400, Sean Anderson wrote:
> On 9/16/25 12:48, Leo Yan wrote:
> > On Tue, Sep 16, 2025 at 12:14:40PM -0400, Sean Anderson wrote:
> > 
> > [...]
> > 
> >> > Could you check if the drafted patch below looks good to you? If so, I
> >> 
> >> As stated above I disagree with a half-hearted removal. If you want to do that,
> >> then I will resend v2 done with an rcu list and you can make your own follow-up.
> > 
> > It is fine to disagree, but please don't resend v2 :)
> > 
> > We have plan to refactor locking in CoreSight driver, I will try my
> > best to avoid adding new lock unless with a strong reason.
> 
> As said above it will be done with an rcu list, so no new lock.
> 
> Or I can do this patch but stick the notifier block in csdev as suggested by Suzuki.

I am fine for adding the notifier block in csdev.

Suzuki, could you confirm if this is the right way to move forward?

Thanks,
Leo

