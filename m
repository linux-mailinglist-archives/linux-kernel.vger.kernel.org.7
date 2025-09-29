Return-Path: <linux-kernel+bounces-836211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7ACBBA903F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 13:29:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57B153C3D52
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 11:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88F443002AC;
	Mon, 29 Sep 2025 11:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="abakqNw/"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB0E2E8DF0
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 11:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759145364; cv=none; b=Nk14CFgAVRVwL0+EdY8JjsNOxS73OcYOKv7bTP0TUhWunTWMiyWveW2O92eg1qC9OpKmn5ByGLwMC2R4QLA1j4okmsE/+mTv9PtoUBt1qitfSAmVEHVvSYuI7H/Nu55984h+TtsDEqgWw/ITF4K094Wx6L8sn37VSIq+UXt8c9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759145364; c=relaxed/simple;
	bh=H8i5fZk87oCsBRw0T0cL2AXEc1GZ4laeHwnVaeFRon8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hwM6Mo88VPccQLx52nIiwFrRjO2OCmMyxRkD/osegYZ/qo/qyJhUGV6Q9y4LvqMM83QSSW70iCAC5po89EbcvjWSMsudB7R+4vM/cJ7kVFd/3nfVaMSNyZXhhVSw0omW9V/Fa0ruZh5rPtFA+AapuPf2myv5l4vdnaabL6Rm3H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=abakqNw/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759145360;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4W37fo/MDzK6n6//COOhsV3TXN93sDgxG7zOzmfdlP8=;
	b=abakqNw/bL4GI5nYf+51ynTup/mUAUyZAAo8iDLkOM8cze48rpUnoOuzz/UxkL2AF2tzwZ
	OTeWMZfx4V+ujgl+prfi9oqETWciYtzGnlaZ/A9y1lBPITj4WXjqKxMjZHhzWFDGsq+1Te
	L7Ximz2TgQW9/EhPrK0c7wTX+zQLFTI=
Received: from mail-yx1-f72.google.com (mail-yx1-f72.google.com
 [74.125.224.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-339-zeQiHmZtMAuW-vpzCbS8vg-1; Mon, 29 Sep 2025 07:29:16 -0400
X-MC-Unique: zeQiHmZtMAuW-vpzCbS8vg-1
X-Mimecast-MFC-AGG-ID: zeQiHmZtMAuW-vpzCbS8vg_1759145356
Received: by mail-yx1-f72.google.com with SMTP id 956f58d0204a3-6360e9f4efaso5742880d50.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 04:29:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759145356; x=1759750156;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4W37fo/MDzK6n6//COOhsV3TXN93sDgxG7zOzmfdlP8=;
        b=Wb+UpYNosWqXn61LVaM1Z7sKVGzKFeLqtCfmdl+gEjxjdZjikBWOzLyMGPdj6kZEHr
         yeuNq47YmC3tpiy+YKDmUI+J2kmZXePy3C4F/CsKZ8Wq/44bgYmuqHadLtVyQM7ghZ0j
         oniMYfxixd5U5Us+few4dyXB4rNDPmRYAoxiJlAp8t1U6evgfXpYM4A/8TWHHcR6JJB5
         YPQbzAKKj0o9jYZxqYfL8G2u19IalZ9/gicY5Kke27PNNJ1kvuRfQIbcPuHH7W1jyk3r
         nkDFQ1g9rIKGQ13BkYnY2/a2SGDsO5mcmIMzbeacIITqrCbp3XT7IfyxaF8SX0QMHLom
         VhYA==
X-Forwarded-Encrypted: i=1; AJvYcCX513sh+EsQClh3wX+abjiD6dhvrVhbqihB9WToF/zQUhOCGhxZ3NuSAMK07+GQ8KKb+YE/CmHyj9y1CC8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyddIQ+PgQpq2OBgrKn2Z5IWIsXlT6LBRrR/sLHPbN06jLZHUDh
	/4xCYcEeD1Vxse6IuXd8WQEcRBOK8/+gt5ROdzZAs/filvmlmRkEr1EeW1TV7eKZp9nfhdcRLSf
	HvtYP11MMFHDUFIXAd4ugocDZzaEn1+baslcpzTBs2lXeR5rUo0sUtEX4YZnya0GEOe75ozgJVN
	KDg4qGkGOQUfdOpfu7RAKDJVlY7ssZcAb4cqUoAXQe
X-Gm-Gg: ASbGncv9T9F0UkHDaqfwXawHzs22JAZOOqfJoHvM8boWSklfJydUVGUrKfzHJnYiVTL
	AWMPacRZG3nfOC+60+xeW2URmzO5t1p86q+yknyDtVv3UI4hyVeqFTY0hBXcwuljDML5ehm5mBG
	IlD8fnbLmxIQn0b3GW/YuEp43PDVpuU6EHYnXivK1T9NRDMiVSTjOW94DXwJdDRnRa1ILnlY8eG
	mDQeeKq
X-Received: by 2002:a53:d01a:0:b0:635:4ecd:5fca with SMTP id 956f58d0204a3-6361a887144mr14069531d50.39.1759145355933;
        Mon, 29 Sep 2025 04:29:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG/g73Gu+JBOi4zs5bgkT1nwf1P0pcewTQ5ASwa5m2omUoT/pfLQzyL6V9ZhjfrasSXIekqqL35Xc4ZpyGCyxU=
X-Received: by 2002:a53:d01a:0:b0:635:4ecd:5fca with SMTP id
 956f58d0204a3-6361a887144mr14069511d50.39.1759145355363; Mon, 29 Sep 2025
 04:29:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250926101432.2251301-1-eperezma@redhat.com> <20250926101432.2251301-6-eperezma@redhat.com>
 <20250926112445-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250926112445-mutt-send-email-mst@kernel.org>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Mon, 29 Sep 2025 13:28:39 +0200
X-Gm-Features: AS18NWA6PuTGQsbUyyFSfcy0YaplErTQYiRyl2KNK0k91C-RJvn7u3sIizzmuMo
Message-ID: <CAJaqyWdcEZN4UxZ2j5RHVm4zXPtHsznya3QOZoEPvtGr+yTbew@mail.gmail.com>
Subject: Re: [PATCH v5 5/6] vduse: add vq group asid support
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Yongji Xie <xieyongji@bytedance.com>, linux-kernel@vger.kernel.org, 
	Maxime Coquelin <mcoqueli@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Cindy Lu <lulu@redhat.com>, 
	virtualization@lists.linux.dev, Laurent Vivier <lvivier@redhat.com>, jasowang@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 26, 2025 at 5:25=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Fri, Sep 26, 2025 at 12:14:31PM +0200, Eugenio P=C3=A9rez wrote:
> > Add support for assigning Address Space Identifiers (ASIDs) to each VQ
> > group.  This enables mapping each group into a distinct memory space.
> >
> > Now that the driver can change ASID in the middle of operation, the
> > domain that each vq address point is also protected by domain_lock.
> >
> > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > ---
> > v5:
> > * Properly return errno if copy_to_user returns >0 in VDUSE_IOTLB_GET_F=
D
> >   ioctl (Jason).
> > * Properly set domain bounce size to divide equally between nas (Jason)=
.
> > * Exclude "padding" member from the only >V1 members in
> >   vduse_dev_request.
> >
> > v4:
> > * Divide each domain bounce size between the device bounce size (Jason)=
.
> > * revert unneeded addr =3D NULL assignment (Jason)
> > * Change if (x && (y || z)) return to if (x) { if (y) return; if (z)
> >   return; } (Jason)
> > * Change a bad multiline comment, using @ caracter instead of * (Jason)=
.
> > * Consider config->nas =3D=3D 0 as a fail (Jason).
> >
> > v3:
> > * Get the vduse domain through the vduse_as in the map functions
> >   (Jason).
> > * Squash with the patch creating the vduse_as struct (Jason).
> > * Create VDUSE_DEV_MAX_AS instead of comparing agains a magic number
> >   (Jason)
> >
> > v2:
> > * Convert the use of mutex to rwlock.
> >
> > RFC v3:
> > * Increase VDUSE_MAX_VQ_GROUPS to 0xffff (Jason). It was set to a lower
> >   value to reduce memory consumption, but vqs are already limited to
> >   that value and userspace VDUSE is able to allocate that many vqs.
> > * Remove TODO about merging VDUSE_IOTLB_GET_FD ioctl with
> >   VDUSE_IOTLB_GET_INFO.
> > * Use of array_index_nospec in VDUSE device ioctls.
> > * Embed vduse_iotlb_entry into vduse_iotlb_entry_v2.
> > * Move the umem mutex to asid struct so there is no contention between
> >   ASIDs.
> >
> > RFC v2:
> > * Make iotlb entry the last one of vduse_iotlb_entry_v2 so the first
> >   part of the struct is the same.
> > ---
> >  drivers/vdpa/vdpa_user/vduse_dev.c | 335 ++++++++++++++++++++---------
> >  include/uapi/linux/vduse.h         |  53 ++++-
> >  2 files changed, 288 insertions(+), 100 deletions(-)
> >
> > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_use=
r/vduse_dev.c
> > index 3ce70e6524d5..731de08bb692 100644
> > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > @@ -42,6 +42,7 @@
> >
> >  #define VDUSE_DEV_MAX (1U << MINORBITS)
> >  #define VDUSE_DEV_MAX_GROUPS 0xffff
> > +#define VDUSE_DEV_MAX_AS 0xffff
> >  #define VDUSE_MAX_BOUNCE_SIZE (1024 * 1024 * 1024)
> >  #define VDUSE_MIN_BOUNCE_SIZE (1024 * 1024)
> >  #define VDUSE_BOUNCE_SIZE (64 * 1024 * 1024)
> > @@ -87,7 +88,14 @@ struct vduse_umem {
> >       struct mm_struct *mm;
> >  };
> >
> > +struct vduse_as {
> > +     struct vduse_iova_domain *domain;
> > +     struct vduse_umem *umem;
> > +     struct mutex mem_lock;
> > +};
> > +
> >  struct vduse_vq_group {
> > +     struct vduse_as *as;
> >       struct vduse_dev *dev;
> >  };
> >
> > @@ -95,7 +103,7 @@ struct vduse_dev {
> >       struct vduse_vdpa *vdev;
> >       struct device *dev;
> >       struct vduse_virtqueue **vqs;
> > -     struct vduse_iova_domain *domain;
> > +     struct vduse_as *as;
> >       char *name;
> >       struct mutex lock;
> >       spinlock_t msg_lock;
> > @@ -123,9 +131,8 @@ struct vduse_dev {
> >       u32 vq_num;
> >       u32 vq_align;
> >       u32 ngroups;
> > -     struct vduse_umem *umem;
> > +     u32 nas;
> >       struct vduse_vq_group *groups;
> > -     struct mutex mem_lock;
> >       unsigned int bounce_size;
> >       rwlock_t domain_lock;
> >  };
> > @@ -315,7 +322,7 @@ static int vduse_dev_set_status(struct vduse_dev *d=
ev, u8 status)
> >       return vduse_dev_msg_sync(dev, &msg);
> >  }
> >
> > -static int vduse_dev_update_iotlb(struct vduse_dev *dev,
> > +static int vduse_dev_update_iotlb(struct vduse_dev *dev, u32 asid,
> >                                 u64 start, u64 last)
> >  {
> >       struct vduse_dev_msg msg =3D { 0 };
> > @@ -324,8 +331,14 @@ static int vduse_dev_update_iotlb(struct vduse_dev=
 *dev,
> >               return -EINVAL;
> >
> >       msg.req.type =3D VDUSE_UPDATE_IOTLB;
> > -     msg.req.iova.start =3D start;
> > -     msg.req.iova.last =3D last;
> > +     if (dev->api_version < VDUSE_API_VERSION_1) {
> > +             msg.req.iova.start =3D start;
> > +             msg.req.iova.last =3D last;
> > +     } else {
> > +             msg.req.iova_v2.start =3D start;
> > +             msg.req.iova_v2.last =3D last;
> > +             msg.req.iova_v2.asid =3D asid;
> > +     }
> >
> >       return vduse_dev_msg_sync(dev, &msg);
> >  }
> > @@ -437,14 +450,29 @@ static __poll_t vduse_dev_poll(struct file *file,=
 poll_table *wait)
> >       return mask;
> >  }
> >
> > +/* Force set the asid to a vq group without a message to the VDUSE dev=
ice */
> > +static void vduse_set_group_asid_nomsg(struct vduse_dev *dev,
> > +                                    unsigned int group, unsigned int a=
sid)
> > +{
> > +     write_lock(&dev->domain_lock);
> > +     dev->groups[group].as =3D &dev->as[asid];
> > +     write_unlock(&dev->domain_lock);
> > +}
> > +
> >  static void vduse_dev_reset(struct vduse_dev *dev)
> >  {
> >       int i;
> > -     struct vduse_iova_domain *domain =3D dev->domain;
> >
> >       /* The coherent mappings are handled in vduse_dev_free_coherent()=
 */
> > -     if (domain && domain->bounce_map)
> > -             vduse_domain_reset_bounce_map(domain);
> > +     for (i =3D 0; i < dev->nas; i++) {
> > +             struct vduse_iova_domain *domain =3D dev->as[i].domain;
> > +
> > +             if (domain && domain->bounce_map)
> > +                     vduse_domain_reset_bounce_map(domain);
> > +     }
> > +
> > +     for (i =3D 0; i < dev->ngroups; i++)
> > +             vduse_set_group_asid_nomsg(dev, i, 0);
> >
> >       down_write(&dev->rwsem);
> >
> > @@ -624,6 +652,29 @@ static union virtio_map vduse_get_vq_map(struct vd=
pa_device *vdpa, u16 idx)
> >       return ret;
> >  }
> >
> > +static int vduse_set_group_asid(struct vdpa_device *vdpa, unsigned int=
 group,
> > +                             unsigned int asid)
> > +{
> > +     struct vduse_dev *dev =3D vdpa_to_vduse(vdpa);
> > +     struct vduse_dev_msg msg =3D { 0 };
> > +     int r;
> > +
> > +     if (dev->api_version < VDUSE_API_VERSION_1 ||
> > +         group >=3D dev->ngroups || asid >=3D dev->nas)
> > +             return -EINVAL;
> > +
> > +     msg.req.type =3D VDUSE_SET_VQ_GROUP_ASID;
> > +     msg.req.vq_group_asid.group =3D group;
> > +     msg.req.vq_group_asid.asid =3D asid;
> > +
> > +     r =3D vduse_dev_msg_sync(dev, &msg);
> > +     if (r < 0)
> > +             return r;
> > +
> > +     vduse_set_group_asid_nomsg(dev, group, asid);
> > +     return 0;
> > +}
> > +
> >  static int vduse_vdpa_get_vq_state(struct vdpa_device *vdpa, u16 idx,
> >                               struct vdpa_vq_state *state)
> >  {
> > @@ -795,13 +846,13 @@ static int vduse_vdpa_set_map(struct vdpa_device =
*vdpa,
> >       struct vduse_dev *dev =3D vdpa_to_vduse(vdpa);
> >       int ret;
> >
> > -     ret =3D vduse_domain_set_map(dev->domain, iotlb);
> > +     ret =3D vduse_domain_set_map(dev->as[asid].domain, iotlb);
> >       if (ret)
> >               return ret;
> >
> > -     ret =3D vduse_dev_update_iotlb(dev, 0ULL, ULLONG_MAX);
> > +     ret =3D vduse_dev_update_iotlb(dev, asid, 0ULL, ULLONG_MAX);
> >       if (ret) {
> > -             vduse_domain_clear_map(dev->domain, iotlb);
> > +             vduse_domain_clear_map(dev->as[asid].domain, iotlb);
> >               return ret;
> >       }
> >
> > @@ -844,6 +895,7 @@ static const struct vdpa_config_ops vduse_vdpa_conf=
ig_ops =3D {
> >       .get_vq_affinity        =3D vduse_vdpa_get_vq_affinity,
> >       .reset                  =3D vduse_vdpa_reset,
> >       .set_map                =3D vduse_vdpa_set_map,
> > +     .set_group_asid         =3D vduse_set_group_asid,
> >       .get_vq_map             =3D vduse_get_vq_map,
> >       .free                   =3D vduse_vdpa_free,
> >  };
> > @@ -859,9 +911,10 @@ static void vduse_dev_sync_single_for_device(union=
 virtio_map token,
> >               return;
> >
> >       vdev =3D token.group->dev;
> > -     domain =3D vdev->domain;
> > -
> > +     read_lock(&vdev->domain_lock);
> > +     domain =3D token.group->as->domain;
> >       vduse_domain_sync_single_for_device(domain, dma_addr, size, dir);
> > +     read_unlock(&vdev->domain_lock);
> >  }
> >
> >  static void vduse_dev_sync_single_for_cpu(union virtio_map token,
> > @@ -875,9 +928,10 @@ static void vduse_dev_sync_single_for_cpu(union vi=
rtio_map token,
> >               return;
> >
> >       vdev =3D token.group->dev;
> > -     domain =3D vdev->domain;
> > -
> > +     read_lock(&vdev->domain_lock);
> > +     domain =3D token.group->as->domain;
> >       vduse_domain_sync_single_for_cpu(domain, dma_addr, size, dir);
> > +     read_unlock(&vdev->domain_lock);
> >  }
> >
> >  static dma_addr_t vduse_dev_map_page(union virtio_map token, struct pa=
ge *page,
> > @@ -887,14 +941,18 @@ static dma_addr_t vduse_dev_map_page(union virtio=
_map token, struct page *page,
> >  {
> >       struct vduse_dev *vdev;
> >       struct vduse_iova_domain *domain;
> > +     dma_addr_t r;
> >
> >       if (!token.group)
> >               return DMA_MAPPING_ERROR;
> >
> >       vdev =3D token.group->dev;
> > -     domain =3D vdev->domain;
> > +     read_lock(&vdev->domain_lock);
> > +     domain =3D token.group->as->domain;
> > +     r =3D vduse_domain_map_page(domain, page, offset, size, dir, attr=
s);
> > +     read_unlock(&vdev->domain_lock);
> >
> > -     return vduse_domain_map_page(domain, page, offset, size, dir, att=
rs);
> > +     return r;
> >  }
> >
> >  static void vduse_dev_unmap_page(union virtio_map token, dma_addr_t dm=
a_addr,
> > @@ -908,9 +966,10 @@ static void vduse_dev_unmap_page(union virtio_map =
token, dma_addr_t dma_addr,
> >               return;
> >
> >       vdev =3D token.group->dev;
> > -     domain =3D vdev->domain;
> > -
> > -     return vduse_domain_unmap_page(domain, dma_addr, size, dir, attrs=
);
> > +     read_lock(&vdev->domain_lock);
> > +     domain =3D token.group->as->domain;
> > +     vduse_domain_unmap_page(domain, dma_addr, size, dir, attrs);
> > +     read_unlock(&vdev->domain_lock);
> >  }
> >
> >  static void *vduse_dev_alloc_coherent(union virtio_map token, size_t s=
ize,
> > @@ -926,14 +985,14 @@ static void *vduse_dev_alloc_coherent(union virti=
o_map token, size_t size,
> >               return NULL;
> >
> >       vdev =3D token.group->dev;
> > -     domain =3D vdev->domain;
> > +     read_lock(&vdev->domain_lock);
> > +     domain =3D token.group->as->domain;
> >       addr =3D vduse_domain_alloc_coherent(domain, size,
> >                                          (dma_addr_t *)&iova, flag);
> > -     if (!addr)
> > -             return NULL;
> > -
> > -     *dma_addr =3D (dma_addr_t)iova;
> > +     if (addr)
> > +             *dma_addr =3D (dma_addr_t)iova;
> >
> > +     read_unlock(&vdev->domain_lock);
> >       return addr;
> >  }
> >
> > @@ -948,23 +1007,28 @@ static void vduse_dev_free_coherent(union virtio=
_map token, size_t size,
> >               return;
> >
> >       vdev =3D token.group->dev;
> > -     domain =3D vdev->domain;
> > -
> > +     read_lock(&vdev->domain_lock);
> > +     domain =3D token.group->as->domain;
> >       vduse_domain_free_coherent(domain, size, vaddr, dma_addr, attrs);
> > +     read_unlock(&vdev->domain_lock);
> >  }
> >
> >  static bool vduse_dev_need_sync(union virtio_map token, dma_addr_t dma=
_addr)
> >  {
> >       struct vduse_dev *vdev;
> >       struct vduse_iova_domain *domain;
> > +     size_t bounce_size;
> >
> >       if (!token.group)
> >               return false;
> >
> >       vdev =3D token.group->dev;
> > -     domain =3D vdev->domain;
> > +     read_lock(&vdev->domain_lock);
> > +     domain =3D token.group->as->domain;
> > +     bounce_size =3D domain->bounce_size;
> > +     read_unlock(&vdev->domain_lock);
> >
> > -     return dma_addr < domain->bounce_size;
> > +     return dma_addr < bounce_size;
> >  }
> >
> >  static int vduse_dev_mapping_error(union virtio_map token, dma_addr_t =
dma_addr)
> > @@ -978,14 +1042,18 @@ static size_t vduse_dev_max_mapping_size(union v=
irtio_map token)
> >  {
> >       struct vduse_dev *vdev;
> >       struct vduse_iova_domain *domain;
> > +     size_t bounce_size;
> >
> >       if (!token.group)
> >               return 0;
> >
> >       vdev =3D token.group->dev;
> > -     domain =3D vdev->domain;
> > +     read_lock(&vdev->domain_lock);
> > +     domain =3D token.group->as->domain;
> > +     bounce_size =3D domain->bounce_size;
> > +     read_unlock(&vdev->domain_lock);
> >
> > -     return domain->bounce_size;
> > +     return bounce_size;
> >  }
> >
> >  static const struct virtio_map_ops vduse_map_ops =3D {
> > @@ -1125,39 +1193,40 @@ static int vduse_dev_queue_irq_work(struct vdus=
e_dev *dev,
> >       return ret;
> >  }
> >
> > -static int vduse_dev_dereg_umem(struct vduse_dev *dev,
> > +static int vduse_dev_dereg_umem(struct vduse_dev *dev, u32 asid,
> >                               u64 iova, u64 size)
> >  {
> >       int ret;
> >
> > -     mutex_lock(&dev->mem_lock);
> > +     mutex_lock(&dev->as[asid].mem_lock);
> >       ret =3D -ENOENT;
> > -     if (!dev->umem)
> > +     if (!dev->as[asid].umem)
> >               goto unlock;
> >
> >       ret =3D -EINVAL;
> > -     if (!dev->domain)
> > +     if (!dev->as[asid].domain)
> >               goto unlock;
> >
> > -     if (dev->umem->iova !=3D iova || size !=3D dev->domain->bounce_si=
ze)
> > +     if (dev->as[asid].umem->iova !=3D iova ||
> > +         size !=3D dev->as[asid].domain->bounce_size)
> >               goto unlock;
> >
> > -     vduse_domain_remove_user_bounce_pages(dev->domain);
> > -     unpin_user_pages_dirty_lock(dev->umem->pages,
> > -                                 dev->umem->npages, true);
> > -     atomic64_sub(dev->umem->npages, &dev->umem->mm->pinned_vm);
> > -     mmdrop(dev->umem->mm);
> > -     vfree(dev->umem->pages);
> > -     kfree(dev->umem);
> > -     dev->umem =3D NULL;
> > +     vduse_domain_remove_user_bounce_pages(dev->as[asid].domain);
> > +     unpin_user_pages_dirty_lock(dev->as[asid].umem->pages,
> > +                                 dev->as[asid].umem->npages, true);
> > +     atomic64_sub(dev->as[asid].umem->npages, &dev->as[asid].umem->mm-=
>pinned_vm);
> > +     mmdrop(dev->as[asid].umem->mm);
> > +     vfree(dev->as[asid].umem->pages);
> > +     kfree(dev->as[asid].umem);
> > +     dev->as[asid].umem =3D NULL;
> >       ret =3D 0;
> >  unlock:
> > -     mutex_unlock(&dev->mem_lock);
> > +     mutex_unlock(&dev->as[asid].mem_lock);
> >       return ret;
> >  }
> >
> >  static int vduse_dev_reg_umem(struct vduse_dev *dev,
> > -                           u64 iova, u64 uaddr, u64 size)
> > +                           u32 asid, u64 iova, u64 uaddr, u64 size)
> >  {
> >       struct page **page_list =3D NULL;
> >       struct vduse_umem *umem =3D NULL;
> > @@ -1165,14 +1234,14 @@ static int vduse_dev_reg_umem(struct vduse_dev =
*dev,
> >       unsigned long npages, lock_limit;
> >       int ret;
> >
> > -     if (!dev->domain || !dev->domain->bounce_map ||
> > -         size !=3D dev->domain->bounce_size ||
> > +     if (!dev->as[asid].domain || !dev->as[asid].domain->bounce_map ||
> > +         size !=3D dev->as[asid].domain->bounce_size ||
> >           iova !=3D 0 || uaddr & ~PAGE_MASK)
> >               return -EINVAL;
> >
> > -     mutex_lock(&dev->mem_lock);
> > +     mutex_lock(&dev->as[asid].mem_lock);
> >       ret =3D -EEXIST;
> > -     if (dev->umem)
> > +     if (dev->as[asid].umem)
> >               goto unlock;
> >
> >       ret =3D -ENOMEM;
> > @@ -1196,7 +1265,7 @@ static int vduse_dev_reg_umem(struct vduse_dev *d=
ev,
> >               goto out;
> >       }
> >
> > -     ret =3D vduse_domain_add_user_bounce_pages(dev->domain,
> > +     ret =3D vduse_domain_add_user_bounce_pages(dev->as[asid].domain,
> >                                                page_list, pinned);
> >       if (ret)
> >               goto out;
> > @@ -1209,7 +1278,7 @@ static int vduse_dev_reg_umem(struct vduse_dev *d=
ev,
> >       umem->mm =3D current->mm;
> >       mmgrab(current->mm);
> >
> > -     dev->umem =3D umem;
> > +     dev->as[asid].umem =3D umem;
> >  out:
> >       if (ret && pinned > 0)
> >               unpin_user_pages(page_list, pinned);
> > @@ -1220,7 +1289,7 @@ static int vduse_dev_reg_umem(struct vduse_dev *d=
ev,
> >               vfree(page_list);
> >               kfree(umem);
> >       }
> > -     mutex_unlock(&dev->mem_lock);
> > +     mutex_unlock(&dev->as[asid].mem_lock);
> >       return ret;
> >  }
> >
> > @@ -1252,47 +1321,66 @@ static long vduse_dev_ioctl(struct file *file, =
unsigned int cmd,
> >
> >       switch (cmd) {
> >       case VDUSE_IOTLB_GET_FD: {
> > -             struct vduse_iotlb_entry entry;
> > +             struct vduse_iotlb_entry_v2 entry;
> >               struct vhost_iotlb_map *map;
> >               struct vdpa_map_file *map_file;
> >               struct file *f =3D NULL;
> > +             u32 asid;
> >
> >               ret =3D -EFAULT;
> > -             if (copy_from_user(&entry, argp, sizeof(entry)))
> > -                     break;
> > +             if (dev->api_version >=3D VDUSE_API_VERSION_1) {
> > +                     if (copy_from_user(&entry, argp, sizeof(entry)))
> > +                             break;
> > +             } else {
> > +                     entry.asid =3D 0;
> > +                     if (copy_from_user(&entry.v1, argp,
> > +                                        sizeof(entry.v1)))
> > +                             break;
> > +             }
> >
> >               ret =3D -EINVAL;
> > -             if (entry.start > entry.last)
> > +             if (entry.v1.start > entry.v1.last)
> > +                     break;
> > +
> > +             if (entry.asid >=3D dev->nas)
> >                       break;
> >
> >               read_lock(&dev->domain_lock);
> > -             if (!dev->domain) {
> > +             asid =3D array_index_nospec(entry.asid, dev->nas);
> > +             if (!dev->as[asid].domain) {
> >                       read_unlock(&dev->domain_lock);
> >                       break;
> >               }
> > -             spin_lock(&dev->domain->iotlb_lock);
> > -             map =3D vhost_iotlb_itree_first(dev->domain->iotlb,
> > -                                           entry.start, entry.last);
> > +             spin_lock(&dev->as[asid].domain->iotlb_lock);
> > +             map =3D vhost_iotlb_itree_first(dev->as[asid].domain->iot=
lb,
> > +                                           entry.v1.start, entry.v1.la=
st);
> >               if (map) {
> >                       map_file =3D (struct vdpa_map_file *)map->opaque;
> >                       f =3D get_file(map_file->file);
> > -                     entry.offset =3D map_file->offset;
> > -                     entry.start =3D map->start;
> > -                     entry.last =3D map->last;
> > -                     entry.perm =3D map->perm;
> > +                     entry.v1.offset =3D map_file->offset;
> > +                     entry.v1.start =3D map->start;
> > +                     entry.v1.last =3D map->last;
> > +                     entry.v1.perm =3D map->perm;
> >               }
> > -             spin_unlock(&dev->domain->iotlb_lock);
> > +             spin_unlock(&dev->as[asid].domain->iotlb_lock);
> >               read_unlock(&dev->domain_lock);
> >               ret =3D -EINVAL;
> >               if (!f)
> >                       break;
> >
> > -             ret =3D -EFAULT;
> > -             if (copy_to_user(argp, &entry, sizeof(entry))) {
> > +             if (dev->api_version >=3D VDUSE_API_VERSION_1)
> > +                     ret =3D copy_to_user(argp, &entry,
> > +                                        sizeof(entry));
> > +             else
> > +                     ret =3D copy_to_user(argp, &entry.v1,
> > +                                        sizeof(entry.v1));
> > +
> > +             if (ret) {
> > +                     ret =3D -EFAULT;
> >                       fput(f);
> >                       break;
> >               }
> > -             ret =3D receive_fd(f, NULL, perm_to_file_flags(entry.perm=
));
> > +             ret =3D receive_fd(f, NULL, perm_to_file_flags(entry.v1.p=
erm));
> >               fput(f);
> >               break;
> >       }
> > @@ -1437,6 +1525,7 @@ static long vduse_dev_ioctl(struct file *file, un=
signed int cmd,
> >       }
> >       case VDUSE_IOTLB_REG_UMEM: {
> >               struct vduse_iova_umem umem;
> > +             u32 asid;
> >
> >               ret =3D -EFAULT;
> >               if (copy_from_user(&umem, argp, sizeof(umem)))
> > @@ -1444,17 +1533,21 @@ static long vduse_dev_ioctl(struct file *file, =
unsigned int cmd,
> >
> >               ret =3D -EINVAL;
> >               if (!is_mem_zero((const char *)umem.reserved,
> > -                              sizeof(umem.reserved)))
> > +                              sizeof(umem.reserved)) ||
> > +                 (dev->api_version < VDUSE_API_VERSION_1 &&
> > +                  umem.asid !=3D 0) || umem.asid >=3D dev->nas)
> >                       break;
> >
> >               write_lock(&dev->domain_lock);
> > -             ret =3D vduse_dev_reg_umem(dev, umem.iova,
> > +             asid =3D array_index_nospec(umem.asid, dev->nas);
> > +             ret =3D vduse_dev_reg_umem(dev, asid, umem.iova,
> >                                        umem.uaddr, umem.size);
> >               write_unlock(&dev->domain_lock);
> >               break;
> >       }
> >       case VDUSE_IOTLB_DEREG_UMEM: {
> >               struct vduse_iova_umem umem;
> > +             u32 asid;
> >
> >               ret =3D -EFAULT;
> >               if (copy_from_user(&umem, argp, sizeof(umem)))
> > @@ -1462,10 +1555,15 @@ static long vduse_dev_ioctl(struct file *file, =
unsigned int cmd,
> >
> >               ret =3D -EINVAL;
> >               if (!is_mem_zero((const char *)umem.reserved,
> > -                              sizeof(umem.reserved)))
> > +                              sizeof(umem.reserved)) ||
> > +                 (dev->api_version < VDUSE_API_VERSION_1 &&
> > +                  umem.asid !=3D 0) ||
> > +                  umem.asid >=3D dev->nas)
> >                       break;
> > +
> >               write_lock(&dev->domain_lock);
> > -             ret =3D vduse_dev_dereg_umem(dev, umem.iova,
> > +             asid =3D array_index_nospec(umem.asid, dev->nas);
> > +             ret =3D vduse_dev_dereg_umem(dev, asid, umem.iova,
> >                                          umem.size);
> >               write_unlock(&dev->domain_lock);
> >               break;
> > @@ -1473,6 +1571,7 @@ static long vduse_dev_ioctl(struct file *file, un=
signed int cmd,
> >       case VDUSE_IOTLB_GET_INFO: {
> >               struct vduse_iova_info info;
> >               struct vhost_iotlb_map *map;
> > +             u32 asid;
> >
> >               ret =3D -EFAULT;
> >               if (copy_from_user(&info, argp, sizeof(info)))
> > @@ -1486,23 +1585,31 @@ static long vduse_dev_ioctl(struct file *file, =
unsigned int cmd,
> >                                sizeof(info.reserved)))
> >                       break;
> >
> > +             if (dev->api_version < VDUSE_API_VERSION_1) {
> > +                     if (info.asid)
> > +                             break;
> > +             } else if (info.asid >=3D dev->nas)
> > +                     break;
> > +
> >               read_lock(&dev->domain_lock);
> > -             if (!dev->domain) {
> > +             asid =3D array_index_nospec(info.asid, dev->nas);
> > +             if (!dev->as[asid].domain) {
> >                       read_unlock(&dev->domain_lock);
> >                       break;
> >               }
> > -             spin_lock(&dev->domain->iotlb_lock);
> > -             map =3D vhost_iotlb_itree_first(dev->domain->iotlb,
> > +             spin_lock(&dev->as[asid].domain->iotlb_lock);
> > +             map =3D vhost_iotlb_itree_first(dev->as[asid].domain->iot=
lb,
> >                                             info.start, info.last);
> >               if (map) {
> >                       info.start =3D map->start;
> >                       info.last =3D map->last;
> >                       info.capability =3D 0;
> > -                     if (dev->domain->bounce_map && map->start =3D=3D =
0 &&
> > -                         map->last =3D=3D dev->domain->bounce_size - 1=
)
> > +                     if (dev->as[asid].domain->bounce_map &&
> > +                         map->start =3D=3D 0 &&
> > +                         map->last =3D=3D dev->as[asid].domain->bounce=
_size - 1)
> >                               info.capability |=3D VDUSE_IOVA_CAP_UMEM;
> >               }
> > -             spin_unlock(&dev->domain->iotlb_lock);
> > +             spin_unlock(&dev->as[asid].domain->iotlb_lock);
> >               read_unlock(&dev->domain_lock);
> >               if (!map)
> >                       break;
> > @@ -1527,8 +1634,10 @@ static int vduse_dev_release(struct inode *inode=
, struct file *file)
> >       struct vduse_dev *dev =3D file->private_data;
> >
> >       write_lock(&dev->domain_lock);
> > -     if (dev->domain)
> > -             vduse_dev_dereg_umem(dev, 0, dev->domain->bounce_size);
> > +     for (int i =3D 0; i < dev->nas; i++)
> > +             if (dev->as[i].domain)
> > +                     vduse_dev_dereg_umem(dev, i, 0,
> > +                                          dev->as[i].domain->bounce_si=
ze);
> >       write_unlock(&dev->domain_lock);
> >       spin_lock(&dev->msg_lock);
> >       /* Make sure the inflight messages can processed after reconncect=
ion */
> > @@ -1747,7 +1856,6 @@ static struct vduse_dev *vduse_dev_create(void)
> >               return NULL;
> >
> >       mutex_init(&dev->lock);
> > -     mutex_init(&dev->mem_lock);
> >       rwlock_init(&dev->domain_lock);
> >       spin_lock_init(&dev->msg_lock);
> >       INIT_LIST_HEAD(&dev->send_list);
> > @@ -1798,8 +1906,11 @@ static int vduse_destroy_dev(char *name)
> >       idr_remove(&vduse_idr, dev->minor);
> >       kvfree(dev->config);
> >       vduse_dev_deinit_vqs(dev);
> > -     if (dev->domain)
> > -             vduse_domain_destroy(dev->domain);
> > +     for (int i =3D 0; i < dev->nas; i++) {
> > +             if (dev->as[i].domain)
> > +                     vduse_domain_destroy(dev->as[i].domain);
> > +     }
> > +     kfree(dev->as);
> >       kfree(dev->name);
> >       kfree(dev->groups);
> >       vduse_dev_destroy(dev);
> > @@ -1846,12 +1957,17 @@ static bool vduse_validate_config(struct vduse_=
dev_config *config,
> >                        sizeof(config->reserved)))
> >               return false;
> >
> > -     if (api_version < VDUSE_API_VERSION_1 && config->ngroups)
> > +     if (api_version < VDUSE_API_VERSION_1 &&
> > +         (config->ngroups || config->nas))
> >               return false;
> >
> > -     if (api_version >=3D VDUSE_API_VERSION_1 &&
> > -         (!config->ngroups || config->ngroups > VDUSE_DEV_MAX_GROUPS))
> > -             return false;
> > +     if (api_version >=3D VDUSE_API_VERSION_1) {
> > +             if (!config->ngroups || config->ngroups > VDUSE_DEV_MAX_G=
ROUPS)
> > +                     return false;
> > +
> > +             if (!config->nas || config->nas > VDUSE_DEV_MAX_AS)
> > +                     return false;
> > +     }
> >
> >       if (config->vq_align > PAGE_SIZE)
> >               return false;
> > @@ -1916,7 +2032,8 @@ static ssize_t bounce_size_store(struct device *d=
evice,
> >
> >       ret =3D -EPERM;
> >       write_lock(&dev->domain_lock);
> > -     if (dev->domain)
> > +     /* Assuming that if the first domain is allocated, all are alloca=
ted */
> > +     if (dev->as[0].domain)
> >               goto unlock;
> >
> >       ret =3D kstrtouint(buf, 10, &bounce_size);
> > @@ -1976,6 +2093,13 @@ static int vduse_create_dev(struct vduse_dev_con=
fig *config,
> >       for (u32 i =3D 0; i < dev->ngroups; ++i)
> >               dev->groups[i].dev =3D dev;
> >
> > +     dev->nas =3D (dev->api_version < 1) ? 1 : config->nas;
>
> Is this "< 1" here same as VDUSE_API_VERSION_1 ? Maybe use that then.
>

Right, fixing in v6, thanks!


