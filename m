Return-Path: <linux-kernel+bounces-838968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AFBBBB08A6
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 15:39:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0EA04A6B01
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 13:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CBAF2EFD81;
	Wed,  1 Oct 2025 13:39:21 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 839A02EE5F5;
	Wed,  1 Oct 2025 13:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759325961; cv=none; b=pntxCStKuCirhT+mqJHSWorUlBsULa+pSdK7LzSrMCVpA/VXl8EAA25V+ncD6DKFTBNUF+MpDcandZ4nC948Ow3JOLg2Zso9qQMmC27rV5uzMXMSCMOjylwSavGuNHQKMkla1rZCryczpPJZwie/jjjbLE35HfR23BLHkCdjQ8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759325961; c=relaxed/simple;
	bh=UtXb5OiK4CU4HHYjuDw7cW8cwma1Sgv5RlEAG4NZbEw=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gbq42ctGb9zUCYaUmsmER3i+YI1oVIGCWi5Fbfe/OpzzHwbiFkmo2lZCcqLpUnKd1eSeoR2uO6RkVA7wuLdPDZCNOAE3J5UkR+NjnK2OW8ZZSriMIHufQiVUNuAMDbI4aDQW7BTE5Iqtjg0oyG6Hn/hE6I1NuETmmludX3hR5wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 443B216F2;
	Wed,  1 Oct 2025 06:39:05 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E624E3F59E;
	Wed,  1 Oct 2025 06:39:12 -0700 (PDT)
Date: Wed, 1 Oct 2025 14:39:10 +0100
From: Leo Yan <leo.yan@arm.com>
To: James Clark <james.clark@linaro.org>,
	Mike Leach <mike.leach@linaro.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jonathan Corbet <corbet@lwn.net>, coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 5/6] coresight: Add format attribute for setting the
 timestamp interval
Message-ID: <20251001133910.GO7985@e132581.arm.com>
References: <20250814-james-cs-syncfreq-v2-0-c76fcb87696d@linaro.org>
 <20250814-james-cs-syncfreq-v2-5-c76fcb87696d@linaro.org>
 <20250930151414.GK7985@e132581.arm.com>
 <3a731a9e-0621-42b6-b7fc-4b0fd9b7da6e@linaro.org>
 <20251001132815.GN7985@e132581.arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251001132815.GN7985@e132581.arm.com>

On Wed, Oct 01, 2025 at 02:28:15PM +0100, Coresight ML wrote:

[...]

> > Unfortunately that won't work because you'd have to always include
> > coresight-etm4x.h. This file is compiled for both arm32 and arm64 so it
> > would break the arm32 build.
> > 
> > I could define the TTR_CFG_FLD_ts_level_* stuff somewhere else but then it
> > becomes messier than just doing the #ifdefs here.
> 
> ATTR_CFG_FLD_ts_level_* is only used in coresight-etm4x-core.c, it is not
> used in coresight-etm-perf.c. Thus, we don't need to include
> coresight-etm4x.h in coresight-etm-perf.c. Do I miss anything?

Now I understand that you are using GEN_PMU_FORMAT_ATTR, so need to
used TTR_CFG_FLD_ts_level_* macro defined in coresight-etm4x.h.

Thanks,
Leo

