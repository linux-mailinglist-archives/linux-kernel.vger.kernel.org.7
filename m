Return-Path: <linux-kernel+bounces-862412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B63DBF5385
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 10:27:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DD45F4E3390
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 08:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E6F6302CB6;
	Tue, 21 Oct 2025 08:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZjwyKdGK"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3818257AEC
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 08:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761035246; cv=none; b=Es+7foVxBv2iQk3JZjQrBTXFqe05VBBCM9V2VSY50zPt7YgnoclOvcJCUx6u2+FBISEI3s2mO8J6/zDDZLggm8OfqqM4FJAY3x04QJUU1sx1INJx7a+TftnefA/8Q3wsGRN+lYwIB7ZqGghp867W81N7uj3wI3+nu7J2AWPquyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761035246; c=relaxed/simple;
	bh=t2mdVcUzy/XjJodPiuVo495NKZRMRDvPH2ytiObfVjs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WWxEXIZZ9hY9mJuD/2iBBrHz+4dmzxITxG6mAsuJxibcfXMD+FfTYP/nfK/8cH3HhegDnWZxud/TlfgDi3g5lTLLghDYb5uvpT9JsIPMbcNpcUQi4kXrKPbDEkZEBJ7KiINNU2YcFLQx0Cskb8mB1SH28r7hk30BLD67xbAcrFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZjwyKdGK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761035243;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L1e8p2ZQEtizyg+PS9dT60UpnUFBVXwHz4TUTukZ+CY=;
	b=ZjwyKdGKeXQw391QSsSbIDnRayj2Ukl0IdVjg557/qPnr3eQhMriOvfRV6D/mn2YcPiR6l
	5xIPZz9Anmba5Kn9B84qmBcalSVmKvFFV5KZeuZjT35mY8rOkNLr8E7oaBewbAFFvdemKH
	6haPt6B0Hz6R3ayAmlVe486sAQ/bWIw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-GePx_KbrOFWh24NQ9cozHQ-1; Tue, 21 Oct 2025 04:27:22 -0400
X-MC-Unique: GePx_KbrOFWh24NQ9cozHQ-1
X-Mimecast-MFC-AGG-ID: GePx_KbrOFWh24NQ9cozHQ_1761035241
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-46e4cb3e4deso19029625e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 01:27:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761035241; x=1761640041;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L1e8p2ZQEtizyg+PS9dT60UpnUFBVXwHz4TUTukZ+CY=;
        b=SWEAyN4UyogX2SjHZhwZioKoALbGQt2jV7QGidvQEJmDbVavOCxuNK7d/Vv7pgs+jA
         OPDPgeynFITyLZSOdq/b6gTHyMNhl1pRHjNqPzOOQNpJ9sdEw4Mj3lbVol2BEpb7EmEN
         k/6HK5LxAFIM+Dm30ZWrdSUMSkDq2FQZYFD3FEOskIX5vWTgX7JMrdrOO8Nx+nsn84mR
         yhHBCo0LHiqtzwtImLuZiQAdVS7E7oVHp5/qiI7Ssm+4yAzCSHyjANv16GLV4O7rypLp
         LiJW1UU+ZawUFPj4BUyNXRW0nJ8x3rv27uaKJ9MiY42SyfloD//nVQ3jd9stb3iPQca9
         6pTA==
X-Forwarded-Encrypted: i=1; AJvYcCU9te8CwIpJQOpTBJQQ+YK8pb8lCdTR2NyBPEX/3dNFd0ygG61xPirf2/v3llRnpciFzv7vBYdZcpH8toA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfL21TXrOXj9EFeLvUJPT+AKqdfDJsjU5W6kxNFkZDrYDCu5wO
	2MH3mdJq1Enop7ynXbzX8zOUyA+CfmEOL7Hv4+rnvkQwnsiyApvEt8v3kNz+yTRSD7lJky2MLip
	v/iRqDkBKAEMOcanih/VjsgDdgTwpe97/IL0fxWssX6FMxEQgGHbOlN9R87KuuPV/BA==
X-Gm-Gg: ASbGncs/H9mp7axDdbhllijl6K9BD/Ba1LJI6ajX+g018Diql1wHqCOfihW4Af+ncJ/
	0upUfmOX6VLGa16E6mGP2eGzjDBLM2JoEyQt3Xhzmh2BqxW5ov/aJDFWH1wD+jys7RWYG7ylzSA
	BGwgXSbF4ylvopbQstG03AHtXKl3bmudarp2+UDObJqre0Dvo80bmeizBGPZPHBRKJBUZt8YT+4
	gaCRUaz4ExWICBfw673bioqA1QDcTbUp/kw5krNYrQD5YR2el63z3PFUuio3uF187BR5Lda6i4u
	xbxRxE1ns9+MhC50C+seZzHukNcwfofN/FnZVzmMmwBzUn4IaMVFOW+4vrgeAeQASQ4/
X-Received: by 2002:a05:600c:8284:b0:46e:5302:7751 with SMTP id 5b1f17b1804b1-4711726487cmr123240825e9.9.1761035240890;
        Tue, 21 Oct 2025 01:27:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH322GIzHud8+Zk6YhVuSrk7l11dKyN5tL5ceBP4N2vRjXfS0GtBIlO+kW4owHEZHDfN1x6Nw==
X-Received: by 2002:a05:600c:8284:b0:46e:5302:7751 with SMTP id 5b1f17b1804b1-4711726487cmr123240655e9.9.1761035240467;
        Tue, 21 Oct 2025 01:27:20 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:152d:b200:2a90:8f13:7c1e:f479])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427f00ce678sm19391712f8f.51.2025.10.21.01.27.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 01:27:20 -0700 (PDT)
Date: Tue, 21 Oct 2025 04:27:17 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V8 18/19] virtio_ring: factor out split detaching logic
Message-ID: <20251021042325-mutt-send-email-mst@kernel.org>
References: <20251020071003.28834-1-jasowang@redhat.com>
 <20251020071003.28834-19-jasowang@redhat.com>
 <20251020111413-mutt-send-email-mst@kernel.org>
 <CACGkMEsRmkaBiU2WCQTepayhrhR18M1+bDQJXxTVxOUDG4sZyg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEsRmkaBiU2WCQTepayhrhR18M1+bDQJXxTVxOUDG4sZyg@mail.gmail.com>

On Tue, Oct 21, 2025 at 11:36:12AM +0800, Jason Wang wrote:
> On Mon, Oct 20, 2025 at 11:18 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Mon, Oct 20, 2025 at 03:10:02PM +0800, Jason Wang wrote:
> > > This patch factors out the split core detaching logic that could be
> > > reused by in order feature into a dedicated function.
> > >
> > > Acked-by: Eugenio Pérez <eperezma@redhat.com>
> > > Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > ---
> > >  drivers/virtio/virtio_ring.c | 18 ++++++++++++++----
> > >  1 file changed, 14 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > > index 0f07a6637acb..96d7f165ec88 100644
> > > --- a/drivers/virtio/virtio_ring.c
> > > +++ b/drivers/virtio/virtio_ring.c
> > > @@ -802,8 +802,9 @@ static void detach_indirect_split(struct vring_virtqueue *vq,
> > >       vq->split.desc_state[head].indir_desc = NULL;
> > >  }
> > >
> > > -static void detach_buf_split(struct vring_virtqueue *vq, unsigned int head,
> > > -                          void **ctx)
> > > +static unsigned detach_buf_split_in_order(struct vring_virtqueue *vq,
> > > +                                       unsigned int head,
> > > +                                       void **ctx)
> >
> >
> > Well not really _inorder, right? This is a common function.
> 
> Yes, but inorder is a subset for ooo so I use this name.

Can't say it is consistent. I suggest for example:
	_in_order -> specific to in order
	_ooo -> specific to ooo
	no suffix - common

or some other scheme where it's clear which is which.



> > You want to call it __detach_buf_split or something maybe.
> >
> > Additionally the very first line in there is:
> >
> >         __virtio16 nextflag = cpu_to_virtio16(vq->vq.vdev, VRING_DESC_F_NEXT);
> >
> > and the byte swap is not needed for inorder.
> 
> I don't see why?

To be more precise we do need a swap we do not need it
conditional.


No, I mean inorder is a modern only feature. So we do not
need a branch in the inorder path,
you can use __cpu_to_virtio16 with true flag,
not cpu_to_virtio16.

> > you could just do __cpu_to_virtio16(true, VRING_DESC_F_NEXT)
> 
> Probably you mean a leftover for hardening? E.g should we check
> desc_extra.flag instead of desc.flag here?
> 
> while (vq->split.vring.desc[i].flags & nextflag) {
>                 vring_unmap_one_split(vq, &extra[i]);
>         i = vq->split.desc_extra[i].next;
>                 vq->vq.num_free++;
>         }
> 
> Thanks

If it is not exploitable we do not care.

-- 
MST


