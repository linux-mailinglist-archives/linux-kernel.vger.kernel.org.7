Return-Path: <linux-kernel+bounces-892169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EEF2C44877
	for <lists+linux-kernel@lfdr.de>; Sun, 09 Nov 2025 22:47:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 23D734E3052
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Nov 2025 21:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16827267B01;
	Sun,  9 Nov 2025 21:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LS8ma9Sw";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="C++xH0CO"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B193E171C9
	for <linux-kernel@vger.kernel.org>; Sun,  9 Nov 2025 21:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762724828; cv=none; b=kd3iD7V+1GSXeYXbNOt+TawPQ6bL7Y5IyYAWy81WW8cscxyPR2PFW2i74XhibP5+sQjspuYKK9WTufSDV+4bYWBrHP/z0C05tYnuKrPK+tt2OJFxt8xrG3+CJ/ubenG6nMREbf1fhUz1rL4q7BFZ1F4p5DmOOWDoNlOtMHgAJlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762724828; c=relaxed/simple;
	bh=8bHPJqkcpiWZiLm7GJ4WrZrYa8pHR79dKB5UTVQ/U6w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YsELe5oJRqZrgbw5KKkkyIbQC79HSU728pXe0h0b+1YGQeSo4fJg0Ow37A+J0Gh3M88iqw8ImKMZQCYgkrWR+boLx5D64uMQXQeG3DtikH0Cuc6nNifQdDHpqBePonfZY84n/btsJ3DRcJs4SHlgRbqoz9ugQ4alFXW/Nw5TQNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LS8ma9Sw; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=C++xH0CO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762724824;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MpPgJNNfQcmsOxPYyH1pXdl4WpjxS9YLpOkwsCYYikE=;
	b=LS8ma9SwpGg/fm0yPO/nUPJZcXMFp1z8RWqe29Gd8UXk0YCGVFZz9ohW1jwQ1s4szOo5ir
	BMnNhfkQbmq/5/Ol2IoWjZ+ZI411YKcFmMqAFpEzHoqRaU3XIJbaKc/SzYeRoUCMynks1p
	d1PY2zuz0KHmu42SiqVPdGN8+a5ou7Y=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-490-jwwlufzHOUiiKQwa0Lu2AQ-1; Sun, 09 Nov 2025 16:47:03 -0500
X-MC-Unique: jwwlufzHOUiiKQwa0Lu2AQ-1
X-Mimecast-MFC-AGG-ID: jwwlufzHOUiiKQwa0Lu2AQ_1762724821
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-429c76c8a1bso1808276f8f.0
        for <linux-kernel@vger.kernel.org>; Sun, 09 Nov 2025 13:47:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762724821; x=1763329621; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MpPgJNNfQcmsOxPYyH1pXdl4WpjxS9YLpOkwsCYYikE=;
        b=C++xH0COfsHW8ehKSLAZv9bA9w8JBbg7k4KX74uozIUNgdmM+HPfBJFyeM0fRFbk+s
         aoICW2WqoGRsGzsA/ch/D3tpJEfncPh7UxCfNw6bryQWQsQ2A4p6EixyG7OQz6ZyOtMf
         gd7aTh/Cv3WPbOeStHIZEEjS3iONcdeMi2mDYQ/e6RjGFIuaWQgGQ2e7WWKleQxh4vf3
         uD96ePdZxkloG7H0WfLkPa8uR844UkfQIpHRmLvbVkcOruZDdYUJFA1ws+BoSDP8+eLU
         /rS05OJNI646G3f8DYflpaRI91Oh10xAgX9zof4vTcjEB5k0vrlff7YnHpqh1jp4rhNP
         iovQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762724821; x=1763329621;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MpPgJNNfQcmsOxPYyH1pXdl4WpjxS9YLpOkwsCYYikE=;
        b=p7Eomaq/fEP8rJOGOFLlSaCw63+4h4ZaPfaIajuOskc9In1+9YQomzEfm0fSb/BJTm
         t5pdFXHTO92EDO2i0LWDyt6+tKSatozH7wVt3728lCHvuI/wg6lyMJ5b/oXw3zze5b9O
         CX+kiwWgIzVh8W1/4Iif5kKWV6KRBQdJXLNVxf2nhwv9UcXJwjSgGVtb/7HIjLb5s/iD
         Q8LJvQvuqAz13XagI/9NpzBQ8zjjA/+OBhDb4bwKTKt4lKOG0dXyKeNdhJ/5rozaE9OE
         CscTq61U75+kbvFYWQxaM0LEbcBmt6tAs8egV1VU95DvqYPRVoHXMDsnsgNaIqo/ej1T
         /a0g==
X-Forwarded-Encrypted: i=1; AJvYcCUNIW/fmepVkWYTqU37uCZh01f+DBB8Cg4bwvmP/ZZ3pmQqN2gdkT8/eCwXZR8Hnv+xfRzTT7WdWNZ586g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyT1oW0eCmdoWXyShAbZ41yT7OJsgoNai4dqr1LrauYpNgUkuSM
	Dbyhm4WCDJ4cecVQc+Lvcx/q7Dr9KjHDo1cByNHr7PQGUwoluP2T/4kXgkpAlq3X51VX8fJYTgl
	kkCLPPQ/Gfg+RVj7Gjdx5SdpElr88BRAD5LUI+SW9wxL+wQXXELonSVwcM891SsTZ9Q==
X-Gm-Gg: ASbGncsVMta3juejvl7HfJKvv9OoksXimay6WYNoV5Z/DsioBsr0BXhZOHtD8uWgCvI
	jOg7xHBUqDHJLXHZ1vhE7fosALkWQDNZet7TauRWMEUG0m/Hl25SOzf6x8Jsq7cNKgNAFhFzuRj
	HApFOkplBsu4dkDWoH9TrXNMsSm5Vawhji4wBWc4dIbH9CP9AQV2CWyEhtLETgwy27UWx3kI6EI
	aIHJK6XeVl0L5Ecv8sYQmvMOrYlwGenAy2gksiDz2CZIvqRms04PUlUQWC7zBdq6C7j6bFspOOZ
	eT6rKkKSLftiSnsmm9BhZrwRAGHDP/LqJq2pDYq4OdQBiC5XIoFuGer/7wrl/sI06js=
X-Received: by 2002:a5d:5d0e:0:b0:429:f051:84bf with SMTP id ffacd0b85a97d-42b2dc16b22mr4397037f8f.6.1762724820765;
        Sun, 09 Nov 2025 13:47:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGChrGnO/pUJIQy+0U7o2SKTCKjvG5QquXtb6ys9S/qAwgWsCeTMU6fAYrQrooQfJU9X4rYyw==
X-Received: by 2002:a5d:5d0e:0:b0:429:f051:84bf with SMTP id ffacd0b85a97d-42b2dc16b22mr4397025f8f.6.1762724820326;
        Sun, 09 Nov 2025 13:47:00 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1536:2700:9203:49b4:a0d:b580])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42abe62bfa0sm19252079f8f.5.2025.11.09.13.46.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Nov 2025 13:46:59 -0800 (PST)
Date: Sun, 9 Nov 2025 16:46:56 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: Maxime Coquelin <mcoqueli@redhat.com>,
	Yongji Xie <xieyongji@bytedance.com>,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Dragos Tatulea DE <dtatulea@nvidia.com>, jasowang@redhat.com
Subject: Re: [RFC 1/2] virtio_net: timeout control virtqueue commands
Message-ID: <20251109164528-mutt-send-email-mst@kernel.org>
References: <CAJaqyWcf3tz17q6G=123Xb+warf8Ckg=PLaPkzLU9hYHiUy9Zg@mail.gmail.com>
 <20251022060748-mutt-send-email-mst@kernel.org>
 <CAJaqyWdRN3C1nOHQjWroBPWKjc5efNfVbecpruL=Cgsk6i1FXg@mail.gmail.com>
 <20251022073231-mutt-send-email-mst@kernel.org>
 <CAJaqyWeDcyKKOvVdqUkpTuH3d-Tb9rBHG3ym+LC0fcmhrN_FJA@mail.gmail.com>
 <20251028100923-mutt-send-email-mst@kernel.org>
 <CAJaqyWePMtM8vtgm8UnGAv+_XNTnVNFSNuoqzt_Cn-CpZg46mA@mail.gmail.com>
 <20251028104154-mutt-send-email-mst@kernel.org>
 <CAJaqyWc=Fhp2+m8P6cctkqG+oeXUgiGhKAsR5Ns20JMun=wvbQ@mail.gmail.com>
 <CAJaqyWf1Sn7CE+VOptZprDgniRNo=8-ZzmcS5YMOeW=tP4nfBQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJaqyWf1Sn7CE+VOptZprDgniRNo=8-ZzmcS5YMOeW=tP4nfBQ@mail.gmail.com>

On Wed, Nov 05, 2025 at 10:02:48AM +0100, Eugenio Perez Martin wrote:
> On Tue, Oct 28, 2025 at 3:57 PM Eugenio Perez Martin
> <eperezma@redhat.com> wrote:
> >
> > On Tue, Oct 28, 2025 at 3:42 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > >
> > > On Tue, Oct 28, 2025 at 03:37:09PM +0100, Eugenio Perez Martin wrote:
> > > > On Tue, Oct 28, 2025 at 3:10 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > >
> > > > > On Wed, Oct 22, 2025 at 02:55:18PM +0200, Eugenio Perez Martin wrote:
> > > > > > On Wed, Oct 22, 2025 at 1:43 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > > > >
> > > > > > > On Wed, Oct 22, 2025 at 12:50:53PM +0200, Eugenio Perez Martin wrote:
> > > > > > > > Let me switch to MQ as I think it illustrates the point better.
> > > > > > > >
> > > > > > > > IIUC the workflow:
> > > > > > > > a) virtio-net sends MQ_VQ_PAIRS_SET 2 to the device
> > > > > > > > b) VDUSE CVQ sends ok to the virtio-net driver
> > > > > > > > c) VDUSE CVQ sends the command to the VDUSE device
> > > > > > > > d) Now the virtio-net driver sends virtio-net sends MQ_VQ_PAIRS_SET 1
> > > > > > > > e) VDUSE CVQ sends ok to the virtio-net driver
> > > > > > > >
> > > > > > > > The device didn't process the MQ_VQ_PAIRS_SET 1 command at this point,
> > > > > > > > so it potentially uses the second rx queue. But, by the standard:
> > > > > > > >
> > > > > > > > The device MUST NOT queue packets on receive queues greater than
> > > > > > > > virtqueue_pairs once it has placed the VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET
> > > > > > > > command in a used buffer.
> > > > > > > >
> > > > > > > > So the driver does not expect rx buffers on that queue at all. From
> > > > > > > > the driver's POV, the device is invalid, and it could mark it as
> > > > > > > > broken.
> > > > > > >
> > > > > > > ok intresting. Note that if userspace processes vqs it should process
> > > > > > > cvq too. I don't know what to do in this case yet, I'm going on
> > > > > > > vacation, let me ponder this a bit.
> > > > > > >
> > > > > >
> > > > > > Sure.
> > > > >
> > > > > So let me ask you this, how are you going to handle device reset?
> > > > > Same issue, it seems to me.
> > > > >
> > > >
> > > > Well my proposal is to mark it as broken so it needs to be reset
> > > > manually.
> > >
> > >
> > > Heh but guest assumes after reset device does not poke at guest
> > > memory, and will free up and reuse that memory.
> > > If userspace still pokes at it -> plus plus ungood.
> > >
> >
> > I don't get this part. Once the device is reset, the device should not
> > poke at guest memory (unless it is malicious or similar). Why would it
> > do it?
> 
> Friendly ping.



OK I thought about it a bunch. A lot of net drivers actually
just queue ethtool commands and finish them asynchronously.
Thinkably virtio could expose an API on whether it is safe to
wait for buffers to be used. virtio-net would then either
send commands directly or do the asynchronous thing.
Hmm?


-- 
MST


