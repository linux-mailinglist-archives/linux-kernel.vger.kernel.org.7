Return-Path: <linux-kernel+bounces-793676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 80CC8B3D6AF
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 04:32:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3BF41895468
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 02:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5046157493;
	Mon,  1 Sep 2025 02:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ejC6nLfl"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE3FB17BA3
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 02:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756693915; cv=none; b=QNkVXbm7ZZ0jQ+gJeRDElHK0iN88X4rSh6PR7vaXpA2Q50iJID3CBYnDlLDNtr+aDDRphvf15CfPb1swf15s+dGQFBlyLo/OzpInQP5pePGTsTFMWE/5SfH1hi1WF0+Sd/nxLg7tKA599Sl+Ha/pmHdMja6XiH55E2/znsHcWmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756693915; c=relaxed/simple;
	bh=siORwdMayUtw4qc5Kckui3izgWW+KqDC/hqt0/gGlSE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s6ET2ys4/c6tsvl3jE4xwB5h6bSyMZekNJkWMxk7DL8Kk+ysSJDz6wRL7WqGu1cc0ODBngSRaVKDr4YexGDg9HqZ9BS7LZ5mAY0XmolJmBtQYWcLwPdLC825xjIzfukKUzGaXHqmsMojFk+9AMex9OCpc01sLi3hroyXK8pnXno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ejC6nLfl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756693913;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7v4jfKPcBEynUWEFS5XS2jfe0dwO+QCrgAQuf8pEiJU=;
	b=ejC6nLflt723G5zbbZE24Jp6tfYJXMPcyBE9ZVGuIBki1JnVerY6gT9JmSCRcwnb9KYU0F
	ZUf8ce8URbQ7GBABp8o2fNlCk+5dhfBkbaDQEx3J2hRDSIycOgNQ3JVBXl+PZkc5Q9TtEI
	RZNMa1Kqpb5ZXJFbNLY3piiuqpsyBRo=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-91-cu79i27rNw-F52-2R0quzw-1; Sun, 31 Aug 2025 22:31:51 -0400
X-MC-Unique: cu79i27rNw-F52-2R0quzw-1
X-Mimecast-MFC-AGG-ID: cu79i27rNw-F52-2R0quzw_1756693910
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-24aa3cf81a8so12090085ad.2
        for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 19:31:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756693910; x=1757298710;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7v4jfKPcBEynUWEFS5XS2jfe0dwO+QCrgAQuf8pEiJU=;
        b=tIo3VkpcbTJQAsv6xoCzKzRmJV8KP84717cT5nJHdPLNzm3vrYArpuBi5gWep2+695
         kIJkhE/OLuP9R8rTN2VcHIvUvvtOvK1Q7RG2Z6JPcTm0WEsDoz1A/Jx7pHQm/5NmThH6
         S6PSlIfCMqfBW7LTpTqCbnKSW+IApxDefI8ESr9sx3h1orqGVlC9DpwpPpEYpF0wAG3v
         4gmCTpN0ATN8oUQ9s/bPdBw2e4dqtT90y9MwNDjX2HgklFXxextDzqgcMx5VQuB4VGeE
         stXCLx6bLIAf8liuk3jUDIQqmY94F7FZUvvGO69wbzR8fG9WArp0OSJ52SKHzJtY/rrf
         /4kQ==
X-Forwarded-Encrypted: i=1; AJvYcCXIA2JfMCRm6aDNKMQhCJgebzaUIfwqMmgw4Hd1sLVTC/qNKSXuHeKtr74mxwFYV5vs2rUHkr3PV9CngqQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9i4itFInBs/Fw4E+9fBrWpe+WA30An67KH6wp8L4WLIWAH8an
	eGSPpuInBuNy01/NlMhshexDiU84r2IsWVLbpBN2dJlsZEZaGZ3t4aZsM0mYsEPvd9OLI+3vRX+
	GRL0TL4LQPItOmQQGOL+KvZjfUs6ULcPZWwigLcqAFuIKBtWaLOojS/KqSMsUVjmlt2qluB8Rg7
	B3E/uYvqoDGl1LckO9g6HAVxUpGopi7EHJ2Jty04+G
X-Gm-Gg: ASbGncsbkh66iVtT9eOQ1fcYe4nromn/bfVoAPlXxSI33ttTtXrU1hHWSJKGnOTkFYN
	rHUnlkfOkjrAfP5sjaMUpvPW9JQa9GT/J7R8gt1FRIRN5oSs6KIo2EWR15nv5gSEScUafbwT9UM
	dpNcHFF9fyzXMTadBGoC3B3w==
X-Received: by 2002:a17:902:e751:b0:246:b467:eea9 with SMTP id d9443c01a7336-249448f7469mr82210415ad.21.1756693910154;
        Sun, 31 Aug 2025 19:31:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFy/1HgQ1ByCI84ssI7B6m6fyh0l47ooVje3fuTJLIeZnt/DfOO9DlqV7NJcUN8/8KANq8thIA3Tbs9RO3MHDs=
X-Received: by 2002:a17:902:e751:b0:246:b467:eea9 with SMTP id
 d9443c01a7336-249448f7469mr82210135ad.21.1756693909538; Sun, 31 Aug 2025
 19:31:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250826112709.1051172-1-eperezma@redhat.com> <20250826112709.1051172-3-eperezma@redhat.com>
 <CACGkMEvd9w_ijpf=+re8oUxUWfq6Q_0HaDM==_e65df3439k7w@mail.gmail.com>
In-Reply-To: <CACGkMEvd9w_ijpf=+re8oUxUWfq6Q_0HaDM==_e65df3439k7w@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 1 Sep 2025 10:31:38 +0800
X-Gm-Features: Ac12FXxzKO4mimnV_4Q8oNuys-OcPJJIJIw8m0w62YCSwShH75yVJpUZMoIsVBI
Message-ID: <CACGkMEtQ7byU0+4EjvwEkHC8FLQ=vb9=k8Z=7mKvvc+MhEGLug@mail.gmail.com>
Subject: Re: [PATCH 2/6] vduse: add vq group support
To: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Cindy Lu <lulu@redhat.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Laurent Vivier <lvivier@redhat.com>, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Yongji Xie <xieyongji@bytedance.com>, 
	Maxime Coquelin <mcoqueli@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 1, 2025 at 9:59=E2=80=AFAM Jason Wang <jasowang@redhat.com> wro=
te:
>
> On Tue, Aug 26, 2025 at 7:27=E2=80=AFPM Eugenio P=C3=A9rez <eperezma@redh=
at.com> wrote:
> >
> > This allows sepparate the different virtqueues in groups that shares th=
e
> > same address space.  Asking the VDUSE device for the groups of the vq a=
t
> > the beginning as they're needed for the DMA API.
> >
> > Allocating 3 vq groups as net is the device that need the most groups:
> > * Dataplane (guest passthrough)
> > * CVQ
> > * Shadowed vrings.
> >
> > Future versions of the series can include dynamic allocation of the
> > groups array so VDUSE can declare more groups.
> >
> > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > ---
> > v1: Fix: Remove BIT_ULL(VIRTIO_S_*), as _S_ is already the bit (Maxime)
> >
> > RFC v3:
> > * Increase VDUSE_MAX_VQ_GROUPS to 0xffff (Jason). It was set to a lower
> >   value to reduce memory consumption, but vqs are already limited to
> >   that value and userspace VDUSE is able to allocate that many vqs.
> > * Remove the descs vq group capability as it will not be used and we ca=
n
> >   add it on top.
> > * Do not ask for vq groups in number of vq groups < 2.
> > * Move the valid vq groups range check to vduse_validate_config.
> >
> > RFC v2:
> > * Cache group information in kernel, as we need to provide the vq map
> >   tokens properly.
> > * Add descs vq group to optimize SVQ forwarding and support indirect
> >   descriptors out of the box.
> > ---
> >  drivers/vdpa/vdpa_user/vduse_dev.c | 51 ++++++++++++++++++++++++++++--
> >  include/uapi/linux/vduse.h         | 21 +++++++++++-
> >  2 files changed, 68 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_use=
r/vduse_dev.c
> > index e7bced0b5542..0f4e36dd167e 100644
> > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > @@ -58,6 +58,7 @@ struct vduse_virtqueue {
> >         struct vdpa_vq_state state;
> >         bool ready;
> >         bool kicked;
> > +       u32 vq_group;
> >         spinlock_t kick_lock;
> >         spinlock_t irq_lock;
> >         struct eventfd_ctx *kickfd;
> > @@ -114,6 +115,7 @@ struct vduse_dev {
> >         u8 status;
> >         u32 vq_num;
> >         u32 vq_align;
> > +       u32 ngroups;
> >         struct vduse_umem *umem;
> >         struct mutex mem_lock;
> >         unsigned int bounce_size;
> > @@ -592,6 +594,13 @@ static int vduse_vdpa_set_vq_state(struct vdpa_dev=
ice *vdpa, u16 idx,
> >         return 0;
> >  }
> >
> > +static u32 vduse_get_vq_group(struct vdpa_device *vdpa, u16 idx)
> > +{
> > +       struct vduse_dev *dev =3D vdpa_to_vduse(vdpa);
> > +
> > +       return dev->vqs[idx]->vq_group;
> > +}
> > +
> >  static int vduse_vdpa_get_vq_state(struct vdpa_device *vdpa, u16 idx,
> >                                 struct vdpa_vq_state *state)
> >  {
> > @@ -678,6 +687,28 @@ static u8 vduse_vdpa_get_status(struct vdpa_device=
 *vdpa)
> >         return dev->status;
> >  }
> >
> > +static int vduse_fill_vq_groups(struct vduse_dev *dev)
> > +{
> > +       /* All vqs and descs must be in vq group 0 if ngroups < 2 */
> > +       if (dev->ngroups < 2)
> > +               return 0;
> > +
> > +       for (int i =3D 0; i < dev->vdev->vdpa.nvqs; ++i) {
> > +               struct vduse_dev_msg msg =3D { 0 };
> > +               int ret;
> > +
> > +               msg.req.type =3D VDUSE_GET_VQ_GROUP;
> > +               msg.req.vq_group.index =3D i;
> > +               ret =3D vduse_dev_msg_sync(dev, &msg);
> > +               if (ret)
> > +                       return ret;
> > +
> > +               dev->vqs[i]->vq_group =3D msg.resp.vq_group.group;
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> >  static void vduse_vdpa_set_status(struct vdpa_device *vdpa, u8 status)
> >  {
> >         struct vduse_dev *dev =3D vdpa_to_vduse(vdpa);
> > @@ -685,6 +716,11 @@ static void vduse_vdpa_set_status(struct vdpa_devi=
ce *vdpa, u8 status)
> >         if (vduse_dev_set_status(dev, status))
> >                 return;
> >
> > +       if (((dev->status ^ status) & VIRTIO_CONFIG_S_FEATURES_OK) &&
> > +           (status & VIRTIO_CONFIG_S_FEATURES_OK))
> > +               if (vduse_fill_vq_groups(dev))
> > +                       return;
>
> I may lose some context but I think we've agreed that we need to
> extend the status response for this instead of having multiple
> indepdent response.

Btw, I wonder why don't we get the vq group per .get_vq_group()

Thanks

>
> > +
> >         dev->status =3D status;
> >  }
> >
> > @@ -789,6 +825,7 @@ static const struct vdpa_config_ops vduse_vdpa_conf=
ig_ops =3D {
> >         .set_vq_cb              =3D vduse_vdpa_set_vq_cb,
> >         .set_vq_num             =3D vduse_vdpa_set_vq_num,
> >         .get_vq_size            =3D vduse_vdpa_get_vq_size,
> > +       .get_vq_group           =3D vduse_get_vq_group,
> >         .set_vq_ready           =3D vduse_vdpa_set_vq_ready,
> >         .get_vq_ready           =3D vduse_vdpa_get_vq_ready,
> >         .set_vq_state           =3D vduse_vdpa_set_vq_state,
> > @@ -1737,12 +1774,19 @@ static bool features_is_valid(struct vduse_dev_=
config *config)
> >         return true;
> >  }
> >
> > -static bool vduse_validate_config(struct vduse_dev_config *config)
> > +static bool vduse_validate_config(struct vduse_dev_config *config,
> > +                                 u64 api_version)
> >  {
> >         if (!is_mem_zero((const char *)config->reserved,
> >                          sizeof(config->reserved)))
> >                 return false;
> >
> > +       if (api_version < VDUSE_API_VERSION_1 && config->ngroups)
> > +               return false;
> > +
> > +       if (api_version >=3D VDUSE_API_VERSION_1 && config->ngroups > 0=
xffff)
> > +               return false;
>
> Let's use a macro instead of magic number.
>
> > +
> >         if (config->vq_align > PAGE_SIZE)
> >                 return false;
> >
> > @@ -1858,6 +1902,7 @@ static int vduse_create_dev(struct vduse_dev_conf=
ig *config,
> >         dev->device_features =3D config->features;
> >         dev->device_id =3D config->device_id;
> >         dev->vendor_id =3D config->vendor_id;
> > +       dev->ngroups =3D (dev->api_version < 1) ? 1 : (config->ngroups =
?: 1);
> >         dev->name =3D kstrdup(config->name, GFP_KERNEL);
> >         if (!dev->name)
> >                 goto err_str;
> > @@ -1936,7 +1981,7 @@ static long vduse_ioctl(struct file *file, unsign=
ed int cmd,
> >                         break;
> >
> >                 ret =3D -EINVAL;
> > -               if (vduse_validate_config(&config) =3D=3D false)
> > +               if (!vduse_validate_config(&config, control->api_versio=
n))
> >                         break;
> >
> >                 buf =3D vmemdup_user(argp + size, config.config_size);
> > @@ -2017,7 +2062,7 @@ static int vduse_dev_init_vdpa(struct vduse_dev *=
dev, const char *name)
> >
> >         vdev =3D vdpa_alloc_device(struct vduse_vdpa, vdpa, dev->dev,
> >                                  &vduse_vdpa_config_ops, &vduse_map_ops=
,
> > -                                1, 1, name, true);
> > +                                dev->ngroups, 1, name, true);
> >         if (IS_ERR(vdev))
> >                 return PTR_ERR(vdev);
> >
> > diff --git a/include/uapi/linux/vduse.h b/include/uapi/linux/vduse.h
> > index 9a56d0416bfe..b1c0e47d71fb 100644
> > --- a/include/uapi/linux/vduse.h
> > +++ b/include/uapi/linux/vduse.h
> > @@ -31,6 +31,7 @@
> >   * @features: virtio features
> >   * @vq_num: the number of virtqueues
> >   * @vq_align: the allocation alignment of virtqueue's metadata
> > + * @ngroups: number of vq groups that VDUSE device declares
> >   * @reserved: for future use, needs to be initialized to zero
> >   * @config_size: the size of the configuration space
> >   * @config: the buffer of the configuration space
> > @@ -45,7 +46,8 @@ struct vduse_dev_config {
> >         __u64 features;
> >         __u32 vq_num;
> >         __u32 vq_align;
> > -       __u32 reserved[13];
> > +       __u32 ngroups; /* if VDUSE_API_VERSION >=3D 1 */
> > +       __u32 reserved[12];
> >         __u32 config_size;
> >         __u8 config[];
> >  };
> > @@ -160,6 +162,16 @@ struct vduse_vq_state_packed {
> >         __u16 last_used_idx;
> >  };
> >
> > +/**
> > + * struct vduse_vq_group - virtqueue group
> > + * @index: Index of the virtqueue
> > + * @group: Virtqueue group
> > + */
> > +struct vduse_vq_group {
> > +       __u32 index;
> > +       __u32 group;
> > +};
> > +
> >  /**
> >   * struct vduse_vq_info - information of a virtqueue
> >   * @index: virtqueue index
> > @@ -274,6 +286,7 @@ enum vduse_req_type {
> >         VDUSE_GET_VQ_STATE,
> >         VDUSE_SET_STATUS,
> >         VDUSE_UPDATE_IOTLB,
> > +       VDUSE_GET_VQ_GROUP,
> >  };
> >
> >  /**
> > @@ -316,6 +329,7 @@ struct vduse_iova_range {
> >   * @vq_state: virtqueue state, only index field is available
> >   * @s: device status
> >   * @iova: IOVA range for updating
> > + * @vq_group: virtqueue group of a virtqueue
> >   * @padding: padding
> >   *
> >   * Structure used by read(2) on /dev/vduse/$NAME.
> > @@ -328,6 +342,8 @@ struct vduse_dev_request {
> >                 struct vduse_vq_state vq_state;
> >                 struct vduse_dev_status s;
> >                 struct vduse_iova_range iova;
> > +               /* Only if vduse api version >=3D 1 */;
> > +               struct vduse_vq_group vq_group;
> >                 __u32 padding[32];
> >         };
> >  };
> > @@ -338,6 +354,7 @@ struct vduse_dev_request {
> >   * @result: the result of request
> >   * @reserved: for future use, needs to be initialized to zero
> >   * @vq_state: virtqueue state
> > + * @vq_group: virtqueue group of a virtqueue
> >   * @padding: padding
> >   *
> >   * Structure used by write(2) on /dev/vduse/$NAME.
> > @@ -350,6 +367,8 @@ struct vduse_dev_response {
> >         __u32 reserved[4];
> >         union {
> >                 struct vduse_vq_state vq_state;
> > +               /* Only if vduse api version >=3D 1 */
> > +               struct vduse_vq_group vq_group;
> >                 __u32 padding[32];
> >         };
> >  };
> > --
> > 2.51.0
> >
>
> Thanks


