Return-Path: <linux-kernel+bounces-874941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2E5AC1792A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 01:39:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAD1B3AA9E7
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 00:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6877C2C3774;
	Wed, 29 Oct 2025 00:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SqKqCy3H"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB482C235E
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 00:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761698228; cv=none; b=UQs8EK+Hbxc5v+E0L1h5+YoqxDYNdJ1+VxPXqvXNPSMSjkDb0+70AojhJTuluEz8xlOcxGCl4rSKpjeBrTmC88Z1fx6CH2qbTRhAb1ORYZL1D/MOtInuZP19/Bi1p10Xdzfb4O2jjwwjra2CvcFZa67YsFFZm9s5USCUrVS9pTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761698228; c=relaxed/simple;
	bh=z2KxUywKM/o4sjXFIMx/mY+Zmwl/FX3Tzo88dQEt2xs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FF1Geig1RUZSgMhNVSzI5neMRbi7FF82V+LPaTeD6SANnsgibTi10/4BxN0E2twLhAL81IrOtBF8Lr0UjdlxhHXAE+1y0O8+Z/nj34W+bGHdpxl/1tdxA6RgLt6a2lIM7vTILfQ1LosbFky7ikaQSR+wJoRA4CG4Cl/OPRTOMJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SqKqCy3H; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761698226;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z2KxUywKM/o4sjXFIMx/mY+Zmwl/FX3Tzo88dQEt2xs=;
	b=SqKqCy3HOkbeW/a6ipLPP0dtoWBpmtUS0Cj+CBN9PAVTx3iZWYgI4cEa6jIXD0YoyiAwkU
	N1AjdERdyDp2NQx9fG9axt2A0V1T1ImP7bD9OHAIkG0svLWS9gJ2/mj62vwbaCrNcWMtGr
	Dc2riachxeeYuaCYo0Kdp8o/MTJiA2g=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-280--ndVHt-lOWailEEz75LxPw-1; Tue, 28 Oct 2025 20:37:04 -0400
X-MC-Unique: -ndVHt-lOWailEEz75LxPw-1
X-Mimecast-MFC-AGG-ID: -ndVHt-lOWailEEz75LxPw_1761698223
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b6ce1b57b9cso4435326a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 17:37:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761698223; x=1762303023;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z2KxUywKM/o4sjXFIMx/mY+Zmwl/FX3Tzo88dQEt2xs=;
        b=HSe2VcYDffK/JoRQyXDigNd7zIvABI6CU5LDujq+ID1NFH96TyBj3zewIRvUD16zsx
         h68/+Copup+vLQjD4uDo8PjX9hxIjAPqGLp+UQOiyTkafLzby4lyVqD8TkH1ssxllivu
         j5wnOSLUKnr/UxiuAjCos2jpr7kP3ntr1oIIYR+eo1AsuI/WwDPJ0o2Wknp0kYSWXBS0
         aRi7Ky2DscCeaZ4PTKsDLoxo8MA+fMVwVPwY6UFdtqqr4Ay+3EKw9o/F2OH3lDFxaFgF
         CvoeQ3+56CU7QBrdY3FNytPNKvNOhDN4aODoZmPU3WNfDLdKHQfpz4ApG29b0oQzmc+A
         BceA==
X-Forwarded-Encrypted: i=1; AJvYcCVawY/w4Tdgm/L4wLVoOLexaPlPbiJ8XKLR+gHTT41goTJeNcjQBpWgqnpQ5YKmpKmfbM3aYFl0YU+IgcA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpmY5ZJZPkYCHGxwwEelpq+cTDo7vjw+QQsB9rj4UTx8Lwbp9Y
	0C2Rmzf98sjJLEYRN55D4s9fWWyurlLRFyisAlENXhOy6ZYM3ihYsHItd64u0EiYmOkY0e9Ru+U
	xQ4Y9Ut5Ur8PPlcL/ZUSsW+TavvbbpfCCX5hV1Otc8VjmKSXc9JWa6yF3+VPLMGR0+Fvgi10ocn
	Ohne9RXltJwfAx8jEQLFD54g2QruVlE2k2D6KUPPHZ
X-Gm-Gg: ASbGncseUN5ms3fejABACDMigzYhbJrO7ViCaTVQY9iVllbi6xneL08bBIFc2pvpxBp
	rYWyqw9AaeRXTJqDEyhCYa2LA2oLCRBElmzR7CC4IFu1iL8FhpJLp6LVhonabucxWmmGWzfGbZ2
	zEvKvG3EZ1Xv+BFB7aopu+lTDYCv0in+JdhwXnNci1TMTUK4xs/Ooa
X-Received: by 2002:a17:903:18c:b0:25c:76f1:b024 with SMTP id d9443c01a7336-294dee3572dmr10317145ad.25.1761698223424;
        Tue, 28 Oct 2025 17:37:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE/SiMLBBOrGOScV5jwu3LEgWMNSKEpwIxmJj+/O/Qz7kK4bu5+UPkMl7kc61nl2u6Eqbd9szURp9TnMPpT23k=
X-Received: by 2002:a17:903:18c:b0:25c:76f1:b024 with SMTP id
 d9443c01a7336-294dee3572dmr10316805ad.25.1761698222965; Tue, 28 Oct 2025
 17:37:02 -0700 (PDT)
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
 <20251028104154-mutt-send-email-mst@kernel.org> <CAJaqyWc=Fhp2+m8P6cctkqG+oeXUgiGhKAsR5Ns20JMun=wvbQ@mail.gmail.com>
In-Reply-To: <CAJaqyWc=Fhp2+m8P6cctkqG+oeXUgiGhKAsR5Ns20JMun=wvbQ@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 29 Oct 2025 08:36:51 +0800
X-Gm-Features: AWmQ_blHBTuatMSJPDVuJEjsd9mldfKukgTo-6k1-Y6oj3d-VR92-lkw7uaPq1E
Message-ID: <CACGkMEsv3SXnQ74bQKadcOr5Ztv-O-VZ8Zgfdq7mXqXN_Yrg0Q@mail.gmail.com>
Subject: Re: [RFC 1/2] virtio_net: timeout control virtqueue commands
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Maxime Coquelin <mcoqueli@redhat.com>, 
	Yongji Xie <xieyongji@bytedance.com>, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Dragos Tatulea DE <dtatulea@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 28, 2025 at 10:58=E2=80=AFPM Eugenio Perez Martin
<eperezma@redhat.com> wrote:
>
> On Tue, Oct 28, 2025 at 3:42=E2=80=AFPM Michael S. Tsirkin <mst@redhat.co=
m> wrote:
> >
> > On Tue, Oct 28, 2025 at 03:37:09PM +0100, Eugenio Perez Martin wrote:
> > > On Tue, Oct 28, 2025 at 3:10=E2=80=AFPM Michael S. Tsirkin <mst@redha=
t.com> wrote:
> > > >
> > > > On Wed, Oct 22, 2025 at 02:55:18PM +0200, Eugenio Perez Martin wrot=
e:
> > > > > On Wed, Oct 22, 2025 at 1:43=E2=80=AFPM Michael S. Tsirkin <mst@r=
edhat.com> wrote:
> > > > > >
> > > > > > On Wed, Oct 22, 2025 at 12:50:53PM +0200, Eugenio Perez Martin =
wrote:
> > > > > > > Let me switch to MQ as I think it illustrates the point bette=
r.
> > > > > > >
> > > > > > > IIUC the workflow:
> > > > > > > a) virtio-net sends MQ_VQ_PAIRS_SET 2 to the device
> > > > > > > b) VDUSE CVQ sends ok to the virtio-net driver
> > > > > > > c) VDUSE CVQ sends the command to the VDUSE device
> > > > > > > d) Now the virtio-net driver sends virtio-net sends MQ_VQ_PAI=
RS_SET 1
> > > > > > > e) VDUSE CVQ sends ok to the virtio-net driver
> > > > > > >
> > > > > > > The device didn't process the MQ_VQ_PAIRS_SET 1 command at th=
is point,
> > > > > > > so it potentially uses the second rx queue. But, by the stand=
ard:
> > > > > > >
> > > > > > > The device MUST NOT queue packets on receive queues greater t=
han
> > > > > > > virtqueue_pairs once it has placed the VIRTIO_NET_CTRL_MQ_VQ_=
PAIRS_SET
> > > > > > > command in a used buffer.
> > > > > > >
> > > > > > > So the driver does not expect rx buffers on that queue at all=
. From
> > > > > > > the driver's POV, the device is invalid, and it could mark it=
 as
> > > > > > > broken.
> > > > > >
> > > > > > ok intresting. Note that if userspace processes vqs it should p=
rocess
> > > > > > cvq too. I don't know what to do in this case yet, I'm going on
> > > > > > vacation, let me ponder this a bit.
> > > > > >
> > > > >
> > > > > Sure.
> > > >
> > > > So let me ask you this, how are you going to handle device reset?
> > > > Same issue, it seems to me.
> > > >
> > >
> > > Well my proposal is to mark it as broken so it needs to be reset
> > > manually.
> >
> >
> > Heh but guest assumes after reset device does not poke at guest
> > memory, and will free up and reuse that memory.
> > If userspace still pokes at it -> plus plus ungood.
> >
>
> I don't get this part. Once the device is reset, the device should not
> poke at guest memory (unless it is malicious or similar). Why would it
> do it?
>

At least for this case virtio-vDPA + VDUSE, there's no way for the
userspace to poke after reset since everything is done via IOTLB.

For other devices, if we want this extra safety, we need to enable swiotlb.

Thanks


