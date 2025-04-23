Return-Path: <linux-kernel+bounces-616888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E129A99785
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Apr 2025 20:10:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E55C61B829F5
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Apr 2025 18:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C684C28E5F2;
	Wed, 23 Apr 2025 18:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="IVrkYr9O"
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ECB926982F
	for <linux-kernel@vger.kernel.org>; Wed, 23 Apr 2025 18:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745431785; cv=none; b=FoBxuOKmhLFFQqnONIf0ofCC+oLcVMdCXweHaZwAeAxhHqIvzbBqgZamGB39Aa8ix8mmBO3kgEDGgdj11Bl0685Ysklui42hWsXdLnccYuKKwi0HLctoJgkK6EP8Qg1kgoPLWPf4XhsZA+lEFvofcAW7mpSEHP8Tahow58u/BWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745431785; c=relaxed/simple;
	bh=hE07WPwFRXEpanF4skjNKxYCQC8//IXfbbfB/nEbHRQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mjounn5JJCpOYU+Ls4JhSJOj55aH/L6hwSOoxUXe6erc524kebK2xHyvpI1XbCPe4TdpWLDgh13PzgY0MKLXgcLMmcdCGN2HFq8TLOtP9v9jFT4fzK2W1Kh8Wx2TUazpE+1p15/RaX3Ls/aOqEPR6jfWmJLtJyVCL7syUKuuMSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=IVrkYr9O; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4772f48f516so14213601cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Apr 2025 11:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1745431782; x=1746036582; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kL2C8z2XNRWzrThEWzS/MGHmoZb+Ha7gcgLYUEwZduo=;
        b=IVrkYr9OWNFexnkzChtFbEeJ82sJdRjet10LDQZBoVKG/IqUWpRq7BzTKdasu8AI3J
         PCSeri9UkzzpJ1+LI1Y6kiRnEa1Ek/NB4Ich7FJ0mzXyt9CgBmJOGLAl5ioBtCS5Clyf
         yuMsHogkkJho8M0KmLH905m8setMGfwL9k3O/WfTu1YHpiFaCTRKRQxMOOTW5+CMTkYC
         XWnm/KSOpBFMryUh/g/HQiMIQ4TgQvuAQArd2c0VAzkfTSW+ViG3deDi6NI2SXwUAIbN
         zOU5F+V9WDTzr2nW5uS7HPiWohhJAl3lLqjJkpJNcs1n+QHXyW0UXhRTHKzPPjrpcgOc
         Wkow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745431782; x=1746036582;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kL2C8z2XNRWzrThEWzS/MGHmoZb+Ha7gcgLYUEwZduo=;
        b=ddodx4wDjWOfiU64IdcYI0dBWR/kq6lU+va+RkeFW3MqqZwfE/jb1A7wcTv0rl7Ujz
         aVKiKaxwMFYJPvCc9KPeHv2W2m66rc7XSdbpmLZc/P6tOyeU5gdggjH60OdbfELJWPHJ
         hElVl5GxM0N+gjijzln/bDl40yt4wpNNoFpm0Ow2e0paAM0UaDCyBScor/0qRVSmBOVp
         JCKTPgZfu6755TcVOYdQ0WKejbhctS2D0GHZst+Hy0WLJ+o0+YlXLne67OwckoNZXA+T
         CjxEia+SduoFWjwmUUe0w8qyoQym+BZzslrAclnGac8MvEWXhYA7yQdHPDXf/Vzqjvrc
         hGfQ==
X-Forwarded-Encrypted: i=1; AJvYcCWMLvdsmf8JXkjDMiCsgKusBvJQZqL2TfWl0EHblDJtWk0ntPC6zcEpjLKEkcYRMnjzUk/V4hg7V/Ht0NQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwupzF3KiC1dHqwKO0MpQxG3nY0LjwXJysxum1vNtKMQ49hOMNR
	lWogbroHzTL6Uyt+80GjMeoC6kODrEaydhb9DGxUqZdlRmV9hgn5kkT7zz3clPo=
X-Gm-Gg: ASbGncsCFNOrqfvLNsGXhczKvKiCNqRc3JN/z1I380YcpqGxVIQMzP+ddsgEr3hkg9Z
	oDDovtAeuAypLeTrDXtFUCMa7xv95OSdJr/Jp5xIHmhaq4tnx++Q3ttv21450/avo/+iZYc3EFI
	NKvWbmy0GqUUxE9Mp34oeY4gXrhVXsQjNiHJ9/niUo96nw4LlmOz1s3SY1CQmIMos+N5psfJbCa
	yi9bturPgzkkidGli0O3OFvQ5vayBUGi2FgXy0LRhAV77YX9rcgwPdZfwwgq8kk3NA7yYEE8n+e
	b1MOkWRkR9ha+vF1uhOhUk8vVAeuJtTxV+zGdDnmYNK8cKxXsTADebTpXyPTriTZ7l3wpoED59i
	Bmr2XzQcgWQwEL2Bx4sw=
X-Google-Smtp-Source: AGHT+IH4xfxeCQIatfvhUgdAx8fM2pKJgYvLzginEQw7PV9Sr3aShEQ97+Q+stgMKvhEecV5S0qx4w==
X-Received: by 2002:a05:622a:248d:b0:477:84f5:a0b with SMTP id d75a77b69052e-47e780b3d65mr2842901cf.2.1745431782337;
        Wed, 23 Apr 2025 11:09:42 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-219-86.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.219.86])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-47ae9c3b485sm71764181cf.27.2025.04.23.11.09.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 11:09:41 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1u7eXV-00000007LuW-1WeA;
	Wed, 23 Apr 2025 15:09:41 -0300
Date: Wed, 23 Apr 2025 15:09:41 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Leon Romanovsky <leon@kernel.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Leon Romanovsky <leonro@nvidia.com>, Jake Edge <jake@lwn.net>,
	Jonathan Corbet <corbet@lwn.net>, Zhu Yanjun <zyjzyj2000@gmail.com>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	=?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
	iommu@lists.linux.dev, linux-nvme@lists.infradead.org,
	linux-pci@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH v9 17/24] vfio/mlx5: Enable the DMA link API
Message-ID: <20250423180941.GS1213339@ziepe.ca>
References: <cover.1745394536.git.leon@kernel.org>
 <b7a11f0e93a4b244523e07b82475a7616ba739c9.1745394536.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b7a11f0e93a4b244523e07b82475a7616ba739c9.1745394536.git.leon@kernel.org>

On Wed, Apr 23, 2025 at 11:13:08AM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Remove intermediate scatter-gather table completely and
> enable new DMA link API.
> 
> Tested-by: Jens Axboe <axboe@kernel.dk>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/vfio/pci/mlx5/cmd.c  | 298 ++++++++++++++++-------------------
>  drivers/vfio/pci/mlx5/cmd.h  |  21 ++-
>  drivers/vfio/pci/mlx5/main.c |  31 ----
>  3 files changed, 147 insertions(+), 203 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

> +static int register_dma_pages(struct mlx5_core_dev *mdev, u32 npages,
> +			      struct page **page_list, u32 *mkey_in,
> +			      struct dma_iova_state *state,
> +			      enum dma_data_direction dir)
> +{
> +	dma_addr_t addr;
> +	size_t mapped = 0;
> +	__be64 *mtt;
> +	int i, err;
>  
> -	return mlx5_core_create_mkey(mdev, mkey, mkey_in, inlen);
> +	WARN_ON_ONCE(dir == DMA_NONE);
> +
> +	mtt = (__be64 *)MLX5_ADDR_OF(create_mkey_in, mkey_in, klm_pas_mtt);
> +
> +	if (dma_iova_try_alloc(mdev->device, state, 0, npages * PAGE_SIZE)) {
> +		addr = state->addr;
> +		for (i = 0; i < npages; i++) {
> +			err = dma_iova_link(mdev->device, state,
> +					    page_to_phys(page_list[i]), mapped,
> +					    PAGE_SIZE, dir, 0);
> +			if (err)
> +				goto error;
> +			*mtt++ = cpu_to_be64(addr);
> +			addr += PAGE_SIZE;
> +			mapped += PAGE_SIZE;
> +		}

This is an area I'd like to see improvement on as a follow up.

Given we know we are allocating contiguous IOVA we should be able to
request a certain alignment so we can know that it can be put into the
mkey as single mtt. That would eliminate the double translation cost in
the HW.

The RDMA mkey builder is able to do this from the scatterlist but the
logic to do that was too complex to copy into vfio. This is close to
being simple enough, just the alignment is the only problem.

Jason

