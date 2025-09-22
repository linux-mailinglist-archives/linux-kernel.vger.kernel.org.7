Return-Path: <linux-kernel+bounces-826488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B196B8EA63
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 03:06:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 594B2189951F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 01:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 892851465B4;
	Mon, 22 Sep 2025 01:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cZqtImAa"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF83FBF0
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 01:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758503179; cv=none; b=nM4GwibZxb0n9ADr45s54dOdXStgGEQilaWFGgcdJ3AyNAGeU6mFolaFVGzDiVVWMvD2c/BTIYaFXGue5pYRtxcR8HmfpLbUwmyKDNsi94indM0qolKY5IzJ97ExJFhGKymtXstJLOP8Gm60OW68QMZbtDehEfslHttrCJ3jJ1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758503179; c=relaxed/simple;
	bh=y/p2o6rvKbyU1DRs4WihioqxuiP3IGdmZf1j+OmTGQ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ljJydQx4JNw838IIfIc70stYCSMCaVkCopSj/QCyaV3r1Uh/aausleh8sCTFKMOsnXeeZUyEbUWGq4bfvk1xRaAiyX+TK8roPAbsDWKr3Me/bLQBBh2pHlDG7l94I/phBk8knDIhu3x2Fu73hrPlOy36pcAu7TNSsDUvsmV0508=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cZqtImAa; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758503176;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZDg8R1Cj1vMrEJ0X4UgoObYXEm8Kkjuao5nW9kUfAbI=;
	b=cZqtImAa16kdnPebxA2ZuXeMAZiTGdrTpo+4mepjWoItyDd64Cm6gHtfnL5CLwb06vsXbK
	3KB/IASkVyrePvHxUKr8itV3+TTHYKRXKJ3TUl/cU7n4Sdi0rASxb3UNkR5cbcgxDF/u5h
	raE8hArmHZiOnaPca6oe+fdc72fdJoA=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-582-Jv--UrXwOWqhwJG24ahMvA-1; Sun, 21 Sep 2025 21:06:15 -0400
X-MC-Unique: Jv--UrXwOWqhwJG24ahMvA-1
X-Mimecast-MFC-AGG-ID: Jv--UrXwOWqhwJG24ahMvA_1758503174
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-32eddb7e714so3612689a91.1
        for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 18:06:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758503174; x=1759107974;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZDg8R1Cj1vMrEJ0X4UgoObYXEm8Kkjuao5nW9kUfAbI=;
        b=E27GI7VMdI9rBCu8dkSuDwqv7Gs1YxR1UXHx/C67HBGcphru16S9GIYOa6o6jKQJE/
         i8Q9HSFjnJhLHj4InUy6wPacOszmxBD5BLmTFUvZJo+wI8DDRQXS1ccQ6bUuGNhy+Un0
         FF3u3OHNgFiNLdAM5BsbLA9Cag7MkJNDH7kaJRB9c0uY5dhOxY7gnMowj2j13IX+s5WV
         g3c8buqqmE1agNXxozhFYdCrUuaywJTS+6cqMFPSLwosfVhaFpeiD3Ha4dM259HllwPT
         Bw7lG7b4D7H6PD3CxcPQI/scu7xvyOqh5m/Xlo53gbfgG4kU11IK/ay+I51ZBDBWS4wL
         Qicg==
X-Forwarded-Encrypted: i=1; AJvYcCX4U1zpHjgkWbqfg8VoqR9cTBv0U1Dj2Alx97PDUsza1jrlhNHaqBc+fmyLPuBslEbArvU1pSE2PqzAhgc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCYERU/vjld7uHXuCHhgDWEzv4ykgSDfxHP8Z4Pitekq8prNRZ
	wWqPNas+fXt0MYyJoNuzIWTs5OlXxnq3WwoNDhWzEzM2oUpoERQnNtFvWC3v3o6h521NrtocHp8
	eoB86s0zVzqiy6aW49Y3ay6q6AquH7I060uxxwt+PXVT9fPif0KhYB2vf39MNuxJY0/D54K3Jfs
	JNnHOe2QXlI2SRSgJbbM+8pauCVHxtALtJyls2iEZf
X-Gm-Gg: ASbGncvBip3tMhDZqoGw6VdnozI8MCaHhgQYkhOkx4vfMqv2mm/aP5blG8+8cQuJI++
	GcFru9a01NKN3bScbLMTkbfdLf5PMQcS2jglCJGZqTFFax3IfjJW2HPIfXnJreqtNkAB38ToDe0
	Gz4uas7Foek8ujeQoApb2yVA==
X-Received: by 2002:a17:90b:3e86:b0:32b:cafc:e339 with SMTP id 98e67ed59e1d1-33098398714mr12444779a91.36.1758503174206;
        Sun, 21 Sep 2025 18:06:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEIYrw1/gpupdolfZKeQfxe7cKWIQL7P2V2Qr4ck7OGNhqg20Js+9UFm18BbbDDJwQ4MNtpPBZsSsZF4Ocl2nk=
X-Received: by 2002:a17:90b:3e86:b0:32b:cafc:e339 with SMTP id
 98e67ed59e1d1-33098398714mr12444765a91.36.1758503173820; Sun, 21 Sep 2025
 18:06:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250821064641.5025-1-jasowang@redhat.com> <20250921181435-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250921181435-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 22 Sep 2025 09:06:02 +0800
X-Gm-Features: AS18NWCRJf-df9McSDQkbpImLBRr2jkffKi3bG-8b6_NZGULobt_GkYNY9v5ehA
Message-ID: <CACGkMEuEOOkv7pkSo21mdqPpRZJm59SQX_ZGG1Br_v_iN-vWiA@mail.gmail.com>
Subject: Re: [PATCH V6 0/9] Refine virtio mapping API
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	hch@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 22, 2025 at 6:15=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Thu, Aug 21, 2025 at 02:46:32PM +0800, Jason Wang wrote:
> > Hi all:
> >
> > Virtio used to be coupled with DMA API. This works fine for the device
> > that do real DMA but not the others. For example, VDUSE nees to craft
> > with DMA API in order to let the virtio-vdpa driver to work.
> >
> > This series tries to solve this issue by introducing the mapping API
> > in the virtio core. So transport like vDPA can implement their own
> > mapping logic without the need to hack with DMA API. The mapping API
> > are abstracted with a new map operations in order to be re-used by
> > transprot or device. So device like VDUSE can implement its own
> > mapping loigc.
> >
> > For device that uses DMA (for example PCI device), the virtio core
> > will still call DMA API directly without the need of implementing map
> > ops per device/transport.
> >
> > Please review.
>
> I sent some typos i found.
> Pls send fixups on top to fix them so testing in linux-next is not invali=
dated.
> Thanks!
>

Will do, I see the HEAD in linux-next is

vdpa: support virtio_map

Is this intended? Would you want me to send fixes on top?

Thanks

>
>
> > Changes since V5:
> >
> > - Rename mapping_token to virtio_map
> > - Do not use opaque void * pointer, just use a forward decalration of
> >   vduse_iova_domain
> > - Remove unused variable and typo fixes
> >
> > Changes since V4:
> >
> > - Rename map_token to mapping_token
> > - Introduce a union container for opaque token as well as the DMA
> >   device so we won't lose the type safety
> > - Do not try to set DMA mask for VDUSE device
> > - Introduce a new mapper_error op for API completeness
> >
> > Changes since V3:
> >
> > - Fix build error of PDS vDPA driver
> >
> > Changes since V2:
> >
> > - Drop VDUSE dependenct for HAS_DMA and ARCH_HAS_DMA_OPS
> >
> > Changes since V1:
> >
> > - Fix build error of mlx5_vdpa driver
> >
> >
> > Jason Wang (9):
> >   virtio_ring: constify virtqueue pointer for DMA helpers
> >   virtio_ring: switch to use dma_{map|unmap}_page()
> >   virtio: rename dma helpers
> >   virtio: introduce virtio_map container union
> >   virtio_ring: rename dma_handle to map_handle
> >   virtio: introduce map ops in virtio core
> >   vdpa: support virtio_map
> >   vdpa: introduce map ops
> >   vduse: switch to use virtio map API instead of DMA API
> >
> >  drivers/net/virtio_net.c                 |  28 +-
> >  drivers/vdpa/Kconfig                     |   8 +-
> >  drivers/vdpa/alibaba/eni_vdpa.c          |   5 +-
> >  drivers/vdpa/ifcvf/ifcvf_main.c          |   5 +-
> >  drivers/vdpa/mlx5/core/mr.c              |   4 +-
> >  drivers/vdpa/mlx5/net/mlx5_vnet.c        |  15 +-
> >  drivers/vdpa/octeon_ep/octep_vdpa_main.c |   6 +-
> >  drivers/vdpa/pds/vdpa_dev.c              |   5 +-
> >  drivers/vdpa/solidrun/snet_main.c        |   8 +-
> >  drivers/vdpa/vdpa.c                      |   5 +-
> >  drivers/vdpa/vdpa_sim/vdpa_sim.c         |   4 +-
> >  drivers/vdpa/vdpa_user/iova_domain.c     |   2 +-
> >  drivers/vdpa/vdpa_user/iova_domain.h     |   2 +-
> >  drivers/vdpa/vdpa_user/vduse_dev.c       |  79 ++--
> >  drivers/vdpa/virtio_pci/vp_vdpa.c        |   5 +-
> >  drivers/vhost/vdpa.c                     |   6 +-
> >  drivers/virtio/virtio_ring.c             | 459 ++++++++++++++---------
> >  drivers/virtio/virtio_vdpa.c             |  20 +-
> >  include/linux/vdpa.h                     |  25 +-
> >  include/linux/virtio.h                   |  46 ++-
> >  include/linux/virtio_config.h            |  72 ++++
> >  include/linux/virtio_ring.h              |   7 +-
> >  22 files changed, 531 insertions(+), 285 deletions(-)
> >
> > --
> > 2.31.1
>


