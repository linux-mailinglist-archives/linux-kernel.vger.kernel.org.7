Return-Path: <linux-kernel+bounces-761751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DEF8B1FE09
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 05:10:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8252F3B7B17
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 03:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94BD7247293;
	Mon, 11 Aug 2025 03:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T9Q91uVo"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 349745680
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 03:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754881810; cv=none; b=hKQfoFSfileu2qc30uL3+IGc/n0/+s2q4I55EMmYxASYRc5f/9atAUNTIWj+e1mHOKcxkwGVlLvjH/15tpesQwTMDuPqbCx6f3EGFQ9YmRzi7K335VMzH9fBXrA6l9gzWiPq4iUInVDDHMtfVzdelPECLQhYghy1lM94fJ3woe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754881810; c=relaxed/simple;
	bh=gmFBvAsAXFhHJ5DXWqnrqxnDPhs8jC4gkrep2Sry10g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=saweiV0rgOlSgeX56reLZwuxMtDVVEgbde2Uu+maN5XB1S1pou6LBTD8A9PQipPHaRtXkqzz+ZAU1KML3B+2mYyaNCAo3qZgwVTUhd7KQVmJxyPKER7XjnpU9Ez/6r0Ic2Jo15KUy1M1Sk0MM7rDGisDNotiMtioZvuAqxzMGWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T9Q91uVo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754881807;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=20ghAhTra6izBIEKTsU0crmKM6rj8P8UsO71njZ+5PA=;
	b=T9Q91uVorE7x+rTSoMnhv0Uulp7f7kWt7bPlA8Tpdcj/IfiAX6h7eGLd6P4XrQ/9uKYw+b
	w69+acf5Oqn7r+AUBNOreFyz6as3rotzL75qKyDsfTkAXOqDP7dC8otos6bPWIHL61lUb8
	TxPC9YFVmiOW71eFDtoWhmTrMwEHYCQ=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622--C1gmkAxOhOhPkSGYgVNRw-1; Sun, 10 Aug 2025 23:10:06 -0400
X-MC-Unique: -C1gmkAxOhOhPkSGYgVNRw-1
X-Mimecast-MFC-AGG-ID: -C1gmkAxOhOhPkSGYgVNRw_1754881794
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-31f32271a1fso5170826a91.0
        for <linux-kernel@vger.kernel.org>; Sun, 10 Aug 2025 20:09:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754881794; x=1755486594;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=20ghAhTra6izBIEKTsU0crmKM6rj8P8UsO71njZ+5PA=;
        b=YhhRV37MQ6J2YX1nTjFYMzqj2nvp3socvRWrBPmmOFvV9+lN607GTff3KStSTOiApt
         W0GEumFkT40wVm57Y9UgOu2G5ruTAStprOzqWms+vEbbY5NeEpA1pIogHWkKKHQrs/EJ
         S+37cEJtdhgyj+YbmhZCBUQUdcPAfIHMBJSfAQvFvVBMe+uGnn4x36SGNTVX7K5MsaUF
         YzGuSiOXJS35ucJ4s6AMVkU7gMrfRDcaz5510vMXd1GlYt6tbQb+N2M5WtvSpKqhUTLE
         znVhAj0Gregu3wBBnam9rbjjKg2udrObmMe45VPxHQD5SFaAvMuf82J0US15hlbFOn5M
         zXKg==
X-Forwarded-Encrypted: i=1; AJvYcCXmJPdozgUan7da4o3dnxhtm5sULv4UVo7GemZ0v8nmZG/noHF/vDxxBIbpLfIPVe7Rb1At9KxZJtZy4kY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1ZZYcAPu5h/QGZ9ifrQwPSoS3zVUO74OgSTqnJFHqT18tVe8K
	dnPA28dW/BgVmwKhtWUdydVkWMSCBi6i1QftZl6FZDx+2+HDTVLqfrFn7SXUsszvbN6NIe7IZj2
	XrTflThWaxXGixgi72eMVnmbtjU8z98dLcuyUld4CHkE7qmfVpczIvWA19AGbL+/oqVcq4rJzvX
	v9lZnOne4zUgg7Cdg0KBqvIBLx5khtNaQZRPO7XKHT
X-Gm-Gg: ASbGncsKTVGYNGtWzYkD9oZuF+mbE6OzpXD8igJuFJLHE6oVGWIdwOIfXvdY33gP+Dl
	tPqWQHbBWm1jl3nisOs0F7WZjco4v4ygUE3BcqvoE2jyxKUqiSlQ78kDwQZqzW82yCMQYSPX50K
	6F5Gf6i2qtC8xau6HKqf0=
X-Received: by 2002:a17:90b:4986:b0:314:2cd2:595d with SMTP id 98e67ed59e1d1-3218439db43mr18155727a91.8.1754881794077;
        Sun, 10 Aug 2025 20:09:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG4Fs7VVa0FzIKzinv2kEUKLby94eOvwISEi+KslRsbTo/SBws2naemJhmXAHJ7/cbZMrOelyftz/so8ltFrO8=
X-Received: by 2002:a17:90b:4986:b0:314:2cd2:595d with SMTP id
 98e67ed59e1d1-3218439db43mr18155700a91.8.1754881793611; Sun, 10 Aug 2025
 20:09:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250807115752.1663383-1-eperezma@redhat.com> <20250807115752.1663383-3-eperezma@redhat.com>
In-Reply-To: <20250807115752.1663383-3-eperezma@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 11 Aug 2025 11:09:42 +0800
X-Gm-Features: Ac12FXyd2NEMDD86QVQx-BBNPdp7ly5Y3cms8CTZ-KwtgAbSfMFH_t9eySwY9kY
Message-ID: <CACGkMEsMcnBnVPMWD7fxrnXzT+rsUppAxNkoSC4Zy=HiodOvZw@mail.gmail.com>
Subject: Re: [RFC v2 2/7] vduse: add vq group support
To: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Cindy Lu <lulu@redhat.com>, 
	Yongji Xie <xieyongji@bytedance.com>, Stefano Garzarella <sgarzare@redhat.com>, 
	virtualization@lists.linux.dev, Laurent Vivier <lvivier@redhat.com>, 
	linux-kernel@vger.kernel.org, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Maxime Coquelin <mcoqueli@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 7, 2025 at 7:58=E2=80=AFPM Eugenio P=C3=A9rez <eperezma@redhat.=
com> wrote:
>
> This allows sepparate the different virtqueues in groups that shares the
> same address space.  Asking the VDUSE device for the groups of the vq at
> the beginning as they're needed for the DMA API.
>
> Allocating 3 vq groups as net is the device that need the most groups:
> * Dataplane (guest passthrough)
> * CVQ
> * Shadowed vrings.
>
> Future versions of the series can include dynamic allocation of the
> groups array so VDUSE can declare more groups.
>
> Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> ---
> v2:
> * Cache group information in kernel, as we need to provide the vq map
>   tokens properly.
> * Add descs vq group to optimize SVQ forwarding and support indirect
>   descriptors out of the box.
> ---
>  drivers/vdpa/vdpa_user/vduse_dev.c | 71 +++++++++++++++++++++++++++++-
>  include/uapi/linux/vduse.h         | 19 +++++++-
>  2 files changed, 88 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/=
vduse_dev.c
> index d858c4389cc1..d1f6d00a9c71 100644
> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> @@ -46,6 +46,11 @@
>  #define VDUSE_IOVA_SIZE (VDUSE_MAX_BOUNCE_SIZE + 128 * 1024 * 1024)
>  #define VDUSE_MSG_DEFAULT_TIMEOUT 30
>
> +/*
> + * Let's make it 3 for simplicity.
> + */
> +#define VDUSE_MAX_VQ_GROUPS 3

I think we can release this to something like 64. Otherwise we might
bump the version again just to increase the limitation? Or having a
sysfs entry like bounce_size?

> +
>  #define IRQ_UNBOUND -1
>
>  struct vduse_virtqueue {
> @@ -58,6 +63,8 @@ struct vduse_virtqueue {
>         struct vdpa_vq_state state;
>         bool ready;
>         bool kicked;
> +       u32 vq_group;
> +       u32 vq_desc_group;
>         spinlock_t kick_lock;
>         spinlock_t irq_lock;
>         struct eventfd_ctx *kickfd;
> @@ -114,6 +121,7 @@ struct vduse_dev {
>         u8 status;
>         u32 vq_num;
>         u32 vq_align;
> +       u32 ngroups;
>         struct vduse_umem *umem;
>         struct mutex mem_lock;
>         unsigned int bounce_size;
> @@ -592,6 +600,20 @@ static int vduse_vdpa_set_vq_state(struct vdpa_devic=
e *vdpa, u16 idx,
>         return 0;
>  }
>
> +static u32 vduse_get_vq_group(struct vdpa_device *vdpa, u16 idx)
> +{
> +       struct vduse_dev *dev =3D vdpa_to_vduse(vdpa);
> +
> +       return dev->vqs[idx]->vq_group;
> +}
> +
> +static u32 vduse_get_vq_desc_group(struct vdpa_device *vdpa, u16 idx)
> +{
> +       struct vduse_dev *dev =3D vdpa_to_vduse(vdpa);
> +
> +       return dev->vqs[idx]->vq_desc_group;
> +}
> +
>  static int vduse_vdpa_get_vq_state(struct vdpa_device *vdpa, u16 idx,
>                                 struct vdpa_vq_state *state)
>  {
> @@ -678,13 +700,48 @@ static u8 vduse_vdpa_get_status(struct vdpa_device =
*vdpa)
>         return dev->status;
>  }
>
> +static int vduse_fill_vq_groups(struct vduse_dev *dev)
> +{
> +       if (dev->api_version < VDUSE_API_VERSION_1)
> +               return 0;
> +
> +       for (int i =3D 0; i < dev->vdev->vdpa.nvqs; ++i) {
> +               struct vduse_dev_msg msg =3D { 0 };
> +               int ret;
> +
> +               msg.req.type =3D VDUSE_GET_VQ_GROUP;
> +               msg.req.vq_group.index =3D i;
> +               ret =3D vduse_dev_msg_sync(dev, &msg);

I fail to understand why the default group mapping is not done during
device creation.

> +               if (ret)
> +                       return ret;
> +
> +               dev->vqs[i]->vq_group =3D msg.resp.vq_group.num;
> +
> +               msg.req.type =3D VDUSE_GET_VRING_DESC_GROUP;
> +               ret =3D vduse_dev_msg_sync(dev, &msg);
> +               if (ret)
> +                       return ret;
> +
> +               dev->vqs[i]->vq_desc_group =3D msg.resp.vq_group.num;
> +       }
> +
> +       return 0;
> +}
> +
>  static void vduse_vdpa_set_status(struct vdpa_device *vdpa, u8 status)
>  {
>         struct vduse_dev *dev =3D vdpa_to_vduse(vdpa);
> +       u8 previous_status =3D dev->status;
>
>         if (vduse_dev_set_status(dev, status))
>                 return;
>
> +       if ((dev->status ^ previous_status) &
> +            BIT_ULL(VIRTIO_CONFIG_S_FEATURES_OK) &&
> +           status & (1ULL << VIRTIO_CONFIG_S_FEATURES_OK))
> +               if (vduse_fill_vq_groups(dev))

Can we merge the two messages into a single one? Or can we use a
shared memory for storing such mapping?

For example, if we have 256 queues it would be very slow.

Thanks


