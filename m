Return-Path: <linux-kernel+bounces-797669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CCD96B4134A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 05:57:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C34E547FEC
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 03:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BA9533E7;
	Wed,  3 Sep 2025 03:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SIv2BiEm"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE2C2D0637
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 03:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756871865; cv=none; b=tawzYABZmeuUAVtXK54RYQib2lqh3JYv54QfQAZ7m0DQGE1kal3lgAYd31X976SCbVO0Oi7FiO7MG+96pcCdl8HL3pFkyIgudRDbCJxzySpTW2CnuhY4bZn4/31TN2bKOtS4Cx96mjPkWCKS0fL0beaEfyzTo4Cm84vSSi49YmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756871865; c=relaxed/simple;
	bh=A7ssKPkqIDibigKVgV/mQDJH2sZnTU82jjxAnNgso+g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MCcJwwEzRTJibyuy00p3glZy38w/1AgWwtut1HVgv3mQmm3j55zDFdq6TCWL2UYnxaNEvbuMCB9zyybUr//xaG1gqP4ACQqZAamlKK4dB9jmmtBBvfCpU+zI8FY8/6AB4xRB/CDXkf5mTKCfRSUa4JeUrGGYwnetnmkkqeL6qA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SIv2BiEm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756871861;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8FMeOQhsZ/Bz1a50krITAkDUmAVmdmpSJmIX2uvA258=;
	b=SIv2BiEmERfzQzVD5y6UBwZKoIDQYPnpuweLLsITANkPjUWrb54s4+eF78ef1wh5YfiIAg
	b/xqqyKY3AGs7mjoLxEfu+1ASEnY2d22uiOocwMTfka4uIlAk61UX2KgEaEgCvUGy0pDLN
	n10S7srf6hvQLIOdYeLbj9pTA0X3xhQ=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-103-F7_MuvrAM4KsHaNPbpwBIQ-1; Tue, 02 Sep 2025 23:57:39 -0400
X-MC-Unique: F7_MuvrAM4KsHaNPbpwBIQ-1
X-Mimecast-MFC-AGG-ID: F7_MuvrAM4KsHaNPbpwBIQ_1756871858
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-248eec89618so65163285ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 20:57:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756871858; x=1757476658;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8FMeOQhsZ/Bz1a50krITAkDUmAVmdmpSJmIX2uvA258=;
        b=nbIrDs4ArB5qF93XI92l9U4x5Dt+MygcGE8H0yyybkCQSnjH3F5ZWP576UidB6EG1m
         4IYkIEKP83mtwGnA0ak/7P51BegqfUa9TFGbAnXpbkKYEHi1wn2a5zk2GTls+E4Rv2zm
         076+Yz2TXydAS1ApPs92q0vTSC0me7wCPxQ5TqvEqFXejPneFbEfQa7uLONSIaUUv4Tk
         FeW1Z2ydshC3+pmFKmsKQyQGecaIo9W5eBeFNXGqWDhkFFEAS+knmlcYEdR4qgYDXhp9
         WRRfurIAXMt3qw+Wh4CH+P9IkzylgCl4L7TX15fMy2nh/w7kfs9Zdy8SCrVe10m3k84M
         vjYw==
X-Forwarded-Encrypted: i=1; AJvYcCXdlrm0IqgdPotezI21DJ83O0ptwQdM3cql8YdshLDpM79AuNacOgKVKIIyFZvoJlxfKveBQkaNA+16YkI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyu6Ikf7SjMs5YDqb/kFzK5cHCKgPEmiLOnZIc07XMpexViVIft
	0dbVJMHLJYii+FHMYCR8JS+gWkixkMXU5FCi3dxycDPoy9uX/+D769zEYZglXW82tY7PjY5k1cZ
	g0udb/6tAtb+wP4H4kH3WCP2GMsCiwKTW0/ZcIRehTnmYfhOVIRZUJsCHsjmvDvU8yPMT7BN7GJ
	pZr5o8fNwUsWm+ErYMW2Dq1vmMOWPIAYEuNCMjwjPj
X-Gm-Gg: ASbGnctvE6/B8/K13pGl18rKe4MiixErp4xVRJ0BP4eNCU0/6xek4D+1yur7Jgz6nl8
	e5YkCQpGJYhSqE0atu2plCXo43vixX+/k4+YI57u1HnuIZ0iwWU5xU/weopTGLA/NBaOb5FTdFY
	kGygSvbwcWg4psERCmVl7ceQ==
X-Received: by 2002:a17:903:3c45:b0:246:4eb3:9c08 with SMTP id d9443c01a7336-24944870a65mr173393675ad.5.1756871857882;
        Tue, 02 Sep 2025 20:57:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFkE3iE/jqdcUHOgbC8sPvuCPSZCKKD0K/m8LwLji6un3PH2aumk05za/muG1bJ4viYeIzj5Ff9OEL5hv3VF8o=
X-Received: by 2002:a17:903:3c45:b0:246:4eb3:9c08 with SMTP id
 d9443c01a7336-24944870a65mr173393355ad.5.1756871857260; Tue, 02 Sep 2025
 20:57:37 -0700 (PDT)
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
Date: Wed, 3 Sep 2025 11:57:26 +0800
X-Gm-Features: Ac12FXxQzUUcpGjD91I8f81-ocOtOBSKHxA1qUyDeVHyGayy8sNvtEGSiahbZ0Y
Message-ID: <CACGkMEuoH3J9HwRU_G5wsDoeP7EjYfUU-aCDRbsjmcv45OG2mw@mail.gmail.com>
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
>
> > > +
> > >         dev->status =3D status;
> > >  }
> > >
> > > @@ -789,6 +825,7 @@ static const struct vdpa_config_ops vduse_vdpa_co=
nfig_ops =3D {
> > >         .set_vq_cb              =3D vduse_vdpa_set_vq_cb,
> > >         .set_vq_num             =3D vduse_vdpa_set_vq_num,
> > >         .get_vq_size            =3D vduse_vdpa_get_vq_size,
> > > +       .get_vq_group           =3D vduse_get_vq_group,
> > >         .set_vq_ready           =3D vduse_vdpa_set_vq_ready,
> > >         .get_vq_ready           =3D vduse_vdpa_get_vq_ready,
> > >         .set_vq_state           =3D vduse_vdpa_set_vq_state,
> > > @@ -1737,12 +1774,19 @@ static bool features_is_valid(struct vduse_de=
v_config *config)
> > >         return true;
> > >  }
> > >
> > > -static bool vduse_validate_config(struct vduse_dev_config *config)
> > > +static bool vduse_validate_config(struct vduse_dev_config *config,
> > > +                                 u64 api_version)
> > >  {
> > >         if (!is_mem_zero((const char *)config->reserved,
> > >                          sizeof(config->reserved)))
> > >                 return false;
> > >
> > > +       if (api_version < VDUSE_API_VERSION_1 && config->ngroups)
> > > +               return false;
> > > +
> > > +       if (api_version >=3D VDUSE_API_VERSION_1 && config->ngroups >=
 0xffff)
> > > +               return false;
> >
> > Let's use a macro instead of magic number.
> >
>
> The rest of the limits are hardcoded, but I'm ok with changing this.
> Is UINT16_MAX ok here, or do you prefer something like MAX_NGROUPS and
> MAX_ASID?

MAX_NGROUPS and MAX_ASID seem to be better.

Thanks

>
> [...]
>
> [1] https://patchew.org/linux/20250807115752.1663383-1-eperezma@redhat.co=
m/20250807115752.1663383-3-eperezma@redhat.com/#CACGkMEuVngGjgPZXnajiPC+pcb=
t+dr6jqKRQr8OcX7HK1W3WNQ@mail.gmail.com
>


