Return-Path: <linux-kernel+bounces-793970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C8BEB3DAFC
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 09:27:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62207189BA3A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 07:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 179CF26B771;
	Mon,  1 Sep 2025 07:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EVC5DeR+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A597F26B76C
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 07:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756711666; cv=none; b=ualFsBUP3FNg1/xXFHzfwQoPFg+6+4v+y6wYbK2dJTxeZp3jdrsxe5QzFsvkaPjYToFqrBWYL6/YAJqkLD+40CRr29F4ZjLWJjwGra7gv+Y5lIROYLiMLX5MlEnmtjaTIwqD0SDfi7oRTi5J3j5n3HcmoO/CGU4jKg1RBSQIEoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756711666; c=relaxed/simple;
	bh=rCQntznBOWf2Inr+Q/6BajRWkn60e+i2NmXc+MaYtyU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p8XK8omKpmaUxYKde6tvcnDsyvlvTYTaJUfPoa4PspaVKv6MArOtW5j+UmPERIZfxkUFQiT4DC+dYldqp/epTnZaLSX0aTIuY/vTUtmgiatQkQfY/FQ3plyOKDTKaSmeEVT90Iou0CrEDwGqpkPKLqp78aTNW3Ljo5fj25G23aA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EVC5DeR+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756711663;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JSUiWIPMhwHs96b7ABTVTbCkzVoFmMpEwSL1Ss/Y85c=;
	b=EVC5DeR+xRGQwqIEkplYtXVFa78/CW9uNjAd7MUo3iXVstT7jM/rCRCLZyAjHWynUhW4I1
	XmMgDpApMt4v8j+dQ4rEG/oRabynH/qs9nvndrHYbOQ+i/vima2/90KCZ5fQdRkHQKOeeg
	Id+tHCsoDjXUwpIi7v5Fl5BapyF8mlw=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-d92zZfCSMUe9MuGbmTZdNw-1; Mon, 01 Sep 2025 03:27:41 -0400
X-MC-Unique: d92zZfCSMUe9MuGbmTZdNw-1
X-Mimecast-MFC-AGG-ID: d92zZfCSMUe9MuGbmTZdNw_1756711661
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b4c928089fdso4324722a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 00:27:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756711661; x=1757316461;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JSUiWIPMhwHs96b7ABTVTbCkzVoFmMpEwSL1Ss/Y85c=;
        b=h5LjpB/0FMBiGKoBP6BKPf85m+sAm3Kwbp2Va+nEh1iZQ3sywBVW6mBshkY/Cje1hp
         m8xxNWqQHxANvis3FuJBXa7YlSDYIRhT/in6h6VE3T12x3nKzRx2nQb9cMNgYJCiG32V
         vsTV2djI22C/eU2SqLiEX03BUYq33EHQDS5aRBz/Li5lPUIADmBUpQYlzAQzr69IQfKa
         6jJrur5q3N4KMrYztQM2o598Z0i6PVi9X6l09q905HaPxRKxqozByKPs/NbcnW8GK5US
         Nt8DIlXajUh7o7txaYVaROOLHyrpHu4IkyHVP3LvAvVX3U5vJw5c29qWwhd/DMLq/a/0
         SCqw==
X-Forwarded-Encrypted: i=1; AJvYcCVUjlnmkWH7ZBG+gXw0fmLj/P6Q82DX0/+D7LYbivEum4pCnVgiPnAkarcqXdb/NA2ShkXeajcjp6BqdKM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBzu3ISKdKDfOEzU02JVMvs15EJQz11fzzlOYvOKyB4dGKXKYq
	hkW6IPPCtNNXrlyOxigf+dvciQ1G9JnmmxTxJMmUBmDmeHR07iorEioaEOfSfeoLgixOceKMdKE
	xIFo3s3l5jWj8VKx7PyxvEyZowoQR1k6+ZYh3kyHVLXApnpD5iXG17gkBn0NiYmr2+qxEmIOnJl
	8mY5iykydzF1UY95e7YcmCyOgpEc0lfJUWzLPDg3H2
X-Gm-Gg: ASbGnctwIbtkvdsnPMhKQI5bT8V8NEOX3Npp8B+wP/c4V/JnmIj4M39U80hFrwmVFFQ
	idtICvoWin/extmUhKNlXu6BYTNztQM/FS0HySZdeIBuzjyQAur/wki5uLIA+60cgupNmHB36T3
	NNWMWPqVcMJHiLk6IBmvc=
X-Received: by 2002:a05:6a20:3d82:b0:243:a3a1:9d96 with SMTP id adf61e73a8af0-243d6dd4f41mr9903704637.6.1756711660941;
        Mon, 01 Sep 2025 00:27:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEJtQGCGbWY0bZdwpI+00f79bdidShp27UJNhnAdSujPUnIi4MoiPXZPPtyTIJ4UkjyEYRD082Miv9aaGATcW4=
X-Received: by 2002:a05:6a20:3d82:b0:243:a3a1:9d96 with SMTP id
 adf61e73a8af0-243d6dd4f41mr9903675637.6.1756711660568; Mon, 01 Sep 2025
 00:27:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250826112709.1051172-1-eperezma@redhat.com> <20250826112709.1051172-4-eperezma@redhat.com>
 <CACGkMEvUQeA8bgvMthjSAa4u0o3u7Sq3PDoRXTADa9e=c8G7uw@mail.gmail.com>
In-Reply-To: <CACGkMEvUQeA8bgvMthjSAa4u0o3u7Sq3PDoRXTADa9e=c8G7uw@mail.gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Mon, 1 Sep 2025 09:27:03 +0200
X-Gm-Features: Ac12FXwi-r7BfyYjc6Q_xkFKdMIpOyNdxDR-K3Gu6jhRooSOBB_LbDXz5uoGhI8
Message-ID: <CAJaqyWeNhEFK9Fh53sTNUENQqZJbeX1oiFc4AaSPDXtE0hNYFA@mail.gmail.com>
Subject: Re: [PATCH 3/6] vduse: return internal vq group struct as map token
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Cindy Lu <lulu@redhat.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Laurent Vivier <lvivier@redhat.com>, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Yongji Xie <xieyongji@bytedance.com>, 
	Maxime Coquelin <mcoqueli@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 1, 2025 at 4:26=E2=80=AFAM Jason Wang <jasowang@redhat.com> wro=
te:
>
> On Tue, Aug 26, 2025 at 7:27=E2=80=AFPM Eugenio P=C3=A9rez <eperezma@redh=
at.com> wrote:
> >
> > Return the internal struct that represents the vq group as virtqueue ma=
p
> > token, instead of the device.  This allows the map functions to access
> > the information per group.
> >
> > At this moment all the virtqueues share the same vq group, that only
> > can point to ASID 0.  This change prepares the infrastructure for actua=
l
> > per-group address space handling
> >
> > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > ---
> > v3:
> > * Make the vq groups a dynamic array to support an arbitrary number of
> >   them.
> > ---
> >  drivers/vdpa/vdpa_user/vduse_dev.c | 52 ++++++++++++++++++++++++------
> >  include/linux/virtio.h             |  6 ++--
> >  2 files changed, 46 insertions(+), 12 deletions(-)
> >
> > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_use=
r/vduse_dev.c
> > index 0f4e36dd167e..cdb3dc2b5e3f 100644
> > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > @@ -22,6 +22,7 @@
> >  #include <linux/uio.h>
> >  #include <linux/vdpa.h>
> >  #include <linux/nospec.h>
> > +#include <linux/virtio.h>
> >  #include <linux/vmalloc.h>
> >  #include <linux/sched/mm.h>
> >  #include <uapi/linux/vduse.h>
> > @@ -84,6 +85,10 @@ struct vduse_umem {
> >         struct mm_struct *mm;
> >  };
> >
> > +struct vduse_vq_group_int {
> > +       struct vduse_dev *dev;
> > +};
>
> Nit: I don't get the meaning of the "int" suffix.
>

It means "internal", but I don't think it is a great name so I'm ok
with changing it.


