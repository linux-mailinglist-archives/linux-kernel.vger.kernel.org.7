Return-Path: <linux-kernel+bounces-804074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 85EC3B46984
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 08:40:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEECF1C82EE0
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 06:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EE50283CB8;
	Sat,  6 Sep 2025 06:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Bxi/VCTY"
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B5121ABD5
	for <linux-kernel@vger.kernel.org>; Sat,  6 Sep 2025 06:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757140811; cv=none; b=t63VPNmLn1EfbvCnFo40C/JfrJczMMb6n8xsGdwMpiB4F2lOR+nAsNaeVEn9rJA+iJXRbnprMV/8JGGKhrEUOodANpojZhRH8ROPLN9DV6M93p8L6Tq5VKW8M8Ib8jSnHttC1jkhcwevEKrWqqhjce5NJaqj6qqIJPvknWWuv78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757140811; c=relaxed/simple;
	bh=xvo9wb039CsH5GAvrv7vMuxVsf8fz3V34BXkTbcPYEQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uKkM6Hke1uduEFUqqPUY7c9IDfThFihf26K2oDVgclO1nP6dMiiumJoEbuHkxrv00kIiLUD5Fu0XOkYrKX9KgarSouFXaX6/WPJHrJ6QnmWyGq8rMSSjCaKJqgKH1L+tdgtj/BLgOOKyxQNPuuvuN0Fj/VI9S8VVf/Pf1E/usbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Bxi/VCTY; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Gm-Message-State: AOJu0YzLVXv35kXFIUiRktvaeSI64X1MYhY6BlsVNOBm1MkSVgGbnerA
	7ZTXfI5N0wEpmEEEz7LKy+hyeNdArFAhqxXJiEi3463dWLQb0+bnIBRhxilzFyoc3lOr9rtBzbu
	g57nCpDSSYjQp7kk7Mrq9UGzIvCQEzP4=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757140807;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gqIvGeRaxAz05kA2S50rycLnEg9Gm/547IL4mmKsRZg=;
	b=Bxi/VCTYLOQGaX8mBIDtwhE+XdELnm/meYbeU5EXG1z8Ftesgo5nfbafGxgpZpf1qUR5yF
	JMupPdIFNdxL31g2/OCbI63wGkOUjt21mFQyFvq/5ySg9nSzbZs2JbIcOT7yCa3iO2pvh6
	WcEf/XZzFADhUOAM3B/6x7bU18Yq4co=
X-Google-Smtp-Source: AGHT+IH8BlxPCXehT53D8cOwU9O0/ODblCgSZL9wMB8fWtgq2u1xvZZjoe9oV/6yUXkduX62o+onvNt2qPaa49Vvms8=
X-Received: by 2002:a05:6214:1948:b0:716:fdea:db16 with SMTP id
 6a1803df08f44-72bbf3fb1eamr69690796d6.12.1757140804761; Fri, 05 Sep 2025
 23:40:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250905141137.3529867-1-david@redhat.com>
In-Reply-To: <20250905141137.3529867-1-david@redhat.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
Date: Sat, 6 Sep 2025 14:39:26 +0800
X-Gmail-Original-Message-ID: <CABzRoyYutoeA-OX_Y99pYy6cYxb0iYXpWK8Js5jn_Xp2JYyaDg@mail.gmail.com>
X-Gm-Features: Ac12FXxJgS1tMi1cNEiT_Y8dnTFoVxumeja2536-J7u_yM_UU8Y0HYuyc3aPuek
Message-ID: <CABzRoyYutoeA-OX_Y99pYy6cYxb0iYXpWK8Js5jn_Xp2JYyaDg@mail.gmail.com>
Subject: Re: [PATCH v1] mm/huge_memory: fix shrinking of all-zero THPs with
 max_ptes_none default
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
	Usama Arif <usamaarif642@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Migadu-Flow: FLOW_OUT

On Fri, Sep 5, 2025 at 10:14=E2=80=AFPM David Hildenbrand <david@redhat.com=
> wrote:
>
> We added an early exit in thp_underused(), probably to avoid scanning
> pages when there is no chance for success.
>
> However, assume we have max_ptes_none =3D 511 (default).
>
> Nothing should stop us from freeing all pages part of a THP that
> is completely zero (512) and khugepaged will for sure not try to
> instantiate a THP in that case (512 shared zeropages).
>
> This can just trivially happen if someone writes a single 0 byte into a
> PMD area, or of course, when data ends up being zero later.
>
> So let's remove that early exit.
>
> Do we want to CC stable? Hm, not sure. Probably not urgent.
>
> Note that, as default, the THP shrinker is active
> (/sys/kernel/mm/transparent_hugepage/shrink_underused =3D 1), and all
> THPs are added to the deferred split lists. However, with the
> max_ptes_none default we would never scan them. We would not do that. If
> that's not desirable, we should just disable the shrinker as default,
> also not adding all THPs to the deferred split lists.
>
> Easy to reproduce:
>
> 1) Allocate some THPs filled with 0s
>
> <prog.c>
>  #include <string.h>
>  #include <stdio.h>
>  #include <stdlib.h>
>  #include <unistd.h>
>  #include <sys/mman.h>
>
>  const size_t size =3D 1024*1024*1024;
>
>  int main(void)
>  {
>          size_t offs;
>          char *area;
>
>          area =3D mmap(0, size, PROT_READ | PROT_WRITE,
>                      MAP_ANON | MAP_PRIVATE, -1, 0);
>          if (area =3D=3D MAP_FAILED) {
>                  printf("mmap failed\n");
>                  exit(-1);
>          }
>          madvise(area, size, MADV_HUGEPAGE);
>
>          for (offs =3D 0; offs < size; offs +=3D getpagesize())
>                  area[offs] =3D 0;
>          pause();
>  }
> <\prog.c>
>
> 2) Trigger the shrinker
>
> E.g., memory pressure through memhog
>
> 3) Observe that THPs are not getting reclaimed
>
> $ cat /proc/`pgrep prog`/smaps_rollup
>
> Would list ~1GiB of AnonHugePages. With this fix, they would get
> reclaimed as expected.
>
> Fixes: dafff3f4c850 ("mm: split underused THPs")
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Cc: Zi Yan <ziy@nvidia.com>
> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
> Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>
> Cc: Nico Pache <npache@redhat.com>
> Cc: Ryan Roberts <ryan.roberts@arm.com>
> Cc: Dev Jain <dev.jain@arm.com>
> Cc: Barry Song <baohua@kernel.org>
> Cc: Usama Arif <usamaarif642@gmail.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Good catch! Feel free to add:
Reviewed-by: Lance Yang <lance.yang@linux.dev>

Cheers,
Lance

> ---
>  mm/huge_memory.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 26cedfcd74189..aa3ed7a86435b 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -4110,9 +4110,6 @@ static bool thp_underused(struct folio *folio)
>         void *kaddr;
>         int i;
>
> -       if (khugepaged_max_ptes_none =3D=3D HPAGE_PMD_NR - 1)
> -               return false;
> -
>         for (i =3D 0; i < folio_nr_pages(folio); i++) {
>                 kaddr =3D kmap_local_folio(folio, i * PAGE_SIZE);
>                 if (!memchr_inv(kaddr, 0, PAGE_SIZE)) {
> --
> 2.50.1
>
>

