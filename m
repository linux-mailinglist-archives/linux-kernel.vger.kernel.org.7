Return-Path: <linux-kernel+bounces-853813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B5F98BDCA86
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 08:08:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0A3D14E2CFA
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 06:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3F36302CAB;
	Wed, 15 Oct 2025 06:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MSfr6Fsk"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 690072FB0B6
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 06:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760508489; cv=none; b=l64njEhzVcSHfKY2ufmK9fxr+JRRCAWGXgdA02JiaYw74NUUfVeKfdjiYoJHOpGmiX3YP+cpc/yeso/WqfnfdjmuXk2/f6lrKuXQwTwU854GEn2RZ6lgbk0NU+mQOE+8TVVO9fsKWy4FLgTEihX5HipRXcBg5Y48cUDvXycZg24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760508489; c=relaxed/simple;
	bh=NJiRt76dTbkJ4xrmV7ry3jBdOkRCmOO9abjget4+0ZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BNLcU4D7/ifBzhftOzSlfovhn9fw7Jt+HI6x/Or3rdNTcKt/EbHhf1ghkhfTiIOiIQHxD+m5ZmXfFDox/E4l+o14FHNrPgFZ4hGXX9w/TONeLlVVTEM8baQr3KHmp3dfYkekepY72VhH4hEu5zp8i8gkxiUAZ3XyDhyMbrtfOaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MSfr6Fsk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760508486;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MIFmfXL90OL8IaHK+O7WfgGi7yW4MSc3y23FO0z51Bw=;
	b=MSfr6FskXBSRvxtGHcc4o9rFAEw2rJi5JspOXs3q1k+tFEU10ddZpPGMIgQCFDflF6+Yzu
	DugiHxn49QuUdQiuuAO3EtkILl41biNHTPlsA6kv5R7RcS2r/ax1ij3BrAhzL43IgwYZFV
	r2RfiQLxBGABIZ8DyO6Z614CurymMqI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-QGLIHILAPXm3jGvs4wvSiA-1; Wed, 15 Oct 2025 02:08:02 -0400
X-MC-Unique: QGLIHILAPXm3jGvs4wvSiA-1
X-Mimecast-MFC-AGG-ID: QGLIHILAPXm3jGvs4wvSiA_1760508481
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-426ce339084so4479375f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 23:08:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760508481; x=1761113281;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MIFmfXL90OL8IaHK+O7WfgGi7yW4MSc3y23FO0z51Bw=;
        b=MY34pB4XbE++Ej0lg0QSRsZMQPttScCk1IFsoT0lGgq/H3UZvo7f9zaCWoHOKztwfD
         9bWlYaCxJbIfbUSZ+iSZOEcMEfmXC+WOwLUI7gYcLgKNxHVxyRE2e6gAljJt65QgveH5
         1BDgIQB2JZsSheOr/0hU4NXDh6LbHQLnnxyROFt/SdZqJVWKkj1se0elYuc3K+gXwCxZ
         bkIn+Ic+roYV3Kv48tbprlNwSUjM8DmACNQQcJ8MQRKo7ZqR/2JBie9trRla+uVarLzU
         wRVeZKIz/PApQrUvGuVysZC1E1fpdaeGiBUzJw/TdPveX6luvqGrRMxZQcJc7E9x0VFE
         TZjg==
X-Forwarded-Encrypted: i=1; AJvYcCUEU9CmOyRgY7VUyTvPGiHMU1kkzNOAtKtCMQ5V7odoTFPr7IS9uKMGd50kTr4qyTbivPzcDOdiZSra2pY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkGylLwMFOPP6W6EBnW2fMMG5xCGRI5orfEVISRQeGnIiojKWa
	RsXCvzUXZcR1WCyLEFUNdQ7JC+JfMrKypLC2pJ5/g3wLrsFLWKiZgm2FzGcsyPnXPgZGKs9+dhd
	/76ZyPx+ZsPx/3xRARQ1j34fk1IZbTQiNpeit4xdIrEDFgP2zhKApkmKuGLNh8kpdKA==
X-Gm-Gg: ASbGnctLhmuzX1eWYitZ9ay8xH+Un1nSWNxDwpku5H76inzq1wONV2uNsFdN1xz3ZRX
	DPwYqviozunQ4WJPFvUDCIo3YYXkw9t6rKcbrksvjdgSb6flpHQ7s45YeiFLF/HtZCpd4WNgMOr
	edw+95MUSxgqnI6aqA3Kd5+dSF1ASV/T9+TXUL/dTQ+Q4oVGe5gaVjRqrHvmt/X6et00hJB7lsj
	r9LWA4Hi5s/nuD+dKTmnKFCPm45bNiqzzjRCRY1+etBBUKsO9sf17ahEk+IFlER2T9YEBupOBd/
	3oQz/Azg92u4eyOd0/PDDTBcq9kS2txJuQ==
X-Received: by 2002:a05:6000:4205:b0:3f7:b7ac:f3d2 with SMTP id ffacd0b85a97d-4266f752fb9mr16997286f8f.43.1760508481220;
        Tue, 14 Oct 2025 23:08:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHo4zy/2ZSFghJwm9U3Fa/LOQMyZhQqIGJ9fyNuM2dBeXBWUD0UpUGr6S550pkPgJhtuk1XzQ==
X-Received: by 2002:a05:6000:4205:b0:3f7:b7ac:f3d2 with SMTP id ffacd0b85a97d-4266f752fb9mr16997267f8f.43.1760508480741;
        Tue, 14 Oct 2025 23:08:00 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:152d:b200:2a90:8f13:7c1e:f479])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce582a9csm27152693f8f.12.2025.10.14.23.07.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 23:08:00 -0700 (PDT)
Date: Wed, 15 Oct 2025 02:07:57 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Maxime Coquelin <mcoqueli@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Yongji Xie <xieyongji@bytedance.com>,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Dragos Tatulea DE <dtatulea@nvidia.com>
Subject: Re: [RFC 1/2] virtio_net: timeout control virtqueue commands
Message-ID: <20251015020717-mutt-send-email-mst@kernel.org>
References: <20251007130622.144762-1-eperezma@redhat.com>
 <20251007130622.144762-2-eperezma@redhat.com>
 <20251014042459-mutt-send-email-mst@kernel.org>
 <CAO55cszGtuqL9qfs8SVB=Jjghefn=M0Rjw65f2DGPrjLQFFtqg@mail.gmail.com>
 <20251014051537-mutt-send-email-mst@kernel.org>
 <CAO55cswTyMBsKdpn7becsY4Ry+ZUoEfgP+2Q+DkhZ090VK_-2A@mail.gmail.com>
 <CACGkMEsqD1qAgt8qfV=fwj1OeBeXzoOF1wXdqzJaWYR2A=C+UA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEsqD1qAgt8qfV=fwj1OeBeXzoOF1wXdqzJaWYR2A=C+UA@mail.gmail.com>

On Wed, Oct 15, 2025 at 12:44:47PM +0800, Jason Wang wrote:
> On Tue, Oct 14, 2025 at 6:21 PM Maxime Coquelin <mcoqueli@redhat.com> wrote:
> >
> > On Tue, Oct 14, 2025 at 11:25 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> > >
> > > On Tue, Oct 14, 2025 at 11:14:40AM +0200, Maxime Coquelin wrote:
> > > > On Tue, Oct 14, 2025 at 10:29 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > >
> > > > > On Tue, Oct 07, 2025 at 03:06:21PM +0200, Eugenio Pérez wrote:
> > > > > > An userland device implemented through VDUSE could take rtnl forever if
> > > > > > the virtio-net driver is running on top of virtio_vdpa.  Let's break the
> > > > > > device if it does not return the buffer in a longer-than-assumible
> > > > > > timeout.
> > > > >
> > > > > So now I can't debug qemu with gdb because guest dies :(
> > > > > Let's not break valid use-cases please.
> > > > >
> > > > >
> > > > > Instead, solve it in vduse, probably by handling cvq within
> > > > > kernel.
> > > >
> > > > Would a shadow control virtqueue implementation in the VDUSE driver work?
> > > > It would ack systematically messages sent by the Virtio-net driver,
> > > > and so assume the userspace application will Ack them.
> > > >
> > > > When the userspace application handles the message, if the handling fails,
> > > > it somehow marks the device as broken?
> > > >
> > > > Thanks,
> > > > Maxime
> > >
> > > Yes but it's a bit more convoluted  than just acking them.
> > > Once you use the buffer you can get another one and so on
> > > with no limit.
> > > One fix is to actually maintain device state in the
> > > kernel, update it, and then notify userspace.
> >
> > I agree, this is the way to go.
> >
> > Thanks for your insights,
> > Maxime
> 
> A timeout still needs to be considered in this case. Or I may miss something?
> 
> Thanks

Not as such, kernel can use buffers (semi) predictably.

> >
> > >
> > >
> > > > >
> > > > > > A less agressive path can be taken to recover the device, like only
> > > > > > resetting the control virtqueue.  However, the state of the device after
> > > > > > this action is taken races, as the vq could be reset after the device
> > > > > > writes the OK.  Leaving TODO anyway.
> > > > > >
> > > > > > Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
> > > > > > ---
> > > > > >  drivers/net/virtio_net.c | 10 ++++++++++
> > > > > >  1 file changed, 10 insertions(+)
> > > > > >
> > > > > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > > > > index 31bd32bdecaf..ed68ad69a019 100644
> > > > > > --- a/drivers/net/virtio_net.c
> > > > > > +++ b/drivers/net/virtio_net.c
> > > > > > @@ -3576,6 +3576,7 @@ static bool virtnet_send_command_reply(struct virtnet_info *vi, u8 class, u8 cmd
> > > > > >  {
> > > > > >       struct scatterlist *sgs[5], hdr, stat;
> > > > > >       u32 out_num = 0, tmp, in_num = 0;
> > > > > > +     unsigned long end_time;
> > > > > >       bool ok;
> > > > > >       int ret;
> > > > > >
> > > > > > @@ -3614,11 +3615,20 @@ static bool virtnet_send_command_reply(struct virtnet_info *vi, u8 class, u8 cmd
> > > > > >
> > > > > >       /* Spin for a response, the kick causes an ioport write, trapping
> > > > > >        * into the hypervisor, so the request should be handled immediately.
> > > > > > +      *
> > > > > > +      * Long timeout so a malicious device is not able to lock rtnl forever.
> > > > > >        */
> > > > > > +     end_time = jiffies + 30 * HZ;
> > > > > >       while (!virtqueue_get_buf(vi->cvq, &tmp) &&
> > > > > >              !virtqueue_is_broken(vi->cvq)) {
> > > > > >               cond_resched();
> > > > > >               cpu_relax();
> > > > > > +
> > > > > > +             if (time_after(end_time, jiffies)) {
> > > > > > +                     /* TODO Reset vq if possible? */
> > > > > > +                     virtio_break_device(vi->vdev);
> > > > > > +                     break;
> > > > > > +             }
> > > > > >       }
> > > > > >
> > > > > >  unlock:
> > > > > > --
> > > > > > 2.51.0
> > > > >
> > >
> >


