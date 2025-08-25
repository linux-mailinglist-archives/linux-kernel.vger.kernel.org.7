Return-Path: <linux-kernel+bounces-783934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BF3AB33478
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 05:19:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B5B5189D69F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 03:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFEF91C84DE;
	Mon, 25 Aug 2025 03:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KOlZUR7M"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989FD22A1C5
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 03:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756091949; cv=none; b=cfqrYhqpJPRN06Tc5eO2KTSi1IZNoWsfooCpULGb+s9QKDyJf2zFe8NLVNF0wnW+yth/yKtJIceE0n1NnzkSiuzYIRNgD2MYwnLPulO9cTD+zPiKXuQ1WsFmvynDnk/vLDAx3y/l+AoGCahH297lYv+AZrwcR4SxJ6Z+jnZf9/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756091949; c=relaxed/simple;
	bh=PuUbuNvyeLiLOXqEFw4faj6HQcjwdCPqnfZaWCW/qkc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aVJpYSattXcSdkX3HNcqgbkFpHBOoSzbbFO0wst+BpAnhR37+Eb5V7vLs8E4yDqNzC3mluasuPYQ+VBBp5masia8uxJVJM/8jjXLmkdVmYh22+lMnbhWNTnaLx3GV09s8wmBKaqbJDoaSck/7UPaHpfW0lUfuP5xL06NJsHtKyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KOlZUR7M; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756091944;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mkkr6dnBIuydFfXmGU4SfGiQP5HauMl51h1/p3ffeuI=;
	b=KOlZUR7Mzn7snHYO+J94jyyhDDSy6wvuaUtCVm0l/oHcnua2Rm3ZioUGO7U0/VM/FjlpxU
	gv5JndLtJgJI4Sf8LlgoXEkfu+tnxFVNq0iQaE6FWkN9YFIBrZPK5RBIeylRvrnubmbqUH
	ZdcP1/UfzunlvOEwv/ibtQO6QRQMFZM=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-62-QoeG8OU4PYKDeyDJ_J-Png-1; Sun, 24 Aug 2025 23:19:02 -0400
X-MC-Unique: QoeG8OU4PYKDeyDJ_J-Png-1
X-Mimecast-MFC-AGG-ID: QoeG8OU4PYKDeyDJ_J-Png_1756091942
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-618b3c750baso2849795a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 24 Aug 2025 20:19:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756091941; x=1756696741;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mkkr6dnBIuydFfXmGU4SfGiQP5HauMl51h1/p3ffeuI=;
        b=fXS+nzaoXnXxv80D3tllWOARY/iOTbfyMlJFnzXip7aWHdR2EMxz5OoAxB14Tib6SD
         xZ4d2qcnhNt62b1OhX68fRO4SqB4h13TM5CRz8qzWRdK6p9JFWbPhxlCWQm7wCo9QInZ
         R9lgL1WJKUoZ9p484ZzL4sBerCMoSGkUTgYE5FW3p7dMCoBlJToAj3ijLwZ1VoifOi4o
         9E6BOG7VCY6m6ROzLV1pC+4T2WgUK+bcbKF5QtykGAjFD2Dqgs0vaiHsfUWtLk39mT8h
         EIjPsu2K9IrH74XhW33/8Txx8XHaiFcu1PMNo1PfSmA7yn3W1U5Stm1R0GONl4Aa8Mc5
         DKVg==
X-Forwarded-Encrypted: i=1; AJvYcCXMozi2xYLG19wTaz0ACpVlQHVzH3bS7RQkzMdhvjEbbE3Rb4rhsCa88EmvJJb1+Wnu6U8cpfi3R56DF9k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEhEA6o8OqLhkCWmI5wg1e5VcBDctEsT2ucRrLBdCG3XUt3z4r
	tXFvv52oUomAw/am68LR4DgbMyquKhKbiODtTZ1VKJbUbxeSfyPKn5C6Oegu3cUPkypExKUs/ez
	vKZGZhVQAmPSgPkbrhETU/iWkqgUw1mZlj4phIC83HrSsnHQhVMOvNUqteaATHr+MtZaO+Cchfm
	9ByKhbS3f4INTwMezU01sA0xx24qTSyVkXW47LVmdv
X-Gm-Gg: ASbGncsWulPxvDl4q/PJNgqgopFq+vnZNXAUkBDxup6+NJJAEzsg+TBcUF1ZNouKKGn
	L999NSlYhy6yMNbOPsE7/dpG0TBwP0TCqrRl4VmNL/kGfT4MzZNOe8s1I8Ra8/p85p9MdpLqcUn
	fxaHhFwZxBuZtVDrxhLfPP+Q==
X-Received: by 2002:a05:6402:40d3:b0:61c:37f3:81df with SMTP id 4fb4d7f45d1cf-61c37f38ecdmr5584822a12.24.1756091941526;
        Sun, 24 Aug 2025 20:19:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHUHpr+UmaF/UPIc0miOCPZ8Y2NNYsZioaKb50s3hxgE7GvvhOQDF1VyOiPbo78gZwh2DAf5XVxFTEfTBQQ2z4=
X-Received: by 2002:a05:6402:40d3:b0:61c:37f3:81df with SMTP id
 4fb4d7f45d1cf-61c37f38ecdmr5584811a12.24.1756091941117; Sun, 24 Aug 2025
 20:19:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250821064641.5025-1-jasowang@redhat.com>
In-Reply-To: <20250821064641.5025-1-jasowang@redhat.com>
From: Lei Yang <leiyang@redhat.com>
Date: Mon, 25 Aug 2025 11:18:24 +0800
X-Gm-Features: Ac12FXwv6JFOS3OGRBYgKSn1mV44XXfCE_i9G8olouMUz6d6LV5uIEzVWRAeWF0
Message-ID: <CAPpAL=yicLJsn1d+_QbLDAekEQappfkvO9oUedFCG9U9hPT5iQ@mail.gmail.com>
Subject: Re: [PATCH V6 0/9] Refine virtio mapping API
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	hch@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Tested pass with virtio-net regression tests,everything works fine.

Tested-by: Lei Yang <leiyang@redhat.com>

On Thu, Aug 21, 2025 at 2:50=E2=80=AFPM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> Hi all:
>
> Virtio used to be coupled with DMA API. This works fine for the device
> that do real DMA but not the others. For example, VDUSE nees to craft
> with DMA API in order to let the virtio-vdpa driver to work.
>
> This series tries to solve this issue by introducing the mapping API
> in the virtio core. So transport like vDPA can implement their own
> mapping logic without the need to hack with DMA API. The mapping API
> are abstracted with a new map operations in order to be re-used by
> transprot or device. So device like VDUSE can implement its own
> mapping loigc.
>
> For device that uses DMA (for example PCI device), the virtio core
> will still call DMA API directly without the need of implementing map
> ops per device/transport.
>
> Please review.
>
> Changes since V5:
>
> - Rename mapping_token to virtio_map
> - Do not use opaque void * pointer, just use a forward decalration of
>   vduse_iova_domain
> - Remove unused variable and typo fixes
>
> Changes since V4:
>
> - Rename map_token to mapping_token
> - Introduce a union container for opaque token as well as the DMA
>   device so we won't lose the type safety
> - Do not try to set DMA mask for VDUSE device
> - Introduce a new mapper_error op for API completeness
>
> Changes since V3:
>
> - Fix build error of PDS vDPA driver
>
> Changes since V2:
>
> - Drop VDUSE dependenct for HAS_DMA and ARCH_HAS_DMA_OPS
>
> Changes since V1:
>
> - Fix build error of mlx5_vdpa driver
>
>
> Jason Wang (9):
>   virtio_ring: constify virtqueue pointer for DMA helpers
>   virtio_ring: switch to use dma_{map|unmap}_page()
>   virtio: rename dma helpers
>   virtio: introduce virtio_map container union
>   virtio_ring: rename dma_handle to map_handle
>   virtio: introduce map ops in virtio core
>   vdpa: support virtio_map
>   vdpa: introduce map ops
>   vduse: switch to use virtio map API instead of DMA API
>
>  drivers/net/virtio_net.c                 |  28 +-
>  drivers/vdpa/Kconfig                     |   8 +-
>  drivers/vdpa/alibaba/eni_vdpa.c          |   5 +-
>  drivers/vdpa/ifcvf/ifcvf_main.c          |   5 +-
>  drivers/vdpa/mlx5/core/mr.c              |   4 +-
>  drivers/vdpa/mlx5/net/mlx5_vnet.c        |  15 +-
>  drivers/vdpa/octeon_ep/octep_vdpa_main.c |   6 +-
>  drivers/vdpa/pds/vdpa_dev.c              |   5 +-
>  drivers/vdpa/solidrun/snet_main.c        |   8 +-
>  drivers/vdpa/vdpa.c                      |   5 +-
>  drivers/vdpa/vdpa_sim/vdpa_sim.c         |   4 +-
>  drivers/vdpa/vdpa_user/iova_domain.c     |   2 +-
>  drivers/vdpa/vdpa_user/iova_domain.h     |   2 +-
>  drivers/vdpa/vdpa_user/vduse_dev.c       |  79 ++--
>  drivers/vdpa/virtio_pci/vp_vdpa.c        |   5 +-
>  drivers/vhost/vdpa.c                     |   6 +-
>  drivers/virtio/virtio_ring.c             | 459 ++++++++++++++---------
>  drivers/virtio/virtio_vdpa.c             |  20 +-
>  include/linux/vdpa.h                     |  25 +-
>  include/linux/virtio.h                   |  46 ++-
>  include/linux/virtio_config.h            |  72 ++++
>  include/linux/virtio_ring.h              |   7 +-
>  22 files changed, 531 insertions(+), 285 deletions(-)
>
> --
> 2.31.1
>
>


