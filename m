Return-Path: <linux-kernel+bounces-846913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CBAD5BC9697
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 16:03:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8124E3B6502
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 14:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B84551E47A3;
	Thu,  9 Oct 2025 14:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hx1cpHeP"
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2859D2E8E08
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 14:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760018584; cv=none; b=pyjwAR2mTaWrDkWZioefbyUrgTYfRXFn5yn72MNzFGbIS0VYVzlYUEpa1xvxoAg6lZ7FPcUTz7pTD0W+ZOF+u9+RIMXj8pdp0fRIDZQP3x1rnWvCmgc/+TuCXeD/pfy7LAfJ3j4EzHfPVaXxlHXJgx+69vrSDsdScifBWNpNyUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760018584; c=relaxed/simple;
	bh=sY/gtgf7NBozOjwc2EeRJ+KgsNPbK5kep4ypL81cuJQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p2Q9QSBh+8rKDzj4BjhwrkHjuDrLa69Iz8yvTwvhSBFvDZuM+WAMbUZamINeZcW+BdN9N1ewq1ZCPrU+/mkf3TExN6w0uJQ6+y7zRq2b25Ss0+EesKCr6KJzJVMGQktAw1zersYOK0QSj3MOlW8Udx1jpbAO4w3yHxCD7DJZCqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hx1cpHeP; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-937b40137b4so88777039f.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 07:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760018580; x=1760623380; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lfk2bfyqFX2yPC1pilpdm6kUPU4T4/Dvd4LObp2un+E=;
        b=hx1cpHeP97IWTfCT66W1ey8BmgdueE/D7jc6vp7ykfiYizvyc/GsfcLOSLM6TXLhgj
         iWW0DwTWqTMlJQbjl0jgrp7SDTEQGQDXDURN1N6/+i/cZ5sXdwvJJkXzGVXOcfaOI2D7
         36u8V4bRl1U6piKJ9JqjusCQcJlCOk32W3ITClBZCzYmr1q+2ZscngIlBzpnnLao2Qxr
         vPwpCbLtuvfHpmE4G8DJOCiWi0vsOCKe8awit8HDZj9PoQVtjeB4SGuW7WoVVN8nJpl8
         XRJQoC/m7LDM1puM9HBFRMuSMcRaRftNpF60Pmdoui9AVYvyztxWlOEBXpT6MTImiZmc
         y8OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760018580; x=1760623380;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lfk2bfyqFX2yPC1pilpdm6kUPU4T4/Dvd4LObp2un+E=;
        b=hzQ1NlBIfUKjsO9I7PyG9GjlMOAMkB9vamGLZmn2po216zIITgB9IOf9rR8liqrdVi
         qsNKDkTjG7sANHVbCoCOrTEpecaHQ1xYDtn+xilhUrGYkGC1CxoaH8BwIc0YSares9je
         fQLsqsqpfCSqaUMqly0Kn9O3CJWp5G6g1V9zt5gVA22IK/cn82bwVWkDflNOKkNj1e7f
         rWdpwnY7E7QbFwPA2rYWWiFxCq94YvIoQOLdPrE1ZpTB2bNJs2k/7MjmB7aDbMIZfSwM
         EJXtFM+Vqz3zsXze0/xHvcFQxNVLxLLf7s7RhWcDJppuMU/7LZqCOY5juupnPRcsURWI
         KDrw==
X-Forwarded-Encrypted: i=1; AJvYcCVcu7KtsAB97Y10N2cy/rT0s3mzeB9aIuHdk7sYgD2a8XUU7tk4cmDM2R8EnmF6hh8IGH52UhFwqLCSl94=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdtZzM4seBJiaOZ1J/2qT4Ce10MCVkqTcIfteeLgllulnMgFLH
	On7h1AwZfsij01OcVXrg0iCMJ4+ifw5wt0NoBMEgmeboQpGzxHWhHANOHjj9z2aFo2ORfk1TBCv
	QTWX/sacTB84TcSSLgE2/OYxOtSs5VXg=
X-Gm-Gg: ASbGncvVsvQJtb0asYzV62wTcrSzUl+EPbHv/4XPYXQ2yOr45Z1DiDIqrgogH0gEc8d
	uvSTLs6CK8n9hGHvRfx4yLbmAYASfWN9miXBfWFy06whY2ROOCqMdDzZrCU0nP/Zg90HkAtrJDD
	r8UUHTtrnWFJ+kzjAI7pH/zmOYHO6xVNrbVCyI0aUtsDVoxgQP0ekEiNQiLWnyMi8IfSH7E5gyD
	I35S3LAyhi15n5wuBoE2ShPmIk3rik=
X-Google-Smtp-Source: AGHT+IGFUh+yxdaAwOY01QTdDPRzmkqga8JwC7gVQ8hdE1VZLzwP/yHjfQX0w+P+lGz62g/ohriduN1YX1Cx7jhB7TA=
X-Received: by 2002:a05:6e02:4405:20b0:42f:9888:48f1 with SMTP id
 e9e14a558f8ab-42f98884980mr2655225ab.1.1760018579842; Thu, 09 Oct 2025
 07:02:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251008165659.4141318-1-aleksander.lobakin@intel.com>
In-Reply-To: <20251008165659.4141318-1-aleksander.lobakin@intel.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 9 Oct 2025 22:02:23 +0800
X-Gm-Features: AS18NWAnZSobSr21rzMet2NXYBsUZ-tOijH1hdSEoiMgzrgWiOgQX5AxwPD-zdc
Message-ID: <CAL+tcoAWf4sNkQzCBTE8S7VgH12NPyqwiYDiig+jv0KGYAhFTA@mail.gmail.com>
Subject: Re: [PATCH bpf] xsk: harden userspace-supplied &xdp_desc validation
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Magnus Karlsson <magnus.karlsson@intel.com>, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kees Cook <kees@kernel.org>, nxne.cnse.osdt.itp.upstreaming@intel.com, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, linux-hardening@vger.kernel.org, 
	stable@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 9, 2025 at 12:59=E2=80=AFAM Alexander Lobakin
<aleksander.lobakin@intel.com> wrote:
>
> Turned out certain clearly invalid values passed in &xdp_desc from
> userspace can pass xp_{,un}aligned_validate_desc() and then lead
> to UBs or just invalid frames to be queued for xmit.
>
> desc->len close to ``U32_MAX`` with a non-zero pool->tx_metadata_len
> can cause positive integer overflow and wraparound, the same way low
> enough desc->addr with a non-zero pool->tx_metadata_len can cause
> negative integer overflow. Both scenarios can then pass the
> validation successfully.
> This doesn't happen with valid XSk applications, but can be used
> to perform attacks.
>
> Always promote desc->len to ``u64`` first to exclude positive
> overflows of it. Use explicit check_{add,sub}_overflow() when
> validating desc->addr (which is ``u64`` already).
>
> bloat-o-meter reports a little growth of the code size:
>
> add/remove: 0/0 grow/shrink: 2/1 up/down: 60/-16 (44)
> Function                                     old     new   delta
> xskq_cons_peek_desc                          299     330     +31
> xsk_tx_peek_release_desc_batch               973    1002     +29
> xsk_generic_xmit                            3148    3132     -16
>
> but hopefully this doesn't hurt the performance much.

I don't see an evident point that might affect the performance. Since
you said that, I tested by running './xdpsock -i eth1 -t -S -s 64' and
didn't spot any degradation.

>
> Fixes: 341ac980eab9 ("xsk: Support tx_metadata_len")
> Cc: stable@vger.kernel.org # 6.8+
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>

Thanks for the fix!

Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>

> ---
>  net/xdp/xsk_queue.h | 45 +++++++++++++++++++++++++++++++++++----------
>  1 file changed, 35 insertions(+), 10 deletions(-)
>
> diff --git a/net/xdp/xsk_queue.h b/net/xdp/xsk_queue.h
> index f16f390370dc..1eb8d9f8b104 100644
> --- a/net/xdp/xsk_queue.h
> +++ b/net/xdp/xsk_queue.h
> @@ -143,14 +143,24 @@ static inline bool xp_unused_options_set(u32 option=
s)
>  static inline bool xp_aligned_validate_desc(struct xsk_buff_pool *pool,
>                                             struct xdp_desc *desc)
>  {
> -       u64 addr =3D desc->addr - pool->tx_metadata_len;
> -       u64 len =3D desc->len + pool->tx_metadata_len;
> -       u64 offset =3D addr & (pool->chunk_size - 1);
> +       u64 len =3D desc->len;
> +       u64 addr, offset;
>
> -       if (!desc->len)
> +       if (!len)
>                 return false;
>
> -       if (offset + len > pool->chunk_size)
> +       /* Can overflow if desc->addr < pool->tx_metadata_len */
> +       if (check_sub_overflow(desc->addr, pool->tx_metadata_len, &addr))
> +               return false;
> +
> +       offset =3D addr & (pool->chunk_size - 1);
> +
> +       /*
> +        * Can't overflow: @offset is guaranteed to be < ``U32_MAX``
> +        * (pool->chunk_size is ``u32``), @len is guaranteed
> +        * to be <=3D ``U32_MAX``.
> +        */
> +       if (offset + len + pool->tx_metadata_len > pool->chunk_size)
>                 return false;
>
>         if (addr >=3D pool->addrs_cnt)
> @@ -158,27 +168,42 @@ static inline bool xp_aligned_validate_desc(struct =
xsk_buff_pool *pool,
>
>         if (xp_unused_options_set(desc->options))
>                 return false;
> +

nit?

>         return true;
>  }
>
>  static inline bool xp_unaligned_validate_desc(struct xsk_buff_pool *pool=
,
>                                               struct xdp_desc *desc)
>  {
> -       u64 addr =3D xp_unaligned_add_offset_to_addr(desc->addr) - pool->=
tx_metadata_len;
> -       u64 len =3D desc->len + pool->tx_metadata_len;
> +       u64 len =3D desc->len;
> +       u64 addr, end;
>
> -       if (!desc->len)
> +       if (!len)
>                 return false;
>
> +       /* Can't overflow: @len is guaranteed to be <=3D ``U32_MAX`` */
> +       len +=3D pool->tx_metadata_len;
>         if (len > pool->chunk_size)
>                 return false;
>
> -       if (addr >=3D pool->addrs_cnt || addr + len > pool->addrs_cnt ||
> -           xp_desc_crosses_non_contig_pg(pool, addr, len))
> +       /* Can overflow if desc->addr is close to 0 */
> +       if (check_sub_overflow(xp_unaligned_add_offset_to_addr(desc->addr=
),
> +                              pool->tx_metadata_len, &addr))
> +               return false;
> +
> +       if (addr >=3D pool->addrs_cnt)
> +               return false;
> +
> +       /* Can overflow if pool->addrs_cnt is high enough */
> +       if (check_add_overflow(addr, len, &end) || end > pool->addrs_cnt)
> +               return false;
> +
> +       if (xp_desc_crosses_non_contig_pg(pool, addr, len))
>                 return false;
>
>         if (xp_unused_options_set(desc->options))
>                 return false;
> +
>         return true;
>  }
>
> --
> 2.51.0
>
>

