Return-Path: <linux-kernel+bounces-864678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D56A2BFB52B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 12:10:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C584D4F3409
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 10:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F11DD3191DA;
	Wed, 22 Oct 2025 10:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iK7fTzVp"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4194F2FF660
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 10:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761127786; cv=none; b=tTaJYW/fm9J1X3hysCVVibi5FOjvBY9/11PZ81jiZAzLGRN/r/0QO6h1iHtCLBRs0qVU/qOMVUxaS+97aLqsjevDyAxemzXVw6DyPZWXsQP0+n8gM1tCLTSxAUogpHmqXOdBzjtP3pBeC1FNyP3iMi0qgoc8IzU6IXN9Y9lX7+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761127786; c=relaxed/simple;
	bh=C9Mm2dxFST1Npvlr+6IUglDpwNOV6KogFRdlIU8hkYU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GxUIwCZewmTZyZeeTbEopqtSPrbba0b12z09Vs45nVMlqP8tMvtWqhnZf0uw5pDPctnOCGwB5SqbFyiSvtsdR6H25/OtGvT6lCuHmDf7XI7a2a4f5abOYN811gSczpoNHUn/HFJ7b15phwMKG2c8ISzBgw6+uVh9ccwiaTK7SLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iK7fTzVp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761127783;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dQ6PGT7U8Zjz5PqrsvnmsOYhktAt3PvByfU6TEvf+S0=;
	b=iK7fTzVpMAI24+38jX3dUOtuuvgpVRt8BjofS/ivHamy3HtY8rVIFyZHa481K2CZAXiuRi
	+GpOknFD4sPzRceIJ646RIoNAw1vye3sb3knr6JKheoMaewtEk46iupBB8uvoS/dFsFUBY
	qUDU2u5kE0Lqm4aRA8fs0ZZIwV3rw6M=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-414-XlLtjDvAOVuo77d3z5kFcw-1; Wed, 22 Oct 2025 06:09:41 -0400
X-MC-Unique: XlLtjDvAOVuo77d3z5kFcw-1
X-Mimecast-MFC-AGG-ID: XlLtjDvAOVuo77d3z5kFcw_1761127781
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-b2d1072a9c4so650301766b.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 03:09:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761127780; x=1761732580;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dQ6PGT7U8Zjz5PqrsvnmsOYhktAt3PvByfU6TEvf+S0=;
        b=SgYFGtUVpjWuzkQ1vDwEg7VCfal2Yol2g0KQ8FZGUvIR3pSCDCUn01O8gF783MDaOZ
         wVd5LKl7WW5UVXLRejnIDEpIekFstbKGQcFKvZ7pb+eZM6RnUtPWckbjKS8ElxPMrhqt
         VxwQ+7CKgk6KxX3LWUXdgu0uFpX2VWVYKKi8QuJAurmGq2jGfV/UVpu7dWOOJVYtylTG
         M7QTYu3iG+R3nqfaw/I4l2IAxXQ+Z9YZ9DwMQVNkdzFkU1UJ7hOFxEtW9I2mgKDDyPMb
         XrgrrogNhs6XcvpGBoxf2dfihzLEEMeU4hBPy8RSwI5gnwEtTuJbbRk4/C1PVASee7xo
         KgWA==
X-Forwarded-Encrypted: i=1; AJvYcCVHfVow6n1FQos7cCmBMphozNoLiOl2D9p2XlQlLfZRxDDiF9eT4gWV47Aw+8Rf9XNau90mLtKqFROe/cA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw10rHPguAn0QGFuCQqiSiGeV+QrUn3ajThZhpXfu4V7kD9wjQg
	dPUWiSPRE/g261ypnJkfTplN+EcOBmKDEz1lvTzdiA3BtFqDyzWG9vPi9daIy1+XQrcJEXi+J9j
	rfQBupOtp7q46nbXO5//463XhDgyhR0JQUagdsT6M5MLwmjNBhAF+e7mYSOT8IYc0kgmUc9ChMA
	==
X-Gm-Gg: ASbGnctFBKT25qVWjOKrM6fNwpdv0o761FRCCQGXZPk1H3hp/IlTa9XhGte6WOcfXK4
	5SqkIsBc8Y2TLtyXacyLHP2dtmtbmu4v50nOtEpAHkOWeFjdzO+sDY8jz6s5htWoAb8EuJxv+9b
	13eUA4k8iul7/VSY4PQURT1abUb/Wt1TnxPYnDpVLWQW8tAurznP88xV6w1rJpVvQUgI7pyDQa+
	nPmtnB6NcDfxdN/Nfd21elDxp4kn/nsQpAWpSggFCBIIiigxo035QGkhCQ/csTrBdWtUjvzqi4n
	hwyFJoOh0siQoDq4jOJ9B15ZY8pilXGcYa7wPgq3M2H4+x+XVm4jfo29N162nO38
X-Received: by 2002:a17:906:ef07:b0:b57:43c1:e194 with SMTP id a640c23a62f3a-b647254f794mr2555186066b.11.1761127780152;
        Wed, 22 Oct 2025 03:09:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGXWFxmOeM7ei0B+Fi8xm1ol8UHOjWwepsbziS5ZeH0FMm1eWC/BMCVsnSG89pccSJHbOLuAg==
X-Received: by 2002:a17:906:ef07:b0:b57:43c1:e194 with SMTP id a640c23a62f3a-b647254f794mr2555182266b.11.1761127779531;
        Wed, 22 Oct 2025 03:09:39 -0700 (PDT)
Received: from redhat.com ([31.187.78.209])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6aaf93a32asm853297866b.51.2025.10.22.03.09.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 03:09:39 -0700 (PDT)
Date: Wed, 22 Oct 2025 06:09:36 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: Maxime Coquelin <mcoqueli@redhat.com>,
	Yongji Xie <xieyongji@bytedance.com>,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Dragos Tatulea DE <dtatulea@nvidia.com>, jasowang@redhat.com
Subject: Re: [RFC 1/2] virtio_net: timeout control virtqueue commands
Message-ID: <20251022060748-mutt-send-email-mst@kernel.org>
References: <CAO55cszGtuqL9qfs8SVB=Jjghefn=M0Rjw65f2DGPrjLQFFtqg@mail.gmail.com>
 <20251014051537-mutt-send-email-mst@kernel.org>
 <CAJaqyWe-mn4e+1egNCH+R1x4R7DB6U1SZ-mRAXYPTtA27hKCVA@mail.gmail.com>
 <20251015023020-mutt-send-email-mst@kernel.org>
 <CAJaqyWeiX1Tc77NcYoBbeVfKTeuKHK6hw=n_9Mk4y52k7Djr-g@mail.gmail.com>
 <20251015030313-mutt-send-email-mst@kernel.org>
 <CAJaqyWfRmhXM8eV+=wMVKgrc8SJ98OTtBCtNDJj8ZRUM5Y9Nmg@mail.gmail.com>
 <CAO55csx2rbjxEZk5K3aKcZ501KY3Zfs8ThEQHFqQ1ZB9RSXECA@mail.gmail.com>
 <20251015040722-mutt-send-email-mst@kernel.org>
 <CAJaqyWcf3tz17q6G=123Xb+warf8Ckg=PLaPkzLU9hYHiUy9Zg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJaqyWcf3tz17q6G=123Xb+warf8Ckg=PLaPkzLU9hYHiUy9Zg@mail.gmail.com>

On Wed, Oct 15, 2025 at 12:36:47PM +0200, Eugenio Perez Martin wrote:
> On Wed, Oct 15, 2025 at 10:09 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Wed, Oct 15, 2025 at 10:03:49AM +0200, Maxime Coquelin wrote:
> > > On Wed, Oct 15, 2025 at 9:45 AM Eugenio Perez Martin
> > > <eperezma@redhat.com> wrote:
> > > >
> > > > On Wed, Oct 15, 2025 at 9:05 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > >
> > > > > On Wed, Oct 15, 2025 at 08:52:50AM +0200, Eugenio Perez Martin wrote:
> > > > > > On Wed, Oct 15, 2025 at 8:33 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > > > >
> > > > > > > On Wed, Oct 15, 2025 at 08:08:31AM +0200, Eugenio Perez Martin wrote:
> > > > > > > > On Tue, Oct 14, 2025 at 11:25 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > > > > > >
> > > > > > > > > On Tue, Oct 14, 2025 at 11:14:40AM +0200, Maxime Coquelin wrote:
> > > > > > > > > > On Tue, Oct 14, 2025 at 10:29 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > > > > > > > >
> > > > > > > > > > > On Tue, Oct 07, 2025 at 03:06:21PM +0200, Eugenio Pérez wrote:
> > > > > > > > > > > > An userland device implemented through VDUSE could take rtnl forever if
> > > > > > > > > > > > the virtio-net driver is running on top of virtio_vdpa.  Let's break the
> > > > > > > > > > > > device if it does not return the buffer in a longer-than-assumible
> > > > > > > > > > > > timeout.
> > > > > > > > > > >
> > > > > > > > > > > So now I can't debug qemu with gdb because guest dies :(
> > > > > > > > > > > Let's not break valid use-cases please.
> > > > > > > > > > >
> > > > > > > > > > >
> > > > > > > > > > > Instead, solve it in vduse, probably by handling cvq within
> > > > > > > > > > > kernel.
> > > > > > > > > >
> > > > > > > > > > Would a shadow control virtqueue implementation in the VDUSE driver work?
> > > > > > > > > > It would ack systematically messages sent by the Virtio-net driver,
> > > > > > > > > > and so assume the userspace application will Ack them.
> > > > > > > > > >
> > > > > > > > > > When the userspace application handles the message, if the handling fails,
> > > > > > > > > > it somehow marks the device as broken?
> > > > > > > > > >
> > > > > > > > > > Thanks,
> > > > > > > > > > Maxime
> > > > > > > > >
> > > > > > > > > Yes but it's a bit more convoluted  than just acking them.
> > > > > > > > > Once you use the buffer you can get another one and so on
> > > > > > > > > with no limit.
> > > > > > > > > One fix is to actually maintain device state in the
> > > > > > > > > kernel, update it, and then notify userspace.
> > > > > > > > >
> > > > > > > >
> > > > > > > > I thought of implementing this approach at first, but it has two drawbacks.
> > > > > > > >
> > > > > > > > The first one: it's racy. Let's say the driver updates the MAC filter,
> > > > > > > > VDUSE timeout occurs, the guest receives the fail, and then the device
> > > > > > > > replies with an OK. There is no way for the device or VDUSE to update
> > > > > > > > the driver.
> > > > > > >
> > > > > > > There's no timeout. Kernel can guarantee executing all requests.
> > > > > > >
> > > > > >
> > > > > > I don't follow this. How should the VDUSE kernel module act if the
> > > > > > VDUSE userland device does not use the CVQ buffer then?
> > > > >
> > > > > First I am not sure a VQ is the best interface for talking to userspace.
> > > > > But assuming yes - just avoid sending more data, send it later after
> > > > > userspace used the buffer.
> > > > >
> > > >
> > > > Let me take a step back, I think I didn't describe the scenario well enough.
> > > >
> > > > We have a VDUSE device, and then the same host is interacting with the
> > > > device through the virtio_net driver over virtio_vdpa.
> > > >
> > > > Then, the virtio_net driver sends a control command though its CVQ, so
> > > > it *takes the RTNL*. That command reaches the VDUSE CVQ.
> > > >
> > > > It does not matter if the VDUSE device in the userland processes the
> > > > commands through a CVQ, reading the vduse character device, or another
> > > > system. The question is: what to do if the VDUSE device does not
> > > > process that command in a timely manner? Should we just let the RTNL
> > > > be taken forever?
> > > >
> > >
> > > My understanding is that:
> > > 1. Virtio-net sends a control messages, waits for reply
> > > 2. VDUSE driver dequeues it, adds it to the SCVQ, replies OK to the CVQ
> > > 3. Userspace application dequeues the message from the SCVQ
> > >  a. If handling is successful it replies OK
> > >  b. If handling fails, replies ERROR
> 
> If that's the case, everything would be ok now. In both cases, the
> RTNL is held only by that time. The problem is when the VDUSE device
> userland does not reply.
> 
> > > 4. VDUSE driver reads the reply
> > >  a. if OK, do nothing
> > >  b. if ERROR, mark the device as broken?
> > >
> > > This is simplified as it does not take into account SCVQ overflow if
> > > the application is stuck.
> > > If IIUC, Michael suggests to only enqueue a single message at the time
> > > in the SVQ,
> > > and bufferize the pending messages in the VDUSE driver.
> 
> But the RTNL keeps being held in all that process, isn't it?
> 
> >
> > Not exactly bufferize, record.  E.g. we do not need to send
> > 100 messages to enable/disable promisc mode - together they
> > have no effect.
> >
> 
> I still don't follow how that unlocks the RTNL. Let me put some workflows:
> 
> 1) MAC_TABLE_SET, what can we do if:
> The driver sets a set of MAC addresses, (A, B, C). VDUSE device does
> send this set to the VDUSE userland device, as we don't have more
> information. Now, the driver sends a new table with addresses (A, B,
> D), but the device still didn't reply to the VDUSE driver.
> 
> VDUSE should track that the new state is (A, B, D), and then wait for
> the previous request to be replied by the device? What should we
> report to the driver?

you reply OK to the driver immediately.

> If we wait for the device to reply, we're in the
> same situation regarding the RTNL.
> 
> Now we receive a new state (A, B, E). We haven't sent the (A, B, D),
> so it is good to just replace the (A, B, D) with that. and send it
> when (A, B, C) is completed with either success or failure.
> 
> 2) VQ_PAIRS_SET
> 
> The driver starts with 1 vq pair. Now the driver sets 3 vq pairs, and
> the VDUSE CVQ forwards the command. The driver still thinks that it is
> using 1 vq pair. I can store that the driver request was 3, and it is
> still in-flight. Now the timeout occurs, so the VDUSE device returns
> fail to the driver, and the driver frees the vq regions etc. After
> that, the device now replies OK. The memory that was sent as the new
> vqs avail ring and descriptor ring now contains garbage, and it could
> happen that the device start overriding unrelated memory.
> 
> Not even VQ_RESET protects against it as there is still a window
> between the CMD set and the VQ reset.

Timeouts should be up to userspace. If userspace times out
and then gets confused, kernel is not to blame.



