Return-Path: <linux-kernel+bounces-836820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D14ABAAA4D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 23:21:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFFB5189F74A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 21:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47FA8244662;
	Mon, 29 Sep 2025 21:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DanH0zob"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F161B2F872
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 21:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759180899; cv=none; b=XO+rgTPcknLWkot8tOnMZvu0iAnyMX/lZePh+jBAh2mqCvc+gJChly1YxAn73KvUSD3Rj1BSD9KULpZ/K160P8w07fgx2IT68kQOtP1dz8bB3I2uL05Pe2k92ZPnEyU44t1wzl02RqxodOZXAuixvZJKmS5cfWuY/D3T7KoUqfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759180899; c=relaxed/simple;
	bh=pkxsk78IHog0vv+IBSdn+sUVFtS8RfXXuKpUO43hniM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k5irf3wHiqjrca0cXDjKeu55S9iDAuz0aO1kMuQBNE30573pbhTrG/uRkZ1yHfHvPtO0hNDmXvUJObeufM5Eki0qvPHeymde9JqE7ky3ZuDtHSN9L0zERQtbu+cM1ell9LKHuZ+pCmGrR3yuRYh9u/o01dZHqFVhZgWKMAUCE74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DanH0zob; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759180897;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tBEzt7vDi7cQon8pe4PxgzLkANUC3bHfRN0ntBJldU8=;
	b=DanH0zobZx2l4Bvq2An7l396w1L+aSkpRbM9PwRDakVKPwU/yNQcpZBvwAm7C5PDKmRohc
	XNRnq3Ia0EzB0flLSLH1x21esAk3/WUdWnSmJbac+Y84v98JHr82pnPrzPt51Cyl+RNL76
	vQMrv9Ck5UKZ1jlH1v8y2d7Y34l1pnY=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-180-F8ZXXr6_PzKHi1R40RfUag-1; Mon, 29 Sep 2025 17:17:53 -0400
X-MC-Unique: F8ZXXr6_PzKHi1R40RfUag-1
X-Mimecast-MFC-AGG-ID: F8ZXXr6_PzKHi1R40RfUag_1759180673
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-4257e2f44e9so11598585ab.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 14:17:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759180673; x=1759785473;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tBEzt7vDi7cQon8pe4PxgzLkANUC3bHfRN0ntBJldU8=;
        b=OlfPoCVUpV5eUR9FF8wJowwJnrrl3vm2Vo55tcCxaYChsED095KWDMHO/j4ayeSM1C
         XmossrwhLFL9tBmptBDjUIXei/tH6PWRyDNY0HCynw1BzzBDAf5O+xZNB+brbPmwD8Ko
         pi6o072Oeoy98bhP3a223d2nQm6jRQLEnAeFLUhswbo18dLC8ojl/5+scGDH6hRigIv8
         VmvQI/ZNfUSz9GgVgvc6C9Hsz/1A6h7T7hxisR/VR2Tbm5cr02GmBm7ezUy2zrZcS3IM
         6zL5wON+FFelhaq9LUqa18h3hULZ0Wn20Z/WBQX5LUkJ851ULCy228kwfgJsweAyNxi5
         6cVg==
X-Forwarded-Encrypted: i=1; AJvYcCVx4E8P6fyWA4r9iAoDYiPQ1vLqtupxwEFtE4LBEQrVLW+6820wPuNWEqRXBBe636MmFM/iXe1WXmCHuvs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+f7jnU9FltuMgIAL10kGb8HzOE3PPsVXjAQgceCzXvd+pONI+
	scIi2hRvqo8XyjrOg+j8eaQgVdtOa51xKWPYo/WpOACs2tdKnajUKt953DEtb6x+w8P5mxEt9Pm
	tPlrxM7u17o/B9xdR6WKELNzeSwHqX+cJSOuZIlUjvSC+BrEegrTaIBvMnKW59aBY7w==
X-Gm-Gg: ASbGncu+CSC0dG93gJ+aGRJoBH9ytpjzL+ZDjmBYqDiKvWwE9aH7hjOTZgAJrbw/fPu
	88ZkO5XYtiAS9qLZUuI2A4tJ/d68hpjg8ixk3Ocz7UrWaMycJkRlgC1T3AT+4D5EnswjjzDh7NO
	xLrORnlN54xEhGLjntTkwZaSnKJPgrNdCtFTy0t6GpPsSBdSAIxVYrBiCAsJ5i/xGfqLEjxc9BM
	ozh/Cw5O8A2Or1W0L+v0HXJd1Ko/aJbNWr1z7YM8OH+dZiaWhNmrNNvTi9To0QquaCIjgVoa2Kl
	FCwRuNdaDp4j8Z9E1VQBtPlOCK0OEmVvX0muwg904WQ=
X-Received: by 2002:a05:6e02:1523:b0:425:9068:4ff with SMTP id e9e14a558f8ab-425955c8eb5mr97782415ab.1.1759180672727;
        Mon, 29 Sep 2025 14:17:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFTF4nahZRRX2gicTqxhxWdWKeUzRDCgsQQuCRfxHGJ4HNrczL75firr5hrFe4LKeaKRuPCNA==
X-Received: by 2002:a05:6e02:1523:b0:425:9068:4ff with SMTP id e9e14a558f8ab-425955c8eb5mr97782155ab.1.1759180672251;
        Mon, 29 Sep 2025 14:17:52 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-425c05476fasm62141985ab.43.2025.09.29.14.17.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 14:17:51 -0700 (PDT)
Date: Mon, 29 Sep 2025 15:17:49 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Leon Romanovsky <leonro@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Andrew Morton <akpm@linux-foundation.org>, Bjorn Helgaas
 <bhelgaas@google.com>, Christian =?UTF-8?B?S8O2bmln?=
 <christian.koenig@amd.com>, dri-devel@lists.freedesktop.org,
 iommu@lists.linux.dev, Jens Axboe <axboe@kernel.dk>, Joerg Roedel
 <joro@8bytes.org>, kvm@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, linux-mm@kvack.org, linux-pci@vger.kernel.org,
 Logan Gunthorpe <logang@deltatee.com>, Marek Szyprowski
 <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Sumit
 Semwal <sumit.semwal@linaro.org>, Vivek Kasireddy
 <vivek.kasireddy@intel.com>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH v4 10/10] vfio/pci: Add dma-buf export support for MMIO
 regions
Message-ID: <20250929151749.2007b192.alex.williamson@redhat.com>
In-Reply-To: <53f3ea1947919a5e657b4f83e74ca53aa45814d4.1759070796.git.leon@kernel.org>
References: <cover.1759070796.git.leon@kernel.org>
	<53f3ea1947919a5e657b4f83e74ca53aa45814d4.1759070796.git.leon@kernel.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 28 Sep 2025 17:50:20 +0300
Leon Romanovsky <leon@kernel.org> wrote:
> +static int validate_dmabuf_input(struct vfio_pci_core_device *vdev,
> +				 struct vfio_device_feature_dma_buf *dma_buf,
> +				 struct vfio_region_dma_range *dma_ranges,
> +				 struct p2pdma_provider **provider)
> +{
> +	struct pci_dev *pdev = vdev->pdev;
> +	u32 bar = dma_buf->region_index;
> +	resource_size_t bar_size;
> +	u64 sum;
> +	int i;
> +
> +	if (dma_buf->flags)
> +		return -EINVAL;
> +	/*
> +	 * For PCI the region_index is the BAR number like  everything else.
> +	 */
> +	if (bar >= VFIO_PCI_ROM_REGION_INDEX)
> +		return -ENODEV;
> +
> +	*provider = pcim_p2pdma_provider(pdev, bar);
> +	if (!provider)

This needs to be IS_ERR_OR_NULL() or the function needs to settle on a
consistent error return value regardless of CONFIG_PCI_P2PDMA.

> +		return -EINVAL;
> +
> +	bar_size = pci_resource_len(pdev, bar);

We get to this feature via vfio_pci_core_ioctl_feature(), which is used
by several variant drivers, some of which mangle the BAR size exposed
to the user, ex. hisi_acc.  I'm afraid this might actually be giving
dmabuf access to a portion of the BAR that isn't exposed otherwise.

> +	for (i = 0; i < dma_buf->nr_ranges; i++) {
> +		u64 offset = dma_ranges[i].offset;
> +		u64 len = dma_ranges[i].length;
> +
> +		if (!PAGE_ALIGNED(offset) || !PAGE_ALIGNED(len))
> +			return -EINVAL;
> +
> +		if (check_add_overflow(offset, len, &sum) || sum > bar_size)
> +			return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +int vfio_pci_core_feature_dma_buf(struct vfio_pci_core_device *vdev, u32 flags,
> +				  struct vfio_device_feature_dma_buf __user *arg,
> +				  size_t argsz)
> +{
> +	struct vfio_device_feature_dma_buf get_dma_buf = {};
> +	struct vfio_region_dma_range *dma_ranges;
> +	DEFINE_DMA_BUF_EXPORT_INFO(exp_info);
> +	struct p2pdma_provider *provider;
> +	struct vfio_pci_dma_buf *priv;
> +	int ret;
> +
> +	ret = vfio_check_feature(flags, argsz, VFIO_DEVICE_FEATURE_GET,
> +				 sizeof(get_dma_buf));
> +	if (ret != 1)
> +		return ret;
> +
> +	if (copy_from_user(&get_dma_buf, arg, sizeof(get_dma_buf)))
> +		return -EFAULT;
> +
> +	if (!get_dma_buf.nr_ranges)
> +		return -EINVAL;
> +
> +	dma_ranges = memdup_array_user(&arg->dma_ranges, get_dma_buf.nr_ranges,
> +				       sizeof(*dma_ranges));
> +	if (IS_ERR(dma_ranges))
> +		return PTR_ERR(dma_ranges);
> +
> +	ret = validate_dmabuf_input(vdev, &get_dma_buf, dma_ranges, &provider);
> +	if (ret)
> +		return ret;

goto err_free_ranges;

Thanks,
Alex


