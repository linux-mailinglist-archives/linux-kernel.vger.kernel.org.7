Return-Path: <linux-kernel+bounces-855115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BABCBE046E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 20:54:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 055DE4EED3B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 18:54:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB0EB2580FF;
	Wed, 15 Oct 2025 18:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fNPST+xi"
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD36E271A71
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 18:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760554474; cv=none; b=rhVHpnJd9+s9hQw8+TUnVLOj5Qapinv8YUO2nLB4IxGtnPjNU+kWcKrxbVar8AV7pU8TPPgn4flRvXwb9EEQmR3clLzQDw3WhXsoj2aKuU3vAk0RWXkfW4snLI5zSQuPHgcxXa4UjEsOqohEBo8Dq2gwwQal1oRMsn0LJS6CnXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760554474; c=relaxed/simple;
	bh=GtAwIawNpleMozGy/SuF6YUQzBAsq2/Z1a4X7afnNlY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oJ+PVq/5C8SmeJcFvkC6Irwfjvn+Pwg2rW3NvdkmDRVd1EMCENE2t4B31nSDF4BJiNFNpAxisI22oaEu9LeN0LZYsuP8TLP9Sg4u1Ui7VD6b8cNFM1y9hxHyfUWenKHEK75vjebHcVu/D5iiU4X8ZY8JpZ75ZnesGzMaUv8EK/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fNPST+xi; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-430a0a715f9so52615ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 11:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760554472; x=1761159272; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xJqtUlUUzdHm8UIHRbAwoG+Ib2OL2NTfoQttTWYvsVA=;
        b=fNPST+xiJUKU1w+F1cNEerLxWlaGlMJF/P0epJlqW7voK7jo241d6zr672MzMm3V5K
         gI2y3HhSbVtmBrHeJ7aZaOzc0DJrgKFQQwwri5io/X1rAeAdEI3c8ouVEdtvjjiKOGyf
         sRVS0dU/P6P/+hjEIbgFu4fD/ws/gthqYt8AyBPa4CS/J4SUEiEqZ4zWS6IhO6KHQEQB
         SV2bDaoDezOiVgZsmAP1fYyEJm+IHSbfMPITXtMsKU92lSuY/u7RBSsKdpFi+PrtPIVO
         yi5Edf6DmCtkaD/Hasnl1rjexQk1S+RS7cIHQzq1AXCjiG+mzCrXQBEbIji7tGI0j5+m
         oBJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760554472; x=1761159272;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xJqtUlUUzdHm8UIHRbAwoG+Ib2OL2NTfoQttTWYvsVA=;
        b=f6zQPXkNGdr96kNHgZbEoGaEw8ADWtQnBPnTOUog8/hRF0I5olv+ww7IJK/Sv7Fb5j
         Pc9wZVUmDvYzYpdOM81CLkPO8BMP9AESsUqdtXBD/qZOpyTBiC0X+uEEASiXhYWB9h+/
         8W0ae5YpPCFmJ9HpJvsfRMsu1Z1YMaQh77A3mckxhLxfCW+dyWRbdQgBf6La78SwIxo2
         T6Kv3aD6aB+rC2sz8GFT8xFsYYUm+y0feJqd6B2Biti8refP5174lWibUzt8m0XhQ5uj
         lZHMC+zha1CtDsIeGEkGWHx8KnnpONEwCUM9ZH+5yCmGa8Eo+QJGaBZhZ1N4cDNz8dTU
         M9Yg==
X-Forwarded-Encrypted: i=1; AJvYcCUZIGevSPKOMpqwWkbLkrT4XfwzK7uT+LOTD7FUgH4ghpbaFN9qnljEPjhb3EikGOj2uhTTR+MSHE4UpxY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcqA+An6xpmrT8mz1cq5Z5k7KSUUVcapFVa3Ani1a29UZEFyf2
	zW8hY3Ok1SPd6ChdexFS3sXuXAbtBoC2g5trcCWsOyr1nfLPaP+0ta6Lpsalo8ndOPrYePeE9aN
	q2tTXx6oET2UUopQZaGwvntLxfy/PXo07In+fl8JY
X-Gm-Gg: ASbGnctt5lwpp1sSoU90RfffYg2qSoCKuLAmOUxR9bBc+PdbWpO8VhE6cpt6eHlqpTA
	W461g1Sc6GU/ID3zJw/QS01pOo2CddUbjsmQ+wD3FiUMphXffQJlhqSeQQqFTmn1+MXktTrdP0q
	8WLmhwFtskcLNmp2IU1BAYjhDS8XhhO5dU9PewgBL0rDu3DzxW8iOc2ketGzwF53hvXDJ8I0f3x
	hLLppvjeeEdLvSahGucBlAWA1MYOjE5NZiugDqbMJ7OEzWdojPn8eBSdS31VXI=
X-Google-Smtp-Source: AGHT+IHN/Cj7TZnn7sOw6L+jNnHTKiV+9kX3nTieIVtBfflK97jV5CC1cM7tjHiU8hMgwKXTQQ/8srXGHITEFpNEDE4=
X-Received: by 2002:a05:622a:4d0e:b0:4b2:ecb6:e6dd with SMTP id
 d75a77b69052e-4e884c27ba7mr8548201cf.1.1760554471168; Wed, 15 Oct 2025
 11:54:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251015-b4-pcp-lock-cleanup-v2-1-740d999595d5@suse.cz>
In-Reply-To: <20251015-b4-pcp-lock-cleanup-v2-1-740d999595d5@suse.cz>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 15 Oct 2025 11:54:19 -0700
X-Gm-Features: AS18NWBcaZXOhYjN3z_WXQTDHg1hl-Cyr9VA3WP9aqbCYSWLXKZh0FpG_6daS6E
Message-ID: <CAJuCfpELB-LX55qZYBfrSVx1+EHE0TWLiHd2AUuU1BK-JTWntQ@mail.gmail.com>
Subject: Re: [PATCH v2] mm/page_alloc: simplify and cleanup pcp locking
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>, Michal Hocko <mhocko@suse.com>, 
	Brendan Jackman <jackmanb@google.com>, Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, 
	Mel Gorman <mgorman@techsingularity.net>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Joshua Hahn <joshua.hahnjy@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 15, 2025 at 10:50=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> w=
rote:
>
> The pcp locking relies on pcp_spin_trylock() which has to be used
> together with pcp_trylock_prepare()/pcp_trylock_finish() to work
> properly on !SMP !RT configs. This is tedious and error-prone.
>
> We can remove pcp_spin_lock() and underlying pcpu_spin_lock() because we
> don't use it. Afterwards pcp_spin_unlock() is only used together with
> pcp_spin_trylock(). Therefore we can add the UP_flags parameter to them
> both and handle pcp_trylock_prepare()/finish() within.
>
> Additionally for the configs where pcp_trylock_prepare()/finish() are
> no-op (SMP || RT) make them pass &UP_flags to a no-op inline function.
> This ensures typechecking and makes the local variable "used" so we can
> remove the __maybe_unused attributes.
>
> In my compile testing, bloat-o-meter reported no change on SMP config,
> so the compiler is capable of optimizing away the no-ops same as before,
> and we have simplified the code using pcp_spin_trylock().
>
> Reviewed-by: Joshua Hahn <joshua.hahnjy@gmail.com>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

You are fast :)

Reviewed-by: Suren Baghdasaryan <surenb@google.com>

> ---
> based on mm-new
> Changed my mind and did as Joshua suggested, for consistency. Thanks!
> ---
> Changes in v2:
> - Convert also pcp_trylock_finish() to noop function, per Joshua.
> - Link to v1: https://lore.kernel.org/r/20251015-b4-pcp-lock-cleanup-v1-1=
-878e0e7dcfb2@suse.cz
> ---
>  mm/page_alloc.c | 99 +++++++++++++++++++++++----------------------------=
------
>  1 file changed, 40 insertions(+), 59 deletions(-)
>
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 0155a66d7367..fb91c566327c 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -99,9 +99,12 @@ static DEFINE_MUTEX(pcp_batch_high_lock);
>  /*
>   * On SMP, spin_trylock is sufficient protection.
>   * On PREEMPT_RT, spin_trylock is equivalent on both SMP and UP.
> + * Pass flags to a no-op inline function to typecheck and silence the un=
used
> + * variable warning.
>   */
> -#define pcp_trylock_prepare(flags)     do { } while (0)
> -#define pcp_trylock_finish(flag)       do { } while (0)
> +static inline void __pcp_trylock_noop(unsigned long *flags) { }
> +#define pcp_trylock_prepare(flags)     __pcp_trylock_noop(&(flags))
> +#define pcp_trylock_finish(flags)      __pcp_trylock_noop(&(flags))
>  #else
>
>  /* UP spin_trylock always succeeds so disable IRQs to prevent re-entranc=
y. */
> @@ -129,15 +132,6 @@ static DEFINE_MUTEX(pcp_batch_high_lock);
>   * Generic helper to lookup and a per-cpu variable with an embedded spin=
lock.
>   * Return value should be used with equivalent unlock helper.
>   */
> -#define pcpu_spin_lock(type, member, ptr)                              \
> -({                                                                     \
> -       type *_ret;                                                     \
> -       pcpu_task_pin();                                                \
> -       _ret =3D this_cpu_ptr(ptr);                                      =
 \
> -       spin_lock(&_ret->member);                                       \
> -       _ret;                                                           \
> -})
> -
>  #define pcpu_spin_trylock(type, member, ptr)                           \
>  ({                                                                     \
>         type *_ret;                                                     \
> @@ -157,14 +151,21 @@ static DEFINE_MUTEX(pcp_batch_high_lock);
>  })
>
>  /* struct per_cpu_pages specific helpers. */
> -#define pcp_spin_lock(ptr)                                             \
> -       pcpu_spin_lock(struct per_cpu_pages, lock, ptr)
> -
> -#define pcp_spin_trylock(ptr)                                          \
> -       pcpu_spin_trylock(struct per_cpu_pages, lock, ptr)
> +#define pcp_spin_trylock(ptr, UP_flags)                                 =
       \
> +({                                                                     \
> +       struct per_cpu_pages *__ret;                                    \
> +       pcp_trylock_prepare(UP_flags);                                  \
> +       __ret =3D pcpu_spin_trylock(struct per_cpu_pages, lock, ptr);    =
 \
> +       if (!__ret)                                                     \
> +               pcp_trylock_finish(UP_flags);                           \
> +       __ret;                                                          \
> +})
>
> -#define pcp_spin_unlock(ptr)                                           \
> -       pcpu_spin_unlock(lock, ptr)
> +#define pcp_spin_unlock(ptr, UP_flags)                                 \
> +({                                                                     \
> +       pcpu_spin_unlock(lock, ptr);                                    \
> +       pcp_trylock_finish(UP_flags);                                   \
> +})
>
>  #ifdef CONFIG_USE_PERCPU_NUMA_NODE_ID
>  DEFINE_PER_CPU(int, numa_node);
> @@ -2887,13 +2888,10 @@ static bool free_frozen_page_commit(struct zone *=
zone,
>                 if (to_free =3D=3D 0 || pcp->count =3D=3D 0)
>                         break;
>
> -               pcp_spin_unlock(pcp);
> -               pcp_trylock_finish(*UP_flags);
> +               pcp_spin_unlock(pcp, *UP_flags);
>
> -               pcp_trylock_prepare(*UP_flags);
> -               pcp =3D pcp_spin_trylock(zone->per_cpu_pageset);
> +               pcp =3D pcp_spin_trylock(zone->per_cpu_pageset, *UP_flags=
);
>                 if (!pcp) {
> -                       pcp_trylock_finish(*UP_flags);
>                         ret =3D false;
>                         break;
>                 }
> @@ -2904,8 +2902,7 @@ static bool free_frozen_page_commit(struct zone *zo=
ne,
>                  * returned in an unlocked state.
>                  */
>                 if (smp_processor_id() !=3D cpu) {
> -                       pcp_spin_unlock(pcp);
> -                       pcp_trylock_finish(*UP_flags);
> +                       pcp_spin_unlock(pcp, *UP_flags);
>                         ret =3D false;
>                         break;
>                 }
> @@ -2937,7 +2934,7 @@ static bool free_frozen_page_commit(struct zone *zo=
ne,
>  static void __free_frozen_pages(struct page *page, unsigned int order,
>                                 fpi_t fpi_flags)
>  {
> -       unsigned long __maybe_unused UP_flags;
> +       unsigned long UP_flags;
>         struct per_cpu_pages *pcp;
>         struct zone *zone;
>         unsigned long pfn =3D page_to_pfn(page);
> @@ -2973,17 +2970,15 @@ static void __free_frozen_pages(struct page *page=
, unsigned int order,
>                 add_page_to_zone_llist(zone, page, order);
>                 return;
>         }
> -       pcp_trylock_prepare(UP_flags);
> -       pcp =3D pcp_spin_trylock(zone->per_cpu_pageset);
> +       pcp =3D pcp_spin_trylock(zone->per_cpu_pageset, UP_flags);
>         if (pcp) {
>                 if (!free_frozen_page_commit(zone, pcp, page, migratetype=
,
>                                                 order, fpi_flags, &UP_fla=
gs))
>                         return;
> -               pcp_spin_unlock(pcp);
> +               pcp_spin_unlock(pcp, UP_flags);
>         } else {
>                 free_one_page(zone, page, pfn, order, fpi_flags);
>         }
> -       pcp_trylock_finish(UP_flags);
>  }
>
>  void free_frozen_pages(struct page *page, unsigned int order)
> @@ -2996,7 +2991,7 @@ void free_frozen_pages(struct page *page, unsigned =
int order)
>   */
>  void free_unref_folios(struct folio_batch *folios)
>  {
> -       unsigned long __maybe_unused UP_flags;
> +       unsigned long UP_flags;
>         struct per_cpu_pages *pcp =3D NULL;
>         struct zone *locked_zone =3D NULL;
>         int i, j;
> @@ -3039,8 +3034,7 @@ void free_unref_folios(struct folio_batch *folios)
>                 if (zone !=3D locked_zone ||
>                     is_migrate_isolate(migratetype)) {
>                         if (pcp) {
> -                               pcp_spin_unlock(pcp);
> -                               pcp_trylock_finish(UP_flags);
> +                               pcp_spin_unlock(pcp, UP_flags);
>                                 locked_zone =3D NULL;
>                                 pcp =3D NULL;
>                         }
> @@ -3059,10 +3053,8 @@ void free_unref_folios(struct folio_batch *folios)
>                          * trylock is necessary as folios may be getting =
freed
>                          * from IRQ or SoftIRQ context after an IO comple=
tion.
>                          */
> -                       pcp_trylock_prepare(UP_flags);
> -                       pcp =3D pcp_spin_trylock(zone->per_cpu_pageset);
> +                       pcp =3D pcp_spin_trylock(zone->per_cpu_pageset, U=
P_flags);
>                         if (unlikely(!pcp)) {
> -                               pcp_trylock_finish(UP_flags);
>                                 free_one_page(zone, &folio->page, pfn,
>                                               order, FPI_NONE);
>                                 continue;
> @@ -3085,10 +3077,8 @@ void free_unref_folios(struct folio_batch *folios)
>                 }
>         }
>
> -       if (pcp) {
> -               pcp_spin_unlock(pcp);
> -               pcp_trylock_finish(UP_flags);
> -       }
> +       if (pcp)
> +               pcp_spin_unlock(pcp, UP_flags);
>         folio_batch_reinit(folios);
>  }
>
> @@ -3339,15 +3329,12 @@ static struct page *rmqueue_pcplist(struct zone *=
preferred_zone,
>         struct per_cpu_pages *pcp;
>         struct list_head *list;
>         struct page *page;
> -       unsigned long __maybe_unused UP_flags;
> +       unsigned long UP_flags;
>
>         /* spin_trylock may fail due to a parallel drain or IRQ reentranc=
y. */
> -       pcp_trylock_prepare(UP_flags);
> -       pcp =3D pcp_spin_trylock(zone->per_cpu_pageset);
> -       if (!pcp) {
> -               pcp_trylock_finish(UP_flags);
> +       pcp =3D pcp_spin_trylock(zone->per_cpu_pageset, UP_flags);
> +       if (!pcp)
>                 return NULL;
> -       }
>
>         /*
>          * On allocation, reduce the number of pages that are batch freed=
.
> @@ -3357,8 +3344,7 @@ static struct page *rmqueue_pcplist(struct zone *pr=
eferred_zone,
>         pcp->free_count >>=3D 1;
>         list =3D &pcp->lists[order_to_pindex(migratetype, order)];
>         page =3D __rmqueue_pcplist(zone, order, migratetype, alloc_flags,=
 pcp, list);
> -       pcp_spin_unlock(pcp);
> -       pcp_trylock_finish(UP_flags);
> +       pcp_spin_unlock(pcp, UP_flags);
>         if (page) {
>                 __count_zid_vm_events(PGALLOC, page_zonenum(page), 1 << o=
rder);
>                 zone_statistics(preferred_zone, zone, 1);
> @@ -5045,7 +5031,7 @@ unsigned long alloc_pages_bulk_noprof(gfp_t gfp, in=
t preferred_nid,
>                         struct page **page_array)
>  {
>         struct page *page;
> -       unsigned long __maybe_unused UP_flags;
> +       unsigned long UP_flags;
>         struct zone *zone;
>         struct zoneref *z;
>         struct per_cpu_pages *pcp;
> @@ -5139,10 +5125,9 @@ unsigned long alloc_pages_bulk_noprof(gfp_t gfp, i=
nt preferred_nid,
>                 goto failed;
>
>         /* spin_trylock may fail due to a parallel drain or IRQ reentranc=
y. */
> -       pcp_trylock_prepare(UP_flags);
> -       pcp =3D pcp_spin_trylock(zone->per_cpu_pageset);
> +       pcp =3D pcp_spin_trylock(zone->per_cpu_pageset, UP_flags);
>         if (!pcp)
> -               goto failed_irq;
> +               goto failed;
>
>         /* Attempt the batch allocation */
>         pcp_list =3D &pcp->lists[order_to_pindex(ac.migratetype, 0)];
> @@ -5159,8 +5144,8 @@ unsigned long alloc_pages_bulk_noprof(gfp_t gfp, in=
t preferred_nid,
>                 if (unlikely(!page)) {
>                         /* Try and allocate at least one page */
>                         if (!nr_account) {
> -                               pcp_spin_unlock(pcp);
> -                               goto failed_irq;
> +                               pcp_spin_unlock(pcp, UP_flags);
> +                               goto failed;
>                         }
>                         break;
>                 }
> @@ -5171,8 +5156,7 @@ unsigned long alloc_pages_bulk_noprof(gfp_t gfp, in=
t preferred_nid,
>                 page_array[nr_populated++] =3D page;
>         }
>
> -       pcp_spin_unlock(pcp);
> -       pcp_trylock_finish(UP_flags);
> +       pcp_spin_unlock(pcp, UP_flags);
>
>         __count_zid_vm_events(PGALLOC, zone_idx(zone), nr_account);
>         zone_statistics(zonelist_zone(ac.preferred_zoneref), zone, nr_acc=
ount);
> @@ -5180,9 +5164,6 @@ unsigned long alloc_pages_bulk_noprof(gfp_t gfp, in=
t preferred_nid,
>  out:
>         return nr_populated;
>
> -failed_irq:
> -       pcp_trylock_finish(UP_flags);
> -
>  failed:
>         page =3D __alloc_pages_noprof(gfp, 0, preferred_nid, nodemask);
>         if (page)
>
> ---
> base-commit: 550b531346a7e4e7ad31813d0d1d6a6d8c10a06f
> change-id: 20251015-b4-pcp-lock-cleanup-9b70b417a20e
>
> Best regards,
> --
> Vlastimil Babka <vbabka@suse.cz>
>

