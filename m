Return-Path: <linux-kernel+bounces-853843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F170BDCBF5
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 08:33:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49D7819A284E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 06:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A17E33126AD;
	Wed, 15 Oct 2025 06:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C5LrfBQ9"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F829311C13
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 06:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760510008; cv=none; b=Uf5mLpEYBXvZvdAu0TGIGLTVBYtcBYaLYOOby954/fUDxmkMK69d0LVb+VG+KPsSEdHkEwc48vZrUbDRwIEfgOGjcZLhhNpLJ1+Qvdynqh3Mj+gxWPp35PCK6HvpgtTH079wq5U+QyHHkA0iqARsU6K/rTojlkwPjwCNH0mdMnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760510008; c=relaxed/simple;
	bh=5fY2EHaiPx5YUffclMiP+qS81HjO027W1pJLKkStZWY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PInAGhNJ9Roqbcx6dhEn+bG6wN7rCS+7//Yaeke5gteIFJCsIiF19rdhAOBnEh86ndVkW3nKKDxgQD9v4gl0vWAvYh9aIoOT4lV9p7mzgXHlHEvSBwGhNNqDZBbcnm4djNc3cqX3VbVohx1ewmpMmI+RvL2AXB9T43+ZEBG7Slk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C5LrfBQ9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760510005;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aJx3k4VeIaHUuzyh2iGzXH7FVxaGE9ANbJiYM/s1DZw=;
	b=C5LrfBQ90zX0GZSLCZer3xe+nBSlreZ4HrQz4pvwX3kH/10Swrkmu3xtYWZOlK7LoLYteO
	qbGmvbIwOLrk/Ehenqyl/2knr3TXLbglsuewxbfC+J0hB28E+G3xTvNCRJZPKRXoGV+0Ar
	gZvU1E4JHQjPacR3xySyxAiMtynLHjU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-159-td0FU4AaP0-v5LNLjJlQUg-1; Wed, 15 Oct 2025 02:33:23 -0400
X-MC-Unique: td0FU4AaP0-v5LNLjJlQUg-1
X-Mimecast-MFC-AGG-ID: td0FU4AaP0-v5LNLjJlQUg_1760510002
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-40fd1b17d2bso3637545f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 23:33:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760510002; x=1761114802;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aJx3k4VeIaHUuzyh2iGzXH7FVxaGE9ANbJiYM/s1DZw=;
        b=RbV/NYfDg59hErsjh3sFDRloTczAUW6On1LKYJFBZyPQsIxDGVRzBHI+dnz98Ty1iE
         H4LT4K29+FlocxWS/8GDTrPImpQSw+uYChfUKvwwxxP4OK7/8oOJ7J5x4W6uJxFQsS/s
         p0DH0q1w1CjP1ViEgeebpE6UAd3mSGJcihFgYYroGcMQVR0CeXjmJERpkR4cl7STuPVK
         8iWZtZYKCPdzHx/xttRKdtM2k0P/S6aq54dxLcYK4594cw574PDpU6M4DJnmvVGFIybM
         KQmy2kG2xUmxIG24oklv/ApJHoqh5ykQ3kfSTvYuPRE6YmDdH84v/G1evtw9WmFHQ9Og
         vY2w==
X-Forwarded-Encrypted: i=1; AJvYcCWBr+gLHaBVcBO40dSsRsMRO7nvEoG9bJmy22kLS6MAdOJCHIJrsQobkpt+hX1D9XscBdUrdo1LkCJVy98=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzq8RXFq1p2lLuxVKaFpWQ+V6PXSR8owXv4PKzhPZb53+sYXiBU
	IHpat/8VzV0UVe5h1x70k9dy3K4lf/f7vmAowkK337yKP8x4ppFrOa/YbZ+DU8rD0SKvgstl1WD
	GwVDj6vvI70zNkgkvlQcYGZ8nJwMbE2/4Ih+CQ8SbrBEHfr4wLu06hu/pejcxvjee3A==
X-Gm-Gg: ASbGncspa3aFkIasx3RVpc5c1obSdj3Pt3r9aYYWU4vPSxP5yboPubIjoKG2BKlp8Q4
	MkaZmOImFDI9gLTFsxRJFmA2gOdKSwt4OKCkSMr+vH28LIBmmKxR5a0xIDJcv/hv1Ri+U/Tez7n
	dHMa7C9ObhbPTYmVSrMjsaRIm5aSGdsI2M8qDeS0rIRnsT++AmfKr75IpRq2CZFDJHs7RJERBmg
	CqHFD6JmPUb0LBBMs7n3WaI0EugorpctY5F/8+phlguLLUfNp+bppllIVRmDvA10g0mslWsvfD6
	SzYAFZgxKktDB4oksYwz6YiRNXpNOiSFDQ==
X-Received: by 2002:a05:6000:4313:b0:3ea:6680:8fb5 with SMTP id ffacd0b85a97d-42666ab29d5mr15404679f8f.2.1760510002272;
        Tue, 14 Oct 2025 23:33:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEIRF0l4Q21l9jFN9l+tSLarmdL7yzNMiguJ5V8NmivPeOIyz/B0YcSRZ8aXBSFF4p4dY25oQ==
X-Received: by 2002:a05:6000:4313:b0:3ea:6680:8fb5 with SMTP id ffacd0b85a97d-42666ab29d5mr15404659f8f.2.1760510001787;
        Tue, 14 Oct 2025 23:33:21 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:152d:b200:2a90:8f13:7c1e:f479])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce57d3b9sm27612424f8f.11.2025.10.14.23.33.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 23:33:21 -0700 (PDT)
Date: Wed, 15 Oct 2025 02:33:18 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: Maxime Coquelin <mcoqueli@redhat.com>,
	Yongji Xie <xieyongji@bytedance.com>,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Dragos Tatulea DE <dtatulea@nvidia.com>, jasowang@redhat.com
Subject: Re: [RFC 1/2] virtio_net: timeout control virtqueue commands
Message-ID: <20251015023020-mutt-send-email-mst@kernel.org>
References: <20251007130622.144762-1-eperezma@redhat.com>
 <20251007130622.144762-2-eperezma@redhat.com>
 <20251014042459-mutt-send-email-mst@kernel.org>
 <CAO55cszGtuqL9qfs8SVB=Jjghefn=M0Rjw65f2DGPrjLQFFtqg@mail.gmail.com>
 <20251014051537-mutt-send-email-mst@kernel.org>
 <CAJaqyWe-mn4e+1egNCH+R1x4R7DB6U1SZ-mRAXYPTtA27hKCVA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJaqyWe-mn4e+1egNCH+R1x4R7DB6U1SZ-mRAXYPTtA27hKCVA@mail.gmail.com>

On Wed, Oct 15, 2025 at 08:08:31AM +0200, Eugenio Perez Martin wrote:
> On Tue, Oct 14, 2025 at 11:25 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Tue, Oct 14, 2025 at 11:14:40AM +0200, Maxime Coquelin wrote:
> > > On Tue, Oct 14, 2025 at 10:29 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > >
> > > > On Tue, Oct 07, 2025 at 03:06:21PM +0200, Eugenio Pérez wrote:
> > > > > An userland device implemented through VDUSE could take rtnl forever if
> > > > > the virtio-net driver is running on top of virtio_vdpa.  Let's break the
> > > > > device if it does not return the buffer in a longer-than-assumible
> > > > > timeout.
> > > >
> > > > So now I can't debug qemu with gdb because guest dies :(
> > > > Let's not break valid use-cases please.
> > > >
> > > >
> > > > Instead, solve it in vduse, probably by handling cvq within
> > > > kernel.
> > >
> > > Would a shadow control virtqueue implementation in the VDUSE driver work?
> > > It would ack systematically messages sent by the Virtio-net driver,
> > > and so assume the userspace application will Ack them.
> > >
> > > When the userspace application handles the message, if the handling fails,
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
> >
> 
> I thought of implementing this approach at first, but it has two drawbacks.
> 
> The first one: it's racy. Let's say the driver updates the MAC filter,
> VDUSE timeout occurs, the guest receives the fail, and then the device
> replies with an OK. There is no way for the device or VDUSE to update
> the driver.

There's no timeout. Kernel can guarantee executing all requests.



> 
> The second one, what to do when the VDUSE cvq runs out of descriptors?
> While the driver has its descriptor returned with VIRTIO_NET_ERR, the
> VDUSE CVQ has the descriptor available. If this process repeats to
> make available all of the VDUSE CVQ descriptors, how can we proceed?

There's no reason to return VIRTIO_NET_ERR ever and cvq will not run
out of descriptors. Kernel uses cvq buffers.


> I think both of them can be solved with the DEVICE_NEEDS_RESET status
> bit, but it is not implemented in the drivers at this moment.

No need for a reset, either.


