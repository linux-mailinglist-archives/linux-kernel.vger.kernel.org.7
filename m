Return-Path: <linux-kernel+bounces-758956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 239FAB1D62D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 12:56:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C465A5612F5
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 10:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E87C277CA0;
	Thu,  7 Aug 2025 10:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PpkctXu8"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD52221F31
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 10:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754564183; cv=none; b=IxW6hmpqqCcupsnPsFdUifJtdGRmoTyFDfcaaW3ZcusvFvFogOrkDXyfhaJU2pYOnEEKU674l8ME11oUXT1S6ySRPQpgrTX/zSaKAUM6mQfP0LiOPpXbCM0+ju/i8OwVxt9i80YnWhVpr2lqmdC5H2pI2r49prgFLxSd5vnDtHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754564183; c=relaxed/simple;
	bh=5WHRKH5kbB05KZTBQnFvrLARtEFezmcNFMUZirfp/wU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WZT2grgpGc+441KTm0lmOWzNTvgK6Ti8sHCM9vopVGgRjbAnSKsK8fIRfohoUkq++zQStpf8FoZ4NUAlAJnUjggIXa2qESnplY8W5RJtAqhjbhefxK0jjx5vBKrfzNDIIIXNJm1MnOonVyoFPOY2ULNSwmYw/+WiyH8H+sIX3TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PpkctXu8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754564179;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5WHRKH5kbB05KZTBQnFvrLARtEFezmcNFMUZirfp/wU=;
	b=PpkctXu8F7M+6hE0NUvdAh8tTIxxjWZZLWeLMkhlXZloQvMFpH8SunSYG+DPMSzP4/7c4P
	6Q8zT0QShFFEWkTSjmhqqavsDuokmc0kWC+P+aklRTsc2btsgdzyN37WuV/LRynx+3tedK
	ECMrfXwCcRzsHsmbyaEuoYjbBYiv1KU=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-363-LZY8tlyWPPyqDnC4oEeK8Q-1; Thu, 07 Aug 2025 06:56:18 -0400
X-MC-Unique: LZY8tlyWPPyqDnC4oEeK8Q-1
X-Mimecast-MFC-AGG-ID: LZY8tlyWPPyqDnC4oEeK8Q_1754564178
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-31f4d0f60caso1010197a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Aug 2025 03:56:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754564177; x=1755168977;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5WHRKH5kbB05KZTBQnFvrLARtEFezmcNFMUZirfp/wU=;
        b=jdP5v0/9wHtfUdkI0Kv2b4OLSVI7QV+LRzm0nXgM1z9+lNXotsgAVSSGAiR6diZpJa
         LulZ08arVZmPHJ0snIQTVqKr99V7MobYplJaDALwYusl7xBe9qudq6CFfW2gt8bSrCek
         geCvIZzf0MZmHo9qhVh+KKCVC39o/yNsOK9KdQgNT+GE2U5JRsTtMlL43tAsoy8Wsj6A
         kVU3v4xxQrnW5goNvFoLBvFC1gH0rJWZ4WYg+YUb9VFGQ68rMh2SmZ5SiRMAWzjS7g5Q
         1s1/fVoLsrwUm24rWw2Z4ktPkhWGkXzE+5h2bhwUqfddPfPErpyY749grNI0oWzOiGCn
         Tc9g==
X-Forwarded-Encrypted: i=1; AJvYcCXxiuGWcRMFqyMPORVVrs+1c0m0saMSAn3/g+TH5FN9TfPjQoXaGfFycO9jcFP1d+MGWeXb0lrRCQGbEJY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdTO+ZuAUaURsUtKONQkWcm9CMdtb3S3HgSPH2desVoiHjPxm0
	0esA4isM4gr2smP8Zkbbk6lE0JRbgDjPPHYtOzWyusscJpXGj4hJoA1tSlURG4qR15rKKGhe5cc
	CSnRmRl0YppN0yfFdLm+bVtAzrUUtQqClIHh7Esaza3J4OtrgQ9x7V77z81PX59ghTIsxFVShvc
	jJEZYL31xVpWpJun0ukqmXHIfauOvpm1vDibamOYw7
X-Gm-Gg: ASbGncvx3SzuTFTZ8+gGlTUEhzhK+0OrQ9qdoyKyzd4oTsE0s1W8du293ay9W3yyN4M
	WNBKglVtgqEqtMSBLWxwkeUYxs/+2xcNxZU7ICmmWbTffS7133vRnFBpXtSOx8FrNBcifZKKscg
	YtwFFB92vd/+Ri2pmigKtm
X-Received: by 2002:a17:90b:1c10:b0:31f:4a91:4e94 with SMTP id 98e67ed59e1d1-32166ceff05mr7274984a91.30.1754564177544;
        Thu, 07 Aug 2025 03:56:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEnji28TKZYRSPeOPRIzeGS5YsdiPvxMHMQ8G/IxMSHDVyC2mWQCHBvrdd0u92IisFQ9KMRBNPftWmwbHSU0qY=
X-Received: by 2002:a17:90b:1c10:b0:31f:4a91:4e94 with SMTP id
 98e67ed59e1d1-32166ceff05mr7274942a91.30.1754564177031; Thu, 07 Aug 2025
 03:56:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250606115012.1331551-1-eperezma@redhat.com> <20250606115012.1331551-2-eperezma@redhat.com>
 <CACGkMEsw2taXgW11na2CFK6W03c=x=wMn3iwNZPypgPkeSU06Q@mail.gmail.com>
 <CACGkMEvinV7Zd+xddnxcerFbw_c+RZypkeD5HaN8=g6+peZvMQ@mail.gmail.com>
 <CAJaqyWeetDsdoDzVrN-n0+jr97MBPeHdTxeM3ttmNUeLK702VA@mail.gmail.com> <CACGkMEvbxZsmPPHgfst89FCbZamBPLt8V=K-eepa4s3muFuM4A@mail.gmail.com>
In-Reply-To: <CACGkMEvbxZsmPPHgfst89FCbZamBPLt8V=K-eepa4s3muFuM4A@mail.gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Thu, 7 Aug 2025 12:55:40 +0200
X-Gm-Features: Ac12FXyAp2Orw7ea3GlDIsGBdiXOoNFGa3EvjiOD9nnxscN9GpRPsdcRVCe1ktU
Message-ID: <CAJaqyWerLAL44w-mnwaohZh+duzHqPS3BO-sJDoEHZDN5RLY1g@mail.gmail.com>
Subject: Re: [RFC 1/6] vduse: add v1 API definition
To: Jason Wang <jasowang@redhat.com>
Cc: Yongji Xie <xieyongji@bytedance.com>, Cindy Lu <lulu@redhat.com>, 
	linux-kernel@vger.kernel.org, Stefano Garzarella <sgarzare@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, Maxime Coquelin <mcoqueli@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux.dev, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Laurent Vivier <lvivier@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 10, 2025 at 10:36=E2=80=AFAM Jason Wang <jasowang@redhat.com> w=
rote:
>
> On Mon, Jun 9, 2025 at 2:11=E2=80=AFPM Eugenio Perez Martin <eperezma@red=
hat.com> wrote:
> >
> > On Mon, Jun 9, 2025 at 3:50=E2=80=AFAM Jason Wang <jasowang@redhat.com>=
 wrote:
> > >
> > > On Mon, Jun 9, 2025 at 9:41=E2=80=AFAM Jason Wang <jasowang@redhat.co=
m> wrote:
> > > >
> > > > On Fri, Jun 6, 2025 at 7:50=E2=80=AFPM Eugenio P=C3=A9rez <eperezma=
@redhat.com> wrote:
> > > > >
> > > > > This allows to define all functions checking the API version set =
by the
> > > > > userland device.
> > > > >
> > > > > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > > >
> > > > It might be worth clarifying how it works.
> > > >
> > > > For example,
> > > >
> > > > 1) would VDUSE behave differently or if it's just some new ioctls
> >
> > I'd like to test more in-depth, but a device can just bump the version
> > ID and then implement the replies to the vduse messages. No need to
> > implement new ioctls. If the VDUSE device sets 0 in either number of
> > ASID or vq groups, the kernel assumes 1.
>
> Right, this is the way we use now and I think maybe we can document
> this somewhere.
>
> >
> > But you have a very good point here, I think it is wise to evaluate
> > the shortcut of these messages in the VDUSE kernel module. If a VDUSE
> > device only has one vq group and one ASID, it can always return group
> > 0 and asid 0 for everything, and fail every try to ser asid !=3D 0.
>
> Yes, and vhost-vDPA needs to guard against the misconfiguration.
>
> > This
> > way, the update is transparent for the VDUSE device, and future
> > devices do not need to implement the reply of these. What do you
> > think?
>
> This should work.
>
> >
> > > > 2) If VDUSE behave differently, do we need a ioctl to set the API
> > > > version for backward compatibility?
> > >
> > > Speak too fast, there's a VDUSE_SET_API_VERSION actually.
> > >
> > > I think we need to think if it complicates the migration compatibilit=
y or not.
> > >
> >
> > Do you mean migration as "increase the VDUSE version number", not "VM
> > live migration from vduse version 0 to vduse version 1", isn't it? The
> > second should not have any problem but I haven't tested it.
>
> I mean if we bump the version, we can't migrate from version 1 to
> version 0. Or we can offload this to the management (do we need to
> extend the vdpa tool for this)?
>

I just noticed I left this unreplied. But I still do not get what
migrate means here :).

If migrate means to run current VDUSE devices on kernel with this
series applied these devices don't set V1 API so they have one vq
group, and one asid. I'm actually testing this with my libfuse+VDUSE
modifications that don't use V1 at all. Adding this explanation to the
patch as it is a very good point indeed.

If it means to migrate a guest from using a V1 VDUSE device to a V0
device "it should work", as it is just a backend implementation
detail. If we migrate from or to a vdpa device backed by hardware, for
example, one of the devices does not even have the concept of VDUSE
API version.

In the case of net, it does not work at the moment because the only
way to set features like mq are through the shadow CVQ. If a VDUSE net
device implements, let's say, admin vq, something similar to PF and
VF, and dirty bitmap, I guess it should be possible. Maybe it is
easier to play with this wuth block devices.


