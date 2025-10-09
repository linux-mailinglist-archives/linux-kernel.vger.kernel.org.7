Return-Path: <linux-kernel+bounces-846277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B64F0BC7750
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 07:46:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A57054EA3AC
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 05:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 940B61AF4D5;
	Thu,  9 Oct 2025 05:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WS1YxHD0"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 621C334BA49
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 05:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759988754; cv=none; b=MEBAKKS8VMXgumeu8ApeZOG+zofvVIAKuNzXVJ2ijc0ODUZCX7wXB8ENltS/MITT6NEq0BZUTzHSSc9W/2bLbM69VKR60OFzjpLb8PicQaTn0AsB5vnUeYlHjNDzg26C0QiztxK3rGY3O2vpzZkOa++rqT7e9GOwYb+DpN0nizs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759988754; c=relaxed/simple;
	bh=Cgs5/82pfRdFOfycNZ7ouFWHQSrCRVqg6S+KdryAJEE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oNnCLw82uWK05qH8zhG7+T75eBaaCwSM3+F8zzFo1/1FyPrso/Yr1jMXGO+uYySdoRMDYfarBiH9Ni1bYmnC1XWoqk+gGlJplPd+iYF2obKcIvecCNzv/TJZuw0UVnsZWU6Ob8FIherT8uhjAKL/2egtYDR7FOSbHIx1TzkzQ0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WS1YxHD0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759988751;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=orcYfgdpG/ZGGYwoentBQb80+LYoN5XSkiV8KV8rfJo=;
	b=WS1YxHD0RLWCBG54jRqyoxXC705I15M0csjQjiPBRQAnbzBiH5uPE4qIW3+fZ9/Y4Mi3jS
	6T/YUQvl9XEjvlSbmH2giaFO1BiJxR77oirVnjThAL6kaaDbXARNO2HLXUa6wBnRHGRGto
	TNAGg3mKYuJUHBlpVKNjrrWNflrWM2w=
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-28-Dt6B4LkqPZG8syP1WgBwfg-1; Thu, 09 Oct 2025 01:45:49 -0400
X-MC-Unique: Dt6B4LkqPZG8syP1WgBwfg-1
X-Mimecast-MFC-AGG-ID: Dt6B4LkqPZG8syP1WgBwfg_1759988748
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-5cf363edd82so1558610137.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 22:45:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759988748; x=1760593548;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=orcYfgdpG/ZGGYwoentBQb80+LYoN5XSkiV8KV8rfJo=;
        b=I3J3S+8W9RzuLn5gXiHbbHo0zEhYV0bz7lVeMqO8Elz/gRH89L7M3tQ5PYTQ6xq4DM
         scZlh0BpDNeYyl7Ui0BjS39tl4Nrx0jD3ygbOqm1mZzv3U0Gt23Ak7fs8GmxADrwsDZ0
         cuvCAWnpOUbfLO4N2gDsGVDkW54gUmC/qZHS+EzSr3fJQx69zBIYEFp8ve2guRKD9HHa
         j20G1WyRGg8S53vpsGIAUqHfD2db6pmS+ni/0nveQOHiIr6hTlt6Xdf2EPogl0FPMcRj
         8fCSBkjcif59b6W5RB9K/y2SV2p7jYNw9eCfO0jLm7egdoSyXvXSC7hqDK8jZ2ynEH8B
         tl2Q==
X-Forwarded-Encrypted: i=1; AJvYcCUwYc8LK6mRT4YpyMvhWwa0UfDc/eK8FUoKxaZvKbEWJ/aeA0C0JWd+mLnOnfZnkQ7Z3cbqNy1WgyW61Ek=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/OdpAJrrAoceZZHO+AF+HSgIz5PgWkndmrss8w0KkXHgfLNWP
	rLMOydbHIUZX2+1vV0zBRdZIZKXWWT61EG5nG8rEkJgsFe12bR5zEEGAy14jti/ex/iUuYLdoin
	mYfWatnlquya15tK0KkC937I33r/hWTfnnZLVtcdFN9cza/eOrE3pHYBe6YLHV6KAcwI16FqqoY
	aVPDMGQlw+fJFseuulwmwKDtyRXC9/H+0XXe0BoczS
X-Gm-Gg: ASbGncvLTLEeU4GSUUiSFXt6oppHBeMuUIxlWc3k/dlcYZf1a2F6oHKe/wF6yDrH2Mb
	ivGzW8Wq9LsZYMA8X8Ns1PtQuySvlePFFm1jAdIo23E25WAaH400X/m0bzRZs7/FC7VcCWZFh03
	POIhWFrk8P75S400/e544/Sib3xL8=
X-Received: by 2002:a05:6102:1a06:10b0:584:7aa3:a329 with SMTP id ada2fe7eead31-5d5d4c81309mr3856075137.4.1759988748529;
        Wed, 08 Oct 2025 22:45:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG3G8kAFYaXC6ufiRYos6wQXP8+qHlI6XHMSGOom3zuceYwL+hPPQed85kXtqvFgON80O528fdCfB3/9TPXj90=
X-Received: by 2002:a05:6102:1a06:10b0:584:7aa3:a329 with SMTP id
 ada2fe7eead31-5d5d4c81309mr3856068137.4.1759988748195; Wed, 08 Oct 2025
 22:45:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250929134258.80956-1-alok.a.tiwari@oracle.com>
In-Reply-To: <20250929134258.80956-1-alok.a.tiwari@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 9 Oct 2025 13:45:36 +0800
X-Gm-Features: AS18NWAJIasEWYyFtU2lfrqbz_3g5EECFeIzi1irlKeHZRF9-ZPVkvavqWabGu4
Message-ID: <CACGkMEvyh9CBHjQs6bYv8v-DVYGizjOrVMuFVsnnrJeN6kTrfQ@mail.gmail.com>
Subject: Re: [PATCH] vdpa/mlx5: Fix incorrect error code reporting in query_virtqueues
To: Alok Tiwari <alok.a.tiwari@oracle.com>
Cc: dtatulea@nvidia.com, mst@redhat.com, xuanzhuo@linux.alibaba.com, 
	eperezma@redhat.com, tariqt@nvidia.com, moshe@nvidia.com, kshk@linux.ibm.com, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 29, 2025 at 9:43=E2=80=AFPM Alok Tiwari <alok.a.tiwari@oracle.c=
om> wrote:
>
> When query_virtqueues() fails, the error log prints the variable err
> instead of cmd->err. Since err may still be zero at this point, the
> log message can misleadingly report a success value 0 even though the
> command actually failed.
>
> Even worse, once err is set to the first failure, subsequent logs
> print that same stale value. This makes the error reporting appear
> one step behind the actual failing queue index, which is confusing
> and misleading.
>
> Fix the log to report cmd->err, which reflects the real failure code
> returned by the firmware.
>
> Fixes: 1fcdf43ea69e ("vdpa/mlx5: Use async API for vq query command")
> Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/ml=
x5_vnet.c
> index 0ed2fc28e1ce..b2ebf56b2ea2 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -1258,7 +1258,7 @@ static int query_virtqueues(struct mlx5_vdpa_net *n=
dev,
>                 int vq_idx =3D start_vq + i;
>
>                 if (cmd->err) {
> -                       mlx5_vdpa_err(mvdev, "query vq %d failed, err: %d=
\n", vq_idx, err);
> +                       mlx5_vdpa_err(mvdev, "query vq %d failed, err: %d=
\n", vq_idx, cmd->err);
>                         if (!err)
>                                 err =3D cmd->err;
>                         continue;
> --
> 2.50.1
>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


