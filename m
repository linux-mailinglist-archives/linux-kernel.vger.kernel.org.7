Return-Path: <linux-kernel+bounces-820255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9E7CB7D099
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:16:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27392323392
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 08:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01FF530BBB6;
	Wed, 17 Sep 2025 08:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CxfEcnYm"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E59630ACF7
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 08:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758098226; cv=none; b=UG+VJ+kOdSmnk7qeFHeHpL1KxxAAHVULwo5dLVnzJ/8xJtva5a75FzTBnt0RKdMfgGwrs2OXrgUaIeEAMdRT02FblNjQnHcY9YNJJkSqPDTqW/oScKBlPiSBEG+Xrj3yijZZCfiY2TTBFtQuSWCceDSl1sKJCqeXHm1PbgEBlF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758098226; c=relaxed/simple;
	bh=NBcY6IPSwej06QUKs0EihtuS/y5hFWcjcIXp1bLfv/U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UlYTsompH2fNrB43fwQXWMgeYHHeWEDm+Kr0mZKLLLwUkVOSrxCGetPznXH7rajtW2JJN7hQqWcVRbXRhWVhW5xQE+yBLzLRRTQmy8JDupu7vHmDCQKw1cDcoPy9K1NFH3RxuInzMsngNfyqG0KTF+4l0pl3dLOffSxcSJ3ezgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CxfEcnYm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758098222;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1TxTYZVk9R6+dHpEW311M3nyPucrlxVXMkPgErTTIdU=;
	b=CxfEcnYmgty36YNlVWtscdM6ttV9aIdnUH9+TYaWMGky7Rbd5RhlgEMF0rsQqoTMB3m78P
	lzyDgmM2Ja+zilxFVU1wJymxyAZ0yibJGAEz7+avkTfJTkEssxkSiG0xTAHCf6txYQFP6x
	VbphBD5b9vUZSNTFFtVBPHKqNXAwqpE=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-660-jAkRgqhiN8mPjFEAP9ySng-1; Wed, 17 Sep 2025 04:37:00 -0400
X-MC-Unique: jAkRgqhiN8mPjFEAP9ySng-1
X-Mimecast-MFC-AGG-ID: jAkRgqhiN8mPjFEAP9ySng_1758098219
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-32dd3e922fdso8814301a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 01:36:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758098219; x=1758703019;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1TxTYZVk9R6+dHpEW311M3nyPucrlxVXMkPgErTTIdU=;
        b=K8cBfwRXYbqT0w4eM6SSwkRQahSDB56ASq3Tv2ORRjBOU6Hq/fTpTv8GtMj1GwxHmL
         EMtwDWi/7vOXtPWBU+iVHiN4ExnN2autYwb3b0naWpei9DOIEMbX6NqL7RqqFMzOtPR/
         yWztAPSbWNjaBZi00uo+4rKEny8KRxsF+yfRwAa/AnB4qb1DBeBFtZmFd1w1Flv6FlPF
         VzCzybRYYTIFgnXarQJOeB562xj+abfbEDznF53Hd16bK85M75W9tvBbUs/EZlw3ISTv
         LhBFy60OgRUWeoJMOrDYGmXK9jwH3qOB45ii/feSjuXUiAoeiB4rRqXaNaHD/ekyFWqG
         tNFA==
X-Forwarded-Encrypted: i=1; AJvYcCXGoOhDr0MJsZ8aVtlfddkBdNmJj+s0pk+JxXwWYr+Vcj7C1AS7h0JO6nU5IwOUeST5kMbrBmFiQ0f+GqM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcoYeTQntMlB2KWuNHuEzkFLsxDsjzVrflLPhU4UdGwbTPbGAS
	yLfgpUFrFFOS3QJy6GeyuRGTd1pMPiSP5/gk+6iUzRk+gpChTa8RhZhb6d/39dV3I0f5I1YHs2X
	GAIi2eKWsUwUTpwW/axh3WtUJ43tymIsA1qvd8de+Y7GqMoyy0kSvZR7oPY7FCJur4O6UpmFx1S
	RpzKiwdFa3lqSjeIPF97VMm5V+fYDPeckspEGytzwh
X-Gm-Gg: ASbGnctmLudWvAJe57Cc9sA68VDumKR1EJFl91BoCVvMWAvec/hpf11AA5+z0HeuM9s
	kqLpNFnTA7AJY+ySSn6UhgjFqG+kbGikeC/ld6kTPUNCzo1BoxxTrYw6aTrh7SZ8ZjptHwEc0hT
	BM8+8/v9afIedldlKxJg==
X-Received: by 2002:a17:90b:17c2:b0:32e:73fd:81a3 with SMTP id 98e67ed59e1d1-32ee3f8b6f0mr1694524a91.33.1758098218755;
        Wed, 17 Sep 2025 01:36:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHgf+47xFjbJss5nzW9pfRqsyAcOfp76Cus8dXD4wt4iC0r9d7DtsjRHxCmxP9W1KYqYRxaq4Tpeat3e8cFcM8=
X-Received: by 2002:a17:90b:17c2:b0:32e:73fd:81a3 with SMTP id
 98e67ed59e1d1-32ee3f8b6f0mr1694466a91.33.1758098218143; Wed, 17 Sep 2025
 01:36:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916130833.329087-1-eperezma@redhat.com> <20250916130833.329087-4-eperezma@redhat.com>
In-Reply-To: <20250916130833.329087-4-eperezma@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 17 Sep 2025 16:36:46 +0800
X-Gm-Features: AS18NWCFeAS9V15i-xQltaIDuAOcbxB2I1Kcv6j-Q5Av3wHt3MLsXz4VVRoXyyA
Message-ID: <CACGkMEv+FxECjhxfEKjZJcqXKc=c7RogAk6wdptBymTvL0fz1Q@mail.gmail.com>
Subject: Re: [PATCH v2 3/7] vduse: add vq group support
To: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, linux-kernel@vger.kernel.org, 
	Maxime Coquelin <mcoqueli@redhat.com>, Yongji Xie <xieyongji@bytedance.com>, 
	Cindy Lu <lulu@redhat.com>, Laurent Vivier <lvivier@redhat.com>, virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2025 at 9:08=E2=80=AFPM Eugenio P=C3=A9rez <eperezma@redhat=
.com> wrote:
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
> * Now the vq group is in vduse_vq_config struct instead of issuing one
>   VDUSE message per vq.
>
> v1:
> * Fix: Remove BIT_ULL(VIRTIO_S_*), as _S_ is already the bit (Maxime)
>
> RFC v3:
> * Increase VDUSE_MAX_VQ_GROUPS to 0xffff (Jason). It was set to a lower
>   value to reduce memory consumption, but vqs are already limited to
>   that value and userspace VDUSE is able to allocate that many vqs.
> * Remove the descs vq group capability as it will not be used and we can
>   add it on top.
> * Do not ask for vq groups in number of vq groups < 2.
> * Move the valid vq groups range check to vduse_validate_config.
>
> RFC v2:
> * Cache group information in kernel, as we need to provide the vq map
>   tokens properly.
> * Add descs vq group to optimize SVQ forwarding and support indirect
>   descriptors out of the box.
> ---
>  drivers/vdpa/vdpa_user/vduse_dev.c | 37 ++++++++++++++++++++++++++----
>  include/uapi/linux/vduse.h         | 12 +++++++---
>  2 files changed, 41 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/=
vduse_dev.c
> index 2b6a8958ffe0..42f8807911d4 100644
> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> @@ -59,6 +59,7 @@ struct vduse_virtqueue {
>         struct vdpa_vq_state state;
>         bool ready;
>         bool kicked;
> +       u32 vq_group;
>         spinlock_t kick_lock;
>         spinlock_t irq_lock;
>         struct eventfd_ctx *kickfd;
> @@ -115,6 +116,7 @@ struct vduse_dev {
>         u8 status;
>         u32 vq_num;
>         u32 vq_align;
> +       u32 ngroups;
>         struct vduse_umem *umem;
>         struct mutex mem_lock;
>         unsigned int bounce_size;
> @@ -593,6 +595,13 @@ static int vduse_vdpa_set_vq_state(struct vdpa_devic=
e *vdpa, u16 idx,
>         return 0;
>  }
>
> +static u32 vduse_get_vq_group(struct vdpa_device *vdpa, u16 idx)
> +{
> +       struct vduse_dev *dev =3D vdpa_to_vduse(vdpa);
> +
> +       return dev->vqs[idx]->vq_group;

I wonder if we should fail if VDUSE_VQ_SETUP is not set by userspace?

> +}
> +
>  static int vduse_vdpa_get_vq_state(struct vdpa_device *vdpa, u16 idx,
>                                 struct vdpa_vq_state *state)
>  {
> @@ -790,6 +799,7 @@ static const struct vdpa_config_ops vduse_vdpa_config=
_ops =3D {
>         .set_vq_cb              =3D vduse_vdpa_set_vq_cb,
>         .set_vq_num             =3D vduse_vdpa_set_vq_num,
>         .get_vq_size            =3D vduse_vdpa_get_vq_size,
> +       .get_vq_group           =3D vduse_get_vq_group,
>         .set_vq_ready           =3D vduse_vdpa_set_vq_ready,
>         .get_vq_ready           =3D vduse_vdpa_get_vq_ready,
>         .set_vq_state           =3D vduse_vdpa_set_vq_state,
> @@ -1253,12 +1263,21 @@ static long vduse_dev_ioctl(struct file *file, un=
signed int cmd,
>                 if (config.index >=3D dev->vq_num)
>                         break;
>
> -               if (!is_mem_zero((const char *)config.reserved,
> -                                sizeof(config.reserved)))
> +               if (dev->api_version < VDUSE_API_VERSION_1 && config.grou=
p)
> +                       break;
> +
> +               if (dev->api_version >=3D VDUSE_API_VERSION_1 &&
> +                   config.group > dev->ngroups)
> +                       break;
> +
> +               if (config.reserved1 ||
> +                   !is_mem_zero((const char *)config.reserved2,
> +                                sizeof(config.reserved2)))
>                         break;

What's the reason for having this check? I mean if we don't check this
since the day0, it might be too late to do that.

>
>                 index =3D array_index_nospec(config.index, dev->vq_num);
>                 dev->vqs[index]->num_max =3D config.max_size;
> +               dev->vqs[index]->vq_group =3D config.group;
>                 ret =3D 0;
>                 break;
>         }
> @@ -1738,12 +1757,19 @@ static bool features_is_valid(struct vduse_dev_co=
nfig *config)
>         return true;
>  }
>
> -static bool vduse_validate_config(struct vduse_dev_config *config)
> +static bool vduse_validate_config(struct vduse_dev_config *config,
> +                                 u64 api_version)
>  {
>         if (!is_mem_zero((const char *)config->reserved,
>                          sizeof(config->reserved)))
>                 return false;
>
> +       if (api_version < VDUSE_API_VERSION_1 && config->ngroups)
> +               return false;

Better with ngroups > 1?

> +
> +       if (api_version >=3D VDUSE_API_VERSION_1 && config->ngroups > 0xf=
fff)
> +               return false;
> +
>         if (config->vq_align > PAGE_SIZE)
>                 return false;
>
> @@ -1859,6 +1885,7 @@ static int vduse_create_dev(struct vduse_dev_config=
 *config,
>         dev->device_features =3D config->features;
>         dev->device_id =3D config->device_id;
>         dev->vendor_id =3D config->vendor_id;
> +       dev->ngroups =3D (dev->api_version < 1) ? 1 : (config->ngroups ?:=
 1);
>         dev->name =3D kstrdup(config->name, GFP_KERNEL);
>         if (!dev->name)
>                 goto err_str;
> @@ -1937,7 +1964,7 @@ static long vduse_ioctl(struct file *file, unsigned=
 int cmd,
>                         break;
>
>                 ret =3D -EINVAL;
> -               if (vduse_validate_config(&config) =3D=3D false)
> +               if (!vduse_validate_config(&config, control->api_version)=
)
>                         break;
>
>                 buf =3D vmemdup_user(argp + size, config.config_size);
> @@ -2018,7 +2045,7 @@ static int vduse_dev_init_vdpa(struct vduse_dev *de=
v, const char *name)
>
>         vdev =3D vdpa_alloc_device(struct vduse_vdpa, vdpa, dev->dev,
>                                  &vduse_vdpa_config_ops, &vduse_map_ops,
> -                                1, 1, name, true);
> +                                dev->ngroups, 1, name, true);
>         if (IS_ERR(vdev))
>                 return PTR_ERR(vdev);
>
> diff --git a/include/uapi/linux/vduse.h b/include/uapi/linux/vduse.h
> index ccb92a1efce0..a3d51cf6df3a 100644
> --- a/include/uapi/linux/vduse.h
> +++ b/include/uapi/linux/vduse.h
> @@ -31,6 +31,7 @@
>   * @features: virtio features
>   * @vq_num: the number of virtqueues
>   * @vq_align: the allocation alignment of virtqueue's metadata
> + * @ngroups: number of vq groups that VDUSE device declares
>   * @reserved: for future use, needs to be initialized to zero
>   * @config_size: the size of the configuration space
>   * @config: the buffer of the configuration space
> @@ -45,7 +46,8 @@ struct vduse_dev_config {
>         __u64 features;
>         __u32 vq_num;
>         __u32 vq_align;
> -       __u32 reserved[13];
> +       __u32 ngroups; /* if VDUSE_API_VERSION >=3D 1 */
> +       __u32 reserved[12];
>         __u32 config_size;
>         __u8 config[];
>  };
> @@ -122,14 +124,18 @@ struct vduse_config_data {
>   * struct vduse_vq_config - basic configuration of a virtqueue
>   * @index: virtqueue index
>   * @max_size: the max size of virtqueue
> - * @reserved: for future use, needs to be initialized to zero
> + * @reserved1: for future use, needs to be initialized to zero
> + * @group: virtqueue group
> + * @reserved2: for future use, needs to be initialized to zero
>   *
>   * Structure used by VDUSE_VQ_SETUP ioctl to setup a virtqueue.
>   */
>  struct vduse_vq_config {
>         __u32 index;
>         __u16 max_size;
> -       __u16 reserved[13];
> +       __u16 reserved1;
> +       __u32 group;

This makes me think if u16 is sufficient as I see:

        u32 (*get_vq_group)(struct vdpa_device *vdev, u16 idx);

The index is u16 but the group is u32 ...

> +       __u16 reserved2[10];
>  };
>
>  /*
> --
> 2.51.0
>

Thanks


