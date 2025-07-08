Return-Path: <linux-kernel+bounces-721477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 33DA5AFC9BE
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 13:40:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84F7E189FD54
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 11:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE32B2D9ECD;
	Tue,  8 Jul 2025 11:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mU0sxF4N"
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A1A2285C87
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 11:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751974796; cv=none; b=UcFJwdiyaH6l/ZH7w1xALEBng1DNkm4eFQLGNxCCd5iI9iVZDAQFIhSyN1TW9dN5m1oq9X0mxj844GAXATa2OTn41FQ7OVk+iWNwBQ5SoJfgpBiIkd3RPVsGqwifKYdsDgZVyGa6HTk4y/Mhk69t08ioX+aQ2tOX2RMfyShF1Rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751974796; c=relaxed/simple;
	bh=anrcJkhR0K2UFvABRyTbtjlESGIkubeRDAlquXXlVdc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FMSByhknh/XrMpWmcJSiXJ5muaFxttWClEQxHXUC1geF/7+tkOhlN/YZll2cY85aq2Q+gQ4Z2JWFwRfMutNldzm4oHj7ujThokOTbojHBF59wGqK5IzqmLu2wn+lFOo3Q0HGREzm9ZarbwGWSUy/Dk/Ry9Lnclz5M0o/+0NJqaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mU0sxF4N; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-71173646662so37748297b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 04:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1751974793; x=1752579593; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9eMeJVMzIthoABLN3c573S0lEtUCztks52HyLR1vSyo=;
        b=mU0sxF4N67OcXvp/G/I8hXBR7tQ5dePAp5fFejtXyB18qBhn/5ajMQM4YAtY7O5gwW
         duOkHtuGmVBebZJxrxRC4INqFuXxxGk+QJo938rJpOy6redeRnw7dgVwKgw2a7HuSDTW
         Jx5Xfuvbj1HeqhotaCq3IPWQXSnOLOFVKhj/ydYGhBvpAV3eXnxWDasjkHmqPOV/v1+1
         0BSqQNHuoFxP1mVcffcUpBuE+8FQgpxePn4b8kI6Mmh9IBPORvyVFYg54eOP68B1Z7kb
         FcPWr8OCKwSqhVCI0lIt+mxIHuQRvuxyClGM8HX5Y3mxbOFFrJd7YG+Us953IVCvEDOH
         Y3mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751974793; x=1752579593;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9eMeJVMzIthoABLN3c573S0lEtUCztks52HyLR1vSyo=;
        b=BKv+BrwnN3T5ZkFizdAzwBPiFqXUaYGnVda1gnULGJ4V3oiSs60eXw7LxJ3jhPz/2L
         uy1rA0qWtLAkBanCh6+l3MjxPH0rthdOPh1iWHCeYGEB9KqkGzGVZSEGMVr9Cg6IvEMv
         3vpRb1y76jXvwvCXq8bn/xs2NY9UHFtQLuhpW4n0ih1j1Yhk0XuJhdZ0vieS0GeOlebs
         dNdPtTuRsYtrevu0VeWgWBT9hiBhqQHsOGBMcDcvpQybrOU7rXhL8yYLSNcobZbMPEvw
         X0cIU7y4nBiQPUk9nLa1oLIk6TYlptxMFjipjDilmmk7DSWQu8MXcdP4Iaj6EZ3x+Fkx
         3tlw==
X-Forwarded-Encrypted: i=1; AJvYcCV3WqBpWmBM0eD2zp0wbVjfQpgcCqbCR21ggFxwPeYZDYGa2LTEcbAj5OrIsCilQIDgU9RSLa4VOesZOxU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLjfOXNLkPhDpVB+AEE2HV9W8dv31xOLu7gAFB2tdUeY2vd7CP
	NRtHyKJJrwO6TqlYIs1cisE5hxiC6L5NSoK31og7e3/fCt6t3d5HKm5mQanyfYkybMs8frIXSuR
	hcf+TT+mlXDgQ3YfAmJ/c3JC0rxHlf6/hf7mKgWWivw==
X-Gm-Gg: ASbGncsbG2RbkWqytZ74mbNxvLtrBRPDNEwxHrouATTSvAKby9/LsqBMYtTx42bAgHZ
	QqUp37Lua5wPmVrjTW+PdpyHyN6o1F1uRUqqqIBWB6/UZkGY7wuqolgN/etTfVIEcPrbbdB5wVM
	dlKHRqD5bOQqxENnkhEKhtDTXWE180izppVtldlwCObDI=
X-Google-Smtp-Source: AGHT+IG6kwwi/O1JpxJQzqce7OC4YlDVtNrzWESKs36ZU9aEADMh6ZKR839SIoeejlL3CWzFXOhNldDkEPqgFZcBnJY=
X-Received: by 2002:a05:690c:dc7:b0:70e:6105:2360 with SMTP id
 00721157ae682-71668deda5amr227576207b3.24.1751974793396; Tue, 08 Jul 2025
 04:39:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250702053256.4594-1-byungchul@sk.com> <20250702053256.4594-4-byungchul@sk.com>
In-Reply-To: <20250702053256.4594-4-byungchul@sk.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 8 Jul 2025 14:39:16 +0300
X-Gm-Features: Ac12FXwbisTy0vRZbr1dnSDkZ4VZxeOs9_WADPGLv9-1kgfrQv9Qj4QdZfgR36o
Message-ID: <CAC_iWj+mOqEfyanEk52Y7Pw4zMs_tZbES=5xBV7AfAG-nTUPpw@mail.gmail.com>
Subject: Re: [PATCH net-next v8 3/5] page_pool: rename __page_pool_alloc_pages_slow()
 to __page_pool_alloc_netmems_slow()
To: Byungchul Park <byungchul@sk.com>
Cc: willy@infradead.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, kernel_team@skhynix.com, kuba@kernel.org, 
	almasrymina@google.com, harry.yoo@oracle.com, hawk@kernel.org, 
	akpm@linux-foundation.org, davem@davemloft.net, john.fastabend@gmail.com, 
	andrew+netdev@lunn.ch, asml.silence@gmail.com, toke@redhat.com, 
	tariqt@nvidia.com, edumazet@google.com, pabeni@redhat.com, saeedm@nvidia.com, 
	leon@kernel.org, ast@kernel.org, daniel@iogearbox.net, david@redhat.com, 
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz, 
	rppt@kernel.org, surenb@google.com, mhocko@suse.com, horms@kernel.org, 
	linux-rdma@vger.kernel.org, bpf@vger.kernel.org, vishal.moola@gmail.com, 
	hannes@cmpxchg.org, ziy@nvidia.com, jackmanb@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2 Jul 2025 at 08:33, Byungchul Park <byungchul@sk.com> wrote:
>
> Now that __page_pool_alloc_pages_slow() is for allocating netmem, not
> struct page, rename it to __page_pool_alloc_netmems_slow() to reflect
> what it does.
>
> Signed-off-by: Byungchul Park <byungchul@sk.com>
> Reviewed-by: Mina Almasry <almasrymina@google.com>
> Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> ---

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

>  net/core/page_pool.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> index 95ffa48c7c67..05e2e22a8f7c 100644
> --- a/net/core/page_pool.c
> +++ b/net/core/page_pool.c
> @@ -544,8 +544,8 @@ static struct page *__page_pool_alloc_page_order(stru=
ct page_pool *pool,
>  }
>
>  /* slow path */
> -static noinline netmem_ref __page_pool_alloc_pages_slow(struct page_pool=
 *pool,
> -                                                       gfp_t gfp)
> +static noinline netmem_ref __page_pool_alloc_netmems_slow(struct page_po=
ol *pool,
> +                                                         gfp_t gfp)
>  {
>         const int bulk =3D PP_ALLOC_CACHE_REFILL;
>         unsigned int pp_order =3D pool->p.order;
> @@ -615,7 +615,7 @@ netmem_ref page_pool_alloc_netmems(struct page_pool *=
pool, gfp_t gfp)
>         if (static_branch_unlikely(&page_pool_mem_providers) && pool->mp_=
ops)
>                 netmem =3D pool->mp_ops->alloc_netmems(pool, gfp);
>         else
> -               netmem =3D __page_pool_alloc_pages_slow(pool, gfp);
> +               netmem =3D __page_pool_alloc_netmems_slow(pool, gfp);
>         return netmem;
>  }
>  EXPORT_SYMBOL(page_pool_alloc_netmems);
> --
> 2.17.1
>

