Return-Path: <linux-kernel+bounces-734994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 809D4B08939
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 11:25:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F8D67AA249
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 09:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4048A289E05;
	Thu, 17 Jul 2025 09:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JyQFBiFC"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E17C5289356
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 09:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752744317; cv=none; b=le0/Se/K2mOCXWSiZC23CFj1pqqc5rJGlnfKtj0M36IPMMEG32LriV5bvITh3RqXWiqY9PExpvy7St0t6vo/inudsxgT8qQcYTCkVJ3rCkpmbt7VJPmR5wzGxF/N8MXe6b5U6mrJBTUiCS2YfhCkVgIQIFTpEkkXjRcmWWfo1xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752744317; c=relaxed/simple;
	bh=mUGblPwGliu3YzskON//m/UU7MFOS7s+Yue1Nej7KOI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sree7ZRVXBzCyPs0gClekud3/eAz8f0ZJWYPSLDwTXq7QOw5SX2obn/ZFUnkDjATlIt6ec6in3Yfcf/7+MvGeeQijlf2M2Ma6OhGxDrSpjTBk4QwARNFriS13o950/UfnKS9jM68drVvGWB2jNij3lv6q+0jYNEKoRGnYnPyviw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JyQFBiFC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752744314;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xqpFHXx++3EMATXriFPKJGfUd3A8yDTgA5DIK5OX6Jk=;
	b=JyQFBiFCG6AKhZxI1NllSyGrD2xUa5GCmFdtalFgMxLYMMIxzkSNuvu22bUBWpsGaunNfZ
	zfIm0htoVm82xdsUaawD9AKLohJWOaPPbnLPX8TYxFfhhKS+h4nGtSIgxJFN2OR9Godm6S
	DFyM/KM9Ux1CvTCsgsXJCu6JyguLhuQ=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-138-cy9d_7UUMv6HJJEJwsjFUA-1; Thu, 17 Jul 2025 05:25:13 -0400
X-MC-Unique: cy9d_7UUMv6HJJEJwsjFUA-1
X-Mimecast-MFC-AGG-ID: cy9d_7UUMv6HJJEJwsjFUA_1752744313
Received: by mail-yb1-f199.google.com with SMTP id 3f1490d57ef6-e8120bcaf21so948724276.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 02:25:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752744312; x=1753349112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xqpFHXx++3EMATXriFPKJGfUd3A8yDTgA5DIK5OX6Jk=;
        b=TiVHjR8Cxlj8fT8+I3GmSYpswsxKZCSSjoIve6EJGg3NuBOqm5d6xHi3Zcwl40pWBm
         u0t7o8YnStwbdUgPfhhd8rq5NxvxkFoHrBfyj3rceKX4LtX1EpJLempB+TqMsMSVPV69
         CFi5+aNOGz/jn/klDqGr1Pru7IlLQThnJztUF9eOzpdRB+wOd/A9Hw08DAXoENQSn1uK
         aVuAMJuhhk1p3j7DYmu43gYGTUgK9EeOV4zooGGuu/0voBRUGyGdgG5HQCQFaf8VOWcg
         b2RC5OGtquugaCqwgTlaFdDB1KB/r+Ec3qfil/ewktLr/goMafeYdoAANgVnMJ3NlFKp
         q/9A==
X-Forwarded-Encrypted: i=1; AJvYcCUCFjmdHvzPRGfkKVQk6jWK33/jJSJMnXV0BDhtJy/maPn0oZkw0JzNGFf13Y+LCk9d+GWTDDY+/KNBjpA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyGB1BzgZftS4RLhrim0Ejg5K64DzQ25TBiKCttVyUzfSubT3U
	61g3RsApeCxNDRvpTysG7s2OlFICzvq8JORpZAHKErx64gAy6ZpeRD3H3W3kOoZJ9tq2Vw86vEu
	a0LVxZwfg4J4l/CvqX0Rmjb0deKc2qwuJQZ8V4XDe/T2ZYEoMAO9XvqWko8Ky1gVgDoR5h1U3d5
	sEc75MzOkHfrV3Dk8sjanMUEYuOZMercxEoVSqk6R1v8AYIn1p660=
X-Gm-Gg: ASbGncvK+xbSAroOEU3dN8nPPJ8ZAZxU63jR55hXTvokZDIt374t952wxO3ThGDzvLr
	ZEF/BVWufJeoLBbeT+oh0A0Q1EWoeFITJO3l4KqE50BkGIu+KlIpWK4qcrcjgb3zdw2EDG4Eag5
	WRRfRs+mmmSzNEUZFfKr5G
X-Received: by 2002:a05:6902:2582:b0:e8b:d0e7:3ae4 with SMTP id 3f1490d57ef6-e8bd0e73bdcmr5202990276.22.1752744312278;
        Thu, 17 Jul 2025 02:25:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEsfTvkw1PSMXKHBxuokKzY5S7apDyUaHwD6BT79131/X481c8450D90mHNBs58p1agihhTtDodQFLemqkkQdo=
X-Received: by 2002:a05:6902:2582:b0:e8b:d0e7:3ae4 with SMTP id
 3f1490d57ef6-e8bd0e73bdcmr5202940276.22.1752744311654; Thu, 17 Jul 2025
 02:25:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250717090116.11987-1-will@kernel.org> <20250717090116.11987-2-will@kernel.org>
 <CACGkMEsoBj7aNXfCU7Zn=5yWnhvA7M8xhbucmt4fuPm31dQ1+w@mail.gmail.com>
In-Reply-To: <CACGkMEsoBj7aNXfCU7Zn=5yWnhvA7M8xhbucmt4fuPm31dQ1+w@mail.gmail.com>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Thu, 17 Jul 2025 11:25:00 +0200
X-Gm-Features: Ac12FXz6ffoOmDUY3dLdGfR0fllZrD7uhyzojK2JMGGErWflZ9rAZkbEOw8MTDA
Message-ID: <CAGxU2F6jSBM-VKU6vaojvBF_4zTWndmaQ4rFvLxds6gOPjXpcA@mail.gmail.com>
Subject: Re: [PATCH v4 1/9] vhost/vsock: Avoid allocating arbitrarily-sized SKBs
To: Jason Wang <jasowang@redhat.com>
Cc: Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org, 
	Keir Fraser <keirf@google.com>, Steven Moreland <smoreland@google.com>, 
	Frederick Mayle <fmayle@google.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	netdev@vger.kernel.org, virtualization@lists.linux.dev, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 17 Jul 2025 at 11:10, Jason Wang <jasowang@redhat.com> wrote:
>
> On Thu, Jul 17, 2025 at 5:01=E2=80=AFPM Will Deacon <will@kernel.org> wro=
te:
> >
> > vhost_vsock_alloc_skb() returns NULL for packets advertising a length
> > larger than VIRTIO_VSOCK_MAX_PKT_BUF_SIZE in the packet header. However=
,
> > this is only checked once the SKB has been allocated and, if the length
> > in the packet header is zero, the SKB may not be freed immediately.
>
> Can this be triggered from the guest? (I guess yes) Did we need to
> consider it as a security issue?

Yep, but then the packet would still be discarded later, and the
memory released, so it can only increase the pressure on allocation,
but the guest can still do so by sending packets for example on an
unopened port.

Stefano

>
> >
> > Hoist the size check before the SKB allocation so that an iovec larger
> > than VIRTIO_VSOCK_MAX_PKT_BUF_SIZE + the header size is rejected
> > outright. The subsequent check on the length field in the header can
> > then simply check that the allocated SKB is indeed large enough to hold
> > the packet.
> >
> > Cc: <stable@vger.kernel.org>
> > Fixes: 71dc9ec9ac7d ("virtio/vsock: replace virtio_vsock_pkt with sk_bu=
ff")
> > Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
> > Signed-off-by: Will Deacon <will@kernel.org>
> > ---
> >  drivers/vhost/vsock.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
> > index 802153e23073..66a0f060770e 100644
> > --- a/drivers/vhost/vsock.c
> > +++ b/drivers/vhost/vsock.c
> > @@ -344,6 +344,9 @@ vhost_vsock_alloc_skb(struct vhost_virtqueue *vq,
> >
> >         len =3D iov_length(vq->iov, out);
> >
> > +       if (len > VIRTIO_VSOCK_MAX_PKT_BUF_SIZE + VIRTIO_VSOCK_SKB_HEAD=
ROOM)
> > +               return NULL;
> > +
> >         /* len contains both payload and hdr */
> >         skb =3D virtio_vsock_alloc_skb(len, GFP_KERNEL);
> >         if (!skb)
> > @@ -367,8 +370,7 @@ vhost_vsock_alloc_skb(struct vhost_virtqueue *vq,
> >                 return skb;
> >
> >         /* The pkt is too big or the length in the header is invalid */
> > -       if (payload_len > VIRTIO_VSOCK_MAX_PKT_BUF_SIZE ||
> > -           payload_len + sizeof(*hdr) > len) {
> > +       if (payload_len + sizeof(*hdr) > len) {
> >                 kfree_skb(skb);
> >                 return NULL;
> >         }
> > --
> > 2.50.0.727.gbf7dc18ff4-goog
> >
>
> Thanks
>


