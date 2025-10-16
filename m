Return-Path: <linux-kernel+bounces-855590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D790ABE1B71
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 08:26:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92C8E40192D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 06:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10CC72D3EDC;
	Thu, 16 Oct 2025 06:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="St6SA3Nz"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B6622D3A7B
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 06:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760595973; cv=none; b=tVpvvLgkQ1zy5gQCwTALBGiCxNsrrzixjt/nzbTJMo8legQDvyOfbUxszEjYgZ+cf8VJVHkQDEiSunkr0Us+JG59pU+L0Dqr2rKOBpSWqZnZrPR6RdSTxU8nqbQTxCzgzZNUG2V9LbQmSbIQ4ts3h2ST1KniDP812eGxpYk3BH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760595973; c=relaxed/simple;
	bh=tBqeuunpv84uc8GThElbM0HDnAKxIfwceg7sAyWNTkg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hcjCgmbizDV2eeQph67ZSdCSUkvnFmuZDCVEhBSlsMxC5KE4kNnCKB+GPPt04r+DJtN7rpwv470Cf9730/a3BUdasOyUMf9nE8gKKdJan5VjNdHIFS9ezD0369QEA6LAyOxr0p7m1zBticpKwr0szB1E9WbgIcE3FQnKgq/Q8Fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=St6SA3Nz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760595970;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rVdo2zgwDSl/oM36KlT5XNFPETliwAnYnfpD1yjprKs=;
	b=St6SA3NzVuN8FU3uuxmMzGFJLZKcJjDtgufIHFGTUpetmTysGBtuup4gSQfjzNZud/Zic2
	SIeaU4/oUD/vAmyQQSFGMXwJCpR1C9wjfw8wiKWrhfY2s8329HSu59Zsyk7RMGbhZR6tma
	xbE1trsOmVhB3YAln/eSnoAlb1dvZ4U=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-u9s6dEj9NSeUMh3O7izIYw-1; Thu, 16 Oct 2025 02:26:09 -0400
X-MC-Unique: u9s6dEj9NSeUMh3O7izIYw-1
X-Mimecast-MFC-AGG-ID: u9s6dEj9NSeUMh3O7izIYw_1760595968
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-77fa2ee9cb6so5750167b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 23:26:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760595968; x=1761200768;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rVdo2zgwDSl/oM36KlT5XNFPETliwAnYnfpD1yjprKs=;
        b=a62NllmTfz1tYvJD3hNEQxpdTcxNXVIVxhNt2IzhyaEo4jrptQ46QSyfJW+LUebx/m
         WQpLgGmvUOPCnYRKmTIbcTug2Y/XfK89DiXIkN+U6Iajd9BCZu/9xIc9kdFU6lv2DFey
         2LsjivbpzPPuMMGuiVpxwLmHo5WLgDv7m8/ghlt1U+M6Lyn8Xs/MCzC0xplcAqZcNhFG
         bGUGs1WdVVV+kRDL+oWQ4PjTDZWOuUXahVmGz7cnOSj98/bsYbLVj4vZ9SL2E5AbMupj
         z4/thhGCfDlIODvcuXZdDDylP4tDYX13/lPv5DaPhkFE5BwqWpp5Hd0Kd2IRMSdONXtr
         iMNw==
X-Forwarded-Encrypted: i=1; AJvYcCW6c/DxSYp1Zx+pH6+2gX3Peg+2Dn1TegJ5THKQnwFBCxH8+UAjYrqO8qzOrJ2f4NKl1FX0sA0Jkxy/JzI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+irrM0e98fHtYbhaCx+s9Y1oXWHaL09I2l6xG9wJdY7Lh+1gR
	l81WdJz8KB6cYdgn9dN3umsZBhZV0XB0zgg49tFnt7RgBvz473l2QXAdjbWxW0+OIQhXxRwWct8
	kZb/cCd0buVk7tpSpnApCM87LBOM8qGK+lRHCb43RftnPpHEtOxW/ZHJnR2sHl5dAbC34gbZanv
	WctRP1h9GdLTDChapBBMHX/LN3r7tXirnRvOitP+D1
X-Gm-Gg: ASbGncs6mI++pIz01F5yj8///rHf2bDd/v5p9vZOanYlNUul3AYwbi6AdiLk7qdGEOH
	8a50V3ncP3X6bXzb8Ix9l7cjpxDs9V5Fh6v/3jOatENvkOmjOJsKQ6LZ1naLwN8YqsXR00jlL3+
	oYBY/mUtnYbNBZEhLCfCRqS5kWifk6iw7gPKTi34fcKSsaGHik2i09/JAKmDfdfPwLI7zz0e5gc
	9oxKjcYTVcYvGowyemvGtiIQp1bRfx5Mo93csbylWw=
X-Received: by 2002:a05:690c:6c01:b0:737:523a:f7fe with SMTP id 00721157ae682-780e16d5df4mr512147707b3.39.1760595968366;
        Wed, 15 Oct 2025 23:26:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IER2Eg9LZlod/14LY7qz9zEQBt8M239Y70sk1hqZh80LpdNcsYsRxbbCv2GZVkAJvkmUqEJkzVY8fAYBXKrjck=
X-Received: by 2002:a05:690c:6c01:b0:737:523a:f7fe with SMTP id
 00721157ae682-780e16d5df4mr512147467b3.39.1760595968039; Wed, 15 Oct 2025
 23:26:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251015023020-mutt-send-email-mst@kernel.org>
 <CAJaqyWeiX1Tc77NcYoBbeVfKTeuKHK6hw=n_9Mk4y52k7Djr-g@mail.gmail.com>
 <20251015030313-mutt-send-email-mst@kernel.org> <CAJaqyWfRmhXM8eV+=wMVKgrc8SJ98OTtBCtNDJj8ZRUM5Y9Nmg@mail.gmail.com>
 <CAO55csx2rbjxEZk5K3aKcZ501KY3Zfs8ThEQHFqQ1ZB9RSXECA@mail.gmail.com>
 <20251015040722-mutt-send-email-mst@kernel.org> <CAJaqyWcf3tz17q6G=123Xb+warf8Ckg=PLaPkzLU9hYHiUy9Zg@mail.gmail.com>
 <CACGkMEuPPFLH1YqTx03fV9N=Rx3aYXK0HMUDpZu-CvO1NYRRQA@mail.gmail.com>
 <20251016014328-mutt-send-email-mst@kernel.org> <CACGkMEtXWLicmszjkzOhX8Ta=LdGgsDahRUKDEVzBVG8am5vgg@mail.gmail.com>
 <20251016022131-mutt-send-email-mst@kernel.org>
In-Reply-To: <20251016022131-mutt-send-email-mst@kernel.org>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Thu, 16 Oct 2025 08:25:31 +0200
X-Gm-Features: AS18NWDpoxxEeX_RbTSotXQqwNmYlmaB24Mg7SGk1YWLyaDDf6vzF8g0cVP2pFk
Message-ID: <CAJaqyWe--Hho9EdweqkC-h9=t5vhY0cbAN9uAw=hATpkSMbsEg@mail.gmail.com>
Subject: Re: [RFC 1/2] virtio_net: timeout control virtqueue commands
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, Maxime Coquelin <mcoqueli@redhat.com>, 
	Yongji Xie <xieyongji@bytedance.com>, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Dragos Tatulea DE <dtatulea@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 16, 2025 at 8:22=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Thu, Oct 16, 2025 at 02:03:57PM +0800, Jason Wang wrote:
> > On Thu, Oct 16, 2025 at 1:45=E2=80=AFPM Michael S. Tsirkin <mst@redhat.=
com> wrote:
> > >
> > > On Thu, Oct 16, 2025 at 01:39:58PM +0800, Jason Wang wrote:
> > > > > >
> > > > > > Not exactly bufferize, record.  E.g. we do not need to send
> > > > > > 100 messages to enable/disable promisc mode - together they
> > > > > > have no effect.
> > > >
> > > > Note that there's a case that multiple commands need to be sent, e.=
g
> > > > set rx mode. And assuming not all the commands are the best effort,
> > > > kernel VDUSE still needs to wait for the usersapce at least for a
> > > > while.
> > >
> > > Not wait, record. Generate 1st command, after userspace consumed it -
> > > generate and send second command and so on.
> >
> > Right, that's what I asked in another thread, we still need a timeout
> > here.
>
> we do not need a timeout.
>
> > Then I think it would not be too much difference whether it is
> > VDUSE or CVQ that will fail or break the device. Conceptually, VDUSE
> > can only advertise NEEDS_RESET since it's a device implementation.
> > VDUSE can not simply break the device as it requires synchronization
> > which is not easy.
> >
> > > But for each bit of data, at most one command has to be sent,
> > > we do not care if guest tweaked rx mode 3 times, we only care about
> > > the latest state.
> >
> > Yes, but I want to know what's best when VDUSE meets userspace timeout.
> >
> > Thanks
>
>
> userspace should manage its own timeouts.
>

Can we just apply the patch 2/2 of this RFC directly and apply the
VDUSE CVQ on top then? What are we missing to do it?

On Thu, Oct 16, 2025 at 8:22=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Thu, Oct 16, 2025 at 02:03:57PM +0800, Jason Wang wrote:
> > On Thu, Oct 16, 2025 at 1:45=E2=80=AFPM Michael S. Tsirkin <mst@redhat.=
com> wrote:
> > >
> > > On Thu, Oct 16, 2025 at 01:39:58PM +0800, Jason Wang wrote:
> > > > > >
> > > > > > Not exactly bufferize, record.  E.g. we do not need to send
> > > > > > 100 messages to enable/disable promisc mode - together they
> > > > > > have no effect.
> > > >
> > > > Note that there's a case that multiple commands need to be sent, e.=
g
> > > > set rx mode. And assuming not all the commands are the best effort,
> > > > kernel VDUSE still needs to wait for the usersapce at least for a
> > > > while.
> > >
> > > Not wait, record. Generate 1st command, after userspace consumed it -
> > > generate and send second command and so on.
> >
> > Right, that's what I asked in another thread, we still need a timeout
> > here.
>
> we do not need a timeout.
>
> > Then I think it would not be too much difference whether it is
> > VDUSE or CVQ that will fail or break the device. Conceptually, VDUSE
> > can only advertise NEEDS_RESET since it's a device implementation.
> > VDUSE can not simply break the device as it requires synchronization
> > which is not easy.
> >
> > > But for each bit of data, at most one command has to be sent,
> > > we do not care if guest tweaked rx mode 3 times, we only care about
> > > the latest state.
> >
> > Yes, but I want to know what's best when VDUSE meets userspace timeout.
> >
> > Thanks
>
>
> userspace should manage its own timeouts.
>
> > >
> > > --
> > > MST
> > >
>


