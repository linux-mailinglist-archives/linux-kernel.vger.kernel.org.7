Return-Path: <linux-kernel+bounces-862157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 67C5DBF48D8
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 05:56:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 07B214F4665
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 03:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E64521255A;
	Tue, 21 Oct 2025 03:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vc9OHc6K"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDCF7D515
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 03:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761018965; cv=none; b=SVBMoZvN2JSYOcZcz+c9g33qfTCiCnktDFFTomNc+boZ+YcZHv9n9axOOU9C7NN0BBSsaZf2amrjE2wEQCFM2kA4EjMgkTRwySA9+LnGHi791yqe0OJltd/Tx1M/cCYarbJx+eNTBryQD3/5uIPmkyuNwuTOt+BxL0v0Vtmw4Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761018965; c=relaxed/simple;
	bh=4HUYXzgmQuRrjki7cRVCC1qE1Gbl+EdMdBdgCdr4tB4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R4kIY776QsImDzHVQJRp4UE4OMI3JZQUYgSwoqW+aPHkOexM72aKBkdoGV71CpiPUTWMr9UkCgvAI37G2FvqypMEh5jQUuCuYJ3Pt4E7kYoFQ7lyQ7i5j/13enHi/2ccDYpNfM+e0A1Tgr6M4+TfVvy3AwyZTdm8EfBSL49aCes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Vc9OHc6K; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761018962;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5KXU9vMnHGXiyYsj72T8GiUMkynl1civeffeASc2+N0=;
	b=Vc9OHc6KvxPHiasi/xEXT9Zh6s6BVUAW249ZLWlxYTP2iSLjqByxUlYzkxY66RqJr+XygL
	qlrcfDo4D91ouclWi/OMuDAW3c3ZIm4tUgaujbi8AOlhzfR0d8dDagsjme2O8w6nh96GB9
	eQT3M+Sx/H2Fu0B4zKLbn+qRKy6usOs=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-184-Pf7W01dFPsq6VEDzxkYhGw-1; Mon, 20 Oct 2025 23:56:00 -0400
X-MC-Unique: Pf7W01dFPsq6VEDzxkYhGw-1
X-Mimecast-MFC-AGG-ID: Pf7W01dFPsq6VEDzxkYhGw_1761018960
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3307af9b55eso4221301a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 20:56:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761018959; x=1761623759;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5KXU9vMnHGXiyYsj72T8GiUMkynl1civeffeASc2+N0=;
        b=hqLH9wEbZt9KpsyLymA13hfEfO4iFUcpFq6zJDn/6lPG35CFw9vCF8SxiLt5JCiDww
         /AV+dBe3gL9R25qLr/wBVPYbwuStprJUC0LcquFxJZoAhGPQ70wh0FsbDnpnQx+B6SMt
         FLORWc/aJRqvlyh3y/MAsEwjvzfvHiNQpqXicKw50aoiOTJmAKVH4Tcgmx/5LQh/nqLo
         nPs0DsIfFpFExtBx41kg6iF+8fJnNUbd1wQ2AZLLdxQ9Z3kdVMscxPyE2UCAzYWZoIlj
         /9T95ru5LESFkIE4UxcpgQFz6o4oiIObaNV6nTY7uuJKn3cdVoDavpqXFsQ+eikUFUKe
         WSVQ==
X-Forwarded-Encrypted: i=1; AJvYcCXQWzVmsxDPTqktKm+IpjRIdcrmPRi0xc9uIeMOmhf2bdih0Bz6CXmj4vQcnZHPiz9hdJnBzEPqQfWqXvY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywjziv43++vNH5+ZnY4ZkpDEJ1LfNJXAYVe5wIOqepKmHQ7QnoN
	FJiWXCxqvv+Ky1HIeyWlTI663L+NG7fr0tYc+kgFBwN0St7Nm6eNNyUsvP+WI4f2YtAIGd8RgwT
	2c5gGME5DpcyNdashHANAlSiM8FjcBuKJil90rHWYyRNSBRI0nqy3PAYg3iN3Z6MFUUeH+Qminy
	Mf1+lWqrUQkE2PNf4Mip98tjTBupKGac5XArD/65VLYnZLvqguPJg=
X-Gm-Gg: ASbGnctf2N61nq/HZYERHSVvshVGzynHuQs8wdJWSQDz9XH3Fa/xd8bAULN3aQDFfaw
	64T/UCJELiCkSCRQqHtrBysIgmSBa97RFlmxKbut2RtF17mAi8/hDAvFVggrJY3YCcTfUB89DTQ
	91RfKVLeBvrGZUnUEJVa5H1s1GBXLK1LwbaY/rnMCzlj0V/guke7rS24Oy
X-Received: by 2002:a17:90b:2d83:b0:32e:5b07:15dd with SMTP id 98e67ed59e1d1-33bcf8628demr17715368a91.1.1761018959141;
        Mon, 20 Oct 2025 20:55:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH3ko8D1z3OJ5qSJ0J55ui+yDu4uUJ5mp94CSlL54NGBmQbOCI24DmW0qVUAn07/GKA7z8/0JZN7it7xIEXFkY=
X-Received: by 2002:a17:90b:2d83:b0:32e:5b07:15dd with SMTP id
 98e67ed59e1d1-33bcf8628demr17715342a91.1.1761018958629; Mon, 20 Oct 2025
 20:55:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251020071003.28834-1-jasowang@redhat.com> <20251020071003.28834-18-jasowang@redhat.com>
 <20251020121643-mutt-send-email-mst@kernel.org>
In-Reply-To: <20251020121643-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 21 Oct 2025 11:55:47 +0800
X-Gm-Features: AS18NWA6SRYqO_k2DCn6HEp5F2mH9mkSTsc-hdveTB2yX3aA9q3if-M-fNGhk9k
Message-ID: <CACGkMEtV89bDjVhNV6=eZz7T0SLi6+17sn2ORNEnBbtifQxN1A@mail.gmail.com>
Subject: Re: [PATCH V8 17/19] virtio_ring: factor out split indirect detaching logic
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 21, 2025 at 12:17=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com=
> wrote:
>
> On Mon, Oct 20, 2025 at 03:10:01PM +0800, Jason Wang wrote:
> > Factor out the split indirect descriptor detaching logic in order to
> > allow it to be reused by the in order support.
> >
> > Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > ---
> >  drivers/virtio/virtio_ring.c | 63 ++++++++++++++++++++----------------
> >  1 file changed, 35 insertions(+), 28 deletions(-)
> >
> > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.=
c
> > index c59e27e2ad68..0f07a6637acb 100644
> > --- a/drivers/virtio/virtio_ring.c
> > +++ b/drivers/virtio/virtio_ring.c
> > @@ -771,11 +771,42 @@ static bool virtqueue_kick_prepare_split(struct v=
ring_virtqueue *vq)
> >       return needs_kick;
> >  }
> >
> > +static void detach_indirect_split(struct vring_virtqueue *vq,
> > +                               unsigned int head)
> > +{
> > +     struct vring_desc_extra *extra =3D vq->split.desc_extra;
> > +     struct vring_desc *indir_desc =3D
> > +            vq->split.desc_state[head].indir_desc;
>
> why split this line?  it's not too long.
>

Fixed.

Thanks


