Return-Path: <linux-kernel+bounces-854003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 01653BDD501
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 10:09:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B26784E9D04
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 08:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B22722D238A;
	Wed, 15 Oct 2025 08:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bHp3f0T8"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B1B113AD3F
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 08:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760515754; cv=none; b=Rk8SlHHEJJ05cHtrplBptDvco2+U+R/WTguGzAUWqvTJfUrhM3fe/lZnwvgNotf5qbRBC/zD4bGu5MyVH3MvE4AwXdBtqdVyrX8uxZouR8lux8INijeDkO962MToKMQkndUXCYuvmvWkn9nxe6reFTQ7tR4bS1HWPWsPteX+uLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760515754; c=relaxed/simple;
	bh=Bp2KX7ytxkHuVuPESpUWA2hLtp4yHoQ+zo3q+JOjV1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JNeMDm6jXTgb3xBAka4utzH6LuXQJqMzBroGg6qD/hogLdadsmkfSJu3l9LJWCih8L2yVTkxdwNx0VRDQbNyauqGy2dFgP1CsBVkxa+mfw/CluOttifXhhVd+wfIE2XtiKdC/rUteUIVmcYPm4tfKUzZW4NnFyfXyzBC51WJMk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bHp3f0T8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760515751;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QSYriq0cvXoIE3Z2j1WOX3qlPwrgXWcVASIuUgZ48jU=;
	b=bHp3f0T852ihH0vMA08ki3Ye19jUZbXiUAkEvZqolr+8RGW/SVEgMV8aYa8/1D76Feczq9
	+TwRlOVfAv/OA4/NjHbWUYIMiiKZnWCzRykZbgBn71bOdJ6IqApiHnYaF3RE/lDazeJzZE
	9jZxat+w/bD4goTb7kJlCBfaum5qq30=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-260-BBe7vYQWN6OhUY-aS6cuVw-1; Wed, 15 Oct 2025 04:09:09 -0400
X-MC-Unique: BBe7vYQWN6OhUY-aS6cuVw-1
X-Mimecast-MFC-AGG-ID: BBe7vYQWN6OhUY-aS6cuVw_1760515749
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-42421b15185so4372003f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 01:09:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760515748; x=1761120548;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QSYriq0cvXoIE3Z2j1WOX3qlPwrgXWcVASIuUgZ48jU=;
        b=nV0sEI+OFguuIVv+P19U3VRlHZNnBxg2qdQ1hlw6CQv++uvy8bcMX+yIqOTuxS+w9C
         AQFOc9ewScd83S257pP5sbYy8Au2OhNb8YjADgM4nlBBteG/mAq0wJA3MoLwMPM8T9+4
         jmP495oWDJYBy7Mg4ey5a1L1m7TzCNB2BCx0wgGDLP7+lACbSBdKHCaVGJkzycJ5SFus
         s9BMQ9msROp+AMnFdI2BYHkXWgswD4Z9100a2U2q/1uI1QH3qU01oJYovn943Koc9V2U
         mRZ1qOFsvLGxaAxkklPxGv9xuMhKt1Gcjsmm+tAK5T0lDwIUolmgOrwm5mLHRuO2LtzM
         Jurw==
X-Forwarded-Encrypted: i=1; AJvYcCXj8zbJPK/1GEDdI9/szS9B3iAG/pLdWe1inL1bFY/Tyl5WzxbBjz/DPlwz5l3nGes4XtPhubetYhjd9aA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhXwCULniR7G3appTZTkXEBb+xKgTurk2/l/+STkq1eBapXkPa
	Gs2+x+Clwc0hbIcCqTq4nCnOoOXGosn/49vwcy1xNhn5XMoaKzdCNudIDh5a6jLPU3e8IBfvbnF
	qgE+We5ZpeYW/C1vla+/Y/BJDTPJmNXk1RA331RyhenG5PdjVYcSU9TQbo6pxbGYIyQ==
X-Gm-Gg: ASbGncumsU+JjYYuZWm5qrQhPgMugxp4qROaupjvgmYDLctegfjrYy8lM+TO5UQf/EC
	vTTnlXLl9gK7rFY2uftNjTRiASW1njL+20VpNuI0JnCDTITRltxNPUeJmXHkXF/bx6naWshiznP
	E6bm0unWh6c02bzTWNfVO0GaBRVouTkS+cgpttcxK9L7UIInybp849H5y/LjFuLyc3acBTZ8PNm
	t9IHNwWf109wscIuXV4vhwVLRxgCqO9Mv8rwPRKWzITUAyFoE0AdnsZsbJJmPr6koaX40KpoauX
	VoD4wJZQxRFmhUt/uhtkMMyr2Qip7AakAA==
X-Received: by 2002:a05:6000:288c:b0:3e4:d981:e312 with SMTP id ffacd0b85a97d-4266e8e51f2mr16811843f8f.62.1760515748419;
        Wed, 15 Oct 2025 01:09:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHCYEbMZHqRxfg1VSwxLTgxZHiBhAkYhnsx+4h6lUKE87xBVOPm71dXz6S0eHcpwIqMZyaseQ==
X-Received: by 2002:a05:6000:288c:b0:3e4:d981:e312 with SMTP id ffacd0b85a97d-4266e8e51f2mr16811804f8f.62.1760515747614;
        Wed, 15 Oct 2025 01:09:07 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:152d:b200:2a90:8f13:7c1e:f479])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5e83e1sm27796020f8f.51.2025.10.15.01.09.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 01:09:07 -0700 (PDT)
Date: Wed, 15 Oct 2025 04:09:04 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Maxime Coquelin <mcoqueli@redhat.com>
Cc: Eugenio Perez Martin <eperezma@redhat.com>,
	Yongji Xie <xieyongji@bytedance.com>,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Dragos Tatulea DE <dtatulea@nvidia.com>, jasowang@redhat.com
Subject: Re: [RFC 1/2] virtio_net: timeout control virtqueue commands
Message-ID: <20251015040722-mutt-send-email-mst@kernel.org>
References: <20251007130622.144762-2-eperezma@redhat.com>
 <20251014042459-mutt-send-email-mst@kernel.org>
 <CAO55cszGtuqL9qfs8SVB=Jjghefn=M0Rjw65f2DGPrjLQFFtqg@mail.gmail.com>
 <20251014051537-mutt-send-email-mst@kernel.org>
 <CAJaqyWe-mn4e+1egNCH+R1x4R7DB6U1SZ-mRAXYPTtA27hKCVA@mail.gmail.com>
 <20251015023020-mutt-send-email-mst@kernel.org>
 <CAJaqyWeiX1Tc77NcYoBbeVfKTeuKHK6hw=n_9Mk4y52k7Djr-g@mail.gmail.com>
 <20251015030313-mutt-send-email-mst@kernel.org>
 <CAJaqyWfRmhXM8eV+=wMVKgrc8SJ98OTtBCtNDJj8ZRUM5Y9Nmg@mail.gmail.com>
 <CAO55csx2rbjxEZk5K3aKcZ501KY3Zfs8ThEQHFqQ1ZB9RSXECA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAO55csx2rbjxEZk5K3aKcZ501KY3Zfs8ThEQHFqQ1ZB9RSXECA@mail.gmail.com>

On Wed, Oct 15, 2025 at 10:03:49AM +0200, Maxime Coquelin wrote:
> On Wed, Oct 15, 2025 at 9:45 AM Eugenio Perez Martin
> <eperezma@redhat.com> wrote:
> >
> > On Wed, Oct 15, 2025 at 9:05 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> > >
> > > On Wed, Oct 15, 2025 at 08:52:50AM +0200, Eugenio Perez Martin wrote:
> > > > On Wed, Oct 15, 2025 at 8:33 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > >
> > > > > On Wed, Oct 15, 2025 at 08:08:31AM +0200, Eugenio Perez Martin wrote:
> > > > > > On Tue, Oct 14, 2025 at 11:25 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > > > >
> > > > > > > On Tue, Oct 14, 2025 at 11:14:40AM +0200, Maxime Coquelin wrote:
> > > > > > > > On Tue, Oct 14, 2025 at 10:29 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > > > > > >
> > > > > > > > > On Tue, Oct 07, 2025 at 03:06:21PM +0200, Eugenio Pérez wrote:
> > > > > > > > > > An userland device implemented through VDUSE could take rtnl forever if
> > > > > > > > > > the virtio-net driver is running on top of virtio_vdpa.  Let's break the
> > > > > > > > > > device if it does not return the buffer in a longer-than-assumible
> > > > > > > > > > timeout.
> > > > > > > > >
> > > > > > > > > So now I can't debug qemu with gdb because guest dies :(
> > > > > > > > > Let's not break valid use-cases please.
> > > > > > > > >
> > > > > > > > >
> > > > > > > > > Instead, solve it in vduse, probably by handling cvq within
> > > > > > > > > kernel.
> > > > > > > >
> > > > > > > > Would a shadow control virtqueue implementation in the VDUSE driver work?
> > > > > > > > It would ack systematically messages sent by the Virtio-net driver,
> > > > > > > > and so assume the userspace application will Ack them.
> > > > > > > >
> > > > > > > > When the userspace application handles the message, if the handling fails,
> > > > > > > > it somehow marks the device as broken?
> > > > > > > >
> > > > > > > > Thanks,
> > > > > > > > Maxime
> > > > > > >
> > > > > > > Yes but it's a bit more convoluted  than just acking them.
> > > > > > > Once you use the buffer you can get another one and so on
> > > > > > > with no limit.
> > > > > > > One fix is to actually maintain device state in the
> > > > > > > kernel, update it, and then notify userspace.
> > > > > > >
> > > > > >
> > > > > > I thought of implementing this approach at first, but it has two drawbacks.
> > > > > >
> > > > > > The first one: it's racy. Let's say the driver updates the MAC filter,
> > > > > > VDUSE timeout occurs, the guest receives the fail, and then the device
> > > > > > replies with an OK. There is no way for the device or VDUSE to update
> > > > > > the driver.
> > > > >
> > > > > There's no timeout. Kernel can guarantee executing all requests.
> > > > >
> > > >
> > > > I don't follow this. How should the VDUSE kernel module act if the
> > > > VDUSE userland device does not use the CVQ buffer then?
> > >
> > > First I am not sure a VQ is the best interface for talking to userspace.
> > > But assuming yes - just avoid sending more data, send it later after
> > > userspace used the buffer.
> > >
> >
> > Let me take a step back, I think I didn't describe the scenario well enough.
> >
> > We have a VDUSE device, and then the same host is interacting with the
> > device through the virtio_net driver over virtio_vdpa.
> >
> > Then, the virtio_net driver sends a control command though its CVQ, so
> > it *takes the RTNL*. That command reaches the VDUSE CVQ.
> >
> > It does not matter if the VDUSE device in the userland processes the
> > commands through a CVQ, reading the vduse character device, or another
> > system. The question is: what to do if the VDUSE device does not
> > process that command in a timely manner? Should we just let the RTNL
> > be taken forever?
> >
> 
> My understanding is that:
> 1. Virtio-net sends a control messages, waits for reply
> 2. VDUSE driver dequeues it, adds it to the SCVQ, replies OK to the CVQ
> 3. Userspace application dequeues the message from the SCVQ
>  a. If handling is successful it replies OK
>  b. If handling fails, replies ERROR
> 4. VDUSE driver reads the reply
>  a. if OK, do nothing
>  b. if ERROR, mark the device as broken?
> 
> This is simplified as it does not take into account SCVQ overflow if
> the application is stuck.
> If IIUC, Michael suggests to only enqueue a single message at the time
> in the SVQ,
> and bufferize the pending messages in the VDUSE driver.

Not exactly bufferize, record.  E.g. we do not need to send
100 messages to enable/disable promisc mode - together they
have no effect.

-- 
MST


