Return-Path: <linux-kernel+bounces-826437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A27EB8E876
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 00:15:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04E7117D884
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 22:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9944E1DE2A0;
	Sun, 21 Sep 2025 22:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E6v9G2mQ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E90202C5D
	for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 22:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758492951; cv=none; b=kud35yitYAPFp6IiagGvmU0A8f9cWHyakG0ynPvAESy3hizu5oz1sH7eTATiFRf7+W2rUcOXPPj4H+aFTVCwcqAFmu78lCEyP5xLzfUvoQU4Mewe5tVhTvVdqQrRSCj0ofeM5T3EKTX89Us3pEdr5y6Ga/ajQ+CMY9qag1EBOUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758492951; c=relaxed/simple;
	bh=UE2+sCKcRM0D9EqELobfcIehPj4nrD3ENegoQdfRKL0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PXAnEAcHJRTnvyMS+5ZsItiiSropKkCeJBQ1jZl7JH+SYqXHeMCog8dsnpJyz1SxrDqRZ6RizprUrlSjUoHdgBjPZnvWrZbD8948bObbSW5qj7LV2QrMcdQXyTLr8WU3f0ScRKJIHIMVkpVSitHVntkt11FfJDP0tD1Miz/Oc1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E6v9G2mQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758492948;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=issag+Emck8nYiAlp365ctL+iXmBkoGCcqhig3VAAWc=;
	b=E6v9G2mQWwbdfKyLTDwFYwReD8KA22BIN/LuoZG86BP7uh2xzpRSEZ+eNaTKbGDA/753IA
	TdYgLiavMet1IwHdy8L4VImGnxo4kp50p1vb6YdcHJio03o133VVFw8AbRk14y1IVXwZn1
	N2segHsY6wekR2mFn5xhpxxHaDTfQ2s=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-255-2Tt_he3WOgu6ACvVy_u29w-1; Sun, 21 Sep 2025 18:15:45 -0400
X-MC-Unique: 2Tt_he3WOgu6ACvVy_u29w-1
X-Mimecast-MFC-AGG-ID: 2Tt_he3WOgu6ACvVy_u29w_1758492943
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3ef21d77d2eso3060435f8f.1
        for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 15:15:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758492943; x=1759097743;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=issag+Emck8nYiAlp365ctL+iXmBkoGCcqhig3VAAWc=;
        b=INzK6gjY+pBvyiUfUiTwzWFvS1bo0zVuOfCo3eLkFj3ZAKBj6IkSkmfoXWBSA4Tdc8
         M4epvP1/fvH7M7mAu5fswmtQZpghE46/AnfH0xUDaY8O8tz2HmuosUVqaVLZU3r8h0SH
         SM1r7w0zPHnD3ARzl7sUTSj9pbU06dMbpibKAprFTrIGryDoJ0XAbsQ7iaoxVteTTQ4n
         oVn7u0b6QFodfLDWzXxAW/AFhTHRPKrf2ix7f+YVYD6RL+sLzuwXPh5zsHDRv3raMNRL
         RtgWBCWMO4XcRLZceVaMmbN9F6SNT5in+h726pwKbcUQo43gUPqaJKs/MwphgypyE0z/
         R5/A==
X-Forwarded-Encrypted: i=1; AJvYcCX2sd+aMBJw83hxabs0qoNitrY2nXJjUWVw7MECXgktWSP8kCAQs+iCPPst+d95w97ctZMmzoAlZFAL6XE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTpDdbRVCO8ahF38aA8sQScfCtlyVnhIu6mpRN8hp8qWc9ZCeD
	gYUqyPSCL/xAafHw2w8QWSFVOSV3ZMlA545qv1NXCFSXPo5uPwU+HxEG7+a8tOfVUDZTKx/Xz5X
	ojCUCdFYMnb1bTfPVDPcRzsaz2f4WwCCwGpDRFyT3mA9vGdbG/2DHRyneM2jkCVe+Xg==
X-Gm-Gg: ASbGncsj5szveNdCObw9R6LPz3KnF2HDLndxawZlIo6FWJuO3rQlcB+MguDwzw0MqEW
	kmXDN04Nrw5p6OZIYYeVvMyVYNwOQvQD6CvIZ5pZNj1ufC8oIhgQoYle758H4skbZU9YvOQ8Phm
	dtAPfYfYvJre8NHoKZbyhLAI5WPNMxaTkFHGKm47BUHaAmPD603HNK2fDLcbKx7boYeDM233f/D
	goUXUf5+NU2r/zC4USkQY/ELPjzQwnugOv8uNnGuaOKtgJAqLHaIss563k7L8mcxrXltEaDwrcm
	ATBZlPFrn3lVCu4RRnN3G3fEtPCzhgaNhtE=
X-Received: by 2002:a05:6000:2486:b0:3e9:f852:491 with SMTP id ffacd0b85a97d-3ee86b845b9mr10991340f8f.56.1758492943125;
        Sun, 21 Sep 2025 15:15:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG5jSHy9tCekUFhaB50y2EweyLHn5Bx3Q8YuDkLzLOfeR9o5bHpT9MJjrrnHFOUxqNdrfiSsw==
X-Received: by 2002:a05:6000:2486:b0:3e9:f852:491 with SMTP id ffacd0b85a97d-3ee86b845b9mr10991326f8f.56.1758492942751;
        Sun, 21 Sep 2025 15:15:42 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73ea:f900:52ee:df2b:4811:77e0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee07407d33sm17370478f8f.18.2025.09.21.15.15.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Sep 2025 15:15:41 -0700 (PDT)
Date: Sun, 21 Sep 2025 18:15:39 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	hch@infradead.org
Subject: Re: [PATCH V6 0/9] Refine virtio mapping API
Message-ID: <20250921181435-mutt-send-email-mst@kernel.org>
References: <20250821064641.5025-1-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250821064641.5025-1-jasowang@redhat.com>

On Thu, Aug 21, 2025 at 02:46:32PM +0800, Jason Wang wrote:
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

I sent some typos i found.
Pls send fixups on top to fix them so testing in linux-next is not invalidated.
Thanks!



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


