Return-Path: <linux-kernel+bounces-838958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C0FEBB0807
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 15:27:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 742972A487E
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 13:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E98792ED844;
	Wed,  1 Oct 2025 13:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f0LfnNq6"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 396321DA62E
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 13:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759325215; cv=none; b=XsC+aZdeCYAJR1vY3NKFhaSYVLiTLwFudrPTEpc4AF9bQJ+kq54vEcLD6si9PWVNkTNPEgC+GvaO2xRppD+P+OGhzfNUu2Nuvxs0cOjTgd2UcBCJY8Gw7lIg/4HlmSXgVgjUFwNZTdZtEUXuFOEzCpQm2cK3wgFyZqNfid+EBXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759325215; c=relaxed/simple;
	bh=LRAABFgju+Gmfg2mIZ1aoTIFvUWnxmu7159ky6Bh6ZM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NeMx9AsJPhT4qMLrz/QyN0nc+4pUn3OzEuuKI/0EngxAZZ6nGWsQMhCBQTfLBPFFtJurQ5sbSzQZWBu+gWRXgDg3d/FJxgrBYDSVgZfDcL80OgUfquT0DvDWJIFBnmQwW5XixQ9ACJqZEyQ8gcrrb50WvyztFZ7phnsDReJLmSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f0LfnNq6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759325212;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hAGW8ES38PbYiupm2nBaulPze8EVKivbblcAWTv+vpY=;
	b=f0LfnNq6jlPFNq7adXcI7EoQj0beaTp64+Rc5kuW6OhboO5w33MHJ+GXTHPk0u0MFntK1Y
	v+3IeSsExJqA/otvVyWMyREd506NETRfShwVxLrNan7JQxVhE8S1Ww08aOKnYKBXJM/xfF
	Nb2wBulk/K+pPhRNLg4B+jIFfOniQ6w=
Received: from mail-yx1-f69.google.com (mail-yx1-f69.google.com
 [74.125.224.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-Mly6KkKHN2mW4AmsO0JkZw-1; Wed, 01 Oct 2025 09:26:51 -0400
X-MC-Unique: Mly6KkKHN2mW4AmsO0JkZw-1
X-Mimecast-MFC-AGG-ID: Mly6KkKHN2mW4AmsO0JkZw_1759325210
Received: by mail-yx1-f69.google.com with SMTP id 956f58d0204a3-63b781aecedso762519d50.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 06:26:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759325210; x=1759930010;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hAGW8ES38PbYiupm2nBaulPze8EVKivbblcAWTv+vpY=;
        b=oZwZwhNdCZCOTDvHzL4yh1culCWfy9LfqiZHPWKl3y3tlbtfI9C28RDs0mj1i8GiZF
         M6x0O0XqakijXnCDKfghEsA1cT6aTuCACiqKn2nTKOkolHwtWLnS7HJdadwZuyAGQYa3
         FMYCgUcl9WTT55uNk2QVL2AtCU0P4pRKsLL+vfd8f/wypPcKNTq+OYMZRIe7DTgjGNoS
         V0JUZvwwXH+sCc80IL3JUfN4Jx6JDeLUERH/DRZRdy8F8HRbWDMlQI6R/gbshQ7cT13Z
         vT5/nR3vRvrTKT7Z8vMM56uTAMuj74t8lv6l52aR/YHnUdbGntANdcPUXFeC+clTlaWC
         8taw==
X-Forwarded-Encrypted: i=1; AJvYcCWMc+LjE+wAI5NigP/lZvaxt9vLlGZ/wkZmtMIUoxf1eN43jjiq8/hzr6MssbWSmBq0AcmYT6XiAX4+Z04=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhVRjuUjtyq1mifnXDyhDmDUdh9yCDYqQ4GcntWUej66wI3enF
	ydGqQdEPZyD8PXhekkWP7xiY/pChM2jVWnze0ym5xgkvcTJ90kY/Fkc+JQSU7EVsAkqNAb3hq0n
	rOZm7Jz2+x3Pd82HhoGkpU8dPAt3lGAx0avgqP+K/dPiwCPZjBzqXkR5Xk7tygC04hH1L/On/Tk
	UopNJBbygP3xKjXWgauXuxZQLf+6021f6lTV+torEV
X-Gm-Gg: ASbGnctIpyOkbE7+GxaGTi6bxDxIlzagIEISfUMCAUUhT9RiLYNJknMgUchDs6nH5/1
	hBpIC1CP0dJ4WudZd58UjmZq5uSdIx2BRW0ITdEJtc6sIL3Pl2Y2wFyLRr5ZobIM3W99tmAFvht
	jezojYMgI82jcOyEXGSr59vUwUxLXXV83uNiqyf17UkgQSBJC333NgdyFZNbtSFOyac7Gsos9p7
	F/fLcVgsuKfbQ==
X-Received: by 2002:a05:690e:6c9:b0:632:5ba8:1bb5 with SMTP id 956f58d0204a3-63b6feb4b67mr4100193d50.21.1759325210541;
        Wed, 01 Oct 2025 06:26:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEjTH4h+j2839M7DNr9+hAJ3uUMbZ1V4wuh3pcYeTCYK0fJoA5+HVVG3RIGqkpS2Pxx1r5NCBQgCQ1kpF78m/o=
X-Received: by 2002:a05:690e:6c9:b0:632:5ba8:1bb5 with SMTP id
 956f58d0204a3-63b6feb4b67mr4100160d50.21.1759325210126; Wed, 01 Oct 2025
 06:26:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1675725124-7375-1-git-send-email-si-wei.liu@oracle.com> <1675725124-7375-5-git-send-email-si-wei.liu@oracle.com>
In-Reply-To: <1675725124-7375-5-git-send-email-si-wei.liu@oracle.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 1 Oct 2025 15:26:13 +0200
X-Gm-Features: AS18NWD7c8XCB1fbsTkpnchn6hG3Qu77blglfP_z2PBQTYo6EuZC3om7_PG_A7g
Message-ID: <CAJaqyWdEZbURGZtmobrED_jBq34DnQEuC8kUoPMH5=p2K7NE0w@mail.gmail.com>
Subject: Re: [PATCH RESENT v4 4/6] vdpa: validate device feature provisioning
 against supported class
To: Si-Wei Liu <si-wei.liu@oracle.com>
Cc: mst@redhat.com, jasowang@redhat.com, parav@nvidia.com, 
	virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, 
	Dragos Tatulea DE <dtatulea@nvidia.com>, Maxime Coquelin <mcoqueli@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 7, 2023 at 12:15=E2=80=AFAM Si-Wei Liu <si-wei.liu@oracle.com> =
wrote:
>
> Today when device features are explicitly provisioned, the features
> user supplied may contain device class specific features that are
> not supported by the parent management device. On the other hand,
> when parent management device supports more than one class, the
> device features to provision may be ambiguous if none of the class
> specific attributes is provided at the same time. Validate these
> cases and prompt appropriate user errors accordingly.
>
> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
> ---
>  drivers/vdpa/vdpa.c | 59 +++++++++++++++++++++++++++++++++++++++++++++--=
------
>  1 file changed, 50 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> index 1eba978..8da5120 100644
> --- a/drivers/vdpa/vdpa.c
> +++ b/drivers/vdpa/vdpa.c
> @@ -460,12 +460,28 @@ static int vdpa_nl_mgmtdev_handle_fill(struct sk_bu=
ff *msg, const struct vdpa_mg
>         return 0;
>  }
>
> +static u64 vdpa_mgmtdev_get_classes(const struct vdpa_mgmt_dev *mdev,
> +                                   unsigned int *nclasses)
> +{
> +       u64 supported_classes =3D 0;
> +       unsigned int n =3D 0;
> +
> +       for (int i =3D 0; mdev->id_table[i].device; i++) {
> +               if (mdev->id_table[i].device > 63)
> +                       continue;
> +               supported_classes |=3D BIT_ULL(mdev->id_table[i].device);
> +               n++;
> +       }
> +       if (nclasses)
> +               *nclasses =3D n;
> +
> +       return supported_classes;
> +}
> +
>  static int vdpa_mgmtdev_fill(const struct vdpa_mgmt_dev *mdev, struct sk=
_buff *msg,
>                              u32 portid, u32 seq, int flags)
>  {
> -       u64 supported_classes =3D 0;
>         void *hdr;
> -       int i =3D 0;
>         int err;
>
>         hdr =3D genlmsg_put(msg, portid, seq, &vdpa_nl_family, flags, VDP=
A_CMD_MGMTDEV_NEW);
> @@ -475,14 +491,9 @@ static int vdpa_mgmtdev_fill(const struct vdpa_mgmt_=
dev *mdev, struct sk_buff *m
>         if (err)
>                 goto msg_err;
>
> -       while (mdev->id_table[i].device) {
> -               if (mdev->id_table[i].device <=3D 63)
> -                       supported_classes |=3D BIT_ULL(mdev->id_table[i].=
device);
> -               i++;
> -       }
> -
>         if (nla_put_u64_64bit(msg, VDPA_ATTR_MGMTDEV_SUPPORTED_CLASSES,
> -                             supported_classes, VDPA_ATTR_UNSPEC)) {
> +                             vdpa_mgmtdev_get_classes(mdev, NULL),
> +                             VDPA_ATTR_UNSPEC)) {
>                 err =3D -EMSGSIZE;
>                 goto msg_err;
>         }
> @@ -566,13 +577,25 @@ static int vdpa_nl_cmd_mgmtdev_get_doit(struct sk_b=
uff *skb, struct genl_info *i
>                                  BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MTU)     |=
 \
>                                  BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MAX_VQP))
>
> +/*
> + * Bitmask for all per-device features: feature bits VIRTIO_TRANSPORT_F_=
START
> + * through VIRTIO_TRANSPORT_F_END are unset, i.e. 0xfffffc000fffffff for
> + * all 64bit features. If the features are extended beyond 64 bits, or n=
ew
> + * "holes" are reserved for other type of features than per-device, this
> + * macro would have to be updated.
> + */
> +#define VIRTIO_DEVICE_F_MASK (~0ULL << (VIRTIO_TRANSPORT_F_END + 1) | \
> +                             ((1ULL << VIRTIO_TRANSPORT_F_START) - 1))
> +
>  static int vdpa_nl_cmd_dev_add_set_doit(struct sk_buff *skb, struct genl=
_info *info)
>  {
>         struct vdpa_dev_set_config config =3D {};
>         struct nlattr **nl_attrs =3D info->attrs;
>         struct vdpa_mgmt_dev *mdev;
> +       unsigned int ncls =3D 0;
>         const u8 *macaddr;
>         const char *name;
> +       u64 classes;
>         int err =3D 0;
>
>         if (!info->attrs[VDPA_ATTR_DEV_NAME])
> @@ -649,6 +672,24 @@ static int vdpa_nl_cmd_dev_add_set_doit(struct sk_bu=
ff *skb, struct genl_info *i
>                 goto err;
>         }
>
> +       classes =3D vdpa_mgmtdev_get_classes(mdev, &ncls);
> +       if (config.mask & VDPA_DEV_NET_ATTRS_MASK &&
> +           !(classes & BIT_ULL(VIRTIO_ID_NET))) {
> +               NL_SET_ERR_MSG_MOD(info->extack,
> +                                  "Network class attributes provided on =
unsupported management device");
> +               err =3D -EINVAL;
> +               goto err;
> +       }
> +       if (!(config.mask & VDPA_DEV_NET_ATTRS_MASK) &&
> +           config.mask & BIT_ULL(VDPA_ATTR_DEV_FEATURES) &&
> +           classes & BIT_ULL(VIRTIO_ID_NET) && ncls > 1 &&
> +           config.device_features & VIRTIO_DEVICE_F_MASK) {
> +               NL_SET_ERR_MSG_MOD(info->extack,
> +                                  "Management device supports multi-clas=
s while device features specified are ambiguous");
> +               err =3D -EINVAL;
> +               goto err;
> +       }


Hi! I need to question this last if() :). What's the point of error
when we specify features device-specific, from net or blk?

In the VDUSE case both blk and net are supported. I want to use
device_features to limit the net features that the VDUSE device
exports.

Also, why is this limited to only net devices? does this part:

classes & BIT_ULL(VIRTIO_ID_NET) && ncls > 1

Means that it is ok to specify more than one class as long as the set
does not contain net?

> +
>         err =3D mdev->ops->dev_add(mdev, name, &config);
>  err:
>         up_write(&vdpa_dev_lock);
> --
> 1.8.3.1
>


