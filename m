Return-Path: <linux-kernel+bounces-874005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 610F3C154C9
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 16:01:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1821F503463
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 14:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E276C23ABBE;
	Tue, 28 Oct 2025 14:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="adcagzGH"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C44232ED53
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 14:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761663487; cv=none; b=BZF98WV9EzxPFdpgGlWSsb4Los4p86ywaBiehCnHQ1pp6MgWKBsh7MpkF1ItnR6H4upzjT0ljG9/MfG3MsJcrfHjZu8EJxc2lKeEH4/LmJrOoQlvvH82UBygSPRGJNjkgy3Uj4L7JXxhw4+wTRo49cTq/CW2CF0tf0ff/GNjbU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761663487; c=relaxed/simple;
	bh=8N/CyB3BhR9BzfFuw9y8Z5rJf3YG4p6pIZG96vMy1go=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pow2cfnl2mwXcxrNSZiTYdNKKS59GMXwaFXcDgjLRDsaN9gFFbnvsz25UGNe3hy/UgYeuZHocyyunGf4suReSXzeYKVuIN04IgNYyamYgBlRKJ+mMrAvbq7UoPVJJn/FW7bEPiAJRfHqvUt8PzEddNYzn2Om2HAhhzvLPm/za20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=adcagzGH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761663484;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8N/CyB3BhR9BzfFuw9y8Z5rJf3YG4p6pIZG96vMy1go=;
	b=adcagzGHnW+ZOvuDCisA1ZIJFWEf0F9ErtKWkqJtTtKllAH35TKQeDeKCODVU/GUNaG7Ya
	UANRbe8sEx3HMsISm0RkJHaN69wVUO3nQFa/2PgLsSEqzjGM/gNymQKKkZdVfzDCdmINxY
	Gls9v4QEqRN8z5507i6wx1FFC1Qq8fE=
Received: from mail-yx1-f70.google.com (mail-yx1-f70.google.com
 [74.125.224.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-55-BCE2JJHONl22Ix2tU5OT8w-1; Tue, 28 Oct 2025 10:58:02 -0400
X-MC-Unique: BCE2JJHONl22Ix2tU5OT8w-1
X-Mimecast-MFC-AGG-ID: BCE2JJHONl22Ix2tU5OT8w_1761663482
Received: by mail-yx1-f70.google.com with SMTP id 956f58d0204a3-63e1106dcbdso7558182d50.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 07:58:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761663482; x=1762268282;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8N/CyB3BhR9BzfFuw9y8Z5rJf3YG4p6pIZG96vMy1go=;
        b=mpFWl8BBH1QGhTyH6yTfD7d4u7IoPRpj7/lsyKYKjkZvIsGW6Ab05jnMMplimUFgv/
         IOhzY4v/2poRmHIpwx+AaZsJ+zcj9m06bdNvVWB4THoenNs3gQFyn4AdJ7ziZztw/jQy
         s4wLzI0uT03Rh2luIAw38MKbK7FlPPp3wu356akNSLy7X1D4+PEnh9FUOWBlzuGuVHYz
         QAv3sr6CNqkb5kVsvI5+WIpMrbdtklswe3FvzdeDBsmEsepQXEDeuL3KSZRP3lGiWTW9
         32zuFk71GkqZtu6J4qwf4AV03Fd9+i3FBA5XdfGO+RMfs6XwgKfl3WqXKgslHFTDacez
         W1sw==
X-Forwarded-Encrypted: i=1; AJvYcCW0Iay63uNLI/lt7L+MdvpZ8FP0IWw4azhTlsvAq+kf1MMH/L0m64p55JrRAQ2KEnaxWgBWUbDBiE4pFtM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGkFAmkwvtvGa7SEvk3zYC4kF2D2L9/A24gW1+L29nG2cK7bQw
	2xJ5FyvaMvEYtNH2x2g2hu9TlotlkkUbYh7Zeoe2wmL5xtoUXMt8ArOLDt04ZzjB/DwdHWfdoa/
	UQQtJo5QNq320EDJmghBEYNUh08Itd/1/wAXbIfs/YB9uUNUbjzn1yEOojh/4tMSK2nFK7dLR6Y
	NfgJfPHmQ/hoHBv3W3Gc7h61bXrkO6P9ZbO/cgZF8h
X-Gm-Gg: ASbGncvmKQDn+r4gjljFNOQmjNStbUXGyK0S2L/93w6esWcXsxYH8g3+Z6Lvz0Hf6qV
	/dPgRl8ANpRFWpkwl9trlBPvLqpoEeD7U21dA+IqHpXiSRHLJMYyl0foXuO1AYX76E13WIjTQ9K
	bX8tgt0kQ5rwDx5DwuFmlQS5SONXDHeftpzHYgyhUjNHstRqMm5qZZH0YVQvYK8yVFnj9Kn6x/G
	6P4BHw2Re9lHcMafwFGB8noARKCDOJGlM7/pipHGcQ=
X-Received: by 2002:a53:acd4:0:20b0:63c:f5a6:f2ea with SMTP id 956f58d0204a3-63f6bab5397mr2747702d50.60.1761663482130;
        Tue, 28 Oct 2025 07:58:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH/WTYIQ7xXhGVCT8HcoFOlFNGW08q+9o43hTP9kcxsycKYCEMDq54qPBeanzA+lWFpmCWYMaATbs7BaCevFQk=
X-Received: by 2002:a53:acd4:0:20b0:63c:f5a6:f2ea with SMTP id
 956f58d0204a3-63f6bab5397mr2747678d50.60.1761663481676; Tue, 28 Oct 2025
 07:58:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJaqyWfRmhXM8eV+=wMVKgrc8SJ98OTtBCtNDJj8ZRUM5Y9Nmg@mail.gmail.com>
 <CAO55csx2rbjxEZk5K3aKcZ501KY3Zfs8ThEQHFqQ1ZB9RSXECA@mail.gmail.com>
 <20251015040722-mutt-send-email-mst@kernel.org> <CAJaqyWcf3tz17q6G=123Xb+warf8Ckg=PLaPkzLU9hYHiUy9Zg@mail.gmail.com>
 <20251022060748-mutt-send-email-mst@kernel.org> <CAJaqyWdRN3C1nOHQjWroBPWKjc5efNfVbecpruL=Cgsk6i1FXg@mail.gmail.com>
 <20251022073231-mutt-send-email-mst@kernel.org> <CAJaqyWeDcyKKOvVdqUkpTuH3d-Tb9rBHG3ym+LC0fcmhrN_FJA@mail.gmail.com>
 <20251028100923-mutt-send-email-mst@kernel.org> <CAJaqyWePMtM8vtgm8UnGAv+_XNTnVNFSNuoqzt_Cn-CpZg46mA@mail.gmail.com>
 <20251028104154-mutt-send-email-mst@kernel.org>
In-Reply-To: <20251028104154-mutt-send-email-mst@kernel.org>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Tue, 28 Oct 2025 15:57:25 +0100
X-Gm-Features: AWmQ_blFtkQy1FAJaebTbyFFQKUNvmY_l68PG6mENUqg3UT3GDXoN0f29IuNmmk
Message-ID: <CAJaqyWc=Fhp2+m8P6cctkqG+oeXUgiGhKAsR5Ns20JMun=wvbQ@mail.gmail.com>
Subject: Re: [RFC 1/2] virtio_net: timeout control virtqueue commands
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Maxime Coquelin <mcoqueli@redhat.com>, Yongji Xie <xieyongji@bytedance.com>, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Dragos Tatulea DE <dtatulea@nvidia.com>, jasowang@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 28, 2025 at 3:42=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Tue, Oct 28, 2025 at 03:37:09PM +0100, Eugenio Perez Martin wrote:
> > On Tue, Oct 28, 2025 at 3:10=E2=80=AFPM Michael S. Tsirkin <mst@redhat.=
com> wrote:
> > >
> > > On Wed, Oct 22, 2025 at 02:55:18PM +0200, Eugenio Perez Martin wrote:
> > > > On Wed, Oct 22, 2025 at 1:43=E2=80=AFPM Michael S. Tsirkin <mst@red=
hat.com> wrote:
> > > > >
> > > > > On Wed, Oct 22, 2025 at 12:50:53PM +0200, Eugenio Perez Martin wr=
ote:
> > > > > > Let me switch to MQ as I think it illustrates the point better.
> > > > > >
> > > > > > IIUC the workflow:
> > > > > > a) virtio-net sends MQ_VQ_PAIRS_SET 2 to the device
> > > > > > b) VDUSE CVQ sends ok to the virtio-net driver
> > > > > > c) VDUSE CVQ sends the command to the VDUSE device
> > > > > > d) Now the virtio-net driver sends virtio-net sends MQ_VQ_PAIRS=
_SET 1
> > > > > > e) VDUSE CVQ sends ok to the virtio-net driver
> > > > > >
> > > > > > The device didn't process the MQ_VQ_PAIRS_SET 1 command at this=
 point,
> > > > > > so it potentially uses the second rx queue. But, by the standar=
d:
> > > > > >
> > > > > > The device MUST NOT queue packets on receive queues greater tha=
n
> > > > > > virtqueue_pairs once it has placed the VIRTIO_NET_CTRL_MQ_VQ_PA=
IRS_SET
> > > > > > command in a used buffer.
> > > > > >
> > > > > > So the driver does not expect rx buffers on that queue at all. =
From
> > > > > > the driver's POV, the device is invalid, and it could mark it a=
s
> > > > > > broken.
> > > > >
> > > > > ok intresting. Note that if userspace processes vqs it should pro=
cess
> > > > > cvq too. I don't know what to do in this case yet, I'm going on
> > > > > vacation, let me ponder this a bit.
> > > > >
> > > >
> > > > Sure.
> > >
> > > So let me ask you this, how are you going to handle device reset?
> > > Same issue, it seems to me.
> > >
> >
> > Well my proposal is to mark it as broken so it needs to be reset
> > manually.
>
>
> Heh but guest assumes after reset device does not poke at guest
> memory, and will free up and reuse that memory.
> If userspace still pokes at it -> plus plus ungood.
>

I don't get this part. Once the device is reset, the device should not
poke at guest memory (unless it is malicious or similar). Why would it
do it?


