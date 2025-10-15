Return-Path: <linux-kernel+bounces-853814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7152FBDCA8F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 08:09:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 253574E0664
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 06:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CE67302CCD;
	Wed, 15 Oct 2025 06:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CkS/Vlca"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC2C2FB0B6
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 06:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760508555; cv=none; b=LKXvJl90XADWlES3t+CAb46lNJmOZix9vZwgtOEtqDH/tHLHymn4g1dvqS4PmfVd95e/WI4M2dCFX1AOln3MQIfcBIT3SBgqV/igXo5BNR0hcCdHRFynfNhRN7aXArSPIJkiQZvOwK+H3FK+HbuBoFObtiDa0QV9cNAHjwoeaLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760508555; c=relaxed/simple;
	bh=7yHb7V7FxR4Anis0rw9S3yBVPwoAcym+T5NuHmX3i+I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZdhAWJTsFjZ99RjwnYpNxadxOicnJrWP7YZ+3b0re65DLPYIpbM5oCzk3I1RsxsO9dydLJtV1WKNGQezUASS5T/XDFTknQaepCov9J1UnvdUd4ycw4iTpJr2wrZNEPKoO3w6MQca9Xosb8ntV7q9JNDTekJYubKAcLy1g9sG9PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CkS/Vlca; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760508552;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XBi3qvybR9EFvEz+7rVsJKcgMhvZptbfiLDD5q6qnlg=;
	b=CkS/VlcanluH4uKbvEgEhV04R1mSFhexVJ2lb4flmkdH1RKEbfi8jhYO8UHF0iB2BKhJIo
	V7LGSq5UzyxqGjflvfXL7JwXXrqDfQBIUVxc4+RjQR49OWaeRkAsbExOzw3cq0eVfSnMjA
	iWyCXKJvycors3Vccz9oPdcBFuwppEU=
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com
 [74.125.224.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-331-3xbSsqicP86MUYYHEBdlIQ-1; Wed, 15 Oct 2025 02:09:10 -0400
X-MC-Unique: 3xbSsqicP86MUYYHEBdlIQ-1
X-Mimecast-MFC-AGG-ID: 3xbSsqicP86MUYYHEBdlIQ_1760508550
Received: by mail-yx1-f71.google.com with SMTP id 956f58d0204a3-636d73ba36bso11747741d50.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 23:09:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760508549; x=1761113349;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XBi3qvybR9EFvEz+7rVsJKcgMhvZptbfiLDD5q6qnlg=;
        b=Y9slyOjIxTZZ7G72ac/hsQeMfjcyOv9fK+94Uowx5h2r5JqZUEsinDW1ut2vdXwzqQ
         k7sVBqHwzW5fxBHxFSi81sfMFVLb/9D/rzAyAIvY97uVzx/sQbGhChGrsS1y/WJi2gEE
         ovPnhG7K/EA7YBk7vV2OJKtY1bORO3w/ClH5Tqr7y5XCVxERvcdnwxLXieJCU/eBG/hz
         gFXe5Fukxw4IAvv7ZBKtg+LvbDQPMsRWU8XHBdTEIyOrQX5q8GHOgPk1/eh8ymhgnyJ0
         dWD8r8hC5MTploui+A7AJh1u8a1G1ahZb7VKxoS0/sZpW/a8vXs5lwAs+fPABno1U/uC
         T+bQ==
X-Forwarded-Encrypted: i=1; AJvYcCUcuwLByh2hm54nal4YdlKSPqe3fnlluFvimUqCd99o7Xk+ZR9xfVK5Vb6hvsk2r2CuJfZnMMYAxNfZkj4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtDn9bn13rSuguaiJtQJPDHj92YguTgT/jVKtsAro4HUV1dhz7
	l7pzpN2Tdh493Jj8H72PmGHo3VL8k7m6Xg4HjdXJcUOiSDLhklACs0/oCOo0tdODb4PqBXNRQ/f
	A+Rgd7j7ey/VbjBvjPN5wxRDPs7+mD65CXB39INw8eItpMOEliWPfcTNNgbKvknU7BA+BNEq5Ru
	vU9VdyjEatpvIWm/kU4jRj1P7pad62S45Ltmfc4/L3xTZGnnsY/uc=
X-Gm-Gg: ASbGnct23pyOLe7LrcX3JnQ/IjBHhrPXcRUVTT2FE6SechCxQs8/ob/r3aFV0dN8g1i
	3dMRSYxW2oNQBSqa21k3ujN9i7sBaNNk/l++SBeGmRfyIQ8y0s5e8RMkRPBgOxjFv/7QWXFh7LQ
	r08GhTtd7mnSezYHYMTOZRgI3Q2kelEdgjlg/aUp4SF+9jrwIKk6vkAJVhyZrJ0ff8k42pSsdMR
	wwBvTwc
X-Received: by 2002:a53:8650:0:b0:604:3849:9bd1 with SMTP id 956f58d0204a3-63ccb851a6cmr18577920d50.17.1760508549344;
        Tue, 14 Oct 2025 23:09:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF7NrkJrmsbjMLLIbQGJdNBHE3ddxwQ7lrfGtO7MVJtAW5Fm9WJ0LeQC7cXH02MDz8p0wTJ+RfvcMHcPMLKJOI=
X-Received: by 2002:a53:8650:0:b0:604:3849:9bd1 with SMTP id
 956f58d0204a3-63ccb851a6cmr18577914d50.17.1760508548996; Tue, 14 Oct 2025
 23:09:08 -0700 (PDT)
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
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 15 Oct 2025 08:08:31 +0200
X-Gm-Features: AS18NWAssLwaCeDys0qGLVAgspxlbGwh6Vs-twVmCChXDZBs4fMs1s_gyf1-be0
Message-ID: <CAJaqyWe-mn4e+1egNCH+R1x4R7DB6U1SZ-mRAXYPTtA27hKCVA@mail.gmail.com>
Subject: Re: [RFC 1/2] virtio_net: timeout control virtqueue commands
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Maxime Coquelin <mcoqueli@redhat.com>, Yongji Xie <xieyongji@bytedance.com>, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Dragos Tatulea DE <dtatulea@nvidia.com>, jasowang@redhat.com
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
>

I thought of implementing this approach at first, but it has two drawbacks.

The first one: it's racy. Let's say the driver updates the MAC filter,
VDUSE timeout occurs, the guest receives the fail, and then the device
replies with an OK. There is no way for the device or VDUSE to update
the driver.

The second one, what to do when the VDUSE cvq runs out of descriptors?
While the driver has its descriptor returned with VIRTIO_NET_ERR, the
VDUSE CVQ has the descriptor available. If this process repeats to
make available all of the VDUSE CVQ descriptors, how can we proceed?

I think both of them can be solved with the DEVICE_NEEDS_RESET status
bit, but it is not implemented in the drivers at this moment.


