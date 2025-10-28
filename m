Return-Path: <linux-kernel+bounces-873972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45F31C15366
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 15:44:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3702F661B22
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 14:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09C2D339709;
	Tue, 28 Oct 2025 14:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FpYSAbFL"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8645B30499B
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 14:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761662275; cv=none; b=Dy90dMRmXLBWDo3d4hCxg4VrWNaCBO9z3N7tRMg6ZLAkKveZZ08O1tkGtJpkiXqukrOpK/fnimpx5LTqwmtUA4BRRr2CQIa5Ek3ylDEoqBZp5RpPhynz1ToIO+7lqAT4hymLL/lhaF5TwACT9O/eU1Ol+Tzyl48fZKTJyaFWkD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761662275; c=relaxed/simple;
	bh=09NZc1BAr3Ka76OtTpIJwkZSeHbrbtpTLxSEWNV/iwI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pQPHMvN31e5uYij+1nenHHgu4cZusuk7qX//a9xeVEjGPUyMChwNRY6YQpUKBoHnUkxfDReabEcH4OQ78wVXumNcytYWhWbb/afubJoRw1ayzZZVJ2YQhXSlr45Ej2FZNFM5su311CWwWJKSWbhuyCLezi5aGR0hf8LeuhxLxpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FpYSAbFL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761662272;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=09NZc1BAr3Ka76OtTpIJwkZSeHbrbtpTLxSEWNV/iwI=;
	b=FpYSAbFLjd24ib93Rnjhj+HVUCNFw5NHADKSgJIeaQqrK32lltTL3Zpx8szQRZKPVMFvwX
	o5RKh+KgdSD0WGfHQzWT8sxw1Ao0PPZCmfxv9owsAMEHqo3nGVXV78yiJ3/1zh0Qnm/KuK
	4zEgg4V+yVtsbEqH12Br1834gy8Eeo0=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-lbSM5KEVNIy6BO2n-B3pXA-1; Tue, 28 Oct 2025 10:37:49 -0400
X-MC-Unique: lbSM5KEVNIy6BO2n-B3pXA-1
X-Mimecast-MFC-AGG-ID: lbSM5KEVNIy6BO2n-B3pXA_1761662268
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-378e3e1c7c0so41232491fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 07:37:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761662268; x=1762267068;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=09NZc1BAr3Ka76OtTpIJwkZSeHbrbtpTLxSEWNV/iwI=;
        b=bcRCy9yl7z0YPrW4Yawi1zwlTn3q63WUpww+nxP43L36VRqkyEa/8MWUjkSaCT9Kn7
         RjufnViTzToHIQvr7XaNCWRc5CPl4OzOh0i/YzsZdqc8g2fBcZ65uuDDZxbou133oRK7
         6sc1q/wAPgzD5ygKWe+iqc0iirZcoD7cf2XfSbKaf8/ycai5Rmq1yMbZ1BI9VmWpyVEp
         WClsHIof+P6Gx9ltN4FT5w6t1SVgNmdTS08Bgd+tiPrz0q2jAj1/BvCzC+06tBHv0H4k
         MPZ6l5L/1DD3+XVfaa+MPdbqR1i3TXPwKbtohDxOYkqHZ80SYNIqnQVMx8e9Qa9UH4a7
         84/Q==
X-Forwarded-Encrypted: i=1; AJvYcCV7igCR5U7L4+K9Zd/rGFJBKLxdJkkY4QehqSISyuQHzAgYcNiM381sTPEuFt4I4t7Xrhwl4yioXlLIa0s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5Jhrx4i8OPUuGvgDU4DenfwbOnEwKoj34yX8h/ueIjh27g7yL
	0ri/JUGW2/HmlVOhdXaaPVcP2cuABncGfhb4uGLaMqdNGgv1Y7nO4B5ZnCI0DlaIo/xmWF+/HSL
	k0QALqyA+VqMebvgJqdJNrW8R2eoDQ/vkzVL6Qg3DgFqUf2wZDJ7AToWdOf8ajnDETD5Jao+Ccb
	rEA7wL+MqB7EFuU76YBYq2ulfYYDFALudWzDRTQUzV
X-Gm-Gg: ASbGnctHW4+8YjWsCbT3Kj20UeD658Yql1chastOEV1vMGqeU8CDUFDJnLFD1kWiV4X
	ByTc35mhMUtU0QQnZpt5ggSCEOJYdKa4QMbRz05p8yjGN0ZkGTvDhltpeZdAkT23yebT1F9qNoM
	0rMzHm3+dlKs6v26GFs8H8jRxNUrMe5Jzg6NkMAdzoA90bp/IoaGA1udWG9my/6FEIjXlAFgfUD
	hpXW0FXsXvzpAsAAe0ZHrN7HTeHy4sL2sOUnRL0yCY=
X-Received: by 2002:a2e:a917:0:b0:377:c556:68b7 with SMTP id 38308e7fff4ca-37907c99b06mr10803891fa.17.1761662267626;
        Tue, 28 Oct 2025 07:37:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFH1qUNPl6ooa8Bsdv4mhpa8rES8RuOgArfXGQ7Zb+j6PUDeLzIiljeXqTefrnG6lrqdMn5JWzo4puaSyJ4lPM=
X-Received: by 2002:a2e:a917:0:b0:377:c556:68b7 with SMTP id
 38308e7fff4ca-37907c99b06mr10803841fa.17.1761662267194; Tue, 28 Oct 2025
 07:37:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJaqyWeiX1Tc77NcYoBbeVfKTeuKHK6hw=n_9Mk4y52k7Djr-g@mail.gmail.com>
 <20251015030313-mutt-send-email-mst@kernel.org> <CAJaqyWfRmhXM8eV+=wMVKgrc8SJ98OTtBCtNDJj8ZRUM5Y9Nmg@mail.gmail.com>
 <CAO55csx2rbjxEZk5K3aKcZ501KY3Zfs8ThEQHFqQ1ZB9RSXECA@mail.gmail.com>
 <20251015040722-mutt-send-email-mst@kernel.org> <CAJaqyWcf3tz17q6G=123Xb+warf8Ckg=PLaPkzLU9hYHiUy9Zg@mail.gmail.com>
 <20251022060748-mutt-send-email-mst@kernel.org> <CAJaqyWdRN3C1nOHQjWroBPWKjc5efNfVbecpruL=Cgsk6i1FXg@mail.gmail.com>
 <20251022073231-mutt-send-email-mst@kernel.org> <CAJaqyWeDcyKKOvVdqUkpTuH3d-Tb9rBHG3ym+LC0fcmhrN_FJA@mail.gmail.com>
 <20251028100923-mutt-send-email-mst@kernel.org>
In-Reply-To: <20251028100923-mutt-send-email-mst@kernel.org>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Tue, 28 Oct 2025 15:37:09 +0100
X-Gm-Features: AWmQ_bm_ikxtcCHfifEP3X9--_zb9nwAd7fq5zkuRGqhN1hAtFMAFJR9kqLgpas
Message-ID: <CAJaqyWePMtM8vtgm8UnGAv+_XNTnVNFSNuoqzt_Cn-CpZg46mA@mail.gmail.com>
Subject: Re: [RFC 1/2] virtio_net: timeout control virtqueue commands
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Maxime Coquelin <mcoqueli@redhat.com>, Yongji Xie <xieyongji@bytedance.com>, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Dragos Tatulea DE <dtatulea@nvidia.com>, jasowang@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 28, 2025 at 3:10=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Wed, Oct 22, 2025 at 02:55:18PM +0200, Eugenio Perez Martin wrote:
> > On Wed, Oct 22, 2025 at 1:43=E2=80=AFPM Michael S. Tsirkin <mst@redhat.=
com> wrote:
> > >
> > > On Wed, Oct 22, 2025 at 12:50:53PM +0200, Eugenio Perez Martin wrote:
> > > > Let me switch to MQ as I think it illustrates the point better.
> > > >
> > > > IIUC the workflow:
> > > > a) virtio-net sends MQ_VQ_PAIRS_SET 2 to the device
> > > > b) VDUSE CVQ sends ok to the virtio-net driver
> > > > c) VDUSE CVQ sends the command to the VDUSE device
> > > > d) Now the virtio-net driver sends virtio-net sends MQ_VQ_PAIRS_SET=
 1
> > > > e) VDUSE CVQ sends ok to the virtio-net driver
> > > >
> > > > The device didn't process the MQ_VQ_PAIRS_SET 1 command at this poi=
nt,
> > > > so it potentially uses the second rx queue. But, by the standard:
> > > >
> > > > The device MUST NOT queue packets on receive queues greater than
> > > > virtqueue_pairs once it has placed the VIRTIO_NET_CTRL_MQ_VQ_PAIRS_=
SET
> > > > command in a used buffer.
> > > >
> > > > So the driver does not expect rx buffers on that queue at all. From
> > > > the driver's POV, the device is invalid, and it could mark it as
> > > > broken.
> > >
> > > ok intresting. Note that if userspace processes vqs it should process
> > > cvq too. I don't know what to do in this case yet, I'm going on
> > > vacation, let me ponder this a bit.
> > >
> >
> > Sure.
>
> So let me ask you this, how are you going to handle device reset?
> Same issue, it seems to me.
>

Well my proposal is to mark it as broken so it needs to be reset
manually. For example, unbinding and binding the driver in Linux. The
point is that the driver cannot trust the device anymore as it is in
an invalid state. Maybe suspend and reset all the vqs is also a valid
solution to un-broke it if the device supports it but I think a race
is unavoidable there, and I'm not sure how to communicate it to
userspace for all kinds of devices. Incrementing rx errors could be a
first proposal.

If we want to track it in VDUSE we should implement NEEDS_RESET and
leave all the old drivers without solution. That's why I think it is
better to solve all the problems at once in the driver.


