Return-Path: <linux-kernel+bounces-794001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47F2DB3DB57
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 09:44:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E71F3A8D76
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 07:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44E672D7818;
	Mon,  1 Sep 2025 07:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KAzM5ZYm"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61EA72D73BE
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 07:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756712669; cv=none; b=d6P1focp33kRCjqCiPG+o3uglIOenfIUet5I+QPAlv2/vJ4ENB7kYFMzKOAEcP/bFTEXac7o8CygSNsN4VjXb1vTyLwCMnz4Pbguu4npDQ5TJ9UkSPt6uAILb46lpHYVA/uhYJ0x09NhtmxjW681Ib9Z2RPvTXSWwisKjlb7WlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756712669; c=relaxed/simple;
	bh=LAhPlQkwRniWdWdFm7r3ifv986fHloqDlRwZH3JiaWE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G0kJiI1cSCQBG6DKIWiqfrszpgH9rICVGNgHXcgZXMX8Jj9UFk7aUESphiLzXeEQi4W4EiaT9/b66HImKucIOdtrgNGfKJYV+rHJd7hWrucZtQBMfQ6riCfjxVOUhHurhxIzMBn4pCYFRZ+f5wQobIfdE9rvIXqoQAhJhLiTtBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KAzM5ZYm; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756712667; x=1788248667;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=LAhPlQkwRniWdWdFm7r3ifv986fHloqDlRwZH3JiaWE=;
  b=KAzM5ZYmUwZrpBM9YgK7MRn6YO1C0evBTVX8RsVnDB6RPrsBXcCmnRDC
   a6CyxlhQR+OAcgTgFlib2A5y3YJ99GkghA71Qp1gGDsFYlqFt1iUXn/OT
   zrx7cFfNFrDRhgQsKZggxhVssJwPcEfLsYqBZ68CSERB2xSSdFkhEy14e
   xyXjhkKbsSODRH20ngHOQUcm/bxwh8LRibw4wSlAVeeDVWyWCOOzfiLVM
   DXA7zbMGR0+fdKEvSqDGFKrZnDiiekgUIVka6rVqwVOAtIh65C9sdNMV2
   NalVbAsDbGvhxvC95rJpfMlqKTnZQRCaQ2tdviwnpdFtvCvAsIJUdfxyd
   g==;
X-CSE-ConnectionGUID: Ow3PR1JCRGuVv5CoeYyI9Q==
X-CSE-MsgGUID: VQHTrh/6QSGfbFewwM9xhw==
X-IronPort-AV: E=McAfee;i="6800,10657,11539"; a="58990724"
X-IronPort-AV: E=Sophos;i="6.18,225,1751266800"; 
   d="scan'208";a="58990724"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2025 00:31:09 -0700
X-CSE-ConnectionGUID: Wxvkcs4rR6uDQ9LaszcfLw==
X-CSE-MsgGUID: jjggfe7zR4Sg6n4ioQQ63w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,225,1751266800"; 
   d="scan'208";a="201842614"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2025 00:31:07 -0700
Message-ID: <cdd1c8ff-6bb5-4665-a55a-9d86cd81a8ef@linux.intel.com>
Date: Mon, 1 Sep 2025 15:28:29 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/vt-d: fix iommu pasid memory alloc & max pasid err
To: Guanghui Feng <guanghuifeng@linux.alibaba.com>, dwmw2@infradead.org,
 joro@8bytes.org, will@kernel.org, robin.murphy@arm.com
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 alikernel-developer@linux.alibaba.com
References: <20250830130737.1930726-1-guanghuifeng@linux.alibaba.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20250830130737.1930726-1-guanghuifeng@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/30/25 21:07, Guanghui Feng wrote:
> When intel_pasid_alloc_table allocates memory for Scalable Mode PASID
> directories, the specified memory page order is incorrect, and an
> additional PAGE_SHIFT is added. There is also an error in calculating
> the maximum number of supported PASID directories. In the revised
> implementation, 1 << (order + PASID_PDE_SHIFT - 3) represents the memory
> occupied by the Scalable Mode PASID directory, divided by 8 to represent
> the number of PASID directories, and then multiplied by the number of (1
> << PASID_PDE_SHIFT) entries in each PASID directory.

Do you see any specific issues if the changes described in this patch
are lacking?

> 
> Signed-off-by: Guanghui Feng <guanghuifeng@linux.alibaba.com>
> ---
>   drivers/iommu/intel/pasid.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
> index 52f678975da7..9969913b600b 100644
> --- a/drivers/iommu/intel/pasid.c
> +++ b/drivers/iommu/intel/pasid.c
> @@ -61,14 +61,14 @@ int intel_pasid_alloc_table(struct device *dev)
>   	size = max_pasid >> (PASID_PDE_SHIFT - 3);
>   	order = size ? get_order(size) : 0;
>   	dir = iommu_alloc_pages_node_sz(info->iommu->node, GFP_KERNEL,
> -					1 << (order + PAGE_SHIFT));
> +					1 << order);

This converts the order to the allocation size.

>   	if (!dir) {
>   		kfree(pasid_table);
>   		return -ENOMEM;
>   	}
>   
>   	pasid_table->table = dir;
> -	pasid_table->max_pasid = 1 << (order + PAGE_SHIFT + 3);

With this code, I can get the pasid_table->max_pasid equal to 0x100000
if the device supports PASID, which is what I expect.

> +	pasid_table->max_pasid = 1 << (order + PASID_PDE_SHIFT - 3);
>   	info->pasid_table = pasid_table;
>   
>   	if (!ecap_coherent(info->iommu->ecap))

Thanks,
baolu

