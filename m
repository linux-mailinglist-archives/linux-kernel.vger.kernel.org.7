Return-Path: <linux-kernel+bounces-889683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4ADFC3E3D3
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 03:22:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87AD73ABCA8
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 02:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4F242D7DDB;
	Fri,  7 Nov 2025 02:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CF2Y0pNi";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="agxI+Coc"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D0A28D8F4
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 02:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762482137; cv=none; b=tWTeruJ/OdtyzsJvUTYkiSchjfoSXGY/f8H39vhUmYg1NVONLjpfM1KddfYSDCfd8dnx4Grh9jzoDG/iJPTIcHr9ZcYOVLo8eTuRV9dHvwyKJkjUMgrD3Ti+XmVGDHzCub+vkgd1lCivalXV7D3fMDQf4ndwwY++bnjT3apIWgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762482137; c=relaxed/simple;
	bh=eiI4RKVF+XpJdnWRY2/y6Pec9+uJCgwdIuA1y4j7C2A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ENQD8HE55v1RXXM6v4jjcn4vwAey3wNsYkMQJWba8JzRAGKr4sW7Y4leD1xRuXHQ53mLIHWCdd+IKPv5C7tRtwZTXJbLTlVQODVrVdmfDfxAlaqBgJebdaokpP6DMHJJbRHy5di8tBoecWipfwEkFftvRUK7Ik8FTjoRAD0LM7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CF2Y0pNi; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=agxI+Coc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762482134;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NmfewvY3TIZVqOYMciv4wS6LQJa6kLXl31utpCfsjYw=;
	b=CF2Y0pNi1jK/eLVFRMCmX1Irr+WeIYeeRTchkV+SUk3YjfnZ7Cey72guVP270/wiMx6r0O
	Dr2+crkwXA0jYgZOqOWGyrru2VJOVGn6R71IQwHykr1DhjRSGDcCI1kbvqTR8M7Dba3Qnk
	uAZqBKhKNa9mDW1s7I+2fpPSxd/lcGI=
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-66-071tbkYuPMyMQip7vLmS7w-1; Thu, 06 Nov 2025 21:22:12 -0500
X-MC-Unique: 071tbkYuPMyMQip7vLmS7w-1
X-Mimecast-MFC-AGG-ID: 071tbkYuPMyMQip7vLmS7w_1762482132
Received: by mail-ua1-f71.google.com with SMTP id a1e0cc1a2514c-935183381c7so132063241.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 18:22:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762482127; x=1763086927; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NmfewvY3TIZVqOYMciv4wS6LQJa6kLXl31utpCfsjYw=;
        b=agxI+Coc1NN8GIq8swxkduFoiw6GUoIhUq05efjOvSG1rwqKy0esU+4pceae9M7jGV
         ZHlKkT1fzI2ce907xq3zTkAKdxMNcLxwxW6kNAiEXs1As07M6xUEzJcGnm1JiBr5CoeW
         LzbENAtoLtaQn4QJ8uP4cnrRt2GX5DcnU/2ymlOM9fi5huLFD6+q5MD8+xKrRYv874Lh
         kxPoFAwqEokDq+9IF0664TW1dsVwq1WuHFSdIfEw3hiBnBUzNRfJi8cFplQ+pg4bY0wG
         mb9TF1wn1SiKH6WX958JoqRL6wmZTM9UkQCL6/idpslmHt/PrdCUjzearZdYmXDEIbst
         GinQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762482127; x=1763086927;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NmfewvY3TIZVqOYMciv4wS6LQJa6kLXl31utpCfsjYw=;
        b=rW0fZLQt/zAwBrNlbeh/JL+UScdT687KcDdruLYpdWdYmJ2R3QMdk5zpnSOco0V/Ob
         +4AyEF0zUhgMnnUFWeUBplPZMMnMvXdjq2FY1sSRPr5gmUc5q1exrr9IjbMKVlNZH4EB
         6LBTZHaiy+59bdr0Y/D/ihaheU1uLBDJmpuqjY86QYherwmENf4WslGy+gGaDDNxSe+/
         a4xOz1ESStPvrqcWzItGINi3yq3v6UpWgo1kbMSZlMrnVN5CWXr7TWWEM2gl1gMWEmrC
         J3xlHXFy+lFFmSSwoVxmc44EA9z/jNAhFDsWKeikopo2MwHgrJBg9jHmlMvQQIQUq5lz
         VHbA==
X-Forwarded-Encrypted: i=1; AJvYcCUVxy0WynMP3r6DDcM2hhUlrk/hrDvEW82qMsNrC0YyiOeNxy8f0T9S+6na0njk7vEqCb60QI6bFZLjk8M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbwmT6SKmhqFzL06/l2O2ET+GrBCsdYltWGuU95h+EARMwj4yw
	v5N5OlHZxzH2jTobRHm0E9NSEZgEjunNC3sNUd6EmfOT3rmLUTNVLzKA6wDlOSZf96ZZKT2jDp2
	3E/+C0jCJiZiQwtaN3tMl5wKt3fqSkBX9+mofuDZA0+qas6d6fXRq6rcYwsZR/zsdafs+diJkBr
	LvFae5XlrvTxsYke2CduTj3Es5DIKNrUJCYsFJorX4
X-Gm-Gg: ASbGncs07YsiU4uxelnbeEmRJZE/nsWqBp5ElxTuct3FtQ4pGE90B+I16RIngb5yFP2
	o6fr0oejk+XRDrqnkvOtO1Z/pHin5j9RMRxM8TIhGu0DV4QObT1EWhWZ2ThO/RfWEpNMQ1Qc3na
	a8jixXJICZ//pK6wQ+8hkvCZerZaFKYlbxKFBVNVEhb8uS7GG8qSo6nUnX
X-Received: by 2002:a05:6102:5088:b0:5db:ce1d:678b with SMTP id ada2fe7eead31-5ddb2262982mr529361137.23.1762482126540;
        Thu, 06 Nov 2025 18:22:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHQTgCIR2yZlyIRsjR+uBaJ9KKVZE3VbDYLFEq7FC0HdybQ70nBT/Rf27Y/CrpLSHwuhhdFyvK8RLF+GsdDVVg=
X-Received: by 2002:a05:6102:5088:b0:5db:ce1d:678b with SMTP id
 ada2fe7eead31-5ddb2262982mr529351137.23.1762482126071; Thu, 06 Nov 2025
 18:22:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251106155008.879042-1-nhudson@akamai.com>
In-Reply-To: <20251106155008.879042-1-nhudson@akamai.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 7 Nov 2025 10:21:53 +0800
X-Gm-Features: AWmQ_bkNLb92dFLG4-4esFms4Eqjl550eytSJVRszH74gOThR-8BQOC_V694_EU
Message-ID: <CACGkMEt1xybppvu2W42qWfabbsvRdH=1iycoQBOxJ3-+frFW6Q@mail.gmail.com>
Subject: Re: [PATCH] tun: use skb_attempt_defer_free in tun_do_read
To: Nick Hudson <nhudson@akamai.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 6, 2025 at 11:51=E2=80=AFPM Nick Hudson <nhudson@akamai.com> wr=
ote:
>
> On a 640 CPU system running virtio-net VMs with the vhost-net driver, and
> multiqueue (64) tap devices testing has shown contention on the zone lock
> of the page allocator.
>
> A 'perf record -F99 -g sleep 5' of the CPUs where the vhost worker thread=
s run shows
>
>     # perf report -i perf.data.vhost --stdio --sort overhead  --no-childr=
en | head -22
>     ...
>     #
>        100.00%
>                 |
>                 |--9.47%--queued_spin_lock_slowpath
>                 |          |
>                 |           --9.37%--_raw_spin_lock_irqsave
>                 |                     |
>                 |                     |--5.00%--__rmqueue_pcplist
>                 |                     |          get_page_from_freelist
>                 |                     |          __alloc_pages_noprof
>                 |                     |          |
>                 |                     |          |--3.34%--napi_alloc_skb
>     #
>
> That is, for Rx packets
> - ksoftirqd threads pinned 1:1 to CPUs do SKB allocation.
> - vhost-net threads float across CPUs do SKB free.
>
> One method to avoid this contention is to free SKB allocations on the sam=
e
> CPU as they were allocated on. This allows freed pages to be placed on th=
e
> per-cpu page (PCP) lists so that any new allocations can be taken directl=
y
> from the PCP list rather than having to request new pages from the page
> allocator (and taking the zone lock).
>
> Fortunately, previous work has provided all the infrastructure to do this
> via the skb_attempt_defer_free call which this change uses instead of
> consume_skb in tun_do_read.
>
> Testing done with a 6.12 based kernel and the patch ported forward.
>
> Server is Dual Socket AMD SP5 - 2x AMD SP5 9845 (Turin) with 2 VMs
> Load generator: iPerf2 x 1200 clients MSS=3D400
>
> Before:
> Maximum traffic rate: 55Gbps
>
> After:
> Maximum traffic rate 110Gbps
> ---
>  drivers/net/tun.c | 2 +-
>  net/core/skbuff.c | 2 ++
>  2 files changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index 8192740357a0..388f3ffc6657 100644
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c
> @@ -2185,7 +2185,7 @@ static ssize_t tun_do_read(struct tun_struct *tun, =
struct tun_file *tfile,
>                 if (unlikely(ret < 0))
>                         kfree_skb(skb);
>                 else
> -                       consume_skb(skb);
> +                       skb_attempt_defer_free(skb);
>         }
>
>         return ret;
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index 6be01454f262..89217c43c639 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -7201,6 +7201,7 @@ nodefer:  kfree_skb_napi_cache(skb);
>         DEBUG_NET_WARN_ON_ONCE(skb_dst(skb));
>         DEBUG_NET_WARN_ON_ONCE(skb->destructor);
>         DEBUG_NET_WARN_ON_ONCE(skb_nfct(skb));
> +       DEBUG_NET_WARN_ON_ONCE(skb_shared(skb));

I may miss something but it looks there's no guarantee that the packet
sent to TAP is not shared.

>
>         sdn =3D per_cpu_ptr(net_hotdata.skb_defer_nodes, cpu) + numa_node=
_id();
>
> @@ -7221,6 +7222,7 @@ nodefer:  kfree_skb_napi_cache(skb);
>         if (unlikely(kick))
>                 kick_defer_list_purge(cpu);
>  }
> +EXPORT_SYMBOL(skb_attempt_defer_free);
>
>  static void skb_splice_csum_page(struct sk_buff *skb, struct page *page,
>                                  size_t offset, size_t len)
> --
> 2.34.1
>

Thanks


