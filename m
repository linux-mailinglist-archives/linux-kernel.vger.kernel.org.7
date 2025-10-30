Return-Path: <linux-kernel+bounces-878146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 845D5C1FE2F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 12:52:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 364383BFF40
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 11:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6A531D6193;
	Thu, 30 Oct 2025 11:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="lJwlwLeq"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D270533F384
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 11:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761825140; cv=none; b=pXxGfXOsN0tPxfcE5fRxz/6HiMZzidunnqry/AJ7zihkB2/TJKJ9n0up8oGnWOIQGf9n7JCjFIN/5ebxOI1I7oW6Gho0Rc9iFcGm+Lr+vVTDVjFHuApCfpnOgxc9dY1JaMyPXOhPXTyPd2J9fnCFXh2B9iYuyyX8Q8rx+PgZMsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761825140; c=relaxed/simple;
	bh=knFK+WAKNgE/7mM+yN1i5LEngB5N1qdGEYqFboX7PI0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pdze1qGBWPlbP1HiWw1s1dh9McYkVZXaLvAStalT2XfYumTu3gULZUzpx5Yc9YE4l3pLLAAAMKxhhRkprM69l1wcBDIUueGi2DHjGCe7eumhSxtxKwUH6FlPWs4O/TFsAUVvKFemAAnLZSxud+4gL4HXHvVWhezBfSoFJtDapXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=lJwlwLeq; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-33d7589774fso1327505a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 04:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1761825137; x=1762429937; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b5549rKYyKbvnLaB8ZfiZvNmqq8Z4ruD3QxHzbNJEm4=;
        b=lJwlwLeqrbywFC4qd/FYyUqRwEoStJ+oQSNsNMBGMeyecRNtPfV8bPjeIipI/jHYbp
         O4t5t89uWtq0r23A2E1BcbuGxpTnin46iYwL7g2He07uuGU/jv3wAFvkhz/1uGqqUX8A
         7YcyB953n/V64oKPYQkT68hRPJvIPwQnDl23ZxKN4+glndgC7EGdOgpfvGVj7sFEhLDs
         QcewBti+VBeerAb1IR+y6I8yWCnaMnV4iilG8pAmBB20QGlULcq0d0mnqsxi/X1ACvbO
         Fk69vdHPWkGp/Gx6bICHVu0C5Ax6Y9Bf7SWHwzfdWvmGhMNPOsqace6UuaCQlWNmi7Nv
         5XGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761825137; x=1762429937;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b5549rKYyKbvnLaB8ZfiZvNmqq8Z4ruD3QxHzbNJEm4=;
        b=YelFCPiGl64F6Z6JhXth1qbNTQ5GTJ6ZJULL2me3sltHFVMC8SlgjdMydmMiUmBn+A
         VSDGcgmp5iX7S0TFx2scDa+Ijp8Xn83ohv378KcW6DaXlzqnPGjQFuPizbiKwxvIsCVM
         ue3ztQ9/Yp1ugI9cn8QAFgC9RfwDyplEmdjkLiKnZw2A6TDRPT2bmc27cmlDrCiICag9
         GTMwf90PJzgu/YYpNUeUQSrkrzNoo82vZQaCuJCWS0eUO9uycwtBLg006ntKZ7ZiSUdz
         m5uFlkruaqwnthj5a3Efhgo7LKp+d6JNsgFPd7ue64FDKAKNrvayZvZ3n+Clj4EBQLJS
         x4ew==
X-Forwarded-Encrypted: i=1; AJvYcCX19uocf5gjpNsK8MdCYsz6S28gzE6OK5BbsZazKe6600pqDdY7+JbBS9SDsy1qFn0kzKzl+MtpsVJEyAs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwchQyr3O0JceNgBZjX6xRXxxLM/7DR6ssIYWlNqZ38BFBLPVHJ
	X++c4E/SMFf0hqMn4pr8NOhnZM8JX59VC8/8JbJ7pbJ3rCtCMjWoBRIY3oYayoZ5GfxJ4DrzLE7
	f0/Xs5MwERJNXtbA200iluGX5d3LKlQKy3VAQbvvM
X-Gm-Gg: ASbGncuq94ERA8VFGDXEqIC5g0wSoBQCESV35fpQsHBfz93/dLTwRsSIzjBwQpxkiHb
	+cI2/S1rFjrz/kZSumYcVjV63mNxnxD3SpI2HANszyOmUHARnJrddFiiU1ukpX1MNjYQPxck/2V
	CpNWAbJeMI6erMz+8PwbBRbgzfDUWTV482QxpQgF5AJ8gudX0QSfI/C2XDVVEBw+uNrPFNAnyHV
	qAEuQjkl5i4uhdguez0iP8TDxOL8QAErOF4NZVwZ0tTDv/ecZNy0sMVKrbT55VoiAZuc/qJnBjt
	WirwUf7SrBkHnLi3Lw==
X-Google-Smtp-Source: AGHT+IEEeW3nIQg859sqc+QVtr5SS5MSj7nJaU+YKyNNq9KMjLYpVxzRn4z88SdqV27pohVmi/XTQsAzv29ZJnknIO0=
X-Received: by 2002:a17:90a:d64f:b0:33d:a0fd:2572 with SMTP id
 98e67ed59e1d1-3404c45abb7mr3333993a91.22.1761825136869; Thu, 30 Oct 2025
 04:52:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251030100025.95113-1-eperezma@redhat.com> <20251030100025.95113-6-eperezma@redhat.com>
In-Reply-To: <20251030100025.95113-6-eperezma@redhat.com>
From: Yongji Xie <xieyongji@bytedance.com>
Date: Thu, 30 Oct 2025 19:52:05 +0800
X-Gm-Features: AWmQ_bkTLkVZj0bnMf6oixZijr76L0GKNO2NsC4ylmLMyYS69VAZx1cx6eOz7D8
Message-ID: <CACycT3sYzQM88dkqHiT-g9eRtfo-8PjW7XcRtZ=5q++=By4RVw@mail.gmail.com>
Subject: Re: [PATCH v8 5/6] vduse: add vq group asid support
To: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Laurent Vivier <lvivier@redhat.com>, 
	Maxime Coquelin <mcoqueli@redhat.com>, virtualization@lists.linux.dev, 
	Stefano Garzarella <sgarzare@redhat.com>, Jason Wang <jasowang@redhat.com>, Cindy Lu <lulu@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2025 at 6:01=E2=80=AFPM Eugenio P=C3=A9rez <eperezma@redhat=
.com> wrote:
>
> Add support for assigning Address Space Identifiers (ASIDs) to each VQ
> group.  This enables mapping each group into a distinct memory space.
>
> Now that the driver can change ASID in the middle of operation, the
> domain that each vq address point is also protected by domain_lock.
>
> Acked-by: Jason Wang <jasowang@redhat.com>
> Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> ---
> v8:
> * Revert the mutex to rwlock change, it needs proper profiling to
>   justify it.
>
> v7:
> * Take write lock in the error path (Jason).
>
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
>  drivers/vdpa/vdpa_user/vduse_dev.c | 348 ++++++++++++++++++++---------
>  include/uapi/linux/vduse.h         |  53 ++++-
>  2 files changed, 292 insertions(+), 109 deletions(-)
>
> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/=
vduse_dev.c
> index 97be04f73fbf..c6909d73d06d 100644
> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> @@ -41,6 +41,7 @@
>
>  #define VDUSE_DEV_MAX (1U << MINORBITS)
>  #define VDUSE_DEV_MAX_GROUPS 0xffff
> +#define VDUSE_DEV_MAX_AS 0xffff
>  #define VDUSE_MAX_BOUNCE_SIZE (1024 * 1024 * 1024)
>  #define VDUSE_MIN_BOUNCE_SIZE (1024 * 1024)
>  #define VDUSE_BOUNCE_SIZE (64 * 1024 * 1024)
> @@ -86,7 +87,14 @@ struct vduse_umem {
>         struct mm_struct *mm;
>  };
>
> +struct vduse_as {
> +       struct vduse_iova_domain *domain;
> +       struct vduse_umem *umem;
> +       struct mutex mem_lock;
> +};
> +
>  struct vduse_vq_group {
> +       struct vduse_as *as;
>         struct vduse_dev *dev;
>  };
>
> @@ -94,7 +102,7 @@ struct vduse_dev {
>         struct vduse_vdpa *vdev;
>         struct device *dev;
>         struct vduse_virtqueue **vqs;
> -       struct vduse_iova_domain *domain;
> +       struct vduse_as *as;
>         char *name;
>         struct mutex lock;
>         spinlock_t msg_lock;
> @@ -122,9 +130,8 @@ struct vduse_dev {
>         u32 vq_num;
>         u32 vq_align;
>         u32 ngroups;
> -       struct vduse_umem *umem;
> +       u32 nas;
>         struct vduse_vq_group *groups;
> -       struct mutex mem_lock;
>         unsigned int bounce_size;
>         struct mutex domain_lock;
>  };
> @@ -314,7 +321,7 @@ static int vduse_dev_set_status(struct vduse_dev *dev=
, u8 status)
>         return vduse_dev_msg_sync(dev, &msg);
>  }
>
> -static int vduse_dev_update_iotlb(struct vduse_dev *dev,
> +static int vduse_dev_update_iotlb(struct vduse_dev *dev, u32 asid,
>                                   u64 start, u64 last)
>  {
>         struct vduse_dev_msg msg =3D { 0 };
> @@ -323,8 +330,14 @@ static int vduse_dev_update_iotlb(struct vduse_dev *=
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
> @@ -436,14 +449,29 @@ static __poll_t vduse_dev_poll(struct file *file, p=
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
> +       mutex_lock(&dev->domain_lock);
> +       dev->groups[group].as =3D &dev->as[asid];
> +       mutex_unlock(&dev->domain_lock);
> +}
> +
>  static void vduse_dev_reset(struct vduse_dev *dev)
>  {
>         int i;
> -       struct vduse_iova_domain *domain =3D dev->domain;
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
> @@ -623,6 +651,29 @@ static union virtio_map vduse_get_vq_map(struct vdpa=
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
> @@ -794,13 +845,13 @@ static int vduse_vdpa_set_map(struct vdpa_device *v=
dpa,
>         struct vduse_dev *dev =3D vdpa_to_vduse(vdpa);
>         int ret;
>
> -       ret =3D vduse_domain_set_map(dev->domain, iotlb);
> +       ret =3D vduse_domain_set_map(dev->as[asid].domain, iotlb);
>         if (ret)
>                 return ret;
>
> -       ret =3D vduse_dev_update_iotlb(dev, 0ULL, ULLONG_MAX);
> +       ret =3D vduse_dev_update_iotlb(dev, asid, 0ULL, ULLONG_MAX);
>         if (ret) {
> -               vduse_domain_clear_map(dev->domain, iotlb);
> +               vduse_domain_clear_map(dev->as[asid].domain, iotlb);
>                 return ret;
>         }
>
> @@ -843,6 +894,7 @@ static const struct vdpa_config_ops vduse_vdpa_config=
_ops =3D {
>         .get_vq_affinity        =3D vduse_vdpa_get_vq_affinity,
>         .reset                  =3D vduse_vdpa_reset,
>         .set_map                =3D vduse_vdpa_set_map,
> +       .set_group_asid         =3D vduse_set_group_asid,
>         .get_vq_map             =3D vduse_get_vq_map,
>         .free                   =3D vduse_vdpa_free,
>  };
> @@ -858,9 +910,10 @@ static void vduse_dev_sync_single_for_device(union v=
irtio_map token,
>                 return;
>
>         vdev =3D token.group->dev;
> -       domain =3D vdev->domain;
> -
> +       mutex_lock(&vdev->domain_lock);
> +       domain =3D token.group->as->domain;
>         vduse_domain_sync_single_for_device(domain, dma_addr, size, dir);
> +       mutex_unlock(&vdev->domain_lock);
>  }
>
>  static void vduse_dev_sync_single_for_cpu(union virtio_map token,
> @@ -874,9 +927,10 @@ static void vduse_dev_sync_single_for_cpu(union virt=
io_map token,
>                 return;
>
>         vdev =3D token.group->dev;
> -       domain =3D vdev->domain;
> -
> +       mutex_lock(&vdev->domain_lock);
> +       domain =3D token.group->as->domain;
>         vduse_domain_sync_single_for_cpu(domain, dma_addr, size, dir);
> +       mutex_unlock(&vdev->domain_lock);
>  }
>
>  static dma_addr_t vduse_dev_map_page(union virtio_map token, struct page=
 *page,
> @@ -886,14 +940,18 @@ static dma_addr_t vduse_dev_map_page(union virtio_m=
ap token, struct page *page,
>  {
>         struct vduse_dev *vdev;
>         struct vduse_iova_domain *domain;
> +       dma_addr_t r;
>
>         if (!token.group)
>                 return DMA_MAPPING_ERROR;
>
>         vdev =3D token.group->dev;
> -       domain =3D vdev->domain;
> +       mutex_lock(&vdev->domain_lock);

The mutex_lock can't be used here since the dma ops might be called in
atomic context. And I think we can just remove it since creation and
deletion operations of the iova domain are guaranteed not to execute
concurrently with I/O operations.

Thanks,
Yongji

