Return-Path: <linux-kernel+bounces-820272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 83420B7D51F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:23:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC24A7B3863
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 08:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB9651D9663;
	Wed, 17 Sep 2025 08:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SVUDuU7Z"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A96B243376
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 08:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758098790; cv=none; b=KdcsuU5RQzJGou9KOEVGdxcL6o1DL388i/TrU/KmUEKzIodX4NjoZ4e0I45zhxUYREKbx2rbS+zDaT+dbdQFJ6UECe9vj5BlY0WP2gE72yMN1w8eqTirpB/0FYT5kaDRlT6gHeyvg1LN7SCh4f9bR2nWysOdMvsiY3RTgQ5l3NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758098790; c=relaxed/simple;
	bh=cnRnuTmqWokR0st6KNbm+ZTXvnMgTYcH0SllErVeXYQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UFWuGWIH/iXlM0VfInaI+w6e9zH7SzMi25CHjp9VSyS1tK/oWO4107o79LL68imT4nZJ3zNwmE8VOqfj6mbAjOBQ1jY3M658CNmHjlG6yuhMTBaKZtL51j+FOtroAQR5+pLyHhmkm3SS07oOSXy4t+52XHRbKL5QTz59vbU5xJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SVUDuU7Z; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758098787;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6Gye+bjDsWOxOTnwFoI42tq+r6a7KYmtOU66t0gG6Sk=;
	b=SVUDuU7Zna7lh9LopDfX6HIh8CcsHMHH5GUwNELaASYsyTOit4LVfND17csM0EKf7IiSRz
	U8RO/xjRqQps/lo7U8A51loonDBok9Xm2JpPeFeEt35jCR2XAWRtaOnTA+QY7fQuXARLwB
	4Oid0f8C58UbQ4TAor1bPQlJwFlSQ+o=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-691-TTC3lW96OyyDtVyqmfspOw-1; Wed, 17 Sep 2025 04:46:25 -0400
X-MC-Unique: TTC3lW96OyyDtVyqmfspOw-1
X-Mimecast-MFC-AGG-ID: TTC3lW96OyyDtVyqmfspOw_1758098784
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3234811cab3so6049442a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 01:46:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758098784; x=1758703584;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Gye+bjDsWOxOTnwFoI42tq+r6a7KYmtOU66t0gG6Sk=;
        b=HGA+UXlWq5k1+ywmcPjAZcz/FHT5QsTpDWScy05d+a+nrYqK3W5+ILoErfQEmRfewP
         DEL7Ua+Bey4EWtegfxsY7dS8Yvf/EdIuubHSoNTLFu/osXXrp8jiRoBTUSZH036/T/+m
         X9LjngfSCQ2N2Ay/uT79ca8PeMCw9HLlnsX0IYJpylUwyRyArwFInmuADrbk+rAA9cdy
         gONh4JhLTYLY4mfkB+9k5U7JFLLfub8bJ/hnqCrhj54Vw775t+Ykl18/Zird6MaA01DJ
         FCkd0joN0olcNocmZi6m9Z8GKiAkPLa9+0ukqEgt/hDJm0Ug0r2MLwjmQ+hvAmwEY32e
         0MdQ==
X-Forwarded-Encrypted: i=1; AJvYcCWyuVi+gSCXBef9tzvqTYsH78m4MrVQgsxbt4QXHQxPh+QpZgKU4LTZM8IAX3JebzgrBDN7oMURp3avMZE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuBGSqJdocN34ilRHpH9hP+2OBEx74VV4g/Jae58Lac4t6OS4u
	Scn+AchJSQFicVwd5Uazkcs9formUB9tg2YrVcVs9j8afTS6Uf/Sb6SmIQihFaRFr+U8Y808I+z
	dyRhHPoc6Kcw7XWPiYVinPtru6Mx7xZ2DVYw4SGWMyolftVJ3oHVaogj2teStkq32oS8K1mrPl8
	s6k/+JAmgCEuG5y9SsRoUB4bi9XVUxvj3Kk60JJBY1
X-Gm-Gg: ASbGncud8o7/FoeST8r3WJMekw2eST733b/XBLvRcD6/Uq+0jgwzlsfZXioWUqOvNyN
	JMjt8Xzvu2QCzedNUWYXK06cwXZWS8gQlBGvqqQckhm3Sp71aqfyJxCbHPouX08CwaHxjKDqCA2
	eYM96fTGcKFjGZ4uP4cg==
X-Received: by 2002:a17:90a:d605:b0:330:3fb8:3885 with SMTP id 98e67ed59e1d1-3303fb83a10mr845996a91.18.1758098783929;
        Wed, 17 Sep 2025 01:46:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFJVsE5ysih0xV2mqDFvpn+uPOhI4Pb2YsUJhhidqZMBHLNxeCXT6hkCFyOnJRKVSQHp0/sWPQiJbmCJofA9I0=
X-Received: by 2002:a17:90a:d605:b0:330:3fb8:3885 with SMTP id
 98e67ed59e1d1-3303fb83a10mr845950a91.18.1758098783353; Wed, 17 Sep 2025
 01:46:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916130833.329087-1-eperezma@redhat.com> <20250916130833.329087-6-eperezma@redhat.com>
In-Reply-To: <20250916130833.329087-6-eperezma@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 17 Sep 2025 16:46:12 +0800
X-Gm-Features: AS18NWA9wlZ0JFShswYM5_tCS_8Acy0CU2heVFPfl4cfU88_W9Els6o-kW32OgM
Message-ID: <CACGkMEtp61-OB2EpuMY+SWd2b1yShGwfTCNuw9xtMC5YdkpQkQ@mail.gmail.com>
Subject: Re: [PATCH v2 5/7] vduse: create vduse_as to make it an array
To: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, linux-kernel@vger.kernel.org, 
	Maxime Coquelin <mcoqueli@redhat.com>, Yongji Xie <xieyongji@bytedance.com>, 
	Cindy Lu <lulu@redhat.com>, Laurent Vivier <lvivier@redhat.com>, virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2025 at 9:09=E2=80=AFPM Eugenio P=C3=A9rez <eperezma@redhat=
.com> wrote:
>
> This is a first step so we can make more than one different address
> spaces.  No change on the colde flow intended.
>
> Acked-by: Jason Wang <jasowang@redhat.com>

Sorry, I think I found something new.

> Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> ---
>  drivers/vdpa/vdpa_user/vduse_dev.c | 114 +++++++++++++++--------------
>  1 file changed, 59 insertions(+), 55 deletions(-)
>
> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/=
vduse_dev.c
> index 9c12ae72abc2..b45b1d22784f 100644
> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> @@ -86,6 +86,12 @@ struct vduse_umem {
>         struct mm_struct *mm;
>  };
>
> +struct vduse_as {
> +       struct vduse_iova_domain *domain;
> +       struct vduse_umem *umem;
> +       struct mutex mem_lock;
> +};
> +
>  struct vduse_vq_group_int {
>         struct vduse_dev *dev;

I would expect this has an indirection for as. E.g unsigned int as;

>  };
> @@ -94,7 +100,7 @@ struct vduse_dev {
>         struct vduse_vdpa *vdev;
>         struct device *dev;
>         struct vduse_virtqueue **vqs;
> -       struct vduse_iova_domain *domain;
> +       struct vduse_as as;

This needs to be an array per title:

"vduse: create vduse_as to make it an array"

>         char *name;
>         struct mutex lock;
>         spinlock_t msg_lock;
> @@ -122,9 +128,7 @@ struct vduse_dev {
>         u32 vq_num;
>         u32 vq_align;
>         u32 ngroups;
> -       struct vduse_umem *umem;
>         struct vduse_vq_group_int *groups;
> -       struct mutex mem_lock;
>         unsigned int bounce_size;
>         rwlock_t domain_lock;
>  };
> @@ -439,7 +443,7 @@ static __poll_t vduse_dev_poll(struct file *file, pol=
l_table *wait)
>  static void vduse_dev_reset(struct vduse_dev *dev)
>  {
>         int i;
> -       struct vduse_iova_domain *domain =3D dev->domain;
> +       struct vduse_iova_domain *domain =3D dev->as.domain;

This should be an iteration of all address spaces?

>
>         /* The coherent mappings are handled in vduse_dev_free_coherent()=
 */
>         if (domain && domain->bounce_map)
> @@ -788,13 +792,13 @@ static int vduse_vdpa_set_map(struct vdpa_device *v=
dpa,
>         struct vduse_dev *dev =3D vdpa_to_vduse(vdpa);
>         int ret;
>
> -       ret =3D vduse_domain_set_map(dev->domain, iotlb);
> +       ret =3D vduse_domain_set_map(dev->as.domain, iotlb);

The as should be indexed by asid here or I think i miss something. Or
at least fail with asid !=3D 0?

>         if (ret)
>                 return ret;
>
>         ret =3D vduse_dev_update_iotlb(dev, 0ULL, ULLONG_MAX);
>         if (ret) {
> -               vduse_domain_clear_map(dev->domain, iotlb);
> +               vduse_domain_clear_map(dev->as.domain, iotlb);
>                 return ret;
>         }
>
> @@ -846,7 +850,7 @@ static void vduse_dev_sync_single_for_device(union vi=
rtio_map token,
>                                              enum dma_data_direction dir)
>  {
>         struct vduse_dev *vdev =3D token.group->dev;
> -       struct vduse_iova_domain *domain =3D vdev->domain;
> +       struct vduse_iova_domain *domain =3D vdev->as.domain;

The address space should be fetched from the virtqueue group instead
of the hard-coded one.

>
>         vduse_domain_sync_single_for_device(domain, dma_addr, size, dir);
>  }
> @@ -856,7 +860,7 @@ static void vduse_dev_sync_single_for_cpu(union virti=
o_map token,
>                                              enum dma_data_direction dir)
>  {
>         struct vduse_dev *vdev =3D token.group->dev;
> -       struct vduse_iova_domain *domain =3D vdev->domain;
> +       struct vduse_iova_domain *domain =3D vdev->as.domain;
>
>         vduse_domain_sync_single_for_cpu(domain, dma_addr, size, dir);
>  }
> @@ -867,7 +871,7 @@ static dma_addr_t vduse_dev_map_page(union virtio_map=
 token, struct page *page,
>                                      unsigned long attrs)
>  {
>         struct vduse_dev *vdev =3D token.group->dev;
> -       struct vduse_iova_domain *domain =3D vdev->domain;
> +       struct vduse_iova_domain *domain =3D vdev->as.domain;
>
>         return vduse_domain_map_page(domain, page, offset, size, dir, att=
rs);
>  }
> @@ -877,7 +881,7 @@ static void vduse_dev_unmap_page(union virtio_map tok=
en, dma_addr_t dma_addr,
>                                  unsigned long attrs)
>  {
>         struct vduse_dev *vdev =3D token.group->dev;
> -       struct vduse_iova_domain *domain =3D vdev->domain;
> +       struct vduse_iova_domain *domain =3D vdev->as.domain;
>
>         return vduse_domain_unmap_page(domain, dma_addr, size, dir, attrs=
);
>  }
> @@ -886,7 +890,7 @@ static void *vduse_dev_alloc_coherent(union virtio_ma=
p token, size_t size,
>                                       dma_addr_t *dma_addr, gfp_t flag)
>  {
>         struct vduse_dev *vdev =3D token.group->dev;
> -       struct vduse_iova_domain *domain =3D vdev->domain;
> +       struct vduse_iova_domain *domain =3D vdev->as.domain;
>         unsigned long iova;
>         void *addr;
>
> @@ -906,7 +910,7 @@ static void vduse_dev_free_coherent(union virtio_map =
token, size_t size,
>                                     unsigned long attrs)
>  {
>         struct vduse_dev *vdev =3D token.group->dev;
> -       struct vduse_iova_domain *domain =3D vdev->domain;
> +       struct vduse_iova_domain *domain =3D vdev->as.domain;
>
>         vduse_domain_free_coherent(domain, size, vaddr, dma_addr, attrs);
>  }
> @@ -914,7 +918,7 @@ static void vduse_dev_free_coherent(union virtio_map =
token, size_t size,
>  static bool vduse_dev_need_sync(union virtio_map token, dma_addr_t dma_a=
ddr)
>  {
>         struct vduse_dev *vdev =3D token.group->dev;
> -       struct vduse_iova_domain *domain =3D vdev->domain;
> +       struct vduse_iova_domain *domain =3D vdev->as.domain;
>
>         return dma_addr < domain->bounce_size;
>  }
> @@ -929,7 +933,7 @@ static int vduse_dev_mapping_error(union virtio_map t=
oken, dma_addr_t dma_addr)
>  static size_t vduse_dev_max_mapping_size(union virtio_map token)
>  {
>         struct vduse_dev *vdev =3D token.group->dev;
> -       struct vduse_iova_domain *domain =3D vdev->domain;
> +       struct vduse_iova_domain *domain =3D vdev->as.domain;
>
>         return domain->bounce_size;
>  }
> @@ -1076,29 +1080,29 @@ static int vduse_dev_dereg_umem(struct vduse_dev =
*dev,
>  {
>         int ret;
>
> -       mutex_lock(&dev->mem_lock);
> +       mutex_lock(&dev->as.mem_lock);
>         ret =3D -ENOENT;
> -       if (!dev->umem)
> +       if (!dev->as.umem)
>                 goto unlock;
>
>         ret =3D -EINVAL;
> -       if (!dev->domain)
> +       if (!dev->as.domain)
>                 goto unlock;
>
> -       if (dev->umem->iova !=3D iova || size !=3D dev->domain->bounce_si=
ze)
> +       if (dev->as.umem->iova !=3D iova || size !=3D dev->as.domain->bou=
nce_size)

I think it would be better to assume ASID =3D 0 here to ease the future ext=
ension.

>                 goto unlock;
>
> -       vduse_domain_remove_user_bounce_pages(dev->domain);
> -       unpin_user_pages_dirty_lock(dev->umem->pages,
> -                                   dev->umem->npages, true);
> -       atomic64_sub(dev->umem->npages, &dev->umem->mm->pinned_vm);
> -       mmdrop(dev->umem->mm);
> -       vfree(dev->umem->pages);
> -       kfree(dev->umem);
> -       dev->umem =3D NULL;
> +       vduse_domain_remove_user_bounce_pages(dev->as.domain);
> +       unpin_user_pages_dirty_lock(dev->as.umem->pages,
> +                                   dev->as.umem->npages, true);
> +       atomic64_sub(dev->as.umem->npages, &dev->as.umem->mm->pinned_vm);
> +       mmdrop(dev->as.umem->mm);
> +       vfree(dev->as.umem->pages);
> +       kfree(dev->as.umem);
> +       dev->as.umem =3D NULL;
>         ret =3D 0;
>  unlock:
> -       mutex_unlock(&dev->mem_lock);
> +       mutex_unlock(&dev->as.mem_lock);
>         return ret;
>  }
>
> @@ -1111,14 +1115,14 @@ static int vduse_dev_reg_umem(struct vduse_dev *d=
ev,
>         unsigned long npages, lock_limit;
>         int ret;
>
> -       if (!dev->domain || !dev->domain->bounce_map ||
> -           size !=3D dev->domain->bounce_size ||
> +       if (!dev->as.domain || !dev->as.domain->bounce_map ||
> +           size !=3D dev->as.domain->bounce_size ||
>             iova !=3D 0 || uaddr & ~PAGE_MASK)
>                 return -EINVAL;
>
> -       mutex_lock(&dev->mem_lock);
> +       mutex_lock(&dev->as.mem_lock);
>         ret =3D -EEXIST;
> -       if (dev->umem)
> +       if (dev->as.umem)
>                 goto unlock;
>
>         ret =3D -ENOMEM;
> @@ -1142,7 +1146,7 @@ static int vduse_dev_reg_umem(struct vduse_dev *dev=
,
>                 goto out;
>         }
>
> -       ret =3D vduse_domain_add_user_bounce_pages(dev->domain,
> +       ret =3D vduse_domain_add_user_bounce_pages(dev->as.domain,
>                                                  page_list, pinned);
>         if (ret)
>                 goto out;
> @@ -1155,7 +1159,7 @@ static int vduse_dev_reg_umem(struct vduse_dev *dev=
,
>         umem->mm =3D current->mm;
>         mmgrab(current->mm);
>
> -       dev->umem =3D umem;
> +       dev->as.umem =3D umem;
>  out:
>         if (ret && pinned > 0)
>                 unpin_user_pages(page_list, pinned);
> @@ -1166,7 +1170,7 @@ static int vduse_dev_reg_umem(struct vduse_dev *dev=
,
>                 vfree(page_list);
>                 kfree(umem);
>         }
> -       mutex_unlock(&dev->mem_lock);
> +       mutex_unlock(&dev->as.mem_lock);
>         return ret;
>  }
>
> @@ -1212,12 +1216,12 @@ static long vduse_dev_ioctl(struct file *file, un=
signed int cmd,
>                         break;
>
>                 read_lock(&dev->domain_lock);
> -               if (!dev->domain) {
> +               if (!dev->as.domain) {
>                         read_unlock(&dev->domain_lock);
>                         break;
>                 }
> -               spin_lock(&dev->domain->iotlb_lock);
> -               map =3D vhost_iotlb_itree_first(dev->domain->iotlb,
> +               spin_lock(&dev->as.domain->iotlb_lock);
> +               map =3D vhost_iotlb_itree_first(dev->as.domain->iotlb,
>                                               entry.start, entry.last);
>                 if (map) {
>                         map_file =3D (struct vdpa_map_file *)map->opaque;
> @@ -1227,7 +1231,7 @@ static long vduse_dev_ioctl(struct file *file, unsi=
gned int cmd,
>                         entry.last =3D map->last;
>                         entry.perm =3D map->perm;
>                 }
> -               spin_unlock(&dev->domain->iotlb_lock);
> +               spin_unlock(&dev->as.domain->iotlb_lock);
>                 read_unlock(&dev->domain_lock);
>                 ret =3D -EINVAL;
>                 if (!f)
> @@ -1430,22 +1434,22 @@ static long vduse_dev_ioctl(struct file *file, un=
signed int cmd,
>                         break;
>
>                 read_lock(&dev->domain_lock);
> -               if (!dev->domain) {
> +               if (!dev->as.domain) {
>                         read_unlock(&dev->domain_lock);
>                         break;
>                 }
> -               spin_lock(&dev->domain->iotlb_lock);
> -               map =3D vhost_iotlb_itree_first(dev->domain->iotlb,
> +               spin_lock(&dev->as.domain->iotlb_lock);
> +               map =3D vhost_iotlb_itree_first(dev->as.domain->iotlb,
>                                               info.start, info.last);
>                 if (map) {
>                         info.start =3D map->start;
>                         info.last =3D map->last;
>                         info.capability =3D 0;
> -                       if (dev->domain->bounce_map && map->start =3D=3D =
0 &&
> -                           map->last =3D=3D dev->domain->bounce_size - 1=
)
> +                       if (dev->as.domain->bounce_map && map->start =3D=
=3D 0 &&
> +                           map->last =3D=3D dev->as.domain->bounce_size =
- 1)
>                                 info.capability |=3D VDUSE_IOVA_CAP_UMEM;
>                 }
> -               spin_unlock(&dev->domain->iotlb_lock);
> +               spin_unlock(&dev->as.domain->iotlb_lock);
>                 read_unlock(&dev->domain_lock);
>                 if (!map)
>                         break;
> @@ -1470,8 +1474,8 @@ static int vduse_dev_release(struct inode *inode, s=
truct file *file)
>         struct vduse_dev *dev =3D file->private_data;
>
>         write_lock(&dev->domain_lock);
> -       if (dev->domain)
> -               vduse_dev_dereg_umem(dev, 0, dev->domain->bounce_size);
> +       if (dev->as.domain)
> +               vduse_dev_dereg_umem(dev, 0, dev->as.domain->bounce_size)=
;
>         write_unlock(&dev->domain_lock);
>         spin_lock(&dev->msg_lock);
>         /* Make sure the inflight messages can processed after reconncect=
ion */
> @@ -1690,7 +1694,7 @@ static struct vduse_dev *vduse_dev_create(void)
>                 return NULL;
>
>         mutex_init(&dev->lock);
> -       mutex_init(&dev->mem_lock);
> +       mutex_init(&dev->as.mem_lock);
>         rwlock_init(&dev->domain_lock);
>         spin_lock_init(&dev->msg_lock);
>         INIT_LIST_HEAD(&dev->send_list);
> @@ -1741,8 +1745,8 @@ static int vduse_destroy_dev(char *name)
>         idr_remove(&vduse_idr, dev->minor);
>         kvfree(dev->config);
>         vduse_dev_deinit_vqs(dev);
> -       if (dev->domain)
> -               vduse_domain_destroy(dev->domain);
> +       if (dev->as.domain)
> +               vduse_domain_destroy(dev->as.domain);
>         kfree(dev->name);
>         kfree(dev->groups);
>         vduse_dev_destroy(dev);
> @@ -1858,7 +1862,7 @@ static ssize_t bounce_size_store(struct device *dev=
ice,
>
>         ret =3D -EPERM;
>         write_lock(&dev->domain_lock);
> -       if (dev->domain)
> +       if (dev->as.domain)
>                 goto unlock;
>
>         ret =3D kstrtouint(buf, 10, &bounce_size);
> @@ -2109,11 +2113,11 @@ static int vdpa_dev_add(struct vdpa_mgmt_dev *mde=
v, const char *name,
>                 return ret;
>
>         write_lock(&dev->domain_lock);
> -       if (!dev->domain)
> -               dev->domain =3D vduse_domain_create(VDUSE_IOVA_SIZE - 1,
> +       if (!dev->as.domain)
> +               dev->as.domain =3D vduse_domain_create(VDUSE_IOVA_SIZE - =
1,
>                                                   dev->bounce_size);
>         write_unlock(&dev->domain_lock);
> -       if (!dev->domain) {
> +       if (!dev->as.domain) {
>                 put_device(&dev->vdev->vdpa.dev);
>                 return -ENOMEM;
>         }
> @@ -2122,8 +2126,8 @@ static int vdpa_dev_add(struct vdpa_mgmt_dev *mdev,=
 const char *name,
>         if (ret) {
>                 put_device(&dev->vdev->vdpa.dev);
>                 write_lock(&dev->domain_lock);
> -               vduse_domain_destroy(dev->domain);
> -               dev->domain =3D NULL;
> +               vduse_domain_destroy(dev->as.domain);
> +               dev->as.domain =3D NULL;
>                 write_unlock(&dev->domain_lock);
>                 return ret;
>         }
> --
> 2.51.0
>

Thanks


