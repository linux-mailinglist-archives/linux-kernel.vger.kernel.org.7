Return-Path: <linux-kernel+bounces-826483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B16A4B8EA45
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 02:58:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8074C7A26B1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 00:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2ADF80C02;
	Mon, 22 Sep 2025 00:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R3Y8D6xs"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6118170810
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 00:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758502674; cv=none; b=CL7s+fV57EZ8iyEgCLnfVP9gU2ms4d4lJia/AHB5VSILp4kmyIlUKlRDWZ4q7YoaK6X7ypigOFpSKyZNQdBpnxx1YqYA3qA9YUtHIQUXaxdzEscWu9FMgJN0Rud8COGL09ul4KxzQAiuzL+Kvc53kGqzAsdiTkAaOhau87FXWkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758502674; c=relaxed/simple;
	bh=q1a/rF9kqp+ywaGF0ETTH/H1IBYzKKaVF5l0/SyOF1E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BL5A9cQyCnsTkW6nZgU7HG3NxYN1WvtuM1P3g7vEnjHbnT2d1uYxCyuZ7ZSihtxhI4gRX74EC9ru1tQHHx0OfIoDv8RVLeRiC2/8smuHu8pLEVZVp/0gbCkPlqhhTlGZJv2gmZfoOw7dsLgS88gPFxsz48g1gcjqX4tuzHX/oUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R3Y8D6xs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758502671;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iQSNgaae61Za8vLW581DDdncO8iG3z5YRux/p3d2ziM=;
	b=R3Y8D6xsV0hZNZqsvPAGm3ApbXKWLDUpbnj//+nSwakmmLbIwUqKPW9ELVHnQa0bPT0TD7
	Ja2jQ9JXuL8rGKaR0AHU29g07kNZKS0a7H9e3LHz0WI+cFJXAj5P+IpDmrIT8/1oN+S2gQ
	KqFtZzFZUSuCD7P8MPrK8A8VulcrY1M=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-331-8EgGUCufP_O9o7M3wNVFWw-1; Sun, 21 Sep 2025 20:57:49 -0400
X-MC-Unique: 8EgGUCufP_O9o7M3wNVFWw-1
X-Mimecast-MFC-AGG-ID: 8EgGUCufP_O9o7M3wNVFWw_1758502668
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b551338c2c9so2443481a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 17:57:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758502668; x=1759107468;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iQSNgaae61Za8vLW581DDdncO8iG3z5YRux/p3d2ziM=;
        b=I1n+kkiTBsyiI/HwSW7KYj4m9GXFopQXvmxcYdkYV1VHQXB5mb7l7kLWDfKWwe7lyf
         kYiwY5RrJVDcEc0wi8QmWPO9k2HFZCpQ/zKSYhLnEQRSV8rV5thmSKZQ6n5MbX/WlLx5
         o9jWiAWhL2xNF/l4a+5lpnX6DeT3qgGfgUATdSG49UMO0Kq9KdObbJIR8H6oG4xY+DJP
         2jUnNCqN/snMdd2KbUNLtLKCI/5rAT1Kiwfavl311AxhAmpcf1LO/nGLOiSM9Iy4APMv
         6WWCAmaxFNgnIpjlAiWCn6kforOKfB8HnnoS2m2/ICb5zWm5VARd5HTEoo3Cs0PxNZJy
         sJnQ==
X-Forwarded-Encrypted: i=1; AJvYcCViXjq6SzzLTHYjs45hQj/tjDKUF1vMU42t8+PVQ9kLsp7lBGQTf7h1TbH844cqp7HODjcggVPFThKmNNM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUfGr6ZvHsvmibB+DWFGcWofv/jSakfIQoda4nBCz4y/linPhK
	tWI5TNSnw8XK343uXK7zkP9eButWg13jrF1ZdABRF1A5eIdhaBzSULFnEWDoU7dtm19GReZzJJK
	Fuq7ZxmERo0UxePcpz0T70XsybfMkLt5PfeDEr5UCuoZLyUxROGUXNOamHoaAxEQmCBXTjqEWgI
	PCrd1N2wZH+ZXoFzmeJYP/CxrQLFMPLsz+Wr3RPuyc
X-Gm-Gg: ASbGncu8YGKL+8fqWyjJo+tmmoWCcAhx8QyCAr869evrDP5NW7I2wuUIEjK55nRVflX
	SY9NaPiEABk+UN0/x26Mr5aCo4czJ/N19At0SLEt+8ecmBsMGDXPAM6yYFh5L2H0bV4OKgsvsFs
	bggQsZwXHLXpp+AsJvArL+aA==
X-Received: by 2002:a17:90b:554e:b0:32e:52aa:3973 with SMTP id 98e67ed59e1d1-33097fd89a5mr13591197a91.8.1758502667959;
        Sun, 21 Sep 2025 17:57:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFimiupeszfxDl1f/QXKUz4vhoXfLyzRJkGhpVNaQabPzz9P4AzQ5hFNSeN3FbPYQBz1FxcnvxSZyfA54MBRcM=
X-Received: by 2002:a17:90b:554e:b0:32e:52aa:3973 with SMTP id
 98e67ed59e1d1-33097fd89a5mr13591182a91.8.1758502667532; Sun, 21 Sep 2025
 17:57:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250919073154.49278-1-jasowang@redhat.com> <20250919073154.49278-15-jasowang@redhat.com>
 <20250921143758-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250921143758-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 22 Sep 2025 08:57:36 +0800
X-Gm-Features: AS18NWBKlztoe7dgm271u-z7KWOwPlC8MLZ24xmqb66UvMbjUrQbQXRvJtEN_Rk
Message-ID: <CACGkMEuQ5XgrAftGAmufw0U0h1foVNh8f3b71J9_4Bmh2R1gyQ@mail.gmail.com>
Subject: Re: [PATCH V6 14/19] virtio_ring: determine descriptor flags at one time
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 22, 2025 at 2:40=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Fri, Sep 19, 2025 at 03:31:49PM +0800, Jason Wang wrote:
> > Let's determine the last descriptor by counting the number of sg. This
> > would be consistent with packed virtqueue implementation and ease the
> > future in-order implementation.
> >
> > Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > ---
> >  drivers/virtio/virtio_ring.c | 21 ++++++++-------------
> >  1 file changed, 8 insertions(+), 13 deletions(-)
> >
> > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.=
c
> > index 1045c553ee65..0949675a3d12 100644
> > --- a/drivers/virtio/virtio_ring.c
> > +++ b/drivers/virtio/virtio_ring.c
> > @@ -574,7 +574,7 @@ static inline int virtqueue_add_split(struct vring_=
virtqueue *vq,
> >       struct vring_desc_extra *extra;
> >       struct scatterlist *sg;
> >       struct vring_desc *desc;
> > -     unsigned int i, n, avail, descs_used, prev, err_idx;
> > +     unsigned int i, n, avail, descs_used, err_idx, c =3D 0;
> >       int head;
> >       bool indirect;
> >
> > @@ -631,6 +631,7 @@ static inline int virtqueue_add_split(struct vring_=
virtqueue *vq,
> >       }
> >
> >       for (n =3D 0; n < out_sgs; n++) {
> > +             sg =3D sgs[n];
> >               for (sg =3D sgs[n]; sg; sg =3D sg_next(sg)) {
> >                       dma_addr_t addr;
> >                       u32 len;
> > @@ -638,12 +639,12 @@ static inline int virtqueue_add_split(struct vrin=
g_virtqueue *vq,
> >                       if (vring_map_one_sg(vq, sg, DMA_TO_DEVICE, &addr=
, &len, premapped))
> >                               goto unmap_release;
> >
> > -                     prev =3D i;
> >                       /* Note that we trust indirect descriptor
> >                        * table since it use stream DMA mapping.
> >                        */
> >                       i =3D virtqueue_add_desc_split(vq, desc, extra, i=
, addr, len,
> > -                                                  VRING_DESC_F_NEXT,
> > +                                                  ++c =3D=3D total_sg =
?
> > +                                                  0 : VRING_DESC_F_NEX=
T,
>
> I would indent this line a bit more to the right - it is a continuation,
> after all.
>

Fixed.

Thanks


