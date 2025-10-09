Return-Path: <linux-kernel+bounces-846290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7165CBC77AE
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 08:03:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 775EB3B64A7
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 06:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2513729346F;
	Thu,  9 Oct 2025 06:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FukvzxNq"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B32923BCFD
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 06:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759989793; cv=none; b=G5CWxTy81DxP4asVud8shsOuXx9UqSyFj+1L+Jh0jmpe49oKMD5yrGIjQ4E6wVIx/hmuGk8WilhEnZeGdcop5fPwknful8qUv/x0v4fd3PdiP0JgK1ypqSm3g5Hz/+HVSNJl1CzNkr7EiBbBWbzcqeK3gewvwBPb6lWjwX2NzR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759989793; c=relaxed/simple;
	bh=m3LMdSR0pUCk633KJY2rAFBl+kdS7af4YNqnHwPhzSc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F+oEyQDnvIvUjumRFJ0NzpxadcVQtBrHZ6KUvGqRPiug8t5FqpwynsDE7FtsDbgoXV9+NJ7IPxhXSZ1wTXaco4tBa83zzSRQCUJZp38bB8D/X1xjGVYib+OAPkb9XTgIxldVJx3QguOWKyBYjwa4pBlaALH+7RMMaj7VJkUxPL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FukvzxNq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759989791;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P+TYUU+xeDw8HGGSvf4GTNBs7jshrvw+KJVNBUadUDQ=;
	b=FukvzxNqFdJ2b+RUCsEA77QtzAcjWmr7+XL2OvKzsYKmLryfUy2fxK/JbbSfJ9TqL2kt5u
	E3O7l26cKWsaLX7pTWTNe58IhTk/SX9nzlaZU1EHbrmzeDBq5PPT/kEsZ70AA0bz6yYR29
	3hwFwG3qh+2gbqoie1Yvro0TE6FsuRc=
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-523-cQ9VabCWMrGNHro_Xs-JTg-1; Thu, 09 Oct 2025 02:03:09 -0400
X-MC-Unique: cQ9VabCWMrGNHro_Xs-JTg-1
X-Mimecast-MFC-AGG-ID: cQ9VabCWMrGNHro_Xs-JTg_1759989789
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-5d5d1edc3fdso412043137.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 23:03:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759989789; x=1760594589;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P+TYUU+xeDw8HGGSvf4GTNBs7jshrvw+KJVNBUadUDQ=;
        b=GEsG8isA5nj+FxbPEUbfZP/CgAafS3zreOPM9aQ3vQ4SzPLYoUhK4Qhq6R8Js24gUu
         NUDcVNMc+RRqM8mqie3IUPI4bp5xJzbX4cLgluPiCRvuBFMrmWi9Rjej7CxgtvUDYXsh
         cuAfvNy+5UKKJXVJPmG6lXGPcyX8L7rokgMdt5QWOjN8XICLy4/jZ2p3p81sV+qiuEQ8
         NhBZeDUElHINDj6RUrTYSDs2XvClCTwcE+HhTvB9K5hNZhXbt6s5wu2BFpt8lnynBpBm
         ACUB4xR7I8qz834wwAmOoiaOlV6ZthdV0zOAliDPWe09MwEcE6Uh3aMTRQ+Z+9gXrPCq
         pQhA==
X-Forwarded-Encrypted: i=1; AJvYcCUq0iejefWCqO/dgNIqXz4h+/vkNuha58FdW/6/vCrC8uJk7Ge9StZlBsaD2uTTU7SMnE1IfqICSR2bBwM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJyYx8oPC+itHVvN/2hYCXkjGlgo8BrYhTJP0k0iuz4vMADK8c
	bOYmk5dnx1XAP0Hq0G/7t1UEv2VwjP136pnETwz2ToScuW41CY3jy1JbOMsTQzw896N06Yw54O7
	PJCwGXdYpTWVohq4U+3rtpp+nIPacMJTKg6LsA2MuxFIi/O2Kjh9cVpiPHVb9zaIyikW6QM6POx
	dASurZWMnaVfuqIZE7ruWUG8zD5VWOtkZkCQXeRC8K
X-Gm-Gg: ASbGncu+Fo5EuCoH/bChQP/kRPlinzP8AW1HeDrSH4aIIRhVPATgk4SaIQMfNAWHlYy
	+uSuf7hST1QGZC7RxhFJmnIr1OIwbAKFRF+43V+/nSLUGX0Or9D3p2y+1TFZAH5K8Iidgs2PEDO
	NJKWXrd2tClZv80c7Ll4O7mjY=
X-Received: by 2002:a05:6102:50a3:b0:59d:458d:b629 with SMTP id ada2fe7eead31-5d5e23b6f9fmr2592712137.30.1759989788818;
        Wed, 08 Oct 2025 23:03:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEIVynxqXHdtPe98YX2uMJXg5j6g1+mpitA+niP2MyNvau1YAC2uKE39BRPR9p+oXUwcQuZODNisuncD9hvjIY=
X-Received: by 2002:a05:6102:50a3:b0:59d:458d:b629 with SMTP id
 ada2fe7eead31-5d5e23b6f9fmr2592701137.30.1759989788435; Wed, 08 Oct 2025
 23:03:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250929165213.2896034-1-eperezma@redhat.com> <20250929165213.2896034-3-eperezma@redhat.com>
In-Reply-To: <20250929165213.2896034-3-eperezma@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 9 Oct 2025 14:02:55 +0800
X-Gm-Features: AS18NWCRvWiPkTewAunTvSLshw0QM9Wb0_PtyIIsY-hGVYpA9RFg6jNGdChZg58
Message-ID: <CACGkMEvnS_zYoCbh-MMjApFXQGuMdUrJ=EjOJwXkwUUdqfToNA@mail.gmail.com>
Subject: Re: [PATCH v6 2/7] vduse: add v1 API definition
To: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Laurent Vivier <lvivier@redhat.com>, 
	Yongji Xie <xieyongji@bytedance.com>, Stefano Garzarella <sgarzare@redhat.com>, 
	Cindy Lu <lulu@redhat.com>, Maxime Coquelin <mcoqueli@redhat.com>, virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 30, 2025 at 12:52=E2=80=AFAM Eugenio P=C3=A9rez <eperezma@redha=
t.com> wrote:
>
> This allows the kernel to detect whether the userspace VDUSE device
> supports the VQ group and ASID features.  VDUSE devices that don't set
> the V1 API will not receive the new messages, and vdpa device will be
> created with only one vq group and asid.
>
> The next patches implement the new feature incrementally, only enabling
> the VDUSE device to set the V1 API version by the end of the series.
>
> Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


