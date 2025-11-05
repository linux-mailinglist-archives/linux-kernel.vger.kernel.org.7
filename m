Return-Path: <linux-kernel+bounces-887439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id F27EEC383DA
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 23:47:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4DD334F302C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 22:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 261102D3739;
	Wed,  5 Nov 2025 22:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I/qe8UaG"
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A430421E097
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 22:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762382818; cv=none; b=a1IlYc0XRCZAakcbq8p61fJ9RkaI4YbfkaWDOUOsTQ20Kv4ZbLadEzX1XTZGVp6gkCgB8aXSuUm0vZxdq1zf/pcVKw0qP9xTrhbN0ctjaa7Q4jLUfQYuPfNvbj5xnlMvg3G6iJpqDT0qCytwKztywC1LMgrRBlygldWJ1kUn93Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762382818; c=relaxed/simple;
	bh=5Gfu9GR0xsZW33aV8/cKDwjujn8UukY3ZxjDCK17Q6A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O1wLqegZtaiL+ef+yjzw3jhLSchWs6n6UjkBXfkD/zS0zCaBN76aUkp3i84InrMf6Knu9SjDqUsI94QXADhmlsrF6rX7720drxCB5RKswpoPnV9tF5UzdJ8CdwcK228osTfnmQArRch4tcj1TwwEBVu7suz+tp8PfRFwBUN7nA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I/qe8UaG; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4ea12242d2eso48381cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 14:46:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762382814; x=1762987614; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uSZmPHPCjL4HIwQCDjD4+gwb09nM6PqOT1PLdLeReo8=;
        b=I/qe8UaGpfG24aVnUpzsmFkyjkD7NV4IGYsfuOn78Xju/sD3RFQjOkEWAcbZ2gmrJ6
         6gpOff0qMiOWku9Sd8/8UigrvsUrxQi1BkRQXsTDiY+f7KFGeefMFf86NQ2Qskh8bSmq
         ZY979lwj0uuHu25aUtzFOLDrbtr2u6TG98ZPM/QD0z38APsRCNAW54EvVUEerDypooB1
         FlAGF8NtpT5Kegmta5KXWfqevXZVH8fd/rnMQij7nqyhhu9I6cZ+KSrYFlttyFOK7MnE
         H5tOWc1477u/sDRYMpQbJk/PW1uTmqsuVlS21qgFrqPR2hyGXLizPmINl1NWumfF7s9k
         tZEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762382814; x=1762987614;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uSZmPHPCjL4HIwQCDjD4+gwb09nM6PqOT1PLdLeReo8=;
        b=FbuDLuOSvXr6F7TGsN25DGL+ks1edzmLV+mxI0m65v7T/AdU8YOyGfWdNZJ+Fx7wqZ
         LdL39Zh47YDhHEMx1tRebHnlrDBqWPqPXP66HuoPXhZF4Jp0FL+XsJngvhKIYN/rn8w+
         k00Yd1ekbASRGednVfyWg9XFsWrH7z61BAgq0Hh+lHLU1l9bsZW9ApuASHcBW4IfPLSy
         Tq+Dvi7TGE99EP29qZf/0XYwwISUuyoaNg/5sYo6c2UR2YfM+wg9QhDkCte8SU6rab12
         ySL9/cs+/f/Jkf+KzEjO9/CnGLGNEQ/2+8WGJV936j7GRQjoqbsHsNYIg93PFMR4q2U4
         kjWQ==
X-Forwarded-Encrypted: i=1; AJvYcCXehVb0K36f3SRQEfXE/QCSKo9LWtldqFZo2M+9Z6QJ+ro/YeFTPit+B5UQtKUvuhPrSokIybWpoewhf10=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZN6IAzP11usKZKya4N82V5DXOkgyuxnJErrzK5zJjHwVCWR/p
	mlch6U0sUfGKO3BRpG8ub0IFogquMfhtWGct82JH7jQwWHBvoluQpUWfI8EQux3VYi/+vppVCJc
	gceLDiSZzl4r6wnWSEriy0t+kUj0cr7ssJrNhpZKt
X-Gm-Gg: ASbGnctcScQa7Vnn8jWhsDmaK1EvAR5yLIowALbJfBylSvvnivGdkNg0a/1plgRAV4o
	ZIq1kreYpubOk+F9FjB8aDmMRegTr/NEZeMdzz3LywJRRGepsqj+PMci4Z0qkpUhCFO3B4tKXOc
	nYcJzPYDZBptMUh9oWDqH/+0+yzisfRF04RU2ymlns065Tgly1tdA6Wuj9l7bAm/YA2I6KDMsmJ
	DWgMzmyRj9zs9UworboJULZm7JZ/t0mxk5UbRtZ6503f589pEGkVUUAoLa57/CU9WF2C9FGnW/1
	BQaodUF5b4+V4vk=
X-Google-Smtp-Source: AGHT+IEE4CZkViwd/+fts+RqjlWH09qXNoI9+aEUGkZQAvCFiSjVbSVpBD70fg6h8Od0V+BWOvjDgZgZLJz2wFAHdNc=
X-Received: by 2002:ac8:5acf:0:b0:4e4:6a1b:1148 with SMTP id
 d75a77b69052e-4ed8149b933mr2176631cf.6.1762382814250; Wed, 05 Nov 2025
 14:46:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251105200801.178381-1-almasrymina@google.com>
 <20251105200801.178381-2-almasrymina@google.com> <CAEAWyHc4zxC2wKjbO5C8TL6B8Exm6sYQTMxdOihh0PFjFMTkrg@mail.gmail.com>
In-Reply-To: <CAEAWyHc4zxC2wKjbO5C8TL6B8Exm6sYQTMxdOihh0PFjFMTkrg@mail.gmail.com>
From: Mina Almasry <almasrymina@google.com>
Date: Wed, 5 Nov 2025 14:46:40 -0800
X-Gm-Features: AWmQ_bnbkQ_3G2f2J0aAvN5KKDchs76YsvDTSLniYajUWdQ8u8tE7L_p-5iZbTs
Message-ID: <CAHS8izNTtQrRfMCpiK0tN2CadgD7v5pQk9vG9pHB-FkicXGbjw@mail.gmail.com>
Subject: Re: [PATCH net v1 2/2] gve: use max allowed ring size for ZC page_pools
To: Harshitha Ramamurthy <hramamurthy@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Joshua Washington <joshwash@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	Simon Horman <horms@kernel.org>, Willem de Bruijn <willemb@google.com>, ziweixiao@google.com, 
	Vedant Mathur <vedantmathur@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 5, 2025 at 2:15=E2=80=AFPM Harshitha Ramamurthy
<hramamurthy@google.com> wrote:
>
> On Wed, Nov 5, 2025 at 12:08=E2=80=AFPM Mina Almasry <almasrymina@google.=
com> wrote:
> >
> > NCCL workloads with NCCL_P2P_PXN_LEVEL=3D2 or 1 are very slow with the
> > current gve devmem tcp configuration.
> >
> > Root causing showed that this particular workload results in a very
> > bursty pattern of devmem allocations and frees, exhausting the page_poo=
l
> > ring buffer. This results in sock_devmem_dontneed taking up to 5ms to
> > free a batch of 128 netmems, as each free does not find an available
> > entry in the pp->ring, and going all the way down to the (slow) gen_poo=
l,
> > and gve_alloc_buffer running into a burst of successive allocations
> > which also don't find entries in the pp->ring (not dontneed'd yet,
> > presumably), each allocation taking up to 100us, slowing down the napi
> > poll loop.
> >
> > From there, the slowness of the napi poll loop results, I suspect,
> > in the rx buffers not being processed in time, and packet drops
> > detected by tcpdump. The total sum of all this badness results in this
> > workload running at around 0.5 GB/s, when expected perf is around 12
> > GB/s.
> >
> > This entire behavior can be avoided by increasing the pp->ring size to =
the
> > max allowed 16384. This makes the pp able to handle the bursty
> > alloc/frees of this particular workload. AFACT there should be no
> > negative side effect of arbitrarily increasing the pp->ring size in thi=
s
> > manner for ZC configs - the memory is prealloced and pinned by the
> > memory provider anyway.
> >
> > Tested by running AllToAll PXN=3D2 workload. Before:
> >
> > Avg bus bandwidth    : 0.434191
> >
> > After:
> >
> > Avg bus bandwidth    : 12.5494
> >
> > Note that there is more we can do to optimize this path, such as bulk
> > netmem dontneeds, bulk netmem pp refills, and possibly taking a page
> > from the iouring zcrx playbook and replacing the gen_pool with a simple=
r
> > fixed-size array based allocator, but this seems sufficient to fix thes=
e
> > critcal workloads.
> >
> > With thanks to Willem and Eric for helping root cause this,
> >
> > Cc: ziweixiao@google.com
> > Fixes: 62d7f40503bc ("gve: support unreadable netmem")
> > Reported-by: Vedant Mathur <vedantmathur@google.com>
> > Signed-off-by: Mina Almasry <almasrymina@google.com>
> > ---
> >  drivers/net/ethernet/google/gve/gve_buffer_mgmt_dqo.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/drivers/net/ethernet/google/gve/gve_buffer_mgmt_dqo.c b/dr=
ivers/net/ethernet/google/gve/gve_buffer_mgmt_dqo.c
> > index 0e2b703c673a..f63ffdd3b3ba 100644
> > --- a/drivers/net/ethernet/google/gve/gve_buffer_mgmt_dqo.c
> > +++ b/drivers/net/ethernet/google/gve/gve_buffer_mgmt_dqo.c
> > @@ -8,6 +8,8 @@
> >  #include "gve.h"
> >  #include "gve_utils.h"
> >
> > +#include "net/netdev_queues.h"
> > +
> >  int gve_buf_ref_cnt(struct gve_rx_buf_state_dqo *bs)
> >  {
> >         return page_count(bs->page_info.page) - bs->page_info.pagecnt_b=
ias;
> > @@ -263,6 +265,8 @@ struct page_pool *gve_rx_create_page_pool(struct gv=
e_priv *priv,
> >         if (priv->header_split_enabled) {
> >                 pp.flags |=3D PP_FLAG_ALLOW_UNREADABLE_NETMEM;
> >                 pp.queue_idx =3D rx->q_num;
> > +               if  (netif_rxq_has_unreadable_mp(priv->dev, rx->q_num))
> > +                       pp.pool_size =3D PAGE_POOL_MAX_RING_SIZE;
> >         }
>
> Would it make sense to also wrap setting of the
> PP_FLAG_ALLOW_UNREADABLE_NETMEM under the
> netif_rxq_has_unreadable_mp() helper?

Eh, maybe. PP_FLAG_ALLOW_UNREADABLE_NETMEM is supposed to say 'the
driver supports unreadable netmem, core can enable unreadable netmem
if it wants'. The hope was that the driver would never need to
understand whether it's actually configured for readable or
unreadable.

But then we found that for reasons like this, the driver sometimes
wants to know if it's about to be configured for unreadable, hence
netif_rxq_has_unreadable_mp was added.

I would say this bit is correct as written, but let me know if you disagree=
.

--=20
Thanks,
Mina

