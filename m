Return-Path: <linux-kernel+bounces-797670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA4F0B4134D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 05:58:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77D575E60C6
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 03:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F350F2D0C8B;
	Wed,  3 Sep 2025 03:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="glEped29"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED162C324D
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 03:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756871913; cv=none; b=pZ4YZwutp6qonDkwZDRhVYyQ5CBLZITHEsHLYEbEcxOb7iZ3H0MrQZnIpmofv1VNqzFMy60kZPTWMji1890y7gAk0iUvs6R4W3/DgPphD4v8EPjZUON9k1RcOPYKuWLtvq4ssAfzrXtgZ1nDMwtSyFGTDrrY49Qd2tGEhFdYjC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756871913; c=relaxed/simple;
	bh=vMknnbbQmYzTOFy2Csd2WCcR3K2hCxpNauH+LM1kfoI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GAtva54vLEEupvtrNuZUB5aBwo6NCrCEatUUa3YPIUzrDn/pef2Vi05FEC0S2Efc7vdyrqR2YFteJtR8RlDh9ReElWmS1sbDiZyON1MFlfPbukMQj/JCxumD7cjVAFhI3iNu80RNH1GjpU7hfyFT3qW1XL72hfInGo2PfA9jY74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=glEped29; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756871910;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sNvYNe5vg9ZjKfIbx4GJXjyG8dW0HQaniQkkjzhXIEE=;
	b=glEped29BlAQFKdMVFaoiSiZdkNZ0jqYVT/KlVvktXiqxoD9SNuLcWHZSuw1cdr2SKoRXK
	719TzKl3gfBg7/zm8OKQgw4xqnV/T9LIQsog6Zz1Yq81BBUwLuik9d5eLHA9AwL2FbLPAV
	orVQmrsxoehzEtE7xXl8T58VRJ66mEo=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-513-n5xWyvv_Ouuf6NQ0kt-OSg-1; Tue, 02 Sep 2025 23:58:29 -0400
X-MC-Unique: n5xWyvv_Ouuf6NQ0kt-OSg-1
X-Mimecast-MFC-AGG-ID: n5xWyvv_Ouuf6NQ0kt-OSg_1756871908
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-329ee69e7deso1290372a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 20:58:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756871908; x=1757476708;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sNvYNe5vg9ZjKfIbx4GJXjyG8dW0HQaniQkkjzhXIEE=;
        b=fALrEJ246chLw3GmOxSHB33FUnDGFVWDhI+SjlivdZ955oZ0cRBAeAo9fGEn/45J9I
         HqmsoEtZT7JUeo5EDusahxhkDc+vMJlQZe+Su5AAWw7Hh6bseMCNzRjCJNB4T03e+PJj
         5UxvOjns4iOvfyYXzn0qlX3DVbxy0kqGiwa3ViXgpCIs4vlrrZwvDSxIuKG7lVjUBG6L
         8peH3yDM6rIDC5IcWupF/mQ6tKH+JcBNSZIx3OxSsenBN/SIBoKyaW8Fx02Sh1eXi4k3
         KgtP33XwsgZEpPQ2BCQ0EL35U8O0LsUdGN++GtH8WrTwCHZg/W/kPirJK6S+u1f58lC+
         GNfw==
X-Forwarded-Encrypted: i=1; AJvYcCV8yhgkXTutr4jWtBgjWa4XRZ+qLJ5VEBuOPO/m3PWaBbw7XjaAnx8FOo495bfaz4zP/snaZGcgXFIX6go=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVLyzRSFLGFqmmc09seCwSDAI+m1Wr4OlbtQcQywkpcyK2Bx05
	na7/aKwH7dUxkaZ+yRFoHQrsXesTpRoo+rMzXPRABYmhjvgzqmVVjIPOKZUAWlxxNKGWHIOq9g6
	uTVoXovs6PeC4lPEhIgkpzH6DySNnmoohq9WEmi5jALgGihROTiD7NHMEEY3tozIThU2aWB24Z/
	ksRJgdVr5VFM66jvGBRGJCqd4Tz5EqPkg4PNDqu2+B
X-Gm-Gg: ASbGncsM9si6+DrmeLwS2/M0WOK1p/3O2VNZxj9P9dU4ec8WZTaine9XDv28E+TSKYA
	VbhXw7YDHCtWruQTZJjm6b07IBBlRmz7doQr2fUt/zGDP+gY5VaH35GJ+tGmougKuG6LQMUXtHq
	Nmdk5bvWC3h7e+xpflgthTQA==
X-Received: by 2002:a17:90b:35c3:b0:327:ced1:26e2 with SMTP id 98e67ed59e1d1-328156baf5amr18434116a91.18.1756871908150;
        Tue, 02 Sep 2025 20:58:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGj/l9+XDmJEijKU+wd1/EfrIGEVTmiQHMGFvLZVwWY+MpGINUIbbo3w/Qh26mBLxXeGt+dZGVUhyR6UTD9/h0=
X-Received: by 2002:a17:90b:35c3:b0:327:ced1:26e2 with SMTP id
 98e67ed59e1d1-328156baf5amr18434091a91.18.1756871907644; Tue, 02 Sep 2025
 20:58:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250826112709.1051172-1-eperezma@redhat.com> <20250826112709.1051172-3-eperezma@redhat.com>
 <CACGkMEvd9w_ijpf=+re8oUxUWfq6Q_0HaDM==_e65df3439k7w@mail.gmail.com> <CAJaqyWeHLw9CUEkH1KF8np2zJMC-zMRU6AFRJEhczzuF7MNU8A@mail.gmail.com>
In-Reply-To: <CAJaqyWeHLw9CUEkH1KF8np2zJMC-zMRU6AFRJEhczzuF7MNU8A@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 3 Sep 2025 11:58:15 +0800
X-Gm-Features: Ac12FXxSXhLTpVqItZbwqLFmkkE7aWjAaPiNbYHNxF5T95f90TGBfdwRbZ2e3zk
Message-ID: <CACGkMEsUjfPadVi8Qr8L723mbQ_21WG7e07mDd79KDHFNn_AFw@mail.gmail.com>
Subject: Re: [PATCH 2/6] vduse: add vq group support
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Cindy Lu <lulu@redhat.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Laurent Vivier <lvivier@redhat.com>, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Yongji Xie <xieyongji@bytedance.com>, 
	Maxime Coquelin <mcoqueli@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 1, 2025 at 4:40=E2=80=AFPM Eugenio Perez Martin <eperezma@redha=
t.com> wrote:
>
> On Mon, Sep 1, 2025 at 3:59=E2=80=AFAM Jason Wang <jasowang@redhat.com> w=
rote:
> >
> > On Tue, Aug 26, 2025 at 7:27=E2=80=AFPM Eugenio P=C3=A9rez <eperezma@re=
dhat.com> wrote:
> > >
> > > This allows sepparate the different virtqueues in groups that shares =
the
> > > same address space.  Asking the VDUSE device for the groups of the vq=
 at
> > > the beginning as they're needed for the DMA API.
> > >
> > > Allocating 3 vq groups as net is the device that need the most groups=
:
> > > * Dataplane (guest passthrough)
> > > * CVQ
> > > * Shadowed vrings.
> > >
> > > Future versions of the series can include dynamic allocation of the
> > > groups array so VDUSE can declare more groups.
> > >
> > > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > > ---
> > > v1: Fix: Remove BIT_ULL(VIRTIO_S_*), as _S_ is already the bit (Maxim=
e)
> > >
> > > RFC v3:
> > > * Increase VDUSE_MAX_VQ_GROUPS to 0xffff (Jason). It was set to a low=
er
> > >   value to reduce memory consumption, but vqs are already limited to
> > >   that value and userspace VDUSE is able to allocate that many vqs.
> > > * Remove the descs vq group capability as it will not be used and we =
can
> > >   add it on top.
> > > * Do not ask for vq groups in number of vq groups < 2.
> > > * Move the valid vq groups range check to vduse_validate_config.
> > >
> > > RFC v2:
> > > * Cache group information in kernel, as we need to provide the vq map
> > >   tokens properly.
> > > * Add descs vq group to optimize SVQ forwarding and support indirect
> > >   descriptors out of the box.
> > > ---
> > >  drivers/vdpa/vdpa_user/vduse_dev.c | 51 ++++++++++++++++++++++++++++=
--
> > >  include/uapi/linux/vduse.h         | 21 +++++++++++-
> > >  2 files changed, 68 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_u=
ser/vduse_dev.c
> > > index e7bced0b5542..0f4e36dd167e 100644
> > > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > > @@ -58,6 +58,7 @@ struct vduse_virtqueue {
> > >         struct vdpa_vq_state state;
> > >         bool ready;
> > >         bool kicked;
> > > +       u32 vq_group;
> > >         spinlock_t kick_lock;
> > >         spinlock_t irq_lock;
> > >         struct eventfd_ctx *kickfd;
> > > @@ -114,6 +115,7 @@ struct vduse_dev {
> > >         u8 status;
> > >         u32 vq_num;
> > >         u32 vq_align;
> > > +       u32 ngroups;
> > >         struct vduse_umem *umem;
> > >         struct mutex mem_lock;
> > >         unsigned int bounce_size;
> > > @@ -592,6 +594,13 @@ static int vduse_vdpa_set_vq_state(struct vdpa_d=
evice *vdpa, u16 idx,
> > >         return 0;
> > >  }
> > >
> > > +static u32 vduse_get_vq_group(struct vdpa_device *vdpa, u16 idx)
> > > +{
> > > +       struct vduse_dev *dev =3D vdpa_to_vduse(vdpa);
> > > +
> > > +       return dev->vqs[idx]->vq_group;
> > > +}
> > > +
> > >  static int vduse_vdpa_get_vq_state(struct vdpa_device *vdpa, u16 idx=
,
> > >                                 struct vdpa_vq_state *state)
> > >  {
> > > @@ -678,6 +687,28 @@ static u8 vduse_vdpa_get_status(struct vdpa_devi=
ce *vdpa)
> > >         return dev->status;
> > >  }
> > >
> > > +static int vduse_fill_vq_groups(struct vduse_dev *dev)
> > > +{
> > > +       /* All vqs and descs must be in vq group 0 if ngroups < 2 */
> > > +       if (dev->ngroups < 2)
> > > +               return 0;
> > > +
> > > +       for (int i =3D 0; i < dev->vdev->vdpa.nvqs; ++i) {
> > > +               struct vduse_dev_msg msg =3D { 0 };
> > > +               int ret;
> > > +
> > > +               msg.req.type =3D VDUSE_GET_VQ_GROUP;
> > > +               msg.req.vq_group.index =3D i;
> > > +               ret =3D vduse_dev_msg_sync(dev, &msg);
> > > +               if (ret)
> > > +                       return ret;
> > > +
> > > +               dev->vqs[i]->vq_group =3D msg.resp.vq_group.group;
> > > +       }
> > > +
> > > +       return 0;
> > > +}
> > > +
> > >  static void vduse_vdpa_set_status(struct vdpa_device *vdpa, u8 statu=
s)
> > >  {
> > >         struct vduse_dev *dev =3D vdpa_to_vduse(vdpa);
> > > @@ -685,6 +716,11 @@ static void vduse_vdpa_set_status(struct vdpa_de=
vice *vdpa, u8 status)
> > >         if (vduse_dev_set_status(dev, status))
> > >                 return;
> > >
> > > +       if (((dev->status ^ status) & VIRTIO_CONFIG_S_FEATURES_OK) &&
> > > +           (status & VIRTIO_CONFIG_S_FEATURES_OK))
> > > +               if (vduse_fill_vq_groups(dev))
> > > +                       return;
> >
> > I may lose some context but I think we've agreed that we need to
> > extend the status response for this instead of having multiple
> > indepdent response.
> >
>
> My understanding was it is ok to start with this version by [1]. We
> can even make it asynchronous on top if we find this is a bottleneck
> and the VDUSE device would need no change, would that work?

I think I need to understand why we can not defer this to get_group_asid() =
call.

Thanks


