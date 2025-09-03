Return-Path: <linux-kernel+bounces-797904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17D35B41700
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 09:41:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10D033AC842
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 07:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 041482DECB7;
	Wed,  3 Sep 2025 07:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DcHKANtT"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E6FF2DE71D
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 07:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756885251; cv=none; b=V3cPELUUaoxZbn9YjMx9JonXNU29fjylwmVq/aeVZ9qSdEQ5OG2LZJF0ARDaVeGtDB/ySmWgdcAGLngpWwygh8C8qZM0I57rbv74UKK/k5ubKHTHlkxMwa5z0J4dCLEBxamv0Bu+IqPIU5JC4GwPp1+qhPx5Ok3VcHKiDAiB9VY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756885251; c=relaxed/simple;
	bh=6VPWOdFBF6rRqKIzINPp+yDsrQQv5D2JFUneeYieV70=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NGwgBq5rN1/RXmUyVXqGJZvoNKx3VzwScE0bRDORJu7VS4KR57omUP7HKasD6/GRyPJ08zmvRcIfG5x3ZrEQU0zCoiQ1Q8iWDGaIkH8nXw5p6Sr9flRhtymSs/9i/013d4O4X+WLMT8rZfw9ETG8sQpMxqDDuytuTjABZ/RXEMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DcHKANtT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756885246;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p4LAt2WRO8kSFLIa32uL4kKJ+Zm5Jrcb4Q/28wUR1i4=;
	b=DcHKANtTcavfSeoh64gRROmbUdru6hl81RzI83cT5p/PogVy4Kzrd85Xipv7vab8ixXtf5
	yuspysXGnRVuJjVgyW2sj3/UhmCBBlBjbjo8KbCDogamvtyQcFwJpb9+VzrzEwGMYLZidK
	HluICEMeBfnNHeQ7VLVpBabhROC+HtE=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679-ejM0OjstPN2rxTpxSPzIJg-1; Wed, 03 Sep 2025 03:40:43 -0400
X-MC-Unique: ejM0OjstPN2rxTpxSPzIJg-1
X-Mimecast-MFC-AGG-ID: ejM0OjstPN2rxTpxSPzIJg_1756885242
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-329dca88b5aso881499a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 00:40:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756885242; x=1757490042;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p4LAt2WRO8kSFLIa32uL4kKJ+Zm5Jrcb4Q/28wUR1i4=;
        b=i/beHl7vAItqxNXHW5BsdTDXVwiRlRehXTSLGAIivcooQvExMvi7NJlJQvEIh544uO
         B7fkwDz25kE5URGt7RFDJTUl0iLz9Yrf0AxphD1Q90sDgi2m/SQJ+NW1RH846PZz7e4t
         DwWnsFuxhK+rGcNVB82k3CvEVuwQ5LcCvNKsYX3qU/3NcYPC1E6gT/MDm69haqE46K+q
         bhiN9T8OEp17zY4TXcTMpXt7EUWFvJGwbYUvH/qKe2cPphtnKcLOFi7bpvjYDf0GU7E4
         hfNRg4SpYuMRFpg96jBFn+V6CC06o8CDeIxAB54NyUiZdMvO0lFakJEqxsrsEko0O4PR
         A9lw==
X-Forwarded-Encrypted: i=1; AJvYcCXAEaGjNNEUGwrJ1J+u2ik7xH4Pbxe3OwArHfzRhJ3o/HiY4glVTtNeyHx5NyIAaCsstDZ05+KTM47UxJI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvfqlmUq5Vvdl14yHk9zSA5jYH74o+j4J0cAjFmYMLsI5uzyM0
	o4u17njhBcqDAcFhzX8XY+sfIkYGb9HsigDkXmsAcx+oG2kvKhTJtRDDCoibri5St86mPxSEYQB
	rULQH3d7lcjieC5zic/3M2kC78pWF+LH/T7oB7VX9Ec+fpp2qaDVjS2oAzkJiFRX0yk2eckR4fT
	2iZuiUVbToQA07ThLERQrTlmnhfK91+zk6t4lBVEz6
X-Gm-Gg: ASbGncu4hG+Ob2KjmVnXuDbzMO58Fv3iVGHij+GlDGr5MMODVmwLoNbUOJ0j/3HdLiL
	AScOIeKNTmiZurpsmQX1AQcse4qHhfXWvF3oc1mUtM/oF7mcnTqarSEDmF/odosliRoj/uby/BZ
	5yCxaupkYlbANsmmSrRHOCaA==
X-Received: by 2002:a17:90b:1c06:b0:327:faa6:b5b7 with SMTP id 98e67ed59e1d1-328156e2eb4mr17484188a91.17.1756885241985;
        Wed, 03 Sep 2025 00:40:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF2D+tunKE0kpnVXWblaZ0xPi9LkHXkvVFVTag9Z+KZnqiABGP1w0GL6Mdoi2l6ZEfY6XJhCwxHfR4+efLG43g=
X-Received: by 2002:a17:90b:1c06:b0:327:faa6:b5b7 with SMTP id
 98e67ed59e1d1-328156e2eb4mr17484153a91.17.1756885241337; Wed, 03 Sep 2025
 00:40:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250826112709.1051172-1-eperezma@redhat.com> <20250826112709.1051172-3-eperezma@redhat.com>
 <CACGkMEvd9w_ijpf=+re8oUxUWfq6Q_0HaDM==_e65df3439k7w@mail.gmail.com>
 <CAJaqyWeHLw9CUEkH1KF8np2zJMC-zMRU6AFRJEhczzuF7MNU8A@mail.gmail.com>
 <CACGkMEsUjfPadVi8Qr8L723mbQ_21WG7e07mDd79KDHFNn_AFw@mail.gmail.com> <CAJaqyWejgnBngjrnuzefTVAhdjRcDOzAJfe5b0aE65uxON=G5w@mail.gmail.com>
In-Reply-To: <CAJaqyWejgnBngjrnuzefTVAhdjRcDOzAJfe5b0aE65uxON=G5w@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 3 Sep 2025 15:40:29 +0800
X-Gm-Features: Ac12FXzSvObKwGD-XIPbp-CGM5DYKP6-tGxp6Rb7tpvG20l0mngZhofZPSSayKM
Message-ID: <CACGkMEtsCF5d_fdbkb9oPWQOscR=UgW3xq3ghQKXoWv1Be55Ag@mail.gmail.com>
Subject: Re: [PATCH 2/6] vduse: add vq group support
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Cindy Lu <lulu@redhat.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Laurent Vivier <lvivier@redhat.com>, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Yongji Xie <xieyongji@bytedance.com>, 
	Maxime Coquelin <mcoqueli@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 3, 2025 at 2:29=E2=80=AFPM Eugenio Perez Martin <eperezma@redha=
t.com> wrote:
>
> On Wed, Sep 3, 2025 at 5:58=E2=80=AFAM Jason Wang <jasowang@redhat.com> w=
rote:
> >
> > On Mon, Sep 1, 2025 at 4:40=E2=80=AFPM Eugenio Perez Martin <eperezma@r=
edhat.com> wrote:
> > >
> > > On Mon, Sep 1, 2025 at 3:59=E2=80=AFAM Jason Wang <jasowang@redhat.co=
m> wrote:
> > > >
> > > > On Tue, Aug 26, 2025 at 7:27=E2=80=AFPM Eugenio P=C3=A9rez <eperezm=
a@redhat.com> wrote:
> > > > >
> > > > > This allows sepparate the different virtqueues in groups that sha=
res the
> > > > > same address space.  Asking the VDUSE device for the groups of th=
e vq at
> > > > > the beginning as they're needed for the DMA API.
> > > > >
> > > > > Allocating 3 vq groups as net is the device that need the most gr=
oups:
> > > > > * Dataplane (guest passthrough)
> > > > > * CVQ
> > > > > * Shadowed vrings.
> > > > >
> > > > > Future versions of the series can include dynamic allocation of t=
he
> > > > > groups array so VDUSE can declare more groups.
> > > > >
> > > > > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > > > > ---
> > > > > v1: Fix: Remove BIT_ULL(VIRTIO_S_*), as _S_ is already the bit (M=
axime)
> > > > >
> > > > > RFC v3:
> > > > > * Increase VDUSE_MAX_VQ_GROUPS to 0xffff (Jason). It was set to a=
 lower
> > > > >   value to reduce memory consumption, but vqs are already limited=
 to
> > > > >   that value and userspace VDUSE is able to allocate that many vq=
s.
> > > > > * Remove the descs vq group capability as it will not be used and=
 we can
> > > > >   add it on top.
> > > > > * Do not ask for vq groups in number of vq groups < 2.
> > > > > * Move the valid vq groups range check to vduse_validate_config.
> > > > >
> > > > > RFC v2:
> > > > > * Cache group information in kernel, as we need to provide the vq=
 map
> > > > >   tokens properly.
> > > > > * Add descs vq group to optimize SVQ forwarding and support indir=
ect
> > > > >   descriptors out of the box.
> > > > > ---
> > > > >  drivers/vdpa/vdpa_user/vduse_dev.c | 51 ++++++++++++++++++++++++=
++++--
> > > > >  include/uapi/linux/vduse.h         | 21 +++++++++++-
> > > > >  2 files changed, 68 insertions(+), 4 deletions(-)
> > > > >
> > > > > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vd=
pa_user/vduse_dev.c
> > > > > index e7bced0b5542..0f4e36dd167e 100644
> > > > > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > > @@ -58,6 +58,7 @@ struct vduse_virtqueue {
> > > > >         struct vdpa_vq_state state;
> > > > >         bool ready;
> > > > >         bool kicked;
> > > > > +       u32 vq_group;
> > > > >         spinlock_t kick_lock;
> > > > >         spinlock_t irq_lock;
> > > > >         struct eventfd_ctx *kickfd;
> > > > > @@ -114,6 +115,7 @@ struct vduse_dev {
> > > > >         u8 status;
> > > > >         u32 vq_num;
> > > > >         u32 vq_align;
> > > > > +       u32 ngroups;
> > > > >         struct vduse_umem *umem;
> > > > >         struct mutex mem_lock;
> > > > >         unsigned int bounce_size;
> > > > > @@ -592,6 +594,13 @@ static int vduse_vdpa_set_vq_state(struct vd=
pa_device *vdpa, u16 idx,
> > > > >         return 0;
> > > > >  }
> > > > >
> > > > > +static u32 vduse_get_vq_group(struct vdpa_device *vdpa, u16 idx)
> > > > > +{
> > > > > +       struct vduse_dev *dev =3D vdpa_to_vduse(vdpa);
> > > > > +
> > > > > +       return dev->vqs[idx]->vq_group;
> > > > > +}
> > > > > +
> > > > >  static int vduse_vdpa_get_vq_state(struct vdpa_device *vdpa, u16=
 idx,
> > > > >                                 struct vdpa_vq_state *state)
> > > > >  {
> > > > > @@ -678,6 +687,28 @@ static u8 vduse_vdpa_get_status(struct vdpa_=
device *vdpa)
> > > > >         return dev->status;
> > > > >  }
> > > > >
> > > > > +static int vduse_fill_vq_groups(struct vduse_dev *dev)
> > > > > +{
> > > > > +       /* All vqs and descs must be in vq group 0 if ngroups < 2=
 */
> > > > > +       if (dev->ngroups < 2)
> > > > > +               return 0;
> > > > > +
> > > > > +       for (int i =3D 0; i < dev->vdev->vdpa.nvqs; ++i) {
> > > > > +               struct vduse_dev_msg msg =3D { 0 };
> > > > > +               int ret;
> > > > > +
> > > > > +               msg.req.type =3D VDUSE_GET_VQ_GROUP;
> > > > > +               msg.req.vq_group.index =3D i;
> > > > > +               ret =3D vduse_dev_msg_sync(dev, &msg);
> > > > > +               if (ret)
> > > > > +                       return ret;
> > > > > +
> > > > > +               dev->vqs[i]->vq_group =3D msg.resp.vq_group.group=
;
> > > > > +       }
> > > > > +
> > > > > +       return 0;
> > > > > +}
> > > > > +
> > > > >  static void vduse_vdpa_set_status(struct vdpa_device *vdpa, u8 s=
tatus)
> > > > >  {
> > > > >         struct vduse_dev *dev =3D vdpa_to_vduse(vdpa);
> > > > > @@ -685,6 +716,11 @@ static void vduse_vdpa_set_status(struct vdp=
a_device *vdpa, u8 status)
> > > > >         if (vduse_dev_set_status(dev, status))
> > > > >                 return;
> > > > >
> > > > > +       if (((dev->status ^ status) & VIRTIO_CONFIG_S_FEATURES_OK=
) &&
> > > > > +           (status & VIRTIO_CONFIG_S_FEATURES_OK))
> > > > > +               if (vduse_fill_vq_groups(dev))
> > > > > +                       return;
> > > >
> > > > I may lose some context but I think we've agreed that we need to
> > > > extend the status response for this instead of having multiple
> > > > indepdent response.
> > > >
> > >
> > > My understanding was it is ok to start with this version by [1]. We
> > > can even make it asynchronous on top if we find this is a bottleneck
> > > and the VDUSE device would need no change, would that work?
> >
> > I think I need to understand why we can not defer this to get_group_asi=
d() call.
> >
>
> Because we need to know the vq_groups->asid mapping in other calls
> like set_group_asid or get_vq_group.

I think we don't need the mapping of those, or anything I miss?

And the vq to group mappings could be piggy backed by the device
creation request.

>
> We could add a boolean on each virtqueue to track if we know its
> virtqueue group and then only ask VDUSE device it if needed, would
> that work?

Thanks

>


