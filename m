Return-Path: <linux-kernel+bounces-888566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A6B89C3B2AA
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 14:20:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AFDD34FF758
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 13:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C35132B98E;
	Thu,  6 Nov 2025 13:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R1S09r2G"
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B60432AAA4
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 13:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762434790; cv=none; b=t2iXQIDqOa5rhOO2l4qSu5OrfcFQ7iIHGRCJshmikRXvgrcquaM48MDN64Za26k9md0er0J2kBrO/ysDmw4qbhzvcHSbf8tl2Jf7gaXhPH7Ca7gN4EJq/tcQq5XLkVMZq4600eoI/eAZUfbCApiIg1JWsXzgn7SVXouu8lX6wvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762434790; c=relaxed/simple;
	bh=Rgg2Af4bzAMXAetO+2YUfn1QvzY5Z7jf0MbYpQj87MI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DufHSGRdfPPHHsYUh0HhXKI0AG4txASlsUPhvT0jS05JkJngpc4+6UVitQgiXjAeDZNughSyapK8fD9HJzenjyg8P7EWXJ8tUHxTzjw6Q9yFBTn+0KtttgTpXHnENt1nH46PSGNcIVs0t44wYsNDyL6CsCvLk/NNh9GRYt9mpm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=R1S09r2G; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-786a822e73aso9776387b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 05:13:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762434788; x=1763039588; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Pr8zIq++NWe3T42mWiyg4rbtFwpYjZBhkQARiQCCDt8=;
        b=R1S09r2GhRQnOcd8X+O2zTWysTMpkG12lwRhTrRE72Xy5yS9RtyLyRd79dQGboQYGt
         h7w3WZT+QEfMvbX4p+41wYD2JZbohvgydjZFfWBHor7G8jyng0xz6PaSu2di9yXyCW8e
         WOaYNxtx9YCvZhM5MQkIaHbNMRVpYzlUhDdrDiCUXlq2upTa44tKdOepoMZiKJK9+q9W
         rMjkYQwfgIeLORTzlm5IrHb5CLWC4d8tJIQzhJmoU+8sAGZDAXw7vAH4qp6VSXtYpZyb
         89wsPArU7L963ank6JR1AX/oJQBbbS5q00EKo18cWTClg0rUFFJ+5hB2JMeQlurG1aH8
         +oiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762434788; x=1763039588;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Pr8zIq++NWe3T42mWiyg4rbtFwpYjZBhkQARiQCCDt8=;
        b=c8iYOccd5RHXRfdZSh2VWcfVsfjDQeDAxGLOX9eRYZ/B7PTdsu9wp5Xe3maLU7C0d7
         UUWD1u5uQnpP0XF5tQ9OZtxrIx9j2dC5r7B592LT2aiQl9xLOZDCRyZuR3Z6QpjfZljD
         euut66GxpbROJr0YT3rh998F9JyK7SDGWKzMUXyYUFJTd70uGBK3dxWHx33bktVUn4tv
         dJV44XZSHbWIuxV+MYbl5AAC65KZVMov9j3Zfqa4Ig8z4NHmwZk9NCtMuqpxm2U+c2iO
         4FOpNTxzrQ0BVRiVPiWOJpA+LdjQ4Gv6iUS5/Y50RrmgwEz2INPCIozVSRHqy0LlTHk0
         t0Nw==
X-Forwarded-Encrypted: i=1; AJvYcCUEowpLnYFq6OcpEovxn11f4+aCazNm5W03uV2HI1BPu1OPRIPQGmonKFu5xSFMbCe7A1ejjhl/4E4J590=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnkAGHcvObBImx8OqncSuadWdPwGm+19g8t2IWb+XqUgzQ9NxW
	lNhoiDRS1dEkoh5mRAQLD8LYxJmKAtNwvPVR9WofX15YjUYyahSb/jw0dFbvK7poVJGuxMwOKeR
	X3NwgqsFpD8QaqwrMJtU5uJQEe+A7cw+D5K0JZBhNlg==
X-Gm-Gg: ASbGncuY5Bm/qzO6Ztr6m/7hSUuMNM3tHoIQw+1GgAw6krrt6E7UlhFSR5EYSw0u2LM
	5RxiLN857w8HBjBJj2YuDaXpjmpVW7i6yUo/SzQWZ2VNq3uXtAMalv3Y7ptRvXx1EhcW1Ks8v/c
	JK41tplFV0P4POpp2OtuS93TG5GUT4PGDmp7wu9EhwbZ4H5qq2Gvm6JwXoKCzIqFRkHfUd7+tEE
	/k4YNj3+URhltoisgp97ikzWqvRKDSckNKWSKRb+IxGCfMkY1y+sTu7VN9dmABIrcOmecZIPX5n
	rJi6WzFsKMlFOCnkTgHsP6omIWNds5nG5kQvlHu4Wg5CNVRKJlVU
X-Google-Smtp-Source: AGHT+IHpA25Qw9KHp85CbOrmqi7smoI+i5HXa4iYSYr8Yl5m2jCAvh/JMAJMh3OTTZoWzQa0g2jxyJn4ENm2LDRqHa8=
X-Received: by 2002:a53:d058:0:20b0:63f:9f4a:3ea with SMTP id
 956f58d0204a3-63fd34cd64cmr4943589d50.19.1762434788033; Thu, 06 Nov 2025
 05:13:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251105200801.178381-1-almasrymina@google.com>
In-Reply-To: <20251105200801.178381-1-almasrymina@google.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 6 Nov 2025 15:12:30 +0200
X-Gm-Features: AWmQ_bnjH5M9dyJZq9l8Gj4I9eAK7C21YFV07XTbiWP_NI6BQWytXh7uxg1q-mI
Message-ID: <CAC_iWjK1bz9a_SzYsEuZmqvYDWT6h6hFwWdX2OO5aNBcjp1MFw@mail.gmail.com>
Subject: Re: [PATCH net v1 1/2] page_pool: expose max page pool ring size
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Joshua Washington <joshwash@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Simon Horman <horms@kernel.org>, 
	Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 5 Nov 2025 at 22:08, Mina Almasry <almasrymina@google.com> wrote:
>
> Expose this as a constant so we can reuse it in drivers.
>
> Signed-off-by: Mina Almasry <almasrymina@google.com>
> ---
>  include/net/page_pool/types.h | 2 ++
>  net/core/page_pool.c          | 2 +-
>  2 files changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types.h
> index 1509a536cb85..5edba3122b10 100644
> --- a/include/net/page_pool/types.h
> +++ b/include/net/page_pool/types.h
> @@ -58,6 +58,8 @@ struct pp_alloc_cache {
>         netmem_ref cache[PP_ALLOC_CACHE_SIZE];
>  };
>
> +#define PAGE_POOL_MAX_RING_SIZE 16384
> +
>  /**
>   * struct page_pool_params - page pool parameters
>   * @fast:      params accessed frequently on hotpath
> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> index 1a5edec485f1..7b2808da294f 100644
> --- a/net/core/page_pool.c
> +++ b/net/core/page_pool.c
> @@ -211,7 +211,7 @@ static int page_pool_init(struct page_pool *pool,
>                 return -EINVAL;
>
>         if (pool->p.pool_size)
> -               ring_qsize = min(pool->p.pool_size, 16384);
> +               ring_qsize = min(pool->p.pool_size, PAGE_POOL_MAX_RING_SIZE);
>
>         /* DMA direction is either DMA_FROM_DEVICE or DMA_BIDIRECTIONAL.
>          * DMA_BIDIRECTIONAL is for allowing page used for DMA sending,
>
> base-commit: 327c20c21d80e0d87834b392d83ae73c955ad8ff
> --
> 2.51.2.1026.g39e6a42477-goog
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

