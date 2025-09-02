Return-Path: <linux-kernel+bounces-796321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2F97B3FEF2
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 14:02:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58FE53B6EB3
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 11:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50F512F99A8;
	Tue,  2 Sep 2025 11:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IaH/CxhQ"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 202DE2F8BFF
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 11:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756814212; cv=none; b=DlJkjSDayiOyUsi+Ph60IT2skk7lLsdxAb065sp0tTYsdMzsmyOkGcaGfb7RCQnForSxt3mOIstoFwV1vW/F/JopEejlG67mRBtIqooUE5F29tqh40kq/yObwstq+uVfmo+0PV2N93owu/yVk/lgDpsfn/EXJCcBygsK/R1Xpk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756814212; c=relaxed/simple;
	bh=b1YlHgbmyU5wicKUR7DIncYAaRMKAJOWSkzUNdu5Jmc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JChp6mhTtwYLVwBs/umQt+FvGyv8uBirz6lJJhA4Pb/FRSSe7RiZ+DLoHPzwREIWadNfSXWiMK+B2S306Feiju34dTr4QzQ82CiiSN0UvKvbNBTue9/WbE5TOVSSDSQf0IC9dAnRc9/RrzWm/KjkCt2XzWUMJVv3p18YEIvHWog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IaH/CxhQ; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-61ec59e833aso624832a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 04:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756814209; x=1757419009; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CbUyaSyIRtchuH7yFzxitK+3O6e452pD2yav2xjr5N0=;
        b=IaH/CxhQvCPlJPs4cRklsEemmvZGoYypsuL5t7mwCNkAHVsGY18rSo6HI90RfnHm6n
         dNV2JET9XrfzmZ6pdzKAzJ94VDVWd1EoP4L8iP22IJ4ElnNv1yFSgcbHQMntqRxnu4YB
         LjqN6tmsQmcD0kU+LbS7yURdXLG3k6gIWMczaY6yG7E1Xypg0epsJ0muumyJxwVa6ily
         Z6n4Z55U7RoWGn82SukX4r+bXhlonzPHDVSQ9Kx0d+L1b2iq+G7YBkEtutfikXqITyGY
         r3aCd2DgJrQBB7b0KuvjMbEdQ0/0LsDFmgXTPvFZcZZ08SrHHZMXv597aHv+D5iyVKSi
         k6jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756814209; x=1757419009;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CbUyaSyIRtchuH7yFzxitK+3O6e452pD2yav2xjr5N0=;
        b=qgUaY3P17oWAyveRrDnibsmDC3DM3vMTC4hlGtBKtQWFxKzfcGPz1kM6C5zsRKQyn+
         b4t/ZbBd/SL1tqYAHEnphF+ivFju+h8gywE30jVV4fVbKHE0MvbwoVMpzeOqrAhyzD8c
         7TuSNyYwAzkzX0rN+tXUJKJx5aUmWsfs71eXxIQShBvmEtlYZrQtVreIGw9JU+pz1zVg
         /VyxacO0BnIQVTOMPNLJz/KB8Bxbjt/krHVDSOAfAgEMZVbYdCWnDBVzCLHuuNV0ApdB
         3zRJ8UbnnQz3ObdH2MtpJv+kJhW8zUD5cdJkomF2juB3Z8r7VnqNtfETNnt1aIiBGqPC
         QZog==
X-Forwarded-Encrypted: i=1; AJvYcCWdmUlJeVouFpG/FCvD5ODjEddJsixTR/3/OWMfuQ2EdKbIDZBvhpw6fNDCkz5BAOqIdxw7NfUcoGISptA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4GzIu8RYekgvyz9Ppo2uwEPwUYZhJhiPUw1F/Hpr7DIAEqtHW
	lPf0ZFC9Pa23rqiYAq5EkEWGampJJp3xFo2C5mw+kKXB0k8JLTQMWMNEt55i67zfonDtEWGgc/v
	ADmnjO05l/M2wyAnkWTH6kKgUS62pCfs=
X-Gm-Gg: ASbGncv8bEXpnLzYyrD6QJZCuIrViwgDyANo0Zm9TxGi44MOT8jdUn0NMhLDbypFQBH
	jylcSxvZSgX0+bwCOVreVDk091D2vhPY0P7wrm3SwmqipmOFTKjwLbeWG+5aN2lZHjYaq2bxfV8
	ma7sjO6TQNXkGHRVjJ2HawLt29BKdJ2ThE69RG4YGppaJHkJxCjwCJIWziT6ylMtH7m31hK228z
	A6aRA==
X-Google-Smtp-Source: AGHT+IFxuSGAS3lu7B+ojJXi7giy330zUQ+aEe+V3me6DbSYm2Y76wFDblf69yDwU0UiZi9kg9/Bf+jyiF1s8n+OQXQ=
X-Received: by 2002:a05:6402:2554:b0:61e:ae59:5f04 with SMTP id
 4fb4d7f45d1cf-61eae597256mr4093792a12.27.1756814209371; Tue, 02 Sep 2025
 04:56:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250829150944.233505-1-hi@alyssa.is>
In-Reply-To: <20250829150944.233505-1-hi@alyssa.is>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Tue, 2 Sep 2025 07:56:36 -0400
X-Gm-Features: Ac12FXxSr8Mq_QbTI61IlgDzDnhRy7hHUSOIvrPdEfy1Gmiv4DAgDC1ELJPYEjc
Message-ID: <CAJSP0QXd3zgMYRUQ3kCcUZ+RbZ6SHHn-kc5K4DV9C8LeU2g78A@mail.gmail.com>
Subject: Re: [PATCH] virtio_config: clarify output parameters
To: Alyssa Ross <hi@alyssa.is>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 29, 2025 at 11:10=E2=80=AFAM Alyssa Ross <hi@alyssa.is> wrote:
>
> This was ambiguous enough for a broken patch (206cc44588f7 ("virtio:
> reject shm region if length is zero")) to make it into the kernel, so
> make it clearer.
>
> Link: https://lore.kernel.org/r/20250816071600-mutt-send-email-mst@kernel=
.org/
> Signed-off-by: Alyssa Ross <hi@alyssa.is>
> ---
>  include/linux/virtio_config.h | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

>
> diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.=
h
> index 8bf156dde554..7427b79d6f3d 100644
> --- a/include/linux/virtio_config.h
> +++ b/include/linux/virtio_config.h
> @@ -193,14 +193,15 @@ static inline bool virtio_has_feature(const struct =
virtio_device *vdev,
>  }
>
>  static inline void virtio_get_features(struct virtio_device *vdev,
> -                                      u64 *features)
> +                                      u64 *features_out)
>  {
>         if (vdev->config->get_extended_features) {
> -               vdev->config->get_extended_features(vdev, features);
> +               vdev->config->get_extended_features(vdev, features_out);
>                 return;
>         }
>
> -       virtio_features_from_u64(features, vdev->config->get_features(vde=
v));
> +       virtio_features_from_u64(features_out,
> +               vdev->config->get_features(vdev));
>  }
>
>  /**
> @@ -326,11 +327,11 @@ int virtqueue_set_affinity(struct virtqueue *vq, co=
nst struct cpumask *cpu_mask)
>
>  static inline
>  bool virtio_get_shm_region(struct virtio_device *vdev,
> -                          struct virtio_shm_region *region, u8 id)
> +                          struct virtio_shm_region *region_out, u8 id)
>  {
>         if (!vdev->config->get_shm_region)
>                 return false;
> -       return vdev->config->get_shm_region(vdev, region, id);
> +       return vdev->config->get_shm_region(vdev, region_out, id);
>  }
>
>  static inline bool virtio_is_little_endian(struct virtio_device *vdev)
>
> base-commit: 07d9df80082b8d1f37e05658371b087cb6738770
> --
> 2.50.1
>
>

