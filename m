Return-Path: <linux-kernel+bounces-762136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAAB6B2028B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 11:03:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A96BF3ABF64
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 09:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6291A2DCF71;
	Mon, 11 Aug 2025 09:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="itJBuUIE"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6EBB2DCF6A
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 09:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754902914; cv=none; b=nKrlrR1Cnb5t2FssE4emeyxucp+O2EJdPIBuZ21Xr/VKI/rl+GqL9ErtSGvxSYAVhwpBSaHUpqQXE6Hn2LpJh7IP8gz/DQnH9qE5mAjwiavQvovPjdOVtE/eE9+6tuMa/vMNTIuthtozsJj3oToPbJdLGeZRL/pNohlD1zM0/5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754902914; c=relaxed/simple;
	bh=9hlEPV/IfDDtQtAOKScDD2ZMyM5monkE73IXEFC6zd0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dmix/shJY6Nd1s8UHJV3npBWXQX+JOW3321s6IFTTyalNBrU38JLILGiC6chlWl6WVMx2H9TOt+ErPRxMeAk4DhW2wLDR5VWUHqjsxRBWTzP3sDKpXbcn83rckMMRNBAlL4Q/MeDp+DeZeOLG1zsKdSraH2wdOax/HuAaQ9umz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=itJBuUIE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754902911;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9hlEPV/IfDDtQtAOKScDD2ZMyM5monkE73IXEFC6zd0=;
	b=itJBuUIEDjtAyiUGy9mhTrCm5oBaOwJyjB8C5XduuBNLx2+gCsfvID9fIariNIgqq+PZL/
	l4262DJAW8OxS5rrcgA8aQT+U/1RT71ZBWzSnB58LfK0ufoq9mfCjCQxqk1iIQTo6IDeKU
	o99nlzDKOqVa4XISMA2LW4N+FhEGS2c=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-htmwlsFkNfeoTpoQ9N1BmQ-1; Mon, 11 Aug 2025 05:01:47 -0400
X-MC-Unique: htmwlsFkNfeoTpoQ9N1BmQ-1
X-Mimecast-MFC-AGG-ID: htmwlsFkNfeoTpoQ9N1BmQ_1754902906
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3217aae3f90so3756443a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 02:01:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754902906; x=1755507706;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9hlEPV/IfDDtQtAOKScDD2ZMyM5monkE73IXEFC6zd0=;
        b=TmPTqMQC/uTuTA+njz5OURLtND1q4CVmXAuenAe8HS/mrsl/XK/F5iFuSGvDFPq5Lc
         JK+hN0Wee+GswZ47q8AzyICjLWkIx8zqfV4kV3keFlo6mquqAYJQRqAsBqqa8sFZMGXS
         BL7yE/TsX37uvudCrm4Ou55ImoFLB+YIie+cqUvJAQhUY9XdYs7jWyomn3SjV/M2Ucla
         uNISHGzWcT0tdldG6hjuMQazYLaBP21O5wosGbjcXFpgAvL5v81qeV/a0L+pGhVJByXc
         GsmlTD95ZYU0lOy+R8R+hSMAF5LGlIy8AmiBVKJD+jdrlPg16omTfwxWw6K964NpQjDw
         pIhA==
X-Forwarded-Encrypted: i=1; AJvYcCXrqhXQ2NvVrJUtTExAs9TVuQH4gc9fIJxPlDjs5fEMXEtQMy6xl02RjnOeb+q/V6HWmn5pG7Bt3kgN6gg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAtBkzSer6woVpg8ObMGjf1ABXnOGc+2UahSV+jtqy0ed8Dnu4
	ecdmhbBwYd71t4E5B6ytY20LK5J0Hxn3HlWC4aVT5CVzOHA6CPDpmQKJdMA1G8z+7RmfpPYGjuf
	T2ZGv7fwlervM0+rkvRoHrVWQAjoIx5cie0GXCjRCnSpnbtfVJTimmHwJhpGHg9uUy0yQbdVzyK
	shOOFGYd83dypUzt7KgeW7jbKR74DwnqeQoGQqeiMP
X-Gm-Gg: ASbGncuiTjThllTuDAxxPeuNzHvfba59//Ty/x67eMcbaIBxAPyI07llp8L4VFux618
	XIs1AECQQaW08kXZixdd7lC9qhlAE7tCVLjwvNlJ7ks4Tfv0AdtkhO0sOacwFsC8GO5R6Y6OWgH
	uPMZG6PqKWxl9uhk/CVXX4
X-Received: by 2002:a17:90b:52:b0:321:59e7:c5c2 with SMTP id 98e67ed59e1d1-321839f14a1mr17447500a91.9.1754902906028;
        Mon, 11 Aug 2025 02:01:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGDuECMN77vMhYusYpt4WAkjMkw1WRpYN/6auGgR1Mm8CVoxiVNx6ETAxfGe0AVp7SZTkrxI+PiVXP/b49cjfg=
X-Received: by 2002:a17:90b:52:b0:321:59e7:c5c2 with SMTP id
 98e67ed59e1d1-321839f14a1mr17447453a91.9.1754902905548; Mon, 11 Aug 2025
 02:01:45 -0700 (PDT)
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
 <CAJaqyWeteUcvzTbcf2ShatX8QLCVCEgs-dgy19ir=W3LJE3y1A@mail.gmail.com> <CACGkMEtir49z9P=82SO9a4JML9D71UAaGSm38R2Ubx3Sg6ZufQ@mail.gmail.com>
In-Reply-To: <CACGkMEtir49z9P=82SO9a4JML9D71UAaGSm38R2Ubx3Sg6ZufQ@mail.gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Mon, 11 Aug 2025 11:01:08 +0200
X-Gm-Features: Ac12FXyzukIYhcamNRSmGi93ksor1rxeDb1YWIzRqL5BOnr9nU4K34fcomJB3m4
Message-ID: <CAJaqyWfZn36gGbT=MjpdcXi3Sje1WRB6nycXJwP_BPugSzHRyQ@mail.gmail.com>
Subject: Re: [RFC 1/6] vduse: add v1 API definition
To: Jason Wang <jasowang@redhat.com>
Cc: Yongji Xie <xieyongji@bytedance.com>, Cindy Lu <lulu@redhat.com>, 
	linux-kernel@vger.kernel.org, Stefano Garzarella <sgarzare@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, Maxime Coquelin <mcoqueli@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux.dev, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Laurent Vivier <lvivier@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 11, 2025 at 4:58=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Sun, Aug 10, 2025 at 6:18=E2=80=AFPM Eugenio Perez Martin
> <eperezma@redhat.com> wrote:
> >
> > On Fri, Aug 8, 2025 at 2:50=E2=80=AFAM Jason Wang <jasowang@redhat.com>=
 wrote:
> > >
> > > On Thu, Aug 7, 2025 at 6:56=E2=80=AFPM Eugenio Perez Martin <eperezma=
@redhat.com> wrote:
> > > >
> > > > On Tue, Jun 10, 2025 at 10:36=E2=80=AFAM Jason Wang <jasowang@redha=
t.com> wrote:
> > > > >
> > > > > On Mon, Jun 9, 2025 at 2:11=E2=80=AFPM Eugenio Perez Martin <eper=
ezma@redhat.com> wrote:
> > > > > >
> > > > > > On Mon, Jun 9, 2025 at 3:50=E2=80=AFAM Jason Wang <jasowang@red=
hat.com> wrote:
> > > > > > >
> > > > > > > On Mon, Jun 9, 2025 at 9:41=E2=80=AFAM Jason Wang <jasowang@r=
edhat.com> wrote:
> > > > > > > >
> > > > > > > > On Fri, Jun 6, 2025 at 7:50=E2=80=AFPM Eugenio P=C3=A9rez <=
eperezma@redhat.com> wrote:
> > > > > > > > >
> > > > > > > > > This allows to define all functions checking the API vers=
ion set by the
> > > > > > > > > userland device.
> > > > > > > > >
> > > > > > > > > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > > > > > > >
> > > > > > > > It might be worth clarifying how it works.
> > > > > > > >
> > > > > > > > For example,
> > > > > > > >
> > > > > > > > 1) would VDUSE behave differently or if it's just some new =
ioctls
> > > > > >
> > > > > > I'd like to test more in-depth, but a device can just bump the =
version
> > > > > > ID and then implement the replies to the vduse messages. No nee=
d to
> > > > > > implement new ioctls. If the VDUSE device sets 0 in either numb=
er of
> > > > > > ASID or vq groups, the kernel assumes 1.
> > > > >
> > > > > Right, this is the way we use now and I think maybe we can docume=
nt
> > > > > this somewhere.
> > > > >
> > > > > >
> > > > > > But you have a very good point here, I think it is wise to eval=
uate
> > > > > > the shortcut of these messages in the VDUSE kernel module. If a=
 VDUSE
> > > > > > device only has one vq group and one ASID, it can always return=
 group
> > > > > > 0 and asid 0 for everything, and fail every try to ser asid !=
=3D 0.
> > > > >
> > > > > Yes, and vhost-vDPA needs to guard against the misconfiguration.
> > > > >
> > > > > > This
> > > > > > way, the update is transparent for the VDUSE device, and future
> > > > > > devices do not need to implement the reply of these. What do yo=
u
> > > > > > think?
> > > > >
> > > > > This should work.
> > > > >
> > > > > >
> > > > > > > > 2) If VDUSE behave differently, do we need a ioctl to set t=
he API
> > > > > > > > version for backward compatibility?
> > > > > > >
> > > > > > > Speak too fast, there's a VDUSE_SET_API_VERSION actually.
> > > > > > >
> > > > > > > I think we need to think if it complicates the migration comp=
atibility or not.
> > > > > > >
> > > > > >
> > > > > > Do you mean migration as "increase the VDUSE version number", n=
ot "VM
> > > > > > live migration from vduse version 0 to vduse version 1", isn't =
it? The
> > > > > > second should not have any problem but I haven't tested it.
> > > > >
> > > > > I mean if we bump the version, we can't migrate from version 1 to
> > > > > version 0. Or we can offload this to the management (do we need t=
o
> > > > > extend the vdpa tool for this)?
> > > > >
> > > >
> > > > I just noticed I left this unreplied. But I still do not get what
> > > > migrate means here :).
> > > >
> > > > If migrate means to run current VDUSE devices on kernel with this
> > > > series applied these devices don't set V1 API so they have one vq
> > > > group, and one asid. I'm actually testing this with my libfuse+VDUS=
E
> > > > modifications that don't use V1 at all. Adding this explanation to =
the
> > > > patch as it is a very good point indeed.
> > >
> > > Right.
> > >
> > > >
> > > > If it means to migrate a guest from using a V1 VDUSE device to a V0
> > > > device "it should work", as it is just a backend implementation
> > > > detail.
> > >
> > > For example src is the VDUSE with multiqueue support (v1) but dest
> > > doesn't have this support (v0). I think the qemu should fail to launc=
h
> > > in dest.
> > >
> > > > If we migrate from or to a vdpa device backed by hardware, for
> > > > example, one of the devices does not even have the concept of VDUSE
> > > > API version.
> > > >
> > > > In the case of net, it does not work at the moment because the only
> > > > way to set features like mq are through the shadow CVQ.
> > >
> > > I think you mean qemu should fail, I'm not sure this is friendly to l=
ibvirt.
> > >
> >
> > No, I think QEMU should not transmit vdpa backend properties not
> > visible to the guest, so we don't get an explosion of properties that
> > are hard to get. Expanding on this, QEMU is not even able to know if
> > it is talking with VDUSE, vdpa_sim, or a vdpa device backed by
> > hardware. And I think we don't want QEMU to have this information. So
> > sending the VDUSE version implies removing a lot of useful
> > abstractions.
> >
> > In the case of net, the destination QEMU should fail if it is not able
> > to restore the device state. At this moment this implies to have at
> > least two ASID if the net device has CVQ, and that CVQ is in its own
> > ASID, but that may not be true in the future.
> >
> > But QEMU does not check if that is the case migrating between two
> > vdpa_net_sim if one supports ASID but the other doesn't.
>
> Ok I think I must miss something. I need some context here. For
> example, Is the shadow cvq option used by libvirt or not? (Or it has
> been enabled by default if Qemu detect cvq has its own group?)
>
> If shadow cvq is neither used by libvirt nor automatically enabled, we
> need to make it work for libvirt first.
>
> If it relies on libvirt to enable it explicitly, is libvirt expected
> to detect the vDPA ability (I guess it is not what libvirt wants)?
> If shadow cvq is enabled automatically, migrating from V2 to V1 is
> fine but not the reverse.
>

QEMU uses shadow CVQ automatically if all the conditions (ASID, proper
set of features, etc) are supported.


