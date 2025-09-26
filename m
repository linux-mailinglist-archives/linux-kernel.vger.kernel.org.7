Return-Path: <linux-kernel+bounces-833723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F4ECBA2D8A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 09:42:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EFA8170979
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 07:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CECF2877E2;
	Fri, 26 Sep 2025 07:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OVYcD5/O"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF55226FA4E
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 07:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758872566; cv=none; b=Cr2jIc8noeConQ3Bd501pFtT9vJJGo4KMkIp5mqioX3EI+Lfmw9OBKkJuSRs9R3hb6IJZAcjVOuYpQhiji9CAK1yeYZOQRCUPXpgOgPnDcb1co5VkVLNDgDYK1NNZpb/R258Eb4TjMeZtbz+i8uXTL7aX4AO9wdw2xLEJ/W9z2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758872566; c=relaxed/simple;
	bh=0DYzgaYjfziSpVGefjsV8v5Cn3unmqNJFcLCO9fG7Yo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=slvAPtBFebpbG4RtkyRcL4MQGxXVjficID6F9l8dtmqRzhbEjuchtMCQRnBhPYL7RJKrKt44mvtRDDQDwYipzmZifP2kO3ZEn5Koj6ofHzPYic/yGSi5SGOOsigPddCBbR0yjXEgFDoYE/5iPN/Drp40D1w+L6BmIBCVPE8A4dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OVYcD5/O; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758872562;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8HmicZvxtB4srh8p3VU1YserQAMk2ju9wz50BdOmeK0=;
	b=OVYcD5/OoajjC4pG9O0vapksxsMueZuwB7hnr6Xe4cbLfvyO62U2ApQ+A4soY0OsKyjQ5J
	ABBlQEuGGQLle4neCuTqvBYuBsVT0/1j6Pl63RXjW28NWZzj1S6ICB5uCJj3/Iax+QtBSl
	ygA+ZyCyD1t0r+aF/oR0NoJ/0R97lNI=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-w2TSco_DMfmmR57ODeSk-Q-1; Fri, 26 Sep 2025 03:42:41 -0400
X-MC-Unique: w2TSco_DMfmmR57ODeSk-Q-1
X-Mimecast-MFC-AGG-ID: w2TSco_DMfmmR57ODeSk-Q_1758872561
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-32ea7fcddd8so3449926a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 00:42:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758872559; x=1759477359;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8HmicZvxtB4srh8p3VU1YserQAMk2ju9wz50BdOmeK0=;
        b=aG83vo+ygCPh1G9qFGCuSuyyaXiQOQdXPF4rgOOWgwkNUdTPD20atZtXNw5Gg4lqK8
         oRvoCRY/AASdGAySWZ63q9wRFyVXHikR7k7jwD905EkS+4KeV71lF7G+aKyue4aQv+ua
         0uqGAYBzt8eZ6FZGq5PiAp6Ol+i7lsNZWqONEdxj+11wuVH+N5B/PmgYElRTfGB5kG8e
         fW8ynxmFHORtlll9Vwh0XtlCuFxmm/7XbXFyv+EkDaic/PkBkIALgAyv+SK8/pHYitfq
         o+yBzH4yvde8x+lIsH1Al43WMfTvZc7oLqgczTNV80N3OaN8IEHL2LXpDuu39Kp3obI8
         doTQ==
X-Forwarded-Encrypted: i=1; AJvYcCWKgLh+NifzIUD+6i44Zc6u8ebf9NiTB99Y0MOdHGZ1wDwz844IUhcYFJp1phvOwNe8gMUZF1sFhQy09vs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzG2QNpYWbtBwyHA/Xr2NvDkrPwcYEAmstIWjxb5Qa0iR1huW/G
	F/0tyks2SbJr22qExJo4Q/HbjlmZdNlqmy6Snnszlf2FCQsEO9JxrKohmrON2Aoqp5aV5EflWI+
	xFfQ5sp5vvOmI/1NL46g8t0Y1YK4GnccNR8YnY8vhe2GDan63pNn7PiFwHMAmAnpOWNu6k4edCu
	XxvDM+xIT1kXkCCT4tN4P14W3S37SGF/EM5Ic4BA/u
X-Gm-Gg: ASbGnctG1gy6WyORfYTk2MUSMB1NJk4wbGdTp66wGjMbHn7q3GmLLcu8NIKm8cOeB+P
	8ugwhiHwRuMkXTNihcaFjA8AlzoqVzUEHWcmertfpYJlhl4bHA5M0rnhf1m48qe/pewQjtVH5H7
	ivGWDZpuddTkH0Oxrn/A==
X-Received: by 2002:a17:90b:3a92:b0:330:a228:d2c with SMTP id 98e67ed59e1d1-3342a2573e7mr9048471a91.15.1758872559161;
        Fri, 26 Sep 2025 00:42:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFOfOYjeBJkP9Spm69R+gqefPjm48G3w4nVhRcBUvlclTAtbz/2PfHGTXO6/xqAoYOQYQEUfhcfEyDAtzajKws=
X-Received: by 2002:a17:90b:3a92:b0:330:a228:d2c with SMTP id
 98e67ed59e1d1-3342a2573e7mr9048437a91.15.1758872558646; Fri, 26 Sep 2025
 00:42:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250925091335.1964283-1-eperezma@redhat.com> <20250925091335.1964283-4-eperezma@redhat.com>
In-Reply-To: <20250925091335.1964283-4-eperezma@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 26 Sep 2025 15:42:27 +0800
X-Gm-Features: AS18NWA5FGwZrinH5fpRwho4dzxdBuZ_fZbF9IawF26uaxkWFkVck3qOg0_7L_A
Message-ID: <CACGkMEtXOOLuf01qx_MbptjvyZe0jLTgnPU5JDQ0SOUXx54KYg@mail.gmail.com>
Subject: Re: [PATCH v4 3/6] vduse: add vq group support
To: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Yongji Xie <xieyongji@bytedance.com>, Cindy Lu <lulu@redhat.com>, 
	linux-kernel@vger.kernel.org, Maxime Coquelin <mcoqueli@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Laurent Vivier <lvivier@redhat.com>, 
	virtualization@lists.linux.dev, Stefano Garzarella <sgarzare@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 25, 2025 at 5:14=E2=80=AFPM Eugenio P=C3=A9rez <eperezma@redhat=
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
> v4:
> * Revert the "invalid vq group" concept and assume 0 if not set (Jason).
> * Make config->ngroups =3D=3D 0 invalid (Jason).
>
> v3:
> * Make the default group an invalid group as long as VDUSE device does
>   not set it to some valid u32 value.  Modify the vdpa core to take that
>   into account (Jason).
> * Create the VDUSE_DEV_MAX_GROUPS instead of using a magic number
>
> v2:
> * Now the vq group is in vduse_vq_config struct instead of issuing one
>   VDUSE message per vq.
>
> v1:
> * Fix: Remove BIT_ULL(VIRTIO_S_*), as _S_ is already the bit (Maxime)
>
> RFC v3:
> * Increase VDUSE_MAX_VQ_GROUPS to 0xffff (Jason).  It was set to a lower
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
>  drivers/vdpa/vdpa_user/vduse_dev.c | 46 ++++++++++++++++++++++++++----
>  drivers/vhost/vdpa.c               | 11 +++++--
>  include/uapi/linux/vduse.h         | 12 ++++++--
>  3 files changed, 58 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/=
vduse_dev.c
> index 2b6a8958ffe0..3415217cb3a9 100644
> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> @@ -40,6 +40,7 @@
>  #define DRV_LICENSE  "GPL v2"
>
>  #define VDUSE_DEV_MAX (1U << MINORBITS)
> +#define VDUSE_DEV_MAX_GROUPS 0xffff
>  #define VDUSE_MAX_BOUNCE_SIZE (1024 * 1024 * 1024)
>  #define VDUSE_MIN_BOUNCE_SIZE (1024 * 1024)
>  #define VDUSE_BOUNCE_SIZE (64 * 1024 * 1024)
> @@ -59,6 +60,7 @@ struct vduse_virtqueue {
>         struct vdpa_vq_state state;
>         bool ready;
>         bool kicked;
> +       u32 vq_group;
>         spinlock_t kick_lock;
>         spinlock_t irq_lock;
>         struct eventfd_ctx *kickfd;
> @@ -115,6 +117,7 @@ struct vduse_dev {
>         u8 status;
>         u32 vq_num;
>         u32 vq_align;
> +       u32 ngroups;
>         struct vduse_umem *umem;
>         struct mutex mem_lock;
>         unsigned int bounce_size;
> @@ -456,6 +459,7 @@ static void vduse_dev_reset(struct vduse_dev *dev)
>                 vq->driver_addr =3D 0;
>                 vq->device_addr =3D 0;
>                 vq->num =3D 0;
> +               vq->vq_group =3D 0;
>                 memset(&vq->state, 0, sizeof(vq->state));
>
>                 spin_lock(&vq->kick_lock);
> @@ -593,6 +597,16 @@ static int vduse_vdpa_set_vq_state(struct vdpa_devic=
e *vdpa, u16 idx,
>         return 0;
>  }
>
> +static u32 vduse_get_vq_group(struct vdpa_device *vdpa, u16 idx)
> +{
> +       struct vduse_dev *dev =3D vdpa_to_vduse(vdpa);
> +
> +       if (dev->api_version < VDUSE_API_VERSION_1)
> +               return 0;
> +
> +       return dev->vqs[idx]->vq_group;
> +}
> +
>  static int vduse_vdpa_get_vq_state(struct vdpa_device *vdpa, u16 idx,
>                                 struct vdpa_vq_state *state)
>  {
> @@ -790,6 +804,7 @@ static const struct vdpa_config_ops vduse_vdpa_config=
_ops =3D {
>         .set_vq_cb              =3D vduse_vdpa_set_vq_cb,
>         .set_vq_num             =3D vduse_vdpa_set_vq_num,
>         .get_vq_size            =3D vduse_vdpa_get_vq_size,
> +       .get_vq_group           =3D vduse_get_vq_group,
>         .set_vq_ready           =3D vduse_vdpa_set_vq_ready,
>         .get_vq_ready           =3D vduse_vdpa_get_vq_ready,
>         .set_vq_state           =3D vduse_vdpa_set_vq_state,
> @@ -1253,12 +1268,24 @@ static long vduse_dev_ioctl(struct file *file, un=
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
> +               if (dev->api_version >=3D VDUSE_API_VERSION_1) {
> +                       if (config.group > dev->ngroups)
> +                               break;

This should be ">=3D".

> +                       if (dev->status & VIRTIO_CONFIG_S_DRIVER_OK)
> +                               break;
> +               }
> +
> +               if (config.reserved1 ||
> +                   !is_mem_zero((const char *)config.reserved2,
> +                                sizeof(config.reserved2)))
>                         break;
>
>                 index =3D array_index_nospec(config.index, dev->vq_num);
>                 dev->vqs[index]->num_max =3D config.max_size;
> +               dev->vqs[index]->vq_group =3D config.group;
>                 ret =3D 0;
>                 break;
>         }
> @@ -1738,12 +1765,20 @@ static bool features_is_valid(struct vduse_dev_co=
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
> +
> +       if (api_version >=3D VDUSE_API_VERSION_1 &&
> +           (!config->ngroups || config->ngroups > VDUSE_DEV_MAX_GROUPS))
> +               return false;
> +
>         if (config->vq_align > PAGE_SIZE)
>                 return false;
>
> @@ -1859,6 +1894,7 @@ static int vduse_create_dev(struct vduse_dev_config=
 *config,
>         dev->device_features =3D config->features;
>         dev->device_id =3D config->device_id;
>         dev->vendor_id =3D config->vendor_id;
> +       dev->ngroups =3D (dev->api_version < 1) ? 1 : config->ngroups;
>         dev->name =3D kstrdup(config->name, GFP_KERNEL);
>         if (!dev->name)
>                 goto err_str;
> @@ -1937,7 +1973,7 @@ static long vduse_ioctl(struct file *file, unsigned=
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
> @@ -2018,7 +2054,7 @@ static int vduse_dev_init_vdpa(struct vduse_dev *de=
v, const char *name)
>
>         vdev =3D vdpa_alloc_device(struct vduse_vdpa, vdpa, dev->dev,
>                                  &vduse_vdpa_config_ops, &vduse_map_ops,
> -                                1, 1, name, true);
> +                                dev->ngroups, 1, name, true);
>         if (IS_ERR(vdev))
>                 return PTR_ERR(vdev);
>
> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index 05a481e4c385..6305382eacbb 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -22,6 +22,7 @@
>  #include <linux/vdpa.h>
>  #include <linux/nospec.h>
>  #include <linux/vhost.h>
> +#include <linux/types.h>
>
>  #include "vhost.h"
>
> @@ -657,16 +658,20 @@ static long vhost_vdpa_vring_ioctl(struct vhost_vdp=
a *v, unsigned int cmd,
>                         return -EFAULT;
>                 ops->set_vq_ready(vdpa, idx, s.num);
>                 return 0;
> -       case VHOST_VDPA_GET_VRING_GROUP:
> +       case VHOST_VDPA_GET_VRING_GROUP: {
> +               u64 group;
> +
>                 if (!ops->get_vq_group)
>                         return -EOPNOTSUPP;
>                 s.index =3D idx;
> -               s.num =3D ops->get_vq_group(vdpa, idx);
> -               if (s.num >=3D vdpa->ngroups)
> +               group =3D ops->get_vq_group(vdpa, idx);
> +               if (group >=3D vdpa->ngroups || group > U32_MAX || group =
< 0)
>                         return -EIO;
>                 else if (copy_to_user(argp, &s, sizeof(s)))
>                         return -EFAULT;
> +               s.num =3D group;

I guess this won't work.

>                 return 0;
> +       }
>         case VHOST_VDPA_GET_VRING_DESC_GROUP:
>                 if (!vhost_vdpa_has_desc_group(v))
>                         return -EOPNOTSUPP;
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
> +       __u16 reserved2[10];
>  };
>
>  /*
> --
> 2.51.0
>

Thanks


