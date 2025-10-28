Return-Path: <linux-kernel+bounces-873977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 36AFDC15357
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 15:43:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 976554E8FD7
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 14:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32E1133A016;
	Tue, 28 Oct 2025 14:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FVfwfFOY"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 548F22139CE
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 14:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761662579; cv=none; b=h7I/ku8N6v+udkn9/Q9FSltlgw137nkXLQeN9q8u9SGMt7KgQ24LK1lFmOBVFbcJZ5hScb/TiUAFhgXSef/oNnpca9L76QL5U/Z1VLisj2rM15aSNZNi7+l/wuno0O71lKdZeq0S+1LNfCD7xGtnycEyQ0jG9ESYe9gJ7mbd1lA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761662579; c=relaxed/simple;
	bh=Qj7vk7uTH1BUaGwkyY9Q/6UjhXjCxtzuh88Iuht0Qho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gX8N5TWpoDWuT2Cr4v5us5A71zKWpa3KRz36XBU1U0dJL/FlmEzAu2aYqH+QSOvdpkeVSWsjFVg7LqJrEBWiYodQ1F/vqYlIHE00jM81E7hADB+V+gt8toQwS2NWYVa0NbJTgtQA1cqBkiKbowug2pjOaKL0TXsQPh0cCJKJk/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FVfwfFOY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761662575;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=woPx9WhmwY04MjIk66oosoLlHaAzSD9kVyrfhGb0WyQ=;
	b=FVfwfFOYCCo+qkcB1VEOorQ7GvN0E8e/w9t/aaWlwoegMFP8ljU1mvgT6C3jsjeQcuTn2t
	wdhWDSuFDAKTrbj3UBV3TP4i86qyqgko6X5GXgwAWtNgtZKiopUiT0jE84rQqP8igbOWNE
	ZnEYxGRCLaOaTALrVdZr14kUqUMLyJ8=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-281-C-vSl0rjM9uUmLe1-gN6tg-1; Tue, 28 Oct 2025 10:42:53 -0400
X-MC-Unique: C-vSl0rjM9uUmLe1-gN6tg-1
X-Mimecast-MFC-AGG-ID: C-vSl0rjM9uUmLe1-gN6tg_1761662572
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-b6d42c454c2so345375766b.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 07:42:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761662572; x=1762267372;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=woPx9WhmwY04MjIk66oosoLlHaAzSD9kVyrfhGb0WyQ=;
        b=fgVD9imeQGnt3tma72GpiXCASEGIqolhfLT3K5bfsF56Y3aSmMSGmDTTHFlbAcMVZN
         xdC2qtxbF01YPzWwSqNj3IY2EwwNaJQl1S2BOiWWX7m+MxoiCr5yMt/fW525ioBjMtoY
         efmcvSeQsD+xDojzLLtQ7lZoDY4VqBuW8eN51VgRgRE+c5R6NZUvIeKry6xJwh4FS+gh
         947d+GqmGX1wm/denSojRSK4jnxXDbQHZYRuzeo+OKUbkqbhoAVM940NMavOiAgOnI3b
         AviS77m9kQcZQ7lTPZBCiIjSvIPgACsHIyE5SV5ywooSBemhC6xWNjwYwuTZNlw1rKxL
         qIJw==
X-Forwarded-Encrypted: i=1; AJvYcCUCNFOpfx8aZFuekkjqyFUNjjjhQxt3VYKivGOH71vGDjhY9ropy2553m2ncWYjSraUBB6v4MOPXp9jyj8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcM2nqquYsRbt3g6iJejY4h1LEA5TQdUAcAo5ZuIU+UWKk0Ezf
	tH0svl9E0T5C5YwdWoTwEmdGAnFH4ieUrkb5ntQikC9CRO93zwEZBUxEuV29R0Ae/UPAoVfwdKe
	yPatc8Gp+w+3XxWIaZ54HP4vBRBdh9m5/7a7+pbTHDSR8Mc2bcqlVLk10wYQE4+QK0w==
X-Gm-Gg: ASbGncu+wL4ckf2xlnn1d83N0WqAmtDD1TCm0ZD8NxRLogp0TflL4Uz4J4kCAYuiTv/
	Hzajnkh2HCSafOe7Y8nsFjn2Xdz4sfGS9K0JskXDolq8A7GT6+byKYOxy0e1ZrXMMI5dHyoXD1N
	ktR/s9PfqG32aCMpp5P2aKt517lZSGjoMnFZeUT4oJHgIZs9VY36LoUjcEcWxNjb66ZIsXVc9WT
	vLs7kSq7dxBWqlr514Wq32j/LdtlWk3SkHRF9ydJze1HuFirKZHL+lLVxvK05xK2EnXGFbXjmd1
	WCk7DD3Z1MPMHnCP62/vgPQBdeJsFWXNCCycWYzbdw99Jbzu3prwGV7XlDkYqPDt
X-Received: by 2002:a17:907:2da2:b0:b6d:76a9:e7de with SMTP id a640c23a62f3a-b6dba45b18cmr383531266b.8.1761662572127;
        Tue, 28 Oct 2025 07:42:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHX+9QwURp9/sS/6BgNcaqFOSOydpvsqcU1BGjMxVWZLPbegGZKTa+1qvtbiLD844pPi67X3A==
X-Received: by 2002:a17:907:2da2:b0:b6d:76a9:e7de with SMTP id a640c23a62f3a-b6dba45b18cmr383529666b.8.1761662571688;
        Tue, 28 Oct 2025 07:42:51 -0700 (PDT)
Received: from redhat.com ([31.187.78.209])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d85413b88sm1090546266b.55.2025.10.28.07.42.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 07:42:51 -0700 (PDT)
Date: Tue, 28 Oct 2025 10:42:48 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: Maxime Coquelin <mcoqueli@redhat.com>,
	Yongji Xie <xieyongji@bytedance.com>,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Dragos Tatulea DE <dtatulea@nvidia.com>, jasowang@redhat.com
Subject: Re: [RFC 1/2] virtio_net: timeout control virtqueue commands
Message-ID: <20251028104154-mutt-send-email-mst@kernel.org>
References: <CAJaqyWfRmhXM8eV+=wMVKgrc8SJ98OTtBCtNDJj8ZRUM5Y9Nmg@mail.gmail.com>
 <CAO55csx2rbjxEZk5K3aKcZ501KY3Zfs8ThEQHFqQ1ZB9RSXECA@mail.gmail.com>
 <20251015040722-mutt-send-email-mst@kernel.org>
 <CAJaqyWcf3tz17q6G=123Xb+warf8Ckg=PLaPkzLU9hYHiUy9Zg@mail.gmail.com>
 <20251022060748-mutt-send-email-mst@kernel.org>
 <CAJaqyWdRN3C1nOHQjWroBPWKjc5efNfVbecpruL=Cgsk6i1FXg@mail.gmail.com>
 <20251022073231-mutt-send-email-mst@kernel.org>
 <CAJaqyWeDcyKKOvVdqUkpTuH3d-Tb9rBHG3ym+LC0fcmhrN_FJA@mail.gmail.com>
 <20251028100923-mutt-send-email-mst@kernel.org>
 <CAJaqyWePMtM8vtgm8UnGAv+_XNTnVNFSNuoqzt_Cn-CpZg46mA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJaqyWePMtM8vtgm8UnGAv+_XNTnVNFSNuoqzt_Cn-CpZg46mA@mail.gmail.com>

On Tue, Oct 28, 2025 at 03:37:09PM +0100, Eugenio Perez Martin wrote:
> On Tue, Oct 28, 2025 at 3:10 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Wed, Oct 22, 2025 at 02:55:18PM +0200, Eugenio Perez Martin wrote:
> > > On Wed, Oct 22, 2025 at 1:43 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > >
> > > > On Wed, Oct 22, 2025 at 12:50:53PM +0200, Eugenio Perez Martin wrote:
> > > > > Let me switch to MQ as I think it illustrates the point better.
> > > > >
> > > > > IIUC the workflow:
> > > > > a) virtio-net sends MQ_VQ_PAIRS_SET 2 to the device
> > > > > b) VDUSE CVQ sends ok to the virtio-net driver
> > > > > c) VDUSE CVQ sends the command to the VDUSE device
> > > > > d) Now the virtio-net driver sends virtio-net sends MQ_VQ_PAIRS_SET 1
> > > > > e) VDUSE CVQ sends ok to the virtio-net driver
> > > > >
> > > > > The device didn't process the MQ_VQ_PAIRS_SET 1 command at this point,
> > > > > so it potentially uses the second rx queue. But, by the standard:
> > > > >
> > > > > The device MUST NOT queue packets on receive queues greater than
> > > > > virtqueue_pairs once it has placed the VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET
> > > > > command in a used buffer.
> > > > >
> > > > > So the driver does not expect rx buffers on that queue at all. From
> > > > > the driver's POV, the device is invalid, and it could mark it as
> > > > > broken.
> > > >
> > > > ok intresting. Note that if userspace processes vqs it should process
> > > > cvq too. I don't know what to do in this case yet, I'm going on
> > > > vacation, let me ponder this a bit.
> > > >
> > >
> > > Sure.
> >
> > So let me ask you this, how are you going to handle device reset?
> > Same issue, it seems to me.
> >
> 
> Well my proposal is to mark it as broken so it needs to be reset
> manually.


Heh but guest assumes after reset device does not poke at guest
memory, and will free up and reuse that memory.
If userspace still pokes at it -> plus plus ungood.

> For example, unbinding and binding the driver in Linux. The
> point is that the driver cannot trust the device anymore as it is in
> an invalid state. Maybe suspend and reset all the vqs is also a valid
> solution to un-broke it if the device supports it but I think a race
> is unavoidable there, and I'm not sure how to communicate it to
> userspace for all kinds of devices. Incrementing rx errors could be a
> first proposal.
> 
> If we want to track it in VDUSE we should implement NEEDS_RESET and
> leave all the old drivers without solution. That's why I think it is
> better to solve all the problems at once in the driver.


