Return-Path: <linux-kernel+bounces-847658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5E90BCB5D8
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 03:39:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31B9E3C7E4A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 01:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC20F211499;
	Fri, 10 Oct 2025 01:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F2udfWXN"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F4D2868B
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 01:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760060373; cv=none; b=izaA7EMeW78/SyPDFqTVZDjtl3iK3Nm585xBYpDi1DiAutSUJAlVIXhQxYNr0IcWjl9uwEnzYbY7vsYO3h5InYz+Ji7+ovu1TeYFUDHkUr1Sy2gweh8PAk8mNRxUiHdPeLoASMCkfNcruLw0WUJK+FS1/nuM6T+Y1YUhNGonTMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760060373; c=relaxed/simple;
	bh=4XSRVd6zjHhel0Yxft/tpVar5ofWk0brp4Y95QqP7Wc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fRlGLCR5Lq+R7+lhuTxjYQfaKvfYBsqqxygxJjkwl6803qvEtxJKaWTjZAWiMKkFG7SjA2pchck6q2FankXo+n+EQ425QG3g1j5Rp7ttUG6yGqrqptd7tuQhy19g1wMQwnXu3mVPGFqYKtka3G95vDhumCoyvG67XJ0KZe7eU5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F2udfWXN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760060370;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QJ2PrnDvvtlGzC1CWb9dBshv/kwMkb9jABazEpzCcBg=;
	b=F2udfWXN2Rlr3acnWnLDabDoRIeg0iXbu+ePp0NfxtlFzzit7zEcTlmJpKiM1jCcrcpTD5
	jTyamHBykldMyH4K3QsZ8amuh5oYYGwSRHugCvUvH1ih9GUzdUouXqaEkijyxiS9rs4uEb
	EjD60/sGYr6MWjs9ifMJlqwTNR4icCM=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-571-ieq9i0kAMWWHodCXGwgE1Q-1; Thu, 09 Oct 2025 21:39:29 -0400
X-MC-Unique: ieq9i0kAMWWHodCXGwgE1Q-1
X-Mimecast-MFC-AGG-ID: ieq9i0kAMWWHodCXGwgE1Q_1760060368
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b62da7602a0so2633457a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 18:39:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760060368; x=1760665168;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QJ2PrnDvvtlGzC1CWb9dBshv/kwMkb9jABazEpzCcBg=;
        b=gITIEf/dKlJ1/MO3ZAF6zXfJdfKMJnp5xPHibW9bzep4Zhc1M0Mo6iI7RVts2gWUes
         ScmZvqWX7QiFz2dvw0+g7d4ckMFBrUPyXoOnSGIIqe1HFsHvzjEUJ2OMbrCifpplVFQ2
         eltEmAcdjqrTXkU4Pu2pnGXXm9uwQuao4OLW2uFOrzEJJ5Y2pUBHVhd40nraN0/JZJFf
         158CIQzQ35bxZdMNho0fKy7LG9iOoD8ZJxElcDFdezy0XVekiK0265AqmvNNWKhtTtJS
         BM2ItJm3TD9Recorfj4G/GBwOByT38yV5wK9+YzRyynky52jQxmeblNWZpja0cVuQ4X6
         sq8A==
X-Forwarded-Encrypted: i=1; AJvYcCW8H7SGJ6rMa3oHiuKi4zDJds6ZqmQLQkRgUEtQwy+ooR4Qh6kB3MtjB2gOWkLQubvvSaAWYAV7U3bGRfk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yym6FACIg9S82CxYORMbUgas1Ql4xAXvFUz8UHrJxRp+5cJH6s9
	GUbB1u4oXda7Cgn02BnBTwyorhQfC/U++OkTEci+KR2biJy7M678L2m6ZLTrY9H/V7Gfg9rZT1s
	QJJtCzXb2qtjajmywIAmSWn8WK8MuX1nQfab9gZRqfwP5LoYjPJmKLMCwsA4LSuPuQUz3mXpj1y
	dkGqU72QDoG3Mwu3x6krv66nTj14ltGlLj9wzg/r/b
X-Gm-Gg: ASbGncsI4hE5ktsztMU6Ixao0dN7PTvTGeSeug89dx19EFVMc2ENPG/nARwi2EFU674
	Hq0a93udwHK3E+nl4KqBD+A3G1wd8cTZlMB34BheQYW1WmCB43F6ZKtzIffeL+1NFfrkNal2k/m
	c8EiGWGX5XChONcDMTkrjy/LI=
X-Received: by 2002:a05:6a20:7486:b0:2ec:f29:1011 with SMTP id adf61e73a8af0-32da820e9f0mr12793217637.20.1760060368096;
        Thu, 09 Oct 2025 18:39:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEWUCiMPfeXQJAxeOD5bsbIs4rsThpTo6HCCU59kWUmK7PnrOrxP5nmBoR6qw+ps6A1upYzM4SB9S2ZqicH+os=
X-Received: by 2002:a05:6a20:7486:b0:2ec:f29:1011 with SMTP id
 adf61e73a8af0-32da820e9f0mr12793191637.20.1760060367638; Thu, 09 Oct 2025
 18:39:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251002103537.308717-1-eperezma@redhat.com> <20251002103537.308717-3-eperezma@redhat.com>
In-Reply-To: <20251002103537.308717-3-eperezma@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 10 Oct 2025 09:39:16 +0800
X-Gm-Features: AS18NWC0f_X2gcqtgEFF8PFD0xeFfMB6NhlHaz6fkoqBYquwzREZgrTKbkviorU
Message-ID: <CACGkMEucnJMs0QcH4ggourizEGsvkzF-d_OYXy0XBeU_opdNAQ@mail.gmail.com>
Subject: Re: [RFC 2/2] vduse: allow to specify device-specific features if
 it's multiclass
To: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Cc: mst@redhat.com, Laurent Vivier <lvivier@redhat.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, Dragos Tatulea DE <dtatulea@nvidia.com>, Cindy Lu <lulu@redhat.com>, 
	Maxime Coquelin <mcoqueli@redhat.com>, Yongji Xie <xieyongji@bytedance.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, linux-kernel@vger.kernel.org, 
	Jonah Palmer <jonah.palmer@oracle.com>, Si-Wei Liu <si-wei.liu@oracle.com>, 
	virtualization@lists.linux.dev, 
	=?UTF-8?Q?Be=C3=B1at_Gartzia_Arruabarrena?= <bgartzia@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 2, 2025 at 6:36=E2=80=AFPM Eugenio P=C3=A9rez <eperezma@redhat.=
com> wrote:
>
> Even if the device supports more than one class, there are ways to solve
> the ambiguity of which device are we creating.  In the VDUSE case it is
> the name, for example.

This may only work for VDUSE but not other parents.

>
> RFC: I fon't understand 100% the motivation of this limitation, as the
> backend should be the one filtering out the invalid features if any.

I think we can avoid these tricks. Currently, there's a one single
mgmt device, this seems to be in-convenient. Could we have a per
device mgmt device? For example, if user space creates vduse0, vdpa
mgmtdev show may see vduse0 so we won't have this issue.

>
> Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> ---
>  drivers/vdpa/vdpa.c | 9 ---------
>  1 file changed, 9 deletions(-)
>
> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> index 34874beb0152..0fc32f3bd66f 100644
> --- a/drivers/vdpa/vdpa.c
> +++ b/drivers/vdpa/vdpa.c
> @@ -688,15 +688,6 @@ static int vdpa_nl_cmd_dev_add_set_doit(struct sk_bu=
ff *skb, struct genl_info *i
>                 err =3D -EINVAL;
>                 goto err;
>         }
> -       if (!(config.mask & VDPA_DEV_NET_ATTRS_MASK) &&
> -           config.mask & BIT_ULL(VDPA_ATTR_DEV_FEATURES) &&
> -           classes & BIT_ULL(VIRTIO_ID_NET) && ncls > 1 &&
> -           config.device_features & VIRTIO_DEVICE_F_MASK) {
> -               NL_SET_ERR_MSG_MOD(info->extack,
> -                                  "Management device supports multi-clas=
s while device features specified are ambiguous");
> -               err =3D -EINVAL;
> -               goto err;
> -       }
>
>         err =3D mdev->ops->dev_add(mdev, name, &config);
>  err:
> --
> 2.51.0
>

Thanks


