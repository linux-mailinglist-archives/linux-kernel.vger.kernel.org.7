Return-Path: <linux-kernel+bounces-820254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B76FEB7CF9D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:15:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45F23480818
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 08:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 698263043AC;
	Wed, 17 Sep 2025 08:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cmAyoYWk"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ACB530ACF3
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 08:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758098222; cv=none; b=MuIayGjfBWQMLw1U4z3cDaf/jN8uGjecZTHLhvSP2PHX8tYAHiF2dKuW7kCZBg+0aDKO3sPzW+40C3aJNWkvbQ8/W3ADMPN8tTIaVPicQFlFTiAYka0G3foPP8+KsUbr9OI1ZlzthlsW2WHvGQYGqI+xY6JM4XBvBzR3m6pW0/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758098222; c=relaxed/simple;
	bh=mtdwjpppQuMYOYtHvgA3BLkqkWiPCjQmZHjBoBL53Qg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oFowcAsHlHPmWhHw8eJxUeJRf641KTFjpl2VkaOeYKKBoJDNRk3yMLpbB2LCRKVarT4qzbCC4AIm0Kvdl40bvd5L5yIESvLEYvN9ce0n33ePHf2m8uWNtyuNlcBCiCUPuO1IOQmA4Y5mjDOO5ztWAsJ9rbMBBKVZ2Xb+BKb01xA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cmAyoYWk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758098219;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZO090sKfTZEMJYwRNikVJVW8jUDpl6sZ6AO04VdsuYE=;
	b=cmAyoYWk3QePvviygWf6nlsFD1EpfzMcgJ55ItdHwNm9bP0phICmqJGdUbNNCclQuUp+Ai
	Nik3LmMfodG4H1kaA/GPbYflxzcWtQmj8UaANwxPH63j7ut0Lrfy+/xk3RFVxsHufBuu6s
	wq8+17jz+Dyp32XqXMqxpOVo+nD9mA0=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-599-8qNwvoWTPyuLsZGLG_sSvA-1; Wed, 17 Sep 2025 04:36:55 -0400
X-MC-Unique: 8qNwvoWTPyuLsZGLG_sSvA-1
X-Mimecast-MFC-AGG-ID: 8qNwvoWTPyuLsZGLG_sSvA_1758098214
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b54b7cb9d30so5817856a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 01:36:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758098214; x=1758703014;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZO090sKfTZEMJYwRNikVJVW8jUDpl6sZ6AO04VdsuYE=;
        b=OYQ77In25+Q4wbtij53IM+uKFHKe5KgG2xNdxYKS2nsn5wOT1QuopGtL/eLE0VIFjh
         W6kThELdSYt0zX96bW3Q98hNosd0FEqFbtsUNemFL2YTp8VlKGG30NC99nGD/yJdShEO
         4f/2Q1hYYfFR9n14hWslkAJeznHIsEe2G5UiPmADRnAhQKHYeIUg/TogOwyNUS7C6q/8
         9Ajgm2F6EkadGVZlBH5CDAjzjbaQvqadrWN2IWBGvevHOWHbsLF6KIsCupnRlt19XF0P
         DAK0hyyFf1KEnOfbqwoeNZfdkx3lG9vo8QM5nYVR7ElJLPeA6onAcJiLEOR+/A1GK4VJ
         WnlQ==
X-Forwarded-Encrypted: i=1; AJvYcCW+bDIPqnvpx4gPPly2ybs7ADkgD2xv4iiOhi7c6hN6N8KNzU6wBZim0hRZWXDsHh7agwiNGHMq9npMBWQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YztBw42OrKD++xFfBHTa4S0uz67jRyexRMrk5LClXXQ/P2x5n/T
	jILmML/1kdQIYM5no8APQ48yYFSxykkkubVuNfTxGQPPlg7S2a/iL3fVQr+jDLeAOH82gq7qCbg
	ENWE1N3Bvh27C9UUbbhe30Xya+l24drj4Prou4BhgNO+4269XAnQqU20ENGML/Bkwa7aMrMO4V/
	pdtIMdqh6OY94yRLiXMGZeAFm7QjOS347+HO7NV3x/
X-Gm-Gg: ASbGncv1mvpb3gQnatHB2xmNo3Euhl+vg2zA1KtSHf+O5wqQdT/dhnrtajIXopL7PHb
	+k0Uu2dNihhglW7xF64d9lHs6EgLA0ZQz0zlB94oTgV5AvIGHcJb4QwbFRmoAhORMqx0OrncUD5
	aDiShuZEv6Q5lhQAjhwg==
X-Received: by 2002:a05:6a20:3d05:b0:243:b3e2:ca07 with SMTP id adf61e73a8af0-27ab81613efmr1868857637.58.1758098214231;
        Wed, 17 Sep 2025 01:36:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGob8kyHak87Gd1ib5FpUZgzKA2iunl8JSl9iFDu6+BKTmDjmymMDjhF+A303gZi84HYTtXhb58wiGpAb9YSaM=
X-Received: by 2002:a05:6a20:3d05:b0:243:b3e2:ca07 with SMTP id
 adf61e73a8af0-27ab81613efmr1868818637.58.1758098213766; Wed, 17 Sep 2025
 01:36:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916130833.329087-1-eperezma@redhat.com> <20250916130833.329087-3-eperezma@redhat.com>
In-Reply-To: <20250916130833.329087-3-eperezma@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 17 Sep 2025 16:36:42 +0800
X-Gm-Features: AS18NWBP8Pwo30SbuEqdrKv5Y0rlJF8L0BtuNswrz5Nzc-YpJTlgxpRv6bDffgo
Message-ID: <CACGkMEsNTtD9nc7dRi9LH4jwh37kXQgM2WjbJfoz-MsHFe750Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] vduse: make domain_lock an rwlock
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
> It will be used in a few more scenarios read-only so make it more
> scalable.
>
> Suggested-by: Xie Yongji <xieyongji@bytedance.com>
> Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


> ---
> v2: New in v2
> ---
>  drivers/vdpa/vdpa_user/vduse_dev.c | 41 +++++++++++++++---------------
>  1 file changed, 21 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/=
vduse_dev.c
> index e7bced0b5542..2b6a8958ffe0 100644
> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> @@ -14,6 +14,7 @@
>  #include <linux/cdev.h>
>  #include <linux/device.h>
>  #include <linux/eventfd.h>
> +#include <linux/rwlock.h>
>  #include <linux/slab.h>
>  #include <linux/wait.h>
>  #include <linux/dma-map-ops.h>
> @@ -117,7 +118,7 @@ struct vduse_dev {
>         struct vduse_umem *umem;
>         struct mutex mem_lock;
>         unsigned int bounce_size;
> -       struct mutex domain_lock;
> +       rwlock_t domain_lock;
>  };
>
>  struct vduse_dev_msg {
> @@ -1176,9 +1177,9 @@ static long vduse_dev_ioctl(struct file *file, unsi=
gned int cmd,
>                 if (entry.start > entry.last)
>                         break;
>
> -               mutex_lock(&dev->domain_lock);
> +               read_lock(&dev->domain_lock);
>                 if (!dev->domain) {
> -                       mutex_unlock(&dev->domain_lock);
> +                       read_unlock(&dev->domain_lock);
>                         break;
>                 }
>                 spin_lock(&dev->domain->iotlb_lock);
> @@ -1193,7 +1194,7 @@ static long vduse_dev_ioctl(struct file *file, unsi=
gned int cmd,
>                         entry.perm =3D map->perm;
>                 }
>                 spin_unlock(&dev->domain->iotlb_lock);
> -               mutex_unlock(&dev->domain_lock);
> +               read_unlock(&dev->domain_lock);
>                 ret =3D -EINVAL;
>                 if (!f)
>                         break;
> @@ -1346,10 +1347,10 @@ static long vduse_dev_ioctl(struct file *file, un=
signed int cmd,
>                                  sizeof(umem.reserved)))
>                         break;
>
> -               mutex_lock(&dev->domain_lock);
> +               write_lock(&dev->domain_lock);
>                 ret =3D vduse_dev_reg_umem(dev, umem.iova,
>                                          umem.uaddr, umem.size);
> -               mutex_unlock(&dev->domain_lock);
> +               write_unlock(&dev->domain_lock);
>                 break;
>         }
>         case VDUSE_IOTLB_DEREG_UMEM: {
> @@ -1363,10 +1364,10 @@ static long vduse_dev_ioctl(struct file *file, un=
signed int cmd,
>                 if (!is_mem_zero((const char *)umem.reserved,
>                                  sizeof(umem.reserved)))
>                         break;
> -               mutex_lock(&dev->domain_lock);
> +               write_lock(&dev->domain_lock);
>                 ret =3D vduse_dev_dereg_umem(dev, umem.iova,
>                                            umem.size);
> -               mutex_unlock(&dev->domain_lock);
> +               write_unlock(&dev->domain_lock);
>                 break;
>         }
>         case VDUSE_IOTLB_GET_INFO: {
> @@ -1385,9 +1386,9 @@ static long vduse_dev_ioctl(struct file *file, unsi=
gned int cmd,
>                                  sizeof(info.reserved)))
>                         break;
>
> -               mutex_lock(&dev->domain_lock);
> +               read_lock(&dev->domain_lock);
>                 if (!dev->domain) {
> -                       mutex_unlock(&dev->domain_lock);
> +                       read_unlock(&dev->domain_lock);
>                         break;
>                 }
>                 spin_lock(&dev->domain->iotlb_lock);
> @@ -1402,7 +1403,7 @@ static long vduse_dev_ioctl(struct file *file, unsi=
gned int cmd,
>                                 info.capability |=3D VDUSE_IOVA_CAP_UMEM;
>                 }
>                 spin_unlock(&dev->domain->iotlb_lock);
> -               mutex_unlock(&dev->domain_lock);
> +               read_unlock(&dev->domain_lock);
>                 if (!map)
>                         break;
>
> @@ -1425,10 +1426,10 @@ static int vduse_dev_release(struct inode *inode,=
 struct file *file)
>  {
>         struct vduse_dev *dev =3D file->private_data;
>
> -       mutex_lock(&dev->domain_lock);
> +       write_lock(&dev->domain_lock);
>         if (dev->domain)
>                 vduse_dev_dereg_umem(dev, 0, dev->domain->bounce_size);
> -       mutex_unlock(&dev->domain_lock);
> +       write_unlock(&dev->domain_lock);
>         spin_lock(&dev->msg_lock);
>         /* Make sure the inflight messages can processed after reconncect=
ion */
>         list_splice_init(&dev->recv_list, &dev->send_list);
> @@ -1647,7 +1648,7 @@ static struct vduse_dev *vduse_dev_create(void)
>
>         mutex_init(&dev->lock);
>         mutex_init(&dev->mem_lock);
> -       mutex_init(&dev->domain_lock);
> +       rwlock_init(&dev->domain_lock);
>         spin_lock_init(&dev->msg_lock);
>         INIT_LIST_HEAD(&dev->send_list);
>         INIT_LIST_HEAD(&dev->recv_list);
> @@ -1805,7 +1806,7 @@ static ssize_t bounce_size_store(struct device *dev=
ice,
>         int ret;
>
>         ret =3D -EPERM;
> -       mutex_lock(&dev->domain_lock);
> +       write_lock(&dev->domain_lock);
>         if (dev->domain)
>                 goto unlock;
>
> @@ -1821,7 +1822,7 @@ static ssize_t bounce_size_store(struct device *dev=
ice,
>         dev->bounce_size =3D bounce_size & PAGE_MASK;
>         ret =3D count;
>  unlock:
> -       mutex_unlock(&dev->domain_lock);
> +       write_unlock(&dev->domain_lock);
>         return ret;
>  }
>
> @@ -2045,11 +2046,11 @@ static int vdpa_dev_add(struct vdpa_mgmt_dev *mde=
v, const char *name,
>         if (ret)
>                 return ret;
>
> -       mutex_lock(&dev->domain_lock);
> +       write_lock(&dev->domain_lock);
>         if (!dev->domain)
>                 dev->domain =3D vduse_domain_create(VDUSE_IOVA_SIZE - 1,
>                                                   dev->bounce_size);
> -       mutex_unlock(&dev->domain_lock);
> +       write_unlock(&dev->domain_lock);
>         if (!dev->domain) {
>                 put_device(&dev->vdev->vdpa.dev);
>                 return -ENOMEM;
> @@ -2059,10 +2060,10 @@ static int vdpa_dev_add(struct vdpa_mgmt_dev *mde=
v, const char *name,
>         ret =3D _vdpa_register_device(&dev->vdev->vdpa, dev->vq_num);
>         if (ret) {
>                 put_device(&dev->vdev->vdpa.dev);
> -               mutex_lock(&dev->domain_lock);
> +               write_lock(&dev->domain_lock);
>                 vduse_domain_destroy(dev->domain);
>                 dev->domain =3D NULL;
> -               mutex_unlock(&dev->domain_lock);
> +               write_unlock(&dev->domain_lock);
>                 return ret;
>         }
>
> --
> 2.51.0
>


