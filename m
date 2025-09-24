Return-Path: <linux-kernel+bounces-830926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B3479B9AEC3
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 18:53:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0FAE1B28138
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 16:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C2CE314A90;
	Wed, 24 Sep 2025 16:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DPW1E8Yw"
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 441B43128DE
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 16:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758732789; cv=none; b=VU4mIHFhN3law7yKwGKV1327B7dEgnaECyrLhI1TOWcIYDJMNF8emcdTI7ArPRSRkijEWt3MVlJx01SgqHyb5R859wo+MAztdm82HYfqb90g8qTwizlgG6cDTo5wTilf6iKWtnZY9JpgkQLgJ/X18+az6KvC/sTMQA/hvymShvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758732789; c=relaxed/simple;
	bh=nMKNSlgd+7V+f9mWKnNERKzzRCQYc2/BYVK3sw3Dg48=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b1A9CuBsxJ1qLhC3WuW9L583x2nsjQcd0cTvSLxkJ0QEd8yZxFi6khkgTKyg+l253V8JNmf85rAxxsiyctpDZk4ddvaSiyVrtvL/hkar2lghirNZyenn3ZMtFkVrcX4Fwdrim8GUXyJ2l6oryM3RL5mMnEnZjzaQcXzZ2YFfccY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DPW1E8Yw; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4c73047a75cso189331cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 09:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758732787; x=1759337587; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rAL5Cu+UfMQz37OQN1YYrMC/83wElraN+KKVT4FmBP0=;
        b=DPW1E8Yw3QdSPQvHnYln+GZgMDUMuVvYyWbSMfcRif/ZD3NBnWpfLzwVZlr+ThLc5/
         cHmevYxRB/NhIA4Yuc6C0SH9QZ6eibastWiHkUItYXocXRUs4uTrAevZXUGlbqgQW6pR
         LwQYrXMAk2KizIQCxoQj+AU8NmrCelMyRszZFrTWO2LcsKHxFNlRcCpsK7qDtlROrpNF
         Gwd/Et9s7PsEppE3vW2DH2HsqQ/toK4tIsMKl8NpExdimxH4Fa1TwgnN+n3t+3jL7Ek7
         VDmG6MICHvUgHZ7iz+jPghKBF7b6JjtRBmuBKJZakmN6P+AArSI7xy3YUkBNMDiynsu6
         zUtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758732787; x=1759337587;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rAL5Cu+UfMQz37OQN1YYrMC/83wElraN+KKVT4FmBP0=;
        b=N/0JxSJb9DZ5VY+RIpMg7tMzT8vaJBdyaM8JeXKz+ag1Eyf2gN7oKnBHeA2/7PbtLZ
         13DRmInDipSozvYghRuMXwP88XsYYllJOWUzryHe+QDErmEUuYgLBixnAfXGVtzYVeHz
         aRn2LQSwGJ1N9RHTMaWDSu4F2muQqKgRmuodDYxlS0hKjKD9pygseBZbkvdOe//RK3OM
         eaDWe5LoJ9Duw6170LpIx3/t469o2cfa8WJfZhfkq66nkpj+J1biFPNCje5e/8z7IwPG
         o/q6+ftgEZFaxxIrBRgkMhWuUBvE3Om5CYcw3sNbsgSPSdndZwi4kgIanCBQnzBgwNAl
         s9fQ==
X-Forwarded-Encrypted: i=1; AJvYcCWxaAGX+zwXl37G2erg5y8Gr6QecEMaicG8kVi6tvPTtM99e6cpPe8XD5r4jHfqIDEMFecgdNA3CghLT00=@vger.kernel.org
X-Gm-Message-State: AOJu0YynQeWmwnThvCXPBODJ/U8XpXcvFA/88rFInLsJjz8uRS1Oyxib
	UC/yp2oBS4NwhufIH+nBzdQxrQEwi6EX+vQGwaioNZm3oeU1mVet6oKG8yinvixKDDE+C1cKDtY
	EMzwOS9wXIZ9VfgDNThqm2Zcjr300muL4A1RSgkmn
X-Gm-Gg: ASbGncsQWjx+1TDAPCF3rtVdndc9YfOa2jJCARI+YnucPZ1PkOVHwHRmr4PT4LngPll
	GJYlcBp1QvpFMqzbh345zXbvqfSba4nhZQth7oTLtXc01xiF5QzCq/FK+qNaVD8tWwoFd7POLSJ
	0BYILu3V8VheooivKibQo67T93cXc8ufg0TGUaNZdAKjhQG8ogdiv3rWJsXZElyZNqhQqtk50h+
	nbquHOh9v8X9abK5JhV0IQweqMx8J7tlmneFYj8ObE/6Q9yg/II
X-Google-Smtp-Source: AGHT+IFM4bC1CM0lReVKUj4FdqmsLyiIGG5AgB26WGF7py0Fxnl1epvOibVW8GFjcF4KFlPv5Uc4yba9NX1j26NP/mY=
X-Received: by 2002:a05:622a:1819:b0:4b3:8ee:521b with SMTP id
 d75a77b69052e-4da23acea56mr1381191cf.0.1758732786627; Wed, 24 Sep 2025
 09:53:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250910-slub-percpu-caches-v8-0-ca3099d8352c@suse.cz> <20250910-slub-percpu-caches-v8-2-ca3099d8352c@suse.cz>
In-Reply-To: <20250910-slub-percpu-caches-v8-2-ca3099d8352c@suse.cz>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 24 Sep 2025 09:52:55 -0700
X-Gm-Features: AS18NWAeKekoZw_EZc6GYInUxqn2E30S29JpUuV_6-vLoJBFCrPesQlPq9v554g
Message-ID: <CAJuCfpHzNyQw6N5CjfNXsMLyUQem2noSm+_A3O2gm+skA7qDsA@mail.gmail.com>
Subject: Re: [PATCH v8 02/23] slab: simplify init_kmem_cache_nodes() error handling
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
> We don't need to call free_kmem_cache_nodes() immediately when failing
> to allocate a kmem_cache_node, because when we return 0,
> do_kmem_cache_create() calls __kmem_cache_release() which also performs
> free_kmem_cache_nodes().
>
> Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

Reviewed-by: Suren Baghdasaryan <surenb@google.com>

> ---
>  mm/slub.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/mm/slub.c b/mm/slub.c
> index 30003763d224c2704a4b93082b8b47af12dcffc5..9f671ec76131c4b0b28d5d568=
aa45842b5efb6d4 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -5669,10 +5669,8 @@ static int init_kmem_cache_nodes(struct kmem_cache=
 *s)
>                 n =3D kmem_cache_alloc_node(kmem_cache_node,
>                                                 GFP_KERNEL, node);
>
> -               if (!n) {
> -                       free_kmem_cache_nodes(s);
> +               if (!n)
>                         return 0;
> -               }
>
>                 init_kmem_cache_node(n);
>                 s->node[node] =3D n;
>
> --
> 2.51.0
>

