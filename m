Return-Path: <linux-kernel+bounces-854303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 25C68BDE0AE
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 12:37:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 83C05502FE0
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 10:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4E8931960B;
	Wed, 15 Oct 2025 10:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="er+nhfbk"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2FA52DAFA9
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 10:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760524649; cv=none; b=S/nsmS787hQjVhH5oKHlDNMo+nW2obYSpfG6fm7fMgjKjSzXg92brnbGwtqX6+4HiHulGKVHyp1GLzl4bdNVzwBXgFZ07n/fYFBT+XQdi7q0Q0Ub0RF/txhjqRbDC4flhE7swjMD3jGXE2/ZtdHvVUU0/sFghKo6jsY9YC5VR/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760524649; c=relaxed/simple;
	bh=s2JXUbp0DYNFUksSB7dqNSV0t8IjpdOa3Cgcl2SjNIw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VnoBj8CcIvCoI0/L65ReAVecP/PLzta3r8sNyCB4LI5RIoDEBJaboy+ISmI39nV45DGEmK1W2kiOkRlEsQuFY3EtUzGK+QLBKxYbB/CtdeZ+eerMu3WMtzY+dx677mlyQQtSTht1IzHuI6imxgHdXMPCNEvp3l2OyS4eZVQ7KHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=er+nhfbk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760524646;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FJ5OI8qXcU6LeUOVXf33r3M+T7rLK5h6AAwB4S0iIqA=;
	b=er+nhfbkzp+2wF+IALE6RF1jyYAi9/3GM/DXYToRiDhNRcw78wvD4NaGhTCohC7OaxacxS
	EQRQOeAAFa6CoZIb+oz+1fy+3eQCSOWLoLPcH0kxQLPJFlorDb1Kv29v7OdBvOVSkYtLve
	6dbWMHSyeEjJoQ2fUfFSXnm+nmmkKjA=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-15-U1_x1af2MGa7aJjay_7FTA-1; Wed, 15 Oct 2025 06:37:25 -0400
X-MC-Unique: U1_x1af2MGa7aJjay_7FTA-1
X-Mimecast-MFC-AGG-ID: U1_x1af2MGa7aJjay_7FTA_1760524645
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-7815a21894aso15062617b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 03:37:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760524645; x=1761129445;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FJ5OI8qXcU6LeUOVXf33r3M+T7rLK5h6AAwB4S0iIqA=;
        b=GvY1LDdWqgzJFk6aYEJnmg9GxUPGy/kKCyD0xta80o3HVMeHuMWkvvxGex85muQHUB
         YCv1W5EUv2cnJ8ZZqLsSSu3ZjIdy3/410/2KLSHXrkVKePhvOu59UzKzlEj/mq0BQjhX
         EJ8NU0iYuNCqLBAY+JCmiEjcGxdSCncvntI11d9S8y7jZaWvQy8OrR7JqJylvdwghSzm
         +hoxbX+wN8ub65md3jg3Gzt3yWPbzGS/+0r9ZJOb3ptA7N19ifbggz6i5TLwjM3cR8mH
         7ty0OhXDyxvaf0vJHnFqFcpOTwZIYyh8gUbqUokH60LyB7LdS01WMfxdA9LpYqpPszvc
         ewFw==
X-Forwarded-Encrypted: i=1; AJvYcCXTZPjG6VnmTY3uhAmhO1FLpv3X7kVZAxLCI832oFZAm0Ok+ezmSMqJutYevyBkdLdWGavJLZt5VqqjqkY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNyGd3PCBoOh/wuCK9/0bPN1mw3ZaOzt3eqIRPXpVoW3CzfLAn
	Kkbr27wOlKQ+CUlrug984GxkkoMsLr4It8kIqJgHXVKyf1h23IJIUUwkS5bm4CWVUx3X1eccFft
	/vOBlecVT3GHr3/bxjqQ+r+rdMV5CiqFqpoGd8oyfmgoNXf6pU1K+ROKCbCsQho15PjWNG0XAvp
	7fYOB7ij/F5jXhjRt85IVtoSIvLZEVKqDFNYTNgjdc
X-Gm-Gg: ASbGncvRq7NS6Tg9YXZtKEPgEqX2yB1hrBkJF/unma0dFBb7e34KtZJ981npndagPFV
	w6+hXR7GhfOyziseZlG/6Oi17SXWPska4BXZY8gdTc5DomAF0kLMXk5fvTZyNhgPAoEKkTxN7NG
	pKoOxIyPTV5VPjLyoLpVjLFjbHW2RINPHOY0augWOGlxBtDFJt6Icq7o+dBItreIcptt4DavB3o
	5VxDVL8
X-Received: by 2002:a05:690e:2c7:b0:633:abda:fce3 with SMTP id 956f58d0204a3-63ccb903b26mr19292022d50.36.1760524644918;
        Wed, 15 Oct 2025 03:37:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHloSoTDh8INEPlDtU9jlkdkPn/64A75meFhRp+1C+3McE09pWuT2JMM/iqj80sCG6XNefZ+7vtFqlJL08FI4s=
X-Received: by 2002:a05:690e:2c7:b0:633:abda:fce3 with SMTP id
 956f58d0204a3-63ccb903b26mr19292009d50.36.1760524644411; Wed, 15 Oct 2025
 03:37:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251007130622.144762-2-eperezma@redhat.com> <20251014042459-mutt-send-email-mst@kernel.org>
 <CAO55cszGtuqL9qfs8SVB=Jjghefn=M0Rjw65f2DGPrjLQFFtqg@mail.gmail.com>
 <20251014051537-mutt-send-email-mst@kernel.org> <CAJaqyWe-mn4e+1egNCH+R1x4R7DB6U1SZ-mRAXYPTtA27hKCVA@mail.gmail.com>
 <20251015023020-mutt-send-email-mst@kernel.org> <CAJaqyWeiX1Tc77NcYoBbeVfKTeuKHK6hw=n_9Mk4y52k7Djr-g@mail.gmail.com>
 <20251015030313-mutt-send-email-mst@kernel.org> <CAJaqyWfRmhXM8eV+=wMVKgrc8SJ98OTtBCtNDJj8ZRUM5Y9Nmg@mail.gmail.com>
 <CAO55csx2rbjxEZk5K3aKcZ501KY3Zfs8ThEQHFqQ1ZB9RSXECA@mail.gmail.com> <20251015040722-mutt-send-email-mst@kernel.org>
In-Reply-To: <20251015040722-mutt-send-email-mst@kernel.org>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 15 Oct 2025 12:36:47 +0200
X-Gm-Features: AS18NWDZxVi03ZJg7QLo3y_kPBWfnIylCoy1tVOlO9_rzeDHCgU5F_37TTxyJKc
Message-ID: <CAJaqyWcf3tz17q6G=123Xb+warf8Ckg=PLaPkzLU9hYHiUy9Zg@mail.gmail.com>
Subject: Re: [RFC 1/2] virtio_net: timeout control virtqueue commands
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Maxime Coquelin <mcoqueli@redhat.com>, Yongji Xie <xieyongji@bytedance.com>, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Dragos Tatulea DE <dtatulea@nvidia.com>, jasowang@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 15, 2025 at 10:09=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com=
> wrote:
>
> On Wed, Oct 15, 2025 at 10:03:49AM +0200, Maxime Coquelin wrote:
> > On Wed, Oct 15, 2025 at 9:45=E2=80=AFAM Eugenio Perez Martin
> > <eperezma@redhat.com> wrote:
> > >
> > > On Wed, Oct 15, 2025 at 9:05=E2=80=AFAM Michael S. Tsirkin <mst@redha=
t.com> wrote:
> > > >
> > > > On Wed, Oct 15, 2025 at 08:52:50AM +0200, Eugenio Perez Martin wrot=
e:
> > > > > On Wed, Oct 15, 2025 at 8:33=E2=80=AFAM Michael S. Tsirkin <mst@r=
edhat.com> wrote:
> > > > > >
> > > > > > On Wed, Oct 15, 2025 at 08:08:31AM +0200, Eugenio Perez Martin =
wrote:
> > > > > > > On Tue, Oct 14, 2025 at 11:25=E2=80=AFAM Michael S. Tsirkin <=
mst@redhat.com> wrote:
> > > > > > > >
> > > > > > > > On Tue, Oct 14, 2025 at 11:14:40AM +0200, Maxime Coquelin w=
rote:
> > > > > > > > > On Tue, Oct 14, 2025 at 10:29=E2=80=AFAM Michael S. Tsirk=
in <mst@redhat.com> wrote:
> > > > > > > > > >
> > > > > > > > > > On Tue, Oct 07, 2025 at 03:06:21PM +0200, Eugenio P=C3=
=A9rez wrote:
> > > > > > > > > > > An userland device implemented through VDUSE could ta=
ke rtnl forever if
> > > > > > > > > > > the virtio-net driver is running on top of virtio_vdp=
a.  Let's break the
> > > > > > > > > > > device if it does not return the buffer in a longer-t=
han-assumible
> > > > > > > > > > > timeout.
> > > > > > > > > >
> > > > > > > > > > So now I can't debug qemu with gdb because guest dies :=
(
> > > > > > > > > > Let's not break valid use-cases please.
> > > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > Instead, solve it in vduse, probably by handling cvq wi=
thin
> > > > > > > > > > kernel.
> > > > > > > > >
> > > > > > > > > Would a shadow control virtqueue implementation in the VD=
USE driver work?
> > > > > > > > > It would ack systematically messages sent by the Virtio-n=
et driver,
> > > > > > > > > and so assume the userspace application will Ack them.
> > > > > > > > >
> > > > > > > > > When the userspace application handles the message, if th=
e handling fails,
> > > > > > > > > it somehow marks the device as broken?
> > > > > > > > >
> > > > > > > > > Thanks,
> > > > > > > > > Maxime
> > > > > > > >
> > > > > > > > Yes but it's a bit more convoluted  than just acking them.
> > > > > > > > Once you use the buffer you can get another one and so on
> > > > > > > > with no limit.
> > > > > > > > One fix is to actually maintain device state in the
> > > > > > > > kernel, update it, and then notify userspace.
> > > > > > > >
> > > > > > >
> > > > > > > I thought of implementing this approach at first, but it has =
two drawbacks.
> > > > > > >
> > > > > > > The first one: it's racy. Let's say the driver updates the MA=
C filter,
> > > > > > > VDUSE timeout occurs, the guest receives the fail, and then t=
he device
> > > > > > > replies with an OK. There is no way for the device or VDUSE t=
o update
> > > > > > > the driver.
> > > > > >
> > > > > > There's no timeout. Kernel can guarantee executing all requests=
.
> > > > > >
> > > > >
> > > > > I don't follow this. How should the VDUSE kernel module act if th=
e
> > > > > VDUSE userland device does not use the CVQ buffer then?
> > > >
> > > > First I am not sure a VQ is the best interface for talking to users=
pace.
> > > > But assuming yes - just avoid sending more data, send it later afte=
r
> > > > userspace used the buffer.
> > > >
> > >
> > > Let me take a step back, I think I didn't describe the scenario well =
enough.
> > >
> > > We have a VDUSE device, and then the same host is interacting with th=
e
> > > device through the virtio_net driver over virtio_vdpa.
> > >
> > > Then, the virtio_net driver sends a control command though its CVQ, s=
o
> > > it *takes the RTNL*. That command reaches the VDUSE CVQ.
> > >
> > > It does not matter if the VDUSE device in the userland processes the
> > > commands through a CVQ, reading the vduse character device, or anothe=
r
> > > system. The question is: what to do if the VDUSE device does not
> > > process that command in a timely manner? Should we just let the RTNL
> > > be taken forever?
> > >
> >
> > My understanding is that:
> > 1. Virtio-net sends a control messages, waits for reply
> > 2. VDUSE driver dequeues it, adds it to the SCVQ, replies OK to the CVQ
> > 3. Userspace application dequeues the message from the SCVQ
> >  a. If handling is successful it replies OK
> >  b. If handling fails, replies ERROR

If that's the case, everything would be ok now. In both cases, the
RTNL is held only by that time. The problem is when the VDUSE device
userland does not reply.

> > 4. VDUSE driver reads the reply
> >  a. if OK, do nothing
> >  b. if ERROR, mark the device as broken?
> >
> > This is simplified as it does not take into account SCVQ overflow if
> > the application is stuck.
> > If IIUC, Michael suggests to only enqueue a single message at the time
> > in the SVQ,
> > and bufferize the pending messages in the VDUSE driver.

But the RTNL keeps being held in all that process, isn't it?

>
> Not exactly bufferize, record.  E.g. we do not need to send
> 100 messages to enable/disable promisc mode - together they
> have no effect.
>

I still don't follow how that unlocks the RTNL. Let me put some workflows:

1) MAC_TABLE_SET, what can we do if:
The driver sets a set of MAC addresses, (A, B, C). VDUSE device does
send this set to the VDUSE userland device, as we don't have more
information. Now, the driver sends a new table with addresses (A, B,
D), but the device still didn't reply to the VDUSE driver.

VDUSE should track that the new state is (A, B, D), and then wait for
the previous request to be replied by the device? What should we
report to the driver? If we wait for the device to reply, we're in the
same situation regarding the RTNL.

Now we receive a new state (A, B, E). We haven't sent the (A, B, D),
so it is good to just replace the (A, B, D) with that. and send it
when (A, B, C) is completed with either success or failure.

2) VQ_PAIRS_SET

The driver starts with 1 vq pair. Now the driver sets 3 vq pairs, and
the VDUSE CVQ forwards the command. The driver still thinks that it is
using 1 vq pair. I can store that the driver request was 3, and it is
still in-flight. Now the timeout occurs, so the VDUSE device returns
fail to the driver, and the driver frees the vq regions etc. After
that, the device now replies OK. The memory that was sent as the new
vqs avail ring and descriptor ring now contains garbage, and it could
happen that the device start overriding unrelated memory.

Not even VQ_RESET protects against it as there is still a window
between the CMD set and the VQ reset.


