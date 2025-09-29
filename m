Return-Path: <linux-kernel+bounces-835776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A6E0BA8083
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 07:55:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA46C1724D2
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 05:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BFB0296BDE;
	Mon, 29 Sep 2025 05:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KfliRZdj"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99DA327F163
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 05:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759125296; cv=none; b=ehfZpoJUBJh0LX/WgK9AnI1e/yxNKMWO63q+n9kuG+lUgNi4gjLVBT1Vkdj5Kc74yUAguk7pX3pbqQgg2iMHqnYoUZr8ZQoobCX0qOKgHXrR4UnzuJ83HIydWotOh9z95elmszjgjg6i9Bdf23x4ekZMfyYuHXiqTo0FhWJNLXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759125296; c=relaxed/simple;
	bh=8/E2ldD2d5q0fEc83LhadtKerq4Ej4nbZEJYOBXdJlU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MtKDZug8sOUTXI09jmEL1lAj6zZQF2ANxeLDfGfN3PGfIZ3LDL94YCU3mJYYjctU3h7u7X8Y0QY0eXTm+JteG3ZsMlzeWOav79Ub87q3wyCO0ol4MwKNEoplkhDgDMJQSQ4pgW8vGH3nBNoRxmcBtbKWo9KNujB3mhQ9KQbGLmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KfliRZdj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759125293;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E8maNDgdqKly9BiQbDozT3WeIIEQRXlKan+MIsttrfw=;
	b=KfliRZdjTNgGbdrbEIieuwKGmILUSADJldX3lFuF2gf3/VqSPoZ1Iro6ji3NMeHep7jHj9
	aXV/MYZdrdwYePg69U69qbP2MFCpQKTsbHngH28Bfs05YApH4oo5tS/9TtI8C7++l/wFeA
	2H2b+6/eeHyk5P4MU2x+wZzIBbP6iTo=
Received: from mail-yx1-f72.google.com (mail-yx1-f72.google.com
 [74.125.224.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-391-zJ2OXp6yO2aYhOwtEsSJKA-1; Mon, 29 Sep 2025 01:54:48 -0400
X-MC-Unique: zJ2OXp6yO2aYhOwtEsSJKA-1
X-Mimecast-MFC-AGG-ID: zJ2OXp6yO2aYhOwtEsSJKA_1759125288
Received: by mail-yx1-f72.google.com with SMTP id 956f58d0204a3-60fb0c64421so5708871d50.2
        for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 22:54:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759125288; x=1759730088;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E8maNDgdqKly9BiQbDozT3WeIIEQRXlKan+MIsttrfw=;
        b=gmdkjT958c0fEdVuBoUBVVoed6Ajftyhn1Blo6NoCLMwltLnhiNz/MNYE2L/7jJJ0O
         +f+qh/sufEtnz0Xg7kDF0TjVWvxB5ndAWx8JupG88p7qTctlMrcHI70Lg/zU8ADnYHAD
         CeqvURJY8BdPObSkkSGwD4r+vx/SHgTUeiBNKfQ2KeTgYwN2vSvNaFwdKdnlppbkKU7X
         CIPckXNaYwWi4s6Sz42KZW3fthzCSLDcB8Mtt3fMh1XwSlNnOAGga9GqwU/DLdzx9A9M
         AHJnlKOvkXZFGGp2Jg4DGQvg28AUMI0q38CO5F8sVke76CcYX+NRAuhk0dxpj0ieEIuF
         dGiQ==
X-Forwarded-Encrypted: i=1; AJvYcCWCwPrBKHF+Un5CIAF0ymxoNUVSTXl8Zj/pH3I0qB1YfyzQ6YLSS8TMJjCR813+hbVXnbyRW2qeuiiLtgo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQdt/vAA8vP+9VcPzqiwpaf7mtJZt3yZqyJx5kdNyReSFOM/VS
	dmwHNaBHuWnMK5Yg71H6ezyY2uvAsivR3Y8cwVipupUwM/rW7FdwQ+Ru+wzg3UUjKGvAiqtl0qQ
	pVZcIcfb442H7efwJqZ2PhkpSu9UrJX39hAtf8k9W00XgTFzqq1EfHA0v3YlawNU3E8FmKFkbUT
	WoA24jzJ+N+gANAnZhlpAKEHtR5IXBBySKVkErvOW4
X-Gm-Gg: ASbGncsbaiAAZrslimt0/N8F4fVe4WO5bA717oOeLmCrKxIqf/DN3WBHQeNUqS5CDhC
	t0+4Uw1rb6gVfvV1xuzA3gY3TDuG0QP8YRUx01K6rnLVjTNQM/a8dH6oyeagXWcv2xAfQfS/Syt
	uZeEwUF6t4KYoqv3jQyY6wOyociEWtBiC9iwalj/UPkyvyR4RBV/Zw4PtKRPp8WkOmLbTNvwBA3
	p1bzf6Q
X-Received: by 2002:a53:5009:0:b0:5f3:319c:ff0a with SMTP id 956f58d0204a3-6361a7b92ffmr12511249d50.28.1759125287875;
        Sun, 28 Sep 2025 22:54:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEyCK8uLcphB63nbexDPDDs8eK401XtWuvD3A7MVsBqFDygM2N9TSedA53SK67ekYVbIrFtK9DFzn6x08oNE34=
X-Received: by 2002:a53:5009:0:b0:5f3:319c:ff0a with SMTP id
 956f58d0204a3-6361a7b92ffmr12511241d50.28.1759125287445; Sun, 28 Sep 2025
 22:54:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250926101432.2251301-1-eperezma@redhat.com> <20250926101432.2251301-4-eperezma@redhat.com>
 <20250926105938-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250926105938-mutt-send-email-mst@kernel.org>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Mon, 29 Sep 2025 07:54:10 +0200
X-Gm-Features: AS18NWD0M0BrNB-5ZJFshe0N4FI1QlS26_QY2sGc-me5F0QYk2o7zDGY1K4E_wg
Message-ID: <CAJaqyWfZLw8NicJA93yrz7f9m_t6e9fbkEyycTDb-pE=ARzYAA@mail.gmail.com>
Subject: Re: [PATCH v5 3/6] vduse: add vq group support
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Yongji Xie <xieyongji@bytedance.com>, linux-kernel@vger.kernel.org, 
	Maxime Coquelin <mcoqueli@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Cindy Lu <lulu@redhat.com>, 
	virtualization@lists.linux.dev, Laurent Vivier <lvivier@redhat.com>, jasowang@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 26, 2025 at 4:59=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Fri, Sep 26, 2025 at 12:14:29PM +0200, Eugenio P=C3=A9rez wrote:
> > This allows sepparate the different virtqueues in groups that shares th=
e
>
> separate
>

Fixing, thanks!

> > same address space.  Asking the VDUSE device for the groups of the vq a=
t
> > the beginning as they're needed for the DMA API.
> >
> > Allocating 3 vq groups as net is the device that need the most groups:
> > * Dataplane (guest passthrough)
> > * CVQ
> > * Shadowed vrings.
> >
> > Future versions of the series can include dynamic allocation of the
> > groups array so VDUSE can declare more groups.
> >
> > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > ---
> > v5:
> > * Revert core vdpa changes (Jason).
> > * Fix group =3D=3D ngroup case in checking VQ_SETUP argument (Jason).
> >
> > v4:
> > * Revert the "invalid vq group" concept and assume 0 if not set (Jason)=
.
> > * Make config->ngroups =3D=3D 0 invalid (Jason).
> >
> > v3:
> > * Make the default group an invalid group as long as VDUSE device does
> >   not set it to some valid u32 value.  Modify the vdpa core to take tha=
t
> >   into account (Jason).
> > * Create the VDUSE_DEV_MAX_GROUPS instead of using a magic number
> >
> > v2:
> > * Now the vq group is in vduse_vq_config struct instead of issuing one
> >   VDUSE message per vq.
> >
> > v1:
> > * Fix: Remove BIT_ULL(VIRTIO_S_*), as _S_ is already the bit (Maxime)
> >
> > RFC v3:
> > * Increase VDUSE_MAX_VQ_GROUPS to 0xffff (Jason).  It was set to a lowe=
r
> >   value to reduce memory consumption, but vqs are already limited to
> >   that value and userspace VDUSE is able to allocate that many vqs.
> > * Remove the descs vq group capability as it will not be used and we ca=
n
> >   add it on top.
> > * Do not ask for vq groups in number of vq groups < 2.
> > * Move the valid vq groups range check to vduse_validate_config.
> >
> > RFC v2:
> > * Cache group information in kernel, as we need to provide the vq map
> >   tokens properly.
> > * Add descs vq group to optimize SVQ forwarding and support indirect
> >   descriptors out of the box.
> > ---
> >  drivers/vdpa/vdpa_user/vduse_dev.c | 46 ++++++++++++++++++++++++++----
> >  include/uapi/linux/vduse.h         | 12 ++++++--
> >  2 files changed, 50 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_use=
r/vduse_dev.c
> > index 2b6a8958ffe0..99e37def7a83 100644
> > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > @@ -40,6 +40,7 @@
> >  #define DRV_LICENSE  "GPL v2"
> >
> >  #define VDUSE_DEV_MAX (1U << MINORBITS)
> > +#define VDUSE_DEV_MAX_GROUPS 0xffff
> >  #define VDUSE_MAX_BOUNCE_SIZE (1024 * 1024 * 1024)
> >  #define VDUSE_MIN_BOUNCE_SIZE (1024 * 1024)
> >  #define VDUSE_BOUNCE_SIZE (64 * 1024 * 1024)
> > @@ -59,6 +60,7 @@ struct vduse_virtqueue {
> >       struct vdpa_vq_state state;
> >       bool ready;
> >       bool kicked;
> > +     u32 vq_group;
> >       spinlock_t kick_lock;
> >       spinlock_t irq_lock;
> >       struct eventfd_ctx *kickfd;
> > @@ -115,6 +117,7 @@ struct vduse_dev {
> >       u8 status;
> >       u32 vq_num;
> >       u32 vq_align;
> > +     u32 ngroups;
> >       struct vduse_umem *umem;
> >       struct mutex mem_lock;
> >       unsigned int bounce_size;
> > @@ -456,6 +459,7 @@ static void vduse_dev_reset(struct vduse_dev *dev)
> >               vq->driver_addr =3D 0;
> >               vq->device_addr =3D 0;
> >               vq->num =3D 0;
> > +             vq->vq_group =3D 0;
> >               memset(&vq->state, 0, sizeof(vq->state));
> >
> >               spin_lock(&vq->kick_lock);
> > @@ -593,6 +597,16 @@ static int vduse_vdpa_set_vq_state(struct vdpa_dev=
ice *vdpa, u16 idx,
> >       return 0;
> >  }
> >
> > +static u32 vduse_get_vq_group(struct vdpa_device *vdpa, u16 idx)
> > +{
> > +     struct vduse_dev *dev =3D vdpa_to_vduse(vdpa);
> > +
> > +     if (dev->api_version < VDUSE_API_VERSION_1)
> > +             return 0;
> > +
> > +     return dev->vqs[idx]->vq_group;
> > +}
> > +
> >  static int vduse_vdpa_get_vq_state(struct vdpa_device *vdpa, u16 idx,
> >                               struct vdpa_vq_state *state)
> >  {
> > @@ -790,6 +804,7 @@ static const struct vdpa_config_ops vduse_vdpa_conf=
ig_ops =3D {
> >       .set_vq_cb              =3D vduse_vdpa_set_vq_cb,
> >       .set_vq_num             =3D vduse_vdpa_set_vq_num,
> >       .get_vq_size            =3D vduse_vdpa_get_vq_size,
> > +     .get_vq_group           =3D vduse_get_vq_group,
> >       .set_vq_ready           =3D vduse_vdpa_set_vq_ready,
> >       .get_vq_ready           =3D vduse_vdpa_get_vq_ready,
> >       .set_vq_state           =3D vduse_vdpa_set_vq_state,
> > @@ -1253,12 +1268,24 @@ static long vduse_dev_ioctl(struct file *file, =
unsigned int cmd,
> >               if (config.index >=3D dev->vq_num)
> >                       break;
> >
> > -             if (!is_mem_zero((const char *)config.reserved,
> > -                              sizeof(config.reserved)))
> > +             if (dev->api_version < VDUSE_API_VERSION_1 && config.grou=
p)
> > +                     break;
> > +
> > +             if (dev->api_version >=3D VDUSE_API_VERSION_1) {
> > +                     if (config.group >=3D dev->ngroups)
> > +                             break;
> > +                     if (dev->status & VIRTIO_CONFIG_S_DRIVER_OK)
> > +                             break;
> > +             }
> > +
> > +             if (config.reserved1 ||
> > +                 !is_mem_zero((const char *)config.reserved2,
> > +                              sizeof(config.reserved2)))
> >                       break;
> >
> >               index =3D array_index_nospec(config.index, dev->vq_num);
> >               dev->vqs[index]->num_max =3D config.max_size;
> > +             dev->vqs[index]->vq_group =3D config.group;
> >               ret =3D 0;
> >               break;
> >       }
> > @@ -1738,12 +1765,20 @@ static bool features_is_valid(struct vduse_dev_=
config *config)
> >       return true;
> >  }
> >
> > -static bool vduse_validate_config(struct vduse_dev_config *config)
> > +static bool vduse_validate_config(struct vduse_dev_config *config,
> > +                               u64 api_version)
> >  {
> >       if (!is_mem_zero((const char *)config->reserved,
> >                        sizeof(config->reserved)))
> >               return false;
> >
> > +     if (api_version < VDUSE_API_VERSION_1 && config->ngroups)
> > +             return false;
> > +
> > +     if (api_version >=3D VDUSE_API_VERSION_1 &&
> > +         (!config->ngroups || config->ngroups > VDUSE_DEV_MAX_GROUPS))
> > +             return false;
> > +
> >       if (config->vq_align > PAGE_SIZE)
> >               return false;
> >
> > @@ -1859,6 +1894,7 @@ static int vduse_create_dev(struct vduse_dev_conf=
ig *config,
> >       dev->device_features =3D config->features;
> >       dev->device_id =3D config->device_id;
> >       dev->vendor_id =3D config->vendor_id;
> > +     dev->ngroups =3D (dev->api_version < 1) ? 1 : config->ngroups;
> >       dev->name =3D kstrdup(config->name, GFP_KERNEL);
> >       if (!dev->name)
> >               goto err_str;
> > @@ -1937,7 +1973,7 @@ static long vduse_ioctl(struct file *file, unsign=
ed int cmd,
> >                       break;
> >
> >               ret =3D -EINVAL;
> > -             if (vduse_validate_config(&config) =3D=3D false)
> > +             if (!vduse_validate_config(&config, control->api_version)=
)
> >                       break;
> >
> >               buf =3D vmemdup_user(argp + size, config.config_size);
> > @@ -2018,7 +2054,7 @@ static int vduse_dev_init_vdpa(struct vduse_dev *=
dev, const char *name)
> >
> >       vdev =3D vdpa_alloc_device(struct vduse_vdpa, vdpa, dev->dev,
> >                                &vduse_vdpa_config_ops, &vduse_map_ops,
> > -                              1, 1, name, true);
> > +                              dev->ngroups, 1, name, true);
> >       if (IS_ERR(vdev))
> >               return PTR_ERR(vdev);
> >
> > diff --git a/include/uapi/linux/vduse.h b/include/uapi/linux/vduse.h
> > index ccb92a1efce0..a3d51cf6df3a 100644
> > --- a/include/uapi/linux/vduse.h
> > +++ b/include/uapi/linux/vduse.h
> > @@ -31,6 +31,7 @@
> >   * @features: virtio features
> >   * @vq_num: the number of virtqueues
> >   * @vq_align: the allocation alignment of virtqueue's metadata
> > + * @ngroups: number of vq groups that VDUSE device declares
> >   * @reserved: for future use, needs to be initialized to zero
> >   * @config_size: the size of the configuration space
> >   * @config: the buffer of the configuration space
> > @@ -45,7 +46,8 @@ struct vduse_dev_config {
> >       __u64 features;
> >       __u32 vq_num;
> >       __u32 vq_align;
> > -     __u32 reserved[13];
> > +     __u32 ngroups; /* if VDUSE_API_VERSION >=3D 1 */
> > +     __u32 reserved[12];
> >       __u32 config_size;
> >       __u8 config[];
> >  };
> > @@ -122,14 +124,18 @@ struct vduse_config_data {
> >   * struct vduse_vq_config - basic configuration of a virtqueue
> >   * @index: virtqueue index
> >   * @max_size: the max size of virtqueue
> > - * @reserved: for future use, needs to be initialized to zero
> > + * @reserved1: for future use, needs to be initialized to zero
> > + * @group: virtqueue group
> > + * @reserved2: for future use, needs to be initialized to zero
> >   *
> >   * Structure used by VDUSE_VQ_SETUP ioctl to setup a virtqueue.
> >   */
> >  struct vduse_vq_config {
> >       __u32 index;
> >       __u16 max_size;
> > -     __u16 reserved[13];
> > +     __u16 reserved1;
> > +     __u32 group;
> > +     __u16 reserved2[10];
> >  };
> >
> >  /*
> > --
> > 2.51.0
>


