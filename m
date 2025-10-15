Return-Path: <linux-kernel+bounces-854000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 07313BDD4DC
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 10:04:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8AB524EE0ED
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 08:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42F362D2495;
	Wed, 15 Oct 2025 08:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FOOJPlvR"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8DF2C21F7
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 08:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760515446; cv=none; b=fT3ncrH8/+gchnQRXUs2b7QK2TSa1KgXMdYcHWjGevE8vM5HumhgtAK9ykOZg2FL29xjW7SshMvrWmIc3dISM3JhCF/5z/MlnRrJfnLJPACW47zhVLmu2X7OytVgaxCfyvfEPoQKOqWdrKPTcfzaoSq0JmZpfxhfjyBPW2Tgb/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760515446; c=relaxed/simple;
	bh=vpVIYC+QuXykroOmjVEM4y8l5atcwna28pGVIgjZF24=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kEUvKyJwOSBDf6cnIm0bJTDCFp9TEBDaeyJfZ3MPryzgW+AUYWyVko7YXNWAiIWiSJrwl1VYyD9VWhryuBP6cpjIGcACKam7pqDBldIU6Sce02hx0z4v6+NDZxIK8xZRJmWyyFg1grRnZfbYYYQcTjyXzqm7ky/sTezwyW0Km8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FOOJPlvR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760515443;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yXWohRz8B1VQgrvQtaHmJQvIEqtr1FgUvdL7GWQSIqI=;
	b=FOOJPlvRKrz8qcZdpkaNkeCAfVLmuRrnPXJQF8Mxp1/t5itUoiCaC5xVC8jVHuf1Kg1Otb
	vIsjULPOTl5hFuw9B7VSSfZWhviMmLWv1lHSPNwd2zJPbCJ7vu+iiCeoDwex5wy4lOBqMP
	k22jGxZwLf0nF+oxiZwuqc9Inly9JoA=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-427--UZHjMggPKSnDqrIUrdavQ-1; Wed, 15 Oct 2025 04:04:02 -0400
X-MC-Unique: -UZHjMggPKSnDqrIUrdavQ-1
X-Mimecast-MFC-AGG-ID: -UZHjMggPKSnDqrIUrdavQ_1760515441
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-336a6070642so23568661fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 01:04:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760515441; x=1761120241;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yXWohRz8B1VQgrvQtaHmJQvIEqtr1FgUvdL7GWQSIqI=;
        b=AyV8HqPvKsE1rOjubDfrt7FxNgeVslaLm0RexvaqQMSMmp6PSjw8uvh69ht8nQRBOE
         QBKJrDugwmrEsc0BvIetJ+wBSLajDt1gBkbJSsY97jEvrS7XblztqK022fVOfN5xfUYa
         /6CHpzNk1Dai2Qb1/mNRMCyypw09j+ARmOxWyYa8P+ef5F39ZDyAGslNneXkKAJEjadh
         DI/P0mDwdIW6BAvGiv5H0T451RSfIEbqOcHx1InwPXd4QqUVxlN12zTiWF5OwrkpdFeL
         lnhlXfrvX6DTyyw9ZhFeNXq/rcWi/26bJJPfjr/ILbAgA/dv3g32wRG/Ijneq5Nc+jF5
         K3Yg==
X-Forwarded-Encrypted: i=1; AJvYcCWe/oCoJDShuVuWwoZttU2ZQYVpKhVOeTaB0sib5pVeeKBT4iNquU/DO5aLdLuUaWtj78uT+BGPoh+ZlOs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRKguPVzAVLCDWJ2vPl40uR4qg5/ZZt6BqPHcZjLdtYyhHZ6QR
	fPxTKJJt9gZnY0nMykYW4HmjrKPONvYpFFNctyRy+Ltt3suwbhEBaJiU1mvT9C+DYOk8AmuBVbE
	STchSQPvLdssdSsINAUKcc2KXXdhyhzjitqNyJBsOpVUdPY8gZ4cYy7a/E2davLGlFaDfXJaTvl
	12/Ew17DXuHZrYrkIZFUwgu9EUEX1z39hwMGEAemFf
X-Gm-Gg: ASbGncvJLnZ8FNtQeVbrwq1RdKrN2yRj3Z31k3o9RDWmQvvxRywRdqgUvlhYymF4C+b
	Vml4P5Q04d8Z5qQBPWycZXwXpjK+Fn7miKa14K2o5NHo98+wHsEvSdtz10pvJwlqm4CZ0G3IOLx
	nQavopUaKrtYWjdvJZ2Wg=
X-Received: by 2002:a05:651c:1989:b0:36c:ebb0:821c with SMTP id 38308e7fff4ca-37609cc1c2dmr68184421fa.7.1760515440733;
        Wed, 15 Oct 2025 01:04:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGhU0DJPeVcVT2z0ZwoZKfqqQFiuVox9UrFqoWa0xY+/waqQcEh5FRk9TdO7Bs50oicZeyV3Es9MhjTHRog7TU=
X-Received: by 2002:a05:651c:1989:b0:36c:ebb0:821c with SMTP id
 38308e7fff4ca-37609cc1c2dmr68184291fa.7.1760515440268; Wed, 15 Oct 2025
 01:04:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251007130622.144762-1-eperezma@redhat.com> <20251007130622.144762-2-eperezma@redhat.com>
 <20251014042459-mutt-send-email-mst@kernel.org> <CAO55cszGtuqL9qfs8SVB=Jjghefn=M0Rjw65f2DGPrjLQFFtqg@mail.gmail.com>
 <20251014051537-mutt-send-email-mst@kernel.org> <CAJaqyWe-mn4e+1egNCH+R1x4R7DB6U1SZ-mRAXYPTtA27hKCVA@mail.gmail.com>
 <20251015023020-mutt-send-email-mst@kernel.org> <CAJaqyWeiX1Tc77NcYoBbeVfKTeuKHK6hw=n_9Mk4y52k7Djr-g@mail.gmail.com>
 <20251015030313-mutt-send-email-mst@kernel.org> <CAJaqyWfRmhXM8eV+=wMVKgrc8SJ98OTtBCtNDJj8ZRUM5Y9Nmg@mail.gmail.com>
In-Reply-To: <CAJaqyWfRmhXM8eV+=wMVKgrc8SJ98OTtBCtNDJj8ZRUM5Y9Nmg@mail.gmail.com>
From: Maxime Coquelin <mcoqueli@redhat.com>
Date: Wed, 15 Oct 2025 10:03:49 +0200
X-Gm-Features: AS18NWAl5_ajgWsgU8LCHBFRWWZaGW7vNOkzRONDWy-hOfTBe0S7p4M1TJ9202c
Message-ID: <CAO55csx2rbjxEZk5K3aKcZ501KY3Zfs8ThEQHFqQ1ZB9RSXECA@mail.gmail.com>
Subject: Re: [RFC 1/2] virtio_net: timeout control virtqueue commands
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Yongji Xie <xieyongji@bytedance.com>, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Dragos Tatulea DE <dtatulea@nvidia.com>, jasowang@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 15, 2025 at 9:45=E2=80=AFAM Eugenio Perez Martin
<eperezma@redhat.com> wrote:
>
> On Wed, Oct 15, 2025 at 9:05=E2=80=AFAM Michael S. Tsirkin <mst@redhat.co=
m> wrote:
> >
> > On Wed, Oct 15, 2025 at 08:52:50AM +0200, Eugenio Perez Martin wrote:
> > > On Wed, Oct 15, 2025 at 8:33=E2=80=AFAM Michael S. Tsirkin <mst@redha=
t.com> wrote:
> > > >
> > > > On Wed, Oct 15, 2025 at 08:08:31AM +0200, Eugenio Perez Martin wrot=
e:
> > > > > On Tue, Oct 14, 2025 at 11:25=E2=80=AFAM Michael S. Tsirkin <mst@=
redhat.com> wrote:
> > > > > >
> > > > > > On Tue, Oct 14, 2025 at 11:14:40AM +0200, Maxime Coquelin wrote=
:
> > > > > > > On Tue, Oct 14, 2025 at 10:29=E2=80=AFAM Michael S. Tsirkin <=
mst@redhat.com> wrote:
> > > > > > > >
> > > > > > > > On Tue, Oct 07, 2025 at 03:06:21PM +0200, Eugenio P=C3=A9re=
z wrote:
> > > > > > > > > An userland device implemented through VDUSE could take r=
tnl forever if
> > > > > > > > > the virtio-net driver is running on top of virtio_vdpa.  =
Let's break the
> > > > > > > > > device if it does not return the buffer in a longer-than-=
assumible
> > > > > > > > > timeout.
> > > > > > > >
> > > > > > > > So now I can't debug qemu with gdb because guest dies :(
> > > > > > > > Let's not break valid use-cases please.
> > > > > > > >
> > > > > > > >
> > > > > > > > Instead, solve it in vduse, probably by handling cvq within
> > > > > > > > kernel.
> > > > > > >
> > > > > > > Would a shadow control virtqueue implementation in the VDUSE =
driver work?
> > > > > > > It would ack systematically messages sent by the Virtio-net d=
river,
> > > > > > > and so assume the userspace application will Ack them.
> > > > > > >
> > > > > > > When the userspace application handles the message, if the ha=
ndling fails,
> > > > > > > it somehow marks the device as broken?
> > > > > > >
> > > > > > > Thanks,
> > > > > > > Maxime
> > > > > >
> > > > > > Yes but it's a bit more convoluted  than just acking them.
> > > > > > Once you use the buffer you can get another one and so on
> > > > > > with no limit.
> > > > > > One fix is to actually maintain device state in the
> > > > > > kernel, update it, and then notify userspace.
> > > > > >
> > > > >
> > > > > I thought of implementing this approach at first, but it has two =
drawbacks.
> > > > >
> > > > > The first one: it's racy. Let's say the driver updates the MAC fi=
lter,
> > > > > VDUSE timeout occurs, the guest receives the fail, and then the d=
evice
> > > > > replies with an OK. There is no way for the device or VDUSE to up=
date
> > > > > the driver.
> > > >
> > > > There's no timeout. Kernel can guarantee executing all requests.
> > > >
> > >
> > > I don't follow this. How should the VDUSE kernel module act if the
> > > VDUSE userland device does not use the CVQ buffer then?
> >
> > First I am not sure a VQ is the best interface for talking to userspace=
.
> > But assuming yes - just avoid sending more data, send it later after
> > userspace used the buffer.
> >
>
> Let me take a step back, I think I didn't describe the scenario well enou=
gh.
>
> We have a VDUSE device, and then the same host is interacting with the
> device through the virtio_net driver over virtio_vdpa.
>
> Then, the virtio_net driver sends a control command though its CVQ, so
> it *takes the RTNL*. That command reaches the VDUSE CVQ.
>
> It does not matter if the VDUSE device in the userland processes the
> commands through a CVQ, reading the vduse character device, or another
> system. The question is: what to do if the VDUSE device does not
> process that command in a timely manner? Should we just let the RTNL
> be taken forever?
>

My understanding is that:
1. Virtio-net sends a control messages, waits for reply
2. VDUSE driver dequeues it, adds it to the SCVQ, replies OK to the CVQ
3. Userspace application dequeues the message from the SCVQ
 a. If handling is successful it replies OK
 b. If handling fails, replies ERROR
4. VDUSE driver reads the reply
 a. if OK, do nothing
 b. if ERROR, mark the device as broken?

This is simplified as it does not take into account SCVQ overflow if
the application is stuck.
If IIUC, Michael suggests to only enqueue a single message at the time
in the SVQ,
and bufferize the pending messages in the VDUSE driver.


