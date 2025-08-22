Return-Path: <linux-kernel+bounces-782683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49177B32390
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 22:26:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4E08682C8E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 20:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 220442D7DF1;
	Fri, 22 Aug 2025 20:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yylgeXSC"
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE5E92D7817
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 20:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755894345; cv=none; b=Ymxki2jHpBwtxj78NbQY0EnjcUEGuo8e5hN6M47IcFMLaRRsxBIFIDGDjC5yc6+YY+UyS2IEZOe9mtSbOwJgSmae2KUY6DnJ8uJfZnCVNbxU1JDyGl/UAdsv/T3LpdreMb7muDIoBl6VjUOpeyNGXo4PYdV9b8rUBWVewCT4bQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755894345; c=relaxed/simple;
	bh=VAV7N4y5pNAS0jZ5TBhEfldqKhwyq7wrJhDdA6aeLjM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UJkgtQCBUfjVU9Soja2Lb84ER608Z2wd4ga0YEsOU5Zd6hLNBjekR/hKTeAtjwaAkZ3o1y7DSj+t5gjsaxfx/pYp/Pt/VYH1WTCOmaVyYlRMUf0yoQrxTVfriM+h/2pllocsXh2rLpTri3jV+SJg24HLpqbuU972praJKwjLlbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yylgeXSC; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4b0bd88ab8fso67881cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 13:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755894342; x=1756499142; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lnLeUyDCv69RBYB1LT6B3iM9eFzgxTxAmCOD+3zz5xw=;
        b=yylgeXSCBGiER90ZvH4GURxtNZjKy/IEKDb27fUneh1VBK9R6jUdTVoIQkpDJ9qx18
         Nm81zyWuzPZXbVQnVrp+kbIyKB8gFMiGAiD5TFCcjpsbebYRtZC8Ss0ieNTppzxyA+Zg
         +IaG+FH8lOB79qJeee8KLn2sjpuXCmBFbK24vc1+ZCaBFQVErCT06rmVwOcd54Ml/gL6
         ot3TanAJNi+D89F3EkRS0IKo6k7EZsIiQrgHMUQtoWYNLJiTqKMnWgEqbIQturnw7kA0
         7r3MfseguCwIy0kxatEOKNPgq6zENec+lNMtOWVcBaXlTyzZMEufLnB2XL+ESsPW6FlM
         klMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755894342; x=1756499142;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lnLeUyDCv69RBYB1LT6B3iM9eFzgxTxAmCOD+3zz5xw=;
        b=iu1XdJxm+4gj9OBtCTcHd2SbNJvtIdrkuQRkRpguDGBVbEGjtoTyAMcPD4obGcTAQB
         KFvLMnULWnSLkhplmY5CfGtOuloZIJgQNrHIBN5KN0eZisZjb/Dy+8Nb8HkAgRFgAeCX
         78TTKkqx0T+E0Bl169KdZNKzGapPA2PkzW9JO9JKckusdvwCfr5octaklZiYepD/vyR4
         3ykBVjiEMc93tXc1zwH32F4yyf3bt7JaRMwNYlEFoXKzucLz3jUKN9K3M7mkGbLSSxoa
         pn5PEay+zWGQtgGT3v5HNe1RqlpNBK6u8NrXx9QSbmWnDOOFBvpDsvAdzqk8AXEk1IBk
         4DMA==
X-Forwarded-Encrypted: i=1; AJvYcCUX3QWsfZyRmcE4wwFD8JELIL7NaP38EGTrQKAXjWkYAccsxeR0I/POFFaQVxB4G6f9DjZBJ8cJyBUMO3c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUI1BAoy/sPWZC0syfEdKAicttRfbOoyFYLqgQPkz2Bmbhl61a
	G3YSjaOZZhhclKpyoOFcV/Xc00DOzsmh0MY/a3wQoVr53CN6TftlvnopOOiXe4m4C2O6GAS88Xh
	rrybNHo+PQVEZAxm13SD7mYVkVN6/3WGX6QM8M8qx
X-Gm-Gg: ASbGncuffQFLrEvgJhCMH03MXgnPSlxzjjSZD80eweZguH9C528Nqwgtega9BkGAz6D
	4nTDNKjJolWRmNmMC6/4QawSf2LgqCovs5mVHjakhxaza4si3LQOEqT13G+/CMP3hABm7OTmp5k
	8d5mtQi1Hh1P7PU0d7HFwpaW80dhQIugS/cNWk6q7ZzrpumhoXGw6iB4P7+FVDfBMONlQ/I0oVT
	DroSCtsgJQa
X-Google-Smtp-Source: AGHT+IHpcbSNYEbG4dMf2Ur+EvgyoAGIN6Q8D39CISAhHgiGDM6Pv/YSxa4huZIle8BMgUbZsNIx8jQJ2T56bctuf1U=
X-Received: by 2002:ac8:5885:0:b0:4b2:9b79:e700 with SMTP id
 d75a77b69052e-4b2ba6f09bdmr904771cf.4.1755894342112; Fri, 22 Aug 2025
 13:25:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250723-slub-percpu-caches-v5-0-b792cd830f5d@suse.cz> <20250723-slub-percpu-caches-v5-13-b792cd830f5d@suse.cz>
In-Reply-To: <20250723-slub-percpu-caches-v5-13-b792cd830f5d@suse.cz>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 22 Aug 2025 13:25:31 -0700
X-Gm-Features: Ac12FXwIfUzsXFwXr2_zQQKQgHFazg_c-46Y0QfxCWOo6vu0LHzTb5q0mxFp2Dg
Message-ID: <CAJuCfpEjaw+4Ay-Yx=unHev+M4M9FmNmz_PSYmtsFn3EToLBxg@mail.gmail.com>
Subject: Re: [PATCH v5 13/14] maple_tree: Add single node allocation support
 to maple state
To: Vlastimil Babka <vbabka@suse.cz>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Christoph Lameter <cl@gentwo.org>, 
	David Rientjes <rientjes@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Harry Yoo <harry.yoo@oracle.com>, Uladzislau Rezki <urezki@gmail.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org, 
	maple-tree@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 23, 2025 at 6:35=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
>
> The fast path through a write will require replacing a single node in
> the tree.  Using a sheaf (32 nodes) is too heavy for the fast path, so
> special case the node store operation by just allocating one node in the
> maple state.
>
> Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  include/linux/maple_tree.h |  4 +++-
>  lib/maple_tree.c           | 47 ++++++++++++++++++++++++++++++++++++++++=
------
>  2 files changed, 44 insertions(+), 7 deletions(-)
>
> diff --git a/include/linux/maple_tree.h b/include/linux/maple_tree.h
> index 3cf1ae9dde7ce43fa20ae400c01fefad048c302e..61eb5e7d09ad0133978e3ac4b=
2af66710421e769 100644
> --- a/include/linux/maple_tree.h
> +++ b/include/linux/maple_tree.h
> @@ -443,6 +443,7 @@ struct ma_state {
>         unsigned long min;              /* The minimum index of this node=
 - implied pivot min */
>         unsigned long max;              /* The maximum index of this node=
 - implied pivot max */
>         struct slab_sheaf *sheaf;       /* Allocated nodes for this opera=
tion */
> +       struct maple_node *alloc;       /* allocated nodes */
>         unsigned long node_request;
>         enum maple_status status;       /* The status of the state (activ=
e, start, none, etc) */
>         unsigned char depth;            /* depth of tree descent during w=
rite */
> @@ -491,8 +492,9 @@ struct ma_wr_state {
>                 .status =3D ma_start,                                    =
 \
>                 .min =3D 0,                                              =
 \
>                 .max =3D ULONG_MAX,                                      =
 \
> -               .node_request=3D 0,                                      =
 \
>                 .sheaf =3D NULL,                                         =
 \
> +               .alloc =3D NULL,                                         =
 \
> +               .node_request=3D 0,                                      =
 \
>                 .mas_flags =3D 0,                                        =
 \
>                 .store_type =3D wr_invalid,                              =
 \
>         }
> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> index 3c3c14a76d98ded3b619c178d64099b464a2ca23..9aa782b1497f224e7366ebbd6=
5f997523ee0c8ab 100644
> --- a/lib/maple_tree.c
> +++ b/lib/maple_tree.c
> @@ -1101,16 +1101,23 @@ static int mas_ascend(struct ma_state *mas)
>   *
>   * Return: A pointer to a maple node.
>   */
> -static inline struct maple_node *mas_pop_node(struct ma_state *mas)
> +static __always_inline struct maple_node *mas_pop_node(struct ma_state *=
mas)
>  {
>         struct maple_node *ret;
>
> +       if (mas->alloc) {
> +               ret =3D mas->alloc;
> +               mas->alloc =3D NULL;
> +               goto out;
> +       }
> +
>         if (WARN_ON_ONCE(!mas->sheaf))
>                 return NULL;
>
>         ret =3D kmem_cache_alloc_from_sheaf(maple_node_cache, GFP_NOWAIT,=
 mas->sheaf);
> -       memset(ret, 0, sizeof(*ret));
>
> +out:
> +       memset(ret, 0, sizeof(*ret));
>         return ret;
>  }
>
> @@ -1121,9 +1128,34 @@ static inline struct maple_node *mas_pop_node(stru=
ct ma_state *mas)
>   */
>  static inline void mas_alloc_nodes(struct ma_state *mas, gfp_t gfp)
>  {
> -       if (unlikely(mas->sheaf)) {
> -               unsigned long refill =3D mas->node_request;
> +       if (!mas->node_request)
> +               return;
> +
> +       if (mas->node_request =3D=3D 1) {
> +               if (mas->sheaf)
> +                       goto use_sheaf;
> +
> +               if (mas->alloc)
> +                       return;
>
> +               mas->alloc =3D mt_alloc_one(gfp);
> +               if (!mas->alloc)
> +                       goto error;
> +
> +               mas->node_request =3D 0;
> +               return;
> +       }
> +
> +use_sheaf:
> +       if (unlikely(mas->alloc)) {

When would this condition happen? Do we really need to free mas->alloc
here or it can be reused for the next 1-node allocation?

> +               mt_free_one(mas->alloc);
> +               mas->alloc =3D NULL;
> +       }
> +
> +       if (mas->sheaf) {
> +               unsigned long refill;
> +
> +               refill =3D mas->node_request;
>                 if(kmem_cache_sheaf_size(mas->sheaf) >=3D refill) {
>                         mas->node_request =3D 0;
>                         return;
> @@ -5386,8 +5418,11 @@ void mas_destroy(struct ma_state *mas)
>         mas->node_request =3D 0;
>         if (mas->sheaf)
>                 mt_return_sheaf(mas->sheaf);
> -
>         mas->sheaf =3D NULL;
> +
> +       if (mas->alloc)
> +               mt_free_one(mas->alloc);
> +       mas->alloc =3D NULL;
>  }
>  EXPORT_SYMBOL_GPL(mas_destroy);
>
> @@ -6074,7 +6109,7 @@ bool mas_nomem(struct ma_state *mas, gfp_t gfp)
>                 mas_alloc_nodes(mas, gfp);
>         }
>
> -       if (!mas->sheaf)
> +       if (!mas->sheaf && !mas->alloc)
>                 return false;
>
>         mas->status =3D ma_start;
>
> --
> 2.50.1
>

