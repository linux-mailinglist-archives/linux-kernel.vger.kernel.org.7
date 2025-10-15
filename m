Return-Path: <linux-kernel+bounces-853757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E571BDC8A1
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 06:45:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 860BE351B5A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 04:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73E162FF140;
	Wed, 15 Oct 2025 04:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FOlmbeqX"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5CAD2FBE18
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 04:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760503504; cv=none; b=Qg2FJ/cjLpAA4N9sI45iNbt4b6vL6y4iwCi9X0AkxrGhitiiwelUbXtnNxoL7/zZakUvGzSxmaBPg7AsiYP2+DxczH+yhdmGZDSZZqQRNndPNz1jyX9brQYj8dDT/umTp2JdeXidLEDoj7il+6G5LrcTdCQieyHXp2shkaa9Mn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760503504; c=relaxed/simple;
	bh=LSC2b/SZp1Gl7xSk6Lw/gyf4cf3285mzXQOprivu0bo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VaUAl5VoDQPdfaacPecnG6dA67TLsuIpN90MfE6l2M4faYL4PDmcVPZa0O+BdMYm/GdbsFgp592HGD/ws93r8X+aps7vOVVH0j21U+40PoztqyvtfzD5Z+8l8dz3q71SvHXDkNOi/6Qzu7A8MTTETgZs+IdZvQx39nb2WpjkM2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FOlmbeqX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760503501;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fHoYpl/qIggxMNAcJsbGTBz+xXz4lxSJ0MRugYkIEII=;
	b=FOlmbeqXF72FrOVcizHMFJQXZFsCCZV+PQspr+Df9eWnbkpLipLYreUVzpf/3jxCisjtx7
	8kTTgENga+JaGOxhOR//D4FJQtN/1R0VmjhyqZ0cXdcq7Rlkdm+aUQNs9ujccSc1x1u8rT
	juZ6MDgqgRbLiC0aZVCdCmK+KzBvjbc=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-471-7BaOqDefMbOsBJiw8CwEvQ-1; Wed, 15 Oct 2025 00:45:00 -0400
X-MC-Unique: 7BaOqDefMbOsBJiw8CwEvQ-1
X-Mimecast-MFC-AGG-ID: 7BaOqDefMbOsBJiw8CwEvQ_1760503499
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3307af9b55eso9342508a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 21:44:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760503499; x=1761108299;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fHoYpl/qIggxMNAcJsbGTBz+xXz4lxSJ0MRugYkIEII=;
        b=noS6LsOiZkx34GcJ4eHNVJ/MpTN8nbpmyXRVoLJ0dG7KRsEHxOMtqUs56i7swbzJw7
         uWiUrS7AyetHJ1BE3TRT/bVN32Io+W/t5zghLqQAPCf3yi/BRfAO+szmm2rVUFepmXNZ
         76gf/vI43hz8ooofvoGVGHQ6IbfXuj4ZeMzRZC6f8FMjIw+CoURE2tfjEEOR6UKF1fYN
         FDsYl9gZRweEaI6LsM0xVUJPb1cpIR658V9urXVYI4VFsOEOb7juoIHmNlDBmQQHRI9d
         JbTmY3k5oCjvmxlSjx5YLsJW0Fjb541XrDi0KbhO4zxhEUq3QDD4dw9sVtr6SCf8Brln
         Sxpg==
X-Forwarded-Encrypted: i=1; AJvYcCUdOYidoGq/SkGjiupj9pvCV+kVqRL7FokG2HFiLcrExBK4OYz1yTrxxM2yOSAd/c7rZMXZEDSQW+mKzFE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywn/Lc6/lmrgAeZmEmfUzBKobF0LjCgb0unbSVAZr5XwqehZJZG
	lc7kRvlD0wpzyC+8FDmPcyBuocRfEYezTUc/HHX7Ud9WPQ5ylg3Q7U/4iNV3HjeCBr7fM1eEBuY
	NQoO5t9pq4Zia5Bh/yr7HgY3BxeUch53euycznxorBzsH9yrkYxCED5Q90H1NEQ984oF1ix0mLb
	vZzheckC8frTiKbZ7Dd0QEAzifPeePiJQqRu+r1JuD
X-Gm-Gg: ASbGncvS2Go3VtmWppT+hhh3Ypwkl/7LRf0f4DOOHR0BMVZaOXJAmlnPeft5Ckui6A7
	coM793lv+zM9yq4r3Y5PyCHKYAbWwnNR3pmMDGSAn1yn1DaaIACuboQhoO0AwAJVXUKDDGn/6Wa
	dgrsDsp0gqNCjRdlVTJKR56A==
X-Received: by 2002:a17:90b:52cc:b0:30a:4874:5397 with SMTP id 98e67ed59e1d1-33b511185e2mr37768137a91.9.1760503498778;
        Tue, 14 Oct 2025 21:44:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEUUG7KvPpgu2PoUpaCejKKLwvLLR4CU9yjeUizM/YHX9ytu/zSq05xQ+TuWMfC+xZEYoP6Jo/SXgn/94OmTVc=
X-Received: by 2002:a17:90b:52cc:b0:30a:4874:5397 with SMTP id
 98e67ed59e1d1-33b511185e2mr37768107a91.9.1760503498328; Tue, 14 Oct 2025
 21:44:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251007130622.144762-1-eperezma@redhat.com> <20251007130622.144762-2-eperezma@redhat.com>
 <20251014042459-mutt-send-email-mst@kernel.org> <CAO55cszGtuqL9qfs8SVB=Jjghefn=M0Rjw65f2DGPrjLQFFtqg@mail.gmail.com>
 <20251014051537-mutt-send-email-mst@kernel.org> <CAO55cswTyMBsKdpn7becsY4Ry+ZUoEfgP+2Q+DkhZ090VK_-2A@mail.gmail.com>
In-Reply-To: <CAO55cswTyMBsKdpn7becsY4Ry+ZUoEfgP+2Q+DkhZ090VK_-2A@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 15 Oct 2025 12:44:47 +0800
X-Gm-Features: AS18NWCpLV_Q4BfzxhayYNBKCHjXEh1dLniJamBX5d0_jeJRK-MbZ2aXW1QBTaw
Message-ID: <CACGkMEsqD1qAgt8qfV=fwj1OeBeXzoOF1wXdqzJaWYR2A=C+UA@mail.gmail.com>
Subject: Re: [RFC 1/2] virtio_net: timeout control virtqueue commands
To: Maxime Coquelin <mcoqueli@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Yongji Xie <xieyongji@bytedance.com>, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Dragos Tatulea DE <dtatulea@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 14, 2025 at 6:21=E2=80=AFPM Maxime Coquelin <mcoqueli@redhat.co=
m> wrote:
>
> On Tue, Oct 14, 2025 at 11:25=E2=80=AFAM Michael S. Tsirkin <mst@redhat.c=
om> wrote:
> >
> > On Tue, Oct 14, 2025 at 11:14:40AM +0200, Maxime Coquelin wrote:
> > > On Tue, Oct 14, 2025 at 10:29=E2=80=AFAM Michael S. Tsirkin <mst@redh=
at.com> wrote:
> > > >
> > > > On Tue, Oct 07, 2025 at 03:06:21PM +0200, Eugenio P=C3=A9rez wrote:
> > > > > An userland device implemented through VDUSE could take rtnl fore=
ver if
> > > > > the virtio-net driver is running on top of virtio_vdpa.  Let's br=
eak the
> > > > > device if it does not return the buffer in a longer-than-assumibl=
e
> > > > > timeout.
> > > >
> > > > So now I can't debug qemu with gdb because guest dies :(
> > > > Let's not break valid use-cases please.
> > > >
> > > >
> > > > Instead, solve it in vduse, probably by handling cvq within
> > > > kernel.
> > >
> > > Would a shadow control virtqueue implementation in the VDUSE driver w=
ork?
> > > It would ack systematically messages sent by the Virtio-net driver,
> > > and so assume the userspace application will Ack them.
> > >
> > > When the userspace application handles the message, if the handling f=
ails,
> > > it somehow marks the device as broken?
> > >
> > > Thanks,
> > > Maxime
> >
> > Yes but it's a bit more convoluted  than just acking them.
> > Once you use the buffer you can get another one and so on
> > with no limit.
> > One fix is to actually maintain device state in the
> > kernel, update it, and then notify userspace.
>
> I agree, this is the way to go.
>
> Thanks for your insights,
> Maxime

A timeout still needs to be considered in this case. Or I may miss somethin=
g?

Thanks

>
> >
> >
> > > >
> > > > > A less agressive path can be taken to recover the device, like on=
ly
> > > > > resetting the control virtqueue.  However, the state of the devic=
e after
> > > > > this action is taken races, as the vq could be reset after the de=
vice
> > > > > writes the OK.  Leaving TODO anyway.
> > > > >
> > > > > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > > > > ---
> > > > >  drivers/net/virtio_net.c | 10 ++++++++++
> > > > >  1 file changed, 10 insertions(+)
> > > > >
> > > > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > > > index 31bd32bdecaf..ed68ad69a019 100644
> > > > > --- a/drivers/net/virtio_net.c
> > > > > +++ b/drivers/net/virtio_net.c
> > > > > @@ -3576,6 +3576,7 @@ static bool virtnet_send_command_reply(stru=
ct virtnet_info *vi, u8 class, u8 cmd
> > > > >  {
> > > > >       struct scatterlist *sgs[5], hdr, stat;
> > > > >       u32 out_num =3D 0, tmp, in_num =3D 0;
> > > > > +     unsigned long end_time;
> > > > >       bool ok;
> > > > >       int ret;
> > > > >
> > > > > @@ -3614,11 +3615,20 @@ static bool virtnet_send_command_reply(st=
ruct virtnet_info *vi, u8 class, u8 cmd
> > > > >
> > > > >       /* Spin for a response, the kick causes an ioport write, tr=
apping
> > > > >        * into the hypervisor, so the request should be handled im=
mediately.
> > > > > +      *
> > > > > +      * Long timeout so a malicious device is not able to lock r=
tnl forever.
> > > > >        */
> > > > > +     end_time =3D jiffies + 30 * HZ;
> > > > >       while (!virtqueue_get_buf(vi->cvq, &tmp) &&
> > > > >              !virtqueue_is_broken(vi->cvq)) {
> > > > >               cond_resched();
> > > > >               cpu_relax();
> > > > > +
> > > > > +             if (time_after(end_time, jiffies)) {
> > > > > +                     /* TODO Reset vq if possible? */
> > > > > +                     virtio_break_device(vi->vdev);
> > > > > +                     break;
> > > > > +             }
> > > > >       }
> > > > >
> > > > >  unlock:
> > > > > --
> > > > > 2.51.0
> > > >
> >
>


