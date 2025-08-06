Return-Path: <linux-kernel+bounces-758406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77114B1CE96
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 23:42:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8581F3B401C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 21:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08B6A230BFD;
	Wed,  6 Aug 2025 21:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HZ4AummV"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F48C22D7B1
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 21:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754516544; cv=none; b=WevrThWJANpje6eQ/jk4MezlPFEtkF8A8m6oJhVxdbdES7VZsh2NkKd4Sz0BQNQshwgPNJCG/iYSXnlkasCVVktPr/c4VQ4UDqxreb0Gmo/3h/7AQDM8jglmBulhYw/DfDw7gH6rRcqdYlvqHcaBtWrtNbOiry7phr8SNRaIZ0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754516544; c=relaxed/simple;
	bh=u5wJkgayWtoH/wDIjbh042FOJb9qmim8x01zf6tfYcg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qi70YtaPKDbzxaVbxyg3LSHYMkCl7wz7oHCeRnBHwAMl3uN9bS55Ix+tP59GmMGfq7VCWeeWvj9UaSN59kaZjxI/DqXpo1Rz4MVDk7aDkHsbSQskOJuYXrjMOVcRVsTOA0u+shBa2Gk2NspYYuZNzRLcEQqmRWa0Fnbb+SBNgYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HZ4AummV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754516541;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UEyeHS4HV3rZ/wSqVLFMAOzjnboPPP41DAzDFsrqTZs=;
	b=HZ4AummViE6oH34N9v6KfBakeYn+Q0xFpfwJDcs9+K1TdIr0HRmRqSni259C5C5K4VsmlS
	S5tBZPvB7BNv/J/5sL6bC6pSS4j8N8LE1RVwGjmFAXTjTU7/5ATTDG1wADhWk3p+vCgvxt
	bkMZMvw4aVB7stsrsnOvioJH1Ehv+Eg=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-Vy3EGIqdOrCnL8D1xzzM1A-1; Wed, 06 Aug 2025 17:42:18 -0400
X-MC-Unique: Vy3EGIqdOrCnL8D1xzzM1A-1
X-Mimecast-MFC-AGG-ID: Vy3EGIqdOrCnL8D1xzzM1A_1754516538
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-73e41783876so22560a34.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 14:42:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754516538; x=1755121338;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UEyeHS4HV3rZ/wSqVLFMAOzjnboPPP41DAzDFsrqTZs=;
        b=i3SU+kZ0QbcGR5deNDzlrvOshrMU6sD2zBJ1BFkT13PgODo1u3pjGkb1ThJiLu98Iq
         I3ecCb0PPPgyVGKkY42MQRwUx1QQistqF2eouhZO2x00Zl2kOPCo5t6P5WK4yLYWKRSx
         YPMbsHn61Aiq72qbmrZnCygwq8kHcc5dPm/LGBp0tk8aMrD2jSelTM74Amt09eBChyTB
         YgCBhHJbe967QDh0sqsXooU8YEKnlrrcMitnEO2EtEGWszCWCdeoRvX45Mg1XDv1tWRB
         ha12Yp60mfanwYW/q7YdEcuFYtJbuHGs6WUDbvc0h8Xo8L+tQMUse3oPOca5lAot3ymj
         lzxQ==
X-Forwarded-Encrypted: i=1; AJvYcCUmHlzvCYPv4jBYNDe+LyY6jTV7idSkL9f+bcMSiM01LaAU6ZQV+Uawza6qVFTV6bUjJjbVG4MUIF23gf4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpkJOu+SU0nstzFp3/LsPUzP/J68pz7x71H3rVSCuqxPLYDzbf
	ocQNN6V+uNlbl0mSjPK7RVWnGUF2ldw/SRqc5tJmNtpjWiAfWAje6ucuOD3Aje4ETF1b8cWW6ra
	X3np8N4OFyB/OwWt6BKPefLsFEVPu9pgzhRf8P1g8o4+lP6X0WzrEG4W+11wGvUaDfQ==
X-Gm-Gg: ASbGnctcZHKZDYWBAyizMBncil0d+sMTD9L6Da045vYdFhno+WSc5MFPHVY4KnM1OBT
	1vvnnRTFE0u2su3nUi2oMEWq9u2vd81zCtgbWA0/pe/tib6NEi7AJG6AAz1LDgmiOijG4MBYnOq
	fu3fPe91RRiaStUvuGr6YGzSsbIIjcFVPVwc91GwtfvlRApCt6LgEBmtkI+YygpmZOawUGnNj0e
	9oLvGarbjDfZwPmCgbNMX1FOVaCzWOdNQBDfTRSqqIQiZ06a8dj5Yyj/9D/mTeic9wzAeGUsb05
	6K7pRd7Nw1bamCvKoem/VPBJcNxts5Ps3ZIbnHewobE=
X-Received: by 2002:a05:6830:3145:b0:741:a217:720f with SMTP id 46e09a7af769-7430e2000b0mr942369a34.2.1754516537614;
        Wed, 06 Aug 2025 14:42:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH5QU5ZQlpYSxfTPMUFCWfqP/wnHyNw5oOZqDg/+tC9OzPbWJoK2cj/jTsdC9+aUwDUHNbnjQ==
X-Received: by 2002:a05:6830:3145:b0:741:a217:720f with SMTP id 46e09a7af769-7430e2000b0mr942353a34.2.1754516537077;
        Wed, 06 Aug 2025 14:42:17 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-74186cc4e1bsm3606901a34.21.2025.08.06.14.42.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 14:42:16 -0700 (PDT)
Date: Wed, 6 Aug 2025 15:42:14 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Leon Romanovsky <leonro@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Andrew Morton <akpm@linux-foundation.org>, Bjorn Helgaas
 <bhelgaas@google.com>, Christian =?UTF-8?B?S8O2bmln?=
 <christian.koenig@amd.com>, Christoph Hellwig <hch@lst.de>,
 dri-devel@lists.freedesktop.org, iommu@lists.linux.dev, Jens Axboe
 <axboe@kernel.dk>, Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 linux-mm@kvack.org, linux-pci@vger.kernel.org, Logan Gunthorpe
 <logang@deltatee.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Robin
 Murphy <robin.murphy@arm.com>, Sumit Semwal <sumit.semwal@linaro.org>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH v1 04/10] PCI/P2PDMA: Refactor to separate core P2P
 functionality from memory allocation
Message-ID: <20250806154214.1c2618e8.alex.williamson@redhat.com>
In-Reply-To: <cab5f1bfd64becafcc887107bb4386f2c8630ef3.1754311439.git.leon@kernel.org>
References: <cover.1754311439.git.leon@kernel.org>
	<cab5f1bfd64becafcc887107bb4386f2c8630ef3.1754311439.git.leon@kernel.org>
Organization: Red Hat
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  4 Aug 2025 16:00:39 +0300
Leon Romanovsky <leon@kernel.org> wrote:

> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Refactor the PCI P2PDMA subsystem to separate the core peer-to-peer DMA
> functionality from the optional memory allocation layer. This creates a
> two-tier architecture:
> 
> The core layer provides P2P mapping functionality for physical addresses
> based on PCI device MMIO BARs and integrates with the DMA API for
> mapping operations. This layer is required for all P2PDMA users.
> 
> The optional upper layer provides memory allocation capabilities
> including gen_pool allocator, struct page support, and sysfs interface
> for user space access.
> 
> This separation allows subsystems like VFIO to use only the core P2P
> mapping functionality without the overhead of memory allocation features
> they don't need. The core functionality is now available through the
> new pci_p2pdma_enable() function that returns a p2pdma_provider
> structure.
> 
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/pci/p2pdma.c       | 118 ++++++++++++++++++++++++++-----------
>  include/linux/pci-p2pdma.h |   5 ++
>  2 files changed, 89 insertions(+), 34 deletions(-)
> 
> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
> index 176a99232fdca..24a6c8ff88520 100644
> --- a/drivers/pci/p2pdma.c
> +++ b/drivers/pci/p2pdma.c
> @@ -25,11 +25,12 @@ struct pci_p2pdma {
>  	struct gen_pool *pool;
>  	bool p2pmem_published;
>  	struct xarray map_types;
> +	struct p2pdma_provider mem;
>  };
>  
>  struct pci_p2pdma_pagemap {
>  	struct dev_pagemap pgmap;
> -	struct p2pdma_provider mem;
> +	struct p2pdma_provider *mem;
>  };
>  
>  static struct pci_p2pdma_pagemap *to_p2p_pgmap(struct dev_pagemap *pgmap)
> @@ -204,7 +205,7 @@ static void p2pdma_page_free(struct page *page)
>  	struct pci_p2pdma_pagemap *pgmap = to_p2p_pgmap(page_pgmap(page));
>  	/* safe to dereference while a reference is held to the percpu ref */
>  	struct pci_p2pdma *p2pdma = rcu_dereference_protected(
> -		to_pci_dev(pgmap->mem.owner)->p2pdma, 1);
> +		to_pci_dev(pgmap->mem->owner)->p2pdma, 1);
>  	struct percpu_ref *ref;
>  
>  	gen_pool_free_owner(p2pdma->pool, (uintptr_t)page_to_virt(page),
> @@ -227,44 +228,82 @@ static void pci_p2pdma_release(void *data)
>  
>  	/* Flush and disable pci_alloc_p2p_mem() */
>  	pdev->p2pdma = NULL;
> -	synchronize_rcu();
> +	if (p2pdma->pool)
> +		synchronize_rcu();
> +	xa_destroy(&p2pdma->map_types);
> +
> +	if (!p2pdma->pool)
> +		return;
>  
>  	gen_pool_destroy(p2pdma->pool);
>  	sysfs_remove_group(&pdev->dev.kobj, &p2pmem_group);
> -	xa_destroy(&p2pdma->map_types);
>  }
>  
> -static int pci_p2pdma_setup(struct pci_dev *pdev)
> +/**
> + * pci_p2pdma_enable - Enable peer-to-peer DMA support for a PCI device
> + * @pdev: The PCI device to enable P2PDMA for
> + *
> + * This function initializes the peer-to-peer DMA infrastructure for a PCI
> + * device. It allocates and sets up the necessary data structures to support
> + * P2PDMA operations, including mapping type tracking.
> + */
> +struct p2pdma_provider *pci_p2pdma_enable(struct pci_dev *pdev)
>  {
> -	int error = -ENOMEM;
>  	struct pci_p2pdma *p2p;
> +	int ret;
> +
> +	p2p = rcu_dereference_protected(pdev->p2pdma, 1);
> +	if (p2p)
> +		/* PCI device was "rebound" to the driver */
> +		return &p2p->mem;
>  
>  	p2p = devm_kzalloc(&pdev->dev, sizeof(*p2p), GFP_KERNEL);
>  	if (!p2p)
> -		return -ENOMEM;
> +		return ERR_PTR(-ENOMEM);
>  
>  	xa_init(&p2p->map_types);
> +	p2p->mem.owner = &pdev->dev;
> +	/* On all p2p platforms bus_offset is the same for all BARs */
> +	p2p->mem.bus_offset =
> +		pci_bus_address(pdev, 0) - pci_resource_start(pdev, 0);

But not all devices implement BAR0, nor is BAR0 necessarily in the
memory space, wouldn't this calculation be wrong if BAR0 were
unimplemented or an IO BAR?  Even within memory BARs I can imagine
different translations for 32 vs 64 bit, prefetch vs non-prefetch, but
per the comment I guess we're excluding those.  Thanks,

Alex


