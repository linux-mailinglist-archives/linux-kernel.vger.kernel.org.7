Return-Path: <linux-kernel+bounces-782659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33F18B32349
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 21:59:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85FC817A381
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 19:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7FE82D663B;
	Fri, 22 Aug 2025 19:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Hm25WOZF"
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 850ED2C21C1
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 19:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755892734; cv=none; b=HPjyCLqizI0a7JIvjzPTWobwk0j8QE4usfL+wq5Zpb7hWJdUdvL9Aa8r8yz1bpP94Em3AdJ9W/emjyeH6CTb1hJD6wPEtOp4RbgcgbuRedYXXGAvfFsbDoR41SRHs9p9nYkLvs/oxP3P2QEFyhpGg4cKDCPEVUMOhWBufjRRA6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755892734; c=relaxed/simple;
	bh=0bpzj0cYUX4ZSa6GcaVCsPrhX/HSDbWBDDsp5llwFEc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IOnwLoF0a1OzlBnFB7IanhlZDp8Hwp3f6KSa7eOtyXAUxgF07ANAyEtILyRLtYY64KuQiTFVv/XOHet32ER5rkrA3Y5p9DwdKK+6B9Ixgp60ioCJWRGtcfic3PaeV/LFOwr9pcOOTdOwybANrWwIc0D8+C8lB8/aQUa/oJxrdjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Hm25WOZF; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4b29b715106so15191cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 12:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755892731; x=1756497531; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1zbL7KxWZEdFtClBa6fqt36ZA0mgbM0HT/V3o4VWa5g=;
        b=Hm25WOZFTRTvoa9Gz2sWojo93xy07l8AfCl8PndB3lSL63E+maR6gitr0Xdu0Cb5Qq
         lwCycTaM7H8YSBPfRbBqj8nZWP+O7CtD3Uau3T67LVOgecxYG67sxxgZ/KGYzlGxOJMX
         R7gmvGZqggKb/OcmqEF2Hma+oImdX693TY7RpL3xue/foHk3h+LOYKbzaYlai+7AfSj9
         vv8eGb1lwRoq7iFs1BrsLFHQP9EmUrImTYMuCSn9vNguZyRpOghAMPqdaO09Pu0Xfu7p
         mawad1umpmPmmHklJZLfCM/eK9jtFklQ1k9kbGyOgfrLKldcdlH9+mQUWyuFpQaorWef
         t4pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755892731; x=1756497531;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1zbL7KxWZEdFtClBa6fqt36ZA0mgbM0HT/V3o4VWa5g=;
        b=JaquUKdNvYBh1tzFzsbkZfYKTrRyflzqFPsfv80CZkOQkSfmciX3AVZX5ZUziAwBA+
         QrNpTCEywRVK+9LcwFPXwTO0Sm4Jc2SXgBAqQPPQStZ2Po3VnmPoPh6kBOoUfwoeFeNo
         W97FNlEydNPcakfGS1g7iQE1Mr0rQgRmaHfV7JQvcXCkWjzWFF/UqD87g/x0uhZD3Cru
         hqI5Y7c3madsCSFmZnxw8byq6rYSAxUPjMe8is9wZHxcieCAXciFKh8/UmGKi4FrShxV
         1F0Cbbx/seoJ59uExe5F73xyVbHlnt6fngorg6xZwhzTY/R89pTpIfkcqriqbhQnqr9B
         M0CQ==
X-Forwarded-Encrypted: i=1; AJvYcCWbBvoALeQuve4FU4cga2NaBw2dzeH5Mmr1T3icA3T68P9pzChXIl3aAGVVEQQp16pheu6aogwMQRG1ssk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxX9xk984KYeGlhfNuOFWAuFjPSvTfnjj0BSJYhG/0qcvypf/AT
	uRzad4365P8paGkYorCmkXJY5BJK6U1dz3ZWoUySvO+AuKSdfuOfIpYv24YHMcSifzdg1Cg+Qba
	zBOXJTdO0dFKqKjc/zmVvHapQjHLMnZP2dzDTKaq8
X-Gm-Gg: ASbGncsH6InuKPUtwyskU5dOj8KBlsrpg5QPx5BrU/qNLA30AbvWDcq6oyWkIYaJCwV
	qImgsCuthtIci60Vrf7+NBZ7MybA7fuwzuJ0NZeQgpuRcj5CO/ghE/HrJmRceCDaXmYFQ8ThHU2
	1Mm7OVxQ0sLx/OTrlgNErCA9emJHUDUckyOA5F4+kt/DaZnBft88EPJxqWIpWcWKBPt06eKbzj9
	hL0IfG5JoBn5UCaH9Q0hms=
X-Google-Smtp-Source: AGHT+IFkGBfHZ2+PDQQ6XW2JA5HA4716qCgCxznra7rjS8t9rVJmfjNGxXpArpYN4u40i4cniAw7m/bxlDqhU+rScjw=
X-Received: by 2002:ac8:7f47:0:b0:4a9:e17a:6287 with SMTP id
 d75a77b69052e-4b2ba9faaefmr646441cf.7.1755892730905; Fri, 22 Aug 2025
 12:58:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250723-slub-percpu-caches-v5-0-b792cd830f5d@suse.cz> <20250723-slub-percpu-caches-v5-10-b792cd830f5d@suse.cz>
In-Reply-To: <20250723-slub-percpu-caches-v5-10-b792cd830f5d@suse.cz>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 22 Aug 2025 12:58:40 -0700
X-Gm-Features: Ac12FXxtiMpVk0VN-fqcAsXzDvd7uIQeiITE8KpMBbIe5MvmOPVwZb-kbSUcaTc
Message-ID: <CAJuCfpHdBJ+9zkT+8AbTkV+cGx4td5t9-Gdtf-jUW8G0RZHKHg@mail.gmail.com>
Subject: Re: [PATCH v5 10/14] mm, slab: allow NUMA restricted allocations to
 use percpu sheaves
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
> Currently allocations asking for a specific node explicitly or via
> mempolicy in strict_numa node bypass percpu sheaves. Since sheaves
> contain mostly local objects, we can try allocating from them if the
> local node happens to be the requested node or allowed by the mempolicy.
> If we find the object from percpu sheaves is not from the expected node,
> we skip the sheaves - this should be rare.
>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  mm/slub.c | 52 +++++++++++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 45 insertions(+), 7 deletions(-)
>
> diff --git a/mm/slub.c b/mm/slub.c
> index 50fc35b8fc9b3101821c338e9469c134677ded51..b98983b8d2e3e04ea256d91ef=
cf0215ff0ae7e38 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -4765,18 +4765,42 @@ __pcs_handle_empty(struct kmem_cache *s, struct s=
lub_percpu_sheaves *pcs, gfp_t
>  }
>
>  static __fastpath_inline
> -void *alloc_from_pcs(struct kmem_cache *s, gfp_t gfp)
> +void *alloc_from_pcs(struct kmem_cache *s, gfp_t gfp, int node)
>  {
>         struct slub_percpu_sheaves *pcs;
>         void *object;
>
>  #ifdef CONFIG_NUMA
> -       if (static_branch_unlikely(&strict_numa)) {
> -               if (current->mempolicy)
> -                       return NULL;
> +       if (static_branch_unlikely(&strict_numa) &&
> +                        node =3D=3D NUMA_NO_NODE) {
> +
> +               struct mempolicy *mpol =3D current->mempolicy;
> +
> +               if (mpol) {
> +                       /*
> +                        * Special BIND rule support. If the local node
> +                        * is in permitted set then do not redirect
> +                        * to a particular node.
> +                        * Otherwise we apply the memory policy to get
> +                        * the node we need to allocate on.
> +                        */
> +                       if (mpol->mode !=3D MPOL_BIND ||
> +                                       !node_isset(numa_mem_id(), mpol->=
nodes))
> +
> +                               node =3D mempolicy_slab_node();
> +               }
>         }
>  #endif
>
> +       if (unlikely(node !=3D NUMA_NO_NODE)) {

Should this and later (node !=3D NUMA_NO_NODE) checks be still under
#ifdef CONFIG_NUMA ?

> +               /*
> +                * We assume the percpu sheaves contain only local object=
s
> +                * although it's not completely guaranteed, so we verify =
later.
> +                */
> +               if (node !=3D numa_mem_id())
> +                       return NULL;
> +       }
> +
>         if (!local_trylock(&s->cpu_sheaves->lock))
>                 return NULL;
>
> @@ -4788,7 +4812,21 @@ void *alloc_from_pcs(struct kmem_cache *s, gfp_t g=
fp)
>                         return NULL;
>         }
>
> -       object =3D pcs->main->objects[--pcs->main->size];
> +       object =3D pcs->main->objects[pcs->main->size - 1];
> +
> +       if (unlikely(node !=3D NUMA_NO_NODE)) {
> +               /*
> +                * Verify that the object was from the node we want. This=
 could
> +                * be false because of cpu migration during an unlocked p=
art of
> +                * the current allocation or previous freeing process.
> +                */
> +               if (folio_nid(virt_to_folio(object)) !=3D node) {
> +                       local_unlock(&s->cpu_sheaves->lock);
> +                       return NULL;
> +               }
> +       }
> +
> +       pcs->main->size--;
>
>         local_unlock(&s->cpu_sheaves->lock);
>
> @@ -4888,8 +4926,8 @@ static __fastpath_inline void *slab_alloc_node(stru=
ct kmem_cache *s, struct list
>         if (unlikely(object))
>                 goto out;
>
> -       if (s->cpu_sheaves && node =3D=3D NUMA_NO_NODE)
> -               object =3D alloc_from_pcs(s, gfpflags);
> +       if (s->cpu_sheaves)
> +               object =3D alloc_from_pcs(s, gfpflags, node);
>
>         if (!object)
>                 object =3D __slab_alloc_node(s, gfpflags, node, addr, ori=
g_size);
>
> --
> 2.50.1
>

