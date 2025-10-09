Return-Path: <linux-kernel+bounces-846273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EF249BC7726
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 07:38:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 72FB84F1A0C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 05:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 614A72609EE;
	Thu,  9 Oct 2025 05:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dkzeH1cY"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E0321DF75D
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 05:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759988302; cv=none; b=uP6j+xS1XreqZUgxS4RFJRGTGgt6uSSzRfs7xiMTtmTt1kxWS+iHQ7npHHCU6FUAtivDmmw3YJhGuqDUqAV85Ruv/S3EPJs/6CPdMbhpNQU2Xi59fF/AASwCg4PwgBumDXFVI/NR+DMNoB4/4a1MXA/Rd5dtffgt5vDFVRafU00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759988302; c=relaxed/simple;
	bh=xJjynxUyu/EH6gdZjZpUbNxIfveXGxgSA+7Tcn6hZNc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=trMS/aps6zX0nAnbEBaCd8iBPleTxuC69xbSC7Kqr3sBklBnfOdI3lHZYF3j4QbvBaVQwtfk1IuUwKR2EXyDSkAM3xNUUUdb9GsxtyRBWM51sEtR+yvYIsdLsuifYXGQU/9LrrM5SMnmlDzjQNA8eK5I90j560Gr+zLbEPO9KdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dkzeH1cY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759988300;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eWTa/TuKH4Av9RX0s6HhLEo/QEtIUV4RKh28VuFqaMs=;
	b=dkzeH1cYreKx7TbEWR7h3PwSJeskKkclpJDx7B1Obvv7mPKDOdYOI25NGjAsVYGxdqHHuR
	jebkOHbVj4YLHOu55sRkLnzJRHhia6yuVc090rIcN5+Ml1Lwv2bN9RhRmhAHIkaqlwssMK
	qF6MfWyL9MLhvUzEmW/NjeAbS9Ywd2Q=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-509-R3gy54J8OOSuIImWQX-KpA-1; Thu, 09 Oct 2025 01:38:18 -0400
X-MC-Unique: R3gy54J8OOSuIImWQX-KpA-1
X-Mimecast-MFC-AGG-ID: R3gy54J8OOSuIImWQX-KpA_1759988298
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b57c2371182so906000a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 22:38:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759988297; x=1760593097;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eWTa/TuKH4Av9RX0s6HhLEo/QEtIUV4RKh28VuFqaMs=;
        b=DZsQga1r0/41GdFxI5LRMdOVapTXP2meJfD8v6m+c7dwu4HZx42+a5wxrXzk3vsHeP
         OMdC8o3qG67u0qQQsDNKOGzDn4QzLiJJPgJqxe0lXMDjkBzU7s/CXbqN+JUECNx738Mk
         HdchJDjGGfdTqJYEKGiXKFM3iUbE/t0DSqCWtecuuXd4D7L+RdkqyvWXxONTjMeimTp/
         RpUCNIv33K6zwNHDU9GcBMX93Ro4Rlhj92KBwe8h9RXvuiemJUqM4q4q9DTt3pGGX+wx
         8jZ7jl6iBr3G47hnZKV5btZC1kXdVrEjU6v1WDTgaPBYe3CHEK7jdDSrGRPeyJZ37zep
         HxtQ==
X-Forwarded-Encrypted: i=1; AJvYcCXOWbvAKJp2+LA1gRYebn5d9S2EtDAHciPYS2SbXz+PY4PWGHK2N1nmQ0l68bLsqXSiSHe+5EreKtVFtf0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywc/bcoPmNsr4U5jbIKle62hCjvzhCNGchWPZgyRJEQ/sgKW/0q
	xrJtljFk9KtzETH+rBnRRs26gHkiL6t5EgNfb+wDKroI7Dolis6dFFGPRPkURtCnBz5czJxBSeP
	zh8MXu48hStQxTR2Yn6nLmvMA8InSn4qOQGFSy208nukJ01QSz0hU4lK/CXBFdiYqIACXwLMjMi
	DEyqrdHE4WVfVlqjBKQGEVgJjzkeeoetn8N25vqNlv
X-Gm-Gg: ASbGncsDbMfkQpJXtYHS7KrBA5AV0stJdDyButYqcJNsvPrsgp29iAN1F4KzHQ1NUs9
	Z2gMAjbgb5MIPwLaetY0qmFxz7jAlJkhW+DlfbK7Kl7K6pXPHoqW/AwS93MgaCvE7jSBH+rkFKP
	mAdlUkuepO0dFxX06DEIduXlusib4=
X-Received: by 2002:a05:6a21:e081:b0:2d3:8d14:7fad with SMTP id adf61e73a8af0-32da814fd31mr7953244637.27.1759988297621;
        Wed, 08 Oct 2025 22:38:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF/+jT86H6pFu5z2IW0huX/mcSDC4LtmUAbOMb6joX2RFToDjfDTugADgLQsNq+Cc9wybU4k9PQ7wRVrcDmTQU=
X-Received: by 2002:a05:6a21:e081:b0:2d3:8d14:7fad with SMTP id
 adf61e73a8af0-32da814fd31mr7953208637.27.1759988297157; Wed, 08 Oct 2025
 22:38:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251005181232.3320977-1-alok.a.tiwari@oracle.com>
In-Reply-To: <20251005181232.3320977-1-alok.a.tiwari@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 9 Oct 2025 13:38:05 +0800
X-Gm-Features: AS18NWC3EQFtQ3ql8i-tEQy41dxRQwOdJk9C0vzba7wnIt93KviO7yYi2ydIbX0
Message-ID: <CACGkMEux7-Xe3PrGpneJ3ynowEjYnEjxB5f+OV9RWvS-aRfy0w@mail.gmail.com>
Subject: Re: [PATCH v2] virtio_vdpa: fix misleading return in void function
To: Alok Tiwari <alok.a.tiwari@oracle.com>
Cc: eperezma@redhat.com, mst@redhat.com, xuanzhuo@linux.alibaba.com, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 6, 2025 at 2:12=E2=80=AFAM Alok Tiwari <alok.a.tiwari@oracle.co=
m> wrote:
>
> virtio_vdpa_set_status() is declared as returning void, but it used
> "return vdpa_set_status()" Since vdpa_set_status() also returns
> void, the return statement is unnecessary and misleading.
> Remove it.
>
> Fixes: c043b4a8cf3b ("virtio: introduce a vDPA based transport")
> Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
> ---
> v1 -> v2
> added fixes tag
> ---
>  drivers/virtio/virtio_vdpa.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa.c
> index 657b07a60788..1abecaf76465 100644
> --- a/drivers/virtio/virtio_vdpa.c
> +++ b/drivers/virtio/virtio_vdpa.c
> @@ -80,7 +80,7 @@ static void virtio_vdpa_set_status(struct virtio_device=
 *vdev, u8 status)
>  {
>         struct vdpa_device *vdpa =3D vd_get_vdpa(vdev);
>
> -       return vdpa_set_status(vdpa, status);
> +       vdpa_set_status(vdpa, status);
>  }
>
>  static void virtio_vdpa_reset(struct virtio_device *vdev)
> --
> 2.50.1
>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


