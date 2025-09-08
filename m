Return-Path: <linux-kernel+bounces-804972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B40EEB48282
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 04:12:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 632E23A45D1
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 02:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E6A91DFE12;
	Mon,  8 Sep 2025 02:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aF1k8Uxm"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A0FF1DF246
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 02:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757297573; cv=none; b=hPBfsromUoSwSjB5MftdhlHtRf52BvjmgPph9aGdHxR5rqxEOFmbyyubeehvhAtZWZdbV0EC1B7K1Hv5R6/LiJtmv94cWqvZjrN6nyv2e2Qv2fBW7wTjya2DeLAkWp6+NXYA0WI65V02c1ATpETiWP4WVNzSyF9gRakpwIbD7WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757297573; c=relaxed/simple;
	bh=rH5V0FEWA/4OTC2w3xtP2uEnhbXBnOIqXqYpBxQzC80=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pqt/VF3PToBND07NRzExk/Iu3X1+zPBPaCLKnsj9x/6w9GIasu9xD0VIh3RA0LGpiuzQo1oQ8UnDe2vNxo0EI3NGLss57U0JsFa2DSKarDLBHaj4BZwttYOMQjJJZi9fSy/oLMtdi0vV6hSLYOAXSPq9bkSXIk9xoevsNE8Z+UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aF1k8Uxm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757297570;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MWpPh0mHESgML0G8Lfix+KcLD7sLsvv/p81owY9SAiI=;
	b=aF1k8UxmjYq/9zM49x1eUB2UuzNRQWC4PndHkrZa5SZ9gHeHNHCdps7j4ACgaE1gALdVaI
	4zkxssKWN30FqKNlA0F23zBjPSApNJQmf4Q/LRMQh2wbizk/4i7oZ8jQMCwpex5Y3Lv8Rv
	u6JipEQTyLUdNY8NPNk3pZvD3DgWbWg=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-139-ifmxV0CXPaS_d26ZDqhGyA-1; Sun, 07 Sep 2025 22:12:48 -0400
X-MC-Unique: ifmxV0CXPaS_d26ZDqhGyA-1
X-Mimecast-MFC-AGG-ID: ifmxV0CXPaS_d26ZDqhGyA_1757297568
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3234811cab3so4415039a91.3
        for <linux-kernel@vger.kernel.org>; Sun, 07 Sep 2025 19:12:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757297567; x=1757902367;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MWpPh0mHESgML0G8Lfix+KcLD7sLsvv/p81owY9SAiI=;
        b=aSm5R/h8IGviG6Q/Xe0OJ7BviXySU6gXc9DAfJeEGlK+Jb9xz4I2LaTjPWrkJ7DyCM
         6R2p7qzbOvsbmpafNG5mr3fzud+f/1yna9yXueO32xLOWze/mAKA+WDKD3m4DZCYluKo
         52LBk5AGxX/fpUg4qakNeozUByKYzwTUt9q/+M/5L41XgUu7CwyFZz4bH+VrLNBZWriL
         0Dyf6dfuEIqeae5KrYY7FJnfnL0FmmPYLPL9fLC84tf4Enm5WxhuVTBYiit8ya0vT+Sb
         QKQ89+kL1el4EplrJ5PYLNjccu7puuK+z00SKgtc7+NAWCubA8m6fq4dbFnN+o/+lqwS
         eNHQ==
X-Forwarded-Encrypted: i=1; AJvYcCVAY6l+IEDlxqZPClaTamkfOwOMHBvizow4WYTvjzvhHLzVrRAHMfI7bXmXB7LOwurs4/c/x427CZ0A15Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+dTSMvP7/CE5/36JMT2Jd1v2QR5o9seZmfkZmb0d0wEUuevDV
	aFcJj/deYnDGDE3cK4+4SfH+rxsucyhxstYAEiKnAiIIdyiowMI8Z+rITs7lkcx3osQ5Fj7UsCv
	cX0wiwErgzQEolZhXU77ulkfkmO+iXm8axrTQ4FA8M8SQKasqSh5UIQgT9zaKJMgMULDdSQnAL/
	4564Jn502/SrjF2UPt9jK2rXfT5LnPcjcPOUaZLGL3WGdbxyczxXU=
X-Gm-Gg: ASbGnctA3+Zv3wKJ5jYMvK6joXoyC1BdfHJO6C2KOUVjhLk9oZUyLWK+4+P65AbbMNh
	Q0iIx78bP8iaSig4S4um/HUm7NEhhXR8vBBL5S3NHbJyjJJC4JfMyhN2e9JKGywIIytlawzCxWT
	9msoluQo1C08z0fVFlBR5T
X-Received: by 2002:a17:90b:2684:b0:32b:6223:259 with SMTP id 98e67ed59e1d1-32d43eff89amr7569645a91.13.1757297567524;
        Sun, 07 Sep 2025 19:12:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFSsiHEivkn+VQ6VUepAa6sQD7ojw5EVHfUx0SY58PVFB/0bDm63pxJKrggybbW9h3yTFhYqCxMsJKv6UAgIhE=
X-Received: by 2002:a17:90b:2684:b0:32b:6223:259 with SMTP id
 98e67ed59e1d1-32d43eff89amr7569617a91.13.1757297566988; Sun, 07 Sep 2025
 19:12:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250826112709.1051172-1-eperezma@redhat.com> <20250826112709.1051172-3-eperezma@redhat.com>
 <CACGkMEvd9w_ijpf=+re8oUxUWfq6Q_0HaDM==_e65df3439k7w@mail.gmail.com>
 <CAJaqyWeHLw9CUEkH1KF8np2zJMC-zMRU6AFRJEhczzuF7MNU8A@mail.gmail.com>
 <CACGkMEsUjfPadVi8Qr8L723mbQ_21WG7e07mDd79KDHFNn_AFw@mail.gmail.com>
 <CAJaqyWejgnBngjrnuzefTVAhdjRcDOzAJfe5b0aE65uxON=G5w@mail.gmail.com>
 <CACGkMEtsCF5d_fdbkb9oPWQOscR=UgW3xq3ghQKXoWv1Be55Ag@mail.gmail.com>
 <CAJaqyWcAptQjRktZ7WcyDHADFqR0ZjGZ_D+gvKyq4JGSb7yFaQ@mail.gmail.com>
 <CACGkMEudOzDUzVr8i8PbeJ2q81vzBtEVDZKu=67R5y+p_9j8Bw@mail.gmail.com>
 <CACGkMEuPTzY1WD-yJri3q7pmx0D3DCNOD=iLJ2rpzx12K9370A@mail.gmail.com> <CAJaqyWcQwkpRZdKJBSHhtfLXfL5gb2_z8j-OsqSy3pPa+ZvYxw@mail.gmail.com>
In-Reply-To: <CAJaqyWcQwkpRZdKJBSHhtfLXfL5gb2_z8j-OsqSy3pPa+ZvYxw@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 8 Sep 2025 10:12:35 +0800
X-Gm-Features: Ac12FXwWAIz3NJeQs1U3UclbDxwZ7ptExqduje8uhFztt_0bqAoCJ9Ey3D8bTZ0
Message-ID: <CACGkMEsX+D2_12xGDxusO3+BR2bqqXodHHjLy_4TJCpm96jRTA@mail.gmail.com>
Subject: Re: [PATCH 2/6] vduse: add vq group support
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Cindy Lu <lulu@redhat.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Laurent Vivier <lvivier@redhat.com>, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Yongji Xie <xieyongji@bytedance.com>, 
	Maxime Coquelin <mcoqueli@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 5, 2025 at 4:47=E2=80=AFPM Eugenio Perez Martin <eperezma@redha=
t.com> wrote:
>
> On Thu, Sep 4, 2025 at 5:20=E2=80=AFAM Jason Wang <jasowang@redhat.com> w=
rote:
> >
> > On Thu, Sep 4, 2025 at 11:08=E2=80=AFAM Jason Wang <jasowang@redhat.com=
> wrote:
> > >
> > > On Wed, Sep 3, 2025 at 6:31=E2=80=AFPM Eugenio Perez Martin <eperezma=
@redhat.com> wrote:
> > > >
> > > > On Wed, Sep 3, 2025 at 9:40=E2=80=AFAM Jason Wang <jasowang@redhat.=
com> wrote:
> > > > >
> > > > > On Wed, Sep 3, 2025 at 2:29=E2=80=AFPM Eugenio Perez Martin <eper=
ezma@redhat.com> wrote:
> > > > > >
> > > > > > On Wed, Sep 3, 2025 at 5:58=E2=80=AFAM Jason Wang <jasowang@red=
hat.com> wrote:
> > > > > > >
> > > > > > > On Mon, Sep 1, 2025 at 4:40=E2=80=AFPM Eugenio Perez Martin <=
eperezma@redhat.com> wrote:
> > > > > > > >
> > > > > > > > On Mon, Sep 1, 2025 at 3:59=E2=80=AFAM Jason Wang <jasowang=
@redhat.com> wrote:
> > > > > > > > >
> > > > > > > > > On Tue, Aug 26, 2025 at 7:27=E2=80=AFPM Eugenio P=C3=A9re=
z <eperezma@redhat.com> wrote:
> > > > > > > > > >
> > > > > > > > > > This allows sepparate the different virtqueues in group=
s that shares the
> > > > > > > > > > same address space.  Asking the VDUSE device for the gr=
oups of the vq at
> > > > > > > > > > the beginning as they're needed for the DMA API.
> > > > > > > > > >
> > > > > > > > > > Allocating 3 vq groups as net is the device that need t=
he most groups:
> > > > > > > > > > * Dataplane (guest passthrough)
> > > > > > > > > > * CVQ
> > > > > > > > > > * Shadowed vrings.
> > > > > > > > > >
> > > > > > > > > > Future versions of the series can include dynamic alloc=
ation of the
> > > > > > > > > > groups array so VDUSE can declare more groups.
> > > > > > > > > >
> > > > > > > > > > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > > > > > > > > > ---
> > > > > > > > > > v1: Fix: Remove BIT_ULL(VIRTIO_S_*), as _S_ is already =
the bit (Maxime)
> > > > > > > > > >
> > > > > > > > > > RFC v3:
> > > > > > > > > > * Increase VDUSE_MAX_VQ_GROUPS to 0xffff (Jason). It wa=
s set to a lower
> > > > > > > > > >   value to reduce memory consumption, but vqs are alrea=
dy limited to
> > > > > > > > > >   that value and userspace VDUSE is able to allocate th=
at many vqs.
> > > > > > > > > > * Remove the descs vq group capability as it will not b=
e used and we can
> > > > > > > > > >   add it on top.
> > > > > > > > > > * Do not ask for vq groups in number of vq groups < 2.
> > > > > > > > > > * Move the valid vq groups range check to vduse_validat=
e_config.
> > > > > > > > > >
> > > > > > > > > > RFC v2:
> > > > > > > > > > * Cache group information in kernel, as we need to prov=
ide the vq map
> > > > > > > > > >   tokens properly.
> > > > > > > > > > * Add descs vq group to optimize SVQ forwarding and sup=
port indirect
> > > > > > > > > >   descriptors out of the box.
> > > > > > > > > > ---
> > > > > > > > > >  drivers/vdpa/vdpa_user/vduse_dev.c | 51 ++++++++++++++=
++++++++++++++--
> > > > > > > > > >  include/uapi/linux/vduse.h         | 21 +++++++++++-
> > > > > > > > > >  2 files changed, 68 insertions(+), 4 deletions(-)
> > > > > > > > > >
> > > > > > > > > > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drive=
rs/vdpa/vdpa_user/vduse_dev.c
> > > > > > > > > > index e7bced0b5542..0f4e36dd167e 100644
> > > > > > > > > > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > > > > > > > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > > > > > > > @@ -58,6 +58,7 @@ struct vduse_virtqueue {
> > > > > > > > > >         struct vdpa_vq_state state;
> > > > > > > > > >         bool ready;
> > > > > > > > > >         bool kicked;
> > > > > > > > > > +       u32 vq_group;
> > > > > > > > > >         spinlock_t kick_lock;
> > > > > > > > > >         spinlock_t irq_lock;
> > > > > > > > > >         struct eventfd_ctx *kickfd;
> > > > > > > > > > @@ -114,6 +115,7 @@ struct vduse_dev {
> > > > > > > > > >         u8 status;
> > > > > > > > > >         u32 vq_num;
> > > > > > > > > >         u32 vq_align;
> > > > > > > > > > +       u32 ngroups;
> > > > > > > > > >         struct vduse_umem *umem;
> > > > > > > > > >         struct mutex mem_lock;
> > > > > > > > > >         unsigned int bounce_size;
> > > > > > > > > > @@ -592,6 +594,13 @@ static int vduse_vdpa_set_vq_state=
(struct vdpa_device *vdpa, u16 idx,
> > > > > > > > > >         return 0;
> > > > > > > > > >  }
> > > > > > > > > >
> > > > > > > > > > +static u32 vduse_get_vq_group(struct vdpa_device *vdpa=
, u16 idx)
> > > > > > > > > > +{
> > > > > > > > > > +       struct vduse_dev *dev =3D vdpa_to_vduse(vdpa);
> > > > > > > > > > +
> > > > > > > > > > +       return dev->vqs[idx]->vq_group;
> > > > > > > > > > +}
> > > > > > > > > > +
> > > > > > > > > >  static int vduse_vdpa_get_vq_state(struct vdpa_device =
*vdpa, u16 idx,
> > > > > > > > > >                                 struct vdpa_vq_state *s=
tate)
> > > > > > > > > >  {
> > > > > > > > > > @@ -678,6 +687,28 @@ static u8 vduse_vdpa_get_status(st=
ruct vdpa_device *vdpa)
> > > > > > > > > >         return dev->status;
> > > > > > > > > >  }
> > > > > > > > > >
> > > > > > > > > > +static int vduse_fill_vq_groups(struct vduse_dev *dev)
> > > > > > > > > > +{
> > > > > > > > > > +       /* All vqs and descs must be in vq group 0 if n=
groups < 2 */
> > > > > > > > > > +       if (dev->ngroups < 2)
> > > > > > > > > > +               return 0;
> > > > > > > > > > +
> > > > > > > > > > +       for (int i =3D 0; i < dev->vdev->vdpa.nvqs; ++i=
) {
> > > > > > > > > > +               struct vduse_dev_msg msg =3D { 0 };
> > > > > > > > > > +               int ret;
> > > > > > > > > > +
> > > > > > > > > > +               msg.req.type =3D VDUSE_GET_VQ_GROUP;
> > > > > > > > > > +               msg.req.vq_group.index =3D i;
> > > > > > > > > > +               ret =3D vduse_dev_msg_sync(dev, &msg);
> > > > > > > > > > +               if (ret)
> > > > > > > > > > +                       return ret;
> > > > > > > > > > +
> > > > > > > > > > +               dev->vqs[i]->vq_group =3D msg.resp.vq_g=
roup.group;
> > > > > > > > > > +       }
> > > > > > > > > > +
> > > > > > > > > > +       return 0;
> > > > > > > > > > +}
> > > > > > > > > > +
> > > > > > > > > >  static void vduse_vdpa_set_status(struct vdpa_device *=
vdpa, u8 status)
> > > > > > > > > >  {
> > > > > > > > > >         struct vduse_dev *dev =3D vdpa_to_vduse(vdpa);
> > > > > > > > > > @@ -685,6 +716,11 @@ static void vduse_vdpa_set_status(=
struct vdpa_device *vdpa, u8 status)
> > > > > > > > > >         if (vduse_dev_set_status(dev, status))
> > > > > > > > > >                 return;
> > > > > > > > > >
> > > > > > > > > > +       if (((dev->status ^ status) & VIRTIO_CONFIG_S_F=
EATURES_OK) &&
> > > > > > > > > > +           (status & VIRTIO_CONFIG_S_FEATURES_OK))
> > > > > > > > > > +               if (vduse_fill_vq_groups(dev))
> > > > > > > > > > +                       return;
> > > > > > > > >
> > > > > > > > > I may lose some context but I think we've agreed that we =
need to
> > > > > > > > > extend the status response for this instead of having mul=
tiple
> > > > > > > > > indepdent response.
> > > > > > > > >
> > > > > > > >
> > > > > > > > My understanding was it is ok to start with this version by=
 [1]. We
> > > > > > > > can even make it asynchronous on top if we find this is a b=
ottleneck
> > > > > > > > and the VDUSE device would need no change, would that work?
> > > > > > >
> > > > > > > I think I need to understand why we can not defer this to get=
_group_asid() call.
> > > > > > >
> > > > > >
> > > > > > Because we need to know the vq_groups->asid mapping in other ca=
lls
> > > > > > like set_group_asid or get_vq_group.
> > > > >
> > > > > I think we don't need the mapping of those, or anything I miss?
> > > > >
> > > >
> > > > If the kernel module does not ask the userland device for the actua=
l
> > > > vq group of a virtqueue, what should it return in vduse_get_vq_grou=
p?
> > > > 0 for all vqs, even if the CVQ is in vq group 1?
> > >
> > > Since the topology is fixed I think userspace should provide this whe=
n
> > > creating a device.
> > >
>
> The topology is not fixed: The CVQ may be either the vq #2 or the last
> one depending if mq has been negotiated or not.
>
> So it cannot be provided at device creation, but only after feature negot=
iation.

You are correct. This has been discussed before.

Thanks


