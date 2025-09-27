Return-Path: <linux-kernel+bounces-834746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86E7EBA5685
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 02:07:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32B932A50AF
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 00:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89DD3EAD7;
	Sat, 27 Sep 2025 00:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iAFm10NW"
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C89F4A04
	for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 00:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758931620; cv=none; b=WwZ04ngDJMXsRm9fDpWuBuHWfJDFyeSe4Gbdoq1vj59H93iKiOzlzRVlHoglV0RZQ5yHBhip2RUlNQnpp8Oy/NwHpkCiK08bCtIYU79F5J9u6BAxaozY5znmDoePXHeIZu9zLE0GHKiUGCs0B0gm9AfdjyL3n4QSX3FzkNVtgsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758931620; c=relaxed/simple;
	bh=036aeQxb7WNVe5QUIlOs/NMHl2lCy8OynAYON6MVBhc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HrCard4JVkoojhJrLH0fZw0ecpkq5TCjG2mQ6uaO/lLjHFQvcWBEIWh+nrj5Zf4deOpjqAo/27qd68/Vak09B/bhOZ+GfOc112WO1moxEdSPszh8p8yLGzBUv7x4Sr7/+VrWeAnLTkWV0i/WqOXPcV5UlFDsJH1FWye/eaM6L+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iAFm10NW; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4dcc9cebfdfso74301cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 17:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758931618; x=1759536418; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=29URIb6wX4cuu5zaywUpqrFkDEdk6T+tY2Shq6upRwU=;
        b=iAFm10NWDG+D0DP1zUtX6acT+eMGOBp9HEnBTw3CDbsPjO9nHeUN84pWFbkV8WDmAs
         NcSBF41JosPbTjagiYkkE8rFDrwOPo/hm6eqprvyTp2/B9ANP/UtmRAoiZcZgW+TMqp8
         uGS3A89NCaXX+MZfQiGGpH+KLKbujaFlQ9YiU4NQCXgQ4HZjAOHm9AtC0AGLnVwpQMAl
         wwo2xWmIFP46pNGtnvK5ZIyEc3y6wzExld2xqZaEo3J/r4Le/U2r8n0cL20URCvswJhb
         f/r4GKiGtviMfoRxKQYKVPnsmB0zpKvVqJHR24/41SoTEy3LCLbCjnjWc6EijxERRchn
         MLgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758931618; x=1759536418;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=29URIb6wX4cuu5zaywUpqrFkDEdk6T+tY2Shq6upRwU=;
        b=o1haXNeQF2UgAZV1tMw17REyjMEkEs7p/l3s6Sfjk83OwBxj3359opw7svR6R0qr+u
         9Z+e6Ne4UpnoBm13ldSxfhlkcMVU25wrkC5L0flDl2ulLXGgmvSO68C/pvAWzOvdmuBC
         vBdIVPU7rhDs6yhvgOaMzYAPc660g7I9WYh9TUc10DKZtlIBWzU6Ct55tNtBAgOkpq/Q
         ePM7r8YFypviMc1H5dH1rfUmPBF9+tedglbnN2XbYpMUhxeTmm5OXLfl4LUvCD/CTuxD
         SXjIftnULrFKMfNqgvo1PSZiLhEihI6FurIRl36aviP66UXF6U95rDPxTei7dgyOalwu
         HECw==
X-Forwarded-Encrypted: i=1; AJvYcCVWp8YuLyp8pR1ax0FSqweEfTGXtAZ/mw4dmZcpZCXPeeO/a2bHTv44d5Ip7+ivE0TTizSf3qJ8d5n9DFY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbPFNn1Bcy/57TJcnD4NDe01XKLno3NMgw/LzN9XSvywEiWf8C
	vaQoweciYhsCr+xMuvCA+tPhIfhgEowNJr7LXnFuPbG27SPvDjrwLjweykYG5/5Brw3LLjz5Xi5
	h91N6g9RrSEH46vrwLG7D5mbN0HfQyV9OPj0SpPLG
X-Gm-Gg: ASbGncsqEjARG9SRdKaKCv2soVuPo8VGr9Pb8hNjZ6uDkp5hXs5J8JvI24vQsM87sip
	aQ9uAXw6QbMLVZFK3SgPEYCOz85UNBzfw0uPsDmuzUutWUrPmuCQTQrTME2bBUGd1x1cvLS9ItB
	qY7whKtjxkXsM2DFMZfLNyR6tIJd5LIqEXMd60ewx7Yzubb7C6l0EdrSoofG/VKiJ9n7jIPNPlE
	cjPxgzyw/Th
X-Google-Smtp-Source: AGHT+IFLiPgOBV8XSsUKwdgG6fhVNyESUNEXNTrbN+fpy6JAU34fytC+R1DM6IrlpNVPcOxzkPi/LyegQctKAtiDAEI=
X-Received: by 2002:a05:622a:594:b0:4b5:d6bb:f29b with SMTP id
 d75a77b69052e-4dd1814d209mr9393231cf.8.1758931617891; Fri, 26 Sep 2025
 17:06:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250910-slub-percpu-caches-v8-0-ca3099d8352c@suse.cz> <20250910-slub-percpu-caches-v8-19-ca3099d8352c@suse.cz>
In-Reply-To: <20250910-slub-percpu-caches-v8-19-ca3099d8352c@suse.cz>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 26 Sep 2025 17:06:46 -0700
X-Gm-Features: AS18NWCLx8WOW3heEQMMsOLSgr3nS73twxKZ6ISWcyS9VFRYNVbTzAIxYGqOzSQ
Message-ID: <CAJuCfpEJ=-=NqmbZpQOGKsxfW1DQsn3_gusQxeJG8E6hVthgmQ@mail.gmail.com>
Subject: Re: [PATCH v8 19/23] maple_tree: Replace mt_free_one() with kfree()
To: Vlastimil Babka <vbabka@suse.cz>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Christoph Lameter <cl@gentwo.org>, 
	David Rientjes <rientjes@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Harry Yoo <harry.yoo@oracle.com>, Uladzislau Rezki <urezki@gmail.com>, 
	Sidhartha Kumar <sidhartha.kumar@oracle.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org, 
	maple-tree@lists.infradead.org, Pedro Falcato <pfalcato@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 10, 2025 at 1:01=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> From: Pedro Falcato <pfalcato@suse.de>
>
> kfree() is a little shorter and works with kmem_cache_alloc'd pointers
> too. Also lets us remove one more helper.
>
> Signed-off-by: Pedro Falcato <pfalcato@suse.de>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

Reviewed-by: Suren Baghdasaryan <surenb@google.com>

> ---
>  lib/maple_tree.c | 13 ++++---------
>  1 file changed, 4 insertions(+), 9 deletions(-)
>
> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> index c706e2e48f884fd156e25be2b17eb5e154774db7..0439aaacf6cb1f39d0d23af2e=
2a5af1d27ab32be 100644
> --- a/lib/maple_tree.c
> +++ b/lib/maple_tree.c
> @@ -177,11 +177,6 @@ static inline int mt_alloc_bulk(gfp_t gfp, size_t si=
ze, void **nodes)
>         return kmem_cache_alloc_bulk(maple_node_cache, gfp, size, nodes);
>  }
>
> -static inline void mt_free_one(struct maple_node *node)
> -{
> -       kmem_cache_free(maple_node_cache, node);
> -}
> -
>  static inline void mt_free_bulk(size_t size, void __rcu **nodes)
>  {
>         kmem_cache_free_bulk(maple_node_cache, size, (void **)nodes);
> @@ -5092,7 +5087,7 @@ static void mt_free_walk(struct rcu_head *head)
>         mt_free_bulk(node->slot_len, slots);
>
>  free_leaf:
> -       mt_free_one(node);
> +       kfree(node);
>  }
>
>  static inline void __rcu **mte_destroy_descend(struct maple_enode **enod=
e,
> @@ -5176,7 +5171,7 @@ static void mt_destroy_walk(struct maple_enode *eno=
de, struct maple_tree *mt,
>
>  free_leaf:
>         if (free)
> -               mt_free_one(node);
> +               kfree(node);
>         else
>                 mt_clear_meta(mt, node, node->type);
>  }
> @@ -5385,7 +5380,7 @@ void mas_destroy(struct ma_state *mas)
>                         mt_free_bulk(count, (void __rcu **)&node->slot[1]=
);
>                         total -=3D count;
>                 }
> -               mt_free_one(ma_mnode_ptr(node));
> +               kfree(ma_mnode_ptr(node));
>                 total--;
>         }
>
> @@ -6373,7 +6368,7 @@ static void mas_dup_free(struct ma_state *mas)
>         }
>
>         node =3D mte_to_node(mas->node);
> -       mt_free_one(node);
> +       kfree(node);
>  }
>
>  /*
>
> --
> 2.51.0
>

