Return-Path: <linux-kernel+bounces-826478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AADA7B8EA1E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 02:48:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6551C1771C0
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 00:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63B273AC39;
	Mon, 22 Sep 2025 00:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XvoAO1wf"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42CC12CCDB
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 00:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758502097; cv=none; b=Vs7l3R/3KNMvwAsPjujbr2SGpDZuIjz3FVEordUN+cEnE725WHJVhhOBcdcoeBbXFxue+KH69HoSTzHqf+DY4x/SGxIHy7HUgyB4yx8vAz7K5VOfOEjFZTcdIlmn07UORbphcFGT607DAJiWse1hg3oQzFRf7yNpIgX0L3aWcE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758502097; c=relaxed/simple;
	bh=qVPCp62WxI+kbLKhs5z+BTZcbzSr+rBFRsXqbMc6F0g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qVvP0J7cz4yJFD7jwGjQr0l0UJF4wrHIZKe8cvpOSlJr3uKb2yi3A3SVR0ES3Jhu2xilSMER6AI84u5prrFdfbOYtGUwxE7C7H1KXV56341mDC/cTezqeInhZ/nqrJUPvo2Bs26XwPGlaedxCQ8PuYQ+TlDG8blv9zWHNLI5+80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XvoAO1wf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758502093;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LbPwmKep4da7lPYIc/oo7zqSVxp8j3jQIYQS30XuZPE=;
	b=XvoAO1wfH2ab8LO1I1zT5I1FjiAMjdVHxRDAx09/K8ARn23hPThFo99GHbjhN19WvQVOvO
	PDW1S6aGfNwHW3klhglr4MmfSQHddElbzn6ZEXlF9OM3BhhUy47Ex4h6X4Arb9WkSK9k1n
	TiJQY7TOI2Pat7IFTZ7vYANQYj/TNso=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-192-YjGbaDdrO6OYeL0duZPE5w-1; Sun, 21 Sep 2025 20:48:11 -0400
X-MC-Unique: YjGbaDdrO6OYeL0duZPE5w-1
X-Mimecast-MFC-AGG-ID: YjGbaDdrO6OYeL0duZPE5w_1758502088
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-32eb2b284e4so6449562a91.1
        for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 17:48:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758502088; x=1759106888;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LbPwmKep4da7lPYIc/oo7zqSVxp8j3jQIYQS30XuZPE=;
        b=tYPeGi0P63dDczsEgPeBQiZzu1xNd+s4z31R7NlNQFGUmBhyCza3l9yhj57T6BnM8s
         UbBYqJ9CW1X/q2Vf2xnD61ZlkPG8pS4Bs+rPOgYr3b4T4UC5yCAdWIxkQPAmm8cDZ3ZK
         pD4qzSsWWPZvP4JOZnjnJuL5h1O2TARM20Z9hEMEuCldsy+Q57eM8yiJjQiMpLrTEtCa
         Svw4v2yN5i4mv2F1Z6NhleVDUPMNFamgRdzTqlMSYR3TtP5D/KzwDiPVDdU0X1NnHcJz
         pc6PMhMv6SbQztVdoOU2XE/1lILjXXnhD6EArPcQlma7MsXZClD5r77aqKoyYuvXNlr4
         +xGw==
X-Forwarded-Encrypted: i=1; AJvYcCVqOXjWl7fYER+dstgsRipSDflVV5N0MgIYHlitd+Zv8Y46YCVWcUKf0CDKcnUBcvy2/+lULjFbEl/+NMY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4gjzaHOz76nfGuRA+qIrHBhI0Fe1p3EAfhRGCeMscnhgMCnlC
	+UBDVPBtK9sgzxE9IOuztwnpgpY2gZW6XhNJtboDOki7Klz01tDsBHsfwy4DuT33X8pZbIMvKdJ
	E1awtonGC+UKYkYGqcd4YRzxLv2RSaT3ezkvuoU5xEQ786kCiyzE8Ncwh0e4ftBltRAEn86o49y
	fn1PARDK+snZh2hWVmYy8QbA/QRk7jhMsbt6yQ9djCVS5SBGAwEx4=
X-Gm-Gg: ASbGncv3yrYPETupMj0bQCHC2vAXWRL6coG55zkxFrqiFQVTWMre8NBxXt5b3SyOiRZ
	fJgXcCfKPDs+w9nM9jeuJsNOksGwtRefME1sNEt76z4Vo+4+4dnoRmbFudUvqZ+3UoLGAwW2v0Q
	/tmlFiBj9lePfy6wbc5U5gMA==
X-Received: by 2002:a17:90b:5109:b0:32e:38b0:15f4 with SMTP id 98e67ed59e1d1-33097fdc40fmr12833051a91.7.1758502087817;
        Sun, 21 Sep 2025 17:48:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFkm5MDcRGeCr7nM+CSsyiG44BMWORo+SsipMUYwLJVGzVYlDRGII4SLozGaCEYUt93SA5qzvehujesp1OuAIg=
X-Received: by 2002:a17:90b:5109:b0:32e:38b0:15f4 with SMTP id
 98e67ed59e1d1-33097fdc40fmr12833035a91.7.1758502087416; Sun, 21 Sep 2025
 17:48:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250919073154.49278-1-jasowang@redhat.com> <20250919073154.49278-15-jasowang@redhat.com>
 <20250921134323-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250921134323-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 22 Sep 2025 08:47:54 +0800
X-Gm-Features: AS18NWBgmQjVtxf86n4hCuuhNQ_XkG6yIIQsnnd8doULk1KSD6QGgdlq07528fQ
Message-ID: <CACGkMEscRcBQVMUx1gNoWMQ7EUx6XE0-O0fgJm-8EUt96DrhGw@mail.gmail.com>
Subject: Re: [PATCH V6 14/19] virtio_ring: determine descriptor flags at one time
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 22, 2025 at 1:44=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com>=
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
>
> How does this make any sense?

Let me drop this unnecessary assignment.

Thanks.


