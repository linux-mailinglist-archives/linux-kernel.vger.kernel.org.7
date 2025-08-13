Return-Path: <linux-kernel+bounces-766338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBE94B2455F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 11:26:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 646D97BAA19
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 09:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D6012F0C68;
	Wed, 13 Aug 2025 09:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="cgLdIUmc"
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A67E02EFD88
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 09:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755077095; cv=none; b=JUTggNFCzCUjsLZTiNSTTVB51ka5NYwUKs6dFaL/jLbTE0TvQbocgy862AXHcaDaIhhbBeBb0/3mD71yW1T4S3vMZ1E6RNPSq5NxveHeIcYSKeYep9ueyryvzBypXm9fuyVOcdIYq+wBt3SqcasmPPx9ITgg6olOYPUCtSYQzPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755077095; c=relaxed/simple;
	bh=vZU2fPuktRHFqiKEJpukleCqy1pyHW4HPoSySHNd+2E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=i690e6Mx7hDzxRgK+6F0vA8WJm0blCqPJwDC0r291l6nO65+Qo1Dfr9nvwVGb8bHnMjNCgx6+gjvGhwSW03Tk5fxDrweOD/sSx83GNN1GlqGSi6qoTV4KWB0JZJVi2QfYGljMNAfIAJNVeexOShzks9Z6PBPLs9pCThdUOPeklk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=cgLdIUmc; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20250813092452euoutp010fb72a6fdce806bfe5b5dc832c9af700~bSVEHazDp2335723357euoutp013
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 09:24:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20250813092452euoutp010fb72a6fdce806bfe5b5dc832c9af700~bSVEHazDp2335723357euoutp013
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1755077092;
	bh=a2Nwp2MU876d7dPdKtR5qFqYelXFxh3gg4ETa1w6iR0=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=cgLdIUmc0uLWncfkW57OWD9w8L/LM9xrFTd0Uk372B/uNWAUCD2kvSsngN14RA0Fx
	 5pWE3tqh4SlbYfc/nQA64IxjQlTDfZ14ExrlQjNOHK77MeYIs6MNXp4ZYutbt1Ja9X
	 wgBkzRo+XsLbteVMfYx2L2kqS4O9wekVQoXjdI+A=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20250813092451eucas1p11e109563279fd9f71d87ae0ae7054be1~bSVDoQDWX1974719747eucas1p1R;
	Wed, 13 Aug 2025 09:24:51 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250813092450eusmtip236af12d762e8b79623dc70cf3787ce72~bSVCeBDGD2419424194eusmtip2a;
	Wed, 13 Aug 2025 09:24:50 +0000 (GMT)
Message-ID: <7b505aac-0b2d-40b4-9a0b-98b74b0bf987@samsung.com>
Date: Wed, 13 Aug 2025 11:24:49 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH v2] dma/pool: Ensure DMA_DIRECT_REMAP allocations are
 decrypted
To: Shanker Donthineni <sdonthineni@nvidia.com>, Catalin Marinas
	<catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Suzuki K Poulose
	<suzuki.poulose@arm.com>, Steven Price <steven.price@arm.com>,
	linux-arm-kernel@lists.infradead.org
Cc: Robin Murphy <robin.murphy@arm.com>, Gavin Shan <gshan@redhat.com>, Mike
	Rapoport <rppt@kernel.org>, Vikram Sethi <vsethi@nvidia.com>, Jason Sequeira
	<jsequeira@nvidia.com>, Dev Jain <dev.jain@arm.com>, David Rientjes
	<rientjes@google.com>, linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	stable@vger.kernel.org
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20250811181759.998805-1-sdonthineni@nvidia.com>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20250813092451eucas1p11e109563279fd9f71d87ae0ae7054be1
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250811181833eucas1p2632002b6854b082632247829ea0a944c
X-EPHeader: CA
X-CMS-RootMailID: 20250811181833eucas1p2632002b6854b082632247829ea0a944c
References: <CGME20250811181833eucas1p2632002b6854b082632247829ea0a944c@eucas1p2.samsung.com>
	<20250811181759.998805-1-sdonthineni@nvidia.com>

On 11.08.2025 20:17, Shanker Donthineni wrote:
> When CONFIG_DMA_DIRECT_REMAP is enabled, atomic pool pages are
> remapped via dma_common_contiguous_remap() using the supplied
> pgprot. Currently, the mapping uses
> pgprot_dmacoherent(PAGE_KERNEL), which leaves the memory encrypted
> on systems with memory encryption enabled (e.g., ARM CCA Realms).
>
> This can cause the DMA layer to fail or crash when accessing the
> memory, as the underlying physical pages are not configured as
> expected.
>
> Fix this by requesting a decrypted mapping in the vmap() call:
> pgprot_decrypted(pgprot_dmacoherent(PAGE_KERNEL))
>
> This ensures that atomic pool memory is consistently mapped
> unencrypted.
>
> Cc: stable@vger.kernel.org
> Signed-off-by: Shanker Donthineni <sdonthineni@nvidia.com>

Thanks, applied to dma-mapping-fixes branch.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland


