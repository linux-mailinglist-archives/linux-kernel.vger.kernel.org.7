Return-Path: <linux-kernel+bounces-882339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D998C2A35E
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 07:41:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5249188BA31
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 06:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D654E184540;
	Mon,  3 Nov 2025 06:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K2GwZxon";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="b5Qlxy+h"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C95D8347C3
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 06:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762152099; cv=none; b=vAEWKPnR76ECo6m7s/WCsf4vlPBDvmrvvR+XKz/YA14vdx+S2o0wukXe7+LMkvJDxuI746wz27xi9G9mJ8dBvh6osG8R7nHXSTE41TGpH6ctl6j3ARXei7gKiBWq3iEfLFSv/xlgI2MNATSBCnPpHkPw5cyCBUhOuAhH/5tKr9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762152099; c=relaxed/simple;
	bh=wJe3nz4aE6xgCyOVFtSB9YLc6kjwXtH5uSEAKKBK0GQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BSe0r1AgK+zFEUsGx+42IYPA8ak6pUIv/agHIp5zTxxikMMmpyUp/uKECqfRkh7wx7ZLGPnzj7Tl4LsTr9Y/cwZik8EmGHPYxrWwSuBqFBJzaK20gwIdREhghKsJtn+HavtdsmJL0xTyvKzFbUj8m8pHz2/aI18oGV3NQW6PJto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K2GwZxon; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=b5Qlxy+h; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762152095;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XsKohb1DvnEW9qZqAmuTKk46dBTf0mG9UjKJsxqN4z4=;
	b=K2GwZxonphAVhSTBxtmGElHwZ2MCBdcXvgzsS+HEQUy/YQZoFENLpGzen1twahwdKX2YZZ
	gQnmQYQ5NA1EHlPdHZ3YE2VgXYygvfPdBCYsr/myWebdG2OpCgZurCpj2EHvvFVFYls9J8
	iAgGjSiET/o3M5WYWqNSjDTTmsx6I1g=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-9wlsAfm_OXWETGi2Nl9yww-1; Mon, 03 Nov 2025 01:41:34 -0500
X-MC-Unique: 9wlsAfm_OXWETGi2Nl9yww-1
X-Mimecast-MFC-AGG-ID: 9wlsAfm_OXWETGi2Nl9yww_1762152094
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-7865de53d43so19667437b3.0
        for <linux-kernel@vger.kernel.org>; Sun, 02 Nov 2025 22:41:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762152094; x=1762756894; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XsKohb1DvnEW9qZqAmuTKk46dBTf0mG9UjKJsxqN4z4=;
        b=b5Qlxy+heBaN6zctKQK5ec3pU62Fe0sKilGeC20rEj6Db0upzRAOBuOqbGXGq1p0Ig
         nTabf/ByAGEClUwvlMmdVKLuFPJFrHZmEJsKZ9uUFFBJY0mogoh34yMoXJ1i0Ou/iZY3
         D9G5f50SWVO9/hw7vPGzGfxnrZ3C4LTxKCVtZ9SLjpjuhW52eECyDxK26liKkjgEEBVQ
         ZYwzIOHj5Ph42fNpjzb11XRKqUhvt1N0sKkhQxnrPd0KS/dMC/sih1LL+I+0IB5dEs+y
         wPOeFo/mXU3pNk4mKhzX8AxpgOgYqJ+uV9XJhwY46rf5in4Z3Kmik++sbI2p8jdLDYDW
         3BeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762152094; x=1762756894;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XsKohb1DvnEW9qZqAmuTKk46dBTf0mG9UjKJsxqN4z4=;
        b=fubeS06SHWzRVXYpOSbn0W2fdVff5egOnaC+7QzrMxKYOR4j3aV2QI/KKvfCltN8P7
         dq9eyPpQcBPVxS4ETugf3yrZMG3Dxsv88w8ENlyO2Roj7irwxw5O7Nh4AGVJHcHC3ARW
         K9UmLpO25ICicc7KgN97bQuYdX9On2Dx1mQN6Krnl+8nELds76Utg7b8DtRSkQyxw9Dm
         WtbhiubFdhnDjaJ5zKpFIhpZVGTSPri7FEYLk+7zNxsYf0pgBnoOCXPcZkdrMcB/M41f
         WeIoJJR9WjYTkT8+Cki/GZVq+F7lcVYoPNDDvxUru6VDmH8VwiiKI3zvKLmFREsOLZKn
         BJCA==
X-Forwarded-Encrypted: i=1; AJvYcCXp9CnfwuefSQgyYpWpcSpmJ3Nm0qJ9KfYWcq1Qafr8+T0Y82qRgIVK1H9B/YADI6ztDLUDetfU73ZHRFg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMswyliCJah6yPrSKY5R+mBj6nyQQL+4/Ft5qKIg/pmW3TLkBb
	1tL8St/Te8St76lwpMQzdFnlI4oqtyPlVvVaA+yywo6AhhtOd3v/AuI4mRLTicq3dsmXz0rdkSk
	iL5rubSgibkvthUFkgaNca+io9+ZkI6YxPUZQzJNWv9fZ/wXaKHxDv7TuZvVRXyh9zhRedDcbCv
	WfSku5Gzj/FyC0XIe0bj91AylJpWP2lfOgpIBDLxwH
X-Gm-Gg: ASbGncvTmRAeAeiuCHxQjKhmMrEIFtrdfuUvInin65ceuZqeM/w5jktm8/Wc1iwN/Fw
	KBmjNEzu4NpwrGL2Mv/Hdha2Dhg4kzOmfEEk5ce4uG8Ei3NJJFVXYdR2KztHUPOBnW0PVNH+zpK
	LyXi3j+i+lfxj7txTJFQK1ykc2vlBBmbLH34eyEDGdoKEwbNz6cE9jVkGR
X-Received: by 2002:a05:690c:4a02:b0:786:84a7:2ce7 with SMTP id 00721157ae682-78684a7381bmr18493517b3.24.1762152093817;
        Sun, 02 Nov 2025 22:41:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFs/3n3oik8PM0z44B9bSOXj/4LvXjDAq+EupnZgqeC4hX5HsSRPQHN6VPhzmfIz4IefbbRiTrxLrquufhDSdU=
X-Received: by 2002:a05:690c:4a02:b0:786:84a7:2ce7 with SMTP id
 00721157ae682-78684a7381bmr18493267b3.24.1762152093334; Sun, 02 Nov 2025
 22:41:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251030100025.95113-1-eperezma@redhat.com> <20251030100025.95113-6-eperezma@redhat.com>
 <CACycT3sYzQM88dkqHiT-g9eRtfo-8PjW7XcRtZ=5q++=By4RVw@mail.gmail.com>
 <CAJaqyWexPHJiZjC+RPvVH4J6gS55fCOfPQmKay2eWO-nqrjcRQ@mail.gmail.com>
 <CACycT3v4zp_uDRA6ELwcZB287TYLsJfx34EepAhSRJ+w6B0hvw@mail.gmail.com>
 <CAJaqyWe31w=Z--Sh6ufwvhaBsBaKypUjHzLy9qm6NyDJM-NgDQ@mail.gmail.com> <CACycT3sKofWfottqAzRWscCWNaodnqXiFtvuhSv7Pqz1F0+90A@mail.gmail.com>
In-Reply-To: <CACycT3sKofWfottqAzRWscCWNaodnqXiFtvuhSv7Pqz1F0+90A@mail.gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Mon, 3 Nov 2025 07:40:56 +0100
X-Gm-Features: AWmQ_blzu1l4rikqSiCWmLt48W8VPy8pg21NvFuFsvHACTRtHQpqW8WYWJYdvrg
Message-ID: <CAJaqyWdzeOsTG2YT3wJCuoFMffDmGXAsPp4GwL+Jq1h-O8h9SQ@mail.gmail.com>
Subject: Re: Re: Re: [PATCH v8 5/6] vduse: add vq group asid support
To: Yongji Xie <xieyongji@bytedance.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Laurent Vivier <lvivier@redhat.com>, 
	Maxime Coquelin <mcoqueli@redhat.com>, virtualization@lists.linux.dev, 
	Stefano Garzarella <sgarzare@redhat.com>, Jason Wang <jasowang@redhat.com>, Cindy Lu <lulu@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 3, 2025 at 3:55=E2=80=AFAM Yongji Xie <xieyongji@bytedance.com>=
 wrote:
>
> On Fri, Oct 31, 2025 at 10:09=E2=80=AFPM Eugenio Perez Martin
> <eperezma@redhat.com> wrote:
> >
> > On Fri, Oct 31, 2025 at 8:01=E2=80=AFAM Yongji Xie <xieyongji@bytedance=
.com> wrote:
> > >
> > > On Fri, Oct 31, 2025 at 2:31=E2=80=AFPM Eugenio Perez Martin
> > > <eperezma@redhat.com> wrote:
> > > >
> > > > On Thu, Oct 30, 2025 at 12:52=E2=80=AFPM Yongji Xie <xieyongji@byte=
dance.com> wrote:
> > > > >
> > > > > On Thu, Oct 30, 2025 at 6:01=E2=80=AFPM Eugenio P=C3=A9rez <epere=
zma@redhat.com> wrote:
> > > > > >
> > > > > > Add support for assigning Address Space Identifiers (ASIDs) to =
each VQ
> > > > > > group.  This enables mapping each group into a distinct memory =
space.
> > > > > >
> > > > > > Now that the driver can change ASID in the middle of operation,=
 the
> > > > > > domain that each vq address point is also protected by domain_l=
ock.
> > > > > >
> > > > > > Acked-by: Jason Wang <jasowang@redhat.com>
> > > > > > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > > > > > ---
> > > > > > v8:
> > > > > > * Revert the mutex to rwlock change, it needs proper profiling =
to
> > > > > >   justify it.
> > > > > >
> > > > > > v7:
> > > > > > * Take write lock in the error path (Jason).
> > > > > >
> > > > > > v6:
> > > > > > * Make vdpa_dev_add use gotos for error handling (MST).
> > > > > > * s/(dev->api_version < 1) ?/(dev->api_version < VDUSE_API_VERS=
ION_1) ?/
> > > > > >   (MST).
> > > > > > * Fix struct name not matching in the doc.
> > > > > >
> > > > > > v5:
> > > > > > * Properly return errno if copy_to_user returns >0 in VDUSE_IOT=
LB_GET_FD
> > > > > >   ioctl (Jason).
> > > > > > * Properly set domain bounce size to divide equally between nas=
 (Jason).
> > > > > > * Exclude "padding" member from the only >V1 members in
> > > > > >   vduse_dev_request.
> > > > > >
> > > > > > v4:
> > > > > > * Divide each domain bounce size between the device bounce size=
 (Jason).
> > > > > > * revert unneeded addr =3D NULL assignment (Jason)
> > > > > > * Change if (x && (y || z)) return to if (x) { if (y) return; i=
f (z)
> > > > > >   return; } (Jason)
> > > > > > * Change a bad multiline comment, using @ caracter instead of *=
 (Jason).
> > > > > > * Consider config->nas =3D=3D 0 as a fail (Jason).
> > > > > >
> > > > > > v3:
> > > > > > * Get the vduse domain through the vduse_as in the map function=
s
> > > > > >   (Jason).
> > > > > > * Squash with the patch creating the vduse_as struct (Jason).
> > > > > > * Create VDUSE_DEV_MAX_AS instead of comparing agains a magic n=
umber
> > > > > >   (Jason)
> > > > > >
> > > > > > v2:
> > > > > > * Convert the use of mutex to rwlock.
> > > > > >
> > > > > > RFC v3:
> > > > > > * Increase VDUSE_MAX_VQ_GROUPS to 0xffff (Jason). It was set to=
 a lower
> > > > > >   value to reduce memory consumption, but vqs are already limit=
ed to
> > > > > >   that value and userspace VDUSE is able to allocate that many =
vqs.
> > > > > > * Remove TODO about merging VDUSE_IOTLB_GET_FD ioctl with
> > > > > >   VDUSE_IOTLB_GET_INFO.
> > > > > > * Use of array_index_nospec in VDUSE device ioctls.
> > > > > > * Embed vduse_iotlb_entry into vduse_iotlb_entry_v2.
> > > > > > * Move the umem mutex to asid struct so there is no contention =
between
> > > > > >   ASIDs.
> > > > > >
> > > > > > RFC v2:
> > > > > > * Make iotlb entry the last one of vduse_iotlb_entry_v2 so the =
first
> > > > > >   part of the struct is the same.
> > > > > > ---
> > > > > >  drivers/vdpa/vdpa_user/vduse_dev.c | 348 ++++++++++++++++++++-=
--------
> > > > > >  include/uapi/linux/vduse.h         |  53 ++++-
> > > > > >  2 files changed, 292 insertions(+), 109 deletions(-)
> > > > > >
> > > > > > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/=
vdpa_user/vduse_dev.c
> > > > > > index 97be04f73fbf..c6909d73d06d 100644
> > > > > > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > > > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > > > @@ -41,6 +41,7 @@
> > > > > >
> > > > > >  #define VDUSE_DEV_MAX (1U << MINORBITS)
> > > > > >  #define VDUSE_DEV_MAX_GROUPS 0xffff
> > > > > > +#define VDUSE_DEV_MAX_AS 0xffff
> > > > > >  #define VDUSE_MAX_BOUNCE_SIZE (1024 * 1024 * 1024)
> > > > > >  #define VDUSE_MIN_BOUNCE_SIZE (1024 * 1024)
> > > > > >  #define VDUSE_BOUNCE_SIZE (64 * 1024 * 1024)
> > > > > > @@ -86,7 +87,14 @@ struct vduse_umem {
> > > > > >         struct mm_struct *mm;
> > > > > >  };
> > > > > >
> > > > > > +struct vduse_as {
> > > > > > +       struct vduse_iova_domain *domain;
> > > > > > +       struct vduse_umem *umem;
> > > > > > +       struct mutex mem_lock;
> > > > > > +};
> > > > > > +
> > > > > >  struct vduse_vq_group {
> > > > > > +       struct vduse_as *as;
> > > > > >         struct vduse_dev *dev;
> > > > > >  };
> > > > > >
> > > > > > @@ -94,7 +102,7 @@ struct vduse_dev {
> > > > > >         struct vduse_vdpa *vdev;
> > > > > >         struct device *dev;
> > > > > >         struct vduse_virtqueue **vqs;
> > > > > > -       struct vduse_iova_domain *domain;
> > > > > > +       struct vduse_as *as;
> > > > > >         char *name;
> > > > > >         struct mutex lock;
> > > > > >         spinlock_t msg_lock;
> > > > > > @@ -122,9 +130,8 @@ struct vduse_dev {
> > > > > >         u32 vq_num;
> > > > > >         u32 vq_align;
> > > > > >         u32 ngroups;
> > > > > > -       struct vduse_umem *umem;
> > > > > > +       u32 nas;
> > > > > >         struct vduse_vq_group *groups;
> > > > > > -       struct mutex mem_lock;
> > > > > >         unsigned int bounce_size;
> > > > > >         struct mutex domain_lock;
> > > > > >  };
> > > > > > @@ -314,7 +321,7 @@ static int vduse_dev_set_status(struct vdus=
e_dev *dev, u8 status)
> > > > > >         return vduse_dev_msg_sync(dev, &msg);
> > > > > >  }
> > > > > >
> > > > > > -static int vduse_dev_update_iotlb(struct vduse_dev *dev,
> > > > > > +static int vduse_dev_update_iotlb(struct vduse_dev *dev, u32 a=
sid,
> > > > > >                                   u64 start, u64 last)
> > > > > >  {
> > > > > >         struct vduse_dev_msg msg =3D { 0 };
> > > > > > @@ -323,8 +330,14 @@ static int vduse_dev_update_iotlb(struct v=
duse_dev *dev,
> > > > > >                 return -EINVAL;
> > > > > >
> > > > > >         msg.req.type =3D VDUSE_UPDATE_IOTLB;
> > > > > > -       msg.req.iova.start =3D start;
> > > > > > -       msg.req.iova.last =3D last;
> > > > > > +       if (dev->api_version < VDUSE_API_VERSION_1) {
> > > > > > +               msg.req.iova.start =3D start;
> > > > > > +               msg.req.iova.last =3D last;
> > > > > > +       } else {
> > > > > > +               msg.req.iova_v2.start =3D start;
> > > > > > +               msg.req.iova_v2.last =3D last;
> > > > > > +               msg.req.iova_v2.asid =3D asid;
> > > > > > +       }
> > > > > >
> > > > > >         return vduse_dev_msg_sync(dev, &msg);
> > > > > >  }
> > > > > > @@ -436,14 +449,29 @@ static __poll_t vduse_dev_poll(struct fil=
e *file, poll_table *wait)
> > > > > >         return mask;
> > > > > >  }
> > > > > >
> > > > > > +/* Force set the asid to a vq group without a message to the V=
DUSE device */
> > > > > > +static void vduse_set_group_asid_nomsg(struct vduse_dev *dev,
> > > > > > +                                      unsigned int group, unsi=
gned int asid)
> > > > > > +{
> > > > > > +       mutex_lock(&dev->domain_lock);
> > > > > > +       dev->groups[group].as =3D &dev->as[asid];
> > > > > > +       mutex_unlock(&dev->domain_lock);
> > > > > > +}
> > > > > > +
> > > > > >  static void vduse_dev_reset(struct vduse_dev *dev)
> > > > > >  {
> > > > > >         int i;
> > > > > > -       struct vduse_iova_domain *domain =3D dev->domain;
> > > > > >
> > > > > >         /* The coherent mappings are handled in vduse_dev_free_=
coherent() */
> > > > > > -       if (domain && domain->bounce_map)
> > > > > > -               vduse_domain_reset_bounce_map(domain);
> > > > > > +       for (i =3D 0; i < dev->nas; i++) {
> > > > > > +               struct vduse_iova_domain *domain =3D dev->as[i]=
.domain;
> > > > > > +
> > > > > > +               if (domain && domain->bounce_map)
> > > > > > +                       vduse_domain_reset_bounce_map(domain);
> > > > > > +       }
> > > > > > +
> > > > > > +       for (i =3D 0; i < dev->ngroups; i++)
> > > > > > +               vduse_set_group_asid_nomsg(dev, i, 0);
> > > > > >
> > > > > >         down_write(&dev->rwsem);
> > > > > >
> > > > > > @@ -623,6 +651,29 @@ static union virtio_map vduse_get_vq_map(s=
truct vdpa_device *vdpa, u16 idx)
> > > > > >         return ret;
> > > > > >  }
> > > > > >
> > > > > > +static int vduse_set_group_asid(struct vdpa_device *vdpa, unsi=
gned int group,
> > > > > > +                               unsigned int asid)
> > > > > > +{
> > > > > > +       struct vduse_dev *dev =3D vdpa_to_vduse(vdpa);
> > > > > > +       struct vduse_dev_msg msg =3D { 0 };
> > > > > > +       int r;
> > > > > > +
> > > > > > +       if (dev->api_version < VDUSE_API_VERSION_1 ||
> > > > > > +           group >=3D dev->ngroups || asid >=3D dev->nas)
> > > > > > +               return -EINVAL;
> > > > > > +
> > > > > > +       msg.req.type =3D VDUSE_SET_VQ_GROUP_ASID;
> > > > > > +       msg.req.vq_group_asid.group =3D group;
> > > > > > +       msg.req.vq_group_asid.asid =3D asid;
> > > > > > +
> > > > > > +       r =3D vduse_dev_msg_sync(dev, &msg);
> > > > > > +       if (r < 0)
> > > > > > +               return r;
> > > > > > +
> > > > > > +       vduse_set_group_asid_nomsg(dev, group, asid);
> > > > > > +       return 0;
> > > > > > +}
> > > > > > +
> > > > > >  static int vduse_vdpa_get_vq_state(struct vdpa_device *vdpa, u=
16 idx,
> > > > > >                                 struct vdpa_vq_state *state)
> > > > > >  {
> > > > > > @@ -794,13 +845,13 @@ static int vduse_vdpa_set_map(struct vdpa=
_device *vdpa,
> > > > > >         struct vduse_dev *dev =3D vdpa_to_vduse(vdpa);
> > > > > >         int ret;
> > > > > >
> > > > > > -       ret =3D vduse_domain_set_map(dev->domain, iotlb);
> > > > > > +       ret =3D vduse_domain_set_map(dev->as[asid].domain, iotl=
b);
> > > > > >         if (ret)
> > > > > >                 return ret;
> > > > > >
> > > > > > -       ret =3D vduse_dev_update_iotlb(dev, 0ULL, ULLONG_MAX);
> > > > > > +       ret =3D vduse_dev_update_iotlb(dev, asid, 0ULL, ULLONG_=
MAX);
> > > > > >         if (ret) {
> > > > > > -               vduse_domain_clear_map(dev->domain, iotlb);
> > > > > > +               vduse_domain_clear_map(dev->as[asid].domain, io=
tlb);
> > > > > >                 return ret;
> > > > > >         }
> > > > > >
> > > > > > @@ -843,6 +894,7 @@ static const struct vdpa_config_ops vduse_v=
dpa_config_ops =3D {
> > > > > >         .get_vq_affinity        =3D vduse_vdpa_get_vq_affinity,
> > > > > >         .reset                  =3D vduse_vdpa_reset,
> > > > > >         .set_map                =3D vduse_vdpa_set_map,
> > > > > > +       .set_group_asid         =3D vduse_set_group_asid,
> > > > > >         .get_vq_map             =3D vduse_get_vq_map,
> > > > > >         .free                   =3D vduse_vdpa_free,
> > > > > >  };
> > > > > > @@ -858,9 +910,10 @@ static void vduse_dev_sync_single_for_devi=
ce(union virtio_map token,
> > > > > >                 return;
> > > > > >
> > > > > >         vdev =3D token.group->dev;
> > > > > > -       domain =3D vdev->domain;
> > > > > > -
> > > > > > +       mutex_lock(&vdev->domain_lock);
> > > > > > +       domain =3D token.group->as->domain;
> > > > > >         vduse_domain_sync_single_for_device(domain, dma_addr, s=
ize, dir);
> > > > > > +       mutex_unlock(&vdev->domain_lock);
> > > > > >  }
> > > > > >
> > > > > >  static void vduse_dev_sync_single_for_cpu(union virtio_map tok=
en,
> > > > > > @@ -874,9 +927,10 @@ static void vduse_dev_sync_single_for_cpu(=
union virtio_map token,
> > > > > >                 return;
> > > > > >
> > > > > >         vdev =3D token.group->dev;
> > > > > > -       domain =3D vdev->domain;
> > > > > > -
> > > > > > +       mutex_lock(&vdev->domain_lock);
> > > > > > +       domain =3D token.group->as->domain;
> > > > > >         vduse_domain_sync_single_for_cpu(domain, dma_addr, size=
, dir);
> > > > > > +       mutex_unlock(&vdev->domain_lock);
> > > > > >  }
> > > > > >
> > > > > >  static dma_addr_t vduse_dev_map_page(union virtio_map token, s=
truct page *page,
> > > > > > @@ -886,14 +940,18 @@ static dma_addr_t vduse_dev_map_page(unio=
n virtio_map token, struct page *page,
> > > > > >  {
> > > > > >         struct vduse_dev *vdev;
> > > > > >         struct vduse_iova_domain *domain;
> > > > > > +       dma_addr_t r;
> > > > > >
> > > > > >         if (!token.group)
> > > > > >                 return DMA_MAPPING_ERROR;
> > > > > >
> > > > > >         vdev =3D token.group->dev;
> > > > > > -       domain =3D vdev->domain;
> > > > > > +       mutex_lock(&vdev->domain_lock);
> > > > >
> > > > > The mutex_lock can't be used here since the dma ops might be call=
ed in
> > > > > atomic context. And I think we can just remove it since creation =
and
> > > > > deletion operations of the iova domain are guaranteed not to exec=
ute
> > > > > concurrently with I/O operations.
> > > > >
> > > >
> > > > That would be great indeed! Can you expand on this, what protects h=
ere
> > > > from the moment the two syscalls are issues from userland?
> > > >
> > >
> > > The domain mutex lock is introduced in commit
> > > d4438d23eeeef8bb1b3a8abe418abffd60bb544a ("vduse: Delay iova domain
> > > creation"). It's used to prevent concurrent execution between
> > > vdpa_dev_add() and some vduse device ioctl which needs to access the
> > > iova domain such as VDUSE_IOTLB_REG_UMEM/DEREG_UMEM. But the dma ops
> > > would not be called until vdpa_dev_add() completed, so the mutex lock
> > > is not needed.
> > >
> >
> > Yes, but the usage is extended here to also protect from concurrent
> > calls to vduse_dev_map_page and vduse_set_group_asid or similar.
> >
> > So I guess the best is to replace it with a spinlock or RCU.
> >
>
> OK, I see, we simply aim to prevent concurrent access to the group->as
> variable here. But I wonder if the .set_group_asid function can be
> called during I/O.

At least a malicious userland app could do it.

> I think the unmap_page() would fail if we change
> the group->as between map_page() and unmap_page().

I guess a SIGSEGV or similar could be a valid outcome of that, but we
need to protect the "as" pointer anyway.

> Besides, it seems
> that .set_group_asid is only called in the vhost-vdpa case currently,
> but the dma ops such as map_page/unmap_page only service the
> virtio-vdpa case, so they would not be called concurrently with
> .set_group_asid now.
>

That's totally true but a malicious app can do it anyway. So it is
better to protect it properly.

Preparing a new version with a spinlock or RCU, thanks!


