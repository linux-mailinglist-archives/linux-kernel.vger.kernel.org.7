Return-Path: <linux-kernel+bounces-786952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6AE5B36F36
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 18:01:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AD33560E02
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 15:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F1883705B8;
	Tue, 26 Aug 2025 15:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eICtvr42"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF11D3705AC
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 15:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756223567; cv=none; b=F7+fTyWvFSVqF0FFU3yHu3NdG18b22ivus3rmRyP0Y/YrJ3zLMul3KEKTJTJDdAfscawWmNxEYhp5IK+tNUnqSkRHFIU+Po27+KIqOVrvtn0xHx6ieKUJf6YFvM0PDbkOncKiQ/HE1JodZ/jjhVJ9QDfPdCLcdi/3LFS4lmgSC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756223567; c=relaxed/simple;
	bh=KlCX2ZAg3q9wXdpobKxP0hTMgzjtmi46Iu31yrKbqwU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jSXEDuz6dqm4rpXDqmfjEGPPXIIk6cxPwnp7w0D/pIOJ3t1AwRluPW7SSDNYnzCfLu+4ymXaXcBicMo52TROIPugBYvnz97nYISR5PUfdd3Q1uzEkRg9un3CD6hPaMaQlMiNch7qVmCjaSiriCJyvtpmkeBvcjf93SZeg2gpk6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eICtvr42; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4004EC19421
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 15:52:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756223567;
	bh=KlCX2ZAg3q9wXdpobKxP0hTMgzjtmi46Iu31yrKbqwU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=eICtvr42+J6+hYy2n8SDMDC1z3zNCoxeqOTdMYcsn2C9fBF8bCDufrhEFccejYFTL
	 2RNLzgOMCxWWiBqNMAOf6PEcH2fdv/ujIQMmztUK/UzOr8nfPImucZSB4tY1ftD5Xr
	 nxICBgGbZry+1RjKD3hyL/xyx/hoIwR4DGOgIynMZJ1BtBcjb3qgMO69Elm3mANkCV
	 zMf/sB55dut2S236PlDgbuMO7mAaYKIbHX+bWZbePExXoTe3atJrjxgCPPp5NArMog
	 s4YPNvVQG0DYYhDGxV3VTDaSwYKW6ZKXSvmLaR9betcSjOWI36W2gUurhcuDiccz75
	 vzs6FqHxTRy+A==
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e95380515bbso27369276.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 08:52:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUbV4GMGvInhaq1RqNCMlz+XtYxxf91/c+pXy2ove0lJCgn67ijarcB4ezTBO9S3KBjnkdUa6zLsLoRNws=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcpVb5xGnc6eZy8GSOZulaX0CpBKI/Vv/G7V0aY9Pt3gsF02iE
	QQgz8DBbdzwMFsQWb17cDDJIKl8BP3ITFUwUBA3VSMiNivI1bAxj3lQSAIHo6GTdzk+wGZMuZ70
	oaTMWvEdnF3lCbNJuMcQaSp3jwHKNo5PQhr1Mx+KoIA==
X-Google-Smtp-Source: AGHT+IEUMBoKAajA3iPBlepraJu69j4X8I0cRpMBfb6hpiggMTLtkGAy21vMq+d6fJmi2pqGEb2XkUE6TJQCFdkAvb4=
X-Received: by 2002:a25:dc04:0:b0:e94:fc8c:e1f6 with SMTP id
 3f1490d57ef6-e96e4792fadmr1443812276.5.1756223566425; Tue, 26 Aug 2025
 08:52:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822190817.49287-1-sj@kernel.org>
In-Reply-To: <20250822190817.49287-1-sj@kernel.org>
From: Chris Li <chrisl@kernel.org>
Date: Tue, 26 Aug 2025 08:52:35 -0700
X-Gmail-Original-Message-ID: <CACePvbWGPApYr7G29FzbmWzRw-BJE39WH7kUHSaHs+Lnw8=-qQ@mail.gmail.com>
X-Gm-Features: Ac12FXw9oMrwmMyOSTPZuCI29-0riX1CqHTxB7pbY4dMbsclAlSATWgfgwigVXk
Message-ID: <CACePvbWGPApYr7G29FzbmWzRw-BJE39WH7kUHSaHs+Lnw8=-qQ@mail.gmail.com>
Subject: Re: [PATCH v5] mm/zswap: store <PAGE_SIZE compression failed page as-is
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Chengming Zhou <chengming.zhou@linux.dev>, 
	Herbert Xu <herbert@gondor.apana.org.au>, Johannes Weiner <hannes@cmpxchg.org>, 
	Nhat Pham <nphamcs@gmail.com>, Yosry Ahmed <yosry.ahmed@linux.dev>, kernel-team@meta.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Takero Funaki <flintglass@gmail.com>, David Hildenbrand <david@redhat.com>, Baoquan He <bhe@redhat.com>, 
	Barry Song <baohua@kernel.org>, Kairui Song <kasong@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi SeongJae,

I did another pass review on it. This time with the editor so I saw
more source code context and had more feedback.
Mostly just nitpicks. See the detailed comments below.

On Fri, Aug 22, 2025 at 12:08=E2=80=AFPM SeongJae Park <sj@kernel.org> wrot=
e:
> @@ -971,8 +975,26 @@ static bool zswap_compress(struct page *page, struct=
 zswap_entry *entry,
>          */
>         comp_ret =3D crypto_wait_req(crypto_acomp_compress(acomp_ctx->req=
), &acomp_ctx->wait);
>         dlen =3D acomp_ctx->req->dlen;
> -       if (comp_ret)
> -               goto unlock;
> +
> +       /*
> +        * If a page cannot be compressed into a size smaller than PAGE_S=
IZE,
> +        * save the content as is without a compression, to keep the LRU =
order
> +        * of writebacks.  If writeback is disabled, reject the page sinc=
e it
> +        * only adds metadata overhead.  swap_writeout() will put the pag=
e back
> +        * to the active LRU list in the case.
> +        */
> +       if (comp_ret || !dlen)
> +               dlen =3D PAGE_SIZE;
> +       if (dlen >=3D PAGE_SIZE) {

I think these two if can be simplify as:

if (comp_ret || !dlen || dlen >=3D PAGE_SIZE) {
              dlen =3D PAGE_SIZE;

then you do the following check.
That way when goto unlock happens, you have dlen =3D=3D PAGE_SIZE related
to my other feedback in kunmap_local()

> +               if (!mem_cgroup_zswap_writeback_enabled(
> +                                       folio_memcg(page_folio(page)))) {
> +                       comp_ret =3D comp_ret ? comp_ret : -EINVAL;
> +                       goto unlock;
> +               }
> +               comp_ret =3D 0;
> +               dlen =3D PAGE_SIZE;

Delete this line if you use the above suggestion on: dlen =3D PAGE_SIZE;

> +               dst =3D kmap_local_page(page);
> +       }
>
>         zpool =3D pool->zpool;
>         gfp =3D GFP_NOWAIT | __GFP_NORETRY | __GFP_HIGHMEM | __GFP_MOVABL=
E;
> @@ -985,6 +1007,8 @@ static bool zswap_compress(struct page *page, struct=
 zswap_entry *entry,
>         entry->length =3D dlen;
>
>  unlock:
> +       if (dst !=3D acomp_ctx->buffer)
> +               kunmap_local(dst);

I think this has a hidden assumption that kmap_local_page() will
return a different value than acomp_ctx->buffer. That might be true. I
haven't checked the internals. Otherwise you are missing a
kunmap_local(). It also looks a bit strange in the sense that
kumap_local() should be paired with kmap_local_page() in the same
condition. The same condition is not obvious here. How about this to
make it more obvious and get rid of that assumption above:

if (dlen =3D=3D PAGE_SIZE)
               kunmap_local(dst);

That assumes you also take my suggestion above to assign dlen =3D
PAGE_SIZE earlier.


>         if (comp_ret =3D=3D -ENOSPC || alloc_ret =3D=3D -ENOSPC)
>                 zswap_reject_compress_poor++;
>         else if (comp_ret)
> @@ -1007,6 +1031,14 @@ static bool zswap_decompress(struct zswap_entry *e=
ntry, struct folio *folio)
>         acomp_ctx =3D acomp_ctx_get_cpu_lock(entry->pool);
>         obj =3D zpool_obj_read_begin(zpool, entry->handle, acomp_ctx->buf=
fer);
>
> +       /* zswap entries of length PAGE_SIZE are not compressed. */
> +       if (entry->length =3D=3D PAGE_SIZE) {
> +               memcpy_to_folio(folio, 0, obj, entry->length);

The following read_end() followed by acomp unlock() duplicates the
normal decompress ending sequence. It will create complications when
we modify the normal ending sequence in the future, we need to match
it here.How about just goto the ending sequence and share the same
return path as normal:

 +                  goto read_done;

Then insert the read_done label at ending sequence:

        dlen =3D acomp_ctx->req->dlen;

+ read_done:
        zpool_obj_read_end(zpool, entry->handle, obj);
        acomp_ctx_put_unlock(acomp_ctx);

If you adopt that, you also will need to init the comp_ret to "0"
instead of no init value in the beginning of the function:

        struct crypto_acomp_ctx *acomp_ctx;
-        int decomp_ret, dlen;
+       int decomp_ret =3D 0, dlen;
        u8 *src, *obj;


> +               zpool_obj_read_end(zpool, entry->handle, obj);
> +               acomp_ctx_put_unlock(acomp_ctx);
> +               return true;

Delete the above 3 lines inside uncompress if case.

Looks good otherwise.

Thanks for the good work.

Chris

