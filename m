Return-Path: <linux-kernel+bounces-764088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D601AB21DDE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 08:05:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAC0850094F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 06:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC4BD1BD035;
	Tue, 12 Aug 2025 06:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h9wbg9y1"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C62627602D
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 06:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754978651; cv=none; b=GPeuVzjOXLwXrFsnnGWQxZVHMWiMt+ka371It/f55xQqFQskCGoG6oPgwKTAe91YrSwb9RiMdsM1/bF6US9g96uB7WgSp3u8jJRqLfOBwmmOPjzqES5SSGuH6HJsJxOS1Ww+g/+3WqZ4XiQjTlVFMoJPiQw1dSBk9kmW6wgSC4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754978651; c=relaxed/simple;
	bh=0MGr25W73MzQVxLJ+yptcKKN6s8TSWhomvLsuueWA2U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XFYhwKUjO5yHK56bblv6iMjmSSzIiHXkffrjzyy/5blrDUWxF0TiCqYmAQ0j3ZPBB2U1aQFT9iH9GZ2W//Byd3PPCnwOf8QGtxsATZwqaSKjG2JYwx8Bu81+LfKDklhk1Rby8+8Et5oe0M3CsnYOj83MsPUGhsJSpkAbQPOctlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h9wbg9y1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754978647;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3GbJAGTGX+Pn846IPOGuR02+e3qo8B7q3qgt3TnQIEI=;
	b=h9wbg9y11a8EG5/hXZIkAJmxMMEBY5A8MrnWvSBnbsyAGFOjHfSInYMhkcmmwZgR0ZSi7E
	5Fum91NN5s8MQRnOOFWXSvqJrkjOjfw0v5ijoITgJ3quhtsY9Aiz9LBKKqG0ckzBgyJ+SX
	9mPOehByF4KtGQmVKUXYK0ujGoYmyGk=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-jlaWtD22PoucMQmxYEViGA-1; Tue, 12 Aug 2025 02:04:06 -0400
X-MC-Unique: jlaWtD22PoucMQmxYEViGA-1
X-Mimecast-MFC-AGG-ID: jlaWtD22PoucMQmxYEViGA_1754978646
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3217aae3f90so4679735a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 23:04:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754978645; x=1755583445;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3GbJAGTGX+Pn846IPOGuR02+e3qo8B7q3qgt3TnQIEI=;
        b=FUtBPcjpgz8GO5v+i5BqDKhuxFSNvZECCqiAb4xI9sH+b7QZmBxoagcpHNqGWBGNtS
         CFDgBon4Z0DyOoMij/6mIKgiSNIapykuCE+1h+/hCeZKpIUbYz4hV7N/pEXVkK4A18UU
         bZo1S63QEkn0axovv5ZdcgJqe+0CVrT7YBJFQgkk7LMTQPV9NkxP0oJ37mOCj2o04a1T
         DTY3+SkDCRHF3UHgJy54MOzPiWhGRjHja+78+ffeSGChztlFOrtxJrEEONVj4VTNCXjV
         C+xJV57ADlV84n2hzLBoHNflV02BmUBvoTeyG46EaC2uUoeJErlQLPwuYoWxUGJijC4y
         dxnQ==
X-Forwarded-Encrypted: i=1; AJvYcCV41aDb/NaclQ8a6TnCtKk8R2Iai+lpsKMjnTHpgtMJY3zXYCFS/DwOSEqvMFxmwTJdQSGvY1lYuAt4WlU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxri+GbNZdw+Zw92Ztc4ps+UmOhv8oC375Rzx2HpETvuOKI9iM7
	g6NDWoaPEnoV0jIQWd7OkcPzIIhfXOpb1E3bZubu5NAiFG/c9o6T31+/klV5gxOFATkazmoGyan
	JLoRywJkuBaLt7XFqzGoXQDpzbDfwl1n3PY7mS59qSUqd+3igwjDNS9tVL4P+JwnUEaEXCLEYkA
	gga+6tQxy+iT/UJDg+L7Dz0+rVbOCZEMVmGlpVT5ae
X-Gm-Gg: ASbGnct/RNfbIpN5cj2l6WTs9+c7/V1KqOMgUphV5kVBxUUjcVN0aYRgCcSOtAtTWD8
	6cOVPV8RgfG3atfCksj+kbqpSkuKt9MMgoHEnhX0IVZZpTXiuAetSo2PxtDWzNCyrWmil8xPXP1
	PLTiaMYgXXIZ7Ejb45oW41
X-Received: by 2002:a17:90b:4c86:b0:31e:ccfb:22fc with SMTP id 98e67ed59e1d1-321c0b8c1e3mr3115973a91.35.1754978645304;
        Mon, 11 Aug 2025 23:04:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF5r3xMOoc2+ckyY0tIA3SjtXWOoeKKaBtAZLMli/968b/Nb1ALOR8gdeYFvv5jF7vFEy7P0fr/8MCXWLcOdRI=
X-Received: by 2002:a17:90b:4c86:b0:31e:ccfb:22fc with SMTP id
 98e67ed59e1d1-321c0b8c1e3mr3115934a91.35.1754978644837; Mon, 11 Aug 2025
 23:04:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250606115012.1331551-1-eperezma@redhat.com> <20250606115012.1331551-2-eperezma@redhat.com>
 <CACGkMEsw2taXgW11na2CFK6W03c=x=wMn3iwNZPypgPkeSU06Q@mail.gmail.com>
 <CACGkMEvinV7Zd+xddnxcerFbw_c+RZypkeD5HaN8=g6+peZvMQ@mail.gmail.com>
 <CAJaqyWeetDsdoDzVrN-n0+jr97MBPeHdTxeM3ttmNUeLK702VA@mail.gmail.com>
 <CACGkMEvbxZsmPPHgfst89FCbZamBPLt8V=K-eepa4s3muFuM4A@mail.gmail.com>
 <CAJaqyWerLAL44w-mnwaohZh+duzHqPS3BO-sJDoEHZDN5RLY1g@mail.gmail.com>
 <CACGkMEvsvFzKUF6w0T4juUFcDbm67YoFFwNDw82K6kogB-1yRA@mail.gmail.com>
 <CAJaqyWeteUcvzTbcf2ShatX8QLCVCEgs-dgy19ir=W3LJE3y1A@mail.gmail.com>
 <CACGkMEtir49z9P=82SO9a4JML9D71UAaGSm38R2Ubx3Sg6ZufQ@mail.gmail.com>
 <CAJaqyWfZn36gGbT=MjpdcXi3Sje1WRB6nycXJwP_BPugSzHRyQ@mail.gmail.com> <CACGkMEs+ZytUO8bEqYEG+Y6s85dqTZciWdU1NpxpEiMvRPC+ww@mail.gmail.com>
In-Reply-To: <CACGkMEs+ZytUO8bEqYEG+Y6s85dqTZciWdU1NpxpEiMvRPC+ww@mail.gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Tue, 12 Aug 2025 08:03:28 +0200
X-Gm-Features: Ac12FXwTdZgCrYs-TVFEHUQqO9qoI_jJFh9b51aC4ui85plPbJ-rXOsSZjGgjLg
Message-ID: <CAJaqyWc-vGUF_T6_okai40SK_xMYzUe7WHR60W2q6jW0BAjMVw@mail.gmail.com>
Subject: Re: [RFC 1/6] vduse: add v1 API definition
To: Jason Wang <jasowang@redhat.com>
Cc: Yongji Xie <xieyongji@bytedance.com>, Cindy Lu <lulu@redhat.com>, 
	linux-kernel@vger.kernel.org, Stefano Garzarella <sgarzare@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, Maxime Coquelin <mcoqueli@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux.dev, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Laurent Vivier <lvivier@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 12, 2025 at 4:55=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Mon, Aug 11, 2025 at 5:02=E2=80=AFPM Eugenio Perez Martin
> <eperezma@redhat.com> wrote:
> >
> > On Mon, Aug 11, 2025 at 4:58=E2=80=AFAM Jason Wang <jasowang@redhat.com=
> wrote:
> > >
> > > On Sun, Aug 10, 2025 at 6:18=E2=80=AFPM Eugenio Perez Martin
> > > <eperezma@redhat.com> wrote:
> > > >
> > > > On Fri, Aug 8, 2025 at 2:50=E2=80=AFAM Jason Wang <jasowang@redhat.=
com> wrote:
> > > > >
> > > > > On Thu, Aug 7, 2025 at 6:56=E2=80=AFPM Eugenio Perez Martin <eper=
ezma@redhat.com> wrote:
> > > > > >
> > > > > > On Tue, Jun 10, 2025 at 10:36=E2=80=AFAM Jason Wang <jasowang@r=
edhat.com> wrote:
> > > > > > >
> > > > > > > On Mon, Jun 9, 2025 at 2:11=E2=80=AFPM Eugenio Perez Martin <=
eperezma@redhat.com> wrote:
> > > > > > > >
> > > > > > > > On Mon, Jun 9, 2025 at 3:50=E2=80=AFAM Jason Wang <jasowang=
@redhat.com> wrote:
> > > > > > > > >
> > > > > > > > > On Mon, Jun 9, 2025 at 9:41=E2=80=AFAM Jason Wang <jasowa=
ng@redhat.com> wrote:
> > > > > > > > > >
> > > > > > > > > > On Fri, Jun 6, 2025 at 7:50=E2=80=AFPM Eugenio P=C3=A9r=
ez <eperezma@redhat.com> wrote:
> > > > > > > > > > >
> > > > > > > > > > > This allows to define all functions checking the API =
version set by the
> > > > > > > > > > > userland device.
> > > > > > > > > > >
> > > > > > > > > > > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.co=
m>
> > > > > > > > > >
> > > > > > > > > > It might be worth clarifying how it works.
> > > > > > > > > >
> > > > > > > > > > For example,
> > > > > > > > > >
> > > > > > > > > > 1) would VDUSE behave differently or if it's just some =
new ioctls
> > > > > > > >
> > > > > > > > I'd like to test more in-depth, but a device can just bump =
the version
> > > > > > > > ID and then implement the replies to the vduse messages. No=
 need to
> > > > > > > > implement new ioctls. If the VDUSE device sets 0 in either =
number of
> > > > > > > > ASID or vq groups, the kernel assumes 1.
> > > > > > >
> > > > > > > Right, this is the way we use now and I think maybe we can do=
cument
> > > > > > > this somewhere.
> > > > > > >
> > > > > > > >
> > > > > > > > But you have a very good point here, I think it is wise to =
evaluate
> > > > > > > > the shortcut of these messages in the VDUSE kernel module. =
If a VDUSE
> > > > > > > > device only has one vq group and one ASID, it can always re=
turn group
> > > > > > > > 0 and asid 0 for everything, and fail every try to ser asid=
 !=3D 0.
> > > > > > >
> > > > > > > Yes, and vhost-vDPA needs to guard against the misconfigurati=
on.
> > > > > > >
> > > > > > > > This
> > > > > > > > way, the update is transparent for the VDUSE device, and fu=
ture
> > > > > > > > devices do not need to implement the reply of these. What d=
o you
> > > > > > > > think?
> > > > > > >
> > > > > > > This should work.
> > > > > > >
> > > > > > > >
> > > > > > > > > > 2) If VDUSE behave differently, do we need a ioctl to s=
et the API
> > > > > > > > > > version for backward compatibility?
> > > > > > > > >
> > > > > > > > > Speak too fast, there's a VDUSE_SET_API_VERSION actually.
> > > > > > > > >
> > > > > > > > > I think we need to think if it complicates the migration =
compatibility or not.
> > > > > > > > >
> > > > > > > >
> > > > > > > > Do you mean migration as "increase the VDUSE version number=
", not "VM
> > > > > > > > live migration from vduse version 0 to vduse version 1", is=
n't it? The
> > > > > > > > second should not have any problem but I haven't tested it.
> > > > > > >
> > > > > > > I mean if we bump the version, we can't migrate from version =
1 to
> > > > > > > version 0. Or we can offload this to the management (do we ne=
ed to
> > > > > > > extend the vdpa tool for this)?
> > > > > > >
> > > > > >
> > > > > > I just noticed I left this unreplied. But I still do not get wh=
at
> > > > > > migrate means here :).
> > > > > >
> > > > > > If migrate means to run current VDUSE devices on kernel with th=
is
> > > > > > series applied these devices don't set V1 API so they have one =
vq
> > > > > > group, and one asid. I'm actually testing this with my libfuse+=
VDUSE
> > > > > > modifications that don't use V1 at all. Adding this explanation=
 to the
> > > > > > patch as it is a very good point indeed.
> > > > >
> > > > > Right.
> > > > >
> > > > > >
> > > > > > If it means to migrate a guest from using a V1 VDUSE device to =
a V0
> > > > > > device "it should work", as it is just a backend implementation
> > > > > > detail.
> > > > >
> > > > > For example src is the VDUSE with multiqueue support (v1) but des=
t
> > > > > doesn't have this support (v0). I think the qemu should fail to l=
aunch
> > > > > in dest.
> > > > >
> > > > > > If we migrate from or to a vdpa device backed by hardware, for
> > > > > > example, one of the devices does not even have the concept of V=
DUSE
> > > > > > API version.
> > > > > >
> > > > > > In the case of net, it does not work at the moment because the =
only
> > > > > > way to set features like mq are through the shadow CVQ.
> > > > >
> > > > > I think you mean qemu should fail, I'm not sure this is friendly =
to libvirt.
> > > > >
> > > >
> > > > No, I think QEMU should not transmit vdpa backend properties not
> > > > visible to the guest, so we don't get an explosion of properties th=
at
> > > > are hard to get. Expanding on this, QEMU is not even able to know i=
f
> > > > it is talking with VDUSE, vdpa_sim, or a vdpa device backed by
> > > > hardware. And I think we don't want QEMU to have this information. =
So
> > > > sending the VDUSE version implies removing a lot of useful
> > > > abstractions.
> > > >
> > > > In the case of net, the destination QEMU should fail if it is not a=
ble
> > > > to restore the device state. At this moment this implies to have at
> > > > least two ASID if the net device has CVQ, and that CVQ is in its ow=
n
> > > > ASID, but that may not be true in the future.
> > > >
> > > > But QEMU does not check if that is the case migrating between two
> > > > vdpa_net_sim if one supports ASID but the other doesn't.
> > >
> > > Ok I think I must miss something. I need some context here. For
> > > example, Is the shadow cvq option used by libvirt or not? (Or it has
> > > been enabled by default if Qemu detect cvq has its own group?)
> > >
> > > If shadow cvq is neither used by libvirt nor automatically enabled, w=
e
> > > need to make it work for libvirt first.
> > >
> > > If it relies on libvirt to enable it explicitly, is libvirt expected
> > > to detect the vDPA ability (I guess it is not what libvirt wants)?
> > > If shadow cvq is enabled automatically, migrating from V2 to V1 is
> > > fine but not the reverse.
> > >
> >
> > QEMU uses shadow CVQ automatically if all the conditions (ASID, proper
> > set of features, etc) are supported.
> >
>
> Ok, so V1 implies non-migratable.  So I'm still confused about how to
> deal with migration compatibility.
>
> For example, ping-pong migration between V1 and V2.
>

If the device does not have CVQ, everything works.

If the device has CVQ, it is not possible at the moment. Everything
breaks the same way as if the destination vhost_vdpa does not have the
ASID capability. For example, if the destination device is an intel,
pensando, or solidrun vdpa.


