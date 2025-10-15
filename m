Return-Path: <linux-kernel+bounces-853971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 90FDDBDD2EC
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 09:45:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C74814EE714
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 07:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FA482C026F;
	Wed, 15 Oct 2025 07:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eeNj1vyP"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09E59478
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 07:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760514342; cv=none; b=QCi0EY0xV7yAG7jCDwOmB2d+Wk5m1RXhNm65N7/7nSvihhsvWL+B4piZOQoMulCfhycu/mlKBDrCjOzhTn2Jajc31W45Q6YbFc3ikLfkE7VAdYqpqDZcWF7e21SCPQx06gGFm4SEw0T2qhU+x0jDHsWLoXPn6PDxKjubOw5czUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760514342; c=relaxed/simple;
	bh=td875+Fh9lw5w16PBTZzPAomZtSgmujnirC7oXVn1I0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AiUsSwtNJONlVYsJZIzH9kor6u98W1rkn6N/gJ7RQAcm6ARpMXMiKQ5w0Z6sHpbvCbjlddYWBNzV7XCWEMq4zCqLFktYIlJ2FAqfo7+IRzM736PfHX+/c10U0pEVrywIgoPH12kr06V9hiI7/w/6Uj+1RydQk+fDlRf0+FulQac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eeNj1vyP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760514339;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/rbWOVwpa2m4wtu2whE72TL+I902wYR9W02WjI14MQE=;
	b=eeNj1vyP6wpMzUfg+gO6m0I+EeSRpE/1ERgZpv4aKDa+Kz5aO22EmFZNXwWr8+Re6SKBYV
	ha90evPzQDAyA53dZMq6nKYM0XGlb/HWYF28RURIwRcXUy5NdRf3E52SR9U4lMfHRwlFQE
	YkxhUEMvtHWFrkGVPU4fqrqFmYLnZo0=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-eecakDOLPrCUHpvvGB4few-1; Wed, 15 Oct 2025 03:45:38 -0400
X-MC-Unique: eecakDOLPrCUHpvvGB4few-1
X-Mimecast-MFC-AGG-ID: eecakDOLPrCUHpvvGB4few_1760514338
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-74983d5be0bso15905497b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 00:45:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760514338; x=1761119138;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/rbWOVwpa2m4wtu2whE72TL+I902wYR9W02WjI14MQE=;
        b=pizabtgHgtaQAelalgy2vzAHynTcHpqWWBjwLGWIikP+fk1w/yUpY/daJJQ45wMz47
         C2YirrqriuWSbDEu+rZcC8NBwSbqBPcEHKVhhzkdxFYNVucrv+n/7IiN6uiVBGx39HnI
         M/4xF33rXSX0nYQwIhLntm4BG33T6HSQyCNdGfNcUR+u3BjtvP2cDvZF/VGMLNT3NGFm
         mdkQ/yIWLeghCyBEPsm1nJtEbtpzTOilRrK/yzo+clleHLtDCGLalVkZ0kxJU9NgcMj4
         1ENsi5YeRgn3r8Ogb1HIQlW5wLevttsze5W2K4Zg95IowFDrajDTYHMeosNooPoQb/br
         B8wg==
X-Forwarded-Encrypted: i=1; AJvYcCUExe+Iw5Ddn3tKn3ViWeap8JCnWZ5HNNxV5PRg3hlHtcOUb9FEwYs2zzo5dj3TDb4blcgkax+8gtpEPtg=@vger.kernel.org
X-Gm-Message-State: AOJu0YweU9UMUhsUIAh7LhuR9RvcDON8eulk2g6DA0qOCoKcFNyqzbIL
	EGGgM++QH5uXmxXpI5A9oOebaRtQPbsRWjzWOW71lAOTaMRx57wALNpqCkw9epEyiVZh+kNEK71
	fvHe1NpjDOdxjXrz8QRyP586wBPr2wUboaaZ/VsxugDwQIBQlnxLT9G+sI20ffsRbHE5MAoy38Y
	Ry1LuQ/aWJIL9eqC29FWarwadMBgy9LOyXrFFQJXMi
X-Gm-Gg: ASbGncv9MmznIE5WOEh0nG40CX45rlMUJmzvAbzcbtUDflP8yuE8PmNvPCp0JC7MUP3
	mbJXU9CAYuTyucf4M/Zn9gUoMWP/rvrAkxm0zrB//5Xw7ZzruVJLQ1RMG8Vj+qXChtp7TM/Omrs
	6CWnekJaXZsLxaXo95w6MHO1pJ57T35FX4WnGWnSPkGSynB/edAsm46oE2xGH243ePPt3DS1/CH
	N64d3/W
X-Received: by 2002:a05:690e:4250:b0:636:1f5d:b60a with SMTP id 956f58d0204a3-63cbe087551mr23174839d50.7.1760514337819;
        Wed, 15 Oct 2025 00:45:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEs81mpQ4wkDOe+ttYnJ2/87b5bmhO5OaUosq2hzP6/6mssB8BNlxvF0XOiOkLqxlGgoL4FtAfM/lfxnt5v07w=
X-Received: by 2002:a05:690e:4250:b0:636:1f5d:b60a with SMTP id
 956f58d0204a3-63cbe087551mr23174829d50.7.1760514337436; Wed, 15 Oct 2025
 00:45:37 -0700 (PDT)
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
 <20251015030313-mutt-send-email-mst@kernel.org>
In-Reply-To: <20251015030313-mutt-send-email-mst@kernel.org>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 15 Oct 2025 09:45:01 +0200
X-Gm-Features: AS18NWCiPyCG3C1pPFZJeZwWLCjgJaY3_QS3-tGJPLv7i0gOSXBx73ih53afnpY
Message-ID: <CAJaqyWfRmhXM8eV+=wMVKgrc8SJ98OTtBCtNDJj8ZRUM5Y9Nmg@mail.gmail.com>
Subject: Re: [RFC 1/2] virtio_net: timeout control virtqueue commands
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Maxime Coquelin <mcoqueli@redhat.com>, Yongji Xie <xieyongji@bytedance.com>, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Dragos Tatulea DE <dtatulea@nvidia.com>, jasowang@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 15, 2025 at 9:05=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Wed, Oct 15, 2025 at 08:52:50AM +0200, Eugenio Perez Martin wrote:
> > On Wed, Oct 15, 2025 at 8:33=E2=80=AFAM Michael S. Tsirkin <mst@redhat.=
com> wrote:
> > >
> > > On Wed, Oct 15, 2025 at 08:08:31AM +0200, Eugenio Perez Martin wrote:
> > > > On Tue, Oct 14, 2025 at 11:25=E2=80=AFAM Michael S. Tsirkin <mst@re=
dhat.com> wrote:
> > > > >
> > > > > On Tue, Oct 14, 2025 at 11:14:40AM +0200, Maxime Coquelin wrote:
> > > > > > On Tue, Oct 14, 2025 at 10:29=E2=80=AFAM Michael S. Tsirkin <ms=
t@redhat.com> wrote:
> > > > > > >
> > > > > > > On Tue, Oct 07, 2025 at 03:06:21PM +0200, Eugenio P=C3=A9rez =
wrote:
> > > > > > > > An userland device implemented through VDUSE could take rtn=
l forever if
> > > > > > > > the virtio-net driver is running on top of virtio_vdpa.  Le=
t's break the
> > > > > > > > device if it does not return the buffer in a longer-than-as=
sumible
> > > > > > > > timeout.
> > > > > > >
> > > > > > > So now I can't debug qemu with gdb because guest dies :(
> > > > > > > Let's not break valid use-cases please.
> > > > > > >
> > > > > > >
> > > > > > > Instead, solve it in vduse, probably by handling cvq within
> > > > > > > kernel.
> > > > > >
> > > > > > Would a shadow control virtqueue implementation in the VDUSE dr=
iver work?
> > > > > > It would ack systematically messages sent by the Virtio-net dri=
ver,
> > > > > > and so assume the userspace application will Ack them.
> > > > > >
> > > > > > When the userspace application handles the message, if the hand=
ling fails,
> > > > > > it somehow marks the device as broken?
> > > > > >
> > > > > > Thanks,
> > > > > > Maxime
> > > > >
> > > > > Yes but it's a bit more convoluted  than just acking them.
> > > > > Once you use the buffer you can get another one and so on
> > > > > with no limit.
> > > > > One fix is to actually maintain device state in the
> > > > > kernel, update it, and then notify userspace.
> > > > >
> > > >
> > > > I thought of implementing this approach at first, but it has two dr=
awbacks.
> > > >
> > > > The first one: it's racy. Let's say the driver updates the MAC filt=
er,
> > > > VDUSE timeout occurs, the guest receives the fail, and then the dev=
ice
> > > > replies with an OK. There is no way for the device or VDUSE to upda=
te
> > > > the driver.
> > >
> > > There's no timeout. Kernel can guarantee executing all requests.
> > >
> >
> > I don't follow this. How should the VDUSE kernel module act if the
> > VDUSE userland device does not use the CVQ buffer then?
>
> First I am not sure a VQ is the best interface for talking to userspace.
> But assuming yes - just avoid sending more data, send it later after
> userspace used the buffer.
>

Let me take a step back, I think I didn't describe the scenario well enough=
.

We have a VDUSE device, and then the same host is interacting with the
device through the virtio_net driver over virtio_vdpa.

Then, the virtio_net driver sends a control command though its CVQ, so
it *takes the RTNL*. That command reaches the VDUSE CVQ.

It does not matter if the VDUSE device in the userland processes the
commands through a CVQ, reading the vduse character device, or another
system. The question is: what to do if the VDUSE device does not
process that command in a timely manner? Should we just let the RTNL
be taken forever?


