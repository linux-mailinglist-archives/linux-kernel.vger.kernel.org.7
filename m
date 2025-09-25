Return-Path: <linux-kernel+bounces-832412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17C72B9F41C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 14:32:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 498A27B98A5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 12:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 379482FFDD4;
	Thu, 25 Sep 2025 12:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FnWACTpI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB0A2FF14D
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 12:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758803399; cv=none; b=Xuz6MbxaEJrwEYh+a5jFfIqFj4nAobNNzShDHtZAUYewJQGDEBYLikmj4uzkS8gD0Oo3sXWzsJxM2Tyqnlqk9J5/SdFLGDXl+xoeAcWG2q0Yx2TzzcI77XpT6yTKeIHmfzjSyxITUgyt1DZM35fwtSGlaradP0hUcHPS+hMTl90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758803399; c=relaxed/simple;
	bh=CXXZxoD4NVVxkG0WCJby6ZE4X2RMXOBdaUm6I7ki76o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uLWVllfvFPHc6ZwbrMQIkEOPMsbc/tTH+IXYDM0OmM/0U0jBoNLWeN/OkJCG7Keir28dgXtQRLCdMLKf28IXjC10TBV6FO2I0igC6Vi4n1wySkEOMmqb8ikMrxZkhZ8w1tO48edSwYqfW9RhpGZhM2DnjdJTF9qgqmUQe2xvNmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FnWACTpI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 476F3C4CEF0;
	Thu, 25 Sep 2025 12:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758803398;
	bh=CXXZxoD4NVVxkG0WCJby6ZE4X2RMXOBdaUm6I7ki76o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FnWACTpI7WLGblf7RqdLmAe8mKJ+RRBm/pNdWgsZ9TGUOVXdpWaf3CXEAhrf20e2U
	 SBLMHtnsZ4O9IE/aCxUfi1+hbyBuptWWuc/+sFBOGv4PVn1cSt3O4UYeX8Gol7UW1o
	 kKXZWHw2flS8+NcyfdTmOCKv1qojZvZew4BjXmrQ=
Date: Thu, 25 Sep 2025 14:29:55 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Yaxing Guo <guoyaxing@bosc.ac.cn>
Cc: linux-kernel@vger.kernel.org, wangran@bosc.ac.cn, zhangjian@bosc.ac.cn,
	anxu@bosc.ac.cn
Subject: Re: [PATCH v2 1/3] uio: Add SVA support for PCI devices via
 uio_pci_generic_sva.c
Message-ID: <2025092539-tamper-subtype-2839@gregkh>
References: <20250925104018.57053-1-guoyaxing@bosc.ac.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250925104018.57053-1-guoyaxing@bosc.ac.cn>

On Thu, Sep 25, 2025 at 06:40:16PM +0800, Yaxing Guo wrote:
> This patch introduces a new UIO driver, uio_pci_generic_sva, which
> extends the functionality of uio_pci_generic by adding support for
> Shared Virtual Addressing (SVA) when IOMMU is enabled in the system.
> 
> The key enhancement allows PCI devices to directly use user-space virtual
> addresses for DMA operations, eliminating the need for bounce buffers or
> explicit IOVA mapping. This is achieved by leveraging the kernel's IOMMU-SVA
> subsystem, including process address space attachment, page fault handling,
> and shared context management between CPU and device.
> 
> With this driver, userspace applications can perform zero-copy DMA using
> native pointers:
> 
>     void *addr = malloc(N);
>     set_dma_addr((uint64_t)addr);  // Pass user VA directly
>     start_dma();
> 
> The device can now access 'addr' through the IOMMU's PASID-based translation,
> provided that the underlying IOMMU hardware (e.g., Intel VT-d 3.1+, AMD-Vi,
> ARM SMMU, RISCV IOMMU) and platform support SVA.
> 
> Dependencies:
> - CONFIG_IOMMU_SVA must be enabled.
> - The platform must support PRI (Page Request Interface) and PASID.
> - Device drivers/userspace must handle page faults if demand-paging is used.
> 
> The implementation reuses core logic from uio_pci_generic.c while adding
> PASID setting, and integration with the IOMMU SVA APIs.
> 
> Signed-off-by: Yaxing Guo <guoyaxing@bosc.ac.cn>
> ---
> Changes in v2:
>   -- Use sysfs_emit() instead of sprintf in pasid_show()
>   -- Use the default attribute list instead of sysfs_create_file
>   -- Add MODULE_DESCRIPTION
>   -- Modify "2024" to "2025" in copyright
> 
>  drivers/uio/uio_pci_generic_sva.c | 192 ++++++++++++++++++++++++++++++
>  1 file changed, 192 insertions(+)
>  create mode 100644 drivers/uio/uio_pci_generic_sva.c
> 
> diff --git a/drivers/uio/uio_pci_generic_sva.c b/drivers/uio/uio_pci_generic_sva.c
> new file mode 100644
> index 000000000000..97e9ab9a081a
> --- /dev/null
> +++ b/drivers/uio/uio_pci_generic_sva.c
> @@ -0,0 +1,192 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * UIO PCI Express sva driver
> + *
> + * Copyright (c) 2025 Beijing Institute of Open Source Chip (BOSC)

Shouldn't that be 2024-2025 if work happened on this in 2024?


