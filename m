Return-Path: <linux-kernel+bounces-792284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF434B3C24A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 20:14:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB2734631AE
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 18:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D48E932A3C7;
	Fri, 29 Aug 2025 18:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dadxvsEd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A10B275B18
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 18:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756491269; cv=none; b=j49ag3ELfVjplNVL7rhBkyMkV9ldzXZ3GeGLgA6BCmQOs3eebctw3v5/o05O/rrKUX1J3hYfl3Cj6xQcmolws1VMW/NFSMSsyHzo06pDTx2WBS89gMQuhiUfSJNkP66/Y1Njr9ftfsqfV3QG9JFo+lUc1NKbZB/nWQX1pDJTFmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756491269; c=relaxed/simple;
	bh=yRJt+TegNK6W+502znezjR7f/M/raLPdTP7KKYAHCIk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nhzbE/Wohf0yhO/JL8UxF6YUKXXPAHOFOMvCblgTJNiJ3iPhRIPGG2vohgO7l5y7VrrDy7ZuESUzqv639/om5t+HKBfPSXsMyCMYc/age5oDCTmEGcTxwzwcO6BvaVcgxbjZAbeJcURG7gE0KmiG87Le4ojw44orms2MYnaIxP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dadxvsEd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8977C4CEFE
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 18:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756491268;
	bh=yRJt+TegNK6W+502znezjR7f/M/raLPdTP7KKYAHCIk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=dadxvsEdsUz03D4KiiBUc6rnx4w9CKtysKQ2Eg9I2yOwV2Lcyincoq9j7MNXm1TkO
	 Zc3GbMvM5v8gf3EWbLMzooNOltkGZxXWhRG5oKXrjdCTiO+uqvwJvm9T71MC7LSu7w
	 eVYSi01LnVrJphozAp7EF6+LOQoNSpruXRtbdg9w07IuFW2PaPgPdC1wSKxmTKCXr5
	 ZN211+cuxW5DyUHCOyh8IpxP8detqr/QJ7FedvATGKPfAE25V0X/SNZHaDC0yfQ9m3
	 Wz/vRB3u50epHjtJ0ea+00Lh19KZWWEW2XwWB75ei9hYbR12dQu/ypiTmjnZUo25E6
	 Sg04yo+wZ0CAQ==
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-45b72f7f606so3435e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 11:14:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWVjP+WlniqmsOvjbESm2GGZTSO+60RmAbuWzq2hVd6XfN1io4vcmvU0WJPzOic9bMW84ATxh5gvWAgETY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPZ+LanpTdAGyB9KnoMXyp8/k6kcMe0MSxP53Ah+5coBHqPVNP
	G/yfV355/abzsYhsV7kkVBHTxYVVUDa3eNmvRgYAh9RTfP/dtV2BLqln6rZ3fxTaZvmSLzG8iGT
	a5STngu93w86gnJgxpEwa7OY7nzDB1DDwsvwbHMZu
X-Google-Smtp-Source: AGHT+IGMRQV1XZsQIwrNNqTDZtdRqBuWEXIqyZMGeqwYHLrc/h6k2Q/Qn1Z0+Fezw7s/S13TR4rhAli8suotYoqiEqU=
X-Received: by 2002:a05:600c:8906:b0:45a:2861:3625 with SMTP id
 5b1f17b1804b1-45b84b4a04fmr43005e9.4.1756491267267; Fri, 29 Aug 2025 11:14:27
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACePvbXnaWZh61aH=BHoGDqbKvBSE52Me+PpE-WMXcGpRy0FFw@mail.gmail.com>
 <20250828163913.57957-1-sj@kernel.org>
In-Reply-To: <20250828163913.57957-1-sj@kernel.org>
From: Chris Li <chrisl@kernel.org>
Date: Fri, 29 Aug 2025 11:14:15 -0700
X-Gmail-Original-Message-ID: <CAF8kJuNFEc6GpjzrTAF59jU7Z9OiGujqHm3086aUhG+Y141iyw@mail.gmail.com>
X-Gm-Features: Ac12FXwUslqnoCOE6vybxi7aGMsQj_ykVBv57KBSkgX6Y5hLisalD99VAYpNJHY
Message-ID: <CAF8kJuNFEc6GpjzrTAF59jU7Z9OiGujqHm3086aUhG+Y141iyw@mail.gmail.com>
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

Acked-by: Chris Li <chrisl@kernel.org>

Chris

On Thu, Aug 28, 2025 at 9:39=E2=80=AFAM SeongJae Park <sj@kernel.org> wrote=
:
>
> On Wed, 27 Aug 2025 14:16:37 -0700 Chris Li <chrisl@kernel.org> wrote:
>
> > On Wed, Aug 27, 2025 at 10:45=E2=80=AFAM SeongJae Park <sj@kernel.org> =
wrote:
> [...]
> > Anyway, I just opened the editor to check again. Yes, if we goto the
> > read_done, the if condition using dlen can introduce a new incoming
> > edge that has len uninitialized value to be used. Yes, need to
> > initialize dlen =3D PAGE_SIZE or you initialize it at the memcpy of
> > page.
>
> Thank you for confirming.
>
> >
> > > I will post the fixup by tomorrow morning (Pacific time) unless I
> > > hear other opinions or find my mistakes on the above plan by tonight.
> >
> > You are too humble, that is the normal reviewing process. You can take
> > your time.
>
> No worry, I just wanted to give you an expectation of the time line :)
>
> Andrew, could you please pick the below attached cleanup patch as a fixup=
 of
> the original patch?  Please feel free to let me know if you prefer postin=
g a
> new version of the patch instead or any other approach.
>
>
> Thanks,
> SJ
>
> [...]
>
> =3D=3D=3D=3D Attachment 0 (0001-mm-zswap-cleanup-incompressible-pages-han=
dling-code.patch) =3D=3D=3D=3D
> From 867c3789fa80ac163427f1d7804bf2c8667684ca Mon Sep 17 00:00:00 2001
> From: SeongJae Park <sj@kernel.org>
> Date: Wed, 27 Aug 2025 13:18:38 -0700
> Subject: [PATCH] mm/zswap: cleanup incompressible pages handling code
>
> Following Chris Li's suggestions[1], make the code easier to read and
> manage.
>
> [1] https://lore.kernel.org/CACePvbWGPApYr7G29FzbmWzRw-BJE39WH7kUHSaHs+Ln=
w8=3D-qQ@mail.gmail.com
>
> Signed-off-by: SeongJae Park <sj@kernel.org>
> Acked-by: Chris Li <chrisl@kernel.org>
> ---
>  mm/zswap.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/mm/zswap.c b/mm/zswap.c
> index f865a930dc88..e5e1f5687f5e 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -952,6 +952,7 @@ static bool zswap_compress(struct page *page, struct =
zswap_entry *entry,
>         struct zpool *zpool;
>         gfp_t gfp;
>         u8 *dst;
> +       bool mapped =3D false;
>
>         acomp_ctx =3D acomp_ctx_get_cpu_lock(pool);
>         dst =3D acomp_ctx->buffer;
> @@ -983,9 +984,8 @@ static bool zswap_compress(struct page *page, struct =
zswap_entry *entry,
>          * only adds metadata overhead.  swap_writeout() will put the pag=
e back
>          * to the active LRU list in the case.
>          */
> -       if (comp_ret || !dlen)
> +       if (comp_ret || !dlen || dlen >=3D PAGE_SIZE) {
>                 dlen =3D PAGE_SIZE;
> -       if (dlen >=3D PAGE_SIZE) {
>                 if (!mem_cgroup_zswap_writeback_enabled(
>                                         folio_memcg(page_folio(page)))) {
>                         comp_ret =3D comp_ret ? comp_ret : -EINVAL;
> @@ -994,6 +994,7 @@ static bool zswap_compress(struct page *page, struct =
zswap_entry *entry,
>                 comp_ret =3D 0;
>                 dlen =3D PAGE_SIZE;
>                 dst =3D kmap_local_page(page);
> +               mapped =3D true;
>         }
>
>         zpool =3D pool->zpool;
> @@ -1007,7 +1008,7 @@ static bool zswap_compress(struct page *page, struc=
t zswap_entry *entry,
>         entry->length =3D dlen;
>
>  unlock:
> -       if (dst !=3D acomp_ctx->buffer)
> +       if (mapped)
>                 kunmap_local(dst);
>         if (comp_ret =3D=3D -ENOSPC || alloc_ret =3D=3D -ENOSPC)
>                 zswap_reject_compress_poor++;
> @@ -1025,7 +1026,7 @@ static bool zswap_decompress(struct zswap_entry *en=
try, struct folio *folio)
>         struct zpool *zpool =3D entry->pool->zpool;
>         struct scatterlist input, output;
>         struct crypto_acomp_ctx *acomp_ctx;
> -       int decomp_ret, dlen;
> +       int decomp_ret =3D 0, dlen =3D PAGE_SIZE;
>         u8 *src, *obj;
>
>         acomp_ctx =3D acomp_ctx_get_cpu_lock(entry->pool);
> @@ -1034,9 +1035,7 @@ static bool zswap_decompress(struct zswap_entry *en=
try, struct folio *folio)
>         /* zswap entries of length PAGE_SIZE are not compressed. */
>         if (entry->length =3D=3D PAGE_SIZE) {
>                 memcpy_to_folio(folio, 0, obj, entry->length);
> -               zpool_obj_read_end(zpool, entry->handle, obj);
> -               acomp_ctx_put_unlock(acomp_ctx);
> -               return true;
> +               goto read_done;
>         }
>
>         /*
> @@ -1059,6 +1058,7 @@ static bool zswap_decompress(struct zswap_entry *en=
try, struct folio *folio)
>         decomp_ret =3D crypto_wait_req(crypto_acomp_decompress(acomp_ctx-=
>req), &acomp_ctx->wait);
>         dlen =3D acomp_ctx->req->dlen;
>
> +read_done:
>         zpool_obj_read_end(zpool, entry->handle, obj);
>         acomp_ctx_put_unlock(acomp_ctx);
>
> --
> 2.39.5
>
>

