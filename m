Return-Path: <linux-kernel+bounces-599254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74CD3A85167
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Apr 2025 04:08:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9ADDD8A7D43
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Apr 2025 02:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E3B927BF67;
	Fri, 11 Apr 2025 02:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RnKjK46L"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7261348CFC
	for <linux-kernel@vger.kernel.org>; Fri, 11 Apr 2025 02:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744337318; cv=none; b=p65hxNcpWtLfrJSUaHuDCjryZyzbnFEAueVE40kPDjyMAM+6dEHRoj9OEei1lWdArlCkckXiqb2iCjGa709MGf43irbYYzskHsUf/Ewom19IWFKKCSrkE+VmIMWiuKLCEx8RviKSzcEZpgqPPgyhrl3bH7BQ+pKMvPPW4kx4OFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744337318; c=relaxed/simple;
	bh=CdN7bNlVpobFRPEqoZGNL5GLM4SaDwb8QK1i6qZLk3o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BIm4SRaWXs/0Nxa4RLTRFNghxmwXt7tgBV6VuMdAJEvT+6ffwVqxfnk0qkthx8q0iw2Yj8dL1al3l0ppH3XW5v5UzXqcbZhsZczo4pTbQ6DglWxuG8qny381KQQ1NDEnsiTQCDJ2cALb5wm1pyDPsMdZxBmbV2/C34lqvCtXWUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RnKjK46L; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744337316; x=1775873316;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=CdN7bNlVpobFRPEqoZGNL5GLM4SaDwb8QK1i6qZLk3o=;
  b=RnKjK46LoJP6FvwAahdVB7SfDRDEZ7JeFtqrItVeYTknMJrXJIswb9Ju
   tlefopEqPqVfQLCJ3nM7Pxjq+6JJ5Zidb2MKf3+DXK0OucXS+Stk7EIii
   N1bNwZFRRbUYL8bdkns8tMa81b8Pte+o+agqYk+B2aksj4sUw0MwYd9Ng
   JBuXJWN0vw4gSz6kPohBOUrq7z7KA+aGok4nsIvGLHTpWhfLymSCYJqSh
   xcYNC+ZarAPld78vutKOqqyJMVH+gaztzTxlUbkfWDLe4s+fFMbDVdDN0
   Fk1tljazczABpU3ovEOgnXbzJZ+qPmGka/L+LaLL44TQHQSm6yYkFSCeS
   A==;
X-CSE-ConnectionGUID: 2HS4YJ/bTQ+NqLUni2r34Q==
X-CSE-MsgGUID: u4uh1UvHSxKIrfKwemUWqA==
X-IronPort-AV: E=McAfee;i="6700,10204,11400"; a="57251049"
X-IronPort-AV: E=Sophos;i="6.15,203,1739865600"; 
   d="scan'208";a="57251049"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2025 19:08:35 -0700
X-CSE-ConnectionGUID: Bu4IKsmDTsqkp3ubsu4ThQ==
X-CSE-MsgGUID: ls6EYf7/Rjy9ZVkb6TekfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,203,1739865600"; 
   d="scan'208";a="160039691"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2025 19:08:11 -0700
Message-ID: <e416dddd-bb35-4ee7-9c6a-e1aa8c4ec3a9@linux.intel.com>
Date: Fri, 11 Apr 2025 10:04:18 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu: Clear iommu-dma ops on cleanup
To: Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org, will@kernel.org
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 Chen-Yu Tsai <wenst@chromium.org>
References: <e788aa927f6d827dd4ea1ed608fada79f2bab030.1744284228.git.robin.murphy@arm.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <e788aa927f6d827dd4ea1ed608fada79f2bab030.1744284228.git.robin.murphy@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/10/25 19:23, Robin Murphy wrote:
> If iommu_device_register() encounters an error, it can end up tearing
> down already-configured groups and default domains, however this
> currently still leaves devices hooked up to iommu-dma (and even
> historically the behaviour in this area was at best inconsistent across
> architectures/drivers...) Although in the case that an IOMMU is present
> whose driver has failed to probe, users cannot necessarily expect DMA to
> work anyway, it's still arguable that we should do our best to put
> things back as if the IOMMU driver was never there at all, and certainly
> the potential for crashing in iommu-dma itself is undesirable. Make sure
> we clean up the dev->dma_iommu flag along with everything else.
> 
> Reported-by: Chen-Yu Tsai<wenst@chromium.org>
> Signed-off-by: Robin Murphy<robin.murphy@arm.com>

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

