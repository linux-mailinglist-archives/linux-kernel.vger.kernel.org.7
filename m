Return-Path: <linux-kernel+bounces-852198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 782A2BD86D0
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 11:25:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBB1A192187E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 09:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A222E2E7160;
	Tue, 14 Oct 2025 09:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LK4uOVBN"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B8B25D546
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 09:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760433940; cv=none; b=hzR4SM10R7SLiJjQbIwssghTrbtkin139q5raPh/SolqqOcSZ1EXTVNSWeXgcHzkelppsB4rztDMC6mrGAOc81S/W1+Ryff08z0p2ipdDY7Oz9KV9om5638UiH/e7npM9Uk1K+AjmYc6MxzIsLus98VK+FxrS9gllp+knruktSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760433940; c=relaxed/simple;
	bh=rZCAygjY0OWPeTvsMe7UoXhWjSZufdU/LV1/KfHjJRU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ax7/37J1DBi4hYY1MIDgqMVx0VQBar8ZzrklGIAw1PEZZWvdfcf8k8n6X5HpOknYhXrvCAU4tGu1VJCNFzBdXDt9kAOg4jXV3CoDJGItXVMFCp0yOzWMtBJ5lmMzSTR6U6e27UlJ/27Lb0A9/2ZYEqSDKzYWjUQkUJt7YDIcoKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LK4uOVBN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760433936;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PfLdBJrnTMVkOACQmFhZRlAwlSYvcBsyR97wH5UAbz4=;
	b=LK4uOVBNgBuVGhYeXWYKuLCJtWkhdgkQdidSjF3onDLLdBm0Sd8x5fNbiO7E0WcB5DieK0
	6CUHR+4Um59D5oczQ+libTwJjoW5r/HlJUt203x95FwdOVT9PebfF39HmA1GssU3Hc4aqI
	M/LxBX31ERphlOz1zcqrHsHZw0kDA8o=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-694-P-hHgAvTNSetomZdwLBV_g-1; Tue, 14 Oct 2025 05:25:35 -0400
X-MC-Unique: P-hHgAvTNSetomZdwLBV_g-1
X-Mimecast-MFC-AGG-ID: P-hHgAvTNSetomZdwLBV_g_1760433934
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3efe4fcc9ccso4405709f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 02:25:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760433934; x=1761038734;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PfLdBJrnTMVkOACQmFhZRlAwlSYvcBsyR97wH5UAbz4=;
        b=iRz9ZhL8uPqH5IkFdbSGeBPSCwbR1lsWdzcM63vXWimuwS7fuHV/g8d6ca9cBnIPsR
         XNxN0dQz5Bf+uTJye2pf7WipGK04jTPe3JZvgmIZ2pqREht+yTsUdYmfNpG6JXN9NSYa
         do/kZeU6lLQ/d/X34OS54OF+lw2JO+uMXyNckuY36KTiIaSTztS+KXDiVFtv7SF4d8Fz
         3x9VtG4aAbEkBMp16on4ayeEko9G5QPfmMdVPMTFpExoSGKOeRA90RZRx8E5YZ9ZhcN+
         eIrdniURbPdGXpk05LhkRM88rMPkHfenC3FXVhdor/UjVwgJLnPCAx3xMeY+x8od7Jqo
         qcLg==
X-Forwarded-Encrypted: i=1; AJvYcCWGpZTQve24LouEyWOzAOcjEmMp+JPdM+wjhLRCNXnRTEFg4RBvrz4lheVvMfhIFG6MfAyKF/929npyZ24=@vger.kernel.org
X-Gm-Message-State: AOJu0YwO26v+EjSjFhPjEeYvzRxuznzmur82ZqywZA03NpEs8p4w9XwP
	nRa2o0qEw/c7Wp20KKuCKUGlrCIT01qrmzWS6nhkCyrmhBLdBmRpEeyvm/a+tOtg+DLxzDUO3Zk
	TdWB6NSnEGGBHhYVYvYeqalBRQl6gwAfjVtsKgsTeLavZRn7TPCJBOfJi0Hvr+xk8nCWc1wlPPY
	do
X-Gm-Gg: ASbGncuc9FxtcGaaC1TEyAHpqGHZr9Jhy0EKG/8aGAiAv9fYJjKmJWvb1w4CyFx/hZL
	CEN56e3sDRu62TbYAl4KNDE21QdIWdD1icEM/+0hxIO2hOcrQnmWbqodmQd09UkYweMQX0TeYp+
	gxD5Nt+O0KTGNJI0OI2xXX4FRYfgF2VXKhYalBECir7iGq5ae5kOTeDA2Rh+qoBEWDe23FUJQfg
	kIRo/LLWyUcEKU9uWCLNPk6nH0XeVLkDvDT+4bhcaF/sIH+ZEypxZ/sPrGQ36VAL1Z1sgO13R6N
	/LCBRNtJQ+wSZvBJRriwx/VgcFiZe28C0w==
X-Received: by 2002:a05:6000:2485:b0:425:8133:ec6c with SMTP id ffacd0b85a97d-42666ac634cmr13951508f8f.9.1760433934212;
        Tue, 14 Oct 2025 02:25:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFNy4HULkh4edX8RYJTZCVGTdNQF7IsmD0wybDN7UvL+JUlMATmv35cRvOQ3uVINtBjnY95mQ==
X-Received: by 2002:a05:6000:2485:b0:425:8133:ec6c with SMTP id ffacd0b85a97d-42666ac634cmr13951481f8f.9.1760433933753;
        Tue, 14 Oct 2025 02:25:33 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:152d:b200:2a90:8f13:7c1e:f479])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5e8141sm22498086f8f.48.2025.10.14.02.25.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 02:25:33 -0700 (PDT)
Date: Tue, 14 Oct 2025 05:25:30 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Maxime Coquelin <mcoqueli@redhat.com>
Cc: Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Yongji Xie <xieyongji@bytedance.com>,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Dragos Tatulea DE <dtatulea@nvidia.com>, jasowang@redhat.com
Subject: Re: [RFC 1/2] virtio_net: timeout control virtqueue commands
Message-ID: <20251014051537-mutt-send-email-mst@kernel.org>
References: <20251007130622.144762-1-eperezma@redhat.com>
 <20251007130622.144762-2-eperezma@redhat.com>
 <20251014042459-mutt-send-email-mst@kernel.org>
 <CAO55cszGtuqL9qfs8SVB=Jjghefn=M0Rjw65f2DGPrjLQFFtqg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAO55cszGtuqL9qfs8SVB=Jjghefn=M0Rjw65f2DGPrjLQFFtqg@mail.gmail.com>

On Tue, Oct 14, 2025 at 11:14:40AM +0200, Maxime Coquelin wrote:
> On Tue, Oct 14, 2025 at 10:29 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Tue, Oct 07, 2025 at 03:06:21PM +0200, Eugenio Pérez wrote:
> > > An userland device implemented through VDUSE could take rtnl forever if
> > > the virtio-net driver is running on top of virtio_vdpa.  Let's break the
> > > device if it does not return the buffer in a longer-than-assumible
> > > timeout.
> >
> > So now I can't debug qemu with gdb because guest dies :(
> > Let's not break valid use-cases please.
> >
> >
> > Instead, solve it in vduse, probably by handling cvq within
> > kernel.
> 
> Would a shadow control virtqueue implementation in the VDUSE driver work?
> It would ack systematically messages sent by the Virtio-net driver,
> and so assume the userspace application will Ack them.
> 
> When the userspace application handles the message, if the handling fails,
> it somehow marks the device as broken?
> 
> Thanks,
> Maxime

Yes but it's a bit more convoluted  than just acking them.
Once you use the buffer you can get another one and so on
with no limit.
One fix is to actually maintain device state in the
kernel, update it, and then notify userspace.



> >
> > > A less agressive path can be taken to recover the device, like only
> > > resetting the control virtqueue.  However, the state of the device after
> > > this action is taken races, as the vq could be reset after the device
> > > writes the OK.  Leaving TODO anyway.
> > >
> > > Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
> > > ---
> > >  drivers/net/virtio_net.c | 10 ++++++++++
> > >  1 file changed, 10 insertions(+)
> > >
> > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > index 31bd32bdecaf..ed68ad69a019 100644
> > > --- a/drivers/net/virtio_net.c
> > > +++ b/drivers/net/virtio_net.c
> > > @@ -3576,6 +3576,7 @@ static bool virtnet_send_command_reply(struct virtnet_info *vi, u8 class, u8 cmd
> > >  {
> > >       struct scatterlist *sgs[5], hdr, stat;
> > >       u32 out_num = 0, tmp, in_num = 0;
> > > +     unsigned long end_time;
> > >       bool ok;
> > >       int ret;
> > >
> > > @@ -3614,11 +3615,20 @@ static bool virtnet_send_command_reply(struct virtnet_info *vi, u8 class, u8 cmd
> > >
> > >       /* Spin for a response, the kick causes an ioport write, trapping
> > >        * into the hypervisor, so the request should be handled immediately.
> > > +      *
> > > +      * Long timeout so a malicious device is not able to lock rtnl forever.
> > >        */
> > > +     end_time = jiffies + 30 * HZ;
> > >       while (!virtqueue_get_buf(vi->cvq, &tmp) &&
> > >              !virtqueue_is_broken(vi->cvq)) {
> > >               cond_resched();
> > >               cpu_relax();
> > > +
> > > +             if (time_after(end_time, jiffies)) {
> > > +                     /* TODO Reset vq if possible? */
> > > +                     virtio_break_device(vi->vdev);
> > > +                     break;
> > > +             }
> > >       }
> > >
> > >  unlock:
> > > --
> > > 2.51.0
> >


