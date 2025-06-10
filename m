Return-Path: <linux-kernel+bounces-678742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8916CAD2D8A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jun 2025 07:56:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 683183B19CD
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jun 2025 05:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D42F25F7A1;
	Tue, 10 Jun 2025 05:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J+2QAMvR"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A8825F7B7
	for <linux-kernel@vger.kernel.org>; Tue, 10 Jun 2025 05:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749534962; cv=none; b=Pe1MTp271R/bVr9uNdsHe5UUNf1apZllGBhqVTqylspKWhHLsMv2MmUGr93k8EKVtN2leyu7QD/S/NbEryEnzuzshFk+YV4VCDaJgwWHXHMh21vDASQ0es8diR8nvsuWENO9iNAJu50FHXDUMrMs6wcX73FA68C/A662e7XB8Vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749534962; c=relaxed/simple;
	bh=G4e/2eOK6ny5QB/E7KrW01XPlfzZ3rtlWZTAQU/NK50=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gj6YgcFQYuohaO4SR3BhOooFoqRGmVHsaOECq7z2Zscjq71w11R4N18jK0lA/+Cm9/5aS9w/eTw6fRoWxT9c4tVr4ng28vuSdXRhZFZHhHrbYSeHxQ5muv3VSVzf71dFX4IEi/dLnqC3qjaaewBlZC4MM5v6Ar6KvMlUFWfu8t4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J+2QAMvR; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749534961; x=1781070961;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=G4e/2eOK6ny5QB/E7KrW01XPlfzZ3rtlWZTAQU/NK50=;
  b=J+2QAMvRlu3bnPN05KcoHdCuKfvI9ZsE+/8JR3mz0Bux0EY1dAKNfKKK
   tfSp6DyDpepuimbKfiCQC1tVPA+CWI8gQXpNu2qHF0coXwkobzh8EtsSV
   HjJkgFQyzRhMb1lqQk9FkrOEt9wbom1Ip+lwqEHvNa0D3vvBLxxGWc0hU
   HnYKs1vLcP6k8u9Hv8PkU4+kkh47ZgGVENpPjZHcluJEPDh3w5H9EcYuP
   H5QFnc6CRmlrP2qnoz4V5W7i9YB20sQNlJ5UYatKgYx49dZezC6rAFU30
   77cneI/tcQR9v1EatbZeELIQ1HgGyRzOMlGnfTXOxf8eduodm4lV7fQVG
   A==;
X-CSE-ConnectionGUID: ZcODmRbWSKa0bOxZmDNd0g==
X-CSE-MsgGUID: x+KvNVJuTYe5ev64n66foA==
X-IronPort-AV: E=McAfee;i="6800,10657,11459"; a="51619302"
X-IronPort-AV: E=Sophos;i="6.16,224,1744095600"; 
   d="scan'208";a="51619302"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2025 22:56:00 -0700
X-CSE-ConnectionGUID: iwtgq3SFR1qHMUrMNb3N1Q==
X-CSE-MsgGUID: +iV+ck/8TO6QZ8hxjHdHGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,224,1744095600"; 
   d="scan'208";a="147692069"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2025 22:55:56 -0700
Message-ID: <663c7eee-5a3a-48e5-8bed-8abad62f3484@linux.intel.com>
Date: Tue, 10 Jun 2025 13:55:05 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 08/12] iommufd/viommu: Replace ops->viommu_alloc with
 ops->viommu_init
To: Nicolin Chen <nicolinc@nvidia.com>, jgg@nvidia.com, kevin.tian@intel.com
Cc: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
 ddutile@redhat.com, yi.l.liu@intel.com, peterz@infradead.org,
 jsnitsel@redhat.com, praan@google.com, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org, patches@lists.linux.dev
References: <cover.1749488870.git.nicolinc@nvidia.com>
 <5586990446e4c97827b5a195622ec0f8cf9d2d67.1749488870.git.nicolinc@nvidia.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <5586990446e4c97827b5a195622ec0f8cf9d2d67.1749488870.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/10/25 01:13, Nicolin Chen wrote:
> To ease the for-driver iommufd APIs, get_viommu_size and viommu_init ops
> are introduced. Now, those existing vIOMMU supported drivers implemented
> these two ops too.
> 
> Relace the ops->viommu_alloc call with the two new ones.
> 
> Note that this will fail a !viommu->ops case from now on, since a vIOMMU
> is expected to support alloc_domain_nested at least.

Does this mean that the viommu implementation in the iommu driver is
required to implement alloc_domain_nested? I suppose viommu should soon
be extended to support TEE/IO.

> 
> Suggested-by: Jason Gunthorpe<jgg@nvidia.com>
> Signed-off-by: Nicolin Chen<nicolinc@nvidia.com>
> ---
>   drivers/iommu/iommufd/viommu.c | 30 +++++++++++++++++++++++++++---
>   1 file changed, 27 insertions(+), 3 deletions(-)
> 

<...>

> @@ -68,6 +82,16 @@ int iommufd_viommu_alloc_ioctl(struct iommufd_ucmd *ucmd)
>   	 */
>   	viommu->iommu_dev = __iommu_get_iommu_dev(idev->dev);
>   
> +	rc = ops->viommu_init(viommu, hwpt_paging->common.domain);
> +	if (rc)
> +		goto out_abort;
> +
> +	/* It is a driver bug that viommu->ops isn't filled */
> +	if (WARN_ON_ONCE(!viommu->ops)) {
> +		rc = -EINVAL;
> +		goto out_abort;
> +	}
> +
>   	cmd->out_viommu_id = viommu->obj.id;
>   	rc = iommufd_ucmd_respond(ucmd, sizeof(*cmd));
>   	if (rc)

Thanks,
baolu

