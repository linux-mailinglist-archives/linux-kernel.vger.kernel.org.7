Return-Path: <linux-kernel+bounces-822028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2639AB82E4A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 06:39:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9C741C24259
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 04:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 241F9271457;
	Thu, 18 Sep 2025 04:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Pey2lUFn"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 363D426FA6F
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 04:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758170371; cv=none; b=p3ULB/aYlx0hcn1O6eVpGHdX4N5jSWcIdmlnfKFqb2lWydHT9yK4FftMi8ha1v2Jraci+a4fOJTd6ybe3IjYBUfKWwehzPFcI9IFFUHXKgP6DKawKcRquEVPH/9X/Yyo6Ut3a0aA3rYLJjEGWuKSX9RgGaF3ZrtLBckT+2pZ0yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758170371; c=relaxed/simple;
	bh=X6kUjj680xcLI1K1anx91rO/C/v/4f+XsFbrFBY/zS8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fl0QjQo1bZ7Z+Syhyvy9quK19wXzXb9Fhv7hXjZKxwcN/dO7zIIX+GTk2F5HcywQrz1f03amD71cU7M2aFamS4wZs05ZiPJhYuP1xzvS8Z1/5tM6T4oRpZc0CUQu9l6PbQCowUivBtnsVJ8wC++Ji5B7dzWqU5e6apzGNbCb3kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Pey2lUFn; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758170370; x=1789706370;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=X6kUjj680xcLI1K1anx91rO/C/v/4f+XsFbrFBY/zS8=;
  b=Pey2lUFneG1xJ2KIodRHhKAN1y2NqNaaASwkT/8M+trrofPCtNd4+K4B
   777l7VOllTjAl9QoLpyZ6/IYQvgEAXhqyj4OeDalWuDSilAFKvD2vp9Zq
   mlkQa6zESO98Ywri4WypOZJvwGic9K4qI57tNi5nEJfoyoEtgFIH0NQ5o
   wb9HGvqnBHcZcotd9OHzDL2S9pHVcXOa0AQa3g/N7ZN7DuqCVZz7+SdmW
   y1MV/0jeSj9ffqgtkqO5To1tIJYKu+kOi1INOCHsy4afyrNnwTNLccUJV
   /fSA6ASbA4VfGMeUFJYyKTEy4kI5VMWfI6Bngx0y5h3b1ylz+YWDan/10
   A==;
X-CSE-ConnectionGUID: WWSbXUWiQ4CZx0TTtOeRgw==
X-CSE-MsgGUID: DlRN6FEYSeiU5Gu7Vw65ig==
X-IronPort-AV: E=McAfee;i="6800,10657,11556"; a="77926735"
X-IronPort-AV: E=Sophos;i="6.18,274,1751266800"; 
   d="scan'208";a="77926735"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2025 21:39:30 -0700
X-CSE-ConnectionGUID: LFj+fWbST/+64gxGSe6FYQ==
X-CSE-MsgGUID: 2jaEbAFeStec6YDUOKFXnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,274,1751266800"; 
   d="scan'208";a="175827138"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2025 21:39:27 -0700
Message-ID: <e49733c3-c6a0-44e3-9cb5-afcf2161b22c@linux.intel.com>
Date: Thu, 18 Sep 2025 12:36:36 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] iommu/vt-d: Removal of Advanced Fault Logging
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20250917024850.143801-1-baolu.lu@linux.intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20250917024850.143801-1-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/17/25 10:48, Lu Baolu wrote:
> The advanced fault logging has been removed from the specification since
> v4.0. Linux doesn't implement advanced fault logging functionality, but
> it currently dumps the advanced logging registers through debugfs. Remove
> the dumping of these advanced fault logging registers through debugfs to
> avoid potential access to non-present registers.
> 
> Signed-off-by: Lu Baolu<baolu.lu@linux.intel.com>
> ---
>   drivers/iommu/intel/debugfs.c | 1 -
>   drivers/iommu/intel/iommu.h   | 1 -
>   2 files changed, 2 deletions(-)

Queued for v6.18.

