Return-Path: <linux-kernel+bounces-751285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DDB96B1673E
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 21:59:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D100C1C2094F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 19:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DD67218E9F;
	Wed, 30 Jul 2025 19:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zwipy1d/"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9ED0212FB7
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 19:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753905534; cv=none; b=hbMgyiQGQ+wepEC/u92Vt5G/+JzYkYU/HIJ6+20OQCu7WFXL/GsTKJcgJJGlmFRvqdq/xUbvVtBEiPRypHLvUen8BY0gVsPT+Drx+nLtGO1qu3K7wLWNW58B9TNnESRnv9OFToF+gVp0Vyrt7JGkzoT8gArCC7EYathaPM8W3uI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753905534; c=relaxed/simple;
	bh=CG5SKXa8zPOQn3DCX5/e8odAxj8sWImHdXc+IA7A+Io=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fF3yFJxLMei06PhBGwGptDHMbIhCvR7rNCWABqxKYUFKR7Hj7hwFXj5qYHYbAleQMV89JGvtMYqSIXZLG3enUWJUBf5+7xcGQikNe3uXBfH/aApJju5HdMeItmog5sAMT+XfAYDq1TBIoPvQIDHSusXy+Q/r5cYtbRokfSM5nTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Zwipy1d/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753905531;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MJ8yWqGXhru7WhV5DGnUZnDJthF7Yg1ZkZASyV+JWoM=;
	b=Zwipy1d/+aYeX49YUl3RPWoAUZbooFhei0QjfGCwO7B6gicBefkcYFOHLVp3nRcdVyAnK8
	fz9dbP/EKgOzMP/UlVW7s06aAtjY3f8I+AnGHnlKsxTV+SZKY9U+K8UdHAtu69hNexPuN+
	a5nOYkou2V0wu0FmawyGX5zof/5RgdY=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-393-nPuyICfVODufcwQE3lwpyg-1; Wed, 30 Jul 2025 15:58:50 -0400
X-MC-Unique: nPuyICfVODufcwQE3lwpyg-1
X-Mimecast-MFC-AGG-ID: nPuyICfVODufcwQE3lwpyg_1753905530
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-87c6cba5c79so3657539f.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 12:58:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753905529; x=1754510329;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MJ8yWqGXhru7WhV5DGnUZnDJthF7Yg1ZkZASyV+JWoM=;
        b=L/rf5L6FweEMhUpV70KeylUPwK7xEYiBjF6UEoeZ6uTEbf1vAM9JKsZitmgyboI1Ds
         z1iHE7hmuvQl6kBg9l2+/7+J8bJ69Eo07XoDj5VeP+XlA218bZY/YvW5kaxKCo8969m0
         2dTiBf2WXLFDo5b0hWehO7YW04jXWqmiMmJM0g6wHhdd9hpWDNQgQ+prWPufhjXsjTik
         DAU5dbSIFCpoTbIjWmTlm1Bg+VYCbl77B94pG5lwloIMUvz9dkRk9/+ekvBnVfRS9ZwG
         njNfdmknRhl6QBSo6JBP7uGVu6Eqi7ANgF30AJNmWMbffDEWh1TCwac/a3u0mG0Rz75C
         C+ow==
X-Forwarded-Encrypted: i=1; AJvYcCVeywGkZwWhyGOAV9VfmgeNo/PfxLDplgnTcWPA1VTz1EFpEWL4jg9Rsuu8noL5KjeSXqNJynsyMOEg8s4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3sRsf8XKvMfGdTjvA57fm+yWySpGfZZyEHkoQnxx0AwgBIL9a
	SeHBF1TAhq5VOHj6Dt84biMJ+vkybHvRKagy3USsEoDvW7x1p4NRtBnHSruwbZpyb1FwavGfvLb
	FSpkXp2AjZFAGD4twkiJXHM0SVLtaDE0/arex/mw95NQPgFM/SaFiMCj3WnbhVRerbQ==
X-Gm-Gg: ASbGnctCZwbz6OPyqaiIegAa7QlAGWwx10IZ0Eu0YNzQ/CqM82+ikKtfKU8BP85o2b1
	g5dHk6ksLK2X5uPyagPCAnB4fAs2oyw+e6if5v9XzjwuefIUf0o3c047NONIaDnJQIVpTFbupiM
	CDJbnLW8VC7924X1YaYKIw9y3DGwp2O3lXoRTwmmJOUcA5Zznk70ScpeVUPVwhEfeo+de3XyjSJ
	d/Q9NsGbyjuK58wZ4rHdynWmPGoDpCqJFYv/YW3BdulSGiI5M8UFINj/J/QXehUrB306qZFnoY/
	HC7Hb5bIZBwLspPHk800cB1ROQOQ99BpeeGA5R1X8uo=
X-Received: by 2002:a05:6602:3403:b0:85b:544c:ba6c with SMTP id ca18e2360f4ac-88137489c1bmr247639039f.1.1753905529658;
        Wed, 30 Jul 2025 12:58:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEqzTNDwtWgU4diezEDNzfWAqDpdNRdRLffgeb0LuFILxM3AuzO6OxVkpYobVhQ8ZrxcWgziA==
X-Received: by 2002:a05:6602:3403:b0:85b:544c:ba6c with SMTP id ca18e2360f4ac-88137489c1bmr247635939f.1.1753905529204;
        Wed, 30 Jul 2025 12:58:49 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-50a55da3278sm19521173.84.2025.07.30.12.58.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 12:58:48 -0700 (PDT)
Date: Wed, 30 Jul 2025 13:58:46 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Leon Romanovsky <leonro@nvidia.com>, Christoph Hellwig <hch@lst.de>,
 Jason Gunthorpe <jgg@nvidia.com>, Andrew Morton
 <akpm@linux-foundation.org>, Bjorn Helgaas <bhelgaas@google.com>, Christian
 =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 dri-devel@lists.freedesktop.org, iommu@lists.linux.dev, Jens Axboe
 <axboe@kernel.dk>, =?UTF-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
 Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 linux-mm@kvack.org, linux-pci@vger.kernel.org, Logan Gunthorpe
 <logang@deltatee.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Robin
 Murphy <robin.murphy@arm.com>, Sumit Semwal <sumit.semwal@linaro.org>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH 00/10] vfio/pci: Allow MMIO regions to be exported
 through dma-buf
Message-ID: <20250730135846.2208fe89.alex.williamson@redhat.com>
In-Reply-To: <cover.1753274085.git.leonro@nvidia.com>
References: <cover.1753274085.git.leonro@nvidia.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 23 Jul 2025 16:00:01 +0300
Leon Romanovsky <leon@kernel.org> wrote:

> From: Leon Romanovsky <leonro@nvidia.com>
> 
> ---------------------------------------------------------------------------
> Based on blk and DMA patches which will be sent during coming merge window.
> ---------------------------------------------------------------------------
> 
> This series extends the VFIO PCI subsystem to support exporting MMIO regions
> from PCI device BARs as dma-buf objects, enabling safe sharing of non-struct
> page memory with controlled lifetime management. This allows RDMA and other
> subsystems to import dma-buf FDs and build them into memory regions for PCI
> P2P operations.
> 
> The series supports a use case for SPDK where a NVMe device will be owned
> by SPDK through VFIO but interacting with a RDMA device. The RDMA device
> may directly access the NVMe CMB or directly manipulate the NVMe device's
> doorbell using PCI P2P.
> 
> However, as a general mechanism, it can support many other scenarios with
> VFIO. This dmabuf approach can be usable by iommufd as well for generic
> and safe P2P mappings.

I think this will eventually enable DMA mapping of device MMIO through
an IOMMUFD IOAS for the VM P2P use cases, right?  How do we get from
what appears to be a point-to-point mapping between two devices to a
shared IOVA between multiple devices?  I'm guessing we need IOMMUFD to
support something like IOMMU_IOAS_MAP_FILE for dma-buf, but I can't
connect all the dots.  Thanks,

Alex


