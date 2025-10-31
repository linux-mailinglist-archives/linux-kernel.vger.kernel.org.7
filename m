Return-Path: <linux-kernel+bounces-880330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1544AC258CF
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 15:24:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4268F580C01
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 14:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21D6534C156;
	Fri, 31 Oct 2025 14:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ek0XeQlW"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F3B734C149
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 14:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761919758; cv=none; b=gLNb1R/GUQcG33nFeqYvB/cipBCooqVIk/7aknQjyLjYPYrqtsjw3tIpek+abgg4AN8XhrWDRX2xLKA6iopMY9ghkaI/DfZY5UuwxN45LlsuUbWs8v2uYWoY9g9y+4ymAQR+NEzhxif3krkOxozAxgTebcilhZ6s66sKLlPpIoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761919758; c=relaxed/simple;
	bh=cKi5u5kKlJDSFWBeitxoarMtPoIQFmFvqpw5hBsjDas=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DNzpj+7fTSvppMaktRuxvyfA7KjvqNz0ci9EQH/WBrZqd180WqkRAGxjqHxHTn3NwRFnB3V0FsQS/h+msGk9y90iv2rWptOne08SdM9X50sHBPOxUDuOCNKadk0EI+LIbKLzdkQbOOpGphYaEpdePZhb13De6Y3h5OwzMSvjJQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ek0XeQlW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761919753;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uM4ttKk22d8PZmTgVE4g81Ky8Fy3SL6iz8meVLdYIsw=;
	b=Ek0XeQlWyGeydBvBOp77HRgVCFUE/bg3JTGSMJ/uPiQD91Gg/UPrUvjNOec1GfLj73wN2R
	F8XiT1jSYMFK3T4XRF96fI88Em9RJHdqE+5/oJbV8kB+xHFiZQDtOu/UkbPFoFCivmuIXL
	hkf1kVOV1OpIR1H9wMAfBDVbNWO2aog=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-16-Bsho6UrgP3m5a2X_GOu3wg-1; Fri, 31 Oct 2025 10:09:12 -0400
X-MC-Unique: Bsho6UrgP3m5a2X_GOu3wg-1
X-Mimecast-MFC-AGG-ID: Bsho6UrgP3m5a2X_GOu3wg_1761919751
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-57893a7d7b6so1513335e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 07:09:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761919750; x=1762524550;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uM4ttKk22d8PZmTgVE4g81Ky8Fy3SL6iz8meVLdYIsw=;
        b=e/dqj1ZTtbe7TKsMeQoHUfpRLPNVesWd0iJv+BpDFLt6l9Tv9AJr38mbThGpNFNQC7
         G8F60HV3ulzEwGf0QKPbMUIB6iVsTwUk8/G6nwyECUg4s09Dmv+0nktbstbLAZLa/luL
         hjGwoyTuetStBnc11YojaFnsbISpn/5BcvzLpBmTs3+NIp1d/lzz/3/w9S4VHYReNV+2
         GMxgFJn5VOzh1zhQUbOsK6yhBOagxtftf+jUC8hLMCMEfhhAEbj8eglvTeVxbUAD/xcO
         3ylh4UxoCcetm5Cln9S303J2ELpdJtQCpVFd1B9FkBRo85H/mOzNWBUec761bcRxfqLT
         K7NQ==
X-Forwarded-Encrypted: i=1; AJvYcCWI6nUoV2bVS9TIJ7mBdsmlAE4Km58SeZTcOWV1SuQNvDDusa2Y2DydwoLjlUUPKf6AJ0mgyMTdTdCASrk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTjVi/TlHDtVOp9o6nlAMKivhvhqET8IlH7/6/nChcY31HLvMi
	W2zIYtdv1Bei1TV4MyclQhL2s+NBxsdnZxvsn8hLvqpSbpMOeDjPwHymxyav/bGzabVh8IKPRKN
	MNmkc4ISBX+RdNqbqQD9LrENBkH6G/1QD1nCxNk3SHoxt7PqLMccBPYMgOgIVrWNPaNL1F9lTYx
	R2//27hHx5RTi/BP28FU9Fiomx+dgK0ytUoLFO9d0/
X-Gm-Gg: ASbGncubiQOurmV65YeQPMOAFFOaFnU8EJ0slDnI7/SNstRkhawv2gBrj8Xuh15q2yk
	NCR+2nh3OAbmrMJEFVn8L4y6MaO9P/UbnsAU9yTc8ueqf8O73nsiSzgCI+GB8vWlWcCmS28/S1F
	OMLPrQY3+0GyKGRHblV0sa/r8bmbAovmwTRiLp8fiHGMv/4E+gjhbZ87gjM4+NYbHvjhxin0rNU
	707Gz4DLjWEscwe6HoE1t1xC0geuSO30SGJ1TF2gMEJ1w==
X-Received: by 2002:a05:6512:a93:b0:583:903e:b59d with SMTP id 2adb3069b0e04-5941d4ff177mr1243059e87.7.1761919750348;
        Fri, 31 Oct 2025 07:09:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHPUSne/fXeoSzWHtk1fLIQjJ1IX5ONWCLElKOL4D6Rr46BElzxp0Xbz/bC6904Q7mtlL0eNE87lHPP2zSNEuM=
X-Received: by 2002:a05:6512:a93:b0:583:903e:b59d with SMTP id
 2adb3069b0e04-5941d4ff177mr1243048e87.7.1761919749860; Fri, 31 Oct 2025
 07:09:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251030100025.95113-1-eperezma@redhat.com> <20251030100025.95113-6-eperezma@redhat.com>
 <CACycT3sYzQM88dkqHiT-g9eRtfo-8PjW7XcRtZ=5q++=By4RVw@mail.gmail.com>
 <CAJaqyWexPHJiZjC+RPvVH4J6gS55fCOfPQmKay2eWO-nqrjcRQ@mail.gmail.com> <CACycT3v4zp_uDRA6ELwcZB287TYLsJfx34EepAhSRJ+w6B0hvw@mail.gmail.com>
In-Reply-To: <CACycT3v4zp_uDRA6ELwcZB287TYLsJfx34EepAhSRJ+w6B0hvw@mail.gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Fri, 31 Oct 2025 15:08:29 +0100
X-Gm-Features: AWmQ_bkK8-t8DBBNr6izZz4YnZoStha-_i4aQBGOg8SPJUsZ5oRy9LfhqixlVJU
Message-ID: <CAJaqyWe31w=Z--Sh6ufwvhaBsBaKypUjHzLy9qm6NyDJM-NgDQ@mail.gmail.com>
Subject: Re: Re: [PATCH v8 5/6] vduse: add vq group asid support
To: Yongji Xie <xieyongji@bytedance.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Laurent Vivier <lvivier@redhat.com>, 
	Maxime Coquelin <mcoqueli@redhat.com>, virtualization@lists.linux.dev, 
	Stefano Garzarella <sgarzare@redhat.com>, Jason Wang <jasowang@redhat.com>, Cindy Lu <lulu@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 31, 2025 at 8:01=E2=80=AFAM Yongji Xie <xieyongji@bytedance.com=
> wrote:
>
> On Fri, Oct 31, 2025 at 2:31=E2=80=AFPM Eugenio Perez Martin
> <eperezma@redhat.com> wrote:
> >
> > On Thu, Oct 30, 2025 at 12:52=E2=80=AFPM Yongji Xie <xieyongji@bytedanc=
e.com> wrote:
> > >
> > > On Thu, Oct 30, 2025 at 6:01=E2=80=AFPM Eugenio P=C3=A9rez <eperezma@=
redhat.com> wrote:
> > > >
> > > > Add support for assigning Address Space Identifiers (ASIDs) to each=
 VQ
> > > > group.  This enables mapping each group into a distinct memory spac=
e.
> > > >
> > > > Now that the driver can change ASID in the middle of operation, the
> > > > domain that each vq address point is also protected by domain_lock.
> > > >
> > > > Acked-by: Jason Wang <jasowang@redhat.com>
> > > > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > > > ---
> > > > v8:
> > > > * Revert the mutex to rwlock change, it needs proper profiling to
> > > >   justify it.
> > > >
> > > > v7:
> > > > * Take write lock in the error path (Jason).
> > > >
> > > > v6:
> > > > * Make vdpa_dev_add use gotos for error handling (MST).
> > > > * s/(dev->api_version < 1) ?/(dev->api_version < VDUSE_API_VERSION_=
1) ?/
> > > >   (MST).
> > > > * Fix struct name not matching in the doc.
> > > >
> > > > v5:
> > > > * Properly return errno if copy_to_user returns >0 in VDUSE_IOTLB_G=
ET_FD
> > > >   ioctl (Jason).
> > > > * Properly set domain bounce size to divide equally between nas (Ja=
son).
> > > > * Exclude "padding" member from the only >V1 members in
> > > >   vduse_dev_request.
> > > >
> > > > v4:
> > > > * Divide each domain bounce size between the device bounce size (Ja=
son).
> > > > * revert unneeded addr =3D NULL assignment (Jason)
> > > > * Change if (x && (y || z)) return to if (x) { if (y) return; if (z=
)
> > > >   return; } (Jason)
> > > > * Change a bad multiline comment, using @ caracter instead of * (Ja=
son).
> > > > * Consider config->nas =3D=3D 0 as a fail (Jason).
> > > >
> > > > v3:
> > > > * Get the vduse domain through the vduse_as in the map functions
> > > >   (Jason).
> > > > * Squash with the patch creating the vduse_as struct (Jason).
> > > > * Create VDUSE_DEV_MAX_AS instead of comparing agains a magic numbe=
r
> > > >   (Jason)
> > > >
> > > > v2:
> > > > * Convert the use of mutex to rwlock.
> > > >
> > > > RFC v3:
> > > > * Increase VDUSE_MAX_VQ_GROUPS to 0xffff (Jason). It was set to a l=
ower
> > > >   value to reduce memory consumption, but vqs are already limited t=
o
> > > >   that value and userspace VDUSE is able to allocate that many vqs.
> > > > * Remove TODO about merging VDUSE_IOTLB_GET_FD ioctl with
> > > >   VDUSE_IOTLB_GET_INFO.
> > > > * Use of array_index_nospec in VDUSE device ioctls.
> > > > * Embed vduse_iotlb_entry into vduse_iotlb_entry_v2.
> > > > * Move the umem mutex to asid struct so there is no contention betw=
een
> > > >   ASIDs.
> > > >
> > > > RFC v2:
> > > > * Make iotlb entry the last one of vduse_iotlb_entry_v2 so the firs=
t
> > > >   part of the struct is the same.
> > > > ---
> > > >  drivers/vdpa/vdpa_user/vduse_dev.c | 348 ++++++++++++++++++++-----=
----
> > > >  include/uapi/linux/vduse.h         |  53 ++++-
> > > >  2 files changed, 292 insertions(+), 109 deletions(-)
> > > >
> > > > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa=
_user/vduse_dev.c
> > > > index 97be04f73fbf..c6909d73d06d 100644
> > > > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > @@ -41,6 +41,7 @@
> > > >
> > > >  #define VDUSE_DEV_MAX (1U << MINORBITS)
> > > >  #define VDUSE_DEV_MAX_GROUPS 0xffff
> > > > +#define VDUSE_DEV_MAX_AS 0xffff
> > > >  #define VDUSE_MAX_BOUNCE_SIZE (1024 * 1024 * 1024)
> > > >  #define VDUSE_MIN_BOUNCE_SIZE (1024 * 1024)
> > > >  #define VDUSE_BOUNCE_SIZE (64 * 1024 * 1024)
> > > > @@ -86,7 +87,14 @@ struct vduse_umem {
> > > >         struct mm_struct *mm;
> > > >  };
> > > >
> > > > +struct vduse_as {
> > > > +       struct vduse_iova_domain *domain;
> > > > +       struct vduse_umem *umem;
> > > > +       struct mutex mem_lock;
> > > > +};
> > > > +
> > > >  struct vduse_vq_group {
> > > > +       struct vduse_as *as;
> > > >         struct vduse_dev *dev;
> > > >  };
> > > >
> > > > @@ -94,7 +102,7 @@ struct vduse_dev {
> > > >         struct vduse_vdpa *vdev;
> > > >         struct device *dev;
> > > >         struct vduse_virtqueue **vqs;
> > > > -       struct vduse_iova_domain *domain;
> > > > +       struct vduse_as *as;
> > > >         char *name;
> > > >         struct mutex lock;
> > > >         spinlock_t msg_lock;
> > > > @@ -122,9 +130,8 @@ struct vduse_dev {
> > > >         u32 vq_num;
> > > >         u32 vq_align;
> > > >         u32 ngroups;
> > > > -       struct vduse_umem *umem;
> > > > +       u32 nas;
> > > >         struct vduse_vq_group *groups;
> > > > -       struct mutex mem_lock;
> > > >         unsigned int bounce_size;
> > > >         struct mutex domain_lock;
> > > >  };
> > > > @@ -314,7 +321,7 @@ static int vduse_dev_set_status(struct vduse_de=
v *dev, u8 status)
> > > >         return vduse_dev_msg_sync(dev, &msg);
> > > >  }
> > > >
> > > > -static int vduse_dev_update_iotlb(struct vduse_dev *dev,
> > > > +static int vduse_dev_update_iotlb(struct vduse_dev *dev, u32 asid,
> > > >                                   u64 start, u64 last)
> > > >  {
> > > >         struct vduse_dev_msg msg =3D { 0 };
> > > > @@ -323,8 +330,14 @@ static int vduse_dev_update_iotlb(struct vduse=
_dev *dev,
> > > >                 return -EINVAL;
> > > >
> > > >         msg.req.type =3D VDUSE_UPDATE_IOTLB;
> > > > -       msg.req.iova.start =3D start;
> > > > -       msg.req.iova.last =3D last;
> > > > +       if (dev->api_version < VDUSE_API_VERSION_1) {
> > > > +               msg.req.iova.start =3D start;
> > > > +               msg.req.iova.last =3D last;
> > > > +       } else {
> > > > +               msg.req.iova_v2.start =3D start;
> > > > +               msg.req.iova_v2.last =3D last;
> > > > +               msg.req.iova_v2.asid =3D asid;
> > > > +       }
> > > >
> > > >         return vduse_dev_msg_sync(dev, &msg);
> > > >  }
> > > > @@ -436,14 +449,29 @@ static __poll_t vduse_dev_poll(struct file *f=
ile, poll_table *wait)
> > > >         return mask;
> > > >  }
> > > >
> > > > +/* Force set the asid to a vq group without a message to the VDUSE=
 device */
> > > > +static void vduse_set_group_asid_nomsg(struct vduse_dev *dev,
> > > > +                                      unsigned int group, unsigned=
 int asid)
> > > > +{
> > > > +       mutex_lock(&dev->domain_lock);
> > > > +       dev->groups[group].as =3D &dev->as[asid];
> > > > +       mutex_unlock(&dev->domain_lock);
> > > > +}
> > > > +
> > > >  static void vduse_dev_reset(struct vduse_dev *dev)
> > > >  {
> > > >         int i;
> > > > -       struct vduse_iova_domain *domain =3D dev->domain;
> > > >
> > > >         /* The coherent mappings are handled in vduse_dev_free_cohe=
rent() */
> > > > -       if (domain && domain->bounce_map)
> > > > -               vduse_domain_reset_bounce_map(domain);
> > > > +       for (i =3D 0; i < dev->nas; i++) {
> > > > +               struct vduse_iova_domain *domain =3D dev->as[i].dom=
ain;
> > > > +
> > > > +               if (domain && domain->bounce_map)
> > > > +                       vduse_domain_reset_bounce_map(domain);
> > > > +       }
> > > > +
> > > > +       for (i =3D 0; i < dev->ngroups; i++)
> > > > +               vduse_set_group_asid_nomsg(dev, i, 0);
> > > >
> > > >         down_write(&dev->rwsem);
> > > >
> > > > @@ -623,6 +651,29 @@ static union virtio_map vduse_get_vq_map(struc=
t vdpa_device *vdpa, u16 idx)
> > > >         return ret;
> > > >  }
> > > >
> > > > +static int vduse_set_group_asid(struct vdpa_device *vdpa, unsigned=
 int group,
> > > > +                               unsigned int asid)
> > > > +{
> > > > +       struct vduse_dev *dev =3D vdpa_to_vduse(vdpa);
> > > > +       struct vduse_dev_msg msg =3D { 0 };
> > > > +       int r;
> > > > +
> > > > +       if (dev->api_version < VDUSE_API_VERSION_1 ||
> > > > +           group >=3D dev->ngroups || asid >=3D dev->nas)
> > > > +               return -EINVAL;
> > > > +
> > > > +       msg.req.type =3D VDUSE_SET_VQ_GROUP_ASID;
> > > > +       msg.req.vq_group_asid.group =3D group;
> > > > +       msg.req.vq_group_asid.asid =3D asid;
> > > > +
> > > > +       r =3D vduse_dev_msg_sync(dev, &msg);
> > > > +       if (r < 0)
> > > > +               return r;
> > > > +
> > > > +       vduse_set_group_asid_nomsg(dev, group, asid);
> > > > +       return 0;
> > > > +}
> > > > +
> > > >  static int vduse_vdpa_get_vq_state(struct vdpa_device *vdpa, u16 i=
dx,
> > > >                                 struct vdpa_vq_state *state)
> > > >  {
> > > > @@ -794,13 +845,13 @@ static int vduse_vdpa_set_map(struct vdpa_dev=
ice *vdpa,
> > > >         struct vduse_dev *dev =3D vdpa_to_vduse(vdpa);
> > > >         int ret;
> > > >
> > > > -       ret =3D vduse_domain_set_map(dev->domain, iotlb);
> > > > +       ret =3D vduse_domain_set_map(dev->as[asid].domain, iotlb);
> > > >         if (ret)
> > > >                 return ret;
> > > >
> > > > -       ret =3D vduse_dev_update_iotlb(dev, 0ULL, ULLONG_MAX);
> > > > +       ret =3D vduse_dev_update_iotlb(dev, asid, 0ULL, ULLONG_MAX)=
;
> > > >         if (ret) {
> > > > -               vduse_domain_clear_map(dev->domain, iotlb);
> > > > +               vduse_domain_clear_map(dev->as[asid].domain, iotlb)=
;
> > > >                 return ret;
> > > >         }
> > > >
> > > > @@ -843,6 +894,7 @@ static const struct vdpa_config_ops vduse_vdpa_=
config_ops =3D {
> > > >         .get_vq_affinity        =3D vduse_vdpa_get_vq_affinity,
> > > >         .reset                  =3D vduse_vdpa_reset,
> > > >         .set_map                =3D vduse_vdpa_set_map,
> > > > +       .set_group_asid         =3D vduse_set_group_asid,
> > > >         .get_vq_map             =3D vduse_get_vq_map,
> > > >         .free                   =3D vduse_vdpa_free,
> > > >  };
> > > > @@ -858,9 +910,10 @@ static void vduse_dev_sync_single_for_device(u=
nion virtio_map token,
> > > >                 return;
> > > >
> > > >         vdev =3D token.group->dev;
> > > > -       domain =3D vdev->domain;
> > > > -
> > > > +       mutex_lock(&vdev->domain_lock);
> > > > +       domain =3D token.group->as->domain;
> > > >         vduse_domain_sync_single_for_device(domain, dma_addr, size,=
 dir);
> > > > +       mutex_unlock(&vdev->domain_lock);
> > > >  }
> > > >
> > > >  static void vduse_dev_sync_single_for_cpu(union virtio_map token,
> > > > @@ -874,9 +927,10 @@ static void vduse_dev_sync_single_for_cpu(unio=
n virtio_map token,
> > > >                 return;
> > > >
> > > >         vdev =3D token.group->dev;
> > > > -       domain =3D vdev->domain;
> > > > -
> > > > +       mutex_lock(&vdev->domain_lock);
> > > > +       domain =3D token.group->as->domain;
> > > >         vduse_domain_sync_single_for_cpu(domain, dma_addr, size, di=
r);
> > > > +       mutex_unlock(&vdev->domain_lock);
> > > >  }
> > > >
> > > >  static dma_addr_t vduse_dev_map_page(union virtio_map token, struc=
t page *page,
> > > > @@ -886,14 +940,18 @@ static dma_addr_t vduse_dev_map_page(union vi=
rtio_map token, struct page *page,
> > > >  {
> > > >         struct vduse_dev *vdev;
> > > >         struct vduse_iova_domain *domain;
> > > > +       dma_addr_t r;
> > > >
> > > >         if (!token.group)
> > > >                 return DMA_MAPPING_ERROR;
> > > >
> > > >         vdev =3D token.group->dev;
> > > > -       domain =3D vdev->domain;
> > > > +       mutex_lock(&vdev->domain_lock);
> > >
> > > The mutex_lock can't be used here since the dma ops might be called i=
n
> > > atomic context. And I think we can just remove it since creation and
> > > deletion operations of the iova domain are guaranteed not to execute
> > > concurrently with I/O operations.
> > >
> >
> > That would be great indeed! Can you expand on this, what protects here
> > from the moment the two syscalls are issues from userland?
> >
>
> The domain mutex lock is introduced in commit
> d4438d23eeeef8bb1b3a8abe418abffd60bb544a ("vduse: Delay iova domain
> creation"). It's used to prevent concurrent execution between
> vdpa_dev_add() and some vduse device ioctl which needs to access the
> iova domain such as VDUSE_IOTLB_REG_UMEM/DEREG_UMEM. But the dma ops
> would not be called until vdpa_dev_add() completed, so the mutex lock
> is not needed.
>

Yes, but the usage is extended here to also protect from concurrent
calls to vduse_dev_map_page and vduse_set_group_asid or similar.

So I guess the best is to replace it with a spinlock or RCU.


