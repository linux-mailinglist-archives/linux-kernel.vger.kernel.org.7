Return-Path: <linux-kernel+bounces-887409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA1F2C3827D
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 23:15:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE21B18C7EA7
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 22:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 654502F0C6D;
	Wed,  5 Nov 2025 22:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jLavHGc9"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26EB51A2392
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 22:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762380938; cv=none; b=U59PVSEbGVQLVkzl9B9JL/G7PQY8UJJFBqm5B9qTWzDhJ7X17zO1nN/uTmsduCjYvwUxBVLm6qNR8L9cDam4kBa+uwaeLMJncmDXkLgCsyl+Ixcif59sn2fqj92mpEgxk3w6ruxI4bQO+bKZf6jhiLjqkKlSy2YYczQ9f9LqZqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762380938; c=relaxed/simple;
	bh=OdLOMgZW2KFI0N/w5SzMnELwpkeuWZuR5Xrnqu6OWos=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pv0ru5+4CSBtcWtcEMqVabBtiK0dUJpvpIdCdlCc9eBzQeqF46seEwwqmPEV5I+TaRErHN4h3hi8mOT0vVuNGqLDWFHuzuwQEiFujG53mLaGFJ97Ns1UsZdByBQufglC3cJm4CdZk4lenhiIVIUotqh10AJVV/HO+e0W/SwZXvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jLavHGc9; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-27d67abd215so49585ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 14:15:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762380936; x=1762985736; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i3lvSuLZZH1/RCKxfhUKoqbWv/FK7QWkV+OjY9CUFeE=;
        b=jLavHGc9AmMCnGBjpx4oxnqWBbwpHgQ9cFmM/FluprsBdi07PJF7uFwu8vBXcYODPX
         xwikDsH6USs7ZeRDbgRKLGegRXkiqV+haqj+zymAheZzeoh2A3KAmg7DsFrHk3/NuENO
         /alYfv/lFORi/aiWMUVkHZdoscvn05PLn55A4BG0oZOg3g4e0sd83sF1Wn47gLaRabwA
         ZhgcXFDWD9bLqER5aEZpG6D2EVBzSGVVuXaXL09C16+WbyeztA5IlfX0kJ0YxCre5gCK
         CbTry+6vDPYF2I9rDyGJV8A9X7NPXIKSscs5slg+04VARM38l6Dh3wTWR016I+r3stgA
         3Hjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762380936; x=1762985736;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=i3lvSuLZZH1/RCKxfhUKoqbWv/FK7QWkV+OjY9CUFeE=;
        b=hPjUPygqldTtU2jSFv4e8HX0HcYwxF9ViXtOF9rPsYzLhRKOq1qVumfUSxkmrfSw4T
         ns7/h9ncrWJTWXclxqYr/vXafBP61oUeDAG8UL2fGNVIdFkShnlV2C7HaytEFzZJSiK8
         Gp8JglqWESJNj22IwbvJBnnGqvz+0yn9MWsf1gBsVWe/3jZVanv+9SeZp/qAgJfGUcMq
         vZUEsgCiL0Sm65HOFA60jkPZV6Q08rvWuI55LbnCHHQYK/QYCDfu1hEeGWWRIwkhGu1p
         pc6GviUew3iM2jZ7UPci6M+tSchUkMVMyFRBFF1/EnyFZ2SzGafWqjzFtPtEr+r0PaIv
         7ZtA==
X-Forwarded-Encrypted: i=1; AJvYcCUqWo9zCFhrnyVeWcPPoc2we5bYLXPF0cGO+s1Qh0s58ze5MztBwadpDRFUaCcPyhoEzYap1jA2FatI76E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcnfI21lb5fc3mo6A4RjUMajelZrknlq18GmyaWGSmVS9BhYbk
	WXBWtmh0ejOtvNXrU3ol0my7qa4eIN833M2zAuW6noqgGN+gbiMyEvcJ0qNpkBluoL9sL3DcJ7S
	pCDs4bAT/Sa80F2kR1WZCyoeNHZYy3ZzzUs10pwgp
X-Gm-Gg: ASbGncv5myaOfKDVoAVWVVQat7yq9PMiaCyoiqH7UdYgs5CiPCSjQ3kxIMNJz0U1fND
	Bx+p63UGzIt1elYmf9b9HPaN8ARyTE7Ce8Dd7Sl3nJ/WNFmdiem2iGFeSruI7/2pi2cqvWnotKN
	4DeQH8MpfMUEfISybQWa3CGabhmvINuxERPNqNvM4uTHwWJo5sneW+SddhBpUNn+gVOlOugAe8T
	V3xWbXaBxOnvIaEe6NC/KlvLsaYnIfSNu7IX0HdaDtiazX2iWDKSGwSj3PYFup4WqjDkT+TFFnl
	Y+Bk8h0TMeQ/Lx5zBSeHPPqKEUY=
X-Google-Smtp-Source: AGHT+IFGwzwV2PdBnmzL8mXgRan2fERw/vTgCOurKJjFHayrcS30RBuqNtvLgGgDdlXer4FCuzFSjd5/uaLUw1FVlNs=
X-Received: by 2002:a17:902:d505:b0:266:b8a2:f5d8 with SMTP id
 d9443c01a7336-29655c7a119mr1520385ad.14.1762380936033; Wed, 05 Nov 2025
 14:15:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251105200801.178381-1-almasrymina@google.com> <20251105200801.178381-2-almasrymina@google.com>
In-Reply-To: <20251105200801.178381-2-almasrymina@google.com>
From: Harshitha Ramamurthy <hramamurthy@google.com>
Date: Wed, 5 Nov 2025 14:15:23 -0800
X-Gm-Features: AWmQ_bljffcDvUJLZB0ZodJS92q8_Zm_EPbfpoxwapkprjEWq5txJjOAYuwgef4
Message-ID: <CAEAWyHc4zxC2wKjbO5C8TL6B8Exm6sYQTMxdOihh0PFjFMTkrg@mail.gmail.com>
Subject: Re: [PATCH net v1 2/2] gve: use max allowed ring size for ZC page_pools
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Joshua Washington <joshwash@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	Simon Horman <horms@kernel.org>, Willem de Bruijn <willemb@google.com>, ziweixiao@google.com, 
	Vedant Mathur <vedantmathur@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 5, 2025 at 12:08=E2=80=AFPM Mina Almasry <almasrymina@google.co=
m> wrote:
>
> NCCL workloads with NCCL_P2P_PXN_LEVEL=3D2 or 1 are very slow with the
> current gve devmem tcp configuration.
>
> Root causing showed that this particular workload results in a very
> bursty pattern of devmem allocations and frees, exhausting the page_pool
> ring buffer. This results in sock_devmem_dontneed taking up to 5ms to
> free a batch of 128 netmems, as each free does not find an available
> entry in the pp->ring, and going all the way down to the (slow) gen_pool,
> and gve_alloc_buffer running into a burst of successive allocations
> which also don't find entries in the pp->ring (not dontneed'd yet,
> presumably), each allocation taking up to 100us, slowing down the napi
> poll loop.
>
> From there, the slowness of the napi poll loop results, I suspect,
> in the rx buffers not being processed in time, and packet drops
> detected by tcpdump. The total sum of all this badness results in this
> workload running at around 0.5 GB/s, when expected perf is around 12
> GB/s.
>
> This entire behavior can be avoided by increasing the pp->ring size to th=
e
> max allowed 16384. This makes the pp able to handle the bursty
> alloc/frees of this particular workload. AFACT there should be no
> negative side effect of arbitrarily increasing the pp->ring size in this
> manner for ZC configs - the memory is prealloced and pinned by the
> memory provider anyway.
>
> Tested by running AllToAll PXN=3D2 workload. Before:
>
> Avg bus bandwidth    : 0.434191
>
> After:
>
> Avg bus bandwidth    : 12.5494
>
> Note that there is more we can do to optimize this path, such as bulk
> netmem dontneeds, bulk netmem pp refills, and possibly taking a page
> from the iouring zcrx playbook and replacing the gen_pool with a simpler
> fixed-size array based allocator, but this seems sufficient to fix these
> critcal workloads.
>
> With thanks to Willem and Eric for helping root cause this,
>
> Cc: ziweixiao@google.com
> Fixes: 62d7f40503bc ("gve: support unreadable netmem")
> Reported-by: Vedant Mathur <vedantmathur@google.com>
> Signed-off-by: Mina Almasry <almasrymina@google.com>
> ---
>  drivers/net/ethernet/google/gve/gve_buffer_mgmt_dqo.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/net/ethernet/google/gve/gve_buffer_mgmt_dqo.c b/driv=
ers/net/ethernet/google/gve/gve_buffer_mgmt_dqo.c
> index 0e2b703c673a..f63ffdd3b3ba 100644
> --- a/drivers/net/ethernet/google/gve/gve_buffer_mgmt_dqo.c
> +++ b/drivers/net/ethernet/google/gve/gve_buffer_mgmt_dqo.c
> @@ -8,6 +8,8 @@
>  #include "gve.h"
>  #include "gve_utils.h"
>
> +#include "net/netdev_queues.h"
> +
>  int gve_buf_ref_cnt(struct gve_rx_buf_state_dqo *bs)
>  {
>         return page_count(bs->page_info.page) - bs->page_info.pagecnt_bia=
s;
> @@ -263,6 +265,8 @@ struct page_pool *gve_rx_create_page_pool(struct gve_=
priv *priv,
>         if (priv->header_split_enabled) {
>                 pp.flags |=3D PP_FLAG_ALLOW_UNREADABLE_NETMEM;
>                 pp.queue_idx =3D rx->q_num;
> +               if  (netif_rxq_has_unreadable_mp(priv->dev, rx->q_num))
> +                       pp.pool_size =3D PAGE_POOL_MAX_RING_SIZE;
>         }

Would it make sense to also wrap setting of the
PP_FLAG_ALLOW_UNREADABLE_NETMEM under the
netif_rxq_has_unreadable_mp() helper?
>
>         return page_pool_create(&pp);
> --
> 2.51.2.1026.g39e6a42477-goog
>

