Return-Path: <linux-kernel+bounces-864754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68044BFB77F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 12:52:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76FF5189B12A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 10:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19041287257;
	Wed, 22 Oct 2025 10:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jx0P1wwR"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E99328616
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 10:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761130295; cv=none; b=kUdfOo/9KG/T+f3SDP3IjAuEyeYq65oZgzHNJdWroT2WeVGlbhQidpL4reBC5sqSF61QkZQiKmRJd4fALobB4sQj8TadvXkUPP1GNjHN1a0cD4qR6wWYJsoyfkZsde63Sf83LygUrt8awao0TsUdU+/8d0/JxBATA69yzbgLJH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761130295; c=relaxed/simple;
	bh=nzxbEL4AcQMNjHK7ByACa2aHjRwYFCQRxVz5WkGTbns=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kXMqX+fWDr2X+fFA+hiA5D9BNVv1HFj0EYHhI9ak1cy+KBJKIT28kYqGzDGckwa0BzE7BpAnOyayGY09iA28F6LJTN4APXAsUkAxthx5mu0tmrzrlmLOCqx/lpK0QEVZpXJRL71bDzhQ8YXaSxvKnzyXgfBNNsJSTUnHhl/amLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Jx0P1wwR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761130292;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q35xvr5tfCYnwPls/gsk4lxNICURyGN0ynUpd7YxlEE=;
	b=Jx0P1wwRaDBr5KqMgnrXAf8spJQBg3gYQoOF+kkYsLVJCTC8u0E4fmShStEVJMjJrrA2Ye
	YGALUDwo5BMYCJ+ie+m4Km1kA0+TBcuYCuHkfu7Ho9X7SHm45At5TWfD8vPdZ1ZwP9Dp3b
	Od0W1cZN+iFjAhbz6rK9L/Lyrrte1OQ=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-pYRkbPV9Oiq29fsOeG0FXw-1; Wed, 22 Oct 2025 06:51:31 -0400
X-MC-Unique: pYRkbPV9Oiq29fsOeG0FXw-1
X-Mimecast-MFC-AGG-ID: pYRkbPV9Oiq29fsOeG0FXw_1761130290
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-780d2956a2fso80883967b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 03:51:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761130290; x=1761735090;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q35xvr5tfCYnwPls/gsk4lxNICURyGN0ynUpd7YxlEE=;
        b=fPrMznYW5vIu7wycUxc8fFXEhl8SY99Yr5s2N/WcwzL7yoBJWtCZEG4CHC8xQw28oX
         JRRAbtd6WGZI/vHvGLaNB8NuB4N+QCaeJCgI2m0B9eVYm7SNWgFkIN7ZDT0/s6OYu1BE
         GjhCX5ECEUHBauIWNMxvBvTUDcOEBTm9iVdqQC5q3hBr5jK4/Ud94wjCtQXl7D3QwUcc
         WpY2JVmmx55Ti6nP/+vekrN886s440LcqVVBwYzBNk7FEMaW4Hj+FLXLDISXrP0Ha1Ba
         iZQ5OrGLOKzn87Hu/H/xCupc1pBG/QGZKthJ3y676bhD0mz+rllf1S7iKCzzXfh0l07w
         ul3w==
X-Forwarded-Encrypted: i=1; AJvYcCUpzyzsKAC8EVb2HEJXnqpQwpNranZ7OFxJ+RUM/vK/OAHLKauy1JaoQmxBrwLrZkeKpA7LJyUZjGS0bsA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFHbXiq1WBjhTz/dlOAnXMW3olBY3//nMeX/pUkgSBOiUytqx8
	DTEzuPNXHZNVUuVg+uPbxEzYQgRrrY4hBQSEEmF7dDwSk7vuY2YvI9az5e1PyDa8NMkFIbsf0mZ
	syYXwIrpstYM/VloZ0K+2+vIiV0rlFeyMR9RXWAoNv7nSEut0U/hi14L12IsFCaLiu5P1XzUWhP
	buJ66GOKnwf2pumTu92CHzQzJyq7vw+Hj0fvR0HIO0
X-Gm-Gg: ASbGnctZAR2FCqQdkYp8kuA25dztdfCSAq5UU9Bsa7sPUBcPTDdeuRCC2geOcbDW9TH
	i6G3KEdfYZdAmMAdFkehzH75OHsaLHwJ8Q9BoGeOo6oS6fH33oDPI3uQ2l3uPSXJDwqDkyncx+x
	nI/d6tDHczDPTz7zhcBfHe62m3qdvwyvejFNm1hVvwv1Z2Eon1Ef42b4TbRFrSLbL5wcvKbhs9h
	e9SWViXebk9+O+H0SdoVPrphGrckeh3kDr7S4BQT9E=
X-Received: by 2002:a53:cf10:0:b0:63d:ec38:cbf1 with SMTP id 956f58d0204a3-63e1619835cmr13133339d50.24.1761130290395;
        Wed, 22 Oct 2025 03:51:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEELxoVIm7xswDMnDDsuMUiqpogk+Sg3oLnoeZgSqCBu4zLreSrlb93TQ+pzj1vr8XL6XrkdISmauTcvrtBouo=
X-Received: by 2002:a53:cf10:0:b0:63d:ec38:cbf1 with SMTP id
 956f58d0204a3-63e1619835cmr13133329d50.24.1761130290032; Wed, 22 Oct 2025
 03:51:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAO55cszGtuqL9qfs8SVB=Jjghefn=M0Rjw65f2DGPrjLQFFtqg@mail.gmail.com>
 <20251014051537-mutt-send-email-mst@kernel.org> <CAJaqyWe-mn4e+1egNCH+R1x4R7DB6U1SZ-mRAXYPTtA27hKCVA@mail.gmail.com>
 <20251015023020-mutt-send-email-mst@kernel.org> <CAJaqyWeiX1Tc77NcYoBbeVfKTeuKHK6hw=n_9Mk4y52k7Djr-g@mail.gmail.com>
 <20251015030313-mutt-send-email-mst@kernel.org> <CAJaqyWfRmhXM8eV+=wMVKgrc8SJ98OTtBCtNDJj8ZRUM5Y9Nmg@mail.gmail.com>
 <CAO55csx2rbjxEZk5K3aKcZ501KY3Zfs8ThEQHFqQ1ZB9RSXECA@mail.gmail.com>
 <20251015040722-mutt-send-email-mst@kernel.org> <CAJaqyWcf3tz17q6G=123Xb+warf8Ckg=PLaPkzLU9hYHiUy9Zg@mail.gmail.com>
 <20251022060748-mutt-send-email-mst@kernel.org>
In-Reply-To: <20251022060748-mutt-send-email-mst@kernel.org>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 22 Oct 2025 12:50:53 +0200
X-Gm-Features: AS18NWBqn7RiZH4H5vYn4Th5IRh0pRKsIsyhfTpJEICFBEiy1e_vabuDQNUZNdo
Message-ID: <CAJaqyWdRN3C1nOHQjWroBPWKjc5efNfVbecpruL=Cgsk6i1FXg@mail.gmail.com>
Subject: Re: [RFC 1/2] virtio_net: timeout control virtqueue commands
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Maxime Coquelin <mcoqueli@redhat.com>, Yongji Xie <xieyongji@bytedance.com>, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Dragos Tatulea DE <dtatulea@nvidia.com>, jasowang@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 22, 2025 at 12:09=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com=
> wrote:
>
> On Wed, Oct 15, 2025 at 12:36:47PM +0200, Eugenio Perez Martin wrote:
> > On Wed, Oct 15, 2025 at 10:09=E2=80=AFAM Michael S. Tsirkin <mst@redhat=
.com> wrote:
> > >
> > > On Wed, Oct 15, 2025 at 10:03:49AM +0200, Maxime Coquelin wrote:
> > > > On Wed, Oct 15, 2025 at 9:45=E2=80=AFAM Eugenio Perez Martin
> > > > <eperezma@redhat.com> wrote:
> > > > >
> > > > > On Wed, Oct 15, 2025 at 9:05=E2=80=AFAM Michael S. Tsirkin <mst@r=
edhat.com> wrote:
> > > > > >
> > > > > > On Wed, Oct 15, 2025 at 08:52:50AM +0200, Eugenio Perez Martin =
wrote:
> > > > > > > On Wed, Oct 15, 2025 at 8:33=E2=80=AFAM Michael S. Tsirkin <m=
st@redhat.com> wrote:
> > > > > > > >
> > > > > > > > On Wed, Oct 15, 2025 at 08:08:31AM +0200, Eugenio Perez Mar=
tin wrote:
> > > > > > > > > On Tue, Oct 14, 2025 at 11:25=E2=80=AFAM Michael S. Tsirk=
in <mst@redhat.com> wrote:
> > > > > > > > > >
> > > > > > > > > > On Tue, Oct 14, 2025 at 11:14:40AM +0200, Maxime Coquel=
in wrote:
> > > > > > > > > > > On Tue, Oct 14, 2025 at 10:29=E2=80=AFAM Michael S. T=
sirkin <mst@redhat.com> wrote:
> > > > > > > > > > > >
> > > > > > > > > > > > On Tue, Oct 07, 2025 at 03:06:21PM +0200, Eugenio P=
=C3=A9rez wrote:
> > > > > > > > > > > > > An userland device implemented through VDUSE coul=
d take rtnl forever if
> > > > > > > > > > > > > the virtio-net driver is running on top of virtio=
_vdpa.  Let's break the
> > > > > > > > > > > > > device if it does not return the buffer in a long=
er-than-assumible
> > > > > > > > > > > > > timeout.
> > > > > > > > > > > >
> > > > > > > > > > > > So now I can't debug qemu with gdb because guest di=
es :(
> > > > > > > > > > > > Let's not break valid use-cases please.
> > > > > > > > > > > >
> > > > > > > > > > > >
> > > > > > > > > > > > Instead, solve it in vduse, probably by handling cv=
q within
> > > > > > > > > > > > kernel.
> > > > > > > > > > >
> > > > > > > > > > > Would a shadow control virtqueue implementation in th=
e VDUSE driver work?
> > > > > > > > > > > It would ack systematically messages sent by the Virt=
io-net driver,
> > > > > > > > > > > and so assume the userspace application will Ack them=
.
> > > > > > > > > > >
> > > > > > > > > > > When the userspace application handles the message, i=
f the handling fails,
> > > > > > > > > > > it somehow marks the device as broken?
> > > > > > > > > > >
> > > > > > > > > > > Thanks,
> > > > > > > > > > > Maxime
> > > > > > > > > >
> > > > > > > > > > Yes but it's a bit more convoluted  than just acking th=
em.
> > > > > > > > > > Once you use the buffer you can get another one and so =
on
> > > > > > > > > > with no limit.
> > > > > > > > > > One fix is to actually maintain device state in the
> > > > > > > > > > kernel, update it, and then notify userspace.
> > > > > > > > > >
> > > > > > > > >
> > > > > > > > > I thought of implementing this approach at first, but it =
has two drawbacks.
> > > > > > > > >
> > > > > > > > > The first one: it's racy. Let's say the driver updates th=
e MAC filter,
> > > > > > > > > VDUSE timeout occurs, the guest receives the fail, and th=
en the device
> > > > > > > > > replies with an OK. There is no way for the device or VDU=
SE to update
> > > > > > > > > the driver.
> > > > > > > >
> > > > > > > > There's no timeout. Kernel can guarantee executing all requ=
ests.
> > > > > > > >
> > > > > > >
> > > > > > > I don't follow this. How should the VDUSE kernel module act i=
f the
> > > > > > > VDUSE userland device does not use the CVQ buffer then?
> > > > > >
> > > > > > First I am not sure a VQ is the best interface for talking to u=
serspace.
> > > > > > But assuming yes - just avoid sending more data, send it later =
after
> > > > > > userspace used the buffer.
> > > > > >
> > > > >
> > > > > Let me take a step back, I think I didn't describe the scenario w=
ell enough.
> > > > >
> > > > > We have a VDUSE device, and then the same host is interacting wit=
h the
> > > > > device through the virtio_net driver over virtio_vdpa.
> > > > >
> > > > > Then, the virtio_net driver sends a control command though its CV=
Q, so
> > > > > it *takes the RTNL*. That command reaches the VDUSE CVQ.
> > > > >
> > > > > It does not matter if the VDUSE device in the userland processes =
the
> > > > > commands through a CVQ, reading the vduse character device, or an=
other
> > > > > system. The question is: what to do if the VDUSE device does not
> > > > > process that command in a timely manner? Should we just let the R=
TNL
> > > > > be taken forever?
> > > > >
> > > >
> > > > My understanding is that:
> > > > 1. Virtio-net sends a control messages, waits for reply
> > > > 2. VDUSE driver dequeues it, adds it to the SCVQ, replies OK to the=
 CVQ
> > > > 3. Userspace application dequeues the message from the SCVQ
> > > >  a. If handling is successful it replies OK
> > > >  b. If handling fails, replies ERROR
> >
> > If that's the case, everything would be ok now. In both cases, the
> > RTNL is held only by that time. The problem is when the VDUSE device
> > userland does not reply.
> >
> > > > 4. VDUSE driver reads the reply
> > > >  a. if OK, do nothing
> > > >  b. if ERROR, mark the device as broken?
> > > >
> > > > This is simplified as it does not take into account SCVQ overflow i=
f
> > > > the application is stuck.
> > > > If IIUC, Michael suggests to only enqueue a single message at the t=
ime
> > > > in the SVQ,
> > > > and bufferize the pending messages in the VDUSE driver.
> >
> > But the RTNL keeps being held in all that process, isn't it?
> >
> > >
> > > Not exactly bufferize, record.  E.g. we do not need to send
> > > 100 messages to enable/disable promisc mode - together they
> > > have no effect.
> > >
> >
> > I still don't follow how that unlocks the RTNL. Let me put some workflo=
ws:
> >
> > 1) MAC_TABLE_SET, what can we do if:
> > The driver sets a set of MAC addresses, (A, B, C). VDUSE device does
> > send this set to the VDUSE userland device, as we don't have more
> > information. Now, the driver sends a new table with addresses (A, B,
> > D), but the device still didn't reply to the VDUSE driver.
> >
> > VDUSE should track that the new state is (A, B, D), and then wait for
> > the previous request to be replied by the device? What should we
> > report to the driver?
>
> you reply OK to the driver immediately.
>

Let me switch to MQ as I think it illustrates the point better.

IIUC the workflow:
a) virtio-net sends MQ_VQ_PAIRS_SET 2 to the device
b) VDUSE CVQ sends ok to the virtio-net driver
c) VDUSE CVQ sends the command to the VDUSE device
d) Now the virtio-net driver sends virtio-net sends MQ_VQ_PAIRS_SET 1
e) VDUSE CVQ sends ok to the virtio-net driver

The device didn't process the MQ_VQ_PAIRS_SET 1 command at this point,
so it potentially uses the second rx queue. But, by the standard:

The device MUST NOT queue packets on receive queues greater than
virtqueue_pairs once it has placed the VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET
command in a used buffer.

So the driver does not expect rx buffers on that queue at all. From
the driver's POV, the device is invalid, and it could mark it as
broken.

And, what's worse, how to handle it if the device now replies with
VIRTIO_NET_ERR to the VDUSE CVQ?

> > If we wait for the device to reply, we're in the
> > same situation regarding the RTNL.
> >
> > Now we receive a new state (A, B, E). We haven't sent the (A, B, D),
> > so it is good to just replace the (A, B, D) with that. and send it
> > when (A, B, C) is completed with either success or failure.
> >
> > 2) VQ_PAIRS_SET
> >
> > The driver starts with 1 vq pair. Now the driver sets 3 vq pairs, and
> > the VDUSE CVQ forwards the command. The driver still thinks that it is
> > using 1 vq pair. I can store that the driver request was 3, and it is
> > still in-flight. Now the timeout occurs, so the VDUSE device returns
> > fail to the driver, and the driver frees the vq regions etc. After
> > that, the device now replies OK. The memory that was sent as the new
> > vqs avail ring and descriptor ring now contains garbage, and it could
> > happen that the device start overriding unrelated memory.
> >
> > Not even VQ_RESET protects against it as there is still a window
> > between the CMD set and the VQ reset.
>
> Timeouts should be up to userspace. If userspace times out
> and then gets confused, kernel is not to blame.
>
>

I meant the virtio-net driver will be confused.


