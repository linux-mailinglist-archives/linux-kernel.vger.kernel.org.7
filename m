Return-Path: <linux-kernel+bounces-857481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id ED461BE6EA4
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 09:22:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 72EB14F51AA
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 07:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 031D3242D6B;
	Fri, 17 Oct 2025 07:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EW2Rpdfh"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E4923EA94
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 07:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760685724; cv=none; b=G2x3LLcC95/52pSd+Oak8guI3sCo9oxNKW1vgejawmuBuyj8Xs/Hwk4khIc40w9UrBKBgEqW68i1X+IKIXEpbDBVwoDLLu/f9WUc65Bor/RDUzXl2C9JtlsFUYNPMr0caPNOHYqvr5POMOeF28m2U8FNTpd/NIzTs+z8Bta5DsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760685724; c=relaxed/simple;
	bh=klMwGirUZdc/9en6gVNRoYBq4q9YFhZSrvAPxBrsxO8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QWyXZgpbA4ENTFdS89AF95uo5P1vNV/g9onZDXJkyx/Hz4liRkSrGEOWmYBdrHOYUti970aKaqr4DE4r3BaBSGZxqNcd3BKOEJjCCNRJ1K+Fjc0nXR38cQQi4mdiiQ35XlwXIUeK/fU2gGcvBZr+5rw4K0+5spLX7lHizJkkIQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EW2Rpdfh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760685716;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v28vvTjtPo8MKw10asWnJl+FMQDqDxLQM+r4bXZie6U=;
	b=EW2RpdfhFJRQAIiog38GQTEpjzlyeYUf3ayceJq/ZpzAJZK1US1q5JsJhatee48BQHv2rs
	DmE8j3laM+qJF9t6JX3vdhZnsGq0DfIX1hr0My51Ojg8IQjoWMD4yF1+KkBw8KOaqIUyMJ
	OToGldTnnVMSsYtfNRA8wQttP1nVK2Q=
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com
 [74.125.224.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-581-h4w8zfSfNsubsVzbH_Aynw-1; Fri, 17 Oct 2025 03:21:54 -0400
X-MC-Unique: h4w8zfSfNsubsVzbH_Aynw-1
X-Mimecast-MFC-AGG-ID: h4w8zfSfNsubsVzbH_Aynw_1760685714
Received: by mail-yx1-f71.google.com with SMTP id 956f58d0204a3-63d34257de6so2378984d50.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 00:21:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760685714; x=1761290514;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v28vvTjtPo8MKw10asWnJl+FMQDqDxLQM+r4bXZie6U=;
        b=VmhuYcQL+VPYDlJQdcGiyOIm7Au+pweQS6wcsTJXxJ+K/ndrj57EdFnq5lxZ3LA2Vt
         9Ufcg5r35jTdwgbUnkkg9ilfiI59VY3ZoIDVuzszopdQEsFMzMJkYLql1ZZh2VHW4H3G
         OBtI91inneqYARH6iDg86pWDPuNj5B9vaDXYdb6bPGIawImR4rzQzdSKYLQru8Mpuws3
         VGCDsqkQaUUf7TFHfo1yz1365vSxBx4ioN8++ykGCUEPN37BXPAeWlpq03v+Huzro4nb
         ydUYtV3HoNXx3pe0eAwl8K1lWDH6aFCLmzuaWCxGn+jaqU6p/ziMV0mVNDr/B2+XPFt6
         phgQ==
X-Forwarded-Encrypted: i=1; AJvYcCWXqkbSe+ddBy7LanM7F4MvpMWiqHHSzQSG7vljwVIC51AdxEXfLR3A9MDvJGWcxLVJwIdcQ6ZmXPXvuVI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9VM3YkuHtKPsAu115qqj2mBBjH71qADZswjHOeiFs6ofM/Tes
	0D6ygeMCD50fZBpcDyI9tfo733GCEaAb6fu9McunXYIx+MgxmN8fP6UA3+/Zc3SZb6A2V6nTX7a
	I8GXN0LyYcqS5Oh9ZfP/ihiO3NxN6svvKJaTgnHZ7LjiYkCudXqjHoYbVAHEtVF9xj77jl3nEVd
	bb3zggYA0+4/RMQzFPIyY/P/r67jjgdLigp8hY5PUQ
X-Gm-Gg: ASbGncvDptBvrIAXVnFHoUuH98V9Fl6fdb4/KtyR9unEnrxwRBZosSAZVxUlHbNJkMR
	APHONr6l6MI/5+N4nRqmAcNraRk04d9vIv/uQp1cTkt9DcIDw2eiQ2mCLFkmB9H3hVTmzc1xJTv
	CTS3oZy7L3zGEC3HEsPoFcxeLOcyNADiSMiXgvslpixRxhwkd8bFXdlsrfdkTpx9znJ5Lbzd/Xw
	cjT/vk9+2fZto7uVKiG6+SOsWhyHEPoWFCrBcmLApE=
X-Received: by 2002:a05:690e:dcf:b0:5f3:319c:ff0a with SMTP id 956f58d0204a3-63e16157b37mr3030398d50.28.1760685714183;
        Fri, 17 Oct 2025 00:21:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFZwyPhDZHU7dOLNaIR4lfmJjGqqnoPu3JOnms4GhUSITGKnhrHsbO/qlmNv1p1/X6EDYY+QAN377bA156xF9M=
X-Received: by 2002:a05:690e:dcf:b0:5f3:319c:ff0a with SMTP id
 956f58d0204a3-63e16157b37mr3030377d50.28.1760685713838; Fri, 17 Oct 2025
 00:21:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJaqyWfRmhXM8eV+=wMVKgrc8SJ98OTtBCtNDJj8ZRUM5Y9Nmg@mail.gmail.com>
 <CAO55csx2rbjxEZk5K3aKcZ501KY3Zfs8ThEQHFqQ1ZB9RSXECA@mail.gmail.com>
 <20251015040722-mutt-send-email-mst@kernel.org> <CAJaqyWcf3tz17q6G=123Xb+warf8Ckg=PLaPkzLU9hYHiUy9Zg@mail.gmail.com>
 <CACGkMEuPPFLH1YqTx03fV9N=Rx3aYXK0HMUDpZu-CvO1NYRRQA@mail.gmail.com>
 <20251016014328-mutt-send-email-mst@kernel.org> <CACGkMEtXWLicmszjkzOhX8Ta=LdGgsDahRUKDEVzBVG8am5vgg@mail.gmail.com>
 <20251016022131-mutt-send-email-mst@kernel.org> <CAJaqyWe--Hho9EdweqkC-h9=t5vhY0cbAN9uAw=hATpkSMbsEg@mail.gmail.com>
 <CAJaqyWdEY6KaVbBn5LJhkz7h6kytFg8-b8iXnc9N54L+q_Yrbw@mail.gmail.com> <20251017023902-mutt-send-email-mst@kernel.org>
In-Reply-To: <20251017023902-mutt-send-email-mst@kernel.org>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Fri, 17 Oct 2025 09:21:17 +0200
X-Gm-Features: AS18NWAqq13vIx4wyqpvwIq_0fwtZxgXGnFG57EyRZguYWfSvJx_PPst438uNPs
Message-ID: <CAJaqyWcyJU_ghJpQrnEyTf19o_NzE6FXkxgBRZx=1RYqQkN4gA@mail.gmail.com>
Subject: Re: [RFC 1/2] virtio_net: timeout control virtqueue commands
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, Maxime Coquelin <mcoqueli@redhat.com>, 
	Yongji Xie <xieyongji@bytedance.com>, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Dragos Tatulea DE <dtatulea@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 17, 2025 at 8:39=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Fri, Oct 17, 2025 at 08:36:41AM +0200, Eugenio Perez Martin wrote:
> > On Thu, Oct 16, 2025 at 8:25=E2=80=AFAM Eugenio Perez Martin
> > <eperezma@redhat.com> wrote:
> > >
> > > On Thu, Oct 16, 2025 at 8:22=E2=80=AFAM Michael S. Tsirkin <mst@redha=
t.com> wrote:
> > > >
> > > > On Thu, Oct 16, 2025 at 02:03:57PM +0800, Jason Wang wrote:
> > > > > On Thu, Oct 16, 2025 at 1:45=E2=80=AFPM Michael S. Tsirkin <mst@r=
edhat.com> wrote:
> > > > > >
> > > > > > On Thu, Oct 16, 2025 at 01:39:58PM +0800, Jason Wang wrote:
> > > > > > > > >
> > > > > > > > > Not exactly bufferize, record.  E.g. we do not need to se=
nd
> > > > > > > > > 100 messages to enable/disable promisc mode - together th=
ey
> > > > > > > > > have no effect.
> > > > > > >
> > > > > > > Note that there's a case that multiple commands need to be se=
nt, e.g
> > > > > > > set rx mode. And assuming not all the commands are the best e=
ffort,
> > > > > > > kernel VDUSE still needs to wait for the usersapce at least f=
or a
> > > > > > > while.
> > > > > >
> > > > > > Not wait, record. Generate 1st command, after userspace consume=
d it -
> > > > > > generate and send second command and so on.
> > > > >
> > > > > Right, that's what I asked in another thread, we still need a tim=
eout
> > > > > here.
> > > >
> > > > we do not need a timeout.
> > > >
> > > > > Then I think it would not be too much difference whether it is
> > > > > VDUSE or CVQ that will fail or break the device. Conceptually, VD=
USE
> > > > > can only advertise NEEDS_RESET since it's a device implementation=
.
> > > > > VDUSE can not simply break the device as it requires synchronizat=
ion
> > > > > which is not easy.
> > > > >
> > > > > > But for each bit of data, at most one command has to be sent,
> > > > > > we do not care if guest tweaked rx mode 3 times, we only care a=
bout
> > > > > > the latest state.
> > > > >
> > > > > Yes, but I want to know what's best when VDUSE meets userspace ti=
meout.
> > > > >
> > > > > Thanks
> > > >
> > > >
> > > > userspace should manage its own timeouts.
> > > >
> > >
> > > Can we just apply the patch 2/2 of this RFC directly and apply the
> > > VDUSE CVQ on top then? What are we missing to do it?
> > >
> >
> > Even better, can we just revert commit 56e71885b0349 ("vduse:
> > Temporarily fail if control queue feature requested") ?
>
> No because both would let userspace hang kernels merely by
> not consuming buffers.
>

My understanding was that you want to be able to debug qemu with gdb
from that hang [1].

Could you put an example of the whole chain of events you expect? From
the moment the driver sends a VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET command,
the VDUSE CVQ Forwards the command to the VDUSE device in the
userspace, and then the vduse userland device does not reply.

How does the VDUSE CVQ detect that the VDUSE device implemented in
userland does not reply? What are the next steps from that point of
the kernel VDUSE module?

Thanks!

[1] https://lore.kernel.org/lkml/20251014042459-mutt-send-email-mst@kernel.=
org/


