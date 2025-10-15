Return-Path: <linux-kernel+bounces-853886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FA6BBDCD0F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 09:05:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B70F3A8271
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 07:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12BC329BDBC;
	Wed, 15 Oct 2025 07:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IDETDVUM"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5737E25D1E6
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 07:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760511902; cv=none; b=C83trVFUUemKWaREtf1PZ4YWKyohxmi+cePGzq8drTmOMylq63iRign/zp37AnYU36+2gItHJVnjFHyargEwQVQ+lyWVMRB2lEt/sNTorH+/6gBVSCh+OdWrsvCvvn4i8rrpPELGpclEfCzozSaH9kTlizarCYjL4am1W6YCH5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760511902; c=relaxed/simple;
	bh=pw1kGo2ws+5OCuELJrcKLUoUBQ0/TG/z4KJ0tei3+2k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IXTfa8TyUS9nCneMkOQYEwKYEz8/nLhmC1mfWpxG/QLaDQKFb+EIqJdTC0mCX9sXCsfu21DRV7vh/IGR5+wDXKPaikogic5JHKS4kbPyHgRdGj4Z7ssAkpUio9e997o7Npcszgn5TJPzCauGI4mY67lURxEmg4vetYiGoHnKHl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IDETDVUM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760511899;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2jp8KDES5ks8Aac5tH2y5JeuFcW9ux+XVUfHWrIy/4U=;
	b=IDETDVUMtQkNDTEMluMHPbJz4fQmKtVwWWzDizl3oOHuiuTDhAoCkgW1FbrR6k5qL75HQn
	2Lw+1AT/MzvLBR0GjyYl5FVkoOaJe8JhrKQVktNWf3lebO5piexQiW9cwQC//Dr7nUKS/3
	ljsYRAyCNqEkuOE7gaQVjzfGe1NDZtE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-ikWxStrVM9at5iLIwzyswA-1; Wed, 15 Oct 2025 03:04:57 -0400
X-MC-Unique: ikWxStrVM9at5iLIwzyswA-1
X-Mimecast-MFC-AGG-ID: ikWxStrVM9at5iLIwzyswA_1760511896
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-46e44b9779eso35150325e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 00:04:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760511896; x=1761116696;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2jp8KDES5ks8Aac5tH2y5JeuFcW9ux+XVUfHWrIy/4U=;
        b=LqYNhxem9CgCx3TEUiNEVpBLRZlCMUXElqfVBYFpfwqp8JS9NzT4prHipwWXsodkuD
         /Y36tTSTvzsfgiZy5x0i68Ps+qJIYL2rr72yuIKIXK1JsyjQn3t0uoL5oIvARCGLTtrl
         IhwUe/h0acXoPMV8A0KfKVXB32yhKNmNyZtQ/YkqCfjcl/yJgoQNzByCnKadpG8chz1b
         Ja2iFyp6e1HbKA2UJKdhm5Ns+VYvrEd9wW4nKojLtXiN8WVFF9jeNEHmrkcZUX6e04JZ
         I8BpCMuDeYIcV2r8x4Ziq3w03cddL8G4BJhCPB+mbqkZYVI79+17uWHyQJhm1jDEkvWt
         cyrw==
X-Forwarded-Encrypted: i=1; AJvYcCVkn4Kg+qbzxHtq1S+xjAQvBbp8CXDvgCXyupf6ZE453lQgTg/IieC5OzRnZzkIBrCqamzcXDvhDURV+RU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLzf0bHAdATUYAWM8sFEe6L9GO5Nrrm7twbeiRCDOLqTwZT2s6
	CWq/1XGaQY/JxAqJVMmpQUvVrvc1FByWaoEek1jO4Y1P3ZYc41M2HwLUxaE6vdF/UOmh++BBkcc
	oy6rI+uPb/AGu3HKLy9A3LxdAUQGJ41fPE9vxkASn3xmrA4At5LLSL0q8efuzc3Sm8g==
X-Gm-Gg: ASbGncussqD354I0RofGTviT4peoHmiqaNGoxjlaS54MGylET395DnJ+x72Vw+7ZWUJ
	sL7QPiTSzdR82n+lBL4GkRHQXC+rdUmpkXxsxJ1mPcMSf/EIJyTLCaRIvRQeZYXq/cjaYDmF3RE
	gl5Cla8alv86ePBIoCxztBLui8aVg3J10xhOqsUrPRSGScCjsTbbrBgOuUxy009kls017V8uW67
	Sot/MCD2hDnOD2ro9QeLq2uNagw8HnD/X+l2GdsYqpkJ/xO87EkiJy9AHmLtJFHKmT/9tJ6kjqq
	XfQHlaNDgcOXtK5x08VNNUyW6uHEjwCK3Q==
X-Received: by 2002:a05:600c:502c:b0:46e:1f86:aeba with SMTP id 5b1f17b1804b1-46fa9af014cmr175468025e9.17.1760511896363;
        Wed, 15 Oct 2025 00:04:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGhAQEhpelfdmyS4qYM1C8WtBXdelqu4F1sSu1VYzwVpfHA3C49VVzKIr4iSipRy/2riecqYQ==
X-Received: by 2002:a05:600c:502c:b0:46e:1f86:aeba with SMTP id 5b1f17b1804b1-46fa9af014cmr175467725e9.17.1760511895812;
        Wed, 15 Oct 2025 00:04:55 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:152d:b200:2a90:8f13:7c1e:f479])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce583664sm27454506f8f.22.2025.10.15.00.04.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 00:04:55 -0700 (PDT)
Date: Wed, 15 Oct 2025 03:04:52 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: Maxime Coquelin <mcoqueli@redhat.com>,
	Yongji Xie <xieyongji@bytedance.com>,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Dragos Tatulea DE <dtatulea@nvidia.com>, jasowang@redhat.com
Subject: Re: [RFC 1/2] virtio_net: timeout control virtqueue commands
Message-ID: <20251015030313-mutt-send-email-mst@kernel.org>
References: <20251007130622.144762-1-eperezma@redhat.com>
 <20251007130622.144762-2-eperezma@redhat.com>
 <20251014042459-mutt-send-email-mst@kernel.org>
 <CAO55cszGtuqL9qfs8SVB=Jjghefn=M0Rjw65f2DGPrjLQFFtqg@mail.gmail.com>
 <20251014051537-mutt-send-email-mst@kernel.org>
 <CAJaqyWe-mn4e+1egNCH+R1x4R7DB6U1SZ-mRAXYPTtA27hKCVA@mail.gmail.com>
 <20251015023020-mutt-send-email-mst@kernel.org>
 <CAJaqyWeiX1Tc77NcYoBbeVfKTeuKHK6hw=n_9Mk4y52k7Djr-g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJaqyWeiX1Tc77NcYoBbeVfKTeuKHK6hw=n_9Mk4y52k7Djr-g@mail.gmail.com>

On Wed, Oct 15, 2025 at 08:52:50AM +0200, Eugenio Perez Martin wrote:
> On Wed, Oct 15, 2025 at 8:33 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Wed, Oct 15, 2025 at 08:08:31AM +0200, Eugenio Perez Martin wrote:
> > > On Tue, Oct 14, 2025 at 11:25 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > >
> > > > On Tue, Oct 14, 2025 at 11:14:40AM +0200, Maxime Coquelin wrote:
> > > > > On Tue, Oct 14, 2025 at 10:29 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > > >
> > > > > > On Tue, Oct 07, 2025 at 03:06:21PM +0200, Eugenio Pérez wrote:
> > > > > > > An userland device implemented through VDUSE could take rtnl forever if
> > > > > > > the virtio-net driver is running on top of virtio_vdpa.  Let's break the
> > > > > > > device if it does not return the buffer in a longer-than-assumible
> > > > > > > timeout.
> > > > > >
> > > > > > So now I can't debug qemu with gdb because guest dies :(
> > > > > > Let's not break valid use-cases please.
> > > > > >
> > > > > >
> > > > > > Instead, solve it in vduse, probably by handling cvq within
> > > > > > kernel.
> > > > >
> > > > > Would a shadow control virtqueue implementation in the VDUSE driver work?
> > > > > It would ack systematically messages sent by the Virtio-net driver,
> > > > > and so assume the userspace application will Ack them.
> > > > >
> > > > > When the userspace application handles the message, if the handling fails,
> > > > > it somehow marks the device as broken?
> > > > >
> > > > > Thanks,
> > > > > Maxime
> > > >
> > > > Yes but it's a bit more convoluted  than just acking them.
> > > > Once you use the buffer you can get another one and so on
> > > > with no limit.
> > > > One fix is to actually maintain device state in the
> > > > kernel, update it, and then notify userspace.
> > > >
> > >
> > > I thought of implementing this approach at first, but it has two drawbacks.
> > >
> > > The first one: it's racy. Let's say the driver updates the MAC filter,
> > > VDUSE timeout occurs, the guest receives the fail, and then the device
> > > replies with an OK. There is no way for the device or VDUSE to update
> > > the driver.
> >
> > There's no timeout. Kernel can guarantee executing all requests.
> >
> 
> I don't follow this. How should the VDUSE kernel module act if the
> VDUSE userland device does not use the CVQ buffer then?

First I am not sure a VQ is the best interface for talking to userspace.
But assuming yes - just avoid sending more data, send it later after
userspace used the buffer.


> >
> >
> > >
> > > The second one, what to do when the VDUSE cvq runs out of descriptors?
> > > While the driver has its descriptor returned with VIRTIO_NET_ERR, the
> > > VDUSE CVQ has the descriptor available. If this process repeats to
> > > make available all of the VDUSE CVQ descriptors, how can we proceed?
> >
> > There's no reason to return VIRTIO_NET_ERR ever and cvq will not run
> > out of descriptors. Kernel uses cvq buffers.
> >
> >
> > > I think both of them can be solved with the DEVICE_NEEDS_RESET status
> > > bit, but it is not implemented in the drivers at this moment.
> >
> > No need for a reset, either.
> >


