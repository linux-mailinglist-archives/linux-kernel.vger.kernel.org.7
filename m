Return-Path: <linux-kernel+bounces-846373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E167BC7BE9
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 09:43:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 419114EF96E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 07:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 225A0298CA4;
	Thu,  9 Oct 2025 07:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i2zakA3e"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C328619047A
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 07:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759995797; cv=none; b=pB9ATCui4knaNjIE0a9stC5P4S3Xc6P8Aa3Zk7bhRFQl6vZWzHJPNhYydz6PduDw4DeeAV5jtTtMk8AO5Fc3/jcAEfgJCLCCQWlgfPxUK8XHomDYbqY72JET5cgUNMV8tZ7QMZVyribbRjw5nSBZzZwMp8QjufIpj/BaVFrO5I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759995797; c=relaxed/simple;
	bh=zVKRcKBKy5UMg8zeg6DuVbbztfNrMDkWudL549E9dKE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R43KUZd+3qeJ/sspfvw3hCxBaQ5CMxKea3S/ODzT/Bk/kqy0wXo6VZhFtCoKGhgM5zf+iKtVE734Hs9fwuBVJiKRg85ncKECa7fDtYPwo9UB4H32Dcn0QhJ0ItLHlW/6ExWJcN6i1ZYHjSQOXnt1g8zKhxfehoTPslOXtei51Is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i2zakA3e; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759995794;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lqVlQjsLtQiDAss75C4CqbUYx6+KaJ0FeS0J3CR27eU=;
	b=i2zakA3ejJbfSsYVzus+fYA+km033HY8KDlxs2sVtQDISLL9QkkqXPhKaZJAw9DgAc01F8
	ooSXhaOZ0woN6kYf2xI7zAT7qx0MgKKLAjdlRv2niQ0eeCEh6m1lu364s/EJp/UpCqFX1i
	cw0No3Z747J8lxuMRQp+mQtZ5NxuTuI=
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-511-5sMhyZOgO9aPeL1ehh6k5g-1; Thu, 09 Oct 2025 03:43:13 -0400
X-MC-Unique: 5sMhyZOgO9aPeL1ehh6k5g-1
X-Mimecast-MFC-AGG-ID: 5sMhyZOgO9aPeL1ehh6k5g_1759995792
Received: by mail-ua1-f71.google.com with SMTP id a1e0cc1a2514c-89018ea59e0so1536788241.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 00:43:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759995792; x=1760600592;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lqVlQjsLtQiDAss75C4CqbUYx6+KaJ0FeS0J3CR27eU=;
        b=DySEbJ3bfzMRzERBsAFBETuC8LWVrYgNEeDbfd+ku+56O3WqCHXqyFjje535ZhpHEm
         FjcCya5WQjvgjWf0irY+Zf6rM9sLbQqQpKwPZ+WU1B+f3fbVVD3AxzemTD73t7l78jHE
         79atNObWNGaWgbhT13MhNYnT8/DyZU+46OjQuZ+Zn84OSAhUKxIs+feX9zuhyHfPZMHG
         pJI/G4NyVMbZH6oCs7sTWnQhD+v8Vpu0svzn19M2olYlQuc8Cm97Rn8ezhgGG/RjPnr2
         K/ZwABJ4/XP8u6Tj9Ql5J2NACqSXYuqWq9CH6Is+4vHiQZn0Gd5CtT9TiJTgmpsUwBqW
         rDig==
X-Forwarded-Encrypted: i=1; AJvYcCWVcnsdWmjTTH1LADMESEB9audYIGRBgRH16NTzEQxrNmUUg55LUebfz3ZuprTG8zkLo1Smzkw9bEB9et8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDHIVVq83kNPuLl7mKA4VUc2pqd7Yh8can+uAuF7h+0tbfArQz
	vTZyyGOSRsd1gwPz6redgW/i837UYZn66w2w+snUMtNWl5lyPLiTvTuM3EgwHwIL7J88pJRm+pc
	EeqM7+8/QwJTVRThjpw+PDyC/KXf9LHmnubRv+akjawcPFcrOs9v8Izrk+vvE/WhvKJT4mFgEID
	8+3slINDvn3z6+bN5jIh0CyIgh45K8MmAoJDMkaFmz
X-Gm-Gg: ASbGncuKeOAgqVElOuBTnZOOsChjGnmQQsp3Yub3I+aiJFab3MPUFQTG4E4N7eIyGk4
	jqcltsKCAgCTfFTF2AvMnjHwzawuTjz/V5hisGNfczLNG9bHWda6fHtI2MzAY8oWpFrlo6/BlVb
	tw2WL2ZgrLuIYHDCttJLg6nwQ=
X-Received: by 2002:a05:6102:512b:b0:5d3:ff01:363d with SMTP id ada2fe7eead31-5d5e2323bc3mr2727499137.21.1759995792618;
        Thu, 09 Oct 2025 00:43:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFuW1O6aYG322N90mSfPqM1yVoDXYbVpe62RkG9vN89i8vdM+utFjOpbEoXeVs+CeLXPaqVm14uwn8vmxLCF8o=
X-Received: by 2002:a05:6102:512b:b0:5d3:ff01:363d with SMTP id
 ada2fe7eead31-5d5e2323bc3mr2727489137.21.1759995792135; Thu, 09 Oct 2025
 00:43:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250929165213.2896034-1-eperezma@redhat.com> <20250929165213.2896034-7-eperezma@redhat.com>
In-Reply-To: <20250929165213.2896034-7-eperezma@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 9 Oct 2025 15:42:59 +0800
X-Gm-Features: AS18NWDNgO7BZAhdFYci_qhyrfWWjVvbQhFDVOL7yd0tvH6HgRQf74zWCfAymoU
Message-ID: <CACGkMEuRMXrt3zyQtrW8QvHJSVPqh5XGXtxBtir3UxGzjSmXOQ@mail.gmail.com>
Subject: Re: [PATCH v6 6/7] vduse: add vq group asid support
To: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Laurent Vivier <lvivier@redhat.com>, 
	Yongji Xie <xieyongji@bytedance.com>, Stefano Garzarella <sgarzare@redhat.com>, 
	Cindy Lu <lulu@redhat.com>, Maxime Coquelin <mcoqueli@redhat.com>, virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 30, 2025 at 12:52=E2=80=AFAM Eugenio P=C3=A9rez <eperezma@redha=
t.com> wrote:
>
> Add support for assigning Address Space Identifiers (ASIDs) to each VQ
> group.  This enables mapping each group into a distinct memory space.
>
> Now that the driver can change ASID in the middle of operation, the
> domain that each vq address point is also protected by domain_lock.
>
> Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> ---
> v6:
> * Make vdpa_dev_add use gotos for error handling (MST).
> * s/(dev->api_version < 1) ?/(dev->api_version < VDUSE_API_VERSION_1) ?/
>   (MST).
> * Fix struct name not matching in the doc.
>
> v5:
> * Properly return errno if copy_to_user returns >0 in VDUSE_IOTLB_GET_FD
>   ioctl (Jason).
> * Properly set domain bounce size to divide equally between nas (Jason).
> * Exclude "padding" member from the only >V1 members in
>   vduse_dev_request.
>
> v4:
> * Divide each domain bounce size between the device bounce size (Jason).
> * revert unneeded addr =3D NULL assignment (Jason)
> * Change if (x && (y || z)) return to if (x) { if (y) return; if (z)
>   return; } (Jason)
> * Change a bad multiline comment, using @ caracter instead of * (Jason).
> * Consider config->nas =3D=3D 0 as a fail (Jason).
>
> v3:
> * Get the vduse domain through the vduse_as in the map functions
>   (Jason).
> * Squash with the patch creating the vduse_as struct (Jason).
> * Create VDUSE_DEV_MAX_AS instead of comparing agains a magic number
>   (Jason)
>
> v2:
> * Convert the use of mutex to rwlock.
>
> RFC v3:
> * Increase VDUSE_MAX_VQ_GROUPS to 0xffff (Jason). It was set to a lower
>   value to reduce memory consumption, but vqs are already limited to
>   that value and userspace VDUSE is able to allocate that many vqs.
> * Remove TODO about merging VDUSE_IOTLB_GET_FD ioctl with
>   VDUSE_IOTLB_GET_INFO.
> * Use of array_index_nospec in VDUSE device ioctls.
> * Embed vduse_iotlb_entry into vduse_iotlb_entry_v2.
> * Move the umem mutex to asid struct so there is no contention between
>   ASIDs.
>
> RFC v2:
> * Make iotlb entry the last one of vduse_iotlb_entry_v2 so the first
>   part of the struct is the same.
> ---
>  drivers/vdpa/vdpa_user/vduse_dev.c | 347 ++++++++++++++++++++---------
>  include/uapi/linux/vduse.h         |  53 ++++-
>  2 files changed, 290 insertions(+), 110 deletions(-)
>

[...]

> @@ -2154,7 +2280,8 @@ static int vdpa_dev_add(struct vdpa_mgmt_dev *mdev,=
 const char *name,
>                         const struct vdpa_dev_set_config *config)
>  {
>         struct vduse_dev *dev;
> -       int ret;
> +       size_t domain_bounce_size;
> +       int ret, i;
>
>         mutex_lock(&vduse_lock);
>         dev =3D vduse_find_dev(name);
> @@ -2168,29 +2295,35 @@ static int vdpa_dev_add(struct vdpa_mgmt_dev *mde=
v, const char *name,
>                 return ret;
>
>         write_lock(&dev->domain_lock);
> -       if (!dev->domain)
> -               dev->domain =3D vduse_domain_create(VDUSE_IOVA_SIZE - 1,
> -                                                 dev->bounce_size);
> -       write_unlock(&dev->domain_lock);
> -       if (!dev->domain) {
> -               ret =3D -ENOMEM;
> -               goto domain_err;
> +       ret =3D 0;
> +
> +       domain_bounce_size =3D dev->bounce_size / dev->nas;

Could dev->nas be zero here?

It looks like we only have the check like this:

        dev->nas =3D (dev->api_version < VDUSE_API_VERSION_1) ? 1 : config-=
>nas;

When API version >=3D 1, userspace could fill zero here.

> +       for (i =3D 0; i < dev->nas; ++i) {
> +               dev->as[i].domain =3D vduse_domain_create(VDUSE_IOVA_SIZE=
 - 1,
> +                                                       domain_bounce_siz=
e);
> +               if (!dev->as[i].domain) {
> +                       ret =3D -ENOMEM;
> +                       goto err;
> +               }
>         }
>
> +       write_unlock(&dev->domain_lock);
> +
>         ret =3D _vdpa_register_device(&dev->vdev->vdpa, dev->vq_num);
> -       if (ret) {
> -               goto register_err;
> -       }
> +       if (ret)
> +               goto err;

We don't hold domain_lock here but err tries to unlock it.

>
>         return 0;
>
> -register_err:
> -       write_lock(&dev->domain_lock);
> -       vduse_domain_destroy(dev->domain);
> -       dev->domain =3D NULL;
> +err:
> +       for (int j =3D 0; j < i; j++) {
> +               if (dev->as[j].domain) {
> +                       vduse_domain_destroy(dev->as[j].domain);
> +                       dev->as[j].domain =3D NULL;
> +               }
> +       }
>         write_unlock(&dev->domain_lock);
>

Thanks


