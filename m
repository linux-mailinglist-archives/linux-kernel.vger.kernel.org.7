Return-Path: <linux-kernel+bounces-836818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32371BAAA26
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 23:18:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BCDB1711EC
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 21:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D3B72594BE;
	Mon, 29 Sep 2025 21:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PRqBoWWm"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E36223DDD
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 21:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759180669; cv=none; b=jD2rO0zUPc4GvWpeBQW0pRp/IR0DyT9EKTtYhg3nf0do3Y7iCd/tMK+Zgyx/7oa6r87cSiL5XNetYRbLxZ6f1TcECkmcaPGxXNt+UL2+mZOYwX97gOnMApbyzqVuDymf82OTmNxPDiPeSZgewlud8ddW5BRuVScYFuFtI4Io1hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759180669; c=relaxed/simple;
	bh=fo8uROp6Yd4p51oNun07BdvS3ckFl/pgBYhRp5v8n58=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cUqyDXDIDsPQSVeBDd3cwPpqQCCVDHRSJilElBw2cE7UxWUY/WkJTfs5G9x36ZCh5hb1EHjp3bnPtgskj5pDBN+DWxSZFCTfR3EeZF7MsTYGJzEYv2NDD7PH5WpJS7cEqWeSYC6IgcqH/hs8Z7iH/fyoSMOvetdLyMBK/K9pgyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PRqBoWWm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759180666;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pvJsfDbbmraa6iCCkjoqVoBB3Mb9XdjPoCcVP3qHFzU=;
	b=PRqBoWWmZf9bx5sAghO/yeCFDa5/DCJV29BNJOZgQLBDdtur8MTCn2aL82tGx5VSg4BjpN
	69uZtADX1TPTW6es+SlAUKdZaSk3Mr+Y0u+HfSpnHONjIflQ46OV0LnGkEzg5hRih9K1EJ
	kugIpO5FE+bgDTpyByJUKJCCmdjd4u8=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-187-PDmCjdlzMqeIxiE_H_RMmg-1; Mon, 29 Sep 2025 17:17:45 -0400
X-MC-Unique: PDmCjdlzMqeIxiE_H_RMmg-1
X-Mimecast-MFC-AGG-ID: PDmCjdlzMqeIxiE_H_RMmg_1759180664
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-4248bfd20faso13820545ab.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 14:17:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759180664; x=1759785464;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pvJsfDbbmraa6iCCkjoqVoBB3Mb9XdjPoCcVP3qHFzU=;
        b=KWgkOVoz2p+Q+T/kPzewCTxD6BCyhzGRUNPhxcVuTwhf3/I907Xjd/qeyXebyPqoi7
         lnH42DCjwNjedOx/mX/FdWeODoTcai1Xy61MYRy4Zou7LUGy7uEuvZqtVC0MJZjWVlsV
         ZGBwvE77WY2k3JtVHp1Rsfm7RLMUNuvP3RTtv4knYksf3UMJPWgQhWAYOvURc23fsK/J
         XCLW1ULThHw3Y2Hr+37GQmG089K4mKz+ixC5hB8nJkmh3pIhrDgrJ/DTwNuUoigbOedd
         Z/jqJucaP/weJmZB70M1yHMl575m+JQ7YUW1Ml4waG+tKEvnVw9to5GnaloP8X9LfX+Q
         rNbg==
X-Forwarded-Encrypted: i=1; AJvYcCXYqVveA2w9BlfW1KEkeFxNeK8S00lb5lmjsLzRBVc3b0d5BRCOW+CxJ5UXtcxwSM02yxN36lbX3WC/wA4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxV73wyi6MGgZ9jT44fA1QSAJpaU86Y10rSYJLwsDiCQoYFUCBq
	0O7uAHd8y9ywXRmsaySPTqXd9FJtUHty5oj9GUK/MfbKive4yhhNim1kDzlXEOnSnD7m3/63tR3
	U3wt7dmaATD+aqz+0IgJUTtODpFyk5mIZBvgsEUb3V5miUUKL+tL+3TtbQrm/l62Q9g==
X-Gm-Gg: ASbGncsKG9VaF1l6O8LnfEQ4OcQDdqKrzirx6698dH0qejtCl6fJ0fK63PcofstW+nY
	Lxpa9rO9uSol+5MTWMKj7ybr0QstLq2pYDza/vQtYaZsP6gq5V10UY6pFKzLlIA8JZiSOp6TnV8
	lmRhpjd5cwonv+rSOD0y6iuQ8/T4rn3IcI6OYntK3MtAfHkGj6VSPvFroYLL1BSjBlvBKysqmMl
	7DdLYcH02PXeV+pT75oinWzyK0qRJtr3minPBpgxnIPuBce41kSQapVzk6zF4DiYzKJQz6ev1g+
	JWavLrmdcwmx/eNXP8dvBnpEleSgrzmTADgEZWoJ2MY=
X-Received: by 2002:a05:6e02:1525:b0:408:1624:b2ee with SMTP id e9e14a558f8ab-425955e4f60mr87964855ab.1.1759180664139;
        Mon, 29 Sep 2025 14:17:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG3VrvxaH7k00bkTZJWrxcv/Xeuv7Ik/zOnPnH3ASkfKmA5ptZ34qoyLfGaDXRfunQjFfs8kg==
X-Received: by 2002:a05:6e02:1525:b0:408:1624:b2ee with SMTP id e9e14a558f8ab-425955e4f60mr87964675ab.1.1759180663680;
        Mon, 29 Sep 2025 14:17:43 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-57269f5d0c5sm1963571173.13.2025.09.29.14.17.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 14:17:42 -0700 (PDT)
Date: Mon, 29 Sep 2025 15:17:40 -0600
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
Subject: Re: [PATCH v4 07/10] vfio/pci: Add dma-buf export config for MMIO
 regions
Message-ID: <20250929151740.21f001e3.alex.williamson@redhat.com>
In-Reply-To: <b1b44823f93fd9e7fa73dc165141d716cb74fa90.1759070796.git.leon@kernel.org>
References: <cover.1759070796.git.leon@kernel.org>
	<b1b44823f93fd9e7fa73dc165141d716cb74fa90.1759070796.git.leon@kernel.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 28 Sep 2025 17:50:17 +0300
Leon Romanovsky <leon@kernel.org> wrote:

> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Add new kernel config which indicates support for dma-buf export
> of MMIO regions, which implementation is provided in next patches.
> 
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/vfio/pci/Kconfig | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/drivers/vfio/pci/Kconfig b/drivers/vfio/pci/Kconfig
> index 2b0172f54665..55ae888bf26a 100644
> --- a/drivers/vfio/pci/Kconfig
> +++ b/drivers/vfio/pci/Kconfig
> @@ -55,6 +55,26 @@ config VFIO_PCI_ZDEV_KVM
>  
>  	  To enable s390x KVM vfio-pci extensions, say Y.
>  
> +config VFIO_PCI_DMABUF
> +	bool "VFIO PCI extensions for DMA-BUF"
> +	depends on VFIO_PCI_CORE
> +	depends on PCI_P2PDMA && DMA_SHARED_BUFFER
> +	default y
> +	help
> +	  Enable support for VFIO PCI extensions that allow exporting
> +	  device MMIO regions as DMA-BUFs for peer devices to access via
> +	  peer-to-peer (P2P) DMA.
> +
> +	  This feature enables a VFIO-managed PCI device to export a portion
> +	  of its MMIO BAR as a DMA-BUF file descriptor, which can be passed
> +	  to other userspace drivers or kernel subsystems capable of
> +	  initiating DMA to that region.
> +
> +	  Say Y here if you want to enable VFIO DMABUF-based MMIO export
> +	  support for peer-to-peer DMA use cases.
> +
> +	  If unsure, say N.
> +
>  source "drivers/vfio/pci/mlx5/Kconfig"
>  
>  source "drivers/vfio/pci/hisilicon/Kconfig"

This is only necessary if we think there's a need to build a kernel with
P2PDMA and VFIO_PCI, but not VFIO_PCI_DMABUF.  Does that need really
exist?

I also find it unusual to create the Kconfig before adding the
supporting code.  Maybe this could be popped to the end or rolled into
the last patch if we decided to keep it.  Thanks,

Alex


