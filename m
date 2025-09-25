Return-Path: <linux-kernel+bounces-831765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EEC5B9D836
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 08:02:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6417C7B7F96
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 06:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65A4C2D9EDC;
	Thu, 25 Sep 2025 06:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MO1JUS1x"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F4E21D5B3
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 06:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758780159; cv=none; b=idP0tfQs5dXp60KjYQkqiobJWWcnynmPjaF3RuVyj6mEOrdn6XAwzD1/LEfLe0QgwAQDErH3WaZFQV/kFG10tYtVfmFb76WFYR1flmcMbIKXlxcoILwg4PDj+0EOk19l7uofyHh0edTMqUGIbLh9uHYEJFbdyYMnECUBhVCHtjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758780159; c=relaxed/simple;
	bh=k7xzOIG46ANABbJRx9WSD5OyTJ9AHlHnRpl1zUshA3c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IQDAMDP0BTyuGV9a4bq/w86CCdjUHqQXKi7rb1VFoVWNXFI+IjvPI4phZAxFNc/FPdUlUdXJ9IuE4W4+Z7tZUWrg7im0MVEDzF7+h4yJad8zBnH0KkafupWo+fZrEDx7Rhc9/JLR7QSO2cj5vTAF0he1aQfBa4cLcLxeKPo1YPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MO1JUS1x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF328C4CEF0;
	Thu, 25 Sep 2025 06:02:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758780159;
	bh=k7xzOIG46ANABbJRx9WSD5OyTJ9AHlHnRpl1zUshA3c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MO1JUS1xQ7SC9OCRxeP2fSNZKKsA9GHolLRgRUGX3pY6nNZ0tguubcvNd5adwMeZD
	 XYR1R9Ke1gh9+jw+e0h5q7hucdMvcWLR8M0893x+8gESoH1YOa1N7T5y+RbqYWl+1L
	 qxc0i1te+yYXeSkhzUO+zoPGwZ2cDcTUFq17uIO8=
Date: Thu, 25 Sep 2025 08:02:36 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Yaxing Guo <guoyaxing@bosc.ac.cn>
Cc: linux-kernel@vger.kernel.org, anxu@bosc.ac.cn, zhangjian@bosc.ac.cn,
	wangran@bosc.an.cn
Subject: Re: [RFC v1 1/2] uio: Add SVA support for PCI devices via
 uio_pci_generic_sva.c
Message-ID: <2025092518-urologist-image-12ab@gregkh>
References: <20250925040637.14511-1-guoyaxing@bosc.ac.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250925040637.14511-1-guoyaxing@bosc.ac.cn>

On Thu, Sep 25, 2025 at 12:06:36PM +0800, Yaxing Guo wrote:
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
>  drivers/uio/uio_pci_generic_sva.c | 188 ++++++++++++++++++++++++++++++
>  1 file changed, 188 insertions(+)
>  create mode 100644 drivers/uio/uio_pci_generic_sva.c
> 
> diff --git a/drivers/uio/uio_pci_generic_sva.c b/drivers/uio/uio_pci_generic_sva.c
> new file mode 100644
> index 000000000000..6a20c3487fed
> --- /dev/null
> +++ b/drivers/uio/uio_pci_generic_sva.c
> @@ -0,0 +1,188 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * UIO PCI Express sva driver
> + *
> + * Copyright (c) 2024 Beijing Institute of Open Source Chip (BOSC)

It is now 2025 :)


> + */
> +
> +#include <linux/device.h>
> +#include <linux/module.h>
> +#include <linux/pci.h>
> +#include <linux/uio_driver.h>
> +#include <linux/iommu.h>
> +
> +struct uio_pci_sva_dev {
> +	struct pci_dev *pdev;
> +	struct uio_info info;
> +	struct iommu_sva *sva_handle;
> +	int pasid;
> +};
> +
> +static ssize_t pasid_show(struct device *dev,
> +			  struct device_attribute *attr, char *buf)
> +{
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +	struct uio_pci_sva_dev *udev = pci_get_drvdata(pdev);
> +
> +	return sprintf(buf, "%d\n", udev->pasid);

sysfs_emit() please.

> +}
> +static DEVICE_ATTR_RO(pasid);

All sysfs attributes need to be documented in Documentation/ABI/

> +static int probe(struct pci_dev *pdev, const struct pci_device_id *id)
> +{
> +	struct uio_pci_sva_dev *udev;
> +	int ret, i, irq;
> +
> +	ret = pci_enable_device(pdev);
> +	if (ret) {
> +		dev_err(&pdev->dev, "pci_enable_device failed: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
> +	if (ret)
> +		goto out_disable;
> +
> +	pci_set_master(pdev);
> +
> +	ret = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_MSIX);
> +	if (ret) {
> +		irq = msi_get_virq(&pdev->dev, 0);
> +		if (irq == -ENXIO)
> +			ret = UIO_IRQ_NONE;
> +		else if (irq < 0) {
> +			ret = irq;
> +			goto out_disable;
> +		}
> +	} else {
> +		dev_warn(&pdev->dev, "Failed to allocate irq vectors\n");

Why doesn't this fail probe?

> +	}
> +
> +	udev = devm_kzalloc(&pdev->dev, sizeof(struct uio_pci_sva_dev),
> +			    GFP_KERNEL);
> +	if (!udev) {
> +		ret =  -ENOMEM;
> +		goto out_disable;
> +	}
> +
> +	udev->pdev = pdev;
> +	udev->info.name = "uio_pci_sva";
> +	udev->info.version = "0.0.1";
> +	udev->info.open = uio_pci_sva_open;
> +	udev->info.release = uio_pci_sva_release;
> +	udev->info.irq = irq;
> +	udev->info.handler = irq_handler;
> +	udev->info.priv = udev;
> +
> +	for (i = 0; i < MAX_UIO_MAPS; i++) {
> +		struct resource *r = &pdev->resource[i];
> +		struct uio_mem *uiomem = &udev->info.mem[i];
> +
> +		if (r->flags != (IORESOURCE_SIZEALIGN | IORESOURCE_MEM))
> +			continue;
> +
> +		if (uiomem >= &udev->info.mem[MAX_UIO_MAPS]) {
> +			dev_warn(&pdev->dev, "Do not support more than %d iomem\n",
> +				 MAX_UIO_MAPS);
> +			break;
> +		}
> +
> +		uiomem->memtype = UIO_MEM_PHYS;
> +		uiomem->addr = r->start & PAGE_MASK;
> +		uiomem->offs = r->start & ~PAGE_MASK;
> +		uiomem->size =
> +			(uiomem->offs + resource_size(r) + PAGE_SIZE - 1) &
> +			PAGE_MASK;
> +		uiomem->name = r->name;
> +	}
> +
> +	ret = sysfs_create_file(&pdev->dev.kobj, &dev_attr_pasid.attr);

You just raced with userspace and lost.  Please use the default
attribute list instead.

> +module_pci_driver(uio_pci_generic_sva_driver);
> +MODULE_LICENSE("GPL");

You now also need a MODULE_DESCRIPTION(), didn't you get a build warning
without it?

thanks,

greg k-h

