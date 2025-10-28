Return-Path: <linux-kernel+bounces-873937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78638C151C8
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 15:18:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E60706454AD
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 14:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED6AF336EE2;
	Tue, 28 Oct 2025 14:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q0Um8C3g"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CEE8331A42
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 14:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761660599; cv=none; b=VvAxrI1CsTA+tY5IAUBUdsjKV0X8H0+YUypiex3j968Vg0sVDQTZtpr90apm5pzeCaRNtGnC3DaVvUU4Go36f5vgP6KykKzKX95omKa09GzVlHjDLQt/9h7S/gwCykOncZNr2naRgJkHs7flS3cihpGUZ6MQqgzCCZMYiLv0mnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761660599; c=relaxed/simple;
	bh=k6DUB/80tk/p9ZsPvOsXhgNv+6GExQYVkWQJfA0Xymg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o7Nib3/yoDr8N/7w2bFjLET8Ac7eMsO/c1nEqXcZhMHe57sGOi8eHJJnweVyNmaT0OvA8uLfTy63eo5JIOaskdUTlx0ZjOBF43rZbCZkYa5wsDtmdKIMZFROBLfIdHnM2SKzDy/Z2ikz5wAO1p3XfY90922DakEsKK4N0nEKFfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q0Um8C3g; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761660596;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KeZZLRTGnwzYPkoev55d4qpCXJZUXZb6bdFgAsfZ6dc=;
	b=Q0Um8C3g+GxcyDDI62iFyQTvH0NARB3pQ6gXX/5NwJjnK1GIofo06aFj3JThDY/b7bByTf
	B8Gw3HLqkNG59yg3SQ5D+1IauiucXjjcF6SxebG1x1p18rYJaAVg0qVtxsV3mIt93cit2W
	m7uVJAzdEU48ZAaKrPqBQ6NjGszxXgY=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-1-1UbRLVZjMl6t9aZTGs9wkQ-1; Tue, 28 Oct 2025 10:09:54 -0400
X-MC-Unique: 1UbRLVZjMl6t9aZTGs9wkQ-1
X-Mimecast-MFC-AGG-ID: 1UbRLVZjMl6t9aZTGs9wkQ_1761660593
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-63c074c62b6so9026585a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 07:09:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761660593; x=1762265393;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KeZZLRTGnwzYPkoev55d4qpCXJZUXZb6bdFgAsfZ6dc=;
        b=Tk0cEKgFLkcGkBlds4XmzajqGuprhx9kJXXyP4/yPsyTY26D1M4bt1nuPXo7eQXjRh
         winjwQTxndwdVpdxHZASUpfkDplwEg6nom4TLUr3MV6eLAlT2AeWLcyLXRGcvWnHa8Va
         0/xIbJ4IJorJG/ca839o2jSBynUW371uz3tdR31dmYDJuPAyf1dRB+yMbW4EqPOElVF3
         JuBO6lfHwguM+huaUvHt4HXhdGa4KBkD9jnXC64Lp5vzSXeoiEhz1rUcsGI9eF4nWDNH
         0kCmttHieR7jeLfIwqVuI5ccRkzVwBBN37Gts2SV7DCGpRA1TyvAybhSFtCMXEQt56oG
         pLtA==
X-Forwarded-Encrypted: i=1; AJvYcCWjScwk/DhIOBTNr0f1/ht3iavJ2RMBcDpt+PnuQ7FBtqp+F9JehpHkN4OAqH2owX0SHc96MMLXzV1EfH0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy84Oxar8O9wI34bEJwridEbLB836s3/JZVcwzrR0dwdqoZCEHu
	VtaWrhvMvk0e9KbfGKLWky2YIWvQObP3bnMavvRo2Pjm9SJHAYJctoPI+ItfCUMkvAWkc53jXI3
	eowxcaoRQj+PTP42yO1M+4KP63Xfm+Y0yI9yW75ysyxYwwlyBBcuSnpP8da2D9FzoJA==
X-Gm-Gg: ASbGncvvFvE6/P3j6yDy3DWiBU7tgf1iBv3m7W9MPvrKE3M0w3VIhOPigF8UGd+3yoa
	96iDFPpV0lGgqXPTHJzXo2+IifA1qtI4VVCM3KmOm2F66vJMaDU1jcfK/4Kf1EQqmw0dw81tuXo
	nZ59U5PUqMmHgDJtN6eoBghUc9zcWLlhzJBTN3niP7YJNPMX7TSYey371pDmm8c26u1ZuukM2Wl
	E8o17du1cWa7JY1cG2JmYj4+tVlGLIiC/ichP31gh4SmgSWwM8mHvZb73QpKLeZJikZ8vuQdoX7
	rquml+n1nCOilIldSI9GafqDmVqTHcTzLkNR9Oywmu35ccOkL1X8SDNXpgfPOaXu
X-Received: by 2002:a05:6402:1456:b0:63b:f1aa:11d1 with SMTP id 4fb4d7f45d1cf-63ed826acdcmr3237255a12.1.1761660593381;
        Tue, 28 Oct 2025 07:09:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEem+lTvepnFKdZpVOUw39YZBZhlQB90KyKypzmERmitQ6amw9M9mWfyT8audleripecx8J2Q==
X-Received: by 2002:a05:6402:1456:b0:63b:f1aa:11d1 with SMTP id 4fb4d7f45d1cf-63ed826acdcmr3237226a12.1.1761660592882;
        Tue, 28 Oct 2025 07:09:52 -0700 (PDT)
Received: from redhat.com ([31.187.78.209])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63e7efd0e23sm8969833a12.35.2025.10.28.07.09.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 07:09:52 -0700 (PDT)
Date: Tue, 28 Oct 2025 10:09:49 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: Maxime Coquelin <mcoqueli@redhat.com>,
	Yongji Xie <xieyongji@bytedance.com>,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Dragos Tatulea DE <dtatulea@nvidia.com>, jasowang@redhat.com
Subject: Re: [RFC 1/2] virtio_net: timeout control virtqueue commands
Message-ID: <20251028100923-mutt-send-email-mst@kernel.org>
References: <CAJaqyWeiX1Tc77NcYoBbeVfKTeuKHK6hw=n_9Mk4y52k7Djr-g@mail.gmail.com>
 <20251015030313-mutt-send-email-mst@kernel.org>
 <CAJaqyWfRmhXM8eV+=wMVKgrc8SJ98OTtBCtNDJj8ZRUM5Y9Nmg@mail.gmail.com>
 <CAO55csx2rbjxEZk5K3aKcZ501KY3Zfs8ThEQHFqQ1ZB9RSXECA@mail.gmail.com>
 <20251015040722-mutt-send-email-mst@kernel.org>
 <CAJaqyWcf3tz17q6G=123Xb+warf8Ckg=PLaPkzLU9hYHiUy9Zg@mail.gmail.com>
 <20251022060748-mutt-send-email-mst@kernel.org>
 <CAJaqyWdRN3C1nOHQjWroBPWKjc5efNfVbecpruL=Cgsk6i1FXg@mail.gmail.com>
 <20251022073231-mutt-send-email-mst@kernel.org>
 <CAJaqyWeDcyKKOvVdqUkpTuH3d-Tb9rBHG3ym+LC0fcmhrN_FJA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJaqyWeDcyKKOvVdqUkpTuH3d-Tb9rBHG3ym+LC0fcmhrN_FJA@mail.gmail.com>

On Wed, Oct 22, 2025 at 02:55:18PM +0200, Eugenio Perez Martin wrote:
> On Wed, Oct 22, 2025 at 1:43 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Wed, Oct 22, 2025 at 12:50:53PM +0200, Eugenio Perez Martin wrote:
> > > Let me switch to MQ as I think it illustrates the point better.
> > >
> > > IIUC the workflow:
> > > a) virtio-net sends MQ_VQ_PAIRS_SET 2 to the device
> > > b) VDUSE CVQ sends ok to the virtio-net driver
> > > c) VDUSE CVQ sends the command to the VDUSE device
> > > d) Now the virtio-net driver sends virtio-net sends MQ_VQ_PAIRS_SET 1
> > > e) VDUSE CVQ sends ok to the virtio-net driver
> > >
> > > The device didn't process the MQ_VQ_PAIRS_SET 1 command at this point,
> > > so it potentially uses the second rx queue. But, by the standard:
> > >
> > > The device MUST NOT queue packets on receive queues greater than
> > > virtqueue_pairs once it has placed the VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET
> > > command in a used buffer.
> > >
> > > So the driver does not expect rx buffers on that queue at all. From
> > > the driver's POV, the device is invalid, and it could mark it as
> > > broken.
> >
> > ok intresting. Note that if userspace processes vqs it should process
> > cvq too. I don't know what to do in this case yet, I'm going on
> > vacation, let me ponder this a bit.
> >
> 
> Sure.

So let me ask you this, how are you going to handle device reset?
Same issue, it seems to me.

-- 
MST


