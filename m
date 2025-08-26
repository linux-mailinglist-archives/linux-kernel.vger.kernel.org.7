Return-Path: <linux-kernel+bounces-786558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A4EBB35C64
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 13:33:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B98437B7BBA
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 11:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF3C83451A5;
	Tue, 26 Aug 2025 11:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZREqODTM"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C7A3451AA
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 11:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756207872; cv=none; b=nbJzsyVdonm5m78tIMNSwIhgPl1o03Gz1DCpQxihD2CQ9F2ioXhJzQhWfu1k9zHTw5GPSEop5Klv/KHnuYDyGbEs36rTMSc3gUkotGuDCMieAL7wSW19wHxDCEQKAx7X11of/M/mVpgp1k+eXO9T/9hPZYdg/zFTh5Z6Xv3dihE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756207872; c=relaxed/simple;
	bh=RBVK/hVv7Cv492e9EIM6DicnWjPWJ0/fXcwi/pUoyNs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tyHTTB8iTuhaVkVdiL+A5Po2UUGtH8IE0Rn3/MolqM3QtFTlbAwtEegtHoedeyCDIbpnZgIYcf+rrDGjeL0dZbtimkAS8AA+G+gJo5pzNSVrxMcZ4w9hMnJKmsWbv2vy5+P1bXDkmdRdIkXyAbhWBi6OFzI5cfNQhBuzmSP9/BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZREqODTM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756207869;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4ivLojxMmQNDm3XJ4T+3KolmVVz+U8oHP6tGC+J4C4o=;
	b=ZREqODTMhzrvaJGEgTf+HXGhCH2sztEHPGqH8pYppCne+OPrlVTQnXYZc7sOR6LKs+xkTS
	fqnGDllixtFbYVkNMWmujwfz6oWxiuKB6nXTZZs8L487FsvatEZd1+604cqSnF5QumNpBC
	pBtVBOh/G9rr4eiDloBYSU7s8TWG2rs=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-122-KsF-G1fiN6KJIJQA4nH1TQ-1; Tue, 26 Aug 2025 07:31:07 -0400
X-MC-Unique: KsF-G1fiN6KJIJQA4nH1TQ-1
X-Mimecast-MFC-AGG-ID: KsF-G1fiN6KJIJQA4nH1TQ_1756207867
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-325e31cecd8so1727622a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 04:31:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756207867; x=1756812667;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4ivLojxMmQNDm3XJ4T+3KolmVVz+U8oHP6tGC+J4C4o=;
        b=aOXqW9y9/HVE9OmPJmIoegwWdbnXkEdhxeLapt2yOSQiGOEdBxDUM7EnGKmzDjl/+v
         8MIM8xnzHKnFbuO8F5pZNcZxGP8DwTsjKlsQSbyOHbfipwruCPUk216rFd6OVbn9iQ+l
         vU0Qahr+h+LespqCJaiotdIRwdooG8X2eZTS2cLVFybEtZfNrBLSC1ywzZisf+GaTsfK
         xD5dVs9vWj5N345wf797B87UOyVlOAZu+hi+8DM+CNZo0jfS1yoSzyyH3gEGlYjkqg9H
         UZf+K5VKKGRKFxE1alDMVHQaIkFqQFnD5BDqzeq1+pYNrKKY8c0+cpM50jTgu5MZj2dP
         JDNA==
X-Forwarded-Encrypted: i=1; AJvYcCXH6B9xJamcxAwLzxcopBuz2mDlFNuKr1ENNjMc9pkt+es/ncOCsEIwOpz/KF5NzK6MCXTNrngkIFVcf9Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7SaZ3NKwNpt0H+bIDc4bfw3Y2MQHAXAqudbDUibOg+gBf9af/
	E+v0uY04EruwTPDlKMqxfhwJk6bATy5M7tO0PNluAHWWon6SpUAs/WHcXQG0RF7jv39wL9HhjQW
	AvCTjG+8gsrzZNmMDbB9wkrrg/EysU+3tLNwuClg3zR4cN3qhGO8Gjl8utMr308+V9Ad/KGog44
	w2pkh5rMLwNPly9Hxuhw/8cC1ZBx7eB7I6lJufReA9
X-Gm-Gg: ASbGncvozBuj0nMr6PE0s6xEAPBAtIjjNabn+aUuA5ZjukVkSzLbWOUHLbXWkPbSqqJ
	j6aLK+IN6H6dXS0SFao0vSeFmsXkMf+ykm7cgxwsUu75UIkxe2Jcxp/n8NzWQLsUSzPWpAhJ9jo
	fdtSF9gsJUqpIyxPFUXk7h
X-Received: by 2002:a17:90b:38c3:b0:321:1a89:f692 with SMTP id 98e67ed59e1d1-32515e3cfacmr19699973a91.8.1756207866477;
        Tue, 26 Aug 2025 04:31:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFaf8YZgWJ0+HDYuM4XR1ubKp5FiGeOYzvPC28hH4AyjclQUqbi3rkdpwMNcpziszLugIRzaTrljK9MsLkpDmo=
X-Received: by 2002:a17:90b:38c3:b0:321:1a89:f692 with SMTP id
 98e67ed59e1d1-32515e3cfacmr19699933a91.8.1756207865950; Tue, 26 Aug 2025
 04:31:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250821064641.5025-1-jasowang@redhat.com>
In-Reply-To: <20250821064641.5025-1-jasowang@redhat.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Tue, 26 Aug 2025 13:30:29 +0200
X-Gm-Features: Ac12FXxy-r6wPefrciOMAbkeP53SUdM8GTDTRkBaqrilIKG6Ni1qHvg3Kd5eeKw
Message-ID: <CAJaqyWcPu5KcjC72epOpM7uYPanWL2Kvi4N5Cn2QC5AHiCwApw@mail.gmail.com>
Subject: Re: [PATCH V6 0/9] Refine virtio mapping API
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, xuanzhuo@linux.alibaba.com, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, hch@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 21, 2025 at 8:46=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
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

Reviewed-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

Thanks!


