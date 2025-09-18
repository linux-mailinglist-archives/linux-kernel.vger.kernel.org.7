Return-Path: <linux-kernel+bounces-822126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2F80B8312A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 08:01:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A0BD16464E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 06:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE2002765DD;
	Thu, 18 Sep 2025 06:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F6W55MFn"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C86619E98C
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 06:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758175292; cv=none; b=UheB7yo9n+xR+Pk1FC4hApKrsBeOJrNl9/GOLMT5s8EpEJDPxZPNQoTgzwC2abVJBionitamtwfYUvPI4XzsD66xkof+aAQCkEDk5yiPvNuifQhNPlbdBVPljFMMQR/zZQAB4Xd6hqjQv0f+o61ze3W/XtIKcc/TfJ+Jn81vQSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758175292; c=relaxed/simple;
	bh=F6PJ5sQuLeWoui3h2IeTIGET/+Tl6Dh4Hqzs4mXntL8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dAaR2MCJB+angCFYQE0c68CgdHpnzj5PaEZxxtX0iSdDMZlMyN/UVou/DwHFF/d/fapoP7ij+m5n9666qjpOPWH2YSNfoxoCAmu0ZaYuurPzqmB4SG8b9QMMcKxxvGDcSmBoxFoLRfK9aus5VYBgudFwrhoa4TD0jVwlY7nZE3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F6W55MFn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758175289;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IzuE/sVEIP49GyPLtIFMnoeSvzxhUD8lfSAmKMWlyxA=;
	b=F6W55MFn+mIPTdiCNcIrB0THJo2Ur/9th/SXR9cbSaYp2giqwSi1zBNQbAczx2Na6CHiQf
	s5SxDjmUfUKVVg/tu5Eeliz/TKd1DQ7x98wE/vb1269sD/yWChQCaCJz5kEu7igVXvh0Q4
	/WGpJFdTMAGSSKLwLRWF0ffhlIqO+9I=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-410-4U-cpr7zOgO3U0fChb8J1g-1; Thu, 18 Sep 2025 02:01:27 -0400
X-MC-Unique: 4U-cpr7zOgO3U0fChb8J1g-1
X-Mimecast-MFC-AGG-ID: 4U-cpr7zOgO3U0fChb8J1g_1758175286
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-32dd9854282so864249a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 23:01:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758175286; x=1758780086;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IzuE/sVEIP49GyPLtIFMnoeSvzxhUD8lfSAmKMWlyxA=;
        b=Grmgo4ViPhBcW8hJR+c8dREea0Uq8w7bBsKW/26CJoq80YU3kzrh+9yLbQEOE5+a9+
         CWzFm3R+pUVvFcut7KjjErxNvFIhhmASYQoen4POC7FdnguaM2XuDP6xzfGpLgrIR5qY
         wBIO2YZxBqDmDFLprrdKRV2tnbtIgaaSrR4t5Ok+cz6OWyesGIseg86YMSlAOL5ZgZvD
         TqLk9rQiD8AhxyOYwV02827M72tcTtwgn8tC3wpmIRt1ZcqYeV9u30jcg9kX+2j6b5E2
         7Pbnp4O0MdLU/H6AIIgr5b9uYBU3XAmGdHR/WGs3nlClpD2GKVm5mZYYgltta1y0aKv2
         xQ/w==
X-Forwarded-Encrypted: i=1; AJvYcCWFQqHWJBf/8O4Q7C306yN94Fmf3nR1ZQVaYLOIZ81xrPayiRou3AFUdqGyFlgwTr3bm2yus/EriUSC4WI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhYeE0GCtLTUKIWGI+mQM/QECDBJOKhdW+c+r8/+p2rPsHwSUz
	bCPllegf7/UFbWPzy3m3mTONyKH3zf9Op4XSF+QThGcYJdGR2WrNo6kT3lkHd1y/ceNHqwIPuiZ
	kuYFrH/dBXni/C7Bbq79tg6ABS8JkU7CpqoZIttJI05ujA5DBEfDDADLaO0W1lsm/VCPtvrKV29
	HGBDaGBRZb4yME30QujD18WBQbmIr38tMM1UMLFIrd
X-Gm-Gg: ASbGncvkOrRF+wle4uQ5GxZqxXr8nNjSLD/GE+dopgqr7hW+YaOR8kxBhqLewPbacbV
	3b3Lmv5JZEXxDJZPvnICoIqAQm65uGAJayJJ7sH4EdiEnSWPOjQzU9Ea+aLXomwYbZRWR35HQpC
	fUOgdF1YHis9YpKF6MQZpZJA==
X-Received: by 2002:a17:90a:d605:b0:32d:dc3e:559a with SMTP id 98e67ed59e1d1-32ee3efdfc9mr5581743a91.10.1758175286332;
        Wed, 17 Sep 2025 23:01:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHfmJKCoA5y7MoRr4bYSaS8CiHLpFq0iE4EPRNFATTud9bsTx5aFhmChJlICDrZYsKveR/4ce5Y13Wk4tvBAZg=
X-Received: by 2002:a17:90a:d605:b0:32d:dc3e:559a with SMTP id
 98e67ed59e1d1-32ee3efdfc9mr5581702a91.10.1758175285879; Wed, 17 Sep 2025
 23:01:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916130833.329087-1-eperezma@redhat.com> <20250916130833.329087-5-eperezma@redhat.com>
 <CACGkMEuY359QtVeTY40Z_L1zhG87rB2te=qc7YM6gZxcKM=m7w@mail.gmail.com> <CAJaqyWfkpxmFXafRnxvP1Wjd3=uBaSr_m05BCpDYB4e7XR9diQ@mail.gmail.com>
In-Reply-To: <CAJaqyWfkpxmFXafRnxvP1Wjd3=uBaSr_m05BCpDYB4e7XR9diQ@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 18 Sep 2025 14:01:14 +0800
X-Gm-Features: AS18NWBLzBcRmksoMvZDbU4LLioMJtZOsvqhhZPcF9nUwwqwEpDd82qsByN5YAI
Message-ID: <CACGkMEto2vc3rYO7aKJvqgRFE6QFDrtxRbHhXrVb=91vvqJ9=w@mail.gmail.com>
Subject: Re: [PATCH v2 4/7] vduse: return internal vq group struct as map token
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, linux-kernel@vger.kernel.org, 
	Maxime Coquelin <mcoqueli@redhat.com>, Yongji Xie <xieyongji@bytedance.com>, 
	Cindy Lu <lulu@redhat.com>, Laurent Vivier <lvivier@redhat.com>, virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 18, 2025 at 12:17=E2=80=AFAM Eugenio Perez Martin
<eperezma@redhat.com> wrote:
>
> On Wed, Sep 17, 2025 at 10:37=E2=80=AFAM Jason Wang <jasowang@redhat.com>=
 wrote:
> >
> > On Tue, Sep 16, 2025 at 9:09=E2=80=AFPM Eugenio P=C3=A9rez <eperezma@re=
dhat.com> wrote:
> > >
> > > Return the internal struct that represents the vq group as virtqueue =
map
> > > token, instead of the device.  This allows the map functions to acces=
s
> > > the information per group.
> > >
> > > At this moment all the virtqueues share the same vq group, that only
> > > can point to ASID 0.  This change prepares the infrastructure for act=
ual
> > > per-group address space handling
> > >
> > > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > > ---
> > > RFC v3:
> > > * Make the vq groups a dynamic array to support an arbitrary number o=
f
> > >   them.
> > > ---
> > >  drivers/vdpa/vdpa_user/vduse_dev.c | 52 ++++++++++++++++++++++++----=
--
> > >  include/linux/virtio.h             |  6 ++--
> > >  2 files changed, 46 insertions(+), 12 deletions(-)
> > >
> > > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_u=
ser/vduse_dev.c
> > > index 42f8807911d4..9c12ae72abc2 100644
> > > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > > @@ -23,6 +23,7 @@
> > >  #include <linux/uio.h>
> > >  #include <linux/vdpa.h>
> > >  #include <linux/nospec.h>
> > > +#include <linux/virtio.h>
> > >  #include <linux/vmalloc.h>
> > >  #include <linux/sched/mm.h>
> > >  #include <uapi/linux/vduse.h>
> > > @@ -85,6 +86,10 @@ struct vduse_umem {
> > >         struct mm_struct *mm;
> > >  };
> > >
> > > +struct vduse_vq_group_int {
> > > +       struct vduse_dev *dev;
> > > +};
> >
> > I remember we had some discussion over this, and the conclusion is to
> > have a better name.
> >
> > Maybe just vduse_vq_group?
> >
>
> Good catch, I also hate the _int suffix :). vduse_vq_group was used in
> the vduse uapi in previous series, but now there is no reason for it.
> Replacing it, thanks!
>
> > And to be conceptually correct, we need to use iova_domain here
> > instead of the vduse_dev. More below.
> >
> > > +
> > >  struct vduse_dev {
> > >         struct vduse_vdpa *vdev;
> > >         struct device *dev;
> > > @@ -118,6 +123,7 @@ struct vduse_dev {
> > >         u32 vq_align;
> > >         u32 ngroups;
> > >         struct vduse_umem *umem;
> > > +       struct vduse_vq_group_int *groups;
> > >         struct mutex mem_lock;
> > >         unsigned int bounce_size;
> > >         rwlock_t domain_lock;
> > > @@ -602,6 +608,15 @@ static u32 vduse_get_vq_group(struct vdpa_device=
 *vdpa, u16 idx)
> > >         return dev->vqs[idx]->vq_group;
> > >  }
> > >
> > > +static union virtio_map vduse_get_vq_map(struct vdpa_device *vdpa, u=
16 idx)
> > > +{
> > > +       struct vduse_dev *dev =3D vdpa_to_vduse(vdpa);
> > > +       u32 vq_group =3D dev->vqs[idx]->vq_group;
> > > +       union virtio_map ret =3D { .group =3D &dev->groups[vq_group] =
};
> > > +
> > > +       return ret;
> > > +}
> > > +
> > >  static int vduse_vdpa_get_vq_state(struct vdpa_device *vdpa, u16 idx=
,
> > >                                 struct vdpa_vq_state *state)
> > >  {
> > > @@ -822,6 +837,7 @@ static const struct vdpa_config_ops vduse_vdpa_co=
nfig_ops =3D {
> > >         .get_vq_affinity        =3D vduse_vdpa_get_vq_affinity,
> > >         .reset                  =3D vduse_vdpa_reset,
> > >         .set_map                =3D vduse_vdpa_set_map,
> > > +       .get_vq_map             =3D vduse_get_vq_map,
> > >         .free                   =3D vduse_vdpa_free,
> > >  };
> > >
> > > @@ -829,7 +845,8 @@ static void vduse_dev_sync_single_for_device(unio=
n virtio_map token,
> > >                                              dma_addr_t dma_addr, siz=
e_t size,
> > >                                              enum dma_data_direction =
dir)
> > >  {
> > > -       struct vduse_iova_domain *domain =3D token.iova_domain;
> > > +       struct vduse_dev *vdev =3D token.group->dev;
> > > +       struct vduse_iova_domain *domain =3D vdev->domain;
> >
> > If we really want to do this, we need to move the iova_domian into the =
group.
> >
>
> It's done in patches on top to make each patch smaller. This patch is
> focused on just changing the type of the union. Would you prefer me to
> reorder the patches so that part is done earlier?

I think it would be better for logical completeness.

Thanks


