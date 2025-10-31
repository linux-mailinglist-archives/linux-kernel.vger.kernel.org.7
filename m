Return-Path: <linux-kernel+bounces-879568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BCBDC237C2
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 08:01:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5C6114EA04D
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 07:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97FE92FA0EF;
	Fri, 31 Oct 2025 07:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="GXSlNFAn"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906B81A9B46
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 07:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761894081; cv=none; b=WJuPJOVzN9bmgQ0eKZAOtjAGX161r4MGSABtVEAy9XFmgu5OSKy2p1QIlJ5gm0vIf2l5voKDp8H1TTiWXAZZh2FBFL0WO5TS6Xp9cdBvOgBfXnn1r0K9YPxke9cooTb1jaby5XMEksFrg7za9ovXZtIygFtmS+EXyvUHaD1vlaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761894081; c=relaxed/simple;
	bh=q12KDfEkhxXl6/bpkJTQjJy91PPPOKSp6gIdjXvXM+k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N4/ytRPwEgZIEaYosUVhpJ7wB28w768/qlPcttV/VlfIf4iCbV/WOZlNCKEZUkat6IWAtz2M+0U3O8F1opnyBjxU/h3ukhCy6UG4CXcf9QttRJoYI6iDZt77hNo50RsQ07wFNgTjHTFwbqsUQGOedwhJEvYRolkY1r0o5fDRy8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=GXSlNFAn; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-34029c5beabso1920481a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 00:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1761894078; x=1762498878; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wn3uuAbqAI8xe0K1MlWuHQhr0lEGAe8UaHyzaH8poqA=;
        b=GXSlNFAncCtU4SClNhWpDDI/mdxp4OSokg8UOlYtMU0FBoJj/eI2SxGeVUZzh1X3/V
         K4wmaLAC6Nb+ySDXpebX2bD7SQay/iRBrrk5orC9vbc0rz1/EKTXdXsJ4l7r008S62Vc
         GdEWRO0pPCDAnufMJUctij/xGqjxnZUBjZ03+PbglxOdFcIBWAn3briUHmk8PQWLmirm
         7GQlsLn0rDCpoQwo5s71+Yjrh/kT7775Rmut8/RQ5bjCg/fVm0m59pWE5cBnaE8mQaJn
         W0DBqkhdRpX65Vj2EmAnKRswcWz0opxjabCklXMi8niTEDSd1mmzuhk95WlcAG2KoVJH
         3KbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761894078; x=1762498878;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wn3uuAbqAI8xe0K1MlWuHQhr0lEGAe8UaHyzaH8poqA=;
        b=A9vMG8nUU4keTIebF7/qCcOYyRr3QMtPNWOelcydcPXDD/XYvWyRas/da0VgFIJLY0
         RFJDAiv7el5wWeboCK/pt/alZxNKy+VRW9Z8Lg84sbe51qVj1YfX3XHaPGXQBJjiY4pP
         jwbI1bgXN6VN6gjYC8Hsx0zg0X+YKcsi8zCEejlWJ4CN6VfymeoQlC8CaHPARnixuxlY
         tGkwRyinZTqx95d+BU6NZrKn60sPv/ezJBNIg1spOSoiK5PPJu6RJG4zWcNB8/1vxCzw
         e4dbZn9ooY3SmTV7/jpSlX2Gyd74IZvY0di0Ml+6PXL658UBCX9fQBQa+eKJJePRGVfg
         OYEg==
X-Forwarded-Encrypted: i=1; AJvYcCUPZZZSLpec/D7r00TaQpxjGOvRCuk6L9HNbuTCYcB3UQtE04qPcY9rBEB15j6yOGIUMvC4kKZ2GXzlysc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6yUbvFuyQbSLy1FCHQNjjFvFY8p1q2991ZAhsWcatEQpZ6efd
	bG2MVW7jEmxLgzB8gc42wuejb9j0jlQTp6tYJ2JhTJks4hvj7BTGTeGAE+t7opeVyzw7COxCQ9G
	dU3IL6OV8JPwIYr3/kXejO66rUBQJZY4Ko7AIajmwwAkO43dO2Mc0A57YKwQ=
X-Gm-Gg: ASbGncuwkNHYglZpe5MlVrcXeZzxfSMGyIAhoTg0Ei6uD6y/IHCNpdJ2RRj0dZDq51E
	uPDb0l7bDgKSoUck6NRXu2C8i4YqK5aJBc8+Rp3tvvQ5IweZZ5XwZfpqPO+I33qRO98BWSQPzQt
	EB4t604wYDfYa4poAE3X7f1TFgBCcWRpKPi/o8Bk4FHmyr6DmH8qkMUPROn81dQJGZkxBj5W5Aj
	d18AnKfXocU8Ke0RBfxs7ujQFRaP5r11V1qrzXlFaLrgzvAP+FCDmg34A2s9oiWpC97A6V/e5Dw
	ZCCuc+z1pGXRqvNvOaIwnFiWv6Su
X-Google-Smtp-Source: AGHT+IHvJ5b6u1Qktl2Zll7CNkYolmqAtjWX5d1nDDzUpnoONbbWcYjJvw0MF2Jr7nmM35PDSy57jIuWhVz7fMMx59o=
X-Received: by 2002:a17:90b:3f8b:b0:32b:a332:7a0a with SMTP id
 98e67ed59e1d1-34082fab188mr2999301a91.1.1761894077979; Fri, 31 Oct 2025
 00:01:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251030100025.95113-1-eperezma@redhat.com> <20251030100025.95113-6-eperezma@redhat.com>
 <CACycT3sYzQM88dkqHiT-g9eRtfo-8PjW7XcRtZ=5q++=By4RVw@mail.gmail.com> <CAJaqyWexPHJiZjC+RPvVH4J6gS55fCOfPQmKay2eWO-nqrjcRQ@mail.gmail.com>
In-Reply-To: <CAJaqyWexPHJiZjC+RPvVH4J6gS55fCOfPQmKay2eWO-nqrjcRQ@mail.gmail.com>
From: Yongji Xie <xieyongji@bytedance.com>
Date: Fri, 31 Oct 2025 15:01:06 +0800
X-Gm-Features: AWmQ_bmtgpETmCi0MGzGulnV_O9k88UXrZWEB3j_ApUVZHRFhCreX9iRMKEcR78
Message-ID: <CACycT3v4zp_uDRA6ELwcZB287TYLsJfx34EepAhSRJ+w6B0hvw@mail.gmail.com>
Subject: Re: Re: [PATCH v8 5/6] vduse: add vq group asid support
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Laurent Vivier <lvivier@redhat.com>, 
	Maxime Coquelin <mcoqueli@redhat.com>, virtualization@lists.linux.dev, 
	Stefano Garzarella <sgarzare@redhat.com>, Jason Wang <jasowang@redhat.com>, Cindy Lu <lulu@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 31, 2025 at 2:31=E2=80=AFPM Eugenio Perez Martin
<eperezma@redhat.com> wrote:
>
> On Thu, Oct 30, 2025 at 12:52=E2=80=AFPM Yongji Xie <xieyongji@bytedance.=
com> wrote:
> >
> > On Thu, Oct 30, 2025 at 6:01=E2=80=AFPM Eugenio P=C3=A9rez <eperezma@re=
dhat.com> wrote:
> > >
> > > Add support for assigning Address Space Identifiers (ASIDs) to each V=
Q
> > > group.  This enables mapping each group into a distinct memory space.
> > >
> > > Now that the driver can change ASID in the middle of operation, the
> > > domain that each vq address point is also protected by domain_lock.
> > >
> > > Acked-by: Jason Wang <jasowang@redhat.com>
> > > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > > ---
> > > v8:
> > > * Revert the mutex to rwlock change, it needs proper profiling to
> > >   justify it.
> > >
> > > v7:
> > > * Take write lock in the error path (Jason).
> > >
> > > v6:
> > > * Make vdpa_dev_add use gotos for error handling (MST).
> > > * s/(dev->api_version < 1) ?/(dev->api_version < VDUSE_API_VERSION_1)=
 ?/
> > >   (MST).
> > > * Fix struct name not matching in the doc.
> > >
> > > v5:
> > > * Properly return errno if copy_to_user returns >0 in VDUSE_IOTLB_GET=
_FD
> > >   ioctl (Jason).
> > > * Properly set domain bounce size to divide equally between nas (Jaso=
n).
> > > * Exclude "padding" member from the only >V1 members in
> > >   vduse_dev_request.
> > >
> > > v4:
> > > * Divide each domain bounce size between the device bounce size (Jaso=
n).
> > > * revert unneeded addr =3D NULL assignment (Jason)
> > > * Change if (x && (y || z)) return to if (x) { if (y) return; if (z)
> > >   return; } (Jason)
> > > * Change a bad multiline comment, using @ caracter instead of * (Jaso=
n).
> > > * Consider config->nas =3D=3D 0 as a fail (Jason).
> > >
> > > v3:
> > > * Get the vduse domain through the vduse_as in the map functions
> > >   (Jason).
> > > * Squash with the patch creating the vduse_as struct (Jason).
> > > * Create VDUSE_DEV_MAX_AS instead of comparing agains a magic number
> > >   (Jason)
> > >
> > > v2:
> > > * Convert the use of mutex to rwlock.
> > >
> > > RFC v3:
> > > * Increase VDUSE_MAX_VQ_GROUPS to 0xffff (Jason). It was set to a low=
er
> > >   value to reduce memory consumption, but vqs are already limited to
> > >   that value and userspace VDUSE is able to allocate that many vqs.
> > > * Remove TODO about merging VDUSE_IOTLB_GET_FD ioctl with
> > >   VDUSE_IOTLB_GET_INFO.
> > > * Use of array_index_nospec in VDUSE device ioctls.
> > > * Embed vduse_iotlb_entry into vduse_iotlb_entry_v2.
> > > * Move the umem mutex to asid struct so there is no contention betwee=
n
> > >   ASIDs.
> > >
> > > RFC v2:
> > > * Make iotlb entry the last one of vduse_iotlb_entry_v2 so the first
> > >   part of the struct is the same.
> > > ---
> > >  drivers/vdpa/vdpa_user/vduse_dev.c | 348 ++++++++++++++++++++-------=
--
> > >  include/uapi/linux/vduse.h         |  53 ++++-
> > >  2 files changed, 292 insertions(+), 109 deletions(-)
> > >
> > > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_u=
ser/vduse_dev.c
> > > index 97be04f73fbf..c6909d73d06d 100644
> > > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > > @@ -41,6 +41,7 @@
> > >
> > >  #define VDUSE_DEV_MAX (1U << MINORBITS)
> > >  #define VDUSE_DEV_MAX_GROUPS 0xffff
> > > +#define VDUSE_DEV_MAX_AS 0xffff
> > >  #define VDUSE_MAX_BOUNCE_SIZE (1024 * 1024 * 1024)
> > >  #define VDUSE_MIN_BOUNCE_SIZE (1024 * 1024)
> > >  #define VDUSE_BOUNCE_SIZE (64 * 1024 * 1024)
> > > @@ -86,7 +87,14 @@ struct vduse_umem {
> > >         struct mm_struct *mm;
> > >  };
> > >
> > > +struct vduse_as {
> > > +       struct vduse_iova_domain *domain;
> > > +       struct vduse_umem *umem;
> > > +       struct mutex mem_lock;
> > > +};
> > > +
> > >  struct vduse_vq_group {
> > > +       struct vduse_as *as;
> > >         struct vduse_dev *dev;
> > >  };
> > >
> > > @@ -94,7 +102,7 @@ struct vduse_dev {
> > >         struct vduse_vdpa *vdev;
> > >         struct device *dev;
> > >         struct vduse_virtqueue **vqs;
> > > -       struct vduse_iova_domain *domain;
> > > +       struct vduse_as *as;
> > >         char *name;
> > >         struct mutex lock;
> > >         spinlock_t msg_lock;
> > > @@ -122,9 +130,8 @@ struct vduse_dev {
> > >         u32 vq_num;
> > >         u32 vq_align;
> > >         u32 ngroups;
> > > -       struct vduse_umem *umem;
> > > +       u32 nas;
> > >         struct vduse_vq_group *groups;
> > > -       struct mutex mem_lock;
> > >         unsigned int bounce_size;
> > >         struct mutex domain_lock;
> > >  };
> > > @@ -314,7 +321,7 @@ static int vduse_dev_set_status(struct vduse_dev =
*dev, u8 status)
> > >         return vduse_dev_msg_sync(dev, &msg);
> > >  }
> > >
> > > -static int vduse_dev_update_iotlb(struct vduse_dev *dev,
> > > +static int vduse_dev_update_iotlb(struct vduse_dev *dev, u32 asid,
> > >                                   u64 start, u64 last)
> > >  {
> > >         struct vduse_dev_msg msg =3D { 0 };
> > > @@ -323,8 +330,14 @@ static int vduse_dev_update_iotlb(struct vduse_d=
ev *dev,
> > >                 return -EINVAL;
> > >
> > >         msg.req.type =3D VDUSE_UPDATE_IOTLB;
> > > -       msg.req.iova.start =3D start;
> > > -       msg.req.iova.last =3D last;
> > > +       if (dev->api_version < VDUSE_API_VERSION_1) {
> > > +               msg.req.iova.start =3D start;
> > > +               msg.req.iova.last =3D last;
> > > +       } else {
> > > +               msg.req.iova_v2.start =3D start;
> > > +               msg.req.iova_v2.last =3D last;
> > > +               msg.req.iova_v2.asid =3D asid;
> > > +       }
> > >
> > >         return vduse_dev_msg_sync(dev, &msg);
> > >  }
> > > @@ -436,14 +449,29 @@ static __poll_t vduse_dev_poll(struct file *fil=
e, poll_table *wait)
> > >         return mask;
> > >  }
> > >
> > > +/* Force set the asid to a vq group without a message to the VDUSE d=
evice */
> > > +static void vduse_set_group_asid_nomsg(struct vduse_dev *dev,
> > > +                                      unsigned int group, unsigned i=
nt asid)
> > > +{
> > > +       mutex_lock(&dev->domain_lock);
> > > +       dev->groups[group].as =3D &dev->as[asid];
> > > +       mutex_unlock(&dev->domain_lock);
> > > +}
> > > +
> > >  static void vduse_dev_reset(struct vduse_dev *dev)
> > >  {
> > >         int i;
> > > -       struct vduse_iova_domain *domain =3D dev->domain;
> > >
> > >         /* The coherent mappings are handled in vduse_dev_free_cohere=
nt() */
> > > -       if (domain && domain->bounce_map)
> > > -               vduse_domain_reset_bounce_map(domain);
> > > +       for (i =3D 0; i < dev->nas; i++) {
> > > +               struct vduse_iova_domain *domain =3D dev->as[i].domai=
n;
> > > +
> > > +               if (domain && domain->bounce_map)
> > > +                       vduse_domain_reset_bounce_map(domain);
> > > +       }
> > > +
> > > +       for (i =3D 0; i < dev->ngroups; i++)
> > > +               vduse_set_group_asid_nomsg(dev, i, 0);
> > >
> > >         down_write(&dev->rwsem);
> > >
> > > @@ -623,6 +651,29 @@ static union virtio_map vduse_get_vq_map(struct =
vdpa_device *vdpa, u16 idx)
> > >         return ret;
> > >  }
> > >
> > > +static int vduse_set_group_asid(struct vdpa_device *vdpa, unsigned i=
nt group,
> > > +                               unsigned int asid)
> > > +{
> > > +       struct vduse_dev *dev =3D vdpa_to_vduse(vdpa);
> > > +       struct vduse_dev_msg msg =3D { 0 };
> > > +       int r;
> > > +
> > > +       if (dev->api_version < VDUSE_API_VERSION_1 ||
> > > +           group >=3D dev->ngroups || asid >=3D dev->nas)
> > > +               return -EINVAL;
> > > +
> > > +       msg.req.type =3D VDUSE_SET_VQ_GROUP_ASID;
> > > +       msg.req.vq_group_asid.group =3D group;
> > > +       msg.req.vq_group_asid.asid =3D asid;
> > > +
> > > +       r =3D vduse_dev_msg_sync(dev, &msg);
> > > +       if (r < 0)
> > > +               return r;
> > > +
> > > +       vduse_set_group_asid_nomsg(dev, group, asid);
> > > +       return 0;
> > > +}
> > > +
> > >  static int vduse_vdpa_get_vq_state(struct vdpa_device *vdpa, u16 idx=
,
> > >                                 struct vdpa_vq_state *state)
> > >  {
> > > @@ -794,13 +845,13 @@ static int vduse_vdpa_set_map(struct vdpa_devic=
e *vdpa,
> > >         struct vduse_dev *dev =3D vdpa_to_vduse(vdpa);
> > >         int ret;
> > >
> > > -       ret =3D vduse_domain_set_map(dev->domain, iotlb);
> > > +       ret =3D vduse_domain_set_map(dev->as[asid].domain, iotlb);
> > >         if (ret)
> > >                 return ret;
> > >
> > > -       ret =3D vduse_dev_update_iotlb(dev, 0ULL, ULLONG_MAX);
> > > +       ret =3D vduse_dev_update_iotlb(dev, asid, 0ULL, ULLONG_MAX);
> > >         if (ret) {
> > > -               vduse_domain_clear_map(dev->domain, iotlb);
> > > +               vduse_domain_clear_map(dev->as[asid].domain, iotlb);
> > >                 return ret;
> > >         }
> > >
> > > @@ -843,6 +894,7 @@ static const struct vdpa_config_ops vduse_vdpa_co=
nfig_ops =3D {
> > >         .get_vq_affinity        =3D vduse_vdpa_get_vq_affinity,
> > >         .reset                  =3D vduse_vdpa_reset,
> > >         .set_map                =3D vduse_vdpa_set_map,
> > > +       .set_group_asid         =3D vduse_set_group_asid,
> > >         .get_vq_map             =3D vduse_get_vq_map,
> > >         .free                   =3D vduse_vdpa_free,
> > >  };
> > > @@ -858,9 +910,10 @@ static void vduse_dev_sync_single_for_device(uni=
on virtio_map token,
> > >                 return;
> > >
> > >         vdev =3D token.group->dev;
> > > -       domain =3D vdev->domain;
> > > -
> > > +       mutex_lock(&vdev->domain_lock);
> > > +       domain =3D token.group->as->domain;
> > >         vduse_domain_sync_single_for_device(domain, dma_addr, size, d=
ir);
> > > +       mutex_unlock(&vdev->domain_lock);
> > >  }
> > >
> > >  static void vduse_dev_sync_single_for_cpu(union virtio_map token,
> > > @@ -874,9 +927,10 @@ static void vduse_dev_sync_single_for_cpu(union =
virtio_map token,
> > >                 return;
> > >
> > >         vdev =3D token.group->dev;
> > > -       domain =3D vdev->domain;
> > > -
> > > +       mutex_lock(&vdev->domain_lock);
> > > +       domain =3D token.group->as->domain;
> > >         vduse_domain_sync_single_for_cpu(domain, dma_addr, size, dir)=
;
> > > +       mutex_unlock(&vdev->domain_lock);
> > >  }
> > >
> > >  static dma_addr_t vduse_dev_map_page(union virtio_map token, struct =
page *page,
> > > @@ -886,14 +940,18 @@ static dma_addr_t vduse_dev_map_page(union virt=
io_map token, struct page *page,
> > >  {
> > >         struct vduse_dev *vdev;
> > >         struct vduse_iova_domain *domain;
> > > +       dma_addr_t r;
> > >
> > >         if (!token.group)
> > >                 return DMA_MAPPING_ERROR;
> > >
> > >         vdev =3D token.group->dev;
> > > -       domain =3D vdev->domain;
> > > +       mutex_lock(&vdev->domain_lock);
> >
> > The mutex_lock can't be used here since the dma ops might be called in
> > atomic context. And I think we can just remove it since creation and
> > deletion operations of the iova domain are guaranteed not to execute
> > concurrently with I/O operations.
> >
>
> That would be great indeed! Can you expand on this, what protects here
> from the moment the two syscalls are issues from userland?
>

The domain mutex lock is introduced in commit
d4438d23eeeef8bb1b3a8abe418abffd60bb544a ("vduse: Delay iova domain
creation"). It's used to prevent concurrent execution between
vdpa_dev_add() and some vduse device ioctl which needs to access the
iova domain such as VDUSE_IOTLB_REG_UMEM/DEREG_UMEM. But the dma ops
would not be called until vdpa_dev_add() completed, so the mutex lock
is not needed.

Thanks,
Yongji

