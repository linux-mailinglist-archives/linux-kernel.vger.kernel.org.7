Return-Path: <linux-kernel+bounces-805759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF44AB48D07
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 14:13:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0270B16FDFE
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 12:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C56F2FDC56;
	Mon,  8 Sep 2025 12:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Ypl/B+Ru"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E7482FD1D8
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 12:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757333556; cv=none; b=pQKABZz+7exlxNjgZufoqRqdLAklb//fmEpyGEULh5k1Fi/VIAB4+8ZJpKJqtOUn9/gP1RxjxNVKg6EVeUFOAwOI7U98EVdKyOfrudd/TJtoLqYz9gtSBjMJByy5h7tJ4Yrc1As7okoCvUvAG64DwZZFqc7AmORc7vtlNMINwaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757333556; c=relaxed/simple;
	bh=otFOLS41MOzeOmIi5Qj4erstUXuYLgtkMaxX1Oi9Z/I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qRbC/orjG/bjW9FOSPyCJk0+hTlhXbCuTOq1UQPswCZMHbDkxhGT6coFv3r05YKRoe6iO0AjvHE4k2RBPlsccmIQZY0XKGp2qccJ7VF+TgxixO/PoSRq0AK3Ut9ia+mXgHNC1UyYuxTQWXa5xuFGGJ7A63T/JMHaUKVNQhriNl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Ypl/B+Ru; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b5229007f31so981752a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 05:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1757333553; x=1757938353; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LeeAbZ1EiDBRybQL5hHr70oeFHubNRnYbaFSvRYvGpY=;
        b=Ypl/B+Ru6zjlD4mJipNRk3fhy6qeuLfH6Cl6Q6jTzkHc30P/38ggFJ+DDvDoegZ5dg
         gafVntYRDiANeU4YppEKgomIfSYmRVr2OD5qq1y4rsb+/QmpQeAi1j/eUYbkjQDXnm+r
         Ca2BHNZHPXCoPwD2SuDSZsNW/hMVe+DPKaVPB3X/v7+Cde2/YCrqbWuIoH1k+iaCJUjQ
         aV7iJTjWJeBs1tvqc6O7fJpPYADOXgpYxMD82Inp+SnLXpNfBxsSGlOJnrZV1G4U9NGh
         7bUn0cYrkzTDmEglt84rYtdrsU4jbvLwUgOOybGVBgK8oQzAKn4KLaab4GT2Of0nXPxF
         +TMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757333553; x=1757938353;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LeeAbZ1EiDBRybQL5hHr70oeFHubNRnYbaFSvRYvGpY=;
        b=WoAuHKJ9G+dEWzLkkRPK9FvTmtH1zVtbHmXQX7VadEeVn4iy8FB6uRcuVT7iAOXjCV
         YWcNF3ms+cgpU/CpEIz3x8BHg7KDbxfluZaPnmNrIOEYgbTABLFOKgE2iuzSWOZ1UmL7
         aCJBgFeo7GMsRIdjF7y8kuaRP/lyC+n6LqZprgY/oAqly6yubOIAgT+QL7zYetFiiLqM
         o9LuNhGsFJ7kDGCHzDhAE/hzVj3jOEz2uiTs/0T53F0Wywp3AeO/23dgXeIDqkWBAHo6
         8+N6IJKizQeoDFrrozEZIPaiu5P4qETNc+Z3AIMVTNXOnfNGGYWGAuEujOYqDL/RCIM7
         tnwQ==
X-Forwarded-Encrypted: i=1; AJvYcCUg0UDigUjgLOSBIR6oS2EZDCTt6dkAJqeVuR808KFOvuhee82ISll1e7v9FLe4R6QbR8tlOTmxM99nMUM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSOsQWaZL4/ks50kk1iq5HqtjL8+Qqwihxe6UEOhwp36pC81oj
	kyj3u6Nf2PzqWamdmEqg4PrxnagiJJBmHOU+dSlo86CMZEj4OhcApunakOLQpDkGH+6/MEG5K0o
	t0IxYQbE6ZE4PCiuAmT8Dsp7u8VPJWRtLuzdCjYrs
X-Gm-Gg: ASbGncsI5cylNm5r1k2ALKo+J/+xdLHTcRDkQwKtkux3gcDDkYE6rdhQAohFqB9Alro
	uVqsI00BP94Xy9meS3yvKEH8A2dbliq9u9SHWcUr0I7sqmZ2IYwBHkORooSFzCoxXqIDHstt4wj
	AUwyPhtIgsY0B6mfIhdEaP7OY74/0PwIUC7jsIv6mbcB+QCeI+5ARjmLn0Sh5v2wZz3e6PbyGnk
	z3x7FWJE2yN6aF5oaEyatj1vRSxhgpDF74B
X-Google-Smtp-Source: AGHT+IGx6pmzghjPqFgsVQmVTkwwTtz5N4DB6EsXhw7FXgcknmkdSOnhkpnsWHjBZ6c8uUIRX/mbOCTyucBTce3hJUQ=
X-Received: by 2002:a17:902:cf04:b0:24a:8e36:420a with SMTP id
 d9443c01a7336-25172291ecdmr99814645ad.40.1757333553153; Mon, 08 Sep 2025
 05:12:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250826112709.1051172-1-eperezma@redhat.com> <20250826112709.1051172-6-eperezma@redhat.com>
In-Reply-To: <20250826112709.1051172-6-eperezma@redhat.com>
From: Yongji Xie <xieyongji@bytedance.com>
Date: Mon, 8 Sep 2025 20:12:20 +0800
X-Gm-Features: Ac12FXzQHka_VYKIEEmUPWsxhC3NsQ2ds4URqALiW1y4mZc2t3dSHUvk0HNuFtc
Message-ID: <CACycT3v=_Nm6fefJGFEyoU+Xf5G=Kzi0sXhhaBHnJQZcG-4EqA@mail.gmail.com>
Subject: Re: [PATCH 5/6] vduse: add vq group asid support
To: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Cindy Lu <lulu@redhat.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Laurent Vivier <lvivier@redhat.com>, virtualization@lists.linux.dev, 
	linux-kernel <linux-kernel@vger.kernel.org>, Jason Wang <jasowang@redhat.com>, 
	Maxime Coquelin <mcoqueli@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Eugenio,

On Tue, Aug 26, 2025 at 7:27=E2=80=AFPM Eugenio P=C3=A9rez <eperezma@redhat=
.com> wrote:
>
> Add support for assigning Address Space Identifiers (ASIDs) to each VQ
> group.  This enables mapping each group into a distinct memory space.
>
> Now that the driver can change ASID in the middle of operation, the
> domain that each vq address point is also protected by domain_lock.
>
> Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> ---
> v3:
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
> v2:
> * Make iotlb entry the last one of vduse_iotlb_entry_v2 so the first
>   part of the struct is the same.
> ---
>  drivers/vdpa/vdpa_user/vduse_dev.c | 290 +++++++++++++++++++++--------
>  include/uapi/linux/vduse.h         |  52 +++++-
>  2 files changed, 259 insertions(+), 83 deletions(-)
>
> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/=
vduse_dev.c
> index 7d2a3ed77b1e..2fb227713972 100644
> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> @@ -92,6 +92,7 @@ struct vduse_as {
>  };
>
>  struct vduse_vq_group_int {
> +       struct vduse_iova_domain *domain;
>         struct vduse_dev *dev;
>  };
>
> @@ -99,7 +100,7 @@ struct vduse_dev {
>         struct vduse_vdpa *vdev;
>         struct device *dev;
>         struct vduse_virtqueue **vqs;
> -       struct vduse_as as;
> +       struct vduse_as *as;
>         char *name;
>         struct mutex lock;
>         spinlock_t msg_lock;
> @@ -127,6 +128,7 @@ struct vduse_dev {
>         u32 vq_num;
>         u32 vq_align;
>         u32 ngroups;
> +       u32 nas;
>         struct vduse_vq_group_int *groups;
>         unsigned int bounce_size;
>         struct mutex domain_lock;
> @@ -317,7 +319,7 @@ static int vduse_dev_set_status(struct vduse_dev *dev=
, u8 status)
>         return vduse_dev_msg_sync(dev, &msg);
>  }
>
> -static int vduse_dev_update_iotlb(struct vduse_dev *dev,
> +static int vduse_dev_update_iotlb(struct vduse_dev *dev, u32 asid,
>                                   u64 start, u64 last)
>  {
>         struct vduse_dev_msg msg =3D { 0 };
> @@ -326,8 +328,14 @@ static int vduse_dev_update_iotlb(struct vduse_dev *=
dev,
>                 return -EINVAL;
>
>         msg.req.type =3D VDUSE_UPDATE_IOTLB;
> -       msg.req.iova.start =3D start;
> -       msg.req.iova.last =3D last;
> +       if (dev->api_version < VDUSE_API_VERSION_1) {
> +               msg.req.iova.start =3D start;
> +               msg.req.iova.last =3D last;
> +       } else {
> +               msg.req.iova_v2.start =3D start;
> +               msg.req.iova_v2.last =3D last;
> +               msg.req.iova_v2.asid =3D asid;
> +       }
>
>         return vduse_dev_msg_sync(dev, &msg);
>  }
> @@ -439,14 +447,28 @@ static __poll_t vduse_dev_poll(struct file *file, p=
oll_table *wait)
>         return mask;
>  }
>
> +/* Force set the asid to a vq group without a message to the VDUSE devic=
e */
> +static void vduse_set_group_asid_nomsg(struct vduse_dev *dev,
> +                                      unsigned int group, unsigned int a=
sid)
> +{
> +       guard(mutex)(&dev->domain_lock);
> +       dev->groups[group].domain =3D dev->as[asid].domain;
> +}
> +
>  static void vduse_dev_reset(struct vduse_dev *dev)
>  {
>         int i;
> -       struct vduse_iova_domain *domain =3D dev->as.domain;
>
>         /* The coherent mappings are handled in vduse_dev_free_coherent()=
 */
> -       if (domain && domain->bounce_map)
> -               vduse_domain_reset_bounce_map(domain);
> +       for (i =3D 0; i < dev->nas; i++) {
> +               struct vduse_iova_domain *domain =3D dev->as[i].domain;
> +
> +               if (domain && domain->bounce_map)
> +                       vduse_domain_reset_bounce_map(domain);
> +       }
> +
> +       for (i =3D 0; i < dev->ngroups; i++)
> +               vduse_set_group_asid_nomsg(dev, i, 0);
>
>         down_write(&dev->rwsem);
>
> @@ -620,6 +642,29 @@ static union virtio_map vduse_get_vq_map(struct vdpa=
_device *vdpa, u16 idx)
>         return ret;
>  }
>
> +static int vduse_set_group_asid(struct vdpa_device *vdpa, unsigned int g=
roup,
> +                               unsigned int asid)
> +{
> +       struct vduse_dev *dev =3D vdpa_to_vduse(vdpa);
> +       struct vduse_dev_msg msg =3D { 0 };
> +       int r;
> +
> +       if (dev->api_version < VDUSE_API_VERSION_1 ||
> +           group >=3D dev->ngroups || asid >=3D dev->nas)
> +               return -EINVAL;
> +
> +       msg.req.type =3D VDUSE_SET_VQ_GROUP_ASID;
> +       msg.req.vq_group_asid.group =3D group;
> +       msg.req.vq_group_asid.asid =3D asid;
> +
> +       r =3D vduse_dev_msg_sync(dev, &msg);
> +       if (r < 0)
> +               return r;
> +
> +       vduse_set_group_asid_nomsg(dev, group, asid);
> +       return 0;
> +}
> +
>  static int vduse_vdpa_get_vq_state(struct vdpa_device *vdpa, u16 idx,
>                                 struct vdpa_vq_state *state)
>  {
> @@ -818,13 +863,13 @@ static int vduse_vdpa_set_map(struct vdpa_device *v=
dpa,
>         struct vduse_dev *dev =3D vdpa_to_vduse(vdpa);
>         int ret;
>
> -       ret =3D vduse_domain_set_map(dev->as.domain, iotlb);
> +       ret =3D vduse_domain_set_map(dev->as[asid].domain, iotlb);
>         if (ret)
>                 return ret;
>
> -       ret =3D vduse_dev_update_iotlb(dev, 0ULL, ULLONG_MAX);
> +       ret =3D vduse_dev_update_iotlb(dev, asid, 0ULL, ULLONG_MAX);
>         if (ret) {
> -               vduse_domain_clear_map(dev->as.domain, iotlb);
> +               vduse_domain_clear_map(dev->as[asid].domain, iotlb);
>                 return ret;
>         }
>
> @@ -867,6 +912,7 @@ static const struct vdpa_config_ops vduse_vdpa_config=
_ops =3D {
>         .get_vq_affinity        =3D vduse_vdpa_get_vq_affinity,
>         .reset                  =3D vduse_vdpa_reset,
>         .set_map                =3D vduse_vdpa_set_map,
> +       .set_group_asid         =3D vduse_set_group_asid,
>         .get_vq_map             =3D vduse_get_vq_map,
>         .free                   =3D vduse_vdpa_free,
>  };
> @@ -876,8 +922,10 @@ static void vduse_dev_sync_single_for_device(union v=
irtio_map token,
>                                              enum dma_data_direction dir)
>  {
>         struct vduse_dev *vdev =3D token.group->dev;
> -       struct vduse_iova_domain *domain =3D vdev->as.domain;
> +       struct vduse_iova_domain *domain;
>
> +       guard(mutex)(&vdev->domain_lock);
> +       domain =3D token.group->domain;
>         vduse_domain_sync_single_for_device(domain, dma_addr, size, dir);
>  }
>
> @@ -886,8 +934,10 @@ static void vduse_dev_sync_single_for_cpu(union virt=
io_map token,
>                                              enum dma_data_direction dir)
>  {
>         struct vduse_dev *vdev =3D token.group->dev;
> -       struct vduse_iova_domain *domain =3D vdev->as.domain;
> +       struct vduse_iova_domain *domain;
>
> +       guard(mutex)(&vdev->domain_lock);
> +       domain =3D token.group->domain;
>         vduse_domain_sync_single_for_cpu(domain, dma_addr, size, dir);
>  }
>
> @@ -897,8 +947,10 @@ static dma_addr_t vduse_dev_map_page(union virtio_ma=
p token, struct page *page,
>                                      unsigned long attrs)
>  {
>         struct vduse_dev *vdev =3D token.group->dev;
> -       struct vduse_iova_domain *domain =3D vdev->as.domain;
> +       struct vduse_iova_domain *domain;
>
> +       guard(mutex)(&vdev->domain_lock);

Won't this mutex lock hurt the performance? Can we use rw_lock/rcu_lock ins=
tead?

Thanks,
Yongji

