Return-Path: <linux-kernel+bounces-834770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72A6ABA57B0
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 03:17:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D2013256E8
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 01:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A57B81DE8B3;
	Sat, 27 Sep 2025 01:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TgD4W4VH"
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C3019F115
	for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 01:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758935843; cv=none; b=U3nSc+nx+2SCEObGGNfMT2+8JtS22qQ8zxdp6VlJciYQwm09wbJ+TWaPg2MFlUIdOm6xW5ICRPayWuAsirzDypohWxlfsmLGkifzm96JHgkhx9kQUDMm49cQTdm+KzMFTo8IxUwGGygUlVc5qzhQHYolZCD+cSwkbOgvMwxgfY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758935843; c=relaxed/simple;
	bh=GLQYJhwAyzcEeEfpcAHXQec3Dck6ULc+1afuEMmCptI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I4AsGYPp4S4ZRZhH/t7uP4RamyC1jH7PpSfs5/X5AtJsQdI0jFQo8GKB2FmVA5qsS0IK8ln0/C1jOfP8N2aqfv5S7yNs9zO8xebDlPizcpg16GgZYCQgUGVuum/dKWqHnjExQYXqdZXjF9l8/WkMII4MzUuDhF1Rihd4InjpsLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TgD4W4VH; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-42451cc9deaso57735ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 18:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758935840; x=1759540640; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JP6jNuOzuaZrN4jqHuCq7vrrzkS8UserW/hueLrBex8=;
        b=TgD4W4VHvKbd1guKyWz36mHEsB3ZTyfdlKapbRqXj5x2j3Ne7rmVxZn2lx2D6TfUa2
         P8ZpiVfEAYWE6P/JJgsCR10raUyTJ7aKuu/rEYl+ExKOVGGCzGOfcsjStTh5tcPCCfmz
         033L2Hci8tMZeLPKZXHGA9TvR/BZnYguyuGBUdJZbziVfC3GtHKTpViGLyWGByvw7h+t
         m1ZIAM5o9Y/6NXmhsGUhGe3x1RDrDm8tjfpX0GZYxDtwGVJEocXu3fsSzGHOS5Wiba7P
         FxzLi9N6Qsep4o2TltSr4acKgCwfkjq5l2QAvkIwqfMpHxiV+Rn1IU+h00H0tkNkGeBe
         cPGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758935840; x=1759540640;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JP6jNuOzuaZrN4jqHuCq7vrrzkS8UserW/hueLrBex8=;
        b=XBw+iq1R3/W3sNYcrSTAVQ8IrNB//qMqig2mIocRndUi3HjoJ0x1Uzal+I3gLkVNP9
         WvNNm0kFks6vztYMovnmRvVKpEygZGUtCVFCZ3G4v6x4czCXu1KGX/d6NYeExBLukWQd
         xddG/svaoiOzvmo8E4T4976phFl1kS2eVFTbYfCnj5qwANbqeq8gWiHItModBJT+8RQW
         oyYsdoh7AmTfW6oO+vEmurNY+XQkGrVX1oAE0W7w6f/bf8SDP2/8jW07e+eJc6gP5cz8
         W/jYYlYVAUEQr+5a6Vt+066VFidAQ2fqt6nNWrkbBnidQqsiasPM9LTqgIWl/ecYh2oL
         jmJQ==
X-Forwarded-Encrypted: i=1; AJvYcCX44E33n+cjZHbWpkh6go3lFJRIzGzAqtuyRFFnGi/2pYruY6KogT077nNRT2j+MauhpuVp2TE2MuCvOFI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCea7g0qLqJ40BxUmjyS/hfx2vKzzMWAFEG+wnru9xekYG/8pE
	HVnypuIeWME5t6q9lc1vNroPw97+TGS1HFL55QopJHDiDiThyXqofJnkVXMapfrtWIhZSOiOqHL
	/AlBLJBTAUIfMjMuRbqKUfF3ZLlXdxeAhjOyCj6y5
X-Gm-Gg: ASbGnctGdbkfXH0nP7Y/ykqfgQBoYb4r4cCnzaFax/DxKBDY0SzN5vr8E1unWcbfYYC
	CXzJipbmjh/VGEkUNq7xv6s6Vj5q/9ESFUsOFCHAXcE2/mUq8h/8BwhZBFGvxj8Aj70k9EKmBcm
	hFhD51Xl8ziO3+LxY7uChyFaGeSzl+hZqejaBduIewqJqjhfRXh32/YFbs9Kx4m5doxSrYuyrnY
	VsywWEXvTZX
X-Google-Smtp-Source: AGHT+IGpoONlCIOAmMBpkfhbwwmRo6WPxhB3OyNDNkTIiNF4jxrBqrGuAWP/ZktJKaI8KQeNzgcj6VefKfyiJbBSYPU=
X-Received: by 2002:a05:6e02:2589:b0:425:7759:802b with SMTP id
 e9e14a558f8ab-42865823250mr3145845ab.3.1758935839686; Fri, 26 Sep 2025
 18:17:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250910-slub-percpu-caches-v8-0-ca3099d8352c@suse.cz> <20250910-slub-percpu-caches-v8-22-ca3099d8352c@suse.cz>
In-Reply-To: <20250910-slub-percpu-caches-v8-22-ca3099d8352c@suse.cz>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 26 Sep 2025 18:17:08 -0700
X-Gm-Features: AS18NWC10t7P1-gbNUaB2koz9Kn412M7cqwnvwuIUDJz-je5B49gAVgPRT2D2pk
Message-ID: <CAJuCfpGhv15YLyAm7X63t5gT9hkw+6PK3GZbWmOTng+AG7rEsg@mail.gmail.com>
Subject: Re: [PATCH v8 22/23] maple_tree: Add single node allocation support
 to maple state
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
>  include/linux/maple_tree.h       |  4 +++-
>  lib/maple_tree.c                 | 47 ++++++++++++++++++++++++++++++++++=
+-----
>  tools/testing/radix-tree/maple.c |  9 ++++++--
>  3 files changed, 51 insertions(+), 9 deletions(-)
>
> diff --git a/include/linux/maple_tree.h b/include/linux/maple_tree.h
> index 166fd67e00d882b1e6de1f80c1b590bba7497cd3..562a1e9e5132b5b1fa8f8402a=
7cadd8abb65e323 100644
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
> index a3fcb20227e506ed209554cc8c041a53f7ef4903..a912e6a1d4378e72b967027b6=
0f8f564476ad14e 100644
> --- a/lib/maple_tree.c
> +++ b/lib/maple_tree.c
> @@ -1073,16 +1073,23 @@ static int mas_ascend(struct ma_state *mas)
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
> @@ -1093,9 +1100,34 @@ static inline struct maple_node *mas_pop_node(stru=
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

Hmm, I don't get the above logic. One node is requested and instead of
using possibly available mas->alloc, we jump to using mas->sheaf and
freeing mas->alloc... That does not sound efficient. What am I
missing?

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
> +               kfree(mas->alloc);
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
> @@ -5180,8 +5212,11 @@ void mas_destroy(struct ma_state *mas)
>         mas->node_request =3D 0;
>         if (mas->sheaf)
>                 mt_return_sheaf(mas->sheaf);
> -
>         mas->sheaf =3D NULL;
> +
> +       if (mas->alloc)
> +               kfree(mas->alloc);
> +       mas->alloc =3D NULL;
>  }
>  EXPORT_SYMBOL_GPL(mas_destroy);
>
> @@ -5816,7 +5851,7 @@ bool mas_nomem(struct ma_state *mas, gfp_t gfp)
>                 mas_alloc_nodes(mas, gfp);
>         }
>
> -       if (!mas->sheaf)
> +       if (!mas->sheaf && !mas->alloc)
>                 return false;
>
>         mas->status =3D ma_start;
> diff --git a/tools/testing/radix-tree/maple.c b/tools/testing/radix-tree/=
maple.c
> index 72a8fe8e832a4150c6567b711768eba6a3fa6768..83260f2efb1990b71093e4569=
50069c24d75560e 100644
> --- a/tools/testing/radix-tree/maple.c
> +++ b/tools/testing/radix-tree/maple.c
> @@ -35085,10 +35085,15 @@ static unsigned char get_vacant_height(struct m=
a_wr_state *wr_mas, void *entry)
>
>  static int mas_allocated(struct ma_state *mas)
>  {
> +       int total =3D 0;
> +
> +       if (mas->alloc)
> +               total++;
> +
>         if (mas->sheaf)
> -               return kmem_cache_sheaf_size(mas->sheaf);
> +               total +=3D kmem_cache_sheaf_size(mas->sheaf);
>
> -       return 0;
> +       return total;
>  }
>  /* Preallocation testing */
>  static noinline void __init check_prealloc(struct maple_tree *mt)
>
> --
> 2.51.0
>

