Return-Path: <linux-kernel+bounces-720389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1533BAFBB03
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 20:44:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91876189CAFB
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 18:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A872F265284;
	Mon,  7 Jul 2025 18:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KZcwQHs0"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F2B713959D
	for <linux-kernel@vger.kernel.org>; Mon,  7 Jul 2025 18:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751913875; cv=none; b=DcqVVObc8txT1bt/9de4f3Fp79XtWWqwlBC5t38PiarJgaBGJ/He+LIdB7ZUHjpGAnq2AolFEUu/BtSFdm0QXTCVUBdrmIq2p1YJfwitSAl0dweyLmcp+t/fXEOwyoh8NfDJ/xbu5knVtf4t277MCtD+CVF3nB3tnjqL7rYcrcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751913875; c=relaxed/simple;
	bh=32i6sL3k/7n514hoK30bj6EDsZGKMdCRy9vDMTynO+w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L6aMQt5tW9l0sbmpr7vY4oskV/ElqiTRWSYg0oihIztM38X23D/SNi/sEV2U15vDFPB47P7T0AsmU2RvujPwsYTuRHPUIt0aGmrSgBIbhZrROZ7RKmzVgkYGhR+jrQBy/hkMjukZPpI7PNJTWaVSPy983lYRjSZLbjVs05C4TyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KZcwQHs0; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-237f18108d2so33825ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jul 2025 11:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751913873; x=1752518673; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K6Lvj3nCTG7249j78tV/ADB9mPIRZ2rxd8wAayUkP1w=;
        b=KZcwQHs06mDyWXVQeNxYuLESlVxs4CDU4MeUD+nXCPNG8ood0ACenNWsxbYxqEPuO5
         pCzJy58t6bxXxia3QGHM3apOuqrx1nO+98JDdY3Bj+DpMEFnJjXZVgh9oLklGZLcMn2V
         SBsYIMyaoToKp3M24xaDAPIu2EWXEhemwHW0qJZNnRk68+LS5Dl/bJAJO11iiyWPJ2of
         wdn2hqhgSGl8Y8ndHbOYPeaIvFFRRQndSLTG3UlSrzAPaAdvctNyXx1DaGUdOXN8FXaE
         /i/0GHjzQ35vEKbeVyWNMhZd/BZY1Ba7HC7gkdnK6gwU9QxGVyfq3ICpMiX1w44kSjw0
         VlWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751913873; x=1752518673;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K6Lvj3nCTG7249j78tV/ADB9mPIRZ2rxd8wAayUkP1w=;
        b=cZ2ohkqJXLchiCgD5HVV6LmHzWGcMr3H02xUFC8NMBJOxOTP+3k1XSHK+h+N+KCYn8
         TXwOAesAw5SrIt/uEdxkC/lAsMKmhI5lziWYvGXKYyy5elFA8r3RYN7Rmd6HoQ97CJDV
         vSRuIh+A4I10UXERseEHPTY1wdxttygkA40XPLutKytN3OnI7tscQKtPg+kf7TM7RuaK
         sRwGl3WfKe3iNV9ri0PcNVdSx6coODt98j8zijtTdVuCafNyM0W88fHnWTgYfPlW/PXl
         t9iOwLj8kOXWu+zmet+z7FL3BPLGqcqiHekQYx6clC7j7dFMk+Z2Cg1Sgw3KVkyCS0LT
         +1gw==
X-Forwarded-Encrypted: i=1; AJvYcCWIRr0GgKHudWdft5MYY3Hs9TrjHN6jR1BRG1hgr3RpM+6Gc9g2Ichu9LRvOviAV5AzfAOPG/xgfn7u4Ak=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4bmGAUnNnjSF3JLyd1j64sv7B1rmCVVMasj0QGBnAlyIZHhSB
	YEJoWxOJ16tPVRfPW3sEWSn1OsZvwrfJe08JxTkEY6QlJGKv0RbiTHT3PBTPZwWGvRy8Q+7RsBR
	KoKChuvdULXlmGabd7ZAGVZlbfdY8ICpzfd1krxgV
X-Gm-Gg: ASbGncug9ov2D6tYe1WD2YA06kUCVdNdyRao+4F9LsKmkpSDZYLR9OaLjHuJSP8BUcG
	vuCbti99aP+VKgXRNegXC/FbzGiHbo4xaOxjVE1BOf3KVmAA0iVjh3S4vGKyJXT5Zwlxe96z1go
	pUr9jIFmhK7mT0OfD4nU2MrWnfNYWGeuNaGTWi7tgvudpgAgq7Bz6NJaVv55B0ld8AKQrUCVhOy
	A==
X-Google-Smtp-Source: AGHT+IE0tGwaA6D3IeEZZUqDhUheIQ389GY5jZhIJs/gD6HqNfIA4AeA6Ek54TDoRm2T5GpcZZVWVTYIC3i7IUlhDmg=
X-Received: by 2002:a17:902:f707:b0:235:e1fa:1fbc with SMTP id
 d9443c01a7336-23dd0ee20c1mr440915ad.0.1751913872656; Mon, 07 Jul 2025
 11:44:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250702172433.1738947-1-dtatulea@nvidia.com> <20250702172433.1738947-2-dtatulea@nvidia.com>
 <20250702113208.5adafe79@kernel.org> <c5pxc7ppuizhvgasy57llo2domksote5uvo54q65shch3sqmkm@bgcnojnxt4hh>
 <20250702135329.76dbd878@kernel.org> <CY8PR12MB7195361C14592016B8D2217DDC43A@CY8PR12MB7195.namprd12.prod.outlook.com>
 <22kf5wtxym5x3zllar7ek3onkav6nfzclf7w2lzifhebjme4jb@h4qycdqmwern>
In-Reply-To: <22kf5wtxym5x3zllar7ek3onkav6nfzclf7w2lzifhebjme4jb@h4qycdqmwern>
From: Mina Almasry <almasrymina@google.com>
Date: Mon, 7 Jul 2025 11:44:19 -0700
X-Gm-Features: Ac12FXw82IyNgu8OZzpM9U6ZsV8mDMv3r4jB-HKtgJZSMSlf1sY9fRc8lLDdPqo
Message-ID: <CAHS8izN-yJ1tm0uUvQxq327-bU1Vzj8JVc6bqns0CwNnWhc_XQ@mail.gmail.com>
Subject: Re: [RFC net-next 1/4] net: Allow non parent devices to be used for
 ZC DMA
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: Parav Pandit <parav@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, 
	"asml.silence@gmail.com" <asml.silence@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, 
	Tariq Toukan <tariqt@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 4, 2025 at 6:11=E2=80=AFAM Dragos Tatulea <dtatulea@nvidia.com>=
 wrote:
>
> On Thu, Jul 03, 2025 at 01:58:50PM +0200, Parav Pandit wrote:
> >
> > > From: Jakub Kicinski <kuba@kernel.org>
> > > Sent: 03 July 2025 02:23 AM
> > >
> [...]
> > > Maybe someone with closer understanding can chime in. If the kind of
> > > subfunctions you describe are expected, and there's a generic way of
> > > recognizing them -- automatically going to parent of parent would ind=
eed be
> > > cleaner and less error prone, as you suggest.
> >
> > I am not sure when the parent of parent assumption would fail, but can =
be
> > a good start.
> >
> > If netdev 8 bytes extension to store dma_dev is concern,
> > probably a netdev IFF_DMA_DEV_PARENT can be elegant to refer parent->pa=
rent?
> > So that there is no guess work in devmem layer.
> >
> > That said, my understanding of devmem is limited, so I could be mistake=
n here.
> >
> > In the long term, the devmem infrastructure likely needs to be
> > modernized to support queue-level DMA mapping.
> > This is useful because drivers like mlx5 already support
> > socket-direct netdev that span across two PCI devices.
> >
> > Currently, devmem is limited to a single PCI device per netdev.
> > While the buffer pool could be per device, the actual DMA
> > mapping might need to be deferred until buffer posting
> > time to support such multi-device scenarios.
> >
> > In an offline discussion, Dragos mentioned that io_uring already
> > operates at the queue level, may be some ideas can be picked up
> > from io_uring?
> The problem for devmem is that the device based API is already set in
> stone so not sure how we can change this. Maybe Mina can chime in.
>

I think what's being discussed here is pretty straight forward and
doesn't need UAPI changes, right? Or were you referring to another
API?

> To sum the conversation up, there are 2 imperfect and overlapping
> solutions:
>
> 1) For the common case of having a single PCI device per netdev, going on=
e
>    parent up if the parent device is not DMA capable would be a good
>    starting point.
>
> 2) For multi-PF netdev [0], a per-queue get_dma_dev() op would be ideal
>    as it provides the right PF device for the given queue.

Agreed these are the 2 options.

> io_uring
>    could use this but devmem can't. Devmem could use 1. but the
>    driver has to detect and block the multi PF case.
>

Why? AFAICT both io_uring and devmem are in the exact same boat right
now, and your patchset seems to show that? Both use dev->dev.parent as
the mapping device, and AFAIU you want to use dev->dev.parent.parent
or something like that?

Also AFAIU the driver won't need to block the multi PF case, it's
actually core that would need to handle that. For example, if devmem
wants to bind a dmabuf to 4 queues, but queues 0 & 1 use 1 dma device,
but queues 2 & 3 use another dma-device, then core doesn't know what
to do, because it can't map the dmabuf to both devices at once. The
restriction would be at bind time that all the queues being bound to
have the same dma device. Core would need to check that and return an
error if the devices diverge. I imagine all of this is the same for
io_uring, unless I'm missing something.

> I think we need both. Either that or a netdev op with an optional queue
> parameter. Any thoughts?
>

At the moment, from your description of the problem, I would lean to
going with Jakub's approach and handling the common case via #1. If
more use cases that require a very custom dma device to be passed we
can always move to #2 later, but FWIW I don't see a reason to come up
with a super future proof complicated solution right now, but I'm
happy to hear disagreements.

--=20
Thanks,
Mina

