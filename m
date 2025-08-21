Return-Path: <linux-kernel+bounces-780826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 33F62B309D7
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 01:09:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 960AB1D0016E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 23:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB3E72D97AA;
	Thu, 21 Aug 2025 23:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f1+wL8hp"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B01272E43
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 23:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755817741; cv=none; b=ZhHzZozaO1HwRDZhi6JA8PqgT58QyWxxSuShdGgToyl+lqRA9gta47HINca7M5939cExTPI5RHsWv81RVHhq/3LhdxevrFiTiYJeV9y9+Ni+kMlUhSqMwBt0DmUgioJukoCjfWwkO6YAKsIk4S7ayUBlkHW2N0K9u5k1g2ejGC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755817741; c=relaxed/simple;
	bh=Y5H03yME9tlnPLL7pIW9/OtSVagb7ZuTcfQ9D/jsVzE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m/s+MC/VwEX/buIXyv/PZFYRgREpVyfSdYcCW+pLy/N5YFja5YYKZi+2m/t+8VnMCB3Gwd4KxAjDDsQjGhnkgMaZ6RnqDjKxrDyZfzLi0ZyeJdD1Gc+9U+FYwTIGPVWQj1xZhsC/1dvzRNas+n7rwUJd08yhlqCXWzSi9RL24Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=f1+wL8hp; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-459fbca0c95so30215e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 16:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755817738; x=1756422538; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L77xUDEmyoLvrX97o1nUFPtOyxF9ceXHsdzlmWuagMQ=;
        b=f1+wL8hp10nXEpikMhrN6pPpEwGZ86riTLt+yad4l6gSVC/di9lH9M+OfAf6G5kqbc
         uxtALhJrHW49d/0AeiIAYJKQPOAaZB6GtfvIRTjBp/Vyl9mLmNylYUtyVR/If3KOWYuo
         EmalhNWSVwEFLXzqLCy+V2rjy3AWRxrRvCLEUMgEp4PMTMjEowIktiHCmH7XIKPeHpGX
         97dbeIw81IbP2gHvKLlArUVyG2hPK6OO9/gmt2h4aNiaQHx5pvksrtJ33iYw0eAyb63v
         +O//5bDIzzPLynz2iKo7JP1lZlGPBtWi5hoOahNJzJuoupZVPA2HcUI+HAhC3Wq8FZuq
         1zjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755817738; x=1756422538;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L77xUDEmyoLvrX97o1nUFPtOyxF9ceXHsdzlmWuagMQ=;
        b=lAhu1g5OFQMIZZl2MTU7YTrOfotu/P+J/kGJ+wfSUtpNI8DQ3R3eoKtAvjbYQhC+l7
         D4vE0PbrZzCj9U1GpAwuW5LibxjzV9bQs4MmzLMRzdQiaWDmpD3gMJ+M3SW47G0TKyJ6
         hYRGczQzDiwK+Qe1ZcAiuOItiFP6gHyvSMcCWpucczpjdw01rdIQ21pD/5wK7CYpxyc+
         t7UHu+UG01L7po/rkVFMFQgBauj6rJKHAixMTdOhGc0w720W9g9gzUdhY5Qx1GsNItvf
         g7CXHL/AZJzaK86MWX2AKzx33uQD5DNUfQrSfuz3MBe81/dnHnOuCqo3JZh6YkB7RrO6
         VcKQ==
X-Forwarded-Encrypted: i=1; AJvYcCXjXcK2OhBDDKqO8HaDwLA8t87sicW4hO9i+msWMTpqLcbm/ecA9MrY9SXn/LRkdhRIZNPuK+IuS4LvxGs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw15me5UtNCEM3fJpdg/WYSxfexaxqgcQD2///4EanxmeipGvzd
	OHs0nMnTGhEdp/Z5tk9Vj9gnhF9Mwvr4crFm18szFN1e7TYSFnZuRBfCz/bM5NxsZiNQdZ59zEb
	dUcfM8w/QmlNV/PO/3m8LMmo/pFHYOO5ATeM/tpnW
X-Gm-Gg: ASbGncsXoKDWtcfO1v433wMIGW9yhTfsEKgaMy05QmUH1XSo/tT7+HT0FtfsBuLSSeK
	7kHr8pgnv18b+kgqpD33X6qfCvFSDhB6wf8pnfqqC47VggH8jTwlnMchapQ6Er7N5ZwCoKemhNE
	6uw6+QNlhTXkLFCNGhlqrYloScU3gsiqDODNtfKBTJiLKk+KGmtI94C3aUyUX2WBP9SS6U2NycA
	c5JtVvhMXCv1B353XQXO1WefDUyKKsT19kv8/cQan39+Nw=
X-Google-Smtp-Source: AGHT+IHqxqiVwocOp0r5efeFXaRCBSd7tvJuGa3xj5Uo4LzMOxVOD2dlJdtT3gkdTDsuidX4F2vR/Ty1h77VkFuwobg=
X-Received: by 2002:a05:600c:8b01:b0:453:79c3:91d6 with SMTP id
 5b1f17b1804b1-45b52119c8dmr234265e9.1.1755817737631; Thu, 21 Aug 2025
 16:08:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250821030349.705244-1-almasrymina@google.com>
In-Reply-To: <20250821030349.705244-1-almasrymina@google.com>
From: Samiullah Khawaja <skhawaja@google.com>
Date: Thu, 21 Aug 2025 16:08:44 -0700
X-Gm-Features: Ac12FXyYskNcdVHna1U4upva43G1arYBWxE-pS5te9bEvcxkDP-4_Li1vcDBayc
Message-ID: <CAAywjhQ7ySv_Bu4EFxxYnDL5Di4ur0wbFYyVR0bKP6ggMfdXHg@mail.gmail.com>
Subject: Re: [PATCH net v1] page_pool: fix incorrect mp_ops error handling
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 20, 2025 at 8:03=E2=80=AFPM Mina Almasry <almasrymina@google.co=
m> wrote:
>
> Minor fix to the memory provider error handling, we should be jumping to
> free_ptr_ring in this error case rather than returning directly.
>
> Found by code-inspection.
>
> Cc: skhawaja@google.com
>
> Fixes: b400f4b87430 ("page_pool: Set `dma_sync` to false for devmem memor=
y provider")
> Signed-off-by: Mina Almasry <almasrymina@google.com>
>
> ---
>  net/core/page_pool.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> index 343a6cac21e3..ba70569bd4b0 100644
> --- a/net/core/page_pool.c
> +++ b/net/core/page_pool.c
> @@ -287,8 +287,10 @@ static int page_pool_init(struct page_pool *pool,
>         }
>
>         if (pool->mp_ops) {
> -               if (!pool->dma_map || !pool->dma_sync)
> -                       return -EOPNOTSUPP;
> +               if (!pool->dma_map || !pool->dma_sync) {
> +                       err =3D -EOPNOTSUPP;
> +                       goto free_ptr_ring;
> +               }
>
>                 if (WARN_ON(!is_kernel_rodata((unsigned long)pool->mp_ops=
))) {
>                         err =3D -EFAULT;
>
> base-commit: c42be534547d6e45c155c347dd792b6ad9c24def
> --
> 2.51.0.rc1.193.gad69d77794-goog
>

Reviewed-by: Samiullah Khawaja <skhawaja@google.com>

