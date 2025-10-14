Return-Path: <linux-kernel+bounces-852344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DC425BD8BB2
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 12:22:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 703BC4FC3BE
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 10:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A8D62F5A29;
	Tue, 14 Oct 2025 10:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PSoyqVJP"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF2062EC0AB
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 10:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760437311; cv=none; b=kW97NHrTi6lsV85ehtntrYtv81qh5P8v/wy63aySU0annpZ7rz/HKOghdkdRFs1a8/UjWVfySxqDIZIKms2MdoWE6hXYRsUUWxJvdU8IGYdYYM0EQg89dWCkO4b497cLEyGatfaXjj/TrrwVwE/r30zt9+upCWMPkFbJQ/8nsgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760437311; c=relaxed/simple;
	bh=0+9oOtn3ToO9YBdvcAwnf/zoA3wAd3rg3heRydAHaEQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q6InTgcTPvmrd/5KhtH6XygrzY8QIuU4pquuVRY0SfY/S+A0OaMUdZY07Imp46D+3ej2sHbZo4ZnDNkACJwcZKbZUUqq3/UsP1zGGxID8W78RFZKShQ5/e6Gh5sq7IvEhShTRHZq/7ysz2AKh/xg5tP3PwiTcC35HnusKNFM4Cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PSoyqVJP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760437308;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/DfJWp99jFxqBbEKvRqQ4rgQH8Wd24+r3ktEvYW+Eps=;
	b=PSoyqVJPWNr+y8p4Y/KG0LZvuw/O/tBtYhixklsUt4T3KUbCYhQFUYq2n7kyWMpkr2J2Ik
	OMJqOyNSzaPtzVb6C/xSfszkBPxdCD7POV75X5rL5H9syUEXXONUh0qvxCsoCH9yeFKlJH
	LN2KLBQmc0Hx2+ncLFhevKjYcf0RU7s=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-xYirMrhDOTS72_f0gpdZYg-1; Tue, 14 Oct 2025 06:21:47 -0400
X-MC-Unique: xYirMrhDOTS72_f0gpdZYg-1
X-Mimecast-MFC-AGG-ID: xYirMrhDOTS72_f0gpdZYg_1760437306
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-634ad8328fdso6447891a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 03:21:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760437306; x=1761042106;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/DfJWp99jFxqBbEKvRqQ4rgQH8Wd24+r3ktEvYW+Eps=;
        b=g0hCNDQ2X2uIWZFPNXR/nWbB9e/feeNg9ZddmTl5sHnlDRSZOws2DxEBKkufmY+7D4
         HvfxWMncdonZ7KGXbYzKI+45A5so+NV3t+bltrPkbN9OpROJbO5bETVhi19lcDBnA6yH
         ptbhq/LYCDFd8iMsFWc7v88ZKvRrKAqy5L+CphTLuDSZPduMnnCOa4HoJ+VfiwCgdYR7
         G/r/pzQE8rBZ+u6c1sWm9u8ff3ktcjrojKd8HkR2D0vAnSDwDYU+ikB91kBT0SIA+KSH
         nS93hsVGTJ6DbRsXjaJdYcGsSPjGTdlIZKQZGDXp9Ew0mYY890ZIeLwY/uhvHGkd8WdV
         jhBA==
X-Forwarded-Encrypted: i=1; AJvYcCVNCrs/LbXUYnfAmvsxM+gI4TzXrZlR64AoDM9djt2o8N9GPQoHZHtCicJaFpl8CgasNp6BMO0KArBfc0s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRwYqBkfsf29wG6vbfedWwrFe/qwD1i3ffF22V87eC1lXQ9uTy
	bnv8bBgx1RL0XCNc9AqBDRBYiGuBPx0zoeG7kNr6imyAy+/5A0onE5SJNkISu6FJtOrY2cHSKCC
	MV0a04Q26r1HTeR6RNX20dBU+Zy5jZt9urdcSnQIovylHxz3eqgpFxBqxLdGHeqrQ89+N6h2HnA
	l4ajr2wlcqzRc0dfnJOmG4VkQlI0Z85RYp73YT/yLY
X-Gm-Gg: ASbGnctNlIbkGvggzyOxPiR86pGtEOvFEaVE4Zy5LEqNozGn4uJPHd6HPopgv7xfwCy
	AEEZXB5lH9JOYhau5eT4fpAdY/SvxqL3csNnyrs6j9MvNYZgZYbW10XapE4thljBTxBWNWNmQo5
	lpZVUawWQyhEa0H7gqnlk=
X-Received: by 2002:aa7:cd43:0:b0:636:7b44:f793 with SMTP id 4fb4d7f45d1cf-639d5c76f3amr16517953a12.36.1760437306445;
        Tue, 14 Oct 2025 03:21:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEKrvE9Xc9mqZwQ51BrULFDR+Gy3L+td0SwFVlzpJhYd2POB68sD9sCyewNnN1OSi+CZpFHWHtKVkVVztq+xfw=
X-Received: by 2002:aa7:cd43:0:b0:636:7b44:f793 with SMTP id
 4fb4d7f45d1cf-639d5c76f3amr16517926a12.36.1760437306030; Tue, 14 Oct 2025
 03:21:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251007130622.144762-1-eperezma@redhat.com> <20251007130622.144762-2-eperezma@redhat.com>
 <20251014042459-mutt-send-email-mst@kernel.org> <CAO55cszGtuqL9qfs8SVB=Jjghefn=M0Rjw65f2DGPrjLQFFtqg@mail.gmail.com>
 <20251014051537-mutt-send-email-mst@kernel.org>
In-Reply-To: <20251014051537-mutt-send-email-mst@kernel.org>
From: Maxime Coquelin <mcoqueli@redhat.com>
Date: Tue, 14 Oct 2025 12:21:34 +0200
X-Gm-Features: AS18NWDpS8D6S4j8bcZBNBYFKVG5ZJYkhs61PKFEtR3JascrL9Zw9_GKX6oIn1M
Message-ID: <CAO55cswTyMBsKdpn7becsY4Ry+ZUoEfgP+2Q+DkhZ090VK_-2A@mail.gmail.com>
Subject: Re: [RFC 1/2] virtio_net: timeout control virtqueue commands
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Yongji Xie <xieyongji@bytedance.com>, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Dragos Tatulea DE <dtatulea@nvidia.com>, jasowang@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 14, 2025 at 11:25=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com=
> wrote:
>
> On Tue, Oct 14, 2025 at 11:14:40AM +0200, Maxime Coquelin wrote:
> > On Tue, Oct 14, 2025 at 10:29=E2=80=AFAM Michael S. Tsirkin <mst@redhat=
.com> wrote:
> > >
> > > On Tue, Oct 07, 2025 at 03:06:21PM +0200, Eugenio P=C3=A9rez wrote:
> > > > An userland device implemented through VDUSE could take rtnl foreve=
r if
> > > > the virtio-net driver is running on top of virtio_vdpa.  Let's brea=
k the
> > > > device if it does not return the buffer in a longer-than-assumible
> > > > timeout.
> > >
> > > So now I can't debug qemu with gdb because guest dies :(
> > > Let's not break valid use-cases please.
> > >
> > >
> > > Instead, solve it in vduse, probably by handling cvq within
> > > kernel.
> >
> > Would a shadow control virtqueue implementation in the VDUSE driver wor=
k?
> > It would ack systematically messages sent by the Virtio-net driver,
> > and so assume the userspace application will Ack them.
> >
> > When the userspace application handles the message, if the handling fai=
ls,
> > it somehow marks the device as broken?
> >
> > Thanks,
> > Maxime
>
> Yes but it's a bit more convoluted  than just acking them.
> Once you use the buffer you can get another one and so on
> with no limit.
> One fix is to actually maintain device state in the
> kernel, update it, and then notify userspace.

I agree, this is the way to go.

Thanks for your insights,
Maxime

>
>
> > >
> > > > A less agressive path can be taken to recover the device, like only
> > > > resetting the control virtqueue.  However, the state of the device =
after
> > > > this action is taken races, as the vq could be reset after the devi=
ce
> > > > writes the OK.  Leaving TODO anyway.
> > > >
> > > > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > > > ---
> > > >  drivers/net/virtio_net.c | 10 ++++++++++
> > > >  1 file changed, 10 insertions(+)
> > > >
> > > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > > index 31bd32bdecaf..ed68ad69a019 100644
> > > > --- a/drivers/net/virtio_net.c
> > > > +++ b/drivers/net/virtio_net.c
> > > > @@ -3576,6 +3576,7 @@ static bool virtnet_send_command_reply(struct=
 virtnet_info *vi, u8 class, u8 cmd
> > > >  {
> > > >       struct scatterlist *sgs[5], hdr, stat;
> > > >       u32 out_num =3D 0, tmp, in_num =3D 0;
> > > > +     unsigned long end_time;
> > > >       bool ok;
> > > >       int ret;
> > > >
> > > > @@ -3614,11 +3615,20 @@ static bool virtnet_send_command_reply(stru=
ct virtnet_info *vi, u8 class, u8 cmd
> > > >
> > > >       /* Spin for a response, the kick causes an ioport write, trap=
ping
> > > >        * into the hypervisor, so the request should be handled imme=
diately.
> > > > +      *
> > > > +      * Long timeout so a malicious device is not able to lock rtn=
l forever.
> > > >        */
> > > > +     end_time =3D jiffies + 30 * HZ;
> > > >       while (!virtqueue_get_buf(vi->cvq, &tmp) &&
> > > >              !virtqueue_is_broken(vi->cvq)) {
> > > >               cond_resched();
> > > >               cpu_relax();
> > > > +
> > > > +             if (time_after(end_time, jiffies)) {
> > > > +                     /* TODO Reset vq if possible? */
> > > > +                     virtio_break_device(vi->vdev);
> > > > +                     break;
> > > > +             }
> > > >       }
> > > >
> > > >  unlock:
> > > > --
> > > > 2.51.0
> > >
>


