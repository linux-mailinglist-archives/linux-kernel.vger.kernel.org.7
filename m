Return-Path: <linux-kernel+bounces-839902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 79D81BB2B0B
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 09:27:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE23019C2D62
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 07:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D1DF2C08C5;
	Thu,  2 Oct 2025 07:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UdHGpaft"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF75D33F6
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 07:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759390070; cv=none; b=RW84XeN9cbqyn2dAVc+sS+oEyePbEBi908JT/h4J1QsOHfDSa470Iqrjw1LeiYZUqHGpzlemPpXwkBZ/LpOrcKicn310hyfWd4ExKvzeRzs9qNTUimQLICjxExgK+pSkJkznUmBA4XysX52UVPrAstzQpj5eJjyYWlj+HcryPoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759390070; c=relaxed/simple;
	bh=Pe9V4pOUKY0TgpmvjfSAP8vc53Cb77GQdtv5sowAjNE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m1CT+x1RjBHnB/LGWzoiHrvotxeierDtumNYD+u5bx79LKWfvBhw5nVDPayINFQ0mqQPBk2PJNSBgS+QjB9P7mqyuThHJ+VqH7yqoOAYSLAIsU7uLvjuMRs3lGZ2gVZrdN3/Z1hlAcSQ7uMWRjHiPl2OV8vQfN6NsALjOzI296A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UdHGpaft; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759390067;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IMoT/EJOXxcCndc9sTtuH4r5q/WuvT1uP7pW4UMHvkM=;
	b=UdHGpaftHsperoRT+sMQBFlu7jrN8UHzrD6NcpaZPFLiyN1QmFQTRCng7Un5L4SJ5XFjbg
	wramT94m9mi95xJUne0B53lYJllFkUUQSP0JC1n8sRcoNc7Gwvt/tI8wUZpEKiKRW9gdTO
	P+jjTW7LwOdBuPXODCNYxwyq0y5ouQ0=
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com
 [74.125.224.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-258-AdvDs-h4MPWv_szAZDKQ6Q-1; Thu, 02 Oct 2025 03:27:46 -0400
X-MC-Unique: AdvDs-h4MPWv_szAZDKQ6Q-1
X-Mimecast-MFC-AGG-ID: AdvDs-h4MPWv_szAZDKQ6Q_1759390065
Received: by mail-yx1-f71.google.com with SMTP id 956f58d0204a3-63604a1a14aso1118468d50.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 00:27:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759390065; x=1759994865;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IMoT/EJOXxcCndc9sTtuH4r5q/WuvT1uP7pW4UMHvkM=;
        b=UD4c+RnYsTiIRBMEc0p7ctU0v2VBzssI7lgI5y+7uWtP0fuXBjBvlZNReZZ6ozsHy4
         c/b47HAhcVZxRv/c8vRFC7xebe/kCT9N3o5aHBPV+/YCxrxwVf/ra2nxcoV/dcKGh6n6
         qGPB+GImIz/LeueMcFwoS4p2zMffSn0Goxhw2aepcR9FyutnoMYEXgs2wU4ELEjtxdFp
         SFFp9SMM2R41lHf3kc+7Yl2yQoy8s4BYTgNyy17Bx6d8PK7T9Bly5y5XHGGs/1/nYyun
         pE3row1gdyKWRvbG++9iG4EjSdpMKfobe3OjIjIQpt2A2n8CpRO2fUcD4pjjPXI30gXZ
         nuIQ==
X-Forwarded-Encrypted: i=1; AJvYcCXHDv1lfUlNMbEo4pxtMswJRwW3v3a8P4aB4z/6mjdnWyr7K26ot/SIe5epJeTBKPfinYnfysIi2NeT/AU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsZKDOEyMLVLnlM19l8pjv9Upz7IdWceDYWui8CHQMxqgRgmcw
	KXzkXuH1vqJsOcsdOn8bZkbni6YGBkZhzQubIhsO3UmGbsk2h26dL0pIYXY9Dbe2JXgy1M+CV+o
	O+nLOZ9arq/sQPoJkBToAszuPAdeb2kFkp+JCgT+0h9gfWOm0tdwlfi8o4n3ATqelF6PRVdiAio
	VNdxHC8iDO5utCxmT7ql5zIGkuVL629ZEJ3diZRxFE
X-Gm-Gg: ASbGnctIPqaftIqeHVXb8mbObjnH8GVVFsd8YXSDou07HEGrfnANrTTX/WHhIYQYvAj
	ueu35XukliQOsG34i1H47H6+tyGO6leyAmo3UDNXiFcDo6ctx37wRyx490bkHC3VZLQAxSLg2Cb
	ayAHNPjA+03kpInY/+xEQWR7n30r8Br48KRkaslY4hbRnRgugHT9ok0upRKbXC4ujkHupkBIGm2
	r7PO9XOEkdS0Q==
X-Received: by 2002:a53:b6c6:0:b0:634:7613:25a4 with SMTP id 956f58d0204a3-63b6ff0af71mr6830746d50.14.1759390065169;
        Thu, 02 Oct 2025 00:27:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF8+sedmtxTreESow8ld4vIqcdjpkPuG0lafu4PLKnMyWgezKmRryEvxJjmsNUqH9uSvqw1y3W8d+yaQlNzSno=
X-Received: by 2002:a53:b6c6:0:b0:634:7613:25a4 with SMTP id
 956f58d0204a3-63b6ff0af71mr6830723d50.14.1759390064543; Thu, 02 Oct 2025
 00:27:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1675725124-7375-1-git-send-email-si-wei.liu@oracle.com>
 <1675725124-7375-5-git-send-email-si-wei.liu@oracle.com> <CAJaqyWdEZbURGZtmobrED_jBq34DnQEuC8kUoPMH5=p2K7NE0w@mail.gmail.com>
 <f5897b60-8e4f-4a3c-a88d-f85be0bc7705@oracle.com>
In-Reply-To: <f5897b60-8e4f-4a3c-a88d-f85be0bc7705@oracle.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Thu, 2 Oct 2025 09:27:08 +0200
X-Gm-Features: AS18NWAkYZhuEt1p0u2fDdrsIqY5nDF2gtaoeWtZRs3qDM6cUMLedr6j1FLwjb8
Message-ID: <CAJaqyWd2sRSMeR294sQGxyEFg3dPbd5AgUmG+C85oCCZXqCEBQ@mail.gmail.com>
Subject: Re: [PATCH RESENT v4 4/6] vdpa: validate device feature provisioning
 against supported class
To: Si-Wei Liu <si-wei.liu@oracle.com>
Cc: mst@redhat.com, jasowang@redhat.com, parav@nvidia.com, 
	virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, 
	Dragos Tatulea DE <dtatulea@nvidia.com>, Maxime Coquelin <mcoqueli@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 2, 2025 at 1:27=E2=80=AFAM Si-Wei Liu <si-wei.liu@oracle.com> w=
rote:
>
> Hi Eugenio,
>
> On 10/1/2025 6:26 AM, Eugenio Perez Martin wrote:
> > On Tue, Feb 7, 2023 at 12:15=E2=80=AFAM Si-Wei Liu <si-wei.liu@oracle.c=
om> wrote:
> >> Today when device features are explicitly provisioned, the features
> >> user supplied may contain device class specific features that are
> >> not supported by the parent management device. On the other hand,
> >> when parent management device supports more than one class, the
> >> device features to provision may be ambiguous if none of the class
> >> specific attributes is provided at the same time. Validate these
> >> cases and prompt appropriate user errors accordingly.
> >>
> >> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
> >> ---
> >>   drivers/vdpa/vdpa.c | 59 +++++++++++++++++++++++++++++++++++++++++++=
++--------
> >>   1 file changed, 50 insertions(+), 9 deletions(-)
> >>
> >> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> >> index 1eba978..8da5120 100644
> >> --- a/drivers/vdpa/vdpa.c
> >> +++ b/drivers/vdpa/vdpa.c
> >> @@ -460,12 +460,28 @@ static int vdpa_nl_mgmtdev_handle_fill(struct sk=
_buff *msg, const struct vdpa_mg
> >>          return 0;
> >>   }
> >>
> >> +static u64 vdpa_mgmtdev_get_classes(const struct vdpa_mgmt_dev *mdev,
> >> +                                   unsigned int *nclasses)
> >> +{
> >> +       u64 supported_classes =3D 0;
> >> +       unsigned int n =3D 0;
> >> +
> >> +       for (int i =3D 0; mdev->id_table[i].device; i++) {
> >> +               if (mdev->id_table[i].device > 63)
> >> +                       continue;
> >> +               supported_classes |=3D BIT_ULL(mdev->id_table[i].devic=
e);
> >> +               n++;
> >> +       }
> >> +       if (nclasses)
> >> +               *nclasses =3D n;
> >> +
> >> +       return supported_classes;
> >> +}
> >> +
> >>   static int vdpa_mgmtdev_fill(const struct vdpa_mgmt_dev *mdev, struc=
t sk_buff *msg,
> >>                               u32 portid, u32 seq, int flags)
> >>   {
> >> -       u64 supported_classes =3D 0;
> >>          void *hdr;
> >> -       int i =3D 0;
> >>          int err;
> >>
> >>          hdr =3D genlmsg_put(msg, portid, seq, &vdpa_nl_family, flags,=
 VDPA_CMD_MGMTDEV_NEW);
> >> @@ -475,14 +491,9 @@ static int vdpa_mgmtdev_fill(const struct vdpa_mg=
mt_dev *mdev, struct sk_buff *m
> >>          if (err)
> >>                  goto msg_err;
> >>
> >> -       while (mdev->id_table[i].device) {
> >> -               if (mdev->id_table[i].device <=3D 63)
> >> -                       supported_classes |=3D BIT_ULL(mdev->id_table[=
i].device);
> >> -               i++;
> >> -       }
> >> -
> >>          if (nla_put_u64_64bit(msg, VDPA_ATTR_MGMTDEV_SUPPORTED_CLASSE=
S,
> >> -                             supported_classes, VDPA_ATTR_UNSPEC)) {
> >> +                             vdpa_mgmtdev_get_classes(mdev, NULL),
> >> +                             VDPA_ATTR_UNSPEC)) {
> >>                  err =3D -EMSGSIZE;
> >>                  goto msg_err;
> >>          }
> >> @@ -566,13 +577,25 @@ static int vdpa_nl_cmd_mgmtdev_get_doit(struct s=
k_buff *skb, struct genl_info *i
> >>                                   BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MTU)  =
   | \
> >>                                   BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MAX_VQ=
P))
> >>
> >> +/*
> >> + * Bitmask for all per-device features: feature bits VIRTIO_TRANSPORT=
_F_START
> >> + * through VIRTIO_TRANSPORT_F_END are unset, i.e. 0xfffffc000fffffff =
for
> >> + * all 64bit features. If the features are extended beyond 64 bits, o=
r new
> >> + * "holes" are reserved for other type of features than per-device, t=
his
> >> + * macro would have to be updated.
> >> + */
> >> +#define VIRTIO_DEVICE_F_MASK (~0ULL << (VIRTIO_TRANSPORT_F_END + 1) |=
 \
> >> +                             ((1ULL << VIRTIO_TRANSPORT_F_START) - 1)=
)
> >> +
> >>   static int vdpa_nl_cmd_dev_add_set_doit(struct sk_buff *skb, struct =
genl_info *info)
> >>   {
> >>          struct vdpa_dev_set_config config =3D {};
> >>          struct nlattr **nl_attrs =3D info->attrs;
> >>          struct vdpa_mgmt_dev *mdev;
> >> +       unsigned int ncls =3D 0;
> >>          const u8 *macaddr;
> >>          const char *name;
> >> +       u64 classes;
> >>          int err =3D 0;
> >>
> >>          if (!info->attrs[VDPA_ATTR_DEV_NAME])
> >> @@ -649,6 +672,24 @@ static int vdpa_nl_cmd_dev_add_set_doit(struct sk=
_buff *skb, struct genl_info *i
> >>                  goto err;
> >>          }
> >>
> >> +       classes =3D vdpa_mgmtdev_get_classes(mdev, &ncls);
> >> +       if (config.mask & VDPA_DEV_NET_ATTRS_MASK &&
> >> +           !(classes & BIT_ULL(VIRTIO_ID_NET))) {
> >> +               NL_SET_ERR_MSG_MOD(info->extack,
> >> +                                  "Network class attributes provided =
on unsupported management device");
> >> +               err =3D -EINVAL;
> >> +               goto err;
> >> +       }
> >> +       if (!(config.mask & VDPA_DEV_NET_ATTRS_MASK) &&
> >> +           config.mask & BIT_ULL(VDPA_ATTR_DEV_FEATURES) &&
> >> +           classes & BIT_ULL(VIRTIO_ID_NET) && ncls > 1 &&
> >> +           config.device_features & VIRTIO_DEVICE_F_MASK) {
> >> +               NL_SET_ERR_MSG_MOD(info->extack,
> >> +                                  "Management device supports multi-c=
lass while device features specified are ambiguous");
> >> +               err =3D -EINVAL;
> >> +               goto err;
> >> +       }
> >
> > Hi! I need to question this last if() :). What's the point of error
> > when we specify features device-specific, from net or blk?
> Because device specific features belong to different feature space, for
> instance, VIRTIO_BLK_F_SIZE_MAX (1) on block device and
> VIRTIO_NET_F_GUEST_CSUM (1) on network device both use same feature bit
> value of (1<<1)ULL, but they belong to different type of devices.
>
> >
> > In the VDUSE case both blk and net are supported. I want to use
> > device_features to limit the net features that the VDUSE device
> > exports.
> Then we have to extend to the vdpa CLI to add "class ..." attribute to
> explicitly indicate which type of device the creation has to be, so
> eliminate the ambiguity entirely.
>
> >
> > Also, why is this limited to only net devices?
> Actually, this is not limited to only net I think, we can even remove the
>
> classes & BIT_ULL(VIRTIO_ID_NET)
>
> conditional if mgmtdev and vdpa dev instance is 1:1 bound. But at the
> point when this code was written, it's not clear to me how multi-class
> can be supported - such that does it limit to one vdpa instance
> supporting one single class 1:1, or it is even possible to support both
> or multiple classes (multi-facets) per vdpa instance i.e. 1:N.
>
> >   does this part:
> >
> > classes & BIT_ULL(VIRTIO_ID_NET) && ncls > 1
> >
> > Means that it is ok to specify more than one class as long as the set
> > does not contain net?
> Exactly, that's why it is coded in that odd way. For instance, if a
> multi-facet vdpa instance needs to be provisioned with respective
> feature bits for both block and iSCSI device types at the same time, we
> may have to extend the CLI usage to support that.
>

Right I get the algorithm, but I still don't get what this is trying
to solve :).

Let me give some examples: I've got a mgmt device that supports blk
and net. Now two operators want to create one vdpa device of each
kind.

Let's say it is VDUSE. The userland device is able to set its own
name, and their creation is atomic, so there is no way to set the
features to the wrong one. Let's say one VDUSE device is called
vduse_net0 and the other one is vduse_blk0, so we can tell which one
is which with "vdpa dev add name vduse_net0 device_features ...". We
cannot set the device features to the wrong one.

In the case of mlx the mgmtdev is already a net device, so we cannot
create two different devices of a different kind. We could provide a
different feature set depending on who is creating the device if we
don't want live migration, and that's possible with the current code
as long as we can tell them apart by the name.

Other devices already have more ids than NET, but not standard VIRTIO.
Others could have only one ID, being that VIRTIO_DEV_ANY_ID, and I
think that would pass the test and allow you to set device_features.
Then we have vp_vdpa, which blindly passes the one single device id of
the PCI device and I think it would allow to set device_features. All
of these are hypothetical as they don't offer the
VDPA_ATTR_DEV_FEATURES to the vdpa core, but I think they should be
able to do it.

So I'm not sure if that ambiguity is just solved otherwise? If not,
could we move that to the specific backend?

Thanks!


