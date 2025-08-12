Return-Path: <linux-kernel+bounces-763886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77B2FB21B37
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 05:03:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BA9016B951
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 03:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B1FD2E4245;
	Tue, 12 Aug 2025 03:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JdDbeqeX"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5772E0B6D
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 03:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754967753; cv=none; b=L7R1SEV2PE4mGnfk6vGurPpehrW7fCXM68H03C4F/nddXaHOVNGL/5Ca9/fsmWN0aoul4niMuVJFIUpTD0ffc9CE6EnGlbi1vKxuZaRv/Gwj6/DByU4jzaCxaWc9F/UxKyVkHv79H0Or33Mc3Xf0cQcKupt2p8K8gxXOyBleCpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754967753; c=relaxed/simple;
	bh=ioZp9GwhYq3DOLcNu3g4TvlRC4KH8eaX1JYYcMUAeto=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M4+XChEiienv8CKYWC3jLE/vSt9u3d9uDF1HpjEy1jSilK4hutEcIvtorLx3e23h6R9ImV5JoxFsyQq0TH+Y/XCBnaFYaF730Tm2dpqcX2ghiZkPoalafEt+lKrE6FsHA+gL+MWNJUra88eLhCoysC7yuNJv4pMkq8ARinEXOiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JdDbeqeX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754967751;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bvrOcstLTid8vKk7e+6Q+Q4vFiqhAtxVL8U0N+GhLdg=;
	b=JdDbeqeXATtnEcN53MGXm+MTiFo7rXZC3WnF3akq3RsrLjrIFiNgvca99ilKaKj9wQgf7/
	u8Dc/hb+hRLX1KorSaHOLqVMjhleKTAZthjldXsiBhyWecqoTU1O90WpYbkrXurRMuzEMl
	+ytL4I/A03FxzviQI9smpVI4tF4kkZI=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-PKhiZYtnNEOT1gcSRoWQDg-1; Mon, 11 Aug 2025 23:02:29 -0400
X-MC-Unique: PKhiZYtnNEOT1gcSRoWQDg-1
X-Mimecast-MFC-AGG-ID: PKhiZYtnNEOT1gcSRoWQDg_1754967749
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-31f74a64da9so5478527a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 20:02:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754967749; x=1755572549;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bvrOcstLTid8vKk7e+6Q+Q4vFiqhAtxVL8U0N+GhLdg=;
        b=eYTkpXcfrpoE7jTjOoY8lwEDPSuaid7171NGWjqpP5w16SdtY8rq3jVowYWnnFIde1
         hUpuBg1VRnKt1tQzIHONFL8mLRQVg3TIXIu5qK1D3Nbe9FAQc2K8yuX9vS1Gyzc4Orrj
         lgSJdBUrD9xaf7Y2YscYapwkBJuU1VUKO0KWdDX1NPrLTKK2NJ3nb4vJKKHfqfRu+FXI
         Mz6J/sTiTHQGAgNkMU7JxXY+Si4k6oIv2Xv8s61JaZ4xKdawPmnjVubff0ZlTjV0zGoL
         X4OAYwb9lEcKHEyqIpn85a++mW6w4C++WlX+KtFPGWnZQuzxyUXkoKivQBY6rJCCl6BZ
         ymfA==
X-Forwarded-Encrypted: i=1; AJvYcCVtvxdRyBLUw6d/Ud5KCp5Uo5YF7EVXvxJB5v9onOkeXOSuqKtcoXzXHNRgn7HL6Aal35Uo9hqrViNSNwQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxy5KKmm0koWcCzzJa29JvUQBi7u25d69byLQsERJ3Vu3j6R59e
	UkznebNkGX2qOFy7+6dvQuojumTdxGQdY6BorlWdMMFDObK/Qs+l31LvZBipKAxVJPhw5EZ8qYw
	vqOFLHIj2Ivp4qFG3288GqpMQJk7IK9AgD9mKGeEFmXC8cb20a/DGzeOb9gu/R3uxcY7cPBXvzg
	+FITqwCGmqvbNtffxZ+CON1K79U0K9Ihpa3VgwZDAm
X-Gm-Gg: ASbGnctMuFZElpjXa5npwa+3oKlt2LZdoCNc5KRIbitCP8n45OYh8qsJpMqqrMzgVqm
	A5r41CHaBL/tC6xOPLv8eVhYeVGwsQCzSvYPbkch3NOQzUStLX8QCFAqexXECttbq6e50Btx4hP
	R/L1jgklNe40k4wytUxfWSCjs=
X-Received: by 2002:a17:90b:58cd:b0:312:e8ed:758 with SMTP id 98e67ed59e1d1-321c0a52c02mr2393325a91.13.1754967748568;
        Mon, 11 Aug 2025 20:02:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IExmyC1v+o3+EX+7wPrTBSi1UurHHwYyuQx49y6mXs8rpoVylUDhQeJ16Iggq7jiFnxBbGtnT04jO3+mxUeT2E=
X-Received: by 2002:a17:90b:58cd:b0:312:e8ed:758 with SMTP id
 98e67ed59e1d1-321c0a52c02mr2393277a91.13.1754967747878; Mon, 11 Aug 2025
 20:02:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250807115752.1663383-1-eperezma@redhat.com> <20250807115752.1663383-5-eperezma@redhat.com>
 <CACGkMEurTUOb6t9g+nVdzwU8LrZ=eAAxzHYVCTH1XkQkRtAUXQ@mail.gmail.com> <CAJaqyWfh_3_J3+rq_7pa0YMUQSQHfeHn7Tvurz=PAmWoqV5vNg@mail.gmail.com>
In-Reply-To: <CAJaqyWfh_3_J3+rq_7pa0YMUQSQHfeHn7Tvurz=PAmWoqV5vNg@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 12 Aug 2025 11:02:16 +0800
X-Gm-Features: Ac12FXwZqnO6d7oHIYNzKyQAmB2XYu0MI_aY6JIP8N8FOq5205LaGyJbsvfLzJc
Message-ID: <CACGkMEv+-zbtPYsRam_8XB1hLCB-Gh5xaRLxpF_gLWZNnG2OEg@mail.gmail.com>
Subject: Re: [RFC v2 4/7] vduse: return internal vq group struct as map token
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Cindy Lu <lulu@redhat.com>, 
	Yongji Xie <xieyongji@bytedance.com>, Stefano Garzarella <sgarzare@redhat.com>, 
	virtualization@lists.linux.dev, Laurent Vivier <lvivier@redhat.com>, 
	linux-kernel@vger.kernel.org, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Maxime Coquelin <mcoqueli@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 11, 2025 at 7:04=E2=80=AFPM Eugenio Perez Martin
<eperezma@redhat.com> wrote:
>
> On Mon, Aug 11, 2025 at 5:11=E2=80=AFAM Jason Wang <jasowang@redhat.com> =
wrote:
> >
> > On Thu, Aug 7, 2025 at 7:58=E2=80=AFPM Eugenio P=C3=A9rez <eperezma@red=
hat.com> wrote:
> > >
> > > Return the internal struct that represents the vq group as virtqueue =
map
> > > token, instead of the device.
> >
> > Note that Michael prefers to use the iova domain. This indeed seems to
> > be better.
> >
>
> Well iova domain would delete an indirection in the pointer chase, but
> it would be problematic to store the token in the caller.
>
> And we need to add some way to protect that the ASID of a vq group is
> not changed in the middle of the operation by an ioctl. IOW, the
> vq_group_internal struct pointer is constant for all the lifetime of
> the device, while iova_domain is not.

I will post a new version of DMA rework and switch to using the iova
domain there. Let's see if it works then.

>
> > > This allows the DMA functions to access
> >
> > s/DMA/map/
> >
>
> Ouch, thanks for the catch!
>
> > > the information per group.
> > >
> > > At this moment all the virtqueues share the same vq group, that only
> > > can point to ASID 0.  This change prepares the infrastructure for act=
ual
> > > per-group address space handling
> > >
> > > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> >
> > Thanks
> >
>

Thanks


