Return-Path: <linux-kernel+bounces-863820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B608BF92EC
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 01:08:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6654F4E7154
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 23:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A30D629B20A;
	Tue, 21 Oct 2025 23:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ga0DejZF"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE7BA286D40
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 23:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761088087; cv=none; b=G6WOU3cEu3fr21Acn/Mr3+ADESfM7FT4jOWDoJk6xrc6SvPEf812rPW8ua7/c3ujJke8+RscKg4LFxO9pBSm+W0y4rjT6vEHsUf5trDYzFvnNNhm8K84q02NNeo/umqp8fxm88QHH+e+slVV8PmimHdiaFdUvueG9eFxxGjT8mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761088087; c=relaxed/simple;
	bh=3yIkC31zTPm26HmRa1gMyTn340ExM3qt76dwCqyKOPI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c4gxHGXM6a89wLUYLmooZh5pC1xxIaCCYxrWEWHUl2vqh0V9mY6MEbnctW89jqCNgQ32wc33fX1wujYdtAWv+VSQo4AGs9gGJmUKoAIsTuzT/97Tl7vQlSFW5QftGUI8NPoOJyjEp0UPjl9oBW0cmngWOL+0r68Zioa+TRWIoOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ga0DejZF; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-42706c3b7cfso2109282f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 16:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761088084; x=1761692884; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H37xO2Fy8H7/W951P5nhrd9q2BRvh9lu87ubrZUHMGY=;
        b=ga0DejZFPxKbqQJs0juok5ivMMlsgsOoeg3nahGR1X8POzCZfdGvir1MSQjs9QdRxH
         91BFjbhMXoG4rRpCurJ7FCs3L6srZurgLQBOT2ILMKKoqtnJKeBolaElbKc+w4vetRSa
         asXeVmKqsznyNclgaZeQVu4VFprnnX42KCny1aPkf6uJApEYSBk5IM2jd5QALsiB/5DU
         bphfm1VEZ3wqFxwNbjkmmwKDiqwsM0TV+mctve6O27+S8Wf5/XveApGykDZMOGvjRoid
         /IXPyGk3yjg845eXOqXYrQipP+spqWYLiCiqIVfPAU6oMGAa24top4tKn5pBPkzGfsHv
         LFJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761088084; x=1761692884;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H37xO2Fy8H7/W951P5nhrd9q2BRvh9lu87ubrZUHMGY=;
        b=OrJR7ZwkKlZCLv7pE48k5sIBFCQagltYcKmbFfdok7Rg2z+32Ml7cYlBhPhkGiq7Gw
         ddTE+Coy3cK9suNu9YZuOKLmRvlE13qqMYl4d/eVd2qWY2COTDSoKesjsOpxqTVsu+UC
         RUka9HAkg1aCDdbfRcoSEA6NGobtmZG6bDd93LgU4ETuLok6LwVpwzB6ZhCsJJpvU2HB
         CMqb0186D9YM3gFvm6RUDe9T5vqkz/ciWwqLT5zFzsn5O3QLkFRYcMXfjpIpolROvYSo
         n4uBNLZ5MxCM2Vu8oEzdjHr5fOV9vdhuAivBG7iZi7AAEFzpTyXVyVIZPK5X1R8ASyJh
         UGcw==
X-Forwarded-Encrypted: i=1; AJvYcCW0g14hU6g+otd0iFh8m+wlG2wPCjT7dtWVzuuOODVVYOQ44zwN84ZhEB9bZjoqA6QZjtV7/sDF5Dhyw7Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpENvg34l54ItFjkIO/Mg/YmHroCJUBm4foXvvg2TxRlijkSHt
	zRYFnMyfV0zEN+BCHKZX9lOJR2xdt2t4JvJbAesnMmCFB3R2teeU4JyHSmDo58pK8JqsxY0rtsB
	qaqcw00WFQfUPtKO+eY+Mf+CMLnhkI4c=
X-Gm-Gg: ASbGncuf7ZS3uX4TbL0ZI9s31MiNl7AzPSnpXF1k9KknUoCK3wAvTp0UjZS7jG5BI0u
	vzIVaCV96pJU44YNCfAzCsiA/ybhtPd7I+WHHOG7MTCCakgo85WeOsn4x9b0FmsYJOgPsoN84ay
	kck2d51NGY8U98LInd/HZOoKTdmbExvRAk3Br+KaePrAvTTHwf8dxW3037CNGEsXedGrjwFrtNK
	JysTY2jLTaGV5/n4lZ80kQRYHhhsOsGfUe8wSieb3FlNU3KdkPImMbSFkL8ze+bNQHL7Qig+TOM
	a5Ml3ZhTgu/9o1/tJXo=
X-Google-Smtp-Source: AGHT+IEWPj2I0xxnPz4/dkJe7RhQBxRU9fyNVOntXO7PLacZpfmaJiw0Rgj9CHaIbpqxxcmt9zLxveNrifPcF4PaPoQ=
X-Received: by 2002:a05:6000:22c6:b0:405:3028:1bf0 with SMTP id
 ffacd0b85a97d-42704d49805mr12349472f8f.10.1761088084218; Tue, 21 Oct 2025
 16:08:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251009155403.1379150-1-snovitoll@gmail.com> <20251009155403.1379150-3-snovitoll@gmail.com>
In-Reply-To: <20251009155403.1379150-3-snovitoll@gmail.com>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Wed, 22 Oct 2025 01:07:52 +0200
X-Gm-Features: AS18NWA2pgO8GYU1ySDNiDCWOQnFDbtDo8I_YJWXlOsSYh4kVXxVQK2mbQ2GsTM
Message-ID: <CA+fCnZeqtp2jqa7YTzDSbCkhso3dAaMGSEcmVtzU+Mrobark8w@mail.gmail.com>
Subject: Re: [PATCH 2/2] kasan: cleanup of kasan_enabled() checks
To: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
Cc: ryabinin.a.a@gmail.com, glider@google.com, dvyukov@google.com, 
	vincenzo.frascino@arm.com, akpm@linux-foundation.org, bhe@redhat.com, 
	christophe.leroy@csgroup.eu, ritesh.list@gmail.com, 
	kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 9, 2025 at 5:54=E2=80=AFPM Sabyrzhan Tasbolatov <snovitoll@gmai=
l.com> wrote:
>
> Deduplication of kasan_enabled() checks which are already used by callers=
.
>
> * Altered functions:
>
> check_page_allocation
>         Delete the check because callers have it already in __wrappers in
>         include/linux/kasan.h:
>                 __kasan_kfree_large
>                 __kasan_mempool_poison_pages
>                 __kasan_mempool_poison_object
>
> kasan_populate_vmalloc, kasan_release_vmalloc
>         Add __wrappers in include/linux/kasan.h.
>         They are called externally in mm/vmalloc.c.
>
> __kasan_unpoison_vmalloc, __kasan_poison_vmalloc
>         Delete checks because there're already kasan_enabled() checks
>         in respective __wrappers in include/linux/kasan.h.
>
> release_free_meta -- Delete the check because the higher caller path
>         has it already. See the stack trace:
>
>         __kasan_slab_free -- has the check already
>         __kasan_mempool_poison_object -- has the check already
>                 poison_slab_object
>                         kasan_save_free_info
>                                 release_free_meta
>                                         kasan_enabled() -- Delete here
>
> Signed-off-by: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
> ---
>  include/linux/kasan.h | 20 ++++++++++++++++++--
>  mm/kasan/common.c     |  3 ---
>  mm/kasan/generic.c    |  3 ---
>  mm/kasan/shadow.c     | 20 ++++----------------
>  4 files changed, 22 insertions(+), 24 deletions(-)
>
> diff --git a/include/linux/kasan.h b/include/linux/kasan.h
> index d12e1a5f5a9..f335c1d7b61 100644
> --- a/include/linux/kasan.h
> +++ b/include/linux/kasan.h
> @@ -571,11 +571,27 @@ static inline void kasan_init_hw_tags(void) { }
>  #if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
>
>  void kasan_populate_early_vm_area_shadow(void *start, unsigned long size=
);
> -int kasan_populate_vmalloc(unsigned long addr, unsigned long size, gfp_t=
 gfp_mask);
> -void kasan_release_vmalloc(unsigned long start, unsigned long end,
> +int __kasan_populate_vmalloc(unsigned long addr, unsigned long size, gfp=
_t gfp_mask);
> +static inline int kasan_populate_vmalloc(unsigned long addr,
> +                                        unsigned long size, gfp_t gfp_ma=
sk)
> +{
> +       if (kasan_enabled())
> +               return __kasan_populate_vmalloc(addr, size, gfp_mask);
> +       return 0;
> +}
> +void __kasan_release_vmalloc(unsigned long start, unsigned long end,
>                            unsigned long free_region_start,
>                            unsigned long free_region_end,
>                            unsigned long flags);
> +static inline void kasan_release_vmalloc(unsigned long start, unsigned l=
ong end,
> +                          unsigned long free_region_start,
> +                          unsigned long free_region_end,
> +                          unsigned long flags)
> +{
> +       if (kasan_enabled())
> +               return __kasan_release_vmalloc(start, end, free_region_st=
art,
> +                                        free_region_end, flags);
> +}
>
>  #else /* CONFIG_KASAN_GENERIC || CONFIG_KASAN_SW_TAGS */
>
> diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> index d4c14359fea..22e5d67ff06 100644
> --- a/mm/kasan/common.c
> +++ b/mm/kasan/common.c
> @@ -305,9 +305,6 @@ bool __kasan_slab_free(struct kmem_cache *cache, void=
 *object, bool init,
>
>  static inline bool check_page_allocation(void *ptr, unsigned long ip)
>  {
> -       if (!kasan_enabled())
> -               return false;
> -
>         if (ptr !=3D page_address(virt_to_head_page(ptr))) {
>                 kasan_report_invalid_free(ptr, ip, KASAN_REPORT_INVALID_F=
REE);
>                 return true;
> diff --git a/mm/kasan/generic.c b/mm/kasan/generic.c
> index 516b49accc4..2b8e73f5f6a 100644
> --- a/mm/kasan/generic.c
> +++ b/mm/kasan/generic.c
> @@ -506,9 +506,6 @@ static void release_alloc_meta(struct kasan_alloc_met=
a *meta)
>
>  static void release_free_meta(const void *object, struct kasan_free_meta=
 *meta)
>  {
> -       if (!kasan_enabled())
> -               return;
> -
>         /* Check if free meta is valid. */
>         if (*(u8 *)kasan_mem_to_shadow(object) !=3D KASAN_SLAB_FREE_META)
>                 return;
> diff --git a/mm/kasan/shadow.c b/mm/kasan/shadow.c
> index 5d2a876035d..cf842b620a2 100644
> --- a/mm/kasan/shadow.c
> +++ b/mm/kasan/shadow.c
> @@ -354,7 +354,7 @@ static int ___alloc_pages_bulk(struct page **pages, i=
nt nr_pages, gfp_t gfp_mask
>         return 0;
>  }
>
> -static int __kasan_populate_vmalloc(unsigned long start, unsigned long e=
nd, gfp_t gfp_mask)
> +static int __kasan_populate_vmalloc_do(unsigned long start, unsigned lon=
g end, gfp_t gfp_mask)
>  {
>         unsigned long nr_pages, nr_total =3D PFN_UP(end - start);
>         struct vmalloc_populate_data data;
> @@ -403,14 +403,11 @@ static int __kasan_populate_vmalloc(unsigned long s=
tart, unsigned long end, gfp_
>         return ret;
>  }
>
> -int kasan_populate_vmalloc(unsigned long addr, unsigned long size, gfp_t=
 gfp_mask)
> +int __kasan_populate_vmalloc(unsigned long addr, unsigned long size, gfp=
_t gfp_mask)
>  {
>         unsigned long shadow_start, shadow_end;
>         int ret;
>
> -       if (!kasan_enabled())
> -               return 0;
> -
>         if (!is_vmalloc_or_module_addr((void *)addr))
>                 return 0;
>
> @@ -432,7 +429,7 @@ int kasan_populate_vmalloc(unsigned long addr, unsign=
ed long size, gfp_t gfp_mas
>         shadow_start =3D PAGE_ALIGN_DOWN(shadow_start);
>         shadow_end =3D PAGE_ALIGN(shadow_end);
>
> -       ret =3D __kasan_populate_vmalloc(shadow_start, shadow_end, gfp_ma=
sk);
> +       ret =3D __kasan_populate_vmalloc_do(shadow_start, shadow_end, gfp=
_mask);
>         if (ret)
>                 return ret;
>
> @@ -574,7 +571,7 @@ static int kasan_depopulate_vmalloc_pte(pte_t *ptep, =
unsigned long addr,
>   * pages entirely covered by the free region, we will not run in to any
>   * trouble - any simultaneous allocations will be for disjoint regions.
>   */
> -void kasan_release_vmalloc(unsigned long start, unsigned long end,
> +void __kasan_release_vmalloc(unsigned long start, unsigned long end,
>                            unsigned long free_region_start,
>                            unsigned long free_region_end,
>                            unsigned long flags)
> @@ -583,9 +580,6 @@ void kasan_release_vmalloc(unsigned long start, unsig=
ned long end,
>         unsigned long region_start, region_end;
>         unsigned long size;
>
> -       if (!kasan_enabled())
> -               return;
> -
>         region_start =3D ALIGN(start, KASAN_MEMORY_PER_SHADOW_PAGE);
>         region_end =3D ALIGN_DOWN(end, KASAN_MEMORY_PER_SHADOW_PAGE);
>
> @@ -634,9 +628,6 @@ void *__kasan_unpoison_vmalloc(const void *start, uns=
igned long size,
>          * with setting memory tags, so the KASAN_VMALLOC_INIT flag is ig=
nored.
>          */
>
> -       if (!kasan_enabled())
> -               return (void *)start;
> -
>         if (!is_vmalloc_or_module_addr(start))
>                 return (void *)start;
>
> @@ -659,9 +650,6 @@ void *__kasan_unpoison_vmalloc(const void *start, uns=
igned long size,
>   */
>  void __kasan_poison_vmalloc(const void *start, unsigned long size)
>  {
> -       if (!kasan_enabled())
> -               return;
> -
>         if (!is_vmalloc_or_module_addr(start))
>                 return;
>
> --
> 2.34.1
>

Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>

Awesome, thank you!

I believe the check in kasan_byte_accessible() can be just removed as
well? If you do, please run the tests to be sure.

As for the other three (check_inline_region(), kasan_poison(), and
kasan_poison_last_granule()) - perhaps, we can leave them be.
Otherwise, we would need to duplicate the kasan_enabled() checks in a
lot of compiler-inserted functions.

