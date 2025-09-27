Return-Path: <linux-kernel+bounces-834767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3401BA5784
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 03:09:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2E7E1C2477D
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 01:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC1111E5B64;
	Sat, 27 Sep 2025 01:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ied4C/2g"
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 033701B6CE9
	for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 01:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758935334; cv=none; b=itWeWwE/2ck4FPe2qiLMReZR+OHxjLnTDhHOWlwpbjIUgMVVCePCpvoApOHPV1Yl8y2vbCJ82Ee5pABSynfoYtY9KDYDyUPe5MhURynrsJFJm+QjJuA6r3xmHw/7Sve2CrAWZHDa5E3UDI2v9uTu+sg10Ch7vfbcb5bdGvcR1XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758935334; c=relaxed/simple;
	bh=MNNAN9gtZ8qnFN/sruAI8/m7CzvcfuE1W5uNk1889s8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lZpNcIpZ1uKsBCwxl1KZE6xnjWIgpGqSulYot+YHGnVRWUIdYxw5NLKclqfhj/IXfXAXbg+SKeVIDlU6lfIl3FMbUc3EhbSZuB3ApiuC9OdL/vWPz0cDsGCUqiv2o/LY4GlJulT1duY1j4esR3MaO5N9lSkPm+r3JcADFBpCAG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ied4C/2g; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4de66881569so156861cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 18:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758935331; x=1759540131; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1dEX25s4Fwys/kwxBH9Kih0HT2qF6vqcdExnhHAEAZM=;
        b=ied4C/2gzGGQXdY6C5nc3FXMtJMjCFcUtzSo866Zsii0GsEQu75G54QiUiDOru0W+N
         SDDLy9Zb39hGHUMSG6pqmfDC8ZE+/AMUO/OEsbJiryI959GX/QXCQSXvbiX07UVxfn6l
         cegmaYb5Om56DUSOVcRGGIuyVK0Qg4cw01WzJLbpgli0G+vA+6/k6Ka7hdCVK3v6b04J
         Uf7jhcMO6Hrok2ojSv5lL2QTegEiwIjGtFtlMzjSdFdXPa+B3xhZ2MqaMqvb9J8xw24n
         SaUqnFkjI/4KKvl0FYtFXqcNWgRz1kFOG/7UnWhYrMvotLTiAZ2+Zr7uAWim2LYksf/V
         ic2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758935331; x=1759540131;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1dEX25s4Fwys/kwxBH9Kih0HT2qF6vqcdExnhHAEAZM=;
        b=Ng5TJF2ootTvTKlHjeOhWf5uNgB0HyTWh2FHjpVXtzEMtLWFexx2zO7F2/v4P/am1Z
         NI4Ol7xbxSzWM1bacoLfnAOg0o2HfTABZXZDgCx2JFw5QTFcBdx9BJO00ZfU1SXHrcgp
         L3xUFFBFZKNyvSmvqwo5lalgkegRX/8FIenYIHaWLahyoA8jlkdoczw9I+yf+3sQzkKo
         5WzStNjVrU+igi537JmwF1tV2wmUDcZNMA0q7gP0TxK7yoeVGcWaIDLr13Dhdot1cUlG
         jpBPr2XnmpwSa0jTMNZk/HhvidnG/N3unDATO6YUznbU8CZusdBrnxzCJbJMLolsNZIW
         1JJA==
X-Forwarded-Encrypted: i=1; AJvYcCXTtYeNmMm7YND45qY1IK4P3tS/RzswxjzdLSdhHK/5aQDfY+7SKbVc0fsW/sygqX0Qrfe2zwfRpx92GyA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCq8dpHsb44vif01u2owv0x1u9YjjFZ9eGfvIBWMjQOFlALKGy
	vpzO5rNiAQHi7uONXmxPJl38sVou1mBzxoQprnpSBUDJhz82bkNz0GyGfr5cx2KnlG+lJi+DoQD
	Ljw4ctSK99FnjTCtAcjpSWw2NMnxoWdp60zMwFf/nyfEcob77CMyoIZRU
X-Gm-Gg: ASbGncuZFhT3oHfg81zL+nsdpIZDhovwZAJXrFhUZbyTTISr391pD/D5/6+lUjAJqkV
	2fKAWcmJU3yPxHvH0q2dRRyDZ8DtPePX/QBSIwukwdueiF/ZKVYLUHTjidW0V4u/nrr1LkSzRPJ
	kRH21nXDF3bayL9thYH7W8wyVWwpcp1TuyyqKbDkwAHDlLQGwE/Kj6Jci8+JeDWjQfNh+pvWmbd
	QJtJM6x7Vgb
X-Google-Smtp-Source: AGHT+IFW1RePl6J0TEsi+Vje/G7JqELl2NWkvyLgqBkkj+eSK4LH6vVsKRGWrTxx5JQ2TN1kM5g4EKffqZ+CTHO/07Q=
X-Received: by 2002:a05:622a:2cd:b0:4b0:f1f3:db94 with SMTP id
 d75a77b69052e-4dec6b1f86cmr3060731cf.5.1758935330099; Fri, 26 Sep 2025
 18:08:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250910-slub-percpu-caches-v8-0-ca3099d8352c@suse.cz> <20250910-slub-percpu-caches-v8-21-ca3099d8352c@suse.cz>
In-Reply-To: <20250910-slub-percpu-caches-v8-21-ca3099d8352c@suse.cz>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 26 Sep 2025 18:08:38 -0700
X-Gm-Features: AS18NWANjmlb2InvVdCxKl32dBOCTwVQzieWObr3D7rnm-E7jSaRToIBJ08DjP4
Message-ID: <CAJuCfpGBg7xO6-swzvk3vLhMxO+F=C6udEiNmAAC6LEA7vA9=Q@mail.gmail.com>
Subject: Re: [PATCH v8 21/23] maple_tree: Prefilled sheaf conversion and testing
To: Vlastimil Babka <vbabka@suse.cz>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Christoph Lameter <cl@gentwo.org>, 
	David Rientjes <rientjes@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Harry Yoo <harry.yoo@oracle.com>, Uladzislau Rezki <urezki@gmail.com>, 
	Sidhartha Kumar <sidhartha.kumar@oracle.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org, 
	maple-tree@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 10, 2025 at 1:01=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
>
> Use prefilled sheaves instead of bulk allocations. This should speed up
> the allocations and the return path of unused allocations.
>
> Remove the push and pop of nodes from the maple state as this is now
> handled by the slab layer with sheaves.
>
> Testing has been removed as necessary since the features of the tree
> have been reduced.
>
> Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

Couple nits but otherwise looks great!

Reviewed-by: Suren Baghdasaryan <surenb@google.com>

> ---
>  include/linux/maple_tree.h       |   6 +-
>  lib/maple_tree.c                 | 326 ++++++---------------------
>  tools/testing/radix-tree/maple.c | 461 ++-------------------------------=
------
>  tools/testing/shared/linux.c     |   5 +-
>  4 files changed, 88 insertions(+), 710 deletions(-)
>
> diff --git a/include/linux/maple_tree.h b/include/linux/maple_tree.h
> index bafe143b1f783202e27b32567fffee4149e8e266..166fd67e00d882b1e6de1f80c=
1b590bba7497cd3 100644
> --- a/include/linux/maple_tree.h
> +++ b/include/linux/maple_tree.h
> @@ -442,7 +442,8 @@ struct ma_state {
>         struct maple_enode *node;       /* The node containing this entry=
 */
>         unsigned long min;              /* The minimum index of this node=
 - implied pivot min */
>         unsigned long max;              /* The maximum index of this node=
 - implied pivot max */
> -       struct maple_alloc *alloc;      /* Allocated nodes for this opera=
tion */
> +       struct slab_sheaf *sheaf;       /* Allocated nodes for this opera=
tion */
> +       unsigned long node_request;

No comment for this poor fella?

>         enum maple_status status;       /* The status of the state (activ=
e, start, none, etc) */
>         unsigned char depth;            /* depth of tree descent during w=
rite */
>         unsigned char offset;
> @@ -490,7 +491,8 @@ struct ma_wr_state {
>                 .status =3D ma_start,                                    =
 \
>                 .min =3D 0,                                              =
 \
>                 .max =3D ULONG_MAX,                                      =
 \
> -               .alloc =3D NULL,                                         =
 \
> +               .node_request=3D 0,                                      =
 \

Missing space in assignment.

> +               .sheaf =3D NULL,                                         =
 \
>                 .mas_flags =3D 0,                                        =
 \
>                 .store_type =3D wr_invalid,                              =
 \
>         }
> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> index 0439aaacf6cb1f39d0d23af2e2a5af1d27ab32be..a3fcb20227e506ed209554cc8=
c041a53f7ef4903 100644
> --- a/lib/maple_tree.c
> +++ b/lib/maple_tree.c
> @@ -182,6 +182,22 @@ static inline void mt_free_bulk(size_t size, void __=
rcu **nodes)
>         kmem_cache_free_bulk(maple_node_cache, size, (void **)nodes);
>  }
>
> +static void mt_return_sheaf(struct slab_sheaf *sheaf)
> +{
> +       kmem_cache_return_sheaf(maple_node_cache, GFP_NOWAIT, sheaf);
> +}
> +
> +static struct slab_sheaf *mt_get_sheaf(gfp_t gfp, int count)
> +{
> +       return kmem_cache_prefill_sheaf(maple_node_cache, gfp, count);
> +}
> +
> +static int mt_refill_sheaf(gfp_t gfp, struct slab_sheaf **sheaf,
> +               unsigned int size)
> +{
> +       return kmem_cache_refill_sheaf(maple_node_cache, gfp, sheaf, size=
);
> +}
> +
>  /*
>   * ma_free_rcu() - Use rcu callback to free a maple node
>   * @node: The node to free
> @@ -574,67 +590,6 @@ static __always_inline bool mte_dead_node(const stru=
ct maple_enode *enode)
>         return ma_dead_node(node);
>  }
>
> -/*
> - * mas_allocated() - Get the number of nodes allocated in a maple state.
> - * @mas: The maple state
> - *
> - * The ma_state alloc member is overloaded to hold a pointer to the firs=
t
> - * allocated node or to the number of requested nodes to allocate.  If b=
it 0 is
> - * set, then the alloc contains the number of requested nodes.  If there=
 is an
> - * allocated node, then the total allocated nodes is in that node.
> - *
> - * Return: The total number of nodes allocated
> - */
> -static inline unsigned long mas_allocated(const struct ma_state *mas)
> -{
> -       if (!mas->alloc || ((unsigned long)mas->alloc & 0x1))
> -               return 0;
> -
> -       return mas->alloc->total;
> -}
> -
> -/*
> - * mas_set_alloc_req() - Set the requested number of allocations.
> - * @mas: the maple state
> - * @count: the number of allocations.
> - *
> - * The requested number of allocations is either in the first allocated =
node,
> - * located in @mas->alloc->request_count, or directly in @mas->alloc if =
there is
> - * no allocated node.  Set the request either in the node or do the nece=
ssary
> - * encoding to store in @mas->alloc directly.
> - */
> -static inline void mas_set_alloc_req(struct ma_state *mas, unsigned long=
 count)
> -{
> -       if (!mas->alloc || ((unsigned long)mas->alloc & 0x1)) {
> -               if (!count)
> -                       mas->alloc =3D NULL;
> -               else
> -                       mas->alloc =3D (struct maple_alloc *)(((count) <<=
 1U) | 1U);
> -               return;
> -       }
> -
> -       mas->alloc->request_count =3D count;
> -}
> -
> -/*
> - * mas_alloc_req() - get the requested number of allocations.
> - * @mas: The maple state
> - *
> - * The alloc count is either stored directly in @mas, or in
> - * @mas->alloc->request_count if there is at least one node allocated.  =
Decode
> - * the request count if it's stored directly in @mas->alloc.
> - *
> - * Return: The allocation request count.
> - */
> -static inline unsigned int mas_alloc_req(const struct ma_state *mas)
> -{
> -       if ((unsigned long)mas->alloc & 0x1)
> -               return (unsigned long)(mas->alloc) >> 1;
> -       else if (mas->alloc)
> -               return mas->alloc->request_count;
> -       return 0;
> -}
> -
>  /*
>   * ma_pivots() - Get a pointer to the maple node pivots.
>   * @node: the maple node
> @@ -1120,77 +1075,15 @@ static int mas_ascend(struct ma_state *mas)
>   */
>  static inline struct maple_node *mas_pop_node(struct ma_state *mas)
>  {
> -       struct maple_alloc *ret, *node =3D mas->alloc;
> -       unsigned long total =3D mas_allocated(mas);
> -       unsigned int req =3D mas_alloc_req(mas);
> +       struct maple_node *ret;
>
> -       /* nothing or a request pending. */
> -       if (WARN_ON(!total))
> +       if (WARN_ON_ONCE(!mas->sheaf))
>                 return NULL;
>
> -       if (total =3D=3D 1) {
> -               /* single allocation in this ma_state */
> -               mas->alloc =3D NULL;
> -               ret =3D node;
> -               goto single_node;
> -       }
> -
> -       if (node->node_count =3D=3D 1) {
> -               /* Single allocation in this node. */
> -               mas->alloc =3D node->slot[0];
> -               mas->alloc->total =3D node->total - 1;
> -               ret =3D node;
> -               goto new_head;
> -       }
> -       node->total--;
> -       ret =3D node->slot[--node->node_count];
> -       node->slot[node->node_count] =3D NULL;
> -
> -single_node:
> -new_head:
> -       if (req) {
> -               req++;
> -               mas_set_alloc_req(mas, req);
> -       }
> -
> +       ret =3D kmem_cache_alloc_from_sheaf(maple_node_cache, GFP_NOWAIT,=
 mas->sheaf);
>         memset(ret, 0, sizeof(*ret));
> -       return (struct maple_node *)ret;
> -}
> -
> -/*
> - * mas_push_node() - Push a node back on the maple state allocation.
> - * @mas: The maple state
> - * @used: The used maple node
> - *
> - * Stores the maple node back into @mas->alloc for reuse.  Updates alloc=
ated and
> - * requested node count as necessary.
> - */
> -static inline void mas_push_node(struct ma_state *mas, struct maple_node=
 *used)
> -{
> -       struct maple_alloc *reuse =3D (struct maple_alloc *)used;
> -       struct maple_alloc *head =3D mas->alloc;
> -       unsigned long count;
> -       unsigned int requested =3D mas_alloc_req(mas);
>
> -       count =3D mas_allocated(mas);
> -
> -       reuse->request_count =3D 0;
> -       reuse->node_count =3D 0;
> -       if (count) {
> -               if (head->node_count < MAPLE_ALLOC_SLOTS) {
> -                       head->slot[head->node_count++] =3D reuse;
> -                       head->total++;
> -                       goto done;
> -               }
> -               reuse->slot[0] =3D head;
> -               reuse->node_count =3D 1;
> -       }
> -
> -       reuse->total =3D count + 1;
> -       mas->alloc =3D reuse;
> -done:
> -       if (requested > 1)
> -               mas_set_alloc_req(mas, requested - 1);
> +       return ret;
>  }
>
>  /*
> @@ -1200,75 +1093,32 @@ static inline void mas_push_node(struct ma_state =
*mas, struct maple_node *used)
>   */
>  static inline void mas_alloc_nodes(struct ma_state *mas, gfp_t gfp)
>  {
> -       struct maple_alloc *node;
> -       unsigned long allocated =3D mas_allocated(mas);
> -       unsigned int requested =3D mas_alloc_req(mas);
> -       unsigned int count;
> -       void **slots =3D NULL;
> -       unsigned int max_req =3D 0;
> -
> -       if (!requested)
> -               return;
> +       if (unlikely(mas->sheaf)) {
> +               unsigned long refill =3D mas->node_request;
>
> -       mas_set_alloc_req(mas, 0);
> -       if (mas->mas_flags & MA_STATE_PREALLOC) {
> -               if (allocated)
> +               if(kmem_cache_sheaf_size(mas->sheaf) >=3D refill) {
> +                       mas->node_request =3D 0;
>                         return;
> -               WARN_ON(!allocated);
> -       }
> -
> -       if (!allocated || mas->alloc->node_count =3D=3D MAPLE_ALLOC_SLOTS=
) {
> -               node =3D (struct maple_alloc *)mt_alloc_one(gfp);
> -               if (!node)
> -                       goto nomem_one;
> -
> -               if (allocated) {
> -                       node->slot[0] =3D mas->alloc;
> -                       node->node_count =3D 1;
> -               } else {
> -                       node->node_count =3D 0;
>                 }
>
> -               mas->alloc =3D node;
> -               node->total =3D ++allocated;
> -               node->request_count =3D 0;
> -               requested--;
> -       }
> +               if (mt_refill_sheaf(gfp, &mas->sheaf, refill))
> +                       goto error;
>
> -       node =3D mas->alloc;
> -       while (requested) {
> -               max_req =3D MAPLE_ALLOC_SLOTS - node->node_count;
> -               slots =3D (void **)&node->slot[node->node_count];
> -               max_req =3D min(requested, max_req);
> -               count =3D mt_alloc_bulk(gfp, max_req, slots);
> -               if (!count)
> -                       goto nomem_bulk;
> -
> -               if (node->node_count =3D=3D 0) {
> -                       node->slot[0]->node_count =3D 0;
> -                       node->slot[0]->request_count =3D 0;
> -               }
> +               mas->node_request =3D 0;
> +               return;
> +       }
>
> -               node->node_count +=3D count;
> -               allocated +=3D count;
> -               /* find a non-full node*/
> -               do {
> -                       node =3D node->slot[0];
> -               } while (unlikely(node->node_count =3D=3D MAPLE_ALLOC_SLO=
TS));
> -               requested -=3D count;
> +       mas->sheaf =3D mt_get_sheaf(gfp, mas->node_request);
> +       if (likely(mas->sheaf)) {
> +               mas->node_request =3D 0;
> +               return;
>         }
> -       mas->alloc->total =3D allocated;
> -       return;
>
> -nomem_bulk:
> -       /* Clean up potential freed allocations on bulk failure */
> -       memset(slots, 0, max_req * sizeof(unsigned long));
> -       mas->alloc->total =3D allocated;
> -nomem_one:
> -       mas_set_alloc_req(mas, requested);
> +error:
>         mas_set_err(mas, -ENOMEM);
>  }
>
> +
>  /*
>   * mas_free() - Free an encoded maple node
>   * @mas: The maple state
> @@ -1279,42 +1129,7 @@ static inline void mas_alloc_nodes(struct ma_state=
 *mas, gfp_t gfp)
>   */
>  static inline void mas_free(struct ma_state *mas, struct maple_enode *us=
ed)
>  {
> -       struct maple_node *tmp =3D mte_to_node(used);
> -
> -       if (mt_in_rcu(mas->tree))
> -               ma_free_rcu(tmp);
> -       else
> -               mas_push_node(mas, tmp);
> -}
> -
> -/*
> - * mas_node_count_gfp() - Check if enough nodes are allocated and reques=
t more
> - * if there is not enough nodes.
> - * @mas: The maple state
> - * @count: The number of nodes needed
> - * @gfp: the gfp flags
> - */
> -static void mas_node_count_gfp(struct ma_state *mas, int count, gfp_t gf=
p)
> -{
> -       unsigned long allocated =3D mas_allocated(mas);
> -
> -       if (allocated < count) {
> -               mas_set_alloc_req(mas, count - allocated);
> -               mas_alloc_nodes(mas, gfp);
> -       }
> -}
> -
> -/*
> - * mas_node_count() - Check if enough nodes are allocated and request mo=
re if
> - * there is not enough nodes.
> - * @mas: The maple state
> - * @count: The number of nodes needed
> - *
> - * Note: Uses GFP_NOWAIT for gfp flags.
> - */
> -static void mas_node_count(struct ma_state *mas, int count)
> -{
> -       return mas_node_count_gfp(mas, count, GFP_NOWAIT);
> +       ma_free_rcu(mte_to_node(used));
>  }
>
>  /*
> @@ -2451,10 +2266,7 @@ static inline void mas_topiary_node(struct ma_stat=
e *mas,
>         enode =3D tmp_mas->node;
>         tmp =3D mte_to_node(enode);
>         mte_set_node_dead(enode);
> -       if (in_rcu)
> -               ma_free_rcu(tmp);
> -       else
> -               mas_push_node(mas, tmp);
> +       ma_free_rcu(tmp);
>  }
>
>  /*
> @@ -3980,7 +3792,7 @@ static inline void mas_wr_prealloc_setup(struct ma_=
wr_state *wr_mas)
>   *
>   * Return: Number of nodes required for preallocation.
>   */
> -static inline int mas_prealloc_calc(struct ma_wr_state *wr_mas, void *en=
try)
> +static inline void mas_prealloc_calc(struct ma_wr_state *wr_mas, void *e=
ntry)
>  {
>         struct ma_state *mas =3D wr_mas->mas;
>         unsigned char height =3D mas_mt_height(mas);
> @@ -4026,7 +3838,7 @@ static inline int mas_prealloc_calc(struct ma_wr_st=
ate *wr_mas, void *entry)
>                 WARN_ON_ONCE(1);
>         }
>
> -       return ret;
> +       mas->node_request =3D ret;
>  }
>
>  /*
> @@ -4087,15 +3899,15 @@ static inline enum store_type mas_wr_store_type(s=
truct ma_wr_state *wr_mas)
>   */
>  static inline void mas_wr_preallocate(struct ma_wr_state *wr_mas, void *=
entry)
>  {
> -       int request;
> +       struct ma_state *mas =3D wr_mas->mas;
>
>         mas_wr_prealloc_setup(wr_mas);
> -       wr_mas->mas->store_type =3D mas_wr_store_type(wr_mas);
> -       request =3D mas_prealloc_calc(wr_mas, entry);
> -       if (!request)
> +       mas->store_type =3D mas_wr_store_type(wr_mas);
> +       mas_prealloc_calc(wr_mas, entry);
> +       if (!mas->node_request)
>                 return;
>
> -       mas_node_count(wr_mas->mas, request);
> +       mas_alloc_nodes(mas, GFP_NOWAIT);
>  }
>
>  /**
> @@ -5208,7 +5020,6 @@ static inline void mte_destroy_walk(struct maple_en=
ode *enode,
>   */
>  void *mas_store(struct ma_state *mas, void *entry)
>  {
> -       int request;
>         MA_WR_STATE(wr_mas, mas, entry);
>
>         trace_ma_write(__func__, mas, 0, entry);
> @@ -5238,11 +5049,11 @@ void *mas_store(struct ma_state *mas, void *entry=
)
>                 return wr_mas.content;
>         }
>
> -       request =3D mas_prealloc_calc(&wr_mas, entry);
> -       if (!request)
> +       mas_prealloc_calc(&wr_mas, entry);
> +       if (!mas->node_request)
>                 goto store;
>
> -       mas_node_count(mas, request);
> +       mas_alloc_nodes(mas, GFP_NOWAIT);
>         if (mas_is_err(mas))
>                 return NULL;
>
> @@ -5330,20 +5141,19 @@ EXPORT_SYMBOL_GPL(mas_store_prealloc);
>  int mas_preallocate(struct ma_state *mas, void *entry, gfp_t gfp)
>  {
>         MA_WR_STATE(wr_mas, mas, entry);
> -       int ret =3D 0;
> -       int request;
>
>         mas_wr_prealloc_setup(&wr_mas);
>         mas->store_type =3D mas_wr_store_type(&wr_mas);
> -       request =3D mas_prealloc_calc(&wr_mas, entry);
> -       if (!request)
> +       mas_prealloc_calc(&wr_mas, entry);
> +       if (!mas->node_request)
>                 goto set_flag;
>
>         mas->mas_flags &=3D ~MA_STATE_PREALLOC;
> -       mas_node_count_gfp(mas, request, gfp);
> +       mas_alloc_nodes(mas, gfp);
>         if (mas_is_err(mas)) {
> -               mas_set_alloc_req(mas, 0);
> -               ret =3D xa_err(mas->node);
> +               int ret =3D xa_err(mas->node);
> +
> +               mas->node_request =3D 0;
>                 mas_destroy(mas);
>                 mas_reset(mas);
>                 return ret;
> @@ -5351,7 +5161,7 @@ int mas_preallocate(struct ma_state *mas, void *ent=
ry, gfp_t gfp)
>
>  set_flag:
>         mas->mas_flags |=3D MA_STATE_PREALLOC;
> -       return ret;
> +       return 0;
>  }
>  EXPORT_SYMBOL_GPL(mas_preallocate);
>
> @@ -5365,26 +5175,13 @@ EXPORT_SYMBOL_GPL(mas_preallocate);
>   */
>  void mas_destroy(struct ma_state *mas)
>  {
> -       struct maple_alloc *node;
> -       unsigned long total;
> -
>         mas->mas_flags &=3D ~MA_STATE_PREALLOC;
>
> -       total =3D mas_allocated(mas);
> -       while (total) {
> -               node =3D mas->alloc;
> -               mas->alloc =3D node->slot[0];
> -               if (node->node_count > 1) {
> -                       size_t count =3D node->node_count - 1;
> -
> -                       mt_free_bulk(count, (void __rcu **)&node->slot[1]=
);
> -                       total -=3D count;
> -               }
> -               kfree(ma_mnode_ptr(node));
> -               total--;
> -       }
> +       mas->node_request =3D 0;
> +       if (mas->sheaf)
> +               mt_return_sheaf(mas->sheaf);
>
> -       mas->alloc =3D NULL;
> +       mas->sheaf =3D NULL;
>  }
>  EXPORT_SYMBOL_GPL(mas_destroy);
>
> @@ -6019,7 +5816,7 @@ bool mas_nomem(struct ma_state *mas, gfp_t gfp)
>                 mas_alloc_nodes(mas, gfp);
>         }
>
> -       if (!mas_allocated(mas))
> +       if (!mas->sheaf)
>                 return false;
>
>         mas->status =3D ma_start;
> @@ -7414,8 +7211,9 @@ void mas_dump(const struct ma_state *mas)
>
>         pr_err("[%u/%u] index=3D%lx last=3D%lx\n", mas->offset, mas->end,
>                mas->index, mas->last);
> -       pr_err("     min=3D%lx max=3D%lx alloc=3D" PTR_FMT ", depth=3D%u,=
 flags=3D%x\n",
> -              mas->min, mas->max, mas->alloc, mas->depth, mas->mas_flags=
);
> +       pr_err("     min=3D%lx max=3D%lx sheaf=3D" PTR_FMT ", request %lu=
 depth=3D%u, flags=3D%x\n",
> +              mas->min, mas->max, mas->sheaf, mas->node_request, mas->de=
pth,
> +              mas->mas_flags);
>         if (mas->index > mas->last)
>                 pr_err("Check index & last\n");
>  }
> diff --git a/tools/testing/radix-tree/maple.c b/tools/testing/radix-tree/=
maple.c
> index 4a35e1e7c64b7ce347cbd1693beeaacb0c4c330e..72a8fe8e832a4150c6567b711=
768eba6a3fa6768 100644
> --- a/tools/testing/radix-tree/maple.c
> +++ b/tools/testing/radix-tree/maple.c
> @@ -57,430 +57,6 @@ struct rcu_reader_struct {
>         struct rcu_test_struct2 *test;
>  };
>
> -static int get_alloc_node_count(struct ma_state *mas)
> -{
> -       int count =3D 1;
> -       struct maple_alloc *node =3D mas->alloc;
> -
> -       if (!node || ((unsigned long)node & 0x1))
> -               return 0;
> -       while (node->node_count) {
> -               count +=3D node->node_count;
> -               node =3D node->slot[0];
> -       }
> -       return count;
> -}
> -
> -static void check_mas_alloc_node_count(struct ma_state *mas)
> -{
> -       mas_node_count_gfp(mas, MAPLE_ALLOC_SLOTS + 1, GFP_KERNEL);
> -       mas_node_count_gfp(mas, MAPLE_ALLOC_SLOTS + 3, GFP_KERNEL);
> -       MT_BUG_ON(mas->tree, get_alloc_node_count(mas) !=3D mas->alloc->t=
otal);
> -       mas_destroy(mas);
> -}
> -
> -/*
> - * check_new_node() - Check the creation of new nodes and error path
> - * verification.
> - */
> -static noinline void __init check_new_node(struct maple_tree *mt)
> -{
> -
> -       struct maple_node *mn, *mn2, *mn3;
> -       struct maple_alloc *smn;
> -       struct maple_node *nodes[100];
> -       int i, j, total;
> -
> -       MA_STATE(mas, mt, 0, 0);
> -
> -       check_mas_alloc_node_count(&mas);
> -
> -       /* Try allocating 3 nodes */
> -       mtree_lock(mt);
> -       mt_set_non_kernel(0);
> -       /* request 3 nodes to be allocated. */
> -       mas_node_count(&mas, 3);
> -       /* Allocation request of 3. */
> -       MT_BUG_ON(mt, mas_alloc_req(&mas) !=3D 3);
> -       /* Allocate failed. */
> -       MT_BUG_ON(mt, mas.node !=3D MA_ERROR(-ENOMEM));
> -       MT_BUG_ON(mt, !mas_nomem(&mas, GFP_KERNEL));
> -
> -       MT_BUG_ON(mt, mas_allocated(&mas) !=3D 3);
> -       mn =3D mas_pop_node(&mas);
> -       MT_BUG_ON(mt, not_empty(mn));
> -       MT_BUG_ON(mt, mn =3D=3D NULL);
> -       MT_BUG_ON(mt, mas.alloc =3D=3D NULL);
> -       MT_BUG_ON(mt, mas.alloc->slot[0] =3D=3D NULL);
> -       mas_push_node(&mas, mn);
> -       mas_reset(&mas);
> -       mas_destroy(&mas);
> -       mtree_unlock(mt);
> -
> -
> -       /* Try allocating 1 node, then 2 more */
> -       mtree_lock(mt);
> -       /* Set allocation request to 1. */
> -       mas_set_alloc_req(&mas, 1);
> -       /* Check Allocation request of 1. */
> -       MT_BUG_ON(mt, mas_alloc_req(&mas) !=3D 1);
> -       mas_set_err(&mas, -ENOMEM);
> -       /* Validate allocation request. */
> -       MT_BUG_ON(mt, !mas_nomem(&mas, GFP_KERNEL));
> -       /* Eat the requested node. */
> -       mn =3D mas_pop_node(&mas);
> -       MT_BUG_ON(mt, not_empty(mn));
> -       MT_BUG_ON(mt, mn =3D=3D NULL);
> -       MT_BUG_ON(mt, mn->slot[0] !=3D NULL);
> -       MT_BUG_ON(mt, mn->slot[1] !=3D NULL);
> -       MT_BUG_ON(mt, mas_allocated(&mas) !=3D 0);
> -
> -       mn->parent =3D ma_parent_ptr(mn);
> -       ma_free_rcu(mn);
> -       mas.status =3D ma_start;
> -       mas_destroy(&mas);
> -       /* Allocate 3 nodes, will fail. */
> -       mas_node_count(&mas, 3);
> -       /* Drop the lock and allocate 3 nodes. */
> -       mas_nomem(&mas, GFP_KERNEL);
> -       /* Ensure 3 are allocated. */
> -       MT_BUG_ON(mt, mas_allocated(&mas) !=3D 3);
> -       /* Allocation request of 0. */
> -       MT_BUG_ON(mt, mas_alloc_req(&mas) !=3D 0);
> -
> -       MT_BUG_ON(mt, mas.alloc =3D=3D NULL);
> -       MT_BUG_ON(mt, mas.alloc->slot[0] =3D=3D NULL);
> -       MT_BUG_ON(mt, mas.alloc->slot[1] =3D=3D NULL);
> -       /* Ensure we counted 3. */
> -       MT_BUG_ON(mt, mas_allocated(&mas) !=3D 3);
> -       /* Free. */
> -       mas_reset(&mas);
> -       mas_destroy(&mas);
> -
> -       /* Set allocation request to 1. */
> -       mas_set_alloc_req(&mas, 1);
> -       MT_BUG_ON(mt, mas_alloc_req(&mas) !=3D 1);
> -       mas_set_err(&mas, -ENOMEM);
> -       /* Validate allocation request. */
> -       MT_BUG_ON(mt, !mas_nomem(&mas, GFP_KERNEL));
> -       MT_BUG_ON(mt, mas_allocated(&mas) !=3D 1);
> -       /* Check the node is only one node. */
> -       mn =3D mas_pop_node(&mas);
> -       MT_BUG_ON(mt, not_empty(mn));
> -       MT_BUG_ON(mt, mas_allocated(&mas) !=3D 0);
> -       MT_BUG_ON(mt, mn =3D=3D NULL);
> -       MT_BUG_ON(mt, mn->slot[0] !=3D NULL);
> -       MT_BUG_ON(mt, mn->slot[1] !=3D NULL);
> -       MT_BUG_ON(mt, mas_allocated(&mas) !=3D 0);
> -       mas_push_node(&mas, mn);
> -       MT_BUG_ON(mt, mas_allocated(&mas) !=3D 1);
> -       MT_BUG_ON(mt, mas.alloc->node_count);
> -
> -       mas_set_alloc_req(&mas, 2); /* request 2 more. */
> -       MT_BUG_ON(mt, mas_alloc_req(&mas) !=3D 2);
> -       mas_set_err(&mas, -ENOMEM);
> -       MT_BUG_ON(mt, !mas_nomem(&mas, GFP_KERNEL));
> -       MT_BUG_ON(mt, mas_allocated(&mas) !=3D 3);
> -       MT_BUG_ON(mt, mas.alloc =3D=3D NULL);
> -       MT_BUG_ON(mt, mas.alloc->slot[0] =3D=3D NULL);
> -       MT_BUG_ON(mt, mas.alloc->slot[1] =3D=3D NULL);
> -       for (i =3D 2; i >=3D 0; i--) {
> -               mn =3D mas_pop_node(&mas);
> -               MT_BUG_ON(mt, mas_allocated(&mas) !=3D i);
> -               MT_BUG_ON(mt, !mn);
> -               MT_BUG_ON(mt, not_empty(mn));
> -               mn->parent =3D ma_parent_ptr(mn);
> -               ma_free_rcu(mn);
> -       }
> -
> -       total =3D 64;
> -       mas_set_alloc_req(&mas, total); /* request 2 more. */
> -       MT_BUG_ON(mt, mas_alloc_req(&mas) !=3D total);
> -       mas_set_err(&mas, -ENOMEM);
> -       MT_BUG_ON(mt, !mas_nomem(&mas, GFP_KERNEL));
> -       for (i =3D total; i > 0; i--) {
> -               unsigned int e =3D 0; /* expected node_count */
> -
> -               if (!MAPLE_32BIT) {
> -                       if (i >=3D 35)
> -                               e =3D i - 34;
> -                       else if (i >=3D 5)
> -                               e =3D i - 4;
> -                       else if (i >=3D 2)
> -                               e =3D i - 1;
> -               } else {
> -                       if (i >=3D 4)
> -                               e =3D i - 3;
> -                       else if (i >=3D 1)
> -                               e =3D i - 1;
> -                       else
> -                               e =3D 0;
> -               }
> -
> -               MT_BUG_ON(mt, mas.alloc->node_count !=3D e);
> -               mn =3D mas_pop_node(&mas);
> -               MT_BUG_ON(mt, not_empty(mn));
> -               MT_BUG_ON(mt, mas_allocated(&mas) !=3D i - 1);
> -               MT_BUG_ON(mt, !mn);
> -               mn->parent =3D ma_parent_ptr(mn);
> -               ma_free_rcu(mn);
> -       }
> -
> -       total =3D 100;
> -       for (i =3D 1; i < total; i++) {
> -               mas_set_alloc_req(&mas, i);
> -               mas_set_err(&mas, -ENOMEM);
> -               MT_BUG_ON(mt, !mas_nomem(&mas, GFP_KERNEL));
> -               for (j =3D i; j > 0; j--) {
> -                       mn =3D mas_pop_node(&mas);
> -                       MT_BUG_ON(mt, mas_allocated(&mas) !=3D j - 1);
> -                       MT_BUG_ON(mt, !mn);
> -                       MT_BUG_ON(mt, not_empty(mn));
> -                       mas_push_node(&mas, mn);
> -                       MT_BUG_ON(mt, mas_allocated(&mas) !=3D j);
> -                       mn =3D mas_pop_node(&mas);
> -                       MT_BUG_ON(mt, not_empty(mn));
> -                       MT_BUG_ON(mt, mas_allocated(&mas) !=3D j - 1);
> -                       mn->parent =3D ma_parent_ptr(mn);
> -                       ma_free_rcu(mn);
> -               }
> -               MT_BUG_ON(mt, mas_allocated(&mas) !=3D 0);
> -
> -               mas_set_alloc_req(&mas, i);
> -               mas_set_err(&mas, -ENOMEM);
> -               MT_BUG_ON(mt, !mas_nomem(&mas, GFP_KERNEL));
> -               for (j =3D 0; j <=3D i/2; j++) {
> -                       MT_BUG_ON(mt, mas_allocated(&mas) !=3D i - j);
> -                       nodes[j] =3D mas_pop_node(&mas);
> -                       MT_BUG_ON(mt, mas_allocated(&mas) !=3D i - j - 1)=
;
> -               }
> -
> -               while (j) {
> -                       j--;
> -                       mas_push_node(&mas, nodes[j]);
> -                       MT_BUG_ON(mt, mas_allocated(&mas) !=3D i - j);
> -               }
> -               MT_BUG_ON(mt, mas_allocated(&mas) !=3D i);
> -               for (j =3D 0; j <=3D i/2; j++) {
> -                       MT_BUG_ON(mt, mas_allocated(&mas) !=3D i - j);
> -                       mn =3D mas_pop_node(&mas);
> -                       MT_BUG_ON(mt, not_empty(mn));
> -                       mn->parent =3D ma_parent_ptr(mn);
> -                       ma_free_rcu(mn);
> -                       MT_BUG_ON(mt, mas_allocated(&mas) !=3D i - j - 1)=
;
> -               }
> -               mas_reset(&mas);
> -               MT_BUG_ON(mt, mas_nomem(&mas, GFP_KERNEL));
> -               mas_destroy(&mas);
> -
> -       }
> -
> -       /* Set allocation request. */
> -       total =3D 500;
> -       mas_node_count(&mas, total);
> -       /* Drop the lock and allocate the nodes. */
> -       mas_nomem(&mas, GFP_KERNEL);
> -       MT_BUG_ON(mt, !mas.alloc);
> -       i =3D 1;
> -       smn =3D mas.alloc;
> -       while (i < total) {
> -               for (j =3D 0; j < MAPLE_ALLOC_SLOTS; j++) {
> -                       i++;
> -                       MT_BUG_ON(mt, !smn->slot[j]);
> -                       if (i =3D=3D total)
> -                               break;
> -               }
> -               smn =3D smn->slot[0]; /* next. */
> -       }
> -       MT_BUG_ON(mt, mas_allocated(&mas) !=3D total);
> -       mas_reset(&mas);
> -       mas_destroy(&mas); /* Free. */
> -
> -       MT_BUG_ON(mt, mas_allocated(&mas) !=3D 0);
> -       for (i =3D 1; i < 128; i++) {
> -               mas_node_count(&mas, i); /* Request */
> -               mas_nomem(&mas, GFP_KERNEL); /* Fill request */
> -               MT_BUG_ON(mt, mas_allocated(&mas) !=3D i); /* check reque=
st filled */
> -               for (j =3D i; j > 0; j--) { /*Free the requests */
> -                       mn =3D mas_pop_node(&mas); /* get the next node. =
*/
> -                       MT_BUG_ON(mt, mn =3D=3D NULL);
> -                       MT_BUG_ON(mt, not_empty(mn));
> -                       mn->parent =3D ma_parent_ptr(mn);
> -                       ma_free_rcu(mn);
> -               }
> -               MT_BUG_ON(mt, mas_allocated(&mas) !=3D 0);
> -       }
> -
> -       for (i =3D 1; i < MAPLE_NODE_MASK + 1; i++) {
> -               MA_STATE(mas2, mt, 0, 0);
> -               mas_node_count(&mas, i); /* Request */
> -               mas_nomem(&mas, GFP_KERNEL); /* Fill request */
> -               MT_BUG_ON(mt, mas_allocated(&mas) !=3D i); /* check reque=
st filled */
> -               for (j =3D 1; j <=3D i; j++) { /* Move the allocations to=
 mas2 */
> -                       mn =3D mas_pop_node(&mas); /* get the next node. =
*/
> -                       MT_BUG_ON(mt, mn =3D=3D NULL);
> -                       MT_BUG_ON(mt, not_empty(mn));
> -                       mas_push_node(&mas2, mn);
> -                       MT_BUG_ON(mt, mas_allocated(&mas2) !=3D j);
> -               }
> -               MT_BUG_ON(mt, mas_allocated(&mas) !=3D 0);
> -               MT_BUG_ON(mt, mas_allocated(&mas2) !=3D i);
> -
> -               for (j =3D i; j > 0; j--) { /*Free the requests */
> -                       MT_BUG_ON(mt, mas_allocated(&mas2) !=3D j);
> -                       mn =3D mas_pop_node(&mas2); /* get the next node.=
 */
> -                       MT_BUG_ON(mt, mn =3D=3D NULL);
> -                       MT_BUG_ON(mt, not_empty(mn));
> -                       mn->parent =3D ma_parent_ptr(mn);
> -                       ma_free_rcu(mn);
> -               }
> -               MT_BUG_ON(mt, mas_allocated(&mas2) !=3D 0);
> -       }
> -
> -
> -       MT_BUG_ON(mt, mas_allocated(&mas) !=3D 0);
> -       mas_node_count(&mas, MAPLE_ALLOC_SLOTS + 1); /* Request */
> -       MT_BUG_ON(mt, mas.node !=3D MA_ERROR(-ENOMEM));
> -       MT_BUG_ON(mt, !mas_nomem(&mas, GFP_KERNEL));
> -       MT_BUG_ON(mt, mas_allocated(&mas) !=3D MAPLE_ALLOC_SLOTS + 1);
> -       MT_BUG_ON(mt, mas.alloc->node_count !=3D MAPLE_ALLOC_SLOTS);
> -
> -       mn =3D mas_pop_node(&mas); /* get the next node. */
> -       MT_BUG_ON(mt, mn =3D=3D NULL);
> -       MT_BUG_ON(mt, not_empty(mn));
> -       MT_BUG_ON(mt, mas_allocated(&mas) !=3D MAPLE_ALLOC_SLOTS);
> -       MT_BUG_ON(mt, mas.alloc->node_count !=3D MAPLE_ALLOC_SLOTS - 1);
> -
> -       mas_push_node(&mas, mn);
> -       MT_BUG_ON(mt, mas_allocated(&mas) !=3D MAPLE_ALLOC_SLOTS + 1);
> -       MT_BUG_ON(mt, mas.alloc->node_count !=3D MAPLE_ALLOC_SLOTS);
> -
> -       /* Check the limit of pop/push/pop */
> -       mas_node_count(&mas, MAPLE_ALLOC_SLOTS + 2); /* Request */
> -       MT_BUG_ON(mt, mas_alloc_req(&mas) !=3D 1);
> -       MT_BUG_ON(mt, mas.node !=3D MA_ERROR(-ENOMEM));
> -       MT_BUG_ON(mt, !mas_nomem(&mas, GFP_KERNEL));
> -       MT_BUG_ON(mt, mas_alloc_req(&mas));
> -       MT_BUG_ON(mt, mas.alloc->node_count !=3D 1);
> -       MT_BUG_ON(mt, mas_allocated(&mas) !=3D MAPLE_ALLOC_SLOTS + 2);
> -       mn =3D mas_pop_node(&mas);
> -       MT_BUG_ON(mt, not_empty(mn));
> -       MT_BUG_ON(mt, mas_allocated(&mas) !=3D MAPLE_ALLOC_SLOTS + 1);
> -       MT_BUG_ON(mt, mas.alloc->node_count  !=3D MAPLE_ALLOC_SLOTS);
> -       mas_push_node(&mas, mn);
> -       MT_BUG_ON(mt, mas.alloc->node_count !=3D 1);
> -       MT_BUG_ON(mt, mas_allocated(&mas) !=3D MAPLE_ALLOC_SLOTS + 2);
> -       mn =3D mas_pop_node(&mas);
> -       MT_BUG_ON(mt, not_empty(mn));
> -       mn->parent =3D ma_parent_ptr(mn);
> -       ma_free_rcu(mn);
> -       for (i =3D 1; i <=3D MAPLE_ALLOC_SLOTS + 1; i++) {
> -               mn =3D mas_pop_node(&mas);
> -               MT_BUG_ON(mt, not_empty(mn));
> -               mn->parent =3D ma_parent_ptr(mn);
> -               ma_free_rcu(mn);
> -       }
> -       MT_BUG_ON(mt, mas_allocated(&mas) !=3D 0);
> -
> -
> -       for (i =3D 3; i < MAPLE_NODE_MASK * 3; i++) {
> -               mas.node =3D MA_ERROR(-ENOMEM);
> -               mas_node_count(&mas, i); /* Request */
> -               mas_nomem(&mas, GFP_KERNEL); /* Fill request */
> -               mn =3D mas_pop_node(&mas); /* get the next node. */
> -               mas_push_node(&mas, mn); /* put it back */
> -               mas_destroy(&mas);
> -
> -               mas.node =3D MA_ERROR(-ENOMEM);
> -               mas_node_count(&mas, i); /* Request */
> -               mas_nomem(&mas, GFP_KERNEL); /* Fill request */
> -               mn =3D mas_pop_node(&mas); /* get the next node. */
> -               mn2 =3D mas_pop_node(&mas); /* get the next node. */
> -               mas_push_node(&mas, mn); /* put them back */
> -               mas_push_node(&mas, mn2);
> -               mas_destroy(&mas);
> -
> -               mas.node =3D MA_ERROR(-ENOMEM);
> -               mas_node_count(&mas, i); /* Request */
> -               mas_nomem(&mas, GFP_KERNEL); /* Fill request */
> -               mn =3D mas_pop_node(&mas); /* get the next node. */
> -               mn2 =3D mas_pop_node(&mas); /* get the next node. */
> -               mn3 =3D mas_pop_node(&mas); /* get the next node. */
> -               mas_push_node(&mas, mn); /* put them back */
> -               mas_push_node(&mas, mn2);
> -               mas_push_node(&mas, mn3);
> -               mas_destroy(&mas);
> -
> -               mas.node =3D MA_ERROR(-ENOMEM);
> -               mas_node_count(&mas, i); /* Request */
> -               mas_nomem(&mas, GFP_KERNEL); /* Fill request */
> -               mn =3D mas_pop_node(&mas); /* get the next node. */
> -               mn->parent =3D ma_parent_ptr(mn);
> -               ma_free_rcu(mn);
> -               mas_destroy(&mas);
> -
> -               mas.node =3D MA_ERROR(-ENOMEM);
> -               mas_node_count(&mas, i); /* Request */
> -               mas_nomem(&mas, GFP_KERNEL); /* Fill request */
> -               mn =3D mas_pop_node(&mas); /* get the next node. */
> -               mn->parent =3D ma_parent_ptr(mn);
> -               ma_free_rcu(mn);
> -               mn =3D mas_pop_node(&mas); /* get the next node. */
> -               mn->parent =3D ma_parent_ptr(mn);
> -               ma_free_rcu(mn);
> -               mn =3D mas_pop_node(&mas); /* get the next node. */
> -               mn->parent =3D ma_parent_ptr(mn);
> -               ma_free_rcu(mn);
> -               mas_destroy(&mas);
> -       }
> -
> -       mas.node =3D MA_ERROR(-ENOMEM);
> -       mas_node_count(&mas, 5); /* Request */
> -       mas_nomem(&mas, GFP_KERNEL); /* Fill request */
> -       MT_BUG_ON(mt, mas_allocated(&mas) !=3D 5);
> -       mas.node =3D MA_ERROR(-ENOMEM);
> -       mas_node_count(&mas, 10); /* Request */
> -       mas_nomem(&mas, GFP_KERNEL); /* Fill request */
> -       mas.status =3D ma_start;
> -       MT_BUG_ON(mt, mas_allocated(&mas) !=3D 10);
> -       mas_destroy(&mas);
> -
> -       mas.node =3D MA_ERROR(-ENOMEM);
> -       mas_node_count(&mas, MAPLE_ALLOC_SLOTS - 1); /* Request */
> -       mas_nomem(&mas, GFP_KERNEL); /* Fill request */
> -       MT_BUG_ON(mt, mas_allocated(&mas) !=3D MAPLE_ALLOC_SLOTS - 1);
> -       mas.node =3D MA_ERROR(-ENOMEM);
> -       mas_node_count(&mas, 10 + MAPLE_ALLOC_SLOTS - 1); /* Request */
> -       mas_nomem(&mas, GFP_KERNEL); /* Fill request */
> -       mas.status =3D ma_start;
> -       MT_BUG_ON(mt, mas_allocated(&mas) !=3D 10 + MAPLE_ALLOC_SLOTS - 1=
);
> -       mas_destroy(&mas);
> -
> -       mas.node =3D MA_ERROR(-ENOMEM);
> -       mas_node_count(&mas, MAPLE_ALLOC_SLOTS + 1); /* Request */
> -       mas_nomem(&mas, GFP_KERNEL); /* Fill request */
> -       MT_BUG_ON(mt, mas_allocated(&mas) !=3D MAPLE_ALLOC_SLOTS + 1);
> -       mas.node =3D MA_ERROR(-ENOMEM);
> -       mas_node_count(&mas, MAPLE_ALLOC_SLOTS * 2 + 2); /* Request */
> -       mas_nomem(&mas, GFP_KERNEL); /* Fill request */
> -       mas.status =3D ma_start;
> -       MT_BUG_ON(mt, mas_allocated(&mas) !=3D MAPLE_ALLOC_SLOTS * 2 + 2)=
;
> -       mas_destroy(&mas);
> -
> -       mas.node =3D MA_ERROR(-ENOMEM);
> -       mas_node_count(&mas, MAPLE_ALLOC_SLOTS * 2 + 1); /* Request */
> -       mas_nomem(&mas, GFP_KERNEL); /* Fill request */
> -       MT_BUG_ON(mt, mas_allocated(&mas) !=3D MAPLE_ALLOC_SLOTS * 2 + 1)=
;
> -       mas.node =3D MA_ERROR(-ENOMEM);
> -       mas_node_count(&mas, MAPLE_ALLOC_SLOTS * 3 + 2); /* Request */
> -       mas_nomem(&mas, GFP_KERNEL); /* Fill request */
> -       mas.status =3D ma_start;
> -       MT_BUG_ON(mt, mas_allocated(&mas) !=3D MAPLE_ALLOC_SLOTS * 3 + 2)=
;
> -       mas_destroy(&mas);
> -
> -       mtree_unlock(mt);
> -}
> -
>  /*
>   * Check erasing including RCU.
>   */
> @@ -35507,6 +35083,13 @@ static unsigned char get_vacant_height(struct ma=
_wr_state *wr_mas, void *entry)
>         return vacant_height;
>  }
>
> +static int mas_allocated(struct ma_state *mas)
> +{
> +       if (mas->sheaf)
> +               return kmem_cache_sheaf_size(mas->sheaf);
> +
> +       return 0;
> +}
>  /* Preallocation testing */
>  static noinline void __init check_prealloc(struct maple_tree *mt)
>  {
> @@ -35525,7 +35108,10 @@ static noinline void __init check_prealloc(struc=
t maple_tree *mt)
>
>         /* Spanning store */
>         mas_set_range(&mas, 470, 500);
> -       MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) !=3D 0);
> +
> +       mas_wr_preallocate(&wr_mas, ptr);
> +       MT_BUG_ON(mt, mas.store_type !=3D wr_spanning_store);
> +       MT_BUG_ON(mt, mas_is_err(&mas));
>         allocated =3D mas_allocated(&mas);
>         height =3D mas_mt_height(&mas);
>         vacant_height =3D get_vacant_height(&wr_mas, ptr);
> @@ -35535,6 +35121,7 @@ static noinline void __init check_prealloc(struct=
 maple_tree *mt)
>         allocated =3D mas_allocated(&mas);
>         MT_BUG_ON(mt, allocated !=3D 0);
>
> +       mas_wr_preallocate(&wr_mas, ptr);
>         MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) !=3D 0);
>         allocated =3D mas_allocated(&mas);
>         height =3D mas_mt_height(&mas);
> @@ -35575,20 +35162,6 @@ static noinline void __init check_prealloc(struc=
t maple_tree *mt)
>         mn->parent =3D ma_parent_ptr(mn);
>         ma_free_rcu(mn);
>
> -       MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) !=3D 0);
> -       allocated =3D mas_allocated(&mas);
> -       height =3D mas_mt_height(&mas);
> -       vacant_height =3D get_vacant_height(&wr_mas, ptr);
> -       MT_BUG_ON(mt, allocated !=3D 1 + (height - vacant_height) * 3);
> -       mn =3D mas_pop_node(&mas);
> -       MT_BUG_ON(mt, mas_allocated(&mas) !=3D allocated - 1);
> -       mas_push_node(&mas, mn);
> -       MT_BUG_ON(mt, mas_allocated(&mas) !=3D allocated);
> -       MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) !=3D 0);
> -       mas_destroy(&mas);
> -       allocated =3D mas_allocated(&mas);
> -       MT_BUG_ON(mt, allocated !=3D 0);
> -
>         MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) !=3D 0);
>         allocated =3D mas_allocated(&mas);
>         height =3D mas_mt_height(&mas);
> @@ -36389,11 +35962,17 @@ static void check_nomem_writer_race(struct mapl=
e_tree *mt)
>         check_load(mt, 6, xa_mk_value(0xC));
>         mtree_unlock(mt);
>
> +       mt_set_non_kernel(0);
>         /* test for the same race but with mas_store_gfp() */
>         mtree_store_range(mt, 0, 5, xa_mk_value(0xA), GFP_KERNEL);
>         mtree_store_range(mt, 6, 10, NULL, GFP_KERNEL);
>
>         mas_set_range(&mas, 0, 5);
> +
> +       /* setup writer 2 that will trigger the race condition */
> +       mt_set_private(mt);
> +       mt_set_callback(writer2);
> +
>         mtree_lock(mt);
>         mas_store_gfp(&mas, NULL, GFP_KERNEL);
>
> @@ -36508,10 +36087,6 @@ void farmer_tests(void)
>         check_erase_testset(&tree);
>         mtree_destroy(&tree);
>
> -       mt_init_flags(&tree, 0);
> -       check_new_node(&tree);
> -       mtree_destroy(&tree);
> -
>         if (!MAPLE_32BIT) {
>                 mt_init_flags(&tree, MT_FLAGS_ALLOC_RANGE);
>                 check_rcu_simulated(&tree);
> diff --git a/tools/testing/shared/linux.c b/tools/testing/shared/linux.c
> index 4ceff7969b78cf8e33cd1e021c68bc9f8a02a7a1..8c72571559583759456c2b469=
a2abc2611117c13 100644
> --- a/tools/testing/shared/linux.c
> +++ b/tools/testing/shared/linux.c
> @@ -64,7 +64,8 @@ void *kmem_cache_alloc_lru(struct kmem_cache *cachep, s=
truct list_lru *lru,
>
>         if (!(gfp & __GFP_DIRECT_RECLAIM)) {
>                 if (!cachep->non_kernel) {
> -                       cachep->exec_callback =3D true;
> +                       if (cachep->callback)
> +                               cachep->exec_callback =3D true;
>                         return NULL;
>                 }
>
> @@ -210,6 +211,8 @@ int kmem_cache_alloc_bulk(struct kmem_cache *cachep, =
gfp_t gfp, size_t size,
>                 for (i =3D 0; i < size; i++)
>                         __kmem_cache_free_locked(cachep, p[i]);
>                 pthread_mutex_unlock(&cachep->lock);
> +               if (cachep->callback)
> +                       cachep->exec_callback =3D true;
>                 return 0;
>         }
>
>
> --
> 2.51.0
>

