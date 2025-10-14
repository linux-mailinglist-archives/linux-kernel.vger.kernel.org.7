Return-Path: <linux-kernel+bounces-853072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CC91BDA951
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 18:13:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1A7D3AD718
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 16:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E7D9301466;
	Tue, 14 Oct 2025 16:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TZh4yLNy"
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E311DD0D4
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 16:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760458377; cv=none; b=heX/rmsBy/nayrPdNzHy6H9CBQIJHRFPt7O+7tOimUHNWfwT3QirvfJGIoy8zic+6pyUylFKLiKIs927uTNYsLj+LR0wUkqnaUbAdGgos0BuoXqhFGZ3pCdSZu79meWE1VZ9qX411rXHC+xlwH8d/WSp0xoCteTD6PP1AVbpzvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760458377; c=relaxed/simple;
	bh=O8Tq4MsJHxlW1U0Ha1xoCRqGAsT3LOYjvEC8SdmdklE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GZHy4ZzzMEm5ifPSCuGSOKDmpOS8Amk9CKZ6MgkFPBeLISkD1F0ZFvQktMEVpT8Qe9lLDkI5PAS6IdUxgHjPcm0WzA8a8kWG1CNh3/jcQU5cRIMmXUF/stusEGFU3jjVueamk7N7gKsSv1osF4sLTHaCWnX9gGcBeY5NlEGPiJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TZh4yLNy; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-42d7d0c58f9so1106805ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 09:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760458375; x=1761063175; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1l4EKKqI8FBMhyIpr+zCVYKqGmbIAtFPgpDTTeM4gt4=;
        b=TZh4yLNydNF9IYlvYfcDRI+LqRZxeoIXlN6xmQulg5iQoBFewSRXdz2YONzZLUH3MP
         UOJXea1oaXnks3DzGjFFlDE7ajEkwfXWJ4/yqhk02mZJp7A7m17hmm5ERU27he+UZe1J
         pKYN0hNHPzUfP+SuXTGCIOmZmdDgEcHLwONI8NtXMiaYREq73niZgNXP2hJSSOKa9msx
         l3BJbHFIbVsx9Ugqa6sAxNTlPQIJ/3k2h1yNyliG9+jdA0Fr8XYp1I6tf2PVxENoPvGY
         1pXgNYXWTDaSxjayl21SPr+qv6ofHTn8O7m3uGgpqZmAnX0MkcfFIr3qv7xI9J5Hne/H
         qprw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760458375; x=1761063175;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1l4EKKqI8FBMhyIpr+zCVYKqGmbIAtFPgpDTTeM4gt4=;
        b=dvpM2Dg3oaefTckRNeMKKX2egZMdOWTmyU5JAGpDgwOCTwZIOILkHV4TVVupctiXey
         ITKX8pQJ2qL/M6v/5DOW5ZN8Z94DVlYJ+belX8bLcBsMTeAghiO7vKbcPruCXZqDZEq8
         hwJJZfL5LyGBITdJuZFwqlOxN8e/+EU+uZS4AeTHV8J/47HTXYT4PzXbruI+BUbHWFz2
         u0O9zjPTp9Y6j48WngxUZlRwlCo4xOVCFKIZBYo2P/WZ7jD/+IhN9jTpYLr/NJZ1nNVa
         WFlaLFIWp/vIqczXDYHJhjd8pS9UAKC/G42EuxMAuPCUMHeyCb/JSDHhC/8uInEMOXbC
         KupA==
X-Forwarded-Encrypted: i=1; AJvYcCWsvz1QwI8LdpIO3FqyI7OXAH/037XAox+S7LGZTES4rSNiy+JIdkHbywMs22Y9rGZwSFJ1bsstVSZId/Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJjyABy1JP4DYHJ+87+zFJDtxnRK9T3/Cm9430OWWKuVzOOBs2
	SW0T5Cf4E8aU0Iyynh9la/TEDP+jApNRgf6To6bftVTElvfB1Kf7VkOjzd/f27LJwsa20OfRCXT
	M6swoMT8PNgP2LOKmVI8dBzbumEFS4eyX5CVtNbGh
X-Gm-Gg: ASbGncs3YmTl8L9iVIWf9uwt2wK5ZVANC18iWjmorpnSvoleDAiSLLJBjyscv2rXAhJ
	b8OU0evU8AXIRRnudXTaeC3i1K9O9E6Dr5M+fpmG+sJ+ZO3/qkhONLpeaTHCiMlXQbzbKSW+Pnp
	5KgPRTHuHn0sRxiVZGCPArqppYTZH8XyWee4RHL5Pz4bqzT31vidLwYHBWuVWzUyziNiR6gtgUX
	wfc+kLKYz/UqrhfzHPDmUz2iu7jEOKGHdcTDrQ3O5DjjlQzYGfiSXX9hjii6sRIETZhCZUsuQ==
X-Google-Smtp-Source: AGHT+IHsxfkI3RqV60s+4SmwuFMESPV6szhVrpxfuVQ107I5yLh6CGiq1Si9ni7nugofNA3QUKMsfNaQEUkOomFVGCk=
X-Received: by 2002:ac8:5987:0:b0:4b4:9590:e091 with SMTP id
 d75a77b69052e-4e6eab2cd23mr44696741cf.5.1760458374781; Tue, 14 Oct 2025
 09:12:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251014152751.499376-1-hao.ge@linux.dev>
In-Reply-To: <20251014152751.499376-1-hao.ge@linux.dev>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 14 Oct 2025 09:12:43 -0700
X-Gm-Features: AS18NWCAriF2eEUZLKRahG6-w3sbYVxwVeVbddImCwABMJPof2QmTeFqw72OU9Q
Message-ID: <CAJuCfpGBxUmvWoe2xv2-bsF+TY4fK-m1-Z_E3OcyTiSYz5KeAA@mail.gmail.com>
Subject: Re: [PATCH v3] slab: Add check for memcg_data != OBJEXTS_ALLOC_FAIL
 in folio_memcg_kmem
To: Hao Ge <hao.ge@linux.dev>
Cc: Vlastimil Babka <vbabka@suse.cz>, Alexei Starovoitov <ast@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Harry Yoo <harry.yoo@oracle.com>, cgroups@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Hao Ge <gehao@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 14, 2025 at 8:28=E2=80=AFAM Hao Ge <hao.ge@linux.dev> wrote:
>
> From: Hao Ge <gehao@kylinos.cn>
>
> Since OBJEXTS_ALLOC_FAIL and MEMCG_DATA_OBJEXTS currently share
> the same bit position, we cannot determine whether memcg_data still
> points to the slabobj_ext vector simply by checking
> folio->memcg_data & MEMCG_DATA_OBJEXTS.
>
> If obj_exts allocation failed, slab->obj_exts is set to OBJEXTS_ALLOC_FAI=
L,
> and during the release of the associated folio, the BUG check is triggere=
d
> because it was mistakenly assumed that a valid folio->memcg_data
> was not cleared before freeing the folio.
>
> So let's check for memcg_data !=3D OBJEXTS_ALLOC_FAIL in folio_memcg_kmem=
.
>
> Fixes: 7612833192d5 ("slab: Reuse first bit for OBJEXTS_ALLOC_FAIL")
> Suggested-by: Harry Yoo <harry.yoo@oracle.com>
> Signed-off-by: Hao Ge <gehao@kylinos.cn>

Reviewed-by: Suren Baghdasaryan <surenb@google.com>

nit: I think it would be helpful if the changelog explained why we
need the additional check. We can have the same bit set in two
different situations:
1. object extension vector allocation failure;
2. memcg_data pointing to a valid mem_cgroup.
To distinguish between them, we need to check not only the bit itself
but also the rest of this field. If the rest is NULL, we have case 1,
otherwise case 2.

> ---
> v3: Simplify the solution, per Harry's suggestion in the v1 comments
>     Add Suggested-by: Harry Yoo <harry.yoo@oracle.com>
> ---
>  include/linux/memcontrol.h | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 873e510d6f8d..7ed15f858dc4 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -534,7 +534,9 @@ static inline struct mem_cgroup *get_mem_cgroup_from_=
objcg(struct obj_cgroup *ob
>  static inline bool folio_memcg_kmem(struct folio *folio)
>  {
>         VM_BUG_ON_PGFLAGS(PageTail(&folio->page), &folio->page);
> -       VM_BUG_ON_FOLIO(folio->memcg_data & MEMCG_DATA_OBJEXTS, folio);
> +       VM_BUG_ON_FOLIO((folio->memcg_data !=3D OBJEXTS_ALLOC_FAIL) &&
> +                       (folio->memcg_data & MEMCG_DATA_OBJEXTS),
> +                       folio);
>         return folio->memcg_data & MEMCG_DATA_KMEM;
>  }
>
> --
> 2.25.1
>

