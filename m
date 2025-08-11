Return-Path: <linux-kernel+bounces-761756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 363E8B1FE12
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 05:24:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D83DF3B7989
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 03:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00D4224888F;
	Mon, 11 Aug 2025 03:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZYjujJcF"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B5B1991DD
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 03:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754882662; cv=none; b=T1BjZbgMNZIEy/1MennZu4s8Pt7jTiSoJL6L8ZQbotAP4LmOrUQ9hgUYIIZNCcuokzj/DiA59T0iQoGADG/vptJNVDhygCbcxTxbltXdXGEn11lb5Z5xEffVuUg4DPqW6rPeXOT0CN9eaNIRu61AlkhFF8nd+TXkdXRJht0qbTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754882662; c=relaxed/simple;
	bh=iP6Z1qUMCiUuRzcznpyqzUNtogdFZvomceWUHIJevIk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IBRzecN+0qFB9/Vi+dzyUNW2nnINhbW9e071Cx4fmC+Ea8ydH/v6C7E5OOm/3xmPgDs7RL+L+4Q6LUMMiHFEXpQGdHiNBjL0jmxrp4lX9hg8eMtiynLRL2T9NRzZO5aXJ/gz07JTbrXIlCJAs72QNJJot/AKBusB1O06GBLV1sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZYjujJcF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754882660;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zjNPuV7EJaEaUCcJ0gZblwrSNrDlXAI+214HZj1UE/s=;
	b=ZYjujJcFh57C7WJf3Ejj3jdnP4Dwz0+O13mUzozllVztWUaUpsltaxogcypnwQOxypqcbg
	Wd1zpBO/QE5JldM5D9/AsSVMtpBJdCeWR/kmUOrnxpJDvaHq7hk2W86CuYp2gZQnPXQK+h
	tSUSTox5J1TM2imOBu+ZIa4u4uKcuQ8=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-226-kGB4VxMLOTy3_8gnNp_g5g-1; Sun, 10 Aug 2025 23:24:18 -0400
X-MC-Unique: kGB4VxMLOTy3_8gnNp_g5g-1
X-Mimecast-MFC-AGG-ID: kGB4VxMLOTy3_8gnNp_g5g_1754882657
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-32147620790so4158819a91.1
        for <linux-kernel@vger.kernel.org>; Sun, 10 Aug 2025 20:24:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754882657; x=1755487457;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zjNPuV7EJaEaUCcJ0gZblwrSNrDlXAI+214HZj1UE/s=;
        b=r003kS2kDR5Krmw6Vyn6ZFJ6mr7HuQpDgZzpceH7uvHd279514Tc83GjqIkwRbSxy1
         DKdHzCIpszD2LBY6tcwgzY6yDliwUty21hgWYa+y/qSY/sz7gwGh5ci1WxjddpFk7I7A
         HJO4q7ijOVHXsBJItQWarYz4TolJsUbJYJ1usRo1h6E1xc3GWhmnqZZLe19Mkf2XMriv
         by2ySsLRUJnGUBqSgUk8fP8FlQth1fRxT9tFBlieZ0eg3XPde8gyW1KLt5oyMI197EeB
         NhicFhA01Dadbz/WxyswExsrYRFzuCXDjppE65GrpcVzvla3VG6Iz/AqDEE+tzOO1QTo
         4Kzw==
X-Forwarded-Encrypted: i=1; AJvYcCUSepkddWnhO7avcooCXeEmCPxKAMbpwC2cKGihV0bl6r5Ngnt/he+73Cjhxe0M2WdPmywob3Y69kTxsM0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSV8N6NC9iAk/GuNbSaeeUQ9G097K7Ys77/e55Ru2RTrN+IAew
	Xsjbo0xo5255CbXaLWC0RMdnGVuQgp6PWWxBTa8HFpujJnpOrqYAjeJI04RKK/AzMNzkD8zugbv
	Utw86AQiOTVsUlCPdfYbt/iiZueAztz4aQNPdVSt6jsWJhR7TnO0J+i1i4c1jpfHyEj8MO6yAgV
	pZm38hKEvLjmItThoyHn6LEZKGH5CQFn6aRTA0Vkq+
X-Gm-Gg: ASbGncsMb5NH87KQwJgVY2o5Ltam+C3lfhChvSkPqGd0RsJpLThA1f2ie+YShmzAiWt
	jfQMckb/EizA9UZwAMyoKIyeSufyZRyDPzGZgzNmZiP5prZEAg0bj1c0oSDvYblEvxTRyVYRvjF
	cM+oS85EhI13RSP2aSGGY=
X-Received: by 2002:a17:90b:3510:b0:31e:cdfb:5f1f with SMTP id 98e67ed59e1d1-321839f3e73mr15802491a91.14.1754882657275;
        Sun, 10 Aug 2025 20:24:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFE4ywZjr1sq2uRwQw4EF1VsaPtYYNpQ0buDcJ189M7Cu6CuvDxchAByxIOp6XLWSObXGmDD/ly6N2CbfA8BtU=
X-Received: by 2002:a17:90b:3510:b0:31e:cdfb:5f1f with SMTP id
 98e67ed59e1d1-321839f3e73mr15802465a91.14.1754882656818; Sun, 10 Aug 2025
 20:24:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250807115752.1663383-1-eperezma@redhat.com> <20250807115752.1663383-7-eperezma@redhat.com>
In-Reply-To: <20250807115752.1663383-7-eperezma@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 11 Aug 2025 11:24:05 +0800
X-Gm-Features: Ac12FXzgn3y-tLYzPRHYZyV9LaliqHEqy5NbVa1yW7rw96blCmLRNDtm3gfQeZ8
Message-ID: <CACGkMEsMi6Axcm_3Uin76mosPjsrwZv2qDvejoK_vLu1c3z6-Q@mail.gmail.com>
Subject: Re: [RFC v2 6/7] vduse: send update_iotlb_v2 message
To: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Cindy Lu <lulu@redhat.com>, 
	Yongji Xie <xieyongji@bytedance.com>, Stefano Garzarella <sgarzare@redhat.com>, 
	virtualization@lists.linux.dev, Laurent Vivier <lvivier@redhat.com>, 
	linux-kernel@vger.kernel.org, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Maxime Coquelin <mcoqueli@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 7, 2025 at 7:58=E2=80=AFPM Eugenio P=C3=A9rez <eperezma@redhat.=
com> wrote:
>
> This message lets the kernel notify userspace VDUSE backends about
> updated IOTLB mappings for a specific ASID.
>
> Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

I guess this could be squashed to the previous patch for logic completeness=
.

Thanks


> ---
>  drivers/vdpa/vdpa_user/vduse_dev.c | 14 ++++++++++----
>  include/uapi/linux/vduse.h         |  7 +++++++
>  2 files changed, 17 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/=
vduse_dev.c
> index 145147c49930..ac7897068222 100644
> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> @@ -326,7 +326,7 @@ static int vduse_dev_set_status(struct vduse_dev *dev=
, u8 status)
>         return vduse_dev_msg_sync(dev, &msg);
>  }
>
> -static int vduse_dev_update_iotlb(struct vduse_dev *dev,
> +static int vduse_dev_update_iotlb(struct vduse_dev *dev, u32 asid,
>                                   u64 start, u64 last)
>  {
>         struct vduse_dev_msg msg =3D { 0 };
> @@ -335,8 +335,14 @@ static int vduse_dev_update_iotlb(struct vduse_dev *=
dev,
>                 return -EINVAL;
>
>         msg.req.type =3D VDUSE_UPDATE_IOTLB;
> -       msg.req.iova.start =3D start;
> -       msg.req.iova.last =3D last;
> +       if (dev->api_version < VDUSE_API_VERSION_1) {
> +               msg.req.iova.start =3D start;
> +               msg.req.iova.last =3D last;
> +       } else {
> +               msg.req.iova_v2.start =3D start;
> +               msg.req.iova_v2.last =3D last;
> +               msg.req.iova_v2.asid =3D asid;
> +       }
>
>         return vduse_dev_msg_sync(dev, &msg);
>  }
> @@ -882,7 +888,7 @@ static int vduse_vdpa_set_map(struct vdpa_device *vdp=
a,
>         if (ret)
>                 return ret;
>
> -       ret =3D vduse_dev_update_iotlb(dev, 0ULL, ULLONG_MAX);
> +       ret =3D vduse_dev_update_iotlb(dev, asid, 0ULL, ULLONG_MAX);
>         if (ret) {
>                 vduse_domain_clear_map(dev->domain[asid], iotlb);
>                 return ret;
> diff --git a/include/uapi/linux/vduse.h b/include/uapi/linux/vduse.h
> index d300fd5f867f..a5f7a5edb8e0 100644
> --- a/include/uapi/linux/vduse.h
> +++ b/include/uapi/linux/vduse.h
> @@ -349,6 +349,12 @@ struct vduse_iova_range {
>         __u64 last;
>  };
>
> +struct vduse_iova_range_v2 {
> +       __u64 start;
> +       __u64 last;
> +       __u32 asid;
> +};
> +
>  /**
>   * struct vduse_dev_request - control request
>   * @type: request type
> @@ -369,6 +375,7 @@ struct vduse_dev_request {
>                 struct vduse_vq_state vq_state;
>                 struct vduse_dev_status s;
>                 struct vduse_iova_range iova;
> +               struct vduse_iova_range_v2 iova_v2;
>                 struct vduse_vq_group vq_group; /* Only if vduse api vers=
ion >=3D 1 */
>                 /* Only if vduse api version >=3D 1 */
>                 struct vduse_vq_group_asid vq_group_asid;
> --
> 2.50.1
>


