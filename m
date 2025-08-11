Return-Path: <linux-kernel+bounces-762459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E263B206D1
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 13:04:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4879818C12E8
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 11:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E616B2BE7AF;
	Mon, 11 Aug 2025 11:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CmgZzSOk"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45652BE63F
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 11:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754910261; cv=none; b=YFPCcXguEqa5uoLcfPLdL4OFHNcEddWoIvXE6e0sUr8Pka5isfzCCD3xL+/1jNEWnQDkKi1q8yd9oQoRHgVElNlaY+GC+EKnfZAbcFpxctNS0ERFhxUlILIr1B5mck86wQtJfa7xQxbsvIvEMC/Uv7PxcG/UB71ejZpIjS36zIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754910261; c=relaxed/simple;
	bh=7swBeyj25GpPy2B4vm5DrwjXt8XVNNkLZpz1CZp3XHQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GELHpV9ECJAn0g7vsKv/2c+++FqbLe1kVUUfvGHZEWKwc1KjIqRZJWqttRO/aLLrMUkH8MmR+sx2LDVrPSMRaQ611R806kfctn4oJGWuWiaGz+CD9DAmQFIHu3tRRbIJ9rVit3dOObIaf13VdWoWdnmqJQoOICaZCDAYhrGe/d0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CmgZzSOk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754910255;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gbtrlWAXKnBqFTiIwDQ3ZgGXj2AWGHBhEhOwNJt/ZYk=;
	b=CmgZzSOktw5wM/ciyUxJ0/xI+ZmAv6+p6VatIrYdzhyqSDYGPfRHCuiYLuvRSDqIsUyCzO
	F49LOh/Adz+25FReRpn7zTH7Dta1n3IAjjtE6PohXMCpC35Jd2rpsPQmtolcntGr172QKn
	+myfuZrEyQ/FFAJtUrFuDSXZn5l45E8=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-326-ndrtq7KyPCaiYgBSC0aUBg-1; Mon, 11 Aug 2025 07:04:14 -0400
X-MC-Unique: ndrtq7KyPCaiYgBSC0aUBg-1
X-Mimecast-MFC-AGG-ID: ndrtq7KyPCaiYgBSC0aUBg_1754910253
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3132c1942a1so9255423a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 04:04:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754910253; x=1755515053;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gbtrlWAXKnBqFTiIwDQ3ZgGXj2AWGHBhEhOwNJt/ZYk=;
        b=P5fNBF8AHo7w08oI+FzC3o8btUA9jlMqaOTSGbeFTiXamh++n+GCjrb6yYrGttBS4m
         wUpkewddpAedlixzV/l7QE5cV2+xb78qkLGLFTMvokCaGvDbmvd+ZjZ9XF14RKbRV+S7
         4oXCvNQe+iz1vbmtB7mgFb22lVdiRWCOjzG5LC/H6MdczUq/2HkZ4lyEkouPU+jXloyV
         9Hrw93DwZOOIiHTiBOsVoqPoGejakXAFL+yBigukvUmev+CUz5miSuCbDFmTZm3IGiYS
         N+IV+HbS3ICV2LaBtmu66OL0DvnIxbXJm4oCxbFBpZmvLEFQ4wejkqx1KhVt2SZMU2Bh
         Pm4g==
X-Forwarded-Encrypted: i=1; AJvYcCW4Q65YodO5xvt9nCFXvDhH1pSAxX0Mr+8sKrfMBcT1JO+z9ZXwpPmJ2fc7MVxUeLQSITgWacwrWl5TGTs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyV5CUBbrYNSh/NGHg4p4vFC4HZKJNloVXzJ4IJwkBl7mlA2hU8
	stxvdUu2CS16j7NxFE70kYirmesfigYO0lNceLt3N2f1MQKY/iT1mitPZ/J5nbKy+vc8MD7wEFR
	SQUQDf1WMaFmS6MXXINb2uYCQnoTAhB99d9Z3LcLoEzBpRz5zWN91iSSqpP/Z+nh4nl6ig3asGz
	zSl0ryY0dZG5r1wPApFXUse2+LDYac6p/LTnDeGWU+
X-Gm-Gg: ASbGnct5e4eDxggRsPVRY65fWfnQJPuTSpQqra1Y6N66owqxqdkXe7+b/C3yDN4Ix10
	etgvCg6Q5IC29T158newGWLtlL069xPWLnJbI5oz0cFZa/CGIVikCyv1WvuVTpuWsGOftfEo6ue
	z99E5vDPnWkq+xQB4DFZ7J
X-Received: by 2002:a17:90b:3d4c:b0:321:1682:2d49 with SMTP id 98e67ed59e1d1-32183e53bc5mr14049824a91.32.1754910253485;
        Mon, 11 Aug 2025 04:04:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF3xV7eQmtVr29Dvkrf19Z0RpYiJKfehsxKGeyuyfepW7qEzpFPEIZ90g+ShPrigpIu8heBQhMEISWgVc3nZvU=
X-Received: by 2002:a17:90b:3d4c:b0:321:1682:2d49 with SMTP id
 98e67ed59e1d1-32183e53bc5mr14049792a91.32.1754910253179; Mon, 11 Aug 2025
 04:04:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250807115752.1663383-1-eperezma@redhat.com> <20250807115752.1663383-5-eperezma@redhat.com>
 <CACGkMEurTUOb6t9g+nVdzwU8LrZ=eAAxzHYVCTH1XkQkRtAUXQ@mail.gmail.com>
In-Reply-To: <CACGkMEurTUOb6t9g+nVdzwU8LrZ=eAAxzHYVCTH1XkQkRtAUXQ@mail.gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Mon, 11 Aug 2025 13:03:37 +0200
X-Gm-Features: Ac12FXz-ElJczrAcsWwjTE4HF8afkl2XnLnlhag32dbWIT1lsmlWc3ma_13wMhA
Message-ID: <CAJaqyWfh_3_J3+rq_7pa0YMUQSQHfeHn7Tvurz=PAmWoqV5vNg@mail.gmail.com>
Subject: Re: [RFC v2 4/7] vduse: return internal vq group struct as map token
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Cindy Lu <lulu@redhat.com>, 
	Yongji Xie <xieyongji@bytedance.com>, Stefano Garzarella <sgarzare@redhat.com>, 
	virtualization@lists.linux.dev, Laurent Vivier <lvivier@redhat.com>, 
	linux-kernel@vger.kernel.org, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Maxime Coquelin <mcoqueli@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 11, 2025 at 5:11=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Thu, Aug 7, 2025 at 7:58=E2=80=AFPM Eugenio P=C3=A9rez <eperezma@redha=
t.com> wrote:
> >
> > Return the internal struct that represents the vq group as virtqueue ma=
p
> > token, instead of the device.
>
> Note that Michael prefers to use the iova domain. This indeed seems to
> be better.
>

Well iova domain would delete an indirection in the pointer chase, but
it would be problematic to store the token in the caller.

And we need to add some way to protect that the ASID of a vq group is
not changed in the middle of the operation by an ioctl. IOW, the
vq_group_internal struct pointer is constant for all the lifetime of
the device, while iova_domain is not.

> > This allows the DMA functions to access
>
> s/DMA/map/
>

Ouch, thanks for the catch!

> > the information per group.
> >
> > At this moment all the virtqueues share the same vq group, that only
> > can point to ASID 0.  This change prepares the infrastructure for actua=
l
> > per-group address space handling
> >
> > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
>
> Thanks
>


