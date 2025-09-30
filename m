Return-Path: <linux-kernel+bounces-837786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 536C8BAD2E7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 16:31:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DE1B32211A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 14:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 711DC284896;
	Tue, 30 Sep 2025 14:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FrrW8Yy/"
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EEB3241673
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 14:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759242674; cv=none; b=V/YUXrlV1lDhvwnaeVc05DRpemfcLTYg9p5dAHSU+tLuzlz8stjT+wuS9769HJ6+GCf2XYr3hxkDyRJD36mReNOHMvPlt4tPy73tcoSEmuaRRGVOTyyJMO1v/MJln6vjpILb6+VpLKVPT2VUvIgVv2H4ZDbW00JvTcHw05PaWks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759242674; c=relaxed/simple;
	bh=tk8QX20vhVgvhFs5c1ShZSPdYu5PmDbETEFmQGs7ASg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fUVkNKBYd6M1bL/G9C9vOoQO4KhsTDugC2cHqkQWKhPYBiXxgAY1s0eLzosUDRWYi0Jnk9pv675Ya3FLjLi9u06Czz8gkCYFbzYioNqMPDyIA9zLmzCSskr6cHdQM5l+cUg3MWV+PYfAJVKJJPOIG6AJkp8XG2ebAqlphlH1Gt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FrrW8Yy/; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Forwarded-Encrypted: i=1; AJvYcCW/pOvylhx2g8ncYuY98mhVmD+vUxALk8Pv7nDULLfPlpANDJqp5zpfLHWjoVgHGMmlldjAkm38+ZzS4ME=@vger.kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1759242669;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/P8UbV87J09tZL1h3UzmxkojtiXGLQJFOupY2v35F54=;
	b=FrrW8Yy/jvWuFW+ZwbYYTb/jryMyxSHmmi5pw1ciKqlFdltE3Qn7BWWGujyKamjs70z/Hw
	m70FFTqGOUFjLvT+wxdFi4Sh19MiTfw3fbsaTLgM4gM0ErypldyLIYiA/y6SLMXnZ7D2ac
	6qK+WpX4xmHwKDOQWyIYrE+JAICcluA=
X-Gm-Message-State: AOJu0YwkDUkBssODWPWTlcQCwWpTidDBw0sTtePOAWEYVr7DrsC99yU2
	btvS/hQCjD8q1XN2qq47tY/O19OXooElz0c/9cO3Yi37p81Awu9298fXnHKYlmA4jQGZqQcsYHj
	6Gy4OpbZavIIr3u9BcnE08Ihfabe6nuQ=
X-Google-Smtp-Source: AGHT+IFVSPZu6yh0Q16pHzVeahA0zVDamjBYekfddJu+S0nvsCyAm84127hmtyw+5HLmrZLl1Fidbc3JRjFYvkTCfPo=
X-Received: by 2002:ad4:5c65:0:b0:746:4ca1:fbc with SMTP id
 6a1803df08f44-7fc2fd7343amr298313466d6.23.1759242666456; Tue, 30 Sep 2025
 07:31:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250930025246.1143340-1-anshuman.khandual@arm.com>
In-Reply-To: <20250930025246.1143340-1-anshuman.khandual@arm.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
Date: Tue, 30 Sep 2025 22:30:28 +0800
X-Gmail-Original-Message-ID: <CABzRoyYvdeX562ob6tf50O8gRoMKPp9-62FR5mcjTUNyGZSoTQ@mail.gmail.com>
X-Gm-Features: AS18NWDSRA9_SfA-4xAgCAAwq9ckBLFuJLAQkfHgnyzZ7OPW9t0Fkeu1DptjuSI
Message-ID: <CABzRoyYvdeX562ob6tf50O8gRoMKPp9-62FR5mcjTUNyGZSoTQ@mail.gmail.com>
Subject: Re: [PATCH] mm/ptdump: Replace READ_ONCE() with standard page table accessors
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Migadu-Flow: FLOW_OUT

On Tue, Sep 30, 2025 at 10:56=E2=80=AFAM Anshuman Khandual
<anshuman.khandual@arm.com> wrote:
>
> Replace READ_ONCE() with standard page table accessors i.e pxdp_get() whi=
ch
> anyways default into READ_ONCE() in cases where platform does not overrid=
e.
>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---

Nice cleanup! I assume it's a no-op change on all architectures for now ;)
Acked-by: Lance Yang <lance.yang@linux.dev>

>  mm/ptdump.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/mm/ptdump.c b/mm/ptdump.c
> index b600c7f864b8..18861501b533 100644
> --- a/mm/ptdump.c
> +++ b/mm/ptdump.c
> @@ -31,7 +31,7 @@ static int ptdump_pgd_entry(pgd_t *pgd, unsigned long a=
ddr,
>                             unsigned long next, struct mm_walk *walk)
>  {
>         struct ptdump_state *st =3D walk->private;
> -       pgd_t val =3D READ_ONCE(*pgd);
> +       pgd_t val =3D pgdp_get(pgd);
>
>  #if CONFIG_PGTABLE_LEVELS > 4 && \
>                 (defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW=
_TAGS))
> @@ -54,7 +54,7 @@ static int ptdump_p4d_entry(p4d_t *p4d, unsigned long a=
ddr,
>                             unsigned long next, struct mm_walk *walk)
>  {
>         struct ptdump_state *st =3D walk->private;
> -       p4d_t val =3D READ_ONCE(*p4d);
> +       p4d_t val =3D p4dp_get(p4d);
>
>  #if CONFIG_PGTABLE_LEVELS > 3 && \
>                 (defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW=
_TAGS))
> @@ -77,7 +77,7 @@ static int ptdump_pud_entry(pud_t *pud, unsigned long a=
ddr,
>                             unsigned long next, struct mm_walk *walk)
>  {
>         struct ptdump_state *st =3D walk->private;
> -       pud_t val =3D READ_ONCE(*pud);
> +       pud_t val =3D pudp_get(pud);
>
>  #if CONFIG_PGTABLE_LEVELS > 2 && \
>                 (defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW=
_TAGS))
> @@ -100,7 +100,7 @@ static int ptdump_pmd_entry(pmd_t *pmd, unsigned long=
 addr,
>                             unsigned long next, struct mm_walk *walk)
>  {
>         struct ptdump_state *st =3D walk->private;
> -       pmd_t val =3D READ_ONCE(*pmd);
> +       pmd_t val =3D pmdp_get(pmd);
>
>  #if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
>         if (pmd_page(val) =3D=3D virt_to_page(lm_alias(kasan_early_shadow=
_pte)))
> --
> 2.30.2
>
>

