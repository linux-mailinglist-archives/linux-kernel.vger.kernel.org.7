Return-Path: <linux-kernel+bounces-851218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 50A8FBD5CCD
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 20:54:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CB3F0351709
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 18:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A57242D876F;
	Mon, 13 Oct 2025 18:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iDhhy3hW"
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE3A2C3242
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 18:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760381651; cv=none; b=Mg5OaxeCAkV67mzAypq2HKWBZlRbBXLu2QPWUv/dhd6cdxNBjqpAS6fObJNx2h49ArgqeXFuugVcOlFJlgcb2y7bZUw5MHEoU05kyQGuj2I49e0vhxdJ6ahdamq3S+pMAys/Kh79FN5L6lg8EzukkAg5HGmgosLyRCXmwWDlr4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760381651; c=relaxed/simple;
	bh=Q0A8mwHB6ISznX1IsEIotmy3Sl/eaR8kzKeY3PLseig=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WJ9X0/F3qDW9XWmDELcq0XpOH8xO+urAidGhFycjzNUdIx08nl7oHeCXEuKW5pUwD6I8g+gctupBgBW09k777uTJtFvYC1oA/j9fObJYa7Rdwz1SvlWqVVw4Njcnx9m4WeQXYwPallkyz0AyGeS9F1fFVG1B/62o58lk0pf1u2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iDhhy3hW; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-85cee530df9so707260785a.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 11:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760381649; x=1760986449; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OHvdDoFLXKQzTfUBohM5QpfVzGeutBShrm8qkwsGAgA=;
        b=iDhhy3hWQseR7B59Wk9B1f1X5jyath/Vv1m6ebI7H29S1vvYX6vMnQ3ToYPWAWwJUf
         KogVPsls1PuYOmBJZZsKhmYfqJWhawxOO/jQW2Zd36FIr0VZwKyytraEV8ZQjhsiquKT
         8U/DgtZm/LBOH3sITn2q+qLwHHdZk/TwqTr0Lgz0PVxEVezb4L01HkZupGnKTuJT3QXX
         QiK7W69yIlzxc12ngLPQ297WhE1NJBvA+bcqRgtWl/6h7ziB37bozqi/nnWtGcLxzF0e
         oPd3Ma2yPQ0FfC6+IjBkEPm7sOjUjvE1B5LQKtDCnTp+4z2xorUoAsBv0RJ+504llQ1n
         umfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760381649; x=1760986449;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OHvdDoFLXKQzTfUBohM5QpfVzGeutBShrm8qkwsGAgA=;
        b=QgGliCYXJLyYcff2Y0By51aZGOm7SBB3CcJFqOwe0OTsOGvwoj6Ofqk8aAtiQtBneO
         4h3+vhEKhA/tbAQapU+NJKmQ8Z1ixUewNqOtK3+i+usZu+983nuIJqFwUYm+PFd05JJU
         ayojWo0tGNIbPWt0CoX9qpro1l50Gk1CqI3TOKpI5nx2WKCPWAjBFScDVmZhjlyVF+OE
         MUq3LzoIrZcjrTAMeZG+7j4Brs6XXy0rZkJ8hyTZP/J1BrbCkfKQ0R46BoUqj7ArKdVd
         az2xE4YPxnIff1bdZ4oHIeqIsEnMB0Uy7+xjqyuIll5xv+M9A7TocgsMtQ+YlzhR8GXC
         ZLZw==
X-Forwarded-Encrypted: i=1; AJvYcCU6gxkVaHypDqsX9QGK3+DW3oIJqDhUmvQCIqxqlZTPRkmjFVFcdC5fCJOPDGFWqOU3qW10JIjIycAYtuw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxg4nRFOIhM+r+/TTR0BeNb27Wzgw6X5qSrGSSzHTx8S/Odpoqw
	Yu+QI62rLlz4/xdbDB2Cj3GfvearRoQrl2F3R1oRGrjbzsGCM1jwx0QzbHxJGINkQPJfNb2MLGi
	1t97A73L+hMLOeq4HZahuG/rlXxVt03VBNBIe710s
X-Gm-Gg: ASbGnctJZ5Qwv8g+unKnwKAIE12O/X4412FfFcaZozb96KPucE3CPXSaFI+Ri7geqV1
	FVIb7GcyT8MObiSZflM93sL1ecVa6H4LGJyuJ9nnBlgHBaHZAfVcNcAO/hjnw+xdcM1M0Y1fXLM
	YnfzZRCGSkjnjTawts5ksm9/VHJKaHujc5tajkt6RadrkDYkHB7XPOo74105lMi5W1HTSh+XQeq
	smUnz1v/23LECZXrXO0Qe4jYuBnmAm7
X-Google-Smtp-Source: AGHT+IHEX/LXCcXiIAvMWCf1qx+3kkMbx/P3MOisSt6xugJLgd5lVynv5AI5WAJHsRmWmbQAX0ncoNz5Nk1IfQjetPE=
X-Received: by 2002:ac8:5902:0:b0:4de:b0d4:dda4 with SMTP id
 d75a77b69052e-4e6ead7493fmr328872751cf.69.1760381648539; Mon, 13 Oct 2025
 11:54:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251013101636.69220-1-21cnbao@gmail.com>
In-Reply-To: <20251013101636.69220-1-21cnbao@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 13 Oct 2025 11:53:57 -0700
X-Gm-Features: AS18NWAe_NmExu5WITMBDbR0FpCc3scky7DNzwEUSRCGS5tETmNSC2IUauhYc4w
Message-ID: <CANn89i+wikOQQrGFXu=L3nKPG62rsBmWer5WpLg5wmBN+RdMqA@mail.gmail.com>
Subject: Re: [RFC PATCH] mm: net: disable kswapd for high-order network buffer allocation
To: Barry Song <21cnbao@gmail.com>
Cc: netdev@vger.kernel.org, linux-mm@kvack.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Barry Song <v-songbaohua@oppo.com>, 
	Jonathan Corbet <corbet@lwn.net>, Kuniyuki Iwashima <kuniyu@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, Vlastimil Babka <vbabka@suse.cz>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Brendan Jackman <jackmanb@google.com>, Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, 
	Yunsheng Lin <linyunsheng@huawei.com>, Huacai Zhou <zhouhuacai@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 13, 2025 at 3:16=E2=80=AFAM Barry Song <21cnbao@gmail.com> wrot=
e:
>
> From: Barry Song <v-songbaohua@oppo.com>
>
> On phones, we have observed significant phone heating when running apps
> with high network bandwidth. This is caused by the network stack frequent=
ly
> waking kswapd for order-3 allocations. As a result, memory reclamation be=
comes
> constantly active, even though plenty of memory is still available for ne=
twork
> allocations which can fall back to order-0.
>
> Commit ce27ec60648d ("net: add high_order_alloc_disable sysctl/static key=
")
> introduced high_order_alloc_disable for the transmit (TX) path
> (skb_page_frag_refill()) to mitigate some memory reclamation issues,
> allowing the TX path to fall back to order-0 immediately, while leaving t=
he
> receive (RX) path (__page_frag_cache_refill()) unaffected. Users are
> generally unaware of the sysctl and cannot easily adjust it for specific =
use
> cases. Enabling high_order_alloc_disable also completely disables the
> benefit of order-3 allocations. Additionally, the sysctl does not apply t=
o the
> RX path.
>
> An alternative approach is to disable kswapd for these frequent
> allocations and provide best-effort order-3 service for both TX and RX pa=
ths,
> while removing the sysctl entirely.
>
>
...

> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> ---
>  Documentation/admin-guide/sysctl/net.rst | 12 ------------
>  include/net/sock.h                       |  1 -
>  mm/page_frag_cache.c                     |  2 +-
>  net/core/sock.c                          |  8 ++------
>  net/core/sysctl_net_core.c               |  7 -------
>  5 files changed, 3 insertions(+), 27 deletions(-)
>
> diff --git a/Documentation/admin-guide/sysctl/net.rst b/Documentation/adm=
in-guide/sysctl/net.rst
> index 2ef50828aff1..b903bbae239c 100644
> --- a/Documentation/admin-guide/sysctl/net.rst
> +++ b/Documentation/admin-guide/sysctl/net.rst
> @@ -415,18 +415,6 @@ GRO has decided not to coalesce, it is placed on a p=
er-NAPI list. This
>  list is then passed to the stack when the number of segments reaches the
>  gro_normal_batch limit.
>
> -high_order_alloc_disable
> -------------------------
> -
> -By default the allocator for page frags tries to use high order pages (o=
rder-3
> -on x86). While the default behavior gives good results in most cases, so=
me users
> -might have hit a contention in page allocations/freeing. This was especi=
ally
> -true on older kernels (< 5.14) when high-order pages were not stored on =
per-cpu
> -lists. This allows to opt-in for order-0 allocation instead but is now m=
ostly of
> -historical importance.
> -

The sysctl is quite useful for testing purposes, say on a freshly
booted host, with plenty of free memory.

Also, having order-3 pages if possible is quite important for IOMM use case=
s.

Perhaps kswapd should have some kind of heuristic to not start if a
recent run has already happened.

I am guessing phones do not need to send 1.6 Tbit per second on
network devices (yet),
an option  could be to disable it in your boot scripts.

