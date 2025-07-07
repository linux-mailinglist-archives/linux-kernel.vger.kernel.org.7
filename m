Return-Path: <linux-kernel+bounces-719010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 923DDAFA8B3
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 02:53:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD1AB3AC6BC
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 00:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1A0C166F0C;
	Mon,  7 Jul 2025 00:53:27 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8620E7E9;
	Mon,  7 Jul 2025 00:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751849607; cv=none; b=CFGqdqYVU8lrc64/hd9LbaWRh8gNs7ZMtNzc2HcqMML/mCewpvEe+zfj7NhNjq4iGi4s7T+L+Fm6p9Tv0V+a2ZBDbNvimzDs558FSNLIlTc2ny8wOy7BjacA4XV02ohcpbRyLpg+x2fzqqvu4zKPAw5KQJAuma/B6M3o3EswzTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751849607; c=relaxed/simple;
	bh=pc6/4pTCRoJU0680dfIylpAEX56OLE3/Ve8SK9ZY5yI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jl7M6DK1yfBwG4ClTjUzkb9zzoUVFcWgAtDj+gGMzQObWRMhr3gYU40AL8ugbfEiNTPAQbmK8AotLVLgUR0IoHG3LMiiaWZ9OMNAMbMu3dr+V1gXW9cfGC5fGH18eedHf9QdyPptdE3e6vlC0NRrb6wfSyKSP66T5wbcjFKmXO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E581AC4CEED;
	Mon,  7 Jul 2025 00:52:51 +0000 (UTC)
Date: Sun, 6 Jul 2025 19:52:50 -0500
From: Catalin Marinas <catalin.marinas@arm.com>
To: ankita@nvidia.com
Cc: jgg@nvidia.com, maz@kernel.org, oliver.upton@linux.dev,
	joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com,
	will@kernel.org, ryan.roberts@arm.com, shahuang@redhat.com,
	lpieralisi@kernel.org, david@redhat.com, ddutile@redhat.com,
	seanjc@google.com, aniketa@nvidia.com, cjia@nvidia.com,
	kwankhede@nvidia.com, kjaju@nvidia.com, targupta@nvidia.com,
	vsethi@nvidia.com, acurrid@nvidia.com, apopple@nvidia.com,
	jhubbard@nvidia.com, danw@nvidia.com, zhiw@nvidia.com,
	mochs@nvidia.com, udhoke@nvidia.com, dnigam@nvidia.com,
	alex.williamson@redhat.com, sebastianene@google.com,
	coltonlewis@google.com, kevin.tian@intel.com, yi.l.liu@intel.com,
	ardb@kernel.org, akpm@linux-foundation.org, gshan@redhat.com,
	linux-mm@kvack.org, tabba@google.com, qperret@google.com,
	kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, maobibo@loongson.cn
Subject: Re: [PATCH v10 2/6] KVM: arm64: Update the check to detect device
 memory
Message-ID: <aGsaYlZXvpU0Cngg@arm.com>
References: <20250705071717.5062-1-ankita@nvidia.com>
 <20250705071717.5062-3-ankita@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250705071717.5062-3-ankita@nvidia.com>

On Sat, Jul 05, 2025 at 07:17:13AM +0000, ankita@nvidia.com wrote:
> From: Ankit Agrawal <ankita@nvidia.com>
> 
> Currently, the kvm_is_device_pfn() detects if the memory is kernel
> mapped through pfn_is_map_memory. It thus implies whether KVM can
> use Cache Maintenance Operations (CMOs) on that PFN. It is a bit
> of a misnomer as it does not necessarily detect whether a PFN
> is for a device memory. Moreover, the function is only used at
> one place.
> 
> It would be better to directly call pfn_is_map_memory. Moreover
> we should restrict this call to VM_PFNMAP or VM_MIXEDMAP. Non PFMAP
> or MIXEDMAP VMA's must always contain normal pages which are
> struct page backed, have KVA's and are cachable. So we should always
> be able to go from phys to KVA to do a CMO.
> 
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Tested-by: Donald Dutile <ddutile@redhat.com>
> Signed-off-by: Ankit Agrawal <ankita@nvidia.com>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

