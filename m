Return-Path: <linux-kernel+bounces-864668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 91EC1BFB4D7
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 12:07:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 560D94F6E07
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 10:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E802D2FB;
	Wed, 22 Oct 2025 10:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IZB0oFVm"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AADB119CC28
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 10:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761127624; cv=none; b=oKszASxatcVbZn1u6+jsFe3rESzByvUH+h55uJFXRcSdAu0pseQUMpjqXrT8601aG11LKoXVFsMqcWu1XmAFXqaLEEC7SnPnQqK8DPLxLES+N+9jRe2EIzfXvaj/536Gc9hZ9pAXlAsaoh2utAznF0zXlqO9drRGewbD+AVGpGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761127624; c=relaxed/simple;
	bh=KXby+KBos3mBCHbCtKceC1SeknYNBjI8ybIfHn2TN5E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lF/ab5cux37MPQ7fRU0++3BQk5AMOFn39QBRuiVoBxIhe+cNd/j+unFtUonvApVAMSXkE+EOHvcm6NWURpl06H5ZQzPMpaktQtvybAm75UBxf+5wRCaWLDjoIyQg33SFWrRQrvWMkQrWRCcwXe2FYSo560aT6Wri3y1DhZJWT60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IZB0oFVm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761127621;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/e+F1wjH70YTwPDjaw/7Mb8vtwGL0zVerrZ8/E0h6d0=;
	b=IZB0oFVmNO3pUkpmACM6PUWYr9QEQpHJ8owPNO9bfiQYrr3oQ19w664jDlQ9Oi01oM6egf
	Ig4Kpa2bEw+BwOxxz1wG+cOzJItMonwz4FA6MYdXHFwXJkq4OCt2RumkRdPyxm3NN+eRnV
	67svB3/xQTqbkkoOfhCXxLzxSuo07RA=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-70-mZZUSG3TMZ2lyBIevgb-zA-1; Wed, 22 Oct 2025 06:07:00 -0400
X-MC-Unique: mZZUSG3TMZ2lyBIevgb-zA-1
X-Mimecast-MFC-AGG-ID: mZZUSG3TMZ2lyBIevgb-zA_1761127619
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-b48635cf06fso683059766b.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 03:07:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761127619; x=1761732419;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/e+F1wjH70YTwPDjaw/7Mb8vtwGL0zVerrZ8/E0h6d0=;
        b=iHvMmjWdFGJwwHkhjBQzsBVifVjFGzYww53982GXlr6WnZY8iExVEsu2xAtpIEsWKO
         j1iSoANimYSCdeBBXLmlIU6shpjsgEDWuCfENizh9C82IdE3fbZ4Yox5F7GkNnW4G5+K
         iHON/Jb4wrvT/OYJjlsIM+UGFLxyosuT50OkK0TTehuHJc8rivgH0pdwnUe/MEt8RzbP
         BN/QMPlcGV6QbiHkvauEhtiHQG2yNibvPEuosQPGn3QvXysJ7GkFtPSr4myv5B1mKHtj
         eeZCSk8mb5F3hB9oE2QjrpfCE7ykhMyM+xb+1qTFDR3KBqQACaCRHivPMbylcWLckSLQ
         j3zQ==
X-Forwarded-Encrypted: i=1; AJvYcCVpeFlgw4BkyMVR73vV0bGdS6E4ruvyz7KcF4R9hSEg9w+lrv0fu5YI1b63fhHiAAquJsiM+96XGV7+Grg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/xwshUrB8+VqRMnW4M9mVRwqkrkPcCjfByt/h2Z9XfDF0lKID
	KB1LS9XoArkcH7GCmRK5NTA2Do3I2zJG1t6uoZtzUifvaq71pnSPtnV4LdY16Fv8NxRe/Hguk90
	a2HQ+w4dXC+mtZKfxYbLOEbQYd7ll5QY9td9RVFNNr9eoAdTFWiTJmKEVQVKCROHUQ/SKmDzR9A
	==
X-Gm-Gg: ASbGnctCY0Sh0AzRHDow87P57qElBRBMEEh6uVmcMPHi3VwUmzjgc5HCph8Jg/PVZq/
	X/coeHfFWqxGpfpPYyB/xeyjMtoRWl3xGmLvDAfdpp0a9Gwx2OOhmzoxmtKZFZV1dFYP2VXvQoc
	gfqWayOBsjhPISzgbgAX+Of2/5yVSVGB1CGzzccKWCRg62gwLjYp+WYyBrwD9YX2traIIsGq2vw
	rzIJ8MVTB/YU7dc/ijaIIJZP1pLx18t4nnrUtQKV9L8eZXLyVMSveDWr/MBWcpYZRZBStGrNG2T
	CYhFc7IZ/wgCWWOV5MxNanuWLMcnV9yvxvcIJUj5Eeb0o2x7iDGU60PicDfZx95Q
X-Received: by 2002:a17:907:980f:b0:b3c:3c8e:189d with SMTP id a640c23a62f3a-b6474b37113mr2591861066b.32.1761127618657;
        Wed, 22 Oct 2025 03:06:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFdi4vCu0HcpcB9RZjtPHlWXKhaiLhZv2KMQBy/nOXAmeOE3Rh1TYravOf+t544Sn9yyv5kZQ==
X-Received: by 2002:a17:907:980f:b0:b3c:3c8e:189d with SMTP id a640c23a62f3a-b6474b37113mr2591856866b.32.1761127618149;
        Wed, 22 Oct 2025 03:06:58 -0700 (PDT)
Received: from redhat.com ([31.187.78.209])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65ebf434f0sm1301190766b.82.2025.10.22.03.06.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 03:06:57 -0700 (PDT)
Date: Wed, 22 Oct 2025 06:06:54 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, Maxime Coquelin <mcoqueli@redhat.com>,
	Yongji Xie <xieyongji@bytedance.com>,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Dragos Tatulea DE <dtatulea@nvidia.com>
Subject: Re: [RFC 1/2] virtio_net: timeout control virtqueue commands
Message-ID: <20251022060506-mutt-send-email-mst@kernel.org>
References: <20251015040722-mutt-send-email-mst@kernel.org>
 <CAJaqyWcf3tz17q6G=123Xb+warf8Ckg=PLaPkzLU9hYHiUy9Zg@mail.gmail.com>
 <CACGkMEuPPFLH1YqTx03fV9N=Rx3aYXK0HMUDpZu-CvO1NYRRQA@mail.gmail.com>
 <20251016014328-mutt-send-email-mst@kernel.org>
 <CACGkMEtXWLicmszjkzOhX8Ta=LdGgsDahRUKDEVzBVG8am5vgg@mail.gmail.com>
 <20251016022131-mutt-send-email-mst@kernel.org>
 <CAJaqyWe--Hho9EdweqkC-h9=t5vhY0cbAN9uAw=hATpkSMbsEg@mail.gmail.com>
 <CAJaqyWdEY6KaVbBn5LJhkz7h6kytFg8-b8iXnc9N54L+q_Yrbw@mail.gmail.com>
 <20251017023902-mutt-send-email-mst@kernel.org>
 <CAJaqyWcyJU_ghJpQrnEyTf19o_NzE6FXkxgBRZx=1RYqQkN4gA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJaqyWcyJU_ghJpQrnEyTf19o_NzE6FXkxgBRZx=1RYqQkN4gA@mail.gmail.com>

On Fri, Oct 17, 2025 at 09:21:17AM +0200, Eugenio Perez Martin wrote:
> On Fri, Oct 17, 2025 at 8:39 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Fri, Oct 17, 2025 at 08:36:41AM +0200, Eugenio Perez Martin wrote:
> > > On Thu, Oct 16, 2025 at 8:25 AM Eugenio Perez Martin
> > > <eperezma@redhat.com> wrote:
> > > >
> > > > On Thu, Oct 16, 2025 at 8:22 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > >
> > > > > On Thu, Oct 16, 2025 at 02:03:57PM +0800, Jason Wang wrote:
> > > > > > On Thu, Oct 16, 2025 at 1:45 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > > > >
> > > > > > > On Thu, Oct 16, 2025 at 01:39:58PM +0800, Jason Wang wrote:
> > > > > > > > > >
> > > > > > > > > > Not exactly bufferize, record.  E.g. we do not need to send
> > > > > > > > > > 100 messages to enable/disable promisc mode - together they
> > > > > > > > > > have no effect.
> > > > > > > >
> > > > > > > > Note that there's a case that multiple commands need to be sent, e.g
> > > > > > > > set rx mode. And assuming not all the commands are the best effort,
> > > > > > > > kernel VDUSE still needs to wait for the usersapce at least for a
> > > > > > > > while.
> > > > > > >
> > > > > > > Not wait, record. Generate 1st command, after userspace consumed it -
> > > > > > > generate and send second command and so on.
> > > > > >
> > > > > > Right, that's what I asked in another thread, we still need a timeout
> > > > > > here.
> > > > >
> > > > > we do not need a timeout.
> > > > >
> > > > > > Then I think it would not be too much difference whether it is
> > > > > > VDUSE or CVQ that will fail or break the device. Conceptually, VDUSE
> > > > > > can only advertise NEEDS_RESET since it's a device implementation.
> > > > > > VDUSE can not simply break the device as it requires synchronization
> > > > > > which is not easy.
> > > > > >
> > > > > > > But for each bit of data, at most one command has to be sent,
> > > > > > > we do not care if guest tweaked rx mode 3 times, we only care about
> > > > > > > the latest state.
> > > > > >
> > > > > > Yes, but I want to know what's best when VDUSE meets userspace timeout.
> > > > > >
> > > > > > Thanks
> > > > >
> > > > >
> > > > > userspace should manage its own timeouts.
> > > > >
> > > >
> > > > Can we just apply the patch 2/2 of this RFC directly and apply the
> > > > VDUSE CVQ on top then? What are we missing to do it?
> > > >
> > >
> > > Even better, can we just revert commit 56e71885b0349 ("vduse:
> > > Temporarily fail if control queue feature requested") ?
> >
> > No because both would let userspace hang kernels merely by
> > not consuming buffers.
> >
> 
> My understanding was that you want to be able to debug qemu with gdb
> from that hang [1].
> 
> Could you put an example of the whole chain of events you expect? From
> the moment the driver sends a VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET command,
> the VDUSE CVQ Forwards the command to the VDUSE device in the
> userspace, and then the vduse userland device does not reply.

this is not the idea.

the idea is that kernel handles VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET.

separately it notifies userspace that some configuration
changed and userspace gets the new value.
Or not, if it is stuck.




> How does the VDUSE CVQ detect that the VDUSE device implemented in
> userland does not reply? What are the next steps from that point of
> the kernel VDUSE module?
> 
> Thanks!
> 
> [1] https://lore.kernel.org/lkml/20251014042459-mutt-send-email-mst@kernel.org/







