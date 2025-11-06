Return-Path: <linux-kernel+bounces-887711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 45C74C38ED4
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 03:57:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5E14B4F2E2A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 02:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FC70233735;
	Thu,  6 Nov 2025 02:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="syueqX9j"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F4F18EB0
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 02:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762397822; cv=none; b=DatojyNqS1vKcst19ix2yTzY4bqRXJGJq92BusKoExtANZ+/nY8Gf5pPOfOjCcfTPMbDDfqM7ex7slDngQsTwWdmy57MqR7kVaN5chriPn8fA+KTdvp7kA5xvjlAfsS/EL+dWRTTJWe6TLzYJ86fq8qDScHOzvxqNSvoYNB3yPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762397822; c=relaxed/simple;
	bh=KO0HgacN+wrz+fcQ05+6ChuZEjppxP+jsu1mXG+XNFo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tcXSLaATk3RD81PFiF/2qPhIocw4sZ8sHoV/y8LIa6FYNStiBjpDKLv7Ybeu/mSq/4wZ2YQoDQHVmd4Q+N90hEMUXJmQG3ztBL6vXbPVGtbyeu2yK+9Moe03OlrT9Zv1pr4XxVJbAYZT8yQ3q+PAGnu9LNr7bOhfuoYjUsB1nhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=syueqX9j; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-58b027beea6so2317e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 18:57:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762397819; x=1763002619; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RrosdiVf/Gz+H710qexMyPsQSNuuRWVYFgyQNahREeM=;
        b=syueqX9jg5+bQkO575UINH0yhASlWlo6uWnml6DtRqLt2CeAIsWB43wjXGTkAGMA4C
         zAW7WjqfJcPGoxrGIlbUDV/C16WxcW599vAa6TeLyCPzmjv6QKlnyu7QuSgYpYDW/QSB
         OR5uK4w0dY9VDPKWA+jhp9xo0NR7EOH86LbUZzsKfg62kvpHTzX3YhYC5aWgStsnBrtA
         ZxIIA0xavjhgpRbBFOaAjMB58+82rlEFrL/hUvV1SkaVj5pie1yqAfyPpaCcmJvxQUXl
         5zVWBI0xVs8hjUXE2qkk4fNTLLmkl0utlGfPuwWT3GvibonPfYfQbEWozLChio3k+rkf
         psBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762397819; x=1763002619;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RrosdiVf/Gz+H710qexMyPsQSNuuRWVYFgyQNahREeM=;
        b=tb2S/biwxjTOL7SBr98pLKs2KoW1FmWE8qgR440LUykUjMqdHwtShO69gxj9VJ9mw0
         DRnm3EQ75KgwmvM7hhnljdGFjH0su9QamJEic2jz3YU8p9X3FVsas+JScPbzNXSG4h7D
         +aS1e1ty6leoi22AsVOwHVqlIYdYqknPAYsdqFFzYZaZnvj+nQrvW0RyebowiXVp3Ydd
         vBdyutJ2AEhpz82AFk9j91R2hTrhtY2+oAJShYj0nXGxhsxVU6NG78ZnRk/fmDNJWnUa
         B+f8OHK+1gDzTIyo1WcRTZhpn1LQpNbVVIFJ8G0Am7PtW9ss1cy+9rSDOJ8KPqdtb7H7
         FCsQ==
X-Forwarded-Encrypted: i=1; AJvYcCWWUNfiM4YXCcAWMTd34n5RQeJHqmrOn3a9VU6RXSVGWFOg1hH/2hlwjuHwNLVnlrdVdom6o0HSv49vfMg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUSKOjbXMX8pbeN7lPHPAoirTdGR6pAWIUSi+x6CqXBb8xryRC
	9GfgOmD55SR6mKvfhCadGTgkCJ1yJD0OT74T9kpD5C4YvIVl9WLhp9AfYg3+teIofDioWmGQbha
	F7A2kP+ax3fnaep3U0bH2tc1kqhghcQ47rBl7aP50
X-Gm-Gg: ASbGncuHbGH7N6nLUKX9ixWz6+eL+6+uB2tIA4jJhXyWYJRC2U6xLEFdjpfV7AM/ADj
	pX+B01Kjlzz4Eb5docw926fgnE7UYB3gWPUIkScAlzR94LRyynwfKvcBy89qp0UiZPDGC9yWGqo
	05XAflpCAVHo0CxERGDKr6/P3BcEnC2fXywzq9cjISjBmHK2bdxClclTZyVa6O843HZDIf0Rf4X
	7r3x1QLJFid8oqN8cMQxkymKv0uxG6+jbIIxH7pN8W4WP49+6ViwUjkxCh6UE6Q3tL4G7c=
X-Google-Smtp-Source: AGHT+IFr/UGg5sBN9bVdMzHc8NnT+HD6hpWKoyRn41p3xvts5bvpnTlNiGZ55tFzBm2vf10TY9Z5X0KwQqcwCDMEgnA=
X-Received: by 2002:ac2:5f58:0:b0:594:33c3:e724 with SMTP id
 2adb3069b0e04-5944c848b73mr77501e87.5.1762397818874; Wed, 05 Nov 2025
 18:56:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251105200801.178381-1-almasrymina@google.com>
 <20251105200801.178381-2-almasrymina@google.com> <20251105171142.13095017@kernel.org>
 <CAHS8izNg63A9W5GkGVgy0_v1U6_rPgCj1zu2_5QnUKcR9eTGFg@mail.gmail.com> <20251105182210.7630c19e@kernel.org>
In-Reply-To: <20251105182210.7630c19e@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Wed, 5 Nov 2025 18:56:46 -0800
X-Gm-Features: AWmQ_bmIDWMz3eePaZmq1cVMbHZCO4uFMn3om9Yopbzoff0vbmiyvxl0GNzxoMk
Message-ID: <CAHS8izP0y1t4LU3nBj4h=3zw126dMtMNHUiXASuqDNyVuyhFYQ@mail.gmail.com>
Subject: Re: [PATCH net v1 2/2] gve: use max allowed ring size for ZC page_pools
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Joshua Washington <joshwash@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	Simon Horman <horms@kernel.org>, Willem de Bruijn <willemb@google.com>, ziweixiao@google.com, 
	Vedant Mathur <vedantmathur@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 5, 2025 at 6:22=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Wed, 5 Nov 2025 17:56:10 -0800 Mina Almasry wrote:
> > On Wed, Nov 5, 2025 at 5:11=E2=80=AFPM Jakub Kicinski <kuba@kernel.org>=
 wrote:
> > > On Wed,  5 Nov 2025 20:07:58 +0000 Mina Almasry wrote:
> > > > NCCL workloads with NCCL_P2P_PXN_LEVEL=3D2 or 1 are very slow with =
the
> > > > current gve devmem tcp configuration.
> > >
> > > Hardcoding the ring size because some other attribute makes you think
> > > that a specific application is running is rather unclean IMO..
> >
> > I did not see it this way tbh. I am thinking for devmem tcp to be as
> > robust as possible to the burstiness of frag frees, we need a bit of a
> > generous ring size. The specific application I'm referring to is just
> > an example of how this could happen.
> >
> > I was thinking maybe binding->dma_buf->size / net_iov_size (so that
> > the ring is large enough to hold every single netmem if need be) would
> > be the upper bound, but in practice increasing to the current max
> > allowed was good enough, so I'm trying that.
>
> Increasing cache sizes to the max seems very hacky at best.
> The underlying implementation uses genpool and doesn't even
> bother to do batching.
>

OK, my bad. I tried to think through downsides of arbitrarily
increasing the ring size in a ZC scenario where the underlying memory
is pre-pinned and allocated anyway, and I couldn't think of any, but I
won't argue the point any further.

> > > Do you want me to respin the per-ring config series? Or you can take =
it over.
> > > IDK where the buffer size config is after recent discussion but IIUC
> > > it will not drag in my config infra so it shouldn't conflict.
> >
> > You mean this one? "[RFC net-next 00/22] net: per-queue rx-buf-len
> > configuration"
> >
> > I don't see the connection between rx-buf-len and the ring size,
> > unless you're thinking about some netlink-configurable way to
> > configure the pp->ring size?
>
> The latter. We usually have the opposite problem - drivers configure
> the cache way too large for any practical production needs and waste
> memory.
>

Sounds good, does this sound like roughly what we're looking for here?
I'm thinking configuring pp->ring size could be simpler than
rx-buf-len because it's really all used by core, so maybe not
something we need to bubble all the way down to the driver, so
something like:

- We add a new field, netdev_rx_queue[->mp_params?]->pp_ring_size.
- We add a netlink api to configure the above.
- When a pp is being created, we check
netdev_rx_queue[->mp_params]->pp_ring_size, if it's set, then it
overrides the driver-provided value.

Does that make sense? I don't immediately see why the driver needs to
be told the pp_ring_size via the queue API, as it's really needed by
the pp anyway, no? Or am I missing something?

--=20
Thanks,
Mina

